//prumer loziska 10 mm
//pocinato se sroubem M8 o min delce 20 mm

include <../src/Parameters.scad>
outer_diameter = 10;
inner_diameter = M8_screw_diameter+0.25;//9+0,25
rim_outer_diameter=12;
module 888_3016(draft = true){

    //inner_diameter = M6_screw_diameter - 0.25;
    //outer_diameter = bearing_efsm_10_d + 3;
    rim_height = 2;
    bearng_ball_height = 9/2;
    difference(){
        union(){
            cylinder(h = rim_height, d = rim_outer_diameter, $fn = 50);
            translate([0,0,rim_height])
                cylinder(h = bearng_ball_height, d = outer_diameter, $fn = 50);
        }
        cylinder(h = 2 * bearng_ball_height , d = inner_diameter, $fn = 50);
    }
}
888_3016();
