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

    noOfStages = 4; // drives progress value - currently parse, object, light and render stages.

    // initial stuff
    overriddenObjectID = nil;
    overriddenObjectName = nil;
    lastObject = 0;
    lastLight = 0;
    lastCamera = 0;
    contentDirectory = getdir("Content");
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
	
    for(passItem = 1; passItem <= size(setItems); passItem++)
    {
        progressString = string((passItem / size(setItems)) / noOfStages);
        msgString = "{" + progressString + "}Generating Render Scene:  Cataloging Items and Overrides...";
        StatusMsg(msgString);
        sleep(1);

        // first the object lines
        tempNumber = setItems[passItem];
        tempObjectNames[passItem] = displayNames[tempNumber];
        assignmentsArray = checkForOverrideAssignments(displayIDs[tempNumber], pass);
    
        if(assignmentsArray != nil)
        {
            doOverride[passItem] = 1;
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
				doOverride[passItem] = 0;
				overrideType[passItem] = 0;
			}
			
            if(settingsArray[2] == "type5")
            {
                overrideType[passItem] = 5;
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
                    LensFlareLine = "LensFlare 0\n";
                }
                else
                {
                    LensFlareLine = "LensFlare 1\n";
                }
                if(settingsArray[10] == "0")
                {
                    VolumetricsLine = "VolumetricLighting 0\n";
                }
                else
                {
                    VolumetricsLine = "VolumetricLighting 1\n";
                }
                
                lightSettingsPartOne[passItem] = lightColorLine + lightIntensityLine + affectDiffuseLine + affectSpecularLine;
                lightSettingsPartTwo[passItem] = LensFlareLine;
                lightSettingsPartThree[passItem] = VolumetricsLine;
                
                motInputTemp[passItem] = nil;
                lwoInputTemp[passItem] = nil;
                srfLWOInputID[passItem] = nil;
                srfInputTemp[passItem] = nil;
                objPropOverrideSets[passItem] = nil;
                objPropOverrideShadowOpts[passItem] = nil;
                cameraSettingsPartOne[passItem] = nil;
                cameraSettingsPartTwo[passItem] = nil;
                cameraSettingsPartThree[passItem]= nil;

            }

            if(settingsArray[2] == "type1")
            {
                overrideType[passItem] = 1;
                motInputTemp[passItem] = nil;
                lwoInputTemp[passItem] = nil;
                srfLWOInputID[passItem] = displayIDs[tempNumber];
                srfInputTemp[passItem] = settingsArray[3];
                objPropOverrideSets[passItem] = nil;
                objPropOverrideShadowOpts[passItem] = nil;
                lightSettingsPartOne[passItem] = nil;
                lightSettingsPartTwo[passItem] = nil;
                lightSettingsPartThree[passItem] = nil;
                cameraSettingsPartOne[passItem] = nil;
                cameraSettingsPartTwo[passItem] = nil;
                cameraSettingsPartThree[passItem]= nil;

            }   

            if(settingsArray[2] == "type4")
            {
                overrideType[passItem] = 4;
                motInputTemp[passItem] = nil;
                lwoInputTemp[passItem] = settingsArray[3];
                srfLWOInputID[passItem] = nil;
                srfInputTemp[passItem] = nil;
                objPropOverrideSets[passItem] = nil;
                objPropOverrideShadowOpts[passItem] = nil;
                lightSettingsPartOne[passItem] = nil;
                lightSettingsPartTwo[passItem] = nil;
                lightSettingsPartThree[passItem] = nil;
                cameraSettingsPartOne[passItem] = nil;
                cameraSettingsPartTwo[passItem] = nil;
                cameraSettingsPartThree[passItem]= nil;
            }   

            if(settingsArray[2] == "type3")
            {
                overrideType[passItem] = 3;
                motInputTemp[passItem] = File(settingsArray[3],"r");
                lwoInputTemp[passItem] = nil;
                srfLWOInputID[passItem] = nil;
                srfInputTemp[passItem] = nil;
                objPropOverrideSets[passItem] = nil;
                objPropOverrideShadowOpts[passItem] = nil;
                lightSettingsPartOne[passItem] = nil;
                lightSettingsPartTwo[passItem] = nil;
                lightSettingsPartThree[passItem] = nil;
                cameraSettingsPartOne[passItem] = nil;
                cameraSettingsPartTwo[passItem] = nil;
                cameraSettingsPartThree[passItem]= nil;
            }

            if(settingsArray[2] == "type2")
            {
                overrideType[passItem] = 2;
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
				motInputTemp[passItem] = nil;
                lwoInputTemp[passItem] = nil;
                srfLWOInputID[passItem] = nil;
                srfInputTemp[passItem] = nil;
                objPropOverrideSets[passItem] = matteObjectLine + unseenByFogLine + unseenByRadiosityLine + unseenByRaysLine + unseenByCameraLine + alphaLine;
                objPropOverrideShadowOpts[passItem] = shadowOptionsLine;
                lightSettingsPartOne[passItem] = nil;
                lightSettingsPartTwo[passItem] = nil;
                lightSettingsPartThree[passItem] = nil;
                cameraSettingsPartOne[passItem] = nil;
                cameraSettingsPartTwo[passItem] = nil;
                cameraSettingsPartThree[passItem]= nil;
            }

            if(settingsArray[2] == "type7")
            {
                overrideType[passItem] = 7;
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
                    lightExclusion[passItem] = nil;
                    doneRad = 0;
                    doneCaus = 0;                   
                    for(k = 1; k <= size(lightNames); k++)
                    {
                        for(m = 1; m <= size(excludedLightNames); m++)
                        {
                            if(lightNames[k] == excludedLightNames[m])
                            {
                                tempID = lightOldIDs[k];
                                lightExclusion[passItem] = string(lightExclusion[passItem]) + "ExcludeLight " + string(tempID) + "\n";
                            }
                            else
                            {
                                if(excludedLightNames[m] == "Radiosity")
                                {
                                    if(doneRad == 0)
                                    {
                                        lightExclusion[passItem] = string(lightExclusion[passItem]) + "ExcludeLight 21000000\n";
                                        doneRad = 1;
                                    }
                                }
                                else
                                {
                                    if(excludedLightNames[m] == "Caustics")
                                    {
                                        if(doneCaus == 0)
                                        {
                                            lightExclusion[passItem] = string(lightExclusion[passItem]) + "ExcludeLight 22000000\n";
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
                    lightExclusion[passItem] = nil;
                }
                
                motInputTemp[passItem] = nil;
                lwoInputTemp[passItem] = nil;
                srfLWOInputID[passItem] = nil;
                srfInputTemp[passItem] = nil;
                objPropOverrideSets[passItem] = nil;
                objPropOverrideShadowOpts[passItem] = nil;
                lightSettingsPartOne[passItem] = nil;
                lightSettingsPartTwo[passItem] = nil;
                lightSettingsPartThree[passItem] = nil;
                cameraSettingsPartOne[passItem] = nil;
                cameraSettingsPartTwo[passItem] = nil;
                cameraSettingsPartThree[passItem]= nil;
            }

            if(settingsArray[2] == "type8") // EXPERIMENTAL Camera override
            {
                zoomFactor 						= string(settingsArray[3]);
                cameraSettingsPartOne[passItem] =	"ZoomFactor " + zoomFactor + "\n";
				zoomType 						= string(settingsArray[4]);
                cameraSettingsPartOne[passItem] +=	"ZoomType " + zoomType + "\n";
				resolutionMultiplier 			= string(settingsArray[5]);
                cameraSettingsPartOne[passItem] +=	"ResolutionMultiplier " + resolutionMultiplier + "\n";
				frameSizeH 						= string(settingsArray[6]);
				frameSizeV 						= string(settingsArray[7]);
                cameraSettingsPartOne[passItem] +=	"FrameSize " + frameSizeH + " " + frameSizeV + "\n";
				pixelAspect 					= string(settingsArray[8]);
                cameraSettingsPartOne[passItem] +=	"PixelAspect " + pixelAspect + "\n";
				motionBlur 						= string(settingsArray[9]);
                cameraSettingsPartOne[passItem] +=	"MotionBlur " + motionBlur + "\n";
				motionBlurPasses 				= string(settingsArray[10]);
                cameraSettingsPartOne[passItem] +=	"MotionBlurPasses " + motionBlurPasses + "\n";
				shutterEfficiency 				= string(settingsArray[11]);
                cameraSettingsPartOne[passItem] +=	"ShutterEfficiency " + shutterEfficiency + "\n";
				rollingShutter 					= string(settingsArray[12]);
                cameraSettingsPartOne[passItem] +=	"RollingShutter " + rollingShutter + "\n";
				shutterOpen 					= string(settingsArray[13]);
                cameraSettingsPartOne[passItem] +=	"ShutterOpen " + shutterOpen + "\n";
				oversampling 					= string(settingsArray[14]);
                cameraSettingsPartOne[passItem] +=	"Oversampling " + oversampling + "\n";
				// UndockPreview 0
				fieldRendering 					= string(settingsArray[15]);
                cameraSettingsPartTwo[passItem] +=	"FieldRendering " + fieldRendering + "\n";
				apertureHeight 					= string(settingsArray[16]);
                cameraSettingsPartTwo[passItem] +=	"ApertureHeight " + apertureHeight + "\n";
				eyeSeparation 					= string(settingsArray[17]);
                cameraSettingsPartTwo[passItem] +=	"EyeSeparation " + eyeSeparation + "\n";
				convergencePoint 				= string(settingsArray[18]);
                cameraSettingsPartTwo[passItem] +=	"ConvergencePoint " + convergencePoint + "\n";
				useConvergence 					= string(settingsArray[19]);
                cameraSettingsPartTwo[passItem] +=	"UseConvergence " + useConvergence + "\n";
				// AnaglyphOpenGL 1
				convergenceToeIn 					= string(settingsArray[20]);
                cameraSettingsPartThree[passItem] 	+=	"ConvergenceToeIn " + convergenceToeIn + "\n";
				depthOfField 						= string(settingsArray[21]);
                cameraSettingsPartThree[passItem] 	+=	"DepthOfField " + depthOfField + "\n";
				focalDistance 						= string(settingsArray[22]);
                cameraSettingsPartThree[passItem] 	+=	"FocalDistance " + focalDistance + "\n";
				lensFStop 							= string(settingsArray[23]);
                cameraSettingsPartThree[passItem] 	+=	"LensFStop " + lensFStop + "\n";
				diaphragmSides 						= string(settingsArray[24]);
                cameraSettingsPartThree[passItem] 	+=	"DiaphragmSides " + diaphragmSides + "\n";
				diaphragmRotation 					= string(settingsArray[25]);
                cameraSettingsPartThree[passItem] 	+=	"DiaphragmRotation " + diaphragmRotation + "\n";
				aASamples 							= string(settingsArray[26]);
                cameraSettingsPartThree[passItem] 	+=	"AASamples " + aASamples + "\n";
				sampler 							= string(settingsArray[27]);
                cameraSettingsPartThree[passItem] 	+=	"Sampler " + sampler + "\n";
				adaptiveThreshold 					= string(settingsArray[28]);
                cameraSettingsPartThree[passItem] 	+=	"AdaptiveThreshold " + adaptiveThreshold + "\n";
				minimumSamples 						= string(settingsArray[29]);
                cameraSettingsPartThree[passItem] 	+=	"MinimumSamples " + minimumSamples + "\n";
				maximumSamples 						= string(settingsArray[30]);
                cameraSettingsPartThree[passItem] 	+=	"MaximumSamples " + maximumSamples + "\n";

                overrideType[passItem] = 8;
                motInputTemp[passItem] = nil;
                lwoInputTemp[passItem] = nil;
                srfLWOInputID[passItem] = nil;
                srfInputTemp[passItem] = nil;
                objPropOverrideSets[passItem] = nil;
                objPropOverrideShadowOpts[passItem] = nil;
                lightSettingsPartOne[passItem] = nil;
                lightSettingsPartTwo[passItem] = nil;
                lightSettingsPartThree[passItem] = nil;
            }

            if(assignmentsArray != nil && size(assignmentsArray) > 1)
            {
                if(secondSettingsArray[2] == "type7")
                {
                    secondOverrideType[passItem] = 7;
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
                        lightExclusion[passItem] = nil;
                        doneRad = 0;
                        doneCaus = 0;                   
                        for(k = 1; k <= size(lightNames); k++)
                        {
                            for(m = 1; m <= size(excludedLightNames); m++)
                            {
                                if(lightNames[k] == excludedLightNames[m])
                                {
                                    tempID = lightOldIDs[k];
                                    lightExclusion[passItem] = string(lightExclusion[passItem]) + "ExcludeLight " + string(tempID) + "\n";
                                }
                                else
                                {
                                    if(excludedLightNames[m] == "Radiosity")
                                    {
                                        if(doneRad == 0)
                                        {
                                            lightExclusion[passItem] = string(lightExclusion[passItem]) + "ExcludeLight 21000000\n";
                                            doneRad = 1;
                                        }
                                    }
                                    else
                                    {
                                        if(excludedLightNames[m] == "Caustics")
                                        {
                                            if(doneCaus == 0)
                                            {
                                                lightExclusion[passItem] = string(lightExclusion[passItem]) + "ExcludeLight 22000000\n";
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
                        lightExclusion[passItem] = nil;
                    }
                    
                    //tempIDArray = parse("x",hex(number(secondSettingsArray[4])));
                    //lightExclusion[passItem] = "ExcludeLight " + tempIDArray[2] + "\n";
                }
                else
                {
                    secondOverrideType[passItem] = nil;
                }
            }
            else
            {
                secondOverrideType[passItem] = nil;
            }
            
        }
        else
        {
			doOverride[passItem] = 0;
            overrideType[passItem] = 0;
        }
        if(size(doOverride) < passItem)
        {
            doOverride[passItem] = 0;
        }
        if(overrideType == nil || size(overrideType) < passItem)
        {
			errorString = "An internal error has been detected: overrideType is: " + overrideType;
			info(errorString);
			errorString = "Will render a full pass of type '" + mode + "' instead. Sorry.";
			info(errorString);
			doOverride[passItem] = 0;
            overrideType[passItem] = 0;
        }
        
        if(strleft(string(displayOldIDs[tempNumber]),1) == string(MESH))
        {
            objStart[passItem] = getObjectLines(passEditorEndLine + 1,0,displayOldIDs[tempNumber],currentScenePath);
            objStartTemp = number(objStart[passItem]);
            objStartPlusOne = objStartTemp + 1;
            objEnd[passItem] = getObjectEndLine(objStartPlusOne,0,displayOldIDs[tempNumber],currentScenePath);
            objMotStart[passItem] = getPartialLine(objStart[passItem],objEnd[passItem],"NumChannels",currentScenePath);
            numberOfChannels = integer(strright(readSpecificLine(objMotStart[passItem],currentScenePath),1));
            objMotEnd[passItem] = objMotStart[passItem];
            for(b = 1; b <= numberOfChannels; b++)
            {
                objMotEnd[passItem] = getPartialLine((objMotEnd[passItem] + 1),objEnd[passItem],"}",currentScenePath);
            }
            lastObject = passItem;
        }

        // then the light lines
        if(strleft(string(displayOldIDs[tempNumber]),1) == string(LIGHT))
        {
            objStart[passItem] = getLightLines(passEditorEndLine + 1,0,displayOldIDs[tempNumber],currentScenePath);
            objStartTemp = number(objStart[passItem]);
            objStartPlusOne = objStartTemp + 1;
            objEnd[passItem] = getLightEndLine(objStartPlusOne,0,displayOldIDs[tempNumber],currentScenePath);
            objMotStart[passItem] = getPartialLine(objStart[passItem],objEnd[passItem],"NumChannels",currentScenePath);
            numberOfChannels = integer(strright(readSpecificLine(objMotStart[passItem],currentScenePath),1));
            objMotEnd[passItem] = objMotStart[passItem];
            for(b = 1; b <= numberOfChannels; b++)
            {
                objMotEnd[passItem] = getPartialLine((objMotEnd[passItem] + 1),objEnd[passItem],"}",currentScenePath);
            }
            objPathAlignReliableDistLine[passItem] = getPartialLine(objStart[passItem],objEnd[passItem],"PathAlignReliableDist",currentScenePath);
            if(getPartialLine(objStart[passItem],objEnd[passItem],"AffectCaustics",currentScenePath) > 0)
            {
                objAffectCausticsLine[passItem] = getPartialLine(objStart[passItem],objEnd[passItem],"AffectCaustics",currentScenePath);
            }
            else
            {
                objAffectCausticsLine[passItem] = nil;
            }
            objLightTypeLine[passItem] = getPartialLine(objStart[passItem],objEnd[passItem],"LightType ",currentScenePath);
            objLensFlareLine[passItem] = getPartialLine(objStart[passItem],objEnd[passItem],"LensFlare ",currentScenePath);
            objVolLightLine[passItem] = getPartialLine(objStart[passItem],objEnd[passItem],"VolumetricLighting ",currentScenePath);
            lastLight++;
        }
		
        // then the camera lines
        if(strleft(string(displayOldIDs[tempNumber]),1) == string(CAMERA))
        {
            objStart[passItem] = getCameraLines(passEditorEndLine + 1,0,displayOldIDs[tempNumber],currentScenePath);
            objStartTemp = number(objStart[passItem]);
            objStartPlusOne = objStartTemp + 1;
            objEnd[passItem] = getCameraEndLine(objStartPlusOne,0,displayOldIDs[tempNumber],currentScenePath);
            objMotStart[passItem] = getPartialLine(objStart[passItem],objEnd[passItem],"NumChannels",currentScenePath);
            numberOfChannels = integer(strright(readSpecificLine(objMotStart[passItem],currentScenePath),1));
            objMotEnd[passItem] = objMotStart[passItem];
            for(b = 1; b <= numberOfChannels; b++)
            {
                objMotEnd[passItem] = getPartialLine((objMotEnd[passItem] + 1),objEnd[passItem],"}",currentScenePath);
            }
            lastCamera++;
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
                for(hvCount = 2; hvCount <= integer(hvObjectTotal); hvCount++)
                {
                    xMinusOne = hvCount - 1;
                    linePlusOne = hvObjectLine[xMinusOne] + 1;
                    hvObjectLine[hvCount] = getPartialLine(linePlusOne,0,"  { HVObject",currentScenePath);
                    hvObjectEndLineTemp = getPartialLine(hvObjectLine[hvCount],0,"    { HVoxelCache",currentScenePath);
                    hvObjectEndLine[hvCount] = hvObjectEndLineTemp + 5;

                }
            }

            inputTemp = File(currentScenePath,"r");
            for(hvCount = 1; hvCount <= integer(hvObjectTotal); hvCount++)
            {
                lineTempNumber = hvObjectLine[hvCount] + 2;
                inputTemp.line(lineTempNumber);
                hvObjectNameTemp = inputTemp.read();
                tempNameArray = parse("\"",hvObjectNameTemp);
                hvObjectName[hvCount] = tempNameArray[2];
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

    if(platform() == INTEL)
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
        for(objectCounter = 1; objectCounter <= lastObject; objectCounter++)
        {
            progressString = string(((objectCounter/size(lastObject))/4) + (1 / noOfStages));
            msgString = "{" + progressString + "}Generating Render Scene:  Writing Objects...";
            StatusMsg(msgString);
            sleep(1);
            
            if(doOverride[objectCounter] == 1)
            {
                switch(overrideType[objectCounter])
                {
                    case 1:
                        // begin case 1 here, which is the surface type
                        if(srfInputTemp[objectCounter] != nil && srfLWOInputID[objectCounter] != nil)
                        {
                            surfacedLWO = generateSurfaceObjects(pass,srfLWOInputID[objectCounter],srfInputTemp[objectCounter],currentScenePath,objStart[objectCounter]);
                            if(surfacedLWO != nil)
                            {
                                inputFile.line(objStart[objectCounter]);
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
                                    if(inputFile.line() == (objEnd[objectCounter] - 2))
                                    {
                                        done = true;
                                        break;
                                    }
                                }
                                inputFile.line(objEnd[objectCounter] - 2);
                                line = inputFile.read();
                                outputFile.writeln(line);
                                if(lightExclusion)
                                {
                                    if(lightExclusion[objectCounter] != nil)
                                    {
                                        outputFile.write(lightExclusion[objectCounter]);
                                    }
                                }
    
                                outputFile.writeln("");
                            }
                            else
                            {
                                inputFile.line(objStart[objectCounter]);
                                done = nil;
                                while(!done)
                                {
                                    line = inputFile.read();
                                    outputFile.writeln(line);
                                    if(inputFile.line() == (objEnd[objectCounter] - 2))
                                    {
                                        done = true;
                                        break;
                                    }
                                }
                                inputFile.line(objEnd[objectCounter] - 2);
                                line = inputFile.read();
                                outputFile.writeln(line);
                                if(lightExclusion)
                                {
                                    if(lightExclusion[objectCounter] != nil)
                                    {
                                        outputFile.write(lightExclusion[objectCounter]);
                                    }
                                }
    
                                outputFile.writeln(""); 
                            }   
                            
                        }
                        else
                        {
                            inputFile.line(objStart[objectCounter]);
                            done = nil;
                            while(!done)
                            {
                                line = inputFile.read();
                                outputFile.writeln(line);
                                if(inputFile.line() == (objEnd[objectCounter] - 2))
                                {
                                    done = true;
                                    break;
                                }
                            }
                            inputFile.line(objEnd[objectCounter] - 2);
                            line = inputFile.read();
                            outputFile.writeln(line);
                            if(lightExclusion)
                            {
                                if(lightExclusion[objectCounter] != nil)
                                {
                                    outputFile.write(lightExclusion[objectCounter]);
                                }
                            }

                            outputFile.writeln(""); 
                        }
                        // end case 1 here, which is the surface type
                        break;
                    
                    case 2:
                        // begin case 2 here, which is the object properties override type
                        inputFile.line(objStart[objectCounter]);
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
                                    outputFile.write(objPropOverrideSets[objectCounter]);
                                    outputFile.write(objPropOverrideShadowOpts[objectCounter]);
                                    excludedLightsTemp = 1;
                                }
                            }
                            else
                            {
                                outputFile.writeln(line);
                            }
                            if(inputFile.line() == (objEnd[objectCounter] - 2))
                            {
                                done = true;
                                break;
                            }
                        }
                        if(excludedLightsTemp == 1)
                        {
                            inputFile.line(objEnd[objectCounter] - 2);
                            line = inputFile.read();
                            outputFile.writeln(line);
                            outputFile.writeln("");
                        }
                        else
                        {
                            outputFile.write(objPropOverrideSets[objectCounter]);
                            outputFile.writeln(objPropOverrideShadowOpts[objectCounter]);
                        }
                        if(lightExclusion)
                        {
                            if(lightExclusion[objectCounter] != nil)
                            {
                                outputFile.write(lightExclusion[objectCounter]);
                            }
                        }

                        // end case 2 here, which is the object properties override type
                        break;
                        
                    case 3:
                        // begin case 3 here, which is the motion override type
                        if(motInputTemp[objectCounter] != nil)
                        {
                            inputFile.line(objStart[objectCounter]);
                            done = nil;
                            while(!done)
                            {
                                line = inputFile.read();
                                outputFile.writeln(line);
                                if(inputFile.line() == (objMotStart[objectCounter]))
                                {
                                    done = true;
                                    break;
                                }
                            }
                            motInputTemp[objectCounter].line(4);
                            while(!motInputTemp[objectCounter].eof())
                            {
                                line = motInputTemp[objectCounter].read();
                                outputFile.writeln(line);
                            }
                            inputFile.line(objMotEnd[objectCounter] + 1);
                            done = nil;
                            while(!done)
                            {
                                line = inputFile.read();
                                outputFile.writeln(line);
                                if(inputFile.line() == (objEnd[objectCounter] - 2))
                                {
                                    done = true;
                                    break;
                                }
                            }
                            motInputTemp[objectCounter].close();
                            inputFile.line(objEnd[objectCounter] - 2);
                            line = inputFile.read();
                            outputFile.writeln(line);
                            if(lightExclusion)
                            {
                                if(lightExclusion[objectCounter] != nil)
                                {
                                    outputFile.write(lightExclusion[objectCounter]);
                                }
                            }
                            outputFile.writeln("");
                        }
                        else
                        {
                            inputFile.line(objStart[objectCounter]);
                            done = nil;
                            while(!done)
                            {
                                line = inputFile.read();
                                outputFile.writeln(line);
                                if(inputFile.line() == (objEnd[objectCounter] - 2))
                                {
                                    done = true;
                                    break;
                                }
                            }
                            inputFile.line(objEnd[objectCounter] - 2);
                            line = inputFile.read();
                            outputFile.writeln(line);
                            if(lightExclusion)
                            {
                                if(lightExclusion[objectCounter] != nil)
                                {
                                    outputFile.write(lightExclusion[objectCounter]);
                                }
                            }
                            outputFile.writeln("");
                        }
                        // end case 3 here, which is the motion override type
                        break;
                        
                    case 4:
                        // begin case 4 here, which is the alternate object type
                        if(lwoInputTemp[objectCounter] != nil)
                        {
                            inputFile.line(objStart[objectCounter]);
                            line = inputFile.read();
                            if(line != nil && line != "")
                            {
                                parseObjLineTemp = parse(" ",line);
                                if(parseObjLineTemp[1] == "LoadObjectLayer")
                                {
                                    line = parseObjLineTemp[1] + " 1 " + parseObjLineTemp[3] + " " + lwoInputTemp[objectCounter];
                                    replacedLWO_nameArray = split(lwoInputTemp[objectCounter]);
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
                                if(inputFile.line() == (objEnd[objectCounter] - 2))
                                {
                                    done = true;
                                    break;
                                }
                            }
                            inputFile.line(objEnd[objectCounter] - 2);
                            line = inputFile.read();
                            outputFile.writeln(line);
                            if(lightExclusion)
                            {
                                if(lightExclusion[objectCounter] != nil)
                                {
                                    outputFile.write(lightExclusion[objectCounter]);
                                }
                            }
                            outputFile.writeln(""); 
                            
                        }
                        else
                        {
                            inputFile.line(objStart[objectCounter]);
                            done = nil;
                            while(!done)
                            {
                                line = inputFile.read();
                                outputFile.writeln(line);
                                if(inputFile.line() == (objEnd[objectCounter] - 2))
                                {
                                    done = true;
                                    break;
                                }
                            }
                            inputFile.line(objEnd[objectCounter] - 2);
                            line = inputFile.read();
                            outputFile.writeln(line);
                            if(lightExclusion)
                            {
                                if(lightExclusion[objectCounter] != nil)
                                {
                                    outputFile.write(lightExclusion[objectCounter]);
                                }
                            }
                            outputFile.writeln(""); 
                        }
                        // end case 4 here, which is the alternate object type
                        break;
                        
                    case 7:
                        inputFile.line(objStart[objectCounter]);
                        done = nil;
                        while(!done)
                        {
                            line = inputFile.read();
                            outputFile.writeln(line);
                            if(inputFile.line() == (objEnd[objectCounter] - 2))
                            {
                                done = true;
                                break;
                            }
                        }
                        inputFile.line(objEnd[objectCounter] - 2);
                        line = inputFile.read();
                        outputFile.writeln(line);
                        if(lightExclusion)
                        {
                            if(lightExclusion[objectCounter] != nil)
                            {
                                outputFile.write(lightExclusion[objectCounter]);
                            }
                        }                   
                        outputFile.writeln("");
                        break;
						
                    default:
                        inputFile.line(objStart[objectCounter]);
                        done = nil;
                        while(!done)
                        {
                            line = inputFile.read();
                            outputFile.writeln(line);
                            if(inputFile.line() == (objEnd[objectCounter] - 2))
                            {
                                done = true;
                                break;
                            }
                        }
                        inputFile.line(objEnd[objectCounter] - 2);
                        line = inputFile.read();
                        outputFile.writeln(line);
                        outputFile.writeln("");
                        break;

                // end override type switch statement here
                }
                
            }
            else
            {
                inputFile.line(objStart[objectCounter]);
                done = nil;
                while(!done)
                {
                    line = inputFile.read();
                    outputFile.writeln(line);
                    if(inputFile.line() == (objEnd[objectCounter] - 2))
                    {
                        done = true;
                        break;
                    }
                }
                inputFile.line(objEnd[objectCounter] - 2);
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
    for(lightCounter = lastObject + 1; lightCounter <= lastObject + lastLight; lightCounter++)
    {
        progressString = string(((lightCounter/(lastObject + lastLight))/4) + (2 / noOfStages));
        msgString = "{" + progressString + "}Generating Render Scene:  Writing Lights...";
        StatusMsg(msgString);
        sleep(1);
        
        if(doOverride[lightCounter] == 1)
        {
            switch(overrideType[lightCounter])
            {
                case 5:
                    // begin case 5 here, which is the light properties override type
                    if(lightSettingsPartOne[lightCounter] != nil)
                    {
                        // write out the beginning of the light
                        inputFile.line(objStart[lightCounter]);
                        done = nil;
                        while(!done)
                        {
                            line = inputFile.read();
                            outputFile.writeln(line);
                            if(inputFile.line() == (objPathAlignReliableDistLine[lightCounter]) + 1)
                            {
                                done = true;
                                break;
                            }
                        }
                        
                        // write out the custom parameters
                        outputFile.write(lightSettingsPartOne[lightCounter]);
                        
                        // write out the affect caustics line
                        if(objAffectCausticsLine != nil)
                        {
                            if(objAffectCausticsLine[lightCounter] != nil)
                            {
                                inputFile.line(objAffectCausticsLine[lightCounter]);
                                line = inputFile.read();
                                outputFile.writeln(line);
                            }
                        }
                        
                        // write out the lens flare line.
                        if(objLensFlareLine != nil)
                        {
                            if(objLensFlareLine[lightCounter] != nil)
                            {
								changeScnLine(lightSettingsPartTwo[lightCounter], newScenePath, objLensFlareLine[lightCounter]);
                                inputFile.line(objLensFlareLine[lightCounter]);
                                line = inputFile.read();
                            }
                        }

                        // write out the volumetric line
                        if(objVolLightLine != nil)
                        {
                            if(objVolLightLine[lightCounter] != nil)
                            {
								changeScnLine(lightSettingsPartThree[lightCounter], newScenePath, objVolLightLine[lightCounter]);
                                inputFile.line(objVolLightLine[lightCounter]);
                                line = inputFile.read();
                            }
                        }
                        
                        // write out the rest of the light
                        inputFile.line(objLightTypeLine[lightCounter]);
                        done = nil;
                        while(!done)
                        {
                            line = inputFile.read();
                            outputFile.writeln(line);
                            if(inputFile.line() == (objEnd[lightCounter]))
                            {
                                done = true;
                                break;
                            }
                        }
                    }
                    else
                    {
                        inputFile.line(objStart[lightCounter]);
                        done = nil;
                        while(!done)
                        {
                            line = inputFile.read();
                            outputFile.writeln(line);
                            if(inputFile.line() == (objEnd[lightCounter]))
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
                    if(motInputTemp[lightCounter] != nil)
                    {
                        inputFile.line(objStart[lightCounter]);
                        done = nil;
                        while(!done)
                        {
                            line = inputFile.read();
                            outputFile.writeln(line);
                            if(inputFile.line() == (objMotStart[lightCounter]))
                            {
                                done = true;
                                break;
                            }
                        }
                        motInputTemp[lightCounter].line(4);
                        while(!motInputTemp[lightCounter].eof())
                        {
                            line = motInputTemp[lightCounter].read();
                            outputFile.writeln(line);
                        }
                        inputFile.line(objMotEnd[lightCounter] + 1);
                        done = nil;
                        while(!done)
                        {
                            line = inputFile.read();
                            outputFile.writeln(line);
                            if(inputFile.line() == (objEnd[lightCounter] - 2))
                            {
                                done = true;
                                break;
                            }
                        }
                        motInputTemp[lightCounter].close();
                        inputFile.line(objEnd[lightCounter] - 2);
                        line = inputFile.read();
                        outputFile.writeln(line);
                        outputFile.writeln("");
                    }
                    else
                    {
                        inputFile.line(objStart[lightCounter]);
                        done = nil;
                        while(!done)
                        {
                            line = inputFile.read();
                            outputFile.writeln(line);
                            if(inputFile.line() == (objEnd[lightCounter]))
                            {
                                done = true;
                                break;
                            }
                        }
                    }
                    // end case 3 here, which is the motion override type
                    break;
                
                default:
                    inputFile.line(objStart[lightCounter]);
                    done = nil;
                    while(!done)
                    {
                        line = inputFile.read();
                        outputFile.writeln(line);
                        if(inputFile.line() == (objEnd[lightCounter]))
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
            inputFile.line(objStart[lightCounter]);
            done = nil;
            while(!done)
            {
                line = inputFile.read();
                outputFile.writeln(line);
                if(inputFile.line() == (objEnd[lightCounter]))
                {
                    done = true;
                    break;
                }
            }
        }
    }

    // write out the cameras
    info("lastObject: " + lastObject.asStr());
    info("lastLight: " + lastLight.asStr());
    info("lastCamera: " + lastCamera.asStr());
    for(cameraCounter = lastObject + lastLight; cameraCounter <= lastObject + lastLight + lastCamera; cameraCounter++)
    {
        progressString = string(((cameraCounter/(lastObject + lastLight + lastCamera))/4) + (3 / noOfStages));
        msgString = "{" + progressString + "}Generating Render Scene:  Writing Cameras...";
        StatusMsg(msgString);
        sleep(1);

        if(doOverride[cameraCounter] == 1)
        {
            switch(overrideType[cameraCounter])
            {
                case 3:
                    // begin case 3 here, which is the motion override type
                    if(motInputTemp[cameraCounter] != nil)
                    {
                        inputFile.line(objStart[cameraCounter]);
                        done = nil;
                        while(!done)
                        {
                            line = inputFile.read();
                            outputFile.writeln(line);
                            if(inputFile.line() == (objMotStart[cameraCounter]))
                            {
                                done = true;
                                break;
                            }
                        }
                        motInputTemp[cameraCounter].line(4);
                        while(!motInputTemp[cameraCounter].eof())
                        {
                            line = motInputTemp[cameraCounter].read();
                            outputFile.writeln(line);
                        }
                        inputFile.line(objMotEnd[cameraCounter] + 1);
                        done = nil;
                        while(!done)
                        {
                            line = inputFile.read();
                            outputFile.writeln(line);
                            if(inputFile.line() == (objEnd[cameraCounter] - 2))
                            {
                                done = true;
                                break;
                            }
                        }
                        motInputTemp[cameraCounter].close();
                        inputFile.line(objEnd[cameraCounter] - 2);
                        line = inputFile.read();
                        outputFile.writeln(line);
                        outputFile.writeln("");
                    }
                    else
                    {
                        inputFile.line(objStart[cameraCounter]);
                        done = nil;
                        while(!done)
                        {
                            line = inputFile.read();
                            outputFile.writeln(line);
                            if(inputFile.line() == (objEnd[cameraCounter]))
                            {
                                done = true;
                                break;
                            }
                        }
                    }
                    // end case 3 here, which is the motion override type
                    break;

                case 8:
                	break;

                default:
                    inputFile.line(objStart[cameraCounter]);
                    done = nil;
                    while(!done)
                    {
                        line = inputFile.read();
                        outputFile.writeln(line);
                        if(inputFile.line() == (objEnd[cameraCounter]))
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
            inputFile.line(objStart[cameraCounter]);
            done = nil;
            while(!done)
            {
                line = inputFile.read();
                outputFile.writeln(line);
                if(inputFile.line() == (objEnd[cameraCounter]))
                {
                    done = true;
                    break;
                }
            }
        }
	}
	
	    
    if(hvDataLine != nil || includedHvObjects != nil)
    {        
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
			overrideType[passItem] = 6;
			overrideRenderer = integer(settingsArray[3]);
			switch(overrideRenderer)
			{
				case 1:
				// native renderer - call the support
				scnGen_native(updatedCurrentScenePath, newScenePath);
				break;
				
				default:
				scnGen_native(updatedCurrentScenePath, newScenePath);
				break;
			}
		}
    }

	// FiberFX stuff. Due to poor parameter naming, we need to do this in a more specific manner.
	if(fiberFX(newScenePath) == 1)
	{
		// We made some changes, so let's align the files again
		filecopy(newScenePath, updatedCurrentScenePath);
	}

	// deal with the buffer savers now.
	handleBuffers(updatedCurrentScenePath);
    
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

fiberFX: ffFile
{
	// Let's check if FiberFX was even applied.
	ffLine = getPartialLine(0,0,"Plugin PixelFilterHandler 1 FiberFilter",ffFile);
	if(ffLine == nil)
	{
		return 0;
	}
	
	// Let's check if it's version 3
	checkFile = File(ffFile, "r");
	checkFile.line(ffLine + 2);
	line = checkFile.read();
	if(line != "Version 3")
	{
		checkFile.close();
		return 0;
	}
	
	// If we got here, we're happy that everything is good to go.
	checkFile.close();

	// Hard-coded offsets from the detected pixel filter line, based on scene file inspection.
	fiberFXSaveRGBA				= integer(settingsArray[50]);
	ffString = "SaveRGBA " + string(fiberFXSaveRGBA);
	changeScnLine(ffString, ffFile, ffLine + 8);

	fiberFXSaveDepth			= integer(settingsArray[53]);
	ffString = "SaveDepth " + string(fiberFXSaveDepth);
	changeScnLine(ffString, ffFile, ffLine + 9);

	fiberFXSaveRGBAType			= integer(settingsArray[51]);
	ffString = "RGBType " + string(image_formats_array[fiberFXSaveRGBAType]);
	changeScnLine(ffString, ffFile, ffLine + 10);

	fiberFXSaveDepthType		= integer(settingsArray[54]);
	ffString = "DepthType " + string(image_formats_array[fiberFXSaveDepthType]);
	changeScnLine(ffString, ffFile, ffLine + 11);

	fiberFXSaveRGBAName			= string(settingsArray[52]);
	ffString = "RGBName " + string(fiberFXSaveRGBAName);
	changeScnLine(ffString, ffFile, ffLine + 12);

	fiberFXSaveDepthName		= string(settingsArray[55]);
	ffString = "DepthName " + string(fiberFXSaveDepthName);
	changeScnLine(ffString, ffFile, ffLine + 13);

	return 1; // notify caller that we changed something.
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
		
	}
    inputFile.close();
    tempOutput.close();
    finishFiles();
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
	tempFileName = tempDirectory + getsep() + "tempPassportInputFile.lws";
	filecopy(inputFileName, tempFileName);
	// Insert missing radiosity lines in the file passed in.
	radLines_native(tempFileName);
	filecopy(tempFileName, inputFileName);
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
	fileAdjust.read(); // move on the read file by that line.
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
