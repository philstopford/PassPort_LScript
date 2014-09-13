generatePassFile: mode, gPass
{
    tempPass = ::pass;
    ::pass = gPass;
    if (mode == "frame")
    {
        outputStr = "testFrame_";
    }
    if (mode == "seq")
    {
        outputStr = "seq_";
    }

    ::noOfStages = 4; // drives progress value - currently parse, object, light and render stages.

    // initial stuff
    ::overriddenObjectID = nil;
    ::overriddenObjectName = nil;
    ::lastObject = 0;
    ::lastLight = 0;
    ::lastCamera = 0;
    lightSettingOffset = 0;
    contentDirectory = getdir("Content");
    chdir(::tempDirectory);
    SaveSceneCopy("passEditorTempSceneCopy.lws");
    ::currentScenePath = ::tempDirectory + getsep() + "passEditorTempSceneCopy.lws";
    prepareReadBuffer(::tempDirectory + getsep() + "passEditorTempSceneCopy.lws");
     // Insert missing radiosity lines in the file passed in.
    radLines_native();
    chdir(contentDirectory);

    // get the item start and stop lines for copying. We also use the setItems array later for dep checking.
    setItems = parseListItems(::passAssItems[::pass]);
    
    for(::passItem = 1; ::passItem <= size(setItems); ::passItem++)
    {
        progressString = string((::passItem / size(setItems)) / ::noOfStages);
        msgString = "{" + progressString + "}Generating Render Scene:  Cataloging Items and Overrides...";
        StatusMsg(msgString);
        sleep(1);

        // first the object lines
        tempNumber = setItems[::passItem];
        tempObjectNames[::passItem] = ::displayNames[tempNumber];
        assignmentsArray = checkForOverrideAssignments(::displayIDs[tempNumber], ::pass);
    
        if(assignmentsArray != nil)
        {
            // Set up the values. Overrides will then adjust their own values of interest.
            ::overrideType[::passItem] = nil;
            ::motInputTemp[::passItem] = nil;
            ::lwoInputTemp[::passItem] = nil;
            ::srfLWOInputID[::passItem] = nil;
            ::srfInputTemp[::passItem] = nil;
            ::objPropOverrideSets[::passItem] = nil;
            ::objPropOverrideShadowOpts[::passItem] = nil;
            ::lightSettingsPartOne[::passItem] = nil;
            ::lightSettingsPartTwo[::passItem] = nil;
            ::lightSettingsPartThree[::passItem] = nil;
            ::cameraSettingsPartOne[::passItem] = nil;
            ::cameraSettingsPartTwo[::passItem] = nil;
            ::cameraSettingsPartThree[::passItem]= nil;

            ::doOverride[::passItem] = 1;
            a = assignmentsArray[1];
            ::settingsArray = parse("||", ::overrideSettings[a]);
            if( size(assignmentsArray) > 1)
            {
                b = assignmentsArray[2];
                secondSettingsArray = parse("||",::overrideSettings[b]);
            }

            // Scene Master override is incompatible with an assignment array, so empty it in this case :           
            if(::settingsArray[2] == "type6")
            {
                assignmentsArray = nil;
                ::doOverride[::passItem] = 0;
                ::overrideType[::passItem] = 0;
            }
            
            if(::settingsArray[2] == "type5")
            {
                ::overrideType[::passItem] = 5;
                lightColorLine = "LightColor " + string(number(::settingsArray[3]) / 255) + " " + string(number(::settingsArray[4]) / 255) + " " + string(number(::settingsArray[5]) / 255) + "\n";
                lightIntensityLine = "LightIntensity " + ::settingsArray[6] + "\n";
                if(::settingsArray[7] == "0")
                {
                    affectDiffuseLine = "AffectDiffuse 0\n";
                    lightSettingOffset++;
                }
                else
                {
                    affectDiffuseLine = "";
                }
                if(::settingsArray[8] == "0")
                {
                    affectSpecularLine = "AffectSpecular 0\n";
                    lightSettingOffset++;
                }
                else
                {
                    affectSpecularLine = "";
                }
                if(::settingsArray[9] == "0")
                {
                    affectCausticsLine = "AffectCaustics 0\n";
                }
                else
                {
                    affectCausticsLine = "AffectCaustics 1\n";
                }
                if(::settingsArray[10] == "0") // deliberately omit carriage returns.
                {
                    LensFlareLine = "LensFlare 0";
                }
                else
                {
                    LensFlareLine = "LensFlare 1";
                }
                if(::settingsArray[11] == "0") // deliberately omit carriage returns.
                {
                    VolumetricsLine = "VolumetricLighting 0";
                }
                else
                {
                    VolumetricsLine = "VolumetricLighting 1";
                }
                
                ::lightSettingsPartOne[::passItem] = lightColorLine + lightIntensityLine + affectDiffuseLine + affectSpecularLine + affectCausticsLine;
                ::lightSettingsPartTwo[::passItem] = LensFlareLine;
                ::lightSettingsPartThree[::passItem] = VolumetricsLine;
            
            }

            if(::settingsArray[2] == "type1")
            {
                ::overrideType[::passItem] = 1;
                ::srfLWOInputID[::passItem] = ::displayIDs[tempNumber];
                ::srfInputTemp[::passItem] = ::settingsArray[3];
            }   

            if(::settingsArray[2] == "type4")
            {
                ::overrideType[::passItem] = 4;
                ::lwoInputTemp[::passItem] = ::settingsArray[3];
            }   

            if(::settingsArray[2] == "type3")
            {
                ::overrideType[::passItem] = 3;
                ::motInputTemp[::passItem] = ::settingsArray[3];
            }

            if(::settingsArray[2] == "type2")
            {
                ::overrideType[::passItem] = 2;
                if(::settingsArray[3] == "1")
                {
                    //matteObjectLine = "MatteObject 1\nMatteColor 0 0 0\n";
                    matteObjectLine = "MatteObject 1\nMatteColor " + string(number(::settingsArray[12]) / 255) + " " + string(number(::settingsArray[13]) / 255) + " " + string(number(::settingsArray[14]) / 255) + "\n";
                }
                else
                {
                    matteObjectLine = "";
                }

                switch(integer(::settingsArray[4]))
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
                if(::settingsArray[5] == "1")
                {
                    unseenByRaysLine = "UnseenByRays 1\n";
                }
                else
                {
                    unseenByRaysLine = "";
                }
                if(::settingsArray[6] == "1")
                {
                    unseenByCameraLine = "UnseenByCamera 1\n";
                }
                else
                {
                    unseenByCameraLine = "";
                }
                if(::settingsArray[7] == "1")
                {
                    unseenByRadiosityLine = "UnseenByRadiosity 1\n";
                }
                else
                {
                    unseenByRadiosityLine = "";
                }
                if(::settingsArray[8] == "1")
                {
                    unseenByFogLine = "UnaffectedByFog 1\n";
                }
                else
                {
                    unseenByFogLine = "";
                }
                if(::settingsArray[9] == "0")
                {
                    if(::settingsArray[10] == "0")
                    {
                        if(::settingsArray[11] == "0")
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
                        if(::settingsArray[11] == "0")
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
                    if(::settingsArray[10] == "0")
                    {
                        if(::settingsArray[11] == "0")
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
                        if(::settingsArray[11] == "0")
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
                ::objPropOverrideSets[::passItem] = matteObjectLine + unseenByFogLine + unseenByRadiosityLine + unseenByRaysLine + unseenByCameraLine + alphaLine;
                ::objPropOverrideShadowOpts[::passItem] = shadowOptionsLine;
            }

            if(::settingsArray[2] == "type7")
            {
                ::overrideType[::passItem] = 7;
                if(size(::settingsArray) >= 3)
                {
                    if(::settingsArray[3] != nil && ::settingsArray[3] != "")
                    {
                        excludedLightNames = parse(";",::settingsArray[3]);
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
                    lightExclusion[::passItem] = nil;
                    doneRad = 0;
                    doneCaus = 0;                   
                    for(k = 1; k <= size(::lightNames); k++)
                    {
                        for(m = 1; m <= size(excludedLightNames); m++)
                        {
                            if(::lightNames[k] == excludedLightNames[m])
                            {
                                tempID = ::lightOldIDs[k];
                                lightExclusion[::passItem] = string(lightExclusion[::passItem]) + "ExcludeLight " + string(tempID) + "\n";
                            }
                            else
                            {
                                if(excludedLightNames[m] == "Radiosity")
                                {
                                    if(doneRad == 0)
                                    {
                                        lightExclusion[::passItem] = string(lightExclusion[::passItem]) + "ExcludeLight 21000000\n";
                                        doneRad = 1;
                                    }
                                }
                                else
                                {
                                    if(excludedLightNames[m] == "Caustics")
                                    {
                                        if(doneCaus == 0)
                                        {
                                            lightExclusion[::passItem] = string(lightExclusion[::passItem]) + "ExcludeLight 22000000\n";
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
                    lightExclusion[::passItem] = nil;
                }
                
            }

            if(::settingsArray[2] == "type8") // EXPERIMENTAL Camera override
            {
                zoomFactor                      = string(::settingsArray[3]);
                ::cameraSettingsPartOne[::passItem] =   "ZoomFactor " + zoomFactor + "\n";
                ::cameraSettingsPartOneCount[::passItem] = 1;
                zoomType                        = string(::settingsArray[4]);
                ::cameraSettingsPartOne[::passItem] +=  "ZoomType " + zoomType + "\n";
                ::cameraSettingsPartOneCount[::passItem]++;
                resolutionMultiplier            = string(::settingsArray[5]);
                ::cameraSettingsPartOne[::passItem] +=  "ResolutionMultiplier " + resolutionMultiplier + "\n";
                ::cameraSettingsPartOneCount[::passItem]++;
                frameSizeH                      = string(int(::settingsArray[6]) * number(resolutionMultiplier));
                frameSizeV                      = string(int(::settingsArray[7]) * number(resolutionMultiplier));
                ::cameraSettingsPartOne[::passItem] +=  "FrameSize " + frameSizeH + " " + frameSizeV + "\n";
                ::cameraSettingsPartOneCount[::passItem]++;
                pixelAspect                     = string(::settingsArray[8]);
                ::cameraSettingsPartOne[::passItem] +=  "PixelAspect " + pixelAspect + "\n";
                ::cameraSettingsPartOneCount[::passItem]++;
                motionBlur                      = string(::settingsArray[9]);
                ::cameraSettingsPartOne[::passItem] +=  "MotionBlur " + motionBlur + "\n";
                ::cameraSettingsPartOneCount[::passItem]++;
                motionBlurPasses                = string(::settingsArray[10]);
                ::cameraSettingsPartOne[::passItem] +=  "MotionBlurPasses " + motionBlurPasses + "\n";
                ::cameraSettingsPartOneCount[::passItem]++;
                shutterEfficiency               = string(::settingsArray[11]);
                ::cameraSettingsPartOne[::passItem] +=  "ShutterEfficiency " + shutterEfficiency + "\n";
                ::cameraSettingsPartOneCount[::passItem]++;
                rollingShutter                  = string(::settingsArray[12]);
                ::cameraSettingsPartOne[::passItem] +=  "RollingShutter " + rollingShutter + "\n";
                ::cameraSettingsPartOneCount[::passItem]++;
                shutterOpen                     = string(::settingsArray[13]);
                ::cameraSettingsPartOne[::passItem] +=  "ShutterOpen " + shutterOpen + "\n";
                ::cameraSettingsPartOneCount[::passItem]++;
                oversampling                    = string(::settingsArray[14]);
                ::cameraSettingsPartOne[::passItem] +=  "Oversampling " + oversampling + "\n";
                ::cameraSettingsPartOneCount[::passItem]++;

                fieldRendering                  = string(::settingsArray[15]);
                ::cameraSettingsPartTwo[::passItem] =   "FieldRendering " + fieldRendering + "\n";
                ::cameraSettingsPartTwoCount[::passItem] = 1;

                depthOfField                        = string(::settingsArray[16]);
                ::cameraSettingsPartThree[::passItem]   =  "DepthOfField " + depthOfField + "\n";
                ::cameraSettingsPartThreeCount[::passItem] = 1;

                sampler                             = string(::settingsArray[17]);
                ::cameraSettingsPartFour[::passItem]    =   "Sampler " + sampler + "\n";
                ::cameraSettingsPartFourCount[::passItem] = 1;
                adaptiveThreshold                   = string(::settingsArray[18]);
                ::cameraSettingsPartFour[::passItem]    +=  "AdaptiveThreshold " + adaptiveThreshold + "\n";
                ::cameraSettingsPartFourCount[::passItem]++;
                minimumSamples                      = string(::settingsArray[19]);
                ::cameraSettingsPartFour[::passItem]    +=  "MinimumSamples " + minimumSamples + "\n";
                ::cameraSettingsPartFourCount[::passItem]++;
                maximumSamples                      = string(::settingsArray[20]);
                ::cameraSettingsPartFour[::passItem]    +=  "MaximumSamples " + maximumSamples + "\n";
                ::cameraSettingsPartFourCount[::passItem]++;

                ::overrideType[::passItem] = 8;
            }

            if(assignmentsArray != nil && size(assignmentsArray) > 1)
            {
                if(secondSettingsArray[2] == "type7")
                {
                    secondOverrideType[::passItem] = 7;
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
                        lightExclusion[::passItem] = nil;
                        doneRad = 0;
                        doneCaus = 0;                   
                        for(k = 1; k <= size(::lightNames); k++)
                        {
                            for(m = 1; m <= size(excludedLightNames); m++)
                            {
                                if(::lightNames[k] == excludedLightNames[m])
                                {
                                    tempID = ::lightOldIDs[k];
                                    lightExclusion[::passItem] = string(lightExclusion[::passItem]) + "ExcludeLight " + string(tempID) + "\n";
                                }
                                else
                                {
                                    if(excludedLightNames[m] == "Radiosity")
                                    {
                                        if(doneRad == 0)
                                        {
                                            lightExclusion[::passItem] = string(lightExclusion[::passItem]) + "ExcludeLight 21000000\n";
                                            doneRad = 1;
                                        }
                                    }
                                    else
                                    {
                                        if(excludedLightNames[m] == "Caustics")
                                        {
                                            if(doneCaus == 0)
                                            {
                                                lightExclusion[::passItem] = string(lightExclusion[::passItem]) + "ExcludeLight 22000000\n";
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
                        lightExclusion[::passItem] = nil;
                    }
                }
                else
                {
                    secondOverrideType[::passItem] = nil;
                }
            }
            else
            {
                secondOverrideType[::passItem] = nil;
            }            
        }
        else
        {
            ::doOverride[::passItem] = 0;
            ::overrideType[::passItem] = 0;
        }
        if(size(::doOverride) < ::passItem)
        {
            ::doOverride[::passItem] = 0;
        }
        if(::overrideType == nil || size(::overrideType) < ::passItem)
        {
            errorString = "An internal error has been detected: overrideType is: " + ::overrideType;
            logger("warn","errorString");
            errorString = "Will render a full pass of type '" + mode + "' instead. Sorry.";
            logger("warn","errorString");
            ::doOverride[::passItem] = 0;
            ::overrideType[::passItem] = 0;
        }
        
        if(strleft(string(::displayOldIDs[tempNumber]),1) == string(MESH))
        {
            ::objStart[::passItem] = getEntityStartLine(::displayOldIDs[tempNumber]);
            ::objEnd[::passItem] = getEntityEndLine(::objStart[::passItem] + 1,::displayOldIDs[tempNumber]);
            ::objMotStart[::passItem] = getPartialLine(::objStart[::passItem],::objEnd[::passItem],"NumChannels");
            // We no longer make assumptions about the number of channels for an entity. We retrieve it directly from the scene file.
            // Happily, the line was retrieved above by the getPartialLine call, so it's available for use.
            // We use parse to split the line by spaces, the second is assumed to be the number of channels. We cast that to an integer.
            noc_Array = parse(" ",readSpecificLine(::objMotStart[::passItem]));
            numberOfChannels = integer(noc_Array[2]);
            ::objMotEnd[::passItem] = ::objMotStart[::passItem];
            for(b = 1; b <= numberOfChannels; b++)
            {
                ::objMotEnd[::passItem] = getPartialLine((::objMotEnd[::passItem] + 1),::objEnd[::passItem],"}");
            }
            ::lastObject = ::passItem;
            // logger("info","objstart: " + ::objStart[::passItem].asStr());
            // logger("info","objend: " + ::objEnd[::passItem].asStr());
        }


        // then the light lines
        if(strleft(string(::displayOldIDs[tempNumber]),1) == string(LIGHT))
        {
            ::objStart[::passItem] = getEntityStartLine(::displayOldIDs[tempNumber]);
            ::objEnd[::passItem] = getEntityEndLine(::objStart[::passItem] + 1,::displayOldIDs[tempNumber]);
            ::objMotStart[::passItem] = getPartialLine(::objStart[::passItem],::objEnd[::passItem],"NumChannels");
            // We no longer make assumptions about the number of channels for an entity. We retrieve it directly from the scene file.
            // Happily, the line was retrieved above by the getPartialLine call, so it's available for use.
            // We use parse to split the line by spaces, the second is assumed to be the number of channels. We cast that to an integer.
            noc_Array = parse(" ",readSpecificLine(::objMotStart[::passItem]));
            numberOfChannels = integer(noc_Array[2]);
            ::objMotEnd[::passItem] = ::objMotStart[::passItem];
            for(b = 1; b <= numberOfChannels; b++)
            {
                ::objMotEnd[::passItem] = getPartialLine((::objMotEnd[::passItem] + 1),::objEnd[::passItem],"}");
            }
            IKInitialState[::passItem] = getPartialLine(::objStart[::passItem],::objEnd[::passItem],"IKInitialState");
            objAffectCausticsLine[::passItem] = getPartialLine(::objStart[::passItem],::objEnd[::passItem],"AffectCaustics");
            objLightTypeLine[::passItem] = getPartialLine(::objStart[::passItem],::objEnd[::passItem],"LightType ");
            objLensFlareLine[::passItem] = getPartialLine(::objStart[::passItem],::objEnd[::passItem],"LensFlare ");
            if(objLensFlareLine[::passItem])
            {
                objLensFlareLine[::passItem] += lightSettingOffset;
            }
            objVolLightLine[::passItem] = getPartialLine(::objStart[::passItem],::objEnd[::passItem],"VolumetricLighting ");
            if(objVolLightLine[::passItem])
                objVolLightLine[::passItem] += lightSettingOffset;
            ::lastLight++;
            // logger("info","lightstart: " + ::objStart[::passItem].asStr());
            // logger("info","lightend: " + ::objEnd[::passItem].asStr());
        }
        
        // then the camera lines
        if(strleft(string(::displayOldIDs[tempNumber]),1) == string(CAMERA))
        {
            ::objStart[::passItem] = getEntityStartLine(::displayOldIDs[tempNumber]);
            ::objEnd[::passItem] = getEntityEndLine(::objStart[::passItem] + 1,::displayOldIDs[tempNumber]);
            ::objMotStart[::passItem] = getPartialLine(::objStart[::passItem],::objEnd[::passItem],"NumChannels");
            // We no longer make assumptions about the number of channels for an entity. We retrieve it directly from the scene file.
            // Happily, the line was retrieved above by the getPartialLine call, so it's available for use.
            // We use parse to split the line by spaces, the second is assumed to be the number of channels. We cast that to an integer.
            noc_Array = parse(" ",readSpecificLine(::objMotStart[::passItem]));
            numberOfChannels = integer(noc_Array[2]);
            ::objMotEnd[::passItem] = ::objMotStart[::passItem];
            for(b = 1; b <= numberOfChannels; b++)
            {
                ::objMotEnd[::passItem] = getPartialLine((::objMotEnd[::passItem] + 1),::objEnd[::passItem],"}");
            }
            IKInitialState[::passItem] = getPartialLine(::objStart[::passItem],::objEnd[::passItem],"IKInitialState");
            ::lastCamera++;
            // logger("info","camstart: " + ::objStart[::passItem].asStr());
            // logger("info","camend: " + ::objEnd[::passItem].asStr());
        }
    }

    outputFolder = parse("(", ::userOutputFolder);

    if(outputFolder[1] == nil || outputFolder[1] == "leave empty)")
    {
        logger("error","Please choose an output folder in the preferences.");
    }

    if(!chdir(outputFolder[1]))
    {
        logger("error","Output folder is invalid! Please choose a valid output folder in Preferences.");
    }

    // write out the header stuff
    writeHeader();

    // write out the objects
    writeObjects();

    // write out the stuff between the lights and objects
    // get the start light line
    startLightsLine = getPartialLine(0,0,"AddLight");
    // then the ambient color line
    ambientColorLine = getPartialLine(0,0,"AmbientColor");

    i = ambientColorLine;
    while(i < startLightsLine - 1)
    {
        ::writeBuffer[size(::writeBuffer) + 1] = readBuffer[i];
        i++;
    }

    // write out the lights
    writeLights(IKInitialState);

    // then the camera line
    cameraStartLine = getPartialLine(0,0,"AddCamera");
    readIndex = cameraStartLine;
    writeCameras(readIndex);

    //  lineNumber = ::objEnd[::lastLight + ::lastObject + ::lastCamera];
    // then the AA line
    antialiasingLine = getPartialLine(0,0,"Antialiasing");
    // data overlay label
    dataOverlayLabelLine = getPartialLine(0,0,"DataOverlayLabel");
    readIndex = antialiasingLine;
    while(readIndex <= dataOverlayLabelLine)
    {
        if(hvStartLine)
        {
            if(readIndex = (hvStartLine + 1) && (hvDataLine != nil || includedHvObjects != nil))
            {
                for(x = 1; x < 4; x++)
                {
                        ::writeBuffer[size(::writeBuffer) + 1] = ::readBuffer[readIndex];
                        readIndex++;
                }

                for(x = 1; x <= size(includedHvObjects); x++)
                {
                    tempIterationNumber = includedHvObjects[x];
                    readIndex = hvObjectLine[tempIterationNumber];
                    while(readIndex <= hvObjectEndLine[tempIterationNumber])
                    {
                        ::writeBuffer[size(::writeBuffer)+1] = ::readBuffer[readIndex];
                        readIndex++;
                    }
                }
                
                tempSizeNumber = size(hvObjectEndLine);
                readIndex = hvObjectEndLine[tempSizeNumber];
            }
        }
        ::writeBuffer[size(::writeBuffer) + 1] = ::readBuffer[readIndex];
        readIndex++;
    }

    progressString = string(0.995);
    msgString = "{" + progressString + "}Generating Render Scene:  Finishing...";
    StatusMsg(msgString);
    sleep(1);

        // get the save RGB line
    saveRGBLine = getPartialLine(cameraStartLine,0,"SaveRGB ");

    ::saveRGBImagesPrefix = generateSaveRGBPath(mode, outputFolder, outputStr);
    ::writeBuffer[size(::writeBuffer) + 1] = "OutputFilenameFormat 3";
    ::writeBuffer[size(::writeBuffer) + 1] = "SaveRGB 1";
    ::writeBuffer[size(::writeBuffer) + 1] = "SaveRGBImagesPrefix " + ::saveRGBImagesPrefix;
    if (mode == "frame")
    {
        ::writeBuffer[size(::writeBuffer) + 1] = "RGBImageSaver " + ::image_formats_array[::testRgbSaveType];
    } else {
        ::writeBuffer[size(::writeBuffer) + 1] = "RGBImageSaver " + ::image_formats_array[::rgbSaveType];
    }
    ::writeBuffer[size(::writeBuffer) + 1] = "SaveAlpha 0";

    // try to get the alpha multiplication settings line
    alphaMultSettingsLine =  getPartialLine(saveRGBLine,0,"AlphaMode ");
    if(alphaMultSettingsLine != nil)
    {
        // write out the alpha multiplication settings if they exist
        readIndex = alphaMultSettingsLine;
        line = ::readBuffer[readIndex];
        readIndex++;
        if(line != nil && line != "")
        {
            ::writeBuffer[size(::writeBuffer) + 1] = line;
        }
    }
    ::writeBuffer[size(::writeBuffer) + 1] = "";

    // write out the rest of the scene file
    // get the ViewConfiguration line
    readIndex = getPartialLine(0,0,"ViewConfiguration ");
    while(readIndex <= size(::readBuffer))
    {
        ::writeBuffer[size(::writeBuffer) + 1] = ::readBuffer[readIndex];
        readIndex++;
    }
    ::readBuffer = ::writeBuffer;
    ::writeBuffer = nil;


    if(::overrideNames[1] != "empty")
    {
        z = 1;
        for(x = 1; x <= size(::overrideNames); x++)
        {
            //set_o_items = parseListItems(::passOverrideItems[::pass][x]);
            overrideItemsString = ::passOverrideItems[::pass][x];
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
        ::settingsArray = parse("||",::overrideSettings[a]);
        if(::settingsArray[2] == "type6")
        {
            ::overrideType[::passItem] = 6;
            ::overrideRenderer = integer(::settingsArray[3]);
            redirectBuffersSetts = integer(::settingsArray[8]);
            switch(::overrideRenderer)
            {
                case 1:
                // native renderer - call the support
                scnGen_native();
                break;
                case 2:
                // kray renderer - call the support
@if enableKray
                scnGen_kray25();
@else
                logger("error","Scene Master override calls for Kray 2.5, but this build doesn't offer support.");
@end
                break;

                case 3:
                // arnold renderer - call the support
@if enableArnold048
                scnGen_arnold048();
@else
                logger("error","Scene Master override calls for LWtoA 0.4.3, but this build doesn't offer support.");
@end
                break;

                default:
                scnGen_native();
                break;
            }
            fiberFXOverride();
        }
    }

    // FiberFX stuff. Overrides are handled earlier - this is just about pass alignment.
    fiberFX();

    // Hypervoxel 3 pass alignment.
    hyperVoxels3();

    // deal with the buffer savers now.
    if(!redirectBuffersSetts)
        redirectBuffersSetts = 0;
    handleBuffers(mode, redirectBuffersSetts, outputFolder, outputStr, fileOuputPrefix, ::userOutputString);
    
    // and as a tack-on fix, replace motion-mixer stuff for overridden objects. Calls finishFiles() for us.
    motionMixerStuff();

    dependencyCheck();
    
    stripPassEditor();

    commitSceneBufferToDisk();

    ::pass = tempPass;
    return(::currentScenePath);
} // generatePass

commitSceneBufferToDisk
{
    readIndex = 1;
    diskFile = File(::currentScenePath, "w");
    while(readIndex <= size(::readBuffer))
    {
        diskFile.writeln(::readBuffer[readIndex]);
        readIndex++;
    }
    diskFile.close();
}

writeHeader
{
    switch(int(hostVersion()))
    {
        case 11:
            endLine = getPartialLine(0, 0, "NavigationDesiredDevice");
            if(hostVersion() < 11.5 && hostVersion() >= 11)
            {
                endLine = getPartialLine(0, 0, "FirstBackgroundImageSyncFrame");
            }
            break;
        default:
            logger("error","Unsupported version of LW!");
            break;
    }
    if(!endLine || endLine == nil || endLine == 0)
    {
        logger("error","writeHeader: couldn't find endLine");
    }

    i = 1;
    while(i <= endLine)
    {
        ::writeBuffer[i] = ::readBuffer[i];
        i++;
    }
    ::writeBuffer[size(::writeBuffer) + 1] = "";
}

writeCameras: lineNumber
{
    for(cameraCounter = ::lastObject + ::lastLight + 1; cameraCounter <= ::lastObject + ::lastLight + ::lastCamera; cameraCounter++)
    {
        progressString = string(((cameraCounter/(::lastObject + ::lastLight + ::lastCamera))/4) + (3 / ::noOfStages));
        msgString = "{" + progressString + "}Generating Render Scene:  Writing Cameras...";
        StatusMsg(msgString);
        sleep(1);

        if(::doOverride[cameraCounter] == 1)
        {
            switch(::overrideType[cameraCounter])
            {
                case 3:
                    // begin case 3 here, which is the motion override type
                    if(::motInputTemp[cameraCounter] != nil)
                    {
                        fileCheck(::motInputTemp[cameraCounter]);
                        motFile = File(::motInputTemp[cameraCounter], "r");
                        readIndex = ::objStart[cameraCounter];
                        done = nil;
                        while(!done)
                        {
                            ::writeBuffer[size(::writeBuffer) + 1] = ::readBuffer[readIndex];
                            readIndex++;
                            if(readIndex == (::objMotStart[cameraCounter]))
                            {
                                done = true;
                                break;
                            }
                        }
                        lineNumber = 4;
                        motFile.line(lineNumber);
                        endLine = getPartialLineFromFile(0,0,"Channel 6",::motInputTemp[cameraCounter]); // cameras don't support scale channels (the last 3 in a traditional LW .mot file).
                        while(lineNumber < endLine)
                        {
                            line = motFile.read();
                            ::writeBuffer[size(::writeBuffer) + 1] = line;
                            lineNumber = motFile.line();
                        }
                        readIndex = (::objMotEnd[cameraCounter] + 1);
                        done = nil;
                        while(!done)
                        {
                            ::writeBuffer[size(::writeBuffer) + 1] = ::readBuffer[readIndex];
                            readIndex++;
                            if(readIndex == (::objEnd[cameraCounter]))
                            {
                                done = true;
                                break;
                            }
                        }
                        motFile.close();
                    }
                    else
                    {
                        readIndex = ::objStart[cameraCounter];
                        done = nil;
                        while(!done)
                        {
                            ::writeBuffer[size(::writeBuffer) + 1] = ::readBuffer[readIndex];
                            readIndex++;
                            if(readIndex == (::objEnd[cameraCounter]))
                            {
                                done = true;
                                break;
                            }
                        }
                    }
                    // end case 3 here, which is the motion override type
                    break;

                case 8:
                    if(::cameraSettingsPartOne[cameraCounter] != nil && ::cameraSettingsPartTwo[cameraCounter] != nil && 
                       ::cameraSettingsPartThree[cameraCounter] != nil && ::cameraSettingsPartFour[cameraCounter] != nil)
                    {
                        // write out the beginning of the camera
                        readIndex = ::objStart[cameraCounter];
                        done = nil;
                        while(!done)
                        {
                            ::writeBuffer[size(::writeBuffer) + 1] = ::readBuffer[readIndex];
                            readIndex++;
                            if(readIndex == IKInitialState[cameraCounter] + 1)
                            {
                                done = true;
                                break;
                            }
                        }
                        
                        // write out the custom parameters
                        tempArray = parse("\\n", ::cameraSettingsPartOne[cameraCounter]);
                        for (i = 1; i <= size(tempArray); i++)
                        {
                            ::writeBuffer[size(::writeBuffer) + 1] = tempArray[i];
                        }

                        // Fill out content until the next .
                        readIndex = getPartialLine(::objStart[cameraCounter],0,"Oversampling") + 1;
                        tempEndNumber = getPartialLine(readIndex,0,"FieldRendering");
                        if(!tempEndNumber)
                        {
                            logger("error","writeCameras: Failed to find FieldRendering!");
                        }
                        while(readIndex < tempEndNumber)
                        {
                            ::writeBuffer[size(::writeBuffer) + 1] = ::readBuffer[readIndex];
                            readIndex++;
                        }

                        // Next set of changes.
                        tempArray = parse("\\n", ::cameraSettingsPartTwo[cameraCounter]);
                        for (i = 1; i <= size(tempArray); i++)
                        {
                            ::writeBuffer[size(::writeBuffer) + 1] = tempArray[i];
                        }

                        lineNumber = tempEndNumber + ::cameraSettingsPartTwoCount[cameraCounter] + 1;
                        tempEndNumber = getPartialLine(lineNumber,0,"DepthOfField");
                        if(!tempEndNumber)
                        {
                            logger("error","writeCameras: Failed to find DepthOfField!");
                        }
                        for(readIndex = lineNumber; readIndex < tempEndNumber; readIndex++)
                        {
                            ::writeBuffer[size(::writeBuffer) + 1] = ::readBuffer[readIndex];
                        }

                        // Next set of changes.
                        tempArray = parse("\\n", ::cameraSettingsPartThree[cameraCounter]);
                        for (i = 1; i <= size(tempArray); i++)
                        {
                            ::writeBuffer[size(::writeBuffer) + 1] = tempArray[i];
                        }

                        lineNumber = tempEndNumber + ::cameraSettingsPartThreeCount[cameraCounter] + 1;
                        tempEndNumber = getPartialLine(lineNumber,0,"Sampler");
                        if(!tempEndNumber)
                        {
                            logger("error","writeCameras: Failed to find Sampler!");
                        }
                        for(readIndex = lineNumber; readIndex < tempEndNumber; readIndex++)
                        {
                            ::writeBuffer[size(::writeBuffer) + 1] = ::readBuffer[readIndex];
                        }

                        // Next set of changes.
                        tempArray = parse("\\n", ::cameraSettingsPartFour[cameraCounter]);
                        for (i = 1; i <= size(tempArray); i++)
                        {
                            ::writeBuffer[size(::writeBuffer) + 1] = tempArray[i];
                        }

                        readIndex += (::cameraSettingsPartFourCount[cameraCounter] + 1);

                        // Finish up
                        while(!done)
                        {
                            ::writeBuffer[size(::writeBuffer) + 1] = ::readBuffer[readIndex];
                            readIndex++;
                            if(readIndex > ::objEnd[cameraCounter])
                            {
                                done = true;
                                break;
                            }
                        }
                    }
                    break;

                default:
                    readIndex = (::objStart[cameraCounter]);
                    done = nil;
                    while(!done)
                    {
                        ::writeBuffer[size(::writeBuffer) + 1] = ::readBuffer[readIndex];
                        readIndex++;
                        if(readIndex > (::objEnd[cameraCounter]))
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
            readIndex = ::objStart[cameraCounter]; // first camera line.
            while(readIndex <= ::objEnd[cameraCounter])
            {
                ::writeBuffer[size(::writeBuffer) + 1] = ::readBuffer[readIndex];
                readIndex++;
            }
        }
    }
}

writeObjects
{
    if(::lastObject != nil)
    {
        mmInt = 1;
        for(objectCounter = 1; objectCounter <= ::lastObject; objectCounter++)
        {
            progressString = string(((objectCounter/size(::lastObject))/4) + (1 / ::noOfStages));
            msgString = "{" + progressString + "}Generating Render Scene:  Writing Objects...";
            StatusMsg(msgString);
            sleep(1);
            
            if(::doOverride[objectCounter] == 1)
            {
                switch(::overrideType[objectCounter])
                {
                    case 1:
                        // begin case 1 here, which is the surface type
                        if(::srfInputTemp[objectCounter] != nil && ::srfLWOInputID[objectCounter] != nil)
                        {
                            surfacedLWO = generateSurfaceObjects(::srfLWOInputID[objectCounter],::srfInputTemp[objectCounter],::currentScenePath,::objStart[objectCounter]);
                            if(surfacedLWO != nil)
                            {
                                readIndex = ::objStart[objectCounter];
                                line = ::readBuffer[readIndex];
                                if(line != nil && line != "")
                                {
                                    parseObjLineTemp = parse(" ",line);
                                    if(parseObjLineTemp[1] == "LoadObjectLayer")
                                    {
                                        line = parseObjLineTemp[1] + " " + parseObjLineTemp[2] + " " + parseObjLineTemp[3] + " " + surfacedLWO;
                                        
                                        surfacedLWO_nameArray = split(surfacedLWO);
                                        surfacedLWO_baseName = surfacedLWO_nameArray[3];
                                        ::overriddenObjectID[mmInt] = parseObjLineTemp[3];
                                        ::overriddenObjectName[mmInt] = surfacedLWO_baseName;
                                        mmInt = mmInt + 1;
                                    }
                                }
                                ::writeBuffer[size(::writeBuffer) + 1] = line;
                                readIndex++;
                                done = nil;
                                while(!done)
                                {
                                    ::writeBuffer[size(::writeBuffer) + 1] = ::readBuffer[readIndex];
                                    readIndex++;
                                    if(readIndex > ::objEnd[objectCounter])
                                    {
                                        done = true;
                                        break;
                                    }
                                }
                                if(lightExclusion)
                                {
                                    if(lightExclusion[objectCounter] != nil)
                                    {
                                        tempArray = parse("\\n", lightExclusion[objectCounter]);
                                        for (i = 1; i <= size(tempArray); i++)
                                        {
                                            ::writeBuffer[size(::writeBuffer) + 1] = tempArray[i];
                                        }
                                    }
                                }
                                ::writeBuffer[size(::writeBuffer) + 1] = "";
                            }
                            else
                            {
                                readIndex = ::objStart[objectCounter];
                                done = nil;
                                while(!done)
                                {
                                    ::writeBuffer[size(::writeBuffer) + 1] = ::readBuffer[readIndex];
                                    readIndex++;
                                    if(readIndex > ::objEnd[objectCounter])
                                    {
                                        done = true;
                                        break;
                                    }
                                }
                                if(lightExclusion)
                                {
                                    if(lightExclusion[objectCounter] != nil)
                                    {
                                        tempArray = parse("\\n", lightExclusion[objectCounter]);
                                        for (i = 1; i <= size(tempArray); i++)
                                        {
                                            ::writeBuffer[size(::writeBuffer) + 1] = tempArray[i];
                                        }
                                    }
                                }
                                ::writeBuffer[size(::writeBuffer) + 1] = "";
                            }   
                            
                        }
                        else
                        {
                            readIndex = ::objStart[objectCounter];
                            done = nil;
                            while(!done)
                            {
                                ::writeBuffer[size(::writeBuffer) + 1] = ::readBuffer[readIndex];
                                readIndex++;
                                if(readIndex > ::objEnd[objectCounter])
                                {
                                    done = true;
                                    break;
                                }
                            }
                            if(lightExclusion)
                            {
                                if(lightExclusion[objectCounter] != nil)
                                {
                                    tempArray = parse("\\n", lightExclusion[objectCounter]);
                                    for (i = 1; i <= size(tempArray); i++)
                                    {
                                        ::writeBuffer[size(::writeBuffer) + 1] = tempArray[i];
                                    }
                                }
                            }
                            ::writeBuffer[size(::writeBuffer) + 1] = "";
                        }
                        // end case 1 here, which is the surface type
                        break;
                    
                    case 2:
                        // begin case 2 here, which is the object properties override type
                        readIndex = ::objStart[objectCounter];
                        done = nil;
                        excludedLightsTemp = 0;
                        while(!done)
                        {
                            line = ::readBuffer[readIndex];
                            readIndex++;
                            mystring = "ShadowOptions ";
                            mystring_len = size(mystring);
                            if(size(line) > mystring_len)
                            {
                                if(strleft(line,mystring_len) != mystring)
                                {
                                    ::writeBuffer[size(::writeBuffer) + 1] = line;
                                    //excludedLightsTemp = 0;
                                }
                                else
                                {
                                    tempArray = parse("\\n", ::objPropOverrideSets[objectCounter]);
                                    for (i = 1; i <= size(tempArray); i++)
                                    {
                                        ::writeBuffer[size(::writeBuffer) + 1] = tempArray[i];
                                    }
                                    tempArray = parse("\\n", ::objPropOverrideShadowOpts[objectCounter]);
                                    for (i = 1; i <= size(tempArray); i++)
                                    {
                                        ::writeBuffer[size(::writeBuffer) + 1] = tempArray[i];
                                    }
                                    excludedLightsTemp = 1;
                                }
                            }
                            else
                            {
                                ::writeBuffer[size(::writeBuffer) + 1] = line;
                            }
                            if(readIndex > ::objEnd[objectCounter])
                            {
                                done = true;
                                break;
                            }
                        }
                        if(excludedLightsTemp == 1)
                        {
                            ::writeBuffer[size(::writeBuffer) + 1] = "";
                        }
                        else
                        {
                            tempArray = parse("\\n", ::objPropOverrideSets[objectCounter]);
                            for (i = 1; i <= size(tempArray); i++)
                            {
                                ::writeBuffer[size(::writeBuffer) + 1] = tempArray[i];
                            }
                            tempArray = parse("\\n", ::objPropOverrideShadowOpts[objectCounter]);
                            for (i = 1; i <= size(tempArray); i++)
                            {
                                ::writeBuffer[size(::writeBuffer) + 1] = tempArray[i];
                            }
                        }
                        if(lightExclusion)
                        {
                            if(lightExclusion[objectCounter] != nil)
                            {
                                tempArray = parse("\\n", lightExclusion[objectCounter]);
                                for (i = 1; i <= size(tempArray); i++)
                                {
                                    ::writeBuffer[size(::writeBuffer) + 1] = tempArray[i];
                                }
                            }
                        }

                        // end case 2 here, which is the object properties override type
                        break;
                        
                    case 3:
                        // begin case 3 here, which is the motion override type
                        if(::motInputTemp[objectCounter] != nil)
                        {
                            // Check that we can find the motion file.
                            fileCheck(::motInputTemp[objectCounter]);
                            motFile = File(::motInputTemp[objectCounter], "r");
                            readIndex = ::objStart[objectCounter];
                            done = nil;
                            while(!done)
                            {
                                ::writeBuffer[size(::writeBuffer) + 1] = ::readBuffer[readIndex];
                                readIndex++;
                                if(readIndex == ::objMotStart[objectCounter])
                                {
                                    done = true;
                                    break;
                                }
                            }
                            motFile.line(4);
                            while(!motFile.eof())
                            {
                                ::writeBuffer[size(::writeBuffer) + 1] = motFile.read();
                            }
                            readIndex = ::objMotEnd[objectCounter] + 1;
                            done = nil;
                            while(!done)
                            {
                                ::writeBuffer[size(::writeBuffer) + 1] = ::readBuffer[readIndex];
                                readIndex++;
                                if(readIndex > ::objEnd[objectCounter])
                                {
                                    done = true;
                                    break;
                                }
                            }
                            motFile.close();
                            if(lightExclusion)
                            {
                                if(lightExclusion[objectCounter] != nil)
                                {
                                    tempArray = parse("\\n", lightExclusion[objectCounter]);
                                    for (i = 1; i <= size(tempArray); i++)
                                    {
                                        ::writeBuffer[size(::writeBuffer) + 1] = tempArray[i];
                                    }
                                }
                            }
                            ::writeBuffer[size(::writeBuffer) + 1] = "";
                        }
                        else
                        {
                            readIndex = ::objStart[objectCounter];
                            done = nil;
                            while(!done)
                            {
                                ::writeBuffer[size(::writeBuffer) + 1] = ::readBuffer[readIndex];
                                readIndex++;
                                if(readIndex > ::objEnd[objectCounter])
                                {
                                    done = true;
                                    break;
                                }
                            }
                            if(lightExclusion)
                            {
                                if(lightExclusion[objectCounter] != nil)
                                {
                                    tempArray = parse("\\n", lightExclusion[objectCounter]);
                                    for (i = 1; i <= size(tempArray); i++)
                                    {
                                        ::writeBuffer[size(::writeBuffer) + 1] = tempArray[i];
                                    }
                                }
                            }
                            ::writeBuffer[size(::writeBuffer) + 1] = "";
                        }
                        // end case 3 here, which is the motion override type
                        break;
                        
                    case 4:
                        // begin case 4 here, which is the alternate object type
                        if(::lwoInputTemp[objectCounter] != nil)
                        {
                            // Check that we can find the file.
                            fileCheck(::lwoInputTemp[objectCounter]);
                            readIndex = ::objStart[objectCounter];
                            line = ::readBuffer[readIndex];
                            readIndex++;
                            if(line != nil && line != "")
                            {
                                parseObjLineTemp = parse(" ",line);
                                if(parseObjLineTemp[1] == "LoadObjectLayer")
                                {
                                    line = parseObjLineTemp[1] + " 1 " + parseObjLineTemp[3] + " " + ::lwoInputTemp[objectCounter];
                                    replacedLWO_nameArray = split(::lwoInputTemp[objectCounter]);
                                    replacedLWO_baseName = replacedLWO_nameArray[3];
                                    ::overriddenObjectID[mmInt] = parseObjLineTemp[3];
                                    ::overriddenObjectName[mmInt] = replacedLWO_baseName;
                                    mmInt = mmInt + 1;
                                }
                            }
                            ::writeBuffer[size(::writeBuffer) + 1] = line;
                            done = nil;
                            while(!done)
                            {
                                ::writeBuffer[size(::writeBuffer) + 1] = ::readBuffer[readIndex];
                                readIndex++;
                                if(readIndex > ::objEnd[objectCounter])
                                {
                                    done = true;
                                    break;
                                }
                            }
                            if(lightExclusion)
                            {
                                if(lightExclusion[objectCounter] != nil)
                                {
                                    tempArray = parse("\\n", lightExclusion[objectCounter]);
                                    for (i = 1; i <= size(tempArray); i++)
                                    {
                                        ::writeBuffer[size(::writeBuffer) + 1] = tempArray[i];
                                    }
                                }
                            }
                            ::writeBuffer[size(::writeBuffer) + 1] = "";
                        }
                        else
                        {
                            readIndex = ::objStart[objectCounter];
                            done = nil;
                            while(!done)
                            {
                                ::writeBuffer[size(::writeBuffer) + 1] = ::readBuffer[readIndex];
                                readIndex++;
                                if(readIndex > ::objEnd[objectCounter])
                                {
                                    done = true;
                                    break;
                                }
                            }
                            if(lightExclusion)
                            {
                                if(lightExclusion[objectCounter] != nil)
                                {
                                    tempArray = parse("\\n", lightExclusion[objectCounter]);
                                    for (i = 1; i <= size(tempArray); i++)
                                    {
                                        ::writeBuffer[size(::writeBuffer) + 1] = tempArray[i];
                                    }
                                }
                            }
                            ::writeBuffer[size(::writeBuffer) + 1] = "";
                        }
                        // end case 4 here, which is the alternate object type
                        break;
                        
                    case 7:
                        readIndex = ::objStart[objectCounter];
                        done = nil;
                        while(!done)
                        {
                            ::writeBuffer[size(::writeBuffer) + 1] = ::readBuffer[readIndex];
                            readIndex++;
                            if(readIndex > ::objEnd[objectCounter])
                            {
                                done = true;
                                break;
                            }
                        }
                        if(lightExclusion)
                        {
                            if(lightExclusion[objectCounter] != nil)
                            {
                                tempArray = parse("\\n", lightExclusion[objectCounter]);
                                for (i = 1; i <= size(tempArray); i++)
                                {
                                    ::writeBuffer[size(::writeBuffer) + 1] = tempArray[i];
                                }
                            }
                        }                   
                        ::writeBuffer[size(::writeBuffer) + 1] = "";
                        break;
                        
                    default:
                        readIndex = ::objStart[objectCounter];
                        done = nil;
                        while(!done)
                        {
                            ::writeBuffer[size(::writeBuffer) + 1] = ::readBuffer[readIndex];
                            readIndex++;
                            if(readIndex > ::objEnd[objectCounter])
                            {
                                done = true;
                                break;
                            }
                        }
                        ::writeBuffer[size(::writeBuffer) + 1] = "";
                        break;

                // end override type switch statement here
                }
                
            }
            else
            {
                readIndex = ::objStart[objectCounter];
                done = nil;
                while(!done)
                {
                    ::writeBuffer[size(::writeBuffer) + 1] = ::readBuffer[readIndex];
                    readIndex++;
                    if(readIndex == ::objEnd[objectCounter])
                    {
                        done = true;
                        break;
                    }
                }
                ::writeBuffer[size(::writeBuffer) + 1] = "";
            }
        }
    }
    else
    {
        ::lastObject = 0;
    }
}

writeLights: IKInitialState
{
    for(lightCounter = ::lastObject + 1; lightCounter <= ::lastObject + ::lastLight; lightCounter++)
    {
        progressString = string(((lightCounter/(::lastObject + ::lastLight))/4) + (2 / ::noOfStages));
        msgString = "{" + progressString + "}Generating Render Scene:  Writing Lights...";
        StatusMsg(msgString);
        sleep(1);
        
        if(::doOverride[lightCounter] == 1)
        {
            switch(::overrideType[lightCounter])
            {
                case 5:
                    // begin case 5 here, which is the light properties override type
                    if(::lightSettingsPartOne[lightCounter] != nil)
                    {
                        // write out the beginning of the light
                        readIndex = ::objStart[lightCounter];
                        done = nil;
                        while(!done)
                        {
                            ::writeBuffer[size(::writeBuffer) + 1] = ::readBuffer[readIndex];
                            readIndex++;
                            if(readIndex == (IKInitialState[lightCounter]) + 1)
                            {
                                done = true;
                                break;
                            }
                        }
                        
                        // write out the custom parameters
                        tempArray = parse("\\n", ::lightSettingsPartOne[lightCounter]);
                        for (i = 1; i <= size(tempArray); i++)
                        {
                            ::writeBuffer[size(::writeBuffer) + 1] = tempArray[i];
                        }

                        // write out the rest of the light, first volumetrics, then flare, then rest
                        readIndex = ::objAffectCausticsLine[lightCounter];
                        if(::objVolLightLine[lightCounter] != nil)
                        {
                            done = nil;
                            endLine = ::objVolLightLine[lightCounter];
                            while(!done)
                            {
                                ::writeBuffer[size(::writeBuffer) + 1] = ::readBuffer[readIndex];
                                readIndex++;
                                if(readIndex == endLine)
                                {
                                    tempArray = parse("\\n", ::lightSettingsPartThree[lightCounter]);
                                    for (i = 1; i <= size(tempArray); i++)
                                    {
                                        ::writeBuffer[size(::writeBuffer) + 1] = tempArray[i];
                                    }
                                    done = true;
                                    break;
                                }
                            }
                        }
                        if(::objLensFlareLine[lightCounter] != nil)
                        {
                            endLine = ::objLensFlareLine[lightCounter];
                            done = nil;
                            while(!done)
                            {
                                ::writeBuffer[size(::writeBuffer) + 1] = ::readBuffer[readIndex];
                                readIndex++;
                                if(readIndex == endLine)
                                {
                                    tempArray = parse("\\n", ::lightSettingsPartTwo[lightCounter]);
                                    for (i = 1; i <= size(tempArray); i++)
                                    {
                                        ::writeBuffer[size(::writeBuffer) + 1] = tempArray[i];
                                    }
                                    done = true;
                                    break;
                                }
                            }
                        }    
                        done = nil;
                        while(!done)
                        {
                            ::writeBuffer[size(::writeBuffer) + 1] = ::readBuffer[readIndex];
                            readIndex++;
                            if(readIndex == ::objEnd[lightCounter])
                            {
                                done = true;
                                break;
                            }
                        }
                    }
                    else
                    {
                        readIndex = ::objStart[lightCounter];
                        done = nil;
                        while(!done)
                        {
                            ::writeBuffer[size(::writeBuffer) + 1] = ::readBuffer[readIndex];
                            readIndex++;
                            if(readIndex == ::objEnd[lightCounter])
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
                    if(::motInputTemp[lightCounter] != nil)
                    {
                        // Check file is valid.
                        fileCheck(::motInputTemp[lightCounter]);
                        motFile = File(::motInputTemp[lightCounter],"r");
                        readIndex = ::objStart[lightCounter];
                        done = nil;
                        while(!done)
                        {
                            ::writeBuffer[size(::writeBuffer) + 1] = ::readBuffer[readIndex];
                            readIndex++;
                            if(readIndex == (::objMotStart[lightCounter]))
                            {
                                done = true;
                                break;
                            }
                        }
                        motFile.line(4);
                        while(!motFile.eof())
                        {
                            line = motFile.read();
                            ::writeBuffer[size(::writeBuffer) + 1] = line;
                        }
                        inputFile.line(::objMotEnd[lightCounter] + 1);
                        done = nil;
                        while(!done)
                        {
                            ::writeBuffer[size(::writeBuffer) + 1] = ::readBuffer[readIndex];
                            readIndex++;
                            if(readIndex == ::objEnd[lightCounter])
                            {
                                done = true;
                                break;
                            }
                        }
                        motFile.close();
                    }
                    else
                    {
                        readIndex = ::objStart[lightCounter];
                        done = nil;
                        while(!done)
                        {
                            ::writeBuffer[size(::writeBuffer) + 1] = ::readBuffer[readIndex];
                            readIndex++;
                            if(readIndex == ::objEnd[lightCounter])
                            {
                                done = true;
                                break;
                            }
                        }
                    }
                    // end case 3 here, which is the motion override type
                    break;
                
                default:
                    readIndex = ::objStart[lightCounter];
                    done = nil;
                    while(!done)
                    {
                        ::writeBuffer[size(::writeBuffer) + 1] = ::readBuffer[readIndex];
                        readIndex++;
                        if(readIndex == ::objEnd[lightCounter])
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
            readIndex = ::objStart[lightCounter];
            done = nil;
            while(!done)
            {
                ::writeBuffer[size(::writeBuffer) + 1] = ::readBuffer[readIndex];
                readIndex++;
                if(readIndex == ::objEnd[lightCounter])
                {
                    done = true;
                    break;
                }
            }
        }
    }
    ::writeBuffer[size(::writeBuffer) + 1] = "";
}

fiberFXOverride
{
    ffxLine = getPixelFilterLine("FiberFilter");
    if (!ffxLine)
    {
        // No FFx entries
        return 0;
    }

    // Let's check if it's version 3 or 4 - we support both.
    ffxVersion = int(strright(::readBuffer[ffxLine + 2],1));
    if(ffxVersion != "3" && ffxVersion != "4")
    {
        logger("warn","FiberFX detected, but version mismatched - we support version 3 or version 4.");
        return 0;
    }

    ::fiberFXSaveRGBA             = integer(::settingsArray[50]);
    ::fiberFXSaveRGBAType         = integer(::settingsArray[51]);
    ::fiberFXSaveRGBAName         = string(::settingsArray[52]);
    ::fiberFXSaveDepth            = integer(::settingsArray[53]);
    ::fiberFXSaveDepthType        = integer(::settingsArray[54]);
    ::fiberFXSaveDepthName        = string(::settingsArray[55]);

    // Hard-coded offsets from the detected pixel filter line, based on scene file inspection.
    ffxString = "SaveRGBA " + string(fiberFXSaveRGBA);
    changeScnLine(ffxString, ffxLine + 8);

    ffxString = "SaveDepth " + string(fiberFXSaveDepth);
    changeScnLine(ffxString, ffxLine + 9);

    ffxString = "RGBType " + string(::image_formats_array[fiberFXSaveRGBAType]);
    changeScnLine(ffxString, ffxLine + 10);

    ffxString = "DepthType " + string(::image_formats_array[fiberFXSaveDepthType]);
    changeScnLine(ffxString, ffxLine + 11);

    ffxString = "RGBName " + string(fiberFXSaveRGBAName);
    changeScnLine(ffxString, ffxLine + 12);

    ffxString = "DepthName " + string(fiberFXSaveDepthName);
    changeScnLine(ffxString, ffxLine + 13);

    return 1;
}

fiberFX
{
    // LW only allows one instance of the plugin, so we only need one check and adjustment sequence.
    ffxDebug = 0;
    // Let's check if FiberFX was even applied.
    ffxLine = getPixelFilterLine("FiberFilter");
    if (!ffxLine)
    {
        // No FFx entries
        return 0;
    }
    
    // Let's check if it's version 3 or later - we support both.
    ffxVersion = int(strright(::readBuffer[ffxLine + 2],1));
    if(ffxVersion != "4")
    {
        logger("warn","FiberFX detected, but version mismatched - we only support 11.6-authored FiberFX scenes!");
        return 0;
    }

    ffxHeaderEndLine = getPartialLine(ffxLine,0,"ToggleOff"); // This line is the last before the item specific entries.

    ffxEndLine = getPartialLine(ffxLine,0,"EndPlugin"); // End of plugin block.


    // We need to extract item IDs from the scene file to then check against our pass items.
    ffxItems = getFFxItems(ffxLine);
    if (ffxItems == nil)
    {
        // No item IDs found. Nothing to do.
        if (ffxDebug == 1)
        {
            logger("log_info","fiberFX: Nothing found");
        }
        return 0;
    }

    // Let's get our start and end lines for each item using FFx.
    // We'll need to make a temporary, translated array of IDs from our pass items.
    passItems = parse("||", ::passAssItems[::pass]);
    for (j = 1; j <= size(passItems); j++)
    {
        // passAssItems stores the decimal ID value. FFx and the scene file use the hexadecimal representation (also stored in the oldIDs array)
        // We need to get creative in comparing them.
        tArray = parse("x",hex(int(passItems[j])));
        tempID[j] = tArray[2];
    }

    matchedFFXItems;
    matchedFFXItemsCounter = 1;

    for (i = 1; i <= size(ffxItems); i++)
    {
        if (ffxDebug == 1)
        {
            logger("log_info","fiberFX: Checking FFID: " + ffxItems[i].asStr());
        }
        ffxMatchFound = tempID.indexOf(string(ffxItems[i]));
        if(ffxMatchFound != 0)
        {
            matchedFFXItems[matchedFFXItemsCounter] = ffxItems[i];
            matchedFFXItemsCounter++;
        }
    }

    if (matchedFFXItemsCounter == 1) // safety catch.
    {
        logger("warn","fiberFX: FiberFX active, but no items in the pass or we encountered an error during ID matching. Report the latter, please.");
        logger("info","fiberFX: Stripping FiberFX from scene, to allow render to pass.");
        stripFiberFX(ffxLine, ffxEndLine);
        return 0;
    } else {
        // logger("log_info","fiberFX: Matched " + size(matchedFFXItems) + " items");
    }

    ffxChunkLineArrayIndex = 1;
    for (i = 1; i <= size(matchedFFXItems); i++)
    {
        ffxItemID = matchedFFXItems[i];
        if (ffxDebug == 1)
        {
            logger("log_info","fiberFX: Processing FFID: " + ffxItemID.asStr());
        }

        readIndex = ffxLine;
        ffxStartString = "  Itemid " + ffxItemID.asStr();
        ffxEndString = "  VolumeType";
        while(readIndex <= size(::readBuffer))
        {
            ffxLineTemp = ::readBuffer[readIndex];
            readIndex++;
            if (ffxLineTemp == ffxStartString)
            {
                ffxChunkStartLineArray[ffxChunkLineArrayIndex] = readIndex - 3; // hard-coded offset to start of block
                ffx_s_found = 1;
            }
            if ((strleft(ffxLineTemp, ffxEndString.size()) == ffxEndString) && (ffx_s_found == 1))
            {
                ffxChunkEndLineArray[ffxChunkLineArrayIndex] = readIndex + 11; // hard-coded offset to end of block
                ffx_s_found = 0;
                if (ffxDebug == 1)
                {
                    logger("log_info",ffxChunkStartLineArray[ffxChunkLineArrayIndex].asStr() + "/" + ffxChunkEndLineArray[ffxChunkLineArrayIndex]);
                }
                ffxChunkLineArrayIndex++;
            }
        }
    }

    // Now we need to write out the sections we care about.
    readIndex = 1;
    while(readIndex <= ffxHeaderEndLine)
    {
        ::writeBuffer[readIndex] = ::readBuffer[readIndex];
        readIndex++;
    }

    // Now we write out our sections from above.
    for(i = 1; i <= size(matchedFFXItems); i++)
    {
        ffxItemID = matchedFFXItems[i];
        if (ffxDebug == 1)
        {
            logger("log_info","fiberFX: Writing FFID: " + ffxItemID);
        }
        readIndex = ffxChunkStartLineArray[i];
        while(readIndex <= ffxChunkEndLineArray[i])
        {
            ::writeBuffer[size(::writeBuffer) + 1] = ::readBuffer[readIndex];
            readIndex++;
        }
    }

    readIndex = ffxEndLine;
    while(readIndex <= size(::readBuffer))
    {
        ::writeBuffer[size(::writeBuffer) + 1] = ::readBuffer[readIndex];
        readIndex++;
    }

    // Push the output back to the original file.
    ::readBuffer = ::writeBuffer;
    ::writeBuffer = nil;

    return 1; // notify caller that we changed something.
}

stripFiberFX: ffxLine, ffxEndLine
{
    ffxVolFilterLine = getVolumetricHandlerLine(".FiberVolume");
    // Walk the scene file to strip the FiberFX entries. Fail-safe.
    stripFiberFFX_input = File(ffxFile, "r");
    stripffxFile = ::tempDirectory + getsep() + "tempPassportInputFile_StripFFx.lws";
    stripFiberFFX_output = File(stripffxFile, "w");
    readIndex = 1;
    while(readIndex < ffxVolFilterLine)
    {
        ::writeBuffer[size(::writeBuffer) + 1] = ::readBuffer[readIndex];
        readIndex++;
    }
    readIndex += 2; // skip vol and end plugin lines

    while(readIndex < ffxLine)
    {
        ::writeBuffer[size(::writeBuffer) + 1] = ::readBuffer[readIndex];
        readIndex++;
    }
    readIndex = (ffxEndLine + 1);
    while(readIndex <= size(::readBuffer))
    {
        ::writeBuffer[size(::writeBuffer) + 1] = ::readBuffer[readIndex];
        readIndex++;
    }
    ::readBuffer = ::writeBuffer;
    ::writeBuffer = nil;
}

handleBuffers: mode, redirectBuffersSetts, outputFolder, outputStr, fileOuputPrefix, userOutputString // if you edit this, don't forget to extend defaultBufferExporters as well and the new/edit pass dialog to set the values accordingly. You'll also need to bump the version due to mismatches.
{
    if(redirectBuffersSetts == 1)
    {
        readIndex = 1;
        while(readIndex <= size(::readBuffer))
        {
            line = ::readBuffer[readIndex];
            readIndex++;
            searchString = "Plugin ImageFilterHandler ";
            if(size(line) > searchString.size())
            {
                if(strleft(line,searchString.size()) == searchString)
                {
                    bufferTestLineParse = parse(" ",line);
                    // compositing buffer exporter - experimental with beta 8
                    if(bufferTestLineParse[4] == "LW_CompositeBuffer")
                    {
                        for(i = 1; i <= 3; i++)
                        {
                            ::writeBuffer[size(::writeBuffer) + 1] = line;
                            line = ::readBuffer[readIndex];
                            readIndex++;
                        }
                        baseNameArray = parse(getsep(),line);
                        if(baseNameArray[size(baseNameArray)] != nil && baseNameArray[size(baseNameArray)] != "")
                        {
                            compositeBaseName = baseNameArray[size(baseNameArray)];
                            updatedCompositeSaverPath = "    \"" + generatePath("filter_2sep", outputFolder, outputStr, ::fileOutputPrefix, ::userOutputString, compositeBaseName);

                            if(platform() == INTEL)
                            {
                                noIntroPath = "\"" + generatePath("filter_2sep", outputFolder, outputStr, ::fileOutputPrefix, ::userOutputString, compositeBaseName);
                                tempFixedPath = fixPathForWin32(noIntroPath);
                                noIntroPath = tempFixedPath;
                                newPathFixed = "    " + noIntroPath;

                                toWrite = newPathFixed;
                            }
                            else
                            {
                                toWrite = updatedCompositeSaverPath;
                            }
                        }
                        else
                        {
                            toWrite = line;
                        }
                    }

                    // exrTrader - experimental with beta 8
                    if(bufferTestLineParse[4] == "exrTrader")
                    {
                        for(i = 1; i <= 3; i++)
                        {
                            ::writeBuffer[size(::writeBuffer) + 1] = line;
                            line = ::readBuffer[readIndex];
                            readIndex++;
                        }
                        baseNameArray = parse(getsep(),line);
                        if(baseNameArray[size(baseNameArray)] != nil && baseNameArray[size(baseNameArray)] != "")
                        {
                            compositeBaseName = baseNameArray[size(baseNameArray)];
                            updatedCompositeSaverPath = "    \"" + generatePath("filter_2sep", outputFolder, outputStr, ::fileOutputPrefix, ::userOutputString, compositeBaseName);

                            if(platform() == INTEL)
                            {
                                noIntroPath = "\"" + generatePath("filter_2sep", outputFolder, outputStr, ::fileOutputPrefix, ::userOutputString, compositeBaseName);
                                tempFixedPath = fixPathForWin32(noIntroPath);
                                noIntroPath = tempFixedPath;
                                newPathFixed = "    " + noIntroPath;

                                toWrite = newPathFixed;
                            }
                            else
                            {
                                toWrite = updatedCompositeSaverPath;
                            }
                        }
                        else
                        {
                            toWrite = line;
                        }
                    }

                    // the stock render buffer exporter
                    if(bufferTestLineParse[4] == "LW_SpecialBuffers")
                    {
                        for(i = 1; i <= 2; i++)
                        {
                            ::writeBuffer[size(::writeBuffer) + 1] = line;
                            line = ::readBuffer[readIndex];
                            readIndex++;
                        }
                        if(line == "0")
                        {
                            ::writeBuffer[size(::writeBuffer) + 1] = line;
                            line = ::readBuffer[readIndex];
                            readIndex++;
                            baseNameArray = parse(getsep(),line);
                            if(baseNameArray[size(baseNameArray)] != nil && baseNameArray[size(baseNameArray)] != "")
                            {
                                bufferBaseName = baseNameArray[size(baseNameArray)];
                                updatedBufferSaverPath = "\"" + generatePath("filter", outputFolder, outputStr, ::fileOutputPrefix, ::userOutputString, bufferBaseName);

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
                        for(i = 1; i <= 2; i++)
                        {
                            ::writeBuffer[size(::writeBuffer) + 1] = line;
                            line = ::readBuffer[readIndex];
                            readIndex++;
                        }
                        if(strleft(line,5) == "Path ")
                        {
                            baseNameArray = parse(getsep(),line);
                            if(baseNameArray[size(baseNameArray)] != nil && baseNameArray[size(baseNameArray)] != "")
                            {
                                psdBaseName = baseNameArray[size(baseNameArray)];
                                updatedPsdSaverPath = "Path \"" + generatePath("filter_2sep", outputFolder, outputStr, ::fileOutputPrefix, ::userOutputString, psdBaseName);

                                if(platform() == INTEL)
                                {
                                    noIntroPath = "\"" + generatePath("filter_2sep", outputFolder, outputStr, ::fileOutputPrefix, ::userOutputString, psdBaseName);
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
                        for(i = 1; i <= 2; i++)
                        {
                            ::writeBuffer[size(::writeBuffer) + 1] = line;
                            line = ::readBuffer[readIndex];
                            readIndex++;
                        }
                        if(strleft(line,1) != "")
                        {
                            baseNameArray = parse(getsep(),line);
                            if(baseNameArray[size(baseNameArray)] != nil && baseNameArray[size(baseNameArray)] != "")
                            {
                                rlaBaseName = baseNameArray[size(baseNameArray)];
                                updatedRlaSaverPath = generatePath("filter", outputFolder, outputStr, ::fileOutputPrefix, ::userOutputString, rlaBaseName);
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
                        for(i = 1; i <= 2; i++)
                        {
                            ::writeBuffer[size(::writeBuffer) + 1] = line;
                            line = ::readBuffer[readIndex];
                            readIndex++;
                        }
                        if(strleft(line,1) != "")
                        {
                            baseNameArray = parse(getsep(),line);
                            if(baseNameArray[size(baseNameArray)] != nil && baseNameArray[size(baseNameArray)] != "")
                            {
                                rpfBaseName = baseNameArray[size(baseNameArray)];
                                updatedRpfSaverPath = "\"" + generatePath("filter", outputFolder, outputStr, ::fileOutputPrefix, ::userOutputString, rpfBaseName);
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
                        for(i = 1; i <= 2; i++)
                        {
                            ::writeBuffer[size(::writeBuffer) + 1] = line;
                            line = ::readBuffer[readIndex];
                            readIndex++;
                        }
                        if(strleft(line,1) == "\"")
                        {
                            baseNameArray = parse(getsep(),line);
                            if(baseNameArray[size(baseNameArray)] != nil && baseNameArray[size(baseNameArray)] != "")
                            {
                                auraBaseName = baseNameArray[size(baseNameArray)];
                                updatedAuraSaverPath = "\"" + generatePath("filter_2sep", outputFolder, outputStr, ::fileOutputPrefix, ::userOutputString, auraBaseName);
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
                        for(i = 1; i <= 9; i++)
                        {
                            ::writeBuffer[size(::writeBuffer) + 1] = line;
                            line = ::readBuffer[readIndex];
                            readIndex++;
                        }
                        if(strleft(line,1) != "")
                        {
                            baseNameArray = parse(getsep(),line);
                            if(baseNameArray[size(baseNameArray)] != nil && baseNameArray[size(baseNameArray)] != "")
                            {
                                idofBaseName = baseNameArray[size(baseNameArray)];
                                updatedIdofSaverPath = generatePath("filter", outputFolder, outputStr, ::fileOutputPrefix, ::userOutputString, idofBaseName);
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
            ::writeBuffer[size(::writeBuffer) + 1] = toWrite;
        }
        ::readBuffer = ::writeBuffer;
        ::writeBuffer = nil;
    }
    passBufferSetup();
}

// This function is called from handleBuffers and it works to (de)activate buffer exporters (image filters) for the current pass.
passBufferSetup
{
    pbsSettings = parse("||",::passBufferExporters[::pass]);

    if(int(pbsSettings[1]) == 0)
    {
        return; // user didn't opt to have us change their exporter settings, so we won't do it. We're good like that.
    } else {

        // Setting order defined in the global definitions.
        compBuffSetting         = int(pbsSettings[2]);
        exrTraderSetting        = int(pbsSettings[3]);
        specBuffersSetting      = int(pbsSettings[4]);
        psdBuffersSetting       = int(pbsSettings[5]);
        extRLABuffersSetting    = int(pbsSettings[6]);
        extRPFBuffersSetting    = int(pbsSettings[7]);
        auraBuffersSetting      = int(pbsSettings[8]);
        iDOFBuffersSetting      = int(pbsSettings[9]);

        passBufferSetup_processBufferSetting("LW_CompositeBuffer", compBuffSetting);
        passBufferSetup_processBufferSetting("exrTrader", exrTraderSetting);
        passBufferSetup_processBufferSetting("LW_SpecialBuffers", specBuffersSetting);
        passBufferSetup_processBufferSetting("LW_PSDExport", psdBuffersSetting);
        passBufferSetup_processBufferSetting("LW_ExtendedRLAExport", extRLABuffersSetting);
        passBufferSetup_processBufferSetting("LW_ExtendedRPFExport", extRPFBuffersSetting);
        passBufferSetup_processBufferSetting("Aura25Export", auraBuffersSetting);
        passBufferSetup_processBufferSetting("iDof_channels_IF", iDOFBuffersSetting);
    }
}

passBufferSetup_processBufferSetting: imageFilterString, imageFilterSetting
{
    imageFilterLinesIndex = 0;
    readIndex = 1;
    while(readIndex <= size(::readBuffer))
    {
        line = ::readBuffer[readIndex];
        readIndex++;
        searchString = "Plugin ImageFilterHandler ";
        if(size(line) > size(searchString))
        {
            if(strleft(line,size(searchString)) == searchString)
            {
                pbsTestLineParse = parse(" ",line);
                // Here we check for a match to the image filter string fed in..
                // If found, we store the line we need to change to activate or deactivate the buffer exporter in the scene file (an offset from the detected line containing the exporter itself).
                // LW has a plugin activated by default. If the plugin is deactivated, it adds 'PluginEnabled 0' in a new line after the EndPlugin line. *sigh*
                // For now, we retrieve the end plugin line. We'll have to check for the existence of a 'PluginEnabled' line when activating/deactivating the plugins.

                if(pbsTestLineParse[4] == imageFilterString)
                {
                    imageFilterLinesIndex++;
                    endPluginLine = getPartialLine(lineNumber,0,"EndPlugin");
                    imageFilterLines[imageFilterLinesIndex] = endPluginLine;
                }
            }
        }
        lineNumber++;
    }
    
    if(imageFilterLinesIndex >= 1) // We detected at least one buffer exporter of this type.
    {
        lineOffset = 0; // We'll need to modify this as we go to ensure we target the correct lines.
                        // Needs to be incremented when we insert 'PluginEnabled 0' lines for active plugins. We change 'PluginEnabled 0' to 'PluginEnabled 1' rather than removing lines,for simplicity.

        ::writeBuffer = ::readBuffer;

        for(i = 1; i <= imageFilterLinesIndex; i++)
        {
            // Assume plugin is currently enabled.
            state = 1;
            // Let's figure out what state this plugin is in.
            line = ::readdBuffer[imageFilterLines[i] + 1];
            if(strleft(line,14) == "PluginEnabled ")
            {
                state = int(parse(" ", line));
            }

            // Now we know what state the plugin is in. Let's find out if we need to do something.
            if(imageFilterSetting != state)
            {
                makeChange = 1;
                if(state == 0)
                {
                    changeScnLine("PluginEnabled 1", imageFilterLines[i] + 1 + lineOffset);
                } else {
                    insertScnLine("PluginEnabled 0", imageFilterLines[i] + lineOffset);
                    lineOffset++;
                }
            }
        }
        if(makeChange == 1)
        {
            ::readBuffer = ::writeBuffer;
        }
        ::writeBuffer = nil;
    }
}

motionMixerStuff
{
    if(::overriddenObjectID != nil)
    {
        // check for clones of motion mixer items
        clonedMMItems = false;
        for(x = 1; x <= size(::overriddenObjectID); x++)
        {
            for(y = 1; y <= size(::overriddenObjectID); y++)
            {
                if(x != y && ::overriddenObjectID[x] == ::overriddenObjectID[y])
                {
                    clonedMMItems = true;
                }
            }
        }
        
        for(x = 1; x <= size(::overriddenObjectID); x++)
        {
            readIndex = 2;
            
            mmItemIDLine = nil;
            // find the line in the motion mixer stuff if it exists...
            while(readIndex <= size(::readBuffer))
            {
                line = ::readBuffer[readIndex];
                readIndex++;
                if(size(line) >= 22)
                {
                    stringTempAdd = "      ItemAdd " + string(::overriddenObjectID[x]);
                    if(strleft(line,22) == stringTempAdd)
                    {
                        mmItemIDLine = readIndex;
                    }
                }
            }

            // if the item line exists in the motion mixer stuff, read the line before it to get the object name
            if(mmItemIDLine != nil)
            {
                if(clonedMMItems == true)
                {
                    logger("error","PassPort has found clones being overridden in a scene with Motion Mixer.  Please resolve clone naming.");
                }

                readIndex = mmItemIDLine - 2;
                mmItemToReplace = ::readBuffer[readIndex];
                readIndex++;
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
                
                replacementStringOne = "      ItemName \"" + ::overriddenObjectName[x];
                replacementStringTwo = "          ItemName \"" + ::overriddenObjectName[x];
                replacementStringThree = "            ChannelName \"" + ::overriddenObjectName[x];
                replacementStringFour = "              TrackMotionItemName \"" + ::overriddenObjectName[x];
                
                readIndex = 1;
                
                while(readIndex <= size(::readBuffer))
                {
                    line = ::readBuffer[readIndex];
                    readIndex++;
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
                    ::writeBuffer[size(::writeBuffer) + 1] = line;
                }
                
                ::readBuffer = ::writeBuffer;
                ::writeBuffer = nil;
                readIndex = 1;
                
                while(readIndex <= size(::readBuffer))
                {
                    line = ::readBuffer[readIndex];
                    readIndex++;
                    if(size(line) > size(replaceStringTwo))
                    {
                        if(strleft(line,size(replaceStringTwo)) == replaceStringTwo)
                        {
                            n = size(line) - size(replaceStringTwo);
                            lineTemp = replacementStringTwo + strright(line,n);
                            line = lineTemp;
                        }
                    }
                    ::writeBuffer[size(::writeBuffer) + 1] = line;
                }

                ::readBuffer = ::writeBuffer;
                ::writeBuffer = nil;
                readIndex = 1;

                while(readIndex <= size(::readBuffer))
                {
                    line = ::readBuffer[readIndex];
                    readIndex++;
                    if(size(line) > size(replaceStringThree))
                    {
                        if(strleft(line,size(replaceStringThree)) == replaceStringThree)
                        {
                            n = size(line) - size(replaceStringThree);
                            lineTemp = replacementStringThree + strright(line,n);
                            line = lineTemp;
                        }
                    }
                    ::writeBuffer[size(::writeBuffer) + 1] = line;
                }

                ::readBuffer = ::writeBuffer;
                ::writeBuffer = nil;
                readIndex = 1;
                
                while(readIndex <= size(::readBuffer))
                {
                    line = ::readBuffer[readIndex];
                    readIndex++;
                    if(size(line) > size(replaceStringFour))
                    {
                        if(strleft(line,size(replaceStringFour)) == replaceStringFour)
                        {
                            n = size(line) - size(replaceStringFour);
                            lineTemp = replacementStringFour + strright(line,n);
                            line = lineTemp;
                        }
                    }
                    ::writeBuffer[size(::writeBuffer) + 1] = line;
                }
                ::readBuffer = ::writeBuffer;
                ::writeBuffer = nil;
            }
            // end of the mm if and else statement here
            // write out the scene, replacing the motion mixer stuff with the object name with the overridden info
        }
    //end of all the mm stuff
    }
}

dependencyCheck
{
    dcDebug = 1;
    // We want to notify the user if the pass has unsatisfied references.
    // There's no way to do this except manually, case-by-case.
    // We don't check certain cases because other functions (e.g. the FiberFX handler) trim dependencies.
    // Some elements reference item IDs and others reference the name. We have an ID array for the pass.
    // We'll need to construct the name array.

    dcIDArray = parse("||", ::passAssItems[::pass]); // pull decimal ID.
    if (size(dcIDArray) == 0)
        return;

    dcArrayCounter = 0;
    for (i = 1; i <= size(dcIDArray); i++)
    {
        dcIDArray[i] = int(dcIDArray[i]);
        for (j = 1; j <= size(::displayIDs); j++)
        {
            if (dcIDArray[i] == ::displayIDs[j])
            {
                dcArrayCounter++;
                dcIDArray[i] = int(::displayOldIDs[j]); // remap to hex based ID to align with LWS.
                dcGenusArray[dcArrayCounter] = int(::displayGenus[j]);
                dcNameArray[dcArrayCounter] = string(::displayNames[j]);
            }
        }
    }

    if(dcArrayCounter == 0)
    {
        // Something went wrong. Let's find out what that might be.
        logger("warn","dependencyCheck: failed. dcNameArray is " + size(dcNameArray).asStr() + " long.");
        return;
    }

    dcRelItemsReported =  nil; // array to hold reported breakage item names for Relativity. Allows us to avoid reporting multiple instances of the same breakage.
    // Let's get started.
    for (i = 1; i <= size(dcIDArray); i++)
    {
        dependencyCheck_Relativity(dcIDArray[i], dcGenusArray[i], dcGenusArray, dcNameArray);
    }
}

dependencyCheck_Relativity: dcID, dcGenus, dcGenusArray, dcNameArray
{
    // Let's see if we find Relativity applied.
    // We don't anticipate more than one instance of each type of modifier on the item.
    // This is an issue for the channel modifier, though.
    // Note that we get paired values back for start and end lines of each setting type.
    relModifierTypes = @"Motion", "Channel"@;

    for(i = 1; i <= size(dcNameArray); i++)
    {
        dcRelNameArray[i] = strlower(dcNameArray[i]); // Relativity drops all names to lower case.
    }
    dcRelNameArrayIndex = size(dcRelNameArray);
    for(i = 1; i <= size(dcGenusArray); i++)
    {
        if(dcGenusArray[i] == MESH)
        {
            insertionPoint = 0;
            // Need to append .lwo to the object name to handle the Relativity pattern matching
            tempString = dcNameArray[i];
            if(strsub(tempString,size(tempString),1) == "\)")
            {
                for (j = size(tempString); j >= 1; j--)
                {
                    // Find the matching opening bracket
                    if(strsub(tempString,j,1) == "\(")
                    {
                        insertionPoint = j - 2; // should end up before the space preceding the bracket.
                    }
                }
            }

            // OK. Let's append or insert .lwo as needed. We then graft this to the end of our array
            if(insertionPoint == 0)
            {
                dcRelTempString = dcRelNameArray[i] + ".lwo";
            } else {
                dcRelTempString = strsub(dcRelNameArray[i],1,insertionPoint) + ".lwo" + strsub(dcRelNameArray[i],insertionPoint + 1,size(dcRelNameArray[i]) - (insertionPoint));
            }
            dcRelNameArrayIndex++;
            dcRelNameArray[dcRelNameArrayIndex] = dcRelTempString;
        }
    }

    for (rType = 1; rType <= size(relModifierTypes); rType++)
    {
        relativityLineArray = nil; // empty array.
        relativityLineArray = getRelativityLines(relModifierTypes[rType], dcID, dcGenus);

        // OK. We have our start and end lines.
        if(relativityLineArray)
        {
            // logger("info_log", "Relativity found for " + dcID.asStr()); 
            r = 0;
            while (r < size(relativityLineArray))
            {
                r++;
                dcRelLineNumber = relativityLineArray[r];
                r++;
                dcEndLineNumber = relativityLineArray[r];
                readIndex = dcRelLineNumber;
                while (readIndex <= dcEndLineNumber)
                {
                    dcRelString = ::readBuffer[readIndex];
                    // Use our custom extracter. We should get back an array
                    dcRelItems = extractRelativityItems(dcRelString);

                    if (dcRelItems != nil)
                    {
                        // We're not done yet - we need to check our returned array against our pass
                        // item names.

                        for (dcRelItemIndex = 1; dcRelItemIndex <= size(dcRelItems); dcRelItemIndex++)
                        {
                            dcRelItemMatched = dcRelNameArray.indexOf(dcRelItems[dcRelItemIndex]);
                            if (dcRelItemMatched == 0)
                            {
                                // Need to filter to only report once per broken dependency against the item name in the entire scene.
                                // Need an array to track reported errors.
                                tempString = dcRelItems[dcRelItemIndex];
                                relDisplayMessage = 0;
                                if (dcRelItemsReported == nil)
                                {
                                    dcRelItemsReported[1] = dcRelItems[dcRelItemIndex];
                                    relDisplayMessage = 1;
                                }
                                else if (dcRelItemsReported.indexOf(tempString) == 0)
                                {
                                    dcRelItemsReported[size(dcRelItemsReported) + 1] = dcRelItems[dcRelItemIndex];
                                    relDisplayMessage = 1;
                                }
                                if (relDisplayMessage == 1)
                                {
                                    relStringToDisplay = "Relativity dependency for " + dcRelItems[dcRelItemIndex] + " not satisified in this pass.";
                                    if(::errorOnDependency == 1)
                                    {
                                        logger("error",relStringToDisplay);
                                    } else {
                                        logger("warn",relStringToDisplay);
                                    }
                                }
                            }
                        }
                    }
                    readIndex++;
                }
            }
        }
    }
}

hyperVoxels3
{
    // LW only allows one instance of the plugin, so we only need one check and adjustment sequence.
    hv3Debug = 0;
    // Let's check if HV3 was even applied.
    hv3Line = getVolumetricHandlerLine("HyperVoxelsFilter");
    if (!hv3Line)
    {
        // No HV3 entries
        return 0;
    }
    
    hv3HeaderEndLine = getPartialLine(hv3Line,0,"HVBlendingGroups"); // This line is the last before the item specific entries.

    hv3EndLine = getPartialLine(hv3Line,0,"EndPlugin") - 1; // End of plugin block. Decrement to capture closing brace.

    // We need to extract item IDs from the scene file to then check against our pass items.
    hv3Items = getHyperVoxels3Items(hv3Line);
    if (hv3Items == nil)
    {
        // No item IDs found. Nothing to do.
        if (hv3Debug == 1)
        {
            logger("log_info","hyperVoxels3: Nothing found");
        }
        return 0;
    }

    // Let's get our start and end lines for each item using HV3.
    // We'll need to make a temporary, translated array of IDs from our pass items.
    passItems = parse("||", ::passAssItems[::pass]);
    for (j = 1; j <= size(passItems); j++)
    {
        // passAssItems stores the decimal ID value. HV3 and the scene file use the hexadecimal representation (also stored in the oldIDs array)
        // We need to get creative in comparing them.
        tArray = parse("x",hex(int(passItems[j])));
        tempID[j] = tArray[2];
    }

    matchedHV3Items;
    matchedHV3ItemsCounter = 1;

    for (i = 1; i <= size(hv3Items); i++)
    {
        if (hv3Debug == 1)
        {
            logger("log_info","hyperVoxels3: Checking HV3ID: " + hv3Items[i].asStr());
        }
        hv3MatchFound = tempID.indexOf(string(hv3Items[i]));
        if(hv3MatchFound != 0)
        {
            matchedHV3Items[matchedHV3ItemsCounter] = hv3Items[i];
            matchedHV3ItemsCounter++;
        }
    }

    if (matchedHV3ItemsCounter == 1) // safety catch.
    {
        logger("log_warn","hyperVoxels3: Error during ID Matching!");
        return 0;
    } else {
        // logger("log_info,"hyperVoxels3: Matched " + size(matchedHV3Items) + " items");
    }

    hv3ChunkLineArrayIndex = 1;
    for (i = 1; i <= size(matchedHV3Items); i++)
    {
        hv3ItemID = matchedHV3Items[i];
        if (hv3Debug == 1)
        {
            logger("log_info","hyperVoxels3: Processing HV3ID: " + hv3ItemID.asStr());
        }
        readIndex = hv3Line;
        hv3StartString = "    { HVLink"; // object ID follows this line
        hv3EndString = "    { HVoxelCache"; // object block ends 6 lines after this line
        while(readIndex <= size(::readBuffer))
        {
            hv3LineTemp = ::readBuffer[readIndex];
            readIndex++;
            if (hv3LineTemp == hv3StartString)
            {
                hv3ChunkStartLineArray[hv3ChunkLineArrayIndex] = readIndex + 1; // hard-coded offset to start of block
                hv3_s_found = 1;
            }
            if ((strleft(hv3LineTemp, hv3EndString.size()) == hv3EndString) && (hv3_s_found == 1))
            {
                hv3ChunkEndLineArray[hv3ChunkLineArrayIndex] = readIndex + 6; // hard-coded offset to end of block
                hv3_s_found = 0;
                if (hv3Debug == 1)
                {
                    logger("log_info",hv3ChunkStartLineArray[hv3ChunkLineArrayIndex].asStr() + "/" + hv3ChunkEndLineArray[hv3ChunkLineArrayIndex]);
                }
                hv3ChunkLineArrayIndex++;
            }
        }
    }

    // Now we need to write out the sections we care about.
    readIndex = 1;
    while(readIndex <= hv3HeaderEndLine)
    {
        ::writeBuffer[size(::writeBuffer) + 1] = ::readBuffer[readIndex];
        readIndex++;
    }

    // Now we write out our sections from above.
    for(i = 1; i <= size(matchedHV3Items); i++)
    {
        hv3ItemID = matchedHV3Items[i];
        if (hv3Debug == 1)
        {
            logger("log_info","hyperVoxels3: Writing HV3ID: " + hv3ItemID);
        }
        readIndex = hv3ChunkStartLineArray[i];
        while(readIndex <= hv3ChunkEndLineArray[i])
        {
            ::writeBuffer[size(::writeBuffer) + 1] = ::readBuffer[readIndex];
            readIndex++;
        }
    }

    readIndex = hv3EndLine;
    while(readIndex <= size(::readBuffer))
    {
        ::writeBuffer[size(::writeBuffer) + 1] = ::readBuffer[readIndex];
        readIndex++;
    }

    // Push the output back to the original file.
    ::readBuffer = ::writeBuffer;
    ::writeBuffer = nil;

    return 1; // notify caller that we changed something.
}

