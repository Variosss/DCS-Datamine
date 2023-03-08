local DbOption  = require('Options.DbOption')
local i18n	    = require('i18n')
local Range 	= DbOption.Range
local oms       = require('optionsModsScripts')

local _ = i18n.ptranslate


return {
	F1SimplifiedGearLever	 = DbOption.new():setValue(false):checkbox(),
	F1SimplifiedFiringSafety = DbOption.new():setValue(true):checkbox(),
	--F1ModifiedABDetentPos	 = DbOption.new():setValue(false):checkbox(),
	F1SelectedABDetentPos  = DbOption.new():setValue(59):slider(Range(50, 95)),
	F1AutoCounterSet = DbOption.new():setValue(true):checkbox(),
	F1RadarCoverRemovedDefault = DbOption.new():setValue(false):checkbox(),
	F1StickForcesEmulation = DbOption.new():setValue(true):checkbox(),
}
