dofile(LockOn_Options.script_path.."TV-Indicator/Indicator/definitions.lua")

function AddElement(object)
    object.use_mipfilter    = true
	object.additive_alpha   = true
	object.h_clip_relation  = h_clip_relations.COMPARE
	object.level			= HUD_DEFAULT_LEVEL
    Add(object)
end

function AddStaticSight(_texturepath,_showparametername)
	local _MATERIAL   			= MakeMaterial(_texturepath,BASE_COLOR2) -- image of the fixed net

	local sight_origin	         = CreateElement "ceSimple"
	sight_origin.name 		     = create_guid_string() -- no such function in this script. Not in definitions.lua either. Could be in elements_defs.lua
	sight_origin.collimated 		 = true
	AddElement(sight_origin)

	local _sight_full_radius =  100 -- is this the radius of "HUD/net view field"? Units (pixels or angular units)?
	local _sight_shift  = -0 -- explain shift?
	local _sight_radius =  100 + _sight_shift

	local sight	    = CreateElement "ceTexPoly" --this could be the text area on HUD
	sight.name 		= create_guid_string() -- this must be external function call.
	sight.vertices   = {{-_sight_full_radius, _sight_full_radius},
					{ _sight_full_radius, _sight_full_radius},
					{ _sight_full_radius,-_sight_full_radius},
					{-_sight_full_radius,-_sight_full_radius}}
	sight.indices	= {0,1,2,2,3,0}
	sight.tex_coords = {{0,0},{1,0},{1,1},{0,1}}
	sight.material   = _MATERIAL	   
	sight.init_pos   = {0,0} 
	sight.additive_alpha  = true
	sight.collimated = true
	sight.element_params   = {_showparametername} 
								   
	sight.controllers 	   = {{"parameter_in_range"	,0,0.9,1.1},--check that piper available using WS_GUN_PIPER_AVAILABLE
								 }
	sight.parent_element = sight_origin.name
--AddElement(sight)

end

-- FPM/TVV
local BASE_COLOR  = {0,0  ,0,0}
local BASE_COLOR2 = {255  ,255,255,255} --128,165,0,120
local GRID_   			= MakeMaterial(LockOn_Options.script_path.."../resources/IndicationTextures/MeatBall.tga",BASE_COLOR2) -- image of the fixed net
local BASE_COLOR_MAT    = MakeMaterial(nil,BASE_COLOR)

local shape_rotation = 0

shape_rotation = math.tan(shape_rotation/57.3) * 1000 -- to mils -- NOTE: this does nothing currently, returns 0


local full_radius =  45 -- is this the radius of "HUD/net view field"? Units (pixels or angular units)?
local grid_shift  = 0---35 -- explain shift?
local grid_radius =  full_radius + grid_shift

local grid_origin	         = CreateElement "ceSimple"
grid_origin.name 		     = create_guid_string() -- no such function in this script. Not in definitions.lua either. Could be in elements_defs.lua
grid_origin.collimated 		 = true
AddElement(grid_origin)

local grid	    = CreateElement "ceTexPoly" --this could be the text area on HUD
grid.name 		= create_guid_string() -- this must be external function call.
grid.vertices   = {{-grid_radius, grid_radius},
				   { grid_radius, grid_radius},
				   { grid_radius,-grid_radius},
				   {-grid_radius,-grid_radius}}
grid.indices	= {0,1,2,2,3,0}
grid.tex_coords = {{0,0},{1,0},{1,1},{0,1}}
grid.material   = GRID_	   
grid.init_pos   = {0,grid_shift + shape_rotation} 
grid.additive_alpha  = true
grid.collimated = true
grid.element_params   = {"FARTVEKTOR_SHOW",
								   "HUD_BETA_PARAM",
								   "HUD_ALPHA_PARAM"} 
								   
grid.controllers 	   = {{"parameter_in_range"				,0,0.9,1.1},--check that piper available using WS_GUN_PIPER_AVAILABLE
								  {"move_left_right_using_parameter",1, 1 },	--azimuth move by WS_GUN_PIPER_AZIMUTH , 0.73 is default collimator distance (from eye to HUD plane)
								  {"move_up_down_using_parameter"   ,2, 1 }, --elevation move by WS_GUN_PIPER_ELEVATION
								 }--rotate_using_parameter
grid.parent_element = grid_origin.name 
--AddElement(grid)

-- LADDER
local _LADDER   			= MakeMaterial(LockOn_Options.script_path.."../resources/IndicationTextures/Ladder0.tga",BASE_COLOR2) -- image of the fixed net

local ladder_origin	         = CreateElement "ceSimple"
ladder_origin.name 		     = create_guid_string() -- no such function in this script. Not in definitions.lua either. Could be in elements_defs.lua
ladder_origin.collimated 		 = true
AddElement(ladder_origin)

local ladder_full_radius =  270 -- is this the radius of "HUD/net view field"? Units (pixels or angular units)?
local ladder_shift  = -0 -- explain shift?
local ladder_radius =  ladder_full_radius + ladder_shift

local ladder	    = CreateElement "ceTexPoly" --this could be the text area on HUD
ladder.name 		= create_guid_string() -- this must be external function call.
ladder.vertices   = {{-ladder_radius, ladder_radius},
				   { ladder_radius, ladder_radius},
				   { ladder_radius,-ladder_radius},
				   {-ladder_radius,-ladder_radius}}
