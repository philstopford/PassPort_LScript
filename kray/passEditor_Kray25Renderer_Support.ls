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

    krayHeaderLine = getMasterPluginLine("Kray", ::updatedCurrentScenePath); // Should pick up MasterHandler for Kray

    // Startup checks to ensure we're working against a known quantity.
    if (krayHeaderLine == nil)
    {
        logger("info","scnGen_kray25: Kray 2.5 master plugin not found. Guessing....");
        krayLSCBuild = default_krayLSCBuild;
        krayBuild = default_krayBuild;
    } else {
        searchString = "Plugin MasterHandler";
        input = File(::updatedCurrentScenePath, "r");
        input.line(krayHeaderLine + 3); // offset for the plugin header, the LSC script reference and the Kray encapsulator
        krayLSCBuild = input.readInt();
        krayBuild = input.readInt();
        input.close();
        krayPluginEndLine = getPartialLine(krayHeaderLine,0,"EndPlugin",::updatedCurrentScenePath);
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

    if(activeCameraID == 0) // FIXME: Needs implementation.
    {
        activeCamera = 0; // first camera in scene file, matching default behaviour for no cameras in pass.
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
                            nameIndex = k;
                        }
                    }
                    passCamNameArray[passCamArrayIndex] = ::displayNames[nameIndex];
                    passCamArrayIndex++;
                }
            }
        }

        activeCamera = 0;
        counter = 0;
        for(i = 1; i <= passCamIDArray.size(); i++)
        {
            if(passCamIDArray[i] == activeCameraID)
            {
                // logger("info","scnGen_kray25: Found match for camera: " + counter.asStr());
                activeCamera = counter;
            }
            counter++;
        }
    }

    if(passCamNameArray == nil)
    {
        logger("error","scnGen_kray25: No camera assigned to pass!");
    } else {
        activeCameraName = passCamNameArray[activeCamera + 1];
    }

    // We need to do both of these - the first because we will later overwrite this field because it's parked at the end of the file and gets re-written
    // from the source file very late in the scene generation process.
    writeOverrideString(::updatedCurrentScenePath, ::updatedCurrentScenePath, "CurrentCamera ", activeCamera);
    writeOverrideString(::updatedCurrentScenePath, ::newScenePath, "CurrentCamera ", activeCamera);
    
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

    krayTempPath = ::tempDirectory + getsep() + "passEditorTempSceneKray.lws";
    ::krayfile = File(krayTempPath, "w");
    sourceFile = File(::updatedCurrentScenePath, "r");
    if (krayHeaderLine != nil)
    {
        copyLineNumber = 1;
        while(copyLineNumber <= krayHeaderLine)
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
        ::krayfile.writeln("Plugin MasterHandler " + string(masterHandlerCounter + 1) + " Kray");
        ::krayfile.writeln("Script " + getKrayScriptPath().asStr());
    }
    ::krayfile.writeln("Kray{");

    scnGen_kray25_general();
    scnGen_kray25_accuracy();
    scnGen_kray25_script();
    ::krayfile.writeln("}");

    if (krayHeaderLine != nil)
    {
        sourceFile.line(krayPluginEndLine);
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

    scnGen_kray25_plugins();

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
    ::krayfile.writeln(version);

    if (!create_flag){  // not inited, do not save settings
        ::krayfile.writeln(int,3605);
        ::krayfile.writeln(int,kray25_v_gph_preset);
        ::krayfile.writeln(int,kray25_v_cph_preset);
        ::krayfile.writeln(int,kray25_v_fg_preset);
        ::krayfile.writeln(int,kray25_v_aa_preset);
        ::krayfile.writeln(int,kray25_v_quality_preset);
        
        ::krayfile.writeln(int,104);
        ::krayfile.writeln(int,kray25_v_gi);
        ::krayfile.writeln(kray25_v_gicaustics);
        ::krayfile.writeln(kray25_v_giirrgrad);
        ::krayfile.writeln(kray25_v_gipmmode);

        ::krayfile.writeln(int,2301);
        ::krayfile.writeln(kray25_v_girtdirect);

        ::krayfile.writeln(int,201);
        ::krayfile.writeln(int,kray25_v_lg);
        
        ::krayfile.writeln(int,301);
        ::krayfile.writeln(int,kray25_v_pl);

        mlsize=size(kray25_v_outname);
        if (mlsize==0)
        {
            ::krayfile.writeln(int,3501);
            ::krayfile.writeln("");
        } else {
            for (a=1 ; a<=mlsize ; a += ::maxlinelength)
            {
                t = a + ::maxlinelength;
                if (t>(mlsize+1))
                {
                    t=mlsize+1;
                }
                t=-a+t;
                ::krayfile.writeln(int,3501);
                ::krayfile.writeln(strsub(kray25_v_outname,a,t));
            }
        }

        ::krayfile.writeln(int,602);
        ::krayfile.writeln(number,kray25_v_prep);
        ::krayfile.writeln(int,kray25_v_pxlordr);

        ::krayfile.writeln(int,702);
        ::krayfile.writeln(int,kray25_v_underf);
        ::krayfile.writeln(number,kray25_v_undert);

        ::krayfile.writeln(int,802);
        ::krayfile.writeln(int,kray25_v_areavis);
        ::krayfile.writeln(int,kray25_v_areaside);

       // lights & camera

        ::krayfile.writeln(int,1003);
        ::krayfile.writeln(kray25_v_planth);
        ::krayfile.writeln(kray25_v_planrmin);
        ::krayfile.writeln(kray25_v_planrmax);

        ::krayfile.writeln(int,2103);
        ::krayfile.writeln(kray25_v_llinth);
        ::krayfile.writeln(kray25_v_llinrmin);
        ::krayfile.writeln(kray25_v_llinrmax);

        ::krayfile.writeln(int,1103);
        ::krayfile.writeln(kray25_v_lumith);
        ::krayfile.writeln(kray25_v_lumirmin);
        ::krayfile.writeln(kray25_v_lumirmax);

        ::krayfile.writeln(int,2402);
        if(kray25_v_camobject == "__PPRN__BLANK__ENTRY__")
        {
            ::krayfile.writeln("");
        } else {
            ::krayfile.writeln(kray25_v_camobject);
        }
        if(kray25_v_camuvname == "__PPRN__BLANK__ENTRY__")
        {
            ::krayfile.writeln("");
        } else {
            ::krayfile.writeln(kray25_v_camuvname);
        }

        ::krayfile.writeln(int,1301);
        ::krayfile.writeln(kray25_v_cptype);

        mlsize=size(kray25_v_lenspict);
        if (mlsize==0)
        {
            ::krayfile.writeln(int,1401);
            ::krayfile.writeln("");
        } else {
            for (a=1 ; a<=mlsize ; a+=::maxlinelength)
            {
                t=a+::maxlinelength;
                if (t>(mlsize+1))
                {
                    t=mlsize+1;
                }
                t=-a+t;
                ::krayfile.writeln(int,1401);
                ::krayfile.writeln(strsub(kray25_v_lenspict,a,t));
            }
        }
        
        ::krayfile.writeln(int,1501);
        if(kray25_v_dofobj == "__PPRN__BLANK__ENTRY__")
        {
            ::krayfile.writeln("");
        } else {
            ::krayfile.writeln(kray25_v_dofobj);
        }

        ::krayfile.writeln(int,1603);
        ::krayfile.writeln(kray25_v_cstocvar);
        ::krayfile.writeln(kray25_v_cstocmin);
        ::krayfile.writeln(kray25_v_cstocmax);

        ::krayfile.writeln(int,1804);
        ::krayfile.writeln(kray25_v_aatype);
        ::krayfile.writeln(kray25_v_aafscreen);
        ::krayfile.writeln(kray25_v_aargsmpl);
        ::krayfile.writeln(kray25_v_aagridrotate);

        ::krayfile.writeln(int,1903);
        ::krayfile.writeln(kray25_v_refth);
        ::krayfile.writeln(kray25_v_refrmin);
        ::krayfile.writeln(kray25_v_refrmax);

        mlsize=size(kray25_v_prescript);
        if (mlsize==0)
        {
            ::krayfile.writeln(int,3301);
            ::krayfile.writeln("");
        } else {
            for (a=1 ; a<=mlsize ; a+=::maxlinelength)
            {
                t=a+::maxlinelength;
                if (t>(mlsize+1))
                {
                    t=mlsize+1;
                }
                t=-a+t;
                ::krayfile.writeln(int,3301);
                ::krayfile.writeln(strsub(kray25_v_prescript,a,t));
            }
        }
        
        mlsize=size(kray25_v_postscript);
        if (mlsize==0)
        {
            ::krayfile.writeln(int,3401);
            ::krayfile.writeln("");
        } else {
            for (a=1 ; a<=mlsize ; a+=::maxlinelength)
            {
                t=a+::maxlinelength;
                if (t>(mlsize+1))
                {
                    t=mlsize+1;
                }
                t=-a+t;
                ::krayfile.writeln(int,3401);
                ::krayfile.writeln(strsub(kray25_v_postscript,a,t));
            }
        }
        
        ::krayfile.writeln(int,2101);
        ::krayfile.writeln(kray25_v_autolumi);

        //ovr_rem ::krayfile.writeln(int,2502);
        //ovr_rem ::krayfile.writeln(kray25_v_ovrsfc);
        //ovr_rem ::krayfile.writeln(kray25_v_ovrsfcolor);

        ::krayfile.writeln(int,2601);
        ::krayfile.writeln(kray25_v_conetoarea);

        ::krayfile.writeln(int,2707);
        ::krayfile.writeln(kray25_v_edgeabs);
        ::krayfile.writeln(kray25_v_edgerel);
        ::krayfile.writeln(kray25_v_edgenorm);
        ::krayfile.writeln(kray25_v_edgezbuf);
        ::krayfile.writeln(kray25_v_edgeup);
        ::krayfile.writeln(kray25_v_edgethick);
        ::krayfile.writeln(kray25_v_edgeover);

        ::krayfile.writeln(int,2802);
        ::krayfile.writeln(kray25_v_pxlfltr);
        ::krayfile.writeln(kray25_v_pxlparam);

        ::krayfile.writeln(int,2901);
        ::krayfile.writeln(kray25_v_refacth);

        ::krayfile.writeln(int,3004);
        ::krayfile.writeln(number,kray25_v_tmo);
        ::krayfile.writeln(number,kray25_v_tmhsv);
        ::krayfile.writeln(number,kray25_v_outparam);
        ::krayfile.writeln(number,kray25_v_outexp);

        ::krayfile.writeln(int,3101);
        ::krayfile.writeln(kray25_v_aarandsmpl);

        ::krayfile.writeln(int,3207);   // do zmiany
        ::krayfile.writeln(int,kray25_v_shgi);
        ::krayfile.writeln(string,kray25_v_giload);
        ::krayfile.writeln(boolean,kray25_v_ginew);
        ::krayfile.writeln(boolean,kray25_v_tiphotons);
        ::krayfile.writeln(boolean,kray25_v_tifg);
        ::krayfile.writeln(int,kray25_v_tiframes);
        ::krayfile.writeln(number,kray25_v_tiextinction);
        
        ::krayfile.writeln(int,3701);
        ::krayfile.writeln(int,kray25_v_cmbsubframes);

        ::krayfile.writeln(int,3801);
        ::krayfile.writeln(kray25_v_refmodel);

        ::krayfile.writeln(int,4001);
        ::krayfile.writeln(kray25_v_octdepth);
        
        ::krayfile.writeln(boolean,4101);
        ::krayfile.writeln(kray25_v_output_On);
        
        ::krayfile.writeln(int,4201);
        ::krayfile.writeln(kray25_v_errode);
        
        ::krayfile.writeln(int,4303);
        ::krayfile.writeln(kray25_v_eyesep);
        ::krayfile.writeln(int,kray25_v_stereoimages);
        ::krayfile.writeln(boolean,kray25_v_render0);
        
        ::krayfile.writeln(int,4411);
        ::krayfile.writeln(boolean,kray25_v_LogOn);
        ::krayfile.writeln(kray25_v_Logfile);
        ::krayfile.writeln(boolean,kray25_v_Debug);
        ::krayfile.writeln(boolean,kray25_v_InfoOn);
        ::krayfile.writeln(kray25_v_InfoText);
        ::krayfile.writeln(boolean,kray25_v_IncludeOn);
        ::krayfile.writeln(kray25_v_IncludeFile);
        ::krayfile.writeln(boolean,kray25_v_FullPrev);
        ::krayfile.writeln(boolean,kray25_v_Finishclose);
        ::krayfile.writeln(boolean,kray25_v_UBRAGI);
        ::krayfile.writeln(boolean,kray25_v_outputtolw);
    }

    ::krayfile.writeln(int,3901);
    ::krayfile.writeln(int,kray25_create_flag);

    ::krayfile.writeln(int,4301);
    ::krayfile.writeln(int,kray25_v_outfmt);    // new outputformat (list)
    
    ::krayfile.writeln(int,0);  // end hunk
}

