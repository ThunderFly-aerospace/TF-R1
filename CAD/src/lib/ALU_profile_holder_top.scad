include <../../parameters.scad>



module ALU_profile_holder_top(deep=35) {
    wall_thickness = ALU_profile_holder_wall_thickness;
    
    module screw_holes() {
        translate([wall_thickness/2, 8, ALU_profile_width/2]) {
            rotate([0, 90, 0]) 
                cylinder(d=M5_screw_diameter, h=wall_thickness*2, center=true, $fn=20);
        }
        translate([wall_thickness/2, deep-10, ALU_profile_width/2]) {
                rotate([0, 90, 0])
                cylinder(d=M5_screw_diameter, h=wall_thickness*2, center=true, $fn=20);
            
        }
    }
    
    difference() {
        cube([ALU_profile_width+wall_thickness*2, deep+wall_thickness*2, ALU_profile_width]);
        translate([wall_thickness, -0.1, -0.1])
            cube([ALU_profile_width, deep+0.1, ALU_profile_width+0.2]);
        
        screw_holes();
        translate([ALU_profile_width+wall_thickness, 0, 0])
            screw_holes();
    }
}

ALU_profile_holder_top(35);