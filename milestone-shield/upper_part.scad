include <common.scad>;

upper_part_width = phone_width + shield_common_thickness * 2;
upper_part_height = phone_height + shield_common_thickness * 2;

difference(){
	union(){
		difference(){
			cube([upper_part_width, upper_part_height, phone_bottom_thickness]);
			translate([shield_common_thickness, shield_common_thickness, 0])
				cube([phone_width, phone_height, phone_bottom_thickness]);
		}
		connector4(upper_part_width, upper_part_height);

		translate([upper_part_width, upper_part_height, phone_bottom_thickness])
			rotate([0, 0, 180])
				difference(){
					cube([upper_part_width, shield_common_thickness + phone_screen_bottom_to_edge, max(shield_common_thickness, phone_total_thickness - phone_bottom_thickness)]);
					translate([upper_part_width / 2, shield_common_thickness + phone_screen_bottom_to_edge, 0]){
						cylinder(very_long, phone_mic_radius, phone_mic_radius);
					}
				}

		translate([0, 0, phone_bottom_thickness]){
			cube([upper_part_width, shield_common_thickness, phone_top_thickness]);
			translate([0, 0, phone_top_thickness])
				cube([upper_part_width, shield_common_thickness + phone_screen_top_to_edge, shield_common_thickness]);
		}

		translate([upper_part_width, 0, phone_bottom_thickness])
			rotate([0, 0, 90])
				cube([shield_common_thickness + phone_screen_length, shield_common_thickness, phone_top_thickness]);
	}
	// SPEAKER HOLE
	translate([upper_part_width / 2 - phone_speaker_width / 2, phone_speaker_to_edge,  phone_total_thickness])
		cube([phone_speaker_width, phone_screen_top_to_edge - phone_speaker_to_edge, shield_common_thickness]);
	// USB HOLE
	translate([upper_part_width - shield_common_thickness, phone_usb_to_top + shield_common_thickness, phone_usb_to_back])
		cube([shield_common_thickness, phone_usb_width, phone_usb_height]);
	// POWER BUTTON HOLE
	translate([shield_common_thickness + phone_power_to_right, 0, connector_thickness])
		cube([phone_power_width, shield_common_thickness, phone_power_button_hole_height]);
	// VOLUME BUTTON HOLE
	translate([0, phone_volume_button_to_edge + shield_common_thickness, phone_volume_button_to_bottom])
		cube([shield_common_thickness, phone_volume_button_width, phone_bottom_thickness - phone_volume_button_to_bottom]);
	// CAMERA BUTTON HOLE
	translate([0, upper_part_height, 0])
		rotate([0, 0, 180])
			translate([0, phone_camera_button_to_edge + shield_common_thickness, phone_camera_button_to_bottom])
				rotate([0, 0, 90])
					cube([phone_camera_button_width, shield_common_thickness + short_length, phone_bottom_thickness - phone_camera_button_to_bottom]);
}
