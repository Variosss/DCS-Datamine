dofile(LockOn_Options.script_path.."Scripts/RWR/Indicator/Pilot/definitions.lua")

local step = 0.16 * size;
local boatsize = 0.95;

local screen_origin = create_origin()
screen_origin.init_pos = {cx, cy}

local grid_origin = create_origin()
grid_origin.parent_element = screen_origin.name
grid_origin.controllers = {{"RWR_display_pilot"}}

local symbol_size = 0.200 * size

local elem12 = my_create_textured_box_1k(470,872,226,148,nil,910,symbol_size*boatsize)
	elem12.name = create_guid_string()
	elem12.parent_element = grid_origin.name
	elem12.init_pos = {-step*0.5,step}
	elem12.controllers = {{"RWR_brightness_pilot"}}
	elem12.material = "RWR_MAT"
AddRwrElement(elem12)

local elem13_1 = my_create_textured_box_1k(754,777,251,123,nil,900,symbol_size)
	elem13_1.name = create_guid_string()
	elem13_1.parent_element = grid_origin.name
	elem13_1.init_pos = {step*0.5,step}
	elem13_1.controllers = {{"RWR_brightness_pilot"}}
	elem13_1.material = "RWR_MAT"
AddRwrElement(elem13_1)

local elem13_2 = my_create_textured_box_1k(754,777,251,123,nil,900,symbol_size)
	elem13_2.name = create_guid_string()
	elem13_2.parent_element = grid_origin.name
	elem13_2.init_pos = {step*0.5,step}
	elem13_2.init_rot = {180,0,0}
	elem13_2.controllers = {{"RWR_brightness_pilot"}}
	elem13_2.material = "RWR_MAT"
AddRwrElement(elem13_2)

local elem14_1 = my_create_textured_box_1k(754,777,251,123,nil,900,symbol_size)
	elem14_1.name = create_guid_string()
	elem14_1.parent_element = grid_origin.name
	elem14_1.init_pos = {step*1.5,step}
	elem14_1.controllers = {{"RWR_brightness_pilot"}}
	elem14_1.material = "RWR_MAT"
AddRwrElement(elem14_1)

local elem14_2 = my_create_textured_box_1k(754,777,251,123,nil,900,symbol_size)
	elem14_2.name = create_guid_string()
	elem14_2.parent_element = grid_origin.name
	elem14_2.init_pos = {step*1.5,step}
	elem14_2.init_rot = {180,0,0}
	elem14_2.controllers = {{"RWR_brightness_pilot"}}
	elem14_2.material = "RWR_MAT"
AddRwrElement(elem14_2)

local elem14_3 = my_create_textured_box_1k(470,872,228,148,nil,910,symbol_size*boatsize)
	elem14_3.name = create_guid_string()
	elem14_3.parent_element = grid_origin.name
	elem14_3.init_pos = {step*1.5,step}
	elem14_3.controllers = {{"RWR_brightness_pilot"}}
	elem14_3.material = "RWR_MAT"
AddRwrElement(elem14_3)




local elem21_1 = my_create_textured_box_1k(754,900,251,123,nil,900,symbol_size)
	elem21_1.name = create_guid_string()
	elem21_1.parent_element = grid_origin.name
	elem21_1.init_pos = {-step*1.5,0}
	elem21_1.controllers = {{"RWR_brightness_pilot"}}
	elem21_1.material = "RWR_MAT"
AddRwrElement(elem21_1)

local elem21_2 = my_create_textured_box_1k(754,900,251,123,nil,900,symbol_size)
	elem21_2.name = create_guid_string()
	elem21_2.parent_element = grid_origin.name
	elem21_2.init_pos = {-step*1.5,0}
	elem21_2.init_rot = {180,0,0}
	elem21_2.controllers = {{"RWR_brightness_pilot"}}
	elem21_2.material = "RWR_MAT"
AddRwrElement(elem21_2)


local elem22_1 = my_create_textured_box_1k(754,900,251,123,nil,900,symbol_size)
	elem22_1.name = create_guid_string()
	elem22_1.parent_element = grid_origin.name
	elem22_1.init_pos = {-step*0.5,0}
	elem22_1.controllers = {{"RWR_brightness_pilot"}}
	elem22_1.material = "RWR_MAT"
AddRwrElement(elem22_1)

local elem22_2 = my_create_textured_box_1k(754,900,251,123,nil,900,symbol_size)
	elem22_2.name = create_guid_string()
	elem22_2.parent_element = grid_origin.name
	elem22_2.init_pos = {-step*0.5,0}
	elem22_2.init_rot = {180,0,0}
	elem22_2.controllers = {{"RWR_brightness_pilot"}}
	elem22_2.material = "RWR_MAT"
