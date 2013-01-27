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
	info("itemslb_event: items");
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
				tempNumber = items[x];
				passAssItems[sel] = passAssItems[sel] + "||" + displayIDs[tempNumber];
			}
		}
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
	info("o_itemslb_event: o_items");
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
					}
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
	info("passeslb_event: passes_items");
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
		} 
	}
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
	info("overrideslb_event: overrides_items");
	pass = currentChosenPass;
	overrides_array = nil;
	if(overrides_items != nil)
	{
		overrides_size = sizeof(overrides_items);
		for(x = 1;x <= overrides_size;x++)
		{
			overrides_array[x] = overrides_items[x];
			overrides_sel = overrides_items[x];
		}
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
		}
	}
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
		for(x = 1;x <= items_size;x++)
		{
			items_array[x] = x;
			tempNumber = x;
			passAssItems[sel] = passAssItems[sel] + "||" + displayIDs[tempNumber];
		}
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
		for(x = 2;x <= o_items_size;x++)
		{
			o_items_array[x] = x;
			tempNumber = x;
			passOverrideItems[pass][sel] = passOverrideItems[pass][sel] + "||" + displayIDs[tempNumber - 1];
		}
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
				if(reqisopen())
				{
					reqend();
				}
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
						if(reqisopen())
						{
							reqend();
						}
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
					if(reqisopen())
					{
						reqend();
					}
					
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
