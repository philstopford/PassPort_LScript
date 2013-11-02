// native renderer globals

// scnMaster override UI stuff
scnmasterOverride_UI_native: action
{
    // sel only used in edit action.
    // action should be either 'new' or 'edit'
    if (action == "new" || action == "edit")
    {
        if(action == "edit")
        {
            sel = getvalue(gad_OverridesListview).asInt();
            ::settingsArray = parseOverrideSettings(::overrideSettings[sel]);
            ::overrideRenderer            = integer(::settingsArray[3]);
            renderModeSetts             = integer(::settingsArray[4]);
            depthBufferAASetts          = integer(::settingsArray[5]);
            renderLinesSetts            = integer(::settingsArray[6]);
            rayRecursionLimitSetts      = integer(::settingsArray[7]);
            redirectBuffersSetts        = integer(::settingsArray[8]);
            disableAASetts              = integer(::settingsArray[9]);
            raytraceShadows             = integer(::settingsArray[10]);
            raytraceReflect             = integer(::settingsArray[11]);
            raytraceRefract             = integer(::settingsArray[12]);
            raytraceTrans               = integer(::settingsArray[13]);
            raytraceOccl                = integer(::settingsArray[14]);
            volumetricAA                = integer(::settingsArray[15]);
            gLensFlares                 = integer(::settingsArray[16]);
            shadowMaps                  = integer(::settingsArray[17]);
            volLights                   = integer(::settingsArray[18]);
            twoSidedALgts               = integer(::settingsArray[19]);
            renderInstances             = integer(::settingsArray[20]);
            rayPrecision                = number(::settingsArray[21]);
            rayCutoff                   = number(::settingsArray[22]);
            shadingSamples              = integer(::settingsArray[23]);
            lightSamples                = integer(::settingsArray[24]);
            gLightIntensity             = number(::settingsArray[25]);
            gFlareIntensity             = number(::settingsArray[26]);
            enableGI                    = integer(::settingsArray[27]);
            giMode                      = integer(::settingsArray[28]);
            interpolateGI               = integer(::settingsArray[29]);
            blurBGGI                    = integer(::settingsArray[30]);
            transparencyGI              = integer(::settingsArray[31]);
            volumetricGI                = integer(::settingsArray[32]);
            ambOcclGI                   = integer(::settingsArray[33]);
            directionalGI               = integer(::settingsArray[34]);
            gradientsGI                 = integer(::settingsArray[35]);
            behindTestGI                = integer(::settingsArray[36]);
            useBumpsGI                  = integer(::settingsArray[37]);
            giIntensity                 = number(::settingsArray[38]);
            giAngTol                    = number(::settingsArray[39]);
            giIndBounces                = integer(::settingsArray[40]);
            giMinSpacing                = number(::settingsArray[41]);
            giRPE                       = integer(::settingsArray[42]);
            giMaxSpacing                = number(::settingsArray[43]);
            gi2ndBounces                = integer(::settingsArray[44]);
            giMultiplier                = number(::settingsArray[45]);
            enableCaustics              = integer(::settingsArray[46]);
            causticsAccuracy            = integer(::settingsArray[47]);
            causticsIntensity           = number(::settingsArray[48]);
            causticsSoftness            = integer(::settingsArray[49]);
            fiberFXSaveRGBA             = integer(::settingsArray[50]);
            fiberFXSaveRGBAType         = integer(::settingsArray[51]);
            fiberFXSaveRGBAName         = string(::settingsArray[52]);
            fiberFXSaveDepth            = integer(::settingsArray[53]);
            fiberFXSaveDepthType        = integer(::settingsArray[54]);
            fiberFXSaveDepthName        = string(::settingsArray[55]);
            // fog
            fogType                     = integer(::settingsArray[56]);
            fogColorArray               = <integer(::settingsArray[57]), integer(::settingsArray[58]), integer(::settingsArray[59])>;
            fogBackdropColor            = integer(::settingsArray[60]);
            // compositing
            useBackgroundColor          = integer(::settingsArray[61]);
            backgroundColorArray        = <integer(::settingsArray[62]), integer(::settingsArray[63]), integer(::settingsArray[64])>;
            // backdrop
            backdropColorArray          = <integer(::settingsArray[65]), integer(::settingsArray[66]), integer(::settingsArray[67])>;
            zenithColorArray            = <integer(::settingsArray[68]), integer(::settingsArray[69]), integer(::settingsArray[70])>;
            skyColorArray               = <integer(::settingsArray[71]), integer(::settingsArray[72]), integer(::settingsArray[73])>;
            groundColorArray            = <integer(::settingsArray[74]), integer(::settingsArray[75]), integer(::settingsArray[76])>;
            nadirColorArray             = <integer(::settingsArray[77]), integer(::settingsArray[78]), integer(::settingsArray[79])>;
            useSolidBackdrop            = integer(::settingsArray[80]);

            adaptiveSampling            = integer(::settingsArray[81]);
            for(i = 1; i <= 8; i++)
            {
                radFlags_Array[i] = integer(::settingsArray[81 + i]);
            }
            activeCameraID              = integer(::settingsArray[90]);
        }
    
        ::doKeys = 0;

        reqbeginstr = "New Scene Master Override";
        if(action == "edit")
        {
            reqbeginstr = "Edit Scene Master Override";
        }
        reqbegin(reqbeginstr);
        reqsize(::ScnMst_ui_window_w, 725);
        reqredraw("scnmasterOverride_UI_native_redraw");

        newName = "SceneMasterOverride";
        if(action == "edit")
        {
            newName = ::settingsArray[1];
        }
        c20 = ctlstring("Override Name:",newName);
        ctlposition(c20, ::ScnMst_gad_x2, ::ScnMst_gad_y, ::ScnMst_gad_w, ::ScnMst_gad_h, ::ScnMst_gad_text_offset);
        
        ui_offset_y = ::ScnMst_ui_offset_y + ::ScnMst_ui_row_offset;

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
        if(passCamArrayIndex == 1)
        {
            passCamNameArray = @"No camera found in pass!"@;
        }

        activeCameraID = ::masterScene.renderCamera(0).id;
        if(action == "edit")
        {
            activeCameraID = integer(::settingsArray[90]);
        }
        activeCamera = 0; // will map to first camera.
        counter = 0;
        for (i = 1; i <= passCamIDArray.size(); i++)
        {
            if(passCamIDArray[i] == activeCameraID)
            {
                activeCamera = counter;
            }
            counter++;
        }
        if(activeCamera != 0)
        {
            activeCamera += 1; // Need to increment by one due to 1-based array and 0-based UI
        }
        c90 = ctlpopup("Active Camera",activeCamera,passCamNameArray);
        ctlposition(c90, ::ScnMst_gad_x, ::ScnMst_gad_y + ui_offset_y, ::ScnMst_gad_w, ::ScnMst_gad_h, ::ScnMst_gad_text_offset);

        renderModeSetts = 3;
        if(action == "edit")
        {
            renderModeSetts = integer(::settingsArray[4]);
        }
        c21 = ctlpopup("Render Mode",renderModeSetts,::renderModeArray);
        ctlposition(c21, ::ScnMst_gad_x2, ::ScnMst_gad_y + ui_offset_y, ::ScnMst_gad_w, ::ScnMst_gad_h, ::ScnMst_gad_text_offset);

        fogType = 0;
        if(action == "edit")
        {
            fogType = integer(::settingsArray[56]);
        }
        c73 = ctlpopup("Fog Type",fogType,::fogTypeArray);
        ctlposition(c73, ::ScnMst_gad_x3, ::ScnMst_gad_y + ui_offset_y, ::ScnMst_gad_w, ::ScnMst_gad_h, ::ScnMst_gad_text_offset);

        ::ScnMst_dividerline_y1 = ::ScnMst_gad_y + ui_offset_y;

        ui_offset_y += ::ScnMst_ui_row_offset;

        c27val = 1;
        if(action == "edit")
        {
            c27val = raytraceShadows;
        }
        c27 = ctlcheckbox("RT Shadows",c27val);
        ctlposition(c27, ::ScnMst_gad_x, ::ScnMst_gad_y + ui_offset_y, ::ScnMst_gad_w, ::ScnMst_gad_h, ::ScnMst_gad_text_offset);

        c30val = 1;
        if(action == "edit")
        {
            c30val = raytraceReflect;
        }
        c30 = ctlcheckbox("RT Reflection",c30val);
        ctlposition(c30, ::ScnMst_gad_x2, ::ScnMst_gad_y + ui_offset_y, ::ScnMst_gad_w, ::ScnMst_gad_h, ::ScnMst_gad_text_offset);

        c74val = 255;
        if(action == "edit")
        {
            c74val = fogColorArray;
        }
        c74 = ctlcolor("Fog Color", c74val);
        ctlposition(c74, ::ScnMst_gad_x3, ::ScnMst_gad_y + ui_offset_y, ::ScnMst_gad_w, ::ScnMst_gad_h, ::ScnMst_gad_text_offset);

        ui_offset_y += ::ScnMst_ui_row_offset;

        c28val = 1;
        if(action == "edit")
        {
            c28val = raytraceTrans;
        }
        c28 = ctlcheckbox("RT Transparency",c28val);
        ctlposition(c28, ::ScnMst_gad_x, ::ScnMst_gad_y + ui_offset_y, ::ScnMst_gad_w, ::ScnMst_gad_h, ::ScnMst_gad_text_offset);

        c29val = 1;
        if(action == "edit")
        {
            c29val = raytraceRefract;
        }
        c29 = ctlcheckbox("RT Refraction",c29val);
        ctlposition(c29, ::ScnMst_gad_x2, ::ScnMst_gad_y + ui_offset_y, ::ScnMst_gad_w, ::ScnMst_gad_h, ::ScnMst_gad_text_offset);

        c75val = 0;
        if(action == "edit")
        {
            c75val = fogBackdropColor;
        }
        c75 = ctlcheckbox("Use Backdrop Color",c75val);
        ctlposition(c75, ::ScnMst_gad_x3, ::ScnMst_gad_y + ui_offset_y, ::ScnMst_gad_w, ::ScnMst_gad_h, ::ScnMst_gad_text_offset);

        ui_offset_y += ::ScnMst_ui_row_offset;

        c31val = 0;
        if(action == "edit")
        {
            c31val = raytraceOccl;
        }
        c31 = ctlcheckbox("RT Occlusion",c31val);
        ctlposition(c31, ::ScnMst_gad_x, ::ScnMst_gad_y + ui_offset_y, ::ScnMst_gad_w, ::ScnMst_gad_h, ::ScnMst_gad_text_offset);

        c22val = 0;
        if(action == "edit")
        {
            c22val = depthBufferAASetts;
        }
        c22 = ctlcheckbox("Depth Buffer AA",c22val);
        ctlposition(c22, ::ScnMst_gad_x2, ::ScnMst_gad_y + ui_offset_y, ::ScnMst_gad_w, ::ScnMst_gad_h, ::ScnMst_gad_text_offset);

        ui_offset_y += ::ScnMst_ui_row_offset;

        c23val = 1;
        if(action == "edit")
        {
            c23val = renderLinesSetts;
        }
        c23 = ctlcheckbox("Render Lines",c23val);
        ctlposition(c23, ::ScnMst_gad_x, ::ScnMst_gad_y + ui_offset_y, ::ScnMst_gad_w, ::ScnMst_gad_h, ::ScnMst_gad_text_offset);

        c37val = 1;
        if(action == "edit")
        {
            c37val = renderInstances;
        }
        if(hostVersion() >= 11.5) // feature only added in 11.5
        {
            c37 = ctlcheckbox("Render Instances",c37val);
            ctlposition(c37, ::ScnMst_gad_x2, ::ScnMst_gad_y + ui_offset_y, ::ScnMst_gad_w, ::ScnMst_gad_h, ::ScnMst_gad_text_offset);
        }

        ui_offset_y += ::ScnMst_ui_row_offset + 2;
        sep1 = ctlsep(0, ::ScnMst_ui_seperator_w - 10);
        ctlposition(sep1, -2, ::ScnMst_gad_y + ui_offset_y);
        ui_offset_y += ::ScnMst_ui_spacing_y + 2;

        c24val= 16;
        if(action == "edit")
        {
            c24val = rayRecursionLimitSetts;
        }
        c24 = ctlminislider("Ray Recursion Limit", c24val, 0, ::LWrecursionLimit);
        ctlposition(c24, ::ScnMst_gad_x, ::ScnMst_gad_y + ui_offset_y, ::ScnMst_gad_w - 22, ::ScnMst_gad_h, ::ScnMst_gad_text_offset);

        c40val = 1;  // 11.0 uses 8, 11.5 uses 1
        if(hostVersion() < 11.5)
            c40val = 8;
        if(action == "edit")
        {
            c40val = shadingSamples;
        }
        c40 = ctlnumber("Shading Samples:",c40val);
        ctlposition(c40, ::ScnMst_gad_x2, ::ScnMst_gad_y + ui_offset_y, ::ScnMst_gad_w, ::ScnMst_gad_h, ::ScnMst_gad_text_offset);

        compLabel = ctltext("", "Compositing");
        ctlposition(compLabel, ::ScnMst_gad_x3, ::ScnMst_gad_y + ui_offset_y, ::ScnMst_gad_w, ::ScnMst_gad_h, ::ScnMst_gad_text_offset);

        c76val = 0;
        if(action == "edit")
        {
            c76val = useBackgroundColor;
        }
        c76 = ctlcheckbox("Use Background Color",c76val);
        ctlposition(c76, ::ScnMst_gad_x3, ::ScnMst_gad_y + ui_offset_y, ::ScnMst_gad_w, ::ScnMst_gad_h, ::ScnMst_gad_text_offset);

        ui_offset_y += ::ScnMst_ui_row_offset;
        
        c38val = 6.0;
        if(action == "edit")
        {
            c38val = rayPrecision;
        }
        c38 = ctlnumber("Ray Precision:",c38val);
        ctlposition(c38, ::ScnMst_gad_x, ::ScnMst_gad_y + ui_offset_y, ::ScnMst_gad_w, ::ScnMst_gad_h, ::ScnMst_gad_text_offset);

        c41val = 1;  // 11.0 uses 8, 11.5 uses 1
        if(hostVersion() < 11.5)
            c41val = 8;
        if(action == "edit")
        {
            c41val = lightSamples;
        }
        c41 = ctlnumber("Light Samples:",c41val);
        ctlposition(c41, ::ScnMst_gad_x2, ::ScnMst_gad_y + ui_offset_y, ::ScnMst_gad_w, ::ScnMst_gad_h, ::ScnMst_gad_text_offset);

        c77val = 0;
        if(action == "edit")
        {
            c77val = backgroundColorArray;
        }
        c77 = ctlcolor("BG Color", c77val);
        ctlposition(c77, ::ScnMst_gad_x3, ::ScnMst_gad_y + ui_offset_y, ::ScnMst_gad_w, ::ScnMst_gad_h, ::ScnMst_gad_text_offset);

        ui_offset_y += ::ScnMst_ui_row_offset;
        
        c39val = 0.01;
        if(action == "edit")
        {
            c39val = rayCutoff;
        }
        c39 = ctlnumber("Ray Cutoff:",c39val);
        ctlposition(c39, ::ScnMst_gad_x, ::ScnMst_gad_y + ui_offset_y, ::ScnMst_gad_w, ::ScnMst_gad_h, ::ScnMst_gad_text_offset);

        ui_offset_y += ::ScnMst_ui_row_offset + 2;
        sep2 = ctlsep(0, ::ScnMst_ui_seperator_w - 10);
        ctlposition(sep2, -2, ::ScnMst_gad_y + ui_offset_y);
        ui_offset_y += ::ScnMst_ui_spacing_y + 2;

        c25val = 0;
        if(action == "edit")
        {
            c25val = redirectBuffersSetts;
        }
        c25 = ctlcheckbox("Redirect Buffer Export Paths",c25val);
        ctlposition(c25, ::ScnMst_gad_x, ::ScnMst_gad_y + ui_offset_y, ::ScnMst_gad_w, ::ScnMst_gad_h, ::ScnMst_gad_text_offset);

        c26val = 0;
        if(action == "edit")
        {
            c26val = disableAASetts;
        }
        c26 = ctlcheckbox("Disable all AA",c26val);
        ctlposition(c26, ::ScnMst_gad_x2, ::ScnMst_gad_y + ui_offset_y, ::ScnMst_gad_w, ::ScnMst_gad_h, ::ScnMst_gad_text_offset);

        ui_offset_y += ::ScnMst_ui_row_offset;

        c79val = 1;
        if(action == "edit")
        {
            c79val = adaptiveSampling;
        }
        c79 = ctlcheckbox("Adaptive Sampling AA",c79val);
        ctlposition(c79, ::ScnMst_gad_x, ::ScnMst_gad_y + ui_offset_y, ::ScnMst_gad_w, ::ScnMst_gad_h, ::ScnMst_gad_text_offset);

        c32val = 1;
        if(action == "edit")
        {
            c32val = volumetricAA;
        }
        c32 = ctlcheckbox("Volumetric AA",c32val);
        ctlposition(c32, ::ScnMst_gad_x2, ::ScnMst_gad_y + ui_offset_y, ::ScnMst_gad_w, ::ScnMst_gad_h, ::ScnMst_gad_text_offset);

        ui_offset_y += ::ScnMst_ui_row_offset + 2;
        sep3 = ctlsep(0, ::ScnMst_ui_seperator_w - 10);
        ctlposition(sep3, -2, ::ScnMst_gad_y + ui_offset_y);
        ui_offset_y += ::ScnMst_ui_spacing_y + 2;

        c42val = 1.0;
        if(action == "edit")
        {
            c42val = gLightIntensity;
        }
        c42 = ctlpercent("Light Intensity",c42val);
        ctlposition(c42, ::ScnMst_gad_x, ::ScnMst_gad_y + ui_offset_y, ::ScnMst_gad_w - 22, ::ScnMst_gad_h, ::ScnMst_gad_text_offset);

        c43val = 1.0;
        if(action == "edit")
        {
            c43val = gFlareIntensity;
        }
        c43 = ctlpercent("Flare Intensity",c43val);
        ctlposition(c43, ::ScnMst_gad_x2, ::ScnMst_gad_y + ui_offset_y, ::ScnMst_gad_w - 22, ::ScnMst_gad_h, ::ScnMst_gad_text_offset);

        ui_offset_y += ::ScnMst_ui_row_offset;

        c33val = 1;
        if(action == "edit")
        {
            c33val = gLensFlares;
        }
        c33 = ctlcheckbox("Lens Flares",c33val);
        ctlposition(c33, ::ScnMst_gad_x, ::ScnMst_gad_y + ui_offset_y, ::ScnMst_gad_w, ::ScnMst_gad_h, ::ScnMst_gad_text_offset);
        
        c34val = 1;
        if(action == "edit")
        {
            c34val = shadowMaps;
        }
        c34 = ctlcheckbox("Shadow Maps",c34val);
        ctlposition(c34, ::ScnMst_gad_x2, ::ScnMst_gad_y + ui_offset_y, ::ScnMst_gad_w, ::ScnMst_gad_h, ::ScnMst_gad_text_offset);

        ui_offset_y += ::ScnMst_ui_row_offset;

        c35val = 1;
        if(action == "edit")
        {
            c35val = volLights;
        }
        c35 = ctlcheckbox("Volumetric Lights",c35val);
        ctlposition(c35, ::ScnMst_gad_x, ::ScnMst_gad_y + ui_offset_y, ::ScnMst_gad_w, ::ScnMst_gad_h, ::ScnMst_gad_text_offset);

        c36val = 1;
        if(action == "edit")
        {
            c36val = twoSidedALgts;
        }
        c36 = ctlcheckbox("2 Sided Area Lights",c36val);
        ctlposition(c36, ::ScnMst_gad_x2, ::ScnMst_gad_y + ui_offset_y, ::ScnMst_gad_w, ::ScnMst_gad_h, ::ScnMst_gad_text_offset);

        ui_offset_y += ::ScnMst_ui_row_offset + 2;
        sep4 = ctlsep(0, ::ScnMst_ui_seperator_w - 10);
        ctlposition(sep4, -2, ::ScnMst_gad_y + ui_offset_y);
        ui_offset_y += ::ScnMst_ui_spacing_y + 2;

        c44val = 0;
        if(action == "edit")
        {
            c44val = enableGI;
        }
        c44 = ctlcheckbox("Enable Radiosity",c44val);
        ctlposition(c44, ::ScnMst_gad_x, ::ScnMst_gad_y + ui_offset_y, ::ScnMst_gad_w, ::ScnMst_gad_h, ::ScnMst_gad_text_offset);

        c45val = 2; // default to MC, matching LW.
        if(action == "edit")
        {
            c45val = giMode;
        }
        c45 = ctlpopup("Render Mode",c45val,::giTypeArray);
        ctlposition(c45, ::ScnMst_gad_x2, ::ScnMst_gad_y + ui_offset_y, ::ScnMst_gad_w, ::ScnMst_gad_h, ::ScnMst_gad_text_offset);

        c78val = 0;
        if(action == "edit")
        {
            c78val = backdropColorArray;
        }
        c78 = ctlcolor("Backdrop Color", c78val);
        ctlposition(c78, ::ScnMst_gad_x3, ::ScnMst_gad_y + ui_offset_y, ::ScnMst_gad_w, ::ScnMst_gad_h, ::ScnMst_gad_text_offset);

        ui_offset_y += ::ScnMst_ui_row_offset;

        c46val = 1; // Match LW
        if(action == "edit")
        {
            c46val = interpolateGI;
        }
        c46 = ctlcheckbox("Interpolated",c46val);
        ctlposition(c46, ::ScnMst_gad_x, ::ScnMst_gad_y + ui_offset_y, ::ScnMst_gad_w, ::ScnMst_gad_h, ::ScnMst_gad_text_offset);

        c47val = 1; // Match LW
        if(action == "edit")
        {
            c47val = blurBGGI;
        }
        c47 = ctlcheckbox("Blur Background",c47val);
        ctlposition(c47, ::ScnMst_gad_x2, ::ScnMst_gad_y + ui_offset_y, ::ScnMst_gad_w, ::ScnMst_gad_h, ::ScnMst_gad_text_offset);

        c80val = 0;
        if(action == "edit")
        {
            c80val = useSolidBackdrop;
        }
        c80 = ctlcheckbox("Use Gradient Backdrop", c80val);
        ctlposition(c80, ::ScnMst_gad_x3, ::ScnMst_gad_y + ui_offset_y, ::ScnMst_gad_w, ::ScnMst_gad_h, ::ScnMst_gad_text_offset);

        ui_offset_y += ::ScnMst_ui_row_offset;
        
        c48val = 0; // Match LW
        if(action == "edit")
        {
            c48val = transparencyGI;
        }
        c48 = ctlcheckbox("Use Transparency",c48val);
        ctlposition(c48, ::ScnMst_gad_x, ::ScnMst_gad_y + ui_offset_y, ::ScnMst_gad_w, ::ScnMst_gad_h, ::ScnMst_gad_text_offset);

        c49val = 0; // Match LW
        if(action == "edit")
        {
            c49val = volumetricGI;
        }
        c49 = ctlcheckbox("Volumetric Radiosity",c49val);
        ctlposition(c49, ::ScnMst_gad_x2, ::ScnMst_gad_y + ui_offset_y, ::ScnMst_gad_w, ::ScnMst_gad_h, ::ScnMst_gad_text_offset);

        c81val = <158,188,255>;
        if(action == "edit")
        {
            c81val = zenithColorArray;
        }
        c81 = ctlcolor("Zenith Color", c81val);
        ctlposition(c81, ::ScnMst_gad_x3, ::ScnMst_gad_y + ui_offset_y, ::ScnMst_gad_w, ::ScnMst_gad_h, ::ScnMst_gad_text_offset);

        ui_offset_y += ::ScnMst_ui_row_offset;
        
        c50val = 0; // Match LW
        if(action == "edit")
        {
            c50val = ambOcclGI;
        }
        c50 = ctlcheckbox("Ambient Occlusion",c50val);
        ctlposition(c50, ::ScnMst_gad_x, ::ScnMst_gad_y + ui_offset_y, ::ScnMst_gad_w, ::ScnMst_gad_h, ::ScnMst_gad_text_offset);
        
        c51val = 0; // Match LW
        if(action == "edit")
        {
            c51val = directionalGI;
        }
        c51 = ctlcheckbox("Directional Rays",c51val);
        ctlposition(c51, ::ScnMst_gad_x2, ::ScnMst_gad_y + ui_offset_y, ::ScnMst_gad_w, ::ScnMst_gad_h, ::ScnMst_gad_text_offset);

        c82val = <225,234,255>;
        if(action == "edit")
        {
            c82val = skyColorArray;
        }
        c82 = ctlcolor("Sky Color", c82val);
        ctlposition(c82, ::ScnMst_gad_x3, ::ScnMst_gad_y + ui_offset_y, ::ScnMst_gad_w, ::ScnMst_gad_h, ::ScnMst_gad_text_offset);

        ui_offset_y += ::ScnMst_ui_row_offset;
        
        c52val = 0; // Match LW
        if(action == "edit")
        {
            c52val = gradientsGI;
        }
        c52 = ctlcheckbox("Use Gradients",c52val);
        ctlposition(c52, ::ScnMst_gad_x, ::ScnMst_gad_y + ui_offset_y, ::ScnMst_gad_w, ::ScnMst_gad_h, ::ScnMst_gad_text_offset);

        c53val = 0; // Match LW
        if(action == "edit")
        {
            c53val = behindTestGI;
        }
        c53 = ctlcheckbox("Use Behind Test",c53val);
        ctlposition(c53, ::ScnMst_gad_x2, ::ScnMst_gad_y + ui_offset_y, ::ScnMst_gad_w, ::ScnMst_gad_h, ::ScnMst_gad_text_offset);

        c83val = <225,234,255>;
        if(action == "edit")
        {
            c83val = groundColorArray;
        }
        c83 = ctlcolor("Ground Color", c83val);
        ctlposition(c83, ::ScnMst_gad_x3, ::ScnMst_gad_y + ui_offset_y, ::ScnMst_gad_w, ::ScnMst_gad_h, ::ScnMst_gad_text_offset);

        ui_offset_y += ::ScnMst_ui_row_offset;

        ::radFlags_Array = ::radFlags_Default;
        if(action == "edit")
        {
            for(i = 1; i <= 8; i++)
            {
                ::radFlags_Array[i] = integer(::settingsArray[81 + i]);
            }
        }
        radFlagsButton = ctlbutton("Radiosity Flags", ::ScnMst_gad_w, "radFlags");
        ctlposition(radFlagsButton, ::ScnMst_gad_x, ::ScnMst_gad_y + ui_offset_y, ::ScnMst_gad_w, ::ScnMst_gad_h, ::ScnMst_gad_text_offset);

        c54val = 0; // Match LW
        if(action == "edit")
        {
            c54val = useBumpsGI;
        }
        c54 = ctlcheckbox("Use Bumps",c54val);
        ctlposition(c54, ::ScnMst_gad_x2, ::ScnMst_gad_y + ui_offset_y, ::ScnMst_gad_w, ::ScnMst_gad_h, ::ScnMst_gad_text_offset);

        c84val = <31,24,21>;
        if(action == "edit")
        {
            c84val = nadirColorArray;
        }
        c84 = ctlcolor("Nadir Color", c84val);
        ctlposition(c84, ::ScnMst_gad_x3, ::ScnMst_gad_y + ui_offset_y, ::ScnMst_gad_w, ::ScnMst_gad_h, ::ScnMst_gad_text_offset);

        ui_offset_y += ::ScnMst_ui_row_offset;
        
        c55val = 1.0; // Match LW
        if(action == "edit")
        {
            c55val = giIntensity;
        }
        c55 = ctlpercent("Intensity",c55val);
        ctlposition(c55, ::ScnMst_gad_x, ::ScnMst_gad_y + ui_offset_y, ::ScnMst_gad_w - 22, ::ScnMst_gad_h, ::ScnMst_gad_text_offset);

        //FIXME - this might be totally broken - see comments below.
        c56val = 45.0;              // LW maps 0-90 degrees as 0-1.0.
                                    // 90 degrees is 0.5*pi, but LW insists on 1.0. Have to bodge it.
        if(action == "edit")
        {
            c56val = giAngTol;
        }
        c56 = ctlangle("Angular Tolerance",c56val);
        ctlposition(c56, ::ScnMst_gad_x2, ::ScnMst_gad_y + ui_offset_y, ::ScnMst_gad_w - 22, ::ScnMst_gad_h, ::ScnMst_gad_text_offset);

        ui_offset_y += ::ScnMst_ui_row_offset;
        
        c57val = 1; // Match LW
        if(action == "edit")
        {
            c57val = giIndBounces;
        }
        c57 = ctlpercent("Indirect Bounces",c57val);
        ctlposition(c57, ::ScnMst_gad_x, ::ScnMst_gad_y + ui_offset_y, ::ScnMst_gad_w - 22, ::ScnMst_gad_h, ::ScnMst_gad_text_offset);

        c58val = 3.0; // Match LW
        if(action == "edit")
        {
            c58val = giMinSpacing;
        }
        c58 = ctlnumber("Min Pixel Spacing",c58val);
        ctlposition(c58, ::ScnMst_gad_x2, ::ScnMst_gad_y + ui_offset_y, ::ScnMst_gad_w, ::ScnMst_gad_h, ::ScnMst_gad_text_offset);

        ui_offset_y += ::ScnMst_ui_row_offset;
        
        c59val = 100; // Match LW
        if(action == "edit")
        {
            c59val = giRPE;
        }
        c59 = ctlinteger("Rays/Evaluation",c59val);
        ctlposition(c59, ::ScnMst_gad_x, ::ScnMst_gad_y + ui_offset_y, ::ScnMst_gad_w, ::ScnMst_gad_h, ::ScnMst_gad_text_offset);
        
        c60val = 100.0; // Match LW
        if(action == "edit")
        {
            c60val = giMaxSpacing;
        }
        c60 = ctlnumber("Max Pixel Spacing",c60val);
        ctlposition(c60, ::ScnMst_gad_x2, ::ScnMst_gad_y + ui_offset_y, ::ScnMst_gad_w, ::ScnMst_gad_h, ::ScnMst_gad_text_offset);
        
        ui_offset_y += ::ScnMst_ui_row_offset;
        
        c61val = 50; // Match LW
        if(action == "edit")
        {
            c61val = gi2ndBounces;
        }
        c61 = ctlinteger("Secondary Bounce Rays",c61val);
        ctlposition(c61, ::ScnMst_gad_x, ::ScnMst_gad_y + ui_offset_y, ::ScnMst_gad_w, ::ScnMst_gad_h, ::ScnMst_gad_text_offset);

        c62val = 1.0; // Match LW
        if(action == "edit")
        {
            c62val = giMultiplier;
        }
        c62 = ctlpercent("Multiplier",c62val);
        ctlposition(c62, ::ScnMst_gad_x2, ::ScnMst_gad_y + ui_offset_y, ::ScnMst_gad_w - 22, ::ScnMst_gad_h, ::ScnMst_gad_text_offset);
        
        ui_offset_y += ::ScnMst_ui_row_offset + 2;
        sep5 = ctlsep(0, ::ScnMst_ui_seperator_w - 10);
        ctlposition(sep5, -2, ::ScnMst_gad_y + ui_offset_y);
        ui_offset_y += ::ScnMst_ui_spacing_y + 2;

        c63val = 0;
        if(action == "edit")
        {
            c63val = enableCaustics;
        }
        c63 = ctlcheckbox("Enable Caustics",c63val);
        ctlposition(c63, ::ScnMst_gad_x, ::ScnMst_gad_y + ui_offset_y, ::ScnMst_gad_w, ::ScnMst_gad_h, ::ScnMst_gad_text_offset);

        c64val = 100;
        if(action == "edit")
        {
            c64val = causticsAccuracy;
        }
        c64 = ctlinteger("Caustics Accuracy",c64val);
        ctlposition(c64, ::ScnMst_gad_x2, ::ScnMst_gad_y + ui_offset_y, ::ScnMst_gad_w, ::ScnMst_gad_h, ::ScnMst_gad_text_offset);

        ui_offset_y += ::ScnMst_ui_row_offset;

        c65val = 1.0;
        if(action == "edit")
        {
            c65val = causticsIntensity;
        }
        c65 = ctlpercent("Caustics Intensity",c65val);
        ctlposition(c65, ::ScnMst_gad_x, ::ScnMst_gad_y + ui_offset_y, ::ScnMst_gad_w - 22, ::ScnMst_gad_h, ::ScnMst_gad_text_offset);

        c66val = 20;
        if(action == "edit")
        {
            c66val = causticsSoftness;
        }
        c66 = ctlinteger("Caustics Softness",c66val);
        ctlposition(c66, ::ScnMst_gad_x2, ::ScnMst_gad_y + ui_offset_y, ::ScnMst_gad_w, ::ScnMst_gad_h, ::ScnMst_gad_text_offset);

        ui_offset_y += ::ScnMst_ui_row_offset + 2;
        sep6 = ctlsep(0, ::ScnMst_ui_seperator_w - 10);
        ctlposition(sep6, -2, ::ScnMst_gad_y + ui_offset_y);
        ui_offset_y += ::ScnMst_ui_spacing_y + 4;

        ffxLabel = ctltext("", "FiberFX");
        ctlposition(ffxLabel, ::ScnMst_gad_x, ::ScnMst_gad_y + ui_offset_y, ::ScnMst_gad_w, ::ScnMst_gad_h, ::ScnMst_gad_text_offset);

        ui_offset_y -= 2;

        c67val = 0;
        if(action == "edit")
        {
            c67val = fiberFXSaveRGBA;
        }
        c67 = ctlcheckbox("FFx Save RGBA",c67val);
        ctlposition(c67, ::ScnMst_gad_x, ::ScnMst_gad_y + ui_offset_y, ::ScnMst_gad_w, ::ScnMst_gad_h, ::ScnMst_gad_text_offset);

        c70val = 0;
        if(action == "edit")
        {
            c70val = fiberFXSaveDepth;
        }
        c70 = ctlcheckbox("FFx Save Depth",c70val);
        ctlposition(c70, ::ScnMst_gad_x2, ::ScnMst_gad_y + ui_offset_y, ::ScnMst_gad_w, ::ScnMst_gad_h, ::ScnMst_gad_text_offset);

        ui_offset_y += ::ScnMst_ui_row_offset;

        c68val = 0;
        if(action == "edit")
        {
            c68val = fiberFXSaveRGBAType;
        }
        c68 = ctlpopup("RGBA Type",c68val,::image_formats_array);
        ctlposition(c68, ::ScnMst_gad_x, ::ScnMst_gad_y + ui_offset_y, ::ScnMst_gad_w, ::ScnMst_gad_h, ::ScnMst_gad_text_offset);

        c71val = 0;
        if(action == "edit")
        {
            c71val = fiberFXSaveDepthType;
        }
        c71 = ctlpopup("Depth Type",c71val,::image_formats_array);
        ctlposition(c71, ::ScnMst_gad_x2, ::ScnMst_gad_y + ui_offset_y, ::ScnMst_gad_w, ::ScnMst_gad_h, ::ScnMst_gad_text_offset);

        ui_offset_y += ::ScnMst_ui_row_offset;

        c69val = "*.*";
        if(action == "edit")
        {
            c69val = fiberFXSaveRGBAName;
        }
        c69 = ctlfilename("Save ...", c69val,30,1);
        ctlposition(c69, ::ScnMst_gad_x, ::ScnMst_gad_y + ui_offset_y, ::ScnMst_gad_w - 22, ::ScnMst_gad_h, ::ScnMst_gad_text_offset);

        c72val = "*.*";
        if(action == "edit")
        {
            c72val = fiberFXSaveDepthName;
        }
        c72 = ctlfilename("Save ...", c72val,30,1);
        ctlposition(c72, ::ScnMst_gad_x2, ::ScnMst_gad_y + ui_offset_y, ::ScnMst_gad_w - 22, ::ScnMst_gad_h, ::ScnMst_gad_text_offset);
        ::ScnMst_dividerline_y2 = ::ScnMst_gad_y + ui_offset_y + ::ScnMst_gad_h;

        if(reqpost())
        {
            newName                         = getvalue(c20);
            newName                         = makeStringGood(newName);
            ::overrideRenderer                = 1; // hard-coded.
            renderModeSetts                 = getvalue(c21);
            depthBufferAASetts              = getvalue(c22);
            renderLinesSetts                = getvalue(c23);
            rayRecursionLimitSetts          = getvalue(c24);
            redirectBuffersSetts            = getvalue(c25);
            disableAASetts                  = getvalue(c26);
            raytraceShadows                 = getvalue(c27);
            raytraceTrans                   = getvalue(c28);
            raytraceRefract                 = getvalue(c29);
            raytraceReflect                 = getvalue(c30);
            raytraceOccl                    = getvalue(c31);
            volumetricAA                    = getvalue(c32);
            lensFlares                      = getvalue(c33);
            shadowMaps                      = getvalue(c34);
            volLights                       = getvalue(c35);
            twoSidedALgts                   = getvalue(c36);
            if(hostVersion() < 11.5)
            {
                renderInstances             = 1; // force on in case scene pushed to 11.5 for render, no impact on < 11.5
            } else {
                renderInstances             = getvalue(c37);
            }
            rayPrecision                    = getvalue(c38);
            rayCutoff                       = getvalue(c39);
            shadingSamples                  = getvalue(c40);
            lightSamples                    = getvalue(c41);
            lightIntensity                  = getvalue(c42);
            flareIntensity                  = getvalue(c43);
            enableGI                        = getvalue(c44);
            giMode                          = getvalue(c45);
            interpolateGI                   = getvalue(c46);
            blurBGGI                        = getvalue(c47);
            transparencyGI                  = getvalue(c48);
            volumetricGI                    = getvalue(c49);
            ambOcclGI                       = getvalue(c50);
            directionalGI                   = getvalue(c51);
            gradientsGI                     = getvalue(c52);
            behindTestGI                    = getvalue(c53);
            useBumpsGI                      = getvalue(c54);
            giIntensity                     = getvalue(c55);
            giAngTol                        = getvalue(c56);
            giIndBounces                    = getvalue(c57);
            giMinSpacing                    = getvalue(c58);
            giRPE                           = getvalue(c59);
            giMaxSpacing                    = getvalue(c60);
            gi2ndBounces                    = getvalue(c61);
            giMultiplier                    = getvalue(c62);
            enableCaustics                  = getvalue(c63);
            causticsAccuracy                = getvalue(c64);
            causticsIntensity               = getvalue(c65);
            causticsSoftness                = getvalue(c66);
            fiberFXSaveRGBA                 = getvalue(c67);
            fiberFXSaveRGBAType             = getvalue(c68);
            fiberFXSaveRGBAName             = getvalue(c69);
            fiberFXSaveDepth                = getvalue(c70);
            fiberFXSaveDepthType            = getvalue(c71);
            fiberFXSaveDepthName            = getvalue(c72);
            fogType                         = getvalue(c73);
            fogColorArray                   = getvalue(c74);
            fogBackdropColor                = getvalue(c75);
            useBackgroundColor              = getvalue(c76);
            backgroundColorArray            = getvalue(c77);
            backdropColorArray              = getvalue(c78);
            adaptiveSampling                = getvalue(c79);
            useSolidBackdrop                = getvalue(c80);
            zenithColorArray                = getvalue(c81);
            skyColorArray                   = getvalue(c82);
            groundColorArray                = getvalue(c83);
            nadirColorArray                 = getvalue(c84);

            radFlags_Nodes                  = integer(radFlags_Array[1]);
            radFlags_Cells                  = integer(radFlags_Array[2]);
            radFlags_ColorCells             = integer(radFlags_Array[3]);
            radFlags_Samples                = integer(radFlags_Array[4]);
            radFlags_MissPPSamples          = integer(radFlags_Array[5]);
            radFlags_MissRnSamples          = integer(radFlags_Array[6]);
            radFlags_SecBounce              = integer(radFlags_Array[7]);
            radFlags_Behind                 = integer(radFlags_Array[8]);

            if(!passCamIDArray)
            {
                activeCameraID              = 0;
            } else {
                activeCameraID              = passCamIDArray[getvalue(c90)]; // Offset as UI is 0-based; array is 1-based.
            }

            newNumber = sel;
            if(action == "new")
            {
                ::pass = ::currentChosenPass;
                if(::overrideNames[1] != "empty")
                {
                    newNumber = size(::overrideNames) + 1;
                }
                else
                {
                    newNumber = 1;
                }
                ::passOverrideItems[::pass][newNumber] = "";
                for(y = 1; y <= size(::passNames); y++)
                {
                    ::passOverrideItems[y][newNumber] = "";
                }
            }
            ::overrideNames[newNumber] = newName + "   (scene properties)";
            ::overrideSettings[newNumber] = newName                               +   "||"    + "type6"                           +   "||"
                                        + string(::overrideRenderer)              +   "||"    + string(renderModeSetts)           +   "||"
                                        + string(depthBufferAASetts)            +   "||"    + string(renderLinesSetts)          +   "||"
                                        + string(rayRecursionLimitSetts)        +   "||"    + string(redirectBuffersSetts)      +   "||"
                                        + string(disableAASetts)                +   "||"    + string(raytraceShadows)           +   "||"
                                        + string(raytraceReflect)               +   "||"    + string(raytraceRefract)           +   "||"
                                        + string(raytraceTrans)                 +   "||"    + string(raytraceOccl)              +   "||"
                                        + string(volumetricAA)                  +   "||"    + string(lensFlares)                +   "||"
                                        + string(shadowMaps)                    +   "||"    + string(volLights)                 +   "||"
                                        + string(twoSidedALgts)                 +   "||"    + string(renderInstances)           +   "||"
                                        + string(rayPrecision)                  +   "||"    + string(rayCutoff)                 +   "||"
                                        + string(shadingSamples)                +   "||"    + string(lightSamples)              +   "||"
                                        + string(lightIntensity)                +   "||"    + string(flareIntensity)            +   "||"
                                        + string(enableGI)                      +   "||"    + string(giMode)                    +   "||"
                                        + string(interpolateGI)                 +   "||"    + string(blurBGGI)                  +   "||"
                                        + string(transparencyGI)                +   "||"    + string(volumetricGI)              +   "||"
                                        + string(ambOcclGI)                     +   "||"    + string(directionalGI)             +   "||"
                                        + string(gradientsGI)                   +   "||"    + string(behindTestGI)              +   "||"
                                        + string(useBumpsGI)                    +   "||"    + string(giIntensity)               +   "||"
                                        + string(giAngTol)                      +   "||"    + string(giIndBounces)              +   "||"
                                        + string(giMinSpacing)                  +   "||"    + string(giRPE)                     +   "||"
                                        + string(giMaxSpacing)                  +   "||"    + string(gi2ndBounces)              +   "||"
                                        + string(giMultiplier)                  +   "||"    + string(enableCaustics)            +   "||"
                                        + string(causticsAccuracy)              +   "||"    + string(causticsIntensity)         +   "||"
                                        + string(causticsSoftness)              +   "||"    + string(fiberFXSaveRGBA)           +   "||"
                                        + string(fiberFXSaveRGBAType)           +   "||"    + string(fiberFXSaveRGBAName)       +   "||"
                                        + string(fiberFXSaveDepth)              +   "||"    + string(fiberFXSaveDepthType)      +   "||"
                                        + string(fiberFXSaveDepthName)          +   "||"    + string(fogType)                   +   "||"
                                        + string(fogColorArray.x)               +   "||"    + string(fogColorArray.y)           +   "||"
                                        + string(fogColorArray.z)               +   "||"    + string(fogBackdropColor)          +   "||"
                                        + string(useBackgroundColor)            +   "||"    + string(backgroundColorArray.x)    +   "||"
                                        + string(backgroundColorArray.y)        +   "||"    + string(backgroundColorArray.z)    +   "||"
                                        + string(backdropColorArray.x)          +   "||"    + string(backdropColorArray.y)      +   "||"
                                        + string(backdropColorArray.z)          +   "||"    + string(zenithColorArray.x)        +   "||"
                                        + string(zenithColorArray.y)            +   "||"    + string(zenithColorArray.z)        +   "||"
                                        + string(skyColorArray.x)               +   "||"    + string(skyColorArray.y)           +   "||"
                                        + string(skyColorArray.z)               +   "||"    + string(groundColorArray.x)        +   "||"
                                        + string(groundColorArray.y)            +   "||"    + string(groundColorArray.z)        +   "||"
                                        + string(nadirColorArray.x)             +   "||"    + string(nadirColorArray.y)         +   "||"
                                        + string(nadirColorArray.z)             +   "||"    + string(useSolidBackdrop)          +   "||"
                                        + string(adaptiveSampling)              +   "||"    + string(radFlags_Nodes)            +   "||"
                                        + string(radFlags_Cells)                +   "||"    + string(radFlags_ColorCells)       +   "||"
                                        + string(radFlags_Samples)              +   "||"    + string(radFlags_MissPPSamples)    +   "||"
                                        + string(radFlags_MissRnSamples)        +   "||"    + string(radFlags_SecBounce)        +   "||"
                                        + string(radFlags_Behind)               +   "||"    + string(activeCameraID);
        }
        reqend();
    } else {
        logger("error","scnmasterOverride_UI: incorrect, or no, action passed");
    }
}

