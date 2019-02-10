

main_screw = 6.3;
clamp_screw = 3.5;
clamp_screw_head_d = 6.3;
clamp_screw_head_h = 3.5;
width = 15;

cables = 2;
cable_thickness = [5, 7, 7, 5];

side_a = round(cables/2);
side_b = cables-side_a;
length = 29*(cables+1);
thickness = 8;

module cable_clamp_a(){

difference(){
    translate([-width/2, -length/2, 0])
        cube([width, length, thickness]);
    
    cylinder(d=main_screw, h=thickness+0.2);
    
    for (x = [1:side_a]){
        translate([0, x*28+10, -0.1]){
            
            translate([0, 0, clamp_screw_head_h+0.2])
                cylinder(d = clamp_screw, h = thickness+0.2);
            cylinder(d = clamp_screw_head_d, h = clamp_screw_head_h);
            translate([0, 0, thickness - clamp_screw_head_h+0.2])
                cylinder(d = clamp_screw_head_d, h = clamp_screw_head_h, $fn=6);
            
            translate([-width/2, -10, thickness])
                rotate([0, 90, 0])
                    scale([1, 1.5, 1])
                        cylinder(h = width+0.2+10, d = cable_thickness[x], $fn=15);
        }
        
        
        translate([0, x*28+10-20, -0.1]){
            translate([0, 0, clamp_screw_head_h+0.2])
                cylinder(d = clamp_screw, h = thickness+0.2);
            cylinder(d = clamp_screw_head_d, h = clamp_screw_head_h);
            translate([0, 0, thickness - clamp_screw_head_h+0.2])
                cylinder(d = clamp_screw_head_d, h = clamp_screw_head_h, $fn=6);
        }   
    }
    for (x = [1:side_b]){
        translate([0, -x*28-10, -0.1]){
            
            translate([0, 0, clamp_screw_head_h+0.2])
                cylinder(d = clamp_screw, h = thickness+0.2);
            cylinder(d = clamp_screw_head_d, h = clamp_screw_head_h);
            translate([0, 0, thickness - clamp_screw_head_h+0.2])
                cylinder(d = clamp_screw_head_d, h = clamp_screw_head_h, $fn=6);
            
            translate([-width/2, +10, thickness])
                rotate([0, 90, 0])
                    scale([1, 1.5, 1])
                        cylinder(h = width+0.2+10, d = cable_thickness[x], $fn=15);
        }
        
        
        translate([0, -x*28-10+20, -0.1]){
            translate([0, 0, clamp_screw_head_h+0.2])
                cylinder(d = clamp_screw, h = thickness+0.2);
            cylinder(d = clamp_screw_head_d, h = clamp_screw_head_h);
            translate([0, 0, thickness - clamp_screw_head_h+0.2])
                cylinder(d = clamp_screw_head_d, h = clamp_screw_head_h, $fn=6);
        }   
    }
    
}    
}


module cable_clamp_b(){
    difference(){
      translate([-width/2, -13.5, 0])
        cube([width, 27, 7]);
        
    translate([-width/2, 0, 7+1])
        rotate([0, 90, 0])
            scale([1, 1.5, 1])
                cylinder(h = width+0.2+10, d = 7, $fn=15);

    translate([0, 10, 0])
    cylinder(d = clamp_screw, h = thickness+0.2, $fn=15);

    translate([0, -10, 0])
    cylinder(d = clamp_screw, h = thickness+0.2, $fn=15);


    
    }
}

//cable_clamp_a();
translate([20, 28, 0]) cable_clamp_b();
