dofile(LockOn_Options.script_path.."Displays/MFD/indicator/MFD_Symbology.lua")

-- 
TGP_MODE =
{
	STBY = 1,
	AG = 2,
	AA = 3,
}

TGP_TRACK =
{
	POINT	= 1,
	AREA	= 2,
	RATES	= 3,
}

--
tgp_max_size_Px		= 480
tgp_half_size_Px	= 0.5 * tgp_max_size_Px

box_ind   = {0,1,2,0,2,3}

function set_as_invisible_mask(obj)
	local show_masks = false
	obj.isvisible = show_masks
	obj.material  = "MASK_MATERIAL"
end

local function SetScreenSpace(object)
	object.h_clip_relation = h_clip_relations.NULL
	object.screenspace = 2
end

local boxSz  = 2
local holeSz = 1
local tgp_roll_stab_artifact_vert = {{-boxSz, boxSz}, {boxSz, boxSz}, {boxSz,-boxSz}, {-boxSz,-boxSz},
									 {-holeSz, holeSz}, {holeSz, holeSz}, {holeSz,-holeSz}, {-holeSz,-holeSz}}
local tgp_roll_stab_artifact_indices = {0,1,4;4,1,5; 1,2,5;5,2,6; 2,3,6;3,6,7; 3,0,7;7,0,4}

-- start VIDEO
function AddRenderFLIR()
-- Add base
	local 	verts = {{-238,  238},
					 { 238,  238}, 
					 { 238, -238},
					 {-238, -238}}

	local	back					= CreateElement "ceMeshPoly"
			back.primitivetype		= "triangles"
			back.vertices			= verts
			back.indices			= box_ind
			set_as_invisible_mask(back)
			back.level				= DEFAULT_LEVEL
			back.h_clip_relation	= h_clip_relations.REWRITE_LEVEL
	Add(back)

	local	render_base					= CreateElement  "ceSimple"
			render_base.controllers		= {{"TGP_TV_Render"}}
--			render_base.parent_element 	= back.name
	Add(render_base)

