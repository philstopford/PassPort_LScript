cameraOverride_UI: action
{
	// sel only used in edit action.
	// action should be either 'new' or 'edit'
	if (action == "new" || action == "edit")
	{
		if(action == "edit")
		{
			sel = getvalue(gad_OverridesListview).asInt();
			settingsArray = parseOverrideSettings(overrideSettings[sel]);
            zoomFactor 						= number(settingsArray[3]);
			zoomType 						= integer(settingsArray[4]);
			resolutionMultiplier 			= number(settingsArray[5]);
			frameSizeH 						= integer(settingsArray[6]);
			frameSizeV 						= integer(settingsArray[7]);
			pixelAspect 					= number(settingsArray[8]);
			motionBlur 						= integer(settingsArray[9]);
			motionBlurPasses 				= integer(settingsArray[10]);
			shutterEfficiency 				= number(settingsArray[11]);
			rollingShutter 					= number(settingsArray[12]);
			shutterOpen 					= number(settingsArray[13]);
			oversampling 					= number(settingsArray[14]);
			fieldRendering 					= integer(settingsArray[15]);
			depthOfField 					= integer(settingsArray[16]);
			sampler 						= integer(settingsArray[17]);
			adaptiveThreshold 				= number(settingsArray[18]);
			minimumSamples 					= integer(settingsArray[19]);
			maximumSamples 					= integer(settingsArray[20]);
		}
		
		doKeys = 0;

		reqbeginstr = "New Camera Override";
		if(action == "edit")
		{
			reqbeginstr = "Edit Camera Override";
		}
		reqbegin(reqbeginstr);
		reqsize(CamProp_ui_window_w, 325);
		
		newName = "CamPropsOverride";
		if(action == "edit")
		{
			newName = settingsArray[1];
		}
		c20 = ctlstring("Override Name:", newName);

		ctlposition(c20, CamProp_gad_x, CamProp_gad_y, CamProp_gad_w, CamProp_gad_h, CamProp_gad_text_offset);

		ui_offset_y = CamProp_ui_offset_y + CamProp_ui_row_offset;

		c21val = 3.2;
		if(action == "edit")
		{
			c21val = zoomFactor;
		}
		c21 = ctlnumber("Zoom Factor:",c21val);
		ctlposition(c21, CamProp_gad_x, CamProp_gad_y + ui_offset_y, CamProp_gad_w, CamProp_gad_h, CamProp_gad_text_offset);

		c22val = 1; //FIXME : Menu?
		if(action == "edit")
		{
			c22val = zoomType;
		}
		c22 = ctlinteger("Zoom Type:",c22val);
		ctlposition(c22, CamProp_gad_x2, CamProp_gad_y + ui_offset_y, CamProp_gad_w, CamProp_gad_h, CamProp_gad_text_offset);

		ui_offset_y += CamProp_ui_row_offset;

		c23val = 3;
		resolutionMultiplier = 1.0;
		if(action == "edit")
		{
			c23val = 3;
			if(resolutionMultiplier == 0.25)
			{
				c23val = 1;
			}
			if(resolutionMultiplier == 0.5)
			{
				c23val = 2;
			}
			if(resolutionMultiplier == 1.0)
			{
				c23val = 3;
			}
			if(resolutionMultiplier == 2.0)
			{
				c23val = 4;
			}
			if(resolutionMultiplier == 4.0)
			{
				c23val = 5;
			}
		}
		c23 = ctlpopup("Resolution Multiplier",c23val,resolutionMultArray);
		ctlposition(c23, CamProp_gad_x, CamProp_gad_y + ui_offset_y, CamProp_gad_w, CamProp_gad_h, CamProp_gad_text_offset);

		c24val = 1.0;
		if(action == "edit")
		{
			c24val = pixelAspect;
		}
		c24 = ctlnumber("Pixel Aspect:",c24val);
		ctlposition(c24, CamProp_gad_x2, CamProp_gad_y + ui_offset_y, CamProp_gad_w, CamProp_gad_h, CamProp_gad_text_offset);
		// ui_offset_y += CamProp_ui_row_offset;
		ui_offset_y += CamProp_ui_row_offset + 2;
		sep1 = ctlsep(0, CamProp_ui_seperator_w + 4);
		ctlposition(sep1, -2, CamProp_gad_y + ui_offset_y);
		ui_offset_y += CamProp_ui_spacing_y + 4;

		c25val = 1280;
		if(action == "edit")
		{
			c25val = frameSizeH;
		}
		c25 = ctlinteger("Horizontal Size:",c25val);
		ctlposition(c25, CamProp_gad_x, CamProp_gad_y + ui_offset_y, CamProp_gad_w, CamProp_gad_h, CamProp_gad_text_offset);

		c26val = 720;
		if(action == "edit")
		{
			c26val = frameSizeV;
		}
		c26 = ctlinteger("Vertical Size:",c26val);
		ctlposition(c26, CamProp_gad_x2, CamProp_gad_y + ui_offset_y, CamProp_gad_w, CamProp_gad_h, CamProp_gad_text_offset);
		// ui_offset_y += CamProp_ui_row_offset;
		ui_offset_y += CamProp_ui_row_offset + 2;
		sep2 = ctlsep(0, CamProp_ui_seperator_w + 4);
		ctlposition(sep2, -2, CamProp_gad_y + ui_offset_y);
		ui_offset_y += CamProp_ui_spacing_y + 4;

		c27val = 0;
		if(action == "edit")
		{
			c27val = motionBlur;
		}
		c27 = ctlcheckbox("Motion Blur",c27val);
		ctlposition(c27, CamProp_gad_x, CamProp_gad_y + ui_offset_y, CamProp_gad_w, CamProp_gad_h, CamProp_gad_text_offset);

		ui_offset_y += CamProp_ui_row_offset;

		c28val = 1;
		if(action == "edit")
		{
			c28val = motionBlurPasses;
		}
		c28 = ctlinteger("Passes:",c28val);
		ctlposition(c28, CamProp_gad_x, CamProp_gad_y + ui_offset_y, CamProp_gad_w, CamProp_gad_h, CamProp_gad_text_offset);

		c29val = 1;
		if(action == "edit")
		{
			c29val = shutterEfficiency;
		}
		c29 = ctlpercent("Shutter Efficiency",c29val);
		ctlposition(c29, CamProp_gad_x2, CamProp_gad_y + ui_offset_y, CamProp_gad_w - 22, CamProp_gad_h, CamProp_gad_text_offset);

		ui_offset_y += CamProp_ui_row_offset;

		c30val = 1;
		if(action == "edit")
		{
			c30val = rollingShutter;
		}
		c30 = ctlpercent("Rolling Shutter",c30val);
		ctlposition(c30, CamProp_gad_x, CamProp_gad_y + ui_offset_y, CamProp_gad_w - 22, CamProp_gad_h, CamProp_gad_text_offset);

		c31val = 1;
		if(action == "edit")
		{
			c31val = shutterOpen;
		}
		c31 = ctlpercent("Shutter Open",c31val);
		ctlposition(c31, CamProp_gad_x2, CamProp_gad_y + ui_offset_y, CamProp_gad_w - 22, CamProp_gad_h, CamProp_gad_text_offset);

		ui_offset_y += CamProp_ui_row_offset + 2;
		sep3 = ctlsep(0, CamProp_ui_seperator_w + 4);
		ctlposition(sep3, -2, CamProp_gad_y + ui_offset_y);
		ui_offset_y += CamProp_ui_spacing_y + 4;

		c32val = 1;
		fieldRendering = c32val - 1;
		if(action == "edit")
		{
			c32val = fieldRendering + 1;
		}
		c32 = ctlpopup("Field Rendering",c32val,fieldRenderArray);
		ctlposition(c32, CamProp_gad_x, CamProp_gad_y + ui_offset_y, CamProp_gad_w, CamProp_gad_h, CamProp_gad_text_offset);

		c38val = 0;
		if(action == "edit")
		{
			c38val = depthOfField;
		}
		c38 = ctlcheckbox("Depth of Field",c38val);
		ctlposition(c38, CamProp_gad_x2, CamProp_gad_y + ui_offset_y, CamProp_gad_w, CamProp_gad_h, CamProp_gad_text_offset);

		ui_offset_y += CamProp_ui_row_offset + 2;
		sep4 = ctlsep(0, CamProp_ui_seperator_w + 4);
		ctlposition(sep4, -2, CamProp_gad_y + ui_offset_y);
		ui_offset_y += CamProp_ui_spacing_y + 4;

		c33val = 1;
		sampler = c33val - 1;
		if(action == "edit")
		{
			c33val = sampler + 1;
		}
		c33 = ctlpopup("Sampler",c33val,samplerArray);
		ctlposition(c33, CamProp_gad_x, CamProp_gad_y + ui_offset_y, CamProp_gad_w, CamProp_gad_h, CamProp_gad_text_offset);

		ui_offset_y += CamProp_ui_row_offset;

		c34val = 1;
		if(action == "edit")
		{
			c34val = minimumSamples;
		}
		c34 = ctlinteger("Min Samples",c34val);
		ctlposition(c34, CamProp_gad_x, CamProp_gad_y + ui_offset_y, CamProp_gad_w, CamProp_gad_h, CamProp_gad_text_offset);

		c35val = 0.01;
		if(action == "edit")
		{
			c35val = adaptiveThreshold;
		}
		c35 = ctlnumber("Threshold",c35val);
		ctlposition(c35, CamProp_gad_x2, CamProp_gad_y + ui_offset_y, CamProp_gad_w, CamProp_gad_h, CamProp_gad_text_offset);

		ui_offset_y += CamProp_ui_row_offset;

		c36val = 1;
		if(action == "edit")
		{
			c36val = maximumSamples;
		}
		c36 = ctlinteger("Max Samples",c36val);
		ctlposition(c36, CamProp_gad_x, CamProp_gad_y + ui_offset_y, CamProp_gad_w, CamProp_gad_h, CamProp_gad_text_offset);

		c37val = 0;
		if(action == "edit")
		{
			c37val = oversampling;
		}
		c37 = ctlnumber("Oversampling",c37val);
		ctlposition(c37, CamProp_gad_x2, CamProp_gad_y + ui_offset_y, CamProp_gad_w, CamProp_gad_h, CamProp_gad_text_offset);

		if(reqpost())
		{
			newName 				= getvalue(c20);
			newName 				= makeStringGood(newName);
			zoomFactor 				= getvalue(c21);
			zoomType 				= getvalue(c22);
			switch(getvalue(c23))
			{
				case 1:
					resolutionMultiplier = 0.25;
					break;
				case 2:
					resolutionMultiplier = 0.5;
					break;
				case 3:
					resolutionMultiplier = 1.0;
					break;
				case 4:
					resolutionMultiplier = 2.0;
					break;
				case 5:
					resolutionMultiplier = 4.0;
					break;
				default:
					resolutionMultiplier = 1.0;
					break;
			}
			frameSizeH				= getvalue(c25);
			frameSizeV				= getvalue(c26);
			pixelAspect				= getvalue(c24);
			motionBlur 				= getvalue(c27);
			motionBlurPasses 		= getvalue(c28);
			shutterEfficiency		= getvalue(c29);
			rollingShutter			= getvalue(c30);
			shutterOpen				= getvalue(c31);
			oversampling 			= getvalue(c37);
			fieldRendering 			= getvalue(c32) - 1;
			depthOfField			= getvalue(c38);
			sampler 				= getvalue(c33) - 1;
			adaptiveThreshold		= getvalue(c35);
			minimumSamples			= getvalue(c34);
			maximumSamples			= getvalue(c36);

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
			overrideNames[newNumber] = newName + "   (camera)";
			overrideSettings[newNumber] = 	newName 				+ "||" + 	"type8" 			+ "||"
										+ 	zoomFactor				+ "||" + 	zoomType 			+ "||"
										+ 	resolutionMultiplier	+ "||" + 	frameSizeH 			+ "||"
										+ 	frameSizeV				+ "||" + 	pixelAspect			+ "||"
										+ 	motionBlur				+ "||" + 	motionBlurPasses	+ "||"
										+ 	shutterEfficiency		+ "||" + 	rollingShutter		+ "||"
										+ 	shutterOpen				+ "||" + 	oversampling		+ "||"
										+ 	fieldRendering			+ "||" + 	depthOfField		+ "||"
										+ 	sampler					+ "||" + 	adaptiveThreshold	+ "||"
										+ 	minimumSamples			+ "||" + 	maximumSamples;
		}
		reqend();
	} else {
		error("cameraOverride_UI: incorrect, or no, action passed");
	}
    req_update();
}

