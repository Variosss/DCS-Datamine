dofile(LockOn_Options.script_path.."AN_ALR69V/indicator/AN_ALR69V_definitions.lua")

AddText(FailureStatus, 0.00, -0.05, {{"FailureStatus", 1}}, "F")
AddPoint({{"FailureStatus", 0}})

AddNoiseBar(0, {{"RWRHealthStatus"}})
AddNoiseBar(1, {{"RWRHealthStatus"}})
AddNoiseBar(2, {{"RWRHealthStatus"}})

AddNoiseStatus(0, {{"RWRHealthStatus", 0}})
AddNoiseStatus(1, {{"RWRHealthStatus", 1}})

for i = 1, 16 do
	AddThreatPlacer(i, {{"ThreatPos", i-1}})
end

for i = 1, 16 do
	AddThreatSymbol(i, {{"ThreatSymbol", i-1}})
end

for i = 1, 16 do
	AddAirborneSymbol(i, {{"AirborneSymbol", i-1}})
end

for i = 1, 16 do
	AddPrimaryThreatSymbol(i, {{"PrimaryThreatSymbol", i-1}})
end

for i = 1, 16 do
	AddNewGuySymbol(i, {{"NewGuySymbol", i-1}})
end

for i = 1, 16 do
	AddLaunchSymbol(i, {{"LaunchSymbol", i-1}})
end

for i = 1, 16 do
	AddMWS_Symbol(i, {{"MWS_Threat_PosAndSymbol", i-1}})
end