dofile(LockOn_Options.script_path.."HUD/Indicator/HUD_definitions.lua")

PitchLineClipRadius = 163

function AddPitchLine(name, tex_params, parent, index)

	local Line = AddHUDTexElement(name, 
					{{-37, -2.5}, {-37, 2.5}, 
					{37, 2.5}, {37, -2.5}},
					tex_params, 
					{{"line_pitch", index, 348, PitchLineClipRadius}},
					{0.0, index * five_degrees, 0.0},
					{0.0, 0.0, 0.0},
					parent,
					HUD_DEFAULT_LEVEL)

	textpos = -1.2
	if index < 0 then
		textpos = 0.8
	end
				
	local Text1 = AddHUDTextElement(("txt_" .. name), 
				  {{"txt_pitch", index}}, 
				  {-41, textpos, 0.0}, 
				  name,
				  HUD_DEFAULT_LEVEL)
	
	local Text2 = AddHUDTextElement(("txt_" .. name .. string.format("%i", 2)), 
				  {{"txt_pitch", index}}, 
				  {41, textpos, 0.0}, 
				  name,
				  HUD_DEFAULT_LEVEL)
end

AddHUDTexElement("Depressible_Pipper", 
				{{-14, -14}, {-14, 14}, 
				{14, 14}, {14, -14}},
				{1.59/texture_size, 5.23/texture_size, tex_scale, tex_scale},
				{{"Depressible_Pipper_pos", ZSL}},
				{0.0, 0.0, 0.0},
				{0.0, 0.0, 0.0},
				nil,
				HUD_DEFAULT_LEVEL)
				
AddHUDTexElement("Depressible_piper_hars_stroke_1",
				{{-5, -1}, {-5, 1}, 
				{5, 1}, {5, -1}},
				{9.71/texture_size, 3.29/texture_size, tex_scale, tex_scale},
				{{"HARS_CCP_stroke"}},
				{0.0, 24.0, 0.0},
				{0.0, 0.0, 0.0},
				"Depressible_Pipper",
				HUD_DEFAULT_LEVEL)
		
AddHUDTexElement("Depressible_piper_hars_stroke_2",
				{{-5, -1}, {-5, 1}, 
				{5, 1}, {5, -1}},
				{9.71/texture_size, 3.29/texture_size, tex_scale, tex_scale},
				nil,
				{0.0, 24.0, 0.0},
				{0.0, 0.0, 0.0},
				"Depressible_piper_hars_stroke_1",
				HUD_DEFAULT_LEVEL)
				
AGM_65 = AddHUDTexElement("AGM_65_Maverick_Symbol",
				{{-11.5, -11.5}, {-11.5, 11.5}, 
				{11.5, 11.5}, {11.5, -11.5}},
				{5.61/texture_size, 5.255/texture_size, tex_scale, tex_scale},
				{{"MasterArmSafe", 0}, {"AGM_65_Maverick_Symbol_pos", 158.2, ZSL, 0.1667}},
				{0.0, 0.0, 0.0},
				{0.0, 0.0, 0.0},
				nil,
				HUD_DEFAULT_LEVEL)

mav = AddHUDTexElement("Maverick_min_range",
				{{-12, -12}, {-12, 12}, 
				{12, 12}, {12, -12}},
				{13.575/texture_size, 16.215/texture_size, tex_scale, tex_scale},
				{{"AGM_65_min_range"}},
				{0.0, 0.0, 0.0},
				{0.0, 0.0, 0.0},
				"AGM_65_Maverick_Symbol",
				HUD_DEFAULT_LEVEL)		

mb = AddHUDTextElement_Pos_Val("AGM_65_MB_Symbol", 
				  {{"AGM_65_MB_Symbol_show"}}, 
				  {0.0, 15, 0.0}, 
				  "AGM_65_Maverick_Symbol",
				  HUD_DEFAULT_LEVEL,
				  "CenterCenter",
				  "MB")	

SN = AddHUDTextElement_Pos_Val("AGM_65_SN_Symbol", 
				  {{"AGM_65_SN_Symbol_show"}}, 
				  {0.0, 15, 0.0}, 
				  "AGM_65_Maverick_Symbol",
				  HUD_DEFAULT_LEVEL,
				  "CenterCenter",
				  "SN")	

dist = AddHUDTextElement("AGM_65_Dist", 
				  {{"AGM_65_Dist"}},
				  {0.0, -15, 0.0}, 
				  "AGM_65_Maverick_Symbol",
				  HUD_DEFAULT_LEVEL)					

PipperReticleOccultWndPnt			= CreateDummy()
PipperReticleOccultWndPnt.name		= "PipperReticleOccultWndPnt"
PipperReticleOccultWndPnt.level 	= HUD_DEFAULT_LEVEL
PipperReticleOccultWndPnt.controllers	= 
	{{"MasterArmSafe", 0}, {"OccultWndModeContol"}, {"pipper_reticle_pos", ZSL, 100, TFOV, 28},
	 {"pipper_reticle_max_defl", 160, CCRP_MaxPiperDefl}}
Add(PipperReticleOccultWndPnt)

clip_sizeX = 25
clip_sizeY = 18

CCIP_OccultVerts = {{-clip_sizeX, -clip_sizeY},
					{-clip_sizeX, clip_sizeY},
					{clip_sizeX, clip_sizeY},
					{clip_sizeX, -clip_sizeY}
				   }

OpenOccultWnd("clipReticleCCIP_Bomb1",
			CCIP_OccultVerts,
			{{"OccultWndReticle", 2}}, 
			"PipperReticleOccultWndPnt", 
			HUD_DEFAULT_LEVEL)

OpenOccultWnd("clipReticleCCIP_Bomb2",
			CCIP_OccultVerts,
			{{"OccultWndReticle", 2}}, 
			"PipperReticleOccultWndPnt", 
			HUD_DEFAULT_LEVEL + 1)

clip_sizeX = 18

CCRP_OccultVerts = {{-clip_sizeX, -clip_sizeY},
					{-clip_sizeX, clip_sizeY},
					{clip_sizeX, clip_sizeY},
					{clip_sizeX, -clip_sizeY}
				   }

OpenOccultWnd("clipReticleCCRP1",
			CCRP_OccultVerts,
			{--[[{"IsIAM", 0},--]] {"OccultWndReticle", 3}}, 
			"PipperReticleOccultWndPnt", 
			HUD_DEFAULT_LEVEL)
			
OpenOccultWnd("clipReticleCCRP2",
			CCRP_OccultVerts,
			{--[[{"IsIAM", 0},--]] {"OccultWndReticle", 3}}, 
			"PipperReticleOccultWndPnt", 
			HUD_DEFAULT_LEVEL + 1)

addHWLine("PBIL", 340, 340, {{"MasterArmSafe", 0}, {"IsIAM", 0}, {"IsMaverickSelected", 0}, {"PBIL", TFOV, ZSL, 100, 200, 60, 28, CCRP_MaxPiperDefl}},
	{0.0, 0.0, 0.0}, {0.0, 0.0, 0.0}, nil, HUD_DEFAULT_LEVEL)

clip_sizeX = 12
clip_sizeY = 12

GUNS_OccultVerts = {{-clip_sizeX, -clip_sizeY},
					{-clip_sizeX, clip_sizeY},
					{clip_sizeX, clip_sizeY},
					{clip_sizeX, -clip_sizeY}
				   }

OpenOccultWnd("clipReticleGUNS1",
			GUNS_OccultVerts,
			{{"OccultWndReticle", 1}}, 
			"PipperReticleOccultWndPnt", 
			HUD_DEFAULT_LEVEL)
			
OpenOccultWnd("clipReticleGUNS2",
			GUNS_OccultVerts,
			{{"OccultWndReticle", 1}}, 
			"PipperReticleOccultWndPnt", 
			HUD_DEFAULT_LEVEL + 1)

