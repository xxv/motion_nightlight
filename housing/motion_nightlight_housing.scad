include <boxmaker.scad>;

$fn = 120;
smidge = 0.1;

// main interior volume
interior_battery = [94, 94, 32];
// thickness of the wall material
wall_size = 3.3;
// distance between the top and the board
board_z = 12.5;

// size of the PCB
board_size = [64, 35.0, 1.6];
// Clearance from the wall for the board
board_clearance = 1;
// distance in from the edge of the PCB that the holes are
board_hole_offset = 4;

battery_hole_size = [46, 55];
battery_hole_offset = [0, 3];
battery_finger_size = 10;
// holes to screw plate into the wood
laser_pilot_hole = 1.33/2;

// amount that the board mount overlaps with the wood
overlap = 6;
// how much inset the battery lid rest is from the battery hole
inset = 1;

// width of the plate holding the board
plate_width = board_size[0] + overlap * 2;
// Wood screws that mount the plate to the bottom wall
wood_screws = [
  [battery_hole_size[0]/2 + overlap/2, board_clearance + board_size[1] + overlap/2, 0],
  [battery_hole_size[0]/2 + overlap/2, battery_hole_size[1] + battery_hole_offset[1] + overlap/2, 0],
  [plate_width/2 - overlap/2, overlap/2, 0]
  ];

stand_volume_battery = interior_battery + [0, 0, 1];

//////////////////////////////////////////////////////////////////////

mockup(interior_battery, stand_volume_battery, battery_present=1);

/********* laser cut *********/
*enclosure_2d(interior_battery, wall_size);

/********* 3D Print **********/
*board_holder(interior_battery);
* battery_plate(interior_battery);
* grate();
* diffuser_stand_print(stand_volume_battery);
  // This can be a knife template for cutting the diffuser material
* diffuser(stand_volume_battery, 2);

//////////////////////////////////////////////////////////////////////

module mockup(interior, stand_volume, battery_present) {
  translate([interior[0]/2 - board_size[0]/2, board_clearance, 0])
    electronics(battery_present);
  enclosure_with_design(interior, stand_volume);
}

module diffuser_stand_print(stand_volume) {
  translate([0, 0, stand_volume[2]])
    rotate([0, 180,0])
      diffuser_stand(stand_volume);
}

module enclosure_with_design(interior, stand_volume) {
  translate([0, 0, -(interior[2] - board_z)]) {
    translate([0, 0, stand_volume[2]])
      diffuser_and_grate(stand_volume);

    color([0.5, 0.5, 0.5]) {
      board_holder(interior);
      battery_plate(interior);
    }

    color("SaddleBrown", alpha=1)
      enclosure_3d(interior, wall_size);
  }
}

module diffuser_and_grate(inner_size) {
  diffuser_thickness = 0.1;

  translate([0, 0, diffuser_thickness + 0.01])
    color(c=[0.2, 0.2, 0.2])
      grate();

  // diffuser
  color(c=[0.95, 0.95, 0.95, 1])
    diffuser(inner_size, diffuser_thickness);

  color(c=[0.2, 0.2, 0.2])
    translate([0, 0, -inner_size[2] - 0.01])
      diffuser_stand(inner_size);
}

module diffuser_stand(inner_size) {
  diffuser_inset = 2.2;
  intersection() {
    difference() {
      cube(inner_size);
      inset_size = inner_size - [diffuser_inset * 2, diffuser_inset * 2, -1];
      translate((inner_size - inset_size)/2)
      cube(inset_size);
    }

    union() {
      translate([0, 0, inner_size[2] - 1])
        cube(inner_size - [0, 0, inner_size[2] - 1]);

      for (r = [0 : 90 :360])
          translate([inner_size[0]/2, inner_size[1]/2, 0])
        rotate([0, 0, r])
          translate([inner_size[0]/2, inner_size[1]/2, 0])
            cylinder(r1=2, r2=15, h=inner_size[2]);
    }
  }
}

module grate() {
  linear_extrude(height=1)
    import("metal mesh design.dxf");
}

module diffuser(inner_size, thickness=0.1) {
  difference() {
    cube(inner_size + [0, 0, -(inner_size[2] - thickness)]);
    translate([inner_size[0]/2, 13.5, -1])
      cylinder(r=11, h=thickness + 2);
  }
}

module board_holder(interior) {
  thickness = 1;
  stand_width = 6;
  battery_hole = [battery_hole_size[0] - inset * 2, battery_hole_size[1] - inset * 2, thickness + 1];
  board_screw_hole = 0.75;
  plate_screw_hole = 2.5;
  z_height = interior[2] - board_z - board_size[2]/2;

