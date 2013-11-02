getPassEditorStartLine: inputPath
{
	input = File(inputPath, "r");

	if(startLine == 0 || startLine == nil)
	{
		startLine = 1;
	}

	if(endLine == 0)
	{
		endLine = input.linecount();
	}
	
	startLine = 1;
	endLine = input.linecount();

	currentLine = 1;
	toReturn = nil;
	input.line(startLine);

	while (currentLine <= endLine) {
		line = input.read();
		lineArray = parse(" ", line);
		if(size(lineArray) >= 4)
		{
			if(lineArray[2] == "MasterHandler" && lineArray[4] == "PassPort_MC")
			{
				toReturn = currentLine;
				break;
			}
		}
		currentLine++;
	}

	input.close();
	return(toReturn);
}

getFFxItems: inputPath, startLine // unusual caller requirement, but there's a single call-site and this is specialized.
{
	input = File(inputPath, "r");
	input.line(startLine);
	ffxItemArray = @""@;
	ffxItemArrayIndex = 1;
	foundFFXBlock = 0;

	while(!input.eof())
	{
		line = input.read();
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
	input.close();
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
	if (objGenus == 1)
	{
		relStartLine = getObjectLine(objID,inputPath);
		relEndLine = getObjectEndLine(relStartLine + 1, objID, inputPath);
	}
	else if (objGenus == 2)
	{
		relStartLine = getLightLine(objID,inputPath);
		relEndLine = getLightEndLine(relStartLine, objID, inputPath);
	}
	else if (objGenus == 3)
	{
		relStartLine = getCameraLine(objID,inputPath);
		relEndLine = getCameraEndLine(relStartLine, objID, inputPath);
	}
	else {
		logger("warn","Genus not recognized: " + objGenus.asStr());
		return nil; // unrecognized.
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
	input = File(inputPath, "r");
	startLine = 1;
	endLine = input.linecount();
	currentLine = 1;
	toReturn = nil;
	input.line(startLine);

	while(currentLine != endLine)
	{
		gl_line = input.read();
		lineArray = parse(" ",gl_line);
		if(size(lineArray) >= 3)
		{
			if(lineArray[1] == "LoadObjectLayer" || lineArray[1] == "AddNullObject")
			{
				if(lineArray[3] == string(objID) || lineArray[2] == string(objID))
				{
					toReturn = currentLine;
					break;
				}
			}
		}
		currentLine++;
	}
	input.close();
	return(toReturn);
}

getLightLine: lightID,inputPath
{
	input = File(inputPath, "r");
	startLine = 1;
	endLine = input.linecount();
	currentLine = 1;
	toReturn = nil;
	input.line(startLine);
	while(currentLine != endLine)
	{
		gl_line = input.read();
		lineArray = parse(" ",gl_line);
		if(size(lineArray) >= 2)
		{
			if(lineArray[1] == "AddLight" && lineArray[2] == string(lightID))
			{
				toReturn = currentLine;
				break;
			}
		}
		currentLine++;
	}
	input.close();
	return(toReturn);
}

getPixelFilterLine: pixelFilterString, inputPath
{
	input = File(inputPath, "r");
	endLine = input.linecount();
	currentLine = 1;
	toReturn = nil;
	input.line(currentLine);
	while (currentLine != endLine)
	{
		gl_line = input.read();
		lineArray = parse(" ", gl_line);
		if (size(lineArray) >= 4)
		{
			if((lineArray[1] == "Plugin") && (lineArray[2] == "PixelFilterHandler") && (lineArray[4] == pixelFilterString))
			{
				toReturn = currentLine;
			}
		}
		currentLine++;
	}
	return toReturn;
}

getVolumetricHandlerLine: volumetricHandlerString, inputPath
{
	input = File(inputPath, "r");
	endLine = input.linecount();
	currentLine = 1;
	toReturn = nil;
	input.line(currentLine);
	while (currentLine != endLine)
	{
		gl_line = input.read();
		lineArray = parse(" ", gl_line);
		if (size(lineArray) >= 4)
		{
			if((lineArray[1] == "Plugin") && (lineArray[2] == "VolumetricHandler") && (lineArray[4] == volumetricHandlerString))
			{
				toReturn = currentLine;
			}
		}
		currentLine++;
	}
	return toReturn;
}

getCameraLine: camID,inputPath
{
	input = File(inputPath, "r");
	startLine = 1;
	endLine = input.linecount();
	currentLine = 1;
	toReturn = nil;
	input.line(startLine);
	while(currentLine != endLine)
	{
		gl_line = input.read();
		lineArray = parse(" ",gl_line);
		if(size(lineArray) >= 2)
		{
			if(lineArray[1] == "AddCamera" && lineArray[2] == string(camID))
			{
				toReturn = currentLine;
				break;
			}
		}
		currentLine++;
	}
	input.close();
	return(toReturn);
}

getObjectEndLine: startLine,objID,inputPath
{
	input = File(inputPath, "r");

	if(startLine == 0 || startLine == nil)
	{
		startLine = 1;
	}
	endLine = input.linecount();
	currentLine = startLine;
	toReturn = nil;
	input.line(currentLine);
	while(currentLine != endLine)
	{
		gl_line = input.read();
		currentLineArray[1] = gl_line;
		if(sizeof(currentLineArray[1]) >= 12)
		{
			currentLineString = strleft(gl_line,12);
			if(currentLineString == "LoadObjectLa" || currentLineString == "AddNullObjec" || currentLineString == "AmbientColor")
			{
				toReturn = currentLine;
				if (toReturn == startLine)
				{
					logger("error","getObjectEndLine: end line is start line! Function called incorrectly.");
				}
				toReturn += -2; // offset back to the end line.
				break;
			}
		}
		currentLine++;
	}
	input.close();
	return(toReturn);
}

getCameraEndLine: startLine,objID,inputPath
{
	input = File(inputPath, "r");

	if(startLine == 0 || startLine == nil)
	{
		startLine = 1;
	}
	endLine = input.linecount();
	currentLine = startLine;
	toReturn = nil;
	endMarkerString = "Plugin CameraHandler";
	input.line(currentLine);
	while(currentLine != endLine)
	{
		gl_line = input.read();
		currentLineArray[1] = gl_line;
		if(sizeof(currentLineArray[1]) >= size(endMarkerString))
		{
			currentLineString = strleft(gl_line,size(endMarkerString));
			if(currentLineString == endMarkerString)
			{
				toReturn = currentLine + 2; // offset to include the EndPlugin line, the whitespace afterwards and the subsequent line to match original code flow.
				break;
			}
		}
		currentLine++;
	}
	input.close();
	return(toReturn);
}

getLightEndLine: startLine,objID,inputPath
{
	input = File(inputPath, "r");

	if(startLine == 0 || startLine == nil)
	{
		startLine = 1;
	}
	endLine = input.linecount();
	currentLine = startLine;
	toReturn = nil;
	endMarkerString = "Plugin LightHandler";
	input.line(currentLine);
	while(currentLine != endLine)
	{
		gl_line = input.read();
		currentLineArray[1] = gl_line;
		if(sizeof(currentLineArray[1]) >= size(endMarkerString))
		{
			currentLineString = strleft(gl_line,size(endMarkerString));
			if(currentLineString == endMarkerString)
			{
				toReturn = currentLine + 2; // offset to include the EndPlugin line, the whitespace afterwards and the subsequent line to match original code flow.
				break;
			}
		}
		currentLine++;
	}
	input.close();
	return(toReturn);
}

getPartialLine: currentLine, endLine, searchString, inputPath
{
	input = File(inputPath, "r");

	searchLine[1] = searchString;
	searchStringSize = sizeof(searchLine[1]);
	if(currentLine == 0 || currentLine == nil)
	{
		currentLine = 1;
	}
	if(endLine == 0)
	{
		endLine = input.linecount();
	}
	toReturn = nil;
	input.line(currentLine);
	while(currentLine != endLine)
	{
		line = input.read();
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
	input.close();
	return(toReturn);
}

readSpecificLine: lineToRead, inputPath
{
	input = File(inputPath, "r");
	endLine = input.linecount();
	toReturn = "";
	if(lineToRead <= endLine)
	{
		input.line(lineToRead);
		toReturn = input.read();
	}
	input.close();
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
	input = File(inputPath, "r");
	input.line(startLine);
	hv3ItemArray = @""@;
	hv3ItemArrayIndex = 1;
	foundHV3Block = 0;
	lineNumber = 1;

	while(lineNumber <= input.linecount())
	{
		line = input.read();
		lineArray = parse(" ",line);
		if((size(lineArray) == 4) && (lineArray[1] == "Plugin") && (lineArray[2] == "VolumetricHandler") && (lineArray[4] == "HyperVoxelsFilter"))
		{
			foundHV3Block = 1;
		}
		if (foundHV3Block == 1)
		{
			if(line == "  { HVObject")
			{
				line = input.read();
				if(line == "    { HVLink")
				{
					line = input.read(); // should now get ID. Unfortunately, it's quoted and prefixed by 6 spaces. We'll take care of that.
					hv3ItemArray[hv3ItemArrayIndex] = int(unquoteString(strright(line,size(line) - 6)));
					hv3ItemArrayIndex++;
				}
			}
			if(line == "EndPlugin")
			{
				break; // hit the end of the HV3 block.
			}
		}
		lineNumber = input.line() + 1;
	}
	input.close();
	if (hv3ItemArrayIndex == 1) // we found no item IDs within the specified lines.
	{
		return nil;
	} else {
		return hv3ItemArray;
	}	
}
