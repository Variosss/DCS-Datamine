dofile(LockOn_Options.script_path.."HUD/Indicator/HUD_definitions.lua")

Solution_Cue_point				= CreateDummy()
Solution_Cue_point.name			= "Solution_Cue_point"
Solution_Cue_point.init_pos		= {0.0, 0.0, 0.0}
Solution_Cue_point.controllers	= {{"IsIAM", 0},{"MasterArmSafe", 0}, {"Solution_Cue_pos"}}
Add(Solution_Cue_point)				  
				  
AddHUDTexElement("Solution_Cue",
				{{-5.0, -5.0}, {-5.0, 5.0}, 
				{5.0, 5.0}, {5.0, -5.0}}, 
				{13.42/texture_size, 0.68/texture_size, tex_scale, tex_scale},
				{{"CCRP_INVALID_msg", 0}, {"Solution_Cue_Show", 1, 5}},
				{0.0, 0.0, 0.0},
				{0.0, 0.0 , 0.0},
				"Solution_Cue_point",
				HUD_DEFAULT_LEVEL)
				
			
AddHUDTexElement("Solution_Cue_invalid",
				{{-5.0, -5.0}, {-5.0, 5.0}, 
				{5.0, 5.0}, {5.0, -5.0}}, 
				{14.565/texture_size, 0.68/texture_size, tex_scale, tex_scale},
				{{"Solution_Cue_Show", 2, 5}},
				{0.0, 0.0, 0.0},
				{0.0, 0.0 , 0.0},
				"Solution_Cue_point",
				HUD_DEFAULT_LEVEL)	
				
				
AddHUDTextElement_Pos("TTRN_RAN", 
				  {{"TTRN_RAN_value", 20, 100}}, 
				  {5.5, 0.0, 0.0}, 
				  "Solution_Cue_point",
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")				
				
				
CueStencilSize = 4.0
CueStencil = CreateElement "ceMeshPoly"
CueStencil.name = "CueStencil"
CueStencil.primitivetype = "triangles"
CueStencil.vertices = {{-CueStencilSize, -CueStencilSize},
						{-CueStencilSize, CueStencilSize},
						{CueStencilSize, CueStencilSize},
						{CueStencilSize, -CueStencilSize}
						}
CueStencil.indices  = default_box_indices
CueStencil.init_pos = {0, 0, 0}
CueStencil.parent_element	= "Solution_Cue_point"
CueStencil.controllers	= {{"CCRP_INVALID_msg", 0}, {"Rotate_Stencil"}}
CueStencil.material = "DBG_RED"
CueStencil.h_clip_relation = h_clip_relations.INCREASE_IF_LEVEL
CueStencil.level			 = HUD_DEFAULT_LEVEL
CueStencil.isdraw = true
CueStencil.isvisible = false
Add(CueStencil)

addHWLine("ASL", 340, 340, {{"CCRP_INVALID_msg", 0}, {"ASL", 25}}, {0.0, 0.0, 0.0}, {-90.0, 0.0, 0.0}, "Solution_Cue_point", HUD_DEFAULT_LEVEL)

CueStencil1 = CreateElement "ceMeshPoly"
CueStencil1.name = "CueStencil1"
CueStencil1.primitivetype = "triangles"
CueStencil1.vertices = {{-CueStencilSize, -CueStencilSize},
						{-CueStencilSize, CueStencilSize},
						{CueStencilSize, CueStencilSize},
						{CueStencilSize, -CueStencilSize}
						}
CueStencil1.indices  = default_box_indices
CueStencil1.init_pos = {0, 0, 0}
CueStencil1.parent_element	= "Solution_Cue_point"
CueStencil1.controllers	= {{"Rotate_Stencil"}}
CueStencil1.material = "DBG_BLACK"
CueStencil1.h_clip_relation = h_clip_relations.DECREASE_IF_LEVEL
CueStencil1.level			= HUD_DEFAULT_LEVEL + 1
CueStencil1.isdraw = true
CueStencil1.isvisible = false
Add(CueStencil1)


-------------------------------------------------------------------------------
-- Azimuth Steering Line for IAM weapons + depressible piper occultation windows.
--

DepressiblePipperOccultWndASLpt1				= CreateDummy()
DepressiblePipperOccultWndASLpt1.name		    = "DepressiblePipperOccultWndASLpt1"
DepressiblePipperOccultWndASLpt1.level 		    = HUD_DEFAULT_LEVEL
DepressiblePipperOccultWndASLpt1.controllers	= {{"Depressible_Pipper_pos", ZSL}}
Add(DepressiblePipperOccultWndASLpt1)			

clip_sizeX = 12
clip_sizeY = 12

DeprPipper_OccultVerts = {{-clip_sizeX, -clip_sizeY},
						  {-clip_sizeX, clip_sizeY},
						  {clip_sizeX, clip_sizeY},
						  {clip_sizeX, -clip_sizeY}
						 }

OpenOccultWnd("Depressible_Pipper_clip_ASL_11",
			DeprPipper_OccultVerts,
			nil, 
			"DepressiblePipperOccultWndASLpt1",
			HUD_DEFAULT_LEVEL)

OpenOccultWnd("Depressible_Pipper_clip_ASL_12",
			DeprPipper_OccultVerts,
			nil,
			"DepressiblePipperOccultWndASLpt1", 
			HUD_DEFAULT_LEVEL + 1)

-- New IAM AZL
AZSL_iam_point				= CreateDummy()
AZSL_iam_point.name			= "AZSL_iam_point"
AZSL_iam_point.init_pos		= {0.0, 0.0, 0.0}
AZSL_iam_point.controllers	= {{"IsIAM", 1},{"MasterArmSafe", 0}, {"Solution_Cue_pos"}}
Add(AZSL_iam_point)				  

addHWLine("ASL_IAM", 340, 340, {{"CCRP_INVALID_msg", 0}, {"ASL_IAM", 25}}, {0.0, 0.0, 0.0}, {-90.0, 0.0, 0.0}, "AZSL_iam_point", HUD_DEFAULT_LEVEL)

-- Old IAM AZL
--addHWLine("ASL_IAM", 340, 340, {{"IsIAM", 1}, {"MasterArmSafe", 0}, {"Solution_Cue_pos"}, {"ASL_IAM", 25}}, {0.0, 0.0, 0.0}, {0.0, 0.0, 0.0}, nil, HUD_DEFAULT_LEVEL)

DepressiblePipperOccultWndASLpt2				= CreateDummy()
DepressiblePipperOccultWndASLpt2.name	        = "DepressiblePipperOccultWndASLpt2"
DepressiblePipperOccultWndASLpt2.level 	        = HUD_DEFAULT_LEVEL
DepressiblePipperOccultWndASLpt2.controllers	= {{"Depressible_Pipper_pos", ZSL}}
Add(DepressiblePipperOccultWndASLpt2)			

CloseOccultWnd("Depressible_Pipper_clip_ASL_21",
			DeprPipper_OccultVerts, 
			nil,
			"DepressiblePipperOccultWndASLpt2", 
			HUD_DEFAULT_LEVEL + 2)

CloseOccultWnd("Depressible_Pipper_clip_ASL_22",
			DeprPipper_OccultVerts, 
			nil,
			"DepressiblePipperOccultWndASLpt2", 
			HUD_DEFAULT_LEVEL + 1)

-------------------------------------------------------------------------------
