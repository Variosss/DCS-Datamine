
--	SelfWidth   - width of device in meters
--  SelfHeight   - height of device in meters
dofile(LockOn_Options.common_script_path.."devices_defs.lua")

indicator_type = indicator_types.COMMON
used_render_mask = "interleave.dds"

purposes 	 	  = {100}--render_purpose.GENERAL,render_purpose.HUD_ONLY_VIEW}
x_size            = 1.0
y_size            = SelfHeight/SelfWidth
frame_start_y     = 23/1024
frame_end_y       = 754/1024
tex_scale         = (frame_end_y - frame_start_y)/(2*y_size)
render_start      = 55/1024
render_end        = 497/1024

y_render_size     = 0.5 * (render_end - render_start)/tex_scale

aspect_render_map = y_render_size/x_size

map_window_params =
{
	cursor_limit_y = y_render_size/x_size,
	cursor_size    = 16/422,
	scale_factor   = SelfWidth * 0.5
}
						
-------PAGE IDs-------
id_pagesubset =
{
	COMMON                = 0,
	MAIN                  = 1,
	SNS_COMMON              = 3,
	CONTROLS         = 4,

	NAV_MAIN              = 5,
	NAV_MAP               = 6,
	NAV_JOURNAL           = 7,
	NAV_SEARCH            = 8,
	NAV_HSI               = 9,
	NAV_REVIEW            = 10,
	
	OPTIONS_MAIN          = 12,
	OPTIONS_MEASUREMENTS  = 13,
	OPTIONS_PERFOMANCE    = 14,
	OPTIONS_SIGNALS       = 15,
	OPTIONS_CHARTS        = 16,
	
	OPTIONS_COMMON        = 17,
	
	CONTROLS_MESSAGES     = 18,
	CONTROLS_DATABANK     = 19,
	CONTROLS_K041_COMMON  = 20,
	CONTROLS_COMMON       = 21,
	SPECIFIC              = 22,
	
	NAV_MAP_COMMON        = 23,
	NAV_MAP_INFO_STBY     = 24,
	NAV_MAP_INFO_READY    = 25,
	NAV_MAP_MEASURE       = 26,
	NAV_MAP_MARKER        = 27,
	
	
	TEMPLATE_JOURNAL      = 28,
	TEMPLATE_SIMPLE_MENU  = 31,
	
	PLAN_COMMON			  = 30,
	PLAN_MAIN             = 11,
	PLAN_LOAD             = 32,
	PLAN_ROUTE_LOADED     = 33,
		
	PLAN_REDACT_DRAW_FINALIZE_INSERT_COMMON = 34,
	PLAN_ROUTE_TEMPLATE       = 35,
	
	PLAN_REMOVE			  = 36,
	PLAN_SAVE			  = 37,
	
	PLAN_DRAW		      = 29,
	PLAN_DRAW_COMMON      = 38,
	PLAN_DRAW_INSERT      = 39,
	PLAN_REDACT_SPEED_TEMPLATE = 40,
	PLAN_REDACT_SPEED     = 41,
	PLAN_REDACT_SPEED_FINALIZE = 42,
	PLAN_REDACT_SPEED_COMMON   = 43,
	
	PLAN_REDACT_METEO_TEMPLATE = 44,
	PLAN_REDACT_METEO     = 45,
	PLAN_REDACT_METEO_FINALIZE = 46,
	PLAN_REDACT_METEO_COMMON   = 47,
	
	PLAN_REDACT_VNAV_TEMPLATE = 48,
	PLAN_REDACT_VNAV     = 49,
	PLAN_REDACT_VNAV_FINALIZE = 50,
	PLAN_REDACT_VNAV_COMMON   = 51,
	
	PLAN_REDACT_FUEL_TEMPLATE = 52,
	PLAN_REDACT_FUEL     = 53,
	PLAN_REDACT_FUEL_FINALIZE = 54,
	PLAN_REDACT_FUEL_COMMON   = 55,
	
	SEARCH_COMMON			  = 56,
	PLAN_REDACT_DRAW_SEARCH      = 57,
	PLAN_REDACT_DRAW_SEARCH_NOT_FOUND  = 58,
	PLAN_REDACT_DRAW_SEARCH_NEAREST    = 59,
	
	
	NAV_SEARCH_NEAREST_COMMON = 60,
	NAV_SEARCH_NEAREST_AERODROMES = 61,
	NAV_SEARCH_NEAREST_VOR = 62,
	NAV_SEARCH_NEAREST_OPRS = 63,
	NAV_SEARCH_NEAREST_STP = 64,
	NAV_SEARCH_NEAREST_CITY = 65,
	
	NAV_SEARCH_TEMPLATE_COMMON = 66,
	NAV_SEARCH_TEMPLATE_AIRPORT = 82,
	NAV_SEARCH_TEMPLATE_VOR = 83,
	NAV_SEARCH_TEMPLATE_OPRS = 84,
	NAV_SEARCH_TEMPLATE_STP = 85,
	NAV_SEARCH_TEMPLATE_CITY = 86,
	
	
	NAV_SEARCH_FOUNDED_INFO_READY = 67,
	NAV_SEARCH_FIND_BY_NAME       = 68,
	
	NAV_SEARCH_BY_NAME_TEMPLATE_COMMON = 87,
	NAV_SEARCH_BY_NAME_TEMPLATE_AIRPORT = 88,
	NAV_SEARCH_BY_NAME_TEMPLATE_VOR = 89,
	NAV_SEARCH_BY_NAME_TEMPLATE_OPRS = 90,
	NAV_SEARCH_BY_NAME_TEMPLATE_STP = 91,
	
	PLAN_ADDITIONAL_INFO_MAIN   = 70,
	PLAN_ADDITIONAL_INFO_ADD_POINT_LINE  = 71,
	
	PLAN_ADDITIONAL_INFO_POINTS_DIRECT   = 72,
	PLAN_ADDITIONAL_INFO_POINTS_RELATIVE = 73,
	PLAN_ADDITIONAL_INFO_POINT_EDIT_REMOVE  = 74,	
	PLAN_ADDITIONAL_INFO_LINES  = 75,
	PLAN_ADDITIONAL_INFO_POINT_LINE_REMOVE  = 76,
	
	PLAN_ADDITIONALINFO_COLOR_TEMPLATE = 77,
	
	CONTROLS_DATABANK_LOADER  = 78,
	CONTROLS_DATABANK_STORAGE = 79,
	CONTROLS_DATABANK_COMMON  = 80,
	
	SOFTWARE_BSOD             = 81,
	

	
	SYST_MAIN         = 92,
	SYST_SNS			= 93,
	SYST_COMMON			= 94,
	SYST_SELECT			= 95,
	SYST_EDIT			= 96,
	SYST_SNS_START_TEST		= 97,
	SYST_SNS_STOP_TEST		= 98,
	
	SNS_MAIN_COMMON = 99,
	SNS_MAIN_MANUAL = 100,
	SNS_MAIN_AUTO = 101,
	SNS_CALC = 102,
	
	NAV_JOURNAL_VNAV = 103,
	NAV_JOURNAL_VNAV_VERTICAL_SPEED_EDIT = 104,
	OPTIONS_CHANGE = 105,
	OPTIONS_EDIT = 106,	
	SYST_MAIN_COMMON = 107,
	SYST_MAIN_MENU = 108,
	PLAN_COMMON_MODE = 109,
	
	PLAN_REDACT_DRAW_FINALIZE_INSERT_NEW_WPT = 110,
	PLAN_REDACT_DRAW_FINALIZE_INSERT_EXIST_WPT = 111,
	PLAN_REDACT_DRAW_FINALIZE_INSERT_EXIST_WPT_ARRAY = 112,
	PLAN_REDACT_DRAW_FINALIZE_INSERT_MOVE = 113,
	
	NAV_JOURNAL_VNAV_COMMON = 114,
	
	CONTROLS_K041 	   = 115,
	CONTROLS_K041_MENU = 116,
	
	PLAN_ADDITIONAL_OBJECTS_MODE = 117,
	PLAN_ADDITIONAL_POINTS_MODE = 118,
	PLAN_ADDITIONAL_LINES_MODE = 119,
	MESSAGES_TEMPLATE          = 120,
	
	HARDWARE_BIOS			   = 121,
}
	
	

id_Page =
{
	PAGE_NULL = 0,
	PAGE_OFF  = 1,
	PAGE_TEST = 2,
	PAGE_MAIN = 3,
	PAGE_MAP  = 4,
	
	PAGE_CONTROLS = 6,
	
	PAGE_SNS_MAIN      = 5,
	PAGE_NAV_MAIN      = 7,

	PAGE_NAV_MAP      = 8,
	PAGE_NAV_JOURNAL  = 9,
	PAGE_NAV_SEARCH   = 10,
	PAGE_NAV_HSI      = 11,
	PAGE_NAV_REVIEW   = 12,
	

	PAGE_OPTIONS_MAIN  = 14,
	PAGE_OPTIONS_MEASUREMENTS = 15,
	PAGE_OPTIONS_PERFOMANCE = 16,
	PAGE_OPTIONS_SIGNALS    = 17,
	PAGE_OPTIONS_CHARTS     = 18,
	
	PAGE_CONTROLS_MESSAGES = 19,
	PAGE_CONTROLS_DATABANK = 20,
	PAGE_CONTROLS_K041     = 21,
	
	PAGE_NAV_MAP_INFO_STBY  = 22,
	PAGE_NAV_MAP_INFO_READY = 23,
	PAGE_NAV_MAP_MEASURE    = 24,
	PAGE_NAV_MAP_MARKER     = 25,
	
	PAGE_PLAN_MAIN     		 = 13,
	PAGE_PLAN_LOAD            = 27,
	PAGE_PLAN_ROUTE_LOADED    = 28,
	PAGE_PLAN_REDACT_DRAW_FINALIZE_INSERT = 29,
	PAGE_PLAN_REMOVE		 = 30,
	PAGE_PLAN_SAVE			  = 31,
	PAGE_PLAN_DRAW     = 26,
	PAGE_PLAN_DRAW_INSERT = 32,
	
	PAGE_PLAN_REDACT_SPEED = 33,
	PAGE_PLAN_REDACT_SPEED_FINALIZE = 34,
	
	PAGE_PLAN_REDACT_METEO = 35,
	PAGE_PLAN_REDACT_METEO_FINALIZE = 36,
	
	PAGE_PLAN_REDACT_VNAV = 37,
	PAGE_PLAN_REDACT_VNAV_FINALIZE = 38,
	
	PAGE_PLAN_REDACT_FUEL = 39,
	PAGE_PLAN_REDACT_FUEL_FINALIZE = 40,
	PAGE_PLAN_REDACT_DRAW_SEARCH = 41,
	PAGE_PLAN_REDACT_DRAW_SEARCH_NOT_FOUND  = 42,
	PAGE_PLAN_REDACT_DRAW_SEARCH_NEAREST    = 43,
	
	PAGE_NAV_SEARCH_NEAREST_AERODROMES = 44,
	PAGE_NAV_SEARCH_NEAREST_VOR = 45,
	PAGE_NAV_SEARCH_NEAREST_OPRS = 46,
	PAGE_NAV_SEARCH_NEAREST_STP = 47,
	PAGE_NAV_SEARCH_NEAREST_CITY = 48,
	
	PAGE_NAV_SEARCH_FOUNDED_INFO_READY = 49,
	PAGE_NAV_SEARCH_FIND_BY_NAME       = 50,
	
	PAGE_PLAN_ADDITIONAL_INFO_MAIN     = 51,
	PAGE_PLAN_ADDITIONAL_INFO_POINTS_DIRECT = 52,
	PAGE_PLAN_ADDITIONAL_INFO_POINTS_RELATIVE = 53,
	PAGE_PLAN_ADDITIONAL_INFO_POINT_EDIT_REMOVE  = 54,
	PAGE_PLAN_ADDITIONAL_INFO_POINT_REMOVE  = 55,
	PAGE_PLAN_ADDITIONAL_INFO_LINES  = 56,	
	PAGE_PLAN_ADDITIONAL_INFO_LINE_REMOVE  = 57,

	PAGE_CONTROLS_DATABANK_LOADER  = 58,
	PAGE_CONTROLS_DATABANK_STORAGE = 59,
	PAGE_BSOD            		   = 60,
	
	PAGE_SYST_MAIN = 61,
	PAGE_SYST_SNS = 62,
	PAGE_SYST_SNS_SELECT = 63,
	PAGE_SYST_SNS_EDIT = 64,
	PAGE_SYST_SNS_START_TEST = 65,
	PAGE_SYST_SNS_STOP_TEST = 66,
	
	PAGE_SNS_MAIN_AUTO = 67,
	PAGE_SNS_MAIN_MANUAL = 68,
	
	PAGE_SNS_CALC = 69,
	PAGE_NAV_JOURNAL_VNAV = 70,
	PAGE_NAV_JOURNAL_VERTICAL_SPEED_EDIT = 71,
	PAGE_OPTIONS_MAIN_EDIT = 72,
	
	PAGE_SYST_MAIN_MENU = 73,
	PAGE_PLAN_REDACT_DRAW_FINALIZE_INSERT_EXIST_WPT = 74,
	PAGE_PLAN_REDACT_DRAW_FINALIZE_INSERT_EXIST_WPT_ARRAY = 75,
	PAGE_PLAN_REDACT_DRAW_FINALIZE_INSERT_MOVE = 76,
	
	PAGE_NAV_JOURNAL_VNAV_EDIT = 77,
	
	PAGE_CONTROLS_K041_MENU = 78,
	
	PAGE_BIOS = 79
}

--mode enums
--ABRIS modes      (ABRIS_Mode::master)
  ABRIS_MENU                = 0 + 1
  ABRIS_OPTIONS			    = 1 + 1
  ABRIS_CONTROLS            = 2 + 1
  ABRIS_PLAN                = 3 + 1
  ABRIS_SNS                 = 4 + 1
  ABRIS_NAV                 = 5 + 1
  ABRIS_HARDWARE            = 6 + 1
  ABRIS_SOFTWARE            = 7 + 1
  ABRIS_SYST				= 8 + 1
--SUBMODES 
  ABRIS_SUBMODE_NONE        = 0 + 1
