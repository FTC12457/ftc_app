$fn = 72;



MountHeight = 30;
MountThickness = 16;
SupportDepth = MountHeight+8;
MountDepth = SupportDepth+6 - MountThickness/2;

ShaftHeight = MountHeight;
ShaftRadius = 3.5;
PadWidth=27;

AnchorRadius = 2;
AttachRadius = 4;


rotate([0,90,0])
difference() {
    union() {
        translate([-PadWidth/2,-MountThickness/2,0])
            cube([PadWidth,MountThickness,MountDepth]);

        rotate([0,90,0])
            translate([0,0,-PadWidth/2])        
                cylinder(r=MountThickness/2,h=PadWidth);
        
        translate([0,0,MountDepth])
        rotate([0,90,0])
            translate([0,0, -PadWidth/2])        
                cylinder(r=MountThickness/2,h=PadWidth);
    }
    
    union () {
        translate([0,0,ShaftHeight])
            rotate([90,0,0])
                translate([0,0,-(MountThickness+2)/2])        
                    cylinder(r=ShaftRadius,h=MountThickness+2);
        
        translate([0,0, SupportDepth])
        rotate([0,90,0])
            translate([0,0,-(PadWidth+2)/2])        
                cylinder(r=AnchorRadius,h=PadWidth+2);

        rotate([0,90,0])
            translate([0,0,-(PadWidth+2)/2])        
                cylinder(r=AttachRadius,h=PadWidth+2);
    }
}


module Corner(radius, length){
translate([-radius,-radius,0])
        difference() {
                cube([radius, radius, length]);
            translate([0,0,-1])
            cylinder(r=radius,h=length+2);
        }  
}