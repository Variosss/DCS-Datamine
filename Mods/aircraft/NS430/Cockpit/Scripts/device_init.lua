dofile(LockOn_Options.script_path.."devices.lua")

MainPanel = {"G430::ccNS430Panel", LockOn_Options.script_path.."mainpanel_init.lua",{{"system", devices.GNS430}}}

-- Avionics devices initialization example
--	items in <...> are optional
--
-- creators[DEVICE_ID] = {"NAME_OF_CONTROLLER_CLASS",
--						  <"CONTROLLER_SCRIPT_FILE",>
--						  <{{"varname1", devices.LINKED_DEVICE1}, {"varname2", devices.LINKED_DEVICE2}, ...},>
--						  <"INPUT_COMMANDS_SCRIPT_FILE",>
--						  <{{"NAME_OF_INDICATOR_CLASS", "INDICATOR_SCRIPT_FILE"}, ...}>
--						 }

creators = {}
creators[devices.GNS430_Radio] = {"G430::avGNS430_Radio", LockOn_Options.script_path.."Devices_specs/Radio.lua"}
creators[devices.GNS430] = {"G430::avGNS430", LockOn_Options.script_path.."Devices_specs/NS430.lua",
									{ 
										{"radio", devices.GNS430_Radio}
								 	}
								}
indicators  = {}

-- 

indicators[#indicators + 1] = {"G430::ccGNS430",LockOn_Options.script_path.."NS430_init.lua", devices.GNS430, {{"GARMIN-CENTER", "GARMIN-DOWN", "GARMIN-RIGHT"}}}

--indicators[#indicators + 1] = {"G430::ccGNS430",LockOn_Options.script_path.."NS430_init1.lua", devices.GNS430_2, {{"GARMIN-CENTER", "GARMIN-DOWN", "GARMIN-RIGHT"}}}