AddRwrElement(elem22_2)

local elem22_3 = my_create_textured_box_1k(470,872,228,148,nil,910,symbol_size*boatsize)
	elem22_3.name = create_guid_string()
	elem22_3.parent_element = grid_origin.name
	elem22_3.init_pos = {-step*0.5,0}
	elem22_3.controllers = {{"RWR_brightness_pilot"}}
	elem22_3.material = "RWR_MAT"
AddRwrElement(elem22_3)


local elem23_1 = my_create_textured_box_1k(754,900,251,123,nil,900,symbol_size)
	elem23_1.name = create_guid_string()
	elem23_1.parent_element = grid_origin.name
	elem23_1.init_pos = {step*0.5,0}
	elem23_1.controllers = {{"RWR_brightness_pilot"}}
	elem23_1.material = "RWR_MAT"
AddRwrElement(elem23_1)

local elem23_2 = my_create_textured_box_1k(754,900,251,123,nil,900,symbol_size)
	elem23_2.name = create_guid_string()
	elem23_2.parent_element = grid_origin.name
	elem23_2.init_pos = {step*0.5,0}
	elem23_2.init_rot = {180,0,0}
	elem23_2.controllers = {{"RWR_brightness_pilot"}}
	elem23_2.material = "RWR_MAT"
AddRwrElement(elem23_2)

local elem23_3 = my_create_textured_box_1k(754,777,251,123,nil,900,symbol_size)
	elem23_3.name = create_guid_string()
	elem23_3.parent_element = grid_origin.name
	elem23_3.init_pos = {step*0.5,0}
	elem23_3.controllers = {{"RWR_brightness_pilot"}}
	elem23_3.material = "RWR_MAT"
AddRwrElement(elem23_3)

local elem23_4 = my_create_textured_box_1k(754,777,251,123,nil,900,symbol_size)
	elem23_4.name = create_guid_string()
	elem23_4.parent_element = grid_origin.name
	elem23_4.init_pos = {step*0.5,0}
	elem23_4.init_rot = {180,0,0}
	elem23_4.controllers = {{"RWR_brightness_pilot"}}
	elem23_4.material = "RWR_MAT"
AddRwrElement(elem23_4)


local elem24_1 = my_create_textured_box_1k(754,900,251,123,nil,900,symbol_size)
	elem24_1.name = create_guid_string()
	elem24_1.parent_element = grid_origin.name
	elem24_1.init_pos = {step*1.5,0}
	elem24_1.controllers = {{"RWR_brightness_pilot"}}
	elem24_1.material = "RWR_MAT"
AddRwrElement(elem24_1)

local elem24_2 = my_create_textured_box_1k(754,900,251,123,nil,900,symbol_size)
	elem24_2.name = create_guid_string()
	elem24_2.parent_element = grid_origin.name
	elem24_2.init_pos = {step*1.5,0}
	elem24_2.init_rot = {180,0,0}
	elem24_2.controllers = {{"RWR_brightness_pilot"}}
	elem24_2.material = "RWR_MAT"
AddRwrElement(elem24_2)

local elem24_3 = my_create_textured_box_1k(754,777,251,123,nil,900,symbol_size)
	elem24_3.name = create_guid_string()
	elem24_3.parent_element = grid_origin.name
	elem24_3.init_pos = {step*1.5,0}
	elem24_3.controllers = {{"RWR_brightness_pilot"}}
	elem24_3.material = "RWR_MAT"
AddRwrElement(elem24_3)

local elem24_4 = my_create_textured_box_1k(754,777,251,123,nil,900,symbol_size)
	elem24_4.name = create_guid_string()
	elem24_4.parent_element = grid_origin.name
	elem24_4.init_pos = {step*1.5,0}
	elem24_4.init_rot = {180,0,0}
	elem24_4.controllers = {{"RWR_brightness_pilot"}}
	elem24_4.material = "RWR_MAT"
AddRwrElement(elem24_4)

local elem24_5 = my_create_textured_box_1k(470,872,228,148,nil,910,symbol_size*boatsize)
	elem24_5.name = create_guid_string()
	elem24_5.parent_element = grid_origin.name
	elem24_5.init_pos = {step*1.5,0}
	elem24_5.controllers = {{"RWR_brightness_pilot"}}
	elem24_5.material = "RWR_MAT"
AddRwrElement(elem24_5)



local elem31_1 = my_create_textured_box_1k(754,777,251,123,nil,900,symbol_size)
	elem31_1.name = create_guid_string()
	elem31_1.parent_element = grid_origin.name
	elem31_1.init_pos = {-step*1.5,-step}
	elem31_1.controllers = {{"RWR_brightness_pilot"}}
	elem31_1.material = "RWR_MAT"
