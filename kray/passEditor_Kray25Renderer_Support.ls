// kray2.5 renderer globals
@insert "@kray/passEditor_Kray25Renderer_Support_Vars.ls"
@insert "@kray/passEditor_Kray25Renderer_Support_CustomFuncs.ls"
@insert "@kray/passEditor_Kray25Renderer_Support_Presets.ls"
@insert "@kray/passEditor_Kray25Renderer_Support_UI.ls"

// Plugins
@if Kray_PS
@insert "@kray/passEditor_Kray25PhysicalSky_Support.ls"
@end
@if Kray_QuickLWF
@insert "@kray/passEditor_Kray25QuickLWF_Support.ls"
@end
@if Kray_ToneMap
@insert "@kray/passEditor_Kray25ToneMap_Support.ls"
@end

// scnMaster override UI stuff
activeCameraName; // for Kray script function. Value set in UI.

scnGen_kray25
{
    default_krayLSCBuild = 1223;    
    default_krayBuild = 3605;
    // Kray, happily, has all of its settings in the scene file so all we need to do now is to find the header line and then use hard-coded offsets to the data we care about. There are no line markers, so hard-coding is the only option.
    // It's bloating this code somewhat, but for flexibility, we'll abstract our line references with variables to make this maintainable in future.

    krayHeaderLine = getMasterPluginLine("Kray"); // Should pick up MasterHandler for Kray

    // Startup checks to ensure we're working against a known quantity.
    if (krayHeaderLine == nil)
    {
        logger("info","scnGen_kray25: Kray 2.5 master plugin not found. Guessing....");
        krayLSCBuild = default_krayLSCBuild;
        krayBuild = default_krayBuild;
    } else {
        searchString = "Plugin MasterHandler";
        readIndex = krayHeaderLine; // offset for the plugin header, the LSC script reference and the Kray encapsulator
        krayLSCBuild = int(::readBuffer[readIndex]);
        readIndex++;
        krayBuild = int(::readBuffer[readIndex]);
        readIndex++;
        krayPluginEndLine = getPartialLine(krayHeaderLine,0,"EndPlugin");
        // Check known version of Kray in case of mismatch
        if((krayLSCBuild != default_krayLSCBuild) || (krayBuild != default_krayBuild))
        {
            logger("error","scnGen_kray25: Kray master plugin or engine version mismatch: " + krayLSCBuild.asStr() + "/" + krayBuild.asStr());
        }
    }

    // Generic stuff from the native renderer function.
    redirectBuffersSetts = int(::settingsArray[size(::settingsArray)]);

    activeCameraID = int(::settingsArray[size(::settingsArray) - 1]);
    // logger("log_info","scnGen_kray25: activeCameraID: " + activeCameraID.asStr());

    if(activeCameraID == 0)
    {
        activeCamera = 0; // first camera in scene file, matching default behaviour for no cameras in pass.
        passCamNameArray[1] = ::cameraNames[1];
        passCamIDArray[1] = ::cameraIDs[1];
    } else {
        passCamNameArray = nil;
        passCamIDArray = nil;

        passItemsIDsArray = parse("||",::passAssItems[::currentChosenPass]);
        passCamArrayIndex = 1;
        for (i = 1; i <= passItemsIDsArray.size(); i++)
        {
            for (j = 1; j <= ::cameraIDs.size(); j++)
            {
                if(passItemsIDsArray[i] == ::cameraIDs[j])
                {
                    passCamIDArray[passCamArrayIndex] = passItemsIDsArray[i];
                    // Name look-up
                    for(k = 1; k <= ::displayIDs.size(); k++)
                    {
                        if(::displayIDs[k] == passItemsIDsArray[i])
                        {
                            passCamNameArray[passCamArrayIndex] = ::displayNames[k];
                            passCamArrayIndex++;
                        }
                    }
                }
            }
        }

        activeCamera = 0;
        for(i = 1; i <= passCamIDArray.size(); i++)
        {
            if(passCamIDArray[i] == activeCameraID)
            {
                activeCamera = i - 1;
                logger("info","scnGen_kray25: Found match for camera: " + activeCamera.asStr());
            }
        }
    }


    if(passCamNameArray == nil)
    {
        logger("error","scnGen_kray25: Something went wrong with the camera handling!");
    } else {
        activeCameraName = passCamNameArray[activeCamera + 1];
    }

    // We need to do both of these - the first because we will later overwrite this field because it's parked at the end of the file and gets re-written
    // from the source file very late in the scene generation process.
    writeOverrideString("CurrentCamera ", activeCamera);

    // Kray writes out according to its functions :
    //      ::krayfile.writeln("Kray{");
    //      save_general(io);
    //      save_accuracy(io);
    //      if (!create_flag){
    //          save_krayscript_file(io,"");
    //      }
    //      ::krayfile.writeln("}");

    // Start values for the huge chunk of settings.
    // krayLineNumber = krayBuild;
    settingIndex = 2;

    if (krayHeaderLine != nil)
    {
        readIndex = 1;
        while(readIndex <= krayHeaderLine)
        {
            ::writeBuffer[readIndex] = ::readBuffer[readIndex];
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
            ::writeBuffer[readIndex] = ::readBuffer[readIndex];
            readIndex++;
        }

        ::writeBuffer[size(::writeBuffer) + 1] = "Plugin MasterHandler " + string(masterHandlerCounter + 1) + " Kray";
        ::writeBuffer[size(::writeBuffer) + 1] = "Script " + getKrayScriptPath().asStr();
    }
    ::writeBuffer[size(::writeBuffer) + 1] = "Kray{";

    scnGen_kray25_general();
    scnGen_kray25_accuracy();
    scnGen_kray25_script();
    ::writeBuffer[size(::writeBuffer) + 1] = "}";

    if (krayHeaderLine != nil)
    {
        readIndex = krayPluginEndLine;
    } else {
        readIndex = mHStartLine + 1;
        ::writeBuffer[size(::writeBuffer) + 1]  = "EndPlugin";
    }

    while(readIndex <= size(::readBuffer))
    {
        ::writeBuffer[size(::writeBuffer)+1] = ::readBuffer[readIndex];
        readIndex++;
    }

    ::readBuffer = ::writeBuffer;
    ::writeBuffer = nil;

//    scnGen_kray25_plugins();

    addKrayRenderer();
}

scnGen_kray25_plugins
{
    // Each called function must align new and current scene paths.
@if Kray_PS
    scnGen_kray25_physky();
@end
@if Kray_QuickLWF
    scnGen_kray25_QuickLWF();
@end
@if Kray_ToneMap
    scnGen_kray25_ToneMap();
@end
}

