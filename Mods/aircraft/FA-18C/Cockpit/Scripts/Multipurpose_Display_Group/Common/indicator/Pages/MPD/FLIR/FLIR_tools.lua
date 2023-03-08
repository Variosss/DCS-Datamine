dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/FLIR/FLIR_Defs.lua")

local AFLIR_COORD = 
{
	ALL 	= 0,
	LAT_LON = 1,
	GRID	= 2,
	OFF		= 3,
};

function set_as_invisible_mask(obj)
	local show_masks = false
	obj.isvisible = show_masks
	obj.material  = "MASK_MATERIAL"
end

local function SetScreenSpace(object)
	object.h_clip_relation = h_clip_relations.NULL
	object.screenspace = 2
end

--addMesh(name, vertices, indices, pos, primitives, parent, controllers, material)

local boxSz  = 2
local holeSz = 1
local lt_up = 390/512
local lt_dn = 450/512

local tgp_roll_stab_artifact_vert_L = {{-boxSz, boxSz}, {boxSz, boxSz}, {boxSz,-boxSz}, {-boxSz,-boxSz},
									 {-holeSz, lt_up}, {holeSz, lt_up}, {holeSz,-lt_dn}, {-holeSz,-lt_dn}}
local tgp_roll_stab_artifact_vert_A = {{-boxSz, boxSz}, {boxSz, boxSz}, {boxSz,-boxSz}, {-boxSz,-boxSz},
									 {-holeSz, holeSz}, {holeSz, holeSz}, {holeSz,-holeSz}, {-holeSz,-holeSz}}
local tgp_roll_stab_artifact_indices = {0,1,4;4,1,5; 1,2,5;5,2,6; 2,3,6;3,6,7; 3,0,7;7,0,4}

local dot_vertices	= {{-0.005, 0.005},
						{ 0.005, 0.005},
						{ 0.005,-0.005},
						{-0.005,-0.005}}

-- start VIDEO
function AddRenderFLIR()
	-- Add base
	local	verts = {{-512,  512},
					 { 512,  512}, 
					 { 512, -512},		--x, 400
					 {-512, -512}}		--x, 400

	local function AddBack()
		local	back					= CreateElement "ceMeshPoly"
				back.primitivetype		= "triangles"
				back.vertices			= verts
				back.indices			= box_ind
				set_as_invisible_mask(back)
				back.level				= DEFAULT_LEVEL
				back.h_clip_relation	= h_clip_relations.REWRITE_LEVEL
			Add(back)
	end
	AddBack()
	
	local	render_base					= CreateElement  "ceSimple"
			render_base.controllers		= {{"MPD_FLIR_TV_Render"}}