Pipper_Reticle_dashOccultWnd		= CreateDummy()
Pipper_Reticle_dashOccultWnd.name	= "Pipper_Reticle_dashOccultWnd"
Pipper_Reticle_dashOccultWnd.level 	= HUD_DEFAULT_LEVEL
Pipper_Reticle_dashOccultWnd.controllers =
	{{"MasterArmSafe", 0}, {"IsMaverickSelected", 0}, {"OccultWndModeContol"}, {"pipper_reticle_dashed_pos", ZSL, TFOV, 28, 20}}
Add(Pipper_Reticle_dashOccultWnd)

clip_sizeX = 25
clip_sizeY = 18

Dash_OccultVerts = {{-clip_sizeX, -clip_sizeY},
					{-clip_sizeX, clip_sizeY},
					{clip_sizeX, clip_sizeY},
					{clip_sizeX, -clip_sizeY}
				   }

OpenOccultWnd("clipReticle3",
			Dash_OccultVerts,
			nil, 
			"Pipper_Reticle_dashOccultWnd", 
			HUD_DEFAULT_LEVEL)
			
OpenOccultWnd("clipReticle4",
			Dash_OccultVerts,
			nil, 
			"Pipper_Reticle_dashOccultWnd", 
			HUD_DEFAULT_LEVEL + 1)			
		
addDashLine("PBILDash", {{"MasterArmSafe", 0}, {"IsIAM", 0}, {"IsMaverickSelected", 0}, {"PBILDash", TFOV, ZSL, 100, 28}}, {0.0, 0.0, 0.0}, {0.0, 0.0, 0.0}, 340, 0, nil, HUD_DEFAULT_LEVEL)

--------------------------------------------------------------------
-- GUN CROSS clips

GunCross_sizeX = 12
GunCross_sizeY = 14.5

Cross_OccultVerts = {{-GunCross_sizeX, -GunCross_sizeY},
					 {-GunCross_sizeX, GunCross_sizeY},
					 {GunCross_sizeX, GunCross_sizeY},
					 {GunCross_sizeX, -GunCross_sizeY}
				    }
					
clipGunCross_pnt		= CreateDummy()
clipGunCross_pnt.name	= "clipGunCross_pnt"
clipGunCross_pnt.level 	= HUD_DEFAULT_LEVEL
clipGunCross_pnt.controllers = 
	{{"MasterArmSafe", 0}, {"OccultWndModeContol"}, {"GunCrossOccultWnd_show"},{"pipper_reticle_pos", ZSL, 100, TFOV, 28, 1},
	 {"pipper_reticle_max_defl", 160, CCRP_MaxPiperDefl, 1}}
Add(clipGunCross_pnt)

OpenOccultWnd("clipGunCross1",
			Cross_OccultVerts,
			nil, 
			"clipGunCross_pnt",
			HUD_DEFAULT_LEVEL)
			
OpenOccultWnd("clipGunCross2",
			Cross_OccultVerts, 
			nil,
			"clipGunCross_pnt", 
			HUD_DEFAULT_LEVEL + 1)
			
			
clipWindGunCross_pnt		= CreateDummy()
clipWindGunCross_pnt.name	= "clipWindGunCross_pnt"
clipWindGunCross_pnt.level 	= HUD_DEFAULT_LEVEL
clipWindGunCross_pnt.controllers	= {{"MasterArmSafe", 0}, {"GunSymbologyAvail", 1}, {"OccultWndModeContol"}, {"GunCrossOccultWnd_show"}, {"Wind_Corrected_gun_cross_pos", 160, ZSL}}
Add(clipWindGunCross_pnt)
			
OpenOccultWnd("clipGunCross3",
			Cross_OccultVerts,
			nil,
			"clipWindGunCross_pnt", 
			HUD_DEFAULT_LEVEL)
			
OpenOccultWnd("clipGunCross4",
			Cross_OccultVerts,
			nil,
			"clipWindGunCross_pnt", 
			HUD_DEFAULT_LEVEL + 1)			
					
clipRangeGunCross_pnt		= CreateDummy()
clipRangeGunCross_pnt.name	= "clipRangeGunCross_pnt"
clipRangeGunCross_pnt.level 		= HUD_DEFAULT_LEVEL
clipRangeGunCross_pnt.init_pos		= {0.0, -15.0, 0.0}
clipRangeGunCross_pnt.parent_element = "clipGunCross_pnt"
Add(clipRangeGunCross_pnt)					

GunCross_txt_sizeX = 10
GunCross_txt_sizeY = 4

Cross_txt_OccultVerts = {{-GunCross_txt_sizeX, -GunCross_txt_sizeY},
						 {-GunCross_txt_sizeX, GunCross_txt_sizeY},
						 {GunCross_txt_sizeX, GunCross_txt_sizeY},
						 {GunCross_txt_sizeX, -GunCross_txt_sizeY}
						}

OpenOccultWnd("clipGunCross_txt1",
			Cross_txt_OccultVerts,
			{{"GunCross_txt_OccultWnd"}}, 
			"clipRangeGunCross_pnt", 
			HUD_DEFAULT_LEVEL)
			
OpenOccultWnd("clipGunCross_txt2",
			Cross_txt_OccultVerts,
			{{"GunCross_txt_OccultWnd"}}, 
			"clipRangeGunCross_pnt", 
			HUD_DEFAULT_LEVEL + 1)

	
clipReticle4_8_12_pnt		= CreateDummy()
clipReticle4_8_12_pnt.name		= "clipReticle4_8_12_pnt"
clipReticle4_8_12_pnt.level 	= HUD_DEFAULT_LEVEL
clipReticle4_8_12_pnt.controllers	= {{"MasterArmSafe", 0}, {"GunSymbologyAvail", 1}, {"OccultWndModeContol"}, {"gun_4_8_12_reticle", 160, ZSL, 1}}
Add(clipReticle4_8_12_pnt)


clip_sizeX = 12
clip_sizeY = 12

Ret4_8_12_OccultVerts = {{-clip_sizeX, -clip_sizeY},
						 {-clip_sizeX, clip_sizeY},
						 {clip_sizeX, clip_sizeY},
						 {clip_sizeX, -clip_sizeY}
						}

OpenOccultWnd("clipReticle4_8_12_1",
			Ret4_8_12_OccultVerts,
			nil, 
			"clipReticle4_8_12_pnt", 
			HUD_DEFAULT_LEVEL)
			
OpenOccultWnd("clipReticle4_8_12_2",
			Ret4_8_12_OccultVerts,
			nil, 
			"clipReticle4_8_12_pnt", 
			HUD_DEFAULT_LEVEL + 1)

			
TISL_base_point        			= CreateDummy()	
TISL_base_point.name			= "TISL_base_point"
TISL_base_point.init_pos		= {0.0, 0.0, 0.0}
TISL_base_point.controllers		= {{"attitude"}, {"TISL_base_point",ZSL}}	
TISL_base_point.collimated		= true
Add(TISL_base_point)			

AddHUDTexElement("TISL_Spider", 
				{{-9, -9}, {-9, 9}, 
				{9, 9}, {9, -9}},
				{3.805/texture_size, 2.94/texture_size, tex_scale, tex_scale},
				{{"TISL_Spider_pos", 160, ZSL, 0.25}},
				{0.0, 0.0, 0.0},
				{45.0, 0.0, 0.0},
				"TISL_base_point",
				HUD_DEFAULT_LEVEL)
				
--addMeshBox("test_meshbox", {test}, {0.0, 0.0, 0.0}, nil)

addDashLine("testDash", {{"TISL_hook_line"}}, {0.0, 0.0, 0.0}, {0.0, 0.0, 0.0}, 340, 0,  "TISL_base_point", HUD_DEFAULT_LEVEL)

