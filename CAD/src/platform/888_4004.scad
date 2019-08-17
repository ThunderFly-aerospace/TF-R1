include <../../parameters.scad>
include <./calculations.scad>
use <../lib/copyFunctions.scad>
use <./888_4003.scad>
use <./888_4005.scad>
use <./888_4006.scad>

draft = false;
$fn = draft ? 20 : 100;

module camera(camera_xsize = 26, camera_ysize = 26)
{
camera_height = 15; // montážní výška kamery včetně USB konektoru
camera_thickness = 5;   // tloušťka PCB a objektivu kamery
camera_lens_diameter = 16;
camera_screw_lenght = 10;
camera_cable_diameter = 5;

    translate([-camera_xsize/2, -camera_ysize/2,-camera_height])
        cube([camera_xsize, camera_ysize, camera_height]);

    rotate([0,0,180-30])
        translate([0,0,-camera_height])
            cube([platform_top_diameter, camera_cable_diameter, camera_cable_diameter]);

    // otvory pro šrouby kamery
    translate([21/2, 21/2, -camera_thickness])
        bolt(2,length = camera_screw_lenght , pocket = false);
    translate([21/2, -21/2, -camera_thickness])
        bolt(2,length = camera_screw_lenght , pocket = false);
    translate([-21/2, 21/2, -camera_thickness])
        bolt(2,length = camera_screw_lenght , pocket = false);
    translate([-21/2, -21/2, -camera_thickness])
        bolt(2,length = camera_screw_lenght , pocket = false);

    translate([0,0, 0])
        cylinder(d=camera_lens_diameter, h = platform_height);  // otvor pro objektiv


}

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
                    rotate([0, 0, i*90])
                    {
                        // Washer
                        translate([g3_0_srcew_dist, 0, 0])
                            cylinder(h = 2, d = 19);
                        // Nut hole
                        translate([g3_0_srcew_dist, 0, 2])
                            cylinder(h = M6_nut_height, d = M6_nut_diameter);
                        // Bolt hole
                        translate([g3_0_srcew_dist, 0, 0])
                            cylinder(h = platform_height, d = M6_screw_diameter);
                    }
                }
            }
        connecting_holes();
        translate([0, 0,-platform_height/2+15])
            camera();

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
    // Draft only - beams visualisation
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
