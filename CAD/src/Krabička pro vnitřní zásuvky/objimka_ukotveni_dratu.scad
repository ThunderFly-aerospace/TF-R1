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
  cube(size=[sleevelength,sleevewidth,sleeveheight],center=true);
  translate([-3,0,sleevewidth/4])
  rotate([90,0,0]){
    cylinder(h=sleevewidth,d=wirediameter,$fn=100,center=true);
  }
  translate([3,0,sleevewidth/4])
  rotate([90,0,0]){
    cylinder(h=sleevewidth,d=wirediameter,$fn=100,center=true);
  }
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

  translate([-10,0,-sleeveheight/2])
  rotate([0,0,90])
  {
    cylinder(h=M3_nut_height,d=M3_nut_diameter,$fn=6);
  }
  translate([10,0,-sleeveheight/2])
  rotate([0,0,90])
  {
    cylinder(h=M3_nut_height,d=M3_nut_diameter,$fn=6);
  }
}

//horni pritalcna deska
difference(){
  translate([0,0,30])
  cube(size=[sleevelength,sleevewidth,sleeveheightupper],center=true);
  translate([10,0,30-sleeveheightupper/2])
  rotate([0,0,90])
  {
    cylinder(h=sleeveheightupper*4,d=M3_screw_diameter,$fn=100);
  }
  translate([-10,0,30-sleeveheightupper/2])
  rotate([0,0,90])
  {
    cylinder(h=sleeveheightupper*4,d=M3_screw_diameter,$fn=100);
  }
}
