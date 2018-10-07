$fn=72;
SliceAngle = 1.5;

difference() {
    Screw(10.25,8,2,5);
    translate([0,0,-1])
        cylinder(r=8,h=10);
}

/*
difference() {
    cylinder(r=15,h=8);
    Screw(10+0.5,8,2,5);   
}
*/
FixedCrossSection = [[0, 0],
                     [1, 0.4],
                     [1, 0.6],
                     [0, 1]];

function Slice(angle, i, pitch, innerRadius, threadDepth, threadHeight) =
    let (dx = cos(angle) * (innerRadius + threadDepth * FixedCrossSection[i][0]))
    let (dy = sin(angle) * (innerRadius + threadDepth * FixedCrossSection[i][0]))
    let (h = pitch * angle / 360)
        [dx, dy, FixedCrossSection[i][1] * threadHeight + h];
        
function Face(angle, i, j) =
    let (index = angle)
    let (s0 = index * len(FixedCrossSection))
    let (p0 = s0 + i)
    let (p1 = s0 + (i + 1) % len(FixedCrossSection))
    let (s1 = (index + 1) * len(FixedCrossSection))
    let (p2 = s1 + (i + 1) % len(FixedCrossSection))
    let (p3 = s1 + i)
    (j == 0) ? [p3,p1,p0] : [p2,p1,p3];
    
module Screw(radius, height, threadDepth, threadHeight) {
    difference() {
        union() {
            cylinder(r=radius+0.01,h=height, $fn=360/SliceAngle);
            
            pitch = threadHeight * 1.2; //(== threadHeight * (1 + 0.6 - 0.4));
            
            maxAngle = (360 * (height+threadHeight) / pitch);
            slices = ceil(maxAngle / SliceAngle);

            p = [for (angle = [0:slices])
                for (i = [0:len(FixedCrossSection)-1])
                    Slice(angle * SliceAngle, i, pitch, radius, threadDepth, threadHeight)];
                            
            f = [[for (i = [0:len(FixedCrossSection)-1]) i],
                 for (angle = [0:slices-1])
                    for (i = [0:len(FixedCrossSection)-1])
                        for (j = [0:1])
                            Face(angle, i, j),
                  [for (i = [len(FixedCrossSection)-1:-1:0]) i + slices*len(FixedCrossSection)]];
         
            translate([0,0,-threadHeight])          
                polyhedron(
                    points = p,
                    faces = f,
                    convexity = 10);
        }
        
        translate([-(radius+threadDepth)*2,-(radius+threadDepth)*2, 0])
            union () {
                translate([0,0,-2*threadHeight])
                    cube([(radius+threadDepth)*4,(radius+threadDepth)*4, 2*threadHeight]);
                translate([0,0,height])
                    cube([(radius+threadDepth)*4,(radius+threadDepth)*4, 2*threadHeight]);
            }
    }
}
