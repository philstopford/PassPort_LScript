@asyncspawn
@warnings
@script master
@name "PassPort_MC"
// @define dev 1

// EXPERIMENTAL features
// @define enableKray 1;
// @define enablePBS 1; // only for post-1.0.

var supportedplatform = 1;

@insert "@passEditor_globals.ls"
@insert "@passEditor_UIglobals.ls"
@insert "@passEditor_Utilityfuncs.ls"
@insert "@passEditor_Interface_Subfuncs.ls"
@insert "@passEditor_Interface_Subfuncs_Passes.ls"
@insert "@passEditor_Interface_Subfuncs_Overrides.ls"
@insert "@passEditor_Interface_Subfuncs_OverrideUI.ls" // override UIs are complicated so they got broken out into a separate file.
@insert "@passEditor_render_Subfuncs.ls"
@insert "@passEditor_sceneGen_Subfuncs.ls"
@insert "@passEditor_sceneParse_Subfuncs.ls"
@insert "@passEditor_UDF.ls"
@insert "@passEditor_UDF_Passes.ls"
@insert "@passEditor_UDF_Overrides.ls"
@insert "@passEditor_NativeRenderer_Support.ls"
@insert "@passEditor_Kray25Renderer_Support.ls"

// icons
blank_icon = @ "................",
                  "................",
                  "................",
                  "................",
                  "................",
                  "................",
                  "................",
                  "................",
                  "................"
            @;
            
enterkey_icon = @ "................",
                  "................",
                  "................",
                  ".....1.1.1.1.1..",
                  "......1.1.1.1...",
                  ".............1..",
                  "............1...",
                  ".............1..",
                  ".............1.."
            @;
deletekey_icon = @ "................",
                  ".......1.1.1.1.1",
                  ".....1..x...x..1",
                  "...1.1..xx.xx...",
                  "..1.......xx...1",
                  "...1.1..xx.xx...",
                  "......1.x...x..1",
                  "........1.1.1.1.",
                  "................"
            @;
            
ctrlA_icon = @ "....1.1.........",
               "....1..1........",
               "..1....1........",
               "..1......1......",
               "................",
               "...........a.a..",
               "..........a...a.",
               "..........a...a.",
               "...........aaa.a"
            @;
downarrow_icon = @ "................",
                   "................",
                   "...111111111....",
                   "....1111111.....",
                   ".....11111......",
                   "......111.......",
                   ".......1........",
                   "................",
                   "................"
            @;
lettero_icon = @ "................",
           "................",
           "................",
           "...........a.a..",
           ".........a.....a.",
           ".........a.....a.",
           ".........a.....a.",
           ".........a.....a.",
           "...........a.a.."
            @;
ctrlR_icon = @ ".....11.........",
               "....1..1........",
               "...1....1.......",
               "..1......1......",
               "................",
               "............aa..",
               "...........a..a.",
               "...........a....",
               "...........a...."
            @;
            

bullet_icon = @ "................",
                "................",
                "................",
                "................",
                "........---.....",
                ".......-----....",
                ".......-----....",
                "........---.....",
                "................"
            @;

@define BLANK 1
@define ENTERKEY 2
@define DELETEKEY 3
@define CTRLA 4
@define DOWNARROW 5
@define LETTERO 6
@define CTRLR 7
@define BULLET 8

platformcheck
{
    // Check to block operation on old LW versions - permitted removal of needHackySaving!
    if (hostBuild() < 2238) {
    	supportedplatform = 0;
        error("This version of PassPort requires at least LightWave 3D 11.0.");
    }

	return;
}

// typical interface functions for master script here
create
{
	// Attempt to avoid failures under LWSN.
	if(runningUnder() == LAYOUT)
	{
		platformcheck();
	
		loadingInProgress = 0;
		justReopened = 0;
		// 22 = List gadget scrollbar
		listOneWidth = listTwoWidth = integer( ( (Main_panelWidth - (3 * Main_ui_gap) ) - 44) / 2);
		listTwoPosition = listTwoWidth + 22 + (2 * Main_ui_gap);
		listOneHeight = Main_panelHeight - ( 3 * Main_button_height) - Main_banner_height - Main_spacer_height - ( 5 * Main_ui_y_spacer);
	
		icon[BLANK] = Icon(blank_icon);
		icon[ENTERKEY] = Icon(enterkey_icon);
		icon[DELETEKEY] = Icon(deletekey_icon);
		icon[CTRLA] = Icon(ctrlA_icon);
		icon[DOWNARROW] = Icon(downarrow_icon);
		icon[LETTERO] = Icon(lettero_icon);
		icon[CTRLR] = Icon(ctrlR_icon);
		icon[BULLET] = Icon(bullet_icon);
		setdesc("PassPort Renewed " + versionString);
		sceneJustLoaded = 0;
		
		fileMenu_items = @"Save Pass as Scene...","Save All Passes As Scenes...","Render Pass Frame","Render Pass Scene","Render All Passes","==","Update Lists Now      "+ icon[CTRLR],"Preferences...          " + icon[LETTERO],"Render Globals...","==","Save Current Settings...","Load Settings...","About PassPort..."@;
	
		//preProcess();
		comringattach("LW_PassPort","getCommand");
    }
}

destroy
{
	if(runningUnder() == LAYOUT)
	{
		if(supportedplatform != 1)
			return;
		unProcess();
	}
}

