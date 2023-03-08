dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/MPD_page_defs.lua")
dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/FLIR/FLIR_Defs.lua")
dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/FLIR/FLIR_tools.lua")

local function SetScreenSpace(object)
	object.h_clip_relation = h_clip_relations.NULL
	object.screenspace = 2
end

local wyptRoot = addPlaceholder("AFLIR_WYPT_symb", {0,0}, nil, {{"MPD_AFLIR_WYPT_MarkerPos", 8192}})
SetScreenSpace(wyptRoot)

local lineW		= 0.0075
local mrkrSz	= 0.03
local mrkrSide	= mrkrSz * math.sqrt(3) * 0.5
local mrkrHoleSz	= mrkrSz - 2*lineW
local mrkrHoleSide	= mrkrHoleSz * math.sqrt(3) * 0.5
local mrkr_indices	= {0,1,3;0,3,5;1,2,4;1,4,3;2,0,5;2,5,4}
local mrkr_vertices	= {	{-mrkrSide, mrkrSz/2}, {mrkrSide, mrkrSz/2}, {0,-mrkrSz}, {-mrkrHoleSide, mrkrHoleSz/2}, {mrkrHoleSide, mrkrHoleSz/2}, {0,-mrkrHoleSz} }
local WyptMarker	= addMesh("MPD_AFLIR_WYPT_MarkerPos", mrkr_vertices, mrkr_indices, {0, 0}, "triangles", wyptRoot.name, nil, "INDICATION_COMMON_WHITE")
SetScreenSpace(WyptMarker)

local fontSz = 0.0042

local	MarkerNum					= CreateElement "ceStringPoly"
		MarkerNum.material			= "font_ATFLIR"
		MarkerNum.alignment			= "LeftBottom"
		MarkerNum.stringdefs		= {fontSz, fontSz,0,0}
		MarkerNum.init_pos			= {0.033, 0.033}
		MarkerNum.formats 			= {"%d"}
		MarkerNum.controllers		= {{"MPD_AFLIR_WYPT_MarkerNum"}}
		MarkerNum.parent_element	= wyptRoot.name
Add(MarkerNum)
SetScreenSpace(MarkerNum)
