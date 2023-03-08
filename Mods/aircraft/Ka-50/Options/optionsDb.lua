local DbOption  = require('Options.DbOption')
local i18n	    = require('i18n')
local Range 	= DbOption.Range
local oms       = require('optionsModsScripts')

local _ = i18n.ptranslate


return {
	Ka50TrimmingMethod = DbOption.new():setValue(0):combo({DbOption.Item(_('INSTANT TRIM (DEFAULT)')):Value(0),
																DbOption.Item(_('CENTRAL POSITION TRIMMER MODE')):Value(1),
																DbOption.Item(_('JOYSTICK WITHOUT SPRINGS AND FFB')):Value(2),}),
	Ka50RudderTrimmer 		 = DbOption.new():setValue(false):checkbox(),	
    CPLocalList		  		 = oms.getCPLocalList("Cockpit-Ka-50_2"),	
	
	helmetCircleDisplacement = DbOption.new():setValue(11):slider(Range(-15,15)),
	
	hmdEye					 = DbOption.new():setValue(1):combo({DbOption.Item(_('Right eye')):Value(1),
																 DbOption.Item(_('Left eye')) :Value(0),
																 DbOption.Item(_('Both eyes')):Value(2),}),
																
	

}
