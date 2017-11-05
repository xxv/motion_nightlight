$fn=120;
smidge = 0.1;

battery_size = [];
board_size = [];
board_hole_offset = 3.5;

electronics();
enclosure_with_design([100, 100, 36.1]);

module enclosure_with_design(outer_size) {
  translate([0, 0, -22]) {
    translate([-1.5, -1.5, outer_size[2] - 2])
      diffuser_and_grate(outer_size);

    color("SaddleBrown", alpha=0.8)
      translate([-3.5, -3.5, 0])
        enclosure(outer_size);
  }
}

module diffuser_and_grate(outer_size) {
        translate([0, 0, 0.51])
        color(c=[0.2, 0.2, 0.2])
          import("metal mesh design.dxf");
    // diffuser
    color(c=[0.9, 0.9, 0.9, 0.9])
      cube(outer_size - [5, 5, outer_size[2]-0.1]);
}

module screw() {
  color([0.3, 0.3, 0.3])
  import("screw.stl");
  color([0.7, 0.7, 0.7])
  translate([0, 0, -4.3])
    import("nut.stl");
}

module enclosure(outer_size, wall=3) {
    difference() {
      cube(outer_size);
      translate([wall, wall, wall])
        cube(outer_size - [wall, wall, 0] * 2);
    }
 }

module electronics() {
  translate([14, 0, 0]) {
    board();
    translate([32.7,3.4,-0.6])
      rotate([0,180,0])
      battery();
    translate([16.5, 29.8, -2.5]) {
      translate([0, 0, 0])
        rotate([0, 180, 0])
          screw();
      translate([30, 0, 0])
        rotate([0, 180, 0])
          screw();
    }
  }
}

module battery() {
  color(c=[0.2, 0.2, 0.2])
    translate([2,23,7])
      rotate([90,0,-90])
        import("keystone-PN2464.stl");
}

module board() {
  color("purple") {
    rotate([0, 0, 90])
      translate([-114, 60, 0])
        import("../board/motion_light.stl");
    translate([32, 7, 1])
      pir();
    translate([32, 20, 2])
      photo_resistor();
  }
};

module pir() {
  cylinder(r1=11/2, r2=9.5/2,h=13);
}

module pir_wide() {
  cylinder(r1=11/2, r2=9.5/2,h=13);

  translate([0, 0, 7.3])
    difference() {
    sphere(r=20.7/2);
      translate([-16, -16, -62])
      cube([32, 32, 62]);
    }
}

module cut_cylinder(r, h, cut) {
  intersection() {
    cylinder(r=r, h=h);
    translate([-r, -r + cut, 0])
    cube([r * 2, r * 2 - cut * 2, h+smidge*2]);
  }
}

module photo_resistor(photo_sensor_r=5/2, photo_sensor_h=2, photo_sensor_cut=0.5, photo_sensor_lead_hole_r=0.25, photo_sensor_lead_h=24) {
  height = 2;
  cut_cylinder(r=photo_sensor_r, h=photo_sensor_h, cut=photo_sensor_cut);
  translate([-2.7/2, 0, -photo_sensor_lead_h])
  cylinder(r=photo_sensor_lead_hole_r, h=photo_sensor_lead_h);
  translate([2.7/2, 0, -photo_sensor_lead_h])
  cylinder(r=photo_sensor_lead_hole_r, h=photo_sensor_lead_h);
  }
