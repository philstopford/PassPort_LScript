// Listbox

o_itemslb_count
{
	return ::o_displayNamesFiltered.size();
}

o_itemslb_name: index
{
	return ::o_displayNamesFiltered[index];
}

o_itemslb_event: o_items // Add items to the selected override; need to filter display list.
{

	o_items_array = nil;
	::pass = ::currentChosenPass;
	sel = getvalue(gad_OverridesListview).asInt();

	if(::overrideNames[1] != "empty")
	{
		if(::overridesSelected == true && sel != 0)
		{
			::previousPassOverrideItems[::pass][sel] = ::passOverrideItems[::pass][sel];
			::passOverrideItems[::pass][sel] = "";
			o_tempSettingsArray = parse("||",::overrideSettings[sel]);
			tempOverrideType = o_tempSettingsArray[2];
			if(o_items != nil)
			{
				o_items_size = sizeof(o_items);
				for(x = 1;x <= o_items_size;x++)  {
					o_items_array[x] = o_items[x];
					if(/*o_items[x] == 1 */ tempOverrideType == "type6") // only one (Scene Master) and this is only applicable for type6 overrides.
					{
						::passOverrideItems[::pass][sel] = ::passOverrideItems[::pass][sel] + "||" + "(Scene Master)";
					}
					else
					{
						::passOverrideItems[::pass][sel] = ::passOverrideItems[::pass][sel] + "||" + ::o_displayIDsFiltered[o_items[x]]; // look up our ID in the filtered list.
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
	req_update();
}

o_parseListItems: overrideItemsString
{
	if (overrideItemsString != nil)
	{
		sel = getvalue(gad_OverridesListview).asInt();
		o_tempSettingsArray = parse("||",::overrideSettings[sel]);
		tempOverrideType = o_tempSettingsArray[2];

		if(tempOverrideType == "type6") // special case for the scene master override
										// might need to be tweaked in case of multiple scene overrides; assumes SM always assigned.
		{
			itemsParsedArray[1] = 1;
			z = 2;
		}
		else
		{
			idsArray = parse("||",overrideItemsString);

			z = 1;
			for(x = 1; x <= size(::o_displayIDsFiltered); x++)
			{
				for(y = 1; y <= size(idsArray); y++)
				{
					if(::o_displayIDsFiltered[x].asStr() == idsArray[y].asStr())
					{
						itemsParsedArray[z] = x;
						z++;
					}
				}
			}
		}

		if(z > 1) { // we found at least one match, so the index value was bumped to at least 2 in the process.
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
    if(::overrideNames[1] != "empty")
    {
        return(::overrideNames.size());
    }
    else
    {
        return(nil);
    }
}

overrideslb_name: index
{
/*    if(::overrideNames[1] != "empty")
    {
		if(getvalue(gad_OverridesListview) >= 1)
		{
			if(::passOverrideItems[::currentChosenPass][getvalue(gad_OverridesListview)] != "" && ::overrideNames[1] != "empty")
			{
				return(" " + ::icon[BULLET] + " " + ::overrideNames[index]);
			}
		} */
		return(::overrideNames[index]);
/*    }
    else
    {
        return(nil);
    } */
}

overrideslb_event: overrides_list
{   
	o_itemslb = o_displayNamesObjectIndex;
    overrides_array = nil;
    if(overrides_list != nil)
    {
		::overridesSelected = true;
        overrides_size = sizeof(overrides_list);

        if(overrides_size > 1) // user selected more than one override, so we pick the first in the index for handling.
        {
		    setvalue(gad_OverridesListview, overrides_list[1]);
			overrides_size = 1;
        }

		o_Filter(overrides_list);
		
		// The setvalue call below sets the highlighting on any items that are selected for the current override.
		setvalue(gad_SceneItems_forOverrides_Listview,o_parseListItems(::passOverrideItems[::currentChosenPass][overrides_list[1]]));		
		setvalue(gad_PassesListview,nil);
		// Update to draw the highlighting. This doesn't seem to repaint the listbox list in the process, so the earlier req_update() is needed.
		req_update();
        req_update();
    }
    else
    {
        ::overridesSelected = false;
		::o_displayNamesFiltered = nil; // empty filtered list - override selected, but no assigned items.
		// Clear any highlighting.
        setvalue(gad_OverridesListview,nil);
        setvalue(gad_PassesListview,nil);
        req_update();
        req_update();
    }
}

o_Filter: overrides_list
{
        passItemsIDsArray = parse("||",::passAssItems[::currentChosenPass]);

		overrides_sel = overrides_list[1]; // index of selected override in list.
		o_tempSettingsArray = parse("||",::overrideSettings[overrides_sel]);
		tempOverrideType = o_tempSettingsArray[2];
		::o_displayNamesFiltered = nil;
		::o_displayIDsFiltered = nil;
		o_displayFilterIndex = 1;

		filtered = 0;

		if(tempOverrideType == "type1" || tempOverrideType == "type2" || tempOverrideType == "type4" || tempOverrideType == "type7")
		{	// object-genus specific overrides : only objects permitted. Type 4 debatable whether object-specific....
			filtered = 1;
			for (i = 2; i <= ::o_displayNames.size(); i++) { // no point considering the scene master in [1]
				if (::o_displayGenus[i] == MESH) // Last check is to only show items assigned to the currently selected pass.
				{
                    for(j = 1; j <= passItemsIDsArray.size(); j++)
                    {
                        if(string(passItemsIDsArray[j]) == string(::o_displayIDs[i]))
                        {
        					::o_displayNamesFiltered[o_displayFilterIndex] = ::o_displayNames[i];
        					::o_displayIDsFiltered[o_displayFilterIndex] = ::o_displayIDs[i];
        					o_displayFilterIndex++;
                        }
                    }
				}
			}
		}
		
		if(tempOverrideType == "type3" && filtered == 0)
		{	// light/object-genus specific overrides : only lights/objects/cameras permitted
			filtered = 1;
			for (i = 2; i <= ::o_displayNames.size(); i++) { // no point considering the scene master in [1]
				if (::o_displayGenus[i] == MESH || ::o_displayGenus[i] == LIGHT  || ::o_displayGenus[i] == CAMERA) // Last check is to only show items assigned to the currently selected pass.
				{
                    for(j = 1; j <= passItemsIDsArray.size(); j++)
                    {
                        if(string(passItemsIDsArray[j]) == string(::o_displayIDs[i]))
                        {
        					::o_displayNamesFiltered[o_displayFilterIndex] = ::o_displayNames[i];
        					::o_displayIDsFiltered[o_displayFilterIndex] = ::o_displayIDs[i];
        					o_displayFilterIndex++;
                        }
                    }
				}
			}
		}

		if(tempOverrideType == "type5" && filtered == 0)
		{	// light-genus specific overrides : only lights permitted
			filtered = 1;
			for (i = 2; i <= ::o_displayNames.size(); i++) { // no point considering the scene master in [1]
				if (::o_displayGenus[i] == LIGHT) // Last check is to only show items assigned to the currently selected pass.
				{
                    for(j = 1; j <= passItemsIDsArray.size(); j++)
                    {
                        if(string(passItemsIDsArray[j]) == string(::o_displayIDs[i]))
                        {
                            ::o_displayNamesFiltered[o_displayFilterIndex] = ::o_displayNames[i];
                            ::o_displayIDsFiltered[o_displayFilterIndex] = ::o_displayIDs[i];
                            o_displayFilterIndex++;
                        }
                    }
				}
			}
		}

		if(tempOverrideType == "type8" && filtered == 0)
		{	// camera-genus specific overrides : only cameras permitted
			filtered = 1;
			for (i = 2; i <= ::o_displayNames.size(); i++) { // no point considering the scene master in [1]
				if (::o_displayGenus[i] == CAMERA) // Last check is to only show items assigned to the currently selected pass.
				{
                    for(j = 1; j <= passItemsIDsArray.size(); j++)
                    {
                        if(string(passItemsIDsArray[j]) == string(::o_displayIDs[i]))
                        {
        					::o_displayNamesFiltered[o_displayFilterIndex] = ::o_displayNames[i];
        					::o_displayIDsFiltered[o_displayFilterIndex] = ::o_displayIDs[i];
        					o_displayFilterIndex++;
                        }
                    }
				}
			}
		}

		if(tempOverrideType == "type6" && filtered == 0)
		{	// scene override : only scene master permitted
			::o_displayNamesFiltered[1] = ::o_displayNames[1];
			::o_displayIDsFiltered[1] = ::o_displayNames[1];
		}
}

// Buttons

o_addAllButton
{
    o_items_array = nil;
    ::pass = ::currentChosenPass;
    sel = getvalue(gad_OverridesListview).asInt();
    o_tempSettingsArray = parse("||",::overrideSettings[sel]);
	
    if(::overridesSelected == true && sel != 0)
    {
        ::previousPassOverrideItems[::pass][sel] = ::passOverrideItems[::pass][sel];
        ::passOverrideItems[::pass][sel] = ""; // erase since we're going to add the universe.

        if(o_tempSettingsArray[2] == "type6") // scene master - only one item, so no problem.
		{
	        ::passOverrideItems[::pass][sel] = ::passOverrideItems[::pass][sel] + "||" + "(Scene Master)";
		} else { // we don't need to care about override type - the list is already filtered against the selected override type.
			o_items_size = sizeof(::o_displayNamesFiltered);
			o_items_array[1] = 1;
			for(x = 1;x <= o_items_size;x++)
			{
				o_items_array[x] = x;
				::passOverrideItems[::pass][sel] = ::passOverrideItems[::pass][sel] + "||" + ::o_displayIDsFiltered[x];
			}
		}
        // set highlighting for matching items.
        setvalue(gad_SceneItems_forOverrides_Listview,o_parseListItems(::passOverrideItems[::pass][sel]));
        req_update();
    }
    else
    {
        setvalue(gad_SceneItems_forOverrides_Listview,nil);
        req_update();
    }
    req_update();
}


o_clearAllButton
{
    if(::areYouSurePrompts == 1)
    {
        ::doKeys = 0;
        reqbegin("Confirm Clear Override Assignments");
        c20 = ctltext("","Are you sure you want to clear all override assignments?");
        if(reqpost())
        {
            o_items_array = nil;
            ::pass = ::currentChosenPass;
            sel = getvalue(gad_OverridesListview).asInt();
            if(::overridesSelected == true && sel != 0)
            {
                ::previousPassOverrideItems[::pass][sel] = ::passOverrideItems[::pass][sel];
                ::passOverrideItems[::pass][sel] = "";
                setvalue(gad_SceneItems_forOverrides_Listview,nil);
                req_update();
            }
        }
        else
        {
            logger("warn","Clearing of override assignments cancelled.");
        }
        reqend();
        ::doKeys = 1;
    }
    else
    {

        o_items_array = nil;
        ::pass = ::currentChosenPass;
        sel = getvalue(gad_OverridesListview).asInt();
        if(::overridesSelected == true && sel != 0)
        {
            ::passOverrideItems[::pass][sel] = "";
            setvalue(gad_SceneItems_forOverrides_Listview,nil);
            req_update();
        }
    }
    req_update();
}


o_addSelButton
{   
    o_items_array = nil;
    ::pass = ::currentChosenPass;
    sel = getvalue(gad_OverridesListview).asInt();
    o_tempSettingsArray = parse("||",::overrideSettings[sel]);
    if(::overridesSelected == true && sel != 0)
    {
        s = ::masterScene.getSelect(); // picks up selected items in Layout, matching documentation.
        if(s != nil)
        {
            arraySize = sizeof(s);
            for(x = 1; x <= arraySize; x++)
            {
                itemname = s[x].name;
                ::previousPassOverrideItems[::pass][sel] = ::passOverrideItems[::pass][sel];
                if((s[x].genus == MESH) && (o_tempSettingsArray[2] == "type1" || o_tempSettingsArray[2] == "type2"  || o_tempSettingsArray[2] == "type3"  || o_tempSettingsArray[2] == "type4" || o_tempSettingsArray[2] == "type7"))
                {
                    tempMeshAgents[x] = Mesh(itemname);
                    tempMeshNames[x] = tempMeshAgents[x].name;
                    tempMeshIDs[x] = tempMeshAgents[x].id;
                    ::passOverrideItems[::pass][sel] = ::passOverrideItems[::pass][sel] + "||" + tempMeshIDs[x];
                }
                if ((s[x].genus == LIGHT) && (o_tempSettingsArray[2] == "type3" || o_tempSettingsArray[2] == "type5"))
                {
                    tempLightAgents[x] = Light(itemname);
                    tempLightNames[x] = tempLightAgents[x].name;
                    tempLightIDs[x] = tempLightAgents[x].id;
                    ::passOverrideItems[::pass][sel] = ::passOverrideItems[::pass][sel] + "||" + tempLightIDs[x];
                }
                if(o_tempSettingsArray[2] == "type6")
                {
                     // since working from Layout select, no ability to assign scene master.
                }
                if ((s[x].genus == CAMERA) && (o_tempSettingsArray[2] == "type3" || o_tempSettingsArray[2] == "type8"))
                {
					// Camera override - prototype code.
                    tempCameraAgents[x] = Camera(itemname);
                    tempCameraNames[x] = tempCameraAgents[x].name;
                    tempCameraIDs[x] = tempCameraAgents[x].id;
                    ::passOverrideItems[::pass][sel] = ::passOverrideItems[::pass][sel] + "||" + tempCameraIDs[x];
				}
            }
            // Apply highlight to items assigned to override
            setvalue(gad_SceneItems_forOverrides_Listview,o_parseListItems(::passOverrideItems[::pass][sel]));
            req_update();
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
    req_update();
}

o_clearSelButton
{   
    o_items_array = nil;
    ::pass = ::currentChosenPass;
    sel = getvalue(gad_OverridesListview).asInt();
    if(::overridesSelected == true && sel != 0)
    {
        s = ::masterScene.getSelect();
        if(s != nil)
        {
            arraySize = sizeof(s);
            // s = ::masterScene.getSelect();
            // arraySize = sizeof(s);
            newNumber = sel;
            for(x = 1; x <= arraySize; x++)
            {
                itemname = s[x].name;
                ::previousPassOverrideItems[::pass][sel] = ::passOverrideItems[::pass][sel];
                switch(s[x].genus)
                {
                    case MESH:
                        tempMeshAgents[x] = Mesh(itemname);
                        tempMeshNames[x] = tempMeshAgents[x].name;
                        removeMeIDs[x] = tempMeshAgents[x].id;
                        tempParse = parse("||",::passOverrideItems[::pass][sel]);
                        ::passOverrideItems[::pass][sel] = "";
                        for(y = 1; y <= size(tempParse); y++)
                        {
                            if(tempParse[y] != removeMeIDs[x])
                            {
                                ::passOverrideItems[::pass][sel] = ::passOverrideItems[::pass][sel] + "||" + tempParse[y];
                            }
                        }
                        break;
                    
                    case LIGHT:
                        tempLightAgents[x] = Light(itemname);
                        tempLightNames[x] = tempLightAgents[x].name;
                        removeMeIDs[x] = tempLightAgents[x].id;
                        tempParse = parse("||",::passOverrideItems[::pass][sel]);
                        ::passOverrideItems[::pass][sel] = "";
                        for(y = 1; y <= size(tempParse); y++)
                        {
                            if(tempParse[y] != removeMeIDs[x])
                            {
                                ::passOverrideItems[::pass][sel] = ::passOverrideItems[::pass][sel] + "||" + tempParse[y];
                            }
                        }
                        break;

                    case CAMERA:
                        tempCameraAgents[x] = Camera(itemname);
                        tempCameraNames[x] = tempCameraAgents[x].name;
                        removeMeIDs[x] = tempCameraAgents[x].id;
                        tempParse = parse("||",::passOverrideItems[::pass][sel]);
                        ::passOverrideItems[::pass][sel] = "";
                        for(y = 1; y <= size(tempParse); y++)
                        {
                            if(tempParse[y] != removeMeIDs[x])
                            {
                                ::passOverrideItems[::pass][sel] = ::passOverrideItems[::pass][sel] + "||" + tempParse[y];
                            }
                        }
                        break;
                        
                    default:
                        break;
                }
            }
            setvalue(gad_SceneItems_forOverrides_Listview,::passOverrideItems[::pass][sel]);
            req_update();
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
    req_update();
}

// Menus

overrideMenu_select: overrideMenu_item
{
    switch(overrideMenu_item)
    {
        case 1:
            createObjPropOverride();
            req_update();
            break;
        case 2:
            createAltObjOverride();
            req_update();
            break;
        case 3:
            createMotOverride();
            req_update();
            break;
        case 4:
            createSrfOverride();
            req_update();
            break;
        case 5:
            createLgtPropOverride();
            req_update();
            break;
        case 6:
            createSceneMasterOverride();
            req_update();
            break;
        case 7:
            createCameraOverride();
            req_update();
            break;
        case 9:
            createLightExclusionOverride();
            req_update();
            break;
        case 10:
            duplicateSelectedOverride();
            req_update();
            break;
            
        default:
            req_update();
            break;
    }
}

overrideMenu_active: overrideMenu_item
{
   return(overrideMenu_item);
}

// Other

parseOverrideSettings: overrideSettingsString
{
    ::settingsArray = parse("||",overrideSettingsString);
    return(::settingsArray);
}