ladder.indices	= {0,1,2,2,3,0}
ladder.tex_coords = {{0,0},{1,0},{1,1},{0,1}}
ladder.material   = _LADDER	   
ladder.init_pos   = {0,grid_shift + shape_rotation} 
ladder.additive_alpha  = true
ladder.collimated = true
ladder.element_params   = {"KONSTHORIZ_SHOW",
								   "HUD_LAD0HORIZ_PARAM",
								   "HUD_PITCH_PARAM",
								   "HUD_ROLL_PARAM"} 
								   
ladder.controllers 	   = {{"parameter_in_range"				,0,0.9,1.1},--check that piper available using WS_GUN_PIPER_AVAILABLE
								  {"move_left_right_using_parameter",1, 1 },	--azimuth move by WS_GUN_PIPER_AZIMUTH , 0.73 is default collimator distance (from eye to HUD plane)
								  {"move_up_down_using_parameter"   ,2, 1 }, --elevation move by WS_GUN_PIPER_ELEVATION
								  {"rotate_using_parameter"			,3, 1 }, -- ROTATION FTW!!!!
								 }
ladder.parent_element = ladder_origin.name
--AddElement(ladder)


-- LADDER 5 deg (for debug)
local _LADDER5d   			= MakeMaterial(LockOn_Options.script_path.."../resources/IndicationTextures/Ladder+10.tga",BASE_COLOR2) -- image of the fixed net

local ladder5d_origin	         = CreateElement "ceSimple"
ladder5d_origin.name 		     = create_guid_string() -- no such function in this script. Not in definitions.lua either. Could be in elements_defs.lua
ladder5d_origin.collimated 		 = true
AddElement(ladder5d_origin)

local ladder5d_full_radius =  100 -- is this the radius of "HUD/net view field"? Units (pixels or angular units)?
local ladder5d_shift  = -0 -- explain shift?
local ladder5d_radius =  ladder5d_full_radius + ladder5d_shift

local ladder5d	    = CreateElement "ceTexPoly" --this could be the text area on HUD
ladder5d.name 		= create_guid_string() -- this must be external function call.
ladder5d.vertices   = {{-ladder_radius, ladder_radius},
				   { ladder_radius, ladder_radius},
				   { ladder_radius,-ladder_radius},
				   {-ladder_radius,-ladder_radius}}
ladder5d.indices	= {0,1,2,2,3,0}
ladder5d.tex_coords = {{0,0},{1,0},{1,1},{0,1}}
ladder5d.material   = _LADDER5d	   
ladder5d.init_pos   = {0,grid_shift + shape_rotation} 
ladder5d.additive_alpha  = true
ladder5d.collimated = true
ladder5d.element_params   = {"KONSTHORIZ_SHOW",
								   "HUD_LAD0HORIZ_PARAM",
								   "HUD_LADp5Y_PARAM",
								   "HUD_ROLL_PARAM"} 
								   
ladder5d.controllers 	   = {{"parameter_in_range"				,0,0.9,1.1},--check that piper available using WS_GUN_PIPER_AVAILABLE
								  {"move_left_right_using_parameter",1, 1 },	--azimuth move by WS_GUN_PIPER_AZIMUTH , 0.73 is default collimator distance (from eye to HUD plane)
								  {"move_up_down_using_parameter"   ,2, 1 }, --elevation move by WS_GUN_PIPER_ELEVATION
								  {"rotate_using_parameter"			,3, 1 }, -- ROTATION FTW!!!!
								 }
ladder5d.parent_element = ladder5d_origin.name
--AddElement(ladder5d)

-- 2DEG STOLPAR
local _TVAGRADSTOLP   			= MakeMaterial(LockOn_Options.script_path.."../resources/IndicationTextures/2grader thin.tga",BASE_COLOR2) -- image of the fixed net

local tvagradstolp_origin	         = CreateElement "ceSimple"
tvagradstolp_origin.name 		     = create_guid_string() -- no such function in this script. Not in definitions.lua either. Could be in elements_defs.lua
tvagradstolp_origin.collimated 		 = true
AddElement(tvagradstolp_origin)

local tvagradstolp_full_radius =  150 -- is this the radius of "HUD/net view field"? Units (pixels or angular units)?
local tvagradstolp_shift  = -0 -- explain shift?
local tvagradstolp_radius =  tvagradstolp_full_radius + tvagradstolp_shift

local tvagradstolp	    = CreateElement "ceTexPoly" --this could be the text area on HUD
tvagradstolp.name 		= create_guid_string() -- this must be external function call.
tvagradstolp.vertices   = {{-tvagradstolp_radius, tvagradstolp_radius},
				   { tvagradstolp_radius, tvagradstolp_radius},
				   { tvagradstolp_radius,-tvagradstolp_radius},
				   {-tvagradstolp_radius,-tvagradstolp_radius}}
