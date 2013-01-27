
// build 0001
// version 1.1.3
//--------------------------------------
// PassPort
// by Jeremy Hardin
// LightWave 9.6 fix - Matt Gorner

/*
	About:
		This is a master script that uses a catalog of scene items and
		allows assignment of those scene items to new groups, called
		Passes.  Each pass has it's own rendered output, so an object
		can be included/excluded according to need with each pass.
		Also, each pass has an Override system, which gives the user
		the opportunity to alter properties on a per-pass basis.
		Things like surfaces, motions, object properties, etc. can
		be overridden on a per-object, per-pass basis.

	Script Logic:
		The logic is this.  There are 4 listboxes for the interface.  One
		holds a list of passes (user created).  This list grows and shrinks
		based on user input, but one pass will always exist.
		An acompanying scene items listbox holds all non-camera scene items
		for assignment in passes.  Selecting a pass in the first listbox will
		allow the user to select any combination of scene items in the second
		listbox.  Clicking on each pass will auto-select assigned scene items
		in the second listbox.
		The second tab is for overrides, and contains 2 more listboxes.  These
		listboxes reflect the overrides, and do so based on which pass is
		selected in a pass menu above the listboxes.  The selection system is
		the same as the pass system, but this one changes based on what pass
		is selected, and there don't have to be overrides.
		
	Render Logic:
		On render, the script takes the pass selected in the pulldown menu,
		gets the item assignments, and writes out a new scene file to a
		location specified in the preferences.  This is a render only scene
		and is never to be loaded by the user.  I will likely have it deleted
		when I'm finished.  No filenames are specified directly.  The names of
		the render come from the pass name, the user specified prefix, and the
		user field.  Appropriate directories are created using this information.
		
	Files in this setup:
		I've tried to name the files appropriate to the functions located in them.
		A fair bit of scene parsing happens, so I've put that in the scene parse
		subfuctions script.  Additional sub-interfaces have been put in the interface
		subfuction, and so on.
		
		
	Multi-dimensional array hack:
		This is my way of allowing 3 dimensional arrays in lscript, and it's specific to
		the override assignments.  I use 2 dpmensional arrays, with strings in each element.
		Each string is parseable to reveal a third dimension of elements (separated by the
		double pipe symbol "||").
*/
//
//--------------------------------------
@asyncspawn
@warnings
@script master
@name "PassPort_MC"

// Inserts other functions ...
@if platform == MACINTOSH
//@insert "Macintosh HD:Users:jezza:Documents:Projects:Lscript:passEditor:0050:passEditor_Interface_Subfuncs.ls"
//@insert "Macintosh HD:Users:jezza:Documents:Projects:Lscript:passEditor:0050:passEditor_render_Subfuncs.ls"
//@insert "Macintosh HD:Users:jezza:Documents:Projects:Lscript:passEditor:0050:passEditor_sceneGen_Subfuncs.ls"
//@insert "Macintosh HD:Users:jezza:Documents:Projects:Lscript:passEditor:0050:passEditor_sceneParse_Subfuncs.ls"
@insert "@passEditor_Interface_Subfuncs.ls"
@insert "@passEditor_render_Subfuncs.ls"
@insert "@passEditor_sceneGen_Subfuncs.ls"
@insert "@passEditor_sceneParse_Subfuncs.ls"
@end
@if platform == MACUB
//@insert "/Users/jezza/Documents/Projects/Lscript/passEditor/0050/passEditor_Interface_Subfuncs.ls"
//@insert "/Users/jezza/Documents/Projects/Lscript/passEditor/0050/passEditor_render_Subfuncs.ls"
//@insert "/Users/jezza/Documents/Projects/Lscript/passEditor/0050/passEditor_sceneGen_Subfuncs.ls"
//@insert "/Users/jezza/Documents/Projects/Lscript/passEditor/0050/passEditor_sceneParse_Subfuncs.ls"
@insert "@passEditor_Interface_Subfuncs.ls"
@insert "@passEditor_render_Subfuncs.ls"
@insert "@passEditor_sceneGen_Subfuncs.ls"
@insert "@passEditor_sceneParse_Subfuncs.ls"
@end
@if platform == INTEL
//@insert "C:/Users/Matt/Desktop/LightWave10_64/support/plugins/custom/PassPort/passEditor_Interface_Subfuncs.ls"
//@insert "C:/Users/Matt/Desktop/LightWave10_64/support/plugins/custom/PassPort/passEditor_render_Subfuncs.ls"
//@insert "C:/Users/Matt/Desktop/LightWave10_64/support/plugins/custom/PassPort/passEditor_sceneGen_Subfuncs.ls"
//@insert "C:/Users/Matt/Desktop/LightWave10_64/support/plugins/custom/PassPort/passEditor_sceneParse_Subfuncs.ls"
@insert "@passEditor_Interface_Subfuncs.ls"
@insert "@passEditor_render_Subfuncs.ls"
@insert "@passEditor_sceneGen_Subfuncs.ls"
@insert "@passEditor_sceneParse_Subfuncs.ls"
@end

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




// globals
var buildString = "(build 0001)";
var versionString = " v1.1.3";
var registeredToName;
var icon;
var scenesnames;
var passSelected = false;
var overridesSelected = false;
var passAssItems;
var previousPassAssItems;
var passOverrideItems;
var previousPassOverrideItems;
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

var newPassButtonString;
var newPassButtonXposition;
var newPassButtonWidth;
var newOverrideButtonString;
var newOverrideButtonXposition;
var newOverrideButtonWidth;
var editSelectedButtonString;
var editSelectedButtonWidth;
var editSelectedButtonXposition;
var deleteSelectedButtonString;
var deleteSelectedButtonWidth;
var deleteSelectedButtonXposition;
var addAllButtonString;
var addAllButtonWidth;
var addAllButtonXposition;
var addSelButtonString;
var addSelButtonWidth;
var addSelButtonXposition;
var clearAllButtonString;
var clearAllButtonWidth;
var clearAllButtonXposition;
var clearSelButtonString;
var clearSelButtonWidth;
var clearSelButtonXposition;
var listTwoPosition;
var listOneWidth;
var listTwoWidth;
var bottomPosition;
var loadingInProgress;
var justReopened;
var beingEscaped;

// UI layout variables
// Matt Gorner

var banner_height	= 64;
var button_height	= 19;
var spacer_height	= 3;
var ui_y_spacer		= 4;
var ui_gap			= 5;

// need for hacky saving
var needHackySaving;

// registration variables
var dongleCheckVar;
var registeredDonglesVar;

// Quick dongle check disabling (for opensource distribution) - Matt Gorner 28.06.2010
var nodonglecheck = TRUE;

// typical interface functions for master script here
create
{
	loadingInProgress = 0;
	justReopened = 0;


	// The next stuff, I changed per user before compiling. The 'dongleCheckFunction()'
	// from the _Interface_Subfuncs file uses the dongle IDs to check registration
	// and the registeredToName goes into the about box of the interface
	// The registeredDonglesVar array could be as big as it needed to be. I just
	// added to it depending on the number of licenses. Two are below, as an example.
	
	registeredDonglesVar[1] = 12345;  // me, jezza hardin, or it was, anyway

	registeredToName = "A LightWave User";

	//panelWidth = 640;
	panelWidth = integer(globalrecall("passEditorpanelWidth", 640));
	//panelHeight = 540;
	panelHeight = integer(globalrecall("passEditorpanelHeight", 540));
	panelWidthOnOpen = panelWidth;

	// 22 = List gadget scrollbar
	listOneWidth = listTwoWidth = integer( ( (panelWidth - (3 * ui_gap) ) - 44) / 2);
	listTwoPosition = listTwoWidth + 22 + (2 * ui_gap);

	// New UI layout code - Matt Gorner
	listOneHeight = panelHeight - ( 3 * button_height) - banner_height - spacer_height - ( 5 * ui_y_spacer);
	//listOneHeight = integer((integer(panelHeight) / 1.11) - ((integer(panelHeight) / 27) + 27));

	icon[BLANK] = Icon(blank_icon);
	icon[ENTERKEY] = Icon(enterkey_icon);
	icon[DELETEKEY] = Icon(deletekey_icon);
	icon[CTRLA] = Icon(ctrlA_icon);
	icon[DOWNARROW] = Icon(downarrow_icon);
	icon[LETTERO] = Icon(lettero_icon);
	icon[CTRLR] = Icon(ctrlR_icon);
	icon[BULLET] = Icon(bullet_icon);
	setdesc("PassPort" + versionString);
	sceneJustSaved = 0;
	sceneJustLoaded = 0;
	if(hostBuild() >= 1281)
	{
		needHackySaving = 0;
	}
	else
	{
		needHackySaving = 1;
	}
	
	fileMenu_items = @"Save Pass as Scene...","Save All Passes As Scenes...","Render Pass Frame","Render Pass Scene","Render All Passes","==","Update Lists Now      "+ icon[CTRLR],"Preferences...          " + icon[LETTERO],"Render Globals...","==","Save Current Settings...","Load Settings...","About PassPort..."@;

	dongleCheckVar = dongleCheckFunction(registeredDonglesVar);
	if(nodonglecheck == TRUE)
		dongleCheckVar = 1;

	//preProcess();
	
	comringattach("LW_PassPort","getCommand");
}

destroy
{
	unProcess();
}

