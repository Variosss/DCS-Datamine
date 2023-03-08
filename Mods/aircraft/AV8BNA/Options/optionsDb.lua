local DbOption  = require('Options.DbOption')
local i18n	    = require('i18n')
local oms       = require('optionsModsScripts')

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
    CPLocalList		= tblCPLocalList["AV8BNA-CPT"],	
	MPCD_EXPORT		= DbOption.new():setValue(false):checkbox(),
	INS_Alignment	= DbOption.new():setValue(0):combo({DbOption.Item(_('UNALIGNED')):Value(0),
														DbOption.Item(_('SAVED HEADING ONLY')):Value(1),
														DbOption.Item(_('PRE-ALIGNED')):Value(2),}),
	INS_GYROHasNAV	= DbOption.new():setValue(false):checkbox(),
	USE_REAL_TDC	= DbOption.new():setValue(false):checkbox(),
	USE_MPCD_EXPORT = DbOption.new():setValue(false):checkbox(),
}
