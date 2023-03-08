-------------------------
-- EHSD Page           --
-- Navigation          --
-- Route Lines Display --
-------------------------
local EHSD_Scale = 0.5 * GetHalfHeight()
local EHSD_Line_Thickness		= stroke_thickness * 3.5
local EHSD_Line_OL_Thickness	= DMC_outline_thickness * 3.5
local half_x  = 0.5 * 1024 * mils_ratio
local half_y  = 0.5 * 4 * mils_ratio

-- Symbols Centers
local	MPCD_center					= CreateElement "ceSimple"
		MPCD_center.name			= "MPCD_center"
		MPCD_center.init_pos		= {0, 0, 0}
		MPCD_center.controllers		= {{"EHSD_Compass_Rose_Center", -0.05}}
Add_MPCD_Element(MPCD_center)

-- Mission Route
local	EHSD_Symbol_Line				= CreateElement "ceSimpleLineObject"
		EHSD_Symbol_Line.name			= "Mission_Route_Line_OL"
		EHSD_Symbol_Line.material		= stroke_material_outl
		EHSD_Symbol_Line.width       	= EHSD_Line_OL_Thickness
		EHSD_Symbol_Line.init_pos		= {0, 0, 0}
		EHSD_Symbol_Line.parent_element	= "MPCD_center"
		EHSD_Symbol_Line.controllers	= {{"EHSD_Route_Line", EHSD_Scale, 0}}
Add_MPCD_Element(EHSD_Symbol_Line)

local	EHSD_Symbol_Line				= CreateElement "ceSimpleLineObject"
		EHSD_Symbol_Line.name			= "Mission_Route_Line"
		EHSD_Symbol_Line.material   	= stroke_material
		EHSD_Symbol_Line.width       	= EHSD_Line_Thickness
		EHSD_Symbol_Line.init_pos		= {0, 0, 0}
		EHSD_Symbol_Line.parent_element	= "MPCD_center"
		EHSD_Symbol_Line.controllers    = {{"EHSD_Route_Line", EHSD_Scale, 1}}
Add_MPCD_Element(EHSD_Symbol_Line)

-- TERM Route
local	EHSD_Symbol_Line				= CreateElement "ceSimpleLineObject"
		EHSD_Symbol_Line.name			= "TERM_Route_Line_OL"
		EHSD_Symbol_Line.material		= stroke_material_outl
		EHSD_Symbol_Line.width       	= EHSD_Line_OL_Thickness
		EHSD_Symbol_Line.init_pos		= {0, 0, 0}
		EHSD_Symbol_Line.parent_element	= "MPCD_center"
		EHSD_Symbol_Line.controllers	= {{"EHSD_TERM_Route", EHSD_Scale, 0}}
Add_MPCD_Element(EHSD_Symbol_Line)

local	EHSD_Symbol_Line				= CreateElement "ceSimpleLineObject"
		EHSD_Symbol_Line.name			= "TERM_Route_Line"
		EHSD_Symbol_Line.material   	= stroke_material
		EHSD_Symbol_Line.width       	= EHSD_Line_Thickness
		EHSD_Symbol_Line.init_pos		= {0, 0, 0}
		EHSD_Symbol_Line.parent_element	= "MPCD_center"
		EHSD_Symbol_Line.controllers    = {{"EHSD_TERM_Route", EHSD_Scale, 1}}
Add_MPCD_Element(EHSD_Symbol_Line)

-- NSEQ Route
local	EHSD_Symbol_Line				= CreateElement "ceSimpleLineObject"
		EHSD_Symbol_Line.name			= "NNSEQ_IGR_Route_Line_OL"
		EHSD_Symbol_Line.material		= stroke_material_outl
		EHSD_Symbol_Line.width       	= EHSD_Line_OL_Thickness
		EHSD_Symbol_Line.init_pos		= {0, 0, 0}
		EHSD_Symbol_Line.parent_element	= "MPCD_center"
		EHSD_Symbol_Line.controllers	= {{"EHSD_NSEQ_Route_IGRS", EHSD_Scale, 0}}
Add_MPCD_Element(EHSD_Symbol_Line)

local	EHSD_Symbol_Line				= CreateElement "ceSimpleLineObject"
		EHSD_Symbol_Line.name			= "NSEQ_IGR_Route_Line"
		EHSD_Symbol_Line.material   	= stroke_material
		EHSD_Symbol_Line.width       	= EHSD_Line_Thickness
		EHSD_Symbol_Line.init_pos		= {0, 0, 0}
		EHSD_Symbol_Line.parent_element	= "MPCD_center"
		EHSD_Symbol_Line.controllers    = {{"EHSD_NSEQ_Route_IGRS", EHSD_Scale, 1}}
Add_MPCD_Element(EHSD_Symbol_Line)

local	EHSD_Symbol_Line				= CreateElement "ceSimpleLineObject"
		EHSD_Symbol_Line.name			= "NSEQ_EGR_Route_Line_OL"
		--EHSD_Symbol_Line.material		= stroke_material_outl
		EHSD_Symbol_Line.material		= mpcd_ehsd_nseq_lines_ebg
		EHSD_Symbol_Line.tex_params		= {{0, 0.5}, {1, 0.5}, {1/(2 * half_x), 1}}
		EHSD_Symbol_Line.vertices		= { {0, 0}, {2 * half_x, 0} }
		EHSD_Symbol_Line.width       	= EHSD_Line_OL_Thickness
		EHSD_Symbol_Line.init_pos		= {0, 0, 0}
		EHSD_Symbol_Line.parent_element	= "MPCD_center"
		EHSD_Symbol_Line.controllers	= {{"EHSD_NSEQ_Route_EGRS", EHSD_Scale, 0}}
Add_MPCD_Element(EHSD_Symbol_Line)

local	EHSD_Symbol_Line				= CreateElement "ceSimpleLineObject"
		EHSD_Symbol_Line.name			= "NSEQ_EGR_Route_Line"
		--EHSD_Symbol_Line.material   	= stroke_material
		EHSD_Symbol_Line.material		= mpcd_ehsd_nseq_lines_egr
		EHSD_Symbol_Line.tex_params		= {{0, 0.5}, {1, 0.5}, {1/(2 * half_x), 1}}
		EHSD_Symbol_Line.vertices		= { {0, 0}, {2 * half_x, 0} }
		EHSD_Symbol_Line.width       	= EHSD_Line_Thickness
		EHSD_Symbol_Line.init_pos		= {0, 0, 0}
		EHSD_Symbol_Line.parent_element	= "MPCD_center"
		EHSD_Symbol_Line.controllers    = {{"EHSD_NSEQ_Route_EGRS", EHSD_Scale, 1}}
Add_MPCD_Element(EHSD_Symbol_Line)