scnGen_kray25_general
{
    ::writeBuffer[size(::writeBuffer)+1] = version;

    if (!create_flag)
    {  // not inited, do not save settings
        ::writeBuffer[size(::writeBuffer)+1] = 3605;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_gph_preset;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_cph_preset;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_fg_preset;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_aa_preset;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_quality_preset;
        
        ::writeBuffer[size(::writeBuffer)+1] = 104;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_gi;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_gicaustics;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_giirrgrad;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_gipmmode;

        ::writeBuffer[size(::writeBuffer)+1] = 2301;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_girtdirect;

        ::writeBuffer[size(::writeBuffer)+1] = 201;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_lg;
        
        ::writeBuffer[size(::writeBuffer)+1] = 301;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_pl;

        mlsize=size(kray25_v_outname);
        if (mlsize==0)
        {
            ::writeBuffer[size(::writeBuffer)+1] = 3501;
            ::writeBuffer[size(::writeBuffer)+1] = "";
        } else {
            for (a=1 ; a<=mlsize ; a += ::maxlinelength)
            {
                t = a + ::maxlinelength;
                if (t>(mlsize+1))
                {
                    t=mlsize+1;
                }
                t=-a+t;
                ::writeBuffer[size(::writeBuffer)+1] = 3501;
                ::writeBuffer[size(::writeBuffer)+1] = strsub(kray25_v_outname,a,t);
            }
        }

        ::writeBuffer[size(::writeBuffer)+1] = 602;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_prep;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_pxlordr;

        ::writeBuffer[size(::writeBuffer)+1] = 702;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_underf;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_undert;

        ::writeBuffer[size(::writeBuffer)+1] = 802;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_areavis;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_areaside;

        // lights & camera

        ::writeBuffer[size(::writeBuffer)+1] = 1003;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_planth;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_planrmin;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_planrmax;

        ::writeBuffer[size(::writeBuffer)+1] = 2103;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_llinth;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_llinrmin;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_llinrmax;

        ::writeBuffer[size(::writeBuffer)+1] = 1103;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_lumith;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_lumirmin;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_lumirmax;

        ::writeBuffer[size(::writeBuffer)+1] = 2402;
        if(kray25_v_camobject == "__PPRN__BLANK__ENTRY__")
        {
            ::writeBuffer[size(::writeBuffer)+1] = "";
        } else {
            ::writeBuffer[size(::writeBuffer)+1] = kray25_v_camobject;
        }
        if(kray25_v_camuvname == "__PPRN__BLANK__ENTRY__")
        {
            ::writeBuffer[size(::writeBuffer)+1] = "";
        } else {
            ::writeBuffer[size(::writeBuffer)+1] = kray25_v_camuvname;
        }

        ::writeBuffer[size(::writeBuffer)+1] = 1301;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_cptype;

        mlsize=size(kray25_v_lenspict);
        if (mlsize==0)
        {
            ::writeBuffer[size(::writeBuffer)+1] = 1401;
            ::writeBuffer[size(::writeBuffer)+1] = "";
        } else {
            for (a=1 ; a<=mlsize ; a+=::maxlinelength)
            {
                t=a+::maxlinelength;
                if (t>(mlsize+1))
                {
                    t=mlsize+1;
                }
                t=-a+t;
                ::writeBuffer[size(::writeBuffer)+1] = 1401;
                ::writeBuffer[size(::writeBuffer)+1] = strsub(kray25_v_lenspict,a,t);
            }
        }
        
        ::writeBuffer[size(::writeBuffer)+1] = 1501;
        if(kray25_v_dofobj == "__PPRN__BLANK__ENTRY__")
        {
            ::writeBuffer[size(::writeBuffer)+1] = "";
        } else {
            ::writeBuffer[size(::writeBuffer)+1] = kray25_v_dofobj;
        }

        ::writeBuffer[size(::writeBuffer)+1] = 1603;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_cstocvar;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_cstocmin;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_cstocmax;

        ::writeBuffer[size(::writeBuffer)+1] = 1804;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_aatype;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_aafscreen;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_aargsmpl;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_aagridrotate;

        ::writeBuffer[size(::writeBuffer)+1] = 1903;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_refth;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_refrmin;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_refrmax;

        mlsize=size(kray25_v_prescript);
        if (mlsize==0)
        {
            ::writeBuffer[size(::writeBuffer)+1] = 3301;
            ::writeBuffer[size(::writeBuffer)+1] = "";
        } else {
            for (a=1 ; a<=mlsize ; a+=::maxlinelength)
            {
                t=a+::maxlinelength;
                if (t>(mlsize+1))
                {
                    t=mlsize+1;
                }
                t=-a+t;
                ::writeBuffer[size(::writeBuffer)+1] = 3301;
                ::writeBuffer[size(::writeBuffer)+1] = strsub(kray25_v_prescript,a,t);
            }
        }
        
        mlsize=size(kray25_v_postscript);
        if (mlsize==0)
        {
            ::writeBuffer[size(::writeBuffer)+1] = 3401;
            ::writeBuffer[size(::writeBuffer)+1] = "";
        } else {
            for (a=1 ; a<=mlsize ; a+=::maxlinelength)
            {
                t=a+::maxlinelength;
                if (t>(mlsize+1))
                {
                    t=mlsize+1;
                }
                t=-a+t;
                ::writeBuffer[size(::writeBuffer)+1] = 3401;
                ::writeBuffer[size(::writeBuffer)+1] = strsub(kray25_v_postscript,a,t);
            }
        }
        
        ::writeBuffer[size(::writeBuffer)+1] = 2101;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_autolumi;

        //ovr_rem ::krayfile.writeln(int,2502);
        //ovr_rem ::krayfile.writeln(kray25_v_ovrsfc);
        //ovr_rem ::krayfile.writeln(kray25_v_ovrsfcolor);

        ::writeBuffer[size(::writeBuffer)+1] = 2601;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_conetoarea;

        ::writeBuffer[size(::writeBuffer)+1] = 2707;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_edgeabs;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_edgerel;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_edgenorm;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_edgezbuf;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_edgeup;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_edgethick;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_edgeover;

        ::writeBuffer[size(::writeBuffer)+1] = 2802;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_pxlfltr;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_pxlparam;

        ::writeBuffer[size(::writeBuffer)+1] = 2901;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_refacth;

        ::writeBuffer[size(::writeBuffer)+1] = 3004;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_tmo;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_tmhsv;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_outparam;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_outexp;

        ::writeBuffer[size(::writeBuffer)+1] = 3101;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_aarandsmpl;

        ::writeBuffer[size(::writeBuffer)+1] = 3207;   // do zmiany
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_shgi;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_giload;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_ginew;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_tiphotons;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_tifg;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_tiframes;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_tiextinction;
        
        ::writeBuffer[size(::writeBuffer)+1] = 3701;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_cmbsubframes;

        ::writeBuffer[size(::writeBuffer)+1] = 3801;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_refmodel;

        ::writeBuffer[size(::writeBuffer)+1] = 4001;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_octdepth;
        
        ::writeBuffer[size(::writeBuffer)+1] = 4101;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_output_On;
        
        ::writeBuffer[size(::writeBuffer)+1] = 4201;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_errode;
        
        ::writeBuffer[size(::writeBuffer)+1] = 4303;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_eyesep;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_stereoimages;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_render0;
        
        ::writeBuffer[size(::writeBuffer)+1] = 4411;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_LogOn;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_Logfile;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_Debug;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_InfoOn;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_InfoText;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_IncludeOn;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_IncludeFile;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_FullPrev;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_Finishclose;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_UBRAGI;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_outputtolw;
    }

    ::writeBuffer[size(::writeBuffer)+1] = 3901;
    ::writeBuffer[size(::writeBuffer)+1] = kray25_create_flag;

    ::writeBuffer[size(::writeBuffer)+1] = 4301;
    ::writeBuffer[size(::writeBuffer)+1] = kray25_v_outfmt;    // new outputformat (list)
    
    ::writeBuffer[size(::writeBuffer)+1] = 0;  // end hunk
}

