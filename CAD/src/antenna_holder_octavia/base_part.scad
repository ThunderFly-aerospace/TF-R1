

beam_top_width = 31;
beam_bottom_width = 21;
beam_height = 25;

holder_width = 40;
below_beam = 8;


min_wall = 5;

M4_screw_diameter = 4.3;
M4_nut_diameter = 10;
M4_nut_height = 4;

lock_thickness = 8;
lock_join_width = 30;
lock_conection_width = 15;
lock_clearence = 0.5;


lock_around_wall = (holder_width-lock_join_width)/2;

module bottom_part(){

    difference(){
    translate([0, -holder_width/2, -below_beam])
        cube([beam_top_width + 2*M4_screw_diameter + 4*3, holder_width, below_beam+beam_height]);

    translate([beam_top_width/2+ M4_screw_diameter + 2*3, 0, 0]) rotate([90, 0, 0]) hull(){
        translate([beam_bottom_width/2 - 3/2, 3/2, 0])
            cylinder(d = 3, h = 100, center = true, $fn = 50);
        translate([-beam_bottom_width/2 + 3/2, 3/2, 0])
            cylinder(d = 3, h = 100, center = true, $fn = 50);

        translate([beam_top_width/2 - 3/2, beam_height, 0])
            cylinder(d = 3, h = 100, center = true, $fn = 50);
        translate([-beam_top_width/2 + 3/2, beam_height, 0])
            cylinder(d = 3, h = 100, center = true, $fn = 50);
    }

    for(x = [3+M4_screw_diameter/2, 3*3+1.5*M4_screw_diameter+beam_top_width], y=[-holder_width/3*1, holder_width/3])
        translate([x, y, -below_beam]){
            cylinder(d = M4_screw_diameter, h = 100, $fn = 30);

        }
    }



    difference(){
        translate([-(lock_thickness+lock_around_wall), -holder_width/2, -below_beam])
            cube([lock_thickness+lock_around_wall, holder_width, below_beam+beam_height]);

        translate(){
            translate([-(lock_thickness), -lock_join_width/2, 0])
                cube([lock_thickness, lock_join_width, below_beam+beam_height+1]);
            translate([-(lock_thickness)-20, -lock_conection_width/2, 0])
                cube([lock_thickness+20, lock_conection_width, below_beam+beam_height+1]);
        }

    }

}

module top_part(){

    difference(){
        translate([0, -holder_width/2, 0])
            cube([beam_top_width + 2*M4_screw_diameter + 4*3, holder_width, 10]);

        for(x = [3+M4_screw_diameter/2, 3*3+1.5*M4_screw_diameter+beam_top_width], y=[-holder_width/3*1, holder_width/3])
            translate([x, y, -0.1]){
                cylinder(d = M4_screw_diameter, h = 100, $fn = 30);
            }
    }
    difference(){
        translate([-(lock_thickness+lock_around_wall), -holder_width/2, 0])
            cube([lock_thickness+lock_around_wall, holder_width, 10]);

        translate(){
            translate([-(lock_thickness), -lock_join_width/2, 0])
                cube([lock_thickness, lock_join_width, below_beam+beam_height+1]);
            translate([-(lock_thickness)-20, -lock_conection_width/2, 0])
                cube([lock_thickness+20, lock_conection_width, below_beam+beam_height+1]);
        }
    }
}



module antenna_5g_holder(){

        difference(){
            union(){
                translate([0, 0, 0]) cylinder(d1 = 20+10, d2=30+10, h=10, $fn=100);
                translate([0, 0,10]) cylinder(d1 = 30+10, d2=35+10, h=25, $fn=100);
                translate([0, 0,35]) cylinder(d = 35+10, h=5, $fn=100);

                translate([-lock_clearence, -(lock_conection_width-lock_clearence)/2, 0])
                    cube([40, lock_conection_width-lock_clearence, 35]);
                translate([40-lock_thickness, -(lock_join_width-lock_clearence)/2, 0])
                    cube([lock_thickness-lock_clearence, lock_join_width-lock_clearence, 35]);
            }

            union(){
                translate([0, 0, 0]) cylinder(d = 20, h=10, $fn=100);
                translate([0, 0,10]) cylinder(d = 30, h=25, $fn=100);
                translate([0, 0,35]) cylinder(d = 35, h=10, $fn=100);
            }

        }

}

translate([-40, 0, 0])
antenna_5g_holder();

bottom_part();

translate([0, 0, beam_height+1]) top_part();
