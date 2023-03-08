dofile(LockOn_Options.script_path.."MFCD/indicator/MFCD_useful_definitions.lua")

training_label							= CreateElement "ceStringPoly"
training_label.name						= "TRAINING_LABEL"
training_label.material					= font_MFCD_BLUE
training_label.alignment				= "CenterBottom"
training_label.init_pos					= {375,max_pixels_count-80,0}
SetLowerLeftCornerOrigin(training_label)
training_label.stringdefs				= predefined_fonts[1]
training_label.UseBackground			= false
training_label.BackgroundMaterial		= MFCD_SOLID_BLACK
training_label.value					= "TRAINING"
training_label.controllers				= {{"DSMS_training_label"}}
Add(training_label)
use_mipfilter(training_label) 

training_frame							=  line_2_pixel({{-45,23},{45,23},{45,2},{-45,2},{-45,23}}, MFCD_BLUE)
training_frame.parent_element			=  training_label.name

WpnName						= CreateElement "ceStringPoly"
WpnName.name				= "WPN_NAME"
WpnName.material			= font_MFCD
WpnName.UseBackground		= true
WpnName.BackgroundMaterial	= MFCD_SOLID_BLACK
WpnName.alignment			= "CenterCenter"
WpnName.init_pos			= {160+267/2,max_pixels_count-127+DSMS_StringHeight,0}
WpnName.controllers			= {{"DSMS_selected_profile_wpn_name"}}
WpnName.stringdefs			= predefined_fonts[1]
SetLowerLeftCornerOrigin(WpnName)
Add(WpnName)
use_mipfilter(WpnName)


StationsWidth	= 36

StationsBackground={}
for i=1, 11 do
	StationsBackground[i]						= CreateElement "ceMeshPoly"
	StationsBackground[i].name				= "STATIONS_COLOR"..i
	StationsBackground[i].material			= MFCD_SOLID_GREEN
	StationsBackground[i].primitivetype   	= "triangles"
	StationsBackground[i].init_pos			= {90,max_pixels_count-520,0}
	StationsBackground[i].vertices        	= {{StationsWidth*(i-1), 0}, 
											{StationsWidth*(i-1), 25}, 
											{StationsWidth*(i-0), 25},
											{StationsWidth*(i-0), 0}}
	StationsBackground[i].indices	       	= box_ind
	StationsBackground[i].isdraw			= false
	StationsBackground[i].controllers		= {{"DSMS_store_background_visible_selected", i-1}}
	SetLowerLeftCornerOrigin(StationsBackground[i])
	Add(StationsBackground[i])
	use_mipfilter(StationsBackground[i])
end

TableBorder					= line_2_pixel({{0, max_pixels_count-145},
											{0, max_pixels_count-85}, 
											{267, max_pixels_count-85}, 
											{267, 80},
											{0, 80},
											{0, max_pixels_count-145},
											{267, max_pixels_count-145}}, MFCD_GREEN)

TableBorder.init_pos	    = {160,0,0}
SetLowerLeftCornerOrigin(TableBorder)


StationsTable				= line_2_pixel({{0, 0},
											{StationsWidth*11, 0}, 
											{StationsWidth*11, 25}, 
											{0, 25}}, MFCD_GREEN)
StationsTable.init_pos		= {90,max_pixels_count-520,0}
SetLowerLeftCornerOrigin(StationsTable)

StationsVertLines = {}
for i=0, 11 do
	StationsVertLines[i]				= line_2_pixel({{StationsWidth*i, 0},
														{StationsWidth*i, 25}}, MFCD_GREEN)
	StationsVertLines[i].init_pos	    = StationsTable.init_pos
	SetLowerLeftCornerOrigin(StationsVertLines[i])
end

StoreNumber = {}
for i = 1, 11 do
	StoreNumber[i]					= CreateElement "ceStringPoly"
	StoreNumber[i].name				= "STORE_NUMBER"..string.format("%d",i)
	StoreNumber[i].value			= string.format("%d",i)
	StoreNumber[i].material			= font_MFCD
	StoreNumber[i].UseBackground	= false
	StoreNumber[i].alignment		= "CenterCenter"
	StoreNumber[i].controllers		= {{"DSMS_store_color_selected", i-1}}
	StoreNumber[i].stringdefs		= predefined_fonts[1]
	StoreNumber[i].init_pos			= {90 + StationsWidth / 2 + StationsWidth * (i - 1), max_pixels_count - 520 + 25 / 2, 0}
	SetLowerLeftCornerOrigin(StoreNumber[i])
	Add(StoreNumber[i])
	use_mipfilter(StoreNumber[i])
end


TableNames={}
for i=1, 14 do
	TableNames[i]						= CreateElement "ceStringPoly"
	TableNames[i].name					= "TABLE_NAMES"..i
	TableNames[i].material				= font_MFCD
	TableNames[i].UseBackground			= false
	TableNames[i].alignment				= "LeftTop"
	TableNames[i].init_pos				= {165,max_pixels_count-145-3-(DSMS_StringHeight-0)*(i-1),0}
	TableNames[i].controllers			= {{"DSMS_view_profile_names", i}}
	TableNames[i].stringdefs			= predefined_fonts[1]
	SetLowerLeftCornerOrigin(TableNames[i])
	Add(TableNames[i])
	use_mipfilter(TableNames[i])
end

TableParams={}
for i=1, 14 do
	TableParams[i]						= CreateElement "ceStringPoly"
	TableParams[i].name					= "TABLE_PARAMS"..i
	TableParams[i].material				= font_MFCD
	TableParams[i].UseBackground		= false
	TableParams[i].alignment			= "LeftTop"
	TableParams[i].init_pos				= {320,max_pixels_count-145-3-(DSMS_StringHeight-0)*(i-1),0}
	TableParams[i].controllers			= {{"DSMS_view_profile_params", i}}
	TableParams[i].stringdefs			= predefined_fonts[1]
	SetLowerLeftCornerOrigin(TableParams[i])
	Add(TableParams[i])
	use_mipfilter(TableParams[i])
end

TableUnderline={}
for i=1, 14 do
	TableUnderline[i]					= CreateElement "ceStringPoly"
	TableUnderline[i].name				= "TABLE_UNDERLINE"..i
	TableUnderline[i].material			= font_MFCD
	TableUnderline[i].UseBackground		= false
	TableUnderline[i].alignment			= "LeftTop"
	TableUnderline[i].controllers		= {{"DSMS_view_profile_params_underline", i}}
	TableUnderline[i].stringdefs		= predefined_fonts[1]
	TableUnderline[i].parent_element	= TableParams[i].name
	Add(TableUnderline[i])
	use_mipfilter(TableUnderline[i])
end

