dofile(LockOn_Options.common_script_path.."elements_defs.lua")

x_size  = 0.047
y_size  = 0.022 --0.024

tex_x_size = 0.98
start_x_2  = 9/512
end_x_2  = 431/512
scale_2    =  (end_x_2 - start_x_2) / (2 * x_size)
x_center_2 =   start_x_2  + (end_x_2 - start_x_2)/2

box_ind        = {0, 1, 2, 0, 2, 3}

function SetLine(object, x_start, y_start, x_end, y_end)
	local centers_line  = (385  + (388 - 385)/2)/512
	local size_line     = (388 - 385)/1024	
	local scaled_size_line = size_line / scale_2
	
	local dx = x_end - x_start
	local dy = y_end - y_start
	local length = math.sqrt(dx * dx + dy * dy)
	local x0 = x_start + dx / 2
	local y0 = y_start + dy / 2
	
	local direction = 0
	if dx ~=0 then
		direction = math.atan(dy / dx)
	else
		if dy > 0 then
			direction = 1.57
		else
			direction = -1.57
		end
	end

	local line_vertices = {	{-0.5 * length + x0,  scaled_size_line + y0},
							{ 0.5 * length + x0,  scaled_size_line + y0},
							{ 0.5 * length + x0, -scaled_size_line + y0},
							{-0.5 * length + x0, -scaled_size_line + y0}}
	object.indices		= box_ind
	object.vertices     = line_vertices
	object.material     = "LINES_ARK_TABLE"
	object.tex_params   = {x_center_2, centers_line, scale_2, scale_2}
	object.init_rot		= {direction * 57.325,0,0}
end

mip_filter_used = true

function use_mipfilter(object)
	if mip_filter_used then
		object.use_mipfilter = true
	end
end

ark_table_main_caption_font = {0.006, 0.67*0.006, 0.0003, 0}
ark_table_caption_font = {0.0035, 0.67*0.0035, 0.0003, 0}
ark_table_font = {0.0032, 0.67*0.0032, 0.00003, 0}