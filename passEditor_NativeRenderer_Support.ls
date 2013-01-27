// native renderer globals

// scnMaster override UI stuff
scnmasterOverride_UI_native: action
{
	// sel only used in edit action.
	// action should be either 'new' or 'edit'
	if (action == "new" || action == "edit")
	{
		doUpdate;
		if(action == "edit")
		{
			sel = getvalue(gad_OverridesListview).asInt();
			settingsArray = parseOverrideSettings(overrideSettings[sel]);
			overrideRenderer			= integer(settingsArray[3]);
			resolutionMultiplierSetts 	= integer(settingsArray[4]);
			renderModeSetts				= integer(settingsArray[5]);
			depthBufferAASetts 			= integer(settingsArray[6]);
			renderLinesSetts 			= integer(settingsArray[7]);
			rayRecursionLimitSetts 		= integer(settingsArray[8]);
			redirectBuffersSetts 		= integer(settingsArray[9]);
			disableAASetts 				= integer(settingsArray[10]);
			raytraceShadows 			= integer(settingsArray[11]);
			raytraceReflect 			= integer(settingsArray[12]);
			raytraceRefract 			= integer(settingsArray[13]);
			raytraceTrans 				= integer(settingsArray[14]);
			raytraceOccl 				= integer(settingsArray[15]);
			volumetricAA 				= integer(settingsArray[16]);
			gLensFlares 				= integer(settingsArray[17]);
			shadowMaps 					= integer(settingsArray[18]);
			volLights 					= integer(settingsArray[19]);
			twoSidedALgts 				= integer(settingsArray[20]);
			renderInstances				= integer(settingsArray[21]);
			rayPrecision 				= number(settingsArray[22]);
			rayCutoff 					= number(settingsArray[23]);
			shadingSamples 				= integer(settingsArray[24]);
			lightSamples 				= integer(settingsArray[25]);
			gLightIntensity 			= number(settingsArray[26]);
			gFlareIntensity 			= number(settingsArray[27]);
			enableGI 					= integer(settingsArray[28]);
			giMode 						= integer(settingsArray[29]);
			interpolateGI 				= integer(settingsArray[30]);
			blurBGGI 					= integer(settingsArray[31]);
			transparencyGI 				= integer(settingsArray[32]);
			volumetricGI 				= integer(settingsArray[33]);
			ambOcclGI 					= integer(settingsArray[34]);
			directionalGI 				= integer(settingsArray[35]);
			gradientsGI 				= integer(settingsArray[36]);
			behindTestGI 				= integer(settingsArray[37]);
			useBumpsGI 					= integer(settingsArray[38]);
			giIntensity 				= number(settingsArray[39]);
			giAngTol 					= number(settingsArray[40]);
			giIndBounces 				= integer(settingsArray[41]);
			giMinSpacing 				= number(settingsArray[42]);
			giRPE 						= integer(settingsArray[43]);
			giMaxSpacing 				= number(settingsArray[44]);
			gi2ndBounces				= integer(settingsArray[45]);
			giMultiplier				= number(settingsArray[46]);
			enableCaustics				= integer(settingsArray[47]);
			causticsAccuracy			= integer(settingsArray[48]);
			causticsIntensity			= number(settingsArray[49]);
			causticsSoftness			= integer(settingsArray[50]);
			fiberFXSaveRGBA				= integer(settingsArray[51]);
			fiberFXSaveRGBAType			= integer(settingsArray[52]);
			fiberFXSaveRGBAName			= string(settingsArray[53]);
			fiberFXSaveDepth			= integer(settingsArray[54]);
			fiberFXSaveDepthType		= integer(settingsArray[55]);
			fiberFXSaveDepthName		= string(settingsArray[56]);
			// fog
			fogType 					= integer(settingsArray[57]);
			fogColorArray 				= <settingsArray[58], settingsArray[59], settingsArray[60]>;
			fogBackdropColor			= integer(settingsArray[61]);
			// compositing
			useBackgroundColor			= integer(settingsArray[62]);
			backgroundColorArray		= <settingsArray[63], settingsArray[64], settingsArray[65]>;
			// backdrop
			backdropColorArray			= <settingsArray[66], settingsArray[67], settingsArray[68]>;
		}
	
		doKeys = 0;

		reqbeginstr = "New Scene Master Override";
		if(action == "edit")
		{
			reqbeginstr = "Edit Scene Master Override";
		}
		reqbegin(reqbeginstr);
		reqsize(ScnMst_ui_window_w, 725);

		newName = "SceneMasterOverride";
		if(action == "edit")
		{
			newName = settingsArray[1];
		}
		c20 = ctlstring("Override Name:",newName);
		ctlposition(c20, ScnMst_gad_x2, ScnMst_gad_y, ScnMst_gad_w, ScnMst_gad_h, ScnMst_gad_text_offset);
		
		ui_offset_y = ScnMst_ui_offset_y + ScnMst_ui_row_offset;

		resolutionMultiplierSetts = 3;
		if(action == "edit")
		{
			resolutionMultiplierSetts = integer(settingsArray[3]);
		}
		c20_5 = ctlpopup("Resolution Multiplier",resolutionMultiplierSetts,resolutionMultArray);
		ctlposition(c20_5, ScnMst_gad_x, ScnMst_gad_y + ui_offset_y, ScnMst_gad_w, ScnMst_gad_h, ScnMst_gad_text_offset);

		renderModeSetts = 3;
		if(action == "edit")
		{
			renderModeSetts = integer(settingsArray[4]);
		}
		c21 = ctlpopup("Render Mode",renderModeSetts,renderModeArray);
		ctlposition(c21, ScnMst_gad_x2, ScnMst_gad_y + ui_offset_y, ScnMst_gad_w, ScnMst_gad_h, ScnMst_gad_text_offset);

		fogType = 0;
		if(action == "edit")
		{
			fogType = integer(settingsArray[57]);
		}
		c73 = ctlpopup("Fog Type",fogType,fogTypeArray);
		ctlposition(c73, ScnMst_gad_x3, ScnMst_gad_y + ui_offset_y, ScnMst_gad_w, ScnMst_gad_h, ScnMst_gad_text_offset);

		ui_offset_y += ScnMst_ui_row_offset;

		c27val = 1;
		if(action == "edit")
		{
			c27val = raytraceShadows;
		}
		c27 = ctlcheckbox("RT Shadows",c27val);
		ctlposition(c27, ScnMst_gad_x, ScnMst_gad_y + ui_offset_y, ScnMst_gad_w, ScnMst_gad_h, ScnMst_gad_text_offset);

		c30val = 1;
		if(action == "edit")
		{
			c30val = raytraceReflect;
		}
		c30 = ctlcheckbox("RT Reflection",c30val);
		ctlposition(c30, ScnMst_gad_x2, ScnMst_gad_y + ui_offset_y, ScnMst_gad_w, ScnMst_gad_h, ScnMst_gad_text_offset);

		c74val = 255;
		if(action == "edit")
		{
			c74val = fogColorArray;
		}
		c74 = ctlcolor("Fog Color", c74val);
		ctlposition(c74, ScnMst_gad_x3, ScnMst_gad_y + ui_offset_y, ScnMst_gad_w, ScnMst_gad_h, ScnMst_gad_text_offset);

		ui_offset_y += ScnMst_ui_row_offset;

		c28val = 1;
		if(action == "edit")
		{
			c28val = raytraceTrans;
		}
		c28 = ctlcheckbox("RT Transparency",c28val);
		ctlposition(c28, ScnMst_gad_x, ScnMst_gad_y + ui_offset_y, ScnMst_gad_w, ScnMst_gad_h, ScnMst_gad_text_offset);

		c29val = 1;
		if(action == "edit")
		{
			c29val = raytraceRefract;
		}
		c29 = ctlcheckbox("RT Refraction",c29val);
		ctlposition(c29, ScnMst_gad_x2, ScnMst_gad_y + ui_offset_y, ScnMst_gad_w, ScnMst_gad_h, ScnMst_gad_text_offset);

		c75val = 0;
		if(action == "edit")
		{
			c75val = fogBackdropColor;
		}
		c75 = ctlcheckbox("Use Backdrop Color",c75val);
		ctlposition(c75, ScnMst_gad_x3, ScnMst_gad_y + ui_offset_y, ScnMst_gad_w, ScnMst_gad_h, ScnMst_gad_text_offset);

		ui_offset_y += ScnMst_ui_row_offset;

		c31val = 0;
		if(action == "edit")
		{
			c31val = raytraceOccl;
		}
		c31 = ctlcheckbox("RT Occlusion",c31val);
		ctlposition(c31, ScnMst_gad_x, ScnMst_gad_y + ui_offset_y, ScnMst_gad_w, ScnMst_gad_h, ScnMst_gad_text_offset);

		c22val = 0;
		if(action == "edit")
		{
			c22val = depthBufferAASetts;
		}
		c22 = ctlcheckbox("Depth Buffer AA",c22val);
		ctlposition(c22, ScnMst_gad_x2, ScnMst_gad_y + ui_offset_y, ScnMst_gad_w, ScnMst_gad_h, ScnMst_gad_text_offset);

		ui_offset_y += ScnMst_ui_row_offset;

		c23val = 1;
		if(action == "edit")
		{
			c23val = renderLinesSetts;
		}
		c23 = ctlcheckbox("Render Lines",c23val);
		ctlposition(c23, ScnMst_gad_x, ScnMst_gad_y + ui_offset_y, ScnMst_gad_w, ScnMst_gad_h, ScnMst_gad_text_offset);

		c37val = 1;
		if(action == "edit")
		{
			c37val = renderInstances;
		}
		if(hostVersion() >= 11.5) // feature only added in 11.5
		{
			c37 = ctlcheckbox("Render Instances",c37val);
			ctlposition(c37, ScnMst_gad_x2, ScnMst_gad_y + ui_offset_y, ScnMst_gad_w, ScnMst_gad_h, ScnMst_gad_text_offset);
		}

		ui_offset_y += ScnMst_ui_row_offset + 2;
		sep1 = ctlsep(0, ScnMst_ui_seperator_w + 4);
		ctlposition(sep1, -2, ScnMst_gad_y + ui_offset_y);
		ui_offset_y += ScnMst_ui_spacing_y + 2;

		c24val= 16;
		if(action == "edit")
		{
			c24val = rayRecursionLimitSetts;
		}
		c24 = ctlminislider("Ray Recursion Limit", c24val, 0, LWrecursionLimit);
		ctlposition(c24, ScnMst_gad_x, ScnMst_gad_y + ui_offset_y, ScnMst_gad_w - 22, ScnMst_gad_h, ScnMst_gad_text_offset);

		c40val = 1;  // 11.0 uses 8, 11.5 uses 1
		if(hostVersion() < 11.5)
			c40val = 8;
		if(action == "edit")
		{
			c40val = shadingSamples;
		}
		c40 = ctlnumber("Shading Samples:",c40val);
		ctlposition(c40, ScnMst_gad_x2, ScnMst_gad_y + ui_offset_y, ScnMst_gad_w, ScnMst_gad_h, ScnMst_gad_text_offset);

		compLabel = ctltext("", "Compositing");
		ctlposition(compLabel, ScnMst_gad_x3, ScnMst_gad_y + ui_offset_y, ScnMst_gad_w, ScnMst_gad_h, ScnMst_gad_text_offset);

		c76val = 0;
		if(action == "edit")
		{
			c76val = useBackgroundColor;
		}
		c76 = ctlcheckbox("Use Background Color",c76val);
		ctlposition(c76, ScnMst_gad_x3, ScnMst_gad_y + ui_offset_y, ScnMst_gad_w, ScnMst_gad_h, ScnMst_gad_text_offset);

		ui_offset_y += ScnMst_ui_row_offset;
		
		c38val = 6.0;
		if(action == "edit")
		{
			c38val = rayPrecision;
		}
		c38 = ctlnumber("Ray Precision:",c38val);
		ctlposition(c38, ScnMst_gad_x, ScnMst_gad_y + ui_offset_y, ScnMst_gad_w, ScnMst_gad_h, ScnMst_gad_text_offset);

		c41val = 1;  // 11.0 uses 8, 11.5 uses 1
		if(hostVersion() < 11.5)
			c41val = 8;
		if(action == "edit")
		{
			c41val = lightSamples;
		}
		c41 = ctlnumber("Light Samples:",c41val);
		ctlposition(c41, ScnMst_gad_x2, ScnMst_gad_y + ui_offset_y, ScnMst_gad_w, ScnMst_gad_h, ScnMst_gad_text_offset);

		c77val = 0;
		if(action == "edit")
		{
			c77val = backgroundColorArray;
		}
		c77 = ctlcolor("BG Color", c77val);
		ctlposition(c77, ScnMst_gad_x3, ScnMst_gad_y + ui_offset_y, ScnMst_gad_w, ScnMst_gad_h, ScnMst_gad_text_offset);

		ui_offset_y += ScnMst_ui_row_offset;
		
		c39val = 0.01;
		if(action == "edit")
		{
			c39val = rayCutoff;
		}
		c39 = ctlnumber("Ray Cutoff:",c39val);
		ctlposition(c39, ScnMst_gad_x, ScnMst_gad_y + ui_offset_y, ScnMst_gad_w, ScnMst_gad_h, ScnMst_gad_text_offset);

		ui_offset_y += ScnMst_ui_row_offset + 2;
		sep2 = ctlsep(0, ScnMst_ui_seperator_w + 4);
		ctlposition(sep2, -2, ScnMst_gad_y + ui_offset_y);
		ui_offset_y += ScnMst_ui_spacing_y + 2;

		c25val = 0;
		if(action == "edit")
		{
			c25val = redirectBuffersSetts;
		}
		c25 = ctlcheckbox("Redirect Buffer Export Paths",c25val);
		ctlposition(c25, ScnMst_gad_x, ScnMst_gad_y + ui_offset_y, ScnMst_gad_w, ScnMst_gad_h, ScnMst_gad_text_offset);

		c26val = 0;
		if(action == "edit")
		{
			c26val = disableAASetts;
		}
		c26 = ctlcheckbox("Disable all AA",c26val);
		ctlposition(c26, ScnMst_gad_x2, ScnMst_gad_y + ui_offset_y, ScnMst_gad_w, ScnMst_gad_h, ScnMst_gad_text_offset);

		ui_offset_y += ScnMst_ui_row_offset;

		c32val = 1;
		if(action == "edit")
		{
			c32val = volumetricAA;
		}
		c32 = ctlcheckbox("Volumetric AA",c32val);
		ctlposition(c32, ScnMst_gad_x2, ScnMst_gad_y + ui_offset_y, ScnMst_gad_w, ScnMst_gad_h, ScnMst_gad_text_offset);

		ui_offset_y += ScnMst_ui_row_offset + 2;
		sep3 = ctlsep(0, ScnMst_ui_seperator_w + 4);
		ctlposition(sep3, -2, ScnMst_gad_y + ui_offset_y);
		ui_offset_y += ScnMst_ui_spacing_y + 2;

		c42val = 1.0;
		if(action == "edit")
		{
			c42val = gLightIntensity;
		}
		c42 = ctlpercent("Light Intensity",c42val);
		ctlposition(c42, ScnMst_gad_x, ScnMst_gad_y + ui_offset_y, ScnMst_gad_w - 22, ScnMst_gad_h, ScnMst_gad_text_offset);

		c43val = 1.0;
		if(action == "edit")
		{
			c43val = gFlareIntensity;
		}
		c43 = ctlpercent("Flare Intensity",c43val);
		ctlposition(c43, ScnMst_gad_x2, ScnMst_gad_y + ui_offset_y, ScnMst_gad_w - 22, ScnMst_gad_h, ScnMst_gad_text_offset);

		ui_offset_y += ScnMst_ui_row_offset;

		c33val = 1;
		if(action == "edit")
		{
			c33val = gLensFlares;
		}
		c33 = ctlcheckbox("Lens Flares",c33val);
		ctlposition(c33, ScnMst_gad_x, ScnMst_gad_y + ui_offset_y, ScnMst_gad_w, ScnMst_gad_h, ScnMst_gad_text_offset);
		
		c34val = 1;
		if(action == "edit")
		{
			c34val = shadowMaps;
		}
		c34 = ctlcheckbox("Shadow Maps",c34val);
		ctlposition(c34, ScnMst_gad_x2, ScnMst_gad_y + ui_offset_y, ScnMst_gad_w, ScnMst_gad_h, ScnMst_gad_text_offset);

		ui_offset_y += ScnMst_ui_row_offset;

		c35val = 1;
		if(action == "edit")
		{
			c35val = volLights;
		}
		c35 = ctlcheckbox("Volumetric Lights",c35val);
		ctlposition(c35, ScnMst_gad_x, ScnMst_gad_y + ui_offset_y, ScnMst_gad_w, ScnMst_gad_h, ScnMst_gad_text_offset);

		c36val = 1;
		if(action == "edit")
		{
			c36val = twoSidedALgts;
		}
		c36 = ctlcheckbox("2 Sided Area Lights",c36val);
		ctlposition(c36, ScnMst_gad_x2, ScnMst_gad_y + ui_offset_y, ScnMst_gad_w, ScnMst_gad_h, ScnMst_gad_text_offset);

		ui_offset_y += ScnMst_ui_row_offset + 2;
		sep4 = ctlsep(0, ScnMst_ui_seperator_w + 4);
		ctlposition(sep4, -2, ScnMst_gad_y + ui_offset_y);
		ui_offset_y += ScnMst_ui_spacing_y + 2;

		c44val = 0;
		if(action == "edit")
		{
			c44val = enableGI;
		}
		c44 = ctlcheckbox("Enable Radiosity",c44val);
		ctlposition(c44, ScnMst_gad_x, ScnMst_gad_y + ui_offset_y, ScnMst_gad_w, ScnMst_gad_h, ScnMst_gad_text_offset);

		c45val = 2; // default to MC, matching LW.
		if(action == "edit")
		{
			c45val = giMode;
		}
		c45 = ctlpopup("Render Mode",c45val,giTypeArray);
		ctlposition(c45, ScnMst_gad_x2, ScnMst_gad_y + ui_offset_y, ScnMst_gad_w, ScnMst_gad_h, ScnMst_gad_text_offset);

		c78val = 0;
		if(action == "edit")
		{
			c78val = backdropColorArray;
		}
		c78 = ctlcolor("Backdrop Color", c78val);
		ctlposition(c78, ScnMst_gad_x3, ScnMst_gad_y + ui_offset_y, ScnMst_gad_w, ScnMst_gad_h, ScnMst_gad_text_offset);

		ui_offset_y += ScnMst_ui_row_offset;

		c46val = 1; // Match LW
		if(action == "edit")
		{
			c46val = interpolateGI;
		}
		c46 = ctlcheckbox("Interpolated",c46val);
		ctlposition(c46, ScnMst_gad_x, ScnMst_gad_y + ui_offset_y, ScnMst_gad_w, ScnMst_gad_h, ScnMst_gad_text_offset);

		c47val = 1; // Match LW
		if(action == "edit")
		{
			c47val = blurBGGI;
		}
		c47 = ctlcheckbox("Blur Background",c47val);
		ctlposition(c47, ScnMst_gad_x2, ScnMst_gad_y + ui_offset_y, ScnMst_gad_w, ScnMst_gad_h, ScnMst_gad_text_offset);

		ui_offset_y += ScnMst_ui_row_offset;
		
		c48val = 0; // Match LW
		if(action == "edit")
		{
			c48val = transparencyGI;
		}
		c48 = ctlcheckbox("Use Transparency",c48val);
		ctlposition(c48, ScnMst_gad_x, ScnMst_gad_y + ui_offset_y, ScnMst_gad_w, ScnMst_gad_h, ScnMst_gad_text_offset);

		c49val = 0; // Match LW
		if(action == "edit")
		{
			c49val = volumetricGI;
		}
		c49 = ctlcheckbox("Volumetric Radiosity",c49val);
		ctlposition(c49, ScnMst_gad_x2, ScnMst_gad_y + ui_offset_y, ScnMst_gad_w, ScnMst_gad_h, ScnMst_gad_text_offset);

		ui_offset_y += ScnMst_ui_row_offset;
		
		c50val = 0; // Match LW
		if(action == "edit")
		{
			c50val = ambOcclGI;
		}
		c50 = ctlcheckbox("Ambient Occlusion",c50val);
		ctlposition(c50, ScnMst_gad_x, ScnMst_gad_y + ui_offset_y, ScnMst_gad_w, ScnMst_gad_h, ScnMst_gad_text_offset);
		
		c51val = 0; // Match LW
		if(action == "edit")
		{
			c51val = directionalGI;
		}
		c51 = ctlcheckbox("Directional Rays",c51val);
		ctlposition(c51, ScnMst_gad_x2, ScnMst_gad_y + ui_offset_y, ScnMst_gad_w, ScnMst_gad_h, ScnMst_gad_text_offset);

		ui_offset_y += ScnMst_ui_row_offset;
		
		c52val = 0; // Match LW
		if(action == "edit")
		{
			c52val = gradientsGI;
		}
		c52 = ctlcheckbox("Use Gradients",c52val);
		ctlposition(c52, ScnMst_gad_x, ScnMst_gad_y + ui_offset_y, ScnMst_gad_w, ScnMst_gad_h, ScnMst_gad_text_offset);

		c53val = 0; // Match LW
		if(action == "edit")
		{
			c53val = behindTestGI;
		}
		c53 = ctlcheckbox("Use Behind Test",c53val);
		ctlposition(c53, ScnMst_gad_x2, ScnMst_gad_y + ui_offset_y, ScnMst_gad_w, ScnMst_gad_h, ScnMst_gad_text_offset);

		ui_offset_y += ScnMst_ui_row_offset;

		c54val = 0; // Match LW
		if(action == "edit")
		{
			c54val = useBumpsGI;
		}
		c54 = ctlcheckbox("Use Bumps",c54val);
		ctlposition(c54, ScnMst_gad_x2, ScnMst_gad_y + ui_offset_y, ScnMst_gad_w, ScnMst_gad_h, ScnMst_gad_text_offset);

		ui_offset_y += ScnMst_ui_row_offset;
		
		c55val = 1.0; // Match LW
		if(action == "edit")
		{
			c55val = giIntensity;
		}
		c55 = ctlpercent("Intensity",c55val);
		ctlposition(c55, ScnMst_gad_x, ScnMst_gad_y + ui_offset_y, ScnMst_gad_w - 22, ScnMst_gad_h, ScnMst_gad_text_offset);

		//FIXME - this might be totally broken - see comments below.
		c56val = 45.0;			 	// LW maps 0-90 degrees as 0-1.0.
									// 90 degrees is 0.5*pi, but LW insists on 1.0. Have to bodge it.
		if(action == "edit")
		{
			c56val = giAngTol;
		}
		c56 = ctlangle("Angular Tolerance",c56val);
		ctlposition(c56, ScnMst_gad_x2, ScnMst_gad_y + ui_offset_y, ScnMst_gad_w - 22, ScnMst_gad_h, ScnMst_gad_text_offset);

		ui_offset_y += ScnMst_ui_row_offset;
		
		c57val = 1; // Match LW
		if(action == "edit")
		{
			c57val = giIndBounces;
		}
		c57 = ctlpercent("Indirect Bounces",c57val);
		ctlposition(c57, ScnMst_gad_x, ScnMst_gad_y + ui_offset_y, ScnMst_gad_w - 22, ScnMst_gad_h, ScnMst_gad_text_offset);

		c58val = 3.0; // Match LW
		if(action == "edit")
		{
			c58val = giMinSpacing;
		}
		c58 = ctlnumber("Min Pixel Spacing",c58val);
		ctlposition(c58, ScnMst_gad_x2, ScnMst_gad_y + ui_offset_y, ScnMst_gad_w, ScnMst_gad_h, ScnMst_gad_text_offset);

		ui_offset_y += ScnMst_ui_row_offset;
		
		c59val = 100; // Match LW
		if(action == "edit")
		{
			c59val = giRPE;
		}
		c59 = ctlinteger("Rays/Evaluation",c59val);
		ctlposition(c59, ScnMst_gad_x, ScnMst_gad_y + ui_offset_y, ScnMst_gad_w, ScnMst_gad_h, ScnMst_gad_text_offset);
		
		c60val = 100.0; // Match LW
		if(action == "edit")
		{
			c60val = giMaxSpacing;
		}
		c60 = ctlnumber("Max Pixel Spacing",c60val);
		ctlposition(c60, ScnMst_gad_x2, ScnMst_gad_y + ui_offset_y, ScnMst_gad_w, ScnMst_gad_h, ScnMst_gad_text_offset);
		
		ui_offset_y += ScnMst_ui_row_offset;
		
		c61val = 50; // Match LW
		if(action == "edit")
		{
			c61val = gi2ndBounces;
		}
		c61 = ctlinteger("Secondary Bounce Rays",c61val);
		ctlposition(c61, ScnMst_gad_x, ScnMst_gad_y + ui_offset_y, ScnMst_gad_w, ScnMst_gad_h, ScnMst_gad_text_offset);

		c62val = 1.0; // Match LW
		if(action == "edit")
		{
			c62val = giMultiplier;
		}
		c62 = ctlpercent("Multiplier",c62val);
		ctlposition(c62, ScnMst_gad_x2, ScnMst_gad_y + ui_offset_y, ScnMst_gad_w - 22, ScnMst_gad_h, ScnMst_gad_text_offset);
		
		ui_offset_y += ScnMst_ui_row_offset + 2;
		sep5 = ctlsep(0, ScnMst_ui_seperator_w + 4);
		ctlposition(sep5, -2, ScnMst_gad_y + ui_offset_y);
		ui_offset_y += ScnMst_ui_spacing_y + 2;

		c63val = 0;
		if(action == "edit")
		{
			c63val = enableCaustics;
		}
		c63 = ctlcheckbox("Enable Caustics",c63val);
		ctlposition(c63, ScnMst_gad_x, ScnMst_gad_y + ui_offset_y, ScnMst_gad_w, ScnMst_gad_h, ScnMst_gad_text_offset);

		c64val = 100;
		if(action == "edit")
		{
			c64val = causticsAccuracy;
		}
		c64 = ctlinteger("Caustics Accuracy",c64val);
		ctlposition(c64, ScnMst_gad_x2, ScnMst_gad_y + ui_offset_y, ScnMst_gad_w, ScnMst_gad_h, ScnMst_gad_text_offset);

		ui_offset_y += ScnMst_ui_row_offset;

		c65val = 1.0;
		if(action == "edit")
		{
			c65val = causticsIntensity;
		}
		c65 = ctlpercent("Caustics Intensity",c65val);
		ctlposition(c65, ScnMst_gad_x, ScnMst_gad_y + ui_offset_y, ScnMst_gad_w - 22, ScnMst_gad_h, ScnMst_gad_text_offset);

		c66val = 20;
		if(action == "edit")
		{
			c66val = causticsSoftness;
		}
		c66 = ctlinteger("Caustics Softness",c66val);
		ctlposition(c66, ScnMst_gad_x2, ScnMst_gad_y + ui_offset_y, ScnMst_gad_w, ScnMst_gad_h, ScnMst_gad_text_offset);

		ui_offset_y += ScnMst_ui_row_offset + 2;
		sep6 = ctlsep(0, ScnMst_ui_seperator_w + 4);
		ctlposition(sep6, -2, ScnMst_gad_y + ui_offset_y);
		ui_offset_y += ScnMst_ui_spacing_y + 4;

		ffxLabel = ctltext("", "FiberFX");
		ctlposition(ffxLabel, ScnMst_gad_x, ScnMst_gad_y + ui_offset_y, ScnMst_gad_w, ScnMst_gad_h, ScnMst_gad_text_offset);

		ui_offset_y -= 2;

		c67val = 0;
		if(action == "edit")
		{
			c67val = fiberFXSaveRGBA;
		}
		c67 = ctlcheckbox("FFx Save RGBA",c67val);
		ctlposition(c67, ScnMst_gad_x, ScnMst_gad_y + ui_offset_y, ScnMst_gad_w, ScnMst_gad_h, ScnMst_gad_text_offset);

		c70val = 0;
		if(action == "edit")
		{
			c70val = fiberFXSaveDepth;
		}
		c70 = ctlcheckbox("FFx Save Depth",c70val);
		ctlposition(c70, ScnMst_gad_x2, ScnMst_gad_y + ui_offset_y, ScnMst_gad_w, ScnMst_gad_h, ScnMst_gad_text_offset);

		ui_offset_y += ScnMst_ui_row_offset;

		c68val = 0;
		if(action == "edit")
		{
			c68val = fiberFXSaveRGBAType;
		}
		c68 = ctlpopup("RGBA Type",c68val,image_formats_array);
		ctlposition(c68, ScnMst_gad_x, ScnMst_gad_y + ui_offset_y, ScnMst_gad_w, ScnMst_gad_h, ScnMst_gad_text_offset);

		c71val = 0;
		if(action == "edit")
		{
			c71val = fiberFXSaveDepthType;
		}
		c71 = ctlpopup("Depth Type",c71val,image_formats_array);
		ctlposition(c71, ScnMst_gad_x2, ScnMst_gad_y + ui_offset_y, ScnMst_gad_w, ScnMst_gad_h, ScnMst_gad_text_offset);

		ui_offset_y += ScnMst_ui_row_offset;

		c69val = "*.*";
		if(action == "edit")
		{
			c69val = fiberFXSaveRGBAName;
		}
		c69 = ctlfilename("Save ...", c69val,30,1);
		ctlposition(c69, ScnMst_gad_x, ScnMst_gad_y + ui_offset_y, ScnMst_gad_w - 22, ScnMst_gad_h, ScnMst_gad_text_offset);

		c72val = "*.*";
		if(action == "edit")
		{
			c72val = fiberFXSaveDepthName;
		}
		c72 = ctlfilename("Save ...", c72val,30,1);
		ctlposition(c72, ScnMst_gad_x2, ScnMst_gad_y + ui_offset_y, ScnMst_gad_w - 22, ScnMst_gad_h, ScnMst_gad_text_offset);

		if(reqpost())
		{
			newName 						= getvalue(c20);
			newName 						= makeStringGood(newName);
			overrideRenderer				= 1; // hard-coded.
			resolutionMultiplierSetts 		= getvalue(c20_5);
			renderModeSetts 				= getvalue(c21);
			depthBufferAASetts 				= getvalue(c22);
			renderLinesSetts 				= getvalue(c23);
			rayRecursionLimitSetts 			= getvalue(c24);
			redirectBuffersSetts 			= getvalue(c25);
			disableAASetts 					= getvalue(c26);
			raytraceShadows 				= getvalue(c27);
			raytraceTrans 					= getvalue(c28);
			raytraceRefract 				= getvalue(c29);
			raytraceReflect 				= getvalue(c30);
			raytraceOccl 					= getvalue(c31);
			volumetricAA 					= getvalue(c32);
			lensFlares 						= getvalue(c33);
			shadowMaps 						= getvalue(c34);
			volLights 						= getvalue(c35);
			twoSidedALgts 					= getvalue(c36);
			if(hostVersion() < 11.5)
			{
				renderInstances 			= 1; // force on in case scene pushed to 11.5 for render, no impact on < 11.5
			} else {
				renderInstances 			= getvalue(c37);
			}
			rayPrecision 					= getvalue(c38);
			rayCutoff 						= getvalue(c39);
			shadingSamples 					= getvalue(c40);
			lightSamples 					= getvalue(c41);
			lightIntensity 					= getvalue(c42);
			flareIntensity 					= getvalue(c43);
			enableGI 						= getvalue(c44);
			giMode 							= getvalue(c45);
			interpolateGI 					= getvalue(c46);
			blurBGGI 						= getvalue(c47);
			transparencyGI 					= getvalue(c48);
			volumetricGI 					= getvalue(c49);
			ambOcclGI 						= getvalue(c50);
			directionalGI 					= getvalue(c51);
			gradientsGI 					= getvalue(c52);
			behindTestGI 					= getvalue(c53);
			useBumpsGI 						= getvalue(c54);
			giIntensity 					= getvalue(c55);
			giAngTol 						= getvalue(c56);
			giIndBounces 					= getvalue(c57);
			giMinSpacing 					= getvalue(c58);
			giRPE 							= getvalue(c59);
			giMaxSpacing 					= getvalue(c60);
			gi2ndBounces 					= getvalue(c61);
			giMultiplier 					= getvalue(c62);
			enableCaustics 					= getvalue(c63);
			causticsAccuracy 				= getvalue(c64);
			causticsIntensity				= getvalue(c65);
			causticsSoftness				= getvalue(c66);
			fiberFXSaveRGBA					= getvalue(c67);
			fiberFXSaveRGBAType				= getvalue(c68);
			fiberFXSaveRGBAName				= getvalue(c69);
			fiberFXSaveDepth				= getvalue(c70);
			fiberFXSaveDepthType			= getvalue(c71);
			fiberFXSaveDepthName			= getvalue(c72);
			fogType 						= getvalue(c73);
			fogColorArray 					= getvalue(c74);
			fogBackdropColor				= getvalue(c75);
			useBackgroundColor				= getvalue(c76);
			backgroundColorArray			= getvalue(c77);
			backdropColorArray				= getvalue(c78);
			doUpdate = 1;	
		}
		else
		{
			doUpdate = 0;
		}
		reqend();
		if(doUpdate == 1)
		{
			newNumber = sel;
			if(action == "new")
			{
				pass = currentChosenPass;
				if(overrideNames[1] != "empty")
				{
					newNumber = size(overrideNames) + 1;
				}
				else
				{
					newNumber = 1;
				}
				passOverrideItems[pass][newNumber] = "";
				for(y = 1; y <= size(passNames); y++)
				{
					passOverrideItems[y][newNumber] = "";
				}
			}
			overrideNames[newNumber] = newName + "   (scene properties)";
			overrideSettings[newNumber] = newName 								+ 	"||" 	+ "type6" 							+ 	"||"
										+ string(overrideRenderer)				+ 	"||" 	
										+ string(resolutionMultiplierSetts) 	+ 	"||" 	+ string(renderModeSetts)			+ 	"||"
										+ string(depthBufferAASetts) 			+ 	"||" 	+ string(renderLinesSetts) 			+ 	"||"
										+ string(rayRecursionLimitSetts) 		+	"||" 	+ string(redirectBuffersSetts)		+ 	"||"
										+ string(disableAASetts) 				+ 	"||" 	+ string(raytraceShadows) 			+ 	"||"
										+ string(raytraceReflect) 				+ 	"||" 	+ string(raytraceRefract) 			+ 	"||"
										+ string(raytraceTrans) 				+ 	"||" 	+ string(raytraceOccl) 				+ 	"||"
										+ string(volumetricAA) 					+ 	"||"	+ string(lensFlares)				+	"||"
										+ string(shadowMaps)					+ 	"||"	+ string(volLights)					+	"||"
										+ string(twoSidedALgts)					+ 	"||"	+ string(renderInstances)			+	"||"
										+ string(rayPrecision)					+ 	"||"	+ string(rayCutoff)					+	"||"
										+ string(shadingSamples)				+ 	"||"	+ string(lightSamples)				+	"||"
										+ string(lightIntensity)				+ 	"||"	+ string(flareIntensity)			+	"||"
										+ string(enableGI)						+ 	"||"	+ string(giMode)					+	"||"
										+ string(interpolateGI)					+ 	"||"	+ string(blurBGGI)					+	"||"
										+ string(transparencyGI)				+	"||"	+ string(volumetricGI)				+	"||"
										+ string(ambOcclGI)						+	"||"	+ string(directionalGI)				+	"||"
										+ string(gradientsGI)					+	"||"	+ string(behindTestGI)				+	"||"
										+ string(useBumpsGI)					+	"||"	+ string(giIntensity)				+	"||"
										+ string(giAngTol)						+	"||"	+ string(giIndBounces)				+	"||"
										+ string(giMinSpacing)					+	"||"	+ string(giRPE)						+	"||"
										+ string(giMaxSpacing)					+	"||"	+ string(gi2ndBounces)				+	"||"
										+ string(giMultiplier)					+	"||"	+ string(enableCaustics)			+	"||"
										+ string(causticsAccuracy)				+	"||"	+ string(causticsIntensity)			+	"||"
										+ string(causticsSoftness)				+	"||"	+ string(fiberFXSaveRGBA)			+	"||"
										+ string(fiberFXSaveRGBAType)			+	"||"	+ string(fiberFXSaveRGBAName)		+	"||"
										+ string(fiberFXSaveDepth)				+	"||"	+ string(fiberFXSaveDepthType)		+	"||"
										+ string(fiberFXSaveDepthName)			+	"||"	+ string(fogType)					+	"||"
										+ string(fogColorArray.x) 				+	"||"	+ string(fogColorArray.y) 			+	"||"
										+ string(fogColorArray.z) 				+	"||"	+ string(fogBackdropColor)			+	"||"
										+ string(useBackgroundColor)			+	"||"	+ string(backgroundColorArray.x) 	+	"||"
										+ string(backgroundColorArray.y) 		+	"||"	+ string(backgroundColorArray.z) 	+	"||"
										+ string(backdropColorArray.x) 			+	"||"	+ string(backdropColorArray.y) 		+	"||"
										+ string(backdropColorArray.z);
		}
	} else {
		error("scnmasterOverride_UI: incorrect, or no, action passed");
	}
}

