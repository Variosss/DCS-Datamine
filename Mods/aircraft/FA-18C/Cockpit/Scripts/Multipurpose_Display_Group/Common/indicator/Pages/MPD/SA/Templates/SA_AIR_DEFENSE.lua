dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/MPD_page_defs.lua")
dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/MDG_strokesDefs.lua")

local SA_AIR_DEFENSE_Element_Root = addPlaceholder("SA_AirDefense", nil, nil, {{"MPD_SA_SetSymbolPosition", DYNAMIC_DATA.SA_AIR_DEFENSE}, SA_DeclutterMREJ1_Show_controller})

local SA_AIR_DEFENSE_Element_Outlined = addPlaceholder(SA_AIR_DEFENSE_Element_Root.name.."_Outlined", nil, SA_AIR_DEFENSE_Element_Root.name, {{"MPD_SA_DisableDrawOutlinedOnDDI"}})
stroke_thickness = DMC_outline_thickness
stroke_fuzziness = DMC_outline_fuzziness
stroke_font = "font_MPD_DMC_outline"
SA_AirDefense_Symbol(SA_AIR_DEFENSE_Element_Outlined.name, 1)

local SA_AIR_DEFENSE_Element_DMC = addPlaceholder(SA_AIR_DEFENSE_Element_Root.name.."_DMC", nil, SA_AIR_DEFENSE_Element_Root.name)
stroke_thickness = DMC_stroke_thickness
stroke_fuzziness = DMC_stroke_fuzziness
stroke_font = "font_MPD_DMC_main"
SA_AirDefense_Symbol(SA_AIR_DEFENSE_Element_DMC.name, 0)
