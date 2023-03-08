local DialogLoader		= require('DialogLoader')
local gettext			= require('i_18n')
local dxgui				= require('dxgui')
local Window            = require('Window')
local Widget			= require('Widget')
local SkinUtils         = require('SkinUtils')
local Skin              = require('Skin')

local function _(text) 
	return gettext.dtranslate('simulator', text) 
end

local localization = {
	newBookmark	= _('New Route'),
	enterUniqueRouteName = _('Enter unique route name'),
	ok    		= _('OK'),
	cancel		= _('Cancel'),
}

local window_
local editBoxName_
local buttonOK_
local buttonCancel_

local function create()	
--	print('NewRouteDialog.create()')
	window_ = DialogLoader.spawnDialogFromFile('./Scripts/UI/View/NewRouteDialog.dlg', localization)
	window_:setText(localization.newBookmark)
	window_:setPosition(400, 200)
	window_:setSkin(SkinUtils.setWindowBkgColor(window_:getSkin(), 0x000000A0))
	editBoxName_ = window_.editBoxName
	editBoxName_:setText('')
	buttonOK_ = window_.panelButtons.buttonOK
	buttonOK_:setText(localization.ok)
	buttonCancel_ = window_.panelButtons.buttonCancel
	buttonCancel_:setText(localization.cancel)
	
	function buttonOK_:onChange()
--		print('buttonOK_:onChange()')
		local name = editBoxName_:getText()
--		print('name = ', name)
		onButtonOK(name)
		editBoxName_:setText('')
		window_:setVisible(false)
	end
	
	function buttonCancel_:onChange()
--		print('buttonJump_:onChange()')
		editBoxName_:setText('')
		window_:setVisible(false)
	end
	
end

local function kill()
	window_:kill()
	window_ = nil
end

local function show()
	editBoxName_:setText('')
	window_:setVisible(true)
end

local function hide()
	window_:setVisible(false)
end

local function getWindow()
	return window_.widget
end

return {
	create								= create,
	kill								= kill,
	show								= show,
	hide								= hide,
	getWindow							= getWindow,
}
