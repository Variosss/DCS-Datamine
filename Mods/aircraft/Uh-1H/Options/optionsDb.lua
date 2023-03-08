local DbOption = require('Options.DbOption')
local oms       = require('optionsModsScripts')
local Range = DbOption.Range


return {
	weapTooltips 		= DbOption.new():setValue(true):checkbox(),
	autoPilot			= DbOption.new():setValue(true):checkbox(),
	UHTrimmingMethod	= DbOption.new():setValue(0):combo({DbOption.Item(_('DEFAULT')):Value(0),
															DbOption.Item(_('CENTRAL POSITION TRIMMER MODE')):Value(1),
															DbOption.Item(_('JOYSTICK WITHOUT SPRINGS AND FFB')):Value(2),}),
	UHRudderTrimmer		= DbOption.new():setValue(false):checkbox(),
	UH1HCockpitShake 	= DbOption.new():setValue(50):slider(Range(0, 100)),
    CPLocalList         = oms.getCPLocalList("Cockpit_UH-1H"),
}
 