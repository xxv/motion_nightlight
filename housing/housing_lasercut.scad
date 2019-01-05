include <motion_nightlight_housing.scad>;

copies = 4;
spacing = 2;
width = interior_battery.x + spacing + wall_size * 2;

for(x=[0 : width : width * copies - 1])
translate([x, 0])
enclosure_2d(interior_battery, wall_size);