--OPTIONS submodes (ABRIS_Mode::level_2)
  ABRIS_OPTIONS_MAIN	    = 0 + 1
  ABRIS_OPTIONS_MEASUREMENTS= 1 + 1
  ABRIS_OPTIONS_PERFOMANCE  = 2 + 1
  ABRIS_OPTIONS_SIGNALS     = 3 + 1
  ABRIS_OPTIONS_CHARTS      = 4 + 1
 --OPTIONS submodes (ABRIS_Mode::level_3)
  ABRIS_OPTIONS_CHANGE      = 0 + 1
  ABRIS_OPTIONS_EDIT	    = 1 + 1
--CONTROLS submodes (ABRIS_Mode::level_2)
  ABRIS_CONTROLS_DATABANK   = 1 + 1
  ABRIS_CONTROLS_K_041      = 2 + 1
  ABRIS_CONTROLS_MESSAGES   = 3 + 1
--SNS submodes     (ABRIS_Mode::level_2)
  ABRIS_SNS_MAIN			= 0 + 1
  ABRIS_SNS_CALC			= 1 + 1
 --SYST submodes (ABRIS_Mode::level_2)
  ABRIS_SYST_MAIN			= 0 + 1
  ABRIS_SYST_MAIN_MENU 		= 1 + 1
  ABRIS_SYST_ARINC			= 2 + 1;
  ABRIS_SYST_RS_232			= 3 + 1;
  ABRIS_SYST_DAC			= 4 + 1;
  ABRIS_SYST_ADC			= 5 + 1;
  ABRIS_SYST_SNS			= 6 + 1;
  ABRIS_SYST_AUDIO			= 7 + 1;
  ABRIS_SYST_RK				= 8 + 1;
  ABRIS_SYST_TEST			= 9 + 1;
  ABRIS_SYST_TRACE			= 10 + 1;
  ABRIS_SYST_SOFTWARE		= 11 + 1;
 --SYST subsubmodes (ABRIS_Mode::level_3)
  ABRIS_SNS_MAIN_MANUAL		= 0 +1
  ABRIS_SNS_MAIN_AUTO		= 1 +1
  
  ABRIS_SYST_SNS_MAIN = 0 + 1
  ABRIS_SYST_SNS_EDIT = 1 + 1
  ABRIS_SYST_SNS_START_TEST = 2 + 1;
  ABRIS_SYST_SNS_STOP_TEST = 3 + 1;

--NAV submodes      (ABRIS_Mode::level_2)
  ABRIS_NAV_HSI             = 1 + 1
  ABRIS_NAV_JOURNAL         = 2 + 1
  ABRIS_NAV_SEARCH          = 3 + 1
  ABRIS_NAV_MAP             = 4 + 1
  ABRIS_NAV_REVIEW          = 5 + 1

  ABRIS_NAV_JOURNAL_FLIGHTROUTE  = 1 + 1
  ABRIS_NAV_JOURNAL_STARTROUTE   = 2 + 1
  ABRIS_NAV_JOURNAL_RETURNROUTE  = 3 + 1
  ABRIS_NAV_JOURNAL_VNAV		 = 4 + 1

--NAV-MAP ABRIS_Mode::level_3
  ABRIS_NAV_MAP_INFO_STDBY    = 1 + 1
  ABRIS_NAV_MAP_INFO_READY    = 2 + 1
  ABRIS_NAV_MAP_MEASURE = 3 + 1
  ABRIS_NAV_MAP_MARKER  = 4 + 1

 -- NAV-SEARCH level3
  ABRIS_NAV_SEARCH_FIND_NEAREST       = 1 + 1
  ABRIS_NAV_SEARCH_FIND_BY_NAME       = 2 + 1
--PLAN submodes     (ABRIS_Mode::level_2)  
  ABRIS_PLAN_LOAD                = 1 + 1
  ABRIS_PLAN_REDACT				 = 2 + 1
  ABRIS_PLAN_SAVE                = 3 + 1
  ABRIS_PLAN_CLEAN               = 4 + 1
  ABRIS_PLAN_RETURN              = 5 + 1
  ABRIS_PLAN_REMOVE              = 6 + 1
  ABRIS_PLAN_INVERT              = 7 + 1
  ABRIS_PLAN_AUTO                = 8 + 1
  ABRIS_PLAN_ADDITIONALINFO      = 9 + 1
  ABRIS_PLAN_ROUTE_LOADED  		 = 10 + 1
 
 --PLAN level3 REDACT submodes
ABRIS_PLAN_REDACT_DRAW			= 1 + 1;
ABRIS_PLAN_REDACT_SPEED			= 2 + 1;
ABRIS_PLAN_REDACT_VNAV			= 3 + 1;
ABRIS_PLAN_REDACT_METEO			= 4 + 1;
ABRIS_PLAN_REDACT_FUEL			= 5 + 1;
--PLAN level4 REDACT submodes
ABRIS_NAV_JOURNAL_VERTICAL_SPEED_EDIT	 = 1 + 1;
ABRIS_NAV_JOURNAL_VNAV_EDIT				 = 2 + 1;

ABRIS_PLAN_REDACT_DRAW_FINALIZE_INSERT   = 1 + 1;
ABRIS_PLAN_REDACT_DRAW_INSERT		     = 2 + 1;
ABRIS_PLAN_REDACT_DRAW_SEARCH		     = 3 + 1;
ABRIS_PLAN_REDACT_DRAW_SEARCH_NOT_FOUND  = 4 + 1;
ABRIS_PLAN_REDACT_DRAW_SEARCH_NEAREST    = 5 + 1;
ABRIS_PLAN_REDACT_DRAW_FINALIZE_INSERT_EXIST_WPT	 = 6 + 1;
ABRIS_PLAN_REDACT_DRAW_FINALIZE_INSERT_EXIST_WPT_ARRAY	 = 7 + 1;
ABRIS_PLAN_REDACT_DRAW_MOVE = 8 + 1;

ABRIS_PLAN_REDACT_SPEED_FINALIZE       = 1 + 1;
ABRIS_PLAN_REDACT_METEO_FINALIZE       = 1 + 1;
ABRIS_PLAN_REDACT_VNAV_FINALIZE        = 1 + 1;
ABRIS_PLAN_REDACT_FUEL_FINALIZE        = 1 + 1;

ABRIS_PLAN_ADDITIONALINFO_POINT_INSERT = 1  + 1;
ABRIS_PLAN_ADDITIONALINFO_LINE_INSERT  = 2  + 1;
ABRIS_PLAN_ADDITIONALINFO_POINT_EDIT_REMOVE  = 3  + 1;
ABRIS_PLAN_ADDITIONALINFO_POINT_REMOVE  = 4  + 1;
ABRIS_PLAN_ADDITIONALINFO_LINE_REMOVE  = 5  + 1;

ABRIS_PLAN_ADDITIONALINFO_POINT_INSERTS_DIRECT   = 0 + 1; 
ABRIS_PLAN_ADDITIONALINFO_POINT_INSERTS_RELATIVE = 1 + 1;
ABRIS_PLAN_ADDITIONALINFO_POINT_INSERTS_FINALIZE = 2 + 1;


	NAV_SEARCH_AERODROMES = 0 + 1
	NAV_SEARCH_VOR = 1 + 1
	NAV_SEARCH_OPRS = 2 + 1
	NAV_SEARCH_STP = 3 + 1
	NAV_SEARCH_CITY = 4 + 1

ABRIS_NAV_SEARCH_FOUNDED_INFO_READY = 5 + 1;

ABRIS_CONTROLS_DATABANK_ONBOARD_LOADER   = 1 + 1;
ABRIS_CONTROLS_DATABANK_ONBOARD_STORAGE  = 2 + 1;

ABRIS_CONTROLS_K_041_MENU				 = 3 + 1;

ABRIS_HARDWARE_BIOS_POST       = 1 + 1;
ABRIS_SOFTWARE_ERROR		   = 1 + 1;



page_subsets = {}
page_subsets[id_pagesubset.COMMON] 			   = LockOn_Options.script_path.."ABRIS\\ABRIS_base_page.lua"
page_subsets[id_pagesubset.MAIN]   			   = LockOn_Options.script_path.."ABRIS\\ABRIS_page_menu.lua"
 
page_subsets[id_pagesubset.SNS_COMMON]           = LockOn_Options.script_path.."ABRIS\\ABRIS_page_SNS_COMMON.lua"
page_subsets[id_pagesubset.SNS_MAIN_COMMON]           = LockOn_Options.script_path.."ABRIS\\ABRIS_page_SNS_MAIN_COMMON.lua"
page_subsets[id_pagesubset.SNS_MAIN_MANUAL]           = LockOn_Options.script_path.."ABRIS\\ABRIS_page_SNS_MAIN_MANUAL.lua"
page_subsets[id_pagesubset.SNS_MAIN_AUTO]           = LockOn_Options.script_path.."ABRIS\\ABRIS_page_SNS_MAIN_AUTO.lua"
page_subsets[id_pagesubset.SNS_CALC]           = LockOn_Options.script_path.."ABRIS\\ABRIS_page_SNS_CALC.lua"

page_subsets[id_pagesubset.NAV_MAIN]           = LockOn_Options.script_path.."ABRIS\\ABRIS_page_NAV_MAIN.lua"
page_subsets[id_pagesubset.NAV_MAP]            = LockOn_Options.script_path.."ABRIS\\ABRIS_page_NAV_MAP.lua"
page_subsets[id_pagesubset.NAV_JOURNAL]		   = LockOn_Options.script_path.."ABRIS\\ABRIS_page_NAV_JOURNAL.lua"
page_subsets[id_pagesubset.NAV_SEARCH]		   = LockOn_Options.script_path.."ABRIS\\ABRIS_page_NAV_SEARCH.lua"
page_subsets[id_pagesubset.NAV_HSI]			   = LockOn_Options.script_path.."ABRIS\\ABRIS_page_NAV_HSI.lua"
page_subsets[id_pagesubset.NAV_REVIEW]         = LockOn_Options.script_path.."ABRIS\\ABRIS_page_NAV_REVIEW.lua"
page_subsets[id_pagesubset.OPTIONS_MAIN]       = LockOn_Options.script_path.."ABRIS\\ABRIS_page_OPTIONS_MAIN.lua"
page_subsets[id_pagesubset.OPTIONS_MEASUREMENTS]      = LockOn_Options.script_path.."ABRIS\\ABRIS_page_OPTIONS_MEASUREMENTS.lua"
page_subsets[id_pagesubset.OPTIONS_PERFOMANCE] = LockOn_Options.script_path.."ABRIS\\ABRIS_page_OPTIONS_PERFOMANCE.lua"
page_subsets[id_pagesubset.OPTIONS_SIGNALS]    = LockOn_Options.script_path.."ABRIS\\ABRIS_page_OPTIONS_SIGNALS.lua"
page_subsets[id_pagesubset.OPTIONS_CHARTS]     = LockOn_Options.script_path.."ABRIS\\ABRIS_page_OPTIONS_CHARTS.lua"
page_subsets[id_pagesubset.OPTIONS_COMMON]     = LockOn_Options.script_path.."ABRIS\\ABRIS_page_OPTIONS_COMMON.lua"

page_subsets[id_pagesubset.OPTIONS_CHANGE]     = LockOn_Options.script_path.."ABRIS\\ABRIS_page_OPTIONS_CHANGE.lua"
page_subsets[id_pagesubset.OPTIONS_EDIT]     = LockOn_Options.script_path.."ABRIS\\ABRIS_page_OPTIONS_EDIT.lua"

page_subsets[id_pagesubset.SYST_MAIN_COMMON]     = LockOn_Options.script_path.."ABRIS\\ABRIS_page_SYST_MAIN_COMMON.lua"
page_subsets[id_pagesubset.SYST_MAIN]     = LockOn_Options.script_path.."ABRIS\\ABRIS_page_SYST_MAIN.lua"
page_subsets[id_pagesubset.SYST_MAIN_MENU]     = LockOn_Options.script_path.."ABRIS\\ABRIS_page_SYST_MAIN_MENU.lua"
page_subsets[id_pagesubset.SYST_SNS]      = LockOn_Options.script_path.."ABRIS\\ABRIS_page_SYST_SNS.lua"
page_subsets[id_pagesubset.SYST_COMMON]   = LockOn_Options.script_path.."ABRIS\\ABRIS_page_SYST_COMMON.lua"
page_subsets[id_pagesubset.SYST_SELECT]     = LockOn_Options.script_path.."ABRIS\\ABRIS_page_SYST_SELECT.lua"
page_subsets[id_pagesubset.SYST_EDIT]     = LockOn_Options.script_path.."ABRIS\\ABRIS_page_SYST_EDIT.lua"
page_subsets[id_pagesubset.SYST_SNS_START_TEST]    = LockOn_Options.script_path.."ABRIS\\ABRIS_page_SYST_SNS_START_TEST.lua"
page_subsets[id_pagesubset.SYST_SNS_STOP_TEST]     = LockOn_Options.script_path.."ABRIS\\ABRIS_page_SYST_SNS_STOP_TEST.lua"

--page_subsets[id_pagesubset.CONTROLS]   = ""
page_subsets[id_pagesubset.CONTROLS_MESSAGES]   = LockOn_Options.script_path.."ABRIS\\ABRIS_page_CONTROLS_MESSAGES.lua"
page_subsets[id_pagesubset.CONTROLS_DATABANK]   = LockOn_Options.script_path.."ABRIS\\ABRIS_page_CONTROLS_DATABASE.lua"
page_subsets[id_pagesubset.CONTROLS_DATABANK_LOADER ] = LockOn_Options.script_path.."ABRIS\\ABRIS_page_CONTROLS_DATABASE_LOADER.lua"
page_subsets[id_pagesubset.CONTROLS_DATABANK_STORAGE] = LockOn_Options.script_path.."ABRIS\\ABRIS_page_CONTROLS_DATABASE_STORAGE.lua"
page_subsets[id_pagesubset.CONTROLS_DATABANK_COMMON ] = LockOn_Options.script_path.."ABRIS\\ABRIS_page_CONTROLS_DATABASE_COMMON.lua"
page_subsets[id_pagesubset.CONTROLS_K041_COMMON]       = LockOn_Options.script_path.."ABRIS\\ABRIS_page_CONTROLS_K041_COMMON.lua"
page_subsets[id_pagesubset.CONTROLS_K041]       = LockOn_Options.script_path.."ABRIS\\ABRIS_page_CONTROLS_K041.lua"
page_subsets[id_pagesubset.CONTROLS_K041_MENU]       = LockOn_Options.script_path.."ABRIS\\ABRIS_page_CONTROLS_K041_MENU.lua"
page_subsets[id_pagesubset.CONTROLS_COMMON]     = LockOn_Options.script_path.."ABRIS\\ABRIS_page_CONTROLS_COMMON.lua"

