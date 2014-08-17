// Arnold 0.4.3 renderer globals
@insert "@lwtoa/passEditor_Arnold043Renderer_Support_Vars.ls"
@insert "@lwtoa/passEditor_Arnold043Renderer_Support_UI.ls"

// scnMaster override UI stuff
activeCameraName; // for Arnold script function. Value set in UI.

scnGen_arnold043
{
	// Arnold, happily, has all of its settings in the scene file under the external renderer plugin section so all we need to do now is to find the corresponding line and write sequentially from there.
	// If the line doesn't exist, we need to add it and go from there.

	settingIndex = 4;
    activeCameraID = int(::settingsArray[settingIndex]);

	settingIndex++;
	// Generic stuff from the native renderer function.
    redirectBuffersSetts = int(::settingsArray[settingIndex]);

    // logger("info","activeCameraID: " + activeCameraID.asStr());

    if(activeCameraID == 0)
    {
        activeCamera = 0; // first camera in scene file, matching default behaviour for no cameras in pass.
        passCamNameArray[1] = ::cameraNames[1];
        passCamIDArray[1] = ::cameraIDs[1];
    } else {
        passCamNameArray = nil;
        passCamIDArray = nil;

        passItemsIDsArray = parse("||",::passAssItems[::currentChosenPass]);
        passCamArrayIndex = 1;
        for (i = 1; i <= passItemsIDsArray.size(); i++)
        {
            for (j = 1; j <= ::cameraIDs.size(); j++)
            {
                if(passItemsIDsArray[i] == ::cameraIDs[j])
                {
                    passCamIDArray[passCamArrayIndex] = passItemsIDsArray[i];
                    // Name look-up
                    for(k = 1; k <= ::displayIDs.size(); k++)
                    {
                        if(::displayIDs[k] == passItemsIDsArray[i])
                        {
                            nameIndex = k;
                        }
                    }
                    passCamNameArray[passCamArrayIndex] = ::displayNames[nameIndex];
                    passCamArrayIndex++;
                }
            }
        }

        activeCamera = 0;
        counter = 0;
        for(i = 1; i <= passCamIDArray.size(); i++)
        {
            if(passCamIDArray[i] == activeCameraID)
            {
				// logger("info","Found match for camera: " + counter.asStr());
                activeCamera = counter;
            }
            counter++;
        }
    }

	if(passCamNameArray == nil)
	{
		logger("error","Error: No camera assigned to pass!");
	} else {
		activeCameraName = passCamNameArray[activeCamera + 1];
	}

    // We need to do both of these - the first because we will later overwrite this field because it's parked at the end of the file and gets re-written
    // from the source file very late in the scene generation process.
    writeOverrideString("CurrentCamera ", activeCamera);
    writeOverrideString("CurrentCamera ", activeCamera);
	
	/* Anticipating a structure like :
	ExternalRenderer LWtoA
	Plugin ExtRendererHandler 1 LWtoA
	// settings block
	EndPlugin
	*/

	// Check if we have any external renderer configured.
	rendererCheck = getRendererPluginLine("any");
	if(rendererCheck)
	{
		arnoldCheck = getRendererPluginLine("LWtoA");
	}

	if(!arnoldCheck)
	{
		logger("info","scnGen_arnold043: Arnold " + lwtoa043_default_arnoldMajor.asStr() + "." + lwtoa043_default_arnoldMinor.asStr() + "." + lwtoa043_default_arnoldPatch.asStr() + " master plugin not found. Guessing....");
		arnoldMajor = lwtoa043_default_arnoldMajor;
		arnoldMinor = lwtoa043_default_arnoldMinor;
		arnoldPatch = lwtoa043_default_arnoldPatch;
		if (rendererCheck)
		{
	   		strip3rdPartyRenderers();
		}
		insertionLine = getPartialLine(0,0,"PixelFilterForceMT");
		arnoldVolLine = -1; // set because we need to pass it, but it's not going to be used.
		arnoldEndLine = -1; // we'll check for this specific condition later.
	} else {
		insertionLine = arnoldCheck;
		readIndex = insertionLine + 2; // offset
		arnoldMajor = int(::readBuffer[readIndex]);
		readIndex++;
		arnoldMinor = int(::readBuffer[readIndex]);
		readIndex++;
		arnoldPatch = int(::readBuffer[readIndex]);
		readIndex++;
		// Check known version of Arnold in case of mismatch
		arnoldVolLine = getPartialLine(insertionLine,0,"Arnold_Volume_Scattering"); // enable workaround for currently unsupported volumetric section of Arnold block.
		arnoldEndLine = getPartialLine(insertionLine,0,"EndPlugin");
		if((arnoldMajor != lwtoa043_default_arnoldMajor) || (arnoldMinor != lwtoa043_default_arnoldMinor) || (arnoldPatch != lwtoa043_default_arnoldPatch))
		{
			logger("error","scnGen_arnold043: Arnold version mismatch: " + lwtoa043_arnoldMajor.asStr() + "." + lwtoa043_arnoldMinor.asStr() + "." + lwtoa043_arnoldPatch.asStr());
		}
		
	}
	readIndex = 1;
	while (readIndex < insertionLine)
	{
		::writeBuffer[readIndex] = ::readBuffer[readIndex];
		readIndex++;
	}

	::writeBuffer[size(::writeBuffer) + 1] = "ExternalRenderer LWtoA";
	::writeBuffer[size(::writeBuffer) + 1] = "Plugin ExtRendererHandler 1 LWtoA"; // only ever have one external renderer block.
	scnGen_arnold043_settings(); // long chunk of writes, so make a specific function to contain them. Easier to maintain and debug.
	scnGen_arnold043_volumetrics(arnoldVolLine, arnoldEndLine);
	::writeBuffer[size(::writeBuffer) + 1] = "EndPlugin";

	// Need to then append output from current position in the input file until hit end of file.
	if (arnoldEndLine != -1)
	{
		readIndex = arnoldEndLine + 1; // offset our source file to read from after the Arnold block.
	} else {
		readIndex = insertionLine;
	}
    while(readIndex <= size(::readBuffer))
    {
		::writeBuffer[size(::writeBuffer) + 1] = ::readBuffer[readIndex];
		readIndex++;
    }
    ::readBuffer = ::writeBuffer;
    ::writeBuffer = nil;
}

