include <../../parameters.scad>
use <../lib/ALU_profile_holder_top.scad>
use <../lib/ALU_joint_A.scad>

module 888_5007() {
    height = 40;

    module KSTM08_holder() {
        module nut_hole() {
            hull() {
                rotate([0, 0, 30])
                    cylinder(d=M4_nut_diameter, h=M4_nut_height, $fn=6, center=true);
                translate([0, KSTM08_case_width, 0])
                    cube([M4_nut_pocket, M4_nut_height, M4_nut_height], center=true);
            }
        }

        difference() {
            hull() {
                translate([0, 0, 0.5])
                    cube([ALU_profile_width+ALU_profile_holder_wall_thickness*2, KSTM08_case_width*1.5, 1], center=true);
                translate([0, 0, M4_nut_height*3/2+ALU_profile_holder_wall_thickness*2])
                    cube([KSTM08_case_length, KSTM08_case_width*1.5, M4_nut_height*3], center=true);
            }
            difference() {
                translate([KSTM08_screws_distance/2, 0, M4_nut_height*3/2+ALU_profile_holder_wall_thickness*2])
                    cylinder(d=M4_screw_diameter, h=M4_nut_height*3+0.1, $fn=20, center=true);
                translate([KSTM08_screws_distance/2, 0, M4_nut_height*3/2+ALU_profile_holder_wall_thickness*2+M4_nut_height/2])
                    cylinder(d=M4_screw_diameter, h=1, $fn=20);
            }
            difference() {
                translate([-KSTM08_screws_distance/2, 0, M4_nut_height*3/2+ALU_profile_holder_wall_thickness*2])
                    cylinder(d=M4_screw_diameter, h=M4_nut_height*3+0.1, $fn=20, center=true);
                translate([-KSTM08_screws_distance/2, 0, M4_nut_height*3/2+ALU_profile_holder_wall_thickness*2+M4_nut_height/2])
                    cylinder(d=M4_screw_diameter, h=1, $fn=20);
            }

            translate([KSTM08_screws_distance/2, 0, M4_nut_height*3/2+ALU_profile_holder_wall_thickness*2])
                nut_hole();
            translate([-KSTM08_screws_distance/2, 0, M4_nut_height*3/2+ALU_profile_holder_wall_thickness*2])
                nut_hole();
        }
    }

    translate([0, ALU_profile_width, 0])
        rotate([90, 0, 0])
            ALU_profile_holder_top(height);

    translate([5, ALU_profile_width+4, 0])
        ALU_joint_A(ALU_profile_width+ALU_profile_holder_wall_thickness*2-10);

    translate([0, ALU_profile_width, 0])
        cube([ALU_profile_width+ALU_profile_holder_wall_thickness*2, 4, height+ALU_profile_holder_wall_thickness*2]);

    translate([ALU_profile_width/2+ALU_profile_holder_wall_thickness, KSTM08_case_width*1.5/2, height])
        KSTM08_holder();
}

888_5007();