page_subsets[id_pagesubset.NAV_MAP_COMMON]      =LockOn_Options.script_path.."ABRIS\\ABRIS_page_NAV_MAP_COMMON.lua"
page_subsets[id_pagesubset.NAV_MAP_INFO_STBY]   =LockOn_Options.script_path.."ABRIS\\ABRIS_page_NAV_MAP_INFO_STBY.lua"
page_subsets[id_pagesubset.NAV_MAP_INFO_READY]  =LockOn_Options.script_path.."ABRIS\\ABRIS_page_NAV_MAP_INFO_READY.lua"
page_subsets[id_pagesubset.NAV_MAP_MEASURE]     =LockOn_Options.script_path.."ABRIS\\ABRIS_page_NAV_MAP_MEASURE.lua"
page_subsets[id_pagesubset.NAV_MAP_MARKER]      =LockOn_Options.script_path.."ABRIS\\ABRIS_page_NAV_MAP_MARKER.lua"
page_subsets[id_pagesubset.TEMPLATE_JOURNAL]     =LockOn_Options.script_path.."ABRIS\\ABRIS_page_NAV_JOURNAL_LIST.lua" 
page_subsets[id_pagesubset.TEMPLATE_SIMPLE_MENU] =LockOn_Options.script_path.."ABRIS\\ABRIS_page_CURRENT_MENU_TEMPLATE.lua"

page_subsets[id_pagesubset.PLAN_MAIN]         = LockOn_Options.script_path.."ABRIS\\ABRIS_page_PLAN_MAIN.lua"
page_subsets[id_pagesubset.PLAN_COMMON]       = LockOn_Options.script_path.."ABRIS\\ABRIS_page_PLAN_COMMON.lua"
page_subsets[id_pagesubset.PLAN_COMMON_MODE]       = LockOn_Options.script_path.."ABRIS\\ABRIS_page_PLAN_COMMON_MODE.lua"
page_subsets[id_pagesubset.PLAN_DRAW_COMMON]  		  = LockOn_Options.script_path.."ABRIS\\ABRIS_page_PLAN_DRAW_COMMON.lua"
page_subsets[id_pagesubset.PLAN_DRAW_INSERT]  		  = LockOn_Options.script_path.."ABRIS\\ABRIS_page_PLAN_DRAW_INSERT.lua"
page_subsets[id_pagesubset.PLAN_DRAW] 		 		  = LockOn_Options.script_path.."ABRIS\\ABRIS_page_PLAN_DRAW.lua"

page_subsets[id_pagesubset.PLAN_REDACT_DRAW_FINALIZE_INSERT_COMMON] = LockOn_Options.script_path.."ABRIS\\ABRIS_page_PLAN_REDACT_DRAW_FINALIZE_INSERT_COMMON.lua"
page_subsets[id_pagesubset.PLAN_REDACT_DRAW_FINALIZE_INSERT_NEW_WPT] = LockOn_Options.script_path.."ABRIS\\ABRIS_page_PLAN_REDACT_DRAW_FINALIZE_INSERT_NEW_WPT.lua"
page_subsets[id_pagesubset.PLAN_REDACT_DRAW_FINALIZE_INSERT_EXIST_WPT] = LockOn_Options.script_path.."ABRIS\\ABRIS_page_PLAN_REDACT_DRAW_FINALIZE_INSERT_EXIST_WPT.lua"
page_subsets[id_pagesubset.PLAN_REDACT_DRAW_FINALIZE_INSERT_EXIST_WPT_ARRAY] = LockOn_Options.script_path.."ABRIS\\ABRIS_page_PLAN_REDACT_DRAW_FINALIZE_INSERT_EXIST_WPT_ARRAY.lua"
page_subsets[id_pagesubset.PLAN_REDACT_DRAW_FINALIZE_INSERT_MOVE] = LockOn_Options.script_path.."ABRIS\\ABRIS_page_PLAN_REDACT_DRAW_FINALIZE_INSERT_MOVE.lua"

page_subsets[id_pagesubset.PLAN_LOAD] 		  = LockOn_Options.script_path.."ABRIS\\ABRIS_page_PLAN_LOAD.lua"
page_subsets[id_pagesubset.PLAN_REMOVE]		  = LockOn_Options.script_path.."ABRIS\\ABRIS_page_PLAN_REMOVE.lua"
page_subsets[id_pagesubset.PLAN_SAVE]		  = LockOn_Options.script_path.."ABRIS\\ABRIS_page_PLAN_SAVE.lua"

page_subsets[id_pagesubset.PLAN_ROUTE_LOADED] = LockOn_Options.script_path.."ABRIS\\ABRIS_page_PLAN_ROUTE_LOADED.lua"
page_subsets[id_pagesubset.PLAN_ROUTE_TEMPLATE]       =  LockOn_Options.script_path.."ABRIS\\ABRIS_page_PLAN_DRAW_TEMPLATE.lua"

page_subsets[id_pagesubset.PLAN_REDACT_SPEED_COMMON]   = LockOn_Options.script_path.."ABRIS\\ABRIS_page_PLAN_REDACT_SPEED_COMMON.lua"
page_subsets[id_pagesubset.PLAN_REDACT_SPEED_TEMPLATE] = LockOn_Options.script_path.."ABRIS\\ABRIS_page_PLAN_SPEED_TEMPLATE.lua"
page_subsets[id_pagesubset.PLAN_REDACT_SPEED]          = LockOn_Options.script_path.."ABRIS\\ABRIS_page_PLAN_REDACT_SPEED.lua"
page_subsets[id_pagesubset.PLAN_REDACT_SPEED_FINALIZE] = LockOn_Options.script_path.."ABRIS\\ABRIS_page_PLAN_REDACT_SPEED_FINALIZE.lua"
--------------------------------
page_subsets[id_pagesubset.PLAN_REDACT_METEO_COMMON]   = LockOn_Options.script_path.."ABRIS\\ABRIS_page_PLAN_REDACT_METEO_COMMON.lua"
page_subsets[id_pagesubset.PLAN_REDACT_METEO_TEMPLATE] = LockOn_Options.script_path.."ABRIS\\ABRIS_page_PLAN_METEO_TEMPLATE.lua"
page_subsets[id_pagesubset.PLAN_REDACT_METEO]          = LockOn_Options.script_path.."ABRIS\\ABRIS_page_PLAN_REDACT_METEO.lua"
page_subsets[id_pagesubset.PLAN_REDACT_METEO_FINALIZE] = LockOn_Options.script_path.."ABRIS\\ABRIS_page_PLAN_REDACT_METEO_FINALIZE.lua"

page_subsets[id_pagesubset.PLAN_REDACT_VNAV_COMMON]   = LockOn_Options.script_path.."ABRIS\\ABRIS_page_PLAN_REDACT_VNAV_COMMON.lua"
page_subsets[id_pagesubset.PLAN_REDACT_VNAV_TEMPLATE] = LockOn_Options.script_path.."ABRIS\\ABRIS_page_PLAN_VNAV_TEMPLATE.lua"
page_subsets[id_pagesubset.PLAN_REDACT_VNAV]          = LockOn_Options.script_path.."ABRIS\\ABRIS_page_PLAN_REDACT_VNAV.lua"
page_subsets[id_pagesubset.PLAN_REDACT_VNAV_FINALIZE] = LockOn_Options.script_path.."ABRIS\\ABRIS_page_PLAN_REDACT_VNAV_FINALIZE.lua"

page_subsets[id_pagesubset.PLAN_REDACT_FUEL_COMMON]   = LockOn_Options.script_path.."ABRIS\\ABRIS_page_PLAN_REDACT_FUEL_COMMON.lua"
page_subsets[id_pagesubset.PLAN_REDACT_FUEL_TEMPLATE] = LockOn_Options.script_path.."ABRIS\\ABRIS_page_PLAN_FUEL_TEMPLATE.lua"
page_subsets[id_pagesubset.PLAN_REDACT_FUEL]          = LockOn_Options.script_path.."ABRIS\\ABRIS_page_PLAN_REDACT_FUEL.lua"
page_subsets[id_pagesubset.PLAN_REDACT_FUEL_FINALIZE] = LockOn_Options.script_path.."ABRIS\\ABRIS_page_PLAN_REDACT_FUEL_FINALIZE.lua"

page_subsets[id_pagesubset.SEARCH_COMMON]			  = LockOn_Options.script_path.."ABRIS\\ABRIS_page_SEARCH_COMMON.lua"
page_subsets[id_pagesubset.PLAN_REDACT_DRAW_SEARCH]	  = LockOn_Options.script_path.."ABRIS\\ABRIS_page_PLAN_REDACT_DRAW_SEARCH.lua"

page_subsets[id_pagesubset.PLAN_REDACT_DRAW_SEARCH_NOT_FOUND] = LockOn_Options.script_path.."ABRIS\\ABRIS_page_PLAN_REDACT_DRAW_SEARCH_NOT_FOUND.lua"
page_subsets[id_pagesubset.PLAN_REDACT_DRAW_SEARCH_NEAREST]   = LockOn_Options.script_path.."ABRIS\\ABRIS_page_PLAN_REDACT_DRAW_SEARCH_NEAREST.lua"


page_subsets[id_pagesubset.NAV_SEARCH_NEAREST_COMMON] 	  = LockOn_Options.script_path.."ABRIS\\ABRIS_page_NAV_SEARCH_NEAREST_COMMON.lua"
page_subsets[id_pagesubset.NAV_SEARCH_NEAREST_AERODROMES] = LockOn_Options.script_path.."ABRIS\\ABRIS_page_NAV_SEARCH_NEAREST_AIRPORT.lua"
page_subsets[id_pagesubset.NAV_SEARCH_NEAREST_VOR] 		  = LockOn_Options.script_path.."ABRIS\\ABRIS_page_NAV_SEARCH_NEAREST_VOR.lua"
page_subsets[id_pagesubset.NAV_SEARCH_NEAREST_OPRS] 	  = LockOn_Options.script_path.."ABRIS\\ABRIS_page_NAV_SEARCH_NEAREST_HOMER.lua"
page_subsets[id_pagesubset.NAV_SEARCH_NEAREST_STP] 		  = LockOn_Options.script_path.."ABRIS\\ABRIS_page_NAV_SEARCH_NEAREST_WAYPOINT.lua"
page_subsets[id_pagesubset.NAV_SEARCH_NEAREST_CITY]		  = LockOn_Options.script_path.."ABRIS\\ABRIS_page_NAV_SEARCH_NEAREST_TOWN.lua"

page_subsets[id_pagesubset.NAV_SEARCH_TEMPLATE_COMMON]    	  = LockOn_Options.script_path.."ABRIS\\ABRIS_page_NAV_SEARCH_COMMON_TEMPLATE.lua"
page_subsets[id_pagesubset.NAV_SEARCH_TEMPLATE_AIRPORT]    	  = LockOn_Options.script_path.."ABRIS\\ABRIS_page_NAV_SEARCH_NEAREST_AIRPORT_TEMPLATE.lua"
page_subsets[id_pagesubset.NAV_SEARCH_TEMPLATE_VOR]    	  = LockOn_Options.script_path.."ABRIS\\ABRIS_page_NAV_SEARCH_NEAREST_VOR_TEMPLATE.lua"
page_subsets[id_pagesubset.NAV_SEARCH_TEMPLATE_OPRS]    	  = LockOn_Options.script_path.."ABRIS\\ABRIS_page_NAV_SEARCH_NEAREST_HOMER_TEMPLATE.lua"
page_subsets[id_pagesubset.NAV_SEARCH_TEMPLATE_STP]    	  = LockOn_Options.script_path.."ABRIS\\ABRIS_page_NAV_SEARCH_NEAREST_WAYPOINT_TEMPLATE.lua"

page_subsets[id_pagesubset.NAV_SEARCH_FIND_BY_NAME]           = LockOn_Options.script_path.."ABRIS\\ABRIS_page_NAV_SEARCH_FIND_BY_NAME_COMMON.lua"
page_subsets[id_pagesubset.NAV_SEARCH_BY_NAME_TEMPLATE_COMMON]= LockOn_Options.script_path.."ABRIS\\ABRIS_page_NAV_SEARCH_BY_NAME_COMMON_TEMPLATE.lua"
page_subsets[id_pagesubset.NAV_SEARCH_BY_NAME_TEMPLATE_AIRPORT]= LockOn_Options.script_path.."ABRIS\\ABRIS_page_NAV_SEARCH_BY_NAME_AIRPORT_TEMPLATE.lua"
page_subsets[id_pagesubset.NAV_SEARCH_BY_NAME_TEMPLATE_VOR]= LockOn_Options.script_path.."ABRIS\\ABRIS_page_NAV_SEARCH_BY_NAME_VOR_TEMPLATE.lua"
page_subsets[id_pagesubset.NAV_SEARCH_BY_NAME_TEMPLATE_OPRS]= LockOn_Options.script_path.."ABRIS\\ABRIS_page_NAV_SEARCH_BY_NAME_HOMMER_TEMPLATE.lua"
page_subsets[id_pagesubset.NAV_SEARCH_BY_NAME_TEMPLATE_STP]= LockOn_Options.script_path.."ABRIS\\ABRIS_page_NAV_SEARCH_BY_NAME_WAYPOINT_TEMPLATE.lua"
page_subsets[id_pagesubset.NAV_SEARCH_FOUNDED_INFO_READY]	  = LockOn_Options.script_path.."ABRIS\\ABRIS_page_NAV_SEARCH_FOUNDED_INFO_READY.lua"

