dofile(LockOn_Options.script_path.."ABRIS\\ABRIS_usefull_definitions.lua")

ABRIS_workspace_common				   = CreateElement "ceMeshPoly"
ABRIS_workspace_common.name			   = "ABRIS_workspace_common"
ABRIS_workspace_common.primitivetype   = "triangles"
ABRIS_workspace_common.vertices		   = {{-x_size,y_size},
										   {x_size,y_size},
										   {x_size,-y_size},
										  {-x_size,-y_size}}
ABRIS_workspace_common.indices		   = {0, 1, 2, 0, 2, 3}
ABRIS_workspace_common.material		   = "RED"
ABRIS_workspace_common.h_clip_relation = h_clip_relations.REWRITE_LEVEL
ABRIS_workspace_common.level		   = DEFAULT_LEVEL + 2
ABRIS_workspace_common.isvisible       = false
Add(ABRIS_workspace_common);

bios_base 		 	  = CreateElement "ceSimple"
bios_base.name 		  = "bios_base"
bios_base.init_pos    = {-0.98*x_size,0.9*y_size,0}
Add(bios_base)
local  delta = (abris_font[2][1] + abris_font[2][4] )/GetScale()
add_console(bios_base,25,"font_Ka-50_ABRIS_WHITE",abris_font[2],delta)