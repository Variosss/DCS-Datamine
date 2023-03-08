dofile("Scripts/Database/wsTypes.lua")

StoreIndexes = {}
StoreIndexes[1] = 0
StoreIndexes[2] = 1
StoreIndexes[3] = 2
StoreIndexes[4] = 3
StoreIndexes[5] = 4
StoreIndexes[6] = 5
StoreIndexes[7] = 6
StoreIndexes[8] = 7
StoreIndexes[9] = 8
StoreIndexes[10] = 9
StoreIndexes[11] = 10


function AddStatLabel()
	local OsbLabelStat = add_OSB_label(1,BRANCH_L .. "STAT")
	addOSB_Box(1, {OsbLabelStat})
	add_osb_static_hint(1, _("Return to DSMS Status page"))
end

function AddRetLabel()
	local OsbLabelRet = add_OSB_label(2,BRANCH_L .. "RET")
	addOSB_Box(2, {OsbLabelRet})
end

function AddMaverickPowerTimeLabel()
	maverick_power_time                 = CreateElement "ceStringPoly"
	maverick_power_time.name			= "txt_sensor"
	maverick_power_time.material		= font_MFCD
	maverick_power_time.alignment		= "RightCenter"
	maverick_power_time.stringdefs		= predefined_fonts[1]
	maverick_power_time.formats 		= {" EO %02d:%02d:%02d"}
	maverick_power_time.controllers     = {{"maverick_power_on"}, {"maverick_power_time", 0}}
	maverick_power_time.UseBackground			= false
	maverick_power_time.BackgroundMaterial		= MFCD_SOLID_BLACK
	shift_button_pos(maverick_power_time, 10, -10, -87)
	Add(maverick_power_time)
	use_mipfilter(maverick_power_time) 

	maverick_power_time_frame				=  line_2_pixel_with_background({{-129,12},{0,12},{0,-12},{-129,-12},{-129,12}})
	maverick_power_time_frame.parent_element=  maverick_power_time.name
end

function AddInventoryTrainingLabel()
	training_label							= CreateElement "ceStringPoly"
	training_label.name						= "TRAINING_LABEL"
	training_label.material					= font_MFCD_BLUE
	training_label.alignment				= "CenterBottom"
	training_label.init_pos					= {max_pixels_count/2,OSB_positions[7][2],0}
	SetLowerLeftCornerOrigin(training_label)
	training_label.stringdefs				= predefined_fonts[1]
	training_label.UseBackground			= false
	training_label.BackgroundMaterial		= MFCD_SOLID_BLACK
	training_label.value					= "TRAINING"
	training_label.controllers				= {{"DSMS_training_label"}}
	Add(training_label)
	use_mipfilter(training_label) 

	training_frame						=  line_2_pixel({{-45,23},{45,23},{45,2},{-45,2},{-45,23}}, MFCD_BLUE)
	training_frame.parent_element		=  training_label.name
end

function AddStationNumber()
	StationNumber						= CreateElement "ceStringPoly"
	StationNumber.name					= "StationNumber"
	StationNumber.material				= font_MFCD
	StationNumber.init_pos				= {max_pixels_count/2,OSB_positions[20][2]-140,0}
	StationNumber.alignment				= "CenterCenter"
	StationNumber.stringdefs			= predefined_fonts[2]
	StationNumber.formats 				= {"STA %d"}
	StationNumber.controllers     		= {{"DSMS_station_number", 0}}
	StationNumber.UseBackground			= false
	StationNumber.BackgroundMaterial	= MFCD_SOLID_BLACK
	SetLowerLeftCornerOrigin(StationNumber)
	Add(StationNumber)
	use_mipfilter(StationNumber) 

	StationNumber_underline					= CreateElement "ceStringPoly"
	StationNumber_underline.name			= "StationNumber_UNDERLINE"
	StationNumber_underline.material		= font_MFCD
	StationNumber_underline.UseBackground	= false
	StationNumber_underline.alignment		= "CenterCenter"
	StationNumber_underline.controllers		= {{"DSMS_underline"}}
	StationNumber_underline.stringdefs		= predefined_fonts[2]
	StationNumber_underline.parent_element	= StationNumber.name
	Add(StationNumber_underline)
	use_mipfilter(StationNumber_underline)
end

function AddPylonName(param)
	Pylon							= CreateElement "ceStringPoly"
	Pylon.name						= "Pylon"
	Pylon.material					= font_MFCD
	Pylon.init_pos					= {max_pixels_count/2,OSB_positions[20][2]-175,0}
	Pylon.alignment					= "CenterCenter"
	Pylon.stringdefs				= predefined_fonts[2]
	Pylon.formats 					= {"%s"}
	Pylon.controllers     			= {{"DSMS_inventory_pylon_name", param}}
	Pylon.UseBackground				= false
	Pylon.BackgroundMaterial		= MFCD_SOLID_BLACK
	SetLowerLeftCornerOrigin(Pylon)
	Add(Pylon)
	use_mipfilter(Pylon) 
end

function AddInventoryText()
	InventoryText							= CreateElement "ceStringPoly"
	InventoryText.name						= "InventoryText"
	InventoryText.material					= font_MFCD
	InventoryText.alignment					= "CenterCenter"
	InventoryText.init_pos					= {max_pixels_count/2,OSB_positions[20][2]-35,0}
	SetLowerLeftCornerOrigin(InventoryText)
	InventoryText.stringdefs				= predefined_fonts[2]
	InventoryText.UseBackground				= false
	InventoryText.BackgroundMaterial		= MFCD_SOLID_BLACK
	InventoryText.value						= "INVENTORY"
	Add(InventoryText)
	use_mipfilter(InventoryText) 
end

function AddWpnNameCount()
	WpnNameCount							= CreateElement "ceStringPoly"
	WpnNameCount.name						= "WpnNameCount"
	WpnNameCount.material					= font_MFCD
	WpnNameCount.init_pos					= {max_pixels_count/2,OSB_positions[20][2]-210,0}
	WpnNameCount.alignment					= "CenterCenter"
	WpnNameCount.stringdefs					= predefined_fonts[2]
	WpnNameCount.formats 					= {"%s"}
	WpnNameCount.controllers     			= {{"DSMS_inventory_wpn_name_count", 0}}
	WpnNameCount.UseBackground				= false
	WpnNameCount.BackgroundMaterial			= MFCD_SOLID_BLACK
	SetLowerLeftCornerOrigin(WpnNameCount)
	Add(WpnNameCount)
	use_mipfilter(WpnNameCount) 
end
