use <../lib/naca4.scad>
include <../../parameters.scad>
draft = true;
$fs =  draft ? 50 :100;

module 888_4005(draft){

    height = 30;
    magnet_d = 80;
    cylinder_height = magnet_d/2;
    magnet_offset = 0;
    piston_mount_distance = 20;

    difference(){
        union(){
            hull(){
                cylinder( d1 = magnet_d * 1.8, d2 = magnet_d * 1.5, h = 20, $fn = draft?50:100);
                translate([magnet_offset,0, height - 5])
                    cylinder(d = magnet_d , h = 5, $fn=draft?50:100);
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
            translate([- 57/2, 0, 0])
                cylinder(h = 100, d = 8, $fn = 50);

        // srouby pri pripevneni pneumatickych valcu
       % for (i = [0:2]){
            rotate([0, 0, i*120])
                translate([magnet_d * 1.5, 0, -global_clearance])
                    cylinder(h = 100, d = M6_screw_diameter, $fn = 50);
            rotate([0, 0, i*120])
                translate([magnet_d * 1.5, 0, 30-18-5])
                    rotate([0,0,30])
                        cylinder(h=50, d=M6_nut_diameter, $fn=6);
        }

       % for (i = [0:2]){
            rotate([0, 0, i*120 + piston_mount_distance])
                translate([magnet_d * 1.5, 0, -global_clearance])
                    cylinder(h = 100, d = M6_screw_diameter, $fn = 50);
            rotate([0, 0, i*120])
                translate([magnet_d * 1.5, 0, 30-18-5])
                    rotate([0,0,30])
                        cylinder(h=20, d=M6_nut_diameter, $fn=6);
        }
    }
}

888_4005(draft);
