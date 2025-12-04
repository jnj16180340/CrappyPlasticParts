$fn = 192;

// ---- Parameters (all mm) ----
flange_radius = 15;   // target max radius
tube_length   = 35;   // mouthpiece tube
tube_outer_r  = 10;
tube_inner_r  = 7;

// Big numbers that comfortably enclose the whole part
trim_outer_r  = 100;
trim_height   = 100;

mount_z = -7;

filler_thickness = 8;    // total height of the filler ring
filler_z         = -3.8;    // vertical 


// ---- Mouthpiece tube (centered on STL) ----
module mouthpiece_tube() {
    difference() {
        // solid tube, centered on origin
        cylinder(r = tube_outer_r, h = tube_length, center = true);

        // bore
        cylinder(r = tube_inner_r, h = tube_length + 0.2, center = true);
    }
}


// ---- STL + tube, before trimming ----
module lug_plus_tube_raw() {
    union() {
        import("3M_LugMount.stl", center = true, convexity = 10);

        // adjust Z if needed so tube meets the lug nicely
        // (right now it's centered on the STL)
        translate([0, 0, mount_z])
        color([1,0,0])
        mouthpiece_tube();
    }
}

module flange_filler() {
    translate([0, 0, filler_z])  // move in Z to line up with your green area
    difference() {
        // outer boundary = trimmed flange radius
        cylinder(r2 = flange_radius, r1=tube_outer_r, h = filler_thickness, center = true);

        // inner boundary = keep clearance around tube
        cylinder(r = tube_outer_r, h = filler_thickness + 0.2, center = true);
    }
}

// ---- Radial trim: remove everything with r > flange_radius ----
module radial_trim_cutter() {
    difference() {
        // big solid cylinder
        cylinder(r = trim_outer_r, h = trim_height, center = true);

        // keep inside this radius by subtracting inner cylinder
        cylinder(r = flange_radius, h = trim_height + 2, center = true);
    }
}


// ---- Final object ----
difference() {
    union() {
    lug_plus_tube_raw();     // STL + tube
    color([0,1,0]) flange_filler();
    }
    radial_trim_cutter();    // chop away outer flange beyond flange_radius
}
