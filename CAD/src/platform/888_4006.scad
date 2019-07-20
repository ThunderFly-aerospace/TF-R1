include <../../parameters.scad>
use <../lib/copyFunctions.scad>
use <../lib/stdlib/bolts.scad>
use <../lib/print.scad>
include <./calculations.scad>
use <./888_4003.scad>
use <./888_4004.scad>
use <./888_4005.scad>

draft = true;
$fn = draft ? 20 : 100;

module beam(draft = true)
{
    difference()
    {
        mirror_copy()
            difference()
            {
                translate([0, 0, -platform_height/2])
                    cube([platform_base_cylinder_spacing,
                          platform_base_diameter/2 + bearing_length/2
                          - piston_holder_size,
                          platform_height/2]);
                translate([0, 0, -platform_height/2])
                    cylinder(h = platform_height, d = platform_top_diameter);
            }
        piston_base_cut_out();
        connecting_holes();
    }
}

print(draft, [0, -platform_base_diameter/2 + piston_holder_size, platform_height/2])
{
    beam();
    rotate([0, 0, 120])
        rotate_copy([0, 0, 120])
            beam();
    rotate_copy([0, 0, 120])
        rotate_copy([0, 0, 120])
            piston_holder();
    pistons_and_bearing();
    888_4005();
    round_base();
    translate([0, 0, -platform_height/4])
        cube([platform_base_diameter*2, platform_base_diameter*2, platform_height]);
}
