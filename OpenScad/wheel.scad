$fn=72;
SliceAngle = 1.5;


SphereRadius = 20.25;    //pingpong ball
//SphereRadius = 22;     //golf ball
SphereExposure = 10;
DiskWidth=SphereRadius - SphereExposure;

MountWallThickness = 1;

CarrierThickness = 3.5;

ThreadDepth = 1.5;
ThreadHeight = 6;
Gap = 0.25;

//Disk();

//rotate([180,0,0])
//Carrier();

Wheel();

module Carrier() {
    difference() {
        union() {
            translate([0,0,SphereRadius - SphereExposure])
            intersection () {
                sphere(r=SphereRadius+MountWallThickness+CarrierThickness);
                translate([-100,-100,0])
                    cube([200,200,100]);
            }
            cylinder(r=SphereRadius+MountWallThickness+CarrierThickness,
                     h=SphereRadius - SphereExposure);
        }
        
        union () {
            DiskCut();
        }     
    }
}


module Wheel() {
    difference() {
        Screw(SphereRadius+MountWallThickness,DiskWidth,
              ThreadDepth,ThreadHeight);
        translate([0,0,-50])
        cylinder(r=1+sqrt(SphereRadius*SphereRadius-DiskWidth*DiskWidth), h=100);
        translate([0,0,SphereRadius - SphereExposure])
            sphere(r=SphereRadius);
        }
}

module WheelCut() {
      union () {
        translate([0,0,-1])
        Screw(SphereRadius+MountWallThickness+Gap,1+SphereRadius - SphereExposure,
              ThreadDepth,ThreadHeight);
        translate([0,0,SphereRadius - SphereExposure])
            sphere(r=SphereRadius);
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
