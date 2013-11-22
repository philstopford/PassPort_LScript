debug_kray
{
	logger("info","Size is : " + size(::kray25_PhySky_settings).asStr());
}

scnmasterOverride_UI_kray25: action
{
	// Kray UI variables, taken directly from Kray.ls and renamed to avoid conflicts.
	kray25_modal              = 0;
	kray25_gad_x              = 0;                                             // Gadget X coord
	kray25_gad_y              = 24;                                            // Gadget Y coord
	kray25_gad_w              = 260;                                           // Gadget width
	kray25_gad_h              = 19;                                            // Gadget height
	kray25_gad_text_offset    = 100;                                           // Gadget text offset
	kray25_gad_prekray25_v_w         = 0;                                             // Previous gadget width temp variable
	kray25_ui_window_w        = 440;                                           // Window width
	kray25_ui_banner_height   = 0;
	kray25_ui_window_h        = 467 + kray25_modal * 40;                       // Window height
	kray25_ui_spacing         = 3;                                             // Spacing gap size
	kray25_ui_sep_spacing     = 13;                                            // Spacing for the seperators (with text labels)
	kray25_ui_offset_x        = 0;                                             // Main X offset from 0
	// kray25_ui_offset_y     = kray25_ui_banner_height+(kray25_ui_spacing*2); // Main Y offset from 0
	kray25_ui_row_offset      = kray25_gad_h + kray25_ui_spacing;              // Row offset
	kray25_ui_offset_y        = kray25_ui_row_offset + kray25_ui_spacing;
	kray25_ui_row             = 0;                                             // Row number
	kray25_ui_column          = 0;                                             // Column number
	kray25_ui_tab_offset      = kray25_ui_offset_y + 23;                       // Offset for tab height
	kray25_ui_seperator_w     = kray25_ui_window_w + 2;                        // Width of seperators
	kray25_ui_tab_bottom      = kray25_ui_offset_y + kray25_ui_row_offset + kray25_ui_spacing + kray25_gad_h; // The bottom of the tab gadgets

	kray25_gad_x2             = (kray25_ui_window_w / 2) + kray25_gad_x;        // Gadget X coord2

	// sel only used in edit action.
	// action should be either 'new' or 'edit'
	if (action == "new" || action == "edit")
	{
		if(action == "edit")
		{
			sel = getvalue(gad_OverridesListview).asInt();
			::settingsArray = parseOverrideSettings(::overrideSettings[sel]);
			::overrideRenderer  = integer(::settingsArray[3]);
			settingIndex = 3;
			settingIndex++;
			kray25_v_gph_preset = int(::settingsArray[settingIndex]);
			settingIndex++;
			kray25_v_cph_preset = int(::settingsArray[settingIndex]);
			settingIndex++;
			kray25_v_fg_preset = int(::settingsArray[settingIndex]);
			settingIndex++;
			kray25_v_aa_preset = int(::settingsArray[settingIndex]);
			settingIndex++;
			kray25_v_quality_preset = int(::settingsArray[settingIndex]);

			//104 settings block
			settingIndex++;
			kray25_v_gi = int(::settingsArray[settingIndex]);
			settingIndex++;
			kray25_v_gicaustics = int(::settingsArray[settingIndex]);
			settingIndex++;
			kray25_v_giirrgrad = int(::settingsArray[settingIndex]);
			settingIndex++;
			kray25_v_gipmmode = int(::settingsArray[settingIndex]);

			//2301 settings block
			settingIndex++;
			kray25_v_girtdirect = int(::settingsArray[settingIndex]);

			//201 settings block
			settingIndex++;
			kray25_v_lg = int(::settingsArray[settingIndex]);

			//301 settings block
			settingIndex++;
			kray25_v_pl = int(::settingsArray[settingIndex]);

			//3501 - we don't handle that right now.

			//602 settings block
			settingIndex++;
			kray25_v_prep = number(::settingsArray[settingIndex]);
			settingIndex++;
			kray25_v_pxlordr = int(::settingsArray[settingIndex]);

			//702 settings block
			settingIndex++;
			kray25_v_underf = int(::settingsArray[settingIndex]);
			settingIndex++;
			kray25_v_undert = number(::settingsArray[settingIndex]);

			//802 settings block
			settingIndex++;
			kray25_v_areavis = int(::settingsArray[settingIndex]);
			settingIndex++;
			kray25_v_areaside = int(::settingsArray[settingIndex]);

			//1003 settings block
			settingIndex++;
			kray25_v_planth = number(::settingsArray[settingIndex]);
			settingIndex++;
			kray25_v_planrmin = int(::settingsArray[settingIndex]);
			settingIndex++;
			kray25_v_planrmax = int(::settingsArray[settingIndex]);

			//2103 settings block
			settingIndex++;
			kray25_v_llinth = number(::settingsArray[settingIndex]);
			settingIndex++;
			kray25_v_llinrmin = int(::settingsArray[settingIndex]);
			settingIndex++;
			kray25_v_llinrmax = int(::settingsArray[settingIndex]);

			//1103 settings block
			settingIndex++;
			kray25_v_lumith = number(::settingsArray[settingIndex]);
			settingIndex++;
			kray25_v_lumirmin = int(::settingsArray[settingIndex]);
			settingIndex++;
			kray25_v_lumirmax = int(::settingsArray[settingIndex]);

			//2402 settings block
			settingIndex++;
			kray25_v_camobject = string(::settingsArray[settingIndex]);
			if(kray25_v_camobject == "__PPRN__BLANK__ENTRY__")
			{
				kray25_v_camobject = "";
			}
			settingIndex++;
			kray25_v_camuvname = string(::settingsArray[settingIndex]);
			if(kray25_v_camuvname == "__PPRN__BLANK__ENTRY__")
			{
				kray25_v_camuvname = "";
			}

			//1301 settings block
			settingIndex++;
			kray25_v_cptype = int(::settingsArray[settingIndex]);

			//1401 settings block
			settingIndex++;
			kray25_v_lenspict = string(::settingsArray[settingIndex]);
			if(kray25_v_lenspict == "__PPRN__BLANK__ENTRY__")
			{
				kray25_v_lenspict = "";
			}

			//1501 settings block
			settingIndex++;
			kray25_v_dofobj = string(::settingsArray[settingIndex]);
			if(kray25_v_dofobj == "__PPRN__BLANK__ENTRY__")
			{
				kray25_v_lenspict = "";
			}

			//1603 settings block
			settingIndex++;
			kray25_v_cstocvar = number(::settingsArray[settingIndex]);
			settingIndex++;
			kray25_v_cstocmin = int(::settingsArray[settingIndex]);
			settingIndex++;
			kray25_v_cstocmax = int(::settingsArray[settingIndex]);

			//1804 settings block
			settingIndex++;
			kray25_v_aatype = int(::settingsArray[settingIndex]);
			settingIndex++;
			kray25_v_aafscreen = int(::settingsArray[settingIndex]);
			settingIndex++;
			kray25_v_aargsmpl = int(::settingsArray[settingIndex]);
			settingIndex++;
			kray25_v_aagridrotate = int(::settingsArray[settingIndex]);

			//1903 settings block
			settingIndex++;
			kray25_v_refth = number(::settingsArray[settingIndex]);
			settingIndex++;
			kray25_v_refrmin = int(::settingsArray[settingIndex]);
			settingIndex++;
			kray25_v_refrmax = int(::settingsArray[settingIndex]);

			//2101 settings block
			settingIndex++;
			kray25_v_autolumi = number(::settingsArray[settingIndex]);

			//2601 settings block
			settingIndex++;
			kray25_v_conetoarea = int(::settingsArray[settingIndex]);

			//2707 settings block
			settingIndex++;
			kray25_v_edgeabs = number(::settingsArray[settingIndex]);
			settingIndex++;
			kray25_v_edgerel = number(::settingsArray[settingIndex]);
			settingIndex++;
			kray25_v_edgenorm = number(::settingsArray[settingIndex]);
			settingIndex++;
			kray25_v_edgezbuf = number(::settingsArray[settingIndex]);
			settingIndex++;
			kray25_v_edgeup = int(::settingsArray[settingIndex]);
			settingIndex++;
			kray25_v_edgethick = int(::settingsArray[settingIndex]);
			settingIndex++;
			kray25_v_edgeover = number(::settingsArray[settingIndex]);

			//2802 settings block
			settingIndex++;
			kray25_v_pxlfltr = int(::settingsArray[settingIndex]);
			settingIndex++;
			kray25_v_pxlparam = number(::settingsArray[settingIndex]);

			//2901 settings block
			settingIndex++;
			kray25_v_refacth = number(::settingsArray[settingIndex]);

			//3004 settings block
			settingIndex++;
			kray25_v_tmo = int(::settingsArray[settingIndex]);
			settingIndex++;
			kray25_v_tmhsv = int(::settingsArray[settingIndex]);
			settingIndex++;
			kray25_v_outparam = number(::settingsArray[settingIndex]);
			settingIndex++;
			kray25_v_outexp = number(::settingsArray[settingIndex]);

			//3101 settings block
			settingIndex++;
			kray25_v_aarandsmpl = int(::settingsArray[settingIndex]);

			//3207 settings block
			settingIndex++;
			kray25_v_shgi = int(::settingsArray[settingIndex]);
			settingIndex++;
			kray25_v_ginew = int(::settingsArray[settingIndex]);
			settingIndex++;
			kray25_v_tiphotons = int(::settingsArray[settingIndex]);
			settingIndex++;
			kray25_v_tifg = int(::settingsArray[settingIndex]);
			settingIndex++;
			kray25_v_tiframes = int(::settingsArray[settingIndex]);
			settingIndex++;
			kray25_v_tiextinction = number(::settingsArray[settingIndex]);

			//3701 settings block
			settingIndex++;
			kray25_v_cmbsubframes = int(::settingsArray[settingIndex]);

			//3801 settings block
			settingIndex++;
			kray25_v_refmodel = int(::settingsArray[settingIndex]);

			//4001 settings block
			settingIndex++;
			kray25_v_octdepth = int(::settingsArray[settingIndex]);

			//4101 settings block
			settingIndex++;
			kray25_v_output_On = int(::settingsArray[settingIndex]);

			//4101 settings block
			settingIndex++;
			kray25_v_errode = int(::settingsArray[settingIndex]);

			//4303 settings block
			settingIndex++;
			kray25_v_eyesep = number(::settingsArray[settingIndex]);
			settingIndex++;
			kray25_v_stereoimages = int(::settingsArray[settingIndex]);
			settingIndex++;
			kray25_v_render0 = int(::settingsArray[settingIndex]);

			//4411 settings block
			settingIndex++;
			kray25_v_LogOn      = int(::settingsArray[settingIndex]);
			settingIndex++;
			kray25_v_Debug      = int(::settingsArray[settingIndex]);
			settingIndex++;
			kray25_v_InfoOn        = int(::settingsArray[settingIndex]);
			settingIndex++;
			kray25_v_IncludeOn  = int(::settingsArray[settingIndex]);
			settingIndex++;
			kray25_v_FullPrev    = int(::settingsArray[settingIndex]);
			settingIndex++;
			kray25_v_Finishclose   = int(::settingsArray[settingIndex]);
			settingIndex++;
			kray25_v_UBRAGI        = int(::settingsArray[settingIndex]);
			settingIndex++;
			kray25_v_outputtolw    = int(::settingsArray[settingIndex]);

			//3901 settings block
			settingIndex++;
			create_flag  = int(::settingsArray[settingIndex]);

			//4301 settings block
			settingIndex++;
			kray25_v_outfmt        = int(::settingsArray[settingIndex]);

			//100601
			settingIndex++;
			kray25_v_girauto      = int(::settingsArray[settingIndex]);

			//100001 settings block
			settingIndex++;
			kray25_v_gir          = number(::settingsArray[settingIndex]); // distance value.

			//100105 settings block
			settingIndex++;
			kray25_v_cf            = int(::settingsArray[settingIndex]);
			settingIndex++;
			kray25_v_cn            = int(::settingsArray[settingIndex]);
			settingIndex++;
			kray25_v_cpstart      = number(::settingsArray[settingIndex]);
			settingIndex++;
			kray25_v_cpstop        = number(::settingsArray[settingIndex]);
			settingIndex++;
			kray25_v_cpstep        = int(::settingsArray[settingIndex]);

			//100704 settings block
			settingIndex++;
			kray25_v_cmatic        = int(::settingsArray[settingIndex]);
			settingIndex++;
			kray25_v_clow        = number(::settingsArray[settingIndex]);
			settingIndex++;
			kray25_v_chigh      = number(::settingsArray[settingIndex]);
			settingIndex++;
			kray25_v_cdyn        = number(::settingsArray[settingIndex]);

			//100205 settings block
			settingIndex++;
			kray25_v_gf = int(::settingsArray[settingIndex]);
			settingIndex++;
			kray25_v_gn = int(::settingsArray[settingIndex]);
			settingIndex++;
			kray25_v_gpstart = number(::settingsArray[settingIndex]);
			settingIndex++;
			kray25_v_gpstop = number(::settingsArray[settingIndex]);
			settingIndex++;
			kray25_v_gpstep = int(::settingsArray[settingIndex]);

			//100804 settings block
			settingIndex++;
			kray25_v_gmatic = int(::settingsArray[settingIndex]);
			settingIndex++;
			kray25_v_glow = number(::settingsArray[settingIndex]);
			settingIndex++;
			kray25_v_ghigh = number(::settingsArray[settingIndex]);
			settingIndex++;
			kray25_v_gdyn = int(::settingsArray[settingIndex]);

			//100301 settings block
			settingIndex++;
			kray25_v_ppsize = number(::settingsArray[settingIndex]);

			//100405 settings block
			settingIndex++;
			kray25_v_fgmin = number(::settingsArray[settingIndex]);
			settingIndex++;
			kray25_v_fgmax = number(::settingsArray[settingIndex]);
			settingIndex++;
			kray25_v_fgscale = number(::settingsArray[settingIndex]);
			settingIndex++;
			kray25_v_fgshows = int(::settingsArray[settingIndex]);
			settingIndex++;
			kray25_v_fgsclr_temp = parse(" ", settingsArray[settingIndex]);
			kray25_v_fgsclr = <int(kray25_v_fgsclr_temp[1]),int(kray25_v_fgsclr_temp[2]),int(kray25_v_fgsclr_temp[3])>;

			//100502 settings block
			settingIndex++;
			kray25_v_cornerdist    = number(::settingsArray[settingIndex]);
			settingIndex++;
			kray25_v_cornerpaths = int(::settingsArray[settingIndex]);

			//100901 settings block
			settingIndex++;
			kray25_v_cfunit = int(::settingsArray[settingIndex]);

			//101001 settings block
			settingIndex++;
			kray25_v_gfunit = int(::settingsArray[settingIndex]);

			//101102 settings block
			settingIndex++;
			kray25_v_fgreflections = int(::settingsArray[settingIndex]);
			settingIndex++;
			kray25_v_fgrefractions = int(::settingsArray[settingIndex]);

			//101201 settings block
			settingIndex++;
			kray25_v_gmode = int(::settingsArray[settingIndex]);

			//101301 settings block
			settingIndex++;
			kray25_v_ppcaustics = int(::settingsArray[settingIndex]);

			//101403 settings block
			settingIndex++;
			kray25_v_fgrmin = int(::settingsArray[settingIndex]);
			settingIndex++;
			kray25_v_fgrmax = int(::settingsArray[settingIndex]);
			settingIndex++;
			kray25_v_fgth = number(::settingsArray[settingIndex]);

			//101502 settings block
			settingIndex++;
			kray25_v_fga = number(::settingsArray[settingIndex]);
			settingIndex++;
			kray25_v_fgb = number(::settingsArray[settingIndex]); // FIXME: Angle.

			//101601 settings block
			settingIndex++;
			kray25_v_ppmult = number(::settingsArray[settingIndex]);

			//101701 settings block
			settingIndex++;
			kray25_v_cmult = number(::settingsArray[settingIndex]);

			//101801 settings block
			settingIndex++;
			kray25_v_ppblur = number(::settingsArray[settingIndex]);

			//101901 settings block
			settingIndex++;
			kray25_v_fgblur = number(::settingsArray[settingIndex]);

			//102001 settings block
			settingIndex++;
			kray25_v_showphotons = int(::settingsArray[settingIndex]);

			//102201 settings block
			settingIndex++;
			kray25_v_resetoct = int(::settingsArray[settingIndex]);

			//102301 settings block
			settingIndex++;
			kray25_v_limitdr = int(::settingsArray[settingIndex]);

			//102403 settings block
			settingIndex++;
			kray25_v_prestep = int(::settingsArray[settingIndex]);
			settingIndex++;
			kray25_v_preSplDet = number(::settingsArray[settingIndex]);
			settingIndex++;
			kray25_v_gradNeighbour = number(::settingsArray[settingIndex]);

			settingIndex++;
			activeCameraID = number(::settingsArray[settingIndex]);

			settingIndex++;
			redirectBuffersSetts = int(::settingsArray[settingIndex]);

			// Retrieve plugin setting arrays that we need to append to our main array afterwards.
			// Physical sky settings.
			// ::krayPluginSettingIndexHandler is used to maintain the setting index across the
			// plugin calls. We don't set settingIndex global to limit unintended consequences.
			// We align the settingIndex to our global handler afterwards.
			settingIndex++;
			::krayPluginSettingIndexHandler = settingIndex;
@if Kray_PS
			scnGen_kray25_PhySky_settings();
@end
@if Kray_QuickLWF
			scnGen_kray25_QuickLWF_settings();
@end
@if Kray_ToneMap
			scnGen_kray25_ToneMap_settings();
@end
			settingIndex = ::krayPluginSettingIndexHandler;
		} else {
			// Need to read in settings from the scene configuration? For now, we'll create default values.
			kray25_v_gph_preset = 2;
			kray25_v_cph_preset = 2;
			kray25_v_fg_preset = 2;
			kray25_v_aa_preset = 2;
			kray25_v_quality_preset = 2;

			//104 settings block
			kray25_v_gi = 1;
			kray25_v_gicaustics = 0;
			kray25_v_giirrgrad = 1;
			kray25_v_gipmmode = 3;

			//2301 settings block
			kray25_v_girtdirect = 0;

			//201 settings block
			kray25_v_lg = 1;

			//301 settings block
			kray25_v_pl = 1;

			//3501 - we don't handle that right now.

			//602 settings block
			kray25_v_prep = 1;
			kray25_v_pxlordr = 1;

			//702 settings block
			kray25_v_underf = 1;
			kray25_v_undert = 0.01;

			//802 settings block
			kray25_v_areavis = 2;
			kray25_v_areaside = 0;

			//1003 settings block
			kray25_v_planth = 0.002;
			kray25_v_planrmin = 1;
			kray25_v_planrmax = 4;

			//2103 settings block
			kray25_v_llinth = 0.002;
			kray25_v_llinrmin = 1;
			kray25_v_llinrmax = 4;

			//1103 settings block
			kray25_v_lumith = 0.01;
			kray25_v_lumirmin = 10;
			kray25_v_lumirmax = 60;

			//2402 settings block
			kray25_v_camobject = "";
			kray25_v_camuvname = "";

			//1301 settings block
			kray25_v_cptype = 1;

			//1401 settings block
			kray25_v_lenspict = "";

			//1501 settings block
			kray25_v_dofobj = "";

			//1603 settings block
			kray25_v_cstocvar = 0.0001;
			kray25_v_cstocmin = 10;
			kray25_v_cstocmax = 50;

			//1804 settings block
			kray25_v_aatype = 2;
			kray25_v_aafscreen = 0;
			kray25_v_aargsmpl = 2;
			kray25_v_aagridrotate = 1;

			//1903 settings block
			kray25_v_refth = 0.001;
			kray25_v_refrmin = 100;
			kray25_v_refrmax = 100;

			//2101 settings block
			kray25_v_autolumi = 1;

			//2601 settings block
			kray25_v_conetoarea = 0;

			//2707 settings block
			kray25_v_edgeabs = 0.2;
			kray25_v_edgerel = 0.2;
			kray25_v_edgenorm = 0.1;
			kray25_v_edgezbuf = 0.1;
			kray25_v_edgeup = 0;
			kray25_v_edgethick = 1;
			kray25_v_edgeover = 1;

			//2802 settings block
			kray25_v_pxlfltr = 1;
			kray25_v_pxlparam = 0.7;

			//2901 settings block
			kray25_v_refacth = 0.01;

			//3004 settings block
			kray25_v_tmo = 2;
			kray25_v_tmhsv = 0;
			kray25_v_outparam = 1;
			kray25_v_outexp = 1;

			//3101 settings block
			kray25_v_aarandsmpl = 16;

			//3207 settings block
			kray25_v_shgi = 1;
			kray25_v_ginew = 2;
			kray25_v_tiphotons = 1;
			kray25_v_tifg = 1;
			kray25_v_tiframes = 1;
			kray25_v_tiextinction = 0;

			//3701 settings block
			kray25_v_cmbsubframes = 2;

			//3801 settings block
			kray25_v_refmodel = 0;

			//4001 settings block
			kray25_v_octdepth = 3;

			//4101 settings block
			kray25_v_output_On = 0;

			//4201 settings block
			kray25_v_errode = 4;

			//4303 settings block
			kray25_v_eyesep = 0.01;
			kray25_v_stereoimages = 3;
			kray25_v_render0 = 0;

			//4411 settings block
			kray25_v_LogOn = 0;
			kray25_v_Debug = 0;
			kray25_v_InfoOn = 0;
			kray25_v_IncludeOn = 0;
			kray25_v_FullPrev = 0;
			kray25_v_Finishclose = 0;
			kray25_v_UBRAGI = 0;
			kray25_v_outputtolw = 0;

			//3901 settings block
			create_flag = 0;

			//4301 settings block
			kray25_v_outfmt = 3;

			//100601 settings block
			kray25_v_girauto = 1;

			//100001 settings block
			kray25_v_gir = 1;

			//100105 settings block
			kray25_v_cf = 500000;
			kray25_v_cn = 400;
			kray25_v_cpstart = 0.25;
			kray25_v_cpstop = 1;
			kray25_v_cpstep = 4;

			//100704 settings block
			kray25_v_cmatic = 1;
			kray25_v_clow = 0.1;
			kray25_v_chigh = 0.9;
			kray25_v_cdyn = 10;

			//100205 settings block
			kray25_v_gf = 200000;
			kray25_v_gn = 400;
			kray25_v_gpstart = 1;
			kray25_v_gpstop = 2;
			kray25_v_gpstep = 4;

			//100804 settings block
			kray25_v_gmatic = 1;
			kray25_v_glow = 0.2;
			kray25_v_ghigh = 0.8;
			kray25_v_gdyn = 4;

			//100301 settings block
			kray25_v_ppsize = 0.5;

			//100405 settings block
			kray25_v_fgmin = 0.1;
			kray25_v_fgmax = 30;
			kray25_v_fgscale = 0;
			kray25_v_fgshows = 1;
			kray25_v_fgsclr = <255,0,255>;

			//100502 settings block
			kray25_v_cornerdist = 0.5;
			kray25_v_cornerpaths = 0;

			//100901 settings block
			kray25_v_cfunit = 2;

			//101001 settings block
			kray25_v_gfunit = 2;

			//101102 settings block
			kray25_v_fgreflections = 0;
			kray25_v_fgrefractions = 1;

			//101201 settings block
			kray25_v_gmode = 2;

			//101301 settings block
			kray25_v_ppcaustics = 0;

			//101403 settings block
			kray25_v_fgrmin = 100;
			kray25_v_fgrmax = 600;
			kray25_v_fgth = 0.0001;

			//101502 settings block
			kray25_v_fga = 0.1;
			kray25_v_fgb = 30;

			//101601 settings block
			kray25_v_ppmult = 1;

			//101701 settings block
			kray25_v_cmult = 1;

			//101801 settings block
			kray25_v_ppblur = 1;

			//101901 settings block
			kray25_v_fgblur = 1;

			//102001 settings block
			kray25_v_showphotons = 0;

			//102201 settings block
			kray25_v_resetoct = 0;

			//102301 settings block
			kray25_v_limitdr = 1;

			//102403 settings block
			kray25_v_prestep = 1;
			kray25_v_preSplDet = 0.05;
			kray25_v_gradNeighbour = 0.05;

			create_flag = 1;

			redirectBuffersSetts = 0;

			// Set default settings for plugin arrays that will need to be appended to our settings block later.
			// Physical sky plugin.
@if Kray_PS
			scnGen_kray25_PhySky_defaultsettings();
@end
@if Kray_QuickLWF
			scnGen_kray25_QuickLWF_defaultsettings();
@end
@if Kray_ToneMap
			scnGen_kray25_ToneMap_defaultsettings();
@end
		}

		::doKeys = 0;

		reqbeginstr = "New Scene Master Override - Kray 2.5";
		if(action == "edit")
		{
			reqbeginstr = "Edit Scene Master Override - Kray 2.5";
		}
		reqbegin(reqbeginstr);
		reqsize(kray25_ui_window_w, kray25_ui_window_h + 100);

		newName = "SceneMasterOverride_Kray25";
		if(action == "edit")
		{
			newName = ::settingsArray[1];
		}
		kray25_c20 = ctlstring("Override Name:",newName);
		ctlposition(kray25_c20, kray25_gad_x, kray25_gad_y, kray25_gad_w, kray25_gad_h, kray25_gad_text_offset);

@if Kray_PS
		// DEBUG stuff
		kray25_c20_1	= ctlbutton("Check",0,"debug_kray");
		ctlposition(kray25_c20_1, kray25_gad_x + kray25_gad_w + kray25_ui_spacing, kray25_gad_y, 159, kray25_gad_h, kray25_gad_text_offset);
@end

		kray25_ui_offset_y = kray25_gad_y + kray25_ui_row_offset;
		
		passCamNameArray = nil;
		passCamIDArray = nil;

		passItemsIDsArray = parse("||",::passAssItems[::currentChosenPass]);
		passCamArrayIndex = 1;
		for (i = 1; i <= passItemsIDsArray.size(); i++)
		{
			for (j = 1; j <= ::cameraIDs.size(); j++)
			{
				if(passItemsIDsArray[i] == ::cameraIDs[j])
				{
					passCamIDArray[passCamArrayIndex] = passItemsIDsArray[i];
					// Name look-up
					for(k = 1; k <= ::displayIDs.size(); k++)
					{
						if(::displayIDs[k] == passItemsIDsArray[i])
						{
							nameIndex = k;
						}
					}
					passCamNameArray[passCamArrayIndex] = ::displayNames[nameIndex];
					passCamArrayIndex++;
				}
			}
		}
		if(passCamArrayIndex == 1)
		{
			passCamNameArray = @"No camera found in pass!"@;
		}

		activeCameraID = ::masterScene.renderCamera(0).id;
		if(action == "edit")
		{
			activeCameraID = integer(::settingsArray[size(settingsArray) - 1]);
		}
		activeCamera = 0; // will map to first camera.
		counter = 0;
		for (i = 1; i <= passCamIDArray.size(); i++)
		{
			if(passCamIDArray[i] == activeCameraID)
			{
				activeCamera = counter;
			}
			counter++;
		}
		if(activeCamera != 0)
		{
			activeCamera += 1; // Need to increment by one due to 1-based array and 0-based UI
		}

		kray25_c90 = ctlpopup("Active Camera",activeCamera,passCamNameArray);
		ctlposition(kray25_c90, kray25_gad_x, kray25_ui_offset_y, kray25_gad_w, kray25_gad_h, kray25_gad_text_offset);

		kray25_c90_1 = ctlcheckbox("Redirect Buffer Export Paths",redirectBuffersSetts);
		ctlposition(kray25_c90_1, kray25_gad_x + kray25_gad_w + kray25_ui_spacing, kray25_ui_offset_y, 179, kray25_gad_h,0);

		kray25_ui_offset_y += kray25_ui_row_offset;

		// Render presets popup menu

		kray25_c_general_preset=ctlpopup("Render Preset",1,kray25_general_presets_list);
		ctlposition(kray25_c_general_preset, kray25_gad_x, kray25_ui_offset_y, kray25_gad_w, kray25_gad_h, kray25_gad_text_offset);
		ctlrefresh(kray25_c_general_preset,"scnGen_kray25_general_presets");

		kray25_ui_offset_y += kray25_ui_tab_offset;

		kray25_tab0 = ctltab("General","Photons","Final Gather","Sampling","Quality",
@if Kray_Plugins
		"Plugins",
@end
		"Misc");
		ctlposition(kray25_tab0, kray25_ui_offset_x, kray25_ui_offset_y, 372, kray25_gad_h);

		ctlrefresh(kray25_tab0,"scnGen_kray25_c_tab_refresh");
		reqredraw("scnGen_kray25_req_redraw");

		// Gadgets: General Tab

		kray25_ui_offset_y += kray25_ui_row_offset;
		ref_offset_y = kray25_ui_offset_y;

		// Diffuse model popup menu
		kray25_c_gi=ctlpopup("Diffuse Model",kray25_v_gi,@"Raytrace","Photons Estimate","Photon Mapping","Path Tracing"@);
		ctlposition(kray25_c_gi,kray25_gad_x, kray25_ui_offset_y, kray25_gad_w, kray25_gad_h, kray25_gad_text_offset);

		// Caustics checkbox
		kray25_c_gicaustics = ctlcheckbox("Caustics",kray25_v_gicaustics);
		ctlposition(kray25_c_gicaustics, kray25_gad_x + kray25_gad_w + kray25_ui_spacing, kray25_ui_offset_y, 159, kray25_gad_h,0);

		kray25_ui_offset_y += kray25_ui_row_offset;

		// Cache irradience checkbox
		kray25_c_giirrgrad = ctlcheckbox("Cache Irradiance",kray25_v_giirrgrad);
		ctlposition(kray25_c_giirrgrad, kray25_gad_x + kray25_gad_w + kray25_ui_spacing, kray25_ui_offset_y, 159, kray25_gad_h,0);

		// Raytrace direct checkbox
		kray25_c_girtdirect = ctlcheckbox("Raytrace Direct",kray25_v_girtdirect);
		ctlposition(kray25_c_girtdirect, kray25_gad_x + kray25_gad_w + kray25_ui_spacing, kray25_ui_offset_y, 159, kray25_gad_h,0);

		// Photons estimate checkbox
		kray25_c_gipmmode = ctlpopup("Photons Estimate",kray25_v_gipmmode,@"Global Filtered","Global Unfiltered","Precomputed","Precomputed Filtered"@);
		ctlposition(kray25_c_gipmmode, kray25_gad_x, kray25_ui_offset_y, kray25_gad_w, kray25_gad_h, kray25_gad_text_offset);

		ctlvisible(kray25_c_gi,"scnGen_kray25_c_pmdirectopt",kray25_c_gipmmode);
		ctlvisible(kray25_c_gi,"scnGen_kray25_c_pmcausticsopt",kray25_c_gicaustics);
		ctlvisible(kray25_c_gi,"scnGen_kray25_c_pmirrgradopt",kray25_c_giirrgrad);
		ctlvisible(kray25_c_gi,"scnGen_kray25_c_pmrtdirect",kray25_c_girtdirect);
		ctlrefresh(kray25_c_gipmmode,"scnGen_kray25_c_gi_refresh");
		ctlrefresh(kray25_c_girtdirect,"scnGen_kray25_c_gipmmode_refresh");

		kray25_ui_offset_y += kray25_ui_row_offset;

		// GI mode popup menu
		kray25_c_shgi = ctlpopup("GI Mode",kray25_v_shgi,@"Independent","Time Interpolation","Shared For All Frames"@);
		ctlposition(kray25_c_shgi, kray25_gad_x, kray25_ui_offset_y, kray25_gad_w, kray25_gad_h, kray25_gad_text_offset);

		kray25_ui_offset_y += kray25_ui_row_offset;

		// Time interpolation GI mode

		// Frames numeric entry
		kray25_c_tiframes = ctlinteger("Frame",kray25_v_tiframes);
		ctlposition(kray25_c_tiframes, kray25_gad_x, kray25_ui_offset_y, kray25_gad_w, kray25_gad_h, kray25_gad_text_offset);

		// Precached map checkbox
		kray25_c_tiphotons = ctlcheckbox("Precached Map",kray25_v_tiphotons);
		ctlposition(kray25_c_tiphotons, kray25_gad_x + kray25_gad_w + kray25_ui_spacing, kray25_ui_offset_y, 159, kray25_gad_h,0);

		kray25_ui_offset_y += kray25_ui_row_offset;

		// Extinction percentage entry
		kray25_c_tiextinction = ctlpercent("Extinction",kray25_v_tiextinction);
		ctlposition(kray25_c_tiextinction, kray25_gad_x, kray25_ui_offset_y, kray25_gad_w - 22, kray25_gad_h, kray25_gad_text_offset);

		// Irradiance cache checkbox
		kray25_c_tifg = ctlcheckbox("Irradiance Cache",kray25_v_tifg);
		ctlposition(kray25_c_tifg, kray25_gad_x + kray25_gad_w + kray25_ui_spacing, kray25_ui_offset_y, 159, kray25_gad_h,0);

		ctlrefresh(kray25_c_tifg,"scnGen_kray25_ti_refresh1");
		ctlrefresh(kray25_c_tiphotons,"scnGen_kray25_ti_refresh2");
		ctlvisible(kray25_c_shgi,"scnGen_kray25_is_2",kray25_c_tiphotons,kray25_c_tifg,kray25_c_tiframes,kray25_c_tiextinction);

		// Shared GI Mode

		kray25_ui_offset_y -= kray25_ui_row_offset;
		kray25_ui_offset_y -= kray25_ui_row_offset;

		kray25_c_resetoct = ctlcheckbox("Allow Animation",kray25_v_resetoct);
		ctlposition(kray25_c_resetoct, kray25_gad_x + kray25_gad_w + kray25_ui_spacing, kray25_ui_offset_y, 159, kray25_gad_h,0);

		kray25_ui_offset_y += kray25_ui_row_offset;

		// GI cache filename
		kray25_c_giload = ctlfilename("GI Cache File",kray25_v_giload);
		ctlposition(kray25_c_giload, kray25_gad_x, kray25_ui_offset_y, kray25_gad_w - 23, kray25_gad_h, kray25_gad_text_offset);
		
		// Reset cache file button
		kray25_c_resetGI = ctlbutton("Reset File",1,"scnGen_kray25_resetfile");
		ctlposition(kray25_c_resetGI, kray25_gad_x + kray25_gad_w + kray25_ui_spacing, kray25_ui_offset_y, 159, kray25_gad_h,0);

		kray25_ui_offset_y += kray25_ui_row_offset;

		// Cache file mode
		kray25_c_ginew = ctlchoice("",kray25_v_ginew,@"Load","Save","Update"@);
		ctlposition(kray25_c_ginew, kray25_gad_x, kray25_ui_offset_y, kray25_gad_w, kray25_gad_h, kray25_gad_text_offset);

		// Skip final raytrace step
		kray25_c_render0 = ctlcheckbox("Bake Only",kray25_v_render0);
		ctlposition(kray25_c_render0, kray25_gad_x + kray25_gad_w + kray25_ui_spacing, kray25_ui_offset_y, 159, kray25_gad_h,0);

		ctlvisible(kray25_c_shgi,"scnGen_kray25_is_3",kray25_c_giload,kray25_c_ginew,kray25_c_resetGI,kray25_c_resetoct,kray25_c_render0); // Added

		kray25_ui_offset_y += kray25_ui_row_offset + 4;
		kray25_c_sep3 = ctlsep(0, kray25_ui_seperator_w + 4);
		ctlposition(kray25_c_sep3, -2, kray25_ui_offset_y);
		kray25_ui_offset_y += kray25_ui_spacing + 5;

		// Camera mode popup
		kray25_c_cptype = ctlpopup("Camera Mode",kray25_v_cptype,@"Lightwave","Spherical","Fish Eye","Texture Baker","Stereo"@);
		ctlposition(kray25_c_cptype, kray25_gad_x, kray25_ui_offset_y, kray25_gad_w + 159 + kray25_ui_spacing, kray25_gad_h, kray25_gad_text_offset);

		kray25_ui_offset_y += kray25_ui_row_offset;

		// Pixel order popup
		kray25_c_pxlordr = ctlpopup("Pixel Order",kray25_v_pxlordr,@"Scanline","Scancolumn","Random","Progressive","RenderWorm","Frost"@);
		ctlposition(kray25_c_pxlordr, kray25_gad_x, kray25_ui_offset_y, kray25_gad_w + 159 + kray25_ui_spacing, kray25_gad_h, kray25_gad_text_offset);

		kray25_ui_offset_y += kray25_ui_row_offset;

		/*
		if (kray25_v_lenspict!="")
		{
			found=0;

			imapObj = Image();
			while(imapObj)
			{
				temp = imapObj.filename(0);
				if (temp == kray25_v_lenspict)
				{
					found=1;
					break;
				}
				imapObj = imapObj.next();
			}
		}
		*/

		kray25_ui_offset_y += kray25_ui_row_offset;

		// Iris shape file
		kray25_c_lenspict = ctlfilename("Iris Shape",kray25_v_lenspict,0,1);
		ctlposition(kray25_c_lenspict, kray25_gad_x, kray25_ui_offset_y, kray25_gad_w + 159 + kray25_ui_spacing - 23, kray25_gad_h, kray25_gad_text_offset);
		kray25_ui_offset_y += kray25_ui_row_offset;

	    ::tempArray = parse("||", ::passAssItems[::currentChosenPass]);
		kray25_objnames = prefixArrayWithBlank(getPassItemNamesByType(::tempArray, MESH));
		kray25_meshids = prefixArrayWithBlank(getPassItemIDsByType(::tempArray, MESH));
		::tempArray = getSceneVMaps(VMTEXTURE);
		kray25_vmapnames = prefixArrayWithBlank(::tempArray);
		::tempArray = nil;
		kray25_v_index = kray25_vmapnames.indexOf(kray25_v_camuvname);
		if(kray25_v_index == 0)
		{
			kray25_v_index = 1;
		}
		kray25_v_dof_index = kray25_objnames.indexOf(kray25_v_dofobj);
		if(kray25_v_dof_index == 0)
		{
			kray25_v_dof_index = 1;
		}
		kray25_v_vmapobj_index = kray25_meshids.indexOf(kray25_v_camobject);
		if(kray25_v_vmapobj_index == 0)
		{
			kray25_v_vmapobj_index = 1;
		}

		// CONSTRUCTION SITE.

		// DOF target popup menu
		kray25_c_dofobj = ctlpopup("DOF Target",kray25_v_dof_index,kray25_objnames);
		ctlposition(kray25_c_dofobj, kray25_gad_x, kray25_ui_offset_y, kray25_gad_w + 159 + kray25_ui_spacing - 23, kray25_gad_h, kray25_gad_text_offset);

		/*
		// Refresh DOF target list button (Beta). We can't handle this in PPRN. Disabling. No override impact.
		kray25_c_refresh1 = ctlbutton("R",1,"options");
		ctlposition(kray25_c_refresh1, kray25_gad_x + kray25_gad_w + 159 + kray25_ui_spacing - 23 + 5, kray25_ui_offset_y, 18, kray25_gad_h);
		*/

		kray25_ui_offset_y -= kray25_ui_row_offset;

		// VMap Object popup menu
		kray25_c_camobject = ctlpopup("Object",kray25_v_vmapobj_index,kray25_objnames);
		ctlposition(kray25_c_camobject, kray25_gad_x, kray25_ui_offset_y, kray25_gad_w + 159 + kray25_ui_spacing - 23, kray25_gad_h, kray25_gad_text_offset);

		// Refresh object list button (Beta). We can't handle this in PPRN. Disabling. No override impact.
		// kray25_c_refresh4 = ctlbutton("R",1,"options");
		// ctlposition(kray25_c_refresh4, kray25_gad_x + kray25_gad_w + 159 + kray25_ui_spacing - 23 + 5, kray25_ui_offset_y, 18, kray25_gad_h);

		ctlactive(kray25_c_cptype,"scnGen_kray25_c_dof_on",kray25_c_lenspict,kray25_c_dofobj);

		// STEREO settings
		kray25_c_eyesep = ctlnumber("Eye separation",kray25_v_eyesep);
		ctlposition(kray25_c_eyesep, kray25_gad_x, kray25_ui_offset_y, 63 + kray25_gad_text_offset, kray25_gad_h, kray25_gad_text_offset);
		
		kray25_ui_offset_y += kray25_ui_row_offset;

		kray25_c_camuvname = ctlpopup("UV Map",kray25_v_index,kray25_vmapnames);
		ctlposition(kray25_c_camuvname, kray25_gad_x, kray25_ui_offset_y, kray25_gad_w, kray25_gad_h, kray25_gad_text_offset);

		kray25_c_errode = ctlpopup("Extend border",kray25_v_errode,@"Extend edge 0 px","Extend edge 1 px","Extend edge 2 px","Extend edge 3 px","Extend edge 4 px", "Extend edge 5 px"@);
		ctlposition(kray25_c_errode, kray25_gad_x + kray25_gad_w + kray25_ui_spacing, kray25_ui_offset_y, 159, kray25_gad_h,0);

		// STEREO settings
		kray25_c_stereoimages = ctlinteger("No. of images",kray25_v_stereoimages);
		ctlposition(kray25_c_stereoimages, kray25_gad_x , kray25_ui_offset_y, 63 + kray25_gad_text_offset, kray25_gad_h, kray25_gad_text_offset);        
		
		ctlvisible(kray25_c_cptype,"scnGen_kray25_is_not_5",kray25_c_eyesep,kray25_c_stereoimages); 
		
		ctlvisible(kray25_c_cptype,"scnGen_kray25_is_not_4",kray25_c_camobject, kray25_c_camuvname, kray25_c_errode/*, kray25_c_refresh4*/); //added beta 'R'4 visible state
		// ctlvisible(kray25_c_cptype,"scnGen_kray25_is_1",kray25_c_lenspict, kray25_c_dofobj/*kray25_c_refresh1*/); //added beta 'R'1 visible state

		kray25_ui_offset_y += kray25_ui_row_offset + 4;
		kray25_c_sep4 = ctlsep(0, kray25_ui_seperator_w + 4);
		ctlposition(kray25_c_sep4, -2, kray25_ui_offset_y);
		kray25_ui_offset_y += kray25_ui_spacing + 5;
		
		//Output
		kray25_output_label = ctltext("","Output file");
		ctlposition(kray25_output_label, kray25_gad_x + 45, kray25_ui_offset_y + kray25_ui_spacing, 100, kray25_gad_h, kray25_gad_text_offset);
		
		kray25_c_output_On = ctlcheckbox("On",kray25_v_output_On);
		ctlposition(kray25_c_output_On, kray25_gad_x, kray25_ui_offset_y, 145, kray25_gad_h, kray25_gad_text_offset);

		// Output filename
		kray25_c_outname = ctlfilename("",kray25_v_outname,0,0);
		offout = 145 + kray25_ui_spacing;
		ctlposition(kray25_c_outname, kray25_gad_x + offout, kray25_ui_offset_y, kray25_gad_w + 159 + kray25_ui_spacing - 23 - offout, kray25_gad_h, 0 );

		ctlrefresh(kray25_c_outname,"scnGen_kray25_format_refresh");
		mlsize=size(kray25_v_outname);

		kray25_ui_offset_y += kray25_ui_row_offset;

		// File format type choice
		kray25_c_outfmt = ctlpopup("File Format",kray25_v_outfmt,kray25_image_formats);
		ctlposition(kray25_c_outfmt, kray25_gad_x, kray25_ui_offset_y, kray25_gad_w + 159 + kray25_ui_spacing, kray25_gad_h, kray25_gad_text_offset);

		ctlrefresh(kray25_c_outfmt,"scnGen_kray25_format_refresh");
		ctlactive(kray25_c_outname,"scnGen_kray25_is_name",kray25_c_outfmt);
		ctlactive(kray25_c_output_On,"scnGen_kray25_is_1",kray25_c_outname,kray25_c_outfmt);

		kray25_ui_offset_y += kray25_ui_row_offset;
		kray25_ui_offset_y += kray25_ui_row_offset;

		// Tonemap type
		kray25_c_tmo = ctlpopup("Tonemap",kray25_v_tmo,@"Linear","Gamma","Exponential"@);
		ctlposition(kray25_c_tmo, kray25_gad_x, kray25_ui_offset_y, kray25_gad_w, kray25_gad_h, kray25_gad_text_offset);

		// Limit dynamic range popup menu
		kray25_c_limitdr = ctlpopup("LimitDR",kray25_v_limitdr,@"Limit DR After Tonemap","Limit DR Before Tonemap","Don't Limit DR"@);
		ctlposition(kray25_c_limitdr, kray25_gad_x + kray25_gad_w + kray25_ui_spacing, kray25_ui_offset_y, 159, kray25_gad_h,0);

		kray25_ui_offset_y += kray25_ui_row_offset;

		// Parameter numeric entry
		kray25_c_outparam = ctlnumber("Parameter",kray25_v_outparam);
		ctlposition(kray25_c_outparam, kray25_gad_x , kray25_ui_offset_y, 63 + kray25_gad_text_offset, kray25_gad_h, kray25_gad_text_offset);

		// Exposure numeric entry
		kray25_c_outexp = ctlnumber("Exp",kray25_v_outexp);
		ctlposition(kray25_c_outexp, 63 + kray25_gad_text_offset + 10, kray25_ui_offset_y, 63 + 24, kray25_gad_h, 24);

		// HSV mode checkbox
		kray25_c_tmhsv = ctlcheckbox("HSV Mode",kray25_v_tmhsv);
		ctlposition(kray25_c_tmhsv, kray25_gad_x + kray25_gad_w + kray25_ui_spacing, kray25_ui_offset_y, 159, kray25_gad_h,0);

		ctlvisible(kray25_c_tmo,"scnGen_kray25_is_not_1",kray25_c_outexp,kray25_c_tmhsv,kray25_c_outparam);

		kray25_ui_offset_y += kray25_ui_row_offset + 4;
		kray25_c_sep_last1 = ctlsep(0, kray25_ui_seperator_w + 4);
		ctlposition(kray25_c_sep_last1, -2, kray25_ui_offset_y);
		kray25_ui_offset_y += kray25_ui_spacing + 5;

		ctlpage(1,kray25_c_gi,kray25_c_shgi,kray25_c_outname,kray25_c_outfmt, kray25_output_label, kray25_c_output_On, kray25_c_limitdr, kray25_c_outparam,kray25_c_outexp, kray25_c_sep3,kray25_c_giload,kray25_c_pxlordr,
		 kray25_c_ginew,kray25_c_gicaustics,kray25_c_gipmmode,kray25_c_giirrgrad, kray25_c_girtdirect,kray25_c_tmo,kray25_c_tmhsv,kray25_c_tiphotons,kray25_c_tifg
		 , kray25_c_camobject, kray25_c_lenspict, kray25_c_camuvname, kray25_c_dofobj,kray25_c_resetoct,kray25_c_errode, kray25_c_eyesep, kray25_c_stereoimages, kray25_c_tiframes,kray25_c_tiextinction,kray25_c_cptype,kray25_c_sep4
		 /*, kray25_c_refresh1*//*, kray25_c_refresh4*/,kray25_c_resetGI,kray25_c_render0); //added load/save & refresh

		// Photons tab

		// Reset kray25_ui_offset_y value
		kray25_ui_offset_y = ref_offset_y; // kray25_ui_tab_bottom + (kray25_ui_spacing*2);

		// GI resolution numeric entry
		kray25_c_gir = ctldistance("GI Resolution",kray25_v_gir);
		ctlposition(kray25_c_gir, kray25_gad_x, kray25_ui_offset_y, kray25_gad_w, kray25_gad_h, kray25_gad_text_offset);

		// Auto photons checkbox
		kray25_c_girauto = ctlcheckbox("Auto",kray25_v_girauto);
		ctlposition(kray25_c_girauto, kray25_gad_x + kray25_gad_w + kray25_ui_spacing, kray25_ui_offset_y, 159, kray25_gad_h,0);

		kray25_ui_offset_y += kray25_ui_row_offset + kray25_ui_sep_spacing;

		kray25_c_gph_text=ctltext("","Photons Settings:");
		ctlposition(kray25_c_gph_text, kray25_gad_x + 10, kray25_ui_offset_y - 8, 100,kray25_gad_h, kray25_gad_text_offset);

		kray25_c_sep1 = ctlsep(0, kray25_ui_seperator_w + 4);
		ctlposition(kray25_c_sep1, 100, kray25_ui_offset_y);
		kray25_ui_offset_y += kray25_ui_sep_spacing + 3;

		kray25_c_gph_preset=ctlpopup("Photons Preset",kray25_v_gph_preset,kray25_presets_list2);
		ctlposition(kray25_c_gph_preset, kray25_gad_x, kray25_ui_offset_y, kray25_gad_w, kray25_gad_h, kray25_gad_text_offset);
		ctlrefresh(kray25_c_gph_preset,"scnGen_kray25_photons_presets");

		kray25_c_gmode = ctlchoice("",kray25_v_gmode,@"Photonmap","Lightmap"@);
		ctlposition(kray25_c_gmode, kray25_gad_x + kray25_gad_w + kray25_ui_spacing, kray25_ui_offset_y, 159, kray25_gad_h,0);

		kray25_ui_offset_y += kray25_ui_row_offset;

		kray25_c_gf = ctlinteger("Global Photons",kray25_v_gf);
		ctlposition(kray25_c_gf, kray25_gad_x, kray25_ui_offset_y, kray25_gad_w - 99, kray25_gad_h, kray25_gad_text_offset);

		kray25_c_gfunit = ctlchoice("",kray25_v_gfunit,@"Emit","Receive"@);
		ctlposition(kray25_c_gfunit, kray25_gad_x + kray25_gad_w - 100, kray25_ui_offset_y, 100, kray25_gad_h,0);

		// Show photons checkbox
		kray25_c_showphotons = ctlcheckbox("Preview Photons",kray25_v_showphotons);
		ctlposition(kray25_c_showphotons, kray25_gad_x + kray25_gad_w + kray25_ui_spacing, kray25_ui_offset_y, 159, kray25_gad_h,0);

		kray25_ui_offset_y += kray25_ui_row_offset;

		kray25_c_ppmult = ctlnumber("Power",kray25_v_ppmult);
		ctlposition(kray25_c_ppmult, kray25_gad_x, kray25_ui_offset_y, kray25_gad_w, kray25_gad_h, kray25_gad_text_offset);

		kray25_ui_offset_y += kray25_ui_row_offset;

		kray25_c_gmatic = ctlcheckbox("Use Autophotons",kray25_v_gmatic);
		ctlposition(kray25_c_gmatic, kray25_gad_x + kray25_gad_w + kray25_ui_spacing, kray25_ui_offset_y, 159, kray25_gad_h,0);

		kray25_ui_offset_y += kray25_ui_row_offset;

		kray25_c_gn = ctlinteger("N",kray25_v_gn);
		ctlposition(kray25_c_gn, kray25_gad_x, kray25_ui_offset_y, kray25_gad_w, kray25_gad_h, kray25_gad_text_offset);

		kray25_c_glow = ctlpercent("Low",kray25_v_glow);
		ctlposition(kray25_c_glow, kray25_gad_x + kray25_gad_w , kray25_ui_offset_y, 139, kray25_gad_h, 67);

		kray25_c_gpstart = ctlpercent("Radius",kray25_v_gpstart);
		ctlposition(kray25_c_gpstart, kray25_gad_x + kray25_gad_w , kray25_ui_offset_y, 139, kray25_gad_h, 67);

		kray25_ui_offset_y += kray25_ui_row_offset;

		kray25_c_ppsize = ctlpercent("Precache Distance",kray25_v_ppsize);
		ctlposition(kray25_c_ppsize, kray25_gad_x, kray25_ui_offset_y, kray25_gad_w - 22, kray25_gad_h, kray25_gad_text_offset);

		kray25_c_ghigh = ctlpercent("High",kray25_v_ghigh);
		ctlposition(kray25_c_ghigh, kray25_gad_x + kray25_gad_w , kray25_ui_offset_y, 139, kray25_gad_h, 67);

		kray25_c_gpstop = ctlpercent("Max Radius",kray25_v_gpstop);
		ctlposition(kray25_c_gpstop, kray25_gad_x + kray25_gad_w , kray25_ui_offset_y, 139, kray25_gad_h, 67);

		kray25_ui_offset_y += kray25_ui_row_offset;

		kray25_c_ppblur = ctlpercent("Precache Blur",kray25_v_ppblur);
		ctlposition(kray25_c_ppblur, kray25_gad_x, kray25_ui_offset_y, kray25_gad_w - 22, kray25_gad_h, kray25_gad_text_offset);

		kray25_c_gpstep = ctlinteger("Steps",kray25_v_gpstep);
		ctlposition(kray25_c_gpstep, kray25_gad_x + kray25_gad_w , kray25_ui_offset_y, 161, kray25_gad_h, 67);

		kray25_c_gdyn = ctlnumber("Steps",kray25_v_gdyn);
		ctlposition(kray25_c_gdyn, kray25_gad_x + kray25_gad_w , kray25_ui_offset_y, 161, kray25_gad_h, 67);

		ctlvisible(kray25_c_gmatic,"scnGen_kray25_ft_active",kray25_c_gpstart,kray25_c_gpstop,kray25_c_gpstep);
		ctlvisible(kray25_c_gmatic,"scnGen_kray25_tf_active",kray25_c_glow,kray25_c_ghigh,kray25_c_gdyn);
		ctlrefresh(kray25_c_gmatic,"scnGen_kray25_c_gmaticrefresh");

		ctlactive(kray25_c_gph_preset,"scnGen_kray25_is_1",kray25_c_gmatic,kray25_c_gn,kray25_c_glow,kray25_c_gpstart,kray25_c_ppsize,kray25_c_ghigh,kray25_c_gpstop,kray25_c_ppblur,kray25_c_gpstep,kray25_c_gdyn);

		kray25_ui_offset_y += kray25_ui_row_offset + kray25_ui_sep_spacing;

		kray25_c_cph_text=ctltext("","Caustics Settings:");
		ctlposition(kray25_c_cph_text, kray25_gad_x + 10, kray25_ui_offset_y - 8, 100,kray25_gad_h, kray25_gad_text_offset);

		kray25_c_sep9 = ctlsep(0, kray25_ui_seperator_w + 4);
		ctlposition(kray25_c_sep9, 100, kray25_ui_offset_y);
		kray25_ui_offset_y += kray25_ui_sep_spacing + 3;

		kray25_c_cph_preset=ctlpopup("Caustics Preset",kray25_v_cph_preset,kray25_presets_list);
		ctlposition(kray25_c_cph_preset, kray25_gad_x, kray25_ui_offset_y, kray25_gad_w, kray25_gad_h, kray25_gad_text_offset);

		ctlrefresh(kray25_c_cph_preset,"scnGen_kray25_caustics_presets");

		kray25_c_ppcaustics = ctlcheckbox("Add to Lightmap",kray25_v_ppcaustics);
		ctlposition(kray25_c_ppcaustics, kray25_gad_x + kray25_gad_w + kray25_ui_spacing, kray25_ui_offset_y, 159, kray25_gad_h,0);

		kray25_ui_offset_y += kray25_ui_row_offset;

		kray25_c_cf = ctlinteger("Caustics Photons",kray25_v_cf);
		ctlposition(kray25_c_cf, kray25_gad_x, kray25_ui_offset_y, kray25_gad_w - 99, kray25_gad_h, kray25_gad_text_offset);

		kray25_c_cfunit = ctlchoice("",kray25_v_cfunit,@"Emit","Receive"@);
		ctlposition(kray25_c_cfunit, kray25_gad_x + kray25_gad_w - 100, kray25_ui_offset_y, 100, kray25_gad_h,0);
		
		kray25_c_cmatic = ctlcheckbox("Use Autophotons",kray25_v_cmatic);
		ctlposition(kray25_c_cmatic, kray25_gad_x + kray25_gad_w + kray25_ui_spacing, kray25_ui_offset_y, 159, kray25_gad_h,0);
		
		kray25_ui_offset_y += kray25_ui_row_offset;

		kray25_c_cmult = ctlnumber("Power",kray25_v_cmult);
		ctlposition(kray25_c_cmult, kray25_gad_x, kray25_ui_offset_y, kray25_gad_w, kray25_gad_h, kray25_gad_text_offset);

		kray25_c_clow = ctlpercent("Low",kray25_v_clow);
		ctlposition(kray25_c_clow, kray25_gad_x + kray25_gad_w , kray25_ui_offset_y, 139, kray25_gad_h, 67);

		kray25_c_cpstart = ctlpercent("Radius",kray25_v_cpstart);
		ctlposition(kray25_c_cpstart, kray25_gad_x + kray25_gad_w , kray25_ui_offset_y, 139, kray25_gad_h, 67);

		kray25_ui_offset_y += kray25_ui_row_offset;

		kray25_c_cpstop = ctlpercent("Max radius",kray25_v_cpstop);
		ctlposition(kray25_c_cpstop, kray25_gad_x + kray25_gad_w , kray25_ui_offset_y, 139, kray25_gad_h, 67);

		kray25_c_chigh = ctlpercent("High",kray25_v_chigh);
		ctlposition(kray25_c_chigh, kray25_gad_x + kray25_gad_w , kray25_ui_offset_y, 139, kray25_gad_h, 67);

		kray25_ui_offset_y += kray25_ui_row_offset;

		kray25_c_cn = ctlinteger("N",kray25_v_cn);
		ctlposition(kray25_c_cn, kray25_gad_x, kray25_ui_offset_y, kray25_gad_w, kray25_gad_h, kray25_gad_text_offset);

		kray25_c_cdyn = ctlnumber("Steps",kray25_v_cdyn);
		ctlposition(kray25_c_cdyn, kray25_gad_x + kray25_gad_w , kray25_ui_offset_y, 161, kray25_gad_h, 67);

		kray25_c_cpstep = ctlinteger("Steps",kray25_v_cpstep);
		ctlposition(kray25_c_cpstep, kray25_gad_x + kray25_gad_w , kray25_ui_offset_y, 161, kray25_gad_h, 67);

		kray25_ui_offset_y += kray25_ui_row_offset;

		ctlvisible(kray25_c_cmatic,"scnGen_kray25_ft_active",kray25_c_cpstart,kray25_c_cpstop,kray25_c_cpstep);
		ctlvisible(kray25_c_cmatic,"scnGen_kray25_tf_active",kray25_c_clow,kray25_c_chigh,kray25_c_cdyn);
		ctlrefresh(kray25_c_cmatic,"scnGen_kray25_c_cmaticrefresh");

		ctlactive(kray25_c_cph_preset,"scnGen_kray25_is_1",kray25_c_cmatic,kray25_c_cn,kray25_c_clow,kray25_c_cpstart,kray25_c_cdyn,kray25_c_cpstep,kray25_c_cpstop,kray25_c_chigh);

		ctlpage(2,kray25_c_gir,kray25_c_sep1,kray25_c_sep9,kray25_c_cph_preset,kray25_c_showphotons,kray25_c_cf,kray25_c_cmatic,kray25_c_cpstart,kray25_c_cpstop,kray25_c_cpstep,kray25_c_cn,kray25_c_cfunit,kray25_c_clow,kray25_c_chigh,kray25_c_cdyn,
		kray25_c_gf,kray25_c_gmatic,kray25_c_gpstart,kray25_c_gpstop,kray25_c_gpstep,kray25_c_gn,kray25_c_gmode,kray25_c_gfunit,kray25_c_glow,kray25_c_ghigh,kray25_c_gdyn,kray25_c_ppsize,kray25_c_girauto,kray25_c_ppcaustics,kray25_c_ppmult,kray25_c_cmult,kray25_c_gph_preset,
		kray25_c_ppblur,kray25_c_gph_text,kray25_c_cph_text);

		// Final Gather Tab

		// Reset kray25_ui_offset_y value
		kray25_ui_offset_y = ref_offset_y; // kray25_ui_tab_bottom + (kray25_ui_spacing*2);

		kray25_c_gir_copy = ctldistance("GI Resolution",kray25_v_gir);
		ctlposition(kray25_c_gir_copy, kray25_gad_x, kray25_ui_offset_y, kray25_gad_w, kray25_gad_h, kray25_gad_text_offset);

		ctlrefresh(kray25_c_gir_copy,"scnGen_kray25_c_fgircopy");

		kray25_c_girauto_copy = ctlcheckbox("Auto",kray25_v_girauto);
		ctlposition(kray25_c_girauto_copy, kray25_gad_x + kray25_gad_w + kray25_ui_spacing, kray25_ui_offset_y, 159, kray25_gad_h,0);

		kray25_ui_offset_y += kray25_ui_row_offset + kray25_ui_sep_spacing;

		kray25_c_fg_text=ctltext("","Final Gather Settings:");
		ctlposition(kray25_c_fg_text, kray25_gad_x + 10, kray25_ui_offset_y - 8, 100,kray25_gad_h, kray25_gad_text_offset);

		kray25_c_sepfg1 = ctlsep(0, kray25_ui_seperator_w + 4);
		ctlposition(kray25_c_sepfg1, 115, kray25_ui_offset_y);
		kray25_ui_offset_y += kray25_ui_sep_spacing + 3; 

		ctlrefresh(kray25_c_girauto_copy,"scnGen_kray25_c_fgirautocopy");
		ctlvisible(kray25_c_gmatic,"scnGen_kray25_tf_active",kray25_c_girauto_copy,kray25_c_girauto);

		ctlactive(kray25_c_girauto,"scnGen_kray25_ft_active",kray25_c_gir,kray25_c_gir_copy);

		kray25_c_fg_preset=ctlpopup("Final Gather Preset",kray25_v_fg_preset,kray25_presets_list2);
		ctlposition(kray25_c_fg_preset, kray25_gad_x, kray25_ui_offset_y, kray25_gad_w + 35, kray25_gad_h, kray25_gad_text_offset);

		ctlrefresh(kray25_c_fg_preset,"scnGen_kray25_fg_presets");

		kray25_ui_offset_y += kray25_ui_row_offset;

		kray25_c_fgth = ctlnumber("FG Threshold",kray25_v_fgth);
		ctlposition(kray25_c_fgth, kray25_gad_x, kray25_ui_offset_y, 71 + kray25_gad_text_offset, kray25_gad_h, kray25_gad_text_offset);

		kray25_gad_prekray25_v_w = 71 + kray25_gad_text_offset;

		kray25_c_fgrmin = ctlinteger("Min Rays",kray25_v_fgrmin);
		ctlposition(kray25_c_fgrmin, kray25_gad_x + kray25_gad_prekray25_v_w + kray25_ui_spacing, kray25_ui_offset_y, 71 + 50, kray25_gad_h, 50);

		kray25_gad_prekray25_v_w += kray25_gad_x + kray25_ui_spacing + 71 + 50;

		kray25_c_fgrmax = ctlinteger("Max Rays",kray25_v_fgrmax);
		ctlposition(kray25_c_fgrmax, kray25_gad_x + kray25_gad_prekray25_v_w + kray25_ui_spacing, kray25_ui_offset_y, 71 + 53, kray25_gad_h, 53);

		kray25_ui_offset_y += kray25_ui_row_offset;

		kray25_c_prep = ctlpercent("Prerender",kray25_v_prep);
		ctlposition(kray25_c_prep, kray25_gad_x, kray25_ui_offset_y, 71 + kray25_gad_text_offset - 22, kray25_gad_h, kray25_gad_text_offset);

		ctlrefresh(kray25_c_prep,"scnGen_kray25_zero_one_c_prep_refresh");

		kray25_gad_prekray25_v_w = 71 + kray25_gad_text_offset;

		kray25_c_prestep = ctlinteger("Passes",kray25_v_prestep);
		ctlposition(kray25_c_prestep, kray25_gad_x + kray25_gad_prekray25_v_w + kray25_ui_spacing, kray25_ui_offset_y, 71 + 50, kray25_gad_h, 50);

		kray25_gad_prekray25_v_w += kray25_gad_x + kray25_ui_spacing + 71 + 50;

		kray25_c_preSplDet = ctlnumber("Splotch D",kray25_v_preSplDet);
		ctlposition(kray25_c_preSplDet, kray25_gad_x + kray25_gad_prekray25_v_w + kray25_ui_spacing, kray25_ui_offset_y, 71 + 53, kray25_gad_h, 53);

		kray25_ui_offset_y += kray25_ui_row_offset;

		kray25_c_gradNeighbour = ctlnumber("Sensitivity",kray25_v_gradNeighbour);
		ctlposition(kray25_c_gradNeighbour, kray25_gad_x, kray25_ui_offset_y, 71 + kray25_gad_text_offset, kray25_gad_h, kray25_gad_text_offset);

		kray25_ui_offset_y += kray25_ui_row_offset;

		kray25_gad_prekray25_v_w = 71 + kray25_gad_text_offset;

		kray25_c_fgreflections = ctlcheckbox("FG Reflections",kray25_v_fgreflections);
		ctlposition(kray25_c_fgreflections, kray25_gad_x, kray25_ui_offset_y, kray25_gad_w + 35, kray25_gad_h, kray25_gad_text_offset);

		kray25_ui_offset_y += kray25_ui_row_offset;

		kray25_c_fgrefractions = ctlcheckbox("FG Transparency / Refractions",kray25_v_fgrefractions);
		ctlposition(kray25_c_fgrefractions, kray25_gad_x, kray25_ui_offset_y, kray25_gad_w + 35, kray25_gad_h, kray25_gad_text_offset);

		kray25_ui_offset_y += kray25_ui_row_offset + 4;
		kray25_c_seppsfg = ctlsep(0, kray25_ui_seperator_w + 4);
		ctlposition(kray25_c_seppsfg, -2, kray25_ui_offset_y);
		kray25_ui_offset_y += kray25_ui_spacing + 5;

		kray25_c_fga = ctlnumber("Spatial Tolerance",kray25_v_fga);
		ctlposition(kray25_c_fga, kray25_gad_x, kray25_ui_offset_y, 71 + kray25_gad_text_offset, kray25_gad_h, kray25_gad_text_offset);

		kray25_gad_prekray25_v_w = 71 + kray25_gad_text_offset;

		kray25_c_fgb = ctlangle("Angular Tolerance",kray25_v_fgb);
		ctlposition(kray25_c_fgb, kray25_gad_x + kray25_gad_prekray25_v_w + 22, kray25_ui_offset_y, 130 - 24 + 101, kray25_gad_h, 101);

		kray25_ui_offset_y += kray25_ui_row_offset;

		kray25_c_fgmin = ctlpercent("Min Distance",kray25_v_fgmin);
		ctlposition(kray25_c_fgmin, kray25_gad_x, kray25_ui_offset_y, 71 + kray25_gad_text_offset - 22 , kray25_gad_h, kray25_gad_text_offset);

		kray25_c_fgmax = ctlpercent("Max Distance",kray25_v_fgmax);
		ctlposition(kray25_c_fgmax, kray25_gad_x + kray25_gad_prekray25_v_w + 22, kray25_ui_offset_y, 130 - 24 + 101, kray25_gad_h, 101);

		kray25_ui_offset_y += kray25_ui_row_offset;

		kray25_c_fgblur = ctlnumber("Blur Samples",kray25_v_fgblur);
		ctlposition(kray25_c_fgblur, kray25_gad_x, kray25_ui_offset_y, 71 + kray25_gad_text_offset, kray25_gad_h, kray25_gad_text_offset);

		kray25_c_fgscale = ctlpercent("Brightness / Density",kray25_v_fgscale);
		ctlposition(kray25_c_fgscale, kray25_gad_x + kray25_gad_prekray25_v_w + 22, kray25_ui_offset_y, 130 - 24 + 101, kray25_gad_h, 101);

		kray25_ui_offset_y += kray25_ui_row_offset;

		kray25_c_fgshows = ctlchoice("Show FG Samples",kray25_v_fgshows,@"Off","Corners","All"@);
		ctlposition(kray25_c_fgshows, kray25_gad_x, kray25_ui_offset_y, kray25_gad_w + 32, kray25_gad_h, kray25_gad_text_offset);

		kray25_ui_offset_y += kray25_ui_row_offset;

		kray25_c_fgsclr = ctlcolor("Color",kray25_v_fgsclr);
		ctlposition(kray25_c_fgsclr, kray25_gad_x, kray25_ui_offset_y, kray25_gad_w + 32, kray25_gad_h, kray25_gad_text_offset);

		kray25_ui_offset_y += kray25_ui_row_offset + kray25_ui_sep_spacing;

		kray25_c_pth_text=ctltext("","Path Tracing Settings:");
		ctlposition(kray25_c_pth_text, kray25_gad_x + 10, kray25_ui_offset_y - 8, 100,kray25_gad_h, kray25_gad_text_offset);

		kray25_c_seppsfg2 = ctlsep(0, kray25_ui_seperator_w + 4);
		ctlposition(kray25_c_seppsfg2, 115, kray25_ui_offset_y);
		kray25_ui_offset_y += kray25_ui_sep_spacing + 3;

		kray25_c_cornerpaths = ctlinteger("Path Passes",kray25_v_cornerpaths);
		ctlposition(kray25_c_cornerpaths, kray25_gad_x, kray25_ui_offset_y, 71 + kray25_gad_text_offset, kray25_gad_h, kray25_gad_text_offset);

		kray25_c_cornerdist = ctlpercent("Corner Distance",kray25_v_cornerdist);
		ctlposition(kray25_c_cornerdist, kray25_gad_x + kray25_gad_prekray25_v_w + 22, kray25_ui_offset_y, 130 - 24 + 101, kray25_gad_h, 101);

		ctlactive(kray25_c_fg_preset,"scnGen_kray25_is_1",kray25_c_fga,kray25_c_fgb,kray25_c_fgmin,kray25_c_fgmax,kray25_c_fgscale,kray25_c_fgblur,kray25_c_fgshows,kray25_c_fgsclr);

		ctlpage(3,kray25_c_fgth,kray25_c_fgrmin,kray25_c_fgrmax,kray25_c_fga,kray25_c_fgb,kray25_c_fgmin,kray25_c_fgmax,kray25_c_fgscale,kray25_c_fgblur,kray25_c_fgshows,kray25_c_fgsclr,kray25_c_seppsfg,kray25_c_seppsfg2,kray25_c_fg_text,kray25_c_prep,kray25_c_pth_text,
		 kray25_c_girauto_copy,kray25_c_cornerdist,kray25_c_cornerpaths,kray25_c_fg_preset,kray25_c_gir_copy,kray25_c_sepfg1,kray25_c_fgreflections,kray25_c_fgrefractions,kray25_c_prestep,kray25_c_preSplDet,kray25_c_gradNeighbour);

		// Sampling Tab
		
		// Reset kray25_ui_offset_y value
		kray25_ui_offset_y = ref_offset_y; // kray25_ui_tab_bottom + (kray25_ui_spacing*2);

		kray25_ui_offset_y += kray25_ui_sep_spacing;

		kray25_c_aa_text=ctltext("","Antialiasing Settings :");
		ctlposition(kray25_c_aa_text, kray25_gad_x + 10, kray25_ui_offset_y - 8, 100, kray25_gad_h, kray25_gad_text_offset);

		kray25_c_sepaa6 = ctlsep(0, kray25_ui_seperator_w + 4);
		ctlposition(kray25_c_sepaa6, 112, kray25_ui_offset_y);
		kray25_ui_offset_y += kray25_ui_sep_spacing + 3;

		kray25_c_aa_preset=ctlpopup("AA Preset",kray25_v_aa_preset,kray25_presets_list);
		ctlposition(kray25_c_aa_preset, kray25_gad_x, kray25_ui_offset_y, kray25_gad_w, kray25_gad_h, kray25_gad_text_offset);

		scene = Scene();
		kray25_dof_active=scene.renderopts[7];
		mb_active=scene.renderopts[6];

		kray25_ui_offset_y += kray25_ui_row_offset;
		
		kray25_c_pxlfltr = ctlpopup("Pixel Filter",kray25_v_pxlfltr,@"Box","Cone","Cubic","Quadratic","Lanczos","Mitchell","Spline","Catmull"@);
		ctlposition(kray25_c_pxlfltr, kray25_gad_x, kray25_ui_offset_y, kray25_gad_w, kray25_gad_h, kray25_gad_text_offset);

		kray25_c_pxlparam = ctlnumber("Filter Radius",kray25_v_pxlparam);
		ctlposition(kray25_c_pxlparam, kray25_gad_x + kray25_gad_w + kray25_ui_spacing, kray25_ui_offset_y, 91 + 64, kray25_gad_h, 64);

		ctlvisible(kray25_c_pxlfltr,"scnGen_kray25_is_less_then_6",kray25_c_pxlparam);

		kray25_ui_offset_y += kray25_ui_row_offset*1.5;      

		kray25_c_aatype = ctlpopup("Antialiasing",kray25_v_aatype,@"None","Grid","Quasi-Random","Random Full Screen AA"@);
		ctlposition(kray25_c_aatype, kray25_gad_x, kray25_ui_offset_y, kray25_gad_w, kray25_gad_h, kray25_gad_text_offset);

		kray25_c_aafscreen = ctlcheckbox("Full Screen Antialiasing",kray25_v_aafscreen);
		ctlposition(kray25_c_aafscreen, kray25_gad_x + kray25_gad_w + kray25_ui_spacing, kray25_ui_offset_y, 159, kray25_gad_h,0);

		ctlrefresh(kray25_c_aatype,"scnGen_kray25_disable_fscreen_refresh");

		kray25_ui_offset_y += kray25_ui_row_offset;

		kray25_c_aargsmpl = ctlinteger("Grid Size",kray25_v_aargsmpl);
		ctlposition(kray25_c_aargsmpl, kray25_gad_x, kray25_ui_offset_y, kray25_gad_w, kray25_gad_h, kray25_gad_text_offset);

		kray25_c_aagridrotate = ctlcheckbox("Rotated Grid",kray25_v_aagridrotate);
		ctlposition(kray25_c_aagridrotate, kray25_gad_x + kray25_gad_w + kray25_ui_spacing, kray25_ui_offset_y, 159, kray25_gad_h,0);

		kray25_c_cstocvar = ctlnumber("Threshold",kray25_v_cstocvar);
		ctlposition(kray25_c_cstocvar,  kray25_gad_x, kray25_ui_offset_y, kray25_gad_w, kray25_gad_h, kray25_gad_text_offset);

		kray25_c_aarandsmpl = ctlinteger("Rays",kray25_v_aarandsmpl);
		ctlposition(kray25_c_aarandsmpl, kray25_gad_x, kray25_ui_offset_y, kray25_gad_w, kray25_gad_h, kray25_gad_text_offset);

		kray25_ui_offset_y += kray25_ui_row_offset;

		kray25_c_cstocmin = ctlinteger("Min Rays",kray25_v_cstocmin);
		ctlposition(kray25_c_cstocmin,  kray25_gad_x, kray25_ui_offset_y, kray25_gad_w, kray25_gad_h, kray25_gad_text_offset);

		kray25_c_cmbsubframes = ctlinteger("MB Subframes",kray25_v_cmbsubframes);
		ctlposition(kray25_c_cmbsubframes, kray25_gad_x, kray25_ui_offset_y, kray25_gad_w, kray25_gad_h, kray25_gad_text_offset);

		kray25_ui_offset_y += kray25_ui_row_offset;

		kray25_c_cstocmax = ctlinteger("Max Rays",kray25_v_cstocmax);
		ctlposition(kray25_c_cstocmax,  kray25_gad_x, kray25_ui_offset_y, kray25_gad_w, kray25_gad_h, kray25_gad_text_offset);

		kray25_ui_offset_y += kray25_ui_row_offset; // Create space for gadgets that will be defined lower down
		kray25_ui_offset_y += kray25_ui_sep_spacing;

		kray25_c_aa_atext=ctltext("","Adaptive Settings :");
		ctlposition(kray25_c_aa_atext, kray25_gad_x + 10, kray25_ui_offset_y - 8, 100);

		kray25_c_sepaa1 = ctlsep(0, kray25_ui_seperator_w + 4);
		ctlposition(kray25_c_sepaa1, 101, kray25_ui_offset_y);
		kray25_ui_offset_y += kray25_ui_sep_spacing + 3;

		kray25_c_edgeabs = ctlnumber("Edge Absolute",kray25_v_edgeabs);
		ctlposition(kray25_c_edgeabs, kray25_gad_x, kray25_ui_offset_y, kray25_gad_w, kray25_gad_h, kray25_gad_text_offset);

		kray25_c_edgerel = ctlnumber("Relative",kray25_v_edgerel);
		ctlposition(kray25_c_edgerel, kray25_gad_x + kray25_gad_w + kray25_ui_spacing, kray25_ui_offset_y, 91 + 64, kray25_gad_h, 64);

		kray25_ui_offset_y += kray25_ui_row_offset;

		kray25_c_edgethick = ctlinteger("Thickness",kray25_v_edgethick);
		ctlposition(kray25_c_edgethick, kray25_gad_x, kray25_ui_offset_y, kray25_gad_w, kray25_gad_h, kray25_gad_text_offset);

		kray25_c_edgeover = ctlnumber("Overburn",kray25_v_edgeover);
		ctlposition(kray25_c_edgeover, kray25_gad_x + kray25_gad_w + kray25_ui_spacing, kray25_ui_offset_y, 91 + 64, kray25_gad_h, 64);
		
		kray25_ui_offset_y += kray25_ui_row_offset; 
		kray25_ui_offset_y += kray25_ui_sep_spacing;
		
		kray25_c_aa_atext2=ctltext("","Geometry Detect :");
		ctlposition(kray25_c_aa_atext2, kray25_gad_x + 10, kray25_ui_offset_y - 8, 100);
		
		kray25_c_sepaa2 = ctlsep(0, kray25_ui_seperator_w + 4);
		ctlposition(kray25_c_sepaa2, 101, kray25_ui_offset_y);
		kray25_ui_offset_y += kray25_ui_sep_spacing + 3;
		
		kray25_c_edgenorm = ctlnumber("Normal",kray25_v_edgenorm);
		ctlposition(kray25_c_edgenorm, kray25_gad_x, kray25_ui_offset_y, kray25_gad_w, kray25_gad_h, kray25_gad_text_offset);
		
		kray25_c_edgezbuf = ctlnumber("Z",kray25_v_edgezbuf);
		ctlposition(kray25_c_edgezbuf, kray25_gad_x + kray25_gad_w + kray25_ui_spacing, kray25_ui_offset_y, 91 + 64, kray25_gad_h, 64);

		kray25_ui_offset_y += kray25_ui_row_offset;
		
		kray25_c_edgeup = ctlinteger("Upsample",kray25_v_edgeup);
		ctlposition(kray25_c_edgeup, kray25_gad_x, kray25_ui_offset_y, kray25_gad_w, kray25_gad_h, kray25_gad_text_offset);

		kray25_ui_offset_y += kray25_ui_row_offset*2;
		
		kray25_c_underf = ctlpopup("Undersample",kray25_v_underf,@"None","2","4","8","16","32","64","128","256","512"@);
		ctlposition(kray25_c_underf, kray25_gad_x, kray25_ui_offset_y, kray25_gad_w, kray25_gad_h, kray25_gad_text_offset);

		kray25_c_undert = ctlnumber("Threshold",kray25_v_undert);
		ctlposition(kray25_c_undert, kray25_gad_x + kray25_gad_w + kray25_ui_spacing, kray25_ui_offset_y, 91 + 64, kray25_gad_h, 64);        

		ctlvisible(kray25_c_aatype,"scnGen_kray25_c_antistoc",kray25_c_cstocvar,kray25_c_cstocmax,kray25_c_cstocmin);
		ctlvisible(kray25_c_aatype,"scnGen_kray25_is_not_4",kray25_c_cmbsubframes);
		ctlvisible(kray25_c_aatype,"scnGen_kray25_c_antigrid",kray25_c_aagridrotate,kray25_c_aargsmpl);
		ctlvisible(kray25_c_aatype,"scnGen_kray25_c_antirand",kray25_c_aarandsmpl);

		ctlvisible(kray25_c_aatype,"scnGen_kray25_is_not_one_not_four_active",kray25_c_aafscreen);
		ctlvisible(kray25_c_aatype,"scnGen_kray25_is_one_or_four_active",kray25_c_aa_atext,kray25_c_sepaa1,kray25_c_edgeabs,kray25_c_edgerel,kray25_c_edgethick,kray25_c_edgeover,kray25_c_aa_atext2,kray25_c_sepaa2,kray25_c_edgenorm,kray25_c_edgezbuf,kray25_c_edgeup);

		// ctlactive(kray25_c_underf,"scnGen_kray25_is_1",kray25_c_edgenorm,kray25_c_edgezbuf,kray25_c_edgeup);
		ctlrefresh(kray25_c_underf,"scnGen_kray25_on_off_fsaa_refresh");
		
		ctlactive(kray25_c_underf,"scnGen_kray25_is_not_1",kray25_c_undert);
		ctlactive(kray25_c_aafscreen,"scnGen_kray25_aa_edge_active",kray25_c_edgeabs,kray25_c_edgerel,kray25_c_edgethick,kray25_c_edgeover);
		ctlactive(kray25_c_aafscreen,"scnGen_kray25_aa_edge_active2",kray25_c_edgenorm,kray25_c_edgezbuf,kray25_c_edgeup);
		ctlrefresh(kray25_c_aa_preset,"scnGen_kray25_aa_presets");

		ctlpage(4,kray25_c_aatype,kray25_c_underf,kray25_c_undert,kray25_c_cstocvar,kray25_c_cstocmin,kray25_c_cstocmax,kray25_c_aa_text,kray25_c_aa_atext,
		kray25_c_cmbsubframes,kray25_c_sepaa6,kray25_c_aafscreen,kray25_c_sepaa1, kray25_c_edgeabs,kray25_c_edgerel,kray25_c_edgenorm,kray25_c_edgezbuf,kray25_c_edgeup,
		kray25_c_edgethick,kray25_c_edgeover,kray25_c_pxlfltr,kray25_c_pxlparam,kray25_c_aa_preset,kray25_c_aargsmpl,kray25_c_aarandsmpl,kray25_c_aagridrotate,kray25_c_sepaa2,kray25_c_aa_atext2);

		// Quality Tab

		// Reset kray25_ui_offset_y value
		kray25_ui_offset_y = ref_offset_y; // kray25_ui_tab_bottom + (kray25_ui_spacing*2);

		kray25_c_quality_preset=ctlpopup("Quality Preset",kray25_v_quality_preset,kray25_presets_list);
		ctlposition(kray25_c_quality_preset, kray25_gad_x, kray25_ui_offset_y, kray25_gad_w, kray25_gad_h, kray25_gad_text_offset);
		ctlrefresh(kray25_c_quality_preset,"scnGen_kray25_quality_presets");

		kray25_ui_offset_y += kray25_ui_row_offset + 4;
		kray25_c_sep_qua = ctlsep(0, kray25_ui_seperator_w + 4);
		ctlposition(kray25_c_sep_qua, -2, kray25_ui_offset_y);
		kray25_ui_offset_y += kray25_ui_spacing + 5;

		kray25_c_lg = ctlpopup("Luminosity Model",kray25_v_lg,@"Compute as Indirect","Compute as Direct","Automatic"@);
		ctlposition(kray25_c_lg, kray25_gad_x, kray25_ui_offset_y, kray25_gad_w, kray25_gad_h, kray25_gad_text_offset);

		kray25_c_autolumi = ctlpercent("Level",kray25_v_autolumi);
		ctlposition(kray25_c_autolumi, kray25_gad_x + kray25_gad_w + kray25_ui_spacing, kray25_ui_offset_y, 102 + 32, kray25_gad_h, 32);
		ctlvisible(kray25_c_lg,"scnGen_kray25_is_3",kray25_c_autolumi);
		
		kray25_ui_offset_y += kray25_ui_row_offset;

		kray25_c_pl = ctlpopup("Area Lights",kray25_v_pl,@"Compute Separately (AS)","Compute With Luminosity"@);
		ctlposition(kray25_c_pl, kray25_gad_x, kray25_ui_offset_y, kray25_gad_w, kray25_gad_h, kray25_gad_text_offset);

		kray25_c_areaside = ctlcheckbox("Double Sided",kray25_v_areaside);
		ctlposition(kray25_c_areaside, kray25_gad_x + kray25_gad_w + kray25_ui_spacing, kray25_ui_offset_y, 105 + 22 + 32, kray25_gad_h, 32);

		kray25_ui_offset_y += kray25_ui_row_offset;

		kray25_c_areavis = ctlpopup("Area Light Visibility",kray25_v_areavis,@"Visible (Realistic)","Invisible (LW Compatible)"@);
		ctlposition(kray25_c_areavis, kray25_gad_x, kray25_ui_offset_y, kray25_gad_w, kray25_gad_h, kray25_gad_text_offset);

		kray25_c_conetoarea = ctlcheckbox("Spotlights To Area",kray25_v_conetoarea);
		ctlposition(kray25_c_conetoarea, kray25_gad_x + kray25_gad_w + kray25_ui_spacing, kray25_ui_offset_y, 105 + 22 + 32, kray25_gad_h, 32);
		
		kray25_ui_offset_y += kray25_ui_row_offset + kray25_ui_sep_spacing;

		kray25_c_light_qtext=ctltext("","Lights Quality:");
		ctlposition(kray25_c_light_qtext, kray25_gad_x + 10, kray25_ui_offset_y - 8, 100,kray25_gad_h, kray25_gad_text_offset);

		kray25_c_light_qsep = ctlsep(0, kray25_ui_seperator_w + 4);
		ctlposition(kray25_c_light_qsep, 80, kray25_ui_offset_y);
		kray25_ui_offset_y += kray25_ui_sep_spacing + 3;

		kray25_c_planth = ctlnumber("Area Lights Threshold",kray25_v_planth);
		ctlposition(kray25_c_planth, kray25_gad_x + 10, kray25_ui_offset_y, 75 + 116, kray25_gad_h, 116);

		kray25_gad_prekray25_v_w = 75 + 116 + 10;
		
		kray25_c_planrmin = ctlinteger("Min Recursion",kray25_v_planrmin);
		ctlposition(kray25_c_planrmin, kray25_gad_x + kray25_gad_prekray25_v_w + kray25_ui_spacing, kray25_ui_offset_y, 52 + 77, kray25_gad_h, 77);

		kray25_gad_prekray25_v_w += 52 + 77 + 10;

		kray25_c_planrmax = ctlinteger("Max",kray25_v_planrmax);
		ctlposition(kray25_c_planrmax, kray25_gad_x + kray25_gad_prekray25_v_w + kray25_ui_spacing, kray25_ui_offset_y, 53 + 26, kray25_gad_h, 26);

		kray25_ui_offset_y += kray25_ui_row_offset;

		kray25_c_llinth = ctlnumber("Linear Lights Threshold",kray25_v_llinth);
		ctlposition(kray25_c_llinth, kray25_gad_x + 10, kray25_ui_offset_y, 75 + 116, kray25_gad_h, 116);

		kray25_gad_prekray25_v_w = 75 + 116 + 10;

		kray25_c_llinrmin = ctlinteger("Min Recursion",kray25_v_llinrmin);
		ctlposition(kray25_c_llinrmin, kray25_gad_x + kray25_gad_prekray25_v_w + kray25_ui_spacing, kray25_ui_offset_y, 52 + 77, kray25_gad_h, 77);

		kray25_gad_prekray25_v_w += 52 + 77 + 10;

		kray25_c_llinrmax = ctlinteger("Max",kray25_v_llinrmax);
		ctlposition(kray25_c_llinrmax, kray25_gad_x + kray25_gad_prekray25_v_w + kray25_ui_spacing, kray25_ui_offset_y, 53 + 26, kray25_gad_h, 26);

		kray25_ui_offset_y += kray25_ui_row_offset;

		kray25_c_lumith = ctlnumber("Luminosity Threshold",kray25_v_lumith);
		ctlposition(kray25_c_lumith, kray25_gad_x + 10, kray25_ui_offset_y, 75 + 116, kray25_gad_h, 116);

		kray25_gad_prekray25_v_w = 75 + 116 + 10;

		kray25_c_lumirmin = ctlinteger("Min Rays",kray25_v_lumirmin);
		ctlposition(kray25_c_lumirmin, kray25_gad_x + kray25_gad_prekray25_v_w + kray25_ui_spacing, kray25_ui_offset_y, 52 + 77, kray25_gad_h, 77);
		
		kray25_gad_prekray25_v_w += 52 + 77 + 10;

		kray25_c_lumirmax = ctlinteger("Max",kray25_v_lumirmax);
		ctlposition(kray25_c_lumirmax, kray25_gad_x + kray25_gad_prekray25_v_w + kray25_ui_spacing, kray25_ui_offset_y, 53 + 26, kray25_gad_h, 26);

		kray25_ui_offset_y += kray25_ui_row_offset + kray25_ui_sep_spacing;

		kray25_c_blur_text=ctltext("","Reflection / Refraction Quality:");
		ctlposition(kray25_c_blur_text, kray25_gad_x + 10, kray25_ui_offset_y - 8, 100,kray25_gad_h, kray25_gad_text_offset);

		kray25_c_sep11 = ctlsep(0, kray25_ui_seperator_w + 4);
		ctlposition(kray25_c_sep11, 162, kray25_ui_offset_y);
		kray25_ui_offset_y += kray25_ui_sep_spacing + 3;

		kray25_c_refth = ctlnumber("Blurring Threshold",kray25_v_refth);
		ctlposition(kray25_c_refth, kray25_gad_x + 10, kray25_ui_offset_y, 75 + 116, kray25_gad_h, 116);

		kray25_gad_prekray25_v_w = 75 + 116 + 10;

		kray25_c_refrmin = ctlinteger("Min Rays",kray25_v_refrmin);
		ctlposition(kray25_c_refrmin, kray25_gad_x + kray25_gad_prekray25_v_w + kray25_ui_spacing, kray25_ui_offset_y, 52 + 77, kray25_gad_h, 77);

		kray25_gad_prekray25_v_w += 52 + 77 + 10;

		kray25_c_refrmax = ctlinteger("Max",kray25_v_refrmax);
		ctlposition(kray25_c_refrmax, kray25_gad_x + kray25_gad_prekray25_v_w + kray25_ui_spacing, kray25_ui_offset_y, 53 + 26, kray25_gad_h, 26);

		kray25_ui_offset_y += kray25_ui_row_offset;

		kray25_c_refacth = ctlpercent("Blurring Accuracy Limit",kray25_v_refacth);
		ctlposition(kray25_c_refacth, kray25_gad_x + 10, kray25_ui_offset_y, 75 + 116 - 22, kray25_gad_h, 116);

		kray25_gad_prekray25_v_w = 75 + 116 - 22;

		kray25_c_refmodel = ctlcheckbox("Trace Direct Light Reflections",kray25_v_refmodel);
		ctlposition(kray25_c_refmodel, kray25_gad_x + kray25_gad_prekray25_v_w + kray25_ui_spacing, kray25_ui_offset_y, 194 + 24 + 32, kray25_gad_h, 32);

		kray25_ui_offset_y += kray25_ui_row_offset + kray25_ui_sep_spacing;

		kray25_c_memm_text=ctltext("","Memory Management:");
		ctlposition(kray25_c_memm_text, kray25_gad_x + 10, kray25_ui_offset_y - 8, 100,kray25_gad_h, kray25_gad_text_offset);

		kray25_c_sepm11 = ctlsep(0, kray25_ui_seperator_w + 4);
		ctlposition(kray25_c_sepm11, 118, kray25_ui_offset_y);
		kray25_ui_offset_y += kray25_ui_sep_spacing + 3;

		kray25_c_octdepth = ctlpopup("Octree Detail",kray25_v_octdepth,@"Very Low","Low","Normal","High"@);
		ctlposition(kray25_c_octdepth, kray25_gad_x, kray25_ui_offset_y, kray25_gad_w, kray25_gad_h, kray25_gad_text_offset);

		ctlactive(kray25_c_quality_preset,"scnGen_kray25_is_1",kray25_c_planth,kray25_c_planrmin,kray25_c_planrmax,kray25_c_llinth,kray25_c_llinrmin,kray25_c_llinrmax,kray25_c_lumith,kray25_c_lumirmin,kray25_c_lumirmax,kray25_c_refth,kray25_c_refrmin,kray25_c_refrmax,kray25_c_refacth,kray25_c_refmodel,kray25_c_octdepth);

		ctlpage(5,
		kray25_c_sep11,kray25_c_refth,kray25_c_refrmin,kray25_c_refrmax,kray25_c_sepm11,kray25_c_refacth,kray25_c_refmodel,
		kray25_c_planth,kray25_c_planrmin,kray25_c_planrmax,
		kray25_c_llinth,kray25_c_llinrmin,kray25_c_llinrmax,
		kray25_c_lumith,kray25_c_lumirmin,kray25_c_lumirmax,kray25_c_octdepth,
		kray25_c_memm_text,
		kray25_c_conetoarea,kray25_c_blur_text,
		kray25_c_quality_preset,kray25_c_sep_qua,kray25_c_autolumi,kray25_c_lg,kray25_c_pl,kray25_c_areaside,
		kray25_c_areavis,kray25_c_light_qsep,kray25_c_light_qtext);


@if Kray_Plugins
		// Kray Plugins Tab

	    // Reset ui_offset_y value
		kray25_ui_offset_y = ref_offset_y; // kray25_ui_tab_bottom + (kray25_ui_spacing*2);

		kray25_ui_offset_y += kray25_ui_sep_spacing;

@if Kray_PS
		kray25_c_open_physky	= ctlbutton("Physical Sky",0,"scnmasterOverride_UI_kray25_physky");
		ctlposition(kray25_c_open_physky, kray25_gad_x + 10, kray25_ui_offset_y, 220, kray25_gad_h, 50);
@end

		kray25_ui_offset_y += kray25_ui_sep_spacing;
		kray25_ui_offset_y += kray25_ui_sep_spacing;

@if Kray_QuickLWF
		kray25_c_open_quicklwf	= ctlbutton("QuickLWF",0,"scnmasterOverride_UI_kray25_QuickLWF");
		ctlposition(kray25_c_open_quicklwf, kray25_gad_x + 10, kray25_ui_offset_y, 220, kray25_gad_h, 50);
@end

		kray25_ui_offset_y += kray25_ui_sep_spacing;
		kray25_ui_offset_y += kray25_ui_sep_spacing;

@if Kray_QuickLWF
		kray25_c_open_tonemapblend	= ctlbutton("Tonemap Blend",0,"scnmasterOverride_UI_kray25_ToneMap");
		ctlposition(kray25_c_open_tonemapblend, kray25_gad_x + 10, kray25_ui_offset_y, 220, kray25_gad_h, 50);
@end

/*		kray25_ui_offset_y += kray25_ui_sep_spacing;
		kray25_ui_offset_y += kray25_ui_sep_spacing;

		kray25_c_open_override	= ctlbutton("Override",0,"scnmasterOverride_UI_kray25_override");
		ctlposition(kray25_c_open_override, kray25_gad_x + 10, kray25_ui_offset_y, 220, kray25_gad_h, 50);

		kray25_ui_offset_y += kray25_ui_sep_spacing;
		kray25_ui_offset_y += kray25_ui_sep_spacing;

		kray25_c_open_buffers	= ctlbutton("Buffers",0,"scnmasterOverride_UI_kray25_buffers");
		ctlposition(kray25_c_open_buffers, kray25_gad_x + 10, kray25_ui_offset_y, 220, kray25_gad_h, 50);
		*/

		// Define gadgets associated with tab 6
		ctlpage(6
@if Kray_PS
		,kray25_c_open_physky
@end
@if Kray_QuickLWF
		,kray25_c_open_quicklwf
@end
@if Kray_ToneMap
		,kray25_c_open_tonemapblend
@end
/*		kray25_c_open_override,
		kray25_c_open_buffers
		*/
		);
@end
		// MISC Tab
		
		kray25_xOffset = 10;
		kray25_OnSwitchWidth = 100;
		kray25_xStart = 5;
		kray25_textw = 240;
		kray25_SecondSwitchWidth = kray25_ui_window_w - kray25_textw - kray25_OnSwitchWidth - kray25_xOffset*2 - kray25_xStart;
		// Reset kray25_ui_offset_y value
		
		kray25_ui_offset_y = ref_offset_y; // kray25_ui_tab_bottom + (kray25_ui_spacing*2);
		// kray25_ui_offset_y += kray25_ui_sep_spacing;

		//Logfile
		kray25_c_LogOn = ctlcheckbox("Logfile",kray25_v_LogOn);
		ctlposition(kray25_c_LogOn, kray25_xOffset, kray25_ui_offset_y, kray25_OnSwitchWidth, kray25_gad_h, kray25_xStart);

		kray25_c_Logfile = ctlfilename("",kray25_v_Logfile,0,0);
		kray25_offout = kray25_OnSwitchWidth + kray25_ui_spacing;        
		ctlposition(kray25_c_Logfile, kray25_xOffset + kray25_offout, kray25_ui_offset_y, kray25_OnSwitchWidth + kray25_textw + kray25_ui_spacing - kray25_offout - 23, kray25_gad_h, 0 );
		
		kray25_offout = kray25_OnSwitchWidth + kray25_textw + kray25_ui_spacing;
		kray25_c_Debug = ctlcheckbox("Debug",kray25_v_Debug);
		ctlposition(kray25_c_Debug, kray25_xOffset + kray25_offout, kray25_ui_offset_y, kray25_SecondSwitchWidth, kray25_gad_h, kray25_xStart);            
		
		ctlactive(kray25_c_LogOn,"scnGen_kray25_is_1",kray25_c_Logfile);
		kray25_ui_offset_y += kray25_ui_row_offset;
				  
		//Renderinfo
		kray25_c_InfoOn = ctlcheckbox("Info Stamp",kray25_v_InfoOn);
		ctlposition(kray25_c_InfoOn, kray25_xOffset, kray25_ui_offset_y, kray25_OnSwitchWidth, kray25_gad_h, kray25_xStart);

		kray25_c_InfoText = ctlstring("",kray25_v_InfoText);
		kray25_offout = kray25_OnSwitchWidth + kray25_ui_spacing;
		ctlposition(kray25_c_InfoText, kray25_xOffset + kray25_offout, kray25_ui_offset_y, kray25_OnSwitchWidth + kray25_textw + kray25_ui_spacing - kray25_offout, kray25_gad_h, 0 );

		kray25_c_RenderIinfoAdd = ctlpopup("",1,kray25_renderinfo_list);
		kray25_offout = kray25_OnSwitchWidth + kray25_textw + kray25_ui_spacing;
		ctlposition(kray25_c_RenderIinfoAdd, kray25_xOffset + kray25_offout, kray25_ui_offset_y, kray25_SecondSwitchWidth, kray25_gad_h, kray25_xStart);            
		ctlrefresh(kray25_c_RenderIinfoAdd,"scnGen_kray25_refresh_renderinfo_add");
				  
		ctlactive(kray25_c_InfoOn,"scnGen_kray25_is_1",kray25_c_InfoText,kray25_c_RenderIinfoAdd);
		kray25_ui_offset_y += kray25_ui_row_offset;
		
		//Include
		kray25_c_IncludeOn = ctlcheckbox("Include",kray25_v_IncludeOn);
		ctlposition(kray25_c_IncludeOn, kray25_xOffset, kray25_ui_offset_y, kray25_OnSwitchWidth, kray25_gad_h, kray25_xStart);

		kray25_c_IncludeFile = ctlfilename("",kray25_v_IncludeFile,0,0);
		kray25_offout = kray25_OnSwitchWidth + kray25_ui_spacing;        
		ctlposition(kray25_c_IncludeFile, kray25_xOffset + kray25_offout, kray25_ui_offset_y, kray25_OnSwitchWidth + kray25_textw + kray25_ui_spacing - kray25_offout - 23, kray25_gad_h, 0 );
		
		ctlactive(kray25_c_IncludeOn,"scnGen_kray25_is_1",kray25_c_IncludeFile);
		kray25_ui_offset_y += kray25_ui_row_offset*2;

		//SWITCHES
		
		kray25_OnSwitchWidth = kray25_ui_window_w * 0.5 - (kray25_xStart * 2) - kray25_ui_spacing;
		// Full render preview
		kray25_c_FullPrev = ctlcheckbox("Full size preview",kray25_v_FullPrev);
		ctlposition(kray25_c_FullPrev, kray25_xOffset, kray25_ui_offset_y, kray25_OnSwitchWidth, kray25_gad_h, kray25_xStart);
		
		// Finishclose
		kray25_c_Finishclose = ctlcheckbox("Close preview on finish",kray25_v_Finishclose);
		ctlposition(kray25_c_Finishclose, kray25_xOffset + kray25_OnSwitchWidth + kray25_ui_spacing, kray25_ui_offset_y, kray25_OnSwitchWidth, kray25_gad_h, kray25_xStart);
		kray25_ui_offset_y += kray25_ui_row_offset;
		
		// unseenbyrays_affectsgi 1;
		kray25_c_UBRAGI = ctlcheckbox("Unseen by rays casts light",kray25_v_UBRAGI);
		ctlposition(kray25_c_UBRAGI, kray25_xOffset, kray25_ui_offset_y, kray25_OnSwitchWidth, kray25_gad_h, kray25_xStart);
		
		// outputtolw 1;
		kray25_c_outputtolw = ctlcheckbox("Also output to LW",kray25_v_outputtolw);
		ctlposition(kray25_c_outputtolw, kray25_xOffset + kray25_OnSwitchWidth + kray25_ui_spacing, kray25_ui_offset_y, kray25_OnSwitchWidth, kray25_gad_h, kray25_xStart);
		
		kray25_ui_offset_y += kray25_ui_row_offset*2;
		
		// HEADER TAILER COMMANDS
		OnSwitchWidth = 100;
		
		ctlpage(
@if Kray_Plugins
		7
@else
		6
@end
		,kray25_c_LogOn,kray25_c_Logfile,kray25_c_Debug,kray25_c_InfoOn,kray25_c_InfoText,kray25_c_RenderIinfoAdd,kray25_c_IncludeOn,kray25_c_IncludeFile,kray25_c_FullPrev,kray25_c_Finishclose,kray25_c_UBRAGI,kray25_c_outputtolw
		//,kray25_c_prescript,kray25_c_postscript,kray25_c_headeradd,kray25_c_taileradd
		);

		if (create_flag==1)
		{
			scnGen_kray25_photons_presets(kray25_v_gph_preset);
			scnGen_kray25_caustics_presets(kray25_v_cph_preset);
			scnGen_kray25_fg_presets(kray25_v_fg_preset);
			scnGen_kray25_aa_presets(kray25_v_aa_preset);
			scnGen_kray25_quality_presets(kray25_v_quality_preset);
			create_flag=0;
		}

		if(reqpost())
		{
			newName                      = getvalue(kray25_c20);
			newName                      = makeStringGood(newName);
			::overrideRenderer                = 2; // hard-coded.

			kray25_v_gph_preset = getvalue(kray25_c_gph_preset);
			kray25_v_cph_preset = getvalue(kray25_c_gph_preset);
			kray25_v_fg_preset = getvalue(kray25_c_fg_preset);
			kray25_v_aa_preset = getvalue(kray25_c_aa_preset);
			kray25_v_quality_preset = getvalue(kray25_c_quality_preset);

			//104 settings block
			kray25_v_gi = getvalue(kray25_c_gi);
			kray25_v_gicaustics = getvalue(kray25_c_gicaustics);
			kray25_v_giirrgrad = getvalue(kray25_c_giirrgrad);
			kray25_v_gipmmode = getvalue(kray25_c_gipmmode);

			//2301 settings block
			kray25_v_girtdirect = getvalue(kray25_c_girtdirect);

			//201 settings block
			kray25_v_lg = getvalue(kray25_c_lg);

			//301 settings block
			kray25_v_pl = getvalue(kray25_c_pl);

			//3501 - we don't handle that right now.

			//602 settings block
			kray25_v_prep = getvalue(kray25_c_prep);
			kray25_v_pxlordr = getvalue(kray25_c_pxlordr);

			//CONSTRUCTION
			kray25_v_lenspict = getvalue(kray25_c_lenspict);
			if (kray25_v_lenspict == nil)
			{
				kray25_v_lenspict = "__PPRN__BLANK__ENTRY__";
			}
			kray25_v_dofobj = kray25_objnames[int(getvalue(kray25_c_dofobj))];
			if (kray25_v_dofobj == nil)
			{
				kray25_v_dofobj = "__PPRN__BLANK__ENTRY__";
			}
			kray25_v_camobject = kray25_meshids[int(getvalue(kray25_c_camobject))];
			if (kray25_v_camobject == nil)
			{
				kray25_v_camobject = "__PPRN__BLANK__ENTRY__";
			}
			kray25_v_camuvname = kray25_vmapnames[int(getvalue(kray25_c_camuvname))];
			if (kray25_v_camuvname == nil)
			{
				kray25_v_camuvname = "__PPRN__BLANK__ENTRY__";
			}

			//702 settings block
			kray25_v_underf = getvalue(kray25_c_underf);
			kray25_v_undert = getvalue(kray25_c_undert);

			//802 settings block
			kray25_v_areavis = getvalue(kray25_c_areavis);
			kray25_v_areaside = getvalue(kray25_c_areaside);

			//1003 settings block
			kray25_v_planth = getvalue(kray25_c_planth);
			kray25_v_planrmin = getvalue(kray25_c_planrmin);
			kray25_v_planrmax = getvalue(kray25_c_planrmax);

			//2103 settings block
			kray25_v_llinth = getvalue(kray25_c_llinth);
			kray25_v_llinrmin = getvalue(kray25_c_llinrmin);
			kray25_v_llinrmax = getvalue(kray25_c_llinrmax);

			//1103 settings block
			kray25_v_lumith = getvalue(kray25_c_lumith);
			kray25_v_lumirmin = getvalue(kray25_c_lumirmin);
			kray25_v_lumirmax = getvalue(kray25_c_lumirmax);

			//1603 settings block
			kray25_v_cstocvar = getvalue(kray25_c_cstocvar);
			kray25_v_cstocmin = getvalue(kray25_c_cstocmin);
			kray25_v_cstocmax = getvalue(kray25_c_cstocmax);

			//1804 settings block
			kray25_v_aatype = getvalue(kray25_c_aatype);
			kray25_v_aafscreen = getvalue(kray25_c_aafscreen);
			kray25_v_aargsmpl = getvalue(kray25_c_aargsmpl);
			kray25_v_aagridrotate = getvalue(kray25_c_aagridrotate);

			//1903 settings block
			kray25_v_refth = getvalue(kray25_c_refth);
			kray25_v_refrmin = getvalue(kray25_c_refrmin);
			kray25_v_refrmax = getvalue(kray25_c_refrmax);

			//2101 settings block
			kray25_v_autolumi = getvalue(kray25_c_autolumi);

			//2601 settings block
			kray25_v_conetoarea = getvalue(kray25_c_conetoarea);

			//2707 settings block
			kray25_v_edgeabs = getvalue(kray25_c_edgeabs);
			kray25_v_edgerel = getvalue(kray25_c_edgerel);
			kray25_v_edgenorm = getvalue(kray25_c_edgenorm);
			kray25_v_edgezbuf = getvalue(kray25_c_edgezbuf);
			kray25_v_edgeup = getvalue(kray25_c_edgeup);
			kray25_v_edgethick = getvalue(kray25_c_edgethick);
			kray25_v_edgeover = getvalue(kray25_c_edgeover);

			//2802 settings block
			kray25_v_pxlfltr = getvalue(kray25_c_pxlfltr);
			kray25_v_pxlparam = getvalue(kray25_c_pxlparam);

			//2901 settings block
			kray25_v_refacth = getvalue(kray25_c_refacth);

			//3004 settings block
			kray25_v_tmo = getvalue(kray25_c_tmo);
			kray25_v_tmhsv = getvalue(kray25_c_tmhsv);
			kray25_v_outparam = getvalue(kray25_c_outparam);
			kray25_v_outexp = getvalue(kray25_c_outexp);

			//3101 settings block
			kray25_v_aarandsmpl = getvalue(kray25_c_aarandsmpl);

			//3207 settings block
			kray25_v_shgi = getvalue(kray25_c_shgi);
			kray25_v_ginew = getvalue(kray25_c_ginew);
			kray25_v_tiphotons = getvalue(kray25_c_tiphotons);
			kray25_v_tifg = getvalue(kray25_c_tifg);
			kray25_v_tiframes = getvalue(kray25_c_tiframes);
			kray25_v_tiextinction = getvalue(kray25_c_tiextinction);

			//3701 settings block
			kray25_v_cmbsubframes = getvalue(kray25_c_cmbsubframes);

			//3801 settings block
			kray25_v_refmodel = getvalue(kray25_c_refmodel);

			//4001 settings block
			kray25_v_octdepth = getvalue(kray25_c_octdepth);

			//4101 settings block
			kray25_v_output_On = getvalue(kray25_c_output_On);

			//4101 settings block
			kray25_v_errode = getvalue(kray25_c_errode);

			//4303 settings block
			kray25_v_eyesep = getvalue(kray25_c_eyesep);
			kray25_v_stereoimages = getvalue(kray25_c_stereoimages);
			kray25_v_render0 = getvalue(kray25_c_render0);

			//4411 settings block
			kray25_v_LogOn = getvalue(kray25_c_LogOn);
			kray25_v_Debug = getvalue(kray25_c_Debug);
			kray25_v_InfoOn = getvalue(kray25_c_InfoOn);
			kray25_v_IncludeOn = getvalue(kray25_c_IncludeOn);
			kray25_v_FullPrev = getvalue(kray25_c_FullPrev);
			kray25_v_Finishclose = getvalue(kray25_c_Finishclose);
			kray25_v_UBRAGI = getvalue(kray25_c_UBRAGI);
			kray25_v_outputtolw = getvalue(kray25_c_outputtolw);

			//3901 settings block
			create_flag  = create_flag; // JUST TO TRACK THIS INTO THE OVERRIDE.

			//4301 settings block
			kray25_v_outfmt = getvalue(kray25_c_outfmt);

			//100601
			kray25_v_girauto = getvalue(kray25_c_girauto);

			//100001 settings block
			kray25_v_gir = getvalue(kray25_c_gir);

			//100105 settings block
			kray25_v_cf = getvalue(kray25_c_cf);
			kray25_v_cn = getvalue(kray25_c_cn);
			kray25_v_cpstart = getvalue(kray25_c_cpstart);
			kray25_v_cpstop = getvalue(kray25_c_cpstop);
			kray25_v_cpstep = getvalue(kray25_c_cpstep);

			//100704 settings block
			kray25_v_cmatic = getvalue(kray25_c_cmatic);
			kray25_v_clow = getvalue(kray25_c_clow);
			kray25_v_chigh = getvalue(kray25_c_chigh);
			kray25_v_cdyn = getvalue(kray25_c_cdyn);

			//100205 settings block
			kray25_v_gf = getvalue(kray25_c_gf);
			kray25_v_gn = getvalue(kray25_c_gn);
			kray25_v_gpstart = getvalue(kray25_c_gpstart);
			kray25_v_gpstop = getvalue(kray25_c_gpstop);
			kray25_v_gpstep = getvalue(kray25_c_gpstep);

			//100804 settings block
			kray25_v_gmatic = getvalue(kray25_c_gmatic);
			kray25_v_glow = getvalue(kray25_c_glow);
			kray25_v_ghigh = getvalue(kray25_c_ghigh);
			kray25_v_gdyn = getvalue(kray25_c_gdyn);

			//100301 settings block
			kray25_v_ppsize = getvalue(kray25_c_ppsize);

			//100405 settings block
			kray25_v_fgmin = getvalue(kray25_c_fgmin);
			kray25_v_fgmax = getvalue(kray25_c_fgmax);
			kray25_v_fgscale = getvalue(kray25_c_fgscale);
			kray25_v_fgshows = getvalue(kray25_c_fgshows);
			kray25_v_fgsclr = getvalue(kray25_c_fgsclr); // COLOR

			//100502 settings block
			kray25_v_cornerdist = getvalue(kray25_c_cornerdist);
			kray25_v_cornerpaths = getvalue(kray25_c_cornerpaths);

			//100901 settings block
			kray25_v_cfunit = getvalue(kray25_c_cfunit);

			//101001 settings block
			kray25_v_gfunit = getvalue(kray25_c_gfunit);

			//101102 settings block
			kray25_v_fgreflections = getvalue(kray25_c_fgreflections);
			kray25_v_fgrefractions = getvalue(kray25_c_fgrefractions);

			//101201 settings block
			kray25_v_gmode = getvalue(kray25_c_gmode);

			//101301 settings block
			kray25_v_ppcaustics = getvalue(kray25_c_ppcaustics);

			//101403 settings block
			kray25_v_fgrmin = getvalue(kray25_c_fgrmin);
			kray25_v_fgrmax = getvalue(kray25_c_fgrmax);
			kray25_v_fgth = getvalue(kray25_c_fgth);

			//101502 settings block
			kray25_v_fga = getvalue(kray25_c_fga);
			kray25_v_fgb = getvalue(kray25_c_fgb);// ANGLE

			//101601 settings block
			kray25_v_ppmult = getvalue(kray25_c_ppmult);

			//101701 settings block
			kray25_v_cmult = getvalue(kray25_c_cmult);

			//101801 settings block
			kray25_v_ppblur = getvalue(kray25_c_ppblur);

			//101901 settings block
			kray25_v_fgblur = getvalue(kray25_c_fgblur);

			//102001 settings block
			kray25_v_showphotons = getvalue(kray25_c_showphotons);

			//102201 settings block
			kray25_v_resetoct = getvalue(kray25_c_resetoct);

			//102301 settings block
			kray25_v_limitdr = getvalue(kray25_c_limitdr);

			//102403 settings block
			kray25_v_prestep = getvalue(kray25_c_prestep);
			kray25_v_preSplDet = getvalue(kray25_c_preSplDet);
			kray25_v_gradNeighbour = getvalue(kray25_c_gradNeighbour);

			if(!passCamIDArray)
			{
				activeCameraID            = 0;
			} else {
				activeCameraID            = passCamIDArray[getvalue(kray25_c90)]; // Offset as UI is 0-based; array is 1-based.
			}

			redirectBuffersSetts = getvalue(kray25_c90_1);

			newNumber = sel;
			if(action == "new")
			{
				::pass = ::currentChosenPass;
				if(::overrideNames[1] != "empty")
				{
					newNumber = size(::overrideNames) + 1;
				}
				else
				{
					newNumber = 1;
				}
				::passOverrideItems[::pass][newNumber] = "";
				for(y = 1; y <= size(::passNames); y++)
				{
					::passOverrideItems[y][newNumber] = "";
				}
			}
			kray25_debug = 0;
			::overrideNames[newNumber] = newName + "   (scene properties)";
			::overrideSettings[newNumber] = newName + "||" + "type6" + "||" + string(::overrideRenderer) + "||"
										+ string(kray25_v_gph_preset) + "||" + string(kray25_v_cph_preset) + "||"
										+ string(kray25_v_fg_preset) + "||" + string(kray25_v_aa_preset) + "||"
										+ string(kray25_v_quality_preset) + "||";
			if (kray25_debug == 1)
			{
				logger("log_info", ::overrideSettings[newNumber]);
			}

			//104 settings block
			::overrideSettings[newNumber] += string(kray25_v_gi) + "||" + string(kray25_v_gicaustics) + "||"
										  + string(kray25_v_giirrgrad) + "||" + string(kray25_v_gipmmode) + "||";
			if (kray25_debug == 1)
			{
				logger("log_info", ::overrideSettings[newNumber]);
			}

			//2301 settings block
			::overrideSettings[newNumber] += string(kray25_v_girtdirect) + "||";
			if (kray25_debug == 1)
			{
				logger("log_info", ::overrideSettings[newNumber]);
			}

			//201 settings block
			::overrideSettings[newNumber] += string(kray25_v_lg) + "||";
			if (kray25_debug == 1)
			{
				logger("log_info", ::overrideSettings[newNumber]);
			}

			//301 settings block
			::overrideSettings[newNumber] += string(kray25_v_pl) + "||";
			if (kray25_debug == 1)
			{
				logger("log_info", ::overrideSettings[newNumber]);
			}

			//602 settings block
			::overrideSettings[newNumber] += string(kray25_v_prep) + "||" + string(kray25_v_pxlordr) + "||";
			if (kray25_debug == 1)
			{
				logger("log_info", ::overrideSettings[newNumber]);
			}

			//702 settings block
			::overrideSettings[newNumber] += string(kray25_v_underf) + "||" + string(kray25_v_undert) + "||";
			if (kray25_debug == 1)
			{
				logger("log_info", ::overrideSettings[newNumber]);
			}

			//802 settings block
			::overrideSettings[newNumber] += string(kray25_v_areavis) + "||" + string(kray25_v_areaside) + "||";
			if (kray25_debug == 1)
			{
				logger("log_info", ::overrideSettings[newNumber]);
			}

			//1003 settings block
			::overrideSettings[newNumber] += string(kray25_v_planth) + "||" + string(kray25_v_planrmin) + "||" 
										  + string(kray25_v_planrmax) + "||";
			if (kray25_debug == 1)
			{
				logger("log_info", ::overrideSettings[newNumber]);
			}

			//2103 settings block
			::overrideSettings[newNumber] += string(kray25_v_llinth) + "||" + string(kray25_v_llinrmin) + "||" 
										  + string(kray25_v_llinrmax) + "||";
			if (kray25_debug == 1)
			{
				logger("log_info", ::overrideSettings[newNumber]);
			}

			// 1103 block
			::overrideSettings[newNumber] += string(kray25_v_lumith) + "||" + string(kray25_v_lumirmin) + "||" 
										  + string(kray25_v_lumirmax) + "||";
			if (kray25_debug == 1)
			{
				logger("log_info", ::overrideSettings[newNumber]);
			}

			// 2402 settings block
			::overrideSettings[newNumber] += string(kray25_v_camobject) + "||" + string(kray25_v_camuvname) + "||";
			if (kray25_debug == 1)
			{
				logger("log_info", ::overrideSettings[newNumber]);
			}

			// 1301 settings block
			::overrideSettings[newNumber] += string(kray25_v_cptype) + "||";
			if (kray25_debug == 1)
			{
				logger("log_info", ::overrideSettings[newNumber]);
			}

			// 1401 settings block
			::overrideSettings[newNumber] += string(kray25_v_lenspict) + "||";
			if (kray25_debug == 1)
			{
				logger("log_info", ::overrideSettings[newNumber]);
			}

			// 1501 settings block
			::overrideSettings[newNumber] += string(kray25_v_dofobj) + "||";
			if (kray25_debug == 1)
			{
				logger("log_info", ::overrideSettings[newNumber]);
			}

			// 1603 settings block
			::overrideSettings[newNumber] += string(kray25_v_cstocvar) + "||" + string(kray25_v_cstocmin) + "||" 
										  + string(kray25_v_cstocmax) + "||";
			if (kray25_debug == 1)
			{
				logger("log_info", ::overrideSettings[newNumber]);
			}

			// 1804 settings block
			::overrideSettings[newNumber] += string(kray25_v_aatype) + "||" + string(kray25_v_aafscreen) + "||" 
										  + string(kray25_v_aargsmpl) + "||" + string(kray25_v_aagridrotate) + "||";
			if (kray25_debug == 1)
			{
				logger("log_info", ::overrideSettings[newNumber]);
			}

			// 1903 settings block
			::overrideSettings[newNumber] += string(kray25_v_refth) + "||" + string(kray25_v_refrmin) + "||" 
										  + string(kray25_v_refrmax) + "||";
			if (kray25_debug == 1)
			{
				logger("log_info", ::overrideSettings[newNumber]);
			}

			// 2101 settings block
			::overrideSettings[newNumber] += string(kray25_v_autolumi) + "||";
			if (kray25_debug == 1)
			{
				logger("log_info", ::overrideSettings[newNumber]);
			}

			// 2601 settings block
			::overrideSettings[newNumber] += string(kray25_v_conetoarea) + "||";
			if (kray25_debug == 1)
			{
				logger("log_info", ::overrideSettings[newNumber]);
			}

			// 2707 settings block
			::overrideSettings[newNumber] += string(kray25_v_edgeabs) + "||" + string(kray25_v_edgerel) + "||" 
										  + string(kray25_v_edgenorm) + "||" + string(kray25_v_edgezbuf) + "||" 
										  + string(kray25_v_edgeup) + "||" + string(kray25_v_edgethick) + "||" 
										  + string(kray25_v_edgeover) + "||";
			if (kray25_debug == 1)
			{
				logger("log_info", ::overrideSettings[newNumber]);
			}

			// 2802 settings block
			::overrideSettings[newNumber] += string(kray25_v_pxlfltr) + "||" + string(kray25_v_pxlparam) + "||";
			if (kray25_debug == 1)
			{
				logger("log_info", ::overrideSettings[newNumber]);
			}

			// 2901 settings block
			::overrideSettings[newNumber] += string(kray25_v_refacth) + "||";
			if (kray25_debug == 1)
			{
				logger("log_info", ::overrideSettings[newNumber]);
			}

			// 3004 settings block
			::overrideSettings[newNumber] += string(kray25_v_tmo) + "||" + string(kray25_v_tmhsv) + "||" 
										  + string(kray25_v_outparam) + "||" + string(kray25_v_outexp) + "||";
			if (kray25_debug == 1)
			{
				logger("log_info", ::overrideSettings[newNumber]);
			}

			// 3101 settings block
			::overrideSettings[newNumber] += string(kray25_v_aarandsmpl) + "||";
			if (kray25_debug == 1)
			{
				logger("log_info", ::overrideSettings[newNumber]);
			}

			// 3207 settings block
			::overrideSettings[newNumber] += string(kray25_v_shgi) + "||" + string(kray25_v_ginew) + "||" 
										  + string(kray25_v_tiphotons) + "||" + string(kray25_v_tifg) + "||" 
										  + string(kray25_v_tiframes) + "||" + string(kray25_v_tiextinction) + "||";
			if (kray25_debug == 1)
			{
				logger("log_info", ::overrideSettings[newNumber]);
			}

			// 3701 settings block
			::overrideSettings[newNumber] += string(kray25_v_cmbsubframes) + "||";
			if (kray25_debug == 1)
			{
				logger("log_info", ::overrideSettings[newNumber]);
			}

			// 3801 settings block
			::overrideSettings[newNumber] += string(kray25_v_refmodel) + "||";
			if (kray25_debug == 1)
			{
				logger("log_info", ::overrideSettings[newNumber]);
			}

			// 4001 settings block
			::overrideSettings[newNumber] += string(kray25_v_octdepth) + "||";
			if (kray25_debug == 1)
			{
				logger("log_info", ::overrideSettings[newNumber]);
			}

			// 4101 settings block
			::overrideSettings[newNumber] += string(kray25_v_output_On) + "||";
			if (kray25_debug == 1)
			{
				logger("log_info", ::overrideSettings[newNumber]);
			}

			// 4101 settings block
			::overrideSettings[newNumber] += string(kray25_v_errode) + "||";
			if (kray25_debug == 1)
			{
				logger("log_info", ::overrideSettings[newNumber]);
			}

			// 4303 settings block
			::overrideSettings[newNumber] += string(kray25_v_eyesep) + "||" + string(kray25_v_stereoimages) + "||" 
										  + string(kray25_v_render0) + "||";
			if (kray25_debug == 1)
			{
				logger("log_info", ::overrideSettings[newNumber]);
			}

			// 4411 settings block
			::overrideSettings[newNumber] += string(kray25_v_LogOn) + "||" + string(kray25_v_Debug) + "||" 
										  + string(kray25_v_InfoOn) + "||" + string(kray25_v_IncludeOn) + "||" 
										  + string(kray25_v_FullPrev) + "||" + string(kray25_v_Finishclose) + "||"
										  + string(kray25_v_UBRAGI) + "||" + string(kray25_v_outputtolw) + "||";
			if (kray25_debug == 1)
			{
				logger("log_info", ::overrideSettings[newNumber]);
			}

			// 3901 settings block
			::overrideSettings[newNumber] += string(create_flag) + "||"; // JUST TO TRACK THIS INTO THE OVERRIDE.
			if (kray25_debug == 1)
			{
				logger("log_info", ::overrideSettings[newNumber]);
			}

			// 4301 settings block
			::overrideSettings[newNumber] += string(kray25_v_outfmt) + "||";
			if (kray25_debug == 1)
			{
				logger("log_info", ::overrideSettings[newNumber]);
			}

			// 100601
			::overrideSettings[newNumber] += string(kray25_v_girauto) + "||";
			if (kray25_debug == 1)
			{
				logger("log_info", ::overrideSettings[newNumber]);
			}

			// 100001 settings block
			::overrideSettings[newNumber] += string(kray25_v_gir) + "||";
			if (kray25_debug == 1)
			{
				logger("log_info", ::overrideSettings[newNumber]);
			}

			// 100105 settings block
			::overrideSettings[newNumber] += string(kray25_v_cf) + "||" + string(kray25_v_cn) + "||" 
										  + string(kray25_v_cpstart) + "||" + string(kray25_v_cpstop) + "||" 
										  + string(kray25_v_cpstep) + "||";
			if (kray25_debug == 1)
			{
				logger("log_info", ::overrideSettings[newNumber]);
			}

			// 100704 settings block
			::overrideSettings[newNumber] += string(kray25_v_cmatic) + "||" + string(kray25_v_clow) + "||" 
										  + string(kray25_v_chigh) + "||" + string(kray25_v_cdyn) + "||";
			if (kray25_debug == 1)
			{
				logger("log_info", ::overrideSettings[newNumber]);
			}
	
			//100205 settings block
			::overrideSettings[newNumber] += string(kray25_v_gf) + "||" + string(kray25_v_gn) + "||" 
										  + string(kray25_v_gpstart) + "||" + string(kray25_v_gpstop) + "||" 
										  + string(kray25_v_gpstep) + "||";
			if (kray25_debug == 1)
			{
				logger("log_info", ::overrideSettings[newNumber]);
			}
			//100804 settings block
			::overrideSettings[newNumber] += string(kray25_v_gmatic) + "||" + string(kray25_v_glow) + "||" 
										  + string(kray25_v_ghigh) + "||" + string(kray25_v_gdyn) + "||";
			if (kray25_debug == 1)
			{
				logger("log_info", ::overrideSettings[newNumber]);
			}

			//100301 settings block
			::overrideSettings[newNumber] += string(kray25_v_ppsize) + "||";
			if (kray25_debug == 1)
			{
				logger("log_info", ::overrideSettings[newNumber]);
			}

			//100405 settings block
			::overrideSettings[newNumber] += string(kray25_v_fgmin) + "||" + string(kray25_v_fgmax) + "||" 
										  + string(kray25_v_fgscale) + "||" + string(kray25_v_fgshows) + "||" 
										  + string(kray25_v_fgsclr.x) + " " +  string(kray25_v_fgsclr.y) + " " + string(kray25_v_fgsclr.z) /*COLOR*/ + "||";
			if (kray25_debug == 1)
			{
				logger("log_info", ::overrideSettings[newNumber]);
			}

			//100502 settings block
			::overrideSettings[newNumber] += string(kray25_v_cornerdist) + "||" + string(kray25_v_cornerpaths) + "||";
			if (kray25_debug == 1)
			{
				logger("log_info", ::overrideSettings[newNumber]);
			}

			//100901 settings block
			::overrideSettings[newNumber] += string(kray25_v_cfunit) + "||";
			if (kray25_debug == 1)
			{
				logger("log_info", ::overrideSettings[newNumber]);
			}

			//101001 settings block
			::overrideSettings[newNumber] += string(kray25_v_gfunit) + "||";
			if (kray25_debug == 1)
			{
				logger("log_info", ::overrideSettings[newNumber]);
			}

			//101102 settings block
			::overrideSettings[newNumber] += string(kray25_v_fgreflections) + "||" + string(kray25_v_fgrefractions) + "||";
			if (kray25_debug == 1)
			{
				logger("log_info", ::overrideSettings[newNumber]);
			}

			//101201 settings block
			::overrideSettings[newNumber] += string(kray25_v_gmode) + "||";
			if (kray25_debug == 1)
			{
				logger("log_info", ::overrideSettings[newNumber]);
			}

			//101301 settings block
			::overrideSettings[newNumber] += string(kray25_v_ppcaustics) + "||";
			if (kray25_debug == 1)
			{
				logger("log_info", ::overrideSettings[newNumber]);
			}

			//101403 settings block
			::overrideSettings[newNumber] += string(kray25_v_fgrmin) + "||" + string(kray25_v_fgrmax) + "||" 
										  + string(kray25_v_fgth) + "||";
			if (kray25_debug == 1)
			{
				logger("log_info", ::overrideSettings[newNumber]);
			}

			//101502 settings block
			::overrideSettings[newNumber] += string(kray25_v_fga) + "||" + string(kray25_v_fgb) + "||";
			if (kray25_debug == 1)
			{
				logger("log_info", ::overrideSettings[newNumber]);
			}

			//101601 settings block
			::overrideSettings[newNumber] += string(kray25_v_ppmult) + "||";
			if (kray25_debug == 1)
			{
				logger("log_info", ::overrideSettings[newNumber]);
			}

			//101701 settings block
			::overrideSettings[newNumber] += string(kray25_v_cmult) + "||";
			if (kray25_debug == 1)
			{
				logger("log_info", ::overrideSettings[newNumber]);
			}

			//101801 settings block
			::overrideSettings[newNumber] += string(kray25_v_ppblur) + "||";
			if (kray25_debug == 1)
			{
				logger("log_info", ::overrideSettings[newNumber]);
			}

			//101901 settings block
			::overrideSettings[newNumber] += string(kray25_v_fgblur) + "||";
			if (kray25_debug == 1)
			{
				logger("log_info", ::overrideSettings[newNumber]);
			}

			//102001 settings block
			::overrideSettings[newNumber] += string(kray25_v_showphotons) + "||";
			if (kray25_debug == 1)
			{
				logger("log_info", ::overrideSettings[newNumber]);
			}

			//102201 settings block
			::overrideSettings[newNumber] += string(kray25_v_resetoct) + "||";
			if (kray25_debug == 1)
			{
				logger("log_info", ::overrideSettings[newNumber]);
			}

			//102301 settings block
			::overrideSettings[newNumber] += string(kray25_v_limitdr) + "||";
			if (kray25_debug == 1)
			{
				logger("log_info", ::overrideSettings[newNumber]);
			}

			//102403 settings block
			::overrideSettings[newNumber] += string(kray25_v_prestep) + "||" + string(kray25_v_preSplDet) + "||" 
										  + string(kray25_v_gradNeighbour) + "||";
			if (kray25_debug == 1)
			{
				logger("log_info", ::overrideSettings[newNumber]);
			}

			::overrideSettings[newNumber] += string(activeCameraID) + "||";
			if (kray25_debug == 1)
			{
				logger("log_info", ::overrideSettings[newNumber]);
			}

			::overrideSettings[newNumber] += string(redirectBuffersSetts);
			if (kray25_debug == 1)
			{
				logger("log_info", ::overrideSettings[newNumber]);
			}

			// Now start appending plugin settings.
			// Physical sky.
@if Kray_PS
			::overrideSettings[newNumber] += "||" + scnGen_kray25_PhySky_Values();
			if (kray25_debug == 1)
			{
				logger("log_info", ::overrideSettings[newNumber]);
			}
@end
@if Kray_QuickLWF
			::overrideSettings[newNumber] += "||" + scnGen_kray25_QuickLWF_Values();
			if (kray25_debug == 1)
			{
				logger("log_info", ::overrideSettings[newNumber]);
			}
@end
@if Kray_ToneMap
			::overrideSettings[newNumber] += "||" + scnGen_kray25_ToneMap_Values();
			if (kray25_debug == 1)
			{
				logger("log_info", ::overrideSettings[newNumber]);
			}
@end
		}
		reqend();
	} else {
		logger("error", "scnmasterOverride_UI_kray25: incorrect, or no, action passed");
	}
}

