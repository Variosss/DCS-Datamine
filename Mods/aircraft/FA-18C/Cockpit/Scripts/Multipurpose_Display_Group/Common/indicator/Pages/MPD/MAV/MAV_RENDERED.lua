dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/MPD_page_defs.lua")
dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/MAV/MAV_tools.lua")
dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/HARM/HARM_Utils.lua")

step = 15
AddRender()

local displayMaterial = "MAV_COLOR_"..string.format("%d",GetRenderTarget())

local openingMask = openMaskArea(0, "CrossArea", {}, {}, {0, 0}, nil, {{"maverick_frame_size", 900 * 1.3}})
set_box_w_h(openingMask, 10, 10)

addPlaceholder("Big_Cross", {0,0}, nil, {{"MPD_SMS_AGM65_IR_Cross"}}, false, 0, 0, "MAV_COLOR_"..string.format("%d",GetRenderTarget()))
addStrokeLine("Big_Cross1", 450, {0, 0}, 0, "Big_Cross", {{"maverick_polarity_change_color",0,0,0}}, false, 0, 0, displayMaterial)
addStrokeLine("Big_Cross2", 450, {0, 0}, 180, "Big_Cross", {{"maverick_polarity_change_color",0,0,0}}, false, 0, 0, displayMaterial)
addStrokeLine("Big_Cross3", 450, {0, 0}, 90, "Big_Cross", {{"maverick_polarity_change_color",0,0,0}}, false, 0, 0, displayMaterial)
addStrokeLine("Big_Cross4", 450, {0, 0}, -90, "Big_Cross", {{"maverick_polarity_change_color",0,0,0}}, false, 0, 0, displayMaterial)

addStrokeLine("Big_CrossShip", 450, {0, -10}, 90, "Big_Cross", {{"MPD_SMS_AGM65_ShipWaterLine"}, {"maverick_polarity_change_color",0,0,0}}, false, 0, 0, displayMaterial)
addStrokeLine("Big_CrossShip1", 450, {0, -10}, -90, "Big_Cross", {{"MPD_SMS_AGM65_ShipWaterLine"}, {"maverick_polarity_change_color",0,0,0}}, false, 0, 0, displayMaterial)

addPlaceholder("GridPos", {0,0}, nil, {{"MPD_SMS_AGM65_IR_Cross"}})

closeMaskArea(1, "CrossAreaClose", openingMask.vertices, openingMask.indices, openingMask.init_pos, nil, {{"maverick_frame_size", 900 * 1.3}})

max_pixels_count = 900

local GimbalcrossOpenMask = openMaskArea(0, "GimbalCrossArea", {}, {}, {0, 0}, nil)
set_box_w_h(GimbalcrossOpenMask, max_pixels_count, max_pixels_count)

GridPos1 = addPlaceholder("GridPos1", {0,0}, nil, {{"MPD_SMS_AGM65_IR_Cross"}})
setClipLevel(GridPos1, 1)

Small_Cross = addPlaceholder("Small_Cross", {0,0}, "GridPos1", {{"MPD_SMS_AG_AGM_Gimbal_Ang", 450, 1}})
setClipLevel(Small_Cross, 1)

Small_Cross1 = addStrokeLine("Small_Cross1", 90, {0, -45}, 0, "Small_Cross", {{"maverick_polarity_change_color",0,0,0}}, false, 0, 0, displayMaterial)
setClipLevel(Small_Cross1, 1)

Small_Cross2 = addStrokeLine("Small_Cross2", 90, {45, 0}, 90, "Small_Cross", {{"maverick_polarity_change_color",0,0,0}}, false, 0, 0, displayMaterial)
setClipLevel(Small_Cross2, 1)

closeMaskArea(1, "GimbalCrossAreaClose", GimbalcrossOpenMask.vertices, GimbalcrossOpenMask.indices, GimbalcrossOpenMask.init_pos, nil)

addPlaceholder("GridNoMask", {0,0}, nil, {{"MPD_SMS_AGM65_IR_Cross"}})

addStrokeLine("Line1", 80, {40, -90}, 90, "GridNoMask", {{"maverick_polarity_change_color",0,0,0}}, false, 0, 0, displayMaterial)
addStrokeLine("Line2", 80, {40, -180}, 90, "GridNoMask", {{"maverick_polarity_change_color",0,0,0}}, false, 0, 0, displayMaterial)
addStrokeLine("Line3", 80, {40, -270}, 90, "GridNoMask", {{"maverick_polarity_change_color",0,0,0}}, false, 0, 0, displayMaterial)


