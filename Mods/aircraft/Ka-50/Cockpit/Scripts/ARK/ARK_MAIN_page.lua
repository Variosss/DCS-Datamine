dofile(LockOn_Options.script_path.."Devices_specs/ARK.lua")
dofile(LockOn_Options.script_path.."ARK/ARK_usefull_definitions.lua")
dofile(LockOn_Options.script_path.."ARK/ARK_localizer.lua")
dofile(LockOn_Options.common_script_path.."Transliterate.lua")

local table_height = 0.78 * y_size
local subchannel_step = 2 * table_height / 9
local channel_step = subchannel_step * 2

ARK_table_main_dummy 			= CreateElement "ceSimple"
ARK_table_main_dummy.name  		= "ARK_table_main_dummy"
ARK_table_main_dummy.init_pos    = {0.00055, 0.003, 0}
Add(ARK_table_main_dummy)

txt_main_caption				= CreateElement "ceStringPoly"
txt_main_caption.name			= "txt_main_caption"
txt_main_caption.material		= "font_ARK_table"
txt_main_caption.init_pos		= {(-1 + 0.05) * x_size, (1 - 0.6 / 2) * y_size, 0}
txt_main_caption.alignment    	= "LeftCenter"
txt_main_caption.stringdefs   	= ark_table_main_caption_font
txt_main_caption.value			= LOCALIZE("КАНАЛЫ АРК")
txt_main_caption.parent_element = ARK_table_main_dummy.name
Add(txt_main_caption)
use_mipfilter(txt_main_caption)

ARK_table_dummy 			= CreateElement "ceSimple"
ARK_table_dummy.name  		= "ARK_table_dummy"
ARK_table_dummy.init_pos    = {0, - (y_size - table_height), 0}
Add(ARK_table_dummy)

table_upper_hor_line				= CreateElement "ceTexPoly"
table_upper_hor_line.name			= "table_upper_hor_line"
SetLine(table_upper_hor_line, -x_size, 0, x_size, 0)
table_upper_hor_line.init_pos		= {0, table_height, 0}
table_upper_hor_line.parent_element = ARK_table_dummy.name
table_upper_hor_line.use_mipfilter	= true
Add(table_upper_hor_line)
use_mipfilter(table_upper_hor_line)

table_central_ver_line          	= CreateElement "ceTexPoly"
table_central_ver_line.name			= "table_central_ver_line"
SetLine(table_central_ver_line, 0, -table_height, 0, table_height)
table_central_ver_line.init_pos		= {0, 0, 0}
table_central_ver_line.parent_element = ARK_table_dummy.name
table_central_ver_line.use_mipfilter	= true
Add(table_central_ver_line)
use_mipfilter(table_central_ver_line)

