srfOverride_UI: action
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
			overrideNames[newNumber] = newName + "   (.srf file)";
			overrideSettings[newNumber] = newName + "||" + "type1" + "||" + string(srfFile);
		}
	} else {
		error("srfOverride_UI: incorrect, or no, action passed");
	}
}

lightOverride_UI: action
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
			lightColorSettsArrays[1] = integer(settingsArray[3]);
			lightColorSettsArrays[2] = integer(settingsArray[4]);
			lightColorSettsArrays[3] = integer(settingsArray[5]);
			lightIntensitySetts = number(settingsArray[6]);
			affectDiffuseSetts = integer(settingsArray[7]);
			affectSpecularSetts = integer(settingsArray[8]);
			lensFlareSetts = integer(settingsArray[9]);
			volumetricLightingSetts = integer(settingsArray[10]);
			lightColorSettsArray = <lightColorSettsArrays[1], lightColorSettsArrays[2], lightColorSettsArrays[3]>;
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
			lensFlareSetts = getvalue(c27);
			volumetricLightingSetts = getvalue(c28);
			doUpdate = 1;
		}
		else
		{
			doUpdate = 0;
		}
		reqend();
		
		if(doUpdate == 1)
		{	
			newNumber;
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
			overrideSettings[newNumber] = newName + "||" + "type5" + "||" +	string(lightColorSettsArray.x) +  "||" + string(lightColorSettsArray.y) + "||" + string(lightColorSettsArray.z) + "||" + string(lightIntensitySetts) + "||" + string(affectDiffuseSetts) + "||" + string(affectSpecularSetts) + "||" + string(lensFlareSetts)  + "||" + string(volumetricLightingSetts);
		}
	} else {
		error("lightOverride_UI: incorrect, or no, action passed");
	}
}

objpropsOverride_UI: action
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
			// matteColorSettsArray[1] = integer(settingsArray[12]);
			// matteColorSettsArray[2] = integer(settingsArray[13]);
			// matteColorSettsArray[3] = integer(settingsArray[14]);
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
			overrideNames[newNumber] = newName + "   (object properties)";
			overrideSettings[newNumber] = newName + "||" + "type2" + "||" + string(matteObjectSetts) + "||" + string(alphaChannelSetts) + "||" + string(unseenByRaysSetts) + "||" + string(unseenByCameraSetts) + "||" + string(unseenByRadiositySetts) + "||" + string(unseenByFogSetts) + "||" + string(selfShadowSetts) + "||" + string(castShadowSetts) + "||" + string(receiveShadowSetts) + "||" + string(matteColorSettsArray.x) + "||" + string(matteColorSettsArray.y) + "||" + string(matteColorSettsArray.z);
		}
	} else {
		error("objpropsOverride_UI: incorrect, or no, action passed");
	}
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
		doUpdate;
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
			overrideNames[newNumber] = newName + "   (.mot file)";
			overrideSettings[newNumber] = newName + "||" + "type3" + "||" + string(motFile);
		}
	} else {
		error("motOverride_UI: incorrect, or no, action passed");
	}
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
		doUpdate;
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
			overrideNames[newNumber] = newName + "   (.lwo file)";
			overrideSettings[newNumber] = newName + "||" + "type4" + "||" + string(lwoFile);
		}
	} else {
		error("lwoOverride_UI: incorrect, or no, action passed");
	}
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
		doUpdate;
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
			overrideNames[newNumber] = newName + "   (light exclusion)";
			overrideSettings[newNumber] = newName + "||" + "type7" + "||" + string(excludedLightsSetts);
		}
	} else {
		error("lightexclOverride_UI: incorrect, or no, action passed");
	}
}

