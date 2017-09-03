// Sampler.scad - library for parametric airfoils of 4 digit NACA series
// Code: Rudolf Huttary, Berlin 
// June 2015
// commercial use prohibited

 use <shortcuts.scad>  // see: http://www.thingiverse.com/thing:644830
 use <naca4.scad>
 
place_in_rect(110, 70) // arange that stuff in a grid
{
// duct
  T(50, 30, 0)
  rotate_extrude($fn = 100)
  translate([30, 100, 0])
  R(0, -180, 90)
  polygon(points = airfoil_data([-.1, .4, .1], L=100)); 

// drop
T(50, 30, 0)
scale([1, 2])
rotate_extrude()
Rz(90)
difference()
{
  polygon(points = airfoil_data(30)); 
  square(100, 100); 
}

// some winding airfoils
linear_extrude(height = 100, twist = 30, scale = .5)
  polygon(points = airfoil_data(30)); 

translate([50, 0, 0])
linear_extrude(height = 100, twist = 30, scale = .5)
translate([-50, 0, 0])
  polygon(points = airfoil_data(30)); 

translate([100, 0, 0])
linear_extrude(height = 100, twist = 30, scale = .5)
translate([-100, 0, 0])
  polygon(points = airfoil_data(30)); 

T(30)
 airfoil(naca = 2432, L = 60, N=101, h = 30, open = false); 

// some airfoil objects, Naca values defined with number or vector
 airfoil ();                  // NACA12 object 
 airfoil (2417);              // NACA2417 object 
 airfoil ([.2, .4, .17]);     // NACA2417 object 
 airfoil ([-.10101, .52344, .17122]); // inverted precise curvature

help();  // show help in console

// end of sampler

}




