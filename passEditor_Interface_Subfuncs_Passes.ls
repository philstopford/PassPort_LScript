editSelectedPass // required due to callback function limitations.
{
	passHandler("edit","");
}

createNewFullPass
{
	passHandler("new","full");
}

createNewEmptyPass
{
	passHandler("new","empty");
}

createNewPassFromSelection
{
	passHandler("new","fromsel");
}

passHandler: action, mode
{
	doKeys = 0;

	if(!action)
		error("passHandler called without arguments");

	if(action == "new")
	{
		if(!mode)
			error("passHandler arg2 missing");
		if(mode == "full")
		{
			dialogTitle = "New Full Pass";
			dialogString = "Full_Pass";
		}
		if(mode == "empty")
		{
			dialogTitle = "New Empty Pass";
			dialogString = "Empty_Pass";
		}
		if(mode == "fromsel")
		{
			s = masterScene.getSelect();
			dialogTitle = "New Selection Pass";
			dialogString = "Selection_Pass";
		}
		if(!dialogTitle)
			error("passHandler arg2 invalid");
		newNumber = size(passNames) + 1;
	}
	if(action == "edit") // mode is disregarded.
	{
	    sel = getvalue(gad_PassesListview).asInt();
	    if(passSelected == true && sel != 0)
	    {
@if enablePBS == 1
	        bufferSettings = parse("||", passBufferExporters[sel]);
@end
	        dialogTitle = "Edit Pass";
	        dialogString = passNames[sel];
	        newNumber = sel;
	    } else {
	    	return; // skips error below.
	    }
	}

	if(!dialogTitle)
		error("passHandler arg1 invalid");


	reqbegin(dialogTitle);
	c20 = ctlstring("Pass Name:",dialogString);

@if enablePBS == 1
	reqsize(Passes_ui_window_w, 325);
	ctlposition(c20, Passes_gad_x, Passes_gad_y, Passes_gad_w, Passes_gad_h, Passes_gad_text_offset);

	ui_offset_y = Passes_ui_offset_y + Passes_ui_row_offset;

	lbl = ctltext("","These options will only affect existing filters in the scene:");
	ctlposition(lbl, Passes_gad_x, Passes_gad_y + ui_offset_y, Passes_gad_w, Passes_gad_h, Passes_gad_text_offset);

	ui_offset_y += Passes_ui_row_offset + 6;

	changeImageFilterState = defaultBufferExporters[1];
	if(mode == "edit")
	{
        changeImageFilterState = integer(bufferSettings[1]);
	}
	c21 = ctlcheckbox("Change image filter states for this pass",changeImageFilterState);
	ctlposition(c21, Passes_gad_x - 22, Passes_gad_y + ui_offset_y, Passes_gad_w, Passes_gad_h, Passes_gad_text_offset);

	ui_offset_y += Passes_ui_row_offset;

	compBufferToggle = defaultBufferExporters[2];
	if(mode == "edit")
	{
        compBufferToggle = integer(bufferSettings[2]);
	}
	c22 = ctlcheckbox("Compositing Buffer",compBufferToggle);
	ctlposition(c22, Passes_gad_x, Passes_gad_y + ui_offset_y, Passes_gad_w, Passes_gad_h, Passes_gad_text_offset);

	ui_offset_y += Passes_ui_row_offset;

	exrTraderToggle = defaultBufferExporters[3];
	if(mode == "edit")
	{
        exrTraderToggle = integer(bufferSettings[3]);
	}	
	c23 = ctlcheckbox("exrTrader",exrTraderToggle);
	ctlposition(c23, Passes_gad_x, Passes_gad_y + ui_offset_y, Passes_gad_w, Passes_gad_h, Passes_gad_text_offset);

	ui_offset_y += Passes_ui_row_offset;

	specBuffToggle = defaultBufferExporters[4];
	if(mode == "edit")
	{
        specBuffToggle = integer(bufferSettings[4]);
	}
	c24 = ctlcheckbox("Special Buffers",specBuffToggle);
	ctlposition(c24, Passes_gad_x, Passes_gad_y + ui_offset_y, Passes_gad_w, Passes_gad_h, Passes_gad_text_offset);

	ui_offset_y += Passes_ui_row_offset;

	psdToggle = defaultBufferExporters[5];
	if(mode == "edit")
	{
        psdToggle = integer(bufferSettings[5]);
	}
	c25 = ctlcheckbox("PSD Export",psdToggle);
	ctlposition(c25, Passes_gad_x, Passes_gad_y + ui_offset_y, Passes_gad_w, Passes_gad_h, Passes_gad_text_offset);

	ui_offset_y += Passes_ui_row_offset;

	rlaToggle = defaultBufferExporters[6];
	if(mode == "edit")
	{
        rlaToggle = integer(bufferSettings[6]);
	}
	c26 = ctlcheckbox("Extended RLA Export",rlaToggle);
	ctlposition(c26, Passes_gad_x, Passes_gad_y + ui_offset_y, Passes_gad_w, Passes_gad_h, Passes_gad_text_offset);

	ui_offset_y += Passes_ui_row_offset;

	rpfToggle = defaultBufferExporters[7];
	if(mode == "edit")
	{
        rlaToggle = integer(bufferSettings[7]);
	}
	c27 = ctlcheckbox("Extended RPF Export",rpfToggle);
	ctlposition(c27, Passes_gad_x, Passes_gad_y + ui_offset_y, Passes_gad_w, Passes_gad_h, Passes_gad_text_offset);

	ui_offset_y += Passes_ui_row_offset;

	auraToggle = defaultBufferExporters[8];
	if(mode == "edit")
	{
        auraToggle = integer(bufferSettings[8]);
	}
	c28 = ctlcheckbox("Aura 2.5",auraToggle);
	ctlposition(c28, Passes_gad_x, Passes_gad_y + ui_offset_y, Passes_gad_w, Passes_gad_h, Passes_gad_text_offset);

	ui_offset_y += Passes_ui_row_offset;

	iDOFToggle = defaultBufferExporters[9];
	if(mode == "edit")
	{
        iDOFToggle = integer(bufferSettings[9]);
	}
	c29 = ctlcheckbox("iDOF",iDOFToggle);
	ctlposition(c29, Passes_gad_x, Passes_gad_y + ui_offset_y, Passes_gad_w, Passes_gad_h, Passes_gad_text_offset);
@end // PBS

    if(reqpost())
    {
        newName = getvalue(c20);
        newName = makeStringGood(newName);

@if enablePBS == 1
        changeImageFilterState  = string(getvalue(c21));
        compBufferToggle        = string(getvalue(c22));
        exrTraderToggle         = string(getvalue(c23));
        specBuffToggle          = string(getvalue(c24));
        psdToggle               = string(getvalue(c25));
        rlaToggle               = string(getvalue(c26));
        rpfToggle               = string(getvalue(c27));
        auraToggle              = string(getvalue(c28));
        iDOFToggle              = string(getvalue(c29));
@end // PBS

@if enablePBS == 1
        passBufferExporters[newNumber] = changeImageFilterState + "||" + compBufferToggle + "||" + exrTraderToggle + "||" + specBuffToggle + "||" + psdToggle
                                                                + "||" + rlaToggle + "||" + rpfToggle + "||" + auraToggle + "||" + iDOFToggle;
@end // PBS

		if(action == "edit")
		{
			passNames[newNumber] = newName;		
		}
		if(action == "new")
		{
			passNames[newNumber] = newName;
		    passOverrideItems[newNumber][size(overrideNames)] = "";
		    passAssItems[newNumber] = "";
		    for(y = 1; y <= size(overrideNames); y++)
		    {
		    	passOverrideItems[newNumber][y] = "";
		    }
			if(mode == "full")
			{
				items_size = sizeof(displayNames);
				for(x = 1;x <= items_size;x++)
				{
					items_array[x] = x;
					passAssItems[newNumber] = passAssItems[newNumber] + "||" + displayIDs[x];
				}
			}
			if(mode == "fromsel")
			{
		    	if(s != nil)
		    	{
					arraySize = sizeof(s);
					for(x = 1; x <= arraySize; x++)
					{
						itemname = s[x].name;
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
								passAssItems[newNumber] = passAssItems[newNumber] + "||" + tempCameraIDs[x];
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
			}
			if(mode == "full" || mode == "fromsel")
			{
				setitems = parseListItems(passAssItems[newNumber]);
				setvalue(gad_SceneItems_forPasses_Listview,setitems);
			}
		}
        req_update();
	}
	reqend();
    req_update();
}

deleteSelectedPass
{
    if(size(passNames) > 1)
    {
        sel = getvalue(gad_PassesListview).asInt();
        if( sel != currentChosenPass )
        {
            if(areYouSurePrompts == 1)
            {
                doKeys = 0;
                reqbegin("Confirm Delete Pass");
                c20 = ctltext("","Are you sure you want to delete selected pass?");
                if(reqpost())
                {
                    sel = getvalue(gad_PassesListview).asInt();
                    if(passSelected == true && sel != 0)
                    {
                        topNumber = size(passNames);
                        if(sel == topNumber)
                        {
                            passNames[sel] = nil;
                            passAssItems[sel] = "";

@if enablePBS == 1
                            passBufferExporters[sel] = nil;
@end // PBS

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

@if enablePBS == 1
                                    passBufferExporters[x] = passBufferExporters[x];
@end // PBS

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

@if enablePBS == 1
                                        passBufferExporters[x] = passBufferExporters[xPlusOne];
@end // PBS

                                        for(y = 1; y <= size(overrideNames); y++)
                                        {
                                            passOverrideItems[x][y] = passOverrideItems[xPlusOne][y];
                                        }
                                    }
                                }
                            }
                            passNames[topNumber] = nil;
                            passAssItems[topNumber] = "";

@if enablePBS == 1
                            passBufferExporters[topNumber] = nil;
@end // PBS

                            for(y = 1; y <= size(overrideNames); y++)
                            {
                                passOverrideItems[topNumber][y] = "";
                            }

                        }
                    }
                    //reProcess();
                    doRefresh = 1;
                }
                else
                {
                    warn("Pass deletion cancelled.");
                    doRefresh = 0;
                }
                reqend();
                if(doRefresh == 1)
                {
                    if(currentChosenPass > 1)
                    {
                        currentChosenPass = currentChosenPass - 1;
                        currentChosenPassString = passNames[currentChosenPass];
                    }
                }
                //reProcess();
                req_update();
                doKeys = 1;
            }
            else
            {
                sel = getvalue(gad_PassesListview).asInt();
                if(passSelected == true && sel != 0)
                {
                    topNumber = size(passNames);
                    if(sel == topNumber)
                    {
                        passNames[sel] = nil;
                        passAssItems[sel] = "";

@if enablePBS == 1
                        passBufferExporters[sel] = nil;
@end // PBS

                        for(x = 1; x <= size(overrideNames); x++)
                        {
                            passOverrideItems[1][x] = "";
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

@if enablePBS == 1
                                passBufferExporters[x] = passBufferExporters[x];
@end // PBS

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

@if enablePBS == 1
                                    passBufferExporters[x] = passBufferExporters[xPlusOne];
@end // PBS

                                    for(y = 1; y <= size(overrideNames); y++)
                                    {
                                        passOverrideItems[x][y] = passOverrideItems[xPlusOne][y];
                                    }
                                }
                            }
                        }
                        passNames[topNumber] = nil;
                        passAssItems[topNumber] = "";

@if enablePBS == 1
                        passBufferExporters[topNumber] = nil;
@end // PBS

                        for(y = 1; y <= size(overrideNames); y++)
                        {
                            passOverrideItems[topNumber][y] = "";
                        }

                    }
                }
                if(currentChosenPass > 1)
                {
                    currentChosenPass = currentChosenPass - 1;
                    currentChosenPassString = passNames[currentChosenPass];
                }
                req_update();
            }
        }
        else
        {
            error("Can't delete current pass!  Change to a different pass, then delete this one.");
        }
    }
    req_update();
}

