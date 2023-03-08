dofile(LockOn_Options.common_script_path.."devices_defs.lua")
indicator_type       = indicator_types.COMMON
-------PAGE IDs-------
page_subsets 	= {LockOn_Options.common_script_path.."dbg_chart_page.lua"}
----------------------
pages 			= {{1}}
init_pageID     = 1
purposes 	 	 		   = {render_purpose.HUD_ONLY_VIEW,
							  render_purpose.SCREENSPACE_OUTSIDE_COCKPIT,
							  render_purpose.SCREENSPACE_INSIDE_COCKPIT}
local  default_height = 0.5 * LockOn_Options.screen.height - 10
local  default_width  =       LockOn_Options.screen.width - 20

dedicated_viewport 	      = {10,10,default_width,default_height}
dedicated_viewport_arcade = dedicated_viewport

is_real_timer  = false
is_model_timer = true
is_enabled	   = false

local lfs = require("lfs")

--scan user mods
local user_path = lfs.writedir()..'Config/dbg_chart.lua'
local f = loadfile(user_path)
if f then
   f()
end
--[[

mapped_params =
{
[1] = "COCKPIT_PARAM_1",
[2] = "COCKPIT_PARAM_2",
}

functional_params = {
[1] = {func = [lambda name], name = [legend], param = [parameter for lambda call], scale = [scale]},
[2] = {func = [lambda name], name = [legend], param = [parameter for lambda call], scale = [scale]}
}
--]]
