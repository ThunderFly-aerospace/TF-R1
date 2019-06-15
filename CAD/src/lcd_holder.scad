$fn = 100;
include <../parameters.scad>

box_width = 185;
box_height = 135;

screw_x = 164.9;
screw_y = 114.96;

outer_width = 172.9 + 3;
outer_height= 124.27+ 3;

view_width = 160-4;
view_height = 90-4;

pcb_thickness = 1.5;
pcb_spacer = 2; // pruzna podlozka pod pcb

layer = 0.2;

module front(){
    difference(){
        hull(){
            translate([-box_width/2, -box_height/2, 1])
                cube([box_width, box_height, 10-1]);
            translate([-(box_width-2)/2, -(box_height-2)/2, 0])
                cube([box_width-2, box_height-2, 10]);
        }

        translate([screw_x/2, screw_y/2, M3_nut_height+layer])
            cylinder(d=M3_screw_diameter, h=11);
        translate([screw_x/2, screw_y/2, -0.1])
            cylinder(d=M3_nut_diameter, h=M3_nut_height);

        translate([screw_x/2, -screw_y/2, M3_nut_height+layer])
            cylinder(d=M3_screw_diameter, h=11);
        translate([screw_x/2, -screw_y/2, -0.1])
            cylinder(d=M3_nut_diameter, h=M3_nut_height);

        translate([-screw_x/2, screw_y/2, M3_nut_height+layer])
            cylinder(d=M3_screw_diameter, h=11);
        translate([-screw_x/2, screw_y/2, -0.1])
            cylinder(d=M3_nut_diameter, h=M3_nut_height);

        translate([-screw_x/2, -screw_y/2, M3_nut_height+layer])
            cylinder(d=M3_screw_diameter, h=11);
        translate([-screw_x/2, -screw_y/2, -0.1])
            cylinder(d=M3_nut_diameter, h=M3_nut_height);

        /* translate([-screw_x/2, screw_y/2 - 58.1, M3_nut_height+layer])
            cylinder(d=M3_screw_diameter, h=11);
        translate([-screw_x/2, screw_y/2 - 58.1, -0.1])
            cylinder(d=M3_nut_diameter, h=M3_nut_height); */


        //middle screw
        /* translate([-screw_x/2+49, screw_y/2, M3_nut_height+layer])
            cylinder(d=M3_screw_diameter, h=11);
        translate([-screw_x/2+49, screw_y/2, -0.1])
            cylinder(d=M3_nut_diameter, h=M3_nut_height);

        translate([screw_x/2-49, screw_y/2, M3_nut_height+layer])
            cylinder(d=M3_screw_diameter, h=11);
        translate([screw_x/2-49, screw_y/2, -0.1])
            cylinder(d=M3_nut_diameter, h=M3_nut_height);

        translate([-screw_x/2+49, -screw_y/2, M3_nut_height+layer])
            cylinder(d=M3_screw_diameter, h=11);
        translate([-screw_x/2+49, -screw_y/2, -0.1])
            cylinder(d=M3_nut_diameter, h=M3_nut_height);

        translate([screw_x/2-49, -screw_y/2, M3_nut_height+layer])
            cylinder(d=M3_screw_diameter, h=11);
        translate([screw_x/2-49, -screw_y/2, -0.1])
            cylinder(d=M3_nut_diameter, h=M3_nut_height); */


        // LCD hole
        translate([-view_width/2+6, -view_height/2+2, -0.1])
            cube([view_width, view_height, 11]);

        translate([-view_width/2+6-5, -view_height/2-9, 0.5])
            cube([view_width+10, view_height+18, 11]);

        translate([-outer_width/2, -outer_height/2, 6.0])
            cube([outer_width, outer_height, 11]);

        translate([-view_width/2+6, -outer_height/2+11.7, 0.5])
            rotate([45, 0, 0])
                cube([130, 15, 15]);

        // connectors
        translate([-box_width/2, outer_height/2-58.5, 6.0])
            cube([15, 48.5, 10]);

        translate([-box_width/2-.1, outer_height/2-58.5, 1.0])
            cube([6, 48.5, 15]);

        translate([0, outer_height/2-13, 0.1])
            rotate([0, 180, 0])
                linear_extrude(height = 0.4)
                    text(text = "ThunderFly", size = 12, halign = "center");

        translate([0, -outer_height/2+1, 0.1])
            rotate([0, 180, 0])
                linear_extrude(height = 0.4)
                    text(text = "TF-R1", size = 5, halign = "center");
    }
}


