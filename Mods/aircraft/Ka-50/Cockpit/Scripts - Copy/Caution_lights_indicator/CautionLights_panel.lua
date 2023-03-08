dofile(LockOn_Options.common_script_path.."devices_defs.lua")
purposes 	 = {render_purpose.HUD_ONLY_VIEW}
indicator_type       = indicator_types.COMMON


dedicated_viewport      	  = {5,5,LockOn_Options.screen.width - 10,LockOn_Options.screen.width - 10} --square
local multimonitor_setup_name =  "Config/MonitorSetup/"..get_multimonitor_preset_name()..".lua"
local f = loadfile(multimonitor_setup_name)
if	  f then
local env = {}
	  env.screen = LockOn_Options.screen
	  setfenv(f,env)
	  pcall(f)
	  if env.UIMainView ~= nil then
			dedicated_viewport 	= {env.UIMainView.x + 5,
								   env.UIMainView.y + 5,
								   env.UIMainView.width - 10,
								   env.UIMainView.width - 10}
	  end	  
end
page_subsets = {LockOn_Options.script_path.."Caution_lights_indicator/CautionLights_panel_page.lua"}
pages        = {{1}}
init_pageID  = 1




