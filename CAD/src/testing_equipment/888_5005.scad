include <../../parameters.scad>
use <../lib/ALU_profile_holder_side.scad>

module 888_5005() {
    joint_width = 8;
    wall_thickness = ALU_profile_holder_wall_thickness;
    
    translate([0, -ALU_profile_width-ALU_profile_holder_wall_thickness*2, 0])
        ALU_profile_holder_side(ALU_profile_width);
    
    module holder() {
        difference() {
            hull() {
                cube([3, 4, ALU_profile_width]);
                
                translate([1.5, 10, ALU_profile_width/2])
                    rotate([0, 90, 0])
                        cylinder(d=M5_screw_diameter+10, h=3, $fn=60, center=true);
            }
            
            translate([1.5, 10, ALU_profile_width/2])
                rotate([0, 90, 0])
                    cylinder(d=M5_screw_diameter, h=4, $fn=20, center=true);
        }
    }
    translate([(ALU_profile_width+wall_thickness*2)/2-3-joint_width/2, 0, 0])
        holder();
    translate([(ALU_profile_width+wall_thickness*2)/2+joint_width/2, 0, 0])
        holder();
}

888_5005();