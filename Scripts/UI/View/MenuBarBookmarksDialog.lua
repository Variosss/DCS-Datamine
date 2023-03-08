-- Toolbar for the F11 view and for the RCtrl-F2 view
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

local function _(text) 
	return gettext.dtranslate('simulator', text) 
end

-- Predefined bookmarks menu item really controls current airfield camera positions
-- for the F11 view in the handler MenuBarBookmarksDialog::onPredefinedBookmarksMenu(). 
local localization = {
	predefined_bookmarks	= _('Predefined bookmarks'),
	current_positions		= _('Current positions'),
	user_bookmarks 			= _('User Bookmarks'),
	editor    				= _('Editor'),
	clipboard				= _('Clipboard'),
	camera_mode				= _('Camera mode'),
	frontal					= _('Frontal'),
	horizontal				= _('Horizontal'),
	vertical				= _('Vertical'),
	look_down				= _('Look down'),
	world_axes				= _('World axes'),
	camera_to_clipboard 	= _('Camera to clipboard'),
	clipboard_to_camera 	= _('Clipboard to camera'),
	by_default				= _('By default (RCtrl-Numpad5)'),
	terrain_position		= _('Terrain position'),
	visible_cameras			= _('Visible'),
}

local window_
local menuBar_
local menuPredefinedBookmarks_
local menuUserBookmarks_
local menuClipboard_
local menuItemCameraMode_
local menuCameraMode_
local radioFrontal_
local radioHorizontal_
local radioVertical_
local lookDownItem_
local worldAxesItem_
local editorMenuItem_
local button_close_
local visibleCamerasMenuItem_
	
local function setPredefinedBookmarkItems(useAirfields)
-- set PredefinedBookmarks somewhere in the Lua state 

	menuPredefinedBookmarks_:clear()	
	if PredefinedBookmarks ~= nil then
		for i = 1, table.getn(PredefinedBookmarks) do
			local bookmarkInfo = PredefinedBookmarks[i]
			local name = bookmarkInfo.name	           
			local menuItem = MenuItem.new(name)
			menuItem.id = i - 1
			menuPredefinedBookmarks_:insertItem(menuItem)
		end	
	end
	if useAirfields == 1 then
		local menuItem = MenuSeparatorItem.new()
		menuPredefinedBookmarks_:insertItem(menuItem)
		menuItem = MenuItem.new(localization.by_default)
		menuItem.id = -2	-- by default ID	
		menuPredefinedBookmarks_:insertItem(menuItem)
		
		menuItem = MenuSeparatorItem.new()
		menuPredefinedBookmarks_:insertItem(menuItem)
		menuItem = MenuItem.new(localization.terrain_position)
		menuItem.id = -1	-- terrain position ID	
		menuPredefinedBookmarks_:insertItem(menuItem)
	end
end

local function setAirdromeBookmarks()
-- PredefinedBookmarks created here (names only)

	PredefinedBookmarks = {}
	for airdromeNumber, airdromeInfo in pairs(Terrain.GetTerrainConfig('Airdromes')) do
        local locale = i18n.getLocale()		
        local name	           
        if airdromeInfo.display_name then
            name = _(airdromeInfo.display_name) 
        else
            name = airdromeInfo.names[locale] or airdromeInfo.names['en']
        end
		local bookmarkInfo = {name = name} 		
		table.insert(PredefinedBookmarks, bookmarkInfo)
	end
	--print("setAirdromeBookmarks: PredefinedBookmarks size = "..table.getn(PredefinedBookmarks)) 
end

local function updateUserBookmarkItems()
-- set UserBookmarks somewhere in the Lua state

	menuUserBookmarks_:clear()
	if UserBookmarks ~= nil then
		local id = 0
		-- Editor MenuCheckItem with specific id = 'editor'		
		editorMenuItem_ = MenuCheckItem.new(localization.editor)
		editorMenuItem_.id = 'editor'
		menuUserBookmarks_:insertItem(editorMenuItem_)
		-- Visible cameras MenuCheckItem with specific id = 'visible_cameras'		
		visibleCamerasMenuItem_ = MenuCheckItem.new(localization.visible_cameras)
		visibleCamerasMenuItem_.id = 'visible_cameras'
		menuUserBookmarks_:insertItem(visibleCamerasMenuItem_)
		local menuItem = MenuSeparatorItem.new()
		menuUserBookmarks_:insertItem(menuItem)		
		for i = 1, table.getn(UserBookmarks) do
			local bookmarkInfo = UserBookmarks[i]
			local name = bookmarkInfo.name
			menuItem = MenuItem.new(name)
			menuItem.id = i - 1
			menuUserBookmarks_:insertItem(menuItem)
		end
	end	
end

local function setEditorCheckBox(state)
	editorMenuItem_:setState(state)
end

local function setVisibleCamerasCheckBox(state)
	visibleCamerasMenuItem_:setState(state)
end

