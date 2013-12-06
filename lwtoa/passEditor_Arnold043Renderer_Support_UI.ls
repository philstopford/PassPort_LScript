scnmasterOverride_UI_arnold043: action
{
	// Kray UI variables, taken directly from Kray.ls and renamed to avoid conflicts.
	lwtoa043_modal              = 0;
	lwtoa043_gad_x              = 0;                                             		// Gadget X coord
	lwtoa043_gad_y              = 24;                                            		// Gadget Y coord
	lwtoa043_gad_w              = 260;                                           		// Gadget width
	lwtoa043_gad_h              = 19;                                            		// Gadget height
	lwtoa043_gad_text_offset    = 100;                                           		// Gadget text offset
	lwtoa043_gad_prev_w         = 0;                                             		// Previous gadget width temp variable
	lwtoa043_ui_window_w        = 470;                                           		// Window width
	lwtoa043_ui_window_h        = 870;						                       		// Window height
	lwtoa043_ui_spacing         = 3;                                             		// Spacing gap size
	lwtoa043_ui_sep_spacing     = 13;                                            		// Spacing for the seperators (with text labels)
	lwtoa043_ui_offset_x        = 0;                                             		// Main X offset from 0
	lwtoa043_ui_row_offset      = lwtoa043_gad_h + lwtoa043_ui_spacing;              	// Row offset
	lwtoa043_ui_offset_y        = lwtoa043_ui_row_offset + lwtoa043_ui_spacing;
	lwtoa043_ui_row             = 0;                                             		// Row number
	lwtoa043_ui_column          = 0;                                             		// Column number
	lwtoa043_ui_tabrow_width	= lwtoa043_ui_window_w - 2*(lwtoa043_ui_offset_x);		// Tab row width
	lwtoa043_ui_tab_offset      = lwtoa043_ui_offset_y + 11;                       		// Offset for tab height
	lwtoa043_ui_seperator_w     = lwtoa043_ui_window_w + 2;                        		// Width of seperators
	lwtoa043_ui_tab_bottom      = lwtoa043_ui_offset_y + lwtoa043_ui_row_offset + lwtoa043_ui_spacing + lwtoa043_gad_h; // The bottom of the tab gadgets
	buttonWidth = 212;
	lwtoa043_gad_wc = (lwtoa043_ui_window_w - buttonWidth - lwtoa043_ui_spacing)/2;

	lwtoa043_gad_x2             = (lwtoa043_ui_window_w / 2) + lwtoa043_gad_x;        // Gadget X coord2

	// sel only used in edit action.
	// action should be either 'new' or 'edit'
	if (action == "new" || action == "edit")
	{
		if(action == "edit")
		{
			sel = getvalue(gad_OverridesListview).asInt();
			::settingsArray = parseOverrideSettings(::overrideSettings[sel]);
			settingIndex = 3;
			::overrideRenderer  = integer(::settingsArray[settingIndex]);
			settingIndex++;

			activeCameraID = number(::settingsArray[settingIndex]);
			settingIndex++;

			redirectBuffersSetts  = integer(::settingsArray[settingIndex]);
			settingIndex++;

			lwtoa043_arnoldMajor = integer(::settingsArray[settingIndex]);
			settingIndex++;

			lwtoa043_arnoldMinor = integer(::settingsArray[settingIndex]);
			settingIndex++;

			lwtoa043_arnoldPatch = integer(::settingsArray[settingIndex]);
			settingIndex++;

			// Main arnold parameters
			lwtoa043_ai_mt_auto = integer(::settingsArray[settingIndex]); 				// multithread auto
			settingIndex++;
			lwtoa043_ai_mt_num = integer(::settingsArray[settingIndex]);				// number of threads
			settingIndex++;
			lwtoa043_ai_scan_mode = integer(::settingsArray[settingIndex]);			// buckets scanning mode
			settingIndex++;
			lwtoa043_ai_prog_sampling = integer(::settingsArray[settingIndex]);		// progressive sampling in preview
			settingIndex++;

			lwtoa043_ai_bx = integer(::settingsArray[settingIndex]);					// buckets size
			settingIndex++;
			lwtoa043_ai_license_skip = integer(::settingsArray[settingIndex]);			// skip license search
			settingIndex++;

			// Sampling parameters
			lwtoa043_ai_aas = integer(::settingsArray[settingIndex]);					// antialiasing samples
			settingIndex++;
			lwtoa043_ai_ds = integer(::settingsArray[settingIndex]);					// diffuse samples
			settingIndex++;
			lwtoa043_ai_gs = integer(::settingsArray[settingIndex]);					// glossy samples
			settingIndex++;
			lwtoa043_ai_rs = integer(::settingsArray[settingIndex]);					// refraction samples
			settingIndex++;
			lwtoa043_ai_clamp = integer(::settingsArray[settingIndex]);				// clamp sample values.
			settingIndex++;
			lwtoa043_ai_clamp_max = integer(::settingsArray[settingIndex]);			// clamp max value
			settingIndex++;
			lwtoa043_ai_lock = integer(::settingsArray[settingIndex]);					// lock sampling noise
			settingIndex++;
			lwtoa043_ai_pf = integer(::settingsArray[settingIndex]);					// pixel filtering type
			settingIndex++;
			lwtoa043_ai_pw = integer(::settingsArray[settingIndex]);					// pixel filtering width
			settingIndex++;

			// Ray depth parameters
			lwtoa043_ai_rd_total = integer(::settingsArray[settingIndex]);				// ray depth total rays
			settingIndex++;
			lwtoa043_ai_rd_diffuse = integer(::settingsArray[settingIndex]);			// diffuse ray depth
			settingIndex++;
			lwtoa043_ai_rd_refl = integer(::settingsArray[settingIndex]);				// reflection ray depth
			settingIndex++;
			lwtoa043_ai_rd_refr = integer(::settingsArray[settingIndex]);				// refraction ray depth
			settingIndex++;
			lwtoa043_ai_rd_glossy = integer(::settingsArray[settingIndex]);			// glossy ray depth
			settingIndex++;

			// Motion blur parameters
			lwtoa043_ai_mb_def = integer(::settingsArray[settingIndex]);				// enable deformation blur
			settingIndex++;
			lwtoa043_ai_mb_duration = integer(::settingsArray[settingIndex]);			// frame duration
			settingIndex++;
			lwtoa043_ai_shutter_type = integer(::settingsArray[settingIndex]);			// shutter type
			settingIndex++;
			lwtoa043_ai_mb_deform_steps = integer(::settingsArray[settingIndex]);		// deformation blur steps
			settingIndex++;
			lwtoa043_ai_mb_apply_cam = integer(::settingsArray[settingIndex]);			// enable MB for camera
			settingIndex++;
			lwtoa043_ai_mb_apply_light = integer(::settingsArray[settingIndex]);		// enable MB for lights
			settingIndex++;
			lwtoa043_ai_mb_apply_obj = integer(::settingsArray[settingIndex]);			// enable MB for objects
			settingIndex++;
			lwtoa043_ai_mb_forceRefresh = integer(::settingsArray[settingIndex]);		// force full scene refresh for MB
			settingIndex++;

			// Depth of field parameters
			lwtoa043_ai_dof_aspect = integer(::settingsArray[settingIndex]);			// DOF aperture aspect ratio
			settingIndex++;
			lwtoa043_ai_dof_curvature = integer(::settingsArray[settingIndex]);		// DOF blades curvature
			settingIndex++;

			// Plugin instancing options
			lwtoa043_ai_instance_lwclones = integer(::settingsArray[settingIndex]);	// Flag to instance in arnold LW cloned object
			settingIndex++;
			lwtoa043_ai_instance_nulls = integer(::settingsArray[settingIndex]);		// Render NULLS that begin with "-" as instances
			settingIndex++;

			// .ass file options
			lwtoa043_ai_render_to_file = integer(::settingsArray[settingIndex]);							// Activate writting .ass files
			settingIndex++;
			lwtoa043_ai_filename = sanitizePath(string(::settingsArray[settingIndex]),0,0);				// Output path and filename of .ass
			settingIndex++;
			lwtoa043_ai_compress_file = integer(::settingsArray[settingIndex]);							// Compress .ass file to .gz
			settingIndex++;
			lwtoa043_ai_writenode_options = integer(::settingsArray[settingIndex]);						// Selective nodes to save in .ass file
			settingIndex++;
			lwtoa043_ai_writenode_drivers = integer(::settingsArray[settingIndex]);
			settingIndex++;
			lwtoa043_ai_writenode_geom = integer(::settingsArray[settingIndex]);
			settingIndex++;
			lwtoa043_ai_writenode_cam = integer(::settingsArray[settingIndex]);
			settingIndex++;
			lwtoa043_ai_writenode_lights = integer(::settingsArray[settingIndex]);
			settingIndex++;
			lwtoa043_ai_writenode_shaders = integer(::settingsArray[settingIndex]);
			settingIndex++;
			lwtoa043_ai_ass_binary = integer(::settingsArray[settingIndex]);			// Save the .ass file in binary encoding.
			settingIndex++;

			// Log and debug options
			lwtoa043_ai_log_console = integer(::settingsArray[settingIndex]);								// Open console to show log
			settingIndex++;
			lwtoa043_ai_log_write = integer(::settingsArray[settingIndex]);								// Write the log to a file
			settingIndex++;
			lwtoa043_ai_log_filename = sanitizePath(string(::settingsArray[settingIndex]),0,0);			// Log filename
			settingIndex++;
			lwtoa043_ai_log_level = integer(::settingsArray[settingIndex]);								// Log message level
			settingIndex++;
			lwtoa043_ai_log_max = integer(::settingsArray[settingIndex]);									// Max number of lines in log file
			settingIndex++;
			lwtoa043_ai_log_ipr_level = integer(::settingsArray[settingIndex]);							// IPR log level
			settingIndex++;

			// Arnold native texture mapping options
			lwtoa043_ai_tex_accept_nomipmap = integer(::settingsArray[settingIndex]);	// Texture system accept no mimpamed images flag
			settingIndex++;
			lwtoa043_ai_tex_automipmap = integer(::settingsArray[settingIndex]);		// Automipmap flag
			settingIndex++;
			lwtoa043_ai_tex_magfilter = integer(::settingsArray[settingIndex]);		// Texture magnification filter
			settingIndex++;
			lwtoa043_ai_tex_accept_untiled = integer(::settingsArray[settingIndex]);	// Accept untiled textures
			settingIndex++;
			lwtoa043_ai_tex_autotile = integer(::settingsArray[settingIndex]);			// Autotile flag
			settingIndex++;
			lwtoa043_ai_tex_tile_size = integer(::settingsArray[settingIndex]);		// Autotile tile size
			settingIndex++;
			lwtoa043_ai_tex_cache = integer(::settingsArray[settingIndex]);			// Enable texture cache
			settingIndex++;
			lwtoa043_ai_tex_cache_size = integer(::settingsArray[settingIndex]);		// Cache size in MB
			settingIndex++;
			lwtoa043_ai_tex_maxfiles = integer(::settingsArray[settingIndex]);			// Maximum open textures while rendering
			settingIndex++;

			// Misc. rendering options
			lwtoa043_ai_abort_lic_fail = integer(::settingsArray[settingIndex]);		// Abort render on license fail
			settingIndex++;
			lwtoa043_ai_sampling_mult = integer(::settingsArray[settingIndex]);		// Global sampling multiplier
			settingIndex++;
			lwtoa043_ai_light_sampling_mult = integer(::settingsArray[settingIndex]);	// Global light sampling multiplier
			settingIndex++;
			lwtoa043_ai_mult_factor = integer(::settingsArray[settingIndex]);
			settingIndex++;
			lwtoa043_ai_light_mult_factor = integer(::settingsArray[settingIndex]);
			settingIndex++;

			// System AOVs parameters
			lwtoa043_ai_sysaovs_enable = integer(::settingsArray[settingIndex]);		// Flag to enable rendering of system AOVs
			settingIndex++;
			lwtoa043_ai_sysaovs_display = integer(::settingsArray[settingIndex]);		// AOVs transfered to LW preview and render window
			settingIndex++;

			lwtoa043_ai_sysaovs_fileoptions_path = sanitizePath(string(::settingsArray[settingIndex]),0,0);
			settingIndex++;
			lwtoa043_ai_sysaovs_fileoptions_exr_compress = integer(::settingsArray[settingIndex]);
			settingIndex++;
			lwtoa043_ai_sysaovs_fileoptions_exr_half = integer(::settingsArray[settingIndex]);
			settingIndex++;
			lwtoa043_ai_sysaovs_fileoptions_exr_tiled = integer(::settingsArray[settingIndex]);
			settingIndex++;
			lwtoa043_ai_sysaovs_fileoptions_exr_preserve = integer(::settingsArray[settingIndex]);
			settingIndex++;
			lwtoa043_ai_sysaovs_fileoptions_tif_compress = integer(::settingsArray[settingIndex]);
			settingIndex++;
			lwtoa043_ai_sysaovs_fileoptions_tif_format = integer(::settingsArray[settingIndex]);
			settingIndex++;
			lwtoa043_ai_sysaovs_fileoptions_tif_tiled = integer(::settingsArray[settingIndex]);
			settingIndex++;
			lwtoa043_ai_sysaovs_fileoptions_tif_dither = integer(::settingsArray[settingIndex]);
			settingIndex++;
			lwtoa043_ai_sysaovs_fileoptions_pad1 = integer(::settingsArray[settingIndex]);
			settingIndex++;
			lwtoa043_ai_sysaovs_fileoptions_pad2 = integer(::settingsArray[settingIndex]);
			settingIndex++;
			lwtoa043_ai_sysaovs_fileoptions_pad3 = integer(::settingsArray[settingIndex]);
			settingIndex++;
			lwtoa043_ai_sysaovs_fileoptions_pad4 = integer(::settingsArray[settingIndex]);
			settingIndex++;

			// AOV blocks. We have arrays that are each 40 elements long.
			/* Match scene format :
					LWSAVE_I4( sState, &render->ai_sysaovs[xx].active, 1 );				// Enabled or disabled AOV
					LWSAVE_I4( sState, &render->ai_sysaovs[xx].type, 1 );				// AOV type
					LWSAVE_STR( sState, render->ai_sysaovs[xx].suf);					// AOV suffix
					LWSAVE_I4( sState, &render->ai_sysaovs[xx].filter, 1 );				// AOV filter
					LWSAVE_FP( sState, &render->ai_sysaovs[xx].gamma, 1 );				// AOV gamma
					LWSAVE_I4( sState, &render->ai_sysaovs[xx].file_format, 1 );		// AOV file format
					LWSAVE_I4( sState, &render->ai_sysaovs[xx].pad1, 1 );				// Not used
					LWSAVE_I4( sState, &render->ai_sysaovs[xx].pad2, 1 );				// Not used
					LWSAVE_I4( sState, &render->ai_sysaovs[xx].pad3, 1 );				// Not used
					LWSAVE_I4( sState, &render->ai_sysaovs[xx].pad4, 1 );				// Not used
			*/
			for (x = 1; x <= lwtoa043_MAX_SYS_AOVS; x++)
			{
				lwtoa043_ai_sysaovs_active[x] = integer(::settingsArray[settingIndex]);
				settingIndex++;
				lwtoa043_ai_sysaovs_type[x] = integer(::settingsArray[settingIndex]);
				settingIndex++;
				lwtoa043_ai_sysaovs_suf[x] = unquoteString(string(::settingsArray[settingIndex]));
				settingIndex++;
				lwtoa043_ai_sysaovs_filter[x] = integer(::settingsArray[settingIndex]);
				settingIndex++;
				lwtoa043_ai_sysaovs_gamma[x] = integer(::settingsArray[settingIndex]);
				settingIndex++;
				lwtoa043_ai_sysaovs_file_format[x] = integer(::settingsArray[settingIndex]);
				settingIndex++;
				lwtoa043_ai_sysaovs_pad1[x] = integer(::settingsArray[settingIndex]);
				settingIndex++;
				lwtoa043_ai_sysaovs_pad2[x] = integer(::settingsArray[settingIndex]);
				settingIndex++;
				lwtoa043_ai_sysaovs_pad3[x] = integer(::settingsArray[settingIndex]);
				settingIndex++;
				lwtoa043_ai_sysaovs_pad4[x] = integer(::settingsArray[settingIndex]);
				settingIndex++;
			}

			// Transparency options
			lwtoa043_ai_trans_depth = integer(::settingsArray[settingIndex]);
			settingIndex++;
			lwtoa043_ai_trans_mode = integer(::settingsArray[settingIndex]);
			settingIndex++;
			lwtoa043_ai_trans_threshold = number(::settingsArray[settingIndex]);
			settingIndex++;

			// Point cloud Subsurface Scattering options
			lwtoa043_ai_sss_spacing = number(::settingsArray[settingIndex]);
			settingIndex++;
			lwtoa043_ai_sss_distribution = integer(::settingsArray[settingIndex]);
			settingIndex++;
			lwtoa043_ai_sss_factor = integer(::settingsArray[settingIndex]);
			settingIndex++;
			lwtoa043_ai_sss_show = integer(::settingsArray[settingIndex]);
			settingIndex++;

			// Rendering ignore options
			lwtoa043_ai_ignore_textures = integer(::settingsArray[settingIndex]);
			settingIndex++;
			lwtoa043_ai_ignore_shaders = integer(::settingsArray[settingIndex]);
			settingIndex++;
			lwtoa043_ai_ignore_atmosphere = integer(::settingsArray[settingIndex]);
			settingIndex++;
			lwtoa043_ai_ignore_lights = integer(::settingsArray[settingIndex]);
			settingIndex++;
			lwtoa043_ai_ignore_shadows = integer(::settingsArray[settingIndex]);
			settingIndex++;
			lwtoa043_ai_ignore_subdivision = integer(::settingsArray[settingIndex]);
			settingIndex++;
			lwtoa043_ai_ignore_displacement = integer(::settingsArray[settingIndex]);
			settingIndex++;
			lwtoa043_ai_ignore_bump = integer(::settingsArray[settingIndex]);
			settingIndex++;
			lwtoa043_ai_ignore_motion_blur = integer(::settingsArray[settingIndex]);
			settingIndex++;
			lwtoa043_ai_ignore_smoothing = integer(::settingsArray[settingIndex]);
			settingIndex++;
			lwtoa043_ai_ignore_sss = integer(::settingsArray[settingIndex]);
			settingIndex++;
			lwtoa043_ai_ignore_direct_lighting = integer(::settingsArray[settingIndex]);
			settingIndex++;

			// Arnold camera options
			lwtoa043_ai_cam_type = integer(::settingsArray[settingIndex]);
			settingIndex++;
			lwtoa043_ai_cam_near = number(::settingsArray[settingIndex]);
			settingIndex++;
			lwtoa043_ai_cam_far = integer(::settingsArray[settingIndex]);
			settingIndex++;
			lwtoa043_ai_cam_fisheye_crop = integer(::settingsArray[settingIndex]);
			settingIndex++;
			lwtoa043_ai_cam_ortho_factor = integer(::settingsArray[settingIndex]);
			settingIndex++;

			lwtoa043_ai_mb_apply_psys = integer(::settingsArray[settingIndex]);
			settingIndex++;
			lwtoa043_ai_mb_psys_factor = integer(::settingsArray[settingIndex]);
			settingIndex++;

			lwtoa043_ai_background_visbility = integer(::settingsArray[settingIndex]);
			settingIndex++;

			lwtoa043_ai_log_sn_level = integer(::settingsArray[settingIndex]);
			settingIndex++;
			lwtoa043_ai_info_add = integer(::settingsArray[settingIndex]);
			settingIndex++;
			lwtoa043_ai_info_txt = unquoteString(string(::settingsArray[settingIndex]));
			settingIndex++;

			lwtoa043_ai_instance_lw11 = integer(::settingsArray[settingIndex]);
			settingIndex++;
			lwtoa043_ai_sds_max_level = integer(::settingsArray[settingIndex]);
			settingIndex++;

			lwtoa043_ai_shading_pass = integer(::settingsArray[settingIndex]);
			settingIndex++;
			for (x = 1; x <= lwtoa043_SHADING_PASSES; x++)
			{
				lwtoa043_shading_pass_names[x] = unquoteString(string(::settingsArray[settingIndex]));
				settingIndex++;
			}

			lwtoa043_ai_multithread_loading = integer(::settingsArray[settingIndex]);
			settingIndex++;

			lwtoa043_ai_aov_composition = integer(::settingsArray[settingIndex]);
			settingIndex++;
			lwtoa043_ai_ignore_mis = integer(::settingsArray[settingIndex]);
			settingIndex++;

			lwtoa043_ai_volumetric_type = integer(::settingsArray[settingIndex]); // 0->physicalSky, 1->LW fog, 2->Arnold fog, 3->volume scattering
			settingIndex++;

			lwtoa043_ai_cam_exposure = integer(::settingsArray[settingIndex]);
			settingIndex++;

			lwtoa043_ai_gamma_light = integer(::settingsArray[settingIndex]);
			settingIndex++;
			lwtoa043_ai_gamma_shader = integer(::settingsArray[settingIndex]);
			settingIndex++;
			lwtoa043_ai_gamma_texture = integer(::settingsArray[settingIndex]);
			settingIndex++;
			lwtoa043_ai_tex_diffuse_blur = number(::settingsArray[settingIndex]);
			settingIndex++;
			lwtoa043_ai_tex_glossy_blur = number(::settingsArray[settingIndex]);
			settingIndex++;

			lwtoa043_ai_low_light_threshold = number(::settingsArray[settingIndex]);
			settingIndex++;

			lwtoa043_ai_ignore_dof = integer(::settingsArray[settingIndex]);
			settingIndex++;
			lwtoa043_ai_sss_engine = integer(::settingsArray[settingIndex]);
			settingIndex++;
			lwtoa043_ai_sss_samples = integer(::settingsArray[settingIndex]);
			settingIndex++;

			lwtoa043_ai_clamp_aovs = integer(::settingsArray[settingIndex]);
			settingIndex++;
			lwtoa043_ai_nlights_heatmap = integer(::settingsArray[settingIndex]);
			settingIndex++;
			lwtoa043_ai_ignore_procedurals = integer(::settingsArray[settingIndex]);
			settingIndex++;

			lwtoa043_ai_procedural_path = sanitizePath(string(::settingsArray[settingIndex]),0,0);
			settingIndex++;
			lwtoa043_ai_texture_path = sanitizePath(string(::settingsArray[settingIndex]),0,0);
			settingIndex++;
			lwtoa043_ai_shader_path = sanitizePath(string(::settingsArray[settingIndex]),0,0);
			settingIndex++;

			lwtoa043_ai_log_frame_number = integer(::settingsArray[settingIndex]);
			settingIndex++;
			lwtoa043_ai_ipr_license_skip = integer(::settingsArray[settingIndex]);
			settingIndex++;
			lwtoa043_ai_texture_max_sharpen = integer(::settingsArray[settingIndex]);
			settingIndex++;
			lwtoa043_ai_shader_timing_stats = integer(::settingsArray[settingIndex]);
			settingIndex++;

			lwtoa043_ai_enable_multiple_uvmaps = integer(::settingsArray[settingIndex]);
			settingIndex++;
			lwtoa043_ai_rendering_mode = integer(::settingsArray[settingIndex]);
			settingIndex++;
			lwtoa043_ai_reload_lights = integer(::settingsArray[settingIndex]);
			settingIndex++;
			lwtoa043_ai_reload_materials = integer(::settingsArray[settingIndex]);
			settingIndex++;

			lwtoa043_ai_disable_rotational_mb = integer(::settingsArray[settingIndex]);
			settingIndex++;
			lwtoa043_ai_cam_rolling_shutter = integer(::settingsArray[settingIndex]);
			// settingIndex++;

		} else {
			lwtoa043_arnoldMajor = integer(lwtoa043_default_arnoldMajor);
			lwtoa043_arnoldMinor = integer(lwtoa043_default_arnoldMinor);
			lwtoa043_arnoldPatch = integer(lwtoa043_default_arnoldPatch);

			redirectBuffersSetts = 0;

			// Need to read in settings from the scene configuration? For now, we'll create default values. Taken directly from a virgin scene file saved with default settings.

			// Main arnold parameters
			lwtoa043_ai_mt_auto = 1; 			// multithread auto
			lwtoa043_ai_mt_num = 8; 				// number of threads
			lwtoa043_ai_scan_mode = 6; 			// buckets scanning mode
			lwtoa043_ai_prog_sampling = 0; 		// progressive sampling in preview

			lwtoa043_ai_bx = 64;					// buckets size
			lwtoa043_ai_license_skip = 1;		// skip license search

			// Sampling parameters
			lwtoa043_ai_aas = 3;					// antialiasing samples
			lwtoa043_ai_ds = 2;					// diffuse samples
			lwtoa043_ai_gs = 1;					// glossy samples
			lwtoa043_ai_rs = 1;					// refraction samples
			lwtoa043_ai_clamp = 0;				// clamp sample values.
			lwtoa043_ai_clamp_max = 2;			// clamp max value
			lwtoa043_ai_lock = 0;				// lock sampling noise
			lwtoa043_ai_pf = 7;					// pixel filtering type
			lwtoa043_ai_pw = 2;					// pixel filtering width

			// Ray depth parameters
			lwtoa043_ai_rd_total = 10;			// ray depth total rays
			lwtoa043_ai_rd_diffuse = 1;			// diffuse ray depth
			lwtoa043_ai_rd_refl = 1;				// reflection ray depth
			lwtoa043_ai_rd_refr = 1;				// refraction ray depth
			lwtoa043_ai_rd_glossy = 1;			// glossy ray depth

			// Motion blur parameters
			lwtoa043_ai_mb_def = 0;				// enable deformation blur
			lwtoa043_ai_mb_duration = 1;			// frame duration
			lwtoa043_ai_shutter_type = 0;		// shutter type
			lwtoa043_ai_mb_deform_steps = 2;		// deformation blur steps
			lwtoa043_ai_mb_apply_cam = 1;		// enable MB for camera
			lwtoa043_ai_mb_apply_light = 1;		// enable MB for lights
			lwtoa043_ai_mb_apply_obj = 1;		// enable MB for objects
			lwtoa043_ai_mb_forceRefresh = 0;		// force full scene refresh for MB

			// Depth of field parameters
			lwtoa043_ai_dof_aspect = 1;			// DOF aperture aspect ratio
			lwtoa043_ai_dof_curvature = 0;		// DOF blades curvature

			// Plugin instancing options
			lwtoa043_ai_instance_lwclones = 1;	// Flag to instance in arnold LW cloned object
			lwtoa043_ai_instance_nulls = 1;		// Render NULLS that begin with "-" as instances

			// .ass file options
			lwtoa043_ai_render_to_file = 0;				// Activate writting .ass files
			lwtoa043_ai_filename = "c:\\arnoldScene";	// Output path and filename of .ass
			lwtoa043_ai_compress_file = 0;				// Compress .ass file to .gz
			lwtoa043_ai_writenode_options = 1;			// Selective nodes to save in .ass file
			lwtoa043_ai_writenode_drivers = 1;
			lwtoa043_ai_writenode_geom = 1;
			lwtoa043_ai_writenode_cam = 1;
			lwtoa043_ai_writenode_lights = 1;
			lwtoa043_ai_writenode_shaders = 1;
			lwtoa043_ai_ass_binary = 1;					// Save the .ass file in binary encoding.

			// Log and debug options
			lwtoa043_ai_log_console = 0;						// Open console to show log
			lwtoa043_ai_log_write = 1;						// Write the log to a file
			lwtoa043_ai_log_filename = "c:\\arnold_info";	// Log filename
			lwtoa043_ai_log_level = 1;						// Log message level
			lwtoa043_ai_log_max = 5;							// Max number of lines in log file
			lwtoa043_ai_log_ipr_level = 1;					// IPR log level

			// Arnold native texture mapping options
			lwtoa043_ai_tex_accept_nomipmap = 1;	// Texture system accept no mimpamed images flag
			lwtoa043_ai_tex_automipmap = 1;		// Automipmap flag
			lwtoa043_ai_tex_magfilter = 1;		// Texture magnification filter
			lwtoa043_ai_tex_accept_untiled = 1;	// Accept untiled textures
			lwtoa043_ai_tex_autotile = 0;		// Autotile flag
			lwtoa043_ai_tex_tile_size = 64;		// Autotile tile size
			lwtoa043_ai_tex_cache = 0;			// Enable texture cache
			lwtoa043_ai_tex_cache_size = 512;		// Cache size in MB
			lwtoa043_ai_tex_maxfiles = 100;		// Maximum open textures while rendering

			// Misc. rendering options
			lwtoa043_ai_abort_lic_fail = 1;			// Abort render on license fail
			lwtoa043_ai_sampling_mult = 100;			// Global sampling multiplier
			lwtoa043_ai_light_sampling_mult = 100;	// Global light sampling multiplier
			lwtoa043_ai_mult_factor = 3;
			lwtoa043_ai_light_mult_factor = 3;

			// System AOVs parameters
			lwtoa043_ai_sysaovs_enable = 0;		// Flag to enable rendering of system AOVs
			lwtoa043_ai_sysaovs_display = 0;		// AOVs transfered to LW preview and render window

			lwtoa043_ai_sysaovs_fileoptions_path = "C:\\LWstuff\\Benchmark\\Images";
			lwtoa043_ai_sysaovs_fileoptions_exr_compress = 4;
			lwtoa043_ai_sysaovs_fileoptions_exr_half = 0;
			lwtoa043_ai_sysaovs_fileoptions_exr_tiled = 1;
			lwtoa043_ai_sysaovs_fileoptions_exr_preserve = 0;
			lwtoa043_ai_sysaovs_fileoptions_tif_compress = 1;
			lwtoa043_ai_sysaovs_fileoptions_tif_format = 0;
			lwtoa043_ai_sysaovs_fileoptions_tif_tiled = 1;
			lwtoa043_ai_sysaovs_fileoptions_tif_dither = 1;
			lwtoa043_ai_sysaovs_fileoptions_pad1 = 0;
			lwtoa043_ai_sysaovs_fileoptions_pad2 = 0;
			lwtoa043_ai_sysaovs_fileoptions_pad3 = 0;
			lwtoa043_ai_sysaovs_fileoptions_pad4 = 0;

			// AOV blocks. We have arrays that are each 40 elements long.
			for (x = 1; x <= lwtoa043_MAX_SYS_AOVS; x++)
			{
				lwtoa043_ai_sysaovs_active[x] = 0;
				lwtoa043_ai_sysaovs_pad1[x] = 0;
				lwtoa043_ai_sysaovs_pad2[x] = 0;
				lwtoa043_ai_sysaovs_pad3[x] = 0;
				lwtoa043_ai_sysaovs_pad4[x] = 0;
				lwtoa043_ai_sysaovs_gamma[x] = 1;
				lwtoa043_ai_sysaovs_file_format[x] = 0;
			}
			x = 1;
			/*
			lwtoa043_ai_sysaovs_type[x] = 	@0,					1,				2,				2,				1,			5,			2,			2,			4,		3,
							  	 	 4,					1,				1,				1,				1,			1,			1,			1,			1,		1,
							  	 	 1,					1,				1,				1@;
			lwtoa043_ai_sysaovs_suf[x] = 	@"rgba",			"rgb",			"a",			"z",			"opacity",	"id",		"cputime",	"raycount",	"p",	"n",
							  		 "mvector",			"dir_diff",		"dir_spec",		"emission",		"ind_diff",	"ind_spec", "reflect",	"refract",	"sss",	"skin_prim_spec",
							  		 "skin_sec_spec",	"skin_shallow",	"skin_mid",		"skin_deep"@;
			lwtoa043_ai_sysaovs_filter[x] = 	7,					7,				7,				12,				7,			12,			12,			12,			12,		12,
								 	12,					7,				7,				7,				7,			7,			7,			7,			7,		7,
								 	7,					7,				7,				7@;
			*/
			lwtoa043_ai_sysaovs_type[x] = 	0;
			lwtoa043_ai_sysaovs_suf[x] = 	"rgba";
			lwtoa043_ai_sysaovs_filter[x] = 	7;
			x++;
			lwtoa043_ai_sysaovs_type[x] = 	1;
			lwtoa043_ai_sysaovs_suf[x] = 	"rgb";
			lwtoa043_ai_sysaovs_filter[x] = 	7;
			x++;
			lwtoa043_ai_sysaovs_type[x] = 	2;
			lwtoa043_ai_sysaovs_suf[x] = 	"a";
			lwtoa043_ai_sysaovs_filter[x] = 	7;
			x++;
			lwtoa043_ai_sysaovs_type[x] = 	2;
			lwtoa043_ai_sysaovs_suf[x] = 	"z";
			lwtoa043_ai_sysaovs_filter[x] = 	12;
			x++;
			lwtoa043_ai_sysaovs_type[x] = 	1;
			lwtoa043_ai_sysaovs_suf[x] = 	"opacity";
			lwtoa043_ai_sysaovs_filter[x] = 	7;
			x++;
			lwtoa043_ai_sysaovs_type[x] = 	5;
			lwtoa043_ai_sysaovs_suf[x] = 	"id";
			lwtoa043_ai_sysaovs_filter[x] = 	12;
			x++;
			lwtoa043_ai_sysaovs_type[x] = 	2;
			lwtoa043_ai_sysaovs_suf[x] = 	"cputime";
			lwtoa043_ai_sysaovs_filter[x] = 	12;
			x++;
			lwtoa043_ai_sysaovs_type[x] = 	2;
			lwtoa043_ai_sysaovs_suf[x] = 	"raycount";
			lwtoa043_ai_sysaovs_filter[x] = 	12;
			x++;
			lwtoa043_ai_sysaovs_type[x] = 	4;
			lwtoa043_ai_sysaovs_suf[x] = 	"p";
			lwtoa043_ai_sysaovs_filter[x] = 	12;
			x++;
			lwtoa043_ai_sysaovs_type[x] = 	3;
			lwtoa043_ai_sysaovs_suf[x] = 	"n";
			lwtoa043_ai_sysaovs_filter[x] = 	12;
			x++;
			lwtoa043_ai_sysaovs_type[x] = 	4;
			lwtoa043_ai_sysaovs_suf[x] = 	"mvector";
			lwtoa043_ai_sysaovs_filter[x] = 	12;
			x++;
			lwtoa043_ai_sysaovs_type[x] = 	1;
			lwtoa043_ai_sysaovs_suf[x] = 	"dir_diff";
			lwtoa043_ai_sysaovs_filter[x] = 	7;
			x++;
			lwtoa043_ai_sysaovs_type[x] = 	1;
			lwtoa043_ai_sysaovs_suf[x] = 	"dir_spec";
			lwtoa043_ai_sysaovs_filter[x] = 	7;
			x++;
			lwtoa043_ai_sysaovs_type[x] = 	1;
			lwtoa043_ai_sysaovs_suf[x] = 	"emission";
			lwtoa043_ai_sysaovs_filter[x] = 	7;
			x++;
			lwtoa043_ai_sysaovs_type[x] = 	1;
			lwtoa043_ai_sysaovs_suf[x] = 	"ind_diff";
			lwtoa043_ai_sysaovs_filter[x] = 	7;
			x++;
			lwtoa043_ai_sysaovs_type[x] = 	1;
			lwtoa043_ai_sysaovs_suf[x] = 	"ind_spec";
			lwtoa043_ai_sysaovs_filter[x] = 	7;
			x++;
			lwtoa043_ai_sysaovs_type[x] = 	1;
			lwtoa043_ai_sysaovs_suf[x] = 	"reflect";
			lwtoa043_ai_sysaovs_filter[x] = 	7;
			x++;
			lwtoa043_ai_sysaovs_type[x] = 	1;
			lwtoa043_ai_sysaovs_suf[x] = 	"refract";
			lwtoa043_ai_sysaovs_filter[x] = 	7;
			x++;
			lwtoa043_ai_sysaovs_type[x] = 	1;
			lwtoa043_ai_sysaovs_suf[x] = 	"sss";
			lwtoa043_ai_sysaovs_filter[x] = 	7;
			x++;
			lwtoa043_ai_sysaovs_type[x] = 	1;
			lwtoa043_ai_sysaovs_suf[x] = 	"skin_prim_spec";
			lwtoa043_ai_sysaovs_filter[x] = 	7;
			x++;
			lwtoa043_ai_sysaovs_type[x] = 	1;
			lwtoa043_ai_sysaovs_suf[x] = 	"skin_sec_spec";
			lwtoa043_ai_sysaovs_filter[x] = 	7;
			x++;
			lwtoa043_ai_sysaovs_type[x] = 	1;
			lwtoa043_ai_sysaovs_suf[x] = 	"skin_shallow";
			lwtoa043_ai_sysaovs_filter[x] = 	7;
			x++;
			lwtoa043_ai_sysaovs_type[x] = 	1;
			lwtoa043_ai_sysaovs_suf[x] = 	"skin_mid";
			lwtoa043_ai_sysaovs_filter[x] = 	7;
			x++;
			lwtoa043_ai_sysaovs_type[x] = 	1;
			lwtoa043_ai_sysaovs_suf[x] = 	"skin_deep";
			lwtoa043_ai_sysaovs_filter[x] = 	7;
			x++;

			while (x <= lwtoa043_MAX_SYS_AOVS)
			{
				lwtoa043_ai_sysaovs_type[x] = 0;
				lwtoa043_ai_sysaovs_suf[x] = "";
				lwtoa043_ai_sysaovs_filter[x] = 0;
				x++;
			}

			// Transparency options
			lwtoa043_ai_trans_depth = 10;
			lwtoa043_ai_trans_mode = 1;
			lwtoa043_ai_trans_threshold = 0.99000001;

			// Point cloud Subsurface Scattering options
			lwtoa043_ai_sss_spacing = 0.1;
			lwtoa043_ai_sss_distribution = 0;
			lwtoa043_ai_sss_factor = 4;
			lwtoa043_ai_sss_show = 0;

			// Rendering ignore options
			lwtoa043_ai_ignore_textures = 0;
			lwtoa043_ai_ignore_shaders = 0;
			lwtoa043_ai_ignore_atmosphere = 0;
			lwtoa043_ai_ignore_lights = 0;
			lwtoa043_ai_ignore_shadows = 0;
			lwtoa043_ai_ignore_subdivision = 0;
			lwtoa043_ai_ignore_displacement = 0;
			lwtoa043_ai_ignore_bump = 0;
			lwtoa043_ai_ignore_motion_blur = 0;
			lwtoa043_ai_ignore_smoothing = 0;
			lwtoa043_ai_ignore_sss = 0;
			lwtoa043_ai_ignore_direct_lighting = 0;

			// Arnold camera options
			lwtoa043_ai_cam_type = 0;
			lwtoa043_ai_cam_near = 9.9999997e-005;
			lwtoa043_ai_cam_far = 9999999;
			lwtoa043_ai_cam_fisheye_crop = 0;
			lwtoa043_ai_cam_ortho_factor = 1;

			lwtoa043_ai_mb_apply_psys = 1;
			lwtoa043_ai_mb_psys_factor = 1;

			lwtoa043_ai_background_visbility = 0;

			lwtoa043_ai_log_sn_level = 2;
			lwtoa043_ai_info_add = 0;
			lwtoa043_ai_info_txt = "LWtoA user text line";

			lwtoa043_ai_instance_lw11 = 1;
			lwtoa043_ai_sds_max_level = 6;

			lwtoa043_ai_shading_pass = 0;
			for (x = 1; x <= lwtoa043_SHADING_PASSES; x++)
			{
				y = x - 1;
				lwtoa043_shading_pass_names[x] = "shader pass " + y.asStr(); // hack to work around LScript 1-based indexing.
			}

			lwtoa043_ai_multithread_loading = 1;

			lwtoa043_ai_aov_composition = 0;
			lwtoa043_ai_ignore_mis = 0;

			lwtoa043_ai_volumetric_type = 1; // 0->physicalSky, 1->LW fog, 2->Arnold fog, 3->volume scattering

			lwtoa043_ai_cam_exposure = 0;

			lwtoa043_ai_gamma_light = 1;
			lwtoa043_ai_gamma_shader = 1;
			lwtoa043_ai_gamma_texture = 1;
			lwtoa043_ai_tex_diffuse_blur = 0.031199999;
			lwtoa043_ai_tex_glossy_blur = 0.0156;

			lwtoa043_ai_low_light_threshold = 0.001;

			lwtoa043_ai_ignore_dof = 0;
			lwtoa043_ai_sss_engine = 1;
			lwtoa043_ai_sss_samples = 2;

			lwtoa043_ai_clamp_aovs = 0;
			lwtoa043_ai_nlights_heatmap = 0;
			lwtoa043_ai_ignore_procedurals = 0;

			lwtoa043_ai_procedural_path = "";
			lwtoa043_ai_texture_path = "";
			lwtoa043_ai_shader_path = "";

			lwtoa043_ai_log_frame_number = 0;
			lwtoa043_ai_ipr_license_skip = 1;
			lwtoa043_ai_texture_max_sharpen = 1;
			lwtoa043_ai_shader_timing_stats = 0;

			lwtoa043_ai_enable_multiple_uvmaps = 1;
			lwtoa043_ai_rendering_mode = 0;
			lwtoa043_ai_reload_lights = 0;
			lwtoa043_ai_reload_materials = 0;

			lwtoa043_ai_disable_rotational_mb = 0;
			lwtoa043_ai_cam_rolling_shutter = 0;

		}
	
		::doKeys = 0;

		reqbeginstr = "New Scene Master Override - LWtoA " + lwtoa043_default_arnoldMajor.asStr() + "." + lwtoa043_default_arnoldMinor.asStr() + "." + lwtoa043_default_arnoldPatch.asStr();
		if(action == "edit")
		{
			reqbeginstr = "Edit Scene Master Override - LWtoA " + lwtoa043_default_arnoldMajor.asStr() + "." + lwtoa043_default_arnoldMinor.asStr() + "." + lwtoa043_default_arnoldPatch.asStr();
		}
		reqbegin(reqbeginstr);
		reqsize(lwtoa043_ui_window_w, lwtoa043_ui_window_h);
		// reqredraw("scnGen_lwtoa043_req_redraw");

		newName = "SceneMasterOverride_LWtoA" + lwtoa043_default_arnoldMajor.asStr() +  lwtoa043_default_arnoldMinor.asStr() + lwtoa043_default_arnoldPatch.asStr();
		if(action == "edit")
		{
			newName = ::settingsArray[1];
		}
		lwtoa043_c20 = ctlstring("Override Name:",newName);
		ctlposition(lwtoa043_c20, lwtoa043_gad_x, 5, lwtoa043_gad_w + 50, lwtoa043_gad_h, lwtoa043_gad_text_offset);

		lwtoa043_ui_offset_y = 5 + lwtoa043_ui_row_offset;
		
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

		if(action == "new")
		{
			activeCameraID = ::masterScene.renderCamera(0).id;
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

		lwtoa043_c90 = ctlpopup("Active Camera",activeCamera,passCamNameArray);
		ctlposition(lwtoa043_c90, lwtoa043_gad_x, lwtoa043_ui_offset_y, lwtoa043_gad_w, lwtoa043_gad_h, lwtoa043_gad_text_offset);

		lwtoa043_c90_1 = ctlcheckbox("Redirect Buffer Export Paths",redirectBuffersSetts);
		ctlposition(lwtoa043_c90_1, lwtoa043_gad_x + lwtoa043_gad_w + lwtoa043_ui_spacing, lwtoa043_ui_offset_y, 200, lwtoa043_gad_h,0);

		lwtoa043_ui_offset_y += lwtoa043_ui_tab_offset;

		lwtoa043_tab0 = ctltab("System","Sampling","Rays","Misc","Debug","ASS","Text","AOVs");
		ctlposition(lwtoa043_tab0, lwtoa043_ui_offset_x, lwtoa043_ui_offset_y, lwtoa043_ui_tabrow_width, lwtoa043_gad_h);
		lwtoa043_tabrow = lwtoa043_ui_offset_y + 1;

		// TAB 1 - SYSTEM TAB
		if (1 == 1) // allow us to collapse this section for readability.
		{
			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset;
			lwtoa014_taboffset_y = lwtoa043_ui_offset_y;

			lwtoa043_c_ai_mt_auto = ctlcheckbox("Rendering Multithreading Autodetect",lwtoa043_ai_mt_auto);
			ctlposition(lwtoa043_c_ai_mt_auto, lwtoa043_gad_wc, lwtoa043_ui_offset_y, buttonWidth, lwtoa043_gad_h,0);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset;

	        lwtoa043_c_ai_mt_num = ctlminislider("Rendering Threads", lwtoa043_ai_mt_num, 1, lwtoa043_maxthreads);
			ctlposition(lwtoa043_c_ai_mt_num, lwtoa043_gad_wc, lwtoa043_ui_offset_y, buttonWidth - 22, lwtoa043_gad_h,lwtoa043_gad_text_offset);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset;

			lwtoa043_c_ai_multithread_loading = ctlcheckbox("Multithread Scene Loading",lwtoa043_ai_multithread_loading);
			ctlposition(lwtoa043_c_ai_multithread_loading, lwtoa043_gad_wc, lwtoa043_ui_offset_y, buttonWidth, lwtoa043_gad_h,0);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset * 1.5;

	        lwtoa043_sep_t1_1 = ctlsep(0, lwtoa043_ui_seperator_w);
	        ctlposition(lwtoa043_sep_t1_1, 1, lwtoa043_ui_offset_y);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset/2;

			// New stuff for LWtoA 0.4.3
			// Arnold uses 0-index; LScript uses 1-index. We have to manage this. Converted in reqpost() to 0-index.
			lwtoa043_ai_rendering_mode++;
	        lwtoa043_c_ai_rendering_mode = ctlpopup("IPR/Main Rendering Mode",lwtoa043_ai_rendering_mode,lwtoa043_rendering_mode_array);
			ctlposition(lwtoa043_c_ai_rendering_mode, lwtoa043_gad_wc, lwtoa043_ui_offset_y, buttonWidth, lwtoa043_gad_h,lwtoa043_gad_text_offset);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset;

			lwtoa043_c_ai_reload_lights = ctlcheckbox("Reload lights", lwtoa043_ai_reload_lights);
			ctlposition(lwtoa043_c_ai_reload_lights, lwtoa043_gad_wc, lwtoa043_ui_offset_y, buttonWidth, lwtoa043_gad_h,0);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset;

			lwtoa043_c_ai_reload_materials = ctlcheckbox("Reload materials", lwtoa043_ai_reload_materials);
			ctlposition(lwtoa043_c_ai_reload_materials, lwtoa043_gad_wc, lwtoa043_ui_offset_y, buttonWidth, lwtoa043_gad_h,0);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset * 1.5;

	        lwtoa043_sep_t1_2 = ctlsep(0, lwtoa043_ui_seperator_w);
	        ctlposition(lwtoa043_sep_t1_2, 1, lwtoa043_ui_offset_y);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset/2;

			// Arnold uses 0-index; LScript uses 1-index. We have to manage this. Converted in reqpost() to 0-index.
			lwtoa043_ai_scan_mode++;
	        lwtoa043_c_ai_scan_mode = ctlpopup("Bucket Scanning",lwtoa043_ai_scan_mode,lwtoa043_bucketscanning_array);
			ctlposition(lwtoa043_c_ai_scan_mode, lwtoa043_gad_wc, lwtoa043_ui_offset_y, buttonWidth, lwtoa043_gad_h,lwtoa043_gad_text_offset);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset;

	        lwtoa043_c_ai_bx = ctlnumber("Bucket size in pixels",lwtoa043_ai_bx);
			ctlposition(lwtoa043_c_ai_bx, lwtoa043_gad_wc, lwtoa043_ui_offset_y, buttonWidth, lwtoa043_gad_h,lwtoa043_gad_text_offset + 50);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset * 1.5;

	        lwtoa043_sep_t1_3 = ctlsep(0, lwtoa043_ui_seperator_w);
	        ctlposition(lwtoa043_sep_t1_3, 1, lwtoa043_ui_offset_y);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset/2;

			lwtoa043_c_ai_license_skip = ctlcheckbox("Render skip license check",lwtoa043_ai_license_skip);
			ctlposition(lwtoa043_c_ai_license_skip, lwtoa043_gad_wc, lwtoa043_ui_offset_y, buttonWidth, lwtoa043_gad_h,0);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset;

			lwtoa043_c_ai_ipr_license_skip = ctlcheckbox("IPR skip license check",lwtoa043_ai_ipr_license_skip);
			ctlposition(lwtoa043_c_ai_ipr_license_skip, lwtoa043_gad_wc, lwtoa043_ui_offset_y, buttonWidth, lwtoa043_gad_h,0);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset;

			lwtoa043_c_ai_abort_lic_fail = ctlcheckbox("Render abort on license fail",lwtoa043_ai_abort_lic_fail);
			ctlposition(lwtoa043_c_ai_abort_lic_fail, lwtoa043_gad_wc, lwtoa043_ui_offset_y, buttonWidth, lwtoa043_gad_h,0);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset * 1.5;

	        lwtoa043_sep_t1_4 = ctlsep(0, lwtoa043_ui_seperator_w);
	        ctlposition(lwtoa043_sep_t1_4, 1, lwtoa043_ui_offset_y);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset/2;

			lwtoa043_c_ai_procedural_path = ctlfoldername("Procedurals search path", lwtoa043_ai_procedural_path);
			ctlposition(lwtoa043_c_ai_procedural_path, (lwtoa043_ui_window_w - (buttonWidth + lwtoa043_gad_wc))/2, lwtoa043_ui_offset_y, buttonWidth + lwtoa043_gad_wc, lwtoa043_gad_h,lwtoa043_gad_wc);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset;

			lwtoa043_c_ai_shader_path = ctlfoldername("Shaders search path", lwtoa043_ai_shader_path);
			ctlposition(lwtoa043_c_ai_shader_path, (lwtoa043_ui_window_w - (buttonWidth + lwtoa043_gad_wc))/2, lwtoa043_ui_offset_y, buttonWidth + lwtoa043_gad_wc, lwtoa043_gad_h,lwtoa043_gad_wc);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset;

			lwtoa043_c_ai_texture_path = ctlfoldername("Procedurals search path", lwtoa043_ai_texture_path);
			ctlposition(lwtoa043_c_ai_texture_path, (lwtoa043_ui_window_w - (buttonWidth + lwtoa043_gad_wc))/2, lwtoa043_ui_offset_y, buttonWidth + lwtoa043_gad_wc, lwtoa043_gad_h,lwtoa043_gad_wc);

			ctlpage(1,lwtoa043_c_ai_mt_auto, lwtoa043_c_ai_mt_num, lwtoa043_c_ai_multithread_loading, lwtoa043_c_ai_rendering_mode, lwtoa043_c_ai_reload_lights, lwtoa043_c_ai_reload_materials, lwtoa043_c_ai_scan_mode, lwtoa043_c_ai_bx, lwtoa043_c_ai_license_skip, lwtoa043_c_ai_ipr_license_skip, lwtoa043_c_ai_abort_lic_fail, lwtoa043_c_ai_procedural_path, lwtoa043_c_ai_shader_path, lwtoa043_c_ai_texture_path, lwtoa043_sep_t1_1, lwtoa043_sep_t1_2, lwtoa043_sep_t1_3, lwtoa043_sep_t1_4);
		}

		// TAB 2 - SAMPLING TAB
		if (2 == 2)
		{
			lwtoa043_ui_offset_y = lwtoa014_taboffset_y;

			lwtoa043_c_ai_prog_sampling = ctlcheckbox("Draft pass before rendering",lwtoa043_ai_prog_sampling);
			ctlposition(lwtoa043_c_ai_prog_sampling, lwtoa043_gad_wc, lwtoa043_ui_offset_y, buttonWidth, lwtoa043_gad_h,0);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset;

			// Written out as full value, so we need to handle this on both sides.
			tmpStr = lwtoa043_ai_sampling_mult.asStr() + "%";
			lwtoa043_ai_sampling_mult = lwtoa043_samplingmult_array.indexOf(tmpStr);
	        lwtoa043_c_ai_sampling_mult = ctlpopup("Shading sampling multiplier",lwtoa043_ai_sampling_mult,lwtoa043_samplingmult_array);
			ctlposition(lwtoa043_c_ai_sampling_mult, lwtoa043_gad_wc, lwtoa043_ui_offset_y, buttonWidth, lwtoa043_gad_h,lwtoa043_gad_text_offset + 50);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset;

			// Written out as full value, so we need to handle this on both sides.
			tmpStr = lwtoa043_ai_light_sampling_mult.asStr() + "%";
			lwtoa043_ai_light_sampling_mult = lwtoa043_samplingmult_array.indexOf(tmpStr);
	        lwtoa043_c_ai_light_sampling_mult = ctlpopup("Lighting sampling multiplier",lwtoa043_ai_light_sampling_mult,lwtoa043_samplingmult_array);
			ctlposition(lwtoa043_c_ai_light_sampling_mult, lwtoa043_gad_wc, lwtoa043_ui_offset_y, buttonWidth, lwtoa043_gad_h,lwtoa043_gad_text_offset + 50);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset * 1.5;

	        lwtoa043_sep_t2_1 = ctlsep(0, lwtoa043_ui_seperator_w);
	        ctlposition(lwtoa043_sep_t2_1, 1, lwtoa043_ui_offset_y);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset/2;

	        lwtoa043_c_ai_aas = ctlminislider("AA Samples", lwtoa043_ai_aas, 1, lwtoa043_maxsamples);
			ctlposition(lwtoa043_c_ai_aas, lwtoa043_gad_wc, lwtoa043_ui_offset_y, buttonWidth - 22, lwtoa043_gad_h,lwtoa043_gad_text_offset);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset;

	        lwtoa043_c_ai_ds = ctlminislider("Diffuse Samples", lwtoa043_ai_ds, 1, lwtoa043_maxsamples);
			ctlposition(lwtoa043_c_ai_ds, lwtoa043_gad_wc, lwtoa043_ui_offset_y, buttonWidth - 22, lwtoa043_gad_h,lwtoa043_gad_text_offset);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset;

	        lwtoa043_c_ai_gs = ctlminislider("Glossy Samples", lwtoa043_ai_gs, 1, lwtoa043_maxsamples);
			ctlposition(lwtoa043_c_ai_gs, lwtoa043_gad_wc, lwtoa043_ui_offset_y, buttonWidth - 22, lwtoa043_gad_h,lwtoa043_gad_text_offset);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset;

	        lwtoa043_c_ai_rs = ctlminislider("Refraction Samples", lwtoa043_ai_rs, 1, lwtoa043_maxsamples);
			ctlposition(lwtoa043_c_ai_rs, lwtoa043_gad_wc, lwtoa043_ui_offset_y, buttonWidth - 22, lwtoa043_gad_h,lwtoa043_gad_text_offset);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset * 1.5;

	        lwtoa043_sep_t2_2 = ctlsep(0, lwtoa043_ui_seperator_w);
	        ctlposition(lwtoa043_sep_t2_2, 1, lwtoa043_ui_offset_y);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset/2;

			lwtoa043_c_ai_clamp = ctlcheckbox("Clamp Sample Values",lwtoa043_ai_clamp);
			ctlposition(lwtoa043_c_ai_clamp, lwtoa043_gad_wc, lwtoa043_ui_offset_y, buttonWidth, lwtoa043_gad_h,0);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset;

			lwtoa043_c_ai_clamp_aovs = ctlcheckbox("Clamp AOVs Sample Values",lwtoa043_ai_clamp_aovs);
			ctlposition(lwtoa043_c_ai_clamp_aovs, lwtoa043_gad_wc, lwtoa043_ui_offset_y, buttonWidth, lwtoa043_gad_h,0);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset;

	        lwtoa043_c_ai_clamp_max = ctlnumber("Max Value",lwtoa043_ai_clamp_max);
			ctlposition(lwtoa043_c_ai_clamp_max, lwtoa043_gad_wc, lwtoa043_ui_offset_y, buttonWidth, lwtoa043_gad_h,lwtoa043_gad_text_offset);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset * 1.5;

	        lwtoa043_sep_t2_3 = ctlsep(0, lwtoa043_ui_seperator_w);
	        ctlposition(lwtoa043_sep_t2_3, 1, lwtoa043_ui_offset_y);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset/2;

			lwtoa043_c_ai_lock = ctlcheckbox("Lock Sampling Noise",lwtoa043_ai_lock);
			ctlposition(lwtoa043_c_ai_lock, lwtoa043_gad_wc, lwtoa043_ui_offset_y, buttonWidth, lwtoa043_gad_h,0);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset * 1.5;

	        lwtoa043_sep_t2_4 = ctlsep(0, lwtoa043_ui_seperator_w);
	        ctlposition(lwtoa043_sep_t2_4, 1, lwtoa043_ui_offset_y);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset/2;

			// Arnold uses 0-index; LScript uses 1-index. We have to manage this. Converted in reqpost() to 0-index.
			lwtoa043_ai_pf++;
	        lwtoa043_c_ai_pf = ctlpopup("Pixel Filter",lwtoa043_ai_pf,lwtoa043_pixelfilter_array);
			ctlposition(lwtoa043_c_ai_pf, lwtoa043_gad_wc, lwtoa043_ui_offset_y, buttonWidth, lwtoa043_gad_h,lwtoa043_gad_text_offset);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset;

	        lwtoa043_c_ai_pw = ctlnumber("Filter Width",lwtoa043_ai_pw);
			ctlposition(lwtoa043_c_ai_pw, lwtoa043_gad_wc, lwtoa043_ui_offset_y, buttonWidth, lwtoa043_gad_h,lwtoa043_gad_text_offset);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset * 1.5;

	        lwtoa043_sep_t2_5 = ctlsep(0, lwtoa043_ui_seperator_w);
	        ctlposition(lwtoa043_sep_t2_5, 1, lwtoa043_ui_offset_y);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset/2;

			// Arnold uses 0-index; LScript uses 1-index. We have to manage this. Converted in reqpost() to 0-index.
			lwtoa043_ai_sss_engine++;
	        lwtoa043_c_ai_sss_engine = ctlpopup("Diffusion SSS Engine",lwtoa043_ai_sss_engine,lwtoa043_sssengine_array);
			ctlposition(lwtoa043_c_ai_sss_engine, lwtoa043_gad_wc - 50, lwtoa043_ui_offset_y, buttonWidth + 50, lwtoa043_gad_h,lwtoa043_gad_text_offset + 50);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset;

			lwtoa043_c_ai_sss_rtlbl = ctltext("","Settings below are for the raytraced SSS engine");
			ctlposition(lwtoa043_c_ai_sss_rtlbl, 5, lwtoa043_ui_offset_y, lwtoa043_ui_window_w, lwtoa043_gad_h,0);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset;

	        lwtoa043_c_ai_sss_samples = ctlminislider("Raytraced BSSRDF samples", lwtoa043_ai_sss_samples, 1, lwtoa043_max_rt_sss_samples);
			ctlposition(lwtoa043_c_ai_sss_samples, lwtoa043_gad_wc, lwtoa043_ui_offset_y, buttonWidth - 22, lwtoa043_gad_h,lwtoa043_gad_text_offset + 50);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset;

			lwtoa043_c_ai_sss_pclbl = ctltext("","Settings below are for the Pointcloud SSS engine");
			ctlposition(lwtoa043_c_ai_sss_pclbl, 5, lwtoa043_ui_offset_y, lwtoa043_ui_window_w, lwtoa043_gad_h,0);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset;

	        lwtoa043_c_ai_sss_factor = ctlminislider("Pointcloud sample factor", lwtoa043_ai_sss_factor, 1, lwtoa043_max_pc_sss_factor);
			ctlposition(lwtoa043_c_ai_sss_factor, lwtoa043_gad_wc, lwtoa043_ui_offset_y, buttonWidth - 22, lwtoa043_gad_h,lwtoa043_gad_text_offset + 50);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset;

	        lwtoa043_c_ai_sss_spacing = ctlnumber("Default pointcloud sample spacing",lwtoa043_ai_sss_spacing);
			ctlposition(lwtoa043_c_ai_sss_spacing, lwtoa043_gad_wc - 50, lwtoa043_ui_offset_y, buttonWidth + 50, lwtoa043_gad_h,lwtoa043_gad_text_offset + 100);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset;

			// Arnold uses 0-index; LScript uses 1-index. We have to manage this. Converted in reqpost() to 0-index.
			lwtoa043_ai_sss_distribution++;
	        lwtoa043_c_ai_sss_distribution = ctlpopup("Default pointcloud sample distrib.",lwtoa043_ai_sss_distribution,lwtoa043_pc_sample_distrib_array);
			ctlposition(lwtoa043_c_ai_sss_distribution, lwtoa043_gad_wc - 100, lwtoa043_ui_offset_y, buttonWidth + 100, lwtoa043_gad_h,lwtoa043_gad_text_offset + 100);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset;

			// Arnold uses 0-index; LScript uses 1-index. We have to manage this. Converted in reqpost() to 0-index.
			lwtoa043_ai_sss_show++;
	        lwtoa043_c_ai_sss_show = ctlpopup("Show pointcloud sample",lwtoa043_ai_sss_show,lwtoa043_pc_showsamples_array);
			ctlposition(lwtoa043_c_ai_sss_show, lwtoa043_gad_wc, lwtoa043_ui_offset_y, buttonWidth, lwtoa043_gad_h,lwtoa043_gad_text_offset + 50);

			ctlpage(2,lwtoa043_c_ai_prog_sampling, lwtoa043_c_ai_sampling_mult, lwtoa043_c_ai_light_sampling_mult, lwtoa043_c_ai_aas, lwtoa043_c_ai_ds, lwtoa043_c_ai_gs, lwtoa043_c_ai_rs, lwtoa043_c_ai_clamp, lwtoa043_c_ai_clamp_aovs, lwtoa043_c_ai_clamp_max, lwtoa043_c_ai_lock, lwtoa043_c_ai_pf, lwtoa043_c_ai_pw, lwtoa043_c_ai_sss_engine, lwtoa043_c_ai_sss_rtlbl, lwtoa043_c_ai_sss_samples, lwtoa043_c_ai_sss_pclbl, lwtoa043_c_ai_sss_factor, lwtoa043_c_ai_sss_spacing, lwtoa043_c_ai_sss_distribution, lwtoa043_c_ai_sss_show, lwtoa043_sep_t2_1, lwtoa043_sep_t2_2, lwtoa043_sep_t2_3, lwtoa043_sep_t2_4, lwtoa043_sep_t2_5);
		}

		// TAB 3 - RAYS TAB
		if (3 == 3)
		{
			lwtoa043_ui_offset_y = lwtoa014_taboffset_y;

	        lwtoa043_c_ai_rd_total = ctlminislider("Total Ray Depth", lwtoa043_ai_rd_total, 1, lwtoa043_max_rays);
			ctlposition(lwtoa043_c_ai_rd_total, lwtoa043_gad_wc, lwtoa043_ui_offset_y, buttonWidth - 22, lwtoa043_gad_h,lwtoa043_gad_text_offset);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset;

	        lwtoa043_c_ai_rd_diffuse = ctlminislider("Diffuse Depth", lwtoa043_ai_rd_diffuse, 1, lwtoa043_max_rays);
			ctlposition(lwtoa043_c_ai_rd_diffuse, lwtoa043_gad_wc, lwtoa043_ui_offset_y, buttonWidth - 22, lwtoa043_gad_h,lwtoa043_gad_text_offset);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset;

	        lwtoa043_c_ai_rd_refl = ctlminislider("Reflection Depth", lwtoa043_ai_rd_refl, 1, lwtoa043_max_rays);
			ctlposition(lwtoa043_c_ai_rd_refl, lwtoa043_gad_wc, lwtoa043_ui_offset_y, buttonWidth - 22, lwtoa043_gad_h,lwtoa043_gad_text_offset);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset;

	        lwtoa043_c_ai_rd_refr = ctlminislider("Refraction Depth", lwtoa043_ai_rd_refr, 1, lwtoa043_max_rays);
			ctlposition(lwtoa043_c_ai_rd_refr, lwtoa043_gad_wc, lwtoa043_ui_offset_y, buttonWidth - 22, lwtoa043_gad_h,lwtoa043_gad_text_offset);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset;

	        lwtoa043_c_ai_rd_glossy = ctlminislider("Glossy Depth", lwtoa043_ai_rd_glossy, 1, lwtoa043_max_rays);
			ctlposition(lwtoa043_c_ai_rd_glossy, lwtoa043_gad_wc, lwtoa043_ui_offset_y, buttonWidth - 22, lwtoa043_gad_h,lwtoa043_gad_text_offset);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset * 1.5;

	        lwtoa043_sep_t3_1 = ctlsep(0, lwtoa043_ui_seperator_w);
	        ctlposition(lwtoa043_sep_t3_1, 1, lwtoa043_ui_offset_y);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset/2;

			lwtoa043_c_ai_trans_mode = ctlcheckbox("Enable Transparency",lwtoa043_ai_trans_mode);
			ctlposition(lwtoa043_c_ai_trans_mode, lwtoa043_gad_wc, lwtoa043_ui_offset_y, buttonWidth, lwtoa043_gad_h,0);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset;

	        lwtoa043_c_ai_trans_depth = ctlminislider("Transparency Depth", lwtoa043_ai_trans_depth, 1, lwtoa043_max_transdepth);
			ctlposition(lwtoa043_c_ai_trans_depth, lwtoa043_gad_wc, lwtoa043_ui_offset_y, buttonWidth, lwtoa043_gad_h,lwtoa043_gad_text_offset + 50);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset;

	        lwtoa043_c_ai_trans_threshold = ctlnumber("Transparency Threshold",lwtoa043_ai_trans_threshold);
			ctlposition(lwtoa043_c_ai_trans_threshold, lwtoa043_gad_wc - 50, lwtoa043_ui_offset_y, buttonWidth + 50, lwtoa043_gad_h,lwtoa043_gad_text_offset + 100);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset;

			lwtoa043_c_ai_aov_composition = ctlcheckbox("Enable AOVs Composition",lwtoa043_ai_aov_composition);
			ctlposition(lwtoa043_c_ai_aov_composition, lwtoa043_gad_wc, lwtoa043_ui_offset_y, buttonWidth, lwtoa043_gad_h,0);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset * 1.5;

	        lwtoa043_sep_t3_2 = ctlsep(0, lwtoa043_ui_seperator_w);
	        ctlposition(lwtoa043_sep_t3_2, 1, lwtoa043_ui_offset_y);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset/2;

			// Arnold uses 0-index; LScript uses 1-index. We have to manage this. Converted in reqpost() to 0-index.
			lwtoa043_ai_volumetric_type++;
	        lwtoa043_c_ai_volumetric_type = ctlpopup("Atmospheric/Volumetric Engine",lwtoa043_ai_volumetric_type,lwtoa043_vol_engine_array);
			ctlposition(lwtoa043_c_ai_volumetric_type, lwtoa043_gad_wc - 50, lwtoa043_ui_offset_y, buttonWidth + 100, lwtoa043_gad_h,lwtoa043_gad_text_offset + 100);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset * 1.5;

	        lwtoa043_sep_t3_3 = ctlsep(0, lwtoa043_ui_seperator_w);
	        ctlposition(lwtoa043_sep_t3_3, 1, lwtoa043_ui_offset_y);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset/2;

			// Arnold uses 0-index; LScript uses 1-index. We have to manage this. Converted in reqpost() to 0-index.
			lwtoa043_ai_background_visbility++;
	        lwtoa043_c_ai_background_visbility = ctlpopup("LW Backdrop Ray Visibility",lwtoa043_ai_background_visbility,lwtoa043_backdrop_ray_vis_array);
			ctlposition(lwtoa043_c_ai_background_visbility, lwtoa043_gad_wc, lwtoa043_ui_offset_y, buttonWidth + 50, lwtoa043_gad_h,lwtoa043_gad_text_offset + 50);

			ctlpage(3,lwtoa043_c_ai_rd_total, lwtoa043_c_ai_rd_diffuse, lwtoa043_c_ai_rd_refl, lwtoa043_c_ai_rd_refr, lwtoa043_c_ai_rd_glossy, lwtoa043_c_ai_trans_mode, lwtoa043_c_ai_trans_depth, lwtoa043_c_ai_trans_threshold, lwtoa043_c_ai_aov_composition, lwtoa043_c_ai_volumetric_type, lwtoa043_c_ai_background_visbility, lwtoa043_sep_t3_1, lwtoa043_sep_t3_2, lwtoa043_sep_t3_3);
		}

		// TAB 4 - MISC TAB
		if (4 == 4)
		{
			lwtoa043_ui_offset_y = lwtoa014_taboffset_y;

			// Arnold uses 0-index; LScript uses 1-index. We have to manage this. Converted in reqpost() to 0-index.
			lwtoa043_ai_shading_pass++;
	        lwtoa043_c_ai_shading_pass = ctlpopup("Render shading pass",lwtoa043_ai_shading_pass,lwtoa043_shading_pass_names);
			ctlposition(lwtoa043_c_ai_shading_pass, lwtoa043_gad_wc - 50, lwtoa043_ui_offset_y, buttonWidth + 50, lwtoa043_gad_h,lwtoa043_gad_text_offset + 50);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset * 1.5;

	        lwtoa043_sep_t4_1 = ctlsep(0, lwtoa043_ui_seperator_w);
	        ctlposition(lwtoa043_sep_t4_1, 1, lwtoa043_ui_offset_y);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset/2;

			// Arnold uses 0-index; LScript uses 1-index. We have to manage this. Converted in reqpost() to 0-index.
			lwtoa043_ai_cam_type++;
	        lwtoa043_c_ai_cam_type = ctlpopup("Camera type",lwtoa043_ai_cam_type,lwtoa043_camera_types);
			ctlposition(lwtoa043_c_ai_cam_type, lwtoa043_gad_wc - 50, lwtoa043_ui_offset_y, buttonWidth + 50, lwtoa043_gad_h,lwtoa043_gad_text_offset);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset;

	        lwtoa043_c_ai_cam_exposure = ctlnumber("Camera Exposure",lwtoa043_ai_cam_exposure);
			ctlposition(lwtoa043_c_ai_cam_exposure, lwtoa043_gad_wc - 50, lwtoa043_ui_offset_y, buttonWidth + 50, lwtoa043_gad_h,lwtoa043_gad_text_offset + 50);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset;

	        lwtoa043_c_ai_cam_near = ctlnumber("Camera Near Clip",lwtoa043_ai_cam_near);
			ctlposition(lwtoa043_c_ai_cam_near, lwtoa043_gad_wc - 50, lwtoa043_ui_offset_y, buttonWidth + 50, lwtoa043_gad_h,lwtoa043_gad_text_offset + 50);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset;

	        lwtoa043_c_ai_cam_far = ctlnumber("Camera Far Clip",lwtoa043_ai_cam_far);
			ctlposition(lwtoa043_c_ai_cam_far, lwtoa043_gad_wc - 50, lwtoa043_ui_offset_y, buttonWidth + 50, lwtoa043_gad_h,lwtoa043_gad_text_offset + 50);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset;

			// Arnold uses 0-index; LScript uses 1-index. We have to manage this. Converted in reqpost() to 0-index.
			lwtoa043_ai_cam_rolling_shutter++;
			lwtoa043_c_ai_cam_rolling_shutter = ctlpopup("Camera rolling shutter",lwtoa043_ai_cam_rolling_shutter,lwtoa043_rolling_shutter_array);
			ctlposition(lwtoa043_c_ai_cam_rolling_shutter, lwtoa043_gad_wc - 50, lwtoa043_ui_offset_y, buttonWidth + 50, lwtoa043_gad_h,lwtoa043_gad_text_offset);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset;

			lwtoa043_c_ai_cam_fisheye_crop = ctlcheckbox("Fisheye Camera autocrop",lwtoa043_ai_cam_fisheye_crop);
			ctlposition(lwtoa043_c_ai_cam_fisheye_crop, lwtoa043_gad_wc, lwtoa043_ui_offset_y, buttonWidth, lwtoa043_gad_h,0);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset;

	        lwtoa043_c_ai_cam_ortho_factor = ctlnumber("Ortho Camera size factor",lwtoa043_ai_cam_ortho_factor);
			ctlposition(lwtoa043_c_ai_cam_ortho_factor, lwtoa043_gad_wc, lwtoa043_ui_offset_y, buttonWidth, lwtoa043_gad_h,lwtoa043_gad_text_offset + 50);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset * 1.5;

	        lwtoa043_sep_t4_2 = ctlsep(0, lwtoa043_ui_seperator_w);
	        ctlposition(lwtoa043_sep_t4_2, 1, lwtoa043_ui_offset_y);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset/2;

	        lwtoa043_c_ai_dof_aspect = ctlnumber("DOF Aperture Aspect Ratio",lwtoa043_ai_dof_aspect);
			ctlposition(lwtoa043_c_ai_dof_aspect, lwtoa043_gad_wc, lwtoa043_ui_offset_y, buttonWidth, lwtoa043_gad_h,lwtoa043_gad_text_offset + 50);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset;

	        lwtoa043_c_ai_dof_curvature = ctlnumber("DOF Blade Curvature",lwtoa043_ai_dof_curvature);
			ctlposition(lwtoa043_c_ai_dof_curvature, lwtoa043_gad_wc, lwtoa043_ui_offset_y, buttonWidth, lwtoa043_gad_h,lwtoa043_gad_text_offset + 50);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset * 1.5;

	        lwtoa043_sep_t4_3 = ctlsep(0, lwtoa043_ui_seperator_w);
	        ctlposition(lwtoa043_sep_t4_3, 1, lwtoa043_ui_offset_y);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset/2;

			// Arnold uses 0-index; LScript uses 1-index. We have to manage this. Converted in reqpost() to 0-index.
			lwtoa043_ai_shutter_type++;
	        lwtoa043_c_ai_shutter_type = ctlpopup("Motion blur shutter type",lwtoa043_ai_shutter_type,lwtoa043_shutter_types);
			ctlposition(lwtoa043_c_ai_shutter_type, lwtoa043_gad_wc - 50, lwtoa043_ui_offset_y, buttonWidth + 50, lwtoa043_gad_h,lwtoa043_gad_text_offset + 50);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset;

			lwtoa043_c_ai_mb_apply_obj = ctlcheckbox("Apply MB to objects",lwtoa043_ai_mb_apply_obj);
			ctlposition(lwtoa043_c_ai_mb_apply_obj, lwtoa043_gad_wc, lwtoa043_ui_offset_y, buttonWidth, lwtoa043_gad_h,0);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset;

			lwtoa043_c_ai_mb_apply_light = ctlcheckbox("Apply MB to lights",lwtoa043_ai_mb_apply_light);
			ctlposition(lwtoa043_c_ai_mb_apply_light, lwtoa043_gad_wc, lwtoa043_ui_offset_y, buttonWidth, lwtoa043_gad_h,0);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset;

			lwtoa043_c_ai_mb_apply_cam = ctlcheckbox("Apply MB to camera",lwtoa043_ai_mb_apply_cam);
			ctlposition(lwtoa043_c_ai_mb_apply_cam, lwtoa043_gad_wc, lwtoa043_ui_offset_y, buttonWidth, lwtoa043_gad_h,0);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset;

			lwtoa043_c_ai_mb_apply_psys = ctlcheckbox("Apply MB to particle systems",lwtoa043_ai_mb_apply_psys);
			ctlposition(lwtoa043_c_ai_mb_apply_psys, lwtoa043_gad_wc, lwtoa043_ui_offset_y, buttonWidth, lwtoa043_gad_h,0);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset;

	        lwtoa043_c_ai_mb_psys_factor = ctlnumber("Particle systems MB factor",lwtoa043_ai_mb_psys_factor);
			ctlposition(lwtoa043_c_ai_mb_psys_factor, lwtoa043_gad_wc, lwtoa043_ui_offset_y, buttonWidth, lwtoa043_gad_h,lwtoa043_gad_text_offset + 50);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset;

			lwtoa043_c_ai_mb_forceRefresh = ctlcheckbox("Full scene evaluation for MB",lwtoa043_ai_mb_forceRefresh);
			ctlposition(lwtoa043_c_ai_mb_forceRefresh, lwtoa043_gad_wc, lwtoa043_ui_offset_y, buttonWidth, lwtoa043_gad_h,0);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset * 1.5;

	        lwtoa043_sep_t4_4 = ctlsep(0, lwtoa043_ui_seperator_w);
	        ctlposition(lwtoa043_sep_t4_4, 1, lwtoa043_ui_offset_y);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset/2;

			lwtoa043_c_ai_instance_lwclones = ctlcheckbox("Render LW clones as Arnold instances",lwtoa043_ai_instance_lwclones);
			ctlposition(lwtoa043_c_ai_instance_lwclones, lwtoa043_gad_wc - 25, lwtoa043_ui_offset_y, buttonWidth + 50, lwtoa043_gad_h,0);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset;

			lwtoa043_c_ai_instance_nulls = ctlcheckbox("Render -(name) Null objects as Arnold instances",lwtoa043_ai_instance_nulls);
			ctlposition(lwtoa043_c_ai_instance_nulls, lwtoa043_gad_wc - 25, lwtoa043_ui_offset_y, buttonWidth + 50, lwtoa043_gad_h,0);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset;

			lwtoa043_c_ai_instance_lw11 = ctlcheckbox("Render LW11+ native instances",lwtoa043_ai_instance_lw11);
			ctlposition(lwtoa043_c_ai_instance_lw11, lwtoa043_gad_wc - 25, lwtoa043_ui_offset_y, buttonWidth + 50, lwtoa043_gad_h,0);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset * 1.5;

	        lwtoa043_sep_t4_5 = ctlsep(0, lwtoa043_ui_seperator_w);
	        ctlposition(lwtoa043_sep_t4_5, 1, lwtoa043_ui_offset_y);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset/2;

	        lwtoa043_c_ai_sds_max_level = ctlnumber("Max. SDS Subdivisions",lwtoa043_ai_sds_max_level);
			ctlposition(lwtoa043_c_ai_sds_max_level, lwtoa043_gad_wc, lwtoa043_ui_offset_y, buttonWidth, lwtoa043_gad_h,lwtoa043_gad_text_offset + 50);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset;

	        lwtoa043_c_ai_low_light_threshold = ctlnumber("Low Light Threshold",lwtoa043_ai_low_light_threshold);
			ctlposition(lwtoa043_c_ai_low_light_threshold, lwtoa043_gad_wc, lwtoa043_ui_offset_y, buttonWidth, lwtoa043_gad_h,lwtoa043_gad_text_offset + 50);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset * 1.5;

	        lwtoa043_sep_t4_6 = ctlsep(0, lwtoa043_ui_seperator_w);
	        ctlposition(lwtoa043_sep_t4_6, 1, lwtoa043_ui_offset_y);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset/2;

			lwtoa043_c_ai_enable_multiple_uvmaps = ctlcheckbox("Support multiple UV maps in the objects", lwtoa043_ai_enable_multiple_uvmaps);
			ctlposition(lwtoa043_c_ai_enable_multiple_uvmaps, lwtoa043_gad_wc - 25, lwtoa043_ui_offset_y, buttonWidth + 50, lwtoa043_gad_h,0);

			ctlpage(4, lwtoa043_c_ai_shading_pass, lwtoa043_c_ai_cam_type, lwtoa043_c_ai_cam_exposure, lwtoa043_c_ai_cam_near, lwtoa043_c_ai_cam_far, lwtoa043_c_ai_cam_rolling_shutter, lwtoa043_c_ai_cam_fisheye_crop, lwtoa043_c_ai_cam_ortho_factor, lwtoa043_c_ai_dof_aspect, lwtoa043_c_ai_dof_curvature, lwtoa043_c_ai_shutter_type, lwtoa043_c_ai_mb_apply_obj, lwtoa043_c_ai_mb_apply_light, lwtoa043_c_ai_mb_apply_cam, lwtoa043_c_ai_mb_apply_psys, lwtoa043_c_ai_mb_psys_factor, lwtoa043_c_ai_mb_forceRefresh, lwtoa043_c_ai_instance_lwclones, lwtoa043_c_ai_instance_nulls, lwtoa043_c_ai_instance_lw11, lwtoa043_c_ai_sds_max_level, lwtoa043_c_ai_low_light_threshold, lwtoa043_c_ai_enable_multiple_uvmaps, lwtoa043_sep_t4_1, lwtoa043_sep_t4_2, lwtoa043_sep_t4_3, lwtoa043_sep_t4_4, lwtoa043_sep_t4_5, lwtoa043_sep_t4_6);
		}

		// TAB 5 - DEBUG TAB
		if (5 == 5)
		{
			lwtoa043_ui_offset_y = lwtoa014_taboffset_y;

			lwtoa043_c_ai_log_write = ctlcheckbox("Write log to file",lwtoa043_ai_log_write);
			ctlposition(lwtoa043_c_ai_log_write, lwtoa043_gad_wc, lwtoa043_ui_offset_y, buttonWidth, lwtoa043_gad_h,0);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset;

			lwtoa043_c_ai_log_filename = ctlfilename("Log File", lwtoa043_ai_log_filename);
			ctlposition(lwtoa043_c_ai_log_filename, (lwtoa043_ui_window_w - (buttonWidth + lwtoa043_gad_wc))/2, lwtoa043_ui_offset_y, buttonWidth + lwtoa043_gad_wc, lwtoa043_gad_h,lwtoa043_gad_wc);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset;

			// Arnold uses 0-index; LScript uses 1-index. We have to manage this. Converted in reqpost() to 0-index.
			lwtoa043_ai_log_level++;
	        lwtoa043_c_ai_log_level = ctlpopup("Log Verbosity",lwtoa043_ai_log_level,lwtoa043_debug_verbosity_array);
			ctlposition(lwtoa043_c_ai_log_level, lwtoa043_gad_wc - 50, lwtoa043_ui_offset_y, buttonWidth + 50, lwtoa043_gad_h,lwtoa043_gad_text_offset + 50);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset;

			// Arnold uses 0-index; LScript uses 1-index. We have to manage this. Converted in reqpost() to 0-index.
			lwtoa043_ai_log_ipr_level++;
	        lwtoa043_c_ai_log_ipr_level = ctlpopup("IPR Log Verbosity",lwtoa043_ai_log_ipr_level,lwtoa043_debug_verbosity_array);
			ctlposition(lwtoa043_c_ai_log_ipr_level, lwtoa043_gad_wc - 50, lwtoa043_ui_offset_y, buttonWidth + 50, lwtoa043_gad_h,lwtoa043_gad_text_offset + 50);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset;

			// Arnold uses 0-index; LScript uses 1-index. We have to manage this. Converted in reqpost() to 0-index.
			lwtoa043_ai_log_sn_level++;
	        lwtoa043_c_ai_log_sn_level = ctlpopup("ScreamerNet Log Verbosity",lwtoa043_ai_log_sn_level,lwtoa043_debug_verbosity_array);
			ctlposition(lwtoa043_c_ai_log_sn_level, lwtoa043_gad_wc - 50, lwtoa043_ui_offset_y, buttonWidth + 50, lwtoa043_gad_h,lwtoa043_gad_text_offset + 50);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset;

	        lwtoa043_c_ai_log_max = ctlinteger("Max. warnings in log",lwtoa043_ai_log_max);
			ctlposition(lwtoa043_c_ai_log_max, lwtoa043_gad_wc, lwtoa043_ui_offset_y, buttonWidth, lwtoa043_gad_h,lwtoa043_gad_text_offset + 50);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset;

			lwtoa043_c_ai_log_frame_number = ctlcheckbox("Add frame number to log filename",lwtoa043_ai_log_frame_number);
			ctlposition(lwtoa043_c_ai_log_frame_number, lwtoa043_gad_wc, lwtoa043_ui_offset_y, buttonWidth, lwtoa043_gad_h,0);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset;

			lwtoa043_c_ai_shader_timing_stats = ctlcheckbox("Enable Shading Timing Stats",lwtoa043_ai_shader_timing_stats);
			ctlposition(lwtoa043_c_ai_shader_timing_stats, lwtoa043_gad_wc, lwtoa043_ui_offset_y, buttonWidth, lwtoa043_gad_h,0);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset * 1.5;

	        lwtoa043_sep_t5_1 = ctlsep(0, lwtoa043_ui_seperator_w);
	        ctlposition(lwtoa043_sep_t5_1, 1, lwtoa043_ui_offset_y);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset/2;

			lwtoa043_c_ai_ignore_textures = ctlcheckbox("Ignore Arnold Textures",lwtoa043_ai_ignore_textures);
			ctlposition(lwtoa043_c_ai_ignore_textures, 5, lwtoa043_ui_offset_y, buttonWidth, lwtoa043_gad_h,0);

			lwtoa043_c_ai_ignore_displacement = ctlcheckbox("Ignore Arnold Displacement",lwtoa043_ai_ignore_displacement);
			ctlposition(lwtoa043_c_ai_ignore_displacement, lwtoa043_ui_window_w / 2, lwtoa043_ui_offset_y, buttonWidth, lwtoa043_gad_h,0);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset;

			lwtoa043_c_ai_ignore_shaders = ctlcheckbox("Ignore Shaders",lwtoa043_ai_ignore_shaders);
			ctlposition(lwtoa043_c_ai_ignore_shaders, 5, lwtoa043_ui_offset_y, buttonWidth, lwtoa043_gad_h,0);

			lwtoa043_c_ai_ignore_bump = ctlcheckbox("Ignore Bump",lwtoa043_ai_ignore_bump);
			ctlposition(lwtoa043_c_ai_ignore_bump, lwtoa043_ui_window_w / 2, lwtoa043_ui_offset_y, buttonWidth, lwtoa043_gad_h,0);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset;

			lwtoa043_c_ai_ignore_atmosphere = ctlcheckbox("Ignore Atmospheres",lwtoa043_ai_ignore_atmosphere);
			ctlposition(lwtoa043_c_ai_ignore_atmosphere, 5, lwtoa043_ui_offset_y, buttonWidth, lwtoa043_gad_h,0);

			lwtoa043_c_ai_ignore_motion_blur = ctlcheckbox("Ignore Motion Blur",lwtoa043_ai_ignore_motion_blur);
			ctlposition(lwtoa043_c_ai_ignore_motion_blur, lwtoa043_ui_window_w / 2, lwtoa043_ui_offset_y, buttonWidth, lwtoa043_gad_h,0);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset;

			lwtoa043_c_ai_ignore_lights = ctlcheckbox("Ignore Lights",lwtoa043_ai_ignore_lights);
			ctlposition(lwtoa043_c_ai_ignore_lights, 5, lwtoa043_ui_offset_y, buttonWidth, lwtoa043_gad_h,0);

			lwtoa043_c_ai_ignore_smoothing = ctlcheckbox("Ignore Smoothing",lwtoa043_ai_ignore_smoothing);
			ctlposition(lwtoa043_c_ai_ignore_smoothing, lwtoa043_ui_window_w / 2, lwtoa043_ui_offset_y, buttonWidth, lwtoa043_gad_h,0);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset;

			lwtoa043_c_ai_ignore_shadows = ctlcheckbox("Ignore Shadows",lwtoa043_ai_ignore_shadows);
			ctlposition(lwtoa043_c_ai_ignore_shadows, 5, lwtoa043_ui_offset_y, buttonWidth, lwtoa043_gad_h,0);

			lwtoa043_c_ai_ignore_sss = ctlcheckbox("Ignore SSS",lwtoa043_ai_ignore_sss);
			ctlposition(lwtoa043_c_ai_ignore_sss, lwtoa043_ui_window_w / 2, lwtoa043_ui_offset_y, buttonWidth, lwtoa043_gad_h,0);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset;

			lwtoa043_c_ai_ignore_subdivision = ctlcheckbox("Ignore Arnold SDS",lwtoa043_ai_ignore_subdivision);
			ctlposition(lwtoa043_c_ai_ignore_subdivision, 5, lwtoa043_ui_offset_y, buttonWidth, lwtoa043_gad_h,0);

			lwtoa043_c_ai_ignore_direct_lighting = ctlcheckbox("Ignore Direct Lighting",lwtoa043_ai_ignore_direct_lighting);
			ctlposition(lwtoa043_c_ai_ignore_direct_lighting, lwtoa043_ui_window_w / 2, lwtoa043_ui_offset_y, buttonWidth, lwtoa043_gad_h,0);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset;

			lwtoa043_c_ai_ignore_mis = ctlcheckbox("Ignore MIS",lwtoa043_ai_ignore_mis);
			ctlposition(lwtoa043_c_ai_ignore_mis, 5, lwtoa043_ui_offset_y, buttonWidth, lwtoa043_gad_h,0);

			lwtoa043_c_ai_ignore_dof = ctlcheckbox("Ignore DOF",lwtoa043_ai_ignore_dof);
			ctlposition(lwtoa043_c_ai_ignore_dof, lwtoa043_ui_window_w / 2, lwtoa043_ui_offset_y, buttonWidth, lwtoa043_gad_h,0);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset;

			lwtoa043_c_ai_nlights_heatmap = ctlcheckbox("Render NLights Heatmap",lwtoa043_ai_nlights_heatmap);
			ctlposition(lwtoa043_c_ai_nlights_heatmap, 5, lwtoa043_ui_offset_y, buttonWidth, lwtoa043_gad_h,0);

			lwtoa043_c_ai_ignore_procedurals = ctlcheckbox("Ignore Procedurals",lwtoa043_ai_ignore_procedurals);
			ctlposition(lwtoa043_c_ai_ignore_procedurals, lwtoa043_ui_window_w / 2, lwtoa043_ui_offset_y, buttonWidth, lwtoa043_gad_h,0);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset;

			lwtoa043_c_ai_disable_rotational_mb = ctlcheckbox("Disable Rotational MB",lwtoa043_ai_disable_rotational_mb);
			ctlposition(lwtoa043_c_ai_disable_rotational_mb, lwtoa043_ui_window_w / 2, lwtoa043_ui_offset_y, buttonWidth, lwtoa043_gad_h,0);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset * 1.5;

	        lwtoa043_sep_t5_2 = ctlsep(0, lwtoa043_ui_seperator_w);
	        ctlposition(lwtoa043_sep_t5_2, 1, lwtoa043_ui_offset_y);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset/2;

			lwtoa043_c_ai_info_add = ctlcheckbox("Add render info to image",lwtoa043_ai_info_add);
			ctlposition(lwtoa043_c_ai_info_add, lwtoa043_gad_wc, lwtoa043_ui_offset_y, buttonWidth, lwtoa043_gad_h,0);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset;

	        lwtoa043_c_ai_info_txt = ctlstring("User info line",lwtoa043_ai_info_txt);
			ctlposition(lwtoa043_c_ai_info_txt, lwtoa043_gad_wc, lwtoa043_ui_offset_y, buttonWidth, lwtoa043_gad_h,lwtoa043_gad_text_offset);

			ctlpage(5, lwtoa043_c_ai_log_write, lwtoa043_c_ai_log_filename, lwtoa043_c_ai_log_level, lwtoa043_c_ai_log_ipr_level, lwtoa043_c_ai_log_sn_level, lwtoa043_c_ai_log_max, lwtoa043_c_ai_log_frame_number, lwtoa043_c_ai_shader_timing_stats, lwtoa043_c_ai_ignore_textures, lwtoa043_c_ai_ignore_displacement, lwtoa043_c_ai_ignore_shaders, lwtoa043_c_ai_ignore_bump, lwtoa043_c_ai_ignore_atmosphere, lwtoa043_c_ai_ignore_motion_blur, lwtoa043_c_ai_ignore_lights, lwtoa043_c_ai_ignore_smoothing, lwtoa043_c_ai_ignore_shadows, lwtoa043_c_ai_ignore_sss, lwtoa043_c_ai_ignore_subdivision, lwtoa043_c_ai_ignore_direct_lighting, lwtoa043_c_ai_ignore_mis, lwtoa043_c_ai_ignore_dof, lwtoa043_c_ai_nlights_heatmap, lwtoa043_c_ai_ignore_procedurals, lwtoa043_c_ai_disable_rotational_mb, lwtoa043_c_ai_info_add, lwtoa043_c_ai_info_txt, lwtoa043_sep_t5_1, lwtoa043_sep_t5_2);
		}

		// TAB 6 - ASS TAB
		if (6 == 6)
		{
			lwtoa043_ui_offset_y = lwtoa014_taboffset_y;

			lwtoa043_c_ai_render_to_file = ctlcheckbox("Render frame or scene to .ass file",lwtoa043_ai_render_to_file);
			ctlposition(lwtoa043_c_ai_render_to_file, lwtoa043_gad_wc, lwtoa043_ui_offset_y, buttonWidth, lwtoa043_gad_h,0);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset;

			lwtoa043_c_ai_filename = ctlfilename(".ass File Name", lwtoa043_ai_filename);
			ctlposition(lwtoa043_c_ai_filename, (lwtoa043_ui_window_w - (buttonWidth + lwtoa043_gad_wc))/2, lwtoa043_ui_offset_y, buttonWidth + lwtoa043_gad_wc, lwtoa043_gad_h,lwtoa043_gad_wc);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset;

			lwtoa043_c_ai_compress_file = ctlcheckbox("Compress .ass file to .gz",lwtoa043_ai_compress_file);
			ctlposition(lwtoa043_c_ai_compress_file, lwtoa043_gad_wc, lwtoa043_ui_offset_y, buttonWidth, lwtoa043_gad_h,0);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset;

			lwtoa043_c_ai_ass_binary = ctlcheckbox("Binary encoding of float arrays",lwtoa043_ai_ass_binary);
			ctlposition(lwtoa043_c_ai_ass_binary, lwtoa043_gad_wc, lwtoa043_ui_offset_y, buttonWidth, lwtoa043_gad_h,0);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset * 1.5;

	        lwtoa043_sep_t6_1 = ctlsep(0, lwtoa043_ui_seperator_w);
	        ctlposition(lwtoa043_sep_t6_1, 1, lwtoa043_ui_offset_y);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset/2;

			lwtoa043_c_ai_writenode_options = ctlcheckbox("Export Options Nodes",lwtoa043_ai_writenode_options);
			ctlposition(lwtoa043_c_ai_writenode_options, lwtoa043_gad_wc, lwtoa043_ui_offset_y, buttonWidth, lwtoa043_gad_h,0);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset;

			lwtoa043_c_ai_writenode_drivers = ctlcheckbox("Export Drivers/Filters Nodes",lwtoa043_ai_writenode_drivers);
			ctlposition(lwtoa043_c_ai_writenode_drivers, lwtoa043_gad_wc, lwtoa043_ui_offset_y, buttonWidth, lwtoa043_gad_h,0);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset;

			lwtoa043_c_ai_writenode_geom = ctlcheckbox("Export Geometry Nodes",lwtoa043_ai_writenode_geom);
			ctlposition(lwtoa043_c_ai_writenode_geom, lwtoa043_gad_wc, lwtoa043_ui_offset_y, buttonWidth, lwtoa043_gad_h,0);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset;

			lwtoa043_c_ai_writenode_cam = ctlcheckbox("Export Camera Nodes",lwtoa043_ai_writenode_cam);
			ctlposition(lwtoa043_c_ai_writenode_cam, lwtoa043_gad_wc, lwtoa043_ui_offset_y, buttonWidth, lwtoa043_gad_h,0);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset;

			lwtoa043_c_ai_writenode_lights = ctlcheckbox("Export Lights Nodes",lwtoa043_ai_writenode_lights);
			ctlposition(lwtoa043_c_ai_writenode_lights, lwtoa043_gad_wc, lwtoa043_ui_offset_y, buttonWidth, lwtoa043_gad_h,0);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset;

			lwtoa043_c_ai_writenode_shaders = ctlcheckbox("Export Shaders Nodes",lwtoa043_ai_writenode_shaders);
			ctlposition(lwtoa043_c_ai_writenode_shaders, lwtoa043_gad_wc, lwtoa043_ui_offset_y, buttonWidth, lwtoa043_gad_h,0);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset;

			ctlpage(6, lwtoa043_c_ai_render_to_file, lwtoa043_c_ai_filename, lwtoa043_c_ai_compress_file, lwtoa043_c_ai_ass_binary, lwtoa043_c_ai_writenode_options, lwtoa043_c_ai_writenode_drivers, lwtoa043_c_ai_writenode_geom, lwtoa043_c_ai_writenode_cam, lwtoa043_c_ai_writenode_lights, lwtoa043_c_ai_writenode_shaders, lwtoa043_sep_t6_1);
		}

		// TAB 7 - TEXT TAB
		if (7 == 7)
		{
			lwtoa043_ui_offset_y = lwtoa014_taboffset_y;

			lwtoa043_c_ai_tex_accept_nomipmap = ctlcheckbox("Accept Unmipmapped Textures",lwtoa043_ai_tex_accept_nomipmap);
			ctlposition(lwtoa043_c_ai_tex_accept_nomipmap, lwtoa043_gad_wc, lwtoa043_ui_offset_y, buttonWidth, lwtoa043_gad_h,0);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset;

			lwtoa043_c_ai_tex_automipmap = ctlcheckbox("Auto Mipmap",lwtoa043_ai_tex_automipmap);
			ctlposition(lwtoa043_c_ai_tex_automipmap, lwtoa043_gad_wc, lwtoa043_ui_offset_y, buttonWidth, lwtoa043_gad_h,0);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset;

			// Arnold uses 0-index; LScript uses 1-index. We have to manage this. Converted in reqpost() to 0-index.
			lwtoa043_ai_tex_magfilter++;
	        lwtoa043_c_ai_tex_magfilter = ctlpopup("Default Mag. Filter",lwtoa043_ai_tex_magfilter,lwtoa043_default_mag_filter_array);
			ctlposition(lwtoa043_c_ai_tex_magfilter, lwtoa043_gad_wc - 50, lwtoa043_ui_offset_y, buttonWidth + 50, lwtoa043_gad_h,lwtoa043_gad_text_offset + 50);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset * 1.5;

	        lwtoa043_sep_t7_1 = ctlsep(0, lwtoa043_ui_seperator_w);
	        ctlposition(lwtoa043_sep_t7_1, 1, lwtoa043_ui_offset_y);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset/2;

			lwtoa043_c_ai_tex_accept_untiled = ctlcheckbox("Accept Untiled Textures",lwtoa043_ai_tex_accept_untiled);
			ctlposition(lwtoa043_c_ai_tex_accept_untiled, lwtoa043_gad_wc, lwtoa043_ui_offset_y, buttonWidth, lwtoa043_gad_h,0);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset;

			lwtoa043_c_ai_tex_autotile = ctlcheckbox("Autotile Textures",lwtoa043_ai_tex_autotile);
			ctlposition(lwtoa043_c_ai_tex_autotile, lwtoa043_gad_wc, lwtoa043_ui_offset_y, buttonWidth, lwtoa043_gad_h,0);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset;

	        lwtoa043_c_ai_tex_tile_size = ctlinteger("Tile size",lwtoa043_ai_tex_tile_size);
			ctlposition(lwtoa043_c_ai_tex_tile_size, lwtoa043_gad_wc, lwtoa043_ui_offset_y, buttonWidth, lwtoa043_gad_h,lwtoa043_gad_text_offset + 50);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset * 1.5;

	        lwtoa043_sep_t7_2 = ctlsep(0, lwtoa043_ui_seperator_w);
	        ctlposition(lwtoa043_sep_t7_2, 1, lwtoa043_ui_offset_y);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset/2;

			lwtoa043_c_ai_tex_cache = ctlcheckbox("Enable Texture Caching",lwtoa043_ai_tex_cache);
			ctlposition(lwtoa043_c_ai_tex_cache, lwtoa043_gad_wc, lwtoa043_ui_offset_y, buttonWidth, lwtoa043_gad_h,0);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset;

	        lwtoa043_c_ai_tex_cache_size = ctlinteger("Cache Size (MB)",lwtoa043_ai_tex_cache_size);
			ctlposition(lwtoa043_c_ai_tex_cache_size, lwtoa043_gad_wc, lwtoa043_ui_offset_y, buttonWidth, lwtoa043_gad_h,lwtoa043_gad_text_offset + 50);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset;

	        lwtoa043_c_ai_tex_maxfiles = ctlinteger("Maximum Open Textures",lwtoa043_ai_tex_maxfiles);
			ctlposition(lwtoa043_c_ai_tex_maxfiles, lwtoa043_gad_wc, lwtoa043_ui_offset_y, buttonWidth, lwtoa043_gad_h,lwtoa043_gad_text_offset + 50);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset * 1.5;

	        lwtoa043_sep_t7_3 = ctlsep(0, lwtoa043_ui_seperator_w);
	        ctlposition(lwtoa043_sep_t7_3, 1, lwtoa043_ui_offset_y);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset/2;

	        lwtoa043_c_ai_gamma_texture = ctlnumber("Arnold Textures Gamma Correction",lwtoa043_ai_gamma_texture);
			ctlposition(lwtoa043_c_ai_gamma_texture, lwtoa043_gad_wc, lwtoa043_ui_offset_y, buttonWidth, lwtoa043_gad_h,lwtoa043_gad_text_offset + 50);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset;

	        lwtoa043_c_ai_tex_diffuse_blur = ctlnumber("Arnold Textures Diffuse Blur",lwtoa043_ai_tex_diffuse_blur);
			ctlposition(lwtoa043_c_ai_tex_diffuse_blur, lwtoa043_gad_wc, lwtoa043_ui_offset_y, buttonWidth, lwtoa043_gad_h,lwtoa043_gad_text_offset + 50);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset;

	        lwtoa043_c_ai_tex_glossy_blur = ctlnumber("Arnold Textures Glossy Blur",lwtoa043_ai_tex_glossy_blur);
			ctlposition(lwtoa043_c_ai_tex_glossy_blur, lwtoa043_gad_wc, lwtoa043_ui_offset_y, buttonWidth, lwtoa043_gad_h,lwtoa043_gad_text_offset + 50);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset;

	        lwtoa043_c_ai_texture_max_sharpen = ctlnumber("Arnold Textures Max Sharpen",lwtoa043_ai_texture_max_sharpen);
			ctlposition(lwtoa043_c_ai_texture_max_sharpen, lwtoa043_gad_wc, lwtoa043_ui_offset_y, buttonWidth, lwtoa043_gad_h,lwtoa043_gad_text_offset + 50);

			ctlpage(7, lwtoa043_c_ai_tex_accept_nomipmap, lwtoa043_c_ai_tex_automipmap, lwtoa043_c_ai_tex_magfilter, lwtoa043_c_ai_tex_accept_untiled, lwtoa043_c_ai_tex_autotile, lwtoa043_c_ai_tex_tile_size, lwtoa043_c_ai_tex_cache, lwtoa043_c_ai_tex_cache_size, lwtoa043_c_ai_tex_maxfiles, lwtoa043_c_ai_gamma_texture, lwtoa043_c_ai_tex_diffuse_blur, lwtoa043_c_ai_tex_glossy_blur, lwtoa043_c_ai_texture_max_sharpen, lwtoa043_sep_t7_1, lwtoa043_sep_t7_2, lwtoa043_sep_t7_3);
		}

		// TAB 8 - AOVS
		if (8 == 8)
		{
			lwtoa043_ui_offset_y = lwtoa014_taboffset_y;

			lwtoa043_c_ai_sysaovs_enable = ctlcheckbox("Enable system AOVs output",lwtoa043_ai_sysaovs_enable);
			ctlposition(lwtoa043_c_ai_sysaovs_enable, lwtoa043_gad_wc, lwtoa043_ui_offset_y, buttonWidth, lwtoa043_gad_h,0);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset;

			// Arnold uses 0-index; LScript uses 1-index. We have to manage this. Converted in reqpost() to 0-index.
			lwtoa043_ai_sysaovs_display++;
	        lwtoa043_c_ai_sysaovs_display = ctlpopup("Render View AOV",lwtoa043_ai_sysaovs_display,lwtoa043_AOV_array);
			ctlposition(lwtoa043_c_ai_sysaovs_display, lwtoa043_gad_wc - 50, lwtoa043_ui_offset_y, buttonWidth + 50, lwtoa043_gad_h,lwtoa043_gad_text_offset + 50);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset * 1.5;

	        lwtoa043_sep_t8_1 = ctlsep(0, lwtoa043_ui_seperator_w);
	        ctlposition(lwtoa043_sep_t8_1, 1, lwtoa043_ui_offset_y);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset/2;

			if (0 == 0) // allows us to collapse the large chunk of the AOV UI code down.
			{
				lwtoa043_t8_colwidth = lwtoa043_ui_window_w / size(lwtoa043_AOV_colheaders);

				col_index = 1;
				colheader_t8_1 = ctltext("",lwtoa043_AOV_colheaders[col_index]);
		        ctlposition(colheader_t8_1, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y);

				col_index++;
				colheader_t8_2 = ctltext("",lwtoa043_AOV_colheaders[col_index]);
		        ctlposition(colheader_t8_2, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y);

				col_index++;
				colheader_t8_3 = ctltext("",lwtoa043_AOV_colheaders[col_index]);
		        ctlposition(colheader_t8_3, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y);

				col_index++;
				colheader_t8_4 = ctltext("",lwtoa043_AOV_colheaders[col_index]);
		        ctlposition(colheader_t8_4, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y);

				col_index++;
				colheader_t8_5 = ctltext("",lwtoa043_AOV_colheaders[col_index]);
		        ctlposition(colheader_t8_5, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y);

				col_index++;
				colheader_t8_6 = ctltext("",lwtoa043_AOV_colheaders[col_index]);
		        ctlposition(colheader_t8_6, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y);
	        }

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset;

			if (1 == 1)
			{
				col_index = 1;
				lwtoa043_t8_AOV_index = 1;
				lwtoa043_c_ai_sysaovs_active_1 = ctlstate(lwtoa043_AOV_array[lwtoa043_t8_AOV_index], lwtoa043_ai_sysaovs_active[lwtoa043_t8_AOV_index], lwtoa043_t8_colwidth - 10, "scnGen_lwtoa043_aov_stub");
		        ctlposition(lwtoa043_c_ai_sysaovs_active_1, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);

				col_index++;
				lwtoa043_c_ai_sysaovs_type_1 = ctlpopup("", int(lwtoa043_ai_sysaovs_type[lwtoa043_t8_AOV_index]) + 1,lwtoa043_AOV_types);
		        ctlposition(lwtoa043_c_ai_sysaovs_type_1, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);

				col_index++;
				lwtoa043_c_ai_sysaovs_suffix_1 = ctlstring("", lwtoa043_ai_sysaovs_suf[lwtoa043_t8_AOV_index]);
		        ctlposition(lwtoa043_c_ai_sysaovs_suffix_1, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);

				col_index++;
				lwtoa043_c_ai_sysaovs_filter_1 = ctlpopup("", int(lwtoa043_ai_sysaovs_filter[lwtoa043_t8_AOV_index]) + 1,lwtoa043_pixelfilter_array);
		        ctlposition(lwtoa043_c_ai_sysaovs_filter_1, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);

				col_index++;
				lwtoa043_c_ai_sysaovs_gamma_1 = ctlnumber("", lwtoa043_ai_sysaovs_gamma[lwtoa043_t8_AOV_index]);
		        ctlposition(lwtoa043_c_ai_sysaovs_gamma_1, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);

				col_index++;
				lwtoa043_c_ai_sysaovs_file_format_1 = ctlpopup("", lwtoa043_ai_sysaovs_file_format[lwtoa043_t8_AOV_index] + 1,lwtoa043_AOV_formats);
		        ctlposition(lwtoa043_c_ai_sysaovs_file_format_1, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);
	        }

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset;

			if (2 == 2)
			{
				col_index = 1;
				lwtoa043_t8_AOV_index++;
				lwtoa043_c_ai_sysaovs_active_2 = ctlstate(lwtoa043_AOV_array[lwtoa043_t8_AOV_index], lwtoa043_ai_sysaovs_active[lwtoa043_t8_AOV_index], lwtoa043_t8_colwidth - 10, "scnGen_lwtoa043_aov_stub");
		        ctlposition(lwtoa043_c_ai_sysaovs_active_2, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);

				col_index++;
				lwtoa043_c_ai_sysaovs_type_2 = ctlpopup("", int(lwtoa043_ai_sysaovs_type[lwtoa043_t8_AOV_index]) + 1,lwtoa043_AOV_types);
		        ctlposition(lwtoa043_c_ai_sysaovs_type_2, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);

				col_index++;
				lwtoa043_c_ai_sysaovs_suffix_2 = ctlstring("", lwtoa043_ai_sysaovs_suf[lwtoa043_t8_AOV_index]);
		        ctlposition(lwtoa043_c_ai_sysaovs_suffix_2, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);

				col_index++;
				lwtoa043_c_ai_sysaovs_filter_2 = ctlpopup("", int(lwtoa043_ai_sysaovs_filter[lwtoa043_t8_AOV_index]) + 1,lwtoa043_pixelfilter_array);
		        ctlposition(lwtoa043_c_ai_sysaovs_filter_2, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);

				col_index++;
				lwtoa043_c_ai_sysaovs_gamma_2 = ctlnumber("", lwtoa043_ai_sysaovs_gamma[lwtoa043_t8_AOV_index]);
		        ctlposition(lwtoa043_c_ai_sysaovs_gamma_2, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);

				col_index++;
				lwtoa043_c_ai_sysaovs_file_format_2 = ctlpopup("", lwtoa043_ai_sysaovs_file_format[lwtoa043_t8_AOV_index] + 1,lwtoa043_AOV_formats);
		        ctlposition(lwtoa043_c_ai_sysaovs_file_format_2, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);
	        }

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset;

			if (3 == 3)
			{
				col_index = 1;
				lwtoa043_t8_AOV_index++;
				lwtoa043_c_ai_sysaovs_active_3 = ctlstate(lwtoa043_AOV_array[lwtoa043_t8_AOV_index], lwtoa043_ai_sysaovs_active[lwtoa043_t8_AOV_index], lwtoa043_t8_colwidth - 10, "scnGen_lwtoa043_aov_stub");
		        ctlposition(lwtoa043_c_ai_sysaovs_active_3, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);

				col_index++;
				lwtoa043_c_ai_sysaovs_type_3 = ctlpopup("", int(lwtoa043_ai_sysaovs_type[lwtoa043_t8_AOV_index]) + 1,lwtoa043_AOV_types);
		        ctlposition(lwtoa043_c_ai_sysaovs_type_3, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);

				col_index++;
				lwtoa043_c_ai_sysaovs_suffix_3 = ctlstring("", lwtoa043_ai_sysaovs_suf[lwtoa043_t8_AOV_index]);
		        ctlposition(lwtoa043_c_ai_sysaovs_suffix_3, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);

				col_index++;
				lwtoa043_c_ai_sysaovs_filter_3 = ctlpopup("", int(lwtoa043_ai_sysaovs_filter[lwtoa043_t8_AOV_index]) + 1,lwtoa043_pixelfilter_array);
		        ctlposition(lwtoa043_c_ai_sysaovs_filter_3, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);

				col_index++;
				lwtoa043_c_ai_sysaovs_gamma_3 = ctlnumber("", lwtoa043_ai_sysaovs_gamma[lwtoa043_t8_AOV_index]);
		        ctlposition(lwtoa043_c_ai_sysaovs_gamma_3, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);

				col_index++;
				lwtoa043_c_ai_sysaovs_file_format_3 = ctlpopup("", lwtoa043_ai_sysaovs_file_format[lwtoa043_t8_AOV_index] + 1,lwtoa043_AOV_formats);
		        ctlposition(lwtoa043_c_ai_sysaovs_file_format_3, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);
	        }

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset;

			if (4 == 4)
			{
				col_index = 1;
				lwtoa043_t8_AOV_index++;
				lwtoa043_c_ai_sysaovs_active_4 = ctlstate(lwtoa043_AOV_array[lwtoa043_t8_AOV_index], lwtoa043_ai_sysaovs_active[lwtoa043_t8_AOV_index], lwtoa043_t8_colwidth - 10, "scnGen_lwtoa043_aov_stub");
		        ctlposition(lwtoa043_c_ai_sysaovs_active_4, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);

				col_index++;
				lwtoa043_c_ai_sysaovs_type_4 = ctlpopup("", int(lwtoa043_ai_sysaovs_type[lwtoa043_t8_AOV_index]) + 1,lwtoa043_AOV_types);
		        ctlposition(lwtoa043_c_ai_sysaovs_type_4, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);

				col_index++;
				lwtoa043_c_ai_sysaovs_suffix_4 = ctlstring("", lwtoa043_ai_sysaovs_suf[lwtoa043_t8_AOV_index]);
		        ctlposition(lwtoa043_c_ai_sysaovs_suffix_4, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);

				col_index++;
				lwtoa043_c_ai_sysaovs_filter_4 = ctlpopup("", int(lwtoa043_ai_sysaovs_filter[lwtoa043_t8_AOV_index]) + 1,lwtoa043_pixelfilter_array);
		        ctlposition(lwtoa043_c_ai_sysaovs_filter_4, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);

				col_index++;
				lwtoa043_c_ai_sysaovs_gamma_4 = ctlnumber("", lwtoa043_ai_sysaovs_gamma[lwtoa043_t8_AOV_index]);
		        ctlposition(lwtoa043_c_ai_sysaovs_gamma_4, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);

				col_index++;
				lwtoa043_c_ai_sysaovs_file_format_4 = ctlpopup("", lwtoa043_ai_sysaovs_file_format[lwtoa043_t8_AOV_index] + 1,lwtoa043_AOV_formats);
		        ctlposition(lwtoa043_c_ai_sysaovs_file_format_4, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);
	        }

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset;

			if (5 == 5)
			{
				col_index = 1;
				lwtoa043_t8_AOV_index++;
				lwtoa043_c_ai_sysaovs_active_5 = ctlstate(lwtoa043_AOV_array[lwtoa043_t8_AOV_index], lwtoa043_ai_sysaovs_active[lwtoa043_t8_AOV_index], lwtoa043_t8_colwidth - 10, "scnGen_lwtoa043_aov_stub");
		        ctlposition(lwtoa043_c_ai_sysaovs_active_5, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);

				col_index++;
				lwtoa043_c_ai_sysaovs_type_5 = ctlpopup("", int(lwtoa043_ai_sysaovs_type[lwtoa043_t8_AOV_index]) + 1,lwtoa043_AOV_types);
		        ctlposition(lwtoa043_c_ai_sysaovs_type_5, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);

				col_index++;
				lwtoa043_c_ai_sysaovs_suffix_5 = ctlstring("", lwtoa043_ai_sysaovs_suf[lwtoa043_t8_AOV_index]);
		        ctlposition(lwtoa043_c_ai_sysaovs_suffix_5, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);

				col_index++;
				lwtoa043_c_ai_sysaovs_filter_5 = ctlpopup("", int(lwtoa043_ai_sysaovs_filter[lwtoa043_t8_AOV_index]) + 1,lwtoa043_pixelfilter_array);
		        ctlposition(lwtoa043_c_ai_sysaovs_filter_5, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);

				col_index++;
				lwtoa043_c_ai_sysaovs_gamma_5 = ctlnumber("", lwtoa043_ai_sysaovs_gamma[lwtoa043_t8_AOV_index]);
		        ctlposition(lwtoa043_c_ai_sysaovs_gamma_5, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);

				col_index++;
				lwtoa043_c_ai_sysaovs_file_format_5 = ctlpopup("", lwtoa043_ai_sysaovs_file_format[lwtoa043_t8_AOV_index] + 1,lwtoa043_AOV_formats);
		        ctlposition(lwtoa043_c_ai_sysaovs_file_format_5, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);
	        }

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset;

			if (6 == 6)
			{
				col_index = 1;
				lwtoa043_t8_AOV_index++;
				lwtoa043_c_ai_sysaovs_active_6 = ctlstate(lwtoa043_AOV_array[lwtoa043_t8_AOV_index], lwtoa043_ai_sysaovs_active[lwtoa043_t8_AOV_index], lwtoa043_t8_colwidth - 10, "scnGen_lwtoa043_aov_stub");
		        ctlposition(lwtoa043_c_ai_sysaovs_active_6, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);

				col_index++;
				lwtoa043_c_ai_sysaovs_type_6 = ctlpopup("", int(lwtoa043_ai_sysaovs_type[lwtoa043_t8_AOV_index]) + 1,lwtoa043_AOV_types);
		        ctlposition(lwtoa043_c_ai_sysaovs_type_6, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);

				col_index++;
				lwtoa043_c_ai_sysaovs_suffix_6 = ctlstring("", lwtoa043_ai_sysaovs_suf[lwtoa043_t8_AOV_index]);
		        ctlposition(lwtoa043_c_ai_sysaovs_suffix_6, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);

				col_index++;
				lwtoa043_c_ai_sysaovs_filter_6 = ctlpopup("", int(lwtoa043_ai_sysaovs_filter[lwtoa043_t8_AOV_index]) + 1,lwtoa043_pixelfilter_array);
		        ctlposition(lwtoa043_c_ai_sysaovs_filter_6, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);

				col_index++;
				lwtoa043_c_ai_sysaovs_gamma_6 = ctlnumber("", lwtoa043_ai_sysaovs_gamma[lwtoa043_t8_AOV_index]);
		        ctlposition(lwtoa043_c_ai_sysaovs_gamma_6, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);

				col_index++;
				lwtoa043_c_ai_sysaovs_file_format_6 = ctlpopup("", lwtoa043_ai_sysaovs_file_format[lwtoa043_t8_AOV_index] + 1,lwtoa043_AOV_formats);
		        ctlposition(lwtoa043_c_ai_sysaovs_file_format_6, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);
	        }

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset;

			if (7 == 7)
			{
				col_index = 1;
				lwtoa043_t8_AOV_index++;
				lwtoa043_c_ai_sysaovs_active_7 = ctlstate(lwtoa043_AOV_array[lwtoa043_t8_AOV_index], lwtoa043_ai_sysaovs_active[lwtoa043_t8_AOV_index], lwtoa043_t8_colwidth - 10, "scnGen_lwtoa043_aov_stub");
		        ctlposition(lwtoa043_c_ai_sysaovs_active_7, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);

				col_index++;
				lwtoa043_c_ai_sysaovs_type_7 = ctlpopup("", int(lwtoa043_ai_sysaovs_type[lwtoa043_t8_AOV_index]) + 1,lwtoa043_AOV_types);
		        ctlposition(lwtoa043_c_ai_sysaovs_type_7, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);

				col_index++;
				lwtoa043_c_ai_sysaovs_suffix_7 = ctlstring("", lwtoa043_ai_sysaovs_suf[lwtoa043_t8_AOV_index]);
		        ctlposition(lwtoa043_c_ai_sysaovs_suffix_7, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);

				col_index++;
				lwtoa043_c_ai_sysaovs_filter_7 = ctlpopup("", int(lwtoa043_ai_sysaovs_filter[lwtoa043_t8_AOV_index]) + 1,lwtoa043_pixelfilter_array);
		        ctlposition(lwtoa043_c_ai_sysaovs_filter_7, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);

				col_index++;
				lwtoa043_c_ai_sysaovs_gamma_7 = ctlnumber("", lwtoa043_ai_sysaovs_gamma[lwtoa043_t8_AOV_index]);
		        ctlposition(lwtoa043_c_ai_sysaovs_gamma_7, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);

				col_index++;
				lwtoa043_c_ai_sysaovs_file_format_7 = ctlpopup("", lwtoa043_ai_sysaovs_file_format[lwtoa043_t8_AOV_index] + 1,lwtoa043_AOV_formats);
		        ctlposition(lwtoa043_c_ai_sysaovs_file_format_7, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);
	        }

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset;

			if (8 == 8)
			{
				col_index = 1;
				lwtoa043_t8_AOV_index++;
				lwtoa043_c_ai_sysaovs_active_8 = ctlstate(lwtoa043_AOV_array[lwtoa043_t8_AOV_index], lwtoa043_ai_sysaovs_active[lwtoa043_t8_AOV_index], lwtoa043_t8_colwidth - 10, "scnGen_lwtoa043_aov_stub");
		        ctlposition(lwtoa043_c_ai_sysaovs_active_8, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);

				col_index++;
				lwtoa043_c_ai_sysaovs_type_8 = ctlpopup("", int(lwtoa043_ai_sysaovs_type[lwtoa043_t8_AOV_index]) + 1,lwtoa043_AOV_types);
		        ctlposition(lwtoa043_c_ai_sysaovs_type_8, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);

				col_index++;
				lwtoa043_c_ai_sysaovs_suffix_8 = ctlstring("", lwtoa043_ai_sysaovs_suf[lwtoa043_t8_AOV_index]);
		        ctlposition(lwtoa043_c_ai_sysaovs_suffix_8, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);

				col_index++;
				lwtoa043_c_ai_sysaovs_filter_8 = ctlpopup("", int(lwtoa043_ai_sysaovs_filter[lwtoa043_t8_AOV_index]) + 1,lwtoa043_pixelfilter_array);
		        ctlposition(lwtoa043_c_ai_sysaovs_filter_8, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);

				col_index++;
				lwtoa043_c_ai_sysaovs_gamma_8 = ctlnumber("", lwtoa043_ai_sysaovs_gamma[lwtoa043_t8_AOV_index]);
		        ctlposition(lwtoa043_c_ai_sysaovs_gamma_8, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);

				col_index++;
				lwtoa043_c_ai_sysaovs_file_format_8 = ctlpopup("", lwtoa043_ai_sysaovs_file_format[lwtoa043_t8_AOV_index] + 1,lwtoa043_AOV_formats);
		        ctlposition(lwtoa043_c_ai_sysaovs_file_format_8, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);
	        }

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset;

			if (9 == 9)
			{
				col_index = 1;
				lwtoa043_t8_AOV_index++;
				lwtoa043_c_ai_sysaovs_active_9 = ctlstate(lwtoa043_AOV_array[lwtoa043_t8_AOV_index], lwtoa043_ai_sysaovs_active[lwtoa043_t8_AOV_index], lwtoa043_t8_colwidth - 10, "scnGen_lwtoa043_aov_stub");
		        ctlposition(lwtoa043_c_ai_sysaovs_active_9, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);

				col_index++;
				lwtoa043_c_ai_sysaovs_type_9 = ctlpopup("", int(lwtoa043_ai_sysaovs_type[lwtoa043_t8_AOV_index]) + 1,lwtoa043_AOV_types);
		        ctlposition(lwtoa043_c_ai_sysaovs_type_9, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);

				col_index++;
				lwtoa043_c_ai_sysaovs_suffix_9 = ctlstring("", lwtoa043_ai_sysaovs_suf[lwtoa043_t8_AOV_index]);
		        ctlposition(lwtoa043_c_ai_sysaovs_suffix_9, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);

				col_index++;
				lwtoa043_c_ai_sysaovs_filter_9 = ctlpopup("", int(lwtoa043_ai_sysaovs_filter[lwtoa043_t8_AOV_index]) + 1,lwtoa043_pixelfilter_array);
		        ctlposition(lwtoa043_c_ai_sysaovs_filter_9, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);

				col_index++;
				lwtoa043_c_ai_sysaovs_gamma_9 = ctlnumber("", lwtoa043_ai_sysaovs_gamma[lwtoa043_t8_AOV_index]);
		        ctlposition(lwtoa043_c_ai_sysaovs_gamma_9, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);

				col_index++;
				lwtoa043_c_ai_sysaovs_file_format_9 = ctlpopup("", lwtoa043_ai_sysaovs_file_format[lwtoa043_t8_AOV_index] + 1,lwtoa043_AOV_formats);
		        ctlposition(lwtoa043_c_ai_sysaovs_file_format_9, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);
	        }

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset;

			if (10 == 10)
			{
				col_index = 1;
				lwtoa043_t8_AOV_index++;
				lwtoa043_c_ai_sysaovs_active_10 = ctlstate(lwtoa043_AOV_array[lwtoa043_t8_AOV_index], lwtoa043_ai_sysaovs_active[lwtoa043_t8_AOV_index], lwtoa043_t8_colwidth - 10, "scnGen_lwtoa043_aov_stub");
		        ctlposition(lwtoa043_c_ai_sysaovs_active_10, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);

				col_index++;
				lwtoa043_c_ai_sysaovs_type_10 = ctlpopup("", int(lwtoa043_ai_sysaovs_type[lwtoa043_t8_AOV_index]) + 1,lwtoa043_AOV_types);
		        ctlposition(lwtoa043_c_ai_sysaovs_type_10, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);

				col_index++;
				lwtoa043_c_ai_sysaovs_suffix_10 = ctlstring("", lwtoa043_ai_sysaovs_suf[lwtoa043_t8_AOV_index]);
		        ctlposition(lwtoa043_c_ai_sysaovs_suffix_10, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);

				col_index++;
				lwtoa043_c_ai_sysaovs_filter_10 = ctlpopup("", int(lwtoa043_ai_sysaovs_filter[lwtoa043_t8_AOV_index]) + 1,lwtoa043_pixelfilter_array);
		        ctlposition(lwtoa043_c_ai_sysaovs_filter_10, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);

				col_index++;
				lwtoa043_c_ai_sysaovs_gamma_10 = ctlnumber("", lwtoa043_ai_sysaovs_gamma[lwtoa043_t8_AOV_index]);
		        ctlposition(lwtoa043_c_ai_sysaovs_gamma_10, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);

				col_index++;
				lwtoa043_c_ai_sysaovs_file_format_10 = ctlpopup("", lwtoa043_ai_sysaovs_file_format[lwtoa043_t8_AOV_index] + 1,lwtoa043_AOV_formats);
		        ctlposition(lwtoa043_c_ai_sysaovs_file_format_10, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);
	        }

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset;

			if (11 == 11)
			{
				col_index = 1;
				lwtoa043_t8_AOV_index++;
				lwtoa043_c_ai_sysaovs_active_11 = ctlstate(lwtoa043_AOV_array[lwtoa043_t8_AOV_index], lwtoa043_ai_sysaovs_active[lwtoa043_t8_AOV_index], lwtoa043_t8_colwidth - 10, "scnGen_lwtoa043_aov_stub");
		        ctlposition(lwtoa043_c_ai_sysaovs_active_11, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);

				col_index++;
				lwtoa043_c_ai_sysaovs_type_11 = ctlpopup("", int(lwtoa043_ai_sysaovs_type[lwtoa043_t8_AOV_index]) + 1,lwtoa043_AOV_types);
		        ctlposition(lwtoa043_c_ai_sysaovs_type_11, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);

				col_index++;
				lwtoa043_c_ai_sysaovs_suffix_11 = ctlstring("", lwtoa043_ai_sysaovs_suf[lwtoa043_t8_AOV_index]);
		        ctlposition(lwtoa043_c_ai_sysaovs_suffix_11, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);

				col_index++;
				lwtoa043_c_ai_sysaovs_filter_11 = ctlpopup("", int(lwtoa043_ai_sysaovs_filter[lwtoa043_t8_AOV_index]) + 1,lwtoa043_pixelfilter_array);
		        ctlposition(lwtoa043_c_ai_sysaovs_filter_11, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);

				col_index++;
				lwtoa043_c_ai_sysaovs_gamma_11 = ctlnumber("", lwtoa043_ai_sysaovs_gamma[lwtoa043_t8_AOV_index]);
		        ctlposition(lwtoa043_c_ai_sysaovs_gamma_11, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);

				col_index++;
				lwtoa043_c_ai_sysaovs_file_format_11 = ctlpopup("", lwtoa043_ai_sysaovs_file_format[lwtoa043_t8_AOV_index] + 1,lwtoa043_AOV_formats);
		        ctlposition(lwtoa043_c_ai_sysaovs_file_format_11, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);
	        }

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset;

			if (12 == 12)
			{
				col_index = 1;
				lwtoa043_t8_AOV_index++;
				lwtoa043_c_ai_sysaovs_active_12 = ctlstate(lwtoa043_AOV_array[lwtoa043_t8_AOV_index], lwtoa043_ai_sysaovs_active[lwtoa043_t8_AOV_index], lwtoa043_t8_colwidth - 10, "scnGen_lwtoa043_aov_stub");
		        ctlposition(lwtoa043_c_ai_sysaovs_active_12, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);

				col_index++;
				lwtoa043_c_ai_sysaovs_type_12 = ctlpopup("", int(lwtoa043_ai_sysaovs_type[lwtoa043_t8_AOV_index]) + 1,lwtoa043_AOV_types);
		        ctlposition(lwtoa043_c_ai_sysaovs_type_12, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);

				col_index++;
				lwtoa043_c_ai_sysaovs_suffix_12 = ctlstring("", lwtoa043_ai_sysaovs_suf[lwtoa043_t8_AOV_index]);
		        ctlposition(lwtoa043_c_ai_sysaovs_suffix_12, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);

				col_index++;
				lwtoa043_c_ai_sysaovs_filter_12 = ctlpopup("", int(lwtoa043_ai_sysaovs_filter[lwtoa043_t8_AOV_index]) + 1,lwtoa043_pixelfilter_array);
		        ctlposition(lwtoa043_c_ai_sysaovs_filter_12, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);

				col_index++;
				lwtoa043_c_ai_sysaovs_gamma_12 = ctlnumber("", lwtoa043_ai_sysaovs_gamma[lwtoa043_t8_AOV_index]);
		        ctlposition(lwtoa043_c_ai_sysaovs_gamma_12, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);

				col_index++;
				lwtoa043_c_ai_sysaovs_file_format_12 = ctlpopup("", lwtoa043_ai_sysaovs_file_format[lwtoa043_t8_AOV_index] + 1,lwtoa043_AOV_formats);
		        ctlposition(lwtoa043_c_ai_sysaovs_file_format_12, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);
	        }

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset;

			if (13 == 13)
			{
				col_index = 1;
				lwtoa043_t8_AOV_index++;
				lwtoa043_c_ai_sysaovs_active_13 = ctlstate(lwtoa043_AOV_array[lwtoa043_t8_AOV_index], lwtoa043_ai_sysaovs_active[lwtoa043_t8_AOV_index], lwtoa043_t8_colwidth - 10, "scnGen_lwtoa043_aov_stub");
		        ctlposition(lwtoa043_c_ai_sysaovs_active_13, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);

				col_index++;
				lwtoa043_c_ai_sysaovs_type_13 = ctlpopup("", int(lwtoa043_ai_sysaovs_type[lwtoa043_t8_AOV_index]) + 1,lwtoa043_AOV_types);
		        ctlposition(lwtoa043_c_ai_sysaovs_type_13, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);

				col_index++;
				lwtoa043_c_ai_sysaovs_suffix_13 = ctlstring("", lwtoa043_ai_sysaovs_suf[lwtoa043_t8_AOV_index]);
		        ctlposition(lwtoa043_c_ai_sysaovs_suffix_13, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);

				col_index++;
				lwtoa043_c_ai_sysaovs_filter_13 = ctlpopup("", int(lwtoa043_ai_sysaovs_filter[lwtoa043_t8_AOV_index]) + 1,lwtoa043_pixelfilter_array);
		        ctlposition(lwtoa043_c_ai_sysaovs_filter_13, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);

				col_index++;
				lwtoa043_c_ai_sysaovs_gamma_13 = ctlnumber("", lwtoa043_ai_sysaovs_gamma[lwtoa043_t8_AOV_index]);
		        ctlposition(lwtoa043_c_ai_sysaovs_gamma_13, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);

				col_index++;
				lwtoa043_c_ai_sysaovs_file_format_13 = ctlpopup("", lwtoa043_ai_sysaovs_file_format[lwtoa043_t8_AOV_index] + 1,lwtoa043_AOV_formats);
		        ctlposition(lwtoa043_c_ai_sysaovs_file_format_13, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);
	        }

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset;

			if (14 == 14)
			{
				col_index = 1;
				lwtoa043_t8_AOV_index++;
				lwtoa043_c_ai_sysaovs_active_14 = ctlstate(lwtoa043_AOV_array[lwtoa043_t8_AOV_index], lwtoa043_ai_sysaovs_active[lwtoa043_t8_AOV_index], lwtoa043_t8_colwidth - 10, "scnGen_lwtoa043_aov_stub");
		        ctlposition(lwtoa043_c_ai_sysaovs_active_14, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);

				col_index++;
				lwtoa043_c_ai_sysaovs_type_14 = ctlpopup("", int(lwtoa043_ai_sysaovs_type[lwtoa043_t8_AOV_index]) + 1,lwtoa043_AOV_types);
		        ctlposition(lwtoa043_c_ai_sysaovs_type_14, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);

				col_index++;
				lwtoa043_c_ai_sysaovs_suffix_14 = ctlstring("", lwtoa043_ai_sysaovs_suf[lwtoa043_t8_AOV_index]);
		        ctlposition(lwtoa043_c_ai_sysaovs_suffix_14, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);

				col_index++;
				lwtoa043_c_ai_sysaovs_filter_14 = ctlpopup("", int(lwtoa043_ai_sysaovs_filter[lwtoa043_t8_AOV_index]) + 1,lwtoa043_pixelfilter_array);
		        ctlposition(lwtoa043_c_ai_sysaovs_filter_14, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);

				col_index++;
				lwtoa043_c_ai_sysaovs_gamma_14 = ctlnumber("", lwtoa043_ai_sysaovs_gamma[lwtoa043_t8_AOV_index]);
		        ctlposition(lwtoa043_c_ai_sysaovs_gamma_14, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);

				col_index++;
				lwtoa043_c_ai_sysaovs_file_format_14 = ctlpopup("", lwtoa043_ai_sysaovs_file_format[lwtoa043_t8_AOV_index] + 1,lwtoa043_AOV_formats);
		        ctlposition(lwtoa043_c_ai_sysaovs_file_format_14, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);
	        }

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset;

			if (15 == 15)
			{
				col_index = 1;
				lwtoa043_t8_AOV_index++;
				lwtoa043_c_ai_sysaovs_active_15 = ctlstate(lwtoa043_AOV_array[lwtoa043_t8_AOV_index], lwtoa043_ai_sysaovs_active[lwtoa043_t8_AOV_index], lwtoa043_t8_colwidth - 10, "scnGen_lwtoa043_aov_stub");
		        ctlposition(lwtoa043_c_ai_sysaovs_active_15, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);

				col_index++;
				lwtoa043_c_ai_sysaovs_type_15 = ctlpopup("", int(lwtoa043_ai_sysaovs_type[lwtoa043_t8_AOV_index]) + 1,lwtoa043_AOV_types);
		        ctlposition(lwtoa043_c_ai_sysaovs_type_15, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);

				col_index++;
				lwtoa043_c_ai_sysaovs_suffix_15 = ctlstring("", lwtoa043_ai_sysaovs_suf[lwtoa043_t8_AOV_index]);
		        ctlposition(lwtoa043_c_ai_sysaovs_suffix_15, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);

				col_index++;
				lwtoa043_c_ai_sysaovs_filter_15 = ctlpopup("", int(lwtoa043_ai_sysaovs_filter[lwtoa043_t8_AOV_index]) + 1,lwtoa043_pixelfilter_array);
		        ctlposition(lwtoa043_c_ai_sysaovs_filter_15, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);

				col_index++;
				lwtoa043_c_ai_sysaovs_gamma_15 = ctlnumber("", lwtoa043_ai_sysaovs_gamma[lwtoa043_t8_AOV_index]);
		        ctlposition(lwtoa043_c_ai_sysaovs_gamma_15, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);

				col_index++;
				lwtoa043_c_ai_sysaovs_file_format_15 = ctlpopup("", lwtoa043_ai_sysaovs_file_format[lwtoa043_t8_AOV_index] + 1,lwtoa043_AOV_formats);
		        ctlposition(lwtoa043_c_ai_sysaovs_file_format_15, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);
	        }

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset;

			if (16 == 16)
			{
				col_index = 1;
				lwtoa043_t8_AOV_index++;
				lwtoa043_c_ai_sysaovs_active_16 = ctlstate(lwtoa043_AOV_array[lwtoa043_t8_AOV_index], lwtoa043_ai_sysaovs_active[lwtoa043_t8_AOV_index], lwtoa043_t8_colwidth - 10, "scnGen_lwtoa043_aov_stub");
		        ctlposition(lwtoa043_c_ai_sysaovs_active_16, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);

				col_index++;
				lwtoa043_c_ai_sysaovs_type_16 = ctlpopup("", int(lwtoa043_ai_sysaovs_type[lwtoa043_t8_AOV_index]) + 1,lwtoa043_AOV_types);
		        ctlposition(lwtoa043_c_ai_sysaovs_type_16, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);

				col_index++;
				lwtoa043_c_ai_sysaovs_suffix_16 = ctlstring("", lwtoa043_ai_sysaovs_suf[lwtoa043_t8_AOV_index]);
		        ctlposition(lwtoa043_c_ai_sysaovs_suffix_16, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);

				col_index++;
				lwtoa043_c_ai_sysaovs_filter_16 = ctlpopup("", int(lwtoa043_ai_sysaovs_filter[lwtoa043_t8_AOV_index]) + 1,lwtoa043_pixelfilter_array);
		        ctlposition(lwtoa043_c_ai_sysaovs_filter_16, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);

				col_index++;
				lwtoa043_c_ai_sysaovs_gamma_16 = ctlnumber("", lwtoa043_ai_sysaovs_gamma[lwtoa043_t8_AOV_index]);
		        ctlposition(lwtoa043_c_ai_sysaovs_gamma_16, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);

				col_index++;
				lwtoa043_c_ai_sysaovs_file_format_16 = ctlpopup("", lwtoa043_ai_sysaovs_file_format[lwtoa043_t8_AOV_index] + 1,lwtoa043_AOV_formats);
		        ctlposition(lwtoa043_c_ai_sysaovs_file_format_16, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);
	        }

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset;

			if (17 == 17)
			{
				col_index = 1;
				lwtoa043_t8_AOV_index++;
				lwtoa043_c_ai_sysaovs_active_17 = ctlstate(lwtoa043_AOV_array[lwtoa043_t8_AOV_index], lwtoa043_ai_sysaovs_active[lwtoa043_t8_AOV_index], lwtoa043_t8_colwidth - 10, "scnGen_lwtoa043_aov_stub");
		        ctlposition(lwtoa043_c_ai_sysaovs_active_17, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);

				col_index++;
				lwtoa043_c_ai_sysaovs_type_17 = ctlpopup("", int(lwtoa043_ai_sysaovs_type[lwtoa043_t8_AOV_index]) + 1,lwtoa043_AOV_types);
		        ctlposition(lwtoa043_c_ai_sysaovs_type_17, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);

				col_index++;
				lwtoa043_c_ai_sysaovs_suffix_17 = ctlstring("", lwtoa043_ai_sysaovs_suf[lwtoa043_t8_AOV_index]);
		        ctlposition(lwtoa043_c_ai_sysaovs_suffix_17, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);

				col_index++;
				lwtoa043_c_ai_sysaovs_filter_17 = ctlpopup("", int(lwtoa043_ai_sysaovs_filter[lwtoa043_t8_AOV_index]) + 1,lwtoa043_pixelfilter_array);
		        ctlposition(lwtoa043_c_ai_sysaovs_filter_17, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);

				col_index++;
				lwtoa043_c_ai_sysaovs_gamma_17 = ctlnumber("", lwtoa043_ai_sysaovs_gamma[lwtoa043_t8_AOV_index]);
		        ctlposition(lwtoa043_c_ai_sysaovs_gamma_17, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);

				col_index++;
				lwtoa043_c_ai_sysaovs_file_format_17 = ctlpopup("", lwtoa043_ai_sysaovs_file_format[lwtoa043_t8_AOV_index] + 1,lwtoa043_AOV_formats);
		        ctlposition(lwtoa043_c_ai_sysaovs_file_format_17, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);
	        }

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset;

			if (18 == 18)
			{
				col_index = 1;
				lwtoa043_t8_AOV_index++;
				lwtoa043_c_ai_sysaovs_active_18 = ctlstate(lwtoa043_AOV_array[lwtoa043_t8_AOV_index], lwtoa043_ai_sysaovs_active[lwtoa043_t8_AOV_index], lwtoa043_t8_colwidth - 10, "scnGen_lwtoa043_aov_stub");
		        ctlposition(lwtoa043_c_ai_sysaovs_active_18, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);

				col_index++;
				lwtoa043_c_ai_sysaovs_type_18 = ctlpopup("", int(lwtoa043_ai_sysaovs_type[lwtoa043_t8_AOV_index]) + 1,lwtoa043_AOV_types);
		        ctlposition(lwtoa043_c_ai_sysaovs_type_18, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);

				col_index++;
				lwtoa043_c_ai_sysaovs_suffix_18 = ctlstring("", lwtoa043_ai_sysaovs_suf[lwtoa043_t8_AOV_index]);
		        ctlposition(lwtoa043_c_ai_sysaovs_suffix_18, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);

				col_index++;
				lwtoa043_c_ai_sysaovs_filter_18 = ctlpopup("", int(lwtoa043_ai_sysaovs_filter[lwtoa043_t8_AOV_index]) + 1,lwtoa043_pixelfilter_array);
		        ctlposition(lwtoa043_c_ai_sysaovs_filter_18, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);

				col_index++;
				lwtoa043_c_ai_sysaovs_gamma_18 = ctlnumber("", lwtoa043_ai_sysaovs_gamma[lwtoa043_t8_AOV_index]);
		        ctlposition(lwtoa043_c_ai_sysaovs_gamma_18, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);

				col_index++;
				lwtoa043_c_ai_sysaovs_file_format_18 = ctlpopup("", lwtoa043_ai_sysaovs_file_format[lwtoa043_t8_AOV_index] + 1,lwtoa043_AOV_formats);
		        ctlposition(lwtoa043_c_ai_sysaovs_file_format_18, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);
	        }

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset;

			if (19 == 19)
			{
				col_index = 1;
				lwtoa043_t8_AOV_index++;
				lwtoa043_c_ai_sysaovs_active_19 = ctlstate(lwtoa043_AOV_array[lwtoa043_t8_AOV_index], lwtoa043_ai_sysaovs_active[lwtoa043_t8_AOV_index], lwtoa043_t8_colwidth - 10, "scnGen_lwtoa043_aov_stub");
		        ctlposition(lwtoa043_c_ai_sysaovs_active_19, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);

				col_index++;
				lwtoa043_c_ai_sysaovs_type_19 = ctlpopup("", int(lwtoa043_ai_sysaovs_type[lwtoa043_t8_AOV_index]) + 1,lwtoa043_AOV_types);
		        ctlposition(lwtoa043_c_ai_sysaovs_type_19, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);

				col_index++;
				lwtoa043_c_ai_sysaovs_suffix_19 = ctlstring("", lwtoa043_ai_sysaovs_suf[lwtoa043_t8_AOV_index]);
		        ctlposition(lwtoa043_c_ai_sysaovs_suffix_19, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);

				col_index++;
				lwtoa043_c_ai_sysaovs_filter_19 = ctlpopup("", int(lwtoa043_ai_sysaovs_filter[lwtoa043_t8_AOV_index]) + 1,lwtoa043_pixelfilter_array);
		        ctlposition(lwtoa043_c_ai_sysaovs_filter_19, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);

				col_index++;
				lwtoa043_c_ai_sysaovs_gamma_19 = ctlnumber("", lwtoa043_ai_sysaovs_gamma[lwtoa043_t8_AOV_index]);
		        ctlposition(lwtoa043_c_ai_sysaovs_gamma_19, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);

				col_index++;
				lwtoa043_c_ai_sysaovs_file_format_19 = ctlpopup("", lwtoa043_ai_sysaovs_file_format[lwtoa043_t8_AOV_index] + 1,lwtoa043_AOV_formats);
		        ctlposition(lwtoa043_c_ai_sysaovs_file_format_19, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);
	        }

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset;

			if (20 == 20)
			{
				col_index = 1;
				lwtoa043_t8_AOV_index++;
				lwtoa043_c_ai_sysaovs_active_20 = ctlstate(lwtoa043_AOV_array[lwtoa043_t8_AOV_index], lwtoa043_ai_sysaovs_active[lwtoa043_t8_AOV_index], lwtoa043_t8_colwidth - 10, "scnGen_lwtoa043_aov_stub");
		        ctlposition(lwtoa043_c_ai_sysaovs_active_20, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);

				col_index++;
				lwtoa043_c_ai_sysaovs_type_20 = ctlpopup("", int(lwtoa043_ai_sysaovs_type[lwtoa043_t8_AOV_index]) + 1,lwtoa043_AOV_types);
		        ctlposition(lwtoa043_c_ai_sysaovs_type_20, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);

				col_index++;
				lwtoa043_c_ai_sysaovs_suffix_20 = ctlstring("", lwtoa043_ai_sysaovs_suf[lwtoa043_t8_AOV_index]);
		        ctlposition(lwtoa043_c_ai_sysaovs_suffix_20, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);

				col_index++;
				lwtoa043_c_ai_sysaovs_filter_20 = ctlpopup("", int(lwtoa043_ai_sysaovs_filter[lwtoa043_t8_AOV_index]) + 1,lwtoa043_pixelfilter_array);
		        ctlposition(lwtoa043_c_ai_sysaovs_filter_20, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);

				col_index++;
				lwtoa043_c_ai_sysaovs_gamma_20 = ctlnumber("", lwtoa043_ai_sysaovs_gamma[lwtoa043_t8_AOV_index]);
		        ctlposition(lwtoa043_c_ai_sysaovs_gamma_20, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);

				col_index++;
				lwtoa043_c_ai_sysaovs_file_format_20 = ctlpopup("", lwtoa043_ai_sysaovs_file_format[lwtoa043_t8_AOV_index] + 1,lwtoa043_AOV_formats);
		        ctlposition(lwtoa043_c_ai_sysaovs_file_format_20, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);
	        }

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset;

			if (21 == 21)
			{
				col_index = 1;
				lwtoa043_t8_AOV_index++;
				lwtoa043_c_ai_sysaovs_active_21 = ctlstate(lwtoa043_AOV_array[lwtoa043_t8_AOV_index], lwtoa043_ai_sysaovs_active[lwtoa043_t8_AOV_index], lwtoa043_t8_colwidth - 10, "scnGen_lwtoa043_aov_stub");
		        ctlposition(lwtoa043_c_ai_sysaovs_active_21, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);

				col_index++;
				lwtoa043_c_ai_sysaovs_type_21 = ctlpopup("", int(lwtoa043_ai_sysaovs_type[lwtoa043_t8_AOV_index]) + 1,lwtoa043_AOV_types);
		        ctlposition(lwtoa043_c_ai_sysaovs_type_21, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);

				col_index++;
				lwtoa043_c_ai_sysaovs_suffix_21 = ctlstring("", lwtoa043_ai_sysaovs_suf[lwtoa043_t8_AOV_index]);
		        ctlposition(lwtoa043_c_ai_sysaovs_suffix_21, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);

				col_index++;
				lwtoa043_c_ai_sysaovs_filter_21 = ctlpopup("", int(lwtoa043_ai_sysaovs_filter[lwtoa043_t8_AOV_index]) + 1,lwtoa043_pixelfilter_array);
		        ctlposition(lwtoa043_c_ai_sysaovs_filter_21, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);

				col_index++;
				lwtoa043_c_ai_sysaovs_gamma_21 = ctlnumber("", lwtoa043_ai_sysaovs_gamma[lwtoa043_t8_AOV_index]);
		        ctlposition(lwtoa043_c_ai_sysaovs_gamma_21, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);

				col_index++;
				lwtoa043_c_ai_sysaovs_file_format_21 = ctlpopup("", lwtoa043_ai_sysaovs_file_format[lwtoa043_t8_AOV_index] + 1,lwtoa043_AOV_formats);
		        ctlposition(lwtoa043_c_ai_sysaovs_file_format_21, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);
	        }

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset;

			if (22 == 22)
			{
				col_index = 1;
				lwtoa043_t8_AOV_index++;
				lwtoa043_c_ai_sysaovs_active_22 = ctlstate(lwtoa043_AOV_array[lwtoa043_t8_AOV_index], lwtoa043_ai_sysaovs_active[lwtoa043_t8_AOV_index], lwtoa043_t8_colwidth - 10, "scnGen_lwtoa043_aov_stub");
		        ctlposition(lwtoa043_c_ai_sysaovs_active_22, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);

				col_index++;
				lwtoa043_c_ai_sysaovs_type_22 = ctlpopup("", int(lwtoa043_ai_sysaovs_type[lwtoa043_t8_AOV_index]) + 1,lwtoa043_AOV_types);
		        ctlposition(lwtoa043_c_ai_sysaovs_type_22, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);

				col_index++;
				lwtoa043_c_ai_sysaovs_suffix_22 = ctlstring("", lwtoa043_ai_sysaovs_suf[lwtoa043_t8_AOV_index]);
		        ctlposition(lwtoa043_c_ai_sysaovs_suffix_22, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);

				col_index++;
				lwtoa043_c_ai_sysaovs_filter_22 = ctlpopup("", int(lwtoa043_ai_sysaovs_filter[lwtoa043_t8_AOV_index]) + 1,lwtoa043_pixelfilter_array);
		        ctlposition(lwtoa043_c_ai_sysaovs_filter_22, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);

				col_index++;
				lwtoa043_c_ai_sysaovs_gamma_22 = ctlnumber("", lwtoa043_ai_sysaovs_gamma[lwtoa043_t8_AOV_index]);
		        ctlposition(lwtoa043_c_ai_sysaovs_gamma_22, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);

				col_index++;
				lwtoa043_c_ai_sysaovs_file_format_22 = ctlpopup("", lwtoa043_ai_sysaovs_file_format[lwtoa043_t8_AOV_index] + 1,lwtoa043_AOV_formats);
		        ctlposition(lwtoa043_c_ai_sysaovs_file_format_22, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);
	        }

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset;

			if (23 == 23)
			{
				col_index = 1;
				lwtoa043_t8_AOV_index++;
				lwtoa043_c_ai_sysaovs_active_23 = ctlstate(lwtoa043_AOV_array[lwtoa043_t8_AOV_index], lwtoa043_ai_sysaovs_active[lwtoa043_t8_AOV_index], lwtoa043_t8_colwidth - 10, "scnGen_lwtoa043_aov_stub");
		        ctlposition(lwtoa043_c_ai_sysaovs_active_23, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);

				col_index++;
				lwtoa043_c_ai_sysaovs_type_23 = ctlpopup("", int(lwtoa043_ai_sysaovs_type[lwtoa043_t8_AOV_index]) + 1,lwtoa043_AOV_types);
		        ctlposition(lwtoa043_c_ai_sysaovs_type_23, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);

				col_index++;
				lwtoa043_c_ai_sysaovs_suffix_23 = ctlstring("", lwtoa043_ai_sysaovs_suf[lwtoa043_t8_AOV_index]);
		        ctlposition(lwtoa043_c_ai_sysaovs_suffix_23, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);

				col_index++;
				lwtoa043_c_ai_sysaovs_filter_23 = ctlpopup("", int(lwtoa043_ai_sysaovs_filter[lwtoa043_t8_AOV_index]) + 1,lwtoa043_pixelfilter_array);
		        ctlposition(lwtoa043_c_ai_sysaovs_filter_23, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);

				col_index++;
				lwtoa043_c_ai_sysaovs_gamma_23 = ctlnumber("", lwtoa043_ai_sysaovs_gamma[lwtoa043_t8_AOV_index]);
		        ctlposition(lwtoa043_c_ai_sysaovs_gamma_23, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);

				col_index++;
				lwtoa043_c_ai_sysaovs_file_format_23 = ctlpopup("", lwtoa043_ai_sysaovs_file_format[lwtoa043_t8_AOV_index] + 1,lwtoa043_AOV_formats);
		        ctlposition(lwtoa043_c_ai_sysaovs_file_format_23, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);
	        }

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset;

			if (24 == 24)
			{
				col_index = 1;
				lwtoa043_t8_AOV_index++;
				lwtoa043_c_ai_sysaovs_active_24 = ctlstate(lwtoa043_AOV_array[lwtoa043_t8_AOV_index], lwtoa043_ai_sysaovs_active[lwtoa043_t8_AOV_index], lwtoa043_t8_colwidth - 10, "scnGen_lwtoa043_aov_stub");
		        ctlposition(lwtoa043_c_ai_sysaovs_active_24, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);

				col_index++;
				lwtoa043_c_ai_sysaovs_type_24 = ctlpopup("", int(lwtoa043_ai_sysaovs_type[lwtoa043_t8_AOV_index]) + 1,lwtoa043_AOV_types);
		        ctlposition(lwtoa043_c_ai_sysaovs_type_24, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);

				col_index++;
				lwtoa043_c_ai_sysaovs_suffix_24 = ctlstring("", lwtoa043_ai_sysaovs_suf[lwtoa043_t8_AOV_index]);
		        ctlposition(lwtoa043_c_ai_sysaovs_suffix_24, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);

				col_index++;
				lwtoa043_c_ai_sysaovs_filter_24 = ctlpopup("", int(lwtoa043_ai_sysaovs_filter[lwtoa043_t8_AOV_index]) + 1,lwtoa043_pixelfilter_array);
		        ctlposition(lwtoa043_c_ai_sysaovs_filter_24, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);

				col_index++;
				lwtoa043_c_ai_sysaovs_gamma_24 = ctlnumber("", lwtoa043_ai_sysaovs_gamma[lwtoa043_t8_AOV_index]);
		        ctlposition(lwtoa043_c_ai_sysaovs_gamma_24, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);

				col_index++;
				lwtoa043_c_ai_sysaovs_file_format_24 = ctlpopup("", lwtoa043_ai_sysaovs_file_format[lwtoa043_t8_AOV_index] + 1,lwtoa043_AOV_formats);
		        ctlposition(lwtoa043_c_ai_sysaovs_file_format_24, (col_index - 1) * lwtoa043_t8_colwidth, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth - 10, lwtoa043_gad_h);
	        }

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset * 1.5;

	        lwtoa043_sep_t8_2 = ctlsep(0, lwtoa043_ui_seperator_w);
	        ctlposition(lwtoa043_sep_t8_2, 1, lwtoa043_ui_offset_y);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset/2;

			lwtoa043_c_ai_sysaovs_fileoptions_path = ctlfoldername("Output file", lwtoa043_ai_sysaovs_fileoptions_path);
			ctlposition(lwtoa043_c_ai_sysaovs_fileoptions_path, (lwtoa043_ui_window_w - (buttonWidth + lwtoa043_gad_wc))/2, lwtoa043_ui_offset_y, buttonWidth + lwtoa043_gad_wc, lwtoa043_gad_h,lwtoa043_gad_wc);
			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset * 1.5;

	        lwtoa043_sep_t8_3 = ctlsep(0, lwtoa043_ui_seperator_w);
	        ctlposition(lwtoa043_sep_t8_3, 1, lwtoa043_ui_offset_y);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset/2;

			lwtoa043_t8_colwidth2 = lwtoa043_ui_window_w / 5;
			col_index = 0;

			lwtoa043_exroptions = ctltext("", "EXR options");
			ctlposition(lwtoa043_exroptions, 1, lwtoa043_ui_offset_y);

			col_index = 1;
			lwtoa043_ai_sysaovs_fileoptions_exr_compress++; // 1-based in LScript, 0-based in Arnold.
			lwtoa043_c_ai_sysaovs_fileoptions_exr_compress = ctlpopup("", lwtoa043_ai_sysaovs_fileoptions_exr_compress,lwtoa043_exr_options_array);
			ctlposition(lwtoa043_c_ai_sysaovs_fileoptions_exr_compress, col_index * lwtoa043_t8_colwidth2, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth2 - 10, lwtoa043_gad_h);

			col_index = 2;
			lwtoa043_c_ai_sysaovs_fileoptions_exr_half = ctlstate("half depth", lwtoa043_ai_sysaovs_fileoptions_exr_half, lwtoa043_t8_colwidth2 - 10, "scnGen_lwtoa043_aov_stub");
	        ctlposition(lwtoa043_c_ai_sysaovs_fileoptions_exr_half, col_index * lwtoa043_t8_colwidth2, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth2 - 10, lwtoa043_gad_h);

			col_index = 3;
			lwtoa043_c_ai_sysaovs_fileoptions_exr_tiled = ctlstate("Tiled", lwtoa043_ai_sysaovs_fileoptions_exr_tiled, lwtoa043_t8_colwidth2 - 10, "scnGen_lwtoa043_aov_stub");
	        ctlposition(lwtoa043_c_ai_sysaovs_fileoptions_exr_tiled, col_index * lwtoa043_t8_colwidth2, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth2 - 10, lwtoa043_gad_h);

			col_index = 4;
			lwtoa043_c_ai_sysaovs_fileoptions_exr_preserve = ctlstate("Layer names", lwtoa043_ai_sysaovs_fileoptions_exr_preserve, lwtoa043_t8_colwidth2 - 10, "scnGen_lwtoa043_aov_stub");
	        ctlposition(lwtoa043_c_ai_sysaovs_fileoptions_exr_preserve, col_index * lwtoa043_t8_colwidth2, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth2 - 10, lwtoa043_gad_h);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset * 1.5;

	        lwtoa043_sep_t8_4 = ctlsep(0, lwtoa043_ui_seperator_w);
	        ctlposition(lwtoa043_sep_t8_4, 1, lwtoa043_ui_offset_y);

			lwtoa043_ui_offset_y += lwtoa043_ui_row_offset/2;

			lwtoa043_t8_colwidth2 = lwtoa043_ui_window_w / 5;
			col_index = 0;

			lwtoa043_tiffoptions = ctltext("", "TIFF options");
			ctlposition(lwtoa043_tiffoptions, 1, lwtoa043_ui_offset_y);

			col_index = 1;
			lwtoa043_ai_sysaovs_fileoptions_tif_compress++; // 1-based in LScript, 0-based in Arnold
			lwtoa043_c_ai_sysaovs_fileoptions_tif_compress = ctlpopup("", lwtoa043_ai_sysaovs_fileoptions_tif_compress,lwtoa043_tiff_options_array);
			ctlposition(lwtoa043_c_ai_sysaovs_fileoptions_tif_compress, col_index * lwtoa043_t8_colwidth2, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth2 - 10, lwtoa043_gad_h);

			col_index = 2;
			lwtoa043_ai_sysaovs_fileoptions_tif_format++; // 1-based in LScript, 0-based in Arnold
			lwtoa043_c_ai_sysaovs_fileoptions_tif_format = ctlpopup("", lwtoa043_ai_sysaovs_fileoptions_tif_format,lwtoa043_tiff_depth_array);
			ctlposition(lwtoa043_c_ai_sysaovs_fileoptions_tif_format, col_index * lwtoa043_t8_colwidth2, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth2 - 10, lwtoa043_gad_h);

			col_index = 3;
			lwtoa043_c_ai_sysaovs_fileoptions_tif_tiled = ctlstate("Tiled", lwtoa043_ai_sysaovs_fileoptions_tif_tiled, lwtoa043_t8_colwidth2 - 10, "scnGen_lwtoa043_aov_stub");
	        ctlposition(lwtoa043_c_ai_sysaovs_fileoptions_tif_tiled, col_index * lwtoa043_t8_colwidth2, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth2 - 10, lwtoa043_gad_h);

			col_index = 4;
			lwtoa043_c_ai_sysaovs_fileoptions_tif_dither = ctlnumber("Dith.", lwtoa043_ai_sysaovs_fileoptions_tif_dither);
	        ctlposition(lwtoa043_c_ai_sysaovs_fileoptions_tif_dither, col_index * lwtoa043_t8_colwidth2, lwtoa043_ui_offset_y, lwtoa043_t8_colwidth2 - 10, lwtoa043_gad_h);

			ctlpage(8, lwtoa043_c_ai_sysaovs_enable, lwtoa043_c_ai_sysaovs_display, colheader_t8_1, colheader_t8_2, colheader_t8_3, colheader_t8_4, colheader_t8_5, colheader_t8_6,
			lwtoa043_c_ai_sysaovs_active_1, lwtoa043_c_ai_sysaovs_type_1, lwtoa043_c_ai_sysaovs_suffix_1, lwtoa043_c_ai_sysaovs_filter_1, lwtoa043_c_ai_sysaovs_gamma_1, lwtoa043_c_ai_sysaovs_file_format_1,
			lwtoa043_c_ai_sysaovs_active_2, lwtoa043_c_ai_sysaovs_type_2, lwtoa043_c_ai_sysaovs_suffix_2, lwtoa043_c_ai_sysaovs_filter_2, lwtoa043_c_ai_sysaovs_gamma_2, lwtoa043_c_ai_sysaovs_file_format_2,
			lwtoa043_c_ai_sysaovs_active_3, lwtoa043_c_ai_sysaovs_type_3, lwtoa043_c_ai_sysaovs_suffix_3, lwtoa043_c_ai_sysaovs_filter_3, lwtoa043_c_ai_sysaovs_gamma_3, lwtoa043_c_ai_sysaovs_file_format_3,
			lwtoa043_c_ai_sysaovs_active_4, lwtoa043_c_ai_sysaovs_type_4, lwtoa043_c_ai_sysaovs_suffix_4, lwtoa043_c_ai_sysaovs_filter_4, lwtoa043_c_ai_sysaovs_gamma_4, lwtoa043_c_ai_sysaovs_file_format_4,
			lwtoa043_c_ai_sysaovs_active_5, lwtoa043_c_ai_sysaovs_type_5, lwtoa043_c_ai_sysaovs_suffix_5, lwtoa043_c_ai_sysaovs_filter_5, lwtoa043_c_ai_sysaovs_gamma_5, lwtoa043_c_ai_sysaovs_file_format_5,
			lwtoa043_c_ai_sysaovs_active_6, lwtoa043_c_ai_sysaovs_type_6, lwtoa043_c_ai_sysaovs_suffix_6, lwtoa043_c_ai_sysaovs_filter_6, lwtoa043_c_ai_sysaovs_gamma_6, lwtoa043_c_ai_sysaovs_file_format_6,
			lwtoa043_c_ai_sysaovs_active_7, lwtoa043_c_ai_sysaovs_type_7, lwtoa043_c_ai_sysaovs_suffix_7, lwtoa043_c_ai_sysaovs_filter_7, lwtoa043_c_ai_sysaovs_gamma_7, lwtoa043_c_ai_sysaovs_file_format_7,
			lwtoa043_c_ai_sysaovs_active_8, lwtoa043_c_ai_sysaovs_type_8, lwtoa043_c_ai_sysaovs_suffix_8, lwtoa043_c_ai_sysaovs_filter_8, lwtoa043_c_ai_sysaovs_gamma_8, lwtoa043_c_ai_sysaovs_file_format_8,
			lwtoa043_c_ai_sysaovs_active_9, lwtoa043_c_ai_sysaovs_type_9, lwtoa043_c_ai_sysaovs_suffix_9, lwtoa043_c_ai_sysaovs_filter_9, lwtoa043_c_ai_sysaovs_gamma_9, lwtoa043_c_ai_sysaovs_file_format_9,
			lwtoa043_c_ai_sysaovs_active_10, lwtoa043_c_ai_sysaovs_type_10, lwtoa043_c_ai_sysaovs_suffix_10, lwtoa043_c_ai_sysaovs_filter_10, lwtoa043_c_ai_sysaovs_gamma_10, lwtoa043_c_ai_sysaovs_file_format_10,
			lwtoa043_c_ai_sysaovs_active_11, lwtoa043_c_ai_sysaovs_type_11, lwtoa043_c_ai_sysaovs_suffix_11, lwtoa043_c_ai_sysaovs_filter_11, lwtoa043_c_ai_sysaovs_gamma_11, lwtoa043_c_ai_sysaovs_file_format_11,
			lwtoa043_c_ai_sysaovs_active_12, lwtoa043_c_ai_sysaovs_type_12, lwtoa043_c_ai_sysaovs_suffix_12, lwtoa043_c_ai_sysaovs_filter_12, lwtoa043_c_ai_sysaovs_gamma_12, lwtoa043_c_ai_sysaovs_file_format_12,
			lwtoa043_c_ai_sysaovs_active_13, lwtoa043_c_ai_sysaovs_type_13, lwtoa043_c_ai_sysaovs_suffix_13, lwtoa043_c_ai_sysaovs_filter_13, lwtoa043_c_ai_sysaovs_gamma_13, lwtoa043_c_ai_sysaovs_file_format_13,
			lwtoa043_c_ai_sysaovs_active_14, lwtoa043_c_ai_sysaovs_type_14, lwtoa043_c_ai_sysaovs_suffix_14, lwtoa043_c_ai_sysaovs_filter_14, lwtoa043_c_ai_sysaovs_gamma_14, lwtoa043_c_ai_sysaovs_file_format_14,
			lwtoa043_c_ai_sysaovs_active_15, lwtoa043_c_ai_sysaovs_type_15, lwtoa043_c_ai_sysaovs_suffix_15, lwtoa043_c_ai_sysaovs_filter_15, lwtoa043_c_ai_sysaovs_gamma_15, lwtoa043_c_ai_sysaovs_file_format_15,
			lwtoa043_c_ai_sysaovs_active_16, lwtoa043_c_ai_sysaovs_type_16, lwtoa043_c_ai_sysaovs_suffix_16, lwtoa043_c_ai_sysaovs_filter_16, lwtoa043_c_ai_sysaovs_gamma_16, lwtoa043_c_ai_sysaovs_file_format_16,
			lwtoa043_c_ai_sysaovs_active_17, lwtoa043_c_ai_sysaovs_type_17, lwtoa043_c_ai_sysaovs_suffix_17, lwtoa043_c_ai_sysaovs_filter_17, lwtoa043_c_ai_sysaovs_gamma_17, lwtoa043_c_ai_sysaovs_file_format_17,
			lwtoa043_c_ai_sysaovs_active_18, lwtoa043_c_ai_sysaovs_type_18, lwtoa043_c_ai_sysaovs_suffix_18, lwtoa043_c_ai_sysaovs_filter_18, lwtoa043_c_ai_sysaovs_gamma_18, lwtoa043_c_ai_sysaovs_file_format_18,
			lwtoa043_c_ai_sysaovs_active_19, lwtoa043_c_ai_sysaovs_type_19, lwtoa043_c_ai_sysaovs_suffix_19, lwtoa043_c_ai_sysaovs_filter_19, lwtoa043_c_ai_sysaovs_gamma_19, lwtoa043_c_ai_sysaovs_file_format_19,
			lwtoa043_c_ai_sysaovs_active_20, lwtoa043_c_ai_sysaovs_type_20, lwtoa043_c_ai_sysaovs_suffix_20, lwtoa043_c_ai_sysaovs_filter_20, lwtoa043_c_ai_sysaovs_gamma_20, lwtoa043_c_ai_sysaovs_file_format_20,
			lwtoa043_c_ai_sysaovs_active_21, lwtoa043_c_ai_sysaovs_type_21, lwtoa043_c_ai_sysaovs_suffix_21, lwtoa043_c_ai_sysaovs_filter_21, lwtoa043_c_ai_sysaovs_gamma_21, lwtoa043_c_ai_sysaovs_file_format_21,
			lwtoa043_c_ai_sysaovs_active_22, lwtoa043_c_ai_sysaovs_type_22, lwtoa043_c_ai_sysaovs_suffix_22, lwtoa043_c_ai_sysaovs_filter_22, lwtoa043_c_ai_sysaovs_gamma_22, lwtoa043_c_ai_sysaovs_file_format_22,
			lwtoa043_c_ai_sysaovs_active_23, lwtoa043_c_ai_sysaovs_type_23, lwtoa043_c_ai_sysaovs_suffix_23, lwtoa043_c_ai_sysaovs_filter_23, lwtoa043_c_ai_sysaovs_gamma_23, lwtoa043_c_ai_sysaovs_file_format_23,
			lwtoa043_c_ai_sysaovs_active_24, lwtoa043_c_ai_sysaovs_type_24, lwtoa043_c_ai_sysaovs_suffix_24, lwtoa043_c_ai_sysaovs_filter_24, lwtoa043_c_ai_sysaovs_gamma_24, lwtoa043_c_ai_sysaovs_file_format_24,
			lwtoa043_sep_t8_1, lwtoa043_sep_t8_2, lwtoa043_c_ai_sysaovs_fileoptions_path, lwtoa043_c_ai_sysaovs_fileoptions_exr_compress, lwtoa043_sep_t8_3, lwtoa043_sep_t8_4, lwtoa043_exroptions, lwtoa043_c_ai_sysaovs_fileoptions_exr_half, lwtoa043_c_ai_sysaovs_fileoptions_exr_tiled, lwtoa043_c_ai_sysaovs_fileoptions_exr_preserve, lwtoa043_tiffoptions, lwtoa043_c_ai_sysaovs_fileoptions_tif_compress, lwtoa043_c_ai_sysaovs_fileoptions_tif_format, lwtoa043_c_ai_sysaovs_fileoptions_tif_tiled, lwtoa043_c_ai_sysaovs_fileoptions_tif_dither
			);
		}

		// END OF TABS

		if(reqpost())
		{
			newName                      = getvalue(lwtoa043_c20);
			newName                      = makeStringGood(newName);
			::overrideRenderer             = 3; // hard-coded.

			if(!passCamIDArray)
			{
				activeCameraID            = 0;
			} else {
				activeCameraID            = passCamIDArray[getvalue(lwtoa043_c90)]; // Offset as UI is 0-based; array is 1-based.
			}

			redirectBuffersSetts = getvalue(lwtoa043_c90_1); // may not be relevant to LWtoA, but leaving for now.

			lwtoa043_ai_mt_auto = int(getvalue(lwtoa043_c_ai_mt_auto));
			lwtoa043_ai_mt_num = int(getvalue(lwtoa043_c_ai_mt_num));
			lwtoa043_ai_multithread_loading = int(getvalue(lwtoa043_c_ai_multithread_loading));
			lwtoa043_ai_rendering_mode = int(getvalue(lwtoa043_c_ai_rendering_mode)) - 1; // offset to 0-index for Arnold.
			lwtoa043_ai_reload_lights = int(getvalue(lwtoa043_c_ai_reload_lights));
			lwtoa043_ai_reload_materials = int(getvalue(lwtoa043_c_ai_reload_materials));
			lwtoa043_ai_scan_mode = int(getvalue(lwtoa043_c_ai_scan_mode)) - 1; // offset to 0-index for Arnold.
			lwtoa043_ai_bx = int(getvalue(lwtoa043_c_ai_bx));
			if (lwtoa043_ai_bx < 1) // sanity check for silly user input (we can't screen it at UI level)
			{
				if (lwtoa043_ai_bx < 0)
				{
					lwtoa043_ai_bx = lwtoa043_ai_bx * -1;
				} else {
					lwtoa043_ai_bx = 1;
				}
			}
			lwtoa043_ai_license_skip = int(getvalue(lwtoa043_c_ai_license_skip));
			lwtoa043_ai_ipr_license_skip = int(getvalue(lwtoa043_c_ai_ipr_license_skip));
			lwtoa043_ai_abort_lic_fail = int(getvalue(lwtoa043_c_ai_abort_lic_fail));
			lwtoa043_ai_procedural_path = sanitizePath(string(getvalue(lwtoa043_c_ai_procedural_path)),1,1);
			lwtoa043_ai_shader_path = sanitizePath(string(getvalue(lwtoa043_c_ai_shader_path)),1,1);
			lwtoa043_ai_texture_path = sanitizePath(string(getvalue(lwtoa043_c_ai_texture_path)),1,1);

			lwtoa043_ai_prog_sampling = int(getvalue(lwtoa043_c_ai_prog_sampling));

			// Here, we return the array index from the drop-down, but we actually want the value
			// Since the menu contents have the % suffix, we also need to drop this in substring operations.
			lwtoa043_ai_sampling_mult = lwtoa043_samplingmult_array[int(getvalue(lwtoa043_c_ai_sampling_mult))];
			// Drop the % from the value
			lwtoa043_ai_sampling_mult = strleft(lwtoa043_ai_sampling_mult,lwtoa043_ai_sampling_mult.size() - 1);
			lwtoa043_ai_light_sampling_mult = lwtoa043_samplingmult_array[int(getvalue(lwtoa043_c_ai_light_sampling_mult))];
			// Drop the % from the value
			lwtoa043_ai_light_sampling_mult = strleft(lwtoa043_ai_light_sampling_mult,lwtoa043_ai_light_sampling_mult.size() - 1);

			lwtoa043_ai_aas = int(getvalue(lwtoa043_c_ai_aas));
			lwtoa043_ai_ds = int(getvalue(lwtoa043_c_ai_ds));
			lwtoa043_ai_gs = int(getvalue(lwtoa043_c_ai_gs));
			lwtoa043_ai_rs = int(getvalue(lwtoa043_c_ai_rs));
			lwtoa043_ai_clamp = int(getvalue(lwtoa043_c_ai_clamp));
			lwtoa043_ai_clamp_aovs = int(getvalue(lwtoa043_c_ai_clamp_aovs));
			lwtoa043_ai_clamp_max = number(getvalue(lwtoa043_c_ai_clamp_max));
			lwtoa043_ai_lock = int(getvalue(lwtoa043_c_ai_lock));
			lwtoa043_ai_pf = int(getvalue(lwtoa043_c_ai_pf)) - 1; // offset to 0-index for Arnold.
			lwtoa043_ai_pw = number(getvalue(lwtoa043_c_ai_pw));
			lwtoa043_ai_sss_engine = int(getvalue(lwtoa043_c_ai_sss_engine)) - 1; // offset to 0-index for Arnold
			lwtoa043_ai_sss_samples = int(getvalue(lwtoa043_c_ai_sss_samples));
			lwtoa043_ai_sss_factor = int(getvalue(lwtoa043_c_ai_sss_factor));
			lwtoa043_ai_sss_spacing = number(getvalue(lwtoa043_c_ai_sss_spacing));
			lwtoa043_ai_sss_distribution = int(getvalue(lwtoa043_c_ai_sss_distribution)) - 1; // offset to 0-index for Arnold
			lwtoa043_ai_sss_show = int(getvalue(lwtoa043_c_ai_sss_show)) - 1; // offset to 0-index for Arnold

			lwtoa043_ai_rd_total = int(getvalue(lwtoa043_c_ai_rd_total));
			lwtoa043_ai_rd_diffuse = int(getvalue(lwtoa043_c_ai_rd_diffuse));
			lwtoa043_ai_rd_refl = int(getvalue(lwtoa043_c_ai_rd_refl));
			lwtoa043_ai_rd_refr = int(getvalue(lwtoa043_c_ai_rd_refr));
			lwtoa043_ai_rd_glossy = int(getvalue(lwtoa043_c_ai_rd_glossy));
			lwtoa043_ai_trans_mode = int(getvalue(lwtoa043_c_ai_trans_mode));
			lwtoa043_ai_trans_depth = int(getvalue(lwtoa043_c_ai_trans_depth));
			lwtoa043_ai_trans_threshold = number(getvalue(lwtoa043_c_ai_trans_threshold));
			lwtoa043_ai_aov_composition = int(getvalue(lwtoa043_c_ai_aov_composition));
			lwtoa043_ai_volumetric_type = int(getvalue(lwtoa043_c_ai_volumetric_type)) - 1; // offset to 0-index for Arnold.
			lwtoa043_ai_background_visbility = int(getvalue(lwtoa043_c_ai_background_visbility)) - 1; // offset to 0-index for Arnold.

			lwtoa043_ai_cam_type = int(getvalue(lwtoa043_c_ai_cam_type)) - 1; // offset to 0-index for Arnold.
			lwtoa043_ai_cam_exposure = number(getvalue(lwtoa043_c_ai_cam_exposure));
			lwtoa043_ai_cam_near = number(getvalue(lwtoa043_c_ai_cam_near));
			lwtoa043_ai_cam_far = number(getvalue(lwtoa043_c_ai_cam_far));
			lwtoa043_ai_cam_rolling_shutter = int(getvalue(lwtoa043_c_ai_cam_rolling_shutter)) - 1; // offset to 0-index for Arnold.
			lwtoa043_ai_cam_fisheye_crop = int(getvalue(lwtoa043_c_ai_cam_fisheye_crop));
			lwtoa043_ai_cam_ortho_factor = number(getvalue(lwtoa043_c_ai_cam_ortho_factor));
			lwtoa043_ai_dof_aspect = number(getvalue(lwtoa043_c_ai_dof_aspect));
			lwtoa043_ai_dof_curvature = number(getvalue(lwtoa043_c_ai_dof_curvature));
			lwtoa043_ai_shutter_type = int(getvalue(lwtoa043_c_ai_shutter_type)) - 1; // offset to 0-index for Arnold.
			lwtoa043_ai_mb_apply_obj = int(getvalue(lwtoa043_c_ai_mb_apply_obj));
			lwtoa043_ai_mb_apply_light = int(getvalue(lwtoa043_c_ai_mb_apply_light));
			lwtoa043_ai_mb_apply_cam = int(getvalue(lwtoa043_c_ai_mb_apply_cam));
			lwtoa043_ai_mb_apply_psys = int(getvalue(lwtoa043_c_ai_mb_apply_psys));
			lwtoa043_ai_mb_psys_factor = number(getvalue(lwtoa043_c_ai_mb_psys_factor));
			lwtoa043_ai_mb_forceRefresh = int(getvalue(lwtoa043_c_ai_mb_forceRefresh));
			lwtoa043_ai_instance_lwclones = int(getvalue(lwtoa043_c_ai_instance_lwclones));
			lwtoa043_ai_instance_nulls = int(getvalue(lwtoa043_c_ai_instance_nulls));
			lwtoa043_ai_instance_lw11 = int(getvalue(lwtoa043_c_ai_instance_lw11));
			lwtoa043_ai_sds_max_level = int(getvalue(lwtoa043_c_ai_sds_max_level));
			lwtoa043_ai_shading_pass = int(getvalue(lwtoa043_c_ai_shading_pass)) - 1; // offset to 0-index for Arnold.
			lwtoa043_ai_low_light_threshold = number(getvalue(lwtoa043_c_ai_low_light_threshold));

			lwtoa043_ai_enable_multiple_uvmaps = int(getvalue(lwtoa043_c_ai_enable_multiple_uvmaps));

			lwtoa043_ai_log_write = int(getvalue(lwtoa043_c_ai_log_write));
			lwtoa043_ai_log_filename = sanitizePath(string(getvalue(lwtoa043_c_ai_log_filename)),1,1);
			lwtoa043_ai_log_level = int(getvalue(lwtoa043_c_ai_log_level)) - 1; // offset to 0-index for Arnold.
			lwtoa043_ai_log_ipr_level = int(getvalue(lwtoa043_c_ai_log_ipr_level)) - 1; // offset to 0-index for Arnold.
			lwtoa043_ai_log_sn_level = int(getvalue(lwtoa043_c_ai_log_sn_level)) - 1; // offset to 0-index for Arnold.
			lwtoa043_ai_log_max = int(getvalue(lwtoa043_c_ai_log_max));
			lwtoa043_ai_log_frame_number = int(getvalue(lwtoa043_c_ai_log_frame_number));
			lwtoa043_ai_shader_timing_stats = int(getvalue(lwtoa043_c_ai_shader_timing_stats));

			lwtoa043_ai_ignore_textures = int(getvalue(lwtoa043_c_ai_ignore_textures));
			lwtoa043_ai_ignore_shaders = int(getvalue(lwtoa043_c_ai_ignore_shaders));
			lwtoa043_ai_ignore_atmosphere = int(getvalue(lwtoa043_c_ai_ignore_atmosphere));
			lwtoa043_ai_ignore_lights = int(getvalue(lwtoa043_c_ai_ignore_lights));
			lwtoa043_ai_ignore_shadows = int(getvalue(lwtoa043_c_ai_ignore_shadows));
			lwtoa043_ai_ignore_subdivision = int(getvalue(lwtoa043_c_ai_ignore_subdivision));
			lwtoa043_ai_ignore_displacement = int(getvalue(lwtoa043_c_ai_ignore_displacement));
			lwtoa043_ai_ignore_bump = int(getvalue(lwtoa043_c_ai_ignore_bump));
			lwtoa043_ai_ignore_motion_blur = int(getvalue(lwtoa043_c_ai_ignore_motion_blur));
			lwtoa043_ai_ignore_smoothing = int(getvalue(lwtoa043_c_ai_ignore_smoothing));
			lwtoa043_ai_ignore_sss = int(getvalue(lwtoa043_c_ai_ignore_sss));
			lwtoa043_ai_ignore_direct_lighting = int(getvalue(lwtoa043_c_ai_ignore_direct_lighting));
			lwtoa043_ai_ignore_mis = int(getvalue(lwtoa043_c_ai_ignore_mis));
			lwtoa043_ai_ignore_dof = int(getvalue(lwtoa043_c_ai_ignore_dof));
			lwtoa043_ai_nlights_heatmap = int(getvalue(lwtoa043_c_ai_nlights_heatmap));
			lwtoa043_ai_ignore_procedurals = int(getvalue(lwtoa043_c_ai_ignore_procedurals));
			lwtoa043_ai_disable_rotational_mb = int(getvalue(lwtoa043_c_ai_disable_rotational_mb));
			lwtoa043_ai_info_add = int(getvalue(lwtoa043_c_ai_info_add));
			lwtoa043_ai_info_txt = quoteString(string(getvalue(lwtoa043_c_ai_info_txt)));

			lwtoa043_ai_render_to_file = int(getvalue(lwtoa043_c_ai_render_to_file));
			lwtoa043_ai_filename = sanitizePath(string(getvalue(lwtoa043_c_ai_filename)),1,1);
			lwtoa043_ai_compress_file = int(getvalue(lwtoa043_c_ai_compress_file));
			lwtoa043_ai_ass_binary = int(getvalue(lwtoa043_c_ai_ass_binary));
			lwtoa043_ai_writenode_options = int(getvalue(lwtoa043_c_ai_writenode_options));
			lwtoa043_ai_writenode_drivers = int(getvalue(lwtoa043_c_ai_writenode_drivers));
			lwtoa043_ai_writenode_geom = int(getvalue(lwtoa043_c_ai_writenode_geom));
			lwtoa043_ai_writenode_cam = int(getvalue(lwtoa043_c_ai_writenode_cam));
			lwtoa043_ai_writenode_lights = int(getvalue(lwtoa043_c_ai_writenode_lights));
			lwtoa043_ai_writenode_shaders = int(getvalue(lwtoa043_c_ai_writenode_shaders));

			lwtoa043_ai_tex_accept_nomipmap = int(getvalue(lwtoa043_c_ai_tex_accept_nomipmap));
			lwtoa043_ai_tex_automipmap = int(getvalue(lwtoa043_c_ai_tex_automipmap));
			lwtoa043_ai_tex_magfilter = int(getvalue(lwtoa043_c_ai_tex_magfilter)) - 1; // offset to 0-index for Arnold.
			lwtoa043_ai_tex_accept_untiled = int(getvalue(lwtoa043_c_ai_tex_accept_untiled));
			lwtoa043_ai_tex_autotile = int(getvalue(lwtoa043_c_ai_tex_autotile));
			lwtoa043_ai_tex_tile_size = int(getvalue(lwtoa043_c_ai_tex_tile_size));
			lwtoa043_ai_tex_cache = int(getvalue(lwtoa043_c_ai_tex_cache));
			lwtoa043_ai_tex_cache_size = int(getvalue(lwtoa043_c_ai_tex_cache_size));
			lwtoa043_ai_tex_maxfiles = int(getvalue(lwtoa043_c_ai_tex_maxfiles));
			lwtoa043_ai_gamma_texture = number(getvalue(lwtoa043_c_ai_gamma_texture));
			lwtoa043_ai_tex_diffuse_blur = number(getvalue(lwtoa043_c_ai_tex_diffuse_blur));
			lwtoa043_ai_tex_glossy_blur = number(getvalue(lwtoa043_c_ai_tex_glossy_blur));
			lwtoa043_ai_texture_max_sharpen = number(getvalue(lwtoa043_c_ai_texture_max_sharpen));

			lwtoa043_ai_sysaovs_enable = int(getvalue(lwtoa043_c_ai_sysaovs_enable));
			lwtoa043_ai_sysaovs_display = int(getvalue(lwtoa043_c_ai_sysaovs_display)) - 1; // offset to 0-index for Arnold.

			lwtoa043_t8_AOV_index = 1;
			lwtoa043_ai_sysaovs_active[lwtoa043_t8_AOV_index] = int(getvalue(lwtoa043_c_ai_sysaovs_active_1));
			lwtoa043_ai_sysaovs_type[lwtoa043_t8_AOV_index] = int(getvalue(lwtoa043_c_ai_sysaovs_type_1)) - 1; // offset to 0-index for Arnold
			lwtoa043_ai_sysaovs_suf[lwtoa043_t8_AOV_index] = quoteString(string(getvalue(lwtoa043_c_ai_sysaovs_suffix_1)));
			lwtoa043_ai_sysaovs_filter[lwtoa043_t8_AOV_index] = int(getvalue(lwtoa043_c_ai_sysaovs_filter_1)) - 1; // offset to 0-index for Arnold.
			lwtoa043_ai_sysaovs_gamma[lwtoa043_t8_AOV_index] = number(getvalue(lwtoa043_c_ai_sysaovs_gamma_1));
			lwtoa043_ai_sysaovs_file_format[lwtoa043_t8_AOV_index] = int(getvalue(lwtoa043_c_ai_sysaovs_file_format_1)) - 1; // offset to 0-index for Arnold.
			lwtoa043_ai_sysaovs_pad1[lwtoa043_t8_AOV_index] = 0;
			lwtoa043_ai_sysaovs_pad2[lwtoa043_t8_AOV_index] = 0;
			lwtoa043_ai_sysaovs_pad3[lwtoa043_t8_AOV_index] = 0;
			lwtoa043_ai_sysaovs_pad4[lwtoa043_t8_AOV_index] = 0;

			lwtoa043_t8_AOV_index++;
			lwtoa043_ai_sysaovs_active[lwtoa043_t8_AOV_index] = int(getvalue(lwtoa043_c_ai_sysaovs_active_2));
			lwtoa043_ai_sysaovs_type[lwtoa043_t8_AOV_index] = int(getvalue(lwtoa043_c_ai_sysaovs_type_2)) - 1; // offset to 0-index for Arnold
			lwtoa043_ai_sysaovs_suf[lwtoa043_t8_AOV_index] = quoteString(string(getvalue(lwtoa043_c_ai_sysaovs_suffix_2)));
			lwtoa043_ai_sysaovs_filter[lwtoa043_t8_AOV_index] = int(getvalue(lwtoa043_c_ai_sysaovs_filter_2)) - 1; // offset to 0-index for Arnold.
			lwtoa043_ai_sysaovs_gamma[lwtoa043_t8_AOV_index] = number(getvalue(lwtoa043_c_ai_sysaovs_gamma_2));
			lwtoa043_ai_sysaovs_file_format[lwtoa043_t8_AOV_index] = int(getvalue(lwtoa043_c_ai_sysaovs_file_format_2)) - 1; // offset to 0-index for Arnold.
			lwtoa043_ai_sysaovs_pad1[lwtoa043_t8_AOV_index] = 0;
			lwtoa043_ai_sysaovs_pad2[lwtoa043_t8_AOV_index] = 0;
			lwtoa043_ai_sysaovs_pad3[lwtoa043_t8_AOV_index] = 0;
			lwtoa043_ai_sysaovs_pad4[lwtoa043_t8_AOV_index] = 0;

			lwtoa043_t8_AOV_index++;
			lwtoa043_ai_sysaovs_active[lwtoa043_t8_AOV_index] = int(getvalue(lwtoa043_c_ai_sysaovs_active_3));
			lwtoa043_ai_sysaovs_type[lwtoa043_t8_AOV_index] = int(getvalue(lwtoa043_c_ai_sysaovs_type_3)) - 1; // offset to 0-index for Arnold
			lwtoa043_ai_sysaovs_suf[lwtoa043_t8_AOV_index] = quoteString(string(getvalue(lwtoa043_c_ai_sysaovs_suffix_3)));
			lwtoa043_ai_sysaovs_filter[lwtoa043_t8_AOV_index] = int(getvalue(lwtoa043_c_ai_sysaovs_filter_3)) - 1; // offset to 0-index for Arnold.
			lwtoa043_ai_sysaovs_gamma[lwtoa043_t8_AOV_index] = number(getvalue(lwtoa043_c_ai_sysaovs_gamma_3));
			lwtoa043_ai_sysaovs_file_format[lwtoa043_t8_AOV_index] = int(getvalue(lwtoa043_c_ai_sysaovs_file_format_3)) - 1; // offset to 0-index for Arnold.
			lwtoa043_ai_sysaovs_pad1[lwtoa043_t8_AOV_index] = 0;
			lwtoa043_ai_sysaovs_pad2[lwtoa043_t8_AOV_index] = 0;
			lwtoa043_ai_sysaovs_pad3[lwtoa043_t8_AOV_index] = 0;
			lwtoa043_ai_sysaovs_pad4[lwtoa043_t8_AOV_index] = 0;

			lwtoa043_t8_AOV_index++;
			lwtoa043_ai_sysaovs_active[lwtoa043_t8_AOV_index] = int(getvalue(lwtoa043_c_ai_sysaovs_active_4));
			lwtoa043_ai_sysaovs_type[lwtoa043_t8_AOV_index] = int(getvalue(lwtoa043_c_ai_sysaovs_type_4)) - 1; // offset to 0-index for Arnold
			lwtoa043_ai_sysaovs_suf[lwtoa043_t8_AOV_index] = quoteString(string(getvalue(lwtoa043_c_ai_sysaovs_suffix_4)));
			lwtoa043_ai_sysaovs_filter[lwtoa043_t8_AOV_index] = int(getvalue(lwtoa043_c_ai_sysaovs_filter_4)) - 1; // offset to 0-index for Arnold.
			lwtoa043_ai_sysaovs_gamma[lwtoa043_t8_AOV_index] = number(getvalue(lwtoa043_c_ai_sysaovs_gamma_4));
			lwtoa043_ai_sysaovs_file_format[lwtoa043_t8_AOV_index] = int(getvalue(lwtoa043_c_ai_sysaovs_file_format_4)) - 1; // offset to 0-index for Arnold.
			lwtoa043_ai_sysaovs_pad1[lwtoa043_t8_AOV_index] = 0;
			lwtoa043_ai_sysaovs_pad2[lwtoa043_t8_AOV_index] = 0;
			lwtoa043_ai_sysaovs_pad3[lwtoa043_t8_AOV_index] = 0;
			lwtoa043_ai_sysaovs_pad4[lwtoa043_t8_AOV_index] = 0;

			lwtoa043_t8_AOV_index++;
			lwtoa043_ai_sysaovs_active[lwtoa043_t8_AOV_index] = int(getvalue(lwtoa043_c_ai_sysaovs_active_5));
			lwtoa043_ai_sysaovs_type[lwtoa043_t8_AOV_index] = int(getvalue(lwtoa043_c_ai_sysaovs_type_5)) - 1; // offset to 0-index for Arnold
			lwtoa043_ai_sysaovs_suf[lwtoa043_t8_AOV_index] = quoteString(string(getvalue(lwtoa043_c_ai_sysaovs_suffix_5)));
			lwtoa043_ai_sysaovs_filter[lwtoa043_t8_AOV_index] = int(getvalue(lwtoa043_c_ai_sysaovs_filter_5)) - 1; // offset to 0-index for Arnold.
			lwtoa043_ai_sysaovs_gamma[lwtoa043_t8_AOV_index] = number(getvalue(lwtoa043_c_ai_sysaovs_gamma_5));
			lwtoa043_ai_sysaovs_file_format[lwtoa043_t8_AOV_index] = int(getvalue(lwtoa043_c_ai_sysaovs_file_format_5)) - 1; // offset to 0-index for Arnold.
			lwtoa043_ai_sysaovs_pad1[lwtoa043_t8_AOV_index] = 0;
			lwtoa043_ai_sysaovs_pad2[lwtoa043_t8_AOV_index] = 0;
			lwtoa043_ai_sysaovs_pad3[lwtoa043_t8_AOV_index] = 0;
			lwtoa043_ai_sysaovs_pad4[lwtoa043_t8_AOV_index] = 0;

			lwtoa043_t8_AOV_index++;
			lwtoa043_ai_sysaovs_active[lwtoa043_t8_AOV_index] = int(getvalue(lwtoa043_c_ai_sysaovs_active_6));
			lwtoa043_ai_sysaovs_type[lwtoa043_t8_AOV_index] = int(getvalue(lwtoa043_c_ai_sysaovs_type_6)) - 1; // offset to 0-index for Arnold
			lwtoa043_ai_sysaovs_suf[lwtoa043_t8_AOV_index] = quoteString(string(getvalue(lwtoa043_c_ai_sysaovs_suffix_6)));
			lwtoa043_ai_sysaovs_filter[lwtoa043_t8_AOV_index] = int(getvalue(lwtoa043_c_ai_sysaovs_filter_6)) - 1; // offset to 0-index for Arnold.
			lwtoa043_ai_sysaovs_gamma[lwtoa043_t8_AOV_index] = number(getvalue(lwtoa043_c_ai_sysaovs_gamma_6));
			lwtoa043_ai_sysaovs_file_format[lwtoa043_t8_AOV_index] = int(getvalue(lwtoa043_c_ai_sysaovs_file_format_6)) - 1; // offset to 0-index for Arnold.
			lwtoa043_ai_sysaovs_pad1[lwtoa043_t8_AOV_index] = 0;
			lwtoa043_ai_sysaovs_pad2[lwtoa043_t8_AOV_index] = 0;
			lwtoa043_ai_sysaovs_pad3[lwtoa043_t8_AOV_index] = 0;
			lwtoa043_ai_sysaovs_pad4[lwtoa043_t8_AOV_index] = 0;

			lwtoa043_t8_AOV_index++;
			lwtoa043_ai_sysaovs_active[lwtoa043_t8_AOV_index] = int(getvalue(lwtoa043_c_ai_sysaovs_active_7));
			lwtoa043_ai_sysaovs_type[lwtoa043_t8_AOV_index] = int(getvalue(lwtoa043_c_ai_sysaovs_type_7)) - 1; // offset to 0-index for Arnold
			lwtoa043_ai_sysaovs_suf[lwtoa043_t8_AOV_index] = quoteString(string(getvalue(lwtoa043_c_ai_sysaovs_suffix_7)));
			lwtoa043_ai_sysaovs_filter[lwtoa043_t8_AOV_index] = int(getvalue(lwtoa043_c_ai_sysaovs_filter_7)) - 1; // offset to 0-index for Arnold.
			lwtoa043_ai_sysaovs_gamma[lwtoa043_t8_AOV_index] = number(getvalue(lwtoa043_c_ai_sysaovs_gamma_7));
			lwtoa043_ai_sysaovs_file_format[lwtoa043_t8_AOV_index] = int(getvalue(lwtoa043_c_ai_sysaovs_file_format_7)) - 1; // offset to 0-index for Arnold.
			lwtoa043_ai_sysaovs_pad1[lwtoa043_t8_AOV_index] = 0;
			lwtoa043_ai_sysaovs_pad2[lwtoa043_t8_AOV_index] = 0;
			lwtoa043_ai_sysaovs_pad3[lwtoa043_t8_AOV_index] = 0;
			lwtoa043_ai_sysaovs_pad4[lwtoa043_t8_AOV_index] = 0;

			lwtoa043_t8_AOV_index++;
			lwtoa043_ai_sysaovs_active[lwtoa043_t8_AOV_index] = int(getvalue(lwtoa043_c_ai_sysaovs_active_8));
			lwtoa043_ai_sysaovs_type[lwtoa043_t8_AOV_index] = int(getvalue(lwtoa043_c_ai_sysaovs_type_8)) - 1; // offset to 0-index for Arnold
			lwtoa043_ai_sysaovs_suf[lwtoa043_t8_AOV_index] = quoteString(string(getvalue(lwtoa043_c_ai_sysaovs_suffix_8)));
			lwtoa043_ai_sysaovs_filter[lwtoa043_t8_AOV_index] = int(getvalue(lwtoa043_c_ai_sysaovs_filter_8)) - 1; // offset to 0-index for Arnold.
			lwtoa043_ai_sysaovs_gamma[lwtoa043_t8_AOV_index] = number(getvalue(lwtoa043_c_ai_sysaovs_gamma_8));
			lwtoa043_ai_sysaovs_file_format[lwtoa043_t8_AOV_index] = int(getvalue(lwtoa043_c_ai_sysaovs_file_format_8)) - 1; // offset to 0-index for Arnold.
			lwtoa043_ai_sysaovs_pad1[lwtoa043_t8_AOV_index] = 0;
			lwtoa043_ai_sysaovs_pad2[lwtoa043_t8_AOV_index] = 0;
			lwtoa043_ai_sysaovs_pad3[lwtoa043_t8_AOV_index] = 0;
			lwtoa043_ai_sysaovs_pad4[lwtoa043_t8_AOV_index] = 0;

			lwtoa043_t8_AOV_index++;
			lwtoa043_ai_sysaovs_active[lwtoa043_t8_AOV_index] = int(getvalue(lwtoa043_c_ai_sysaovs_active_9));
			lwtoa043_ai_sysaovs_type[lwtoa043_t8_AOV_index] = int(getvalue(lwtoa043_c_ai_sysaovs_type_9)) - 1; // offset to 0-index for Arnold
			lwtoa043_ai_sysaovs_suf[lwtoa043_t8_AOV_index] = quoteString(string(getvalue(lwtoa043_c_ai_sysaovs_suffix_9)));
			lwtoa043_ai_sysaovs_filter[lwtoa043_t8_AOV_index] = int(getvalue(lwtoa043_c_ai_sysaovs_filter_9)) - 1; // offset to 0-index for Arnold.
			lwtoa043_ai_sysaovs_gamma[lwtoa043_t8_AOV_index] = number(getvalue(lwtoa043_c_ai_sysaovs_gamma_9));
			lwtoa043_ai_sysaovs_file_format[lwtoa043_t8_AOV_index] = int(getvalue(lwtoa043_c_ai_sysaovs_file_format_9)) - 1; // offset to 0-index for Arnold.
			lwtoa043_ai_sysaovs_pad1[lwtoa043_t8_AOV_index] = 0;
			lwtoa043_ai_sysaovs_pad2[lwtoa043_t8_AOV_index] = 0;
			lwtoa043_ai_sysaovs_pad3[lwtoa043_t8_AOV_index] = 0;
			lwtoa043_ai_sysaovs_pad4[lwtoa043_t8_AOV_index] = 0;

			lwtoa043_t8_AOV_index++;
			lwtoa043_ai_sysaovs_active[lwtoa043_t8_AOV_index] = int(getvalue(lwtoa043_c_ai_sysaovs_active_10));
			lwtoa043_ai_sysaovs_type[lwtoa043_t8_AOV_index] = int(getvalue(lwtoa043_c_ai_sysaovs_type_10)) - 1; // offset to 0-index for Arnold
			lwtoa043_ai_sysaovs_suf[lwtoa043_t8_AOV_index] = quoteString(string(getvalue(lwtoa043_c_ai_sysaovs_suffix_10)));
			lwtoa043_ai_sysaovs_filter[lwtoa043_t8_AOV_index] = int(getvalue(lwtoa043_c_ai_sysaovs_filter_10)) - 1; // offset to 0-index for Arnold.
			lwtoa043_ai_sysaovs_gamma[lwtoa043_t8_AOV_index] = number(getvalue(lwtoa043_c_ai_sysaovs_gamma_10));
			lwtoa043_ai_sysaovs_file_format[lwtoa043_t8_AOV_index] = int(getvalue(lwtoa043_c_ai_sysaovs_file_format_10)) - 1; // offset to 0-index for Arnold.
			lwtoa043_ai_sysaovs_pad1[lwtoa043_t8_AOV_index] = 0;
			lwtoa043_ai_sysaovs_pad2[lwtoa043_t8_AOV_index] = 0;
			lwtoa043_ai_sysaovs_pad3[lwtoa043_t8_AOV_index] = 0;
			lwtoa043_ai_sysaovs_pad4[lwtoa043_t8_AOV_index] = 0;

			lwtoa043_t8_AOV_index++;
			lwtoa043_ai_sysaovs_active[lwtoa043_t8_AOV_index] = int(getvalue(lwtoa043_c_ai_sysaovs_active_11));
			lwtoa043_ai_sysaovs_type[lwtoa043_t8_AOV_index] = int(getvalue(lwtoa043_c_ai_sysaovs_type_11)) - 1; // offset to 0-index for Arnold
			lwtoa043_ai_sysaovs_suf[lwtoa043_t8_AOV_index] = quoteString(string(getvalue(lwtoa043_c_ai_sysaovs_suffix_11)));
			lwtoa043_ai_sysaovs_filter[lwtoa043_t8_AOV_index] = int(getvalue(lwtoa043_c_ai_sysaovs_filter_11)) - 1; // offset to 0-index for Arnold.
			lwtoa043_ai_sysaovs_gamma[lwtoa043_t8_AOV_index] = number(getvalue(lwtoa043_c_ai_sysaovs_gamma_11));
			lwtoa043_ai_sysaovs_file_format[lwtoa043_t8_AOV_index] = int(getvalue(lwtoa043_c_ai_sysaovs_file_format_11)) - 1; // offset to 0-index for Arnold.
			lwtoa043_ai_sysaovs_pad1[lwtoa043_t8_AOV_index] = 0;
			lwtoa043_ai_sysaovs_pad2[lwtoa043_t8_AOV_index] = 0;
			lwtoa043_ai_sysaovs_pad3[lwtoa043_t8_AOV_index] = 0;
			lwtoa043_ai_sysaovs_pad4[lwtoa043_t8_AOV_index] = 0;

			lwtoa043_t8_AOV_index++;
			lwtoa043_ai_sysaovs_active[lwtoa043_t8_AOV_index] = int(getvalue(lwtoa043_c_ai_sysaovs_active_12));
			lwtoa043_ai_sysaovs_type[lwtoa043_t8_AOV_index] = int(getvalue(lwtoa043_c_ai_sysaovs_type_12)) - 1; // offset to 0-index for Arnold
			lwtoa043_ai_sysaovs_suf[lwtoa043_t8_AOV_index] = quoteString(string(getvalue(lwtoa043_c_ai_sysaovs_suffix_12)));
			lwtoa043_ai_sysaovs_filter[lwtoa043_t8_AOV_index] = int(getvalue(lwtoa043_c_ai_sysaovs_filter_12)) - 1; // offset to 0-index for Arnold.
			lwtoa043_ai_sysaovs_gamma[lwtoa043_t8_AOV_index] = number(getvalue(lwtoa043_c_ai_sysaovs_gamma_12));
			lwtoa043_ai_sysaovs_file_format[lwtoa043_t8_AOV_index] = int(getvalue(lwtoa043_c_ai_sysaovs_file_format_12)) - 1; // offset to 0-index for Arnold.
			lwtoa043_ai_sysaovs_pad1[lwtoa043_t8_AOV_index] = 0;
			lwtoa043_ai_sysaovs_pad2[lwtoa043_t8_AOV_index] = 0;
			lwtoa043_ai_sysaovs_pad3[lwtoa043_t8_AOV_index] = 0;
			lwtoa043_ai_sysaovs_pad4[lwtoa043_t8_AOV_index] = 0;

			lwtoa043_t8_AOV_index++;
			lwtoa043_ai_sysaovs_active[lwtoa043_t8_AOV_index] = int(getvalue(lwtoa043_c_ai_sysaovs_active_13));
			lwtoa043_ai_sysaovs_type[lwtoa043_t8_AOV_index] = int(getvalue(lwtoa043_c_ai_sysaovs_type_13)) - 1; // offset to 0-index for Arnold
			lwtoa043_ai_sysaovs_suf[lwtoa043_t8_AOV_index] = quoteString(string(getvalue(lwtoa043_c_ai_sysaovs_suffix_13)));
			lwtoa043_ai_sysaovs_filter[lwtoa043_t8_AOV_index] = int(getvalue(lwtoa043_c_ai_sysaovs_filter_13)) - 1; // offset to 0-index for Arnold.
			lwtoa043_ai_sysaovs_gamma[lwtoa043_t8_AOV_index] = number(getvalue(lwtoa043_c_ai_sysaovs_gamma_13));
			lwtoa043_ai_sysaovs_file_format[lwtoa043_t8_AOV_index] = int(getvalue(lwtoa043_c_ai_sysaovs_file_format_13)) - 1; // offset to 0-index for Arnold.
			lwtoa043_ai_sysaovs_pad1[lwtoa043_t8_AOV_index] = 0;
			lwtoa043_ai_sysaovs_pad2[lwtoa043_t8_AOV_index] = 0;
			lwtoa043_ai_sysaovs_pad3[lwtoa043_t8_AOV_index] = 0;
			lwtoa043_ai_sysaovs_pad4[lwtoa043_t8_AOV_index] = 0;

			lwtoa043_t8_AOV_index++;
			lwtoa043_ai_sysaovs_active[lwtoa043_t8_AOV_index] = int(getvalue(lwtoa043_c_ai_sysaovs_active_14));
			lwtoa043_ai_sysaovs_type[lwtoa043_t8_AOV_index] = int(getvalue(lwtoa043_c_ai_sysaovs_type_14)) - 1; // offset to 0-index for Arnold
			lwtoa043_ai_sysaovs_suf[lwtoa043_t8_AOV_index] = quoteString(string(getvalue(lwtoa043_c_ai_sysaovs_suffix_14)));
			lwtoa043_ai_sysaovs_filter[lwtoa043_t8_AOV_index] = int(getvalue(lwtoa043_c_ai_sysaovs_filter_14)) - 1; // offset to 0-index for Arnold.
			lwtoa043_ai_sysaovs_gamma[lwtoa043_t8_AOV_index] = number(getvalue(lwtoa043_c_ai_sysaovs_gamma_14));
			lwtoa043_ai_sysaovs_file_format[lwtoa043_t8_AOV_index] = int(getvalue(lwtoa043_c_ai_sysaovs_file_format_14)) - 1; // offset to 0-index for Arnold.
			lwtoa043_ai_sysaovs_pad1[lwtoa043_t8_AOV_index] = 0;
			lwtoa043_ai_sysaovs_pad2[lwtoa043_t8_AOV_index] = 0;
			lwtoa043_ai_sysaovs_pad3[lwtoa043_t8_AOV_index] = 0;
			lwtoa043_ai_sysaovs_pad4[lwtoa043_t8_AOV_index] = 0;

			lwtoa043_t8_AOV_index++;
			lwtoa043_ai_sysaovs_active[lwtoa043_t8_AOV_index] = int(getvalue(lwtoa043_c_ai_sysaovs_active_15));
			lwtoa043_ai_sysaovs_type[lwtoa043_t8_AOV_index] = int(getvalue(lwtoa043_c_ai_sysaovs_type_15)) - 1; // offset to 0-index for Arnold
			lwtoa043_ai_sysaovs_suf[lwtoa043_t8_AOV_index] = quoteString(string(getvalue(lwtoa043_c_ai_sysaovs_suffix_15)));
			lwtoa043_ai_sysaovs_filter[lwtoa043_t8_AOV_index] = int(getvalue(lwtoa043_c_ai_sysaovs_filter_15)) - 1; // offset to 0-index for Arnold.
			lwtoa043_ai_sysaovs_gamma[lwtoa043_t8_AOV_index] = number(getvalue(lwtoa043_c_ai_sysaovs_gamma_15));
			lwtoa043_ai_sysaovs_file_format[lwtoa043_t8_AOV_index] = int(getvalue(lwtoa043_c_ai_sysaovs_file_format_15)) - 1; // offset to 0-index for Arnold.
			lwtoa043_ai_sysaovs_pad1[lwtoa043_t8_AOV_index] = 0;
			lwtoa043_ai_sysaovs_pad2[lwtoa043_t8_AOV_index] = 0;
			lwtoa043_ai_sysaovs_pad3[lwtoa043_t8_AOV_index] = 0;
			lwtoa043_ai_sysaovs_pad4[lwtoa043_t8_AOV_index] = 0;

			lwtoa043_t8_AOV_index++;
			lwtoa043_ai_sysaovs_active[lwtoa043_t8_AOV_index] = int(getvalue(lwtoa043_c_ai_sysaovs_active_16));
			lwtoa043_ai_sysaovs_type[lwtoa043_t8_AOV_index] = int(getvalue(lwtoa043_c_ai_sysaovs_type_16)) - 1; // offset to 0-index for Arnold
			lwtoa043_ai_sysaovs_suf[lwtoa043_t8_AOV_index] = quoteString(string(getvalue(lwtoa043_c_ai_sysaovs_suffix_16)));
			lwtoa043_ai_sysaovs_filter[lwtoa043_t8_AOV_index] = int(getvalue(lwtoa043_c_ai_sysaovs_filter_16)) - 1; // offset to 0-index for Arnold.
			lwtoa043_ai_sysaovs_gamma[lwtoa043_t8_AOV_index] = number(getvalue(lwtoa043_c_ai_sysaovs_gamma_16));
			lwtoa043_ai_sysaovs_file_format[lwtoa043_t8_AOV_index] = int(getvalue(lwtoa043_c_ai_sysaovs_file_format_16)) - 1; // offset to 0-index for Arnold.
			lwtoa043_ai_sysaovs_pad1[lwtoa043_t8_AOV_index] = 0;
			lwtoa043_ai_sysaovs_pad2[lwtoa043_t8_AOV_index] = 0;
			lwtoa043_ai_sysaovs_pad3[lwtoa043_t8_AOV_index] = 0;
			lwtoa043_ai_sysaovs_pad4[lwtoa043_t8_AOV_index] = 0;

			lwtoa043_t8_AOV_index++;
			lwtoa043_ai_sysaovs_active[lwtoa043_t8_AOV_index] = int(getvalue(lwtoa043_c_ai_sysaovs_active_17));
			lwtoa043_ai_sysaovs_type[lwtoa043_t8_AOV_index] = int(getvalue(lwtoa043_c_ai_sysaovs_type_17)) - 1; // offset to 0-index for Arnold
			lwtoa043_ai_sysaovs_suf[lwtoa043_t8_AOV_index] = quoteString(string(getvalue(lwtoa043_c_ai_sysaovs_suffix_17)));
			lwtoa043_ai_sysaovs_filter[lwtoa043_t8_AOV_index] = int(getvalue(lwtoa043_c_ai_sysaovs_filter_17)) - 1; // offset to 0-index for Arnold.
			lwtoa043_ai_sysaovs_gamma[lwtoa043_t8_AOV_index] = number(getvalue(lwtoa043_c_ai_sysaovs_gamma_17));
			lwtoa043_ai_sysaovs_file_format[lwtoa043_t8_AOV_index] = int(getvalue(lwtoa043_c_ai_sysaovs_file_format_17)) - 1; // offset to 0-index for Arnold.
			lwtoa043_ai_sysaovs_pad1[lwtoa043_t8_AOV_index] = 0;
			lwtoa043_ai_sysaovs_pad2[lwtoa043_t8_AOV_index] = 0;
			lwtoa043_ai_sysaovs_pad3[lwtoa043_t8_AOV_index] = 0;
			lwtoa043_ai_sysaovs_pad4[lwtoa043_t8_AOV_index] = 0;

			lwtoa043_t8_AOV_index++;
			lwtoa043_ai_sysaovs_active[lwtoa043_t8_AOV_index] = int(getvalue(lwtoa043_c_ai_sysaovs_active_18));
			lwtoa043_ai_sysaovs_type[lwtoa043_t8_AOV_index] = int(getvalue(lwtoa043_c_ai_sysaovs_type_18)) - 1; // offset to 0-index for Arnold
			lwtoa043_ai_sysaovs_suf[lwtoa043_t8_AOV_index] = quoteString(string(getvalue(lwtoa043_c_ai_sysaovs_suffix_18)));
			lwtoa043_ai_sysaovs_filter[lwtoa043_t8_AOV_index] = int(getvalue(lwtoa043_c_ai_sysaovs_filter_18)) - 1; // offset to 0-index for Arnold.
			lwtoa043_ai_sysaovs_gamma[lwtoa043_t8_AOV_index] = number(getvalue(lwtoa043_c_ai_sysaovs_gamma_18));
			lwtoa043_ai_sysaovs_file_format[lwtoa043_t8_AOV_index] = int(getvalue(lwtoa043_c_ai_sysaovs_file_format_18)) - 1; // offset to 0-index for Arnold.
			lwtoa043_ai_sysaovs_pad1[lwtoa043_t8_AOV_index] = 0;
			lwtoa043_ai_sysaovs_pad2[lwtoa043_t8_AOV_index] = 0;
			lwtoa043_ai_sysaovs_pad3[lwtoa043_t8_AOV_index] = 0;
			lwtoa043_ai_sysaovs_pad4[lwtoa043_t8_AOV_index] = 0;

			lwtoa043_t8_AOV_index++;
			lwtoa043_ai_sysaovs_active[lwtoa043_t8_AOV_index] = int(getvalue(lwtoa043_c_ai_sysaovs_active_19));
			lwtoa043_ai_sysaovs_type[lwtoa043_t8_AOV_index] = int(getvalue(lwtoa043_c_ai_sysaovs_type_19)) - 1; // offset to 0-index for Arnold
			lwtoa043_ai_sysaovs_suf[lwtoa043_t8_AOV_index] = quoteString(string(getvalue(lwtoa043_c_ai_sysaovs_suffix_19)));
			lwtoa043_ai_sysaovs_filter[lwtoa043_t8_AOV_index] = int(getvalue(lwtoa043_c_ai_sysaovs_filter_19)) - 1; // offset to 0-index for Arnold.
			lwtoa043_ai_sysaovs_gamma[lwtoa043_t8_AOV_index] = number(getvalue(lwtoa043_c_ai_sysaovs_gamma_19));
			lwtoa043_ai_sysaovs_file_format[lwtoa043_t8_AOV_index] = int(getvalue(lwtoa043_c_ai_sysaovs_file_format_19)) - 1; // offset to 0-index for Arnold.
			lwtoa043_ai_sysaovs_pad1[lwtoa043_t8_AOV_index] = 0;
			lwtoa043_ai_sysaovs_pad2[lwtoa043_t8_AOV_index] = 0;
			lwtoa043_ai_sysaovs_pad3[lwtoa043_t8_AOV_index] = 0;
			lwtoa043_ai_sysaovs_pad4[lwtoa043_t8_AOV_index] = 0;

			lwtoa043_t8_AOV_index++;
			lwtoa043_ai_sysaovs_active[lwtoa043_t8_AOV_index] = int(getvalue(lwtoa043_c_ai_sysaovs_active_20));
			lwtoa043_ai_sysaovs_type[lwtoa043_t8_AOV_index] = int(getvalue(lwtoa043_c_ai_sysaovs_type_20)) - 1; // offset to 0-index for Arnold
			lwtoa043_ai_sysaovs_suf[lwtoa043_t8_AOV_index] = quoteString(string(getvalue(lwtoa043_c_ai_sysaovs_suffix_20)));
			lwtoa043_ai_sysaovs_filter[lwtoa043_t8_AOV_index] = int(getvalue(lwtoa043_c_ai_sysaovs_filter_20)) - 1; // offset to 0-index for Arnold.
			lwtoa043_ai_sysaovs_gamma[lwtoa043_t8_AOV_index] = number(getvalue(lwtoa043_c_ai_sysaovs_gamma_20));
			lwtoa043_ai_sysaovs_file_format[lwtoa043_t8_AOV_index] = int(getvalue(lwtoa043_c_ai_sysaovs_file_format_20)) - 1; // offset to 0-index for Arnold.
			lwtoa043_ai_sysaovs_pad1[lwtoa043_t8_AOV_index] = 0;
			lwtoa043_ai_sysaovs_pad2[lwtoa043_t8_AOV_index] = 0;
			lwtoa043_ai_sysaovs_pad3[lwtoa043_t8_AOV_index] = 0;
			lwtoa043_ai_sysaovs_pad4[lwtoa043_t8_AOV_index] = 0;

			lwtoa043_t8_AOV_index++;
			lwtoa043_ai_sysaovs_active[lwtoa043_t8_AOV_index] = int(getvalue(lwtoa043_c_ai_sysaovs_active_21));
			lwtoa043_ai_sysaovs_type[lwtoa043_t8_AOV_index] = int(getvalue(lwtoa043_c_ai_sysaovs_type_21)) - 1; // offset to 0-index for Arnold
			lwtoa043_ai_sysaovs_suf[lwtoa043_t8_AOV_index] = quoteString(string(getvalue(lwtoa043_c_ai_sysaovs_suffix_21)));
			lwtoa043_ai_sysaovs_filter[lwtoa043_t8_AOV_index] = int(getvalue(lwtoa043_c_ai_sysaovs_filter_21)) - 1; // offset to 0-index for Arnold.
			lwtoa043_ai_sysaovs_gamma[lwtoa043_t8_AOV_index] = number(getvalue(lwtoa043_c_ai_sysaovs_gamma_21));
			lwtoa043_ai_sysaovs_file_format[lwtoa043_t8_AOV_index] = int(getvalue(lwtoa043_c_ai_sysaovs_file_format_21)) - 1; // offset to 0-index for Arnold.
			lwtoa043_ai_sysaovs_pad1[lwtoa043_t8_AOV_index] = 0;
			lwtoa043_ai_sysaovs_pad2[lwtoa043_t8_AOV_index] = 0;
			lwtoa043_ai_sysaovs_pad3[lwtoa043_t8_AOV_index] = 0;
			lwtoa043_ai_sysaovs_pad4[lwtoa043_t8_AOV_index] = 0;

			lwtoa043_t8_AOV_index++;
			lwtoa043_ai_sysaovs_active[lwtoa043_t8_AOV_index] = int(getvalue(lwtoa043_c_ai_sysaovs_active_22));
			lwtoa043_ai_sysaovs_type[lwtoa043_t8_AOV_index] = int(getvalue(lwtoa043_c_ai_sysaovs_type_22)) - 1; // offset to 0-index for Arnold
			lwtoa043_ai_sysaovs_suf[lwtoa043_t8_AOV_index] = quoteString(string(getvalue(lwtoa043_c_ai_sysaovs_suffix_22)));
			lwtoa043_ai_sysaovs_filter[lwtoa043_t8_AOV_index] = int(getvalue(lwtoa043_c_ai_sysaovs_filter_22)) - 1; // offset to 0-index for Arnold.
			lwtoa043_ai_sysaovs_gamma[lwtoa043_t8_AOV_index] = number(getvalue(lwtoa043_c_ai_sysaovs_gamma_22));
			lwtoa043_ai_sysaovs_file_format[lwtoa043_t8_AOV_index] = int(getvalue(lwtoa043_c_ai_sysaovs_file_format_22)) - 1; // offset to 0-index for Arnold.
			lwtoa043_ai_sysaovs_pad1[lwtoa043_t8_AOV_index] = 0;
			lwtoa043_ai_sysaovs_pad2[lwtoa043_t8_AOV_index] = 0;
			lwtoa043_ai_sysaovs_pad3[lwtoa043_t8_AOV_index] = 0;
			lwtoa043_ai_sysaovs_pad4[lwtoa043_t8_AOV_index] = 0;

			lwtoa043_t8_AOV_index++;
			lwtoa043_ai_sysaovs_active[lwtoa043_t8_AOV_index] = int(getvalue(lwtoa043_c_ai_sysaovs_active_23));
			lwtoa043_ai_sysaovs_type[lwtoa043_t8_AOV_index] = int(getvalue(lwtoa043_c_ai_sysaovs_type_23)) - 1; // offset to 0-index for Arnold
			lwtoa043_ai_sysaovs_suf[lwtoa043_t8_AOV_index] = quoteString(string(getvalue(lwtoa043_c_ai_sysaovs_suffix_23)));
			lwtoa043_ai_sysaovs_filter[lwtoa043_t8_AOV_index] = int(getvalue(lwtoa043_c_ai_sysaovs_filter_23)) - 1; // offset to 0-index for Arnold.
			lwtoa043_ai_sysaovs_gamma[lwtoa043_t8_AOV_index] = number(getvalue(lwtoa043_c_ai_sysaovs_gamma_23));
			lwtoa043_ai_sysaovs_file_format[lwtoa043_t8_AOV_index] = int(getvalue(lwtoa043_c_ai_sysaovs_file_format_23)) - 1; // offset to 0-index for Arnold.
			lwtoa043_ai_sysaovs_pad1[lwtoa043_t8_AOV_index] = 0;
			lwtoa043_ai_sysaovs_pad2[lwtoa043_t8_AOV_index] = 0;
			lwtoa043_ai_sysaovs_pad3[lwtoa043_t8_AOV_index] = 0;
			lwtoa043_ai_sysaovs_pad4[lwtoa043_t8_AOV_index] = 0;

			lwtoa043_t8_AOV_index++;
			lwtoa043_ai_sysaovs_active[lwtoa043_t8_AOV_index] = int(getvalue(lwtoa043_c_ai_sysaovs_active_24));
			lwtoa043_ai_sysaovs_type[lwtoa043_t8_AOV_index] = int(getvalue(lwtoa043_c_ai_sysaovs_type_24)) - 1; // offset to 0-index for Arnold
			lwtoa043_ai_sysaovs_suf[lwtoa043_t8_AOV_index] = quoteString(string(getvalue(lwtoa043_c_ai_sysaovs_suffix_24)));
			lwtoa043_ai_sysaovs_filter[lwtoa043_t8_AOV_index] = int(getvalue(lwtoa043_c_ai_sysaovs_filter_24)) - 1; // offset to 0-index for Arnold.
			lwtoa043_ai_sysaovs_gamma[lwtoa043_t8_AOV_index] = number(getvalue(lwtoa043_c_ai_sysaovs_gamma_24));
			lwtoa043_ai_sysaovs_file_format[lwtoa043_t8_AOV_index] = int(getvalue(lwtoa043_c_ai_sysaovs_file_format_24)) - 1; // offset to 0-index for Arnold.
			lwtoa043_ai_sysaovs_pad1[lwtoa043_t8_AOV_index] = 0;
			lwtoa043_ai_sysaovs_pad2[lwtoa043_t8_AOV_index] = 0;
			lwtoa043_ai_sysaovs_pad3[lwtoa043_t8_AOV_index] = 0;
			lwtoa043_ai_sysaovs_pad4[lwtoa043_t8_AOV_index] = 0;

			// Populate the rest of the AOVs (currently unused in LWtoA) with default data.
			lwtoa043_t8_AOV_index++;
			while(lwtoa043_t8_AOV_index <= lwtoa043_MAX_SYS_AOVS)
			{
				lwtoa043_ai_sysaovs_active[lwtoa043_t8_AOV_index] = 0;
				lwtoa043_ai_sysaovs_type[lwtoa043_t8_AOV_index] = 0;
				lwtoa043_ai_sysaovs_suf[lwtoa043_t8_AOV_index] = "\"\"";
				lwtoa043_ai_sysaovs_filter[lwtoa043_t8_AOV_index] = 0;
				lwtoa043_ai_sysaovs_gamma[lwtoa043_t8_AOV_index] = 1;
				lwtoa043_ai_sysaovs_file_format[lwtoa043_t8_AOV_index] = 0;
				lwtoa043_ai_sysaovs_pad1[lwtoa043_t8_AOV_index] = 0;
				lwtoa043_ai_sysaovs_pad2[lwtoa043_t8_AOV_index] = 0;
				lwtoa043_ai_sysaovs_pad3[lwtoa043_t8_AOV_index] = 0;
				lwtoa043_ai_sysaovs_pad4[lwtoa043_t8_AOV_index] = 0;
				lwtoa043_t8_AOV_index++;
			}

			lwtoa043_ai_sysaovs_fileoptions_path = sanitizePath(string(getvalue(lwtoa043_c_ai_sysaovs_fileoptions_path)),1,1);
			lwtoa043_ai_sysaovs_fileoptions_exr_compress = int(getvalue(lwtoa043_c_ai_sysaovs_fileoptions_exr_compress)) - 1; // offset to 0-index for Arnold.
			lwtoa043_ai_sysaovs_fileoptions_exr_half = int(getvalue(lwtoa043_c_ai_sysaovs_fileoptions_exr_half));
			lwtoa043_ai_sysaovs_fileoptions_exr_tiled = int(getvalue(lwtoa043_c_ai_sysaovs_fileoptions_exr_tiled));
			lwtoa043_ai_sysaovs_fileoptions_exr_preserve = int(getvalue(lwtoa043_c_ai_sysaovs_fileoptions_exr_preserve));
			lwtoa043_ai_sysaovs_fileoptions_tif_compress = int(getvalue(lwtoa043_c_ai_sysaovs_fileoptions_tif_compress)) - 1; // offset to 0-index for Arnold.
			lwtoa043_ai_sysaovs_fileoptions_tif_format = int(getvalue(lwtoa043_c_ai_sysaovs_fileoptions_tif_format)) - 1; // offset to 0-index for Arnold.
			lwtoa043_ai_sysaovs_fileoptions_tif_tiled = int(getvalue(lwtoa043_c_ai_sysaovs_fileoptions_tif_tiled));
			lwtoa043_ai_sysaovs_fileoptions_tif_dither = number(getvalue(lwtoa043_c_ai_sysaovs_fileoptions_tif_dither));

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
			::overrideNames[newNumber] = newName + "   (scene properties)";
			::overrideSettings[newNumber] = newName + "||" + "type6" + "||"
										+ string(::overrideRenderer) + "||"
										+ string(activeCameraID) + "||"
										+ string(redirectBuffersSetts) + "||"
										+ string(lwtoa043_default_arnoldMajor) + "||" + string(lwtoa043_default_arnoldMinor) + "||" + string(lwtoa043_default_arnoldPatch) + "||"
										+ string(lwtoa043_ai_mt_auto) + "||" + string(lwtoa043_ai_mt_num) + "||" + string(lwtoa043_ai_scan_mode) + "||"
										+ string(lwtoa043_ai_prog_sampling) + "||" + string(lwtoa043_ai_bx) + "||" + string(lwtoa043_ai_license_skip) + "||"
										+ string(lwtoa043_ai_aas) + "||" + string(lwtoa043_ai_ds) + "||" + string(lwtoa043_ai_gs) + "||" + string(lwtoa043_ai_rs) + "||"
										+ string(lwtoa043_ai_clamp) + "||" + string(lwtoa043_ai_clamp_max) + "||" + string(lwtoa043_ai_lock) + "||"
										+ string(lwtoa043_ai_pf) + "||" + string(lwtoa043_ai_pw) + "||" + string(lwtoa043_ai_rd_total)+ "||"
										+ string(lwtoa043_ai_rd_diffuse) + "||" + string(lwtoa043_ai_rd_refl) + "||" + string(lwtoa043_ai_rd_refr) + "||"
										+ string(lwtoa043_ai_rd_glossy) + "||" + string(lwtoa043_ai_mb_def) + "||" + string(lwtoa043_ai_mb_duration) + "||"
										+ string(lwtoa043_ai_shutter_type) + "||" + string(lwtoa043_ai_mb_deform_steps) + "||" + string(lwtoa043_ai_mb_apply_cam) + "||"
										+ string(lwtoa043_ai_mb_apply_light) + "||" + string(lwtoa043_ai_mb_apply_obj) + "||" 
										+ string(lwtoa043_ai_mb_forceRefresh) + "||" + string(lwtoa043_ai_dof_aspect) + "||" + string(lwtoa043_ai_dof_curvature) + "||"
										+ string(lwtoa043_ai_instance_lwclones) + "||" + string(lwtoa043_ai_instance_nulls) + "||" 
										+ string(lwtoa043_ai_render_to_file) + "||" + string(lwtoa043_ai_filename) + "||" + string(lwtoa043_ai_compress_file) + "||"
										+ string(lwtoa043_ai_writenode_options) + "||" + string(lwtoa043_ai_writenode_drivers) + "||" 
										+ string(lwtoa043_ai_writenode_geom) + "||" + string(lwtoa043_ai_writenode_cam) + "||" 
										+ string(lwtoa043_ai_writenode_lights) + "||" + string(lwtoa043_ai_writenode_shaders) + "||"
										+ string(lwtoa043_ai_ass_binary) + "||" + string(lwtoa043_ai_log_console) + "||" + string(lwtoa043_ai_log_write) + "||"
										+ string(lwtoa043_ai_log_filename) + "||" + string(lwtoa043_ai_log_level) + "||" + string(lwtoa043_ai_log_max) + "||"
										+ string(lwtoa043_ai_log_ipr_level) + "||" + string(lwtoa043_ai_tex_accept_nomipmap) + "||"
										+ string(lwtoa043_ai_tex_automipmap) + "||" + string(lwtoa043_ai_tex_magfilter) + "||" 
										+ string(lwtoa043_ai_tex_accept_untiled) + "||" + string(lwtoa043_ai_tex_autotile) + "||" 
										+ string(lwtoa043_ai_tex_tile_size) + "||" + string(lwtoa043_ai_tex_cache) + "||" + string(lwtoa043_ai_tex_cache_size) + "||"
										+ string(lwtoa043_ai_tex_maxfiles) + "||" + string(lwtoa043_ai_abort_lic_fail) + "||" + string(lwtoa043_ai_sampling_mult) + "||"
										+ string(lwtoa043_ai_light_sampling_mult) + "||" + string(lwtoa043_ai_mult_factor) + "||" 
										+ string(lwtoa043_ai_light_mult_factor) + "||" + string(lwtoa043_ai_sysaovs_enable) + "||" 
										+ string(lwtoa043_ai_sysaovs_display) + "||" + string(lwtoa043_ai_sysaovs_fileoptions_path) + "||"
										+ string(lwtoa043_ai_sysaovs_fileoptions_exr_compress) + "||"
										+ string(lwtoa043_ai_sysaovs_fileoptions_exr_half) + "||"
										+ string(lwtoa043_ai_sysaovs_fileoptions_exr_tiled) + "||"
										+ string(lwtoa043_ai_sysaovs_fileoptions_exr_preserve) + "||"
										+ string(lwtoa043_ai_sysaovs_fileoptions_tif_compress) + "||"
										+ string(lwtoa043_ai_sysaovs_fileoptions_tif_format) + "||"
										+ string(lwtoa043_ai_sysaovs_fileoptions_tif_tiled) + "||"
										+ string(lwtoa043_ai_sysaovs_fileoptions_tif_dither) + "||"
										+ string(lwtoa043_ai_sysaovs_fileoptions_pad1) + "||"
										+ string(lwtoa043_ai_sysaovs_fileoptions_pad2) + "||"
										+ string(lwtoa043_ai_sysaovs_fileoptions_pad3) + "||"
										+ string(lwtoa043_ai_sysaovs_fileoptions_pad4);
			// DEBUG
			// logger("log_info","1: " + ::overrideSettings[newNumber]);
			::tempArray = nil;
			::tempArray = ::overrideSettings[newNumber];
			::overrideSettings[newNumber] = ::tempArray;

			for (x=1; x <= lwtoa043_MAX_SYS_AOVS; x++)
			{
				::overrideSettings[newNumber] = ::overrideSettings[newNumber] + "||"
				+ string(lwtoa043_ai_sysaovs_active[x]) + "||"
				+ string(lwtoa043_ai_sysaovs_type[x]) + "||"
				+ string(lwtoa043_ai_sysaovs_suf[x]) + "||"
				+ string(lwtoa043_ai_sysaovs_filter[x]) + "||"
				+ string(lwtoa043_ai_sysaovs_gamma[x]) + "||"
				+ string(lwtoa043_ai_sysaovs_file_format[x]) + "||"
				+ string(lwtoa043_ai_sysaovs_pad1[x]) + "||"
				+ string(lwtoa043_ai_sysaovs_pad2[x]) + "||"
				+ string(lwtoa043_ai_sysaovs_pad3[x]) + "||"
				+ string(lwtoa043_ai_sysaovs_pad4[x]);
			}
			// DEBUG
			// logger("log_info","2: " + ::overrideSettings[newNumber]);
			::tempArray = nil;
			::tempArray = ::overrideSettings[newNumber];
			::overrideSettings[newNumber] = ::tempArray;

			::overrideSettings[newNumber] = ::overrideSettings[newNumber] + "||"
										+ string(lwtoa043_ai_trans_depth) + "||"	+ string(lwtoa043_ai_trans_mode) + "||" + string(lwtoa043_ai_trans_threshold) + "||"
										+ string(lwtoa043_ai_sss_spacing) + "||" + string(lwtoa043_ai_sss_distribution) + "||"
										+ string(lwtoa043_ai_sss_factor) + "||" + string(lwtoa043_ai_sss_show) + "||" + string(lwtoa043_ai_ignore_textures) + "||"
										+ string(lwtoa043_ai_ignore_shaders) + "||" + string(lwtoa043_ai_ignore_atmosphere) + "||" 
										+ string(lwtoa043_ai_ignore_lights) + "||" + string(lwtoa043_ai_ignore_shadows) + "||" 
										+ string(lwtoa043_ai_ignore_subdivision) + "||" + string(lwtoa043_ai_ignore_displacement) + "||"
										+ string(lwtoa043_ai_ignore_bump) + "||" + string(lwtoa043_ai_ignore_motion_blur) + "||" 
										+ string(lwtoa043_ai_ignore_smoothing) + "||" + string(lwtoa043_ai_ignore_sss) + "||" 
										+ string(lwtoa043_ai_ignore_direct_lighting) + "||" + string(lwtoa043_ai_cam_type) + "||" + string(lwtoa043_ai_cam_near) + "||"
										+ string(lwtoa043_ai_cam_far) + "||" + string(lwtoa043_ai_cam_fisheye_crop) + "||" + string(lwtoa043_ai_cam_ortho_factor) + "||"
										+ string(lwtoa043_ai_mb_apply_psys) + "||" + string(lwtoa043_ai_mb_psys_factor) + "||" 
										+ string(lwtoa043_ai_background_visbility) + "||" + string(lwtoa043_ai_log_sn_level) + "||" + string(lwtoa043_ai_info_add) + "||"
										+ string(lwtoa043_ai_info_txt) + "||" + string(lwtoa043_ai_instance_lw11) + "||" + string(lwtoa043_ai_sds_max_level) + "||"
										+ string(lwtoa043_ai_shading_pass);

			// DEBUG
			// logger("log_info","3: " + ::overrideSettings[newNumber]);
			for (x=1; x <= lwtoa043_SHADING_PASSES; x++)	// lwtoa043_SHADING_PASSES = 12
			{
				::overrideSettings[newNumber] = ::overrideSettings[newNumber] + "||"
				+ quoteString(string(lwtoa043_shading_pass_names[x]));
				::tempArray = nil;
				::tempArray = ::overrideSettings[newNumber];
				::overrideSettings[newNumber] = ::tempArray;
			}
			// DEBUG
			// logger("log_info","4: " + ::overrideSettings[newNumber]);
			::overrideSettings[newNumber] = ::overrideSettings[newNumber] + "||"
										+ string(lwtoa043_ai_multithread_loading) + "||" + string(lwtoa043_ai_aov_composition) + "||"
										+ string(lwtoa043_ai_ignore_mis) + "||" + string(lwtoa043_ai_volumetric_type) + "||" + string(lwtoa043_ai_cam_exposure) + "||" 
										+ string(lwtoa043_ai_gamma_light) + "||" + string(lwtoa043_ai_gamma_shader) + "||" + string(lwtoa043_ai_gamma_texture) + "||"
										+ string(lwtoa043_ai_tex_diffuse_blur) + "||" + string(lwtoa043_ai_tex_glossy_blur) + "||"
										+ string(lwtoa043_ai_low_light_threshold) + "||" + string(lwtoa043_ai_ignore_dof) + "||" + string(lwtoa043_ai_sss_engine) + "||"
										+ string(lwtoa043_ai_sss_samples) + "||" + string(lwtoa043_ai_clamp_aovs) + "||" + string(lwtoa043_ai_nlights_heatmap) + "||"
										+ string(lwtoa043_ai_ignore_procedurals) + "||" + string(lwtoa043_ai_procedural_path) + "||"
										+ string(lwtoa043_ai_texture_path) + "||" + string(lwtoa043_ai_shader_path) + "||" + string(lwtoa043_ai_log_frame_number) + "||"
										+ string(lwtoa043_ai_ipr_license_skip) + "||" + string(lwtoa043_ai_texture_max_sharpen) + "||"
										+ string(lwtoa043_ai_shader_timing_stats);
			::tempArray = nil;
			::tempArray = ::overrideSettings[newNumber];
			::overrideSettings[newNumber] = ::tempArray;
			::overrideSettings[newNumber] = ::overrideSettings[newNumber] + "||" + string(lwtoa043_ai_enable_multiple_uvmaps) + "||"
										+ string(lwtoa043_ai_rendering_mode) + "||" + string(lwtoa043_ai_reload_lights) + "||" + string(lwtoa043_ai_reload_materials) + "||"
										+ string(lwtoa043_ai_disable_rotational_mb) + "||" + string(lwtoa043_ai_cam_rolling_shutter);
			// DEBUG
			// logger("log_info","5: " + ::overrideSettings[newNumber]);
			::tempArray = nil;
			::tempArray = ::overrideSettings[newNumber];
			::overrideSettings[newNumber] = ::tempArray;
		}
		reqend();
	} else {
		logger("error","scnmasterOverride_UI_arnold043: incorrect, or no, action passed");
	}
}

// Redraw custom drawing on requester
scnGen_lwtoa043_req_redraw
{
	// Draw line underneath tabs (UI beautification!)
	// drawline(<060,061,063>, 0, lwtoa043_tabrow, lwtoa043_ui_window_w, lwtoa043_tabrow1);
	requpdate();
}

scnGen_lwtoa043_aov_stub: val
{
	// Nothing to do. We have this stub only to satisfy the requirements of our state buttons.
}