srfOverride_UI: action
{
	// sel only used in edit action.
	// action should be either 'new' or 'edit'
	if (action == "new" || action == "edit")
	{
		if(action == "edit")
		{
		    sel = getvalue(gad_OverridesListview).asInt();
			settingsArray = parseOverrideSettings(overrideSettings[sel]);
		}
		
		doKeys = 0;

		reqbeginstr = "New .srf Override";
		if(action == "edit")
		{
			reqbeginstr = "Edit .srf Override";
		}
		reqbegin(reqbeginstr);
		
		newName = "SurfaceOverride";
		if(action == "edit")
		{
			newName = settingsArray[1];
		}
		c20 = ctlstring("Override Name:", newName);

		srfFile = "*.srf";
		if(action == "edit")
		{
			srfFile = settingsArray[3];
		}
		c21 = ctlfilename("Load .srf file...", srfFile,30,1);

		if(reqpost())
		{
			newName = getvalue(c20);
			newName = makeStringGood(newName);
			srfFile = getvalue(c21);

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
			overrideNames[newNumber] = newName + "   (.srf file)";
			overrideSettings[newNumber] = newName + "||" + "type1" + "||" + string(srfFile);
		}
		reqend();
	} else {
		error("srfOverride_UI: incorrect, or no, action passed");
	}
    req_update();
}

