// kray2.5 physical sky globals
@insert "@kray/passEditor_Kray25PhysicalSky_Support_Vars.ls"
@insert "@kray/passEditor_Kray25PhysicalSky_Support_CustomFuncs.ls"
@insert "@kray/passEditor_Kray25PhysicalSky_Support_UI.ls"

scnGen_kray25_physky
{
	// Need to check whether we actually need to process anything - we're a plugin and thus optional.
	// kray25_PhySky_Index = ::settingsArray.indexOf(kray25_PhySky_pluginTagString);
	// if (kray25_PhySky_Index == 0) // Not found, nothing to do.
	//	return;

	// Kray, happily, has all of its settings in the scene file so all we need to do now is to find the header line and then use hard-coded offsets to the data we care about. There are no line markers, so hard-coding is the only option.
	// It's bloating this code somewhat, but for flexibility, we'll abstract our line references with variables to make this maintainable in future.

	kray_physsky_PluginHeaderLine = getMasterPluginLine("KrayPhySky"); // Should pick up MasterHandler for Kray

	// Startup checks to ensure we're working against a known quantity.
    if (kray_physsky_PluginHeaderLine == nil)
    {
		logger("info","scnGen_kray25_physky: Kray 2.5 physical sky plugin not found. Guessing....");
		kray_physsky_pluginBuild = default_kray_physky_pluginBuild;
		kray_physsky_sectionTag = default_kray_physky_sectionTag;
	} else {
		searchString = "Plugin MasterHandler";
		readIndex = kray_physsky_PluginHeaderLine + 3; // offset for the plugin header, the LSC script reference and the Kray encapsulator
		kray_physsky_pluginBuild = int(::readBuffer[readIndex]);
		readIndex++;
		kray_physsky_sectionTag = int(::readBuffer[readIndex]);
		readIndex++;
		kray_physsky_PluginEndLine = getPartialLine(kray_physsky_PluginHeaderLine,0,"EndPlugin");
		// Check known version of Kray in case of mismatch
		if((kray_physsky_pluginBuild != default_kray_physky_pluginBuild) || (kray_physsky_sectionTag != default_kray_physky_sectionTag))
		{
			logger("error","scnGen_kray25_physky: Kray Physical Sky version or section tag mismatch: " + kray_physsky_pluginBuild.asStr() + "/" + kray_physsky_sectionTag.asStr());
		}
	}

	// Kray writes out according to its functions :
	//		::krayfile.writeln("Kray{");
	//		save_general(io);
	//		save_krayscript_file(io,"");
	//		::krayfile.writeln("}");

	// Start values for the huge chunk of settings.
	// krayLineNumber = kray_physsky_pluginBuild;
	settingIndex = 2;

	if (kray_physsky_PluginHeaderLine != nil)
	{
		readIndex = 1;
		while(readIndex <= kray_physsky_PluginHeaderLine)
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
		::writeBuffer[size(::writeBuffer) + 1] = "Plugin MasterHandler " + string(masterHandlerCounter + 1) + " KrayPhySky";
		::writeBuffer[size(::writeBuffer) + 1] = "Script " + SCRIPTID.asStr();
	}

	::kray25_PhySky_settings = scnGen_kray25_PhySky_settings();
	scnGen_kray25_physky_general();
	scnGen_kray25_physky_script();

	if (kray_physsky_PluginHeaderLine != nil)
	{
		readIndex = kray_physsky_PluginEndLine;
	} else {
		::writeBuffer[size(::writeBuffer) + 1] = "EndPlugin";
	}
	while(readIndex <= size(::readBuffer))
	{
		::writeBuffer[size(::writeBuffer) + 1] = ::readBuffer[readIndex];
		readIndex++;
	}
}

