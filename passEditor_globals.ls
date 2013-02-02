// globals
@if dev == 1
var debugButtonXposition;
var debugButtonWidth;
var debugmode = integer(globalrecall("passEditorDebugMode", 0)); // default to off if not found.
@else
var debugmode = 0;
@end
var versionString = "1.0";
var rpeVersion = "1.0";
var parch = "Unknown";
var icon;
var scenesnames;
var passSelected = false;
var currentPassMenu_item;
var overridesSelected = false;
var passAssItems;
@if enablePBS == 1
var defaultBufferExporters = @0,0,0,0,0,0,0,0,0@; // user setting to make changes, compositing buffer, exrTrader, special buffers, PSD export, extended RLA, extended RPF, Aura 2.5, iDof
var passBufferExporters;
@end // PBS
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
var cameraAgents;
var cameraNames;
var cameraIDs;
var cameraOldIDs;
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
var overrideMenu_items = @"Object Properties","Alternative Object...","Motion File...","Surface File...","Light Properties","Scene Master","Camera Override","==","Light Exclusions","Duplicate Selected Override"@;
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
var userOutputString;
var areYouSurePrompts;
var doKeys;
var rgbSaveType;
var editorResolution;
var testResMultiplier;
var testRgbSaveType;
var sceneJustLoaded = 0;
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
var saveRGBImagesPrefix;
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
var pass;
var passItem;
var noOfStages;
var lastObject = 0;
var lastLight = 0;
var lastCamera = 0;
var noAppend = 0;

// motion mixer
var overriddenObjectID;
var overriddenObjectName;

// file variables.
var newScenePath;
var currentScenePath;
var newScenePath;
var inputFileName;
var filesPrepared = 0;
var tempDirectory = getdir("Temp");

// Mac stuff
var useGrowl = 0; // shut off Growl by default.
var usegrowl;

// Renderer support extension - prototype!
@if enableKray
var renderers = @"Native","Kray 2.5"@;
@else
var renderers = @"Native"@;
@end
var overrideRenderer = 1; // default, native.

var lastObject;
var lastLight;
var lastCamera;
var objStart;
var objEnd;
var objMotStart;
var objMotEnd;
var doOverride;

// Global override variables settings.
var settingsArray;
var overrideType;
var motInputTemp;
var lwoInputTemp;
var srfLWOInputID;
var srfInputTemp;
var objPropOverrideSets;
var objPropOverrideShadowOpts;
var lightSettingsPartOne;
var lightSettingsPartTwo;
var lightSettingsPartThree;
var cameraSettingsPartOne;
var cameraSettingsPartOneCount;
var cameraSettingsPartTwo;
var cameraSettingsPartTwoCount;
var cameraSettingsPartThree;
var cameraSettingsPartThreeCount;
var cameraSettingsPartFour;
var cameraSettingsPartFourCount;
var LWrecursionLimit = 64;
var giTypeArray = @"Backdrop Only","Monte Carlo","Final Gather"@;
var cameraMotBlur = @"Off","Classic","Dither","Photoreal"@;
var resolutionMultArray = @"25 %","50 %","100 %","200 %","400 %"@;
var renderModeArray = @"Wireframe","Quickshade","Realistic"@;
var samplerArray = @"Low-discrepancy","Fixed","Classic"@;
var reconFilterArray = @"Classic","Box","Box (Soft)","Box (Sharp)","Gaussian","Gaussian (Soft)","Gaussian (Sharp)","Mitchell","Mitchell (Soft)","Mitchell (Sharp)","Lanczos","Lanczos (Soft)","Lanczos (Sharp)"@;
var fieldRenderArray = @"Off","Even/Upper First","Odd/Lower First"@;
var fogTypeArray = @"Off","Linear","Nonlinear 1","Nonlinear 2","Realistic"@;
var radFlags_Default = @0,0,0,0,0,0,0,0@;
var radFlags_Array;
