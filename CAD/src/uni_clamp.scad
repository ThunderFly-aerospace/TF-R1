//M. Haris Usmani
//http://harisusmani.com

//All Units are in mm, 

/* [Main Settings] */
//Diameter of Pipe in milimeters 
R=12; 

//Space for Tightening
T=1; //[0:5]

//Nut Size
M=5.5; //[4,5,6]

/////////////////////////////////////////////////////////////////////////////
//Strength of Clamp (Fixed)
S=1.2; // [1.2] Determines Strength of Clamp in Percentage-FIXED!

/////////////////////////////////////////////////////////////////////////////
//Hexagonal Module from shapes.scad, http://svn.clifford.at/openscad/trunk/libraries/shapes.scad by Catarina Mota
module hexagon(size, height) {
  boxWidth = size/1.75;
  for (r = [-60, 0, 60]) rotate([0,0,r]) cube([boxWidth, size, height], true);
}
/////////////////////////////////////////////////////////////////////////////

//Pipe Model for Visualization
//translate([R*S/2,R*S/2,-R*6]) cylinder(R*10,R/2,R/2);

union()//Main Duplication
{

difference() //Pipe Hole
{
union()
{
minkowski() //Fillet
{
	union()
	{
		cube([R*S,R/2*S, R*S]); //Main Body
		translate([R*S/2,R*S/2,0]) cylinder(R*S,R*S/2,R*S/2); //Curved Edge
	}
	sphere([R/2,R,R*5/12]); //Fillet Object
}

minkowski() //Fillet
{
	difference() //Hard Chamfer
	{
		translate([-R/4,R/5,(R/2)-(R*5/48)]) cube([R/2,R/1.4,R*5/12]);
		translate([-R,-R*7/17,(R/2)-(R*5/24)]) rotate([0,0,-33]) cube([R/2,R,2*R*5/12]);
	}
	sphere([R/2,R,R*5/12]); //Fillet Object
}
}
	union()
	{
		translate([R*S/2,R*S/2,-R*6]) cylinder(R*10,R/2,R/2);//Pipe
		translate([-R,R*S*5/12,-R]) cube([R*2,R/(15-T),R*4]);//Tightning Space
		translate([-R/7,R*2,(R*S/2)]) rotate([90,0,0]) cylinder((R*4),M/2,M/2); //Screw Space
		if (M==4) translate([-R/7,-R*0.2,(R*S/2)]) rotate([90,0,0]) hexagon(7.66,50); //NUTS
		if (M==5) translate([-R/7,-R*0.2,(R*S/2)]) rotate([90,0,0]) hexagon(8.79,50);
		if (M==6) translate([-R/7,-R*0.2,(R*S/2)]) rotate([90,0,0]) hexagon(11.05,50);
	}
} //Single Side ENDS

}

{

translate([R*S,1,R*S]) rotate([180,90,0]) //Main Translation

//COPY SIDE HERE
difference() //Pipe Hole
{
union()
{
minkowski() //Fillet
{
	union()
	{
		cube([R*S,R/2*S, R*S]); //Main Body
		translate([R*S/2,R*S/2,0]) cylinder(R*S,R*S/2,R*S/2); //Curved Edge
	}
	sphere([R/2,R,R*5/12]); //Fillet Object
}

minkowski() //Fillet
{
	difference() //Hard Chamfer
	{
		translate([-R/4,R/5,(R/2)-(R*5/48)]) cube([R/2,R/1.4,R*5/12]);
		translate([-R,-R*7/17,(R/2)-(R*5/24)]) rotate([0,0,-33]) cube([R/2,R,2*R*5/12]);
	}
	sphere([R/2,R,R*5/12]); //Fillet Object
}
}
	union()
	{
		translate([R*S/2,R*S/2,-R*6]) cylinder(R*10,R/2,R/2);//Pipe
		translate([-R,R*S*5/12,-R]) cube([R*2,R/(15-T),R*4]);//Tightning Space
		translate([-R/7,R*2,(R*S/2)]) rotate([90,0,0]) cylinder((R*4),M/2,M/2); //Screw Space
		if (M==4) translate([-R/7,-R*0.2,(R*S/2)]) rotate([90,0,0]) hexagon(7.66,50); //NUTS
		if (M==5) translate([-R/7,-R*0.2,(R*S/2)]) rotate([90,0,0]) hexagon(8.79,50);
		if (M==6) translate([-R/7,-R*0.2,(R*S/2)]) rotate([90,0,0]) hexagon(11.05,50);
	}
}
///////////////
}

//preview[view: north, tilt: top];
