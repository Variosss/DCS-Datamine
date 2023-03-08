dofile(LockOn_Options.script_path.."EWS/RWR/indicator/RWR_ALR56_definitions.lua")

local NoiseBar_root = addPlaceholder("NoiseBar_root", nil, nil, {{"RWR_HealthStatus"}})

AddNoiseBar(0, NoiseBar_root.name)
AddNoiseBar(1, NoiseBar_root.name)
AddNoiseBar(2, NoiseBar_root.name)

AddNoiseStatus(0, {{"RWR_HealthStatus", 0}})
AddNoiseStatus(1, {{"RWR_HealthStatus", 1}})

for i = 1, 16 do
	AddThreatPlacer(i, {{"RWR_ThreatPos", i-1}})
	
	AddThreatSymbol(i, {{"RWR_ThreatSymbol", i-1, 0}}, false)
	AddThreatSymbol(i, {{"RWR_ThreatSymbol", i-1, 1}}, true) -- Enlarged symbol
	
	AddAirborneSymbol(i, {{"RWR_AirborneSymbol", i-1, 0}}, false)
	AddAirborneSymbol(i, {{"RWR_AirborneSymbol", i-1, 1}}, true)
	
	AddBoxThreatSymbol(i, {{"RWR_BoxThreatSymbol", i-1, 0}}, false)
	AddBoxThreatSymbol(i, {{"RWR_BoxThreatSymbol", i-1, 1}}, true)
	
	AddEWR_Symbol(i, {{"RWR_EWR_Symbol", i-1, 0}}, false)
	AddEWR_Symbol(i, {{"RWR_EWR_Symbol", i-1, 1}}, true)
	
	AddPrimaryThreatSymbol(i, {{"RWR_PrimaryThreatSymbol", i-1, 0}}, false)
	AddPrimaryThreatSymbol(i, {{"RWR_PrimaryThreatSymbol", i-1, 1}}, true)
	
	AddLaunchSymbol(i, {{"RWR_LaunchSymbol", i-1, 0}}, false)
	AddLaunchSymbol(i, {{"RWR_LaunchSymbol", i-1, 1}}, true)
end

local RWR_INDICATION =
{
	SEARCH = 0,
	ALT_LOW = 1,
}

AddText("SearchMode", 0.02 , -0.05, {{"RWR_IndicationInCenter", RWR_INDICATION.SEARCH}}, "S")
AddText("AltLowMode", 0.02 , -0.05, {{"RWR_IndicationInCenter", RWR_INDICATION.ALT_LOW}}, "L")