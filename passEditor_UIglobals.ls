var aboutsize_x = 400;
var aboutsize_y = 200;

// Main UI
Main_banner_height			= 64;
Main_button_height			= 19;
Main_spacer_height			= 3;
Main_ui_y_spacer			= 4;
Main_ui_gap					= 5;
Main_panelWidth 			= integer(globalrecall("passEditorpanelWidth", 640));
Main_panelHeight 			= integer(globalrecall("passEditorpanelHeight", 540));
// Main_panelWidthOnOpen 		= Main_panelWidth;
Main_res1_panelWidth 		= 640;
Main_res1_panelHeight 		= 540;
Main_res2_panelWidth 		= 640;
Main_res2_panelHeight 		= 385;
Main_res3_panelWidth 		= 457;
Main_res3_panelHeight 		= 540;
Main_res4_panelWidth 		= 457;
Main_res4_panelHeight 		= 385;

// Light Properties dialog UI
LgtProp_gad_x				= 6;													// Gadget X coord
LgtProp_gad_y				= 6;													// Gadget Y coord
LgtProp_gad_w				= 260;													// Gadget width
LgtProp_gad_h				= 19;													// Gadget height
LgtProp_gad_text_offset		= 80;													// Gadget text offset

LgtProp_num_gads			= 11;													// Total number of gadgets vertically (for calculating the max window height)
LgtProp_num_spacers			= 1;													// Total number of 'normal' spacers
LgtProp_num_text_spacers	= 0;													// Total number of spacers with text associated with them

LgtProp_ui_spacing_y		= 3;													// Spacing gap size Y
LgtProp_ui_spacing_x		= 3;													// Spacing gap size X

LgtProp_ui_offset_x 		= 0;													// Main X offset from 0
LgtProp_ui_offset_y 		= 6;													// Main Y offset from 0
LgtProp_ui_row				= 0;													// Row number
LgtProp_ui_column			= 0;													// Column number
LgtProp_ui_tab_offset		= LgtProp_ui_offset_y + 23;								// Offset for tab height
LgtProp_ui_row_offset		= LgtProp_gad_h + LgtProp_ui_spacing_y;					// Row offset

LgtProp_ui_window_w			= 275;													// Window width
LgtProp_ui_window_h			= (LgtProp_ui_row_offset*LgtProp_num_gads) + 11;		// Window height
LgtProp_ui_seperator_w		= LgtProp_ui_window_w + 2;								// Width of seperators

// Light Exclusion dialog UI
LgtExcl_gad_x				= 6;													// Gadget X coord
LgtExcl_gad_y				= 6;													// Gadget Y coord
LgtExcl_gad_w				= 280;													// Gadget width
LgtExcl_gad_h				= 19;													// Gadget height
LgtExcl_gad_text_offset		= 105;													// Gadget text offset

LgtExcl_num_gads			= 11;													// Total number of gadgets vertically (for calculating the max window height)
LgtExcl_num_spacers			= 1;													// Total number of 'normal' spacers
LgtExcl_num_text_spacers	= 0;													// Total number of spacers with text associated with them

LgtExcl_ui_spacing_y		= 3;													// Spacing gap size Y
LgtExcl_ui_spacing_x		= 3;													// Spacing gap size X

LgtExcl_ui_offset_x 		= 0;													// Main X offset from 0
LgtExcl_ui_offset_y 		= 6;													// Main Y offset from 0
LgtExcl_ui_row				= 0;													// Row number
LgtExcl_ui_column			= 0;													// Column number
LgtExcl_ui_tab_offset		= LgtExcl_ui_offset_y + 23;								// Offset for tab height
LgtExcl_ui_row_offset		= LgtExcl_gad_h + LgtExcl_ui_spacing_y;					// Row offset

LgtExcl_ui_window_w			= 295;													// Window width
LgtExcl_ui_window_h			= (LgtExcl_ui_row_offset*LgtExcl_num_gads) + 11;		// Window height
LgtExcl_ui_seperator_w		= LgtExcl_ui_window_w + 2;								// Width of seperators

