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

InitPosBase					= CreateElement "ceSimple"
InitPosBase.name				= "InitPosBase"
InitPosBase.init_pos			= {0, GetAspect() - 3.5 * FontSizeY1}
AddElement(InitPosBase)

-- Alignment Vars
local delta_pos_y = LineSizeY * 1.35

-- Page Title --

local PDA_Adjust_x = 0
local PDA_Adjust_y = -LineSizeY * 1.35

txt_PageTitle					= CreateElement "ceStringPoly"
txt_PageTitle.name				= "txt_PageTitle"
txt_PageTitle.material			= "font_hints_kneeboard"
txt_PageTitle.init_pos			= {PDA_Adjust_x,  PDA_Adjust_y, 0}
txt_PageTitle.value				= "PILOT SIGNOUT SHEET"
txt_PageTitle.alignment			= "CenterCenter"
txt_PageTitle.parent_element	= HintsBase.name
txt_PageTitle.stringdefs		= predefined_font_08
AddElement(txt_PageTitle)

-- Pilot & Aircraft Data --

local PAD_pos_x0 = 0
local PAD_pos_x1 = -0.95
local PAD_pos_x2 = -0.20
local PAD_pos_x3 = 0.0
local PAD_pos_y = -delta_pos_y * 2.2

txt_AircraftModel					= CreateElement "ceStringPoly"
txt_AircraftModel.name				= "txt_AircraftModel"
txt_AircraftModel.material			= "font_hints_kneeboard"
txt_AircraftModel.init_pos			= {PAD_pos_x1,  PAD_pos_y, 0}
txt_AircraftModel.value				= "AIRCRAFT MODEL:   M-2000C"
txt_AircraftModel.alignment			= "LeftCenter"
txt_AircraftModel.parent_element	= HintsBase.name
txt_AircraftModel.stringdefs		= predefined_font_06
AddElement(txt_AircraftModel)

PAD_pos_y = PAD_pos_y - delta_pos_y * 1

txt_Pilot_Callsign_D				= CreateElement "ceStringPoly"
txt_Pilot_Callsign_D.name			= "txt_Pilot_Callsign_D"
txt_Pilot_Callsign_D.material		= "font_hints_kneeboard"
txt_Pilot_Callsign_D.init_pos		= {PAD_pos_x1,  PAD_pos_y, 0}
txt_Pilot_Callsign_D.formats		= {"PILOT CALLSIGN: %s"}
txt_Pilot_Callsign_D.alignment		= "LeftCenter"
txt_Pilot_Callsign_D.parent_element	= HintsBase.name
txt_Pilot_Callsign_D.stringdefs		= predefined_font_06
txt_Pilot_Callsign_D.controllers	= {{"PAD_Callsign"}}
AddElement(txt_Pilot_Callsign_D)

PAD_pos_y = PAD_pos_y - delta_pos_y * 1


txt_Aircraft_Ordnance					= CreateElement "ceStringPoly"
txt_Aircraft_Ordnance.name				= "txt_Aircraft_Weight_O"
txt_Aircraft_Ordnance.material			= "font_hints_kneeboard"
txt_Aircraft_Ordnance.init_pos			= {PAD_pos_x1,  PAD_pos_y, 0}
txt_Aircraft_Ordnance.value				= "AIRCRAFT ORDNANCE:"
txt_Aircraft_Ordnance.alignment			= "LeftCenter"
txt_Aircraft_Ordnance.parent_element	= HintsBase.name
txt_Aircraft_Ordnance.stringdefs		= predefined_font_06
AddElement(txt_Aircraft_Ordnance)

txt_Aircraft_Ordnance_0					= CreateElement "ceStringPoly"
txt_Aircraft_Ordnance_0.name			= "txt_Aircraft_Ordnance_0"
txt_Aircraft_Ordnance_0.material		= "font_hints_kneeboard"
txt_Aircraft_Ordnance_0.init_pos		= {PAD_pos_x0,  PAD_pos_y, 0}
txt_Aircraft_Ordnance_0.formats			= {"%d ROUNDS 30MM X 2"}
txt_Aircraft_Ordnance_0.alignment		= "LeftCenter"
txt_Aircraft_Ordnance_0.parent_element	= HintsBase.name
txt_Aircraft_Ordnance_0.stringdefs		= predefined_font_06
txt_Aircraft_Ordnance_0.controllers		= {{"PAD_GunAmmo"}}
AddElement(txt_Aircraft_Ordnance_0)

