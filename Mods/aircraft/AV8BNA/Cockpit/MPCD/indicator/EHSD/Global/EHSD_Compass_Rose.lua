-- EHSDI Compass Rose

-- Compass Rose Centers
local	MPCD_center				= CreateElement "ceSimple"
		MPCD_center.name		= "MPCD_center"
		MPCD_center.init_pos	= {0, 0, 0}
		MPCD_center.controllers	= {{"EHSD_Compass_Rose_Center", -0.05}}
Add_MPCD_Element(MPCD_center)

local	MPCD_center					= CreateElement "ceSimple"
		MPCD_center.name			= "CompassRose_center"
		MPCD_center.init_pos		= {0, 0, 0}
		MPCD_center.parent_element	= "MPCD_center"
		MPCD_center.controllers		= {{"EHSD_MAP_EHSI"}, {"EHSD_Compass_Rose_Heading"}}
Add_MPCD_Element(MPCD_center)

local	MPCD_center					= CreateElement "ceSimple"
		MPCD_center.name			= "GT_Ind_center"
		MPCD_center.init_pos		= {0, 0, 0}
		MPCD_center.parent_element	= "MPCD_center"
		MPCD_center.controllers		= {{"EHSD_MAP_EHSI"}, {"ac_grd_trk_pointer"}}
Add_MPCD_Element(MPCD_center)

-- GROUND TRACK Indicator Centered
local	EHSD_Symbol					= CreateElement "ceSMultiLine"
		EHSD_Symbol.name			= "gt_pointer_CTR_OL"
		EHSD_Symbol.material		= stroke_material_outl
		EHSD_Symbol.init_pos		= {0, PosY(0.4), 0}
		EHSD_Symbol.parent_element	= "GT_Ind_center"
		EHSD_Symbol.points_set		= {"MPCD_stroke_symbols", "GT_Index_Centered"}
		EHSD_Symbol.scale			= MPCD_STRK_SCALE
		EHSD_Symbol.controllers 	= {{"EHSD_CR_Centered"}}
AddMPCDStrokeSymbol(EHSD_Symbol, true, false)

local	EHSD_Symbol					= CreateElement "ceSMultiLine"
		EHSD_Symbol.name			= "gt_pointer_CTR"
		EHSD_Symbol.material		= stroke_material
		EHSD_Symbol.init_pos		= {0, PosY(0.4), 0}
		EHSD_Symbol.parent_element	= "GT_Ind_center"
		EHSD_Symbol.points_set		= {"MPCD_stroke_symbols", "GT_Index_Centered"}
		EHSD_Symbol.scale			= MPCD_STRK_SCALE
		EHSD_Symbol.controllers 	= {{"EHSD_CR_Centered"}}
AddMPCDStrokeSymbol(EHSD_Symbol)

-- GROUND TRACK Indicator Decentered
local	EHSD_Symbol					= CreateElement "ceSMultiLine"
		EHSD_Symbol.name			= "gt_pointer_DCTR_OL"
		EHSD_Symbol.material		= stroke_material_outl
		EHSD_Symbol.init_pos		= {0, PosY(0.652), 0}
		EHSD_Symbol.parent_element	= "GT_Ind_center"
		EHSD_Symbol.points_set		= {"MPCD_stroke_symbols", "GT_Index_Decentered"}
		EHSD_Symbol.scale			= MPCD_STRK_SCALE
		EHSD_Symbol.controllers 	= {{"EHSD_CR_Decentered"}}
AddMPCDStrokeSymbol(EHSD_Symbol, true, false)

local	EHSD_Symbol					= CreateElement "ceSMultiLine"
		EHSD_Symbol.name			= "gt_pointer_DCTR"
		EHSD_Symbol.material		= stroke_material
		EHSD_Symbol.init_pos		= {0, PosY(0.652), 0}
		EHSD_Symbol.parent_element	= "GT_Ind_center"
		EHSD_Symbol.points_set		= {"MPCD_stroke_symbols", "GT_Index_Decentered"}
		EHSD_Symbol.scale			= MPCD_STRK_SCALE
		EHSD_Symbol.controllers 	= {{"EHSD_CR_Decentered"}}
AddMPCDStrokeSymbol(EHSD_Symbol)

-- COMPASS ROSE Elements
local i = 0
local j = 0

for i = 1, 35 do
	j = i % 3
	
	if j ~= 0 then
		local	compass_rose_dots					= CreateElement "ceSMultiLine"
				compass_rose_dots.name				= "compass_rose_OL_" .. string.format("%02d", i)
				compass_rose_dots.material			= stroke_material_outl
				compass_rose_dots.init_pos			= {0, 0, 0}
				compass_rose_dots.points_set		= {"MPCD_stroke_symbols", "compass_dot"}
				compass_rose_dots.scale				= MPCD_STRK_SCALE
				compass_rose_dots.parent_element	= "MPCD_center"
				compass_rose_dots.controllers 		= {{"EHSD_MAP_EHSI"}, {"ehsd_compass_rose", i * 10, 0.09}}
		AddMPCDStrokeSymbol(compass_rose_dots, true, false)
		
		local	compass_rose_dots					= CreateElement "ceSMultiLine"
				compass_rose_dots.name				= "compass_rose_" .. string.format("%02d", i)
				compass_rose_dots.material			= stroke_material
				compass_rose_dots.init_pos			= {0, 0, 0}
				compass_rose_dots.points_set		= {"MPCD_stroke_symbols", "compass_dot"}
				compass_rose_dots.scale				= MPCD_STRK_SCALE
				compass_rose_dots.parent_element	= "MPCD_center"
				compass_rose_dots.controllers 		= {{"EHSD_MAP_EHSI"}, {"ehsd_compass_rose", i * 10, 0.09}}
		AddMPCDStrokeSymbol(compass_rose_dots)
	end
