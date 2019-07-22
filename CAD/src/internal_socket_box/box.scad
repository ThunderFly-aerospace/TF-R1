include  <../../parameters.scad>;

//velikost boxu
boxlength = 135;
boxwidth = 90;
boxheight = 70;
thicknesswall = 4;

wirediameter=5.4;

//vstup napajecich vodicu
powersourceinputdiameter = wirediameter*2;

//vyrez pro 12 V zasuvku
cutoutheight=71;
cutoutwidth=20;
xscrewposition=41;
yscrewposition=11;

//vyrez pro voltmetr
voltmetr_cutoutwidth = 22.3;
voltmetr_cutoutlength = 46.08;
//zapust sroubu (domecek pro matky)
embeddingheight= 10;
embeddingdiameter= 10;

//upevneni privodnichvodicu
sleevelength=30;
sleevewidth=10;
sleeveheight=7;
sleeveheightupper=5;

//podpory
supportlength=15;
supportwidth=5;
supportheight=15;
supportquantity=2;
supportpitch=28;

// box
difference(){
  cube(size=[boxlength,boxwidth,boxheight],center=true);
  translate([0,0,thicknesswall/2])
    cube(size=[boxlength-thicknesswall,boxwidth-thicknesswall,boxheight],center=true);

  //vyrez pro ulozeni vika
  translate([0,0,boxheight/2-thicknesswall/2])
    cube(size=[boxlength-(thicknesswall/2),boxwidth-(thicknesswall/2),thicknesswall],center=true);

  //vyrezem pro zasuvku 12V
  translate([0,-boxwidth/5,-boxheight/2+thicknesswall])
    cube(size=[cutoutheight,cutoutwidth,thicknesswall+5],center=true);

//vyrez pro voltmetr
translate([0,boxwidth/5,-boxheight/2])
cube([voltmetr_cutoutlength,voltmetr_cutoutwidth,thicknesswall+5],center=true);

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
  //diry pro srouby-pripojeni 12 V zasuvky do dna
  translate([xscrewposition,yscrewposition-boxwidth/5,-boxheight/2-0.5])
    cylinder(h=thicknesswall,d=M3_screw_diameter,$fn=100);
  //zapusteni setihranu pro lepsi pripojeni 12 V panelu
  translate([xscrewposition,yscrewposition-boxwidth/5,-boxheight/2+M3_nut_height/2-0.5])
    cylinder(h=M3_nut_height,d=M3_nut_diameter,$fn=6);

      translate([-xscrewposition,yscrewposition-boxwidth/5,-boxheight/2])
        cylinder(h=thicknesswall,d=M3_screw_diameter,$fn=100);
      //zapusteni setihranu pro lepsi pripojeni 12 V panelu
      translate([-xscrewposition,yscrewposition-boxwidth/5,-boxheight/2+M3_nut_height/2-0.5])
        cylinder(h=M3_nut_height,d=M3_nut_diameter,$fn=6);

        translate([xscrewposition,-yscrewposition-boxwidth/5,-boxheight/2])
          cylinder(h=thicknesswall,d=M3_screw_diameter,$fn=100);
        //zapusteni setihranu pro lepsi pripojeni 12 V panelu
        translate([xscrewposition,-yscrewposition-boxwidth/5,-boxheight/2+M3_nut_height/2-0.5])
          cylinder(h=M3_nut_height,d=M3_nut_diameter,$fn=6);

          translate([-xscrewposition,-yscrewposition-boxwidth/5,-boxheight/2])
            cylinder(h=thicknesswall,d=M3_screw_diameter,$fn=100);
          //zapusteni setihranu pro lepsi pripojeni 12 V panelu
          translate([-xscrewposition,-yscrewposition-boxwidth/5,-boxheight/2+M3_nut_height/2-0.5])
            cylinder(h=M3_nut_height,d=M3_nut_diameter,$fn=6);

  //otvor pro vstup napajecich vodicu
  rotate([0,90,0]){
    cylinder(h=180,d=powersourceinputdiameter,$fn=100,center=true);
  }
}
blind_plug();
mirror(v=[1,0,0]){
blind_plug();
}

// generovani boxu pro ulozeni matek maticek
blind_plug();
nutbox();
mirror(v=[1,0,0]){
  nutbox();
  blind_plug();
}
mirror(v=[1,0,0]){
  mirror(v=[0,1,0]){
    nutbox();
    blind_plug();
  }
}
mirror(v=[0,1,0]){
  nutbox();
  blind_plug();
}

//generovani ukotveni privodnich kabelu
translate(([-boxlength/2+thicknesswall+sleeveheight/2,0,-sleeveheight/2]))
    rotate([0,0,90]){
        anchorwiring();

}
translate(([+boxlength/2-thicknesswall-sleeveheight/2,0,-sleeveheight/2]))
    rotate([180,180,90]){
        anchorwiring();

}

