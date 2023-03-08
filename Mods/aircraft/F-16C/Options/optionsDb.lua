local DbOption			= require('Options.DbOption')

local i18n = require('i18n')
local _ = i18n.ptranslate

local oms				= require('optionsModsScripts')

return {
	abDetent				= DbOption.new():setValue(0):combo({DbOption.Item(_('Always off')):Value(0),
																DbOption.Item(_('Always on')):Value(1),}),
	hmdEye					= DbOption.new():setValue(1):combo({DbOption.Item(_('Right eye')):Value(1),
																DbOption.Item(_('Left eye')):Value(0),
																DbOption.Item(_('Both eyes')):Value(2),}),
	CPLocalList				= oms.getCPLocalList("Cockpit_F-16C"),
	canopyTint				= DbOption.new():setValue(1):combo({DbOption.Item(_('Transparent')):Value(1),
																DbOption.Item(_('Tinted')):Value(0),}),
	canopyReflections		= DbOption.new():setValue(0):combo({DbOption.Item(_('None')):Value(1),
																DbOption.Item(_('Static')):Value(0),}),
	mfdReflections			= DbOption.new():setValue(0):combo({DbOption.Item(_('None')):Value(1),
																DbOption.Item(_('Static')):Value(0),}),
}
