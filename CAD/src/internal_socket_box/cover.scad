include  <../../parameters.scad>;
//velikost boxu
//velikost boxu
boxlength = 150;
boxwidth = 90;
boxheight = 85;
thicknesswall = 4;


//zapust sroubu
embeddingheight = 10;
embeddingdiameter = 10;


//generovani vika
difference(){
  translate([0,0,thicknesswall/2])
   cube(size=[boxlength-thicknesswall/2-0.1,boxwidth-thicknesswall/2-0.1,thicknesswall],center=true);

  //zapusteni hlavicek sroubu do vika
  coverhole();
  mirror(v=[1,0,0]){
    coverhole();
  }
  mirror(v=[1,0,0]){
    mirror(v=[0,1,0]){
      coverhole();
    }
  }
  mirror(v=[0,1,0]){
    coverhole();
  }
}

module coverhole(){
  translate([boxlength/2-thicknesswall/2-embeddingdiameter/2,boxwidth/2-thicknesswall/2-embeddingdiameter/2,0])
    cylinder(h=M3_screw_head_height+4,d=M3_screw_diameter,$fn=100);
  translate([boxlength/2-thicknesswall/2-embeddingdiameter/2,boxwidth/2-thicknesswall/2-embeddingdiameter/2,thicknesswall-M3_nut_height])
    cylinder(h=M3_nut_height,d=M3_nut_diameter,$fn=100);
}
