undoItemSelect
{
	sel = getvalue(gad_PassesListview).asInt();
    if(::passSelected == true && sel != 0)
    {
    	temp = ::passAssItems[sel];
    	if(::previousPassAssItems != nil)
    	{
	    	if(::previousPassAssItems[sel] != nil)
	    	{
	    		::passAssItems[sel] = ::previousPassAssItems[sel];
	    		::previousPassAssItems[sel] = temp;
	    		setitems = parseListItems(::passAssItems[sel]);
				setvalue(gad_SceneItems_forPasses_Listview,setitems);
				setvalue(gad_OverridesListview,nil);
	    	}
	        else
	    	{
	    		req_update();
	    	}
    	}
    	 else
    	{
    		req_update();
    	}
    }
    else
    {
		setvalue(gad_SceneItems_forPasses_Listview,nil);
    	req_update();
	}
}

aboutPassPortDialog
{
	::doKeys = 0;
	reqbegin("About PassPort");
	reqsize(::aboutsize_x,::aboutsize_y);

	// About Graphic
	if(::compiled)
	{
		c_banner = ctlimage( "Passport_About.tga" );
	}else
	{
		banner_filename = ::this_script_path + "Passport_About.tga";
		c_banner = ctlimage( banner_filename );
	}
	ctlposition(c_banner,0,0);

	reqredraw("aboutPassPortDialog_redraw");
	if(reqpost())
	{
	}

	reqend();
	::doKeys = 1;
}

// About Box redraw function (drawtext doesn't have a background colour, whereas ctltext gadgets do, which were previously used)
// Matt Gorner
aboutPassPortDialog_redraw
{
	if(reqisopen())
	{
		txt_y = 135;
		drawline(<038,038,040>, 0, txt_y - 10, ::aboutsize_x, txt_y - 10);
		lwversion = string(string(hostVersion()) + " (" + string(hostBuild()) + ")" );
		str = string("Version: " + ::versionString + " on LW version: " + lwversion);
		drawtext(str, <0,0,0>, 10, txt_y);
		str = string("Platform: " + platformInformation());
		drawtext(str, <0,0,0>, 10, txt_y + drawtextheight(str) );
	}
}

platformInformation
{
	switch(platform()) {
		case WIN32:
			::parch = "Win_x86";
			break;
		case WIN64:
			::parch = "Win_x86_64";
			break;
		case MACUB:
			::parch = "MacUB_x86";
			break;
		case MAC64:
			::parch = "MacUB_x86_64";
			break;
		default:
			::parch = "unknown: " + string(platform());
			break;
	}
	return ::parch;
}