scnmasterOverride_UI: action
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
			depthBufferAASetts 			= integer(settingsArray[5]);
			renderLinesSetts 			= integer(settingsArray[6]);
			rayRecursionLimitSetts 		= integer(settingsArray[7]);
			redirectBuffersSetts 		= integer(settingsArray[8]);
			disableAASetts 				= integer(settingsArray[9]);
			raytraceShadows 			= integer(settingsArray[10]);
			raytraceReflect 			= integer(settingsArray[11]);
			raytraceRefract 			= integer(settingsArray[12]);
			raytraceTrans 				= integer(settingsArray[13]);
			raytraceOccl 				= integer(settingsArray[14]);
			volumetricAA 				= integer(settingsArray[15]);
			gLensFlares 				= integer(settingsArray[16]);
			shadowMaps 					= integer(settingsArray[17]);
			volLights 					= integer(settingsArray[18]);
			twoSidedALgts 				= integer(settingsArray[19]);
			renderInstances				= integer(settingsArray[20]);
			rayPrecision 				= number(settingsArray[21]);
			rayCutoff 					= number(settingsArray[22]);
			shadingSamples 				= integer(settingsArray[23]);
			lightSamples 				= integer(settingsArray[24]);
			gLightIntensity 			= number(settingsArray[25]);
			gFlareIntensity 			= number(settingsArray[26]);
			enableGI 					= integer(settingsArray[27]);
			giMode 						= integer(settingsArray[28]);
			interpolateGI 				= integer(settingsArray[29]);
			blurBGGI 					= integer(settingsArray[30]);
			transparencyGI 				= integer(settingsArray[31]);
			volumetricGI 				= integer(settingsArray[32]);
			ambOcclGI 					= integer(settingsArray[33]);
			directionalGI 				= integer(settingsArray[34]);
			gradientsGI 				= integer(settingsArray[35]);
			behindTestGI 				= integer(settingsArray[36]);
			useBumpsGI 					= integer(settingsArray[37]);
			giIntensity 				= number(settingsArray[38]);
			giAngTol 					= number(settingsArray[39]);
			giIndBounces 				= integer(settingsArray[40]);
			giMinSpacing 				= number(settingsArray[41]);
			giRPE 						= integer(settingsArray[42]);
			giMaxSpacing 				= number(settingsArray[43]);
			gi2ndBounces				= integer(settingsArray[44]);
			giMultiplier				= number(settingsArray[45]);
			enableCaustics				= integer(settingsArray[46]);
			causticsAccuracy			= integer(settingsArray[47]);
			causticsIntensity			= number(settingsArray[48]);
			causticsSoftness			= integer(settingsArray[49]);
			fiberFXSaveRGBA				= integer(settingsArray[50]);
			fiberFXSaveRGBAType			= integer(settingsArray[51]);
			fiberFXSaveRGBAName			= string(settingsArray[52]);
			fiberFXSaveDepth			= integer(settingsArray[53]);
			fiberFXSaveDepthType		= integer(settingsArray[54]);
			fiberFXSaveDepthName		= string(settingsArray[55]);
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
		ctlposition(c20, ScnMst_gad_x, ScnMst_gad_y, ScnMst_gad_w, ScnMst_gad_h, ScnMst_gad_text_offset);
		
		ui_offset_y = ScnMst_ui_offset_y + ScnMst_ui_row_offset;

		resolutionMultiplierSetts = 3;
		if(action == "edit")
		{
			resolutionMultiplierSetts = integer(settingsArray[3]);
		}
		tempMultiplierArray[1] = "25 %";
		tempMultiplierArray[2] = "50 %";
		tempMultiplierArray[3] = "100 %";
		tempMultiplierArray[4] = "200 %";
		tempMultiplierArray[5] = "400 %";
		c20_5 = ctlpopup("Resolution Multiplier",resolutionMultiplierSetts,tempMultiplierArray);
		ctlposition(c20_5, ScnMst_gad_x, ScnMst_gad_y + ui_offset_y, ScnMst_gad_w, ScnMst_gad_h, ScnMst_gad_text_offset);

		renderModeSetts = 3;
		if(action == "edit")
		{
			renderModeSetts = integer(settingsArray[4]);
		}
		tempTypeArray[1] = "Wireframe";
		tempTypeArray[2] = "Quickshade";
		tempTypeArray[3] = "Realistic";
		c21 = ctlpopup("Render Mode",renderModeSetts,tempTypeArray);
		ctlposition(c21, ScnMst_gad_x2, ScnMst_gad_y + ui_offset_y, ScnMst_gad_w, ScnMst_gad_h, ScnMst_gad_text_offset);

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
		c37 = ctlcheckbox("Render Instances",c37val);
		ctlposition(c37, ScnMst_gad_x2, ScnMst_gad_y + ui_offset_y, ScnMst_gad_w, ScnMst_gad_h, ScnMst_gad_text_offset);

		ui_offset_y += ScnMst_ui_row_offset + 2;
		sep1 = ctlsep(0, ScnMst_ui_seperator_w + 4);
		ctlposition(sep1, -2, ScnMst_gad_y + ui_offset_y);
		ui_offset_y += ScnMst_ui_spacing_y + 2;

		c24val= 16;
		if(action == "edit")
		{
			c24val = rayRecursionLimitSetts;
		}
		c24 = ctlminislider("Ray Recursion Limit", c24val, 0, 64);
		ctlposition(c24, ScnMst_gad_x, ScnMst_gad_y + ui_offset_y, ScnMst_gad_w - 22, ScnMst_gad_h, ScnMst_gad_text_offset);

		c40val = 1; // 11.0 uses 8, 11.5 uses 1
		if(action == "edit")
		{
			c40val = shadingSamples;
		}
		c40 = ctlnumber("Shading Samples:",c40val);
		ctlposition(c40, ScnMst_gad_x2, ScnMst_gad_y + ui_offset_y, ScnMst_gad_w, ScnMst_gad_h, ScnMst_gad_text_offset);

		ui_offset_y += ScnMst_ui_row_offset;
		
		c38val = 6.0;
		if(action == "edit")
		{
			c38val = rayPrecision;
		}
		c38 = ctlnumber("Ray Precision:",c38val);
		ctlposition(c38, ScnMst_gad_x, ScnMst_gad_y + ui_offset_y, ScnMst_gad_w, ScnMst_gad_h, ScnMst_gad_text_offset);

		c41val = 1; // 11.0 uses 8, 11.5 uses 1
		if(action == "edit")
		{
			c41val = lightSamples;
		}
		c41 = ctlnumber("Light Samples:",c41val);
		ctlposition(c41, ScnMst_gad_x2, ScnMst_gad_y + ui_offset_y, ScnMst_gad_w, ScnMst_gad_h, ScnMst_gad_text_offset);

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
		giTypeArray[1] = "Backdrop Only";
		giTypeArray[2] = "Monte Carlo";
		giTypeArray[3] = "Final Gather";
		c45 = ctlpopup("Render Mode",c45val,giTypeArray);
		ctlposition(c45, ScnMst_gad_x2, ScnMst_gad_y + ui_offset_y, ScnMst_gad_w, ScnMst_gad_h, ScnMst_gad_text_offset);

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
			renderInstances 				= getvalue(c37);
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
			overrideSettings[newNumber] = newName 								+ 	"||" 	+ "type6" 						+ 	"||"
										+ string(resolutionMultiplierSetts) 	+ 	"||" 	+ string(renderModeSetts)		+ 	"||"
										+ string(depthBufferAASetts) 			+ 	"||" 	+ string(renderLinesSetts) 		+ 	"||"
										+ string(rayRecursionLimitSetts) 		+	"||" 	+ string(redirectBuffersSetts)	+ 	"||"
										+ string(disableAASetts) 				+ 	"||" 	+ string(raytraceShadows) 		+ 	"||"
										+ string(raytraceReflect) 				+ 	"||" 	+ string(raytraceRefract) 		+ 	"||"
										+ string(raytraceTrans) 				+ 	"||" 	+ string(raytraceOccl) 			+ 	"||"
										+ string(volumetricAA) 					+ 	"||"	+ string(lensFlares)			+	"||"
										+ string(shadowMaps)					+ 	"||"	+ string(volLights)				+	"||"
										+ string(twoSidedALgts)					+ 	"||"	+ string(renderInstances)		+	"||"
										+ string(rayPrecision)					+ 	"||"	+ string(rayCutoff)				+	"||"
										+ string(shadingSamples)				+ 	"||"	+ string(lightSamples)			+	"||"
										+ string(lightIntensity)				+ 	"||"	+ string(flareIntensity)		+	"||"
										+ string(enableGI)						+ 	"||"	+ string(giMode)				+	"||"
										+ string(interpolateGI)					+ 	"||"	+ string(blurBGGI)				+	"||"
										+ string(transparencyGI)				+	"||"	+ string(volumetricGI)			+	"||"
										+ string(ambOcclGI)						+	"||"	+ string(directionalGI)			+	"||"
										+ string(gradientsGI)					+	"||"	+ string(behindTestGI)			+	"||"
										+ string(useBumpsGI)					+	"||"	+ string(giIntensity)			+	"||"
										+ string(giAngTol)						+	"||"	+ string(giIndBounces)			+	"||"
										+ string(giMinSpacing)					+	"||"	+ string(giRPE)					+	"||"
										+ string(giMaxSpacing)					+	"||"	+ string(gi2ndBounces)			+	"||"
										+ string(giMultiplier)					+	"||"	+ string(enableCaustics)		+	"||"
										+ string(causticsAccuracy)				+	"||"	+ string(causticsIntensity)		+	"||"
										+ string(causticsSoftness)				+	"||"	+ string(fiberFXSaveRGBA)		+	"||"
										+ string(fiberFXSaveRGBAType)			+	"||"	+ string(fiberFXSaveRGBAName)	+	"||"
										+ string(fiberFXSaveDepth)				+	"||"	+ string(fiberFXSaveDepthType)	+	"||"
										+ string(fiberFXSaveDepthName);
		}
	} else {
		error("scnmasterOverride_UI: incorrect, or no, action passed");
	}
}
