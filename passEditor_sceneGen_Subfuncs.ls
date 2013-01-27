generatePassFile: mode, pass
{
    if (mode == "frame")
    {
        outputStr = "testFrame_";
    }
    if (mode == "seq")
    {
        outputStr = "seq_";
    }

    // initial stuff
    overriddenObjectID = nil;
    overriddenObjectName = nil;
    contentDirectory = getdir("Content");
    tempDirectory = getdir("Temp");
    chdir(tempDirectory);
    SaveSceneCopy("passEditorTempSceneCopy.lws");
    currentScenePath = tempDirectory + getsep() + "passEditorTempSceneCopy.lws";
    chdir(contentDirectory);
    // get the plugin lines so we don't copy those into the render scenes
    passEditorStartLine = getPassEditorStartLine(currentScenePath);

    if(passEditorStartLine == nil)
    {
        error("Pass Editor not installed.  Please install and run.");
    }
    
    passEditorEndLine = getPartialLine(passEditorStartLine,0,"EndPlugin",currentScenePath);

    // get the item start and stop lines for copying
    setItems = parseListItems(passAssItems[pass]);
	
    for(x = 1; x <= size(setItems); x++)
    {
        progressString = string((x / size(setItems)) / 2);
        msgString = "{" + progressString + "}Generating Render Scene:  Cataloging Items and Overrides...";
        StatusMsg(msgString);
        sleep(1);

        // first the object lines
        tempNumber = setItems[x];
        tempObjectNames[x] = displayNames[tempNumber];
        assignmentsArray = checkForOverrideAssignments(displayIDs[tempNumber], pass);
    
        if(assignmentsArray != nil)
        {
            doOverride[x] = 1;
            a = assignmentsArray[1];
            settingsArray = parse("||", overrideSettings[a]);
            if( size(assignmentsArray) > 1)
            {
                b = assignmentsArray[2];
                secondSettingsArray = parse("||",overrideSettings[b]);
            }

			// Scene Master override is incompatible with an assignment array, so empty it in this case :			
			if(settingsArray[2] == "type6")
			{
				assignmentsArray = nil;
				doOverride[x] = 0;
				overrideType[x] = 0;
			}
			
            if(settingsArray[2] == "type5")
            {
                overrideType[x] = 5;
                lightColorLine = "LightColor " + string(number(settingsArray[3]) / 255) + " " + string(number(settingsArray[4]) / 255) + " " + string(number(settingsArray[5]) / 255) + "\n";
                lightIntensityLine = "LightIntensity " + settingsArray[6] + "\n";
                if(settingsArray[7] == "0")
                {
                    affectDiffuseLine = "AffectDiffuse 0\n";
                }
                else
                {
                    affectDiffuseLine = "";
                }
                if(settingsArray[8] == "0")
                {
                    affectSpecularLine = "AffectSpecular 0\n";
                }
                else
                {
                    affectSpecularLine = "";
                }
                if(settingsArray[9] == "0")
                {
                    affectOpenglLine = "AffectOpenGL 0\n";
                }
                else
                {
                    affectOpenglLine = "";
                }
                if(settingsArray[10] == "0")
                {
                    LensFlareLine = "LensFlare 0\n";
                }
                else
                {
                    LensFlareLine = "LensFlare 1\n";
                }
                if(settingsArray[11] == "0")
                {
                    VolumetricsLine = "VolumetricLighting 0\n";
                }
                else
                {
                    VolumetricsLine = "VolumetricLighting 1\n";
                }
                
                lightSettingsPartOne[x] = lightColorLine + lightIntensityLine + affectDiffuseLine + affectSpecularLine + LensFlareLine + VolumetricsLine;
                lightSettingsPartTwo[x] = affectOpenglLine;
                
                motInputTemp[x] = nil;
                lwoInputTemp[x] = nil;
                srfLWOInputID[x] = nil;
                srfInputTemp[x] = nil;
                objPropOverrideSets[x] = nil;
                objPropOverrideShadowOpts[x] = nil;

            }

            if(settingsArray[2] == "type1")
            {
                overrideType[x] = 1;
                motInputTemp[x] = nil;
                lwoInputTemp[x] = nil;
                srfLWOInputID[x] = displayIDs[tempNumber];
                srfInputTemp[x] = settingsArray[3];
                objPropOverrideSets[x] = nil;
                objPropOverrideShadowOpts[x] = nil;
                lightSettingsPartOne[x] = nil;
                lightSettingsPartTwo[x] = nil;

            }   

            if(settingsArray[2] == "type4")
            {
                overrideType[x] = 4;
                motInputTemp[x] = nil;
                lwoInputTemp[x] = settingsArray[3];
                srfLWOInputID[x] = nil;
                srfInputTemp[x] = nil;
                objPropOverrideSets[x] = nil;
                objPropOverrideShadowOpts[x] = nil;
                lightSettingsPartOne[x] = nil;
                lightSettingsPartTwo[x] = nil;

            }   
            if(settingsArray[2] == "type3")
            {
                overrideType[x] = 3;
                motInputTemp[x] = File(settingsArray[3],"r");
                lwoInputTemp[x] = nil;
                srfLWOInputID[x] = nil;
                srfInputTemp[x] = nil;
                objPropOverrideSets[x] = nil;
                objPropOverrideShadowOpts[x] = nil;
                lightSettingsPartOne[x] = nil;
                lightSettingsPartTwo[x] = nil;

            }   
            if(settingsArray[2] == "type2")
            {
                overrideType[x] = 2;
                if(settingsArray[3] == "1")
                {
                    //matteObjectLine = "MatteObject 1\nMatteColor 0 0 0\n";
                    matteObjectLine = "MatteObject 1\nMatteColor " + string(number(settingsArray[12]) / 255) + " " + string(number(settingsArray[13]) / 255) + " " + string(number(settingsArray[14]) / 255) + "\n";
                }
                else
                {
                    matteObjectLine = "";
                }

                switch(integer(settingsArray[4]))
                {
                    case 1:
                        alphaLine = "";
                        break;

                    case 2:
                        alphaLine = "ObjectAlphaMode 1\n";
                        break;

                    case 3:
                        alphaLine = "ObjectAlphaMode 2\n";
                        break;

                    default:
                        break;
                }
                if(settingsArray[5] == "1")
                {
                    unseenByRaysLine = "UnseenByRays 1\n";
                }
                else
                {
                    unseenByRaysLine = "";
                }
                if(settingsArray[6] == "1")
                {
                    unseenByCameraLine = "UnseenByCamera 1\n";
                }
                else
                {
                    unseenByCameraLine = "";
                }
                if(settingsArray[7] == "1")
                {
                    unseenByRadiosityLine = "UnseenByRadiosity 1\n";
                }
                else
                {
                    unseenByRadiosityLine = "";
                }
                if(settingsArray[8] == "1")
                {
                    unseenByFogLine = "UnaffectedByFog 1\n";
                }
                else
                {
                    unseenByFogLine = "";
                }
                //info("settingsArray[9] is ",settingsArray[9]," and settingsArray[10] is ",settingsArray[10]," and settingsArray[11] is ",settingsArray[11]);
                if(settingsArray[9] == "0")
                {
                    if(settingsArray[10] == "0")
                    {
                        if(settingsArray[11] == "0")
                        {
                            shadowOptionsLine = "ShadowOptions 0\n";
                        }
                        else
                        {
                            shadowOptionsLine = "ShadowOptions 4\n";
                        }
                    }
                    else
                    {
                        if(settingsArray[11] == "0")
                        {
                            shadowOptionsLine = "ShadowOptions 2\n";
                        }
                        else
                        {
                            shadowOptionsLine = "ShadowOptions 6\n";
                        }
                    }
                }
                else
                {
                    if(settingsArray[10] == "0")
                    {
                        if(settingsArray[11] == "0")
                        {
                            shadowOptionsLine = "ShadowOptions 1\n";
                        }
                        else
                        {
                            shadowOptionsLine = "ShadowOptions 5\n";
                        }
                    }
                    else
                    {
                        if(settingsArray[11] == "0")
                        {
                            shadowOptionsLine = "ShadowOptions 3\n";
                        }
                        else
                        {
                            shadowOptionsLine = "ShadowOptions 7\n";
                        }
                    }

                    /*
                    ShadowOptions 0 = none
                    ShadowOptions 1 = self
                    ShadowOptions 2 = cast
                    ShadowOptions 3 = self, cast
                    ShadowOptions 4 = receive
                    ShadowOptoins 5 = self, receive
                    ShadowOptions 6 = cast, receive
                    ShadowOptions 7 = self, cast, receive

                    */
                }
                motInputTemp[x] = nil;
                lwoInputTemp[x] = nil;
                srfLWOInputID[x] = nil;
                srfInputTemp[x] = nil;
                objPropOverrideSets[x] = matteObjectLine + unseenByFogLine + unseenByRadiosityLine + unseenByRaysLine + unseenByCameraLine + alphaLine;
                objPropOverrideShadowOpts[x] = shadowOptionsLine;
                lightSettingsPartOne[x] = nil;
                lightSettingsPartTwo[x] = nil;
            }
            if(settingsArray[2] == "type7")
            {
                overrideType[x] = 7;
                if(size(settingsArray) >= 3)
                {
                    if(settingsArray[3] != nil && settingsArray[3] != "")
                    {
                        excludedLightNames = parse(";",settingsArray[3]);
                    }
                    else
                    {
                        excludedLightNames = "";
                    }
                }
                else
                {
                    excludedLightNames = "";
                }
                if(excludedLightNames != nil && excludedLightNames != "")
                {
                    lightExclusion[x] = nil;
                    doneRad = 0;
                    doneCaus = 0;                   
                    for(k = 1; k <= size(lightNames); k++)
                    {
                        for(m = 1; m <= size(excludedLightNames); m++)
                        {
                            if(lightNames[k] == excludedLightNames[m])
                            {
                                tempID = lightOldIDs[k];
                                lightExclusion[x] = string(lightExclusion[x]) + "ExcludeLight " + string(tempID) + "\n";
                            }
                            else
                            {
                                if(excludedLightNames[m] == "Radiosity")
                                {
                                    if(doneRad == 0)
                                    {
                                        lightExclusion[x] = string(lightExclusion[x]) + "ExcludeLight 21000000\n";
                                        doneRad = 1;
                                    }
                                }
                                else
                                {
                                    if(excludedLightNames[m] == "Caustics")
                                    {
                                        if(doneCaus == 0)
                                        {
                                            lightExclusion[x] = string(lightExclusion[x]) + "ExcludeLight 22000000\n";
                                            doneCaus = 1;
                                        }
                                    }
                                }
                            }   
                        }
                    }
                }
                else
                {
                    lightExclusion[x] = nil;
                }
                
                
                //tempIDArray = parse("x",hex(number(settingsArray[4])));
                //lightExclusion[x] = "ExcludeLight " + tempIDArray[2] + "\n";
                
                motInputTemp[x] = nil;
                lwoInputTemp[x] = nil;
                srfLWOInputID[x] = nil;
                srfInputTemp[x] = nil;
                objPropOverrideSets[x] = nil;
                objPropOverrideShadowOpts[x] = nil;
                lightSettingsPartOne[x] = nil;
                lightSettingsPartTwo[x] = nil;
            }
            if(assignmentsArray != nil && size(assignmentsArray) > 1)
            {
                if(secondSettingsArray[2] == "type7")
                {
                    secondOverrideType[x] = 7;
                    if(size(secondSettingsArray) >= 3)
                    {
                        if(secondSettingsArray[3] != nil && secondSettingsArray[3] != "")
                        {
                            excludedLightNames = parse(";",secondSettingsArray[3]);
                        }
                        else
                        {
                            excludedLightNames = "";
                        }
                    }
                    else
                    {
                        excludedLightNames = "";
                    }
                    if(excludedLightNames != nil && excludedLightNames != "")
                    {
                        lightExclusion[x] = nil;
                        doneRad = 0;
                        doneCaus = 0;                   
                        for(k = 1; k <= size(lightNames); k++)
                        {
                            for(m = 1; m <= size(excludedLightNames); m++)
                            {
                                if(lightNames[k] == excludedLightNames[m])
                                {
                                    tempID = lightOldIDs[k];
                                    lightExclusion[x] = string(lightExclusion[x]) + "ExcludeLight " + string(tempID) + "\n";
                                }
                                else
                                {
                                    if(excludedLightNames[m] == "Radiosity")
                                    {
                                        if(doneRad == 0)
                                        {
                                            lightExclusion[x] = string(lightExclusion[x]) + "ExcludeLight 21000000\n";
                                            doneRad = 1;
                                        }
                                    }
                                    else
                                    {
                                        if(excludedLightNames[m] == "Caustics")
                                        {
                                            if(doneCaus == 0)
                                            {
                                                lightExclusion[x] = string(lightExclusion[x]) + "ExcludeLight 22000000\n";
                                                doneCaus = 1;
                                            }
                                        }
                                    }
                                }   
                            }
                        }
                    }
                    else
                    {
                        lightExclusion[x] = nil;
                    }
                    
                    //tempIDArray = parse("x",hex(number(secondSettingsArray[4])));
                    //lightExclusion[x] = "ExcludeLight " + tempIDArray[2] + "\n";
                }
                else
                {
                    secondOverrideType[x] = nil;
                }
            }
            else
            {
                secondOverrideType[x] = nil;
            }
            
        }
        else
        {
			doOverride[x] = 0;
            overrideType[x] = 0;
        }
        if(size(doOverride) < x)
        {
            doOverride[x] = 0;
        }
        if(overrideType == nil || size(overrideType) < x)
        {
			errorString = "An internal error has been detected: overrideType is: " + overrideType;
			info(errorString);
			errorString = "Will render a full pass of type '" + mode + "' instead. Sorry.";
			info(errorString);
			doOverride[x] = 0;
            overrideType[x] = 0;
        }
        

        if(strleft(string(displayOldIDs[tempNumber]),1) == "1")
        {
            objStart[x] = getObjectLines(passEditorEndLine + 1,0,displayOldIDs[tempNumber],currentScenePath);
            objStartTemp = number(objStart[x]);
            objStartPlusOne = objStartTemp + 1;
            objEnd[x] = getObjectEndLine(objStartPlusOne,0,displayOldIDs[tempNumber],currentScenePath);
            objMotStart[x] = getPartialLine(objStart[x],objEnd[x],"NumChannels",currentScenePath);
            objMotEnd[x] = objMotStart[x];
            for(b = 1; b <= 9; b++)
            {
                objMotEnd[x] = getPartialLine((objMotEnd[x] + 1),objEnd[x],"}",currentScenePath);
            }
            lastObject = x;
        }

        // then the light lines
        if(strleft(string(displayOldIDs[tempNumber]),1) == "2")
        {
            objStart[x] = getLightLines(passEditorEndLine + 1,0,displayOldIDs[tempNumber],currentScenePath);
            objStartTemp = number(objStart[x]);
            objStartPlusOne = objStartTemp + 1;
            objEnd[x] = getLightEndLine(objStartPlusOne,0,displayOldIDs[tempNumber],currentScenePath);
            objMotStart[x] = getPartialLine(objStart[x],objEnd[x],"NumChannels",currentScenePath);
            objMotEnd[x] = objMotStart[x];
            for(b = 1; b <= 9; b++)
            {
                objMotEnd[x] = getPartialLine((objMotEnd[x] + 1),objEnd[x],"}",currentScenePath);
            }
            objPathAlignReliableDistLine[x] = getPartialLine(objStart[x],objEnd[x],"PathAlignReliableDist",currentScenePath);
            if(getPartialLine(objStart[x],objEnd[x],"AffectCaustics",currentScenePath) > 0)
            {
                objAffectCausticsLine[x] = getPartialLine(objStart[x],objEnd[x],"AffectCaustics",currentScenePath);
            }
            else
            {
                objAffectCausticsLine[x] = nil;
            }
            objLightTypeLine[x] = getPartialLine(objStart[x],objEnd[x],"LightType ",currentScenePath);
        }


    }

    // then the ambient color line
    ambientColorLine = getPartialLine(0,0,"AmbientColor",currentScenePath);

    // get the start light line
    startLightsLine = getPartialLine(0,0,"AddLight",currentScenePath);

    // then the camera line
    cameraStartLine = getPartialLine(0,0,"AddCamera",currentScenePath);

    // data overlay label
    dataOverlayLabelLine = getPartialLine(0,0,"DataOverlayLabel",currentScenePath);

    // get the save RGB line
    saveRGBLine = getPartialLine(cameraStartLine,0,"SaveRGB ",currentScenePath);

    // try to get the alpha multiplication settings line
    alphaMultSettingsLine =  getPartialLine(saveRGBLine,0,"AlphaMode ",currentScenePath);

    // get the ViewConfiguration line
    viewConfigurationLine = getPartialLine(saveRGBLine,0,"ViewConfiguration ",currentScenePath);

    // check for HV data
    hvDataLine = getPartialLine(0,0,"{ HyperVoxelData",currentScenePath);


    if(hvDataLine)
    {
        inputTemp = File(currentScenePath,"r");
        hvObjectTotal = 0;
        inputTemp.line(hvDataLine);
        while(!inputTemp.eof())
        {
            line = inputTemp.read();
            if(line == "  { HVObject")
            {
                hvObjectTotal = hvObjectTotal + 1;
            }
        }
        inputTemp.close();
        if(hvObjectTotal != 0)
        {
            hvObjectLine[1] = getPartialLine(hvDataLine,0,"  { HVObject",currentScenePath);
            hvObjectEndLineTemp = getPartialLine(hvObjectLine[1],0,"    { HVoxelCache",currentScenePath);
            hvObjectEndLine[1] = hvObjectEndLineTemp + 5;
            if(hvObjectTotal > 1)
            {
                for(x = 2; x <= integer(hvObjectTotal); x++)
                {
                    xMinusOne = x - 1;
                    linePlusOne = hvObjectLine[xMinusOne] + 1;
                    hvObjectLine[x] = getPartialLine(linePlusOne,0,"  { HVObject",currentScenePath);
                    hvObjectEndLineTemp = getPartialLine(hvObjectLine[x],0,"    { HVoxelCache",currentScenePath);
                    hvObjectEndLine[x] = hvObjectEndLineTemp + 5;

                }
            }

            inputTemp = File(currentScenePath,"r");
            for(x = 1; x <= integer(hvObjectTotal); x++)
            {
                lineTempNumber = hvObjectLine[x] + 2;
                inputTemp.line(lineTempNumber);
                hvObjectNameTemp = inputTemp.read();
                tempNameArray = parse("\"",hvObjectNameTemp);
                hvObjectName[x] = tempNameArray[2];
            }
            inputTemp.close();

            z = 1;
            for(x = 1; x <= size(tempObjectNames); x++)
            {
                for(y = 1; y <= size(hvObjectName); y++)
                {
                    if(tempObjectNames[x] == hvObjectName[y])
                    {
                        includedHvObjects[z] = y;
                        z++;
                    }
                }
            }
        }
        else
        {
            hvObjectEndLine[1] = hvDataLine + 4;
        }
    }

    outputFolder = parse("(", userOutputFolder);

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
                    newScenePath = outputFolder[1] + getsep() + "CG" + getsep() + "temp" + getsep() + "tempScenes" + getsep() + outputStr + fileOutputPrefix + "_" + userOutputString + "_" + passNames[pass] + ".lws";
                }
                else
                {
                    mkdir("tempScenes");
                    chdir("tempScenes");
                    newScenePath = outputFolder[1] + getsep() + "CG" + getsep() + "temp" + getsep() + "tempScenes" + getsep() + outputStr + fileOutputPrefix + "_" + userOutputString + "_" + passNames[pass] + ".lws";
                    
                }
            }
            else
            {
                mkdir("temp");
                chdir("temp");
                mkdir("tempScenes");
                chdir("tempScenes");
                newScenePath = outputFolder[1] + getsep() + "CG" + getsep() + "temp" + getsep() + "tempScenes" + getsep() + outputStr + fileOutputPrefix + "_" + userOutputString + "_" + passNames[pass] + ".lws";
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
            newScenePath = outputFolder[1] + getsep() + "CG" + getsep() + "temp" + getsep() + "tempScenes" + getsep() + outputStr + fileOutputPrefix + "_" + userOutputString + "_" + passNames[pass] + ".lws";
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
        newScenePath = outputFolder[1] + getsep() + "CG" + getsep() + "temp" + getsep() + "tempScenes" + getsep() + outputStr + fileOutputPrefix + "_" + userOutputString + "_" + passNames[pass] + ".lws";
    }

    if(platformVar == WIN32 || platformVar == WIN64)
    {
        
        tempFixedPath = fixPathForWin32(newScenePath);
        newScenePath = tempFixedPath;
        
        tempFixedPath = fixPathForWin32(currentScenePath);
        currentScenePath = tempFixedPath;

    }

    inputFile = File(currentScenePath, "r");
    outputFile = File(newScenePath, "w");

    // write out the header stuff
    lineNumber = 1;
    inputFile.line(lineNumber);
    while(lineNumber < passEditorStartLine)
    {
        line = inputFile.read();
        outputFile.writeln(line);
        lineNumber = inputFile.line();
    }
    outputFile.writeln("");
    
    // write out the objects
    if(lastObject != nil)
    {
        mmInt = 1;
        for(x = 1; x <= lastObject; x++)
        {
            progressString = string(((x/size(lastObject))/4) + 0.5);
            msgString = "{" + progressString + "}Generating Render Scene:  Writing Objects...";
            StatusMsg(msgString);
            sleep(1);
            
            if(doOverride[x] == 1)
            {
                switch(overrideType[x])
                {
                    case 1:
                        // begin case 1 here, which is the surface type
                        if(srfInputTemp[x] != nil && srfLWOInputID[x] != nil)
                        {
                            surfacedLWO = generateSurfaceObjects(pass,srfLWOInputID[x],srfInputTemp[x],currentScenePath,objStart[x]);
                            if(surfacedLWO != nil)
                            {
                                inputFile.line(objStart[x]);
                                line = inputFile.read();
                                if(line != nil && line != "")
                                {
                                    parseObjLineTemp = parse(" ",line);
                                    if(parseObjLineTemp[1] == "LoadObjectLayer")
                                    {
                                        line = parseObjLineTemp[1] + " " + parseObjLineTemp[2] + " " + parseObjLineTemp[3] + " " + surfacedLWO;
                                        
                                        surfacedLWO_nameArray = split(surfacedLWO);
                                        surfacedLWO_baseName = surfacedLWO_nameArray[3];
                                        overriddenObjectID[mmInt] = parseObjLineTemp[3];
                                        //info("overriding properly");
                                        overriddenObjectName[mmInt] = surfacedLWO_baseName;
                                        mmInt = mmInt + 1;
                                    }
                                }
                                outputFile.writeln(line);
                                done = nil;
                                while(!done)
                                {
                                    line = inputFile.read();
                                    outputFile.writeln(line);
                                    if(inputFile.line() == (objEnd[x] - 2))
                                    {
                                        done = true;
                                        break;
                                    }
                                }
                                inputFile.line(objEnd[x] - 2);
                                line = inputFile.read();
                                outputFile.writeln(line);
                                if(lightExclusion)
                                {
                                    if(lightExclusion[x] != nil)
                                    {
                                        outputFile.write(lightExclusion[x]);
                                    }
                                }
    
                                outputFile.writeln("");
                            }
                            else
                            {
                                inputFile.line(objStart[x]);
                                done = nil;
                                while(!done)
                                {
                                    line = inputFile.read();
                                    outputFile.writeln(line);
                                    if(inputFile.line() == (objEnd[x] - 2))
                                    {
                                        done = true;
                                        break;
                                    }
                                }
                                inputFile.line(objEnd[x] - 2);
                                line = inputFile.read();
                                outputFile.writeln(line);
                                if(lightExclusion)
                                {
                                    if(lightExclusion[x] != nil)
                                    {
                                        outputFile.write(lightExclusion[x]);
                                    }
                                }
    
                                outputFile.writeln(""); 
                            }   
                            
                        }
                        else
                        {
                            inputFile.line(objStart[x]);
                            done = nil;
                            while(!done)
                            {
                                line = inputFile.read();
                                outputFile.writeln(line);
                                if(inputFile.line() == (objEnd[x] - 2))
                                {
                                    done = true;
                                    break;
                                }
                            }
                            inputFile.line(objEnd[x] - 2);
                            line = inputFile.read();
                            outputFile.writeln(line);
                            if(lightExclusion)
                            {
                                if(lightExclusion[x] != nil)
                                {
                                    outputFile.write(lightExclusion[x]);
                                }
                            }

                            outputFile.writeln(""); 
                        }
                        // end case 1 here, which is the surface type
                        break;
                    
                    case 2:
                        // begin case 2 here, which is the object properties override type
                        inputFile.line(objStart[x]);
                        done = nil;
                        excludedLightsTemp = 0;
                        while(!done)
                        {
                            line = inputFile.read();
                            mystring = "ShadowOptions ";
                            mystring_len = size(mystring);
                            if(size(line) > mystring_len)
                            {
                                if(strleft(line,mystring_len) != mystring)
                                {
                                    outputFile.writeln(line);
                                    //excludedLightsTemp = 0;
                                }
                                else
                                {
                                    outputFile.write(objPropOverrideSets[x]);
                                    outputFile.write(objPropOverrideShadowOpts[x]);
                                    excludedLightsTemp = 1;
                                }
                            }
                            else
                            {
                                outputFile.writeln(line);
                            }
                            if(inputFile.line() == (objEnd[x] - 2))
                            {
                                done = true;
                                break;
                            }
                        }
                        if(excludedLightsTemp == 1)
                        {
                            inputFile.line(objEnd[x] - 2);
                            line = inputFile.read();
                            outputFile.writeln(line);
                            outputFile.writeln("");
                        }
                        else
                        {
                            outputFile.write(objPropOverrideSets[x]);
                            outputFile.writeln(objPropOverrideShadowOpts[x]);
                        }
                        if(lightExclusion)
                        {
                            if(lightExclusion[x] != nil)
                            {
                                outputFile.write(lightExclusion[x]);
                            }
                        }

                        // end case 2 here, which is the object properties override type
                        break;
                        
                    case 3:
                        // begin case 3 here, which is the motion override type
                        if(motInputTemp[x] != nil)
                        {
                            inputFile.line(objStart[x]);
                            done = nil;
                            while(!done)
                            {
                                line = inputFile.read();
                                outputFile.writeln(line);
                                if(inputFile.line() == (objMotStart[x]))
                                {
                                    done = true;
                                    break;
                                }
                            }
                            motInputTemp[x].line(4);
                            while(!motInputTemp[x].eof())
                            {
                                line = motInputTemp[x].read();
                                outputFile.writeln(line);
                            }
                            inputFile.line(objMotEnd[x] + 1);
                            done = nil;
                            while(!done)
                            {
                                line = inputFile.read();
                                outputFile.writeln(line);
                                if(inputFile.line() == (objEnd[x] - 2))
                                {
                                    done = true;
                                    break;
                                }
                            }
                            motInputTemp[x].close();
                            inputFile.line(objEnd[x] - 2);
                            line = inputFile.read();
                            outputFile.writeln(line);
                            if(lightExclusion)
                            {
                                if(lightExclusion[x] != nil)
                                {
                                    outputFile.write(lightExclusion[x]);
                                }
                            }
                            outputFile.writeln("");
                        }
                        else
                        {
                            inputFile.line(objStart[x]);
                            done = nil;
                            while(!done)
                            {
                                line = inputFile.read();
                                outputFile.writeln(line);
                                if(inputFile.line() == (objEnd[x] - 2))
                                {
                                    done = true;
                                    break;
                                }
                            }
                            inputFile.line(objEnd[x] - 2);
                            line = inputFile.read();
                            outputFile.writeln(line);
                            if(lightExclusion)
                            {
                                if(lightExclusion[x] != nil)
                                {
                                    outputFile.write(lightExclusion[x]);
                                }
                            }
                            outputFile.writeln("");
                        }
                        // end case 3 here, which is the motion override type
                        break;
                        
                    case 4:
                        // begin case 4 here, which is the alternate object type
                        if(lwoInputTemp[x] != nil)
                        {
                            inputFile.line(objStart[x]);
                            line = inputFile.read();
                            if(line != nil && line != "")
                            {
                                parseObjLineTemp = parse(" ",line);
                                if(parseObjLineTemp[1] == "LoadObjectLayer")
                                {
                                    line = parseObjLineTemp[1] + " 1 " + parseObjLineTemp[3] + " " + lwoInputTemp[x];
                                    replacedLWO_nameArray = split(lwoInputTemp[x]);
                                    replacedLWO_baseName = replacedLWO_nameArray[3];
                                    overriddenObjectID[mmInt] = parseObjLineTemp[3];
                                    overriddenObjectName[mmInt] = replacedLWO_baseName;
                                    mmInt = mmInt + 1;
                                }
                            }
                            outputFile.writeln(line);
                            done = nil;
                            while(!done)
                            {
                                line = inputFile.read();
                                outputFile.writeln(line);
                                if(inputFile.line() == (objEnd[x] - 2))
                                {
                                    done = true;
                                    break;
                                }
                            }
                            inputFile.line(objEnd[x] - 2);
                            line = inputFile.read();
                            outputFile.writeln(line);
                            if(lightExclusion)
                            {
                                if(lightExclusion[x] != nil)
                                {
                                    outputFile.write(lightExclusion[x]);
                                }
                            }
                            outputFile.writeln(""); 
                            
                        }
                        else
                        {
                            inputFile.line(objStart[x]);
                            done = nil;
                            while(!done)
                            {
                                line = inputFile.read();
                                outputFile.writeln(line);
                                if(inputFile.line() == (objEnd[x] - 2))
                                {
                                    done = true;
                                    break;
                                }
                            }
                            inputFile.line(objEnd[x] - 2);
                            line = inputFile.read();
                            outputFile.writeln(line);
                            if(lightExclusion)
                            {
                                if(lightExclusion[x] != nil)
                                {
                                    outputFile.write(lightExclusion[x]);
                                }
                            }
                            outputFile.writeln(""); 
                        }
                        // end case 4 here, which is the alternate object type
                        break;
                        
                    case 7:
                        inputFile.line(objStart[x]);
                        done = nil;
                        while(!done)
                        {
                            line = inputFile.read();
                            outputFile.writeln(line);
                            if(inputFile.line() == (objEnd[x] - 2))
                            {
                                done = true;
                                break;
                            }
                        }
                        inputFile.line(objEnd[x] - 2);
                        line = inputFile.read();
                        outputFile.writeln(line);
                        if(lightExclusion)
                        {
                            if(lightExclusion[x] != nil)
                            {
                                outputFile.write(lightExclusion[x]);
                            }
                        }                   
                        outputFile.writeln("");
                        break;
                        
                    default:
                        inputFile.line(objStart[x]);
                        done = nil;
                        while(!done)
                        {
                            line = inputFile.read();
                            outputFile.writeln(line);
                            if(inputFile.line() == (objEnd[x] - 2))
                            {
                                done = true;
                                break;
                            }
                        }
                        inputFile.line(objEnd[x] - 2);
                        line = inputFile.read();
                        outputFile.writeln(line);
                        outputFile.writeln("");
                        break;

                // end override type switch statement here
                }
                
            }
            else
            {
                inputFile.line(objStart[x]);
                done = nil;
                while(!done)
                {
                    line = inputFile.read();
                    outputFile.writeln(line);
                    if(inputFile.line() == (objEnd[x] - 2))
                    {
                        done = true;
                        break;
                    }
                }
                inputFile.line(objEnd[x] - 2);
                line = inputFile.read();
                outputFile.writeln(line);
                outputFile.writeln("");
            }
        }
    }
    else
    {
        lastObject = 0;
    }

    // write out the stuff between the lights and objects
    lineNumber = ambientColorLine;
    inputFile.line(lineNumber);
    while(lineNumber < (startLightsLine - 1))
    {
        lineNumber = inputFile.line();
        line = inputFile.read();
        outputFile.writeln(line);
    }
    
    // write out the lights
    for(x = lastObject + 1; x <= size(objStart); x++)
    {
        
        progressString = string(((x/size(objStart))/4) + 0.74);
        msgString = "{" + progressString + "}Generating Render Scene:  Writing Lights...";
        StatusMsg(msgString);
        sleep(1);
        
        
        if(doOverride[x] == 1)
        {
            switch(overrideType[x])
            {
                case 5:
                    // begin case 5 here, which is the light properties override type
                    if(lightSettingsPartOne[x] != nil)
                    {
                        // write out the beginning of the light
                        inputFile.line(objStart[x]);
                        done = nil;
                        while(!done)
                        {
                            line = inputFile.read();
                            outputFile.writeln(line);
                            if(inputFile.line() == (objPathAlignReliableDistLine[x]) + 1)
                            {
                                done = true;
                                break;
                            }
                        }
                        
                        // write out the custom parameters
                        outputFile.write(lightSettingsPartOne[x]);
                        
                        // write out the affect caustics line
                        if(objAffectCausticsLine != nil)
                        {
                            if(objAffectCausticsLine[x] != nil)
                            {
                                inputFile.line(objAffectCausticsLine[x]);
                                line = inputFile.read();
                                outputFile.writeln(line);
                            }
                        }
                        
                        // write out the open gl line
                        outputFile.write(lightSettingsPartTwo[x]);
                        
                        // write out the rest of the light
                        inputFile.line(objLightTypeLine[x]);
                        done = nil;
                        while(!done)
                        {
                            line = inputFile.read();
                            outputFile.writeln(line);
                            if(inputFile.line() == (objEnd[x]))
                            {
                                done = true;
                                break;
                            }
                        }
                    }
                    else
                    {
                        inputFile.line(objStart[x]);
                        done = nil;
                        while(!done)
                        {
                            line = inputFile.read();
                            outputFile.writeln(line);
                            if(inputFile.line() == (objEnd[x]))
                            {
                                done = true;
                                break;
                            }
                        }
                    }
                    // end case 5 here, which is the light properties override type
                    break;
                
                case 3:
                    // begin case 3 here, which is the motion override type
                    if(motInputTemp[x] != nil)
                    {
                        inputFile.line(objStart[x]);
                        done = nil;
                        while(!done)
                        {
                            line = inputFile.read();
                            outputFile.writeln(line);
                            if(inputFile.line() == (objMotStart[x]))
                            {
                                done = true;
                                break;
                            }
                        }
                        motInputTemp[x].line(4);
                        while(!motInputTemp[x].eof())
                        {
                            line = motInputTemp[x].read();
                            outputFile.writeln(line);
                        }
                        inputFile.line(objMotEnd[x] + 1);
                        done = nil;
                        while(!done)
                        {
                            line = inputFile.read();
                            outputFile.writeln(line);
                            if(inputFile.line() == (objEnd[x] - 2))
                            {
                                done = true;
                                break;
                            }
                        }
                        motInputTemp[x].close();
                        inputFile.line(objEnd[x] - 2);
                        line = inputFile.read();
                        outputFile.writeln(line);
                        outputFile.writeln("");
                    }
                    else
                    {
                        inputFile.line(objStart[x]);
                        done = nil;
                        while(!done)
                        {
                            line = inputFile.read();
                            outputFile.writeln(line);
                            if(inputFile.line() == (objEnd[x]))
                            {
                                done = true;
                                break;
                            }
                        }
                    }
                    // end case 3 here, which is the motion override type
                    break;
                
                default:
                    inputFile.line(objStart[x]);
                    done = nil;
                    while(!done)
                    {
                        line = inputFile.read();
                        outputFile.writeln(line);
                        if(inputFile.line() == (objEnd[x]))
                        {
                            done = true;
                            break;
                        }
                    }
                    break;
            }
        }
        else
        {
            inputFile.line(objStart[x]);
            done = nil;
            while(!done)
            {
                line = inputFile.read();
                outputFile.writeln(line);
                if(inputFile.line() == (objEnd[x]))
                {
                    done = true;
                    break;
                }
            }
        }
    }
    
    if(hvDataLine == nil || includedHvObjects == nil)
    {
        if(hvDataLine != nil)
        {
            // write out the camera lines
            hvStartLine = hvDataLine - 1;
            lineNumber = cameraStartLine - 1;
            inputFile.line(lineNumber);
            while(lineNumber <= hvStartLine)
            {
                line = inputFile.read();
                outputFile.writeln(line);
                lineNumber = inputFile.line();
            }
            
            // write out more of the scene, skipping the HV data
            tempSizeNumber = size(hvObjectEndLine);
            lineNumber = hvObjectEndLine[tempSizeNumber];
            inputFile.line(lineNumber);
            while(lineNumber <= dataOverlayLabelLine)
            {
                line = inputFile.read();
                outputFile.writeln(line);
                lineNumber = inputFile.line();
            }
        }
        else
        {
            // write out the camera lines
            lineNumber = cameraStartLine - 1;
            inputFile.line(lineNumber);
            while(lineNumber <= dataOverlayLabelLine)
            {
                line = inputFile.read();
                outputFile.writeln(line);
                lineNumber = inputFile.line();
            }

        }
            
    }
    else
    {
        // write out the camera lines
        hvStartLine = hvDataLine - 1;
        lineNumber = cameraStartLine - 1;
        inputFile.line(lineNumber);
        while(lineNumber <= hvStartLine)
        {
            line = inputFile.read();
            outputFile.writeln(line);
            lineNumber = inputFile.line();
        }
        
        //write out the HV data
        lineNumber = hvStartLine + 1;
        inputFile.line(lineNumber);
        for(x = 1; x < 4; x++)
        {
            line = inputFile.read();
            outputFile.writeln(line);
        }
        for(x = 1; x <= size(includedHvObjects); x++)
        {
            tempIterationNumber = includedHvObjects[x];
            lineNumber = hvObjectLine[tempIterationNumber];
            inputFile.line(lineNumber);
            while(lineNumber <= hvObjectEndLine[tempIterationNumber])
            {
                line = inputFile.read();
                outputFile.writeln(line);
                lineNumber = inputFile.line();
            }
        }
        
        tempSizeNumber = size(hvObjectEndLine);
        lineNumber = hvObjectEndLine[tempSizeNumber];
        inputFile.line(lineNumber);
        while(lineNumber <= dataOverlayLabelLine)
        {
            line = inputFile.read();
            outputFile.writeln(line);
            lineNumber = inputFile.line();
        }
        
    }
    
    progressString = string(0.995);
    msgString = "{" + progressString + "}Generating Render Scene:  Finishing...";
    StatusMsg(msgString);
    sleep(1);
    
    // write out the save RGB information
    if(mode == "frame")
    {
        outputFile.writeln("OutputFilenameFormat 3");
    } else {
        outputFile.writeln("OutputFilenameFormat 7");
    }
    outputFile.writeln("SaveRGB 1");
    
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
            saveRGBImagesPrefix = outputFolder[1] + getsep() + "CG" + getsep();
            if (mode == "frame")
            {
                saveRGBImagesPrefix = saveRGBImagesPrefix + "temp" + getsep();
            }
            saveRGBImagesPrefix = saveRGBImagesPrefix + outputStr + fileOutputPrefix + "_" + userOutputString + "_" + passNames[pass] + getsep() + outputStr + fileOutputPrefix + "_" + userOutputString + "_" + passNames[pass];
        }
        else
        {
            chdir("CG");
            if (mode == "frame")
                chdir("temp");
            mkdir(outputStr + fileOutputPrefix + "_" + userOutputString + "_" + passNames[pass]);
            chdir(outputStr + fileOutputPrefix + "_" + userOutputString + "_" + passNames[pass]);
            
            saveRGBImagesPrefix = outputFolder[1] + getsep() + "CG" + getsep();
            if (mode == "frame")
            {
                saveRGBImagesPrefix = saveRGBImagesPrefix + "temp" + getsep();
            }
            saveRGBImagesPrefix = saveRGBImagesPrefix + outputStr + fileOutputPrefix + "_" + userOutputString + "_" + passNames[pass] + getsep() + outputStr + fileOutputPrefix + "_" + userOutputString + "_" + passNames[pass];
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
        
        saveRGBImagesPrefix = outputFolder[1] + getsep() + "CG" + getsep();
        if (mode == "frame")
        {
            saveRGBImagesPrefix = saveRGBImagesPrefix + "temp" + getsep();
        }
        saveRGBImagesPrefix = saveRGBImagesPrefix + outputStr + fileOutputPrefix + "_" + userOutputString + "_" + passNames[pass] + getsep() + outputStr + fileOutputPrefix + "_" + userOutputString + "_" + passNames[pass];
    }
    testOutputPath = saveRGBImagesPrefix;
    
    outputFile.writeln("SaveRGBImagesPrefix " + saveRGBImagesPrefix);
    if (mode == "frame")
    {
        outputFile.writeln("RGBImageSaver " + image_formats_array[testRgbSaveType]);
    } else {
        outputFile.writeln("RGBImageSaver " + image_formats_array[rgbSaveType]);
    }
    outputFile.writeln("SaveAlpha 0");
    if(alphaMultSettingsLine != nil)
    {
        // write out the alpha multiplication settings if they exist
        lineNumber = alphaMultSettingsLine;
        inputFile.line(lineNumber);
        line = inputFile.read();
        if(line != nil && line != "")
        {
            outputFile.writeln(line);
        }
    }
    outputFile.writeln("");
    
    // write out the rest of the scene file
    lineNumber = viewConfigurationLine;
    inputFile.line(lineNumber);
    while(!inputFile.eof())
    {
        line = inputFile.read();
        outputFile.writeln(line);
        lineNumber = inputFile.line();
    }   

    // close them up
    inputFile.close();
    outputFile.close();

    updatedCurrentScenePath = tempDirectory + getsep() + "passEditorTempSceneUpdated.lws";
	filecopy(newScenePath, updatedCurrentScenePath);
	
    // newScenePath
    if(overrideNames[1] != "empty")
    {
        z = 1;
        for(x = 1; x <= size(overrideNames); x++)
        {
            //set_o_items = parseListItems(passOverrideItems[pass][x]);
            overrideItemsString = passOverrideItems[pass][x];
            idsArray = parse("||",overrideItemsString);
            for(y = 1; y <= size(idsArray); y++)
            {
                if(string(idsArray[y]) == "(Scene Master)")
                {
                        itemsParsedArray[z] = x;
                        z++;
                }
            }
        }
    }
    if(itemsParsedArray != nil)
    {
        a = itemsParsedArray[1];
        settingsArray = parse("||",overrideSettings[a]);
        if(settingsArray[2] == "type6")
        {
			overrideType[x] = 6;
            resolutionMultiplierSetts	= integer(settingsArray[3]);
			redirectBuffersSetts 		= integer(settingsArray[8]);
			disableAASetts 				= integer(settingsArray[9]);

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

			writeOverrideString(updatedCurrentScenePath, newScenePath, "GlobalFrameSize ", resMult);
						
			renderModeSetts = integer(settingsArray[4]);
			writeOverrideString(updatedCurrentScenePath, newScenePath, "RenderMode ", renderModeSetts);

			renderModeSetts = integer(settingsArray[4]);
			writeOverrideString(updatedCurrentScenePath, newScenePath, "RenderMode ", renderModeSetts);
            
			depthBufferAASetts = integer(settingsArray[5]);
			writeOverrideString(updatedCurrentScenePath, newScenePath, "DepthBufferAA ", depthBufferAASetts);
            
			renderLinesSetts = integer(settingsArray[6]);
			writeOverrideString(updatedCurrentScenePath, newScenePath, "RenderLines ", renderLinesSetts);

			rayRecursionLimitSetts = integer(settingsArray[7]);
			writeOverrideString(updatedCurrentScenePath, newScenePath, "RayRecursionLimit ", rayRecursionLimitSetts);

			if(disableAASetts == 1) {
				writeOverrideString(updatedCurrentScenePath, newScenePath, "AASamples ", "1");
			}
			
			raytraceShadows				= integer(settingsArray[10]);
			raytraceShadows_Flag		= 1;
			raytraceFlags				= (raytraceShadows * raytraceShadows_Flag);

			raytraceReflect				= integer(settingsArray[11]);
			raytraceReflect_Flag		= 2;
			raytraceFlags				+= (raytraceReflect * raytraceReflect_Flag);

			raytraceRefract				= integer(settingsArray[12]);
			raytraceRefract_Flag		= 4;
			raytraceFlags				+= (raytraceRefract * raytraceRefract_Flag);

			raytraceTrans				= integer(settingsArray[13]);
			raytraceTrans_Flag			= 8;
			raytraceFlags				+= (raytraceTrans * raytraceTrans_Flag);

			raytraceOccl				= integer(settingsArray[14]);
			raytraceOccl_Flag			= 16;
			raytraceFlags				+= (raytraceOccl * raytraceOccl_Flag);
			
     		writeOverrideString(updatedCurrentScenePath, newScenePath, "RayTraceEffects ", raytraceFlags);

   			volumetricAA = integer(settingsArray[15]);
     		writeOverrideString(updatedCurrentScenePath, newScenePath, "VolumetricAA ", volumetricAA);

   			gLensFlares = integer(settingsArray[16]);
     		writeOverrideString(updatedCurrentScenePath, newScenePath, "EnableLensFlares ", gLensFlares);

   			shadowMaps = integer(settingsArray[17]);
     		writeOverrideString(updatedCurrentScenePath, newScenePath, "EnableShadowMaps ", shadowMaps);
  
   			volLights = integer(settingsArray[18]);
     		writeOverrideString(updatedCurrentScenePath, newScenePath, "EnableVolumetricLights ", volLights);

   			twoSidedALgts = integer(settingsArray[19]);
     		writeOverrideString(updatedCurrentScenePath, newScenePath, "DoubleSidedAreaLights ", twoSidedALgts);

   			renderInstances = integer(settingsArray[20]);
     		writeOverrideString(updatedCurrentScenePath, newScenePath, "RenderInstances ", renderInstances);

   			rayPrecision = number(settingsArray[21]);
     		writeOverrideString(updatedCurrentScenePath, newScenePath, "RayPrecision ", rayPrecision);

   			rayCutoff = number(settingsArray[22]);
     		writeOverrideString(updatedCurrentScenePath, newScenePath, "RayCutoff ", rayCutoff);

   			shadingSamples = integer(settingsArray[23]);
     		writeOverrideString(updatedCurrentScenePath, newScenePath, "ShadingSamples ", shadingSamples);
  
     		lightSamples = integer(settingsArray[24]);
     		writeOverrideString(updatedCurrentScenePath, newScenePath, "LightSamples ", lightSamples);

     		gLightIntensity = number(settingsArray[25]);
     		writeOverrideString(updatedCurrentScenePath, newScenePath, "GlobalLightIntensity ", gLightIntensity);

     		gFlareIntensity = number(settingsArray[26]);
     		writeOverrideString(updatedCurrentScenePath, newScenePath, "GlobalFlareIntensity ", gFlareIntensity);

     		enableGI = number(settingsArray[27]);
     		writeOverrideString(updatedCurrentScenePath, newScenePath, "EnableRadiosity ", enableGI);

     		giMode = integer(settingsArray[28]);
     		giMode = giMode - 1; // decrement by one to match index in LW. Menus are 1-indexed.
     		writeOverrideString(updatedCurrentScenePath, newScenePath, "RadiosityType ", giMode);

     		interpolateGI = integer(settingsArray[29]);
     		writeOverrideString(updatedCurrentScenePath, newScenePath, "RadiosityInterpolated ", interpolateGI);

     		blurBGGI = integer(settingsArray[30]);
     		writeOverrideString(updatedCurrentScenePath, newScenePath, "BlurRadiosity ", blurBGGI);
 
      		transparencyGI = integer(settingsArray[31]);
     		writeOverrideString(updatedCurrentScenePath, newScenePath, "RadiosityTransparency ", transparencyGI);

      		volumetricGI = integer(settingsArray[32]);
     		writeOverrideString(updatedCurrentScenePath, newScenePath, "VolumetricRadiosity ", volumetricGI);

      		ambOcclGI = integer(settingsArray[33]);
     		writeOverrideString(updatedCurrentScenePath, newScenePath, "RadiosityUseAmbient ", ambOcclGI);

      		directionalGI = integer(settingsArray[34]);
     		writeOverrideString(updatedCurrentScenePath, newScenePath, "RadiosityDirectionalRays ", directionalGI);

      		gradientsGI = integer(settingsArray[35]);
     		writeOverrideString(updatedCurrentScenePath, newScenePath, "RadiosityUseGradients ", gradientsGI);

      		behindTestGI = integer(settingsArray[36]);
     		writeOverrideString(updatedCurrentScenePath, newScenePath, "RadiosityUseBehindTest ", behindTestGI);

      		useBumpsGI = integer(settingsArray[37]);
      		useBumpsGI = useBumpsGI * (-2147483648);
     		writeOverrideString(updatedCurrentScenePath, newScenePath, "RadiosityFlags ", useBumpsGI);

      		giIntensity = integer(settingsArray[38]);
     		writeOverrideString(updatedCurrentScenePath, newScenePath, "RadiosityIntensity ", giIntensity);

      		giAngTol = integer(settingsArray[39]);
     		writeOverrideString(updatedCurrentScenePath, newScenePath, "RadiosityTolerance ", giAngTol);

      		giIndBounces = integer(settingsArray[40]);
     		writeOverrideString(updatedCurrentScenePath, newScenePath, "IndirectBounces ", giIndBounces);
            
            giMinSpacing = number(settingsArray[41]);
     		writeOverrideString(updatedCurrentScenePath, newScenePath, "RadiosityMinPixelSpacing ", giMinSpacing);

            giRPE = number(settingsArray[42]);
     		writeOverrideString(updatedCurrentScenePath, newScenePath, "RadiosityRays ", giRPE);

            giMaxSpacing = number(settingsArray[43]);
     		writeOverrideString(updatedCurrentScenePath, newScenePath, "RadiosityMaxPixelSpacing ", giMaxSpacing);

            gi2ndBounces = integer(settingsArray[44]);
     		writeOverrideString(updatedCurrentScenePath, newScenePath, "SecondaryBounceRays ", gi2ndBounces);

            giMultiplier = number(settingsArray[45]);
     		writeOverrideString(updatedCurrentScenePath, newScenePath, "RadiosityMultiplier ", giMultiplier);

            enableCaustics = number(settingsArray[46]);
     		writeOverrideString(updatedCurrentScenePath, newScenePath, "EnableCaustics ", enableCaustics);

            causticsAccuracy = integer(settingsArray[47]);
     		writeOverrideString(updatedCurrentScenePath, newScenePath, "CausticAccuracy ", causticsAccuracy);

            causticsIntensity = number(settingsArray[48]);
     		writeOverrideString(updatedCurrentScenePath, newScenePath, "CausticIntensity ", causticsIntensity);

            causticsSoftness = number(settingsArray[49]);
     		writeOverrideString(updatedCurrentScenePath, newScenePath, "CausticSoftness ", causticsSoftness);
                                   
			// FIXME : Move to camera override.
			disableAASetts = integer(settingsArray[9]);
			if(disableAASetts == 1)
				disableAASetts = 0;
     		writeOverrideString(updatedCurrentScenePath, newScenePath, "Antialiasing ", disableAASetts);

     		writeOverrideString(updatedCurrentScenePath, newScenePath, "AntiAliasingLevel ", "-1");
            
			finishFiles();

	        // deal with the buffer savers now.
	        handleBuffers(updatedCurrentScenePath);
        }
    }
    
	// and as a tack-on fix, replace motion-mixer stuff for overridden objects
	motionMixerStuff(updatedCurrentScenePath);

    // and the test frame resolution multiplier stuff
    switch(testResMultiplier)
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
	finishFiles();
	filedelete(updatedCurrentScenePath);

    return(newScenePath);
} // generatePass

