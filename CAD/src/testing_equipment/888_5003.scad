include <../../parameters.scad>
use <../lib/ALU_profile_holder.scad>

module 888_5003() {
    translate([0, -ALU_profile_width-ALU_profile_holder_wall_thickness*2, 0])
        ALU_profile_holder();
    
    module bearing_holder() {
        difference() {
            hull() {
                cube([bearing_height+2, 10, strain_gauge_screw_distance+20]);
                translate([0, 20, (strain_gauge_screw_distance+20)/2])
                    rotate([0, 90, 0])
                        cylinder(d=strain_gauge_screw_distance+20, h=bearing_height+2, $fn=100);
            }
            
            translate([0, 20, (strain_gauge_screw_distance+20)/2])
                    rotate([0, 90, 0])
                        cylinder(d=bearing_outer_diameter, h=bearing_height, $fn=60);
            
            translate([0, 20, (strain_gauge_screw_distance+20)/2])
                    rotate([0, 90, 0])
                        cylinder(d=bearing_inner_diameter, h=bearing_height+2, $fn=60);
        }
    }
    
    bearing_holder();
    translate([ALU_profile_width+ALU_profile_holder_wall_thickness*2, 0, 0])
    mirror([1, 0, 0])
        bearing_holder();
}

888_5003();