scnmasterOverride_UI_native_redraw
{
    drawline(<038,038,040>, ::ScnMst_ui_seperator_w - 7, ::ScnMst_dividerline_y1, ::ScnMst_ui_seperator_w - 7, ::ScnMst_dividerline_y2);
}

scnGen_native
{
    redirectBuffersSetts        = integer(::settingsArray[8]);
    disableAASetts              = integer(::settingsArray[9]);

    activeCameraID = integer(::settingsArray[90]);
    if(activeCameraID == 0)
    {
        activeCamera = 0; // first camera in scene file, matching default behaviour for no cameras in pass.
    } else {
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
                // logger("info","scnGen_native: Found match for camera: " + counter.asStr());
                activeCamera = counter;
            }
            counter++;
        }
    }

    // We need to do both of these - the first because we will later overwrite this field because it's parked at the end of the file and gets re-written
    // from the source file very late in the scene generation process.
    writeOverrideString(::updatedCurrentScenePath, updatedCurrentScenePath, "CurrentCamera ", activeCamera);
    writeOverrideString(::updatedCurrentScenePath, ::newScenePath, "CurrentCamera ", activeCamera);

    renderModeSetts = integer(::settingsArray[4]) - 1;
    writeOverrideString(::updatedCurrentScenePath, ::newScenePath, "RenderMode ", renderModeSetts);
    
    depthBufferAASetts = integer(::settingsArray[5]);
    writeOverrideString(::updatedCurrentScenePath, ::newScenePath, "DepthBufferAA ", depthBufferAASetts);
    
    renderLinesSetts = integer(::settingsArray[6]);
    writeOverrideString(::updatedCurrentScenePath, ::newScenePath, "RenderLines ", renderLinesSetts);

    rayRecursionLimitSetts = integer(::settingsArray[7]);
    writeOverrideString(::updatedCurrentScenePath, ::newScenePath, "RayRecursionLimit ", rayRecursionLimitSetts);

    if(disableAASetts == 1) {
        writeOverrideString(::updatedCurrentScenePath, ::newScenePath, "AASamples ", "1");
    }
    
    raytraceShadows             = integer(::settingsArray[10]);
    raytraceShadows_Flag        = 1;
    raytraceFlags               = (raytraceShadows * raytraceShadows_Flag);

    raytraceReflect             = integer(::settingsArray[11]);
    raytraceReflect_Flag        = 2;
    raytraceFlags               += (raytraceReflect * raytraceReflect_Flag);

    raytraceRefract             = integer(::settingsArray[12]);
    raytraceRefract_Flag        = 4;
    raytraceFlags               += (raytraceRefract * raytraceRefract_Flag);

    raytraceTrans               = integer(::settingsArray[13]);
    raytraceTrans_Flag          = 8;
    raytraceFlags               += (raytraceTrans * raytraceTrans_Flag);

    raytraceOccl                = integer(::settingsArray[14]);
    raytraceOccl_Flag           = 16;
    raytraceFlags               += (raytraceOccl * raytraceOccl_Flag);
    
    writeOverrideString(::updatedCurrentScenePath, ::newScenePath, "RayTraceEffects ", raytraceFlags);

    volumetricAA = integer(::settingsArray[15]);
    writeOverrideString(::updatedCurrentScenePath, ::newScenePath, "VolumetricAA ", volumetricAA);

    gLensFlares = integer(::settingsArray[16]);
    writeOverrideString(::updatedCurrentScenePath, ::newScenePath, "EnableLensFlares ", gLensFlares);

    shadowMaps = integer(::settingsArray[17]);
    writeOverrideString(::updatedCurrentScenePath, ::newScenePath, "EnableShadowMaps ", shadowMaps);

    volLights = integer(::settingsArray[18]);
    writeOverrideString(::updatedCurrentScenePath, ::newScenePath, "EnableVolumetricLights ", volLights);

    twoSidedALgts = integer(::settingsArray[19]);
    writeOverrideString(::updatedCurrentScenePath, ::newScenePath, "DoubleSidedAreaLights ", twoSidedALgts);

    renderInstances = integer(::settingsArray[20]);
    writeOverrideString(::updatedCurrentScenePath, ::newScenePath, "RenderInstances ", renderInstances);

    rayPrecision = number(::settingsArray[21]);
    writeOverrideString(::updatedCurrentScenePath, ::newScenePath, "RayPrecision ", rayPrecision);

    rayCutoff = number(::settingsArray[22]);
    writeOverrideString(::updatedCurrentScenePath, ::newScenePath, "RayCutoff ", rayCutoff);

    shadingSamples = integer(::settingsArray[23]);
    writeOverrideString(::updatedCurrentScenePath, ::newScenePath, "ShadingSamples ", shadingSamples);

    lightSamples = integer(::settingsArray[24]);
    writeOverrideString(::updatedCurrentScenePath, ::newScenePath, "LightSamples ", lightSamples);

    gLightIntensity = number(::settingsArray[25]);
    writeOverrideString(::updatedCurrentScenePath, ::newScenePath, "GlobalLightIntensity ", gLightIntensity);

    gFlareIntensity = number(::settingsArray[26]);
    writeOverrideString(::updatedCurrentScenePath, ::newScenePath, "GlobalFlareIntensity ", gFlareIntensity);

    enableGI = number(::settingsArray[27]);
    writeOverrideString(::updatedCurrentScenePath, ::newScenePath, "EnableRadiosity ", enableGI);

    giMode = integer(::settingsArray[28]);
    giMode = giMode - 1; // decrement by one to match index in LW. Menus are 1-indexed.
    writeOverrideString(::updatedCurrentScenePath, ::newScenePath, "RadiosityType ", giMode);

    interpolateGI = integer(::settingsArray[29]);
    writeOverrideString(::updatedCurrentScenePath, ::newScenePath, "RadiosityInterpolated ", interpolateGI);

    blurBGGI = integer(::settingsArray[30]);
    writeOverrideString(::updatedCurrentScenePath, ::newScenePath, "BlurRadiosity ", blurBGGI);

    transparencyGI = integer(::settingsArray[31]);
    writeOverrideString(::updatedCurrentScenePath, ::newScenePath, "RadiosityTransparency ", transparencyGI);

    volumetricGI = integer(::settingsArray[32]);
    writeOverrideString(::updatedCurrentScenePath, ::newScenePath, "VolumetricRadiosity ", volumetricGI);

    ambOcclGI = integer(::settingsArray[33]);
    writeOverrideString(::updatedCurrentScenePath, ::newScenePath, "RadiosityUseAmbient ", ambOcclGI);

    directionalGI = integer(::settingsArray[34]);
    writeOverrideString(::updatedCurrentScenePath, ::newScenePath, "RadiosityDirectionalRays ", directionalGI);

    gradientsGI = integer(::settingsArray[35]);
    writeOverrideString(::updatedCurrentScenePath, ::newScenePath, "RadiosityUseGradients ", gradientsGI);

    behindTestGI = integer(::settingsArray[36]);
    writeOverrideString(::updatedCurrentScenePath, ::newScenePath, "RadiosityUseBehindTest ", behindTestGI);

    useBumpsGI = integer(::settingsArray[37]);
    bradFlagsValue = useBumpsGI * (-2147483648);

    // We also need to consider any radiosity flags set by the user.
    for(i = 1; i <= 8; i++)
    {
        radFlags_Array[i] = integer(::settingsArray[81+ i]);
    }
                                   
    radFlags_Nodes              = integer(radFlags_Array[1]);
    radFlags_Cells              = integer(radFlags_Array[2]);
    radFlags_ColorCells         = integer(radFlags_Array[3]);
    radFlags_Samples            = integer(radFlags_Array[4]);
    radFlags_MissPPSamples      = integer(radFlags_Array[5]);
    radFlags_MissRnSamples      = integer(radFlags_Array[6]);
    radFlags_SecBounce          = integer(radFlags_Array[7]);
    radFlags_Behind             = integer(radFlags_Array[8]);

    // -2147483393

    cradFlagsValue = radFlags_Nodes + (2 * radFlags_Cells) + (4 * radFlags_ColorCells) + (8 * radFlags_Samples) +
                    (16 * radFlags_MissPPSamples) + (32 * radFlags_MissRnSamples) + (64 * radFlags_SecBounce) + (128 * radFlags_Behind);

    // Odd tweak needed if all flags are set - seems strange to me.
    radFlagsValue = bradFlagsValue + cradFlagsValue;
    if (cradFlagsValue == 256 && useBumpsGI == 1)
    {
        radFlagsValue -= 1;
    }

    writeOverrideString(::updatedCurrentScenePath, ::newScenePath, "RadiosityFlags ", radFlagsValue);

    giIntensity = integer(::settingsArray[38]);
    writeOverrideString(::updatedCurrentScenePath, ::newScenePath, "RadiosityIntensity ", giIntensity);

    giAngTol = integer(::settingsArray[39]);
    writeOverrideString(::updatedCurrentScenePath, ::newScenePath, "RadiosityTolerance ", giAngTol);

    giIndBounces = integer(::settingsArray[40]);
    writeOverrideString(::updatedCurrentScenePath, ::newScenePath, "IndirectBounces ", giIndBounces);
    
    giMinSpacing = number(::settingsArray[41]);
    writeOverrideString(::updatedCurrentScenePath, ::newScenePath, "RadiosityMinPixelSpacing ", giMinSpacing);

    giRPE = number(::settingsArray[42]);
    writeOverrideString(::updatedCurrentScenePath, ::newScenePath, "RadiosityRays ", giRPE);

    giMaxSpacing = number(::settingsArray[43]);
    writeOverrideString(::updatedCurrentScenePath, ::newScenePath, "RadiosityMaxPixelSpacing ", giMaxSpacing);

    gi2ndBounces = integer(::settingsArray[44]);
    writeOverrideString(::updatedCurrentScenePath, ::newScenePath, "SecondaryBounceRays ", gi2ndBounces);

    giMultiplier = number(::settingsArray[45]);
    writeOverrideString(::updatedCurrentScenePath, ::newScenePath, "RadiosityMultiplier ", giMultiplier);

    enableCaustics = number(::settingsArray[46]);
    writeOverrideString(::updatedCurrentScenePath, ::newScenePath, "EnableCaustics ", enableCaustics);

    causticsAccuracy = integer(::settingsArray[47]);
    writeOverrideString(::updatedCurrentScenePath, ::newScenePath, "CausticAccuracy ", causticsAccuracy);

    causticsIntensity = number(::settingsArray[48]);
    writeOverrideString(::updatedCurrentScenePath, ::newScenePath, "CausticIntensity ", causticsIntensity);

    causticsSoftness = number(::settingsArray[49]);
    writeOverrideString(::updatedCurrentScenePath, ::newScenePath, "CausticSoftness ", causticsSoftness);

    // FiberFX settings are written out in the main scene gen code. At least for now.

    fogType = integer(::settingsArray[56]) - 1;
    writeOverrideString(::updatedCurrentScenePath, ::newScenePath, "FogType ", fogType);

    fogColorLine = string(number(::settingsArray[57]) / 255) + " " + string(number(::settingsArray[58]) / 255) + " " + string(number(::settingsArray[59]) / 255);
    writeOverrideString(::updatedCurrentScenePath, ::newScenePath, "FogColor ", fogColorLine);

    fogBackdropColor = integer(::settingsArray[60]);
    writeOverrideString(::updatedCurrentScenePath, ::newScenePath, "BackdropFog ", fogBackdropColor);

    useBackgroundColor = integer(::settingsArray[61]);
    writeOverrideString(::updatedCurrentScenePath, ::newScenePath, "UseBackgroundColor ", useBackgroundColor);

    bgColorLine = string(number(::settingsArray[62]) / 255) + " " + string(number(::settingsArray[63]) / 255) + " " + string(number(::settingsArray[64]) / 255);
    writeOverrideString(::updatedCurrentScenePath, ::newScenePath, "BackgroundColor ", bgColorLine);

    bdColorLine = string(number(::settingsArray[65]) / 255) + " " + string(number(::settingsArray[66]) / 255) + " " + string(number(::settingsArray[67]) / 255);
    writeOverrideString(::updatedCurrentScenePath, ::newScenePath, "BackdropColor ", bdColorLine);

    zenithColorLine = string(number(::settingsArray[68]) / 255) + " " + string(number(::settingsArray[69]) / 255) + " " + string(number(::settingsArray[70]) / 255);
    writeOverrideString(::updatedCurrentScenePath, ::newScenePath, "ZenithColor ", zenithColorLine);

    skyColorLine = string(number(::settingsArray[71]) / 255) + " " + string(number(::settingsArray[72]) / 255) + " " + string(number(::settingsArray[73]) / 255);
    writeOverrideString(::updatedCurrentScenePath, ::newScenePath, "SkyColor ", skyColorLine);

    groundColorLine = string(number(::settingsArray[74]) / 255) + " " + string(number(::settingsArray[75]) / 255) + " " + string(number(::settingsArray[76]) / 255);
    writeOverrideString(::updatedCurrentScenePath, ::newScenePath, "GroundColor ", groundColorLine);

    nadirColorLine = string(number(::settingsArray[77]) / 255) + " " + string(number(::settingsArray[78]) / 255) + " " + string(number(::settingsArray[79]) / 255);
    writeOverrideString(::updatedCurrentScenePath, ::newScenePath, "NadirColor ", nadirColorLine);

    useSolidBackdrop = integer(::settingsArray[80]); // The scene file uses a solid backdrop tag. LW's UI denotes this as a gradient switch.
    if (useSolidBackdrop == 0) // So we have to flip the polarity to match the UI intent.
    {
        useSolidBackdrop = 1;
    } else {
        useSolidBackdrop = 0;
    }
    writeOverrideString(::updatedCurrentScenePath, ::newScenePath, "SolidBackdrop ", useSolidBackdrop);

    adaptiveSampling = integer(::settingsArray[81]);
    writeOverrideString(::updatedCurrentScenePath, ::newScenePath, "AdaptiveSampling ", adaptiveSampling);

    // FIXME : Move to camera override.
    disableAASetts = integer(::settingsArray[9]);
    if(disableAASetts == 1)
        disableAASetts = 0;
    writeOverrideString(::updatedCurrentScenePath, ::newScenePath, "Antialiasing ", disableAASetts);

    writeOverrideString(::updatedCurrentScenePath, ::newScenePath, "AntiAliasingLevel ", "-1");

    finishFiles();

    strip3rdPartyRenderers();
}