options
{
	platformcheck();

    if(interfaceRunYet == 1)
    {
        reProcess();
    }

    else
    {
        preProcess();
    }


    interfaceRunYet = 1;
    if(reqisopen())
    {
        reqend();
    }

	// Original code always anticipated a drive letter this_script[1].
	// On Mac, this is nil and the arithmetic fails. So we adjust this as below.
	this_script = split(SCRIPTID);
	this_script_path = this_script[2];
	if(this_script[1])
		this_script_path = this_script[1] + this_script[2] + getsep();
       
    // Check if the script is compiled, if so, don't need to find the banner images on disk
    compiled = 1;
    s = strsub(this_script[4], size(this_script[4]), 1);
    if(s =="s" || s =="S")
    {
        compiled = 0;
    }

    reqbegin("PassPort Editor " + versionString.asStr());
    reqsize(Main_panelWidth,Main_panelHeight);

    // Banner Graphic
    if(compiled)
    {
        switch(editorResolution)
        {
            case 1:
                c_banner = ctlimage( "Passport_Banner_640.tga" );
                break;

            case 2:
                c_banner = ctlimage( "Passport_Banner_640.tga" );
                break;

            case 3:
                c_banner = ctlimage( "Passport_Banner_457.tga" );
            break;

            case 4:
                c_banner = ctlimage( "Passport_Banner_457.tga" );
                break;

            default:
                c_banner = ctlimage( "Passport_Banner_640.tga" );
                break;
        }
    }else
    {
        switch(editorResolution)
        {
            case 1:
                banner_filename = this_script_path + "Passport_Banner_640.tga";
                break;

            case 2:
                banner_filename = this_script_path + "Passport_Banner_640.tga";
                break;

            case 3:
                banner_filename = this_script_path + "Passport_Banner_457.tga";
            break;

            case 4:
                banner_filename = this_script_path + "Passport_Banner_457.tga";
                break;

            default:
                banner_filename = this_script_path + "Passport_Banner_640.tga";
                break;
        }
        c_banner = ctlimage( banner_filename );
    }

    ctlposition(c_banner,0,0);

    file_popup_menu = ctlmenu("File...           " + icon[DOWNARROW],fileMenu_items,"fileMenu_select","fileMenu_active");
    ctlposition(file_popup_menu, Main_ui_gap, Main_banner_height + 5);
    
    gad_PassesOverridesTab = ctltab("Passes","Overrides");
    ctlposition(gad_PassesOverridesTab, 0, Main_banner_height + 35);

    gad_PassesListview = ctllistbox("Render Passes",listOneWidth,listOneHeight,"passeslb_count","passeslb_name","passeslb_event");
    ctlposition(gad_PassesListview, Main_ui_gap, Main_banner_height + 55);

    gad_OverridesListview = ctllistbox("Item Overrides",listOneWidth,listOneHeight,"overrideslb_count","overrideslb_name","overrideslb_event");
    ctlposition(gad_OverridesListview, Main_ui_gap, Main_banner_height + 55);

@if dev == 1
    gad_Debug = ctlstate("DEBUG",debugmode,debugButtonWidth,"debugMe"); // use globalstore (defined in globals), defaults to 0 if not retrieved.
    ctlposition(gad_Debug,debugButtonXposition, Main_banner_height+5);
@end // end of dev == 1 check
    
    gad_SceneItems_forPasses_Listview = ctllistbox("Scene Items",listTwoWidth,listOneHeight,"itemslb_count","itemslb_name","itemslb_event");
    ctlposition(gad_SceneItems_forPasses_Listview,listTwoPosition, Main_banner_height + 55);

    gad_SceneItems_forOverrides_Listview = ctllistbox("Scene Items",listTwoWidth,listOneHeight,"o_itemslb_count","o_itemslb_name","o_itemslb_event");
    ctlposition(gad_SceneItems_forOverrides_Listview,listTwoPosition, Main_banner_height + 55);

    gad_New_Pass = ctlmenu(newPassButtonString,passMenu_items,"passMenu_select","passMenu_active");
    ctlposition(gad_New_Pass,newPassButtonXposition,bottomPosition,newPassButtonWidth,Main_button_height);

    gad_New_Override = ctlmenu(newOverrideButtonString,overrideMenu_items,"overrideMenu_select","overrideMenu_active");
    ctlposition(gad_New_Override,newOverrideButtonXposition,bottomPosition,newOverrideButtonWidth,Main_button_height);

    gad_EditSel_Passes = ctlbutton(editSelectedButtonString,editSelectedButtonWidth,"editSelectedPass");
    ctlposition(gad_EditSel_Passes,editSelectedButtonXposition,bottomPosition);

    gad_DelSel_Passes = ctlbutton(deleteSelectedButtonString,deleteSelectedButtonWidth,"deleteSelectedPass");
    ctlposition(gad_DelSel_Passes,deleteSelectedButtonXposition,bottomPosition);

    gad_EditSel_Override = ctlbutton(editSelectedButtonString,editSelectedButtonWidth,"editSelectedOverride");
    ctlposition(gad_EditSel_Override,editSelectedButtonXposition,bottomPosition);

    gad_DelSel_Override = ctlbutton(deleteSelectedButtonString, deleteSelectedButtonWidth, "deleteSelectedOverride");
    ctlposition(gad_DelSel_Override,deleteSelectedButtonXposition,bottomPosition);

    gad_AddAll_Passes = ctlbutton(addAllButtonString,addAllButtonWidth,"addAllButton");
    ctlposition(gad_AddAll_Passes,addAllButtonXposition,bottomPosition);

    gad_AddSelected_Passes = ctlbutton(addSelButtonString,addSelButtonWidth,"addSelButton");
    ctlposition(gad_AddSelected_Passes,addSelButtonXposition,bottomPosition);

    gad_ClearAll_Passes = ctlbutton(clearAllButtonString,clearAllButtonWidth,"clearAllButton");
    ctlposition(gad_ClearAll_Passes,clearAllButtonXposition,bottomPosition);

    gad_ClearSel_Passes = ctlbutton(clearSelButtonString,clearSelButtonWidth,"clearSelButton");
    ctlposition(gad_ClearSel_Passes,clearSelButtonXposition,bottomPosition);

    gad_AddAll_Override = ctlbutton(addAllButtonString,addAllButtonWidth,"o_addAllButton");
    ctlposition(gad_AddAll_Override,addAllButtonXposition,bottomPosition);

    gad_AddSelected_Override = ctlbutton(addSelButtonString,addSelButtonWidth,"o_addSelButton");
    ctlposition(gad_AddSelected_Override,addSelButtonXposition,bottomPosition);

    gad_ClearAll_Override = ctlbutton(clearAllButtonString,clearAllButtonWidth,"o_clearAllButton");
    ctlposition(gad_ClearAll_Override,clearAllButtonXposition,bottomPosition);

    gad_ClearSel_Override = ctlbutton(clearSelButtonString,clearSelButtonWidth,"o_clearSelButton");
    ctlposition(gad_ClearSel_Override,clearSelButtonXposition,bottomPosition);

    gad_SelectedPass = ctlpopup("Current Pass :",currentChosenPass,"currentPassMenu_update");
    ctlposition(gad_SelectedPass, 100, Main_banner_height + 5, 300, Main_button_height);
    ctlrefresh(gad_SelectedPass, "currentPassMenu_refresh");

    ctlpage(1,gad_PassesListview,gad_SceneItems_forPasses_Listview,gad_New_Pass,gad_EditSel_Passes,gad_DelSel_Passes,gad_AddAll_Passes,gad_AddSelected_Passes,gad_ClearAll_Passes,gad_ClearSel_Passes);
    ctlpage(2,gad_OverridesListview,gad_SceneItems_forOverrides_Listview,gad_New_Override,gad_EditSel_Override,gad_DelSel_Override,gad_AddAll_Override,gad_AddSelected_Override,gad_ClearAll_Override,gad_ClearSel_Override);

    req_update();    
    reqopen();
} // end options

load: what,io
    {
		platformcheck();

        loadingInProgress = 1;
        if(what == SCENEMODE)
        {
          passPortVersion = io.read();
          versionMismatch = 0;
          if(passPortVersion != versionString)
          {
            info("WARNING: This scene contains settings for Passport version " + passPortVersion);
            versionMismatch = 1;
          }
          lwVersion = io.read();
          if(lwVersion != hostVersion().asStr())
          {
            info("WARNING: Passport override settings are for LW version " + lwVersion);
            versionMismatch = 1;
          }
          if (versionMismatch == 1)
          {
            info("PassPort : One or more warnings were issued. Passport operation may be affected. See documentation for advice.");
          }
          passNamesSize = io.read().asInt();
          for(x = 1; x <= passNamesSize; x++)
          {
              passNames[x] = io.read();
              passAssItems[x] = io.read();
              if(passAssItems[x] == nil)
              {
                  passAssItems[x] = "";
              }

@if enablePBS == 1
              passBufferExporters[x] = io.read();
@end
          }
          overrideNamesSize = io.read().asInt();
          overrideNames[1] = io.read();
          if(overrideNames[1] == "empty")
          {
              overrideSettings[1] = "";
          }
          else
          {
              overrideSettings[1] = io.read();
          }
          if(overrideNamesSize > 1)
          {
              for(x = 2; x <= overrideNamesSize; x++)
              {
                  overrideNames[x] = io.read();
                  if(overrideNames[1] != "empty")
                  {
                      overrideSettings[x] = io.read();
                  }
              }
          }
          for(x = 1; x <= passNamesSize; x++)
          {
              for(y = 1; y <= overrideNamesSize; y++)
              {
                  if(overrideNames[1] != "empty")
                  {
                      passOverrideItems[x][y] = io.read();
                      if(passOverrideItems[x][y] == nil)
                      {
                          passOverrideItems[x][y] = "";
                      }
                  }
                  else
                  {
                      passOverrideItems[x][y] = "";
                  }
              }
          }
          userOutputFolder = io.read();
          if(userOutputFolder == nil)
          {
              userOutputFolder = "";
          }
          fileOutputPrefix = io.read();
          if(fileOutputPrefix == nil)
          {
              fileOutputPrefix = "";
          }
          userOutputString = io.read();
          if(userOutputString == nil)
          {
              userOutputString = "";
          }
          useGrowl = io.read().asInt();
          areYouSurePrompts = io.read().asInt();
          rgbSaveType = io.read().asInt();
          editorResolution = io.read().asInt();
          testRgbSaveType = io.read().asInt();
          
          setdesc("PassPort Renewed " + versionString);
          sceneJustLoaded = 1;
          interfaceRunYet = 1;
        }
    }
    
