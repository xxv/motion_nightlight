include <motion_nightlight_housing.scad>;

curve_r = 2;
foot_extra_z = 1;
cutout_z_offset = 2;
lip = 2;

smidge = 0.01;

exterior = interior_battery + [wall_size * 2, wall_size * 2, wall_size * 2];

%translate([0, exterior.z, cutout_z_offset])
  rotate([90,0,0])
    cube(exterior);

vertical_stand(exterior);

module section(length) {
  translate([-smidge, 0, 0])
    edge(length + smidge * 2);
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

/**
 * A small inset to help prevent the plywood laminate from catching on the corner.
 */
module corner_inset_taper() {
  corner_inset = 0.25;
  corner_taper = 15;
  linear_extrude(height=30)
    polygon(points=[[-corner_inset, -corner_inset], [0, corner_taper], [corner_taper, corner_taper], [corner_taper, 0]]);
}

module vertical_stand(interior) {
  difference() {
    decorative_platform(interior);
    translate([lip, lip, -1])
      cube([interior.x - lip * 2, interior.z - lip * 2, interior.x]);
    translate([0, 0, cutout_z_offset]) {
      cube([interior.x, interior.z, interior.x]);

    corner_inset_taper();
    translate([0, interior.z, 0])
      rotate([0, 0, -90])
        corner_inset_taper();
    translate([interior.x, interior.z, 0])
      rotate([0, 0, -180])
        corner_inset_taper();
    translate([interior.x, 0, 0])
      rotate([0, 0, -270])
        corner_inset_taper();
    }
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
