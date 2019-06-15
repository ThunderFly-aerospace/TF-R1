include <../../parameters.scad>

module bolt(size = 4, length = 35, pocket = true, pocket_size = 35, washer = false,
            square_nut = false)
{
    bolts = [//size | bolt d | head h | head d | nut h | nut d | nut pckt 
             [10    ,  10.4  , 10     , 16.5   , 10.5  , 25.5  , 22.3],
             [8     ,  8.6   , 8      , 13.5   , 7.5   , 14.9  , 13.5],
             [6     ,  6.5   , 6      , 10.5   , 4.9   , 11.8  , 10.4],
             [5     ,  5.5   , 5      , 13.5   , 4.5   , 9.4   , 8.4 ],
             [4     ,  4.5   , 4      , 8.4    , 3.2   , 8.4   , 7.5 ],
             [3     ,  3.2   , 3      , 6.6    , 2.7   , 6.6   , 6.6 ],
             [2.5   ,  2.7   , 2.3    , 6      , 2.3   , 6     , 5.5 ],
            ];
    bolt_diameter = bolts[search(size, bolts)[0]][1];
    head_height   = bolts[search(size, bolts)[0]][2];
    head_diameter = bolts[search(size, bolts)[0]][3];
    nut_height    = bolts[search(size, bolts)[0]][4];
    nut_diameter  = bolts[search(size, bolts)[0]][5];
    nut_pocket    = bolts[search(size, bolts)[0]][6];

    // bolt
    color("gray", 1)
        cylinder(h = length + head_height, d = bolt_diameter);
    // bolt pocket
    translate([0, 0, length + head_height])
        cylinder(h = head_height, d = bolt_diameter);
    // head
    color("gray")
        cylinder(h = head_height, d = head_diameter);
    // head pocket
    translate([0, 0, -length])
        cylinder(h = length, d = head_diameter);
    // nut TODO square nut option
    if (square_nut == false)
        color("gray")
            translate([0, 0, length - global_clearance])
                cylinder(h = nut_height + global_clearance, d = nut_diameter, $fn=6);
    // nut pocket TODO square nut option
    if (pocket == true)
        translate([-pocket_size, -nut_pocket/2, length - global_clearance])
            cube([pocket_size, nut_pocket, nut_height + global_clearance]);
    // TODO washer
}

// Example
bolt(10);
translate([0, 30, 0])
    bolt(8);
translate([0, 60, 0])
    bolt(6);
translate([0, 90, 0])
    bolt(5);
translate([0, 120, 0])
    bolt(4);
translate([0, 150, 0])
    bolt(3);
translate([0, 180, 0])
    bolt(2.5);
