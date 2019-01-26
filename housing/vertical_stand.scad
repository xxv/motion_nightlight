include <motion_nightlight_housing.scad>;

curve_r = 2;
foot_extra_z = 1;
cutout_z_offset = 2;
lip = 2;

exterior = interior_battery + [wall_size * 2, wall_size * 2, wall_size * 2];

%translate([0, exterior.z, cutout_z_offset])
  rotate([90,0,0])
    cube(exterior);

vertical_stand(exterior);

module section(length) {
  edge(length);
  rotate([0, 0, 90])
    corner();
}

module corner() {
  intersection() {
    translate([0, 0, curve_r])
    rotate_extrude() {
      nice_curve();
    }
    cube([curve_r * 2, curve_r * 2, curve_r * 2]);
  }
}

module edge(length) {
  translate([0, 0, curve_r])
  rotate([90, 0, 90])
  linear_extrude(height=length) {
    nice_curve();
  }
}

module nice_curve() {
  difference() {
    union() {
      circle(r=curve_r);
      translate([0, -curve_r])
      square([curve_r * 2, curve_r]);
    }
    translate([curve_r * 2, 0])
      circle(r=curve_r);
    translate([-curve_r * 2, -curve_r])
      square([curve_r + curve_r, curve_r + curve_r]);
  }
}

module vertical_stand(interior) {
  difference() {
    decorative_platform(interior);
    translate([0, 0, cutout_z_offset])
      cube([interior.x, interior.z, interior.x]);
    translate([lip, lip, -1])
      cube([interior.x - lip * 2, interior.z - lip * 2, interior.x]);
  }
}

module decorative_platform(interior) {
  cube([interior.x, interior.z, curve_r * 2 + foot_extra_z]);
  translate([0, 0, foot_extra_z]) {
    translate([0, interior.z, 0])
      section(interior.x);
    translate([interior.x, 0, 0])
      rotate([0, 0, 180])
        section(interior.x);
    translate([0,0, 0])
      rotate([0, 0, 90])
        section(interior.z);
    translate([interior.x, interior.z, 0])
      rotate([0, 0, -90])
        section(interior.z);
  }

  linear_extrude(height=foot_extra_z)
    minkowski() {
      square([interior.x, interior.z]);
      circle(r=curve_r * 2);
    }
}
