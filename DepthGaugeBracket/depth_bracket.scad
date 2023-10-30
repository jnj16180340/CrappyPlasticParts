/*
VERSION 2:
DO ALL BOOLEAN OPERATIONS IN 2-D THEN EXTRUDE
TO REMOVE FUDGEFACTOR AND FLOATING POINT ERROR
*/

/* Measurements */

THICKNESS = 10.0;

BOLT = 6.40; // 1/4-20 bolt maybe?

DIAMETER_INNER = 40.0; // big hole around the chuck

WIDTH_OUTER_COLLAR = 3;
WIDTH_COLLAR = 2.25;
DEPTH_COLLAR = 2.5;

NORMAL_TO_DEPTHHOLE = 18.0; // from inner chuck ring - how far it pokes out idk
NORMAL_OFFSET_DEPTHHOLE = 2.0; // from inner chuck ring - towards center of hole

BAR = 16.5;
BAR_CENTERS_OFFSET = 20; // (18.x?)
BAR_LEN = 40;

/* DERIVED FROM MEASUREMENTS */

RADIUS_INNER = DIAMETER_INNER / 2;
RING_THICKNESS = WIDTH_COLLAR + WIDTH_OUTER_COLLAR; // of the chuck ring
RADIUS_OUTER = RADIUS_INNER + RING_THICKNESS;

/* META */

FUDGE = 0.01; // add to negative space so floating point error doesn't make
              // render weird

outer_radius = (DIAMETER_INNER / 2) + WIDTH_COLLAR + WIDTH_OUTER_COLLAR;

/* RENDERING PARAMETERS */
// NB! Circle intersection fudge depends on this
 $fa = 12;
 $fs = 0.1;
 $fn = 360;


/* That Thing */

module blackhole() { cylinder(r = 2 * outer_radius, h = 1, center = false); }

module cleanup() {
  translate([ 0, 0, THICKNESS - FUDGE ]) { blackhole(); }
  translate([ 0, 0, FUDGE ]) {
    mirror([ 0, 0, 1 ]) { blackhole(); }
  }
}

// cleanup();

module chuck_ring_positive() {

  cylinder(r = outer_radius, h = THICKNESS, center = false);
}

module chuck_ring_negative() {
  // main hole through which the chuck goes
  cylinder(r = DIAMETER_INNER / 2, h = THICKNESS, center = false);

  // the collar it sits on
  translate([ 0, 0, THICKNESS - DEPTH_COLLAR ]) {
    cylinder(r = (DIAMETER_INNER / 2) + WIDTH_COLLAR, h = DEPTH_COLLAR,
             center = false);
  }
}

module chuck_ring() {
  difference() {
    chuck_ring_positive();
    chuck_ring_negative();
  }
}

module clamper_half() {
  ff2 = 50; // "fudgefactor factor"
  translate([ 0, RADIUS_OUTER - ff2 * FUDGE, 0 ]) {
    difference() {
      // POSITIVE
      cube([ THICKNESS / 2, THICKNESS + ff2 * FUDGE, THICKNESS ]);
      // NEGATIVE
      translate([
        -1 * FUDGE, (ff2 / 2) * FUDGE + THICKNESS / 2, FUDGE + THICKNESS / 2
      ]) {
        rotate([ 0, 90, 0 ]) {
          cylinder(h = THICKNESS / 2 + 2 * FUDGE, r = BOLT / 2, center = false);
        }
      }
    }
  }
}

module clamper() {
  mirror([ 1, 0, 0 ]) { clamper_half(); }
  clamper_half();
}

module everything() {
  // THE BAR
  ///*
  difference() {
    translate([
      -22 + RADIUS_OUTER, //-FUDGE*100,
      -BAR + RADIUS_OUTER, 0
    ]) {
      cube([ BAR_LEN, BAR, THICKNESS ], center = false);
    }
    chuck_ring_negative();

    // BOLT HOLE IN BAR
    translate(
        [ NORMAL_TO_DEPTHHOLE + RADIUS_INNER, RADIUS_INNER - BOLT / 2, 0 ]) {
      cylinder(h = THICKNESS + FUDGE * 20, r = BOLT / 2, center = false);
    }
  }
  //*/

  // Plan is to just cut this on a bandsaw :)
  clamper();
  mirror([ 0, 1, 0 ]) { clamper(); }

  chuck_ring();
}

difference() {
  everything();
  cleanup();
}

// mirror([0,0,1]){blackhole();}
// translate([0,0,-1*THICKNESS]){blackhole();}
