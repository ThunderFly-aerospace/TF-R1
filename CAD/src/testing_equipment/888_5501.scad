include <../../parameters.scad>
use <../lib/ALU_profile.scad>
use <888_5001.scad>
use <888_5002.scad>
use <888_5003.scad>
use <888_5004.scad>
use <888_5005.scad>
use <888_5010.scad>
use <888_5011.scad>

module tenzometr() {
    translate([-strain_gauge_screw_distance/2-10, -ALU_profile_width/2-ALU_profile_holder_wall_thickness, ALU_profile_width/2+ALU_profile_holder_wall_thickness*2])
    rotate([90, 0, 90])
    color([1, 0, 0]) 888_5001();


    translate([-strain_gauge_screw_distance/2-10, strain_gauge_width/-2, ALU_profile_width/2+ALU_profile_holder_wall_thickness*2+3])
    color([0, 0, 1]) cube([strain_gauge_length, strain_gauge_width, strain_gauge_width]);

    translate([(10+strain_gauge_length-strain_gauge_screw_distance*3)-strain_gauge_screw_distance/2-10, strain_gauge_width/2, ALU_profile_width/2+strain_gauge_width+ALU_profile_holder_wall_thickness*2+3])
    rotate([0, 0, -90])
    color([1, 0, 0]) 888_5002();
}
module tenzometr_opak() {
    rotate([90, 0, 90])
    translate([-ALU_profile_width/2-ALU_profile_holder_wall_thickness, ALU_profile_width/2+ALU_profile_holder_wall_thickness*2, -ALU_profile_width/2])
    888_5005();
}
rotate([90, 0, 90])
translate([-ALU_profile_width/2-ALU_profile_holder_wall_thickness-3, ALU_profile_holder_wall_thickness*2+ALU_profile_width/2, (608_bearing_outer_diameter+10)/-2])
color([1, 0, 0]) 888_5010();

translate([-80, 0, 0])
rotate([0, 90, 0])
ALU_profile(height=200);

translate([-200, 0, -182-ALU_profile_width/2])
rotate([0, 90, 0])
ALU_profile(height=500);

translate([0, 0, -182])
ALU_profile(height=150);

translate([608_bearing_outer_diameter+12, 0, 65.5])
ALU_profile(height=160);

translate([-160, 0, -182])
ALU_profile(height=300);

translate([ALU_profile_width/-2, 0, ALU_profile_width/-2-5])
rotate([90, 0, 90])
translate([0, 0, 0])
color([1, 0, 0]) 888_5011();

translate([608_bearing_outer_diameter+12, 0, 0])
rotate([90, 0, 90])
translate([ALU_profile_width/-2-ALU_profile_holder_wall_thickness, ALU_profile_width/2+ALU_profile_holder_wall_thickness*2, 608_bearing_outer_diameter/-2-5])
color([1, 0 ,0]) 888_5003();

translate([608_bearing_outer_diameter+12, 0, 80])
rotate([-90, 0, 90])
translate([ALU_profile_width/-2-ALU_profile_holder_wall_thickness, ALU_profile_width/2+ALU_profile_holder_wall_thickness*2, -ALU_profile_width/2])
color([1, 0, 0]) 888_5004();

rotate([180, 0, 0])
translate([105, 0, 0])
color([1, 0, 0]) tenzometr_opak();

translate([608_bearing_outer_diameter+12, 0, 125])
rotate([0, -90, 0])
color([1, 0, 0]) tenzometr_opak();

translate([50, 0, -182-ALU_profile_width/2])
tenzometr();

translate([-160, 0, 75])
rotate([180, -90, 0])
tenzometr();