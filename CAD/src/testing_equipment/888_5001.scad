include <../../parameters.scad>
use <../lib/ALU_profile_holder.scad>


module 888_5001() {
    wall_thickness = ALU_profile_holder_wall_thickness;
    
    difference() {
        ALU_profile_holder();
        
        //díry pro šrouby na uchycení tenzometru
        translate([ALU_profile_width/2+wall_thickness, ALU_profile_width+wall_thickness*2-0.5, (strain_gauge_screw_distance+20)/2-strain_gauge_screw_distance/2]) {
            rotate([90, 0, 0])
            cylinder(d=M4_screw_diameter, h=wall_thickness*4, center=true, $fn=20);
            translate([0, 0, strain_gauge_screw_distance])
                rotate([90, 0, 0])
                    cylinder(d=M4_screw_diameter, h=wall_thickness*4, center=true, $fn=20);
        }
    }
}

888_5001();