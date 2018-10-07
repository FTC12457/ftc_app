
$fn = 36;

Base=2;
Depth = 16;
Height = 40;

Flat = 2;
Width = 12;

rotate([0,-90,0])
difference () {
    union () {
        minkowski() {
            translate([0,0,-Flat/2])
            linear_extrude(height=Flat)
            polygon([[0,0],[Height,0],[0,Depth]]);
            sphere(r=(Width -Flat)/2);
        }
    }
    
    union() {
        translate([Height+2,-50,-50])
           cube([100,100,100]);
        translate([-100,-50,-50])
            cube([100,100,100]);
        
        rotate([0,90,0])
            translate([0,0,40])
                cylinder(r=4,h=100);

        rotate([0,90,0])
            translate([0,0,-1])
                cylinder(r=2,h=100);
        translate([0,16,0])
        rotate([0,90,0])
            translate([0,0,-1])
                cylinder(r=2,h=100);
        
        translate([0,16,0])
            rotate([0,90,0])
                translate([0,0,Base])
                    cylinder(r=4,h=100);
        
    }
}