DepressiblePipperOccultWndPnt		= CreateDummy()
DepressiblePipperOccultWndPnt.name	= "DepressiblePipperOccultWndPnt"
DepressiblePipperOccultWndPnt.level = HUD_DEFAULT_LEVEL
DepressiblePipperOccultWndPnt.controllers	= {{"Depressible_Pipper_pos", ZSL}}
Add(DepressiblePipperOccultWndPnt)								

clip_sizeX = 12
clip_sizeY = 12

DeprPipper_OccultVerts = {{-clip_sizeX, -clip_sizeY},
						  {-clip_sizeX, clip_sizeY},
						  {clip_sizeX, clip_sizeY},
						  {clip_sizeX, -clip_sizeY}
						 }

OpenOccultWnd("Depressible_Pipper_clip11",
			DeprPipper_OccultVerts,
			nil, 
			"DepressiblePipperOccultWndPnt", 
			HUD_DEFAULT_LEVEL)
			
OpenOccultWnd("Depressible_Pipper_clip12",
			DeprPipper_OccultVerts,
			nil, 
			"DepressiblePipperOccultWndPnt", 
			HUD_DEFAULT_LEVEL + 1)


FPA_ladder_point        		= CreateDummy()	
FPA_ladder_point.name			= "FPA_point"
FPA_ladder_point.init_pos		= {0.0, 0.0, 0.0}
FPA_ladder_point.controllers	= {{"attitude"}, {"FPA_ladder_point"}}	
FPA_ladder_point.collimated		= true
Add(FPA_ladder_point)

TVV_point					= CreateDummy()
TVV_point.name				= "TVV_point"
TVV_point.init_pos			= {0.0, 0.0, 0.0}
TVV_point.parent_element 	= "FPA_point"
TVV_point.controllers		= {{"EGI_attitude_on"}}
TVV_point.collimated		= true
Add(TVV_point)

pitch_origin				= CreateDummy()
pitch_origin.name			= "pitch_origin"
pitch_origin.init_pos		= {0.0, 0.0, 0.0}
pitch_origin.parent_element = "FPA_point"
pitch_origin.collimated		= true
pitch_origin.controllers	= {{"attitude"}, {"pitch_origin"}} 
Add(pitch_origin)

ZeroPitch = AddHUDTexElement("zero_pitch",
				{{-40.0, -1.5}, {-40.0, 1.5}, 
				{40.0, 1.5}, {40.0, -1.5}}, 
				{4.28/texture_size, 0.855/texture_size, tex_scale/1.1, tex_scale},
				{{"zero_pitch", PitchLineClipRadius}},
				{0.0, 0.0, 0.0},
				{0.0, 0.0, 0.0},
				"pitch_origin",
				HUD_DEFAULT_LEVEL)
		
for i = 1, 4 do
	AddPitchLine("posit_pitch" .. string.format("%i", i),
				{4.28/texture_size, 0.365/texture_size, tex_scale, tex_scale},
				"pitch_origin",
				i)
				
	AddPitchLine("negat_pitch" .. string.format("%i", i),
				{4.28/texture_size, 1.385/texture_size, tex_scale, tex_scale},
				"pitch_origin",
				-1 * i)
end

local scratch_pad_position = FROM_HUD_CENTER(0.0, -120.5)

AddHUDTextElement("Scratch_PAD", 
				  {{"heading_or_scratch", 2}}, 
				  scratch_pad_position, 
				  nil,
				  HUD_DEFAULT_LEVEL)

AddHUDTextElement("Scratch_PAD_AndWARNING",
				  {{"heading_or_scratch", 3, 1, 0.1667}},
				  scratch_pad_position, 
				  nil,
				  HUD_DEFAULT_LEVEL)

AddHUDTextElement("Scratch_PAD_AndCAUTION",
				  {{"heading_or_scratch", 3, 2, 0.1667}},
				  scratch_pad_position, 
				  nil,
				  HUD_DEFAULT_LEVEL)
				  
AddHUDTextElement("Scratch_PAD_AndNOTE",
				  {{"heading_or_scratch", 3, 3, 0.1667}},
				  scratch_pad_position, 
				  nil,
				  HUD_DEFAULT_LEVEL)

AddHUDTextElement("Scratch_PAD_AndMESSAGE",
				  {{"heading_or_scratch", 3, 4, 0.1667}},
				  scratch_pad_position, 
				  nil,
				  HUD_DEFAULT_LEVEL)

AddHUDTextElement_Pos_Val("WARNING",
				  {{"heading_or_scratch", 4, 1, 0.1667}},
				  scratch_pad_position, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "CenterCenter",
				  "WARNING")

AddHUDTextElement_Pos_Val("CAUTION",
				  {{"heading_or_scratch", 4, 2, 0.1667}},
				  scratch_pad_position, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "CenterCenter",
				  "CAUTION")
				  
AddHUDTextElement_Pos_Val("NOTE",
				  {{"heading_or_scratch", 4, 3, 0.1667}},
				  scratch_pad_position, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "CenterCenter",
				  "NOTE")

AddHUDTextElement_Pos_Val("MESSAGE",
				  {{"heading_or_scratch", 4, 4, 0.1667}},
				  scratch_pad_position, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "CenterCenter",
				  "MESSAGE")

AddHUDTextElement("Scratch_PAD_cursor", 
				  {{"Scratch_PAD_cursor_pos", 0.1667}}, 
				  {0.0, UnderlineDepr, 0.0}, 
				  "Scratch_PAD",
				  HUD_DEFAULT_LEVEL)

AddHUDTextElement("Scratch_PAD_Mode", 
				  {{"Scratch_PAD_Mode_letter", 1}}, 
				  scratch_pad_position, 
				  nil,
				  HUD_DEFAULT_LEVEL)				  

AddHUDTextElement("Scratch_PAD_Mode_underline", 
				  {{"Scratch_PAD_Mode_letter", 2}}, 
				  {0.0, UnderlineDepr, 0.0}, 
				  "Scratch_PAD_Mode",
				  HUD_DEFAULT_LEVEL)
				  
local HEADING_TAPE_POS = FROM_HUD_CENTER(0,-112)

heading_border_sizeX = 36.5
heading_border_sizeY = 15
heading_scale_border = CreateElement "ceMeshPoly"
heading_scale_border.name = "heading_scale_border"
heading_scale_border.primitivetype = "triangles"
heading_scale_border.vertices = {{-heading_border_sizeX, -heading_border_sizeY},
									{-heading_border_sizeX, heading_border_sizeY},
									{heading_border_sizeX, heading_border_sizeY},
									{heading_border_sizeX, -heading_border_sizeY}
									}
heading_scale_border.indices  = default_box_indices
heading_scale_border.init_pos = HEADING_TAPE_POS
heading_scale_border.material = "DBG_RED" --"GREEN"
heading_scale_border.h_clip_relation = h_clip_relations.INCREASE_IF_LEVEL
heading_scale_border.level			 = HUD_DEFAULT_LEVEL
heading_scale_border.collimated		 = true
heading_scale_border.isdraw = true
heading_scale_border.isvisible = false
Add(heading_scale_border)

AddHUDTexElement("heading",
				{{-4.0, -2.0}, {-4.0, 2.0}, 
				{4.0, 2.0}, {4.0, -2.0}}, 
				{9.37/texture_size, 5.935/texture_size, tex_scale, tex_scale},
				{{"heading_or_scratch", 1}, {"heading"}},
				HEADING_TAPE_POS,
				{0.0, 0.0 , 0.0},
				nil,
				HUD_DEFAULT_LEVEL + 1)

delta = 12.5

