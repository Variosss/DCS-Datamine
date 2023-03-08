---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
----   DEBUG DEFINITIONS  -------------------------------------------
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
is_debug = false

---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
----   END OF DEBUG DEFINITIONS  --------------------------------
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------


package.path = package.path..";./Scripts/?.lua"

local Serializer = require('Serializer')
dofile (LockOn_Options.script_path.."DSMS/database/DTS_definitions.lua")
dofile (LockOn_Options.script_path.."DSMS/database/DTS_weapon_names.lua")
-- APKWS and GBU-54 addition
dofile (LockOn_Options.script_path.."DSMS/database/DTS_definitions_A10C_2.lua")

device_timer_dt		= 1.0

default_db			= LockOn_Options.script_path.."DSMS/Database/DataBase.lua"

function get_file_name(loader)
	local campaign = LockOn_Options.mission.campaign
	local mission  = LockOn_Options.mission.title
	local					  name     = db_path
	if campaign ~= "" then    name     = name .. campaign .. "/" end
	if mission  ~= "" then	  name     = name .. mission .. DSMS_DB_name_suffix end
	return 					  name
end

function SaveDB()
	local file   = io.open(db_path, "w")
	
	if  file then
		local serializer = Serializer.new(file)
		
		serializer:serialize("ProfileList", ProfileList)
		serializer:serialize("ProfileTrainingList", ProfileTrainingList)
		
		file:close()
	end
end

storesPermissions = {}
storesPermissions[1] = {}
storesPermissions[1]["bomb"] = true
storesPermissions[1]["bombtypes"] = {}
storesPermissions[1]["bombtypes"]["MK82"] = true
storesPermissions[1]["bombtypes"]["MK82A"] = true
storesPermissions[1]["bombtypes"]["BDU50"] = true
storesPermissions[1]["bombtypes"]["MK84"] = false
storesPermissions[1]["bombtypes"]["BDU56"] = false
storesPermissions[1]["bombtypes"]["BDU33"] = false
storesPermissions[1]["bombtypes"]["BLU52"] = false
storesPermissions[1]["cbu"] = true
storesPermissions[1]["cbutypes"] = {}
storesPermissions[1]["cbutypes"]["CBU87"] = true
storesPermissions[1]["cbutypes"]["CBU89"] = true
storesPermissions[1]["cbutypes"]["CBU97"] = true
storesPermissions[1]["cbutypes"]["CBU103"] = false
storesPermissions[1]["cbutypes"]["CBU104"] = false
storesPermissions[1]["cbutypes"]["CBU105"] = false
storesPermissions[1]["gbu"] = true
storesPermissions[1]["gbutypes"] = {}
storesPermissions[1]["gbutypes"]["GBU10"] = false
storesPermissions[1]["gbutypes"]["GBU12"] = true
storesPermissions[1]["gbutypes"]["GBU31"] = false
storesPermissions[1]["gbutypes"]["GBU38"] = false
storesPermissions[1]["misc"] = false
storesPermissions[1]["rocket"] = false
storesPermissions[1]["flare"] = false
storesPermissions[1]["missile"] = true
storesPermissions[1]["missiletypes"] = {}
storesPermissions[1]["missiletypes"]["AIM9"] = true
storesPermissions[1]["missiletypes"]["AGM65"] = false
storesPermissions[1]["pod"] = true
storesPermissions[1]["podtypes"] = {}
storesPermissions[1]["podtypes"]["LITENING"] = false
storesPermissions[1]["podtypes"]["ALQ131"] = true
storesPermissions[1]["podtypes"]["ALQ184"] = true
storesPermissions[1]["rack"] = true
storesPermissions[1]["racktypes"] = {}
storesPermissions[1]["racktypes"]["TER"] = false
storesPermissions[1]["racktypes"]["LAU117"] = false
storesPermissions[1]["racktypes"]["LAU88"] = false
storesPermissions[1]["racktypes"]["SUU25"] = false
storesPermissions[1]["racktypes"]["LAU105"] = true
storesPermissions[1]["racktypes"]["LAU68"] = false
storesPermissions[1]["racktypes"]["LAU131"] = false
storesPermissions[2] = {}
storesPermissions[2]["bomb"] = true
storesPermissions[2]["bombtypes"] = {}
storesPermissions[2]["bombtypes"]["MK82"] = true
storesPermissions[2]["bombtypes"]["MK82A"] = true
storesPermissions[2]["bombtypes"]["BDU50"] = true
storesPermissions[2]["bombtypes"]["MK84"] = false
storesPermissions[2]["bombtypes"]["BDU56"] = false
storesPermissions[2]["bombtypes"]["BDU33"] = false
storesPermissions[2]["bombtypes"]["BLU52"] = true
storesPermissions[2]["cbu"] = true
storesPermissions[2]["cbutypes"] = {}
storesPermissions[2]["cbutypes"]["CBU87"] = true
storesPermissions[2]["cbutypes"]["CBU89"] = true
storesPermissions[2]["cbutypes"]["CBU97"] = true
storesPermissions[2]["cbutypes"]["CBU103"] = false
storesPermissions[2]["cbutypes"]["CBU104"] = false
storesPermissions[2]["cbutypes"]["CBU105"] = false
storesPermissions[2]["gbu"] = true
storesPermissions[2]["gbutypes"] = {}
storesPermissions[2]["gbutypes"]["GBU10"] = false
storesPermissions[2]["gbutypes"]["GBU12"] = true
storesPermissions[2]["gbutypes"]["GBU31"] = false
storesPermissions[2]["gbutypes"]["GBU38"] = false
storesPermissions[2]["misc"] = false
storesPermissions[2]["rocket"] = true
storesPermissions[2]["flare"] = true
storesPermissions[2]["missile"] = false
storesPermissions[2]["pod"] = true
storesPermissions[2]["podtypes"] = {}
storesPermissions[2]["podtypes"]["LITENING"] = true
storesPermissions[2]["podtypes"]["ALQ131"] = false
storesPermissions[2]["podtypes"]["ALQ184"] = false
storesPermissions[2]["rack"] = true
storesPermissions[2]["racktypes"] = {}
storesPermissions[2]["racktypes"]["TER"] = false
storesPermissions[2]["racktypes"]["LAU117"] = false
storesPermissions[2]["racktypes"]["LAU88"] = false
storesPermissions[2]["racktypes"]["SUU25"] = true
storesPermissions[2]["racktypes"]["LAU105"] = false
storesPermissions[2]["racktypes"]["LAU68"] = true
storesPermissions[2]["racktypes"]["LAU131"] = true
storesPermissions[3] = {}
storesPermissions[3]["bomb"] = true
storesPermissions[3]["bombtypes"] = {}
storesPermissions[3]["bombtypes"]["MK82"] = true
storesPermissions[3]["bombtypes"]["MK82A"] = true
storesPermissions[3]["bombtypes"]["BDU50"] = true
storesPermissions[3]["bombtypes"]["MK84"] = true
storesPermissions[3]["bombtypes"]["BDU56"] = true
storesPermissions[3]["bombtypes"]["BDU33"] = true
storesPermissions[3]["bombtypes"]["BLU52"] = true
storesPermissions[3]["cbu"] = true
storesPermissions[3]["cbutypes"] = {}
storesPermissions[3]["cbutypes"]["CBU87"] = true
storesPermissions[3]["cbutypes"]["CBU89"] = true
storesPermissions[3]["cbutypes"]["CBU97"] = true
storesPermissions[3]["cbutypes"]["CBU103"] = true
storesPermissions[3]["cbutypes"]["CBU104"] = true
storesPermissions[3]["cbutypes"]["CBU105"] = true
storesPermissions[3]["gbu"] = true
storesPermissions[3]["gbutypes"] = {}
storesPermissions[3]["gbutypes"]["GBU10"] = true
storesPermissions[3]["gbutypes"]["GBU12"] = true
storesPermissions[3]["gbutypes"]["GBU31"] = true
storesPermissions[3]["gbutypes"]["GBU38"] = true
storesPermissions[3]["misc"] = true
storesPermissions[3]["misctypes"] = {}
storesPermissions[3]["misctypes"]["CTU2A"] = true
storesPermissions[3]["misctypes"]["TK600"] = false
storesPermissions[3]["misctypes"]["TravelPod"] = true
storesPermissions[3]["rocket"] = true
storesPermissions[3]["flare"] = true
storesPermissions[3]["missile"] = true
storesPermissions[3]["missiletypes"] = {}
storesPermissions[3]["missiletypes"]["AIM9"] = false
storesPermissions[3]["missiletypes"]["AGM65"] = true
storesPermissions[3]["pod"] = false
storesPermissions[3]["rack"] = true
storesPermissions[3]["racktypes"] = {}
storesPermissions[3]["racktypes"]["TER"] = true
storesPermissions[3]["racktypes"]["LAU117"] = true
storesPermissions[3]["racktypes"]["LAU88"] = true
storesPermissions[3]["racktypes"]["SUU25"] = true
storesPermissions[3]["racktypes"]["LAU105"] = false
storesPermissions[3]["racktypes"]["LAU68"] = true
storesPermissions[3]["racktypes"]["LAU131"] = true
storesPermissions[4] = {}
storesPermissions[4]["bomb"] = true
storesPermissions[4]["bombtypes"] = {}
storesPermissions[4]["bombtypes"]["MK82"] = true
storesPermissions[4]["bombtypes"]["MK82A"] = true
storesPermissions[4]["bombtypes"]["BDU50"] = true
storesPermissions[4]["bombtypes"]["MK84"] = true
storesPermissions[4]["bombtypes"]["BDU56"] = true
storesPermissions[4]["bombtypes"]["BDU33"] = true
storesPermissions[4]["bombtypes"]["BLU52"] = true
storesPermissions[4]["cbu"] = true
storesPermissions[4]["cbutypes"] = {}
storesPermissions[4]["cbutypes"]["CBU87"] = true
storesPermissions[4]["cbutypes"]["CBU89"] = true
storesPermissions[4]["cbutypes"]["CBU97"] = true
storesPermissions[4]["cbutypes"]["CBU103"] = true
storesPermissions[4]["cbutypes"]["CBU104"] = true
storesPermissions[4]["cbutypes"]["CBU105"] = true
storesPermissions[4]["gbu"] = true
storesPermissions[4]["gbutypes"] = {}
storesPermissions[4]["gbutypes"]["GBU10"] = true
storesPermissions[4]["gbutypes"]["GBU12"] = true
storesPermissions[4]["gbutypes"]["GBU31"] = true
storesPermissions[4]["gbutypes"]["GBU38"] = true
storesPermissions[4]["misc"] = true
storesPermissions[4]["misctypes"] = {}
storesPermissions[4]["misctypes"]["CTU2A"] = false
storesPermissions[4]["misctypes"]["TK600"] = true
storesPermissions[4]["misctypes"]["TravelPod"] = true
storesPermissions[4]["rocket"] = true
storesPermissions[4]["flare"] = false
storesPermissions[4]["missile"] = false
storesPermissions[4]["pod"] = false
storesPermissions[4]["rack"] = true
storesPermissions[4]["racktypes"] = {}
storesPermissions[4]["racktypes"]["TER"] = true
storesPermissions[4]["racktypes"]["LAU117"] = false
storesPermissions[4]["racktypes"]["LAU88"] = false
storesPermissions[4]["racktypes"]["SUU25"] = false
storesPermissions[4]["racktypes"]["LAU105"] = false
storesPermissions[4]["racktypes"]["LAU68"] = true
storesPermissions[4]["racktypes"]["LAU131"] = true
storesPermissions[5] = {}
storesPermissions[5]["bomb"] = true
storesPermissions[5]["bombtypes"] = {}
storesPermissions[5]["bombtypes"]["MK82"] = true
storesPermissions[5]["bombtypes"]["MK82A"] = true
storesPermissions[5]["bombtypes"]["BDU50"] = true
storesPermissions[5]["bombtypes"]["MK84"] = true
storesPermissions[5]["bombtypes"]["BDU56"] = true
storesPermissions[5]["bombtypes"]["BDU33"] = true
storesPermissions[5]["bombtypes"]["BLU52"] = true
storesPermissions[5]["cbu"] = true
storesPermissions[5]["cbutypes"] = {}
storesPermissions[5]["cbutypes"]["CBU87"] = true
storesPermissions[5]["cbutypes"]["CBU89"] = true
storesPermissions[5]["cbutypes"]["CBU97"] = true
storesPermissions[5]["cbutypes"]["CBU103"] = true
storesPermissions[5]["cbutypes"]["CBU104"] = true
storesPermissions[5]["cbutypes"]["CBU105"] = true
storesPermissions[5]["gbu"] = true
storesPermissions[5]["gbutypes"] = {}
storesPermissions[5]["gbutypes"]["GBU10"] = true
storesPermissions[5]["gbutypes"]["GBU12"] = true
storesPermissions[5]["gbutypes"]["GBU31"] = true
storesPermissions[5]["gbutypes"]["GBU38"] = true
storesPermissions[5]["misc"] = true
storesPermissions[5]["misctypes"] = {}
storesPermissions[5]["misctypes"]["CTU2A"] = false
storesPermissions[5]["misctypes"]["TK600"] = false
storesPermissions[5]["misctypes"]["TravelPod"] = true
storesPermissions[5]["rocket"] = false
storesPermissions[5]["flare"] = false
storesPermissions[5]["missile"] = false
storesPermissions[5]["pod"] = false
storesPermissions[5]["rack"] = true
storesPermissions[5]["racktypes"] = {}
storesPermissions[5]["racktypes"]["TER"] = true
storesPermissions[5]["racktypes"]["LAU117"] = false
storesPermissions[5]["racktypes"]["LAU88"] = false
storesPermissions[5]["racktypes"]["SUU25"] = false
storesPermissions[5]["racktypes"]["LAU105"] = false
storesPermissions[5]["racktypes"]["LAU68"] = false
storesPermissions[5]["racktypes"]["LAU131"] = false
storesPermissions[6] = {}
storesPermissions[6]["bomb"] = true
storesPermissions[6]["bombtypes"] = {}
storesPermissions[6]["bombtypes"]["MK82"] = true
storesPermissions[6]["bombtypes"]["MK82A"] = true
storesPermissions[6]["bombtypes"]["BDU50"] = true
storesPermissions[6]["bombtypes"]["MK84"] = true
storesPermissions[6]["bombtypes"]["BDU56"] = true
storesPermissions[6]["bombtypes"]["BDU33"] = true
storesPermissions[6]["bombtypes"]["BLU52"] = true
storesPermissions[6]["cbu"] = true
storesPermissions[6]["cbutypes"] = {}
storesPermissions[6]["cbutypes"]["CBU87"] = true
storesPermissions[6]["cbutypes"]["CBU89"] = true
storesPermissions[6]["cbutypes"]["CBU97"] = true
storesPermissions[6]["cbutypes"]["CBU103"] = true
storesPermissions[6]["cbutypes"]["CBU104"] = true
storesPermissions[6]["cbutypes"]["CBU105"] = true
storesPermissions[6]["gbu"] = true
storesPermissions[6]["gbutypes"] = {}
storesPermissions[6]["gbutypes"]["GBU10"] = true
storesPermissions[6]["gbutypes"]["GBU12"] = true
storesPermissions[6]["gbutypes"]["GBU31"] = false
storesPermissions[6]["gbutypes"]["GBU38"] = false
storesPermissions[6]["misc"] = true
storesPermissions[6]["misctypes"] = {}
storesPermissions[6]["misctypes"]["CTU2A"] = false
storesPermissions[6]["misctypes"]["TK600"] = true
storesPermissions[6]["misctypes"]["TravelPod"] = true
storesPermissions[6]["rocket"] = false
storesPermissions[6]["flare"] = false
storesPermissions[6]["missile"] = false
storesPermissions[6]["pod"] = false
storesPermissions[6]["rack"] = true
storesPermissions[6]["racktypes"] = {}
storesPermissions[6]["racktypes"]["TER"] = true
storesPermissions[6]["racktypes"]["LAU117"] = false
storesPermissions[6]["racktypes"]["LAU88"] = false
storesPermissions[6]["racktypes"]["SUU25"] = false
storesPermissions[6]["racktypes"]["LAU105"] = false
storesPermissions[6]["racktypes"]["LAU68"] = false
storesPermissions[6]["racktypes"]["LAU131"] = false
storesPermissions[7] = {}
storesPermissions[7]["bomb"] = true
storesPermissions[7]["bombtypes"] = {}
storesPermissions[7]["bombtypes"]["MK82"] = true
storesPermissions[7]["bombtypes"]["MK82A"] = true
storesPermissions[7]["bombtypes"]["BDU50"] = true
storesPermissions[7]["bombtypes"]["MK84"] = true
storesPermissions[7]["bombtypes"]["BDU56"] = true
storesPermissions[7]["bombtypes"]["BDU33"] = true
storesPermissions[7]["bombtypes"]["BLU52"] = true
storesPermissions[7]["cbu"] = true
storesPermissions[7]["cbutypes"] = {}
storesPermissions[7]["cbutypes"]["CBU87"] = true
storesPermissions[7]["cbutypes"]["CBU89"] = true
storesPermissions[7]["cbutypes"]["CBU97"] = true
storesPermissions[7]["cbutypes"]["CBU103"] = true
storesPermissions[7]["cbutypes"]["CBU104"] = true
storesPermissions[7]["cbutypes"]["CBU105"] = true
storesPermissions[7]["gbu"] = true
storesPermissions[7]["gbutypes"] = {}
storesPermissions[7]["gbutypes"]["GBU10"] = true
storesPermissions[7]["gbutypes"]["GBU12"] = true
storesPermissions[7]["gbutypes"]["GBU31"] = true
storesPermissions[7]["gbutypes"]["GBU38"] = true
storesPermissions[7]["misc"] = true
storesPermissions[7]["misctypes"] = {}
storesPermissions[7]["misctypes"]["CTU2A"] = false
storesPermissions[7]["misctypes"]["TK600"] = false
storesPermissions[7]["misctypes"]["TravelPod"] = true
storesPermissions[7]["rocket"] = false
storesPermissions[7]["flare"] = false
storesPermissions[7]["missile"] = false
storesPermissions[7]["pod"] = false
storesPermissions[7]["rack"] = true
storesPermissions[7]["racktypes"] = {}
storesPermissions[7]["racktypes"]["TER"] = true
storesPermissions[7]["racktypes"]["LAU117"] = false
storesPermissions[7]["racktypes"]["LAU88"] = false
storesPermissions[7]["racktypes"]["SUU25"] = false
storesPermissions[7]["racktypes"]["LAU105"] = false
storesPermissions[7]["racktypes"]["LAU68"] = false
storesPermissions[7]["racktypes"]["LAU131"] = false
storesPermissions[8] = {}
storesPermissions[8]["bomb"] = true
storesPermissions[8]["bombtypes"] = {}
storesPermissions[8]["bombtypes"]["MK82"] = true
storesPermissions[8]["bombtypes"]["MK82A"] = true
storesPermissions[8]["bombtypes"]["BDU50"] = true
storesPermissions[8]["bombtypes"]["MK84"] = true
storesPermissions[8]["bombtypes"]["BDU56"] = true
storesPermissions[8]["bombtypes"]["BDU33"] = true
storesPermissions[8]["bombtypes"]["BLU52"] = true
storesPermissions[8]["cbu"] = true
storesPermissions[8]["cbutypes"] = {}
storesPermissions[8]["cbutypes"]["CBU87"] = true
storesPermissions[8]["cbutypes"]["CBU89"] = true
storesPermissions[8]["cbutypes"]["CBU97"] = true
storesPermissions[8]["cbutypes"]["CBU103"] = true
storesPermissions[8]["cbutypes"]["CBU104"] = true
storesPermissions[8]["cbutypes"]["CBU105"] = true
storesPermissions[8]["gbu"] = true
storesPermissions[8]["gbutypes"] = {}
storesPermissions[8]["gbutypes"]["GBU10"] = true
storesPermissions[8]["gbutypes"]["GBU12"] = true
storesPermissions[8]["gbutypes"]["GBU31"] = true
storesPermissions[8]["gbutypes"]["GBU38"] = true
storesPermissions[8]["misc"] = true
storesPermissions[8]["misctypes"] = {}
storesPermissions[8]["misctypes"]["CTU2A"] = false
storesPermissions[8]["misctypes"]["TK600"] = true
storesPermissions[8]["misctypes"]["TravelPod"] = true
storesPermissions[8]["rocket"] = true
storesPermissions[8]["flare"] = false
storesPermissions[8]["missile"] = false
storesPermissions[8]["pod"] = false
storesPermissions[8]["rack"] = true
storesPermissions[8]["racktypes"] = {}
storesPermissions[8]["racktypes"]["TER"] = true
storesPermissions[8]["racktypes"]["LAU117"] = false
storesPermissions[8]["racktypes"]["LAU88"] = false
storesPermissions[8]["racktypes"]["SUU25"] = false
storesPermissions[8]["racktypes"]["LAU105"] = false
storesPermissions[8]["racktypes"]["LAU68"] = true
storesPermissions[8]["racktypes"]["LAU131"] = true
storesPermissions[9] = {}
storesPermissions[9]["bomb"] = true
storesPermissions[9]["bombtypes"] = {}
storesPermissions[9]["bombtypes"]["MK82"] = true
storesPermissions[9]["bombtypes"]["MK82A"] = true
storesPermissions[9]["bombtypes"]["BDU50"] = true
storesPermissions[9]["bombtypes"]["MK84"] = true
storesPermissions[9]["bombtypes"]["BDU56"] = true
storesPermissions[9]["bombtypes"]["BDU33"] = true
storesPermissions[9]["bombtypes"]["BLU52"] = true
storesPermissions[9]["cbu"] = true
storesPermissions[9]["cbutypes"] = {}
storesPermissions[9]["cbutypes"]["CBU87"] = true
storesPermissions[9]["cbutypes"]["CBU89"] = true
storesPermissions[9]["cbutypes"]["CBU97"] = true
storesPermissions[9]["cbutypes"]["CBU103"] = true
storesPermissions[9]["cbutypes"]["CBU104"] = true
storesPermissions[9]["cbutypes"]["CBU105"] = true
storesPermissions[9]["gbu"] = true
storesPermissions[9]["gbutypes"] = {}
storesPermissions[9]["gbutypes"]["GBU10"] = true
storesPermissions[9]["gbutypes"]["GBU12"] = true
storesPermissions[9]["gbutypes"]["GBU31"] = true
storesPermissions[9]["gbutypes"]["GBU38"] = true
storesPermissions[9]["misc"] = true
storesPermissions[9]["misctypes"] = {}
storesPermissions[9]["misctypes"]["CTU2A"] = true
storesPermissions[9]["misctypes"]["TK600"] = false
storesPermissions[9]["misctypes"]["TravelPod"] = true
storesPermissions[9]["rocket"] = true
storesPermissions[9]["flare"] = true
storesPermissions[9]["missile"] = true
storesPermissions[9]["missiletypes"] = {}
storesPermissions[9]["missiletypes"]["AIM9"] = false
storesPermissions[9]["missiletypes"]["AGM65"] = true
storesPermissions[9]["pod"] = false
storesPermissions[9]["rack"] = true
storesPermissions[9]["racktypes"] = {}
storesPermissions[9]["racktypes"]["TER"] = true
storesPermissions[9]["racktypes"]["LAU117"] = true
storesPermissions[9]["racktypes"]["LAU88"] = true
storesPermissions[9]["racktypes"]["SUU25"] = true
storesPermissions[9]["racktypes"]["LAU105"] = false
storesPermissions[9]["racktypes"]["LAU68"] = true
storesPermissions[9]["racktypes"]["LAU131"] = true
storesPermissions[10] = {}
storesPermissions[10]["bomb"] = true
storesPermissions[10]["bombtypes"] = {}
storesPermissions[10]["bombtypes"]["MK82"] = true
storesPermissions[10]["bombtypes"]["MK82A"] = true
storesPermissions[10]["bombtypes"]["BDU50"] = true
storesPermissions[10]["bombtypes"]["MK84"] = false
storesPermissions[10]["bombtypes"]["BDU56"] = false
storesPermissions[10]["bombtypes"]["BDU33"] = false
storesPermissions[10]["bombtypes"]["BLU52"] = true
storesPermissions[10]["cbu"] = true
storesPermissions[10]["cbutypes"] = {}
storesPermissions[10]["cbutypes"]["CBU87"] = true
storesPermissions[10]["cbutypes"]["CBU89"] = true
storesPermissions[10]["cbutypes"]["CBU97"] = true
storesPermissions[10]["cbutypes"]["CBU103"] = false
storesPermissions[10]["cbutypes"]["CBU104"] = false
storesPermissions[10]["cbutypes"]["CBU105"] = false
storesPermissions[10]["gbu"] = true
storesPermissions[10]["gbutypes"] = {}
storesPermissions[10]["gbutypes"]["GBU10"] = false
storesPermissions[10]["gbutypes"]["GBU12"] = true
storesPermissions[10]["gbutypes"]["GBU31"] = false
storesPermissions[10]["gbutypes"]["GBU38"] = false
storesPermissions[10]["misc"] = false
storesPermissions[10]["rocket"] = true
storesPermissions[10]["flare"] = true
storesPermissions[10]["missile"] = false
storesPermissions[10]["pod"] = true
storesPermissions[10]["podtypes"] = {}
storesPermissions[10]["podtypes"]["LITENING"] = true
storesPermissions[10]["podtypes"]["ALQ131"] = false
storesPermissions[10]["podtypes"]["ALQ184"] = false
storesPermissions[10]["rack"] = true
storesPermissions[10]["racktypes"] = {}
storesPermissions[10]["racktypes"]["TER"] = false
storesPermissions[10]["racktypes"]["LAU117"] = false
storesPermissions[10]["racktypes"]["LAU88"] = false
storesPermissions[10]["racktypes"]["SUU25"] = true
storesPermissions[10]["racktypes"]["LAU105"] = false
storesPermissions[10]["racktypes"]["LAU68"] = true
storesPermissions[10]["racktypes"]["LAU131"] = true
storesPermissions[11] = {}
storesPermissions[11]["bomb"] = true
storesPermissions[11]["bombtypes"] = {}
storesPermissions[11]["bombtypes"]["MK82"] = true
storesPermissions[11]["bombtypes"]["MK82A"] = true
storesPermissions[11]["bombtypes"]["BDU50"] = true
storesPermissions[11]["bombtypes"]["MK84"] = false
storesPermissions[11]["bombtypes"]["BDU56"] = false
storesPermissions[11]["bombtypes"]["BDU33"] = false
storesPermissions[11]["bombtypes"]["BLU52"] = false
storesPermissions[11]["cbu"] = true
storesPermissions[11]["cbutypes"] = {}
storesPermissions[11]["cbutypes"]["CBU87"] = true
storesPermissions[11]["cbutypes"]["CBU89"] = true
storesPermissions[11]["cbutypes"]["CBU97"] = true
storesPermissions[11]["cbutypes"]["CBU103"] = false
storesPermissions[11]["cbutypes"]["CBU104"] = false
storesPermissions[11]["cbutypes"]["CBU105"] = false
storesPermissions[11]["gbu"] = true
storesPermissions[11]["gbutypes"] = {}
storesPermissions[11]["gbutypes"]["GBU10"] = false
storesPermissions[11]["gbutypes"]["GBU12"] = true
storesPermissions[11]["gbutypes"]["GBU31"] = false
storesPermissions[11]["gbutypes"]["GBU38"] = false
storesPermissions[11]["misc"] = false
storesPermissions[11]["rocket"] = false
storesPermissions[11]["flare"] = false
storesPermissions[11]["missile"] = true
storesPermissions[11]["missiletypes"] = {}
storesPermissions[11]["missiletypes"]["AIM9"] = true
storesPermissions[11]["missiletypes"]["AGM65"] = false
storesPermissions[11]["pod"] = true
storesPermissions[11]["podtypes"] = {}
storesPermissions[11]["podtypes"]["LITENING"] = false
storesPermissions[11]["podtypes"]["ALQ131"] = true
storesPermissions[11]["podtypes"]["ALQ184"] = true
storesPermissions[11]["rack"] = true
storesPermissions[11]["racktypes"] = {}
storesPermissions[11]["racktypes"]["TER"] = false
storesPermissions[11]["racktypes"]["LAU117"] = false
storesPermissions[11]["racktypes"]["LAU88"] = false
storesPermissions[11]["racktypes"]["SUU25"] = false
storesPermissions[11]["racktypes"]["LAU105"] = true
storesPermissions[11]["racktypes"]["LAU68"] = false
storesPermissions[11]["racktypes"]["LAU131"] = false

