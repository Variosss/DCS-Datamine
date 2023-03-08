local DbOption	= require('Options.DbOption')
local Range 	= DbOption.Range
local i18n		= require('i18n')
local oms		= require('optionsModsScripts')

local _ = i18n.ptranslate

return {
	weapTooltipsMi24 			= DbOption.new():setValue(true):checkbox(),
	Mi24AutoHandover			= DbOption.new():setValue(true):checkbox(),
	controlHelperMi24			= DbOption.new():setValue(false):checkbox(),

	Mi24StickTrimMethod			= DbOption.new():setValue(0):combo({DbOption.Item(_('INSTANT TRIM (DEFAULT)')):Value(0),
																DbOption.Item(_('CENTRAL POSITION TRIMMER MODE')):Value(1),
																DbOption.Item(_('JOYSTICK WITHOUT SPRINGS AND FFB')):Value(2),}),

	Mi24PedalsTrimMode			= DbOption.new():setValue(0):combo({DbOption.Item(_('INSTANT TRIM (DEFAULT)')):Value(0),
																DbOption.Item(_('CENTRAL POSITION TRIMMER MODE')):Value(1),}),
																		
	Mi24PedalsMicroswitchLogic	= DbOption.new():setValue(1):combo({DbOption.Item(_('PEDALS DEFLECTION')):Value(1), 
																DbOption.Item(_('PEDALS SPEED')):Value(2),
																DbOption.Item(_('AUTOMATIC MICROSWITCH OFF')):Value(0),}),
	

	Mi24PedalsTrimButton		= DbOption.new():setValue(1):combo({DbOption.Item(_('CYCLIC TRIMMER BUTTON (T)')):Value(1), 
																DbOption.Item(_('PEDALS MICROSWITCH BUTTON (Y)')):Value(2),
																DbOption.Item(_('DO NOT TRIM')):Value(0),}),
	

	CPLocalList					= oms.getCPLocalList("Cockpit_Mi-24P"),
	Mi24CockpitShake 			= DbOption.new():setValue(50):slider(Range(0, 100)),
	
	collectiveDisengage			= DbOption.new():setValue(1):slider(Range(1, 30)),
    collectiveBrake				= DbOption.new():setValue(0):combo({DbOption.Item(_("Default - disengages alt. hold only")):Value(0),
                                                                DbOption.Item(_("Hydro lock - has to be depressed to move collective")):Value(1),}),
	Aiming_mark					= DbOption.new():setValue(false):checkbox(),

	Mi24PedalsInputSensitivity	= DbOption.new():setValue(24):slider(Range(10, 100)),
	Mi24AIColorScheme			= DbOption.new():setValue(0):combo({DbOption.Item(_('NATO')):Value(0),
																	DbOption.Item(_('Coalition color')):Value(1),}),
	Mi24AIVoiceLanguage			= DbOption.new():setValue(0):combo({DbOption.Item(_('Auto')):Value(0),
																	DbOption.Item(_('Off')):Value(1),
																	DbOption.Item(_('English')):Value(2),
																	DbOption.Item(_('Russian')):Value(3),
																	}),
}