scnGen_kray25_accuracy
{
    ::writeBuffer[size(::writeBuffer)+1] = "AccuracyBegin";
    ::writeBuffer[size(::writeBuffer)+1] = version;

    if (!create_flag)
    {   // not inited, do not save settings
        ::writeBuffer[size(::writeBuffer)+1] = 100601;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_girauto;

        ::writeBuffer[size(::writeBuffer)+1] = 100001;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_gir;

        ::writeBuffer[size(::writeBuffer)+1] = 100105;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_cf;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_cn;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_cpstart;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_cpstop;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_cpstep;

        ::writeBuffer[size(::writeBuffer)+1] = 100704;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_cmatic;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_clow;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_chigh;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_cdyn;

        ::writeBuffer[size(::writeBuffer)+1] = 100205;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_gf;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_gn;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_gpstart;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_gpstop;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_gpstep;

        ::writeBuffer[size(::writeBuffer)+1] = 100804;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_gmatic;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_glow;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_ghigh;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_gdyn;

        ::writeBuffer[size(::writeBuffer)+1] = 100301;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_ppsize;

        ::writeBuffer[size(::writeBuffer)+1] = 100405;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_fgmin;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_fgmax;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_fgscale;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_fgshows;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_fgsclr;

        ::writeBuffer[size(::writeBuffer)+1] = 100502;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_cornerdist;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_cornerpaths;

        ::writeBuffer[size(::writeBuffer)+1] = 100901;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_cfunit;

        ::writeBuffer[size(::writeBuffer)+1] = 101001;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_gfunit;

        ::writeBuffer[size(::writeBuffer)+1] = 101102;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_fgreflections;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_fgrefractions;

        ::writeBuffer[size(::writeBuffer)+1] = 101201;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_gmode;

        ::writeBuffer[size(::writeBuffer)+1] = 101301;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_ppcaustics;

        ::writeBuffer[size(::writeBuffer)+1] = 101403;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_fgrmin;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_fgrmax;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_fgth;

        ::writeBuffer[size(::writeBuffer)+1] = 101502;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_fga;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_fgb;

        ::writeBuffer[size(::writeBuffer)+1] = 101601;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_ppmult;

        ::writeBuffer[size(::writeBuffer)+1] = 101701;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_cmult;

        ::writeBuffer[size(::writeBuffer)+1] = 101801;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_ppblur;
        
        ::writeBuffer[size(::writeBuffer)+1] = 101901;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_fgblur;

        ::writeBuffer[size(::writeBuffer)+1] = 102001;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_showphotons;

        ::writeBuffer[size(::writeBuffer)+1] = 102201;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_resetoct;

        ::writeBuffer[size(::writeBuffer)+1] = 102301;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_limitdr;

        ::writeBuffer[size(::writeBuffer)+1] = 102403;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_prestep;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_preSplDet;
        ::writeBuffer[size(::writeBuffer)+1] = kray25_v_gradNeighbour;
    }

    ::writeBuffer[size(::writeBuffer)+1] = 0;  // end hunk
    ::writeBuffer[size(::writeBuffer)+1] = "AccuracyEnd";
}

