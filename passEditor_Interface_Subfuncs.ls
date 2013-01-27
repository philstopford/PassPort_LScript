undoOverrideSelect
{
	pass = currentChosenPass;
	sel = getvalue(gad_OverridesListview).asInt();
	if(overrideNames[1] != "empty")
	{
	    if(overridesSelected == true && sel != 0)
	    {
			temp = passOverrideItems[pass][sel];
			if(previousPassOverrideItems != nil)
			{
				if(previousPassOverrideItems[pass][sel] != nil)
				{
					passOverrideItems[pass][sel] = previousPassOverrideItems[pass][sel];
					previousPassOverrideItems[pass][sel] = temp;
					set_o_items = o_parseListItems(passOverrideItems[pass][sel]);
					setvalue(gad_SceneItems_forOverrides_Listview,set_o_items);
					setvalue(gad_PassesListview,nil);
					req_update();
				}
				else
		    	{
		    		req_update();
		    	}
			}
			else
	    	{
	    		req_update();
	    	}
	    }
		else
    	{
    		setvalue(gad_SceneItems_forOverrides_Listview,nil);
    		req_update();
    	}
	}
	else
   	{
   		setvalue(gad_SceneItems_forOverrides_Listview,nil);
   		req_update();
   	}
}

undoItemSelect
{
	sel = getvalue(gad_PassesListview).asInt();
    if(passSelected == true && sel != 0)
    {
    	temp = passAssItems[sel];
    	//previousPassAssItems[sel] = passAssItems[sel];
    	if(previousPassAssItems != nil)
    	{
	    	if(previousPassAssItems[sel] != nil)
	    	{
	    		passAssItems[sel] = previousPassAssItems[sel];
	    		previousPassAssItems[sel] = temp;
	    		setitems = parseListItems(passAssItems[sel]);
				setvalue(gad_SceneItems_forPasses_Listview,setitems);
				setvalue(gad_OverridesListview,nil);
	    	}
	        else
	    	{
	    		req_update();
	    	}
    	}
    	 else
    	{
    		req_update();
    	}
    }
    else
    {
		setvalue(gad_SceneItems_forPasses_Listview,nil);
    	req_update();
	}
}

// interface secondary functions and sub-interfaces
createNewFullScenePass
{
	doKeys = 0;
	reqbegin("New Full Pass");
	c20 = ctlstring("Pass Name:","Full_Pass");
	if(reqpost())
	{
		newName = getvalue(c20);
		newName = makeStringGood(newName);
	}

	reqend();
	
	newNumber = size(passNames) + 1;
	passNames[newNumber] = newName;
    passAssItems[newNumber] = "";
    passOverrideItems[newNumber][size(overrideNames)] = "";
    for(y = 1; y <= size(overrideNames); y++)
    {
    	passOverrideItems[newNumber][y] = "";
    }
	items_size = sizeof(displayNames);
	for(x = 1;x <= items_size;x++)
	{
		items_array[x] = x;
		passAssItems[newNumber] = passAssItems[newNumber] + "||" + displayIDs[x];
	}
	setitems = parseListItems(passAssItems[newNumber]);
	setvalue(gad_SceneItems_forPasses_Listview,setitems);
}

createNewEmptyPass
{
	doKeys = 0;
	reqbegin("New Empty Pass");
	c20 = ctlstring("Pass Name:","Empty_Pass");
	if(reqpost())
	{
		newName = getvalue(c20);
		newName = makeStringGood(newName);
	}
	reqend();
	newNumber = size(passNames) + 1;
	passNames[newNumber] = newName;
    passAssItems[newNumber] = "";
    passOverrideItems[newNumber][size(overrideNames)] = "";
    for(y = 1; y <= size(overrideNames); y++)
    {
    	passOverrideItems[newNumber][y] = "";
    }
}
createNewPassFromLayoutSelection
{
	//sleep(1);
	//RefreshNow();
	//EditObjects();
	s = masterScene.getSelect();
	//info(Scene().getSelect());
	
	doKeys = 0;
	reqbegin("New Selection Pass");
	c20 = ctlstring("Pass Name:","Selection_Pass");
	if(reqpost())
	{
		newName = getvalue(c20);
		newName = makeStringGood(newName);
	}
	reqend();
	newNumber = size(passNames) + 1;
	passNames[newNumber] = newName;
    passAssItems[newNumber] = "";
    passOverrideItems[newNumber][size(overrideNames)] = "";
    for(y = 1; y <= size(overrideNames); y++)
    {
    	passOverrideItems[newNumber][y] = "";
    }
    
    	//s = masterScene.getSelect();
    	//info(s);
    	if(s != nil)
    	{
			arraySize = sizeof(s);
			//newNumber = sel;
			for(x = 1; x <= arraySize; x++)
			{
				itemname = s[x].name;
				//previousPassAssItems[newNumber] = passAssItems[newNumber];
				switch(s[x].genus)
				{
					case 1:
						tempMeshAgents[x] = Mesh(itemname);
						tempMeshNames[x] = tempMeshAgents[x].name;
						tempMeshIDs[x] = tempMeshAgents[x].id;
						passAssItems[newNumber] = passAssItems[newNumber] + "||" + tempMeshIDs[x];
						break;
					
					case 2:
						tempLightAgents[x] = Light(itemname);
						tempLightNames[x] = tempLightAgents[x].name;
						tempLightIDs[x] = tempLightAgents[x].id;
						passAssItems[newNumber] = passAssItems[newNumber] + "||" + tempLightIDs[x];
						break;
						
					default:
						break;
				}
			}
			
			//setitems = parseListItems(passAssItems[newNumber]);
			//setvalue(gad_SceneItems_forPasses_Listview,setitems);
			
					
			SelectItem(s[1].id);
			for(x = 1; x <= size(s); x++)
			{
				AddToSelection(s[x].id);
			}
			
    	}
		
		setitems = parseListItems(passAssItems[newNumber]);
		setvalue(gad_SceneItems_forPasses_Listview,setitems);
		

}

duplicateSelectedPass
{
	sel = getvalue(gad_PassesListview).asInt();
    if(passSelected == true && sel != 0)
    {
    	newNumber = size(passNames) + 1;
		passNames[newNumber] = passNames[sel] + "_copy";
	    passAssItems[newNumber] = passAssItems[sel];
	    passOverrideItems[newNumber][size(overrideNames)] = "";
	    for(y = 1; y <= size(overrideNames); y++)
	    {
	    	passOverrideItems[newNumber][y] = passOverrideItems[sel][y];
	    }
    }
	    	
}

duplicateSelectedOverride
{
	sel = getvalue(gad_OverridesListview).asInt();
    if(overridesSelected == true && sel != 0)
    {
		settingsArray = parseOverrideSettings(overrideSettings[sel]);
		if(settingsArray != nil && settingsArray != "")
		{
			newNumber = size(overrideNames) + 1;
			tempOSettings = parse("||",overrideSettings[sel]);
			newName = tempOSettings[1] + "_copy";
			overrideSettings[newNumber] = newName;
			for(x = 2; x <= size(tempOSettings); x++)
			{
				overrideSettings[newNumber] = overrideSettings[newNumber] + "||" + tempOSettings[x];
			}
		    passOverrideItems[currentChosenPass][newNumber] = "";
		    for(y = 1; y <= size(passNames); y++)
		    {
		    	passOverrideItems[y][newNumber] = passOverrideItems[y][sel];
		    }
		    //overrideSettings[newNumber] = overrideSettings[sel];
		    
		    //deal with the weird appendix thing that's type dependent, dammit.
		    overrideTempType = integer(strright(tempOSettings[2],1));
		    switch(overrideTempType)
		    {
		    	case 1:
		    		overrideNames[newNumber] = newName + "   (.srf file)";
		    		break;
		    		
		    	case 2:
		    		overrideNames[newNumber] = newName + "   (object properties)";
		    		break;
		    		
		    	case 3:
		    		overrideNames[newNumber] = newName + "   (.mot file)";
		    		break;
		    		
		    	case 4:
		    		overrideNames[newNumber] = newName + "   (.lwo file)";
		    		break;
		    		
		    	case 5:
		    		overrideNames[newNumber] = newName + "   (light properties)";
		    		break;
		    		
		    	case 6:
		    		overrideNames[newNumber] = newName + "   (scene properties)";
		    		break;

		    	case 7:
		    		overrideNames[newNumber] = newName + "   (light exclusion)";
		    		break;
		    		
		    		
		    	default:
		    		break;
		    }
		    //req_update();
		}
    }
}

