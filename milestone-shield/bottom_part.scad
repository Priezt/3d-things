include <params.scad>;
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
}
connector4(bottom_part_width, bottom_part_height);
translate([bottom_part_width / 2, bottom_part_height / 2, shield_common_thickness])
	put_rotated_2()
		cube([1, 1, 1]);
