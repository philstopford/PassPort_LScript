// kray2.5 quickLWF globals
@insert "@kray/passEditor_Kray25QuickLWF_Support_Vars.ls"
@insert "@kray/passEditor_Kray25QuickLWF_Support_UI.ls"

scnGen_kray25_QuickLWF
{
	// Kray, happily, has all of its settings in the scene file so all we need to do now is to find the header line and then use hard-coded offsets to the data we care about. There are no line markers, so hard-coding is the only option.
	// It's bloating this code somewhat, but for flexibility, we'll abstract our line references with variables to make this maintainable in future.

	kray_QuickLWF_PluginHeaderLine = getMasterPluginLine("KrayQuickLWF", ::updatedCurrentScenePath); // Should pick up MasterHandler for Kray
	// logger("log_info",""kray at " + kray_QuickLWF_PluginHeaderLine.asStr());

	// Startup checks to ensure we're working against a known quantity.
    if (kray_QuickLWF_PluginHeaderLine == nil)
    {
		logger("info","scnGen_kray25_QuickLWF: Kray 2.5 QuickLWF plugin not found. Guessing....");
		kray_QuickLWF_pluginBuild = default_kray_QuickLWF_pluginBuild;
		kray_QuickLWF_sectionTag = default_kray_QuickLWF_sectionTag;
	} else {
		searchString = "Plugin MasterHandler";
		input = File(::updatedCurrentScenePath, "r");
		input.line(kray_QuickLWF_PluginHeaderLine + 3); // offset for the plugin header, the LSC script reference and the Kray encapsulator
		kray_QuickLWF_pluginBuild = input.readInt();
		kray_QuickLWF_sectionTag = input.readInt();
		input.close();
		kray_QuickLWF_PluginEndLine = getPartialLine(kray_QuickLWF_PluginHeaderLine,0,"EndPlugin",::updatedCurrentScenePath);
		// Check known version of Kray in case of mismatch
		if((kray_QuickLWF_pluginBuild != default_kray_QuickLWF_pluginBuild) || (kray_QuickLWF_sectionTag != default_kray_QuickLWF_sectionTag))
		{
			logger("error","scnGen_kray25_QuickLWF: Kray QuickLWF version or section tag mismatch: " + kray_QuickLWF_pluginBuild.asStr() + "/" + kray_QuickLWF_sectionTag.asStr());
		}
	}

	// Kray writes out according to its functions :
	//		::krayfile.writeln("Kray{");
	//		save_general(io);
	//		save_krayscript_file(io,"");
	//		::krayfile.writeln("}");

	// Start values for the huge chunk of settings.
	// krayLineNumber = kray_QuickLWF_pluginBuild;
	settingIndex = 2;

	krayTempPath = ::tempDirectory + getsep() + "passEditorTempSceneKray.lws";
	::krayfile = File(krayTempPath, "w");
	sourceFile = File(::updatedCurrentScenePath, "r");
	if (kray_QuickLWF_PluginHeaderLine != nil)
	{
		copyLineNumber = 1;
		while(copyLineNumber <= kray_QuickLWF_PluginHeaderLine)
		{
			::krayfile.writeln(sourceFile.read());
			copyLineNumber++;
		}
	} else {
		masterHandlerCounter = 0;
		mHLine = 0;
		while(mHLine != nil)
		{
			if(masterHandlerCounter > 0)
			{
				mHLine_Prev = mHLine;
			}
			mHLine = getPartialLine(mHLine, 0, "MasterHandler", ::updatedCurrentScenePath);
			masterHandlerCounter++;
		}
		if(masterHandlerCounter == 0)
		{
			mHStartLine = getPartialLine(0, 0, "ChangeScene", ::updatedCurrentScenePath);
		} else {
			mHStartLine = mHLine_Prev;
		}

		copyLineNumber = 1;
		while(copyLineNumber <= mHStartLine)
		{
			::krayfile.writeln(sourceFile.read());
			copyLineNumber++;
		}
		::krayfile.writeln("Plugin MasterHandler " + string(masterHandlerCounter + 1) + " KrayQuickLWF");
		::krayfile.writeln("Script " + SCRIPTID.asStr());
	}

	::kray25_QuickLWF_settings = scnGen_kray25_QuickLWF_settings();
	scnGen_kray25_QuickLWF_general();
	scnGen_kray25_QuickLWF_script();

	if (kray_QuickLWF_PluginHeaderLine != nil)
	{
		sourceFile.line(kray_QuickLWF_PluginEndLine);
	} else {
		::krayfile.writeln("EndPlugin");
	}
	while(!sourceFile.eof())
	{
		::krayfile.writeln(sourceFile.read());
	}

	::krayfile.close();
	sourceFile.close();
	filecopy(krayTempPath,::newScenePath);
	filecopy(krayTempPath,::updatedCurrentScenePath); // avoid getting our source file clobbered in a later function.
	filedelete(krayTempPath);
}