// Called from scene generation code if native renderer set for override.
radLines_native: radFileName
{
    switch (int(hostVersion()))
    {
        case 11:
            prepareRadiosityLines_11(radFileName);
            break;
        
        default:
            break;
    }
}

// This is ~annoying. The setting locations in the scene file were determined by manual inspection.
// I've version-controlled them in case they move/change in future.
prepareRadiosityLines_11: radFileName
{
    pRLStage = 1;
    pRLArray = @"EnableRadiosity 0","RadiosityType 1","RadiosityInterpolated 0","RadiosityTransparency 0","CacheRadiosity 0","PreprocessRadiosity 0","RadiosityIntensity 1",
                "RadiosityTolerance 0.2928932","RadiosityRays 100","SecondaryBounceRays 50","RadiosityMinPixelSpacing 3","RadiosityMaxPixelSpacing 100","RadiosityMultiplier 1",
                "VolumetricRadiosity 0","RadiosityUseAmbient 0","RadiosityDirectionalRays 0","RadiosityUseGradients 0","RadiosityUseBehindTest 0","BlurRadiosity 0",
                "RadiosityFlags 0","RadiosityCacheAnimation 0","RadiosityCacheModulus 1","RadiositySaveEachFrame 1","RadiosityCacheFilePath Radiosity/radiosity.cache"@;

    // Let's just write the entire standard block. The appropriate settings will be adjusted by any override in a subsequent action.

    pRL11StartLine = getPartialLine(0,0,"EnableRadiosity",radFileName);
    if (pRL11StartLine == nil)
    {
        pRL11StartLine = getPartialLine(0,0,"RadiosityType",radFileName);
    }
    pRL11EndLine = getPartialLine(0,0,"PixelFilterForceMT", radFileName);
    if (pRL11StartLine == nil)
    {
        logger("error","Something went wrong - please report with bug ref pRL11_1 and attach scene file");
    }

    pRLSource = File(radFileName,"r");
    tempFilePRL = ::tempDirectory + getsep() + "tempPassportFilePRL.lws";
    pRLTarget = File(tempFilePRL, "w");

    totalNumberOfActions = pRLSource.linecount() + size(pRLArray);

    for (line = 1; line < pRL11StartLine; line++)
    {
        progressString = string(line / totalNumberOfActions);
        msgString = "{" + progressString + "}Radiosity: Phase 1/3 - Preparing target scene...";
        StatusMsg(msgString);
        pRLTarget.writeln(pRLSource.read());
    }

    for (i = 1; i <= size(pRLArray); i++)
    {
        progressString = string((i + pRL11StartLine) / totalNumberOfActions);
        msgString = "{" + progressString + "}Radiosity: Phase 2/3 - Writing radiosity lines...";
        StatusMsg(msgString);
        pRLString = pRLArray[i];
        pRLString_a = parse(" ", pRLString);
        pRLString_t = pRLString_a[1];
        pRLSLine = getPartialLine(0,0,pRLString_t,radFileName);
        if(pRLSLine != nil)
        {
            pRLSource.line(pRLSLine);
            pRLString = pRLSource.read();
        }
        pRLTarget.writeln(pRLString);
    }

    pRLSource.line(pRL11EndLine);
    while(!pRLSource.eof())
    {
        progressString = string((pRLSource.line() + size(pRLArray)) / totalNumberOfActions);
        msgString = "{" + progressString + "}Radiosity: Phase 3/3 - Finishing target scene...";
        StatusMsg(msgString);
        pRLTarget.writeln(pRLSource.read());
    }
    pRLTarget.close();
    pRLSource.close();
    filecopy(tempFilePRL, radFileName);
    filedelete(tempFilePRL);
}

