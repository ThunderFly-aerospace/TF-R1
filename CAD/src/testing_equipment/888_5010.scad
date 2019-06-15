include <../../parameters.scad>
use <../lib/ALU_joint_A.scad>
use <../lib/ALU_profile_holder_side.scad>


module 888_5010() {
    screw_head_height = 3;

    ALU_joint_A(ALU_profile_width+ALU_profile_holder_wall_thickness*2+screw_head_height*2);
    translate([screw_head_height, -ALU_profile_width-ALU_profile_holder_wall_thickness*2, 0])
        ALU_profile_holder_side(608_bearing_outer_diameter+10);


}

888_5010();