page_subsets[id_pagesubset.NAV_JOURNAL_VNAV] 			  = LockOn_Options.script_path.."ABRIS\\ABRIS_page_NAV_JOURNAL_VNAV.lua"
page_subsets[id_pagesubset.NAV_JOURNAL_VNAV_COMMON] 			  = LockOn_Options.script_path.."ABRIS\\ABRIS_page_NAV_JOURNAL_VNAV_COMMON.lua"
page_subsets[id_pagesubset.NAV_JOURNAL_VNAV_VERTICAL_SPEED_EDIT] = LockOn_Options.script_path.."ABRIS\\ABRIS_page_NAV_JOURNAL_VNAV_VERTICAL_SPEED_EDIT.lua"

page_subsets[id_pagesubset.PLAN_ADDITIONAL_INFO_MAIN]		  = LockOn_Options.script_path.."ABRIS\\ABRIS_page_PLAN_ADDITIONAL_INFO_MAIN.lua"
page_subsets[id_pagesubset.PLAN_ADDITIONAL_INFO_ADD_POINT_LINE]		  = LockOn_Options.script_path.."ABRIS\\ABRIS_page_PLAN_ADDITIONAL_INFO_ADD_POINT_LINE.lua"

page_subsets[id_pagesubset.PLAN_ADDITIONAL_OBJECTS_MODE]	  = LockOn_Options.script_path.."ABRIS\\ABRIS_page_PLAN_ADDITIONAL_OBJECTS_MODE.lua"
page_subsets[id_pagesubset.PLAN_ADDITIONAL_POINTS_MODE]		  = LockOn_Options.script_path.."ABRIS\\ABRIS_page_PLAN_ADDITIONAL_POINTS_MODE.lua"
page_subsets[id_pagesubset.PLAN_ADDITIONAL_LINES_MODE]		  = LockOn_Options.script_path.."ABRIS\\ABRIS_page_PLAN_ADDITIONAL_LINES_MODE.lua"
	
page_subsets[id_pagesubset.PLAN_ADDITIONAL_INFO_POINTS_DIRECT]	    	  = LockOn_Options.script_path.."ABRIS\\ABRIS_page_PLAN_ADDITIONAL_INFO_POINTS_DIRECT.lua"
page_subsets[id_pagesubset.PLAN_ADDITIONAL_INFO_POINTS_RELATIVE]		  = LockOn_Options.script_path.."ABRIS\\ABRIS_page_PLAN_ADDITIONAL_INFO_POINTS_RELATIVE.lua"
page_subsets[id_pagesubset.PLAN_ADDITIONAL_INFO_POINT_EDIT_REMOVE]		  = LockOn_Options.script_path.."ABRIS\\ABRIS_page_PLAN_ADDITIONAL_INFO_POINT_EDIT_REMOVE.lua"
page_subsets[id_pagesubset.PLAN_ADDITIONAL_INFO_POINT_LINE_REMOVE]		  = LockOn_Options.script_path.."ABRIS\\ABRIS_page_PLAN_ADDITIONAL_INFO_POINT_LINE_REMOVE.lua"
page_subsets[id_pagesubset.PLAN_ADDITIONAL_INFO_LINES]			= LockOn_Options.script_path.."ABRIS\\ABRIS_page_PLAN_ADDITIONAL_INFO_LINES.lua"


page_subsets[id_pagesubset.PLAN_ADDITIONALINFO_COLOR_TEMPLATE] = LockOn_Options.script_path.."ABRIS\\ABRIS_page_PLAN_ADDITIONAL_INFO_LINES_COLOR_MENU.lua"

page_subsets[id_pagesubset.SOFTWARE_BSOD]					   = LockOn_Options.script_path.."ABRIS\\ABRIS_page_BSOD.lua"
page_subsets[id_pagesubset.MESSAGES_TEMPLATE]                   = LockOn_Options.script_path.."ABRIS\\ABRIS_page_MESSAGES_TEMPLATE.lua"

page_subsets[id_pagesubset.HARDWARE_BIOS]					    = LockOn_Options.script_path.."ABRIS\\ABRIS_page_BIOS.lua"
----------------------
pages = {}
pages[id_Page.PAGE_MAIN]         ={id_pagesubset.COMMON,id_pagesubset.MAIN}
pages[id_Page.PAGE_SNS_MAIN_MANUAL]     ={id_pagesubset.COMMON,id_pagesubset.SNS_COMMON,id_pagesubset.SNS_MAIN_COMMON,id_pagesubset.SNS_MAIN_MANUAL}
pages[id_Page.PAGE_SNS_MAIN_AUTO]     ={id_pagesubset.COMMON,id_pagesubset.SNS_COMMON,id_pagesubset.SNS_MAIN_COMMON,id_pagesubset.SNS_MAIN_AUTO}
pages[id_Page.PAGE_SNS_CALC]     ={id_pagesubset.COMMON,id_pagesubset.SNS_COMMON,id_pagesubset.SNS_CALC}
pages[id_Page.PAGE_SYST_MAIN]    = {id_pagesubset.COMMON, id_pagesubset.SYST_MAIN_COMMON, id_pagesubset.SYST_COMMON, id_pagesubset.SYST_MAIN}
pages[id_Page.PAGE_SYST_MAIN_MENU]   = {id_pagesubset.COMMON, id_pagesubset.SYST_MAIN_COMMON, id_pagesubset.SYST_COMMON, id_pagesubset.SYST_MAIN_MENU}
pages[id_Page.PAGE_NAV_MAIN]     ={id_pagesubset.COMMON,id_pagesubset.NAV_MAIN}
pages[id_Page.PAGE_NAV_MAP]      ={id_pagesubset.COMMON,id_pagesubset.NAV_MAP}
pages[id_Page.PAGE_NAV_JOURNAL]  ={id_pagesubset.COMMON,id_pagesubset.NAV_JOURNAL}
pages[id_Page.PAGE_NAV_SEARCH]   ={id_pagesubset.COMMON,id_pagesubset.NAV_SEARCH}


pages[id_Page.PAGE_NAV_SEARCH_NEAREST_AERODROMES] = {id_pagesubset.COMMON,id_pagesubset.NAV_SEARCH_NEAREST_COMMON,id_pagesubset.NAV_SEARCH_NEAREST_AERODROMES}
pages[id_Page.PAGE_NAV_SEARCH_NEAREST_VOR]        = {id_pagesubset.COMMON,id_pagesubset.NAV_SEARCH_NEAREST_COMMON,id_pagesubset.NAV_SEARCH_NEAREST_VOR}
pages[id_Page.PAGE_NAV_SEARCH_NEAREST_OPRS]       = {id_pagesubset.COMMON,id_pagesubset.NAV_SEARCH_NEAREST_COMMON,id_pagesubset.NAV_SEARCH_NEAREST_OPRS}
pages[id_Page.PAGE_NAV_SEARCH_NEAREST_STP]        = {id_pagesubset.COMMON,id_pagesubset.NAV_SEARCH_NEAREST_COMMON,id_pagesubset.NAV_SEARCH_NEAREST_STP}
pages[id_Page.PAGE_NAV_SEARCH_NEAREST_CITY]       = {id_pagesubset.COMMON,id_pagesubset.NAV_SEARCH_NEAREST_COMMON,id_pagesubset.NAV_SEARCH_NEAREST_CITY}
pages[id_Page.PAGE_NAV_SEARCH_FIND_BY_NAME]       = {id_pagesubset.COMMON,id_pagesubset.SEARCH_COMMON,id_pagesubset.NAV_SEARCH_FIND_BY_NAME}
pages[id_Page.PAGE_NAV_SEARCH_FOUNDED_INFO_READY] = {id_pagesubset.COMMON,id_pagesubset.NAV_SEARCH_FOUNDED_INFO_READY}


pages[id_Page.PAGE_NAV_HSI]      = {id_pagesubset.COMMON,id_pagesubset.NAV_HSI}
pages[id_Page.PAGE_NAV_REVIEW]	 = {id_pagesubset.COMMON,id_pagesubset.NAV_REVIEW} 
pages[id_Page.PAGE_OPTIONS_MAIN]	    = {id_pagesubset.COMMON,id_pagesubset.OPTIONS_MAIN,id_pagesubset.OPTIONS_COMMON,id_pagesubset.OPTIONS_CHANGE}
pages[id_Page.PAGE_OPTIONS_MAIN_EDIT]	= {id_pagesubset.COMMON,id_pagesubset.OPTIONS_MAIN,id_pagesubset.OPTIONS_COMMON,id_pagesubset.OPTIONS_EDIT}
pages[id_Page.PAGE_OPTIONS_MEASUREMENTS]= {id_pagesubset.COMMON,id_pagesubset.OPTIONS_MEASUREMENTS,id_pagesubset.OPTIONS_COMMON,id_pagesubset.OPTIONS_CHANGE}
pages[id_Page.PAGE_OPTIONS_PERFOMANCE]  = {id_pagesubset.COMMON,id_pagesubset.OPTIONS_PERFOMANCE,id_pagesubset.OPTIONS_COMMON,id_pagesubset.OPTIONS_CHANGE}
pages[id_Page.PAGE_OPTIONS_SIGNALS]     = {id_pagesubset.COMMON,id_pagesubset.OPTIONS_SIGNALS,id_pagesubset.OPTIONS_COMMON,id_pagesubset.OPTIONS_CHANGE}
pages[id_Page.PAGE_OPTIONS_CHARTS]      = {id_pagesubset.COMMON,id_pagesubset.OPTIONS_CHARTS,id_pagesubset.OPTIONS_COMMON,id_pagesubset.OPTIONS_CHANGE}

pages[id_Page.PAGE_CONTROLS_MESSAGES]   		= {id_pagesubset.COMMON,id_pagesubset.CONTROLS_COMMON,id_pagesubset.CONTROLS_MESSAGES}
pages[id_Page.PAGE_CONTROLS_DATABANK]			= {id_pagesubset.COMMON,id_pagesubset.CONTROLS_COMMON,id_pagesubset.CONTROLS_DATABANK_COMMON,id_pagesubset.CONTROLS_DATABANK}
pages[id_Page.PAGE_CONTROLS_DATABANK_LOADER]	= {id_pagesubset.COMMON,id_pagesubset.CONTROLS_COMMON,id_pagesubset.CONTROLS_DATABANK_COMMON,id_pagesubset.CONTROLS_DATABANK_LOADER}
pages[id_Page.PAGE_CONTROLS_DATABANK_STORAGE]	= {id_pagesubset.COMMON,id_pagesubset.CONTROLS_COMMON,id_pagesubset.CONTROLS_DATABANK_COMMON,id_pagesubset.CONTROLS_DATABANK_STORAGE}
pages[id_Page.PAGE_CONTROLS_K041]				= {id_pagesubset.COMMON,id_pagesubset.CONTROLS_COMMON,id_pagesubset.CONTROLS_K041_COMMON,id_pagesubset.CONTROLS_K041}
pages[id_Page.PAGE_CONTROLS_K041_MENU]			= {id_pagesubset.COMMON,id_pagesubset.CONTROLS_COMMON,id_pagesubset.CONTROLS_K041_COMMON,id_pagesubset.CONTROLS_K041_MENU}

pages[id_Page.PAGE_SYST_SNS] = {id_pagesubset.COMMON,id_pagesubset.SYST_SNS,id_pagesubset.SYST_COMMON}
pages[id_Page.PAGE_SYST_SNS_SELECT] = {id_pagesubset.COMMON,id_pagesubset.SYST_SNS,id_pagesubset.SYST_SELECT,id_pagesubset.SYST_COMMON}
pages[id_Page.PAGE_SYST_SNS_EDIT] = {id_pagesubset.COMMON,id_pagesubset.SYST_SNS,id_pagesubset.SYST_EDIT,id_pagesubset.SYST_COMMON}
pages[id_Page.PAGE_SYST_SNS_START_TEST] = {id_pagesubset.COMMON,id_pagesubset.SYST_SNS,id_pagesubset.SYST_SNS_START_TEST,id_pagesubset.SYST_COMMON}
pages[id_Page.PAGE_SYST_SNS_STOP_TEST] = {id_pagesubset.COMMON,id_pagesubset.SYST_SNS,id_pagesubset.SYST_SNS_STOP_TEST,id_pagesubset.SYST_COMMON}

pages[id_Page.PAGE_NAV_MAP_INFO_STBY]   = {id_pagesubset.COMMON,id_pagesubset.NAV_MAP_COMMON,id_pagesubset.NAV_MAP_INFO_STBY}
pages[id_Page.PAGE_NAV_MAP_INFO_READY]  = {id_pagesubset.COMMON,id_pagesubset.NAV_MAP_COMMON,id_pagesubset.NAV_MAP_INFO_READY}
pages[id_Page.PAGE_NAV_MAP_MEASURE]     = {id_pagesubset.COMMON,id_pagesubset.NAV_MAP_COMMON,id_pagesubset.NAV_MAP_MEASURE}
pages[id_Page.PAGE_NAV_MAP_MARKER]      = {id_pagesubset.COMMON,id_pagesubset.NAV_MAP_COMMON,id_pagesubset.NAV_MAP_MARKER}