radFlags
{
    // Query our array
    radFlags_Nodes              = integer(radFlags_Array[1]);
    radFlags_Cells              = integer(radFlags_Array[2]);
    radFlags_ColorCells         = integer(radFlags_Array[3]);
    radFlags_Samples            = integer(radFlags_Array[4]);
    radFlags_MissPPSamples      = integer(radFlags_Array[5]);
    radFlags_MissRnSamples      = integer(radFlags_Array[6]);
    radFlags_SecBounce          = integer(radFlags_Array[7]);
    radFlags_Behind             = integer(radFlags_Array[8]);

    reqbeginstr = "Radiosity Flags";
    reqsize(50, 150);
    reqbegin(reqbeginstr);

    rf1 = ctlcheckbox("Show Nodes", radFlags_Nodes);
    ctlposition(rf1, ::radFlg_gad_x, ::radFlg_gad_y, ::radFlg_gad_w, ::radFlg_gad_h, ::radFlg_gad_text_offset);
        
    ui_offset_y = ::radFlg_ui_row_offset;

    rf2 = ctlcheckbox("Show Cells", radFlags_Cells);
    ctlposition(rf2, ::radFlg_gad_x, ::radFlg_gad_y + ui_offset_y, ::radFlg_gad_w, ::radFlg_gad_h, ::radFlg_gad_text_offset);

    ui_offset_y += ::radFlg_ui_row_offset;

    rf3 = ctlcheckbox("Show Color Cells", radFlags_ColorCells);
    ctlposition(rf3, ::radFlg_gad_x, ::radFlg_gad_y + ui_offset_y, ::radFlg_gad_w, ::radFlg_gad_h, ::radFlg_gad_text_offset);

    ui_offset_y += ::radFlg_ui_row_offset;

    rf4 = ctlcheckbox("Show Samples", radFlags_Samples);
    ctlposition(rf4, ::radFlg_gad_x, ::radFlg_gad_y + ui_offset_y, ::radFlg_gad_w, ::radFlg_gad_h, ::radFlg_gad_text_offset);

    ui_offset_y += ::radFlg_ui_row_offset;

    rf5 = ctlcheckbox("Show Missing Preprocess Samples", radFlags_MissPPSamples);
    ctlposition(rf5, ::radFlg_gad_x, ::radFlg_gad_y + ui_offset_y, ::radFlg_gad_w, ::radFlg_gad_h, ::radFlg_gad_text_offset);

    ui_offset_y += ::radFlg_ui_row_offset;

    rf6 = ctlcheckbox("Show Missing Render Samples", radFlags_MissRnSamples);
    ctlposition(rf6, ::radFlg_gad_x, ::radFlg_gad_y + ui_offset_y, ::radFlg_gad_w, ::radFlg_gad_h, ::radFlg_gad_text_offset);

    ui_offset_y += ::radFlg_ui_row_offset;

    rf7 = ctlcheckbox("Show Second Bounce", radFlags_SecBounce);
    ctlposition(rf7, ::radFlg_gad_x, ::radFlg_gad_y + ui_offset_y, ::radFlg_gad_w, ::radFlg_gad_h, ::radFlg_gad_text_offset);

    ui_offset_y += ::radFlg_ui_row_offset;

    rf8 = ctlcheckbox("Show Behind", radFlags_Behind);
    ctlposition(rf8, ::radFlg_gad_x, ::radFlg_gad_y + ui_offset_y, ::radFlg_gad_w, ::radFlg_gad_h, ::radFlg_gad_text_offset);

    if(reqpost())
    {
        radFlags_Nodes              = integer(getvalue(rf1));
        radFlags_Cells              = integer(getvalue(rf2));
        radFlags_ColorCells         = integer(getvalue(rf3));
        radFlags_Samples            = integer(getvalue(rf4));
        radFlags_MissPPSamples      = integer(getvalue(rf5));
        radFlags_MissRnSamples      = integer(getvalue(rf6));
        radFlags_SecBounce          = integer(getvalue(rf7));
        radFlags_Behind             = integer(getvalue(rf8));

        radFlags_Array[1] = radFlags_Nodes;
        radFlags_Array[2] = radFlags_Cells;
        radFlags_Array[3] = radFlags_ColorCells;
        radFlags_Array[4] = radFlags_Samples;
        radFlags_Array[5] = radFlags_MissPPSamples;
        radFlags_Array[6] = radFlags_MissRnSamples;
        radFlags_Array[7] = radFlags_SecBounce;
        radFlags_Array[8] = radFlags_Behind;
    }

    reqend;
}

