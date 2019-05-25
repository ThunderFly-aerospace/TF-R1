include <../../parameters.scad>
use <../lib/ALU_profile_holder_side.scad>
use <../lib/ALU_joint_A.scad>

module 888_5003() {
    translate([0, -ALU_profile_width-ALU_profile_holder_wall_thickness*2, 0])
        ALU_profile_holder_side(608_bearing_outer_diameter+10);
    
    
    translate([5, 0, 0])
    ALU_joint_A(ALU_profile_width+ALU_profile_holder_wall_thickness*2-10);
}

888_5003();