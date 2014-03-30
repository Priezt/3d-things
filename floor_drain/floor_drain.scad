include <params.scad>;

module round_bar(length, radius, thickness){
	union(){
		for(y = [0, length]){
			translate([0, y, 0]){
				cylinder(thickness, radius, radius);
			}
		}
		translate([-radius, 0, 0]){
			cube([radius * 2, length, thickness]);
		}
	}
}


translate([-square_side / 2, -square_side / 2, 0]){
	union(){
		difference(){
			cube([square_side, square_side, square_thickness]);
			translate([square_side / 2, square_side / 2, 0]){
				for(i = [0:1:(bar_count - 1)]){
					rotate([0, 0, (360 / bar_count) * i]){
						translate([0, bar_padding, 0]){
							round_bar(bar_length, bar_radius, square_thickness);
						}
					}
				}
				cylinder(square_thickness, center_radius, center_radius);
			}
		}
		translate([square_side / 2, square_side / 2, 0]){
			difference(){
				cylinder(square_thickness + circle_verticle_thickness, circle_radius, circle_radius);
				cylinder(square_thickness + circle_verticle_thickness, circle_radius - circle_border_thickness, circle_radius - circle_border_thickness);
			}
		}
	}
}
