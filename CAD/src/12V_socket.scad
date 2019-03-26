include <Parameters.scad>
//podlozka

//velikost zakladny
length = 50;
width = 50;
height = 8;

//dira pro srouby
lengthscrew=10;
indentationscrewhole=28.5;
indentationcubehole=32.5;
pitchleft= 38.5;
pitchright=61.5;

//vyrez pro zapojeni
cubelength=25;
cubewidth=15;
cubeheight=10;

//privodni drat
chanelwidth=10;
chanellength=45;
chanelheight=6;

difference(){
    translate([50, width/2, height/2])
    cube(size = [length,width,height], center = true);
//pruchod pro srouby
    translate([pitchleft, indentationscrewhole, 0])
        cylinder(h = lengthscrew, d = M3_screw_diameter, $fn=100);

    translate([pitchright, indentationscrewhole, 0])
        cylinder(h = lengthscrew, d = M3_screw_diameter, $fn=100);
//vyrez pro pripojeni
    translate([50, indentationcubehole, 5])
        cube(size = [cubewidth,cubelength,cubeheight], center = true);

//prohluben pro matky
    translate([pitchright, indentationscrewhole, 0])
     cylinder(h = M3_nut_height*1.5, d = M3_nut_diameter, $fn=6);
    translate([pitchleft, indentationscrewhole, 0])
     cylinder(h = M3_nut_height*1.5, d = M3_nut_diameter, $fn=6);
//privodni drat
    translate([50, 67.5, chanelheight])
        rotate([0,0,90]){
            cube(size=[chanellength,chanelwidth, chanelheight], center = true);
                        }
};
