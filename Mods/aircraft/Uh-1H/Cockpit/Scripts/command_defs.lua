-- Commands : not intended for end-user editing

Keys =
{
	PlaneFire								= 84,
	PlaneFireOff							= 85,
	
	PlaneLightsOnOff						= 175,
	PlaneCockpitIllumination				= 300,
	
	CopilotPlaneFireOn						= 350,
	CopilotPlaneFireOff						= 351,
	
	PlaneCockpitIlluminationPanels			= 493,
	PlaneCockpitIlluminationGauges			= 494,	
	
	PlaneAntiCollisionLights				= 518,

	CockpitIllumination						= 815,
	  
    iCommandPlaneCockpitIllumination       = 300,
    iCommandPlaneCockpitIlluminationPanels = 493,
    iCommandPlaneCockpitIlluminationGauges = 494,
    iCommandCockpitShowPilotOnOff          = 835,

	iCommandPitotAoAHeat                    = 910,
	iCommandPitotRam                        = 911,
	
	PlaneTrimOn								= 957,
	PlaneTrimOff							= 958,
	PlaneTrimCancel							= 97,

	Throttle_Inc							= 1032,
	Throttle_Dec							= 1033,
	
	Plane_SpotLight_left  					= 511,
	Plane_SpotLight_right 					= 512,
	Plane_SpotLight_up						= 513,
	Plane_SpotLight_down 					= 514,
	Plane_SpotLight_stop 					= 515,
}

start_command   = 3000
device_commands = {}
for cmd_num = 1,70 do
	device_commands["Button_"..cmd_num] = start_command + cmd_num
end

cb_start_cmd = device_commands.Button_21
cb_end_cmd = cb_start_cmd + 63
