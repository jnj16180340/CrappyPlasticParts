difference() {

linear_extrude( height=7) polygon(points = [
    [0, 0], 
    [150,0],
    [150,80],
    [40,80],
    [40,120],
    [30,120],
    [30,150],
    [0,150],
    [0,0]
]);

cube([10,400,10], center=true);
}