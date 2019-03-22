include <Parameters.scad>

//podlozka

//velikost zakladny 
lenght = 100;
width = 90;
height = 7;

//dira pro srouby
lenghtscrew=10;
indentationscrewhole=28.5;
indentationcubehole=32.5;
pitchleft= 38.5;
pitchright=61.5;

//vyrez pro zapojeni
cubelenght=25;
cubewidth=15;
cubeheight=10;

//privodni drat
chanelwidth=8;
chanellenght=45;
chanelheight=4;

difference(){
    translate([50, 45, height/2])
    cube(size = [lenght,width,height], center = true);
//pruchod pro srouby
    translate([pitchleft, indentationscrewhole, 0])
        cylinder(h = lenghtscrew, d = M3_screw_diameter, $fn=100);
    
    translate([pitchright, indentationscrewhole, 0])
        cylinder(h = lenghtscrew, d = M3_screw_diameter, $fn=100);
//vyrez pro pripojeni
    translate([50, indentationcubehole, 5])
        cube(size = [cubewidth,cubelenght,cubeheight], center = true);
    
//prohluben pro matky
    translate([pitchright, indentationscrewhole, 0])
     cylinder(h = M3_nut_height*1.5, d = M3_nut_diameter, $fn=6);
    translate([pitchleft, indentationscrewhole, 0])
     cylinder(h = M3_nut_height*1.5, d = M3_nut_diameter, $fn=6);
//privodni drat
    translate([50, 67.5, 1])
        rotate([0,0,90]){  
            cube(size=[chanellenght,chanelwidth, chanelheight], center = true);
                        }
};