include <../../parameters.scad>
include <./calculations.scad>
use <../lib/copyFunctions.scad>
use <./888_4003.scad>
use <./888_4004.scad>
use <./888_4005.scad>
use <./888_4006.scad>

draft = true;

difference()
{
    if (!draft)
    {
        round_base(false);
        rotate_copy([0, 0, 120])
            rotate_copy([0, 0, 120])
            {
                piston_holder(false);
                beam(false);
                888_4005(false);
            }
    }
    else
    {
        round_base();
        rotate_copy([0, 0, 120])
            rotate_copy([0, 0, 120])
            {
                piston_holder();
                beam();
            }
        888_4005();
    }
    // Cut-out cube
    if (draft)
        translate([0, 0, -platform_height/4])
            cube(platform_base_diameter*2);
}
    // Draft only - piston and bearing visualisation
    #if (draft)
        pistons_and_bearing();
