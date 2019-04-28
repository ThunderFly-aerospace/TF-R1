
draft = false;
center_diameter = 140;
center_height = 10;
connecting_module_length = 17;
leg_length = 5;
leg_width = 60;
pitch_bearing = 15;
bearing_angle=5;

//Screw diameter and nut for M6 [mm]
M6_screw_diameter=6.5;
M6_head_diameter = 10+0.5;
M6_head_height = 6;
M6_nut_height = 4.9;
M6_nut_diameter = 11.8;
M6_nut_pocket = 10.4;

//Screw diameter and nut for M4 [mm]
M4_screw_diameter=4.5;
M4_screw_head_height = 4;
M4_nut_height = 3.2;
M4_nut_diameter = 8.4;
M4_nut_pocket = 7.5;

g3_0_srcew_dist = 55;


 //tvorba noh
module connectingpart(){
     for(y=[0:120:240]){
         //připojovací část
         rotate([0,0,y]){
             translate([center_diameter/2-7,-leg_width/2,0])
                 cube([connecting_module_length,leg_width,center_height*2]);
         }
     }
 }

//vytvareni der a stredu
difference(){
    union()
    {
        cylinder(h=center_height,d=center_diameter,$fn=draft?50:100);
        connectingpart();
    }
    for(y=[0:120:240]){
        rotate([0,90,y]){
            translate([-center_height,-15,center_diameter/2-7])
                cylinder(h=M4_nut_height,d=M4_nut_diameter,$fn=6);
            translate([-center_height,-15,center_diameter/2+connecting_module_length/2+1])
                cylinder(h=connecting_module_length*2,d=M4_screw_diameter,center=true,$fn=draft?50:100);
            translate([-center_height,-15,center_diameter/2-7-M4_nut_height])
                cylinder(h=M4_nut_height,d=M4_nut_diameter,$fn=6);

            translate([-center_height,+15,center_diameter/2-7])
                cylinder(h=M4_nut_height,d=M4_nut_diameter,$fn=6);
            translate([-center_height,+15,center_diameter/2+connecting_module_length/2+1])
                cylinder(h=connecting_module_length*2,d=M4_screw_diameter,center=true,$fn=draft?50:100);
            translate([-center_height,15,center_diameter/2-7-M4_nut_height])
                cylinder(h=M4_nut_height,d=M4_nut_diameter,$fn=6);
        }
    }

    mounting_hole();
}

//diry pro pripevneni na strop auta
module mounting_hole()
{
    for (i = [0:3]){
        rotate([0, 0, i*90])
            translate([g3_0_srcew_dist, 0,0])
                cylinder(h = 100, d = M6_screw_diameter, $fn = 50);
        rotate([0, 0, i*90])
            translate([g3_0_srcew_dist, 0,0])
                cylinder(h=1, d1=M6_screw_diameter+2, d2=M6_screw_diameter, $fn=draft?50:100);
        rotate([0, 0, i*90])
            translate([g3_0_srcew_dist, 0, 30-18-5])
                rotate([0,0,30])
                    cylinder(h=20, d=M6_nut_diameter, $fn=6, $fn=6);
    }
}
