dofile(LockOn_Options.common_script_path.."devices_defs.lua")
dofile(LockOn_Options.script_path.."materials.lua")
purposes 	 = {render_purpose.GENERAL,render_purpose.HUD_ONLY_VIEW}
indicator_type     = indicator_types.--[[COMMON--]]COLLIMATOR--[[HELMET--]]

-------PAGE IDs-------
id_Page =
{
	PAGE_NULL			= 0,
	PAGE_OFF			= 1,
	PAGE_GRID			= 2,
	PAGE_TEST			= 3,
	PAGE_NAV			= 4,
	PAGE_NAV_STEERING	= 5,
	PAGE_CANNON			= 6,
	PAGE_ROCKETS		= 7,
	PAGE_MISSILES		= 8,
	PAGE_BOMBS			= 9,
    PAGE_COMBAT         = 10,
    PAGE_TEST           = 11
}

id_pagesubset =
{
	COMMON			= 0,
	GRID			= 1,
	NAV_COMMON		= 2,
	NAV_SPECIPHIC	= 3,
	NAV_STEERING	= 4,
	WEAPON_COMMON	= 5,
	SHKVAL_V		= 6,
	CANNON			= 7,
	ROCKETS			= 8,
	MISSILES		= 9,
	BOMBS			= 10,
    TEST            = 11,
}

opacity_sensitive_materials = 
{
	"INDICATION_HUD_KA50",
	"INDICATION_HUD_KA50_TEMP",
	"INDICATION_HUD_KA50_TEMP2",
	"INDICATION_HUD_KA50_BORDER_FAR",
	"INDICATION_HUD_KA50_BORDER_NEAR",
	--[["font_Ka-50_dbg",--]]
	"font_Ka-50_HUD"
}

color_sensitive_materials = 
{
	"INDICATION_HUD_KA50",
	"INDICATION_HUD_KA50_BORDER_FAR",
	"INDICATION_HUD_KA50_BORDER_NEAR",
	"font_Ka-50_HUD"
}

function get_color(tbl_in)
	tbl_out = {}
	
	local ind = 0
	for k, v in pairs(tbl_in) do
		ind = ind + 1
		if (ind < 4) then
			tbl_out[k] = v
		end
	end
	
	return tbl_out
end

indication_color = get_color(materials["GREEN"])
grid_color		 = get_color(materials["AMBER_HUD"])
night_color      = get_color(materials["HUD_NIGHT"])

page_subsets = {}
page_subsets[id_pagesubset.COMMON]			= LockOn_Options.script_path.."HUD\\HUD_BASE_page.lua"
page_subsets[id_pagesubset.GRID]			= LockOn_Options.script_path.."HUD\\HUD_GRID_page.lua"
page_subsets[id_pagesubset.NAV_COMMON]		= LockOn_Options.script_path.."HUD\\HUD_NAV_COMMON_page.lua"
page_subsets[id_pagesubset.NAV_SPECIPHIC]   = LockOn_Options.script_path.."HUD\\HUD_NAV_SPECIPHIC_page.lua"
page_subsets[id_pagesubset.NAV_STEERING]    = LockOn_Options.script_path.."HUD\\HUD_NAV_STEERING_page.lua"
page_subsets[id_pagesubset.WEAPON_COMMON]   = LockOn_Options.script_path.."HUD\\HUD_WEAPON_COMMON_page.lua"
page_subsets[id_pagesubset.SHKVAL_V]		= LockOn_Options.script_path.."HUD\\HUD_SHKVAL_page.lua"
page_subsets[id_pagesubset.CANNON]			= LockOn_Options.script_path.."HUD\\HUD_CANNON_page.lua"
page_subsets[id_pagesubset.ROCKETS]			= LockOn_Options.script_path.."HUD\\HUD_ROCKETS_page.lua"
page_subsets[id_pagesubset.MISSILES]		= LockOn_Options.script_path.."HUD\\HUD_MISSILES_page.lua"
page_subsets[id_pagesubset.BOMBS]			= LockOn_Options.script_path.."HUD\\HUD_BOMBS_page.lua"
page_subsets[id_pagesubset.TEST]			= LockOn_Options.script_path.."HUD\\HUD_TEST_page.lua"

