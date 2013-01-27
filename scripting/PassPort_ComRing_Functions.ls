// PassPort ComRing Functions
var tempTransferring;
var tempEventCodeTransferring;

ppConnect
{
	comringattach("LW_PassPort","ppReturnData");	
}

ppLoadSettings: rpeFile, replaceBool
{
	// set up and send the command for saving PassPort settings
	commandCode = 5;
	sendCommand[1] = "loadSettings";
	sendCommand[2] = rpeFile;
	sendCommand[3] = string(replaceBool);
	comRingCommand = comringencode(@"s:200#3"@,sendCommand);
	comringmsg("LW_PassPort",commandCode,comRingCommand);	
}

ppSaveCurrentSettings: rpeFile
{
	// set up and send the command for saving PassPort settings
	commandCode = 5;
	sendCommand[1] = "saveCurrentSettings";
	sendCommand[2] = rpeFile;
	sendCommand[3] = "";
	comRingCommand = comringencode(@"s:200#3"@,sendCommand);
	comringmsg("LW_PassPort",commandCode,comRingCommand);	
}

ppSavePassAsScene: lwsFile
{
	// set up and send the command for saving a pass as a scene
	commandCode = 5;
	sendCommand[1] = "savePassAsScene";
	sendCommand[2] = lwsFile;
	sendCommand[3] = "";
	comRingCommand = comringencode(@"s:200#3"@,sendCommand);
	comringmsg("LW_PassPort",commandCode,comRingCommand);
}

ppP_AddItem: passName,ID
{
	// set up and send the command for adding an item to a pass
	commandCode = 2;
	sendCommand[1] = "doAddItem";
	sendCommand[2] = passName;
	sendCommand[3] = string(ID);
	comRingCommand = comringencode(@"s:200#3"@,sendCommand);
	comringmsg("LW_PassPort",commandCode,comRingCommand);
}

ppP_ClearItem: passName,ID
{
	// set up and send the command for removing an item from a pass
	commandCode = 2;
	sendCommand[1] = "doClearItem";
	sendCommand[2] = passName;
	sendCommand[3] = string(ID);
	comRingCommand = comringencode(@"s:200#3"@,sendCommand);
	comringmsg("LW_PassPort",commandCode,comRingCommand);
}

ppO_AddItem: passName,overrideName,ID
{
	// set up and send the command for adding an item to an override
	commandCode = 3;
	sendCommand[1] = "doAddItem";
	sendCommand[2] = passName;
	sendCommand[3] = overrideName;
	sendCommand[4] = string(ID);
	comRingCommand = comringencode(@"s:200#4"@,sendCommand);
	comringmsg("LW_PassPort",commandCode,comRingCommand);
}

ppO_ClearItem: passName,overrideName,ID
{
	// set up and send the command for removing an item from an override
	commandCode = 3;
	sendCommand[1] = "doClearItem";
	sendCommand[2] = passName;
	sendCommand[3] = overrideName;
	sendCommand[4] = string(ID);
	comRingCommand = comringencode(@"s:200#4"@,sendCommand);
	comringmsg("LW_PassPort",commandCode,comRingCommand);
}

ppO_DuplicateOverride: overrideName
{
	// set up and send the command for removing an item from an override
	commandCode = 3;
	sendCommand[1] = "doDuplicateOverride";
	sendCommand[2] = overrideName;
	sendCommand[3] = "";
	sendCommand[4] = "";
	comRingCommand = comringencode(@"s:200#4"@,sendCommand);
	comringmsg("LW_PassPort",commandCode,comRingCommand);
}

ppCreatePass: passName
{
	// set up and send the command for making a new pass
	commandCode = 1;
	sendCommand[1] = "doCreatePass";
	sendCommand[2] = passName;
	comRingCommand = comringencode(@"s:200#2"@,sendCommand);
	comringmsg("LW_PassPort",commandCode,comRingCommand);
}

ppSelectPass: passName
{
	// set up and send the command for selecting a pass
	commandCode = 6;
	sendCommand[1] = "doSelect";
	sendCommand[2] = passName;
	comRingCommand = comringencode(@"s:200#2"@,sendCommand);
	comringmsg("LW_PassPort",commandCode,comRingCommand);
}

