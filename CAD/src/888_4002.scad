include <../parameters.scad>
//sroub pro propojení pistu k 3D vytisku je M6
//dno je tluste 3 mm
//sroub pro prřipojení 3D vytisku k lozisku je M6, hlava soubu je ulozena  blize k pistu.

connecting_height=13+M6_head_height;
connecting_diameter=20;
piston_thread_height=13;
piston_thread_diameter=16+0.2;
piston_cutout=12.1;
bearing_diameter=bearing_EFOM_10_d1;
bearing_ball_height=bearing_EFOM_10_h-0.8;
bottom_height=3;
hole_pozition=4;//posunuti diry pro pripevneni vytisku k pistu měřeno od širší části.
insert_nut_connecting_pozition = connecting_height-hole_pozition-M6_screw_diameter/2+bottom_height;
tolerance=global_clearance;
blank_for_printing=0.2;

difference(){
    //cast ktera se pripevni na pist
    translate([0,0,bottom_height])
        cylinder(h=connecting_height,d=connecting_diameter,$fn=100);

    //vyrez pro nasazeni
    difference(){
         translate([0,0,bottom_height+M6_head_height])
            cylinder(h=piston_thread_height,d=piston_thread_diameter,$fn=100);

        translate([0,piston_cutout/2+5/2,bottom_height+M6_head_height+piston_thread_height/2])
            cube([piston_thread_diameter,5,piston_thread_height],center=true);
        translate([0,-piston_cutout/2-5/2,bottom_height+M6_head_height+piston_thread_height/2])
            cube([piston_thread_diameter,5,piston_thread_height],center=true);
    }
    //vyrez pro ulozeni hlavy sroubu M6 do dna
    translate([0,0,bottom_height])
        cylinder(h=M6_head_height,d=M6_head_diameter,$fn=6);

    //pruchod pro sroub
    cylinder(h=bottom_height,d=M6_screw_diameter,$fn=100);

    //vyrez pro pripevneni na pist pomoci sroubu
    rotate([90,0,0]){
        translate([0,insert_nut_connecting_pozition,0])
            cylinder(h=connecting_diameter,d=M6_screw_diameter,$fn=100,center=true);
    }
}
//zaslepka pro tisk
translate([0,0,bottom_height+M6_head_height])
    cylinder(h=blank_for_printing,d=connecting_diameter);

//zkoseni dna
difference(){
    hull(){
        translate([0,0,bottom_height])
            cylinder(h=0.1,d=connecting_diameter,$fn=100);
            
        cylinder(h=0.1,d=bearing_diameter+2,$fn=100);
    }
    cylinder(h=bottom_height+1,d=M6_screw_diameter,$fn=100);
}

//cast ktera prochazi loziskem
difference() {
    //vnejsi povrch
    translate([0,0,-bearing_ball_height])
        cylinder(h=bearing_ball_height,d=bearing_diameter,$fn=100);

    //vnitrni povrch
    translate([0,0,-bearing_ball_height])
        cylinder(h=bearing_ball_height,d=M6_screw_diameter,$fn=100);
}
