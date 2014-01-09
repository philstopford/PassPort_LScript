getPassEditorStartLine: inputPath
{
	gpesl_input = File(inputPath, "r");
	toReturn = nil;

	while (!gpesl_input.eof())
	{
		lineArray = parse(" ", gpesl_input.read());
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
	relStartLine = getEntityStartLine(objID,inputPath);
	relEndLine = getEntityEndLine(relStartLine+ 1, objID, inputPath);
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

getPixelFilterLine: pixelFilterString, inputPath
{
	gpf_input = File(inputPath, "r");
	toReturn = nil;
	while (!gpf_input.eof())
	{
		lineArray = parse(" ", gpf_input.read());
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
		lineArray = parse(" ", gvl_input.read());
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

getEntityStartLine: objID, inputPath
{
	entityGenus = int(strleft(string(objID),1));
	toReturn = 0;
	if(entityGenus > 3 || entityGenus < 1)
	{
		logger("error", "getEntityStartLine: invalid genus detected: " + entityGenus.asStr());
	}
	if (entityGenus == 1)
	{
		startMarkerStringArray = @"LoadObjectLayer","AddNullObject"@;
	}
	if (entityGenus == 2)
	{
		startMarkerStringArray = @"AddLight"@;
	}
	if (entityGenus == 3)
	{
		startMarkerStringArray = @"AddCamera"@;
	}

	gesl_input = File(inputPath, "r");

	while(!gesl_input.eof())
	{
		gesl_lineArray = parse(" ", gesl_input.read());
		if (size(gesl_lineArray) >= 2)
		{
			for (sms_counter = 1; sms_counter <= size(startMarkerStringArray); sms_counter++)
			{
				if(gesl_lineArray[1] == startMarkerStringArray[sms_counter])
				{
					if((entityGenus == 1) && (sms_counter == 1))
					{
						// Need to special case this handling due to the layer reference in 'LoadObjectLayer'
						gesl_ArrayIndex = 3;
					} else {
						gesl_ArrayIndex = 2;
					}
					if (gesl_lineArray[gesl_ArrayIndex] == string(objID))
					{
						toReturn = gesl_input.line() - 1; // decrement for read event.
						break;
					}
				}
			}
		}
		if(toReturn != 0)
		{
			break;
		}
	}
	gesl_input.close();
	if(toReturn == 0)
	{
		logger("error", "getEntityStartLine: failed to find start line for entity ID: " + objID.asStr() + " in " + inputPath);
	}
	return(toReturn);
}

getEntityEndLine: startLine,objID,inputPath
{
	entityGenus = int(strleft(string(objID),1));
	toReturn = 0;
	if(entityGenus > 3 || entityGenus < 1)
	{
		logger("error", "getEntityEndLine: invalid genus detected: " + entityGenus.asStr());
	}
	if(startLine == 0 || startLine == nil)
	{
		startLine = getEntityStartLine(objID,inputPath);
		startLine += 1;
	}
	if (entityGenus == 1)
	{
		endMarkerStringArray = @"LoadObjectLayer","AddNullObject","AmbientColor"@;
	}
	if (entityGenus == 2)
	{
		endMarkerStringArray = @"AddLight","AddCamera"@;
	}
	if (entityGenus == 3)
	{
		endMarkerStringArray = @"AddCamera","Antialiasing"@;
	}

	geel_input = File(inputPath, "r");
	geel_input.line(startLine);

	while(!geel_input.eof())
	{
		geel_lineArray = parse(" ", geel_input.read());
		if(sizeof(geel_lineArray) >= 2)
		{
			for (ems_counter = 1; ems_counter <= size(endMarkerStringArray); ems_counter++)
			{
				if(geel_lineArray[1] == endMarkerStringArray[ems_counter])
				{
					toReturn = geel_input.line() - 1; // decrement for read event.
					break;
				}
			}

			if (toReturn != 0)
			{
				if(entityGenus == 1)
				{
					if(toReturn == startLine)
					{
						logger("error","getEntityEndLine: end line is start line for object entity! Function called incorrectly.");
					}
				}
				toReturn += -1; // offset back to real end line.
			}
		}
		if(toReturn != 0)
		{
			break;
		}
	}
	geel_input.close();
	if(toReturn == 0)
	{
		logger("error", "getEntityEndLine: failed to find end line for entity ID: " + objID.asStr() + " starting from line " + startLine.asStr() + " in " + inputPath);
	}
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
