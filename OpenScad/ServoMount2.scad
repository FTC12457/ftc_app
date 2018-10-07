
HolderWidth = 27;
HolderLength = 44;
HolderThickness = 8;

ScrewOffset = -5;
HolderOffset = 4-ScrewOffset;

ServoWidth = 20;
ServoLength = 41;



HoleRadius = 2;
$fn = 72;


WedgeX = 2;
WedgeY = 2;

//Servo();

difference() {
    translate([-HolderWidth/2,-HolderOffset,0])
        cube([HolderWidth,HolderLength+HolderOffset,HolderThickness]);
    
    union () {
        translate([-ServoWidth/2,0,-1])
                cube([ServoWidth,ServoLength,HolderThickness+2]);
        
        translate([0,ScrewOffset,HolderThickness/2])
            rotate([0,90,0])
                translate([0,0,-(HolderWidth+2)/2])
                    cylinder(r=HoleRadius, h=HolderWidth+2);
    }
}

/*
difference() {
    translate([-HolderWidth/2,-HolderOffset,0])
        cube([HolderWidth,HolderOffset+HolderLength,HolderHeight]);
    Servo();
}*/

module Servo() {
    union () {
        translate([-ServoWidth/2,ServoBaseOffset, 0])
        cube([ServoWidth,ServoBaseLength,ServoBaseThickness+1]);

        translate([-ServoWidth/2,ServoMiddleOffset, ServoBaseThickness])
        cube([ServoWidth,ServoMiddleLength,ServoBodyHeight]);

        translate([-ServoWidth/2,-ServoPlateOffset,ServoBaseThickness+ServoMiddleThickness])
        cube([ServoWidth,ServoPlateLength+ServoPlateOffset*2,
              ServoBodyHeight]);
        
        translate([-5,0,0])
            cylinder(r=2,h=ServoBodyHeight);
        translate([5,0,0])
            cylinder(r=2,h=ServoBodyHeight);
        translate([-5,FarScrewOffset,0])
            cylinder(r=2,h=ServoBodyHeight);
        translate([5,FarScrewOffset,0])
            cylinder(r=2,h=ServoBodyHeight);
        translate([0,0,ServoBaseThickness+ServoMiddleThickness])
            rotate([0,90,0])
                translate([0,0,-1])
                    linear_extrude(height=2)
                    polygon([[0,-WedgeX],
                             [WedgeY,ServoMiddleOffset],
                             [0,5]]);
        translate([0,ServoMiddleLength+10,ServoBaseThickness+ServoMiddleThickness])         
            rotate([0,0,180])               
            rotate([0,90,0])
                translate([0,0,-1])
                    linear_extrude(height=2)
                    polygon([[0,-WedgeX],
                             [WedgeY,ServoMiddleOffset],
                             [0,5]]);

    }
}

/*union() {
    translate([-HolderWidth/2,-ServoOverhang,0])
        cube([HolderWidth, ServoOverhang+ServoOffset1, 3]);
    difference() {
        union () {
            translate([-HolderWidth/2, HolderOffset-ServoOverhang, 0])
                cube([HolderWidth, HolderLength+ServoOverhang,
                      HolderHeight]);
        }
        
        union () {
            translate([-ServoWidth/2, ServoOffset1, -1])
                cube([ServoWidth, ServoLength, HolderHeight+2]);
            
            translate([-ServoWidth/2, ServoOffset2, 3])
                cube([ServoWidth, ServoLength, 5]);

            translate([-ServoWidth/2, ServoOffset3, 8])
                cube([ServoWidth, ServoLength, HolderHeight+2]);
            translate([0,0,16])
                rotate([-20,0,0])
                    cube([2,20,20], center=true);

            translate([-5,0,-1])
                cylinder(r=2,h=10);
            translate([5,0,-1])
                cylinder(r=2,h=10);
            
            translate([-HolderWidth/2-1,0,14])
            rotate([0,90,0])
            cylinder(r=2,h=HolderWidth+2);
            
            
        }
        
    }
}
*/