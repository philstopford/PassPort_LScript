// kray2.5 ToneMap globals
@insert "@kray/passEditor_Kray25ToneMap_Support_Vars.ls"
@insert "@kray/passEditor_Kray25ToneMap_Support_CustomFuncs.ls"
@insert "@kray/passEditor_Kray25ToneMap_Support_UI.ls"

scnGen_kray25_ToneMap
{
	// Need to check whether we actually need to process anything - we're a plugin and thus optional.
	// kray25_ToneMap_Index = ::settingsArray.indexOf(kray25_ToneMap_pluginTagString);
	// if (kray25_ToneMap_Index == 0) // Not found, nothing to do.
	//	return;

	// Kray, happily, has all of its settings in the scene file so all we need to do now is to find the header line and then use hard-coded offsets to the data we care about. There are no line markers, so hard-coding is the only option.
	// It's bloating this code somewhat, but for flexibility, we'll abstract our line references with variables to make this maintainable in future.

	kray_ToneMap_PluginHeaderLine = getMasterPluginLine("KrayTonemapBlending"); // Should pick up MasterHandler for Kray

	// Startup checks to ensure we're working against a known quantity.
    if (kray_ToneMap_PluginHeaderLine == nil)
    {
		logger("info","scnGen_kray25_ToneMap: Kray 2.5 ToneMap plugin not found. Guessing....");
		kray_ToneMap_pluginBuild = default_kray_ToneMap_pluginBuild;
		kray_ToneMap_sectionTag = default_kray_ToneMap_sectionTag;
	} else {
		searchString = "Plugin MasterHandler";
		readIndex = kray_ToneMap_PluginHeaderLine + 3; // offset for the plugin header, the LSC script reference and the Kray encapsulator
		kray_ToneMap_pluginBuild = int(::readBuffer[readIndex]);
		readIndex++;
		kray_ToneMap_sectionTag = int(::readBuffer[readIndex]);
		readIndex++;
		kray_ToneMap_PluginEndLine = getPartialLine(kray_ToneMap_PluginHeaderLine,0,"EndPlugin");
		// Check known version of Kray in case of mismatch
		if((kray_ToneMap_pluginBuild != default_kray_ToneMap_pluginBuild) || (kray_ToneMap_sectionTag != default_kray_ToneMap_sectionTag))
		{
			logger("error","scnGen_kray25_ToneMap: Kray ToneMap version or section tag mismatch: " + kray_ToneMap_pluginBuild.asStr() + "/" + kray_ToneMap_sectionTag.asStr());
		}
	}

	// Kray writes out according to its functions :
	//		::krayfile.writeln("Kray{");
	//		save_general(io);
	//		save_krayscript_file(io,"");
	//		::krayfile.writeln("}");

	// Start values for the huge chunk of settings.
	// krayLineNumber = kray_ToneMap_pluginBuild;
	settingIndex = 2;

	if (kray_ToneMap_PluginHeaderLine != nil)
	{
		readIndex = 1;
		while(readIndex <= kray_ToneMap_PluginHeaderLine)
		{
			::writeBuffer[size(::writeBuffer) + 1] = ::readBuffer[readIndex];
			readIndex++;
		}
	} else {
        mHStartLine = getPartialLine_last(0, 0, "MasterHandler");
        if(mHStartLine != nil)
        {
            tempArray = parse(" ", mHStartLine);
            masterHandlerCounter = int(tempArray[3]);
            mHStartLine = getPartialLine(mHStartLine,0, "EndPlugin");
        } else {
            masterHandlerCounter = 0;
            mHStartLine = getPartialLine(0, 0, "ChangeScene");
        }

		readIndex = 1;
		while(readIndex <= mHStartLine)
		{
			::writeBuffer[size(::writeBuffer) + 1] = ::readBuffer[readIndex];
			readIndex++;
		}
		::writeBuffer[size(::writeBuffer) + 1] = "Plugin MasterHandler " + string(masterHandlerCounter + 1) + " KrayTonemapBlending";
		::writeBuffer[size(::writeBuffer) + 1] = "Script " + SCRIPTID.asStr();
	}

	::kray25_ToneMap_settings = scnGen_kray25_ToneMap_settings();
	scnGen_kray25_ToneMap_general();
	scnGen_kray25_ToneMap_script();

	if (kray_ToneMap_PluginHeaderLine != nil)
	{
		readIndex = kray_ToneMap_PluginEndLine;
	} else {
		::writeBuffer[size(::writeBuffer) + 1] = "EndPlugin";
	}
	while(readIndex <= size(::readBuffer))
	{
		::writeBuffer[size(::writeBuffer) + 1] = ::readBuffer[readIndex];
		readIndex++;
	}
}