----------------------
pages = {}

pages[id_Page.PAGE_OFF]		= { }

pages[id_Page.PAGE_GRID]	= {id_pagesubset.COMMON,
							   id_pagesubset.GRID
							  }

pages[id_Page.PAGE_NAV]		= {id_pagesubset.COMMON,
							 --   id_pagesubset.SHKVAL_V,
							   id_pagesubset.NAV_COMMON,
							   id_pagesubset.NAV_SPECIPHIC,
							   id_pagesubset.NAV_STEERING
							  }

pages[id_Page.PAGE_NAV_STEERING] = {id_pagesubset.COMMON,
								--	id_pagesubset.SHKVAL_V,
									id_pagesubset.NAV_COMMON,
									id_pagesubset.NAV_STEERING,
									id_pagesubset.NAV_SPECIPHIC
								   }

pages[id_Page.PAGE_CANNON]	= {id_pagesubset.COMMON,
							   id_pagesubset.WEAPON_COMMON,
							   id_pagesubset.SHKVAL_V,
							   id_pagesubset.CANNON,
							   id_pagesubset.NAV_COMMON
						      }
						   
pages[id_Page.PAGE_ROCKETS] = {id_pagesubset.COMMON,
							   id_pagesubset.WEAPON_COMMON,
							   id_pagesubset.SHKVAL_V,
							   id_pagesubset.ROCKETS,
							   id_pagesubset.NAV_COMMON
						     }
						     
pages[id_Page.PAGE_MISSILES]= {id_pagesubset.COMMON,
							   id_pagesubset.WEAPON_COMMON,
							   id_pagesubset.SHKVAL_V,
						       id_pagesubset.MISSILES,
							   id_pagesubset.NAV_COMMON
							  }
pages[id_Page.PAGE_BOMBS]   = {id_pagesubset.COMMON,
							   id_pagesubset.WEAPON_COMMON,
							   id_pagesubset.SHKVAL_V,
								--[[id_pagesubset.BOMBS,]]--
							   id_pagesubset.NAV_COMMON
							  }
                              
pages[id_Page.PAGE_COMBAT]=   {id_pagesubset.COMMON,
							   id_pagesubset.WEAPON_COMMON,
							   id_pagesubset.SHKVAL_V,
							   id_pagesubset.NAV_COMMON
							  }
pages[id_Page.PAGE_TEST]=     {id_pagesubset.COMMON,
							   id_pagesubset.TEST}


init_pageID		= id_Page.PAGE_NAV
grid_pageID		= id_Page.PAGE_GRID
use_parser		= false

--- master modes
KA50_HUD_OFF			   = 0 
KA50_HUD_TEST              = 1 
KA50_HUD_NAV               = 2
KA50_HUD_WEAPON            = 3 
--- Ka50_HUD_TEST_SUBMODES
KA50_HUD_TEST_MAIN         = 0
--- Ka50_HUD_NAV_SUBMODES
KA50_HUD_NAV_MAIN          = 0
KA50_HUD_NAV_STEERING      = 1
--- Ka50_HUD_WEAPON_SUBMODES
KA50_HUD_WEAPON_NULL       = 0
KA50_HUD_WEAPON_CANNON     = 1
KA50_HUD_WEAPON_ROCKETS    = 2
KA50_HUD_WEAPON_MISSILES   = 3
KA50_HUD_WEAPON_BOMBS      = 4

--- Ka50_HUD_WEAPON_CANNON_SUBMODES
KA50_HUD_WEAPON_CANNON_NPU = 0
KA50_HUD_WEAPON_CANNON_PPU = 1

------------------------------------
pages_by_mode                 = {}

pages_by_mode[KA50_HUD_OFF]							  = {}
pages_by_mode[KA50_HUD_OFF][0]						  = {}
pages_by_mode[KA50_HUD_OFF][0][0]					  = {}
pages_by_mode[KA50_HUD_OFF][0][0][0]				  = id_Page.PAGE_OFF

