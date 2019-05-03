include <../../parameters.scad>

module ALU_joint_B(height) {
    module holder() {
        difference() {
            hull() {
                cube([4, 10, height]);

                translate([0, 608_bearing_outer_diameter-5, height/2])
                    rotate([0, 90, 0])
                        cylinder(d=M8_screw_diameter+15, h=4, $fn=60);
            }
            translate([-0.1, 608_bearing_outer_diameter-5, height/2])
                rotate([0, 90, 0])
                    cylinder(d=M8_screw_diameter, h=4.2, $fn=60);
        }
    }
    translate([0.5, 0, 0])
    holder();

    translate([ALU_profile_width+ALU_profile_holder_wall_thickness*2-4.5, 0, 0])
    holder();
}

ALU_joint_B(20);