TYPE_STRINGS = {}
TYPE_STRINGS["MAV"]		= AGM65D
TYPE_STRINGS["BDU33"]	= BDU33
TYPE_STRINGS["MK84"]	= MK84
TYPE_STRINGS["MK82"]	= MK82
TYPE_STRINGS["CBU97"]	= CBU97
TYPE_STRINGS["LUU2B"]	= LUU2B
TYPE_STRINGS["BDU50LD"]	= BDU50LD
TYPE_STRINGS["BDU56LD"]	= BDU56LD
TYPE_STRINGS["GBU10"]	= GBU10
TYPE_STRINGS["GBU12"]	= GBU12
TYPE_STRINGS["GBU31"]	= GBU31
TYPE_STRINGS["GBU38"]	= GBU38
TYPE_STRINGS["CBU87"]	= CBU87
TYPE_STRINGS["CBU89"]	= CBU89
TYPE_STRINGS["CBU97"]	= CBU97
TYPE_STRINGS["M257"]	= M257
TYPE_STRINGS["M278"]	= M278
TYPE_STRINGS["M151"]	= M151
TYPE_STRINGS["M156"]	= M156
TYPE_STRINGS["WTU"]		= WTU1B
TYPE_STRINGS["M274"]	= M274
TYPE_STRINGS["MK1"]		= MK1
TYPE_STRINGS["MK5"]		= MK5
TYPE_STRINGS["MK61"]	= MK61
TYPE_STRINGS["LUU2AB"]	= LUU2AB
TYPE_STRINGS["LUU2BB"]	= LUU2BB
TYPE_STRINGS["LUU19B"]	= LUU19
TYPE_STRINGS["CBU103"]	= CBU103
TYPE_STRINGS["CBU104"]	= CBU104
TYPE_STRINGS["CBU105"]	= CBU105

maverick_types = {}
maverick_types["AGM65D"] = AGM65D
maverick_types["AGM65G"] = AGM65G
maverick_types["AGM65H"] = AGM65H
maverick_types["AGM65K"] = AGM65K
maverick_types["TGM65D"] = TGM65D
maverick_types["TGM65G"] = TGM65G
maverick_types["CTM65K"] = CATM65K

rocket_types = {}
rocket_types["M151"] = M151
rocket_types["M156"] = M156
rocket_types["M257"] = M257
rocket_types["M274"] = M274
rocket_types["M278"] = M278
rocket_types["MK1"] = MK1
rocket_types["MK5"] = MK5
rocket_types["WTU"] = WTU1B
rocket_types["MK61"] = MK61

flare_types = {}
--	flare_types["LUU1"] = M151
flare_types["LUU19B"] = LUU19
flare_types["LUU2B"] = LUU2B
flare_types["LUU2AB"] = LUU2AB
flare_types["LUU2BB"] = LUU2BB
--	flare_types["LUU5"] = M151
--	flare_types["LUU6"] = M151

sidewinder_types = {}
sidewinder_types["AIM9"]	= AIM9
sidewinder_types["CATM9"]	= CATM9

common_types = {}
common_types["BDU33"] = BDU33
common_types["CBU87"] = CBU87
common_types["CBU89"] = CBU89
common_types["CBU97"] = CBU97
common_types["GBU10"] = GBU10
common_types["GBU12"] = GBU12
common_types["GBU31"] = GBU31
common_types["GBU38"] = GBU38
common_types["LITPOD"] = LITENING
common_types["TK600"] = FUEL_TANK
common_types["MXU"] = TRAV_POD
common_types["MK84"] = MK84
common_types["MK82A"] = MK82AIR
common_types["MK82L"] = MK82
common_types["BDU50G"] = BDU50LGB
common_types["BDU50H"] = BDU50HD
common_types["BDU50L"] = BDU50LD
common_types["BDU56"]  = BDU56LD
common_types["CBU103"] = CBU103
common_types["CBU104"] = CBU104
common_types["CBU105"] = CBU105
	
DATA_LAUNCHER		= 0
DATA_MIN_ALT		= 1
DATA_ESC_MNVR		= 2
DATA_DES_TOF		= 3
DATA_NOSE_FZ		= 4
DATA_TAIL_FZ		= 5
DATA_ADJ_RT			= 6
DATA_ADJ_UP			= 7
DATA_EJECT_VEL		= 8
DATA_RACK_DEL		= 9
DATA_FZU39			= 10
DATA_FUNC_TIME		= 11
DATA_HOF			= 12
DATA_FF_DIST		= 13
DATA_HOT			= 14
DATA_SERIES			= 15
DATA_MIN_TOF		= 16
DATA_CONFIG			= 17
DATA_AUTO_LS		= 18
DATA_SOLN			= 19
DATA_LS_TIME		= 20
DATA_DES_HD_TOF		= 21
DATA_DES_LD_TOF		= 22
DATA_POD_SET		= 23
DATA_DRAG			= 24
DATA_LASER_CODE		= 25
DATA_RPM			= 26
DATA_PATT_AZ		= 27
DATA_IMP_AZ			= 28
DATA_IMP_ANG		= 29
DATA_IAM_TARGET		= 30

LAUNCHER_PARAMS = {}
LAUNCHER_PARAMS["StringName"]	= "LAUNCHER:"
LAUNCHER_PARAMS["Format"]		= "%s"
LAUNCHER_PARAMS["IsUnderline"]	= false
LAUNCHER_PARAMS["ParamType"]	= DATA_LAUNCHER

MIN_ALT_PARAMS = {}
MIN_ALT_PARAMS["StringName"]	= "MIN ALT:"
MIN_ALT_PARAMS["Format"] 		= "%d"
MIN_ALT_PARAMS["IsUnderline"]	= true
MIN_ALT_PARAMS["ParamType"]		= DATA_MIN_ALT

ESC_MNVR_PARAMS = {}
ESC_MNVR_PARAMS["StringName"]	= "ESC MNVR:"
ESC_MNVR_PARAMS["Format"]		= "%s"
ESC_MNVR_PARAMS["IsUnderline"]	= true
ESC_MNVR_PARAMS["ParamType"]	= DATA_ESC_MNVR

ESC_MNVR_NAMES = {"NONE", "CLM", "TRN", "TLT"}

BMB_MNT_PARAMS = {}
BMB_MNT_PARAMS["StringName"]	= "BMB MNT:"
BMB_MNT_PARAMS["Format"]		= "%s"
BMB_MNT_PARAMS["IsUnderline"]	= false
BMB_MNT_PARAMS["ParamType"]		= DATA_LAUNCHER

DES_TOF_PARAMS = {}
DES_TOF_PARAMS["StringName"]	= "DES TOF:"
DES_TOF_PARAMS["Format"]		= "%.1f"
DES_TOF_PARAMS["IsUnderline"]	= true
DES_TOF_PARAMS["ParamType"]		= DATA_DES_TOF

MIN_TOF_PARAMS = {}
MIN_TOF_PARAMS["StringName"]	= "MIN TOF:"
MIN_TOF_PARAMS["Format"]		= "%.1f"
MIN_TOF_PARAMS["IsUnderline"]	= true
MIN_TOF_PARAMS["ParamType"]		= DATA_MIN_TOF

NOSE_FZ_PARAMS = {}
NOSE_FZ_PARAMS["StringName"]	= "N-"
NOSE_FZ_PARAMS["Format"]		= "%s"
NOSE_FZ_PARAMS["IsUnderline"]	= false
NOSE_FZ_PARAMS["ParamType"]		= DATA_NOSE_FZ

TAIL_FZ_PARAMS = {}
TAIL_FZ_PARAMS["StringName"]	= "T-"
TAIL_FZ_PARAMS["Format"]		= "%s"
TAIL_FZ_PARAMS["IsUnderline"]	= false
TAIL_FZ_PARAMS["ParamType"]		= DATA_TAIL_FZ

ADJ_RT_PARAMS = {}
ADJ_RT_PARAMS["StringName"]		= " ADJ RT:"
ADJ_RT_PARAMS["Format"] 		= "%d"
ADJ_RT_PARAMS["IsUnderline"]	= true
ADJ_RT_PARAMS["ParamType"]		= DATA_ADJ_RT

ADJ_UP_PARAMS = {}
ADJ_UP_PARAMS["StringName"]		= " ADJ UP:"
ADJ_UP_PARAMS["Format"] 		= "%d"
ADJ_UP_PARAMS["IsUnderline"]	= true
ADJ_UP_PARAMS["ParamType"]		= DATA_ADJ_UP

EJECT_VEL_PARAMS = {}
EJECT_VEL_PARAMS["StringName"]	= " EJECT VEL:"
EJECT_VEL_PARAMS["Format"] 		= "%d"
EJECT_VEL_PARAMS["IsUnderline"]	= true
EJECT_VEL_PARAMS["ParamType"]	= DATA_EJECT_VEL

RACK_DEL_PARAMS = {}
RACK_DEL_PARAMS["StringName"]	= " RACK DEL:"
RACK_DEL_PARAMS["Format"]		= "%.2f"
RACK_DEL_PARAMS["IsUnderline"]	= true
RACK_DEL_PARAMS["ParamType"]	= DATA_RACK_DEL

FZU39_PARAMS = {}
FZU39_PARAMS["StringName"]		= "FZU39:"
FZU39_PARAMS["Format"]			= "%s"
FZU39_PARAMS["IsUnderline"]		= false
FZU39_PARAMS["ParamType"]		= DATA_FZU39

FZU39_NAMES = {"YES", "NO"}

FUNC_TIME_PARAMS = {}
FUNC_TIME_PARAMS["StringName"]	= "FUNC TIME:"
FUNC_TIME_PARAMS["Format"]		= "%s"
FUNC_TIME_PARAMS["IsUnderline"]	= false
FUNC_TIME_PARAMS["ParamType"]	= DATA_FUNC_TIME

FUNC_TIME_NAMES = {".63 - M", ".95 - N", "1.28 - O", "1.60 - P", "1.92 - R", "2.23 - S"}
FUNC_TIME_DATA = {	0.63,		0.95,		1.28,		1.60,		1.92,		2.23}

HOF_PARAMS = {}
HOF_PARAMS["StringName"]		= "HOF:"
HOF_PARAMS["Format"]			= "%s"
HOF_PARAMS["IsUnderline"]		= false
HOF_PARAMS["ParamType"]			= DATA_HOF

HOF_NAMES = {"300 - A", "500 - B", "700 - C", "900 - D", "1200 - E", "1500 - F", "1800 - G", "2200 - H", "2600 - J", "3000 - K"}
HOF_DATA = {300, 		500,		700,		900,		1200,		1500,		1800,		2200,		2600,		3000}

RPM_PARAMS = {}
RPM_PARAMS["StringName"]		= "RPM:"
RPM_PARAMS["Format"]			= "%s"
RPM_PARAMS["IsUnderline"]		= false
RPM_PARAMS["ParamType"]			= DATA_RPM

RPM_NAMES = {"0 - 1", "500 - 2", "1000 - 3", "1500 - 4", "2000 - 5", "2500 - 6"}
RPM_DATA  = {0, 	   500,	      1000,		  1500,		  2000,		  2500}

SUU25_MNT_PARAMS = {}
SUU25_MNT_PARAMS["StringName"]	= "SUU25 MNT:"
SUU25_MNT_PARAMS["Format"]		= "%s"
SUU25_MNT_PARAMS["IsUnderline"]	= false
SUU25_MNT_PARAMS["ParamType"]	= DATA_LAUNCHER

FF_DIST_PARAMS = {}
FF_DIST_PARAMS["StringName"]	= "FF DIST:"
FF_DIST_PARAMS["Format"] 		= "%s"
FF_DIST_PARAMS["IsUnderline"]	= false
FF_DIST_PARAMS["ParamType"]		= DATA_FF_DIST

HOT_PARAMS = {}
HOT_PARAMS["StringName"]		= "H OVR TGT:"
HOT_PARAMS["Format"] 			= "%d"
HOT_PARAMS["IsUnderline"]		= true
HOT_PARAMS["ParamType"]			= DATA_HOT

SERIES_PARAMS = {}
SERIES_PARAMS["StringName"]		= "SERIES:"
SERIES_PARAMS["Format"] 		= "%s"
SERIES_PARAMS["IsUnderline"]	= false
SERIES_PARAMS["ParamType"]		= DATA_SERIES

SERIES_NAMES = {"/B", "A/B", "B/B", "C/B", "D/B", "E/B"}

CONFIG_PARAMS = {}
CONFIG_PARAMS["StringName"]		= "CONFIG:"
CONFIG_PARAMS["Format"] 		= "%s"
CONFIG_PARAMS["IsUnderline"]	= false
CONFIG_PARAMS["ParamType"]		= DATA_CONFIG

CONFIG_LDGP						= 0
CONFIG_LGB						= 1
CONFIG_FIXED_HI					= 2
CONFIG_FIXED_LO					= 3
CONFIG_PLT_OPT					= 4
CONFIG_PLT_OPT1					= 5
CONFIG_PLT_OPT2					= 6

CONFIG_NAMES = {"LDGP", "LGB", "FIXED HI", "FIXED LO", "PLT OPT", "PLT OPT1", "PLT OPT2"}

AUTO_LS_PARAMS = {}
AUTO_LS_PARAMS["StringName"]	= "AUTO LASE:"
AUTO_LS_PARAMS["Format"] 		= "%s"
AUTO_LS_PARAMS["IsUnderline"]	= true
AUTO_LS_PARAMS["ParamType"]		= DATA_AUTO_LS

AUTO_LS_NAMES = {"ON", "OFF"}

SOLN_PARAMS = {}
SOLN_PARAMS["StringName"]		= "SOLUTION:"
SOLN_PARAMS["Format"] 			= "%s"
SOLN_PARAMS["IsUnderline"]		= true
SOLN_PARAMS["ParamType"]		= DATA_SOLN

SOLN_NAMES = {"ORP", "BAL"}

LS_TIME_PARAMS = {}
LS_TIME_PARAMS["StringName"]	= "LASE TIME:"
LS_TIME_PARAMS["Format"] 		= "%d SEC"
LS_TIME_PARAMS["IsUnderline"]	= true
LS_TIME_PARAMS["ParamType"]		= DATA_LS_TIME

DES_HD_TOF_PARAMS = {}
DES_HD_TOF_PARAMS["StringName"]	= "DES HD TOF:"
DES_HD_TOF_PARAMS["Format"]		= "%.1f"
DES_HD_TOF_PARAMS["IsUnderline"]= true
DES_HD_TOF_PARAMS["ParamType"]	= DATA_DES_HD_TOF