PAD_pos_y = PAD_pos_y - delta_pos_y * 1


txt_Aircraft_Ordnance_1					= CreateElement "ceStringPoly"
txt_Aircraft_Ordnance_1.name			= "txt_Aircraft_Ordnance_1"
txt_Aircraft_Ordnance_1.material		= "font_hints_kneeboard"
txt_Aircraft_Ordnance_1.init_pos		= {PAD_pos_x0,  PAD_pos_y, 0}
txt_Aircraft_Ordnance_1.formats			= {"%s X %d"}
txt_Aircraft_Ordnance_1.alignment		= "LeftCenter"
txt_Aircraft_Ordnance_1.parent_element	= HintsBase.name
txt_Aircraft_Ordnance_1.stringdefs		= predefined_font_06
txt_Aircraft_Ordnance_1.controllers		= {{"PAD_PCA",1}}
AddElement(txt_Aircraft_Ordnance_1)

PAD_pos_y = PAD_pos_y - delta_pos_y * 1

txt_Aircraft_Ordnance_2					= CreateElement "ceStringPoly"
txt_Aircraft_Ordnance_2.name			= "txt_Aircraft_Ordnance_2"
txt_Aircraft_Ordnance_2.material		= "font_hints_kneeboard"
txt_Aircraft_Ordnance_2.init_pos		= {PAD_pos_x0,  PAD_pos_y, 0}
txt_Aircraft_Ordnance_2.formats			= {"%s X %d"}
txt_Aircraft_Ordnance_2.alignment		= "LeftCenter"
txt_Aircraft_Ordnance_2.parent_element	= HintsBase.name
txt_Aircraft_Ordnance_2.stringdefs		= predefined_font_06
txt_Aircraft_Ordnance_2.controllers		= {{"PAD_PCA",2}}
AddElement(txt_Aircraft_Ordnance_2)

PAD_pos_y = PAD_pos_y - delta_pos_y * 1

txt_Aircraft_Ordnance_3					= CreateElement "ceStringPoly"
txt_Aircraft_Ordnance_3.name			= "txt_Aircraft_Ordnance_3"
txt_Aircraft_Ordnance_3.material		= "font_hints_kneeboard"
txt_Aircraft_Ordnance_3.init_pos		= {PAD_pos_x0,  PAD_pos_y, 0}
txt_Aircraft_Ordnance_3.formats			= {"%s X %d"}
txt_Aircraft_Ordnance_3.alignment		= "LeftCenter"
txt_Aircraft_Ordnance_3.parent_element	= HintsBase.name
txt_Aircraft_Ordnance_3.stringdefs		= predefined_font_06
txt_Aircraft_Ordnance_3.controllers		= {{"PAD_PCA",3}}
AddElement(txt_Aircraft_Ordnance_3)

PAD_pos_y = PAD_pos_y - delta_pos_y * 1

txt_Aircraft_Ordnance_4					= CreateElement "ceStringPoly"
txt_Aircraft_Ordnance_4.name			= "txt_Aircraft_Ordnance_4"
txt_Aircraft_Ordnance_4.material		= "font_hints_kneeboard"
txt_Aircraft_Ordnance_4.init_pos		= {PAD_pos_x0,  PAD_pos_y, 0}
txt_Aircraft_Ordnance_4.formats			= {"%s X %d"}
txt_Aircraft_Ordnance_4.alignment		= "LeftCenter"
txt_Aircraft_Ordnance_4.parent_element	= HintsBase.name
txt_Aircraft_Ordnance_4.stringdefs		= predefined_font_06
txt_Aircraft_Ordnance_4.controllers		= {{"PAD_PCA",4}}
AddElement(txt_Aircraft_Ordnance_4)

PAD_pos_y = PAD_pos_y - delta_pos_y * 1

