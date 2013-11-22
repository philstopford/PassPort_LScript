scnmasterOverride_UI_kray25_ToneMap
{
    // User Interface Layout Variables
    kray25_ToneMap_gad_x               = 10;                               // Gadget X coord
    kray25_ToneMap_gad_y               = 24;                               // Gadget Y coord
    kray25_ToneMap_gad_w               = 188;                              // Gadget width
    kray25_ToneMap_gad_h               = 19;                               // Gadget height
    kray25_ToneMap_gad_text_offset     = 82;                               // Gadget text offset
    kray25_ToneMap_gad_prev_w          = 0;                                // Previous gadget width temp variable

    kray25_ToneMap_num_gads            = 14;                                // Total number of gadgets vertically (for calculating the max window height)

    kray25_ToneMap_ui_banner_height    = 0;
    kray25_ToneMap_ui_spacing          = 3;                                // Spacing gap size

    kray25_ToneMap_ui_offset_x         = 0;                                // Main X offset from 0
    kray25_ToneMap_ui_offset_y         = kray25_ToneMap_ui_banner_height+(kray25_ToneMap_ui_spacing*2);  // Main Y offset from 0
    kray25_ToneMap_ui_row              = 0;                                // Row number
    kray25_ToneMap_ui_column           = 0;                                // Column number
    kray25_ToneMap_ui_tab_offset       = kray25_ToneMap_ui_offset_y + 23;                 // Offset for tab height
    kray25_ToneMap_ui_row_offset       = kray25_ToneMap_gad_h + kray25_ToneMap_ui_spacing;               // Row offset

    kray25_ToneMap_ui_window_w         = 292;                              // Window width
    kray25_ToneMap_ui_window_h         = kray25_ToneMap_ui_banner_height + kray25_ToneMap_ui_row_offset*(kray25_ToneMap_num_gads); // Window height
    kray25_ToneMap_ui_seperator_w      = kray25_ToneMap_ui_window_w + 2;                  // Width of seperators

    // We have our own settings array. This has been setup/populated by the main Kray routine.

    kray25_ToneMap_SettingIndex = 2; // Increment to get past our tag.

    kray25_ToneMap_v_1st_tmo = int(::kray25_ToneMap_settings[kray25_ToneMap_SettingIndex]);
    kray25_ToneMap_SettingIndex++;

    kray25_ToneMap_v_1st_tmhsv = int(::kray25_ToneMap_settings[kray25_ToneMap_SettingIndex]);
    kray25_ToneMap_SettingIndex++;

    kray25_ToneMap_v_1st_outparam = number(::kray25_ToneMap_settings[kray25_ToneMap_SettingIndex]);
    kray25_ToneMap_SettingIndex++;

    kray25_ToneMap_v_1st_outexp = number(::kray25_ToneMap_settings[kray25_ToneMap_SettingIndex]);
    kray25_ToneMap_SettingIndex++;

    kray25_ToneMap_v_2nd_tmo = int(::kray25_ToneMap_settings[kray25_ToneMap_SettingIndex]);
    kray25_ToneMap_SettingIndex++;

    kray25_ToneMap_v_2nd_tmhsv = int(::kray25_ToneMap_settings[kray25_ToneMap_SettingIndex]);
    kray25_ToneMap_SettingIndex++;

    kray25_ToneMap_v_2nd_outparam = number(::kray25_ToneMap_settings[kray25_ToneMap_SettingIndex]);
    kray25_ToneMap_SettingIndex++;

    kray25_ToneMap_v_2nd_outexp = number(::kray25_ToneMap_settings[kray25_ToneMap_SettingIndex]);
    kray25_ToneMap_SettingIndex++;

    kray25_ToneMap_blending = number(::kray25_ToneMap_settings[kray25_ToneMap_SettingIndex]);
    kray25_ToneMap_SettingIndex++;

    kray25_ToneMap_v_onFlag = int(::kray25_ToneMap_settings[kray25_ToneMap_SettingIndex]);
    kray25_ToneMap_SettingIndex++;

    ::doKeys = 0;

    reqbeginstr = "New Override - Kray 2.5 ToneMap";
    if(action == "edit")
    {
        reqbeginstr = "Edit Override - Kray 2.5 ToneMap";
    }
    reqbegin(reqbeginstr);
    reqsize(kray25_ToneMap_ui_window_w, kray25_ToneMap_ui_window_h);

    // Turn off plugin      
    kray25_ToneMap_c_onFlag = ctlcheckbox("Enable Plugin",kray25_ToneMap_v_onFlag);
    ctlposition(kray25_ToneMap_c_onFlag, kray25_ToneMap_gad_x, kray25_ToneMap_ui_offset_y, kray25_ToneMap_gad_w + kray25_ToneMap_gad_text_offset, kray25_ToneMap_gad_h, kray25_ToneMap_gad_text_offset);

    kray25_ToneMap_ui_offset_y += kray25_ToneMap_ui_row_offset;

    kray25_ToneMap_c_1st_tmo = ctlpopup("1st Tonemap",kray25_ToneMap_v_1st_tmo,@"Linear","Gamma","Exponential"@);
    ctlposition(kray25_ToneMap_c_1st_tmo, kray25_ToneMap_gad_x, kray25_ToneMap_ui_offset_y, kray25_ToneMap_gad_w + kray25_ToneMap_gad_text_offset, kray25_ToneMap_gad_h, kray25_ToneMap_gad_text_offset);

    kray25_ToneMap_ui_offset_y += kray25_ToneMap_ui_row_offset;

    kray25_ToneMap_c_1st_tmhsv = ctlcheckbox("HSV Mode",kray25_ToneMap_v_1st_tmhsv);
    ctlposition(kray25_ToneMap_c_1st_tmhsv, kray25_ToneMap_gad_x, kray25_ToneMap_ui_offset_y, kray25_ToneMap_gad_w + kray25_ToneMap_gad_text_offset, kray25_ToneMap_gad_h, kray25_ToneMap_gad_text_offset);

    kray25_ToneMap_ui_offset_y += kray25_ToneMap_ui_row_offset;

    kray25_ToneMap_c_1st_outparam = ctlnumber("Parameter",kray25_ToneMap_v_1st_outparam);
    ctlposition(kray25_ToneMap_c_1st_outparam, kray25_ToneMap_gad_x, kray25_ToneMap_ui_offset_y, 67 + kray25_ToneMap_gad_text_offset, kray25_ToneMap_gad_h, kray25_ToneMap_gad_text_offset);

    kray25_ToneMap_c_1st_outexp = ctlnumber("Exposure",kray25_ToneMap_v_1st_outexp);
    ctlposition(kray25_ToneMap_c_1st_outexp, kray25_ToneMap_gad_x + 67 + kray25_ToneMap_gad_text_offset + kray25_ToneMap_ui_spacing, kray25_ToneMap_ui_offset_y, 67 + 50, kray25_ToneMap_gad_h, 50);

    ctlactive(kray25_ToneMap_c_1st_tmo,"scnGen_kray25_is_not_1",kray25_ToneMap_c_1st_outexp,kray25_ToneMap_c_1st_tmhsv,kray25_ToneMap_c_1st_outparam);

    kray25_ToneMap_ui_offset_y += kray25_ToneMap_ui_row_offset + 4;
    kray25_ToneMap_c_sep = ctlsep(0, kray25_ToneMap_ui_seperator_w + 4);
    ctlposition(kray25_ToneMap_c_sep, -2, kray25_ToneMap_ui_offset_y);
    kray25_ToneMap_ui_offset_y += kray25_ToneMap_ui_spacing + 5;

    kray25_ToneMap_c_2nd_tmo = ctlpopup("2nd Tonemap",kray25_ToneMap_v_2nd_tmo,@"Linear","Gamma","Exponential"@);
    ctlposition(kray25_ToneMap_c_2nd_tmo, kray25_ToneMap_gad_x, kray25_ToneMap_ui_offset_y, kray25_ToneMap_gad_w + kray25_ToneMap_gad_text_offset, kray25_ToneMap_gad_h, kray25_ToneMap_gad_text_offset);

    kray25_ToneMap_ui_offset_y += kray25_ToneMap_ui_row_offset;

    kray25_ToneMap_c_2nd_tmhsv = ctlcheckbox("HSV Mode",kray25_ToneMap_v_2nd_tmhsv);
    ctlposition(kray25_ToneMap_c_2nd_tmhsv,  kray25_ToneMap_gad_x, kray25_ToneMap_ui_offset_y, kray25_ToneMap_gad_w + kray25_ToneMap_gad_text_offset, kray25_ToneMap_gad_h, kray25_ToneMap_gad_text_offset);

    kray25_ToneMap_ui_offset_y += kray25_ToneMap_ui_row_offset;

    kray25_ToneMap_c_2nd_outparam = ctlnumber("Parameter",kray25_ToneMap_v_2nd_outparam);
    ctlposition(kray25_ToneMap_c_2nd_outparam, kray25_ToneMap_gad_x, kray25_ToneMap_ui_offset_y, 67 + kray25_ToneMap_gad_text_offset, kray25_ToneMap_gad_h, kray25_ToneMap_gad_text_offset);

    kray25_ToneMap_c_2nd_outexp = ctlnumber("Exposure",kray25_ToneMap_v_2nd_outexp);
    ctlposition(kray25_ToneMap_c_2nd_outexp, kray25_ToneMap_gad_x + 67 + kray25_ToneMap_gad_text_offset + kray25_ToneMap_ui_spacing, kray25_ToneMap_ui_offset_y, 67 + 50, kray25_ToneMap_gad_h, 50);

    ctlactive(kray25_ToneMap_c_2nd_tmo,"scnGen_kray25_is_not_1",kray25_ToneMap_c_2nd_outexp,kray25_ToneMap_c_2nd_tmhsv,kray25_ToneMap_c_2nd_outparam);

    kray25_ToneMap_ui_offset_y += kray25_ToneMap_ui_row_offset + 4;
    kray25_ToneMap_c_sep2 = ctlsep(0, kray25_ToneMap_ui_seperator_w + 4);
    ctlposition(kray25_ToneMap_c_sep2, -2, kray25_ToneMap_ui_offset_y);
    kray25_ToneMap_ui_offset_y += kray25_ToneMap_ui_spacing + 5;

    kray25_ToneMap_c_blending = ctlpercent("Blending",kray25_ToneMap_blending);
    ctlposition(kray25_ToneMap_c_blending,   kray25_ToneMap_gad_x, kray25_ToneMap_ui_offset_y, kray25_ToneMap_gad_w + kray25_ToneMap_gad_text_offset - 23, kray25_ToneMap_gad_h, kray25_ToneMap_gad_text_offset);
    ctlrefresh(kray25_ToneMap_c_blending, "scnGen_kray25_ToneMap_limit100");

    ctlactive(kray25_ToneMap_c_onFlag,"scnGen_kray25_is_1",kray25_ToneMap_c_1st_tmo,kray25_ToneMap_c_1st_tmhsv,kray25_ToneMap_c_1st_outparam,
    kray25_ToneMap_c_1st_outexp,kray25_ToneMap_c_2nd_tmo,kray25_ToneMap_c_2nd_tmhsv,kray25_ToneMap_c_2nd_outparam,kray25_ToneMap_c_2nd_outexp,kray25_ToneMap_c_blending);

    if(reqpost())
    {
        kray25_ToneMap_SettingIndex = 2; // to get past our tag that is fixed in position 1.
        kray25_ToneMap_v_1st_tmo = getvalue(kray25_ToneMap_c_1st_tmo);
        ::kray25_ToneMap_settings[kray25_ToneMap_SettingIndex] = string(kray25_ToneMap_v_1st_tmo);
        kray25_ToneMap_SettingIndex++;

        kray25_ToneMap_v_1st_tmhsv = getvalue(kray25_ToneMap_c_1st_tmhsv);
        ::kray25_ToneMap_settings[kray25_ToneMap_SettingIndex] = string(kray25_ToneMap_v_1st_tmhsv);
        kray25_ToneMap_SettingIndex++;

        kray25_ToneMap_v_1st_outparam = getvalue(kray25_ToneMap_c_1st_outparam);
        ::kray25_ToneMap_settings[kray25_ToneMap_SettingIndex] = string(kray25_ToneMap_v_1st_outparam);
        kray25_ToneMap_SettingIndex++;

        kray25_ToneMap_v_1st_outexp = getvalue(kray25_ToneMap_c_1st_outexp);
        ::kray25_ToneMap_settings[kray25_ToneMap_SettingIndex] = string(kray25_ToneMap_v_1st_outexp);
        kray25_ToneMap_SettingIndex++;

        kray25_ToneMap_v_2nd_tmo = getvalue(kray25_ToneMap_c_2nd_tmo);
        ::kray25_ToneMap_settings[kray25_ToneMap_SettingIndex] = string(kray25_ToneMap_v_2nd_tmo);
        kray25_ToneMap_SettingIndex++;

        kray25_ToneMap_v_2nd_tmhsv = getvalue(kray25_ToneMap_c_2nd_tmhsv);
        ::kray25_ToneMap_settings[kray25_ToneMap_SettingIndex] = string(kray25_ToneMap_v_2nd_tmhsv);
        kray25_ToneMap_SettingIndex++;

        kray25_ToneMap_v_2nd_outparam = getvalue(kray25_ToneMap_c_2nd_outparam);
        ::kray25_ToneMap_settings[kray25_ToneMap_SettingIndex] = string(kray25_ToneMap_v_2nd_outparam);
        kray25_ToneMap_SettingIndex++;

        kray25_ToneMap_v_2nd_outexp = getvalue(kray25_ToneMap_c_2nd_outexp);
        ::kray25_ToneMap_settings[kray25_ToneMap_SettingIndex] = string(kray25_ToneMap_v_2nd_outexp);
        kray25_ToneMap_SettingIndex++;

        kray25_ToneMap_blending = getvalue(kray25_ToneMap_c_blending);
        ::kray25_ToneMap_settings[kray25_ToneMap_SettingIndex] = string(kray25_ToneMap_blending);
        kray25_ToneMap_SettingIndex++;

        kray25_ToneMap_v_onFlag = getvalue(kray25_ToneMap_c_onFlag);
        ::kray25_ToneMap_settings[kray25_ToneMap_SettingIndex] = string(kray25_ToneMap_v_onFlag);
        kray25_ToneMap_SettingIndex++;
    }
}
