include <../parameters.scad>
$fn=90;
switch_diameter = 58;
switch_mounting_screws_distance = (31+43.5)/2;
switch_height = 50;
switch_screws_width = 23;
wall_thickness = 8;

difference(){
    cylinder(d = switch_diameter + 2 * wall_thickness, h=switch_height);

    translate([- switch_diameter, -switch_screws_width/2, wall_thickness])
        cube([2*switch_diameter,switch_screws_width,switch_height]);

    translate([ 0, 0, switch_height - 7])
        cylinder(d = switch_diameter,h=50);


    translate([0,switch_mounting_screws_distance/2,0])
    {
        cylinder(d = M5_screw_diameter,h = 50);
        cylinder(d = M5_nut_diameter,h = switch_height/2, $fn = 6);
    }

    translate([0,-switch_mounting_screws_distance/2,0])
    {
        cylinder(d = M5_screw_diameter,h = 50);
        cylinder(d = M5_nut_diameter,h = switch_height/2, $fn = 6);
    }
}