txt_Aircraft_Ordnance_5					= CreateElement "ceStringPoly"
txt_Aircraft_Ordnance_5.name			= "txt_Aircraft_Ordnance_5"
txt_Aircraft_Ordnance_5.material		= "font_hints_kneeboard"
txt_Aircraft_Ordnance_5.init_pos		= {PAD_pos_x0,  PAD_pos_y, 0}
txt_Aircraft_Ordnance_5.formats			= {"%s X %d"}
txt_Aircraft_Ordnance_5.alignment		= "LeftCenter"
txt_Aircraft_Ordnance_5.parent_element	= HintsBase.name
txt_Aircraft_Ordnance_5.stringdefs		= predefined_font_06
txt_Aircraft_Ordnance_5.controllers		= {{"PAD_PCA",5}}
AddElement(txt_Aircraft_Ordnance_5)

PAD_pos_y = PAD_pos_y - delta_pos_y * 2

-- Aircraft Initial Position --
txt_Aircraft_IP_Title					= CreateElement "ceStringPoly"
txt_Aircraft_IP_Title.name				= "txt_Aircraft_IP_Title"
txt_Aircraft_IP_Title.material			= "font_hints_kneeboard"
txt_Aircraft_IP_Title.init_pos			= {PAD_pos_x1,  PAD_pos_y, 0}
txt_Aircraft_IP_Title.value				= "INITIAL POSITION:"
txt_Aircraft_IP_Title.alignment			= "LeftCenter"
txt_Aircraft_IP_Title.parent_element	= InitPosBase.name
txt_Aircraft_IP_Title.stringdefs		= predefined_font_06
AddElement(txt_Aircraft_IP_Title)

PAD_pos_y = PAD_pos_y - delta_pos_y * 1


txt_Aircraft_IP_Lat					= CreateElement "ceStringPoly"
txt_Aircraft_IP_Lat.name			= "txt_Aircraft_IP_Lat"
txt_Aircraft_IP_Lat.material		= "font_hints_kneeboard"
txt_Aircraft_IP_Lat.init_pos		= {PAD_pos_x1,  PAD_pos_y, 0}
txt_Aircraft_IP_Lat.value			= "LATITUDE:"
txt_Aircraft_IP_Lat.alignment		= "LeftCenter"
txt_Aircraft_IP_Lat.parent_element	= InitPosBase.name
txt_Aircraft_IP_Lat.stringdefs		= predefined_font_06
AddElement(txt_Aircraft_IP_Lat)

txt_Aircraft_IP_Lat_D					= CreateElement "ceStringPoly"
txt_Aircraft_IP_Lat_D.name				= "txt_Aircraft_IP_Lat_D"
txt_Aircraft_IP_Lat_D.material			= "font_hints_kneeboard"
txt_Aircraft_IP_Lat_D.init_pos			= {-PAD_pos_x1,  PAD_pos_y, 0}
txt_Aircraft_IP_Lat_D.formats			= {"%c%d.%02d.%03d"}
txt_Aircraft_IP_Lat_D.alignment			= "RightCenter"
txt_Aircraft_IP_Lat_D.parent_element	= InitPosBase.name
txt_Aircraft_IP_Lat_D.stringdefs		= predefined_font_06
txt_Aircraft_IP_Lat_D.controllers		= {{"PAD_IP_LAT"}}
AddElement(txt_Aircraft_IP_Lat_D)

PAD_pos_y = PAD_pos_y - delta_pos_y * 1

txt_Aircraft_IP_Lon					= CreateElement "ceStringPoly"
txt_Aircraft_IP_Lon.name			= "txt_Aircraft_IP_Lon"
txt_Aircraft_IP_Lon.material		= "font_hints_kneeboard"
txt_Aircraft_IP_Lon.init_pos		= {PAD_pos_x1,  PAD_pos_y, 0}
txt_Aircraft_IP_Lon.value			= "LONGITUDE:"
txt_Aircraft_IP_Lon.alignment		= "LeftCenter"
txt_Aircraft_IP_Lon.parent_element	= InitPosBase.name
txt_Aircraft_IP_Lon.stringdefs		= predefined_font_06
AddElement(txt_Aircraft_IP_Lon)

