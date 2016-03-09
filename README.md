Motion detector night light
===========================

A simple little light to illuminate your dark hallway on your way to the bathroom.

Ingredients
-----------

* 1 Arduino Mini Pro 5v (or other similar microcontroller)
* 1 APA102 LED
* 1 PIR motion detector
* 1 Barrel jack

Steps
-----

Wire the APA102 to the SPI pins (on the Arduino Mini Pro, these are pins MOSI
11 and CLK 13). Connect the APA102 5V to the Arduino 5V regulator output pin
(or your supply voltage if it's a well-regulated 5V).

Connect the PIR sensor output to pin 5 (it's arbitrary).

The PIR sensor that I used does most of the timing for you, hence why there is
no retrigger/hold/timeout logic in the Arduino code.
