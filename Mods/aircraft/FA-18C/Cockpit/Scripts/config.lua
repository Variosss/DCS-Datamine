bakeIndicators = true
bakeHUD = false

-- set true to bake L/R MDIs directly to a cockpit texture
bakeToCockpitTexture = false

args_initial_state = 
{
}

if get_option_value("difficulty.hideStick", "local") then 
	args_initial_state[575] = 1.0
end

-- TODO: probably to adjust
local MDI_greenness
if bakeToCockpitTexture == true then
	MDI_greenness = 1.0
else
	MDI_greenness = 0.0
end

args_initial_state[524] = MDI_greenness -- Left MDI
args_initial_state[525] = MDI_greenness -- Right MDI