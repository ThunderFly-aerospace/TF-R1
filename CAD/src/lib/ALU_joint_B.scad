include <../../parameters.scad>

module ALU_joint_B(height) {
    difference() {
        hull() {
            cube([4, 608_bearing_outer_diameter-M8_screw_diameter/2-5, height]);

            translate([0, 608_bearing_outer_diameter-5, height/2])
                rotate([0, 90, 0])
                    cylinder(d=608_bearing_outer_diameter, h=4, $fn=60);
        }
        translate([-0.1, 608_bearing_outer_diameter-5, height/2])
            rotate([0, 90, 0])
                cylinder(d=M8_screw_diameter, h=4.2, $fn=60);
    }
}
ALU_joint_B(25);