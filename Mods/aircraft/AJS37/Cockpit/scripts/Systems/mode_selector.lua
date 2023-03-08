local landing_gear_system = GetSelf()
local dev = GetSelf()

local update_time_step = 0.05
make_default_activity(update_time_step)

local sensor_data = get_base_data()
local SwitchModeRight  = 3001 --iCommandPlaneFlaps 72, IcommandPlaneGear 68
local SwitchModeLeft = 3002
local AltimeterSettingRight = 3003
local AltimeterSettingLeft = 3004
local AltimeterSettingKnob = 3005
local SwitchParam  = get_param_handle("MODE_SELECT_SWITCH")
local SwitchParamLeft  = get_param_handle("MODE_SELECT_SWITCH_LEFT") 
local AltimeterSettingRightParam  = get_param_handle("ALTIMETERSETTINGTURNRIGHT")
local AltimeterSettingLeftParam  = get_param_handle("ALTIMETERSETTINGTURNLEFT") 
local AltimeterSettingKnobParam = get_param_handle("ALTIMETERSETTINGKNOB")

print("MODE SELECT SYSTEM")

dev:listen_command(SwitchModeLeft)
dev:listen_command(SwitchModeRight)
dev:listen_command(AltimeterSettingRight)
dev:listen_command(AltimeterSettingLeft)
dev:listen_command(AltimeterSettingKnob)


function SetCommand(command,value)		
		
	if (command == SwitchModeRight) then
		print_message_to_user("Switching mode right.")
		SwitchParam:set(1)
	end
	if (command == SwitchModeLeft) then
		print_message_to_user("Switching mode left.")
		SwitchParamLeft:set(1)
	end
	
	if (command == AltimeterSettingRight) then
		--print_message_to_user("Turning altimeter right.")
		AltimeterSettingRightParam:set(1)
	end
	if (command == AltimeterSettingLeft) then
		--print_message_to_user("Turning altimeter left.")
		AltimeterSettingLeftParam:set(1)
	end
	if (command == AltimeterSettingKnob) then
		AltimeterSettingKnobParam:set(value)
	end
end

function update()

end


