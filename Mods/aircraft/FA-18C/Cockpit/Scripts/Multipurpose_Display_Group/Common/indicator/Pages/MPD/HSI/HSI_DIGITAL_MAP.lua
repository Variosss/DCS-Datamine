dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/MPD_page_defs.lua")

AddVideoSignalRender_MPD_FullScreen({{"MPD_HSI_DigitalMapShow"}})

--[[
local szDBG = 0.3
local vertsDBG = {{-szDBG,  szDBG},
			   { szDBG,  szDBG}, 
			   { szDBG, -szDBG},
			   {-szDBG, -szDBG}}
				   
local meshDBG  			    = CreateElement "ceMeshPoly"
meshDBG.name                = "meshDBG"
meshDBG.isdraw              = true
meshDBG.material            = "DBG_RED"
meshDBG.additive_alpha	    = additive_alpha or false
meshDBG.collimated		    = collimated or false
meshDBG.use_mipfilter       = use_mipfilter
--setClipLevel(meshDBG)
meshDBG.vertices			= vertsDBG
meshDBG.indices				= default_box_indices
meshDBG.primitivetype		= "triangles"
meshDBG.screenspace 		= 2
Add(meshDBG)
]]