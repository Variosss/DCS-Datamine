dofile(LockOn_Options.common_script_path.."KNEEBOARD/indicator/definitions.lua")
SetScale(FOV)

add_picture("Mods/aircraft/M-2000C/Cockpit/Resources/IndicationTextures/notepad.dds")

-- GENERAL SCALE
local general_font_scale = 1.0

FontSizeX1	= 0.0075 * general_font_scale
FontSizeY1	= FontSizeX1

predefined_font_20 = {general_font_scale* FontSizeY1*2.0, general_font_scale* FontSizeX1*2.0, 0.0, 0.0}
predefined_font_10 = {general_font_scale* FontSizeY1, 	  general_font_scale* FontSizeX1	, 0.0, 0.0}
predefined_font_09 = {general_font_scale* FontSizeY1*0.9, general_font_scale* FontSizeX1*0.9, 0.0, 0.0}
predefined_font_08 = {general_font_scale* FontSizeY1*0.8, general_font_scale* FontSizeX1*0.8, 0.0, 0.0}
predefined_font_07 = {general_font_scale* FontSizeY1*0.7, general_font_scale* FontSizeX1*0.7, 0.0, 0.0}
predefined_font_06 = {general_font_scale* FontSizeY1*0.6, general_font_scale* FontSizeX1*0.6, 0.0, 0.0}
predefined_font_05 = {general_font_scale* FontSizeY1*0.5, general_font_scale* FontSizeX1*0.5, 0.0, 0.0}

function AddElement(object)
    object.use_mipfilter = true
    Add(object)
end

function AddText(name, pos, text_format, align, parent, controllers, size, material)
	local elem			= CreateElement "ceStringPoly"
	elem.name			= name
	elem.material		= material or "font_hints_kneeboard"
	elem.init_pos		= {pos[1],  pos[2], 0}
	elem.alignment		= align
	elem.parent_element	= parent
	elem.stringdefs		= size or predefined_font_06
	elem.controllers	= controllers or {}
	
	if type(text_format) == "table" then
		elem.formats    = text_format
	else
		elem.value = text_format
	end
	
	AddElement(elem)
end


local LineSizeY   = FontSizeY1 * 9
local ColumnSizeX = FontSizeX1 * 48 / 72 * 8 

firstLineY = - LineSizeY

local hints_scale		= MakeMaterial("arcade.tga", {255, 128, 64, 255})

local base_size_x   = ColumnSizeX * 45.0
local base_size_y   = LineSizeY   * 17.0
local base_size_x05 = base_size_x * 0.5
local base_size_y05 = base_size_y * 0.5

HintsBase					= CreateElement "ceSimple"
HintsBase.name				= "HintsBase"
HintsBase.init_pos			= {0, GetAspect() - 3.5 * FontSizeY1}
AddElement(HintsBase)

-- Ground Adjustment ------------------------------------------------
-----------------------------------------------------------------

local Ground_Adjust_x = 0
local Ground_Adjust_y = - LineSizeY * 1.35

txt_GroundAdjust				= CreateElement "ceStringPoly"
txt_GroundAdjust.name			= "txt_GroundAdjust"
txt_GroundAdjust.material		= "font_hints_kneeboard"
txt_GroundAdjust.init_pos		= {Ground_Adjust_x,  Ground_Adjust_y - LineSizeY * 0.5, 0}
txt_GroundAdjust.value			= "GROUND ADJUSTMENT OPTIONS"
txt_GroundAdjust.alignment		= "CenterCenter"
txt_GroundAdjust.parent_element	= HintsBase.name
txt_GroundAdjust.stringdefs		= predefined_font_10
AddElement(txt_GroundAdjust)

-- Rocket Adjustment ------------------------------------------------
-----------------------------------------------------------------
local RocketBurst_pos_x	    = ColumnSizeX * 8
local KeyRocketBurst_pos_x	= 1.0 - ColumnSizeX * 1.5

local weapon_delta_pos_y	= LineSizeY * 1.35
local weapon_names_pos_y	= Ground_Adjust_y - LineSizeY * 1.35
local ConfigWarning_pos_y	= weapon_names_pos_y - weapon_delta_pos_y * 1
local RocketBurst_pos_y		= weapon_names_pos_y - weapon_delta_pos_y * 3

