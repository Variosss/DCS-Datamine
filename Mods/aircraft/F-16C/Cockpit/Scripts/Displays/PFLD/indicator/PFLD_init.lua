dofile(LockOn_Options.common_script_path.."devices_defs.lua")

opacity_sensitive_materials = 
{
	"font_PFLD",
	"font_PFLD_inv"
}

indicator_type	= indicator_types.COMMON
purposes		= {render_purpose.GENERAL}

--
PFLD_PagesPath = LockOn_Options.script_path.."Displays/PFLD/indicator/"
dofile(LockOn_Options.script_path.."Displays/Common/indicator/PFLD/PFLD_Pages_init.lua")

--
use_parser					= false
dynamically_update_geometry	= false

