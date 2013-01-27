// scene rendering functions
win_bg_frameRender: sceneFile, frameOutputPath
{
	
    temp_dir = getdir("Temp");
    currentscene_path = sceneFile;
    currentscene_patharray = split(currentscene_path);
    currentscene_filename = currentscene_patharray[3] + currentscene_patharray[4];
    currenttime = Scene().currenttime;
    currentframe = Scene().currenttime*Scene().fps;
    extensionArray = parse("(",image_formats_array[testRgbSaveType]);
    extension = strleft(extensionArray[2],4);
    if(currentframe < 10)
    {
    	paddingString = "000";
    }
    else
    {
    	if(currentframe < 100)
    	{
    		paddingString = "00";
    	}
    	else
    	{
    		if(currentframe < 1000)
    		{
    			paddingString = "0";
    		}
    		else
    		{
    			paddingString = "";
    		}
    	}
    }
    actualImageOutput = frameOutputPath + paddingString + string(currentframe) + extension;

    install_dir = getdir("Install");
    content_dir = getdir("Content");
    config_dir = getdir("Settings");
    if(currentscene_patharray[1] != nil)
    {
    	bashFilePath = currentscene_patharray[1] + currentscene_patharray[2] + "frameRender_bat.bat";
    }
    else
    {
    	bashFilePath = currentscene_patharray[2] + "frameRender_bat.bat";
    }

    // currentscene_patharray[2] = fixPathForWin32(currentscene_patharray[2]);

    bashOutput = File(bashFilePath,"w");

    outputLine = "\"" + install_dir + getsep() + "lwsn.exe\" -3 -c\"" + config_dir + "\" -d\"" + content_dir + "\" \"" + sceneFile + "\" " + currentframe + " " + currentframe + " " + "1";
    bashOutput.writeln(outputLine);

    bashOutput.writeln("@echo Displaying Completed Frame.\n");
    bashOutput.writeln("@\"" + actualImageOutput + "\"");

	/* Matt Gorner - get rid of extra slashes that stops the del command in the Batch file */
    t = currentscene_patharray[1] + getsep() + strip_slashes(currentscene_patharray[2]) + "frameRender_bat.bat";
    // bashOutput.writeln("@del \"" + bashFilePath + "\"\n");
    bashOutput.writeln("@del \"" + t + "\"\n");

	bashOutput.writeln("pause");

    bashOutput.close();

    //chdir(currentscene_patharray[2] + getsep());

    result = spawn(bashFilePath);
    //filedelete(scriptFilePath);

    /*
    commandadd =  "\"" + install_dir + getsep() + "lwsn.exe\" -3 -c\"" + config_dir + "\" -d\"" + content_dir + "\" \"" + scenespaths[items_array[x]] + scenesnames[items_array[x]] + "\" " + scenesstart[items_array[1]] + " " + scenesend[items_array[1]] + " " + scenesstep[items_array[1]];
    */
}

/* Matt Gorner - get rid of extra slashes that stops the del command in the Batch file */
strip_slashes: path
{
	temp = parse( "\\" , path);
	str = temp[1];

	for( loop = 2; loop <= temp.count(); loop++ )
	{
		str = str + getsep() + temp[loop];
	}

	str = str + getsep();

	return(str);
}