ppEditPass: passName
{
	// set up and send the command for editing a pass
	commandCode = 1;
	sendCommand[1] = "doEditPass";
	sendCommand[2] = passName;
	comRingCommand = comringencode(@"s:200#2"@,sendCommand);
	comringmsg("LW_PassPort",commandCode,comRingCommand);
}

ppDuplicatePass
{
	// set up and send the command for editing a pass
	commandCode = 1;
	sendCommand[1] = "doDuplicatePass";
	sendCommand[2] = "";
	comRingCommand = comringencode(@"s:200#2"@,sendCommand);
	comringmsg("LW_PassPort",commandCode,comRingCommand);
}

ppDeletePass
{
	// set up and send the command to delete the selected pass
	commandCode = 1;
	sendCommand[1] = "doDeletePass";
	sendCommand[2] = "";
	comRingCommand = comringencode(@"s:200#2"@,sendCommand);
	comringmsg("LW_PassPort",commandCode,comRingCommand);
}

ppChangeCurrentPass: passName
{
	// set up and send the command for changing the pass
	commandCode = 6;
	sendCommand[1] = "doChange";
	sendCommand[2] = passName;
	comRingCommand = comringencode(@"s:200#2"@,sendCommand);
	comringmsg("LW_PassPort",commandCode,comRingCommand);
	
}

ppRefresh
{
	// set up and send the command to refresh the list
	commandCode = 4;
	sendCommand2 = "updateListsNow";
	comRingCommand = comringencode(@"s:200"@,sendCommand2);
	comringmsg("LW_PassPort",commandCode,comRingCommand);
}

ppRenderPassFrame
{
	// set up and send the command to render a frame
	commandCode = 4;
	sendCommand2 = "renderPassFrame";
	comRingCommand = comringencode(@"s:200"@,sendCommand2);
	comringmsg("LW_PassPort",commandCode,comRingCommand);
}

ppRenderPassScene
{
	// set up and send the command to render the scene
	commandCode = 4;
	sendCommand2 = "renderPassScene";
	comRingCommand = comringencode(@"s:200"@,sendCommand2);
	comringmsg("LW_PassPort",commandCode,comRingCommand);
}

ppRenderAllPasses
{
	// set up and send the command to render all passes
	commandCode = 4;
	sendCommand2 = "renderAllPasses";
	comRingCommand = comringencode(@"s:200"@,sendCommand2);
	comringmsg("LW_PassPort",commandCode,comRingCommand);
}


ppDisconnect
{
	comringdetach("LW_PassPort");
}



functionNotes
{
	/*
	commandCode 1 is to work with passes.
	commandCode 2 is to work with pass assignments.
	commandCode 3 is to work with override assignments.
	commandCode 4 is to activate an interface functions that has no browser feedback.  one click operations, basically.
	commandCode 5 is to activate the interface functions that lead to file browsers.  saving passes as scenes and saving/loading settings.
	commandCode 6 is to select or change passes.
	
	
	commandCode 1:
	doCreatePass accepts 1 other string argument, which is the name of the pass.
	doEditPass  accepts 1 other string argument, which is the new name for the selected pass.
	doDeletePass accepts a blank string as a second argument, and deletes the selected pass.
	
	commandCode 2:
	doAddItem accepts 2 other string arguments, the pass name to assign to and the object id as a string.
	doClearItem accepts 2 other string arguments, the pass name to and the object id as a string.
	
	commandCode 3:
	doAddItem accepts 3 other string arguments, the pass, the override name to assign to and either "sel", "all", or the object id as a string.
	doClearItem accepts 3 other string arguments, the pass, the override name to clear from and either "sel", "all", or the object id as a string.
	
	commandCode 4:
	renderPassFrame
	renderPassScene
	renderAllPasses
	updateListsNow
	
	commandCode 5:
	savePassAsScene accepts one other string argument, the path to the new scene file.
	saveCurrentSettings accepts one other string argument, the path to the new settings file.
	loadSettings accepts 1 other string argument, the path to the settings file to load.
	
	commandCode 6:
	doSelect accepts 1 other string argument, the name of a pass to select.
	doChange accepts 1 other string argument, the name of the pass to change to.
	
	*/
	
}
