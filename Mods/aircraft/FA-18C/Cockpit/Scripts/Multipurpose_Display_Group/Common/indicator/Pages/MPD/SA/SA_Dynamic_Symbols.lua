dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/MPD_page_defs.lua")

------------------------------------------ SA DYNAMIC SYMBOLS ------------------------------------------
addPlaceholder("SA_AIR_DEFENSE_Keeper", nil, nil, {{"MPD_updateMultipleSymbolsBuffer", DYNAMIC_DATA.SA_AIR_DEFENSE}})
addPlaceholder("SA_PPLI_Keeper", nil, nil, {{"MPD_updateMultipleSymbolsBuffer", DYNAMIC_DATA.SA_PPLI}})
addPlaceholder("SA_SURVEILLANCE_Keeper", nil, nil, {{"MPD_updateMultipleSymbolsBuffer", DYNAMIC_DATA.SA_SURVEILLANCE}})
addPlaceholder("SA_FF_Keeper", nil, nil, {{"MPD_updateMultipleSymbolsBuffer", DYNAMIC_DATA.SA_FF}})