scnGen_kray25_script
{
    if (temp_scene==""){
        ::writeBuffer[size(::writeBuffer)+1] = "KrayScriptLWSInlined -2000;";
    }
    ::writeBuffer[size(::writeBuffer)+1] = "echo '*** Kray script generated by Kray plugin for LightWave';";
    ::writeBuffer[size(::writeBuffer)+1] = "threads 0;";

    if (!Scene().renderopts[1] || !Scene().renderopts[2] || !Scene().renderopts[3]){
        list = scnGen_kray25_renderOptsList();
        
        ::writeBuffer[size(::writeBuffer)+1] = "echo '!** Render global "+list+" is OFF';";
    }
    if (Light().ambient(0)>0){
        ::writeBuffer[size(::writeBuffer)+1] = "echo '!** AMBIENT light is on';";
    }

    ::writeBuffer[size(::writeBuffer)+1] = "var pi,3.14159265;";
    // precached photon map
        ::writeBuffer[size(::writeBuffer)+1] = "var __ppscale,1.2;";
        ::writeBuffer[size(::writeBuffer)+1] = "var __ppstep,0;";
        ::writeBuffer[size(::writeBuffer)+1] = "var __ppstop,0;";
        ::writeBuffer[size(::writeBuffer)+1] = "var __precacheN,1;";
    // blend model
        ::writeBuffer[size(::writeBuffer)+1] = "var __blendss,0;";
    // irradiance gradients constants
        ::writeBuffer[size(::writeBuffer)+1] = "var __irr_elip,4;";
    // autophotons
        ::writeBuffer[size(::writeBuffer)+1] = "var __autogsamples,100;";
        ::writeBuffer[size(::writeBuffer)+1] = "var __autogscale,1;";
        ::writeBuffer[size(::writeBuffer)+1] = "var __autocsamples,100;";
        ::writeBuffer[size(::writeBuffer)+1] = "var __autocscale,1;";
    // auto gir size
        ::writeBuffer[size(::writeBuffer)+1] = "var __autogradients,0.5;";
        ::writeBuffer[size(::writeBuffer)+1] = "var __autocaustics,0.5;";
        ::writeBuffer[size(::writeBuffer)+1] = "var __autoprecached,0.5;";
        ::writeBuffer[size(::writeBuffer)+1] = "var __light_model,1;";
        ::writeBuffer[size(::writeBuffer)+1] = "var __undersample_edge,1;";
        
        ::writeBuffer[size(::writeBuffer)+1] = "var __caustics_try,0.3;";
        
        ::writeBuffer[size(::writeBuffer)+1] = "var __oversample,0.5;";
        
        ::writeBuffer[size(::writeBuffer)+1] = "var __importflags,0;";

        ::writeBuffer[size(::writeBuffer)+1] = "formatstring camera," + activeCamera + ";";
        
        ::writeBuffer[size(::writeBuffer)+1] = "var fgth,"+kray25_v_fgth+";";
        ::writeBuffer[size(::writeBuffer)+1] = "var fgrmin,"+kray25_v_fgrmin+";";
        ::writeBuffer[size(::writeBuffer)+1] = "var fgrmax,"+kray25_v_fgrmax+";";
        ::writeBuffer[size(::writeBuffer)+1] = "var fga,"+kray25_v_fga+";";
        ::writeBuffer[size(::writeBuffer)+1] = "var fgb,"+kray25_v_fgb+";";
        ::writeBuffer[size(::writeBuffer)+1] = "var fgmin,"+kray25_v_fgmin+";";
        ::writeBuffer[size(::writeBuffer)+1] = "var fgmax,"+kray25_v_fgmax+";";
        ::writeBuffer[size(::writeBuffer)+1] = "var fgscale,"+kray25_v_fgscale+";";
        ::writeBuffer[size(::writeBuffer)+1] = "var fgblur,"+kray25_v_fgblur+";";
        ::writeBuffer[size(::writeBuffer)+1] = "var fgreflections,"+kray25_v_fgreflections+";";
        ::writeBuffer[size(::writeBuffer)+1] = "var fgrefractions,"+kray25_v_fgrefractions+";";

        ::writeBuffer[size(::writeBuffer)+1] = "var cornerdist,"+kray25_v_cornerdist+";";
        ::writeBuffer[size(::writeBuffer)+1] = "var cornerpaths,"+kray25_v_cornerpaths+";";
        
        ::writeBuffer[size(::writeBuffer)+1] = "var prep,"+kray25_v_prep+";";
        ::writeBuffer[size(::writeBuffer)+1] = "var prestep,"+kray25_v_prestep+";";
        ::writeBuffer[size(::writeBuffer)+1] = "var preSplDet,"+kray25_v_preSplDet+";";
        ::writeBuffer[size(::writeBuffer)+1] = "var gradNeighbour,"+kray25_v_gradNeighbour+";";
    
        if (temp_scene=="")
        {
            ::writeBuffer[size(::writeBuffer)+1] = "end;";
            ::writeBuffer[size(::writeBuffer)+1] = "KrayScriptLWSInlined -1000;";
        }

        ::writeBuffer[size(::writeBuffer)+1] = "savegimode 1;cam_singleside 0;previewsize 1200,600;usemultipass 0;lwo2rayslimit 1,0.9;animmode 1;about;";
        ::writeBuffer[size(::writeBuffer)+1] = "addpathlw;addpath \""+getdir(CONTENTDIR)+"\";";    // for standalone Kray
        
        ::writeBuffer[size(::writeBuffer)+1] = "multiline 'Header commands';";
        mlsize=size(kray25_v_prescript);
        for (a=1 ; a<=mlsize ; a+=::maxlinelength)
        {
            t=a+::maxlinelength;
            if (t>(mlsize+1))
            {
                t=mlsize+1;
            }
            t=-a+t;
            ::writeBuffer[size(::writeBuffer)+1] = strsub(kray25_v_prescript,a,t);
        }
        ::writeBuffer[size(::writeBuffer)+1] = ";";
        ::writeBuffer[size(::writeBuffer)+1] = "end_of_multiline;";

        // general options

        vp_gi=0;

        switch(kray25_v_gi)
        {
            case 1: // local
                if (kray25_v_gicaustics)
                {
                    vp_gi+=1;
                }
                break;
            case 2: // estimate
                if (kray25_v_gipmmode==1)
                {
                    vp_gi=10000;
                }
                if (kray25_v_gipmmode==2)
                {
                    vp_gi=10002;
                }
                if (kray25_v_gipmmode==3)
                {
                    vp_gi=11000;
                }
                if (kray25_v_gipmmode==4)
                {
                    if (kray25_v_girtdirect)
                    {
                        if (kray25_v_gicaustics)
                        {
                            vp_gi=12013;
                        } else {
                            vp_gi=12012;
                        }
                    } else {
                        vp_gi=11010;
                    }
                }
                break;
            case 3: // photonmapping
                vp_gi=kray25_photon_map_model;
                if (kray25_v_gicaustics)
                {
                    vp_gi+=1;
                }
                if (kray25_v_giirrgrad)
                {
                    vp_gi+=1000;
                }
                break;
            case 4: // path tracing
                vp_gi=40000;
                if (kray25_v_gicaustics)
                {
                    vp_gi+=1;
                }
                if (kray25_v_giirrgrad)
                {
                    vp_gi+=1000;
                }
                break;
        }

        fgtraceflag=0;
        if (!kray25_v_fgreflections)
        {
            fgtraceflag=4;
        }
        if (!kray25_v_fgrefractions)
        {
            fgtraceflag=fgtraceflag+8;
        }

        ::writeBuffer[size(::writeBuffer)+1] = "lwo2import "+vp_gi+",__light_model,(2-"+kray25_v_areavis;
        ::writeBuffer[size(::writeBuffer)+1] = "),"+kray25_v_refmodel+","+fgtraceflag+"+__blendss|__importflags;";
        ::writeBuffer[size(::writeBuffer)+1] = "lwo2bluroptions "+kray25_v_refrmin+","+kray25_v_refrmax+","+kray25_v_refth+","+kray25_v_refacth+";";
        ::writeBuffer[size(::writeBuffer)+1] = "lwconetoarea "+kray25_v_conetoarea+";";
        
        if (kray25_v_lg==1)
        {
            ::writeBuffer[size(::writeBuffer)+1] = "lwpassiveset2;";
            if ((kray25_v_gi==1 || kray25_v_gi==4) && kray25_v_gicaustics==0)
            {
                ::writeBuffer[size(::writeBuffer)+1] = "lumi_minsamples 0;";
            }
        } else if (kray25_v_lg==3)
        {
            ::writeBuffer[size(::writeBuffer)+1] = "autopassive "+kray25_v_autolumi+";";
        }
        
        if (kray25_v_output_On && !kray25_v_render0)
        {
            ::writeBuffer[size(::writeBuffer)+1] = "multiline 'Output filename';";
            ::writeBuffer[size(::writeBuffer)+1] = "outputto '";
            mlsize=size(kray25_v_outname);
            for (a=1 ; a<=mlsize ; a+=::maxlinelength)
            {
                t=a+::maxlinelength;
                if (t>(mlsize+1))
                {
                    t=mlsize+1;
                }
                t=-a+t;
                ::writeBuffer[size(::writeBuffer)+1] = strsub(kray25_v_outname,a,t);
            }
            ::writeBuffer[size(::writeBuffer)+1] = "';";
        
            ::writeBuffer[size(::writeBuffer)+1] = "end_of_multiline;";
        }
        
        if (mlsize==0 || !kray25_v_output_On)
        {       // add alpha buffer if filename is none
            ::writeBuffer[size(::writeBuffer)+1] = "outputtolw 1;";
            ::writeBuffer[size(::writeBuffer)+1] = "needbuffers 0+0x1+0x2;";
        }
        
        switch(kray25_v_outfmt)
        {
            case 1:
                ::writeBuffer[size(::writeBuffer)+1] = "outputformat hdr;";
                break;
            case 2:
                ::writeBuffer[size(::writeBuffer)+1] = "outputformat jpg,100;";
                break;
            case 3:
                ::writeBuffer[size(::writeBuffer)+1] = "outputformat png;";
                break;
            case 4:
                ::writeBuffer[size(::writeBuffer)+1] = "needbuffers 0+0x1+0x2;";
                ::writeBuffer[size(::writeBuffer)+1] = "outputformat pnga;";
                break;
            case 5:
                ::writeBuffer[size(::writeBuffer)+1] = "outputformat tif;";
                break;
            case 6:
                ::writeBuffer[size(::writeBuffer)+1] = "needbuffers 0+0x1+0x2;";
                ::writeBuffer[size(::writeBuffer)+1] = "outputformat tifa;";
                break;
            case 7:
                ::writeBuffer[size(::writeBuffer)+1] = "outputformat tga;";
                break;
            case 8:
                ::writeBuffer[size(::writeBuffer)+1] = "needbuffers 0+0x1+0x2;";
                ::writeBuffer[size(::writeBuffer)+1] = "outputformat tgaa;";
                break;
            case 9:
                ::writeBuffer[size(::writeBuffer)+1] = "outputformat bmp;";
                break;
            case 10:
                ::writeBuffer[size(::writeBuffer)+1] = "needbuffers 0+0x1+0x2;";
                ::writeBuffer[size(::writeBuffer)+1] = "outputformat bmpa;";
                break;
        }
        if(kray25_v_limitdr==2)
        {
            ::writeBuffer[size(::writeBuffer)+1] = "limitdr 1;";
            ::writeBuffer[size(::writeBuffer)+1] = "echo '*** Limiting dynamic range before tonemap';";
        }

        switch(kray25_v_tmo)
        {
            case 1:
                tmp="linear";
                break;
            case 2:
                if (kray25_v_tmhsv)
                {
                    tmp="v_gamma_exposure,"+kray25_v_outparam+","+kray25_v_outexp;
                } else {
                    tmp="gamma_exposure,"+kray25_v_outparam+","+kray25_v_outexp;
                }
                break;
            case 3:
                if (kray25_v_tmhsv)
                {
                    tmp="v_exp_exposure,"+kray25_v_outparam+","+kray25_v_outexp;
                } else {
                    tmp="exp_exposure,"+kray25_v_outparam+","+kray25_v_outexp;
                }
                break;
        }

        ::writeBuffer[size(::writeBuffer)+1] = "tonemapper "+tmp+";";
        
        if (kray25_v_limitdr==3)
        {
            ::writeBuffer[size(::writeBuffer)+1] = "postprocess tonemapper,reverse,"+tmp+";";
            ::writeBuffer[size(::writeBuffer)+1] = "postviewtonemapper "+tmp+";";
        }
        
        if (kray25_v_outfmt!=1)
        {
            ::writeBuffer[size(::writeBuffer)+1] = "dither fs;";
        }
        
        if (temp_scene=="")
        {
            ::writeBuffer[size(::writeBuffer)+1] = "end;";
            ::writeBuffer[size(::writeBuffer)+1] = "KrayScriptLWSInlined 1000;";
        } else {
            ::writeBuffer[size(::writeBuffer)+1] = "lwsload \""+temp_scene+"\";";
        }

        ::writeBuffer[size(::writeBuffer)+1] = "square_lights (2-"+kray25_v_pl+"),"+kray25_v_areaside+";";

        if (kray25_v_shgi==2)
        {
            cb=kray25_v_tiextinction;
            if (cb<0) cb=0;
            if (cb>1) cb=1;

            frames=kray25_v_tiframes;
            if (frames<0) frames=0;
            fparam=frames;
            if (fparam<1) fparam=1;
            
            ca=(1-cb)/(frames+1);

            if (ca!=1)
            {
                if (kray25_v_tiphotons)
                {
                    ::writeBuffer[size(::writeBuffer)+1] = "timeprecached "+fparam+","+ca;

                    if (frames==0)
                    {
                        ::writeBuffer[size(::writeBuffer)+1] = ",0,"+cb;
                    } else {
                        ::writeBuffer[size(::writeBuffer)+1] = ","+ca+","+cb;
                    }

                    for (loop=1 ; loop<frames ; loop++)
                    {
                        ::writeBuffer[size(::writeBuffer)+1] = ","+ca+",0";
                    }

                    ::writeBuffer[size(::writeBuffer)+1] = ";";
                }
                if (kray25_v_tifg)
                {
                    ::writeBuffer[size(::writeBuffer)+1] = "timegradients "+fparam+","+ca;

                    if (frames==0)
                    {
                        ::writeBuffer[size(::writeBuffer)+1] = ",0,"+cb;
                    } else {
                        ::writeBuffer[size(::writeBuffer)+1] = ","+ca+","+cb;
                    }

                    for (loop=1 ; loop<frames ; loop++)
                    {
                        ::writeBuffer[size(::writeBuffer)+1] = ","+ca+",0";
                    }

                    ::writeBuffer[size(::writeBuffer)+1] = ";";
                }
            }
        } else if (kray25_v_shgi==3)
        {
            ::writeBuffer[size(::writeBuffer)+1] = "resetgi 0;";
            ::writeBuffer[size(::writeBuffer)+1] = "resetoct "+kray25_v_resetoct+";";
            ::writeBuffer[size(::writeBuffer)+1] = "lmanim;";
            if (kray25_v_render0)
            {
                    ::writeBuffer[size(::writeBuffer)+1] = "render 0;";
            }
            if (kray25_v_giload)
            {
                if (kray25_v_ginew&1)
                {
                    ::writeBuffer[size(::writeBuffer)+1] = "loadgis \""+kray25_v_giload+"\";";
                }
                if (kray25_v_ginew&2)
                {
                    ::writeBuffer[size(::writeBuffer)+1] = "savegis \""+kray25_v_giload+"\";";
                }
            }

        }
        if (kray25_v_single)
        {
            ::writeBuffer[size(::writeBuffer)+1] = "singleframe;";
        }

        switch(kray25_v_pxlordr)
        {
            case 1:
                ::writeBuffer[size(::writeBuffer)+1] = "splitscreen betterauto;pixelorder scanline;";
                break;
            case 2:
                ::writeBuffer[size(::writeBuffer)+1] = "splitscreen betterauto;pixelorder scanrow;";
                break;
            case 3:
                ::writeBuffer[size(::writeBuffer)+1] = "splitscreen none;pixelorder random;";
                break;
            case 4:
                ::writeBuffer[size(::writeBuffer)+1] = "undersampleprerender 1;pixelorder scanline;";
                if (kray25_v_underf==1)
                {
                    ::writeBuffer[size(::writeBuffer)+1] = "undersample 1,0,0;";
                }
                break;
            case 5:
                ::writeBuffer[size(::writeBuffer)+1] = "splitscreen none;pixelorder worm;";
                break;
            case 6:
                ::writeBuffer[size(::writeBuffer)+1] = "splitscreen none;pixelorder frost;";
                break;
        }
        if(kray25_v_limitdr==1)
        {
            ::writeBuffer[size(::writeBuffer)+1] = "limitdr 1;";
            ::writeBuffer[size(::writeBuffer)+1] = "echo '*** Limiting dynamic range after tonemap';";
        }
        
        ::writeBuffer[size(::writeBuffer)+1] = "prerender prep,prestep,preSplDet; gradients_neighbour gradNeighbour;";

        if (kray25_v_underf>1)
        {
            if (kray25_v_fgshows==1 || !kray25_v_giirrgrad)
            {
                ::writeBuffer[size(::writeBuffer)+1] = "undersample ("+kray25_v_underf+"-1),"+kray25_v_undert+",__undersample_edge;";
            }
        }

        ::writeBuffer[size(::writeBuffer)+1] = "linadaptive "+kray25_v_llinth+","+kray25_v_llinrmin+","+kray25_v_llinrmax+";";
        ::writeBuffer[size(::writeBuffer)+1] = "squareplanar "+kray25_v_planth+","+kray25_v_planrmin+","+kray25_v_planrmax+";";
        ::writeBuffer[size(::writeBuffer)+1] = "planar ("+kray25_v_lumith+"*"+kray25_v_lumith+"),"+kray25_v_lumirmin+","+kray25_v_lumirmax+";";

        // accuracy settings

        switch(kray25_v_octdepth)
        {
            case 1: // very low
                ::writeBuffer[size(::writeBuffer)+1] = "octree 25,22;var sep,2;var ds,4;var fs,0;";
                break;
            case 2: // low
                ::writeBuffer[size(::writeBuffer)+1] = "octree 30,17;var sep,0.7;var ds,2;var fs,0;";
                break;
            case 3: // normal
                ::writeBuffer[size(::writeBuffer)+1] = "octree 35,15;var sep,0.7;var ds,1;var fs,90;";
                break;
            case 4: // high
                ::writeBuffer[size(::writeBuffer)+1] = "octree 40,15;var sep,0.5;var ds,0.5;var fs,90;";
                break;
        }
        ::writeBuffer[size(::writeBuffer)+1] = "octbuild sep,(ds*0.2,ds*1,ds*0.2),(fs*0.2,fs*1,fs*0.2);";
        ::writeBuffer[size(::writeBuffer)+1] = "outsidesize -1;";    // automatic

        if (kray25_v_girauto)
        {
            ::writeBuffer[size(::writeBuffer)+1] = "var _gi_res,1;";
            ::writeBuffer[size(::writeBuffer)+1] = "autophotons gscalegradients,__autogradients;";
            ::writeBuffer[size(::writeBuffer)+1] = "autophotons gscalecaustics,__autocaustics;";
            ::writeBuffer[size(::writeBuffer)+1] = "autophotons gscaleprecached,__autoprecached;";
        } else {
            ::writeBuffer[size(::writeBuffer)+1] = "var _gi_res,"+kray25_v_gir+";";
        }
        if (kray25_v_showphotons!=1)
        {
            ::writeBuffer[size(::writeBuffer)+1] = "showphotons 0;";
        }   
        tstop=0;
        if (kray25_v_cpstep>1)
        {
            tstop=kray25_v_cpstop;
        }
        tsign=1;
        if (kray25_v_cfunit==2)
        {
            tsign=-1;
        }

        ::writeBuffer[size(::writeBuffer)+1] = "causticspm "+(kray25_v_cf*tsign)+","+kray25_v_cn+",_gi_res*"+kray25_v_cpstart+",";
        ::writeBuffer[size(::writeBuffer)+1] = "_gi_res*"+kray25_v_cpstop+","+kray25_v_cpstep+",__caustics_try;";

        tstop=0;
        if (kray25_v_gpstep>1)
        {
            tstop=kray25_v_gpstop;
        }
        tsign=1;
        if (kray25_v_gfunit==2)
        {
            tsign=-1;
        }

        if (kray25_v_gmode==1)
        {
            ::writeBuffer[size(::writeBuffer)+1] = "globalpm "+(kray25_v_gf*tsign)+","+kray25_v_gn+",_gi_res*"+kray25_v_gpstart+",";
            ::writeBuffer[size(::writeBuffer)+1] = "_gi_res*"+tstop+","+kray25_v_gpstep+";";
            } else {
                lmcaustics=0;
                if (kray25_v_gicaustics || kray25_v_gi==2)
                {   // caustics enabled or estimate mode
                    lmcaustics=kray25_v_ppcaustics;
                }
            ::writeBuffer[size(::writeBuffer)+1] = "globallm "+(kray25_v_gf*tsign)+","+kray25_v_gn+",_gi_res*"+kray25_v_gpstart+",";
            ::writeBuffer[size(::writeBuffer)+1] = "_gi_res*"+tstop+","+kray25_v_gpstep+","+lmcaustics+";";
        }

        ::writeBuffer[size(::writeBuffer)+1] = "precachedpm _gi_res*__ppscale*"+kray25_v_ppsize+",_gi_res*__ppscale*__ppstop,";
        ::writeBuffer[size(::writeBuffer)+1] = "__ppstep,__precacheN,_gi_res*"+kray25_v_ppsize+";";
        ::writeBuffer[size(::writeBuffer)+1] = "precachedblur "+kray25_v_ppblur+";";
        ::writeBuffer[size(::writeBuffer)+1] = "globalmultiplier "+kray25_v_ppmult+";";
        ::writeBuffer[size(::writeBuffer)+1] = "causticsmultiplier "+kray25_v_cmult+";";

        if (kray25_v_gmatic)
        {
            ::writeBuffer[size(::writeBuffer)+1] = "autophotons global,__autogsamples,"+kray25_v_glow+","+kray25_v_ghigh+","+kray25_v_gdyn+",__autogscale;";
        }
        if (kray25_v_cmatic)
        {
            ::writeBuffer[size(::writeBuffer)+1] = "autophotons caustics,__autocsamples,"+kray25_v_clow+","+kray25_v_chigh+","+kray25_v_cdyn+",";
            ::writeBuffer[size(::writeBuffer)+1] = "__autocscale;";
        }

        ::writeBuffer[size(::writeBuffer)+1] = "irradiancerays "+kray25_v_fgrmin+","+kray25_v_fgrmax+",1,"+kray25_v_fgth+"*"+kray25_v_fgth+";";

        ::writeBuffer[size(::writeBuffer)+1] = "pmcorner _gi_res*"+kray25_v_cornerdist+","+kray25_v_cornerpaths+";";

        ::writeBuffer[size(::writeBuffer)+1] = "gradients _gi_res*"+kray25_v_fgmax+","+kray25_v_fga+";";
        ::writeBuffer[size(::writeBuffer)+1] = "gradients2 _gi_res*"+kray25_v_fgmin+","+kray25_v_fgscale+";";
        ::writeBuffer[size(::writeBuffer)+1] = "gradients3 __oversample,"+kray25_v_fgb+"*pi/180;";
        ::writeBuffer[size(::writeBuffer)+1] = "gradients4 _gi_res*"+(kray25_v_fgmax*10)+",_gi_res*"+(kray25_v_fgmax*10)+",__irr_elip;";
        ::writeBuffer[size(::writeBuffer)+1] = "irradianceblur 0,1+sqr("+kray25_v_fgblur+");";

        if (kray25_v_fgshows!=1)
        {
            clr=kray25_v_fgsclr;
            clr=clr*100;
            r=dot3d(clr,<1,0,0>);
            g=dot3d(clr,<0,1,0>);
            b=dot3d(clr,<0,0,1>);
            if (kray25_v_fgshows==3)
            {
                ::writeBuffer[size(::writeBuffer)+1] = "showgisamples ("+(r/255)+","+(g/255)+","+(b/255)+");";
            } else {
                ::writeBuffer[size(::writeBuffer)+1] = "showcornersamples ("+(r/255)+","+(g/255)+","+(b/255)+");";
            }
        }

        kray25_dof_active=Scene().renderopts[7];
        mb_active=Scene().renderopts[6];

        if (kray25_dof_active && !kray25_v_aafscreen)
        {
            ::writeBuffer[size(::writeBuffer)+1] = "echo '!!! Full screen AA is off. DOF disabled.';";
        }

        if (kray25_v_aatype==1)
        {
            ::writeBuffer[size(::writeBuffer)+1] = "imagesampler none;";
        } else {
            if (kray25_v_aafscreen)
            {
                if (kray25_v_aatype==2)
                {
                    if (kray25_v_aagridrotate)
                    {
                        ::writeBuffer[size(::writeBuffer)+1] = "imagesampler total_rot_uniform,"+kray25_v_aargsmpl+";";
                    } else {
                        ::writeBuffer[size(::writeBuffer)+1] = "imagesampler total_uniform,"+kray25_v_aargsmpl+";";
                    }
                }
                if (kray25_v_aatype==3)
                {
                    if (kray25_v_cstocmin>=kray25_v_cstocmax || kray25_v_cstocvar==0 || mb_active || kray25_dof_active)
                    {   // Added fix for FS#414 check if MB or DOF is on
                        ::writeBuffer[size(::writeBuffer)+1] = "imagesampler total_qmc,"+kray25_v_cstocmin+";";
                    } else {
                        ::writeBuffer[size(::writeBuffer)+1] = "imagesampler total_qmcadaptive,"+kray25_v_cstocmin+","+kray25_v_cstocmax+","+kray25_v_cstocvar+";";
                    }
                }
                if (kray25_v_aatype==4)
                {
                        if (mb_active)
                        {
                            ::writeBuffer[size(::writeBuffer)+1] = "imagesampler total_mb_random,"+kray25_v_aarandsmpl+","+kray25_v_cmbsubframes+";";
                        } else {
                            ::writeBuffer[size(::writeBuffer)+1] = "imagesampler total_random,"+kray25_v_aarandsmpl+";";
                        }
                }
            } else {
                if (kray25_v_aatype==2)
                {
                    if (kray25_v_aagridrotate)
                    {
                        ::writeBuffer[size(::writeBuffer)+1] = "imagesampler rot_uniform,"+kray25_v_aargsmpl+";";
                    } else {
                        ::writeBuffer[size(::writeBuffer)+1] = "imagesampler uniform,"+kray25_v_aargsmpl+";";
                    }
                }
                if (kray25_v_aatype==3)
                {
                    ::writeBuffer[size(::writeBuffer)+1] = "imagesampler qmcadaptive,"+kray25_v_cstocmin+","+kray25_v_cstocmax+","+kray25_v_cstocvar+";";
                }
            }
        }

        if (1)
        {
            // edgedetector (deprecated but still working)
            ::writeBuffer[size(::writeBuffer)+1] = "edgedetector "+kray25_v_edgeabs+","+kray25_v_edgerel+","+kray25_v_edgenorm+","+kray25_v_edgezbuf+",";
            ::writeBuffer[size(::writeBuffer)+1] = ""+kray25_v_edgethick+","+kray25_v_edgeover+","+kray25_v_edgeup+";";
        } else {
            // edgedetector (new)
            ::writeBuffer[size(::writeBuffer)+1] = "edgedetectorglobals "+kray25_v_edgethick+","+kray25_v_edgeup+";";
            ::writeBuffer[size(::writeBuffer)+1] = "edgedetectorslot 0,"+kray25_v_edgeabs+","+kray25_v_edgerel+","+kray25_v_edgenorm+","+kray25_v_edgezbuf+",";
            ::writeBuffer[size(::writeBuffer)+1] = ""+kray25_v_edgeover+";";
        }

        // pixel filter
        switch(kray25_v_pxlfltr)
        {
            case 1:
                ::writeBuffer[size(::writeBuffer)+1] = "pixelfilter box,"+kray25_v_pxlparam+";";
                break;
            case 2:
                ::writeBuffer[size(::writeBuffer)+1] = "pixelfilter cone,"+kray25_v_pxlparam+";";
                break;
            case 3:
                ::writeBuffer[size(::writeBuffer)+1] = "pixelfilter cubic,"+kray25_v_pxlparam+";";
                break;
            case 4:
                ::writeBuffer[size(::writeBuffer)+1] = "pixelfilter quadric,"+kray25_v_pxlparam+";";
                break;
            case 5:
                ::writeBuffer[size(::writeBuffer)+1] = "pixelfilter lanczos,"+kray25_v_pxlparam+";";
                break;
            case 6:
                ::writeBuffer[size(::writeBuffer)+1] = "pixelfilter mitchell;";
                break;
            case 7:
                ::writeBuffer[size(::writeBuffer)+1] = "pixelfilter spline;";
                break;
            case 8:
                ::writeBuffer[size(::writeBuffer)+1] = "pixelfilter catmull;";
                break;
        }

        camera_write="";
        switch(kray25_v_cptype)
        {
            case 1:
                break;
            case 2:
                ::writeBuffer[size(::writeBuffer)+1] = "lwcammode 1;";
                break;
            case 3:
                ::writeBuffer[size(::writeBuffer)+1] = "lwcammode 4;";
                break;
            case 4:
                ::writeBuffer[size(::writeBuffer)+1] = "lwcammode 3;";

                kray25_v_camobjectfile="";
                vmapObj = Mesh();
                while(vmapObj)
                {
                    if (vmapObj.id==kray25_v_camobject)
                    {
                        kray25_v_camobjectfile=vmapObj.filename;
                    }
                    vmapObj = vmapObj.next();
                }

                ::writeBuffer[size(::writeBuffer)+1] = "multiline 'TextureBaker';";
                ::writeBuffer[size(::writeBuffer)+1] = "camera mesh,'";
                
                mlsize=size(kray25_v_camobjectfile);
                for (a=1 ; a<=mlsize ; a+=::maxlinelength)
                {
                    t=a+::maxlinelength;
                    if (t>(mlsize+1))
                    {
                        t=mlsize+1;
                    }
                    t=-a+t;
                    ::writeBuffer[size(::writeBuffer)+1] = strsub(kray25_v_camobjectfile,a,t);
                }           
                ::writeBuffer[size(::writeBuffer)+1] = "',"+kray25_v_camobject+",'"+kray25_v_camuvname+"',0,0,(0,0,0),<>;";
                ::writeBuffer[size(::writeBuffer)+1] = "end_of_multiline;";
                break;
            case 5:
                ::writeBuffer[size(::writeBuffer)+1] = "lwcammode 8;camera stereo,0,0,0,(0,0,0),<>,"+kray25_v_eyesep+","+kray25_v_stereoimages+";";
                break;
        }

        if (kray25_v_lenspict!="" && kray25_dof_active)
        {
            ::writeBuffer[size(::writeBuffer)+1] = "echo '*** Loading lens bitmap';";
            ::writeBuffer[size(::writeBuffer)+1] = "multiline 'LensImage';";
            ::writeBuffer[size(::writeBuffer)+1] = "pixmap __lens_bitmap,'";
            
            mlsize=size(kray25_v_lenspict);
            for (a=1 ; a<=mlsize ; a+=::maxlinelength)
            {
                t=a+::maxlinelength;
                if (t>(mlsize+1))
                {
                    t=mlsize+1;
                }
                t=-a+t;
                ::writeBuffer[size(::writeBuffer)+1] = strsub(kray25_v_lenspict,a,t);
            }

            ::writeBuffer[size(::writeBuffer)+1] = "',0;";
            ::writeBuffer[size(::writeBuffer)+1] = "end_of_multiline;";
            ::writeBuffer[size(::writeBuffer)+1] = "lensbitmap __lens_bitmap;";
        }

        index=-1;
        count=1;

        kray25_vmapObj = Mesh();
        if (kray25_vmapObj != nil)
        {
            while(kray25_vmapObj)
            {
                if (string(kray25_vmapObj.name)==kray25_v_dofobj)
                {
                    index=kray25_vmapObj.id;
                }
                kray25_vmapObj = kray25_vmapObj.next();
                count++;
            }
        }

        if (index>=0)
        {
            ::writeBuffer[size(::writeBuffer)+1] = "lwdoftargetobject "+index+";";
        }

    ::writeBuffer[size(::writeBuffer)+1] = "remglobalpm 1;";
    ::writeBuffer[size(::writeBuffer)+1] = "pmsidethreshold 0.5;";
    ::writeBuffer[size(::writeBuffer)+1] = "octcache 3;";
    kray25_v_errode = kray25_v_errode + (-1);
    ::writeBuffer[size(::writeBuffer)+1] = "postprocess erode," +kray25_v_errode+ ";";
        

    if (kray25_v_LogOn)
    {
        ::writeBuffer[size(::writeBuffer)+1] = "logfile '" +kray25_v_Logfile+ "';";
    }
    if (kray25_v_Debug)
    {
        ::writeBuffer[size(::writeBuffer)+1] = "debug -1;";
    }
    if (kray25_v_InfoOn)
    {
        ::writeBuffer[size(::writeBuffer)+1] = "renderinfo '" +kray25_v_InfoText+ "';";
    }
    if (kray25_v_IncludeOn)
    {
        ::writeBuffer[size(::writeBuffer)+1] = "include '" +kray25_v_IncludeFile+ "';";
    }
    if (kray25_v_FullPrev)
    {
        ::writeBuffer[size(::writeBuffer)+1] = "previewsize 99999,99999;";
    }
    if (kray25_v_Finishclose)
    {
        ::writeBuffer[size(::writeBuffer)+1] = "finishclose;";
    }
    if (kray25_v_UBRAGI)
    {
        ::writeBuffer[size(::writeBuffer)+1] = "lwo2unseenbyrays_affectsgi 0;";
    }
    if (kray25_v_outputtolw)
    {
        ::writeBuffer[size(::writeBuffer)+1] = "outputtolw 1;";
    }

    ::writeBuffer[size(::writeBuffer)+1] = "multiline 'Tailer commands';";
    mlsize=size(kray25_v_postscript);
    mlsize=size(kray25_v_postscript);
    for (a=1 ; a<=mlsize ; a+=::maxlinelength)
    {
        t=a+::maxlinelength;
        if (t>(mlsize+1))
        {
            t=mlsize+1;
        }
        t=-a+t;
        ::writeBuffer[size(::writeBuffer)+1] = strsub(kray25_v_postscript,a,t);
    }
    ::writeBuffer[size(::writeBuffer)+1] = ";";
    ::writeBuffer[size(::writeBuffer)+1] = "end_of_multiline;";
    ::writeBuffer[size(::writeBuffer)+1] = "end;";
}

