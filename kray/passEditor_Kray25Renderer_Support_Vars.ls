// Kray variables taken directly from Kray.ls
krayfile;

// Hack to work around plugin setting index changes as settingIndex is not global
krayPluginSettingIndexHandler = 0;

maxlinelength = 30;

	//general tab
	kray25_c_general_preset;
	kray25_c_gi;
	kray25_v_gi=1;				// Diffuse model 2=photon estimate
	kray25_c_gicaustics;
	kray25_v_gicaustics = 0; // Photon mapping caustics
	kray25_c_giirrgrad;
	kray25_v_giirrgrad = 1;	// Cached irradiance
	kray25_c_gipmmode;
	kray25_v_gipmmode = 3;		// Photons estimate 2=global unfiltered
	kray25_c_girtdirect;
	kray25_v_girtdirect=0;		// Precomputed filtered raytrace direct 1=on

	kray25_c_lg;
	kray25_v_lg=1;				// Luminosity model 1=indirect 2=direct 3=auto
	kray25_c_autolumi;
	kray25_v_autolumi=1;		// Level 1=100%

	kray25_c_pl;
	kray25_v_pl=1;				// Area lights 1=Compute sparately 2=Compute with luminosity
	
	kray25_c_output_On;
	kray25_v_output_On=0;
	kray25_c_outname;
	kray25_v_outname="kray_render.png";	// File name
	kray25_c_outfmt;
	kray25_v_outfmt=3;						// Format 1=HDR,JPG,PNG,PNGA,TIF,TIFA,TGA,TGAA,BMP,10=BMPA

	kray25_c_limitdr;
	kray25_v_limitdr=1;	//LimitDR

	kray25_c_shgi;
	kray25_v_shgi=1;						// shared gi 1=independant

	kray25_c_resetoct;
	kray25_v_resetoct=0;	//Allow animation

	kray25_c_tiphotons;
	kray25_v_tiphotons=1; 

	kray25_c_tifg;
	kray25_v_tifg=1;
	kray25_c_tiframes;
	kray25_v_tiframes=1;
	kray25_c_tiextinction;
	kray25_v_tiextinction=0;
	kray25_v_render0=0;
	kray25_c_render0;

	kray25_c_tmo;
	kray25_v_tmo=2;		// Tone mapping mode 1=linear 2=gamma 3=exponential
	kray25_c_tmhsv;
	kray25_v_tmhsv=0;		// HSV 0=off 1=on
	kray25_c_outparam;
	kray25_v_outparam=1;   // Parameter
	kray25_c_outexp;
	kray25_v_outexp=1;     // Exposure

	kray25_c_giload;
	kray25_v_giload="kraydata.gi";	// gi file name
	kray25_c_ginew;
	kray25_v_ginew=2;		// shared gi 2=saved

	kray25_c_prep;
	kray25_v_prep=0;		// Prerender
	kray25_c_prestep;		// Prerender steps
	kray25_v_prestep=1;
	kray25_c_preSplDet;	// Prerender splotch detection
	kray25_v_preSplDet=0.01;
	kray25_c_gradNeighbour;	// Gradients neighbour sensitivity
	kray25_v_gradNeighbour=0.1;

	kray25_c_pxlordr;
	kray25_v_pxlordr=1;	// Pixel order
	kray25_c_underf;
	kray25_v_underf=1;		// Undersample 1=none
	kray25_c_undert;
	kray25_v_undert=0;  // Undersample threshold

	kray25_v_areavis=2;	// area light visibility 1=visible
	kray25_c_areavis;
	kray25_v_areaside=0;	// area light sideness 1=double sided
	kray25_c_areaside;
	// photons tab
	kray25_c_cph_preset;
	kray25_v_cph_preset=2;

	kray25_c_gph_preset;
	kray25_v_gph_preset=2;

	kray25_c_girauto;
	kray25_v_girauto=1;	// Use global autophotons 1=on

	kray25_c_showphotons;
	kray25_v_showphotons=0;

	kray25_c_cmatic;
	kray25_v_cmatic=1;
	kray25_c_cf;
	kray25_v_cf=0;
	kray25_c_cfunit;
	kray25_v_cfunit=1;
	kray25_c_gf;
	kray25_v_gf=0;
	kray25_c_gmode;
	kray25_v_gmode=1;
	kray25_c_gfunit;
	kray25_v_gfunit=1;
	kray25_c_gir;
	kray25_v_gir=1;		// GI resolution

	kray25_c_clow;
	kray25_v_clow=0;
	kray25_c_chigh;
	kray25_v_chigh=0;
	kray25_c_cdyn;
	kray25_v_cdyn=0;
	kray25_c_cpstart;
	kray25_v_cpstart=0;
	kray25_c_cpstop;
	kray25_v_cpstop=0;
	kray25_c_cpstep;
	kray25_v_cpstep=0;
	kray25_c_cn;
	kray25_v_cn=0;
	// caustics autophotons
	kray25_c_gmatic;
	kray25_v_gmatic=0;
	kray25_c_gpstart;
	kray25_v_gpstart=1;
	kray25_c_gpstop;
	kray25_v_gpstop=0;
	kray25_c_gpstep;
	kray25_v_gpstep=0;
	kray25_c_gn;
	kray25_v_gn=0;

	kray25_c_glow;
	kray25_v_glow=0.4;
	kray25_c_ghigh;
	kray25_v_ghigh=0.8;
	kray25_c_gdyn;
	kray25_v_gdyn=3;

	kray25_c_ppsize;
	kray25_v_ppsize=0.5;	// precache distance
	kray25_c_ppblur;
	kray25_v_ppblur=0;
	kray25_c_ppmult;
	kray25_v_ppmult=1;		// photons power
	kray25_c_cmult;
	kray25_v_cmult=1;		// caustics power
	kray25_c_ppcaustics;
	kray25_v_ppcaustics=1; // ligtmap caustics 0=off
	// FG tab
	kray25_c_fg_preset;
	kray25_v_fg_preset=2;

	kray25_c_fgth;
	kray25_v_fgth=0;
	kray25_c_fgrmin;
	kray25_v_fgrmin=0;
	kray25_c_fgrmax;
	kray25_v_fgrmax=0;
	kray25_c_fga;
	kray25_v_fga=0;
	kray25_c_fgb;
	kray25_v_fgb=0;

	kray25_c_gir_copy;
	kray25_c_girauto_copy;
	kray25_v_fgmin=0;
	kray25_c_fgmin;
	kray25_v_fgmax=0;
	kray25_c_fgmax;
	kray25_v_fgscale=0;
	kray25_c_fgscale;
	kray25_v_fgblur=0;
	kray25_c_fgblur;
	kray25_v_fgshows=1;
	kray25_c_fgshows;
	kray25_v_fgsclr=@255,0,255@;
	kray25_c_fgsclr;

	kray25_v_fgreflections=1;
	kray25_c_fgreflections;
	kray25_v_fgrefractions=1;
	kray25_c_fgrefractions;

	kray25_v_cornerdist=0.5;
	kray25_c_cornerdist;
	kray25_v_cornerpaths=0;
	kray25_c_cornerpaths;
	// quality tab
	kray25_c_quality_preset;
	kray25_v_quality_preset=2;

	kray25_v_planth=0;
	kray25_c_planth;
	kray25_v_planrmin=0;
	kray25_c_planrmin;
	kray25_v_planrmax=0;
	kray25_c_planrmax;

	kray25_v_llinth=0;
	kray25_c_llinth;
	kray25_v_llinrmin=0;
	kray25_c_llinrmin;
	kray25_v_llinrmax=0;
	kray25_c_llinrmax;

	kray25_v_lumith=0;
	kray25_c_lumith;
	kray25_v_lumirmin=0;
	kray25_c_lumirmin;
	kray25_v_lumirmax=0;
	kray25_c_lumirmax;

	kray25_v_camobject=0;
	kray25_c_camobject;
	kray25_v_camuvname="";
	kray25_c_camuvname;
	
	kray25_c_eyesep;
	kray25_v_eyesep=0.01;
	kray25_c_stereoimages;
	kray25_v_stereoimages=3;
	
	kray25_c_errode;
	kray25_v_errode=4;
	
	kray25_v_cptype=1;
	kray25_c_cptype;

	kray25_v_lenspict="";
	kray25_c_lenspict;
	kray25_v_dofobj=1;
	kray25_c_dofobj;
	kray25_v_cstocvar=0;
	kray25_c_cstocvar;
	kray25_v_cstocmin=0;
	kray25_c_cstocmin;
	kray25_v_cstocmax=0;
	kray25_c_cstocmax;
	kray25_v_cmbsubframes=1;
	kray25_c_cmbsubframes;

	// Sampling tab
	kray25_c_aa_preset;
	kray25_v_aa_preset=2;

	kray25_c_aatype;
	kray25_v_aatype=1;
	kray25_c_aafscreen;
	kray25_v_aafscreen=1;

	kray25_c_aarandsmpl;
	kray25_v_aarandsmpl=kray25_v_cstocmin;

	kray25_c_aargsmpl;
	kray25_v_aargsmpl=3;
	kray25_c_aagridrotate;
	kray25_v_aagridrotate=0;

	kray25_c_refth;
	kray25_v_refth=0;
	kray25_c_refrmin;
	kray25_v_refrmin=0;
	kray25_c_refrmax;
	kray25_v_refrmax=0;
	kray25_c_refacth;
	kray25_v_refacth=1;
	kray25_c_refmodel;
	kray25_v_refmodel=0;

	kray25_c_conetoarea;
	kray25_v_conetoarea=0;

	kray25_c_octdepth;
	kray25_v_octdepth=3;

	kray25_c_prescript;
	kray25_v_prescript="";
	kray25_c_postscript;
	kray25_v_postscript="";
	// edgedetector
	kray25_c_edgeabs;
	kray25_v_edgeabs=0.1;
	kray25_c_edgerel;
	kray25_v_edgerel=0;
	kray25_c_edgenorm;
	kray25_v_edgenorm=0;
	kray25_c_edgezbuf;
	kray25_v_edgezbuf=0;
	kray25_c_edgeup;
	kray25_v_edgeup=1;
	kray25_c_edgethick;
	kray25_v_edgethick=1;
	kray25_c_edgeover;
	kray25_v_edgeover=1;
	// pixel filter
	kray25_c_pxlfltr;
	kray25_v_pxlfltr=1;
	kray25_c_pxlparam;
	kray25_v_pxlparam=0.5;

	kray25_c_headeradd;
	kray25_c_taileradd;

	create_flag=0;
	guisetup_flag=0;

	//Misc tab
	kray25_c_LogOn;
	kray25_v_LogOn=0;
	kray25_c_Logfile;
	kray25_v_Logfile="kraylog.txt";
	kray25_c_Debug;
	kray25_v_Debug=0;
	
	kray25_c_InfoOn;
	kray25_v_InfoOn=0;
	kray25_c_InfoText;
	kray25_v_InfoText="%kray% %ver% render time: %time% | %width% x %height%";	
	kray25_c_RenderIinfoAdd;
	
	kray25_c_IncludeOn;
	kray25_v_IncludeOn=0;
	kray25_c_IncludeFile;
	kray25_v_IncludeFile="";
	
	kray25_c_FullPrev;
	kray25_v_FullPrev=0;
	
	kray25_c_Finishclose;
	kray25_v_Finishclose=0;
	
	kray25_c_UBRAGI;
	kray25_v_UBRAGI=0;
	
	kray25_c_outputtolw;
	kray25_v_outputtolw=1;
	
	//Preset lists
	kray25_presets_list=@"Custom","Low","Medium","High","Uncached"@;
	kray25_presets_list2=@"Custom","Low","Medium","High","Uncached","Interior", "Exterior"@;
	kray25_general_presets_list=@"Select...","Custom","Low","Medium","High","Uncached","Static GI", "Animated GI"@;

	lsver
	{
		v=lscriptVersion();
		return v[2]*100+v[3]*10+v[4];
	}

//header/tailer commands
/*	kray25_header_list=@"Add ...",
				"previewsize 1280,800",
				"logfile 'kray_log.txt'",
				"showphstats",
				"octstats",
				"renderinfosize 0.5,10",
				"usemultipass 1"@;
	kray25_tailer_list=@"Add ...",
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
*/
	kray25_image_formats=@	"HDR High Dynamic Range (Radiance)",
					"JPG Joint Photographic experts Group",
					"PNG Portable Network Graphics",
					"PNG Portable Network Graphics +alpha",
					"TIF Tagged Image file Format",
					"TIF Tagged Image file Format +alpha",
					"TGA Truevision Graphics Adapter file",
					"TGA Truevision Graphics Adapter file +alpha",
					"BMP BitMaP",
					"BMP BitMaP +alpha"@;
	kray25_renderinfo_list=@"Add ...",
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
	kray25_dof_active=0;
	kray25_photon_map_model=20100;

	// scene settings
	kray25_v_single=false;
	kray25_tab0;
	kray25_active_tab=1;
