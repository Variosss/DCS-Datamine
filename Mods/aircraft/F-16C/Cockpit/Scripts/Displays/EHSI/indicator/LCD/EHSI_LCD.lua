dofile(LockOn_Options.common_script_path.."devices_defs.lua")
dofile(LockOn_Options.common_script_path.."ViewportHandling.lua")


indicator_type				= indicator_types.COMMON
purposes					= {render_purpose.GENERAL}


local viewport				= make_viewport(1,true,false,480)
dedicated_viewport			= viewport
dedicated_viewport_arcade	= viewport

page_subsets				= {LockOn_Options.script_path.."Displays/EHSI/indicator/LCD/page.lua"}
try_find_assigned_viewport("EHSI")

pages			= {{1}}
init_pageID		= 1