DES_LD_TOF_PARAMS = {}
DES_LD_TOF_PARAMS["StringName"]	= "DES LD TOF:"
DES_LD_TOF_PARAMS["Format"]		= "%.1f"
DES_LD_TOF_PARAMS["IsUnderline"]= true
DES_LD_TOF_PARAMS["ParamType"]	= DATA_DES_LD_TOF

POD_SET_PARAMS = {}
POD_SET_PARAMS["StringName"]	= "POD SET:"
POD_SET_PARAMS["Format"] 		= "%s"
POD_SET_PARAMS["IsUnderline"]	= false
POD_SET_PARAMS["ParamType"]		= DATA_POD_SET

POD_SET_NAMES = {"SINGLE", "RIPPLE"}

LAU_MNT_PARAMS = {}
LAU_MNT_PARAMS["StringName"]	= "LAUNCHER:"
LAU_MNT_PARAMS["Format"]		= "%s"
LAU_MNT_PARAMS["IsUnderline"]	= false
LAU_MNT_PARAMS["ParamType"]		= DATA_LAUNCHER

DRAG_PARAMS = {}
DRAG_PARAMS["StringName"]		= "DRAG:"
DRAG_PARAMS["Format"]			= "%.2f"
DRAG_PARAMS["IsUnderline"]		= true
DRAG_PARAMS["ParamType"]		= DATA_DRAG

LASER_CODE_PARAMS = {}
LASER_CODE_PARAMS["StringName"]	= "LASER CODE:"
LASER_CODE_PARAMS["Format"] 	= "%s"
LASER_CODE_PARAMS["IsUnderline"]= false
LASER_CODE_PARAMS["ParamType"]	= DATA_LASER_CODE


PATT_AZ_PARAMS = {}
PATT_AZ_PARAMS["StringName"]	= "PATT AZ:"
PATT_AZ_PARAMS["Format"] 		= "%d"
PATT_AZ_PARAMS["IsUnderline"]	= true
PATT_AZ_PARAMS["ParamType"]		= DATA_PATT_AZ

IMP_AZ_PARAMS = {}
IMP_AZ_PARAMS["StringName"]		= "IMP AZ:"
IMP_AZ_PARAMS["Format"] 		= "%d"
IMP_AZ_PARAMS["IsUnderline"]	= true
IMP_AZ_PARAMS["ParamType"]		= DATA_IMP_AZ

IMP_ANG_PARAMS = {}
IMP_ANG_PARAMS["StringName"]	= "IMP ANG:"
IMP_ANG_PARAMS["Format"] 		= "%d"
IMP_ANG_PARAMS["IsUnderline"]	= true
IMP_ANG_PARAMS["ParamType"]		= DATA_IMP_ANG

IAM_TARGET_PARAMS = {}
IAM_TARGET_PARAMS["StringName"]= "TARGET:"
IAM_TARGET_PARAMS["Format"] 	= "%s"
IAM_TARGET_PARAMS["IsUnderline"]= true
IAM_TARGET_PARAMS["ParamType"]	= DATA_IAM_TARGET

RELEASE_MODES = {"SGL", "PRS", "RIP SGL", "RIP PRS"}
IAM_RELEASE_MODES = {"SGL"}
FUZE_TYPES = {"N/T", "N", " /T"}

