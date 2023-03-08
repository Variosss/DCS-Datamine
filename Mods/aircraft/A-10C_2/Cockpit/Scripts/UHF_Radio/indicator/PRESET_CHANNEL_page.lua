dofile(LockOn_Options.common_script_path.."elements_defs.lua")
dofile(LockOn_Options.script_path.."config.lua")

use_mipfilter = true

local scale = 1 / 1000

txtPresetChannel					= CreateElement "ceStringPoly"
txtPresetChannel.name				= "txtPresetChannel"
txtPresetChannel.material			= "font_UHF_RADIO"
txtPresetChannel.init_pos			= {0.0, 0.0, 0.0}
txtPresetChannel.alignment			= "CenterCenter"
txtPresetChannel.value				= "01"
txtPresetChannel.controllers		= {{"txtPresetChannel"}}
txtPresetChannel.stringdefs			= {5 * scale, 5 * scale, 0.0, 0.0}
txtPresetChannel.use_mipfilter		= use_mipfilter
Add(txtPresetChannel)
