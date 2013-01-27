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
					case MESH:
						tempMeshAgents[x] = Mesh(itemname);
						tempMeshNames[x] = tempMeshAgents[x].name;
						tempMeshIDs[x] = tempMeshAgents[x].id;
						passAssItems[newNumber] = passAssItems[newNumber] + "||" + tempMeshIDs[x];
						break;
					
					case LIGHT:
						tempLightAgents[x] = Light(itemname);
						tempLightNames[x] = tempLightAgents[x].name;
						tempLightIDs[x] = tempLightAgents[x].id;
						passAssItems[newNumber] = passAssItems[newNumber] + "||" + tempLightIDs[x];
						break;

					case CAMERA:
						tempCameraAgents[x] = Camera(itemname);
						tempCameraNames[x] = tempCameraAgents[x].name;
						tempCameraIDs[x] = tempCameraAgents[x].id;
						passAssItems[newNumber] = passAssItems[newNumber] + "||" + tempLightIDs[x];
						break;
						
					default:
						break;
				}
			}
								
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
		    	
		    	case 8:
		    		overrideNames[newNumber] = newName + "   (camera)";
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
					renderer = settingsArray[3];
					scnmasterOverride_UI(renderer, "edit");
					reProcess();
					req_update();
					break;

				case 8:
					cameraOverride_UI("edit");
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

createCameraOverride
{
	cameraOverride_UI("new");
	reProcess();
	req_update();
}


createSceneMasterOverride
{
	if(renderers.count() >= 2)
	{
		reqbeginstr = "Choose Renderer";
		reqbegin(reqbeginstr);
		smoWidth = 300;
		smoHeight = 60;
		reqsize(smoWidth, smoHeight);
		renderermenu = ctlpopup("Renderer",1,renderers);
		ctlposition(renderermenu, 25, 5, (smoWidth - (2 * 25)), ScnMst_gad_h, ScnMst_gad_text_offset);
				
		if(reqpost())
		{
			scnmasterOverride_UI(int(getvalue(renderermenu)), "new");
		} else {
			// User cancelled out, so we do nothing.
		}
		reqend();
	} else {
		scnmasterOverride_UI(1, "new"); // native
	}
	reProcess();
	req_update();
}

aboutPassPortDialog
{
	this_script = split(SCRIPTID);
	this_script_path = this_script[2];
	if(this_script[1])
		this_script_path = this_script[1] + this_script[2] + getsep();

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
		str = string("Platform: " + platformInformation());
		drawtext(str, <0,0,0>, 10, txt_y + drawtextheight(str) );
	}
}

platformInformation
{
	switch(platform()) {
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

	ui_offset_y += 5;

	if(platform() == MACUB || platform() == MAC64)
	{
		usegrowl = ctlcheckbox("Use Growl",useGrowl);
		ctlposition(usegrowl, Pref_gad_x, ui_offset_y, Pref_gad_w, Pref_gad_h, Pref_gad_text_offset);
	
		ui_offset_y += Pref_ui_row_offset + 5;
		s201 = ctlsep();
		ctlposition(s201, -2, ui_offset_y);
		ui_offset_y += 6;

	} else {
		ui_offset_y += Pref_ui_row_offset;
		ui_offset_y += Pref_ui_row_offset;
	}

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
		if(platform() == MACUB || platform() == MAC64)
			useGrowl = getvalue(usegrowl);
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
			    	if(!chdir(lwsFileSplit[1] + lwsFileSplit[2]))
			    		error("Invalid save location: " + lwsFileSplit[1] + lwsFileSplit[2]);
			    	newLwsFile = lwsFileSplit[1] + lwsFileSplit[2] + getsep() + passNames[x] + ".lws";
			    }
			    else
			    {
			    	if(!chdir(lwsFileSplit[2]))
			    		error("Invalid save location: " + lwsFileSplit[2]);
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

	// mac UB frame rendering
 	if(platform() == MACUB || platform() == MAC64)
	{
		UB_bg_frameRender(frameRenderScene,saveRGBImagesPrefix);
	} else {
		win_bg_frameRender(frameRenderScene,saveRGBImagesPrefix);
	}
}

renderPassScene
{
	seqRenderScene = generatePassFile("seq", currentChosenPass);
		
	// mac UB scene rendering
 	if(platform() == MACUB || platform() == MAC64)
	{
		UB_bg_sceneRender(seqRenderScene,saveRGBImagesPrefix);
	} else {
		win_bg_sceneRender(seqRenderScene,saveRGBImagesPrefix);
	}
}

renderAllScene
{
	for(x = 1; x <= size(passNames); x++)
	{
		seqRenderScene[x] = generatePassFile("seq", x);
	}
		
	// mac UB all scene rendering
 	if(platform() == MACUB || platform() == MAC64)
	{
		UB_bg_allSceneRender(seqRenderScene,saveRGBImagesPrefix);
	} else {
		win_bg_allSceneRender(seqRenderScene,saveRGBImagesPrefix);
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
		io.writeln(useGrowl); // write this out no matter what, to keep parity across platforms.
		io.writeln(areYouSurePrompts);
		io.writeln(rgbSaveType);
		io.writeln(editorResolution);
		io.close();
		
		globalstore("passEditoruserOutputString",userOutputString);
		if(platform() == MACUB || platform() == MAC64)
			globalstore("passEditorUseGrowl", useGrowl);
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
			useGrowl = io.read().asInt();
			areYouSurePrompts = io.read().asInt();
			rgbSaveType = io.read().asInt();
			editorResolution = io.read().asInt();
			io.close();
			
			panelWidth = integer(globalrecall("passEditorpanelWidth", 640));
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