pages_by_mode[KA50_HUD_TEST]						  = {}
pages_by_mode[KA50_HUD_TEST][KA50_HUD_TEST_MAIN]      = {}
pages_by_mode[KA50_HUD_TEST][KA50_HUD_TEST_MAIN][0]   = {}
pages_by_mode[KA50_HUD_TEST][KA50_HUD_TEST_MAIN][0][0]= id_Page.PAGE_TEST

pages_by_mode[KA50_HUD_NAV]                           = {}
pages_by_mode[KA50_HUD_NAV][KA50_HUD_NAV_MAIN]        = {}
pages_by_mode[KA50_HUD_NAV][KA50_HUD_NAV_MAIN][0]     = {}
pages_by_mode[KA50_HUD_NAV][KA50_HUD_NAV_MAIN][0][0]  = id_Page.PAGE_NAV

pages_by_mode[KA50_HUD_NAV][KA50_HUD_NAV_STEERING]			= {}
pages_by_mode[KA50_HUD_NAV][KA50_HUD_NAV_STEERING][0]		= {}
pages_by_mode[KA50_HUD_NAV][KA50_HUD_NAV_STEERING][0][0]	= id_Page.PAGE_NAV_STEERING

pages_by_mode[KA50_HUD_WEAPON]                              = {}
pages_by_mode[KA50_HUD_WEAPON][KA50_HUD_WEAPON_CANNON]								  = {}
pages_by_mode[KA50_HUD_WEAPON][KA50_HUD_WEAPON_CANNON][KA50_HUD_WEAPON_CANNON_NPU]	  = {}
pages_by_mode[KA50_HUD_WEAPON][KA50_HUD_WEAPON_CANNON][KA50_HUD_WEAPON_CANNON_PPU]    = {}
pages_by_mode[KA50_HUD_WEAPON][KA50_HUD_WEAPON_CANNON][KA50_HUD_WEAPON_CANNON_NPU][0] = id_Page.PAGE_CANNON
pages_by_mode[KA50_HUD_WEAPON][KA50_HUD_WEAPON_CANNON][KA50_HUD_WEAPON_CANNON_PPU][0] = id_Page.PAGE_CANNON


pages_by_mode[KA50_HUD_WEAPON][KA50_HUD_WEAPON_NULL]	   = {}
pages_by_mode[KA50_HUD_WEAPON][KA50_HUD_WEAPON_NULL][0]	   = {}
pages_by_mode[KA50_HUD_WEAPON][KA50_HUD_WEAPON_NULL][0][0] = id_Page.PAGE_COMBAT

pages_by_mode[KA50_HUD_WEAPON][KA50_HUD_WEAPON_ROCKETS]						          = {}
pages_by_mode[KA50_HUD_WEAPON][KA50_HUD_WEAPON_ROCKETS][0]					          = {}
pages_by_mode[KA50_HUD_WEAPON][KA50_HUD_WEAPON_ROCKETS][0][0]				          = id_Page.PAGE_ROCKETS

pages_by_mode[KA50_HUD_WEAPON][KA50_HUD_WEAPON_MISSILES]					          = {}
pages_by_mode[KA50_HUD_WEAPON][KA50_HUD_WEAPON_MISSILES][0]					          = {}
pages_by_mode[KA50_HUD_WEAPON][KA50_HUD_WEAPON_MISSILES][0][0]				          = id_Page.PAGE_MISSILES

pages_by_mode[KA50_HUD_WEAPON][KA50_HUD_WEAPON_BOMBS]					          = {}
pages_by_mode[KA50_HUD_WEAPON][KA50_HUD_WEAPON_BOMBS][0]					      = {}
pages_by_mode[KA50_HUD_WEAPON][KA50_HUD_WEAPON_BOMBS][0][0]				          = id_Page.PAGE_BOMBS

function get_page_by_mode(master, L2, L3, L4)
	local page_id = pages_by_mode[master][L2][L3][L4]
	if    page_id ~= nil then
		return page_id	
	else 
		  page_id = pages_by_mode[master][0][0][0]
		  if  page_id ~= nil then
				return page_id
		  else
		  		return init_pageID
		  end
	end
end