win_bg_sceneRender: sceneFile, frameOutputPath
{

    temp_dir = getdir("Temp");
    currentscene_path = sceneFile;
    currentscene_patharray = split(currentscene_path);
    currentscene_filename = currentscene_patharray[3] + currentscene_patharray[4];
    currenttime = Scene().currenttime;
    currentframe = Scene().currenttime*Scene().fps;
    extensionArray = parse("(",image_formats_array[rgbSaveType]);
    extension = strleft(extensionArray[2],4);
    renderStart = Scene().renderstart;
    renderEnd = Scene().renderend;
    renderStep = Scene().renderstep;

    install_dir = getdir("Install");
    content_dir = getdir("Content");
    config_dir = getdir("Settings");
    if(currentscene_patharray[1] != nil)
    {
    	bashFilePath = currentscene_patharray[1] + currentscene_patharray[2] + getsep() + "frameRender_bat.bat";
    }
    else
    {
    	bashFilePath = currentscene_patharray[2] + getsep() + "frameRender_bat.bat";
    }

    bashOutput = File(bashFilePath,"w");
	outputLine = "\"" + install_dir + getsep() + "lwsn.exe\" -3 -c\"" + config_dir + "\" -d\"" + content_dir + "\" \"" + sceneFile + "\" " + renderStart + " " + renderEnd + " " + renderStep;
    bashOutput.writeln(outputLine);
	bashOutput.writeln("@echo Sequence Render Complete.\n");

	/* Matt Gorner - get rid of extra slashes that stops the del command in the Batch file */
    t = currentscene_patharray[1] + getsep() + strip_slashes(currentscene_patharray[2]) + "frameRender_bat.bat";
    // bashOutput.writeln("@del \"" + bashFilePath + "\"\n");
    bashOutput.writeln("@del \"" + t + "\"\n");

    bashOutput.writeln("pause");
    bashOutput.close();
    result = spawn(bashFilePath);
}



win_bg_allSceneRender: sceneFile, frameOutputPath
{
	
    temp_dir = getdir("Temp");
    currentscene_path = sceneFile[1];
    currentscene_patharray = split(currentscene_path);
    currentscene_filename = currentscene_patharray[3] + currentscene_patharray[4];
    currenttime = Scene().currenttime;
    currentframe = Scene().currenttime*Scene().fps;
    extensionArray = parse("(",image_formats_array[rgbSaveType]);
    extension = strleft(extensionArray[2],4);
    renderStart = Scene().renderstart;
    renderEnd = Scene().renderend;
    renderStep = Scene().renderstep;

    install_dir = getdir("Install");
    content_dir = getdir("Content");
    config_dir = getdir("Settings");

    if(currentscene_patharray[1] != nil)
    {
    	bashFilePath = currentscene_patharray[1] + currentscene_patharray[2] + getsep() + "frameRender_bat.bat";
    }
    else
    {
    	bashFilePath = currentscene_patharray[2] + getsep() + "frameRender_bat.bat";
    }

    bashOutput = File(bashFilePath,"w");
    
    for(x = 1; x <= size(sceneFile); x++)
    {
	   	outputLine = "\"" + install_dir + getsep() + "lwsn.exe\" -3 -c\"" + config_dir + "\" -d\"" + content_dir + "\" \"" + sceneFile[x] + "\" " + renderStart + " " + renderEnd + " " + renderStep;
	      bashOutput.writeln(outputLine);
    }
	bashOutput.writeln("@echo Passes Render Complete.\n");

	/* Matt Gorner - get rid of extra slashes that stops the del command in the Batch file */
    t = currentscene_patharray[1] + getsep() + strip_slashes(currentscene_patharray[2]) + "frameRender_bat.bat";
    // bashOutput.writeln("@del \"" + bashFilePath + "\"\n");
    bashOutput.writeln("@del \"" + t + "\"\n");
    
    bashOutput.writeln("pause");
    bashOutput.close();
    result = spawn(bashFilePath);
}


