/*

 Kray Render Options Script
 Main code, Grzegorz Tanski
 Additional code, Jure Judez
 User Interface Modifcation, Matt Gorner
 
 Modification allowed.

*/

@asyncspawn 
@warnings 
@version 2.4
@script master
@save relative
@name Kray
@define KRAY_COMRING "kray_hub_comring"

// global values go here
	version=1223;
	kverstring="2.5";
	demo_mode=0;
	exe_path="";
	exe_autoconfirm=0;
	
	// exe_path can point to Kray.exe or Kray.app in such case Kray.ls will spawn separate render process outside LightWave examples:
	// exe_path="D:\\KrayWin\\Kray.exe";
	// exe_path="/Users/gtanski/Sources/KrayCocoa/build/Release/Kray.app";

//header/tailer commands
	header_list=@"Add ...",
				"previewsize 1280,800",
				"logfile 'kray_log.txt'",
				"showphstats",
				"octstats",
				"renderinfosize 0.5,10",
				"usemultipass 1"@;
	tailer_list=@"Add ...",
				"irradianceblurgamma 0.3",
				"lwo2airpolys 1,0",
				"octree <depth>,<object per octree leaf>",
				"postprocess desaturate, 0.1",
				"postprocess gamma,1.4",
				"postprocess gblur,15,0.4",
				"postprocess mult,(3,3,3)",
				"postprocess ca,0.1,1,2,100",
				"postprocess erode,5;",
				"recurse 100",
				"surface_flags 0+1+2",
				"cam_singleside 1"@;
	image_formats=@	"HDR High Dynamic Range (Radiance)",
					"JPG Joint Photographic experts Group",
					"PNG Portable Network Graphics",
					"PNG Portable Network Graphics +alpha",
					"TIF Tagged Image file Format",
					"TIF Tagged Image file Format +alpha",
					"TGA Truevision Graphics Adapter file",
					"TGA Truevision Graphics Adapter file +alpha",
					"BMP BitMaP",
					"BMP BitMaP +alpha"@;
	renderinfo_list=@"Add ...",
					"%kray%",
					"%ver%",
					"%build%",
					"%arch%",
					"%time%",
					"%ptime%",
					"%days%",
					"%hours%",
					"%mins%",
					"%secs%",
					"%centisecs%",
					"%sectime%",
					"%now%",
					"%file%",
					"%fileformat%",
					"%width%",
					"%height%",
					"%fgraysmin%",
					"%fgraysmax%",
					"%threads%",
					"%frame%"@;

// config
	modal=0;
	reminders=1;

	loadmode=0;     // settings loading
	maxlinelength=30;
	dof_active=0;
	photon_map_model=20100;

	// scene settings
	v_single=false;
	tab0;
	active_tab=1;

// variables
	//general tab
		c_general_preset;
		c_gi;
		v_gi=1;				// Diffuse model 2=photon estimate
		c_gicaustics;
		v_gicaustics=false; // Photon mapping caustics
		c_giirrgrad;
		v_giirrgrad=true;	// Cached irradiance
		c_gipmmode;
		v_gipmmode = 3;		// Photons estimate 2=global unfiltered
		c_girtdirect;
		v_girtdirect=0;		// Precomputed filtered raytrace direct 1=on

		c_lg;
		v_lg=1;				// Luminosity model 1=indirect 2=direct 3=auto
		c_autolumi;
		v_autolumi=1;		// Level 1=100%

		c_pl;
		v_pl=1;				// Area lights 1=Compute sparately 2=Compute with luminosity
		
		c_output_On;
		v_output_On=0;
		c_outname;
		v_outname="kray_render.png";	// File name
		c_outfmt;
		v_outfmt=3;						// Format 1=HDR,JPG,PNG,PNGA,TIF,TIFA,TGA,TGAA,BMP,10=BMPA

		c_limitdr;
		v_limitdr=1;	//LimitDR

		c_shgi;
		v_shgi=1;						// shared gi 1=independant

		c_resetoct;
		v_resetoct=0;	//Allow animation

		c_tiphotons;
		v_tiphotons=1; 

		c_tifg;
		v_tifg=1;
		c_tiframes;
		v_tiframes=1;
		c_tiextinction;
		v_tiextinction=0;
		v_render0=0;
		c_render0;

		c_tmo;
		v_tmo=2;		// Tone mapping mode 1=linear 2=gamma 3=exponential
		c_tmhsv;
		v_tmhsv=0;		// HSV 0=off 1=on
		c_outparam;
		v_outparam=1;   // Parameter
		c_outexp;
		v_outexp=1;     // Exposure

		c_giload;
		v_giload="kraydata.gi";	// gi file name
		c_ginew;
		v_ginew=2;		// shared gi 2=saved

		c_prep;
		v_prep=0;		// Prerender
		c_prestep;		// Prerender steps
		v_prestep=1;
		c_preSplDet;	// Prerender splotch detection
		v_preSplDet=0.01;
		c_gradNeighbour;	// Gradients neighbour sensitivity
		v_gradNeighbour=0.1;

		c_pxlordr;
		v_pxlordr=1;	// Pixel order
		c_underf;
		v_underf=1;		// Undersample 1=none
		c_undert;
		v_undert=0;  // Undersample threshold

		v_areavis=2;	// area light visibility 1=visible
		c_areavis;
		v_areaside=0;	// area light sideness 1=double sided
		c_areaside;
	// photons tab
		c_cph_preset;
		v_cph_preset=2;

		c_gph_preset;
		v_gph_preset=2;

		c_girauto;
		v_girauto=1;	// Use global autophotons 1=on

		c_showphotons;
		v_showphotons=0;

		c_cmatic;
		v_cmatic=1;
		c_cf;
		v_cf=0;
		c_cfunit;
		v_cfunit=1;
		c_gf;
		v_gf=0;
		c_gmode;
		v_gmode=1;
		c_gfunit;
		v_gfunit=1;
		c_gir;
		v_gir=1;		// GI resolution

		c_clow;
		v_clow=0;
		c_chigh;
		v_chigh=0;
		c_cdyn;
		v_cdyn=0;
		c_cpstart;
		v_cpstart=0;
		c_cpstop;
		v_cpstop=0;
		c_cpstep;
		v_cpstep=0;
		c_cn;
		v_cn=0;
	// caustics autophotons
		c_gmatic;
		v_gmatic=0;
		c_gpstart;
		v_gpstart=1;
		c_gpstop;
		v_gpstop=0;
		c_gpstep;
		v_gpstep=0;
		c_gn;
		v_gn=0;

		c_glow;
		v_glow=0.4;
		c_ghigh;
		v_ghigh=0.8;
		c_gdyn;
		v_gdyn=3;

		c_ppsize;
		v_ppsize=0.5;	// precache distance
		c_ppblur;
		v_ppblur=0;
		c_ppmult;
		v_ppmult=1;		// photons power
		c_cmult;
		v_cmult=1;		// caustics power
		c_ppcaustics;
		v_ppcaustics=1; // ligtmap caustics 0=off
	// FG tab
		c_fg_preset;
		v_fg_preset=2;

		c_fgth;
		v_fgth=0;
		c_fgrmin;
		v_fgrmin=0;
		c_fgrmax;
		v_fgrmax=0;
		c_fga;
		v_fga=0;
		c_fgb;
		v_fgb=0;

		c_gir_copy;
		c_girauto_copy;
		v_fgmin=0;
		c_fgmin;
		v_fgmax=0;
		c_fgmax;
		v_fgscale=0;
		c_fgscale;
		v_fgblur=0;
		c_fgblur;
		v_fgshows=1;
		c_fgshows;
		v_fgsclr=<255,0,255>;
		c_fgsclr;

		v_fgreflections=1;
		c_fgreflections;
		v_fgrefractions=1;
		c_fgrefractions;

		v_cornerdist=0.5;
		c_cornerdist;
		v_cornerpaths=0;
		c_cornerpaths;
	// quality tab
		c_quality_preset;
		v_quality_preset=2;

		v_planth=0;
		c_planth;
		v_planrmin=0;
		c_planrmin;
		v_planrmax=0;
		c_planrmax;

		v_llinth=0;
		c_llinth;
		v_llinrmin=0;
		c_llinrmin;
		v_llinrmax=0;
		c_llinrmax;

		v_lumith=0;
		c_lumith;
		v_lumirmin=0;
		c_lumirmin;
		v_lumirmax=0;
		c_lumirmax;

		v_camobject=0;
		c_camobject;
		v_camuvname="";
		c_camuvname;
		
		c_eyesep;
		v_eyesep=0.01;
		c_stereoimages;
		v_stereoimages=3;
		
		c_errode;
		v_errode=4;
		
		v_cptype=1;
		c_cptype;

		v_lenspict="";
		c_lenspict;
		v_dofobj=1;
		c_dofobj;
		v_cstocvar=0;
		c_cstocvar;
		v_cstocmin=0;
		c_cstocmin;
		v_cstocmax=0;
		c_cstocmax;
		v_cmbsubframes=1;
		c_cmbsubframes;

	// Sampling tab
		c_aa_preset;
		v_aa_preset=2;

		c_aatype;
		v_aatype=1;
		c_aafscreen;
		v_aafscreen=1;

		c_aarandsmpl;
		v_aarandsmpl=v_cstocmin;

		c_aargsmpl;
		v_aargsmpl=3;
		c_aagridrotate;
		v_aagridrotate=0;

		c_refth;
		v_refth=0;
		c_refrmin;
		v_refrmin=0;
		c_refrmax;
		v_refrmax=0;
		c_refacth;
		v_refacth=1;
		c_refmodel;
		v_refmodel=0;

		c_conetoarea;
		v_conetoarea=0;

		c_octdepth;
		v_octdepth=3;

		c_prescript;
		v_prescript="";
		c_postscript;
		v_postscript="";
		// edgedetector
			c_edgeabs;
			v_edgeabs=0.1;
			c_edgerel;
			v_edgerel=0;
			c_edgenorm;
			v_edgenorm=0;
			c_edgezbuf;
			v_edgezbuf=0;
			c_edgeup;
			v_edgeup=1;
			c_edgethick;
			v_edgethick=1;
			c_edgeover;
			v_edgeover=1;
			// pixel filter
				c_pxlfltr;
				v_pxlfltr=1;
				c_pxlparam;
				v_pxlparam=0.5;

				c_headeradd;
				c_taileradd;

				create_flag=0;
				guisetup_flag=0;

	// Plugin Active Status Variables for Comring Communication
		c_disable_physky;
		v_disable_physky = false;
		c_disable_quicklwf;
		v_disable_quicklwf = false;
		c_disable_tonemapblend;
		v_disable_tonemapblend = false;
		c_disable_override;
		v_disable_override = false;
		c_disable_buffers;
		v_disable_buffers = false;
		c_disable_instances;
		v_disable_instances = true;
	
	//Misc tab
	c_LogOn;
	v_LogOn=0;
	c_Logfile;
	v_Logfile="kraylog.txt";
	c_Debug;
	v_Debug=0;
	
	c_InfoOn;
	v_InfoOn=0;
	c_InfoText;
	v_InfoText="%kray% %ver% render time: %time% | %width% x %height%";	
	c_RenderIinfoAdd;
	
	c_IncludeOn;
	v_IncludeOn=0;
	c_IncludeFile;
	v_IncludeFile="";
	
	c_FullPrev;
	v_FullPrev=0;
	
	c_Finishclose;
	v_Finishclose=0;
	
	c_UBRAGI;
	v_UBRAGI=0;
	
	c_outputtolw;
	v_outputtolw=0;
	
	//Preset lists
		presets_list=@"Custom","Low","Medium","High","Uncached"@;
		presets_list2=@"Custom","Low","Medium","High","Uncached","Interior", "Exterior"@;

		general_presets_list=@"Select...","Custom","Low","Medium","High","Uncached","Static GI", "Animated GI"@;

	lsver{
		v=lscriptVersion();
		
		return v[2]*100+v[3]*10+v[4];
	}
	lscomringactive{
		return lsver()>270;
	}
// master functions
	create
	{
	    // one-time initialization takes place here
	    create_flag=1;
		guisetup_flag=0;
		
	    // Set up comring communication
	    if (lscomringactive()){
			comringattach(KRAY_COMRING,"process_comring_message");
		}
	}

	destroy
	{
	    // take care of final clean-up activities here

	    // Remove comring communication
	    if (lscomringactive()){
			comringdetach(KRAY_COMRING);
		}
	}

	flags{
	    // indicates the type of the Master script.  it can
	    // be either SCENE or LAYOUT.  SCENE scripts will be
	    // removed whenever the current scene is cleared or
	    // replaced.  LAYOUT scripts persist until manually
	    // removed.

	    return(SCENE);
	}

	process: event, command{
	    // called for each event that occurs within the filter
	    // you specified in flags()

	    if (!modal && reqisopen() && !loadmode){
			get_values();

			if (exe_path!="" && command){
				len=size(command);

				if (len>=21){
					cmd=strlower(strleft(command,21));
					if (cmd==      "generic_kray_frame_ex"){	// ex, not exe is ok
						rendersingle();
					}else if (cmd=="generic_kray_anim_exe"){
						rendersequence();
					}
				}
			}
	    }
	}
	
	safe_warn: text{
		if (runningUnder() != SCREAMERNET){
			warn(text);
		}
	}

	load: what,io{
	    if(what == SCENEMODE){
			io.read();  // Kray{
			create_flag=0;
			load_settings_general(io);
			load_settings_accuracy(io);
	    }
	}

	save: what,io{
	    if(what == SCENEMODE){
			io.writeln("Kray{");
			save_general(io);
			save_accuracy(io);
			if (!create_flag){
				save_krayscript_file(io,"");
			}
			io.writeln("}");
	    }
	}

	photons_presets:value{
	 // low preset
	    if (value==2){ 
			setvalue(c_gf,200000);       // Global photons
			setvalue(c_gfunit,2);       // 1 - Emitted 2 - Received
			setvalue(c_ppmult,1);       // Power
			setvalue(c_gmode,2);        // 1 - Photonmap 2 - Lightmap

			setvalue(c_gmatic,1);       // Autophotons 0 - off 1 - on
			setvalue(c_gn,400);		// N

			setvalue(c_glow,0.2);       // Low
			setvalue(c_ghigh,0.8);      // High
			setvalue(c_gdyn,4);	// Step (autophotons on)

			setvalue(c_ppsize,0.5);     // Precache distance
			setvalue(c_ppblur,1);     // Precache blur

			setvalue(c_gpstart,1);      // Radius (min)
			setvalue(c_gpstop,2);       // Max (radius)
			setvalue(c_gpstep,4);       // Steps (autophotons off)
	    }
	    if (value==3){ // medium preset
			setvalue(c_gf,500000);     // Global photons
			setvalue(c_gfunit,2);       // 1 - Emitted 2 - Received
			setvalue(c_ppmult,1);       // Power
			setvalue(c_gmode,2);        // 1 - Photonmap 2 - Lightmap

			setvalue(c_gmatic,1);       // Autophotons 0 - off 1 - on
			setvalue(c_gn,500);        // N

			setvalue(c_glow,0.2);       // Low
			setvalue(c_ghigh,0.8);      // High
			setvalue(c_gdyn,4);     // Step (autophotons on)

			setvalue(c_ppsize,0.5);     // Precache distance
			setvalue(c_ppblur,1);       // Precache blur

			setvalue(c_gpstart,1);      // Radius (min)
			setvalue(c_gpstop,2);       // Max (radius)
			setvalue(c_gpstep,4);       // Steps (autophotons off)
	    }
	    if (value==4){ // high preset
			setvalue(c_gf,1000000);     // Global photons
			setvalue(c_gfunit,2);       // 1 - Emitted 2 - Received
			setvalue(c_ppmult,1);       // Power
			setvalue(c_gmode,2);        // 1 - Photonmap 2 - Lightmap

			setvalue(c_gmatic,1);       // Autophotons 0 - off 1 - on
			setvalue(c_gn,1000);        // N

			setvalue(c_glow,0.2);       // Low
			setvalue(c_ghigh,0.8);      // High
			setvalue(c_gdyn,4);     // Step (autophotons on)

			setvalue(c_ppsize,0.5);     // Precache distance
			setvalue(c_ppblur,0.5);       // Precache blur

			setvalue(c_gpstart,1);      // Radius (min)
			setvalue(c_gpstop,2);       // Max (radius)
			setvalue(c_gpstep,4);       // Steps (autophotons off)
	    }
	    if (value==5){ // Brute Force
			setvalue(c_gph_preset,4);
	    }
	    if (value==6){ // Interior
			setvalue(c_gir,0.4);     // Gi resolution
			setvalue(c_girauto,0);     // Auto GI resolution
	    }
	    if (value==7){ // Exterior
			setvalue(c_gir,1);     // Gi resolution
			setvalue(c_girauto,0);     // Auto GI resolution
	    }
	}
	caustics_presets:value{
	    if (value==2){  // low preset
			setvalue(c_ppcaustics,0);   // Add to lightmap 0 - off 1 - on
			setvalue(c_cf,500000);      // Caustics photons
			setvalue(c_cfunit,2);       // 1 - Emitted 2 - Received
			setvalue(c_cmult,1);        // Power

			setvalue(c_cmatic,1);       // Autophotons 0 - off 1 - on
			setvalue(c_cn,400);     // N
			setvalue(c_clow,0.1);       // Low
			setvalue(c_chigh,0.9);      // High
			setvalue(c_cdyn,10);        // Steps (autophotons on)

			setvalue(c_cpstart,0.25);   // Radius (min)
			setvalue(c_cpstop,1);       // Max (radius)
			setvalue(c_cpstep,4);       // Steps (autophotons off)
	    }
	    if (value==3){ // medium preset
			setvalue(c_ppcaustics,0);   // Add to lightmap 0 - off 1 - on
			setvalue(c_cf,1000000);      // Caustics photons
			setvalue(c_cfunit,2);       // 1 - Emitted 2 - Received
			setvalue(c_cmult,1);        // Power

			setvalue(c_cmatic,1);       // Autophotons 0 - off 1 - on
			setvalue(c_cn,500);	    // N
			setvalue(c_clow,0.1);       // Low
			setvalue(c_chigh,0.9);      // High
			setvalue(c_cdyn,10);        // Steps (autophotons on)

			setvalue(c_cpstart,0.25);   // Radius (min)
			setvalue(c_cpstop,1);       // Max (radius)
			setvalue(c_cpstep,4);       // Steps (autophotons off)
	    }
	    if (value==4){ // high preset
			setvalue(c_ppcaustics,0);   // Add to lightmap 0 - off 1 - on
			setvalue(c_cf,5000000);      // Caustics photons
			setvalue(c_cfunit,2);       // 1 - Emitted 2 - Received
			setvalue(c_cmult,1);        // Power

			setvalue(c_cmatic,1);       // Autophotons 0 - off 1 - on
			setvalue(c_cn,800);         // N
			setvalue(c_clow,0.1);       // Low
			setvalue(c_chigh,0.9);      // High
			setvalue(c_cdyn,10);        // Steps (autophotons on)

			setvalue(c_cpstart,0.25);   // Radius (min)
			setvalue(c_cpstop,1);       // Max (radius)
			setvalue(c_cpstep,4);       // Steps (autophotons off)
	    }
	    if (value==5){		    // Brute Force
			setvalue(c_cph_preset,4);
	    }
	}
	fg_presets:value{
	    if (value==2){  // low preset
			setvalue(c_fgth,0.0001);      // FG threshold
			setvalue(c_fgrmin,100);     // FG Min rays
			setvalue(c_fgrmax,600);     // FG Max rays
			setvalue(c_prep,1);       // Prerender
			setvalue(c_prestep,1);		// Prerender steps
			setvalue(c_preSplDet,0.05);	// Prerender splotch detection
			setvalue(c_gradNeighbour,0.05);	// Gradients neighbour sensitivity
			setvalue(c_fga,0.1);        // Spatial tolerance
			setvalue(c_fgb,30);     // Angle tolerance
			setvalue(c_fgmin,0.1);      // Distance Min
			setvalue(c_fgmax,30);       // Distance Max
			setvalue(c_fgscale,0);      // B/D
			setvalue(c_fgblur,4);      // Blur
			setvalue(c_fgshows,1);      // Show samples (1 - Off 2 - Corners 3 - All)
			setvalue(c_fgsclr,<1,0,1>); // Color
			setvalue(c_fgreflections,0);
			setvalue(c_fgrefractions,1);
	    }
	    if (value==3){ // medium preset
			setvalue(c_fgth,0.0001);     // FG threshold
			setvalue(c_fgrmin,100);     // FG Min rays
			setvalue(c_fgrmax,600);    // FG Max rays
			setvalue(c_prep,1);       // Prerender
			setvalue(c_prestep,2);		// Prerender steps
			setvalue(c_preSplDet,0.05);	// Prerender splotch detection
			setvalue(c_gradNeighbour,0.05);	// Gradients neighbour sensitivity
			setvalue(c_fga,0.1);        // Spatial tolerance
			setvalue(c_fgb,25);     // Angle tolerance
			setvalue(c_fgmin,0.1);      // Distance Min
			setvalue(c_fgmax,30);        // Distance Max
			setvalue(c_fgscale,0);      // B/D
			setvalue(c_fgblur,1);      // Blur
			setvalue(c_fgshows,1);      // Show samples (1 - Off 2 - Corners 3 - All)
			setvalue(c_fgsclr,<1,0,1>); // Color
			setvalue(c_fgreflections,0);
			setvalue(c_fgrefractions,1);
	    }
	    if (value==4){ // high preset
			setvalue(c_fgth,0.0001);     // FG threshold
			setvalue(c_fgrmin,200);      // FG Min rays
			setvalue(c_fgrmax,800);    // FG Max rays
			setvalue(c_prep,1);       // Prerender
			setvalue(c_prestep,3);		// Prerender steps
			setvalue(c_preSplDet,0.02);	// Prerender splotch detection
			setvalue(c_gradNeighbour,0.02);	// Gradients neighbour sensitivity
			setvalue(c_fga,0.05);        // Spatial tolerance
			setvalue(c_fgb,15);     // Angle tolerance
			setvalue(c_fgmin,0.1);     // Distance Min
			setvalue(c_fgmax,30);        // Distance Max
			setvalue(c_fgscale,1);    // B/D
			setvalue(c_fgblur,2);       // Blur
			setvalue(c_fgshows,1);      // Show samples (1 - Off 2 - Corners 3 - All)
			setvalue(c_fgsclr,<1,0,1>); // Color
			setvalue(c_fgreflections,0);
			setvalue(c_fgrefractions,1);
	    }
	    if (value==5){			// Brute Force
			setvalue(c_fgth,0.0001);     // FG threshold
			setvalue(c_fgrmin,100);     // FG Min rays
			setvalue(c_fgrmax,800);    // FG Max rays

			setvalue(c_fgreflections,0);
			setvalue(c_fgrefractions,1);
	    }
	    if (value==6){ // Interior
			setvalue(c_fga,0.07);        // Spatial tolerance
	    }
	    if (value==7){ // Exterior
			setvalue(c_fga,0.1);        // Spatial tolerance
	    }
	}
	aa_presets:value{
		if (value==1){
			setvalue(c_aafscreen,getvalue(c_aafscreen));
		}
		if (value==2){  // low preset
			setvalue(c_edgeabs,0.2);    // Edge absolute
			setvalue(c_edgerel,0.2);    // Edge relative
			setvalue(c_edgenorm,0.1);   // Normal
			setvalue(c_edgezbuf,0.1);   // Z
			setvalue(c_edgeup,0);       // Upsample
			setvalue(c_edgethick,1);    // Thickness
			setvalue(c_edgeover,1);     // Overburn

			setvalue(c_aafscreen,0);    // FSAA 0 - off 1 - on
			
			setvalue(c_aargsmpl,2);     // Grid size (Grid)
			setvalue(c_aagridrotate,1); // Grid rotare (Grid)
			
			setvalue(c_cstocvar,0.0001);  // Threshold (Quasi-random)
			setvalue(c_cstocmin,10);    // Min rays (Quasi-random)
			setvalue(c_cstocmax,50);    // Max rays (Quasi-random)
			setvalue(c_cmbsubframes,2);	// MB subframes
			
			setvalue(c_aarandsmpl,16);  // Rays (Random)

			setvalue(c_pxlfltr,1);      // Pixel filter type (1 - Box 2 - Cone 3 - Cubic 4 - Quadric 5 - Lanczos 6 - Mitchell 7 - Spline 8 - Catmull)
			setvalue(c_pxlparam,0.7);   // Pixel filter param
			
			setvalue(c_underf,1);       // Undersample (1 - None 2 - 2 3 - 4 4 - 8 ....)
			setvalue(c_undert,0.01);	// Undersampe threshold

			setvalue(c_aatype,2);       // AA type 0 - None 1 - Grid 2 - Quasi-random 3 - Random
	    }
	    if (value==3){	//Medium
			setvalue(c_edgeabs,0.1);    // Edge absolute
			setvalue(c_edgerel,0.1);	// Edge relative
			setvalue(c_edgenorm,0.1);	// Normal
			setvalue(c_edgezbuf,0.1);	// Z
			setvalue(c_edgeup,0);       // Upsample
			setvalue(c_edgethick,1);    // Thickness
			setvalue(c_edgeover,1);     // Overburn

			setvalue(c_aafscreen,1);    // FSAA 0 - off 1 - on
			
			setvalue(c_aargsmpl,3);     // Grid size (Grid)
			setvalue(c_aagridrotate,1); // Grid rotare (Grid)
			
			setvalue(c_cstocvar,0.0001);  // Threshold (Quasi-random)
			setvalue(c_cstocmin,16);    // Min rays (Quasi-random)
			setvalue(c_cstocmax,64);    // Max rays (Quasi-random)
			setvalue(c_cmbsubframes,2);	// MB subframes
			
			setvalue(c_aarandsmpl,32);  // Rays (Random)
			
			setvalue(c_pxlfltr,1);      // Pixel filter type (1 - Box 2 - Cone 3 - Cubic 4 - Quadric 5 - Lanczos 6 - Mitchell 7 - Spline 8 - Catmull)
			setvalue(c_pxlparam,0.5);   // Pixel filter param
			
			setvalue(c_underf,1);       // Undersample (1 - None 2 - 2 3 - 4 4 - 8 ....)
			setvalue(c_undert,0.01);    // Undersampe threshold

			setvalue(c_aatype,3);       // AA type 1 - None 2 - Grid 3 - Quasi-random 4 - Random
	    }
	    if (value==4){ // high preset
			setvalue(c_edgeabs,0.1);    // Edge absolute
			setvalue(c_edgerel,0.1);        // Edge relative
			setvalue(c_edgenorm,0.05);      // Normal
			setvalue(c_edgezbuf,0.05);      // Z
			setvalue(c_edgeup,0);       // Upsample
			setvalue(c_edgethick,1);    // Thickness
			setvalue(c_edgeover,1);     // Overburn

			setvalue(c_aafscreen,1);    // FSAA 0 - off 1 - on
			
			setvalue(c_aargsmpl,4);     // Grid size (Grid)
			setvalue(c_aagridrotate,1); // Grid rotare (Grid)
			
			setvalue(c_cstocvar,0.0001); // Threshold (Quasi-random)
			setvalue(c_cstocmin,16);    // Min rays (Quasi-random)
			setvalue(c_cstocmax,128);   // Max rays (Quasi-random)
			setvalue(c_cmbsubframes,2);	// MB subframes
			
			setvalue(c_aarandsmpl,64); // Rays (Random)
			
			setvalue(c_pxlfltr,1);      // Pixel filter type (1 - Box 2 - Cone 3 - Cubic 4 - Quadric 5 - Lanczos 6 - Mitchell 7 - Spline 8 - Catmull)
			setvalue(c_pxlparam,0.5);   // Pixel filter param
			
			setvalue(c_underf,1);       // Undersample (1 - None 2 - 2 3 - 4 4 - 8 ....)
			setvalue(c_undert,0.01);    // Undersampe threshold

			setvalue(c_aatype,2);       // AA type 1 - None 2 - Grid 3 - Quasi-random 4 - Random
	    }
	    if (value==5){		// Brute Force
			setvalue(c_edgeabs,0.1);    // Edge absolute
			setvalue(c_edgerel,0.1);	// Edge relative
			setvalue(c_edgenorm,0.1);	// Normal
			setvalue(c_edgezbuf,0.1);	// Z
			setvalue(c_edgeup,0);       // Upsample
			setvalue(c_edgethick,1);    // Thickness
			setvalue(c_edgeover,1);     // Overburn

			setvalue(c_aafscreen,1);    // FSAA 0 - off 1 - on
			
			setvalue(c_aargsmpl,5);     // Grid size (Grid)
			setvalue(c_aagridrotate,1); // Grid rotare (Grid)
			
			setvalue(c_cstocvar,0.01);  // Threshold (Quasi-random)
			setvalue(c_cstocmin,10);    // Min rays (Quasi-random)
			setvalue(c_cstocmax,50);    // Max rays (Quasi-random)
			setvalue(c_cmbsubframes,2);	// MB subframes
			
			setvalue(c_aarandsmpl,64);  // Rays (Random)
			
			setvalue(c_pxlfltr,1);      // Pixel filter type (1 - Box 2 - Cone 3 - Cubic 4 - Quadric 5 - Lanczos 6 - Mitchell 7 - Spline 8 - Catmull)
			setvalue(c_pxlparam,0.5);   // Pixel filter param
			
			setvalue(c_underf,1);       // Undersample (1 - None 2 - 2 3 - 4 4 - 8 ....)
			setvalue(c_undert,0.01);    // Undersampe threshold

			setvalue(c_aatype,2);       // AA type 1 - None 2 - Grid 3 - Quasi-random 4 - Random
	    }
	}
	quality_presets:value{
	    if (value==2){  // low preset
			setvalue(c_planth,0.002);   // Area threshold
			setvalue(c_planrmin,1);     // Area min
			setvalue(c_planrmax,4);     // Area max
			setvalue(c_llinth,0.002);   // Linear threshold
			setvalue(c_llinrmin,1);     // Linear min
			setvalue(c_llinrmax,4);     // Linear max
			setvalue(c_lumith,0.01);    // Luminosity threshold
			setvalue(c_lumirmin,10);    // Luminosity min
			setvalue(c_lumirmax,60);    // Luminosity max
			setvalue(c_refth,0.001);    // Blurring threshold
			setvalue(c_refrmin,100);    // Blurring min
			setvalue(c_refrmax,100);    // Blurring max
			setvalue(c_refacth,0.01);  // Blurring accuracy
			setvalue(c_refmodel,0);   // Trace direct reflections
			setvalue(c_octdepth,3);    // Octree 
	    }
	    if (value==3){ // medium preset
			setvalue(c_planth,0.002);   // Area threshold
			setvalue(c_planrmin,2);     // Area min
			setvalue(c_planrmax,4);     // Area max
			setvalue(c_llinth,0.002);   // Linear threshold
			setvalue(c_llinrmin,2);     // Linear min
			setvalue(c_llinrmax,4);     // Linear max
			setvalue(c_lumith,0.01);    // Luminosity threshold
			setvalue(c_lumirmin,10);    // Luminosity min
			setvalue(c_lumirmax,100);    // Luminosity max
			setvalue(c_refth,0.0001);    // Blurring threshold
			setvalue(c_refrmin,100);    // Blurring min
			setvalue(c_refrmax,500);   // Blurring max
			setvalue(c_refacth,0.01);    // Blurring accuracy
			setvalue(c_refmodel,0);   // Trace direct reflections
			setvalue(c_octdepth,3);    // Octree 
	    }
	    if (value==4){ // high preset
			setvalue(c_planth,0.001);   // Area threshold
			setvalue(c_planrmin,2);     // Area min
			setvalue(c_planrmax,6);     // Area max
			setvalue(c_llinth,0.001);   // Linear threshold
			setvalue(c_llinrmin,2);     // Linear min
			setvalue(c_llinrmax,6);     // Linear max
			setvalue(c_lumith,0.01);    // Luminosity threshold
			setvalue(c_lumirmin,50);    // Luminosity min
			setvalue(c_lumirmax,150);   // Luminosity max
			setvalue(c_refth,0.0001);   // Blurring threshold
			setvalue(c_refrmin,200);    // Blurring min
			setvalue(c_refrmax,600);   // Blurring max
			setvalue(c_refacth,0.1);    // Blurring accuracy
			setvalue(c_refmodel,0);   // Trace direct reflections
			setvalue(c_octdepth,3);    // Octree 
	    }
	    if (value==5){		   // Brute Force
			setvalue(c_planth,0.002);   // Area threshold
			setvalue(c_planrmin,2);     // Area min
			setvalue(c_planrmax,4);     // Area max
			setvalue(c_llinth,0.002);   // Linear threshold
			setvalue(c_llinrmin,2);     // Linear min
			setvalue(c_llinrmax,4);     // Linear max
			setvalue(c_lumith,0.01);    // Luminosity threshold
			setvalue(c_lumirmin,50);    // Luminosity min
			setvalue(c_lumirmax,200);    // Luminosity max
			setvalue(c_refth,0.0001);    // Blurring threshold
			setvalue(c_refrmin,100);    // Blurring min
			setvalue(c_refrmax,500);   // Blurring max
			setvalue(c_refacth,0.01);    // Blurring accuracy
			setvalue(c_refmodel,0);   // Trace direct reflections
			setvalue(c_octdepth,3);    // Octree depth
	    }
	}
	general_presets:value{
	    if (value!=1 && value<6){
			value=value+(-1);
			setvalue(c_gph_preset,value);
			setvalue(c_cph_preset,value);
			setvalue(c_fg_preset,value);
			setvalue(c_aa_preset,value);
			setvalue(c_quality_preset,value);
			setvalue(c_general_preset,1);
			setvalue(c_giirrgrad,1); // Cached irradiance
	    }
	    if (value==6){ // Uncached
			setvalue(c_gi,3); // Photon mapping
			setvalue(c_fg_preset,5);
			setvalue(c_shgi,1); // shared gi 
			setvalue(c_giirrgrad,0);  // Uncached irradiance
		}
	    if (value==7){ // static GI
			setvalue(c_gi,3); // Photon mapping

			setvalue(c_shgi,3); // gi mode: shared
			setvalue(c_ginew,3); // gi file mode
	    }
	    if (value==8){ // animated GI
			setvalue(c_gi,3); // Photon mapping

			setvalue(c_shgi,2); // gi mode: TI

			setvalue(c_tiframes,5); 
			setvalue(c_tiextinction,0.3); 
	    }
	}