scnGen_kray25_physky_general
{

	::writeBuffer[size(::writeBuffer) + 1] = kray25_PhySky_default_version;    // version number

    /* ::kray25_PhySky_settings = @kray25_PhySky_pluginTagString, string(kray25_PhySky_v_onFlag), string(kray25_PhySky_v_city_preset), string(kray25_PhySky_v_hour), string(kray25_PhySky_v_minute), string(kray25_PhySky_v_second), string(kray25_PhySky_v_day), string(kray25_PhySky_v_month), string(kray25_PhySky_v_year), string(kray25_PhySky_v_longitude), string(kray25_PhySky_v_north), string(kray25_PhySky_v_lattitude), string(kray25_PhySky_v_time_zone), string(kray25_PhySky_v_turbidity), string(kray25_PhySky_v_exposure), string(kray25_PhySky_v_volumetric), string(kray25_PhySky_v_ignore), string(kray25_PhySky_skyON), string(kray25_PhySky_sunON), string(kray25_PhySky_v_SunIntensity), string(kray25_PhySky_v_SunShadow), string(kray25_PhySky_v_sunpower)@;
    */

	::writeBuffer[size(::writeBuffer) + 1] = 117;
	kray25_PhySky_v_north = ::kray25_PhySky_settings[11];
	::writeBuffer[size(::writeBuffer) + 1] = kray25_PhySky_v_north;
	kray25_PhySky_v_second = ::kray25_PhySky_settings[6];
	::writeBuffer[size(::writeBuffer) + 1] = kray25_PhySky_v_second;
	kray25_PhySky_v_minute = ::kray25_PhySky_settings[5];
	::writeBuffer[size(::writeBuffer) + 1] = kray25_PhySky_v_minute;
	kray25_PhySky_v_hour = ::kray25_PhySky_settings[4];
	::writeBuffer[size(::writeBuffer) + 1] = kray25_PhySky_v_hour;
	kray25_PhySky_v_day = ::kray25_PhySky_settings[7];
	::writeBuffer[size(::writeBuffer) + 1] = kray25_PhySky_v_day;
	kray25_PhySky_v_month = ::kray25_PhySky_settings[8];
	::writeBuffer[size(::writeBuffer) + 1] = kray25_PhySky_v_month;
	kray25_PhySky_v_year = ::kray25_PhySky_settings[9];
	::writeBuffer[size(::writeBuffer) + 1] = kray25_PhySky_v_year;
	kray25_PhySky_v_lattitude = ::kray25_PhySky_settings[12];
	::writeBuffer[size(::writeBuffer) + 1] = kray25_PhySky_v_lattitude;
	kray25_PhySky_v_longitude = ::kray25_PhySky_settings[10];
	::writeBuffer[size(::writeBuffer) + 1] = kray25_PhySky_v_longitude;
	kray25_PhySky_v_time_zone = ::kray25_PhySky_settings[13];
	::writeBuffer[size(::writeBuffer) + 1] = kray25_PhySky_v_time_zone;
	kray25_PhySky_v_turbidity = ::kray25_PhySky_settings[14];
	::writeBuffer[size(::writeBuffer) + 1] = kray25_PhySky_v_turbidity;
	kray25_PhySky_v_exposure = ::kray25_PhySky_settings[15];
	::writeBuffer[size(::writeBuffer) + 1] = kray25_PhySky_v_exposure;
	
	kray25_PhySky_v_ignore = ::kray25_PhySky_settings[17];
	if (kray25_PhySky_v_ignore != nil)
	{
		::writeBuffer[size(::writeBuffer) + 1] = kray25_PhySky_v_ignore.id; // FIXME: probably broken here in PPRN.
	} else {
		::writeBuffer[size(::writeBuffer) + 1] = 0;
	}

	kray25_PhySky_v_volumetric = ::kray25_PhySky_settings[16];
	::writeBuffer[size(::writeBuffer) + 1] = kray25_PhySky_v_volumetric;
	kray25_PhySky_skyON = ::kray25_PhySky_settings[18];
	::writeBuffer[size(::writeBuffer) + 1] = kray25_PhySky_skyON;
	kray25_PhySky_sunON = ::kray25_PhySky_settings[19];
	::writeBuffer[size(::writeBuffer) + 1] = kray25_PhySky_sunON;
	kray25_PhySky_v_city_preset = ::kray25_PhySky_settings[3];
	::writeBuffer[size(::writeBuffer) + 1] = kray25_PhySky_v_city_preset;
	
	::writeBuffer[size(::writeBuffer) + 1] = 201;
	kray25_PhySky_v_onFlag = ::kray25_PhySky_settings[2];
	::writeBuffer[size(::writeBuffer) + 1] = kray25_PhySky_v_onFlag;
	
	::writeBuffer[size(::writeBuffer) + 1] = 302;
	kray25_PhySky_v_SunIntensity = ::kray25_PhySky_settings[20];
	::writeBuffer[size(::writeBuffer) + 1] = kray25_PhySky_v_SunIntensity;
	kray25_PhySky_v_SunShadow = ::kray25_PhySky_settings[21];
	::writeBuffer[size(::writeBuffer) + 1] = kray25_PhySky_v_SunShadow;
	
	// These are hard-coded values in the globals; not sure if they are ever user-adjustable. Might be legacy.
	::writeBuffer[size(::writeBuffer) + 1] = 402;
	::writeBuffer[size(::writeBuffer) + 1] = kray25_PhySky_sunarea_min;
	::writeBuffer[size(::writeBuffer) + 1] = kray25_PhySky_sunarea_max;
	
	::writeBuffer[size(::writeBuffer) + 1] = 501;
	kray25_PhySky_v_sunpower = ::kray25_PhySky_settings[22];
	::writeBuffer[size(::writeBuffer) + 1] = kray25_PhySky_v_sunpower;
	
	::writeBuffer[size(::writeBuffer) + 1] = 0;  // end hunk
}

