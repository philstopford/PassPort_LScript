getPassEditorStartLine
{
	toReturn = nil;
	for (i = 1; i <= size(::readBuffer); i++)
	{
		lineArray = parse(" ", ::readBuffer[i]);
		if(size(lineArray) >= 4)
		{
			if(lineArray[2] == "MasterHandler" && lineArray[4] == "PassPort_MC")
			{
				toReturn = i;
				break;
			}
		}
	}
	return(toReturn);
}

getFFxItems: startLine
{
	ffxItemArray = @""@;
	ffxItemArrayIndex = 1;
	foundFFXBlock = 0;

	for(i = startLine; i <= size(::readBuffer); i++)
	{
		lineArray = parse(" ", ::readBuffer[i]);
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
	if (ffxItemArrayIndex == 1) // we found no item IDs within the specified lines.
	{
		return nil;
	} else {
		return ffxItemArray;
	}
}

getRelativityLines: mode, objID, objGenus
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
	relStartLine = getEntityStartLine(objID);
	relEndLine = getEntityEndLine(relStartLine + 1, objID);

	relLineArray = nil;
	relLineArrayCounter = 0;
	for (i = relStartLine; i <= relEndLine; i++)
	{
		relLine = ::readBuffer[i];
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
				relLineArray[relLineArrayCounter] = i;
				relLineArrayCounter++; // now to store the end line
				relLineArray[relLineArrayCounter] = getPartialLine(i, 0, searchEndLine);
			}
		}
	}
	return relLineArray;
}

getPixelFilterLine: pixelFilterString
{
	toReturn = nil;
	for (i = 1; i <= size(::readBuffer); i++)
	{
		lineArray = parse(" ", ::readBuffer[i]);
		if (size(lineArray) >= 4)
		{
			if((lineArray[1] == "Plugin") && (lineArray[2] == "PixelFilterHandler") && (lineArray[4] == pixelFilterString))
			{
				toReturn = i;
				break;
			}
		}
	}
	return toReturn;
}

getVolumetricHandlerLine: volumetricHandlerString
{
	toReturn = nil;
	for (i = 1; i <= size(::readBuffer); i++)
	{
		lineArray = parse(" ", ::readBuffer[i]);
		if (size(lineArray) >= 4)
		{
			if((lineArray[1] == "Plugin") && (lineArray[2] == "VolumetricHandler") && (lineArray[4] == volumetricHandlerString))
			{
				toReturn = i;
				break;
			}
		}
	}
	return toReturn;
}