//custom functions
	setsafevalue:ctrl,value{
		if (guisetup_flag){
			setvalue(ctrl,value);
		}
	}
	add_kray_command: control,command{
	    str=getvalue(control);
	    if (str!=""){
			if (strright(str,1)!=";"){
				str=str+";";
			}
	    }
	    setvalue(control,str+command);
	}
	add_info_command: control,command{
	    str=getvalue(control);
	    if (str!=""){
			if (strright(str,1)!=" "){
				str=str+" ";
			}
	    }
	    setvalue(control,str+command);
	}	
	refresh_header_add : value{
	    index=getvalue(c_headeradd);
	    if (index!=1){
		add_kray_command(c_prescript,header_list[index]);
		setvalue(c_headeradd,1);
	    }
	}
	refresh_tailer_add : value{
	    index=getvalue(c_taileradd);
	    if (index!=1){
		add_kray_command(c_postscript,tailer_list[index]);
		setvalue(c_taileradd,1);
	    }
	}
	refresh_renderinfo_add : value{
	    index=getvalue(c_RenderIinfoAdd);
	    if (index!=1){
		add_info_command(c_InfoText,renderinfo_list[index]);
		setvalue(c_RenderIinfoAdd,1);
	    }
	}
	read_line: io{
		line=string(io.read());

		if (size(line)>0){	// strip non ascii chars
			if (strright(line,1)<" "){
				line=strleft(line,len+(-1));
			}
		}
		
		return line;
	}
	read_int: io{
		return int(read_line(io));
	}
	read_number: io{
		return number(read_line(io));
	}
	read_vector: io{
		return vector(read_line(io));
	}

	tf_active:value{
	    return value;
	}
	ft_active:value{
	    return !value;
	}

	is_1:value{
	    return (value==1);
	}
	is_not_1:value{
	    return (value!=1);
	}
	is_not_one_not_four_active:value{
	    return (value!=1 && value!=4);
	}
	is_one_or_four_active:value{
	    return (value!=1 && value!=4);
	}
	is_2:value{
	    return (value==2);
	}
	is_less_then_6:value{
	    return (value<6);
	}

	is_3:value{
	    return (value==3);
	}

	is_4:value{
	    return (value!=4);
	}
	is_not_4:value{
	    return (value==4);
	}
		is_not_5:value{
	    return (value==5);
	}
	ti_refresh2:value{
	    v1=getvalue(c_tifg);
	    v2=getvalue(c_tiphotons);
	    if (!v1 && !v2){
		setvalue(c_tifg,1);
	    }
	}
	ti_refresh1:value{
	    v1=getvalue(c_tifg);
	    v2=getvalue(c_tiphotons);
	    if (!v1 && !v2){
		setvalue(c_tiphotons,1);
	    }
	}
	zero_one_c_prep_refresh:value{
	    if (value<0) setvalue(c_prep,0);
	    if (value>1) setvalue(c_prep,1);
	}
	format_refresh:v{
	    value=getvalue(c_outfmt);
	    fname=find_frame_number(getvalue(c_outname));
	    
	    if (fname!=""){ 
		   // find last '.'
		   
			dot=0;
			
			for (a=size(fname) ; a>0 ; a--){
				if (fname[a]=="\\" || fname[a]=="/"){
					break;
				}
				if (fname[a]=="."){
					dot=a;
					break;
				}
			}
			
			if (dot>0){
				fname=strleft(fname,dot);
			}else{
				fname=string(fname,".");
			}
			

			switch(value){
				case 1:
					n_ext="hdr";
				break;
				case 2:
					n_ext="jpg";
				break;
				case 3:
				case 4:
					n_ext="png";
				break;
				case 5:
				case 6:
					n_ext="tif";
				break;
				case 7:
				case 8:
					n_ext="tga";
				break;
				case 9:
				case 10:
					n_ext="bmp";
				break;
			}

			if (fname!=""){
				name=string(fname,n_ext);
				setvalue(c_outname,name);
			}
		}
	}
	c_dof_on:value{
	    return dof_active;
	}
	c_antiadapt:value{
	    if (dof_active){
			return false;
	    }
	    if (value==3 || value==6){
			return true;
	    }else{
			return false;
	    }
	}
	c_antigrid:value{
	    if (value==2){
			return true;
	    }else{
			return false;
	    }
	}
	c_antistoc:value{
	    if (value==3){
			return true;
	    }else{
			return false;
	    }
	}
	c_antirand:value{
	    if (value==4){
			return true;
	    }else{
			return false;
	    }
	}
	c_pmdirectopt:value{
	    if (value==2){
			return true;
	    }else{
			return false;
	    }
	}
	c_pmcausticsopt:value{
	    if (value!=2){
			return true;
	    }else{
		if (getvalue(c_gipmmode)==4){
		    if (getvalue(c_girtdirect)==1){
				return true;
		    }
		}
		return false;
	    }
	}
	c_pmrtdirect:value{
	    if (value!=2){
		return false;
	    }else{
		if (getvalue(c_gipmmode)==4){
		    return true;
		}
		return false;
	    }
	}
	c_pmirrgradopt:value{
	    if (value>=3){
		return true;
	    }else{
		return false;
	    }
	}
	on_off_fsaa_refresh:value{
	    setvalue(c_aafscreen,getvalue(c_aafscreen));
	}

	c_fgircopy:value{
	    setvalue(c_gir,getvalue(c_gir_copy));
	}
	c_fgirautocopy:value{
	    setvalue(c_girauto,getvalue(c_girauto_copy));
	}
	c_gmaticrefresh:value{
	    if (getvalue(c_gph_preset)==1){
			setvalue(c_gph_preset,1);
	    }
	    if (!value){
			setvalue(c_girauto,0);
	    }
	}
	c_cmaticrefresh:value{
	    if (getvalue(c_cph_preset)==1){
			setvalue(c_cph_preset,1);
	    }
	}
	c_gipmmode_refresh:value{
	    a=getvalue(c_gipmmode);
	    setvalue(c_gipmmode,a);
	}
	c_gi_refresh:value{
	    a=getvalue(c_gi);
	    setvalue(c_gi,a);
	}
	c_gipmmode_prep_active:value{
	    a=getvalue(c_gi);
	    if (a==3 || a==4){
			return value;
	    }else{
			return false;
	    }
	}
	c_aa_preset_refresh:value{
	    a=getvalue(c_aa_preset);
	    if (a==1){
		setvalue(c_aa_preset,1);
	    }
	}
	disable_fscreen_refresh:value{	// if aa is none
		if (value==1 || value==4){
			setvalue(c_aafscreen,1);
		// }else{
			// setvalue(c_aafscreen,0);
		}
	}
	aa_edge_active:value{
		if (value){
			return 0;
		}
		pset=getvalue(c_aa_preset);
		if (pset!=1){
			return 0;
		}	
		return 1;
	}
	aa_edge_active2:value{
		if (value){
			return 0;
		}
		pset=getvalue(c_aa_preset);
		if (pset!=1){
			return 0;
		}
		underf=getvalue(c_underf);
		if (underf!=1){
			return 0;
		}
		return 1;
	}
	c_tab_refresh:value{
	    new_active_tab=getvalue(tab0);

	    if (new_active_tab==3){
			setvalue(c_gir_copy,getvalue(c_gir));
			setvalue(c_girauto_copy,getvalue(c_girauto));
	    }

	    active_tab=new_active_tab;
	}
	
	renderOptsList{
		list="";
		if (!Scene().renderopts[1]){
			list="`Raytrace Shadows`";
		}
		if (!Scene().renderopts[2]){
			if (list!=""){
				list=list+",";
			}
			list=list+"`Raytrace Reflection`";
		}
		if (!Scene().renderopts[3]){
			if (list!=""){
				list=list+",";
			}
			list=list+"`Raytrace Refraction`";
		}
		
		return list;
	}

	find_frame_number:input{
	    mlsize=size(input);
		dstreak=0;
		nlen=5;
		replacement="%frame%";
		rsize=size(replacement);
		
		// try to find replacement
		for (a=1+rsize ; a<=mlsize ; a++){
			sub=strsub(input,a+(-rsize),rsize);
			
			if (sub=="%frame%"){
				return input;
			}
		}
		
		// find last / or \
		last_slash=1;
		
	    for (a=1 ; a<=mlsize ; a++){
			character=strsub(input,a,1);
			
			if (character=="/" || character=="\\"){
				last_slash=a;
			}
		}
		
	    for (a=last_slash ; a<=mlsize ; a++){
			character=strsub(input,a,1);
			
			// >= <= < > operators does not work on mac
			if ((character=="0") ||
				(character=="1") ||
				(character=="2") ||
				(character=="3") ||
				(character=="4") ||
				(character=="5") ||
				(character=="6") ||
				(character=="7") ||
				(character=="8") ||
				(character=="9")){
				dstreak++;
			}else{
				if (dstreak>=nlen){
					return strleft(input,a+(-6))+replacement+strsub(input,a,mlsize);
				}
				dstreak=0;
			}
		}
		if (dstreak>=nlen){
			return strleft(input,a+(-6))+replacement;
		}

		return input;
	}
	is_name:input{
		mlsize=size(input);
		if (mlsize!=0){
		    return true;
		}
		return false;
	}

	CheckRenderFlagsAndAmbient{
		ambient = Light().ambient(0);
		RT_Shadow = Scene().renderopts[1];
		RT_Reflect = Scene().renderopts[2];
		RT_Refract = Scene().renderopts[3];

		if (!RT_Shadow || !RT_Reflect || !RT_Refract || ambient>0){
			reqbegin("Kray warning");
			reqsize( 450, 130);

			msg="";
			
			if (!RT_Shadow || !RT_Reflect || !RT_Refract){
				ctltext("",renderOptsList()+" raytrace flags are OFF.");
			}
			if (ambient>0){
				ctltext("","There is AMBIENT light in scene.");
			}
			
			ctltext("","Do you want to fix it?");
		    choice = reqpost();

		    reqend();
			if (choice){		
				if (!RT_Shadow){	
					RayTraceShadows();
				}
				if (!RT_Reflect){	
					RayTraceReflection();
				}
				if (!RT_Reflect){
					RayTraceRefraction();
				}
			    AmbientIntensity(0);
			}
		}
	}

	reqkeyboard: key{
		// For CTRL+a, use normal ascii keyboard codes. 01 is CTRL+a.  02 is CTRL+b and so on through 26 being CTRL+z.
		if(key == REQKB_F9) //render frame
		{	
			rendersingle();
		}
		
		if(key == REQKB_F10) //render sequence
		{
			rendersequence();
		}
		
		if(key == REQKB_LEFT || key == REQKB_PAGEUP) // go previous Tab
		{
			current_tab = getvalue(tab0) - 1;
			if(current_tab < 1) current_tab = 6; //loop back to last tab
			tab0.value = current_tab;
		}

		if(key == REQKB_RIGHT || key == REQKB_PAGEDOWN) // go next Tab
		{
			current_tab = getvalue(tab0) + 1;
			if(current_tab > 6) current_tab = 1; //loop back to first tab
			tab0.value = current_tab; 
		}
		if (key == 'l'){
		    CommandInput("Generic_KrayLicenseTool");
		}
	}
	resetfile {
		filedelete ( v_giload );
		safe_warn("GI File has been reset!");
	}
	render_exe :  suffix{
		if (exe_autoconfirm){
			AutoConfirm(1);
		}
		vmapObj = Mesh();
		if (vmapObj){
			vmapObj=0;
			SaveAllObjects();
		}
		SaveScene();
		if (exe_autoconfirm){
			AutoConfirm(0);
		}
		scene = Scene();
		quote="\""; quote="\"";
		content=getdir("Content");
		
		params=quote+scene.filename+quote+" -c "+quote+"addpathlw;addpath '"+content+"';"+quote+suffix;
		
		mac=0;
		if (size(exe_path)>4){
			if (strright(exe_path,4)==".app"){
				mac=1;
			}
		}
		
		if (mac){
			system(exe_path+"/Contents/MacOS/Kray "+params);
		}else{
			spawn(exe_path+" ",params);
		}
	}
	rendersingle{
		if (exe_path!=""){
			render_exe(" -p singleframe;finishwait;");
		}else{
			get_values();
			CommandInput("Generic_KrayFrame");
		}
	}
	rendersequence{
		if (exe_path!=""){
			render_exe(" -p finishwait;");
		}else{
			get_values();
			CommandInput("Generic_KrayAnim");
		}
	}

