dofile(LockOn_Options.common_script_path..'AN_ALR_HarmIDs.lua')

device_timer_dt		= 0.05

dofile(LockOn_Options.script_path.."Displays/HUD/device/HUD_config.lua")
dofile(LockOn_Options.script_path.."Displays/Common/indicator/Units.lua")

hdg_base_pos	= HDG_origin_pos		-- mr
hdg_fixed_bias	=  135					-- mr
ind_fixed_bias	=  25					-- mr
hdg_upper_lim	=  50					-- mr
ind_upper_lim	=  DegToMil(6.6)		-- mr
cmn_lower_lim	=  DegToMil(13)			-- mr

need_to_be_closed	= true