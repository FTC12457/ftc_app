sliderWidth = 30;
sliderHeight = 32;
sliderDepth = 6;

tabWidth = 8;
tabGapWidth = 3;
tabRadius = 300.0;
tabDepth = 4;

lowerWidth = 24;
lowerDepth = 2.5;

upperWidth=24;
upperDepth=4;

holeShift=4;
holeOffset = 8;
holeRadius = 2;

bigHoleDepth = 1.5;
bigHoleRadius = 4.75;

tabFacets = 256;
holeFacets = 144;
blockFacets = 144;

//BigHoles();
intersection() {
    union() {
        Slider();
        translate([0,0,32])
            Slider();
        translate([0,0,-32])
            Slider();
    }

    union() {
    translate([7,0,0])
        cube([41,100,96],center=true);
    translate([0,0,-18])
        cube([100,100,76],center=true);
    }
}

//translate([0,sliderHeight*1.25,0])
//    Slider();


module Slider()
{
    rotate([90,0,0])
    difference()
    {
        union() {
            translate([sliderWidth/2,0,0])
                Tab();
            translate([-sliderWidth/2,0,0])
                Tab();
            translate([0,0,sliderDepth/2])
                cube([sliderWidth-tabWidth,sliderHeight,sliderDepth],
                     center=true);

        }
        translate([holeShift,0,0])
        Holes();

        
        translate([0,0,sliderDepth])
            RoundedBlock(upperWidth, 2*sliderHeight, 2*upperDepth);
     /*   translate([0,0,0])
            RoundedBlock(lowerWidth, 2*sliderHeight, 2*lowerDepth);*/
    }
}

module Tab() {
    union() {
        translate([0,0,sliderDepth/2])
            intersection() {
                cube([tabWidth,sliderHeight,sliderDepth],
                     center = true);
                union() {
                    translate([tabRadius + tabGapWidth/2,0,0])
                        cylinder(h = sliderDepth*2, r = tabRadius, 
                                 center=true, $fn=tabFacets);
                    translate([-(tabRadius + tabGapWidth/2),0,0])
                        cylinder(h = sliderDepth*2, r = tabRadius, 
                                 center=true, $fn=tabFacets);

               }
           }
        translate([0,0,(sliderDepth-tabDepth)/2])
           cube([tabWidth,sliderHeight,(sliderDepth-tabDepth)], center=true);
   }
}

module Holes() {
  //  translate([holeOffset,0,0])
   //     cylinder(r=holeRadius,h=3*sliderDepth, center=true, $fn=holeFacets);
    translate([-holeOffset,0,0])
        cylinder(r=holeRadius,h=3*sliderDepth, center=true, $fn=holeFacets);
    translate([0,holeOffset,0])
        cylinder(r=holeRadius,h=3*sliderDepth, center=true, $fn=holeFacets);
    translate([0,-holeOffset,0])
        cylinder(r=holeRadius,h=3*sliderDepth, center=true, $fn=holeFacets);
}

module BigHoles() {/*
    rotate([0,180])
    translate([holeOffset,0,0])
        linear_extrude(height = 2*bigHoleDepth, center=true, scale=1.5)
        circle(r=bigHoleRadius,$fn=6);
    
    rotate([0,180])
    translate([-holeOffset,0,0])
        linear_extrude(height = 2*bigHoleDepth, center=true, scale=1.5)
        circle(r=bigHoleRadius,$fn=6);
    
    rotate([0,180])
    translate([0,holeOffset,0])
        linear_extrude(height = 2*bigHoleDepth, center=true, scale=1.5)
        circle(r=bigHoleRadius,$fn=6);
    
    rotate([0,180])
    translate([0,-holeOffset,0])
        linear_extrude(height = 2*bigHoleDepth, center=true, scale=1.5)
        circle(r=bigHoleRadius,$fn=6);
    */
    translate([holeOffset,0,0]) 
        rotate([0,0,30])   
            cylinder(r=bigHoleRadius,h=2*bigHoleDepth,
                     center=true, $fn=6);
    translate([-holeOffset,0,0])
        rotate([0,0,30])
            cylinder(r=bigHoleRadius,h=2*bigHoleDepth,
                     center=true, $fn=6);
    translate([0,holeOffset,0])
        rotate([0,0,30])
            cylinder(r=bigHoleRadius,h=2*bigHoleDepth,
                     center=true, $fn=6);
    translate([0,-holeOffset,0])
        rotate([0,0,30])
            cylinder(r=bigHoleRadius,h=2*bigHoleDepth,
                     center=true, $fn=6);
}

module RoundedBlock(width, length, height, radius)
{
    cube([width, length, height], center=true);
}