  screw_standoff = 2.5;

#  translate([interior[0]/2, 0, screw_standoff + 1])
      for (m = [0 : 1 : 1])
        mirror([m, 0, 0])
          for (screw = wood_screws)
            translate(screw)
              import("m2.2_wood_screw.stl");

  corner_r = overlap/2;
  overlap_rounded = overlap - corner_r;
  plate_width_rounded = plate_width - corner_r - overlap/2;

  // main plate
  intersection() {
    difference() {
      union() {
        minkowski() {
          union() {
            translate([interior[0]/2 - battery_hole_size[0]/2 - overlap_rounded, 0, 0])
              cube([battery_hole_size[0] + (overlap_rounded) * 2, battery_hole_size[1] + battery_hole_offset[1] + overlap_rounded, thickness]);

            translate([interior[0]/2 - plate_width_rounded/2, 0, 0])
              cube([plate_width_rounded, board_size[1] + board_clearance + overlap_rounded, thickness]);
            }
            cylinder(r=corner_r, h=0.0001);
        }

        // Screw stands
        translate([interior[0]/2, 0, 1])
            for (m = [0 : 1 : 1])
              mirror([m, 0, 0])
                for (screw = wood_screws)
                  translate(screw)
                    cylinder(r=overlap/2, h=screw_standoff);
      }

      // Battery hole
      translate(battery_hole_offset)
        translate([interior[0]/2 - battery_hole[0]/2, inset, -0.5])
          cube(battery_hole);

      // Screw holes
      translate([interior[0]/2, 0, -1])
        for (m = [0 : 1 : 1])
          mirror([m, 0, 0])
            for (screw = wood_screws)
              translate(screw)
                cylinder(r=plate_screw_hole/2, h=10);
    }
    cube(interior);
  }

  // board stands
  translate([interior[0]/2, board_clearance + board_size[1]/2, 0])
    for (m = [0 : 1 : 1])
      mirror([m, 0, 0])
        translate([board_size[0]/2 - stand_width - 1, -board_size[1]/2, 0])
          difference() {
            cube([stand_width, board_size[1], z_height]);

            translate([stand_width/2, board_hole_offset, z_height - 4.9])
              cylinder(r=board_screw_hole, h=5);

            translate([stand_width/2, board_size[1] - board_hole_offset, z_height - 4.9])
              cylinder(r=board_screw_hole, h=5);
          }
}

module battery_plate(interior) {
  battery_plate_wall = [2, 2, 0];
  inset_for_mating = 0.2;
  extra_inset = [inset * 2 + inset_for_mating, inset * 2 + inset_for_mating, 0];
  wall_thickness = 1;
  plate_thickness = 0.5;
  battery_hole = [battery_hole_size[0],
                  battery_hole_size[1],
                  wall_thickness + plate_thickness] - extra_inset;

      translate(battery_hole_offset)
        translate([interior[0]/2 - battery_hole_size[0]/2, 0, 0] + extra_inset/2)
          difference() {
            cube(battery_hole);
            translate(battery_plate_wall/2 - [0, 0, -plate_thickness])
              cube(battery_hole - (battery_plate_wall + [0, 0, -3]));
            translate([(battery_hole_size[0] - extra_inset[0])/2, battery_hole_size[1] - extra_inset[1]/2, -1])
              cylinder(d=battery_finger_size, h=wall_thickness + plate_thickness + 2);
          }
}

module back_face(box_inner, thickness, tabs) {
  screw_hole_spacing = 70;
  screw_size = 3;
  screw_head_size = screw_size + 3;

  difference() {
    side_a(box_inner, thickness, tabs);
    // Battery hole
    translate(-battery_hole_offset)
      translate([box_inner[0]/2 - battery_hole_size[0]/2,
                 box_inner[1] - battery_hole_size[1]])
        difference() {
          square(battery_hole_size);

          difference() {
            translate([smidge, smidge])
              square(battery_hole_size - [smidge * 2, smidge * 2]);

              translate([battery_hole_size[0]/2, 0])
              circle(d=battery_finger_size);
          }
        }

    // Screw holes
    translate([box_inner[0]/2 - screw_hole_spacing/2, screw_head_size * 2, 0])
      rotate([180])
        screw_slot_2d(screw_head_size, screw_size, screw_head_size);

    translate([box_inner[0]/2 + screw_hole_spacing/2, screw_head_size * 2, 0])
      rotate([180])
        screw_slot_2d(screw_head_size, screw_size, screw_head_size);

    translate([box_inner[0]/2, 0])
      for (m = [0 : 1 : 1])
        mirror([m, 0, 0])
          for (screw = wood_screws)
            translate([0, box_inner[1]] - screw)
              circle(r=laser_pilot_hole);
  }
}
module button_face(box_inner, thickness, tabs) {
  button_offset = [9.25, 0];
  button_hole_size = 2;

