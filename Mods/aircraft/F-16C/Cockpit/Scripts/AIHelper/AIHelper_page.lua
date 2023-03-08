dofile(LockOn_Options.common_script_path.."elements_defs.lua")
local x,y,w,h = get_UIMainView();

SetCustomScale(2 * GetHalfWidth()/w) --1 unit will be pixel

aspect = w/h

local AIHelperTexturesPath = LockOn_Options.script_path.."../IndicationTextures/AIHelper/"

local fnt_size = 24;


FontSizeY1	= fnt_size * GetScale()
FontSizeX1	= 0.85 * FontSizeY1

predefined_font_1 = {FontSizeY1, FontSizeX1, 0.0, 0.0}


function AddElement(object)
    object.use_mipfilter = true
    Add(object)
end

local AIHelperBase				= CreateElement "ceSimple"
AIHelperBase.name				= "AIHelperBase"
AIHelperBase.init_pos			= {-w/2,-aspect * h/2}
AIHelperBase.controllers		= {{"show"},{"scale",1,aspect}}
AddElement(AIHelperBase) -- lower left corner of screen
-- now all children of AIHelperBase will be started from lower left corner of screen and sizes be in pixels



-- to upper left corner 
local box_sz    = 256
local quad 		= {{0 		,  0},
				   {box_sz	,  0},
				   {box_sz	,-box_sz},
				   {0  		,-box_sz}}
local quad_tex = {{0,0},
				  {1,0},
				  {1,1},
				  {0,1}}

 
local function add_AIHelper_prompt(priority, prompt_info, howto_info, tex_name)

	local prompt_mat	= MakeMaterial(nil, {255, 255, 255, 0})
	if (tex_name ~=	"") then
		prompt_mat	= MakeMaterial(AIHelperTexturesPath..tex_name, {255, 255, 255, 200})
	end
	local prompt_ind			= CreateElement "ceTexPoly"
	prompt_ind.name				= "prompt_ind_" .. string.format("%i", priority)
	prompt_ind.vertices			= quad
	prompt_ind.indices			= default_box_indices
	prompt_ind.material			= prompt_mat
	prompt_ind.tex_coords		= quad_tex
	prompt_ind.init_pos 		= {5,h - 5 - fnt_size}
	prompt_ind.controllers		= {{"Indication", priority}}
	prompt_ind.parent_element	= AIHelperBase.name
	AddElement(prompt_ind)

	txt_PromptInformation				= CreateElement "ceStringPoly"
	txt_PromptInformation.name			= "txt_PromptInformation" .. string.format("%i", priority)
	txt_PromptInformation.material		= "font_general_aihelper_message"
	txt_PromptInformation.value			= prompt_info
	txt_PromptInformation.alignment		= "LeftBottom"
	txt_PromptInformation.parent_element	= prompt_ind.name
	txt_PromptInformation.stringdefs	= predefined_font_1
	txt_PromptInformation.controllers	= {{"Information", priority}}
	AddElement(txt_PromptInformation)

	txt_HowToInformation				= CreateElement "ceStringPoly"
	txt_HowToInformation.name			= "txt_HowToInformation" .. string.format("%i", priority)
	txt_HowToInformation.material		= "font_general_aihelper_howto"
	txt_HowToInformation.init_pos		={0,-box_sz}
	txt_HowToInformation.value			= howto_info
	txt_HowToInformation.alignment		= "LeftTop"
	txt_HowToInformation.parent_element	= prompt_ind.name
	txt_HowToInformation.stringdefs		= predefined_font_1
	txt_HowToInformation.controllers	= {{"Information", priority}}
	AddElement(txt_HowToInformation)

end

priority_start = -1;
local function priority_count()
	priority_start = priority_start + 1
	return priority_start
end

-- Prompts priority : ATTENTION!!! list should correspond to enum in avAIHelper

DisconnectGroundAir		= priority_count()
DisconnectGroundPower	= priority_count()
RemoveWheelChocks		= priority_count()
TurnOxygenLeverOn		= priority_count()

add_AIHelper_prompt(DisconnectGroundAir,	"DISCONNECT GROUND AIR",					"RADIO MENU>F8>F5>F2",	"")
add_AIHelper_prompt(DisconnectGroundPower,	"DISCONNECT GROUND POWER",					"RADIO MENU>F8>F2>F2",	"")
add_AIHelper_prompt(RemoveWheelChocks,		"REMOVE WHEEL CHOCKS",						"RADIO MENU>F8>F4>F2",	"")
add_AIHelper_prompt(TurnOxygenLeverOn,		"TURN OXYGEN REGULATOR SUPPLY LEVER ON",	"RC + [P]",						"")
