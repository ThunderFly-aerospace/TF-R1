//velikost boxu
boxlength = 150;
boxwidth = 85;
boxheight = 85;
thicknesswall=5;

//viko
caplength=150;
capwidth=85;
capheight=5;

//zapust sroubu
embeddingheight= 10;
embeddingdiameter= 10;

M3_screw_diameter=3.2;
M3_nut_height = 2.7;
M3_nut_diameter = 6.6;
M3_screw_head_height = 3;


//viko
difference(){
  translate([0,0,(M3_screw_head_height+3)/2])
  cube(size=[boxlength-3,boxwidth-3,M3_screw_head_height+2],center=true);

//zapusteni hlavicek sroubu do vika
  pruchozisezapusti();
  mirror(v=[1,0,0]){
    pruchozisezapusti();
  }
  mirror(v=[1,0,0]){
    mirror(v=[0,1,0]){
      pruchozisezapusti();
    }
  }
  mirror(v=[0,1,0]){
    pruchozisezapusti();
  }
}
module pruchozisezapusti(){
  translate([boxlength/2-thicknesswall-embeddingdiameter/4,boxwidth/2-thicknesswall-embeddingdiameter/4,M3_screw_head_height])
    cylinder(h=M3_screw_head_height+4,d=M3_screw_diameter,$fn=100);
  translate([boxlength/2-thicknesswall-embeddingdiameter/4,boxwidth/2-thicknesswall-embeddingdiameter/4,0])
    cylinder(h=M3_screw_head_height,d=M3_screw_diameter+2,$fn=100);
}
