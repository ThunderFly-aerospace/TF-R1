include <../../parameters.scad>

module 888_5002() {
    joint_width = 8;
    
    module holder() {
        translate([0, 0, 2]) {
            difference() {
                hull() {
                    cube([(strain_gauge_width-joint_width)/2, strain_gauge_screw_distance+10, 5]);
                    translate([0, strain_gauge_screw_distance/2+5, 15])
                        rotate([0, 90, 0])
                            cylinder(d=strain_gauge_screw_distance, h=(strain_gauge_width-joint_width)/2, $fn=50);
                            
                }
                translate([0, strain_gauge_screw_distance/2+5, 15])
                    rotate([0, 90, 0])
                        cylinder(d = M5_screw_diameter, h=(strain_gauge_width-joint_width)/2, $fn=20);
            }
        }
    }
    
    difference() {
        cube([strain_gauge_width, strain_gauge_screw_distance+10, 2]);
        translate([strain_gauge_width/2, 5, 0]) {
            cylinder(d=M4_screw_diameter, h=3, $fn=20);
            translate([0, strain_gauge_screw_distance, 0])
                cylinder(d=M4_screw_diameter, h=3, $fn=20);
        }
    }
    holder();
    translate([strain_gauge_width-(strain_gauge_width-joint_width)/2, 0, 0])
        holder();
}

888_5002();