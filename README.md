Motion detector night light
===========================

A light to illuminate your dark hallway on your way to the bathroom.

Ingredients
-----------

### Custom parts
* fully-populated and assembled PCB
* laser-cut wooden housing (`housing/housing_lasercut.scad`), cut from 3mm plywood
* laser-cut or 3D printed front grate (`housing/front_grate.svg`), 1.5mm black acrylic
* laser-cut diffuser holder (`housing/diffuser_holder.scad`), cut from 3mm black acrylic
* 3D printed board holder (`housing/board_holder.scad`)
* 3D printed battery plate (`housing/battery_plate.scad`)

### Vitamins
* 2x M2.5x8 black flat head bolt with washer and nut McMaster: 91294A016,
  90591A270, 93475a196
* 10x M2.2 6.5mm round head screws for sheet metal McMaster: 94997a125
* 3x AA batteries

### Other bits
* Diffuser (`housing/diffuser.scad`) cut from LEE Filters 810 Zircon Diffusion
  1 (or similar)
* Wood glue (+ clamps)
* Super glue
* 2mm-wide double-stick tape or similar

Main Assembly
-------------

1. Assemble PCB. Use M2.5x8 hardware to fasten battery holder to board.
2. Assemble diffuser assembly (see below).
3. Cut out main enclosure.
4. Glue main enclosure together with wood glue. Clamp and wipe off excess glue
   with a damp paper towel.
5. Glue battery plate to battery cover with super glue. (center carefully)
6. Once main enclosure glue is dry, screw board holder to it with M2.2 screws.
7. Screw board to board holder using M2.2 screws.
8. Slide the diffuser assembly into place. It should fit snugly, but not fall out.
9. Put fresh batteries into the night light. Don't put the battery cover on yet.
10. Calibrate the ambient light sensor.
    1. Bringing the night light into a dark room.
    2. Pull out the middle battery.
    3. Holding down both buttons, re-insert the middle battery.
    4. The status LED should blink three times to indicate that the calibration has been saved.

Diffuser Assembly
-----------------

1. Cut out the diffuser stand (4 identical parts) and assemble with super glue.
2. Cut out the diffuser from the Zircon 810 sheet using the diffuser template.
   This material is polyester and can be laser cut if desired.
3. Adhere the diffuser to the diffuser stand using the double-stick tape.
4. Cut out the diffuser decorative grate `front_grate.svg`. Note the
   non-commercial terms for this part in the license at the bottom.
5. Adhere the diffuser decorative grate to the diffuser using 2mm double-stick tape.

License
-------

* The PCB design and associated firmware are licensed under the GPLv3.
* The diffuser grate artwork (`front_grate.svg` and derivatives) is licensed under
  the Creative Commons CC-BY-NC-SA 4.0. If you wish to sell night lights using
  these files, you must use your own design for this one part. Consider this an
  opportunity to make your night light truly your own!
* All of the mechanical parts (housing, board stand, etc.) are available
  licensed under the Creative Commons CC-BY-SA 4.0 license.
