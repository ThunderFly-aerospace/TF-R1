//prumer loziska 10 mm
//pocinato se sroubem M8 o min delce 20 mm

include <../../parameters.scad>
inner_diameter = M6_screw_diameter;
rim_outer_diameter=12;
rim_height = 1.5;

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
