include <../../parameters.scad>

module rotor_joint() {
    module screw_nut_hole() {
        difference() {
            translate([(ALU_profile_width/2+ALU_profile_holder_wall_thickness+M4_screw_diameter), (ALU_profile_width/2+ALU_profile_holder_wall_thickness+M4_screw_diameter), 0])
                cylinder(d=M4_screw_diameter, h=M4_nut_height*3+0.1, center=true, $fn=20);
            translate([(ALU_profile_width/2+ALU_profile_holder_wall_thickness+M4_screw_diameter), (ALU_profile_width/2+ALU_profile_holder_wall_thickness+M4_screw_diameter), M4_nut_height/2])
                cylinder(d=M4_screw_diameter, h=1, $fn=20); 
        }

        hull() {
            translate([(ALU_profile_width/2+ALU_profile_holder_wall_thickness+M4_screw_diameter), (ALU_profile_width/2+ALU_profile_holder_wall_thickness+M4_screw_diameter), 0])
                rotate([0, 0, 30])
                    cylinder(d=M4_nut_diameter, h=M4_nut_height, $fn=6, center=true);

            translate([(ALU_profile_width/2+ALU_profile_holder_wall_thickness+M4_screw_diameter), (ALU_profile_width/2+ALU_profile_holder_wall_thickness+M4_screw_diameter)+M4_screw_diameter*2, 0])
                cube([M4_nut_pocket, M4_screw_diameter, M4_nut_height], center=true);
        }
    }

    difference() {
        minkowski() {
            cube([ALU_profile_width+ALU_profile_holder_wall_thickness*2+M4_screw_diameter*2, ALU_profile_width+ALU_profile_holder_wall_thickness*2+M4_screw_diameter*2, M4_nut_height*3/2], center=true);
            cylinder(d=M4_nut_diameter*2, h=M4_nut_height*3/2, $fn=70, center=true);
        }
        screw_nut_hole();
        rotate([0, 0, 90])
            screw_nut_hole();
        rotate([0, 0, 180])
            screw_nut_hole();
        rotate([0, 0, 270])
            screw_nut_hole();
    }
}

rotor_joint();