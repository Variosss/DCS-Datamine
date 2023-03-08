dofile(LockOn_Options.common_script_path.."elements_defs.lua")
dofile(LockOn_Options.script_path.."MapDisplay/MapDisplay_devconfig.lua")
SetScale(1)
ARCADE = MakeMaterial("arcade.tga",{0,0,0,255})

width  = 2.2
height = 1.68
finetune_scale = 0.58 --yeah
--finetune_aspect = 1.53 --in MapDisplay_devconfig.lua
width = width * finetune_scale * finetune_aspect
height = height * finetune_scale

finetune_h_offset = 0.2


function default_vertices(width, height)
	height = height or width / finetune_aspect
	return {
		{-width / 2, height / 2 + finetune_h_offset},
		{ width / 2, height / 2 + finetune_h_offset},
		{ width / 2, -height / 2 + finetune_h_offset},
		{-width / 2, -height / 2 + finetune_h_offset},
	}
end

default_indices = {0,1,2;0,2,3}
default_tex_coords = {
							{0, 0},
							{1, 0},
							{1, 1},
							{0, 1},
						}
