
$fn= 72;

Length=32;
Width=10;
Thickness=5;
LowestLength=10;
LowestOffset=10;
LowestHeight=12;
LowHeight=20;
HighHeight=35;

FoldedAngle=20;
PrintAngle=0;
OpenAngle = 60;
Pad = 0;

SupportHeight=3.525;
Gap=0.6;
VerticalGap=0.75;
PostGap= 0.25;
HookGap=0.25;

PostRadius=3.25;
PostLength=5;
HookRadius= 3.75;

OuterLength = 50;

OffsetX = cos(FoldedAngle) * Length/2;
OffsetY = sin(FoldedAngle) * Length/2;

FinRatio = 2;
ContactSize=22;
ContactThickness=0.0;

CutWidth = 1.75;
CutLength=6;
HookBottomLength = HookRadius;
HookTopLength = HookRadius;
HookMiddleLength=0.75;
HookLength=HookBottomLength+HookMiddleLength+HookTopLength;
HookWidth=2.65;

union () {
    //Pair();
    //Preview();
    //Tops(1);
    //Bottoms(1);
    Test();
    //Gripper();
}

module Pair() {
    rotate([0,0,-FoldedAngle])
        Top();
    translate([0,30,0])
        rotate([0,0,180+FoldedAngle])
                Bottom();
}

module Preview() {
    rotate([0,0,PrintAngle])
        Bottom();    
    Top();
}

module Tops(n) {
    for (i = [0:n-1]) {
        translate([0,i*20,0])
            Top();
    }
}

module Bottoms(n) {
    for (i = [0:n-1]) {
        translate([0,i*20,0])
            Bottom();
    }
}

module Test() {
    union () {
        dy = sqrt(ContactSize)/2;
        translate([0,0,ContactThickness/2]) {
            translate([-22,2,0])
                rotate([0,0,45])
                    cube([20,20,ContactThickness], center=true);
            translate([22,-2,0])
                rotate([0,0,45])
                    cube([20,20,ContactThickness], center=true);
        }


        intersection() {
            cube([30,20,100+(SupportHeight+PostLength+HookGap+HookMiddleLength)*2],center = true);
            Top();
        }
    } 
    
    //translate([0,15,0])
    intersection() {
        cube([20,20,40],center = true);
        Bottom();
    }
}

module Bottom() {
    difference() {
        union () {
            translate([Length/4-Pad,0,0])
                Rod(Pad+Length/2,Width,SupportHeight,false);                
           
            translate([Length/2,0,0])
                rotate([0,0,-FoldedAngle]) {
                    translate([OuterLength/2,0,0]) {

                        Rod(OuterLength,Width,Thickness);
                        translate([OuterLength/2,0,0]) {
                            Fin(Width/2, HighHeight, FinRatio);
                            Fin(Width/2, HighHeight/2, 5+FinRatio);
                            Spoke(Width/2, HighHeight);
                            ContactPad();
                            
                        translate([-47.5,0.5-Width/2,2])                          
                            scale([1/3,1,1/3])
                                rotate([90,0,0])
                                    linear_extrude(height=1)        
                                        text("Space Potatoes", center=true);   
                        }
                    }
                }
                
            translate([0,0,SupportHeight-1])
                Hook(PostRadius, PostLength+1,
                     HookRadius, HookBottomLength, HookMiddleLength, HookTopLength,
                     0.0, 0.0);
        }
        
        translate([0,0,1])
            cylinder(r1=0,r2=1,h=2);
        translate([0,0,3])
           cylinder(r=1,h=SupportHeight+PostLength-5);
        translate([0,0,SupportHeight+PostLength-2])
            cylinder(r1=1,r2=0,h=2);
    }
}

module QuarterSphere(radius)
{
    intersection() {
        sphere(r=radius);
        translate([0,-radius*2,0])
            cube([radius*2,radius*4,radius*2]);
    }
}


