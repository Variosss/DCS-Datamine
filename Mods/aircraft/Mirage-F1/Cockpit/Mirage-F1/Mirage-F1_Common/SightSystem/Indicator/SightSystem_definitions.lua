dofile(LockOn_Options.common_script_path.."elements_defs.lua")
dofile(LockOn_Options.script_path.."../../Common/symbology_generic_tools.lua")

collimated 							= true
INDICATOR_DEFAULT_LEVEL 			= 3

TFOV_radius 						= 132 --72.5 * 3.5 * 0.5 -- ~126.9 mils, 72.5 degrees of pitch ladder in total

radarDatumPosY   					= -87.25 -- mils

-- texture resolution			
texture_resolution 					= 1024
 
-- pixels per 1 milliradian
pixelsPerUnit 						= 24
