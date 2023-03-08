dofile(LockOn_Options.common_script_path.."elements_defs.lua")
dofile(LockOn_Options.script_path.."config.lua")

use_mipfilter = true

local scale = 1 / 1000

local cols = 3
local rows = 7

local chan_col_width = 7.0
local freq_col_width = 12.0
local col_width = chan_col_width + freq_col_width
local row_height = 3.75

local border_height = row_height * 0.0
local border_width = chan_col_width * -0.2

local org_x = border_width + (-cols / 2 * col_width) + chan_col_width
local org_y = -border_height + (rows / 2 * row_height)

local char_height = row_height * 0.75
local char_width = freq_col_width / 7


local channel_no = 0

local col_dy = {-0.05 * chan_col_width, - 0.025 * chan_col_width, 0.0}

for i = 1, cols do
	for j = 1, rows do
		if not (i == 1 and j == 1) then
			
			local pos_x = org_x + (i - 1) * col_width
			local pos_y = org_y - (j - 0.5) * row_height
			
			pos_y = pos_y + col_dy[i]
			
			txtCh				= CreateElement "ceStringPoly"
			txtCh.name			= "txtCh"..i..j
			txtCh.material		= "font_UHF_RADIO_CH_MAP"
			txtCh.init_pos		= {pos_x * scale, pos_y * scale, 0.0}
			txtCh.alignment		= "LeftCenter"
			txtCh.value			= 9-i.."00.00"..j
			txtCh.stringdefs	= {char_height * scale, char_width * scale, 0.25 * scale, 0.0}
			txtCh.use_mipfilter	= use_mipfilter
			txtCh.controllers	= {{"txtChannelMapSheet", channel_no}}
			Add(txtCh)
			
			channel_no = channel_no + 1
		end
	end
end
