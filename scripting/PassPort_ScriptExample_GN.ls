// Here are example for each of PassPort's lscript functions.
// Uncomment specific areas of the script to test them.

// Also, in beginning portion of the script, you'll need to change
//  the path to PassPort_ComRing_Functions.lsc to it's location
//  on your disk.  Any scripts that use the functions in this
//  example will need this portion at the beginning of the
//  script until compiled.  Compiled Lscripts should not need
//  the functions file any more after compiling.

// Finally, notice that at the bottom of this script there is an empty
//  function called "ppReturnData" that accepts two arguments.  Any
//  scripts that attempt to communicate with PassPort will need this
//  empty function.

@if platform == MACUB
library "/Users/jezza/Documents/Projects/Lscript/passEditor/0040/PassPort_Scripting/PassPort_ComRing_Functions.lsc";
@end

@if platform == INTEL
library "G:\\PassPort_Scripting\\PassPort_ComRing_Functions.lsc";
@end

generic
{
	// connect to PassPort
	ppConnect();
	
	//info("Have you uncommented the functions to test?");



	// an example of loading pass editor settings
		/*
		reqbegin("Load PassPort Settings...");
		c21 = ctlfilename("Load .rpe file...", "*.rpe",30,1);
		c22 = ctlcheckbox("Replace existing settings?",0);
		if(reqpost())
		{
			rpeFile = getvalue(c21);
			replaceChoice = getvalue(c22);
		}
		reqend();
		
		ppLoadSettings(rpeFile,replaceChoice);
		
		ppRefresh();
		*/



	// an example of refreshing the interface
		/*
		ppRefresh();
		*/
	
	
	
	// an example of saving current settings
		/*
		reqbegin("Save PassPort Settings...");
		c21 = ctlfilename("Save .rpe file...", "*.rpe",30,0);
		if(reqpost())
		{
			rpeFile = getvalue(c21);
		}
		reqend();
		
		ppSaveCurrentSettings(rpeFile);
		*/
	
	
	// an example of saving the current pass as an external scene file
		/*
		reqbegin("Save Pass As Scene...");
		c21 = ctlfilename("Save .lws file...", "*.lws",30,0);
		if(reqpost())
		{
			lwsFile = getvalue(c21);
		}
		reqend();
		
		ppSavePassAsScene(lwsFile);
		*/
		
		
	// an example of adding an item to a pass
		/*
		firstMesh = Mesh();
		firstMeshID = firstMesh.id;
		passName = "Default";
		
		ppP_AddItem(passName,firstMeshID);
		
		ppRefresh();
		*/
		
	// an example of removing an item from a pass
		/*
		firstMesh = Mesh();
		firstMeshID = firstMesh.id;
		passName = "Default";
		
		ppP_ClearItem(passName,firstMeshID);
		
		ppRefresh();
		*/
		
	// an example of adding an item to an override in a pass
		/*
		firstMesh = Mesh();
		firstMeshID = firstMesh.id;
		passName = "Default";
		overrideName = "ObjProps";
		
		ppO_AddItem(passName,overrideName,firstMeshID);
	
		ppRefresh();
		*/
		
	
	// an example of removing an item from an override in a pass
		/*
		firstMesh = Mesh();
		firstMeshID = firstMesh.id;
		passName = "Default";
		overrideName = "ObjProps";
		
		ppO_ClearItem(passName,overrideName,firstMeshID);
		
		ppRefresh();
		*/
		
	// an example of duplicating an override
		/*
		overrideName = "ObjProps";
		
		ppO_DuplicateOverride(overrideName);
		
		ppRefresh();
		*/
		
		
	// an example of making a new pass
		/*
		passName = "NewScriptedPass";
		
		ppCreatePass(passName);
		
		ppRefresh();
		*/
		
	
		
		
	// an example of selecting a pass in PassPort
		/*
		passName = "NewScriptedPass";
		
		ppSelectPass(passName);
		*/
		
	// an example of editing the selected pass in PassPort
		/*
		passName = "EditedScriptedPass";
		
		ppEditPass(passName);
		
		ppRefresh();
		*/
		
	// an example of duplicating a pass
		
		ppDuplicatePass();
	
		ppRefresh();
		
		
	// an example of deleting the selected pass in PassPort
		/*		
		ppDeletePass();
		
		ppRefresh();
		*/
		
	// an example of switching the current pass
		/*
		passName = "Default";
		
		ppChangeCurrentPass(passName);
		*/
		
	// an example of rendering the current frame in the current pass
		/*
		ppRenderPassFrame();
		*/
		
	// an example of rendering the current pass
		/*
		ppRenderPassScene();
		*/
		
	// an example of rendering all passes
		/*
		ppRenderAllPasses();
		*/
		
		
		

		
	
	// disconnect from PassPort
	ppDisconnect();
		
}

ppReturnData: eventcode,data
{
	// include this empty function in the bottom of every script that uses PassPort
	
}

