plate_height = 70;
plate_width = 50;
plate_radius = 10;
plate_thickness = 2;

module plate() {
	translate([plate_radius-plate_width/2, plate_radius, 0]) minkowski() {
		cube([plate_width-plate_radius*2, plate_height-plate_radius*2, plate_thickness/2]);
		cylinder(r=plate_radius, h=plate_thickness/2, $fn=50);
	}
}

//plate();