UB_bg_frameRender: sceneFile, frameOutputPath
{
	
    temp_dir = getdir("Temp");
    currentscene_path = sceneFile;
    currentscene_patharray = split(currentscene_path);
    currentscene_filename = currentscene_patharray[3] + currentscene_patharray[4];
    currenttime = Scene().currenttime;
    currentframe = Scene().currenttime*Scene().fps;
    extensionArray = parse("(",image_formats_array[testRgbSaveType]);
    extension = strleft(extensionArray[2],4);
    if(currentframe < 10)
    {
    	paddingString = "000";
    }
    else
    {
    	if(currentframe < 100)
    	{
    		paddingString = "00";
    	}
    	else
    	{
    		if(currentframe < 1000)
    		{
    			paddingString = "0";
    		}
    		else
    		{
    			paddingString = "";
    		}
    	}
    }
    actualImageOutput = frameOutputPath + paddingString + string(currentframe) + extension;
    
    install_dir = getdir("Install");
    content_dir = getdir("Content");
    config_dir = getdir("Settings");
    if(currentscene_patharray[1] != nil)
    {
    	bashFilePath = currentscene_patharray[1] + currentscene_patharray[2] + getsep() + "frameRender_bash.bash";
    	scriptFilePath = currentscene_patharray[1] + currentscene_patharray[2] + getsep() + "temp.scpt";
    	growlAppleScriptPath = currentscene_patharray[1] + currentscene_patharray[2] + getsep() + "growlNotify.scpt";

    }
    else
    {
    	bashFilePath = currentscene_patharray[2] + getsep() + "frameRender_bash.bash";
    	scriptFilePath = currentscene_patharray[2] + getsep() + "temp.scpt";
    	growlAppleScriptPath = currentscene_patharray[2] + getsep() + "growlNotify.scpt";
    }
    
	
	growlScriptOutput = File(growlAppleScriptPath,"w");
	growlScriptOutput.writeln("tell application \"GrowlHelperApp\"");
	growlScriptOutput.writeln("set the allNotificationsList to {\"PassPort Frame Render Complete Notification\",\"PassPort Pass Render Complete Notification\",\"PassPort All Passes Render Complete Notification\"}");
	growlScriptOutput.writeln("set the enabledNotificationsList to {\"PassPort Frame Render Complete Notification\",\"PassPort Pass Render Complete Notification\",\"PassPort All Passes Render Complete Notification\"}");
	growlScriptOutput.writeln("register as application \"PassPort for LightWave 3D\" all notifications allNotificationsList default notifications enabledNotificationsList icon of application \"Layout.app\"");
	growlScriptOutput.writeln("notify with name \"PassPort Frame Render Complete Notification\" title \"PassPort Render Complete.\" description \"Your PassPort single frame render of \\\"" + currentChosenPassString + "\\\" at frame " + currentframe + " is complete.\" application name \"PassPort for LightWave 3D\"");
	growlScriptOutput.writeln("end tell");
	growlScriptOutput.close();
       
    bashOutput = File(bashFilePath,"w");
   	outputLine = install_dir + getsep() + "Screamernet -3 -c" + config_dir + " -d" + content_dir + " " + sceneFile + " " + currentframe + " " + currentframe + " " + "1\;\n" + "open " + actualImageOutput + "\;";
    bashOutput.writeln(outputLine);
    bashOutput.writeln("rm " + bashFilePath);
    bashOutput.writeln("osascript \"" + growlAppleScriptPath + "\"");
    bashOutput.writeln("rm " + growlAppleScriptPath);
	bashOutput.writeln("echo \"Displaying Completed Frame.\"");
    bashOutput.close();
    
    scriptOutput = File(scriptFilePath,"w");
    scriptOutput.writeln("tell application \"Terminal\"");
    scriptOutput.writeln("	activate");
    scriptOutput.writeln("	do script \"bash " + bashFilePath + "\"");
    scriptOutput.writeln("end tell");
    chdir(currentscene_patharray[2] + getsep());
    systemCommand = "osascript \"temp.scpt\"";
       
    result = system(systemCommand); 
    filedelete(scriptFilePath);
    
    
    /*
    /Applications/Newtek/9x_beta/LightWave/ScreamerNet -3 -c/Applications/Newtek/9x_beta/config/ -d/Users/jezza/Documents/Projects/Production/MISSP/lw/ /Users/jezza/Documents/Projects/Production/MISSP/lw/Scenes/bak/bg_renderTesting.lws 31 31 1;
	open /Users/jezza/Documents/Projects/Production/LWG_Texture_Contest/July_07/images/renders/CG/bgRenderTesting_frame_0050.jpg;
	*/
    
}

