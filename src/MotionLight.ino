#include <FastLED.h>

#define COLOR          135
#define DIM_TIME       3000
#define MAX_BRIGHTNESS 20
#define NUM_LEDS       5
#define NUM_LEDS_ACTIVE       1
#define PIN_MOTION     5

CRGB leds[NUM_LEDS];

int brightness = 0;

void setup() {
  pinMode(PIN_MOTION, INPUT);
  FastLED.addLeds<APA102, BGR>(leds, NUM_LEDS);
}

void loop() {
  brightness += digitalRead(PIN_MOTION) ? 1 : -1;

  if (brightness < 0) {
    brightness = 0;
  }

  if (brightness > MAX_BRIGHTNESS) {
    brightness = MAX_BRIGHTNESS;
  }

  for (uint8_t i = 0; i < NUM_LEDS_ACTIVE; i++) {
    leds[i] = CRGB(brightness, brightness, brightness);
  }
  FastLED.show();

  delay(DIM_TIME/MAX_BRIGHTNESS);
}