//modul ulozeni matek pro pripevneni vika
module nutbox (){
    difference(){
        hull(){
            translate([boxlength/2-thicknesswall/2-embeddingdiameter/2,boxwidth/2-thicknesswall/2-embeddingdiameter/2,boxheight/2-embeddingheight/2-thicknesswall])
                cube(size=[embeddingdiameter,embeddingdiameter,embeddingheight],center=true);
            //podpora pro tisk
            translate([boxlength/2 - thicknesswall/2, boxwidth/2 - thicknesswall/2, boxheight/2 - embeddingheight*2])
                cylinder(h = 15, d = 0.01, $fn = 4, center=true);
        }
        //pruchozi dira pro sroub
        translate([boxlength/2-thicknesswall/2-embeddingdiameter/2,boxwidth/2-thicknesswall/2-embeddingdiameter/2,boxheight/2-embeddingheight-7])
            cylinder(h = 17, d = M3_screw_diameter, $fn=100);
        //ulozeni matky sestihran
        translate([boxlength/2-thicknesswall/2-embeddingdiameter/2,boxwidth/2-thicknesswall/2-embeddingdiameter/2,boxheight/2-embeddingheight/2-M3_nut_height-thicknesswall])
            cylinder(h = M3_nut_height, d = M3_nut_diameter, $fn=6);
        //vyrez pro vlozeni matky
        translate([boxlength/2-thicknesswall/2-1,boxwidth/2-thicknesswall/2-embeddingdiameter/2,boxheight/2-embeddingheight/2-M3_nut_height/2-thicknesswall])
            cube(size=[6,M3_nut_diameter*0.9,M3_nut_height],center=true);
    }
}

//module pro diry pro pripojeni 12 V
module screwhole(){

  //otvor pro vlozeni matky z vnejsi strany
  translate([boxlength/2-thicknesswall/2,boxwidth/2-thicknesswall/2-(embeddingdiameter)/2,boxheight/2-embeddingheight/2-M3_nut_height/2-thicknesswall])
    cube(size=[6,M3_nut_diameter*0.9,M3_nut_height],center=true);
}

//modul-ukoveni privodnich vodicu
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
    translate([-wirediameter/2,0,sleeveheight/2])
        rotate([90,0,0]){
            cylinder(h=sleevewidth+2,d=wirediameter,$fn=100,center=true);
    }
    translate([wirediameter/2,0,sleeveheight/2])
        rotate([90,0,0]){
            cylinder(h=sleevewidth+2,d=wirediameter,$fn=100,center=true);
    }
    //pruchod pro sroub
    translate([10,0,-sleeveheight])
        rotate([0,0,90]){
            cylinder(h=sleeveheight*3,d=M3_screw_diameter,$fn=100);
    }
    translate([-10,0,-sleeveheight])
        rotate([0,0,90]){
            cylinder(h=sleeveheight*3,d=M3_screw_diameter,$fn=100);
    }
    //vyrez pro ulozeni matky M3
    translate([-10,0,-sleeveheight/2+3])
        rotate([0,0,90]){
            cylinder(h=M3_nut_height,d=M3_nut_diameter,$fn=6,center=true);
    }
    translate([10,0,-sleeveheight/2+3])
        rotate([0,0,90]){
            cylinder(h=M3_nut_height,d=M3_nut_diameter,$fn=6,center=true);
    }

    //vyrez pro vlozeni matek M3
    translate([-10,-M3_nut_diameter/2,-sleeveheight/2+3])
    cube([6-0.2,M3_nut_diameter,M3_nut_height],center=true);

    translate([10,-M3_nut_diameter/2,-sleeveheight/2+3])
    cube([6-0.2,M3_nut_diameter,M3_nut_height],center=true);

  }
}
module blind_plug(){
    //zaslepka pro tisk
    translate([-boxlength/2+thicknesswall+sleeveheight/2,sleevewidth,-sleeveheight/2+3-M3_nut_height+layer_thickness*2.34])
    cube([5,sleevewidth,layer_thickness],center=true);

    translate([boxlength/2-thicknesswall/2-embeddingdiameter/2-2.5,boxwidth/2-thicknesswall/2-embeddingdiameter/2-2.5,boxheight/2-embeddingheight/2-thicknesswall])
    cube([5,5,layer_thickness]);

}

module support(l, w, h){
       polyhedron(
               points=[[0,0,0], [l,0,0], [l,w,0], [0,w,0], [0,w,h], [l,w,h]],
               faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]
    );
}

for(i=[1:supportquantity]){
    translate([supportpitch*i-supportwidth/2,boxwidth/2-thicknesswall/2-supportlength,-boxheight/2+thicknesswall/2])
        support(supportwidth,supportlength,supportheight);

    translate([-supportpitch*i-supportwidth/2,boxwidth/2-thicknesswall/2-supportlength,-boxheight/2+thicknesswall/2])
        support(supportwidth,supportlength,supportheight);
}
rotate([0,0,180]){
    for(i=[1:supportquantity])
    {
        translate([supportpitch*i-supportwidth/2,boxwidth/2-thicknesswall/2-supportlength,-boxheight/2+thicknesswall/2])
            support(supportwidth,supportlength,supportheight);

        translate([-supportpitch*i-supportwidth/2,boxwidth/2-thicknesswall/2-supportlength,-boxheight/2+thicknesswall/2])
            support(supportwidth,supportlength,supportheight);
    }
}