//get values
	get_values{
	    get_general_values();
	    get_accuracy_values();
	}
	get_accuracy_values{
	    v_girauto=getvalue(c_girauto);

	    v_cf=abs(getvalue(c_cf));
	    v_cfunit=getvalue(c_cfunit);
	    v_gf=abs(getvalue(c_gf));
	    v_gfunit=getvalue(c_gfunit);
	    v_gmode=getvalue(c_gmode);

	    v_gir=abs(getvalue(c_gir));

	    v_fgth=abs(getvalue(c_fgth));
	    v_fgrmin=abs(getvalue(c_fgrmin));
	    v_fgrmax=abs(getvalue(c_fgrmax));

	    v_fga=abs(getvalue(c_fga));
	    v_fgb=abs(getvalue(c_fgb));

	    v_cmatic=getvalue(c_cmatic);
	    v_clow=abs(getvalue(c_clow));
	    v_chigh=abs(getvalue(c_chigh));
	    v_cdyn=abs(getvalue(c_cdyn));

	    v_cn=abs(getvalue(c_cn));
	    v_cpstart=abs(getvalue(c_cpstart));
	    v_cpstop=abs(getvalue(c_cpstop));
	    v_cpstep=abs(getvalue(c_cpstep));

	    v_gn=abs(getvalue(c_gn));
	    v_gpstart=abs(getvalue(c_gpstart));
	    v_gpstop=abs(getvalue(c_gpstop));
	    v_gpstep=abs(getvalue(c_gpstep));

	    v_gmatic=getvalue(c_gmatic);
	    v_glow=abs(getvalue(c_glow));
	    v_ghigh=abs(getvalue(c_ghigh));
	    v_gdyn=abs(getvalue(c_gdyn));

	    v_ppsize=abs(getvalue(c_ppsize));
	    v_ppblur=abs(getvalue(c_ppblur));
	    v_ppmult=abs(getvalue(c_ppmult));

	    v_cmult=abs(getvalue(c_cmult));

	    v_ppcaustics=getvalue(c_ppcaustics);

	    v_fgmin=abs(getvalue(c_fgmin));
	    v_fgmax=abs(getvalue(c_fgmax));
	    v_fgscale=abs(getvalue(c_fgscale));
	    v_fgblur=abs(getvalue(c_fgblur));
	    v_fgshows=abs(getvalue(c_fgshows));
	    v_fgsclr=getvalue(c_fgsclr);

	    v_cornerdist=getvalue(c_cornerdist);
	    v_cornerpaths=getvalue(c_cornerpaths);

	    v_fgreflections=getvalue(c_fgreflections);
	    v_fgrefractions=getvalue(c_fgrefractions);

	    v_showphotons=getvalue(c_showphotons);

	    v_resetoct=getvalue(c_resetoct);
	    v_limitdr=getvalue(c_limitdr);
	}
	get_general_values{
		// presets
		    v_gph_preset=getvalue(c_gph_preset);
		    v_cph_preset=getvalue(c_cph_preset);
		    v_fg_preset=getvalue(c_fg_preset);
		    v_aa_preset=getvalue(c_aa_preset);
		    v_quality_preset=getvalue(c_quality_preset);
		    v_general_preset=getvalue(c_general_preset);
		    
		// general
		    v_gi=getvalue(c_gi);
		    v_gicaustics=getvalue(c_gicaustics);
		    v_giirrgrad=getvalue(c_giirrgrad);
		    v_girtdirect=getvalue(c_girtdirect);
		    v_gipmmode=getvalue(c_gipmmode);
		    v_lg=getvalue(c_lg);
		    v_autolumi=getvalue(c_autolumi);
		    v_pl=getvalue(c_pl);
		    v_shgi=getvalue(c_shgi);
		    v_tiphotons=getvalue(c_tiphotons);
		    v_tifg=getvalue(c_tifg);
		    v_tiframes=getvalue(c_tiframes);
		    v_tiextinction=getvalue(c_tiextinction);
		    v_outname=getvalue(c_outname);
		    v_outfmt=getvalue(c_outfmt);
			v_render0=getvalue(c_render0);
			
			v_output_On=getvalue(c_output_On);

		    v_tmo=getvalue(c_tmo);
		    v_tmhsv=getvalue(c_tmhsv);
		    v_outparam=getvalue(c_outparam);
		    v_outexp=getvalue(c_outexp);
		    
			v_prep=getvalue(c_prep);
			v_prestep=abs(getvalue(c_prestep));
			v_preSplDet=abs(getvalue(c_preSplDet));
			v_gradNeighbour=abs(getvalue(c_gradNeighbour));

			v_pxlordr=getvalue(c_pxlordr);
		    v_underf=getvalue(c_underf);
		    v_undert=getvalue(c_undert);
		    v_areavis=getvalue(c_areavis);
		    v_areaside=getvalue(c_areaside);
		    v_giload=getvalue(c_giload);
		    v_ginew=getvalue(c_ginew);

		// lights camera sampling

		    v_planth=abs(getvalue(c_planth));
		    v_planrmin=abs(getvalue(c_planrmin));
		    v_planrmax=abs(getvalue(c_planrmax));
		    v_llinth=abs(getvalue(c_llinth));
		    v_llinrmin=abs(getvalue(c_llinrmin));
		    v_llinrmax=abs(getvalue(c_llinrmax));
		    v_lumith=abs(getvalue(c_lumith));
		    v_lumirmin=abs(getvalue(c_lumirmin));
		    v_lumirmax=abs(getvalue(c_lumirmax));

		    temp=getvalue(c_camobject);

		    v_camobject=0;
		    count=2;
		    vmapObj = Mesh();
			v_camobjectfile="";
		    while(vmapObj){
			if (count==temp){
			    v_camobject=vmapObj.id;
			    v_camobjectfile=vmapObj.filename;
			}
			vmapObj = vmapObj.next();
			count++;
		    }

		    temp=getvalue(c_camuvname);

		    count=2;
		    v_camuvname="";
		    vmapObj = VMap(VMTEXTURE);
		    while(vmapObj){
			if (vmapObj.type == VMTEXTURE){
			    if (count==temp){
				v_camuvname=vmapObj.name;
			    }
			    count++;
			}
			vmapObj = vmapObj.next();
		    }
			
			v_errode=getvalue(c_errode);

		    temp=getvalue(c_dofobj);

		    v_dofobj="";
		    count=2;
		    vmapObj = Mesh();
		    while(vmapObj){
			if (count==temp){
			    v_dofobj=vmapObj.name;
			}
			vmapObj = vmapObj.next();
			count++;
		    }

			v_eyesep=getvalue(c_eyesep);
			v_stereoimages=getvalue(c_stereoimages);
			
		    v_cptype=getvalue(c_cptype);
		    v_lenspict=getvalue(c_lenspict);

		    v_cstocvar=getvalue(c_cstocvar);
		    v_cstocmin=getvalue(c_cstocmin);
		    v_cstocmax=getvalue(c_cstocmax);
		    v_cmbsubframes=getvalue(c_cmbsubframes);
		    v_aatype=getvalue(c_aatype);
		    v_aafscreen=getvalue(c_aafscreen);
		    v_aarandsmpl=getvalue(c_aarandsmpl);

		    v_aargsmpl=getvalue(c_aargsmpl);
		    v_aagridrotate=getvalue(c_aagridrotate);

		// edgedetector
		    v_edgeabs=getvalue(c_edgeabs);
		    v_edgerel=getvalue(c_edgerel);
		    v_edgenorm=getvalue(c_edgenorm);
		    v_edgezbuf=getvalue(c_edgezbuf);
		    v_edgeup=getvalue(c_edgeup);
		    v_edgethick=getvalue(c_edgethick);
		    v_edgeover=getvalue(c_edgeover);

		// pixel filter
		    v_pxlfltr=getvalue(c_pxlfltr);
		    v_pxlparam=getvalue(c_pxlparam);

		    if (v_pxlfltr==1){
			if (v_pxlparam<0.5){
			    v_pxlparam=0.5;
			}
		    }
		    if (v_pxlfltr==2){
			if (v_pxlparam<0.71){
			    v_pxlparam=0.71;
			}
		    }
		    if (v_pxlfltr==3){
			if (v_pxlparam<1){
			    v_pxlparam=1;
			}
		    }

		// reflection refrection
	    v_refth=abs(getvalue(c_refth));
	    v_refrmin=abs(getvalue(c_refrmin));
	    v_refrmax=abs(getvalue(c_refrmax));
	    v_refacth=abs(getvalue(c_refacth));
	    v_refmodel=getvalue(c_refmodel);

	    v_conetoarea=getvalue(c_conetoarea);
	    v_octdepth=getvalue(c_octdepth);

	    //ovr_rem v_ovrsfc=getvalue(c_ovrsfc);
	    //ovr_rem v_ovrsfcolor=getvalue(c_ovrsfcolor);

	    v_prescript=getvalue(c_prescript);
	    v_postscript=getvalue(c_postscript);
		
		// Misc tab
		v_LogOn=getvalue(c_LogOn);
		v_Logfile=getvalue(c_Logfile);
		v_Debug=getvalue(c_Debug);
		v_InfoOn=getvalue(c_InfoOn);
		v_InfoText=getvalue(c_InfoText);
		v_IncludeOn=getvalue(c_IncludeOn);
		v_IncludeFile=getvalue(c_IncludeFile);
		v_FullPrev=getvalue(c_FullPrev);
		v_Finishclose=getvalue(c_Finishclose);
		v_UBRAGI=getvalue(c_UBRAGI);
		v_outputtolw=getvalue(c_outputtolw);
	}