tvagradstolp.indices	= {0,1,2,2,3,0}
tvagradstolp.tex_coords = {{0,0},{1,0},{1,1},{0,1}}
tvagradstolp.material   = _TVAGRADSTOLP	   
tvagradstolp.init_pos   = {0,tvagradstolp_shift + shape_rotation} 
tvagradstolp.additive_alpha  = true
tvagradstolp.collimated = true
tvagradstolp.element_params   = {"2GRADSTOLP_SHOW","HUD_ROLL_PARAM",
								   "HUD_BETA_PARAM",
								   "RIKTPRICK_Y"} 
								   
tvagradstolp.controllers 	   = {{"parameter_in_range"				,0,0.9,1.1},--check that piper available using WS_GUN_PIPER_AVAILABLE
								 	{"rotate_using_parameter", 1, 1},
									  {"move_left_right_using_parameter",2, 1 },	--azimuth move by WS_GUN_PIPER_AZIMUTH , 0.73 is default collimator distance (from eye to HUD plane)
								  {"move_up_down_using_parameter"   ,3, 1 },}
tvagradstolp.parent_element = tvagradstolp_origin.name
--AddElement(tvagradstolp)


-- Referensstolpar (för avstånd)
local _REFSTOLPAR   			= MakeMaterial(LockOn_Options.script_path.."../resources/IndicationTextures/Refstolpe.tga",BASE_COLOR2) -- image of the fixed net

local refstolpar_origin	         = CreateElement "ceSimple"
refstolpar_origin.name 		     = create_guid_string() -- no such function in this script. Not in definitions.lua either. Could be in elements_defs.lua
refstolpar_origin.collimated 		 = true
AddElement(refstolpar_origin)

local refstolpar_full_radius =  150 -- is this the radius of "HUD/net view field"? Units (pixels or angular units)?
local refstolpar_shift  = -0 -- explain shift?
local refstolpar_radius =  refstolpar_full_radius + refstolpar_shift

local refstolpar	    = CreateElement "ceTexPoly" --this could be the text area on HUD
refstolpar.name 		= create_guid_string() -- this must be external function call.
refstolpar.vertices   = {{-refstolpar_radius, refstolpar_radius},
				   { refstolpar_radius, refstolpar_radius},
				   { refstolpar_radius,-refstolpar_radius},
				   {-refstolpar_radius,-refstolpar_radius}}
refstolpar.indices	= {0,1,2,2,3,0}
refstolpar.tex_coords = {{0,0},{1,0},{1,1},{0,1}}
refstolpar.material   = _REFSTOLPAR	   
refstolpar.init_pos   = {0,refstolpar_shift + shape_rotation} 
refstolpar.additive_alpha  = true
refstolpar.collimated = true
refstolpar.element_params   = {"REFSTOLPAR_SHOW","HUD_ROLL_PARAM",
								   "HUD_BETA_PARAM",
								   "RIKTPRICK_Y"}  
								   
refstolpar.controllers 	   = {{"parameter_in_range"				,0,0.9,1.1},--check that piper available using WS_GUN_PIPER_AVAILABLE
								 	{"rotate_using_parameter", 1, 1},
									{"move_left_right_using_parameter",2, 1 },	--azimuth move by WS_GUN_PIPER_AZIMUTH , 0.73 is default collimator distance (from eye to HUD plane)
								  {"move_up_down_using_parameter"   ,3, 1 }}
refstolpar.parent_element = refstolpar_origin.name
--AddElement(refstolpar)


-- Riktprick
AddStaticSight(LockOn_Options.script_path.."../resources/IndicationTextures/Ritprick.tga","RIKTPRICK_SHOW")
local _RIKTPRICK   			= MakeMaterial(LockOn_Options.script_path.."../resources/IndicationTextures/Ritprick.tga",BASE_COLOR2) -- image of the fixed net

local riktprick_origin	         = CreateElement "ceSimple"
riktprick_origin.name 		     = create_guid_string() -- no such function in this script. Not in definitions.lua either. Could be in elements_defs.lua
riktprick_origin.collimated 		 = true
AddElement(riktprick_origin)

local riktprick_full_radius =  150 -- is this the radius of "HUD/net view field"? Units (pixels or angular units)?
local riktprick_shift  = -0 -- explain shift?
local riktprick_radius =  riktprick_full_radius + riktprick_shift

local riktprick	    = CreateElement "ceTexPoly" --this could be the text area on HUD
riktprick.name 		= create_guid_string() -- this must be external function call.
riktprick.vertices   = {{-riktprick_radius, riktprick_radius},
				   { riktprick_radius, riktprick_radius},
				   { riktprick_radius,-riktprick_radius},
				   {-riktprick_radius,-riktprick_radius}}
riktprick.indices	= {0,1,2,2,3,0}
riktprick.tex_coords = {{0,0},{1,0},{1,1},{0,1}}
riktprick.material   = _RIKTPRICK	   
riktprick.init_pos   = {0,riktprick_shift + shape_rotation} 
riktprick.additive_alpha  = true
riktprick.collimated = true
riktprick.element_params   = {"RIKTPRICK_SHOW","HUD_ROLL_PARAM", 
								   "HUD_BETA_PARAM",
								   "RIKTPRICK_Y" } 
								   
riktprick.controllers 	   = {{"parameter_in_range"				,0,0.9,1.1},--check that piper available using WS_GUN_PIPER_AVAILABLE
								{"rotate_using_parameter", 1, 1},
									{"move_left_right_using_parameter",2, 1 },									
									{"move_up_down_using_parameter"   ,3, 1 }}
