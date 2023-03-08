-----------------------
-- EHSD Page         --
-- Navigation        --
-- Mission Overlay 1 --
-----------------------
local	EHSD_Scale = 0.5 * GetHalfHeight()
local	EHSD_Line_Thickness		= stroke_thickness * 3.5
local	EHSD_Line_OL_Thickness	= DMC_outline_thickness * 3.5

-- Symbols Centers
local	MPCD_center					= CreateElement "ceSimple"
		MPCD_center.name			= "MPCD_center"
		MPCD_center.init_pos		= {0, 0, 0}
		MPCD_center.controllers		= {{"EHSD_Compass_Rose_Center", -0.05}}
Add_MPCD_Element(MPCD_center)

-- AAR ZONE 1
local	AAR_Zone_Pos					= CreateElement "ceSimple"
		AAR_Zone_Pos.name				= "AAR_Zone_1_Pos"
		AAR_Zone_Pos.init_pos			= {0, 0, 0}
		AAR_Zone_Pos.parent_element		= "MPCD_center"
		AAR_Zone_Pos.controllers		= {{"EHSD_OL1_AAR_1_Pos", EHSD_Scale}}
Add_MPCD_VIDEO_Element(AAR_Zone_Pos)

local	EHSD_Symbol_Line				= CreateElement "ceSimpleLineObject"
		EHSD_Symbol_Line.name			= "AAR_Zone_1_OL"
		EHSD_Symbol_Line.material		= stroke_material_outl
		EHSD_Symbol_Line.width       	= EHSD_Line_OL_Thickness
		EHSD_Symbol_Line.init_pos		= {0, 0, 0}
		EHSD_Symbol_Line.parent_element	= "AAR_Zone_1_Pos"
		EHSD_Symbol_Line.controllers	= {{"EHSD_OL1_AAR_1", EHSD_Scale}}
Add_MPCD_Element(EHSD_Symbol_Line)

local	EHSD_Symbol_Line				= CreateElement "ceSimpleLineObject"
		EHSD_Symbol_Line.name			= "AAR_Zone_1"
		EHSD_Symbol_Line.material   	= stroke_material
		EHSD_Symbol_Line.width       	= EHSD_Line_Thickness
		EHSD_Symbol_Line.init_pos		= {0, 0, 0}
		EHSD_Symbol_Line.parent_element	= "AAR_Zone_1_Pos"
		EHSD_Symbol_Line.controllers    = {{"EHSD_OL1_AAR_1", EHSD_Scale}}
Add_MPCD_Element(EHSD_Symbol_Line)

-- AAR ZONE 2
local	AAR_Zone_Pos					= CreateElement "ceSimple"
		AAR_Zone_Pos.name				= "AAR_Zone_2_Pos"
		AAR_Zone_Pos.init_pos			= {0, 0, 0}
		AAR_Zone_Pos.parent_element		= "MPCD_center"
		AAR_Zone_Pos.controllers		= {{"EHSD_OL1_AAR_2_Pos", EHSD_Scale}}
Add_MPCD_VIDEO_Element(AAR_Zone_Pos)

local	EHSD_Symbol_Line				= CreateElement "ceSimpleLineObject"
		EHSD_Symbol_Line.name			= "AAR_Zone_2_OL"
		EHSD_Symbol_Line.material		= stroke_material_outl
		EHSD_Symbol_Line.width       	= EHSD_Line_OL_Thickness
		EHSD_Symbol_Line.init_pos		= {0, 0, 0}
		EHSD_Symbol_Line.parent_element	= "AAR_Zone_2_Pos"
		EHSD_Symbol_Line.controllers	= {{"EHSD_OL1_AAR_2", EHSD_Scale}}
Add_MPCD_Element(EHSD_Symbol_Line)

local	EHSD_Symbol_Line				= CreateElement "ceSimpleLineObject"
		EHSD_Symbol_Line.name			= "AAR_Zone_2"
		EHSD_Symbol_Line.material   	= stroke_material
		EHSD_Symbol_Line.width       	= EHSD_Line_Thickness
		EHSD_Symbol_Line.init_pos		= {0, 0, 0}
		EHSD_Symbol_Line.parent_element	= "AAR_Zone_2_Pos"
		EHSD_Symbol_Line.controllers    = {{"EHSD_OL1_AAR_2", EHSD_Scale}}
Add_MPCD_Element(EHSD_Symbol_Line)

-- AAR ZONE 3
local	AAR_Zone_Pos					= CreateElement "ceSimple"
		AAR_Zone_Pos.name				= "AAR_Zone_3_Pos"
		AAR_Zone_Pos.init_pos			= {0, 0, 0}
		AAR_Zone_Pos.parent_element		= "MPCD_center"
		AAR_Zone_Pos.controllers		= {{"EHSD_OL1_AAR_3_Pos", EHSD_Scale}}
Add_MPCD_VIDEO_Element(AAR_Zone_Pos)

local	EHSD_Symbol_Line				= CreateElement "ceSimpleLineObject"
		EHSD_Symbol_Line.name			= "AAR_Zone_3_OL"
		EHSD_Symbol_Line.material		= stroke_material_outl
		EHSD_Symbol_Line.width       	= EHSD_Line_OL_Thickness
		EHSD_Symbol_Line.init_pos		= {0, 0, 0}
		EHSD_Symbol_Line.parent_element	= "AAR_Zone_3_Pos"
		EHSD_Symbol_Line.controllers	= {{"EHSD_OL1_AAR_3", EHSD_Scale}}
Add_MPCD_Element(EHSD_Symbol_Line)

local	EHSD_Symbol_Line				= CreateElement "ceSimpleLineObject"
		EHSD_Symbol_Line.name			= "AAR_Zone_3"
		EHSD_Symbol_Line.material   	= stroke_material
		EHSD_Symbol_Line.width       	= EHSD_Line_Thickness
		EHSD_Symbol_Line.init_pos		= {0, 0, 0}
		EHSD_Symbol_Line.parent_element	= "AAR_Zone_3_Pos"
		EHSD_Symbol_Line.controllers    = {{"EHSD_OL1_AAR_3", EHSD_Scale}}
Add_MPCD_Element(EHSD_Symbol_Line)
