dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/MPD_page_defs.lua")
dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/MDG_strokesDefs.lua")

local SA_SURVEILLANCE_Element_Root = addPlaceholder("SA_surveillance", nil, nil, {{"MPD_SA_SetSymbolPosition", DYNAMIC_DATA.SA_SURVEILLANCE}})

local SA_SURVEILLANCE_Element_Outlined = addPlaceholder(SA_SURVEILLANCE_Element_Root.name.."_Outlined", nil, SA_SURVEILLANCE_Element_Root.name, {{"MPD_SA_DisableDrawOutlinedOnDDI"}})
stroke_thickness = DMC_outline_thickness
stroke_fuzziness = DMC_outline_fuzziness
stroke_font = "font_MPD_DMC_outline"
SA_Surveillance_Symbol(SA_SURVEILLANCE_Element_Outlined.name, {"MPD_SA_SetCourse", DYNAMIC_DATA.SA_SURVEILLANCE, 15}, 1)

local SA_SURVEILLANCE_Element_DMC = addPlaceholder(SA_SURVEILLANCE_Element_Root.name.."_DMC", nil, SA_SURVEILLANCE_Element_Root.name)
stroke_thickness = DMC_stroke_thickness
stroke_fuzziness = DMC_stroke_fuzziness
stroke_font = "font_MPD_DMC_main"
SA_Surveillance_Symbol(SA_SURVEILLANCE_Element_DMC.name, {"MPD_SA_SetCourse", DYNAMIC_DATA.SA_SURVEILLANCE, 15}, 0)