pages[id_Page.PAGE_PLAN_MAIN]   				 						= {id_pagesubset.COMMON, id_pagesubset.PLAN_COMMON_MODE, id_pagesubset.PLAN_COMMON,id_pagesubset.PLAN_MAIN}
pages[id_Page.PAGE_PLAN_DRAW]    				 						= {id_pagesubset.COMMON,id_pagesubset.PLAN_COMMON_MODE,id_pagesubset.PLAN_COMMON,id_pagesubset.PLAN_DRAW_COMMON,id_pagesubset.PLAN_DRAW}
pages[id_Page.PAGE_PLAN_DRAW_INSERT]			 						= {id_pagesubset.COMMON,id_pagesubset.PLAN_COMMON_MODE,id_pagesubset.PLAN_COMMON,id_pagesubset.PLAN_DRAW_COMMON,id_pagesubset.PLAN_DRAW_INSERT}
pages[id_Page.PAGE_PLAN_REDACT_DRAW_FINALIZE_INSERT]    				= {id_pagesubset.COMMON,id_pagesubset.PLAN_COMMON_MODE,id_pagesubset.PLAN_COMMON,id_pagesubset.PLAN_REDACT_DRAW_FINALIZE_INSERT_NEW_WPT        ,id_pagesubset.PLAN_REDACT_DRAW_FINALIZE_INSERT_COMMON,id_pagesubset.PLAN_DRAW_COMMON,}
pages[id_Page.PAGE_PLAN_REDACT_DRAW_FINALIZE_INSERT_EXIST_WPT]    		= {id_pagesubset.COMMON,id_pagesubset.PLAN_COMMON_MODE,id_pagesubset.PLAN_COMMON,id_pagesubset.PLAN_REDACT_DRAW_FINALIZE_INSERT_EXIST_WPT      ,id_pagesubset.PLAN_REDACT_DRAW_FINALIZE_INSERT_COMMON,id_pagesubset.PLAN_DRAW_COMMON,}
pages[id_Page.PAGE_PLAN_REDACT_DRAW_FINALIZE_INSERT_EXIST_WPT_ARRAY]    = {id_pagesubset.COMMON,id_pagesubset.PLAN_COMMON_MODE,id_pagesubset.PLAN_COMMON,id_pagesubset.PLAN_REDACT_DRAW_FINALIZE_INSERT_EXIST_WPT_ARRAY,id_pagesubset.PLAN_REDACT_DRAW_FINALIZE_INSERT_COMMON,id_pagesubset.PLAN_DRAW_COMMON,}
pages[id_Page.PAGE_PLAN_REDACT_DRAW_FINALIZE_INSERT_MOVE]				= {id_pagesubset.COMMON,id_pagesubset.PLAN_COMMON_MODE,id_pagesubset.PLAN_COMMON,id_pagesubset.PLAN_REDACT_DRAW_FINALIZE_INSERT_MOVE           ,id_pagesubset.PLAN_DRAW_COMMON}
pages[id_Page.PAGE_PLAN_REDACT_DRAW_SEARCH]			    				= {id_pagesubset.COMMON,id_pagesubset.PLAN_COMMON,id_pagesubset.SEARCH_COMMON,id_pagesubset.PLAN_REDACT_DRAW_SEARCH}

pages[id_Page.PAGE_PLAN_REDACT_DRAW_SEARCH_NOT_FOUND]		= {id_pagesubset.COMMON,id_pagesubset.PLAN_COMMON,id_pagesubset.PLAN_REDACT_DRAW_SEARCH_NOT_FOUND,id_pagesubset.PLAN_DRAW_COMMON}
pages[id_Page.PAGE_PLAN_REDACT_DRAW_SEARCH_NEAREST]			= {id_pagesubset.COMMON,id_pagesubset.PLAN_COMMON,id_pagesubset.PLAN_REDACT_DRAW_SEARCH_NOT_FOUND,id_pagesubset.SEARCH_COMMON}


pages[id_Page.PAGE_PLAN_REDACT_SPEED]            ={id_pagesubset.COMMON,id_pagesubset.PLAN_COMMON_MODE,id_pagesubset.PLAN_COMMON,id_pagesubset.PLAN_REDACT_SPEED_COMMON,id_pagesubset.PLAN_REDACT_SPEED}
pages[id_Page.PAGE_PLAN_REDACT_SPEED_FINALIZE]   ={id_pagesubset.COMMON,id_pagesubset.PLAN_COMMON_MODE,id_pagesubset.PLAN_COMMON,id_pagesubset.PLAN_REDACT_SPEED_FINALIZE,id_pagesubset.PLAN_REDACT_SPEED_COMMON}
---
pages[id_Page.PAGE_PLAN_REDACT_METEO]            ={id_pagesubset.COMMON,id_pagesubset.PLAN_COMMON_MODE,id_pagesubset.PLAN_COMMON,id_pagesubset.PLAN_REDACT_METEO_COMMON,id_pagesubset.PLAN_REDACT_METEO}
pages[id_Page.PAGE_PLAN_REDACT_METEO_FINALIZE]   ={id_pagesubset.COMMON,id_pagesubset.PLAN_COMMON_MODE,id_pagesubset.PLAN_COMMON,id_pagesubset.PLAN_REDACT_METEO_FINALIZE,id_pagesubset.PLAN_REDACT_METEO_COMMON}

pages[id_Page.PAGE_PLAN_REDACT_VNAV]            ={id_pagesubset.COMMON,id_pagesubset.PLAN_COMMON_MODE,id_pagesubset.PLAN_COMMON,id_pagesubset.PLAN_REDACT_VNAV_COMMON,id_pagesubset.PLAN_REDACT_VNAV}
pages[id_Page.PAGE_PLAN_REDACT_VNAV_FINALIZE]   ={id_pagesubset.COMMON,id_pagesubset.PLAN_COMMON_MODE,id_pagesubset.PLAN_COMMON,id_pagesubset.PLAN_REDACT_VNAV_FINALIZE,id_pagesubset.PLAN_REDACT_VNAV_COMMON}

pages[id_Page.PAGE_PLAN_REDACT_FUEL]            ={id_pagesubset.COMMON,id_pagesubset.PLAN_COMMON_MODE,id_pagesubset.PLAN_COMMON,id_pagesubset.PLAN_REDACT_FUEL_COMMON,id_pagesubset.PLAN_REDACT_FUEL}
pages[id_Page.PAGE_PLAN_REDACT_FUEL_FINALIZE]   ={id_pagesubset.COMMON,id_pagesubset.PLAN_COMMON_MODE,id_pagesubset.PLAN_COMMON,id_pagesubset.PLAN_REDACT_FUEL_FINALIZE,id_pagesubset.PLAN_REDACT_FUEL_COMMON}

pages[id_Page.PAGE_NAV_JOURNAL_VNAV]            	 ={id_pagesubset.COMMON, id_pagesubset.NAV_JOURNAL_VNAV_COMMON, id_pagesubset.PLAN_REDACT_VNAV_COMMON, id_pagesubset.NAV_JOURNAL_VNAV}
pages[id_Page.PAGE_NAV_JOURNAL_VERTICAL_SPEED_EDIT]  ={id_pagesubset.COMMON, id_pagesubset.NAV_JOURNAL_VNAV_COMMON, id_pagesubset.NAV_JOURNAL_VNAV_VERTICAL_SPEED_EDIT, id_pagesubset.PLAN_REDACT_VNAV_COMMON}
pages[id_Page.PAGE_NAV_JOURNAL_VNAV_EDIT]  			 ={id_pagesubset.COMMON, id_pagesubset.NAV_JOURNAL_VNAV_COMMON, id_pagesubset.PLAN_REDACT_VNAV_FINALIZE, id_pagesubset.PLAN_REDACT_VNAV_COMMON}


pages[id_Page.PAGE_PLAN_LOAD]    		 ={id_pagesubset.COMMON,id_pagesubset.PLAN_LOAD}
pages[id_Page.PAGE_PLAN_REMOVE]    		 ={id_pagesubset.COMMON,id_pagesubset.PLAN_REMOVE}
pages[id_Page.PAGE_PLAN_SAVE]    		 ={id_pagesubset.COMMON,id_pagesubset.PLAN_COMMON_MODE,id_pagesubset.PLAN_COMMON,id_pagesubset.PLAN_SAVE}

pages[id_Page.PAGE_PLAN_ROUTE_LOADED]    ={id_pagesubset.COMMON,id_pagesubset.PLAN_COMMON_MODE,id_pagesubset.PLAN_COMMON,id_pagesubset.PLAN_ROUTE_LOADED}

pages[id_Page.PAGE_PLAN_ADDITIONAL_INFO_MAIN] 				= {id_pagesubset.COMMON,id_pagesubset.PLAN_COMMON,id_pagesubset.PLAN_ADDITIONAL_OBJECTS_MODE,id_pagesubset.PLAN_ADDITIONAL_INFO_MAIN,id_pagesubset.PLAN_ADDITIONAL_INFO_ADD_POINT_LINE}
pages[id_Page.PAGE_PLAN_ADDITIONAL_INFO_POINTS_DIRECT]		= {id_pagesubset.COMMON,id_pagesubset.PLAN_COMMON,id_pagesubset.PLAN_ADDITIONAL_POINTS_MODE,id_pagesubset.PLAN_ADDITIONAL_INFO_POINTS_DIRECT}
pages[id_Page.PAGE_PLAN_ADDITIONAL_INFO_POINTS_RELATIVE]	= {id_pagesubset.COMMON,id_pagesubset.PLAN_COMMON,id_pagesubset.PLAN_ADDITIONAL_POINTS_MODE,id_pagesubset.PLAN_ADDITIONAL_INFO_POINTS_RELATIVE}
pages[id_Page.PAGE_PLAN_ADDITIONAL_INFO_POINT_EDIT_REMOVE]	= {id_pagesubset.COMMON,id_pagesubset.PLAN_COMMON,id_pagesubset.PLAN_ADDITIONAL_POINTS_MODE,id_pagesubset.PLAN_ADDITIONAL_INFO_MAIN,id_pagesubset.PLAN_ADDITIONAL_INFO_POINT_EDIT_REMOVE}
pages[id_Page.PAGE_PLAN_ADDITIONAL_INFO_POINT_REMOVE]	= {id_pagesubset.COMMON,id_pagesubset.PLAN_COMMON,id_pagesubset.PLAN_ADDITIONAL_POINTS_MODE, id_pagesubset.PLAN_ADDITIONAL_INFO_MAIN, id_pagesubset.PLAN_ADDITIONAL_INFO_POINT_LINE_REMOVE}
pages[id_Page.PAGE_PLAN_ADDITIONAL_INFO_LINES]		  	= {id_pagesubset.COMMON,id_pagesubset.PLAN_COMMON,id_pagesubset.PLAN_ADDITIONAL_LINES_MODE, id_pagesubset.PLAN_ADDITIONAL_INFO_LINES}
pages[id_Page.PAGE_PLAN_ADDITIONAL_INFO_LINE_REMOVE]	= {id_pagesubset.COMMON,id_pagesubset.PLAN_COMMON,id_pagesubset.PLAN_ADDITIONAL_LINES_MODE, id_pagesubset.PLAN_ADDITIONAL_INFO_MAIN, id_pagesubset.PLAN_ADDITIONAL_INFO_POINT_LINE_REMOVE}


pages[id_Page.PAGE_BSOD]							  = {id_pagesubset.SOFTWARE_BSOD}
pages[id_Page.PAGE_BIOS]							  = {id_pagesubset.HARDWARE_BIOS}

init_pageID     = id_Page.PAGE_BIOS
use_parser      = false

function clear_mode_table(table_mode)
	for master = 1,9 do
		table_mode[master] = {}
		for level_2 = 1,30 do
			table_mode[master][level_2] = {}
			for level_3 = 1,30 do
				table_mode[master][level_2][level_3] = {}
			end 
		end 
	end 
	return
end

pages_by_mode = {}
clear_mode_table(pages_by_mode)

pages_by_mode[ABRIS_MENU][ABRIS_SUBMODE_NONE][ABRIS_SUBMODE_NONE][ABRIS_SUBMODE_NONE]      = id_Page.PAGE_MAIN


pages_by_mode[ABRIS_OPTIONS][ABRIS_SUBMODE_NONE]        [ABRIS_SUBMODE_NONE][ABRIS_SUBMODE_NONE]   = id_Page.PAGE_OPTIONS_MAIN

pages_by_mode[ABRIS_OPTIONS][ABRIS_OPTIONS_MAIN]        [ABRIS_SUBMODE_NONE][ABRIS_SUBMODE_NONE]   = id_Page.PAGE_OPTIONS_MAIN
pages_by_mode[ABRIS_OPTIONS][ABRIS_OPTIONS_MEASUREMENTS][ABRIS_SUBMODE_NONE][ABRIS_SUBMODE_NONE]   = id_Page.PAGE_OPTIONS_MEASUREMENTS
pages_by_mode[ABRIS_OPTIONS][ABRIS_OPTIONS_PERFOMANCE]  [ABRIS_SUBMODE_NONE][ABRIS_SUBMODE_NONE]   = id_Page.PAGE_OPTIONS_PERFOMANCE
pages_by_mode[ABRIS_OPTIONS][ABRIS_OPTIONS_SIGNALS]     [ABRIS_SUBMODE_NONE][ABRIS_SUBMODE_NONE]   = id_Page.PAGE_OPTIONS_SIGNALS
pages_by_mode[ABRIS_OPTIONS][ABRIS_OPTIONS_CHARTS]      [ABRIS_SUBMODE_NONE][ABRIS_SUBMODE_NONE]   = id_Page.PAGE_OPTIONS_CHARTS

pages_by_mode[ABRIS_OPTIONS][ABRIS_OPTIONS_MAIN][ABRIS_OPTIONS_EDIT][ABRIS_SUBMODE_NONE] = id_Page.PAGE_OPTIONS_MAIN_EDIT

pages_by_mode[ABRIS_SYST][ABRIS_SUBMODE_NONE]   [ABRIS_SUBMODE_NONE][ABRIS_SUBMODE_NONE]   = id_Page.PAGE_SYST_MAIN
pages_by_mode[ABRIS_SYST][ABRIS_SYST_MAIN_MENU]   [ABRIS_SUBMODE_NONE][ABRIS_SUBMODE_NONE]   = id_Page.PAGE_SYST_MAIN_MENU
pages_by_mode[ABRIS_SYST][ABRIS_SYST_SNS]       [ABRIS_SUBMODE_NONE][ABRIS_SUBMODE_NONE]   = id_Page.PAGE_SYST_SNS_SELECT
pages_by_mode[ABRIS_SYST][ABRIS_SYST_SNS]       [ABRIS_SYST_SNS_EDIT][ABRIS_SUBMODE_NONE]   = id_Page.PAGE_SYST_SNS_EDIT
pages_by_mode[ABRIS_SYST][ABRIS_SYST_SNS]       [ABRIS_SYST_SNS_START_TEST][ABRIS_SUBMODE_NONE]   = id_Page.PAGE_SYST_SNS_START_TEST
pages_by_mode[ABRIS_SYST][ABRIS_SYST_SNS]       [ABRIS_SYST_SNS_STOP_TEST][ABRIS_SUBMODE_NONE]   = id_Page.PAGE_SYST_SNS_STOP_TEST