scnGen_kray25_physky_script
{
	kray25_PhySky_SettingIndex = 2; // skip our tag
	kray25_PhySky_v_onFlag = ::kray25_PhySky_settings[kray25_PhySky_SettingIndex];
	kray25_PhySky_SettingIndex++;
	kray25_PhySky_v_city_preset = ::kray25_PhySky_settings[kray25_PhySky_SettingIndex];
	kray25_PhySky_SettingIndex++;
	kray25_PhySky_v_hour = ::kray25_PhySky_settings[kray25_PhySky_SettingIndex];
	kray25_PhySky_SettingIndex++;
	kray25_PhySky_v_minute = ::kray25_PhySky_settings[kray25_PhySky_SettingIndex];
	kray25_PhySky_SettingIndex++;
	kray25_PhySky_v_second = ::kray25_PhySky_settings[kray25_PhySky_SettingIndex];
	kray25_PhySky_SettingIndex++;
	kray25_PhySky_v_day = ::kray25_PhySky_settings[kray25_PhySky_SettingIndex];
	kray25_PhySky_SettingIndex++;
	kray25_PhySky_v_month = ::kray25_PhySky_settings[kray25_PhySky_SettingIndex];
	kray25_PhySky_SettingIndex++;
	kray25_PhySky_v_year = ::kray25_PhySky_settings[kray25_PhySky_SettingIndex];
	kray25_PhySky_SettingIndex++;
	kray25_PhySky_v_longitude = ::kray25_PhySky_settings[kray25_PhySky_SettingIndex];
	kray25_PhySky_SettingIndex++;
	kray25_PhySky_v_north = ::kray25_PhySky_settings[kray25_PhySky_SettingIndex];
	kray25_PhySky_SettingIndex++;
	kray25_PhySky_v_lattitude = ::kray25_PhySky_settings[kray25_PhySky_SettingIndex];
	kray25_PhySky_SettingIndex++;
	kray25_PhySky_v_time_zone = ::kray25_PhySky_settings[kray25_PhySky_SettingIndex];
	kray25_PhySky_SettingIndex++;
	kray25_PhySky_v_turbidity = ::kray25_PhySky_settings[kray25_PhySky_SettingIndex];
	kray25_PhySky_SettingIndex++;
	kray25_PhySky_v_exposure = ::kray25_PhySky_settings[kray25_PhySky_SettingIndex];
	kray25_PhySky_SettingIndex++;
	kray25_PhySky_v_volumetric = ::kray25_PhySky_settings[kray25_PhySky_SettingIndex];
	kray25_PhySky_SettingIndex++;
	kray25_PhySky_v_ignore = ::kray25_PhySky_settings[kray25_PhySky_SettingIndex];
	kray25_PhySky_SettingIndex++;
	kray25_PhySky_skyON = ::kray25_PhySky_settings[kray25_PhySky_SettingIndex];
	kray25_PhySky_SettingIndex++;
	kray25_PhySky_sunON = ::kray25_PhySky_settings[kray25_PhySky_SettingIndex];
	kray25_PhySky_SettingIndex++;
	kray25_PhySky_v_SunIntensity = ::kray25_PhySky_settings[kray25_PhySky_SettingIndex];
	kray25_PhySky_SettingIndex++;
	kray25_PhySky_v_SunShadow = ::kray25_PhySky_settings[kray25_PhySky_SettingIndex];
	kray25_PhySky_SettingIndex++;
	kray25_PhySky_v_sunpower = ::kray25_PhySky_settings[kray25_PhySky_SettingIndex];

	if (kray25_PhySky_v_onFlag)
	{
		// and script for Kray
		// will be executed after header commands (-1000) and scene load (0), but before tailer commands (1000)

		::writeBuffer[size(::writeBuffer) + 1] = "KrayScriptLWSInlined 100;";
		::writeBuffer[size(::writeBuffer) + 1] = "onevent framesetup;";
		::writeBuffer[size(::writeBuffer) + 1] = "var time_of_day,"+kray25_PhySky_v_hour+"+("+kray25_PhySky_v_minute+"/60)+("+kray25_PhySky_v_second+"/3600);";
		::writeBuffer[size(::writeBuffer) + 1] = "var day_of_year,floor("+kray25_PhySky_v_day+"+30.5*("+kray25_PhySky_v_month+"-1));";
		::writeBuffer[size(::writeBuffer) + 1] = "hpbaxes sky_axes,"+kray25_PhySky_v_north+"+90,-180,0;";
		::writeBuffer[size(::writeBuffer) + 1] = "physkysundir sun_direction,"+kray25_PhySky_v_lattitude+","+kray25_PhySky_v_longitude+",day_of_year,time_of_day,"+kray25_PhySky_v_time_zone+";";
		// reverse west and east
		::writeBuffer[size(::writeBuffer) + 1] = "axes rev_east_west_axes,(1,0,0),(0,1,0),(0,0,-1);";
		::writeBuffer[size(::writeBuffer) + 1] = "vecaxismult sun_direction,rev_east_west_axes;";
		::writeBuffer[size(::writeBuffer) + 1] = "vecaxisdiv sun_direction,sky_axes;";
		::writeBuffer[size(::writeBuffer) + 1] = "physky mysky,sun_direction,"+kray25_PhySky_v_turbidity+","+kray25_PhySky_v_exposure+",sky_axes;";
		::writeBuffer[size(::writeBuffer) + 1] = "physkyparam mysky,sunintensity,"+kray25_PhySky_v_SunIntensity+";";
		::writeBuffer[size(::writeBuffer) + 1] = "physkyparam mysky,sunspotangle,"+kray25_PhySky_v_SunShadow+";";
		::writeBuffer[size(::writeBuffer) + 1] = "echo '*** Kray physical sky applied ***';";
		
		if (kray25_PhySky_skyON)
		{
			::writeBuffer[size(::writeBuffer) + 1] = "background physky,mysky;";
			::writeBuffer[size(::writeBuffer) + 1] = "echo '*** Applying Physical Sky Backdrop ***';";		
		}
		switch(kray25_PhySky_v_volumetric)
		{
		case 1:
			::writeBuffer[size(::writeBuffer) + 1] = "echo '*** No Volumetrics Applied ***';";
			break;
		case 2:
			::writeBuffer[size(::writeBuffer) + 1] = "environment physky,mysky,8;";
			::writeBuffer[size(::writeBuffer) + 1] = "echo '*** Applying Physical Sky Volumetrics to backdrop ***';";
			break;
		case 3:
			::writeBuffer[size(::writeBuffer) + 1] = "environment physky,mysky,4;";
			::writeBuffer[size(::writeBuffer) + 1] = "echo '*** Applying Physical Sky Volumetrics to shadows ***';";
			break;					
		case 4:
			::writeBuffer[size(::writeBuffer) + 1] = "environment physky,mysky,2;";
			::writeBuffer[size(::writeBuffer) + 1] = "echo '*** Applying Physical Sky Volumetrics to FG ***';";
			break;
		}
		::writeBuffer[size(::writeBuffer) + 1] = "echo '*** Time: "+kray25_PhySky_v_hour+" h "+kray25_PhySky_v_minute+" min "+kray25_PhySky_v_second+" sec, Month: "+kray25_PhySky_v_month+" Day: "+kray25_PhySky_v_day+" Year: "+kray25_PhySky_v_year+" Timezone: "+kray25_PhySky_v_time_zone+" ***';";
		::writeBuffer[size(::writeBuffer) + 1] = "echo '*** Lattitude: "+kray25_PhySky_v_lattitude+" Longitude: "+kray25_PhySky_v_longitude+" North direction: "+kray25_PhySky_v_north+" ***';";
		::writeBuffer[size(::writeBuffer) + 1] = "echo '*** Turbidity: "+kray25_PhySky_v_turbidity+" Exposure: "+kray25_PhySky_v_exposure+" ***';";

		lcmd="light ";
		lightname="mysun";
		if(kray25_PhySky_v_ignore)
		{
			::writeBuffer[size(::writeBuffer) + 1] = "ignorelwitemid "+hex(kray25_PhySky_v_ignore.id)+";";
			::writeBuffer[size(::writeBuffer) + 1] = "echo '*** Ignoring Light: "+hex(kray25_PhySky_v_ignore.id)+" ***';";

			SelectedLight = hex(kray25_PhySky_v_ignore.id);
			lcmd="replacelwlight "+SelectedLight+",";

			SelectedLight=string(SelectedLight);			
			SelectedLight=strright(SelectedLight,8);
			lightname="LW"+SelectedLight;
		}else{
			lcmd="lightname "+lightname+",";
		}
		if (kray25_PhySky_sunON)
		{
			::writeBuffer[size(::writeBuffer) + 1] = lcmd+"physky,mysky,adaptive,10000000,0.002,"+kray25_PhySky_sunarea_min+","+kray25_PhySky_sunarea_max+";";
			::writeBuffer[size(::writeBuffer) + 1] = "lightphotonmultiplier "+lightname+",1,"+kray25_PhySky_v_sunpower+";";
		}
		::writeBuffer[size(::writeBuffer) + 1] = "end;";
		// end of our script
		::writeBuffer[size(::writeBuffer) + 1] = "end;";
	}
}

