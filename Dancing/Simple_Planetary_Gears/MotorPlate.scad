//A motor mounting bracket for 28BYJ-48 stepper motor

motorplate(40,22,1.5);

module motorplate(platew,platel,height) {
    holespace = 35/2;
    difference() {
        roundsquare(platel,platew,height,5);
        
        //Holes
        translate([0,0,-2])
            cylinder(d=10,h=height+4,$fn=20);
        //Mounting holes
        translate([8,holespace,-2])
            cylinder(d=4.2,h=height+4,$fn=20);
        translate([8,-holespace,-2])
            cylinder(d=4.2,h=height+4,$fn=20);
    }
}

module roundsquare(width,length,height,corner) {
    w2=width-corner/2;
    l2=length-corner/2;
    hull(){
        translate([-w2/2,-l2/2,0])
            cylinder(d=corner,h=height);
        translate([w2/2,-l2/2,0])
            cylinder(d=corner,h=height);
        translate([w2/2,l2/2,0])
            cylinder(d=corner,h=height);
        translate([-w2/2,l2/2,0])
            cylinder(d=corner,h=height);
    }
}