module Hook(postRadius, postLength, hookRadius, bottomHookLength, middleHookLength, topHookLength, 
            hookGap, postGap)
{
    union() {
        cylinder(r=postRadius+postGap, h=postLength);
        
        translate([0,0,postLength-bottomHookLength-hookGap])
            cylinder(r1=hookGap, r2 = hookRadius+hookGap, h=bottomHookLength);
        translate([0,0,postLength-hookGap])
            cylinder(r=hookRadius+hookGap, h=2*hookGap+middleHookLength);
        translate([0,0,postLength+middleHookLength+hookGap])
            cylinder(r1 = hookRadius+hookGap, r2=hookGap, h=topHookLength);        
    }    
}

module Top() {
    union () {

        difference() {
            union() {
                difference() {
                    translate([Pad-Length/4,0,0])
                        Rod(Pad+Length/2,Width,LowestHeight);
                
                    rotate([0,0,-OpenAngle/2])
                    translate([-Width*2-LowestOffset,-Width*2,Thickness+Width/2])
                        cube([Width*2, Width*4, Width*2]);
                }        
                
                translate([-Length/2,0,0])
                    rotate([0,0,180+FoldedAngle])
                        translate([OuterLength/2,0,0]) {
                            Rod(OuterLength,Width,Thickness);
                            translate([OuterLength/2,0,0]) {
                                Fin(Width/2, HighHeight, FinRatio);
                                Fin(Width/2, HighHeight/2, 5+FinRatio);
                                Spoke(Width/2, HighHeight);
                                ContactPad();
                                                            
                        translate([-10,Width/2-0.5,2])                          
                            scale([1/3,1,1/3])
                                rotate([90,0,180])
                                    linear_extrude(height=1)        
                                        text("FTC 12547", center=true);   
                            }
                        }
            }

            union () {
               color("blue")
                rotate([0,0,2*FoldedAngle])
                translate([-2*Width,-(Width+Gap)/2,-1])
                cube([4*Width,Width+Gap, SupportHeight+VerticalGap+1]);
                
                color("red")
                rotate([0,0,2*OpenAngle])
                translate([-2*Width,-(Width+Gap)/2,-1])
                cube([4*Width,Width+Gap, SupportHeight+VerticalGap+1]);
                
                translate([0,0,SupportHeight-1])
                    Hook(PostRadius, PostLength+1,
                         HookRadius, HookBottomLength, HookMiddleLength, HookTopLength,
                         HookGap, PostGap);
            }
        }
    }
}

module ContactPad() {
    if (ContactThickness!=0.0) {
        translate([-(Width/2+ContactSize/4),0,ContactThickness*0.6])
                cube([ContactSize,ContactSize*1.2,ContactThickness],
                     center=true);                
    }
}


module Rod(length, width, height, roundTop=true)
{
    translate([-length/2,-width/2,0])
    intersection () {
        translate([-width/2,0,0])
            cube([length+width, width, height+width]);
        union()
        {
            cube([length, width, height]);
            
            if (roundTop) {
                translate([0,width/2,height])
                    rotate([0,90,0])
                        cylinder(r=width/2, h=length);
                
                translate([0,width/2,height])
                    sphere(r=width/2);
                translate([length,width/2,height])
                    sphere(r=width/2); 
            }
            
            translate([0,width/2,0])
                cylinder(r=width/2,h=height);
            translate([length,width/2,0])
                cylinder(r=width/2,h=height);
        }
    }    
}

module Fin(radius, height, ratio)
{
    difference() {
        translate([0,0,height])
            rotate([0,180,0])
                linear_extrude(height=height, scale=[ratio,1])
                    circle(r=radius);

        translate([0,-radius*1.5, -1])
            cube([radius*2*ratio,radius*3,height+2]);
    }
}

module Spoke(radius, height)
{
    union() {
        cylinder(r=radius,h=height);
        translate([0,0,height])
            sphere(r=radius);
    }
}