//load/save functions
   //save
	savesettings{
		kraysettingsfile = getfile("Save Kray global settings","kray_settings.KGcfg",,0);
		return if kraysettingsfile == nil;
		
		outfile = File(kraysettingsfile,"w");
		
		//--- saving start
		outfile.writeln("Kray{");
		save_general(outfile);
		save_accuracy(outfile);
		//save_krayscript_file(outfile,"");
		outfile.writeln("}");
	    //--- saving end
	}
	check_exe_location{
		if (exe_path!=""){
			krayfile = File(exe_path,"r");
			if (!krayfile){
				exe_path=getfile("Locate Kray executable","","",1);

				if (exe_path){
					krayfile=File(exe_path,"r");
					if (krayfile){
						info("Kray path : '"+exe_path+"'");
						krayfile.close();
					}else{
						exe_path="";
					}
				}else{
					exe_path="";
				}
			}
			
			if (exe_path==""){
				info("Standalone mode disabled.");
			}
		}
	}	
	save_general: io{
	    io.writeln(version);

		if (!create_flag){	// not inited, do not save settings
		    io.writeln(int,3605);
		    io.writeln(int,v_gph_preset);
		    io.writeln(int,v_cph_preset);
		    io.writeln(int,v_fg_preset);
		    io.writeln(int,v_aa_preset);
		    io.writeln(int,v_quality_preset);
			
		    io.writeln(int,104);
		    io.writeln(int,v_gi);
		    io.writeln(v_gicaustics);
		    io.writeln(v_giirrgrad);
		    io.writeln(v_gipmmode);

		    io.writeln(int,2301);
		    io.writeln(v_girtdirect);

		    io.writeln(int,201);
		    io.writeln(int,v_lg);
			
		    io.writeln(int,301);
		    io.writeln(int,v_pl);

		    mlsize=size(v_outname);
		    if (mlsize==0){
				io.writeln(int,3501);
				io.writeln("");
		    }else{
				for (a=1 ; a<=mlsize ; a+=maxlinelength){
					t=a+maxlinelength;
					if (t>(mlsize+1)){
						t=mlsize+1;
					}
					t=-a+t;
					io.writeln(int,3501);
					io.writeln(strsub(v_outname,a,t));
				}
			}

		    io.writeln(int,602);
		    io.writeln(number,v_prep);
		    io.writeln(int,v_pxlordr);

		    io.writeln(int,702);
		    io.writeln(int,v_underf);
		    io.writeln(number,v_undert);

		    io.writeln(int,802);
		    io.writeln(int,v_areavis);
		    io.writeln(int,v_areaside);

		   // lights & camera

		    io.writeln(int,1003);
		    io.writeln(v_planth);
		    io.writeln(v_planrmin);
		    io.writeln(v_planrmax);

		    io.writeln(int,2103);
		    io.writeln(v_llinth);
		    io.writeln(v_llinrmin);
		    io.writeln(v_llinrmax);

		    io.writeln(int,1103);
		    io.writeln(v_lumith);
		    io.writeln(v_lumirmin);
		    io.writeln(v_lumirmax);

		    io.writeln(int,2402);
		    io.writeln(v_camobject);
		    io.writeln(v_camuvname);

		    io.writeln(int,1301);
		    io.writeln(v_cptype);

		    mlsize=size(v_lenspict);
		    if (mlsize==0){
				io.writeln(int,1401);
				io.writeln("");
		    }else{
				for (a=1 ; a<=mlsize ; a+=maxlinelength){
					t=a+maxlinelength;
					if (t>(mlsize+1)){
						t=mlsize+1;
					}
					t=-a+t;
					io.writeln(int,1401);
					io.writeln(strsub(v_lenspict,a,t));
				}
			}
		    
		    io.writeln(int,1501);
		    io.writeln(v_dofobj);

		    io.writeln(int,1603);
		    io.writeln(v_cstocvar);
		    io.writeln(v_cstocmin);
		    io.writeln(v_cstocmax);

		    io.writeln(int,1804);
		    io.writeln(v_aatype);
		    io.writeln(v_aafscreen);
		    io.writeln(v_aargsmpl);
		    io.writeln(v_aagridrotate);

		    io.writeln(int,1903);
		    io.writeln(v_refth);
		    io.writeln(v_refrmin);
		    io.writeln(v_refrmax);

		    mlsize=size(v_prescript);
		    if (mlsize==0){
				io.writeln(int,3301);
				io.writeln("");
		    }else{
				for (a=1 ; a<=mlsize ; a+=maxlinelength){
					t=a+maxlinelength;
					if (t>(mlsize+1)){
						t=mlsize+1;
					}
					t=-a+t;
					io.writeln(int,3301);
					io.writeln(strsub(v_prescript,a,t));
				}
			}
		    
		    mlsize=size(v_postscript);
		    if (mlsize==0){
				io.writeln(int,3401);
				io.writeln("");
		    }else{
				for (a=1 ; a<=mlsize ; a+=maxlinelength){
					t=a+maxlinelength;
					if (t>(mlsize+1)){
						t=mlsize+1;
					}
					t=-a+t;
					io.writeln(int,3401);
					io.writeln(strsub(v_postscript,a,t));
				}
			}
		    
		    io.writeln(int,2101);
		    io.writeln(v_autolumi);

		    //ovr_rem io.writeln(int,2502);
		    //ovr_rem io.writeln(v_ovrsfc);
		    //ovr_rem io.writeln(v_ovrsfcolor);

		    io.writeln(int,2601);
		    io.writeln(v_conetoarea);

		    io.writeln(int,2707);
		    io.writeln(v_edgeabs);
		    io.writeln(v_edgerel);
		    io.writeln(v_edgenorm);
		    io.writeln(v_edgezbuf);
		    io.writeln(v_edgeup);
		    io.writeln(v_edgethick);
		    io.writeln(v_edgeover);

		    io.writeln(int,2802);
		    io.writeln(v_pxlfltr);
		    io.writeln(v_pxlparam);

		    io.writeln(int,2901);
		    io.writeln(v_refacth);

		    io.writeln(int,3004);
		    io.writeln(number,v_tmo);
		    io.writeln(number,v_tmhsv);
		    io.writeln(number,v_outparam);
		    io.writeln(number,v_outexp);

		    io.writeln(int,3101);
		    io.writeln(v_aarandsmpl);

		    io.writeln(int,3207);   // do zmiany
		    io.writeln(int,v_shgi);
		    io.writeln(string,v_giload);
		    io.writeln(boolean,v_ginew);
		    io.writeln(boolean,v_tiphotons);
		    io.writeln(boolean,v_tifg);
		    io.writeln(int,v_tiframes);
		    io.writeln(number,v_tiextinction);
		    
		    io.writeln(int,3701);
		    io.writeln(int,v_cmbsubframes);

		    io.writeln(int,3801);
		    io.writeln(v_refmodel);

		    io.writeln(int,4001);
		    io.writeln(v_octdepth);
			
			io.writeln(boolean,4101);
		    io.writeln(v_output_On);
			
			io.writeln(int,4201);
			io.writeln(v_errode);
			
			io.writeln(int,4303);
			io.writeln(v_eyesep);
			io.writeln(int,v_stereoimages);
			io.writeln(boolean,v_render0);
			
			io.writeln(int,4411);
			io.writeln(boolean,v_LogOn);
			io.writeln(v_Logfile);
			io.writeln(boolean,v_Debug);
			io.writeln(boolean,v_InfoOn);
			io.writeln(v_InfoText);
			io.writeln(boolean,v_IncludeOn);
			io.writeln(v_IncludeFile);
			io.writeln(boolean,v_FullPrev);
			io.writeln(boolean,v_Finishclose);
			io.writeln(boolean,v_UBRAGI);
			io.writeln(boolean,v_outputtolw);
		}

		io.writeln(int,3901);
		io.writeln(int,create_flag);

		io.writeln(int,4301);
		io.writeln(int,v_outfmt);	// new outputformat (list)
		
	    io.writeln(int,0);  // end hunk
	}
	save_accuracy: io{
	    io.writeln("AccuracyBegin");
	    io.writeln(version);

		if (!create_flag){	// not inited, do not save settings
		    io.writeln(int,100601);
		    io.writeln(int,v_girauto);

		    io.writeln(int,100001);
		    io.writeln(v_gir);

		    io.writeln(int,100105);
		    io.writeln(v_cf);
		    io.writeln(int,v_cn);
		    io.writeln(v_cpstart);
		    io.writeln(v_cpstop);
		    io.writeln(v_cpstep);

		    io.writeln(int,100704);
		    io.writeln(v_cmatic);
		    io.writeln(v_clow);
		    io.writeln(v_chigh);
		    io.writeln(v_cdyn);

		    io.writeln(int,100205);
		    io.writeln(v_gf);
		    io.writeln(int,v_gn);
		    io.writeln(v_gpstart);
		    io.writeln(v_gpstop);
		    io.writeln(v_gpstep);

		    io.writeln(int,100804);
		    io.writeln(v_gmatic);
		    io.writeln(v_glow);
		    io.writeln(v_ghigh);
		    io.writeln(v_gdyn);

		    io.writeln(int,100301);
		    io.writeln(v_ppsize);

		    io.writeln(int,100405);
		    io.writeln(v_fgmin);
		    io.writeln(v_fgmax);
		    io.writeln(v_fgscale);
		    io.writeln(v_fgshows);
		    io.writeln(v_fgsclr);

		    io.writeln(int,100502);
		    io.writeln(v_cornerdist);
		    io.writeln(v_cornerpaths);

		    io.writeln(int,100901);
		    io.writeln(int,v_cfunit);

		    io.writeln(int,101001);
		    io.writeln(int,v_gfunit);

		    io.writeln(int,101102);
		    io.writeln(v_fgreflections);
		    io.writeln(v_fgrefractions);

		    io.writeln(int,101201);
		    io.writeln(int,v_gmode);

		    io.writeln(int,101301);
		    io.writeln(int,v_ppcaustics);

		    io.writeln(int,101403);
		    io.writeln(v_fgrmin);
		    io.writeln(v_fgrmax);
		    io.writeln(v_fgth);

		    io.writeln(int,101502);
		    io.writeln(v_fga);
		    io.writeln(v_fgb);

		    io.writeln(int,101601);
		    io.writeln(v_ppmult);

		    io.writeln(int,101701);
		    io.writeln(v_cmult);

		    io.writeln(int,101801);
		    io.writeln(v_ppblur);
		    
		    io.writeln(int,101901);
		    io.writeln(v_fgblur);

		    io.writeln(int,102001);
		    io.writeln(int,v_showphotons);

		    io.writeln(int,102201);
		    io.writeln(int,v_resetoct);

		    io.writeln(int,102301);
		    io.writeln(int,v_limitdr);

			io.writeln(int,102403);
			io.writeln(int,v_prestep);
			io.writeln(v_preSplDet);
			io.writeln(v_gradNeighbour);
			
		}

	    io.writeln(int,0);  // end hunk
	    io.writeln("AccuracyEnd");
	}
   //load
	loadsettings{
		kraysettingsfile = getfile("Load Kray global settings",,,1);
		if (kraysettingsfile == nil){
			return;
		}
		
		infile = File(kraysettingsfile,"r");
		
		//--- loading start
		infile.read();  // Kray{
		load_settings_general(infile);
		load_settings_accuracy(infile);
	    //--- loading end
	    
	    safe_warn("Kray global settings loaded successfully...");
	}
	load_settings_general: io{
		test_version=read_int(io);
		if (test_version>=1000){
			if (test_version>version){
				safe_warn("Scene was saved with newer version of Kray plugin.<br>Some features are not available and will be lost if you save the scene.");
			}

			loadv_prescript="";
			loadv_postscript="";
			loadv_outname="";
			loadv_lenspict="";

			hunk=100;
			while(hunk>=100){
				hunk=read_int(io);
				switch(hunk){
				case 0:
					break;
				case 2301:
					v_girtdirect=read_int(io);	setsafevalue(c_girtdirect,v_girtdirect);
					break;
				case 104:
					v_gi=read_int(io);			setsafevalue(c_gi,v_gi);
					v_gicaustics=read_int(io);	setsafevalue(c_gicaustics,v_gicaustics);
					v_giirrgrad=read_int(io);		setsafevalue(c_giirrgrad,v_giirrgrad);
					v_gipmmode=read_int(io);		setsafevalue(c_gipmmode,v_gipmmode);
					break;
				case 201:
					v_lg=read_int(io);			setsafevalue(c_lg,v_lg);
					break;
				case 301:
					v_pl=read_int(io);			setsafevalue(c_pl,v_pl);
					break;
				case 403:
					v_shgi=read_int(io);			
					if (v_shgi){
						v_shgi=3;			setsafevalue(c_shgi,v_shgi);
					}
					v_giload=read_line(io);
					if (!v_giload){
						v_giload="";				
					}					setsafevalue(c_giload,v_giload);
					v_ginew=read_int(io);		setsafevalue(c_ginew,v_ginew);
					break;
				case 504:
					v_outname=read_line(io);			
					if (!v_outname){
						v_outname="";
					}					setsafevalue(c_outname,v_outname);
					v_outfmt=read_int(io);		setsafevalue(c_outfmt,v_outfmt);
					v_outparam=read_number(io);		setsafevalue(c_outparam,v_outparam);
					v_outexp=read_number(io);		setsafevalue(c_outexp,v_outexp);
					v_tmo=2;				setsafevalue(c_tmo,v_tmo);
					v_tmhsv=0;				setsafevalue(c_tmhsv,v_tmhsv);
					break;
				case 502:
					v_outname=read_line(io);			
					if (!v_outname){
						v_outname="";
					}					setsafevalue(c_outname,v_outname);
					v_outfmt=read_int(io);		setsafevalue(c_outfmt,v_outfmt);
					break;
				case 501:	// old popup format
					v_outfmt=read_int(io);
					
					if (v_outfmt==1){
						v_outfmt=9;
					}else if (v_outfmt==3){
						v_outfmt=7;
					}else if (v_outfmt==4){
						v_outfmt=1;
					}else if (v_outfmt==5){
						v_outfmt=2;
					}else if (v_outfmt==6){
						v_outfmt=5;
					}else{
						v_outfmt=3;
					}
				
					setsafevalue(c_outfmt,v_outfmt);
				break;
				case 4301:
					v_outfmt=read_int(io);		setsafevalue(c_outfmt,v_outfmt);
				break;

				case 602:
					v_prep=read_number(io);		setsafevalue(c_prep,v_prep);
					v_pxlordr=read_int(io);		setsafevalue(c_pxlordr,v_pxlordr);
					break;
				case 702:
					v_underf=read_int(io);		setsafevalue(c_underf,v_underf);
					v_undert=read_number(io);		setsafevalue(c_undert,v_undert);
					break;
				case 802:
					v_areavis=read_int(io);		setsafevalue(c_areavis,v_areavis);
					v_areaside=read_int(io);		setsafevalue(c_areaside,v_areaside);
					break;
				case 902:   // compatibility (ignore input gamma)
					read_line(io);
					read_line(io);
					break;

					// lights & camera

				case 1003:
					v_planth=read_number(io);		setsafevalue(c_planth,v_planth);
					v_planrmin=read_int(io);		setsafevalue(c_planrmin,v_planrmin);
					v_planrmax=read_int(io);		setsafevalue(c_planrmax,v_planrmax);
					break;
				case 2103:
					v_llinth=read_number(io);		setsafevalue(c_llinth,v_llinth);
					v_llinrmin=read_int(io);		setsafevalue(c_llinrmin,v_llinrmin);
					v_llinrmax=read_int(io);		setsafevalue(c_llinrmax,v_llinrmax);
					break;
				case 1103:
					v_lumith=read_number(io);		setsafevalue(c_lumith,v_lumith);
					v_lumirmin=read_int(io);		setsafevalue(c_lumirmin,v_lumirmin);
					v_lumirmax=read_int(io);		setsafevalue(c_lumirmax,v_lumirmax);
					break;
					
				case 2402: //baking camera object and uv
					v_camobject=read_int(io);  //read baking object id?
					v_camuvname=read_line(io); //read uv map name

					count=2;
					
					vmapObj = Mesh();
					while(vmapObj){
						if (vmapObj.id==v_camobject){
							setsafevalue(c_camobject,count);
						}
						vmapObj = vmapObj.next();
						count++;
					}
					
					count=2;

					vmapObj = VMap(VMTEXTURE);
					while(vmapObj){
						if (vmapObj.type == VMTEXTURE){
							if (vmapObj.name==v_camuvname){
								setsafevalue(c_camuvname,count);
							}
							count++;
						}
						vmapObj = vmapObj.next();
					}
					break;
					
				case 1301:
					v_cptype=read_int(io);		setsafevalue(c_cptype,v_cptype);
					break;
				case 1401:
					loadv_lenspict=loadv_lenspict+read_line(io);	setsafevalue(c_lenspict,loadv_lenspict);
					v_lenspict=loadv_lenspict;
					break;
					
				case 1501: //DoF target object name
					v_dofobj=read_line(io); //read DoF target object name
					
					count=2;
					meshObj = Mesh();
					while(meshObj){
						if (meshObj.name==v_dofobj) //if object name exist in scene
						{
							setsafevalue(c_dofobj,count);		//set dof item index
						}
						meshObj = meshObj.next();
						count++;
					}
					break;
					
				case 1603:
					v_cstocvar=read_number(io);		setsafevalue(c_cstocvar,v_cstocvar);
					v_cstocmin=read_int(io);		setsafevalue(c_cstocmax,v_cstocmax);
					v_cstocmax=read_int(io);		setsafevalue(c_cstocmin,v_cstocmin);
					break;
				case 1701:  // compatibility
					v_aafscreen=read_int(io);		setsafevalue(c_aafscreen,v_aafscreen);
					break;
				case 1803:  // compatibility
					v_aatype=read_int(io);		setsafevalue(c_aatype,v_aatype);
					v_aafscreen=read_int(io);		setsafevalue(c_aafscreen,v_aafscreen);
					v_aargsmpl=read_int(io);		setsafevalue(c_aarandsmpl,v_aarandsmpl);
					break;
				case 1804:
					v_aatype=read_int(io);		setsafevalue(c_aatype,v_aatype);
					v_aafscreen=read_int(io);		setsafevalue(c_aafscreen,v_aafscreen);
					v_aargsmpl=read_int(io);		setsafevalue(c_aargsmpl,v_aargsmpl);
					v_aagridrotate=read_int(io);	setsafevalue(c_aagridrotate,v_aagridrotate);
					break;
				case 1805:  // compatibility
					v_aatype=read_int(io);		setsafevalue(c_aatype,v_aatype);
					v_edgeabs=read_number(io);		setsafevalue(c_edgeabs,v_edgeabs);
					v_edgerel=0;					setsafevalue(c_edgerel,v_edgerel);
					v_edgenorm=0;					setsafevalue(c_edgenorm,v_edgenorm);
					v_edgezbuf=0;					setsafevalue(c_edgezbuf,v_edgezbuf);
					v_edgeup=0;						setsafevalue(c_edgeup,v_edgeup);
					v_edgethick=1;					setsafevalue(c_edgethick,v_edgethick);
					v_edgeover=1;					setsafevalue(c_edgeover,v_edgeover);

					if (v_aatype==3){   // Adaptive
						v_aatype=2;					setsafevalue(c_aatype,v_aatype);
					}								
					if (v_aatype==4){   // Stochastic
						v_aatype=3;					setsafevalue(c_aatype,v_aatype);
					}								
					if (v_aatype==5){   // Enhanced regular grid
						v_aatype=2;					setsafevalue(c_aatype,v_aatype);
						v_edgethick=2;					setsafevalue(c_edgethick,v_edgethick);
					}
					if (v_aatype==6){   // Enhanced adaptive
						v_aatype=2;					setsafevalue(c_aatype,v_aatype);
						v_edgethick=2;					setsafevalue(c_edgethick,v_edgethick);
					}
					if (v_aatype==7){   // Enhanced stochastic
						v_aatype=3;					setsafevalue(c_aatype,v_aatype);
						v_edgethick=2;					setsafevalue(c_edgethick,v_edgethick);
					}

					v_aargsmpl=read_int(io);		setsafevalue(c_aargsmpl,v_aargsmpl);
					read_int(io);
					read_int(io);
					break;
				case 1901:
					v_refrmin=read_int(io);		setsafevalue(c_refrmin,v_refrmin);
					v_refrmax=0;					setsafevalue(c_refrmax,v_refrmax);
					v_refth=0;						setsafevalue(c_refth,v_refth);
					break;
				case 1903:
					v_refth=read_number(io);		setsafevalue(c_refth,v_refth);
					v_refrmin=read_int(io);		setsafevalue(c_refrmin,v_refrmin);
					v_refrmax=read_int(io);		setsafevalue(c_refrmax,v_refrmax);
					break;
				case 2002:
					v_prescript=read_line(io);	setsafevalue(c_prescript,v_prescript);
					v_postscript=read_line(io);	setsafevalue(c_postscript,v_postscript);
					break;
				case 2101:
					v_autolumi=read_number(io);	setsafevalue(c_autolumi,v_autolumi);
					break;
				case 2201:	// backwards compatibility
					v_octdepth=read_int(io);
					if (v_octdepth<20){
						v_octdepth=2;
					}else if(v_octdepth>60){
						v_octdepth=4;
					}else{
						v_octdepth=3;
					}
					setsafevalue(c_octdepth,v_octdepth);
					break;
				case 2502:
					v_ovrsfc=read_int(io);
					if (v_ovrsfc>0){
						v_ovrsfc=0;					
					}								setsafevalue(c_ovrsfc,v_ovrsfc);
					v_ovrsfcolor=read_vector(io);	setsafevalue(c_ovrsfcolor,(v_ovrsfcolor/255));
					break;
				case 2601:
					v_conetoarea=read_int(io);		setsafevalue(c_conetoarea,v_conetoarea);
					break;
				case 2707:
					v_edgeabs=read_number(io);		setsafevalue(c_edgeabs,v_edgeabs);
					v_edgerel=read_number(io);		setsafevalue(c_edgerel,v_edgerel);
					v_edgenorm=read_number(io);		setsafevalue(c_edgenorm,v_edgenorm);
					v_edgezbuf=read_number(io);		setsafevalue(c_edgezbuf,v_edgezbuf);
					v_edgeup=read_int(io);		setsafevalue(c_edgeup,v_edgeup);
					v_edgethick=read_int(io);		setsafevalue(c_edgethick,v_edgethick);
					v_edgeover=read_number(io);		setsafevalue(c_edgeover,v_edgeover);
					break;
				case 2802:
					v_pxlfltr=read_int(io);		setsafevalue(c_pxlfltr,v_pxlfltr);
					v_pxlparam=read_number(io);		setsafevalue(c_pxlparam,v_pxlparam);
					break;
				case 2901:
					v_refacth=read_number(io);		setsafevalue(c_refacth,v_refacth);
					break;
				case 3004:
					v_tmo=read_number(io);		setsafevalue(c_tmo,v_tmo);
					v_tmhsv=read_number(io);		setsafevalue(c_tmhsv,v_tmhsv);
					v_outparam=read_number(io);		setsafevalue(c_outparam,v_outparam);
					v_outexp=read_number(io);		setsafevalue(c_outexp,v_outexp);
					break;
				case 3101:
					v_aarandsmpl=read_number(io);	setsafevalue(c_aarandsmpl,v_aarandsmpl);
					break;
				case 3207:
					v_shgi=read_int(io);		setsafevalue(c_shgi,v_shgi);
					v_giload=read_line(io);
					if (!v_giload){
						v_giload="";
					}					setsafevalue(c_giload,v_giload);
					v_ginew=read_int(io);		setsafevalue(c_ginew,v_ginew);
					v_tiphotons=read_int(io);		setsafevalue(c_tiphotons,v_tiphotons);
					v_tifg=read_int(io);		setsafevalue(c_tifg,v_tifg);
					v_tiframes=read_int(io);		setsafevalue(c_tiframes,v_tiframes);
					v_tiextinction=read_number(io);	setsafevalue(c_tiextinction,v_tiextinction);
					break;
				case 3301:
					loadv_prescript=loadv_prescript+read_line(io);
					break;
				case 3401:
					loadv_postscript=loadv_postscript+read_line(io);
					break;
				case 3501:
					loadv_outname=loadv_outname+read_line(io);	setsafevalue(c_outname,loadv_outname);
					v_outname=loadv_outname;
					break;
				case 3605:
					v_gph_preset=read_int(io);			setsafevalue(c_gph_preset,v_gph_preset);
					v_cph_preset=read_int(io);			setsafevalue(c_cph_preset,v_cph_preset);
					v_fg_preset=read_int(io);			setsafevalue(c_fg_preset,v_fg_preset);
					v_aa_preset=read_int(io);			setsafevalue(c_aa_preset,v_aa_preset);
					v_quality_preset=read_int(io);		setsafevalue(c_quality_preset,v_quality_preset);
					break;
				case 3701:
					v_cmbsubframes=read_int(io);		setsafevalue(c_cmbsubframes,v_cmbsubframes);
					break;             
				case 3801:
					v_refmodel=read_number(io);			setsafevalue(c_refmodel,v_refmodel);
					break;
				case 3901:
					create_flag=read_number(io);
					break;
				case 4001:
					v_octdepth=read_int(io);			setsafevalue(c_octdepth,v_octdepth);
					break;
				case 4101:
					v_output_On=read_int(io);			setsafevalue(c_output_On,v_output_On);
					break;
				case 4201:
					v_errode=read_int(io);				setsafevalue(c_errode,v_errode);
					break;
				case 4303:
					v_eyesep=read_number(io);			setsafevalue(c_eyesep,v_eyesep);
					v_stereoimages=read_int(io);		setsafevalue(c_stereoimages,v_stereoimages);
					v_render0=read_int(io);				setsafevalue(c_render0,v_render0);
					break;
				case 4411:
					v_LogOn=read_number(io);			setsafevalue(c_LogOn,v_LogOn);
					v_Logfile=read_line(io);			setsafevalue(c_Logfile,v_Logfile);				
					v_Debug=read_number(io);			setsafevalue(c_Debug,v_Debug);
					v_InfoOn=read_number(io);			setsafevalue(c_InfoOn,v_InfoOn);
					v_InfoText=read_line(io);			setsafevalue(c_InfoText,v_InfoText);
					v_IncludeOn=read_number(io);		setsafevalue(c_IncludeOn,v_IncludeOn);
					v_IncludeFile=read_line(io);		setsafevalue(c_IncludeFile,v_IncludeFile);
					v_FullPrev=read_number(io);			setsafevalue(c_FullPrev,v_FullPrev);
					v_Finishclose=read_number(io);		setsafevalue(c_Finishclose,v_Finishclose);
					v_UBRAGI=read_number(io);			setsafevalue(c_UBRAGI,v_UBRAGI);
					v_outputtolw=read_number(io);		setsafevalue(c_outputtolw,v_outputtolw);
					break;
				default:
					hunk_len=hunk%100;
					for (skip=0 ; skip<hunk_len ; skip++){
						s=read_line(io);
					}
					break;
				}

				v_prescript=loadv_prescript;
				v_postscript=loadv_postscript;
				setsafevalue(c_prescript,v_prescript);
				setsafevalue(c_postscript,v_postscript);
			}
		}else{
			safe_warn("Bad file version.");
		}
	}
	load_settings_accuracy: io{
	    text=read_line(io); // AccuracyBegin text
	    
	    if (strright(text,13)=="AccuracyBegin"){
		test_version=read_int(io);
		if (test_version>=1000){
		    if (test_version>version){
				safe_warn("Accuracy settings were saved with newer version of Kray plugin.<br>Some features are not available and their settings will be lost if you save the file.");
		    }

		    hunk=100;

		    while(hunk>=100){
			hunk=read_int(io);
			switch(hunk){
			    case 0:
			    break;
			    case 100001:
					v_gir=read_number(io);			setsafevalue(c_gir,v_gir);
			    break;
			    case 100003:    // backwards compatibility
					v_gir=read_number(io);			setsafevalue(c_gir,v_gir);
					v_fgrmin=read_int(io);			setsafevalue(c_fgrmin,v_fgrmin);
					v_fgrmax=0;							setsafevalue(c_fgrmax,v_fgrmax);
					v_fgth=0;							setsafevalue(c_fgth,v_fgth);
					v_fga=read_number(io);			setsafevalue(c_fga,v_fga);
					v_fgb=v_fga*180;					setsafevalue(c_fgb,v_fgb);
			    break;
			    case 100105:
					v_cf=read_int(io);				setsafevalue(c_cf,v_cf);
					v_cn=read_int(io);				setsafevalue(c_cn,v_cn);
					v_cpstart=read_number(io);		setsafevalue(c_cpstart,v_cpstart);
					v_cpstop=read_number(io);			setsafevalue(c_cpstop,v_cpstop);
					v_cpstep=read_int(io);			setsafevalue(c_cpstep,v_cpstep);
			    break;
			    case 100205:
					v_gf=read_int(io);				setsafevalue(c_gf,v_gf);
					v_gn=read_int(io);				setsafevalue(c_gn,v_gn);
					v_gpstart=read_number(io);		setsafevalue(c_gpstart,v_gpstart);
					v_gpstop=read_number(io);			setsafevalue(c_gpstop,v_gpstop);
					v_gpstep=read_int(io);			setsafevalue(c_gpstep,v_gpstep);
			    break;
			    case 100301:
					v_ppsize=read_number(io);			setsafevalue(c_ppsize,v_ppsize);
			    break;
			    case 100305:    // compatibility
					read_int(io);	
					v_ppsize=0.5;						setsafevalue(c_ppsize,v_ppsize);
					read_int(io);
					read_int(io);
					read_int(io);
					read_int(io);
			    break;
			    case 100407:
					v_fgmin=read_number(io);		setsafevalue(c_fgmin,v_fgmin);
					v_fgmax=read_number(io);		setsafevalue(c_fgmax,v_fgmax);
					v_fgscale=read_number(io);		
					read_line(io);							
					read_line(io);							
					v_fgshows=read_int(io);			setsafevalue(c_fgshows,v_fgshows);
					v_fgsclr=read_vector(io);		setsafevalue(c_fgsclr,(v_fgsclr/255));
			    break;
			    case 100406:
					v_fgmin=read_number(io);		setsafevalue(c_fgmin,v_fgmin);
					v_fgmax=read_number(io);		setsafevalue(c_fgmax,v_fgmax);
					v_fgscale=read_number(io);		setsafevalue(c_fgscale,v_fgscale);
					read_line(io);
					v_fgshows=read_int(io);			setsafevalue(c_fgshows,v_fgshows);
					v_fgsclr=read_vector(io);		setsafevalue(c_fgsclr,(v_fgsclr/255));
			    break;
			    case 100405:
					v_fgmin=read_number(io);		setsafevalue(c_fgmin,v_fgmin);
					v_fgmax=read_number(io);		setsafevalue(c_fgmax,v_fgmax);
					v_fgscale=read_number(io);		setsafevalue(c_fgscale,v_fgscale);
					v_fgshows=read_int(io);			setsafevalue(c_fgshows,v_fgshows);
					v_fgsclr=read_vector(io);		setsafevalue(c_fgsclr,(v_fgsclr/255));
			    break;
			    case 100502:
					v_cornerdist=read_number(io);	setsafevalue(c_cornerdist,v_cornerdist);
					v_cornerpaths=read_int(io);		setsafevalue(c_cornerpaths,v_cornerpaths);
			    break;
			    case 100503:    // compatibility
					ison=read_int(io);				
					v_cornerdist=read_number(io);	setsafevalue(c_cornerdist,v_cornerdist);
					v_cornerpaths=read_int(io);		setsafevalue(c_cornerpaths,v_cornerpaths);
					if (!ison){
						v_cornerpaths=0;
					}								setsafevalue(c_cornerpaths,v_cornerpaths);
			    break;
			    case 100601:
				v_girauto=read_int(io);			setsafevalue(c_girauto,v_girauto);
					break;
			    case 100704:
					v_cmatic=read_int(io);			setsafevalue(c_cmatic,v_cmatic);
					v_clow=read_number(io);			setsafevalue(c_clow,v_clow);
					v_chigh=read_number(io);		setsafevalue(c_chigh,v_chigh);
					v_cdyn=read_number(io);			setsafevalue(c_cdyn,v_cdyn);
			    break;
			    case 100804:
					v_gmatic=read_int(io);			setsafevalue(c_gmatic,v_gmatic);
					v_glow=read_number(io);			setsafevalue(c_glow,v_glow);
					v_ghigh=read_number(io);		setsafevalue(c_ghigh,v_ghigh);
					v_gdyn=read_number(io);			setsafevalue(c_gdyn,v_gdyn);
			    break;
			    case 100901:
					v_cfunit=read_int(io);			setsafevalue(c_cfunit,v_cfunit);
			    break;
			    case 101001:
					v_gfunit=read_int(io);			setsafevalue(c_gfunit,v_gfunit);
			    break;
			    case 101102:
					v_fgreflections=read_number(io);	setsafevalue(c_fgreflections,v_fgreflections);
					v_fgrefractions=read_int(io);		setsafevalue(c_fgrefractions,v_fgrefractions);
			    break;
			    case 101201:
					v_gmode=read_int(io);				setsafevalue(c_gmode,v_gmode);
			    break;
			    case 101301:
					v_ppcaustics=read_int(io);		setsafevalue(c_ppcaustics,v_ppcaustics);
			    break;
			    case 101403:
					v_fgrmin=read_int(io);			setsafevalue(c_fgrmin,v_fgrmin);
					v_fgrmax=read_int(io);			setsafevalue(c_fgrmax,v_fgrmax);
					v_fgth=read_number(io);			setsafevalue(c_fgth,v_fgth);
			    break;
			    case 101502:
					v_fga=read_number(io);			setsafevalue(c_fga,v_fga);
					v_fgb=read_number(io);			setsafevalue(c_fgb,v_fgb);
			    break;
			    case 101601:
					v_ppmult=read_number(io);		setsafevalue(c_ppmult,v_ppmult);
			    break;
			    case 101701:
					v_cmult=read_number(io);		setsafevalue(c_cmult,v_cmult);
			    break;
			    case 101801:
					v_ppblur=read_number(io);		setsafevalue(c_ppblur,v_ppblur);
			    break;
			    case 101901:
					v_fgblur=read_number(io);		setsafevalue(c_fgblur,v_fgblur);
			    break;
			    case 102001:
					v_showphotons=read_number(io);		setsafevalue(c_showphotons,v_showphotons);
			    break;
			    case 102101:	// old, wrong hunk, still here for compatibility with Kray.ls 1176 (2.0 RC2)
				    v_resetoct=read_number(io);		setsafevalue(c_resetoct,v_resetoct);
				    v_limitdr=read_number(io);		setsafevalue(c_limitdr,v_limitdr);
			    break;
			    case 102201:
				    v_resetoct=read_number(io);		setsafevalue(c_resetoct,v_resetoct);
			    break;
			    case 102301:
				    v_limitdr=read_number(io);		setsafevalue(c_limitdr,v_limitdr);
				break;
				case 102403:
					v_prestep=read_number(io);		setsafevalue(c_prestep,v_prestep);
					v_preSplDet=read_number(io);	setsafevalue(c_preSplDet,v_preSplDet);
					v_gradNeighbour=read_number(io);	setsafevalue(c_gradNeighbour,v_gradNeighbour);
				break;
			    default:
					hunk_len=hunk%100;
					for (skip=0 ; skip<hunk_len ; skip++){
						s=read_line(io);
					}
			    break;
			}
		    }
		}else{
		    error("Kray accuracy settings - bad version number.");
		}
		read_line(io);  // AcEnd
	    }else{
		error("Not an accuracy file.");
	    }
	}

