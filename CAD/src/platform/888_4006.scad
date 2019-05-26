include <../../parameters.scad>
use <../lib/copyFunctions.scad>
include <./calculations.scad>
use <./888_4003.scad>
use <./888_4004.scad>
use <./888_4005.scad>

draft = true;
$fn = draft ? 20 : 100;

module M8x60(draft = true)
{
    // bolt
    cylinder(h = 60 + M8_head_height + 10, d = M8_screw_diameter);
    // head with pocket
    translate([0, 0, -platform_base_diameter/2])
        cylinder(h = platform_base_diameter/2 + M8_head_height, d = M8_head_diameter);
    // nut
    translate([0, 0, 60 + M8_head_height - M8_nut_height - global_clearance])
        cylinder(h = M8_nut_height + global_clearance, d = M8_nut_diameter, $fn=6);
    // nut pocket
    translate([-platform_height, -M8_nut_pocket/2,
               60 + M8_head_height - M8_nut_height - global_clearance])
        cube([platform_height, M8_nut_pocket, M8_nut_height + global_clearance]);
}

module connecting_holes(draft = true)
{
    for (i = [1:3])
    {
        // M8x60 bolt between round base and beams
        rotate([0, 0, i*120])
            translate([0,
                        platform_top_diameter/2 - (60 + M8_head_height)/2,
                        -platform_height/4])
                rotate([90, 90, 180])
                {
                    M8x60();
                }
        // M8x60 bolt between beams and piston holders
        rotate([0, 0, i*120])
            translate([0, platform_base_diameter/2,
                       -platform_height/4])
                rotate([90, 90, 0])
                {
                    M8x60();
                }
    }
}

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

difference()
{
    // If not draft -> move to print position.
    if (!draft)
        translate([0, -platform_base_diameter/2 + piston_holder_size, platform_height/2])
            rotate([0, 0, 0])
            {
                beam(false);
            }
    else
    {
        rotate_copy([0, 0, 120])
            rotate_copy([0, 0, 120])
                beam();
    }
    // Cut-out cube
    if (draft)
        translate([0, 0, -platform_height/4])
            cube([platform_base_diameter*2, platform_base_diameter*2, platform_height]);
}
    // Draft only - platforms visualisation
    #if (draft)
    {
        translate([0, 0, vertical_distance_of_plaftorms - platform_height/2])
            cylinder(h = platform_height, d = platform_top_diameter);
        round_base();
    }
    // Draft only - piston holder visualisation
    #if (draft)
        rotate_copy([0, 0, 120])
        rotate_copy([0, 0, 120])
        piston_holder();
    // Draft only - piston and bearing visualisation
    #if (draft)
        pistons_and_bearing();
