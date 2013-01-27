// Passes

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
