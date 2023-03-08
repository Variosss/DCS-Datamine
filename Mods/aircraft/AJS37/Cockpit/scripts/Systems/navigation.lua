local dev = GetSelf()

local update_time_step = 0.01
make_default_activity(update_time_step)



local sensor_data = get_base_data()
local ModeInOut = 3001
local ModeOut = 3002
local BrytpunktL = 3008
local BrytpunktLS = 3009
local BrytpunktX = 3010
local BrytpunktOne = 3011
local BrytpunktTwo = 3012
local BrytpunktThree = 3013
local BrytpunktFour = 3014
local BrytpunktFive = 3015
local BrytpunktSix = 3016
local BrytpunktSeven = 3017
local BrytpunktEight = 3018
local BrytpunktNine = 3019
local NumpadZero = 3020
local NumpadOne = 3021
local NumpadTwo = 3022
local NumpadThree = 3023
local NumpadFour = 3024
local NumpadFive = 3025
local NumpadSix = 3026
local NumpadSeven = 3027
local NumpadEight = 3028
local NumpadNine = 3029
local NavRotaryCW = 3030
local NavRotaryCCW = 3031
local NavRotaryClick = 3032


print("LOADING NAVIGATION SYSTEM")
local commandwp_param = get_param_handle("NAV_COMMAND_WP")
local commandmode_param = get_param_handle("NAV_COMMAND_MODE")
local commandnump_param = get_param_handle("NAV_COMMAND_NUMP")
local commandnavrot_param = get_param_handle("NAV_COMMAND_ROT")
local commandnavrotsel_param = get_param_handle("NAV_COMMAND_ROTSEL")

commandwp_param:set(0)
commandmode_param:set(0)
commandnump_param:set(0)
commandnavrot_param:set(0)
commandnavrotsel_param:set(-1)


dev:listen_command(ModeInOut)
dev:listen_command(ModeOut)
dev:listen_command(BrytpunktOne)
dev:listen_command(BrytpunktTwo)
dev:listen_command(BrytpunktThree)
dev:listen_command(BrytpunktFour)
dev:listen_command(BrytpunktFive)
dev:listen_command(BrytpunktSix)
dev:listen_command(BrytpunktSeven)
dev:listen_command(BrytpunktEight)
dev:listen_command(BrytpunktNine)
dev:listen_command(NumpadZero)
dev:listen_command(NumpadOne)
dev:listen_command(NumpadTwo)
dev:listen_command(NumpadThree)
dev:listen_command(NumpadFour)
dev:listen_command(NumpadFive)
dev:listen_command(NumpadSix)
dev:listen_command(NumpadSeven)
dev:listen_command(NumpadEight)
dev:listen_command(NumpadNine)
dev:listen_command(NavRotaryCW)
dev:listen_command(NavRotaryCCW)
dev:listen_command(NavRotaryClick)


function SetCommand(command,value)		
	if command==ModeInOut then
		commandmode_param:set(value)
	end
	if command==ModeOut then
		commandmode_param:set(0)
	end
	if command==BrytpunktOne and value==1 then
		commandwp_param:set(1)
	end
	if command==BrytpunktTwo and value==1 then
		commandwp_param:set(2)
	end
	if command==BrytpunktThree and value==1 then
		commandwp_param:set(3)
	end
	if command==BrytpunktFour and value==1 then
		commandwp_param:set(4)
	end
	if command==BrytpunktFive and value==1 then
		commandwp_param:set(5)
	end
	if command==BrytpunktSix and value==1 then
		commandwp_param:set(6)
	end
	if command==BrytpunktSeven and value==1 then
		commandwp_param:set(7)
	end
	if command==BrytpunktEight and value==1 then
		commandwp_param:set(8)
	end
	if command==BrytpunktNine and value==1 then
		commandwp_param:set(9)
	end
	if command==BrytpunktX and value==1 then
		commandwp_param:set(10)
	end
	if command==BrytpunktL and value==1 then
		commandwp_param:set(11)
	end
	if command==BrytpunktLS and value==1 then
		commandwp_param:set(12)
	end
	if command==NumpadZero and value==1 then
		commandnump_param:set(0)
	end
	if command==NumpadOne and value==1 then
		commandnump_param:set(1)
	end
	if command==NumpadTwo and value==1 then
		commandnump_param:set(2)
	end
	if command==NumpadThree and value==1 then
		commandnump_param:set(3)
	end
	if command==NumpadFour and value==1 then
		commandnump_param:set(4)
	end
	if command==NumpadFive and value==1 then
		commandnump_param:set(5)
	end
	if command==NumpadSix and value==1 then
		commandnump_param:set(6)
	end
	if command==NumpadSeven and value==1 then
		commandnump_param:set(7)
	end
	if command==NumpadEight and value==1 then
		commandnump_param:set(8)
	end
	if command==NumpadNine and value==1 then
		commandnump_param:set(9)
	end
	if command==NavRotaryCW and value==1 then
		commandnavrot_param:set(2)
	end
	if command==NavRotaryCCW and value==1 then
		commandnavrot_param:set(1)
	end
	if command==NavRotaryClick then
		commandnavrotsel_param:set(value)
	end
end

function update()

end


