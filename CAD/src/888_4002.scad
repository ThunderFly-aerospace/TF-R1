include <../src/Parameters.scad>
// sroub pro propojení pistu k 3D vytisku je M6
//dno je tluste 3 mm
//sroub pro prřipojení 3d vytisku k lozisku je M5, hlava soubu je ulozena  blize k pistu.

connecting_height=13+M5_head_height; //13+5+0.5
connecting_diameter=20;
piston_thread_height=13;
piston_thread_diameter=16;
bearing_diameter=10;
bearing_ball_height=9-1;
bottom_height=3;
hole_pozition=4;//pozice diry pro pripevneni vytisku k pistu
insert_nut_connecting_pozition = connecting_height-hole_pozition-M5_screw_diameter/2+bottom_height;
tolerance=0.2;

difference(){
    //cast ktera se pripevni na pist
    translate([0,0,bottom_height])
        cylinder(h=connecting_height,d=connecting_diameter,$fn=100);

    //vyrez pro nasazeni
    translate([0,0,M5_head_height+bottom_height])
        cylinder(h=piston_thread_height,d=piston_thread_diameter+tolerance,$fn=100);

    //vyrez pro ulozeni hlavy sroubu M5
    translate([0,0,bottom_height])
        cylinder(h=M5_head_height+0.25,d=M5_head_diameter,$fn=6);

    cylinder(h=bottom_height,d=M5_screw_diameter+0.25,$fn=100);

    //vyrez pro pripevneni na pist
    rotate([90,0,0]){
        translate([0,insert_nut_connecting_pozition,0])
            cylinder(h=connecting_diameter,d=M5_screw_diameter+tolerance,$fn=100,center=true);
    }
}
//zkoseni dna
difference(){
    hull(){
        translate([0,0,bottom_height])
            cylinder(h=0.1,d=connecting_diameter,$fn=100);
        cylinder(h=0.1,d=bearing_diameter,$fn=100);
    }
    cylinder(h=bottom_height+1,d=M5_screw_diameter+tolerance,$fn=100);
}

//cast ktera prochazi loziskem
difference() {
    //vnejsi povrch
    translate([0,0,-bearing_ball_height])
        cylinder(h=bearing_ball_height,d=bearing_diameter-tolerance,$fn=100);

    //vnitrni povrch
    translate([0,0,-bearing_ball_height])
        cylinder(h=bearing_ball_height,d=M5_screw_diameter+tolerance,$fn=100);
}
