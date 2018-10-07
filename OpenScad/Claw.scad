



SphereRadius = 36;

InnerRadius = 22;

DiskRadius = 12;
DiskThickness = 10;

ArmThickness = 2;
ArmHeight = 10;
ArmLength = 120;
ArmRadius = SphereRadius + ArmThickness+2;

ArmCenterRadius = 4;


Width = SphereRadius+5;
Length = 2*SphereRadius+20;
Thickness = 1.5;
Offset = 20;

$fn = 144;

ServoHeight = 50;
Gap = 0.25;

GridPadding = 3;
GridEdgeThickness = 20+Gap;
GridLength = 90;
GridHeight = 48;
GridThickness = 15;
GridCornerRadius = 2;
GridHoleOffset = 12;
GridRadius = 6;
GridInset = 15;


GridInset = 18;

WheelRadius = 42.7/2 + Gap;     //Golf ball diameter = 42.7
WheelExposure = 12;
WheelMountThickness = 1;



ThreadDepth = 2;
ThreadHeight = 8;

FrontHeight = 38;
FrontRadius = WheelRadius + WheelMountThickness + ThreadDepth + 2 + Gap;
FrontOuterCornerRadius = 8;

BackHeight = FrontHeight;
BackRadius = FrontRadius;
BackSeparation = FrontRadius - 2;


BandRadius = 4;
BandOffset = 2;

ExtensionThickness = DiskThickness;
ExtensionLength = 10;
angle =(ArmLength / (ArmRadius - ArmThickness/2)) * 180 / 3.141592654;

ServoForwardDisplacement = 16;
ServoHorizontalOffset = GridThickness/2 + 32+ 15;
ServoVerticalOffset = 25 + (50 - WheelExposure - FrontHeight);
ServoBottomMountThickness = 10;
ServoBottomRadius = 2.5;
ServoWidth = 24;

HookRadius=3.5;
HookLength = 20;
BumperOffset = 8;
HookHorizontalOffset = 30;
HookVerticalOffset = ServoVerticalOffset+42;

ChannelCornerRadius = 8;

//Claw();

//rotate([180,0,0])
{   
    //Front(true);
    //Back(true);
}
//Wheel(WheelRadius, WheelMountThickness, WheelExposure, ThreadDepth, ThreadHeight);
//WheelCut(WheelRadius, WheelMountThickness, WheelExposure, ThreadDepth, ThreadHeight);
//Grid();


Preview();
module Preview() {
    translate([-(FrontRadius+GridLength),0,0])
    Front(false);
    
    translate([BackRadius,0,0])
    rotate([0,0,180])
        Back(false);
    
    rotate([-90,0,180])
    Grid();

    translate([-ServoForwardDisplacement,ServoHorizontalOffset,0])
    rotate([0,0,10]) {
           translate([-(InnerRadius+ArmRadius-ArmThickness/2),0,13])
                rotate([0,0,45])
                cube([50,50,50], center=true);
            translate([0,0,10])
            Claw();
            translate([0,0,28])
            Claw();
    }
    translate([-ServoForwardDisplacement,-ServoHorizontalOffset,0])
    scale([1,-1,1])
        rotate([0,0,5]) {
            translate([-(InnerRadius+ArmRadius-ArmThickness/2),0,SphereRadius-12])
                sphere(r=SphereRadius);
            translate([0,0,10])
            Claw();
            translate([0,0,28])
            Claw();
        }
}

