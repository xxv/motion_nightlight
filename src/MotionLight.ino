#include <FastLED.h>
#include "apa102_dim.h"

#define DIM_TIME       3000
#define MAX_BRIGHTNESS 31
#define NUM_LEDS       1
#define PIN_MOTION     5

CRGB leds[NUM_LEDS];

int brightness = 0;

APA102Controller_WithBrightness <MOSI, SPI_CLOCK, BGR>ledController;

void setup() {
  pinMode(PIN_MOTION, INPUT);
  FastLED.addLeds((CLEDController*) &ledController, leds, NUM_LEDS);

  for (uint8_t i = 0; i < NUM_LEDS; i++) {
    leds[i] = CRGB(20, 22, 22);
  }
}

void loop() {
  brightness += digitalRead(PIN_MOTION) ? 1 : -1;

  if (brightness < 0) {
    brightness = 0;
  }

  if (brightness > MAX_BRIGHTNESS) {
    brightness = MAX_BRIGHTNESS;
  }

  ledController.setAPA102Brightness(brightness);

  FastLED.show();

  delay(DIM_TIME/MAX_BRIGHTNESS);
}
