plate_height = 70;
plate_width = 50;
plate_radius = 10;

thron_size = 80;
thron_height = 7.5;
thron_width = 15;
thron_thickness = 3;

module thron() {
	bottom_points = [
		[thron_width/2, thron_size, 0],
		[thron_width/2, thron_size, thron_thickness],
		[thron_width/-2, thron_size, thron_thickness],
		[thron_width/-2, thron_size, 0],
		[0, 0, 0],
		[0, 5, thron_thickness],
	];

	bottom_faces = [[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]];

	top_points = [
		[thron_thickness/2, thron_size, thron_height+thron_thickness],
		[thron_thickness/-2, thron_size, thron_height+thron_thickness],
		[thron_thickness/-2, thron_size, thron_thickness],
		[thron_thickness/2, thron_size, thron_thickness],
		[thron_thickness/2, 15, thron_thickness],
		[thron_thickness/-2, 15, thron_thickness]
	];

	top_faces = [[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]];

	polyhedron(top_points, top_faces);
	polyhedron(bottom_points, bottom_faces);
}
echo(thron_thickness);

translate([(plate_width-plate_radius*2)/-2, plate_radius, 0]) {
	minkowski() {
		cube([plate_width-plate_radius*2, plate_height-plate_radius*2, thron_thickness/2]);
		cylinder(r=plate_radius, h=thron_thickness/2);
	}
}
translate([0, -thron_size, 0]) thron();
translate([thron_thickness/-2, 0, thron_thickness]) cube([thron_thickness, plate_height, thron_height]);