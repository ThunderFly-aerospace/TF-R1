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
  translate([10,0,12])
  rotate([0,0,90])
  {
      cylinder(h=M3_screw_head_height,d=M3_screw_diameter*1.5,$fn=100);
  }
  translate([-10,0,12])
  rotate([0,0,90])
  {
    cylinder(h=M3_screw_head_height,d=M3_screw_diameter*1.5,$fn=100);
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
