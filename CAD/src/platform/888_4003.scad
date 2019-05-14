include <../../parameters.scad>
draft = false;
center_diameter = 140;
center_height = 10;
connecting_module_length = 17;
//distance_bearing = 180;

leg_width = 60;
pitch_bearing = 15;
//bearing_angle_side=5;
//bearing_angle_inner=-2;
pad_bearing_height = M5_head_height+10;

module 888_4003(distance_bearing,bearing_angle_side,bearing_angle_inner,min_pad_bearing_height){
    //spojovaci cast mezi loziskem a pripojovaci casti
    distance = distance_bearing-center_diameter/2 - connecting_module_length*2 -7;
    translate([0,-leg_width/2,0])
        cube([distance-35,leg_width,center_height/2]);

    //pripojovací část
    difference(){
        translate([-connecting_module_length,-leg_width/2,0])
            cube([connecting_module_length,leg_width,center_height*2]);

        translate([-connecting_module_length/2,15,center_height])
            rotate([0,90,0]){
                cylinder(h=connecting_module_length*2,d=M4_screw_diameter,center=true);
            }
        translate([-connecting_module_length/2,-15,center_height])
            rotate([0,90,0]){
                cylinder(h=connecting_module_length*2,d=M4_screw_diameter,center=true);
            }
    }
    difference(){
        //základna
        translate([distance+35-70,-leg_width/2,0])
            cube([70,leg_width,pad_bearing_height+min_pad_bearing_height]);

        //naklon
        rotate([bearing_angle_side,bearing_angle_inner,0]){
            translate([distance+35-70,-bearing_angle_side/2-leg_width/2,M5_head_height+min_pad_bearing_height])
                cube([70+2,leg_width/2+bearing_angle_side,center_height*2]);
        }
        //naklon
        rotate([-bearing_angle_side,bearing_angle_inner,0]){
            translate([distance-70+35,-bearing_angle_side/2,M5_head_height+min_pad_bearing_height])
                cube([70+2,leg_width/2+bearing_angle_side,center_height*2]);
        }
        connecting_bearing_hole();
    }
    // diry pro pripojeni lozisek
    module connecting_bearing_hole(y){
        //jedna strana
        rotate([-bearing_angle_side,bearing_angle_inner,0]){
            translate([distance-18,pitch_bearing,0])
                cylinder(h=center_height*10,d=M5_screw_diameter,$fn=draft?50:100);
            translate([distance-18,pitch_bearing,-1])
                cylinder(h=M5_head_height+min_pad_bearing_height/2,d=M5_nut_diameter,$fn=6);

            translate([distance+18,pitch_bearing,0])
                cylinder(h=center_height*10,d=M5_screw_diameter,$fn=draft?50:100);
            translate([distance+18,pitch_bearing,-3])
                cylinder(h=M5_head_height+min_pad_bearing_height/2,d=M5_nut_diameter,$fn=6);
                //zde upravit na základě prohlubně pro pripojovaci sroub z pistu
            translate([distance,pitch_bearing,M5_head_height+min_pad_bearing_height-6])
                cylinder(h = 6, d = M6_nut_diameter+3,$fn=draft?50:100);
        }
        //druha strana
        rotate([bearing_angle_side,bearing_angle_inner,0]){
            translate([distance-18,-pitch_bearing,0])
                cylinder(h=center_height*10,d=M5_screw_diameter,$fn=draft?50:100);
            translate([distance-18,-pitch_bearing,-1])
                cylinder(h=M5_head_height+min_pad_bearing_height/2,d=M5_nut_diameter,$fn=6);

            translate([distance+18,-pitch_bearing,-3])
                cylinder(h=M5_head_height+min_pad_bearing_height/2,d=M5_nut_diameter,$fn=6);
            translate([distance+18,-pitch_bearing,0])
                cylinder(h=center_height*10,d=M5_screw_diameter,$fn=draft?50:100);
        //zde upravit na základě prohlubně pro pripojovaci sroub z pistu
            translate([distance,-pitch_bearing,M5_head_height+min_pad_bearing_height-6])
                cylinder(h = 6, d = M6_nut_diameter+3,$fn=draft?50:100);
        }
    }
}

888_4003(180,5,-2,3);