local function setCameraModeRadio(id)
	if menuCameraMode_ then
		menuCameraMode_:setRadio(id)
	end
end 

local function setClipboardItems(useAirfields)
	local id = 0
    local menuItem = MenuItem.new(localization.camera_to_clipboard)
	menuItem.id = id
	menuClipboard_:insertItem(menuItem)
	if useAirfields == 1 then		
		id = id + 1
		menuItem = MenuItem.new(localization.clipboard_to_camera)
		menuItem.id = id
		menuClipboard_:insertItem(menuItem)
	end
end

local function create(useAirfields)		
	local screenWidth, screenHeight = dxgui.GetWindowSize()
--	print('screen:', screenWidth, screenHeight)
	if (useAirfields == 1) then
		localization.predefined_bookmarks = localization.current_positions
	end
	window_ = DialogLoader.spawnDialogFromFile('./Scripts/UI/View/MenuBarBookmarksDialog.dlg', localization)
	local w, h = window_:getSize()
--	print('dialog:', w, h)
	window_:setBounds(0, 0, screenWidth, h)	
	window_:setSkin(SkinUtils.setWindowBkgColor(window_:getSkin(), 0x00000080))
	menuBar_ = window_.menuBarTop
	button_close_ = window_.button_close
	menuPredefinedBookmarks_ = menuBar_.menuBarItemPredefinedBookmarks.menu
	menuUserBookmarks_ = menuBar_.menuBarItemUserBookmarks.menu
	menuClipboard_ = menuBar_.menuBarItemClipboard.menu
	menuItemCameraMode_ = menuBar_.menuBarItemCameraMode
	if useAirfields == 1 then
		setAirdromeBookmarks()	
	end
	setPredefinedBookmarkItems(useAirfields)
	
--	updateUserBookmarkItems()	-- called from C++
	setClipboardItems(useAirfields)
	
	if useAirfields ~= 1 then
		menuBar_:removeItem(menuItemCameraMode_)
	else	
		menuCameraMode_ = menuItemCameraMode_.menu
		radioFrontal_ = menuCameraMode_.menuRadioItemFrontal
		radioFrontal_.id = 0
		radioHorizontal_ = menuCameraMode_.menuRadioItemHorizontal
		radioHorizontal_.id = 1
		radioVertical_ = menuCameraMode_.menuRadioItemVertical
		radioVertical_.id = 2
		radioFrontal_:setState(true)
		lookDownItem_ = menuCameraMode_.menuLookDownItem
		lookDownItem_.id = 4
		worldAxesItem_ = menuCameraMode_.menuWorldAxesItem
		worldAxesItem_.id = 5
		
		function menuCameraMode_:onChange()
			local item = self:getSelectedItem()
--			print("menuCameraMode_:onChange()-> id = "..item.id..", text = "..item:getText())
			if item.id < 3 then
				onCameraModeRadio(item.id)
			elseif item.id == 4 then
				onCameraLookDown()
			elseif item.id == 5 then
				onCameraWorldAxes()
			end
		end
		
		function menuCameraMode_:setRadio(id)
			if id == 0 then
				radioFrontal_:setState(true)
			else 
				if id == 1 then
					radioHorizontal_:setState(true)
				else 
					if id == 2 then
						radioVertical_:setState(true)
					end
				end
			end
		end
	end	
	
	function menuPredefinedBookmarks_:onChange()
		local item = self:getSelectedItem()
--		print("menuPredefinedBookmarks_:onChange()-> id = "..item.id..", text = "..item:getText())
		onPredefinedBookmarksMenu(item.id, item:getText())
	end
	
	function menuUserBookmarks_:onChange()
		local item = self:getSelectedItem()
--		print("menuUserBookmarks_:onChange()-> id = "..item.id..", text = "..item:getText())
		if item.id == 'editor' then
			local state = item:getState()
--			print('state =', state)
			onEditorCheckBox(state)
		elseif item.id == 'visible_cameras' then
			local state = item:getState()
			onVisibleCamerasCheckBox(state)
		else
			onUserBookmarksMenu(item.id, item:getText())
		end
	end
	
	function menuClipboard_:onChange()
		local item = self:getSelectedItem()
--		print("menuClipboard_:onChange()-> id = "..item.id..", text = "..item:getText())
		onClipboardMenu(item.id, item:getText())
	end
	
	function button_close_:onChange()
		onButtonClose()
	end
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

return {
	create								= create,
	kill								= kill,
	show								= show,
	hide								= hide,
	getWindow							= getWindow,
	isVisible							= isVisible,
		
	setPredefinedBookmarkItems			= setPredefinedBookmarkItems,
	setAirdromeItems					= setAirdromeItems,
	updateUserBookmarkItems				= updateUserBookmarkItems,
	setEditorCheckBox					= setEditorCheckBox,
	setCameraModeRadio					= setCameraModeRadio,
	setVisibleCamerasCheckBox			= setVisibleCamerasCheckBox,
}
