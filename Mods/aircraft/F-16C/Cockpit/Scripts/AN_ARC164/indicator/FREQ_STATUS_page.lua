dofile(LockOn_Options.common_script_path.."elements_defs.lua")
dofile(LockOn_Options.script_path.."config.lua")

use_mipfilter = true

local scale = 1 / 1000
local char_size = 8.5

txtDot					= CreateElement "ceStringPoly"
txtDot.name				= "txtDot"
txtDot.material			= "font_UHF_RADIO"
txtDot.init_pos			= {0.0, 0.0, 0.0}
txtDot.alignment		= "CenterCenter"
txtDot.value			= "."
txtDot.stringdefs		= {char_size * scale, char_size * scale, 0.0, 0.0}
txtDot.use_mipfilter	= use_mipfilter
Add(txtDot)

txtFreqStatus					= CreateElement "ceStringPoly"
txtFreqStatus.name				= "txtFreqStatus"
txtFreqStatus.material			= "font_UHF_RADIO"
txtFreqStatus.init_pos			= {1.25 * scale, 0.0, 0.0}
txtFreqStatus.alignment			= "CenterCenter"
txtFreqStatus.value				= "******"
txtFreqStatus.controllers		= {{"txtFrequencyStatus"}}
txtFreqStatus.stringdefs		= {char_size * scale, char_size * scale, 2.5 * scale, 0.0}
txtFreqStatus.use_mipfilter		= use_mipfilter
Add(txtFreqStatus)