module Grid() {
    translate([0,0, -(GridThickness/2 - Gap)])
    difference() {
        union () {
            translate([Gap, -BackHeight, 0])
            cube([GridLength - 2 * Gap, BackHeight, GridThickness - 2 * Gap]);

            linear_extrude(height=GridThickness - 2 * Gap)
               offset(r=GridRadius)
                    polygon([[GridRadius+Gap,0],
                             [ServoForwardDisplacement - 10, ServoVerticalOffset],
                             [HookHorizontalOffset-HookLength, HookVerticalOffset+BumperOffset],
                             [HookHorizontalOffset, HookVerticalOffset],
                             //[ServoForwardDisplacement + 10, ServoVerticalOffset + 10],
                             [GridLength - (GridRadius+Gap), 0]]);
            
        }

        translate([0,0,-1]) 
        union () {
            translate([HookHorizontalOffset, HookVerticalOffset, 0])
                cylinder(r=HookRadius,h=GridThickness+2);
            
            translate([ServoForwardDisplacement+8, ServoVerticalOffset, 0])
                cylinder(r=2, h=GridThickness+2);
            translate([ServoForwardDisplacement-8, ServoVerticalOffset, 0])
                cylinder(r=2, h=GridThickness+2);
            translate([ServoForwardDisplacement, ServoVerticalOffset+8, 0])
                cylinder(r=2, h=GridThickness+2);
            translate([ServoForwardDisplacement, ServoVerticalOffset-8, 0])
                cylinder(r=2, h=GridThickness+2);
            
            translate([0,0,1])
            rotate([90,180,0])
                translate([0,0,-100])
                    Corner(GridCornerRadius,200);
 
            translate([0,0,1+GridThickness-2*Gap])
                rotate([90,270,0])
                    translate([0,0,-100])
                        Corner(GridCornerRadius,200);
            
            translate([GridLength - Gap,0,1])
            rotate([90,90,0])
                translate([0,0,-100])
                    Corner(GridCornerRadius,200);
 
           translate([GridLength - Gap,0,1+GridThickness-2*Gap])
            rotate([90,0,0])
                translate([0,0,-100])
                    Corner(GridCornerRadius,200);
            
            translate([GridLength - GridHoleOffset, 10 - FrontHeight, 0])
                cylinder(r=2, h=GridThickness+2);
            translate([GridLength - GridHoleOffset, 28 - FrontHeight, 0])
                cylinder(r=2, h=GridThickness+2);
            
            translate([GridHoleOffset, 10 - FrontHeight, 0])
                cylinder(r=2, h=GridThickness+2);
            translate([GridHoleOffset, 28 - FrontHeight, 0])
                cylinder(r=2, h=GridThickness+2);

            c1 = [Gap + GridInset, -BackHeight+3];
            c2 = [GridLength - Gap - GridInset, -BackHeight+3];
            c3 = [GridLength - Gap - GridInset, 0];
            c4 = [Gap + GridInset, 0];
            m = [(c1[0]+c2[0])/2, (c2[1]+c3[1])/2];

            RoundedTriangle([c1,c2,m], 5, 3, GridThickness+2);
            RoundedTriangle([c2,c3,m], 5, 3, GridThickness+2);
            RoundedTriangle([c3,c4,m], 5, 3, GridThickness+2);
            RoundedTriangle([c4,c1,m], 5, 3, GridThickness+2);
            
            c5 = [HookHorizontalOffset, 0];
            c6 = [GridLength - 2 * Gap, 0];
            c7= [HookHorizontalOffset, HookVerticalOffset+GridRadius];
            
            RoundedTriangle([c5,c6,c7], 10, 6, GridThickness+2);
        }
    }
}
        
module Front(wheelCut) {
    difference() {
        union () {
            Channel();
            

            translate([FrontRadius,GridThickness/2,0])
                rotate([0,0,90])
                    Corner(GridCornerRadius, FrontHeight);
            
            translate([FrontRadius,-GridThickness/2,0])
                rotate([0,0,180])
                    Corner(GridCornerRadius, FrontHeight);

            cylinder(r=FrontRadius, h=FrontHeight);
            if (!wheelCut) {
                translate([0,0,FrontHeight + WheelExposure - WheelRadius])
                    sphere(r=WheelRadius);
            }
        }
        union () {
            translate([FrontRadius + GridEdgeThickness,0,0])
                rotate([270,0,0])
                    translate([0,0,-50])
                        Corner(ChannelCornerRadius,100);
            
            translate([FrontRadius + GridEdgeThickness,0,FrontHeight])
                rotate([90,0,0])
                    translate([0,0,-50])
                        Corner(ChannelCornerRadius,100);
            
            translate([FrontRadius + GridHoleOffset, 0, 10])
                rotate([90,0,0])
                    translate([0,0,-50])
                        cylinder(r=2,h=100);
            translate([FrontRadius + GridHoleOffset, 0, 28])
                rotate([90,0,0])
                    translate([0,0,-50])
                        cylinder(r=2,h=100);
            if (wheelCut) {
                WheelCut(WheelRadius, WheelMountThickness, WheelExposure,
                         ThreadDepth, ThreadHeight);
            }
        }
    }    
}


