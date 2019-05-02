include <../../parameters.scad>

module 888_5006() {
    size = 20;
    wall_around_nut = 2;
    difference() {
        hull() {
            cube([M6_square_nut_diameter+wall_around_nut*2, size, M6_square_nut_diameter+wall_around_nut*2]);
            translate([0, size/2, M6_square_nut_diameter+wall_around_nut+M8_screw_diameter/2])
                rotate([0, 90, 0])
                    cylinder(d=M8_screw_diameter+6, h=M6_square_nut_diameter+wall_around_nut*2, $fn=40);
        }
        
        translate([M6_square_nut_diameter/2+wall_around_nut, 0, M6_square_nut_diameter/2+wall_around_nut])
            rotate([-90, 0, 0])
                cylinder(d=M6_screw_diameter, h=size, $fn=20);
        
        translate([-0.1, size/2, M6_square_nut_diameter+wall_around_nut+M8_screw_diameter/2])
            rotate([0, 90, 0])
                cylinder(d=M8_screw_diameter, h=M6_square_nut_diameter+0.2+wall_around_nut*2, $fn=40);
        
        translate([wall_around_nut, -0.1, wall_around_nut])
            cube([M6_square_nut_diameter, M6_square_nut_height+0.1, M6_square_nut_diameter]);
        
        translate([wall_around_nut, size-M6_square_nut_height, wall_around_nut])
            cube([M6_square_nut_diameter, M6_square_nut_height+0.1, M6_square_nut_diameter]);
    }
}

888_5006();