$fn=120;

height=30;
radius=50;
wall_thickness=2;
rounding=4;

motion_radius=23/2;

diffuser_outer_r=radius-5;
diffuser_inner_r=40/2;
diffuser_thickness=0.25;

bottom_thickness=2;
brace=10;
screw_hole=1.5;
screw_hole_bevel=8;
tooth_extends=1;

smidge = 0.1;

//cutaway();
//bottom();
//color(alpha=0.1)
top_print();
//teeth();

module cutaway() {
  difference() {
    top();
    cube([100,100,100]);
  }
}

module bottom() {
  difference() {
    union() {
    cylinder(r=radius-wall_thickness,h=bottom_thickness);

      teeth();
    }

    translate([0, 0, -smidge])
    difference() {
      cylinder(r=radius - wall_thickness * 2, h=bottom_thickness*2);
      cross(radius, brace, bottom_thickness);
    }
    for(rot = [ 0 : 90 : 270 ])
      rotate([0,0,rot])
        translate([radius - 10, 0, -smidge])
          cylinder(r1=screw_hole, r2=screw_hole_bevel, h=bottom_thickness * 3);
  }

}

module top_print() {
  translate([0,0,height])
  rotate([180,0,0])
    top();
}

module top() {
  difference() {
    shell();
    cylinder(r=motion_radius, h=height + rounding);
    translate([0,0,-smidge])
      cylinder(r=radius - wall_thickness, h=height - wall_thickness+smidge);
    difference() {
      cylinder(r=diffuser_outer_r, h=height - diffuser_thickness);
      translate([0,0,-smidge])
      cylinder(r=diffuser_inner_r, h=height + rounding+smidge*2);
    }

    // slot to hold bottom on
    translate([0, 0, -smidge])
      intersection() {
        cross(radius + tooth_extends+smidge, brace+smidge, bottom_thickness+smidge);
        cylinder(r=radius-wall_thickness+tooth_extends+smidge, h=bottom_thickness+smidge);
      }
    for (rot=[0 : 5 : 15])
      rotate([0,0,rot])
        render()
          teeth();

  }
}

module shell() {
  difference() {
  translate([0,0,0])
    minkowski() {
      cylinder(r=radius-rounding, h=height-rounding);
      sphere(r=rounding);
    }

    translate([-radius, -radius, -rounding*2])
    cube([radius*2,radius*2,rounding*2]);
  }
}

module teeth() {
  intersection() {
    cross(radius*2, brace, bottom_thickness * 3);
    cylinder(r1=radius-wall_thickness, r2=radius-wall_thickness + tooth_extends, h=bottom_thickness);
  }
}

module cross(r, w, h) {
      for(rot = [ 0 : 90 : 90 ])
        rotate([0,0,rot])
          translate([-r, -w/2, 0])
            cube([r*2, w, h]);
}
