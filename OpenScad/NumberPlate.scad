Label = "12547";
Height = 52;
Length = 220;
Offset = 0;
TopOffset = 64;
BracketWidth = 32;


BracketThickness = 0.9;
LetterThickness = 1.4;

$fn = 72;

HorizontalOffsetFactor = 4;
VerticalOffsetFactor = 9.0;
Scale = 6;

Letter("4");

module Letter(s) {
    difference() {
        union() {
            translate([Scale*HorizontalOffsetFactor-16,-15,0])
                cube([32,16,BracketThickness]);
            translate([Scale*HorizontalOffsetFactor-16,
                       Scale*VerticalOffsetFactor,0])
                cube([32,16,BracketThickness]);
            scale([Scale, Scale, 1.0])
              linear_extrude(height=LetterThickness)        
                text(s, center=true);
        }
        
        translate([Scale*HorizontalOffsetFactor-8,-8,-1])
            cylinder(r=2,h=BracketThickness+2);
        translate([Scale*HorizontalOffsetFactor+8,-8,-1])
            cylinder(r=2,h=BracketThickness+2);
        
        translate([Scale*HorizontalOffsetFactor-8,TopOffset,-1])
            cylinder(r=2,h=BracketThickness+2);
        translate([Scale*HorizontalOffsetFactor+8,TopOffset,-1])
            cylinder(r=2,h=BracketThickness+2);
    }
}
