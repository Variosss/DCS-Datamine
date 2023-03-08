dofile(LockOn_Options.script_path.."HMD/indicator/HMD_Page_defs.lua")

local horizontalLineLenghtCoarse 	= 64--DegToMil(10)
local verticalLineLenghtCoarse 		= 107--DegToMil(13.6)

local LineLenghtFine				= DegToMil(1.5)

--Coarse alignment
local HMD_Coarse_Alignment = addPlaceholder("HMD_Coarse_Alignment", nil, nil, {{"HMD_Coarse_Alignment_SHOW"}})
	local HMD_coarse_alignment_cross = addPlaceholder("HMD_coarse_alignment_cross_PH", nil, HMD_Coarse_Alignment.name)
		addStrokeLine("HMD_coarse_aligment_cross_horizontal_line", horizontalLineLenghtCoarse, {-horizontalLineLenghtCoarse/2, -DegToMil(6)+75}, -90, HMD_coarse_alignment_cross.name)
		addStrokeLine("HMD_coarse_aligment_cross_vertical_line"  , verticalLineLenghtCoarse  , {0, -DegToMil(6)}, 0, HMD_coarse_alignment_cross.name)	

--Fine alignment
local HMD_Fine_Aligment = addPlaceholder("HMD_Fine_Aligment", {0,-DegToMil(6)+75}, nil, {{"HMD_Fine_Aligment_SHOW", RadToMil()}})
	local HMD_fine_alignment_crosses = addPlaceholder("HMD_fine_alignment_cross_PH", nil, HMD_Fine_Aligment.name)
	
	addStrokeLine("HMD_fine_aligment_cross1_horizontal_line1",  DegToMil(0.75), {0,0}, 0, HMD_fine_alignment_crosses.name)	
	addStrokeLine("HMD_fine_aligment_cross1_horizontal_line2",  DegToMil(0.75), {0,0}, -180, HMD_fine_alignment_crosses.name)
	addStrokeLine("HMD_fine_aligment_cross1_vertical_line1", 	DegToMil(0.75), {0,0}, -90, HMD_fine_alignment_crosses.name)
	addStrokeLine("HMD_fine_aligment_cross1_vertical_line2", 	DegToMil(0.75), {0,0}, 90, HMD_fine_alignment_crosses.name)
	
	addStrokeLine("HMD_fine_aligment_cross2_horizontal_line1",  DegToMil(0.75), {0,-DegToMil(6)}, 0, HMD_fine_alignment_crosses.name)
	addStrokeLine("HMD_fine_aligment_cross2_horizontal_line2",  DegToMil(0.75), {0,-DegToMil(6)}, -180, HMD_fine_alignment_crosses.name)
	addStrokeLine("HMD_fine_aligment_cross2_vertical_line1", 	DegToMil(0.75), {0,-DegToMil(6)}, -90, HMD_fine_alignment_crosses.name)
	addStrokeLine("HMD_fine_aligment_cross2_vertical_line2", 	DegToMil(0.75), {0,-DegToMil(6)}, 90, HMD_fine_alignment_crosses.name)
		
addStrokeText("ALIGN_TEXT", "", STROKE_FNT_DFLT_150, "CenterCenter", {0,-DegToMil(7)}, nil, {{"HMD_AlignText"}})
