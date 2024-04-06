include <BOSL/constants.scad>
use <BOSL/transforms.scad>
use <BOSL/masks.scad>


CUBE = 55.0;       // cube side
BAR = 16.25;       // bar goes through it 
SCREW_TOP = 10.0;  // screw passes through here
SCREW_BOT = 5.0;   // screw head
FUDGE = 1.0;       // FF
QUAL=30; // really fn

module body() {
    fillet(fillet=2, size=[CUBE,CUBE,CUBE], $fn=QUAL) {
      cube(size=CUBE, center=true);
    }
}

//body();

difference() {
    body();

    rotate([0,90,0]) { 
        cylinder(h=CUBE+FUDGE, r=BAR, center=true); 
        up(CUBE/2) #chamfer_hole_mask(d=BAR/2, chamfer=BAR);
    }

    //cylinder(d=20, h=100.1, center=true);
    //up(CUBE/2) #chamfer_hole_mask(d=20, chamfer=10);
}


module holes() {
rotate([0,90,0]) { cylinder(h=CUBE+FUDGE, r=BAR, center=true); }
rotate([0,0,0])  { cylinder(h=CUBE+FUDGE, r=SCREW_TOP, center=false); }
rotate([0,0,0])  { cylinder(h=CUBE+FUDGE, r=SCREW_BOT, center=true); }
}