for i = 0, 3 do
	addPlaceholder("Fov_bracket"..i, {0,0}, "GridNoMask", {{"maverick_FOV", i, 90}})
	addStrokeLine("LineFOV1"..i, 50, {0, 0}, -i * 90, "Fov_bracket"..i, {{"maverick_polarity_change_color",0,0,0}}, false, 0, 0, displayMaterial)
	addStrokeLine("LineFOV2"..i, 50, {0, 0}, -90 - i * 90, "Fov_bracket"..i, {{"maverick_polarity_change_color",0,0,0}}, false, 0, 0, displayMaterial)
end
----------------------------------------------------------------------------------------------------------------------------

local   verts 			     = {{-max_pixels_count/4,  max_pixels_count/4},
									 { max_pixels_count/4,  max_pixels_count/4}, 
									 { max_pixels_count/4, -max_pixels_count/4},
									 {-max_pixels_count/4, -max_pixels_count/4}}

grid_image  				= CreateElement "ceTexPoly"
grid_image.vertices		    = verts
grid_image.indices		    = box_ind
grid_image.init_pos		    = {70, 0, 0}
grid_image.material		    = "AGM_65E_GRID_"..string.format("%d",GetRenderTarget())
grid_image.tex_params		={0.5,0.5, 1.0/(max_pixels_count/2.05), 1.0/(max_pixels_count/1.9)}
grid_image.controllers     = {{"MPD_SMS_AGM65E_Launch"}}
use_mipfilter(grid_image) 
Add(grid_image)

addPlaceholder("GimbalAngPH", {0, 0}, grid_image.name, {{"MPD_SMS_AG_AGM_Gimbal_Ang", step * 15, 0}})

local agm_65e_sym_size = 30.0
rendered_line_width  = 3

agm_65e_cross 	   			 = CreateElement "ceMeshPoly"
agm_65e_cross.primitivetype  = "triangles"
agm_65e_cross.material	   	 = displayMaterial
agm_65e_cross.parent_element = "GimbalAngPH"
set_cross_X(agm_65e_cross,agm_65e_sym_size,rendered_line_width)
agm_65e_cross.controllers    = {{"MPD_SMS_AGM65_Lock", 0}}
Add(agm_65e_cross)
use_mipfilter(agm_65e_cross) 

agm_65e_rect 	   			 = CreateElement "ceMeshPoly"
agm_65e_rect.primitivetype   = "triangles"
agm_65e_rect.material	   	 = displayMaterial
agm_65e_rect.parent_element  = "GimbalAngPH"
agm_65e_rect.vertices        = {{-agm_65e_sym_size, agm_65e_sym_size},
                                { agm_65e_sym_size, agm_65e_sym_size},
                                { agm_65e_sym_size,-agm_65e_sym_size},
                                {-agm_65e_sym_size,-agm_65e_sym_size}}
agm_65e_rect.indices         = box_ind  
agm_65e_rect.controllers     = {{"MPD_SMS_AGM65_Lock", 1}}
Add(agm_65e_rect)
use_mipfilter(agm_65e_rect) 

addPlaceholder("GimbalPositionPH", {0, -300}, grid_image.name)

GimbalPositionLine 			    = CreateElement "ceMeshPoly"
GimbalPositionLine.primitivetype    = "triangles"
GimbalPositionLine.material	   	    = displayMaterial
GimbalPositionLine.vertices         = {{65, rendered_line_width},
                                   {0, rendered_line_width},
                                   {0, -rendered_line_width},
                                   {65, -rendered_line_width}}
GimbalPositionLine.indices          = box_ind                         
GimbalPositionLine.parent_element   = "GimbalPositionPH"
GimbalPositionLine.init_pos         = {-34, 0}
Add(GimbalPositionLine)
use_mipfilter(GimbalPositionLine)


add_PB_label(3, {"DLY2", nil, {}, {{"MPD_SMS_MAV_FUZE", 5}}})
add_PB_label(4, {"DLY1", nil, {}, {{"MPD_SMS_MAV_FUZE", 4}}})
add_PB_label(5, {"INST", nil, {}, {{"MPD_SMS_MAV_FUZE", 3}}})