UB_bg_sceneRender: sceneFile, frameOutputPath
{
	
    temp_dir = getdir("Temp");
    currentscene_path = sceneFile;
    currentscene_patharray = split(currentscene_path);
    currentscene_filename = currentscene_patharray[3] + currentscene_patharray[4];
    currenttime = Scene().currenttime;
    currentframe = Scene().currenttime*Scene().fps;
    renderStart = Scene().renderstart;
    renderEnd = Scene().renderend;
    renderStep = Scene().renderstep;
    extensionArray = parse("(",image_formats_array[rgbSaveType]);
    extension = strleft(extensionArray[2],4);
    
    install_dir = getdir("Install");
    content_dir = getdir("Content");
    config_dir = getdir("Settings");
    if(currentscene_patharray[1] != nil)
    {
    	bashFilePath = currentscene_patharray[1] + currentscene_patharray[2] + getsep() + "frameRender_bash.bash";
    	scriptFilePath = currentscene_patharray[1] + currentscene_patharray[2] + getsep() + "temp.scpt";
    	growlAppleScriptPath = currentscene_patharray[1] + currentscene_patharray[2] + getsep() + "growlNotify.scpt";
    }
    else
    {
    	bashFilePath = currentscene_patharray[2] + getsep() + "frameRender_bash.bash";
    	scriptFilePath = currentscene_patharray[2] + getsep() + "temp.scpt";
    	growlAppleScriptPath = currentscene_patharray[2] + getsep() + "growlNotify.scpt";
    }
    
    growlScriptOutput = File(growlAppleScriptPath,"w");
	growlScriptOutput.writeln("tell application \"GrowlHelperApp\"");
	growlScriptOutput.writeln("set the allNotificationsList to {\"PassPort Frame Render Complete Notification\",\"PassPort Pass Render Complete Notification\",\"PassPort All Passes Render Complete Notification\"}");
	growlScriptOutput.writeln("set the enabledNotificationsList to {\"PassPort Frame Render Complete Notification\",\"PassPort Pass Render Complete Notification\",\"PassPort All Passes Render Complete Notification\"}");
	growlScriptOutput.writeln("register as application \"PassPort for LightWave 3D\" all notifications allNotificationsList default notifications enabledNotificationsList icon of application \"Layout.app\"");
	growlScriptOutput.writeln("notify with name \"PassPort Pass Render Complete Notification\" title \"PassPort Render Complete.\" description \"Your PassPort Pass render of \\\"" + currentChosenPassString + "\\\" from frame " + renderStart + " to frame " + renderEnd + " is complete.\" application name \"PassPort for LightWave 3D\"");
	growlScriptOutput.writeln("end tell");
	growlScriptOutput.close();
       
    bashOutput = File(bashFilePath,"w");
   	outputLine = install_dir + getsep() + "Screamernet -3 -c" + config_dir + " -d" + content_dir + " " + sceneFile + " " + renderStart + " " + renderEnd + " " + renderStep + "\;\n";
    bashOutput.writeln(outputLine);
    bashOutput.writeln("rm " + bashFilePath);
    bashOutput.writeln("osascript \"" + growlAppleScriptPath + "\"");
    bashOutput.writeln("rm " + growlAppleScriptPath);
	bashOutput.writeln("echo \"Sequence Render Complete.\"");
    bashOutput.close();
    
    scriptOutput = File(scriptFilePath,"w");
    scriptOutput.writeln("tell application \"Terminal\"");
    scriptOutput.writeln("	activate");
    scriptOutput.writeln("	do script \"bash " + bashFilePath + "\"");
    scriptOutput.writeln("end tell");
    chdir(currentscene_patharray[2] + getsep());
    systemCommand = "osascript \"temp.scpt\"";
       
    result = system(systemCommand); 
    filedelete(scriptFilePath);
    
}


