include <./MCAD/involute_gears.scad>;

//Dancing Gnomes

$fn = 80; //Circular resolution

assembly();

d1=100;// diameter of lower ring
t=4;// thickness of outer gears
t2=3; // thickness of inner gears
t1=1.2;// thickness of ring faces
b=0.25;// backlash
c=0.2;// clearance
pa=20;// pressure angle
s=0.4;// vertical clearance
td=0.8;// thickness of planet disk
pd=1.1;// planet disk diameter / pitch diameter
dp=0.85;// ring gear diameter / outside ring diameter

ns=10;// number of teeth on sun (lower)
np1=20;// number of teeth on lower planet

plug=3;
plugGapModifier=1.2;


//--------- Don't edit below here unless you know what you're doing.

nr1=ns+2*np1;// number of teeth on lower ring
pitch=nr1/(d1*dp);// diametral pitch of all gears

R1=(1+nr1/ns);// sun to planet-carrier ratio
Rp=(np1+ns)/np1;// planet to planet-carrier ratio
R=R1;
echo(str("na is : ",nr1));
echo(str("Gear Ratio is 1 : ",R1));
echo(str(pitch));

beam = ((ns+np1)/pitch);

echo(str(beam));

module assembly(){
    

beamthick = 1.5; 
    
chassis(beamthick);

translate([0,0,1])
rotate([0,0,0+360*R*$t])translate([(ns+np1)/pitch/2,0,0])rotate([0,0,-360*R*(1+Rp)*$t])
	color([0,0,1])planet();

        translate([0,0,1])
            rotate([0,0,180+360*R*$t])translate([(ns+np1)/pitch/2,0,0])rotate([0,0,-360*R*(1+Rp)*$t])
            color([0,0,1])planet();

    translate([beam/2,0,t+beamthick])
        color([1,0.5,0])
            tophat(plug,t+s+td/2,3);
    
    translate([-beam/2,0,t+beamthick])
        color([1,0.5,0])
            tophat(plug,t+s+td/2,3);
    
    translate([-beam/2,0,-1.5])
        color([0,1,1])
            mainbeam(beam,8,2,beamthick);

}

module chassis(beamthick) {
    color([0.5,0.5,0.5])
    union(){
    ring1();
    baseplate(t);
    translate([-5.5,-((d1-10)/2)+5,-t])
        crossbeam(6,d1-20,beamthick);
    }
}

module simplebeam(width,length,height) {
    translate([-width/2,-length/2,0])
    hull(){
            cylinder(d=width,h=height);
            translate([0,length/2,0])
                cylinder(d=width*1.8,h=height);
            translate([0,length,0])
               cylinder(d=width,h=height);	
            };
}

module crossbeam(width,length,height) {
    platel = 15;
    platew = 40;
    holespace = 35/2;
    difference() {
        translate([(width/2)+2,(length/2),0])
        union() {
            simplebeam(width,length,height);
            translate([0,width/2,0])
               rotate([0,0,90])
                    simplebeam(width,length,height);
            translate([3,0,0])
                roundsquare(platel,platew,height,5);
        }
        //Holes
        translate([2,0,0]) {
        translate([0.5+width/2,(length/2),-2])
            cylinder(d=10,h=height+4,$fn=20);
        //Mounting holes
        translate([8+width/2,holespace+(length/2),-2])
            cylinder(d=4.2,h=height+4,$fn=20);
        translate([8+width/2,-holespace+(length/2),-2])
            cylinder(d=4.2,h=height+4,$fn=20);
        }
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

module tophat(rad,height,hole) {
        top = 2;
        difference() {
        union () {
            cylinder(r=rad+1,h=top);
            translate([0,0,-height-2*c])
            cylinder(r=rad-c,h=height+2*c);	
        }
        translate([0,0,-2-height-2*c])
            cylinder(d=hole,h=top+height+3+2*c);
    }
}

module pin() {
    flat = 3-c;
    spindle = 5-c;
    intersection(){
        translate([-(flat/2),-spindle/2,0])
            cube([flat,spindle,10]);
        cylinder(h = 10, r=spindle/2);
    }
}

module mainbeam(length,width,height,hole) {
	difference() {
		//Body
		hull(){
		cylinder(d=width,h=height,center=true);
		translate([length/2,0,0])
			cylinder(d=width*1.8,h=height,center=true);
		translate([length,0,0])
			cylinder(d=width,h=height,center=true);	
		};
		//Holes
		cylinder(d=hole+c/2,h=height*1.5,center=true,$fn=20);
		translate([length,0,0])
			cylinder(d=hole+c/2,h=height*1.5,center=true,$fn=20);
        //stepper motor spindle
		translate([length/2,0,-4])
			pin();
	}
}

module baseplate(thick) {
    translate([0,0,-thick])
    difference() {
        cylinder(h = thick, r = beam-4);
        translate([0,0,-1])
            cylinder(h = thick+3, r = beam-11);
    }
}

module support() {
    difference() {
    cube([8,6,12]);
    scale([2,0.2,2])
        translate([2,15,3])
            rotate(45,0,0)
                cylinder(8,3,6,$fn=4);
    }
}


module planet(){
    union() {
	gear(number_of_teeth=np1,
		diametral_pitch=pitch,
		gear_thickness=t2+s+td/2,
		rim_thickness=t2+s+td/2,
		hub_thickness=t2+s+td/2,
		bore_diameter=2*plug,
		backlash=b,
		clearance=c,
		pressure_angle=pa);
        translate([5,-3,0])
            support();
        translate([-13,-3,0])
            support();
    }
}



module ring1() insidegear(nr1);

module insidegear(n)
difference(){
	cylinder(r=n/pitch/2/dp-3,h=t+t1);
	translate([0,0,-.5])
	gear(number_of_teeth=n,
		diametral_pitch=pitch,
		gear_thickness=t+5,
		rim_thickness=t+5,
		hub_thickness=t+5,
		bore_diameter=0,
		backlash=-b,
		clearance=0,
		pressure_angle=pa);
}
