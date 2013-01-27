srfOverride_UI: action
{
	// sel only used in edit action.
	// action should be either 'new' or 'edit'
	if (action == "new" || action == "edit")
	{
		if(action == "edit")
		{
			newName = settingsArray[1];
			srfFile = settingsArray[3];
		}
		
		if(action == "new)
		{
			newName = "SurfaceOverride";
			srfFile = "*.srf";
		}

		doKeys = 0;

		if(action == "edit")
		{
			reqbegin("Edit .srf Override");
		}
		if(action == "new")
		{
			reqbegin("New .srf Override");
		}
		
		c20 = ctlstring("Override Name:", newName);
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
			newNumber;
			if(action == "edit")
			{
				newNumber = sel;
			}
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
		if(action == "edit")
		{
			lightColorSettsArrays[1] = integer(settingsArray[3]);
			lightColorSettsArrays[2] = integer(settingsArray[4]);
			lightColorSettsArrays[3] = integer(settingsArray[5]);
			lightIntensitySetts = number(settingsArray[6]);
			affectDiffuseSetts = integer(settingsArray[7]);
			affectSpecularSetts = integer(settingsArray[8]);
			affectOpenGLSetts = integer(settingsArray[9]);
			lensFlareSetts = integer(settingsArray[10]);
			volumetricLightingSetts = integer(settingsArray[11]);
			lightColorSettsArray = <lightColorSettsArrays[1], lightColorSettsArrays[2], lightColorSettsArrays[3]>;
		}
		
		doKeys = 0;
		if(action == "edit") 
		{
			reqbegin("Edit Light Override");
		}
		if(action == "new") 
		{
			reqbegin("New Light Override");
		}
		reqsize(LgtProp_ui_window_w, 240);

		newName;
		if(action == "edit")
		{
			newName = settingsArray[1];
		}
		if(action == "new")
		{
			newName = "LgtPropsOverride";
		}
		c20 = ctlstring("Override Name",newName, 131);
		ctlposition(c20, LgtProp_gad_x, LgtProp_gad_y, LgtProp_gad_w, LgtProp_gad_h, LgtProp_gad_text_offset);

		ui_offset_y = LgtProp_ui_offset_y + LgtProp_ui_row_offset;

		c22val;
		if(action == "edit")
		{
			c22val = lightColorSettsArray;
		}
		if(action == "new)
		{
			c22val = 255;
		}
		c22 = ctlcolor("Light Color", c22val);
		ctlposition(c22, LgtProp_gad_x, LgtProp_gad_y + ui_offset_y, LgtProp_gad_w, LgtProp_gad_h, LgtProp_gad_text_offset);

		ui_offset_y += LgtProp_ui_row_offset;

		c23val;
		if(action == "edit")
		{
			c23val = lightIntensitySetts;
		}
		if(action == "new")
		{
			c23val =  1.0;
		}
		c23 = ctlpercent("Light Intensity", c23val);
		ctlposition(c23, LgtProp_gad_x, LgtProp_gad_y + ui_offset_y, LgtProp_gad_w - 22, LgtProp_gad_h, LgtProp_gad_text_offset);

		ui_offset_y += LgtProp_ui_row_offset + 12;
		s20 = ctlsep(0, LgtProp_ui_seperator_w + 4);
		ctlposition(s20, -2, ui_offset_y);
		ui_offset_y += LgtProp_ui_spacing_y + 2;

		c24val;
		if(action == "edit")
		{
			c24val = affectDiffuseSetts;
		}
		if(action == "new")
		{
			c24val = 1;
		}
		c24 = ctlcheckbox("Affect Diffuse          ",c24val);
		ctlposition(c24, LgtProp_gad_x, LgtProp_gad_y + ui_offset_y, LgtProp_gad_w, LgtProp_gad_h, LgtProp_gad_text_offset);

		ui_offset_y += LgtProp_ui_row_offset;

		c25val;
		if(action == "edit")
		{
			c25val = affectSpecularSetts;
		}
		if(action == "new")
		{
			c25val = 1;
		}
		c25 = ctlcheckbox("Affect Specular     ",c25val);
		ctlposition(c25, LgtProp_gad_x, LgtProp_gad_y + ui_offset_y, LgtProp_gad_w, LgtProp_gad_h, LgtProp_gad_text_offset);

		ui_offset_y += LgtProp_ui_row_offset;

		c26val;
		if(action == "edit")
		{
			c26val = affectOpenGLSetts;
		}
		if(action == "new")
		{
			c26val = 1;
		}
		c26 = ctlcheckbox("Affect OpenGL          ",c26val);
		ctlposition(c26, LgtProp_gad_x, LgtProp_gad_y + ui_offset_y, LgtProp_gad_w, LgtProp_gad_h, LgtProp_gad_text_offset);

		ui_offset_y += LgtProp_ui_row_offset;

		c27val;
		if(action == "edit")
		{
			c27val = lensFlareSetts;
		}
		if(action == "new")
		{
			c27val = 0;
		}
		c27 = ctlcheckbox("Lens Flare               ",c27val);
		ctlposition(c27, LgtProp_gad_x, LgtProp_gad_y + ui_offset_y, LgtProp_gad_w, LgtProp_gad_h, LgtProp_gad_text_offset);

		ui_offset_y += LgtProp_ui_row_offset;

		c28val;
		if(action == "edit")
		{
			c28val = volumetricLightingSetts;
		}
		if(action == "new")
		{
			c28val = 0;
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
			affectOpenGLSetts = getvalue(c26);
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
			if(action == "edit")
			{
				newNumber = sel;
			}
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
			overrideSettings[newNumber] = newName + "||" + "type5" + "||" +	string(lightColorSettsArray.x) +  "||" + string(lightColorSettsArray.y) + "||" + string(lightColorSettsArray.z) + "||" + string(lightIntensitySetts) + "||" + string(affectDiffuseSetts) + "||" + string(affectSpecularSetts) + "||" + string(affectOpenGLSetts)  + "||" + string(lensFlareSetts)  + "||" + string(volumetricLightingSetts);
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
		if(action == "edit")
		{
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
		
		if(action == "edit")
		{
			reqbegin("Edit ObjProps Override");
		}
		if(action == "new")
		{
			reqbegin("New ObjProps Override");
		}
		reqsize(ObjProp_ui_window_w,320);

		if(action == "edit")
		{
			newName = settingsArray[1];
		}
		if(action == "new")
		{
			newName = "ObjPropsOverride";
		}
		c20 = ctlstring("Override Name:",newName);
		ctlposition(c20, ObjProp_gad_x, ObjProp_gad_y, ObjProp_gad_w, ObjProp_gad_h, ObjProp_gad_text_offset);
		
		ui_offset_y = ObjProp_ui_offset_y + ObjProp_ui_row_offset;

		if(action == "edit")
		{
			c21val = matteObjectSetts;
		}
		if(action == "new")
		{
			c21val = 0;
		}
		c21 = ctlcheckbox("Matte Object",c21val);
		ctlposition(c21, ObjProp_gad_x, ObjProp_gad_y + ui_offset_y, ObjProp_gad_w, ObjProp_gad_h, ObjProp_gad_text_offset);

		ui_offset_y += ObjProp_ui_row_offset;

		if(action == "edit")
		{
			c21_5val = matteColorSettsArray;
		}
		if(action == "new")
		{
			c21_5val = 0;
		}
		c21_5 = ctlcolor("Color",c21_5val);
		ctlposition(c21_5, ObjProp_gad_x, ObjProp_gad_y + ui_offset_y, ObjProp_gad_w, ObjProp_gad_h, ObjProp_gad_text_offset);

		ui_offset_y += ObjProp_ui_row_offset;

		if(action == "edit")
		{
			c22val = alphaChannelSetts;
		}
		if(action == "new")
		{
			c22val = 1;
		}
		c22 = ctlpopup("Alpha Channel",c22val,tempAlphaArray);
		ctlposition(c22, ObjProp_gad_x, ObjProp_gad_y + ui_offset_y, ObjProp_gad_w, ObjProp_gad_h, ObjProp_gad_text_offset);

		ui_offset_y += ObjProp_ui_row_offset + 12;
		s20 = ctlsep(0, ObjProp_ui_seperator_w + 4);
		ctlposition(s20, -2, ui_offset_y);
		ui_offset_y += ObjProp_ui_spacing_y + 2;

		if(action == "edit")
		{
			c23val = unseenByRaysSetts;
		}
		if(action == "new")
		{
			c23val = 0;
		}
		c23 = ctlcheckbox("Unseen by Rays      ",c23val);
		ctlposition(c23, ObjProp_gad_x, ObjProp_gad_y + ui_offset_y, ObjProp_gad_w, ObjProp_gad_h, ObjProp_gad_text_offset);

		ui_offset_y += ObjProp_ui_row_offset;

		if(action == "edit")
		{
			c24val = unseenByCameraSetts;
		}
		if(action == "new")
		{
			c24val = 0;
		}
		c24 = ctlcheckbox("Unseen by Camera",c24val);
		ctlposition(c24, ObjProp_gad_x, ObjProp_gad_y + ui_offset_y, ObjProp_gad_w, ObjProp_gad_h, ObjProp_gad_text_offset);

		ui_offset_y += ObjProp_ui_row_offset;

		if(action == "edit")
		{
			c25val = unseenByRadiositySetts;
		}
		if(action == "new")
		{
			c25val = 0;
		}
		c25 = ctlcheckbox("Unseen by Radiosity",c25val);
		ctlposition(c25, ObjProp_gad_x, ObjProp_gad_y + ui_offset_y, ObjProp_gad_w, ObjProp_gad_h, ObjProp_gad_text_offset);

		ui_offset_y += ObjProp_ui_row_offset;

		if(action == "edit")
		{
			c26val = unseenByFogSetts;
		}
		if(action == "new")
		{
			c26val = 0;
		}
		c26 = ctlcheckbox("Unaffected by Fog  ",c26val);
		ctlposition(c26, ObjProp_gad_x, ObjProp_gad_y + ui_offset_y, ObjProp_gad_w, ObjProp_gad_h, ObjProp_gad_text_offset);

		ui_offset_y += ObjProp_ui_row_offset + 12;
		s21 = ctlsep(0, ObjProp_ui_seperator_w + 4);
		ctlposition(s21, -2, ui_offset_y);
		ui_offset_y += ObjProp_ui_spacing_y + 2;

		if(action == "edit")
		{
			c27val = selfShadowSetts;
		}
		if(action == "new")
		{
			c27val = 1;
		}
		c27 = ctlcheckbox("Self Shadow     ",c27val);
		ctlposition(c27, ObjProp_gad_x, ObjProp_gad_y + ui_offset_y, ObjProp_gad_w, ObjProp_gad_h, ObjProp_gad_text_offset);

		ui_offset_y += ObjProp_ui_row_offset;

		if(action == "edit")
		{
			c28val = castShadowSetts;
		}
		if(action == "new")
		{
			c28val = 1;
		}
		c28 = ctlcheckbox("Cast Shadow     ",c28val);
		ctlposition(c28, ObjProp_gad_x, ObjProp_gad_y + ui_offset_y, ObjProp_gad_w, ObjProp_gad_h, ObjProp_gad_text_offset);

		ui_offset_y += ObjProp_ui_row_offset;

		if(action == "edit")
		{
			c29val = receiveShadowSetts;
		}
		if(action == "new")
		{
			c29val = 1;
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
			if(action == "edit")
			{
				newNumber = sel;
			}
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
		doKeys = 0;
		if(action == "edit")
		{
			reqbegin("Edit .mot Override");
		}
		if(action == "new")
		{
			reqbegin("New .mot Override");
		}
		if(action == "edit")
		{
			newName = settingsArray[1];
		}
		if(action == "new")
		{
			newName = "MotionOverride";
		}
		c20 = ctlstring("Override Name:",newName);
		
		if(action == "edit")
		{
			motFile = settingsArray[3];
		}
		if(action == "new")
		{
			motFile = "*.mot";
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
			if(action == "edit")
			{
				newNumber = sel;
			}
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
		
		doKeys = 0;
		if(action == "edit")
		{
			reqbegin("Edit .lwo Override");
		}
		if(action == "new")
		{
			reqbegin("New .lwo Override");
		}

		if(action == "edit")
		{
			newName = settingsArray[1];
		}
		if(action == "new")
		{
			newName = "AltObjOverride";
		}
		c20 = ctlstring("Override Name:",newName);


		if(action == "edit")
		{
			lwoFile = settingsArray[3];
		}
		if(action == "new")
		{
			lwoFile = "*.lwo";
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
			if(action == "edit")
			{
				newNumber = sel;
			}
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
		for(x = 0; x < size(lightNames); x++)
		{
			xInverse = size(lightNames) - x;
			lightListArray[x + 1] = lightNames[xInverse];
		}
		lightListArray[size(lightNames) + 1] = "Radiosity";
		lightListArray[size(lightNames) + 2] = "Caustics";
		
		doKeys = 0;
		
		if(action == "edit")
		{
			reqbegin("Edit Light Exclusion Override");
		}
		if(action == "new")
		{
			reqbegin("New Light Exclusion Override");
		}
		
		if(action == "edit")
		{
			newName = settingsArray[1];
		}
		if(action == "new")
		{
			newName = "LgtExclusion";
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

		if (action == "edit")
		{
			if(size(settingsArray) >= 3)
			{
				if(settingsArray[3] != nil && settingsArray[3] != "")
				{
					tempLightTransferring = settingsArray[3];
				}
				else
				{
					tempLightTransferring = "";
				}
			}
			else
			{
				tempLightTransferring = "";
			}
		}
		
		if (action == "new")
		{
			tempLightTransferring = "";			
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
			if(action == "edit")
			{
				newNumber = sel;
			}
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
		if(action == "edit")
		{
			resolutionMultiplierSetts = integer(settingsArray[3]);
			renderModeSetts = integer(settingsArray[4]);
			depthBufferAASetts = integer(settingsArray[5]);
			renderLinesSetts = integer(settingsArray[6]);
			rayRecursionLimitSetts = integer(settingsArray[7]);
			redirectBuffersSetts = integer(settingsArray[8]);
			disableAASetts = integer(settingsArray[9]);
		}
	
		doKeys = 0;
		if(action == "edit")
		{
			reqbegin("Edit Scene Master Override");
		}
		if(action == "new")
		{
			reqbegin("New Scene Master Override");
		}
		reqsize(ScnMst_ui_window_w, 240);

		if(action == "edit")
		{
			newName = settingsArray[1];
		}
		if(action == "new")
		{
			newName = "SceneMasterOverride";
		}
		c20 = ctlstring("Override Name:",newName);
		ctlposition(c20, ScnMst_gad_x, ScnMst_gad_y, ScnMst_gad_w, ScnMst_gad_h, ScnMst_gad_text_offset);
		
		ui_offset_y = ScnMst_ui_offset_y + ScnMst_ui_row_offset;

		tempMultiplierArray[1] = "25 %";
		tempMultiplierArray[2] = "50 %";
		tempMultiplierArray[3] = "100 %";
		tempMultiplierArray[4] = "200 %";
		tempMultiplierArray[5] = "400 %";
		c20_5 = ctlpopup("Resolution Multiplier",resolutionMultiplierSetts,tempMultiplierArray);
		ctlposition(c20_5, ScnMst_gad_x, ScnMst_gad_y + ui_offset_y, ScnMst_gad_w, ScnMst_gad_h, ScnMst_gad_text_offset);

		ui_offset_y += ScnMst_ui_row_offset;

		tempTypeArray[1] = "Wireframe";
		tempTypeArray[2] = "Quickshade";
		tempTypeArray[3] = "Realistic";
		c21 = ctlpopup("Render Mode",renderModeSetts,tempTypeArray);
		ctlposition(c21, ScnMst_gad_x, ScnMst_gad_y + ui_offset_y, ScnMst_gad_w, ScnMst_gad_h, ScnMst_gad_text_offset);

		ui_offset_y += ScnMst_ui_row_offset;

		if(action == "edit")
		{
			c22val = depthBufferAASetts
		}
		if(action == "new")
		{
			c22val = 0;
		}
		c22 = ctlcheckbox("Depth Buffer AA",c22val);
		ctlposition(c22, ScnMst_gad_x, ScnMst_gad_y + ui_offset_y, ScnMst_gad_w, ScnMst_gad_h, ScnMst_gad_text_offset);

		ui_offset_y += ScnMst_ui_row_offset;

		if(action == "edit")
		{
			c23val = renderLinesSetts;
		}
		if(action == "new")
		{
			c23val = 1;
		}
		c23 = ctlcheckbox("Render Lines",c23val);
		ctlposition(c23, ScnMst_gad_x, ScnMst_gad_y + ui_offset_y, ScnMst_gad_w, ScnMst_gad_h, ScnMst_gad_text_offset);

		ui_offset_y += ScnMst_ui_row_offset;

		if(action == "edit")
		{
			c24val = rayRecursionLimitSetts;
		}
		if(action == "new")
		{
			c24val= 16;
		}
		c24 = ctlminislider("Ray Recursion Limit", c24val, 0, 24);
		ctlposition(c24, ScnMst_gad_x, ScnMst_gad_y + ui_offset_y, ScnMst_gad_w - 22, ScnMst_gad_h, ScnMst_gad_text_offset);

		ui_offset_y += ScnMst_ui_row_offset + 12;
		s21 = ctlsep(0, ScnMst_ui_seperator_w + 4);
		ctlposition(s21, -2, ScnMst_ui_offset_y);
		ui_offset_y += ScnMst_ui_spacing_y + 2;

		if(action == "edit")
		{
			c25val = redirectBuffersSetts;
		}
		if(action == "new")
		{
			c25val = 0;
		}
		c25 = ctlcheckbox("Redirect Buffer Export Paths",c25val);
		ctlposition(c25, ScnMst_gad_x, ScnMst_gad_y + ui_offset_y, ScnMst_gad_w, ScnMst_gad_h, ScnMst_gad_text_offset);

		ui_offset_y += ScnMst_ui_row_offset;

		if(action == "edit")
		{
			c26val = disableAASetts;
		}
		if(action == "new")
		{
			c26val = 0;
		}
		c26 = ctlcheckbox("Disable all AA",c26val);
		ctlposition(c26, ScnMst_gad_x, ScnMst_gad_y + ui_offset_y, ScnMst_gad_w, ScnMst_gad_h, ScnMst_gad_text_offset);
		
		if(reqpost())
		{
			newName = getvalue(c20);
			newName = makeStringGood(newName);
			resolutionMultiplierSetts = getvalue(c20_5);
			renderModeSetts = getvalue(c21);
			depthBufferAASetts = getvalue(c22);
			renderLinesSetts = getvalue(c23);
			rayRecursionLimitSetts = getvalue(c24);
			redirectBuffersSetts = getvalue(c25);
			disableAASetts = getvalue(c26);
			doUpdate = 1;
		}
		else
		{
			doUpdate = 0;
		}
		reqend();
		if(doUpdate == 1)
		{
			if(action == "edit")
			{
				newNumber = sel;
			}
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
			overrideSettings[newNumber] = newName + "||" + "type6" + "||" + string(resolutionMultiplierSetts) + "||" + string(renderModeSetts) + "||" + string(depthBufferAASetts) + "||" + string(renderLinesSetts) + "||" + string(rayRecursionLimitSetts) + "||" + string(redirectBuffersSetts) + "||" + string(disableAASetts);
		}
	} else {
		error("scnmasterOverride_UI: incorrect, or no, action passed");
	}
}
