include <../../parameters.scad>

module ALU_profile_holder_side(height) {
    wall_thickness = ALU_profile_holder_wall_thickness;
    
    //díry na přišroubování k Al profilům
    module screws_holes(diameter) {
        translate([0, 0, 7])
            rotate([90, 0, 90])
                cylinder(d=diameter, h=wall_thickness*2, center=true, $fn=20);
        
        translate([0, 0, height-7])
            rotate([90, 0, 90])
                cylinder(d=diameter, h=wall_thickness*2, center=true, $fn=20);
    }
    
    difference() {
        cube([ALU_profile_width+wall_thickness*2, ALU_profile_width + wall_thickness*2, height]);

        translate([wall_thickness, -0.1, -0.1])
            cube([ALU_profile_width, ALU_profile_width + 0.1, height + 0.2]);
        
        translate([wall_thickness*0.5, ALU_profile_width/2, 0]) {
            screws_holes(M5_screw_diameter);
            translate([ALU_profile_width+wall_thickness, 0, 0]) {
                screws_holes(M5_screw_diameter);
            }
        }
    }
}

ALU_profile_holder_side(30);