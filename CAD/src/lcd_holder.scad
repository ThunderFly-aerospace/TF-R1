include <Parameters.scad>

box_width = 185;
box_height = 135;

screw_x = 164.9;
screw_y = 114.96;

outer_width = 172.9 + 1;
outer_height= 124.27+ 1;

view_width = 160;
view_height = 90;

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

        translate([-screw_x/2, screw_y/2 - 58.1, M3_nut_height+layer])
            cylinder(d=M3_screw_diameter, h=11);
        translate([-screw_x/2, screw_y/2 - 58.1, -0.1])
            cylinder(d=M3_nut_diameter, h=M3_nut_height);


        //middle screw
        translate([-screw_x/2+49, screw_y/2, M3_nut_height+layer])
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
            cylinder(d=M3_nut_diameter, h=M3_nut_height);


        // LCD hole
        translate([-view_width/2+6, -view_height/2, -0.1])
            cube([view_width, view_height, 11]);

        translate([-view_width/2+6-4, -view_height/2-7, 0.5])
            cube([view_width+8, view_height+14, 11]);

        translate([-outer_width/2, -outer_height/2, 6.0])
            cube([outer_width, outer_height, 11]);

        // connectors
        translate([-box_width/2, outer_height/2-45, 6.0])
            cube([15, 35, 10]);

        translate([-box_width/2, outer_height/2-45, 1.0])
            cube([6, 35, 15]);
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

        translate([-screw_x/2, -screw_y/2 + 58.1, M3_nut_height+layer])
            cylinder(d=M3_screw_diameter, h=11);
        translate([-screw_x/2, -screw_y/2 + 58.1, -0.1])
            cylinder(d=M3_nut_diameter, h=20, $fn=6);


        //middle screw
        translate([-screw_x/2+49, screw_y/2, M3_nut_height+layer])
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
            cylinder(d=M3_nut_diameter, h=M3_nut_height, $fn=6);

        translate([-outer_width/2, -outer_height/2, 15+4-pcb_thickness - 13])
            cube([outer_width, outer_height, 16]);

        for (i=[0, 1, -1, 2, -2, 5, -5, 6, -6, 7, -7]) {
            translate([i*10.16, -outer_height/2+5, 0])
                cylinder(d=M3_screw_diameter, h=10);
            translate([i*10.16, -outer_height/2+5, 5-M3_nut_height])
                cylinder(d=M3_nut_diameter, h=10);
        }

        sx = view_width/10;
        sy = view_height/5;
        for (x=[0:9]) {
            for (y=[0:4]) {
                translate([x*sx-view_width/2+5, y*sy-view_height/2, -0.1])
                    cube([sx-2, sy-2, 20]);
            }
        }

        // connectors
        translate([-box_width/2, -outer_height/2+10, 0])
            cube([15, 35, 15]);
    }


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
    }
}


//translate([0, 0, -10-10])
front();
//translate([0, 0, 10+10])
//rotate([180, 0, 0])
//back();