function AddHeadingPnt(name, parent, index)
	if index > 3 then
		i = 3 - index
	else
		i = index
	end
	
	controllers = nil
	
	if i == 3 then
		controllers = {{"heading_tick3"}}
	end
	
	local element = AddHUDTexElement(name, 
					{{-1.0, -2.0}, {-1.0, 2.0}, 
					{1.0, 2.0}, {1.0, -2.0}}, 
					{16.8/texture_size, 1.455/texture_size, tex_scale, tex_scale},
					controllers,
					{-i * delta, 0.0, 0.0},
					{0.0, 0.0, 0.0},
					parent,
					HUD_DEFAULT_LEVEL + 1)
					
	element.isdraw = true
				
	AddHUDTextElement(("txt_" .. name), 
					  {{"txt_head", -i}}, 
					  {0.0, 3.98, 0.0}, 
					  name,
					  HUD_DEFAULT_LEVEL + 1)
end

AddHUDTexElement("heading_pnt",
				{{-1.0, -2.0}, {-1.0, 2.0}, 
				{1.0, 2.0}, {1.0, -2.0}}, 
				{16.8/texture_size, 1.455/texture_size, tex_scale, tex_scale},
				{{"heading_scale", five_degrees/delta}},
				{0.0, 3.5, 0.0},
				{0.0, 0.0 , 0.0},
				"heading",
				HUD_DEFAULT_LEVEL + 1)

AddHUDTextElement(("txt_heading_pnt"),
				  {{"txt_head", 0}}, 
				  {0.0, 3.98, 0.0}, 
				  "heading_pnt",
				  HUD_DEFAULT_LEVEL + 1)

for i = 1, 6 do
	AddHeadingPnt("heading_pnt" .. string.format("%i", i),
					"heading_pnt", i)
end

heading_scale_border1 = CreateElement "ceMeshPoly"
heading_scale_border1.name = "heading_scale_border1"
heading_scale_border1.primitivetype = "triangles"
heading_scale_border1.vertices = {{-heading_border_sizeX, -heading_border_sizeY},
									{-heading_border_sizeX, heading_border_sizeY},
									{heading_border_sizeX, heading_border_sizeY},
									{heading_border_sizeX, -heading_border_sizeY}
									}
heading_scale_border1.indices  = default_box_indices
heading_scale_border1.init_pos = HEADING_TAPE_POS
heading_scale_border1.material = "DBG_BLACK"
heading_scale_border1.h_clip_relation = h_clip_relations.DECREASE_IF_LEVEL
heading_scale_border1.level			= HUD_DEFAULT_LEVEL + 1
heading_scale_border1.collimated	= true
heading_scale_border1.isdraw = true
heading_scale_border1.isvisible = false
Add(heading_scale_border1)

HeadingRefNoClip				= CreateDummy()
HeadingRefNoClip.name			= "HeadingRefNoClip"
HeadingRefNoClip.init_pos		= HEADING_TAPE_POS
HeadingRefNoClip.controllers	= {{"heading_or_scratch", 1}} 
Add(HeadingRefNoClip)

DesHeadVisDelta = math.rad(10.75)

AddHUDTexElement("nec_heading",
				{{-2.5, -3.0}, {-2.5, 3.0}, 
				{2.5, 3.0}, {2.5, -3.0}}, 
				{15.85/texture_size, 0.655/texture_size, tex_scale, tex_scale},
				{{"HARSorEGI_on"}, {"Desired_Magnetic_Heading", 0, DesHeadVisDelta, five_degrees/delta}},
				{0.0, -8, 0.0},
				{0.0, 0.0 , 0.0},
				"HeadingRefNoClip",
				HUD_DEFAULT_LEVEL)

AddHUDTexElement("nec_heading_out_Left",
				{{-4, -2.0}, {-4, 2.0}, 
				{4, 2.0}, {4, -2.0}}, 
				{15.87/texture_size, 8.69/texture_size, tex_scale, tex_scale},
				{{"HARSorEGI_on"}, {"Desired_Magnetic_Heading", 1, DesHeadVisDelta}},
				{-29, -5, 0.0},
				{180.0, 0.0 , 0.0},
				HeadingRefNoClip.name,
				HUD_DEFAULT_LEVEL)

txt_nec_Left = AddHUDTextElement(("txt_nec_heading_out_Left"),
				  {{"txt_heading_out"}},
				  {10.78, 0.0, 0.0}, 
				  "nec_heading_out_Left",
				  HUD_DEFAULT_LEVEL)
				  
txt_nec_Left.init_rot	= {180.0, 0.0 , 0.0};
								
AddHUDTexElement("nec_heading_out_Right",
				{{-4, -2.0}, {-4, 2.0}, 
				{4, 2.0}, {4, -2.0}}, 
				{15.87/texture_size, 8.69/texture_size, tex_scale, tex_scale},
				{{"HARSorEGI_on"}, {"Desired_Magnetic_Heading", 2, DesHeadVisDelta}},
				{29, -5, 0.0},
				{0.0, 0.0 , 0.0},
				HeadingRefNoClip.name,
				HUD_DEFAULT_LEVEL)
				
AddHUDTextElement(("txt_nec_heading_out_Right"),
				  {{"txt_heading_out"}}, 
				  {10.78, 0.0, 0.0}, 
				  "nec_heading_out_Right",
				  HUD_DEFAULT_LEVEL)

AddHUDTexElement("Destination_Index", 
				{{-4.0, -4.0}, {-4.0, 13.0}, 
				{4.0, 13.0}, {4.0, -4.0}},
				{3.765/texture_size, 5.76/texture_size, tex_scale, tex_scale},
				{{"Destination_Index_Pos", 10, 138, 96.5}},
				{0.0, 0.0, 0.0},
				{0.0, 0.0, 0.0},
				"TVV_point",
				HUD_DEFAULT_LEVEL)

AddHUDTexElement("GBL_CROSS",
				{{-3, -3}, {-3, 3}, 
				 {3, 3}, {3, -3}},
				{7.53/texture_size, 6.4/texture_size, tex_scale, tex_scale},
				{{"MasterArmSafe", 0}, {"GBL_CROSS_Symbol"}},
				{0.0, GBL_CROSS_pos, 0.0},
				{0.0, 0.0, 0.0},
				nil,
				HUD_DEFAULT_LEVEL)

Radar_Alt_pnt			= CreateDummy()
Radar_Alt_pnt.name		= "Radar_Alt_pnt"
Radar_Alt_pnt.init_pos	= FROM_HUD_CENTER(68.5, -4.0)
Radar_Alt_pnt.level 	= HUD_DEFAULT_LEVEL
Radar_Alt_pnt.controllers	= {{"disp_opt_tapes_visible", 0}, {"Radar_Altitude_Scale"}} 
Add(Radar_Alt_pnt)

addHWLine("Radar_Altitude_Scale", 5, 100, {{"Radar_Altitude_Scale_ctrl", 0}}, 
			{0.0, -50.0, 0.0}, {90.0, 0.0, 0.0}, "Radar_Alt_pnt", HUD_DEFAULT_LEVEL)

AddHUDTexElement("Radar_Altitude_Index", 
				{{-1.0, -3.0}, {-1.0, 3.0}, 
				{1.0, 3.0}, {1.0, -3.0}},
				{17.755/texture_size, 1.105/texture_size, tex_scale, tex_scale},
				{{"Radar_Altitude_Scale_ctrl", 1}},
				{-1.0, -52.0, 0.0},
				{0.0, 0.0, 0.0},
				"Radar_Alt_pnt",
				HUD_DEFAULT_LEVEL)
				