// Custom re-draw, taken from Kray.ls and renamed to avoid conflicts
// Redraw custom drawing on requester
scnGen_kray25_req_redraw
{
	// User Interface Layout Variables

	kray25_modal            = 0;

	kray25_gad_x            = 0;                                              // Gadget X coord
	kray25_gad_y            = 24;                                             // Gadget Y coord
	kray25_gad_w            = 260;                                            // Gadget width
	kray25_gad_h            = 19;                                             // Gadget height
	kray25_gad_text_offset  = 100;                                            // Gadget text offset
	kray25_gad_prekray25_v_w       = 0;                                              // Previous gadget width temp variable

	kray25_ui_window_w      = 440;                                            // Window width
	kray25_ui_window_h      = 610 + kray25_modal * 40;                        // Window height
	kray25_ui_banner_height = 0;                                             // Height of banner graphic
	kray25_ui_spacing       = 3;                                              // Spacing gap size

	kray25_ui_offset_x      = 0;                                              // Main X offset from 0
	kray25_ui_offset_y      = kray25_ui_banner_height+(kray25_ui_spacing*2);  // Main Y offset from 0
	kray25_ui_row           = 0;                                              // Row number
	kray25_ui_column        = 0;                                              // Column number
	kray25_ui_tab_offset    = kray25_ui_offset_y + 23;                        // Offset for tab height
	kray25_ui_seperator_w   = kray25_ui_window_w + 2;                         // Width of seperators
	kray25_ui_row_offset    = kray25_gad_h + kray25_ui_spacing;               // Row offset

	kray25_ui_tab_bottom    = kray25_ui_offset_y + kray25_ui_row_offset + kray25_ui_spacing + kray25_gad_h - 1; // The bottom of the tab gadgets
	kray25_gad_x2           = (kray25_ui_window_w / 3) + kray25_gad_x;        // Gadget X coord2

	// Draw line underneath tabs (UI beautification!)
	drawline(<060,061,063>, 0, kray25_ui_tab_bottom, kray25_ui_window_w, kray25_ui_tab_bottom);
}