duplicateSelectedPass
{
	sel = getvalue(gad_PassesListview).asInt();
    if(passSelected == true && sel != 0)
    {
    	newNumber = size(passNames) + 1;
		passNames[newNumber] = passNames[sel] + "_copy";
	    passAssItems[newNumber] = passAssItems[sel];

@if enablePBS == 1
	    passBufferExporters[newNumber] = passBufferExporters[sel];
@end // PBS

	    passOverrideItems[newNumber][size(overrideNames)] = "";
	    for(y = 1; y <= size(overrideNames); y++)
	    {
	    	passOverrideItems[newNumber][y] = passOverrideItems[sel][y];
	    }
    }
}

savePassAsScene
{
	doKeys = 0;
	reqbegin("Save Pass As Scene...");
	c21 = ctlfilename("Save .lws file...", "*.lws",30,0);
	if(reqpost())
	{
		savePassScene = generatePassFile("seq", currentChosenPass);
		lwsFile = getvalue(c21);
		filecopy(savePassScene,lwsFile);
		filedelete(savePassScene);
	}
	reqend();	
	doKeys = 1;
}

saveAllPassesAsScenes
{
	doKeys = 0;
	reqbegin("Save All Passes As Scene...");
	c21 = ctlfilename("Choose a folder...", "DO_NOT_CHANGE.LWS",30,0);
	if(reqpost())
	{
		lwsFile = getvalue(c21);

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
	reqend();
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

saveCurrentPassesSettings
{
	doKeys = 0;
	reqbegin("Save PassPort Settings...");
	c21 = ctlfilename("Save .rpe file...", "*.rpe",30,0);
	if(reqpost())
	{
		rpeFile = getvalue(c21);

		// do the saving here
		if(rpeFile == nil || rpeFile == "*.rpe")
		{
			error("Not a valid save location.");
		}
		io = File(rpeFile,"w");
		io.writeln(string(rpeVersion)); // version tracking of rpe files. Allows us to handle changes in later revisions.
		io.writeln(string(versionString)); // store passport version as well, for safety.
		io.writeln(lwVersion);
		passNamesSize = size(passNames);
		io.writeln(passNamesSize);
		for(x = 1; x <= passNamesSize; x++)
		{
			io.writeln(passNames[x]);
			io.writeln(passAssItems[x]);

@if enablePBS == 1
	    	io.writeln(passBufferExporters[x]);
@end // PBS

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
	else
	reqend();
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

		if(replaceChoice == 1)
		{
			if(rpeFile == nil || rpeFile == "*.rpe")
			{
				error("Not a valid settings file.");
			}
			io = File(rpeFile,"r");
	        versionMismatch = 0;
			passportRPEVersion = io.read();
			if(passportRPEVersion == rpeVersion)
			{
				passportVersion = io.read();
				if(passportVersion != versionString)
				{
		            versionMismatch = 1;
					info("WARNING: This RPE file was written by Passport version " + passPortVersion);
				}
			} else {
				io.close();
				error("Fatal error: This RPE file is for an obsolete version of Passport");
			}
			lwVersion = io.read();
			if(lwVersion != hostVersion().asStr())
			{
				info("WARNING: RPE contains settings for LW version " + lwVersion);
				versionMismatch = 1;
			}
	        if (versionMismatch == 1)
			{
				info("PassPort : One or more warnings were issued. Passport operation may be affected. See documentation for advice.");
			}
			passNamesSize = io.read().asInt();
			for(x = 1; x <= passNamesSize; x++)
			{
				passNames[x] = io.read();
				passAssItems[x] = io.read();
				if(passAssItems[x] == nil)
				{
					passAssItems[x] = "";
				}

@if enablePBS == 1
				passBufferExporters[x] = io.read();
@end // PBS

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

@if enablePBS == 1
				passBufferExporters[x] = io.read();
@end // PBS

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
	reqend();
}
