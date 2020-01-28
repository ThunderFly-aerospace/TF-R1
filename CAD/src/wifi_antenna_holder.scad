include <../parameters.scad>
include <lib/stdlib/polyScrewThread_r1.scad>

draft = $preview;
$fn = draft ? 20 : 100; // model faces resolution
PI=3.141592;

//$fn=40; // model faces resolution.


//----------------------------------------------------------------
//----------------------------------------------------------------
//WINDGAUGE02A_S02 - Parametry pro hlavni valec anemometru
S01_hloubka_zavitu=4;
S01_vyska=110; //80
S01_prumer_vnitrni=50;
S01_sila_materialu=1.2;
S01_vyska_horni_zavit=10;
S01_vyska_spodniho_zavitu=10;
S01_sila_drzaku_RJ11=3; //vyška drážky
S01_hrana_A_RJ11=12.3;
S01_hrana_B_RJ11=19;
S01_tolerance_zavit=1.5;

//Rozměry ložiska se závity
//LO_spodni_prumer=22;
LO_spodni_prumer=17.2; //bez krytu
LO_vyska_bez_krytu=15;
LO_doraz_prumer=44.3;
LO_horni_prumer=7.7;
LO_vyska_spodni_doraz=5;
LO_vyska_horni_doraz=9;
LO_vyska_dorazu=0;

//Parametry sroubu
prumer_sroubu=3.4;
prumer_hlavy_sroubu=8.2;
vyska_hlavy_sroubu=4.3;
vyska_matky=3;
sirka_matky=6.7;




antenna_diameter = 12;

//Držák ložisek, rotoru, senzoru
module WINDGAUGE01A_S01(draft = true)
{
    //valec se zavitem
    union()
    {
        difference()
        {
            union()
            {
                translate([0, 0, S01_sila_materialu])
                    if (draft)
                        cylinder(h = S01_vyska_horni_zavit,
                                 d = S01_prumer_vnitrni + S01_tolerance_zavit);
                    else
                        screw_thread((S01_prumer_vnitrni-S01_tolerance_zavit),
                                     S01_hloubka_zavitu, 55, S01_vyska_horni_zavit,
                                     PI/2, 2);
                //spodní doraz
                cylinder(h = S01_sila_materialu,
                         r=S01_prumer_vnitrni/2 + 5/2*S01_sila_materialu);
                //krycí ovál - usnadnění povolení
                difference()
                {
                    cylinder(h = R01_vyska_prekryti_statoru + 5,
                             r=S01_prumer_vnitrni/2 + 5/2*S01_sila_materialu);
                    cylinder(h = R01_vyska_prekryti_statoru + 5 + 0.01,
                             r = S01_prumer_vnitrni/2 + 3/2*S01_sila_materialu);
                }
            }
        //odstranění vnitřní výplně
        translate([0, 0, S01_sila_materialu])
            cylinder(h = S01_vyska_horni_zavit + 0.01,
                     r = (S01_prumer_vnitrni/2 - S01_hloubka_zavitu/2
                          - S01_sila_materialu));
        //otvor na ložisko s vodiči
        translate([0, 0, S01_sila_materialu/2])
            cylinder(h = S01_sila_materialu + 0.01,
                     r = (LO_spodni_prumer + 0.2)/2,
                     center = true);
        }
        //držák ložiska
        difference()
        {
            union(){
                cylinder(h = LO_vyska_bez_krytu + 8, d = antenna_diameter + 4);
                
                translate([0, -6, 0])
                    cube([22, 12, S01_sila_materialu+2]);
                
                hull(){
                    
                    translate([-6, -5, 0]) cube([10, 10, 1]);
                    translate([-6-7, -5, LO_vyska_bez_krytu + 8 - 8]) cube([10, 10, 8]);
                    
                }
            }
            //otvor na ložisko
            cylinder(h = LO_vyska_bez_krytu + 8 + 0.5, d = antenna_diameter);
            translate([-15, -0.75, 0]) cube([10, 1.5, 30]);
            
            translate([-9, 0, 18])
                rotate([90, 0, 0]){
                        
                        cylinder(d = M3_screw_diameter, h = 30, center = true);
                        translate([0, 0, 4-2])
                            rotate([0, 0, 30])
                                cylinder(d = M3_nut_diameter, h = 5, $fn=6);
                        translate([0, 0, -4+2-5])
                            rotate([0, 0, 30])
                                cylinder(d = M3_nut_diameter, h = 5, $fn = 6);
                    
                    }
                    
                    
            
        }
    }
}

//sloupek na senzor
module SLOUPEK()
{
    translate([0, 0, S01_sila_materialu])
        difference ()
        {
            cylinder (h = (R01_vyska_prekryti_statoru + 2*lozisko_vyska
                           + 2*S01_sila_materialu + 2*S01_sila_materialu
                           + vyska_hlavy_sroubu + magnet_vyska + vyska_matky),
                      r = sirka_matky/2 + S01_sila_materialu, $fn = 20);
            translate([0, 0, R01_vyska_prekryti_statoru + 2*lozisko_vyska
                       + 2*S01_sila_materialu + 2*S01_sila_materialu + vyska_hlavy_sroubu
                       + magnet_vyska])
                cylinder (h = vyska_matky + 0.01, r = (sirka_matky + 0.2)/2, $fn = 6);
            translate([0, 0, -0.01])
                cylinder (h = (R01_vyska_prekryti_statoru + 2*lozisko_vyska
                               + 2*S01_sila_materialu + 2*S01_sila_materialu
                               + vyska_hlavy_sroubu + magnet_vyska + vyska_matky + 0.01),
                          r = (prumer_sroubu + 0.2) / 2, $fn = 40);
            translate([0, 0, -0.01])
                cylinder (h = vyska_hlavy_sroubu - S01_sila_materialu,
                          r = prumer_hlavy_sroubu/2, $fn = 40);
            translate([0, 0, vyska_hlavy_sroubu - S01_sila_materialu - 0.02])
                cylinder(h = 2 + 0.02,
                         r1 = prumer_hlavy_sroubu/2,
                         r2 = (prumer_sroubu + 0.2) / 2);
        }
}

difference()
{
    // If not draft -> move to print position.
    if (!draft)
        translate([0, 0, 0])
            rotate([0, 0, 0])
                WINDGAUGE01A_S01(false);
    else
        WINDGAUGE01A_S01();
    // Cut-out cube
    if (draft)
        translate([0, 0, 0])
            cube(10*R01_vyska_prekryti_statoru);
}