editSelectedOverride
{
    sel = getvalue(gad_OverridesListview).asInt();
    if(overridesSelected == true && sel != 0)
    {
		settingsArray = parseOverrideSettings(overrideSettings[sel]);
		if(settingsArray != nil && settingsArray != "")
		{
			typeInteger = integer(strright(settingsArray[2],1));
			switch(typeInteger)
			{
				case 1:
					srfOverride_UI("edit");
				    reProcess();
					req_update();
					break;
						
				case 5:
					lightOverride_UI("edit");
					reProcess();
					req_update();
					break;

				case 2:
					objpropsOverride_UI("edit");
					reProcess();
					req_update();
					break;
					
				case 3:
					motOverride_UI("edit");
					reProcess();
					req_update();
					break;
					
				case 4:
					lwoOverride_UI("edit");
					reProcess();
					req_update();
					break;
					
				case 7:
					lightexclOverride_UI("edit");
					reProcess();
					req_update();
					break;

					
				case 6:
					scnmasterOverride_UI("edit");
					reProcess();
					req_update();
					break;
					
				default:
					break;
			}
	    }
	    else
	    {
	    	error("There has been a problem with the scene save of this override.  Please delete and recreate.");
	    }
    }
}

lightExclusionAddLight
{
	lightInteger = getvalue(light21);
	if(tempLightTransferring == "")
	{
		tempLightTransferring = lightListArray[lightInteger];
	}
	else
	{
		tempLightTransferring = tempLightTransferring + ";" + lightListArray[lightInteger];
	}
	setvalue(light23,tempLightTransferring);
	req_update();
}


createLightExclusionOverride
{
	lightexclOverride_UI("new");
	reProcess();
	req_update();
}

createLgtPropOverride
{
	lightOverride_UI("new");
	reProcess();
	req_update();
}

createObjPropOverride
{
	objpropsOverride_UI("new");
	reProcess();
	req_update();
}

createSrfOverride
{
	srfOverride_UI("new");
	reProcess();
	req_update();
}

createMotOverride
{
	motOverride_UI("new");
	reProcess();
	req_update();
}

createAltObjOverride
{
	lwoOverride_UI("new");
	reProcess();
	req_update();
}

createSceneMasterOverride
{
	scnmasterOverride_UI("new");
	reProcess();
	req_update();
}

aboutPassPortDialog
{
	this_script = split(SCRIPTID);
	this_script_path = this_script[1] + this_script[2];

	// Check if the script is compiled, if so, don't need to find the banner images on disk
	compiled = 1;
	s = strsub(this_script[4], size(this_script[4]), 1);  // simply check the extension terminating character - c means compiled.
	if(s =="s" || s =="S")
	{
		compiled = 0;
	}

	doKeys = 0;
	reqbegin("About PassPort");
	reqsize(aboutsize_x,aboutsize_y);

	// About Graphic
	if(compiled)
	{
		c_banner = ctlimage( "Passport_About.tga" );
	}else
	{
		banner_filename = this_script_path + "Passport_About.tga";
		c_banner = ctlimage( banner_filename );
	}
	ctlposition(c_banner,0,0);

	reqredraw("aboutPassPortDialog_redraw");
	if(reqpost())
	{
	}

	reqend();
	doKeys = 1;
}

// About Box redraw function (drawtext doesn't have a background colour, whereas ctltext gadgets do, which were previously used)
// Matt Gorner
aboutPassPortDialog_redraw
{
	if(reqisopen())
	{
		txt_y = 135;
		drawline(<038,038,040>, 0, txt_y - 10, aboutsize_x, txt_y - 10);
		lwversion = string(string(hostVersion()) + " (" + string(hostBuild()) + ")" );
		str = string("Version: " + versionString + " on LW version: " + lwversion);
		drawtext(str, <0,0,0>, 10, txt_y);
		str = string("Platform: " + platformInformation(platform()));
		drawtext(str, <0,0,0>, 10, txt_y + drawtextheight(str) );
	}
}

platformInformation: platformVar
{
	switch(platformVar) {
		case WIN32:
			parch = "Win_x86";
			break;
		case WIN64:
			parch = "Win_x86_64";
			break;
		case MACUB:
			parch = "MacUB_x86";
			break;
		case MAC64:
			parch = "MacUB_x86_64";
			break;
		default:
			parch = "unknown: " + string(platform());
			break;
	}
	return parch;
}

preferencePanel
{
	resolutionsArray[1] = "640 x 540";
	resolutionsArray[2] = "640 x 385";
	resolutionsArray[3] = "457 x 540";
	resolutionsArray[4] = "457 x 385";
	
	tempMultiplierArray[1] = "25 %";
	tempMultiplierArray[2] = "50 %";
	tempMultiplierArray[3] = "100 %";
	tempMultiplierArray[4] = "200 %";
	tempMultiplierArray[5] = "400 %";

	rgbSaveType = integer(rgbSaveType);
	doKeys = 0;

	reqbegin("PassPort Preferences");
	reqsize(Pref_ui_window_w,500);

	// c20 = ctlfilename("Select output folder...",userOutputFolder,30,0);
	c20 = ctlfoldername("Scene Save Location:", userOutputFolder,);
	ctlposition(c20, Pref_gad_x, Pref_ui_offset_y, Pref_gad_w, Pref_gad_h, Pref_gad_text_offset);

	ui_offset_y = Pref_ui_offset_y + Pref_ui_row_offset;

	c21 = ctlstring("Render file prefix",fileOutputPrefix);
	ctlposition(c21, Pref_gad_x, ui_offset_y, Pref_gad_w, Pref_gad_h, Pref_gad_text_offset);

	ui_offset_y += Pref_ui_row_offset;

	c22 = ctlstring("User",userOutputString);
	ctlposition(c22, Pref_gad_x, ui_offset_y, Pref_gad_w, Pref_gad_h, Pref_gad_text_offset);

	ui_offset_y += Pref_ui_row_offset + 4;

	s20 = ctlsep();
	ctlposition(s20, -2, ui_offset_y);

	ui_offset_y += Pref_ui_row_offset + 5;

	c23 = ctlcheckbox("Enable Confirmation Dialogs",areYouSurePrompts);
	ctlposition(c23, Pref_gad_x, ui_offset_y, Pref_gad_w, Pref_gad_h, Pref_gad_text_offset);

	ui_offset_y += Pref_ui_row_offset;

	c26 = ctlpopup("Editor UI Size (On Reopen)",editorResolution,resolutionsArray);
	ctlposition(c26, Pref_gad_x, ui_offset_y, Pref_gad_w, Pref_gad_h, Pref_gad_text_offset);

	ui_offset_y += Pref_ui_row_offset + 4;

	s21 = ctlsep();
	ctlposition(s21, -2, ui_offset_y);

	ui_offset_y += Pref_ui_spacing + 5;

	c25 = ctlpopup("Sequence Render RGB Type",rgbSaveType,image_formats_array);
	ctlposition(c25, Pref_gad_x, ui_offset_y, Pref_gad_w, Pref_gad_h, Pref_gad_text_offset);

	ui_offset_y += Pref_ui_row_offset + 4;

	s22 = ctlsep();
	ctlposition(s22, -2, ui_offset_y);

	ui_offset_y += Pref_ui_spacing + 5;

	c28 = ctlpopup("Test Resolution Multiplier",testResMultiplier,tempMultiplierArray);
	ctlposition(c28, Pref_gad_x, ui_offset_y, Pref_gad_w, Pref_gad_h, Pref_gad_text_offset);

	ui_offset_y += Pref_ui_row_offset;

	c29 = ctlpopup("Test Render RGB Type", testRgbSaveType, image_formats_array);
	ctlposition(c29, Pref_gad_x, ui_offset_y, Pref_gad_w, Pref_gad_h, Pref_gad_text_offset);

	if(reqpost())
	{
		userOutputFolder = getvalue(c20);
		fileOutputPrefix = getvalue(c21);
		fileOutputPrefix = makeStringGood(fileOutputPrefix);
		userOutputString = getvalue(c22);
		userOutputString = makeStringGood(userOutputString);
		areYouSurePrompts = getvalue(c23);
		rgbSaveType = getvalue(c25);
		editorResolution = getvalue(c26);
		testResMultiplier = getvalue(c28);
		testRgbSaveType = getvalue(c29);
	}
	reqend();
}