txt_Aircraft_IP_Lon_D					= CreateElement "ceStringPoly"
txt_Aircraft_IP_Lon_D.name				= "txt_Aircraft_IP_Lon_D"
txt_Aircraft_IP_Lon_D.material			= "font_hints_kneeboard"
txt_Aircraft_IP_Lon_D.init_pos			= {-PAD_pos_x1,  PAD_pos_y, 0}
txt_Aircraft_IP_Lon_D.formats			= {"%c%03d.%02d.%03d"}
txt_Aircraft_IP_Lon_D.alignment			= "RightCenter"
txt_Aircraft_IP_Lon_D.parent_element	= InitPosBase.name
txt_Aircraft_IP_Lon_D.stringdefs		= predefined_font_06
txt_Aircraft_IP_Lon_D.controllers		= {{"PAD_IP_LON"}}
AddElement(txt_Aircraft_IP_Lon_D)

PAD_pos_y = PAD_pos_y - delta_pos_y * 1

txt_Aircraft_IP_Alt					= CreateElement "ceStringPoly"
txt_Aircraft_IP_Alt.name			= "txt_Aircraft_IP_Alt"
txt_Aircraft_IP_Alt.material		= "font_hints_kneeboard"
txt_Aircraft_IP_Alt.init_pos		= {PAD_pos_x1,  PAD_pos_y, 0}
txt_Aircraft_IP_Alt.value			= "ALTITUDE:"
txt_Aircraft_IP_Alt.alignment		= "LeftCenter"
txt_Aircraft_IP_Alt.parent_element	= InitPosBase.name
txt_Aircraft_IP_Alt.stringdefs		= predefined_font_06
AddElement(txt_Aircraft_IP_Alt)

txt_Aircraft_IP_Alt_D					= CreateElement "ceStringPoly"
txt_Aircraft_IP_Alt_D.name				= "txt_Aircraft_IP_Alt_D"
txt_Aircraft_IP_Alt_D.material			= "font_hints_kneeboard"
txt_Aircraft_IP_Alt_D.init_pos			= {-PAD_pos_x1,  PAD_pos_y, 0}
txt_Aircraft_IP_Alt_D.formats			= {"%1.f M"}
txt_Aircraft_IP_Alt_D.alignment			= "RightCenter"
txt_Aircraft_IP_Alt_D.parent_element	= InitPosBase.name
txt_Aircraft_IP_Alt_D.stringdefs		= predefined_font_06
txt_Aircraft_IP_Alt_D.controllers		= {{"PAD_IP_ALT"}}
AddElement(txt_Aircraft_IP_Alt_D)

PAD_pos_y = PAD_pos_y - delta_pos_y * 1

txt_Aircraft_INS_Align					= CreateElement "ceStringPoly"
txt_Aircraft_INS_Align.name				= "txt_Aircraft_IP_Alt_D"
txt_Aircraft_INS_Align.material			= "font_general_keys"
txt_Aircraft_INS_Align.init_pos			= {PAD_pos_x0,  PAD_pos_y, 0}
txt_Aircraft_INS_Align.formats			= {"ALN REQUIRED", "ALCM AVAILABLE", "INS IS ALIGNED"}
txt_Aircraft_INS_Align.alignment		= "CenterCenter"
txt_Aircraft_INS_Align.parent_element	= InitPosBase.name
txt_Aircraft_INS_Align.stringdefs		= predefined_font_06
txt_Aircraft_INS_Align.controllers		= {{"PAD_INS_ALNG"}}
AddElement(txt_Aircraft_INS_Align)

PAD_pos_y = PAD_pos_y - delta_pos_y * 2

--Aircraft fuel
txt_Aircraft_Weight_F					= CreateElement "ceStringPoly"
txt_Aircraft_Weight_F.name				= "txt_Aircraft_Weight_F"
txt_Aircraft_Weight_F.material			= "font_hints_kneeboard"
txt_Aircraft_Weight_F.init_pos			= {PAD_pos_x1,  PAD_pos_y, 0}
txt_Aircraft_Weight_F.value				= "AIRCRAFT FUEL:"
txt_Aircraft_Weight_F.alignment			= "LeftCenter"
txt_Aircraft_Weight_F.parent_element	= HintsBase.name
txt_Aircraft_Weight_F.stringdefs		= predefined_font_06
AddElement(txt_Aircraft_Weight_F)