riktprick.parent_element = riktprick_origin.name
--AddElement(riktprick)



-- AVFYRNINGSORDER
local _avfyrningsorder   			= MakeMaterial(LockOn_Options.script_path.."../resources/IndicationTextures/Avfyrningsorder.tga",BASE_COLOR2) -- image of the fixed net

local avfyrningsorder_origin	         = CreateElement "ceSimple"
avfyrningsorder_origin.name 		     = create_guid_string() -- no such function in this script. Not in definitions.lua either. Could be in elements_defs.lua
avfyrningsorder_origin.collimated 		 = true
AddElement(avfyrningsorder_origin)

local avfyrningsorder_full_radius =  150 -- is this the radius of "HUD/net view field"? Units (pixels or angular units)?
local avfyrningsorder_shift  = -0 -- explain shift?
local avfyrningsorder_radius =  avfyrningsorder_full_radius + avfyrningsorder_shift

local avfyrningsorder	    = CreateElement "ceTexPoly" --this could be the text area on HUD
avfyrningsorder.name 		= create_guid_string() -- this must be external function call.
avfyrningsorder.vertices   = {{-avfyrningsorder_radius, avfyrningsorder_radius},
				   { avfyrningsorder_radius, avfyrningsorder_radius},
				   { avfyrningsorder_radius,-avfyrningsorder_radius},
				   {-avfyrningsorder_radius,-avfyrningsorder_radius}}
avfyrningsorder.indices	= {0,1,2,2,3,0}
avfyrningsorder.tex_coords = {{0,0},{1,0},{1,1},{0,1}}
avfyrningsorder.material   = _avfyrningsorder	   
avfyrningsorder.init_pos   = {0,avfyrningsorder_shift + shape_rotation} 
avfyrningsorder.additive_alpha  = true
avfyrningsorder.collimated = true
avfyrningsorder.element_params   = {"AVFYRNINGSORDER_SHOW",
									"HUD_ROLL_PARAM", 
								   "HUD_BETA_PARAM",
								   "RIKTPRICK_Y" } 
								   
avfyrningsorder.controllers 	   = {{"parameter_in_range"				,0,0.9,1.1},--check that piper available using WS_GUN_PIPER_AVAILABLE
								 	{"rotate_using_parameter", 1, 1},
									{"move_left_right_using_parameter",2, 1 },									
									{"move_up_down_using_parameter"   ,3, 1 }}
avfyrningsorder.parent_element = avfyrningsorder_origin.name
--AddElement(avfyrningsorder)


-- TIDSLINJE WHOLE
local _tidslinje   			= MakeMaterial(LockOn_Options.script_path.."../resources/IndicationTextures/tidslinje thin.tga",BASE_COLOR2) -- image of the fixed net

local tidslinje_origin	         = CreateElement "ceSimple"
tidslinje_origin.name 		     = create_guid_string() -- no such function in this script. Not in definitions.lua either. Could be in elements_defs.lua
tidslinje_origin.collimated 		 = true
AddElement(tidslinje_origin)

local tidslinje_full_radius =  150 -- is this the radius of "HUD/net view field"? Units (pixels or angular units)?
local tidslinje_shift  = -0 -- explain shift?
local tidslinje_radius =  tidslinje_full_radius + tidslinje_shift

local tidslinje	    = CreateElement "ceTexPoly" --this could be the text area on HUD
tidslinje.name 		= create_guid_string() -- this must be external function call.
tidslinje.vertices   = {{-tidslinje_radius, tidslinje_radius},
				   { tidslinje_radius, tidslinje_radius},
				   { tidslinje_radius,-tidslinje_radius},
				   {-tidslinje_radius,-tidslinje_radius}}
tidslinje.indices	= {0,1,2,2,3,0}
tidslinje.tex_coords = {{0,0},{1,0},{1,1},{0,1}}
tidslinje.material   = _tidslinje	   
tidslinje.init_pos   = {0,tidslinje_shift + shape_rotation} 
tidslinje.additive_alpha  = true
tidslinje.collimated = true
tidslinje.element_params   = {"TIDSLINJE_SHOW","HUD_ROLL_PARAM", 
								   "HUD_BETA_PARAM",
								   "RIKTPRICK_Y" } 
								   
tidslinje.controllers 	   = {{"parameter_in_range"				,0,0.9,1.1},--check that piper available using WS_GUN_PIPER_AVAILABLE
								{"rotate_using_parameter", 1, 1},
									{"move_left_right_using_parameter",2, 1 },									
									{"move_up_down_using_parameter"   ,3, 1 }}
tidslinje.parent_element = tidslinje_origin.name
--AddElement(tidslinje)


-- TIDSLINJE CORRECT DISTANCE
local _tidslinjeC   			= MakeMaterial(LockOn_Options.script_path.."../resources/IndicationTextures/tidslinjeC thin.tga",BASE_COLOR2) -- image of the fixed net

local tidslinjeC_origin	         = CreateElement "ceSimple"
tidslinjeC_origin.name 		     = create_guid_string() -- no such function in this script. Not in definitions.lua either. Could be in elements_defs.lua
tidslinjeC_origin.collimated 		 = true
AddElement(tidslinjeC_origin)