local idx
ProfileParametrsByWpn = {}
--AGM-65D
idx = #ProfileParametrsByWpn + 1
local idx_mav = idx
ProfileParametrsByWpn[idx] = {}
ProfileParametrsByWpn[idx]["type"] = AGM65D
ProfileParametrsByWpn[idx]["strings"] = {}
ProfileParametrsByWpn[idx]["strings"][1] = LAUNCHER_PARAMS
ProfileParametrsByWpn[idx]["strings"][2] = MIN_ALT_PARAMS
ProfileParametrsByWpn[idx]["settings"] = {}
ProfileParametrsByWpn[idx]["settings"][1] = DATA_MIN_ALT
--AGM-65K
idx = #ProfileParametrsByWpn + 1
ProfileParametrsByWpn[idx] = {}
ProfileParametrsByWpn[idx]["type"] = AGM65K
ProfileParametrsByWpn[idx]["strings"]		= ProfileParametrsByWpn[idx_mav]["strings"]
ProfileParametrsByWpn[idx]["settings"]	= ProfileParametrsByWpn[idx_mav]["settings"]
--AGM-65G
idx = #ProfileParametrsByWpn + 1
ProfileParametrsByWpn[idx] = {}
ProfileParametrsByWpn[idx]["type"] = AGM65G
ProfileParametrsByWpn[idx]["strings"]		= ProfileParametrsByWpn[idx_mav]["strings"]
ProfileParametrsByWpn[idx]["settings"]	= ProfileParametrsByWpn[idx_mav]["settings"]
--AGM-65H
idx = #ProfileParametrsByWpn + 1
ProfileParametrsByWpn[idx] = {}
ProfileParametrsByWpn[idx]["type"] = AGM65H
ProfileParametrsByWpn[idx]["strings"]		= ProfileParametrsByWpn[idx_mav]["strings"]
ProfileParametrsByWpn[idx]["settings"]	= ProfileParametrsByWpn[idx_mav]["settings"]
--TGM-65D
idx = #ProfileParametrsByWpn + 1
ProfileParametrsByWpn[idx] = {}
ProfileParametrsByWpn[idx]["type"] = TGM65D
ProfileParametrsByWpn[idx]["strings"]		= ProfileParametrsByWpn[idx_mav]["strings"]
ProfileParametrsByWpn[idx]["settings"]	= ProfileParametrsByWpn[idx_mav]["settings"]
--TGM-65G
idx = #ProfileParametrsByWpn + 1
ProfileParametrsByWpn[idx] = {}
ProfileParametrsByWpn[idx]["type"] = TGM65G
ProfileParametrsByWpn[idx]["strings"]		= ProfileParametrsByWpn[idx_mav]["strings"]
ProfileParametrsByWpn[idx]["settings"]	= ProfileParametrsByWpn[idx_mav]["settings"]
--TGM-65H
idx = #ProfileParametrsByWpn + 1
ProfileParametrsByWpn[idx] = {}
ProfileParametrsByWpn[idx]["type"] = TGM65H
ProfileParametrsByWpn[idx]["strings"]		= ProfileParametrsByWpn[idx_mav]["strings"]
ProfileParametrsByWpn[idx]["settings"]	= ProfileParametrsByWpn[idx_mav]["settings"]
--CATM_65K
idx = #ProfileParametrsByWpn + 1
ProfileParametrsByWpn[idx] = {}
ProfileParametrsByWpn[idx]["type"] = CATM65K
ProfileParametrsByWpn[idx]["strings"]	= ProfileParametrsByWpn[idx_mav]["strings"]
ProfileParametrsByWpn[idx]["settings"]	= ProfileParametrsByWpn[idx_mav]["settings"]
--BDU-33
idx = #ProfileParametrsByWpn + 1
ProfileParametrsByWpn[idx] = {}
ProfileParametrsByWpn[idx]["type"] = BDU33
ProfileParametrsByWpn[idx]["strings"] = {}
ProfileParametrsByWpn[idx]["strings"][1] = ESC_MNVR_PARAMS
ProfileParametrsByWpn[idx]["strings"][2] = SERIES_PARAMS
ProfileParametrsByWpn[idx]["strings"][3] = MIN_TOF_PARAMS
ProfileParametrsByWpn[idx]["strings"][4] = DES_TOF_PARAMS
ProfileParametrsByWpn[idx]["strings"][5] = MIN_ALT_PARAMS
ProfileParametrsByWpn[idx]["strings"][6] = ADJ_RT_PARAMS
ProfileParametrsByWpn[idx]["strings"][7] = ADJ_UP_PARAMS
ProfileParametrsByWpn[idx]["strings"][8] = EJECT_VEL_PARAMS
ProfileParametrsByWpn[idx]["strings"][9] = RACK_DEL_PARAMS
ProfileParametrsByWpn[idx]["settings"] = {}
ProfileParametrsByWpn[idx]["settings"][1] = DATA_MIN_ALT
ProfileParametrsByWpn[idx]["settings"][2] = DATA_ADJ_RT
ProfileParametrsByWpn[idx]["settings"][3] = DATA_ADJ_UP
ProfileParametrsByWpn[idx]["settings"][4] = DATA_EJECT_VEL
ProfileParametrsByWpn[idx]["settings"][5] = DATA_RACK_DEL
ProfileParametrsByWpn[idx]["settings"][6] = DATA_DES_TOF
ProfileParametrsByWpn[idx]["settings"][7] = DATA_ESC_MNVR
ProfileParametrsByWpn[idx]["settings"][8] = DATA_MIN_TOF
--MK-84
idx = #ProfileParametrsByWpn + 1
ProfileParametrsByWpn[idx] = {}
ProfileParametrsByWpn[idx]["type"] = MK84
ProfileParametrsByWpn[idx]["strings"] = {}
ProfileParametrsByWpn[idx]["strings"][1] = ESC_MNVR_PARAMS
ProfileParametrsByWpn[idx]["strings"][2] = BMB_MNT_PARAMS
ProfileParametrsByWpn[idx]["strings"][3] = DES_TOF_PARAMS
ProfileParametrsByWpn[idx]["strings"][4] = NOSE_FZ_PARAMS
ProfileParametrsByWpn[idx]["strings"][5] = TAIL_FZ_PARAMS
ProfileParametrsByWpn[idx]["strings"][6] = MIN_ALT_PARAMS
ProfileParametrsByWpn[idx]["strings"][7] = ADJ_RT_PARAMS
ProfileParametrsByWpn[idx]["strings"][8] = ADJ_UP_PARAMS
ProfileParametrsByWpn[idx]["strings"][9] = EJECT_VEL_PARAMS
ProfileParametrsByWpn[idx]["strings"][10] = RACK_DEL_PARAMS
ProfileParametrsByWpn[idx]["settings"] = {}
ProfileParametrsByWpn[idx]["settings"][1] = DATA_MIN_ALT
ProfileParametrsByWpn[idx]["settings"][2] = DATA_ADJ_RT
ProfileParametrsByWpn[idx]["settings"][3] = DATA_ADJ_UP
ProfileParametrsByWpn[idx]["settings"][4] = DATA_EJECT_VEL
ProfileParametrsByWpn[idx]["settings"][5] = DATA_RACK_DEL
ProfileParametrsByWpn[idx]["settings"][6] = DATA_DES_TOF
ProfileParametrsByWpn[idx]["settings"][7] = DATA_ESC_MNVR
ProfileParametrsByWpn[idx]["nose_fuzes"] = {}
ProfileParametrsByWpn[idx]["nose_fuzes"][1] = NOSE_FZ_NONE
ProfileParametrsByWpn[idx]["nose_fuzes"][2] = NOSE_FZ_FMU139LD
ProfileParametrsByWpn[idx]["nose_fuzes"][3] = NOSE_FZ_FMU26BB
ProfileParametrsByWpn[idx]["nose_fuzes"][4] = NOSE_FZ_FMU72B
ProfileParametrsByWpn[idx]["nose_fuzes"][5] = NOSE_FZ_M904
ProfileParametrsByWpn[idx]["nose_fuzes"][6] = NOSE_FZ_DSU33
ProfileParametrsByWpn[idx]["nose_fuzes"][7] = NOSE_FZ_FMU_113B
ProfileParametrsByWpn[idx]["nose_set_by_fuze"] = {}
ProfileParametrsByWpn[idx]["nose_set_by_fuze"][NOSE_FZ_FMU139LD] = {NOSE_SET_4, NOSE_SET_6, NOSE_SET_7, NOSE_SET_10, NOSE_SET_14, NOSE_SET_20}
ProfileParametrsByWpn[idx]["nose_set_by_fuze"][NOSE_FZ_FMU26BB] = {NOSE_SET_2, NOSE_SET_4, NOSE_SET_6, NOSE_SET_8, NOSE_SET_10, NOSE_SET_12, NOSE_SET_14, NOSE_SET_16, NOSE_SET_18, NOSE_SET_20}
ProfileParametrsByWpn[idx]["nose_set_by_fuze"][NOSE_FZ_FMU72B] = {NOSE_SET_6}
ProfileParametrsByWpn[idx]["nose_set_by_fuze"][NOSE_FZ_M904] = {NOSE_SET_2, NOSE_SET_4, NOSE_SET_6, NOSE_SET_8, NOSE_SET_10, NOSE_SET_12, NOSE_SET_14, NOSE_SET_16, NOSE_SET_18}
ProfileParametrsByWpn[idx]["nose_set_by_fuze"][NOSE_FZ_FMU_113B] = {NOSE_SET_18}
ProfileParametrsByWpn[idx]["tail_fuze_by_fuze"] = {}
ProfileParametrsByWpn[idx]["tail_fuze_by_fuze"][NOSE_FZ_NONE] = {TAIL_FZ_FMU139LD, TAIL_FZ_FMU26BB, TAIL_FZ_FMU72B, TAIL_FZ_M905}
ProfileParametrsByWpn[idx]["tail_fuze_by_fuze"][NOSE_FZ_FMU139LD] = {TAIL_FZ_NONE, TAIL_FZ_FMU139LD, TAIL_FZ_FMU26BB, TAIL_FZ_FMU72B, TAIL_FZ_M905}
ProfileParametrsByWpn[idx]["tail_fuze_by_fuze"][NOSE_FZ_FMU26BB] = {TAIL_FZ_NONE, TAIL_FZ_FMU139LD, TAIL_FZ_FMU26BB, TAIL_FZ_FMU72B, TAIL_FZ_M905}
ProfileParametrsByWpn[idx]["tail_fuze_by_fuze"][NOSE_FZ_FMU72B] = {TAIL_FZ_NONE, TAIL_FZ_FMU139LD, TAIL_FZ_FMU26BB, TAIL_FZ_FMU72B, TAIL_FZ_M905}
ProfileParametrsByWpn[idx]["tail_fuze_by_fuze"][NOSE_FZ_M904] = {TAIL_FZ_NONE, TAIL_FZ_FMU139LD, TAIL_FZ_FMU26BB, TAIL_FZ_FMU72B, TAIL_FZ_M905}
ProfileParametrsByWpn[idx]["tail_fuze_by_fuze"][NOSE_FZ_DSU33] = {TAIL_FZ_FMU139LD}
ProfileParametrsByWpn[idx]["tail_fuze_by_fuze"][NOSE_FZ_FMU_113B] = {TAIL_FZ_NONE, TAIL_FZ_FMU139LD, TAIL_FZ_FMU26BB, TAIL_FZ_FMU72B, TAIL_FZ_M905}
ProfileParametrsByWpn[idx]["tail_set_by_fuze"] = {}
ProfileParametrsByWpn[idx]["tail_set_by_fuze"][TAIL_FZ_FMU139LD] = {TAIL_SET_4, TAIL_SET_6, TAIL_SET_7, TAIL_SET_10, TAIL_SET_14, TAIL_SET_20}
ProfileParametrsByWpn[idx]["tail_set_by_fuze"][TAIL_FZ_FMU26BB] = {TAIL_SET_2, TAIL_SET_4, TAIL_SET_6, TAIL_SET_8, TAIL_SET_10, TAIL_SET_12, TAIL_SET_14, TAIL_SET_16, TAIL_SET_18, TAIL_SET_20}
ProfileParametrsByWpn[idx]["tail_set_by_fuze"][TAIL_FZ_FMU72B] = {TAIL_SET_6}
ProfileParametrsByWpn[idx]["tail_set_by_fuze"][TAIL_FZ_M905] = {TAIL_SET_4, TAIL_SET_6, TAIL_SET_8, TAIL_SET_12, TAIL_SET_16, TAIL_SET_20}
--MK-82
idx = #ProfileParametrsByWpn + 1
ProfileParametrsByWpn[idx] = {}
ProfileParametrsByWpn[idx]["type"] = MK82
ProfileParametrsByWpn[idx]["strings"] = {}
ProfileParametrsByWpn[idx]["strings"][1] = ESC_MNVR_PARAMS
ProfileParametrsByWpn[idx]["strings"][2] = BMB_MNT_PARAMS
ProfileParametrsByWpn[idx]["strings"][3] = DES_TOF_PARAMS
ProfileParametrsByWpn[idx]["strings"][4] = NOSE_FZ_PARAMS
ProfileParametrsByWpn[idx]["strings"][5] = TAIL_FZ_PARAMS
ProfileParametrsByWpn[idx]["strings"][6] = MIN_ALT_PARAMS
ProfileParametrsByWpn[idx]["strings"][7] = ADJ_RT_PARAMS
ProfileParametrsByWpn[idx]["strings"][8] = ADJ_UP_PARAMS
ProfileParametrsByWpn[idx]["strings"][9] = EJECT_VEL_PARAMS
ProfileParametrsByWpn[idx]["strings"][10] = RACK_DEL_PARAMS
ProfileParametrsByWpn[idx]["settings"] = {}
ProfileParametrsByWpn[idx]["settings"][1] = DATA_MIN_ALT
ProfileParametrsByWpn[idx]["settings"][2] = DATA_ADJ_RT
ProfileParametrsByWpn[idx]["settings"][3] = DATA_ADJ_UP
ProfileParametrsByWpn[idx]["settings"][4] = DATA_EJECT_VEL
ProfileParametrsByWpn[idx]["settings"][5] = DATA_RACK_DEL
ProfileParametrsByWpn[idx]["settings"][6] = DATA_DES_TOF
ProfileParametrsByWpn[idx]["settings"][7] = DATA_ESC_MNVR
ProfileParametrsByWpn[idx]["nose_fuzes"] = {}
ProfileParametrsByWpn[idx]["nose_fuzes"][1] = NOSE_FZ_NONE
ProfileParametrsByWpn[idx]["nose_fuzes"][2] = NOSE_FZ_FMU139LD
ProfileParametrsByWpn[idx]["nose_fuzes"][3] = NOSE_FZ_FMU26BB
ProfileParametrsByWpn[idx]["nose_fuzes"][4] = NOSE_FZ_FMU72B
ProfileParametrsByWpn[idx]["nose_fuzes"][5] = NOSE_FZ_M904
ProfileParametrsByWpn[idx]["nose_fuzes"][6] = NOSE_FZ_DSU33
ProfileParametrsByWpn[idx]["nose_fuzes"][7] = NOSE_FZ_FMU_113B
ProfileParametrsByWpn[idx]["nose_set_by_fuze"] = {}
ProfileParametrsByWpn[idx]["nose_set_by_fuze"][NOSE_FZ_FMU139LD] = {NOSE_SET_4, NOSE_SET_6, NOSE_SET_7, NOSE_SET_10, NOSE_SET_14, NOSE_SET_20}
ProfileParametrsByWpn[idx]["nose_set_by_fuze"][NOSE_FZ_FMU26BB] = {NOSE_SET_2, NOSE_SET_4, NOSE_SET_6, NOSE_SET_8, NOSE_SET_10, NOSE_SET_12, NOSE_SET_14, NOSE_SET_16, NOSE_SET_18, NOSE_SET_20}
ProfileParametrsByWpn[idx]["nose_set_by_fuze"][NOSE_FZ_FMU72B] = {NOSE_SET_6}
ProfileParametrsByWpn[idx]["nose_set_by_fuze"][NOSE_FZ_M904] = {NOSE_SET_2, NOSE_SET_4, NOSE_SET_6, NOSE_SET_8, NOSE_SET_10, NOSE_SET_12, NOSE_SET_14, NOSE_SET_16, NOSE_SET_18}
ProfileParametrsByWpn[idx]["nose_set_by_fuze"][NOSE_FZ_FMU_113B] = {NOSE_SET_18}
ProfileParametrsByWpn[idx]["tail_fuze_by_fuze"] = {}
ProfileParametrsByWpn[idx]["tail_fuze_by_fuze"][NOSE_FZ_NONE] = {TAIL_FZ_FMU139LD, TAIL_FZ_FMU26BB, TAIL_FZ_FMU72B, TAIL_FZ_M905}
ProfileParametrsByWpn[idx]["tail_fuze_by_fuze"][NOSE_FZ_FMU139LD] = {TAIL_FZ_NONE, TAIL_FZ_FMU139LD, TAIL_FZ_FMU26BB, TAIL_FZ_FMU72B, TAIL_FZ_M905}
ProfileParametrsByWpn[idx]["tail_fuze_by_fuze"][NOSE_FZ_FMU26BB] = {TAIL_FZ_NONE, TAIL_FZ_FMU139LD, TAIL_FZ_FMU26BB, TAIL_FZ_FMU72B, TAIL_FZ_M905}
ProfileParametrsByWpn[idx]["tail_fuze_by_fuze"][NOSE_FZ_FMU72B] = {TAIL_FZ_NONE, TAIL_FZ_FMU139LD, TAIL_FZ_FMU26BB, TAIL_FZ_FMU72B, TAIL_FZ_M905}
ProfileParametrsByWpn[idx]["tail_fuze_by_fuze"][NOSE_FZ_M904] = {TAIL_FZ_NONE, TAIL_FZ_FMU139LD, TAIL_FZ_FMU26BB, TAIL_FZ_FMU72B, TAIL_FZ_M905}
ProfileParametrsByWpn[idx]["tail_fuze_by_fuze"][NOSE_FZ_DSU33] = {TAIL_FZ_FMU139LD}
ProfileParametrsByWpn[idx]["tail_fuze_by_fuze"][NOSE_FZ_FMU_113B] = {TAIL_FZ_NONE, TAIL_FZ_FMU139LD, TAIL_FZ_FMU26BB, TAIL_FZ_FMU72B, TAIL_FZ_M905}
ProfileParametrsByWpn[idx]["tail_set_by_fuze"] = {}
ProfileParametrsByWpn[idx]["tail_set_by_fuze"][TAIL_FZ_FMU139LD] = {TAIL_SET_4, TAIL_SET_6, TAIL_SET_7, TAIL_SET_10, TAIL_SET_14, TAIL_SET_20}
ProfileParametrsByWpn[idx]["tail_set_by_fuze"][TAIL_FZ_FMU26BB] = {TAIL_SET_2, TAIL_SET_4, TAIL_SET_6, TAIL_SET_8, TAIL_SET_10, TAIL_SET_12, TAIL_SET_14, TAIL_SET_16, TAIL_SET_18, TAIL_SET_20}
ProfileParametrsByWpn[idx]["tail_set_by_fuze"][TAIL_FZ_FMU72B] = {TAIL_SET_6}
ProfileParametrsByWpn[idx]["tail_set_by_fuze"][TAIL_FZ_M905] = {TAIL_SET_4, TAIL_SET_6, TAIL_SET_8, TAIL_SET_12, TAIL_SET_16, TAIL_SET_20}
--CBU-97
idx = #ProfileParametrsByWpn + 1
ProfileParametrsByWpn[idx] = {}
ProfileParametrsByWpn[idx]["type"] = CBU97
ProfileParametrsByWpn[idx]["strings"] = {}
ProfileParametrsByWpn[idx]["strings"][1] = ESC_MNVR_PARAMS
ProfileParametrsByWpn[idx]["strings"][2] = BMB_MNT_PARAMS
ProfileParametrsByWpn[idx]["strings"][3] = DES_TOF_PARAMS
ProfileParametrsByWpn[idx]["strings"][4] = FZU39_PARAMS
ProfileParametrsByWpn[idx]["strings"][5] = FUNC_TIME_PARAMS
ProfileParametrsByWpn[idx]["strings"][6] = HOF_PARAMS
ProfileParametrsByWpn[idx]["strings"][7] = MIN_ALT_PARAMS
ProfileParametrsByWpn[idx]["strings"][8] = ADJ_RT_PARAMS
ProfileParametrsByWpn[idx]["strings"][9] = ADJ_UP_PARAMS
ProfileParametrsByWpn[idx]["strings"][10] = EJECT_VEL_PARAMS
ProfileParametrsByWpn[idx]["strings"][11] = RACK_DEL_PARAMS
ProfileParametrsByWpn[idx]["settings"] = {}
ProfileParametrsByWpn[idx]["settings"][1] = DATA_MIN_ALT
ProfileParametrsByWpn[idx]["settings"][2] = DATA_ADJ_RT
ProfileParametrsByWpn[idx]["settings"][3] = DATA_ADJ_UP
ProfileParametrsByWpn[idx]["settings"][4] = DATA_EJECT_VEL
ProfileParametrsByWpn[idx]["settings"][5] = DATA_RACK_DEL
ProfileParametrsByWpn[idx]["settings"][6] = DATA_DES_TOF
ProfileParametrsByWpn[idx]["settings"][7] = DATA_ESC_MNVR
--LUU-2 B
idx = #ProfileParametrsByWpn + 1
ProfileParametrsByWpn[idx] = {}
ProfileParametrsByWpn[idx]["type"] = LUU2B
ProfileParametrsByWpn[idx]["strings"] = {}
ProfileParametrsByWpn[idx]["strings"][1] = SUU25_MNT_PARAMS
ProfileParametrsByWpn[idx]["strings"][2] = FF_DIST_PARAMS
ProfileParametrsByWpn[idx]["strings"][3] = HOT_PARAMS
ProfileParametrsByWpn[idx]["settings"] = {}
ProfileParametrsByWpn[idx]["settings"][1] = DATA_HOT
--BDU-50LD
idx = #ProfileParametrsByWpn + 1
ProfileParametrsByWpn[idx] = {}
ProfileParametrsByWpn[idx]["type"] = BDU50LD
ProfileParametrsByWpn[idx]["strings"] = {}
ProfileParametrsByWpn[idx]["strings"][1] = ESC_MNVR_PARAMS
ProfileParametrsByWpn[idx]["strings"][2] = SERIES_PARAMS
ProfileParametrsByWpn[idx]["strings"][3] = CONFIG_PARAMS
ProfileParametrsByWpn[idx]["strings"][4] = BMB_MNT_PARAMS
ProfileParametrsByWpn[idx]["strings"][5] = DES_TOF_PARAMS
ProfileParametrsByWpn[idx]["strings"][6] = NOSE_FZ_PARAMS
ProfileParametrsByWpn[idx]["strings"][7] = TAIL_FZ_PARAMS
ProfileParametrsByWpn[idx]["strings"][8] = MIN_ALT_PARAMS
ProfileParametrsByWpn[idx]["strings"][9] = ADJ_RT_PARAMS
ProfileParametrsByWpn[idx]["strings"][10] = ADJ_UP_PARAMS
ProfileParametrsByWpn[idx]["strings"][11] = EJECT_VEL_PARAMS
ProfileParametrsByWpn[idx]["strings"][12] = RACK_DEL_PARAMS
ProfileParametrsByWpn[idx]["settings"] = {}
ProfileParametrsByWpn[idx]["settings"][1] = DATA_MIN_ALT
ProfileParametrsByWpn[idx]["settings"][2] = DATA_ADJ_RT
ProfileParametrsByWpn[idx]["settings"][3] = DATA_ADJ_UP
ProfileParametrsByWpn[idx]["settings"][4] = DATA_EJECT_VEL
ProfileParametrsByWpn[idx]["settings"][5] = DATA_RACK_DEL
ProfileParametrsByWpn[idx]["settings"][6] = DATA_DES_TOF
ProfileParametrsByWpn[idx]["settings"][7] = DATA_ESC_MNVR
ProfileParametrsByWpn[idx]["nose_fuzes_by_config"] = {}
ProfileParametrsByWpn[idx]["nose_fuzes_by_config"][CONFIG_LDGP] = {NOSE_FZ_NONE, NOSE_FZ_FMU139LD, NOSE_FZ_FMU26BB, NOSE_FZ_FMU72B, NOSE_FZ_M904, NOSE_FZ_DSU33, NOSE_FZ_FMU_113B}
ProfileParametrsByWpn[idx]["nose_set_by_fuze"] = {}
ProfileParametrsByWpn[idx]["nose_set_by_fuze"][NOSE_FZ_FMU139LD] = {NOSE_SET_4, NOSE_SET_6, NOSE_SET_7, NOSE_SET_10, NOSE_SET_14, NOSE_SET_20}
ProfileParametrsByWpn[idx]["nose_set_by_fuze"][NOSE_FZ_FMU26BB] = {NOSE_SET_2, NOSE_SET_4, NOSE_SET_6, NOSE_SET_8, NOSE_SET_10, NOSE_SET_12, NOSE_SET_14, NOSE_SET_16, NOSE_SET_18, NOSE_SET_20}
ProfileParametrsByWpn[idx]["nose_set_by_fuze"][NOSE_FZ_FMU72B] = {NOSE_SET_6}
ProfileParametrsByWpn[idx]["nose_set_by_fuze"][NOSE_FZ_M904] = {NOSE_SET_2, NOSE_SET_4, NOSE_SET_6, NOSE_SET_8, NOSE_SET_10, NOSE_SET_12, NOSE_SET_14, NOSE_SET_16, NOSE_SET_18}
ProfileParametrsByWpn[idx]["nose_set_by_fuze"][NOSE_FZ_FMU_113B] = {NOSE_SET_5, NOSE_SET_6, NOSE_SET_7, NOSE_SET_8, NOSE_SET_9, NOSE_SET_10, NOSE_SET_18}
ProfileParametrsByWpn[idx]["tail_fuze_by_config_fuze"] = {}
ProfileParametrsByWpn[idx]["tail_fuze_by_config_fuze"][CONFIG_LDGP] = {}
ProfileParametrsByWpn[idx]["tail_fuze_by_config_fuze"][CONFIG_LDGP][NOSE_FZ_NONE] = {TAIL_FZ_FMU139LD, TAIL_FZ_FMU26BB, TAIL_FZ_FMU72B, TAIL_FZ_M905}
ProfileParametrsByWpn[idx]["tail_fuze_by_config_fuze"][CONFIG_LDGP][NOSE_FZ_FMU139LD] = {TAIL_FZ_NONE, TAIL_FZ_FMU139LD, TAIL_FZ_FMU26BB, TAIL_FZ_FMU72B, TAIL_FZ_M905}
ProfileParametrsByWpn[idx]["tail_fuze_by_config_fuze"][CONFIG_LDGP][NOSE_FZ_FMU26BB] = {TAIL_FZ_NONE, TAIL_FZ_FMU139LD, TAIL_FZ_FMU26BB, TAIL_FZ_FMU72B, TAIL_FZ_M905}
ProfileParametrsByWpn[idx]["tail_fuze_by_config_fuze"][CONFIG_LDGP][NOSE_FZ_FMU72B] = {TAIL_FZ_NONE, TAIL_FZ_FMU139LD, TAIL_FZ_FMU26BB, TAIL_FZ_FMU72B, TAIL_FZ_M905}
ProfileParametrsByWpn[idx]["tail_fuze_by_config_fuze"][CONFIG_LDGP][NOSE_FZ_M904] = {TAIL_FZ_NONE, TAIL_FZ_FMU139LD, TAIL_FZ_FMU26BB, TAIL_FZ_FMU72B, TAIL_FZ_M905}
ProfileParametrsByWpn[idx]["tail_fuze_by_config_fuze"][CONFIG_LDGP][NOSE_FZ_DSU33] = {TAIL_FZ_FMU139LD}
ProfileParametrsByWpn[idx]["tail_fuze_by_config_fuze"][CONFIG_LDGP][NOSE_FZ_FMU_113B] = {TAIL_FZ_NONE, TAIL_FZ_FMU139LD, TAIL_FZ_FMU26BB, TAIL_FZ_FMU72B, TAIL_FZ_M905}
ProfileParametrsByWpn[idx]["tail_set_by_fuze"] = {}
ProfileParametrsByWpn[idx]["tail_set_by_fuze"][TAIL_FZ_FMU139LD] = {TAIL_SET_4, TAIL_SET_6, TAIL_SET_7, TAIL_SET_10, TAIL_SET_14, TAIL_SET_20}
ProfileParametrsByWpn[idx]["tail_set_by_fuze"][TAIL_FZ_FMU26BB] = {TAIL_SET_2, TAIL_SET_4, TAIL_SET_6, TAIL_SET_8, TAIL_SET_10, TAIL_SET_12, TAIL_SET_14, TAIL_SET_16, TAIL_SET_18, TAIL_SET_20}
ProfileParametrsByWpn[idx]["tail_set_by_fuze"][TAIL_FZ_FMU72B] = {TAIL_SET_6}
ProfileParametrsByWpn[idx]["tail_set_by_fuze"][TAIL_FZ_M905] = {TAIL_SET_4, TAIL_SET_6, TAIL_SET_8, TAIL_SET_12, TAIL_SET_16, TAIL_SET_20}
--BDU-50HD
idx = #ProfileParametrsByWpn + 1
ProfileParametrsByWpn[idx] = {}
ProfileParametrsByWpn[idx]["type"] = BDU50HD
ProfileParametrsByWpn[idx]["strings"] = {}
ProfileParametrsByWpn[idx]["strings"][1] = ESC_MNVR_PARAMS
ProfileParametrsByWpn[idx]["strings"][2] = SERIES_PARAMS
ProfileParametrsByWpn[idx]["strings"][3] = CONFIG_PARAMS
ProfileParametrsByWpn[idx]["strings"][4] = BMB_MNT_PARAMS
ProfileParametrsByWpn[idx]["strings"][5] = NOSE_FZ_PARAMS
ProfileParametrsByWpn[idx]["strings"][6] = TAIL_FZ_PARAMS
ProfileParametrsByWpn[idx]["strings"][7] = DES_HD_TOF_PARAMS
ProfileParametrsByWpn[idx]["strings"][8] = DES_LD_TOF_PARAMS
ProfileParametrsByWpn[idx]["strings"][9] = MIN_ALT_PARAMS
ProfileParametrsByWpn[idx]["strings"][10] = ADJ_RT_PARAMS
ProfileParametrsByWpn[idx]["strings"][11] = ADJ_UP_PARAMS
ProfileParametrsByWpn[idx]["strings"][12] = EJECT_VEL_PARAMS
ProfileParametrsByWpn[idx]["strings"][13] = RACK_DEL_PARAMS
ProfileParametrsByWpn[idx]["settings"] = {}
ProfileParametrsByWpn[idx]["settings"][1] = DATA_MIN_ALT
ProfileParametrsByWpn[idx]["settings"][2] = DATA_ADJ_RT
ProfileParametrsByWpn[idx]["settings"][3] = DATA_ADJ_UP
ProfileParametrsByWpn[idx]["settings"][4] = DATA_EJECT_VEL
ProfileParametrsByWpn[idx]["settings"][5] = DATA_RACK_DEL
ProfileParametrsByWpn[idx]["settings"][6] = DATA_DES_TOF
ProfileParametrsByWpn[idx]["settings"][7] = DATA_ESC_MNVR
ProfileParametrsByWpn[idx]["settings"][8] = DATA_DES_HD_TOF
ProfileParametrsByWpn[idx]["settings"][9] = DATA_DES_LD_TOF
ProfileParametrsByWpn[idx]["nose_fuzes_by_config"] = {}
ProfileParametrsByWpn[idx]["nose_fuzes_by_config"][CONFIG_FIXED_HI] = {NOSE_FZ_NONE, NOSE_FZ_FMU139HD, NOSE_FZ_M904, NOSE_FZ_DSU33}
ProfileParametrsByWpn[idx]["nose_fuzes_by_config"][CONFIG_FIXED_LO] = {NOSE_FZ_NONE, NOSE_FZ_FMU139LD, NOSE_FZ_M904, NOSE_FZ_DSU33}
ProfileParametrsByWpn[idx]["nose_fuzes_by_config"][CONFIG_PLT_OPT] = {NOSE_FZ_NONE, NOSE_FZ_FMU139, NOSE_FZ_M904, NOSE_FZ_DSU33}
ProfileParametrsByWpn[idx]["nose_fuzes_by_config"][CONFIG_PLT_OPT1] = {NOSE_FZ_M904}
ProfileParametrsByWpn[idx]["nose_fuzes_by_config"][CONFIG_PLT_OPT2] = {NOSE_FZ_M904}
ProfileParametrsByWpn[idx]["nose_set_by_fuze"] = {}
ProfileParametrsByWpn[idx]["nose_set_by_fuze"][NOSE_FZ_FMU139LD] = {NOSE_SET_4, NOSE_SET_6, NOSE_SET_7, NOSE_SET_10, NOSE_SET_14, NOSE_SET_20}
ProfileParametrsByWpn[idx]["nose_set_by_fuze"][NOSE_FZ_FMU139HD] = {NOSE_SET_2, NOSE_SET_26, NOSE_SET_4, NOSE_SET_5}
ProfileParametrsByWpn[idx]["nose_set_by_fuze"][NOSE_FZ_FMU139] = {NOSE_SET_26_6, NOSE_SET_26_7, NOSE_SET_26_10, NOSE_SET_26_14, NOSE_SET_26_20, NOSE_SET_40_6, NOSE_SET_40_7, NOSE_SET_40_10, NOSE_SET_40_14, NOSE_SET_40_20, NOSE_SET_50_6, NOSE_SET_50_7, NOSE_SET_50_10, NOSE_SET_50_14, NOSE_SET_50_20}
ProfileParametrsByWpn[idx]["nose_set_by_fuze"][NOSE_FZ_M904] = {NOSE_SET_2, NOSE_SET_4, NOSE_SET_6, NOSE_SET_8, NOSE_SET_10, NOSE_SET_12, NOSE_SET_14, NOSE_SET_16, NOSE_SET_18}
ProfileParametrsByWpn[idx]["tail_fuze_by_config_fuze"] = {}
ProfileParametrsByWpn[idx]["tail_fuze_by_config_fuze"][CONFIG_FIXED_HI] = {}
ProfileParametrsByWpn[idx]["tail_fuze_by_config_fuze"][CONFIG_FIXED_HI][NOSE_FZ_NONE] = {TAIL_FZ_FMU139HD}
ProfileParametrsByWpn[idx]["tail_fuze_by_config_fuze"][CONFIG_FIXED_HI][NOSE_FZ_FMU139HD] = {TAIL_FZ_NONE}
ProfileParametrsByWpn[idx]["tail_fuze_by_config_fuze"][CONFIG_FIXED_HI][NOSE_FZ_M904] = {TAIL_FZ_M905, TAIL_FZ_NONE}
ProfileParametrsByWpn[idx]["tail_fuze_by_config_fuze"][CONFIG_FIXED_HI][NOSE_FZ_DSU33] = {TAIL_FZ_FMU139HD}
ProfileParametrsByWpn[idx]["tail_fuze_by_config_fuze"][CONFIG_FIXED_LO] = {}
ProfileParametrsByWpn[idx]["tail_fuze_by_config_fuze"][CONFIG_FIXED_LO][NOSE_FZ_NONE] = {TAIL_FZ_FMU139LD}
ProfileParametrsByWpn[idx]["tail_fuze_by_config_fuze"][CONFIG_FIXED_LO][NOSE_FZ_FMU139LD] = {TAIL_FZ_NONE, TAIL_FZ_FMU139LD}
ProfileParametrsByWpn[idx]["tail_fuze_by_config_fuze"][CONFIG_FIXED_LO][NOSE_FZ_M904] = {TAIL_FZ_M905}
ProfileParametrsByWpn[idx]["tail_fuze_by_config_fuze"][CONFIG_FIXED_LO][NOSE_FZ_DSU33] = {TAIL_FZ_FMU139LD}
ProfileParametrsByWpn[idx]["tail_fuze_by_config_fuze"][CONFIG_PLT_OPT] = {}
ProfileParametrsByWpn[idx]["tail_fuze_by_config_fuze"][CONFIG_PLT_OPT][NOSE_FZ_NONE] = {TAIL_FZ_FMU139}
ProfileParametrsByWpn[idx]["tail_fuze_by_config_fuze"][CONFIG_PLT_OPT][NOSE_FZ_FMU139] = {TAIL_FZ_NONE, TAIL_FZ_FMU139}
ProfileParametrsByWpn[idx]["tail_fuze_by_config_fuze"][CONFIG_PLT_OPT][NOSE_FZ_M904] = {TAIL_FZ_M905, TAIL_FZ_FMU54AB, TAIL_FZ_FMU54B}
ProfileParametrsByWpn[idx]["tail_fuze_by_config_fuze"][CONFIG_PLT_OPT][NOSE_FZ_DSU33] = {TAIL_FZ_FMU139}
ProfileParametrsByWpn[idx]["tail_fuze_by_config_fuze"][CONFIG_PLT_OPT1] = {}
ProfileParametrsByWpn[idx]["tail_fuze_by_config_fuze"][CONFIG_PLT_OPT1][NOSE_FZ_M904] = {TAIL_FZ_FMU139}
ProfileParametrsByWpn[idx]["tail_fuze_by_config_fuze"][CONFIG_PLT_OPT2] = {}
ProfileParametrsByWpn[idx]["tail_fuze_by_config_fuze"][CONFIG_PLT_OPT2][NOSE_FZ_M904] = {TAIL_FZ_FMU139HD}
ProfileParametrsByWpn[idx]["tail_set_by_fuze"] = {}
ProfileParametrsByWpn[idx]["tail_set_by_fuze"][TAIL_FZ_FMU139LD] = {TAIL_SET_4, TAIL_SET_6, TAIL_SET_7, TAIL_SET_10, TAIL_SET_14, TAIL_SET_20}
ProfileParametrsByWpn[idx]["tail_set_by_fuze"][TAIL_FZ_FMU139HD] = {TAIL_SET_2, TAIL_SET_26, TAIL_SET_4, NOSE_SET_5}
ProfileParametrsByWpn[idx]["tail_set_by_fuze"][TAIL_FZ_FMU139] = {TAIL_SET_26_6, TAIL_SET_26_7, TAIL_SET_26_10, TAIL_SET_26_14, TAIL_SET_26_20, TAIL_SET_40_6, TAIL_SET_40_7, TAIL_SET_40_10, TAIL_SET_40_14, TAIL_SET_40_20, TAIL_SET_50_6, TAIL_SET_50_7, TAIL_SET_50_10, TAIL_SET_50_14, TAIL_SET_50_20}
ProfileParametrsByWpn[idx]["tail_set_by_fuze"][TAIL_FZ_M905] = {TAIL_SET_4, TAIL_SET_6, TAIL_SET_8, TAIL_SET_12, TAIL_SET_16, TAIL_SET_20}
ProfileParametrsByWpn[idx]["tail_set_by_fuze"][TAIL_FZ_FMU54AB] = {TAIL_SET_25, TAIL_SET_275, TAIL_SET_3, TAIL_SET_325, TAIL_SET_35, TAIL_SET_375, TAIL_SET_4, TAIL_SET_425, TAIL_SET_45, TAIL_SET_475, TAIL_SET_5, TAIL_SET_525, TAIL_SET_55, TAIL_SET_575, TAIL_SET_6}
ProfileParametrsByWpn[idx]["tail_set_by_fuze"][TAIL_FZ_FMU54B] = {TAIL_SET_075, TAIL_SET_10, TAIL_SET_125, TAIL_SET_15, TAIL_SET_175, TAIL_SET_2, TAIL_SET_225, TAIL_SET_25, TAIL_SET_275, TAIL_SET_3, TAIL_SET_325, TAIL_SET_35}
--BDU-50LGB
idx = #ProfileParametrsByWpn + 1
ProfileParametrsByWpn[idx] = {}
ProfileParametrsByWpn[idx]["type"] = BDU50LGB
ProfileParametrsByWpn[idx]["strings"] = {}
ProfileParametrsByWpn[idx]["strings"][1] = ESC_MNVR_PARAMS
ProfileParametrsByWpn[idx]["strings"][2] = CONFIG_PARAMS
ProfileParametrsByWpn[idx]["strings"][3] = DES_TOF_PARAMS
ProfileParametrsByWpn[idx]["strings"][4] = NOSE_FZ_PARAMS
ProfileParametrsByWpn[idx]["strings"][5] = TAIL_FZ_PARAMS
ProfileParametrsByWpn[idx]["strings"][6] = AUTO_LS_PARAMS
ProfileParametrsByWpn[idx]["strings"][7] = LS_TIME_PARAMS
ProfileParametrsByWpn[idx]["strings"][8] = LASER_CODE_PARAMS
ProfileParametrsByWpn[idx]["strings"][9] = SOLN_PARAMS
ProfileParametrsByWpn[idx]["strings"][10] = MIN_ALT_PARAMS
ProfileParametrsByWpn[idx]["strings"][11] = ADJ_RT_PARAMS
ProfileParametrsByWpn[idx]["strings"][12] = ADJ_UP_PARAMS
ProfileParametrsByWpn[idx]["strings"][13] = EJECT_VEL_PARAMS
ProfileParametrsByWpn[idx]["strings"][14] = RACK_DEL_PARAMS
ProfileParametrsByWpn[idx]["settings"] = {}
ProfileParametrsByWpn[idx]["settings"][1] = DATA_MIN_ALT
ProfileParametrsByWpn[idx]["settings"][2] = DATA_ADJ_RT
ProfileParametrsByWpn[idx]["settings"][3] = DATA_ADJ_UP
ProfileParametrsByWpn[idx]["settings"][4] = DATA_EJECT_VEL
ProfileParametrsByWpn[idx]["settings"][5] = DATA_RACK_DEL
ProfileParametrsByWpn[idx]["settings"][6] = DATA_DES_TOF
ProfileParametrsByWpn[idx]["settings"][7] = DATA_ESC_MNVR
ProfileParametrsByWpn[idx]["settings"][8] = DATA_AUTO_LS
ProfileParametrsByWpn[idx]["settings"][9] = DATA_SOLN
ProfileParametrsByWpn[idx]["settings"][10] = DATA_LS_TIME
ProfileParametrsByWpn[idx]["nose_fuzes_by_config"] = {}
ProfileParametrsByWpn[idx]["nose_fuzes_by_config"][CONFIG_LGB] = {NOSE_FZ_NONE, NOSE_FZ_FMU139LD, NOSE_FZ_FMU26BB, NOSE_FZ_FMU_81B}
ProfileParametrsByWpn[idx]["nose_set_by_fuze"] = {}
ProfileParametrsByWpn[idx]["nose_set_by_fuze"][NOSE_FZ_FMU139LD] = {NOSE_SET_4, NOSE_SET_6, NOSE_SET_7, NOSE_SET_10, NOSE_SET_14, NOSE_SET_20}
ProfileParametrsByWpn[idx]["nose_set_by_fuze"][NOSE_FZ_FMU26BB] = {NOSE_SET_2, NOSE_SET_4, NOSE_SET_7, NOSE_SET_10, NOSE_SET_14, NOSE_SET_20}
ProfileParametrsByWpn[idx]["nose_set_by_fuze"][NOSE_FZ_FMU_81B] = {NOSE_SET_4, NOSE_SET_5, NOSE_SET_6, NOSE_SET_7, NOSE_SET_8, NOSE_SET_10, NOSE_SET_12, NOSE_SET_14, NOSE_SET_20}
ProfileParametrsByWpn[idx]["tail_fuze_by_config_fuze"] = {}
ProfileParametrsByWpn[idx]["tail_fuze_by_config_fuze"][CONFIG_LGB] = {}
ProfileParametrsByWpn[idx]["tail_fuze_by_config_fuze"][CONFIG_LGB][NOSE_FZ_NONE] = {TAIL_FZ_FMU139LD, TAIL_FZ_FMU26BB, TAIL_FZ_M905, TAIL_FZ_FMU_81B}
ProfileParametrsByWpn[idx]["tail_fuze_by_config_fuze"][CONFIG_LGB][NOSE_FZ_FMU139LD] = {TAIL_FZ_NONE, TAIL_FZ_FMU139LD, TAIL_FZ_FMU26BB, TAIL_FZ_M905, TAIL_FZ_FMU_81B}
ProfileParametrsByWpn[idx]["tail_fuze_by_config_fuze"][CONFIG_LGB][NOSE_FZ_FMU26BB] = {TAIL_FZ_NONE, TAIL_FZ_FMU139LD, TAIL_FZ_FMU26BB, TAIL_FZ_M905, TAIL_FZ_FMU_81B}
ProfileParametrsByWpn[idx]["tail_fuze_by_config_fuze"][CONFIG_LGB][NOSE_FZ_FMU_81B] = {TAIL_FZ_NONE, TAIL_FZ_FMU139LD, TAIL_FZ_FMU26BB, TAIL_FZ_M905, TAIL_FZ_FMU_81B}
ProfileParametrsByWpn[idx]["tail_set_by_fuze"] = {}
ProfileParametrsByWpn[idx]["tail_set_by_fuze"][TAIL_FZ_FMU139LD] = {TAIL_SET_4, TAIL_SET_6, TAIL_SET_7, TAIL_SET_10, TAIL_SET_14, TAIL_SET_20}
ProfileParametrsByWpn[idx]["tail_set_by_fuze"][TAIL_FZ_FMU26BB] = {TAIL_SET_2, TAIL_SET_4, TAIL_SET_7, TAIL_SET_10, TAIL_SET_14, TAIL_SET_20}
ProfileParametrsByWpn[idx]["tail_set_by_fuze"][TAIL_FZ_M905] = {TAIL_SET_4, TAIL_SET_6, TAIL_SET_8, TAIL_SET_12, TAIL_SET_16, TAIL_SET_20}
ProfileParametrsByWpn[idx]["tail_set_by_fuze"][TAIL_FZ_FMU_81B] = {TAIL_SET_4, TAIL_SET_5, TAIL_SET_6, TAIL_SET_7, TAIL_SET_8, TAIL_SET_10, TAIL_SET_12, TAIL_SET_14, TAIL_SET_20}
--BDU-56LD
idx = #ProfileParametrsByWpn + 1
ProfileParametrsByWpn[idx] = {}
ProfileParametrsByWpn[idx]["type"] = BDU56LD
ProfileParametrsByWpn[idx]["strings"] = {}
ProfileParametrsByWpn[idx]["strings"][1] = ESC_MNVR_PARAMS
ProfileParametrsByWpn[idx]["strings"][2] = BMB_MNT_PARAMS
ProfileParametrsByWpn[idx]["strings"][3] = DES_TOF_PARAMS
ProfileParametrsByWpn[idx]["strings"][4] = NOSE_FZ_PARAMS
ProfileParametrsByWpn[idx]["strings"][5] = TAIL_FZ_PARAMS
ProfileParametrsByWpn[idx]["strings"][6] = MIN_ALT_PARAMS
ProfileParametrsByWpn[idx]["strings"][7] = ADJ_RT_PARAMS
ProfileParametrsByWpn[idx]["strings"][8] = ADJ_UP_PARAMS
ProfileParametrsByWpn[idx]["strings"][9] = EJECT_VEL_PARAMS
ProfileParametrsByWpn[idx]["strings"][10] = RACK_DEL_PARAMS
ProfileParametrsByWpn[idx]["settings"] = {}
ProfileParametrsByWpn[idx]["settings"][1] = DATA_MIN_ALT
ProfileParametrsByWpn[idx]["settings"][2] = DATA_ADJ_RT
ProfileParametrsByWpn[idx]["settings"][3] = DATA_ADJ_UP
ProfileParametrsByWpn[idx]["settings"][4] = DATA_EJECT_VEL
ProfileParametrsByWpn[idx]["settings"][5] = DATA_RACK_DEL
ProfileParametrsByWpn[idx]["settings"][6] = DATA_DES_TOF
ProfileParametrsByWpn[idx]["settings"][7] = DATA_ESC_MNVR
ProfileParametrsByWpn[idx]["nose_fuzes"] = {}
ProfileParametrsByWpn[idx]["nose_fuzes"][1] = NOSE_FZ_NONE
ProfileParametrsByWpn[idx]["nose_fuzes"][2] = NOSE_FZ_FMU139LD
ProfileParametrsByWpn[idx]["nose_fuzes"][3] = NOSE_FZ_FMU26BB
ProfileParametrsByWpn[idx]["nose_fuzes"][4] = NOSE_FZ_FMU72B
ProfileParametrsByWpn[idx]["nose_fuzes"][5] = NOSE_FZ_M904
ProfileParametrsByWpn[idx]["nose_fuzes"][6] = NOSE_FZ_DSU33
ProfileParametrsByWpn[idx]["nose_fuzes"][7] = NOSE_FZ_FMU_113B
ProfileParametrsByWpn[idx]["nose_set_by_fuze"] = {}
ProfileParametrsByWpn[idx]["nose_set_by_fuze"][NOSE_FZ_FMU139LD] = {NOSE_SET_4, NOSE_SET_6, NOSE_SET_7, NOSE_SET_10, NOSE_SET_14, NOSE_SET_20}
ProfileParametrsByWpn[idx]["nose_set_by_fuze"][NOSE_FZ_FMU26BB] = {NOSE_SET_2, NOSE_SET_4, NOSE_SET_6, NOSE_SET_8, NOSE_SET_10, NOSE_SET_12, NOSE_SET_14, NOSE_SET_16, NOSE_SET_18, NOSE_SET_20}
ProfileParametrsByWpn[idx]["nose_set_by_fuze"][NOSE_FZ_FMU72B] = {NOSE_SET_6}
ProfileParametrsByWpn[idx]["nose_set_by_fuze"][NOSE_FZ_M904] = {NOSE_SET_2, NOSE_SET_4, NOSE_SET_6, NOSE_SET_8, NOSE_SET_10, NOSE_SET_12, NOSE_SET_14, NOSE_SET_16, NOSE_SET_18}
ProfileParametrsByWpn[idx]["nose_set_by_fuze"][NOSE_FZ_FMU_113B] = {NOSE_SET_5, NOSE_SET_6, NOSE_SET_7, NOSE_SET_8, NOSE_SET_9, NOSE_SET_10, NOSE_SET_18}
ProfileParametrsByWpn[idx]["tail_fuze_by_fuze"] = {}
ProfileParametrsByWpn[idx]["tail_fuze_by_fuze"][NOSE_FZ_NONE] = {TAIL_FZ_FMU139LD, TAIL_FZ_FMU26BB, TAIL_FZ_FMU72B, TAIL_FZ_M905}
ProfileParametrsByWpn[idx]["tail_fuze_by_fuze"][NOSE_FZ_FMU139LD] = {TAIL_FZ_NONE, TAIL_FZ_FMU139LD, TAIL_FZ_FMU26BB, TAIL_FZ_FMU72B, TAIL_FZ_M905}
ProfileParametrsByWpn[idx]["tail_fuze_by_fuze"][NOSE_FZ_FMU26BB] = {TAIL_FZ_NONE, TAIL_FZ_FMU139LD, TAIL_FZ_FMU26BB, TAIL_FZ_FMU72B, TAIL_FZ_M905}
ProfileParametrsByWpn[idx]["tail_fuze_by_fuze"][NOSE_FZ_FMU72B] = {TAIL_FZ_NONE, TAIL_FZ_FMU139LD, TAIL_FZ_FMU26BB, TAIL_FZ_FMU72B, TAIL_FZ_M905}
ProfileParametrsByWpn[idx]["tail_fuze_by_fuze"][NOSE_FZ_M904] = {TAIL_FZ_NONE, TAIL_FZ_FMU139LD, TAIL_FZ_FMU26BB, TAIL_FZ_FMU72B, TAIL_FZ_M905}
ProfileParametrsByWpn[idx]["tail_fuze_by_fuze"][NOSE_FZ_DSU33] = {TAIL_FZ_FMU139LD}
ProfileParametrsByWpn[idx]["tail_fuze_by_fuze"][NOSE_FZ_FMU_113B] = {TAIL_FZ_NONE, TAIL_FZ_FMU139LD, TAIL_FZ_FMU26BB, TAIL_FZ_FMU72B, TAIL_FZ_M905}
ProfileParametrsByWpn[idx]["tail_set_by_fuze"] = {}
ProfileParametrsByWpn[idx]["tail_set_by_fuze"][TAIL_FZ_FMU139LD] = {TAIL_SET_4, TAIL_SET_6, TAIL_SET_7, TAIL_SET_10, TAIL_SET_14, TAIL_SET_20}
ProfileParametrsByWpn[idx]["tail_set_by_fuze"][TAIL_FZ_FMU26BB] = {TAIL_SET_2, TAIL_SET_4, TAIL_SET_6, TAIL_SET_8, TAIL_SET_10, TAIL_SET_12, TAIL_SET_14, TAIL_SET_16, TAIL_SET_18, TAIL_SET_20}
ProfileParametrsByWpn[idx]["tail_set_by_fuze"][TAIL_FZ_FMU72B] = {TAIL_SET_6}
ProfileParametrsByWpn[idx]["tail_set_by_fuze"][TAIL_FZ_M905] = {TAIL_SET_4, TAIL_SET_6, TAIL_SET_8, TAIL_SET_12, TAIL_SET_16, TAIL_SET_20}
--BDU-56LGB
idx = #ProfileParametrsByWpn + 1
ProfileParametrsByWpn[idx] = {}
ProfileParametrsByWpn[idx]["type"] = BDU56LGB
ProfileParametrsByWpn[idx]["strings"] = {}
ProfileParametrsByWpn[idx]["strings"][1] = ESC_MNVR_PARAMS
ProfileParametrsByWpn[idx]["strings"][2] = BMB_MNT_PARAMS
ProfileParametrsByWpn[idx]["strings"][3] = DES_TOF_PARAMS
ProfileParametrsByWpn[idx]["strings"][4] = NOSE_FZ_PARAMS
ProfileParametrsByWpn[idx]["strings"][5] = TAIL_FZ_PARAMS
ProfileParametrsByWpn[idx]["strings"][6] = AUTO_LS_PARAMS
ProfileParametrsByWpn[idx]["strings"][7] = LS_TIME_PARAMS
ProfileParametrsByWpn[idx]["strings"][8] = LASER_CODE_PARAMS
ProfileParametrsByWpn[idx]["strings"][9] = SOLN_PARAMS
ProfileParametrsByWpn[idx]["strings"][10] = MIN_ALT_PARAMS
ProfileParametrsByWpn[idx]["strings"][11] = ADJ_RT_PARAMS
ProfileParametrsByWpn[idx]["strings"][12] = ADJ_UP_PARAMS
ProfileParametrsByWpn[idx]["strings"][13] = EJECT_VEL_PARAMS
ProfileParametrsByWpn[idx]["strings"][14] = RACK_DEL_PARAMS
ProfileParametrsByWpn[idx]["settings"] = {}
ProfileParametrsByWpn[idx]["settings"][1] = DATA_MIN_ALT
ProfileParametrsByWpn[idx]["settings"][2] = DATA_ADJ_RT
ProfileParametrsByWpn[idx]["settings"][3] = DATA_ADJ_UP
ProfileParametrsByWpn[idx]["settings"][4] = DATA_EJECT_VEL
ProfileParametrsByWpn[idx]["settings"][5] = DATA_RACK_DEL
ProfileParametrsByWpn[idx]["settings"][6] = DATA_DES_TOF
ProfileParametrsByWpn[idx]["settings"][7] = DATA_ESC_MNVR
ProfileParametrsByWpn[idx]["settings"][8] = DATA_AUTO_LS
ProfileParametrsByWpn[idx]["settings"][9] = DATA_SOLN
ProfileParametrsByWpn[idx]["settings"][10] = DATA_LS_TIME
ProfileParametrsByWpn[idx]["nose_fuzes"] = {}
ProfileParametrsByWpn[idx]["nose_fuzes"][1] = NOSE_FZ_NONE
ProfileParametrsByWpn[idx]["nose_fuzes"][2] = NOSE_FZ_FMU139LD
ProfileParametrsByWpn[idx]["nose_fuzes"][3] = NOSE_FZ_FMU26BB
ProfileParametrsByWpn[idx]["nose_fuzes"][4] = NOSE_FZ_FMU_81B
ProfileParametrsByWpn[idx]["nose_set_by_fuze"] = {}
ProfileParametrsByWpn[idx]["nose_set_by_fuze"][NOSE_FZ_FMU139LD] = {NOSE_SET_4, NOSE_SET_6, NOSE_SET_7, NOSE_SET_10, NOSE_SET_14, NOSE_SET_20}
ProfileParametrsByWpn[idx]["nose_set_by_fuze"][NOSE_FZ_FMU26BB] = {NOSE_SET_2, NOSE_SET_4, NOSE_SET_6, NOSE_SET_8, NOSE_SET_10, NOSE_SET_12, NOSE_SET_14, NOSE_SET_16, NOSE_SET_18, NOSE_SET_20}
ProfileParametrsByWpn[idx]["nose_set_by_fuze"][NOSE_FZ_FMU_81B] = {NOSE_SET_4, NOSE_SET_5, NOSE_SET_6, NOSE_SET_7, NOSE_SET_8, NOSE_SET_10, NOSE_SET_12, NOSE_SET_14, NOSE_SET_20}
ProfileParametrsByWpn[idx]["tail_fuze_by_fuze"] = {}
ProfileParametrsByWpn[idx]["tail_fuze_by_fuze"][NOSE_FZ_NONE] = {TAIL_FZ_FMU139LD, TAIL_FZ_FMU26BB, TAIL_FZ_M905, TAIL_FZ_FMU_81B}
ProfileParametrsByWpn[idx]["tail_fuze_by_fuze"][NOSE_FZ_FMU139LD] = {TAIL_FZ_NONE, TAIL_FZ_FMU139LD, TAIL_FZ_FMU26BB, TAIL_FZ_M905, TAIL_FZ_FMU_81B}
ProfileParametrsByWpn[idx]["tail_fuze_by_fuze"][NOSE_FZ_FMU26BB] = {TAIL_FZ_NONE, TAIL_FZ_FMU139LD, TAIL_FZ_FMU26BB, TAIL_FZ_M905, TAIL_FZ_FMU_81B}
ProfileParametrsByWpn[idx]["tail_fuze_by_fuze"][NOSE_FZ_FMU_81B] = {TAIL_FZ_NONE, TAIL_FZ_FMU139LD, TAIL_FZ_FMU26BB, TAIL_FZ_M905, TAIL_FZ_FMU_81B}
ProfileParametrsByWpn[idx]["tail_set_by_fuze"] = {}
ProfileParametrsByWpn[idx]["tail_set_by_fuze"][TAIL_FZ_FMU139LD] = {TAIL_SET_4, TAIL_SET_6, TAIL_SET_7, TAIL_SET_10, TAIL_SET_14, TAIL_SET_20}
ProfileParametrsByWpn[idx]["tail_set_by_fuze"][TAIL_FZ_FMU26BB] = {TAIL_SET_2, TAIL_SET_4, TAIL_SET_6, TAIL_SET_8, TAIL_SET_10, TAIL_SET_12, TAIL_SET_14, TAIL_SET_16, TAIL_SET_18, TAIL_SET_20}
ProfileParametrsByWpn[idx]["tail_set_by_fuze"][TAIL_FZ_M905] = {TAIL_SET_4, TAIL_SET_6, TAIL_SET_8, TAIL_SET_12, TAIL_SET_16, TAIL_SET_20}
ProfileParametrsByWpn[idx]["tail_set_by_fuze"][TAIL_FZ_FMU_81B] = {TAIL_SET_4, TAIL_SET_5, TAIL_SET_6, TAIL_SET_7, TAIL_SET_8, TAIL_SET_10, TAIL_SET_12, TAIL_SET_14, TAIL_SET_20}
--GBU-10
idx = #ProfileParametrsByWpn + 1
ProfileParametrsByWpn[idx] = {}
ProfileParametrsByWpn[idx]["type"] = GBU10
ProfileParametrsByWpn[idx]["strings"] = {}
ProfileParametrsByWpn[idx]["strings"][1] = ESC_MNVR_PARAMS
ProfileParametrsByWpn[idx]["strings"][2] = BMB_MNT_PARAMS
ProfileParametrsByWpn[idx]["strings"][3] = DES_TOF_PARAMS
ProfileParametrsByWpn[idx]["strings"][4] = NOSE_FZ_PARAMS
ProfileParametrsByWpn[idx]["strings"][5] = TAIL_FZ_PARAMS
ProfileParametrsByWpn[idx]["strings"][6] = AUTO_LS_PARAMS
ProfileParametrsByWpn[idx]["strings"][7] = LS_TIME_PARAMS
ProfileParametrsByWpn[idx]["strings"][8] = LASER_CODE_PARAMS
ProfileParametrsByWpn[idx]["strings"][9] = SOLN_PARAMS
ProfileParametrsByWpn[idx]["strings"][10] = MIN_ALT_PARAMS
ProfileParametrsByWpn[idx]["strings"][11] = ADJ_RT_PARAMS
ProfileParametrsByWpn[idx]["strings"][12] = ADJ_UP_PARAMS
ProfileParametrsByWpn[idx]["strings"][13] = EJECT_VEL_PARAMS
ProfileParametrsByWpn[idx]["strings"][14] = RACK_DEL_PARAMS
ProfileParametrsByWpn[idx]["settings"] = {}
ProfileParametrsByWpn[idx]["settings"][1] = DATA_MIN_ALT
ProfileParametrsByWpn[idx]["settings"][2] = DATA_ADJ_RT
ProfileParametrsByWpn[idx]["settings"][3] = DATA_ADJ_UP
ProfileParametrsByWpn[idx]["settings"][4] = DATA_EJECT_VEL
ProfileParametrsByWpn[idx]["settings"][5] = DATA_RACK_DEL
ProfileParametrsByWpn[idx]["settings"][6] = DATA_DES_TOF
ProfileParametrsByWpn[idx]["settings"][7] = DATA_ESC_MNVR
ProfileParametrsByWpn[idx]["settings"][8] = DATA_AUTO_LS
ProfileParametrsByWpn[idx]["settings"][9] = DATA_SOLN
ProfileParametrsByWpn[idx]["settings"][10] = DATA_LS_TIME
ProfileParametrsByWpn[idx]["nose_fuzes"] = {}
ProfileParametrsByWpn[idx]["nose_fuzes"][1] = NOSE_FZ_NONE
ProfileParametrsByWpn[idx]["nose_fuzes"][2] = NOSE_FZ_FMU139LD
ProfileParametrsByWpn[idx]["nose_fuzes"][3] = NOSE_FZ_FMU26BB
ProfileParametrsByWpn[idx]["nose_fuzes"][4] = NOSE_FZ_FMU_81B
ProfileParametrsByWpn[idx]["nose_set_by_fuze"] = {}
ProfileParametrsByWpn[idx]["nose_set_by_fuze"][NOSE_FZ_FMU139LD] = {NOSE_SET_4, NOSE_SET_6, NOSE_SET_7, NOSE_SET_10, NOSE_SET_14, NOSE_SET_20}
ProfileParametrsByWpn[idx]["nose_set_by_fuze"][NOSE_FZ_FMU26BB] = {NOSE_SET_2, NOSE_SET_4, NOSE_SET_6, NOSE_SET_8, NOSE_SET_10, NOSE_SET_12, NOSE_SET_14, NOSE_SET_16, NOSE_SET_18, NOSE_SET_20}
ProfileParametrsByWpn[idx]["nose_set_by_fuze"][NOSE_FZ_FMU_81B] = {NOSE_SET_4, NOSE_SET_5, NOSE_SET_6, NOSE_SET_7, NOSE_SET_8, NOSE_SET_10, NOSE_SET_12, NOSE_SET_14, NOSE_SET_20}
ProfileParametrsByWpn[idx]["tail_fuze_by_fuze"] = {}
ProfileParametrsByWpn[idx]["tail_fuze_by_fuze"][NOSE_FZ_NONE] = {TAIL_FZ_FMU139LD, TAIL_FZ_FMU26BB, TAIL_FZ_M905, TAIL_FZ_FMU_81B}
ProfileParametrsByWpn[idx]["tail_fuze_by_fuze"][NOSE_FZ_FMU139LD] = {TAIL_FZ_NONE, TAIL_FZ_FMU139LD, TAIL_FZ_FMU26BB, TAIL_FZ_M905, TAIL_FZ_FMU_81B}
ProfileParametrsByWpn[idx]["tail_fuze_by_fuze"][NOSE_FZ_FMU26BB] = {TAIL_FZ_NONE, TAIL_FZ_FMU139LD, TAIL_FZ_FMU26BB, TAIL_FZ_M905, TAIL_FZ_FMU_81B}
ProfileParametrsByWpn[idx]["tail_fuze_by_fuze"][NOSE_FZ_FMU_81B] = {TAIL_FZ_NONE, TAIL_FZ_FMU139LD, TAIL_FZ_FMU26BB, TAIL_FZ_M905, TAIL_FZ_FMU_81B}
ProfileParametrsByWpn[idx]["tail_set_by_fuze"] = {}
ProfileParametrsByWpn[idx]["tail_set_by_fuze"][TAIL_FZ_FMU139LD] = {TAIL_SET_4, TAIL_SET_6, TAIL_SET_7, TAIL_SET_10, TAIL_SET_14, TAIL_SET_20}
ProfileParametrsByWpn[idx]["tail_set_by_fuze"][TAIL_FZ_FMU26BB] = {TAIL_SET_2, TAIL_SET_4, TAIL_SET_6, TAIL_SET_8, TAIL_SET_10, TAIL_SET_12, TAIL_SET_14, TAIL_SET_16, TAIL_SET_18, TAIL_SET_20}
ProfileParametrsByWpn[idx]["tail_set_by_fuze"][TAIL_FZ_M905] = {TAIL_SET_4, TAIL_SET_6, TAIL_SET_8, TAIL_SET_12, TAIL_SET_16, TAIL_SET_20}
ProfileParametrsByWpn[idx]["tail_set_by_fuze"][TAIL_FZ_FMU_81B] = {TAIL_SET_4, TAIL_SET_5, TAIL_SET_6, TAIL_SET_7, TAIL_SET_8, TAIL_SET_10, TAIL_SET_12, TAIL_SET_14, TAIL_SET_20}
--GBU-12
idx = #ProfileParametrsByWpn + 1
ProfileParametrsByWpn[idx] = {}
ProfileParametrsByWpn[idx]["type"] = GBU12
ProfileParametrsByWpn[idx]["strings"] = {}
ProfileParametrsByWpn[idx]["strings"][1] = ESC_MNVR_PARAMS
ProfileParametrsByWpn[idx]["strings"][2] = BMB_MNT_PARAMS
ProfileParametrsByWpn[idx]["strings"][3] = DES_TOF_PARAMS
ProfileParametrsByWpn[idx]["strings"][4] = NOSE_FZ_PARAMS
ProfileParametrsByWpn[idx]["strings"][5] = TAIL_FZ_PARAMS
ProfileParametrsByWpn[idx]["strings"][6] = AUTO_LS_PARAMS
ProfileParametrsByWpn[idx]["strings"][7] = LS_TIME_PARAMS
ProfileParametrsByWpn[idx]["strings"][8] = LASER_CODE_PARAMS
ProfileParametrsByWpn[idx]["strings"][9] = SOLN_PARAMS
ProfileParametrsByWpn[idx]["strings"][10] = MIN_ALT_PARAMS
ProfileParametrsByWpn[idx]["strings"][11] = ADJ_RT_PARAMS
ProfileParametrsByWpn[idx]["strings"][12] = ADJ_UP_PARAMS
ProfileParametrsByWpn[idx]["strings"][13] = EJECT_VEL_PARAMS
ProfileParametrsByWpn[idx]["strings"][14] = RACK_DEL_PARAMS
ProfileParametrsByWpn[idx]["settings"] = {}
ProfileParametrsByWpn[idx]["settings"][1] = DATA_MIN_ALT
ProfileParametrsByWpn[idx]["settings"][2] = DATA_ADJ_RT
ProfileParametrsByWpn[idx]["settings"][3] = DATA_ADJ_UP
ProfileParametrsByWpn[idx]["settings"][4] = DATA_EJECT_VEL
ProfileParametrsByWpn[idx]["settings"][5] = DATA_RACK_DEL
ProfileParametrsByWpn[idx]["settings"][6] = DATA_DES_TOF
ProfileParametrsByWpn[idx]["settings"][7] = DATA_ESC_MNVR
ProfileParametrsByWpn[idx]["settings"][8] = DATA_AUTO_LS
ProfileParametrsByWpn[idx]["settings"][9] = DATA_SOLN
ProfileParametrsByWpn[idx]["settings"][10] = DATA_LS_TIME
ProfileParametrsByWpn[idx]["nose_fuzes"] = {}
ProfileParametrsByWpn[idx]["nose_fuzes"][1] = NOSE_FZ_NONE
ProfileParametrsByWpn[idx]["nose_fuzes"][2] = NOSE_FZ_FMU139LD
ProfileParametrsByWpn[idx]["nose_fuzes"][3] = NOSE_FZ_FMU26BB
ProfileParametrsByWpn[idx]["nose_fuzes"][4] = NOSE_FZ_FMU_81B
ProfileParametrsByWpn[idx]["nose_set_by_fuze"] = {}
ProfileParametrsByWpn[idx]["nose_set_by_fuze"][NOSE_FZ_FMU139LD] = {NOSE_SET_4, NOSE_SET_6, NOSE_SET_7, NOSE_SET_10, NOSE_SET_14, NOSE_SET_20}
ProfileParametrsByWpn[idx]["nose_set_by_fuze"][NOSE_FZ_FMU26BB] = {NOSE_SET_2, NOSE_SET_4, NOSE_SET_6, NOSE_SET_8, NOSE_SET_10, NOSE_SET_12, NOSE_SET_14, NOSE_SET_16, NOSE_SET_18, NOSE_SET_20}
ProfileParametrsByWpn[idx]["nose_set_by_fuze"][NOSE_FZ_FMU_81B] = {NOSE_SET_4, NOSE_SET_5, NOSE_SET_6, NOSE_SET_7, NOSE_SET_8, NOSE_SET_10, NOSE_SET_12, NOSE_SET_14, NOSE_SET_20}
ProfileParametrsByWpn[idx]["tail_fuze_by_fuze"] = {}
ProfileParametrsByWpn[idx]["tail_fuze_by_fuze"][NOSE_FZ_NONE] = {TAIL_FZ_FMU139LD, TAIL_FZ_FMU26BB, TAIL_FZ_M905, TAIL_FZ_FMU_81B}
ProfileParametrsByWpn[idx]["tail_fuze_by_fuze"][NOSE_FZ_FMU139LD] = {TAIL_FZ_NONE, TAIL_FZ_FMU139LD, TAIL_FZ_FMU26BB, TAIL_FZ_M905, TAIL_FZ_FMU_81B}
ProfileParametrsByWpn[idx]["tail_fuze_by_fuze"][NOSE_FZ_FMU26BB] = {TAIL_FZ_NONE, TAIL_FZ_FMU139LD, TAIL_FZ_FMU26BB, TAIL_FZ_M905, TAIL_FZ_FMU_81B}
ProfileParametrsByWpn[idx]["tail_fuze_by_fuze"][NOSE_FZ_FMU_81B] = {TAIL_FZ_NONE, TAIL_FZ_FMU139LD, TAIL_FZ_FMU26BB, TAIL_FZ_M905, TAIL_FZ_FMU_81B}
ProfileParametrsByWpn[idx]["tail_set_by_fuze"] = {}
ProfileParametrsByWpn[idx]["tail_set_by_fuze"][TAIL_FZ_FMU139LD] = {TAIL_SET_4, TAIL_SET_6, TAIL_SET_7, TAIL_SET_10, TAIL_SET_14, TAIL_SET_20}
ProfileParametrsByWpn[idx]["tail_set_by_fuze"][TAIL_FZ_FMU26BB] = {TAIL_SET_2, TAIL_SET_4, TAIL_SET_6, TAIL_SET_8, TAIL_SET_10, TAIL_SET_12, TAIL_SET_14, TAIL_SET_16, TAIL_SET_18, TAIL_SET_20}
ProfileParametrsByWpn[idx]["tail_set_by_fuze"][TAIL_FZ_M905] = {TAIL_SET_4, TAIL_SET_6, TAIL_SET_8, TAIL_SET_12, TAIL_SET_16, TAIL_SET_20}
ProfileParametrsByWpn[idx]["tail_set_by_fuze"][TAIL_FZ_FMU_81B] = {TAIL_SET_4, TAIL_SET_5, TAIL_SET_6, TAIL_SET_7, TAIL_SET_8, TAIL_SET_10, TAIL_SET_12, TAIL_SET_14, TAIL_SET_20}
--GBU-31
idx = #ProfileParametrsByWpn + 1
ProfileParametrsByWpn[idx] = {}
ProfileParametrsByWpn[idx]["type"] = GBU31
ProfileParametrsByWpn[idx]["strings"] = {}
ProfileParametrsByWpn[idx]["strings"][1] = BMB_MNT_PARAMS
ProfileParametrsByWpn[idx]["strings"][2] = NOSE_FZ_PARAMS
ProfileParametrsByWpn[idx]["strings"][3] = TAIL_FZ_PARAMS
ProfileParametrsByWpn[idx]["strings"][4] = MIN_ALT_PARAMS
ProfileParametrsByWpn[idx]["strings"][5] = IAM_TARGET_PARAMS
ProfileParametrsByWpn[idx]["strings"][6] = IMP_ANG_PARAMS
ProfileParametrsByWpn[idx]["strings"][7] = IMP_AZ_PARAMS
ProfileParametrsByWpn[idx]["strings"][8] = PATT_AZ_PARAMS
ProfileParametrsByWpn[idx]["settings"] = {}
ProfileParametrsByWpn[idx]["settings"][1] = DATA_MIN_ALT
ProfileParametrsByWpn[idx]["settings"][2] = DATA_PATT_AZ
ProfileParametrsByWpn[idx]["settings"][3] = DATA_IMP_AZ
ProfileParametrsByWpn[idx]["settings"][4] = DATA_IMP_ANG
ProfileParametrsByWpn[idx]["settings"][5] = DATA_IAM_TARGET
ProfileParametrsByWpn[idx]["nose_fuzes"] = {}
ProfileParametrsByWpn[idx]["nose_fuzes"][1] = NOSE_FZ_NONE
ProfileParametrsByWpn[idx]["nose_fuzes"][2] = NOSE_FZ_FMU139LD
ProfileParametrsByWpn[idx]["nose_fuzes"][3] = NOSE_FZ_DSU33
ProfileParametrsByWpn[idx]["nose_set_by_fuze"] = {}
ProfileParametrsByWpn[idx]["nose_set_by_fuze"][NOSE_FZ_FMU139LD] = {NOSE_SET_4, NOSE_SET_6, NOSE_SET_7, NOSE_SET_10, NOSE_SET_14, NOSE_SET_20}
ProfileParametrsByWpn[idx]["nose_set_by_fuze"][NOSE_FZ_DSU33] = {NOSE_SET_1_8}
ProfileParametrsByWpn[idx]["tail_fuze_by_fuze"] = {}
ProfileParametrsByWpn[idx]["tail_fuze_by_fuze"][NOSE_FZ_NONE] = {TAIL_FZ_FMU139LD, TAIL_FZ_FMU152}
ProfileParametrsByWpn[idx]["tail_fuze_by_fuze"][NOSE_FZ_FMU139LD] = {TAIL_FZ_FMU139LD, TAIL_FZ_FMU152}
ProfileParametrsByWpn[idx]["tail_fuze_by_fuze"][NOSE_FZ_DSU33] = {TAIL_FZ_FMU139LD}
ProfileParametrsByWpn[idx]["tail_set_by_fuze"] = {}
ProfileParametrsByWpn[idx]["tail_set_by_fuze"][TAIL_FZ_FMU139LD] = {TAIL_SET_4, TAIL_SET_6, TAIL_SET_7, TAIL_SET_10, TAIL_SET_14, TAIL_SET_20}
ProfileParametrsByWpn[idx]["tail_set_by_fuze"][TAIL_FZ_FMU152] = {TAIL_SET_2, TAIL_SET_26, TAIL_SET_3, TAIL_SET_4, TAIL_SET_5}
--GBU-38
idx = #ProfileParametrsByWpn + 1
ProfileParametrsByWpn[idx] = {}
ProfileParametrsByWpn[idx]["type"] = GBU38
ProfileParametrsByWpn[idx]["strings"] = {}
ProfileParametrsByWpn[idx]["strings"][1] = BMB_MNT_PARAMS
ProfileParametrsByWpn[idx]["strings"][2] = NOSE_FZ_PARAMS
ProfileParametrsByWpn[idx]["strings"][3] = TAIL_FZ_PARAMS
ProfileParametrsByWpn[idx]["strings"][4] = MIN_ALT_PARAMS
ProfileParametrsByWpn[idx]["strings"][5] = IAM_TARGET_PARAMS
ProfileParametrsByWpn[idx]["strings"][6] = IMP_ANG_PARAMS
ProfileParametrsByWpn[idx]["strings"][7] = IMP_AZ_PARAMS
ProfileParametrsByWpn[idx]["strings"][8] = PATT_AZ_PARAMS
ProfileParametrsByWpn[idx]["settings"] = {}
ProfileParametrsByWpn[idx]["settings"][1] = DATA_MIN_ALT
ProfileParametrsByWpn[idx]["settings"][2] = DATA_PATT_AZ
ProfileParametrsByWpn[idx]["settings"][3] = DATA_IMP_AZ
ProfileParametrsByWpn[idx]["settings"][4] = DATA_IMP_ANG
ProfileParametrsByWpn[idx]["settings"][5] = DATA_IAM_TARGET
ProfileParametrsByWpn[idx]["nose_fuzes"] = {}
ProfileParametrsByWpn[idx]["nose_fuzes"][1] = NOSE_FZ_NONE
ProfileParametrsByWpn[idx]["nose_fuzes"][2] = NOSE_FZ_FMU139LD
ProfileParametrsByWpn[idx]["nose_fuzes"][3] = NOSE_FZ_DSU33
ProfileParametrsByWpn[idx]["nose_set_by_fuze"] = {}
ProfileParametrsByWpn[idx]["nose_set_by_fuze"][NOSE_FZ_FMU139LD] = {NOSE_SET_4, NOSE_SET_6, NOSE_SET_7, NOSE_SET_10, NOSE_SET_14, NOSE_SET_20}
ProfileParametrsByWpn[idx]["nose_set_by_fuze"][NOSE_FZ_DSU33] = {NOSE_SET_1_8}
ProfileParametrsByWpn[idx]["tail_fuze_by_fuze"] = {}
ProfileParametrsByWpn[idx]["tail_fuze_by_fuze"][NOSE_FZ_NONE] = {TAIL_FZ_FMU139LD, TAIL_FZ_FMU152}
ProfileParametrsByWpn[idx]["tail_fuze_by_fuze"][NOSE_FZ_FMU139LD] = {TAIL_FZ_FMU139LD, TAIL_FZ_FMU152}
ProfileParametrsByWpn[idx]["tail_fuze_by_fuze"][NOSE_FZ_DSU33] = {TAIL_FZ_FMU139LD}
ProfileParametrsByWpn[idx]["tail_set_by_fuze"] = {}
ProfileParametrsByWpn[idx]["tail_set_by_fuze"][TAIL_FZ_FMU139LD] = {TAIL_SET_4, TAIL_SET_6, TAIL_SET_7, TAIL_SET_10, TAIL_SET_14, TAIL_SET_20}
ProfileParametrsByWpn[idx]["tail_set_by_fuze"][TAIL_FZ_FMU152] = {TAIL_SET_2, TAIL_SET_26, TAIL_SET_3, TAIL_SET_4, TAIL_SET_5}
--MK-82AIR
idx = #ProfileParametrsByWpn + 1
ProfileParametrsByWpn[idx] = {}
ProfileParametrsByWpn[idx]["type"] = MK82AIR
ProfileParametrsByWpn[idx]["strings"] = {}
ProfileParametrsByWpn[idx]["strings"][1] = ESC_MNVR_PARAMS
ProfileParametrsByWpn[idx]["strings"][2] = CONFIG_PARAMS
ProfileParametrsByWpn[idx]["strings"][3] = BMB_MNT_PARAMS
ProfileParametrsByWpn[idx]["strings"][4] = NOSE_FZ_PARAMS
ProfileParametrsByWpn[idx]["strings"][5] = TAIL_FZ_PARAMS
ProfileParametrsByWpn[idx]["strings"][6] = DES_HD_TOF_PARAMS
ProfileParametrsByWpn[idx]["strings"][7] = DES_LD_TOF_PARAMS
ProfileParametrsByWpn[idx]["strings"][8] = MIN_ALT_PARAMS
ProfileParametrsByWpn[idx]["strings"][9] = ADJ_RT_PARAMS
ProfileParametrsByWpn[idx]["strings"][10] = ADJ_UP_PARAMS
ProfileParametrsByWpn[idx]["strings"][11] = EJECT_VEL_PARAMS
ProfileParametrsByWpn[idx]["strings"][12] = RACK_DEL_PARAMS
ProfileParametrsByWpn[idx]["settings"] = {}
ProfileParametrsByWpn[idx]["settings"][1] = DATA_MIN_ALT
ProfileParametrsByWpn[idx]["settings"][2] = DATA_ADJ_RT
ProfileParametrsByWpn[idx]["settings"][3] = DATA_ADJ_UP
ProfileParametrsByWpn[idx]["settings"][4] = DATA_EJECT_VEL
ProfileParametrsByWpn[idx]["settings"][5] = DATA_RACK_DEL
ProfileParametrsByWpn[idx]["settings"][6] = DATA_ESC_MNVR
ProfileParametrsByWpn[idx]["settings"][7] = DATA_DES_HD_TOF
ProfileParametrsByWpn[idx]["settings"][8] = DATA_DES_LD_TOF
ProfileParametrsByWpn[idx]["nose_fuzes_by_config"] = {}
ProfileParametrsByWpn[idx]["nose_fuzes_by_config"][CONFIG_FIXED_HI] = {NOSE_FZ_NONE, NOSE_FZ_FMU139HD, NOSE_FZ_M904, NOSE_FZ_DSU33}
ProfileParametrsByWpn[idx]["nose_fuzes_by_config"][CONFIG_FIXED_LO] = {NOSE_FZ_NONE, NOSE_FZ_FMU139LD, NOSE_FZ_M904, NOSE_FZ_DSU33}
ProfileParametrsByWpn[idx]["nose_fuzes_by_config"][CONFIG_PLT_OPT] = {NOSE_FZ_NONE, NOSE_FZ_FMU139, NOSE_FZ_M904, NOSE_FZ_DSU33}
ProfileParametrsByWpn[idx]["nose_fuzes_by_config"][CONFIG_PLT_OPT1] = {NOSE_FZ_M904}
ProfileParametrsByWpn[idx]["nose_fuzes_by_config"][CONFIG_PLT_OPT2] = {NOSE_FZ_M904}
ProfileParametrsByWpn[idx]["nose_set_by_fuze"] = {}
ProfileParametrsByWpn[idx]["nose_set_by_fuze"][NOSE_FZ_FMU139LD] = {NOSE_SET_4, NOSE_SET_6, NOSE_SET_7, NOSE_SET_10, NOSE_SET_14, NOSE_SET_20}
ProfileParametrsByWpn[idx]["nose_set_by_fuze"][NOSE_FZ_FMU139HD] = {NOSE_SET_2, NOSE_SET_26, NOSE_SET_4, NOSE_SET_5}
ProfileParametrsByWpn[idx]["nose_set_by_fuze"][NOSE_FZ_FMU139] = {NOSE_SET_26_6, NOSE_SET_26_7, NOSE_SET_26_10, NOSE_SET_26_14, NOSE_SET_26_20, NOSE_SET_40_6, NOSE_SET_40_7, NOSE_SET_40_10, NOSE_SET_40_14, NOSE_SET_40_20, NOSE_SET_50_6, NOSE_SET_50_7, NOSE_SET_50_10, NOSE_SET_50_14, NOSE_SET_50_20}
ProfileParametrsByWpn[idx]["nose_set_by_fuze"][NOSE_FZ_M904] = {NOSE_SET_2, NOSE_SET_4, NOSE_SET_6, NOSE_SET_8, NOSE_SET_10, NOSE_SET_12, NOSE_SET_14, NOSE_SET_16, NOSE_SET_18}
ProfileParametrsByWpn[idx]["tail_fuze_by_config_fuze"] = {}
ProfileParametrsByWpn[idx]["tail_fuze_by_config_fuze"][CONFIG_FIXED_HI] = {}
ProfileParametrsByWpn[idx]["tail_fuze_by_config_fuze"][CONFIG_FIXED_HI][NOSE_FZ_NONE] = {TAIL_FZ_FMU139HD}
ProfileParametrsByWpn[idx]["tail_fuze_by_config_fuze"][CONFIG_FIXED_HI][NOSE_FZ_FMU139HD] = {TAIL_FZ_NONE}
ProfileParametrsByWpn[idx]["tail_fuze_by_config_fuze"][CONFIG_FIXED_HI][NOSE_FZ_M904] = {TAIL_FZ_M905, TAIL_FZ_NONE}
ProfileParametrsByWpn[idx]["tail_fuze_by_config_fuze"][CONFIG_FIXED_HI][NOSE_FZ_DSU33] = {TAIL_FZ_FMU139HD}
ProfileParametrsByWpn[idx]["tail_fuze_by_config_fuze"][CONFIG_FIXED_LO] = {}
ProfileParametrsByWpn[idx]["tail_fuze_by_config_fuze"][CONFIG_FIXED_LO][NOSE_FZ_NONE] = {TAIL_FZ_FMU139LD}
ProfileParametrsByWpn[idx]["tail_fuze_by_config_fuze"][CONFIG_FIXED_LO][NOSE_FZ_FMU139LD] = {TAIL_FZ_NONE, TAIL_FZ_FMU139LD}
ProfileParametrsByWpn[idx]["tail_fuze_by_config_fuze"][CONFIG_FIXED_LO][NOSE_FZ_M904] = {TAIL_FZ_M905}
ProfileParametrsByWpn[idx]["tail_fuze_by_config_fuze"][CONFIG_FIXED_LO][NOSE_FZ_DSU33] = {TAIL_FZ_FMU139LD}
ProfileParametrsByWpn[idx]["tail_fuze_by_config_fuze"][CONFIG_PLT_OPT] = {}
ProfileParametrsByWpn[idx]["tail_fuze_by_config_fuze"][CONFIG_PLT_OPT][NOSE_FZ_NONE] = {TAIL_FZ_FMU139}
ProfileParametrsByWpn[idx]["tail_fuze_by_config_fuze"][CONFIG_PLT_OPT][NOSE_FZ_FMU139] = {TAIL_FZ_NONE, TAIL_FZ_FMU139}
ProfileParametrsByWpn[idx]["tail_fuze_by_config_fuze"][CONFIG_PLT_OPT][NOSE_FZ_M904] = {TAIL_FZ_M905, TAIL_FZ_FMU54AB, TAIL_FZ_FMU54B}
ProfileParametrsByWpn[idx]["tail_fuze_by_config_fuze"][CONFIG_PLT_OPT][NOSE_FZ_DSU33] = {TAIL_FZ_FMU139}
ProfileParametrsByWpn[idx]["tail_fuze_by_config_fuze"][CONFIG_PLT_OPT1] = {}
ProfileParametrsByWpn[idx]["tail_fuze_by_config_fuze"][CONFIG_PLT_OPT1][NOSE_FZ_M904] = {TAIL_FZ_FMU139}
ProfileParametrsByWpn[idx]["tail_fuze_by_config_fuze"][CONFIG_PLT_OPT2] = {}
ProfileParametrsByWpn[idx]["tail_fuze_by_config_fuze"][CONFIG_PLT_OPT2][NOSE_FZ_M904] = {TAIL_FZ_FMU139HD}
ProfileParametrsByWpn[idx]["tail_set_by_fuze"] = {}
ProfileParametrsByWpn[idx]["tail_set_by_fuze"][TAIL_FZ_FMU139LD] = {TAIL_SET_4, TAIL_SET_6, TAIL_SET_7, TAIL_SET_10, TAIL_SET_14, TAIL_SET_20}
ProfileParametrsByWpn[idx]["tail_set_by_fuze"][TAIL_FZ_FMU139HD] = {TAIL_SET_2, TAIL_SET_26, TAIL_SET_4, NOSE_SET_5}
ProfileParametrsByWpn[idx]["tail_set_by_fuze"][TAIL_FZ_FMU139] = {TAIL_SET_26_6, TAIL_SET_26_7, TAIL_SET_26_10, TAIL_SET_26_14, TAIL_SET_26_20, TAIL_SET_40_6, TAIL_SET_40_7, TAIL_SET_40_10, TAIL_SET_40_14, TAIL_SET_40_20, TAIL_SET_50_6, TAIL_SET_50_7, TAIL_SET_50_10, TAIL_SET_50_14, TAIL_SET_50_20}
ProfileParametrsByWpn[idx]["tail_set_by_fuze"][TAIL_FZ_M905] = {TAIL_SET_4, TAIL_SET_6, TAIL_SET_8, TAIL_SET_12, TAIL_SET_16, TAIL_SET_20}
ProfileParametrsByWpn[idx]["tail_set_by_fuze"][TAIL_FZ_FMU54AB] = {TAIL_SET_25, TAIL_SET_275, TAIL_SET_3, TAIL_SET_325, TAIL_SET_35, TAIL_SET_375, TAIL_SET_4, TAIL_SET_425, TAIL_SET_45, TAIL_SET_475, TAIL_SET_5, TAIL_SET_525, TAIL_SET_55, TAIL_SET_575, TAIL_SET_6}
ProfileParametrsByWpn[idx]["tail_set_by_fuze"][TAIL_FZ_FMU54B] = {TAIL_SET_075, TAIL_SET_10, TAIL_SET_125, TAIL_SET_15, TAIL_SET_175, TAIL_SET_2, TAIL_SET_225, TAIL_SET_25, TAIL_SET_275, TAIL_SET_3, TAIL_SET_325, TAIL_SET_35}
--CBU-87
idx = #ProfileParametrsByWpn + 1
ProfileParametrsByWpn[idx] = {}
ProfileParametrsByWpn[idx]["type"] = CBU87
ProfileParametrsByWpn[idx]["strings"] = {}
ProfileParametrsByWpn[idx]["strings"][1] = ESC_MNVR_PARAMS
ProfileParametrsByWpn[idx]["strings"][2] = BMB_MNT_PARAMS
ProfileParametrsByWpn[idx]["strings"][3] = DES_TOF_PARAMS
ProfileParametrsByWpn[idx]["strings"][4] = FZU39_PARAMS
ProfileParametrsByWpn[idx]["strings"][5] = FUNC_TIME_PARAMS
ProfileParametrsByWpn[idx]["strings"][6] = HOF_PARAMS
ProfileParametrsByWpn[idx]["strings"][7] = RPM_PARAMS
ProfileParametrsByWpn[idx]["strings"][8] = MIN_ALT_PARAMS
ProfileParametrsByWpn[idx]["strings"][9] = ADJ_RT_PARAMS
ProfileParametrsByWpn[idx]["strings"][10] = ADJ_UP_PARAMS
ProfileParametrsByWpn[idx]["strings"][11] = EJECT_VEL_PARAMS
ProfileParametrsByWpn[idx]["strings"][12] = RACK_DEL_PARAMS
ProfileParametrsByWpn[idx]["settings"] = {}
ProfileParametrsByWpn[idx]["settings"][1] = DATA_MIN_ALT
ProfileParametrsByWpn[idx]["settings"][2] = DATA_ADJ_RT
ProfileParametrsByWpn[idx]["settings"][3] = DATA_ADJ_UP
ProfileParametrsByWpn[idx]["settings"][4] = DATA_EJECT_VEL
ProfileParametrsByWpn[idx]["settings"][5] = DATA_RACK_DEL
ProfileParametrsByWpn[idx]["settings"][6] = DATA_DES_TOF
ProfileParametrsByWpn[idx]["settings"][7] = DATA_ESC_MNVR
--CBU-89
idx = #ProfileParametrsByWpn + 1
ProfileParametrsByWpn[idx] = {}
ProfileParametrsByWpn[idx]["type"] = CBU89
ProfileParametrsByWpn[idx]["strings"] = {}
ProfileParametrsByWpn[idx]["strings"][1] = ESC_MNVR_PARAMS
ProfileParametrsByWpn[idx]["strings"][2] = BMB_MNT_PARAMS
ProfileParametrsByWpn[idx]["strings"][3] = DES_TOF_PARAMS
ProfileParametrsByWpn[idx]["strings"][4] = FZU39_PARAMS
ProfileParametrsByWpn[idx]["strings"][5] = FUNC_TIME_PARAMS
ProfileParametrsByWpn[idx]["strings"][6] = HOF_PARAMS
ProfileParametrsByWpn[idx]["strings"][7] = MIN_ALT_PARAMS
ProfileParametrsByWpn[idx]["strings"][8] = ADJ_RT_PARAMS
ProfileParametrsByWpn[idx]["strings"][9] = ADJ_UP_PARAMS
ProfileParametrsByWpn[idx]["strings"][10] = EJECT_VEL_PARAMS
ProfileParametrsByWpn[idx]["strings"][11] = RACK_DEL_PARAMS
ProfileParametrsByWpn[idx]["settings"] = {}
ProfileParametrsByWpn[idx]["settings"][1] = DATA_MIN_ALT
ProfileParametrsByWpn[idx]["settings"][2] = DATA_ADJ_RT
ProfileParametrsByWpn[idx]["settings"][3] = DATA_ADJ_UP
ProfileParametrsByWpn[idx]["settings"][4] = DATA_EJECT_VEL
ProfileParametrsByWpn[idx]["settings"][5] = DATA_RACK_DEL
ProfileParametrsByWpn[idx]["settings"][6] = DATA_DES_TOF
ProfileParametrsByWpn[idx]["settings"][7] = DATA_ESC_MNVR

