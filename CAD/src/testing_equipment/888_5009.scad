include <../../parameters.scad>
use <../lib/rotor_joint.scad>


module 888_5009() {
    $fn=100;
    rod_size = 8; // delka hrany sloupku
    Bwall = 1.5; // wall around bearing
    BaseThickness = 0;
    space = 1;
    rotor_plane_space = 7;
    rotor_shaft_angle = 10;
    bearing_inner_diameter = 7;
    bearing_shaft_shift = ((rod_size/2 + BaseThickness + M3_screw_diameter/2 + space)/tan(rotor_shaft_angle)) - bearing_shaft_length - rotor_plane_space;
    echo(bearing_shaft_shift);

    module rotor_holder() {
        difference() {
            union(){
                hull(){
                translate([-rod_size/2, 0, bearing_outer_diameter/2 + Bwall]) rotate([0, 90, 0])
                        cylinder(d = bearing_outer_diameter + Bwall*2, h = bearing_shaft_length + bearing_shaft_shift + rod_size/2);
            //       translate([-rod_size/2, -bearing_outer_diameter/2 - Bwall, -BaseThickness])
            //            cube([bearing_shaft_length + bearing_shaft_shift + rod_size/2, bearing_outer_diameter + Bwall*2, bearing_outer_diameter/2 + Bwall]);
                    
                translate([-rod_size/2, -bearing_outer_diameter/2 - Bwall, -BaseThickness])
                        cube([bearing_outer_diameter, bearing_outer_diameter + Bwall*2, bearing_outer_diameter + Bwall*2]);
                }
            }
            translate([bearing_shaft_shift + bearing_shaft_length - bearing_shaft_length + bearing_thickness - 100, 0, bearing_outer_diameter/2 + Bwall])
                rotate([0, 90, 0])
                    cylinder(d = bearing_outer_diameter, h = 100);

            translate([bearing_shaft_shift + bearing_shaft_length - bearing_shaft_length + bearing_thickness + layer_thickness, 0, bearing_outer_diameter/2 + Bwall])
                    rotate([0, 90, 0])
                        cylinder(d = bearing_inner_diameter, h = 100);

            translate([bearing_shaft_shift + bearing_shaft_length - bearing_thickness, 0, bearing_outer_diameter/2 + Bwall])
                    rotate([0, 90, 0])
                        cylinder(d = bearing_outer_diameter, h = bearing_thickness + 0.1 + 100);
        }
    }

    difference() {
        union() {
            translate([0, 0, 2.5])
                rotor_joint(2, 5);
            translate([bearing_outer_diameter/2+Bwall, 0, 5])
            rotate([0, -90, 0])
                translate([rod_size/2, 0, 0])
                    rotor_holder();
        }

        cylinder(d=bearing_outer_diameter, h=5);
    }
}

888_5009();