include <params.scad>;

module connector(){
	difference(){
		union(){
			translate([-connector_radius, 0, 0]){
				cube([connector_radius * 2, connector_radius, connector_thickness]);
			};
			translate([0, connector_radius, 0]){
				cylinder(connector_thickness, connector_radius, connector_radius);
			}
		};
		translate([0, connector_radius, 0])union(){
			cylinder(connector_thickness, screw_diameter / 2, screw_diameter / 2);
			translate([0, 0, screw_depth]){
				cylinder(connector_thickness - screw_depth, screw_cap_diameter / 2, screw_cap_diameter / 2);
			}
		};
	}
}

module connector2(width){
	for(t = [
		[connector_radius, 0, 0],
		[width - connector_radius, 0, 0]
	]){
		translate(t)
			rotate([0, 0, 180])
				connector();
	}
}

module connector4(width, height){
	connector2(width);
	translate([width, height, 0])
		rotate([0, 0, 180])
			connector2(width);
}

module put_rotated_2(){
	for(i = [0:$children-1])
		child(i);
	rotate([0, 0, 180])
		for(i = [0:$children-1])
			child(i);
}

module drop(width, height, depth){
	translate([width / 2, height / 2, 0])
		rotate([180, 180, 180])
			cube([width, height, depth]);
}

module pile(ratio=1){
	stick_length = 20 * ratio;
	ring_radius = 12 * ratio;
	ring_width = 5 * ratio;
	stick_width = 5 * ratio;
	thickness = 3;
	union(){
		translate([-stick_width/2, 0, 0])
			cube([stick_width, stick_length, thickness]);
		translate([0, stick_length, 0])
			difference(){
				cylinder(thickness, ring_radius, ring_radius);
				cylinder(thickness, ring_radius - ring_width, ring_radius - ring_width);
			}
	}
}