--  Air-Launched 2.75-Inch Rockets : 
--  M-257
idx = #ProfileParametrsByWpn + 1
local idx_m257 = idx
ProfileParametrsByWpn[idx] = {}
ProfileParametrsByWpn[idx]["type"] = M257
ProfileParametrsByWpn[idx]["strings"] = {}
ProfileParametrsByWpn[idx]["strings"][1] = POD_SET_PARAMS
ProfileParametrsByWpn[idx]["strings"][2] = LAU_MNT_PARAMS
ProfileParametrsByWpn[idx]["strings"][3] = HOT_PARAMS
ProfileParametrsByWpn[idx]["strings"][4] = DRAG_PARAMS
ProfileParametrsByWpn[idx]["strings"][5] = ADJ_RT_PARAMS
ProfileParametrsByWpn[idx]["strings"][6] = ADJ_UP_PARAMS
ProfileParametrsByWpn[idx]["settings"] = {}
ProfileParametrsByWpn[idx]["settings"][1] = DATA_HOT
ProfileParametrsByWpn[idx]["settings"][2] = DATA_ADJ_RT
ProfileParametrsByWpn[idx]["settings"][3] = DATA_ADJ_UP
ProfileParametrsByWpn[idx]["settings"][4] = DATA_DRAG
--M-278
idx = #ProfileParametrsByWpn + 1
ProfileParametrsByWpn[idx] = {}
ProfileParametrsByWpn[idx]["type"] = M278
ProfileParametrsByWpn[idx]["strings"]		= ProfileParametrsByWpn[idx_m257]["strings"]
ProfileParametrsByWpn[idx]["settings"]		= ProfileParametrsByWpn[idx_m257]["settings"]
--M-151
idx = #ProfileParametrsByWpn + 1
local idx_m151 = idx
ProfileParametrsByWpn[idx] = {}
ProfileParametrsByWpn[idx]["type"] = M151
ProfileParametrsByWpn[idx]["strings"] = {}
ProfileParametrsByWpn[idx]["strings"][1] = POD_SET_PARAMS
ProfileParametrsByWpn[idx]["strings"][2] = LAU_MNT_PARAMS
ProfileParametrsByWpn[idx]["strings"][3] = MIN_ALT_PARAMS
ProfileParametrsByWpn[idx]["strings"][4] = ADJ_RT_PARAMS
ProfileParametrsByWpn[idx]["strings"][5] = ADJ_UP_PARAMS
ProfileParametrsByWpn[idx]["settings"] = {}
ProfileParametrsByWpn[idx]["settings"][1] = DATA_MIN_ALT
ProfileParametrsByWpn[idx]["settings"][2] = DATA_ADJ_RT
ProfileParametrsByWpn[idx]["settings"][3] = DATA_ADJ_UP
--M-156
idx = #ProfileParametrsByWpn + 1
ProfileParametrsByWpn[idx] = {}
ProfileParametrsByWpn[idx]["type"] = M156
ProfileParametrsByWpn[idx]["strings"]		= ProfileParametrsByWpn[idx_m151]["strings"]
ProfileParametrsByWpn[idx]["settings"]		= ProfileParametrsByWpn[idx_m151]["settings"]
--WTU
idx = #ProfileParametrsByWpn + 1
ProfileParametrsByWpn[idx] = {}
ProfileParametrsByWpn[idx]["type"] = WTU1B
ProfileParametrsByWpn[idx]["strings"]		= ProfileParametrsByWpn[idx_m151]["strings"]
ProfileParametrsByWpn[idx]["settings"]		= ProfileParametrsByWpn[idx_m151]["settings"]
--M-274
idx = #ProfileParametrsByWpn + 1
ProfileParametrsByWpn[idx] = {}
ProfileParametrsByWpn[idx]["type"] = M274
ProfileParametrsByWpn[idx]["strings"]		= ProfileParametrsByWpn[idx_m151]["strings"]
ProfileParametrsByWpn[idx]["settings"]		= ProfileParametrsByWpn[idx_m151]["settings"]
--MK-1
idx = #ProfileParametrsByWpn + 1
ProfileParametrsByWpn[idx] = {}
ProfileParametrsByWpn[idx]["type"] = MK1
ProfileParametrsByWpn[idx]["strings"]		= ProfileParametrsByWpn[idx_m151]["strings"]
ProfileParametrsByWpn[idx]["settings"]		= ProfileParametrsByWpn[idx_m151]["settings"]
--MK-5
idx = #ProfileParametrsByWpn + 1
ProfileParametrsByWpn[idx] = {}
ProfileParametrsByWpn[idx]["type"] = MK5
ProfileParametrsByWpn[idx]["strings"]		= ProfileParametrsByWpn[idx_m151]["strings"]
ProfileParametrsByWpn[idx]["settings"]		= ProfileParametrsByWpn[idx_m151]["settings"]
--MK-61
idx = #ProfileParametrsByWpn + 1
ProfileParametrsByWpn[idx] = {}
ProfileParametrsByWpn[idx]["type"] = MK61
ProfileParametrsByWpn[idx]["strings"]		= ProfileParametrsByWpn[idx_m151]["strings"]
ProfileParametrsByWpn[idx]["settings"]		= ProfileParametrsByWpn[idx_m151]["settings"]
--LUU-2 AB
idx = #ProfileParametrsByWpn + 1
ProfileParametrsByWpn[idx] = {}
ProfileParametrsByWpn[idx]["type"] = LUU2AB
ProfileParametrsByWpn[idx]["strings"] = {}
ProfileParametrsByWpn[idx]["strings"][1] = SUU25_MNT_PARAMS
ProfileParametrsByWpn[idx]["strings"][2] = FF_DIST_PARAMS
ProfileParametrsByWpn[idx]["strings"][3] = HOT_PARAMS
ProfileParametrsByWpn[idx]["settings"] = {}
ProfileParametrsByWpn[idx]["settings"][1] = DATA_HOT
--LUU-2 BB
idx = #ProfileParametrsByWpn + 1
ProfileParametrsByWpn[idx] = {}
ProfileParametrsByWpn[idx]["type"] = LUU2BB
ProfileParametrsByWpn[idx]["strings"] = {}
ProfileParametrsByWpn[idx]["strings"][1] = SUU25_MNT_PARAMS
ProfileParametrsByWpn[idx]["strings"][2] = FF_DIST_PARAMS
ProfileParametrsByWpn[idx]["strings"][3] = HOT_PARAMS
ProfileParametrsByWpn[idx]["settings"] = {}
ProfileParametrsByWpn[idx]["settings"][1] = DATA_HOT
--LUU-19
idx = #ProfileParametrsByWpn + 1
ProfileParametrsByWpn[idx] = {}
ProfileParametrsByWpn[idx]["type"] = LUU19
ProfileParametrsByWpn[idx]["strings"] = {}
ProfileParametrsByWpn[idx]["strings"][1] = SUU25_MNT_PARAMS
ProfileParametrsByWpn[idx]["strings"][2] = FF_DIST_PARAMS
ProfileParametrsByWpn[idx]["strings"][3] = HOT_PARAMS
ProfileParametrsByWpn[idx]["settings"] = {}
ProfileParametrsByWpn[idx]["settings"][1] = DATA_HOT

