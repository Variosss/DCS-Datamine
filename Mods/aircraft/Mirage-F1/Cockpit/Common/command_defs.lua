
-- Device commands, can be clickable or not
start_command = 3000
devCmds = {}
for i = 1, 999 do
	devCmds["Cmd"..tostring(i)] = start_command + i
end

-- Global non-clickable commands - keyboard, joystick buttons and axes
GLOB_CMD_F1CMN_AXIS_STICK_PITCH						= 8034
GLOB_CMD_F1CMN_AXIS_STICK_ROLL						= 8035
GLOB_CMD_F1CMN_AXIS_RUDDER							= 8036