for r = 0, 1 do
	table_ver_line1					= CreateElement "ceTexPoly"
	table_ver_line1.name			= "table_ver_line1_" .. r
	SetLine(table_ver_line1, 0, -table_height, 0, table_height)
	table_ver_line1.init_pos		= {(-1 + r + 0.164) * x_size, 0, 0}
	table_ver_line1.parent_element	= ARK_table_dummy.name
	Add(table_ver_line1)
	use_mipfilter(table_ver_line1)
	
	table_ver_line2             	= CreateElement "ceTexPoly"
	table_ver_line2.name			= "table_ver_line2_" .. r
	SetLine(table_ver_line2, 0, -0.9 * table_height, 0, 0.9 * table_height)
	table_ver_line2.init_pos 		= {(-1 + r + 0.22) * x_size, -subchannel_step / 2, 0}
	table_ver_line2.parent_element 	= ARK_table_dummy.name
	Add(table_ver_line2)
	use_mipfilter(table_ver_line2)
	
	table_ver_line3             	= CreateElement "ceTexPoly"
	table_ver_line3.name			= "table_ver_line3_" .. r
	SetLine(table_ver_line3, 0, -table_height, 0, table_height)
	table_ver_line3.init_pos		= {(-1 + r + 0.751) * x_size, 0, 0}
	table_ver_line3.parent_element 	= ARK_table_dummy.name
	Add(table_ver_line3)
	use_mipfilter(table_ver_line3)
	--
	vert_shift = subchannel_step * 0.15
	
	txt_caption					= CreateElement "ceStringPoly"
	txt_caption.name			= "txt_caption" .. r
	txt_caption.material		= "font_ARK_table"
	txt_caption.init_pos		= {(-1 + 0.02 + r + 0.00) * x_size, table_height - subchannel_step / 2 + vert_shift, 0}
	txt_caption.alignment    	= "LeftCenter"
	txt_caption.stringdefs   	= ark_table_caption_font
	txt_caption.formats      	= {"%s"}
	txt_caption.value			= LOCALIZE("КАН РАДИОСТАНЦИЯ  ПОЗЫВ")
	txt_caption.parent_element	= ARK_table_dummy.name
	Add(txt_caption)
	use_mipfilter(txt_caption)
	for c = 0, 3 do
	
		if r == 0 then
			table_channel_hor_line              = CreateElement "ceTexPoly"
			table_channel_hor_line.name		    = "table_channel_hor_line" .. c
			SetLine(table_channel_hor_line, -x_size, 0, x_size, 0)
			table_channel_hor_line.init_pos 	= {0, table_height - subchannel_step - channel_step * c, 0}
			table_channel_hor_line.parent_element	= ARK_table_dummy.name
			Add(table_channel_hor_line)
		end

		local ch_number = r * 4 + c + 1
		
		txt_channel_number				= CreateElement "ceStringPoly"
		txt_channel_number.name			= "txt_channel_number" .. ch_number
		txt_channel_number.material		= "font_ARK_table"
		txt_channel_number.init_pos		= {(-1 + r + 0.08) * x_size, table_height - 2 * subchannel_step - channel_step * c + vert_shift, 0}
		txt_channel_number.alignment    = "LeftCenter"
		txt_channel_number.stringdefs   = ark_table_caption_font
		txt_channel_number.formats      = {"%s"}
		txt_channel_number.value		= string.format("%1d", ch_number)
		txt_channel_number.parent_element = ARK_table_dummy.name
		Add(txt_channel_number)
		use_mipfilter(txt_channel_number)
		--
		table_subchannel_hor_line              	= CreateElement "ceTexPoly"
		table_subchannel_hor_line.name		    = "table_subchannel_hor_line_" .. r .. "_" .. c
		SetLine(table_subchannel_hor_line, 0, 0, (1 - 0.164) * x_size, 0)
		table_subchannel_hor_line.init_pos 		= {(-1 + r + 0.164) * x_size, table_height - 2 * subchannel_step - channel_step * c, 0}
		table_subchannel_hor_line.parent_element = ARK_table_dummy.name
		Add(table_subchannel_hor_line)
		use_mipfilter(table_subchannel_hor_line)
		for t = 1, 2 do
			local subch_number = t
			local ark_channel_data = nil
			if channels and channels[ch_number] and channels[ch_number][subch_number] then
				ark_channel_data = channels[ch_number][subch_number]
			end
			--		
			txt_homer_type				= CreateElement "ceStringPoly"
			txt_homer_type.name			= "txt_homer_type"..string.format("%d", ch_number).."-"..string.format("%d",t)
			txt_homer_type.material		= "font_ARK_table"
			txt_homer_type.init_pos		= {(0.12 - 0.03) * x_size, 0.5 * subchannel_step * (1 - 2 * (t - 1)) , 0}
			txt_homer_type.alignment    = "LeftCenter"
			txt_homer_type.stringdefs   = ark_table_font
			if t == 1 then
				txt_homer_type.value	= LOCALIZE("Д")
			else
				txt_homer_type.value	= LOCALIZE("Б")
			end
			txt_homer_type.parent_element = txt_channel_number.name
			Add(txt_homer_type)
			use_mipfilter(txt_homer_type)
			--
			if 	ark_channel_data ~= nil then
				--
				txt_homer_name				= CreateElement "ceStringPoly"
				txt_homer_name.name			= "txt_homer_name"..string.format("%d", ch_number).."-"..string.format("%d",t)
				txt_homer_name.material		= "font_ARK_table"
				txt_homer_name.init_pos		= {0.06 * x_size, 0, 0}
				txt_homer_name.alignment    = "LeftCenter"
				txt_homer_name.stringdefs   = ark_table_font
				if ark_channel_data.name ~= nil then
					txt_homer_name.value	= UTF8_substring(TransliterateToLatDefault(ark_channel_data.name), 0, 15)
				end
				txt_homer_name.controllers	= {{"ARK22BeaconName", ch_number, t}}
				txt_homer_name.parent_element = txt_homer_type.name
				Add(txt_homer_name)
				use_mipfilter(txt_homer_name)
				--
				txt_homer_callsign				= CreateElement "ceStringPoly"
				txt_homer_callsign.name			= "txt_homer_callsign"..string.format("%d", ch_number).."-"..string.format("%d",t)
				txt_homer_callsign.material		= "font_ARK_table"
				txt_homer_callsign.init_pos		= {0.59 * x_size, 0, 0}
				txt_homer_callsign.alignment    = "LeftCenter"
				txt_homer_callsign.stringdefs   = ark_table_font	
				if ark_channel_data.callsign ~= nil then
					txt_homer_callsign.value	= UTF8_substring(TransliterateMorzeToLatDefault(ark_channel_data.callsign), 0, 6)
				end				
				txt_homer_callsign.controllers	= {{"ARK22BeaconCallsign", ch_number, t}}
				txt_homer_callsign.parent_element = txt_homer_type.name
				Add(txt_homer_callsign)
				use_mipfilter(txt_homer_callsign)
			end
		end
	end
end
