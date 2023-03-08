dofile(LockOn_Options.script_path.."UHF_ARC_51/AN_ARC51_usefull_definitions.lua")

SheetTable_MainDummy			= CreateElement "ceSimple"
SheetTable_MainDummy.name		= "SheetTable_MainDummy"
SheetTable_MainDummy.init_pos	= {0.0, 0.0, -0.00005}
SheetTable_MainDummy.isvisible	= true
Add(SheetTable_MainDummy)

sheet_bar_mask					= CreateElement "ceMeshPoly"
sheet_bar_mask.name				= "sheet_bar_mask"
sheet_bar_mask.primitivetype	= "triangles"
sheet_bar_mask.vertices			= {	{  -x_size_05, -y_size_05},
									{  -x_size_05,  y_size_05},
									{ x_size_05,  y_size_05},
									{ x_size_05, -y_size_05}}
sheet_bar_mask.indices			= default_box_indices
sheet_bar_mask.material			= "DBG_GREEN"
sheet_bar_mask.parent_element	= SheetTable_MainDummy.name
sheet_bar_mask.isvisible		= false
Add(sheet_bar_mask)


for channel = 1, 20 do
	SheetTable_Channel					= CreateElement "ceStringPoly"
	SheetTable_Channel.name				= "SheetTable_Channel"..string.format("%d", channel)
	SheetTable_Channel.material			= "font_ARC51_sheet"
	SheetTable_Channel.init_pos			= {get_channel_x(channel), get_channel_y(channel), 0}
	SheetTable_Channel.alignment		= "LeftCenter"
	SheetTable_Channel.stringdefs		= ARC51_table_font
	SheetTable_Channel.value			= "0.0"
	SheetTable_Channel.controllers		= {{"ChannelText", channel}}
	SheetTable_Channel.parent_element	= sheet_bar_mask.name
	Add(SheetTable_Channel)
	use_mipfilter(SheetTable_Channel)
end
