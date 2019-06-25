include <../../parameters.scad>
use <../lib/rotor_joint.scad>

module 888_1020(draft = true){


    hall_distance = 35; // distance between axis and magnet

    hall_length = 16;
    hall_length_offset = (11/2-2); // positiv is further from axis
    hall_width = 25+2;
    hall_thickness = 3;

    rotor_axis_diameter = 8.2;


    // 666_1236
    // 666_1007
    // 666_1212
    motor_distance = 79.03; // vzdalenost prerotatoru od hlavni pos_y
    motor_diameter = 35+2;
    motor_axis_diameter = 6.3;
    motor_puller_diameter = 20;
    motor_screw_diameter = M3_screw_diameter;
    motor_mounting_diameter = 25; // vzdalenost protejsich sroubu pro pridelani prerotatoru
    motor_sink = 9.5; // pro zapusteni bez podlozek na motoru...

    plate_overlap =  35; // jak moc velký má být přesah směrem k motoru..

    servo_join_y = 78; // vzdalenost kloubu pro servo
    servo_join_x = 45; // vzdalenost kloubku od osy rotoru
    servo_join_size = 15;

    plate_size_y = 50;
    plate_size_x = plate_overlap + motor_distance + motor_diameter/2;
    plate_size_z = 5;

    plate_bearing_center_distance = 7;


    joint_size_x = 60+0.5; // delka dorazu podle osy x
    joint_size_y = 50+0.5; //delka dorazu podle osy y
    joint_wall_thickness = 4;

    bearing_inner_diameter = 12.2;
    outer_diameter = bearing_efsm_12_d + 3;
    bearing_ball_height = 10.1;
    rim_height = 1;

    back_part_crop = 0;


    joint_size = 20;  //velikost drzaku

    //velikost otvoru pro matku soubu rotoru
    nut_height = 10;
    nut_diameter = 20;

    // pro EFSM-8

    /* bearing_inner_diameter = 8;
    outer_diameter = bearing_efsm_08_d + 3;
    bearing_ball_height = 10.1;
    rim_height = 1; */



      translate([0,0, plate_bearing_center_distance])
        difference(){
            union(){
                hull(){
                    translate([-(joint_size_x + joint_wall_thickness*2)/2 + back_part_crop, -plate_size_y/2, 0])
                        cube([plate_size_x - motor_diameter - back_part_crop, plate_size_y, plate_size_z]);

                    // cast nad motorem
                    translate([motor_distance, 0, 0])
                        cylinder(d = motor_diameter+10, h=plate_size_z, $fn = draft ? 10 : 100);

                    // ramecek pro dil 888_1015
                    translate([-(joint_size_x + joint_wall_thickness*2)/2 + back_part_crop, - (joint_size_y  + joint_wall_thickness*2)/2, -plate_bearing_center_distance])
                        cube([joint_size_x + joint_wall_thickness*2 - back_part_crop, joint_size_y + joint_wall_thickness*2, 7]);

                }
                
                hull() {
                    translate([-(joint_size_x + joint_wall_thickness*2)/2 + back_part_crop, - (joint_size_y  + joint_wall_thickness*2)/2, -plate_bearing_center_distance])
                        cube([joint_size_x + joint_wall_thickness*2 - back_part_crop, joint_size_y + joint_wall_thickness*2, 7]);

                    translate([0, 0 , -plate_bearing_center_distance-joint_size/2])
                        rotor_joint(2, thickness=joint_size);
                }
    // Vymezovaci podlozka pod motor, misto hlinikove 6.5mm silne podlozky
                


                    // Otvory pro pridelani motoru
                    translate([motor_distance, 0, -global_clearance/2])
                        rotate([0,0,45]){
                            for (i=[[0,1],[0,-1],[1,0], [-1,0]]) {
                                translate([i[0]*motor_mounting_diameter/2, i[1]*motor_mounting_diameter/2, -motor_sink]){
                                        cylinder(d2 = M3_screw_diameter*4, d1 = M3_screw_diameter*2, h = motor_sink, $fn = draft?10:60);
                                }
                            }
                        }
            }

            //otvory pro prisroubovani k pripravku
            for(i = [0:90:360]) {
                rotate([0, 0, i])
                translate([(ALU_profile_width/2+ALU_profile_holder_wall_thickness+M4_screw_diameter), (ALU_profile_width/2+ALU_profile_holder_wall_thickness+M4_screw_diameter), 0]) {
                    cylinder(d=M4_screw_diameter, h=300, $fn=20, center=true);
                    cylinder(d=M4_screw_diameter*2, h=200, $fn=20);
                }
            }
            
            //otvor pro matku sroubu rotoru
            translate([0, 0, -joint_size-plate_bearing_center_distance-global_clearance/2])
                cylinder(d=nut_diameter, h=nut_height+global_clearance/2);

            // otvor pro sroub rotoru
            translate([0, 0, -150])
                cylinder(d = rotor_axis_diameter, h = 300, $fn = draft ? 20 : 80);

            // otvor pro osu motoru
            translate([motor_distance, 0, -global_clearance/2-10])
                cylinder(d = motor_axis_diameter, h = plate_size_z + global_clearance + 10, $fn = draft ? 10 : 100);

            // otvor pro  remenici
            translate([motor_distance, 0, -global_clearance/2-10])
                cylinder(d = motor_puller_diameter, h = plate_size_z + global_clearance + 10, $fn = draft ? 10 : 100);


            // Otvory pro pridelani motoru
            translate([motor_distance, 0, -global_clearance/2])
                rotate([0,0,45]){
                    for (i=[[0,1],[0,-1],[1,0], [-1,0]]) {
                        translate([i[0]*motor_mounting_diameter/2, i[1]*motor_mounting_diameter/2, 0]){
                            translate([0,0,-13.3])
                                cylinder(d = motor_screw_diameter, h = plate_size_z + global_clearance + 10, , $fn = draft ? 10 : 50);
                            translate([0,0, plate_bearing_center_distance - 4.7])
                                cylinder(d = M3_nut_diameter, h = M3_screw_head_height, $fn = draft ? 10 : 50);
                        }
                    }
                }


            //Otvor na hallovu sondu
            translate([hall_distance - hall_length/2 + hall_length_offset, -hall_width/2, plate_size_z - hall_thickness])
                cube([hall_length, hall_width, hall_thickness+global_clearance]);


            translate([hall_distance + hall_length/2 + 2, -3,  plate_size_z - hall_thickness+1])
                cube([3, 6, 20]);

            translate([hall_distance + hall_length/2 + 2, -3, - plate_bearing_center_distance])
                translate([0,0, plate_size_z+8])
                    rotate([0,-40,0])
                        translate([0,0,-20])
                            cube([3, 6, 50]);

        }

}
888_1020();