scnGen_kray25_accuracy
{
    ::krayfile.writeln("AccuracyBegin");
    ::krayfile.writeln(version);

    if (!create_flag)
    {   // not inited, do not save settings
        ::krayfile.writeln(int,100601);
        ::krayfile.writeln(int,kray25_v_girauto);

        ::krayfile.writeln(int,100001);
        ::krayfile.writeln(kray25_v_gir);

        ::krayfile.writeln(int,100105);
        ::krayfile.writeln(kray25_v_cf);
        ::krayfile.writeln(int,kray25_v_cn);
        ::krayfile.writeln(kray25_v_cpstart);
        ::krayfile.writeln(kray25_v_cpstop);
        ::krayfile.writeln(kray25_v_cpstep);

        ::krayfile.writeln(int,100704);
        ::krayfile.writeln(kray25_v_cmatic);
        ::krayfile.writeln(kray25_v_clow);
        ::krayfile.writeln(kray25_v_chigh);
        ::krayfile.writeln(kray25_v_cdyn);

        ::krayfile.writeln(int,100205);
        ::krayfile.writeln(kray25_v_gf);
        ::krayfile.writeln(int,kray25_v_gn);
        ::krayfile.writeln(kray25_v_gpstart);
        ::krayfile.writeln(kray25_v_gpstop);
        ::krayfile.writeln(kray25_v_gpstep);

        ::krayfile.writeln(int,100804);
        ::krayfile.writeln(kray25_v_gmatic);
        ::krayfile.writeln(kray25_v_glow);
        ::krayfile.writeln(kray25_v_ghigh);
        ::krayfile.writeln(kray25_v_gdyn);

        ::krayfile.writeln(int,100301);
        ::krayfile.writeln(kray25_v_ppsize);

        ::krayfile.writeln(int,100405);
        ::krayfile.writeln(kray25_v_fgmin);
        ::krayfile.writeln(kray25_v_fgmax);
        ::krayfile.writeln(kray25_v_fgscale);
        ::krayfile.writeln(kray25_v_fgshows);
        ::krayfile.writeln(kray25_v_fgsclr);

        ::krayfile.writeln(int,100502);
        ::krayfile.writeln(kray25_v_cornerdist);
        ::krayfile.writeln(kray25_v_cornerpaths);

        ::krayfile.writeln(int,100901);
        ::krayfile.writeln(int,kray25_v_cfunit);

        ::krayfile.writeln(int,101001);
        ::krayfile.writeln(int,kray25_v_gfunit);

        ::krayfile.writeln(int,101102);
        ::krayfile.writeln(kray25_v_fgreflections);
        ::krayfile.writeln(kray25_v_fgrefractions);

        ::krayfile.writeln(int,101201);
        ::krayfile.writeln(int,kray25_v_gmode);

        ::krayfile.writeln(int,101301);
        ::krayfile.writeln(int,kray25_v_ppcaustics);

        ::krayfile.writeln(int,101403);
        ::krayfile.writeln(kray25_v_fgrmin);
        ::krayfile.writeln(kray25_v_fgrmax);
        ::krayfile.writeln(kray25_v_fgth);

        ::krayfile.writeln(int,101502);
        ::krayfile.writeln(kray25_v_fga);
        ::krayfile.writeln(kray25_v_fgb);

        ::krayfile.writeln(int,101601);
        ::krayfile.writeln(kray25_v_ppmult);

        ::krayfile.writeln(int,101701);
        ::krayfile.writeln(kray25_v_cmult);

        ::krayfile.writeln(int,101801);
        ::krayfile.writeln(kray25_v_ppblur);
        
        ::krayfile.writeln(int,101901);
        ::krayfile.writeln(kray25_v_fgblur);

        ::krayfile.writeln(int,102001);
        ::krayfile.writeln(int,kray25_v_showphotons);

        ::krayfile.writeln(int,102201);
        ::krayfile.writeln(int,kray25_v_resetoct);

        ::krayfile.writeln(int,102301);
        ::krayfile.writeln(int,kray25_v_limitdr);

        ::krayfile.writeln(int,102403);
        ::krayfile.writeln(int,kray25_v_prestep);
        ::krayfile.writeln(kray25_v_preSplDet);
        ::krayfile.writeln(kray25_v_gradNeighbour);
    }

    ::krayfile.writeln(int,0);  // end hunk
    ::krayfile.writeln("AccuracyEnd");
}

