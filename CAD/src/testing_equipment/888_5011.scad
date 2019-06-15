include <../../parameters.scad>
use <../lib/ALU_profile_holder_top.scad>

module 888_5011() {
    height = ALU_profile_width+608_bearing_outer_diameter-2+ALU_profile_holder_wall_thickness*2+5;

    translate([-ALU_profile_width/2-ALU_profile_holder_wall_thickness, -55-ALU_profile_holder_wall_thickness*2, 0])
        ALU_profile_holder_top(50);

    difference() {
        hull() {
            translate([(ALU_profile_width+ALU_profile_holder_wall_thickness*2+16)/-2, -5, 0])
                cube([ALU_profile_width+ALU_profile_holder_wall_thickness*2+16, height+5, ALU_profile_width]);

            translate([ALU_profile_width/-2-ALU_profile_holder_wall_thickness, -ALU_profile_holder_wall_thickness*2-5, 0])
                cube([ALU_profile_width+ALU_profile_holder_wall_thickness*2, ALU_profile_holder_wall_thickness*2, ALU_profile_width]);

            translate([0, height, ALU_profile_width/2])
                rotate([0, 90, 0])
                    cylinder(d=608_bearing_outer_diameter, h=ALU_profile_width+ALU_profile_holder_wall_thickness*2+16, center=true, $fn=40);
        }

        translate([(ALU_profile_width+ALU_profile_holder_wall_thickness*2+6)/-2, 0, -0.1])
            cube([ALU_profile_width+ALU_profile_holder_wall_thickness*2+6, height+608_bearing_outer_diameter/2, ALU_profile_width+0.2]);

        translate([0, height, ALU_profile_width/2])
            rotate([0, 90, 0])
                cylinder(d=M8_screw_diameter, h=ALU_profile_width*2, $fn=20, center=true);
    }
}
888_5011();