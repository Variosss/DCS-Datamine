dofile(LockOn_Options.common_script_path.."elements_defs.lua")
dofile(LockOn_Options.script_path.."config.lua")

use_mipfilter = true

local scale = 1 / 1000

txtPresetChannel					= CreateElement "ceStringPoly"
txtPresetChannel.name				= "txtPresetChannel"
txtPresetChannel.material			= "font_UHF_Repeater"
txtPresetChannel.init_pos			= {0.0009, 0.0, 0.0}
txtPresetChannel.alignment			= "RightCenter"
txtPresetChannel.value				= "1."
txtPresetChannel.controllers		= {{"RepeaterSource", 0}, {"txtRepeaterChannel"}}
txtPresetChannel.stringdefs			= {7 * scale, 6.4 * scale, 0.8 * scale, 0.0}
txtPresetChannel.use_mipfilter		= use_mipfilter
Add(txtPresetChannel)

txtFreqStatus					= CreateElement "ceStringPoly"
txtFreqStatus.name				= "txtFreqStatus"
txtFreqStatus.material			= "font_UHF_Repeater"
txtFreqStatus.init_pos			= {0.0, 0.0, 0.0}
txtFreqStatus.alignment			= "CenterCenter"
txtFreqStatus.value				= "***.***"
txtFreqStatus.controllers		= {{"RepeaterSource", 1}, {"txtRepeaterFrequency"}}
txtFreqStatus.stringdefs		= {7 * scale, 6.4 * scale, 0.8 * scale, 0.0}
txtFreqStatus.use_mipfilter		= use_mipfilter
Add(txtFreqStatus)