getEntityStartLine: objID
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

	for(i = 1; i <= size(::readBuffer); i++)
	{
		lineArray = parse(" ", ::readBuffer[i]);
		if (size(lineArray) >= 2)
		{
			for (sms_counter = 1; sms_counter <= size(startMarkerStringArray); sms_counter++)
			{
				if(lineArray[1] == startMarkerStringArray[sms_counter])
				{
					if((entityGenus == 1) && (sms_counter == 1))
					{
						// Need to special case this handling due to the layer reference in 'LoadObjectLayer'
						arrayIndex = 3;
					} else {
						arrayIndex = 2;
					}
					if (lineArray[arrayIndex] == string(objID))
					{
						toReturn = i;
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
	if(toReturn == 0)
	{
		logger("error", "getEntityStartLine: failed to find start line for entity ID: " + objID.asStr() + " in array");
	}
	return(toReturn);
}

getEntityEndLine: startLine,objID
{
	entityGenus = int(strleft(string(objID),1));
	toReturn = 0;
	if(entityGenus > 3 || entityGenus < 1)
	{
		logger("error", "getEntityEndLine: invalid genus detected: " + entityGenus.asStr());
	}
	if(startLine == 0 || startLine == nil)
	{
		startLine = getEntityStartLine(objID);
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

	for(i = startLine; i <= size(::readBuffer); i++)
	{
		lineArray = parse(" ", ::readBuffer[i]);
		if(sizeof(lineArray) >= 2)
		{
			for (ems_counter = 1; ems_counter <= size(endMarkerStringArray); ems_counter++)
			{
				if(lineArray[1] == endMarkerStringArray[ems_counter])
				{
					toReturn = i;
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
	if(toReturn == 0)
	{
		logger("error", "getEntityEndLine: failed to find end line for entity ID: " + objID.asStr() + " starting from line " + startLine.asStr() + " in array");
	}
	return(toReturn);
}

getPartialLineFromFile: currentLine, endLine, searchString, inputPath
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

getPartialLine: currentLine, endLine, searchString
{
	searchLine[1] = searchString;
	searchStringSize = sizeof(searchLine[1]);
	if(currentLine == 0 || currentLine == nil)
	{
		currentLine = 1;
	}
	if(endLine == 0)
	{
		endLine = size(::readBuffer);
	}
	toReturn = nil;
	while(currentLine != endLine)
	{
		line = ::readBuffer[currentLine];
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
	return(toReturn);
}

getPartialLine_last: currentLine, endLine, searchString
{
	searchLine[1] = searchString;
	searchStringSize = sizeof(searchLine[1]);
	if(currentLine == 0)
	{
		currentLine = 1;
	}
	if(endLine == 0)
	{
		endLine = size(::readBuffer);
	}
	toReturn = nil;
	while(currentLine != endLine)
	{
		line = ::readBuffer[endLine];
		if(line)
		{
			if(size(line) >= searchStringSize)
			{
				linePart = strleft(line,searchStringSize);
				if(linePart == searchString)
				{
					toReturn = endLine;
					break;
				}
			}
		}
		endLine--;
	}
	return(toReturn);
}

readSpecificLine: lineToRead
{
	if (lineToRead > size(::readBuffer))
	{
		logger("error","readSpecificLine: tried to read a line beyond the array itself");
	}
	return(::readBuffer[lineToRead]);
}

getMasterPluginLine: masterPluginString
{
	// Let's get organized
	prefixMPStr = "Plugin MasterHandler";

	mPStartLine = 0;
	mPOK = 1;

	while(mPOK != nil)
	{
		mPStartLine = getPartialLine(mPStartLine,0,prefixMPStr);
		if(mPStartLine)
		{
			mPLine = readSpecificLine(mPStartLine);
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

getRendererPluginLine: rendererString
{
	prefixRPStr = "Plugin ExtRendererHandler";
	rPLine = getPartialLine(0,0,prefixRPStr);
	if(rendererString != "any")
	{
		return rPLine;
	} else {
		rPStr = readSpecificLine(rPLine);
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

getHyperVoxels3Items: startLine
{
	hv3ItemArray = @""@;
	hv3ItemArrayIndex = 1;
	foundHV3Block = 0;
	i = startLine;

	while(i <= startLine)
	{
		line = ::readBuffer[i];
		lineArray = parse(" ",line);
		if((size(lineArray) == 4) && (lineArray[1] == "Plugin") && (lineArray[2] == "VolumetricHandler") && (lineArray[4] == "HyperVoxelsFilter"))
		{
			foundHV3Block = 1;
		}
		if (foundHV3Block == 1)
		{
			if(line == "  { HVObject")
			{
				i++;
				line = ::readBuffer[i];
				if(line == "    { HVLink")
				{
					i++;
					line = ::readBuffer[i]; // should now get ID. Unfortunately, it's quoted and prefixed by 6 spaces. We'll take care of that.
					hv3ItemArray[hv3ItemArrayIndex] = int(unquoteString(strright(line,size(line) - 6)));
					hv3ItemArrayIndex++;
				}
			}
			if(line == "EndPlugin")
			{
				break; // hit the end of the HV3 block.
			}
		}
		i++;
	}
	if (hv3ItemArrayIndex == 1) // we found no item IDs within the specified lines.
	{
		return nil;
	} else {
		return hv3ItemArray;
	}	
}
