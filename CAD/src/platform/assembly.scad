include <../../parameters.scad>
include <./calculations.scad>
use <../lib/copyFunctions.scad>
use <./888_4003.scad>
use <./888_4004.scad>
use <./888_4005.scad>
use <./888_4006.scad>

draft = true;
cut = false;

difference()
{
    union()
    {
        round_base(draft);
        rotate_copy([0, 0, 120])
            rotate_copy([0, 0, 120])
            {
                piston_holder(draft);
                beam(draft);
            }
        888_4005(false);
    }
    // Cut-out cube
    if (cut)
        translate([0, 0, -platform_height/4])
            cube(platform_base_diameter*2);
}
    // Draft only - piston and bearing visualisation
    #if (draft)
        pistons_and_bearing();