preferencePanel
{
	resolutionsArray[1] = "640 x 540";
	resolutionsArray[2] = "640 x 385";
	resolutionsArray[3] = "457 x 540";
	resolutionsArray[4] = "457 x 385";
	
	::rgbSaveType = integer(::rgbSaveType);
	::doKeys = 0;

	reqbegin("PassPort Preferences");
	reqsize(::Pref_ui_window_w,500);

	c20 = ctlfoldername("Scene Save Location:", ::userOutputFolder,);
	ctlposition(c20, ::Pref_gad_x, ::Pref_ui_offset_y, ::Pref_gad_w, ::Pref_gad_h, ::Pref_gad_text_offset);

	ui_offset_y = ::Pref_ui_offset_y + ::Pref_ui_row_offset;

	c21 = ctlstring("Render file prefix", ::fileOutputPrefix);
	ctlposition(c21, ::Pref_gad_x, ui_offset_y, ::Pref_gad_w, ::Pref_gad_h, ::Pref_gad_text_offset);

	ui_offset_y += ::Pref_ui_row_offset;

	c22 = ctlstring("User", ::userOutputString);
	ctlposition(c22, ::Pref_gad_x, ui_offset_y, ::Pref_gad_w, ::Pref_gad_h, ::Pref_gad_text_offset);

	ui_offset_y += ::Pref_ui_row_offset + 4;

	s20 = ctlsep();
	ctlposition(s20, -2, ui_offset_y);

	ui_offset_y += 5;

	if(platform() == MACUB || platform() == MAC64)
	{
		usegrowl = ctlcheckbox("Use Growl",::useGrowl);
		ctlposition(usegrowl, ::Pref_gad_x, ui_offset_y, ::Pref_gad_w, ::Pref_gad_h, ::Pref_gad_text_offset);
	
		ui_offset_y += ::Pref_ui_row_offset + 5;
		s201 = ctlsep();
		ctlposition(s201, -2, ui_offset_y);
		ui_offset_y += 6;

	} else {
		ui_offset_y += ::Pref_ui_row_offset;
		ui_offset_y += ::Pref_ui_row_offset;
	}

	dependencyError = ctlcheckbox("Error on missing dependencies",::errorOnDependency);
	ctlposition(dependencyError, ::Pref_gad_x, ui_offset_y, ::Pref_gad_w, ::Pref_gad_h, ::Pref_gad_text_offset);

	ui_offset_y += ::Pref_ui_row_offset;

	c_doNotDeleteScripts = ctlcheckbox("Do not delete scripts",::doNotDeleteScripts);
	ctlposition(c_doNotDeleteScripts, ::Pref_gad_x, ui_offset_y, ::Pref_gad_w, ::Pref_gad_h, ::Pref_gad_text_offset);

	ui_offset_y += ::Pref_ui_row_offset;

	c23 = ctlcheckbox("Enable Confirmation Dialogs",::areYouSurePrompts);
	ctlposition(c23, ::Pref_gad_x, ui_offset_y, ::Pref_gad_w, ::Pref_gad_h, ::Pref_gad_text_offset);

	ui_offset_y += ::Pref_ui_row_offset;

	c26 = ctlpopup("Editor UI Size (On Reopen)",::editorResolution,resolutionsArray);
	ctlposition(c26, ::Pref_gad_x, ui_offset_y, ::Pref_gad_w, ::Pref_gad_h, ::Pref_gad_text_offset);

	ui_offset_y += ::Pref_ui_row_offset + 4;

	s21 = ctlsep();
	ctlposition(s21, -2, ui_offset_y);

	ui_offset_y += ::Pref_ui_spacing + 5;

	c25 = ctlpopup("Sequence Render RGB Type",::rgbSaveType,::image_formats_array);
	ctlposition(c25, ::Pref_gad_x, ui_offset_y, ::Pref_gad_w, ::Pref_gad_h, ::Pref_gad_text_offset);

	ui_offset_y += ::Pref_ui_row_offset + 4;

	s22 = ctlsep();
	ctlposition(s22, -2, ui_offset_y);

	ui_offset_y += ::Pref_ui_spacing + 5;

	c29 = ctlpopup("Test Render RGB Type", ::testRgbSaveType, ::image_formats_array);
	ctlposition(c29, ::Pref_gad_x, ui_offset_y, ::Pref_gad_w, ::Pref_gad_h, ::Pref_gad_text_offset);

	if(reqpost())
	{
		::userOutputFolder = getvalue(c20);
		::fileOutputPrefix = getvalue(c21);
		::fileOutputPrefix = makeStringGood(fileOutputPrefix);
		::userOutputString = getvalue(c22);
		::userOutputString = makeStringGood(userOutputString);
		if(platform() == MACUB || platform() == MAC64)
			::useGrowl = getvalue(usegrowl);
		::areYouSurePrompts = getvalue(c23);
		::errorOnDependency = getvalue(dependencyError);
		::doNotDeleteScripts = getvalue(c_doNotDeleteScripts);
		::rgbSaveType = getvalue(c25);
		::editorResolution = getvalue(c26);
		::testRgbSaveType = getvalue(c29);
	}
	reqend();
}
