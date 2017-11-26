include <boxmaker.scad>;

$fn = 120;
smidge = 0.1;

board_size = [64, 35.0, 1.6];
board_clearance = 1;
board_hole_offset = 4;
wall_size = 3;
battery_hole_size = [46, 55];
battery_hole_offset = [0, 3];
laser_pilot_hole=1.33/2;

overlap = 5;
inset = 1;
plate_width = board_size[0] + overlap * 2;
wood_screws = [
  [battery_hole_size[0]/2 + overlap/2, board_clearance + board_size[1] + overlap/2, 0],
  [battery_hole_size[0]/2 + overlap/2, battery_hole_size[1] + battery_hole_offset[1] + overlap/2, 0],
  [plate_width/2 - overlap/2, overlap/2, 0]
  ];

interior = [94, 94, 32];

board_z = 12.5;

mockup();
//enclosure(interior, wall_size);
//board_holder();

module mockup() {
  translate([interior[0]/2 - board_size[0]/2, board_clearance, 0])
    electronics();
  enclosure_with_design(interior);
}

module enclosure_with_design(interior) {
  translate([0, 0, -(interior[2] - board_z)]) {
    translate([-1, -1, interior[2] + wall_size - 2])
      diffuser_and_grate(interior);

    color([0.1, 0.1, 0.1])
      board_holder();

    color("SaddleBrown", alpha=0.5)
      enclosure(interior, wall_size);
  }
}

module diffuser_and_grate(inner_size) {
  translate([0, 0, 0.51])
    color(c=[0.2, 0.2, 0.2])
      import("metal mesh design.dxf");
  // diffuser
  color(c=[0.95, 0.95, 0.95, 1])
    difference() {
      cube(inner_size + [2, 2, -(inner_size[2]-0.1)]);
      translate([inner_size[0]/2+1, 14.5, -1])
        cylinder(r=11, h=3);
    }
}

module board_holder() {
  overlap = 5;
  inset = 1;
  thickness = 1;
  stand_width = 6;
  battery_hole = [battery_hole_size[0] - inset * 2, battery_hole_size[1] - inset * 2, thickness + 1];
  board_screw_hole = 0.75;
  plate_screw_hole = 2.2;
  z_height = interior[2] - board_z - board_size[2]/2;

  screw_standoff = 3;

#  translate([interior[0]/2, 0, screw_standoff + 1])
      for (m = [0 : 1 : 1])
        mirror([m, 0, 0])
          for (screw = wood_screws)
            translate(screw)
              import("m2.2_wood_screw.stl");

  // main plate
  difference() {
    union() {
      translate([interior[0]/2 - battery_hole_size[0]/2 - overlap, 0, 0])
        cube([battery_hole_size[0] + overlap * 2, battery_hole_size[1] + battery_hole_offset[1] + overlap, thickness]);
      translate([interior[0]/2 - plate_width/2, 0, 0])
        cube([plate_width, board_size[1] + board_clearance + overlap, thickness]);
      translate([interior[0]/2, 0, 1])
          for (m = [0 : 1 : 1])
            mirror([m, 0, 0])
              for (screw = wood_screws)
                translate(screw)
                  translate([-overlap/2, -overlap/2, 0])
                    cube([overlap, overlap, screw_standoff]);

    }
    translate(battery_hole_offset)
      translate([interior[0]/2 - battery_hole[0]/2, inset, -0.5])
        cube(battery_hole);

    translate([interior[0]/2, 0, -1])
      for (m = [0 : 1 : 1])
        mirror([m, 0, 0]) {
          for (screw = wood_screws)
            translate(screw)
              cylinder(r=plate_screw_hole/2, h=10);
        }
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

module enclosure(box_inner, thickness) {
  tab = thickness * 2;
  tabs = [tab, tab, tab];
  button_offset = [9.25, 0];
  button_hole_size = 2;

  screw_hole_spacing = 70;
  screw_size = 3;
  screw_head_size = screw_size + 3;

  // BEGIN 2D LAYOUT
  //layout_2d(box_inner, thickness) {
  // END 2D LAYOUT

  // BEGIN 3D PREVIEW
  layout_3d(box_inner, thickness) {
  // END 3D PREVIEW

    // Top
    empty();

    // Bottom
    difference() {
      side_a(box_inner, thickness, tabs);
      // Battery hole
      translate(-battery_hole_offset)
        translate([box_inner[0]/2 - battery_hole_size[0]/2, box_inner[1] - battery_hole_size[1]])
          square(battery_hole_size);

      // Screw holes
      translate([box_inner[0]/2 - screw_hole_spacing/2, screw_head_size * 2, 0])
        rotate([180])
          screw_slot_2d(screw_head_size, screw_size, screw_head_size);
      translate([box_inner[0]/2 + screw_hole_spacing/2, screw_head_size * 2, 0])
        rotate([180])
          screw_slot_2d(screw_head_size, screw_size, screw_head_size);

      translate([interior[0]/2, 0])
        for (m = [0 : 1 : 1])
          mirror([m, 0, 0])
            for (screw = wood_screws)
              translate([0, interior[1]] - screw)
                circle(r=laser_pilot_hole);
    }

    // Left
    difference() {
      side_b(box_inner, thickness, tabs);
    }

    // Right
    difference() {
      side_b(box_inner, thickness, tabs);
    }

    // Front
    difference() {
      side_c(box_inner, thickness, tabs);
      translate([box_inner[0]/2, box_inner[2] - (board_z - 4.4)]) {
        translate(-button_offset)
          circle(r=button_hole_size);
        translate(button_offset)
          circle(r=button_hole_size);
        }
    }

    // Back
    difference() {
      side_c(box_inner, thickness, tabs);
    }
  }
}

module screw_slot_2d(head_size, screw_size, length) {
  circle(r=head_size/2);
    translate([-screw_size/2, 0])
      square([screw_size, length]);
  translate([0, length])
    circle(r=screw_size/2);
}

module electronics() {
  board();
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
};

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