Name_RocketBurst				= CreateElement "ceStringPoly"
Name_RocketBurst.name			= "Name_RocketBurst"
Name_RocketBurst.material		= "font_hints_kneeboard"
Name_RocketBurst.init_pos		= {Ground_Adjust_x,  ConfigWarning_pos_y, 0}
Name_RocketBurst.value			= "ONLY MODIFIABLE WHEN ENGINE IS OFF"
Name_RocketBurst.alignment		= "CenterCenter"
Name_RocketBurst.parent_element	= HintsBase.name
Name_RocketBurst.stringdefs		= predefined_font_06
AddElement(Name_RocketBurst)

Name_RocketBurst				= CreateElement "ceStringPoly"
Name_RocketBurst.name			= "Name_RocketBurst"
Name_RocketBurst.material		= "font_hints_kneeboard"
Name_RocketBurst.init_pos		= {RocketBurst_pos_x,  RocketBurst_pos_y, 0}
Name_RocketBurst.value			= "MATRA 155 BURST COUNT - "
Name_RocketBurst.alignment		= "RightCenter"
Name_RocketBurst.parent_element	= HintsBase.name
Name_RocketBurst.stringdefs		= predefined_font_06
AddElement(Name_RocketBurst)

Status_RocketBurst					= CreateElement "ceStringPoly"
Status_RocketBurst.name				= "Status_RocketBurst"
Status_RocketBurst.material			= "font_hints_kneeboard"
Status_RocketBurst.init_pos			= {RocketBurst_pos_x,  RocketBurst_pos_y, 0}
Status_RocketBurst.formats			= {"1", "3", "6", "18"}
Status_RocketBurst.alignment		= "LeftCenter"
Status_RocketBurst.parent_element	= HintsBase.name
Status_RocketBurst.stringdefs		= predefined_font_06
Status_RocketBurst.controllers		= {{"Weapon_RocketBurst"}}
AddElement(Status_RocketBurst)

Key_RocketBurst					= CreateElement "ceStringPoly"
Key_RocketBurst.name			= "Key_RocketBurst"
Key_RocketBurst.material		= "font_general_keys"
Key_RocketBurst.init_pos		= {KeyRocketBurst_pos_x,  RocketBurst_pos_y, 0}
Key_RocketBurst.value			= "RS+RA+[1]"
Key_RocketBurst.alignment		= "RightCenter"
Key_RocketBurst.parent_element	= HintsBase.name
Key_RocketBurst.stringdefs		= predefined_font_06
AddElement(Key_RocketBurst)

-- Gun Adjustment ------------------------------------------------
-----------------------------------------------------------------
local GunBurst_pos_x	    = ColumnSizeX * 8
local KeyGunBurst_pos_x	    = 1.0 - ColumnSizeX * 1.5

local gun_delta_pos_y	    = LineSizeY * 1.35
local gun_names_pos_y	    = Ground_Adjust_y - LineSizeY * 1.35
local GunBurst_pos_y		= gun_names_pos_y - gun_delta_pos_y * 4

Name_GunBurst				= CreateElement "ceStringPoly"
Name_GunBurst.name			= "Name_GunBurst"
Name_GunBurst.material		= "font_hints_kneeboard"
Name_GunBurst.init_pos		= {RocketBurst_pos_x,  GunBurst_pos_y, 0}
Name_GunBurst.value			= "DEFA BURST TIME - "
Name_GunBurst.alignment		= "RightCenter"
Name_GunBurst.parent_element	= HintsBase.name
Name_GunBurst.stringdefs		= predefined_font_06
AddElement(Name_GunBurst)

Status_GunBurst					= CreateElement "ceStringPoly"
Status_GunBurst.name			= "Status_GunBurst"
Status_GunBurst.material		= "font_hints_kneeboard"
Status_GunBurst.init_pos		= {GunBurst_pos_x,  GunBurst_pos_y, 0}
Status_GunBurst.formats			= {"%1.1f"}
Status_GunBurst.alignment		= "LeftCenter"
Status_GunBurst.parent_element	= HintsBase.name
Status_GunBurst.stringdefs		= predefined_font_06
Status_GunBurst.controllers		= {{"Weapon_GunBurst"}}
AddElement(Status_GunBurst)

