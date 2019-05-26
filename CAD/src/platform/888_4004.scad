include <../../parameters.scad>
include <./calculations.scad>
use <../lib/copyFunctions.scad>
use <./888_4003.scad>
use <./888_4005.scad>
use <./888_4006.scad>

draft = true;
$fn = draft ? 20 : 100;

module round_base(draft = true)
{
    difference()
    {
        translate([0, 0, -platform_height/2])
            difference()
            {
                cylinder(h = platform_height/2, d = platform_top_diameter);
                // M6 bolts between round base and car roof platform
                for (i = [1:4])
                {
                    rotate([0, 0, i*90 + 15])
                    {
                        translate([g3_0_srcew_dist, 0, 2 * M6_nut_height])
                            cylinder(h = platform_height, d = M6_nut_diameter, $fn = 6);
                        translate([g3_0_srcew_dist, 0, 0])
                            cylinder(h = platform_height, d = M6_screw_diameter);
                    }
                }
            }
        connecting_holes();
    }
}

difference()
{
    // If not draft -> move to print position.
    if (!draft)
        translate([0, 0, platform_height/2])
            rotate([0, 0, 0])
            {
                round_base(false);
            }
    else
    {
        round_base();
    }
    // Cut-out cube
    if (draft)
        translate([0, 0, -platform_height/4])
            cube([platform_base_diameter*2, platform_base_diameter*2, platform_height]);
}
    // Draft only - top platform visualisation
    #if (draft)
        translate([0, 0, vertical_distance_of_plaftorms - platform_height/2])
            cylinder(h = platform_height, d = platform_top_diameter);
    // Draft only - piston holder visualisation
    #if (draft)
        rotate_copy([0, 0, 120])
            rotate_copy([0, 0, 120])
                beam();
    // Draft only - piston holder visualisation
    #if (draft)
        rotate_copy([0, 0, 120])
            rotate_copy([0, 0, 120])
                piston_holder();
    // Draft only - piston and bearing visualisation
    #if (draft)
        pistons_and_bearing();
