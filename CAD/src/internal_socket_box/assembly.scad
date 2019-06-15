include  <../Parameters.scad>;
//Na konci souboru jsou 4 moduly. Jeden je pro ulozeni matek(kvadr v hodni casti pro matky), dalsi modul je pro ukotveni vodicu, dalsi dva tvori moduly s otvory do dna a do vika. Tyto moduly jsou nasledně zrcadleny.

//velikost boxu
boxlength = 150;
boxwidth = 85;
boxheight = 85;
thicknesswall=3.5;

wirediameter=5.4;

//posunuti
posunutivika=85;
posunutiukotvenivodicu=12;

//vstup napajecich vodicu
powersourceinputdiameter = wirediameter*2;

//vyrez pro 12 V zasuvku
cutoutheight=65;
cutoutwidth=20;
xscrewposition=41;
yscrewposition=11;

//zapust sroubu,pozice v domecku
embeddingheight= 10;
embeddingdiameter= 10;

//upevneni privodnichvodicu
sleevelength=30;
sleevewidth=10;
sleeveheight=7;
sleeveheightupper=5;

//podpory
supportlength=20;
supportwidth=5;
supportheight=15;
supportquantity=2;
supportpitch=15;


// krabice
difference(){
  cube(size=[boxlength,boxwidth,boxheight],center=true);
  translate([0,0,thicknesswall])
    cube(size=[boxlength-thicknesswall,boxwidth-thicknesswall,boxheight],center=true);

  //vyrez pro ulozeni vika
  translate([0,0,boxheight/2-thicknesswall/2])
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

//generovani vika
difference(){
  translate([0,0,thicknesswall/2+posunutivika])
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

//generovani ukotveni privodnich kabelu
translate(([-boxlength/2+thicknesswall+sleeveheight/2,0,-sleeveheight/2]))
    rotate([0,0,90]){
        anchorwiring();
}
translate(([+boxlength/2-thicknesswall-sleeveheight/2,0,-sleeveheight/2]))
    rotate([180,180,90]){
        anchorwiring();
}

//module ulozeni matek pro viko
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
            cylinder(h = M3_nut_height*1.2, d = M3_nut_diameter, $fn=6);
        //vyrez pro vlozeni matky
        translate([boxlength/2-thicknesswall/2-1,boxwidth/2-thicknesswall/2-embeddingdiameter/2,boxheight/2-(embeddingheight*1.21)/2-thicknesswall])
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
    translate([boxlength/2-thicknesswall/2,boxwidth/2-thicknesswall/2-(embeddingdiameter)/2,boxheight/2-(embeddingheight*1.21)/2-thicknesswall])
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
                cylinder(h=sleeveheight*2,d=M3_screw_diameter,$fn=100);
        }
        translate([-10,0,-sleeveheight])
            rotate([0,0,90]){
                cylinder(h=sleeveheight*2,d=M3_screw_diameter,$fn=100);
        }
        //vyrez pro ulozeni matky M3
        translate([-10,0,-sleeveheight/2-1])
            rotate([0,0,90]){
                cylinder(h=M3_nut_height+8,d=M3_nut_diameter,$fn=6,center=true);
        }
        translate([10,0,-sleeveheight/2-1])
            rotate([0,0,90]){
                cylinder(h=M3_nut_height+8,d=M3_nut_diameter,$fn=6,center=true);
        }
    }

    //horni pritlacna deska pro ukotveni vodicu
    difference(){
        translate([0,0,posunutiukotvenivodicu])
            cube(size=[sleevelength,sleevewidth,sleeveheightupper],center=true);

        translate([10,0,posunutiukotvenivodicu-sleeveheightupper/2])
            rotate([0,0,90]){
                cylinder(h=sleeveheightupper*4,d=M3_screw_diameter,$fn=100);
        }
        translate([-10,0,posunutiukotvenivodicu-sleeveheightupper/2])
            rotate([0,0,90]){
                cylinder(h=sleeveheightupper*4,d=M3_screw_diameter,$fn=100);
        }

        // vyrez pro ulozeni vodicu
        translate([-wirediameter/2,0,posunutiukotvenivodicu-sleeveheightupper/2])
            rotate([90,0,0]){
                cylinder(h=sleevewidth,d=wirediameter,$fn=100,center=true);
        }
        translate([+wirediameter/2,0,posunutiukotvenivodicu-sleeveheightupper/2])
            rotate([90,0,0]){
                cylinder(h=sleevewidth,d=wirediameter,$fn=100,center=true);
        }
    }
}

//modul pro diry ve viku
module coverhole(){
    translate([boxlength/2-thicknesswall/2-embeddingdiameter/2,boxwidth/2-thicknesswall/2-embeddingdiameter/2,posunutivika])
        cylinder(h=M3_screw_head_height+4,d=M3_screw_diameter,$fn=100);
    translate([boxlength/2-thicknesswall/2-embeddingdiameter/2,boxwidth/2-thicknesswall/2-embeddingdiameter/2,M3_screw_head_height+posunutivika])
        cylinder(h=M3_screw_head_height,d=M3_screw_diameter+2,$fn=100);
}

module support(l, w, h){
       polyhedron(
               points=[[0,0,0], [l,0,0], [l,w,0], [0,w,0], [0,w,h], [l,w,h]],
               faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]);
}

for(i=[1:supportquantity]){
    translate([supportpitch*i-supportwidth/2,boxwidth/2-thicknesswall/2-supportlength,-boxheight/2+thicknesswall])
        support(supportwidth,supportlength,supportheight);

    translate([-supportpitch*i-supportwidth/2,boxwidth/2-thicknesswall/2-supportlength,-boxheight/2+thicknesswall])
        support(supportwidth,supportlength,supportheight);
}
rotate([0,0,180]){
    for(i=[1:supportquantity])
    {
        translate([supportpitch*i-supportwidth/2,boxwidth/2-thicknesswall/2-supportlength,-boxheight/2+thicknesswall])
            support(supportwidth,supportlength,supportheight);

        translate([-supportpitch*i-supportwidth/2,boxwidth/2-thicknesswall/2-supportlength,-boxheight/2+thicknesswall])
            support(supportwidth,supportlength,supportheight);
    }
}
