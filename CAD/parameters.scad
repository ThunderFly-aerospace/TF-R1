
//Main tube diameter - hole [mm]
main_tube_outer_diameter = 25.4;
main_tube_inner_diameter = 23.05;

//Tube for undercarriage - rendered hole [mm]
tube_for_undercarriage_outer_diameter = 10.6;
tube_for_undercarriage_inner_diameter = 6;
global_clearance = 0.5;


// Nastavení parametrů rotoru

gliding_aggle = 14;         // tenhle úhel by se zřejmě v budoucnu měl počítat z požadované klouzavosti.


rotor_blade_AOA = 1.5;      // nastavení úhlu náběhu rotorového listu
rotor_blade_length = 970;   // délka rotorového listu
rotor_blade_depth = 50;     // hloubka rotorového listu

// nastavení parametrů motoru

engine_angle = -8;
engine_diameter = 55;
engine_offset = 55;

engine_screws_radius = 15;
engine_holes_radius = (24 + 44)/4;
engine_shatf_hole_diameter = 13;

// Parameters of tube couplings
coupling_wall_thickness = main_tube_outer_diameter/5;  //width of coupling walls
thickness_between_tubes = main_tube_outer_diameter/10;    // minimum distance between tubes in couplings

coupling_wall_thickness_undercarriage = tube_for_undercarriage_outer_diameter/3;
thickness_between_tubes_undercarriage = tube_for_undercarriage_outer_diameter/10;

608_bearing_outer_diameter = 22.3;
608_bearing_thickness = 7.1;


// screw length step - minimum difference in length between two types of screws
basic_screw_length = 5;


//Screw diameter and nut for M10 [mm]
M10_screw_diameter=10.4;
M10_head_height = 10;
M10_head_diameter = 16+0.5;
M10_nut_height = 10.5;
M10_nut_diameter = 25.5;
M10_nut_pocket = 22.3;

//Screw diameter for M8 [mm]
M8_screw_diameter = 8 + 1;
M8_head_height = 8;
M8_head_diameter = 13.5;
M8_nut_height = 7.5;
M8_nut_diameter = 14.4 + 0.5;
M8_nut_pocket = 13 + 0.5;

//Screw diameter and nut for M6 [mm]
M6_screw_diameter=6.5;
M6_head_diameter = 10+0.5;
M6_head_height = 6;
M6_nut_height = 4.9;
M6_nut_diameter = 11.8;
M6_nut_pocket = 10.4;

//Screw diameter and nut for M5 [mm]
M5_screw_diameter=5.5;
M5_head_height = 5;
M5_head_diameter = 13+0.5;
M5_nut_height = 4.5;
M5_nut_diameter = 9.4;
M5_nut_pocket = 8.4;

//Screw diameter and nut for M4 [mm]
M4_screw_diameter=4.5;
M4_screw_head_height = 4;
M4_nut_height = 3.2;
M4_nut_diameter = 8.4;
M4_nut_pocket = 7.5;

//Screw diameter and nut for M3 [mm]
M3_screw_diameter = 3.2;
M3_nut_height = 2.7;
M3_nut_diameter = 6.6;
M3_screw_head_height = 3;

//Screw diameter and nut for M2,5 [mm]
M2_5_screw_diameter = 2.7;
M2_5_nut_height = 2.3;
M2_5_nut_diameter = 6;
M2_5_nut_pocket = 5.5;


//šroub servo
Servo_screw = 1.5;

//The tube for help
Help_main_tube_outer = 25;
Help_main_tube_inner = 23;
Help_tube_for_undercarriage_outer = 10;
Help_tube_for_undercarriage_inner = 5;


//main hull parameters

hull_drop_length = 580;
hull_wall_thickness = 0.8;
hull_y_size = 120;
hull_z_size = 150;
hull_x_size = 580;
hull_corner_radius = 4;
hull_airfoil_thickness= 35;  // thickness of drop generating airfoil in percent of length.
hull_scale_x = 1;
hull_scale_y = 1.5;
hull_scale_z = 1.5;

