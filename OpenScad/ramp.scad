



SphereRadius = 36;

$fn = 72;

InnerRadius = 40;
LidThickness = 2;
LidDepth = 6;
GapThickness = 3;
GapDepth = 4;
RampDepth = 8;
RampWidth = SphereRadius*2 + 2;
MaxHeight = 20;
OuterHeight = 20;
OuterDepth = 3;

SliceAngle = 3;
Slices = 90/SliceAngle;


FixedCrossSection = [[InnerRadius, 0, 0],
                     [InnerRadius, 1, 0],
                     [InnerRadius, RampDepth-(LidThickness+GapThickness), 1],
                     [InnerRadius+GapDepth, RampDepth-(LidThickness+GapThickness), 1],
                     [InnerRadius+GapDepth, RampDepth-LidThickness, 1],
                     [InnerRadius, RampDepth-LidThickness, 1],
                     [InnerRadius, RampDepth, 1],
                     [InnerRadius + LidDepth, RampDepth, 1],           
                     [InnerRadius + LidDepth,  1, 1],                       
                     [InnerRadius + LidDepth + RampWidth, 1, 1],                      
                     [InnerRadius + LidDepth + RampWidth, OuterHeight, 1],  
                     [InnerRadius + LidDepth + RampWidth + OuterDepth, OuterHeight, 1],  
                     [InnerRadius + LidDepth + RampWidth + OuterDepth, 0, 0]];

function Point(i) = [FixedCrossSection[i][0],
                     FixedCrossSection[i][1] + FixedCrossSection[i][2] * MaxHeight];


function Slice(angle, i) =
    let (dx = cos(angle) * FixedCrossSection[i][0])
    let (dy = sin(angle) * FixedCrossSection[i][0])
    let (h = MaxHeight * angle / 90)
        [dx, dy, FixedCrossSection[i][1] + FixedCrossSection[i][2] * h];
function Face(angle, i) =
    let (index = (angle/SliceAngle))
    let (s0 = index * len(FixedCrossSection))
    let (p0 = s0 + i)
    let (p1 = s0 + (i + 1) % len(FixedCrossSection))
    let (s1 = (index + 1) * len(FixedCrossSection))
    let (p2 = s1 + (i + 1) % len(FixedCrossSection))
    let (p3 = s1 + i)
    [p0,p1,p2,p3];
        
        
//polygon([for (i = [0:len(FixedCrossSection)-1]) Point(i)]);
p = [for (angle = [0:SliceAngle:90])
        for (i = [0:len(FixedCrossSection)-1])
            Slice(angle, i)];
                
f = [[for (i = [len(FixedCrossSection)-1:-1:0]) i],
     for (angle = [0:SliceAngle:90-SliceAngle])
        for (i = [0:len(FixedCrossSection)-1])
            Face(angle, i),
      [for (i = [0:len(FixedCrossSection)-1]) i + Slices*len(FixedCrossSection)]];
echo(p);

echo(f);

union() {
/*
difference() {
    translate([-(RampWidth+3), InnerRadius,0])
    cube([RampWidth+3,RampWidth+LidDepth+OuterDepth,MaxHeight+OuterHeight]);
    translate([-RampWidth, InnerRadius + LidDepth,3])
        cube([RampWidth,RampWidth,MaxHeight+OuterHeight+1]);
}
    */
polyhedron(
    points = p,
    faces = f,
    convexity = 10);
}
                  
                
    


module Arc(outerRadius, thickness, length, height)
{
    radius = outerRadius-thickness/2;
    innerRadius = outerRadius - thickness;
    translate([-radius,0,0]) {
        angle = length * 180 / (radius * 3.141592654);
        x = cos(angle) * radius;
        y = sin(angle) * radius;

        union() {
            translate([x,y,0])
                cylinder(r=thickness/2, h=height);
            translate([radius,0,0])
                cylinder(r=thickness/2, h=height);
            intersection() {
                HollowCylinder(innerRadius, outerRadius, height);

                translate([0,0,-1])
                    linear_extrude(height = height + 2)
                        polygon([[0,0],[2*radius,0],
                                 [2*radius,2*radius],
                                 if (angle > 90)
                                    [-2*radius,2*radius],
                                 if (angle > 180)
                                    [-2*radius,-2*radius],
                                 if (angle > 270)
                                    [2*radius,-2*radius],
                                 [2*x,2*y]]);
            }
        }
    }
}
module HollowCylinder(innerRadius, outerRadius, height)
{
    difference()
    {
        cylinder(r=outerRadius, h=height, $fn = 288);
        translate([0,0,-1])
            cylinder(r=innerRadius, h=height + 2, $fn = 288);
    }
}