addKrayRenderer
{
    /* Anticipating a structure like :
    ExternalRenderer KrayRenderer
    Plugin ExtRendererHandler 1 KrayRenderer
    EndPlugin
    */

    // Check if we have any external renderer configured.
    rendererCheck = getRendererPluginLine("any");
    if(rendererCheck)
    {
        krayRPCheck = getRendererPluginLine("KrayRenderer");
    }
    if(!krayRPCheck)
    {
        if (rendererCheck)
        {
            strip3rdPartyRenderers();
        }
        ::writeBuffer = ::readBuffer;
        ::writeBuffer[size(::writeBuffer)+1] = "";
        ::writeBuffer[size(::writeBuffer)+1] = "ExternalRenderer KrayRenderer";
        ::writeBuffer[size(::writeBuffer)+1] = "Plugin ExtRendererHandler 1 KrayRenderer";
        ::writeBuffer[size(::writeBuffer)+1] = "EndPlugin";
        ::readBuffer = ::writeBuffer;
        ::writeBuffer = nil;
    }
}

getKrayScriptPath
{
    config_dir  = getdir("Settings");
    vers        = string(integer(hostVersion()));

    switch(platform())
    {
        case MACUB:
        case MAC64:
            tempString = config_dir + getsep() + "Extensions " + vers;
            input = File(tempString);
            tempString_AS = config_dir + getsep() + "Extension Cache";
            input_AS = File(tempString_AS);
            break;

        case WIN32:
            tempString = config_dir + getsep() + "LWEXT" + vers + ".CFG";
            input = File(tempString);
            tempString_AS = config_dir + getsep() + "Extension Cache";
            input_AS = File(tempString_AS);
            break;

        case WIN64:
            tempString = config_dir + getsep() + "LWEXT" + vers + "-64.CFG";
            input = File(tempString);
            tempString_AS = config_dir + getsep() + "Extension Cache-64";
            input_AS = File(tempString_AS);
            break;

        default:
            break;

    }

    firstSearchString = "  Class \"MasterHandler\"";
    secondSearchString = "  Name \"Kray\"";
    toReturn = "";
    if(input)
    {
        // not autoscan
        while(!input.eof())
        {
            line = input.read();
            if (line == firstSearchString)
            {
                line = input.read();
                if (line == secondSearchString)
                {
                    // Next line should be our Kray.lsc reference.
                    line = input.read();
                    pathString = parse(" ", line);
                    if (pathString[1] == "Module")
                    {
                        krayPath = pathString[2];
                    }
                }
            }
            if (krayPath)
            {
                break; // We found our script.
            }
        }
        input.close();
    }

    if(!krayPath)
    {
        if(input_AS)
        {
            // not autoscan
            while(!input_AS.eof())
            {
                line = input_AS.read();
                if (line == firstSearchString)
                {
                    line = input_AS.read();
                    if (line == secondSearchString)
                    {
                        // Next line should be our Kray.lsc reference.
                        line = input_AS.read();
                        pathString = parse(" ", line);
                        if (pathString[1] == "Module")
                        {
                            krayPath = pathString[2];
                        }
                    }
                }
                if (krayPath)
                {
                    break; // We found our script.
                }
            }
            input_AS.close();
        }
    }
    
    if(krayPath)
    {
        toReturn = krayPath;
    } else {
        logger("warn","Unable to locate LightWave config files or could not find Kray LSC entry. Setting in scene file will be incorrect.");
        toReturn = "Unknown\Kray.LSC";
    }
    return toReturn;
}

