include <../../parameters.scad>
include <./calculations.scad>
use <../lib/copyFunctions.scad>

draft = false;
$fn = draft ? 20 : 100;

module 888_4005(draft = true){

    height = 30;
    magnet_d = 80;
    cylinder_height = magnet_d/2;
    magnet_offset = 38;
    fixing_distance = 20;

    difference()
    {
        translate([0, 0, vertical_distance_of_plaftorms - 10])
            difference()
            {
                union()
                {
                    // válec zkosit o úhel odpovídající správnému
                    // úhlu šroubu kulového kloubu
                    cylinder(d1 = platform_top_diameter,
                             d2 = platform_top_diameter - 10,
                             h = 20);

                    hull()
                    {
                        // válec zkosit o úhel odpovídající správnému
                        // úhlu šroubu kulového kloubu
                        translate([0, 0, 5])
                        cylinder(d1 = platform_top_diameter - 10,
                                 d2 = platform_top_diameter - 10,
                                 h = 15);
                        rotate([0,0,30])        // otočení do přední části platformy
                            translate([magnet_offset,0, height - 1])
                                cylinder(d = magnet_d , h = 1);
                    }
                    //rotate([0,0,30])        // otočení do přední části platformy
                    //    translate([magnet_offset,0, height/2])
                    //        #cylinder(r = magnet_d/2 , h = height/2);
                }
                rotate([0,0,30])        // otočení do přední části platformy
                    translate([magnet_offset,0,0])
                        rotate([0,0,45])
                            for (i=[0:3]) rotate([0, 0, 90*i]){
                                translate([0, 70/2, height - 10 + layer_thickness])
                                    cylinder(h = 2*cylinder_height, d = M4_screw_diameter);

                                translate([0, 70/2, 0])
                                   cylinder(h = height - 10, d = M4_nut_diameter, $fn = 6);
                            }

                // otvor pro vývody
                translate([magnet_offset,0,0])
                    translate([- 57/2, 0, 0])
                        cylinder(h = 100, d = 8);
            }
        // Cut-out for piston bolts
        pistons_and_bearing();
    }
}


difference()
{
    // If not draft -> move to print position.
    if (!draft)
        translate([0, 0, -vertical_distance_of_plaftorms + 10])
            rotate([0, 0, 0])
            {
                888_4005(false);
            }
    else
    {
        888_4005();
    }
    // Cut-out cube
    if (draft)
        translate([0, 0, vertical_distance_of_plaftorms])
            cube([platform_base_diameter*2, platform_base_diameter*2, platform_height]);
}
    // Draft only - piston and bearing visualisation
    #if (draft)
        pistons_and_bearing();