main_pilon_position = 170+68+30;       // pozice rotorového pilonu měřená od přední části krytu
cover_pilon_position = 180;
height_of_vertical_tube = 275; //278mm je změřená délka trubky.

//délka hlavní dlouhé trubky
length_of_main_tube = 820;
length_of_undercarriage_tube = 300;

ribbon_width = 5; // šířka vyztužovacích lemů.

// šířka otvoru v přední části kapoty pro držák motoru.
width_of_engine_holder = 63;

//Top Cover Division - dělení horního krytu pro tisk
top_cover_division = [0, 50, 150, 280, 410, hull_x_size]; // upraveny seznam tak, aby deleni začinalo od nuly, což umožňí úplně automatické rozdělení.

//Bottom Cover Division - dělení dolního krytu pro tisk
bottom_cover_division = [0,100,232.5,365, 470, hull_x_size];
// zkrácená část pro payload pro testovací tisk
//bottom_cover_division = [0,200,250,365, 470, hull_x_size];




rotor_height = height_of_vertical_tube + main_tube_outer_diameter/2 + 2*global_clearance + thickness_between_tubes + 30; // změřená výška rotoru je 367mm
center_of_gravity_position = [main_pilon_position - tan(gliding_aggle)*rotor_height, 0, 0];



//Cover pilon division - na výšku (v ose Z)
cover_pilon_division = [0,170,height_of_vertical_tube + main_tube_outer_diameter + coupling_wall_thickness];

//pozice šroubů
	//horní kryt
top_screw_position = [0,
                    (top_cover_division[0] + top_cover_division[1])/2,
                    (top_cover_division[2] - top_cover_division[1])/2 + top_cover_division[1],
                    (top_cover_division[3] - top_cover_division[2])/2 + top_cover_division[2],
                    (top_cover_division[4] - top_cover_division[3])/8 + top_cover_division[3],
                    (top_cover_division[5] - top_cover_division[4])/2 + top_cover_division[4] - top_cover_division[1]/3];
	//spodní kryt
bottom_screw_position = [0,
                        (bottom_cover_division[0] + bottom_cover_division[1])*(2/6),
                        bottom_cover_division[1]*(9/10),
                        bottom_cover_division[3] + bottom_cover_division[1]*(1/10),
                        bottom_cover_division[3] + bottom_cover_division[1]*(3/5)];




//šířka zámků
lock_width = 10;

//délka zámků
lock_length = 3;


//accumulator
//základní rozměry akumulátoru
width_of_accumulator = 129.4;//45+1;
depth_of_accumulator = 40.61;
height_of_accumulator = 43.65;
//Zapuštění akumulátoru
sink_of_accumulator = 5; //main_tube_outer_diameter/5 - M3_nut_height*1.5;

//tloušťka hrany spojky
accumulator_holder_width = 18;
accumulator_holder_thickness = 10;

//posunutí akumálátoru na podložce
move_of_accumulator = 75;   // pozice akumulátoru (ovlivňuje těžiště)


////////////////
// Senzory
///////////////////

//opticalFlow
width_optical_flow_senzor = 45.5;
depth_optical_flow_senzor = 6;
height_optical_flow_senzor = 35;
sink_of_optical_flow_senzor = depth_optical_flow_senzor - 5;
M3_optical_flow_senzor_Z = 30.4;
M3_optical_flow_senzor_X = 24;
M3_optical_flow_senzor_Z_alone = 9.1;
M3_optical_flow_senzor_X_alone = 16.7;

//GPS anténa
GPS_outer_length = 48.01;   //Vnější rozměr
GPS_inner_length = 37.48;   //Vnitřní rozměr
GPS_diameter = (GPS_outer_length - GPS_inner_length)/2;    //Průměr otvoru
GPS_middle_length = GPS_diameter + GPS_inner_length;      //Střední rozměr


////podzvozek