end

for i = 0, 11 do
	j = i * 3
	
	local	compass_rose_ords					= CreateElement "ceSMultiLine"
			compass_rose_ords.name				= "compass_rose_OL_"  .. string.format("%02d", j)
			compass_rose_ords.material			= stroke_material_outl
			compass_rose_ords.init_pos			= {0, 0, 0}
			compass_rose_ords.points_set		= {"MPCD_stroke_symbols", "Compass_Rose_" .. string.format("%02d", j)}
			compass_rose_ords.scale				= MPCD_STRK_SCALE
			compass_rose_ords.parent_element	= "MPCD_center"
			compass_rose_ords.controllers 		= {{"EHSD_MAP_EHSI"}, {"ehsd_compass_rose", j * 10, 0.045}}
	AddMPCDStrokeSymbol(compass_rose_ords, true, false)
	
	local	compass_rose_ords					= CreateElement "ceSMultiLine"
			compass_rose_ords.name				= "compass_rose_" .. string.format("%02d", j)
			compass_rose_ords.material			= stroke_material
			compass_rose_ords.init_pos			= {0, 0, 0}
			compass_rose_ords.points_set		= {"MPCD_stroke_symbols", "Compass_Rose_" .. string.format("%02d", j)}
			compass_rose_ords.scale				= MPCD_STRK_SCALE
			compass_rose_ords.parent_element	= "MPCD_center"
			compass_rose_ords.controllers 		= {{"EHSD_MAP_EHSI"}, {"ehsd_compass_rose", j * 10, 0.045}}
	AddMPCDStrokeSymbol(compass_rose_ords)
end

-- MAG Heading Lubber Line
local	EHSD_Symbol					= CreateElement "ceSMultiLine"
		EHSD_Symbol.name			= "Lubber_Line_M_CTR_OL"
		EHSD_Symbol.material		= stroke_material_outl
		EHSD_Symbol.init_pos		= {0, PosY(0.85), 0}
		EHSD_Symbol.parent_element	= "CompassRose_center"
		EHSD_Symbol.points_set		= {"MPCD_stroke_symbols", "Mag_Heading"}
		EHSD_Symbol.scale			= MPCD_STRK_SCALE
		EHSD_Symbol.controllers 	= {{"ac_hdg_mag"}, {"EHSD_CR_Decenter_axis", 0.0342}}
AddMPCDStrokeSymbol(EHSD_Symbol, true, false)

local	EHSD_Symbol					= CreateElement "ceSMultiLine"
		EHSD_Symbol.name			= "Lubber_Line_M_CTR"
		EHSD_Symbol.material		= stroke_material
		EHSD_Symbol.init_pos		= {0, PosY(0.85), 0}
		EHSD_Symbol.parent_element	= "CompassRose_center"
		EHSD_Symbol.points_set		= {"MPCD_stroke_symbols", "Mag_Heading"}
		EHSD_Symbol.scale			= MPCD_STRK_SCALE
		EHSD_Symbol.controllers 	= {{"ac_hdg_mag"}, {"EHSD_CR_Decenter_axis", 0.0342}}
AddMPCDStrokeSymbol(EHSD_Symbol)

-- TRUE Heading  Lubber Line
local	EHSD_Symbol					= CreateElement "ceSMultiLine"
		EHSD_Symbol.name			= "Lubber_Line_T_CTR_OL"
		EHSD_Symbol.material		= stroke_material_outl
		EHSD_Symbol.init_pos		= {0, PosY(0.85), 0}
		EHSD_Symbol.parent_element	= "CompassRose_center"
		EHSD_Symbol.points_set		= {"MPCD_stroke_symbols", "True_Heading"}
		EHSD_Symbol.scale			= MPCD_STRK_SCALE
		EHSD_Symbol.controllers 	= {{"ac_hdg_true"}, {"EHSD_CR_Decenter_axis", 0.0342}}
AddMPCDStrokeSymbol(EHSD_Symbol, true, false)

local	EHSD_Symbol					= CreateElement "ceSMultiLine"
		EHSD_Symbol.name			= "Lubber_Line_T_CTR"
		EHSD_Symbol.material		= stroke_material
		EHSD_Symbol.init_pos		= {0, PosY(0.85), 0}
		EHSD_Symbol.parent_element	= "CompassRose_center"
		EHSD_Symbol.points_set		= {"MPCD_stroke_symbols", "True_Heading"}
		EHSD_Symbol.scale			= MPCD_STRK_SCALE
		EHSD_Symbol.controllers 	= {{"ac_hdg_true"}, {"EHSD_CR_Decenter_axis", 0.0342}}
AddMPCDStrokeSymbol(EHSD_Symbol)