//Save krayscript file temp scene
	save_krayscript_file:krayfile,temp_scene{
	    if (temp_scene==""){
			krayfile.writeln("KrayScriptLWSInlined -2000;");
	    }
	    krayfile.writeln("echo '*** Kray script generated by Kray plugin for LightWave';");
		krayfile.writeln("threads 0;");

		if (!Scene().renderopts[1] || !Scene().renderopts[2] || !Scene().renderopts[3]){
			list=renderOptsList();
			
			krayfile.writeln("echo '!** Render global "+list+" is OFF';");		
		}
		if (Light().ambient(0)>0){
			krayfile.writeln("echo '!** AMBIENT light is on';");		
		}

	    krayfile.writeln("var pi,3.14159265;");
		// precached photon map
		    krayfile.writeln("var __ppscale,1.2;");
		    krayfile.writeln("var __ppstep,0;");
		    krayfile.writeln("var __ppstop,0;");
		    krayfile.writeln("var __precacheN,1;");
		// blend model
		    krayfile.writeln("var __blendss,0;");
		// irradiance gradients constants
		    krayfile.writeln("var __irr_elip,4;");
		// autophotons
		    krayfile.writeln("var __autogsamples,100;");
		    krayfile.writeln("var __autogscale,1;");
		    krayfile.writeln("var __autocsamples,100;");
		    krayfile.writeln("var __autocscale,1;");
		// auto gir size
		    krayfile.writeln("var __autogradients,0.5;");
		    krayfile.writeln("var __autocaustics,0.5;");
		    krayfile.writeln("var __autoprecached,0.5;");
		    krayfile.writeln("var __light_model,1;");
		    krayfile.writeln("var __undersample_edge,1;");
		    
		    krayfile.writeln("var __caustics_try,0.3;");
		    
		    krayfile.writeln("var __oversample,0.5;");
			
			krayfile.writeln("var __importflags,0;");

			//START variables for renderinfo
			MyScene = Scene();
			
			//scenefile = string(MyScene.name);
			//krayfile.writeln("formatstring scenename,'" + scenefile + "';");
			
			frame = 1;
			currentCam = MyScene.renderCamera(frame);
			mycamera = string(currentCam.name);
			
			krayfile.writeln("formatstring camera,"+mycamera+";");
			
			krayfile.writeln("var fgth,"+v_fgth+";");
			krayfile.writeln("var fgrmin,"+v_fgrmin+";");
			krayfile.writeln("var fgrmax,"+v_fgrmax+";");
			krayfile.writeln("var fga,"+v_fga+";");
			krayfile.writeln("var fgb,"+v_fgb+";");
			krayfile.writeln("var fgmin,"+v_fgmin+";");
			krayfile.writeln("var fgmax,"+v_fgmax+";");
			krayfile.writeln("var fgscale,"+v_fgscale+";");
			krayfile.writeln("var fgblur,"+v_fgblur+";");
			krayfile.writeln("var fgreflections,"+v_fgreflections+";");
			krayfile.writeln("var fgrefractions,"+v_fgrefractions+";");

			krayfile.writeln("var cornerdist,"+v_cornerdist+";");
			krayfile.writeln("var cornerpaths,"+v_cornerpaths+";");
			
			krayfile.writeln("var prep,"+v_prep+";");
			krayfile.writeln("var prestep,"+v_prestep+";");
			krayfile.writeln("var preSplDet,"+v_preSplDet+";");
			krayfile.writeln("var gradNeighbour,"+v_gradNeighbour+";");
		
		    if (temp_scene==""){
				krayfile.writeln("end;");
				krayfile.writeln("KrayScriptLWSInlined -1000;");
			}

			krayfile.writeln("savegimode 1;cam_singleside 0;previewsize 1200,600;usemultipass 0;lwo2rayslimit 1,0.9;animmode 1;about;");
			krayfile.writeln("addpathlw;addpath \""+getdir(CONTENTDIR)+"\";");	// for standalone Kray
			
		    krayfile.writeln("multiline 'Header commands';");
		    mlsize=size(v_prescript);
		    for (a=1 ; a<=mlsize ; a+=maxlinelength){
				t=a+maxlinelength;
				if (t>(mlsize+1)){
					t=mlsize+1;
				}
				t=-a+t;
				krayfile.writeln(strsub(v_prescript,a,t));
		    }
		    krayfile.writeln(";");
		    krayfile.writeln("end_of_multiline;");

		    // general options

		    vp_gi=0;

		    switch(v_gi){
			case 1: // local
			    if (v_gicaustics){
				vp_gi+=1;
			    }
			break;
			case 2: // estimate
			    if (v_gipmmode==1){
					vp_gi=10000;
			    }
			    if (v_gipmmode==2){
					vp_gi=10002;
			    }
			    if (v_gipmmode==3){
					vp_gi=11000;
			    }
			    if (v_gipmmode==4){
					if (v_girtdirect){
					    if (v_gicaustics){
						vp_gi=12013;
					    }else{
						vp_gi=12012;
					    }
					}else{
					    vp_gi=11010;
					}
			    }
			break;
			case 3: // photonmapping
			    vp_gi=photon_map_model;
			    if (v_gicaustics){
					vp_gi+=1;
			    }
			    if (v_giirrgrad){
					vp_gi+=1000;
			    }
			break;
			case 4: // path tracing
			    vp_gi=40000;
			    if (v_gicaustics){
					vp_gi+=1;
			    }
			    if (v_giirrgrad){
					vp_gi+=1000;
			    }
			break;
		    }

		    fgtraceflag=0;
		    if (!v_fgreflections){
				fgtraceflag=4;
		    }
		    if (!v_fgrefractions){
				fgtraceflag=fgtraceflag+8;
		    }

		    krayfile.writeln("lwo2import "+vp_gi+",__light_model,(2-"+v_areavis);	
		    krayfile.writeln("),"+v_refmodel+","+fgtraceflag+"+__blendss|__importflags;");
		    krayfile.writeln("lwo2bluroptions "+v_refrmin+","+v_refrmax+","+v_refth+","+v_refacth+";");
		    krayfile.writeln("lwconetoarea "+v_conetoarea+";");
		    
		    if (v_lg==1){
				krayfile.writeln("lwpassiveset2;");
				if ((v_gi==1 || v_gi==4) && v_gicaustics==0){
				    krayfile.writeln("lumi_minsamples 0;");
				}
		    }else if (v_lg==3){
				krayfile.writeln("autopassive "+v_autolumi+";");
		    }
			
			if (v_output_On && !v_render0){
				krayfile.writeln("multiline 'Output filename';");
				krayfile.writeln("outputto '");
				mlsize=size(v_outname);
				for (a=1 ; a<=mlsize ; a+=maxlinelength){
					t=a+maxlinelength;
					if (t>(mlsize+1)){
						t=mlsize+1;
					}
					t=-a+t;
					krayfile.writeln(strsub(v_outname,a,t));
				}
				krayfile.writeln("';");
			
				krayfile.writeln("end_of_multiline;");
			}
			
		    if (mlsize==0 || !v_output_On){		// add alpha buffer if filename is none
				krayfile.writeln("outputtolw 1;");				
				krayfile.writeln("needbuffers 0+0x1+0x2;");
		    }
			
		    switch(v_outfmt){
				case 1:
					krayfile.writeln("outputformat hdr;");
				break;
				case 2:
					krayfile.writeln("outputformat jpg,100;");
				break;
				case 3:
					krayfile.writeln("outputformat png;");
				break;
				case 4:
					krayfile.writeln("needbuffers 0+0x1+0x2;");
					krayfile.writeln("outputformat pnga;");
				break;
				case 5:
					krayfile.writeln("outputformat tif;");
				break;
				case 6:
					krayfile.writeln("needbuffers 0+0x1+0x2;");
					krayfile.writeln("outputformat tifa;");
				break;
				case 7:
					krayfile.writeln("outputformat tga;");
				break;
				case 8:
					krayfile.writeln("needbuffers 0+0x1+0x2;");
					krayfile.writeln("outputformat tgaa;");
				break;
				case 9:
					krayfile.writeln("outputformat bmp;");
				break;
				case 10:
					krayfile.writeln("needbuffers 0+0x1+0x2;");
					krayfile.writeln("outputformat bmpa;");
				break;
		    }
			if(v_limitdr==2){
				krayfile.writeln("limitdr 1;");
				krayfile.writeln("echo '*** Limiting dynamic range before tonemap';");
			}

			switch(v_tmo){
				case 1:
					tmp="linear";
				break;
				case 2:
					if (v_tmhsv){
						tmp="v_gamma_exposure,"+v_outparam+","+v_outexp;
					}else{
						tmp="gamma_exposure,"+v_outparam+","+v_outexp;
					}
				break;
				case 3:
					if (v_tmhsv){
						tmp="v_exp_exposure,"+v_outparam+","+v_outexp;
					}else{
						tmp="exp_exposure,"+v_outparam+","+v_outexp;
					}
				break;
			}

			krayfile.writeln("tonemapper "+tmp+";");
			
			if (v_limitdr==3){
				krayfile.writeln("postprocess tonemapper,reverse,"+tmp+";");
				krayfile.writeln("postviewtonemapper "+tmp+";");
			}
			
			if (v_outfmt!=1){
				krayfile.writeln("dither fs;");
			}
		    
		    if (temp_scene==""){
				krayfile.writeln("end;");
				krayfile.writeln("KrayScriptLWSInlined 1000;");
		    }else{
				krayfile.writeln("lwsload \""+temp_scene+"\";");
		    }

		    krayfile.writeln("square_lights (2-"+v_pl+"),"+v_areaside+";");

		    if (v_shgi==2){
				cb=v_tiextinction;
				if (cb<0) cb=0;
				if (cb>1) cb=1;

				frames=v_tiframes;
				if (frames<0) frames=0;
				fparam=frames;
				if (fparam<1) fparam=1;
				
				ca=(1-cb)/(frames+1);

				if (ca!=1){
				    if (v_tiphotons){
						krayfile.writeln("timeprecached "+fparam+","+ca);

						if (frames==0){
						    krayfile.writeln(",0,"+cb);
						}else{
						    krayfile.writeln(","+ca+","+cb);
						}

						for (loop=1 ; loop<frames ; loop++){
						    krayfile.writeln(","+ca+",0");
						}

						krayfile.writeln(";");
					}
					if (v_tifg){
						krayfile.writeln("timegradients "+fparam+","+ca);

						if (frames==0){
						    krayfile.writeln(",0,"+cb);
						}else{
						    krayfile.writeln(","+ca+","+cb);
						}

						for (loop=1 ; loop<frames ; loop++){
						    krayfile.writeln(","+ca+",0");
						}

						krayfile.writeln(";");
					}
				}
		    }else if (v_shgi==3){
				krayfile.writeln("resetgi 0;");
				krayfile.writeln("resetoct "+v_resetoct+";");
				krayfile.writeln("lmanim;");
				if (v_render0){
						krayfile.writeln("render 0;");
				}
				if (v_giload){
				    if (v_ginew&1){
						krayfile.writeln("loadgis \""+v_giload+"\";");
				    }
				    if (v_ginew&2){
						krayfile.writeln("savegis \""+v_giload+"\";");
				    }
				}

		    }
		    if (v_single){
				krayfile.writeln("singleframe;");
		    }

		    switch(v_pxlordr){
			case 1:
			    krayfile.writeln("splitscreen betterauto;pixelorder scanline;");
			break;
			case 2:
			    krayfile.writeln("splitscreen betterauto;pixelorder scanrow;");
			break;
			case 3:
			    krayfile.writeln("splitscreen none;pixelorder random;");
			break;
			case 4:
				krayfile.writeln("undersampleprerender 1;pixelorder scanline;");
				if (v_underf==1){
				    krayfile.writeln("undersample 1,0,0;");
				}
			break;
			case 5:
			    krayfile.writeln("splitscreen none;pixelorder worm;");
			break;
			case 6:
			    krayfile.writeln("splitscreen none;pixelorder frost;");
			break;
		    }
			if(v_limitdr==1){
				krayfile.writeln("limitdr 1;");
				krayfile.writeln("echo '*** Limiting dynamic range after tonemap';");
			}
			
		    krayfile.writeln("prerender prep,prestep,preSplDet; gradients_neighbour gradNeighbour;");

		    if (v_underf>1){
				if (v_fgshows==1 || !v_giirrgrad){
				    krayfile.writeln("undersample ("+v_underf+"-1),"+v_undert+",__undersample_edge;");
				}
		    }

		    krayfile.writeln("linadaptive "+v_llinth+","+v_llinrmin+","+v_llinrmax+";");
		    krayfile.writeln("squareplanar "+v_planth+","+v_planrmin+","+v_planrmax+";");
		    krayfile.writeln("planar ("+v_lumith+"*"+v_lumith+"),"+v_lumirmin+","+v_lumirmax+";");

		    // accuracy settings

			switch(v_octdepth){
				case 1:	// very low
					krayfile.writeln("octree 25,22;var sep,2;var ds,4;var fs,0;");
				break;
				case 2:	// low
					krayfile.writeln("octree 30,17;var sep,0.7;var ds,2;var fs,0;");
				break;
				case 3:	// normal
					krayfile.writeln("octree 35,15;var sep,0.7;var ds,1;var fs,90;");
				break;
				case 4:	// high
					krayfile.writeln("octree 40,15;var sep,0.5;var ds,0.5;var fs,90;");
				break;
			}
			krayfile.writeln("octbuild sep,(ds*0.2,ds*1,ds*0.2),(fs*0.2,fs*1,fs*0.2);");
		    krayfile.writeln("outsidesize -1;");    // automatic

		    if (v_girauto){
				krayfile.writeln("var _gi_res,1;");
				krayfile.writeln("autophotons gscalegradients,__autogradients;");
				krayfile.writeln("autophotons gscalecaustics,__autocaustics;");
				krayfile.writeln("autophotons gscaleprecached,__autoprecached;");
		    }else{
				krayfile.writeln("var _gi_res,"+v_gir+";");
		    }
		    if (v_showphotons!=1){
				krayfile.writeln("showphotons 0;");
		    }	
		    tstop=0;
		    if (v_cpstep>1){
				tstop=v_cpstop;
		    }
		    tsign=1;
		    if (v_cfunit==2){
				tsign=-1;
		    }

		    krayfile.writeln("causticspm "+(v_cf*tsign)+","+v_cn+",_gi_res*"+v_cpstart+",");
		    krayfile.writeln("_gi_res*"+v_cpstop+","+v_cpstep+",__caustics_try;");

		    tstop=0;
		    if (v_gpstep>1){
				tstop=v_gpstop;
		    }
		    tsign=1;
		    if (v_gfunit==2){
				tsign=-1;
		    }

			if (v_gmode==1){
				krayfile.writeln("globalpm "+(v_gf*tsign)+","+v_gn+",_gi_res*"+v_gpstart+",");
				krayfile.writeln("_gi_res*"+tstop+","+v_gpstep+";");
			    }else{
					lmcaustics=0;
					if (v_gicaustics || v_gi==2){	// caustics enabled or estimate mode
						lmcaustics=v_ppcaustics;
					}
				krayfile.writeln("globallm "+(v_gf*tsign)+","+v_gn+",_gi_res*"+v_gpstart+",");
				krayfile.writeln("_gi_res*"+tstop+","+v_gpstep+","+lmcaustics+";");
		    }

		    krayfile.writeln("precachedpm _gi_res*__ppscale*"+v_ppsize+",_gi_res*__ppscale*__ppstop,");
		    krayfile.writeln("__ppstep,__precacheN,_gi_res*"+v_ppsize+";");
		    krayfile.writeln("precachedblur "+v_ppblur+";");
		    krayfile.writeln("globalmultiplier "+v_ppmult+";");
		    krayfile.writeln("causticsmultiplier "+v_cmult+";");

		    if (v_gmatic){
				krayfile.writeln("autophotons global,__autogsamples,"+v_glow+","+v_ghigh+","+v_gdyn+",__autogscale;");
		    }
		    if (v_cmatic){
				krayfile.writeln("autophotons caustics,__autocsamples,"+v_clow+","+v_chigh+","+v_cdyn+",");
				krayfile.writeln("__autocscale;");
		    }

		    krayfile.writeln("irradiancerays "+v_fgrmin+","+v_fgrmax+",1,"+v_fgth+"*"+v_fgth+";");

		    krayfile.writeln("pmcorner _gi_res*"+v_cornerdist+","+v_cornerpaths+";");

		    krayfile.writeln("gradients _gi_res*"+v_fgmax+","+v_fga+";");
		    krayfile.writeln("gradients2 _gi_res*"+v_fgmin+","+v_fgscale+";");
		    krayfile.writeln("gradients3 __oversample,"+v_fgb+"*pi/180;");
		    krayfile.writeln("gradients4 _gi_res*"+(v_fgmax*10)+",_gi_res*"+(v_fgmax*10)+",__irr_elip;");
		    krayfile.writeln("irradianceblur 0,1+sqr("+v_fgblur+");");

		    if (v_fgshows!=1){
				clr=v_fgsclr;
				clr=clr*100;
				r=dot3d(clr,<1,0,0>);
				g=dot3d(clr,<0,1,0>);
				b=dot3d(clr,<0,0,1>);
				if (v_fgshows==3){
					krayfile.writeln("showgisamples ("+(r/255)+","+(g/255)+","+(b/255)+");");
				}else{
					krayfile.writeln("showcornersamples ("+(r/255)+","+(g/255)+","+(b/255)+");");
				}
		    }

		    dof_active=Scene().renderopts[7];
		    mb_active=Scene().renderopts[6];

		    if (dof_active && !v_aafscreen){
				krayfile.writeln("echo '!!! Full screen AA is off. DOF disabled.';");
		    }

		    if (v_aatype==1){
				krayfile.writeln("imagesampler none;");
		    }else{
				if (v_aafscreen){
					if (v_aatype==2){
						if (v_aagridrotate){
							krayfile.writeln("imagesampler total_rot_uniform,"+v_aargsmpl+";");
						}else{
							krayfile.writeln("imagesampler total_uniform,"+v_aargsmpl+";");
						}
					}
					if (v_aatype==3){
						if (v_cstocmin>=v_cstocmax || v_cstocvar==0 || mb_active || dof_active){	// Added fix for FS#414 check if MB or DOF is on
							krayfile.writeln("imagesampler total_qmc,"+v_cstocmin+";");
						}else{
							krayfile.writeln("imagesampler total_qmcadaptive,"+v_cstocmin+","+v_cstocmax+","+v_cstocvar+";");
						}
					}
					if (v_aatype==4){
							if (mb_active){
								krayfile.writeln("imagesampler total_mb_random,"+v_aarandsmpl+","+v_cmbsubframes+";");
							}else{
								krayfile.writeln("imagesampler total_random,"+v_aarandsmpl+";");
							}
					}
				}else{
					if (v_aatype==2){
						if (v_aagridrotate){
							krayfile.writeln("imagesampler rot_uniform,"+v_aargsmpl+";");
						}else{
							krayfile.writeln("imagesampler uniform,"+v_aargsmpl+";");
						}
					}
					if (v_aatype==3){
						krayfile.writeln("imagesampler qmcadaptive,"+v_cstocmin+","+v_cstocmax+","+v_cstocvar+";");
					}
				}
		    }

			if (1){
				// edgedetector (deprecated but still working)
				krayfile.writeln("edgedetector "+v_edgeabs+","+v_edgerel+","+v_edgenorm+","+v_edgezbuf+",");
				krayfile.writeln(""+v_edgethick+","+v_edgeover+","+v_edgeup+";");
			}else{
				// edgedetector (new)
				krayfile.writeln("edgedetectorglobals "+v_edgethick+","+v_edgeup+";");
				krayfile.writeln("edgedetectorslot 0,"+v_edgeabs+","+v_edgerel+","+v_edgenorm+","+v_edgezbuf+",");
				krayfile.writeln(""+v_edgeover+";");
			}

		    // pixel filter
		    switch(v_pxlfltr){
			case 1:
			    krayfile.writeln("pixelfilter box,"+v_pxlparam+";");
			break;
			case 2:
			    krayfile.writeln("pixelfilter cone,"+v_pxlparam+";");
			break;
			case 3:
			    krayfile.writeln("pixelfilter cubic,"+v_pxlparam+";");
			break;
			case 4:
			    krayfile.writeln("pixelfilter quadric,"+v_pxlparam+";");
			break;
			case 5:
			    krayfile.writeln("pixelfilter lanczos,"+v_pxlparam+";");
			break;
			case 6:
			    krayfile.writeln("pixelfilter mitchell;");
			break;
			case 7:
			    krayfile.writeln("pixelfilter spline;");
			break;
			case 8:
			    krayfile.writeln("pixelfilter catmull;");
			break;
		    }

		    camera_write="";
		    switch(v_cptype){
				case 1:
				break;
				case 2:
					krayfile.writeln("lwcammode 1;");
				break;
				case 3:
					krayfile.writeln("lwcammode 4;");
				break;
				case 4:
					krayfile.writeln("lwcammode 3;");

						v_camobjectfile="";
					vmapObj = Mesh();
					while(vmapObj){
					if (vmapObj.id==v_camobject){
						v_camobjectfile=vmapObj.filename;
					}
					vmapObj = vmapObj.next();
					}

					krayfile.writeln("multiline 'TextureBaker';");
					krayfile.writeln("camera mesh,'");
					
					mlsize=size(v_camobjectfile);
					for (a=1 ; a<=mlsize ; a+=maxlinelength){
					t=a+maxlinelength;
					if (t>(mlsize+1)){
						t=mlsize+1;
					}
					t=-a+t;
					krayfile.writeln(strsub(v_camobjectfile,a,t));
					}           
					krayfile.writeln("',"+v_camobject+",'"+v_camuvname+"',0,0,(0,0,0),<>;");
					krayfile.writeln("end_of_multiline;");
				break;
				case 5:
					krayfile.writeln("lwcammode 8;camera stereo,0,0,0,(0,0,0),<>,"+v_eyesep+","+v_stereoimages+";");
				break;
		    }

		    if (v_lenspict!="" && dof_active){
				krayfile.writeln("echo '*** Loading lens bitmap';");
				krayfile.writeln("multiline 'LensImage';");
				krayfile.writeln("pixmap __lens_bitmap,'");
				
				mlsize=size(v_lenspict);
				for (a=1 ; a<=mlsize ; a+=maxlinelength){
					t=a+maxlinelength;
					if (t>(mlsize+1)){
					t=mlsize+1;
					}
					t=-a+t;
					krayfile.writeln(strsub(v_lenspict,a,t));
				}

				krayfile.writeln("',0;");
				krayfile.writeln("end_of_multiline;");
				krayfile.writeln("lensbitmap __lens_bitmap;");
		    }

		    index=-1;
		    count=1;

		    vmapObj = Mesh();
		    if (vmapObj != nil){
				while(vmapObj){
					if (string(vmapObj.name)==v_dofobj){
					index=vmapObj.id;
					}
					vmapObj = vmapObj.next();
					count++;
				}
		    }

		    if (index>=0){
				krayfile.writeln("lwdoftargetobject "+index+";");
		    }

		krayfile.writeln("remglobalpm 1;");
		krayfile.writeln("pmsidethreshold 0.5;");
	    krayfile.writeln("octcache 3;");
		v_errode = v_errode + (-1);
		krayfile.writeln("postprocess erode," +v_errode+ ";");
			

		if (v_LogOn){
			krayfile.writeln("logfile '" +v_Logfile+ "';");
		}
		if (v_Debug){
			krayfile.writeln("debug -1;");
		}
		if (v_InfoOn){
			krayfile.writeln("renderinfo '" +v_InfoText+ "';");
		}
		if (v_IncludeOn){
			krayfile.writeln("include '" +v_IncludeFile+ "';");
		}
		if (v_FullPrev){
			krayfile.writeln("previewsize 99999,99999;");
		}
		if (v_Finishclose){
			krayfile.writeln("finishclose;");
		}
		if (v_UBRAGI){
			krayfile.writeln("lwo2unseenbyrays_affectsgi 0;");
		}
		if (v_outputtolw){
			krayfile.writeln("outputtolw 1;");
		}

	    krayfile.writeln("multiline 'Tailer commands';");
		mlsize=size(v_postscript);
		mlsize=size(v_postscript);
	    for (a=1 ; a<=mlsize ; a+=maxlinelength){
			t=a+maxlinelength;
			if (t>(mlsize+1)){
				t=mlsize+1;
			}
			t=-a+t;
			krayfile.writeln(strsub(v_postscript,a,t));
	    }
	    krayfile.writeln(";");
	    krayfile.writeln("end_of_multiline;");
	    krayfile.writeln("end;");
	}
	save_krayscript:filename,temp_scene{
	    res=0;

	    krayfile = File(filename,"w");

	    if (krayfile){
			save_krayscript_file(krayfile,temp_scene);
			krayfile.close();
			res=1;
	    }else{
			res=0;
	    }

	    return res;
	}

	// Utilities
	file_exists : file{
		f=File(file,"r");

		res=0;
		
		if (f){
			res=1;
			f.close();
		}
		
		return res;
	}
	find_image : file{
		plugs=getdir("Plugins");

		running_script = split(SCRIPTID);

		if(running_script[1] != nil ){
			running_script_path = (running_script[1]) + (running_script[2]);
		}else{
			running_script_path = running_script[2];
		}
		if (!plugs){
			plugs=running_script_path;
		}

		if (file_exists(plugs+"/"+file)){
			return plugs+"/"+file;
		}
		if (file_exists(plugs+"/lscripts/"+file)){
			return plugs+"/lscripts/"+file;
		}
		if (file_exists(plugs+"/lscripts/kray/"+file)){
			return plugs+"/lscripts/kray/"+file;
		}
		if (file_exists(running_script_path+"/"+file)){
			return running_script_path+"/"+file;
		}
		
		return 0;
	}
	// GUI layout
	//
	// New proposed interface layout by Matt Gorner 02 August 2009
	//
	options{
	    if (reqisopen()){  // check if requester is already open then close it
			reqabort();
		}
		
	    if (create_flag==1 && reminders){
			check_exe_location();
			CheckRenderFlagsAndAmbient();
	    }
		
	    scene = Scene();

		// User Interface Layout Variables

		gad_x				= 0;								// Gadget X coord
		gad_y				= 24;								// Gadget Y coord
		gad_w				= 260;								// Gadget width
		gad_h				= 19;								// Gadget height
		gad_text_offset		= 100;								// Gadget text offset
		gad_prev_w			= 0;								// Previous gadget width temp variable

		ui_window_w			= 440;								// Window width
		ui_window_h			= 520 + modal * 40;					// Window height
		ui_banner_height	= 53;								// Height of banner graphic
		ui_spacing			= 3;								// Spacing gap size

		ui_sep_spacing		= 13;								// Spacing for the seperators (with text labels)

		ui_offset_x 		= 0;								// Main X offset from 0
		ui_offset_y 		= ui_banner_height+(ui_spacing*2);	// Main Y offset from 0
		ui_row				= 0;								// Row number
		ui_column			= 0;								// Column number
		ui_tab_offset		= ui_offset_y + 23;					// Offset for tab height
		ui_seperator_w		= ui_window_w + 2;					// Width of seperators
		ui_row_offset		= gad_h + ui_spacing;				// Row offset

		ui_tab_bottom		= ui_offset_y + ui_row_offset + ui_spacing + gad_h; // The bottom of the tab gadgets

		// ctlposition(controlId, X, Y, [W], [H], [Text_Offset])
			
		cname=SCRIPTID;
		cname=strsub(cname,size(cname),1);
		compiled=1;
		if (cname=="s" || cname=="S"){
			compiled=0;
		}

		cmp="LS";
		if (compiled){
			cmp="LSC";
		}
		
		exev="";
		if (exe_path!=""){
			exev=" Standalone mode";
		}
		
	    reqbegin("Kray Options (" + kverstring + " " + "Build " + version + demo + " " + cmp + ")" + exev);
	    reqsize(ui_window_w, ui_window_h);

			// Banner Graphic

			if (compiled){
				c_banner=ctlimage("kray_banner.tga");
				ctlposition(c_banner,0,0);
			}else{
				f_banner=find_image("kray_banner.tga");
				if (f_banner){
					c_banner=ctlimage(f_banner);
					ctlposition(c_banner,0,0);
				}
			}

		    // Render presets popup menu

		    c_general_preset=ctlpopup("Render Preset",1,general_presets_list);
		    ctlposition(c_general_preset, gad_x, ui_offset_y, gad_w, gad_h, gad_text_offset);
		    ctlrefresh(c_general_preset,"general_presets");

			// Render preset load button

			c_load_settings = ctlbutton("Load",1,"loadsettings");
			ctlposition(c_load_settings, gad_x+gad_w+ui_spacing, ui_offset_y,78,gad_h,0);

			// Render preset save button

			c_save_settings = ctlbutton("Save",1,"savesettings");
			ctlposition(c_save_settings, gad_x+gad_w+(ui_spacing*2)+78, ui_offset_y,78,gad_h,0);

			ui_offset_y += ui_row_offset + ui_spacing;


		    // UI Tabs

			if (lscomringactive()){
				tab0 = ctltab("General","Photons","Final Gather","Sampling","Quality","Plugins","Misc");
			}else{
				tab0 = ctltab("General","Photons","Final Gather","Sampling","Quality","Misc");
			}

			ctlposition(tab0, ui_offset_x, ui_offset_y, 372, gad_h);

		    ctlrefresh(tab0,"c_tab_refresh");
			reqredraw("req_redraw");


			// Gadgets: General Tab

			ui_offset_y += ui_row_offset + ui_spacing;

			// Diffuse model popup menu
		    c_gi=ctlpopup("Diffuse Model",v_gi,@"Raytrace","Photons Estimate","Photon Mapping","Path Tracing"@);
		    ctlposition(c_gi,gad_x, ui_offset_y, gad_w, gad_h, gad_text_offset);

			// Caustics checkbox
		    c_gicaustics = ctlcheckbox("Caustics",v_gicaustics);
		    ctlposition(c_gicaustics, gad_x + gad_w + ui_spacing, ui_offset_y, 159, gad_h,0);

			ui_offset_y += ui_row_offset;

			// Cache irradience checkbox
		    c_giirrgrad = ctlcheckbox("Cache Irradiance",v_giirrgrad);
		    ctlposition(c_giirrgrad, gad_x + gad_w + ui_spacing, ui_offset_y, 159, gad_h,0);

			// Raytrace direct checkbox
		    c_girtdirect = ctlcheckbox("Raytrace Direct",v_girtdirect);
		    ctlposition(c_girtdirect, gad_x + gad_w + ui_spacing, ui_offset_y, 159, gad_h,0);

			// Photons estimate checkbox
		    c_gipmmode = ctlpopup("Photons Estimate",v_gipmmode,@"Global Filtered","Global Unfiltered","Precomputed","Precomputed Filtered"@);
		    ctlposition(c_gipmmode, gad_x, ui_offset_y, gad_w, gad_h, gad_text_offset);

		    ctlvisible(c_gi,"c_pmdirectopt",c_gipmmode);
		    ctlvisible(c_gi,"c_pmcausticsopt",c_gicaustics);
		    ctlvisible(c_gi,"c_pmirrgradopt",c_giirrgrad);
		    ctlvisible(c_gi,"c_pmrtdirect",c_girtdirect);
		    ctlrefresh(c_gipmmode,"c_gi_refresh");
		    ctlrefresh(c_girtdirect,"c_gipmmode_refresh");

			ui_offset_y += ui_row_offset;

			// GI mode popup menu
		    c_shgi = ctlpopup("GI Mode",v_shgi,@"Independent","Time Interpolation","Shared For All Frames"@);
		    ctlposition(c_shgi, gad_x, ui_offset_y, gad_w, gad_h, gad_text_offset);

			ui_offset_y += ui_row_offset;

			// Time interpolation GI mode

			// Frames numeric entry
		    c_tiframes = ctlinteger("Frame",v_tiframes);
		    ctlposition(c_tiframes, gad_x, ui_offset_y, gad_w, gad_h, gad_text_offset);

			// Precached map checkbox
		    c_tiphotons = ctlcheckbox("Precached Map",v_tiphotons);
		    ctlposition(c_tiphotons, gad_x + gad_w + ui_spacing, ui_offset_y, 159, gad_h,0);

			ui_offset_y += ui_row_offset;

			// Extinction percentage entry
		    c_tiextinction = ctlpercent("Extinction",v_tiextinction);
		    ctlposition(c_tiextinction, gad_x, ui_offset_y, gad_w - 22, gad_h, gad_text_offset);

			// Irradiance cache checkbox
		    c_tifg = ctlcheckbox("Irradiance Cache",v_tifg);
		    ctlposition(c_tifg, gad_x + gad_w + ui_spacing, ui_offset_y, 159, gad_h,0);

		    ctlrefresh(c_tifg,"ti_refresh1");
		    ctlrefresh(c_tiphotons,"ti_refresh2");
		    ctlvisible(c_shgi,"is_2",c_tiphotons,c_tifg,c_tiframes,c_tiextinction);

			// Shared GI Mode

			ui_offset_y -= ui_row_offset;
			ui_offset_y -= ui_row_offset;

		    c_resetoct = ctlcheckbox("Allow Animation",v_resetoct);
		    ctlposition(c_resetoct, gad_x + gad_w + ui_spacing, ui_offset_y, 159, gad_h,0);

			ui_offset_y += ui_row_offset;

			// GI cache filename
		    c_giload = ctlfilename("GI Cache File",v_giload);
		    ctlposition(c_giload, gad_x, ui_offset_y, gad_w - 23, gad_h, gad_text_offset);
			
			// Reset cache file button
		    c_resetGI = ctlbutton("Reset File",1,"resetfile");
		    ctlposition(c_resetGI, gad_x + gad_w + ui_spacing, ui_offset_y, 159, gad_h,0);

			ui_offset_y += ui_row_offset;

		    // Cache file mode
		    c_ginew = ctlchoice("",v_ginew,@"Load","Save","Update"@);
		    ctlposition(c_ginew, gad_x, ui_offset_y, gad_w, gad_h, gad_text_offset);

			// Skip final raytrace step
		    c_render0 = ctlcheckbox("Bake Only",v_render0);
		    ctlposition(c_render0, gad_x + gad_w + ui_spacing, ui_offset_y, 159, gad_h,0);

		    ctlvisible(c_shgi,"is_3",c_giload,c_ginew,c_resetGI,c_resetoct,c_render0); // Added

		    ui_offset_y += ui_row_offset + 4;
		    c_sep3 = ctlsep(0, ui_seperator_w + 4);
		    ctlposition(c_sep3, -2, ui_offset_y);
		    ui_offset_y += ui_spacing + 5;

			// Camera mode popup
		    c_cptype = ctlpopup("Camera Mode",v_cptype,@"Lightwave","Spherical","Fish Eye","Texture Baker","Stereo"@);
		    ctlposition(c_cptype, gad_x, ui_offset_y, gad_w + 159 + ui_spacing, gad_h, gad_text_offset);

			ui_offset_y += ui_row_offset;

			// Pixel order popup
		    c_pxlordr = ctlpopup("Pixel Order",v_pxlordr,@"Scanline","Scancolumn","Random","Progressive","RenderWorm","Frost"@);
		    ctlposition(c_pxlordr, gad_x, ui_offset_y, gad_w + 159 + ui_spacing, gad_h, gad_text_offset);

		    if (v_lenspict!=""){
			found=0;

			imapObj = Image();
			while(imapObj){
			    temp = imapObj.filename(0);
			    if (temp==v_lenspict){
				found=1;
				break;
			    }
			    imapObj = imapObj.next();
			}
		    }

			ui_offset_y += ui_row_offset;

			// Iris shape file
		    c_lenspict = ctlfilename("Iris Shape",v_lenspict,0,1);
		    ctlposition(c_lenspict, gad_x, ui_offset_y, gad_w + 159 + ui_spacing - 23, gad_h, gad_text_offset);

		    objnames=@"(None)"@;
		    meshids=@0@;
		    dof_index=1;
		    vmapobj_index=1;
		    count=2;

		    vmapObj = Mesh();
		    while(vmapObj){
			objnames[count] = vmapObj.name;
			meshids[count] = vmapObj.id;
			if (objnames[count]==v_dofobj){
			    dof_index=count;
			}
			if (meshids[count]==v_camobject){
			    vmapobj_index=count;
			}
			vmapObj = vmapObj.next();
			count++;
		    }

			ui_offset_y += ui_row_offset;

			// DOF target popup menu
		    c_dofobj = ctlpopup("DOF Target",dof_index,objnames);
		    ctlposition(c_dofobj, gad_x, ui_offset_y, gad_w + 159 + ui_spacing - 23, gad_h, gad_text_offset);

		    // Refresh DOF target list button (Beta)
		    c_refresh1 = ctlbutton("R",1,"options");
		    ctlposition(c_refresh1, gad_x + gad_w + 159 + ui_spacing - 23 + 5, ui_offset_y, 18, gad_h);

			ui_offset_y -= ui_row_offset;

			// VMap Object popup menu
		    c_camobject = ctlpopup("Object",vmapobj_index,objnames);
		    ctlposition(c_camobject, gad_x, ui_offset_y, gad_w + 159 + ui_spacing - 23, gad_h, gad_text_offset);

		    // Refresh object list button (Beta)
		    c_refresh4 = ctlbutton("R",1,"options");
		    ctlposition(c_refresh4, gad_x + gad_w + 159 + ui_spacing - 23 + 5, ui_offset_y, 18, gad_h);

		    ctlactive(c_cptype,"c_dof_on",c_lenspict,c_dofobj);

		    vmapnames=@"(none)"@;
		    index=1;
		    count=2;

		    vmapObj = VMap(VMTEXTURE);
		    while(vmapObj){
			if (vmapObj.type == VMTEXTURE){
			    vmapnames[count] = vmapObj.name;
			    if (vmapnames[count]==v_camuvname){
				index=count;
			    }
			    count++;
			}
			vmapObj = vmapObj.next();
		    }
			
			// STEREO settings
		    c_eyesep = ctlnumber("Eye separation",v_eyesep);
		    ctlposition(c_eyesep, gad_x, ui_offset_y, 63 + gad_text_offset, gad_h, gad_text_offset);
			
			ui_offset_y += ui_row_offset;

		    c_camuvname = ctlpopup("UV Map",index,vmapnames);
		    ctlposition(c_camuvname, gad_x, ui_offset_y, gad_w, gad_h, gad_text_offset);

			
			c_errode = ctlpopup("Extend border",v_errode,@"Extend edge 0 px","Extend edge 1 px","Extend edge 2 px","Extend edge 3 px","Extend edge 4 px", "Extend edge 5 px"@);
			ctlposition(c_errode, gad_x + gad_w + ui_spacing, ui_offset_y, 159, gad_h,0);

			// STEREO settings
			c_stereoimages = ctlinteger("No. of images",v_stereoimages);
		    ctlposition(c_stereoimages, gad_x , ui_offset_y, 63 + gad_text_offset, gad_h, gad_text_offset);			
			
		    ctlvisible(c_cptype,"is_not_5",c_eyesep,c_stereoimages); 
			
		    ctlvisible(c_cptype,"is_not_4",c_camobject,c_camuvname,c_errode,c_refresh4); //added beta 'R'4 visible state
		    ctlvisible(c_cptype,"is_1",c_lenspict,c_dofobj,c_refresh1); //added beta 'R'1 visible state

		    ui_offset_y += ui_row_offset + 4;
		    c_sep4 = ctlsep(0, ui_seperator_w + 4);
		    ctlposition(c_sep4, -2, ui_offset_y);
		    ui_offset_y += ui_spacing + 5;
			
			//Output
			otuput_label = ctltext("","Output file");
			ctlposition(otuput_label, gad_x + 45, ui_offset_y + ui_spacing, 100, gad_h, gad_text_offset);
			
			c_output_On = ctlcheckbox("On",v_output_On);
			ctlposition(c_output_On, gad_x, ui_offset_y, 145, gad_h, gad_text_offset);
			
			// Output filename
		    c_outname = ctlfilename("",v_outname,0,0);
			offout = 145 + ui_spacing;
		    ctlposition(c_outname, gad_x + offout, ui_offset_y, gad_w + 159 + ui_spacing - 23 - offout, gad_h, 0 );

		    ctlrefresh(c_outname,"format_refresh");
		    mlsize=size(v_outname);

			ui_offset_y += ui_row_offset;

			// File format type choice
		    c_outfmt = ctlpopup("File Format",v_outfmt,image_formats);
		    ctlposition(c_outfmt, gad_x, ui_offset_y, gad_w + 159 + ui_spacing, gad_h, gad_text_offset);

		    ctlrefresh(c_outfmt,"format_refresh");
		    ctlactive(c_outname,"is_name",c_outfmt);
			ctlactive(c_output_On,"is_1",c_outname,c_outfmt);

			ui_offset_y += ui_row_offset;
		    ui_offset_y += ui_row_offset;

			// Tonemap type
		    c_tmo = ctlpopup("Tonemap",v_tmo,@"Linear","Gamma","Exponential"@);
		    ctlposition(c_tmo, gad_x, ui_offset_y, gad_w, gad_h, gad_text_offset);

			// Limit dynamic range popup menu
		    c_limitdr = ctlpopup("LimitDR",v_limitdr,@"Limit DR After Tonemap","Limit DR Before Tonemap","Don't Limit DR"@);
		    ctlposition(c_limitdr, gad_x + gad_w + ui_spacing, ui_offset_y, 159, gad_h,0);

			ui_offset_y += ui_row_offset;

			// Parameter numeric entry
		    c_outparam = ctlnumber("Parameter",v_outparam);
		    ctlposition(c_outparam, gad_x , ui_offset_y, 63 + gad_text_offset, gad_h, gad_text_offset);

			// Exposure numeric entry
		    c_outexp = ctlnumber("Exp",v_outexp);
		    ctlposition(c_outexp, 63 + gad_text_offset + 10, ui_offset_y, 63 + 24, gad_h, 24);

		    // HSV mode checkbox
			c_tmhsv = ctlcheckbox("HSV Mode",v_tmhsv);
		    ctlposition(c_tmhsv, gad_x + gad_w + ui_spacing, ui_offset_y, 159, gad_h,0);

			ctlvisible(c_tmo,"is_not_1",c_outexp,c_tmhsv,c_outparam);

		    ui_offset_y += ui_row_offset + 4;
		    // c_sep34 = ctlsep(0, ui_seperator_w + 4);
		    // ctlposition(c_sep34, -2, ui_offset_y);
		    ui_offset_y += ui_spacing + 5;

			//Moved header)tailer to Misc tab
		    // ui_offset_y += ui_row_offset;
			
		    ui_offset_y += ui_row_offset + 4;
		    c_sep_last1 = ctlsep(0, ui_seperator_w + 4);
		    ctlposition(c_sep_last1, -2, ui_offset_y);
		    ui_offset_y += ui_spacing + 5;

			// Render frame button
		    c_rendersingle1 = ctlbutton("Render Frame",0,"rendersingle");
		    ctlposition(c_rendersingle1, gad_x + 18, ui_offset_y, 175, gad_h + 8, 0);

			// Render sequence button
		    c_rendersequence1 = ctlbutton("Render Sequence",0,"rendersequence");
		    ctlposition(c_rendersequence1, gad_x + gad_w - 13, ui_offset_y, 175, gad_h + 8, 0);

		    ctlpage(1,c_gi,c_shgi,c_outname,c_outfmt,
				otuput_label,
				c_output_On,
			    c_limitdr,
			    c_outparam,c_outexp,// c_sep34,
			    c_sep3,c_giload,c_pxlordr,
			    c_ginew,c_gicaustics,c_gipmmode,c_giirrgrad,
			    c_girtdirect,c_tmo,c_tmhsv,c_tiphotons,c_tifg,c_camobject,c_lenspict,c_camuvname,c_dofobj,
			    c_resetoct,c_errode, c_eyesep, c_stereoimages,
				c_tiframes,c_tiextinction,c_cptype,c_sep4,
				c_refresh1,c_refresh4, c_resetGI,c_render0);//added load/save & refresh


			// Photons tab

		    // Reset ui_offset_y value
		    ui_offset_y = ui_tab_bottom + (ui_spacing*2);

			// GI resolution numeric entry
		    c_gir = ctldistance("GI Resolution",v_gir);
		    ctlposition(c_gir, gad_x, ui_offset_y, gad_w, gad_h, gad_text_offset);

			// Auto photons checkbox
		    c_girauto = ctlcheckbox("Auto",v_girauto);
		    ctlposition(c_girauto, gad_x + gad_w + ui_spacing, ui_offset_y, 159, gad_h,0);

		    ui_offset_y += ui_row_offset + ui_sep_spacing;

		    c_gph_text=ctltext("","Photons Settings:");
		    ctlposition(c_gph_text, gad_x + 10, ui_offset_y - 8, 100,gad_h, gad_text_offset);

		    c_sep1 = ctlsep(0, ui_seperator_w + 4);
		    ctlposition(c_sep1, 100, ui_offset_y);
		    ui_offset_y += ui_sep_spacing + 3;

		    c_gph_preset=ctlpopup("Photons Preset",v_gph_preset,presets_list2);
		    ctlposition(c_gph_preset, gad_x, ui_offset_y, gad_w, gad_h, gad_text_offset);
		    ctlrefresh(c_gph_preset,"photons_presets");

		    c_gmode = ctlchoice("",v_gmode,@"Photonmap","Lightmap"@);
		    ctlposition(c_gmode, gad_x + gad_w + ui_spacing, ui_offset_y, 159, gad_h,0);

		    ui_offset_y += ui_row_offset;

		    c_gf = ctlinteger("Global Photons",v_gf);
		    ctlposition(c_gf, gad_x, ui_offset_y, gad_w - 99, gad_h, gad_text_offset);

		    c_gfunit = ctlchoice("",v_gfunit,@"Emit","Receive"@);
		    ctlposition(c_gfunit, gad_x + gad_w - 100, ui_offset_y, 100, gad_h,0);

			// Show photons checkbox
		    c_showphotons = ctlcheckbox("Preview Photons",v_showphotons);
		    ctlposition(c_showphotons, gad_x + gad_w + ui_spacing, ui_offset_y, 159, gad_h,0);

		    ui_offset_y += ui_row_offset;

		    c_ppmult = ctlnumber("Power",v_ppmult);
		    ctlposition(c_ppmult, gad_x, ui_offset_y, gad_w, gad_h, gad_text_offset);

		    ui_offset_y += ui_row_offset;

		    c_gmatic = ctlcheckbox("Use Autophotons",v_gmatic);
		    ctlposition(c_gmatic, gad_x + gad_w + ui_spacing, ui_offset_y, 159, gad_h,0);

		    ui_offset_y += ui_row_offset;

		    c_gn = ctlinteger("N",v_gn);
		    ctlposition(c_gn, gad_x, ui_offset_y, gad_w, gad_h, gad_text_offset);

		    c_glow = ctlpercent("Low",v_glow);
		    ctlposition(c_glow, gad_x + gad_w , ui_offset_y, 139, gad_h, 67);

		    c_gpstart = ctlpercent("Radius",v_gpstart);
		    ctlposition(c_gpstart, gad_x + gad_w , ui_offset_y, 139, gad_h, 67);

		    ui_offset_y += ui_row_offset;

		    c_ppsize = ctlpercent("Precache Distance",v_ppsize);
		    ctlposition(c_ppsize, gad_x, ui_offset_y, gad_w - 22, gad_h, gad_text_offset);

		    c_ghigh = ctlpercent("High",v_ghigh);
		    ctlposition(c_ghigh, gad_x + gad_w , ui_offset_y, 139, gad_h, 67);

		    c_gpstop = ctlpercent("Max Radius",v_gpstop);
		    ctlposition(c_gpstop, gad_x + gad_w , ui_offset_y, 139, gad_h, 67);

		    ui_offset_y += ui_row_offset;

		    c_ppblur = ctlpercent("Precache Blur",v_ppblur);
		    ctlposition(c_ppblur, gad_x, ui_offset_y, gad_w - 22, gad_h, gad_text_offset);

		    c_gpstep = ctlinteger("Steps",v_gpstep);
		    ctlposition(c_gpstep, gad_x + gad_w , ui_offset_y, 161, gad_h, 67);

		    c_gdyn = ctlnumber("Steps",v_gdyn);
		    ctlposition(c_gdyn, gad_x + gad_w , ui_offset_y, 161, gad_h, 67);

		    ctlvisible(c_gmatic,"ft_active",c_gpstart,c_gpstop,c_gpstep);
		    ctlvisible(c_gmatic,"tf_active",c_glow,c_ghigh,c_gdyn);
		    ctlrefresh(c_gmatic,"c_gmaticrefresh");

		    ctlactive(c_gph_preset,"is_1",c_gmatic,c_gn,c_glow,c_gpstart,c_ppsize,c_ghigh,c_gpstop,c_ppblur,c_gpstep,c_gdyn);

		    ui_offset_y += ui_row_offset + ui_sep_spacing;

		    c_cph_text=ctltext("","Caustics Settings:");
		    ctlposition(c_cph_text, gad_x + 10, ui_offset_y - 8, 100,gad_h, gad_text_offset);

		    c_sep9 = ctlsep(0, ui_seperator_w + 4);
		    ctlposition(c_sep9, 100, ui_offset_y);
		    ui_offset_y += ui_sep_spacing + 3;

		    c_cph_preset=ctlpopup("Caustics Preset",v_cph_preset,presets_list);
		    ctlposition(c_cph_preset, gad_x, ui_offset_y, gad_w, gad_h, gad_text_offset);

		    ctlrefresh(c_cph_preset,"caustics_presets");

		    c_ppcaustics = ctlcheckbox("Add to Lightmap",v_ppcaustics);
		    ctlposition(c_ppcaustics, gad_x + gad_w + ui_spacing, ui_offset_y, 159, gad_h,0);

			ui_offset_y += ui_row_offset;

		    c_cf = ctlinteger("Caustics Photons",v_cf);
		    ctlposition(c_cf, gad_x, ui_offset_y, gad_w - 99, gad_h, gad_text_offset);

		    c_cfunit = ctlchoice("",v_cfunit,@"Emit","Receive"@);
		    ctlposition(c_cfunit, gad_x + gad_w - 100, ui_offset_y, 100, gad_h,0);
			
		    c_cmatic = ctlcheckbox("Use Autophotons",v_cmatic);
		    ctlposition(c_cmatic, gad_x + gad_w + ui_spacing, ui_offset_y, 159, gad_h,0);
			
			ui_offset_y += ui_row_offset;

		    c_cmult = ctlnumber("Power",v_cmult);
		    ctlposition(c_cmult, gad_x, ui_offset_y, gad_w, gad_h, gad_text_offset);

		    c_clow = ctlpercent("Low",v_clow);
		    ctlposition(c_clow, gad_x + gad_w , ui_offset_y, 139, gad_h, 67);

		    c_cpstart = ctlpercent("Radius",v_cpstart);
		    ctlposition(c_cpstart, gad_x + gad_w , ui_offset_y, 139, gad_h, 67);

			ui_offset_y += ui_row_offset;



		    c_cpstop = ctlpercent("Max radius",v_cpstop);
		    ctlposition(c_cpstop, gad_x + gad_w , ui_offset_y, 139, gad_h, 67);

		    c_chigh = ctlpercent("High",v_chigh);
		    ctlposition(c_chigh, gad_x + gad_w , ui_offset_y, 139, gad_h, 67);

			ui_offset_y += ui_row_offset;

		    c_cn = ctlinteger("N",v_cn);
		    ctlposition(c_cn, gad_x, ui_offset_y, gad_w, gad_h, gad_text_offset);

		    c_cdyn = ctlnumber("Steps",v_cdyn);
		    ctlposition(c_cdyn, gad_x + gad_w , ui_offset_y, 161, gad_h, 67);

		    c_cpstep = ctlinteger("Steps",v_cpstep);
		    ctlposition(c_cpstep, gad_x + gad_w , ui_offset_y, 161, gad_h, 67);

			ui_offset_y += ui_row_offset;

		    ctlvisible(c_cmatic,"ft_active",c_cpstart,c_cpstop,c_cpstep);
		    ctlvisible(c_cmatic,"tf_active",c_clow,c_chigh,c_cdyn);
		    ctlrefresh(c_cmatic,"c_cmaticrefresh");

		    ctlactive(c_cph_preset,"is_1",c_cmatic,c_cn,c_clow,c_cpstart,c_cdyn,c_cpstep,c_cpstop,c_chigh);

		    ctlpage(2,c_gir,c_sep1,c_sep9,c_cph_preset,c_showphotons,
			c_cf,c_cmatic,c_cpstart,c_cpstop,c_cpstep,c_cn,c_cfunit,c_clow,c_chigh,c_cdyn,
			c_gf,c_gmatic,c_gpstart,c_gpstop,c_gpstep,c_gn,c_gmode,c_gfunit,c_glow,c_ghigh,c_gdyn,
			c_ppsize,c_girauto,c_ppcaustics,c_ppmult,c_cmult,c_gph_preset,
			c_ppblur,c_gph_text,c_cph_text);


			// Final Gather Tab

		    // Reset ui_offset_y value
		    ui_offset_y = ui_tab_bottom + (ui_spacing*2);

		    c_gir_copy = ctldistance("GI Resolution",v_gir);
		    ctlposition(c_gir_copy, gad_x, ui_offset_y, gad_w, gad_h, gad_text_offset);

		    ctlrefresh(c_gir_copy,"c_fgircopy");

		    c_girauto_copy = ctlcheckbox("Auto",v_girauto);
		    ctlposition(c_girauto_copy, gad_x + gad_w + ui_spacing, ui_offset_y, 159, gad_h,0);

		    ui_offset_y += ui_row_offset + ui_sep_spacing;

		    c_fg_text=ctltext("","Final Gather Settings:");
		    ctlposition(c_fg_text, gad_x + 10, ui_offset_y - 8, 100,gad_h, gad_text_offset);

		    c_sepfg1 = ctlsep(0, ui_seperator_w + 4);
		    ctlposition(c_sepfg1, 115, ui_offset_y);
		    ui_offset_y += ui_sep_spacing + 3; 

		    ctlrefresh(c_girauto_copy,"c_fgirautocopy");
		    ctlvisible(c_gmatic,"tf_active",c_girauto_copy,c_girauto);

		    ctlactive(c_girauto,"ft_active",c_gir,c_gir_copy);

		    c_fg_preset=ctlpopup("Final Gather Preset",v_fg_preset,presets_list2);
		    ctlposition(c_fg_preset, gad_x, ui_offset_y, gad_w + 35, gad_h, gad_text_offset);

		    ctlrefresh(c_fg_preset,"fg_presets");

			ui_offset_y += ui_row_offset;

		    c_fgth = ctlnumber("FG Threshold",v_fgth);
		    ctlposition(c_fgth, gad_x, ui_offset_y, 71 + gad_text_offset, gad_h, gad_text_offset);

			gad_prev_w = 71 + gad_text_offset;

		    c_fgrmin = ctlinteger("Min Rays",v_fgrmin);
		    ctlposition(c_fgrmin, gad_x + gad_prev_w + ui_spacing, ui_offset_y, 71 + 50, gad_h, 50);

			gad_prev_w += gad_x + ui_spacing + 71 + 50;

		    c_fgrmax = ctlinteger("Max Rays",v_fgrmax);
		    ctlposition(c_fgrmax, gad_x + gad_prev_w + ui_spacing, ui_offset_y, 71 + 53, gad_h, 53);

		    ui_offset_y += ui_row_offset;

		    c_prep = ctlpercent("Prerender",v_prep);
		    ctlposition(c_prep, gad_x, ui_offset_y, 71 + gad_text_offset - 22, gad_h, gad_text_offset);

		    ctlrefresh(c_prep,"zero_one_c_prep_refresh");

			gad_prev_w = 71 + gad_text_offset;

			c_prestep = ctlinteger("Passes",v_prestep);
		    ctlposition(c_prestep, gad_x + gad_prev_w + ui_spacing, ui_offset_y, 71 + 50, gad_h, 50);

		    gad_prev_w += gad_x + ui_spacing + 71 + 50;

		    c_preSplDet = ctlnumber("Splotch D",v_preSplDet);
		    ctlposition(c_preSplDet, gad_x + gad_prev_w + ui_spacing, ui_offset_y, 71 + 53, gad_h, 53);

		    ui_offset_y += ui_row_offset;

			c_gradNeighbour = ctlnumber("Sensitivity",v_gradNeighbour);
			ctlposition(c_gradNeighbour, gad_x, ui_offset_y, 71 + gad_text_offset, gad_h, gad_text_offset);

			ui_offset_y += ui_row_offset;

			gad_prev_w = 71 + gad_text_offset;

		    c_fgreflections = ctlcheckbox("FG Reflections",v_fgreflections);
		    ctlposition(c_fgreflections, gad_x, ui_offset_y, gad_w + 35, gad_h, gad_text_offset);

			ui_offset_y += ui_row_offset;

		    c_fgrefractions = ctlcheckbox("FG Transparency / Refractions",v_fgrefractions);
		    ctlposition(c_fgrefractions, gad_x, ui_offset_y, gad_w + 35, gad_h, gad_text_offset);

		    ui_offset_y += ui_row_offset + 4;
		    c_seppsfg = ctlsep(0, ui_seperator_w + 4);
		    ctlposition(c_seppsfg, -2, ui_offset_y);
		    ui_offset_y += ui_spacing + 5;

		    c_fga = ctlnumber("Spatial Tolerance",v_fga);
		    ctlposition(c_fga, gad_x, ui_offset_y, 71 + gad_text_offset, gad_h, gad_text_offset);

		    gad_prev_w = 71 + gad_text_offset;

		    c_fgb = ctlangle("Angular Tolerance",v_fgb);
		    ctlposition(c_fgb, gad_x + gad_prev_w + 22, ui_offset_y, 130 - 24 + 101, gad_h, 101);

			ui_offset_y += ui_row_offset;

		    c_fgmin = ctlpercent("Min Distance",v_fgmin);
		    ctlposition(c_fgmin, gad_x, ui_offset_y, 71 + gad_text_offset - 22 , gad_h, gad_text_offset);

		    c_fgmax = ctlpercent("Max Distance",v_fgmax);
		    ctlposition(c_fgmax, gad_x + gad_prev_w + 22, ui_offset_y, 130 - 24 + 101, gad_h, 101);

			ui_offset_y += ui_row_offset;

		    c_fgblur = ctlnumber("Blur Samples",v_fgblur);
		    ctlposition(c_fgblur, gad_x, ui_offset_y, 71 + gad_text_offset, gad_h, gad_text_offset);

		    c_fgscale = ctlpercent("Brightness / Density",v_fgscale);
		    ctlposition(c_fgscale, gad_x + gad_prev_w + 22, ui_offset_y, 130 - 24 + 101, gad_h, 101);

		    ui_offset_y += ui_row_offset;

		    c_fgshows = ctlchoice("Show FG Samples",v_fgshows,@"Off","Corners","All"@);
		    ctlposition(c_fgshows, gad_x, ui_offset_y, gad_w + 32, gad_h, gad_text_offset);

		    ui_offset_y += ui_row_offset;

		    c_fgsclr = ctlcolor("Color",v_fgsclr);
		    ctlposition(c_fgsclr, gad_x, ui_offset_y, gad_w + 32, gad_h, gad_text_offset);

		    ui_offset_y += ui_row_offset + ui_sep_spacing;

		    c_pth_text=ctltext("","Path Tracing Settings:");
		    ctlposition(c_pth_text, gad_x + 10, ui_offset_y - 8, 100,gad_h, gad_text_offset);

		    c_seppsfg2 = ctlsep(0, ui_seperator_w + 4);
		    ctlposition(c_seppsfg2, 115, ui_offset_y);
		    ui_offset_y += ui_sep_spacing + 3;

		    c_cornerpaths = ctlinteger("Path Passes",v_cornerpaths);
		    ctlposition(c_cornerpaths, gad_x, ui_offset_y, 71 + gad_text_offset, gad_h, gad_text_offset);

		    c_cornerdist = ctlpercent("Corner Distance",v_cornerdist);
		    ctlposition(c_cornerdist, gad_x + gad_prev_w + 22, ui_offset_y, 130 - 24 + 101, gad_h, 101);

		    ctlactive(c_fg_preset,"is_1",c_fga,c_fgb,c_fgmin,c_fgmax,c_fgscale,c_fgblur,c_fgshows,c_fgsclr);

		    /*    ypos=footer;
		    c_sep_last3 = ctlsep(10,sepwidth);
		    ctlposition(c_sep_last3,10,ypos+ysize/2);ypos=ypos+ysize;
		    c_rendersingle3 = ctlbutton("Render frame",0,"rendersingle");
		    ctlposition(c_rendersingle3,10,ypos,160,19,0);
		    c_rendersequence3 = ctlbutton("Render sequence",0,"rendersequence");
		    ctlposition(c_rendersequence3,270,ypos,160,19,0);*/

		    ctlpage(3,c_fgth,c_fgrmin,c_fgrmax,c_fga,c_fgb,c_fgmin,c_fgmax,c_fgscale,c_fgblur,
			    c_fgshows,c_fgsclr,c_seppsfg,c_seppsfg2,c_fg_text,c_prep,c_pth_text,
			    c_girauto_copy,c_cornerdist,c_cornerpaths,c_fg_preset,
			    c_gir_copy,c_sepfg1,c_fgreflections,c_fgrefractions,
				c_prestep,c_preSplDet,c_gradNeighbour);


			// Sampling Tab
			
		    // Reset ui_offset_y value
		    ui_offset_y = ui_tab_bottom + (ui_spacing*2);

			ui_offset_y += ui_sep_spacing;

		    c_aa_text=ctltext("","Antialiasing Settings :");
		    ctlposition(c_aa_text, gad_x + 10, ui_offset_y - 8, 100, gad_h, gad_text_offset);

		    c_sepaa6 = ctlsep(0, ui_seperator_w + 4);
		    ctlposition(c_sepaa6, 112, ui_offset_y);
		    ui_offset_y += ui_sep_spacing + 3;

		    c_aa_preset=ctlpopup("AA Preset",v_aa_preset,presets_list);
		    ctlposition(c_aa_preset, gad_x, ui_offset_y, gad_w, gad_h, gad_text_offset);

		    dof_active=scene.renderopts[7];
		    mb_active=scene.renderopts[6];

			ui_offset_y += ui_row_offset;
			
		    c_pxlfltr = ctlpopup("Pixel Filter",v_pxlfltr,@"Box","Cone","Cubic","Quadratic","Lanczos","Mitchell","Spline","Catmull"@);
		    ctlposition(c_pxlfltr, gad_x, ui_offset_y, gad_w, gad_h, gad_text_offset);

		    c_pxlparam = ctlnumber("Filter Radius",v_pxlparam);
		    ctlposition(c_pxlparam, gad_x + gad_w + ui_spacing, ui_offset_y, 91 + 64, gad_h, 64);

		    ctlvisible(c_pxlfltr,"is_less_then_6",c_pxlparam);

			ui_offset_y += ui_row_offset*1.5;			

		    c_aatype = ctlpopup("Antialiasing",v_aatype,@"None","Grid","Quasi-Random","Random Full Screen AA"@);
		    ctlposition(c_aatype, gad_x, ui_offset_y, gad_w, gad_h, gad_text_offset);

		    c_aafscreen = ctlcheckbox("Full Screen Antialiasing",v_aafscreen);
		    ctlposition(c_aafscreen, gad_x + gad_w + ui_spacing, ui_offset_y, 159, gad_h,0);

			ctlrefresh(c_aatype,"disable_fscreen_refresh");

			ui_offset_y += ui_row_offset;

		    c_aargsmpl = ctlinteger("Grid Size",v_aargsmpl);
		    ctlposition(c_aargsmpl, gad_x, ui_offset_y, gad_w, gad_h, gad_text_offset);

		    c_aagridrotate = ctlcheckbox("Rotated Grid",v_aagridrotate);
		    ctlposition(c_aagridrotate, gad_x + gad_w + ui_spacing, ui_offset_y, 159, gad_h,0);

		    c_cstocvar = ctlnumber("Threshold",v_cstocvar);
		    ctlposition(c_cstocvar,  gad_x, ui_offset_y, gad_w, gad_h, gad_text_offset);

		    c_aarandsmpl = ctlinteger("Rays",v_aarandsmpl);
		    ctlposition(c_aarandsmpl, gad_x, ui_offset_y, gad_w, gad_h, gad_text_offset);

			ui_offset_y += ui_row_offset;

		    c_cstocmin = ctlinteger("Min Rays",v_cstocmin);
		    ctlposition(c_cstocmin,  gad_x, ui_offset_y, gad_w, gad_h, gad_text_offset);

		    c_cmbsubframes = ctlinteger("MB Subframes",v_cmbsubframes);
		    ctlposition(c_cmbsubframes, gad_x, ui_offset_y, gad_w, gad_h, gad_text_offset);

			ui_offset_y += ui_row_offset;

		    c_cstocmax = ctlinteger("Max Rays",v_cstocmax);
		    ctlposition(c_cstocmax,  gad_x, ui_offset_y, gad_w, gad_h, gad_text_offset);

			ui_offset_y += ui_row_offset; // Create space for gadgets that will be defined lower down
		    ui_offset_y += ui_sep_spacing;

		    c_aa_atext=ctltext("","Adaptive Settings :");
			ctlposition(c_aa_atext, gad_x + 10, ui_offset_y - 8, 100);

		    c_sepaa1 = ctlsep(0, ui_seperator_w + 4);
		    ctlposition(c_sepaa1, 101, ui_offset_y);
		    ui_offset_y += ui_sep_spacing + 3;

		    c_edgeabs = ctlnumber("Edge Absolute",v_edgeabs);
		    ctlposition(c_edgeabs, gad_x, ui_offset_y, gad_w, gad_h, gad_text_offset);

		    c_edgerel = ctlnumber("Relative",v_edgerel);
		    ctlposition(c_edgerel, gad_x + gad_w + ui_spacing, ui_offset_y, 91 + 64, gad_h, 64);

			ui_offset_y += ui_row_offset;

		    c_edgethick = ctlinteger("Thickness",v_edgethick);
		    ctlposition(c_edgethick, gad_x, ui_offset_y, gad_w, gad_h, gad_text_offset);

		    c_edgeover = ctlnumber("Overburn",v_edgeover);
		    ctlposition(c_edgeover, gad_x + gad_w + ui_spacing, ui_offset_y, 91 + 64, gad_h, 64);
			
		    ui_offset_y += ui_row_offset; 
		    ui_offset_y += ui_sep_spacing;
			
		    c_aa_atext2=ctltext("","Geometry Detect :");
			ctlposition(c_aa_atext2, gad_x + 10, ui_offset_y - 8, 100);
			
			c_sepaa2 = ctlsep(0, ui_seperator_w + 4);
		    ctlposition(c_sepaa2, 101, ui_offset_y);
		    ui_offset_y += ui_sep_spacing + 3;
			
		    c_edgenorm = ctlnumber("Normal",v_edgenorm);
		    ctlposition(c_edgenorm, gad_x, ui_offset_y, gad_w, gad_h, gad_text_offset);
			
			c_edgezbuf = ctlnumber("Z",v_edgezbuf);
		    ctlposition(c_edgezbuf, gad_x + gad_w + ui_spacing, ui_offset_y, 91 + 64, gad_h, 64);

			ui_offset_y += ui_row_offset;
			
			c_edgeup = ctlinteger("Upsample",v_edgeup);
		    ctlposition(c_edgeup, gad_x, ui_offset_y, gad_w, gad_h, gad_text_offset);

			ui_offset_y += ui_row_offset*2;
			
			c_underf = ctlpopup("Undersample",v_underf,@"None","2","4","8","16","32","64","128","256","512"@);
		    ctlposition(c_underf, gad_x, ui_offset_y, gad_w, gad_h, gad_text_offset);

		    c_undert = ctlnumber("Threshold",v_undert);
		    ctlposition(c_undert, gad_x + gad_w + ui_spacing, ui_offset_y, 91 + 64, gad_h, 64);			

		    ctlvisible(c_aatype,"c_antistoc",c_cstocvar,c_cstocmax,c_cstocmin);
		    ctlvisible(c_aatype,"is_not_4",c_cmbsubframes);
		    ctlvisible(c_aatype,"c_antigrid",c_aagridrotate,c_aargsmpl);
		    ctlvisible(c_aatype,"c_antirand",c_aarandsmpl);

		    ctlvisible(c_aatype,"is_not_one_not_four_active",c_aafscreen);
			ctlvisible(c_aatype,"is_one_or_four_active",c_aa_atext,c_sepaa1,c_edgeabs,c_edgerel,c_edgethick,c_edgeover,c_aa_atext2,c_sepaa2,c_edgenorm,c_edgezbuf,c_edgeup);

		    // ctlactive(c_underf,"is_1",c_edgenorm,c_edgezbuf,c_edgeup);
		    ctlrefresh(c_underf,"on_off_fsaa_refresh");
			
		    ctlactive(c_underf,"is_not_1",c_undert);
		    ctlactive(c_aafscreen,"aa_edge_active",c_edgeabs,c_edgerel,c_edgethick,c_edgeover);
			ctlactive(c_aafscreen,"aa_edge_active2",c_edgenorm,c_edgezbuf,c_edgeup);
		    ctlrefresh(c_aa_preset,"aa_presets");

		    /*    ypos=footer;
		    c_sep_last4 = ctlsep(10,sepwidth);
		    ctlposition(c_sep_last4,10,ypos+ysize/2);ypos=ypos+ysize;
		    c_rendersingle4 = ctlbutton("Render frame",0,"rendersingle");
		    ctlposition(c_rendersingle4,10,ypos,160,19,0);
		    c_rendersequence4 = ctlbutton("Render sequence",0,"rendersequence");
		    ctlposition(c_rendersequence4,270,ypos,160,19,0);*/

		    ctlpage(4,c_aatype,c_underf,c_undert,c_cstocvar,c_cstocmin,c_cstocmax,c_aa_text,c_aa_atext,
			c_cmbsubframes,c_sepaa6,c_aafscreen,c_sepaa1, c_edgeabs,c_edgerel,c_edgenorm,c_edgezbuf,c_edgeup,
			c_edgethick,c_edgeover,c_pxlfltr,c_pxlparam,c_aa_preset,c_aargsmpl,c_aarandsmpl,c_aagridrotate,c_sepaa2,c_aa_atext2);


			// Quality Tab

		    // Reset ui_offset_y value
		    ui_offset_y = ui_tab_bottom + (ui_spacing*2);

		    c_quality_preset=ctlpopup("Quality Preset",v_quality_preset,presets_list);
		    ctlposition(c_quality_preset, gad_x, ui_offset_y, gad_w, gad_h, gad_text_offset);
		    ctlrefresh(c_quality_preset,"quality_presets");

		    ui_offset_y += ui_row_offset + 4;
		    c_sep_qua = ctlsep(0, ui_seperator_w + 4);
		    ctlposition(c_sep_qua, -2, ui_offset_y);
		    ui_offset_y += ui_spacing + 5;


		    c_lg = ctlpopup("Luminosity Model",v_lg,@"Compute as Indirect","Compute as Direct","Automatic"@);
		    ctlposition(c_lg, gad_x, ui_offset_y, gad_w, gad_h, gad_text_offset);

		    c_autolumi = ctlpercent("Level",v_autolumi);
		    ctlposition(c_autolumi, gad_x + gad_w + ui_spacing, ui_offset_y, 102 + 32, gad_h, 32);
		    ctlvisible(c_lg,"is_3",c_autolumi);
		    
		    ui_offset_y += ui_row_offset;

		    c_pl = ctlpopup("Area Lights",v_pl,@"Compute Separately (AS)","Compute With Luminosity"@);
		    ctlposition(c_pl, gad_x, ui_offset_y, gad_w, gad_h, gad_text_offset);

		    c_areaside = ctlcheckbox("Double Sided",v_areaside);
		    ctlposition(c_areaside, gad_x + gad_w + ui_spacing, ui_offset_y, 105 + 22 + 32, gad_h, 32);

		    ui_offset_y += ui_row_offset;

		    c_areavis = ctlpopup("Area Light Visibility",v_areavis,@"Visible (Realistic)","Invisible (LW Compatible)"@);
		    ctlposition(c_areavis, gad_x, ui_offset_y, gad_w, gad_h, gad_text_offset);

		    c_conetoarea = ctlcheckbox("Spotlights To Area",v_conetoarea);
		    ctlposition(c_conetoarea, gad_x + gad_w + ui_spacing, ui_offset_y, 105 + 22 + 32, gad_h, 32);
		    
		    ui_offset_y += ui_row_offset + ui_sep_spacing;

		    c_light_qtext=ctltext("","Lights Quality:");
		    ctlposition(c_light_qtext, gad_x + 10, ui_offset_y - 8, 100,gad_h, gad_text_offset);

		    c_light_qsep = ctlsep(0, ui_seperator_w + 4);
		    ctlposition(c_light_qsep, 80, ui_offset_y);
		    ui_offset_y += ui_sep_spacing + 3;

		    c_planth = ctlnumber("Area Lights Threshold",v_planth);
		    ctlposition(c_planth, gad_x + 10, ui_offset_y, 75 + 116, gad_h, 116);

			gad_prev_w = 75 + 116 + 10;
		    
			c_planrmin = ctlinteger("Min Recursion",v_planrmin);
		    ctlposition(c_planrmin, gad_x + gad_prev_w + ui_spacing, ui_offset_y, 52 + 77, gad_h, 77);
			ctlrefresh(c_planrmin,"msg_kray_physky2");

			gad_prev_w += 52 + 77 + 10;

		    c_planrmax = ctlinteger("Max",v_planrmax);
		    ctlposition(c_planrmax, gad_x + gad_prev_w + ui_spacing, ui_offset_y, 53 + 26, gad_h, 26);
			ctlrefresh(c_planrmax,"msg_kray_physky2");

		    ui_offset_y += ui_row_offset;

		    c_llinth = ctlnumber("Linear Lights Threshold",v_llinth);
		    ctlposition(c_llinth, gad_x + 10, ui_offset_y, 75 + 116, gad_h, 116);

			gad_prev_w = 75 + 116 + 10;

		    c_llinrmin = ctlinteger("Min Recursion",v_llinrmin);
		    ctlposition(c_llinrmin, gad_x + gad_prev_w + ui_spacing, ui_offset_y, 52 + 77, gad_h, 77);

			gad_prev_w += 52 + 77 + 10;

		    c_llinrmax = ctlinteger("Max",v_llinrmax);
		    ctlposition(c_llinrmax, gad_x + gad_prev_w + ui_spacing, ui_offset_y, 53 + 26, gad_h, 26);

		    ui_offset_y += ui_row_offset;

		    c_lumith = ctlnumber("Luminosity Threshold",v_lumith);
		    ctlposition(c_lumith, gad_x + 10, ui_offset_y, 75 + 116, gad_h, 116);

			gad_prev_w = 75 + 116 + 10;

		    c_lumirmin = ctlinteger("Min Rays",v_lumirmin);
		    ctlposition(c_lumirmin, gad_x + gad_prev_w + ui_spacing, ui_offset_y, 52 + 77, gad_h, 77);
		    
			gad_prev_w += 52 + 77 + 10;

			c_lumirmax = ctlinteger("Max",v_lumirmax);
		    ctlposition(c_lumirmax, gad_x + gad_prev_w + ui_spacing, ui_offset_y, 53 + 26, gad_h, 26);

		    ui_offset_y += ui_row_offset + ui_sep_spacing;

		    c_blur_text=ctltext("","Reflection / Refraction Quality:");
		    ctlposition(c_blur_text, gad_x + 10, ui_offset_y - 8, 100,gad_h, gad_text_offset);

		    c_sep11 = ctlsep(0, ui_seperator_w + 4);
		    ctlposition(c_sep11, 162, ui_offset_y);
		    ui_offset_y += ui_sep_spacing + 3;

		    c_refth = ctlnumber("Blurring Threshold",v_refth);
		    ctlposition(c_refth, gad_x + 10, ui_offset_y, 75 + 116, gad_h, 116);

			gad_prev_w = 75 + 116 + 10;

		    c_refrmin = ctlinteger("Min Rays",v_refrmin);
		    ctlposition(c_refrmin, gad_x + gad_prev_w + ui_spacing, ui_offset_y, 52 + 77, gad_h, 77);

			gad_prev_w += 52 + 77 + 10;

		    c_refrmax = ctlinteger("Max",v_refrmax);
		    ctlposition(c_refrmax, gad_x + gad_prev_w + ui_spacing, ui_offset_y, 53 + 26, gad_h, 26);

		    ui_offset_y += ui_row_offset;

		    c_refacth = ctlpercent("Blurring Accuracy Limit",v_refacth);
		    ctlposition(c_refacth, gad_x + 10, ui_offset_y, 75 + 116 - 22, gad_h, 116);

			gad_prev_w = 75 + 116 - 22;

			c_refmodel = ctlcheckbox("Trace Direct Light Reflections",v_refmodel);
			ctlposition(c_refmodel, gad_x + gad_prev_w + ui_spacing, ui_offset_y, 194 + 24 + 32, gad_h, 32);

		    ui_offset_y += ui_row_offset + ui_sep_spacing;

		    c_memm_text=ctltext("","Memory Management:");
		    ctlposition(c_memm_text, gad_x + 10, ui_offset_y - 8, 100,gad_h, gad_text_offset);

		    c_sepm11 = ctlsep(0, ui_seperator_w + 4);
		    ctlposition(c_sepm11, 118, ui_offset_y);
		    ui_offset_y += ui_sep_spacing + 3;

		    c_octdepth = ctlpopup("Octree Detail",v_octdepth,@"Very Low","Low","Normal","High"@);
		    ctlposition(c_octdepth, gad_x, ui_offset_y, gad_w, gad_h, gad_text_offset);

		    ctlactive(c_quality_preset,"is_1",c_planth,c_planrmin,c_planrmax,c_llinth,c_llinrmin,c_llinrmax,c_lumith,c_lumirmin,c_lumirmax,c_refth,c_refrmin,c_refrmax,c_refacth,c_refmodel,c_octdepth);

		    /*    ypos=footer;
		    c_sep_last5 = ctlsep(10,sepwidth);
		    ctlposition(c_sep_last5,10,ypos+ysize/2);ypos=ypos+ysize;
		    c_rendersingle5 = ctlbutton("Render frame",0,"rendersingle");
		    ctlposition(c_rendersingle5,10,ypos,160,19,0);
		    c_rendersequence5 = ctlbutton("Render sequence",0,"rendersequence");
		    ctlposition(c_rendersequence5,270,ypos,160,19,0);*/

		    ctlpage(5,
			//c_rendersequence5,c_rendersingle5,c_sep_last5,
			c_sep11,c_refth,c_refrmin,c_refrmax,c_sepm11,c_refacth,c_refmodel,
			c_planth,c_planrmin,c_planrmax,
			c_llinth,c_llinrmin,c_llinrmax,
			c_lumith,c_lumirmin,c_lumirmax,c_octdepth,
			c_memm_text,
			c_conetoarea,c_blur_text,
			c_quality_preset,c_sep_qua,c_autolumi,c_lg,c_pl,c_areaside,
			c_areavis,c_light_qsep,c_light_qtext);

			// Kray Plugins Tab

		    // Reset ui_offset_y value
			if (lscomringactive()){
				ui_offset_y = ui_tab_bottom + (ui_spacing*2);

				ui_offset_y += ui_sep_spacing;

				c_open_physky	= ctlbutton("Add / Edit Physical Sky",0,"add_kray_physky");
				ctlposition(c_open_physky, gad_x + 10, ui_offset_y, 220, gad_h, 50);

				c_remove_physky	= ctlbutton("Remove",0,"remove_kray_physky");
				ctlposition(c_remove_physky, gad_x + 180 + ui_spacing, ui_offset_y, 125, gad_h, 50);

				c_disable_physky	= ctlcheckbox("Enable", v_disable_physky);
				ctlposition(c_disable_physky, gad_x + 255 + ui_spacing*2, ui_offset_y, 125, gad_h, 50);
				ctlrefresh(c_disable_physky,"toggle_kray_physky");

				check_gadget_active(c_disable_physky,"KrayPhySky");

				ui_offset_y += ui_sep_spacing;
				ui_offset_y += ui_sep_spacing;

				c_open_quicklwf	= ctlbutton("Add / Edit QuickLWF",0,"add_kray_quicklwf");
				ctlposition(c_open_quicklwf, gad_x + 10, ui_offset_y, 220, gad_h, 50);

				c_remove_quicklwf	= ctlbutton("Remove",0,"remove_kray_quicklwf");
				ctlposition(c_remove_quicklwf, gad_x + 180 + ui_spacing, ui_offset_y, 125, gad_h, 50);

				c_disable_quicklwf	= ctlcheckbox("Enable", v_disable_quicklwf);
				ctlposition(c_disable_quicklwf, gad_x + 255 + ui_spacing*2, ui_offset_y, 125, gad_h, 50);
				ctlrefresh(c_disable_quicklwf,"toggle_kray_quicklwf");

				check_gadget_active(c_disable_quicklwf,"KrayQuickLWF");

				ui_offset_y += ui_sep_spacing;
				ui_offset_y += ui_sep_spacing;

				c_open_tonemapblend	= ctlbutton("Add / Edit Tonemap Blend",0,"add_kray_tonemapblend");
				ctlposition(c_open_tonemapblend, gad_x + 10, ui_offset_y, 220, gad_h, 50);

				c_remove_tonemapblend	= ctlbutton("Remove",0,"remove_kray_tonemapblend");
				ctlposition(c_remove_tonemapblend, gad_x + 180 + ui_spacing, ui_offset_y, 125, gad_h, 50);

				c_disable_tonemapblend	= ctlcheckbox("Enable", v_disable_tonemapblend);
				ctlposition(c_disable_tonemapblend, gad_x + 255 + ui_spacing*2, ui_offset_y, 125, gad_h, 50);
				ctlrefresh(c_disable_tonemapblend,"toggle_kray_tonemapblend");

				check_gadget_active(c_disable_tonemapblend,"KrayTonemapBlending");

				ui_offset_y += ui_sep_spacing;
				ui_offset_y += ui_sep_spacing;

				c_open_override	= ctlbutton("Add / Edit Override",0,"add_kray_override");
				ctlposition(c_open_override, gad_x + 10, ui_offset_y, 220, gad_h, 50);

				c_remove_override	= ctlbutton("Remove",0,"remove_kray_override");
				ctlposition(c_remove_override, gad_x + 180 + ui_spacing, ui_offset_y, 125, gad_h, 50);

				c_disable_override	= ctlcheckbox("Enable", v_disable_override);
				ctlposition(c_disable_override, gad_x + 255 + ui_spacing*2, ui_offset_y, 125, gad_h, 50);
				ctlrefresh(c_disable_override,"toggle_kray_override");

				check_gadget_active(c_disable_override,"KrayOverride");

				ui_offset_y += ui_sep_spacing;
				ui_offset_y += ui_sep_spacing;

				c_open_buffers	= ctlbutton("Add / Edit Buffers",0,"add_kray_buffers");
				ctlposition(c_open_buffers, gad_x + 10, ui_offset_y, 220, gad_h, 50);

				c_remove_buffers	= ctlbutton("Remove",0,"remove_kray_buffers");
				ctlposition(c_remove_buffers, gad_x + 180 + ui_spacing, ui_offset_y, 125, gad_h, 50);

				c_disable_buffers	= ctlcheckbox("Enable", v_disable_buffers);
				ctlposition(c_disable_buffers, gad_x + 255 + ui_spacing*2, ui_offset_y, 125, gad_h, 50);
				ctlrefresh(c_disable_buffers,"toggle_kray_buffers");

				check_gadget_active(c_disable_buffers,"KrayBuffers");

				ui_offset_y += ui_sep_spacing;
				ui_offset_y += ui_sep_spacing;

				c_disable_instances	= ctlcheckbox("Use Kray Instances", v_disable_instances);
				ctlposition(c_disable_instances, gad_x + 10, ui_offset_y, 220, gad_h, 50);
				ctlrefresh(c_disable_instances,"toggle_kray_instances");
				
				// Define gadgets associated with tab 6
				ctlpage(6,
				c_open_physky, c_remove_physky, c_disable_physky,
				c_open_quicklwf, c_remove_quicklwf, c_disable_quicklwf,
				c_open_tonemapblend, c_remove_tonemapblend, c_disable_tonemapblend,
				c_open_override, c_remove_override, c_disable_override,
				c_open_buffers, c_remove_buffers, c_disable_buffers,
				c_disable_instances
				);
			}
			
		// MISC Tab
		
			xOffset = 10;
			OnSwitchWidth = 100;
			xStart = 5;
			textw = 240;
			SecondSwitchWidth = ui_window_w - textw - OnSwitchWidth - xOffset*2 - xStart;
		    // Reset ui_offset_y value
			
		    ui_offset_y = ui_tab_bottom + (ui_spacing*2);
			ui_offset_y += ui_sep_spacing;

			//Logfile
			c_LogOn = ctlcheckbox("Logfile",v_LogOn);
			ctlposition(c_LogOn, xOffset, ui_offset_y, OnSwitchWidth, gad_h, xStart);

		    c_Logfile = ctlfilename("",v_Logfile,0,0);
			offout = OnSwitchWidth + ui_spacing;			
		    ctlposition(c_Logfile, xOffset + offout, ui_offset_y, OnSwitchWidth + textw + ui_spacing - offout - 23, gad_h, 0 );
			
			offout = OnSwitchWidth + textw + ui_spacing;
			c_Debug = ctlcheckbox("Debug",v_Debug);
			ctlposition(c_Debug, xOffset + offout, ui_offset_y, SecondSwitchWidth, gad_h, xStart);			
			
			ctlactive(c_LogOn,"is_1",c_Logfile);
			ui_offset_y += ui_row_offset;
			
			//Renderinfo
			c_InfoOn = ctlcheckbox("Info Stamp",v_InfoOn);
			ctlposition(c_InfoOn, xOffset, ui_offset_y, OnSwitchWidth, gad_h, xStart);

		    c_InfoText = ctlstring("",v_InfoText);
			offout = OnSwitchWidth + ui_spacing;
		    ctlposition(c_InfoText, xOffset + offout, ui_offset_y, OnSwitchWidth + textw + ui_spacing - offout, gad_h, 0 );

		    c_RenderIinfoAdd = ctlpopup("",1,renderinfo_list);
			offout = OnSwitchWidth + textw + ui_spacing;
			ctlposition(c_RenderIinfoAdd, xOffset + offout, ui_offset_y, SecondSwitchWidth, gad_h, xStart);			
		    ctlrefresh(c_RenderIinfoAdd,"refresh_renderinfo_add");
			
			ctlactive(c_InfoOn,"is_1",c_InfoText,c_RenderIinfoAdd);
			ui_offset_y += ui_row_offset;
			
			//Include
			c_IncludeOn = ctlcheckbox("Include",v_IncludeOn);
			ctlposition(c_IncludeOn, xOffset, ui_offset_y, OnSwitchWidth, gad_h, xStart);

		    c_IncludeFile = ctlfilename("",v_IncludeFile,0,0);
			offout = OnSwitchWidth + ui_spacing;			
		    ctlposition(c_IncludeFile, xOffset + offout, ui_offset_y, OnSwitchWidth + textw + ui_spacing - offout - 23, gad_h, 0 );
			
			ctlactive(c_IncludeOn,"is_1",c_IncludeFile);
			ui_offset_y += ui_row_offset*2;

			//SWITCHES
			
			OnSwitchWidth = ui_window_w * 0.5 - (xStart * 2) - ui_spacing;
			// Full render preview
			c_FullPrev = ctlcheckbox("Full size preview",v_FullPrev);
			ctlposition(c_FullPrev, xOffset, ui_offset_y, OnSwitchWidth, gad_h, xStart);
			
			// Finishclose
			c_Finishclose = ctlcheckbox("Close preview on finish",v_Finishclose);
			ctlposition(c_Finishclose, xOffset + OnSwitchWidth + ui_spacing, ui_offset_y, OnSwitchWidth, gad_h, xStart);
			ui_offset_y += ui_row_offset;
			
			// unseenbyrays_affectsgi 1;
			c_UBRAGI = ctlcheckbox("Unseen by rays casts light",v_UBRAGI);
			ctlposition(c_UBRAGI, xOffset, ui_offset_y, OnSwitchWidth, gad_h, xStart);
			
			// outputtolw 1;
			c_outputtolw = ctlcheckbox("Also output to LW",v_outputtolw);
			ctlposition(c_outputtolw, xOffset + OnSwitchWidth + ui_spacing, ui_offset_y, OnSwitchWidth, gad_h, xStart);
			
			ui_offset_y += ui_row_offset*2;
		
		// HEADER TAILER COMMANDS
			OnSwitchWidth = 100;
			

			// Header commands text entry
		    c_prescript = ctlstring("Header Cmds",v_prescript);
		    ctlposition(c_prescript, xOffset, ui_offset_y, OnSwitchWidth + textw + ui_spacing, gad_h, gad_text_offset);
			// Header commands add button
		    c_headeradd = ctlpopup("",1,header_list);
			offout = OnSwitchWidth + textw + ui_spacing;
		    ctlposition(c_headeradd, xOffset + offout, ui_offset_y, SecondSwitchWidth, gad_h, xStart);

		    ctlrefresh(c_headeradd,"refresh_header_add");

		    ui_offset_y += ui_row_offset;

			// Footer commands text entry
		    c_postscript = ctlstring("Footer Cmds",v_postscript);
		    ctlposition(c_postscript, xOffset, ui_offset_y, OnSwitchWidth + textw + ui_spacing, gad_h, gad_text_offset);
			// Footer commands add button
		    c_taileradd = ctlpopup("",1,tailer_list);
		    ctlposition(c_taileradd, xOffset + offout, ui_offset_y, SecondSwitchWidth, gad_h, xStart);

		    ctlrefresh(c_taileradd,"refresh_tailer_add");


			ctlpage(7,
			c_LogOn,c_Logfile,c_Debug,c_InfoOn,c_InfoText,c_RenderIinfoAdd,
			c_IncludeOn,c_IncludeFile,c_FullPrev,c_Finishclose,c_UBRAGI,c_outputtolw,
			c_prescript,c_postscript,c_headeradd,c_taileradd
			);


	    if (create_flag==1){
			photons_presets(v_gph_preset);
			caustics_presets(v_cph_preset);
			fg_presets(v_fg_preset);
			aa_presets(v_aa_preset);
			quality_presets(v_quality_preset);
			create_flag=0;
	    }

	    guisetup_flag=1;

	    if (modal){
			return if !reqpost();
			get_values();
			reqend();
	    }else{
			reqopen();
	    }
	}