savePassAsScene
{
	savePassScene = generatePassFile("seq", currentChosenPass);
	
	doKeys = 0;
	reqbegin("Save Pass As Scene...");
	c21 = ctlfilename("Save .lws file...", "*.lws",30,0);
	if(reqpost())
	{
		lwsFile = getvalue(c21);
		doUpdate = 1;
	}
	else
	{
		doUpdate = 0;
	}
	reqend();
	
	if(doUpdate == 1)
	{
		filecopy(savePassScene,lwsFile);
	}
	filedelete(savePassScene);
	doKeys = 1;
}

saveAllPassesAsScenes
{
	//savePassScene = generatePassFile("seq", currentChosenPass);
	
	doKeys = 0;
	reqbegin("Save All Passes As Scene...");
	c21 = ctlfilename("Choose a folder...", "DO_NOT_CHANGE.LWS",30,0);
	if(reqpost())
	{
		lwsFile = getvalue(c21);
		doUpdate = 1;
	}
	else
	{
		doUpdate = 0;
	}
	reqend();
	
	if(doUpdate == 1)
	{	
		for(x = 1; x <= size(passNames); x++)
		{
			saveAllPassesScenes[x] = generatePassFile("seq", x);
			
			lwsFileSplit = split(lwsFile);
			if(lwsFileSplit != nil)
			{
				if(lwsFileSplit[1] != nil)
			    {
			    	newLwsFile = lwsFileSplit[1] + lwsFileSplit[2] + getsep() + passNames[x] + ".lws";
			    }
			    else
			    {
			    	newLwsFile = lwsFileSplit[2] + getsep() + passNames[x] + ".lws";
			    }
			    
			    filecopy(saveAllPassesScenes[x],newLwsFile);
				filedelete(saveAllPassesScenes[x]);
	
			}
			else
			{
				error("Invalid save location.");
			}
		}
	}
	doKeys = 1;
}


renderPassFrame
{
	frameRenderScene = generatePassFile("frame", currentChosenPass);


	// windows frame rendering
  	if(platformVar == WIN32 || platformVar == WIN64)
	{
		win_bg_frameRender(frameRenderScene,testOutputPath);
	}

	// mac UB frame rendering
 	if(platformVar == MACUB || platformVar == MAC64)
	{
		UB_bg_frameRender(frameRenderScene,testOutputPath);
	}
}

renderPassScene
{
	seqRenderScene = generatePassFile("seq", currentChosenPass);
	
	// windows scene rendering
	if(platformVar == WIN32 || platformVar == WIN64)
	{
		win_bg_sceneRender(seqRenderScene,seqOutputPath);
	}
	
	// mac UB scene rendering
	if(platformVar == MACUB || platformVar == MAC64)
	{
		UB_bg_sceneRender(seqRenderScene,seqOutputPath);
	}
}

renderAllScene
{
	for(x = 1; x <= size(passNames); x++)
	{
		seqRenderScene[x] = generatePassFile("seq", x);
	}
	
	// windows all scene rendering
	if(platformVar == WIN32 || platformVar == WIN64)
	{
		win_bg_allSceneRender(seqRenderScene,seqOutputPath);
	}
	
	// mac UB all scene rendering
	if(platformVar == MACUB || platformVar == MAC64)
	{
		UB_bg_allSceneRender(seqRenderScene,seqOutputPath);
	}
}



getImageFormats
{
	config_dir	= getdir("Settings");
	vers		= string(integer(hostVersion()));

	switch(platformVar)
	{
		case MACUB:
		case MAC64:
			// Special case check for LW Extensions due to the "extension cache" file
			if(integer(hostVersion()) >= 10)
			{
				tempString = config_dir + getsep() + "Extensions " + vers;
				input = File(tempString);
				(a,c,m,s,l,u,g) = filestat(tempString);
				// Check for LW 10 'Autoscan Plugins'.  When it is on, LWEXT*.cfg is NOT filled in, but plugins are stored in 'Extension Cache' file instead
				// Not sure of the General Options flag to test, so if the read line is NULL, it means it's not been filled in, and so Extension Cache is being used instead (probably)
				//if(line == NULL)
				if(s.asNum() == 0)
				{
					if(input)
						input.close();
					tempString = config_dir + getsep() + "Extension Cache";
					input = File(tempString);
				}
			}else
			{
				tempString = config_dir + getsep() + "Extensions " + vers;
				input = File(tempString);
			}
			break;

		case WIN32:
			if(integer(hostVersion()) >= 10)
			{
				tempString = config_dir + getsep() + "LWEXT" + vers + ".CFG";
				input = File(tempString);
				(a,c,m,s,l,u,g) = filestat(tempString);
				// Check for LW 10 'Autoscan Plugins'.  When it is on, LWEXT*.cfg is NOT filled in, but plugins are stored in 'Extension Cache' file instead
				// Not sure of the General Options flag to test, so if the read line is NULL, it means it's not been filled in, and so Extension Cache is being used instead (probably)
				//if(line == NULL)
				if(s.asNum() == 0)
				{
					if(input)
						input.close();
					tempString = config_dir + getsep() + "Extension Cache";
					input = File(tempString);
				}
			}else
			{
				tempString = config_dir + getsep() + "LWEXT" + vers + ".CFG";
				input = File(tempString);
			}
			break;

		case WIN64:
			if(integer(hostVersion()) >= 10)
			{
				tempString = config_dir + getsep() + "LWEXT" + vers + "-64.CFG";
				input = File(tempString);
				(a,c,m,s,l,u,g) = filestat(tempString);
				// Check for LW 10 'Autoscan Plugins'.  When it is on, LWEXT*.cfg is NOT filled in, but plugins are stored in 'Extension Cache' file instead
				// Not sure of the General Options flag to test, so if the read line is NULL, it means it's not been filled in, and so Extension Cache is being used instead (probably)
				//if(line == NULL)
				if(s.asNum() == 0)
				{
					if(input)
						input.close();
					tempString = config_dir + getsep() + "Extension Cache-64";
					input = File(tempString);
				}
			}else
			{
				tempString = config_dir + getsep() + "LWEXT" + vers + "-64.CFG";
				input = File(tempString);
			}
			break;

		default:
			break;

	}

	searchstring = "  Class \"ImageSaver\"";
	x = 1;
	if(input)
	{
		while(!input.eof())
		{
			line = input.read();
			if(line == searchstring)
			{
				wholeline[x] = input.read();
				wholelinesize = sizeof(wholeline[x]);
				wholeline_right = strright(wholeline[x],wholelinesize - 8);
				wholeline_left = strleft(wholeline_right,(sizeof(wholeline_right) - 1));
				nextline[x] = wholeline_left;
				x++;
			}else if(line == NULL)
			{
				// Double-check for LW 10 'Autoscan Plugins'.  When it is on, LWEXT*.cfg is NOT filled in, but plugins are stored in 'Extension Cache' file instead
				// Not sure of the General Options flag to test, so if the read line is NULL, it means it's not been filled in, and so Extension Cache is being used instead (probably)
				if(input)
					input.close();
				error("Can't parse 'LWEXT*.cfg' file, turn off 'Autoscan Plugins' and manually scan plugin directory");
				return(nil);
			}
		}
		if(input)
			input.close();
		return(nextline);
	}else
	{
		error("Can't locate 'LWEXT",vers,".cfg' file");
		return(nil);
	}
}

