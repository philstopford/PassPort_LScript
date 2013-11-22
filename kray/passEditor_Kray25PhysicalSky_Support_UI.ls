scnmasterOverride_UI_kray25_physky
{
    // User Interface Layout Variables
    kray25_ps_gad_x                   = 0;                                            // Gadget X coord
    kray25_ps_gad_y                   = 24;                                           // Gadget Y coord
    kray25_ps_gad_w                   = 200;                                                // Gadget width
    kray25_ps_gad_h                   = 19;                                           // Gadget height
    kray25_ps_gad_text_offset         = 95;                                           // Gadget text offset
    kray25_ps_slider_w                = 22;                                           // Gadget slider width
    kray25_ps_gad_prev_w              = 0;                                            // Previous gadget width temp variable
    kray25_ps_ui_window_w             = 440;                                                // Window width
    // Height of banner graphic and window height
    kray25_ps_ui_banner_height  = 0;
    kray25_ps_ui_window_h             = 407 + kray25_PhySky_modal * 40;
    kray25_ps_ui_spacing              = 3;                                            // Spacing gap size
    kray25_ps_spacer_w                = 21;                                           // Horizontal spacing
    kray25_ps_ui_offset_x             = 0;                                            // Main X offset from 0
    kray25_ps_ui_offset_y             = kray25_ps_ui_banner_height+(kray25_ps_ui_spacing*2);  // Main Y offset from 0
    kray25_ps_ui_row                        = 0;                                            // Row number
    kray25_ps_ui_column               = 0;                                            // Column number
    kray25_ps_ui_tab_offset           = kray25_ps_ui_offset_y + 23;                           // Offset for tab height
    kray25_ps_ui_seperator_w          = kray25_ps_ui_window_w + 2;                            // Width of seperators
    kray25_ps_ui_row_offset           = kray25_ps_gad_h + kray25_ps_ui_spacing;               // Row offset
    kray25_ps_ui_tab_bottom           = kray25_ps_ui_offset_y + kray25_ps_ui_row_offset 
                                      + kray25_ps_ui_spacing + kray25_ps_gad_h;             // The bottom of the tab gadgets

    // We have our own settings array. This has been setup/populated by the main Kray routine.

    kray25_PhySky_SettingIndex = 2; // Increment to get past our tag.
    kray25_PhySky_v_onFlag = int(::kray25_PhySky_settings[kray25_PhySky_SettingIndex]);

    kray25_PhySky_SettingIndex++;
    kray25_PhySky_v_city_preset = int(::kray25_PhySky_settings[kray25_PhySky_SettingIndex]);

    kray25_PhySky_SettingIndex++;
    kray25_PhySky_v_hour = int(::kray25_PhySky_settings[kray25_PhySky_SettingIndex]);

    kray25_PhySky_SettingIndex++;
    kray25_PhySky_v_minute = int(::kray25_PhySky_settings[kray25_PhySky_SettingIndex]);

    kray25_PhySky_SettingIndex++;
    kray25_PhySky_v_second = int(::kray25_PhySky_settings[kray25_PhySky_SettingIndex]);

    kray25_PhySky_SettingIndex++;
    kray25_PhySky_v_day = int(::kray25_PhySky_settings[kray25_PhySky_SettingIndex]);

    kray25_PhySky_SettingIndex++;
    kray25_PhySky_v_month = int(::kray25_PhySky_settings[kray25_PhySky_SettingIndex]);

    kray25_PhySky_SettingIndex++;
    kray25_PhySky_v_year = int(::kray25_PhySky_settings[kray25_PhySky_SettingIndex]);

    kray25_PhySky_SettingIndex++;
    kray25_PhySky_v_longitude = number(::kray25_PhySky_settings[kray25_PhySky_SettingIndex]);

    kray25_PhySky_SettingIndex++;
    kray25_PhySky_v_north = number(::kray25_PhySky_settings[kray25_PhySky_SettingIndex]);

    kray25_PhySky_SettingIndex++;
    kray25_PhySky_v_lattitude = number(::kray25_PhySky_settings[kray25_PhySky_SettingIndex]);

    kray25_PhySky_SettingIndex++;
    kray25_PhySky_v_time_zone = int(::kray25_PhySky_settings[kray25_PhySky_SettingIndex]);

    kray25_PhySky_SettingIndex++;
    kray25_PhySky_v_turbidity = number(::kray25_PhySky_settings[kray25_PhySky_SettingIndex]);

    kray25_PhySky_SettingIndex++;
    kray25_PhySky_v_exposure = number(::kray25_PhySky_settings[kray25_PhySky_SettingIndex]);

    kray25_PhySky_SettingIndex++;
    kray25_PhySky_v_volumetric = int(::kray25_PhySky_settings[kray25_PhySky_SettingIndex]);

    kray25_PhySky_SettingIndex++;
    kray25_PhySky_v_ignore = string(::kray25_PhySky_settings[kray25_PhySky_SettingIndex]);

    kray25_PhySky_SettingIndex++;
    kray25_PhySky_skyON = int(::kray25_PhySky_settings[kray25_PhySky_SettingIndex]);

    kray25_PhySky_SettingIndex++;
    kray25_PhySky_sunON = int(::kray25_PhySky_settings[kray25_PhySky_SettingIndex]);

    kray25_PhySky_SettingIndex++;
    kray25_PhySky_v_SunIntensity = number(::kray25_PhySky_settings[kray25_PhySky_SettingIndex]);
    
    kray25_PhySky_SettingIndex++;
    kray25_PhySky_v_SunShadow = number(::kray25_PhySky_settings[kray25_PhySky_SettingIndex]);

    kray25_PhySky_SettingIndex++;
    kray25_PhySky_v_sunpower = number(::kray25_PhySky_settings[kray25_PhySky_SettingIndex]);

    passLightNameArray = nil;
    passLightIDArray = nil;

    passItemsIDsArray = parse("||",::passAssItems[::currentChosenPass]);
    passLightArrayIndex = 1;
    for (i = 1; i <= passItemsIDsArray.size(); i++)
    {
        for (j = 1; j <= ::lightIDs.size(); j++)
        {
            if(passItemsIDsArray[i] == ::lightIDs[j])
            {
                passLightIDArray[passLightArrayIndex] = passItemsIDsArray[i];
                // Name look-up
                for(k = 1; k <= ::displayIDs.size(); k++)
                {
                    if(::displayIDs[k] == passItemsIDsArray[i])
                    {
                        nameIndex = k;
                    }
                }
                passLightNameArray[passLightArrayIndex] = ::displayNames[nameIndex];
                passLightArrayIndex++;
            }
        }
    }
    if(passLightArrayIndex == 1)
    {
        passLightNameArray = @"No light found in pass!"@;
        kray25_PhySky_v_ignore_index = 1; // will correspond to our blank in the menu, even with scene reload.
    } else {
        lightArray = size(passLightNameArray);
        for (i = lightArray; i >= 1; i--)
        {
            passLightNameArray[i + 1] = passLightNameArray[i];
            passLightIDArray[i + 1] = passLightIDArray[i];
        }
        passLightNameArray[1] = ""; // a blank entry to allow user to avoid ignoring any lights.
        passLightIDArray[1] = nil;
        kray25_PhySky_v_ignore_index = passLightIDArray.indexOf(kray25_PhySky_v_ignore);
        if (kray25_PhySky_v_ignore_index == 0)
        {
            kray25_PhySky_v_ignore_index = 1; // failed to find a match, so set our index to the first entry which is blank.
        }
    }

    ::doKeys = 0;

    reqbeginstr = "New Override - Kray 2.5 Physical Sky";
    if(action == "edit")
    {
        reqbeginstr = "Edit Override - Kray 2.5 Physical Sky";
    }
    reqbegin(reqbeginstr);
    reqsize(kray25_ps_ui_window_w, kray25_ps_ui_window_h + 250);
    // Update to show crosshairs
    reqredraw("scnGen_kray25_physky_move_map_crosshair");

    // Turn off plugin      
    kray25_PhySky_c_onFlag = ctlcheckbox("Enable Plugin",kray25_PhySky_v_onFlag);
    ctlposition(kray25_PhySky_c_onFlag, kray25_ps_gad_x - 49, kray25_ps_ui_offset_y, 210, kray25_ps_gad_h, kray25_ps_gad_text_offset);
    ctlrefresh(kray25_PhySky_c_onFlag,"scnGen_kray25_physky_toggle_kray_physky");
      
    // Location preset popup menu
    kray25_PhySky_c_city_preset=ctlpopup("Location Preset", kray25_PhySky_v_city_preset, kray25_PhySky_city_presets_list);
    ctlposition(kray25_PhySky_c_city_preset, kray25_ps_gad_x + 196, kray25_ps_ui_offset_y, 210, kray25_ps_gad_h, kray25_ps_gad_text_offset);
    ctlrefresh(kray25_PhySky_c_city_preset,"scnGen_kray25_physky_city_presets_refresh");

    kray25_ps_ui_offset_y += kray25_ps_ui_row_offset + 3;

    if (::compiled == 1)
    {
        kray25_PhySky_c_map=ctlimage("kray_physical_sky_map.tga");
        ctlposition(kray25_PhySky_c_map,kray25_PhySky_frame_x,kray25_ps_ui_offset_y);
    }
    else
    {
        f_map = ::this_script_path + "kray_physical_sky_map.tga";
        if (f_map)
        {
            kray25_PhySky_c_map=ctlimage(f_map);
        }
        ctlposition(kray25_PhySky_c_map,kray25_PhySky_frame_x,kray25_ps_ui_offset_y);
    }
    kray25_PhySky_map_image = Glyph(MapGlyph);

    kray25_ps_ui_offset_y += 180 - kray25_ps_ui_row_offset + 3;

    kray25_ps_ui_offset_y += kray25_ps_ui_row_offset + 4;
    kray25_PhySky_c_sep = ctlsep(0, kray25_ps_ui_seperator_w + 4);
    ctlposition(kray25_PhySky_c_sep, -2, kray25_ps_ui_offset_y);
    kray25_ps_ui_offset_y += kray25_ps_ui_spacing + 5;

    // kray25_PhySky_c_hour = ctlinteger("Hour",kray25_PhySky_v_hour);
    kray25_PhySky_c_hour = ctlminislider("Hour", kray25_PhySky_v_hour, 0, 24);
    ctlposition(kray25_PhySky_c_hour, kray25_ps_gad_x, kray25_ps_ui_offset_y, kray25_ps_gad_w - kray25_ps_slider_w, kray25_ps_gad_h, kray25_ps_gad_text_offset);

    kray25_PhySky_c_time_now = ctlbutton("Get Current Time",1,"scnGen_kray25_physky_get_time");
    ctlposition(kray25_PhySky_c_time_now, kray25_ps_gad_x + kray25_ps_gad_w + 117, kray25_ps_ui_offset_y, kray25_ps_gad_w - kray25_ps_gad_text_offset, kray25_ps_gad_h);

    kray25_ps_ui_offset_y += kray25_ps_ui_row_offset;

    kray25_PhySky_c_minute = ctlminislider("Minute", kray25_PhySky_v_minute, 0, 60);
    ctlposition(kray25_PhySky_c_minute, kray25_ps_gad_x, kray25_ps_ui_offset_y, kray25_ps_gad_w - kray25_ps_slider_w, kray25_ps_gad_h, kray25_ps_gad_text_offset);

    kray25_ps_ui_offset_y += kray25_ps_ui_row_offset;

    kray25_PhySky_c_second = ctlminislider("Seconds", kray25_PhySky_v_second, 0, 60);
    ctlposition(kray25_PhySky_c_second, kray25_ps_gad_x, kray25_ps_ui_offset_y, kray25_ps_gad_w - kray25_ps_slider_w, kray25_ps_gad_h, kray25_ps_gad_text_offset);

    kray25_ps_ui_offset_y += kray25_ps_ui_row_offset + 4;
    kray25_PhySky_c_sep123 = ctlsep(0, kray25_ps_ui_seperator_w + 4);
    ctlposition(kray25_PhySky_c_sep123, -2, kray25_ps_ui_offset_y);
    kray25_ps_ui_offset_y += kray25_ps_ui_spacing + 5;

    kray25_PhySky_c_day = ctlminislider("Day", kray25_PhySky_v_day, 1, 31);
    ctlposition(kray25_PhySky_c_day, kray25_ps_gad_x, kray25_ps_ui_offset_y, kray25_ps_gad_w - kray25_ps_slider_w, kray25_ps_gad_h, kray25_ps_gad_text_offset);

    kray25_PhySky_c_date_now = ctlbutton("Get Current Date",1,"scnGen_kray25_physky_get_date");
    ctlposition(kray25_PhySky_c_date_now, kray25_ps_gad_x + kray25_ps_gad_w + 117, kray25_ps_ui_offset_y, kray25_ps_gad_w - kray25_ps_gad_text_offset, kray25_ps_gad_h);

    kray25_ps_ui_offset_y += kray25_ps_ui_row_offset;

    kray25_PhySky_c_month=ctlpopup("Month", kray25_PhySky_v_month, kray25_PhySky_months_list);
    ctlposition(kray25_PhySky_c_month, kray25_ps_gad_x, kray25_ps_ui_offset_y, kray25_ps_gad_w, kray25_ps_gad_h, kray25_ps_gad_text_offset);

    kray25_ps_ui_offset_y += kray25_ps_ui_row_offset;

    kray25_PhySky_c_year = ctlinteger("Year",kray25_PhySky_v_year);
    ctlposition(kray25_PhySky_c_year, kray25_ps_gad_x, kray25_ps_ui_offset_y, kray25_ps_gad_w, kray25_ps_gad_h, kray25_ps_gad_text_offset);

    kray25_ps_ui_offset_y += kray25_ps_ui_row_offset + 4;
    kray25_PhySky_c_sep2 = ctlsep(0, kray25_ps_ui_seperator_w + 4);
    ctlposition(kray25_PhySky_c_sep2, -2, kray25_ps_ui_offset_y);
    kray25_ps_ui_offset_y += kray25_ps_ui_spacing + 5;

    kray25_PhySky_c_longitude = ctlnumber("Longitude (E)",kray25_PhySky_v_longitude);
    ctlposition(kray25_PhySky_c_longitude, kray25_ps_gad_x, kray25_ps_ui_offset_y, kray25_ps_gad_w, kray25_ps_gad_h, kray25_ps_gad_text_offset);
    ctlrefresh(kray25_PhySky_c_longitude,"scnGen_kray25_physky_longituderefresh");

    kray25_PhySky_c_north = ctlangle("North Offset",kray25_PhySky_v_north);
    ctlposition(kray25_PhySky_c_north, kray25_ps_gad_x + kray25_ps_gad_w + kray25_ps_ui_spacing + kray25_ps_spacer_w, kray25_ps_ui_offset_y, kray25_ps_gad_w - kray25_ps_slider_w, kray25_ps_gad_h, 93);

    kray25_ps_ui_offset_y += kray25_ps_ui_row_offset;

    kray25_PhySky_c_lattitude = ctlnumber("Lattitude (N)",kray25_PhySky_v_lattitude);
    ctlposition(kray25_PhySky_c_lattitude, kray25_ps_gad_x, kray25_ps_ui_offset_y, kray25_ps_gad_w, kray25_ps_gad_h, kray25_ps_gad_text_offset);
    ctlrefresh(kray25_PhySky_c_lattitude,"scnGen_kray25_physky_lattituderefresh");
      
    kray25_PhySky_c_time_zone = ctlinteger("Time Zone",kray25_PhySky_v_time_zone);
    //kray25_PhySky_c_time_zone = ctlminislider("Time Zone", kray25_PhySky_v_time_zone, -12, 12);
    ctlposition(kray25_PhySky_c_time_zone, kray25_ps_gad_x + kray25_ps_gad_w + kray25_ps_ui_spacing + kray25_ps_spacer_w, kray25_ps_ui_offset_y, kray25_ps_gad_w, kray25_ps_gad_h, 93);

    kray25_ps_ui_offset_y += kray25_ps_ui_row_offset + 4;
    kray25_PhySky_c_sep3 = ctlsep(0, kray25_ps_ui_seperator_w + 4);
    ctlposition(kray25_PhySky_c_sep3, -2, kray25_ps_ui_offset_y);
    kray25_ps_ui_offset_y += kray25_ps_ui_spacing + 5;

    kray25_PhySky_c_turbidity = ctlnumber("Turbidity",kray25_PhySky_v_turbidity);
    ctlposition(kray25_PhySky_c_turbidity, kray25_ps_gad_x, kray25_ps_ui_offset_y, kray25_ps_gad_w, kray25_ps_gad_h, kray25_ps_gad_text_offset);

    kray25_PhySky_c_exposure = ctlnumber("Exposure",kray25_PhySky_v_exposure);
    ctlposition(kray25_PhySky_c_exposure, kray25_ps_gad_x + kray25_ps_gad_w + kray25_ps_ui_spacing + kray25_ps_spacer_w, kray25_ps_ui_offset_y, kray25_ps_gad_w, kray25_ps_gad_h, 93);

    kray25_ps_ui_offset_y += kray25_ps_ui_row_offset + 4;
    kray25_PhySky_c_sep4 = ctlsep(0, kray25_ps_ui_seperator_w + 4);
    ctlposition(kray25_PhySky_c_sep4, -2, kray25_ps_ui_offset_y);
    kray25_ps_ui_offset_y += kray25_ps_ui_spacing + 5;

    kray25_PhySky_c_volumetric = ctlpopup("Volumetrics:",kray25_PhySky_v_volumetric,@"Off","Affect Only Background","Affect Shadows","Affect All"@);
    ctlposition(kray25_PhySky_c_volumetric, kray25_ps_gad_x, kray25_ps_ui_offset_y, kray25_ps_ui_window_w - 16, kray25_ps_gad_h, kray25_ps_gad_text_offset);

    kray25_ps_ui_offset_y += kray25_ps_ui_row_offset;

    kray25_PhySky_c_ignore = ctlpopup("Ignore Light",kray25_PhySky_v_ignore_index,passLightNameArray);
    ctlposition(kray25_PhySky_c_ignore, kray25_ps_gad_x, kray25_ps_ui_offset_y, kray25_ps_ui_window_w - 16, kray25_ps_gad_h, kray25_ps_gad_text_offset);

    kray25_ps_ui_offset_y += kray25_ps_ui_row_offset;

    kray25_PhySky_c_skyON = ctlcheckbox("Ignore LightWave Backdrop",kray25_PhySky_skyON);
    ctlposition(kray25_PhySky_c_skyON, kray25_ps_gad_x, kray25_ps_ui_offset_y, kray25_ps_ui_window_w - 16, kray25_ps_gad_h, kray25_ps_gad_text_offset);

    kray25_ps_ui_offset_y += kray25_ps_ui_row_offset;

    kray25_PhySky_c_sunON = ctlcheckbox("Use Physical Sun",kray25_PhySky_sunON);
    ctlposition(kray25_PhySky_c_sunON, kray25_ps_gad_x, kray25_ps_ui_offset_y, kray25_ps_ui_window_w - 16, kray25_ps_gad_h, kray25_ps_gad_text_offset);

    kray25_ps_ui_offset_y += kray25_ps_ui_row_offset;
      
    kray25_PhySky_c_SunIntensity = ctlnumber("Sun Intensity",kray25_PhySky_v_SunIntensity);
    ctlposition(kray25_PhySky_c_SunIntensity, kray25_ps_gad_x, kray25_ps_ui_offset_y, kray25_ps_gad_w, kray25_ps_gad_h, kray25_ps_gad_text_offset);
      
    kray25_PhySky_c_SunShadow = ctlnumber("Sun Softness",kray25_PhySky_v_SunShadow);
    ctlposition(kray25_PhySky_c_SunShadow, kray25_ps_gad_x + kray25_ps_gad_w + kray25_ps_ui_spacing + kray25_ps_spacer_w, kray25_ps_ui_offset_y, kray25_ps_gad_w, kray25_ps_gad_h, 93);
      
    kray25_ps_ui_offset_y += kray25_ps_ui_row_offset;
      
    kray25_PhySky_c_SunPower = ctlnumber("Sun Power Mult.",kray25_PhySky_v_sunpower);
    ctlposition(kray25_PhySky_c_SunPower, kray25_ps_gad_x, kray25_ps_ui_offset_y, kray25_ps_gad_w, kray25_ps_gad_h, kray25_ps_gad_text_offset);
      
    ctlactive(kray25_PhySky_c_onFlag,"scnGen_kray25_is_1",
    kray25_PhySky_c_city_preset,kray25_PhySky_c_hour,kray25_PhySky_c_time_now,kray25_PhySky_c_minute,kray25_PhySky_c_second,kray25_PhySky_c_day,kray25_PhySky_c_date_now,kray25_PhySky_c_month,
    kray25_PhySky_c_year,kray25_PhySky_c_longitude,kray25_PhySky_c_north,kray25_PhySky_c_lattitude,kray25_PhySky_c_time_zone,kray25_PhySky_c_turbidity,kray25_PhySky_c_exposure,kray25_PhySky_c_ignore,
    kray25_PhySky_c_volumetric,kray25_PhySky_c_skyON,kray25_PhySky_c_sunON,kray25_PhySky_c_SunIntensity,kray25_PhySky_c_SunShadow,kray25_PhySky_c_SunPower);

    if(reqpost())
    {
        kray25_PhySky_SettingIndex = 2; // to get past our tag that is fixed in position 1.
        kray25_PhySky_v_onFlag = getvalue(kray25_PhySky_c_onFlag);
        ::kray25_PhySky_settings[kray25_PhySky_SettingIndex] = string(kray25_PhySky_v_onFlag);
        kray25_PhySky_SettingIndex++;
        kray25_PhySky_v_city_preset = getvalue(kray25_PhySky_c_city_preset);
        ::kray25_PhySky_settings[kray25_PhySky_SettingIndex] = string(kray25_PhySky_v_city_preset);
        kray25_PhySky_SettingIndex++;
        kray25_PhySky_v_hour = getvalue(kray25_PhySky_c_hour);
        ::kray25_PhySky_settings[kray25_PhySky_SettingIndex] = string(kray25_PhySky_v_hour);
        kray25_PhySky_SettingIndex++;
        kray25_PhySky_v_minute = getvalue(kray25_PhySky_c_minute);
        ::kray25_PhySky_settings[kray25_PhySky_SettingIndex] = string(kray25_PhySky_v_minute);
        kray25_PhySky_SettingIndex++;
        kray25_PhySky_v_second = getvalue(kray25_PhySky_c_second);
        ::kray25_PhySky_settings[kray25_PhySky_SettingIndex] = string(kray25_PhySky_v_second);
        kray25_PhySky_SettingIndex++;
        kray25_PhySky_v_day = getvalue(kray25_PhySky_c_day);
        ::kray25_PhySky_settings[kray25_PhySky_SettingIndex] = string(kray25_PhySky_v_day);
        kray25_PhySky_SettingIndex++;
        kray25_PhySky_v_month = getvalue(kray25_PhySky_c_month);
        ::kray25_PhySky_settings[kray25_PhySky_SettingIndex] = string(kray25_PhySky_v_month);
        kray25_PhySky_SettingIndex++;
        kray25_PhySky_v_year = getvalue(kray25_PhySky_c_year);
        ::kray25_PhySky_settings[kray25_PhySky_SettingIndex] = string(kray25_PhySky_v_year);
        kray25_PhySky_SettingIndex++;
        kray25_PhySky_v_longitude = getvalue(kray25_PhySky_c_longitude);
        ::kray25_PhySky_settings[kray25_PhySky_SettingIndex] = string(kray25_PhySky_v_longitude);
        kray25_PhySky_SettingIndex++;
        kray25_PhySky_v_north = getvalue(kray25_PhySky_c_north);
        ::kray25_PhySky_settings[kray25_PhySky_SettingIndex] = string(kray25_PhySky_v_north);
        kray25_PhySky_SettingIndex++;
        kray25_PhySky_v_lattitude = getvalue(kray25_PhySky_c_lattitude);
        ::kray25_PhySky_settings[kray25_PhySky_SettingIndex] = string(kray25_PhySky_v_lattitude);
        kray25_PhySky_SettingIndex++;
        kray25_PhySky_v_time_zone = getvalue(kray25_PhySky_c_time_zone);
        ::kray25_PhySky_settings[kray25_PhySky_SettingIndex] = string(kray25_PhySky_v_time_zone);
        kray25_PhySky_SettingIndex++;
        kray25_PhySky_v_turbidity = getvalue(kray25_PhySky_c_turbidity);
        ::kray25_PhySky_settings[kray25_PhySky_SettingIndex] = string(kray25_PhySky_v_turbidity);
        kray25_PhySky_SettingIndex++;
        kray25_PhySky_v_exposure = getvalue(kray25_PhySky_c_exposure);
        ::kray25_PhySky_settings[kray25_PhySky_SettingIndex] = string(kray25_PhySky_v_exposure);
        kray25_PhySky_SettingIndex++;
        kray25_PhySky_v_volumetric = getvalue(kray25_PhySky_c_volumetric);
        ::kray25_PhySky_settings[kray25_PhySky_SettingIndex] = string(kray25_PhySky_v_volumetric);
        kray25_PhySky_SettingIndex++;
        kray25_PhySky_v_ignore = passLightIDArray[getvalue(kray25_PhySky_c_ignore)];
        ::kray25_PhySky_settings[kray25_PhySky_SettingIndex] = string(kray25_PhySky_v_ignore);
        kray25_PhySky_SettingIndex++;
        kray25_PhySky_skyON = getvalue(kray25_PhySky_c_skyON);
        ::kray25_PhySky_settings[kray25_PhySky_SettingIndex] = string(kray25_PhySky_skyON);
        kray25_PhySky_SettingIndex++;
        kray25_PhySky_sunON = getvalue(kray25_PhySky_c_sunON);
        ::kray25_PhySky_settings[kray25_PhySky_SettingIndex] = string(kray25_PhySky_sunON);
        kray25_PhySky_SettingIndex++;
        kray25_PhySky_v_SunIntensity = getvalue(kray25_PhySky_c_SunIntensity);
        ::kray25_PhySky_settings[kray25_PhySky_SettingIndex] = string(kray25_PhySky_v_SunIntensity);
        kray25_PhySky_SettingIndex++;
        kray25_PhySky_v_SunShadow = getvalue(kray25_PhySky_c_SunShadow);
        ::kray25_PhySky_settings[kray25_PhySky_SettingIndex] = string(kray25_PhySky_v_SunShadow);
        kray25_PhySky_SettingIndex++;
        kray25_PhySky_v_sunpower = getvalue(kray25_PhySky_c_SunPower);
        ::kray25_PhySky_settings[kray25_PhySky_SettingIndex] = string(kray25_PhySky_v_sunpower);
    }
}
