// UI variables
lwtoa043_SHADING_PASSES = 12;
lwtoa043_maxthreads = 32;
lwtoa043_maxsamples = 64; // TO BE CONFIRMED
lwtoa043_max_rt_sss_samples = 16;
lwtoa043_max_pc_sss_factor = 10;
lwtoa043_max_rays = 24;
lwtoa043_max_transdepth = 20;
lwtoa043_bucketscanning_array = @"top","bottom","left","right","random","woven","spiral","hilbert"@;
lwtoa043_pixelfilter_array = @"blackman_harris", "box", "catrom", "cone", "cook", "cubic", "disk", "gaussian", "mitnet", "triangle",
							  "variance", "video", "closest"@;
lwtoa043_samplingmult_array = @"10%", "25%", "50%", "100%", "200%", "400%"@;
lwtoa043_sssengine_array = @"Raytraced","Pointclouds"@;
lwtoa043_pc_sample_distrib_array = @"blue_noise", "blue_noise_Pref", "triange_midpoint", "polygon_midpoint"@;
lwtoa043_pc_showsamples_array = @"off", "sss_points", "sss_irradiance"@;
lwtoa043_vol_engine_array = @"None", "Physical Sky", "Lightwave Fog", "Arnold Fog", "Arnold Volume Scattering"@;
lwtoa043_backdrop_ray_vis_array = @"None, only Alpha", "Reflection (with Alpha)", "Full GI (with Alpha)", "Camera only (no Alpha)", "Camera + Reflection (no Alpha)", "Full GI (no Alpha)"@;
lwtoa043_camera_types = @"Perspective Camera", "Fisheye Camera", "Ortho Camera", "Spherical Camera"@;
lwtoa043_shutter_types = @"box", "triangle"@;
lwtoa043_debug_verbosity_array = @"Warnings only", "Info", "Detailed", "Debug"@;
lwtoa043_default_mag_filter_array = @"Closest", "Bilinear", "Bicubic"@;
lwtoa043_AOV_array = @"RGBA", "RGB", "A", "Z", "opacity", "ID", "cputime", "raycount", "P", "N", "motionvector", "direct_diffuse", "direct_specular", "emission", "indirect_diffuse", "indirect_specular", "reflection", "refraction", "sss", "primary_specular", "secondary specular", "shallow_scatter", "mid_scatter", "deep_scatter"@;
lwtoa043_AOV_colheaders = @"AOV", "Type", "Suffix", "Filter", "Gamma", "Format"@;
lwtoa043_AOV_types = @"RGBA", "RGB", "FLOAT", "VECTOR", "POINT", "INT"@;
lwtoa043_AOV_formats = @"exr","tiff","jpeg"@;
lwtoa043_exr_options_array = @"none","piz","pxr24", "rle", "zip"@;
lwtoa043_tiff_options_array = @"none","lzw","ccittrle", "zip", "packbits"@;
lwtoa043_tiff_depth_array = @"int8","int16","int32","float16","float32"@;
lwtoa043_rolling_shutter_array = @"off","top","bottom","left","right"@;
lwtoa043_rendering_mode_array = @"Full Scene Reload","Update Scene"@;

// Arnold variables taken directly from Arnold saver code, courtesy of Juanjo

lwtoa043_default_arnoldMajor = 0;
lwtoa043_default_arnoldMinor = 4;
lwtoa043_default_arnoldPatch = 3;

// Settings (also in same order of scene file)

lwtoa043_arnoldMajor;
lwtoa043_arnoldMinor;
lwtoa043_arnoldPatch;

// Main arnold parameters
lwtoa043_ai_mt_auto; 			// multithread auto
lwtoa043_ai_mt_num; 				// number of threads
lwtoa043_ai_scan_mode; 			// buckets scanning mode
lwtoa043_ai_prog_sampling; 		// progressive sampling in preview

lwtoa043_ai_bx;					// buckets size
lwtoa043_ai_license_skip;		// skip license search

// Sampling parameters
lwtoa043_ai_aas;					// antialiasing samples
lwtoa043_ai_ds;					// diffuse samples
lwtoa043_ai_gs;					// glossy samples
lwtoa043_ai_rs;					// refraction samples
lwtoa043_ai_clamp;				// clamp sample values.
lwtoa043_ai_clamp_max;			// clamp max value
lwtoa043_ai_lock;				// lock sampling noise
lwtoa043_ai_pf;					// pixel filtering type
lwtoa043_ai_pw;					// pixel filtering width

// Ray depth parameters
lwtoa043_ai_rd_total;			// ray depth total rays
lwtoa043_ai_rd_diffuse;			// diffuse ray depth
lwtoa043_ai_rd_refl;				// reflection ray depth
lwtoa043_ai_rd_refr;				// refraction ray depth
lwtoa043_ai_rd_glossy;			// glossy ray depth