scnGen_kray25_PhySky_Values
{
	valTmpStr = string(::kray25_PhySky_settings[1]);
	for (k = 2; k <= ::kray25_PhySky_settings.size(); k++)
	{
		valTmpStr = valTmpStr + "||" + string(::kray25_PhySky_settings[k]);
	}
	return valTmpStr;
}

scnGen_kray25_PhySky_settings
{
	for (k = 1; k <= ::kray25_PhySky_settings_default.size(); k++)
	{
		::kray25_PhySky_settings[k] = ::settingsArray[::krayPluginSettingIndexHandler];
		::krayPluginSettingIndexHandler++;
	}
}

scnGen_kray25_PhySky_defaultsettings
{
	tempIndex = 1;
	::kray25_PhySky_settings[tempIndex] = string(kray25_PhySky_pluginTagString);
	tempIndex++;
	::kray25_PhySky_settings[tempIndex] = string(kray25_PhySky_default_v_onFlag);
	tempIndex++;
	::kray25_PhySky_settings[tempIndex] = string(kray25_PhySky_default_v_city_preset);
	tempIndex++;
	::kray25_PhySky_settings[tempIndex] = string(kray25_PhySky_default_v_hour);
	tempIndex++;
	::kray25_PhySky_settings[tempIndex] = string(kray25_PhySky_default_v_minute);
	tempIndex++;
	::kray25_PhySky_settings[tempIndex] = string(kray25_PhySky_default_v_second);
	tempIndex++;
	::kray25_PhySky_settings[tempIndex] = string(kray25_PhySky_default_v_day);
	tempIndex++;
	::kray25_PhySky_settings[tempIndex] = string(kray25_PhySky_default_v_month);
	tempIndex++;
	::kray25_PhySky_settings[tempIndex] = string(kray25_PhySky_default_v_year);
	tempIndex++;
	::kray25_PhySky_settings[tempIndex] = string(kray25_PhySky_default_v_longitude);
	tempIndex++;
	::kray25_PhySky_settings[tempIndex] = string(kray25_PhySky_default_v_north);
	tempIndex++;
	::kray25_PhySky_settings[tempIndex] = string(kray25_PhySky_default_v_lattitude);
	tempIndex++;
	::kray25_PhySky_settings[tempIndex] = string(kray25_PhySky_default_v_time_zone);
	tempIndex++;
	::kray25_PhySky_settings[tempIndex] = string(kray25_PhySky_default_v_turbidity);
	tempIndex++;
	::kray25_PhySky_settings[tempIndex] = string(kray25_PhySky_default_v_exposure);
	tempIndex++;
	::kray25_PhySky_settings[tempIndex] = string(kray25_PhySky_default_v_volumetric);
	tempIndex++;
	::kray25_PhySky_settings[tempIndex] = string(kray25_PhySky_default_v_ignore);
	tempIndex++;
	::kray25_PhySky_settings[tempIndex] = string(kray25_PhySky_default_skyON);
	tempIndex++;
	::kray25_PhySky_settings[tempIndex] = string(kray25_PhySky_default_sunON);
	tempIndex++;
	::kray25_PhySky_settings[tempIndex] = string(kray25_PhySky_default_v_SunIntensity);
	tempIndex++;
	::kray25_PhySky_settings[tempIndex] = string(kray25_PhySky_default_v_SunShadow);
	tempIndex++;
	::kray25_PhySky_settings[tempIndex] = string(kray25_PhySky_default_v_sunpower);
}
