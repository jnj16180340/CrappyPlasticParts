include <BOSL/constants.scad>
use <BOSL/transforms.scad>
use <BOSL/masks.scad>

BEEF = 4;
BAR = 16.25/2;       // bar goes through it 
CUBE = BEEF * BAR;       // cube side
SCREW_TOP = 10.0/2;  // screw passes through here
SCREW_BOT = 5.0/2;   // screw head
FUDGE = 1.0;       // FF

$fa = 1;
$fs = 0.5;

module body() {
    fillet(fillet=5, size=[CUBE,CUBE,CUBE]) {
      cube(size=CUBE, center=true);
    }
}

module holes() {
rotate([0,90,0]) { cylinder(h=CUBE+FUDGE, r=BAR, center=true); }
rotate([0,0,0])  { cylinder(h=CUBE+FUDGE, r=SCREW_TOP, center=false); }
rotate([0,0,0])  { cylinder(h=CUBE+FUDGE, r=SCREW_BOT, center=true); }
}


difference () {
    body();
    holes();
}
