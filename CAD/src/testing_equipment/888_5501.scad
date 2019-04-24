include <../../parameters.scad>
use <../lib/ALU_profile.scad>
use <888_5001.scad>
use <888_5002.scad>
use <888_5003.scad>
use <888_5004.scad>

module joint() {
    888_5003();
    translate([0, 608_bearing_outer_diameter*2-7, (608_bearing_outer_diameter+10)/2-ALU_profile_width/2])
        mirror([0, 1, 0])
            888_5004();
}

translate([0, -ALU_profile_width/2-ALU_profile_holder_wall_thickness, ALU_profile_width/2+ALU_profile_holder_wall_thickness*2])
rotate([90, 0, 90])
color([1, 0, 0]) joint();

translate([-100, 0, 0])
rotate([0, 90, 0]) ALU_profile(height=300, size=ALU_profile_width);

translate([ALU_profile_width/2+(608_bearing_outer_diameter+10)/2-ALU_profile_width/2, 0, 60]) ALU_profile(height=120, size=ALU_profile_width);

translate([100, -ALU_profile_width/2-ALU_profile_holder_wall_thickness, ALU_profile_width/2+ALU_profile_holder_wall_thickness*2])
rotate([90, 0, 90])
color([1, 0, 0]) 888_5001();


//tenzometr
translate([100, strain_gauge_width/-2, ALU_profile_width/2+7])
color([0, 0, 1]) cube([strain_gauge_length, strain_gauge_width, strain_gauge_width]);

translate([110+strain_gauge_length-strain_gauge_screw_distance*3, strain_gauge_width/2, ALU_profile_width/2+7+strain_gauge_width])
rotate([0, 0, -90])
color([1, 0, 0]) 888_5002();