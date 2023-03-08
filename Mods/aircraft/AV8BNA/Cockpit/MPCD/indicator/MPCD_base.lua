dofile(LockOn_Options.script_path.."MPCD/indicator/MPCD_definitions.lua")

Render_Screen = GetRenderTarget() + 1
local mpcd_name = "MPCDL"
if Render_Screen == 2 then mpcd_name = "MPCDR" end

local vert_x	= GetHalfWidth() * MeterToIn * InToDI()
local vert_y	= GetHalfHeight() * MeterToIn * InToDI()

local log = require("log")
--log.info(string.format("MPCD BASE %s :: half_width %f; half_height %f; Scale %f; vert_x %f; vert_y %f", mpcd_name, GetHalfWidth(), GetHalfHeight(), GetScale(), vert_x, vert_y))

mpcd_base					= CreateElement "ceMeshPoly" -- untextured shape
mpcd_base.name				= mpcd_name
mpcd_base.material			= MakeMaterial(nil,{255,255,255,255})
mpcd_base.h_clip_relation	= h_clip_relations.REWRITE_LEVEL  -- check clipping : pixel on glass then increase level from GLASS_LEVEL to GLASS_LEVEL+1 = HUD_DEFAULT_LEVEL
mpcd_base.level				= MPCD_DEFAULT_LEVEL
mpcd_base.collimated		= false
mpcd_base.isvisible			= false
mpcd_base.z_emable			= true
mpcd_base.vertices			= { {-vert_x, vert_y}, { vert_x, vert_y}, { vert_x, -vert_y}, {-vert_x, -vert_y}, }
mpcd_base.indices			= { 0,1,2; 0,2,3 }
Add(mpcd_base)
