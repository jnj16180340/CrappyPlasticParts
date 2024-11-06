difference() {

linear_extrude( height=7) polygon(points = [
[0,0],
[0,150],
[160,150],
[160,130],
[20,130],
[20,0],
[0,0]
]);

color("blue") 
translate([10,0-1,0-1]){cube([10+1,130+1,5+1], center=false);}
}