scnGen_kray25_QuickLWF_general
{

	::krayfile.writeln(kray25_QuickLWF_default_version);    // version number
	::krayfile.writeln(int,104);

	kray25_QuickLWF_Index = 2;
	kray25_QuickLWF_v_tmo = ::kray25_QuickLWF_settings[kray25_QuickLWF_Index];
	::krayfile.writeln(kray25_PhySky_v_tmo);
	kray25_QuickLWF_Index++;
	kray25_QuickLWF_v_tmhsv = ::kray25_QuickLWF_settings[kray25_QuickLWF_Index];
	::krayfile.writeln(kray25_PhySky_v_tmhsv);
	kray25_QuickLWF_Index++;
	kray25_QuickLWF_v_outparam = ::kray25_QuickLWF_settings[kray25_QuickLWF_Index];
	::krayfile.writeln(kray25_PhySky_v_outparam);
	kray25_QuickLWF_Index++;
	kray25_QuickLWF_v_outexp = ::kray25_QuickLWF_settings[kray25_QuickLWF_Index];
	::krayfile.writeln(kray25_PhySky_v_outexp);
	kray25_QuickLWF_Index++;

	::krayfile.writeln(int,201);
	kray25_PhySky_v_affectbackdrop = ::kray25_QuickLWF_settings[kray25_QuickLWF_Index];
	::krayfile.writeln(kray25_PhySky_v_affectbackdrop);
	kray25_QuickLWF_Index++;

	::krayfile.writeln(int,301);
	kray25_PhySky_v_affecttextures = ::kray25_QuickLWF_settings[kray25_QuickLWF_Index];
	::krayfile.writeln(kray25_PhySky_v_affecttextures);
	kray25_QuickLWF_Index++;

	::krayfile.writeln(int,401);
	kray25_PhySky_v_affectlights = ::kray25_QuickLWF_settings[kray25_QuickLWF_Index];
	::krayfile.writeln(kray25_PhySky_v_affectlights);
	kray25_QuickLWF_Index++;

	::krayfile.writeln(int,501);
	kray25_PhySky_v_onFlag = ::kray25_QuickLWF_settings[kray25_QuickLWF_Index];
	::krayfile.writeln(kray25_PhySky_v_onFlag);
	kray25_QuickLWF_Index++;
	
	::krayfile.writeln(int,0);  // end hunk
}

