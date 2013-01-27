// Listbox
itemslb_count
{
	return displayNames.size();
}

itemslb_name: index
{
	return displayNames[index];
}

itemslb_event: items
{
	items_array = nil;
	sel = getvalue(gad_PassesListview).asInt();
	if(passSelected == true && sel != 0)
	{
		previousPassAssItems[sel] = passAssItems[sel];
		passAssItems[sel] = "";
		if(items != nil)
		{
			items_size = sizeof(items);
			for(x = 1;x <= items_size;x++)
			{
				items_array[x] = items[x];
				passAssItems[sel] = passAssItems[sel] + "||" + displayIDs[items[x]];
			}
		}
		else
		{
			setvalue(gad_SceneItems_forPasses_Listview,nil);
			req_update();
		}
	}
	else
	{
		setvalue(gad_SceneItems_forPasses_Listview,nil);
		req_update();
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
	if(passes_items != nil)
	{
		passes_size = sizeof(passes_items);
		for(x = 1;x <= passes_size;x++)
		{
			passes_array[x] = passes_items[x];
			passes_sel = passes_items[x];
		}
		if(passes_size != 1)
		{
			passSelected = false;
			setvalue(gad_OverridesListview,nil);
			setvalue(gad_SceneItems_forPasses_Listview,nil);
			req_update();
		}
		if(passes_size > 1)
		{
			setvalue(gad_PassesListview,nil);
			setvalue(gad_OverridesListview,nil);
			setvalue(gad_SceneItems_forPasses_Listview,nil);
			req_update();
		}
		if(passes_size == 1)
		{
			passes_sel = passes_array[1];
			setitems = parseListItems(passAssItems[passes_sel]);
			setvalue(gad_SceneItems_forPasses_Listview,setitems);
			setvalue(gad_OverridesListview,nil);
			req_update();
			passSelected = true;
		} 
	}
	else
	{
		passSelected = false;
		setvalue(gad_PassesListview,nil);
		setvalue(gad_OverridesListview,nil);
		setvalue(gad_SceneItems_forPasses_Listview,nil);
		req_update();
	}
}

// Buttons

addAllButton
{
    items_array = nil;
    sel = getvalue(gad_PassesListview).asInt();
    if(passSelected == true && sel != 0)
    {
        previousPassAssItems[sel] = passAssItems[sel];
        passAssItems[sel] = "";
        items_size = sizeof(displayNames);
        for(x = 1;x <= items_size;x++)
        {
            items_array[x] = x;
            passAssItems[sel] = passAssItems[sel] + "||" + displayIDs[x];
        }
        setitems = parseListItems(passAssItems[sel]);
        setvalue(gad_SceneItems_forPasses_Listview,setitems);
        req_update();
    }
    else
    {
        setvalue(gad_SceneItems_forPasses_Listview,nil);
        req_update();
    }
    req_update();
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
                setvalue(gad_SceneItems_forPasses_Listview,nil);
                req_update();
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
            setvalue(gad_SceneItems_forPasses_Listview,nil);
            req_update();
        }
    }
    req_update();
}

addSelButton
{
    items_array = nil;
    sel = getvalue(gad_PassesListview).asInt();
    if(passSelected == true && sel != 0)
    {
        s = masterScene.getSelect();
        if(s != nil)
        {
            arraySize = sizeof(s);
            
            newNumber = sel;
            for(x = 1; x <= arraySize; x++)
            {
                itemname = s[x].name;
                previousPassAssItems[newNumber] = passAssItems[newNumber];
                switch(s[x].genus)
                {
                    case MESH: // was 1 - trying to avoid hard-coding.
                        tempMeshAgents[x] = Mesh(itemname);
                        tempMeshNames[x] = tempMeshAgents[x].name;
                        tempMeshIDs[x] = tempMeshAgents[x].id;
                        passAssItems[newNumber] = passAssItems[newNumber] + "||" + tempMeshIDs[x];
                        break;
                    
                    case LIGHT: // was 2 - trying to avoid hard-coding.
                        tempLightAgents[x] = Light(itemname);
                        tempLightNames[x] = tempLightAgents[x].name;
                        tempLightIDs[x] = tempLightAgents[x].id;
                        passAssItems[newNumber] = passAssItems[newNumber] + "||" + tempLightIDs[x];
                        break;
                        
                    case CAMERA: // was 3 - trying to avoid hard-coding.
                        tempCameraAgents[x] = Camera(itemname);
                        tempCameraNames[x] = tempCameraAgents[x].name;
                        tempCameraIDs[x] = tempCameraAgents[x].id;
                        passAssItems[newNumber] = passAssItems[newNumber] + "||" + tempCameraIDs[x];
                        break;

					default:
                        break;
                }
            }
            setitems = parseListItems(passAssItems[newNumber]);
            setvalue(gad_SceneItems_forPasses_Listview,setitems);
        }
        else
        {
            setvalue(gad_SceneItems_forPasses_Listview,nil);
            req_update();
        }
    }
    else
    {
        setvalue(gad_SceneItems_forPasses_Listview,nil);
        req_update();
    }
    req_update();
}