local tidslinjeC_full_radius =  150 -- is this the radius of "HUD/net view field"? Units (pixels or angular units)?
local tidslinjeC_shift  = -0 -- explain shift?
local tidslinjeC_radius =  tidslinjeC_full_radius + tidslinjeC_shift

local tidslinjeC	    = CreateElement "ceTexPoly" --this could be the text area on HUD
tidslinjeC.name 		= create_guid_string() -- this must be external function call.
tidslinjeC.vertices   = {{-tidslinjeC_radius, tidslinjeC_radius},
				   { tidslinjeC_radius, tidslinjeC_radius},
				   { tidslinjeC_radius,-tidslinjeC_radius},
				   {-tidslinjeC_radius,-tidslinjeC_radius}}
tidslinjeC.indices	= {0,1,2,2,3,0}
tidslinjeC.tex_coords = {{0,0},{1,0},{1,1},{0,1}}
tidslinjeC.material   = _tidslinjeC	   
tidslinjeC.init_pos   = {0,tidslinjeC_shift + shape_rotation} 
tidslinjeC.additive_alpha  = true
tidslinjeC.collimated = true
tidslinjeC.element_params   = {"TIDSLINJEC_SHOW","HUD_ROLL_PARAM", 
								   "HUD_BETA_PARAM",
								   "RIKTPRICK_Y" } 
								   
tidslinjeC.controllers 	   = {{"parameter_in_range"				,0,0.9,1.1},--check that piper available using WS_GUN_PIPER_AVAILABLE
								 {"rotate_using_parameter"   ,1, 1 },
									{"move_left_right_using_parameter",2, 1 },									
									{"move_up_down_using_parameter"   ,3, 1 }}
tidslinjeC.parent_element = tidslinjeC_origin.name
--AddElement(tidslinjeC)


-- TIDSLINJE SHORT DISTANCE
local _tidslinjeB   			= MakeMaterial(LockOn_Options.script_path.."../resources/IndicationTextures/tidslinjeB thin.tga",BASE_COLOR2) -- image of the fixed net

local tidslinjeB_origin	         = CreateElement "ceSimple"
tidslinjeB_origin.name 		     = create_guid_string() -- no such function in this script. Not in definitions.lua either. Could be in elements_defs.lua
tidslinjeB_origin.collimated 		 = true
AddElement(tidslinjeB_origin)

local tidslinjeB_full_radius =  150 -- is this the radius of "HUD/net view field"? Units (pixels or angular units)?
local tidslinjeB_shift  = -0 -- explain shift?
local tidslinjeB_radius =  tidslinjeB_full_radius + tidslinjeB_shift

local tidslinjeB	    = CreateElement "ceTexPoly" --this could be the text area on HUD
tidslinjeB.name 		= create_guid_string() -- this must be external function call.
tidslinjeB.vertices   = {{-tidslinjeB_radius, tidslinjeB_radius},
				   { tidslinjeB_radius, tidslinjeB_radius},
				   { tidslinjeB_radius,-tidslinjeB_radius},
				   {-tidslinjeB_radius,-tidslinjeB_radius}}
tidslinjeB.indices	= {0,1,2,2,3,0}
tidslinjeB.tex_coords = {{0,0},{1,0},{1,1},{0,1}}
tidslinjeB.material   = _tidslinjeB	   
tidslinjeB.init_pos   = {0,tidslinjeB_shift + shape_rotation} 
tidslinjeB.additive_alpha  = true
tidslinjeB.collimated = true
tidslinjeB.element_params   = {"TIDSLINJEB_SHOW","HUD_ROLL_PARAM", 
								   "HUD_BETA_PARAM",
								   "RIKTPRICK_Y" } 
								   
tidslinjeB.controllers 	   = {{"parameter_in_range"				,0,0.9,1.1},--check that piper available using WS_GUN_PIPER_AVAILABLE
								 {"rotate_using_parameter"   ,1, 1 },
									{"move_left_right_using_parameter",2, 1 },									
									{"move_up_down_using_parameter"   ,3, 1 }}
tidslinjeB.parent_element = tidslinjeB_origin.name
--AddElement(tidslinjeB)


-- VERTIKAL STOLPAR
local _vertikalastolpar   			= MakeMaterial(LockOn_Options.script_path.."../resources/IndicationTextures/Vertikala thin.tga",BASE_COLOR2) -- image of the fixed net

local vertikalastolpar_origin	         = CreateElement "ceSimple"
vertikalastolpar_origin.name 		     = create_guid_string() -- no such function in this script. Not in definitions.lua either. Could be in elements_defs.lua
vertikalastolpar_origin.collimated 		 = true
AddElement(vertikalastolpar_origin)

local vertikalastolpar_full_radius =  150 -- is this the radius of "HUD/net view field"? Units (pixels or angular units)?
local vertikalastolpar_shift  = -0 -- explain shift?
local vertikalastolpar_radius =  vertikalastolpar_full_radius + vertikalastolpar_shift

