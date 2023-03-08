dofile(LockOn_Options.common_script_path.."elements_defs.lua")

SetScale(FOV)

half_width   = GetScale() -- size in meters
half_height  = GetAspect() * half_width
aspect       = GetAspect()

DBG_RED = MakeMaterial(nil,{255,0,0,255}) 

SCOPE_GREEN_TRANS = MakeMaterial(nil,{170,255,170,0})

BASE_COLOR = {20,20,20,220}


IndTexture_Path = LockOn_Options.script_path.."Resources/IndicationTextures/"

--DDD_OVERLAY = MakeMaterial(IndTexture_Path.."DDD_overlay.dds", BASE_COLOR)

