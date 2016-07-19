gap = 0.5;

module BoardHolder()
{
    diam=27;
    wall=1;
    hole=4;
    difference() {
        translate([-17,-17,0])
            cube([34.25,34,5],centre=true);
        //cylinder(h=5,d=diam+(wall*2)+(gap/2),$fn=200,centre=true);
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

module MotorHolder()
{
    difference() {
        boardl=32;
        boardw=36;
        wall=1;
        cube([boardl+(2*wall)+(gap/2),boardw+(2*wall)+(gap/2),5],centre=true);
        translate([wall-(gap/4),wall-(gap/4),1]){
            cube([boardl+(gap/2),boardw+(gap/2),5],centre=true);
        }
    }
}


BoardHolder();
translate([-17,17,0])
    MotorHolder();
translate([-17,-55,0])
    MotorHolder();
