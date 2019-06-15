include <../../parameters.scad>
use <../lib/ALU_profile_holder_side.scad>

module 888_5001() {
    
    m4_head_diameter = 8;
    m4_head_height = 3;
    
    wall_thickness = ALU_profile_holder_wall_thickness;
    
    difference() {
        union() {
            translate([0, -ALU_profile_width-wall_thickness*2, 0])
                ALU_profile_holder_side(strain_gauge_screw_distance+30);
            
            translate([(ALU_profile_width+wall_thickness*2)/2-strain_gauge_width/2, 0, 0])
                cube([strain_gauge_width, m4_head_height, strain_gauge_screw_distance+20]);
        }
        
        translate([(ALU_profile_width+wall_thickness*2)/2, 0, 10]) {
            rotate([90, 0, 0]) {
                cylinder(d=M4_screw_diameter, h=wall_thickness*5+m4_head_height, $fn=20, center=true);
                translate([0, 0, wall_thickness*2-m4_head_height/2+0.1])
                    cylinder(d=m4_head_diameter, h=m4_head_height+0.1, center=true, $fn=30);
            }
        }
        translate([(ALU_profile_width+wall_thickness*2)/2, 0, strain_gauge_screw_distance+10]) {
            rotate([90, 0, 0]) {
                cylinder(d=M4_screw_diameter, h=wall_thickness*5+m4_head_height, $fn=20, center=true);
                translate([0, 0, wall_thickness*2-m4_head_height/2+0.1])
                    cylinder(d=m4_head_diameter, h=m4_head_height+0.1, center=true, $fn=30);
            }
        }
    }
}

888_5001();