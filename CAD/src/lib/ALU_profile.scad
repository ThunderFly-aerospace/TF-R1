// Aleksandr Saechnikov 09 june 2015

ALU_profile(height=100, size=30);

module ALU_profile(size=30, height=10, radius=1.5, step=0.5) {

	linear_extrude(height=height) {
		union() {
			sub_extrusion_profile(size, radius, step);
			rotate([0,0,90])  sub_extrusion_profile(size, radius, step);
			rotate([0,0,180]) sub_extrusion_profile(size, radius, step);
			rotate([0,0,270]) sub_extrusion_profile(size, radius, step);
		}
	}
    
    module sub_extrusion_profile(size=30, radius = 1.5, step=0.5) {

        reSize = size/30; // Scalling

        k0 = 0;
        k2 = 3.65*reSize;
        k1 = k2*cos(45);

        k3 = 4*reSize;
        k4 = 6*reSize;
        k5 = 8.25*reSize; k5_2 = k5 + k4 - k3;
        k6 = 12.8*reSize;
        k7 = 15*reSize;

        _radius = radius;// OR  *reSize -- Corner radius
        _step = step;    // OR  *reSize -- Step size

        polygon(points=[
            [k1,k1],[0,k2], // Center hole
            [0,k4],[k3,k4],[k5,k5_2],[k5,k6],[k3,k6],
            [k3,k7-_step],[k3+_step,k7-_step],[k3+_step,k7], //Step
            [k7-_radius,k7],[k7-_radius*(1.-cos(45)),k7-_radius*(1.-cos(45))],[k7,k7-_radius],// Corner
            [k7,k3+_step],[k7-_step,k3+_step],[k7-_step,k3], // Step
            [k6,k3],[k6,k5],[k5_2,k5],[k4,k3],[k4,0],
            [k2,0]  // Center hole
        ]);
    }
}







