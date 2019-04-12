//prumer loziska 10 mm
//pocinato se sroubem M8 o min delce 20 mm

include <../src/Parameters.scad>
inner_diameter = M8_screw_diameter;
rim_outer_diameter=12;
rim_height = 2;
//bearng_ball_height = 9/2-0.5;
//inner_diameter = M6_screw_diameter - 0.25;
//outer_diameter = bearing_efsm_10_d + 3;

module 888_3016(draft = true){

    difference(){
        union(){
            cylinder(h = rim_height, d = rim_outer_diameter, $fn = 100);
            translate([0,0,rim_height])
                cylinder(h = (bearing_EFOM_10_h/2)-0.5, d = bearing_EFOM_10_d1, $fn = 100);
        }
        cylinder(h = 2 * bearing_EFOM_10_h , d = inner_diameter, $fn = 100);
    }
}
888_3016();
