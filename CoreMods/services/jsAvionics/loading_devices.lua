jsAvionicsPath = get_dcs_plugin_path("jsAvionics")

dofile(jsAvionicsPath.."/device_types.lua")

loading_devices = {}
loading_devices["dev1"] = {d_type = device_types["GNS430"], d_id = 1}
loading_devices["dev2"] = {d_type = device_types["GNS430"], d_id = 2}