// Motion blur parameters
lwtoa043_ai_mb_def;				// enable deformation blur
lwtoa043_ai_mb_duration;			// frame duration
lwtoa043_ai_shutter_type;		// shutter type
lwtoa043_ai_mb_deform_steps;		// deformation blur steps
lwtoa043_ai_mb_apply_cam;		// enable MB for camera
lwtoa043_ai_mb_apply_light;		// enable MB for lights
lwtoa043_ai_mb_apply_obj;		// enable MB for objects
lwtoa043_ai_mb_forceRefresh;		// force full scene refresh for MB

// Depth of field parameters
lwtoa043_ai_dof_aspect;			// DOF aperture aspect ratio
lwtoa043_ai_dof_curvature;		// DOF blades curvature

// Plugin instancing options
lwtoa043_ai_instance_lwclones;	// Flag to instance in arnold LW cloned object
lwtoa043_ai_instance_nulls;		// Render NULLS that begin with "-" as instances

// .ass file options
lwtoa043_ai_render_to_file;		// Activate writting .ass files
lwtoa043_ai_filename;			// Output path and filename of .ass
lwtoa043_ai_compress_file;		// Compress .ass file to .gz
lwtoa043_ai_writenode_options;	// Selective nodes to save in .ass file
lwtoa043_ai_writenode_drivers;
lwtoa043_ai_writenode_geom;
lwtoa043_ai_writenode_cam;
lwtoa043_ai_writenode_lights;
lwtoa043_ai_writenode_shaders;
lwtoa043_ai_ass_binary;			// Save the .ass file in binary encoding.

// Log and debug options
lwtoa043_ai_log_console;			// Open console to show log
lwtoa043_ai_log_write;			// Write the log to a file
lwtoa043_ai_log_filename;		// Log filename
lwtoa043_ai_log_level;			// Log message level
lwtoa043_ai_log_max;				// Max number of lines in log file
lwtoa043_ai_log_ipr_level;		// IPR log level

// Arnold native texture mapping options
lwtoa043_ai_tex_accept_nomipmap;	// Texture system accept no mimpamed images flag
lwtoa043_ai_tex_automipmap;		// Automipmap flag
lwtoa043_ai_tex_magfilter;		// Texture magnification filter
lwtoa043_ai_tex_accept_untiled;	// Accept untiled textures
lwtoa043_ai_tex_autotile;		// Autotile flag
lwtoa043_ai_tex_tile_size;		// Autotile tile size
lwtoa043_ai_tex_cache;			// Enable texture cache
lwtoa043_ai_tex_cache_size;		// Cache size in MB
lwtoa043_ai_tex_maxfiles;		// Maximum open textures while rendering

// Misc. rendering options
lwtoa043_ai_abort_lic_fail;		// Abort render on license fail
lwtoa043_ai_sampling_mult;		// Global sampling multiplier
lwtoa043_ai_light_sampling_mult;	// Global light sampling multiplier
lwtoa043_ai_mult_factor;
lwtoa043_ai_light_mult_factor;

// System AOVs parameters
lwtoa043_ai_sysaovs_enable;		// Flag to enable rendering of system AOVs
lwtoa043_ai_sysaovs_display;		// AOVs transfered to LW preview and render window

lwtoa043_ai_sysaovs_fileoptions_path;
lwtoa043_ai_sysaovs_fileoptions_exr_compress;
lwtoa043_ai_sysaovs_fileoptions_exr_half;
lwtoa043_ai_sysaovs_fileoptions_exr_tiled;
lwtoa043_ai_sysaovs_fileoptions_exr_preserve;
lwtoa043_ai_sysaovs_fileoptions_tif_compress;
lwtoa043_ai_sysaovs_fileoptions_tif_format;
lwtoa043_ai_sysaovs_fileoptions_tif_tiled;
lwtoa043_ai_sysaovs_fileoptions_tif_dither;
lwtoa043_ai_sysaovs_fileoptions_pad1;
lwtoa043_ai_sysaovs_fileoptions_pad2;
lwtoa043_ai_sysaovs_fileoptions_pad3;
lwtoa043_ai_sysaovs_fileoptions_pad4;

// 40 AOV blocks.
lwtoa043_MAX_SYS_AOVS = 40;
lwtoa043_ai_sysaovs_active;
lwtoa043_ai_sysaovs_type;
lwtoa043_ai_sysaovs_suf;
lwtoa043_ai_sysaovs_filter;
lwtoa043_ai_sysaovs_gamma;
lwtoa043_ai_sysaovs_file_format;
lwtoa043_ai_sysaovs_pad1;
lwtoa043_ai_sysaovs_pad2;
lwtoa043_ai_sysaovs_pad3;
lwtoa043_ai_sysaovs_pad4;

// Transparency options
lwtoa043_ai_trans_depth;			// Transparency depth control
lwtoa043_ai_trans_mode;			// Transparency mode
lwtoa043_ai_trans_threshold;		// Transparency threshold

