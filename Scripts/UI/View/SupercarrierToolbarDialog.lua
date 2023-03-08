-- Root toolbar for the Supercarrier view
local DialogLoader		= require('DialogLoader')
local gettext			= require('i_18n')
local dxgui				= require('dxgui')
local SkinUtils			= require('SkinUtils')
local Skin              = require('Skin')
local Menu          	= require("Menu")
local MenuItem      	= require("MenuItem")
local MenuSubItem   	= require("MenuSubItem")
local MenuSeparatorItem = require("MenuSeparatorItem")
local MenuRadioItem 	= require("MenuRadioItem")
local MenuCheckItem 	= require("MenuCheckItem")
local Button			= require("Button")
local Terrain           = require('terrain')
local i18n 				= require('i18n')
--local console			= require('ConsoleDialog')	-- for debugging

--local function consoleCallback(text)
--	loadstring(text)
--end

local function _(text) 
	return gettext.dtranslate('simulator', text) 
end

local localization = {
	views					= _('Views'),
	supercarrier			= _('Supercarrier'),
	air_boss 				= _('Air Boss'),
	lso    					= _('LSO'),
	catapults				= _('Catapults'),
	hangar					= _('Hangar'),
	briefing_room			= _('Briefing Room'),
	camera_mode				= _('Camera Mode'),
	unit_collision			= _('Unit Collision'),
	inside_room				= _('Inside Room'),
	on_deck					= _('On Deck'),
	bookmarks				= _('Bookmarks'),
	visible					= _('Visible'),
	animated				= _('Animated'),
	predefined				= _('Predefined'),
	user_defined			= _('User Defined'),
	editor					= _('Editor'),
	clipboard				= _('Clipboard'),
	camera_to_clipboard		= _('Camera To Clipboard'),
	routes					= _('Routes'),
}

local camera_name_
local window_
local menuBar_
local menuViews_
local menuCameraMode_
local menuCheckItemUnitCollision_
local menuCheckItemInsideRoom_
local menuCheckItemOnDeck_
local menuBookmarks_
local menuClipboard_
local menuRoutes_
local button_close_
local menuCheckItemBookmarksVisible_
local menuCheckItemBookmarksAnimated_
local menuCheckItemBookmarksEditor_
local menuPredefinedBookmarks_
local menuUserDefinedBookmarks_
local predefinedBookmarks_
local menuCheckItemRoutesVisible_
local menuCheckItemRouteEditor_
local menuCheckItemRoutePlayer_

local function setMenuCallback(menu)
    function menu:onChange()
		local item = self:getSelectedItem()
        if item.func then
			if item.getState then
				item.func(item:getState())
			else
				item.func()
			end
        end
    end
end

local function setViewsMenu()
    local menu = menuViews_

    setMenuCallback(menu)

    menu.menuItemSupercarrier.func  = onSupercarrier
    menu.menuItemAirBoss.func       = onAirBoss
    menu.menuItemLSO.func           = onLSO
    menu.menuItemCatapults.func     = onCatapults
    menu.menuItemHangar.func      	= onHangar
    menu.menuItemBriefingRoom.func  = onBriefingRoom
end

local function setCameraModeMenu()
    local menu = menuCameraMode_

    setMenuCallback(menu)
			
    menu.menuCheckItemUnitCollision.func = onUnitCollision
    menu.menuCheckItemInsideRoom.func 	 = onInsideRoom
    menu.menuCheckItemOnDeck.func    	 = onOnDeck
end

local function setBookmarksMenu()
    local menu = menuBookmarks_

    setMenuCallback(menu)
			
    menu.menuCheckItemVisible.func 	 = onBookmarksVisible
    menu.menuCheckItemAnimated.func  = onBookmarksAnimated
--    menu.menuSubItemPredefined.func  = onBookmarksPredefined
--    menu.menuSubItemUserDefined.func = onBookmarksUserDefined
    menu.menuCheckItemEditor.func    = onBookmarksEditor
end


local function setClipboardMenu()
    local menu = menuClipboard_

    setMenuCallback(menu)
			
    menu.menuItemCameraToClipboard.func = onCameraToClipboard
end

local function setRoutesMenu()
    local menu = menuRoutes_

    setMenuCallback(menu)
			
    menu.menuCheckItemVisible.func 	 = onRoutesVisible
    menu.menuCheckItemEditor.func    = onRouteEditor
    menu.menuCheckItemPlayer.func    = onRoutePlayer
end

local function create(camera_name)
	camera_name_ = camera_name
--	print('SupercarrierToolbarDialog:create(' .. camera_name_ .. ')')
--	console.create()
--	console.setSize(600, 400)
--	console.setPosition(0, 40)
--	console.setCallback(consoleCallback)
--	console.show()
	local screenWidth, screenHeight = dxgui.GetWindowSize()
	window_ = DialogLoader.spawnDialogFromFile('./Scripts/UI/View/SupercarrierToolbarDialog.dlg', localization)
	local w, h = window_:getSize()
