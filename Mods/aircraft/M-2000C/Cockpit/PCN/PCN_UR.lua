local my_path = LockOn_Options.script_path.."PCN/"
dofile(my_path.."PCN_definitions.lua")

local half_width   = GetScale()
local half_height  = GetAspect() * half_width

local aspect       = GetAspect() -- GetHalfHeight()/GetHalfWidth()

pcn_ur_base					= CreateElement "ceMeshPoly" -- untextured shape
pcn_ur_base.name			= "PCN_UR"
pcn_ur_base.material		= MakeMaterial(nil,{255,0,0,50})
pcn_ur_base.h_clip_relation	= h_clip_relations.REWRITE_LEVEL
pcn_ur_base.level			= PCN_DEFAULT_LEVEL
pcn_ur_base.collimated		= false
pcn_ur_base.isvisible		= false
pcn_ur_base.z_emable		= true
pcn_ur_base.vertices		= { {-1, aspect}, { 1,aspect}, { 1,-aspect}, {-1,-aspect}, }
pcn_ur_base.indices			=  {0,1,2 ;  0,2,3 }
Add(pcn_ur_base)


-- ** LEFT LCD ** --
local	PCN_UL_DIGITS				= CreateElement "ceStringPoly"
		PCN_UL_DIGITS.name				= "PCN_UL_DIGITS"
		PCN_UL_DIGITS.material			= pcn_gauge_font
		PCN_UL_DIGITS.init_pos			= {-0.20,0.01,0.0} -- -0.1
		PCN_UL_DIGITS.alignment			= "RightCenter"
		PCN_UL_DIGITS.value				= "88888"
		PCN_UL_DIGITS.stringdefs		= pcn_font_size_default
		PCN_UL_DIGITS.controllers		= {{"PCN_UL_DIGITS"}}
Add_PCN_Element(PCN_UL_DIGITS)

local	PCN_UL_POINTS					= CreateElement "ceStringPoly"
		PCN_UL_POINTS.name				= "PCN_UL_POINTS"
		PCN_UL_POINTS.material			= pcn_gauge_font
		PCN_UL_POINTS.init_pos			= {-0.32,0.005,0.0} -- -0.16
		PCN_UL_POINTS.alignment			= "RightCenter"
		PCN_UL_POINTS.value				= "...."
		PCN_UL_POINTS.stringdefs		= pcn_font_size_default
		PCN_UL_POINTS.controllers		= {{"PCN_UL_POINTS"}}
Add_PCN_Element(PCN_UL_POINTS)

local	PCN_UL_N						= CreateElement "ceStringPoly"
		PCN_UL_N.name					= "PCN_UL_N"
		PCN_UL_N.material				= pcn_gauge_font
		PCN_UL_N.init_pos				= {-1, 0.06,0} -- -0.86
		PCN_UL_N.alignment				= "LeftCenter"
		PCN_UL_N.value					= "N"
		PCN_UL_N.stringdefs				= {0.005,0.005}
		PCN_UL_N.controllers 			= {{"PCN_UL_N"}}
Add_PCN_Element(PCN_UL_N)

local	PCN_UL_S						= CreateElement "ceStringPoly"
		PCN_UL_S.name					= "PCN_UL_S"
		PCN_UL_S.material				= pcn_gauge_font
		PCN_UL_S.init_pos				= {-1, -0.04,0} -- -0.86
		PCN_UL_S.alignment				= "LeftCenter"
		PCN_UL_S.value					= "S"
		PCN_UL_S.stringdefs				= {0.005,0.005}
		PCN_UL_S.controllers 			= {{"PCN_UL_S"}}
Add_PCN_Element(PCN_UL_S)

local	PCN_UL_P					= CreateElement "ceStringPoly"
		PCN_UL_P.name				= "PCN_UL_P"
		PCN_UL_P.material			= pcn_gauge_font
		PCN_UL_P.init_pos			= {-0.94, 0.06,0} -- -0.8 0.04
		PCN_UL_P.alignment			= "LeftCenter"
		PCN_UL_P.value				= "+"
		PCN_UL_P.stringdefs			= {0.005,0.005}
		PCN_UL_P.controllers 		= {{"PCN_UL_P"}}
Add_PCN_Element(PCN_UL_P)