scnGen_kray25_script
{
    if (temp_scene==""){
        ::krayfile.writeln("KrayScriptLWSInlined -2000;");
    }
    ::krayfile.writeln("echo '*** Kray script generated by Kray plugin for LightWave';");
    ::krayfile.writeln("threads 0;");

    if (!Scene().renderopts[1] || !Scene().renderopts[2] || !Scene().renderopts[3]){
        list = scnGen_kray25_renderOptsList();
        
        ::krayfile.writeln("echo '!** Render global "+list+" is OFF';");        
    }
    if (Light().ambient(0)>0){
        ::krayfile.writeln("echo '!** AMBIENT light is on';");      
    }

    ::krayfile.writeln("var pi,3.14159265;");
    // precached photon map
        ::krayfile.writeln("var __ppscale,1.2;");
        ::krayfile.writeln("var __ppstep,0;");
        ::krayfile.writeln("var __ppstop,0;");
        ::krayfile.writeln("var __precacheN,1;");
    // blend model
        ::krayfile.writeln("var __blendss,0;");
    // irradiance gradients constants
        ::krayfile.writeln("var __irr_elip,4;");
    // autophotons
        ::krayfile.writeln("var __autogsamples,100;");
        ::krayfile.writeln("var __autogscale,1;");
        ::krayfile.writeln("var __autocsamples,100;");
        ::krayfile.writeln("var __autocscale,1;");
    // auto gir size
        ::krayfile.writeln("var __autogradients,0.5;");
        ::krayfile.writeln("var __autocaustics,0.5;");
        ::krayfile.writeln("var __autoprecached,0.5;");
        ::krayfile.writeln("var __light_model,1;");
        ::krayfile.writeln("var __undersample_edge,1;");
        
        ::krayfile.writeln("var __caustics_try,0.3;");
        
        ::krayfile.writeln("var __oversample,0.5;");
        
        ::krayfile.writeln("var __importflags,0;");

        ::krayfile.writeln("formatstring camera," + activeCamera + ";");
        
        ::krayfile.writeln("var fgth,"+kray25_v_fgth+";");
        ::krayfile.writeln("var fgrmin,"+kray25_v_fgrmin+";");
        ::krayfile.writeln("var fgrmax,"+kray25_v_fgrmax+";");
        ::krayfile.writeln("var fga,"+kray25_v_fga+";");
        ::krayfile.writeln("var fgb,"+kray25_v_fgb+";");
        ::krayfile.writeln("var fgmin,"+kray25_v_fgmin+";");
        ::krayfile.writeln("var fgmax,"+kray25_v_fgmax+";");
        ::krayfile.writeln("var fgscale,"+kray25_v_fgscale+";");
        ::krayfile.writeln("var fgblur,"+kray25_v_fgblur+";");
        ::krayfile.writeln("var fgreflections,"+kray25_v_fgreflections+";");
        ::krayfile.writeln("var fgrefractions,"+kray25_v_fgrefractions+";");

        ::krayfile.writeln("var cornerdist,"+kray25_v_cornerdist+";");
        ::krayfile.writeln("var cornerpaths,"+kray25_v_cornerpaths+";");
        
        ::krayfile.writeln("var prep,"+kray25_v_prep+";");
        ::krayfile.writeln("var prestep,"+kray25_v_prestep+";");
        ::krayfile.writeln("var preSplDet,"+kray25_v_preSplDet+";");
        ::krayfile.writeln("var gradNeighbour,"+kray25_v_gradNeighbour+";");
    
        if (temp_scene==""){
            ::krayfile.writeln("end;");
            ::krayfile.writeln("KrayScriptLWSInlined -1000;");
        }

        ::krayfile.writeln("savegimode 1;cam_singleside 0;previewsize 1200,600;usemultipass 0;lwo2rayslimit 1,0.9;animmode 1;about;");
        ::krayfile.writeln("addpathlw;addpath \""+getdir(CONTENTDIR)+"\";");    // for standalone Kray
        
        ::krayfile.writeln("multiline 'Header commands';");
        mlsize=size(kray25_v_prescript);
        for (a=1 ; a<=mlsize ; a+=::maxlinelength){
            t=a+::maxlinelength;
            if (t>(mlsize+1)){
                t=mlsize+1;
            }
            t=-a+t;
            ::krayfile.writeln(strsub(kray25_v_prescript,a,t));
        }
        ::krayfile.writeln(";");
        ::krayfile.writeln("end_of_multiline;");

        // general options

        vp_gi=0;

        switch(kray25_v_gi){
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

        ::krayfile.writeln("lwo2import "+vp_gi+",__light_model,(2-"+kray25_v_areavis);  
        ::krayfile.writeln("),"+kray25_v_refmodel+","+fgtraceflag+"+__blendss|__importflags;");
        ::krayfile.writeln("lwo2bluroptions "+kray25_v_refrmin+","+kray25_v_refrmax+","+kray25_v_refth+","+kray25_v_refacth+";");
        ::krayfile.writeln("lwconetoarea "+kray25_v_conetoarea+";");
        
        if (kray25_v_lg==1)
        {
            ::krayfile.writeln("lwpassiveset2;");
            if ((kray25_v_gi==1 || kray25_v_gi==4) && kray25_v_gicaustics==0)
            {
                ::krayfile.writeln("lumi_minsamples 0;");
            }
        } else if (kray25_v_lg==3)
        {
            ::krayfile.writeln("autopassive "+kray25_v_autolumi+";");
        }
        
        if (kray25_v_output_On && !kray25_v_render0)
        {
            ::krayfile.writeln("multiline 'Output filename';");
            ::krayfile.writeln("outputto '");
            mlsize=size(kray25_v_outname);
            for (a=1 ; a<=mlsize ; a+=::maxlinelength)
            {
                t=a+::maxlinelength;
                if (t>(mlsize+1))
                {
                    t=mlsize+1;
                }
                t=-a+t;
                ::krayfile.writeln(strsub(kray25_v_outname,a,t));
            }
            ::krayfile.writeln("';");
        
            ::krayfile.writeln("end_of_multiline;");
        }
        
        if (mlsize==0 || !kray25_v_output_On)
        {       // add alpha buffer if filename is none
            ::krayfile.writeln("outputtolw 1;");                
            ::krayfile.writeln("needbuffers 0+0x1+0x2;");
        }
        
        switch(kray25_v_outfmt){
            case 1:
                ::krayfile.writeln("outputformat hdr;");
                break;
            case 2:
                ::krayfile.writeln("outputformat jpg,100;");
                break;
            case 3:
                ::krayfile.writeln("outputformat png;");
                break;
            case 4:
                ::krayfile.writeln("needbuffers 0+0x1+0x2;");
                ::krayfile.writeln("outputformat pnga;");
                break;
            case 5:
                ::krayfile.writeln("outputformat tif;");
                break;
            case 6:
                ::krayfile.writeln("needbuffers 0+0x1+0x2;");
                ::krayfile.writeln("outputformat tifa;");
                break;
            case 7:
                ::krayfile.writeln("outputformat tga;");
                break;
            case 8:
                ::krayfile.writeln("needbuffers 0+0x1+0x2;");
                ::krayfile.writeln("outputformat tgaa;");
                break;
            case 9:
                ::krayfile.writeln("outputformat bmp;");
                break;
            case 10:
                ::krayfile.writeln("needbuffers 0+0x1+0x2;");
                ::krayfile.writeln("outputformat bmpa;");
                break;
        }
        if(kray25_v_limitdr==2)
        {
            ::krayfile.writeln("limitdr 1;");
            ::krayfile.writeln("echo '*** Limiting dynamic range before tonemap';");
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

        ::krayfile.writeln("tonemapper "+tmp+";");
        
        if (kray25_v_limitdr==3)
        {
            ::krayfile.writeln("postprocess tonemapper,reverse,"+tmp+";");
            ::krayfile.writeln("postviewtonemapper "+tmp+";");
        }
        
        if (kray25_v_outfmt!=1)
        {
            ::krayfile.writeln("dither fs;");
        }
        
        if (temp_scene=="")
        {
            ::krayfile.writeln("end;");
            ::krayfile.writeln("KrayScriptLWSInlined 1000;");
        } else {
            ::krayfile.writeln("lwsload \""+temp_scene+"\";");
        }

        ::krayfile.writeln("square_lights (2-"+kray25_v_pl+"),"+kray25_v_areaside+";");

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
                    ::krayfile.writeln("timeprecached "+fparam+","+ca);

                    if (frames==0)
                    {
                        ::krayfile.writeln(",0,"+cb);
                    } else {
                        ::krayfile.writeln(","+ca+","+cb);
                    }

                    for (loop=1 ; loop<frames ; loop++)
                    {
                        ::krayfile.writeln(","+ca+",0");
                    }

                    ::krayfile.writeln(";");
                }
                if (kray25_v_tifg)
                {
                    ::krayfile.writeln("timegradients "+fparam+","+ca);

                    if (frames==0)
                    {
                        ::krayfile.writeln(",0,"+cb);
                    } else {
                        ::krayfile.writeln(","+ca+","+cb);
                    }

                    for (loop=1 ; loop<frames ; loop++)
                    {
                        ::krayfile.writeln(","+ca+",0");
                    }

                    ::krayfile.writeln(";");
                }
            }
        } else if (kray25_v_shgi==3)
        {
            ::krayfile.writeln("resetgi 0;");
            ::krayfile.writeln("resetoct "+kray25_v_resetoct+";");
            ::krayfile.writeln("lmanim;");
            if (kray25_v_render0)
            {
                    ::krayfile.writeln("render 0;");
            }
            if (kray25_v_giload)
            {
                if (kray25_v_ginew&1)
                {
                    ::krayfile.writeln("loadgis \""+kray25_v_giload+"\";");
                }
                if (kray25_v_ginew&2)
                {
                    ::krayfile.writeln("savegis \""+kray25_v_giload+"\";");
                }
            }

        }
        if (kray25_v_single)
        {
            ::krayfile.writeln("singleframe;");
        }

        switch(kray25_v_pxlordr)
        {
            case 1:
                ::krayfile.writeln("splitscreen betterauto;pixelorder scanline;");
                break;
            case 2:
                ::krayfile.writeln("splitscreen betterauto;pixelorder scanrow;");
                break;
            case 3:
                ::krayfile.writeln("splitscreen none;pixelorder random;");
                break;
            case 4:
                ::krayfile.writeln("undersampleprerender 1;pixelorder scanline;");
                if (kray25_v_underf==1)
                {
                    ::krayfile.writeln("undersample 1,0,0;");
                }
                break;
            case 5:
                ::krayfile.writeln("splitscreen none;pixelorder worm;");
                break;
            case 6:
                ::krayfile.writeln("splitscreen none;pixelorder frost;");
                break;
        }
        if(kray25_v_limitdr==1)
        {
            ::krayfile.writeln("limitdr 1;");
            ::krayfile.writeln("echo '*** Limiting dynamic range after tonemap';");
        }
        
        ::krayfile.writeln("prerender prep,prestep,preSplDet; gradients_neighbour gradNeighbour;");

        if (kray25_v_underf>1)
        {
            if (kray25_v_fgshows==1 || !kray25_v_giirrgrad)
            {
                ::krayfile.writeln("undersample ("+kray25_v_underf+"-1),"+kray25_v_undert+",__undersample_edge;");
            }
        }

        ::krayfile.writeln("linadaptive "+kray25_v_llinth+","+kray25_v_llinrmin+","+kray25_v_llinrmax+";");
        ::krayfile.writeln("squareplanar "+kray25_v_planth+","+kray25_v_planrmin+","+kray25_v_planrmax+";");
        ::krayfile.writeln("planar ("+kray25_v_lumith+"*"+kray25_v_lumith+"),"+kray25_v_lumirmin+","+kray25_v_lumirmax+";");

        // accuracy settings

        switch(kray25_v_octdepth)
        {
            case 1: // very low
                ::krayfile.writeln("octree 25,22;var sep,2;var ds,4;var fs,0;");
                break;
            case 2: // low
                ::krayfile.writeln("octree 30,17;var sep,0.7;var ds,2;var fs,0;");
                break;
            case 3: // normal
                ::krayfile.writeln("octree 35,15;var sep,0.7;var ds,1;var fs,90;");
                break;
            case 4: // high
                ::krayfile.writeln("octree 40,15;var sep,0.5;var ds,0.5;var fs,90;");
                break;
        }
        ::krayfile.writeln("octbuild sep,(ds*0.2,ds*1,ds*0.2),(fs*0.2,fs*1,fs*0.2);");
        ::krayfile.writeln("outsidesize -1;");    // automatic

        if (kray25_v_girauto)
        {
            ::krayfile.writeln("var _gi_res,1;");
            ::krayfile.writeln("autophotons gscalegradients,__autogradients;");
            ::krayfile.writeln("autophotons gscalecaustics,__autocaustics;");
            ::krayfile.writeln("autophotons gscaleprecached,__autoprecached;");
        } else {
            ::krayfile.writeln("var _gi_res,"+kray25_v_gir+";");
        }
        if (kray25_v_showphotons!=1)
        {
            ::krayfile.writeln("showphotons 0;");
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

        ::krayfile.writeln("causticspm "+(kray25_v_cf*tsign)+","+kray25_v_cn+",_gi_res*"+kray25_v_cpstart+",");
        ::krayfile.writeln("_gi_res*"+kray25_v_cpstop+","+kray25_v_cpstep+",__caustics_try;");

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
            ::krayfile.writeln("globalpm "+(kray25_v_gf*tsign)+","+kray25_v_gn+",_gi_res*"+kray25_v_gpstart+",");
            ::krayfile.writeln("_gi_res*"+tstop+","+kray25_v_gpstep+";");
            } else {
                lmcaustics=0;
                if (kray25_v_gicaustics || kray25_v_gi==2)
                {   // caustics enabled or estimate mode
                    lmcaustics=kray25_v_ppcaustics;
                }
            ::krayfile.writeln("globallm "+(kray25_v_gf*tsign)+","+kray25_v_gn+",_gi_res*"+kray25_v_gpstart+",");
            ::krayfile.writeln("_gi_res*"+tstop+","+kray25_v_gpstep+","+lmcaustics+";");
        }

        ::krayfile.writeln("precachedpm _gi_res*__ppscale*"+kray25_v_ppsize+",_gi_res*__ppscale*__ppstop,");
        ::krayfile.writeln("__ppstep,__precacheN,_gi_res*"+kray25_v_ppsize+";");
        ::krayfile.writeln("precachedblur "+kray25_v_ppblur+";");
        ::krayfile.writeln("globalmultiplier "+kray25_v_ppmult+";");
        ::krayfile.writeln("causticsmultiplier "+kray25_v_cmult+";");

        if (kray25_v_gmatic)
        {
            ::krayfile.writeln("autophotons global,__autogsamples,"+kray25_v_glow+","+kray25_v_ghigh+","+kray25_v_gdyn+",__autogscale;");
        }
        if (kray25_v_cmatic)
        {
            ::krayfile.writeln("autophotons caustics,__autocsamples,"+kray25_v_clow+","+kray25_v_chigh+","+kray25_v_cdyn+",");
            ::krayfile.writeln("__autocscale;");
        }

        ::krayfile.writeln("irradiancerays "+kray25_v_fgrmin+","+kray25_v_fgrmax+",1,"+kray25_v_fgth+"*"+kray25_v_fgth+";");

        ::krayfile.writeln("pmcorner _gi_res*"+kray25_v_cornerdist+","+kray25_v_cornerpaths+";");

        ::krayfile.writeln("gradients _gi_res*"+kray25_v_fgmax+","+kray25_v_fga+";");
        ::krayfile.writeln("gradients2 _gi_res*"+kray25_v_fgmin+","+kray25_v_fgscale+";");
        ::krayfile.writeln("gradients3 __oversample,"+kray25_v_fgb+"*pi/180;");
        ::krayfile.writeln("gradients4 _gi_res*"+(kray25_v_fgmax*10)+",_gi_res*"+(kray25_v_fgmax*10)+",__irr_elip;");
        ::krayfile.writeln("irradianceblur 0,1+sqr("+kray25_v_fgblur+");");

        if (kray25_v_fgshows!=1)
        {
            clr=kray25_v_fgsclr;
            clr=clr*100;
            r=dot3d(clr,<1,0,0>);
            g=dot3d(clr,<0,1,0>);
            b=dot3d(clr,<0,0,1>);
            if (kray25_v_fgshows==3)
            {
                ::krayfile.writeln("showgisamples ("+(r/255)+","+(g/255)+","+(b/255)+");");
            } else {
                ::krayfile.writeln("showcornersamples ("+(r/255)+","+(g/255)+","+(b/255)+");");
            }
        }

        kray25_dof_active=Scene().renderopts[7];
        mb_active=Scene().renderopts[6];

        if (kray25_dof_active && !kray25_v_aafscreen)
        {
            ::krayfile.writeln("echo '!!! Full screen AA is off. DOF disabled.';");
        }

        if (kray25_v_aatype==1)
        {
            ::krayfile.writeln("imagesampler none;");
        } else {
            if (kray25_v_aafscreen)
            {
                if (kray25_v_aatype==2)
                {
                    if (kray25_v_aagridrotate)
                    {
                        ::krayfile.writeln("imagesampler total_rot_uniform,"+kray25_v_aargsmpl+";");
                    } else {
                        ::krayfile.writeln("imagesampler total_uniform,"+kray25_v_aargsmpl+";");
                    }
                }
                if (kray25_v_aatype==3)
                {
                    if (kray25_v_cstocmin>=kray25_v_cstocmax || kray25_v_cstocvar==0 || mb_active || kray25_dof_active)
                    {   // Added fix for FS#414 check if MB or DOF is on
                        ::krayfile.writeln("imagesampler total_qmc,"+kray25_v_cstocmin+";");
                    } else {
                        ::krayfile.writeln("imagesampler total_qmcadaptive,"+kray25_v_cstocmin+","+kray25_v_cstocmax+","+kray25_v_cstocvar+";");
                    }
                }
                if (kray25_v_aatype==4)
                {
                        if (mb_active)
                        {
                            ::krayfile.writeln("imagesampler total_mb_random,"+kray25_v_aarandsmpl+","+kray25_v_cmbsubframes+";");
                        } else {
                            ::krayfile.writeln("imagesampler total_random,"+kray25_v_aarandsmpl+";");
                        }
                }
            } else {
                if (kray25_v_aatype==2)
                {
                    if (kray25_v_aagridrotate)
                    {
                        ::krayfile.writeln("imagesampler rot_uniform,"+kray25_v_aargsmpl+";");
                    } else {
                        ::krayfile.writeln("imagesampler uniform,"+kray25_v_aargsmpl+";");
                    }
                }
                if (kray25_v_aatype==3)
                {
                    ::krayfile.writeln("imagesampler qmcadaptive,"+kray25_v_cstocmin+","+kray25_v_cstocmax+","+kray25_v_cstocvar+";");
                }
            }
        }

        if (1)
        {
            // edgedetector (deprecated but still working)
            ::krayfile.writeln("edgedetector "+kray25_v_edgeabs+","+kray25_v_edgerel+","+kray25_v_edgenorm+","+kray25_v_edgezbuf+",");
            ::krayfile.writeln(""+kray25_v_edgethick+","+kray25_v_edgeover+","+kray25_v_edgeup+";");
        } else {
            // edgedetector (new)
            ::krayfile.writeln("edgedetectorglobals "+kray25_v_edgethick+","+kray25_v_edgeup+";");
            ::krayfile.writeln("edgedetectorslot 0,"+kray25_v_edgeabs+","+kray25_v_edgerel+","+kray25_v_edgenorm+","+kray25_v_edgezbuf+",");
            ::krayfile.writeln(""+kray25_v_edgeover+";");
        }

        // pixel filter
        switch(kray25_v_pxlfltr)
        {
            case 1:
                ::krayfile.writeln("pixelfilter box,"+kray25_v_pxlparam+";");
                break;
            case 2:
                ::krayfile.writeln("pixelfilter cone,"+kray25_v_pxlparam+";");
                break;
            case 3:
                ::krayfile.writeln("pixelfilter cubic,"+kray25_v_pxlparam+";");
                break;
            case 4:
                ::krayfile.writeln("pixelfilter quadric,"+kray25_v_pxlparam+";");
                break;
            case 5:
                ::krayfile.writeln("pixelfilter lanczos,"+kray25_v_pxlparam+";");
                break;
            case 6:
                ::krayfile.writeln("pixelfilter mitchell;");
                break;
            case 7:
                ::krayfile.writeln("pixelfilter spline;");
                break;
            case 8:
                ::krayfile.writeln("pixelfilter catmull;");
                break;
        }

        camera_write="";
        switch(kray25_v_cptype)
        {
            case 1:
                break;
            case 2:
                ::krayfile.writeln("lwcammode 1;");
                break;
            case 3:
                ::krayfile.writeln("lwcammode 4;");
                break;
            case 4:
                ::krayfile.writeln("lwcammode 3;");

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

                ::krayfile.writeln("multiline 'TextureBaker';");
                ::krayfile.writeln("camera mesh,'");
                
                mlsize=size(kray25_v_camobjectfile);
                for (a=1 ; a<=mlsize ; a+=::maxlinelength)
                {
                    t=a+::maxlinelength;
                    if (t>(mlsize+1))
                    {
                        t=mlsize+1;
                    }
                    t=-a+t;
                    ::krayfile.writeln(strsub(kray25_v_camobjectfile,a,t));
                }           
                ::krayfile.writeln("',"+kray25_v_camobject+",'"+kray25_v_camuvname+"',0,0,(0,0,0),<>;");
                ::krayfile.writeln("end_of_multiline;");
                break;
            case 5:
                ::krayfile.writeln("lwcammode 8;camera stereo,0,0,0,(0,0,0),<>,"+kray25_v_eyesep+","+kray25_v_stereoimages+";");
                break;
        }

        if (kray25_v_lenspict!="" && kray25_dof_active)
        {
            ::krayfile.writeln("echo '*** Loading lens bitmap';");
            ::krayfile.writeln("multiline 'LensImage';");
            ::krayfile.writeln("pixmap __lens_bitmap,'");
            
            mlsize=size(kray25_v_lenspict);
            for (a=1 ; a<=mlsize ; a+=::maxlinelength)
            {
                t=a+::maxlinelength;
                if (t>(mlsize+1))
                {
                    t=mlsize+1;
                }
                t=-a+t;
                ::krayfile.writeln(strsub(kray25_v_lenspict,a,t));
            }

            ::krayfile.writeln("',0;");
            ::krayfile.writeln("end_of_multiline;");
            ::krayfile.writeln("lensbitmap __lens_bitmap;");
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
            ::krayfile.writeln("lwdoftargetobject "+index+";");
        }

    ::krayfile.writeln("remglobalpm 1;");
    ::krayfile.writeln("pmsidethreshold 0.5;");
    ::krayfile.writeln("octcache 3;");
    kray25_v_errode = kray25_v_errode + (-1);
    ::krayfile.writeln("postprocess erode," +kray25_v_errode+ ";");
        

    if (kray25_v_LogOn)
    {
        ::krayfile.writeln("logfile '" +kray25_v_Logfile+ "';");
    }
    if (kray25_v_Debug)
    {
        ::krayfile.writeln("debug -1;");
    }
    if (kray25_v_InfoOn)
    {
        ::krayfile.writeln("renderinfo '" +kray25_v_InfoText+ "';");
    }
    if (kray25_v_IncludeOn)
    {
        ::krayfile.writeln("include '" +kray25_v_IncludeFile+ "';");
    }
    if (kray25_v_FullPrev)
    {
        ::krayfile.writeln("previewsize 99999,99999;");
    }
    if (kray25_v_Finishclose)
    {
        ::krayfile.writeln("finishclose;");
    }
    if (kray25_v_UBRAGI)
    {
        ::krayfile.writeln("lwo2unseenbyrays_affectsgi 0;");
    }
    if (kray25_v_outputtolw)
    {
        ::krayfile.writeln("outputtolw 1;");
    }

    ::krayfile.writeln("multiline 'Tailer commands';");
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
        ::krayfile.writeln(strsub(kray25_v_postscript,a,t));
    }
    ::krayfile.writeln(";");
    ::krayfile.writeln("end_of_multiline;");
    ::krayfile.writeln("end;");
}

addKrayRenderer
{
    /* Anticipating a structure like :
    ExternalRenderer KrayRenderer
    Plugin ExtRendererHandler 1 KrayRenderer
    EndPlugin
    */

    // Check if we have any external renderer configured.
    rendererCheck = getRendererPluginLine("any", ::newScenePath);
    if(rendererCheck)
    {
        krayRPCheck = getRendererPluginLine("KrayRenderer", ::newScenePath);
    }
    if(!krayRPCheck)
    {
        if (rendererCheck)
        {
            strip3rdPartyRenderers();
        }
        output = File(::newScenePath, "a");
        output.writeln("");
        output.writeln("ExternalRenderer KrayRenderer");
        output.writeln("Plugin ExtRendererHandler 1 KrayRenderer");
        output.writeln("EndPlugin");
        output.close();
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

