include <Parameters.scad>

//podlozka
//velikost zakladny 
delka = 100;
sirka = 90;
vyskazakladny = 10;

//dira pro srouby
polomer=3.3;
vyskadiry=10;

//parametry prohlubne pro matky
matkapolomer =5.7;
vyskamatky=5;

// privod dratu
privodsirka=2;
privoddelka=45;
privodvyska=2;

difference(){
    translate([50, 45, 5])
    cube(size = [delka,sirka,vyskazakladny], center = true);
//pruchod pro srouby
    translate([38.5, 28.5, 0])
        cylinder(h = vyskadiry, d = polomer, $fn=100);
    
    translate([61.5, 28.5, 0])
        cylinder(h = vyskadiry, d = polomer, $fn=100);
//vyrez pro pripojeni
    translate([50, 32.5, 5])
    cube(size = [15,25,10], center = true);
    
//prohluben pro matky
    translate([61.5, 28.5, 0])
     cylinder(h = vyskamatky, d = M3_nut_diameter, $fn=6);
    translate([38.5, 28.5, 0])
     cylinder(h = vyskamatky, d = M3_nut_diameter, $fn=6);
//privodni drat
    translate([50, 67.5, 1])
    rotate([0,0,90]){  
      cube(size=[privoddelka,privodsirka, privodvyska], center = true); }
};