// Usage example for difference of multiple children:
$fn=90;
difference(){
    cylinder(r=15,h=50,center=true);
      rotate([00,-45,-45]) color("LightBlue") 
        cylinder(r=6,h=100,center=true);
      rotate([00,45,-50])
        cylinder(r=6,h=100,center=true);
      translate([0,0,-10])rotate([90,45,-50])
        cylinder(r=6,h=100,center=true);
}
   