--			render_base.parent_element	= back.name
	Add(render_base)

	-- Add render CCD and IR
	local function AddRenderTV()
		local	render_tv					= CreateElement "ceTexPoly"
				render_tv.name				= "screen"
				render_tv.vertices			= verts
				render_tv.indices			= box_ind
				render_tv.tex_params		= {0.5,0.5, 1.0/flir_max_size_DI, 1.0/flir_max_size_DI}
				---------------------------------------------------------------------------------------
				render_tv.material			= "render_target_"..string.format("%d",GetRenderTarget() + 1)
				---------------------------------------------------------------------------------------
				--render_tv.controllers		= {	{"video_brightness",0.1,1.0,1.0/63.0},
				--								{"video_contrast"  ,0  ,1.0,1.0/32.0}}
				render_tv.level 			= DEFAULT_LEVEL
				render_tv.h_clip_relation	= h_clip_relations.COMPARE
				render_tv.parent_element	= render_base.name
				render_tv.additive_alpha	= true
				render_tv.input_space_SRGB 	= true
		Add(render_tv)
	end
	AddRenderTV()

	local tgp_roll_stabilize_artifact_L = addMesh("MPD_FLIR_roll_stabilize_artifact_L", tgp_roll_stab_artifact_vert_L, tgp_roll_stab_artifact_indices,
				{0, 0}, "triangles", nil, {{"MPD_FLIR_TgpType", LITENING}, {"MPD_FLIR_roll_stabilize_artifact",1,1,1}}, "TGP_STBY_DGRAY")
	SetScreenSpace(tgp_roll_stabilize_artifact_L)
	local tgp_roll_stabilize_artifact_A = addMesh("MPD_FLIR_roll_stabilize_artifact_A", tgp_roll_stab_artifact_vert_A, tgp_roll_stab_artifact_indices,
				{0, 0}, "triangles", nil, {{"MPD_FLIR_TgpType", ATFLIR}, {"MPD_FLIR_roll_stabilize_artifact",1,1,1}}, "TGP_STBY_DGRAY")
	SetScreenSpace(tgp_roll_stabilize_artifact_A)

	--
	local lineW = 0.01

	-- FOV bracket
	local function AddNarrowBracket(name, pos, sz, controllers)
		local	base_obj		= addPlaceholder("MPD_FLIR_NarrowBase"..name, {0,0}, nil, controllers)
				SetScreenSpace(base_obj)
				
		for num = 1, 4 do
			local	base_seg	= addPlaceholder("MPD_FLIR_NarrowSegmentBase"..name..num, {0,0}, base_obj.name, {{"MPD_FLIR_SP_bracket", pos*0.2, num}})
					base_seg.init_rot = {90 * (num-1)}
					SetScreenSpace(base_seg)
			local	line1 = addMesh("MPD_FLIR_NarrowSegment1_"..name..num, {{0, 0}, {sz, 0}, {sz,-lineW}, {0,-lineW}},
								box_ind, {-pos, pos}, "triangles", base_seg.name, nil, "INDICATION_COMMON_WHITE")
					SetScreenSpace(line1)
			local	line2 = addMesh("MPD_FLIR_NarrowSegment2_"..name..num, {{0, 0}, {lineW, 0}, {lineW,-sz}, {0,-sz}},
								box_ind, {-pos, pos}, "triangles", base_seg.name, nil, "INDICATION_COMMON_WHITE")
					SetScreenSpace(line2)
		end
		--
	end

	AddNarrowBracket("TV", 1/3.5,	 0.1, {{"MPD_FLIR_TgpType", LITENING}, {"MPD_FLIR_blinking", 50}, {"MPD_FLIR_FOV"}, {"MPD_FLIR_video_mode",0}})
	AddNarrowBracket("IR", 1.3/4.5, 0.1, {{"MPD_FLIR_TgpType", LITENING}, {"MPD_FLIR_blinking", 50}, {"MPD_FLIR_FOV"}, {"MPD_FLIR_flir"}})

	-- Crosshairs
	local function AddCrossHair(name, gate_sz_, cross_hair_sz_, parentName, controllers)
		local	base_cross_hair		= addPlaceholder(name.."_base", {0,0}, parentName, controllers)
				SetScreenSpace(base_cross_hair)
		for i = 1, 4 do
			local	line = addMesh(name..i, {{gate_sz_, 0.5*lineW}, {cross_hair_sz_, 0.5*lineW}, {cross_hair_sz_,-0.5*lineW}, {gate_sz_,-0.5*lineW}},
								box_ind, {0, 0}, "triangles", base_cross_hair.name, nil, "INDICATION_COMMON_WHITE")
					line.init_rot = {90 * (i-1)}
					SetScreenSpace(line)
		end
		return base_cross_hair
	end

	-- Yardstick
	function AddYardstick_L(parent,gate_sz,cross_hair_sz)
		local	yardstick_sz			=  (cross_hair_sz - 0.5 * gate_sz) * 0.48
		local	tgp_yardstick			= {}
		local	tgp_yardstick_formats	= {{"%.fM"},{"%.fF"}}
		local	tgp_yardstick_control	= {{"MPD_FLIR_yardstick_value", 0, yardstick_sz, 1},
											{"MPD_FLIR_yardstick_value", 0, yardstick_sz, 3.28084}}
		for i = 1, 2 do
			tgp_yardstick[i]					= CreateElement "ceStringPoly"
			tgp_yardstick[i].material			= "font_TGP"
			tgp_yardstick[i].alignment			= "RightBottom"
			tgp_yardstick[i].stringdefs			= {0.0055, 0.0055,0,0}
			tgp_yardstick[i].init_pos			= {0.55,0.03}
			tgp_yardstick[i].formats 			= tgp_yardstick_formats[i]
			tgp_yardstick[i].controllers		= {{"MPD_FLIR_master_mode_is_AA", 0}, 
													{"MPD_FLIR_yardstick_metric", i},
													tgp_yardstick_control[i]}
			tgp_yardstick[i].parent_element		= parent.name
			Add(tgp_yardstick[i])
			SetScreenSpace(tgp_yardstick[i])
		end
	end

	function AddYardstick_A(parent,gate_sz,cross_hair_sz, name)
		local	yardstick_sz			=  (cross_hair_sz - 0.5 * gate_sz) * 0.48
		local	tgp_yardstick			= {}
		local	tgp_yardstick_formats	= {{"%.fM"},{"%.fF"}}
		local	tgp_yardstick_control	= {{"MPD_FLIR_yardstick_value", 0, yardstick_sz, 1},
											{"MPD_FLIR_yardstick_value", 0, yardstick_sz, 3.28084}}
		for i = 1, 2 do
			tgp_yardstick[i]					= CreateElement "ceStringPoly"
			tgp_yardstick[i].material			= "font_TGP"
			tgp_yardstick[i].alignment			= "LeftTop"
			tgp_yardstick[i].stringdefs			= {0.0055, 0.0055,0,0}
			tgp_yardstick[i].init_pos			= {0.10,-0.13}
			tgp_yardstick[i].formats 			= tgp_yardstick_formats[i]
			tgp_yardstick[i].controllers		= {{"MPD_FLIR_master_mode_is_AA", 0}, 
													{"MPD_FLIR_yardstick_metric", i},
													tgp_yardstick_control[i]}
			tgp_yardstick[i].parent_element		= parent.name
			Add(tgp_yardstick[i])
			SetScreenSpace(tgp_yardstick[i])
		end

		local inr_line_vertices		= {	{gate_sz, lineW}, {cross_hair_sz, lineW}, {cross_hair_sz,0}, {gate_sz,0} }
		local inr_line				= addMesh("MPD_AFLIR_Yardstick_INR_line"..name, inr_line_vertices, box_ind,
												{0,-0.125}, "triangles", parent.name, {{"MPD_FLIR_master_mode_is_AA", 0}}, "INDICATION_COMMON_WHITE")
		SetScreenSpace(inr_line)
	end

	-- Diamonds
	local function AddDiamond(boxSz, controllers, suffix)
		local diamond_root	= addPlaceholder("MPD_FLIR_Diamond_root"..suffix, {0,0}, nil, controllers)
		SetScreenSpace(diamond_root)

		local holeSz		= boxSz-lineW
		local box_indices	= {0,1,4;4,1,5; 1,2,5;5,2,6; 2,3,6;6,3,7; 3,0,7;7,0,4}
		local box_vertices	= {	{-boxSz, boxSz}, {boxSz, boxSz}, {boxSz,-boxSz}, {-boxSz,-boxSz},
								{-holeSz, holeSz}, {holeSz, holeSz}, {holeSz,-holeSz}, {-holeSz,-holeSz}}
		local box			= addMesh("MPD_FLIR_Track_Diamond"..suffix, box_vertices, box_indices, {0, 0}, "triangles", diamond_root.name,
								{{"MPD_FLIR_blinking"}}, "INDICATION_COMMON_WHITE")--, {"MPD_FLIR_TgpType", LITENING}, {"MPD_FLIR_track_diamond"}, {"MPD_FLIR_lss_active",0}}, "INDICATION_COMMON_WHITE")
		box.init_rot		= {45}
		SetScreenSpace(box)
			
		return diamond_root
	end
	
	local function AddDiamond_L()
		local diamond_root = AddDiamond(3.1/61.1, {{"MPD_FLIR_TgpType", LITENING}, {"MPD_FLIR_track_diamond"}, {"MPD_FLIR_lss_active",0}}, "LIT")
		AddYardstick_L(diamond_root, 0, 0.2)
		local boxSz	= 0.05
		local box_indices	= {0,1,2;0,2,3}--; 4,5,6;4,6,7}
		local box_vertices	= {	{-0.1-lineW, boxSz}, {-0.1, boxSz}, {-0.1,-boxSz}, {-0.1-lineW,-boxSz} }
		local box	= addMesh("MPD_FLIR_Yardstick_1", box_vertices, box_indices, {0, 0}, "triangles", diamond_root.name, nil, "INDICATION_COMMON_WHITE")
		SetScreenSpace(box)
			box_vertices	= {	{0.1+lineW, boxSz}, {0.1, boxSz}, {0.1,-boxSz}, {0.1+lineW,-boxSz} }
		local box2	= addMesh("MPD_FLIR_Yardstick_2", box_vertices, box_indices, {0, 0}, "triangles", diamond_root.name, nil, "INDICATION_COMMON_WHITE")
		SetScreenSpace(box2)
	end
	AddDiamond_L()

	-- LITENING
	local function AddCrossAndGate_L(parent, gate_sz, cross_hair_sz, suffix)
		local base_cross_hair			= addPlaceholder("MPD_FLIR_base_cross_hair"..suffix, {0,0}, parent.name, {{"MPD_FLIR_enlarged_cross_hair",0}, {"MPD_FLIR_lss_active",0}})
		SetScreenSpace(base_cross_hair)
		local base_cross_hair_enlarged	= addPlaceholder("MPD_FLIR_base_cross_hair_enlarged"..suffix, {0,0}, parent.name, {{"MPD_FLIR_enlarged_cross_hair"},   {"MPD_FLIR_lss_active",0}})
		SetScreenSpace(base_cross_hair_enlarged)

		local normal	= AddCrossHair("MPD_FLIR_normal_ch"..suffix, gate_sz, cross_hair_sz, base_cross_hair.name)
		local enlarged	= AddCrossHair("MPD_FLIR_enlarged_ch"..suffix, gate_sz, 2 * cross_hair_sz, base_cross_hair_enlarged.name)
		
		AddCrossHair("MPD_FLIR_lss_lst_ch"..suffix, gate_sz, 0.9, nil, {{"MPD_FLIR_TgpType", LITENING}, {"MPD_FLIR_lss_active"}})
		AddYardstick_L(base_cross_hair, gate_sz, cross_hair_sz)
		AddYardstick_L(base_cross_hair_enlarged, gate_sz, 2 * cross_hair_sz)
	end

	local base_CCD		= addPlaceholder("MPD_FLIR_base_CCD", {0,0}, nil, {{"MPD_FLIR_TgpType", LITENING}, {"MPD_FLIR_blinking"}, {"MPD_FLIR_track_diamond", 0},{"MPD_FLIR_video_mode", 0}})
	SetScreenSpace(base_CCD)
	local base_FLIR		= addPlaceholder("MPD_FLIR_base_FLIR", {0,0}, nil, {{"MPD_FLIR_TgpType", LITENING}, {"MPD_FLIR_blinking"}, {"MPD_FLIR_track_diamond", 0},{"MPD_FLIR_flir"}})
	SetScreenSpace(base_FLIR)

	AddCrossAndGate_L(base_CCD,	0.05,	0.2,	"_CCD_")
	AddCrossAndGate_L(base_FLIR,0.05,	0.2,	"_FLIR_")

	-- ATFLIR
	local function AddCrossAndGate_A(parent, gate_sz, cross_hair_sz, diamond_sz)
		local base_cross_hair	= addPlaceholder("MPD_AFLIR_base_cross_hair", {0,0}, parent.name, {{"MPD_FLIR_track_diamond", 0}, {"MPD_FLIR_lss_active",0}})
		local base_diamond		= AddDiamond(diamond_sz, {{"MPD_FLIR_TgpType", ATFLIR}, {"MPD_FLIR_track_diamond", 1}, {"MPD_FLIR_lss_active",0}}, "ATF")
		SetScreenSpace(base_cross_hair)
		AddCrossHair("MPD_AFLIR_normal_ch", gate_sz, cross_hair_sz, base_cross_hair.name)
		AddYardstick_A(base_diamond, 0, 0.35, "INR")
		-- FOV brackets
		local lineSz					= 0.12
		local fov_bracket_vertices		= {	{-lineSz, lineW}, {lineSz, lineW}, {lineSz,0}, {-lineSz,0} }
		local fov_bracket_indices		= {0,1,2;0,2,3}
		local pos						= cross_hair_sz + 0.05
		local fov_bracket_pos			= {{0, pos}, {pos, 0}, {0, -pos}, {-pos, 0}}
		for i = 1, 4 do
			local fov_bracket			= addMesh("MPD_AFLIR_FOV_Bracket"..i, fov_bracket_vertices, box_ind,
													fov_bracket_pos[i], "triangles", parent.name, {{"MPD_AFLIR_FOV_Bracket"}}, "INDICATION_COMMON_WHITE")
			fov_bracket.init_rot		= {90 * (i-1)}
			SetScreenSpace(fov_bracket)
		end
		
		local dot = addMesh("MPD_AFLIR_Dot", dot_vertices, box_ind, nil, "triangles", parent.name, {{"MPD_FLIR_track_diamond", 1}}, "INDICATION_COMMON_WHITE")
		SetScreenSpace(dot)
	end

	local ch_base		= addPlaceholder("MPD_AFLIR_CH_base", {0,0}, nil, {{"MPD_FLIR_TgpType", ATFLIR}, {"MPD_FLIR_blinking"}, {"MPD_AFLIR_not_tracking"}, {"MPD_FLIR_lss_active",0}})
	SetScreenSpace(ch_base)

	AddCrossAndGate_A(ch_base,	0.075, 0.45, 0.05)

	-- ATFLIR SCENE reticle
	local function AddSceneReticle()
		local base			= addPlaceholder("MPD_AFLIR_Scene_base", {0,0}, nil, {{"MPD_FLIR_TgpType", ATFLIR}, {"MPD_AFLIR_Scene_track"}})
		SetScreenSpace(base)
		local boxSz			= 0.2
		local box_indices	= {0,1,2;0,2,3}--; 4,5,6;4,6,7}
		local box_vertices	= {	{-boxSz, lineW}, {boxSz, lineW}, {boxSz, 0}, {-boxSz, 0} }
		local box	= addMesh("MPD_AFLIR_Scene_Rtcl", box_vertices, box_indices, {0, boxSz}, "triangles", base.name,
								{{"MPD_FLIR_blinking"}, {"MPD_FLIR_lss_active",0}}, "INDICATION_COMMON_WHITE")
		SetScreenSpace(box)
			box_vertices	= {	{-boxSz, -lineW}, {boxSz, -lineW}, {boxSz, 0}, {-boxSz, 0} }
		local box2	= addMesh("MPD_AFLIR_Scene_Rtcl2", box_vertices, box_indices, {0, -boxSz}, "triangles", base.name,
								{{"MPD_FLIR_blinking"}, {"MPD_FLIR_lss_active",0}}, "INDICATION_COMMON_WHITE")
		SetScreenSpace(box2)
		
		local tickSz		= 0.03
		local ticks_root	= addPlaceholder("MPD_AFLIR_Scene_ticks_root", {0,0}, base.name, {{"MPD_FLIR_blinking"}, {"MPD_AFLIR_HideInSlew"}, {"MPD_FLIR_lss_active",0}})
		SetScreenSpace(ticks_root)
		local tick_vertices	= {	{0, 0}, {lineW, 0}, {lineW, -tickSz}, {0, -tickSz} }
		local tickUp	= addMesh("MPD_AFLIR_Scene_tickUp", tick_vertices, box_indices, {-boxSz, boxSz}, "triangles", ticks_root.name,
								nil, "INDICATION_COMMON_WHITE")
		SetScreenSpace(tickUp)
		tick_vertices		= {	{0, 0}, {-lineW, 0}, {-lineW, -tickSz}, {0, -tickSz} }
		local tickUp2	= addMesh("MPD_AFLIR_Scene_tickUp2", tick_vertices, box_indices, {boxSz, boxSz}, "triangles", ticks_root.name,
								nil, "INDICATION_COMMON_WHITE")
		SetScreenSpace(tickUp2)
		tick_vertices		= {	{0, 0}, {lineW, 0}, {lineW, tickSz}, {0, tickSz} }
		local tickDn	= addMesh("MPD_AFLIR_Scene_tickDn", tick_vertices, box_indices, {-boxSz, -boxSz}, "triangles", ticks_root.name,
								nil, "INDICATION_COMMON_WHITE")
		SetScreenSpace(tickDn)
		tick_vertices		= {	{0, 0}, {-lineW, 0}, {-lineW, tickSz}, {0, tickSz} }
		local tickDn2	= addMesh("MPD_AFLIR_Scene_tickDn2", tick_vertices, box_indices, {boxSz, -boxSz}, "triangles", ticks_root.name,
								nil, "INDICATION_COMMON_WHITE")
		SetScreenSpace(tickDn2)

		local dot = addMesh("MPD_AFLIR_Scene_Dot", dot_vertices, box_ind, nil, "triangles", ticks_root.name, nil, "INDICATION_COMMON_WHITE")
		SetScreenSpace(dot)
		
		AddYardstick_A(base, 0, 0.35, "SCENE")
	end
	AddSceneReticle()

	-- Tracking frame
	local function AddFrame()
		local	frame_start 			= CreateElement "ceSimple"
				frame_start.name		= "MPD_FLIR_frame_start"
