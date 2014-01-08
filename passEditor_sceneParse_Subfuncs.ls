getPassEditorStartLine: inputPath
{
	gpesl_input = File(inputPath, "r");
	toReturn = nil;

	while (!gpesl_input.eof())
	{
		line = gpesl_input.read();
		lineArray = parse(" ", line);
		if(size(lineArray) >= 4)
		{
			if(lineArray[2] == "MasterHandler" && lineArray[4] == "PassPort_MC")
			{
				toReturn = gpesl_input.line() - 1;
				break;
			}
		}
	}
	gpesl_input.close();
	return(toReturn);
}

getFFxItems: inputPath, startLine // unusual caller requirement, but there's a single call-site and this is specialized.
{
	gffxi_input = File(inputPath, "r");
	gffxi_input.line(startLine);
	ffxItemArray = @""@;
	ffxItemArrayIndex = 1;
	foundFFXBlock = 0;

	while(!gffxi_input.eof())
	{
		line = gffxi_input.read();
		lineArray = parse(" ",line);
		if((size(lineArray) == 4) && (lineArray[1] == "Plugin") && (lineArray[2] == "PixelFilterHandler") && (lineArray[4] == "FiberFilter"))
		{
			foundFFXBlock = 1;
		}
		if (foundFFXBlock == 1)
		{
			if(size(lineArray) == 2) // We're expecting something like 'itemID 1000000'
			{
				if(lineArray[1] == "Itemid")
				{
					ffxItemArray[ffxItemArrayIndex] = int(unquoteString(lineArray[2]));
					ffxItemArrayIndex++;
				}
			}
			if(line == "EndPlugin")
			{
				break; // hit the end of the FFx block.
			}
		}
	}
	gffxi_input.close();
	if (ffxItemArrayIndex == 1) // we found no item IDs within the specified lines.
	{
		return nil;
	} else {
		return ffxItemArray;
	}
}

getRelativityLines: mode, objID, objGenus, inputPath
{
	if(mode == "Motion")
	{
		searchLinePrefix = "Plugin ItemMotionHandler";
		searchLineSuffix = "Relativity";
		searchEndLine = "EndPlugin";
	}
	if(mode == "Channel")
	{
		searchLinePrefix = "    \"Rel_Channeler\"";
		searchEndLine = "    \"EndofData\"";
	}
	if(!searchLinePrefix)
	{
		logger("error","getRelativityLine: mode " + mode.asStr() + " not recognized");
	}
	if (objGenus == MESH)
	{
		relStartLine = getObjectLine(objID,inputPath);
		if (relStartLine)
		{
			relEndLine = getObjectEndLine(relStartLine + 1, objID, inputPath);
		}
	}
	else if (objGenus == LIGHT)
	{
		relStartLine = getLightLine(objID,inputPath);
		if (relStartLine)
		{
			relEndLine = getLightEndLine(relStartLine + 1, objID, inputPath);
		}
	}
	else if (objGenus == CAMERA)
	{
		relStartLine = getCameraLine(objID,inputPath);
		if (relStartLine)
		{
			relEndLine = getCameraEndLine(relStartLine, objID, inputPath); // deliberately don't offset the line - see the targeted function.
		}
	}
	else {
		logger("warn","getRelativityLine: Genus not recognized: " + objGenus.asStr());
		return nil; // unrecognized.
	}
	if(!relStartLine || relStartLine == 0)
	{
		return nil;
	}
	if(!relEndLine)
	{
		logger("error","getRelativityLine: failed to find end line for item " + objID.asStr());
	}
	relFile = File(inputPath, "r");
	relFile.line(relStartLine);
	relLineArray = nil;
	relLineArrayCounter = 0;
	for (line = relStartLine; line <= relEndLine; line++)
	{
		relLine = relFile.read();
		if(strleft(relLine, size(searchLinePrefix)) == searchLinePrefix)
		{
			matchFound = 0;
			if(mode == "Motion")
			{
				if (strright(relLine, size(searchLineSuffix)) == searchLineSuffix)
				{
					matchFound = 1;
				}
			} else {
				matchFound = 1;
			}
			if (matchFound == 1)
			{
				// We found a Relativity instance!
				relLineArrayCounter++;
				relLineArray[relLineArrayCounter] = relFile.line() - 1; // since the read() moved the line forward.
				relLineArrayCounter++; // now to store the end line
				relLineArray[relLineArrayCounter] = getPartialLine(relFile.line(), 0, searchEndLine, inputPath);
			}
		}
	}
	return relLineArray;
}

