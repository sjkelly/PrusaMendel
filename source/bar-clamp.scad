wedge_width = 7.6;
m8_diam_tight = 8.2;
m8_diameter = 8.6;
wall_thickness = 3.3;

wedge_outer_angle = 2;

$fn=64;

module teardrop (r=8, h=20) {
    render()
    rotate([-270, 0, 90]) {
        cylinder(r=r, h=h, $fn=64);
        translate([-(r * sqrt(2)) / 2, 0, 0]) cube([r * sqrt(2), r * sqrt(2) / 2, h]);
        difference() {
            rotate([0, 0, 45]) cube([r, r, h]);
            translate([-r, r, -1]) cube([2 * r, r, h + 2]);
        }
    }
}


module barclamp() {
	hole_radius = (m8_diam_tight + m8_diameter) / 4;
	body_radius = hole_radius + wall_thickness;

	difference(){
		union(){
			// rod clamp
			cylinder(r=body_radius, h=body_radius * 2);

			// arms
			translate([0, -body_radius * 1.5, 0]) cube([hole_radius * 2, body_radius * 3, body_radius * 2]);
			// horizontal hole outer
			translate([hole_radius * 2, 0, body_radius]) rotate([90, 0, 0]) cylinder(r=body_radius / cos(180 / 6), h = body_radius * 3, center=true, $fn=6);
		}

		// rod hole - tight!
		#translate([0, 0, -1]) cylinder(r=m8_diam_tight / 2, h=body_radius * 2 + 2);

		// horizontal hole
		#translate([hole_radius * 2, -body_radius * 1.5 - 1, body_radius]) rotate([0, 0, 90]) teardrop(r=m8_diameter / 2, h=body_radius * 3 + 2);

		// wedge
		translate([0, wedge_width / -2, -1]) cube([body_radius * 3, wedge_width, body_radius * 2 + 2]);

		// wedge outer angle
		rotate([0, 0, wedge_outer_angle]) translate([-1, body_radius, -1]) cube([body_radius * 3, body_radius, body_radius * 2 + 2]);
		rotate([0, 0, -wedge_outer_angle]) translate([-1, -2 * body_radius, -1]) cube([body_radius * 3, body_radius, body_radius * 2 + 2]);
	}
}

barclamp();