UB_bg_allSceneRender: sceneFile, frameOutputPath
{
	temp_dir = getdir("Temp");
	currenttime = Scene().currenttime;
    currentframe = Scene().currenttime*Scene().fps;
    renderStart = Scene().renderstart;
    renderEnd = Scene().renderend;
    renderStep = Scene().renderstep;
    extensionArray = parse("(",image_formats_array[rgbSaveType]);
    extension = strleft(extensionArray[2],4);
    
    install_dir = getdir("Install");
    content_dir = getdir("Content");
    config_dir = getdir("Settings");
    
    currentscene_path = sceneFile[1];
    currentscene_patharray = split(currentscene_path);
    currentscene_filename = currentscene_patharray[3] + currentscene_patharray[4];
    
    if(currentscene_patharray[1] != nil)
    {
    	bashFilePath = currentscene_patharray[1] + currentscene_patharray[2] + getsep() + "frameRender_bash.bash";
    	scriptFilePath = currentscene_patharray[1] + currentscene_patharray[2] + getsep() + "temp.scpt";
    	growlAppleScriptPath = currentscene_patharray[1] + currentscene_patharray[2] + getsep() + "growlNotify.scpt";
    }
    else
    {
    	bashFilePath = currentscene_patharray[2] + getsep() + "frameRender_bash.bash";
    	scriptFilePath = currentscene_patharray[2] + getsep() + "temp.scpt";
    	growlAppleScriptPath = currentscene_patharray[2] + getsep() + "growlNotify.scpt";
    }
    bashOutput = File(bashFilePath,"w");

	for(x = 1; x <= size(sceneFile); x++)
	{
		outputLine = install_dir + getsep() + "Screamernet -3 -c" + config_dir + " -d" + content_dir + " " + sceneFile[x] + " " + renderStart + " " + renderEnd + " " + renderStep + "\;\n";
	    bashOutput.writeln(outputLine);
	}
	
	allPassesString = passNames[1];
	if(size(passNames) > 1)
	{
		for(x = 2; x <= size(passNames); x++)
		{
			allPassesString = allPassesString + " | " + passNames[x];
		}
	}
	
	growlScriptOutput = File(growlAppleScriptPath,"w");
	growlScriptOutput.writeln("tell application \"GrowlHelperApp\"");
	growlScriptOutput.writeln("set the allNotificationsList to {\"PassPort Frame Render Complete Notification\",\"PassPort Pass Render Complete Notification\",\"PassPort All Passes Render Complete Notification\"}");
	growlScriptOutput.writeln("set the enabledNotificationsList to {\"PassPort Frame Render Complete Notification\",\"PassPort Pass Render Complete Notification\",\"PassPort All Passes Render Complete Notification\"}");
	growlScriptOutput.writeln("register as application \"PassPort for LightWave 3D\" all notifications allNotificationsList default notifications enabledNotificationsList icon of application \"Layout.app\"");
	growlScriptOutput.writeln("notify with name \"PassPort All Passes Render Complete Notification\" title \"PassPort Render Complete.\" description \"Your PassPort render of passes \\\"" + allPassesString + "\\\" from frame " + renderStart + " to frame " + renderEnd + " is complete.\" application name \"PassPort for LightWave 3D\"");
	growlScriptOutput.writeln("end tell");
	growlScriptOutput.close();
	
    bashOutput.writeln("rm " + bashFilePath);
    bashOutput.writeln("osascript \"" + growlAppleScriptPath + "\"");
    bashOutput.writeln("rm " + growlAppleScriptPath);
	bashOutput.writeln("echo \"Passes Render Complete.\"");
    bashOutput.close();
    
    scriptOutput = File(scriptFilePath,"w");
    scriptOutput.writeln("tell application \"Terminal\"");
    scriptOutput.writeln("	activate");
    scriptOutput.writeln("	do script \"bash " + bashFilePath + "\"");
    scriptOutput.writeln("end tell");
    chdir(currentscene_patharray[2] + getsep());
    systemCommand = "osascript \"temp.scpt\"";
       
    result = system(systemCommand); 
    filedelete(scriptFilePath);
    
}


