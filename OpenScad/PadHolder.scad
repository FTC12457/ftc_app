
$fn= 72;

Length=20;
Width=5;
Thickness=5;
LowestLength=10;
LowestOffset=10;
LowestHeight=12;
LowHeight=20;
HighHeight=Thickness+Width/2+40;
Pad = 7;

       //Angle between outer arms = 180-2(OpenAngle-FoldedAngle)
       //Angle between inner arms = 2*FoldedAngle (closed)
       //                         = 180 - 2*OpenAngle (open)
FoldedAngle=atan2(Pad, Length);
OpenAngle = FoldedAngle+45;     


SupportHeight=3.9;
Gap=0.25;
VerticalGap=0.5;
PostGap= 0.25;
ExtraGap=0.0;//0.125;

PostRadius=3.25;
PostLength=5;
HookRadius= 3.75;

OuterLength = 85;

OffsetX = cos(FoldedAngle) * Length/2;
OffsetY = sin(FoldedAngle) * Length/2;

FinRatio = 2;
ContactSize=22;
ContactThickness=0.0;

CutWidth = 1.75;
CutLength=6;
HookBottomLength = 0.5;
HookTopLength = 4;
HookMiddleLength=0.75;
HookLength=HookBottomLength+HookMiddleLength+HookTopLength;
HookWidth=2.65;

Label1="Space Turtles";
Label2="FTC 12547";

union () {
    Pair();
    //Preview(2*OpenAngle);
    //translate([-30,20,0])
        //Preview(2*FoldedAngle - 180);
    //Tops(4);
    //Bottoms(8);
    //Test();
    //Gripper();
}

module Pair() {
    rotate([0,0,-FoldedAngle])
        Top();
    translate([0,25,0])
        rotate([0,0,180+FoldedAngle])
                Bottom();
    translate([8,12.5,HookWidth/2])
        rotate([0,0,-90])
            Gripper();
}

module Preview(printAngle) {
     rotate([0,0,printAngle])   
        Bottom(); 
    Top();
    rotate([-90,0,printAngle])
    Gripper();
}

module Tops(n) {
    for (i = [0:n-1]) {
        translate([0,i*20,0])
            Top();
    }
}

module Bottoms(n) {
    for (i = [0:n-1]) {
        translate([0,i*15,0])
        {
            Bottom();
            translate([-15,5,HookWidth/2])
                Gripper();
        }
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
            cube([30,20,(PostGap+SupportHeight+PostLength)*2],center = true);
            Top();
        }
    } 

    translate([0,15,0])
    intersection() {
        cube([20,20,40],center = true);
        Bottom();
    }
    
        
    translate([0,-10,HookWidth/2]) 
        Gripper();

}

module Gripper() {
        rotate([90,0,0]) {
        difference () {
            intersection () {

                translate([-10,-HookWidth/2+ExtraGap,0])
                        cube([20,HookWidth-ExtraGap*2,SupportHeight+PostLength+HookLength-2]);
                union() {
                    cylinder(r=PostRadius+1.5-ExtraGap,h=1.65);
                    translate([0,0,1.65])
                        cylinder(r1=PostRadius+1.5-ExtraGap, r2=PostRadius-ExtraGap, h=1);
                    Hook(PostRadius-ExtraGap, SupportHeight+PostLength,
                        HookRadius, HookBottomLength, HookMiddleLength, HookTopLength, 0.0);
                }
            }
            translate([0,0,SupportHeight+PostLength+ HookLength + 1])
                rotate([180,0,90])
                    Rod(HookRadius*3,CutWidth, CutLength+4);  
        }
    }    
}