getObjectLine: objID,inputPath
{
	gol_input = File(inputPath, "r");
	toReturn = nil;

	while(!gol_input.eof())
	{
		gl_line = gol_input.read();
		lineArray = parse(" ",gl_line);
		if(size(lineArray) >= 3)
		{
			if(lineArray[1] == "LoadObjectLayer" || lineArray[1] == "AddNullObject")
			{
				if(lineArray[3] == string(objID) || lineArray[2] == string(objID))
				{
					toReturn = gol_input.line() - 1;
					break;
				}
			}
		}
	}
	gol_input.close();
	return(toReturn);
}

getLightLine: lightID,inputPath
{
	gll_input = File(inputPath, "r");
	toReturn = nil;
	while(!gll_input.eof())
	{
		gl_line = gll_input.read();
		lineArray = parse(" ",gl_line);
		if(size(lineArray) >= 2)
		{
			if(lineArray[1] == "AddLight" && lineArray[2] == string(lightID))
			{
				toReturn = gll_input.line() - 1;
				break;
			}
		}
	}
	gll_input.close();
	return(toReturn);
}

getPixelFilterLine: pixelFilterString, inputPath
{
	gpf_input = File(inputPath, "r");
	toReturn = nil;
	while (!gpf_input.eof())
	{
		gl_line = gpf_input.read();
		lineArray = parse(" ", gl_line);
		if (size(lineArray) >= 4)
		{
			if((lineArray[1] == "Plugin") && (lineArray[2] == "PixelFilterHandler") && (lineArray[4] == pixelFilterString))
			{
				toReturn = gpf_input.line() - 1;
			}
		}
	}
	gpf_input.close();
	return toReturn;
}

getVolumetricHandlerLine: volumetricHandlerString, inputPath
{
	gvl_input = File(inputPath, "r");
	toReturn = nil;
	while (!gvl_input.eof())
	{
		gl_line = gvl_input.read();
		lineArray = parse(" ", gl_line);
		if (size(lineArray) >= 4)
		{
			if((lineArray[1] == "Plugin") && (lineArray[2] == "VolumetricHandler") && (lineArray[4] == volumetricHandlerString))
			{
				toReturn = gvl_input.line() - 1;
			}
		}
	}
	gvl_input.close();
	return toReturn;
}

getCameraLine: camID,inputPath
{
	gcl_input = File(inputPath, "r");
	toReturn = nil;
	while(!gcl_input.eof())
	{
		gl_line = gcl_input.read();
		lineArray = parse(" ",gl_line);
		if(size(lineArray) >= 2)
		{
			if(lineArray[1] == "AddCamera" && lineArray[2] == string(camID))
			{
				toReturn = gcl_input.line() - 1;
				break;
			}
		}
	}
	gcl_input.close();
	return(toReturn);
}

getObjectEndLine: startLine,objID,inputPath
{
	if(startLine == 0 || startLine == nil)
	{
		startLine = getObjectLine(objID,inputPath);
		if(startLine == 0 || startLine == nil)
		{
			logger("error", "getObjectEndLine: cannot find object ID (" + objID.asStr() + ") in scene");
		}
		startLine += 1;
	}

	goel_input = File(inputPath, "r");
	goel_input.line(startLine);
	toReturn = nil;
	while(!goel_input.eof())
	{
		gl_line = goel_input.read();
		currentLineArray = parse(" ", gl_line);
		if(sizeof(currentLineArray) >= 2)
		{
			currentLineString = strleft(currentLineArray[1],12);
			if(currentLineString == "LoadObjectLa" || currentLineString == "AddNullObjec" || currentLineString == "AmbientColor")
			{
				toReturn = goel_input.line() - 1;
				if (toReturn == startLine)
				{
					logger("error","getObjectEndLine: end line is start line! Function called incorrectly.");
				}
				toReturn += -2; // offset back to the end line.
				break;
			}
		}
	}
	goel_input.close();
	return(toReturn);
}