local vertikalastolpar	    = CreateElement "ceTexPoly" --this could be the text area on HUD
vertikalastolpar.name 		= create_guid_string() -- this must be external function call.
vertikalastolpar.vertices   = {{-vertikalastolpar_radius, vertikalastolpar_radius},
				   { vertikalastolpar_radius, vertikalastolpar_radius},
				   { vertikalastolpar_radius,-vertikalastolpar_radius},
				   {-vertikalastolpar_radius,-vertikalastolpar_radius}}
vertikalastolpar.indices	= {0,1,2,2,3,0}
vertikalastolpar.tex_coords = {{0,0},{1,0},{1,1},{0,1}}
vertikalastolpar.material   = _vertikalastolpar	   
vertikalastolpar.init_pos   = {0,vertikalastolpar_shift + shape_rotation} 
vertikalastolpar.additive_alpha  = true
vertikalastolpar.collimated = true
vertikalastolpar.element_params   = {"VERTIKALASTOLPAR_SHOW","HUD_ROLL_PARAM", 
								   "HUD_BETA_PARAM",
								   "RIKTPRICK_Y" } 
								   
vertikalastolpar.controllers 	   = {{"parameter_in_range"				,0,0.9,1.1},--check that piper available using WS_GUN_PIPER_AVAILABLE
								 {"rotate_using_parameter"   ,1, 1 },
									{"move_left_right_using_parameter",2, 1 },									
									{"move_up_down_using_parameter"   ,3, 1 }}
vertikalastolpar.parent_element = vertikalastolpar_origin.name
--AddElement(vertikalastolpar)


-- Test
--AddStaticSight(LockOn_Options.script_path.."../resources/IndicationTextures/ReservSikte.tga", "KONSTHORIZ_SHOW")

-- LADDER 10p
-- local _LADDER10p   			= MakeMaterial(LockOn_Options.script_path.."../resources/IndicationTextures/Ladder+10.tga",BASE_COLOR2) -- image of the fixed net

-- local ladder10p_origin	         = CreateElement "ceSimple"
-- ladder10p_origin.name 		     = create_guid_string() -- no such function in this script. Not in definitions.lua either. Could be in elements_defs.lua
-- ladder10p_origin.collimated 		 = true
-- AddElement(ladder10p_origin)

-- local ladder10p_full_radius =  100 -- is this the radius of "HUD/net view field"? Units (pixels or angular units)?
-- local ladder10p_shift  = -0 -- explain shift?
-- local ladder10p_radius =  ladder_full_radius + grid_shift

-- local ladder10p	    = CreateElement "ceTexPoly" --this could be the text area on HUD
-- ladder10p.name 		= create_guid_string() -- this must be external function call.
-- ladder10p.vertices   = {{-ladder10p_radius, ladder10p_radius},
				   -- { ladder10p_radius, ladder10p_radius},
				   -- { ladder10p_radius,-ladder10p_radius},
				   -- {-ladder10p_radius,-ladder10p_radius}}
-- ladder10p.indices	= {0,1,2,2,3,0}
-- ladder10p.tex_coords = {{0,0},{1,0},{1,1},{0,1}}
-- ladder10p.material   = _LADDER10p   
-- ladder10p.init_pos   = {0,grid_shift + shape_rotation} 
-- ladder10p.additive_alpha  = true

-- ladder10p.collimated = true
-- ladder10p.element_params   = {"WS_GUN_PIPER_AVAILABLE",
								   -- "HUD_LADp10X_PARAM",
								   -- "HUD_LADp10Y_PARAM",
								   -- "HUD_ROLL_PARAM"} 
								   
-- ladder10p.controllers 	   = {{"parameter_in_range"				,0,0.9,1.1},--check that piper available using WS_GUN_PIPER_AVAILABLE
								  -- {"move_left_right_using_parameter",1, 1 },	--azimuth move by WS_GUN_PIPER_AZIMUTH , 0.73 is default collimator distance (from eye to HUD plane)
								  -- {"move_up_down_using_parameter"   ,2, 1 }, --elevation move by WS_GUN_PIPER_ELEVATION
									-- {"rotate_using_parameter"			,3, 1 }, -- ROTATION FTW!!!!
								 -- }
-- ladder10p.parent_element = ladder10p_origin.name
-- AddElement(ladder10p)


local FONT_         = MakeFont({used_DXUnicodeFontData = "font_cockpit_rus_2"},BASE_COLOR2,40,"test_font") --this is font object declaration. Mig-21 does not have fonts, therefore disabled.
local FONTLARGE_         = MakeFont({used_DXUnicodeFontData = "FUI/Fonts/font_arial_17"},BASE_COLOR2,40,"test_font") --this is font object declaration. Mig-21 does not have fonts, therefore disabled.


local test_output           = CreateElement "ceStringPoly"
test_output.name            = create_guid_string()
test_output.material        = FONT_
test_output.init_pos        = {0,55}
test_output.alignment       = "CenterCenter"
test_output.stringdefs      = {0.005,0.50 * 0.01, 0, 0}
test_output.formats         = {"%3.0f","%s"} 
test_output.element_params  = {"FDUHEADINGIND"}--{"HDG_PARAM"}
test_output.controllers     = {{"text_using_parameter",0,0}} --first index is for element_params (starting with 0) , second for formats ( starting with 0)
test_output.additive_alpha  = true
test_output.collimated     = true
--AddElement(test_output)


