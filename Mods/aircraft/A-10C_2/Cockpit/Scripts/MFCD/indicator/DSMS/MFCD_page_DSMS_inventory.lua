dofile(LockOn_Options.script_path.."MFCD/indicator/MFCD_useful_definitions.lua")
dofile(LockOn_Options.script_path.."MFCD/indicator/DSMS/MFCD_DSMS_useful_definitions.lua")

AddMaverickPowerTimeLabel()

InventoryText							= CreateElement "ceStringPoly"
InventoryText.name						= "InventoryText"
InventoryText.material					= font_MFCD
InventoryText.alignment					= "CenterCenter"
InventoryText.init_pos					= {max_pixels_count/2,(OSB_positions[20][2]+OSB_positions[19][2])/2,0}
SetLowerLeftCornerOrigin(InventoryText)
InventoryText.stringdefs				= predefined_fonts[3]
InventoryText.UseBackground				= false
InventoryText.BackgroundMaterial		= MFCD_SOLID_BLACK
InventoryText.value						= "INVENTORY"
Add(InventoryText)
use_mipfilter(InventoryText) 

training_label							= CreateElement "ceStringPoly"
training_label.name						= "TRAINING_LABEL"
training_label.material					= font_MFCD_BLUE
training_label.alignment				= "CenterBottom"
training_label.init_pos					= {max_pixels_count/2,InventoryText.init_pos[2]-50,0}
SetLowerLeftCornerOrigin(training_label)
training_label.stringdefs				= predefined_fonts[1]
training_label.UseBackground			= false
training_label.BackgroundMaterial		= MFCD_SOLID_BLACK
training_label.value					= "TRAINING"
training_label.controllers				= {{"DSMS_training_label"}}
Add(training_label)
use_mipfilter(training_label) 

training_frame					=  line_2_pixel({{-45,23},{45,23},{45,2},{-45,2},{-45,23}}, MFCD_BLUE)
training_frame.parent_element	=  training_label.name

labels = {}

AddStatLabel()

add_dummy_boxes({2, 4, 5})
local dx = 5

black_boxes = {}
box_position = {}
for i = 7, 11 do
	black_boxes[i]				=  line_2_pixel({{(-25-110),27.5},{-25,27.5},{-25,-27.5},{(-25-110),-27.5},{(-25-110),27.5}}, MFCD_GREEN)
	box_position  = OSB_positions[i-1]
	box_position[1] = box_position[1] - dx
	black_boxes[i].init_pos	= box_position
	black_boxes[i].controllers	= {{"DSMS_store_background_visible_active", StoreIndexes[i]}, {"DSMS_store_color", StoreIndexes[i]}}
	SetLowerLeftCornerOrigin(black_boxes[i])
end

for i = 1, 5 do
	black_boxes[i]				=  line_2_pixel({{(25+110),27.5},{25,27.5},{25,-27.5},{(25+110),-27.5},{(25+110),27.5}}, MFCD_GREEN)
	box_position  = OSB_positions[i+15]
	box_position[1] = box_position[1] + dx
	black_boxes[i].init_pos	 = box_position
	black_boxes[i].controllers	= {{"DSMS_store_background_visible_active", StoreIndexes[i]}, {"DSMS_store_color", StoreIndexes[i]}}
	SetLowerLeftCornerOrigin(black_boxes[i])
end

black_boxes[6]				=  line_2_pixel({{(0+55),-54+27.5},{0-55,-54+27.5},{0-55,-54-27.5},{(0+55),-54-27.5},{(0+55),-54+27.5}}, MFCD_GREEN)
black_boxes[6].init_pos	    = OSB_positions[3]
black_boxes[6].controllers	= {{"DSMS_store_background_visible_active", StoreIndexes[6]}, {"DSMS_store_color", StoreIndexes[6]}}
SetLowerLeftCornerOrigin(black_boxes[6])


add_osb_static_hint(2+1, _("Select inventory of station 6"))

add_osb_static_hint(5+1, _("Select inventory of station 7") )
add_osb_static_hint(6+1, _("Select inventory of station 8") )
add_osb_static_hint(7+1, _("Select inventory of station 9") )
add_osb_static_hint(8+1, _("Select inventory of station 10"))
add_osb_static_hint(9+1, _("Select inventory of station 11"))

add_osb_static_hint(15+1, _("Select inventory of station 1"))
add_osb_static_hint(16+1, _("Select inventory of station 2"))
add_osb_static_hint(17+1, _("Select inventory of station 3"))
add_osb_static_hint(18+1, _("Select inventory of station 4"))
add_osb_static_hint(19+1, _("Select inventory of station 5"))
