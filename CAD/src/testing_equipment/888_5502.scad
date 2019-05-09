include <../../parameters.scad>
use <888_5007.scad>
use <888_5008.scad>
use <888_5006.scad>
use <888_5009.scad>

translate([-ALU_profile_width/2-ALU_profile_holder_wall_thickness, 0, 0])
    888_5007();

translate([0, 54, 103.5])
    mirror([0, 0, 1])
        color([1, 0, 0]) 888_5008();

translate([-M6_square_nut_diameter/2-2, 44, 75])
    mirror([0, 0, 1])
        888_5006();

translate([0, 54, 120])
    #888_5009();