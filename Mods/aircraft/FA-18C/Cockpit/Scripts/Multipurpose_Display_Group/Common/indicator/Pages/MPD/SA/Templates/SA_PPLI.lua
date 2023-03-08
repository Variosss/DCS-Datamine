dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/MPD_page_defs.lua")
dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/MDG_strokesDefs.lua")

local SA_PPLI_Element_Root = addPlaceholder("SA_ppli", nil, nil, {{"MPD_SA_SetSymbolPosition", DYNAMIC_DATA.SA_PPLI}})

local SA_PPLI_Element_Outlined = addPlaceholder(SA_PPLI_Element_Root.name.."_Outlined", nil, SA_PPLI_Element_Root.name, {{"MPD_SA_DisableDrawOutlinedOnDDI"}})
stroke_thickness = DMC_outline_thickness
stroke_fuzziness = DMC_outline_fuzziness
stroke_font = "font_MPD_DMC_outline"
SA_PPLI_Symbol(SA_PPLI_Element_Outlined.name, {"MPD_SA_SetCourse", DYNAMIC_DATA.SA_PPLI, 20}, 1, true)

local SA_PPLI_Element_DMC = addPlaceholder(SA_PPLI_Element_Root.name.."_DMC", nil, SA_PPLI_Element_Root.name)
stroke_thickness = DMC_stroke_thickness
stroke_fuzziness = DMC_stroke_fuzziness
stroke_font = "font_MPD_DMC_main"
SA_PPLI_Symbol(SA_PPLI_Element_DMC.name, {"MPD_SA_SetCourse", DYNAMIC_DATA.SA_PPLI, 20}, 0, true)