getCameraEndLine: startLine,objID,inputPath
{
	if(startLine == 0 || startLine == nil)
	{
		startLine = getCameraLine(objID,inputPath);
		if(startLine == 0 || startLine == nil)
		{
			logger("error", "getCameraEndLine: cannot find camera ID (" + objID.asStr() + ") in scene");
		}
	}

	gcel_line1 = getPartialLine(startLine, 0, "Plugin CameraHandler", inputPath);
	if (gcel_line1)
	{
		gcel_line2 = getPartialLine(gcel_line1, 0, "EndPlugin", inputPath);
	}
	return gcel_line2;

	// Disabled below - doesn't seem to be reliable from multiple callsites - works only from first call site.
	/*
	gcel_input = File(inputPath, "r");
	gcel_input.line(startLine);
	toReturn = nil;
	endMarkerString = "Plugin CameraHandler";
	while(!gcel_input.eof())
	{
		gl_line = gcel_input.read();
		currentLineArray = parse(" ", gl_line);
		if((sizeof(currentLineArray) >= 2) && (size(gl_line) >= size(endMarkerString)))
		{
			currentLineString = strleft(gl_line,size(endMarkerString));
			if(currentLineString == endMarkerString)
			{
				toReturn = gcel_input.line() + 1; // offset to include the EndPlugin line, the whitespace afterwards and the subsequent line to match original code flow.
				break;
			}
		}
	}
	gcel_input.close();
	return(toReturn);
	*/
}

getLightEndLine: startLine,objID,inputPath
{
	if(startLine == 0 || startLine == nil)
	{
		startLine = getLightLine(objID,inputPath);
		if(startLine == 0 || startLine == nil)
		{
			logger("error", "getLightEndLine: cannot find light ID (" + objID.asStr() + ") in scene");
		}
		startLine += 1;
	}
	glel_input = File(inputPath, "r");
	glel_input.line(startLine);
	toReturn = nil;
	endMarkerString = "Plugin LightHandler";
	while(!glel_input.eof())
	{
		gl_line = glel_input.read();
		currentLineArray = parse(" ", gl_line);
		if((sizeof(currentLineArray) >= 2) && (size(gl_line) >= size(endMarkerString)))
		{
			currentLineString = strleft(gl_line,size(endMarkerString));
			if(currentLineString == endMarkerString)
			{
				toReturn = glel_input.line() + 1; // offset to include the EndPlugin line, the whitespace afterwards and the subsequent line to match original code flow.
				break;
			}
		}
	}
	glel_input.close();
	return(toReturn);
}

getPartialLine: currentLine, endLine, searchString, inputPath
{
	gpl_input = File(inputPath, "r");

	searchLine[1] = searchString;
	searchStringSize = sizeof(searchLine[1]);
	if(currentLine == 0 || currentLine == nil)
	{
		currentLine = 1;
	}
	if(endLine == 0)
	{
		endLine = gpl_input.linecount();
	}
	toReturn = nil;
	while(currentLine != endLine)
	{
		gpl_input.line(currentLine);
		line = gpl_input.read();
		if(line)
		{
			if(size(line) >= searchStringSize)
			{
				linePart = strleft(line,searchStringSize);
				if(linePart == searchString)
				{
					if(currentLine == 0)
					{
						toReturn = nil;
						break;
					}
					else
					{
						toReturn = currentLine;
						break;
					}
				}
			}
		}
		else
		{
			toReturn = nil;
			break;
		}
		currentLine++;
	}
	gpl_input.close();
	return(toReturn);
}

readSpecificLine: lineToRead, inputPath
{
	rsl_input = File(inputPath, "r");
	endLine = rsl_input.linecount();
	toReturn = "";
	if(lineToRead <= endLine)
	{
		rsl_input.line(lineToRead);
		toReturn = rsl_input.read();
	}
	rsl_input.close();
	return(toReturn);
}

getMasterPluginLine: masterPluginString, searchPath
{
	// Let's get organized
	prefixMPStr = "Plugin MasterHandler";

	mPStartLine = 0;
	mPOK = 1;

	while(mPOK != nil)
	{
		mPStartLine = getPartialLine(mPStartLine,0,prefixMPStr, searchPath);
		if(mPStartLine)
		{
			mPLine = readSpecificLine(mPStartLine, searchPath);
			mPLineArray = parse(" ", mPLine);
			if (mPLineArray[4] == masterPluginString)
			{
				return mPStartLine;
			}
			mPStartLine++; // bump the line on for the next pass.
		} else {
			mPOK = nil;
		}
	}

	// If we got here, we failed to find the master plugin.
	return nil;
}

