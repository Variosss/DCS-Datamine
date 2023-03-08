sound_id = {}
sounds = {}


local count = -1
local function add_sound(name, folder)
	count = count + 1
	id = count
	sound_id[name]	= id
	sounds[id]	= {folder.."/"..name}
end

local function add_switch_onoff_sounds(prefix)
	add_sound(prefix.."-off", "switches")
	add_sound(prefix.."-on", "switches")
end

local function add_switch_sound(name)
	add_sound(name, "switches")
end


add_switch_onoff_sounds("guard1")
add_switch_onoff_sounds("small1")
add_switch_onoff_sounds("small2")
add_switch_onoff_sounds("small3")
add_switch_onoff_sounds("small4")
add_switch_onoff_sounds("small5")
add_switch_onoff_sounds("small6")
add_switch_onoff_sounds("lever1")
add_switch_onoff_sounds("lever2")
add_switch_onoff_sounds("lever3")
add_switch_onoff_sounds("lever4")
add_switch_onoff_sounds("lever5")
add_switch_onoff_sounds("lever6")
add_switch_onoff_sounds("pumpl")
add_switch_onoff_sounds("pumpr")
add_switch_onoff_sounds("vth")
add_switch_onoff_sounds("seljet")
add_switch_onoff_sounds("batt")
add_switch_onoff_sounds("becs")
add_switch_onoff_sounds("masterarm")
add_switch_onoff_sounds("rsmode")
add_switch_onoff_sounds("auxadi")
add_switch_onoff_sounds("parkbrake")
add_switch_onoff_sounds("green-mode")
add_switch_onoff_sounds("knob")
add_switch_onoff_sounds("startpump")
add_switch_onoff_sounds("startcover")
add_switch_onoff_sounds("fuelcutguard")
add_switch_onoff_sounds("seljetguard")
add_switch_onoff_sounds("guard1")
add_switch_onoff_sounds("guard2")
add_switch_onoff_sounds("guard3")
add_switch_onoff_sounds("guard4")
add_switch_onoff_sounds("pca")
add_switch_onoff_sounds("pushs")
add_switch_onoff_sounds("push1")
add_switch_onoff_sounds("push2")
add_switch_onoff_sounds("pcn-wp")
add_switch_onoff_sounds("pcn-grnamb")
add_switch_onoff_sounds("pcn-keypad")
add_switch_onoff_sounds("pcn-knob")
add_switch_onoff_sounds("ew-sel")
add_switch_onoff_sounds("knob")
add_switch_onoff_sounds("click1")
add_switch_onoff_sounds("click2")
add_switch_onoff_sounds("ils-mode")
add_switch_onoff_sounds("bingo")
add_switch_onoff_sounds("tacan-knob")
add_switch_onoff_sounds("landing-gear")
add_switch_onoff_sounds("mip-door")
add_switch_sound("mip-swap")