AddRwrElement(elem31_1)

local elem31_2 = my_create_textured_box_1k(754,777,251,123,nil,900,symbol_size)
	elem31_2.name = create_guid_string()
	elem31_2.parent_element = grid_origin.name
	elem31_2.init_pos = {-step*1.5,-step}
	elem31_2.init_rot = {180,0,0}
	elem31_2.controllers = {{"RWR_brightness_pilot"}}
	elem31_2.material = "RWR_MAT"
AddRwrElement(elem31_2)

local elem31_x1 = my_create_textured_box_1k(436,732,295,144,nil,876,symbol_size)
	elem31_x1.name = create_guid_string()
	elem31_x1.parent_element = grid_origin.name
	elem31_x1.init_pos = {-step*1.5,-step}
	elem31_x1.controllers = {{"RWR_brightness_pilot"}}
	elem31_x1.material = "RWR_MAT"
AddRwrElement(elem31_x1)

local elem31_x2 = my_create_textured_box_1k(436,732,295,144,nil,876,symbol_size)
	elem31_x2.name = create_guid_string()
	elem31_x2.parent_element = grid_origin.name
	elem31_x2.init_pos = {-step*1.5,-step}
	elem31_x2.init_rot = {180,0,0}
	elem31_x2.controllers = {{"RWR_brightness_pilot"}}
	elem31_x2.material = "RWR_MAT"
AddRwrElement(elem31_x2)


local elem32_1 = my_create_textured_box_1k(754,777,251,123,nil,900,symbol_size)
	elem32_1.name = create_guid_string()
	elem32_1.parent_element = grid_origin.name
	elem32_1.init_pos = {-step*0.5,-step}
	elem32_1.controllers = {{"RWR_brightness_pilot"}}
	elem32_1.material = "RWR_MAT"
AddRwrElement(elem32_1)

local elem32_2 = my_create_textured_box_1k(754,777,251,123,nil,900,symbol_size)
	elem32_2.name = create_guid_string()
	elem32_2.parent_element = grid_origin.name
	elem32_2.init_pos = {-step*0.5,-step}
	elem32_2.init_rot = {180,0,0}
	elem32_2.controllers = {{"RWR_brightness_pilot"}}
	elem32_2.material = "RWR_MAT"
AddRwrElement(elem32_2)

local elem32_3 = my_create_textured_box_1k(470,872,228,148,nil,910,symbol_size*boatsize)
	elem32_3.name = create_guid_string()
	elem32_3.parent_element = grid_origin.name
	elem32_3.init_pos = {-step*0.5,-step}
	elem32_3.controllers = {{"RWR_brightness_pilot"}}
	elem32_3.material = "RWR_MAT"
AddRwrElement(elem32_3)

local elem32_x1 = my_create_textured_box_1k(436,732,295,144,nil,876,symbol_size)
	elem32_x1.name = create_guid_string()
	elem32_x1.parent_element = grid_origin.name
	elem32_x1.init_pos = {-step*0.5,-step}
	elem32_x1.controllers = {{"RWR_brightness_pilot"}}
	elem32_x1.material = "RWR_MAT"
AddRwrElement(elem32_x1)

local elem32_x2 = my_create_textured_box_1k(436,732,295,144,nil,876,symbol_size)
	elem32_x2.name = create_guid_string()
	elem32_x2.parent_element = grid_origin.name
	elem32_x2.init_pos = {-step*0.5,-step}
	elem32_x2.init_rot = {180,0,0}
	elem32_x2.controllers = {{"RWR_brightness_pilot"}}
	elem32_x2.material = "RWR_MAT"
AddRwrElement(elem32_x2)



local elem33_1 = my_create_textured_box_1k(754,900,251,123,nil,900,symbol_size)
	elem33_1.name = create_guid_string()
	elem33_1.parent_element = grid_origin.name
	elem33_1.init_pos = {step*0.5,-step}
	elem33_1.controllers = {{"RWR_brightness_pilot"}}
	elem33_1.material = "RWR_MAT"
AddRwrElement(elem33_1)

local elem33_2 = my_create_textured_box_1k(754,900,251,123,nil,900,symbol_size)
	elem33_2.name = create_guid_string()
	elem33_2.parent_element = grid_origin.name
	elem33_2.init_pos = {step*0.5,-step}
	elem33_2.init_rot = {180,0,0}
	elem33_2.controllers = {{"RWR_brightness_pilot"}}
	elem33_2.material = "RWR_MAT"
AddRwrElement(elem33_2)