scnGen_native:updatedCurrentScenePath, newScenePath
{
	resolutionMultiplierSetts	= integer(settingsArray[4]);
	redirectBuffersSetts 		= integer(settingsArray[9]);
	disableAASetts 				= integer(settingsArray[10]);

	switch(resolutionMultiplierSetts)
	{
		case 1:
			resMult = 0.25;
			break;
		
		case 2:
			resMult = 0.5;
			break;
			
		case 3:
			resMult = 1.0;
			break;
			
		case 4:
			resMult = 2.0;
			break;
			
		case 5:
			resMult = 4.0;
			break;
			
		default:
			break;
	}
	
	writeOverrideString(updatedCurrentScenePath, newScenePath, "FrameSize ", resMult);
				
	renderModeSetts = integer(settingsArray[5]) - 1;
	writeOverrideString(updatedCurrentScenePath, newScenePath, "RenderMode ", renderModeSetts);
	
	depthBufferAASetts = integer(settingsArray[6]);
	writeOverrideString(updatedCurrentScenePath, newScenePath, "DepthBufferAA ", depthBufferAASetts);
	
	renderLinesSetts = integer(settingsArray[7]);
	writeOverrideString(updatedCurrentScenePath, newScenePath, "RenderLines ", renderLinesSetts);

	rayRecursionLimitSetts = integer(settingsArray[8]);
	writeOverrideString(updatedCurrentScenePath, newScenePath, "RayRecursionLimit ", rayRecursionLimitSetts);

	if(disableAASetts == 1) {
		writeOverrideString(updatedCurrentScenePath, newScenePath, "AASamples ", "1");
	}
	
	raytraceShadows				= integer(settingsArray[11]);
	raytraceShadows_Flag		= 1;
	raytraceFlags				= (raytraceShadows * raytraceShadows_Flag);

	raytraceReflect				= integer(settingsArray[12]);
	raytraceReflect_Flag		= 2;
	raytraceFlags				+= (raytraceReflect * raytraceReflect_Flag);

	raytraceRefract				= integer(settingsArray[13]);
	raytraceRefract_Flag		= 4;
	raytraceFlags				+= (raytraceRefract * raytraceRefract_Flag);

	raytraceTrans				= integer(settingsArray[14]);
	raytraceTrans_Flag			= 8;
	raytraceFlags				+= (raytraceTrans * raytraceTrans_Flag);

	raytraceOccl				= integer(settingsArray[15]);
	raytraceOccl_Flag			= 16;
	raytraceFlags				+= (raytraceOccl * raytraceOccl_Flag);
	
	writeOverrideString(updatedCurrentScenePath, newScenePath, "RayTraceEffects ", raytraceFlags);

	volumetricAA = integer(settingsArray[16]);
	writeOverrideString(updatedCurrentScenePath, newScenePath, "VolumetricAA ", volumetricAA);

	gLensFlares = integer(settingsArray[17]);
	writeOverrideString(updatedCurrentScenePath, newScenePath, "EnableLensFlares ", gLensFlares);

	shadowMaps = integer(settingsArray[18]);
	writeOverrideString(updatedCurrentScenePath, newScenePath, "EnableShadowMaps ", shadowMaps);

	volLights = integer(settingsArray[19]);
	writeOverrideString(updatedCurrentScenePath, newScenePath, "EnableVolumetricLights ", volLights);

	twoSidedALgts = integer(settingsArray[20]);
	writeOverrideString(updatedCurrentScenePath, newScenePath, "DoubleSidedAreaLights ", twoSidedALgts);

	renderInstances = integer(settingsArray[21]);
	writeOverrideString(updatedCurrentScenePath, newScenePath, "RenderInstances ", renderInstances);

	rayPrecision = number(settingsArray[22]);
	writeOverrideString(updatedCurrentScenePath, newScenePath, "RayPrecision ", rayPrecision);

	rayCutoff = number(settingsArray[23]);
	writeOverrideString(updatedCurrentScenePath, newScenePath, "RayCutoff ", rayCutoff);

	shadingSamples = integer(settingsArray[24]);
	writeOverrideString(updatedCurrentScenePath, newScenePath, "ShadingSamples ", shadingSamples);

	lightSamples = integer(settingsArray[25]);
	writeOverrideString(updatedCurrentScenePath, newScenePath, "LightSamples ", lightSamples);

	gLightIntensity = number(settingsArray[26]);
	writeOverrideString(updatedCurrentScenePath, newScenePath, "GlobalLightIntensity ", gLightIntensity);

	gFlareIntensity = number(settingsArray[27]);
	writeOverrideString(updatedCurrentScenePath, newScenePath, "GlobalFlareIntensity ", gFlareIntensity);

	enableGI = number(settingsArray[28]);
	writeOverrideString(updatedCurrentScenePath, newScenePath, "EnableRadiosity ", enableGI);

	giMode = integer(settingsArray[29]);
	giMode = giMode - 1; // decrement by one to match index in LW. Menus are 1-indexed.
	writeOverrideString(updatedCurrentScenePath, newScenePath, "RadiosityType ", giMode);

	interpolateGI = integer(settingsArray[30]);
	writeOverrideString(updatedCurrentScenePath, newScenePath, "RadiosityInterpolated ", interpolateGI);

	blurBGGI = integer(settingsArray[31]);
	writeOverrideString(updatedCurrentScenePath, newScenePath, "BlurRadiosity ", blurBGGI);

	transparencyGI = integer(settingsArray[32]);
	writeOverrideString(updatedCurrentScenePath, newScenePath, "RadiosityTransparency ", transparencyGI);

	volumetricGI = integer(settingsArray[33]);
	writeOverrideString(updatedCurrentScenePath, newScenePath, "VolumetricRadiosity ", volumetricGI);

	ambOcclGI = integer(settingsArray[34]);
	writeOverrideString(updatedCurrentScenePath, newScenePath, "RadiosityUseAmbient ", ambOcclGI);

	directionalGI = integer(settingsArray[35]);
	writeOverrideString(updatedCurrentScenePath, newScenePath, "RadiosityDirectionalRays ", directionalGI);

	gradientsGI = integer(settingsArray[36]);
	writeOverrideString(updatedCurrentScenePath, newScenePath, "RadiosityUseGradients ", gradientsGI);

	behindTestGI = integer(settingsArray[37]);
	writeOverrideString(updatedCurrentScenePath, newScenePath, "RadiosityUseBehindTest ", behindTestGI);

	useBumpsGI = integer(settingsArray[38]);
	useBumpsGI = useBumpsGI * (-2147483648);
	writeOverrideString(updatedCurrentScenePath, newScenePath, "RadiosityFlags ", useBumpsGI);

	giIntensity = integer(settingsArray[39]);
	writeOverrideString(updatedCurrentScenePath, newScenePath, "RadiosityIntensity ", giIntensity);

	giAngTol = integer(settingsArray[40]);
	writeOverrideString(updatedCurrentScenePath, newScenePath, "RadiosityTolerance ", giAngTol);

	giIndBounces = integer(settingsArray[41]);
	writeOverrideString(updatedCurrentScenePath, newScenePath, "IndirectBounces ", giIndBounces);
	
	giMinSpacing = number(settingsArray[42]);
	writeOverrideString(updatedCurrentScenePath, newScenePath, "RadiosityMinPixelSpacing ", giMinSpacing);

	giRPE = number(settingsArray[43]);
	writeOverrideString(updatedCurrentScenePath, newScenePath, "RadiosityRays ", giRPE);

	giMaxSpacing = number(settingsArray[44]);
	writeOverrideString(updatedCurrentScenePath, newScenePath, "RadiosityMaxPixelSpacing ", giMaxSpacing);

	gi2ndBounces = integer(settingsArray[45]);
	writeOverrideString(updatedCurrentScenePath, newScenePath, "SecondaryBounceRays ", gi2ndBounces);

	giMultiplier = number(settingsArray[46]);
	writeOverrideString(updatedCurrentScenePath, newScenePath, "RadiosityMultiplier ", giMultiplier);

	enableCaustics = number(settingsArray[47]);
	writeOverrideString(updatedCurrentScenePath, newScenePath, "EnableCaustics ", enableCaustics);

	causticsAccuracy = integer(settingsArray[48]);
	writeOverrideString(updatedCurrentScenePath, newScenePath, "CausticAccuracy ", causticsAccuracy);

	causticsIntensity = number(settingsArray[49]);
	writeOverrideString(updatedCurrentScenePath, newScenePath, "CausticIntensity ", causticsIntensity);

	causticsSoftness = number(settingsArray[50]);
	writeOverrideString(updatedCurrentScenePath, newScenePath, "CausticSoftness ", causticsSoftness);

	// FiberFX settings are written out in the main scene gen code. At least for now.

	fogType = integer(settingsArray[57]);
	writeOverrideString(updatedCurrentScenePath, newScenePath, "FogType ", fogType);

	fogColorLine = string(number(settingsArray[58]) / 255) + " " + string(number(settingsArray[59]) / 255) + " " + string(number(settingsArray[60]) / 255);
	writeOverrideString(updatedCurrentScenePath, newScenePath, "FogColor ", fogColorLine);

	fogBackdropColor = integer(settingsArray[61]);
	writeOverrideString(updatedCurrentScenePath, newScenePath, "BackdropFog ", fogBackdropColor);

	useBackgroundColor = integer(settingsArray[62]);
	writeOverrideString(updatedCurrentScenePath, newScenePath, "UseBackgroundColor ", useBackgroundColor);

	bgColorLine = string(number(settingsArray[63]) / 255) + " " + string(number(settingsArray[64]) / 255) + " " + string(number(settingsArray[65]) / 255);
	writeOverrideString(updatedCurrentScenePath, newScenePath, "BackgroundColor ", bgColorLine);

	bdColorLine = string(number(settingsArray[66]) / 255) + " " + string(number(settingsArray[67]) / 255) + " " + string(number(settingsArray[68]) / 255);
	writeOverrideString(updatedCurrentScenePath, newScenePath, "BackdropColor ", bdColorLine);

	// FIXME : Move to camera override.
	disableAASetts = integer(settingsArray[10]);
	if(disableAASetts == 1)
		disableAASetts = 0;
	writeOverrideString(updatedCurrentScenePath, newScenePath, "Antialiasing ", disableAASetts);

	writeOverrideString(updatedCurrentScenePath, newScenePath, "AntiAliasingLevel ", "-1");

	finishFiles();
}

