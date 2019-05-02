include <../../parameters.scad>
use <../lib/ALU_profile_holder_top.scad>


    
module 888_5004() {
    podlozka = 0.8; //tloušťka podložky
    deep = 40;
    
    translate([0, -deep-ALU_profile_holder_wall_thickness*2, 0])
        ALU_profile_holder_top(deep);
    
    translate([ALU_profile_width/2+ALU_profile_holder_wall_thickness-(ALU_profile_width+ALU_profile_holder_wall_thickness*2-(608_bearing_thickness*2+podlozka*2+4))/2, 0, 0])
        difference() {
            hull() {
                cube([ALU_profile_width+ALU_profile_holder_wall_thickness*2-(608_bearing_thickness*2+podlozka*2+4), 10, ALU_profile_width]);
                
                translate([0, 608_bearing_outer_diameter-5, ALU_profile_width/2])
                    rotate([0, 90, 0])
                        cylinder(d=M8_screw_diameter+15, h=ALU_profile_width+ALU_profile_holder_wall_thickness*2-(608_bearing_thickness*2+podlozka*2+4), $fn=60);
            }
            
            translate([0, 608_bearing_outer_diameter-5, ALU_profile_width/2])
                rotate([0, 90, 0])
                    cylinder(d=M8_screw_diameter, h=ALU_profile_width+ALU_profile_holder_wall_thickness*2-(608_bearing_thickness*2+podlozka*2+4), $fn=20);
        }
}
888_5004();