#include <avr/power.h>
#include <avr/sleep.h>
#include <EEPROM.h>
#include <FastLED.h>
#include <JC_Button.h>
#include "apa102_dim.h"

const static bool DEBUG_ACCESSORY_POWER = false;
const static bool DEBUG_AMBIENT         = false;
const static bool DEBUG_MOTION          = false;
const static bool DEBUG_SLEEPING        = false;
const static bool DEBUG_WATCHDOG        = false;

struct LightColors {
  long rgb;
  long white;
};

struct SettingsData {
  uint8_t brightness_level_idx;
  uint8_t palette_idx;
  int ambient_level;
};

const static uint8_t BRIGHTNESS_LEVELS[] = { 2, 4, 8, 16, 31 };

const static uint8_t SETTINGS_ADDRESS = 0;

const static long COLOR_MODE_RANDOM = 0xFFFFFE;

const struct LightColors PALETTES[] = {
  { 0xFFBF00, 0x000000 }, // amber
  { 0x000000, 0x555555 }, // white
  { 0x000000, 0xAAAAAA }, // bright white
  { 0x000000, 0xFFFFFF }, // max white
  { 0xFF0000, 0x555555 }, // white with red
  { 0x0000FF, 0x555555 }, // white with blue
  { 0xA0A0FF, 0x000000 }, // moonlight
  { 0xFF0000, 0x000000 }, // red
  { 0xFFFF00, 0x000000 }, // yellow
  { 0x00FF00, 0x000000 }, // green
  { 0x00FFFF, 0x000000 }, // teal
  { 0x0000FF, 0x000000 }, // blue
  { 0xFF00FF, 0x000000 }, // purple
  { 0x000000, COLOR_MODE_RANDOM }, // show a random color, incl. white
};

const static int PIN_MOTION      = PIN_A0;
const static int PIN_AMBIENT     = A1;
const static int PIN_STATUS_LED  = PIN_A2;
const static int PIN_ACC_PWR_DIS = PIN_A3;
const static int PIN_MOT_PWR_DIS = PIN_A7;
const static int PIN_BUTTON_1    = PIN_B2;
const static int PIN_BUTTON_2    = PIN_B1;
const static int PIN_SCK         = 4;
const static int PIN_SDA         = 6;

const static int NUM_LEDS       = 2;
const static int RGB_LED        = 0;
const static int WHITE_LED      = 1;

const static uint8_t DEEP_SLEEP_TIMEOUT_COUNT = 5; // number of watchdog wakes
const static unsigned long TIMEOUT_MS         = 5000;
const static long SETTING_TIMEOUT_MS          = 5000;
const static long LONG_PRESS_MS               = 1000;

const static int AMBIENT_HYSTERESIS = 10;

// transient state
unsigned long on_time = 0;
CRGBArray<NUM_LEDS> leds;
CRGBArray<NUM_LEDS> leds_prefade;

uint8_t deep_sleep_countdown = 0;
uint8_t fade_value = 0;
uint8_t prev_fade_value = 0;
bool motion = false;
bool is_dark_enough = false;
bool light_on = false;
bool update_color = true;
bool woke_from_watchdog = false;

int ambient_darkness_level = 0;
uint8_t brightness_idx = 0;
uint8_t palette_idx = 0;

/**
 * sleeping = low power, wake via motion
 * deep_sleeping = lowest power, wake via being dark
 * running = light is fading on/off/steady on
 */
enum Mode { sleeping, deep_sleeping, running, setting };

Mode mode = running;

APA102Controller_WithBrightness<PIN_SDA, PIN_SCK, BGR>ledController;

Button button1(PIN_BUTTON_1);
Button button2(PIN_BUTTON_2);

ISR (PCINT0_vect) {
  // Don't need to do anything, just wake up.
}

ISR (PCINT1_vect) {
  // Don't need to do anything, just wake up.
}