// Called from scene generation code if native renderer set for override.
radLines_native: radFileName
{
	switch (int(hostVersion()))
	{
		case 11:
			prepareRadiosityLines_11(radFileName);
			break;
		
		default:
			break;
    }
}

// This is ~annoying. The setting locations in the scene file were determined by manual inspection.
// I've version-controlled them in case they move/change in future.
prepareRadiosityLines_11: radFileName
{
	if (getPartialLine(0,0,"EnableRadiosity",radFileName) == nil)
	{
		insertScnLine("EnableRadiosity 0",radFileName,(getPartialLine(0,0,"DoubleSidedAreaLights",radFileName)));
	}
	if(getPartialLine(0,0,"IndirectBounces",radFileName) == nil)
	{
		insertScnLine("IndirectBounces 1",radFileName,(getPartialLine(0,0,"RadiosityMultiplier",radFileName)));
	}
	if(getPartialLine(0,0,"VolumetricRadiosity",radFileName) == nil)
	{
		insertScnLine("VolumetricRadiosity 0",radFileName,(getPartialLine(0,0,"IndirectBounces",radFileName)));
	}
	if(getPartialLine(0,0,"RadiosityUseAmbient",radFileName) == nil)
	{
		insertScnLine("RadiosityUseAmbient 0",radFileName,(getPartialLine(0,0,"VolumetricRadiosity",radFileName)));
	}
	if(getPartialLine(0,0,"EnableCaustics",radFileName) == nil)
	{
		insertScnLine("EnableCaustics 0",radFileName,(getPartialLine(0,0,"PixelFilterForceMT",radFileName)));
	}
	if(getPartialLine(0,0,"CausticIntensity",radFileName) == nil)
	{
		insertScnLine("CausticIntensity 0",radFileName,(getPartialLine(0,0,"EnableCaustics",radFileName)));
	}
	if(getPartialLine(0,0,"CausticAccuracy",radFileName) == nil)
	{
		insertScnLine("CausticAccuracy 100",radFileName,(getPartialLine(0,0,"CausticIntensity",radFileName)));
	}
	if(getPartialLine(0,0,"CausticSoftness",radFileName) == nil)
	{
		insertScnLine("CausticSoftness 20",radFileName,(getPartialLine(0,0,"CausticAccuracy",radFileName)));
	}
}