module Back(wheelCut) {
    difference () {
        union () {
            translate([-BackRadius, -BackSeparation, 0])
            cube([BackRadius*2, 2 * BackSeparation, BackHeight]);
            
            translate([0,BackSeparation, 0])
                cylinder(r=BackRadius, h=BackHeight);
            translate([0,-BackSeparation, 0])
                cylinder(r=BackRadius, h=BackHeight);
            
            translate([BackRadius,-GridThickness/2,0])
            rotate([0,0,180])
            Corner(GridCornerRadius, BackHeight);
            
            translate([BackRadius,-(GridThickness/2+GridPadding),0])
            rotate([0,0,90])
            Corner(8, BackHeight);
            
            translate([BackRadius,GridThickness/2,0])
            rotate([0,0,90])
            Corner(GridCornerRadius, BackHeight);
            
            translate([BackRadius,(GridThickness/2+GridPadding),0])
            rotate([0,0,180])
            Corner(8, BackHeight);
            
            difference () {
                translate([0,-(GridThickness/2+GridPadding),0])
                    cube([BackRadius + GridEdgeThickness,
                          GridThickness + 2*GridPadding,
                          BackHeight]);
                translate([BackRadius, -GridThickness/2, -1])
                    cube([GridEdgeThickness+1, GridThickness, BackHeight+2]);
            }
            
            if (!wheelCut) {
                translate([0,(BackRadius+BackSeparation)/2,
                           BackHeight + WheelExposure - WheelRadius])
                    sphere(r=WheelRadius);
                translate([0,-(BackRadius+BackSeparation)/2,
                           BackHeight + WheelExposure - WheelRadius])
                    sphere(r=WheelRadius);
            }
        }
        
        union () {
            translate([BackRadius + GridEdgeThickness,0,0])
                rotate([270,0,0])
                    translate([0,0,-50])
                        Corner(ChannelCornerRadius,100);
            
            translate([BackRadius + GridEdgeThickness,0,FrontHeight])
                rotate([90,0,0])
                    translate([0,0,-50])
                        Corner(ChannelCornerRadius,100);

            translate([BackRadius + GridHoleOffset, 0, 10])
                rotate([90,0,0])
                    translate([0,0,-50])
                        cylinder(r=2,h=100);
            translate([BackRadius + GridHoleOffset, 0, 28])
                rotate([90,0,0])
                    translate([0,0,-50])
                        cylinder(r=2,h=100);
            
            if (wheelCut) {
                translate([0,(BackRadius+BackSeparation)/2,0])
                    WheelCut(WheelRadius, WheelMountThickness, WheelExposure,
                             ThreadDepth, ThreadHeight);
               
                translate([0,-(BackRadius+BackSeparation)/2,0])
                    WheelCut(WheelRadius, WheelMountThickness, WheelExposure,
                             ThreadDepth, ThreadHeight);
            } 
        }
        
    }
}
module Corner(radius, length) {
    translate([-radius,-radius,0])
        difference() {
                cube([radius, radius, length]);
            translate([0,0,-1])
            cylinder(r=radius,h=length+2);
        }  
}

module Channel() {
    h = (GridThickness/2+GridPadding);
    d = sqrt((FrontRadius + FrontOuterCornerRadius)*(FrontRadius + FrontOuterCornerRadius) -
             (h + FrontOuterCornerRadius) * (h + FrontOuterCornerRadius));
    w = (h + FrontOuterCornerRadius) * FrontRadius / (FrontRadius + FrontOuterCornerRadius);

    echo (h);
    echo (d);
    difference() {
        union () {
            translate([0,-(GridThickness/2+GridPadding),0])
                cube([FrontRadius + GridEdgeThickness,
                      GridThickness + 2*GridPadding,
                      FrontHeight]);
            
            translate([0,-w,0])
                cube([d, 2 * w, FrontHeight]);
        }
        
        union () {
            translate([d, (h+FrontOuterCornerRadius),-1])
                cylinder(r=FrontOuterCornerRadius, h=FrontHeight+2);
            translate([d, -(h+FrontOuterCornerRadius),-1])
                cylinder(r=FrontOuterCornerRadius, h=FrontHeight+2);
            translate([FrontRadius, -GridThickness/2, -1])
                cube([GridEdgeThickness+1, GridThickness, FrontHeight+2]);
        }
    }
}

module Claw(show) {
    difference() {
        union() {
            cylinder(r=DiskRadius,h=DiskThickness);

        linear_extrude(height=DiskThickness)
            polygon( [RRTangent([0,0], [-InnerRadius,0], DiskRadius, ArmThickness/2, 1),
                      RRTangent([-InnerRadius,0], [0,0], ArmThickness/2, DiskRadius, -1),
                      [-(InnerRadius+Thickness/2)-1,12],
                      [-(InnerRadius+Thickness/2)-9,26],
                      RRTangent([-(InnerRadius+ArmRadius-ArmThickness/2),0], [0,0],
                                ArmRadius, DiskRadius, 1),        
                      RRTangent([0,0], [-(InnerRadius+ArmRadius-ArmThickness/2),0],
                                DiskRadius, ArmRadius, -1)]);    


        translate([-InnerRadius, 0, 0])
            Arc(ArmRadius, ArmThickness, ArmLength, ArmHeight);
       
        translate([-(InnerRadius+ArmRadius-ArmThickness/2),0,0])
            translate([(ArmRadius-ArmThickness/2)*cos(angle),(ArmRadius-ArmThickness/2)*sin(angle),0])
            rotate([0,0,angle]) {

                union () {
                    translate([0,ExtensionLength,0])
                        cylinder(r=ArmThickness/2,h=ExtensionThickness);
                    translate([-ArmThickness/2,0,0])
                        cube([ArmThickness, ExtensionLength, ExtensionThickness]);
                }
            }
        }
        translate([0,0,-1])
            union () {
                cylinder(r=ArmCenterRadius,h=DiskThickness+2);
                translate([0,8,0])
                    cylinder(r=2,h=DiskThickness+2);
                translate([0,-8,0])
                    cylinder(r=2,h=DiskThickness+2);
                translate([8,0,0])
                    cylinder(r=2,h=DiskThickness+2);
                translate([-8,0,0])
                    cylinder(r=2,h=DiskThickness+2);
            }
        }
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

module RoundedTriangle(points, rInset, rCorner, height)
{
    insetPoints = [for (i=[0:len(points)-1])
                   Inset3(points[(i + len(points) - 1) % len(points)],
                          points[i], 
                          points[(i + 1) % len(points)], rInset)];

