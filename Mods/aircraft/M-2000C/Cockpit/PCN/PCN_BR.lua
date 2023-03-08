local my_path = LockOn_Options.script_path.."PCN/"
dofile(my_path.."PCN_definitions.lua")

local half_width   = GetScale()
local half_height  = GetAspect() * half_width
local aspect       = GetAspect() -- GetHalfHeight()/GetHalfWidth()

pcn_br_base					= CreateElement "ceMeshPoly" -- untextured shape
pcn_br_base.name			= "PCN_BR"
pcn_br_base.material		= MakeMaterial(nil,{255,0,0,50})
pcn_br_base.h_clip_relation	= h_clip_relations.REWRITE_LEVEL
pcn_br_base.level			= PCN_DEFAULT_LEVEL
pcn_br_base.collimated		= false
pcn_br_base.isvisible		= false
pcn_br_base.z_emable		= true
pcn_br_base.vertices		= { {-1, aspect}, { 1,aspect}, { 1,-aspect}, {-1,-aspect}, }
pcn_br_base.indices			=  {0,1,2 ;  0,2,3 }
Add(pcn_br_base)


local PCN_BL_DIGITS				= CreateElement "ceStringPoly"
PCN_BL_DIGITS.name				= "PCN_BL_DIGITS"
PCN_BL_DIGITS.material			= pcn_gauge_font
PCN_BL_DIGITS.init_pos			= {-0.2,0.060}
PCN_BL_DIGITS.alignment			= "RightCenter"
PCN_BL_DIGITS.value				= "88"
PCN_BL_DIGITS.stringdefs		= pcn_font_size_default
PCN_BL_DIGITS.controllers 		= {{"PCN_BL_DIGITS"}}
Add_PCN_Element(PCN_BL_DIGITS)

local PCN_BR_DIGITS				= CreateElement "ceStringPoly"
PCN_BR_DIGITS.name				= "PCN_BR_DIGITS"
PCN_BR_DIGITS.material			= pcn_gauge_font
PCN_BR_DIGITS.init_pos			= {1,0.070}
PCN_BR_DIGITS.alignment			= "RightCenter"
PCN_BR_DIGITS.formats			= "88"
PCN_BR_DIGITS.stringdefs		= pcn_font_size_default
PCN_BR_DIGITS.controllers 		= {{"PCN_BR_DIGITS"}}
Add_PCN_Element(PCN_BR_DIGITS)
