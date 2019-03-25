//include  <Parameters.scad>;

//velikost boxu
boxlength = 150;
boxwidth = 85;
boxheight = 85;
thicknesswall=5;

//viko
caplength=150;
capwidth=85;
capheight=5;
posunutivika=150;

//vstup napajecich vodicu
powersourceinputdiameter=15;

//vyrez pro 12 V zasuvku
cutoutheight=65;
cutoutwidth=20;
xscrewposition=41;
yscrewposition=11;
//zapust sroubu
embeddingheight= 10;
embeddingdiameter= 10;

M3_screw_diameter=3.2;
M3_nut_height = 2.7;
M3_nut_diameter = 6.6;
M3_screw_head_height = 3;

// krabice

  difference(){
    cube(size=[boxlength,boxwidth,boxheight],center=true);
    translate([0,0,thicknesswall])
    cube(size=[boxlength-thicknesswall,boxwidth-thicknesswall,boxheight],center=true);

    //vyrez pro ulozeni vika
    translate([0,0,boxheight/2-2.5])
    cube(size=[boxlength-(thicknesswall/2),boxwidth-(thicknesswall/2),thicknesswall],center=true);
    //vyrezem pro zasuvku 12V
    translate([0,0,-boxheight/2+thicknesswall])
    cube(size=[cutoutheight,cutoutwidth,thicknesswall+5],center=true);
    screwhole();
    mirror(v=[1,0,0]){
      screwhole();
    }
    mirror(v=[1,0,0]){
      mirror(v=[0,1,0]){
        screwhole();
      }
    }
    mirror(v=[0,1,0]){
      screwhole();
    }
    //vstupnapajecich vodicu
    rotate([0,90,0]){
      cylinder(h=180,d=powersourceinputdiameter,$fn=100,center=true);
    }
  }
  

//viko
module pruchozisezapusti(){
  translate([boxlength/2-thicknesswall-embeddingdiameter/4,boxwidth/2-thicknesswall-embeddingdiameter/4,posunutivika])
  cylinder(h=M3_screw_head_height+4,d=M3_screw_diameter,$fn=100);
  translate([boxlength/2-thicknesswall-embeddingdiameter/4,boxwidth/2-thicknesswall-embeddingdiameter/4,posunutivika])
  cylinder(h=M3_screw_head_height,d=M3_screw_diameter+2,$fn=100);
}
difference(){
  translate([0,0,posunutivika+(M3_screw_head_height+4)/2])
  cube(size=[boxlength-thicknesswall-1,boxwidth-thicknesswall-1,M3_screw_head_height+4],center=true);
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

//box pro ulozeni matek maticek
nutbox();
mirror(v=[1,0,0]){
  nutbox();
}
mirror(v=[1,0,0]){
  mirror(v=[0,1,0]){
    nutbox();
  }
}
mirror(v=[0,1,0]){
  nutbox();
}

//module ulozeni matek
module nutbox (){
  difference(){
    translate([boxlength/2-thicknesswall-embeddingdiameter/4,boxwidth/2-thicknesswall-embeddingdiameter/4,boxheight/2-embeddingheight])
    cube(size=[embeddingdiameter,embeddingdiameter,embeddingheight],center=true);
    //pruchozi dira pro sroub
    translate([boxlength/2-thicknesswall-embeddingdiameter/4,boxwidth/2-thicknesswall-embeddingdiameter/4,boxheight/2-embeddingheight-20])
    cylinder(h = 40, d = M3_screw_diameter, $fn=100);
    //ulozeni matky sestihran
    translate([boxlength/2-thicknesswall-embeddingdiameter/4,boxwidth/2-thicknesswall-embeddingdiameter/4,boxheight/2-embeddingheight-M3_nut_height])
    cylinder(h = M3_nut_height*1.2, d = M3_nut_diameter, $fn=6);
    //vyrez pro vlozeni matky
    translate([boxlength/2-thicknesswall-embeddingdiameter/2-1,boxwidth/2-thicknesswall-embeddingdiameter/4,boxheight/2-embeddingheight-M3_nut_height/2.5])
    cube(size=[4,M3_nut_diameter*0.9,M3_nut_height*1.2],center=true);
  }
}
//module pro diry pro ukotveni 12 V
module screwhole(){
  //diry pro srouby upevnení 12 V zasuvky do dna
  translate([xscrewposition,yscrewposition,-boxheight/2])
  cylinder(h=thicknesswall,d=M3_screw_diameter,$fn=100);
}