scnGen_kray25_QuickLWF_script
{
	kray25_QuickLWF_Index = 2; // skip our tag
	kray25_QuickLWF_v_tmo = ::kray25_QuickLWF_settings[kray25_QuickLWF_Index];
	kray25_QuickLWF_Index++;
	kray25_QuickLWF_v_tmhsv = ::kray25_QuickLWF_settings[kray25_QuickLWF_Index];
	kray25_QuickLWF_Index++;
	kray25_QuickLWF_v_outparam = ::kray25_QuickLWF_settings[kray25_QuickLWF_Index];
	kray25_QuickLWF_Index++;
	kray25_QuickLWF_v_outexp = ::kray25_QuickLWF_settings[kray25_QuickLWF_Index];
	kray25_QuickLWF_Index++;
	kray25_QuickLWF_v_affectbackdrop = ::kray25_QuickLWF_settings[kray25_QuickLWF_Index];
	kray25_QuickLWF_Index++;
	kray25_QuickLWF_v_affecttextures = ::kray25_QuickLWF_settings[kray25_QuickLWF_Index];
	kray25_QuickLWF_Index++;
	kray25_QuickLWF_v_affectlights = ::kray25_QuickLWF_settings[kray25_QuickLWF_Index];
	kray25_QuickLWF_Index++;
	kray25_QuickLWF_v_onFlag = ::kray25_QuickLWF_settings[kray25_QuickLWF_Index];

	if (kray25_QuickLWF_v_onFlag)
	{	
		if (kray25_QuickLWF_v_affectbackdrop || kray25_QuickLWF_v_affecttextures || kray25_QuickLWF_v_affectlights)
		{
			::krayfile.writeln("KrayScriptLWSInlined -900;");
			::krayfile.writeln("echo '*** Kray quick LWF applied';");			

			kray25_QuickLWF_tm="inputtonemapper";
			
			switch(kray25_QuickLWF_v_tmo)
			{
				case 1:
					::krayfile.writeln(tm+" linear;");            
				break;
				case 2:
					if (v_tmhsv)
					{
						::krayfile.writeln(tm+" v_gamma_exposure,"+kray25_QuickLWF_v_outparam+","+kray25_QuickLWF_v_outexp+";");
					}else{
						::krayfile.writeln(tm+" gamma_exposure,"+kray25_QuickLWF_v_outparam+","+kray25_QuickLWF_v_outexp+";");
					}
				break;
				case 3:
					kray25_QuickLWF__v_outexp=kray25_QuickLWF_v_outexp;
					if (kray25_QuickLWF__v_outexp<1.00001)
					{
						kray25_QuickLWF__v_outexp=1.00001;
					}
					
					if (kray25_QuickLWF_v_tmhsv)
					{
						::krayfile.writeln(kray25_QuickLWF_tm+" v_exp_exposure,"+kray25_QuickLWF_v_outparam+","+kray25_QuickLWF__v_outexp+";");
					}else{
						::krayfile.writeln(kray25_QuickLWF_tm+" exp_exposure,"+kray25_QuickLWF_v_outparam+","+kray25_QuickLWF__v_outexp+";");
					}
				break;
			}
			
			if (kray25_QuickLWF_v_affectlights)
			{
				::krayfile.writeln("lwtonemaplights 1;");
			}

			krayfile.writeln("end;");     

			if (kray25_QuickLWF_v_affecttextures)
			{
				::krayfile.writeln("KrayScriptLWSInlined -1900;");
				::krayfile.writeln("var __importflags,__importflags|16;");
				::krayfile.writeln("end;");     
			}

			if (kray25_QuickLWF_v_affectbackdrop)
			{
				::krayfile.writeln("KrayScriptLWSInlined 1100;");
				::krayfile.writeln("background tone_map;");
				::krayfile.writeln("end;");     
			}
		}
	}
}

scnGen_kray25_QuickLWF_Values
{
	valTmpStr = string(::kray25_QuickLWF_settings[1]);
	for (k = 2; k <= ::kray25_QuickLWF_settings.size(); k++)
	{
		valTmpStr = valTmpStr + "||" + string(::kray25_QuickLWF_settings[k]);
	}
	return valTmpStr;
}

scnGen_kray25_QuickLWF_settings
{
	for (k = 1; k <= ::kray25_QuickLWF_settings_default.size(); k++)
	{
		::kray25_QuickLWF_settings[k] = ::settingsArray[::krayPluginSettingIndexHandler];
		::krayPluginSettingIndexHandler++;
	}
}

scnGen_kray25_QuickLWF_defaultsettings
{
	tempIndex = 1;
	::kray25_QuickLWF_settings[tempIndex] = string(kray25_QuickLWF_pluginTagString);
	tempIndex++;
	::kray25_QuickLWF_settings[tempIndex] = string(kray25_QuickLWF_default_v_tmo);
	tempIndex++;
	::kray25_QuickLWF_settings[tempIndex] = string(kray25_QuickLWF_default_v_tmhsv);
	tempIndex++;
	::kray25_QuickLWF_settings[tempIndex] = string(kray25_QuickLWF_default_v_outparam);
	tempIndex++;
	::kray25_QuickLWF_settings[tempIndex] = string(kray25_QuickLWF_default_v_outexp);
	tempIndex++;
	::kray25_QuickLWF_settings[tempIndex] = string(kray25_QuickLWF_default_v_affectbackdrop);
	tempIndex++;
	::kray25_QuickLWF_settings[tempIndex] = string(kray25_QuickLWF_default_v_affecttextures);
	tempIndex++;
	::kray25_QuickLWF_settings[tempIndex] = string(kray25_QuickLWF_default_v_affectlights);
	tempIndex++;
	::kray25_QuickLWF_settings[tempIndex] = string(kray25_QuickLWF_default_v_onFlag);
}