add_PB_label(6, {"       ", nil, {{"MPD_SMS_6_10PBLabels", 0, 0}}, {{"MPD_SMS_6_10PBLabels", 0, 1}}}, "", {"RDY", nil, {{"MPD_SMS_AG_RDY_Label", 0}}})
add_PB_label(7, {"       ", nil, {{"MPD_SMS_6_10PBLabels", 1, 0}}, {{"MPD_SMS_6_10PBLabels", 1, 1}}}, "", {"RDY", nil, {{"MPD_SMS_AG_RDY_Label", 1}}})
add_PB_label(8, {"       ", nil, {{"MPD_SMS_6_10PBLabels", 2, 0}}, {{"MPD_SMS_6_10PBLabels", 2, 1}}}, "", {"RDY", nil, {{"MPD_SMS_AG_RDY_Label", 2}}})
add_PB_label(9, {"       ", nil, {{"MPD_SMS_6_10PBLabels", 3, 0}}, {{"MPD_SMS_6_10PBLabels", 3, 1}}}, "", {"RDY", nil, {{"MPD_SMS_AG_RDY_Label", 3}}})
add_PB_label(10, {"       ", nil, {{"MPD_SMS_6_10PBLabels", 4, 0}}, {{"MPD_SMS_6_10PBLabels", 4, 1}}}, "", {"RDY", nil, {{"MPD_SMS_AG_RDY_Label", 4}}})

add_X_Over("BP_6_Break_X", 	154, 36, {-336, 488}, 	nil, {{"MPD_SMS_AG_X_Breaker", 0}})
add_X_Over("BP_7_Break_X", 	154, 36, {-167, 488}, 	nil, {{"MPD_SMS_AG_X_Breaker", 1}})
add_X_Over("BP_8_Break_X", 	154, 36, {2, 488}, 		nil, {{"MPD_SMS_AG_X_Breaker", 2}})
add_X_Over("BP_9_Break_X", 	154, 36, {171, 488},	nil, {{"MPD_SMS_AG_X_Breaker", 3}})
add_X_Over("BP_10_Break_X", 154, 36, {340, 488}, 	nil, {{"MPD_SMS_AG_X_Breaker", 4}})

add_PB_label(1, {"SHIP", nil, {{"MPD_SMS_SHIP_Label", 0}}, {{"MPD_SMS_SHIP_Label", 1}}})
add_PB_label(11, {"F/C", nil, {{"MPD_SMS_FC_Label", 0}}, {{"MPD_SMS_FC_Label", 1}}})
add_PB_label(13, {"STEP", nil, {{"MPD_SMS_STEP_Label"}}})
add_PB_label(14, {"UFC", nil, {{"MPD_SMS_UFC_Label", 0}}})
add_PB_label(15, {"FOV", nil, {{"MPD_SMS_FOV_Label"}}})
add_Harm_Ovrd_PB16()
--add_PB_label(17, {"LST"})
add_PB_label(18, {"MENU"})
--add_PB_label(20, {"CCM"})
add_PB_label(20, {"   ", nil, {{"MPD_SMS_IR_MAV_TRK", 0}}}, "", {"TRACK", nil, {{"MPD_SMS_IR_MAV_TRK", 1}}})

local OffsetBetweenColumn = 130
local OffsetBetweenStr = 28

addStrokeText("Station", "STA", STROKE_FNT_DFLT_100, "LeftCenter", {-380, 385})
addStrokeText("CurrStation", nil, STROKE_FNT_DFLT_100, "LeftCenter", {OffsetBetweenColumn / 2, 0.0}, "Station", {{"MPD_SMS_Curr_Station_Num"}})

addStrokeText("Timing", "TIMING", STROKE_FNT_DFLT_100, "LeftCenter", {-380, 357}, nil, {{"MPD_SMS_AGM65E_Timing", 1}})
addStrokeText("Timing_Val", nil, STROKE_FNT_DFLT_100, "LeftCenter", {110, 0}, "Timing", {{"MPD_SMS_AGM65E_Timing", 2}})

local AGM65_CAGE = {
"",
"CAGED",
"UNCAGED",
}