txt_Aircraft_Weight_FID					= CreateElement "ceStringPoly"
txt_Aircraft_Weight_FID.name			= "txt_Aircraft_Weight_FID"
txt_Aircraft_Weight_FID.material		= "font_hints_kneeboard"
txt_Aircraft_Weight_FID.init_pos		= {-PAD_pos_x1,  PAD_pos_y, 0}
txt_Aircraft_Weight_FID.formats			= {"INTERNAL:    %4.0f KG"}
txt_Aircraft_Weight_FID.alignment		= "RightCenter"
txt_Aircraft_Weight_FID.parent_element	= HintsBase.name
txt_Aircraft_Weight_FID.stringdefs		= predefined_font_06
txt_Aircraft_Weight_FID.controllers		= {{"PAD_TotalFuel_Int"}}
AddElement(txt_Aircraft_Weight_FID)

PAD_pos_y = PAD_pos_y - delta_pos_y * 1

txt_Aircraft_Weight_FED					= CreateElement "ceStringPoly"
txt_Aircraft_Weight_FED.name			= "txt_Aircraft_Weight_FED"
txt_Aircraft_Weight_FED.material		= "font_hints_kneeboard"
txt_Aircraft_Weight_FED.init_pos		= {-PAD_pos_x1,  PAD_pos_y, 0}
txt_Aircraft_Weight_FED.formats			= {"EXTERNAL:    %4.0f KG"}
txt_Aircraft_Weight_FED.alignment		= "RightCenter"
txt_Aircraft_Weight_FED.parent_element	= HintsBase.name
txt_Aircraft_Weight_FED.stringdefs		= predefined_font_06
txt_Aircraft_Weight_FED.controllers		= {{"PAD_TotalFuel_Ext"}}
AddElement(txt_Aircraft_Weight_FED)

PAD_pos_y = PAD_pos_y - delta_pos_y * 2

txt_Aircraft_Refuel						= CreateElement "ceStringPoly"
txt_Aircraft_Refuel.name				= "txt_Aircraft_Refuel"
txt_Aircraft_Refuel.material			= "font_hints_kneeboard"
txt_Aircraft_Refuel.init_pos			= {PAD_pos_x1,  PAD_pos_y, 0}
txt_Aircraft_Refuel.value				= "REFUELS:"
txt_Aircraft_Refuel.alignment			= "LeftCenter"
txt_Aircraft_Refuel.parent_element		= HintsBase.name
txt_Aircraft_Refuel.stringdefs			= predefined_font_06
AddElement(txt_Aircraft_Refuel)

PAD_pos_y = PAD_pos_y - delta_pos_y * 1

for i = 0, 10 do
	txt_Aircraft_RefuelA					= CreateElement "ceStringPoly"
	txt_Aircraft_RefuelA.name				= "txt_Aircraft_Refuel" .. (i)
	txt_Aircraft_RefuelA.material			= "font_hints_kneeboard"
	txt_Aircraft_RefuelA.init_pos			= {PAD_pos_x1,  PAD_pos_y, 0}
	txt_Aircraft_RefuelA.formats			= {"  %02d:%02d %c%dKG", "  %02d:%02d TOT %dKG"}
	txt_Aircraft_RefuelA.alignment			= "LeftCenter"
	txt_Aircraft_RefuelA.parent_element		= HintsBase.name
	txt_Aircraft_RefuelA.stringdefs			= predefined_font_06
	txt_Aircraft_RefuelA.controllers		= {{"PAD_Refuel",i}}
	AddElement(txt_Aircraft_RefuelA)
	
	txt_Aircraft_RefuelB					= CreateElement "ceStringPoly"
	txt_Aircraft_RefuelB.name				= "txt_Aircraft_Refuel" .. (i+10)
	txt_Aircraft_RefuelB.material			= "font_hints_kneeboard"
	txt_Aircraft_RefuelB.init_pos			= {PAD_pos_x3,  PAD_pos_y, 0}
	txt_Aircraft_RefuelB.formats			= {"  %02d:%02d %c%dKG", "  %02d:%02d TOT %dKG"}
	txt_Aircraft_RefuelB.alignment			= "LeftCenter"
	txt_Aircraft_RefuelB.parent_element		= HintsBase.name
	txt_Aircraft_RefuelB.stringdefs			= predefined_font_06
	txt_Aircraft_RefuelB.controllers		= {{"PAD_Refuel",i+10}}
	AddElement(txt_Aircraft_RefuelB)
	
	PAD_pos_y = PAD_pos_y - delta_pos_y * 1		
end