// override subfunctions
checkForOverrideAssignments: currentID, pass
{
	// pass = currentChosenPass;
	if(overrideNames[1] != "empty")
	{
		z = 1;
		for(x = 1; x <= size(overrideNames); x++)
		{
			//set_o_items = parseListItems(passOverrideItems[pass][x]);

			overrideItemsString = passOverrideItems[pass][x];

			idsArray = parse("||", overrideItemsString);
			for(y = 1; y <= size(idsArray); y++)
			{
				if(idsArray[y] == string(currentID))
				{
					assignedArray[z] = x;
					z++;
				}
			}
		}
	}
	return( assignedArray );
}

generateSurfaceObjects: pass,srfLWOInputID,srfInputTemp,currentScenePath,objStartLine
{
	// figure out which mesh object agent we're dealing with here so we can do the surfacing
	for(x = 1; x <= size(meshIDs); x++)
	{
		if(meshIDs[x] == srfLWOInputID)
		{
			selectedMeshID = x;
		}
	}
	
	if(meshAgents[selectedMeshID].null == 1)
	{
		return(nil);
	}
	else
	{
	
		// get the surface base name
		srfInputTempArray = split(srfInputTemp);

		// get the directory and path set up for the temp LWO output
		
		outputFolder = parse("(",userOutputFolder);
		if(outputFolder[1] == nil || outputFolder[1] == "leave empty)")
		{
			error("Please choose an output folder in the preferences.");
		}
		if(chdir(outputFolder[1]))
		{
			if(chdir("CG"))
			{
				if(chdir("temp"))
				{
					if(chdir("tempScenes"))
					{
						if(chdir("tempObjects"))
						{
						}
						else
						{
							mkdir("tempObjects");
							chdir("tempObjects");
						}
						
					}
					else
					{
						mkdir("tempScenes");
						chdir("tempScenes");
						mkdir("tempObjects");
						chdir("tempObjects");
					}
				}
				else
				{
					mkdir("temp");
					chdir("temp");
					mkdir("tempScenes");
					chdir("tempScenes");
					mkdir("tempObjects");
					chdir("tempObjects");
				}
			}
			else
			{
				mkdir("CG");
				chdir("CG");
				mkdir("temp");
				chdir("temp");
				mkdir("tempScenes");
				chdir("tempScenes");
				mkdir("tempObjects");
				chdir("tempObjects");
			}
		}
		else
		{
			mkdir(outputFolder[1]);
			chdir(outputFolder[1]);
			mkdir("CG");
			chdir("CG");
			mkdir("temp");
			chdir("temp");
			mkdir("tempScenes");
			chdir("tempScenes");
			mkdir("tempObjects");
			chdir("tempObjects");
		}
		tempLWOPath = generatePath("LWO", outputFolder[1], string(srfLWOInputID), srfInputTempArray[3], userOutputString, passNames[pass], ".lwo");
		
		srf_file_path = split(srfInputTemp);
		surfaceList = Surface(meshAgents[selectedMeshID]);
		for(x = 1; x <= size(surfaceList); x++)
		{
			progressString = string((x/size(surfaceList))/2);
			msgString = "{" + progressString + "}Overriding Surfaces on " + meshNames[selectedMeshID] + "...";
			StatusMsg(msgString);
			
			// deal with both layer names and clones
			meshBaseName = split(meshAgents[selectedMeshID].filename); 
			if(meshBaseName[3] != nil)
			{
				nameOfObject = meshBaseName[3];
			}
			else
			{
				error("Unable to override surfaces on current object.");
			}
			
			commandAdd = "Surf_SetSurf \"" + surfaceList[x] + "\" \"" + nameOfObject + "\"";
			//info(commandAdd);

			CommandInput(commandAdd);
			commandAdd = "Surf_Save \"surfaceForReturning_" + x + "_.srf\"";
			CommandInput(commandAdd);
			commandAdd = "Surf_Load \"" + srfInputTemp + "\"";
			CommandInput(commandAdd);
			sleep(1);
		}
		
		//SelectItem(srfLWOInputID);
		SelectByName(meshNames[selectedMeshID]);
		SaveObjectCopy(tempLWOPath);

		for(x = 1; x <= size(surfaceList); x++)
		{
			if((((x/size(surfaceList))/2) + 0.5) < 1)
			{
				progressString = string(((x/size(surfaceList))/2) + 0.5);
				msgString = "{" + progressString + "}Overriding Surfaces on " + meshNames[selectedMeshID] + "...";
				StatusMsg(msgString);
			}
			else
			{
				StatusMsg("Completed Overriding Surfaces on " + meshNames[selectedMeshID] + ".");
			}
			
			// deal with both layer names and clones
			meshBaseName = split(meshAgents[selectedMeshID].filename); 
			if(meshBaseName[3] != nil)
			{
				nameOfObject = meshBaseName[3];
			}
			else
			{
				error("Unable to override surfaces on current object.");
			}
			
			commandAdd = "Surf_SetSurf \"" + surfaceList[x] + "\" \"" + nameOfObject + "\"";
			CommandInput(commandAdd);
			commandAdd = "Surf_Load \"surfaceForReturning_" + x + "_.srf\"";
			CommandInput(commandAdd);
			sleep(1);
			filedelete("surfaceForReturning_" + x + "_.srf");
		}
		return(tempLWOPath);
	}
}


makeStringGood: string
{
	stringSize = size(string);
	stringAdd = "";
	for(x = 1; x <= stringSize; x++)
	{
		if(string[x].isAlnum())
		{
			stringAdd = stringAdd + string[x];
		}
		else
		{
			if(string[x].isSpace())
			{
				stringAdd = stringAdd + "_";
			}
			else
			{
				if(string[x] == "_")
				{
					stringAdd = stringAdd + "_";
				}
				else
				{
					if(string[x] == "-")
					{
						stringAdd = stringAdd + "_";
					}
				}
			}
		}
	}
	if(stringAdd == "")
	{
		return("_blank_");
	}
	else
	{
		return(stringAdd);
	}
}

resizePanel: w, h
{

}