local elem33_3 = my_create_textured_box_1k(754,777,251,123,nil,900,symbol_size)
	elem33_3.name = create_guid_string()
	elem33_3.parent_element = grid_origin.name
	elem33_3.init_pos = {step*0.5,-step}
	elem33_3.controllers = {{"RWR_brightness_pilot"}}
	elem33_3.material = "RWR_MAT"
AddRwrElement(elem33_3)

local elem33_4 = my_create_textured_box_1k(754,777,251,123,nil,900,symbol_size)
	elem33_4.name = create_guid_string()
	elem33_4.parent_element = grid_origin.name
	elem33_4.init_pos = {step*0.5,-step}
	elem33_4.init_rot = {180,0,0}
	elem33_4.controllers = {{"RWR_brightness_pilot"}}
	elem33_4.material = "RWR_MAT"
AddRwrElement(elem33_4)

local elem33_x1 = my_create_textured_box_1k(436,732,295,144,nil,876,symbol_size)
	elem33_x1.name = create_guid_string()
	elem33_x1.parent_element = grid_origin.name
	elem33_x1.init_pos = {step*0.5,-step}
	elem33_x1.controllers = {{"RWR_brightness_pilot"}}
	elem33_x1.material = "RWR_MAT"
AddRwrElement(elem33_x1)

local elem33_x2 = my_create_textured_box_1k(436,732,295,144,nil,876,symbol_size)
	elem33_x2.name = create_guid_string()
	elem33_x2.parent_element = grid_origin.name
	elem33_x2.init_pos = {step*0.5,-step}
	elem33_x2.init_rot = {180,0,0}
	elem33_x2.controllers = {{"RWR_brightness_pilot"}}
	elem33_x2.material = "RWR_MAT"
AddRwrElement(elem33_x2)



local elem34_1 = my_create_textured_box_1k(754,900,251,123,nil,900,symbol_size)
	elem34_1.name = create_guid_string()
	elem34_1.parent_element = grid_origin.name
	elem34_1.init_pos = {step*1.5,-step}
	elem34_1.controllers = {{"RWR_brightness_pilot"}}
	elem34_1.material = "RWR_MAT"
AddRwrElement(elem34_1)

local elem34_2 = my_create_textured_box_1k(754,900,251,123,nil,900,symbol_size)
	elem34_2.name = create_guid_string()
	elem34_2.parent_element = grid_origin.name
	elem34_2.init_pos = {step*1.5,-step}
	elem34_2.init_rot = {180,0,0}
	elem34_2.controllers = {{"RWR_brightness_pilot"}}
	elem34_2.material = "RWR_MAT"
AddRwrElement(elem34_2)

local elem34_3 = my_create_textured_box_1k(754,777,251,123,nil,900,symbol_size)
	elem34_3.name = create_guid_string()
	elem34_3.parent_element = grid_origin.name
	elem34_3.init_pos = {step*1.5,-step}
	elem34_3.controllers = {{"RWR_brightness_pilot"}}
	elem34_3.material = "RWR_MAT"
AddRwrElement(elem34_3)

local elem34_4 = my_create_textured_box_1k(754,777,251,123,nil,900,symbol_size)
	elem34_4.name = create_guid_string()
	elem34_4.parent_element = grid_origin.name
	elem34_4.init_pos = {step*1.5,-step}
	elem34_4.init_rot = {180,0,0}
	elem34_4.controllers = {{"RWR_brightness_pilot"}}
	elem34_4.material = "RWR_MAT"
AddRwrElement(elem34_4)

local elem34_5 = my_create_textured_box_1k(470,872,228,148,nil,910,symbol_size*boatsize)
	elem34_5.name = create_guid_string()
	elem34_5.parent_element = grid_origin.name
	elem34_5.init_pos = {step*1.5,-step}
	elem34_5.controllers = {{"RWR_brightness_pilot"}}
	elem34_5.material = "RWR_MAT"
AddRwrElement(elem34_5)

local elem34_x1 = my_create_textured_box_1k(436,732,295,144,nil,876,symbol_size)
	elem34_x1.name = create_guid_string()
	elem34_x1.parent_element = grid_origin.name
	elem34_x1.init_pos = {step*1.5,-step}
	elem34_x1.controllers = {{"RWR_brightness_pilot"}}
	elem34_x1.material = "RWR_MAT"
AddRwrElement(elem34_x1)

local elem34_x2 = my_create_textured_box_1k(436,732,295,144,nil,876,symbol_size)
	elem34_x2.name = create_guid_string()
	elem34_x2.parent_element = grid_origin.name
	elem34_x2.init_pos = {step*1.5,-step}
	elem34_x2.init_rot = {180,0,0}
	elem34_x2.controllers = {{"RWR_brightness_pilot"}}
	elem34_x2.material = "RWR_MAT"
AddRwrElement(elem34_x2)
