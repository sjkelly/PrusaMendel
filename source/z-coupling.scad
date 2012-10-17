/*  Symmetric Prusia Z-coupling
    by Philip Hands <phil@hands.com>
    Copyright (C) 2011,
    distributed under the GNU GPL v2 (or later) license.
-   Inspired by:
    Yet Another Prusa Mendel Z Coupling by nophead
	is licensed under the Creative Commons - GNU GPL license.
*/

module nuttrap_inverted(h=2.2, bolt=1.8, nut=3.25, lh=0.2) {
	render()
	union() {
		translate([0, 0, -1]) cylinder(r=5.5 / cos(180 / 6) / 2 + 0.05, h=3.6, $fn=6);
		translate([0, 0, 2.8]) cylinder(r=1.6, h=10, $fn=32);
	}
}

module coupling(x=30,y=21,z=7,s=8,m=7, lh=0.2)
{
	intersection() {
		difference()
		{
			intersection()
			{
				translate([-x/2, -y/2, 0]) cube([x,y,z]);
				cylinder(h=z, r=sqrt(pow(x/2,2)+pow(max(s,m)/2+((y-max(s,m))/12),2)),$fn=128);
			}
	
			// Nut holes
			translate([-x/4,0 - s/2 - 1.55,-0.01]) nuttrap_inverted();
			translate([ x/4,0 - s/2 - 1.55,-0.01]) nuttrap_inverted();
	
			// bolt holes
			translate([-x/4,0 + s/2 + 1.55,-1]) cylinder(h=10, r=1.6, $fn=32);
			translate([ x/4,0 + s/2 + 1.55, -1]) cylinder(h=10, r=1.6, $fn=32);
	
			// dents for shafts
			translate([0, 0, z+0.5]) rotate([0,-90,0]) rotate([0, 0, 180/32]) cylinder(h=x/2+1, r=s/2, $fn=32);
			translate([-1, 0, z+0.5]) rotate([0,90,0]) rotate([0, 0, 180/32]) cylinder(h=x/2+2, r=m/2, $fn=32);
		}
		translate([0, 0, 7])rotate([0, 90, 0]) cylinder(r=22 / 2, h=40, center=true, $fn=128);
	}
}

coupling();


//translate([0, 30, 0]) coupling();
//translate([35, 0, 0]) coupling();
//translate([35, 30, 0]) coupling();
