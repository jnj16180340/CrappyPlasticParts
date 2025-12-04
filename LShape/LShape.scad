// ----------------------------------------
// L-shaped plate with midpoint holes
// All main dimensions in inches
// ----------------------------------------

INCH = 25.4;     // mm per inch
$fn  = 96;       // smooth circles

// Top-level parameters (all in inches)
leg_x_in        = 2;      // length of horizontal leg (X direction)
leg_y_in        = 2;      // length of vertical leg (Y direction)
leg_width_in    = 0.5;      // width of each leg
thickness_in    = 0.9;   // extrusion thickness (Z)
hole_diameter_in = 0.25;  // diameter of holes in each leg

// 2D L profile in the XY plane, with holes
module L_profile_with_holes(leg_x_in, leg_y_in, leg_width_in, hole_diameter_in) {
    lx = leg_x_in     * INCH;
    ly = leg_y_in     * INCH;
    w  = leg_width_in * INCH;
    r  = (hole_diameter_in * INCH) / 2;

    difference() {
        // Base L shape
        union() {
            // Horizontal leg (along +X)
            square([lx, w], center = false);

            // Vertical leg (along +Y)
            square([w, ly], center = false);
        }

        // Hole at midpoint of horizontal leg
        translate([lx/2, w/2])
            circle(r = r);

        // Hole at midpoint of vertical leg
        translate([w/2, ly/2])
            circle(r = r);
    }
}

// 3D L-shaped plate: extrude the 2D profile with holes
module L_plate(
    leg_x_in         = leg_x_in,
    leg_y_in         = leg_y_in,
    leg_width_in     = leg_width_in,
    thickness_in     = thickness_in,
    hole_diameter_in = hole_diameter_in
) {
    linear_extrude(height = thickness_in * INCH, center = false)
        L_profile_with_holes(leg_x_in, leg_y_in, leg_width_in, hole_diameter_in);
}

// ------------------------
// Example call
// ------------------------
L_plate();
