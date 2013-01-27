// globals
@if dev == 1
var debugButtonXposition;
var debugButtonWidth;
var debugmode = integer(globalrecall("passEditorDebugMode", 0)); // default to off if not found.
@else
var debugmode = 0;
@end
var versionString = "20130102";
var parch = "Unknown";
var icon;
var scenesnames;
var passSelected = false;
var overridesSelected = false;
var passAssItems;
var previousPassAssItems;
var passOverrideItems;
var previousPassOverrideItems;
var overrideSettings;
var masterScene;
var image_formats_array;
var originalSelection;
var meshAgents;
var meshNames;
var meshIDs;
var meshOldIDs;
var lightAgents;
var lightNames;
var lightIDs;
var lightOldIDs;
var displayNames;
var displayGenus;
var o_displayNames; // holds all items for the override item listbox
var o_displayNamesFiltered; // populates the listbox with compatible items for selected override type.
var o_displayGenus; // used to filter the displayNames by type for compatibility.
var displayIDs;
var o_displayIDs; // exporting ID array for override items
var o_displayIDsFiltered; // container for IDs for filtered items.
var displayOldIDs;
var passNames;
var overrideNames;
var fileMenu_items;
var passMenu_items = @"Full Scene Pass","Empty Pass","Pass From Layout Selection","Duplicate Selected Pass"@;
var overrideMenu_items = @"Object Properties","Alternative Object...","Motion File...","Surface File...","Light Properties","Scene Master","==","Light Exclusions","Duplicate Selected Override"@;
var gad_PassesListview;
var gad_OverridesListview;
var gad_SceneItems_forPasses_Listview;
var gad_SceneItems_forOverrides_Listview;
var gad_SelectedPass;
// var c7; // unused.
var currentChosenPass;
var currentChosenPassString;
var interfaceRunYet;
var userOutputFolder;
var fileOutputPrefix;
var	userOutputString;
var areYouSurePrompts;
var doKeys;
var platformVar;
var rgbSaveType;
var editorResolution;
var testResMultiplier;
var testRgbSaveType;
var sceneJustLoaded = 0;
var testOutputPath;
var seqOutputPath;
var unsaved;
var listOneWidth;
var panelWidth;
var panelWidthOnOpen;
var listTwoWidth;
var listTwoPosition;
var panelWidth;
var panelHeight;
var listOneHeight;
// exclusion attempt;
var tempLightTransferring;
var light21;
var light23;
var lightListArray;

var newPassButtonString;
var newPassButtonXposition;
var newPassButtonWidth;
var newOverrideButtonString;
var newOverrideButtonXposition;
var newOverrideButtonWidth;
var editSelectedButtonString;
var editSelectedButtonWidth;
var editSelectedButtonXposition;
var deleteSelectedButtonString;
var deleteSelectedButtonWidth;
var deleteSelectedButtonXposition;
var addAllButtonString;
var addAllButtonWidth;
var addAllButtonXposition;
var addSelButtonString;
var addSelButtonWidth;
var addSelButtonXposition;
var clearAllButtonString;
var clearAllButtonWidth;
var clearAllButtonXposition;
var clearSelButtonString;
var clearSelButtonWidth;
var clearSelButtonXposition;
var listTwoPosition;
var listOneWidth;
var listTwoWidth;
var bottomPosition;
var loadingInProgress;
var justReopened;
var beingEscaped;

// motion mixer
var overriddenObjectID;
var overriddenObjectName;

// file variables.
var newScenePath;
var inputFileName;
var filesPrepared = 0;

// Mac stuff
var useGrowl = 0; // shut off Growl by default.
var usegrowl;
