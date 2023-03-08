--/N/ rev 1.9 April 2017.

--local ListBoxItem = require('ListBoxItem')
--local DialogLoader = require('DialogLoader')
local DbOption = require('Options.DbOption')
local Range = DbOption.Range
--local Name = DbOption.Item


--/N/ new for custom cockpit standard ***********************************
local oms       = require('optionsModsScripts')

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

--/N/ end new ************************************************************



return {
	Engine = DbOption.new():setValue(false):checkbox(),
	Shake = DbOption.new():setValue(100):slider(Range(0, 200)),

	--/N/ missing artistic implementation:
	Freeze = DbOption.new():setValue(false):checkbox(),
	
	--CustomCockpit = DbOption.new():setValue(false):checkbox(),
	CPLocalList = tblCPLocalList["Cockpit_MiG-21bis"],
	
	Reticle = DbOption.new():setValue(false):checkbox(),
	
	Pitot = DbOption.new():setValue(false):checkbox(),
	
	Experimental = DbOption.new():setValue(false):checkbox(),
}