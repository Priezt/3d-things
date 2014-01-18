include <params.scad>;

module put_rotated_2(){
	for(i = [0:$children-1])
		child(i);
	rotate([0, 0, 180])
		for(i = [0:$children-1])
			child(i);
}

module half_part(radius, distance_to_center){
	difference(){
		cylinder(depth, radius, radius);
		translate([-radius, -radius, 0])
			cube([radius * 4, distance_to_center + radius, depth]);
	}
}

module half_hollow_part(radius, distance_to_center, thickness){
	difference(){
		half_part(radius, distance_to_center);
		half_part(radius - thickness, distance_to_center + thickness);
	}
}

module ring(radius, thickness, depth){
	difference(){
		cylinder(depth, radius + thickness, radius + thickness);
		cylinder(depth, radius, radius);
	}
}

module half_ring(radius, thickness, depth){
	difference(){
		ring(radius, thickness, depth);
		rotate([0, 0, 180])
			translate([-radius - thickness, 0, 0])
				cube([(radius + thickness) * 2, radius + thickness, depth]);
	}
}

module ring_for_angle(radius, thickness, depth, angle){
	rotate_angle = 90 - angle / 2;
	intersection(){
		rotate([0, 0, rotate_angle])
			half_ring(radius, thickness, depth);
		rotate([0, 0, -rotate_angle])
			half_ring(radius, thickness, depth);
	}
}

ring(pelton_radius + empty_distance, ring_thickness, ring_depth);
put_rotated_2(){
	union(){
		half_hollow_part(pelton_radius - empty_distance, (middle_thickness / 2) + empty_distance, common_thickness);
		ring_for_angle(pelton_radius - empty_distance * 2, empty_distance * 4, ring_depth, 120);
	}
}

//ring_for_angle(pelton_radius - empty_distance, empty_distance * 2, ring_depth, 120);
