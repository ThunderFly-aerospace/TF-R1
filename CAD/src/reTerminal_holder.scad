include <../parameters.scad>


module reTerminal() {
	cube([139.5, 96.5, 23]);

	translate([(139.5-133.5)/2, 12.5, 22])
	cube([133.5, 80.5, 5]);
	
	translate([-10, 10.5, 23/2])
	rotate([0, 90, 0])
	cylinder(d=4.3, h=160, $fn=30);
	
	translate([-10, 10.5+76, 23/2])
	rotate([0, 90, 0])
	cylinder(d=4.3, h=160, $fn=30);
}

module reTerminal_holder() {
	difference() {
		hull() {
			rotate([60, 0, 0])
			translate([0, 11, -15])
			cube([139.5+4, 96.5+2, 21]);

			cube([139.5+4, 96.5+2, 21]);
		}

		translate([2, 0, 2])
		hull() {
			rotate([60, 0, 0])
			translate([0, 11, -15])
			cube([139.5, 96.5-1.75, 25]);

			translate([0, 18, 0])
			cube([139.5, 96.5-5, 21]);
		}

		translate([2, 50, 20])
		cube([139.5, 90, 65]);

		rotate([60, 0, 0])
		translate([2, 11, -15])
		reTerminal();
	}
}


rotate([60, 0, 0])
translate([2, 11, -15])
#reTerminal();

difference() {
reTerminal_holder();
translate([-5, -5, -5])
cube([50, 150, 150]);
}