radius_undercarriage = 25;
vzdalenost_x = tan(20) * 131;
vzdalenost_y = (131 - radius_undercarriage)/tan(79);
uhel_y = 90 - 20;
uhel_x = 90 - 79;

maximum_printable_size = 150;


////Pitotova trubice
Pitot_tube_diameter = 4.02 + 1;
Distance_hole_from_tube = 11.92;  //vzdálenost otvoru pro připevnění od samotné trubičky


////směrové kormidlo
Rudder_length = 4*main_tube_outer_diameter;
Rudder_height = 2*main_tube_outer_diameter;
Rudder_depth = main_tube_outer_diameter/2;
gap_width = 2*hull_wall_thickness;      //šířka mezery mezi směrovkou a ocasní plochou
ruder_shaft_diameter = 2.6; //otočné uchycení směrovky - průměr 2 mm


/////spojka 666_1004

    width_666_1004 = (main_tube_outer_diameter+2*coupling_wall_thickness - M3_screw_head_height)/basic_screw_length;
//        echo("width_666_1004 is", width_666_1004);

//        echo("ceil_666_1004 is", ceil(width_666_1004));

    coupling_screw_length_666_1004 = (ceil(width_666_1004)) * basic_screw_length;
        echo("coupling_screw_length_666_1004 is", coupling_screw_length_666_1004);

    coupling_width_666_1004 = coupling_screw_length_666_1004 + M3_screw_head_height;
//        echo("coupling_width_666_1004 is", coupling_width_666_1004);

    height_666_1004 = coupling_width_666_1004;
//        echo("height_666_1004 is", height_666_1004);

    depth_666_1004 = main_tube_outer_diameter*2+2*coupling_wall_thickness+thickness_between_tubes;
//        echo("depth_666_1004 is", depth_666_1004);

    depth_666_1004_drillhelper = main_tube_outer_diameter*3;

/////spojka 666_1026



    width_666_1026 = main_tube_outer_diameter + 2*thickness_between_tubes;

    depth_666_1026 = (main_tube_outer_diameter*2)/basic_screw_length;
//        echo("depth_666_1026 is", depth_666_1026);

//        echo("ceil_666_1026 is", ceil(depth_666_1026));

    coupling_screw_length_666_1026 = (ceil(depth_666_1026)) * basic_screw_length;
        echo("coupling_screw_length_666_1026 is", coupling_screw_length_666_1026);


    thickness_of_plate = coupling_screw_length_666_1026 - M4_screw_head_height - 50; //50 mm je konstatní šířka spojky 666_1026
    echo("thickness_of_plate is", thickness_of_plate);

    coupling_depth_666_1026 = coupling_screw_length_666_1026 - M4_screw_head_height - thickness_of_plate;      //zde je odečten M4_screw_head_height pro určení šířky, tak aby šroub přesahoval pro potřebnou matku
//        echo("coupling_depth_666_1026 is", coupling_depth_666_1026);

    height_666_1026 = 2*main_tube_outer_diameter;
//        echo("height_666_1026 is", height_666_1026);

//tloušťka plechu pro zajištění konstatní šířky spojky 50 mm

    width_666_1026_drillhelper = main_tube_outer_diameter*2;

    depth_666_1026_drillhelper = main_tube_outer_diameter + 4*thickness_between_tubes;


////spojka 666_1017

    width_666_1017 = (main_tube_outer_diameter + 4*coupling_wall_thickness - M3_screw_head_height)/basic_screw_length;
//        echo("width_666_1017 is", width_666_1017);

//        echo("ceil_666_1017 is", ceil(width_666_1017));

    coupling_screw_length_666_1017 = (ceil(width_666_1017)) * basic_screw_length;
        echo("coupling_screw_length_666_1017 is", coupling_screw_length_666_1017);

    coupling_width_666_1017 = coupling_screw_length_666_1017 + M3_screw_head_height;
