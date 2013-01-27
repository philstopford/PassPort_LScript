//scene parsing functions
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
				toReturn = input.line() - 1;
				break;
			}
		}
		currentLine++;
	}

	input.close();
	return(toReturn);
}

getObjectLines: startLine,endLine,objID,inputPath
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

	currentLine = 1;
	toReturn = nil;
	input.line(startLine);

	while(currentLine != endLine)
	{
		line = input.read();
		lineArray = parse(" ",line);
		if(size(lineArray) >= 3)
		{
			if(lineArray[1] == "LoadObjectLayer" || lineArray[1] == "AddNullObject")
			{
				if(lineArray[3] == string(objID) || lineArray[2] == string(objID))
				{
					toReturn = input.line() - 1;
					break;
				}
			}
		}
	}
	input.close();
	return(toReturn);
}

getLightLines: startLine,endLine,objID,inputPath
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
	currentLine = 1;
	toReturn = nil;
	input.line(startLine);
	while(currentLine != endLine)
	{
		line = input.read();
		lineArray = parse(" ",line);
		if(size(lineArray) >= 2)
		{
			if(lineArray[1] == "AddLight" && lineArray[2] == string(objID))
			{
				toReturn = input.line() - 1;
				break;
			}
		}
	}
	input.close();
	return(toReturn);
}

getCameraLines: startLine,endLine,objID,inputPath
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
	currentLine = 1;
	toReturn = nil;
	input.line(startLine);
	while(currentLine != endLine)
	{
		line = input.read();
		lineArray = parse(" ",line);
		if(size(lineArray) >= 2)
		{
			if(lineArray[1] == "AddCamera" && lineArray[2] == string(objID))
			{
				toReturn = input.line() - 1;
				break;
			}
		}
	}
	input.close();
	return(toReturn);
}

getObjectEndLine: startLine,endLine,objID,inputPath
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
	currentLine = 1;
	toReturn = nil;
	input.line(startLine);
	while(currentLine != endLine)
	{
		line = input.read();
		currentLine = input.line() - 1;
		currentLineArray[1] = line;
		if(sizeof(currentLineArray[1]) >= 12)
		{
			currentLineString = strleft(line,12);
			if(currentLineString == "LoadObjectLa" || currentLineString == "AddNullObjec" || currentLineString == "AmbientColor")
			{
				toReturn = currentLine;
				break;
			}
		}
	}
	input.close();
	return(toReturn);
}

getCameraEndLine: startLine,endLine,objID,inputPath
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
	currentLine = 1;
	toReturn = nil;
	endMarkerString = "Plugin CameraHandler";
	input.line(startLine);
	while(currentLine != endLine)
	{
		line = input.read();
		currentLine = input.line() - 1;
		currentLineArray[1] = line;
		if(sizeof(currentLineArray[1]) >= size(endMarkerString))
		{
			currentLineString = strleft(line,size(endMarkerString));
			if(currentLineString == endMarkerString)
			{
				toReturn = currentLine + 2; // offset to include the EndPlugin line, the whitespace afterwards and the subsequent line to match original code flow.
				break;
			}
		}
	}
	input.close();
	return(toReturn);
}

getLightEndLine: startLine,endLine,objID,inputPath
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
	currentLine = 1;
	toReturn = nil;
	endMarkerString = "Plugin LightHandler";
	input.line(startLine);
	while(currentLine != endLine)
	{
		line = input.read();
		currentLine = input.line() - 1;
		currentLineArray[1] = line;
		if(sizeof(currentLineArray[1]) >= size(endMarkerString))
		{
			currentLineString = strleft(line,size(endMarkerString));
			if(currentLineString == endMarkerString)
			{
				toReturn = currentLine + 2; // offset to include the EndPlugin line, the whitespace afterwards and the subsequent line to match original code flow.
				break;
			}
		}
	}
	input.close();
	return(toReturn);
}

getPartialLine: startLine, endLine, searchString, inputPath
{
	input = File(inputPath, "r");

	searchLine[1] = searchString;
	searchStringSize = sizeof(searchLine[1]);
	if(startLine == 0 || startLine == nil)
	{
		startLine = 1;
	}
	if(endLine == 0)
	{
		endLine = input.linecount();
	}
	currentLine = 1;
	toReturn = nil;
	input.line(startLine);
	while(currentLine != endLine)
	{
		line = input.read();
		currentLine = input.line() - 1;
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
	}
	input.close();
	return(toReturn);
}

