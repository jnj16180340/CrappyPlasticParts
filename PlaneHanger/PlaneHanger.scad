$fn = 256;

// ---- Parameters (all mm) ----
disc_d        = 80;        // 8 cm diameter
disc_h        = 20;        // 2 cm thickness
disc_r        = disc_d / 2;

hole_d        = 5.50;      // center hole
hole_r        = hole_d / 2;

countersink_d   = 10.5;
countersink_r   = countersink_d/2;
countersink_z = 4;

notch_thick   = 6;         // 6 mm deep (through thickness / along Z)
tangent_d     = 40;        // notch is tangent to circle at 4 cm diameter
tangent_r     = tangent_d / 2;

// Extra margin so the notch "block" fully clears the outer edge
notch_margin  = 2;

// Radial extent of the notch block (X direction)
notch_len_x   = (disc_r - tangent_r) + notch_margin;
// Tangential extent (Y direction) – just make it longer than the disc
notch_len_y   = disc_d + 2 * notch_margin;


difference() {
    // Main disc, centered at origin
    cylinder(r = disc_r, h = disc_h, center = true);


    cylinder(r = hole_r, h = disc_h + 2, center = true);
    
    translate([0,0,disc_h/2- countersink_z])
    color("green")
    cylinder(r = countersink_r, h = countersink_z, center = false);

    // Side notch:
    // - Centered at Z=0, thickness = notch_thick
    // - Inner face at radius = tangent_r (tangent to 4 cm circle)
    // - Extends outward past the disc edge
    translate([tangent_r + notch_len_x/2, 0, 0])
        cube([notch_len_x, notch_len_y, notch_thick], center = true);
}


/*
    union() {
    // Center hole
    cylinder(r = hole_r, h = disc_h + 2, center = true);
    translate([0,0,disc_h/2]) color("green") cylinder(r = 10/2, h = 4/2, center = false);
    }
    */