save: what,io
{
  if(supportedplatform != 1)
  	return;
      if(what == SCENEMODE)
      {   
          if(sceneJustLoaded == 1 || interfaceRunYet == 1)
          {
              passNamesSize = size(passNames);
              io.writeln(versionString);
              io.writeln(hostVersion().asStr());
              io.writeln(passNamesSize);
              for(x = 1; x <= passNamesSize; x++)
              {
                  io.writeln(passNames[x]);
                  io.writeln(passAssItems[x]);

@if enablePBS == 1
                  io.writeln(passBufferExporters[x]);
@end
              }
              
               for(x = 1; x <= size(overrideNames); x++)
              {
                  if(strleft(overrideNames[x],1) == " ")
                  {
                      
                      settingsArray = parse("||",overrideSettings[x]);
                      settingsArrayNumber = integer(strright(settingsArray[2],1));
                      switch(settingsArrayNumber)
                      {
                          case 1:
                              overrideNames[x] = settingsArray[1] + "   (.srf file)";
                              break;
                              
                          case 2:
                              overrideNames[x] = settingsArray[1] + "   (object properties)";
                              break;
                              
                          case 3:
                              overrideNames[x] = settingsArray[1] + "   (.mot file)";
                              break;
                              
                          case 4:
                              overrideNames[x] = settingsArray[1] + "   (.lwo file)";
                              break;

                          case 5:
                              overrideNames[x] = settingsArray[1] + "   (light properties)";
                              break;
                              
                          case 6:
                              overrideNames[x] = settingsArray[1] + "   (scene properties)";
                              break;
                          
                          case 7:
                              overrideNames[x] = settingsArray[1] + "   (light exclusion)";
                              break;

                          case 8:
                              overrideNames[x] = settingsArray[1] + "   (camera)";
                              break;

                          default:
                              overrideNames[x] = settingsArray[1];
                              break;
                      }
                  }

              }

              overrideNamesSize = size(overrideNames);
              io.writeln(overrideNamesSize);
              io.writeln(overrideNames[1]);
              
              if(overrideNames[1] != "empty")
              {
                  io.writeln(overrideSettings[1]);
              }
              if(overrideNamesSize > 1)
              {
                  for(x = 2; x <= overrideNamesSize; x++)
                  {
                      io.writeln(overrideNames[x]);
                      if(overrideNames[1] != "empty")
                      {
                          io.writeln(overrideSettings[x]);
                      }
                  }
              }
              
              for(x = 1; x <= passNamesSize; x++)
              {
                  for(y = 1; y <= overrideNamesSize; y++)
                  {
                      if(overrideNames[1] != "empty")
                      {
                          io.writeln(passOverrideItems[x][y]);
                      }
                  }
              }
              io.writeln(userOutputFolder);
              io.writeln(fileOutputPrefix);
              io.writeln(userOutputString);
              io.writeln(useGrowl);
              io.writeln(areYouSurePrompts);
              io.writeln(rgbSaveType);
              io.writeln(editorResolution);
              io.writeln(testRgbSaveType);
              
              unsaved = 0;
              
              globalstore("passEditoruserOutputString",userOutputString);
              if(platform() == MACUB || platform() == MAC64)
                globalstore("passEditorUseGrowl",useGrowl);
              globalstore("passEditorareYouSurePrompts",areYouSurePrompts);
              globalstore("passEditorrgbSaveType",rgbSaveType);
              globalstore("passEditoreditorResolution",editorResolution);
              globalstore("passEditortestRgbSaveType",testRgbSaveType);
          }

      }
  }

  flags
  {
  if(!supportedplatform)
  	return;
  return(SCENE,LWMASTF_RECEIVE_NOTIFICATIONS);
}
    
process: event, command
{
}

