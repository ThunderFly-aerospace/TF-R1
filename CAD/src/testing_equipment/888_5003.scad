include <../../parameters.scad>
use <../lib/ALU_profile_holder_side.scad>

module 888_5003() {
    translate([0, -ALU_profile_width-ALU_profile_holder_wall_thickness*2, 0])
        ALU_profile_holder_side(608_bearing_outer_diameter+10);
    
    module bearing_holder() {
        difference() {
            hull() {
                cube([608_bearing_thickness+2, 10, 608_bearing_outer_diameter+10]);
                translate([0, 20, (608_bearing_outer_diameter+10)/2])
                    rotate([0, 90, 0])
                        cylinder(d=608_bearing_outer_diameter+10, h=608_bearing_thickness+2, $fn=100);
            }
            
            translate([2, 20, (608_bearing_outer_diameter+10)/2])
                    rotate([0, 90, 0])
                        cylinder(d=608_bearing_outer_diameter, h=608_bearing_thickness+0.1, $fn=60);
            
            translate([-0.1, 20, (608_bearing_outer_diameter+10)/2])
                    rotate([0, 90, 0])
                        cylinder(d=M8_screw_diameter+8, h=608_bearing_thickness+2, $fn=60);
        }
    }
    
    bearing_holder();
    translate([ALU_profile_width+ALU_profile_holder_wall_thickness*2, 0, 0])
        mirror([1, 0, 0])
            bearing_holder();
}

888_5003();