// Redraw custom drawing on requester
req_redraw
{
	// User Interface Layout Variables

	gad_x				= 0;								// Gadget X coord
	gad_y				= 24;								// Gadget Y coord
	gad_w				= 260;								// Gadget width
	gad_h				= 19;								// Gadget height
	gad_text_offset		= 100;								// Gadget text offset
	gad_prev_w			= 0;								// Previous gadget width temp variable

	ui_window_w			= 440;								// Window width
	ui_window_h			= 610 + modal * 40;					// Window height
	ui_banner_height	= 53;								// Height of banner graphic
	ui_spacing			= 3;								// Spacing gap size

	ui_offset_x 		= 0;								// Main X offset from 0
	ui_offset_y 		= ui_banner_height+(ui_spacing*2);	// Main Y offset from 0
	ui_row				= 0;								// Row number
	ui_column			= 0;								// Column number
	ui_tab_offset		= ui_offset_y + 23;					// Offset for tab height
	ui_seperator_w		= ui_window_w + 2;					// Width of seperators
	ui_row_offset		= gad_h + ui_spacing;				// Row offset

	ui_tab_bottom		= ui_offset_y + ui_row_offset + ui_spacing + gad_h - 1; // The bottom of the tab gadgets

	// drawline(<060,061,063>, 0, 100, ui_window_w, 100); // Shadow
	// drawline(<156,157,159>, 0, 101, ui_window_w, 101); // Highlight

	// Draw line underneath tabs (UI beautification!)
	drawline(<060,061,063>, 0, ui_tab_bottom, ui_window_w, ui_tab_bottom);
}

