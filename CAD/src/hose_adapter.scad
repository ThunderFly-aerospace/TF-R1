include <lib/stdlib/polyScrewThread_r1.scad>

module vac_adapter(draft = false)
{
h_i_d = 50;  // holder inner diameter
h_o_d = 70; // holder outer diameter
lt = 15;  // total length of holder

// od - Thread major diameter (in_o_d) // celkový obvod
// st - Thread pitch (gap) // kolik bude závitů
// lf0 - Thread angle // sklon závitu (tim pádem i hloubka)
// lt - Thread length // výška
// rs - Thread rotational symmetry // jemnost závitu
// cs - Chamfer style (1, 2, or 3) // zakončení závitu

  difference()
  {
    cylinder(h = lt, d = h_o_d);
    screw_thread(h_i_d, 9, 25, lt*2, 1, 1);
    cylinder(h = lt, d = h_i_d-10`);
  }
}

vac_adapter();
