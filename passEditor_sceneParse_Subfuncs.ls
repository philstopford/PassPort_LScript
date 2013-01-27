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
		/* Changed to .linecount as .eof() only returns a bool value, if the purpose of this is to count the number of lines in the scene file Matt Gorner */
		// endLine = input.eof();
		endLine = input.linecount();
	}
	
	/* Changed these variables because they were never getting initialised - Matt Gorner */
	startLine = 1;
	endLine = input.linecount();


	currentLine = 1;
	input.line(startLine);

	while (currentLine <= endLine) {
		line = input.read();
		lineArray = parse(" ", line);
		if(size(lineArray) >= 4)
		{
			if(lineArray[2] == "MasterHandler" && lineArray[4] == "PassPort_MC")
			{
				currentLine = input.line() - 1;
				return(currentLine);
			}
		}
		currentLine++;
	}

	input.close();
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
		/* Changed to .linecount as .eof() only returns a bool value, if the purpose of this is to count the number of lines in the scene file Matt Gorner */
		// endLine = input.eof();
		endLine = input.linecount();
	}

	currentLine = 1;
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
					currentLine = input.line() - 1;
					return(currentLine);
				}
			}
		}
	}
	input.close();
}

getLightLines: startLine,endLine,objID,inputPath
{
	// Removed the a of ra, because the file is not being appended to in these functions, and it *seemed* to be causing a crash - Matt Gorner
	// input = File(inputPath, "r");
	input = File(inputPath, "r");

	if(startLine == 0 || startLine == nil)
	{
		startLine = 1;
	}
	if(endLine == 0)
	{
		/* Changed to .linecount as .eof() only returns a bool value, if the purpose of this is to count the number of lines in the scene file Matt Gorner */
		// endLine = input.eof();
		endLine = input.linecount();
	}
	currentLine = 1;
	input.line(startLine);
	while(currentLine != endLine)
	{
		line = input.read();
		lineArray = parse(" ",line);
		if(size(lineArray) >= 2)
		{
			if(lineArray[1] == "AddLight" && lineArray[2] == string(objID))
			{
				currentLine = input.line() - 1;
				return(currentLine);
			}
		}
	}
	input.close();
}

getObjectEndLine: startLine,endLine,objID,inputPath
{
	// Removed the a of ra, because the file is not being appended to in these functions, and it *seemed* to be causing a crash - Matt Gorner
	// input = File(inputPath, "r");
	input = File(inputPath, "r");

	if(startLine == 0 || startLine == nil)
	{
		startLine = 1;
	}
	if(endLine == 0)
	{
		/* Changed to .linecount as .eof() only returns a bool value, if the purpose of this is to count the number of lines in the scene file Matt Gorner */
		// endLine = input.eof();
		endLine = input.linecount();
	}
	currentLine = 1;
	input.line(startLine);
	while(currentLine != endLine)
	{
		line = input.read();
		currentLine = input.line() - 1;
		currentLineArray[1] = line;
		if(sizeof(currentLineArray[1]) >= 12)
		{
			currentLineString = strleft(line,12);
			if(currentLineString == "LoadObjectLa" || currentLineString == "AddNullObjec")
			{
				return(currentLine);
			}
			else
			{
				if(currentLineString == "AmbientColor")
				{
					return(currentLine);
				}
			}
		}
	}
	input.close();
}

getLightEndLine: startLine,endLine,objID,inputPath
{
	// Removed the a of ra, because the file is not being appended to in these functions, and it *seemed* to be causing a crash - Matt Gorner
	// input = File(inputPath, "r");
	input = File(inputPath, "r");

	if(startLine == 0 || startLine == nil)
	{
		startLine = 1;
	}
	if(endLine == 0)
	{
		/* Changed to .linecount as .eof() only returns a bool value, if the purpose of this is to count the number of lines in the scene file Matt Gorner */
		// endLine = input.eof();
		endLine = input.linecount();
	}
	currentLine = 1;
	input.line(startLine);
	while(currentLine != endLine)
	{
		line = input.read();
		currentLine = input.line() - 1;
		currentLineArray[1] = line;
		if(sizeof(currentLineArray[1]) >= 8)
		{
			currentLineString = strleft(line,8);
			if(currentLineString == "AddLight" || currentLineString == "AddCamer")
			{
				return(currentLine);
			}
		}
	}
	input.close();
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
	//info(toReturn);
	return(toReturn);
}

