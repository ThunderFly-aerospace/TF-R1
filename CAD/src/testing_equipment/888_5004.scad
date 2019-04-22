include <../../parameters.scad>
use <../lib/ALU_profile_holder_top.scad>


    
module 888_5004() {
    podlozka = 0.8; //tloušťka podložky
    
    translate([0, -ALU_profile_width-ALU_profile_holder_wall_thickness*2, 0])
        ALU_profile_holder_top();
    
    translate([ALU_profile_width/2+ALU_profile_holder_wall_thickness-(ALU_profile_width+ALU_profile_holder_wall_thickness*2-(bearing_height*2+podlozka*2+4))/2, 0, 0])
        difference() {
            hull() {
                cube([ALU_profile_width+ALU_profile_holder_wall_thickness*2-(bearing_height*2+podlozka*2+4), 5, ALU_profile_width]);
                
                translate([0, bearing_outer_diameter-5, ALU_profile_width/2])
                    rotate([0, 90, 0])
                        cylinder(d=bearing_inner_diameter+10, h=ALU_profile_width+ALU_profile_holder_wall_thickness*2-(bearing_height*2+podlozka*2+4), $fn=60);
            }
            
            translate([0, bearing_outer_diameter-5, ALU_profile_width/2])
                rotate([0, 90, 0])
                    cylinder(d=bearing_inner_diameter, h=ALU_profile_width+ALU_profile_holder_wall_thickness*2-(bearing_height*2+podlozka*2+4), $fn=20);
        }
}
888_5004();