options
{
	if(dongleCheckVar == 1)
	{
	
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


		this_script = split(SCRIPTID);
		this_script_path = this_script[1] + this_script[2];

		// Check if the script is compiled, if so, don't need to find the banner images on disk
		compiled = 1;
		s = strsub(this_script[4], size(this_script[4]), 1);
		if(s =="s" || s =="S")
		{
			compiled = 0;
		}

	    reqbegin("PassPort Editor" + versionString);
	    reqsize(panelWidth,panelHeight);
	    //panelWidthOnOpen = panelWidth;
   
		// New UI layout code - Matt Gorner

		// Banner Graphic
		if(compiled)
		{
			switch(editorResolution)
			{
				case 1:
					// banner_filename = "Passport_Banner_640.tga";
					c_banner = ctlimage( "Passport_Banner_640.tga" );
					break;

				case 2:
					// banner_filename = "Passport_Banner_640.tga";
					c_banner = ctlimage( "Passport_Banner_640.tga" );
					break;

				case 3:
					// banner_filename = "Passport_Banner_457.tga";
					c_banner = ctlimage( "Passport_Banner_457.tga" );
				break;

				case 4:
					// banner_filename = "Passport_Banner_457.tga";
					c_banner = ctlimage( "Passport_Banner_457.tga" );
					break;

				default:
					// banner_filename = "Passport_Banner_640.tga";
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

		buttonHeight = 19;
   
	    file_popup_menu = ctlmenu("File...           " + icon[DOWNARROW],fileMenu_items,"fileMenu_select","fileMenu_active");
	    ctlposition(file_popup_menu, ui_gap, banner_height + 5);
	    
	    //c0_25 = ctlsep();
	    //ctlposition(c0_25,0, banner_height + 29);

	    c0_5 = ctltab("Passes","Overrides");
	    ctlposition(c0_5, 0, banner_height + 35);

	    gad_PassesListview = ctllistbox("Render Passes",listOneWidth,listOneHeight,"passeslb_count","passeslb_name","passeslb_event");
	    ctlposition(gad_PassesListview, ui_gap, banner_height + 55);

	    gad_OverridesListview = ctllistbox("Item Overrides",listOneWidth,listOneHeight,"overrideslb_count","overrideslb_name","overrideslb_event");
	    ctlposition(gad_OverridesListview, ui_gap, banner_height + 55);

	    c3 = ctllistbox("Scene Items",listTwoWidth,listOneHeight,"itemslb_count","itemslb_name","itemslb_event");
	    ctlposition(c3,listTwoPosition, banner_height + 55);
   
	    c3_5 = ctllistbox("Scene Items",listTwoWidth,listOneHeight,"o_itemslb_count","o_itemslb_name","o_itemslb_event");
	    ctlposition(c3_5,listTwoPosition, banner_height + 55);

	    c4 = ctlmenu(newPassButtonString,passMenu_items,"passMenu_select","passMenu_active");
	    ctlposition(c4,newPassButtonXposition,bottomPosition,newPassButtonWidth,button_height);
   
	    c5 = ctlmenu(newOverrideButtonString,overrideMenu_items,"overrideMenu_select","overrideMenu_active");
	    ctlposition(c5,newOverrideButtonXposition,bottomPosition,newOverrideButtonWidth,button_height);
   
	    c5_01 = ctlbutton(editSelectedButtonString,editSelectedButtonWidth,"editSelectedPass");
	    ctlposition(c5_01,editSelectedButtonXposition,bottomPosition);
   
	    c5_02 = ctlbutton(deleteSelectedButtonString,deleteSelectedButtonWidth,"deleteSelectedPass");
	    ctlposition(c5_02,deleteSelectedButtonXposition,bottomPosition);
   
	    c5_05 = ctlbutton(editSelectedButtonString,editSelectedButtonWidth,"editSelectedOverride");
	    ctlposition(c5_05,editSelectedButtonXposition,bottomPosition);
   
	    c5_06 = ctlbutton(deleteSelectedButtonString, deleteSelectedButtonWidth, "deleteSelectedOverride");
	    ctlposition(c5_06,deleteSelectedButtonXposition,bottomPosition);
   
	    c5_10 = ctlbutton(addAllButtonString,addAllButtonWidth,"addAllButton");
	    ctlposition(c5_10,addAllButtonXposition,bottomPosition);
   
	    c5_15 = ctlbutton(addSelButtonString,addSelButtonWidth,"addSelButton");
	    ctlposition(c5_15,addSelButtonXposition,bottomPosition);
   
	    c5_20 = ctlbutton(clearAllButtonString,clearAllButtonWidth,"clearAllButton");
	    ctlposition(c5_20,clearAllButtonXposition,bottomPosition);
   
	    c5_25 = ctlbutton(clearSelButtonString,clearSelButtonWidth,"clearSelButton");
	    ctlposition(c5_25,clearSelButtonXposition,bottomPosition);
   
	    c5_30 = ctlbutton(addAllButtonString,addAllButtonWidth,"o_addAllButton");
	    ctlposition(c5_30,addAllButtonXposition,bottomPosition);
   
	    c5_35 = ctlbutton(addSelButtonString,addSelButtonWidth,"o_addSelButton");
	    ctlposition(c5_35,addSelButtonXposition,bottomPosition);
   
	    c5_40 = ctlbutton(clearAllButtonString,clearAllButtonWidth,"o_clearAllButton");
	    ctlposition(c5_40,clearAllButtonXposition,bottomPosition);
   
	    c5_45 = ctlbutton(clearSelButtonString,clearSelButtonWidth,"o_clearSelButton");
	    ctlposition(c5_45,clearSelButtonXposition,bottomPosition);

	    // gad_SelectedPass = ctlmenu("Current Pass...  " + icon[DOWNARROW],passNames,"currentPassMenu_select");
	    // ctlposition(gad_SelectedPass,95, banner_height + 5);
	    gad_SelectedPass = ctlpopup("Current Pass :",currentChosenPass,"currentPassMenu_update");
	    ctlposition(gad_SelectedPass, 100, banner_height + 5, 300, buttonHeight);
	    ctlrefresh(gad_SelectedPass, "currentPassMenu_refresh");

	    //c7 = ctltext(currentChosenPassString,"");
	    //ctlposition(c7, 208, banner_height + 8);

	    ctlpage(1,gad_PassesListview,c3,c4,c5_01,c5_02,c5_10,c5_15,c5_20,c5_25);
	    ctlpage(2,gad_OverridesListview,c3_5,c5,c5_05,c5_06,c5_30,c5_35,c5_40,c5_45);

	    //reqresize("resizePanel",panelWidth,panelHeight,panelWidth,panelHeight);

		reqredraw("req_redraw");
	    reqopen();

	}
	else
	{
		if(dongleCheckVar == 3)
		{
			error("PassPort doesn't run on this version of LightWave.  Please use with LW 9.3.1 or later.");
		}
		else
		{
			if(dongleCheckVar == 2)
			{
				error("PassPort doesn't run on CFM Mac LightWave.  Please use with Universal Binary Mac LightWave");
			}
			else
			{
				if(nodonglecheck == FALSE)
					error("Hardware Lock ID doesn't match license.  Please purchase PassPort from http:\/\/www.lwpassport.com");
			}
		}
	}
} // end options

load: what,io
	{
		loadingInProgress = 1;
		if(what == SCENEMODE)
		{
			passNamesSize = io.read().asInt();
			for(x = 1; x <= passNamesSize; x++)
			{
				passNames[x] = io.read();
				passAssItems[x] = io.read();
				if(passAssItems[x] == nil)
				{
					passAssItems[x] = "";
				}
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
			areYouSurePrompts = io.read().asInt();
			useHackyUpdates = io.read().asInt();
			rgbSaveType = io.read().asInt();
			editorResolution = io.read().asInt();
			testResMultiplier = io.read().asInt();
			testRgbSaveType = io.read().asInt();
			
			//panelWidth = 640;
			//panelWidth = integer(globalrecall("passEditorpanelWidth", 640));
			//panelHeight = 540;
			//panelHeight = integer(globalrecall("passEditorpanelHeight", 540));

			//dongleCheckVar = dongleCheckFunction(registeredDonglesVar);
			setdesc("PassPort" + versionString);
			sceneJustLoaded = 1;
			interfaceRunYet = 1;
			sceneJustSaved = 0;
		}
	}
	
	save: what,io
	{
		if(what == SCENEMODE)
		{	
			if(sceneJustLoaded == 1 || interfaceRunYet == 1)
			{

				// set up my hacky replacement system
				replaceCount = 0;
				
				passNamesSize = size(passNames);
				io.writeln(passNamesSize);
				for(x = 1; x <= passNamesSize; x++)
				{
					io.writeln(passNames[x]);
					if(needHackySaving == 1)
					{
						if(size(passAssItems[x]) <= 99)
						{
							io.writeln(passAssItems[x]);
						}
						else
						{
							replaceCount++;
							io.writeln("REPLACEME " + string(replaceCount));
							replaceMeVar[replaceCount] = passAssItems[x];
						}
					}
					else
					{
							io.writeln(passAssItems[x]);
					}
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
					if(needHackySaving == 1)
					{
						if(size(overrideSettings[1]) <= 99)
						{
							io.writeln(overrideSettings[1]);
						}
						else
						{
							replaceCount++;
							io.writeln("REPLACEME " + string(replaceCount));
							replaceMeVar[replaceCount] = overrideSettings[1];
						}
					}
					else
					{
							io.writeln(overrideSettings[1]);
					}
				}
				if(overrideNamesSize > 1)
				{
					for(x = 2; x <= overrideNamesSize; x++)
					{
						io.writeln(overrideNames[x]);
						if(overrideNames[1] != "empty")
						{
							if(needHackySaving == 1)
							{
								if(size(overrideSettings[x]) <= 99)
								{
									io.writeln(overrideSettings[x]);
								}
								else
								{
									replaceCount++;
									io.writeln("REPLACEME " + string(replaceCount));
									replaceMeVar[replaceCount] = overrideSettings[x];
								}
							}
							else
							{
									io.writeln(overrideSettings[x]);
							}
							
						}
					}
				}
				
				for(x = 1; x <= passNamesSize; x++)
				{
					for(y = 1; y <= overrideNamesSize; y++)
					{
						if(overrideNames[1] != "empty")
						{
							if(needHackySaving == 1)
							{
								if(size(passOverrideItems[x][y]) <= 99)
								{
									io.writeln(passOverrideItems[x][y]);
								}
								else
								{
									replaceCount++;
									io.writeln("REPLACEME " + string(replaceCount));
									replaceMeVar[replaceCount] = passOverrideItems[x][y];
								}
							}
							else
							{
									io.writeln(passOverrideItems[x][y]);
							}
							
						}
					}
				}
				io.writeln(userOutputFolder);
				io.writeln(fileOutputPrefix);
				io.writeln(userOutputString);
				io.writeln(areYouSurePrompts);
				io.writeln(useHackyUpdates);
				io.writeln(rgbSaveType);
				io.writeln(editorResolution);
				io.writeln(testResMultiplier);
				io.writeln(testRgbSaveType);
				
				sceneJustSaved = 1;
				unsaved = 0;
				if(replaceCount > 0)
				{
					//warn("Hacky scene-saving hasn't completed.  Please don't close or clear Layout yet!");
				}
				
				globalstore("passEditoruserOutputString",userOutputString);
				globalstore("passEditorareYouSurePrompts",areYouSurePrompts);
				globalstore("passEditoruseHackyUpdates",useHackyUpdates);
				globalstore("passEditorrgbSaveType",rgbSaveType);
				globalstore("passEditoreditorResolution",editorResolution);
				globalstore("passEditortestResMultiplier",testResMultiplier);
				globalstore("passEditortestRgbSaveType",testRgbSaveType);
			}

		}

	}
	
	flags
	{
	  return(SCENE,LWMASTF_RECEIVE_NOTIFICATIONS);
	}
	


process: event, command
{

	// Was getting an error when a scene was reloaded, but only happened once, so this might not be needed
	/* if (event == LWEVNT_NOTIFY_SCENE_CLEAR_STARTING)
	{
		unProcess();
	} */

	if(command)
	{
		if(size(command) >= 10)
		{
			if(strleft(command,10) == "SaveScene ")
			{
				if(replaceCount > 0)
				{
					if(unsaved == 0)
					{
						if(needHackySaving == 1)
						{
							doHackyReplacing();
						}
						//info("Hacky scene-saving complete.  It's safe to close or clear now.");
					}
				}
				sceneJustSaved = 0;
			}
		}
	}
}







// custom interface functions below here
	preProcess
	{
		// this bit is basically just cataloging scene items and setting up initial values for variables
		masterScene = Scene();
		//if(masterScene.getSelect() != nil)
		//{
			originalSelection = masterScene.getSelect();
		//}
		
		EditObjects();
		platformVar = platform();
		image_formats_array = getImageFormats();
		
		// Set 'userOutputFolder' to "Content/Passport_Passes" by default - Matt Gorner
		userOutputFolder = getdir("Content") + getsep() + "PassPort_Passes";
		//userOutputString = "";
		userOutputString = string(globalrecall("passEditoruserOutputString",""));
		//areYouSurePrompts = 1;
		areYouSurePrompts = integer(globalrecall("passEditorareYouSurePrompts", 1));
		//useHackyUpdates = 1;
		useHackyUpdates = integer(globalrecall("passEditoruseHackyUpdates", 0));
		//rgbSaveType = 1;
		rgbSaveType = integer(globalrecall("passEditorrgbSaveType", 1));
		//editorResolution = 1;
		editorResolution = integer(globalrecall("passEditoreditorResolution", 1));
		//testResMultiplier = 3;
		testResMultiplier = integer(globalrecall("passEditortestResMultiplier", 3));
		//testRgbSaveType = 1;
		testRgbSaveType = integer(globalrecall("passEditortestRgbSaveType", 1));
		
		
		interfaceRunYet = 0;
		doKeys = 1;
		idMapping = 1;
		if(Mesh(0))
		{
			SelectAllObjects();
			//if(masterScene.getSelect() != nil)
			//{
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
			//}
		}
		else
		{
			//if(masterScene.getSelect() != nil)
			//{
				//originalSelection = masterScene.getSelect();
			//}
			meshAgents[1] = "none";
	    }
	    EditObjects();
	    EditLights();
	    SelectAllLights();
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
	    //if(masterScene.getSelect() != nil)
		//{
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
		//}
		    idMapping = 0;
			x = 1;
		    for(y = 1; y <= size(meshAgents); y++)
		    {
		    	if(meshAgents[1] != "none")
		    	{
		    		displayNames[x] = meshNames[y];
		    		displayIDs[x] = meshIDs[y];
		    		displayOldIDs[x] = meshOldIDs[y];
		    		x++;
		    	}
		    }
		    for(y = 1; y <= size(lightAgents); y++)
		    {
		   		displayNames[x] = lightNames[y];
		   		displayIDs[x] = lightIDs[y];
		   		displayOldIDs[x] = lightOldIDs[y];
		   		x++;
		   	}
		   	passNames[1] = "Default";
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
			
		    // do the experimental scene master override setup
		    o_displayNames[1] = "(Scene Master)";
		    for(w = 1; w <= size(displayNames); w++)
		    {
		    	o_displayNames[w + 1] = displayNames[w];
		    }
		    
			if(loadingInProgress != 1)
			{
				//preferencePanel();
			}
			else
			{
				loadingInProgress = 0;
			}

			switch(editorResolution)
			{
				case 1:
					panelWidth = 640;
					panelHeight = 540;
					
					// 22 = List gadget scrollbar
					listOneWidth = listTwoWidth = integer( ( (panelWidth - (3 * ui_gap) ) - 44) / 2);
					listTwoPosition = listTwoWidth + 22 + (2 * ui_gap);

					w = integer(( (listOneWidth + 22 - (3 * ( ui_gap / 2) ) ) / 3) + 1 );

					newPassButtonString = "New Pass...      " + icon[DOWNARROW];
					newPassButtonWidth = w;
					newPassButtonXposition = ui_gap;

					newOverrideButtonString = "New Override... " + icon[DOWNARROW];
					newOverrideButtonWidth = w;
					newOverrideButtonXposition = ui_gap;

					editSelectedButtonString = "Edit Selected  " + icon[ENTERKEY];
					editSelectedButtonWidth = w;
					editSelectedButtonXposition = ui_gap + w + (ui_gap / 2);

					deleteSelectedButtonString = "Del Selected   " + icon[DELETEKEY];
					deleteSelectedButtonWidth = w;
					deleteSelectedButtonXposition = ui_gap + 2 * (w + (ui_gap / 2));

					w = integer( (listOneWidth + 22 - (3 * ( ui_gap / 2) ) ) / 4 );

					addAllButtonString = "Add All    "+ icon[CTRLA];
					addAllButtonWidth = w;
					addAllButtonXposition = listTwoPosition;

					addSelButtonString = "Add Sel    ";
					addSelButtonWidth = w;
					addSelButtonXposition = listTwoPosition + w + (ui_gap / 2);

					clearAllButtonString = "Clear All";
					clearAllButtonWidth = w;
					clearAllButtonXposition = listTwoPosition + 2 * (w + (ui_gap / 2));

					clearSelButtonString = "Clear Sel";
					clearSelButtonWidth = w;
					clearSelButtonXposition = listTwoPosition + 3 * (w + (ui_gap / 2));

					break;
					
				case 2:
					panelWidth = 640;
					panelHeight = 385;

					// 22 = List gadget scrollbar
					listOneWidth = listTwoWidth = integer( ( (panelWidth - (3 * ui_gap) ) - 44) / 2);
					listTwoPosition = listTwoWidth + 22 + (2 * ui_gap);

					w = integer(( (listOneWidth + 22 - (3 * ( ui_gap / 2) ) ) / 3) + 1 );

					newPassButtonString = "New Pass...      " + icon[DOWNARROW];
					newPassButtonWidth = w;
					newPassButtonXposition = ui_gap;

					newOverrideButtonString = "New Override... " + icon[DOWNARROW];
					newOverrideButtonWidth = w;
					newOverrideButtonXposition = ui_gap;

					editSelectedButtonString = "Edit Selected  " + icon[ENTERKEY];
					editSelectedButtonWidth = w;
					editSelectedButtonXposition = ui_gap + w + (ui_gap / 2);

					deleteSelectedButtonString = "Del Selected   " + icon[DELETEKEY];
					deleteSelectedButtonWidth = w;
					deleteSelectedButtonXposition = ui_gap + 2 * (w + (ui_gap / 2));

					w = integer( (listOneWidth + 22 - (3 * ( ui_gap / 2) ) ) / 4 );

					addAllButtonString = "Add All    "+ icon[CTRLA];
					addAllButtonWidth = w;
					addAllButtonXposition = listTwoPosition;

					addSelButtonString = "Add Sel    ";
					addSelButtonWidth = w;
					addSelButtonXposition = listTwoPosition + w + (ui_gap / 2);

					clearAllButtonString = "Clear All";
					clearAllButtonWidth = w;
					clearAllButtonXposition = listTwoPosition + 2 * (w + (ui_gap / 2));

					clearSelButtonString = "Clear Sel";
					clearSelButtonWidth = w;
					clearSelButtonXposition = listTwoPosition + 3 * (w + (ui_gap / 2));

					break;

				case 3:
					panelWidth = 457;
					panelHeight = 540;

					// 22 = List gadget scrollbar
					listOneWidth = listTwoWidth = integer( ( (panelWidth - (3 * ui_gap) ) - 44) / 2);
					listTwoPosition = listTwoWidth + 22 + (2 * ui_gap);
					
					w = integer(( (listOneWidth + 22 - (3 * ( ui_gap / 2) ) ) / 3) + 1 );

					newPassButtonString = "+Pass...   " + icon[DOWNARROW];
					newPassButtonWidth = w;
					newPassButtonXposition = ui_gap;

					newOverrideButtonString = "+Override" + icon[DOWNARROW];
					newOverrideButtonWidth = w;
					newOverrideButtonXposition = ui_gap;

					editSelectedButtonString = "Edit " + icon[ENTERKEY];
					editSelectedButtonWidth = w;
					editSelectedButtonXposition = ui_gap + w + (ui_gap / 2);

					deleteSelectedButtonString = "Del " + icon[DELETEKEY];
					deleteSelectedButtonWidth = w;
					deleteSelectedButtonXposition = ui_gap + 2 * (w + (ui_gap / 2));

					w = integer( (listOneWidth + 22 - (3 * ( ui_gap / 2) ) ) / 4 );

					addAllButtonString = "+All "+ icon[CTRLA];
					addAllButtonWidth = w;
					addAllButtonXposition = listTwoPosition;

					addSelButtonString = "+Sel";
					addSelButtonWidth = w;
					addSelButtonXposition = listTwoPosition + w + (ui_gap / 2);

					clearAllButtonString = "-All";
					clearAllButtonWidth = w;
					clearAllButtonXposition = listTwoPosition + 2 * (w + (ui_gap / 2));

					clearSelButtonString = "-Sel";
					clearSelButtonWidth = w;
					clearSelButtonXposition = listTwoPosition + 3 * (w + (ui_gap / 2));

					break;
					
				case 4:
					panelWidth = 457;
					panelHeight = 385;

					// 22 = List gadget scrollbar
					listOneWidth = listTwoWidth = integer( ( (panelWidth - (3 * ui_gap) ) - 44) / 2);
					listTwoPosition = listTwoWidth + 22 + (2 * ui_gap);

					w = integer(( (listOneWidth + 22 - (3 * ( ui_gap / 2) ) ) / 3) + 1 );

					newPassButtonString = "+Pass...   " + icon[DOWNARROW];
					newPassButtonWidth = w;
					newPassButtonXposition = ui_gap;

					newOverrideButtonString = "+Override" + icon[DOWNARROW];
					newOverrideButtonWidth = w;
					newOverrideButtonXposition = ui_gap;

					editSelectedButtonString = "Edit " + icon[ENTERKEY];
					editSelectedButtonWidth = w;
					editSelectedButtonXposition = ui_gap + w + (ui_gap / 2);

					deleteSelectedButtonString = "Del " + icon[DELETEKEY];
					deleteSelectedButtonWidth = w;
					deleteSelectedButtonXposition = ui_gap + 2 * (w + (ui_gap / 2));

					w = integer( (listOneWidth + 22 - (3 * ( ui_gap / 2) ) ) / 4 );

					addAllButtonString = "+All "+ icon[CTRLA];
					addAllButtonWidth = w;
					addAllButtonXposition = listTwoPosition;

					addSelButtonString = "+Sel";
					addSelButtonWidth = w;
					addSelButtonXposition = listTwoPosition + w + (ui_gap / 2);

					clearAllButtonString = "-All";
					clearAllButtonWidth = w;
					clearAllButtonXposition = listTwoPosition + 2 * (w + (ui_gap / 2));

					clearSelButtonString = "-Sel";
					clearSelButtonWidth = w;
					clearSelButtonXposition = listTwoPosition + 3 * (w + (ui_gap / 2));

					break;
					
				default:
					panelWidth = 640;
					panelHeight = 540;

					// 22 = List gadget scrollbar
					listOneWidth = listTwoWidth = integer( ( (panelWidth - (3 * ui_gap) ) - 44) / 2);
					listTwoPosition = listTwoWidth + 22 + (2 * ui_gap);

					w = integer(( (listOneWidth + 22 - (3 * ( ui_gap / 2) ) ) / 3) + 1 );

					newPassButtonString = "New Pass...      " + icon[DOWNARROW];
					newPassButtonWidth = w;
					newPassButtonXposition = ui_gap;

					newOverrideButtonString = "New Override... " + icon[DOWNARROW];
					newOverrideButtonWidth = w;
					newOverrideButtonXposition = ui_gap;

					editSelectedButtonString = "Edit Selected  " + icon[ENTERKEY];
					editSelectedButtonWidth = w;
					editSelectedButtonXposition = ui_gap + w + (ui_gap / 2);

					deleteSelectedButtonString = "Del Selected   " + icon[DELETEKEY];
					deleteSelectedButtonWidth = w;
					deleteSelectedButtonXposition = ui_gap + 2 * (w + (ui_gap / 2));

					w = integer( (listOneWidth + 22 - (3 * ( ui_gap / 2) ) ) / 4 );

					addAllButtonString = "Add All    "+ icon[CTRLA];
					addAllButtonWidth = w;
					addAllButtonXposition = listTwoPosition;

					addSelButtonString = "Add Sel    ";
					addSelButtonWidth = w;
					addSelButtonXposition = listTwoPosition + w + (ui_gap / 2);

					clearAllButtonString = "Clear All";
					clearAllButtonWidth = w;
					clearAllButtonXposition = listTwoPosition + 2 * (w + (ui_gap / 2));

					clearSelButtonString = "Clear Sel";
					clearSelButtonWidth = w;
					clearSelButtonXposition = listTwoPosition + 3 * (w + (ui_gap / 2));

					break;
			}

		// 22 = List gadget scrollbar
		listOneWidth = listTwoWidth = integer( ( (panelWidth - (3 * ui_gap) ) - 44) / 2);
		listTwoPosition = listTwoWidth + 22 + (2 * ui_gap);

		// New UI layout code - Matt Gorner
		listOneHeight = panelHeight - ( 3 * button_height) - banner_height - spacer_height - ( 5 * ui_y_spacer);

		// New UI layout code - Matt Gorner
		bottomPosition = panelHeight - button_height - ui_y_spacer;

		doKeys = 1;

	// end preprocess here		
	}

	reProcess
	{
		if(justReopened != 1)
		{
			// and this bit just recatalogs the items so assignments are up to date
			if(sceneJustLoaded == 1)
			{
				platformVar = platform();
				doKeys = 1;
				masterScene = Scene();
				//if(masterScene.getSelect() != nil)
				//{
					originalSelection = masterScene.getSelect();
					originalSelectionExists = true;
				//}
				//else
				//{
					//originalSelectionExists = nil;
				//}

				meshAgents[1] = "none";
				currentChosenPass = 1;
		    	currentChosenPassString = passNames[currentChosenPass];
		    	image_formats_array = getImageFormats();
		    	sceneJustLoaded = 0;
			}
			
			if(meshAgents[1] != "none")
			{
				//sleep(1);
				//RefreshNow();
				//masterScene = Scene();
				//info(masterScene.getSelect());
				//if(masterScene.getSelect() != nil)
				//{
					originalSelection = masterScene.getSelect();
				//}
				//info(originalSelection,justReopened);
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
						//if(masterScene.getSelect() != nil)
						//{
							originalSelection = masterScene.getSelect();
						//}
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
			    
		    idMapping = 0;
		    displayNames = nil;
		    displayIDs = nil;
		    displayOldIDs = nil;
			 x = 1;
		    for(y = 1; y <= size(meshAgents); y++)
		    {
		    	if(meshAgents[1] != "none")
		    	{
		    		displayNames[x] = meshNames[y];
		    		displayIDs[x] = meshIDs[y];
		    		displayOldIDs[x] = meshOldIDs[y];
		    		x++;
		    	}
		    }
		    for(y = 1; y <= size(lightAgents); y++)
		    {
		   		displayNames[x] = lightNames[y];
		   		displayIDs[x] = lightIDs[y];
		   		displayOldIDs[x] = lightOldIDs[y];
		   		x++;
		   	}
		   	
		   	//info(originalSelection);
		   	
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
		    //image_formats_array = getImageFormats();
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
		    for(w = 1; w <= size(displayNames); w++)
		    {
		    	o_displayNames[w + 1] = displayNames[w];
		    }
		}
		else
		{
			justReopened = 0;
		}

			switch(editorResolution)
			{
				case 1:
					panelWidth = 640;
					panelHeight = 540;
					
					// 22 = List gadget scrollbar
					listOneWidth = listTwoWidth = integer( ( (panelWidth - (3 * ui_gap) ) - 44) / 2);
					listTwoPosition = listTwoWidth + 22 + (2 * ui_gap);

					w = integer(( (listOneWidth + 22 - (3 * ( ui_gap / 2) ) ) / 3) + 1 );

					newPassButtonString = "New Pass...      " + icon[DOWNARROW];
					newPassButtonWidth = w;
					newPassButtonXposition = ui_gap;

					newOverrideButtonString = "New Override... " + icon[DOWNARROW];
					newOverrideButtonWidth = w;
					newOverrideButtonXposition = ui_gap;

					editSelectedButtonString = "Edit Selected  " + icon[ENTERKEY];
					editSelectedButtonWidth = w;
					editSelectedButtonXposition = ui_gap + w + (ui_gap / 2);

					deleteSelectedButtonString = "Del Selected   " + icon[DELETEKEY];
					deleteSelectedButtonWidth = w;
					deleteSelectedButtonXposition = ui_gap + 2 * (w + (ui_gap / 2));

					w = integer( (listOneWidth + 22 - (3 * ( ui_gap / 2) ) ) / 4 );

					addAllButtonString = "Add All    "+ icon[CTRLA];
					addAllButtonWidth = w;
					addAllButtonXposition = listTwoPosition;

					addSelButtonString = "Add Sel    ";
					addSelButtonWidth = w;
					addSelButtonXposition = listTwoPosition + w + (ui_gap / 2);

					clearAllButtonString = "Clear All";
					clearAllButtonWidth = w;
					clearAllButtonXposition = listTwoPosition + 2 * (w + (ui_gap / 2));

					clearSelButtonString = "Clear Sel";
					clearSelButtonWidth = w;
					clearSelButtonXposition = listTwoPosition + 3 * (w + (ui_gap / 2));

					break;
					
				case 2:
					panelWidth = 640;
					panelHeight = 385;

					// 22 = List gadget scrollbar
					listOneWidth = listTwoWidth = integer( ( (panelWidth - (3 * ui_gap) ) - 44) / 2);
					listTwoPosition = listTwoWidth + 22 + (2 * ui_gap);

					w = integer(( (listOneWidth + 22 - (3 * ( ui_gap / 2) ) ) / 3) + 1 );

					newPassButtonString = "New Pass...      " + icon[DOWNARROW];
					newPassButtonWidth = w;
					newPassButtonXposition = ui_gap;

					newOverrideButtonString = "New Override... " + icon[DOWNARROW];
					newOverrideButtonWidth = w;
					newOverrideButtonXposition = ui_gap;

					editSelectedButtonString = "Edit Selected  " + icon[ENTERKEY];
					editSelectedButtonWidth = w;
					editSelectedButtonXposition = ui_gap + w + (ui_gap / 2);

					deleteSelectedButtonString = "Del Selected   " + icon[DELETEKEY];
					deleteSelectedButtonWidth = w;
					deleteSelectedButtonXposition = ui_gap + 2 * (w + (ui_gap / 2));

					w = integer( (listOneWidth + 22 - (3 * ( ui_gap / 2) ) ) / 4 );

					addAllButtonString = "Add All    "+ icon[CTRLA];
					addAllButtonWidth = w;
					addAllButtonXposition = listTwoPosition;

					addSelButtonString = "Add Sel    ";
					addSelButtonWidth = w;
					addSelButtonXposition = listTwoPosition + w + (ui_gap / 2);

					clearAllButtonString = "Clear All";
					clearAllButtonWidth = w;
					clearAllButtonXposition = listTwoPosition + 2 * (w + (ui_gap / 2));

					clearSelButtonString = "Clear Sel";
					clearSelButtonWidth = w;
					clearSelButtonXposition = listTwoPosition + 3 * (w + (ui_gap / 2));

					break;

				case 3:
					panelWidth = 457;
					panelHeight = 540;

					// 22 = List gadget scrollbar
					listOneWidth = listTwoWidth = integer( ( (panelWidth - (3 * ui_gap) ) - 44) / 2);
					listTwoPosition = listTwoWidth + 22 + (2 * ui_gap);
					
					w = integer(( (listOneWidth + 22 - (3 * ( ui_gap / 2) ) ) / 3) + 1 );

					newPassButtonString = "+Pass...   " + icon[DOWNARROW];
					newPassButtonWidth = w;
					newPassButtonXposition = ui_gap;

					newOverrideButtonString = "+Override" + icon[DOWNARROW];
					newOverrideButtonWidth = w;
					newOverrideButtonXposition = ui_gap;

					editSelectedButtonString = "Edit " + icon[ENTERKEY];
					editSelectedButtonWidth = w;
					editSelectedButtonXposition = ui_gap + w + (ui_gap / 2);

					deleteSelectedButtonString = "Del " + icon[DELETEKEY];
					deleteSelectedButtonWidth = w;
					deleteSelectedButtonXposition = ui_gap + 2 * (w + (ui_gap / 2));

					w = integer( (listOneWidth + 22 - (3 * ( ui_gap / 2) ) ) / 4 );

					addAllButtonString = "+All "+ icon[CTRLA];
					addAllButtonWidth = w;
					addAllButtonXposition = listTwoPosition;

					addSelButtonString = "+Sel";
					addSelButtonWidth = w;
					addSelButtonXposition = listTwoPosition + w + (ui_gap / 2);

					clearAllButtonString = "-All";
					clearAllButtonWidth = w;
					clearAllButtonXposition = listTwoPosition + 2 * (w + (ui_gap / 2));

					clearSelButtonString = "-Sel";
					clearSelButtonWidth = w;
					clearSelButtonXposition = listTwoPosition + 3 * (w + (ui_gap / 2));

					break;
					
				case 4:
					panelWidth = 457;
					panelHeight = 385;

					// 22 = List gadget scrollbar
					listOneWidth = listTwoWidth = integer( ( (panelWidth - (3 * ui_gap) ) - 44) / 2);
					listTwoPosition = listTwoWidth + 22 + (2 * ui_gap);

					w = integer(( (listOneWidth + 22 - (3 * ( ui_gap / 2) ) ) / 3) + 1 );

					newPassButtonString = "+Pass...   " + icon[DOWNARROW];
					newPassButtonWidth = w;
					newPassButtonXposition = ui_gap;

					newOverrideButtonString = "+Override" + icon[DOWNARROW];
					newOverrideButtonWidth = w;
					newOverrideButtonXposition = ui_gap;

					editSelectedButtonString = "Edit " + icon[ENTERKEY];
					editSelectedButtonWidth = w;
					editSelectedButtonXposition = ui_gap + w + (ui_gap / 2);

					deleteSelectedButtonString = "Del " + icon[DELETEKEY];
					deleteSelectedButtonWidth = w;
					deleteSelectedButtonXposition = ui_gap + 2 * (w + (ui_gap / 2));

					w = integer( (listOneWidth + 22 - (3 * ( ui_gap / 2) ) ) / 4 );

					addAllButtonString = "+All "+ icon[CTRLA];
					addAllButtonWidth = w;
					addAllButtonXposition = listTwoPosition;

					addSelButtonString = "+Sel";
					addSelButtonWidth = w;
					addSelButtonXposition = listTwoPosition + w + (ui_gap / 2);

					clearAllButtonString = "-All";
					clearAllButtonWidth = w;
					clearAllButtonXposition = listTwoPosition + 2 * (w + (ui_gap / 2));

					clearSelButtonString = "-Sel";
					clearSelButtonWidth = w;
					clearSelButtonXposition = listTwoPosition + 3 * (w + (ui_gap / 2));

					break;
					
				default:
					panelWidth = 640;
					panelHeight = 540;

					// 22 = List gadget scrollbar
					listOneWidth = listTwoWidth = integer( ( (panelWidth - (3 * ui_gap) ) - 44) / 2);
					listTwoPosition = listTwoWidth + 22 + (2 * ui_gap);

					w = integer(( (listOneWidth + 22 - (3 * ( ui_gap / 2) ) ) / 3) + 1 );

					newPassButtonString = "New Pass...      " + icon[DOWNARROW];
					newPassButtonWidth = w;
					newPassButtonXposition = ui_gap;

					newOverrideButtonString = "New Override... " + icon[DOWNARROW];
					newOverrideButtonWidth = w;
					newOverrideButtonXposition = ui_gap;

					editSelectedButtonString = "Edit Selected  " + icon[ENTERKEY];
					editSelectedButtonWidth = w;
					editSelectedButtonXposition = ui_gap + w + (ui_gap / 2);

					deleteSelectedButtonString = "Del Selected   " + icon[DELETEKEY];
					deleteSelectedButtonWidth = w;
					deleteSelectedButtonXposition = ui_gap + 2 * (w + (ui_gap / 2));

					w = integer( (listOneWidth + 22 - (3 * ( ui_gap / 2) ) ) / 4 );

					addAllButtonString = "Add All    "+ icon[CTRLA];
					addAllButtonWidth = w;
					addAllButtonXposition = listTwoPosition;

					addSelButtonString = "Add Sel    ";
					addSelButtonWidth = w;
					addSelButtonXposition = listTwoPosition + w + (ui_gap / 2);

					clearAllButtonString = "Clear All";
					clearAllButtonWidth = w;
					clearAllButtonXposition = listTwoPosition + 2 * (w + (ui_gap / 2));

					clearSelButtonString = "Clear Sel";
					clearSelButtonWidth = w;
					clearSelButtonXposition = listTwoPosition + 3 * (w + (ui_gap / 2));

					break;
			}


		// 22 = List gadget scrollbar
		listOneWidth = listTwoWidth = integer( ( (panelWidth - (3 * ui_gap) ) - 44) / 2);
		listTwoPosition = listTwoWidth + 22 + (2 * ui_gap);

		// New UI layout code - Matt Gorner
		listOneHeight = panelHeight - ( 3 * button_height) - banner_height - spacer_height - ( 5 * ui_y_spacer);

		// New UI layout code - Matt Gorner
		bottomPosition = panelHeight - button_height - ui_y_spacer;

	    doKeys = 1;
	}

unProcess
{
	// clears out all the variables
	
	if(reqisopen())  {
        reqend();  }
	scenesnames = nil;
	passSelected = nil;
	overridesSelected = nil;
	passAssItems = nil;
	passOverrideItems = nil;
	masterScene = nil;
	originalSelection = nil;
	meshAgents = nil;
	meshNames = nil;
	meshIDs = nil;
	lightAgents = nil;
	lightNames = nil;
	lightIDs = nil;
	displayNames = nil;
	displayIDs = nil;
	passNames = nil;
	overrideNames = nil;
	gad_PassesListview = nil;
	gad_OverridesListview = nil;
	c3 = nil;
	c3_5 = nil;
	gad_SelectedPass = nil;
	c7 = nil;
	currentChosenPass = nil;
	currentChosenPassString = nil;
	interfaceRunYet = nil;

}
	

// listbox functions (or UDFs, as we call them in the industry)
	itemslb_count
	{
		return(displayNames.size());
	}
	
	o_itemslb_count
	{
		return(o_displayNames.size());
	}
	
	itemslb_name: index
	{
	    return(displayNames[index]);
	}

	o_itemslb_name: index
	{
		return(o_displayNames[index]);
	}
	
	itemslb_event: items
	{
		
	    items_array = nil;
	    sel = getvalue(gad_PassesListview).asInt();
	    if(passSelected == true && sel != 0)
	    {
	    	previousPassAssItems[sel] = passAssItems[sel];
	    	passAssItems[sel] = "";
	    	if(items != nil)  {
	    	items_size = sizeof(items);
	    	for(x = 1;x <= items_size;x++)  {
	        	items_array[x] = items[x];
	        	tempNumber = items[x];
	        	passAssItems[sel] = passAssItems[sel] + "||" + displayIDs[tempNumber]; }  }
	        else
	    	{
	    		setvalue(c3,nil);
	    		requpdate();
	    	}
	    }
	    else
	    {
			setvalue(c3,nil);
	    	requpdate();
		}
	}
	
	o_itemslb_event: o_items
	{
		o_items_array = nil;
		pass = currentChosenPass;
	    sel = getvalue(gad_OverridesListview).asInt();
	    if(overrideNames[1] != "empty")
		{
		    if(overridesSelected == true && sel != 0)
		    {
		    	previousPassOverrideItems[pass][sel] = passOverrideItems[pass][sel];
		    	passOverrideItems[pass][sel] = "";
		    	if(o_items != nil)
		    	{
			    	o_items_size = sizeof(o_items);
			    	for(x = 1;x <= o_items_size;x++)  {
			        	o_items_array[x] = o_items[x];
			        	tempNumber = o_items[x];
			        	if(tempNumber == 1)
			        	{
			        		passOverrideItems[pass][sel] = passOverrideItems[pass][sel] + "||" + "(Scene Master)";
			        	}
						else
						{
							passOverrideItems[pass][sel] = passOverrideItems[pass][sel] + "||" + displayIDs[tempNumber - 1];
						}  }
		    	}
		    	else
		    	{
		    		setvalue(c3_5,nil);
		    		requpdate();
		    	}
		    }
		    else
	    	{
	    		setvalue(c3_5,nil);
	    		requpdate();
	    	}
		}
	    else
	    {
	    	
			setvalue(c3_5,nil);
	    	requpdate();
		}
	}
	
	passeslb_count
	{
	  return(passNames.size());
	}
	
	passeslb_name: index
	{
	    return(passNames[index]);
	}
	passeslb_event: passes_items
	{
	    passes_array = nil;
	    if(passes_items != nil)  {
	    passes_size = sizeof(passes_items);
	    for(x = 1;x <= passes_size;x++)  {
	        passes_array[x] = passes_items[x];
	        passes_sel = passes_items[x];  }
		if(passes_size != 1)
		{
			passSelected = false;
			setvalue(gad_OverridesListview,nil);
			setvalue(c3,nil);
			requpdate();
		}
	    if(passes_size > 1)
		{
			setvalue(gad_PassesListview,nil);
			setvalue(gad_OverridesListview,nil);
			setvalue(c3,nil);
	    	requpdate();
		}
		if(passes_size == 1)
		{
			passes_sel = passes_array[1];
			setitems = parseListItems(passAssItems[passes_sel]);
			setvalue(c3,setitems);
			setvalue(gad_OverridesListview,nil);
			requpdate();
			passSelected = true;
		}  }
		else
		{
			passSelected = false;
			setvalue(gad_PassesListview,nil);
			setvalue(gad_OverridesListview,nil);
			setvalue(c3,nil);
			requpdate();
		}
		
	}
	
	parseListItems: passItemsString
	{
		idsArray = parse("||",passItemsString);
		z = 1;
		for(x = 1; x <= size(displayIDs); x++)
		{
			for(y = 1; y <= size(idsArray); y++)
			{
				if(string(displayIDs[x]) == string(idsArray[y]))
				{
					itemsParsedArray[z] = x;
					z++;
				}
				else
				{
					if(string(idsArray[y]) == "(Scene Master)")
					{
						itemsParsedArray[z] = x;
						z++;
					}
				}

			}
		}
		return(itemsParsedArray);
	}
	
	o_parseListItems: passItemsString
	{
		idsArray = parse("||",passItemsString);
		if(string(idsArray[1]) == "(Scene Master)")
		{
			itemsParsedArray[1] = 1;
			z = 2;
		}
		else
		{
			z = 1;
		}
		
		for(x = 1; x <= size(displayIDs); x++)
		{
			for(y = 1; y <= size(idsArray); y++)
			{
				if(string(displayIDs[x]) == string(idsArray[y]))
				{
					itemsParsedArray[z] = x + 1;
					z++;
				}
			}
		}

		return(itemsParsedArray);
	}

	
	parseOverrideSettings: overrideSettingsString
	{
		settingsArray = parse("||",overrideSettingsString);
		return(settingsArray);
	}
	
	
	overrideslb_count
	{
		if(overrideNames[1] != "empty")
		{
			return(overrideNames.size());
		}
		else
		{
			return(nil);
		}
	}
	
	overrideslb_name: index
	{
		if(overrideNames[1] != "empty")
		{
	    	return(overrideNames[index]);
		}
		else
		{
			return(nil);
		}
	}
	overrideslb_event: overrides_items
	{	
		pass = currentChosenPass;
		overrides_array = nil;
		if(overrides_items != nil)  {
		overrides_size = sizeof(overrides_items);
	    for(x = 1;x <= overrides_size;x++)  {
	        overrides_array[x] = overrides_items[x];
	        overrides_sel = overrides_items[x];  }
		if(overrides_size != 1)
		{
			overridesSelected = false;
			setvalue(c3_5,nil);
			setvalue(gad_PassesListview,nil);
			requpdate();
		}
	    if(overrides_size > 1)
		{
			setvalue(gad_OverridesListview,nil);
			setvalue(c3_5,nil);
			setvalue(gad_PassesListview,nil);
	    	requpdate();
		}
		if(overrides_size == 1)
		{
			overrides_sel = overrides_array[1];
			set_o_items = o_parseListItems(passOverrideItems[currentChosenPass][overrides_sel]);
			setvalue(c3_5,set_o_items);
			setvalue(gad_PassesListview,nil);
			requpdate();
			overridesSelected = true;
		}  }
		else
		{
			overridesSelected = false;
			setvalue(gad_OverridesListview,nil);
			setvalue(c3_5,nil);
			setvalue(gad_PassesListview,nil);
			requpdate();
		}
	}

// button functions
	addAllButton
	{
		items_array = nil;
	    sel = getvalue(gad_PassesListview).asInt();
	    if(passSelected == true && sel != 0)
	    {
	    	previousPassAssItems[sel] = passAssItems[sel];
	    	passAssItems[sel] = "";
	    	items_size = sizeof(displayNames);
	    	for(x = 1;x <= items_size;x++)  {
	        	items_array[x] = x;
	        	tempNumber = x;
	        	passAssItems[sel] = passAssItems[sel] + "||" + displayIDs[tempNumber]; }
			setitems = parseListItems(passAssItems[sel]);
			setvalue(c3,setitems);
			requpdate();
	    }
	    else
	    {
			setvalue(c3,nil);
	    	requpdate();
		}
		
	}
	
	o_addAllButton
	{
		o_items_array = nil;
	    pass = currentChosenPass;
	    sel = getvalue(gad_OverridesListview).asInt();
	    if(overridesSelected == true && sel != 0)
	    {
	    	previousPassOverrideItems[pass][sel] = passOverrideItems[pass][sel];
	    	passOverrideItems[pass][sel] = "";
	    	o_items_size = sizeof(o_displayNames);
	    	o_items_array[1] = 1;
	        tempNumber = 1;
	        passOverrideItems[pass][sel] = passOverrideItems[pass][sel] + "||" + "(Scene Master)";
	    	for(x = 2;x <= o_items_size;x++)  {
	        	o_items_array[x] = x;
	        	tempNumber = x;
	        	passOverrideItems[pass][sel] = passOverrideItems[pass][sel] + "||" + displayIDs[tempNumber - 1]; }
	        passOverrideItems[pass][sel] = passOverrideItems[pass][sel] + "||" + displayIDs[1]; 
			set_o_items = o_parseListItems(passOverrideItems[pass][sel]);
			setvalue(c3_5,set_o_items);
			requpdate();
	    }
	    else
	    {
			setvalue(c3_5,nil);
	    	requpdate();
		}
	}
	
	clearAllButton
	{
		if(areYouSurePrompts == 1)
		{
			doKeys = 0;
			reqbegin("Confirm Clear Pass Assignments");
			c20 = ctltext("","Are you sure you want to clear all pass assignments?");
			if(reqpost())
			{
				items_array = nil;
			    sel = getvalue(gad_PassesListview).asInt();
			    if(passSelected == true && sel != 0)
			    {
			    	previousPassAssItems[sel] = passAssItems[sel];
			    	passAssItems[sel] = "";
					setvalue(c3,nil);
					requpdate();
			    }
			}
			else
			{
				warn("Clearing of pass assignments cancelled.");
			}
			reqend();
			doKeys = 1;
		}
		else
		{
			items_array = nil;
		    sel = getvalue(gad_PassesListview).asInt();
		    if(passSelected == true && sel != 0)
		    {
		    	
		    	passAssItems[sel] = "";
				setvalue(c3,nil);
				requpdate();
		    }
		}
	}
	
	o_clearAllButton
	{
		if(areYouSurePrompts == 1)
		{
			doKeys = 0;
			reqbegin("Confirm Clear Override Assignments");
			c20 = ctltext("","Are you sure you want to clear all override assignments?");
			if(reqpost())
			{
				o_items_array = nil;
			    pass = currentChosenPass;
			    sel = getvalue(gad_OverridesListview).asInt();
			    if(overridesSelected == true && sel != 0)
			    {
			    	previousPassOverrideItems[pass][sel] = passOverrideItems[pass][sel];
			    	passOverrideItems[pass][sel] = "";
					setvalue(c3_5,nil);
					requpdate();
			    }

			}
			else
			{
				warn("Clearing of override assignments cancelled.");
			}
			reqend();
			doKeys = 1;
		}
		else
		{

			o_items_array = nil;
		    pass = currentChosenPass;
		    sel = getvalue(gad_OverridesListview).asInt();
		    if(overridesSelected == true && sel != 0)
		    {
		    	passOverrideItems[pass][sel] = "";
				setvalue(c3_5,nil);
				requpdate();
		    }
		}
		
	}
	
	editSelectedPass
	{
		sel = getvalue(gad_PassesListview).asInt();
	    if(passSelected == true && sel != 0)
	    {
	    	doKeys = 0;
			reqbegin("Edit Pass");
			c20 = ctlstring("Pass Name:",passNames[sel]);
			if(reqpost())
			{
				newName = getvalue(c20);
				newName = makeStringGood(newName);
				doUpdate = 1;
			}
			else
			{
				doUpdate = 0;
			}
			reqend();
			if(doUpdate == 1)
			{
				newNumber = sel;
				passNames[newNumber] = newName;
			    //setvalue(gad_SelectedPass,nil);
				//setvalue(gad_SelectedPass,"Current Pass", passNames, "currentPassMenu_select");
				if(useHackyUpdates == 1)
				{
					justReopened = 1;
					if(reqisopen())  {
	        			reqend();  }
	        		
					options();
				}
			}
			//reProcess();
			requpdate();
	    }
	}
	
	deleteSelectedPass
	{
		if(size(passNames) > 1)
		{
			sel = getvalue(gad_PassesListview).asInt();
			if( sel != currentChosenPass )
			{
				if(areYouSurePrompts == 1)
				{
					doKeys = 0;
					reqbegin("Confirm Delete Pass");
					c20 = ctltext("","Are you sure you want to delete selected pass?");
					if(reqpost())
					{
						
						sel = getvalue(gad_PassesListview).asInt();
						if(passSelected == true && sel != 0)
					    {
					    	topNumber = size(passNames);
					    	if(sel == topNumber)
					    	{
					    		passNames[sel] = nil;
					    		passAssItems[sel] = "";
					    		for(x = 1; x <= size(overrideNames); x++)
					    		{
					    			passOverrideItems[sel][x] = "";
					    		}
					    	}
					    	else
					    	{
						    	for(x = 1; x <= size(passNames); x++)
						    	{
						    		if(x < sel)
						    		{
						    			passNames[x] = passNames[x];
						    			passAssItems[x] = passAssItems[x];
							    		for(y = 1; y <= size(overrideNames); y++)
							    		{
							    			passOverrideItems[x][y] = passOverrideItems[x][y];
							    		}
						    		}
						    		else if(x >= sel)
						    		{
						    			xPlusOne = x + 1;
						    			if(xPlusOne <= topNumber)
						    			{
						    				passNames[x] = passNames[xPlusOne];
						    				passAssItems[x] = passAssItems[xPlusOne];
								    		for(y = 1; y <= size(overrideNames); y++)
								    		{
								    			passOverrideItems[x][y] = passOverrideItems[xPlusOne][y];
								    		}
						    			}
						    		}
						    	}
						    	passNames[topNumber] = nil;
						    	passAssItems[topNumber] = "";
							    for(y = 1; y <= size(overrideNames); y++)
					    		{
					    			passOverrideItems[topNumber][y] = "";
					    		}

					    	}
					    }
					    //reProcess();
					    doRefresh = 1;
					}
					else
					{
						warn("Pass deletion cancelled.");
						doRefresh = 0;
					}
					reqend();
					if(doRefresh == 1)
					{
						//setvalue(gad_SelectedPass,nil);
						//setvalue(gad_SelectedPass,"Current Pass",passNames,"currentPassMenu_select");
						if(currentChosenPass > 1)
						{
							currentChosenPass = currentChosenPass - 1;
							currentChosenPassString = passNames[currentChosenPass];
						}
						//setvalue(c7,currentChosenPassString,"");
						if(useHackyUpdates == 1)
						{
							justReopened = 1;
							if(reqisopen())  {
		        				reqend();  }
		        			
							options();
						}
					}
					//reProcess();
					requpdate();
					doKeys = 1;
				}
				else
				{
					sel = getvalue(gad_PassesListview).asInt();
					if(passSelected == true && sel != 0)
				    {
				    	topNumber = size(passNames);
				    	if(sel == topNumber)
				    	{
				    		passNames[sel] = nil;
				    		passAssItems[sel] = "";
				    		for(x = 1; x <= size(overrideNames); x++)
				    		{
				    			passOverrideItems[1][x] = "";
				    		}
				    	}
				    	else
				    	{
					    	for(x = 1; x <= size(passNames); x++)
					    	{
					    		if(x < sel)
					    		{
					    			passNames[x] = passNames[x];
					    			passAssItems[x] = passAssItems[x];
						    		for(y = 1; y <= size(overrideNames); y++)
						    		{
						    			passOverrideItems[x][y] = passOverrideItems[x][y];
						    		}
					    		}
					    		else if(x >= sel)
					    		{
					    			xPlusOne = x + 1;
					    			if(xPlusOne <= topNumber)
					    			{
					    				passNames[x] = passNames[xPlusOne];
					    				passAssItems[x] = passAssItems[xPlusOne];
							    		for(y = 1; y <= size(overrideNames); y++)
							    		{
							    			passOverrideItems[x][y] = passOverrideItems[xPlusOne][y];
							    		}
					    			}
					    		}
					    	}
					    	passNames[topNumber] = nil;
					    	passAssItems[topNumber] = "";
						    for(y = 1; y <= size(overrideNames); y++)
				    		{
				    			passOverrideItems[topNumber][y] = "";
				    		}

				    	}
				    }
				    //reProcess();
				    //setvalue(gad_SelectedPass,nil);
					//setvalue(gad_SelectedPass,"Current Pass",passNames,"currentPassMenu_select");
					if(currentChosenPass > 1)
					{
						currentChosenPass = currentChosenPass - 1;
						currentChosenPassString = passNames[currentChosenPass];
					}
					//setvalue(c7,currentChosenPassString,"");
					if(useHackyUpdates == 1)
					{
						justReopened = 1;
						if(reqisopen())  {
	        				reqend();  }
	        			
						options();
					}
					//reProcess();
					requpdate();
				}

			}
			else
			{
				error("Can't delete current pass!  Changes passes, then delete.");
			}
		}
	}
		
	deleteSelectedOverride
	{
		if(overrideNames[1] != "empty")
		{
			if(areYouSurePrompts == 1)
			{
				doKeys = 0;
				reqbegin("Confirm Delete Override");
				c20 = ctltext("","Are you sure you want to delete selected override?");
				if(reqpost())
				{
					sel = getvalue(gad_OverridesListview).asInt();
		    		if(overridesSelected == true && sel != 0)
		    		{
				    	topNumber = size(overrideNames);
				    	if(topNumber == 1 && overrideNames[1] != "empty")
				    	{
				    		overrideNames[1] = "empty";
				    		passOverrideItems[currentChosenPass][1] = "";
				    		overrideSettings[1] = "";
				    	}
				    	else if(sel == topNumber)
				    	{
				    		overrideNames[sel] = nil;
				    		passOverrideItems[currentChosenPass][sel] = nil;
				    		overrideSettings[sel] = nil;
				    	}
				    	else
				    	{
					    	for(x = 1; x < size(overrideNames); x++)
					    	{
					    		if(x < sel)
					    		{
					    			overrideNames[x] = overrideNames[x];
					    			passOverrideItems[currentChosenPass][x] = passOverrideItems[currentChosenPass][x];
					    			overrideSettings[x] = overrideSettings[x];
					    		}
					    		else if(x >= sel)
					    		{
					    			xPlusOne = x + 1;
					    			if(xPlusOne <= topNumber)
					    			{
					    				overrideNames[x] = overrideNames[xPlusOne];
					    				passOverrideItems[currentChosenPass][x] = passOverrideItems[currentChosenPass][xPlusOne];
					    				overrideSettings[x] = overrideSettings[xPlusOne];
					    			}
					    		}
					    	}
					    	overrideNames[topNumber] = nil;
					    	passOverrideItems[currentChosenPass][topNumber] = nil;
					    	overrideSettings[topNumber] = nil;
					    	
				    	}
				    }
				    reProcess();
				    doRefresh = 1;
				}
				else
				{
					warn("Override deletion cancelled.");
					doRefresh = 0;
				}
				reqend();
				if(doRefresh == 1)
				{
					reProcess();
					requpdate();
				}
				doKeys = 1;
			}
			else
			{
				sel = getvalue(gad_OverridesListview).asInt();
	    		if(overridesSelected == true && sel != 0)
	    		{
			    	topNumber = size(overrideNames);
			    	if(topNumber == 1 && overrideNames[1] != "empty")
			    	{
			    		overrideNames[1] = "empty";
			    		passOverrideItems[currentChosenPass][1] = "";
			    		overrideSettings[1] = "";
			    	}
			    	else if(sel == topNumber)
			    	{
			    		overrideNames[sel] = nil;
			    		passOverrideItems[currentChosenPass][sel] = nil;
			    		overrideSettings[sel] = nil;
			    	}
			    	else
			    	{
				    	for(x = 1; x < size(overrideNames); x++)
				    	{
				    		if(x < sel)
				    		{
				    			overrideNames[x] = overrideNames[x];
				    			passOverrideItems[currentChosenPass][x] = passOverrideItems[currentChosenPass][x];
				    			overrideSettings[x] = overrideSettings[x];
				    		}
				    		else if(x >= sel)
				    		{
				    			xPlusOne = x + 1;
				    			if(xPlusOne <= topNumber)
				    			{
				    				overrideNames[x] = overrideNames[xPlusOne];
				    				passOverrideItems[currentChosenPass][x] = passOverrideItems[currentChosenPass][xPlusOne];
				    				overrideSettings[x] = overrideSettings[xPlusOne];
				    			}
				    		}
				    	}
				    	overrideNames[topNumber] = nil;
				    	passOverrideItems[currentChosenPass][topNumber] = nil;
				    	overrideSettings[topNumber] = nil;
				    	
			    	}
			    }
			    reProcess();
				requpdate();
			}
		}
	}

doQuit
{
	seriously();
}
seriously
{
	options();
}

// menu functions
	fileMenu_select: fileMenu_item
	{
		if(fileMenu_item == 1)
		{
			if(passAssItems[currentChosenPass] != "")
			{
				savePassAsScene();
				StatusMsg("Completed saving " + currentChosenPassString + " as a scene.");
			}
			else
			{
				error("There are no items in this pass.  Can't save.");
			}
		}
		if(fileMenu_item == 2)
		{
			if(passAssItems[currentChosenPass] != "")
			{
				saveAllPassesAsScenes();
				StatusMsg("Completed saving all passes as scenes.");
			}
			else
			{
				error("There are no items in the current pass.  Can't save passes.");
			}
		}
		if(fileMenu_item == 3)
		{
			if(passAssItems[currentChosenPass] != "")
			{
				renderPassFrame();
				StatusMsg("Completed submitting " + currentChosenPassString + " for local rendering.");
			}
			else
			{
				error("There are no items in this pass.  Can't render frame.");
			}
		}
		if(fileMenu_item == 4)
		{
			if(passAssItems[currentChosenPass] != "")
			{
				if(areYouSurePrompts == 1)
				{
					doKeys = 0;
					reqbegin("Confirm Render Pass");
					c20 = ctltext("","Are you sure you want to render the current pass?");
					if(reqpost())
					{
						renderPassScene();
						StatusMsg("Completed submitting " + currentChosenPassString + " for local rendering.");
					}
					else
					{
						warn("Pass rendering cancelled.");
					}
					reqend();
					doKeys = 1;
				}
				else
				{
					renderPassScene();
					StatusMsg("Completed submitting " + currentChosenPassString + " for local rendering.");
				}
			}
			else
			{
				error("There are no items in this pass.  Can't render scene.");
			}
		}
		
		if(fileMenu_item == 5)
		{
			if(passAssItems[currentChosenPass] != "")
			{
				if(areYouSurePrompts == 1)
				{
					doKeys = 0;
					reqbegin("Confirm Render All");
					c20 = ctltext("","Are you sure you want to render all passes?");
					if(reqpost())
					{
						renderAllScene();
						StatusMsg("Completed submitting all passes for local rendering.");
					}
					else
					{
						warn("Rendering cancelled.");
					}
					reqend();
					doKeys = 1;
				}
				else
				{
					renderAllScene();
					StatusMsg("Completed submitting all passes for local rendering.");
				}
			}
			else
			{
				error("There are no items in this pass.  Can't render scene.");
			}
		}

		
		if(fileMenu_item == 7)
		{
			reProcess();
			requpdate();
		}
		if(fileMenu_item == 8)
		{
			preferencePanel();
		}
		if(fileMenu_item == 9)
		{
			RenderOptions();
		}
		if(fileMenu_item == 11)
		{
			saveCurrentPassesSettings();
		}
		if(fileMenu_item == 12)
		{
			if(areYouSurePrompts == 1)
			{
				doKeys = 0;
				reqbegin("Confirm Load Settings");
				c20 = ctltext("","Are you sure you want to load PassPort passes and overrides?");
				if(reqpost())
				{
					loadPassesSettings();
				}
				else
				{
					warn("Settings load cancelled.");
				}
				reqend();
				doKeys = 1;
			}
			else
			{
				loadPassesSettings();
			}
		}
		if(fileMenu_item == 13)
		{
			aboutPassPortDialog();
		}
	}
	
	fileMenu_active: fileMenu_item
	{
	   return(fileMenu_item);
	}
	
	
	passMenu_select: passMenu_item
	{
	   if(passMenu_item == 1)
		{
			reProcess();
			createNewFullScenePass();
			//setvalue(gad_SelectedPass,nil);
			//setvalue(gad_SelectedPass,"Current Pass",passNames,"currentPassMenu_select");

			if(useHackyUpdates == 1)
			{
				justReopened = 1;
				if(reqisopen())
				{
					reqend();
	        	}
				options();
			}
			
			else
			{
				//reProcess();
				requpdate();
			}
			
		}
	   
	   if(passMenu_item == 2)
		{
			justReopened = 1;
			createNewEmptyPass();
			//setvalue(gad_SelectedPass,nil);
			//setvalue(gad_SelectedPass,"Current Pass",passNames,"currentPassMenu_select");
			if(useHackyUpdates == 1)
			{
				justReopened = 1;
				if(reqisopen())  {
	        		reqend();  }
	        	
				options();
			}
			else
			{
				//reProcess();
				requpdate();
			}
		}
		if(passMenu_item == 3)
		{
			reProcess();
			createNewPassFromLayoutSelection();
			//setvalue(gad_SelectedPass,nil);
			//setvalue(gad_SelectedPass,"Current Pass",passNames,"currentPassMenu_select");
			if(useHackyUpdates == 1)
			{
				justReopened = 1;
				if(reqisopen())  {
	        		reqend();  }
	        	
				options();
			}
			else
			{
				//reProcess();
				requpdate();
			}
		}
		if(passMenu_item == 4)
		{
			//reProcess();
			duplicateSelectedPass();
			//setvalue(gad_SelectedPass,nil);
			//setvalue(gad_SelectedPass,"Current Pass",passNames,"currentPassMenu_select");
			if(useHackyUpdates == 1)
			{
				justReopened = 1;
				if(reqisopen())  {
	        		reqend();  }
	        	
				options();
			}
			else
			{
				//reProcess();
				requpdate();
			}
		}
		
	}
	
	currentPassMenu_refresh: value
	{
		currentChosenPass = int(value);
		currentChosenPassString = passNames[currentChosenPass];
		setvalue(gad_OverridesListview,nil);
		setvalue(c3_5,nil);
		//setvalue(gad_SelectedPass,currentChosenPass);
		//setvalue(c7,currentChosenPassString,"");
		reProcess();
		requpdate();
	}

	currentPassMenu_select: currentPassMenu_item
	{
		currentChosenPass = int(currentPassMenu_item);
		currentChosenPassString = passNames[currentChosenPass];
		setvalue(gad_OverridesListview,nil);
		setvalue(c3_5,nil);
		setvalue(gad_SelectedPass,currentChosenPass);
		//setvalue(c7,currentChosenPassString,"");
		reProcess();
		requpdate();
	}
	
	currentPassMenu_update
	{
		return(passNames);
	}
	
	
	passMenu_active: passMenu_item
	{
	   return(passMenu_item);
	}
	
	overrideMenu_select: overrideMenu_item
	{
		switch(overrideMenu_item)
		{
			case 1:
				createObjPropOverride();
				//reProcess();
				requpdate();
				break;
			case 2:
				createAltObjOverride();
				//reProcess();
				requpdate();
				break;
			case 3:
				createMotOverride();
				//reProcess();
				requpdate();
				break;
			case 4:
				createSrfOverride();
				//reProcess();
				requpdate();
				break;
				
			case 5:
				createLgtPropOverride();
				//reProcess();
				requpdate();
				break;
				
			case 6:
				createSceneMasterOverride();
				//reProcess();
				requpdate();
				break;
				
			case 8:
				createLightExclusionOverride();
				//reProcess();
				requpdate();
				break;
				
			case 9:
				duplicateSelectedOverride();
				requpdate();
				break;
				
			default:
				//reProcess();
				requpdate();
				break;
		}
	}
	
	overrideMenu_active: overrideMenu_item
	{
	   return(overrideMenu_item);
	}
	

// keyboard function
	reqkeyboard: key
	{
		
		
		// win hotkeys
		if(platformVar == 1 || platformVar == 10)
		{
			
			// undo selections
			if(key == 26 && doKeys == 1)
			{
				passSel = getvalue(gad_PassesListview).asInt();
				overrideSel = getvalue(gad_OverridesListview).asInt();
				if(passSel > 0)
				{
					undoItemSelect();
				}
				else if(overrideSel > 0)
				{
					undoOverrideSelect();
				}
				
			}
			
			// do the keyboard function for duplicating the pass/override
			if(key == 4 && doKeys == 1)
			{
				passSel = getvalue(gad_PassesListview).asInt();
				overrideSel = getvalue(gad_OverridesListview).asInt();
				if(passSel > 0)
				{

					duplicateSelectedPass();
					//setvalue(gad_SelectedPass,nil);
					//setvalue(gad_SelectedPass,"Current Pass",passNames,"currentPassMenu_select");
					if(useHackyUpdates == 1)
					{
						justReopened = 1;
						if(reqisopen())  {
			        		reqend();  }
			        	
						options();
					}
					else
					{
						//reProcess();
						requpdate();
					}
				}
				else if(overrideSel > 0)
				{
					duplicateSelectedOverride();
					requpdate();
				}
				doKeys = 1;
			}

			// do the keyboard function for editing selected
			if(key == 13 && doKeys == 1)
			{
				passSel = getvalue(gad_PassesListview).asInt();
				overrideSel = getvalue(gad_OverridesListview).asInt();
				if(passSel > 0)
				{
					editSelectedPass();
				}
				else if(overrideSel > 0)
				{
					editSelectedOverride();
				}
				doKeys = 1;
			}
			
			// do the keyboard function for deleting selected
			if(key == 4128 && doKeys == 1)
			{
				passSel = getvalue(gad_PassesListview).asInt();
				overrideSel = getvalue(gad_OverridesListview).asInt();
				if(passSel > 0)
				{
					deleteSelectedPass();
				}
				else if(overrideSel > 0)
				{
					deleteSelectedOverride();
				}
				doKeys = 1;
			}
			// do the keyboard function for selecting all
			if(key == 1 && doKeys == 1)
			{
				passSel = getvalue(gad_PassesListview).asInt();
				overrideSel = getvalue(gad_OverridesListview).asInt();
				if(passSel > 0)
				{
					addAllButton();
				}
				else if(overrideSel > 0)
				{
					o_addAllButton();
				}
				doKeys = 1;
			}
			
			// do keyboard function for opening preferences
			if(key == 111 && doKeys == 1)
			{
				preferencePanel();
				doKeys = 1;
			}
			
			// do keyboard function for refreshing the panel
			if(key == 18 && doKeys == 1)
			{
				reProcess();
				requpdate();
			}
			//win:
			//enter is 13
			//delete is 4128
			//ctrl + a is 1
			//ctrl + r is 18
			//o is 111
			
			
			if(key == 45 && doKeys == 1)
			{
					quickDownSize();
			}
			if(key == 61 && doKeys == 1)
			{
					quickUpSize();
			}
			
			if(key == REQKB_PAGEDOWN && doKeys == 1)
			{
				moveOverrideToBottom();
			}			
		}
		
		// mac UB hotkeys
		if(platformVar == 9)
		{
			// undo selections
			if(key == 26 && doKeys == 1)
			{
				passSel = getvalue(gad_PassesListview).asInt();
				overrideSel = getvalue(gad_OverridesListview).asInt();
				if(passSel > 0)
				{
					undoItemSelect();
				}
				else if(overrideSel > 0)
				{
					undoOverrideSelect();
				}
				
			}
			
			// do the keyboard function for duplicating the pass/override
			if(key == 4 && doKeys == 1)
			{
				passSel = getvalue(gad_PassesListview).asInt();
				overrideSel = getvalue(gad_OverridesListview).asInt();
				if(passSel > 0)
				{
					
					duplicateSelectedPass();
					//setvalue(gad_SelectedPass,nil);
					//setvalue(gad_SelectedPass,"Current Pass",passNames,"currentPassMenu_select");
					if(useHackyUpdates == 1)
					{
						justReopened = 1;
						if(reqisopen())  {
			        		reqend();  }
			        	
						options();
					}
					else
					{
						//reProcess();
						requpdate();
					}
				}
				else if(overrideSel > 0)
				{
					duplicateSelectedOverride();
					requpdate();
				}
				doKeys = 1;
			}



			
			if(key == 45 && doKeys == 1)
			{
					quickDownSize();
			}
			if(key == 61 && doKeys == 1)
			{
					quickUpSize();
			}
			
			if(key == REQKB_PAGEDOWN && doKeys == 1)
			{
				moveOverrideToBottom();
			}

			
			// do the keyboard function for editing selected
			if(key == 13 && doKeys == 1)
			{
				passSel = getvalue(gad_PassesListview).asInt();
				overrideSel = getvalue(gad_OverridesListview).asInt();
				if(passSel > 0)
				{
					editSelectedPass();
				}
				else if(overrideSel > 0)
				{
					editSelectedOverride();
				}
				doKeys = 1;
			}
			
			// do the keyboard function for deleting selected
			if(key == 4128 && doKeys == 1)
			{
				passSel = getvalue(gad_PassesListview).asInt();
				overrideSel = getvalue(gad_OverridesListview).asInt();
				if(passSel > 0)
				{
					deleteSelectedPass();
				}
				else if(overrideSel > 0)
				{
					deleteSelectedOverride();
				}
				doKeys = 1;
			}
			// do the keyboard function for selecting all
			if(key == 1 && doKeys == 1)
			{
				passSel = getvalue(gad_PassesListview).asInt();
				overrideSel = getvalue(gad_OverridesListview).asInt();
				if(passSel > 0)
				{
					addAllButton();
				}
				else if(overrideSel > 0)
				{
					o_addAllButton();
				}
				doKeys = 1;
			}

			// do keyboard function for opening preferences
			if(key == 111 && doKeys == 1)
			{
				preferencePanel();
				doKeys = 1;
			}
			
			// do keyboard function for refreshing the panel
			if(key == 18 && doKeys == 1)
			{
				reProcess();
				requpdate();
			}
			
			//mac:
			//enter is 13
			//delete is 4128
			//ctrl is 4194
			//a is
			//ctrl + a is 1
			//ctrl + r is 18
			//o is 111
		// end mac UB hotkeys
		
		}
	}

// Redraw custom drawing on requester
req_redraw
{
	if(reqisopen())
	{
		// Draw divider line (ctlsep kept getting drawn over)
		drawline(<038,038,040>, 0, banner_height + 29, panelWidth, banner_height + 29);
		drawline(<081,081,083>, 0, banner_height + 31, panelWidth, banner_height + 31);
	}
}
