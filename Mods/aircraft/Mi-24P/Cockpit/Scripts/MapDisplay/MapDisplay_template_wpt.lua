dofile(LockOn_Options.script_path.."MapDisplay/MapDisplay_defs.lua")

local line_thickness = 0.02
local line_tex_params = {{135/512, 176.5/512}, {175/512, 176.5/512}, {0.2, 1}}

local waypoint_size = 0.01 * height
local waypoint = CreateElement "ceSimpleLineObject"
waypoint.name = "waypoint"
waypoint.material = ARCADE
waypoint.tex_params = line_tex_params
waypoint.width = line_thickness
local circle = {}
for i = 1,33 do
	local newpt = {waypoint_size * math.sin(2 * math.pi * (i-1) / 32), waypoint_size * math.cos(2 * math.pi * (i-1) / 32)}
	circle[i] = newpt
end
waypoint.vertices = circle
waypoint.init_pos = {0, 0}
waypoint.controllers =
{
	{'waypoint_pos', width / 2 * GetScale(), height / 2 * GetScale(), finetune_h_offset/10},
}
waypoint.level = 1
waypoint.h_clip_relation = h_clip_relations.COMPARE
Add(waypoint)

local line = CreateElement "ceSimpleLineObject"
line.name = "line"
line.parent_element = waypoint.name
line.material = ARCADE
line.vertices = {{0,waypoint_size}, {0,0.1}}
line.width = line_thickness
line.tex_params = line_tex_params
line.controllers = 
{
	{'line_length', width / finetune_aspect / 2 * GetScale(), height * finetune_aspect / 2 * GetScale()}
}
line.use_mipfilter = true
line.level = 1
line.h_clip_relation = h_clip_relations.COMPARE
Add(line)

local caption_scale = 0.1

local caption_line = CreateElement "ceSimpleLineObject"
caption_line.name = "caption_line"
caption_line.parent_element = waypoint.name
caption_line.material = ARCADE
caption_line.init_pos = {caption_scale / 5, 0}
caption_line.vertices = {{0, 0},{caption_scale, 0}}
caption_line.width = line_thickness
caption_line.tex_params = line_tex_params
caption_line.controllers = 
{
	{'caption_line', width / 2 * GetScale(), height / 2 * GetScale()}
}
caption_line.use_mipfilter = true
caption_line.level = 1
caption_line.h_clip_relation = h_clip_relations.COMPARE
Add(caption_line)

local text_dist = CreateElement "ceStringPoly"
text_dist.name = "text_dist"
text_dist.parent_element = caption_line.name
text_dist.material = "font_mapdisplay"
text_dist.init_pos = {caption_scale / 2, caption_scale / 10}
text_dist.stringdefs = {caption_scale * 0.05, caption_scale * 0.05, 0, 0}
text_dist.alignment = "CenterBottom"
text_dist.controllers = 
{
	{'text_dist'}
}
text_dist.level = 1
text_dist.h_clip_relation = h_clip_relations.COMPARE
Add(text_dist)

local text_time = CreateElement "ceStringPoly"
text_time.name = "text_time"
text_time.parent_element = caption_line.name
text_time.material = "font_mapdisplay"
text_time.init_pos = {caption_scale / 2, -caption_scale / 10}
text_time.stringdefs = {caption_scale * 0.05, caption_scale * 0.05, 0, 0}
text_time.alignment = "CenterTop"
text_time.controllers = 
{
	{'text_time'}
}
text_time.level = 1
text_time.h_clip_relation = h_clip_relations.COMPARE
Add(text_time)

local text_az = CreateElement "ceStringPoly"
text_az.name = "text_az"
text_az.parent_element = caption_line.name
text_az.material = "font_mapdisplay"
text_az.init_pos = {caption_scale * 1.1, 0}
text_az.stringdefs = {caption_scale * 0.08, caption_scale * 0.08, 0, 0}
text_az.alignment = "LeftCenter"
text_az.controllers = 
{
	{'text_az'}
}
text_az.level = 1
text_az.h_clip_relation = h_clip_relations.COMPARE
Add(text_az)