pages_by_mode[ABRIS_CONTROLS][ABRIS_CONTROLS_DATABANK]  [ABRIS_SUBMODE_NONE][ABRIS_SUBMODE_NONE]   = id_Page.PAGE_CONTROLS_DATABANK
pages_by_mode[ABRIS_CONTROLS][ABRIS_CONTROLS_DATABANK]  [ABRIS_CONTROLS_DATABANK_ONBOARD_LOADER][ABRIS_SUBMODE_NONE]   = id_Page.PAGE_CONTROLS_DATABANK_LOADER
pages_by_mode[ABRIS_CONTROLS][ABRIS_CONTROLS_DATABANK]  [ABRIS_CONTROLS_DATABANK_ONBOARD_STORAGE][ABRIS_SUBMODE_NONE]   = id_Page.PAGE_CONTROLS_DATABANK_STORAGE
pages_by_mode[ABRIS_CONTROLS][ABRIS_CONTROLS_K_041]     [ABRIS_SUBMODE_NONE][ABRIS_SUBMODE_NONE]   = id_Page.PAGE_CONTROLS_K041
pages_by_mode[ABRIS_CONTROLS][ABRIS_CONTROLS_K_041]		[ABRIS_CONTROLS_K_041_MENU][ABRIS_SUBMODE_NONE]   = id_Page.PAGE_CONTROLS_K041_MENU
pages_by_mode[ABRIS_CONTROLS][ABRIS_CONTROLS_MESSAGES]  [ABRIS_SUBMODE_NONE][ABRIS_SUBMODE_NONE]   = id_Page.PAGE_CONTROLS_MESSAGES

pages_by_mode[ABRIS_NAV][ABRIS_SUBMODE_NONE][ABRIS_SUBMODE_NONE][ABRIS_SUBMODE_NONE]    = id_Page.PAGE_NAV_MAIN
pages_by_mode[ABRIS_NAV][ABRIS_NAV_HSI]     [ABRIS_SUBMODE_NONE][ABRIS_SUBMODE_NONE]    = id_Page.PAGE_NAV_HSI
pages_by_mode[ABRIS_NAV][ABRIS_NAV_JOURNAL] [ABRIS_SUBMODE_NONE][ABRIS_SUBMODE_NONE]    = id_Page.PAGE_NAV_JOURNAL
pages_by_mode[ABRIS_NAV][ABRIS_NAV_SEARCH]  [ABRIS_SUBMODE_NONE][ABRIS_SUBMODE_NONE]    = id_Page.PAGE_NAV_SEARCH


pages_by_mode[ABRIS_NAV][ABRIS_NAV_SEARCH][ABRIS_NAV_SEARCH_FIND_NEAREST][NAV_SEARCH_AERODROMES] = id_Page.PAGE_NAV_SEARCH_NEAREST_AERODROMES
pages_by_mode[ABRIS_NAV][ABRIS_NAV_SEARCH][ABRIS_NAV_SEARCH_FIND_NEAREST][NAV_SEARCH_VOR]        = id_Page.PAGE_NAV_SEARCH_NEAREST_VOR
pages_by_mode[ABRIS_NAV][ABRIS_NAV_SEARCH][ABRIS_NAV_SEARCH_FIND_NEAREST][NAV_SEARCH_OPRS]       = id_Page.PAGE_NAV_SEARCH_NEAREST_OPRS
pages_by_mode[ABRIS_NAV][ABRIS_NAV_SEARCH][ABRIS_NAV_SEARCH_FIND_NEAREST][NAV_SEARCH_STP]        = id_Page.PAGE_NAV_SEARCH_NEAREST_STP
pages_by_mode[ABRIS_NAV][ABRIS_NAV_SEARCH][ABRIS_NAV_SEARCH_FIND_NEAREST][NAV_SEARCH_CITY]       = id_Page.PAGE_NAV_SEARCH_NEAREST_CITY

pages_by_mode[ABRIS_NAV][ABRIS_NAV_SEARCH][ABRIS_NAV_SEARCH_FIND_BY_NAME][NAV_SEARCH_AERODROMES] = id_Page.PAGE_NAV_SEARCH_FIND_BY_NAME
pages_by_mode[ABRIS_NAV][ABRIS_NAV_SEARCH][ABRIS_NAV_SEARCH_FIND_BY_NAME][NAV_SEARCH_VOR] 		 = id_Page.PAGE_NAV_SEARCH_FIND_BY_NAME
pages_by_mode[ABRIS_NAV][ABRIS_NAV_SEARCH][ABRIS_NAV_SEARCH_FIND_BY_NAME][NAV_SEARCH_OPRS] 		 = id_Page.PAGE_NAV_SEARCH_FIND_BY_NAME
pages_by_mode[ABRIS_NAV][ABRIS_NAV_SEARCH][ABRIS_NAV_SEARCH_FIND_BY_NAME][NAV_SEARCH_STP] 		 = id_Page.PAGE_NAV_SEARCH_FIND_BY_NAME
pages_by_mode[ABRIS_NAV][ABRIS_NAV_SEARCH][ABRIS_NAV_SEARCH_FIND_BY_NAME][NAV_SEARCH_CITY]       = id_Page.PAGE_NAV_SEARCH_FIND_BY_NAME

pages_by_mode[ABRIS_NAV][ABRIS_NAV_SEARCH][ABRIS_NAV_SEARCH_FIND_NEAREST][ABRIS_NAV_SEARCH_FOUNDED_INFO_READY]  = id_Page.PAGE_NAV_SEARCH_FOUNDED_INFO_READY
pages_by_mode[ABRIS_NAV][ABRIS_NAV_SEARCH][ABRIS_NAV_SEARCH_FIND_BY_NAME][ABRIS_NAV_SEARCH_FOUNDED_INFO_READY]  = id_Page.PAGE_NAV_SEARCH_FOUNDED_INFO_READY

pages_by_mode[ABRIS_NAV][ABRIS_NAV_MAP]     [ABRIS_SUBMODE_NONE]	    [ABRIS_SUBMODE_NONE]    = id_Page.PAGE_NAV_MAP
pages_by_mode[ABRIS_NAV][ABRIS_NAV_MAP]     [ABRIS_NAV_MAP_INFO_STDBY]  [ABRIS_SUBMODE_NONE]    = id_Page.PAGE_NAV_MAP_INFO_STBY  
pages_by_mode[ABRIS_NAV][ABRIS_NAV_MAP]     [ABRIS_NAV_MAP_INFO_READY]  [ABRIS_SUBMODE_NONE]    = id_Page.PAGE_NAV_MAP_INFO_READY
pages_by_mode[ABRIS_NAV][ABRIS_NAV_MAP]     [ABRIS_NAV_MAP_MEASURE]     [ABRIS_SUBMODE_NONE]    = id_Page.PAGE_NAV_MAP_MEASURE
pages_by_mode[ABRIS_NAV][ABRIS_NAV_MAP]     [ABRIS_NAV_MAP_MARKER]      [ABRIS_SUBMODE_NONE]    = id_Page.PAGE_NAV_MAP_MARKER
pages_by_mode[ABRIS_NAV][ABRIS_NAV_REVIEW]  [ABRIS_SUBMODE_NONE]		[ABRIS_SUBMODE_NONE]    = id_Page.PAGE_NAV_REVIEW

pages_by_mode[ABRIS_NAV][ABRIS_NAV_JOURNAL]  [ABRIS_NAV_JOURNAL_VNAV]		[ABRIS_SUBMODE_NONE]    					= id_Page.PAGE_NAV_JOURNAL_VNAV
pages_by_mode[ABRIS_NAV][ABRIS_NAV_JOURNAL]  [ABRIS_NAV_JOURNAL_VNAV]		[ABRIS_NAV_JOURNAL_VERTICAL_SPEED_EDIT]    	= id_Page.PAGE_NAV_JOURNAL_VERTICAL_SPEED_EDIT
pages_by_mode[ABRIS_NAV][ABRIS_NAV_JOURNAL]  [ABRIS_NAV_JOURNAL_VNAV]		[ABRIS_NAV_JOURNAL_VNAV_EDIT]    			= id_Page.PAGE_NAV_JOURNAL_VNAV_EDIT

pages_by_mode[ABRIS_PLAN][ABRIS_SUBMODE_NONE]		[ABRIS_SUBMODE_NONE]	[ABRIS_SUBMODE_NONE]       					= id_Page.PAGE_PLAN_MAIN
pages_by_mode[ABRIS_PLAN][ABRIS_PLAN_ROUTE_LOADED]  [ABRIS_SUBMODE_NONE]	[ABRIS_SUBMODE_NONE]            			= id_Page.PAGE_PLAN_ROUTE_LOADED
pages_by_mode[ABRIS_PLAN][ABRIS_PLAN_LOAD]  		[ABRIS_SUBMODE_NONE]	[ABRIS_SUBMODE_NONE]             			= id_Page.PAGE_PLAN_LOAD
pages_by_mode[ABRIS_PLAN][ABRIS_PLAN_REDACT]		[ABRIS_SUBMODE_NONE]	[ABRIS_SUBMODE_NONE]         	 			= id_Page.PAGE_PLAN_DRAW
pages_by_mode[ABRIS_PLAN][ABRIS_PLAN_REDACT]		[ABRIS_PLAN_REDACT_DRAW][ABRIS_SUBMODE_NONE]			 			= id_Page.PAGE_PLAN_DRAW
pages_by_mode[ABRIS_PLAN][ABRIS_PLAN_REDACT]		[ABRIS_PLAN_REDACT_DRAW][ABRIS_PLAN_REDACT_DRAW_INSERT]  			= id_Page.PAGE_PLAN_DRAW_INSERT
pages_by_mode[ABRIS_PLAN][ABRIS_PLAN_REDACT]		[ABRIS_PLAN_REDACT_DRAW][ABRIS_PLAN_REDACT_DRAW_MOVE]  				= id_Page.PAGE_PLAN_REDACT_DRAW_FINALIZE_INSERT_MOVE
pages_by_mode[ABRIS_PLAN][ABRIS_PLAN_REDACT]		[ABRIS_PLAN_REDACT_DRAW][ABRIS_PLAN_REDACT_DRAW_FINALIZE_INSERT]	= id_Page.PAGE_PLAN_REDACT_DRAW_FINALIZE_INSERT
pages_by_mode[ABRIS_PLAN][ABRIS_PLAN_REDACT]		[ABRIS_PLAN_REDACT_DRAW][ABRIS_PLAN_REDACT_DRAW_FINALIZE_INSERT_EXIST_WPT] = id_Page.PAGE_PLAN_REDACT_DRAW_FINALIZE_INSERT_EXIST_WPT
pages_by_mode[ABRIS_PLAN][ABRIS_PLAN_REDACT]		[ABRIS_PLAN_REDACT_DRAW][ABRIS_PLAN_REDACT_DRAW_FINALIZE_INSERT_EXIST_WPT_ARRAY] = id_Page.PAGE_PLAN_REDACT_DRAW_FINALIZE_INSERT_EXIST_WPT_ARRAY
pages_by_mode[ABRIS_PLAN][ABRIS_PLAN_REDACT]		[ABRIS_PLAN_REDACT_DRAW][ABRIS_PLAN_REDACT_DRAW_SEARCH]  		   = id_Page.PAGE_PLAN_REDACT_DRAW_SEARCH
pages_by_mode[ABRIS_PLAN][ABRIS_PLAN_REDACT]		[ABRIS_PLAN_REDACT_DRAW][ABRIS_PLAN_REDACT_DRAW_SEARCH_NOT_FOUND]  = id_Page.PAGE_PLAN_REDACT_DRAW_SEARCH_NOT_FOUND
pages_by_mode[ABRIS_PLAN][ABRIS_PLAN_REDACT]		[ABRIS_PLAN_REDACT_DRAW][ABRIS_PLAN_REDACT_DRAW_SEARCH_NEAREST]    = id_Page.PAGE_PLAN_REDACT_DRAW_SEARCH_NEAREST

pages_by_mode[ABRIS_PLAN][ABRIS_PLAN_REDACT]		[ABRIS_PLAN_REDACT_SPEED][ABRIS_SUBMODE_NONE]  					= id_Page.PAGE_PLAN_REDACT_SPEED
pages_by_mode[ABRIS_PLAN][ABRIS_PLAN_REDACT]		[ABRIS_PLAN_REDACT_SPEED][ABRIS_PLAN_REDACT_SPEED_FINALIZE]		= id_Page.PAGE_PLAN_REDACT_SPEED_FINALIZE

pages_by_mode[ABRIS_PLAN][ABRIS_PLAN_REDACT]		[ABRIS_PLAN_REDACT_METEO][ABRIS_SUBMODE_NONE]  					= id_Page.PAGE_PLAN_REDACT_METEO
pages_by_mode[ABRIS_PLAN][ABRIS_PLAN_REDACT]		[ABRIS_PLAN_REDACT_METEO][ABRIS_PLAN_REDACT_METEO_FINALIZE]		= id_Page.PAGE_PLAN_REDACT_METEO_FINALIZE

pages_by_mode[ABRIS_PLAN][ABRIS_PLAN_REDACT]		[ABRIS_PLAN_REDACT_VNAV][ABRIS_SUBMODE_NONE]  					= id_Page.PAGE_PLAN_REDACT_VNAV
pages_by_mode[ABRIS_PLAN][ABRIS_PLAN_REDACT]		[ABRIS_PLAN_REDACT_VNAV][ABRIS_PLAN_REDACT_VNAV_FINALIZE]		= id_Page.PAGE_PLAN_REDACT_VNAV_FINALIZE

pages_by_mode[ABRIS_PLAN][ABRIS_PLAN_REDACT]		[ABRIS_PLAN_REDACT_FUEL][ABRIS_SUBMODE_NONE]  					= id_Page.PAGE_PLAN_REDACT_FUEL
pages_by_mode[ABRIS_PLAN][ABRIS_PLAN_REDACT]		[ABRIS_PLAN_REDACT_FUEL][ABRIS_PLAN_REDACT_FUEL_FINALIZE]		= id_Page.PAGE_PLAN_REDACT_FUEL_FINALIZE


