include <common.scad>;
echo(phone_height);
bottom_part_width = phone_width + shield_common_thickness * 2;
bottom_part_height = phone_height + shield_common_thickness * 2;
true_inner_edge = shield_common_thickness + shield_bottom_inner_edge;

difference(){
	cube([
		bottom_part_width,
		bottom_part_height,
		shield_common_thickness
	]);
	translate([true_inner_edge, true_inner_edge, 0])
		cube([
			bottom_part_width - true_inner_edge * 2, 
			bottom_part_height - true_inner_edge * 2, 
			shield_common_thickness
		]);
	translate([shield_common_thickness + phone_camera_center_to_left, shield_common_thickness + phone_height - phone_camera_center_to_top, 0])
		cylinder(shield_common_thickness, phone_camera_radius, phone_camera_radius);
}
connector4(bottom_part_width, bottom_part_height);

module belt_connector(){
	difference(){
		translate([-belt_connector_width / 2, -belt_connector_length / 2, 0])
			minkowski(){
				cube([belt_connector_width, belt_connector_length, belt_connector_thickness]);
				sphere(belt_round_radius);
			}
		translate([-belt_connector_width, -belt_hole_length / 2, 0])
			cube([belt_connector_width * 2, belt_hole_length, belt_hole_thickness]);
	}
}

translate([bottom_part_width / 2, bottom_part_height / 2, shield_common_thickness])
	put_rotated_2()
		translate([-phone_width / 2 - shield_common_thickness + belt_connector_from_edge + belt_connector_width / 2, 0, 0])
			belt_connector();

translate([phone_width / 2, 0, 0])
	rotate([0, 0, 180])
		pile();
translate([phone_width / 2, phone_height + shield_common_thickness * 2, 0])
	pile();
