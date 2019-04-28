include <../../parameters.scad>
use <../lib/ALU_profile.scad>
use <888_5001.scad>
use <888_5002.scad>
use <888_5003.scad>
use <888_5004.scad>
use <888_5005.scad>

module joint() {
    rotate([90, 0, 90])
    translate([-ALU_profile_width/2-ALU_profile_holder_wall_thickness, ALU_profile_width/2+ALU_profile_holder_wall_thickness*2, -(608_bearing_outer_diameter+10)/2]) {
        888_5003();
        translate([0, 608_bearing_outer_diameter*2-7, (608_bearing_outer_diameter+10)/2-ALU_profile_width/2])
            mirror([0, 1, 0])
                888_5004();
    }
}
module tenzometr() {
    translate([-strain_gauge_screw_distance/2-10, -ALU_profile_width/2-ALU_profile_holder_wall_thickness, ALU_profile_width/2+ALU_profile_holder_wall_thickness*2])
    rotate([90, 0, 90])
    color([1, 0, 0]) 888_5001();


    translate([-strain_gauge_screw_distance/2-10, strain_gauge_width/-2, ALU_profile_width/2+7])
    color([0, 0, 1]) cube([strain_gauge_length, strain_gauge_width, strain_gauge_width]);

    translate([(10+strain_gauge_length-strain_gauge_screw_distance*3)-strain_gauge_screw_distance/2-10, strain_gauge_width/2, ALU_profile_width/2+7+strain_gauge_width])
    rotate([0, 0, -90])
    color([1, 0, 0]) 888_5002();
}
module tenzometr_opak() {
    rotate([90, 0, 90])
    translate([-ALU_profile_width/2-ALU_profile_holder_wall_thickness, ALU_profile_width/2+ALU_profile_holder_wall_thickness*2, -ALU_profile_width/2])
    888_5005();
}

translate([-ALU_profile_width/2, 0, 0])
rotate([0, 90, 0])
ALU_profile(size=ALU_profile_width, height=400);

translate([0, 0, ALU_profile_width/2])
ALU_profile(height=230, size=ALU_profile_width);

translate([200, 0, ALU_profile_width/2])
ALU_profile(height=75, size=ALU_profile_width);

translate([200, 0, 75+75.5])
color([1, 0, 0]) mirror([0, 0, 1]) joint();

translate([100, 0, 75+75.5])
rotate([0, 90, 0])
ALU_profile(height=300, size=ALU_profile_width);

translate([300, 0, 75+75.5])
color([1, 0, 0]) joint();

translate([300, 0, 75+75.5*2-ALU_profile_width/2])
ALU_profile(height=150, size=ALU_profile_width);

translate([320, 0, 0])
tenzometr();

mirror([1, 0, 0])
translate([0, 0, 230])
rotate([0, -90, 0])
tenzometr();

translate([375, 0, 75+75.5])
color([1, 0, 0]) mirror([0, 0, 1]) tenzometr_opak();


translate([300, 0, (75+75.5*2-ALU_profile_width/2)+70])
color([1, 0, 0]) rotate([0, -90, 0]) tenzometr_opak();