pages_by_mode[ABRIS_PLAN][ABRIS_PLAN_SAVE]  		[ABRIS_SUBMODE_NONE]	[ABRIS_SUBMODE_NONE]          	 = id_Page.PAGE_PLAN_SAVE
pages_by_mode[ABRIS_PLAN][ABRIS_PLAN_CLEAN] 		[ABRIS_SUBMODE_NONE]	[ABRIS_SUBMODE_NONE]          	 = id_Page.PAGE_PLAN_MAIN
pages_by_mode[ABRIS_PLAN][ABRIS_PLAN_RETURN]		[ABRIS_SUBMODE_NONE]	[ABRIS_SUBMODE_NONE]         	 = id_Page.PAGE_PLAN_MAIN
pages_by_mode[ABRIS_PLAN][ABRIS_PLAN_REMOVE]		[ABRIS_SUBMODE_NONE]	[ABRIS_SUBMODE_NONE]         	 = id_Page.PAGE_PLAN_REMOVE
pages_by_mode[ABRIS_PLAN][ABRIS_PLAN_INVERT]        [ABRIS_SUBMODE_NONE]	[ABRIS_SUBMODE_NONE]        	 = id_Page.PAGE_PLAN_MAIN
pages_by_mode[ABRIS_PLAN][ABRIS_PLAN_AUTO]          [ABRIS_SUBMODE_NONE]	[ABRIS_SUBMODE_NONE]             = id_Page.PAGE_PLAN_MAIN
pages_by_mode[ABRIS_PLAN][ABRIS_PLAN_ADDITIONALINFO][ABRIS_SUBMODE_NONE]	[ABRIS_SUBMODE_NONE] 			 = id_Page.PAGE_PLAN_ADDITIONAL_INFO_MAIN

ABRIS_PLAN_ADDITIONALINFO_POINT_INSERTS_DIRECT   = 0 + 1; 
ABRIS_PLAN_ADDITIONALINFO_POINT_INSERTS_RELATIVE = 1 + 1;
ABRIS_PLAN_ADDITIONALINFO_POINT_INSERTS_FINALIZE = 2 + 1;

pages_by_mode[ABRIS_PLAN][ABRIS_PLAN_ADDITIONALINFO][ABRIS_PLAN_ADDITIONALINFO_POINT_INSERT][ABRIS_PLAN_ADDITIONALINFO_POINT_INSERTS_DIRECT]		= id_Page.PAGE_PLAN_ADDITIONAL_INFO_POINTS_DIRECT
pages_by_mode[ABRIS_PLAN][ABRIS_PLAN_ADDITIONALINFO][ABRIS_PLAN_ADDITIONALINFO_POINT_INSERT][ABRIS_PLAN_ADDITIONALINFO_POINT_INSERTS_RELATIVE] 	= id_Page.PAGE_PLAN_ADDITIONAL_INFO_POINTS_RELATIVE
pages_by_mode[ABRIS_PLAN][ABRIS_PLAN_ADDITIONALINFO][ABRIS_PLAN_ADDITIONALINFO_POINT_INSERT][ABRIS_PLAN_ADDITIONALINFO_POINT_INSERTS_FINALIZE] 	= id_Page.PAGE_PLAN_ADDITIONAL_INFO_POINTS_FINALIZE
pages_by_mode[ABRIS_PLAN][ABRIS_PLAN_ADDITIONALINFO][ABRIS_PLAN_ADDITIONALINFO_POINT_EDIT_REMOVE][ABRIS_SUBMODE_NONE]								= id_Page.PAGE_PLAN_ADDITIONAL_INFO_POINT_EDIT_REMOVE
pages_by_mode[ABRIS_PLAN][ABRIS_PLAN_ADDITIONALINFO][ABRIS_PLAN_ADDITIONALINFO_POINT_REMOVE][ABRIS_SUBMODE_NONE]								= id_Page.PAGE_PLAN_ADDITIONAL_INFO_POINT_REMOVE

pages_by_mode[ABRIS_PLAN][ABRIS_PLAN_ADDITIONALINFO][ABRIS_PLAN_ADDITIONALINFO_LINE_INSERT][ABRIS_SUBMODE_NONE]				= id_Page.PAGE_PLAN_ADDITIONAL_INFO_LINES
pages_by_mode[ABRIS_PLAN][ABRIS_PLAN_ADDITIONALINFO][ABRIS_PLAN_ADDITIONALINFO_LINE_REMOVE][ABRIS_SUBMODE_NONE]				= id_Page.PAGE_PLAN_ADDITIONAL_INFO_LINE_REMOVE

pages_by_mode[ABRIS_SNS][ABRIS_SNS_MAIN][ABRIS_SNS_MAIN_MANUAL][ABRIS_SUBMODE_NONE]                      = id_Page.PAGE_SNS_MAIN_MANUAL
pages_by_mode[ABRIS_SNS][ABRIS_SNS_MAIN][ABRIS_SNS_MAIN_AUTO][ABRIS_SUBMODE_NONE]                        = id_Page.PAGE_SNS_MAIN_AUTO
pages_by_mode[ABRIS_SNS][ABRIS_SNS_CALC][ABRIS_SUBMODE_NONE][ABRIS_SUBMODE_NONE]                         = id_Page.PAGE_SNS_CALC

pages_by_mode[ABRIS_SOFTWARE][ABRIS_SOFTWARE_ERROR][ABRIS_SUBMODE_NONE][ABRIS_SUBMODE_NONE]                  = id_Page.PAGE_BSOD
pages_by_mode[ABRIS_HARDWARE][ABRIS_HARDWARE_BIOS_POST][ABRIS_SUBMODE_NONE][ABRIS_SUBMODE_NONE]              = id_Page.PAGE_BIOS



function get_page_by_mode(master,L2,L3,L4)
	local page_id = pages_by_mode[master + 1][L2 + 1][L3 +1][L4 + 1]
	if    page_id ~= nil then
		return page_id	
	else 
		  page_id =  pages_by_mode[master + 1][0 + 1][0 +1][0 + 1]
		  if  page_id ~= nil then
				return page_id
		  else
		  		return init_pageID
		  end
	end
end

-----------------------------------------------------------------------------------------------------------
page_subsets[id_pagesubset.SPECIFIC]            = LockOn_Options.script_path.."ABRIS\\ABRIS_specific.lua"
-----------------------------------------------------------------------------------------------------------

specific_element_id =
{
		ELM_WAYPOINT_STP   = 0 ,               --простая точка
		ELM_WAYPOINT_STP_CURRENT = 1,        --текущая
		ELM_WAYPOINT_STP_OK = 2,             --пройденная
		ELM_WAYPOINT_AIRDROME = 3,           --аэродром
		ELM_WAYPOINT_TOWN = 4,               --город
		ELM_ROUTE = 5,
		ELM_ROUTE_NEXT = 6,
		ELM_WAYPOINT_NEXT = 7,
		ELM_DLPT_ARMOR = 8,
		ELM_DLPT_AIRDEFENCE = 9,
		ELM_DLPT_OTHER = 10,
		ELM_DLPT_REFPOINT = 11,
		ELM_DLPT_GROUP_MEMBER =12,
		-----------------------
		ELM_BEACON_TYPE_VOR = 13,
		ELM_BEACON_TYPE_DME= 14,
		ELM_BEACON_TYPE_TACAN = 15,
		ELM_BEACON_TYPE_VOR_DME = 16,
		ELM_BEACON_TYPE_VOR_TACAN = 17,
		ELM_BEACON_TYPE_HOMER = 18,
		ELM_BEACON_TYPE_ROUTE_MARKER = 19,
		ELM_BEACON_TYPE_ILS_MARKER = 20,
		------------------------		
		ELM_MILITARY_AERODROME = 21,
		ELM_MILITARY_HELIDROME  = 22,
		ELM_MILITARY_SEADROME = 23,
		ELM_CIVIL_AIRPORT = 24,
		ELM_CIVIL_SEADROME = 25,
		ELM_CIVIL_HELIPORT = 26,
		ELM_CLOSED_AIRPORT  = 27,
		ELM_NEW_AIRPORT		= 28,
		----------------------------------------------------------
		ELM_SAM_AREA_FRIENDLY = 29,
		ELM_SAM_AREA_HOSTILE  = 30,
		-----------------------------------------------------------
		ELM_ADDITIONAL_LINE_OBJECT = 31,
		ELM_ADDITIONAL_CURRENT_LINE_OBJECT = 32,
		-----------------------------------------------------------
		ELM_LANDMARK			   = 33,
		ELM_REFPOINT			   = 34,
		ELM_OBSTACLE               = 35,
		----------------------------------------------------------
		ELM_PREPLANNED_THREAT      = 36,
		ELM_PREPLANNED_FRIEND	   = 37,
		----------------------------------------------------------
		ELM_SENSOR_POINT_OF_INTEREST = 38,	
		ELM_CLIMB_DIVE_POINT = 39,
		----------------------------------------------------------		
		ELM_GPS_SATELLITE  = 40,
		ELM_GNSS_SATELLITE = 41,
		ELM_SATELLITE_SNR = 42,		
		----------------------------------------------------------
		ELM_MOVING_ROUTE_SEGMENT = 43,
		ELM_MOVING_SEGMENT_POINT = 44,
		----------------------------------------------------------
		ELM_DLPT_GROUP_LEADER = 45,		
		ELM_DLPT_ARMOR_TARGET = 46,
		ELM_DLPT_AIRDEFENCE_TARGET = 47,
		ELM_DLPT_OTHER_TARGET = 48,
		ELM_DLPT_REFPOINT_TARGET = 49,
		
		ELM_DLPT_GROUP_MEMBER_WITH_COURSE = 50,
		ELM_DLPT_GROUP_LEADER_WITH_COURSE = 51,
		
		ELM_SPECIFIC_MAX = 456
		
}

specific_element_names = {}
specific_element_names[specific_element_id.ELM_WAYPOINT_STP]           ="el_smpl_wpt"
specific_element_names[specific_element_id.ELM_WAYPOINT_STP_CURRENT]   ="el_smpl_wpt_curr"
specific_element_names[specific_element_id.ELM_WAYPOINT_STP_OK]        ="el_smpl_wpt_solid"
specific_element_names[specific_element_id.ELM_WAYPOINT_AIRDROME]      ="el_airport_CIVILIAN_fon" 
specific_element_names[specific_element_id.ELM_WAYPOINT_TOWN]	       ="el_town_fon"
specific_element_names[specific_element_id.ELM_ROUTE]				   ="el_route_segment_OK"
specific_element_names[specific_element_id.ELM_ROUTE_NEXT]			   ="el_route_segment_NEXT"
specific_element_names[specific_element_id.ELM_MOVING_ROUTE_SEGMENT]   ="el_moving_route_segment"
specific_element_names[specific_element_id.ELM_WAYPOINT_NEXT]          ="el_smpl_wpt_solid_blue"
specific_element_names[specific_element_id.ELM_DLPT_ARMOR]             ="el_marker_DLPT_ARMOR"
specific_element_names[specific_element_id.ELM_DLPT_AIRDEFENCE]        ="el_marker_DLPT_AIRDEFENCE"
specific_element_names[specific_element_id.ELM_DLPT_OTHER]             ="el_marker_DLPT_OTHER"
specific_element_names[specific_element_id.ELM_DLPT_REFPOINT]          ="el_marker_DLPT_REFPOINT"
specific_element_names[specific_element_id.ELM_DLPT_GROUP_MEMBER]      ="el_marker_DLPT_GROUP_MEMBER_plashka"
specific_element_names[specific_element_id.ELM_DLPT_GROUP_LEADER]      ="el_marker_DLPT_GROUP_LEADER_plashka"
--
specific_element_names[specific_element_id.ELM_DLPT_GROUP_MEMBER_WITH_COURSE] ="el_marker_DLPT_GROUP_MEMBER_with_course_plashka"
specific_element_names[specific_element_id.ELM_DLPT_GROUP_LEADER_WITH_COURSE] ="el_marker_DLPT_GROUP_LEADER_with_course_plashka"
--
specific_element_names[specific_element_id.ELM_DLPT_ARMOR_TARGET]      	   ="el_marker_DLPT_ARMOR_TARGET"
specific_element_names[specific_element_id.ELM_DLPT_AIRDEFENCE_TARGET]     ="el_marker_DLPT_AIRDEFENCE_TARGET"
specific_element_names[specific_element_id.ELM_DLPT_OTHER_TARGET]      	   ="el_marker_DLPT_OTHER_TARGET"
specific_element_names[specific_element_id.ELM_DLPT_REFPOINT_TARGET]       ="el_marker_DLPT_REFPOINT_TARGET"
--
specific_element_names[specific_element_id.ELM_BEACON_TYPE_VOR] 		  ="el_beacon_VOR"
specific_element_names[specific_element_id.ELM_BEACON_TYPE_DME] 		  ="el_beacon_DME"
specific_element_names[specific_element_id.ELM_BEACON_TYPE_TACAN] 		  ="el_beacon_TACAN"
specific_element_names[specific_element_id.ELM_BEACON_TYPE_VOR_DME] 	  ="el_beacon_VORDME" 
specific_element_names[specific_element_id.ELM_BEACON_TYPE_VOR_TACAN] 	  ="el_beacon_VORTACAN"
specific_element_names[specific_element_id.ELM_BEACON_TYPE_HOMER]		  ="el_beacon_NDB"
specific_element_names[specific_element_id.ELM_BEACON_TYPE_ROUTE_MARKER]  ="el_beacon_wpt"
specific_element_names[specific_element_id.ELM_BEACON_TYPE_ILS_MARKER]    ="el_marker_airport_beacon"

specific_element_names[specific_element_id.ELM_MILITARY_AERODROME]  ="el_airport_CIVILIAN_fon"  ---"el_airport_MILITARY"
specific_element_names[specific_element_id.ELM_MILITARY_HELIDROME]  ="el_airport_heli_MILITARY_fon" 
specific_element_names[specific_element_id.ELM_MILITARY_SEADROME]   ="el_airport_hydro_MILITARY_fon" 
specific_element_names[specific_element_id.ELM_CIVIL_AIRPORT]       ="el_airport_CIVILIAN_fon" 
specific_element_names[specific_element_id.ELM_CIVIL_SEADROME]      ="el_airport_hydro_MILITARY_fon" 
specific_element_names[specific_element_id.ELM_CIVIL_HELIPORT]      ="el_airport_heli_MILITARY_fon"
specific_element_names[specific_element_id.ELM_CLOSED_AIRPORT]      ="el_airport_RESTRICTED_fon" 
specific_element_names[specific_element_id.ELM_NEW_AIRPORT]      ="el_airport_MILITARY"  --"el_airport_NEW_fon" 

