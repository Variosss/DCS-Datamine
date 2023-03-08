local DbOption  = require('Options.DbOption')
local i18n	    = require('i18n')
local oms       = require('optionsModsScripts')
local Range     = DbOption.Range

local _ = i18n.ptranslate


-- find the relative location of optionsDb.lua
function script_path() 
    -- remember to strip off the starting @ 
	local luafileloc = debug.getinfo(2, "S").source:sub(2)
	local ti, tj = string.find(luafileloc, "Options")
	local temploc = string.sub(luafileloc, 1, ti-1)
    return temploc
end 

-- find module path
local relativeloc = script_path()
modulelocation = lfs.currentdir().."\\"..relativeloc

local tblCPLocalList = oms.getTblCPLocalList(modulelocation)


return {
    CPLocalList			= tblCPLocalList["M-2000C-CPT"],	
	UNI_ALIGNED			= DbOption.new():setValue(true):checkbox(),
	UNI_NODRIFT			= DbOption.new():setValue(false):checkbox(),
	FUEL_DETOT_AUTO		= DbOption.new():setValue(false):checkbox(),
	REFUEL_HACK			= DbOption.new():setValue(true):checkbox(),
	RADAR_MAPOBJECTS	= DbOption.new():setValue(true):checkbox(),
	RADAR_CLUTTERQMC	= DbOption.new():setValue(true):checkbox(),
	--RADAR_FULLASYNC		= DbOption.new():setValue(true):checkbox(),
	RADIO_PTTMENU		= DbOption.new():setValue(true):checkbox(),
	REAL_FREQ_REP		= DbOption.new():setValue(true):checkbox(),
	VTB_ENLARGE			= DbOption.new():setValue(0):slider(Range(0, 25)),
	VTB_FOV_ENABLE		= DbOption.new():setValue(true):checkbox(),
	VTB_FOV_SIZE		= DbOption.new():setValue(130):slider(Range(90, 170)),
	VTB_FOV_HEIGHT		= DbOption.new():setValue(150):slider(Range(130, 170)),
	PCN_DIGIT_MSG		= DbOption.new():setValue(true):checkbox(),
	THROTTLE_CO_DETENT	= DbOption.new():setValue(15):slider(Range(3, 15)),
	THROTTLE_AB_DETENT	= DbOption.new():setValue(90):slider(Range(60, 90)),
	PITCH_ELASTIC_LIMIT	= DbOption.new():setValue(80):slider(Range(70, 95)),
	PITCH_LIMIT_MODE	= DbOption.new():setValue(1):combo({
		DbOption.Item(_('Disabled (Full axis always active)')):Value(0),
		DbOption.Item(_('Scale (Unpressed bind scales axis)')):Value(1),
		DbOption.Item(_('Clamp (Unpressed bind clamps axis)')):Value(2),}),
	MW_KNOBS_SPEED		= DbOption.new():setValue(0):slider(Range(-100, 0)),
	EZ_LAUNCH_ALERT		= DbOption.new():setValue(false):checkbox(),
	RAND_RDR_CHANNEL	= DbOption.new():setValue(false):checkbox(),
	ENGINE_LOG			= DbOption.new():setValue(false):checkbox(),
}
