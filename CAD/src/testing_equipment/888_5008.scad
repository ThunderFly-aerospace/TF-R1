include <../../parameters.scad>
use <../lib/ALU_joint_B.scad>
use <../lib/rotor_joint.scad>

module 888_5008() {
    translate([0, 0, -12/2])
    rotor_joint(1, 12);

    difference() {
        translate([0, 0, 35])
            cube([ALU_profile_width+ALU_profile_holder_wall_thickness*2, ALU_profile_width+ALU_profile_holder_wall_thickness*2, 70], center=true);
        
        hull() {
            translate([0, 0, ALU_profile_width/2])
                rotate([90, 0, 0])
                    cylinder(d=M6_square_nut_diameter+5, h=ALU_profile_width+ALU_profile_holder_wall_thickness*2+0.1, center=true, $fn=50);
            
            translate([0, 0, ALU_profile_width/2+40])
                rotate([90, 0, 0])
                    cylinder(d=M6_square_nut_diameter+5, h=ALU_profile_width+ALU_profile_holder_wall_thickness*2+0.1, center=true, $fn=50);
        }
        translate([0, 0, 45])
            rotate([0, 90, 0])
                cylinder(d=M8_screw_diameter, h=ALU_profile_width+ALU_profile_holder_wall_thickness*2+0.1, $fn=20, center=true);
    }

    translate([(ALU_profile_width+ALU_profile_holder_wall_thickness*2-9)/2, (ALU_profile_width+ALU_profile_holder_wall_thickness*2)/2, 70])
        rotate([90, 0, 0])
            ALU_joint_B(ALU_profile_width+ALU_profile_holder_wall_thickness*2);
    mirror([1, 0, 0])
        translate([(ALU_profile_width+ALU_profile_holder_wall_thickness*2-9)/2, (ALU_profile_width+ALU_profile_holder_wall_thickness*2)/2, 70])
            rotate([90, 0, 0])
                ALU_joint_B(ALU_profile_width+ALU_profile_holder_wall_thickness*2);
}

888_5008();