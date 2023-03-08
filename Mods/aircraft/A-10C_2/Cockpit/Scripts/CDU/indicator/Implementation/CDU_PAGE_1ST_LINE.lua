dofile(LockOn_Options.script_path.."CDU/indicator/CDU_definitions.lua")

AddText		("CurrFlightPlanLetter0", 10, 1, LFT, {{"CurrFlightPlanLetter"}, {"TestModeOff"}}, "F")
AddText		("CurrFlightPlanLetter1", 10, 1, LFT, {{"TestModeOn"}}, "TST")

if RepeaterMode then
	AddText		("Asterisk", 1, 1, LFT, {{"Asterisk", 0.2}}, "*")
else
	AddText		("Asterisk", 1, 1, LFT, {{"Asterisk", 1.0}}, "*")
end

AddText		("CurrFlightPlanNumber", 11, 1, LFT, {{"CurrFlightPlanNumber"}, {"TestModeOff"}})

AddText		("CurrSteerPointAsterisk", 14, 1, LFT, {{"TestModeOff"}, {"CurrSteerPointNumber", 0}}, "****")
AddText		("CurrSteerPointNumber",   14, 1, LFT, {{"TestModeOff"}, {"CurrSteerPointNumber", 1}})

AddText		("DTSAS_EGI_STATUS",	   23, 1, RGHT, {{"DTSAS_EGI_STATUS"}})