Key_GunBurst				= CreateElement "ceStringPoly"
Key_GunBurst.name			= "Key_GunBurst"
Key_GunBurst.material		= "font_general_keys"
Key_GunBurst.init_pos		= {KeyGunBurst_pos_x,  GunBurst_pos_y, 0}
Key_GunBurst.value			= "RS+RA+[2]"
Key_GunBurst.alignment		= "RightCenter"
Key_GunBurst.parent_element	= HintsBase.name
Key_GunBurst.stringdefs		= predefined_font_06
AddElement(Key_GunBurst)

-- Laser Code ---------------------------------------------------
-----------------------------------------------------------------

local lasercode_delta_pos_x		= ColumnSizeX * 8
local lasercode_delta_pos_y		= LineSizeY * 1.35

local LaserCode_pos_x 			= lasercode_delta_pos_x
local LaserCode_pos_y			= -LineSizeY * 7*1.35
local LaserCode100_pos_y		= LaserCode_pos_y - lasercode_delta_pos_y * 1
local LaserCode10_pos_y			= LaserCode_pos_y - lasercode_delta_pos_y * 2
local LaserCode1_pos_y			= LaserCode_pos_y - lasercode_delta_pos_y * 3

Name_LaserCode					= CreateElement "ceStringPoly"
Name_LaserCode.name				= "Name_LaserCode"
Name_LaserCode.material			= "font_hints_kneeboard"
Name_LaserCode.init_pos			= {LaserCode_pos_x,  LaserCode_pos_y, 0}
Name_LaserCode.value			= "LASER CODE - "
Name_LaserCode.alignment		= "RightCenter"
Name_LaserCode.parent_element	= HintsBase.name
Name_LaserCode.stringdefs		= predefined_font_06
AddElement(Name_LaserCode)

Status_LaserCode1000				= CreateElement "ceStringPoly"
Status_LaserCode1000.name			= "Status_LaserCode1000"
Status_LaserCode1000.material		= "font_hints_kneeboard"
Status_LaserCode1000.init_pos		= {LaserCode_pos_x,  LaserCode_pos_y, 0}
Status_LaserCode1000.value			= "1"
Status_LaserCode1000.alignment		= "LeftCenter"
Status_LaserCode1000.parent_element	= HintsBase.name
Status_LaserCode1000.stringdefs		= predefined_font_06
AddElement(Status_LaserCode1000)

Status_LaserCode100					= CreateElement "ceStringPoly"
Status_LaserCode100.name			= "Status_LaserCode100"
Status_LaserCode100.material		= "font_hints_kneeboard"
Status_LaserCode100.init_pos		= {LaserCode_pos_x,  LaserCode100_pos_y, 0}
Status_LaserCode100.formats			= {"1", "2", "3", "4", "5", "6", "7", "8"}
Status_LaserCode100.alignment		= "LeftCenter"
Status_LaserCode100.parent_element	= HintsBase.name
Status_LaserCode100.stringdefs		= predefined_font_06
Status_LaserCode100.controllers		= {{"Status_LaserCode", 2}}
AddElement(Status_LaserCode100)

Status_LaserCode10					= CreateElement "ceStringPoly"
Status_LaserCode10.name				= "Status_LaserCode10"
Status_LaserCode10.material			= "font_hints_kneeboard"
Status_LaserCode10.init_pos			= {LaserCode_pos_x,  LaserCode10_pos_y, 0}
Status_LaserCode10.formats			= {"1", "2", "3", "4", "5", "6", "7", "8"}
Status_LaserCode10.alignment		= "LeftCenter"
Status_LaserCode10.parent_element	= HintsBase.name
Status_LaserCode10.stringdefs		= predefined_font_06
Status_LaserCode10.controllers		= {{"Status_LaserCode", 1}}
AddElement(Status_LaserCode10)

Status_LaserCode1					= CreateElement "ceStringPoly"
Status_LaserCode1.name				= "Status_LaserCode1"
Status_LaserCode1.material			= "font_hints_kneeboard"
Status_LaserCode1.init_pos			= {LaserCode_pos_x,  LaserCode1_pos_y, 0}
Status_LaserCode1.formats			= {"1", "2", "3", "4", "5", "6", "7", "8"}
Status_LaserCode1.alignment			= "LeftCenter"
Status_LaserCode1.parent_element	= HintsBase.name
Status_LaserCode1.stringdefs		= predefined_font_06
Status_LaserCode1.controllers		= {{"Status_LaserCode", 0}}
AddElement(Status_LaserCode1)

