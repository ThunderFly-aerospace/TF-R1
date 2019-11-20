include <../parameters.scad>
draft = false;
$fn =  draft ? 50 :100;


module 888_3006(draft){    /////// 1. díl (AZ, YAW)

    //lícovaný šroub  M6
    8_shank_diameter = 8.4;		//průměr dříku + tolerance pro díru
    screw_length = 30; // délka lícovaného sroubu
    whole_screw_length = screw_length + 11+6; 		//celková délka
    thread_length = 11;				//délka závitu
    thread_diameter = 6;
    length_screw_behind_nut = 3;
    head_screw_diameter = 13 + 0.2;		//průměr válcové hlavy šroubu
    head_screw_height = 8 + 0.2;		//výška válcové hlavy šroubu
    // pro dily ze skupiny 3 (888_30**)
    g3_0_cone1 = 70;
    g3_0_cone2 = 45;
    g3_0_cone_height = 25;
    g3_0_cone_top_height = 11;
    g3_0_height = 100;
    g3_0_bearing_bolt_len = 50;
    g3_0_srcew_dist = 55;
    height = ALU_profile_width;
    magnet_d = 80;
    carbon_pipe_10_outer_diameter = 10.4;
    platform_height = 52;
    nut_size = 28; //šířka křídel matky na střeše


    difference(){
        union(){

            hull(){
                cylinder(r = g3_0_cone1, h = 5, $fn = draft?50:100);
                translate([0,0, height/2 - 5])
                    cylinder(r = magnet_d/2 , h = 5, $fn=draft?50:100);
            }

            cylinder(r1=g3_0_cone2, r2=g3_0_cone2/4, h=g3_0_height, $fn=draft?50:100);

                for (i = [0:3]){
                    rotate([0, 0, i*90])
                        translate([g3_0_srcew_dist, 0, 30-18-5])
                            cylinder(h=6, d=M6_nut_diameter+5, $fn=50);
                }

        }

        // srouby pri pridelani na strechu
        for (i = [0:3]){
            rotate([0, 0, i*90])
            {
                // Washer
                translate([g3_0_srcew_dist, 0, 0])
                    cylinder(h = M8_washer_thickness, d = 19);
                // Nut hole
                translate([g3_0_srcew_dist, 0, M8_washer_thickness+layer_thickness])
                    cylinder(h = M6_nut_height, d = M6_nut_diameter);
                // Bolt hole
                translate([g3_0_srcew_dist, 0, M8_washer_thickness + M6_nut_height + layer_thickness])
                    cylinder(h = platform_height, d = M6_screw_diameter);

            }
        }


        cylinder(h = 1000, d = carbon_pipe_10_outer_diameter, $fn = draft?50:100);
    }
}

888_3006(draft);
