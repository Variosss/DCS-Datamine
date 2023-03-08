dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/RDR/RDR_defs.lua")
dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/MDG_strokesDefs.lua")

local RDR_FF_Element_Root = addPlaceholder("RDR_ff", {0, -tactical_display_sz_half}, nil, {{"MPD_RDR_MSI_Symbol_Position", DYNAMIC_DATA.RDR_FF, tactical_display_sz_half}})
SA_FF_Symbol(RDR_FF_Element_Root.name, {"MPD_RDR_MSI_SetCourse", DYNAMIC_DATA.RDR_FF, 20}, 0)

local trackedTgt_MachAlt_ShiftX		= 35
addStrokeText("RDR_FF_Mach", nil, STROKE_FNT_DFLT_100, "RightCenter", {-trackedTgt_MachAlt_ShiftX, 0}, RDR_FF_Element_Root.name, {{"MPD_RDR_TWS_FF_TUC_Mach"}, {"MPD_SA_FF_Color", 0}})
addStrokeText("RDR_FF_Altitude", nil, STROKE_FNT_DFLT_100, "LeftCenter", {trackedTgt_MachAlt_ShiftX, 0}, RDR_FF_Element_Root.name, {{"MPD_RDR_TWS_FF_TUC_Altitude"}, {"MPD_SA_FF_Color", 0}})