// Kray presets - taken directly from Kray.ls

	scnGen_kray25_photons_presets:value
	{ 	
	    if (value==2) // low preset
	    {
			setvalue(kray25_c_gf,200000);       // Global photons
			setvalue(kray25_c_gfunit,2);       // 1 - Emitted 2 - Received
			setvalue(kray25_c_ppmult,1);       // Power
			setvalue(kray25_c_gmode,2);        // 1 - Photonmap 2 - Lightmap

			setvalue(kray25_c_gmatic,1);       // Autophotons 0 - off 1 - on
			setvalue(kray25_c_gn,400);		// N

			setvalue(kray25_c_glow,0.2);       // Low
			setvalue(kray25_c_ghigh,0.8);      // High
			setvalue(kray25_c_gdyn,4);	// Step (autophotons on)

			setvalue(kray25_c_ppsize,0.5);     // Precache distance
			setvalue(kray25_c_ppblur,1);     // Precache blur

			setvalue(kray25_c_gpstart,1);      // Radius (min)
			setvalue(kray25_c_gpstop,2);       // Max (radius)
			setvalue(kray25_c_gpstep,4);       // Steps (autophotons off)
	    }
	    if (value==3) // medium preset
	    {
			setvalue(kray25_c_gf,500000);     // Global photons
			setvalue(kray25_c_gfunit,2);       // 1 - Emitted 2 - Received
			setvalue(kray25_c_ppmult,1);       // Power
			setvalue(kray25_c_gmode,2);        // 1 - Photonmap 2 - Lightmap

			setvalue(kray25_c_gmatic,1);       // Autophotons 0 - off 1 - on
			setvalue(kray25_c_gn,500);        // N

			setvalue(kray25_c_glow,0.2);       // Low
			setvalue(kray25_c_ghigh,0.8);      // High
			setvalue(kray25_c_gdyn,4);     // Step (autophotons on)

			setvalue(kray25_c_ppsize,0.5);     // Precache distance
			setvalue(kray25_c_ppblur,1);       // Precache blur

			setvalue(kray25_c_gpstart,1);      // Radius (min)
			setvalue(kray25_c_gpstop,2);       // Max (radius)
			setvalue(kray25_c_gpstep,4);       // Steps (autophotons off)
	    }
	    if (value==4) // high preset
	    {
			setvalue(kray25_c_gf,1000000);     // Global photons
			setvalue(kray25_c_gfunit,2);       // 1 - Emitted 2 - Received
			setvalue(kray25_c_ppmult,1);       // Power
			setvalue(kray25_c_gmode,2);        // 1 - Photonmap 2 - Lightmap

			setvalue(kray25_c_gmatic,1);       // Autophotons 0 - off 1 - on
			setvalue(kray25_c_gn,1000);        // N

			setvalue(kray25_c_glow,0.2);       // Low
			setvalue(kray25_c_ghigh,0.8);      // High
			setvalue(kray25_c_gdyn,4);     // Step (autophotons on)

			setvalue(kray25_c_ppsize,0.5);     // Precache distance
			setvalue(kray25_c_ppblur,0.5);       // Precache blur

			setvalue(kray25_c_gpstart,1);      // Radius (min)
			setvalue(kray25_c_gpstop,2);       // Max (radius)
			setvalue(kray25_c_gpstep,4);       // Steps (autophotons off)
	    }
	    if (value==5) // Brute Force
	    {
			setvalue(kray25_c_gph_preset,4);
	    }
	    if (value==6) // Interior
	    {
			setvalue(kray25_c_gir,0.4);     // Gi resolution
			setvalue(kray25_c_girauto,0);     // Auto GI resolution
	    }
	    if (value==7) // Exterior
	    {
			setvalue(kray25_c_gir,1);     // Gi resolution
			setvalue(kray25_c_girauto,0);     // Auto GI resolution
	    }
	}

	scnGen_kray25_caustics_presets:value
	{
	    if (value==2){  // low preset
			setvalue(kray25_c_ppcaustics,0);   // Add to lightmap 0 - off 1 - on
			setvalue(kray25_c_cf,500000);      // Caustics photons
			setvalue(kray25_c_cfunit,2);       // 1 - Emitted 2 - Received
			setvalue(kray25_c_cmult,1);        // Power

			setvalue(kray25_c_cmatic,1);       // Autophotons 0 - off 1 - on
			setvalue(kray25_c_cn,400);     // N
			setvalue(kray25_c_clow,0.1);       // Low
			setvalue(kray25_c_chigh,0.9);      // High
			setvalue(kray25_c_cdyn,10);        // Steps (autophotons on)

			setvalue(kray25_c_cpstart,0.25);   // Radius (min)
			setvalue(kray25_c_cpstop,1);       // Max (radius)
			setvalue(kray25_c_cpstep,4);       // Steps (autophotons off)
	    }
	    if (value==3){ // medium preset
			setvalue(kray25_c_ppcaustics,0);   // Add to lightmap 0 - off 1 - on
			setvalue(kray25_c_cf,1000000);      // Caustics photons
			setvalue(kray25_c_cfunit,2);       // 1 - Emitted 2 - Received
			setvalue(kray25_c_cmult,1);        // Power

			setvalue(kray25_c_cmatic,1);       // Autophotons 0 - off 1 - on
			setvalue(kray25_c_cn,500);	    // N
			setvalue(kray25_c_clow,0.1);       // Low
			setvalue(kray25_c_chigh,0.9);      // High
			setvalue(kray25_c_cdyn,10);        // Steps (autophotons on)

			setvalue(kray25_c_cpstart,0.25);   // Radius (min)
			setvalue(kray25_c_cpstop,1);       // Max (radius)
			setvalue(kray25_c_cpstep,4);       // Steps (autophotons off)
	    }
	    if (value==4){ // high preset
			setvalue(kray25_c_ppcaustics,0);   // Add to lightmap 0 - off 1 - on
			setvalue(kray25_c_cf,5000000);      // Caustics photons
			setvalue(kray25_c_cfunit,2);       // 1 - Emitted 2 - Received
			setvalue(kray25_c_cmult,1);        // Power

			setvalue(kray25_c_cmatic,1);       // Autophotons 0 - off 1 - on
			setvalue(kray25_c_cn,800);         // N
			setvalue(kray25_c_clow,0.1);       // Low
			setvalue(kray25_c_chigh,0.9);      // High
			setvalue(kray25_c_cdyn,10);        // Steps (autophotons on)

			setvalue(kray25_c_cpstart,0.25);   // Radius (min)
			setvalue(kray25_c_cpstop,1);       // Max (radius)
			setvalue(kray25_c_cpstep,4);       // Steps (autophotons off)
	    }
	    if (value==5){		    // Brute Force
			setvalue(kray25_c_cph_preset,4);
	    }
	}
	scnGen_kray25_fg_presets:value
	{
	    if (value==2){  // low preset
			setvalue(kray25_c_fgth,0.0001);      // FG threshold
			setvalue(kray25_c_fgrmin,100);     // FG Min rays
			setvalue(kray25_c_fgrmax,600);     // FG Max rays
			setvalue(kray25_c_prep,1);       // Prerender
			setvalue(kray25_c_prestep,1);		// Prerender steps
			setvalue(kray25_c_preSplDet,0.05);	// Prerender splotch detection
			setvalue(kray25_c_gradNeighbour,0.05);	// Gradients neighbour sensitivity
			setvalue(kray25_c_fga,0.1);        // Spatial tolerance
			setvalue(kray25_c_fgb,30);     // Angle tolerance
			setvalue(kray25_c_fgmin,0.1);      // Distance Min
			setvalue(kray25_c_fgmax,30);       // Distance Max
			setvalue(kray25_c_fgscale,0);      // B/D
			setvalue(kray25_c_fgblur,4);      // Blur
			setvalue(kray25_c_fgshows,1);      // Show samples (1 - Off 2 - Corners 3 - All)
			setvalue(kray25_c_fgsclr,<1,0,1>); // Color
			setvalue(kray25_c_fgreflections,0);
			setvalue(kray25_c_fgrefractions,1);
	    }
	    if (value==3){ // medium preset
			setvalue(kray25_c_fgth,0.0001);     // FG threshold
			setvalue(kray25_c_fgrmin,100);     // FG Min rays
			setvalue(kray25_c_fgrmax,600);    // FG Max rays
			setvalue(kray25_c_prep,1);       // Prerender
			setvalue(kray25_c_prestep,2);		// Prerender steps
			setvalue(kray25_c_preSplDet,0.05);	// Prerender splotch detection
			setvalue(kray25_c_gradNeighbour,0.05);	// Gradients neighbour sensitivity
			setvalue(kray25_c_fga,0.1);        // Spatial tolerance
			setvalue(kray25_c_fgb,25);     // Angle tolerance
			setvalue(kray25_c_fgmin,0.1);      // Distance Min
			setvalue(kray25_c_fgmax,30);        // Distance Max
			setvalue(kray25_c_fgscale,0);      // B/D
			setvalue(kray25_c_fgblur,1);      // Blur
			setvalue(kray25_c_fgshows,1);      // Show samples (1 - Off 2 - Corners 3 - All)
			setvalue(kray25_c_fgsclr,<1,0,1>); // Color
			setvalue(kray25_c_fgreflections,0);
			setvalue(kray25_c_fgrefractions,1);
	    }
	    if (value==4){ // high preset
			setvalue(kray25_c_fgth,0.0001);     // FG threshold
			setvalue(kray25_c_fgrmin,200);      // FG Min rays
			setvalue(kray25_c_fgrmax,800);    // FG Max rays
			setvalue(kray25_c_prep,1);       // Prerender
			setvalue(kray25_c_prestep,3);		// Prerender steps
			setvalue(kray25_c_preSplDet,0.02);	// Prerender splotch detection
			setvalue(kray25_c_gradNeighbour,0.02);	// Gradients neighbour sensitivity
			setvalue(kray25_c_fga,0.05);        // Spatial tolerance
			setvalue(kray25_c_fgb,15);     // Angle tolerance
			setvalue(kray25_c_fgmin,0.1);     // Distance Min
			setvalue(kray25_c_fgmax,30);        // Distance Max
			setvalue(kray25_c_fgscale,1);    // B/D
			setvalue(kray25_c_fgblur,2);       // Blur
			setvalue(kray25_c_fgshows,1);      // Show samples (1 - Off 2 - Corners 3 - All)
			setvalue(kray25_c_fgsclr,<1,0,1>); // Color
			setvalue(kray25_c_fgreflections,0);
			setvalue(kray25_c_fgrefractions,1);
	    }
	    if (value==5){			// Brute Force
			setvalue(kray25_c_fgth,0.0001);     // FG threshold
			setvalue(kray25_c_fgrmin,100);     // FG Min rays
			setvalue(kray25_c_fgrmax,800);    // FG Max rays

			setvalue(kray25_c_fgreflections,0);
			setvalue(kray25_c_fgrefractions,1);
	    }
	    if (value==6){ // Interior
			setvalue(kray25_c_fga,0.07);        // Spatial tolerance
	    }
	    if (value==7){ // Exterior
			setvalue(kray25_c_fga,0.1);        // Spatial tolerance
	    }
	}
	scnGen_kray25_aa_presets:value
	{
		if (value==1){
			setvalue(kray25_c_aafscreen,getvalue(c_aafscreen));
		}
		if (value==2){  // low preset
			setvalue(kray25_c_edgeabs,0.2);    // Edge absolute
			setvalue(kray25_c_edgerel,0.2);    // Edge relative
			setvalue(kray25_c_edgenorm,0.1);   // Normal
			setvalue(kray25_c_edgezbuf,0.1);   // Z
			setvalue(kray25_c_edgeup,0);       // Upsample
			setvalue(kray25_c_edgethick,1);    // Thickness
			setvalue(kray25_c_edgeover,1);     // Overburn

			setvalue(kray25_c_aafscreen,0);    // FSAA 0 - off 1 - on
			
			setvalue(kray25_c_aargsmpl,2);     // Grid size (Grid)
			setvalue(kray25_c_aagridrotate,1); // Grid rotare (Grid)
			
			setvalue(kray25_c_cstocvar,0.0001);  // Threshold (Quasi-random)
			setvalue(kray25_c_cstocmin,10);    // Min rays (Quasi-random)
			setvalue(kray25_c_cstocmax,50);    // Max rays (Quasi-random)
			setvalue(kray25_c_cmbsubframes,2);	// MB subframes
			
			setvalue(kray25_c_aarandsmpl,16);  // Rays (Random)

			setvalue(kray25_c_pxlfltr,1);      // Pixel filter type (1 - Box 2 - Cone 3 - Cubic 4 - Quadric 5 - Lanczos 6 - Mitchell 7 - Spline 8 - Catmull)
			setvalue(kray25_c_pxlparam,0.7);   // Pixel filter param
			
			setvalue(kray25_c_underf,1);       // Undersample (1 - None 2 - 2 3 - 4 4 - 8 ....)
			setvalue(kray25_c_undert,0.01);	// Undersampe threshold

			setvalue(kray25_c_aatype,2);       // AA type 0 - None 1 - Grid 2 - Quasi-random 3 - Random
	    }
	    if (value==3){	//Medium
			setvalue(kray25_c_edgeabs,0.1);    // Edge absolute
			setvalue(kray25_c_edgerel,0.1);	// Edge relative
			setvalue(kray25_c_edgenorm,0.1);	// Normal
			setvalue(kray25_c_edgezbuf,0.1);	// Z
			setvalue(kray25_c_edgeup,0);       // Upsample
			setvalue(kray25_c_edgethick,1);    // Thickness
			setvalue(kray25_c_edgeover,1);     // Overburn

			setvalue(kray25_c_aafscreen,1);    // FSAA 0 - off 1 - on
			
			setvalue(kray25_c_aargsmpl,3);     // Grid size (Grid)
			setvalue(kray25_c_aagridrotate,1); // Grid rotare (Grid)
			
			setvalue(kray25_c_cstocvar,0.0001);  // Threshold (Quasi-random)
			setvalue(kray25_c_cstocmin,16);    // Min rays (Quasi-random)
			setvalue(kray25_c_cstocmax,64);    // Max rays (Quasi-random)
			setvalue(kray25_c_cmbsubframes,2);	// MB subframes
			
			setvalue(kray25_c_aarandsmpl,32);  // Rays (Random)
			
			setvalue(kray25_c_pxlfltr,1);      // Pixel filter type (1 - Box 2 - Cone 3 - Cubic 4 - Quadric 5 - Lanczos 6 - Mitchell 7 - Spline 8 - Catmull)
			setvalue(kray25_c_pxlparam,0.5);   // Pixel filter param
			
			setvalue(kray25_c_underf,1);       // Undersample (1 - None 2 - 2 3 - 4 4 - 8 ....)
			setvalue(kray25_c_undert,0.01);    // Undersampe threshold

			setvalue(kray25_c_aatype,3);       // AA type 1 - None 2 - Grid 3 - Quasi-random 4 - Random
	    }
	    if (value==4){ // high preset
			setvalue(kray25_c_edgeabs,0.1);    // Edge absolute
			setvalue(kray25_c_edgerel,0.1);        // Edge relative
			setvalue(kray25_c_edgenorm,0.05);      // Normal
			setvalue(kray25_c_edgezbuf,0.05);      // Z
			setvalue(kray25_c_edgeup,0);       // Upsample
			setvalue(kray25_c_edgethick,1);    // Thickness
			setvalue(kray25_c_edgeover,1);     // Overburn

			setvalue(kray25_c_aafscreen,1);    // FSAA 0 - off 1 - on
			
			setvalue(kray25_c_aargsmpl,4);     // Grid size (Grid)
			setvalue(kray25_c_aagridrotate,1); // Grid rotare (Grid)
			
			setvalue(kray25_c_cstocvar,0.0001); // Threshold (Quasi-random)
			setvalue(kray25_c_cstocmin,16);    // Min rays (Quasi-random)
			setvalue(kray25_c_cstocmax,128);   // Max rays (Quasi-random)
			setvalue(kray25_c_cmbsubframes,2);	// MB subframes
			
			setvalue(kray25_c_aarandsmpl,64); // Rays (Random)
			
			setvalue(kray25_c_pxlfltr,1);      // Pixel filter type (1 - Box 2 - Cone 3 - Cubic 4 - Quadric 5 - Lanczos 6 - Mitchell 7 - Spline 8 - Catmull)
			setvalue(kray25_c_pxlparam,0.5);   // Pixel filter param
			
			setvalue(kray25_c_underf,1);       // Undersample (1 - None 2 - 2 3 - 4 4 - 8 ....)
			setvalue(kray25_c_undert,0.01);    // Undersampe threshold

			setvalue(kray25_c_aatype,2);       // AA type 1 - None 2 - Grid 3 - Quasi-random 4 - Random
	    }
	    if (value==5){		// Brute Force
			setvalue(kray25_c_edgeabs,0.1);    // Edge absolute
			setvalue(kray25_c_edgerel,0.1);	// Edge relative
			setvalue(kray25_c_edgenorm,0.1);	// Normal
			setvalue(kray25_c_edgezbuf,0.1);	// Z
			setvalue(kray25_c_edgeup,0);       // Upsample
			setvalue(kray25_c_edgethick,1);    // Thickness
			setvalue(kray25_c_edgeover,1);     // Overburn

			setvalue(kray25_c_aafscreen,1);    // FSAA 0 - off 1 - on
			
			setvalue(kray25_c_aargsmpl,5);     // Grid size (Grid)
			setvalue(kray25_c_aagridrotate,1); // Grid rotare (Grid)
			
			setvalue(kray25_c_cstocvar,0.01);  // Threshold (Quasi-random)
			setvalue(kray25_c_cstocmin,10);    // Min rays (Quasi-random)
			setvalue(kray25_c_cstocmax,50);    // Max rays (Quasi-random)
			setvalue(kray25_c_cmbsubframes,2);	// MB subframes
			
			setvalue(kray25_c_aarandsmpl,64);  // Rays (Random)
			
			setvalue(kray25_c_pxlfltr,1);      // Pixel filter type (1 - Box 2 - Cone 3 - Cubic 4 - Quadric 5 - Lanczos 6 - Mitchell 7 - Spline 8 - Catmull)
			setvalue(kray25_c_pxlparam,0.5);   // Pixel filter param
			
			setvalue(kray25_c_underf,1);       // Undersample (1 - None 2 - 2 3 - 4 4 - 8 ....)
			setvalue(kray25_c_undert,0.01);    // Undersampe threshold

			setvalue(kray25_c_aatype,2);       // AA type 1 - None 2 - Grid 3 - Quasi-random 4 - Random
	    }
	}
	scnGen_kray25_quality_presets:value
	{
	    if (value==2){  // low preset
			setvalue(kray25_c_planth,0.002);   // Area threshold
			setvalue(kray25_c_planrmin,1);     // Area min
			setvalue(kray25_c_planrmax,4);     // Area max
			setvalue(kray25_c_llinth,0.002);   // Linear threshold
			setvalue(kray25_c_llinrmin,1);     // Linear min
			setvalue(kray25_c_llinrmax,4);     // Linear max
			setvalue(kray25_c_lumith,0.01);    // Luminosity threshold
			setvalue(kray25_c_lumirmin,10);    // Luminosity min
			setvalue(kray25_c_lumirmax,60);    // Luminosity max
			setvalue(kray25_c_refth,0.001);    // Blurring threshold
			setvalue(kray25_c_refrmin,100);    // Blurring min
			setvalue(kray25_c_refrmax,100);    // Blurring max
			setvalue(kray25_c_refacth,0.01);  // Blurring accuracy
			setvalue(kray25_c_refmodel,0);   // Trace direct reflections
			setvalue(kray25_c_octdepth,3);    // Octree 
	    }
	    if (value==3){ // medium preset
			setvalue(kray25_c_planth,0.002);   // Area threshold
			setvalue(kray25_c_planrmin,2);     // Area min
			setvalue(kray25_c_planrmax,4);     // Area max
			setvalue(kray25_c_llinth,0.002);   // Linear threshold
			setvalue(kray25_c_llinrmin,2);     // Linear min
			setvalue(kray25_c_llinrmax,4);     // Linear max
			setvalue(kray25_c_lumith,0.01);    // Luminosity threshold
			setvalue(kray25_c_lumirmin,10);    // Luminosity min
			setvalue(kray25_c_lumirmax,100);    // Luminosity max
			setvalue(kray25_c_refth,0.0001);    // Blurring threshold
			setvalue(kray25_c_refrmin,100);    // Blurring min
			setvalue(kray25_c_refrmax,500);   // Blurring max
			setvalue(kray25_c_refacth,0.01);    // Blurring accuracy
			setvalue(kray25_c_refmodel,0);   // Trace direct reflections
			setvalue(kray25_c_octdepth,3);    // Octree 
	    }
	    if (value==4){ // high preset
			setvalue(kray25_c_planth,0.001);   // Area threshold
			setvalue(kray25_c_planrmin,2);     // Area min
			setvalue(kray25_c_planrmax,6);     // Area max
			setvalue(kray25_c_llinth,0.001);   // Linear threshold
			setvalue(kray25_c_llinrmin,2);     // Linear min
			setvalue(kray25_c_llinrmax,6);     // Linear max
			setvalue(kray25_c_lumith,0.01);    // Luminosity threshold
			setvalue(kray25_c_lumirmin,50);    // Luminosity min
			setvalue(kray25_c_lumirmax,150);   // Luminosity max
			setvalue(kray25_c_refth,0.0001);   // Blurring threshold
			setvalue(kray25_c_refrmin,200);    // Blurring min
			setvalue(kray25_c_refrmax,600);   // Blurring max
			setvalue(kray25_c_refacth,0.1);    // Blurring accuracy
			setvalue(kray25_c_refmodel,0);   // Trace direct reflections
			setvalue(kray25_c_octdepth,3);    // Octree 
	    }
	    if (value==5){		   // Brute Force
			setvalue(kray25_c_planth,0.002);   // Area threshold
			setvalue(kray25_c_planrmin,2);     // Area min
			setvalue(kray25_c_planrmax,4);     // Area max
			setvalue(kray25_c_llinth,0.002);   // Linear threshold
			setvalue(kray25_c_llinrmin,2);     // Linear min
			setvalue(kray25_c_llinrmax,4);     // Linear max
			setvalue(kray25_c_lumith,0.01);    // Luminosity threshold
			setvalue(kray25_c_lumirmin,50);    // Luminosity min
			setvalue(kray25_c_lumirmax,200);    // Luminosity max
			setvalue(kray25_c_refth,0.0001);    // Blurring threshold
			setvalue(kray25_c_refrmin,100);    // Blurring min
			setvalue(kray25_c_refrmax,500);   // Blurring max
			setvalue(kray25_c_refacth,0.01);    // Blurring accuracy
			setvalue(kray25_c_refmodel,0);   // Trace direct reflections
			setvalue(kray25_c_octdepth,3);    // Octree depth
	    }
	}
	scnGen_kray25_general_presets:value
	{
	    if (value!=1 && value<6){
			value=value+(-1);
			setvalue(kray25_c_gph_preset,value);
			setvalue(kray25_c_cph_preset,value);
			setvalue(kray25_c_fg_preset,value);
			setvalue(kray25_c_aa_preset,value);
			setvalue(kray25_c_quality_preset,value);
			setvalue(kray25_c_general_preset,1);
			setvalue(kray25_c_giirrgrad,1); // Cached irradiance
	    }
	    if (value==6){ // Uncached
			setvalue(kray25_c_gi,3); // Photon mapping
			setvalue(kray25_c_fg_preset,5);
			setvalue(kray25_c_shgi,1); // shared gi 
			setvalue(kray25_c_giirrgrad,0);  // Uncached irradiance
		}
	    if (value==7){ // static GI
			setvalue(kray25_c_gi,3); // Photon mapping

			setvalue(kray25_c_shgi,3); // gi mode: shared
			setvalue(kray25_c_ginew,3); // gi file mode
	    }
	    if (value==8){ // animated GI
			setvalue(kray25_c_gi,3); // Photon mapping

			setvalue(kray25_c_shgi,2); // gi mode: TI

			setvalue(kray25_c_tiframes,5); 
			setvalue(kray25_c_tiextinction,0.3); 
	    }
	}
