dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/RDR/RDR_defs.lua")
dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/MDG_strokesDefs.lua")

local trackedTgt_MachAlt_ShiftX		= 35

local RDR_PPLI_Element_Root = addPlaceholder("RDR_ppli", {0, -tactical_display_sz_half}, nil, {{"MPD_RDR_MSI_Symbol_Position", DYNAMIC_DATA.RDR_PPLI, tactical_display_sz_half}})
SA_PPLI_Symbol(RDR_PPLI_Element_Root.name, {"MPD_RDR_MSI_SetCourse", DYNAMIC_DATA.RDR_PPLI, 20}, 0, false)

addStrokeText("RDR_PPLI_Mach", nil, STROKE_FNT_DFLT_100, "RightCenter", {-trackedTgt_MachAlt_ShiftX, 0}, RDR_PPLI_Element_Root.name, {{"MPD_RDR_TWS_PPLI_TUC_Mach"}, {"MPD_SA_PPLI_Color", 0}})
addStrokeText("RDR_PPLI_Altitude", nil, STROKE_FNT_DFLT_100, "LeftCenter", {trackedTgt_MachAlt_ShiftX, 0}, RDR_PPLI_Element_Root.name, {{"MPD_RDR_TWS_PPLI_TUC_Altitude"}, {"MPD_SA_PPLI_Color", 0}})