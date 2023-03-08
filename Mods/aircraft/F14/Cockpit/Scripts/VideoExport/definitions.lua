dofile(LockOn_Options.common_script_path.."elements_defs.lua")

SetScale(FOV)

half_width   = GetScale() -- size in meters
half_height  = GetAspect() * half_width
aspect       = GetAspect()

DBG_GREEN = MakeMaterial(nil,{0,255,0,255})
DBG_RED = MakeMaterial(nil,{255,0,0,255})
DBG_TRANSPARENT = MakeMaterial(nil,{0,255,255,128})


