dofile(LockOn_Options.common_script_path.."devices_defs.lua")
dofile(LockOn_Options.script_path.."config.lua")

-- the parameters for 'MPD_common_bake_init.lua'
bake_page_path = LockOn_Options.script_path.."Multipurpose_Display_Group/MDI_IP1556A/indicator/BAKE/MDI_right_bake_page.lua"

if bakeToCockpitTexture == true then
	-- GENERAL purpose is not necessary when render to a cockpit texture is used. Otherwise it will lead to an extra render pass.
	render_purposes_to_use = {render_purpose.HUD_ONLY_VIEW}
end

dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/BAKE/MPD_common_bake_init.lua")
dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/MDI_IP1556A/indicator/MDI_right_viewport_cfg.lua")