--				frame_start.isdraw		= true
				frame_start.controllers	= {{"MPD_FLIR_blinking"}, {"MPD_FLIR_track_frame",1,1}}
		Add(frame_start)
		SetScreenSpace(frame_start)

		local boxSz	= 0.1
		local box_indices	= {0,1,2;0,2,3}--; 4,5,6;4,6,7}
		local box_vertices	= {	{-lineW, boxSz}, {0, boxSz}, {0,-boxSz}, {-lineW,-boxSz} }
		local box	= addMesh("MPD_FLIR_Track_Box", box_vertices, box_indices, {0, 0}, "triangles", nil,
								{{"MPD_FLIR_blinking"}, {"MPD_FLIR_track_frame",1,1}, {"MPD_FLIR_frame_box",-1,1/boxSz}}, "INDICATION_COMMON_WHITE")
		SetScreenSpace(box)
			box_vertices	= {	{lineW, boxSz}, {0, boxSz}, {0,-boxSz}, {lineW,-boxSz} }
		local box2	= addMesh("MPD_FLIR_Track_Box2", box_vertices, box_indices, {0, 0}, "triangles", nil,
								{{"MPD_FLIR_blinking"}, {"MPD_FLIR_track_frame",1,1}, {"MPD_FLIR_frame_box",1,1/boxSz}}, "INDICATION_COMMON_WHITE")
		SetScreenSpace(box2)
		
		local base_A			= addPlaceholder("MPD_AFLIR_Auto_base", {0,0}, nil, {{"MPD_FLIR_TgpType", ATFLIR}, {"MPD_AFLIR_Auto_track"}})
		SetScreenSpace(base_A)
		local dot = addMesh("MPD_AFLIR_Auto_Dot", dot_vertices, box_ind, nil, "triangles", base_A.name,
								{{"MPD_FLIR_blinking"}, {"MPD_FLIR_lss_active",0}}, "INDICATION_COMMON_WHITE")
		SetScreenSpace(dot)
		AddYardstick_A(base_A, 0, 0.35, "AUTO")
	end
	AddFrame()

	-- OFFSET Cursor
	local function AddOffsetCursor()
		local crossSz			= 3.1 / 61.1
		local holeSz			= crossSz * 0.2
		local hLine				= lineW*0.5
		local cross_indices		= {0,1,2;2,3,0; 4,5,6;6,7,4; 8,9,10;10,11,8; 12,13,14;14,15,12}
		local cross_vertices	= {	{-crossSz,-hLine}, {-crossSz,hLine}, {-holeSz,hLine}, {-holeSz,-hLine},
									{-hLine,crossSz}, {hLine,crossSz}, {hLine,holeSz}, {-hLine,holeSz},
									{crossSz,hLine}, {crossSz,-hLine}, {holeSz,-hLine}, {holeSz,hLine},
									{hLine,-crossSz}, {-hLine,-crossSz}, {-hLine,-holeSz}, {hLine,-holeSz}}
		local cross				= addMesh("MPD_FLIR_OFFSET_cursor", cross_vertices, cross_indices, {0, 0}, "triangles", nil,
									{{"MPD_FLIR_OFFSET_cursor"}}, "INDICATION_COMMON_WHITE")
		SetScreenSpace(cross)
	end
	AddOffsetCursor()

	-- GRAY scale
	local function AddGrayScale()
		local grayPosX = 400 / 512
		local grayPosY = 300 / 512
		local grayX_L = 540 / 512
		local grayX_A = 740 / 512
		local grayY = 200 / 512
		local grayScaleRoot = addPlaceholder("MPD_FLIR_GRAY_Scale_base", {-grayPosX, -grayPosY}, nil, {{"MPD_FLIR_GRAY_Opt"}})
		SetScreenSpace(grayScaleRoot)

		gray_scale_L				= CreateElement "ceTexPoly"
		gray_scale_L.name			= "MPD_FLIR_GRAY_scale_L"
		gray_scale_L.material		= "INDICATION_TGP"
		gray_scale_L.vertices		= {{0, -grayY}, {grayX_L, -grayY}, {grayX_L, 0}, {0, 0}}
		gray_scale_L.indices		= box_ind
		gray_scale_L.tex_params		= {0,0, 200/256 / grayX_L * GetScale(), 0.5 * GetScale()}
		gray_scale_L.parent_element	= grayScaleRoot.name
		gray_scale_L.controllers	= {{"MPD_FLIR_TgpType", LITENING}}
		Add(gray_scale_L)
		SetScreenSpace(gray_scale_L)
		
		gray_scale_A				= CreateElement "ceTexPoly"
		gray_scale_A.name			= "MPD_FLIR_GRAY_scale_A"
		gray_scale_A.material		= "INDICATION_TGP"
		gray_scale_A.vertices		= {{0, -grayY}, {grayX_A, -grayY}, {grayX_A, 0}, {0, 0}}
		gray_scale_A.indices		= box_ind
		gray_scale_A.tex_params		= {0,0, 200/256 / grayX_A * GetScale(), 0.5 * GetScale()}
		gray_scale_A.parent_element	= grayScaleRoot.name
		gray_scale_A.controllers	= {{"MPD_FLIR_TgpType", ATFLIR}}
		Add(gray_scale_A)
		SetScreenSpace(gray_scale_A)
	end
	AddGrayScale()

	-- DCLTR mask
	local function AddDcltrMask()
		local dcltr_mask_vert	= {{-1, 0}, {1, 0}, {1,-112/512}, {-1,-112/512}}
		local dcltr_mask		= addMesh("MPD_FLIR_DCLTR_mask", dcltr_mask_vert, box_ind, {0, -400/512}, "triangles", nil, {{"MPD_FLIR_DCLTR_mask"}}, "TGP_STBY_DGRAY")
		SetScreenSpace(dcltr_mask)
	end
	AddDcltrMask()

	-- Compass and Arrow - LITENING
	local function AddCompassAndArrow_L()
		local max_pixels_count = 480
		local compass_x		= (2*(max_pixels_count - 80)/(max_pixels_count) - 1)
		local compass_y		= 0.6
		local CompassSizeK	= 0.75
		local size_N_x		= (0.5*(34.5 - 4.5)/ 256)
		local size_N_y		= (0.5*(78  - 44)/ 256)
		local x_N			=  4.5/256  + size_N_x
		local y_N			=  44/256   + size_N_y

		compass_N				= CreateElement "ceTexPoly"
		compass_N.name			= "MPD_FLIR_compass_N_L"
		compass_N.material		= "INDICATION_TGP"
		compass_N.vertices		= {{-size_N_x * CompassSizeK,  size_N_y * CompassSizeK}, 
									{ size_N_x * CompassSizeK,  size_N_y * CompassSizeK},
									{ size_N_x * CompassSizeK, -size_N_y * CompassSizeK},
									{-size_N_x * CompassSizeK, -size_N_y * CompassSizeK}}
		compass_N.indices		= box_ind
		compass_N.tex_params	= {x_N, y_N, 1 / CompassSizeK * GetScale(), 1 / CompassSizeK * GetScale(),}
		compass_N.init_pos		= {compass_x, compass_y, 0}
		compass_N.controllers	= {{"MPD_FLIR_TgpType", LITENING}, {"MPD_FLIR_compass_rose_is_available", 1}}
		Add(compass_N)
		SetScreenSpace(compass_N)

		local texture_scale = 1 / 480
		CompassLineNS					= CreateElement "ceSimpleLineObject"
		CompassLineNS.name				= "CompassLineNS"
		CompassLineNS.material			= "INDICATION_TGP"
		CompassLineNS.width				= 0.02
		CompassLineNS.tex_params		= {{0.1, 84.5 / 256 }, {0.9, 84.5 / 256}, {1, 1}}
		CompassLineNS.vertices			= {{0, -0.1}, {0, 0.1}}
		CompassLineNS.parent_element	= compass_N.name
		Add(CompassLineNS)

		CompassLineWE = Copy(CompassLineNS)
		Add(CompassLineWE)

		CompassLineNS.controllers		= {{"MPD_FLIR_compass_rose_NS_line"}}
		CompassLineWE.controllers		= {{"MPD_FLIR_compass_rose_WE_line"}}

		SetScreenSpace(CompassLineNS)
		SetScreenSpace(CompassLineWE)

		local arrow_length		= 0.03

		compass_arrow					= CreateElement "ceMeshPoly"
		compass_arrow.name				= "compass_arrow"
		compass_arrow.primitivetype		= "triangles"
		compass_arrow.material			= "INDICATION_COMMON_WHITE"
		compass_arrow.vertices			= {{ 0, arrow_length},
										{-arrow_length/2, 0},
										{ arrow_length/2, 0}}
		compass_arrow.indices			= {0,1,2} 
		compass_arrow.parent_element	= compass_N.name
		compass_arrow.controllers		= {{"MPD_FLIR_compass_arrow_pos"}}
		Add(compass_arrow)
		SetScreenSpace(compass_arrow)
	end
	AddCompassAndArrow_L()
	
		-- Compass and Arrow - LITENING
	local function AddCompass_A()
		local max_pixels_count = 480
		local compass_x		= -0.63
		local compass_y		= 0.65
		local CompassSizeK	= 0.75
		local size_N_x		= (0.5*(45.5 - 4.5)/ 256)
		local size_N_y		= (0.5*(150  - 94)/ 256)
		local x_N			=  4.5/256  + size_N_x
		local y_N			=  94/256   + size_N_y

		compass_N				= CreateElement "ceTexPoly"
		compass_N.name			= "MPD_FLIR_compass_N_A"
		compass_N.material		= "INDICATION_TGP"
		compass_N.vertices		= {{-size_N_x * CompassSizeK,  size_N_y * CompassSizeK}, 
									{ size_N_x * CompassSizeK,  size_N_y * CompassSizeK},
									{ size_N_x * CompassSizeK, -size_N_y * CompassSizeK},
									{-size_N_x * CompassSizeK, -size_N_y * CompassSizeK}}
		compass_N.indices		= box_ind
		compass_N.tex_params	= {x_N, y_N, 1 / CompassSizeK * GetScale(), 1 / CompassSizeK * GetScale(),}
		compass_N.init_pos		= {compass_x, compass_y, 0}
		compass_N.controllers	= {{"MPD_FLIR_TgpType", ATFLIR}, {"MPD_FLIR_compass_rose_is_available", 1}, {"MPD_FLIR_compass_arrow_rot"}}
		Add(compass_N)
		SetScreenSpace(compass_N)
	end
	AddCompass_A()

	-- Coordinates display - ATFLIR
	local function AddCoordinates_A()
		local FLIR_coords_root_A = addPlaceholder("FLIR_coords_root_A", {0.859375,0.78125}, nil, {{"MPD_FLIR_TgpType", ATFLIR}, {"MPD_FLIR_Coords_Show"}, {"MPD_FLIR_LSS_ON", 0}})
		SetScreenSpace(FLIR_coords_root_A)

		local fontSz = 0.0042
		
		coordinates_lat						= CreateElement "ceStringPoly"
		coordinates_lat.material			= "font_ATFLIR"
		coordinates_lat.alignment			= "LeftCenter"
		coordinates_lat.stringdefs			= {fontSz, fontSz,0,0}
		coordinates_lat.init_pos			= {-0.546, 0}
		coordinates_lat.formats 			= {"%c%3d:%02d.%02d", "%c%3d:%02d:%02d", "%c%3d:%02d.%02d%02d", "%c%3d:%02d:%02d.%02d"}
		coordinates_lat.controllers			= {{"MPD_FLIR_coordinates_display", AFLIR_COORD.LAT_LON}, {"MPD_FLIR_coordinates_Lat"}}
		coordinates_lat.parent_element		= FLIR_coords_root_A.name
		Add(coordinates_lat)
		SetScreenSpace(coordinates_lat)
		
		coordinates_lon						= CreateElement "ceStringPoly"
		coordinates_lon.material			= "font_ATFLIR"
		coordinates_lon.alignment			= "LeftCenter"
		coordinates_lon.stringdefs			= {fontSz, fontSz,0,0}
		coordinates_lon.init_pos			= {-0.546875, -0.056}
		coordinates_lon.formats 			= {"%c%3d:%02d.%02d", "%c%3d:%02d:%02d", "%c%3d:%02d.%02d%02d", "%c%3d:%02d:%02d.%02d"}
		coordinates_lon.controllers			= {{"MPD_FLIR_coordinates_display", AFLIR_COORD.LAT_LON}, {"MPD_FLIR_coordinates_Lon"}}
		coordinates_lon.parent_element		= FLIR_coords_root_A.name
		Add(coordinates_lon)
		SetScreenSpace(coordinates_lon)
		
		coordinates_elev					= CreateElement "ceStringPoly"
		coordinates_elev.material			= "font_ATFLIR"
		coordinates_elev.alignment			= "LeftCenter"
		coordinates_elev.stringdefs			= {fontSz, fontSz,0,0}
		coordinates_elev.init_pos			= {-0.546875, -0.112}
		coordinates_elev.formats 			= {"ELEV %d"}
		coordinates_elev.controllers		= {{"MPD_FLIR_coordinates_display"}, {"MPD_FLIR_coordinates_altitude"}}
		coordinates_elev.parent_element		= FLIR_coords_root_A.name
		Add(coordinates_elev)
		SetScreenSpace(coordinates_elev)
		
		coordinates_grid					= CreateElement "ceStringPoly"
		coordinates_grid.material			= "font_ATFLIR"
		coordinates_grid.alignment			= "RightCenter"
		coordinates_grid.stringdefs			= {fontSz, fontSz,0,0}
		coordinates_grid.init_pos			= {0, -0.168}
		coordinates_grid.formats 			= {"GRID %3s %2s %05d%05d", "GRID %3s %2s %03d%03d"}
		coordinates_grid.controllers		= {{"MPD_FLIR_coordinates_display", AFLIR_COORD.GRID}, {"MPD_FLIR_Grid"}}
		coordinates_grid.parent_element		= FLIR_coords_root_A.name
		Add(coordinates_grid)
		SetScreenSpace(coordinates_grid)
	end
	AddCoordinates_A()
	
	-- Waypoint markers
	local wp_root = addPlaceholder("MPD_AFLIR_WYPT_Symb_Keeper", nil, nil, {{"MPD_FLIR_TgpType", ATFLIR}, {"MPD_updateMultipleSymbolsBuffer", DYNAMIC_DATA.AFLIR_WYPT_SYMB}})
	SetScreenSpace(wp_root)

end
-- end of VIDEO
