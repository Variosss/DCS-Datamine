local DbOption = require('Options.DbOption')
local Name = DbOption.Item

local ok, supercarrier = pcall(require, "edSupercarrier")
local function showDialog(dlg)

end

return {
	Use_native_ATC_text		= DbOption.new():setValue(false):checkbox(),
	enable_FLOLS_overlay    = DbOption.new():setValue(true):checkbox():callback(function(value) 
		if  supercarrier then
			supercarrier.IFLOLS_enable_overlay(value)
		end
	end),
--- dlg callbacks
	callbackOnShowDialog  	= showDialog,
}