// custom interface functions below here
    preProcess
    {
		if (supportedplatform != 1)
			return;
			
        // this bit is basically just cataloging scene items and setting up initial values for variables
        masterScene = Scene();
        originalSelection = masterScene.getSelect();
        
        EditObjects();
        image_formats_array = getImageFormats();
        
        // Set 'userOutputFolder' to "Content/Passport_Passes" by default - Matt Gorner
        userOutputFolder = getdir("Content") + getsep() + "PassPort_Passes";
        userOutputString = string(globalrecall("passEditoruserOutputString",""));
        if(platform() == MACUB || platform() == MAC64)
	        useGrowl = integer(globalrecall("passEditorUseGrowl", 0));
        areYouSurePrompts = integer(globalrecall("passEditorareYouSurePrompts", 1));
        rgbSaveType = integer(globalrecall("passEditorrgbSaveType", 1));
        editorResolution = integer(globalrecall("passEditoreditorResolution", 1));
        testRgbSaveType = integer(globalrecall("passEditortestRgbSaveType", 1));
        
        interfaceRunYet = 0;
        doKeys = 1;
        idMapping = 1;

        fileOutputPrefix = masterScene.name;
        if(strright(fileOutputPrefix,4) == ".lws")
        {
            n = size(fileOutputPrefix) - 4;
            fileOutputPrefix = (strleft(fileOutputPrefix,n));
        }
        if(fileOutputPrefix == "(unnamed)")
        {
            fileOutputPrefix = "unnamed";
            unsaved = 1;
        }
        else
        {
            unsaved = 0;
        }

        if(Mesh(0))
        {
            SelectAllObjects();
            s = masterScene.getSelect();
            if(s != nil)
            {
                arraySize = size(s);
                for(x = 1; x <= arraySize; x++)
                {
                    itemname = s[x].name;
                    meshAgents[x] = Mesh(itemname);
                    meshNames[x] = meshAgents[x].name;
                    meshIDs[x] = meshAgents[x].id;
                    tempIDArray = parse("x",hex(meshIDs[x]));
                    meshOldIDs[x] = tempIDArray[2];
                }
            }
        }
        else
        {
            meshAgents[1] = "none";
        }
        EditObjects();
        EditLights();
        SelectAllLights();
        s = masterScene.getSelect();
        if(s != nil)
        {
            arraySize = size(s);
            for(x = 1; x <= arraySize; x++)
            {
                itemname = s[x].name;
                lightAgents[x] = Light(itemname);
                lightNames[x] = lightAgents[x].name;
                lightIDs[x] = lightAgents[x].id;
                tempIDArray = parse("x",hex(lightIDs[x]));
                lightOldIDs[x] = tempIDArray[2];
            }
        }

        EditCameras();
        SelectAllCameras();
        s = masterScene.getSelect();
        if(s != nil)
        {
            arraySize = size(s);
            for(x = 1; x <= arraySize; x++)
            {
                itemname = s[x].name;
                cameraAgents[x] = Camera(itemname);
                cameraNames[x] = cameraAgents[x].name;
                cameraIDs[x] = cameraAgents[x].id;
                tempIDArray = parse("x",hex(cameraIDs[x]));
                cameraOldIDs[x] = tempIDArray[2];
            }
        }

        // do the experimental scene master override setup
        o_displayNames = nil; // clear it out
        o_displayGenus = nil; // clear it out
        o_displayIDs = nil;
        o_displayNames[1] = "(Scene Master)";
        o_displayGenus[1] = 0;
        o_displayIDs[1] = "SM";
                

        idMapping = 0;
        x = 1;
        for(y = 1; y <= size(meshAgents); y++)
        {
            if(meshAgents[1] != "none")
            {
                displayNames[x] = meshNames[y];
                o_displayNames[x+1] = meshNames[y];
                displayGenus[x] = MESH;
                o_displayGenus[x+1] = MESH;
                displayIDs[x] = meshIDs[y];
                o_displayIDs[x+1] = meshIDs[y];
                displayOldIDs[x] = meshOldIDs[y];
                x++;
            }
        }
        for(y = 1; y <= size(lightAgents); y++)
        {
            displayNames[x] = lightNames[y];
            o_displayNames[x+1] = lightNames[y];
            displayGenus[x] = LIGHT;
            o_displayGenus[x+1] = LIGHT;
            displayIDs[x] = lightIDs[y];
            o_displayIDs[x+1] = lightIDs[y];
            displayOldIDs[x] = lightOldIDs[y];
            x++;
        }

        for(y = 1; y <= size(cameraAgents); y++)
        {
            displayNames[x] = cameraNames[y];
            o_displayNames[x+1] = cameraNames[y];
            displayGenus[x] = CAMERA;
            o_displayGenus[x+1] = CAMERA;
            displayIDs[x] = cameraIDs[y];
            o_displayIDs[x+1] = cameraIDs[y];
            displayOldIDs[x] = cameraOldIDs[y];
            x++;
        }

        passNames[1] = "Default";

@if enablePBS == 1
        changeImageFilterState = "0";
        compBufferToggle = "0";
        exrTraderToggle = "0";
        specBuffToggle = "0";
        psdToggle = "0";
        rlaToggle = "0";
        rpfToggle = "0";
        auraToggle = "0";
        iDOFToggle = "0";
        passBufferExporters[1] = changeImageFilterState + "||" + compBufferToggle + "||" + exrTraderToggle + "||" + specBuffToggle + "||" + psdToggle
                                                        + "||" + rlaToggle + "||" + rpfToggle + "||" + auraToggle + "||" + iDOFToggle;
@end

        overrideNames[1] = "empty";
        for(x = 1; x <= size(passNames); x++)
        {
            passAssItems[x] = "";
        }
        currentChosenPass = 1;
        currentChosenPassString = passNames[currentChosenPass];
        if(overrideNames[1] != "empty")
        {
            passOverrideItems[size(passNames)][size(overrideNames)] = "";
            for(x = 1; x <= size(passNames); x++)
            {
                for(y = 1; y <= size(overrideNames); y++)
                {
                    passOverrideItems[x][y] = "";
                }
            }
        }
        
        if(originalSelection != nil)
        {
            SelectItem(originalSelection[1].id);
            for(x = 1; x <= size(originalSelection); x++)
            {
                AddToSelection(originalSelection[x].id);
            }
        }
        else
        {
            EditObjects();  
        }
                
        if(loadingInProgress != 1)
        {
        }
        else
        {
            loadingInProgress = 0;
        }

        switch(editorResolution)
        {
            case 1:
                Main_panelWidth = Main_res1_panelWidth;
                Main_panelHeight = Main_res1_panelHeight;
                
                // 22 = List gadget scrollbar
                listOneWidth = listTwoWidth = integer( ( (Main_panelWidth - (3 * Main_ui_gap) ) - 44) / 2);
                listTwoPosition = listTwoWidth + 22 + (2 * Main_ui_gap);

                w = integer(( (listOneWidth + 22 - (3 * ( Main_ui_gap / 2) ) ) / 3) + 1 );

                newPassButtonString = "New Pass...      " + icon[DOWNARROW];
                newPassButtonWidth = w;
                newPassButtonXposition = Main_ui_gap;

                newOverrideButtonString = "New Override... " + icon[DOWNARROW];
                newOverrideButtonWidth = w;
                newOverrideButtonXposition = Main_ui_gap;

                editSelectedButtonString = "Edit Selected  " + icon[ENTERKEY];
                editSelectedButtonWidth = w;
                editSelectedButtonXposition = Main_ui_gap + w + (Main_ui_gap / 2);

                deleteSelectedButtonString = "Del Selected   " + icon[DELETEKEY];
                deleteSelectedButtonWidth = w;
                deleteSelectedButtonXposition = Main_ui_gap + 2 * (w + (Main_ui_gap / 2));

                w = integer( (listOneWidth + 22 - (3 * ( Main_ui_gap / 2) ) ) / 4 );

                addAllButtonString = "Add All    "+ icon[CTRLA];
                addAllButtonWidth = w;
                addAllButtonXposition = listTwoPosition;

                addSelButtonString = "Add Sel    ";
                addSelButtonWidth = w;
                addSelButtonXposition = listTwoPosition + w + (Main_ui_gap / 2);

                clearAllButtonString = "Clear All";
                clearAllButtonWidth = w;
                clearAllButtonXposition = listTwoPosition + 2 * (w + (Main_ui_gap / 2));

                clearSelButtonString = "Clear Sel";
                clearSelButtonWidth = w;
                clearSelButtonXposition = listTwoPosition + 3 * (w + (Main_ui_gap / 2));

@if dev == 1
                // debug button is masked in release builds. X position to match the clear selected button. Y position matched from current pass gadget (hard-coded)
                debugButtonXposition = clearSelButtonXposition;
                debugButtonWidth = clearSelButtonWidth;
@end

                break;
                
            case 2:
                Main_panelWidth = Main_res2_panelWidth;
                Main_panelHeight = Main_res2_panelHeight;

                // 22 = List gadget scrollbar
                listOneWidth = listTwoWidth = integer( ( (Main_panelWidth - (3 * Main_ui_gap) ) - 44) / 2);
                listTwoPosition = listTwoWidth + 22 + (2 * Main_ui_gap);

                w = integer(( (listOneWidth + 22 - (3 * ( Main_ui_gap / 2) ) ) / 3) + 1 );

                newPassButtonString = "New Pass...      " + icon[DOWNARROW];
                newPassButtonWidth = w;
                newPassButtonXposition = Main_ui_gap;

                newOverrideButtonString = "New Override... " + icon[DOWNARROW];
                newOverrideButtonWidth = w;
                newOverrideButtonXposition = Main_ui_gap;

                editSelectedButtonString = "Edit Selected  " + icon[ENTERKEY];
                editSelectedButtonWidth = w;
                editSelectedButtonXposition = Main_ui_gap + w + (Main_ui_gap / 2);

                deleteSelectedButtonString = "Del Selected   " + icon[DELETEKEY];
                deleteSelectedButtonWidth = w;
                deleteSelectedButtonXposition = Main_ui_gap + 2 * (w + (Main_ui_gap / 2));

                w = integer( (listOneWidth + 22 - (3 * ( Main_ui_gap / 2) ) ) / 4 );

                addAllButtonString = "Add All    "+ icon[CTRLA];
                addAllButtonWidth = w;
                addAllButtonXposition = listTwoPosition;

                addSelButtonString = "Add Sel    ";
                addSelButtonWidth = w;
                addSelButtonXposition = listTwoPosition + w + (Main_ui_gap / 2);

                clearAllButtonString = "Clear All";
                clearAllButtonWidth = w;
                clearAllButtonXposition = listTwoPosition + 2 * (w + (Main_ui_gap / 2));

                clearSelButtonString = "Clear Sel";
                clearSelButtonWidth = w;
                clearSelButtonXposition = listTwoPosition + 3 * (w + (Main_ui_gap / 2));

@if dev == 1
                // debug button is masked in release builds. X position to match the clear selected button. Y position matched from current pass gadget (hard-coded)
                debugButtonXposition = clearSelButtonXposition;
                debugButtonWidth = clearSelButtonWidth;
@end

                break;

            case 3:
                Main_panelWidth = Main_res3_panelWidth;
                Main_panelHeight = Main_res3_panelHeight;

                // 22 = List gadget scrollbar
                listOneWidth = listTwoWidth = integer( ( (Main_panelWidth - (3 * Main_ui_gap) ) - 44) / 2);
                listTwoPosition = listTwoWidth + 22 + (2 * Main_ui_gap);
                
                w = integer(( (listOneWidth + 22 - (3 * ( Main_ui_gap / 2) ) ) / 3) + 1 );

                newPassButtonString = "+Pass...   " + icon[DOWNARROW];
                newPassButtonWidth = w;
                newPassButtonXposition = Main_ui_gap;

                newOverrideButtonString = "+Override" + icon[DOWNARROW];
                newOverrideButtonWidth = w;
                newOverrideButtonXposition = Main_ui_gap;

                editSelectedButtonString = "Edit " + icon[ENTERKEY];
                editSelectedButtonWidth = w;
                editSelectedButtonXposition = Main_ui_gap + w + (Main_ui_gap / 2);

                deleteSelectedButtonString = "Del " + icon[DELETEKEY];
                deleteSelectedButtonWidth = w;
                deleteSelectedButtonXposition = Main_ui_gap + 2 * (w + (Main_ui_gap / 2));

                w = integer( (listOneWidth + 22 - (3 * ( Main_ui_gap / 2) ) ) / 4 );

                addAllButtonString = "+All "+ icon[CTRLA];
                addAllButtonWidth = w;
                addAllButtonXposition = listTwoPosition;

                addSelButtonString = "+Sel";
                addSelButtonWidth = w;
                addSelButtonXposition = listTwoPosition + w + (Main_ui_gap / 2);

                clearAllButtonString = "-All";
                clearAllButtonWidth = w;
                clearAllButtonXposition = listTwoPosition + 2 * (w + (Main_ui_gap / 2));

                clearSelButtonString = "-Sel";
                clearSelButtonWidth = w;
                clearSelButtonXposition = listTwoPosition + 3 * (w + (Main_ui_gap / 2));

@if dev == 1
                // debug button is masked in release builds. X position to match the clear selected button. Y position matched from current pass gadget (hard-coded)
                debugButtonXposition = clearSelButtonXposition;
                debugButtonWidth = clearSelButtonWidth;
@end

                break;
                
            case 4:
                Main_panelWidth = Main_res4_panelWidth;
                Main_panelHeight = Main_res4_panelHeight;

                // 22 = List gadget scrollbar
                listOneWidth = listTwoWidth = integer( ( (Main_panelWidth - (3 * Main_ui_gap) ) - 44) / 2);
                listTwoPosition = listTwoWidth + 22 + (2 * Main_ui_gap);

                w = integer(( (listOneWidth + 22 - (3 * ( Main_ui_gap / 2) ) ) / 3) + 1 );

                newPassButtonString = "+Pass...   " + icon[DOWNARROW];
                newPassButtonWidth = w;
                newPassButtonXposition = Main_ui_gap;

                newOverrideButtonString = "+Override" + icon[DOWNARROW];
                newOverrideButtonWidth = w;
                newOverrideButtonXposition = Main_ui_gap;

                editSelectedButtonString = "Edit " + icon[ENTERKEY];
                editSelectedButtonWidth = w;
                editSelectedButtonXposition = Main_ui_gap + w + (Main_ui_gap / 2);

                deleteSelectedButtonString = "Del " + icon[DELETEKEY];
                deleteSelectedButtonWidth = w;
                deleteSelectedButtonXposition = Main_ui_gap + 2 * (w + (Main_ui_gap / 2));

                w = integer( (listOneWidth + 22 - (3 * ( Main_ui_gap / 2) ) ) / 4 );

                addAllButtonString = "+All "+ icon[CTRLA];
                addAllButtonWidth = w;
                addAllButtonXposition = listTwoPosition;

                addSelButtonString = "+Sel";
                addSelButtonWidth = w;
                addSelButtonXposition = listTwoPosition + w + (Main_ui_gap / 2);

                clearAllButtonString = "-All";
                clearAllButtonWidth = w;
                clearAllButtonXposition = listTwoPosition + 2 * (w + (Main_ui_gap / 2));

                clearSelButtonString = "-Sel";
                clearSelButtonWidth = w;
                clearSelButtonXposition = listTwoPosition + 3 * (w + (Main_ui_gap / 2));
                
@if dev == 1
                // debug button is masked in release builds. X position to match the clear selected button. Y position matched from current pass gadget (hard-coded)
                debugButtonXposition = clearSelButtonXposition;
                debugButtonWidth = clearSelButtonWidth;
@end

                break;
                
            default:
                Main_panelWidth = Main_res1_panelWidth;
                Main_panelHeight = Main_res1_panelHeight;

                // 22 = List gadget scrollbar
                listOneWidth = listTwoWidth = integer( ( (Main_panelWidth - (3 * Main_ui_gap) ) - 44) / 2);
                listTwoPosition = listTwoWidth + 22 + (2 * Main_ui_gap);

                w = integer(( (listOneWidth + 22 - (3 * ( Main_ui_gap / 2) ) ) / 3) + 1 );

                newPassButtonString = "New Pass...      " + icon[DOWNARROW];
                newPassButtonWidth = w;
                newPassButtonXposition = Main_ui_gap;

                newOverrideButtonString = "New Override... " + icon[DOWNARROW];
                newOverrideButtonWidth = w;
                newOverrideButtonXposition = Main_ui_gap;

                editSelectedButtonString = "Edit Selected  " + icon[ENTERKEY];
                editSelectedButtonWidth = w;
                editSelectedButtonXposition = Main_ui_gap + w + (Main_ui_gap / 2);

                deleteSelectedButtonString = "Del Selected   " + icon[DELETEKEY];
                deleteSelectedButtonWidth = w;
                deleteSelectedButtonXposition = Main_ui_gap + 2 * (w + (Main_ui_gap / 2));

                w = integer( (listOneWidth + 22 - (3 * ( Main_ui_gap / 2) ) ) / 4 );

                addAllButtonString = "Add All    "+ icon[CTRLA];
                addAllButtonWidth = w;
                addAllButtonXposition = listTwoPosition;

                addSelButtonString = "Add Sel    ";
                addSelButtonWidth = w;
                addSelButtonXposition = listTwoPosition + w + (Main_ui_gap / 2);

                clearAllButtonString = "Clear All";
                clearAllButtonWidth = w;
                clearAllButtonXposition = listTwoPosition + 2 * (w + (Main_ui_gap / 2));

                clearSelButtonString = "Clear Sel";
                clearSelButtonWidth = w;
                clearSelButtonXposition = listTwoPosition + 3 * (w + (Main_ui_gap / 2));

@if dev == 1
                // debug button is masked in release builds. X position to match the clear selected button. Y position matched from current pass gadget (hard-coded)
                debugButtonXposition = clearSelButtonXposition;
                debugButtonWidth = clearSelButtonWidth;
@end

                break;
        }

    // 22 = List gadget scrollbar
    listOneWidth = listTwoWidth = integer( ( (Main_panelWidth - (3 * Main_ui_gap) ) - 44) / 2);
    listTwoPosition = listTwoWidth + 22 + (2 * Main_ui_gap);

    // New UI layout code - Matt Gorner
    listOneHeight = Main_panelHeight - ( 3 * Main_button_height) - Main_banner_height - Main_spacer_height - ( 5 * Main_ui_y_spacer);

    // New UI layout code - Matt Gorner
    bottomPosition = Main_panelHeight - Main_button_height - Main_ui_y_spacer;

    doKeys = 1;

// end preprocess here      
}

