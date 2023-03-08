local DbOption			= require('Options.DbOption')

local i18n = require('i18n')
local _ = i18n.ptranslate

local oms       	 = require('optionsModsScripts')

return {
	CPLocalList				= oms.getCPLocalList("A-10C-2020-CPT"),
	
	hmdEye					= DbOption.new():setValue(1):combo({DbOption.Item(_('Right eye')):Value(1),
																DbOption.Item(_('Left eye')):Value(0),
																DbOption.Item(_('Both eyes')):Value(2),}),
																
	defaultGunMode			= DbOption.new():setValue(0):combo({DbOption.Item(_('CCIP Gun Reticle')):Value(0),
																DbOption.Item(_('CCIP Gun Cross')):Value(1),}),

}