clearSelButton
{
    items_array = nil;
    sel = getvalue(gad_PassesListview).asInt();
    if(passSelected == true && sel != 0)
    {
        s = masterScene.getSelect();
        if(s != nil)
        {
            arraySize = sizeof(s);
            newNumber = sel;
            for(x = 1; x <= arraySize; x++)
            {
                itemname = s[x].name;
                previousPassAssItems[newNumber] = passAssItems[newNumber];
                switch(s[x].genus)
                {
                    case MESH:
                        tempMeshAgents[x] = Mesh(itemname);
                        tempMeshNames[x] = tempMeshAgents[x].name;
                        removeMeIDs[x] = tempMeshAgents[x].id;
                        tempParse = parse("||",passAssItems[newNumber]);
                        passAssItems[newNumber] = "";
                        for(y = 1; y <= size(tempParse); y++)
                        {
                            if(tempParse[y] != removeMeIDs[x])
                            {
                                passAssItems[newNumber] = passAssItems[newNumber] + "||" + tempParse[y];
                            }
                        }
                        break;
                    
                    case LIGHT:
                        tempLightAgents[x] = Light(itemname);
                        tempLightNames[x] = tempLightAgents[x].name;
                        removeMeIDs[x] = tempLightAgents[x].id;
                        tempParse = parse("||",passAssItems[newNumber]);
                        passAssItems[newNumber] = "";
                        for(y = 1; y <= size(tempParse); y++)
                        {
                            if(tempParse[y] != removeMeIDs[x])
                            {
                                passAssItems[newNumber] = passAssItems[newNumber] + "||" + tempParse[y];
                            }
                        }
                        break;

                    case CAMERA:
                        tempCameraAgents[x] = Camera(itemname);
                        tempCameraNames[x] = tempCameraAgents[x].name;
                        removeMeIDs[x] = tempCameraAgents[x].id;
                        tempParse = parse("||",passAssItems[newNumber]);
                        passAssItems[newNumber] = "";
                        for(y = 1; y <= size(tempParse); y++)
                        {
                            if(tempParse[y] != removeMeIDs[x])
                            {
                                passAssItems[newNumber] = passAssItems[newNumber] + "||" + tempParse[y];
                            }
                        }
                        break;
                        
                    default:
                        break;
                }
            }
            setitems = parseListItems(passAssItems[newNumber]);
            setvalue(gad_SceneItems_forPasses_Listview,setitems);
        }
        else
        {
            setvalue(gad_SceneItems_forPasses_Listview,nil);
            req_update();
        }
    }
    else
    {
        setvalue(gad_SceneItems_forPasses_Listview,nil);
        req_update();
    }
    req_update();
}

// Menus

passMenu_select: passMenu_item
{
   if(passMenu_item == 1)
    {
        reProcess();
        createNewFullPass();
        req_update();
    }
   
   if(passMenu_item == 2)
    {
        justReopened = 1;
        createNewEmptyPass();
        req_update();
    }
    if(passMenu_item == 3)
    {
        reProcess();
        createNewPassFromSelection();
        req_update();
    }
    if(passMenu_item == 4)
    {
        duplicateSelectedPass();
        req_update();
    }
    
}

currentPassMenu_refresh: value
{
    currentChosenPass = int(value);
    currentChosenPassString = passNames[currentChosenPass];
    setvalue(gad_OverridesListview,nil);
    setvalue(gad_SceneItems_forOverrides_Listview,nil);
    reProcess();
    req_update();
}

currentPassMenu_select: currentPassMenu_item
{
    currentChosenPass = int(currentPassMenu_item);
    currentChosenPassString = passNames[currentChosenPass];
    setvalue(gad_OverridesListview,nil);
    setvalue(gad_SceneItems_forOverrides_Listview,nil);
    setvalue(gad_SelectedPass,currentChosenPass);
    reProcess();
    req_update();
}

currentPassMenu_update
{
    return(passNames);
}


passMenu_active: passMenu_item
{
   return(passMenu_item);
}

// Other

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