module back(){
    difference(){
        hull(){
            translate([-box_width/2, -box_height/2, 1])
                cube([box_width, box_height, 15-1]);
            translate([-(box_width-2)/2, -(box_height-2)/2, 0])
                cube([box_width-2, box_height-2, 15]);
        }


        translate([screw_x/2, screw_y/2, M3_nut_height+layer])
            cylinder(d=M3_screw_diameter, h=11);
        translate([screw_x/2, screw_y/2, -0.1])
            cylinder(d=M3_nut_diameter, h=20, $fn=6);

        translate([screw_x/2, -screw_y/2, M3_nut_height+layer])
            cylinder(d=M3_screw_diameter, h=11);
        translate([screw_x/2, -screw_y/2, -0.1])
            cylinder(d=M3_nut_diameter, h=20, $fn=6);

        translate([-screw_x/2, screw_y/2, M3_nut_height+layer])
            cylinder(d=M3_screw_diameter, h=11);
        translate([-screw_x/2, screw_y/2, -0.1])
            cylinder(d=M3_nut_diameter, h=20, $fn=6);

        translate([-screw_x/2, -screw_y/2, M3_nut_height+layer])
            cylinder(d=M3_screw_diameter, h=11);
        translate([-screw_x/2, -screw_y/2, -0.1])
            cylinder(d=M3_nut_diameter, h=20, $fn=6);
/* 
        translate([-screw_x/2, -screw_y/2 + 58.1, M3_nut_height+layer])
            cylinder(d=M3_screw_diameter, h=11);
        translate([-screw_x/2, -screw_y/2 + 58.1, -0.1])
            cylinder(d=M3_nut_diameter, h=20, $fn=6); */


        //middle screw
        /* translate([-screw_x/2+49, screw_y/2, M3_nut_height+layer])
            cylinder(d=M3_screw_diameter, h=11);
        translate([-screw_x/2+49, screw_y/2, -0.1])
            cylinder(d=M3_nut_diameter, h=M3_nut_height, $fn=6);

        translate([screw_x/2-49, screw_y/2, M3_nut_height+layer])
            cylinder(d=M3_screw_diameter, h=11);
        translate([screw_x/2-49, screw_y/2, -0.1])
            cylinder(d=M3_nut_diameter, h=M3_nut_height, $fn=6);

        translate([-screw_x/2+49, -screw_y/2, M3_nut_height+layer])
            cylinder(d=M3_screw_diameter, h=11);
        translate([-screw_x/2+49, -screw_y/2, -0.1])
            cylinder(d=M3_nut_diameter, h=M3_nut_height, $fn=6);

        translate([screw_x/2-49, -screw_y/2, M3_nut_height+layer])
            cylinder(d=M3_screw_diameter, h=11);
        translate([screw_x/2-49, -screw_y/2, -0.1])
            cylinder(d=M3_nut_diameter, h=M3_nut_height, $fn=6); */

        translate([-outer_width/2, -outer_height/2, 15+4-pcb_thickness - 13])
            cube([outer_width, outer_height, 16]);
/*
        for (i=[0, 1, -1, 2, -2, 5, -5, 6, -6, 7, -7]) {
            translate([i*10.16, -outer_height/2+5, 0])
                cylinder(d=M3_screw_diameter, h=10);
            translate([i*10.16, -outer_height/2+5, 5-M3_nut_height])
                cylinder(d=M3_nut_diameter, h=10);
        } */

        sx = view_width/10;
        sy = view_height/5;
        for (x=[0:9]) {
            for (y=[0:4]) {
                translate([x*sx-view_width/2+5, y*sy-view_height/2, -0.1])
                    cube([sx-2, sy-2, 20]);
            }
        }

        // connectors
        translate([-box_width/2 - 0.1, -outer_height/2+10, -0.1])
            cube([20, 48.5, 15+0.2]);

    }

    difference(){
    union(){
        for (i=[[screw_x/2, screw_y/2, 0], [screw_x/2, -screw_y/2, 0], [-screw_x/2, screw_y/2, 0],
            [-screw_x/2, -screw_y/2, 0], [-screw_x/2, -screw_y/2+58.1, 0]]) {
            translate(i){
                difference(){
                    cylinder(d1=15, d2=8, h=15+4-pcb_thickness-pcb_spacer);
                    translate([0, 0, 15-1.4-pcb_thickness])
                        cylinder(d=M3_screw_diameter, h=20);
                    translate([0, 0, -0.1])
                        cylinder(d=M3_nut_diameter, h=15-3, $fn=6);
                }
            }
        }

        translate([-box_width/2+15, -outer_height/2+10, 0])
            cube([20+3-15, 48.5+3, +4.5]);
    }

    translate([-box_width/2 - 0.1, -outer_height/2+10, -0.1])
        cube([20, 48.5, 15+0.2]);
    }
}


//translate([0, 0, -10-10])
//front();
/* translate([0, 0, 10+10])
rotate([180, 0, ])
*/
back();