-- Digital höjd
local RHM_output           = CreateElement "ceStringPoly"
RHM_output.name            = create_guid_string()
RHM_output.material        = FONTLARGE_
RHM_output.init_pos        = {-55,-0}
RHM_output.alignment       = "CenterCenter"
RHM_output.stringdefs      = {0.005,0.50 * 0.01, 0, 0}
RHM_output.formats         = {"%.0f","%0s"} 
RHM_output.element_params  = {"DIGITALHOJD_VALUE", "DIGITALHOJD_SHOW"}--"RHM_PARAM"}
RHM_output.controllers     = {{"parameter_in_range",1,0.9,1.1},{"text_using_parameter",0,0}} --first index is for element_params (starting with 0) , second for formats ( starting with 0)
RHM_output.additive_alpha  = true
RHM_output.collimated     = true
--AddElement(RHM_output)

local SYS_output           = CreateElement "ceStringPoly"
SYS_output.name            = create_guid_string()
SYS_output.material        = FONT_
SYS_output.init_pos        = {55,0}
SYS_output.alignment       = "CenterCenter"
SYS_output.stringdefs      = {0.005,0.50 * 0.01, 0, 0}
SYS_output.formats         = {"%s"}
SYS_output.element_params  = {"NAV_SCRATCHPAD"}
SYS_output.controllers     = {{"text_using_parameter",0,0}} --first index is for element_params (starting with 0) , second for formats ( starting with 0)
SYS_output.additive_alpha  = true
SYS_output.collimated     = true
--AddElement(SYS_output)

local HDG_output           = CreateElement "ceStringPoly"
HDG_output.name            = create_guid_string()
HDG_output.material        = FONT_
HDG_output.init_pos        = {-50,-10}
HDG_output.alignment       = "CenterLeft"
HDG_output.stringdefs      = {0.012,0.012, 0, 0}
HDG_output.formats         = {"%s","%s"}
HDG_output.element_params  = {"NAV_SCRATCHPAD"}
HDG_output.controllers     = {{"text_using_parameter",0,0}} --first index is for element_params (starting with 0) , second for formats ( starting with 0)
HDG_output.additive_alpha  = true
HDG_output.collimated     = false
--AddElement(HDG_output)

local VSPD_output           = CreateElement "ceStringPoly"
VSPD_output.name            = create_guid_string()
VSPD_output.material        = FONT_
VSPD_output.init_pos        = {-55,-70}
VSPD_output.alignment       = "CenterCenter"
VSPD_output.stringdefs      = {0.005,0.50 * 0.01, 0, 0}
VSPD_output.formats         = {"%g","%s"}
VSPD_output.element_params  = {"FCCOMMANDEDHEADING"}
VSPD_output.controllers     = {{"text_using_parameter",0,0}} --first index is for element_params (starting with 0) , second for formats ( starting with 0)
VSPD_output.additive_alpha  = true
VSPD_output.collimated     = true
--AddElement(VSPD_output)

local THROTTLE_output           = CreateElement "ceStringPoly"
THROTTLE_output.name            = create_guid_string()
THROTTLE_output.material        = FONT_
THROTTLE_output.init_pos        = {55,-70}
THROTTLE_output.alignment       = "CenterCenter"
THROTTLE_output.stringdefs      = {0.005,0.50 * 0.01, 0, 0}
THROTTLE_output.formats         = {"%g","%s"}
THROTTLE_output.element_params  = {"THROTTLE_POS"}
THROTTLE_output.controllers     = {{"text_using_parameter",0,0}} --first index is for element_params (starting with 0) , second for formats ( starting with 0)
THROTTLE_output.additive_alpha  = true
THROTTLE_output.collimated     = false
--AddElement(THROTTLE_output)
function AddDebug(paramname, y)
	local DEBUG_output				= CreateElement "ceStringPoly"
	DEBUG_output.name            = create_guid_string()
	DEBUG_output.material        = FONT_
	DEBUG_output.init_pos        = {-50,y}
	DEBUG_output.alignment       = "CenterLeft"
	DEBUG_output.stringdefs      = {0.004,0.4 * 0.01, 0, 0}
	DEBUG_output.formats         = {"%s","%s"}
	DEBUG_output.element_params  = {paramname}
	DEBUG_output.controllers     = {{"text_using_parameter",0,0}} --first index is for element_params (starting with 0) , second for formats ( starting with 0)
	DEBUG_output.additive_alpha  = true
	DEBUG_output.collimated     = false
	--AddElement(DEBUG_output)
end
AddDebug("DEBUG_output", 50)
AddDebug("DEBUG_output2", 40)
AddDebug("DEBUG_output3", 30)
AddDebug("DEBUG_output4", 20)
AddDebug("DEBUG_output5", 10)
AddDebug("DEBUG_output6", 0)
AddDebug("DEBUG_output7", -10)
AddDebug("DEBUG_output8", -20)
AddDebug("DEBUG_output9", -30)
AddDebug("DEBUG_output10", -40)
AddDebug("DEBUG_output11", -50)
AddDebug("DEBUG_output12", 60)
AddDebug("DEBUG_output13", 70)
AddDebug("DEBUG_output14", -60)
AddDebug("DEBUG_output15", -70)
AddDebug("DEBUG_output16", -80)
AddDebug("DEBUG_output17", -90)
AddDebug("DEBUG_output18", 80)
AddDebug("DEBUG_output19", 90)
AddDebug("DEBUG_output20", 100)


