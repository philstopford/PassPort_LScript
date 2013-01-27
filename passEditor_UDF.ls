// button functions

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

// keyboard function
reqkeyboard: key
{
    // win hotkeys
    if(platform() == WIN32 || platform() == WIN64)
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
    if(platform() == MACUB || platform() == MAC64)
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

