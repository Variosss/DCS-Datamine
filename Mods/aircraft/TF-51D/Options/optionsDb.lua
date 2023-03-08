local DbOption = require('Options.DbOption')
local Range = DbOption.Range
local oms       	 = require('optionsModsScripts')

return {
	autoRudder  = DbOption.new():setValue(false):checkbox(),
	assistance  = DbOption.new():setValue(100):slider(Range(0, 100)),
    CPLocalList = oms.getCPLocalList("Cockpit_TF-51D"),
}