-- RESERVSIKTE
local RESERV_   			= MakeMaterial(LockOn_Options.script_path.."../resources/IndicationTextures/ReservSikte.tga",BASE_COLOR2) -- image of the fixed net

local reservsikte_origin	         = CreateElement "ceSimple"
reservsikte_origin.name 		     = create_guid_string() -- no such function in this script. Not in definitions.lua either. Could be in elements_defs.lua
reservsikte_origin.collimated 		 = true
AddElement(reservsikte_origin)

local reservsikte_full_radius =  100 -- is this the radius of "HUD/net view field"? Units (pixels or angular units)?
local reservsikte_shift  = -0 -- explain shift?
local reservsikte_radius =  reservsikte_full_radius + reservsikte_shift


local reservsikte	    = CreateElement "ceTexPoly" --this could be the text area on HUD
reservsikte.name 		= create_guid_string() -- this must be external function call.
reservsikte.vertices   = {{-reservsikte_radius, reservsikte_radius},
				   { reservsikte_radius, reservsikte_radius},
				   { reservsikte_radius,-reservsikte_radius},
				   {-reservsikte_radius,-reservsikte_radius}}
reservsikte.indices	= {0,1,2,2,3,0}
reservsikte.tex_coords = {{0,0},{1,0},{1,1},{0,1}}
reservsikte.material   = RESERV_	   
reservsikte.init_pos   = {0,reservsikte_shift + shape_rotation-50} 
reservsikte.additive_alpha  = true
reservsikte.collimated = true
reservsikte.element_params   = {"WS_GUN_PIPER_AVAILABLE"
								 } 
								   
reservsikte.controllers 	   = {{"parameter_in_range"				,0,0.9,1.1},--check that piper available using WS_GUN_PIPER_AVAILABLE
								 }--rotate_using_parameter
reservsikte.parent_element = reservsikte_origin.name 
--AddElement(reservsikte)


-- local riktmarke   					= MakeMaterial(LockOn_Options.script_path.."../resources/IndicationTextures/pipper.tga",BASE_COLOR2)
-- local riktmarke 			= create_textured_box(7,7,25,25) -- this is create_textured_box function call with parameters
-- riktmarke.material       	= riktmarke_	
-- riktmarke.name 			= riktmarke_
-- riktmarke.collimated     = true

function texture_box (UL_X,UL_Y,W,H) --this is texture box function. Receives some coordinates and dimensions, returns 4 pairs of values. Nothing is calling this function inside script.
local texture_size_x = 128
local texture_size_y = 128
local ux = UL_X / texture_size_x
local uy = UL_Y / texture_size_y
local w  = W / texture_size_x
local h  = W / texture_size_y

return {{ux	    ,uy},
		{ux + w ,uy},
		{ux + w ,uy + h},
		{ux	 	,uy + h}}
end

function create_textured_box(UL_X,UL_Y,DR_X,DR_Y) -- function that creates textured square. This function is called 2 times in below code.

local size_per_pixel = 1/8
local texture_size_x = 128
local texture_size_y = 128
local W = DR_X - UL_X
local H = DR_Y - UL_Y

local half_x = 0.5 * W * size_per_pixel
local half_y = 0.5 * H * size_per_pixel
local ux 	 = UL_X / texture_size_x
local uy 	 = UL_Y / texture_size_y
local w  	 = W / texture_size_x
local h 	 = H / texture_size_y

local object = CreateElement "ceTexPoly"
object.vertices =  {{-half_x, half_y},
				    { half_x, half_y},
				    { half_x,-half_y},
				    {-half_x,-half_y}}
object.indices	  = {0,1,2,2,3,0}
object.tex_coords = {{ux     ,uy},
					 {ux + w ,uy},
					 {ux + w ,uy + h},
				     {ux 	 ,uy + h}}	 
				 
return object

end

local PIPER_   					= MakeMaterial(LockOn_Options.script_path.."../resources/IndicationTextures/pipper.tga",BASE_COLOR2)
local gun_sight_mark 			= create_textured_box(7,7,25,25) -- this is create_textured_box function call with parameters
gun_sight_mark.material       	= PIPER_	
gun_sight_mark.name 			= PIPER_

gun_sight_mark.collimated	  	= true
gun_sight_mark.element_params   = {"WS_GUN_PIPER_AVAILABLE",
								   "WS_GUN_PIPER_AZIMUTH",
								   "ALPHA_PARAM"} 
								   
gun_sight_mark.controllers 	   = {{"parameter_in_range"				,0,0.9,1.1},--check that piper available using WS_GUN_PIPER_AVAILABLE
								  {"move_left_right_using_parameter",1, 0.73 },	--azimuth move by WS_GUN_PIPER_AZIMUTH , 0.73 is default collimator distance (from eye to HUD plane)
								  {"move_up_down_using_parameter"   ,2, 0.73 }, --elevation move by WS_GUN_PIPER_ELEVATION
								 }
--AddElement(gun_sight_mark)
