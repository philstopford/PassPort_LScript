undoOverrideSelect
{
	::pass = ::currentChosenPass;
	sel = getvalue(gad_OverridesListview).asInt();
	if(::overrideNames[1] != "empty")
	{
	    if(::overridesSelected == true && sel != 0)
	    {
			temp = ::passOverrideItems[::pass][sel];
			if(::previousPassOverrideItems != nil)
			{
				if(::previousPassOverrideItems[::pass][sel] != nil)
				{
					::passOverrideItems[::pass][sel] = ::previousPassOverrideItems[::pass][sel];
					::previousPassOverrideItems[::pass][sel] = temp;
					set_o_items = o_parseListItems(::passOverrideItems[::pass][sel]);
					setvalue(gad_SceneItems_forOverrides_Listview,set_o_items);
					setvalue(gad_PassesListview,nil);
					req_update();
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

duplicateSelectedOverride
{
	sel = getvalue(gad_OverridesListview).asInt();
    if(::overridesSelected == true && sel != 0)
    {
		::settingsArray = parseOverrideSettings(::overrideSettings[sel]);
		if(::settingsArray != nil && ::settingsArray != "")
		{
			newNumber = size(::overrideNames) + 1;
			tempOSettings = parse("||",::overrideSettings[sel]);
			newName = tempOSettings[1] + "_copy";
			::overrideSettings[newNumber] = newName;
			for(x = 2; x <= size(tempOSettings); x++)
			{
				::overrideSettings[newNumber] = ::overrideSettings[newNumber] + "||" + tempOSettings[x];
			}
		    ::passOverrideItems[::currentChosenPass][newNumber] = "";
		    for(y = 1; y <= size(::passNames); y++)
		    {
		    	::passOverrideItems[y][newNumber] = ::passOverrideItems[y][sel];
		    }
		    
		    //deal with the weird appendix thing that's type dependent, dammit.
		    overrideTempType = integer(strright(tempOSettings[2],1));
		    switch(overrideTempType)
		    {
		    	case 1:
		    		::overrideNames[newNumber] = newName + "   (.srf file)";
		    		break;
		    		
		    	case 2:
		    		::overrideNames[newNumber] = newName + "   (object properties)";
		    		break;
		    		
		    	case 3:
		    		::overrideNames[newNumber] = newName + "   (.mot file)";
		    		break;
		    		
		    	case 4:
		    		::overrideNames[newNumber] = newName + "   (.lwo file)";
		    		break;
		    		
		    	case 5:
		    		::overrideNames[newNumber] = newName + "   (light properties)";
		    		break;
		    		
		    	case 6:
		    		::overrideNames[newNumber] = newName + "   (scene properties)";
		    		break;

		    	case 7:
		    		::overrideNames[newNumber] = newName + "   (light exclusion)";
		    		break;
		    	
		    	case 8:
		    		::overrideNames[newNumber] = newName + "   (camera)";
		    		break;
		    		
		    	default:
		    		break;
		    }
		}
    }
}

editSelectedOverride
{
    sel = getvalue(gad_OverridesListview).asInt();
    if(::overridesSelected == true && sel != 0)
    {
		::settingsArray = parseOverrideSettings(::overrideSettings[sel]);
		if(::settingsArray != nil && ::settingsArray != "")
		{
			typeInteger = integer(strright(::settingsArray[2],1));
			switch(typeInteger)
			{
				case 1:
					srfOverride_UI("edit");
				    reProcess();
					req_update();
					break;
						
				case 5:
					lightOverride_UI("edit");
					reProcess();
					req_update();
					break;

				case 2:
					objpropsOverride_UI("edit");
					reProcess();
					req_update();
					break;
					
				case 3:
					motOverride_UI("edit");
					reProcess();
					req_update();
					break;
					
				case 4:
					lwoOverride_UI("edit");
					reProcess();
					req_update();
					break;
					
				case 7:
					lightexclOverride_UI("edit");
					reProcess();
					req_update();
					break;
					
				case 6:
					sel = getvalue(gad_OverridesListview).asInt();
		            ::settingsArray = parseOverrideSettings(::overrideSettings[sel]);
					renderer = ::settingsArray[3];
					scnmasterOverride_UI(renderer, "edit");
					reProcess();
					req_update();
					break;

				case 8:
					cameraOverride_UI("edit");
					reProcess();
					req_update();
					break;
					
				default:
					break;
			}
	    }
	    else
	    {
	    	logger("error","There has been a problem with the scene save of this override.  Please delete and recreate.");
	    }
    }
}

deleteSelectedOverride
{
    if(::overrideNames[1] != "empty")
    {
        if(::areYouSurePrompts == 1)
        {
            ::doKeys = 0;
            reqbegin("Confirm Delete Override");
            c20 = ctltext("","Are you sure you want to delete selected override?");
            if(reqpost())
            {
                sel = getvalue(gad_OverridesListview).asInt();
                if(::overridesSelected == true && sel != 0)
                {
                    topNumber = size(::overrideNames);
                    if(topNumber == 1 && ::overrideNames[1] != "empty")
                    {
                        ::overrideNames[1] = "empty";
                        ::passOverrideItems[::currentChosenPass][1] = "";
                        ::overrideSettings[1] = "";
                    }
                    else if(sel == topNumber)
                    {
                        ::overrideNames[sel] = nil;
                        ::passOverrideItems[::currentChosenPass][sel] = nil;
                        ::overrideSettings[sel] = nil;
                    }
                    else
                    {
                        for(x = 1; x < size(::overrideNames); x++)
                        {
                            if(x < sel)
                            {
                                ::overrideNames[x] = ::overrideNames[x];
                                ::passOverrideItems[::currentChosenPass][x] = ::passOverrideItems[::currentChosenPass][x];
                                ::overrideSettings[x] = ::overrideSettings[x];
                            }
                            else if(x >= sel)
                            {
                                xPlusOne = x + 1;
                                if(xPlusOne <= topNumber)
                                {
                                    ::overrideNames[x] = ::overrideNames[xPlusOne];
                                    ::passOverrideItems[::currentChosenPass][x] = ::passOverrideItems[::currentChosenPass][xPlusOne];
                                    ::overrideSettings[x] = ::overrideSettings[xPlusOne];
                                }
                            }
                        }
                        ::overrideNames[topNumber] = nil;
                        ::passOverrideItems[::currentChosenPass][topNumber] = nil;
                        ::overrideSettings[topNumber] = nil;
                    }
                }
                reProcess();
                doRefresh = 1;
            }
            else
            {
                logger("warn","Override deletion cancelled.");
                doRefresh = 0;
            }
            reqend();
            if(doRefresh == 1)
            {
                reProcess();
                req_update();
            }
            ::doKeys = 1;
        }
        else
        {
            sel = getvalue(gad_OverridesListview).asInt();
            if(::overridesSelected == true && sel != 0)
            {
                topNumber = size(::overrideNames);
                if(topNumber == 1 && ::overrideNames[1] != "empty")
                {
                    ::overrideNames[1] = "empty";
                    ::passOverrideItems[::currentChosenPass][1] = "";
                    ::overrideSettings[1] = "";
                }
                else if(sel == topNumber)
                {
                    ::overrideNames[sel] = nil;
                    ::passOverrideItems[::currentChosenPass][sel] = nil;
                    ::overrideSettings[sel] = nil;
                }
                else
                {
                    for(x = 1; x < size(::overrideNames); x++)
                    {
                        if(x < sel)
                        {
                            ::overrideNames[x] = ::overrideNames[x];
                            ::passOverrideItems[::currentChosenPass][x] = ::passOverrideItems[::currentChosenPass][x];
                            ::overrideSettings[x] = ::overrideSettings[x];
                        }
                        else if(x >= sel)
                        {
                            xPlusOne = x + 1;
                            if(xPlusOne <= topNumber)
                            {
                                ::overrideNames[x] = ::overrideNames[xPlusOne];
                                ::passOverrideItems[::currentChosenPass][x] = ::passOverrideItems[::currentChosenPass][xPlusOne];
                                ::overrideSettings[x] = ::overrideSettings[xPlusOne];
                            }
                        }
                    }
                    ::overrideNames[topNumber] = nil;
                    ::passOverrideItems[::currentChosenPass][topNumber] = nil;
                    ::overrideSettings[topNumber] = nil;
                }
            }
            reProcess();
            req_update();
        }
    }
    req_update();
}

lightExclusionAddLight
{
	lightInteger = getvalue(::light21);
	if(::tempLightTransferring == "")
	{
		::tempLightTransferring = ::lightListArray[lightInteger];
	}
	else
	{
		::tempLightTransferring = ::tempLightTransferring + ";" + ::lightListArray[lightInteger];
	}
	setvalue(::light23,::tempLightTransferring);
	req_update();
}

createLightExclusionOverride
{
	lightexclOverride_UI("new");
	reProcess();
	req_update();
}

createLgtPropOverride
{
	lightOverride_UI("new");
	reProcess();
	req_update();
}

createObjPropOverride
{
	objpropsOverride_UI("new");
	reProcess();
	req_update();
}

createSrfOverride
{
	srfOverride_UI("new");
	reProcess();
	req_update();
}

createMotOverride
{
	motOverride_UI("new");
	reProcess();
	req_update();
}

createAltObjOverride
{
	lwoOverride_UI("new");
	reProcess();
	req_update();
}

createCameraOverride
{
	cameraOverride_UI("new");
	reProcess();
	req_update();
}

createSceneMasterOverride
{
	if(::renderers.count() >= 2)
	{
		reqbeginstr = "Choose Renderer";
		reqbegin(reqbeginstr);
		smoWidth = 300;
		smoHeight = 60;
		reqsize(smoWidth, smoHeight);
		renderermenu = ctlpopup("Renderer",1,::renderers);
		ctlposition(renderermenu, 25, 5, (smoWidth - (2 * 25)), ::ScnMst_gad_h, ::ScnMst_gad_text_offset);
				
		if(reqpost())
		{
			scnmasterOverride_UI(int(getvalue(renderermenu)), "new");
		} else {
			// User cancelled out, so we do nothing.
		}
		reqend();
	} else {
		scnmasterOverride_UI(1, "new"); // native
	}
	reProcess();
	req_update();
}

checkForOverrideAssignments: currentID, pass
{
	// pass = ::currentChosenPass;
	if(::overrideNames[1] != "empty")
	{
		z = 1;
		for(x = 1; x <= size(::overrideNames); x++)
		{
			//set_o_items = parseListItems(::passOverrideItems[::pass][x]);

			overrideItemsString = ::passOverrideItems[::pass][x];

			idsArray = parse("||", overrideItemsString);
			for(y = 1; y <= size(idsArray); y++)
			{
				if(idsArray[y] == string(currentID))
				{
					assignedArray[z] = x;
					z++;
				}
			}
		}
	}
	return( assignedArray );
}

moveOverrideToBottom
{
	if(::overrideNames[1] != "empty")
	{
		if(::areYouSurePrompts == 1)
		{
			::doKeys = 0;
			reqbegin("Move Override to Bottom");
			c20 = ctltext("","Are you sure you want to move the selected override to the bottom?");
			if(reqpost())
			{
				sel = getvalue(gad_OverridesListview).asInt();
	    		if(::overridesSelected == true && sel != 0)
	    		{	    			
			    	topNumber = size(::overrideNames);
			    	if(topNumber == 1 && ::overrideNames[1] != "empty")
			    	{
			    		// I shouldn't do anything here!  Why would I move it to the bottom??
			    	}
			    	else
			    	{			    		
			    		if(sel == topNumber)
				    	{
				    		// I shouldn't do anything here!  It's already at the bottom!!
				    	}
				    	else
				    	{
				    		// get the stuff for making it the top one
				    		movedOverrideName = ::overrideNames[sel];
				    		movedOverrideSettings = ::overrideSettings[sel];
				    		for(passInt = 1; passInt <= size(::passNames); passInt++)
				    		{
								movedPassOverrideItems[passInt] = ::passOverrideItems[passInt][sel];
				    		}
				    		
				    		for(x = 1; x < size(::overrideNames); x++)
						    {	
						    	if(x < sel)
					    		{
					    			::overrideNames[x] = ::overrideNames[x];
					    			//::passOverrideItems[passInt][x] = ::passOverrideItems[passInt][x];
					    			::overrideSettings[x] = ::overrideSettings[x];
					    		}
					    		else 
					    		{
						    		if(x >= sel)
						    		{
						    			xPlusOne = x + 1;
						    			if(xPlusOne <= topNumber)
						    			{
						    				::overrideNames[x] = ::overrideNames[xPlusOne];
						    				//::passOverrideItems[passInt][x] = ::passOverrideItems[passInt][xPlusOne];
						    				::overrideSettings[x] = ::overrideSettings[xPlusOne];
						    			}
						    		}
					    		}
						    }
				    		
				    		for(passInt = 1; passInt <= size(::passNames); passInt++)
				    		{
						    	for(x = 1; x < size(::overrideNames); x++)
						    	{						    		
						    		if(x < sel)
						    		{
						    			//::overrideNames[x] = ::overrideNames[x];
						    			::passOverrideItems[passInt][x] = ::passOverrideItems[passInt][x];
						    			//::overrideSettings[x] = ::overrideSettings[x];
						    		}
						    		else 
						    		{
							    		if(x >= sel)
							    		{
							    			xPlusOne = x + 1;
							    			if(xPlusOne <= topNumber)
							    			{
							    				//::overrideNames[x] = ::overrideNames[xPlusOne];
							    				::passOverrideItems[passInt][x] = ::passOverrideItems[passInt][xPlusOne];
							    				//::overrideSettings[x] = ::overrideSettings[xPlusOne];
							    			}
							    		}
						    		}
						    	}
				    		}

						    for(passInt = 1; passInt <= size(::passNames); passInt++)
				    		{
						    	::passOverrideItems[passInt][topNumber] = movedPassOverrideItems[passInt];
				    		}
				    		::overrideNames[topNumber] = movedOverrideName;
				    		::overrideSettings[topNumber] = movedOverrideSettings;
				    	}
			    	}
			    }
			    reProcess();
			    doRefresh = 1;
			}
			else
			{
				logger("warn","Override move cancelled.");
				doRefresh = 0;
			}
			reqend();
			if(doRefresh == 1)
			{
				reProcess();
				req_update();
			}
			::doKeys = 1;
		}
		else
		{
			sel = getvalue(gad_OverridesListview).asInt();
    		if(::overridesSelected == true && sel != 0)
    		{	    			
		    	topNumber = size(::overrideNames);
		    	if(topNumber == 1 && ::overrideNames[1] != "empty")
		    	{
		    		// I shouldn't do anything here!  Why would I move it to the bottom??
		    	}
		    	else
		    	{			    		
		    		if(sel == topNumber)
			    	{
			    		// I shouldn't do anything here!  It's already at the bottom!!
			    	}
			    	else
			    	{
			    		// get the stuff for making it the top one
			    		movedOverrideName = ::overrideNames[sel];
			    		movedOverrideSettings = ::overrideSettings[sel];
			    		for(passInt = 1; passInt <= size(::passNames); passInt++)
			    		{
							movedPassOverrideItems[passInt] = ::passOverrideItems[passInt][sel];
			    		}
			    		
			    		for(x = 1; x < size(::overrideNames); x++)
					    {	
					    	if(x < sel)
				    		{
				    			::overrideNames[x] = ::overrideNames[x];
				    			//::passOverrideItems[passInt][x] = ::passOverrideItems[passInt][x];
				    			::overrideSettings[x] = ::overrideSettings[x];
				    		}
				    		else 
				    		{
					    		if(x >= sel)
					    		{
					    			xPlusOne = x + 1;
					    			if(xPlusOne <= topNumber)
					    			{
					    				::overrideNames[x] = ::overrideNames[xPlusOne];
					    				//::passOverrideItems[passInt][x] = ::passOverrideItems[passInt][xPlusOne];
					    				::overrideSettings[x] = ::overrideSettings[xPlusOne];
					    			}
					    		}
				    		}
					    }
			    		
			    		for(passInt = 1; passInt <= size(::passNames); passInt++)
			    		{
					    	for(x = 1; x < size(::overrideNames); x++)
					    	{						    		
					    		if(x < sel)
					    		{
					    			//::overrideNames[x] = ::overrideNames[x];
					    			::passOverrideItems[passInt][x] = ::passOverrideItems[passInt][x];
					    			//::overrideSettings[x] = ::overrideSettings[x];
					    		}
					    		else 
					    		{
						    		if(x >= sel)
						    		{
						    			xPlusOne = x + 1;
						    			if(xPlusOne <= topNumber)
						    			{
						    				//::overrideNames[x] = ::overrideNames[xPlusOne];
						    				::passOverrideItems[passInt][x] = ::passOverrideItems[passInt][xPlusOne];
						    				//::overrideSettings[x] = ::overrideSettings[xPlusOne];
						    			}
						    		}
					    		}
					    	}
			    		}
				    	
					    for(passInt = 1; passInt <= size(::passNames); passInt++)
			    		{
					    	::passOverrideItems[passInt][topNumber] = movedPassOverrideItems[passInt];
			    		}
			    		::overrideNames[topNumber] = movedOverrideName;
			    		::overrideSettings[topNumber] = movedOverrideSettings;
			    	}
		    	}
		    }
		    reProcess();
		    req_update();
		}
	}
}
