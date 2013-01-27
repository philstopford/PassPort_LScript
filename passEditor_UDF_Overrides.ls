// Overrides

o_itemslb_count
{
	return o_displayNamesFiltered.size();
}

o_itemslb_name: index
{
	return o_displayNamesFiltered[index];
}

o_itemslb_event: o_items // Add items to the selected override; need to filter display list.
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
			o_tempSettingsArray = parse("||",overrideSettings[sel]);
			tempOverrideType = o_tempSettingsArray[2];
			if(o_items != nil)
			{
				o_items_size = sizeof(o_items);
				for(x = 1;x <= o_items_size;x++)  {
					o_items_array[x] = o_items[x];
					if(/*o_items[x] == 1 */ tempOverrideType == "type6") // only one (Scene Master) and this is only applicable for type6 overrides.
					{
						passOverrideItems[pass][sel] = passOverrideItems[pass][sel] + "||" + "(Scene Master)";
					}
					else
					{
						passOverrideItems[pass][sel] = passOverrideItems[pass][sel] + "||" + o_displayIDsFiltered[x]; // look up our ID in the filtered list.
					}
				}
			}
			else
			{
				setvalue(gad_SceneItems_forOverrides_Listview,nil);
				req_update();
			}
		}
		else
		{
			setvalue(gad_SceneItems_forOverrides_Listview,nil);
			req_update();
		}
	}
	else
	{
		setvalue(gad_SceneItems_forOverrides_Listview,nil);
		req_update();
	}
}

o_parseListItems: overrideItemsString
{
	if (overrideItemsString != nil)
	{
		idsArray = parse("||",overrideItemsString);
	/*	if(string(idsArray[1]) == "(Scene Master)")
		{
			itemsParsedArray[1] = 1;
			z = 2;
		}
		else
		{
			z = 1;
		}
	*/
		z = 1; // still need to special case scene override.
		
		for(x = 1; x <= size(o_displayIDsFiltered); x++)
		{
			for(y = 1; y <= size(idsArray); y++)
			{
				if(string(o_displayIDsFiltered[x]) == string(idsArray[y]))
				{
					itemsParsedArray[z] = x;
					z++;
				}
			}
		}

		if(z > 1) {
			return(itemsParsedArray);
		} else {
			return nil;
		}
	} else {
		return nil;
	}
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

overrideslb_event: overrides_list
{   
	o_itemslb = o_displayNamesObjectIndex;
    overrides_array = nil;
    if(overrides_list != nil)
    {
		overridesSelected = true;
        overrides_size = sizeof(overrides_list);

        if(overrides_size > 1) // user selected more than one override, so we pick the first in the index for handling.
        {
		    setvalue(gad_OverridesListview, overrides_list[1]);
			overrides_size = 1;
        }

		// MOVED TO o_Filter function.
		o_Filter(overrides_list);
		
		// Update the listboxes with new content
		req_update();
		// The setvalue call below sets the highlighting on any items that are selected for the current override.
		setvalue(gad_SceneItems_forOverrides_Listview,o_parseListItems(passOverrideItems[currentChosenPass][overrides_list[1]]));
		
		setvalue(gad_PassesListview,nil);
		// Update to draw the highlighting. This doesn't seem to repaint the listbox list in the process, so the earlier req_update() is needed.
		req_update();
    }
    else
    {
        overridesSelected = false;
		o_displayNamesFiltered = nil; // empty filtered list - override selected, but no assigned items.
		req_update();
		// Clear any highlighting.
        setvalue(gad_OverridesListview,nil);
        setvalue(gad_PassesListview,nil);
        req_update();
    }
}

o_Filter: overrides_list
{
		overrides_sel = overrides_list[1]; // index of selected override in list.
		o_tempSettingsArray = parse("||",overrideSettings[overrides_sel]);
		tempOverrideType = o_tempSettingsArray[2];
		o_displayNamesFiltered = nil;
		o_displayIDsFiltered = nil;
		o_displayFilterIndex = 1;

		filtered = 0;

		if(tempOverrideType == "type1" || tempOverrideType == "type2" || tempOverrideType == "type4" || tempOverrideType == "type7")
		{	// object-genus specific overrides : only objects permitted. Type 4 debatable whether object-specific....
			filtered = 1;
			for (i = 2; i <= o_displayNames.size(); i++) { // no point considering the scene master in [1]
				if (o_displayGenus[i] == 1)
				{
					o_displayNamesFiltered[o_displayFilterIndex] = o_displayNames[i];
					o_displayIDsFiltered[o_displayFilterIndex] = o_displayIDs[i];
					o_displayFilterIndex++;
				}
			}
		}
		
		if(tempOverrideType == "type3" && filtered == 0)
		{	// light/object-genus specific overrides : only lights/objects permitted
			filtered = 1;
			for (i = 2; i <= o_displayNames.size(); i++) { // no point considering the scene master in [1]
				if (o_displayGenus[i] == 1 || o_displayGenus[i] == 2)
				{
					o_displayNamesFiltered[o_displayFilterIndex] = o_displayNames[i];
					o_displayIDsFiltered[o_displayFilterIndex] = o_displayIDs[i];
					o_displayFilterIndex++;
				}
			}
		}

		if(tempOverrideType == "type5" && filtered == 0)
		{	// light-genus specific overrides : only lights permitted
			filtered = 1;
			for (i = 2; i <= o_displayNames.size(); i++) { // no point considering the scene master in [1]
				if (o_displayGenus[i] == 2)
				{
					o_displayNamesFiltered[o_displayFilterIndex] = o_displayNames[i];
					o_displayIDsFiltered[o_displayFilterIndex] = o_displayIDs[i];
					o_displayFilterIndex++;
				}
			}
		}

		if(tempOverrideType == "type6" && filtered == 0)
		{	// scene override : only scene master permitted
			o_displayNamesFiltered[1] = o_displayNames[1];
			o_displayIDsFiltered[1] = o_displayNames[1];
		}
}