reProcess
{
	if(supportedplatform != 1)
		return;
    if(justReopened != 1)
    {
        // and this bit just recatalogs the items so assignments are up to date
        if(sceneJustLoaded == 1)
        {
            doKeys = 1;
            masterScene = Scene();
            originalSelection = masterScene.getSelect();
            originalSelectionExists = true;

            meshAgents[1] = "none";
            currentChosenPass = 1;
            currentChosenPassString = passNames[currentChosenPass];
            image_formats_array = getImageFormats();
            sceneJustLoaded = 0;
        }
        
        if(meshAgents[1] != "none")
        {
            meshAgents = nil;
            meshNames = nil;
            meshIDs = nil;
            meshOldIDs = nil;
            EditObjects();
            SelectAllObjects();
            RefreshNow();
            s = masterScene.getSelect();
            idMapping = 1;
            if(s)
            {
                arraySize = size(s);
                for(x = 1; x <= arraySize; x++)
                {
                    itemname = s[x].name;
                    meshAgents[x] = Mesh(itemname);
                    meshNames[x] = meshAgents[x].name;
                    meshIDs[x] = meshAgents[x].id;
                    tempIDArray = parse("x",hex(meshIDs[x]));
                    meshOldIDs[x] = tempIDArray[2];
                }
            }
            else
            {
                meshAgents[1] = "none";
                reProcess();
            }
        
        }
        else
        {
            EditObjects();
            //info("starting");
            if(Mesh(0))
            {
                if(originalSelectionExists == nil)
                {
                    originalSelection = masterScene.getSelect();
                }
                meshAgents = nil;
                meshNames = nil;
                meshIDs = nil;
                meshOldIDs = nil;
                EditObjects();
                SelectAllObjects();
                RefreshNow();
                s = masterScene.getSelect();
                arraySize = size(s);
                for(x = 1; x <= arraySize; x++)
                {
                    itemname = s[x].name;
                    meshAgents[x] = Mesh(itemname);
                    meshNames[x] = meshAgents[x].name;
                    meshIDs[x] = meshAgents[x].id;
                    tempIDArray = parse("x",hex(meshIDs[x]));
                    meshOldIDs[x] = tempIDArray[2];
                }
            }
            else
            {
                meshAgents[1] = "none";
            }
        }
        itemname = nil;
        lightAgents = nil;
        lightNames = nil;
        lightIDs = nil;
        lightOldIDs = nil;
        EditObjects();
        EditLights();
        SelectAllLights();

        s = masterScene.getSelect();
        arraySize = size(s);
        for(x = 1; x <= arraySize; x++)
        {
            itemname = s[x].name;
            lightAgents[x] = Light(itemname);
            lightNames[x] = lightAgents[x].name;
            lightIDs[x] = lightAgents[x].id;
            tempIDArray = parse("x",hex(lightIDs[x]));
            lightOldIDs[x] = tempIDArray[2];
        }

        itemname = nil;
        cameraAgents = nil;
        cameraNames = nil;
        cameraIDs = nil;
        cameraOldIDs = nil;
        EditCameras();
        SelectAllCameras();

        s = masterScene.getSelect();
        arraySize = size(s);
        for(x = 1; x <= arraySize; x++)
        {
            itemname = s[x].name;
            cameraAgents[x] = Camera(itemname);
            cameraNames[x] = cameraAgents[x].name;
            cameraIDs[x] = cameraAgents[x].id;
            tempIDArray = parse("x",hex(cameraIDs[x]));
            cameraOldIDs[x] = tempIDArray[2];
        }

        idMapping = 0;
        displayNames = nil;
        displayIDs = nil;
        displayOldIDs = nil;
        x = 1;

        // Scene Master override setup
        o_displayNames = nil; // clear it out
        o_displayGenus = nil; // clear it out
        o_displayIDs = nil;
        o_displayNames[1] = "(Scene Master)";
        o_displayGenus[1] = 0;
        o_displayIDs[1] = "SM";
        
        for(y = 1; y <= size(meshAgents); y++)
        {
            if(meshAgents[1] != "none")
            {
                displayNames[x] = meshNames[y];
                o_displayNames[x+1] = meshNames[y];
                displayGenus[x] = MESH;
                o_displayGenus[x+1] = MESH;
                displayIDs[x] = meshIDs[y];
                o_displayIDs[x+1] = meshIDs[y];
                displayOldIDs[x] = meshOldIDs[y];
                x++;
            }
        }
        for(y = 1; y <= size(lightAgents); y++)
        {
            displayNames[x] = lightNames[y];
            o_displayNames[x+1] = lightNames[y];
            displayGenus[x] = LIGHT;
            o_displayGenus[x+1] = LIGHT;
            displayIDs[x] = lightIDs[y];
            o_displayIDs[x+1] = lightIDs[y];
            displayOldIDs[x] = lightOldIDs[y];
            x++;
        }

        for(y = 1; y <= size(cameraAgents); y++)
        {
            displayNames[x] = cameraNames[y];
            o_displayNames[x+1] = cameraNames[y];
            displayGenus[x] = CAMERA;
            o_displayGenus[x+1] = CAMERA;
            displayIDs[x] = cameraIDs[y];
            o_displayIDs[x+1] = cameraIDs[y];
            displayOldIDs[x] = cameraOldIDs[y];
            x++;
        }

        if(originalSelection != nil)
        {
            //info(originalSelection);
            SelectItem(originalSelection[1].id);
            for(x = 1; x <= size(originalSelection); x++)
            {
                AddToSelection(originalSelection[x].id);
            }
        }
        else
        {
            EditObjects();
        }
        currentChosenPassString = passNames[currentChosenPass];
        doKeys = 1;
        
        for(x = 1; x <= size(overrideNames); x++)
        {
            if(passOverrideItems)
            {
                if(passOverrideItems[currentChosenPass][x] != "" && overrideNames[1] != "empty")
                {
                    if(strleft(overrideNames[x],1) != " ")
                    {
                        overrideNames[x] = " " + icon[BULLET] + " " + overrideNames[x];
                    }
                }
                else
                {
                    if(strleft(overrideNames[x],1) == " ")
                    {
                        
                        settingsArray = parse("||",overrideSettings[x]);
                        settingsArrayNumber = integer(strright(settingsArray[2],1));
                        switch(settingsArrayNumber)
                        {
                            case 1:
                                overrideNames[x] = settingsArray[1] + "   (.srf file)";
                                break;
                                
                            case 2:
                                overrideNames[x] = settingsArray[1] + "   (object properties)";
                                break;
                                
                            case 3:
                                overrideNames[x] = settingsArray[1] + "   (.mot file)";
                                break;
                                
                            case 4:
                                overrideNames[x] = settingsArray[1] + "   (.lwo file)";
                                break;
                                
                            case 5:
                                overrideNames[x] = settingsArray[1] + "   (light properties)";
                                break;

                            case 6:
                                overrideNames[x] = settingsArray[1] + "   (scene properties)";
                                break;
                            
                            case 7:
                                overrideNames[x] = settingsArray[1] + "   (light exclusion)";
                                break;

                            case 8:
                                overrideNames[x] = settingsArray[1] + "   (camera)";
                                break;

                            default:
                                overrideNames[x] = settingsArray[1];
                                break;
                        }
                    }
                }
            }
        }
        
        
        // do the experimental scene master override setup
        o_displayNames[1] = "(Scene Master)";
        o_displayNamesObjectIndex = 1;
        o_displayNamesLightIndex = 1;
        o_displayNamesCameraIndex = 1;

        for(w = 1; w <= size(displayNames); w++)
        {
            o_displayNames[w + 1] = displayNames[w];
             // Populating filtered lists - will be used in UDF functions.
            if (displayGenus[w] == MESH) {
                o_displayNamesObject[o_displayNamesObjectIndex] = displayNames[w];
                o_displayNamesObjectIndex++;
            }
            if (displayGenus[w] == LIGHT) {
                o_displayNamesLight[o_displayNamesLightIndex] = displayNames[w];
                o_displayNamesLightIndex++;
            }

            if (displayGenus[w] == CAMERA) {
                o_displayNamesCamera[o_displayNamesCameraIndex] = displayNames[w];
                o_displayNamesCameraIndex++;
            }
        }

    }
    else
    {
        justReopened = 0;
    }

        switch(editorResolution)
        {
            case 1:
                Main_panelWidth = Main_res1_panelWidth;
                Main_panelHeight = Main_res1_panelHeight;
                
                // 22 = List gadget scrollbar
                listOneWidth = listTwoWidth = integer( ( (Main_panelWidth - (3 * Main_ui_gap) ) - 44) / 2);
                listTwoPosition = listTwoWidth + 22 + (2 * Main_ui_gap);

                w = integer(( (listOneWidth + 22 - (3 * ( Main_ui_gap / 2) ) ) / 3) + 1 );

                newPassButtonString = "New Pass...      " + icon[DOWNARROW];
                newPassButtonWidth = w;
                newPassButtonXposition = Main_ui_gap;

                newOverrideButtonString = "New Override... " + icon[DOWNARROW];
                newOverrideButtonWidth = w;
                newOverrideButtonXposition = Main_ui_gap;

                editSelectedButtonString = "Edit Selected  " + icon[ENTERKEY];
                editSelectedButtonWidth = w;
                editSelectedButtonXposition = Main_ui_gap + w + (Main_ui_gap / 2);

                deleteSelectedButtonString = "Del Selected   " + icon[DELETEKEY];
                deleteSelectedButtonWidth = w;
                deleteSelectedButtonXposition = Main_ui_gap + 2 * (w + (Main_ui_gap / 2));

                w = integer( (listOneWidth + 22 - (3 * ( Main_ui_gap / 2) ) ) / 4 );

                addAllButtonString = "Add All    "+ icon[CTRLA];
                addAllButtonWidth = w;
                addAllButtonXposition = listTwoPosition;

                addSelButtonString = "Add Sel    ";
                addSelButtonWidth = w;
                addSelButtonXposition = listTwoPosition + w + (Main_ui_gap / 2);

                clearAllButtonString = "Clear All";
                clearAllButtonWidth = w;
                clearAllButtonXposition = listTwoPosition + 2 * (w + (Main_ui_gap / 2));

                clearSelButtonString = "Clear Sel";
                clearSelButtonWidth = w;
                clearSelButtonXposition = listTwoPosition + 3 * (w + (Main_ui_gap / 2));

@if dev == 1
                // debug button is masked in release builds. X position to match the clear selected button. Y position matched from current pass gadget (hard-coded)
                debugButtonXposition = clearSelButtonXposition;
                debugButtonWidth = clearSelButtonWidth;
@end

                break;
                
            case 2:
                Main_panelWidth = Main_res2_panelWidth;
                Main_panelHeight = Main_res2_panelHeight;

                // 22 = List gadget scrollbar
                listOneWidth = listTwoWidth = integer( ( (Main_panelWidth - (3 * Main_ui_gap) ) - 44) / 2);
                listTwoPosition = listTwoWidth + 22 + (2 * Main_ui_gap);

                w = integer(( (listOneWidth + 22 - (3 * ( Main_ui_gap / 2) ) ) / 3) + 1 );

                newPassButtonString = "New Pass...      " + icon[DOWNARROW];
                newPassButtonWidth = w;
                newPassButtonXposition = Main_ui_gap;

                newOverrideButtonString = "New Override... " + icon[DOWNARROW];
                newOverrideButtonWidth = w;
                newOverrideButtonXposition = Main_ui_gap;

                editSelectedButtonString = "Edit Selected  " + icon[ENTERKEY];
                editSelectedButtonWidth = w;
                editSelectedButtonXposition = Main_ui_gap + w + (Main_ui_gap / 2);

                deleteSelectedButtonString = "Del Selected   " + icon[DELETEKEY];
                deleteSelectedButtonWidth = w;
                deleteSelectedButtonXposition = Main_ui_gap + 2 * (w + (Main_ui_gap / 2));

                w = integer( (listOneWidth + 22 - (3 * ( Main_ui_gap / 2) ) ) / 4 );

                addAllButtonString = "Add All    "+ icon[CTRLA];
                addAllButtonWidth = w;
                addAllButtonXposition = listTwoPosition;

                addSelButtonString = "Add Sel    ";
                addSelButtonWidth = w;
                addSelButtonXposition = listTwoPosition + w + (Main_ui_gap / 2);

                clearAllButtonString = "Clear All";
                clearAllButtonWidth = w;
                clearAllButtonXposition = listTwoPosition + 2 * (w + (Main_ui_gap / 2));

                clearSelButtonString = "Clear Sel";
                clearSelButtonWidth = w;
                clearSelButtonXposition = listTwoPosition + 3 * (w + (Main_ui_gap / 2));

@if dev == 1
                // debug button is masked in release builds. X position to match the clear selected button. Y position matched from current pass gadget (hard-coded)
                debugButtonXposition = clearSelButtonXposition;
                debugButtonWidth = clearSelButtonWidth;
@end

                break;

            case 3:
                Main_panelWidth = Main_res3_panelWidth;
                Main_panelHeight = Main_res3_panelHeight;

                // 22 = List gadget scrollbar
                listOneWidth = listTwoWidth = integer( ( (Main_panelWidth - (3 * Main_ui_gap) ) - 44) / 2);
                listTwoPosition = listTwoWidth + 22 + (2 * Main_ui_gap);
                
                w = integer(( (listOneWidth + 22 - (3 * ( Main_ui_gap / 2) ) ) / 3) + 1 );

                newPassButtonString = "+Pass...   " + icon[DOWNARROW];
                newPassButtonWidth = w;
                newPassButtonXposition = Main_ui_gap;

                newOverrideButtonString = "+Override" + icon[DOWNARROW];
                newOverrideButtonWidth = w;
                newOverrideButtonXposition = Main_ui_gap;

                editSelectedButtonString = "Edit " + icon[ENTERKEY];
                editSelectedButtonWidth = w;
                editSelectedButtonXposition = Main_ui_gap + w + (Main_ui_gap / 2);

                deleteSelectedButtonString = "Del " + icon[DELETEKEY];
                deleteSelectedButtonWidth = w;
                deleteSelectedButtonXposition = Main_ui_gap + 2 * (w + (Main_ui_gap / 2));

                w = integer( (listOneWidth + 22 - (3 * ( Main_ui_gap / 2) ) ) / 4 );

                addAllButtonString = "+All "+ icon[CTRLA];
                addAllButtonWidth = w;
                addAllButtonXposition = listTwoPosition;

                addSelButtonString = "+Sel";
                addSelButtonWidth = w;
                addSelButtonXposition = listTwoPosition + w + (Main_ui_gap / 2);

                clearAllButtonString = "-All";
                clearAllButtonWidth = w;
                clearAllButtonXposition = listTwoPosition + 2 * (w + (Main_ui_gap / 2));

                clearSelButtonString = "-Sel";
                clearSelButtonWidth = w;
                clearSelButtonXposition = listTwoPosition + 3 * (w + (Main_ui_gap / 2));

@if dev == 1
                    // debug button is masked in release builds. X position to match the clear selected button. Y position matched from current pass gadget (hard-coded)
                debugButtonXposition = clearSelButtonXposition;
                debugButtonWidth = clearSelButtonWidth;
@end

                break;
                
            case 4:
                Main_panelWidth = Main_res4_panelWidth;
                Main_panelHeight = Main_res4_panelHeight;

                // 22 = List gadget scrollbar
                listOneWidth = listTwoWidth = integer( ( (Main_panelWidth - (3 * Main_ui_gap) ) - 44) / 2);
                listTwoPosition = listTwoWidth + 22 + (2 * Main_ui_gap);

                w = integer(( (listOneWidth + 22 - (3 * ( Main_ui_gap / 2) ) ) / 3) + 1 );

                newPassButtonString = "+Pass...   " + icon[DOWNARROW];
                newPassButtonWidth = w;
                newPassButtonXposition = Main_ui_gap;

                newOverrideButtonString = "+Override" + icon[DOWNARROW];
                newOverrideButtonWidth = w;
                newOverrideButtonXposition = Main_ui_gap;

                editSelectedButtonString = "Edit " + icon[ENTERKEY];
                editSelectedButtonWidth = w;
                editSelectedButtonXposition = Main_ui_gap + w + (Main_ui_gap / 2);

                deleteSelectedButtonString = "Del " + icon[DELETEKEY];
                deleteSelectedButtonWidth = w;
                deleteSelectedButtonXposition = Main_ui_gap + 2 * (w + (Main_ui_gap / 2));

                w = integer( (listOneWidth + 22 - (3 * ( Main_ui_gap / 2) ) ) / 4 );

                addAllButtonString = "+All "+ icon[CTRLA];
                addAllButtonWidth = w;
                addAllButtonXposition = listTwoPosition;

                addSelButtonString = "+Sel";
                addSelButtonWidth = w;
                addSelButtonXposition = listTwoPosition + w + (Main_ui_gap / 2);

                clearAllButtonString = "-All";
                clearAllButtonWidth = w;
                clearAllButtonXposition = listTwoPosition + 2 * (w + (Main_ui_gap / 2));

                clearSelButtonString = "-Sel";
                clearSelButtonWidth = w;
                clearSelButtonXposition = listTwoPosition + 3 * (w + (Main_ui_gap / 2));

@if dev == 1
                // debug button is masked in release builds. X position to match the clear selected button. Y position matched from current pass gadget (hard-coded)
                debugButtonXposition = clearSelButtonXposition;
                debugButtonWidth = clearSelButtonWidth;
@end

                break;
                
            default:
                Main_panelWidth = Main_res1_panelWidth;
                Main_panelHeight = Main_res1_panelHeight;

                // 22 = List gadget scrollbar
                listOneWidth = listTwoWidth = integer( ( (Main_panelWidth - (3 * Main_ui_gap) ) - 44) / 2);
                listTwoPosition = listTwoWidth + 22 + (2 * Main_ui_gap);

                w = integer(( (listOneWidth + 22 - (3 * ( Main_ui_gap / 2) ) ) / 3) + 1 );

                newPassButtonString = "New Pass...      " + icon[DOWNARROW];
                newPassButtonWidth = w;
                newPassButtonXposition = Main_ui_gap;

                newOverrideButtonString = "New Override... " + icon[DOWNARROW];
                newOverrideButtonWidth = w;
                newOverrideButtonXposition = Main_ui_gap;

                editSelectedButtonString = "Edit Selected  " + icon[ENTERKEY];
                editSelectedButtonWidth = w;
                editSelectedButtonXposition = Main_ui_gap + w + (Main_ui_gap / 2);

                deleteSelectedButtonString = "Del Selected   " + icon[DELETEKEY];
                deleteSelectedButtonWidth = w;
                deleteSelectedButtonXposition = Main_ui_gap + 2 * (w + (Main_ui_gap / 2));

                w = integer( (listOneWidth + 22 - (3 * ( Main_ui_gap / 2) ) ) / 4 );

                addAllButtonString = "Add All    "+ icon[CTRLA];
                addAllButtonWidth = w;
                addAllButtonXposition = listTwoPosition;

                addSelButtonString = "Add Sel    ";
                addSelButtonWidth = w;
                addSelButtonXposition = listTwoPosition + w + (Main_ui_gap / 2);

                clearAllButtonString = "Clear All";
                clearAllButtonWidth = w;
                clearAllButtonXposition = listTwoPosition + 2 * (w + (Main_ui_gap / 2));

                clearSelButtonString = "Clear Sel";
                clearSelButtonWidth = w;
                clearSelButtonXposition = listTwoPosition + 3 * (w + (Main_ui_gap / 2));

@if dev == 1
                // debug button is masked in release builds. X position to match the clear selected button. Y position matched from current pass gadget (hard-coded)
                debugButtonXposition = clearSelButtonXposition;
                debugButtonWidth = clearSelButtonWidth;
@end

                break;
        }


    // 22 = List gadget scrollbar
    listOneWidth = listTwoWidth = integer( ( (Main_panelWidth - (3 * Main_ui_gap) ) - 44) / 2);
    listTwoPosition = listTwoWidth + 22 + (2 * Main_ui_gap);

    // New UI layout code - Matt Gorner
    listOneHeight = Main_panelHeight - ( 3 * Main_button_height) - Main_banner_height - Main_spacer_height - ( 5 * Main_ui_y_spacer);

    // New UI layout code - Matt Gorner
    bottomPosition = Main_panelHeight - Main_button_height - Main_ui_y_spacer;

    doKeys = 1;
}

unProcess
{
	if(supportedplatform != 1)
		return;
		
    // clears out all the variables
    
    if(reqisopen())  {
        reqend();  }
    scenesnames = nil;
    passSelected = nil;
    overridesSelected = nil;
    passAssItems = nil;

@if enablePBS == 1
    passBufferExporters = nil;
@end

    passOverrideItems = nil;
    masterScene = nil;
    originalSelection = nil;
    meshAgents = nil;
    meshNames = nil;
    meshIDs = nil;
    lightAgents = nil;
    lightNames = nil;
    lightIDs = nil;
    cameraAgents = nil;
    cameraNames = nil;
    cameraIDs = nil;
    displayNames = nil;
    displayIDs = nil;
    passNames = nil;
    overrideNames = nil;
    gad_PassesListview = nil;
    gad_OverridesListview = nil;
    gad_SceneItems_forPasses_Listview = nil;
    gad_SceneItems_forOverrides_Listview = nil;
    gad_SelectedPass = nil;
    currentChosenPass = nil;
    currentChosenPassString = nil;
    interfaceRunYet = nil;
}

req_update
{
	if(supportedplatform != 1)
		return;
    refreshing = true;
    requpdate();
    refreshing = false;
}


