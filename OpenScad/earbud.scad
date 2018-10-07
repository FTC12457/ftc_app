
$fn = 72;


Stretch = 2;
ShaftLength = 100;
ShaftRadius = 10;
BaseLength = 10;
BaseRadius = 40;
BaseTransition=10;
WallThickness = 1.5;
TopTransition = 30;
TopLength=30;



difference() {
    scale([1,Stretch,1]) {
        cylinder(r=BaseRadius,h=BaseLength);
        translate([0,0,BaseLength])
            cylinder(r1=BaseRadius, r2=ShaftRadius,h=BaseTransition);
        translate([0,0,BaseLength+BaseTransition])
            cylinder(r=ShaftRadius,h=ShaftLength);
        translate([0,0,BaseLength+ShaftLength])
            cylinder(r1=ShaftRadius, r2=BaseRadius,h=TopTransition);
        translate([0,0,BaseLength+ShaftLength+TopTransition])
            cylinder(r=BaseRadius,h=TopLength);
    }
    scale([1,Stretch,1])
        translate([0,0,BaseLength+ShaftLength+TopTransition])
                cylinder(r=BaseRadius-WallThickness,h=TopLength+1);
}