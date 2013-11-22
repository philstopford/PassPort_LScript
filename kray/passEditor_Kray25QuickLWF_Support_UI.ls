scnmasterOverride_UI_kray25_QuickLWF
{
    // User Interface Layout Variables
    kray25_QuickLWF_gad_x               = 10;                               // Gadget X coord
    kray25_QuickLWF_gad_y               = 24;                               // Gadget Y coord
    kray25_QuickLWF_gad_w               = 188;                              // Gadget width
    kray25_QuickLWF_gad_h               = 19;                               // Gadget height
    kray25_QuickLWF_gad_text_offset     = 82;                               // Gadget text offset
    kray25_QuickLWF_gad_prev_w          = 0;                                // Previous gadget width temp variable

    kray25_QuickLWF_num_gads            = 14;                                // Total number of gadgets vertically (for calculating the max window height)

    kray25_QuickLWF_ui_banner_height    = 0;
    kray25_QuickLWF_ui_spacing          = 3;                                // Spacing gap size

    kray25_QuickLWF_ui_offset_x         = 0;                                // Main X offset from 0
    kray25_QuickLWF_ui_offset_y         = kray25_QuickLWF_ui_banner_height+(kray25_QuickLWF_ui_spacing*2);  // Main Y offset from 0
    kray25_QuickLWF_ui_row              = 0;                                // Row number
    kray25_QuickLWF_ui_column           = 0;                                // Column number
    kray25_QuickLWF_ui_tab_offset       = kray25_QuickLWF_ui_offset_y + 23;                 // Offset for tab height
    kray25_QuickLWF_ui_row_offset       = kray25_QuickLWF_gad_h + kray25_QuickLWF_ui_spacing;               // Row offset

    kray25_QuickLWF_ui_window_w         = 292;                              // Window width
    kray25_QuickLWF_ui_window_h         = kray25_QuickLWF_ui_banner_height + (kray25_QuickLWF_ui_row_offset*kray25_QuickLWF_num_gads); // Window height
    kray25_QuickLWF_ui_seperator_w      = kray25_QuickLWF_ui_window_w + 2;                  // Width of seperators

    // We have our own settings array. This has been setup/populated by the main Kray routine.

    kray25_QuickLWF_SettingIndex = 2; // Increment to get past our tag.

    kray25_QuickLWF_v_tmo = int(::kray25_QuickLWF_settings[kray25_QuickLWF_SettingIndex]);
    kray25_QuickLWF_SettingIndex++;

    kray25_QuickLWF_v_tmhsv = int(::kray25_QuickLWF_settings[kray25_QuickLWF_SettingIndex]);
    kray25_QuickLWF_SettingIndex++;

    kray25_QuickLWF_v_outparam = number(::kray25_QuickLWF_settings[kray25_QuickLWF_SettingIndex]);
    kray25_QuickLWF_SettingIndex++;

    kray25_QuickLWF_v_outexp = number(::kray25_QuickLWF_settings[kray25_QuickLWF_SettingIndex]);
    kray25_QuickLWF_SettingIndex++;

    kray25_QuickLWF_v_affectbackdrop = int(::kray25_QuickLWF_settings[kray25_QuickLWF_SettingIndex]);
    kray25_QuickLWF_SettingIndex++;

    kray25_QuickLWF_v_affecttextures = int(::kray25_QuickLWF_settings[kray25_QuickLWF_SettingIndex]);
    kray25_QuickLWF_SettingIndex++;

    kray25_QuickLWF_v_affectlights = int(::kray25_QuickLWF_settings[kray25_QuickLWF_SettingIndex]);
    kray25_QuickLWF_SettingIndex++;

    kray25_QuickLWF_v_onFlag = int(::kray25_QuickLWF_settings[kray25_QuickLWF_SettingIndex]);
    kray25_QuickLWF_SettingIndex++;

    ::doKeys = 0;

    reqbeginstr = "New Override - Kray 2.5 QuickLWF";
    if(action == "edit")
    {
        reqbeginstr = "Edit Override - Kray 2.5 QuickLWF";
    }
    reqbegin(reqbeginstr);
    reqsize(kray25_QuickLWF_ui_window_w, kray25_QuickLWF_ui_window_h);

    // Turn off plugin      
    kray25_QuickLWF_c_onFlag = ctlcheckbox("Enable Plugin",kray25_QuickLWF_v_onFlag);
    ctlposition(kray25_QuickLWF_c_onFlag, kray25_QuickLWF_gad_x - 49, kray25_QuickLWF_ui_offset_y, kray25_QuickLWF_gad_w + kray25_QuickLWF_gad_text_offset, kray25_QuickLWF_gad_h, kray25_QuickLWF_gad_text_offset);
    // ctlrefresh(kray25_QuickLWF_c_onFlag,"scnGen_kray25_QuickLWF_toggle_kray_QuickLWF");

    kray25_QuickLWF_ui_offset_y += kray25_QuickLWF_ui_row_offset;

    kray25_QuickLWF_c_tmo = ctlpopup("Tone Map Type",kray25_QuickLWF_v_tmo,@"Linear","Gamma","Exponential"@);
    ctlposition(kray25_QuickLWF_c_tmo, kray25_QuickLWF_gad_x, kray25_QuickLWF_ui_offset_y, kray25_QuickLWF_gad_w + kray25_QuickLWF_gad_text_offset, kray25_QuickLWF_gad_h, kray25_QuickLWF_gad_text_offset);

    kray25_QuickLWF_ui_offset_y += kray25_QuickLWF_ui_row_offset;

    kray25_QuickLWF_c_outparam = ctlnumber("Parameter",kray25_QuickLWF_v_outparam);
    ctlposition(kray25_QuickLWF_c_outparam, kray25_QuickLWF_gad_x, kray25_QuickLWF_ui_offset_y, 67 + kray25_QuickLWF_gad_text_offset, kray25_QuickLWF_gad_h, kray25_QuickLWF_gad_text_offset);

    kray25_QuickLWF_c_outexp = ctlnumber("Exposure",kray25_QuickLWF_v_outexp);
    ctlposition(kray25_QuickLWF_c_outexp, kray25_QuickLWF_gad_x + 67 + kray25_QuickLWF_gad_text_offset + kray25_QuickLWF_ui_spacing, kray25_QuickLWF_ui_offset_y, 67 + 50, kray25_QuickLWF_gad_h, 50);

    kray25_QuickLWF_ui_offset_y += kray25_QuickLWF_ui_row_offset;

    kray25_QuickLWF_c_tmhsv = ctlcheckbox("HSV Mode",kray25_QuickLWF_v_tmhsv);
    ctlposition(kray25_QuickLWF_c_tmhsv, kray25_QuickLWF_gad_x, kray25_QuickLWF_ui_offset_y, kray25_QuickLWF_gad_w + kray25_QuickLWF_gad_text_offset, kray25_QuickLWF_gad_h, kray25_QuickLWF_gad_text_offset);

    kray25_QuickLWF_ui_offset_y += kray25_QuickLWF_ui_row_offset + 5;
    kray25_QuickLWF_c_sep = ctlsep(0, kray25_QuickLWF_ui_seperator_w + (-24));
    ctlposition(kray25_QuickLWF_c_sep, 10, kray25_QuickLWF_ui_offset_y);
    kray25_QuickLWF_ui_offset_y += kray25_QuickLWF_ui_spacing + 5;

    ctlvisible(kray25_QuickLWF_c_tmo,"scnGen_kray25_is_not_1",kray25_QuickLWF_c_outexp,kray25_QuickLWF_c_tmhsv,kray25_QuickLWF_c_outparam);

    kray25_QuickLWF_c_affect_text=ctltext("","Affect:");
    ctlposition(kray25_QuickLWF_c_affect_text, kray25_QuickLWF_gad_x, kray25_QuickLWF_ui_offset_y, kray25_QuickLWF_gad_text_offset, kray25_QuickLWF_gad_h, kray25_QuickLWF_gad_text_offset);
    
    kray25_QuickLWF_c_affectbackdrop = ctlcheckbox("Affect Backdrop",kray25_QuickLWF_v_affectbackdrop);
    ctlposition(kray25_QuickLWF_c_affectbackdrop, kray25_QuickLWF_gad_x, kray25_QuickLWF_ui_offset_y, kray25_QuickLWF_gad_w + kray25_QuickLWF_gad_text_offset, kray25_QuickLWF_gad_h, kray25_QuickLWF_gad_text_offset);

    kray25_QuickLWF_ui_offset_y += kray25_QuickLWF_ui_row_offset;

    kray25_QuickLWF_c_affecttextures = ctlcheckbox("Affect Textures",kray25_QuickLWF_v_affecttextures);
    ctlposition(kray25_QuickLWF_c_affecttextures, kray25_QuickLWF_gad_x, kray25_QuickLWF_ui_offset_y, kray25_QuickLWF_gad_w + kray25_QuickLWF_gad_text_offset, kray25_QuickLWF_gad_h, kray25_QuickLWF_gad_text_offset);

    kray25_QuickLWF_ui_offset_y += kray25_QuickLWF_ui_row_offset;

    kray25_QuickLWF_c_affectlights = ctlcheckbox("Affect Lights",kray25_QuickLWF_v_affectlights);
    ctlposition(kray25_QuickLWF_c_affectlights, kray25_QuickLWF_gad_x, kray25_QuickLWF_ui_offset_y, kray25_QuickLWF_gad_w + kray25_QuickLWF_gad_text_offset, kray25_QuickLWF_gad_h, kray25_QuickLWF_gad_text_offset);
    
    ctlactive(kray25_QuickLWF_c_onFlag,"scnGen_kray25_is_1",kray25_QuickLWF_c_tmo,kray25_QuickLWF_c_outparam,kray25_QuickLWF_c_outexp,kray25_QuickLWF_c_tmhsv,kray25_QuickLWF_c_affect_text,kray25_QuickLWF_c_affectbackdrop,kray25_QuickLWF_c_affecttextures,kray25_QuickLWF_c_affectlights);

    if(reqpost())
    {
        kray25_QuickLWF_SettingIndex = 2; // to get past our tag that is fixed in position 1.
        kray25_QuickLWF_v_tmo = getvalue(kray25_QuickLWF_c_tmo);
        ::kray25_QuickLWF_settings[kray25_QuickLWF_SettingIndex] = string(kray25_QuickLWF_v_tmo);
        kray25_QuickLWF_SettingIndex++;

        kray25_QuickLWF_v_tmhsv = getvalue(kray25_QuickLWF_c_tmhsv);
        ::kray25_QuickLWF_settings[kray25_QuickLWF_SettingIndex] = string(kray25_QuickLWF_v_tmhsv);
        kray25_QuickLWF_SettingIndex++;

        kray25_QuickLWF_v_outparam = getvalue(kray25_QuickLWF_c_outparam);
        ::kray25_QuickLWF_settings[kray25_QuickLWF_SettingIndex] = string(kray25_QuickLWF_v_outparam);
        kray25_QuickLWF_SettingIndex++;

        kray25_QuickLWF_v_outexp = getvalue(kray25_QuickLWF_c_outexp);
        ::kray25_QuickLWF_settings[kray25_QuickLWF_SettingIndex] = string(kray25_QuickLWF_v_outexp);
        kray25_QuickLWF_SettingIndex++;

        kray25_QuickLWF_v_affectbackdrop = getvalue(kray25_QuickLWF_c_affectbackdrop);
        ::kray25_QuickLWF_settings[kray25_QuickLWF_SettingIndex] = string(kray25_QuickLWF_v_affectbackdrop);
        kray25_QuickLWF_SettingIndex++;

        kray25_QuickLWF_v_affecttextures = getvalue(kray25_QuickLWF_c_affecttextures);
        ::kray25_QuickLWF_settings[kray25_QuickLWF_SettingIndex] = string(kray25_QuickLWF_v_affecttextures);
        kray25_QuickLWF_SettingIndex++;

        kray25_QuickLWF_v_affectlights = getvalue(kray25_QuickLWF_c_affectlights);
        ::kray25_QuickLWF_settings[kray25_QuickLWF_SettingIndex] = string(kray25_QuickLWF_v_affectlights);
        kray25_QuickLWF_SettingIndex++;

        kray25_QuickLWF_v_onFlag = getvalue(kray25_QuickLWF_c_onFlag);
        ::kray25_QuickLWF_settings[kray25_QuickLWF_SettingIndex] = string(kray25_QuickLWF_v_onFlag);
        kray25_QuickLWF_SettingIndex++;
    }
}