add_kray_physky
{
	p = "KrayPhySky";
	if(!is_plugin_attached(p))
	{
		add_plugin(p);
		c_disable_physky.active(true);
		EditServer("MasterHandler", get_plugin(p));
	}else
	{
		EditServer("MasterHandler", get_plugin(p));
	}
}

remove_kray_physky
{
	p = "KrayPhySky";
	remove_plugin(p);
	check_gadget_active(c_disable_physky, p);
}

add_kray_quicklwf
{
	p = "KrayQuickLWF";
	if(!is_plugin_attached(p))
	{
		add_plugin(p);
		c_disable_quicklwf.active(true);
		EditServer("MasterHandler", get_plugin(p));
	}else
	{
		EditServer("MasterHandler", get_plugin(p));
	}
}

remove_kray_quicklwf
{
	p = "KrayQuickLWF";
	remove_plugin(p);
	check_gadget_active(c_disable_quicklwf, p);
}

add_kray_tonemapblend
{
	p = "KrayTonemapBlending";
	if(!is_plugin_attached(p))
	{
		add_plugin(p);
		c_disable_tonemapblend.active(true);
		EditServer("MasterHandler", get_plugin(p));
	}else
	{
		EditServer("MasterHandler", get_plugin(p));
	}
}

remove_kray_tonemapblend
{
	p = "KrayTonemapBlending";
	remove_plugin(p);
	check_gadget_active(c_disable_tonemapblend, p);
}

