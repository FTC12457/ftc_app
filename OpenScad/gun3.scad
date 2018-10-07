mountLength = 1;
mountWidth = 12;

braceHolesOffset = -51; //-48?

railOffset = 22; //64? 32? 48?
railWidth = 26;

reinforcementWidth = railWidth;
supportWidth = railOffset+railWidth/2+(mountWidth/2);
supportLength = mountLength + 14 - braceHolesOffset;
supportThickness = 2;

bracePadding = 0;
braceOffset = 16;
braceThickness = 2;

maxReinforcingThickness = 4;
minReinforcingThickness = 2;

webThickness = 1;
webDepth = 8;

slotOffset = -15;
diskRadius=36;
diskWidth=8;
braceSideLength = (mountLength - slotOffset) * sqrt(2);
braceRadius = mountLength - slotOffset;
braceHeight=4;

topHolesOffset = 0;
bottomHolesOffset = 64;

braceLength = mountWidth/2 - braceHolesOffset;



holeDepth = 40;
holeOffset = 12;
holeRadius = 2;

bottomGuideOffset = mountLength-braceThickness/2;
middleGuideOffset= bottomGuideOffset-10;

bottomHoleRadius = 4.5;

barrelLength = 95;
barrelWidth = 5;
barrelThickness = braceOffset+diskRadius-5;

holeOffset = 8;
holeRadius = 2.1;

holeFacets = 144;

Pylon();
/*
difference() {
    union() {
        
        translate([-mountWidth/2-50,slotOffset,-supportThickness])
            scale([1.25,2,1]) 
            intersection() {
                cylinder(r=braceRadius,h=supportThickness, $fn=72);
                translate([-25,-50,0])
                cube([50,50,50]);
            }
        
        translate([-mountWidth/2-50,slotOffset,-supportThickness])
            scale([1.25,0.75,1])        
                cylinder(r=braceRadius,h=supportThickness, $fn=72);

        translate([-mountWidth/2-50-braceRadius*1.25,slotOffset,0])
            scale([1.25,0.5,1])  
                linear_extrude(height=barrelThickness-supportThickness,
                               scale=[0.2,0.2], slices=20)
                    translate([braceRadius,0,0])
                    circle(r=braceRadius, $fn=72);
        
        translate([-mountWidth/2-50-braceRadius*1.25,slotOffset,0])
            scale([1.25,0.75,1])  
                linear_extrude(height=5, scale=[0.2,0.2], slices=20)
                    translate([braceRadius,0,0])
                    circle(r=braceRadius, $fn=72);
        

    }
    
    translate([-mountWidth/2-50-braceRadius-4,slotOffset,barrelThickness-5])
        rotate([0,45,0])
            cube([4,8,4], center=true);
    
        translate([(supportWidth-mountWidth)/2-55-braceRadius, (mountLength-supportLength)/2,0])
        Holes(top=false,bottom=false);
}


difference() {
    union() {

        color("red")
            translate([-mountWidth/2,mountLength-supportLength,-supportThickness])
                cube([supportWidth,supportLength,supportThickness]);
        
  //      translate([-mountWidth/2-barrelLength/2,slotOffset,
           //        barrelThickness/2-supportThickness])
             //       cube([barrelLength, barrelWidth, barrelThickness], center=true);
        

        translate([-mountWidth/2,slotOffset,-supportThickness])
            scale([1.25,1,1])        
                cylinder(r=braceRadius,h=supportThickness, $fn=72);

        translate([-mountWidth/2-3.75,slotOffset,0])
            scale([1.25,1,1])  
                linear_extrude(height=braceHeight, scale=[0,0], slices=20)
                    translate([3,0,0])
                    circle(r=braceRadius, $fn=72);
        
            //scale([1.25,1,1])        
                //cylinder(r1=braceRadius,r2=0,h=braceHeight, $fn=72);
        
        translate([railOffset,
                   bottomGuideOffset-braceThickness/2,
                   0])
            scale([1,-1,1])
                 Reinforcement(reinforcementWidth);
        
        translate([railOffset,bottomGuideOffset,0])
            Guide(); 
            

    }

    translate([railOffset,slotOffset+diskWidth/2,bracePadding + braceOffset]) 
        rotate([90,0,0])
            cylinder(r=diskRadius,h=diskWidth,$fn=16);
    translate([railOffset, braceHolesOffset,0])
        Holes();
    translate([railOffset-20, braceHolesOffset,0])
        Holes(left=false,right=false);
    
    translate([(supportWidth-mountWidth)/2, (mountLength-supportLength)/2,0])
        Holes(top=false,bottom=false);
    

    
    translate([-mountWidth/2 - barrelLength,slotOffset,-supportThickness])
        rotate([0,45,0])
            cube([32,8,32], center=true);
    
    translate([-mountWidth/2 - barrelLength/2,slotOffset,barrelThickness/2+-supportThickness])
        rotate([0,45,0])
            cube([barrelThickness/2,8,barrelThickness/2], center=true);
    
    translate([-mountWidth/2-3,slotOffset,barrelThickness])
        rotate([0,45,0])
            cube([40,8,40], center=true);
}
*/
module Pylon() {
    difference() {
        union() {
                translate([0,0,-supportThickness])
                    scale([1.25,0.5,1])        
                        cylinder(r=braceRadius,h=supportThickness, $fn=72);

                translate([-braceRadius*1.25,0,0])
                    scale([1.25,0.5,1])  
                        linear_extrude(height=barrelThickness-supportThickness,
                                       scale=[0.2,0.2], slices=20)
                            translate([braceRadius,0,0])
                            circle(r=braceRadius, $fn=72);
                
            intersection() {
                union() {
                translate([-braceRadius*1.25,0,0])
                    scale([1.25,0.75,1])  
                        linear_extrude(height=5, scale=[0.2,0.2], slices=20)
                            translate([braceRadius,0,0])
                            circle(r=braceRadius, $fn=72);
                
                translate([0,0,-supportThickness])
                    scale([1.25,0.75,1])        
                        cylinder(r=braceRadius,h=supportThickness, $fn=72);
                }

                translate([-25,-50,-(1+supportThickness)])
                        cube([50,50,50], center=tru0);
            }
        }
        translate([-braceRadius-4,0,barrelThickness-7])
            rotate([0,45,0])
                cube([5,8,5], center=true);
    }
}

