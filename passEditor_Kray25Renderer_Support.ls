// kray2.5 renderer globals

// kray 2.5 external renderer lines.
Kray25Lines = @"ExternalRenderer KrayRenderer","Plugin ExtRendererHandler 1 KrayRenderer","EndPlugin"@;

// scnMaster override UI stuff
scnmasterOverride_UI_kray25: action
{
	if(renderers.indexOf("Kray 2.5") == 0)
	{
		info("Sorry - not ready yet.");
		return;
	}

	// sel only used in edit action.
	// action should be either 'new' or 'edit'
	if (action == "new" || action == "edit")
	{
		if(action == "edit")
		{
			sel = getvalue(gad_OverridesListview).asInt();
			settingsArray = parseOverrideSettings(overrideSettings[sel]);
			overrideRenderer			= integer(settingsArray[3]);
		}
	
		doKeys = 0;

		reqbeginstr = "New Scene Master Override";
		if(action == "edit")
		{
			reqbeginstr = "Edit Scene Master Override";
		}
		reqbegin(reqbeginstr);
		reqsize(ScnMst_ui_window_w, 725);

		newName = "SceneMasterOverride";
		if(action == "edit")
		{
			newName = settingsArray[1];
		}
		c20 = ctlstring("Override Name:",newName);
		ctlposition(c20, ScnMst_gad_x, ScnMst_gad_y, ScnMst_gad_w, ScnMst_gad_h, ScnMst_gad_text_offset);

		if(reqpost())
		{
			newName 						= getvalue(c20);
			newName 						= makeStringGood(newName);
			overrideRenderer				= 2; // hard-coded.

			newNumber = sel;
			if(action == "new")
			{
				pass = currentChosenPass;
				if(overrideNames[1] != "empty")
				{
					newNumber = size(overrideNames) + 1;
				}
				else
				{
					newNumber = 1;
				}
				passOverrideItems[pass][newNumber] = "";
				for(y = 1; y <= size(passNames); y++)
				{
					passOverrideItems[y][newNumber] = "";
				}
			}
			overrideNames[newNumber] = newName + "   (scene properties)";
			overrideSettings[newNumber] = newName 								+ 	"||" 	+ "type6" 						+ 	"||"
										+ string(overrideRenderer);
		}
		reqend();
	} else {
		error("scnmasterOverride_UI: incorrect, or no, action passed");
	}
}