local	PCN_UL_M					= CreateElement "ceStringPoly"
		PCN_UL_M.name				= "PCN_UL_M"
		PCN_UL_M.material			= pcn_gauge_font
		PCN_UL_M.init_pos			= {-0.94, -0.04,0} -- -0.8
		PCN_UL_M.alignment			= "LeftCenter"
		PCN_UL_M.value				= "-"
		PCN_UL_M.stringdefs			= {0.005,0.005}
		PCN_UL_M.controllers 		= {{"PCN_UL_M"}}
Add_PCN_Element(PCN_UL_M)




-- ** RIGHT LCD ** --+
local	PCN_UR_DIGITS					= CreateElement "ceStringPoly"
		PCN_UR_DIGITS.name				= "PCN_UR_DIGITS"
		PCN_UR_DIGITS.material			= pcn_gauge_font
		PCN_UR_DIGITS.init_pos			= {0.85,0.01,0}
		PCN_UR_DIGITS.alignment			= "RightCenter"
		PCN_UR_DIGITS.formats			= {"888888"}
		PCN_UR_DIGITS.stringdefs		= pcn_font_size_default
		PCN_UR_DIGITS.controllers		= {{"PCN_UR_DIGITS"}}
Add_PCN_Element(PCN_UR_DIGITS)

local	PCN_UR_POINTS					= CreateElement "ceStringPoly"
		PCN_UR_POINTS.name				= "PCN_UR_POINTS"
		PCN_UR_POINTS.material			= pcn_gauge_font
		PCN_UR_POINTS.init_pos			= {0.73,0.005,0.0}
		PCN_UR_POINTS.alignment			= "RightCenter"
		PCN_UR_POINTS.value				= "....."
		PCN_UR_POINTS.stringdefs		= pcn_font_size_default
		PCN_UR_POINTS.controllers		= {{"PCN_UR_POINTS"}}
Add_PCN_Element(PCN_UR_POINTS)

local	PCN_UR_E						= CreateElement "ceStringPoly"
		PCN_UR_E.name					= "PCN_UR_E"
		PCN_UR_E.material				= pcn_gauge_font
		PCN_UR_E.init_pos				= {-0.1, 0.06,0} -- 0.06
		PCN_UR_E.alignment				= "LeftCenter"
		PCN_UR_E.value					= "E"
		PCN_UR_E.stringdefs				= {0.005,0.005}
		PCN_UR_E.controllers 			= {{"PCN_UR_E"}}
Add_PCN_Element(PCN_UR_E)

local	PCN_UR_W						= CreateElement "ceStringPoly"
		PCN_UR_W.name					= "PCN_UR_W"
		PCN_UR_W.material				= pcn_gauge_font
		PCN_UR_W.init_pos				= {-0.1, -0.04,0} -- 0.06
		PCN_UR_W.alignment				= "LeftCenter"
		PCN_UR_W.value					= "W"
		PCN_UR_W.stringdefs				= {0.005,0.005}
		PCN_UR_W.controllers 			= {{"PCN_UR_W"}}
Add_PCN_Element(PCN_UR_W)

local	PCN_UR_P						= CreateElement "ceStringPoly"
		PCN_UR_P.name					= "PCN_UR_P"
		PCN_UR_P.material				= pcn_gauge_font
		PCN_UR_P.init_pos				= {-0.04, 0.06,0} -- 0.12 0.04
		PCN_UR_P.alignment				= "LeftCenter"
		PCN_UR_P.value					= "+"
		PCN_UR_P.stringdefs				= {0.005,0.005}
		PCN_UR_P.controllers 			= {{"PCN_UR_P"}}
Add_PCN_Element(PCN_UR_P)

local	PCN_UR_M						= CreateElement "ceStringPoly"
		PCN_UR_M.name					= "PCN_UR_M"
		PCN_UR_M.material				= pcn_gauge_font
		PCN_UR_M.init_pos				= {-0.04, -0.04,0} -- 0.12 -0.04
		PCN_UR_M.alignment				= "LeftCenter"
		PCN_UR_M.value					= "-"
		PCN_UR_M.stringdefs				= {0.005,0.005}
		PCN_UR_M.controllers 			= {{"PCN_UR_M"}}
Add_PCN_Element(PCN_UR_M)


