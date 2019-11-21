include <../parameters.scad>
draft = false;
$fn =  draft ? 50 :100;


pipe_outer_diameter = carbon_pipe_10_outer_diameter;
pipe_depth = 20;

difference(){

	union(){
		cylinder(d = pipe_outer_diameter+6, h = pipe_depth);
		cylinder(d = pipe_outer_diameter+6, h = pipe_depth + 7);
		cylinder(d = M8_screw_diameter, h = pipe_depth + 7 + 4);
	}

	cylinder(d = pipe_outer_diameter, h = pipe_depth - layer_thickness);

	// svisly M4 sroub
	translate([0, 0, pipe_depth])
		cylinder(d = M4_screw_diameter, h = 3);

	translate([0, 0, pipe_depth + 1 + M4_nut_height + layer_thickness])
		cylinder(d = M4_screw_diameter, h = pipe_depth - layer_thickness);

	translate([0, 0, pipe_depth + 1])
		rotate(30)
			cylinder(d = M4_nut_diameter, h = M4_nut_height, $fn = 6);

	translate([0, -M4_nut_diameter/2, pipe_depth +1])
		cube([20, M4_nut_diameter, M4_nut_height]);


	// prosroubovani tyce
	translate([0, 0, 5])
		rotate([90, 0, 0])
			cylinder(d= M3_screw_diameter, h = 50, center = true);

	translate([0, -6.5, 5])
		rotate([90, 0, 0])
			rotate(30)
				cylinder(d= M3_nut_diameter, h = 50, $fn = 6);

	translate([0, 50+6.5, 5])
		rotate([90, 0, 0])
			rotate(30) 
				cylinder(d= M3_nut_diameter, h = 50, $fn = 6);

}