saveCurrentPassesSettings
{
	doKeys = 0;
	reqbegin("Save PassPort Settings...");
	c21 = ctlfilename("Save .rpe file...", "*.rpe",30,0);
	if(reqpost())
	{
		rpeFile = getvalue(c21);
		doUpdate = 1;
	}
	else
	{
		doUpdate = 0;
	}
	reqend();
	
	if(doUpdate == 1)
	{
		// do the saving here
		//
		//
		if(rpeFile == nil || rpeFile == "*.rpe")
		{
			error("Not a valid save location.");
		}
		io = File(rpeFile,"w");
		
		passNamesSize = size(passNames);
		io.writeln(passNamesSize);
		for(x = 1; x <= passNamesSize; x++)
		{
			io.writeln(passNames[x]);
			io.writeln(passAssItems[x]);
		}
		
		 for(x = 1; x <= size(overrideNames); x++)
	    {
			if(strleft(overrideNames[x],1) == " ")
    		{
    			tempSize = size(overrideNames[x]) - 16;
    			overrideNames[x] = strright(overrideNames[x],tempSize);
    		}
	    }

		overrideNamesSize = size(overrideNames);
		io.writeln(overrideNamesSize);
		io.writeln(overrideNames[1]);
		
		if(overrideNames[1] != "empty")
		{
			io.writeln(overrideSettings[1]);
		}
		if(overrideNamesSize > 1)
		{
			for(x = 2; x <= overrideNamesSize; x++)
			{
				io.writeln(overrideNames[x]);
				if(overrideNames[1] != "empty")
				{
					io.writeln(overrideSettings[x]);
				}
			}
		}
		for(x = 1; x <= passNamesSize; x++)
		{
			for(y = 1; y <= overrideNamesSize; y++)
			{
				if(overrideNames[1] != "empty")
				{
					io.writeln(passOverrideItems[x][y]);
				}
			}
		}
		io.writeln(userOutputFolder);
		io.writeln(fileOutputPrefix);
		io.writeln(userOutputString);
		io.writeln(areYouSurePrompts);
		io.writeln(rgbSaveType);
		io.writeln(editorResolution);
		io.close();
		
		globalstore("passEditoruserOutputString",userOutputString);
		globalstore("passEditorareYouSurePrompts",areYouSurePrompts);
		globalstore("passEditorrgbSaveType",rgbSaveType);
		globalstore("passEditoreditorResolution",editorResolution);
		
		if(areYouSurePrompts == 1)
		{
			info("Settings saved successfully.");
		}
	}
}

loadPassesSettings
{
	doKeys = 0;
	reqbegin("Load PassPort Settings...");
	c21 = ctlfilename("Load .rpe file...", "*.rpe",30,1);
	c22 = ctlcheckbox("Replace existing settings?",0);
	if(reqpost())
	{
		rpeFile = getvalue(c21);
		replaceChoice = getvalue(c22);
		doUpdate = 1;
	}
	else
	{
		doUpdate = 0;
	}
	reqend();
	
	if(doUpdate == 1)
	{
		if(replaceChoice == 1)
		{
			if(rpeFile == nil || rpeFile == "*.rpe")
			{
				error("Not a valid settings file.");
			}
			io = File(rpeFile,"r");
		
			passNamesSize = io.read().asInt();
			for(x = 1; x <= passNamesSize; x++)
			{
				passNames[x] = io.read();
				passAssItems[x] = io.read();
				if(passAssItems[x] == nil)
				{
					passAssItems[x] = "";
				}
			}
			overrideNamesSize = io.read().asInt();
			overrideNames[1] = io.read();
			if(overrideNames[1] == "empty")
			{
				overrideSettings[1] = "";
			}
			else
			{
				overrideSettings[1] = io.read();
			}
			if(overrideNamesSize > 1)
			{
				for(x = 2; x <= overrideNamesSize; x++)
				{
					overrideNames[x] = io.read();
					if(overrideNames[1] != "empty")
					{
						overrideSettings[x] = io.read();
					}
				}
			}
			for(x = 1; x <= passNamesSize; x++)
			{
				for(y = 1; y <= overrideNamesSize; y++)
				{
					if(overrideNames[1] != "empty")
					{
						passOverrideItems[x][y] = io.read();
						if(passOverrideItems[x][y] == nil)
						{
							passOverrideItems[x][y] = "";
						}
					}
					else
					{
						passOverrideItems[x][y] = "";
					}
				}
			}
			userOutputFolder = io.read();
			if(userOutputFolder == nil)
			{
				userOutputFolder = "";
			}
			fileOutputPrefix = io.read();
			if(fileOutputPrefix == nil)
			{
				fileOutputPrefix = "";
			}
			userOutputString = io.read();
			if(userOutputString == nil)
			{
				userOutputString = "";
			}
			areYouSurePrompts = io.read().asInt();
			rgbSaveType = io.read().asInt();
			editorResolution = io.read().asInt();
			io.close();
			
			//panelWidth = 640;
			panelWidth = integer(globalrecall("passEditorpanelWidth", 640));
			//panelHeight = 540;
			panelHeight = integer(globalrecall("passEditorpanelHeight", 540));
			
			reProcess();
			req_update();
		}
		else
		{
			if(rpeFile == nil || rpeFile == "*.rpe")
			{
				error("Not a valid settings file.");
			}
			io = File(rpeFile,"r");
		
			passNamesSize = io.read().asInt();
			
			newNumberVar = (size(passNames) + 1);
			
			for(x = newNumberVar; x < (newNumberVar + passNamesSize); x++)
			{
				passNames[x] = io.read();
				passAssItems[x] = io.read();
				if(passAssItems[x] == nil)
				{
					passAssItems[x] = "";
				}
			}
			overrideNamesSize = io.read().asInt();
			if(overrideNames[1] != "empty")
			{
				originalOverrideSize =  size(overrideNames);
			}
			else
			{
				originalOverrideSize = 0;
			}
			overrideNamesTemp[1] = io.read();
			
			if(overrideNamesTemp[1] == "empty")
			{
				//overrideSettings[1] = "";
			}
			else
			{
				if(overrideNames[1] == "empty")
				{
					x = 1;
					overrideNames[x] = overrideNamesTemp[1];
					overrideSettings[x] = io.read();
				}
				else
				{
					x = size(overrideNames) + 1;
					overrideNames[x] = overrideNamesTemp[1];
					overrideSettings[x] = io.read();
				}
			}
			if(overrideNamesSize > 1)
			{
				newNumberVar = size(overrideNames) + 1;
				for(x = newNumberVar; x < (newNumberVar + overrideNamesSize); x++)
				{
					overrideNames[x] = io.read();
					if(overrideNamesTemp[1] != "empty")
					{
						overrideSettings[x] = io.read();
					}
				}
			}
			
			newNumberVarOne = (size(passNames) + 1);
			newNumberVarTwo = (originalOverrideSize + 1);
			
			for(x = 1; x <= size(passNames); x++)
			{
				if(newNumberVarTwo > 1)
				{
					for(y = 1; y <= originalOverrideSize; y++)
					{
						passOverrideItems[x][y] = "";
					}
					for(y = newNumberVarTwo; y <= (originalOverrideSize + overrideNamesSize); y++)
					{
						if(overrideNamesTemp[1] != "empty")
						{
							if(x < (size(passNames) - passNamesSize) + 1)
							{
								passOverrideItems[x][y] = "";
								//info("this time i'm assigning nothing");
							}
							else
							{
								passOverrideItems[x][y] = io.read();
								if(passOverrideItems[x][y] == nil)
								{
									passOverrideItems[x][y] = "";
								}
								//info("this time I'm assigning the read value");
							}
						}
						else
						{
							passOverrideItems[x][y] = "";
							//info("i just plain shouldn't be here");
						}
						//info(passOverrideItems[x][y]);
					}
				}
				else
				{
					if(overrideNamesSize == 1)
					{
						if(overrideNamesTemp[1] != "empty")
						{
							if(x < (size(passNames) - passNamesSize) + 1)
							{
								passOverrideItems[x][1] = "";
							}
							else
							{
								
								passOverrideItems[x][1] = io.read();
								if(passOverrideItems[x][1] == nil)
								{
									passOverrideItems[x][1] = "";
								}
							}
							
						}
						else
						{
							passOverrideItems[x][1] = "";
						}
					}
					//info(passOverrideItems[x][1]);
				}
			}
			io.close();
			reProcess();
			req_update();
		}
	}
}
	
