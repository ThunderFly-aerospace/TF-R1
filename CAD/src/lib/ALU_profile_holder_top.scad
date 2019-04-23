include <../../parameters.scad>



module ALU_profile_holder_top() {
    wall_thickness = ALU_profile_holder_wall_thickness;
    
    module screw_holes() {
        translate([wall_thickness/2, 8, ALU_profile_width/2]) {
            rotate([0, 90, 0]) 
                cylinder(d=M6_screw_diameter, h=wall_thickness*2, center=true, $fn=20);
            
            translate([0, 15, 0])
                rotate([0, 90, 0])
                cylinder(d=M6_screw_diameter, h=wall_thickness*2, center=true, $fn=20);
            
        }
    }
    
    difference() {
        cube([ALU_profile_width+wall_thickness*2, ALU_profile_width+wall_thickness*2, ALU_profile_width]);
        translate([wall_thickness, 0, 0])
            cube([ALU_profile_width, ALU_profile_width, ALU_profile_width]);
        
        screw_holes();
        translate([ALU_profile_width+wall_thickness, 0, 0])
            screw_holes();
    }
}

ALU_profile_holder_top();