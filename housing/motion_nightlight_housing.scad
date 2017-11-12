$fn=120;
smidge = 0.1;

battery_size = [];
board_size = [64, 35.0, 1.6];
board_hole_offset = 3.5;
wall_size=3;

interior = [94, 94, 37.5];

translate([interior[0]/2 - board_size[0]/2, 1, 0])
  electronics();
enclosure_with_design(interior);

module enclosure_with_design(outer_size) {
  translate([0, 0, -22]) {
    translate([-1, -1, outer_size[2] - 2])
      diffuser_and_grate(outer_size);

    color("SaddleBrown", alpha=0.8)
      translate([-wall_size, -wall_size, 0])
        enclosure(outer_size, wall_size);
  }
}

module diffuser_and_grate(inner_size) {
  translate([0, 0, 0.51])
    color(c=[0.2, 0.2, 0.2])
      import("metal mesh design.dxf");
  // diffuser
  color(c=[0.9, 0.9, 0.9])
    difference() {
      cube(inner_size + [2, 2, -(inner_size[2]-0.1)]);
      translate([inner_size[0]/2+1, 14.5, -1])
        cylinder(r=11, h=3);
    }
}

module enclosure(inner_size, wall) {
    difference() {
      cube(inner_size + [wall, wall, 0] * 2);
      translate([wall, wall, wall])
        cube(inner_size);
    }
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
    translate([board_size[0]/2, 22, 2])
      photo_resistor();
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

module photo_resistor(photo_sensor_r=5/2, photo_sensor_h=2, photo_sensor_cut=0.5, photo_sensor_lead_hole_r=0.25, photo_sensor_lead_h=24) {
  height = 2;
  cut_cylinder(r=photo_sensor_r, h=photo_sensor_h, cut=photo_sensor_cut);
  translate([-2.7/2, 0, -photo_sensor_lead_h])
  cylinder(r=photo_sensor_lead_hole_r, h=photo_sensor_lead_h);
  translate([2.7/2, 0, -photo_sensor_lead_h])
  cylinder(r=photo_sensor_lead_hole_r, h=photo_sensor_lead_h);
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