moveOverrideToBottom
{
	if(overrideNames[1] != "empty")
	{
		if(areYouSurePrompts == 1)
		{
			doKeys = 0;
			reqbegin("Move Override to Bottom");
			c20 = ctltext("","Are you sure you want to move the selected override to the bottom?");
			if(reqpost())
			{
				sel = getvalue(gad_OverridesListview).asInt();
	    		if(overridesSelected == true && sel != 0)
	    		{	    			
			    	topNumber = size(overrideNames);
			    	if(topNumber == 1 && overrideNames[1] != "empty")
			    	{
			    		// I shouldn't do anything here!  Why would I move it to the bottom??
			    	}
			    	else
			    	{			    		
			    		if(sel == topNumber)
				    	{
				    		// I shouldn't do anything here!  It's already at the bottom!!
				    	}
				    	else
				    	{
				    		// get the stuff for making it the top one
				    		movedOverrideName = overrideNames[sel];
				    		movedOverrideSettings = overrideSettings[sel];
				    		for(passInt = 1; passInt <= size(passNames); passInt++)
				    		{
								movedPassOverrideItems[passInt] = passOverrideItems[passInt][sel];
				    		}
				    		
				    		for(x = 1; x < size(overrideNames); x++)
						    {	
						    	if(x < sel)
					    		{
					    			overrideNames[x] = overrideNames[x];
					    			//passOverrideItems[passInt][x] = passOverrideItems[passInt][x];
					    			overrideSettings[x] = overrideSettings[x];
					    		}
					    		else 
					    		{
						    		if(x >= sel)
						    		{
						    			xPlusOne = x + 1;
						    			if(xPlusOne <= topNumber)
						    			{
						    				overrideNames[x] = overrideNames[xPlusOne];
						    				//passOverrideItems[passInt][x] = passOverrideItems[passInt][xPlusOne];
						    				overrideSettings[x] = overrideSettings[xPlusOne];
						    			}
						    		}
					    		}
						    }
				    		
				    		for(passInt = 1; passInt <= size(passNames); passInt++)
				    		{
						    	for(x = 1; x < size(overrideNames); x++)
						    	{						    		
						    		if(x < sel)
						    		{
						    			//overrideNames[x] = overrideNames[x];
						    			passOverrideItems[passInt][x] = passOverrideItems[passInt][x];
						    			//overrideSettings[x] = overrideSettings[x];
						    		}
						    		else 
						    		{
							    		if(x >= sel)
							    		{
							    			xPlusOne = x + 1;
							    			if(xPlusOne <= topNumber)
							    			{
							    				//overrideNames[x] = overrideNames[xPlusOne];
							    				passOverrideItems[passInt][x] = passOverrideItems[passInt][xPlusOne];
							    				//overrideSettings[x] = overrideSettings[xPlusOne];
							    			}
							    		}
						    		}
						    	}
				    		}

						    for(passInt = 1; passInt <= size(passNames); passInt++)
				    		{
						    	passOverrideItems[passInt][topNumber] = movedPassOverrideItems[passInt];
				    		}
				    		overrideNames[topNumber] = movedOverrideName;
				    		overrideSettings[topNumber] = movedOverrideSettings;
				    	}
			    	}
			    }
			    reProcess();
			    doRefresh = 1;
			}
			else
			{
				warn("Override move cancelled.");
				doRefresh = 0;
			}
			reqend();
			if(doRefresh == 1)
			{
				reProcess();
				req_update();
			}
			doKeys = 1;
		}
		else
		{
			sel = getvalue(gad_OverridesListview).asInt();
    		if(overridesSelected == true && sel != 0)
    		{	    			
		    	topNumber = size(overrideNames);
		    	if(topNumber == 1 && overrideNames[1] != "empty")
		    	{
		    		// I shouldn't do anything here!  Why would I move it to the bottom??
		    	}
		    	else
		    	{			    		
		    		if(sel == topNumber)
			    	{
			    		// I shouldn't do anything here!  It's already at the bottom!!
			    	}
			    	else
			    	{
			    		// get the stuff for making it the top one
			    		movedOverrideName = overrideNames[sel];
			    		movedOverrideSettings = overrideSettings[sel];
			    		for(passInt = 1; passInt <= size(passNames); passInt++)
			    		{
							movedPassOverrideItems[passInt] = passOverrideItems[passInt][sel];
			    		}
			    		
			    		for(x = 1; x < size(overrideNames); x++)
					    {	
					    	if(x < sel)
				    		{
				    			overrideNames[x] = overrideNames[x];
				    			//passOverrideItems[passInt][x] = passOverrideItems[passInt][x];
				    			overrideSettings[x] = overrideSettings[x];
				    		}
				    		else 
				    		{
					    		if(x >= sel)
					    		{
					    			xPlusOne = x + 1;
					    			if(xPlusOne <= topNumber)
					    			{
					    				overrideNames[x] = overrideNames[xPlusOne];
					    				//passOverrideItems[passInt][x] = passOverrideItems[passInt][xPlusOne];
					    				overrideSettings[x] = overrideSettings[xPlusOne];
					    			}
					    		}
				    		}
					    }
			    		
			    		for(passInt = 1; passInt <= size(passNames); passInt++)
			    		{
					    	for(x = 1; x < size(overrideNames); x++)
					    	{						    		
					    		if(x < sel)
					    		{
					    			//overrideNames[x] = overrideNames[x];
					    			passOverrideItems[passInt][x] = passOverrideItems[passInt][x];
					    			//overrideSettings[x] = overrideSettings[x];
					    		}
					    		else 
					    		{
						    		if(x >= sel)
						    		{
						    			xPlusOne = x + 1;
						    			if(xPlusOne <= topNumber)
						    			{
						    				//overrideNames[x] = overrideNames[xPlusOne];
						    				passOverrideItems[passInt][x] = passOverrideItems[passInt][xPlusOne];
						    				//overrideSettings[x] = overrideSettings[xPlusOne];
						    			}
						    		}
					    		}
					    	}
			    		}
				    	
					    for(passInt = 1; passInt <= size(passNames); passInt++)
			    		{
					    	passOverrideItems[passInt][topNumber] = movedPassOverrideItems[passInt];
			    		}
			    		overrideNames[topNumber] = movedOverrideName;
			    		overrideSettings[topNumber] = movedOverrideSettings;
			    	}
		    	}
		    }
		    reProcess();
		    req_update();
		}
	}
}

fixPathForWin32: path
{
	if(strleft(path,1) == "\"")
	{
		doQuotes = 1;
	}
	else
	{
		doQuotes = 0;
	}
	
	if(doQuotes == 1)
	{
		pathSize = size(path);
		path = strleft(path,pathSize - 1);
		pathSize = size(path);
		path = strright(path,pathSize - 1);
	}
	
	pathFixSplit = split(path);
	if(pathFixSplit[1] != nil && pathFixSplit[1] != "")
	{
		pathFixParse = parse(getsep(),path);
		newPathFixed = pathFixParse[1];
		for(f = 2; f <= size(pathFixParse); f++)
		{
			newPathFixed = newPathFixed + "\\\\" + pathFixParse[f];
		}
	}
	else
	{
		pathFixParse = parse(getsep(),path);
		newPathFixed = "\/\/" + pathFixParse[1];
		for(f = 2; f <= size(pathFixParse); f++)
		{
			newPathFixed = newPathFixed + "\/\/" + pathFixParse[f];
		}
	}
	
	if(doQuotes == 1)
	{
		newPathFixed = "\"" + newPathFixed + "\"";
	}
	return(newPathFixed);
}

