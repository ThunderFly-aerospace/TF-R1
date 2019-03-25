//terrain: asphalt, concrete, stone

include<plate.scad>;


plate_angle = 70;

module easel() {
	difference() {
		cube([plate_width-plate_radius*2, 50, 35]);
		rotate([-90+plate_angle, 0, 0]) translate([0, -40, 0]) cube([plate_width-plate_radius*2, 40, 60]);
		rotate([-90+plate_angle, 0, 0]) translate([2, 2, 0]) cube([plate_width-plate_radius*2-4, 50, 50]);
		rotate([-90+plate_angle, 0, 0]) translate([0, -0.5, 35]) cube([plate_width-plate_radius*2, 50, 50]);
	}
}
translate([(plate_width-plate_radius*2)/-2, 0, plate_thickness]) easel();
plate();