addStrokeText("CagedStatus", nil, STROKE_FNT_DFLT_100, "RightCenter", {450, 410}, nil, {{"MPD_SMS_AGM65E_Caged"}}, AGM65_CAGE)
addStrokeText("InRng", "IN RNG", STROKE_FNT_DFLT_100, "RightCenter", {450, 382}, nil, {{"HUD_AG_AGM65_IN_RNG", 0}})
addStrokeText("TTMR", "TTMR", STROKE_FNT_DFLT_100, "RightCenter", {450, 382}, nil, {{"HUD_AG_AGM65_IN_RNG", 1}})
addStrokeText("TTMR_val", nil, STROKE_FNT_DFLT_100, "RightCenter", {-70, 0}, "TTMR", {{"HUD_AG_AGM65_IN_RNG", 2}})

local font_sz  = 0.011

local agm_65e_font_def = {font_sz,font_sz,(3/5)*font_sz, 0}
code						= CreateElement "ceStringPoly"
code.name					= "code_value"
code.material				= "font_AGM_65E_"..string.format("%d",GetRenderTarget())
code.alignment				= "LeftCenter"
code.init_pos				= {-250, 330, 0}
code.stringdefs				= agm_65e_font_def
code.controllers            = {{"MPD_SMS_AGM65E_Code_Enter"}}
code.parent_element         = grid_image.name
Add(code)


agm_65e_cursor 	   			    = CreateElement "ceMeshPoly"
agm_65e_cursor.primitivetype    = "triangles"
agm_65e_cursor.material	   	    = displayMaterial
agm_65e_cursor.vertices         = {{0.6 * 100, 2 * rendered_line_width},
                                   {0, 2 * rendered_line_width},
                                   {0, -2 * rendered_line_width},
                                   {0.6 * 100, -2 * rendered_line_width}}
agm_65e_cursor.indices          = box_ind                         
agm_65e_cursor.parent_element   = code.name
agm_65e_cursor.controllers      = {{"MPD_SMS_AGM65E_Code_Cursor", 125}}
agm_65e_cursor.init_pos         = {60, -65}
Add(agm_65e_cursor)
use_mipfilter(agm_65e_cursor)

slave_symbol						= CreateElement "ceStringPoly"
slave_symbol.name					= "slave_symbol"
slave_symbol.material				= "font_AGM_65E_"..string.format("%d",GetRenderTarget())
slave_symbol.alignment				= "RightCenter"
slave_symbol.value					= "S"
slave_symbol.init_pos				= {430, 90, 0}
slave_symbol.stringdefs				= agm_65e_font_def
slave_symbol.parent_element			= grid_image.name
slave_symbol.controllers            = {{"MPD_SMS_AGM65_SLAVE"}}
Add(slave_symbol)



addStrokeText("CodeEntered", "CODES", STROKE_FNT_DFLT_100, "RightCenter", {380, -190}, grid_image.name, {{"MPD_SMS_Curr_AGM65E_Code", 0}})

for i = 1, 4 do
	addStrokeText("CodeEntVal"..i, nil, STROKE_FNT_DFLT_100, "RightCenter", {0, -OffsetBetweenStr*i}, "CodeEntered", {{"MPD_SMS_Curr_AGM65E_Code", i}})
	k = i + 1
	if i > 2 then
		k = i + 4
	end
	addStrokeBox("CodeEntBox"..i, 70, 28, "RightCenter", {5, 0}, "CodeEntVal"..i, {{"MPD_SMS_IR_CODE_Box", k}})
end


-- Designated waypoint marker
local TD_DiamondPlaceholder = addPlaceholder("TD_DiamondPlaceholder", {400, 450}, nil, {{"TDC_assignedDisplay"}})
addStrokeSymbol("TargetDesignateDiamond_Marker", {"stroke_symbols_HUD", "115-TD-Symbol"}, "FromSet", nil, TD_DiamondPlaceholder.name)
addDot("TD_Diamond_dot", 1.5, nil, TD_DiamondPlaceholder.name)

addStrokeText("MAV_HARM_SP_PB_Indication", nil, STROKE_FNT_DFLT_150, "CenterCenter", {0, 50}, nil, {{"MPD_HARM_SP_PB_Indication"}})
add_X_Over("MAV_HARM_SP_PB_Indication_X", 150, 36, {0, 0}, "MAV_HARM_SP_PB_Indication", {{"MPD_HARM_SP_PB_Indication_X"}})