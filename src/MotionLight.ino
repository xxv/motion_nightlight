#include <FastLED.h>
#include <Button.h>
#include "apa102_dim.h"

#define PIN_A0  0
#define PIN_A1  1
#define PIN_A2  2
#define PIN_A3  3
#define PIN_A4  4
#define PIN_A5  5
#define PIN_A6  6
#define PIN_A7  7
#define PIN_B0 10
#define PIN_B1  9
#define PIN_B2  8

const static uint8_t BRIGHTNESS_LEVELS[] = { 16, 32, 64, 128, 255 };

struct LightColors {
  long rgb;
  long white;
};

struct LightColors PALETTES[] = {
  { 0xFFBF00, 0x000000 }, // amber
  { 0x000000, 0xFF0000 }, // white
  { 0xFF0000, 0xFF0000 }, // white with red
  { 0xA0A0FF, 0x000000 }, // moonlight
  { 0xFF0000, 0x000000 }, // red
  { 0xFFFF00, 0x000000 }, // yellow
  { 0x00FF00, 0x000000 }, // green
  { 0x00FFFF, 0x000000 }, // teal
  { 0x0000FF, 0x000000 }, // blue
  { 0xFF00FF, 0x000000 }, // purple
};

// the number of milliseconds to delay the main animation loop
const static int DIM_TIME       = 100;

const static int PIN_MOTION     = PIN_A0;
const static int PIN_AMBIENT    = PIN_A1;
const static int PIN_STATUS_LED = PIN_A2;
const static int PIN_BUTTON_1   = PIN_B2;
const static int PIN_BUTTON_2   = PIN_B1;

const static int NUM_LEDS       = 2;
const static int RGB_LED        = 0;
const static int WHITE_LED      = 1;

const static long TIMEOUT_MS         = 10000;
const static long SETTING_TIMEOUT_MS = 5000;
const static long LONG_PRESS_MS      = 1000;

// transient state
long on_time = 0;
CRGB leds[NUM_LEDS];

int fade_value = 0;
bool motion = false;
bool light_on = false;
bool goingToSleep = false;
bool update_color = true;


uint8_t brightness_idx = 0;
uint8_t palette_idx = 0;

enum Mode { sleeping, running, setting };

Mode mode = sleeping;

APA102Controller_WithBrightness<PIN_A6, PIN_A4, BGR>ledController;

Button button1(PIN_BUTTON_1, true, true, 20);
Button button2(PIN_BUTTON_2, true, true, 20);

void cycle_brightness_level() {
  brightness_idx = (brightness_idx + 1) %
      (sizeof(BRIGHTNESS_LEVELS)/sizeof(BRIGHTNESS_LEVELS[0]));
  update_color = true;
}

void cycle_palette() {
  palette_idx = (palette_idx + 1) %
      (sizeof(PALETTES)/sizeof(PALETTES[0]));
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
  digitalWrite(PIN_STATUS_LED, LOW);
}

void setup() {
  pinMode(PIN_MOTION, INPUT);
  pinMode(PIN_STATUS_LED, OUTPUT);
  FastLED.addLeds((CLEDController*) &ledController, leds, NUM_LEDS);

  led_test();
  digitalWrite(PIN_STATUS_LED, LOW);
}

void setMode(Mode newMode) {
  mode = newMode;

  switch (mode) {
    case sleeping:
    case running:
      digitalWrite(PIN_STATUS_LED, LOW);
      break;
    case setting:
      digitalWrite(PIN_STATUS_LED, HIGH);
      break;
  }
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
    brightness_idx = 0;
    update_color = true;
    buttonPressed = true;
  } else if (button2.pressedFor(LONG_PRESS_MS)) {
    palette_idx = 0;
    update_color = true;
    buttonPressed = true;
  }

  if (buttonPressed) {
    motion = true;
    on_time = millis();
  }

  if ((millis() - on_time) > SETTING_TIMEOUT_MS) {
    setMode(running);
  }
}

void handleRunningMode() {
  if (button1.pressedFor(LONG_PRESS_MS) && button2.pressedFor(LONG_PRESS_MS)) {
    led_test();
  } else if (button1.wasPressed() || button2.wasPressed()) {
    motion = true;
    fade_value = APA102_MAXIMUM_BRIGHTNESS;
    setMode(setting);
  }

  if (motion) {
    on_time = millis();

    if (!light_on) {
      update_color = true;
    }

    light_on = true;
  }

  if (!motion && light_on && (millis() - on_time) > TIMEOUT_MS) {
    light_on = false;
  }
}

void redrawLights() {
  if (update_color) {
    leds[RGB_LED] = PALETTES[palette_idx].rgb;
    leds[WHITE_LED] = PALETTES[palette_idx].white;

    leds[RGB_LED].nscale8_video(BRIGHTNESS_LEVELS[brightness_idx]);
    leds[WHITE_LED].nscale8_video(BRIGHTNESS_LEVELS[brightness_idx]);
    update_color = false;
  }

  ledController.setAPA102Brightness(fade_value);

  FastLED.show();
}

void loop() {
  button1.read();
  button2.read();

  motion = digitalRead(PIN_MOTION);

  switch (mode) {
    case sleeping:
      if (motion) {
        setMode(running);
      }
    // fall through
    case running:
      handleRunningMode();
      break;
    case setting:
      handleSettingMode();
      break;
  }

  //digitalWrite(PIN_STATUS_LED, motion);

  redrawLights();

  if (mode == running) {
    if (!light_on && fade_value == 1) {
      goingToSleep = true;
    }

    EVERY_N_MILLIS(16) {
      fade_value += light_on ? 2 : -1;
    }

    if (fade_value < 0) {
      fade_value = 0;
    } else if (fade_value > APA102_MAXIMUM_BRIGHTNESS) {
      fade_value = APA102_MAXIMUM_BRIGHTNESS;
    }

    if (goingToSleep) {
      goingToSleep = false;
      setMode(sleeping);
    }
  }

  delay(DIM_TIME);
}
