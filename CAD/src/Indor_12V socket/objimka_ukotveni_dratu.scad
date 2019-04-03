
//parametry
sleevelength=30;
sleevewidth=10;
sleeveheight=7;
sleeveheightupper=5;
wirediameter=3.3;

//parametrs
M3_screw_diameter=3.2;
M3_nut_height = 2.7;
M3_nut_diameter = 6.6;
M3_screw_head_height = 3;



difference(){
  hull(){
cube(size=[sleevelength,sleevewidth,sleeveheight],center=true);
    translate([0,sleevewidth/2-0.2,-10])
    rotate([0,90,0]){
    cylinder(h=sleevelength,d=1,$fn=4,center=true);
    }
  }

// vyrez pro ulozeni vodicu
  translate([-3,0,sleevewidth/3])
  rotate([90,0,0]){
    cylinder(h=sleevewidth+2,d=wirediameter,$fn=100,center=true);
  }
  translate([3,0,sleevewidth/3])
  rotate([90,0,0]){
    cylinder(h=sleevewidth+2,d=wirediameter,$fn=100,center=true);
  }

//pruchod pro sroub
  translate([10,0,-sleeveheight])
  rotate([0,0,90])
  {
    cylinder(h=sleeveheight*2,d=M3_screw_diameter,$fn=100);
  }
  translate([-10,0,-sleeveheight])
  rotate([0,0,90])
  {
    cylinder(h=sleeveheight*2,d=M3_screw_diameter,$fn=100);
  }

//vyrez pro ulozeni matky M3
  translate([-10,0,-sleeveheight/2-1])
  rotate([0,0,90])
  {
    cylinder(h=M3_nut_height+8,d=M3_nut_diameter,$fn=6,center=true);
  }
  translate([10,0,-sleeveheight/2-1])
  rotate([0,0,90])
  {
    cylinder(h=M3_nut_height+8,d=M3_nut_diameter,$fn=6,center=true);
  }
}


//horni pritlacna deska
difference(){
  translate([0,0,12])
  cube(size=[sleevelength,sleevewidth,sleeveheightupper],center=true);
  translate([10,0,12-sleeveheightupper/2])
  rotate([0,0,90])
  {
    cylinder(h=sleeveheightupper*4,d=M3_screw_diameter,$fn=100);
  }
  translate([-10,0,12-sleeveheightupper/2])
  rotate([0,0,90])
  {
    cylinder(h=sleeveheightupper*4,d=M3_screw_diameter,$fn=100);
  }

// vyrez pro ulozeni vodicu
  translate([-3,0,12-sleevewidth/4])
  rotate([90,0,0]){
    cylinder(h=sleevewidth,d=wirediameter,$fn=100,center=true);
  }
  translate([3,0,12-sleevewidth/4])
  rotate([90,0,0]){
    cylinder(h=sleevewidth,d=wirediameter,$fn=100,center=true);
  }
}
