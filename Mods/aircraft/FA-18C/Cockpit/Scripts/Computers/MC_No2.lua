dofile(LockOn_Options.script_path.."Computers/MC_No1.lua")
dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/MPD_PB_defs.lua")
dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/AZ_EL/AZ_EL_Defs.lua")
dofile(LockOn_Options.common_script_path.."AN_ALR_SymbolsBase.lua")

-- Failures
F18_MC_FAILURE	= 0

Damage = {	
	{Failure = F18_MC_FAILURE,	Failure_name = "Failure_Comp_MC2",	Failure_editor_name = _("MC 2 FAILURE"),	Element = 5,	Integrity_Treshold = 0.7, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
}