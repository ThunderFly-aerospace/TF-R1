include  <../../parameters.scad>;

//nutno nastavit!!!
wirediameter = 5.4;


sleevelength = 30;
sleevewidth = 10;
sleeveheight = 7;
sleeveheightupper = 5;


//horni pritlacna deska
difference(){
  translate([0,0,0])
  cube(size=[sleevelength,sleevewidth,sleeveheightupper],center=true);
  translate([10,0,0-sleeveheightupper/2])
  rotate([0,0,90])
  {
    cylinder(h=sleeveheightupper*4,d=M3_screw_diameter,$fn=100);
  }
  translate([-10,0,0-sleeveheightupper/2])
  rotate([0,0,90])
  {
    cylinder(h=sleeveheightupper*4,d=M3_screw_diameter,$fn=100);
  }
  translate([10,0,0])
  rotate([0,0,90])
  {
      cylinder(h=M3_screw_head_height,d=M3_nut_diameter,$fn=100);
  }
  translate([-10,0,0])
  rotate([0,0,90])
  {
    cylinder(h=M3_screw_head_height,d=M3_nut_diameter,$fn=100);
  }


// vyrez pro ulozeni vodicu
  translate([-wirediameter/2,0,0-sleeveheightupper/2])
  rotate([90,0,0]){
    cylinder(h=sleevewidth,d=wirediameter,$fn=100,center=true);
  }
  translate([+wirediameter/2,0,0-sleeveheightupper/2])
  rotate([90,0,0]){
    cylinder(h=sleevewidth,d=wirediameter,$fn=100,center=true);
  }
}