  difference() {
    side_c(box_inner, thickness, tabs);

    translate([box_inner[0] / 2, box_inner[2] - (board_z - 4.4)]) {
      translate(-button_offset)
        circle(r=button_hole_size);

      translate(button_offset)
        circle(r=button_hole_size);
      }
  }
}
module enclosure_3d(box_inner, thickness) {
  tab = thickness * 2;
  tabs = [tab, tab, tab];

  layout_3d(box_inner, thickness) {
    // Top
    empty();

    // Bottom
    back_face(box_inner, thickness, tabs);

    // Left
    difference() {
      side_b(box_inner, thickness, tabs);
    }

    // Right
    difference() {
      side_b(box_inner, thickness, tabs);
    }

    // Front
    button_face(box_inner, thickness, tabs);

    // Back
    difference() {
      side_c(box_inner, thickness, tabs);
    }
  }
}

module enclosure_2d(box_inner, thickness) {
  tab = thickness * 2;
  tabs = [tab, tab, tab];

  offset_bottom_pieces = -box_inner[0] - thickness * 2.5;
  layout_2d(box_inner, thickness) {
    // Top
    empty();

    // Bottom
    translate([offset_bottom_pieces, 0])
      back_face(box_inner, thickness, tabs);

    // Left
    translate([0, offset_bottom_pieces])
      difference() {
        side_b(box_inner, thickness, tabs);
      }

    // Right
    translate([0, offset_bottom_pieces])
      difference() {
        side_b(box_inner, thickness, tabs);
      }

    // Front
    button_face(box_inner, thickness, tabs);

    // Back
    difference() {
      side_c(box_inner, thickness, tabs);
    }
  }
}

module screw_slot_2d(head_size, screw_size, length) {
  circle(r=head_size / 2);
    translate([-screw_size / 2, 0])
      square([screw_size, length]);

  translate([0, length])
    circle(r=screw_size / 2);
}

module electronics(battery_present) {
  board();
  if (battery_present) {
  translate([17.1, 29.4, -4.0]) {
    translate([0, 0, 0])
      rotate([0, 180, 0])
        screw();

    translate([30, 0, 0])
      rotate([0, 180, 0])
        screw();

    translate([17.1, -26.4, 3.1])
      rotate([0,180,0])
        battery();
        }
  }
}

module battery() {
  color(c=[0.2, 0.2, 0.2])
    translate([3.15, 23, 7.0])
      rotate([90, 0, -90])
        import("keystone-PN2464.stl");
}

module board() {
    color("purple")
    rotate([0, 0, 90])
      translate([-114, 60, 0])
        import("../board/motion_light.stl");

  color([0.3, 0.3, 0.3])
   /* translate([32, 7, 1])
      pir();*/
    translate([board_size[0]/2, 12.5, 0.8])
      pir_wide();
    translate([10.5, 28, 2])
      photo_resistor(lead_h=4);
}

module pir() {
  cylinder(r1=11/2, r2=9.5/2, h=13);
}

module pir_wide() {
  cylinder(r1=11/2, r2=9.5/2, h=13);

  translate([0, 0, 9.3])
    cylinder(r=20.7/2, h=4.5);
  translate([0, 0, 7.3])
    cylinder(r=22.3/2, h=2);
  translate([0, 0, 7.3])
    intersection() {
    sphere(r=24.5/2);
      translate([-16, -16, 6.5])
        cube([32, 32, 10]);
    }
}

module photo_resistor(photo_sensor_r=5/2, photo_sensor_h=2, photo_sensor_cut=0.5, photo_sensor_lead_hole_r=0.25, lead_h=24) {
  height = 2;
  cut_cylinder(r=photo_sensor_r, h=photo_sensor_h, cut=photo_sensor_cut);
  translate([-2.7/2, 0, -lead_h])
  cylinder(r=photo_sensor_lead_hole_r, h=lead_h);
  translate([2.7/2, 0, -lead_h])
  cylinder(r=photo_sensor_lead_hole_r, h=lead_h);
  }

module screw() {
  color([0.3, 0.3, 0.3])
    import("m2.5x8_screw.stl");
  color([0.7, 0.7, 0.7])
    translate([0, 0, -5.8])
      import("m2.5_nut.stl");
}

module cut_cylinder(r, h, cut) {
  intersection() {
    cylinder(r=r, h=h);
    translate([-r, -r + cut, 0])
    cube([r * 2, r * 2 - cut * 2, h+smidge*2]);
  }
}
