include <../../parameters.scad>

ALU_profile_width = 30;
wall_thickness = 2;


module 888_5001() {
    
    //díry na přišroubování k Al profilům
    module screws_holes(diameter) {
        translate([0, 0, 7])
            rotate([90, 0, 90])
                cylinder(d=diameter, h=wall_thickness*2, center=true, $fn=20);
        
        translate([0, 0, strain_gauge_screw_distance+13])
            rotate([90, 0, 90])
                cylinder(d=diameter, h=wall_thickness*2, center=true, $fn=20);
    }
    
    
    difference() {
        cube([ALU_profile_width+wall_thickness*2, ALU_profile_width+wall_thickness*2, strain_gauge_screw_distance+20]);

        translate([wall_thickness, 0, 0])
        cube([ALU_profile_width, ALU_profile_width, strain_gauge_screw_distance+20]);

        //díry pro šrouby na tenzometr
        translate([ALU_profile_width/2+wall_thickness, ALU_profile_width+wall_thickness*2-0.5, (strain_gauge_screw_distance+20)/2-strain_gauge_screw_distance/2]) {
            rotate([90, 0, 0])
            cylinder(d=M4_screw_diameter, h=wall_thickness*4, center=true, $fn=20);
            translate([0, 0, strain_gauge_screw_distance])
                rotate([90, 0, 0])
                    cylinder(d=M4_screw_diameter, h=wall_thickness*4, center=true, $fn=20);
        }
        
        translate([wall_thickness*0.5, ALU_profile_width/2, 0]) {
                #screws_holes(M5_screw_diameter);
                translate([ALU_profile_width+wall_thickness, 0, 0]) {
                    #screws_holes(M5_screw_diameter);
                }
        }
    }
}

888_5001();