-- WCMD :
-- CBU-103
idx = #ProfileParametrsByWpn + 1
ProfileParametrsByWpn[idx] = {}
ProfileParametrsByWpn[idx]["type"] = CBU103
ProfileParametrsByWpn[idx]["strings"] = {}
ProfileParametrsByWpn[idx]["strings"][1] = BMB_MNT_PARAMS
ProfileParametrsByWpn[idx]["strings"][2] = FZU39_PARAMS
ProfileParametrsByWpn[idx]["strings"][3] = FUNC_TIME_PARAMS
ProfileParametrsByWpn[idx]["strings"][4] = HOF_PARAMS
ProfileParametrsByWpn[idx]["strings"][5] = RPM_PARAMS
ProfileParametrsByWpn[idx]["strings"][6] = MIN_ALT_PARAMS
ProfileParametrsByWpn[idx]["settings"] = {}
ProfileParametrsByWpn[idx]["settings"][1] = DATA_MIN_ALT
--CBU-104
idx = #ProfileParametrsByWpn + 1
ProfileParametrsByWpn[idx] = {}
ProfileParametrsByWpn[idx]["type"] = CBU104
ProfileParametrsByWpn[idx]["strings"] = {}
ProfileParametrsByWpn[idx]["strings"][1] = BMB_MNT_PARAMS
ProfileParametrsByWpn[idx]["strings"][2] = FZU39_PARAMS
ProfileParametrsByWpn[idx]["strings"][3] = FUNC_TIME_PARAMS
ProfileParametrsByWpn[idx]["strings"][4] = HOF_PARAMS
ProfileParametrsByWpn[idx]["strings"][5] = MIN_ALT_PARAMS
ProfileParametrsByWpn[idx]["settings"] = {}
ProfileParametrsByWpn[idx]["settings"][1] = DATA_MIN_ALT
--CBU-105
idx = #ProfileParametrsByWpn + 1
ProfileParametrsByWpn[idx] = {}
ProfileParametrsByWpn[idx]["type"] = CBU105
ProfileParametrsByWpn[idx]["strings"] = {}
ProfileParametrsByWpn[idx]["strings"][1] = BMB_MNT_PARAMS
ProfileParametrsByWpn[idx]["strings"][2] = FZU39_PARAMS
ProfileParametrsByWpn[idx]["strings"][3] = FUNC_TIME_PARAMS
ProfileParametrsByWpn[idx]["strings"][4] = HOF_PARAMS
ProfileParametrsByWpn[idx]["strings"][5] = MIN_ALT_PARAMS
ProfileParametrsByWpn[idx]["settings"] = {}
ProfileParametrsByWpn[idx]["settings"][1] = DATA_MIN_ALT

