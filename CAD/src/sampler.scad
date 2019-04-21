// Sampler.scad - library for parametric airfoils of 4 digit NACA series
// Code: Rudolf Huttary, Berlin 
// June 2015
// commercial use prohibited

 use <lib/shortcuts.scad>  // see: http://www.thingiverse.com/thing:644830
 use <lib/naca4.scad>
 
place_in_rect(110, 70) // arange that stuff in a grid
{
// duct
//  T(50, 30, 0)
//  rotate_extrude($fn = 100)
//  translate([30, 100, 0])
//  R(0, -180, 90)
//  polygon(points = airfoil_data([-.1, .4, .1], L=100)); 

// drop
T(50, 30, 0)
scale([1, 1.1])
rotate_extrude()
Rz(90)
difference()
{
  polygon(points = airfoil_data(40)); 
  square(100, 100); 
}

airfoil(naca = 0008, L = 60, N=101, h = 30, open = false); 

// some airfoil objects, Naca values defined with number or vector
 //airfoil ();                  // NACA12 object 
 //airfoil (2417);              // NACA2417 object 
 //airfoil ([.2, .4, .17]);     // NACA2417 object 
 //airfoil ([-.10101, .52344, .17122]); // inverted precise curvature

//help();  // show help in console

}