scnGen_kray25_ToneMap_general
{
	::writeBuffer[size(::writeBuffer) + 1] = kray25_ToneMap_default_version;    // version number
	::writeBuffer[size(::writeBuffer) + 1] = 104;

	kray25_ToneMap_Index = 2;
	kray25_ToneMap_v_1st_tmo = ::kray25_ToneMap_settings[kray25_ToneMap_Index];
	::writeBuffer[size(::writeBuffer) + 1] = kray25_ToneMap_v_1st_tmo;
	kray25_ToneMap_Index++;
	kray25_ToneMap_v_1st_tmhsv = ::kray25_ToneMap_settings[kray25_ToneMap_Index];
	::writeBuffer[size(::writeBuffer) + 1] = kray25_ToneMap_v_1st_tmhsv;
	kray25_ToneMap_Index++;
	kray25_ToneMap_v_1st_outparam = ::kray25_ToneMap_settings[kray25_ToneMap_Index];
	::writeBuffer[size(::writeBuffer) + 1] = kray25_ToneMap_v_1st_outparam;
	kray25_ToneMap_Index++;
	kray25_ToneMap_v_1st_outexp = ::kray25_ToneMap_settings[kray25_ToneMap_Index];
	::writeBuffer[size(::writeBuffer) + 1] = kray25_ToneMap_v_1st_outexp;

	kray25_ToneMap_Index++;
	kray25_ToneMap_v_2nd_tmo = ::kray25_ToneMap_settings[kray25_ToneMap_Index];
	::writeBuffer[size(::writeBuffer) + 1] = kray25_ToneMap_v_2nd_tmo;
	kray25_ToneMap_Index++;
	kray25_ToneMap_v_2nd_tmhsv = ::kray25_ToneMap_settings[kray25_ToneMap_Index];
	::writeBuffer[size(::writeBuffer) + 1] = kray25_ToneMap_v_2nd_tmhsv;
	kray25_ToneMap_Index++;
	kray25_ToneMap_v_2nd_outparam = ::kray25_ToneMap_settings[kray25_ToneMap_Index];
	::writeBuffer[size(::writeBuffer) + 1] = kray25_ToneMap_v_2nd_outparam;
	kray25_ToneMap_Index++;
	kray25_ToneMap_v_2nd_outexp = ::kray25_ToneMap_settings[kray25_ToneMap_Index];
	::writeBuffer[size(::writeBuffer) + 1] = kray25_ToneMap_v_2nd_outexp;

	kray25_ToneMap_Index++;
	kray25_ToneMap_blending = ::kray25_ToneMap_settings[kray25_ToneMap_Index];

	::writeBuffer[size(::writeBuffer) + 1] = 201;
	kray25_ToneMap_Index++;
	kray25_ToneMap_v_onFlag = ::kray25_ToneMap_settings[kray25_ToneMap_Index];
	::writeBuffer[size(::writeBuffer) + 1] = kray25_ToneMap_v_onFlag;
	
	::writeBuffer[size(::writeBuffer) + 1] = 0;  // end hunk
}

