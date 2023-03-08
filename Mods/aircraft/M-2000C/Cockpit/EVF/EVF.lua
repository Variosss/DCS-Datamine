dofile(LockOn_Options.common_script_path.."elements_defs.lua")

EVF_DEFAULT_LEVEL     = 8

SetScale(FOV)

local aspect       = GetAspect()

evf_base					= CreateElement "ceMeshPoly" -- untextured shape
evf_base.name				= "EVF"
evf_base.material			= MakeMaterial(nil,{255,0,0,50})
evf_base.h_clip_relation	= h_clip_relations.REWRITE_LEVEL
evf_base.level				= PCN_DEFAULT_LEVEL
evf_base.collimated			= false
evf_base.isvisible			= false
evf_base.z_emable			= true
evf_base.vertices			= { {-1, aspect}, { 1,aspect}, { 1,-aspect}, {-1,-aspect}, }
evf_base.indices			=  {0,1,2 ;  0,2,3 }
Add(evf_base)


-- ** LEFT LCD ** --
local	evf_digits				= CreateElement "ceStringPoly"
evf_digits.name					= "evf-digits"
evf_digits.material				= "evf_lcd_font"
evf_digits.init_pos				= {0,0,0}
evf_digits.alignment			= "CenterCenter"
evf_digits.formats				= {"%02d", "--"}
evf_digits.stringdefs			= {0.008,0.008}
evf_digits.controllers			= {{"cdc_digits"}}
evf_digits.use_mipfilter    	= true
evf_digits.h_clip_relation  	= h_clip_relations.COMPARE
evf_digits.level				= PCN_DEFAULT_LEVEL
evf_digits.additive_alpha   	= true
evf_digits.collimated 			= false
Add(evf_digits)
