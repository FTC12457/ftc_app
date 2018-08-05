mountWidth = 92;
mountThickness = 3;
mountDepth = 32+mountThickness;
mountHeight = 32+mountThickness;


motorOffset=0;
motorInnerRadius = 37.5/2;
motorWallThickness = 3;
motorOuterRadius = motorInnerRadius+motorWallThickness;

mountRadius=4;

cornerRadius = 2.5;

bandWidth=13;
bandThickness = 1.0;

holeRadius = 2;
holeDepth = mountThickness + 2;
holeOffset = 8;
holeFacets = 144;

gap=2;

Mount();

/*
difference() {
    cylinder(r=11,h=mountThickness,$fn=holeFacets);
    
    translate([0,0,mountThickness/2]) {
    Holes();
        
    cylinder(r=5,h=2,$fn=holeFacets);
    cylinder(r=3.5,h=holeDepth,center=true,$fn=holeFacets);}
}
*/

module Mount() {
    difference() {
        union() {
          //  color("red")
              //  translate([0,-3,0])
               // cube([10,6,100]);
            translate([-mountWidth/2,0,0])
                cube([mountWidth, mountDepth, mountThickness]);
            
            translate([-mountWidth/2,0,0])
               cube([mountWidth,mountThickness,mountHeight]);
            
            translate([-mountWidth/2,0,0])
                cube([mountWidth,cornerRadius+mountThickness,cornerRadius+mountThickness]);

            translate([-motorOuterRadius,-(motorOuterRadius+motorOffset),0])
                cube([2*motorOuterRadius,motorOuterRadius+motorOffset,mountHeight]);
            
            translate([0,-(motorOuterRadius+motorOffset),0])
                cylinder(r=motorOuterRadius,h=mountHeight,$fn=holeFacets);
            
            translate([motorOuterRadius,-mountRadius,0])
                cube([mountRadius,mountRadius,mountHeight]);
            scale([-1,1,1])
                translate([motorOuterRadius,-mountRadius,0])
                    cube([mountRadius,mountRadius,mountHeight]);
            
            translate([32,(16+mountThickness),-1])
                CornerCut(2*(mountWidth/2-32),32,mountThickness+2);     
        }
        
        translate([32,(16+mountThickness),-1])
            CornerCut(2*(mountWidth/2-32),32,mountThickness+2);
        
        translate([-32,-1,(16+mountThickness)])
            rotate([90,0,180])
                CornerCut(2*(mountWidth/2-32),32,mountThickness+2);
        
        scale([-1,1,1]) {
            translate([32,(16+mountThickness),-1])
                CornerCut(2*(mountWidth/2-32),32,mountThickness+2);
            translate([-32,-1,(16+mountThickness)])
                rotate([90,0,180])
                    CornerCut(2*(mountWidth/2-32),32,mountThickness+2);
        }
        
        translate([motorOuterRadius+mountRadius,-mountRadius,-1])
                cylinder(r=mountRadius,h=mountHeight+2,$fn=holeFacets);
        scale([-1,1,1])
            translate([motorOuterRadius+mountRadius,-mountRadius,-1])
                    cylinder(r=mountRadius,h=mountHeight+2,$fn=holeFacets);
        
        translate([0,cornerRadius+mountThickness,cornerRadius+mountThickness])
            rotate([0,90,0])
                cylinder(r=cornerRadius,h=mountWidth+2,center=true,$fn=holeFacets);
            
        translate([0,-(motorOuterRadius+motorOffset),-1])
            cylinder(r=motorInnerRadius,h=mountHeight+2,$fn=holeFacets);   

        translate([0,-(motorOuterRadius+motorOffset),mountHeight/2])
            Band();
        
      
        translate([-32,(16+mountThickness),mountThickness/2]) {
            Holes();        

        }
          translate([0,(16+mountThickness),mountThickness/2]) {  
                cylinder(r=5,h=2,$fn=holeFacets);
            cylinder(r=3.5,h=holeDepth,center=true,$fn=holeFacets);
          }
        translate([32,(16+mountThickness),mountThickness/2])
            Holes();

        translate([-32,mountThickness/2,(16+mountThickness)])
            rotate([90,0,0])
                Holes(left=false); 
                
        translate([32,mountThickness/2,(16+mountThickness)])
            rotate([90,0,0])
                Holes(right=false); 

        translate([-gap/2,-(2*motorOuterRadius+motorOffset+1),-1])
               cube([gap,motorWallThickness+2,mountHeight+12]);
        
    }
}

module CornerCut(width, height, thickness) {
    difference() {
        cube([1+width/2,1+height/2,thickness]);
    
        scale([1,height/width,1])
            translate([0,0,-1])
                cylinder(r=width/2,h=thickness+2,$fn=holeFacets);
    }
}

module Band()
{
            rotate_extrude(convexity=10, $fn=holeFacets)
            translate([motorOuterRadius+bandThickness/2+0.005,0,0]) {
                translate([0,bandWidth/2])
                    circle(r=bandThickness/2, $fn=holeFacets);
                translate([0,-bandWidth/2])
                    circle(r=bandThickness/2, $fn=holeFacets);
                polygon([//[0,bandWidth/2+1],
                         [bandThickness/2,bandWidth/2],
                         [bandThickness/2,-bandWidth/2],
                        // [0,-bandWidth/2-1],
                         [-bandThickness/2,-bandWidth/2],
                         [-bandThickness/2,bandWidth/2]]);
            }
}

module Holes(top=true,left=true,right=true,bottom=true) {
    if (left) {
        translate([holeOffset,0,0])
            cylinder(r=holeRadius,h=holeDepth,
                     center=true, $fn=holeFacets); }
    if (right) {
        translate([-holeOffset,0,0])
            cylinder(r=holeRadius,h=holeDepth,
                     center=true, $fn=holeFacets); }
    if (bottom) {            
        translate([0,holeOffset,0])
            cylinder(r=holeRadius,h=holeDepth,
                     center=true, $fn=holeFacets); }
    if (top) {
        translate([0,-holeOffset,0])
            cylinder(r=holeRadius,h=holeDepth,
                     center=true, $fn=holeFacets); }  
}