scnGen_kray25_ToneMap_script
{
	kray25_ToneMap_SettingIndex = 2; // skip our tag
	kray25_ToneMap_v_1st_tmo = ::kray25_ToneMap_settings[kray25_ToneMap_Index];
	kray25_ToneMap_Index++;
	kray25_ToneMap_v_1st_tmhsv = ::kray25_ToneMap_settings[kray25_ToneMap_Index];
	kray25_ToneMap_Index++;
	kray25_ToneMap_v_1st_outparam = ::kray25_ToneMap_settings[kray25_ToneMap_Index];
	kray25_ToneMap_Index++;
	kray25_ToneMap_v_1st_outexp = ::kray25_ToneMap_settings[kray25_ToneMap_Index];
	kray25_ToneMap_Index++;
	kray25_ToneMap_v_2nd_tmo = ::kray25_ToneMap_settings[kray25_ToneMap_Index];
	kray25_ToneMap_Index++;
	kray25_ToneMap_v_2nd_tmhsv = ::kray25_ToneMap_settings[kray25_ToneMap_Index];
	kray25_ToneMap_Index++;
	kray25_ToneMap_v_2nd_outparam = ::kray25_ToneMap_settings[kray25_ToneMap_Index];
	kray25_ToneMap_Index++;
	kray25_ToneMap_v_2nd_outexp = ::kray25_ToneMap_settings[kray25_ToneMap_Index];
	kray25_ToneMap_Index++;
	kray25_ToneMap_blending = ::kray25_ToneMap_settings[kray25_ToneMap_Index];
	kray25_ToneMap_Index++;
	kray25_ToneMap_v_onFlag = ::kray25_ToneMap_settings[kray25_ToneMap_Index];

	if (kray25_ToneMap_v_onFlag){
		::writeBuffer[size(::writeBuffer) + 1] = "KrayScriptLWSInlined 200;";
		kray25_ToneMap_tm="tonemapdefine";
			switch(kray25_ToneMap_v_1st_tmo)
			{
				case 1:
					::writeBuffer[size(::writeBuffer) + 1] = kray25_ToneMap_tm+" t1,linear;";
				break;
				case 2:
					if (kray25_ToneMap_v_1st_tmhsv)
					{
						::writeBuffer[size(::writeBuffer) + 1] = kray25_ToneMap_tm+" t1,v_gamma_exposure,"+kray25_ToneMap_v_1st_outparam+","+kray25_ToneMap_v_1st_outexp+";";
					}else{
						::writeBuffer[size(::writeBuffer) + 1] = kray25_ToneMap_tm+" t1,gamma_exposure,"+kray25_ToneMap_v_1st_outparam+","+kray25_ToneMap_v_1st_outexp+";";
					}
				break;
				case 3:
					if (kray25_ToneMap_v_1st_tmhsv)
					{
						::writeBuffer[size(::writeBuffer) + 1] = kray25_ToneMap_tm+" t1,v_exp_exposure,"+kray25_ToneMap_v_1st_outparam+","+kray25_ToneMap_v_1st_outexp+";";
					}else{
						::writeBuffer[size(::writeBuffer) + 1] = kray25_ToneMap_tm+" t1,exp_exposure,"+kray25_ToneMap_v_1st_outparam+","+kray25_ToneMap_v_1st_outexp+";";
					}
				break;
			}
			switch(kray25_ToneMap_v_2nd_tmo)
			{
				case 1:
					::writeBuffer[size(::writeBuffer) + 1] = kray25_ToneMap_tm+" t2,linear;";
				break;
				case 2:
					if (kray25_ToneMap_v_2nd_tmhsv)
					{
						::writeBuffer[size(::writeBuffer) + 1] = kray25_ToneMap_tm+" t2,v_gamma_exposure,"+kray25_ToneMap_v_2nd_outparam+","+kray25_ToneMap_v_2nd_outexp+";";
					}else{
						::writeBuffer[size(::writeBuffer) + 1] = kray25_ToneMap_tm+" t2,gamma_exposure,"+kray25_ToneMap_v_2nd_outparam+","+kray25_ToneMap_v_2nd_outexp+";";
					}
				break;
				case 3:
					if (kray25_ToneMap_v_2nd_tmhsv)
					{
						::writeBuffer[size(::writeBuffer) + 1] = kray25_ToneMap_tm+" t2,v_exp_exposure,"+kray25_ToneMap_v_2nd_outparam+","+kray25_ToneMap_v_2nd_outexp+";";
					}else{
						::writeBuffer[size(::writeBuffer) + 1] = kray25_ToneMap_tm+" t2,exp_exposure,"+kray25_ToneMap_v_2nd_outparam+","+kray25_ToneMap_v_2nd_outexp+";";
					}
				break;
			}
		::writeBuffer[size(::writeBuffer) + 1] = "tonemapper blend,"+kray25_ToneMap_blending+",t1,t2;";
		::writeBuffer[size(::writeBuffer) + 1] = "echo '*** Applying Tonemapper blending: "+kray25_ToneMap_blending+" tonemappers: "+kray25_ToneMap_v_1st_tmo+"/"+kray25_ToneMap_v_2nd_tmo+"';";

		::writeBuffer[size(::writeBuffer) + 1] = "end;";
	}
}

scnGen_kray25_ToneMap_Values
{
	valTmpStr = string(::kray25_ToneMap_settings[1]);
	for (k = 2; k <= ::kray25_ToneMap_settings.size(); k++)
	{
		valTmpStr = valTmpStr + "||" + string(::kray25_ToneMap_settings[k]);
	}
	return valTmpStr;
}

scnGen_kray25_ToneMap_settings
{
	for (k = 1; k <= ::kray25_ToneMap_settings_default.size(); k++)
	{
		::kray25_ToneMap_settings[k] = ::settingsArray[::krayPluginSettingIndexHandler];
		::krayPluginSettingIndexHandler++;
	}
}

scnGen_kray25_ToneMap_defaultsettings
{
	tempIndex = 1;
	::kray25_ToneMap_settings[tempIndex] = string(kray25_ToneMap_pluginTagString);
	tempIndex++;
	::kray25_ToneMap_settings[tempIndex] = string(kray25_ToneMap_default_v_1st_tmo);
	tempIndex++;
	::kray25_ToneMap_settings[tempIndex] = string(kray25_ToneMap_default_v_1st_tmhsv);
	tempIndex++;
	::kray25_ToneMap_settings[tempIndex] = string(kray25_ToneMap_default_v_1st_outparam);
	tempIndex++;
	::kray25_ToneMap_settings[tempIndex] = string(kray25_ToneMap_default_v_1st_outexp);
	tempIndex++;
	::kray25_ToneMap_settings[tempIndex] = string(kray25_ToneMap_default_v_2nd_tmo);
	tempIndex++;
	::kray25_ToneMap_settings[tempIndex] = string(kray25_ToneMap_default_v_2nd_tmhsv);
	tempIndex++;
	::kray25_ToneMap_settings[tempIndex] = string(kray25_ToneMap_default_v_2nd_outparam);
	tempIndex++;
	::kray25_ToneMap_settings[tempIndex] = string(kray25_ToneMap_default_v_2nd_outexp);
	tempIndex++;
	::kray25_ToneMap_settings[tempIndex] = string(kray25_ToneMap_default_blending);
	tempIndex++;
	::kray25_ToneMap_settings[tempIndex] = string(kray25_ToneMap_default_v_onFlag);
}