scnGen_arnold043_settings
{
    // Offset in our settings array to go past the version values above and start pushing the other values out to the scene file.
    settingIndex = 6;
    while(settingIndex <= settingIndex.size())
    {
    	::writeBuffer[size(::writeBuffer) + 1] = ::settingsArray[settingIndex];
    	settingIndex++;
    }
}

scnGen_arnold043_volumetrics: arnoldVolLine, arnoldEndLine
{
    if (arnoldVolLine == -1) // no arnold in original scene - write out standard volumetric section.
	{
    	::writeBuffer[size(::writeBuffer) + 1] = "{ Arnold_Volume_Scattering";
		::writeBuffer[size(::writeBuffer) + 1] = "  Scatter_Density 0.20000000000000001";
		::writeBuffer[size(::writeBuffer) + 1] = "  Scatter_Samples 4";
		::writeBuffer[size(::writeBuffer) + 1] = "  Scatter_Eccentricity 0";
		::writeBuffer[size(::writeBuffer) + 1] = "  Scatter_Attenuation 0";
		::writeBuffer[size(::writeBuffer) + 1] = "  Scatter_Camera_contribution 1";
		::writeBuffer[size(::writeBuffer) + 1] = "  Scatter_Diffuse_contribution 0";
		::writeBuffer[size(::writeBuffer) + 1] = "  Scatter_Reflection_contribution 1";
		::writeBuffer[size(::writeBuffer) + 1] = "  Scatter_Color 1 1 1";
		::writeBuffer[size(::writeBuffer) + 1] = "  Scatter_Attenuation_Color 1 1 1";
		::writeBuffer[size(::writeBuffer) + 1] = "  { Scatter_node_editor";
		::writeBuffer[size(::writeBuffer) + 1] = "    { Root";
		::writeBuffer[size(::writeBuffer) + 1] = "      Location 0 0";
		::writeBuffer[size(::writeBuffer) + 1] = "      Zoom 1";
		::writeBuffer[size(::writeBuffer) + 1] = "      Disabled 1";
		::writeBuffer[size(::writeBuffer) + 1] = "    }";
		::writeBuffer[size(::writeBuffer) + 1] = "    Version 1";
		::writeBuffer[size(::writeBuffer) + 1] = "    { Nodes";
		::writeBuffer[size(::writeBuffer) + 1] = "      Server \"Arnold Volume Scattering\"";
		::writeBuffer[size(::writeBuffer) + 1] = "      { Tag";
		::writeBuffer[size(::writeBuffer) + 1] = "        RealName \"Arnold Volume Scattering\"";
		::writeBuffer[size(::writeBuffer) + 1] = "        Name \"Arnold Volume Scattering\"";
		::writeBuffer[size(::writeBuffer) + 1] = "        Coordinates -10 -10";
		::writeBuffer[size(::writeBuffer) + 1] = "        Mode 1";
		::writeBuffer[size(::writeBuffer) + 1] = "        { Data";
		::writeBuffer[size(::writeBuffer) + 1] = "        }";
		::writeBuffer[size(::writeBuffer) + 1] = "        Preview \"\"";
		::writeBuffer[size(::writeBuffer) + 1] = "        Comment \"\"";
		::writeBuffer[size(::writeBuffer) + 1] = "      }";
		::writeBuffer[size(::writeBuffer) + 1] = "    }";
		::writeBuffer[size(::writeBuffer) + 1] = "    { Connections";
		::writeBuffer[size(::writeBuffer) + 1] = "    }";
		::writeBuffer[size(::writeBuffer) + 1] = "  }";
		::writeBuffer[size(::writeBuffer) + 1] = "}";
		::writeBuffer[size(::writeBuffer) + 1] = "{ Arnold_Fog";
		::writeBuffer[size(::writeBuffer) + 1] = "  Fog_distance 0.02";
		::writeBuffer[size(::writeBuffer) + 1] = "  Fog_height 5";
		::writeBuffer[size(::writeBuffer) + 1] = "  Fog_color 1 1 1";
		::writeBuffer[size(::writeBuffer) + 1] = "  Fog_ground_point 0 0 0";
		::writeBuffer[size(::writeBuffer) + 1] = "  Fog_ground_color 0 0 1";
		::writeBuffer[size(::writeBuffer) + 1] = "  { Fog_node_editor";
		::writeBuffer[size(::writeBuffer) + 1] = "    { Root";
		::writeBuffer[size(::writeBuffer) + 1] = "      Location 0 0";
		::writeBuffer[size(::writeBuffer) + 1] = "      Zoom 1";
		::writeBuffer[size(::writeBuffer) + 1] = "      Disabled 1";
		::writeBuffer[size(::writeBuffer) + 1] = "    }";
		::writeBuffer[size(::writeBuffer) + 1] = "    Version 1";
		::writeBuffer[size(::writeBuffer) + 1] = "    { Nodes";
		::writeBuffer[size(::writeBuffer) + 1] = "      Server \"Arnold Volumetric Fog\"";
		::writeBuffer[size(::writeBuffer) + 1] = "      { Tag";
		::writeBuffer[size(::writeBuffer) + 1] = "        RealName \"Arnold Volumetric Fog\"";
		::writeBuffer[size(::writeBuffer) + 1] = "        Name \"Arnold Volumetric Fog\"";
		::writeBuffer[size(::writeBuffer) + 1] = "        Coordinates -10 -10";
		::writeBuffer[size(::writeBuffer) + 1] = "        Mode 1";
		::writeBuffer[size(::writeBuffer) + 1] = "        { Data";
		::writeBuffer[size(::writeBuffer) + 1] = "        }";
		::writeBuffer[size(::writeBuffer) + 1] = "        Preview \"\"";
		::writeBuffer[size(::writeBuffer) + 1] = "        Comment \"\"";
		::writeBuffer[size(::writeBuffer) + 1] = "      }";
		::writeBuffer[size(::writeBuffer) + 1] = "    }";
		::writeBuffer[size(::writeBuffer) + 1] = "    { Connections";
		::writeBuffer[size(::writeBuffer) + 1] = "    }";
		::writeBuffer[size(::writeBuffer) + 1] = "  }";
		::writeBuffer[size(::writeBuffer) + 1] = "}";
    } else {
    	readIndex = arnoldVolLine;
    	while(readIndex < arnoldEndLine) // we write out EndPlugin line in our parent function, so don't hit it here.
    	{
    		::writeBuffer[size(::writeBuffer) + 1] = ::readBuffer[readIndex];
    		readIndex++;
    	}
    }
}
