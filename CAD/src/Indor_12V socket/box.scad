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

//upevneni privodnichvodicu
sleevelength=30;
sleevewidth=10;
sleeveheight=7;
sleeveheightupper=5;
wirediameter=5.4;


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

  //generovani otvoru pro pripojeni 12 V zasuvky
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

  //otvor pro vstup napajecich vodicu
  rotate([0,90,0]){
    cylinder(h=180,d=powersourceinputdiameter,$fn=100,center=true);
  }
}

// generovani boxu pro ulozeni matek maticek
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

//generovani ukotveni privodnich kabelu
translate(([-boxlength/2+thicknesswall+sleevewidth/4,0,-7]))
rotate([0,0,90]){
  anchorwiring();
}
translate(([+boxlength/2-thicknesswall-sleevewidth/4,0,-7]))
rotate([180,180,90]){
  anchorwiring();
}

//module ulozeni matek pro pripevneni vika
module nutbox (){
  difference(){
    hull(){
      translate([boxlength/2-thicknesswall-embeddingdiameter/4,boxwidth/2-thicknesswall-embeddingdiameter/4-2,boxheight/2-embeddingheight])
      cube(size=[embeddingdiameter,embeddingdiameter,embeddingheight],center=true);
      //podpora pro tisk
      translate([boxlength/2-thicknesswall+embeddingdiameter/3,boxwidth/2-thicknesswall+embeddingdiameter/3,boxheight/2-embeddingheight*2])
      cylinder(h=15,d=1,fn=4, center=true);
    }
    //pruchozi dira pro sroub
    translate([boxlength/2-thicknesswall-embeddingdiameter/4,boxwidth/2-thicknesswall-embeddingdiameter/4,boxheight/2-embeddingheight-8])
    cylinder(h = 17, d = M3_screw_diameter, $fn=100);
    //ulozeni matky sestihran
    translate([boxlength/2-thicknesswall-embeddingdiameter/4,boxwidth/2-thicknesswall-embeddingdiameter/4,boxheight/2-embeddingheight-M3_nut_height])
    cylinder(h = M3_nut_height*1.2, d = M3_nut_diameter, $fn=6);
    //vyrez pro vlozeni matky
    translate([boxlength/2-thicknesswall/2-1,boxwidth/2-thicknesswall-embeddingdiameter/4,boxheight/2-embeddingheight-M3_nut_height/2.5])
    cube(size=[6,M3_nut_diameter*0.9,M3_nut_height*1.2],center=true);
  }
}

//module pro diry pro pripojeni 12 V
module screwhole(){
  //diry pro srouby-pripojeni 12 V zasuvky do dna
  translate([xscrewposition,yscrewposition,-boxheight/2])
  cylinder(h=thicknesswall,d=M3_screw_diameter*1.1,$fn=100);
  //zapusteni setihranu pro lepsi pripojeni 12 V panelu
  translate([xscrewposition,yscrewposition,-boxheight/2+M3_nut_height])
  cylinder(h=M3_nut_height,d=M3_nut_diameter*1.1,$fn=6);

  //otvor pro vlozeni matky z vnejsi strany
  translate([boxlength/2-3,boxwidth/2-thicknesswall-embeddingdiameter/4,boxheight/2-embeddingheight-M3_nut_height/2.5])
  cube(size=[9,M3_nut_diameter*0.9,M3_nut_height*1.2],center=true);
}

//modul-ukoveni privodnich dratu
module anchorwiring(){

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
}
