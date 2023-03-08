--- ABRIS specifications
local gettext = require("i_18n")
_ = gettext.translate

dofile (LockOn_Options.script_path.."ABRIS\\ABRIS_localizer.lua")
dofile (LockOn_Options.script_path.."ABRIS\\ABRIS_waypoint_type_name.lua")
dofile(LockOn_Options.common_script_path.."Transliterate.lua")
dofile(LockOn_Options.common_script_path.."tools.lua")

device_timer_dt = 0.1

signals_templates =
{
    LOCALIZE("ПРОЛЕТ ППМ").. " ", --
    LOCALIZE("ПОДХОД К ТОЧКЕ").." ",--  MSG_APPROACH_TO_STP,
    LOCALIZE("НАБОР").." ",--  MSG_APPROACH_TO_CLIMBPOINT,
    LOCALIZE("СНИЖЕНИЕ").." ",--    MSG_APPROACH_TO_DIVEPOINT,
    LOCALIZE("ПОВОРОТ").." ",--  MSG_APPROACH_TO_TURNPOINT,
    LOCALIZE("ЗОНА").." ",--    MSG_BORDER_AVOIDANCE_1,
    LOCALIZE("ЗОНА").." ",--    MSG_BORDER_AVOIDANCE_2,
    LOCALIZE("ЗОНА УВД").." ",-- MSG_BORDER_AIR_TRAFFIC_CONTROL_ZONE,
    LOCALIZE("ВЫХОД ПО ЛБУ").." ",--  MSG_LIMIT_LBU,
    LOCALIZE("ВЫХОД ПО ЗПУ").." ",--  MSG_LIMIT_COURSE,
    LOCALIZE("ПРЕПЯТСТВИЕ ПО КУРСУ").." ",--  MSG_COLLISION_DETECTION_HORIZON_LEVEL,
    LOCALIZE("ПРЕПЯТСТВИЕ ПО ВЫСОТЕ").." ",--    MSG_COLLISION_DETECTION_VERTICAL_LEVEL,
    "3D ",
    "2D ",
    LOCALIZE("НЕТ НАВ").." ",
    "PDOP ",
    LOCALIZE("ПОРОГ"),
}

package.path = package.path..";./Scripts/?.lua"

local S        = require("Serializer")
local lfs      = require("lfs")

use_saved_database   = true
save_system_points   = false
save_mission_objects = false

default_path         = get_terrain_related_data("ABRIS_data_path")

local function mission_and_default(file)
	local m = "ABRIS/" .. file
	local d = nil
	if  default_path then 
		return m, default_path..file
	end
	return m
end



if type(default_path) ~= 'string' then
   default_path = nil
end

function load_db_file(loader,file)  

	local m = file
	local d = file
	
	local prefix = "Database/"
	if loader then 
		prefix = "Loader/"
	end
	local  m,d = mission_and_default(prefix..file) 
	local  res,env,data = safe_do_mission_file(m,d,safe_env)
	return env
end




function save_file(name,table_to_save,file_to_save)
    local str = S:serialize_to_string(name,table_to_save)
    save_to_mission(file_to_save,str)
end

function save_db_file(loader,name,table_to_save,file_to_save)
    local             path = file_to_save
    if    loader then path = "ABRIS/Loader/"  ..path
    else              path = "ABRIS/Database/"..path
    save_file(name,table_to_save,path)
    end
end

navigation = {}
routes     = {}
additional = {}

function LoadNavigation(loader)

    navigation = load_db_file(loader,"NAVIGATION.lua").navigation
	
	if not navigation then
		navigation		   = {} 
		if not loader then
			use_saved_database = false
		end
	end
	if  LockOn_Options.avionics_language ~= "native" and navigation.waypoints then
		for i,o in pairs(navigation.waypoints) do
			if o.callsign ~= nil then
			   o.callsign  = TransliterateToLatDefault(o.callsign)
			end
			if o.name ~= nil then
			   o.name  = TransliterateToLatDefault(o.name)
			end
		end
	end
end

function LoadRoutes(loader)        routes     = load_db_file(loader,"ROUTES.lua").routes or {} end
function LoadAdditional(loader)    additional = load_db_file(loader,"ADDITIONAL.lua").additional or {}  end

function SaveNavigation(loader)    save_db_file(loader,"navigation",navigation,"NAVIGATION.lua")    end
function SaveRoutes(loader)        save_db_file(loader,"routes"    ,routes    ,"ROUTES.lua")        end
function SaveAdditional(loader)    save_db_file(loader,"additional",additional,"ADDITIONAL.lua")    end


Options          = {}
System_Options   = {}

local safe_env = make_safe_environment()
safe_env.LOCALIZE = LOCALIZE

function LoadOptions()
	local res,env,data = safe_do_mission_file("ABRIS/Options.lua",LockOn_Options.script_path.."ABRIS/Options.lua",safe_env)
	local opt 		   = env.opt
	if  opt then
	    Options        = opt.Options
		System_Options = opt.System_Options
	end
end

function SaveOptions()
      save_file("opt",
                {Options        = Options,
                 System_Options = System_Options},
                 "Options.lua")
end

LoadOptions()

post_messages = 
{
    {message = "starting BIOS......................",next_time = 5},
    {message = "CPU   :486DX4.........OK",next_time = 0.5},
    {message = "memory:2097152KB......OK",next_time = 0.5},
    {message = "video :EDGA32768KB....OK",next_time = 0.5},
    {message = "mounted flash",next_time = 2},
    {message = "booting EDOS............",next_time = 5},
    {message = "ABRIS started",next_time = 5},
    {message = "ABRIS performing full test",next_time = 60},
    {message = "ABRIS ready , loading ui..",next_time = 2},
}
local last_post = 0;
local abris     = GetSelf()

function update_post(t,t_last)

    if t_last <  0 then
       last_post = 0 
    end
    last_post = last_post + 1
    if last_post > #post_messages then 
    return t
    end
    local msg = post_messages[last_post]
    abris:print_to_console(msg.message)
    return t + msg.next_time
end

COMPUTER_FAILURE = 0
SNS_ANTENNA_FAILURE = 1
SOFTWARE_FAIL = 2
HARDWARE_FAIL = 3

blue_screen_probability_initial   = 0.7
blue_screen_probability_interval  = 600
blue_screen_probability_increment = 0.15

Damage = {  {Failure = COMPUTER_FAILURE, Failure_name = "ABRIS_COMPUTER_FAILURE", Failure_editor_name = _("ABRIS computer failure"), Element = 3, Slope_param = 4.0}, 
            {Failure = COMPUTER_FAILURE, Failure_name = "ABRIS_COMPUTER_FAILURE", Failure_editor_name = _("ABRIS computer failure"), Element = 4, Slope_param = 1.0}, 
            {Failure = COMPUTER_FAILURE, Failure_name = "ABRIS_COMPUTER_FAILURE", Failure_editor_name = _("ABRIS computer failure"), Element = 5, Slope_param = 2.0}, 
            {Failure = SNS_ANTENNA_FAILURE, Failure_name = "SNS_ANTENNA_FAILURE", Failure_editor_name = _("SNS antenna failure"), Element = 58},
			{Failure = SOFTWARE_FAIL, Failure_name = "abris_software", Failure_editor_name = _("ABRIS Software")},
			{Failure = HARDWARE_FAIL, Failure_name = "abris_hardware", Failure_editor_name = _("ABRIS Hardware")},
			
			}
start_mode = {master = 0,level_2 = 0,level_3 = 0,level_4 = 0}-- menu

-- applied at hot start only
initial_brightness_day 		= 1
initial_brightness_night 	= 0.16
