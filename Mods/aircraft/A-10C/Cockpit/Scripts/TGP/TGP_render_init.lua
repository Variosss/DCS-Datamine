dofile(LockOn_Options.common_script_path.."devices_defs.lua")
indicator_type 	 = indicator_types.COMMON
used_render_mask = "Litening_interleave.bmp"
-------PAGE IDs-------
id_Page = {}
id_pagesubset = {}
page_subsets = {}
pages = {}

local multimonitor_setup_name =  "Config/MonitorSetup/"..get_multimonitor_preset_name()..".lua"
local env = {}
	  env.screen = LockOn_Options.screen
local f = loadfile(multimonitor_setup_name)
if	  f 	then
	  setfenv(f,env)
	  pcall(f)
	  if env.LEFT_MFCD  ~= nil or 
	     env.RIGHT_MFCD ~= nil then
		 render_target_always = true
	  end 
end