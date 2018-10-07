

ScrewOffset = 22;
BlockWidth = 27.5;
BlockThickness = 10;

CutWidth = 16.5;
CutDepth = 3.5;
Padding = 0.5;
$fn = 72;

difference() {
    union () {
        cube([ScrewOffset, BlockWidth, BlockThickness]);
        translate([ScrewOffset, 0,BlockThickness/2])
            rotate([-90,0,0])
                cylinder(r=BlockThickness/2, h=BlockWidth);

    }
    
    union() {
        translate([ScrewOffset, 0,BlockThickness/2])
            rotate([-90,0,0])
                translate([0,0,-1])
                    cylinder(r=2,h=BlockWidth+2);
        
        translate([-1,(BlockWidth-CutWidth)/2,-1])
        cube([CutDepth+Padding+1, CutWidth, BlockThickness+2]);    
    
        translate([-1,(BlockWidth-CutWidth)/2,-1])
        cube([CutWidth+Padding+1, CutDepth, BlockThickness+2]);      

        translate([0,0,-1])
            rotate([0,0,180])
                Corner(1, BlockThickness+2);
        
        translate([0,BlockWidth,-1])    
            rotate([0,0,90])
                Corner(1, BlockThickness+2);
        
        translate([CutDepth+Padding,(BlockWidth-CutWidth)/2+CutDepth,-1])    
            rotate([0,0,180])
                Corner(1, BlockThickness+2);
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
