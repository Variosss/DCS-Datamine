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
ABRIS_workspace_common.isdraw		   = true
ABRIS_workspace_common.isvisible	   = false
Add(ABRIS_workspace_common);

txt_time				 = CreateElement "ceStringPoly"
txt_time.name            = "txt_time"
txt_time.material        = "font_Ka-50_ABRIS_WHITE"  
txt_time.init_pos		 = {0.98*x_size,0.97*y_size, 0}
txt_time.alignment       = "RightCenter"
txt_time.stringdefs      = abris_font[2]
txt_time.formats         = {"%02.f:%02.f:%02.f"..LOCALIZE("М ")}
txt_time.controllers	 = {{"txt_time",0}}
Add(txt_time)
use_mipfilter(txt_time)

txt_SNS_mode			   	 = CreateElement "ceStringPoly"
txt_SNS_mode.name            = "txt_SNS_mode"
txt_SNS_mode.material        = "font_Ka-50_ABRIS_GREEN"
txt_SNS_mode.init_pos		 = {0,0.97*y_size,0}
txt_SNS_mode.alignment       = "LeftCenter"
txt_SNS_mode.stringdefs      = abris_font[2]
txt_SNS_mode.formats		 = {"3D",LOCALIZE("ИСКЛ 3D"), "PDOP 3D", "RAIM 3D", "2D", LOCALIZE("СЧСЛ"), LOCALIZE("НЕТ НАВ"), LOCALIZE("ПОРОГ")}
txt_SNS_mode.controllers     = {{"txt_SNS_mode",1,0,1,2,3,4,5,6,7}}
Add(txt_SNS_mode)
use_mipfilter(txt_SNS_mode)

txt_SNS_mode2			   	 = CreateElement "ceStringPoly"
txt_SNS_mode2.name            = "txt_SNS_mode2"
txt_SNS_mode2.material        = "font_Ka-50_ABRIS_YELLOW"
txt_SNS_mode2.init_pos		 = {0,0.97*y_size,0}
txt_SNS_mode2.alignment       = "LeftCenter"
txt_SNS_mode2.stringdefs      = abris_font[2]
txt_SNS_mode2.formats		 = {"3D",LOCALIZE("ИСКЛ 3D"), "PDOP 3D", "RAIM 3D", "2D", LOCALIZE("СЧСЛ"), LOCALIZE("НЕТ НАВ"), LOCALIZE("ПОРОГ")}
txt_SNS_mode2.controllers     = {{"txt_SNS_mode",0,0,1,2,3,4,5,6,7}}
Add(txt_SNS_mode2)
use_mipfilter(txt_SNS_mode2)
