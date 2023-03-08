dofile(LockOn_Options.script_path.."HUD/Indicator/HUD_definitions.lua")

function AddHUDStbTextElement(name, controllers, init_pos, parent, level, pos, value, size)
local txt			= CreateElement "ceStringPoly"
	txt.name		= name
	txt.material	= "font_HUD_STANDBY"
	txt.init_pos	= init_pos
	txt.alignment	= pos
	txt.value		= value
	
	if size ~= nil then
		if size == 2 then
			txt.stringdefs	= predefined_font_2
		else
			txt.stringdefs	= predefined_font_1
		end
	else
		txt.stringdefs	= predefined_font_0
	end
	
	txt.additive_alpha	= true
	txt.collimated		= true
	
	txt.isdraw			= false
	if controllers ~= nil then
		txt.controllers		= controllers
	end
	
	if parent ~= nil then
		txt.parent_element	= parent
		txt.isdraw		= true
	end
	
	txt.h_clip_relation	= h_clip_relations.COMPARE
	txt.level			= level
	txt.use_mipfilter	= use_mipfilter
		
	Add(txt)
	
	return txt
end

AddHUDStandbyTexElement("Depressible_Pipper_standby", 
				{{-26, -26}, {-26, 26}, 
				{32, 26}, {32, -26}},
				{3.88/texture_stb_size_X, 3.85/texture_stb_size_Y, tex_scale_stb_X, tex_scale_stb_Y},
				{{"Standby_Pipper_pos", ZSL}},
				{0.0, 0.0, 0.0},
				{0.0, 0.0, 0.0},
				nil,
				HUD_DEFAULT_LEVEL)

--- numbers
ScalePosY = ZSL+11
ScalePosX = 39
StandBy_txt_sizeX = 15
StandBy_txt_sizeY = 10

clipRangeStandByBox				= CreateElement "ceMeshPoly"
clipRangeStandByBox.name			= "clipRangeStandByBox"
clipRangeStandByBox.primitivetype = "triangles"
clipRangeStandByBox.vertices		= {{-StandBy_txt_sizeX, -StandBy_txt_sizeY},
						 {-StandBy_txt_sizeX, StandBy_txt_sizeY},
						 {StandBy_txt_sizeX, StandBy_txt_sizeY},
						 {StandBy_txt_sizeX, -StandBy_txt_sizeY}
						}
clipRangeStandByBox.indices			= default_box_indices
clipRangeStandByBox.init_pos		=  {47.0, 0.0, 0.0}
clipRangeStandByBox.material		= "DBG_RED" --"GREEN"
clipRangeStandByBox.h_clip_relation = h_clip_relations.INCREASE_IF_LEVEL
clipRangeStandByBox.level			= HUD_DEFAULT_LEVEL
clipRangeStandByBox.controllers		= {{"Standby_Pipper_pos", ZSL}}
clipRangeStandByBox.isvisible		= false
clipRangeStandByBox.collimated		= true
Add(clipRangeStandByBox)

for v = 0,300,10 do

STANDBY_scale = AddHUDStandbyTexElement("Standby_scale"..v, 
				{{0, -10},{0, 0}, 
				{5.5,0}, {5.5, -10}},
				{8.30/texture_stb_size_X, 0.52/texture_stb_size_Y, tex_scale_stb_X, tex_scale_stb_Y},
				nil,
				{33.0, ScalePosY, 0.0},
				{0.0, 0.0, 0.0},
				nil,
				HUD_DEFAULT_LEVEL +1,
				"LeftTop")
STANDBY_scale.isdraw=true

ScalePosY = ScalePosY - 10
Scale0 = AddHUDStbTextElement("Scale"..v, 
				  nil,
				  {ScalePosX, ScalePosY-1, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL +1,
				  "LeftCenter", 
				  v,
				  3)
Scale0.isdraw = true

end

STANDBY_scale = AddHUDStandbyTexElement("Standby_scale", 
				{{0, -10},{0, 0}, 
				{5.5,0}, {5.5, -10}},
				{8.30/texture_stb_size_X, 0.52/texture_stb_size_Y, tex_scale_stb_X, tex_scale_stb_Y},
				nil,
				{33.0, ScalePosY, 0.0},
				{0.0, 0.0, 0.0},
				nil,
				HUD_DEFAULT_LEVEL + 1,
				"LeftTop")
STANDBY_scale.isdraw=true

clipRangeStandByBox_d				= CreateElement "ceMeshPoly"
clipRangeStandByBox_d.name			= "clipRangeStandByBox_d"
clipRangeStandByBox_d.primitivetype = "triangles"
clipRangeStandByBox_d.vertices		= {{-StandBy_txt_sizeX, -StandBy_txt_sizeY},
						 {-StandBy_txt_sizeX, StandBy_txt_sizeY},
						 {StandBy_txt_sizeX, StandBy_txt_sizeY},
						 {StandBy_txt_sizeX, -StandBy_txt_sizeY}
						}
clipRangeStandByBox_d.indices			= default_box_indices
clipRangeStandByBox_d.init_pos			=  {47.0, 0.0, 0.0}
clipRangeStandByBox_d.material			= "DBG_RED" --"GREEN"
clipRangeStandByBox_d.h_clip_relation 	= h_clip_relations.DECREASE_IF_LEVEL
clipRangeStandByBox_d.level			  	= HUD_DEFAULT_LEVEL+1
clipRangeStandByBox_d.controllers		= {{"Standby_Pipper_pos", ZSL}}
clipRangeStandByBox_d.isvisible			= false
clipRangeStandByBox_d.collimated		= true
Add(clipRangeStandByBox_d)