//        echo("coupling_width_666_1017 is", coupling_width_666_1017);

    depth_666_1017 = coupling_width_666_1017;

    height_666_1017= 70; //main_tube_outer_diameter*1.8+main_tube_outer_diameter+wall_thickness;

    width_666_1017_drillhelper = main_tube_outer_diameter+4*thickness_between_tubes;

    depth_666_1017_drillhelper = main_tube_outer_diameter*2;


////spojka 666_1014

    width_666_1014 = tube_for_undercarriage_outer_diameter + 2*coupling_wall_thickness_undercarriage;

    depth_666_1014 = tube_for_undercarriage_outer_diameter + M3_screw_diameter + 2*coupling_wall_thickness_undercarriage + thickness_between_tubes_undercarriage;

    height_666_1014 = width_666_1014;


    width_666_1014_drillhelper = 2*tube_for_undercarriage_outer_diameter + 2*coupling_wall_thickness_undercarriage;



////spojka 666_1015

    width_666_1015 = tube_for_undercarriage_outer_diameter + 2*coupling_wall_thickness_undercarriage;

    depth_666_1015 = tube_for_undercarriage_outer_diameter*2 + 2*coupling_wall_thickness_undercarriage + thickness_between_tubes_undercarriage;

    height_666_1015 = width_666_1015;


    width_666_1015_drillhelper = 2*tube_for_undercarriage_outer_diameter + 2*coupling_wall_thickness_undercarriage;

////spojka 666_1016

    width_666_1016 = tube_for_undercarriage_outer_diameter + 2*coupling_wall_thickness_undercarriage;

    depth_666_1016 = tube_for_undercarriage_outer_diameter + M6_screw_diameter + 2*coupling_wall_thickness_undercarriage + thickness_between_tubes_undercarriage;

    height_666_1016 = width_666_1016;


    width_666_1016_drillhelper = 2*tube_for_undercarriage_outer_diameter + 2*coupling_wall_thickness_undercarriage;




//umístění podvozkových trubek

second_undercarriage_hole =height_666_1026 + height_666_1004/2 + 170 + 160;


//Base Divison - dělení podložky
base_division = [0, 159, main_pilon_position + coupling_width_666_1017/2 + global_clearance/2, second_undercarriage_hole + coupling_width_666_1004/2 + global_clearance/2, hull_x_size];

// šrouby pro připevnění podložky k hlavní trubce
base_mounting_screw_length = 50;


// kulove lozisko

bearing_efsm_08_h = 33+1;
bearing_efsm_08_m = 22;
bearing_efsm_08_db = 18;
bearing_efsm_08_ag = 10.5;
bearing_efsm_08_n = M4_screw_diameter;
bearing_efsm_08_a1 = 5.5;
bearing_efsm_08_d = 8.25;
bearing_efsm_08_B = 8; // ball height

bearing_efsm_10_h = 38+1;
bearing_efsm_10_m = 26;
bearing_efsm_10_db = 21.9;
bearing_efsm_10_ag = 12+0.2;
bearing_efsm_10_n = M5_screw_diameter;
bearing_efsm_10_a1 = 6.5;
bearing_efsm_10_d = 10.25;


bearing_efsm_12_width = 40+1;
bearing_efsm_12_h = bearing_efsm_12_width;
bearing_efsm_12_boltd = 28/2; // polovina vzdalenosti mezi srouby
bearing_efsm_12_m = bearing_efsm_12_boltd*2;
bearing_efsm_12_db = 25;
bearing_efsm_12_ag = 13;
bearing_efsm_12_a1 = 7;
bearing_efsm_12_n = M5_screw_diameter;
bearing_efsm_12_d = 12.15;
bearing_efsm_12_B = 10; // ball height
bearing_efsm_space = 1;

bearing_efsm_17_width = 54+1;
bearing_efsm_17_h = bearing_efsm_17_width;
bearing_efsm_17_boltd = 38/2; // polovina vzdalenosti mezi srouby
bearing_efsm_17_m = bearing_efsm_17_boltd*2;
bearing_efsm_17_db = 35;
bearing_efsm_17_ag = 18;
bearing_efsm_17_n = M6_screw_diameter;
bearing_efsm_17_a1 = 10;
bearing_efsm_17_B = 17; // ball height


