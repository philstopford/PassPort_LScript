// kray2.5 quickLWF globals
@insert "@kray/passEditor_Kray25QuickLWF_Support_Vars.ls"
@insert "@kray/passEditor_Kray25QuickLWF_Support_UI.ls"

scnGen_kray25_QuickLWF
{
    // Kray, happily, has all of its settings in the scene file so all we need to do now is to find the header line and then use hard-coded offsets to the data we care about. There are no line markers, so hard-coding is the only option.
    // It's bloating this code somewhat, but for flexibility, we'll abstract our line references with variables to make this maintainable in future.

    kray_QuickLWF_PluginHeaderLine = getMasterPluginLine("KrayQuickLWF"); // Should pick up MasterHandler for Kray
    // logger("log_info",""kray at " + kray_QuickLWF_PluginHeaderLine.asStr());

    // Startup checks to ensure we're working against a known quantity.
    if (kray_QuickLWF_PluginHeaderLine == nil)
    {
        logger("info","scnGen_kray25_QuickLWF: Kray 2.5 QuickLWF plugin not found. Guessing....");
        kray_QuickLWF_pluginBuild = default_kray_QuickLWF_pluginBuild;
        kray_QuickLWF_sectionTag = default_kray_QuickLWF_sectionTag;
    } else {
        readIndex = kray_QuickLWF_PluginHeaderLine + 3; // offset for the plugin header, the LSC script reference and the Kray encapsulator
        kray_QuickLWF_pluginBuild = int(::readBuffer[readIndex]);
        readIndex++;
        kray_QuickLWF_sectionTag = int(::readBuffer[readIndex]);
        readIndex++;
        kray_QuickLWF_PluginEndLine = getPartialLine(kray_QuickLWF_PluginHeaderLine,0,"EndPlugin");
        // Check known version of Kray in case of mismatch
        if((kray_QuickLWF_pluginBuild != default_kray_QuickLWF_pluginBuild) || (kray_QuickLWF_sectionTag != default_kray_QuickLWF_sectionTag))
        {
            logger("error","scnGen_kray25_QuickLWF: Kray QuickLWF version or section tag mismatch: " + kray_QuickLWF_pluginBuild.asStr() + "/" + kray_QuickLWF_sectionTag.asStr());
        }
    }

    // Kray writes out according to its functions :
    //      ::krayfile.writeln("Kray{");
    //      save_general(io);
    //      save_krayscript_file(io,"");
    //      ::krayfile.writeln("}");

    // Start values for the huge chunk of settings.
    // krayLineNumber = kray_QuickLWF_pluginBuild;
    settingIndex = 2;

    if (kray_QuickLWF_PluginHeaderLine != nil)
    {
        readIndex = 1;
        while(readIndex <= kray_QuickLWF_PluginHeaderLine)
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
        ::writeBuffer[size(::writeBuffer) + 1] = "Plugin MasterHandler " + string(masterHandlerCounter + 1) + " KrayQuickLWF";
        ::writeBuffer[size(::writeBuffer) + 1] = "Script " + SCRIPTID.asStr();
    }

    ::kray25_QuickLWF_settings = scnGen_kray25_QuickLWF_settings();
    scnGen_kray25_QuickLWF_general();
    scnGen_kray25_QuickLWF_script();

    if (kray_QuickLWF_PluginHeaderLine != nil)
    {
        sourceFile.line(kray_QuickLWF_PluginEndLine);
    } else {
        ::writeBuffer[size(::writeBuffer) + 1] = "EndPlugin";
    }
    while(readIndex <= size(::readBuffer))
    {
        ::writeBuffer[size(::writeBuffer) + 1] = ::readBuffer[readIndex];
        readIndex++;
    }
}

