v_angle_shift = 0;
local f = loadfile(LockOn_Options.script_path.."config.lua") --trying read  v_angle_shift from config
if f then
   f()
end
need_to_be_closed = true -- close lua state after initialization 