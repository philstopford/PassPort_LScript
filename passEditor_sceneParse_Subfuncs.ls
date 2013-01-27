//scene parsing functions
getPassEditorStartLine: inputPath
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
	
	/* Changed these variables because they were never getting initialised - Matt Gorner */
	startLine = 1;
	endLine = input.linecount();


	tempNumber = 1;
	input.line(startLine);

	while(tempNumber != endLine)
	{
		line = input.read();
		lineArray = parse(" ", line);
		if(size(lineArray) >= 4)
		{
			if(lineArray[2] == "MasterHandler" && lineArray[4] == "PassPort_MC")
			{
				tempNumber = input.line() - 1;
				return(tempNumber);
			}
		}
	}
	input.close();
}



getObjectLines: startLine,endLine,objID,inputPath
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

	tempNumber = 1;
	input.line(startLine);

	while(tempNumber != endLine)
	{
		line = input.read();
		lineArray = parse(" ",line);
		if(size(lineArray) >= 3)
		{
			if(lineArray[1] == "LoadObjectLayer" || lineArray[1] == "AddNullObject")
			{
				if(lineArray[3] == string(objID) || lineArray[2] == string(objID))
				{
					tempNumber = input.line() - 1;
					return(tempNumber);
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
	tempNumber = 1;
	input.line(startLine);
	while(tempNumber != endLine)
	{
		line = input.read();
		lineArray = parse(" ",line);
		if(size(lineArray) >= 2)
		{
			if(lineArray[1] == "AddLight" && lineArray[2] == string(objID))
			{
				tempNumber = input.line() - 1;
				return(tempNumber);
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
	tempNumber = 1;
	input.line(startLine);
	while(tempNumber != endLine)
	{
		line = input.read();
		tempNumber = input.line() - 1;
		tempLineArray[1] = line;
		if(sizeof(tempLineArray[1]) >= 12)
		{
			tempString = strleft(line,12);
			if(tempString == "LoadObjectLa" || tempString == "AddNullObjec")
			{
				return(tempNumber);
			}
			else
			{
				if(tempString == "AmbientColor")
				{
					return(tempNumber);
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
	tempNumber = 1;
	input.line(startLine);
	while(tempNumber != endLine)
	{
		line = input.read();
		tempNumber = input.line() - 1;
		tempLineArray[1] = line;
		if(sizeof(tempLineArray[1]) >= 8)
		{
			tempString = strleft(line,8);
			if(tempString == "AddLight" || tempString == "AddCamer")
			{
				return(tempNumber);
			}
		}
	}
	input.close();
}

getPartialLine: startLine, endLine, searchString, inputPath
{
	// Removed the a of ra, because the file is not being appended to in these functions, and it *seemed* to be causing a crash - Matt Gorner
	// input = File(inputPath, "r");
	input = File(inputPath, "r");

	searchLine[1] = searchString;
	searchStringSize = sizeof(searchLine[1]);
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
	tempNumber = 1;
	input.line(startLine);
	while(tempNumber != endLine)
	{
		line = input.read();
		tempNumber = input.line() - 1;
		if(line)
		{
			tempSize = size(line);
			if(tempSize >= searchStringSize)
			{
				linePart = strleft(line,searchStringSize);
				if(linePart == searchString)
				{
					if(tempNumber == 0)
					{
						toReturn = nil;
						break;
					}
					else
					{
						toReturn = tempNumber;
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