// Point cloud Subsurface Scattering options
lwtoa043_ai_sss_spacing;			// SSS points cloud sample spacing
lwtoa043_ai_sss_distribution;	// SSS points sample distribution
lwtoa043_ai_sss_factor;			// SSS sample factor
lwtoa043_ai_sss_show;			// Flag to show SSS samples in rendering

// Rendering ignore options
lwtoa043_ai_ignore_textures;
lwtoa043_ai_ignore_shaders;
lwtoa043_ai_ignore_atmosphere;
lwtoa043_ai_ignore_lights;
lwtoa043_ai_ignore_shadows;
lwtoa043_ai_ignore_subdivision;
lwtoa043_ai_ignore_displacement;
lwtoa043_ai_ignore_bump;
lwtoa043_ai_ignore_motion_blur;
lwtoa043_ai_ignore_smoothing;
lwtoa043_ai_ignore_sss;
lwtoa043_ai_ignore_direct_lighting;

// Arnold camera options
lwtoa043_ai_cam_type;					// Arnold camera type
lwtoa043_ai_cam_near;					// Camera near plane
lwtoa043_ai_cam_far;						// Camera far plane
lwtoa043_ai_cam_fisheye_crop;			// Autocrop flag for fisheye camera
lwtoa043_ai_cam_ortho_factor;			// Scale factor for ortho camera

// New in version 0.2.1
lwtoa043_ai_mb_apply_psys;				// Enable MB for particle systems
lwtoa043_ai_mb_psys_factor;				// Particle systems MB factor

// New in version 0.2.4
lwtoa043_ai_background_visbility;		// Backgroud ray visibility

// New in version 0.2.5
lwtoa043_ai_log_sn_level;				// Screamernet log level
lwtoa043_ai_info_add;					// Add the information text to render image
lwtoa043_ai_info_txt;						// User text string for information

// New in version 0.2.6
lwtoa043_ai_instance_lw11;				// Enable rendering LW11 native instaces
lwtoa043_ai_sds_max_level;				// Max. Arnold native SDS subdivision level

// New in version 0.2.8
lwtoa043_ai_shading_pass;				// Current shading pass for main render
lwtoa043_shading_pass_names;			// string with shading pass name

// New in version 0.3.0
lwtoa043_ai_multithread_loading;			// Enable arnold scene loading multithread 

// New in version 0.3.1
lwtoa043_ai_aov_composition;				// Enable AOVs composition feature
lwtoa043_ai_ignore_mis;					// Ignore Multiple Importance Sampling switch
lwtoa043_ai_volumetric_type;				// Arnold volumetrics: 
								// 0->physicalSky, 1->LW fog, 2->Arnold fog, 3->volume scattering

// New in version 0.3.2
lwtoa043_ai_cam_exposure;				// Camera exposure
lwtoa043_ai_gamma_light;					// Internal arnold gamma settings
lwtoa043_ai_gamma_shader;
lwtoa043_ai_gamma_texture;
lwtoa043_ai_tex_diffuse_blur;			// Arnold textures Diffuse blur parameter
lwtoa043_ai_tex_glossy_blur;				// Arnold textures Glossy blur parameter

// New in version 0.3.3
lwtoa043_ai_low_light_threshold;			// low_light_threshold parameter

// New in version 0.3.4
lwtoa043_ai_ignore_dof;					// Ignore DOF in rendering switch
lwtoa043_ai_sss_engine;					// Arnold SSS: 0 for old pointcloud engine, 1 for new raytraced BSSRDF engine
lwtoa043_ai_sss_samples;					// raytraced BSSRD samples for raytraced SSS engine

// New in version 0.3.5
lwtoa043_ai_clamp_aovs;					// Clamp sample values in aovs
lwtoa043_ai_nlights_heatmap;				// Render the nlights heatmap to debug lighting
lwtoa043_ai_ignore_procedurals;			// Ignore procedurals in rendering switch
lwtoa043_ai_procedural_path;				// Arnold internal paths strings
lwtoa043_ai_texture_path;
lwtoa043_ai_shader_path;
lwtoa043_ai_log_frame_number;			// Add a frame number to the log file name

// New in version 0.4.1
lwtoa043_ai_ipr_license_skip;			// Skip license search for the IPR window rendering
lwtoa043_ai_texture_max_sharpen;			// Texture max. sharpen parameter
lwtoa043_ai_shader_timing_stats;			// Add more information about shading to the log files

// New in version 0.4.2
lwtoa043_ai_enable_multiple_uvmaps;		// Enable the load of multiple UV maps in the objects
lwtoa043_ai_rendering_mode;				// Set the rendering mode (0->full scene reload, 1->update scene)
lwtoa043_ai_reload_lights;				// In update scene mode, enable this flag to full reload lights
lwtoa043_ai_reload_materials;			// In update scene mode, enable this flag to full reload all materials in the scene

// New in version 0.4.3
lwtoa043_ai_disable_rotational_mb;		// Disable the new rotational motion blur algorithms
lwtoa043_ai_cam_rolling_shutter;		// Camera rolling shutter parameter
