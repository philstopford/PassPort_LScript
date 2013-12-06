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

    if(activeCameraID == 0) // FIXME: Needs implementation.
    {
        activeCamera = 0; // first camera in scene file, matching default behaviour for no cameras in pass.
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
    writeOverrideString(::updatedCurrentScenePath, ::updatedCurrentScenePath, "CurrentCamera ", activeCamera);
    writeOverrideString(::updatedCurrentScenePath, ::newScenePath, "CurrentCamera ", activeCamera);
	
	arnoldTempPath = ::tempDirectory + getsep() + "passEditorTempSceneArnold.lws";
	arnoldfile = File(arnoldTempPath, "w");
	sourceFile = File(::updatedCurrentScenePath, "r");
	/* Anticipating a structure like :
	ExternalRenderer LWtoA
	Plugin ExtRendererHandler 1 LWtoA
	// settings block
	EndPlugin
	*/

	// Check if we have any external renderer configured.
	rendererCheck = getRendererPluginLine("any", ::newScenePath);
	if(rendererCheck)
	{
		arnoldCheck = getRendererPluginLine("LWtoA", ::newScenePath);
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
		insertionLine = getPartialLine(0,0,"PixelFilterForceMT",::updatedCurrentScenePath);
		arnoldVolLine = -1; // set because we need to pass it, but it's not going to be used.
		arnoldEndLine = -1; // we'll check for this specific condition later.
	} else {
		insertionLine = arnoldCheck;
		sourceFile.line(insertionLine + 2); // offset
		arnoldMajor = sourceFile.readInt();
		arnoldMinor = sourceFile.readInt();
		arnoldPatch = sourceFile.readInt();
		// Check known version of Arnold in case of mismatch
		arnoldVolLine = getPartialLine(insertionLine,0,"Arnold_Volume_Scattering",::updatedCurrentScenePath); // enable workaround for currently unsupported volumetric section of Arnold block.
		arnoldEndLine = getPartialLine(insertionLine,0,"EndPlugin",::updatedCurrentScenePath);
		if((arnoldMajor != lwtoa043_default_arnoldMajor) || (arnoldMinor != lwtoa043_default_arnoldMinor) || (arnoldPatch != lwtoa043_default_arnoldPatch))
		{
			logger("error","scnGen_arnold043: Arnold version mismatch: " + lwtoa043_arnoldMajor.asStr() + "." + lwtoa043_arnoldMinor.asStr() + "." + lwtoa043_arnoldPatch.asStr());
		}
		
	}
	lineNumber = 0; // might need to be 1 - need to check; LScript references can be either 1 or 0 based, case depending.
	sourceFile.line(lineNumber);
	arnoldFile = File(::newScenePath, "w");
	while (lineNumber < insertionLine)
	{
		line = sourceFile.read();
		arnoldFile.writeln(line);
		lineNumber++;
	}

	arnoldFile.writeln("ExternalRenderer LWtoA");
	arnoldFile.writeln("Plugin ExtRendererHandler 1 LWtoA"); // only ever have one external renderer block.
	scnGen_arnold043_settings(arnoldFile); // long chunk of writes, so make a specific function to contain them. Easier to maintain and debug.
	scnGen_arnold043_volumetrics(sourceFile, arnoldVolLine, arnoldEndLine, arnoldFile);
	arnoldFile.writeln("EndPlugin");

	// Need to then append output from current position in the input file until hit end of file.
	if (arnoldEndLine != -1)
	{
		sourceFile.line(arnoldEndLine + 1); // offset our source file to read from after the Arnold block.
	}
    while(!sourceFile.eof())
    {
		line = sourceFile.read();
		arnoldFile.writeln(line);
    }
	sourceFile.close();
	arnoldFile.close();

	filecopy(arnoldTempPath,::newScenePath);
	filecopy(arnoldTempPath,::updatedCurrentScenePath); // avoid getting our source file clobbered in a later function.
	filedelete(arnoldTempPath);
}

scnGen_arnold043_settings: arnoldFile
{
    // Offset in our settings array to go past the version values above and start pushing the other values out to the scene file.
    settingIndex = 6;
    while(settingIndex <= settingIndex.size())
    {
    	arnoldFile.writeln(::settingsArray[settingIndex]);
    	settingIndex++;
    }
}

