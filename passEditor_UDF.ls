parseOverrideSettings: overrideSettingsString
{
    settingsArray = parse("||",overrideSettingsString);
    return(settingsArray);
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
}

o_addAllButton
{
    o_items_array = nil;
    pass = currentChosenPass;
    sel = getvalue(gad_OverridesListview).asInt();
    o_tempSettingsArray = parse("||",overrideSettings[sel]);
	
    if(overridesSelected == true && sel != 0)
    {
        previousPassOverrideItems[pass][sel] = passOverrideItems[pass][sel];
        passOverrideItems[pass][sel] = ""; // erase since we're going to add the universe.

        if(o_tempSettingsArray[2] == "type6") // scene master - only one item, so no problem.
		{
	        passOverrideItems[pass][sel] = passOverrideItems[pass][sel] + "||" + "(Scene Master)";
		} else { // we don't need to care about override type - the list is already filtered against the selected override type.
			o_items_size = sizeof(o_displayNamesFiltered);
			o_items_array[1] = 1;
			for(x = 1;x <= o_items_size;x++)
			{
				o_items_array[x] = x;
				passOverrideItems[pass][sel] = passOverrideItems[pass][sel] + "||" + o_displayIDsFiltered[x];
			}
		}
        // set highlighting for matching items.
        setvalue(gad_SceneItems_forOverrides_Listview,o_parseListItems(passOverrideItems[pass][sel]));
        req_update();
    }
    else
    {
        setvalue(gad_SceneItems_forOverrides_Listview,nil);
        req_update();
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
                setvalue(gad_SceneItems_forOverrides_Listview,nil);
                req_update();
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
            setvalue(gad_SceneItems_forOverrides_Listview,nil);
            req_update();
        }
    }
    
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
                        
                    case CAMERA: // was 2 - trying to avoid hard-coding.
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
}

o_addSelButton
{   
    o_items_array = nil;
    pass = currentChosenPass;
    sel = getvalue(gad_OverridesListview).asInt();
    o_tempSettingsArray = parse("||",overrideSettings[sel]);
    if(overridesSelected == true && sel != 0)
    {
        s = masterScene.getSelect(); // picks up selected items in Layout, matching documentation.
        if(s != nil)
        {
            arraySize = sizeof(s);
            for(x = 1; x <= arraySize; x++)
            {
                itemname = s[x].name;
                previousPassOverrideItems[pass][sel] = passOverrideItems[pass][sel];
                if((s[x].genus == MESH) && (o_tempSettingsArray[2] == "type1" || o_tempSettingsArray[2] == "type2"  || o_tempSettingsArray[2] == "type3"  || o_tempSettingsArray[2] == "type4" || o_tempSettingsArray[2] == "type7"))
                {
                    tempMeshAgents[x] = Mesh(itemname);
                    tempMeshNames[x] = tempMeshAgents[x].name;
                    tempMeshIDs[x] = tempMeshAgents[x].id;
                    passOverrideItems[pass][sel] = passOverrideItems[pass][sel] + "||" + tempMeshIDs[x];
                }
                if ((s[x].genus == LIGHT) && (o_tempSettingsArray[2] == "type3" || o_tempSettingsArray[2] == "type5"))
                {
                    tempLightAgents[x] = Light(itemname);
                    tempLightNames[x] = tempLightAgents[x].name;
                    tempLightIDs[x] = tempLightAgents[x].id;
                    passOverrideItems[pass][sel] = passOverrideItems[pass][sel] + "||" + tempLightIDs[x];
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
                    passOverrideItems[pass][sel] = passOverrideItems[pass][sel] + "||" + tempCameraIDs[x];
				}
            }
            // Apply highlight to items assigned to override
            setvalue(gad_SceneItems_forOverrides_Listview,o_parseListItems(passOverrideItems[pass][sel]));
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
}

o_clearSelButton
{   
    o_items_array = nil;
    pass = currentChosenPass;
    sel = getvalue(gad_OverridesListview).asInt();
    if(overridesSelected == true && sel != 0)
    {
        s = masterScene.getSelect();
        if(s != nil)
        {
            arraySize = sizeof(s);
            s = masterScene.getSelect();
            arraySize = sizeof(s);
            newNumber = sel;
            for(x = 1; x <= arraySize; x++)
            {
                itemname = s[x].name;
                previousPassOverrideItems[pass][sel] = passOverrideItems[pass][sel];
                switch(s[x].genus)
                {
                    case MESH:
                        tempMeshAgents[x] = Mesh(itemname);
                        tempMeshNames[x] = tempMeshAgents[x].name;
                        removeMeIDs[x] = tempMeshAgents[x].id;
                        tempParse = parse("||",passOverrideItems[pass][sel]);
                        passOverrideItems[pass][sel] = "";
                        for(y = 1; y <= size(tempParse); y++)
                        {
                            if(tempParse[y] != removeMeIDs[x])
                            {
                                passOverrideItems[pass][sel] = passOverrideItems[pass][sel] + "||" + tempParse[y];
                            }
                        }
                        break;
                    
                    case LIGHT:
                        tempLightAgents[x] = Light(itemname);
                        tempLightNames[x] = tempLightAgents[x].name;
                        removeMeIDs[x] = tempLightAgents[x].id;
                        tempParse = parse("||",passOverrideItems[pass][sel]);
                        passOverrideItems[pass][sel] = "";
                        for(y = 1; y <= size(tempParse); y++)
                        {
                            if(tempParse[y] != removeMeIDs[x])
                            {
                                passOverrideItems[pass][sel] = passOverrideItems[pass][sel] + "||" + tempParse[y];
                            }
                        }
                        break;

                    case CAMERA:
                        tempCameraAgents[x] = Camera(itemname);
                        tempCameraNames[x] = tempCameraAgents[x].name;
                        removeMeIDs[x] = tempCameraAgents[x].id;
                        tempParse = parse("||",passOverrideItems[pass][sel]);
                        passOverrideItems[pass][sel] = "";
                        for(y = 1; y <= size(tempParse); y++)
                        {
                            if(tempParse[y] != removeMeIDs[x])
                            {
                                passOverrideItems[pass][sel] = passOverrideItems[pass][sel] + "||" + tempParse[y];
                            }
                        }
                        break;
                        
                    default:
                        break;
                }
            }
            setvalue(gad_SceneItems_forOverrides_Listview,passOverrideItems[pass][sel]);
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
        }
        //reProcess();
        req_update();
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
                }
                //reProcess();
                req_update();
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
                //reProcess();
                req_update();
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
                req_update();
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
            req_update();
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
        req_update();
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
        createNewPassFromLayoutSelection();
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
    

// keyboard function
reqkeyboard: key
{
    // win hotkeys
    if(platformVar == WIN32 || platformVar == WIN64)
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
                req_update();
            }
            else if(overrideSel > 0)
            {
                duplicateSelectedOverride();
                req_update();
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
            req_update();
        }
        //win:
        //enter is 13
        //delete is 4128
        //ctrl + a is 1
        //ctrl + r is 18
        //o is 111
        
        
        if(key == REQKB_PAGEDOWN && doKeys == 1)
        {
            moveOverrideToBottom();
        }           
    }
    
    // mac UB hotkeys
    if(platformVar == MACUB || platformVar == MAC64)
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
                req_update();
            }
            else if(overrideSel > 0)
            {
                duplicateSelectedOverride();
                req_update();
            }
            doKeys = 1;
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
            req_update();
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

@if dev == 1
debugMe: val
{
    debug = val;
    globalstore("passEditorDebugMode", debug);
}
@end