Key_LaserCode100				= CreateElement "ceStringPoly"
Key_LaserCode100.name			= "Key_LaserCode100"
Key_LaserCode100.material		= "font_general_keys"
Key_LaserCode100.init_pos		= {KeyRocketBurst_pos_x,  LaserCode100_pos_y, 0}
Key_LaserCode100.value			= "RS+RA+[9]"
Key_LaserCode100.alignment		= "RightCenter"
Key_LaserCode100.parent_element	= HintsBase.name
Key_LaserCode100.stringdefs		= predefined_font_06
AddElement(Key_LaserCode100)

Key_LaserCode10					= CreateElement "ceStringPoly"
Key_LaserCode10.name			= "Key_LaserCode10"
Key_LaserCode10.material		= "font_general_keys"
Key_LaserCode10.init_pos		= {KeyRocketBurst_pos_x,  LaserCode10_pos_y, 0}
Key_LaserCode10.value			= "RS+RA+[0]"
Key_LaserCode10.alignment		= "RightCenter"
Key_LaserCode10.parent_element	= HintsBase.name
Key_LaserCode10.stringdefs		= predefined_font_06
AddElement(Key_LaserCode10)

Key_LaserCode1					= CreateElement "ceStringPoly"
Key_LaserCode1.name				= "Key_LaserCode1"
Key_LaserCode1.material			= "font_general_keys"
Key_LaserCode1.init_pos			= {KeyRocketBurst_pos_x,  LaserCode1_pos_y, 0}
Key_LaserCode1.value			= "RS+RA+[-]"
Key_LaserCode1.alignment		= "RightCenter"
Key_LaserCode1.parent_element	= HintsBase.name
Key_LaserCode1.stringdefs		= predefined_font_06
AddElement(Key_LaserCode1)

-- CMD Progam (Read Only) ---------------------------------------
-----------------------------------------------------------------
local CMD_delta_pos_x		= ColumnSizeX * 8
local CMD_delta_pos_y		= LineSizeY * 1.5

local CMD_pos_x		= 0
local CMD_pos_y		= -LineSizeY * 12 * 1.35

txt_CMD_Prog_Title					= CreateElement "ceStringPoly"
txt_CMD_Prog_Title.name				= "txt_CMD_Prog_Title"
txt_CMD_Prog_Title.material			= "font_hints_kneeboard"
txt_CMD_Prog_Title.init_pos			= {CMD_pos_x,  CMD_pos_y, 0}
txt_CMD_Prog_Title.value			= "CHAFF/FLARE PROGRAMS"
txt_CMD_Prog_Title.alignment		= "CenterCenter"
txt_CMD_Prog_Title.parent_element	= HintsBase.name
txt_CMD_Prog_Title.stringdefs		= predefined_font_10
AddElement(txt_CMD_Prog_Title)

-- CMD Programs Detail --
for i=0,10 do
	AddText("cm_prog"..i,
			{CMD_pos_x,  CMD_pos_y - CMD_delta_pos_y * (2.2+i)},
			{"PROGRAM %2d: CHAFF %2d / FLARES %2d / CYCLES: %2d", 
			  "PANIC REL : CHAFF %2d / FLARES %2d / CYCLES: %2d"},
			"CenterCenter", HintsBase.name,
			{{"CMD_Program", i}})
end

--Chaff/Flare load

AddText("cm_internal",
	{CMD_pos_x,  CMD_pos_y - CMD_delta_pos_y * (2.2+12)},
	{"AIRCRAFT LOAD   : CHAFF %3d / FLARES %3d"},
	"CenterCenter", HintsBase.name,
	{{"CMD_Load", 0}})
	
AddText("cm_eclair",
	{CMD_pos_x,  CMD_pos_y - CMD_delta_pos_y * (2.2+13)},
	{"ECLAIR POD LOAD : CHAFF %3d / FLARES %3d"},
	"CenterCenter", HintsBase.name,
	{{"CMD_Load", 1}})
	
