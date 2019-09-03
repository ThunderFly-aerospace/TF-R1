include <../../parameters.scad>
include <./calculations.scad>
use <../lib/copyFunctions.scad>
use <./888_4004.scad>
use <./888_4005.scad>
use <./888_4006.scad>

draft = true;
$fn = draft ? 20 : 100;

module piston_base_cut_out(draft = true)
{
    mirror_copy()
        rotate([0, 0, -piston_base_offset_angle])
            translate([0, platform_base_diameter/2, 0])
                rotate([90 - vertical_piston_angle, 0,
                        horizontal_piston_angle])
                {
                        translate([-platform_base_cylinder_spacing*0.75,
                                   -bearing_length/2 - global_clearance, 0])
                            cube([platform_base_cylinder_spacing*3,
                                  platform_base_cylinder_spacing*3,
                                  platform_cylinder_medium_length/3]);
                    // Piston bolt
                    translate([0, 0, -bearing_length])
                        cylinder(h = 2*bearing_length, d = 19.5 + global_clearance);
                    // M5 Bearing bolts
                    mirror_copy([0, 1, 0])
                    {
                        translate([0, -bearing_bolt_distance/2, -30])
                        {
                            // bolt
                            cylinder(h = bearing_length, d = M5_screw_diameter);
                            // nut
                            translate([0, 0, 20])
                                cylinder(h = M5_nut_height + global_clearance,
                                         d = M5_nut_diameter, $fn = 6);
                            // nut pocket
                            translate([0, -M5_nut_diameter/2 + global_clearance, 20])
                                cube([50, M5_nut_pocket,
                                      M5_nut_height + global_clearance]);
                        }
                    }
                }
}

module piston_holder(draft = true)
{
    difference()
    {
        mirror_copy()
            // piston holder
            translate([0, platform_base_diameter/2 + bearing_length/2 - piston_holder_size,
                       -platform_height/2])
                cube([platform_base_cylinder_spacing,
                      piston_holder_size,
                      platform_height]);
        difference(){
            piston_base_cut_out();
            translate([-5, platform_base_diameter/3, -platform_height/2]) cube([10, 100, platform_height/2]);
        }
        connecting_holes();
        cylinder(h = platform_height, d = platform_base_diameter - piston_holder_size/2);
    }
}

difference()
{
    // If not draft -> move to print position.
    if (!draft)
        translate([0, -platform_base_diameter/2, platform_height/2])
            rotate([0, 0, 0])
            {
                piston_holder(false);
            }
    else
    {
        rotate_copy([0, 0, 120])
            rotate_copy([0, 0, 120])
                piston_holder();
    }
    // Cut-out cube
    #if (draft)
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
    // Draft only - beams visualisation
    #if (draft)
        rotate_copy([0, 0, 120])
            rotate_copy([0, 0, 120])
                beam();
    // Draft only - piston and bearing visualisation
    #if (draft)
        pistons_and_bearing();