module Guide() {
    union() {
        difference() {
            union() {
      
                translate([-railWidth/2,-braceThickness/2,0])
                    cube([railWidth,
                          braceThickness,
                          bracePadding+braceOffset]);
                
                translate([0,
                           braceThickness/2,
                           bracePadding + braceOffset])
                    rotate([90,0,0])
                        scale([1,.75,1])
                            cylinder(r=railWidth/2,
                                     h=braceThickness,
                                     $fn=holeFacets);

            }
            translate([0,0,bracePadding + braceOffset])
                rotate([90,0,0])
                    cylinder(r=bottomHoleRadius,h=8,
                        center=true, $fn=holeFacets); 
        }
       // translate([0,0,bracePadding + braceOffset]) 
         //   rotate([0,45,0])
           // cube([bottomHoleRadius*1.65,0.5,bottomHoleRadius*1.65], center=true);
    }
        
}

module Reinforcement(length) {
  
    color("green")
    translate([railWidth/2,0,0])
    rotate([0,-90,0]) {
    linear_extrude(height=length/2,
                   scale=minReinforcingThickness/
                         maxReinforcingThickness)
      polygon(points=[[-.1,-.1],
                      [maxReinforcingThickness,-.1],
                      [-.1,maxReinforcingThickness]]);

    translate([0,0,length/2])
        linear_extrude(height=length/2,
                       scale=maxReinforcingThickness/
                             minReinforcingThickness)
            polygon(points=[[-.1,-.1],
                            [minReinforcingThickness,-.1],
                            [-.1,minReinforcingThickness]]);

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
