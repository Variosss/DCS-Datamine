dofile(LockOn_Options.common_script_path.."elements_defs.lua")
dofile(LockOn_Options.script_path.."config.lua")

use_mipfilter = true

local scale = 1 / 1000

local cols = 3
local rows = 7

local freq_col_width = 11
local chan_col_width = 3.6
local col_width = chan_col_width + freq_col_width
local row_height = 3.6

local char_height = 2.5
local col_chars = 7

local channel_no = 1

for i = 1, cols do
	for j = 1, rows do
		if not (i == 1 and j == 1) then
			local org_x = -cols / 2 * col_width
			local org_y = rows / 2 * row_height
			local pos_x = org_x + (i - 1) * col_width + chan_col_width
			local pos_y = org_y - (j - 0.5) * row_height
			if i == 3 then
				pos_x = pos_x + 0.3 * chan_col_width
			end
			txtCh				= CreateElement "ceStringPoly"
			txtCh.name			= "txtCh"..i..j
			txtCh.material		= "font_UHF_RADIO_CH_MAP"
			txtCh.init_pos		= {pos_x * scale, pos_y * scale, 0.0}
			txtCh.alignment		= "LeftCenter"
			txtCh.value			= i.."00.00"..j
			txtCh.stringdefs	= {char_height * scale, freq_col_width / col_chars * scale, 0.0, 0.0}
			txtCh.use_mipfilter	= use_mipfilter
			txtCh.controllers	= {{"txtChannelMapSheet", channel_no}}
			Add(txtCh)
			
			channel_no = channel_no + 1
		end
	end
end

