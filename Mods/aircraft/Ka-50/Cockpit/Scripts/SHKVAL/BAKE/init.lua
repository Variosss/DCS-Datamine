dofile(LockOn_Options.common_script_path.."devices_defs.lua")
dofile(LockOn_Options.common_script_path.."ViewportHandling.lua")

purposes 	 = {render_purpose.GENERAL,render_purpose.HUD_ONLY_VIEW}
indicator_type 	 = indicator_types.COMMON

update_screenspace_diplacement(4/3,true)

try_find_assigned_viewport("Shkval","LEFT_MFCD")


if  render_target_always then 
	local 	panel = GetDevice(0)
	panel:shkval_bake_always()
end

page_subsets 	= {LockOn_Options.script_path.."SHKVAL/BAKE/page.lua"}
pages 			= {{1}}
init_pageID     = 1