    linear_extrude(height=height)
        offset(r=rCorner)
            polygon(insetPoints, convexity=10);
}


// Line equation:
//  P12(t) = (p2 + n12) + t * d12
//  P34(t) = (p3 + n34) + t * d34
//
// Solve for t12, t34 such that P12(t12) = P34(t34)
//
// P12(t12) - P34(t34) = (p2+n12)  - (p3+n34) + t12 * d12 - t34 * d34 = 0
//                       t12 * d12 - t34 * d34 =  (p3+n34) - (p2+n12)
//
//  d12[0] * t12 - d23[0] * t23 = n23[0] * o23 + n12[0] * o12;
function Inset3(p1, p2, p3, offset) = Inset4(p1, p2, p2, p3, offset);
function Inset4(p1, p2, p3, p4, offset) =
    let (d12 = Subtract(p1,p2))
    let (d34 = Subtract(p3, p4))
    let (o12 = offset / Length(d12))
    let (o34 = offset / Length(d34))
    let (n12 = [d12[1] * o12, -d12[0] * o12])
    let (n34 = [d34[1] * o34, -d34[0] * o34]) 
    let (result = Solve(d12[0], -d34[0], (p3[0] + n34[0]) - (p2[0] + n12[0]),
                        d12[1], -d34[1], (p3[1] + n34[1]) - (p2[1] + n12[1])))
        [p2[0] + n12[0] + result[0] * d12[0],
         p2[1] + n12[1] + result[0] * d12[1]];
         
function Solve(m11, m12, r1, m21, m22, r2) =
    let (d = m12 * m21 - m22 * m11)
    (d == 0)
        ? [0.0, 0,0]
        : ((m11 == 0)
           ? let (b = r1 / m12) [(r2 - m22 * b) / m21, b]
           : let (b = (r1 * m21 - r2 * m11) / d) [(r1 - m12 * b) / m11, b]);
           
function Length2(p) = p[0]*p[0] + p[1]*p[1];
function Length(p) = sqrt(Length2(p));
function Subtract(v1, v2) = [v1[0] - v2[0], v1[1] - v2[1]];
function Dot(v1, v2) = v1[0] * v2[0] + v1[1] * v2[1];

function RRTangent(p1, p2, r1, r2, s) =
     let(dx = (p2[0] - p1[0]))
     let(dy = (p2[1] - p1[1]))
     let(distance2 = dx*dx + dy*dy)
     let(distance = sqrt(distance2))
     let(nx = dx / distance)
     let(ny = dy / distance)
     let(cosA = (r1-r2)/distance)
     let(sinA = sqrt(1-cosA*cosA))
        [p1[0] + (cosA * r1) * nx - s * (sinA * r1) * ny,
         p1[1] + (cosA * r1) * ny + s * (sinA * r1) * nx];

SliceAngle = 1.5;

module Wheel(sphereRadius, mountWallThickness, sphereExposure, threadDepth, threadHeight) {
    diskWidth=sphereRadius - sphereExposure;
    difference() {
        Screw(sphereRadius+mountWallThickness,diskWidth,
              threadDepth,threadHeight);
        
        union () {
            translate([0,0,-50])
            cylinder(r=1+sqrt(sphereRadius*sphereRadius-diskWidth*diskWidth), h=100);
            translate([0,0,sphereRadius - sphereExposure])
                sphere(r=sphereRadius);
            
            translate([-50,-1,-1])
                cube([100,2,2]);
            translate([0,0,1])
            rotate([0,90,0])
            translate([0,0,-50])
            cylinder(r=1,h=100);
        }
    }
}

module WheelCut(sphereRadius, mountWallThickness, sphereExposure,
                threadDepth, threadHeight) {
    difference () {
        union () {
            translate([0,0,-1])
                Screw(sphereRadius+mountWallThickness+Gap,1+sphereRadius - sphereExposure,
                      threadDepth,threadHeight);
            translate([0,0,sphereRadius - sphereExposure])
                sphere(r=sphereRadius);
        }
    } 
}


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

