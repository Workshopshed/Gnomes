gap = 0.5;

module BoardHolder()
{
    diam=28;
    wall=1;
    hole=4;
    difference() {
        cylinder(h=5,d=diam+(wall*2)+(gap/2),$fn=200,centre=true);
        translate([0,0,1]) 
            cylinder(h=5,d=diam+(gap/2),$fn=200,centre=true);
        translate([13,13,-1]) 
            cylinder(h=7,d=hole+(gap/2),$fn=200,centre=true);
        translate([13,-13,-1]) 
            cylinder(h=7,d=hole+(gap/2),$fn=200,centre=true);
        translate([-13,-13,-1]) 
            cylinder(h=7,d=hole+(gap/2),$fn=200,centre=true);
        translate([-13,13,-1]) 
            cylinder(h=7,d=hole+(gap/2),$fn=200,centre=true);
    }
}

module Display()
{
    translate([-20/2,-28/2,5])
    {
        difference() {
            holeXoffset = (20-12)/2;
            holeYoffset = (28-22)/2;
            cube([20,28,2]);
            translate([holeXoffset,holeYoffset,0])
                cylinder(h=7,d=2+(gap/2),$fn=200,centre=true);
            translate([holeXoffset+12,holeYoffset,0])
                cylinder(h=7,d=2+(gap/2),$fn=200,centre=true);
            translate([holeXoffset,holeYoffset+22,0])
                cylinder(h=7,d=2+(gap/2),$fn=200,centre=true);
            translate([holeXoffset+12,holeYoffset+22,0])
                cylinder(h=7,d=2+(gap/2),$fn=200,centre=true);
        }
    }
}


//Mounting Holes: 12mm x 22mm / 0.5" x 0.9"
//20mm x 28mm x 4mm / 0.8" x 1.1" x 0.2"

BoardHolder();
Display();