getRendererPluginLine: rendererString, searchPath
{
	prefixRPStr = "Plugin ExtRendererHandler";
	rPLine = getPartialLine(0,0,prefixRPStr, searchPath);
	if(rendererString != "any")
	{
		return rPLine;
	} else {
		rPStr = readSpecificLine(rPLine, searchPath);
		rPStrArray = parse(" ", rPLine);
		if(rPStrArray[4] == rendererString)
		{
			return rPLine;
		} else {
			return nil;
		}
	}
}

extractRelativityItems: relString
{
	readyForExtract = 0;

	// myVar = "    \"X=X(REL(reference test),t) + COND(Y(reference2,t) + #A\"";

	equalityIndex = relString.indexOf('=');
	relString = strright(relString,size(relString) - equalityIndex);
	relString = strleft(relString,size(relString) - 1); // strip trailing quote mark.

	c = 1;
	relItemArray = nil;
	relItemArrayIndex = 1;
	while (c <= size(relString))
	{
		readyForExtract = 0;
		relTag = 0;
		if (strsub(relString,c,2) == "X\(" || strsub(relString,c,2) == "Y\(" ||
		    strsub(relString,c,2) == "Z\(" || strsub(relString,c,2) == "H\(" ||
			strsub(relString,c,2) == "P\(" || strsub(relString,c,2) == "B\(")
		{
			c += 2;
			readyForExtract = 1;
			if(strsub(relString,c,4) == "REL\(")
			{
				relTag = 1;
				c += 4;
			}
		}
		if (strsub(relString,c,3) == "VX\(" || strsub(relString,c,3) == "VY\(" ||
		    strsub(relString,c,3) == "VZ\(" || strsub(relString,c,3) == "VH\(" ||
		    strsub(relString,c,3) == "VP\(" || strsub(relString,c,3) == "VB\(")
		{
			c += 3;
			readyForExtract = 1;
			if(strsub(relString,c,4) == "REL\(")
			{
				relTag = 1;
				c += 4;
			}
		}
		if (strsub(relString,c,3) == "XS\(" || strsub(relString,c,3) == "YS\(" ||
		    strsub(relString,c,3) == "ZS\(")
		{
			c += 3;
			readyForExtract = 1;
			if(strsub(relString,c,4) == "REL\(")
			{
				relTag = 1;
				c += 4;
			}
		}
		if (readyForExtract == 1)
		{
			// trim our string.
			rel_ItemName = strright(relString,size(relString) - (c - 1));
			closePar_index = rel_ItemName.indexOf('\,');
			// We need to sanity check this now because we could be catching the closing
			// bracket from REL(). We use relTag to avoid trapping clone indices (e.g. myobject.lwo (2))
			closePar_index += -1; // 2 to walk back from the ','			
			if (relTag == 1)
			{
				closePar_index += -1; // 2 to walk back from the closing bracket.
			}

			rel_ItemName = strleft(rel_ItemName,closePar_index);
			relItemArray[relItemArrayIndex] = rel_ItemName;
			relItemArrayIndex++;
		}
		c++;
	}
	return relItemArray;
}

getHyperVoxels3Items: inputPath, startLine
{
	ghvi_input = File(inputPath, "r");
	ghvi_input.line(startLine);
	hv3ItemArray = @""@;
	hv3ItemArrayIndex = 1;
	foundHV3Block = 0;

	while(!ghvi_input.eof())
	{
		line = ghvi_input.read();
		lineArray = parse(" ",line);
		if((size(lineArray) == 4) && (lineArray[1] == "Plugin") && (lineArray[2] == "VolumetricHandler") && (lineArray[4] == "HyperVoxelsFilter"))
		{
			foundHV3Block = 1;
		}
		if (foundHV3Block == 1)
		{
			if(line == "  { HVObject")
			{
				line = ghvi_input.read();
				if(line == "    { HVLink")
				{
					line = ghvi_input.read(); // should now get ID. Unfortunately, it's quoted and prefixed by 6 spaces. We'll take care of that.
					hv3ItemArray[hv3ItemArrayIndex] = int(unquoteString(strright(line,size(line) - 6)));
					hv3ItemArrayIndex++;
				}
			}
			if(line == "EndPlugin")
			{
				break; // hit the end of the HV3 block.
			}
		}
	}
	ghvi_input.close();
	if (hv3ItemArrayIndex == 1) // we found no item IDs within the specified lines.
	{
		return nil;
	} else {
		return hv3ItemArray;
	}	
}