-- Settings and parameters for weapons specific for A-10C II
dofile (LockOn_Options.script_path.."DSMS/database/DTS_storesettings_AGM_65_A10C_2.lua")
dofile (LockOn_Options.script_path.."DSMS/database/DTS_storesettings_APKWS_A10C_2.lua")
dofile (LockOn_Options.script_path.."DSMS/database/DTS_storesettings_GBU_54_A10C_2.lua")

function GetLastWord(s)
	--Триммируем строку справа
	local word = s
	TrimStringRight(word)

	--Ищем последний пробел
	local index = string.len(word)
	while 0 < index do
		if 32 == string.byte(s, index) then
			--Возвращаем подстроку с последнего пробела
			return string.sub(word, index-1, string.len(word))
		end
		index = index-1
	end
	return word
end

function CheckForTypes(str, table_field, maverick_types)
	for key, value in pairs(maverick_types) do
		local index = string.find(str, key)
		if nil ~= index then
			--Нашли нужный тип
			table_field["Type"] = value
			--Заодно читаем количество подвешенного
			local s = string.sub(str, 1, index-1)
			s = GetLastWord(s)
			table_field["Count"] = tonumber(s)
			return true
		end
	end
	
	return false
end

function FillTypeLauncher(str, table_field)
	local isTer = false
	
	--Сначала проверяем на лаунчеры
	if nil ~= string.find(str, "1 TER") then			-- Проверяем на TER
		table_field["Launcher"]			= TER
		table_field["LauncherCount"]	= 1
		isTer							= true
	elseif nil ~= string.find(str, "LAU117") then		-- Проверяем на LAU-117
		table_field["Launcher"]			= LAU117
		table_field["LauncherCount"]	= 1
		--Есть повод проверить на маверики
		CheckForTypes(str, table_field, maverick_types)
		return
	elseif nil ~= string.find(str, "L88A") then		-- Проверяем на LAU-88
		table_field["Launcher"]			= LAU88
		table_field["LauncherCount"]	= 1
		--Есть повод проверить на маверики
		CheckForTypes(str, table_field, maverick_types)
		return
	elseif nil ~= string.find(str, "DRA") then			-- Проверяем на DRA
		table_field["Launcher"]			= DRA
		local index = string.find(str, "L105")
		if nil ~= index then
			local s = string.sub(str, 1, index-1)
			s = GetLastWord(s)
			table_field["LauncherCount"]	= tonumber(s)
		else
			table_field["LauncherCount"]	= -1
		end
		--Есть повод проверить на Сайдвиндеры
		if nil == string.find(str, "AISPOD") then
			CheckForTypes(str, table_field, sidewinder_types)
		end
		return
	end
	
	local index = string.find(str, "L68")
	if nil ~= index then								-- Проверяем на LAU-68
		table_field["Launcher"]			= LAU68
		local s = string.sub(str, 1, index-1)
		s = GetLastWord(s)
		table_field["LauncherCount"]	= tonumber(s)
		if isTer then
			table_field["Pylon"]		= PYLON_TER
		else
			table_field["Pylon"]		= PYLON_PYLON
		end
		--Есть повод проверить на НАР
		if CheckForTypes(str, table_field, rocket_types) then
			--НАР найден, надо установить тип мотора
			if nil ~= string.find(str, "MK66") then
				table_field["RocketMotor"]		= ROCKET_MOTOR_MK66
			elseif nil ~= string.find(str, "MK4") then
				table_field["RocketMotor"]		= ROCKET_MOTOR_MK40
			end
		end
		return
	end

	index = string.find(str, " L131")
	if nil ~= index then								-- Проверяем на LAU-131
		table_field["Launcher"]			= LAU131
		local s = string.sub(str, 1, index-1)
		s = GetLastWord(s)
		table_field["LauncherCount"]	= tonumber(s)
		if isTer then
			table_field["Pylon"]		= PYLON_TER
		else
			table_field["Pylon"]		= PYLON_PYLON
		end
		--Есть повод проверить на НАР
		if CheckForTypes(str, table_field, rocket_types) then
			--НАР найден, надо установить тип мотора
			if nil ~= string.find(str, "MK66") then
				table_field["RocketMotor"]		= ROCKET_MOTOR_MK66
			elseif nil ~= string.find(str, "MK4") then
				table_field["RocketMotor"]		= ROCKET_MOTOR_MK40
			end
		end
		return
	end

	index = string.find(str, "SUU25")
	if nil ~= index then								-- Проверяем на SUU-25
		table_field["Launcher"]			= SUU25
		local s = string.sub(str, 1, index-1)
		s = GetLastWord(s)
		table_field["LauncherCount"]	= tonumber(s)
		if isTer then
			table_field["Pylon"]		= PYLON_TER
		else
			table_field["Pylon"]		= PYLON_PYLON
		end
		--Есть повод проверить на LUU
		CheckForTypes(str, table_field, flare_types)
		return
	end

	index = string.find(str, "AL131D")
	if nil ~= index then
		table_field["Type"]			= ALQ131
		table_field["Count"]		= 1
		table_field["ALQ131Type"]	= ALQ131DEEP
		return
	end
	index = string.find(str, "AL131S")
	if nil ~= index then
		table_field["Type"]			= ALQ131
		table_field["Count"]		= 1
		table_field["ALQ131Type"]	= ALQ131SHALLOW
		return
	end
	index = string.find(str, "AL184L")
	if nil ~= index then
		table_field["Type"]			= ALQ184
		table_field["Count"]		= 1
		table_field["ALQ184Type"]	= ALQ184LONG
		return
	end
	index = string.find(str, "AL184S")
	if nil ~= index then
		table_field["Type"]			= ALQ184
		table_field["Count"]		= 1
		table_field["ALQ184Type"]	= ALQ184SHORT
		return
	end
	
	index = string.find(str, "BDU56G")
	if nil ~= index then								-- Проверяем на BDU56LGB
		table_field["Type"]			= BDU56LGB
		local s = string.sub(str, 1, index-1)
		s = GetLastWord(s)
		table_field["Count"]	= tonumber(s)
		table_field["Config"]	= CONFIG_LGB
		return
	end
	
	CheckForTypes(str, table_field, common_types)

	--Затычка...
	if nil ~= string.find(str, "BDU50G") then
		table_field["Config"] = CONFIG_LGB
	end