scnGen_kray25_QuickLWF_general
{
    ::writeBuffer[size(::writeBuffer) + 1] = kray25_QuickLWF_default_version;    // version number
    ::writeBuffer[size(::writeBuffer) + 1] = 104;

    kray25_QuickLWF_Index = 2;
    kray25_QuickLWF_v_tmo = ::kray25_QuickLWF_settings[kray25_QuickLWF_Index];
    ::writeBuffer[size(::writeBuffer) + 1] = kray25_PhySky_v_tmo;
    kray25_QuickLWF_Index++;
    kray25_QuickLWF_v_tmhsv = ::kray25_QuickLWF_settings[kray25_QuickLWF_Index];
    ::writeBuffer[size(::writeBuffer) + 1] = kray25_PhySky_v_tmhsv;
    kray25_QuickLWF_Index++;
    kray25_QuickLWF_v_outparam = ::kray25_QuickLWF_settings[kray25_QuickLWF_Index];
    ::writeBuffer[size(::writeBuffer) + 1] = kray25_PhySky_v_outparam;
    kray25_QuickLWF_Index++;
    kray25_QuickLWF_v_outexp = ::kray25_QuickLWF_settings[kray25_QuickLWF_Index];
    ::writeBuffer[size(::writeBuffer) + 1] = kray25_PhySky_v_outexp;
    kray25_QuickLWF_Index++;

    ::writeBuffer[size(::writeBuffer) + 1] = 201;
    kray25_PhySky_v_affectbackdrop = ::kray25_QuickLWF_settings[kray25_QuickLWF_Index];
    ::writeBuffer[size(::writeBuffer) + 1] = kray25_PhySky_v_affectbackdrop;
    kray25_QuickLWF_Index++;

    ::writeBuffer[size(::writeBuffer) + 1] = 301;
    kray25_PhySky_v_affecttextures = ::kray25_QuickLWF_settings[kray25_QuickLWF_Index];
    ::writeBuffer[size(::writeBuffer) + 1] = kray25_PhySky_v_affecttextures;
    kray25_QuickLWF_Index++;

    ::writeBuffer[size(::writeBuffer) + 1] = 401;
    kray25_PhySky_v_affectlights = ::kray25_QuickLWF_settings[kray25_QuickLWF_Index];
    ::writeBuffer[size(::writeBuffer) + 1] = kray25_PhySky_v_affectlights;
    kray25_QuickLWF_Index++;

    ::writeBuffer[size(::writeBuffer) + 1] = 501;
    kray25_PhySky_v_onFlag = ::kray25_QuickLWF_settings[kray25_QuickLWF_Index];
    ::writeBuffer[size(::writeBuffer) + 1] = kray25_PhySky_v_onFlag;
    kray25_QuickLWF_Index++;
    
    ::writeBuffer[size(::writeBuffer) + 1] = 0;  // end hunk
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
            ::writeBuffer[size(::writeBuffer) + 1] = "KrayScriptLWSInlined -900;";
            ::writeBuffer[size(::writeBuffer) + 1] = "echo '*** Kray quick LWF applied';";

            kray25_QuickLWF_tm="inputtonemapper";
            
            switch(kray25_QuickLWF_v_tmo)
            {
                case 1:
                    ::writeBuffer[size(::writeBuffer) + 1] = tm+" linear;";
                break;
                case 2:
                    if (v_tmhsv)
                    {
                        ::writeBuffer[size(::writeBuffer) + 1] = kray25_QuickLWF_tm+" v_gamma_exposure,"+kray25_QuickLWF_v_outparam+","+kray25_QuickLWF_v_outexp+";";
                    }else{
                        ::writeBuffer[size(::writeBuffer) + 1] = kray25_QuickLWF_tm+" gamma_exposure,"+kray25_QuickLWF_v_outparam+","+kray25_QuickLWF_v_outexp+";";
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
                        ::writeBuffer[size(::writeBuffer) + 1] = kray25_QuickLWF_tm+" v_exp_exposure,"+kray25_QuickLWF_v_outparam+","+kray25_QuickLWF__v_outexp+";";
                    }else{
                        ::writeBuffer[size(::writeBuffer) + 1] = kray25_QuickLWF_tm+" exp_exposure,"+kray25_QuickLWF_v_outparam+","+kray25_QuickLWF__v_outexp+";";
                    }
                break;
            }
            
            if (kray25_QuickLWF_v_affectlights)
            {
                ::writeBuffer[size(::writeBuffer) + 1] = "lwtonemaplights 1;";
            }

            ::writeBuffer[size(::writeBuffer) + 1] = "end;";

            if (kray25_QuickLWF_v_affecttextures)
            {
                ::writeBuffer[size(::writeBuffer) + 1] = "KrayScriptLWSInlined -1900;";
                ::writeBuffer[size(::writeBuffer) + 1] = "var __importflags,__importflags|16;";
                ::writeBuffer[size(::writeBuffer) + 1] = "end;";
            }

            if (kray25_QuickLWF_v_affectbackdrop)
            {
                ::writeBuffer[size(::writeBuffer) + 1] = "KrayScriptLWSInlined 1100;";
                ::writeBuffer[size(::writeBuffer) + 1] = "background tone_map;";
                ::writeBuffer[size(::writeBuffer) + 1] = "end;";
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

