dofile(LockOn_Options.script_path.."Scripts/VideoExport/definitions.lua")

dofile(LockOn_Options.script_path.."Scripts/Common/levels.lua")
INDICATOR_LEVEL = VIDEO_EXPORT_DEFAULT_LEVEL
TV_LEVEL = VIDEO_EXPORT_DEFAULT_LEVEL
dofile(LockOn_Options.script_path.."Scripts/Common/common_defs.lua")

local aspect = LockOn_Options.screen.width / LockOn_Options.screen.height

base = CreateElement "ceMeshPoly"
base.name = "base"
base.primitivetype = "triangles"
base.init_pos		= {0, 0, 0}
base.init_rot		 = {0, 0, 0}
base.vertices = { {-aspect ,1 },
				{aspect ,1 },
				{ aspect ,-1 },
				{-aspect ,-1 }}
base.indices = {0,1,2,0,2,3}
base.material		= MakeMaterial( nil,{0,0,0,255} )
base.h_clip_relation = h_clip_relations.REWRITE_LEVEL
base.level			= TV_LEVEL
base.isdraw			= true
base.change_opacity	= false
base.isvisible		= true
base.screenspace = ScreenType.SCREENSPACE_TRUE
Add(base)
