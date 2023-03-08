dofile(LockOn_Options.common_script_path.."devices_defs.lua")

opacity_sensitive_materials = 
{
	"font_DED",
	"font_DED_inv"
}

indicator_type	= indicator_types.COMMON
purposes		= {render_purpose.GENERAL}

--
DED_PagesPath = LockOn_Options.script_path.."Displays/DED/indicator/Pages/"
dofile(LockOn_Options.script_path.."Displays/Common/indicator/DED/DED_Pages_init.lua")

--
use_parser					= false
dynamically_update_geometry	= false