-- Add render CCD and IR
	local	render_tv					= CreateElement "ceTexPoly"
			render_tv.name				= "screen"
			render_tv.vertices			= verts
			render_tv.indices			= box_ind
			render_tv.tex_params		= {0.5,0.5, 1.0/tgp_max_size_Px, 1.0/tgp_max_size_Px}
			---------------------------------------------------------------------------------------
			render_tv.material			= "render_target_"..string.format("%d",GetRenderTarget() + 1)
			---------------------------------------------------------------------------------------
			--[[
			render_tv.controllers		= {	{"TGP_digital_zoom"},
											{"video_brightness",0.1,1.0,1.0/63.0},
											{"video_contrast"  ,0  ,0.5,1.0/32.0}}
			--]]
			render_tv.controllers		= {	{"TGP_digital_zoom"}}
			render_tv.level 			= DEFAULT_LEVEL
			render_tv.h_clip_relation	= h_clip_relations.COMPARE
			render_tv.parent_element	= render_base.name
			render_tv.additive_alpha	= true
			render_tv.input_space_SRGB  = true
	Add(render_tv)
	
	local tgp_roll_stabilize_artifact = addMesh("TGP_roll_stabilize_artifact", tgp_roll_stab_artifact_vert, tgp_roll_stab_artifact_indices,
				{0, 0}, "triangles", nil, {{"TGP_roll_stabilize_artifact",1,1,1}}, "TGP_STBY_BLACK")
	SetScreenSpace(tgp_roll_stabilize_artifact)
	
	local lineW = 0.012
	-- FOV bracket
	local function AddNarrow(name, pos, sz, controllers)
		local	base_obj 	= addPlaceholder("TGP_NarrowBase"..name, {0,0}, nil, controllers)
				SetScreenSpace(base_obj)
		for num = 1, 4 do
			local	base_seg 	= addPlaceholder("TGP_NarrowSegmentBase"..name..num, {0,0}, base_obj.name)
					base_seg.init_rot = {90 * (num-1)}
					SetScreenSpace(base_seg)
			local	line1 = addMesh("TGP_NarrowSegment1_"..name..num, {{0, 0}, {sz, 0}, {sz,-lineW}, {0,-lineW}},
								box_ind, {-pos, pos}, "triangles", base_seg.name, nil, "INDICATION_COMMON_WHITE")
					SetScreenSpace(line1)
			local	line2 = addMesh("TGP_NarrowSegment2_"..name..num, {{0, 0}, {lineW, 0}, {lineW,-sz}, {0,-sz}},
								box_ind, {-pos, pos}, "triangles", base_seg.name, nil, "INDICATION_COMMON_WHITE")
					SetScreenSpace(line2)
		end
		--
	end

	AddNarrow("TV", 1/3.5, 0.1, {{"TGP_Oper"}, {"TGP_FOV"}, {"TGP_video_mode",0}})
	AddNarrow("IR", 0.25,  0.1, {{"TGP_Oper"}, {"TGP_FOV"}, {"TGP_flir"}})
	
	-- Crosshairs
	local function AddCrossHair(name, gate_sz_, cross_hair_sz_, parentName, controllers)
		local   base_cross_hair 	= addPlaceholder(name.."_base", {0,0}, parentName, controllers)
				SetScreenSpace(base_cross_hair)
		for i = 1, 4 do
			local	line = addMesh(name..i, {{gate_sz_, 0.5*lineW}, {cross_hair_sz_, 0.5*lineW}, {cross_hair_sz_,-0.5*lineW}, {gate_sz_,-0.5*lineW}},
								box_ind, {0, 0}, "triangles", base_cross_hair.name, nil, "INDICATION_COMMON_WHITE")
					line.init_rot = {90 * (i-1)}
					SetScreenSpace(line)
		end
		return base_cross_hair
	end
	
	local function add_ir_brackets(parent_,gate_sz_,cross_hair_sz_)
		local   base_brackets	= addPlaceholder(parent_.name.."_irBracket", {0,0}, parent_.name, {{"TGP_designator_type",1,2}})
				SetScreenSpace(base_brackets)
		
		local  lines = {}
		for i = 1,4 do
			lines[i] = addMesh(parent_.name.."_IR_Bracket_"..i, {{cross_hair_sz_, gate_sz_}, {cross_hair_sz_ + lineW, gate_sz_}, {cross_hair_sz_+ lineW,-gate_sz_}, {cross_hair_sz_,-gate_sz_}},
								box_ind, {0, 0}, "triangles", base_brackets.name, nil, "INDICATION_COMMON_WHITE")
			lines[i].init_rot = {90 * (i - 1)}
			SetScreenSpace(lines[i])
		end
	end

	function add_yardstick(parent,gate_sz,cross_hair_sz)
		local   yardstick_sz 		   =  (cross_hair_sz - 0.5 * gate_sz) * 0.4
		local   tgp_yardstick 		   = {}
		local 	tgp_yardstick_formats  = {{"%.fM"},{"%.fF"}}
		local   tgp_yardstick_control  = {{"TGP_yardstick_value", 0, yardstick_sz, 1},
									  {"TGP_yardstick_value", 0, yardstick_sz, 3.28084}}
		for i = 1, 2 do
			tgp_yardstick[i]						= CreateElement "ceStringPoly"
			tgp_yardstick[i].material				= "font_TGP"
			tgp_yardstick[i].alignment				= "RightBottom"
			tgp_yardstick[i].stringdefs				= {0.0057, 0.0057,0,0}
			tgp_yardstick[i].init_pos           	= {0.55,0.03}
			tgp_yardstick[i].formats 				= tgp_yardstick_formats[i]
			tgp_yardstick[i].controllers			= {{"TGP_master_mode_is_AA", 0}, 
													   {"TGP_yardstick_metric", i},
													   tgp_yardstick_control[i]}
			tgp_yardstick[i].parent_element 		= parent.name
			Add(tgp_yardstick[i])
			SetScreenSpace(tgp_yardstick[i])
		end
	end

	local function AddCrossAndGate(parent, gate_sz, cross_hair_sz, suffix)
		local base_cross_hair			= addPlaceholder("TGP_base_cross_hair"..suffix,		  {0,0}, parent.name, {{"TGP_enlarged_cross_hair",0}, {"TGP_lss_active",0}})
		SetScreenSpace(base_cross_hair)
		local base_cross_hair_enlarged	= addPlaceholder("TGP_base_cross_hair_enlarged"..suffix, {0,0}, parent.name, {{"TGP_enlarged_cross_hair"},   {"TGP_lss_active",0}})
		SetScreenSpace(base_cross_hair_enlarged)

		local normal   = AddCrossHair("TGP_normal_ch"..suffix, gate_sz, cross_hair_sz, base_cross_hair.name, {{"TGP_masked_blinking", 64}})
		local enlarged = AddCrossHair("TGP_enlarged_ch"..suffix, gate_sz, 2 * cross_hair_sz, base_cross_hair_enlarged.name, {{"TGP_masked_blinking", 64}})
		AddCrossHair("TGP_lss_lst_ch"..suffix, gate_sz, 0.9, nil, {{"TGP_lss_active"}, {"TGP_masked_blinking", 64}})

		add_ir_brackets(normal, gate_sz, cross_hair_sz)
		add_ir_brackets(enlarged, gate_sz, 2 * cross_hair_sz)
		add_yardstick(base_cross_hair, gate_sz, cross_hair_sz)
		add_yardstick(base_cross_hair_enlarged, gate_sz, 2 * cross_hair_sz)
	end

	local base_narrow		= addPlaceholder("TGP_base_narrow", {0,0}, nil, {{"TGP_Oper"}, {"TGP_FOV",1}})
	SetScreenSpace(base_narrow)
	local base_wide_CCD		= addPlaceholder("TGP_base_wide_CCD", {0,0}, nil, {{"TGP_Oper"}, {"TGP_FOV"}, {"TGP_video_mode", 0}})
	SetScreenSpace(base_wide_CCD)
	local base_wide_FLIR	= addPlaceholder("TGP_base_wide_FLIR", {0,0}, nil, {{"TGP_Oper"}, {"TGP_FOV"}, {"TGP_flir"}})
	SetScreenSpace(base_wide_FLIR)

