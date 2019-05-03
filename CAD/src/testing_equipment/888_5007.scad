include <../../parameters.scad>
use <../lib/ALU_profile_holder_top.scad>
use <../lib/ALU_joint_A.scad>

module 888_5007() {
    height = 40;

    translate([0, ALU_profile_width, 0])
        rotate([90, 0, 0])
            ALU_profile_holder_top(height);

    translate([5, ALU_profile_width+4, 0])
        ALU_joint_A();

    translate([0, ALU_profile_width, 0])
        cube([ALU_profile_width+ALU_profile_holder_wall_thickness*2, 4, height+ALU_profile_holder_wall_thickness*2]);
}

888_5007();