end

function ReadInventoryString(str, InvList)
	--Парсим строку инвентори и кладем в таблицу
	local temp
	local temp1

	local table_field = {}
	
	--Считываем номер подвески
	str, table_field["StationNumber"]	= GetNumberField(str)
	--Считываем Rack/Wpn 1
	str, temp1						= GetStringField(str)						-- Читаем в темп, ибо в ЛО у нас всегда PILON в наличии
	--Считываем Rack/Wpn 2
	str, temp						= GetStringField(str)
	--Считываем Rack/Wpn 3
	str, temp1						= GetStringField(str)
	temp = temp .. temp1
	--Считываем Rack/Wpn 4
	str, temp1						= GetStringField(str)
	temp = temp .. temp1
	--Считываем Rack/Wpn 5
	str, temp1						= GetStringField(str)
	temp = temp .. temp1															-- в temp лежит строка с типом подвески и лаунчера, а зодно количество всего барахла

	if 0 == string.len(temp) then
		--Ничего не подвешено, уходим нафиг
		InvList[table_field["StationNumber"]] = table_field
		return
	else
		FillTypeLauncher(temp, table_field)
	end
	
	--Считываем Series
	str, temp						= GetStringField(str)
	GetValueFromString(table_field, "series", temp, SERIES_STRINGS)				--TO DO: Проверить как будут выглядить в файле реальные значения
	--Считываем Func Time
	str, temp						= GetStringField(str)
	GetValueFromString(table_field, "FuncTime", temp, FUNC_TIME_STRINGS)		--TO DO: ЗАПОЛНИТЬ ТАБЛИЦУ РЕАЛЬНЫХ ЗНАЧЕНИЙ
	--Считываем Nose Fuze
	str, temp						= GetStringField(str)
	GetValueFromString(table_field, "NoseFuzeType", temp, NOSE_FZ_STRINGS)		--TO DO: Проверить как будут выглядить в файле реальные значения
	--Считываем Tail Fuze
	str, temp						= GetStringField(str)
	GetValueFromString(table_field, "TailFuzeType", temp, TAIL_FZ_STRINGS)		--TO DO: Проверить как будут выглядить в файле реальные значения
	--Считываем Tail Set
	str, temp						= GetStringField(str)
	GetValueFromString(table_field, "TailSet", temp, TAIL_SET_STRINGS)			--TO DO: Проверить как будут выглядить в файле реальные значения
	--Считываем Nose Set
	str, temp						= GetStringField(str)
	GetValueFromString(table_field, "NoseSet", temp, NOSE_SET_STRINGS)			--TO DO: Проверить как будут выглядить в файле реальные значения
	--Считываем HOF
	str, temp						= GetStringField(str)
	GetValueFromString(table_field, "hof", temp, HOF_STRINGS)					--TO DO: ЗАПОЛНИТЬ ТАБЛИЦУ РЕАЛЬНЫХ ЗНАЧЕНИЙ
	--Считываем RPM
	str, temp						= GetStringField(str)						
	GetValueFromString(table_field, "Rpm", temp, RPM_STRINGS)					--TO DO: Проверить как будут выглядить в файле реальные значения
	--Считываем Config
	str, temp						= GetStringField(str)						
	GetValueFromString(table_field, "Config", temp, CONFIG_STRINGS)				--TO DO: Проверить как будут выглядить в файле реальные значения
	--Считываем FZU-39
	str, temp						= GetStringField(str)						
	GetValueFromString(table_field, "Fzu39", temp, FZU_STRINGS)					--TO DO: Проверить как будут выглядить в файле реальные значения
	--Считываем LaserCode
	str, temp						= GetNumberField(str)
	if nil ~= temp then
		table_field["LsrCode"]	= temp
	end
	--Считываем Eject Delay
	str, temp						= GetNumberField(str)
	if nil ~= temp then
		table_field["Eject"]	= temp
	end
	--Считываем Ignit Delay
	str, temp						= GetNumberField(str)
	if nil ~= temp then
		table_field["Ignition"]	= temp
	end
	--Считываем Free Fall
	str, temp						= GetNumberField(str)
	if nil ~= temp then
		table_field["ff_dist"]	= temp
	end
	--Считываем ModeSel
	str								= GetStringField(str)
	GetValueFromString(table_field, "PodSet", str, ROCKET_POD_STRINGS)					--TO DO: Проверить как будут выглядить в файле реальные значения

	InvList[table_field["StationNumber"]] = table_field
end

function Read_DSMS_Inventory(f, InvList)
	local str
	str = f:read()			--Считываем строку с перечнем параметров
	str = f:read()
	while "" ~= str do
		ReadInventoryString(str, InvList)
		str = f:read()
	end
end

function ReadProfileString(str, InvList)
	--Парсим строку профиля и кладем в таблицу
	local temp
		
	local table_field = {}
	
	--Считываем номер профиля
	str, temp	= GetNumberField(str)

	if nil == temp then return end
	if 20 < temp then return end

	--Считываем номер профиля
	table_field["index"]	= temp
	--Считываем имя профиля
	local p_name
	str, p_name						= GetStringField(str)
	--Считываем дескрипшен профиля
	str, temp						= GetStringField(str)
	--Считываем имя типа оружия профиля
	str, temp						= GetStringField(str)
	if nil ~= string.find(temp, "BDU50LO") then
		table_field["Type"]		= BDU50HD
		table_field["Config"]	= CONFIG_FIXED_LO
	elseif nil ~= string.find(temp, "BDU50HI") then
		table_field["Type"]		= BDU50HD
		table_field["Config"]	= CONFIG_FIXED_HI
	elseif nil ~= string.find(temp, "BDU50PO1") then
		table_field["Type"]		= BDU50HD
		table_field["Config"]	= CONFIG_PLT_OPT1
	elseif nil ~= string.find(temp, "BDU50PO2") then
		table_field["Type"]		= BDU50HD
		table_field["Config"]	= CONFIG_PLT_OPT2
	elseif nil ~= string.find(temp, "BDU50PO") then
		table_field["Type"]		= BDU50HD
		table_field["Config"]	= CONFIG_PLT_OPT
	elseif nil ~= string.find(temp, "BDU50LGB") then
		table_field["Type"]		= BDU50LGB
		table_field["Config"]	= CONFIG_LGB
	elseif nil ~= string.find(temp, "BDU56LGB") then
		table_field["Type"]		= BDU56LGB
		table_field["Config"]	= CONFIG_LGB
	elseif nil ~= string.find(temp, "MK82ALO") then
		table_field["Type"]		= MK82AIR
		table_field["Config"]	= CONFIG_FIXED_LO
	elseif nil ~= string.find(temp, "MK82AHI") then
		table_field["Type"]		= MK82AIR
		table_field["Config"]	= CONFIG_FIXED_HI
	elseif nil ~= string.find(temp, "MK82APO1") then
		table_field["Type"]		= MK82AIR
		table_field["Config"]	= CONFIG_PLT_OPT1
	elseif nil ~= string.find(temp, "MK82APO2") then
		table_field["Type"]		= MK82AIR
		table_field["Config"]	= CONFIG_PLT_OPT2
	elseif nil ~= string.find(temp, "MK82APO") then
		table_field["Type"]		= MK82AIR
		table_field["Config"]	= CONFIG_PLT_OPT
	else
		CheckForTypes(temp, table_field, TYPE_STRINGS)
	end

	--Считываем HUD_RotaryStatus
	str, temp						= GetStringField(str)
	local HUD_STRINGS = {}
	HUD_STRINGS[0]		= "Yes"
	HUD_STRINGS[1]		= "No"
	GetValueFromString(table_field, "HUD_RotaryStatus", temp, HUD_STRINGS)		--TO DO: ЗАПОЛНИТЬ ТАБЛИЦУ РЕАЛЬНЫХ ЗНАЧЕНИЙ
	--Считываем ReleaseMode
	str, temp						= GetStringField(str)
	local RELEASE_STRINGS = {}
	RELEASE_STRINGS[0]		= "S"
	RELEASE_STRINGS[1]		= "P"
	RELEASE_STRINGS[2]		= "RS"
	RELEASE_STRINGS[3]		= "RP"
	GetValueFromString(table_field, "ReleaseMode", temp, RELEASE_STRINGS)		--TO DO: ЗАПОЛНИТЬ ТАБЛИЦУ РЕАЛЬНЫХ ЗНАЧЕНИЙ
	--Считываем FuzeType
	str, temp						= GetStringField(str)
	local FUZE_TYPE_STRINGS = {}
	FUZE_TYPE_STRINGS[0]		= "NT"
	FUZE_TYPE_STRINGS[1]		= "N"
	FUZE_TYPE_STRINGS[2]		= "T"
	GetValueFromString(table_field, "FuzeType", temp, FUZE_TYPE_STRINGS)		--TO DO: ЗАПОЛНИТЬ ТАБЛИЦУ РЕАЛЬНЫХ ЗНАЧЕНИЙ
	--Считываем ModeCCIP_RP
	str, temp						= GetStringField(str)
	local ModeCCIP_RP_TYPE_STRINGS = {}
	ModeCCIP_RP_TYPE_STRINGS[0]		= "CCIP"
	ModeCCIP_RP_TYPE_STRINGS[1]		= "CCRP"
	GetValueFromString(table_field, "ModeCCIP_RP", temp, ModeCCIP_RP_TYPE_STRINGS)		--TO DO: ЗАПОЛНИТЬ ТАБЛИЦУ РЕАЛЬНЫХ ЗНАЧЕНИЙ
	--Считываем Qty
	str, table_field["Qty"]			= GetNumberField(str)
	--Считываем Feet
	str, table_field["Feet"]		= GetNumberField(str)
	--Считываем MinAlt
	str, table_field["MinAlt"]		= GetNumberField(str)
	--Считываем DesTOF
	str, table_field["DesTOF"]		= GetNumberField(str)
	--Считываем DesLD_TOF
	str, table_field["DesLD_TOF"]	= GetNumberField(str)
	--Считываем DesHD_TOF
	str, table_field["DesHD_TOF"]	= GetNumberField(str)
	--Считываем AdjRt
	str, table_field["AdjRt"]		= GetNumberField(str)
	--Считываем AdjUp
	str, table_field["AdjUp"]		= GetNumberField(str)
	--Считываем EjectVel
	str, table_field["EjectVel"]	= GetNumberField(str)
	--Считываем RackDel
	str, table_field["RackDel"]		= GetNumberField(str)
	--Считываем EscMnvr
	str, temp						= GetStringField(str)
	local EscMnvr_STRINGS = {}
	EscMnvr_STRINGS[0]		= "NONE"
	EscMnvr_STRINGS[1]		= "CLM"
	EscMnvr_STRINGS[2]		= "TRN"
	EscMnvr_STRINGS[3]		= "TLT"
	GetValueFromString(table_field, "EscMnvr", temp, EscMnvr_STRINGS)		--TO DO: ЗАПОЛНИТЬ ТАБЛИЦУ РЕАЛЬНЫХ ЗНАЧЕНИЙ
	--Считываем Soln
	str, temp						= GetStringField(str)
	local Soln_STRINGS = {}
	Soln_STRINGS[0]			= "ORP"
	Soln_STRINGS[1]			= "BAL"
	GetValueFromString(table_field, "Soln", temp, Soln_STRINGS)				--TO DO: ЗАПОЛНИТЬ ТАБЛИЦУ РЕАЛЬНЫХ ЗНАЧЕНИЙ
	--Считываем HeightOverTarget
	str, table_field["HeightOverTarget"]	= GetNumberField(str)
	--Считываем FZ Time (sec)														--У нас этого параметра нет!!!
	str, temp						= GetNumberField(str)
	--Считываем Target
	str, table_field["TargetName"]	= GetStringField(str)
	--Считываем AutoLs
	str, temp						= GetStringField(str)
	local AutoLs_STRINGS = {}
	AutoLs_STRINGS[0]		= "On"
	AutoLs_STRINGS[1]		= "Off"
	GetValueFromString(table_field, "AutoLs", temp, AutoLs_STRINGS)				--TO DO: ЗАПОЛНИТЬ ТАБЛИЦУ РЕАЛЬНЫХ ЗНАЧЕНИЙ
	--Считываем LsTime
	str, table_field["LsTime"]		= GetNumberField(str)
	--Считываем ImpAng
	str, table_field["ImpAng"]		= GetNumberField(str)
	--Считываем ImpAz
	str, table_field["ImpAz"]		= GetNumberField(str)
	--Считываем PattAz
	str, table_field["PattAz"]		= GetNumberField(str)
	--Считываем Drag
	str, table_field["Drag"]		= GetNumberField(str)

	InvList[p_name] = table_field
end

function Read_DSMS_Profiles(f, InvList)
	local str
	str = f:read()			--Считываем строку с перечнем параметров
	str = f:read()
	while "" ~= str and nil ~= str do
		ReadProfileString(str, InvList)
		str = f:read()
	end
end

--Таблицы, заполняемые из файлов
StoreRealList		= {}
StoreTrainingList	= {}
ProfileList			= {}
ProfileTrainingList	= {}
MaverickData		= {}

function ReadMavParams(f, str)
	local temp
	
	--Считываем тип включения маверика
	str, temp	= GetStringField(str)
	local MAV_PO_STRINGS = {}
	MAV_PO_STRINGS[0]		= "MANUAL"
	MAV_PO_STRINGS[1]		= "LOCATION"
	MAV_PO_STRINGS[2]		= "TIME"
--[[
enum enum_Maverick_power_on_type
{
	MAVERICK_POWER_ON_MAN,
	MAVERICK_POWER_ON_LOC,
	MAVERICK_POWER_ON_TIME,
};
--]]
	GetValueFromString(MaverickData, "MavPO", TrimStringLeft(TrimStringRight(str)), MAV_PO_STRINGS)		--TO DO: ЗАПОЛНИТЬ ТАБЛИЦУ РЕАЛЬНЫХ ЗНАЧЕНИЙ

	str=f:read()
	--Считываем азимут включения маверика
	str, temp	= GetStringField(str)
	MaverickData["AutoEOBearing"] = tonumber(str)

	str=f:read()
	--Считываем дальность включения маверика
	str, temp	= GetStringField(str)
	MaverickData["AutoEORange"] = tonumber(str)

	str=f:read()
	str=f:read()
	--Считываем время включения маверика
	str, temp	= GetStringField(str)
	local hour, minute, second		= GetTime(temp)
	MaverickData["MavTime"] 		= {}
	MaverickData["MavTime"]["H"]	= hour
	MaverickData["MavTime"]["M"]	= minute
	MaverickData["MavTime"]["S"]	= second
	
	
	str=f:read()
	str, temp	= GetStringField(str)
	MaverickData["MavWPT"] = tonumber(str)

end

function Read_DSMS_Actual(f)
	local str
	str=f:read()
	while nil ~= str do
		if nil ~= string.find(str, "DSMS Inventory - Actual", 1, true) then
			Read_DSMS_Inventory(f, StoreRealList)
		end
		if nil ~= string.find(str, "Actual Profiles", 1, true) then
			Read_DSMS_Profiles(f, ProfileList)
		end
		if nil ~= string.find(str, "EO Power Mode", 1, true) then
			ReadMavParams(f, str)
		end
		str=f:read()
	end
end

function Read_DSMS_Training(f)
	local str
	str=f:read()
	while nil ~= str do
		if nil ~= string.find(str, "DSMS Inventory - Training", 1, true) then
			Read_DSMS_Inventory(f, StoreTrainingList)
		end
		if nil ~= string.find(str, "Training Profiles", 1, true) then
			Read_DSMS_Profiles(f, ProfileTrainingList)
		end
		str=f:read()
	end
end

-- SETTINGS_PATH is left for compatibility with old missions
SETTINGS_PATH  = "DSMS/SETTINGS.lua"
dofile(LockOn_Options.common_script_path.."mission_prepare.lua")
