include <../../parameters.scad>

// EFOM-10 Flange bearing
bearing_length = 52;
bearing_width = 26;
bearing_height = 12;
bearing_bolt_distance = 36;

// Borrowed from model 888_3009
g3_0_srcew_dist = 55;

// CONFIGURABLE PARAMETERS
platform_height = bearing_length;
piston_holder_size = bearing_length * 1.3;

// END OF PARAMETERS

// Calculate angle for base platform cylinder spacing:
a1 = platform_base_cylinder_spacing/2; // piston offset -> two pistons, one on each side
                                       // of the bar sitting in the middle if its half.
b1 = platform_base_diameter/2;
c1 = platform_base_diameter/2;
alfa1 = acos((b1*b1 + c1*c1 - a1*a1) / (2*b1*c1));
echo("Piston base offset angle is ", alfa1);
piston_base_offset_angle = alfa1;

// Calculate angle for top platform cylinder spacing
a2 = platform_top_cylinder_spacing/2;
b2 = platform_top_diameter/2;
c2 = platform_top_diameter/2;
alfa2 = acos((b2*b2 + c2*c2 - a2*a2) / (2*b2*c2));
echo("Piston top offset angle is ", alfa2);
piston_top_offset_angle = alfa2;

// Calculate horizontal distance between upper and lower base holds and
// horizontal rotation of piston:
a = platform_top_diameter/2;
b = platform_base_diameter/2;
// angle between upper and lower base holds
gamma = 60 - piston_base_offset_angle - piston_top_offset_angle;
echo("Angle between holds is ", gamma);
// horizontal distance between upper and lower base holds
c = sqrt(a*a + b*b - 2*a*b*cos(gamma));
echo("Horizontal distance between holds is", c);
// horizontal angle between lower base axis and piston
alfa = acos((b*b + c*c - a*a) / (2*b*c));
echo("Horizontal angle of piston is ", alfa);
horizontal_piston_angle = alfa;

// Calculate vertical angle between lower base and piston:
vertical_piston_angle = acos(c / platform_cylinder_medium_length);
echo("Vertical angle of piston is ", vertical_piston_angle);

// Calculate vertical distance between platforms:
vertical_distance_of_plaftorms = 
    sqrt(platform_cylinder_medium_length*platform_cylinder_medium_length - c*c);
echo("Vertical distance of platforms is ",vertical_distance_of_plaftorms);
