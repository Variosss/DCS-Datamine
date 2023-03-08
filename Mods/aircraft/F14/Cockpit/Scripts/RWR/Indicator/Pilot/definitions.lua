dofile(LockOn_Options.common_script_path.."elements_defs.lua")
dofile(LockOn_Options.script_path.."Scripts/Common/levels.lua")

INDICATOR_LEVEL = RWR_DEFAULT_LEVEL

dofile(LockOn_Options.script_path.."Scripts/Common/common_defs.lua")

size = 0.089
halfsize = 0.5 * size
status_dist = 0.025 * size

RWR_fontsize = 0.0054
RWR_fontsize_x = RWR_fontsize * 1.0
RWR_fontsize_y = RWR_fontsize
RWR_fontshift = -0.115 * RWR_fontsize
RWR_string_def = {RWR_fontsize_y, RWR_fontsize_x, RWR_fontshift, 0}

RWR_string_def_BIT = {RWR_fontsize_y, RWR_fontsize_x, -0.20 * RWR_fontsize, 0.0045}

cx = 0
cy = 0

function AddRwrElement(object)
    object.use_mipfilter = true
	object.additive_alpha = false
    Add(object)
end