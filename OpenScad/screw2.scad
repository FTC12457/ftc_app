




$fn = 72;

InnerRadius = 5;
ThreadDepth = 2;
ThreadHeight = 5;
Pitch = 6;

MaxAngle=900;
SliceAngle = 1.5;
Slices = MaxAngle/SliceAngle;

Screw(5,10,3,5);

FixedCrossSection = [[InnerRadius, 0],
                     [InnerRadius + ThreadDepth, ThreadHeight * 0.4],
                     [InnerRadius + ThreadDepth, ThreadHeight * 0.6],
                     [InnerRadius, ThreadHeight]
                     ];

function Slice(angle, i, pitch) =
    let (dx = cos(angle) * FixedCrossSection[i][0])
    let (dy = sin(angle) * FixedCrossSection[i][0])
    let (h = pitch * angle / 360)
        [dx, dy, FixedCrossSection[i][1] + h];
        
function Face(angle, i) =
    let (index = angle)
    let (s0 = index * len(FixedCrossSection))
    let (p0 = s0 + i)
    let (p1 = s0 + (i + 1) % len(FixedCrossSection))
    let (s1 = (index + 1) * len(FixedCrossSection))
    let (p2 = s1 + (i + 1) % len(FixedCrossSection))
    let (p3 = s1 + i)
    [p0,p1,p2,p3];
        

module Screw(height, radius, threadDepth, threadHeight) {
    intersection() {
        translate([-(radius+threadDepth)*2,-(radius+threadDepth)*2, 0])
            cube([(radius+threadDepth)*4,(radius+threadDepth)*4, height]);
        union() {
            cylinder(r=InnerRadius,h=height);
            
            pitch = threadHeight * 1.2; //(== threadHeight * (1 + 0.6 - 0.4));
            
            maxAngle = (360 * (height + threadHeight) / pitch);
            slices = ceil(maxAngle / SliceAngle);

            
            p = [for (angle = [0:slices])
                for (i = [0:len(FixedCrossSection)-1])
                    Slice(angle * SliceAngle, i, pitch)];
                            
            f = [[for (i = [0:len(FixedCrossSection)-1]) i],
                 for (angle = [0:slices-1])
                    for (i = [0:len(FixedCrossSection)-1])
                        Face(angle, i),
                  [for (i = [len(FixedCrossSection)-1:-1:0]) i + slices*len(FixedCrossSection)]];
         
            translate([0,0,-ThreadHeight])          
            polyhedron(
                points = p,
                faces = f,
                convexity = 10);
        }
    }
}
