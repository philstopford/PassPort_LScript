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
			if(o_items != nil)
			{
				o_items_size = sizeof(o_items);
				for(x = 1;x <= o_items_size;x++)  {
					o_items_array[x] = o_items[x];
					if(o_items[x] == 1)
					{
						passOverrideItems[pass][sel] = passOverrideItems[pass][sel] + "||" + "(Scene Master)";
					}
					else
					{
						passOverrideItems[pass][sel] = passOverrideItems[pass][sel] + "||" + displayIDs[o_items[x] - 1];
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
	o_itemslb = o_displayNamesObjectIndex;
    pass = currentChosenPass;
    overrides_array = nil;
    if(overrides_items != nil)
    {
		overridesSelected = true;
        overrides_size = sizeof(overrides_items);

        if(overrides_size > 1) // user selected more than one override, so we pick the first in the index for handling.
        {
		    setvalue(gad_OverridesListview, overrides_items[1]);
			overrides_size = 1;
        }

		overrides_sel = overrides_items[1]; // index of selected override in list.
		o_tempSettingsArray = parse("||",overrideSettings[overrides_sel]);
		tempOverrideType = o_tempSettingsArray[2];
		info("tempOverrideType : " + tempOverrideType);
		o_displayNamesFiltered = nil;
		o_displayNamesFilteredIndex = 1;

		filtered = 0;

		if(tempOverrideType == "type1" || tempOverrideType == "type2" || tempOverrideType == "type4" || tempOverrideType == "type7")
		{	// object-genus specific overrides : only objects permitted. Type 4 debatable whether object-specific....
			filtered = 1;
			for (i = 2; i < o_displayNames.size(); i++) { // no point considering the scene master in [1]
				if (o_displayGenus[i] == 1)
				{
					o_displayNamesFiltered[o_displayNamesFilteredIndex] = o_displayNames[i];
					o_displayNamesFilteredIndex++;
				}
			}
		}
		
		if(tempOverrideType == "type3" && filtered == 0)
		{	// light/object-genus specific overrides : only lights/objects permitted
			filtered = 1;
			for (i = 2; i < o_displayNames.size(); i++) { // no point considering the scene master in [1]
				if (o_displayGenus[i] == 1 || o_displayGenus[i] == 2)
				{
					info("Filtering for lights and objects");
					o_displayNamesFiltered[o_displayNamesFilteredIndex] = o_displayNames[i];
					o_displayNamesFilteredIndex++;
				}
			}
		}

		if(tempOverrideType == "type5" && filtered == 0)
		{	// light-genus specific overrides : only lights permitted
			filtered = 1;
			for (i = 2; i < o_displayNames.size(); i++) { // no point considering the scene master in [1]
				if (o_displayGenus[i] == 2)
				{
					info("Filtering for lights");
					o_displayNamesFiltered[o_displayNamesFilteredIndex] = o_displayNames[i];
					o_displayNamesFilteredIndex++;
				} else {
					info(o_displayGenus[i]);
					info(o_displayNames[i]);
					info(i + ": genus: " + o_displayGenus[i] + " for " + o_displayNames[i]);
				}
			}
		}

		if(tempOverrideType == "type6" && filtered == 0)
		{	// scene override : only scene master permitted
			o_displayNamesFiltered[1] = o_displayNames[1];
		}

//			set_o_items = o_displayNamesFiltered; // temporary to check if implementation is compatible
//			info ("set_o_items: " + set_o_items);
//			setvalue(gad_SceneItems_forOverrides_Listview,set_o_items); // this defines the scene items for the list view (set_o_items). Since we now use o_displayNameFiltered, seems obsolete.
		setvalue(gad_PassesListview,nil);
		req_update();
    }
    else
    {
        overridesSelected = false;
		o_displayNamesFiltered = nil; // empty filtered list - override selected, but no assigned items.
        setvalue(gad_OverridesListview,nil);
        setvalue(gad_SceneItems_forOverrides_Listview,nil);
        setvalue(gad_PassesListview,nil);
        req_update();
    }
}