--	AddCrossAndGate(base_narrow,	0.85 * 4 / 69.9,	3.8 * 4 / 69.9,	"_NAR_")
	AddCrossAndGate(base_narrow,	3.1 / 61.1,			12.2 / 61.1,	"_NAR_")
	AddCrossAndGate(base_wide_CCD,	3.1 / 61.1,			12.2 / 61.1,	"_WCCD_")
	AddCrossAndGate(base_wide_FLIR,	3.5 / 69.9,			15.2 / 69.9,	"_WFLIR_")

	-- Tracking frame
	function AddFrame()
		local	frame_start 			= CreateElement "ceSimple"
				frame_start.name		= "TGP_frame_start"
--				frame_start.isdraw		= true
				frame_start.controllers	= {{"TGP_Oper"}, {"TGP_track_frame",1,1}}
		Add(frame_start)
		SetScreenSpace(frame_start)

		local boxSz	= 3.1 / 61.1
		local holeSz = boxSz-lineW
		local box_indices	= {0,1,4;4,1,5; 1,2,5;5,2,6; 2,3,6;3,6,7; 3,0,7;7,0,4}
		local box_vertices	= {	{-boxSz, boxSz}, {boxSz, boxSz}, {boxSz,-boxSz}, {-boxSz,-boxSz},
								{-holeSz, holeSz}, {holeSz, holeSz}, {holeSz,-holeSz}, {-holeSz,-holeSz}}
		local box	= addMesh("TGP_Track_Box", box_vertices, box_indices, {0, 0}, "triangles", nil,
								{{"TGP_track_frame",1,1}, {"TGP_frame_box",1,1}}, "INDICATION_COMMON_WHITE")
		SetScreenSpace(box)
	end

	AddFrame()

	-- GRAY scale
	local function AddGrayScale()
		local grayPosX = 200 / 240
		local grayPosY = 150 / 240
		local grayX = 400 / 240
		local grayY = 50 / 240
		local grayScaleRoot = addPlaceholder("TGP_GRAY_Scale_base", {-grayPosX, -grayPosY}, nil, {{"TGP_GRAY_Opt", 1}})
		SetScreenSpace(grayScaleRoot)

		gray_scale  			= CreateElement "ceTexPoly"
		gray_scale.name         = "MFD_TGP_GRAY_scale"
		gray_scale.material	 	= "INDICATION_TGP"
		gray_scale.vertices     = {{0, -grayY}, {grayX, -grayY}, {grayX, 0}, {0, 0}}
		gray_scale.indices      = box_ind
		gray_scale.tex_params   = {0,0, 200/256 / grayX * GetScale(), 0.5 * GetScale()}
		gray_scale.parent_element = grayScaleRoot.name
		Add(gray_scale)
		SetScreenSpace(gray_scale)
	end
	AddGrayScale()

	local max_pixels_count = 480
	local compass_x  = (2*(max_pixels_count - 120)/(max_pixels_count) - 1)
	local compass_y  = 0.7
	local CompassSizeK = 0.75
	local size_N_x	 = (0.5*(34.5 - 4.5)/ 256)
	local size_N_y	 = (0.5*(78  - 44)/ 256)
	local x_N		 =  4.5/256  + size_N_x
	local y_N	 	 =  44/256   + size_N_y

	compass_N 	   		  = CreateElement "ceTexPoly"
	compass_N.name 		  = "MFD_TGP_compass_N"
	compass_N.material	  = "INDICATION_TGP"
	compass_N.vertices    = {{-size_N_x * CompassSizeK,  size_N_y * CompassSizeK}, 
							 { size_N_x * CompassSizeK,  size_N_y * CompassSizeK},
							 { size_N_x * CompassSizeK, -size_N_y * CompassSizeK},
							 {-size_N_x * CompassSizeK, -size_N_y * CompassSizeK}}
	compass_N.indices     = box_ind
	compass_N.tex_params  = {x_N, y_N, 1 / CompassSizeK * GetScale(), 1 / CompassSizeK * GetScale(),}
	compass_N.init_pos    = {compass_x, compass_y, 0}
	compass_N.controllers = {{"TGP_compass_rose_is_available", 1}}
	Add(compass_N)
	SetScreenSpace(compass_N)

	local texture_scale = 1 / 480
	CompassLineNS					= CreateElement "ceSimpleLineObject"
	CompassLineNS.name				= "CompassLineNS"
	CompassLineNS.material			= "INDICATION_TGP"
	CompassLineNS.width				= 0.02
	CompassLineNS.tex_params		= {{0.1, 84.5 / 256 }, {0.9, 84.5 / 256}, {1, 1}}
	CompassLineNS.vertices			= {{0, -0.1}, {0, 0.1}}
	CompassLineNS.parent_element    = compass_N.name
	Add(CompassLineNS)

	CompassLineWE = Copy(CompassLineNS)
	Add(CompassLineWE)

	CompassLineNS.controllers       = {{"TGP_compass_rose_NS_line"}}
	CompassLineWE.controllers       = {{"TGP_compass_rose_WE_line"}}

	SetScreenSpace(CompassLineNS)
	SetScreenSpace(CompassLineWE)

	local arrow_length  	= 0.03

	compass_arrow  				 = CreateElement "ceMeshPoly"
	compass_arrow.name 			 = "compass_arrow"
	compass_arrow.primitivetype  = "triangles"
	compass_arrow.material	   	 = "INDICATION_COMMON_WHITE"
	compass_arrow.vertices  	 = {{ 0, arrow_length},
									{-arrow_length/2, 0},
									{ arrow_length/2, 0}}
	compass_arrow.indices		 = {0,1,2} 
	compass_arrow.parent_element = compass_N.name
	compass_arrow.controllers    = {{"TGP_compass_arrow_pos"}}
	Add(compass_arrow)
	SetScreenSpace(compass_arrow)

end
-- end of VIDEO