// 20 KG servo parameters


servo_20kg_axis_offset = 9.375; // jak je osa mimo stredu
servo_20kg_body_x = 42;
servo_20kg_body_y = 21;
servo_20kg_body_z = 40;
servo_20kg_thread_x = 49/2;
servo_20kg_thread_y = 10/2;
servo_20kg_body_below = 10; // jak hluboko je tělo serva pod drzaky na srouby
servo_20kg_below = 25.8; // jak hluboko je páka serva pod drzaky na srouby

servo_20kg_bolt_d = 2.5+0.3;
servo_20kg_nut_d = 5+0.3;



//  888_2***
//    G2
//


g2_0_part_space = 2; // mezera mezi zadni a predni casti

g2_5_height = 608_bearing_outer_diameter*1.5;
g2_5_width = 70+5.5+11;
g2_5_threads = 2; // kolik ma byt sroubu skrz nosnou tyc

g2_5_m3_length = base_mounting_screw_length; // sroub, ktery se pouziva na sesroubovani s nosnou tyci
g2_5_servo_shift = 30;
g2_5_servo_wall = 5;

g2_5_m8_length = 60; // sroub, ktery se pouziva jako osa pro podlozku
g2_5_front_l = main_tube_outer_diameter + 608_bearing_outer_diameter*2;// jak moc ma byt magnet v predu

g2_5_zapusteni_serva = 30;
g2_5_length = g2_5_zapusteni_serva + 2*main_tube_outer_diameter + 30;
g2_5_length_offset = -10;

g2_5_bearing_space = 2; // mezera pro podlozku mezi loziskem a stenou..


g2_0_vertical_bolts = 2;
g2_0_space_btw_wheel_holder = 25.8;

g2_6_plate_thickness = 8;
g2_6_servo_distance = 54; // jak je daleko servo pred tyci kola
g2_6_servo_shift = 0; // jak je osa serva mimo stredu
g2_6_servo_bolt_l = 8; // delka sroubu od konce serva po zacatek matky
g2_6_min_wall_around = 8; // minimalni material okolo serva




// pro dily ze skupiny 3 (888_30**)
g3_0_cone1 = 70;
g3_0_cone2 = 50;
g3_0_cone_height = 25;
g3_0_cone_top_height = 11;
g3_0_height = g3_0_cone_height + 40;
g3_0_bearing_bolt_len = 50;
g3_0_srcew_dist = 55;


// Nastavní volností skupiny dílů 888_30**
// Nastavení rozsahů je v deg
g3_0_pitch_limit = [-20:3:20];
g3_0_roll_limit = [-15:3:15];
g3_0_yaw_limit = [-10:3:10];


//pro zakladnu na strechu auta
g3_1_yaw_width = 75;
g3_1_service_holl_height = 8.4 + 2;
g3_1_service_holl_width = 16 + 1.5;

//pro druhy dil
g3_7_length = maximum_printable_size;
g3_7_width = bearing_efsm_17_width + 2*1+ 2*3;
g3_7_height = M8_screw_diameter*3;

g3_8_magnet_wall_thickness = 7;  // tloustka steny u magnetu
g3_8_bearing_wall_thickness = bearing_efsm_12_ag-bearing_efsm_12_a1;
g3_8_magnet_diameter = 63;
g3_8_cylinder_d = 55; // prumer valce
g3_8_cylinder_h = 30 + g3_8_magnet_wall_thickness;
g3_8_m5_lenght = 40; // delka sroubu pro pridelani kuloveho loziska
g3_8_pocket_wall = g3_8_cylinder_h-(g3_8_m5_lenght-bearing_efsm_12_a1-M5_nut_height-5);

// podlozka na strechu auta
g3_9_height = 145;



servo_20kg_width = 21;   //šřka otvoru pro servo
servo_20kg_height = 42;  //výška otvoru pro servo