for i = 0, 5 do
		
	AddHUDTexElement("Radar_Altitude_tick_" .. string.format("%i", i), 
					{{-2.0, -1.0}, {-2.0, 1.0}, 
					{2.0, 1.0}, {2.0, -1.0}},
					{17.65/texture_size, 0.24/texture_size, tex_scale, tex_scale},
					nil,
					{1.5, -50.0 + i * 13, 0.0},
					{0.0, 0.0, 0.0},
					"Radar_Alt_pnt",
					HUD_DEFAULT_LEVEL)
					
					
	AddHUDTextElement_Pos_Val("Radar_Altitude_" .. string.format("%i", i), 
					  nil, 
					  {2.0, 0.0, 0.0}, 
					  "Radar_Altitude_tick_" .. string.format("%i", i),
					  HUD_DEFAULT_LEVEL,
					  "LeftCenter",
					  string.format("%i", i))
end
				
				
AddHUDTexElement("Radar_Altitude_tick_10", 
				{{-2.0, -1.0}, {-2.0, 1.0}, 
				{2.0, 1.0}, {2.0, -1.0}},
				{17.65/texture_size, 0.24/texture_size, tex_scale, tex_scale},
				nil,
				{1.5, 32.5, 0.0},
				{0.0, 0.0, 0.0},
				"Radar_Alt_pnt",
				HUD_DEFAULT_LEVEL)
				
AddHUDTextElement_Pos_Val("Radar_Altitude_10", 
				  nil, 
				  {2.0, 0.0, 0.0}, 
				  "Radar_Altitude_tick_10",
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  "10")
				  
				  
AddHUDTexElement("Radar_Altitude_tick_15", 
				{{-2.0, -1.0}, {-2.0, 1.0}, 
				{2.0, 1.0}, {2.0, -1.0}},
				{17.65/texture_size, 0.24/texture_size, tex_scale, tex_scale},
				nil,
				{1.5, 50.0, 0.0},
				{0.0, 0.0, 0.0},
				"Radar_Alt_pnt",
				HUD_DEFAULT_LEVEL)				  
				  
AddHUDTextElement_Pos_Val("Radar_Altitude_15", 
				  nil, 
				  {2.0, 0.0, 0.0}, 
				  "Radar_Altitude_tick_15",
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  "15")

				  
				  
AddHUDTexElement("Radar_Altitude_T_Index", 
				{{-1.0, -3.0}, {-1.0, 3.0}, 
				{1.0, 3.0}, {1.0, -3.0}},
				{17.755/texture_size, 1.105/texture_size, tex_scale, tex_scale},
				{{"Radar_Altitude_T_Index"}},
				{-2.8, -50.0, 0.0},
				{90.0, 0.0, 0.0},
				"Radar_Alt_pnt",
				HUD_DEFAULT_LEVEL)

AddHUDTexElement("Radar_Altitude_T_Index1", 
				{{-2.0, -1.0}, {-2.0, 1.0}, 
				{2.0, 1.0}, {2.0, -1.0}},
				{17.65/texture_size, 0.24/texture_size, tex_scale, tex_scale},
				nil,
				{0.5, 2.0, 0.0},
				{0.0, 0.0, 0.0},
				"Radar_Altitude_T_Index",
				HUD_DEFAULT_LEVEL)		

DLZ_PlaceHolder				= CreateDummy()
DLZ_PlaceHolder.name		= "DLZ_PlaceHolder"
DLZ_PlaceHolder.init_pos	= FROM_HUD_CENTER(-100.0, -1.3)
DLZ_PlaceHolder.controllers	= {{"MasterArmSafe", 0}, {"DLZ_show"}, {"shift_pos_tapes_visible", -12.0}}
Add(DLZ_PlaceHolder)

AddHUDTexElement("DLZ_Upper_TIC", 
				{{-9.0, -1.0}, {-9.0, 1.0}, 
				 {1.0, 1.0}, {1.0, -1.0}},
				{16.01/texture_size, 7.38/texture_size, tex_scale, tex_scale},
				nil,
				{-2.0, 25.0, 0.0},
				{0.0, 0.0, 0.0},
				"DLZ_PlaceHolder",
				HUD_DEFAULT_LEVEL)

AddHUDTexElement("DLZ_Lower_TIC", 
				{{-9.0, -1.0}, {-9.0, 1.0}, 
				 {1.0, 1.0}, {1.0, -1.0}},
				{16.01/texture_size, 7.38/texture_size, tex_scale, tex_scale},
				nil,
				{-2.0, -25.0, 0.0},
				{0.0, 0.0, 0.0},
				"DLZ_PlaceHolder",
				HUD_DEFAULT_LEVEL)

DLZ_StaplePlaceHolder				 = CreateDummy()
DLZ_StaplePlaceHolder.name			 = "DLZ_StaplePlaceHolder"
DLZ_StaplePlaceHolder.controllers	 = {{"DLZ_Staple_show", math.rad(30)}}
DLZ_StaplePlaceHolder.parent_element = "DLZ_PlaceHolder"
Add(DLZ_StaplePlaceHolder)

AddHUDTexElement("DLZ_Staple_Upper", 
				{{-8.4, -1.0}, {-8.4, 1.0}, 
				 {1.0, 1.0}, {1.0, -1.0}},
				{16.01/texture_size, 7.74/texture_size, tex_scale, tex_scale},
				{{"DLZ_Staple_horiz", 1, 50, 15}},
				{-2.0, 0.0, 0.0},
				{0.0, 0.0, 0.0},
				"DLZ_StaplePlaceHolder",
				HUD_DEFAULT_LEVEL)

AddHUDTexElement("DLZ_Staple_Lower", 
				{{-8.4, -1.0}, {-8.4, 1.0}, 
				 {1.0, 1.0}, {1.0, -1.0}},
				{16.01/texture_size, 7.74/texture_size, tex_scale, tex_scale},
				{{"DLZ_Staple_horiz", 2, 50, 15}},
				{-2.0, 0.0, 0.0},
				{0.0, 0.0, 0.0},
				"DLZ_StaplePlaceHolder",
				HUD_DEFAULT_LEVEL)

addHWLine("DLZ_Staple_Left", 50, 50, {{"DLZ_Staple_vert", 50, 15}}, {-7.4, 0, 0.0}, {90.0, 0.0, 0.0}, "DLZ_Staple_Lower", HUD_DEFAULT_LEVEL)

AddHUDTexElement("DLZ_Index", 
				{{-2.5, -3.8}, {-2.5, 3.8}, 
				 {2.5, 3.8}, {2.5, -3.8}},
				{17.58/texture_size, 8.69/texture_size, tex_scale, tex_scale},
				{{"WOW", 0}, {"DLZ_Index_pos", 50, 15}},
				{-12.0, 25.0, 0.0},
				{0.0, 0.0, 0.0},
				"DLZ_Lower_TIC",
				HUD_DEFAULT_LEVEL)
				
AddHUDTextElement_Pos("DLZ_Index_txt", 
				  {{"DLZ_Index_Txt"}}, 
				   {-4.5, 0.0, 0.0}, 
				  "DLZ_Index",
				  HUD_DEFAULT_LEVEL,
				  "RightCenter")
				
AddHUDTextElement_Pos("Altitude_Numerics", 
				  {{"disp_opt_tapes_visible", 0}, {"alt_num_txt", 0.1667}},
				  FROM_HUD_CENTER(101, 0.0), 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "RightCenter", 2)

AddHUDTextElement_Pos("Airspeed Numerics", 
				  {{"disp_opt_tapes_visible", 0}, {"air_speed_num_txt", 0.1667}},
				  FROM_HUD_CENTER(-70, 0.0), 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "RightCenter", 2)

AddHUDTextElement_Pos("Required_Airspeed_Display", 
				  {{"disp_opt_tapes_visible", 0}, {"Required_Airspeed_txt"}}, 
				  FROM_HUD_CENTER(-70.3, -12.5), 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "RightCenter")						   
				  