ISR (WDT_vect) {
  MCUSR = 0x00;
  WDTCSR |= _BV(WDE) | _BV(WDCE);
  WDTCSR = 0x00; // disable watchdog

  if (DEBUG_WATCHDOG) {
    digitalWrite(PIN_STATUS_LED, HIGH);
  }

  woke_from_watchdog = true;
}

void watchdog_enable() {
  if (DEBUG_WATCHDOG) {
    digitalWrite(PIN_STATUS_LED, LOW);
  }

  bitSet(WDTCSR, WDIE);           // watchdog triggers an interrupt
  WDTCSR |= _BV(WDP0) | _BV(WDP1) | _BV(WDP2); // trigger every 2 seconds

  bitSet(WDTCSR, WDE); // enable watchdog
}

void set_motion_powered(const bool is_powered) {
  digitalWrite(PIN_MOT_PWR_DIS, !is_powered);
}

void set_accessory_powered(const bool is_powered) {
  digitalWrite(PIN_ACC_PWR_DIS, !is_powered);

  if (DEBUG_ACCESSORY_POWER) {
    digitalWrite(PIN_STATUS_LED, is_powered);
  }
}

void update_deep_sleep_monitoring() {
  if (is_dark_enough) {
    deep_sleep_countdown = 0;
  } else {
    deep_sleep_countdown++;
  }
}

bool should_deep_sleep() {
  return deep_sleep_countdown >= DEEP_SLEEP_TIMEOUT_COUNT;
}

/**
 * Enable Pin Change Interrupt on given pin number.
 */
void pciSetup(byte pin) {
  bitSet(*digitalPinToPCMSK(pin), digitalPinToPCMSKbit(pin)); // enable pin
  bitSet(*digitalPinToPCICR(pin), digitalPinToPCICRbit(pin)); // enable interrupt
}

/**
 * Enable sleep mode and turn on pin change interrupt
 */
void sleep_now(bool deep_sleep) {
  redraw_lights();

  woke_from_watchdog = false;
  watchdog_enable();

  set_accessory_powered(false);
  set_motion_powered(!deep_sleep);

  if (deep_sleep) {
    deep_sleep_countdown = 0;
  } else {
    pciSetup(PIN_MOTION);
  }

  pciSetup(PIN_BUTTON_1);
  pciSetup(PIN_BUTTON_2);

  setMode(deep_sleep ? deep_sleeping : sleeping);
  set_sleep_mode(SLEEP_MODE_PWR_DOWN);
  sleep_enable();

  if (DEBUG_SLEEPING) {
    digitalWrite(PIN_STATUS_LED, LOW);
  }

  bitClear(ADCSRA, ADEN); // disable ADC

  // -.- zzz...
  sleep_mode();

  // !! O.O
  sleep_disable();

  bitSet(ADCSRA, ADEN); // re-enable ADC

  if (DEBUG_SLEEPING) {
    digitalWrite(PIN_STATUS_LED, HIGH);
  }

  disable_pc_interrupts();
  interrupts();
}

void disable_pc_interrupts(byte pin) {
  bitClear(*digitalPinToPCICR(pin), digitalPinToPCICRbit(pin));
}

void disable_pc_interrupts() {
  disable_pc_interrupts(PIN_MOTION);
  disable_pc_interrupts(PIN_BUTTON_1);
  disable_pc_interrupts(PIN_BUTTON_2);
}

void load_settings() {
  SettingsData data;
  EEPROM.get(SETTINGS_ADDRESS, data);

  set_brightness_level(data.brightness_level_idx);
  set_palette(data.palette_idx);
  ambient_darkness_level = data.ambient_level;
}

void save_settings() {
  SettingsData data = {
    brightness_idx,
    palette_idx,
    ambient_darkness_level
  };

  EEPROM.put(SETTINGS_ADDRESS, data);
}

void cycle_brightness_level() {
  set_brightness_level(brightness_idx + 1);
}

