local DbOption  = require('Options.DbOption')
local i18n	    = require('i18n')
local Range 	= DbOption.Range
local oms       = require('optionsModsScripts')

local _ = i18n.ptranslate


return {
	F1SimplifiedGearLever	 		= DbOption.new():setValue(false):checkbox(),
	F1SimplifiedFiringSafety 		= DbOption.new():setValue(true):checkbox(),
	--F1ModifiedABDetentPos	 		= DbOption.new():setValue(false):checkbox(),
	F1SelectedABDetentPos  			= DbOption.new():setValue(59):slider(Range(50, 95)),
	F1AutoCounterSet 				= DbOption.new():setValue(true):checkbox(),
	F1RadarCoverRemovedDefault 		= DbOption.new():setValue(false):checkbox(),
	F1StickForcesEmulation 			= DbOption.new():setValue(true):checkbox(),
	F1MinFFBPitch  					= DbOption.new():setValue(80):slider(Range(0, 100)),
	F1MaxFFBPitch  					= DbOption.new():setValue(100):slider(Range(0, 100)),
	F1FFBARTHUR  					= DbOption.new():setValue(60):slider(Range(50, 100)),
	F1MinFFBRoll  					= DbOption.new():setValue(50):slider(Range(0, 100)),
	F1MaxFFBRoll  					= DbOption.new():setValue(100):slider(Range(0, 100)),
	F1FFBShake  					= DbOption.new():setValue(0):slider(Range(0, 100)),
	
	F1ALR300VoiceLang				= DbOption.new():setValue(0):combo({DbOption.Item(_('NO CHANGE')):Value(0),
																		DbOption.Item(_('Spanish')):Value(1),
																		DbOption.Item(_('French')):Value(2),
																		DbOption.Item(_('English')):Value(3),}),
}