// Object Properties dialog UI
ObjProp_gad_x				= 6;													// Gadget X coord
ObjProp_gad_y				= 6;													// Gadget Y coord
ObjProp_gad_w				= 260;													// Gadget width
ObjProp_gad_h				= 19;													// Gadget height
ObjProp_gad_text_offset		= 80;													// Gadget text offset

ObjProp_num_gads			= 11;													// Total number of gadgets vertically (for calculating the max window height)
ObjProp_num_spacers			= 1;													// Total number of 'normal' spacers
ObjProp_num_text_spacers	= 0;													// Total number of spacers with text associated with them

ObjProp_ui_spacing_y		= 3;													// Spacing gap size Y
ObjProp_ui_spacing_x		= 3;													// Spacing gap size X

ObjProp_ui_offset_x 		= 0;													// Main X offset from 0
ObjProp_ui_offset_y 		= 6;													// Main Y offset from 0
ObjProp_ui_row				= 0;													// Row number
ObjProp_ui_column			= 0;													// Column number
ObjProp_ui_tab_offset		= ObjProp_ui_offset_y + 23;								// Offset for tab height
ObjProp_ui_row_offset		= ObjProp_gad_h + ObjProp_ui_spacing_y;					// Row offset

ObjProp_ui_window_w			= 275;													// Window width
ObjProp_ui_window_h			= (ObjProp_ui_row_offset*ObjProp_num_gads) + 11;		// Window height
ObjProp_ui_seperator_w		= ObjProp_ui_window_w + 2;								// Width of seperators

// Camera dialog UI

CamProp_gad_x				= 6;													// Gadget X coord
CamProp_gad_y				= 6;													// Gadget Y coord
CamProp_gad_w				= 280;													// Gadget width
CamProp_gad_h				= 19;													// Gadget height
CamProp_gad_text_offset		= 105;													// Gadget text offset

CamProp_num_gads			= 11;													// Total number of gadgets vertically (for calculating the max window height)
CamProp_num_spacers			= 1;													// Total number of 'normal' spacers
CamProp_num_text_spacers	= 0;													// Total number of spacers with text associated with them

CamProp_ui_spacing_y		= 3;													// Spacing gap size Y
CamProp_ui_spacing_x		= 3;													// Spacing gap size X

CamProp_ui_offset_x 		= 0;													// Main X offset from 0
CamProp_ui_offset_y 		= 6;													// Main Y offset from 0
CamProp_ui_row				= 0;													// Row number
CamProp_ui_column			= 0;													// Column number
CamProp_ui_tab_offset		= CamProp_ui_offset_y + 23;								// Offset for tab height
CamProp_ui_row_offset		= CamProp_gad_h + CamProp_ui_spacing_y;					// Row offset

CamProp_ui_window_w			= 295 * 2;												// Window width
CamProp_ui_window_h			= (CamProp_ui_row_offset * CamProp_num_gads) + 11;		// Window height
CamProp_ui_seperator_w		= CamProp_ui_window_w + 2;								// Width of seperators

CamProp_gad_x2				= (CamProp_ui_window_w / 2) + CamProp_gad_x;			// Gadget X coord2

// Scene Master dialog UI

ScnMst_gad_x				= 6;													// Gadget X coord
ScnMst_gad_y				= 6;													// Gadget Y coord
ScnMst_gad_w				= 280;													// Gadget width
ScnMst_gad_h				= 19;													// Gadget height
ScnMst_gad_text_offset		= 105;													// Gadget text offset

ScnMst_num_gads				= 11;													// Total number of gadgets vertically (for calculating the max window height)
ScnMst_num_spacers			= 1;													// Total number of 'normal' spacers
ScnMst_num_text_spacers		= 0;													// Total number of spacers with text associated with them

ScnMst_ui_spacing_y			= 3;													// Spacing gap size Y
ScnMst_ui_spacing_x			= 3;													// Spacing gap size X