getCommand: event,data
{
	if(event != nil)
	{
		switch(event)
		{
			case 1:
				comRingCommand = comringdecode(@"s:200#2"@,data);
				if(comRingCommand[1] == "doCreatePass")
				{
					newNumber = size(passNames) + 1;
					comRingCommand[2] = makeStringGood(comRingCommand[2]);
					passNames[newNumber] = comRingCommand[2];
				    passAssItems[newNumber] = "";
				    passOverrideItems[newNumber][size(overrideNames)] = "";
				    for(y = 1; y <= size(overrideNames); y++)
				    {
				    	passOverrideItems[newNumber][y] = "";
				    }
					
				}
				if(comRingCommand[1] == "doEditPass")
				{
					comRingCommand[2] = makeStringGood(comRingCommand[2]);
					sel = getvalue(gad_PassesListview).asInt();
					if(passSelected == true && sel != 0)
					{
						passNames[sel] = comRingCommand[2];
					}
				}
				if(comRingCommand[1] == "doDuplicatePass")
				{
					duplicateSelectedPass();
				}
				if(comRingCommand[1] == "doDeletePass")
				{
					sel = getvalue(gad_PassesListview).asInt();
					if( sel != currentChosenPass )
					{
						if(passSelected == true && sel != 0)
					    {
					    	topNumber = size(passNames);
					    	if(sel == topNumber)
					    	{
					    		passNames[sel] = nil;
					    		passAssItems[sel] = "";
					    		for(x = 1; x <= size(overrideNames); x++)
					    		{
					    			passOverrideItems[sel][x] = "";
					    		}
					    	}
					    	else
					    	{
						    	for(x = 1; x <= size(passNames); x++)
						    	{
						    		if(x < sel)
						    		{
						    			passNames[x] = passNames[x];
						    			passAssItems[x] = passAssItems[x];
							    		for(y = 1; y <= size(overrideNames); y++)
							    		{
							    			passOverrideItems[x][y] = passOverrideItems[x][y];
							    		}
						    		}
						    		else if(x >= sel)
						    		{
						    			xPlusOne = x + 1;
						    			if(xPlusOne <= topNumber)
						    			{
						    				passNames[x] = passNames[xPlusOne];
						    				passAssItems[x] = passAssItems[xPlusOne];
								    		for(y = 1; y <= size(overrideNames); y++)
								    		{
								    			passOverrideItems[x][y] = passOverrideItems[xPlusOne][y];
								    		}
						    			}
						    		}
						    	}
						    	passNames[topNumber] = nil;
						    	passAssItems[topNumber] = "";
							    for(y = 1; y <= size(overrideNames); y++)
					    		{
					    			passOverrideItems[topNumber][y] = "";
					    		}
	
					    	}
					    }
					}
					else
					{
						error("Can't delete current pass!  Changes passes, then delete.");
					}
				}
				break;
				
			case 2:
				comRingCommand = comringdecode(@"s:200#3"@,data);
				if(comRingCommand[1] == "doAddItem")
				{
					for(x = 1; x <= size(passNames); x++)
					{
						if(comRingCommand[2] == passNames[x])
						{
							sel = x;
						}
					}
					if(sel != nil)
					{
						if(comRingCommand[3] != nil && comRingCommand[3] != "")
						{
							passAssItems[sel] = passAssItems[sel] + "||" + comRingCommand[3];
						}
					}
				}
				if(comRingCommand[1] == "doClearItem")
				{
					for(x = 1; x <= size(passNames); x++)
					{
						if(comRingCommand[2] == passNames[x])
						{
							sel = x;
						}
					}
					if(sel != nil)
					{
						if(comRingCommand[3] != nil && comRingCommand[3] != "")
						{
							tempParse = parse("||",passAssItems[sel]);
							passAssItems[sel] = "";
							for(y = 1; y <= size(tempParse); y++)
							{
								if(tempParse[y] != comRingCommand[3])
								{
									passAssItems[sel] = passAssItems[sel] + "||" + tempParse[y];
								}
							}
						}
					}
				}
				break;
				
			case 3:
				comRingCommand = comringdecode(@"s:200#4"@,data);
				if(comRingCommand[1] == "doAddItem")
				{
					for(x = 1; x <= size(passNames); x++)
					{
						if(comRingCommand[2] == passNames[x])
						{
							sel = x;
						}
					}
					if(sel != nil)
					{
						for(x = 1; x <= size(overrideNames); x++)
						{
							overrideNameCompare = parse("||",overrideSettings[x]);
							if(comRingCommand[3] == overrideNameCompare[1])
							{
								o_sel = x;
							}
						}
						if(o_sel != nil)
						{
							if(comRingCommand[4] != nil && comRingCommand[4] != "")
							{
								passOverrideItems[sel][o_sel] = passOverrideItems[sel][o_sel] + "||" + comRingCommand[4];
							}
						}
					}
				}
				if(comRingCommand[1] == "doDuplicateOverride")
				{
					for(x = 1; x <= size(overrideNames); x++)
					{
						overrideNameCompare = parse("||",overrideSettings[x]);
						if(comRingCommand[2] == overrideNameCompare[1])
						{
							sel = x;
						}
					}
					if(sel != nil)
					{
						setvalue(gad_OverridesListview,sel);
						duplicateSelectedOverride();
					}
				}
				if(comRingCommand[1] == "doClearItem")
				{
					for(x = 1; x <= size(passNames); x++)
					{
						if(comRingCommand[2] == passNames[x])
						{
							sel = x;
						}
					}
					if(sel != nil)
					{
						for(x = 1; x <= size(overrideNames); x++)
						{
							overrideNameCompare = parse("||",overrideSettings[x]);
							if(comRingCommand[3] == overrideNameCompare[1])
							{
								o_sel = x;
							}
						}
						if(o_sel != nil)
						{
							if(comRingCommand[4] != nil && comRingCommand[4] != "")
							{
								tempParse = parse("||",passOverrideItems[sel][o_sel]);
								passOverrideItems[sel][o_sel] = "";
								for(y = 1; y <= size(tempParse); y++)
								{
									if(tempParse[y] != comRingCommand[4])
									{
										passOverrideItems[sel][o_sel] = passOverrideItems[sel][o_sel] + "||" + tempParse[y];
									}
								}
							}
						}
					}
				}
				break;
				
			case 4:
				comRingCommand = comringdecode(@"s:200"@,data);
				if(comRingCommand == "updateListsNow")
				{
					reProcess();
					req_update();
				}
				if(comRingCommand == "renderPassFrame")
				{
					if(passAssItems[currentChosenPass] != "")
					{
						renderPassFrame();
					}
					else
					{
						error("There are no items in this pass.  Can't render frame.");
					}
				}
				if(comRingCommand == "renderPassScene")
				{
					if(passAssItems[currentChosenPass] != "")
					{
						renderPassScene();
					}
					else
					{
						error("There are no items in this pass.  Can't render frame.");
					}
						
				}
				if(comRingCommand == "renderAllPasses")
				{
					if(passAssItems[currentChosenPass] != "")
					{
						renderAllScene();
					}
					else
					{
						error("There are no items in this pass.  Can't render frame.");
					}
				}
				break;
				
			case 5:
				comRingCommand = comringdecode(@"s:200#3"@,data);
				if(comRingCommand[1] == "savePassAsScene")
				{
					if(comRingCommand[2] != nil && comRingCommand[2] != "")
					{
						savePassScene = generatePassFile("seq", currentChosenPass);
						filecopy(savePassScene,comRingCommand[2]);
						filedelete(savePassScene);
					}
					
				}
				if(comRingCommand[1] == "saveCurrentSettings")
				{
					if(comRingCommand[2] != nil && comRingCommand[2] != "")
					{
						io = File(comRingCommand[2],"w");
		
						passNamesSize = size(passNames);
						io.writeln(passNamesSize);
						for(x = 1; x <= passNamesSize; x++)
						{
							io.writeln(passNames[x]);
							io.writeln(passAssItems[x]);
						}
						
						 for(x = 1; x <= size(overrideNames); x++)
					    {
							if(strleft(overrideNames[x],1) == " ")
				    		{
				    			tempSize = size(overrideNames[x]) - 16;
				    			overrideNames[x] = strright(overrideNames[x],tempSize);
				    		}
					    }
				
						overrideNamesSize = size(overrideNames);
						io.writeln(overrideNamesSize);
						io.writeln(overrideNames[1]);
						
						if(overrideNames[1] != "empty")
						{
							io.writeln(overrideSettings[1]);
						}
						if(overrideNamesSize > 1)
						{
							for(x = 2; x <= overrideNamesSize; x++)
							{
								io.writeln(overrideNames[x]);
								if(overrideNames[1] != "empty")
								{
									io.writeln(overrideSettings[x]);
								}
							}
						}
						for(x = 1; x <= passNamesSize; x++)
						{
							for(y = 1; y <= overrideNamesSize; y++)
							{
								if(overrideNames[1] != "empty")
								{
									io.writeln(passOverrideItems[x][y]);
								}
							}
						}
						io.writeln(userOutputFolder);
						io.writeln(fileOutputPrefix);
						io.writeln(userOutputString);
						io.writeln(areYouSurePrompts);
						io.writeln(rgbSaveType);
						io.writeln(editorResolution);
						io.close();
					}
				}
				if(comRingCommand[1] == "loadSettings")
				{
					if(comRingCommand[2] != nil && comRingCommand[2] != "")
					{
						if(comRingCommand[3] != nil && comRingCommand[3] != "")
						{
							if(comRingCommand[3] == "1")
							{
								io = File(comRingCommand[2],"r");
			
								passNamesSize = io.read().asInt();
								for(x = 1; x <= passNamesSize; x++)
								{
									passNames[x] = io.read();
									passAssItems[x] = io.read();
									if(passAssItems[x] == nil)
									{
										passAssItems[x] = "";
									}
								}
								overrideNamesSize = io.read().asInt();
								overrideNames[1] = io.read();
								if(overrideNames[1] == "empty")
								{
									overrideSettings[1] = "";
								}
								else
								{
									overrideSettings[1] = io.read();
								}
								if(overrideNamesSize > 1)
								{
									for(x = 2; x <= overrideNamesSize; x++)
									{
										overrideNames[x] = io.read();
										if(overrideNames[1] != "empty")
										{
											overrideSettings[x] = io.read();
										}
									}
								}
								for(x = 1; x <= passNamesSize; x++)
								{
									for(y = 1; y <= overrideNamesSize; y++)
									{
										if(overrideNames[1] != "empty")
										{
											passOverrideItems[x][y] = io.read();
											if(passOverrideItems[x][y] == nil)
											{
												passOverrideItems[x][y] = "";
											}
										}
										else
										{
											passOverrideItems[x][y] = "";
										}
									}
								}
								userOutputFolder = io.read();
								if(userOutputFolder == nil)
								{
									userOutputFolder = "";
								}
								fileOutputPrefix = io.read();
								if(fileOutputPrefix == nil)
								{
									fileOutputPrefix = "";
								}
								userOutputString = io.read();
								if(userOutputString == nil)
								{
									userOutputString = "";
								}
								areYouSurePrompts = io.read().asInt();
								rgbSaveType = io.read().asInt();
								editorResolution = io.read().asInt();
								io.close();
							}
							else
							{
								if(comRingCommand[3] == "0")
								{
									io = File(comRingCommand[2],"r");
								
									passNamesSize = io.read().asInt();
									
									newNumberVar = (size(passNames) + 1);
									
									for(x = newNumberVar; x < (newNumberVar + passNamesSize); x++)
									{
										passNames[x] = io.read();
										passAssItems[x] = io.read();
										if(passAssItems[x] == nil)
										{
											passAssItems[x] = "";
										}
									}
									overrideNamesSize = io.read().asInt();
									if(overrideNames[1] != "empty")
									{
										originalOverrideSize =  size(overrideNames);
									}
									else
									{
										originalOverrideSize = 0;
									}
									overrideNamesTemp[1] = io.read();
									
									if(overrideNamesTemp[1] == "empty")
									{
										//overrideSettings[1] = "";
									}
									else
									{
										if(overrideNames[1] == "empty")
										{
											x = 1;
											overrideNames[x] = overrideNamesTemp[1];
											overrideSettings[x] = io.read();
										}
										else
										{
											x = size(overrideNames) + 1;
											overrideNames[x] = overrideNamesTemp[1];
											overrideSettings[x] = io.read();
										}
									}
									if(overrideNamesSize > 1)
									{
										newNumberVar = size(overrideNames) + 1;
										for(x = newNumberVar; x < (newNumberVar + overrideNamesSize); x++)
										{
											overrideNames[x] = io.read();
											if(overrideNamesTemp[1] != "empty")
											{
												overrideSettings[x] = io.read();
											}
										}
									}
									
									newNumberVarOne = (size(passNames) + 1);
									newNumberVarTwo = (originalOverrideSize + 1);
									
									for(x = 1; x <= size(passNames); x++)
									{
										if(newNumberVarTwo > 1)
										{
											for(y = 1; y <= originalOverrideSize; y++)
											{
												passOverrideItems[x][y] = "";
											}
											for(y = newNumberVarTwo; y <= (originalOverrideSize + overrideNamesSize); y++)
											{
												if(overrideNamesTemp[1] != "empty")
												{
													if(x < (size(passNames) - passNamesSize) + 1)
													{
														passOverrideItems[x][y] = "";
														//info("this time i'm assigning nothing");
													}
													else
													{
														passOverrideItems[x][y] = io.read();
														if(passOverrideItems[x][y] == nil)
														{
															passOverrideItems[x][y] = "";
														}
														//info("this time I'm assigning the read value");
													}
												}
												else
												{
													passOverrideItems[x][y] = "";
													//info("i just plain shouldn't be here");
												}
												//info(passOverrideItems[x][y]);
											}
										}
										else
										{
											if(overrideNamesSize == 1)
											{
												if(overrideNamesTemp[1] != "empty")
												{
													if(x < (size(passNames) - passNamesSize) + 1)
													{
														passOverrideItems[x][1] = "";
													}
													else
													{
														
														passOverrideItems[x][1] = io.read();
														if(passOverrideItems[x][1] == nil)
														{
															passOverrideItems[x][1] = "";
														}
													}
													
												}
												else
												{
													passOverrideItems[x][1] = "";
												}
											}
											//info(passOverrideItems[x][1]);
										}
									}
									io.close();
						
								}
							}
							
						}
					}
					
				}

				break;
				
			case 6:
				comRingCommand = comringdecode(@"s:200#2"@,data);
				if(comRingCommand[1] == "doSelect")
				{
					for(x = 1; x <= size(passNames); x++)
					{
						if(comRingCommand[2] == passNames[x])
						{
							sel = x;
						}
					}
					if(sel != nil)
					{
						passes_sel = sel;
						setitems = parseListItems(passAssItems[passes_sel]);
						setvalue(gad_PassesListview,passes_sel);
						setvalue(gad_SceneItems_forPasses_Listview,setitems);
						setvalue(gad_OverridesListview,nil);
						req_update();
						passSelected = true;
					}
				}
				if(comRingCommand[1] == "doChange")
				{
					for(x = 1; x <= size(passNames); x++)
					{
						if(comRingCommand[2] == passNames[x])
						{
							changeTo = x;
						}
					}
					if(changeTo != nil)
					{
						currentChosenPass = changeTo;
						currentChosenPassString = passNames[currentChosenPass];
						setvalue(gad_OverridesListview,nil);
						setvalue(gad_SceneItems_forOverrides_Listview,nil);
						setvalue(gad_SelectedPass,currentChosenPass);
						setvalue(c7,currentChosenPassString,"");
						reProcess();
						req_update();
					}
				}
				break;
			
			default:
				break;
		}
	}
}
