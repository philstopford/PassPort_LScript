generateNewScenePath: outputFolder, outputStr, fileOuputPrefix, userOutputString, passNames, pass
{
    if(chdir(outputFolder[1]))
    {
        if(chdir("CG"))
        {
            if(chdir("temp"))
            {
                if(chdir("tempScenes"))
                {
                }
                else
                {
                    mkdir("tempScenes");
                    chdir("tempScenes");
                }
            }
            else
            {
                mkdir("temp");
                chdir("temp");
                mkdir("tempScenes");
                chdir("tempScenes");
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
    }
    newScenePath = outputFolder[1] + getsep() + "CG" + getsep() + "temp" + getsep() + "tempScenes" + getsep() + outputStr + fileOutputPrefix + "_" + userOutputString + "_" + passNames[pass] + ".lws";
    return newScenePath;
}

generateSaveRGBPath: mode, outputFolder, outputStr, fileOutputPrefix, userOutputString, passNames, pass
{
	chdirString = outputFolder[1] + getsep() + "CG" + getsep();
    if(mode == "frame")
    {
        chdirString = chdirString + "temp" + getsep();
    }
    
    if(chdir(chdirString))
    {
        chdirString = outputStr + fileOutputPrefix + "_" + userOutputString + "_" + passNames[pass];
        if(chdir(chdirString))
        {
        }
        else
        {
            chdir("CG");
            if (mode == "frame")
                chdir("temp");
            mkdir(outputStr + fileOutputPrefix + "_" + userOutputString + "_" + passNames[pass]);
            chdir(outputStr + fileOutputPrefix + "_" + userOutputString + "_" + passNames[pass]);
        }
    }
    else
    {
        mkdir(outputFolder[1] + getsep() + "CG" + getsep());
        chdir(outputFolder[1] + getsep() + "CG" + getsep());
        if (mode == "frame")
        {
            mkdir("temp");
            chdir("temp");
        }
        mkdir(outputStr + fileOutputPrefix + "_" + userOutputString + "_" + passNames[pass]);
        chdir(outputStr + fileOutputPrefix + "_" + userOutputString + "_" + passNames[pass]);
    }
    saveRGBImagesPrefix = outputFolder[1] + getsep() + "CG" + getsep();
    if (mode == "frame")
    {
        saveRGBImagesPrefix = saveRGBImagesPrefix + "temp" + getsep();
    }
    saveRGBImagesPrefix = saveRGBImagesPrefix + outputStr + fileOutputPrefix + "_" + userOutputString + "_" + passNames[pass] + getsep() + outputStr + fileOutputPrefix + "_" + userOutputString + "_" + passNames[pass];
    return saveRGBImagesPrefix;
}

generatePath: mode, outputFolder, outputStr, fileOutputPrefix, userOutputString, passNames, pass, baseName
{
	if(mode == "filter_2sep")
	{
		tempArray_2sep = parse(getsep(), outputFolder[1]);
		for(i = 1; i <= tempArray_2sep.size(); i++)
		{
			tempOutputFolderString = tempArray_2sep[i] + getsep() + getsep();
		}
		genPath = tempOutputFolderString + getsep()  + getsep() + "CG" + getsep() + getsep();
	} else {
		genPath = outputFolder[1] + getsep() + "CG" + getsep();
	}
	if (mode == "LWO" || mode == "frame" || ((mode == "filter" || mode == "filter_2sep") && outputStr == "testFrame_"))
	{
		genPath = genPath + "temp" + getsep();
		if(mode == "filter_2sep")
		{
			genPath = genPath + getsep();
		}
	}
	if (mode == "LWO")
	{
		genPath = genPath + "tempScenes" + getsep() + "tempObjects" + getsep();
	}
	if (mode == "filter" || mode == "filter_2sep")
	{
		if(mode == "filter")
		{
			genPath = genPath + outputStr + fileOutputPrefix + "_" + userOutputString + "_" + passNames[pass] + getsep() + outputStr + fileOutputPrefix + "_" + userOutputString + "_" + passNames[pass] + "_" + baseName;
		}
		if(mode == "filter_2sep")
		{
			genPath = genPath + outputStr + fileOutputPrefix + "_" + userOutputString + "_" + passNames[pass] + getsep() + getsep() + outputStr + fileOutputPrefix + "_" + userOutputString + "_" + passNames[pass] + "_" + baseName;
		}
	} else {
		genPath = genPath + outputStr + "_" + fileOutputPrefix + "_" + userOutputString + "_" + passNames[pass] + "_" + baseName;
	}
    return genPath;
}

writeOverrideString: inputFileName, outputFileName, outputString, outputValue
{
	if(filesPrepared == 0)
	{
		// We get back a different string - don't be fooled!
		inputFileName = prepareInputFile(inputFileName);
	}
	
	inputFile = File(inputFileName, "r");
	tempOutput = File(outputFileName, "w");

	parameterFound = 0;
	while(!inputFile.eof())
	{
		line = inputFile.read();
		outputString_len = size(outputString);
		if(size(line) > outputString_len)
		{
			if(strleft(line,outputString_len) == outputString)
			{
				parameterFound = 1;
				toWrite = outputString + string(outputValue);

				// Special case handling for outputString == FrameSize or GlobalFrameSize
				// in these cases we need to do some math and also misuse the outputValue to pass in
				// the multipler to process the resolution values.
				if((outputString == "FrameSize ") || (outputString == "GlobalFrameSize "))
				{
				    parsingArray = parse(" ",line);
        	        newResWidth = integer(integer(parsingArray[2]) * outputValue);
    	            newResHeight = integer(integer(parsingArray[3]) * outputValue);
	                toWrite = outputString + string(newResWidth) + " " + string(newResHeight);
				}
			}
			else
			{
				toWrite = line;
			}
		}
		else
		{
			toWrite = line;
		}
		tempOutput.writeln(toWrite);
	}
	
	// Finished with our input file, so close it.
	inputFile.close();
	
	// Didn't find the string, so assume it's one of those settings that LW drops from the scene file
	// and opt to append it to force the condition. Don't do this if the global 'noAppend' flag has been set.
	if (parameterFound == 0 && noAppend == 0)
	{
		tempOutput.reopen("a"); // append mode.
		toWrite  = outputString + string(outputValue);
		tempOutput.writeln(toWrite);
	}

	// reset parameterFound.
	if (parameterFound == 1)
	{
		parameterFound = 0;
	}

	// Finished with our output file, so close it.
	tempOutput.close();
	filecopy(outputFileName, inputFileName);
}

// Duplicate user's input file to a temp file and send back the path to the temp file to process elsewhere..
prepareInputFile: inputFileName
{
	if(filesPrepared == 1)
		error("Internal error - prepareInputFile() already called.");
	tempFileName = tempDirectory + getsep() + "tempPassportInputFile.lws";
	filecopy(inputFileName, tempFileName);
	filesPrepared = 1;
	return tempFileName;
}

finishFiles
{
	if(filesPrepared == 0)
		error("Internal error - finishFiles() already called.");
	tempFileName = tempDirectory + getsep() + "tempPassportInputFile.lws";
	filedelete(tempFileName);
	filesPrepared = 0;
}

changeScnLine: stringToWrite, fileToAdjust, lineToChange
{
	fileAdjust = File(fileToAdjust, "r");
	tempFileToAdjust = tempDirectory + getsep() + "tempPassportInputFileAdjust.lws";
	tempFileAdjust = File(tempFileToAdjust, "w");

	for(i = 1; i < lineToChange; i++)
	{
		tempFileAdjust.writeln(fileAdjust.read());
	}
	tempFileAdjust.writeln(stringToWrite);
	fileAdjust.line(lineToChange + 1);
	tempFileAdjust.reopen("a"); // append mode
	while(!fileAdjust.eof())
	{
		tempFileAdjust.writeln(fileAdjust.read());
	}
	fileAdjust.close();
	tempFileAdjust.close();
	filecopy(tempFileToAdjust, fileToAdjust);
	filedelete(tempFileToAdjust);
}

insertScnLine: stringToInsert, fileToAdjust, lineToInsertAfter
{
	fileAdjust = File(fileToAdjust, "r");
	tempFileToAdjust = tempDirectory + getsep() + "tempPassportInputFileAdjust.lws";
	tempFileAdjust = File(tempFileToAdjust, "w");

	for(i = 1; i <= lineToInsertAfter; i++)
	{
		tempFileAdjust.writeln(fileAdjust.read());
	}
	tempFileAdjust.writeln(stringToInsert);
	tempFileAdjust.reopen("a"); // append mode
	while(!fileAdjust.eof())
	{
		tempFileAdjust.writeln(fileAdjust.read());
	}
	fileAdjust.close();
	tempFileAdjust.close();
	filecopy(tempFileToAdjust, fileToAdjust);
	filedelete(tempFileToAdjust);
}

generateSurfaceObjects: srfLWOInputID,srfInputTemp,currentScenePath,objStartLine, passNames, pass
{
	// File test, just in case.
	fileCheck(srfInputTemp);

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
		tempLWOPath = generatePath("LWO", outputFolder, string(srfLWOInputID), srfInputTempArray[3], userOutputString, passNames, pass, ".lwo");
		
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
						error("Can't delete current pass!  Change to a different pass and then try again.");
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
				if(comRingCommand == "renderPassFrame" || comRingCommand == "renderPassScene" || comRingCommand == "renderAllPasses")
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

getImageFormats
{
	config_dir	= getdir("Settings");
	vers		= string(integer(hostVersion()));

	switch(platform())
	{
		case MACUB:
		case MAC64:
			tempString = config_dir + getsep() + "Extensions " + vers;
			input = File(tempString);
			tempString_AS = config_dir + getsep() + "Extension Cache";
			input_AS = File(tempString_AS);
			break;

		case WIN32:
			tempString = config_dir + getsep() + "LWEXT" + vers + ".CFG";
			input = File(tempString);
			tempString_AS = config_dir + getsep() + "Extension Cache";
			input_AS = File(tempString_AS);
			break;

		case WIN64:
			tempString = config_dir + getsep() + "LWEXT" + vers + "-64.CFG";
			input = File(tempString);
			tempString_AS = config_dir + getsep() + "Extension Cache-64";
			input_AS = File(tempString_AS);
			break;

		default:
			break;

	}

	searchstring = "  Class \"ImageSaver\"";
	x = 1;
	errorReport = 0;
	nextline;
	if(input || input_AS)
	{
		if(input)
		{
			while(!input.eof()) // general config file
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
				}
			}
			input.close();
		} else {
			errorReport++;
		}
		if(input_AS)
		{
			while(!input_AS.eof()) // autoscan config file
			{
				line = input_AS.read();
				if(line == searchstring)
				{
					wholeline[x] = input_AS.read();
					wholelinesize = sizeof(wholeline[x]);
					wholeline_right = strright(wholeline[x],wholelinesize - 8);
					wholeline_left = strleft(wholeline_right,(sizeof(wholeline_right) - 1));
					nextline[x] = wholeline_left;
					x++;
				}
			}
			input_AS.close();		
		} else {
			errorReport++;
		}
		if(errorReport != 2 && nextline.count() != 0)
		{
			return(nextline);
		} else {
			info("Could not find any image saver data in either configuration file!");
			return nil;
		}
	} else {
		error("Can't locate any configuration files for LightWave!");
		return(nil);
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

stripPassEditor: sceneFile
{
    // get the plugin lines so we don't copy those into the render scenes
    passEditorStartLine = getPassEditorStartLine(sceneFile);

    if(passEditorStartLine == nil)
    {
        error("Pass Editor not installed.  Please install and run.");
    }
    
    passEditorEndLine = getPartialLine(passEditorStartLine,0,"EndPlugin",sceneFile);
    lineNumber = 1;
    tempFileName = tempDirectory + getsep() + "passEditorTempScene_trim.lws";
    tempFile = File(tempFileName, "w");
    input = File(sceneFile, "r");
    endLineNumber = input.linecount();
    while(lineNumber < passEditorStartLine)
    {
        line = input.read();
        tempFile.writeln(line);
        lineNumber = input.line();
    }
    for(i = 1; i <= (passEditorEndLine - passEditorStartLine) + 1; i++)
    {
    	tempFile.writeln("");
    }
    input.line(passEditorEndLine + 1);
    tempFile.reopen("a");    
    while(lineNumber <= endLineNumber)
    {
        line = input.read();
        tempFile.writeln(line);
        lineNumber = input.line();
    }
    input.close();
    tempFile.close();
    filecopy(tempFileName, sceneFile);
    filedelete(tempFileName);
    return ((passEditorEndLine + 1) - passEditorStartLine);
}

fileCheck: fileToCheck
{
	test = File(fileToCheck, "r");
	if(!test)
		error("Invalid file specified: " + fileToCheck);
	test.close();
}
