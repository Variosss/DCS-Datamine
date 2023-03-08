dofile(LockOn_Options.script_path.."CDU/indicator/CDU_pages.lua")

CDU_preinit_files_path = LockOn_Options.script_path.."MFCD/Indicator/CDU_repeater/Preinit/"

dofile(LockOn_Options.script_path.."CDU/indicator/CDU_subsets_init.lua")
AddSubset1 = id_pagesubset.MFCD_BACKGROUND
AddSubset2 = id_pagesubset.MFCD_OSB_11_15
AddSubset3 = id_pagesubset.MFCD_CDU_REPEATER
dofile(LockOn_Options.script_path.."CDU/indicator/CDU_pages_init.lua")
