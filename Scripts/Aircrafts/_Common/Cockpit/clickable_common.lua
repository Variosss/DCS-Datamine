--Cursor Data 

Mouse_Speed					= 20

show_element_boxes			= false
show_element_parent_boxes	= false
show_tree_boxes				= false
show_other_pointers			= false
show_indicator_borders		= false


enable_commands_log         = false

class_type = 
{
	NULL   = 0,
	BTN    = 1,
	TUMB   = 2,
	SNGBTN = 3,
	LEV    = 4,
	MOVABLE_LEV = 5,
	MULTY_TUMB = 6,
	BTN_FIX = 7,
	TUMB_4SIDE = 8,
}

use_click_and_pan_mode = false


local count_side = 0
local function counter()
	count_side = count_side + 1
	return count_side
end
BOX_SIDE_X_top		= counter()
BOX_SIDE_X_bottom	= counter()
BOX_SIDE_Y_top		= counter()
BOX_SIDE_Y_bottom	= counter()
BOX_SIDE_Z_top		= counter()
BOX_SIDE_Z_bottom	= counter()