void set_brightness_level(uint8_t index) {
  brightness_idx = index %
      (sizeof(BRIGHTNESS_LEVELS)/sizeof(BRIGHTNESS_LEVELS[0]));

  ledController.setAPA102Brightness(BRIGHTNESS_LEVELS[brightness_idx]);
}

void cycle_palette() {
  set_palette(palette_idx + 1);
}

void set_palette(uint8_t index) {
  palette_idx = index % (sizeof(PALETTES)/sizeof(PALETTES[0]));
  set_leds_prefade();
}

void set_leds_prefade() {
  if (PALETTES[palette_idx].white == COLOR_MODE_RANDOM) {
    if (random8(15) == 0) {
      leds_prefade[RGB_LED] = 0x000000;
      leds_prefade[WHITE_LED] = 0x555555;
    } else {
      leds_prefade[RGB_LED] = CHSV(random8(), 255, 255);
      leds_prefade[WHITE_LED] = 0x000000;
    }
  } else {
    leds_prefade[RGB_LED] = PALETTES[palette_idx].rgb;
    leds_prefade[WHITE_LED] = PALETTES[palette_idx].white;
  }

  update_color = true;
}

void led_test() {
  digitalWrite(PIN_STATUS_LED, HIGH);
  leds[WHITE_LED] = CRGB(0, 0, 0);
  leds[RGB_LED] = CRGB(20, 0, 0);
  FastLED.show();
  delay(500);
  leds[RGB_LED] = CRGB(0, 20, 0);
  FastLED.show();
  delay(500);
  leds[RGB_LED] = CRGB(0, 0, 20);
  FastLED.show();
  delay(500);
  leds[RGB_LED] = CRGB(0, 0, 0);
  leds[WHITE_LED] = CRGB(20, 0, 0);
  FastLED.show();
  delay(500);
  leds[RGB_LED] = CRGB(0, 0, 0);
  leds[WHITE_LED] = CRGB(0, 0, 0);
  FastLED.show();
  digitalWrite(PIN_STATUS_LED, LOW);
}

int analogReadAverage(uint8_t pin, uint8_t count) {
  int sum = 0;

  for (uint8_t i = 0; i < count; i++) {
    sum += analogRead(pin);
  }

  return sum / count;
}

void setup() {
  button1.begin();
  button2.begin();
  pinMode(PIN_MOTION, INPUT);
  pinMode(PIN_AMBIENT, INPUT);
  pinMode(PIN_STATUS_LED, OUTPUT);
  pinMode(PIN_ACC_PWR_DIS, OUTPUT);
  pinMode(PIN_MOT_PWR_DIS, OUTPUT);
  FastLED.addLeds((CLEDController*) &ledController, leds, NUM_LEDS);

  set_accessory_powered(true);
  set_motion_powered(true);
  led_test();

  load_settings();

  if (button1.isPressed() && button2.isPressed()) {
    // a delay to ensure there is no light from the white LED
    delay(100);
    ambient_darkness_level = analogReadAverage(PIN_AMBIENT, 10);
    save_settings();

    digitalWrite(PIN_STATUS_LED, LOW);
    delay(250);
    digitalWrite(PIN_STATUS_LED, HIGH);
    delay(250);
    digitalWrite(PIN_STATUS_LED, LOW);
    delay(250);
    digitalWrite(PIN_STATUS_LED, HIGH);
    delay(250);
    digitalWrite(PIN_STATUS_LED, LOW);
    delay(250);
    digitalWrite(PIN_STATUS_LED, HIGH);
    delay(250);
  }

  digitalWrite(PIN_STATUS_LED, LOW);
}