generatePath: mode, outputFolder, outputStr, fileOutputPrefix, userOutputString, passNames, baseName
{
	genPath = outputFolder + getsep() + "CG" + getsep();
	if (mode == "LWO" || "frame")
	{
		genPath = genPath + "temp" + getsep();
	}
	if (mode == "LWO")
	{
		genPath = genPath + getsep() + "tempScenes" + getsep() + "tempObjects" + getsep();
	}

	genPath = genPath + outputStr + "_" + fileOutputPrefix + "_" + userOutputString + "_" + passNames[pass] + baseName;
    return genPath;
}

handleBuffers: hbFile
{
	inputFileName = prepareInputFile(hbFile);
	inputFile = File(inputFileName, "r");
	tempOutput = File(newScenePath,"w");
	if(redirectBuffersSetts == 1)
	{
		while(!inputFile.eof())
		{
			line = inputFile.read();
			if(size(line) > 26)
			{
				if(strleft(line,26) == "Plugin ImageFilterHandler ")
				{
					// the stock render buffer exporter
						bufferTestLineParse = parse(" ",line);
						if(bufferTestLineParse[4] == "LW_SpecialBuffers")
						{
							tempOutput.writeln(line);
							line = inputFile.read();
							tempOutput.writeln(line);
							line = inputFile.read();
							if(line == "0")
							{
								tempOutput.writeln(line);
								line = inputFile.read();
								baseNameArray = parse(getsep(),line);
								if(baseNameArray[size(baseNameArray)] != nil && baseNameArray[size(baseNameArray)] != "")
								{
									bufferBaseName = baseNameArray[size(baseNameArray)];
									updatedBufferSaverPath = "\"" + generatePath(mode, outputFolder[1], outputStr, fileOutputPrefix, userOutputString, passNames[pass], bufferBaseName);

									if(platform() == INTEL)
									{
										tempFixedPath = fixPathForWin32(updatedBufferSaverPath);
										newPathFixed = tempFixedPath;
										toWrite = newPathFixed;
									}
									else
									{
										toWrite = updatedBufferSaverPath;
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
						}
					// end of the stock render buffer exporter
					
					// the psd exporter
						if(bufferTestLineParse[4] == "LW_PSDExport")
						{
							tempOutput.writeln(line);
							line = inputFile.read();
							tempOutput.writeln(line);
							line = inputFile.read();
							if(strleft(line,5) == "Path ")
							{
								baseNameArray = parse(getsep(),line);
								if(baseNameArray[size(baseNameArray)] != nil && baseNameArray[size(baseNameArray)] != "")
								{
									psdBaseName = baseNameArray[size(baseNameArray)];
									updatedPsdSaverPath = "Path \"" + generatePath(mode, outputFolder[1], outputStr, fileOutputPrefix, userOutputString, passNames[pass], psdBaseName);

									if(platform() == INTEL)
									{
										noIntroPath = "\"" + generatePath(mode, outputFolder[1], outputStr, fileOutputPrefix, userOutputString, passNames[pass], psdBaseName);
										tempFixedPath = fixPathForWin32(noIntroPath);
										noIntroPath = tempFixedPath;
										newPathFixed = "Path " + noIntroPath;
		
										toWrite = newPathFixed;
									}
									else
									{
										toWrite = updatedPsdSaverPath;
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
						}
					// end of the psd exporter
					
					// the rla exporter
						if(bufferTestLineParse[4] == "LW_ExtendedRLAExport")
						{
							tempOutput.writeln(line);
							line = inputFile.read();
							tempOutput.writeln(line);
							line = inputFile.read();
							if(strleft(line,1) != "")
							{
								baseNameArray = parse(getsep(),line);
								if(baseNameArray[size(baseNameArray)] != nil && baseNameArray[size(baseNameArray)] != "")
								{
									rlaBaseName = baseNameArray[size(baseNameArray)];
									updatedRlaSaverPath = generatePath(mode, outputFolder[1], outputStr, fileOutputPrefix, userOutputString, passNames[pass], rlaBaseName);
									toWrite = updatedRlaSaverPath;
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
						}
					// end of the rla exporter
					
					// the rpf exporter
						if(bufferTestLineParse[4] == "LW_ExtendedRPFExport")
						{
							tempOutput.writeln(line);
							line = inputFile.read();
							tempOutput.writeln(line);
							line = inputFile.read();
							if(strleft(line,1) != "")
							{
								baseNameArray = parse(getsep(),line);
								if(baseNameArray[size(baseNameArray)] != nil && baseNameArray[size(baseNameArray)] != "")
								{
									rpfBaseName = baseNameArray[size(baseNameArray)];
									updatedRpfSaverPath = "\"" + generatePath(mode, outputFolder[1], outputStr, fileOutputPrefix, userOutputString, passNames[pass], rpfBaseName);
									toWrite = updatedRpfSaverPath;
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
						}
					// end of the rpf exporter
					
					// the aura exporter
						if(bufferTestLineParse[4] == "Aura25Export")
						{
							tempOutput.writeln(line);
							line = inputFile.read();
							tempOutput.writeln(line);
							line = inputFile.read();
							if(strleft(line,1) == "\"")
							{
								baseNameArray = parse(getsep(),line);
								if(baseNameArray[size(baseNameArray)] != nil && baseNameArray[size(baseNameArray)] != "")
								{
									auraBaseName = baseNameArray[size(baseNameArray)];
									updatedAuraSaverPath = "\"" + generatePath(mode, outputFolder[1], outputStr, fileOutputPrefix, userOutputString, passNames[pass], auraBaseName);
									toWrite = updatedAuraSaverPath;
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
						}
					// end of the aura exporter
					
					// idof channels
						if(bufferTestLineParse[4] == "iDof_channels_IF")
						{
							tempOutput.writeln(line);
							line = inputFile.read();
							tempOutput.writeln(line);
							line = inputFile.read();
							tempOutput.writeln(line);
							line = inputFile.read();
							tempOutput.writeln(line);
							line = inputFile.read();
							tempOutput.writeln(line);
							line = inputFile.read();
							tempOutput.writeln(line);
							line = inputFile.read();
							tempOutput.writeln(line);
							line = inputFile.read();
							tempOutput.writeln(line);
							line = inputFile.read();
							tempOutput.writeln(line);
							line = inputFile.read();
							if(strleft(line,1) != "")
							{
								baseNameArray = parse(getsep(),line);
								if(baseNameArray[size(baseNameArray)] != nil && baseNameArray[size(baseNameArray)] != "")
								{
									idofBaseName = baseNameArray[size(baseNameArray)];
									updatedIdofSaverPath = generatePath(mode, outputFolder[1], outputStr, fileOutputPrefix, userOutputString, passNames[pass], idofBaseName);
									toWrite = updatedIdofSaverPath;
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
						}                               
					// end of idof channels
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
		
		inputFile.close();
		tempOutput.close();
		finishFiles();
	}
}

motionMixerStuff: mmFile
{
	if(overriddenObjectID != nil)
	{
		// check for clones of motion mixer items
		clonedMMItems = false;
		for(x = 1; x <= size(overriddenObjectID); x++)
		{
			for(y = 1; y <= size(overriddenObjectID); y++)
			{
				if(x != y && overriddenObjectID[x] == overriddenObjectID[y])
				{
					clonedMMItems = true;
				}
			}
		}
		
		for(x = 1; x <= size(overriddenObjectID); x++)
		{
			inputFileName = prepareInputFile(mmFile);
			inputFile = File(inputFileName, "r");
			tempOutput = File(newScenePath,"w");
			
			inputFile.line(1);
			
			mmItemIDLine = nil;
			// find the line in the motion mixer stuff if it exists...
			while(!inputFile.eof())
			{
				line = inputFile.read();
				if(size(line) >= 22)
				{
					stringTempAdd = "      ItemAdd " + string(overriddenObjectID[x]);
					if(strleft(line,22) == stringTempAdd)
					{
						mmItemIDLine = inputFile.line();
						//info(stringTempAdd);
					}
				}
			}

			// if the item line exists in the motion mixer stuff, read the line before it to get the object name
			if(mmItemIDLine != nil)
			{
				if(clonedMMItems == true)
				{
					error("PassPort has found clones being overridden in a scene with Motion Mixer.  Please resolve clone naming.");
				}
				
				inputFile.line(mmItemIDLine - 2);
				mmItemToReplace = inputFile.read();
				mmItemStringArray = parse("\"",mmItemToReplace);
				mmItemString = mmItemStringArray[2];
				
				checkForLayers = parse(":",mmItemString);
				if(size(checkForLayers) > 1)
				{
					nameOfObject = checkForLayers[1];
				}
				else
				{
					nameOfObject = mmItemString;
				}
				
				replaceStringOne = "      ItemName \"" + nameOfObject;
				replaceStringTwo = "          ItemName \"" + nameOfObject;
				replaceStringThree = "            ChannelName \"" + nameOfObject;
				replaceStringFour = "              TrackMotionItemName \"" + nameOfObject;
				
				replacementStringOne = "      ItemName \"" + overriddenObjectName[x];
				replacementStringTwo = "          ItemName \"" + overriddenObjectName[x];
				replacementStringThree = "            ChannelName \"" + overriddenObjectName[x];
				replacementStringFour = "              TrackMotionItemName \"" + overriddenObjectName[x];
				
				inputFile.line(1);
				
				while(!inputFile.eof())
				{
					line = inputFile.read();
					linesize = size(line);
					stringsize = size(replaceStringOne);
					if(linesize >= stringsize)
					{
						if(strleft(line,size(replaceStringOne)) == replaceStringOne)
						{
							n = size(line) - size(replaceStringOne);
							lineTemp = replacementStringOne + strright(line,n);
							line = lineTemp;
						}
					}
					tempOutput.writeln(line);
				}
				
				inputFile.close();
				tempOutput.close();
				finishFiles();

				inputFileName = prepareInputFile(mmFile);
				inputFile = File(inputFileName, "r");
				tempOutput = File(newScenePath,"w");
				
				inputFile.line(1);
				
				while(!inputFile.eof())
				{
					line = inputFile.read();
					if(size(line) > size(replaceStringTwo))
					{
						if(strleft(line,size(replaceStringTwo)) == replaceStringTwo)
						{
							n = size(line) - size(replaceStringTwo);
							lineTemp = replacementStringTwo + strright(line,n);
							line = lineTemp;
						}
					}
					tempOutput.writeln(line);
				}
				inputFile.close();
				tempOutput.close();
				
				inputFile.close();
				tempOutput.close();
				finishFiles();

				inputFileName = prepareInputFile(mmFile);
				inputFile = File(inputFileName, "r");
				tempOutput = File(newScenePath,"w");
				
				inputFile.line(1);
				
				while(!inputFile.eof())
				{
					line = inputFile.read();
					if(size(line) > size(replaceStringThree))
					{
						if(strleft(line,size(replaceStringThree)) == replaceStringThree)
						{
							n = size(line) - size(replaceStringThree);
							lineTemp = replacementStringThree + strright(line,n);
							line = lineTemp;
						}
					}
					tempOutput.writeln(line);
				}
				inputFile.close();
				tempOutput.close();
				finishFiles();

				inputFileName = prepareInputFile(mmFile);
				inputFile = File(inputFileName, "r");
				tempOutput = File(newScenePath,"w");
				
				inputFile.line(1);
				
				while(!inputFile.eof())
				{
					line = inputFile.read();
					if(size(line) > size(replaceStringFour))
					{
						if(strleft(line,size(replaceStringFour)) == replaceStringFour)
						{
							n = size(line) - size(replaceStringFour);
							lineTemp = replacementStringFour + strright(line,n);
							line = lineTemp;
						}
					}
					tempOutput.writeln(line);
				}
				inputFile.close();
				tempOutput.close();
				finishFiles();
			}
			else
			{
				inputFile.close();
				tempOutput.close();
				finishFiles();
			}
			// end of the mm if and else statement here
			// write out the scene, replacing the motion mixer stuff with the object name with the overridden info
		}
	//end of all the mm stuff
	}
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
	// and opt to append it to force the condition.
	if (parameterFound == 0)
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
    tempDirectory = getdir("Temp");	
	tempFileName = tempDirectory + getsep() + "tempPassportInputFile.lws";
	filecopy(inputFileName, tempFileName);
	filesPrepared = 1;
	return tempFileName;
}

finishFiles
{
	if(filesPrepared == 0)
		error("Internal error - finishFiles() already called.");
    tempDirectory = getdir("Temp");	
	tempFileName = tempDirectory + getsep() + "tempPassportInputFile.lws";
	filedelete(tempFileName);
	filesPrepared = 0;
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