lightOverride_UI: action
{
	// sel only used in edit action.
	// action should be either 'new' or 'edit'
	if (action == "new" || action == "edit")
	{
		if(action == "edit")
		{
		    sel = getvalue(gad_OverridesListview).asInt();
			settingsArray = parseOverrideSettings(overrideSettings[sel]);

			lightColorSettsArrays[1] = integer(settingsArray[3]);
			lightColorSettsArrays[2] = integer(settingsArray[4]);
			lightColorSettsArrays[3] = integer(settingsArray[5]);
			lightColorSettsArray = <lightColorSettsArrays[1], lightColorSettsArrays[2], lightColorSettsArrays[3]>;

			lightIntensitySetts = number(settingsArray[6]);
			affectDiffuseSetts = integer(settingsArray[7]);
			affectSpecularSetts = integer(settingsArray[8]);
			affectCausticsSetts = integer(settingsArray[9]);
			lensFlareSetts = integer(settingsArray[10]);
			volumetricLightingSetts = integer(settingsArray[11]);
		}
		
		doKeys = 0;
		reqbeginstr = "New Light Override";
		if(action == "edit") 
		{
			reqbeginstr = "Edit Light Override";
		}
		reqbegin(reqbeginstr);

		reqsize(LgtProp_ui_window_w, 240);

		newName = "LgtPropsOverride";
		if(action == "edit")
		{
			newName = settingsArray[1];
		}
		c20 = ctlstring("Override Name",newName, 131);
		ctlposition(c20, LgtProp_gad_x, LgtProp_gad_y, LgtProp_gad_w, LgtProp_gad_h, LgtProp_gad_text_offset);

		ui_offset_y = LgtProp_ui_offset_y + LgtProp_ui_row_offset;

		c22val = 255;
		if(action == "edit")
		{
			c22val = lightColorSettsArray;
		}
		c22 = ctlcolor("Light Color", c22val);
		ctlposition(c22, LgtProp_gad_x, LgtProp_gad_y + ui_offset_y, LgtProp_gad_w, LgtProp_gad_h, LgtProp_gad_text_offset);

		ui_offset_y += LgtProp_ui_row_offset;

		c23val =  1.0;
		if(action == "edit")
		{
			c23val = lightIntensitySetts;
		}
		c23 = ctlpercent("Light Intensity", c23val);
		ctlposition(c23, LgtProp_gad_x, LgtProp_gad_y + ui_offset_y, LgtProp_gad_w - 22, LgtProp_gad_h, LgtProp_gad_text_offset);

		ui_offset_y += LgtProp_ui_row_offset + 12;
		s20 = ctlsep(0, LgtProp_ui_seperator_w + 4);
		ctlposition(s20, -2, ui_offset_y);
		ui_offset_y += LgtProp_ui_spacing_y + 2;

		c24val = 1;
		if(action == "edit")
		{
			c24val = affectDiffuseSetts;
		}
		c24 = ctlcheckbox("Affect Diffuse          ",c24val);
		ctlposition(c24, LgtProp_gad_x, LgtProp_gad_y + ui_offset_y, LgtProp_gad_w, LgtProp_gad_h, LgtProp_gad_text_offset);

		ui_offset_y += LgtProp_ui_row_offset;

		c25val = 1;
		if(action == "edit")
		{
			c25val = affectSpecularSetts;
		}
		c25 = ctlcheckbox("Affect Specular     ",c25val);
		ctlposition(c25, LgtProp_gad_x, LgtProp_gad_y + ui_offset_y, LgtProp_gad_w, LgtProp_gad_h, LgtProp_gad_text_offset);

		ui_offset_y += LgtProp_ui_row_offset;

		c26val = 1;
		if(action == "edit")
		{
			c26val = affectCausticsSetts;
		}
		c26 = ctlcheckbox("Affect Caustics     ",c26val);
		ctlposition(c26, LgtProp_gad_x, LgtProp_gad_y + ui_offset_y, LgtProp_gad_w, LgtProp_gad_h, LgtProp_gad_text_offset);

		ui_offset_y += LgtProp_ui_row_offset;

		c27val = 0;
		if(action == "edit")
		{
			c27val = lensFlareSetts;
		}
		c27 = ctlcheckbox("Lens Flare               ",c27val);
		ctlposition(c27, LgtProp_gad_x, LgtProp_gad_y + ui_offset_y, LgtProp_gad_w, LgtProp_gad_h, LgtProp_gad_text_offset);

		ui_offset_y += LgtProp_ui_row_offset;

		c28val = 0;
		if(action == "edit")
		{
			c28val = volumetricLightingSetts;
		}
		c28 = ctlcheckbox("Volumetric Lighting",c28val);
		
		ctlposition(c28, LgtProp_gad_x, LgtProp_gad_y + ui_offset_y, LgtProp_gad_w, LgtProp_gad_h, LgtProp_gad_text_offset);
		if(reqpost())
		{
			newName = getvalue(c20);
			newName = makeStringGood(newName);
			lightColorSettsArray = getvalue(c22);
			lightIntensitySetts = getvalue(c23);
			affectDiffuseSetts = getvalue(c24);
			affectSpecularSetts = getvalue(c25);
			affectCausticsSetts = getvalue(c26);
			lensFlareSetts = getvalue(c27);
			volumetricLightingSetts = getvalue(c28);

			pass = currentChosenPass;
			newNumber = sel;
			if(action == "new")
			{
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
			overrideNames[newNumber] = newName + "   (light properties)";
			overrideSettings[newNumber] = newName + "||" + "type5" + "||" +	string(lightColorSettsArray.x) +  "||" + string(lightColorSettsArray.y) + "||" + string(lightColorSettsArray.z) + "||" + string(lightIntensitySetts) + "||" + string(affectDiffuseSetts) + "||" + string(affectSpecularSetts) + "||" + string(affectCausticsSetts) + "||" + string(lensFlareSetts)  + "||" + string(volumetricLightingSetts);
		}
		reqend();
	} else {
		error("lightOverride_UI: incorrect, or no, action passed");
	}
    req_update();
}

objpropsOverride_UI: action
{
	// sel only used in edit action.
	// action should be either 'new' or 'edit'
	if (action == "new" || action == "edit")
	{
		if(action == "edit")
		{
		    sel = getvalue(gad_OverridesListview).asInt();
			settingsArray = parseOverrideSettings(overrideSettings[sel]);
			/* so for this system, the resulting parsed array will be
				1.  name
				2.  type
				3.  matte object (0 or 1)
				4.  alpha channel (1, 2, or 3)
				5.  unseen by rays( 0 or 1)
				6.  unseen by camera (0 or 1)
				7.  unseen by radiosity (0 or 1)
				8.  unseen by fog (0 or 1)
				9.  self shadow (0 or 1)
				10. cast shadow (0 or 1)
				11. receive shadow (0 or 1)
			*/

			matteObjectSetts = integer(settingsArray[3]);
			alphaChannelSetts = integer(settingsArray[4]);
			unseenByRaysSetts = integer(settingsArray[5]);
			unseenByCameraSetts = integer(settingsArray[6]);
			unseenByRadiositySetts = integer(settingsArray[7]);
			unseenByFogSetts = integer(settingsArray[8]);
			selfShadowSetts = integer(settingsArray[9]);
			castShadowSetts = integer(settingsArray[10]);
			receiveShadowSetts = integer(settingsArray[11]);
			matteColorSettsArray = < integer(settingsArray[12]), integer(settingsArray[13]), integer(settingsArray[14]) >;
		}
		
		
		tempAlphaArray[1] = "Use Surface Settings";
		tempAlphaArray[2] = "Unaffected by Object";
		tempAlphaArray[3] = "Constant Black";
		
		doKeys = 0;
		
		reqbeginstr = "New ObjProps Override";
		if(action == "edit")
		{
			reqbeginstr = "Edit ObjProps Override";
		}
		reqbegin(reqbeginstr);
		
		reqsize(ObjProp_ui_window_w,320);

		newName = "ObjPropsOverride";
		if(action == "edit")
		{
			newName = settingsArray[1];
		}
		c20 = ctlstring("Override Name:",newName);
		ctlposition(c20, ObjProp_gad_x, ObjProp_gad_y, ObjProp_gad_w, ObjProp_gad_h, ObjProp_gad_text_offset);
		
		ui_offset_y = ObjProp_ui_offset_y + ObjProp_ui_row_offset;

		c21val = 0;
		if(action == "edit")
		{
			c21val = matteObjectSetts;
		}
		c21 = ctlcheckbox("Matte Object",c21val);
		ctlposition(c21, ObjProp_gad_x, ObjProp_gad_y + ui_offset_y, ObjProp_gad_w, ObjProp_gad_h, ObjProp_gad_text_offset);

		ui_offset_y += ObjProp_ui_row_offset;

		c21_5val = 0;
		if(action == "edit")
		{
			c21_5val = matteColorSettsArray;
		}
		c21_5 = ctlcolor("Color",c21_5val);
		ctlposition(c21_5, ObjProp_gad_x, ObjProp_gad_y + ui_offset_y, ObjProp_gad_w, ObjProp_gad_h, ObjProp_gad_text_offset);

		ui_offset_y += ObjProp_ui_row_offset;

		c22val = 1;
		if(action == "edit")
		{
			c22val = alphaChannelSetts;
		}
		c22 = ctlpopup("Alpha Channel",c22val,tempAlphaArray);
		ctlposition(c22, ObjProp_gad_x, ObjProp_gad_y + ui_offset_y, ObjProp_gad_w, ObjProp_gad_h, ObjProp_gad_text_offset);

		ui_offset_y += ObjProp_ui_row_offset + 12;
		s20 = ctlsep(0, ObjProp_ui_seperator_w + 4);
		ctlposition(s20, -2, ui_offset_y);
		ui_offset_y += ObjProp_ui_spacing_y + 2;

		c23val = 0;
		if(action == "edit")
		{
			c23val = unseenByRaysSetts;
		}
		c23 = ctlcheckbox("Unseen by Rays      ",c23val);
		ctlposition(c23, ObjProp_gad_x, ObjProp_gad_y + ui_offset_y, ObjProp_gad_w, ObjProp_gad_h, ObjProp_gad_text_offset);

		ui_offset_y += ObjProp_ui_row_offset;

		c24val = 0;
		if(action == "edit")
		{
			c24val = unseenByCameraSetts;
		}
		c24 = ctlcheckbox("Unseen by Camera",c24val);
		ctlposition(c24, ObjProp_gad_x, ObjProp_gad_y + ui_offset_y, ObjProp_gad_w, ObjProp_gad_h, ObjProp_gad_text_offset);

		ui_offset_y += ObjProp_ui_row_offset;

		c25val = 0;
		if(action == "edit")
		{
			c25val = unseenByRadiositySetts;
		}
		c25 = ctlcheckbox("Unseen by Radiosity",c25val);
		ctlposition(c25, ObjProp_gad_x, ObjProp_gad_y + ui_offset_y, ObjProp_gad_w, ObjProp_gad_h, ObjProp_gad_text_offset);

		ui_offset_y += ObjProp_ui_row_offset;

		c26val = 0;
		if(action == "edit")
		{
			c26val = unseenByFogSetts;
		}
		c26 = ctlcheckbox("Unaffected by Fog  ",c26val);
		ctlposition(c26, ObjProp_gad_x, ObjProp_gad_y + ui_offset_y, ObjProp_gad_w, ObjProp_gad_h, ObjProp_gad_text_offset);

		ui_offset_y += ObjProp_ui_row_offset + 12;
		s21 = ctlsep(0, ObjProp_ui_seperator_w + 4);
		ctlposition(s21, -2, ui_offset_y);
		ui_offset_y += ObjProp_ui_spacing_y + 2;

		c27val = 1;
		if(action == "edit")
		{
			c27val = selfShadowSetts;
		}
		c27 = ctlcheckbox("Self Shadow     ",c27val);
		ctlposition(c27, ObjProp_gad_x, ObjProp_gad_y + ui_offset_y, ObjProp_gad_w, ObjProp_gad_h, ObjProp_gad_text_offset);

		ui_offset_y += ObjProp_ui_row_offset;

		c28val = 1;
		if(action == "edit")
		{
			c28val = castShadowSetts;
		}
		c28 = ctlcheckbox("Cast Shadow     ",c28val);
		ctlposition(c28, ObjProp_gad_x, ObjProp_gad_y + ui_offset_y, ObjProp_gad_w, ObjProp_gad_h, ObjProp_gad_text_offset);

		ui_offset_y += ObjProp_ui_row_offset;

		c29val = 1;
		if(action == "edit")
		{
			c29val = receiveShadowSetts;
		}
		c29 = ctlcheckbox("Receive Shadow",c29val);
		ctlposition(c29, ObjProp_gad_x, ObjProp_gad_y + ui_offset_y, ObjProp_gad_w, ObjProp_gad_h, ObjProp_gad_text_offset);
		
		if(reqpost())
		{
			newName = getvalue(c20);
			newName = makeStringGood(newName);
			matteObjectSetts = getvalue(c21);
			alphaChannelSetts = getvalue(c22);
			unseenByRaysSetts = getvalue(c23);
			unseenByCameraSetts = getvalue(c24);
			unseenByRadiositySetts = getvalue(c25);
			unseenByFogSetts = getvalue(c26);
			selfShadowSetts = getvalue(c27);
			castShadowSetts = getvalue(c28);
			receiveShadowSetts = getvalue(c29);
			matteColorSettsArray = getvalue(c21_5);
			
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
			overrideNames[newNumber] = newName + "   (object properties)";
			overrideSettings[newNumber] = newName + "||" + "type2" + "||" + string(matteObjectSetts) + "||" + string(alphaChannelSetts) + "||" + string(unseenByRaysSetts) + "||" + string(unseenByCameraSetts) + "||" + string(unseenByRadiositySetts) + "||" + string(unseenByFogSetts) + "||" + string(selfShadowSetts) + "||" + string(castShadowSetts) + "||" + string(receiveShadowSetts) + "||" + string(matteColorSettsArray.x) + "||" + string(matteColorSettsArray.y) + "||" + string(matteColorSettsArray.z);
		}
		reqend();
	} else {
		error("objpropsOverride_UI: incorrect, or no, action passed");
	}
    req_update();
}

motOverride_UI: action
{
	// sel only used in edit action.
	// action should be either 'new' or 'edit'
	if (action == "new" || action == "edit")
	{
		if(action == "edit")
		{
		    sel = getvalue(gad_OverridesListview).asInt();
			settingsArray = parseOverrideSettings(overrideSettings[sel]);
		}
		doKeys = 0;

		reqbeginstr = "New .mot Override";
		if(action == "edit")
		{
			reqbeginstr = "Edit .mot Override";
		}
		reqbegin(reqbeginstr);

		newName = "MotionOverride";
		if(action == "edit")
		{
			newName = settingsArray[1];
		}
		c20 = ctlstring("Override Name:",newName);
		
		motFile = "*.mot";
		if(action == "edit")
		{
			motFile = settingsArray[3];
		}
		c21 = ctlfilename("Load .mot file...", motFile,30,1);
		if(reqpost())
		{
			newName = getvalue(c20);
			newName = makeStringGood(newName);
			motFile = getvalue(c21);

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
			overrideNames[newNumber] = newName + "   (.mot file)";
			overrideSettings[newNumber] = newName + "||" + "type3" + "||" + string(motFile);
		}
		reqend();
	} else {
		error("motOverride_UI: incorrect, or no, action passed");
	}
    req_update();
}

lwoOverride_UI: action
{
	// sel only used in edit action.
	// action should be either 'new' or 'edit'
	if (action == "new" || action == "edit")
	{
		if(action == "edit")
		{
		    sel = getvalue(gad_OverridesListview).asInt();
			settingsArray = parseOverrideSettings(overrideSettings[sel]);
		}
		doKeys = 0;

		reqbeginstr = "New .lwo Override";
		if(action == "edit")
		{
			reqbeginstr = "Edit .lwo Override";
		}
		reqbegin(reqbeginstr);

		newName = "AltObjOverride";
		if(action == "edit")
		{
			newName = settingsArray[1];
		}
		c20 = ctlstring("Override Name:",newName);


		lwoFile = "*.lwo";
		if(action == "edit")
		{
			lwoFile = settingsArray[3];
		}
		c21 = ctlfilename("Load .lwo file...", lwoFile,30,1);
		if(reqpost())
		{
			newName = getvalue(c20);
			newName = makeStringGood(newName);
			lwoFile = getvalue(c21);

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
			overrideNames[newNumber] = newName + "   (.lwo file)";
			overrideSettings[newNumber] = newName + "||" + "type4" + "||" + string(lwoFile);
		}
		reqend();
	} else {
		error("lwoOverride_UI: incorrect, or no, action passed");
	}
    req_update();
}

lightexclOverride_UI: action
{
	// sel only used in edit action.
	// action should be either 'new' or 'edit'
	if (action == "new" || action == "edit")
	{
		if(action == "edit")
		{
		    sel = getvalue(gad_OverridesListview).asInt();
			settingsArray = parseOverrideSettings(overrideSettings[sel]);
		}
		for(x = 0; x < size(lightNames); x++)
		{
			xInverse = size(lightNames) - x;
			lightListArray[x + 1] = lightNames[xInverse];
		}
		lightListArray[size(lightNames) + 1] = "Radiosity";
		lightListArray[size(lightNames) + 2] = "Caustics";
		
		doKeys = 0;
		
		reqbeginstr = "New Light Exclusion Override";
		if(action == "edit")
		{
			reqbeginstr = "Edit Light Exclusion Override";
		}
		reqbegin(reqbeginstr);
		
		newName = "LgtExclusion";
		if(action == "edit")
		{
			newName = settingsArray[1];
		}
		c20 = ctlstring("Override Name",newName,131);
		ctlposition(c20, LgtExcl_gad_x, LgtExcl_gad_y, LgtExcl_gad_w, LgtExcl_gad_h, LgtExcl_gad_text_offset);

		ui_offset_y = LgtExcl_ui_offset_y + LgtExcl_ui_row_offset;

		light21 = ctlpopup("Select Light:", 1, lightListArray);
		ctlposition(light21, LgtExcl_gad_x, LgtExcl_gad_y + ui_offset_y, LgtExcl_gad_w, LgtExcl_gad_h, LgtExcl_gad_text_offset);

		ui_offset_y += LgtExcl_ui_row_offset;

		c22 = ctlbutton("Add Light",100,"lightExclusionAddLight");
		ctlposition(c22, LgtExcl_gad_x, LgtExcl_gad_y + ui_offset_y, LgtExcl_gad_w, LgtExcl_gad_h, LgtExcl_gad_text_offset);

		ui_offset_y += LgtExcl_ui_row_offset;

		tempLightTransferring = "";			
		if (action == "edit")
		{
			if(size(settingsArray) >= 3)
			{
				if(settingsArray[3] != nil && settingsArray[3] != "")
				{
					tempLightTransferring = settingsArray[3];
				}
			}
		}
		
		light23 = ctlstring("Excluded Lights:",tempLightTransferring,200);
		ctlposition(light23, LgtExcl_gad_x, LgtExcl_gad_y + ui_offset_y, LgtExcl_gad_w, LgtExcl_gad_h, LgtExcl_gad_text_offset);
		
		if(reqpost())
		{
			newName = getvalue(c20);
			newName = makeStringGood(newName);
			excludedLightsSetts = getvalue(light23);

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
			overrideNames[newNumber] = newName + "   (light exclusion)";
			overrideSettings[newNumber] = newName + "||" + "type7" + "||" + string(excludedLightsSetts);
		}
		reqend();
	} else {
		error("lightexclOverride_UI: incorrect, or no, action passed");
	}
    req_update();
}

scnmasterOverride_UI: rendererindex, action
{
	switch(rendererindex)
	{
		case 1:
			scnmasterOverride_UI_native(action);
			break;
		case 2:
			scnmasterOverride_UI_kray25(action);
			break;
		default:
			scnmasterOverride_UI_native(action);
			break;
	}
    req_update();
}
