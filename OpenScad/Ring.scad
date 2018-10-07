



SphereRadius = 36;

InnerRadius = SphereRadius*1.5;
OuterRadius = InnerRadius + 10;

RingThickness = 5;

PostRadius = 4;
PostHeight = 10;
PostCapRadius = 5;

BandSpacing = 45/2;

DiskRadius = 20;
DiskThickness = 10;

ArmThickness = 2;
ArmHeight = 15;
ArmLength = 90;
ArmRadius = SphereRadius + ArmThickness;

SphereHorizontalOffset = SphereRadius+10;
SphereVerticalOffset = SphereRadius+10;

Width = SphereRadius+5;
Length = 2*SphereRadius+20;
Thickness = 1.5;
Offset = 20;

$fn = 72;

r = (InnerRadius+OuterRadius)/2;
delta = sqrt(r*r - BandSpacing*BandSpacing);

union() {
    HollowCylinder(InnerRadius, OuterRadius, RingThickness);
    
    
    translate([delta, BandSpacing, RingThickness - 1])
        Post(PostRadius, PostHeight + 1, PostCapRadius);
    
    translate([delta, -BandSpacing, RingThickness - 1])
        Post(PostRadius, PostHeight + 1, PostCapRadius);
    
    translate([-delta, BandSpacing, RingThickness - 1])
        Post(PostRadius, PostHeight + 1, PostCapRadius);
    
    translate([-delta, -BandSpacing, RingThickness - 1])
        Post(PostRadius, PostHeight + 1, PostCapRadius);
    
    translate([BandSpacing, delta, RingThickness - 1])
        Post(PostRadius, PostHeight + 1, PostCapRadius);
    
    translate([BandSpacing, -delta, RingThickness - 1])
        Post(PostRadius, PostHeight + 1, PostCapRadius);
    
    translate([-BandSpacing, delta, RingThickness - 1])
        Post(PostRadius, PostHeight + 1, PostCapRadius);
    
    translate([-BandSpacing, -delta, RingThickness - 1])
        Post(PostRadius, PostHeight + 1, PostCapRadius);
}



module Post(radius, height, capRadius) {
    union() {
        cylinder(r = radius, h = height);
        translate([0,0,height])
            sphere(r=capRadius);
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
