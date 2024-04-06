include <BOSL/constants.scad>
use <BOSL/transforms.scad>
use <BOSL/masks.scad>


CUBE = 55.0;       // cube side
BAR = 16.25;       // bar goes through it 
SCREW_TOP = 10.0;  // screw passes through here
SCREW_BOT = 5.0;   // screw head
FUDGE = 1.0;       // FF
QUAL=50; // really fn

module body() {
    fillet(fillet=5, size=[CUBE,CUBE,CUBE], $fn=QUAL) {
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
