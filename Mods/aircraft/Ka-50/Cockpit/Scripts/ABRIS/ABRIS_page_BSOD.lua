dofile(LockOn_Options.script_path.."ABRIS\\ABRIS_usefull_definitions.lua")

ABRIS_workspace_common				   = CreateElement "ceMeshPoly"
ABRIS_workspace_common.name			   = "ABRIS_workspace_common"
ABRIS_workspace_common.primitivetype   = "triangles"
ABRIS_workspace_common.vertices		   = {{-x_size,y_size},
										  {x_size,y_size},
										  {x_size,-y_size},
										  {-x_size,-y_size}}
ABRIS_workspace_common.indices		   = {0, 1, 2, 0, 2, 3}
ABRIS_workspace_common.material		   = "BLUE"
ABRIS_workspace_common.h_clip_relation = h_clip_relations.REWRITE_LEVEL
ABRIS_workspace_common.level		   = DEFAULT_LEVEL + 2
ABRIS_workspace_common.isdraw		   = true

Add(ABRIS_workspace_common);


txt_BSODHEADER				 = CreateElement "ceStringPoly"
txt_BSODHEADER.name          = "txt_BSOD_header"
txt_BSODHEADER.init_pos      = {0,0.5,0}
txt_BSODHEADER.material      = "font_Ka-50_ABRIS_WHITE_INVERSE"  
txt_BSODHEADER.alignment     = "CenterCenter"
txt_BSODHEADER.stringdefs    = abris_font[2]
txt_BSODHEADER.value 		 = "*EDOS*"
Add(txt_BSODHEADER)
use_mipfilter(txt_BSODHEADER)

txt_BSOD				 = CreateElement "ceStringPoly"
txt_BSOD.name            = "txt_BSOD"
txt_BSOD.init_pos      	 = {-0.7,0,0}
txt_BSOD.material        = "font_Ka-50_ABRIS_WHITE"  
txt_BSOD.alignment       = "LeftCenter"
txt_BSOD.stringdefs      = abris_font[2]
txt_BSOD.value 			 = "A fatal exception 0E has occured\nat 002B:C000069F0 in VxD VMM(01)\n+000059F0. The system must be\nterminated\n\n* Please restart your computer.\n  You will lose any unsaved\n  information in all\n  applications"

Add(txt_BSOD)
use_mipfilter(txt_BSOD)