scnGen_arnold043_volumetrics: sourceFile, arnoldVolLine, arnoldEndLine, arnoldFile
{
    if (arnoldVolLine == -1) // no arnold in original scene - write out standard volumetric section.
	{
    	arnoldFile.writeln("{ Arnold_Volume_Scattering");
		arnoldFile.writeln("  Scatter_Density 0.20000000000000001");
		arnoldFile.writeln("  Scatter_Samples 4");
		arnoldFile.writeln("  Scatter_Eccentricity 0");
		arnoldFile.writeln("  Scatter_Attenuation 0");
		arnoldFile.writeln("  Scatter_Camera_contribution 1");
		arnoldFile.writeln("  Scatter_Diffuse_contribution 0");
		arnoldFile.writeln("  Scatter_Reflection_contribution 1");
		arnoldFile.writeln("  Scatter_Color 1 1 1");
		arnoldFile.writeln("  Scatter_Attenuation_Color 1 1 1");
		arnoldFile.writeln("  { Scatter_node_editor");
		arnoldFile.writeln("    { Root");
		arnoldFile.writeln("      Location 0 0");
		arnoldFile.writeln("      Zoom 1");
		arnoldFile.writeln("      Disabled 1");
		arnoldFile.writeln("    }");
		arnoldFile.writeln("    Version 1");
		arnoldFile.writeln("    { Nodes");
		arnoldFile.writeln("      Server \"Arnold Volume Scattering\"");
		arnoldFile.writeln("      { Tag");
		arnoldFile.writeln("        RealName \"Arnold Volume Scattering\"");
		arnoldFile.writeln("        Name \"Arnold Volume Scattering\"");
		arnoldFile.writeln("        Coordinates -10 -10");
		arnoldFile.writeln("        Mode 1");
		arnoldFile.writeln("        { Data");
		arnoldFile.writeln("        }");
		arnoldFile.writeln("        Preview \"\"");
		arnoldFile.writeln("        Comment \"\"");
		arnoldFile.writeln("      }");
		arnoldFile.writeln("    }");
		arnoldFile.writeln("    { Connections");
		arnoldFile.writeln("    }");
		arnoldFile.writeln("  }");
		arnoldFile.writeln("}");
		arnoldFile.writeln("{ Arnold_Fog");
		arnoldFile.writeln("  Fog_distance 0.02");
		arnoldFile.writeln("  Fog_height 5");
		arnoldFile.writeln("  Fog_color 1 1 1");
		arnoldFile.writeln("  Fog_ground_point 0 0 0");
		arnoldFile.writeln("  Fog_ground_color 0 0 1");
		arnoldFile.writeln("  { Fog_node_editor");
		arnoldFile.writeln("    { Root");
		arnoldFile.writeln("      Location 0 0");
		arnoldFile.writeln("      Zoom 1");
		arnoldFile.writeln("      Disabled 1");
		arnoldFile.writeln("    }");
		arnoldFile.writeln("    Version 1");
		arnoldFile.writeln("    { Nodes");
		arnoldFile.writeln("      Server \"Arnold Volumetric Fog\"");
		arnoldFile.writeln("      { Tag");
		arnoldFile.writeln("        RealName \"Arnold Volumetric Fog\"");
		arnoldFile.writeln("        Name \"Arnold Volumetric Fog\"");
		arnoldFile.writeln("        Coordinates -10 -10");
		arnoldFile.writeln("        Mode 1");
		arnoldFile.writeln("        { Data");
		arnoldFile.writeln("        }");
		arnoldFile.writeln("        Preview \"\"");
		arnoldFile.writeln("        Comment \"\"");
		arnoldFile.writeln("      }");
		arnoldFile.writeln("    }");
		arnoldFile.writeln("    { Connections");
		arnoldFile.writeln("    }");
		arnoldFile.writeln("  }");
		arnoldFile.writeln("}");
    } else {
    	lineNumber = arnoldVolLine;
    	sourceFile.line(lineNumber); // should already be here, but do this as a safety check.
    	while(lineNumber < arnoldEndLine) // we write out EndPlugin line in our parent function, so don't hit it here.
    	{
    		line = sourceFile.read();
    		arnoldFile.writeln(line);
    		lineNumber++;
    	}
    }
}
