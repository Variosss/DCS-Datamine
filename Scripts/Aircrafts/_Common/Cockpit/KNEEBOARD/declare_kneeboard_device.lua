local kneeboard_id = 100 
if    devices then
  	  kneeboard_id = devices.KNEEBOARD or 100
end
if not creators then 
   creators = {}
end
if not indicators then 
   indicators = {}
end

creators	[kneeboard_id] 		= {"avKneeboard",LockOn_Options.common_script_path.."KNEEBOARD/device/init.lua"}

local 			init_script = LockOn_Options.common_script_path.."KNEEBOARD/indicator/init.lua"
if is_left then init_script = LockOn_Options.common_script_path.."KNEEBOARD/indicator/init_left.lua" end

local kneeboard_render_target_id = 4

if disable_kneeboard_render_target then
   kneeboard_render_target_id = nil
end

indicators	[#indicators + 1]   = {kneeboard_implementation or "ccKneeboard",init_script,kneeboard_id,
	{{},{sx_l = -0.65,sz_l =  0.15,sy_l = -0.5,ry_l =  10, rz_l = 85 ,sw = 0.142 * 0.5 - 0.1,sh = 0.214 * 0.5 - 0.1},kneeboard_render_target_id}
}