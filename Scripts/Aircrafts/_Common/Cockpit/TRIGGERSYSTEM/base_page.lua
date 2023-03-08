dofile(LockOn_Options.common_script_path.."elements_defs.lua")
SetCustomScale(1.0)
highlights             = CreateElement "ceSimple"
highlights.controllers = {{"reset_buffer"},
  						  {"draw_highlights"},
						  {"apply_buffer"}}
if not LockOn_Options.screen.oculus_rift then
	highlights.screenspace   = ScreenType.SCREENSPACE_TRUE
end
highlights.use_mipfilter = true
Add(highlights)