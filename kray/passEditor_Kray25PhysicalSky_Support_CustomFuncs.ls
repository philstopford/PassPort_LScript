scnGen_kray25_physky_get_time
{
	// Grab current time array
	sys_time = time();

	// Set the hour
	setvalue(kray25_PhySky_c_hour,sys_time[1]);

	// Set the minutes
	setvalue(kray25_PhySky_c_minute,sys_time[2]);

	// Set the seconds
	setvalue(kray25_PhySky_c_second,sys_time[3]);
}

scnGen_kray25_physky_get_date
{
	// Grab current date array
	sys_date = date();

	// Set the day
	setvalue(kray25_PhySky_c_day, sys_date[1]);

	// Set the month
	setvalue(kray25_PhySky_c_month, sys_date[2]);

	// Set the year
	setvalue(kray25_PhySky_c_year, sys_date[3]);
}

scnGen_kray25_physky_city_presets_refresh : value
{
	if (value > 1) {
		value = (value - 1) * 3 - 2;

		// Set the Longitude
		setvalue(kray25_PhySky_c_lattitude, kray25_PhySky_city_coords_list[value]);

		// Set the Latitude
		setvalue(kray25_PhySky_c_longitude, kray25_PhySky_city_coords_list[value + 1]);
		
		// Set the Time zone
		tz = kray25_PhySky_city_coords_list[value + 2];
		tz = int(tz) * 0.01;
		setvalue(kray25_PhySky_c_time_zone, tz);
		
		scnGen_kray25_physky_move_map_crosshair();
	}
}

scnGen_kray25_physky_longituderefresh : value{

	if (value<-180) setvalue(kray25_PhySky_c_longitude,360+value);
	if (value>180) setvalue(kray25_PhySky_c_longitude,-360+value);

	scnGen_kray25_physky_move_map_crosshair();
	scnGen_kray25_physky_timezone_refresh();
}

scnGen_kray25_physky_lattituderefresh : value{

	if (value<-90) setvalue(kray25_PhySky_c_lattitude,180+value);
	if (value>90) setvalue(kray25_PhySky_c_lattitude,-180+value);

	scnGen_kray25_physky_move_map_crosshair();
}

scnGen_kray25_physky_timezone_refresh {

	tz = getvalue(kray25_PhySky_c_longitude)/15;
	setvalue(kray25_PhySky_c_time_zone, tz);
}

// mouse moves

reqmousemove: md {

	kray25_PhySky_mouse_x = md.x;
	kray25_PhySky_mouse_y = md.y;

	// Is LMB down and within map image?
	if(kray25_PhySky_mouse_x >= kray25_PhySky_frame_x && kray25_PhySky_mouse_x <= kray25_PhySky_frame_max_x && kray25_PhySky_mouse_y >= kray25_PhySky_frame_y && kray25_PhySky_mouse_y <= kray25_PhySky_frame_max_y)
	{
		lg = -180 + (kray25_PhySky_mouse_x - kray25_PhySky_frame_x);
		lt = (-90 + (kray25_PhySky_mouse_y - kray25_PhySky_frame_y)) * -1;

		setvalue(kray25_PhySky_c_longitude, lg);
		setvalue(kray25_PhySky_c_lattitude, lt);
		setvalue(kray25_PhySky_c_city_preset,1);
	}
}

reqmousedown: md {
	kray25_PhySky_mouse_x = md.x;
	kray25_PhySky_mouse_y = md.y;

	// Is LMB down and within map image?
	if(kray25_PhySky_mouse_x >= kray25_PhySky_frame_x && kray25_PhySky_mouse_x <= kray25_PhySky_frame_max_x && kray25_PhySky_mouse_y >= kray25_PhySky_frame_y && kray25_PhySky_mouse_y <= kray25_PhySky_frame_max_y)
	{
		lg = -180 + (kray25_PhySky_mouse_x - kray25_PhySky_frame_x);
		lt = (-90 + (kray25_PhySky_mouse_y - kray25_PhySky_frame_y)) * -1;

		setvalue(kray25_PhySky_c_longitude, lg);
		setvalue(kray25_PhySky_c_lattitude, lt);
		setvalue(kray25_PhySky_c_city_preset,1);
	}
}

scnGen_kray25_physky_move_map_crosshair {
	if (kray25_PhySky_map_image){
		kray25_PhySky_mouse_x = getvalue(kray25_PhySky_c_longitude) + 180 + kray25_PhySky_frame_x;
		kray25_PhySky_mouse_y = ((getvalue(kray25_PhySky_c_lattitude))/-1) + 90 + kray25_PhySky_frame_y;

		// Remove drawing bug where crosshair lines go over the specified area (far right and bottom edges)  Don't know why!
		drawerase(kray25_PhySky_frame_x, kray25_PhySky_frame_max_y, kray25_PhySky_frame_w, 2);
		drawerase(kray25_PhySky_frame_max_x, kray25_PhySky_frame_y, 2, kray25_PhySky_frame_h);
		drawglyph(kray25_PhySky_map_image,kray25_PhySky_frame_x,kray25_PhySky_frame_y);

		// Vertical crosshair
		drawline(<255,000,000>, kray25_PhySky_mouse_x, kray25_PhySky_frame_y + 1, kray25_PhySky_mouse_x, kray25_PhySky_frame_max_y - 2);

		// Horizontal crosshair
		drawline(<255,000,000>, kray25_PhySky_frame_x + 1, kray25_PhySky_mouse_y, kray25_PhySky_frame_max_x - 2, kray25_PhySky_mouse_y);
	}
}

scnGen_kray25_physky_toggle_kray_physky: value
{
//    send_comring_message(1,2,value);
}