add_kray_override
{
	p = "KrayOverride";
	if(!is_plugin_attached(p))
	{
		add_plugin(p);
		c_disable_override.active(true);
		EditServer("MasterHandler", get_plugin(p));
	}else
	{
		EditServer("MasterHandler", get_plugin(p));
	}
}

remove_kray_override
{
	p = "KrayOverride";
	remove_plugin(p);
	check_gadget_active(c_disable_override, p);
}

add_kray_buffers
{
	p = "KrayBuffers";
	if(!is_plugin_attached(p))
	{
		add_plugin(p);
		c_disable_buffers.active(true);
		EditServer("MasterHandler", get_plugin(p));
	}else
	{
		EditServer("MasterHandler", get_plugin(p));
	}
}

remove_kray_buffers
{
	p = "KrayBuffers";
	remove_plugin(p);
	check_gadget_active(c_disable_buffers, p);
}

toggle_kray_physky: value
{
    send_comring_message(2,1,value);
}

toggle_kray_quicklwf: value
{
    send_comring_message(3,1,value);
}

toggle_kray_tonemapblend: value
{
    send_comring_message(4,1,value);
}

toggle_kray_override: value
{
    send_comring_message(5,1,value);
}

toggle_kray_buffers: value
{
    send_comring_message(6,1,value);
}

toggle_kray_instances: value
{
    send_comring_message(7,1,value);
}

add_plugin: PLUGIN
{
	success = false;

	if(ApplyServer("MasterHandler", PLUGIN))
		success = true;

  	return success;
}

remove_plugin: PLUGIN
{
	success = false;

 	if(is_plugin_attached(PLUGIN))
	{
		RemoveServer("MasterHandler", get_plugin(PLUGIN));
		success = true;
	}

  	return success;
}

get_plugin: PLUGIN
{
	/* Reset break variable */
	plugin_location = 0;

	/* Refresh the list of Master Plugins attached to the scene */
	applied_master_scripts = Scene().server("MasterHandler");

	/* If a list exists ... */
	if(applied_master_scripts)
	{
		/* Get the size of the array */
		counter = size(applied_master_scripts);

		/* Loop through until we find the plugin */
		for(loop = 1; loop <= counter; loop++)
		{
        	if(applied_master_scripts[loop] == PLUGIN)
			{
				plugin_location = loop;
				break;
			}
		}
	}
	return plugin_location;
}

is_plugin_attached: PLUGIN
{
	/* Set the break variable */
    is_attached = false;

	/* Store a list of Master Plugins attached to the scene */
    applied_master_scripts = Scene().server("MasterHandler");

	/* If a list exists ... */
    if(applied_master_scripts)
    {
    	/* Get the size of the array */
        counter = size(applied_master_scripts);

		/* Loop through until we find the plugin */
        for(loop = 1; loop <= counter; loop++){
            if(applied_master_scripts[loop] == PLUGIN){
                is_attached = true;
                break;
            }
        }
    }
    return is_attached;
}

check_gadget_active: GADGET, PLUGIN
{
	if(is_plugin_attached(PLUGIN))
	{
		GADGET.active(true);
	}else
	{
		GADGET.active(false);
	}
}

send_comring_message: dest, from, value
{
	if (lscomringactive()){
		comringdata_out = comringencode(@"i","i","i"@,dest,from,value);
		comringmsg(KRAY_COMRING, 1, comringdata_out);
	}
}

msg_kray_physky2: value
{
	if (lscomringactive()){
		v_planrmin=getvalue(c_planrmin);
		v_planrmax=getvalue(c_planrmax);
		
		comringdata_out = comringencode(@"i","i","i","i"@,2,1,v_planrmin,v_planrmax);
		comringmsg(KRAY_COMRING, 2, comringdata_out);
	}
}

process_comring_message: eventCode, dataPointer
{
	if(eventCode == 1)
	{
		(dest,from,state) = comringdecode(@"i","i","i"@, dataPointer);

		// Message from PhySky Plugin
		if(dest == 1 && from == 2)
		{
			if(reqisopen())
			{
				setvalue(c_disable_physky, state);
				c_disable_physky.active(true);
			}

			v_disable_physky = state;
		}

		// Message from QuickLWF Plugin
		if(dest == 1 && from == 3)
		{
			if(reqisopen())
			{
				setvalue(c_disable_quicklwf, state);
				c_disable_quicklwf.active(true);
			}
			v_disable_quicklwf = state;
		}


		// Message from TonemapBlend Plugin
		if(dest == 1 && from == 4)
		{
			if(reqisopen())
			{
				setvalue(c_disable_tonemapblend, state);
				c_disable_tonemapblend.active(true);
			}

			v_disable_tonemapblend = state;
		}

		// Message from Override Plugin
		if(dest == 1 && from == 5)
		{
			if(reqisopen())
			{
				setvalue(c_disable_override, state);
				c_disable_override.active(true);
			}

			v_disable_override = state;
		}

		// Message from Buffers Plugin
		if(dest == 1 && from == 6)
		{
			if(reqisopen())
			{
				setvalue(c_disable_buffers, state);
				c_disable_buffers.active(true);
			}

			v_disable_buffers = state;
		}
		
		// Message from Instances Plugin
		if(dest == 1 && from == 7)
		{
		 //info(dest," - ",from);
			if(reqisopen())
			{
				setvalue(c_disable_instances, state);
				c_disable_instances.active(true);
			}

			v_disable_instances = state;
		}
	}

}