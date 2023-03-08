-- ***********************
--   V/STOL REST Display
--   BASIC PAGE
-- ***********************

local mpcd_path = LockOn_Options.script_path.."MPCD/indicator/VRST/"

dofile(LockOn_Options.script_path.."MPCD/indicator/MPCD_definitions.lua")

-- MENU
dofile(mpcd_path.."VRST_MENU.lua")

-- DATA
local	BAW_Label				= CreateElement "ceStringSLine"
		BAW_Label.name			= "BAW_Label"
		BAW_Label.material		= stroke_font
		BAW_Label.init_pos		= {PosX(-0.33), PosY(0.10), 0}
		BAW_Label.alignment		= "LeftCenter"
		BAW_Label.value			= "BAW"
		BAW_Label.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
Add_MPCD_Element(BAW_Label)

local	BAW_Value				= CreateElement "ceStringSLine"
		BAW_Value.name			= "BAW_Value"
		BAW_Value.material		= stroke_font
		BAW_Value.init_pos		= {PosX(0.10), PosY(0.10), 0}
		BAW_Value.alignment		= "RightCenter"
		BAW_Value.value			= "16000"
		BAW_Value.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
        BAW_Value.formats		= {"%d"}
        BAW_Value.controllers	= {{"basic_aircraft_weight"}}
Add_MPCD_Element(BAW_Value)

local	H2O_Label				= CreateElement "ceStringSLine"
		H2O_Label.name			= "H2O_Label"
		H2O_Label.material		= stroke_font
		H2O_Label.init_pos		= {PosX(-0.33), 0, 0}
		H2O_Label.alignment		= "LeftCenter"
		H2O_Label.value			= "H2O"
		H2O_Label.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
Add_MPCD_Element(H2O_Label)

local	H2O_Value				= CreateElement "ceStringSLine"
		H2O_Value.name			= "H2O_Value"
		H2O_Value.material		= stroke_font
		H2O_Value.init_pos		= {PosX(0.10), 0, 0}
		H2O_Value.alignment		= "RightCenter"
		H2O_Value.value			= "400"
		H2O_Value.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
        H2O_Value.formats		= {"%d"}
        H2O_Value.controllers	= {{"basic_h2o"}}
Add_MPCD_Element(H2O_Value)

local	BDI_Label				= CreateElement "ceStringSLine"
		BDI_Label.name			= "BDI_Label"
		BDI_Label.material		= stroke_font
		BDI_Label.init_pos		= {PosX(-0.33), PosY(-0.10), 0}
		BDI_Label.alignment		= "LeftCenter"
		BDI_Label.value			= "BDI"
		BDI_Label.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
Add_MPCD_Element(BDI_Label)

local	BDI_Value				= CreateElement "ceStringSLine"
		BDI_Value.name			= "BDI_Value"
		BDI_Value.material		= stroke_font
		BDI_Value.init_pos		= {PosX(0.10), PosY(-0.10), 0}
		BDI_Value.alignment		= "RightCenter"
		BDI_Value.value			= "6.1"
		BDI_Value.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
        BDI_Value.formats		= {"%2.1f"}
        BDI_Value.controllers	= {{"basic_drag_index"}}
Add_MPCD_Element(BDI_Value)