AddHUDTextElement_Pos("Mach_Display", 
				  {{"Mach_txt"}}, 
				  FROM_HUD_CENTER(-70.3, -12.5), 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "RightCenter")						   				  

AddHUDTextElement_Pos("Depression_Numeric", 
				  {{"DTSAS_or_Depression", 1}, {"Depression_Numeric_txt"}}, 
				  FROM_HUD_CENTER(-70.3, -76.5), 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "RightCenter")
				  
AddHUDTextElement_Pos("G_Meter_Display", 
				  {{"EGI_attitude_on"},{"G_Meter_Display_txt"}}, 
				  FROM_HUD_CENTER(-70, 66.5),
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "RightCenter")

-- The position was changed in last software versions
AddHUDTextElement_Pos_Val("HUD_SOI_Indicator", 
				  {{"shift_pos_tapes_visible", -25.0}, {"HUD_SOI_Indicator_txt"}}, 
				  FROM_HUD_CENTER(-71, -42), 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "RightCenter",
				  "*")

--[[AddHUDTextElement_Pos_Val("Targ_Pod_Designator_Training_mode", 
				  {{"shift_pos_tapes_visible", -25.0}, {"Targ_Pod_Designator_Training_mode"}}, 
				  {-90, -33.3, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "RightCenter",
				  "T")]]
				  
-- The position was changed in last software versions
AddHUDTextElement_Pos("Targ_Pod_Design_Type", 
				  {{"shift_pos_tapes_visible", -25.0}, {"Targ_Pod_Design_Type_txt", 0.1667}}, 
				  FROM_HUD_CENTER(-80.5, -33.3), 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "RightCenter")

-- The position was changed in last software versions
AddHUDTextElement_Pos_Formats("TGP_Mask_SPI_ON_Ind_txt", 
				  {{"shift_pos_tapes_visible", -25.0}, {"TGP_Mask_SPI_ON_Ind_txt", 0.1667}},
				  FROM_HUD_CENTER(-71, -33.3), 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "RightCenter",
				  {"M", "S"})

AddHUDTextElement_Pos("DTSAS_Status_EGI_Mode", 
				  {{"EGI_power_on"}, {"DTSAS_or_Depression", 2}, {"DTSAS_Status_EGI_Mode_txt"}}, 
				  FROM_HUD_CENTER(-70, -76.5), 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "RightCenter")
		  		  
AddHUDTextElement_Pos_Val("EAC_Msg_PATH_HLD", 
				  {{"EAC_Message_txt", 0}},
				  FROM_HUD_CENTER(-70, -89), 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "RightCenter",
				  "PATH HLD")

AddHUDTextElement_Pos_Val("EAC_Msg_ALT_HLD", 
				  {{"EAC_Message_txt", 1}},
				  FROM_HUD_CENTER(-70, -89), 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "RightCenter",
				  "ALT HLD")

AddHUDTextElement_Pos_Val("EAC_Msg_ALT_HDG",
				  {{"EAC_Message_txt", 2}},
				  FROM_HUD_CENTER(-70, -89), 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "RightCenter",
				  "ALT/HDG")

AddHUDTextElement_Pos_Val("EAC_Msg_ALT_PAC_1",
				  {{"EAC_Message_txt", 3}},
				  FROM_HUD_CENTER(-70, -89), 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "RightCenter",
				  "PAC-1")

AddHUDTextElement_Pos_Val("EAC_Msg_ALT_PAC_2",
				  {{"EAC_Message_txt", 4}},
				  FROM_HUD_CENTER(-70, -89), 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "RightCenter",
				  "PAC-2")


------------------------------

AddHUDTextElement_Pos_Val("Weapons_Event_Marker", 
				  {{"Weapons_Event_Marker_txt"}}, 
				  FROM_HUD_CENTER(80, 102.5), 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "CenterCenter",
				  "W")

AddHUDTextElement_Pos("Flight_Path_Angle", 
				  {{"EGI_attitude_on"}, {"shift_pos_tapes_visible", -30.0}, {"flight_path_angle_num_txt"}}, 
				  FROM_HUD_CENTER(95, -16), 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "RightCenter", 2)
				  
AddHUDTextElement_Pos("HARS_Pitch", 
				  {{"HARS_on"},{"shift_pos_tapes_visible", -30.0}, {"HARS_pitch_angle_num_txt"}}, 
				  FROM_HUD_CENTER(95, -16), 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "RightCenter", 2)
				  
local len = 21
local halfheight = 5
local horshift = 2
local vertshift = 0.3
addHWLine("HARSPitchBoxLine1", len, len, {}, 
			{horshift - len, halfheight + vertshift, 0}, {0, 0, 0}, "HARS_Pitch", HUD_DEFAULT_LEVEL)

addHWLine("HARSPitchBoxLine2", len, len, {}, 
			{horshift - len , -halfheight + vertshift, 0}, {0, 0, 0}, "HARS_Pitch", HUD_DEFAULT_LEVEL)

addHWLine("HARSPitchBoxLine3", halfheight * 2, halfheight * 2, {}, 
			{horshift - len, -halfheight + vertshift, 0}, {90, 0, 0}, "HARS_Pitch", HUD_DEFAULT_LEVEL)

addHWLine("HARSPitchBoxLine4", halfheight * 2, halfheight * 2, {}, 
			{horshift, -halfheight + vertshift, 0}, {90, 0, 0}, "HARS_Pitch", HUD_DEFAULT_LEVEL)
------------------------------------			  
				  
AddHUDTextElement_Pos("Anchor_Point_Display1", 
				  {{"Anchor_Point_Display1_txt"}}, 
				  FROM_HUD_CENTER(70, 79), 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")				  
				  
AddHUDTextElement_Pos("Anchor_Point_Display2", 
				  {{"Anchor_Point_Display2_txt"}}, 
				  FROM_HUD_CENTER(70, 66.5), 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")				  
				  
AddHUDTextElement_Pos("Radar_Altitude_Numerics", 
				  {{"radar_altitude_numerics_txt"}}, 
				  FROM_HUD_CENTER(70, -64), 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")

--[[
for i = 1,5 do
local txt			        = CreateElement "ceStringPoly"
      txt.material	        = "font_HUD"
      txt.alignment	        = "CenterCenter"
      txt.stringdefs	    = predefined_font_2
      txt.additive_alpha	= true
      txt.collimated		= true
      txt.value             = "X"
      txt.controllers		= {{"closest_friendly_unit_position",i-1,ZSL}}
	  txt.h_clip_relation	= h_clip_relations.COMPARE
      txt.level			= HUD_DEFAULT_LEVEL
      txt.use_mipfilter	= use_mipfilter
      Add(txt)    
end
--]]

-- Tapes
delta = 6

function AddVerticalTapePnt(name, parent, pos_x, index, level, is_short, align_left)
	controllers = nil
	
	local element
	local align_shift = 1.0
	if align_left then
		align_shift = -align_shift
	end
	
	if is_short then
		element = AddHUDTexElement(name, 
					{{-2.0, -1.0}, {-2.0, 1.0}, 
					{2.0, 1.0}, {2.0, -1.0}}, 
					{0.931, 0.036, tex_scale, tex_scale},
					controllers,
					{pos_x + align_shift, index * delta, 0.0},
					{0.0, 0.0, 0.0},
					parent,
					level)
	else
		element = AddHUDTexElement(name, 
					{{-3.5, -1.0}, {-3.5, 1.0}, 
					{3.5, 1.0}, {3.5, -1.0}}, 
					{0.931, 0.014, tex_scale, tex_scale},
					controllers,
					{pos_x, index * delta, 0.0},
					{0.0, 0.0, 0.0},
					parent,
					level)
	end
					
	element.isdraw = true
	
	return element
end

function AddVerticalTapeText(name, parent, init_pos, level, align)
	txt = AddHUDTextElement_Pos(name, 
					  nil, --{{"alt_tape_num_txt", 0}},
					  init_pos, 
					  parent.name,
					  level,
					  align)
	return txt
end

-- Vertical Velocity Scale
--VVS_center_pnt = AddVerticalTapePnt("VVS_center_pnt", nil, 120, 0, HUD_DEFAULT_LEVEL)
VVS_center_pnt = AddVerticalTapePnt("VVS_center_pnt", nil, 112.8, 0, HUD_DEFAULT_LEVEL)
VVS_center_pnt.controllers = {{"Vertical_Velocity_Scale_visible"}}

for i = 1, 5 do
	local short_tick = (i % 5) ~= 0
	AddVerticalTapePnt("VVS_pnt_"..string.format("%i", i), VVS_center_pnt.name, 0, i, HUD_DEFAULT_LEVEL, short_tick)
	AddVerticalTapePnt("VVS_pnt_"..string.format("%i", i + 5), VVS_center_pnt.name, 0, -i, HUD_DEFAULT_LEVEL, short_tick)
end

local VVS_K = 1.333 * delta * 5
AddHUDTexElement("VVS_caret", 
					{{0.0, -3.0}, {8.0, 3.0}, 
					{0.0, 3.0}, {8.0, -3.0}}, 
					{0.926, 0.12, tex_scale, tex_scale},
					{{"Vertical_Velocity_Scale_caret", VVS_K * GetScale()}},
					{3.1, 0.0, 0.0},
					{0.0, 0.0, 0.0},
					VVS_center_pnt.name,
					HUD_DEFAULT_LEVEL)
					
addHWLine("VVS_line", 0, 340, {{"Vertical_Velocity_Scale_line", VVS_K * GetScale(), VVS_K}},
	{3.1, 0.0, 0.0}, {90.0, 0.0, 0.0}, VVS_center_pnt.name, HUD_DEFAULT_LEVEL)

local AS_ALT_Tape_pos = 74.5

-- Altitude Tape
AltTape_border_sizeX = 30
AltTape_border_sizeY = delta * 14.4 / 2
AltTape_border = CreateElement "ceMeshPoly"
AltTape_border.name = "AltTape_border"
AltTape_border.primitivetype = "triangles"
AltTape_border.vertices = {{-6, -AltTape_border_sizeY},
									{-6, AltTape_border_sizeY},
									{AltTape_border_sizeX, AltTape_border_sizeY},
									{AltTape_border_sizeX, -AltTape_border_sizeY}}
AltTape_border.indices  = default_box_indices
AltTape_border.init_pos = FROM_HUD_CENTER(AS_ALT_Tape_pos, 0)
AltTape_border.material = "DBG_RED"
AltTape_border.h_clip_relation = h_clip_relations.INCREASE_IF_LEVEL
AltTape_border.level			 = HUD_DEFAULT_LEVEL
AltTape_border.collimated		 = true
AltTape_border.isdraw = true
AltTape_border.isvisible = false
Add(AltTape_border)

AltTape_org				= CreateDummy()
AltTape_org.name		= "AltTape_org"
AltTape_org.controllers	= {{"BaroAlt_avail"}, {"disp_opt_tapes_visible", 1}, {"flash_on_master_caution", 0.1667}}
--AltTape_org.controllers	= {{"disp_opt_tapes_visible", 1}, {"flash_on_master_caution", 0.1667}}
AltTape_org.init_pos	= FROM_HUD_CENTER(AS_ALT_Tape_pos, 0)
Add(AltTape_org)

AltTape_caret = AddHUDTexElement("AltTape_caret", 
					{{-6.0, -3.0}, {-6.0, 3.0}, 
					{1.0, 3.0}, {1.0, -3.0}}, 
					{0.961, 0.164, tex_scale, tex_scale},
					nil,
					{0.0, 0.0, 0.0},
					{0.0, 0.0, 0.0},
					"AltTape_org",
					HUD_DEFAULT_LEVEL + 1)

AltTape_center_tick = AddVerticalTapePnt("AltTape_center_tick", "AltTape_org", 2, 0, HUD_DEFAULT_LEVEL + 1)
AltTape_center_tick.controllers = {{"Altitude_Tape_position", delta * GetScale()}}

txt = AddVerticalTapeText("AltTape_Numerics",
				AltTape_center_tick,
				{4, 0.0, 0.0},
				HUD_DEFAULT_LEVEL + 1,
				"LeftCenter")
txt.controllers = {{"Altitude_Tape_numerics", 0}}

for i = 1, 10 do
	local short_tick = (i % 5) ~= 0
	
	local tick = AddVerticalTapePnt("AltTape_tick_"..string.format("%i", i), "AltTape_center_tick", 0, i, HUD_DEFAULT_LEVEL + 1, short_tick, true)
	if not short_tick then
		txt = AddVerticalTapeText("AltTape_Numerics"..string.format("%i", i),
				tick,
				{4, 0.0, 0.0},
				HUD_DEFAULT_LEVEL + 1,
				"LeftCenter")
		txt.controllers = {{"Altitude_Tape_numerics", i / 5}}
	end
	
	tick = AddVerticalTapePnt("AltTape_tick_"..string.format("%i", i + 10), "AltTape_center_tick", 0, -i, HUD_DEFAULT_LEVEL + 1, short_tick, true)
	if not short_tick then
		txt = AddVerticalTapeText("AltTape_Numerics"..string.format("%i", i + 10),
				tick,
				{4, 0.0, 0.0},
				HUD_DEFAULT_LEVEL + 1,
				"LeftCenter")
		txt.controllers = {{"Altitude_Tape_numerics", -i / 5}}
	end
end

AltTape_border1 = CreateElement "ceMeshPoly"
AltTape_border1.name = "AltTape_border1"
AltTape_border1.primitivetype = "triangles"
AltTape_border1.vertices = {{-6, -AltTape_border_sizeY},
									{-6, AltTape_border_sizeY},
									{AltTape_border_sizeX, AltTape_border_sizeY},
									{AltTape_border_sizeX, -AltTape_border_sizeY}}
AltTape_border1.indices  = default_box_indices
AltTape_border1.init_pos = FROM_HUD_CENTER(AS_ALT_Tape_pos, 0)
AltTape_border1.material = "DBG_BLACK"
AltTape_border1.h_clip_relation = h_clip_relations.DECREASE_IF_LEVEL
AltTape_border1.level			= HUD_DEFAULT_LEVEL + 1
AltTape_border1.collimated	= true
AltTape_border1.isdraw = true
AltTape_border1.isvisible = false
Add(AltTape_border1)

-- Airspeed Tape
ASTape_border_sizeX = 30
ASTape_border_sizeY = delta * 14.4 / 2
ASTape_border = CreateElement "ceMeshPoly"
ASTape_border.name = "ASTape_border"
ASTape_border.primitivetype = "triangles"
ASTape_border.vertices = {{-ASTape_border_sizeX, -ASTape_border_sizeY},
									{-ASTape_border_sizeX, ASTape_border_sizeY},
									{12, ASTape_border_sizeY},
									{12, -ASTape_border_sizeY}}
ASTape_border.indices  = default_box_indices
ASTape_border.init_pos = FROM_HUD_CENTER(-AS_ALT_Tape_pos, 0)
ASTape_border.material = "DBG_RED"
ASTape_border.h_clip_relation = h_clip_relations.INCREASE_IF_LEVEL
ASTape_border.level	= HUD_DEFAULT_LEVEL
ASTape_border.collimated = true
ASTape_border.isdraw = true
ASTape_border.isvisible = false
Add(ASTape_border)

ASTape_org			= CreateDummy()
ASTape_org.name		= "ASTape_org"
ASTape_org.controllers	= {{"AirSpeed_avail"}, {"disp_opt_tapes_visible", 1}, {"flash_on_master_caution", 0.1667}}
--ASTape_org.controllers	= {{"disp_opt_tapes_visible", 1}, {"flash_on_master_caution", 0.1667}}
ASTape_org.init_pos	= FROM_HUD_CENTER(-AS_ALT_Tape_pos, 0)
Add(ASTape_org)

ASTape_caret = AddHUDTexElement("ASTape_caret", 
					{{-6.0, -3.0}, {-6.0, 3.0}, 
					{1.0, 3.0}, {1.0, -3.0}}, 
					{0.961, 0.164, tex_scale, tex_scale},
					nil,
					{0.0, 0.0, 0.0},
					{180.0, 0.0, 0.0},
					ASTape_org.name,
					HUD_DEFAULT_LEVEL + 1)

AddHUDTextElement_Pos_Formats("ASTape_speed_type", 
				  {{"Airspeed_Tape_speed_type"}},
				  {7.0, 0.0, 0.0}, 
				  ASTape_org.name,
				  HUD_DEFAULT_LEVEL + 1,
				  "LeftCenter",
				  {"T", "G"})
				  

AddHUDTextElement_Pos_Formats("SPI_Status",
				  {{"EGI_on"},{"SPI_Status"}},
				  FROM_HUD_CENTER(-70, -126.5),
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "RightCenter",
				  {"* ", "STPT", "TGP", "TAD", "TDC", "MAV", "IFFCC", "IAM TGT", "MARK"})				  										
					
ASTape_center_tick = AddVerticalTapePnt("ASTape_center_tick", ASTape_org.name, -2, 0, HUD_DEFAULT_LEVEL + 1)
ASTape_center_tick.controllers = {{"Airspeed_Tape_position", delta * GetScale()}}

txt = AddVerticalTapeText("ASTape_Numerics",
				ASTape_center_tick,
				{-4, 0.0, 0.0},
				HUD_DEFAULT_LEVEL + 1,
				"RightCenter")
txt.controllers = {{"Airspeed_Tape_numerics", 0}}



for i = 1, 10 do
	local short_tick = (i % 5) ~= 0

	local tick = AddVerticalTapePnt("ASTape_tick_"..string.format("%i", i), "ASTape_center_tick", 0, i, HUD_DEFAULT_LEVEL + 1, short_tick)
	if not short_tick then
		txt = AddVerticalTapeText("ASTape_Numerics"..string.format("%i", i),
						tick,
						{-4, 0.0, 0.0},
						HUD_DEFAULT_LEVEL + 1,
						"RightCenter")
		txt.controllers = {{"Airspeed_Tape_numerics", i / 5}}
	end
	
	tick = AddVerticalTapePnt("ASTape_tick_"..string.format("%i", i + 10), "ASTape_center_tick", 0, -i, HUD_DEFAULT_LEVEL + 1, short_tick)
	if not short_tick then
		txt = AddVerticalTapeText("ASTape_Numerics"..string.format("%i", i + 10),
						tick,
						{-4, 0.0, 0.0},
						HUD_DEFAULT_LEVEL + 1,
						"RightCenter")
		txt.controllers = {{"Airspeed_Tape_numerics", -i / 5}}
	end
end

ASTape_border1 = CreateElement "ceMeshPoly"
ASTape_border1.name = "ASTape_border1"
ASTape_border1.primitivetype = "triangles"
ASTape_border1.vertices = {{-ASTape_border_sizeX, -ASTape_border_sizeY},
									{-ASTape_border_sizeX, ASTape_border_sizeY},
									{12, ASTape_border_sizeY},
									{12, -ASTape_border_sizeY}}
ASTape_border1.indices  = default_box_indices
ASTape_border1.init_pos = FROM_HUD_CENTER(-AS_ALT_Tape_pos, 0)
ASTape_border1.material = "DBG_BLACK"
ASTape_border1.h_clip_relation = h_clip_relations.DECREASE_IF_LEVEL
ASTape_border1.level			= HUD_DEFAULT_LEVEL + 1
ASTape_border1.collimated	= true
ASTape_border1.isdraw = true
ASTape_border1.isvisible = false
Add(ASTape_border1)

ASTape_required = AddHUDTexElement("ASTape_required", 
					{{-0.2, -3.0}, {-0.2, 3.0}, 
					{8.0, 3.0}, {8.0, -3.0}}, 
					{0.927, 0.211, tex_scale, tex_scale},
					{{"disp_opt_tapes_visible", 1}, {"flash_on_master_caution", 0.1667}, {"Airspeed_Tape_required_visible", 1}, {"Airspeed_Tape_required_pos", delta * GetScale(),ASTape_border_sizeY * GetScale() }},
					FROM_HUD_CENTER(-AS_ALT_Tape_pos, 0),
					{0.0, 0.0, 0.0},
					nil,
					HUD_DEFAULT_LEVEL)

ASTape_required_txt = AddHUDTextElement_Pos_Val("ASTape_invalid_required_txt", 
				  {{"disp_opt_tapes_visible", 1}, {"Airspeed_Tape_required_visible", 0}, {"flash_on_master_caution", 0.1667}}, 
				  FROM_HUD_CENTER(-AS_ALT_Tape_pos + 1, 8 * delta), 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "RightCenter",
				  "RXXX")

borderGCAS_sizeX = 17.29
borderGCAS_sizeY = 11				  


GCAS_TrnMsg_Ctrls = {{"hud_mode_txt", 0}, {"CCIP_INVALID_msg", 0}, {"CCRP_INVALID_msg", 0}, {"InvalidFuzing_msg", 0},
	{"AltWarnSettingText", -1}, {"Delta_EGI_RadarElevation", 0}, {"MarkpointElevation", 0},
	{"Use_CCRP_msg", 0}, {"GCAS_symbol_show"}}

-- Commented as GCAS training message is not a Type 1 symbol,
-- and it should be occulted by aiming symbology.
--[[
borderGCAS_Verts = {{-borderGCAS_sizeX, -borderGCAS_sizeY},
					{-borderGCAS_sizeX, borderGCAS_sizeY},
					{borderGCAS_sizeX, borderGCAS_sizeY},
					{borderGCAS_sizeX, -borderGCAS_sizeY}
					}

borderGCAS = addType1SymBorder("borderGCAS", borderGCAS_Verts, nil, FROM_HUD_CENTER(0, 24), GCAS_TrnMsg_Ctrls)

GCAS_training_sym = AddHUDTextElement_Pos_Val("GCAS_training_sym", 
				  nil,
				  {0, 0}, 
				  borderGCAS.name,
				  HUD_DEFAULT_LEVEL + 2,
				  "CenterCenter",
				  "GCAS",
				  2)	
--]]
				  
GCAS_training_sym = AddHUDTextElement_Pos_Val("GCAS_training_sym", 
				  GCAS_TrnMsg_Ctrls,
				  FROM_HUD_CENTER(0, 24),
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "CenterCenter",
				  "GCAS",
				  2)	

IFF_alert_mode1_sym = AddHUDTextElement_Pos_Val("IFF_alert_mode1_sym", 
				  {{"Iff_mode_show",1, 0.125}},  -- 1 - mode, 0.125- blink interval 4Hz
				  FROM_HUD_CENTER(-70.0, 80), 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "RightCenter",
				  "MODE 1",1)					  
				  
IFF_alert_mode4_sym = AddHUDTextElement_Pos_Val("IFF_alert_mode4_sym", 
				 {{"Iff_mode_show",4, 0.125}}, 
				  FROM_HUD_CENTER(-70.0, 80), 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "RightCenter",
				  "MODE 4",1)				  
				  