void handleSettingMode() {
  bool buttonPressed = false;

  if (button1.wasPressed()) {
    cycle_brightness_level();
    buttonPressed = true;
  } else if (button2.wasPressed()) {
    cycle_palette();
    buttonPressed = true;
  } else if (button1.pressedFor(LONG_PRESS_MS)) {
    set_brightness_level(0);
    buttonPressed = true;
  } else if (button2.pressedFor(LONG_PRESS_MS)) {
    set_palette(0);
    buttonPressed = true;
  }

  // animate the palette to indicate random mode
  if (PALETTES[palette_idx].white == COLOR_MODE_RANDOM) {
    EVERY_N_MILLIS(333) {
      set_leds_prefade();
    }
  }

  if (buttonPressed) {
    light_on = true;
    on_time = millis();
  }

  if ((millis() - on_time) > SETTING_TIMEOUT_MS) {
    save_settings();
    setMode(running);
  }
}

void check_buttons() {
  if (button1.pressedFor(LONG_PRESS_MS) && button2.pressedFor(LONG_PRESS_MS)) {
    led_test();
  } else if (button1.wasPressed() || button2.wasPressed()) {
    motion = true;
    fade_value = 255;
    update_color = true;
    setMode(setting);
  }
}

void handleRunningMode() {
  if (motion) {
    on_time = millis();

    if (!light_on) {
      set_leds_prefade();
    }

    light_on = true;
  }

  if (!motion && light_on && (millis() - on_time) > TIMEOUT_MS) {
    light_on = false;
  }
}

void redraw_lights() {
  if (update_color) {
    leds = leds_prefade;

    leds[RGB_LED].nscale8_video(fade_value);
    leds[WHITE_LED].nscale8_video(fade_value);

    update_color = false;
  }

  FastLED.show();
}

void update_ambient_level() {
  if (is_dark_enough) {
    is_dark_enough = analogRead(PIN_AMBIENT) <=
                     (ambient_darkness_level + AMBIENT_HYSTERESIS);
  } else {
    is_dark_enough = analogRead(PIN_AMBIENT) <=
                     (ambient_darkness_level - AMBIENT_HYSTERESIS);
  }
}

void manage_power() {
  if (mode == running) {
    if (!light_on && fade_value == 0) {
      sleep_now(false);
    }
  } else if (mode == deep_sleeping) {
    sleep_now(!is_dark_enough);
  } else if (mode == sleeping) {
    sleep_now(should_deep_sleep());
  }
}

void setMode(Mode newMode) {
  if (mode != newMode) {
    switch (newMode) {
      case deep_sleeping:
        // fall through
      case sleeping:
        // fall through
      case running:
        if (mode == setting) {
          digitalWrite(PIN_STATUS_LED, LOW);
        }
        set_motion_powered(true);
        break;
      case setting:
        digitalWrite(PIN_STATUS_LED, HIGH);
        break;
    }
    mode = newMode;
  }
}

void loop() {
  EVERY_N_MILLIS(10) {
    button1.read();
    button2.read();

    set_accessory_powered(true);
    motion = digitalRead(PIN_MOTION);
    update_ambient_level();

    switch (mode) {
      case sleeping:
        if (woke_from_watchdog) {
          update_deep_sleep_monitoring();
        }
        // fall through
      case deep_sleeping:
        if (motion && is_dark_enough) {
          setMode(running);
          handleRunningMode();
        }
        check_buttons();
        break;
      case running:
        check_buttons();
        handleRunningMode();
        break;
      case setting:
        handleSettingMode();
        break;
    }
  }

  if (DEBUG_AMBIENT) {
    digitalWrite(PIN_STATUS_LED, is_dark_enough);
  }

  if (DEBUG_MOTION) {
    digitalWrite(PIN_STATUS_LED, motion);
  }

  EVERY_N_MILLIS(2) {
    prev_fade_value = fade_value;

    if (light_on) {
      fade_value = qadd8(fade_value, 2);
    } else {
      fade_value = qsub8(fade_value, 1);
    }

    if (prev_fade_value != fade_value) {
      update_color = true;
    }
  }

  redraw_lights();

  manage_power();

  delay(1);
}