module Bottom() {
    difference() {
        union () {
            difference() {
                union () {
                    translate([Length/4,0,0])
                        Rod2(Length/2,Width+Pad,Width,SupportHeight,false);
                    translate([Length/2,0,0])
                        Spoke(Width/2,LowestHeight);
                }
                color("red")
                rotate([0,0,(90-OpenAngle)]) 
                    translate([LowestOffset,-Width*2,Thickness+Width/2])
                        cube([Width*2, Width*4, Width*2]);
            }               
           
            translate([Length/2,0,0])
                rotate([0,0,-FoldedAngle]) {
                    translate([OuterLength/2,0,0]) {

                        Rod(OuterLength,Width,Thickness);
                        translate([OuterLength/2,0,0]) {
                            Fin(Width/2, HighHeight, FinRatio);
                            Fin(Width/2, HighHeight/2, 4+FinRatio);
                            Spoke(Width/2, HighHeight);
                            ContactPad();
                        
                        if (Label1 != "") {
                            translate([-47.5,0.5-Width/2,1.75])
                                rotate([90,0,0])
                                    scale([1/2,1/2,1])
                                        linear_extrude(height=1)        
                                            text(Label1, center=true); 
                            }  
                        }
                    }
                }
                
            translate([0,0,SupportHeight-1])
                cylinder(r=PostRadius,h=1+PostLength);
            translate([0,0,SupportHeight])
                cylinder(r1=PostRadius+0.5,r2=PostRadius,h=1);
        }

        translate([0,0,-1])
        intersection() {
            union() {
                cylinder(r=PostRadius+PostGap+1.5,h=2.65+PostGap);
                translate([0,0,2.65+PostGap])
                    cylinder(r1=PostRadius+PostGap+1.5, r2=PostRadius+PostGap, h=1);
                cylinder(r=PostRadius+PostGap, h=2+PostLength+SupportHeight);
            }
            translate([-10,-(HookWidth + 2*PostGap)/2,0])
                cube([20, (HookWidth + 2*PostGap), 2+PostLength+SupportHeight]);
        }            
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


module Hook(postRadius, postLength, hookRadius, bottomHookLength, middleHookLength, topHookLength, gap)
{
    union() {
        cylinder(r=postRadius+gap, h=postLength+bottomHookLength);
        translate([0,0,postLength-gap])
            cylinder(r1=postRadius+gap, r2 = hookRadius+gap, h=bottomHookLength);
        translate([0,0,postLength+bottomHookLength-gap])
            cylinder(r=hookRadius+gap, h=2*gap+middleHookLength);
        translate([0,0,postLength+bottomHookLength+middleHookLength+gap])
            cylinder(r1 = hookRadius+gap, r2=gap, h=topHookLength);        
    }    
}

module Top() {
    difference() {
        union() {
            difference() {
                translate([-Length/4,0,0])
                    Rod2(Length/2,Width,Width+Pad,LowestHeight);
            
                rotate([0,0,(OpenAngle-90)])
                translate([-Width*2-LowestOffset,-Width*2,Thickness+Width/2])
                    cube([Width*2, Width*4, Width*2]);
            }        
            
            translate([-Length/2,0,0])
                rotate([0,0,180+FoldedAngle])
                    translate([OuterLength/2,0,0]) {
                        Rod(OuterLength,Width,Thickness);
                        translate([OuterLength/2,0,0]) {
                            Fin(Width/2, HighHeight, FinRatio);
                            Fin(Width/2, HighHeight/2, 4+FinRatio);
                            Spoke(Width/2, HighHeight);
                            ContactPad();
                    
                        if (Label2 != "") {
                            translate([-10,Width/2-0.5,1.75])                          
                                rotate([90,0,180])
                                    scale([1/2,1/2,1])
                                        linear_extrude(height=1)        
                                            text(Label2, center=true);   
                            }
                        }
                    }
        }

        union () {
            color("blue")
            rotate([0,0,2*FoldedAngle-180])
                translate([Length/4,0,-1])
                    Rod2(Length/2,Width+Pad+Gap,Width+Gap,SupportHeight+VerticalGap+1,roundTop=false);
            //translate([-2*Width,-(Width+Gap)/2,-1])
            //cube([4*Width,Width+Gap, SupportHeight+VerticalGap+1]);
            
            
            color("red")
                rotate([0,0,2*OpenAngle])
                    translate([Length/4,0,-1])
                        Rod2(Length/2,Width+Pad+Gap,Width+Gap,SupportHeight+VerticalGap+1,roundTop=false);
         //   translate([-2*Width,-(Width+Gap)/2,-1])
        //    cube([4*Width,Width+Gap, SupportHeight+VerticalGap+1]);
            
            translate([0,0,SupportHeight-1])
                Hook(PostRadius, PostLength+1,
                     HookRadius, HookBottomLength, HookMiddleLength, HookTopLength, PostGap);
            
            translate([0,0,SupportHeight+VerticalGap])
                cylinder(r1=PostRadius+0.5+PostGap,r2=PostRadius+PostGap,h=1);
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
    translate([-length/2,0,0])
    intersection () {
        translate([-width/2,-width/2,0])
            cube([length+width, width, height+width]);
        union()
        {
            translate([0,-width/2,0])
                cube([length, width, height]);
            
            if (roundTop) {
                translate([0,0,height])
                    rotate([0,90,0])
                        cylinder(r=width/2, h=length);
                
                translate([0,0,height])
                    sphere(r=width/2);
                translate([length,0,height])
                    sphere(r=width/2); 
            }
            
            translate([0,0,0])
                cylinder(r=width/2,h=height);
            translate([length,0,0])
                cylinder(r=width/2,h=height);
        }
    }    
}

module Rod2(length, width1, width2, height, roundTop=true)
{
    r1 = width1/2;
    r2 = width2/2;
    width = (width1+width2)/2;
    maxWidth = max(width1, width2);
    
    dx = (r2-r1)/length;
    dy = sqrt(1 - dx*dx);
    
    translate([-length/2,0,0])
    intersection () {
        translate([-width1/2,-maxWidth/2,0])
            cube([length+width, maxWidth, height+maxWidth]);
        union()
        {
                linear_extrude(height=height)
                    polygon([[-dx*r1, -dy*r1], [-dx*r1, dy*r1],
                             [length-dx*r2, dy*r2], [length-dx*r2, -dy*r2]]);           
            if (roundTop) {
                translate([-dx*r1,0,height])
                    rotate([0,90,0])
                        cylinder(r1=dy*r1, r2=dy*r2, h=length-(r2-r1)*dx);
                
                translate([0,0,height])
                    sphere(r=r1);
                translate([length,0,height])
                    sphere(r=r2); 
            }
            
            translate([0,0,0])
                cylinder(r=r1,h=height);
            translate([length,0,0])
                cylinder(r=r2,h=height);
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
