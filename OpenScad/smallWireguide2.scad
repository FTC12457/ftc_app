
width=12;
holeOffset = 8;
holeRadius = 2;

facets = 144;

height=8;
wrenchRadius=1.5;
wireRadius = 6;
screwRadius=4;
screwHeight=2;
wallThickness = 1;
baseThickness = 3;

cutHeight = height+2;
cutOffset=3;
cutThickness=2.5;

yScale = 0.75;

gap=0.25;

hookThickness = 2;
socketWallThickness = 1.25;
socketThickness = hookThickness + (socketWallThickness +gap)* 2;
socketExtension = 6;
socketLength = (wireRadius + wallThickness)*yScale + socketExtension;
socketHeight = 5;

hookWidth = 2.5;
hookHeight = height/2+5;
hookOffset = socketLength - hookWidth-1;
hookRadius = sqrt(hookWidth*hookWidth + hookThickness*hookThickness)/2;
echo(hookRadius);

Guide();

module SineCut(length, amplitude, height, thickness, segments)
{
    translate([-length/2,0,0])

        linear_extrude(height=height, center=true, convexity=5)
            polygon(points=[for(i=[0:segments])
                            Position(i, segments, length, amplitude, thickness/2),
                            for(i=[segments:-1:0])
                            Position(i, segments, length, amplitude, -thickness/2)]);
}

function Position(i, segments, length, amplitude, halfThickness) = 
                    [length*i/segments,
                     amplitude * cos(i * 180/segments) + halfThickness];


module Guide() {
    difference() {
        union() {
            scale([1,yScale,1])
                cylinder(r=wireRadius + wallThickness, h=height, center=true, $fn = facets);
            translate([0,0,-height/2])
                RoundedCube(socketThickness, socketLength, socketHeight);
            
            translate([0,hookOffset+hookWidth/2,hookHeight])       
                sphere(r=hookRadius,$fn=facets);
            translate([hookThickness/2,0,0])
                rotate([0,-90,0])
                    linear_extrude(height=hookThickness)
                        polygon([[socketHeight-height/2,wireRadius*yScale],
                                 [height/2,wireRadius*yScale],
                                 [hookHeight,hookOffset],
                                 [hookHeight,hookOffset+hookWidth],
                                 [socketHeight-height/2+socketThickness/2,socketLength],
                                 [socketHeight-height/2,socketLength]]);
            
  
        }
        
        translate([0,(wireRadius + wallThickness) * yScale,-height/2-1])
            RoundedCube(hookThickness+2*gap, socketLength+1, socketHeight+1);
        
        scale([1,yScale,1])
            cylinder(r=wireRadius, h=height+2, center=true, $fn = facets);
        
        translate([wireRadius+wallThickness/2,0,0])
            rotate([0,90,0])
                SineCut(height+0.25,2,5,cutThickness, facets);  
        
        /*translate([wireRadius,cutOffset+baseThickness-height/2,0])
        rotate([0,45,-90]) {
            translate([0,0,(cutHeight-cutThickness)/2])
                cube([cutThickness,wallThickness+16,cutHeight], center=true);

            translate([(cutHeight-cutThickness)/2,0,0])
                cube([cutHeight,wallThickness+16,cutThickness], center=true);
        }*/
            
        translate([0,hookOffset+hookWidth/2,-height/2+hookRadius+1])       
            sphere(r=hookRadius+gap,$fn=facets);
    }
}



module RoundedCube(width, depth, height)
{
    union() {
        translate([-width/2,0,0])
            cube([width, depth, height]);
        translate([0,0,height])
            rotate([-90,0,0])
                cylinder(r=width/2,h=depth,$fn = facets);
    }
}
