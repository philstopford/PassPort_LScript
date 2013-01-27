// globals
var buildString = "(build 0001)";
var scenesnames;
var passSelected = false;
var overridesSelected = false;
var passAssItems;
var passOverrideItems;
var overrideSettings;
var masterScene;
var image_formats_array;
var originalSelection;
var meshAgents;
var meshNames;
var meshIDs;
var meshOldIDs;
var lightAgents;
var lightNames;
var lightIDs;
var lightOldIDs;
var displayNames;
var o_displayNames;
var displayIDs;
var displayOldIDs;
var passNames;
var overrideNames;
var fileMenu_items;
var passMenu_items = @"Full Scene Pass","Empty Pass","Pass From Layout Selection","Duplicate Selected Pass"@;
var overrideMenu_items = @"Object Properties","Alternative Object...","Motion File...","Surface File...","Light Properties","Scene Master","==","Light Exclusions","Duplicate Selected Override"@;
var gad_PassesListview;
var gad_OverridesListview;
var c3;
var c3_5;
var gad_SelectedPass;
var c7;
var currentChosenPass;
var currentChosenPassString;
var interfaceRunYet;
var userOutputFolder;
var fileOutputPrefix;
var	userOutputString;
var areYouSurePrompts;
var doKeys;
var platformVar;
var useHackyUpdates;
var rgbSaveType;
var editorResolution;
var testResMultiplier;
var testRgbSaveType;
var sceneJustLoaded = 0;
var sceneJustSaved;
var testOutputPath;
var seqOutputPath;
// hacky scene save vars
var replaceMeVar;
var replaceCount;
var unsaved;
var listOneWidth;
var panelWidth;
var panelWidthOnOpen;
var listTwoWidth;
var listTwoPosition;
var panelWidth;
var panelHeight;
var listOneHeight;
// exclusion attempt;
var tempLightTransferring;
var light21;
var light23;
var lightListArray;

// registration variables
var dongleCheckVar;
var registeredDonglesVar;

// need for hacky saving
var needHackySaving;
var justReopened;
var beingEscaped;

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