--	print('screenWidth = ', screenWidth)
	window_:setBounds(0, 0, screenWidth, h)	
	window_:setSkin(SkinUtils.setWindowBkgColor(window_:getSkin(), 0x00000080))
	
	button_close_ = window_.button_close
	function button_close_:onChange()
		window_:setVisible(false)
	end
	
	menuBar_ = window_.menuBarTop	
	
	menuViews_ = menuBar_.menuBarItemViews.menu
	
	menuCameraMode_ = menuBar_.menuBarItemCameraMode.menu
	menuCheckItemUnitCollision_ = menuCameraMode_.menuCheckItemUnitCollision
	menuCheckItemUnitCollision_:setState(true)
	menuCheckItemInsideRoom_ = menuCameraMode_.menuCheckItemInsideRoom
	menuCheckItemInsideRoom_:setState(true)
	menuCheckItemOnDeck_ = menuCameraMode_.menuCheckItemOnDeck
	menuCheckItemOnDeck_:setState(false)
	
	menuBookmarks_ = menuBar_.menuBarItemBookmarks.menu
	menuCheckItemBookmarksVisible_ = menuBookmarks_.menuCheckItemVisible
	menuCheckItemBookmarksVisible_:setState(false)
	menuCheckItemBookmarksAnimated_ = menuBookmarks_.menuCheckItemAnimated
	menuCheckItemBookmarksAnimated_:setState(false)
	menuCheckItemBookmarksEditor_ = menuBookmarks_.menuCheckItemEditor
	menuCheckItemBookmarksEditor_:setState(false)
	
	menuClipboard_ = menuBar_.menuBarItemClipboard.menu	
	
	menuRoutes_ = menuBar_.menuBarItemRoutes.menu
	menuCheckItemRoutesVisible_ = menuRoutes_.menuCheckItemVisible
	menuCheckItemRoutesVisible_:setState(false)
	menuCheckItemRouteEditor_ = menuRoutes_.menuCheckItemEditor
	menuCheckItemRouteEditor_:setState(false)
	menuCheckItemRoutePlayer_ = menuRoutes_.menuCheckItemPlayer
	menuCheckItemRoutePlayer_:setState(false)
		
end

local function kill()
	window_:kill()
	window_ = nil
end

local function show()
	window_:setVisible(true)
end

local function hide()
	window_:setVisible(false)
end

local function isVisible()
	return window_:getVisible()
end

local function getWindow()
	return window_.widget
end

local function setMenuCallbacks()
	setViewsMenu()
	if camera_name_ == 'CameraBriefingRoom' then
		menuBar_.menuBarItemCameraMode:setEnabled(false)
		menuBar_.menuBarItemBookmarks:setEnabled(false)
		menuBar_.menuBarItemClipboard:setEnabled(false)	
		menuBar_.menuBarItemRoutes:setEnabled(false)
	else
		setCameraModeMenu()
		setBookmarksMenu()
		if camera_name_ == 'CameraSupercarrier' or camera_name_ == 'CameraCatapult' then
			setClipboardMenu()
		else
			menuBar_.menuBarItemClipboard:setEnabled(false)
		end
		setRoutesMenu()
	end
end

local function createPredefinedBookmarksMenu()
--	print('createPredefinedBookmarksMenu()')
	if menuPredefinedBookmarks_ == nil then	
		menuPredefinedBookmarks_ = Menu.new()
		menuBookmarks_.menuSubItemPredefined:setSubmenu(menuPredefinedBookmarks_)
		function menuPredefinedBookmarks_:onChange()
			local item = self:getSelectedItem()
			onPredefinedBookmark(item.id)
		end
	end
	if (PredefinedBookmarks ~= nil) then
		menuPredefinedBookmarks_:clear()
--		print('PredefinedBookmarks: ', table.getn(PredefinedBookmarks))
		for i = 1, table.getn(PredefinedBookmarks) do
			local bookmarkInfo = PredefinedBookmarks[i]
			local name = bookmarkInfo.name	           
			local menuItem = menuPredefinedBookmarks_:newItem(name)			
			menuItem.id = i - 1
		end
	end
end

local function updateUserDefinedBookmarksMenu()
--	print('updateUserDefinedBookmarksMenu()')
	if menuUserDefinedBookmarks_ == nil then
		menuUserDefinedBookmarks_ = Menu.new()
		menuBookmarks_.menuSubItemUserDefined:setSubmenu(menuUserDefinedBookmarks_)
		function menuUserDefinedBookmarks_:onChange()
			local item = self:getSelectedItem()
			onUserDefinedBookmark(item.id)
		end	
	end
	if (UserDefinedBookmarks ~= nil) then
		menuUserDefinedBookmarks_:clear()
--		print('UserDefinedBookmarks: ', table.getn(UserDefinedBookmarks))
--		for k, v in pairs(UserDefinedBookmarks) do
--			print('~~~k, v', k, v.name)
--		end
		for i = 1, table.getn(UserDefinedBookmarks) do
			local bookmarkInfo = UserDefinedBookmarks[i]
			local name = bookmarkInfo.name
			local menuItem = menuUserDefinedBookmarks_:newItem(name)			
			menuItem.id = i - 1
		end
	end
end

local function setUnitCollision(state)
	menuCheckItemUnitCollision_:setState(state)
end

local function setInsideRoom(state)
	menuCheckItemInsideRoom_:setState(state)
end

local function setOnDeck(state)
	menuCheckItemOnDeck_:setState(state)
end

local function setBookmarksEditorCheckbox(state)
	menuCheckItemBookmarksEditor_:setState(state)
end

local function setRouteEditorCheckbox(state)
	menuCheckItemRouteEditor_:setState(state)
end

local function setRoutePlayerCheckbox(state)
	menuCheckItemRoutePlayer_:setState(state)
end

return {
	create								= create,
	kill								= kill,
	show								= show,
	hide								= hide,
	getWindow							= getWindow,
	isVisible							= isVisible,
	setMenuCallbacks					= setMenuCallbacks,
	createPredefinedBookmarksMenu		= createPredefinedBookmarksMenu,
	updateUserDefinedBookmarksMenu		= updateUserDefinedBookmarksMenu,
	setUnitCollision					= setUnitCollision,
	setInsideRoom						= setInsideRoom,
	setOnDeck							= setOnDeck,
	setBookmarksEditorCheckbox			= setBookmarksEditorCheckbox,
	setRouteEditorCheckbox				= setRouteEditorCheckbox,
	setRoutePlayerCheckbox				= setRoutePlayerCheckbox,
}
