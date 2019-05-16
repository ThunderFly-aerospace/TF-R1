use <../lib/naca4.scad>
include <../../parameters.scad>
use <../lib/curvedPipe.scad>
draft = true;
$fs =  draft ? 50 :100;

module 888_3006(draft){

    height = 50;
    magnet_d = 80;
    cylinder_height = magnet_d/2;
    magnet_offset = 35;

    difference(){
        union(){
            hull(){
                cylinder(r = g3_0_cone1, h = 5, $fn = draft?50:100);
                translate([magnet_offset,0, height/2 - 5])
                    cylinder(r = magnet_d/2 , h = 5, $fn=draft?50:100);
            }

            translate([magnet_offset,0, height/2])
                cylinder(r = magnet_d/2 , h = height/2, $fn=draft?50:100);
        }

        translate([magnet_offset,0,0])
            rotate([0,0,45])
                for (i=[0:3]) rotate([0, 0, 90*i]){
                    translate([0, 70/2, 0])
                        cylinder(h = 2*cylinder_height, d = M4_screw_diameter, $fn = 50);

                    translate([0, 70/2, 0])
                       cylinder(h = height - 10, d = M4_nut_diameter, $fn = 6);
                }

        // otvor pro vývody
        translate([magnet_offset,0,0])
            curvedPipe([[- 57/2 ,0,2 * height], [-57/2, 0,height / 2], [-100,0,height / 2]], 2, [20], 8, 0);

        // otvor pro kapsu na matku závitové tyče
        translate([g3_0_srcew_dist, 0, 30-18-5])
            cylinder(h = M6_nut_height + global_clearance, d = M6_nut_diameter, $fn = 6);

        translate([g3_0_srcew_dist, -M6_nut_pocket/2 , 30-18-5])
            cube([100,M6_nut_pocket, M6_nut_height + global_clearance]);

        // srouby pri pridelani na strechu
        for (i = [0:3]){
            rotate([0, 0, i*90])
                translate([g3_0_srcew_dist, 0, -global_clearance])
                    cylinder(h = 100, d = M6_screw_diameter, $fn = 50);
            rotate([0, 0, i*90])
                translate([g3_0_srcew_dist, 0, -global_clearance])
                    cylinder(h=1, d1=M6_screw_diameter+2, d2=M6_screw_diameter, $fn=draft?50:100);
            rotate([0, 0, i*90])
                translate([g3_0_srcew_dist, 0, 30-18-5])
                    rotate([0,0,30])
                        cylinder(h=20, d=M6_nut_diameter, $fn=6);
        }
    }
}

888_3006(draft);