ScnMst_ui_offset_x 			= 0;													// Main X offset from 0
ScnMst_ui_offset_y 			= 6;													// Main Y offset from 0
ScnMst_ui_row				= 0;													// Row number
ScnMst_ui_column			= 0;													// Column number
ScnMst_ui_tab_offset		= ScnMst_ui_offset_y + 23;								// Offset for tab height
ScnMst_ui_row_offset		= ScnMst_gad_h + ScnMst_ui_spacing_y;					// Row offset

ScnMst_ui_window_w			= 295 * 3;												// Window width
ScnMst_ui_window_h			= (ScnMst_ui_row_offset*ScnMst_num_gads) + 11;			// Window height
ScnMst_gad_x2				= (ScnMst_ui_window_w / 3) + ScnMst_gad_x;				// Gadget X coord2
ScnMst_gad_x3				= (ScnMst_ui_window_w * 2 / 3) + ScnMst_gad_x;			// Gadget X coord3
ScnMst_ui_seperator_w		= ScnMst_gad_x3 + 2;			// Width of seperators (was ScnMst_ui_window_w + 2)

ScnMst_dividerline_y1		= 0;
ScnMst_dividerline_y2		= 0;

// rad Flags
radFlg_gad_x				= 6;													// Gadget X coord
radFlg_gad_y				= 6;													// Gadget Y coord
radFlg_gad_w				= 280;													// Gadget width
radFlg_gad_h				= 19;													// Gadget height
radFlg_gad_text_offset		= 105;													// Gadget text offset
radFlg_ui_spacing_y			= 3;													// Spacing gap size Y

radFlg_ui_row_offset		= radFlg_gad_h + radFlg_ui_spacing_y;					// Row offset

// Preferences UI

Pref_gad_x					= 6;													// Gadget X coord
Pref_gad_y					= 24;													// Gadget Y coord
Pref_gad_w					= 400;													// Gadget width
Pref_gad_h					= 19;													// Gadget height
Pref_gad_text_offset		= 150;													// Gadget text offset
Pref_gad_prev_w				= 0;													// Previous gadget width temp variable
Pref_num_gads				= 10;													// Total number of gadgets vertically (for calculating the max window height)

Pref_ui_banner_height		= 0;													// Height of banner graphic
Pref_ui_spacing				= 3;													// Spacing gap size
Pref_ui_offset_x 			= 0;													// Main X offset from 0
Pref_ui_offset_y 			= 3 * Pref_ui_spacing;									// Main Y offset from 0
Pref_ui_row					= 0;													// Row number
Pref_ui_column				= 0;													// Column number
Pref_ui_tab_offset			= Pref_ui_offset_y + 23;								// Offset for tab height
Pref_ui_row_offset			= Pref_gad_h + Pref_ui_spacing;							// Row offset
Pref_ui_window_w			= 436;													// Window width
Pref_ui_window_h			= Pref_ui_offset_y + (Pref_gad_h*Pref_num_gads)
							+ (Pref_ui_spacing*(Pref_num_gads+1)) + 24;				// Window height
Pref_ui_seperator_w			= Pref_ui_window_w + 2;									// Width of seperators

// Passes UI

Passes_gad_x				= 6;													// Gadget X coord
Passes_gad_y				= 24;													// Gadget Y coord
Passes_gad_w				= 400;													// Gadget width
Passes_gad_h				= 19;													// Gadget height
Passes_gad_text_offset		= 150;													// Gadget text offset

Passes_ui_spacing			= 3;													// Spacing gap size
Passes_ui_offset_x 			= 0;													// Main X offset from 0
Passes_ui_offset_y 			= 3 * Passes_ui_spacing;								// Main Y offset from 0
Passes_ui_row				= 0;													// Row number
Passes_ui_column			= 0;													// Column number
Passes_ui_row_offset		= Passes_gad_h + Passes_ui_spacing;						// Row offset
Passes_ui_window_w			= 436;													// Window width
Passes_ui_seperator_w		= Passes_ui_window_w + 2;								// Width of seperators

