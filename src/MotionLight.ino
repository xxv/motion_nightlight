#include <FastLED.h>
#include <Button.h>
#include "apa102_dim.h"

const static uint8_t BRIGHTNESS_LEVELS[] = { 16, 32, 64, 128, 255 };

// the number of milliseconds to delay the main animation loop
const static int DIM_TIME       = 1;

const static int PIN_MOTION     = PIN_A0;
const static int PIN_AMBIENT    = PIN_A1;
const static int STATUS_LED     = PIN_A2;
const static int PIN_BUTTON_1   = PIN_B2;
const static int PIN_BUTTON_2   = PIN_B1;

const static int NUM_LEDS       = 2;
const static int RGB_LED        = 0;
const static int WHITE_LED      = 1;

const static long TIMEOUT       = 10000; // ms

long on_time = 0;
CRGB leds[NUM_LEDS];

CRGB color = CRGB(0, 0, 0);
CRGB white_value = CRGB(255, 0, 0);

int brightness = BRIGHTNESS_LEVELS[0];
int fade_value = 0;
int white_fade = 255;

int brightness_idx = 0;

APA102Controller_WithBrightness<6, 4, BGR>ledController;

Button button1(PIN_BUTTON_1, true, true, 20);
Button button2(PIN_BUTTON_2, true, true, 20);

void cycle_brightness_level() {
  brightness_idx = (brightness_idx + 1) %
      (sizeof(BRIGHTNESS_LEVELS)/sizeof(BRIGHTNESS_LEVELS[0]));
  brightness = BRIGHTNESS_LEVELS[brightness_idx];
}

void setup() {
  pinMode(PIN_MOTION, INPUT);
  pinMode(STATUS_LED, OUTPUT);
  FastLED.addLeds((CLEDController*) &ledController, leds, NUM_LEDS);

  // LED test
  digitalWrite(STATUS_LED, HIGH);
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
  digitalWrite(STATUS_LED, LOW);
}

bool motion = false;
bool light_on = false;
bool update_color = true;

void loop() {
  button1.read();
  button2.read();

  if (button1.wasPressed()) {
    cycle_brightness_level();
    update_color = true;
  }

  motion = digitalRead(PIN_MOTION);

  if (motion) {
    on_time = millis();

    if (!light_on) {
      update_color = true;
    }

    light_on = true;
  }

  if (!motion && light_on && (millis() - on_time) > TIMEOUT) {
    light_on = false;
  }

  if (update_color) {
    leds[RGB_LED] = color;
    leds[WHITE_LED] = white_value;

    leds[RGB_LED].nscale8_video(255 - white_fade);
    leds[WHITE_LED].nscale8_video(white_fade);

    leds[RGB_LED].nscale8_video(brightness);
    leds[WHITE_LED].nscale8_video(brightness);

    update_color = false;
  }

  ledController.setAPA102Brightness(fade_value);

  FastLED.show();

  EVERY_N_MILLIS(16) {
    fade_value += light_on ? 1 : -1;
  }

  if (fade_value < 0) {
    fade_value = 0;
  } else if (fade_value > APA102_MAXIMUM_BRIGHTNESS) {
    fade_value = APA102_MAXIMUM_BRIGHTNESS;
  }

  delay(DIM_TIME);
}