specific_element_names[specific_element_id.ELM_SAM_AREA_FRIENDLY]       = "threat_friendly"
specific_element_names[specific_element_id.ELM_SAM_AREA_HOSTILE]        = "threat_hostile"
specific_element_names[specific_element_id.ELM_ADDITIONAL_LINE_OBJECT]  = "el_additional_info_line"
specific_element_names[specific_element_id.ELM_ADDITIONAL_CURRENT_LINE_OBJECT]  = "el_additional_info_current_line"
specific_element_names[specific_element_id.ELM_LANDMARK]				= "el_landmark" 
specific_element_names[specific_element_id.ELM_REFPOINT]				= "el_refpoint" 
specific_element_names[specific_element_id.ELM_OBSTACLE]			    = "el_obstacle"
specific_element_names[specific_element_id.ELM_PREPLANNED_THREAT]		= "el_marker_DLPT_PREPLANNED_THREAT"
specific_element_names[specific_element_id.ELM_PREPLANNED_FRIEND]		= "el_marker_DLPT_PREPLANNED_FRIEND"
specific_element_names[specific_element_id.ELM_SENSOR_POINT_OF_INTEREST]= "el_SPI_line"
specific_element_names[specific_element_id.ELM_CLIMB_DIVE_POINT]  = "climb_dive_point_mark"

specific_element_names[specific_element_id.ELM_MOVING_SEGMENT_POINT]  = "el_smpl_wpt_solid_green"


specific_element_names[specific_element_id.ELM_GPS_SATELLITE]  = "gps_satellite_mark"
specific_element_names[specific_element_id.ELM_GNSS_SATELLITE]  = "gnss_satellite_mark"
specific_element_names[specific_element_id.ELM_SATELLITE_SNR]  = "SNR_row_label"

templates = {}
templates["JOURNAL"]      = id_pagesubset.TEMPLATE_JOURNAL
templates["SIMPLE_MENU"]  = id_pagesubset.TEMPLATE_SIMPLE_MENU
templates["MAP_OBJECTS"]  = id_pagesubset.SPECIFIC
templates["SPACE_OBJECTS"]  = id_pagesubset.SPECIFIC
templates["THREAT_AREAS"]   = id_pagesubset.SPECIFIC

templates_by_mode = {}
templates_by_mode["JOURNAL"] ={}
templates_by_mode["SIMPLE_MENU"] ={}
templates_by_mode["MAP_OBJECTS"] ={}
templates_by_mode["THREAT_AREAS"] = {}

clear_mode_table(templates_by_mode["JOURNAL"])
clear_mode_table(templates_by_mode["SIMPLE_MENU"])
clear_mode_table(templates_by_mode["MAP_OBJECTS"])
clear_mode_table(templates_by_mode["THREAT_AREAS"])

templates_by_mode["JOURNAL"][ABRIS_PLAN][ABRIS_PLAN_REDACT][ABRIS_SUBMODE_NONE]    [ABRIS_SUBMODE_NONE]                     = id_pagesubset.PLAN_ROUTE_TEMPLATE
templates_by_mode["JOURNAL"][ABRIS_PLAN][ABRIS_PLAN_REDACT][ABRIS_PLAN_REDACT_DRAW][ABRIS_SUBMODE_NONE]			 		    = id_pagesubset.PLAN_ROUTE_TEMPLATE
templates_by_mode["JOURNAL"][ABRIS_PLAN][ABRIS_PLAN_REDACT][ABRIS_PLAN_REDACT_DRAW][ABRIS_PLAN_REDACT_DRAW_INSERT]  	    = id_pagesubset.PLAN_ROUTE_TEMPLATE
templates_by_mode["JOURNAL"][ABRIS_PLAN][ABRIS_PLAN_REDACT][ABRIS_PLAN_REDACT_DRAW][ABRIS_PLAN_REDACT_DRAW_FINALIZE_INSERT] = id_pagesubset.PLAN_ROUTE_TEMPLATE
templates_by_mode["JOURNAL"][ABRIS_PLAN][ABRIS_PLAN_REDACT][ABRIS_PLAN_REDACT_DRAW][ABRIS_PLAN_REDACT_DRAW_MOVE] 			= id_pagesubset.PLAN_ROUTE_TEMPLATE
templates_by_mode["JOURNAL"][ABRIS_PLAN][ABRIS_PLAN_REDACT][ABRIS_PLAN_REDACT_DRAW][ABRIS_PLAN_REDACT_DRAW_FINALIZE_INSERT_EXIST_WPT] 		= id_pagesubset.PLAN_ROUTE_TEMPLATE
templates_by_mode["JOURNAL"][ABRIS_PLAN][ABRIS_PLAN_REDACT][ABRIS_PLAN_REDACT_DRAW][ABRIS_PLAN_REDACT_DRAW_FINALIZE_INSERT_EXIST_WPT_ARRAY] = id_pagesubset.PLAN_ROUTE_TEMPLATE
templates_by_mode["JOURNAL"][ABRIS_PLAN][ABRIS_PLAN_REDACT][ABRIS_PLAN_REDACT_DRAW][ABRIS_PLAN_REDACT_DRAW_SEARCH_NOT_FOUND]				= id_pagesubset.PLAN_ROUTE_TEMPLATE

templates_by_mode["JOURNAL"][ABRIS_PLAN][ABRIS_PLAN_REDACT][ABRIS_PLAN_REDACT_SPEED][ABRIS_SUBMODE_NONE]                   = id_pagesubset.PLAN_REDACT_SPEED_TEMPLATE
templates_by_mode["JOURNAL"][ABRIS_PLAN][ABRIS_PLAN_REDACT][ABRIS_PLAN_REDACT_SPEED][ABRIS_PLAN_REDACT_SPEED_FINALIZE]     = id_pagesubset.PLAN_REDACT_SPEED_TEMPLATE
templates_by_mode["JOURNAL"][ABRIS_PLAN][ABRIS_PLAN_REDACT][ABRIS_PLAN_REDACT_METEO][ABRIS_SUBMODE_NONE]                   = id_pagesubset.PLAN_REDACT_METEO_TEMPLATE
templates_by_mode["JOURNAL"][ABRIS_PLAN][ABRIS_PLAN_REDACT][ABRIS_PLAN_REDACT_METEO][ABRIS_PLAN_REDACT_METEO_FINALIZE]     = id_pagesubset.PLAN_REDACT_METEO_TEMPLATE
templates_by_mode["JOURNAL"][ABRIS_PLAN][ABRIS_PLAN_REDACT][ABRIS_PLAN_REDACT_VNAV][ABRIS_SUBMODE_NONE]                   = id_pagesubset.PLAN_REDACT_VNAV_TEMPLATE
templates_by_mode["JOURNAL"][ABRIS_PLAN][ABRIS_PLAN_REDACT][ABRIS_PLAN_REDACT_VNAV][ABRIS_PLAN_REDACT_VNAV_FINALIZE]     = id_pagesubset.PLAN_REDACT_VNAV_TEMPLATE
templates_by_mode["JOURNAL"][ABRIS_PLAN][ABRIS_PLAN_REDACT][ABRIS_PLAN_REDACT_FUEL][ABRIS_SUBMODE_NONE]                   = id_pagesubset.PLAN_REDACT_FUEL_TEMPLATE
templates_by_mode["JOURNAL"][ABRIS_PLAN][ABRIS_PLAN_REDACT][ABRIS_PLAN_REDACT_FUEL][ABRIS_PLAN_REDACT_FUEL_FINALIZE]     = id_pagesubset.PLAN_REDACT_FUEL_TEMPLATE

templates_by_mode["JOURNAL"][ABRIS_NAV][ABRIS_NAV_JOURNAL][ABRIS_NAV_JOURNAL_VNAV][ABRIS_SUBMODE_NONE] = id_pagesubset.PLAN_REDACT_VNAV_TEMPLATE
templates_by_mode["JOURNAL"][ABRIS_NAV][ABRIS_NAV_JOURNAL][ABRIS_NAV_JOURNAL_VNAV][ABRIS_NAV_JOURNAL_VERTICAL_SPEED_EDIT] = id_pagesubset.PLAN_REDACT_VNAV_TEMPLATE
templates_by_mode["JOURNAL"][ABRIS_NAV][ABRIS_NAV_JOURNAL][ABRIS_NAV_JOURNAL_VNAV][ABRIS_NAV_JOURNAL_VNAV_EDIT] = id_pagesubset.PLAN_REDACT_VNAV_TEMPLATE

templates_by_mode["SIMPLE_MENU"][ABRIS_NAV][ABRIS_NAV_SEARCH][ABRIS_NAV_SEARCH_FIND_NEAREST][NAV_SEARCH_AERODROMES] = id_pagesubset.NAV_SEARCH_TEMPLATE_AIRPORT
templates_by_mode["SIMPLE_MENU"][ABRIS_NAV][ABRIS_NAV_SEARCH][ABRIS_NAV_SEARCH_FIND_NEAREST][NAV_SEARCH_VOR]        = id_pagesubset.NAV_SEARCH_TEMPLATE_VOR
templates_by_mode["SIMPLE_MENU"][ABRIS_NAV][ABRIS_NAV_SEARCH][ABRIS_NAV_SEARCH_FIND_NEAREST][NAV_SEARCH_OPRS]       = id_pagesubset.NAV_SEARCH_TEMPLATE_OPRS
templates_by_mode["SIMPLE_MENU"][ABRIS_NAV][ABRIS_NAV_SEARCH][ABRIS_NAV_SEARCH_FIND_NEAREST][NAV_SEARCH_STP]        = id_pagesubset.NAV_SEARCH_TEMPLATE_STP
templates_by_mode["SIMPLE_MENU"][ABRIS_NAV][ABRIS_NAV_SEARCH][ABRIS_NAV_SEARCH_FIND_NEAREST][NAV_SEARCH_CITY]       = id_pagesubset.NAV_SEARCH_TEMPLATE_COMMON

templates_by_mode["SIMPLE_MENU"][ABRIS_NAV][ABRIS_NAV_SEARCH][ABRIS_NAV_SEARCH_FIND_BY_NAME][NAV_SEARCH_AERODROMES] = id_pagesubset.NAV_SEARCH_BY_NAME_TEMPLATE_AIRPORT
templates_by_mode["SIMPLE_MENU"][ABRIS_NAV][ABRIS_NAV_SEARCH][ABRIS_NAV_SEARCH_FIND_BY_NAME][NAV_SEARCH_VOR]        = id_pagesubset.NAV_SEARCH_BY_NAME_TEMPLATE_VOR
templates_by_mode["SIMPLE_MENU"][ABRIS_NAV][ABRIS_NAV_SEARCH][ABRIS_NAV_SEARCH_FIND_BY_NAME][NAV_SEARCH_OPRS]       = id_pagesubset.NAV_SEARCH_BY_NAME_TEMPLATE_OPRS
templates_by_mode["SIMPLE_MENU"][ABRIS_NAV][ABRIS_NAV_SEARCH][ABRIS_NAV_SEARCH_FIND_BY_NAME][NAV_SEARCH_STP]        = id_pagesubset.NAV_SEARCH_BY_NAME_TEMPLATE_STP
templates_by_mode["SIMPLE_MENU"][ABRIS_NAV][ABRIS_NAV_SEARCH][ABRIS_NAV_SEARCH_FIND_BY_NAME][NAV_SEARCH_CITY]       = id_pagesubset.NAV_SEARCH_BY_NAME_TEMPLATE_COMMON
templates_by_mode["SIMPLE_MENU"][ABRIS_PLAN][ABRIS_PLAN_ADDITIONALINFO][ABRIS_PLAN_ADDITIONALINFO_LINE_INSERT][ABRIS_SUBMODE_NONE] =  id_pagesubset.PLAN_ADDITIONALINFO_COLOR_TEMPLATE
templates_by_mode["SIMPLE_MENU"][ABRIS_CONTROLS][ABRIS_CONTROLS_MESSAGES][ABRIS_SUBMODE_NONE][ABRIS_SUBMODE_NONE]  = id_pagesubset.MESSAGES_TEMPLATE

function get_template(name)
	local mode = LoGetModeABRIS()
		  mode.master  = mode.master  + 1
		  mode.level_2 = mode.level_2 + 1
		  mode.level_3 = mode.level_3 + 1
		  mode.level_4 = mode.level_4 + 1
		  
	if templates_by_mode[name]														  ~= nil then
	if templates_by_mode[name][mode.master] 										  ~= nil then
	if templates_by_mode[name][mode.master][mode.level_2]							  ~= nil then
	if templates_by_mode[name][mode.master][mode.level_2][mode.level_3]				  ~= nil then
	if templates_by_mode[name][mode.master][mode.level_2][mode.level_3][mode.level_4] ~= nil then
		return templates_by_mode[name][mode.master][mode.level_2][mode.level_3][mode.level_4]
	end
	end
	end
	end
	end
			
	if     templates[name] ~= nil then
		return templates[name]	
	end
	return -1
end
-------------------------------------------------------------------------------
--"el_smpl_wpt"
-------------------------------------------------------------------------------
--"el_smpl_wpt_curr"
-------------------------------------------------------------------------------
--"el_beacon_wpt_arrow"
-------------------------------------------------------------------------------
--"el_beacon_wpt"
-------------------------------------------------------------------------------
--"el_marker_wpt"
-------------------------------------------------------------------------------
--"el_beacon_wpt_solid"
-------------------------------------------------------------------------------
--"el_marker_wpt_solid"
-------------------------------------------------------------------------------
function get_specific_element_name_by_id(id)
	local name = ""
	if      specific_element_names[id] == nil then
		return name
	else
		return specific_element_names[id]
	end
end

