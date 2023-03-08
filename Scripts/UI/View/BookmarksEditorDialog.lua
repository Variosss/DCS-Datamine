local DialogLoader		= require('DialogLoader')
local gettext			= require('i_18n')
local dxgui				= require('dxgui')
local ListBoxItem		= require('ListBoxItem')
local SkinUtils         = require('SkinUtils')
local Skin              = require('Skin')

local function _(text) 
	return gettext.dtranslate('simulator', text) 
end

local localization = {
	bookmarksEditor	= _('Bookmarks Editor'),
	new 			= _('New'),
	jump    		= _('Jump'),
	delete			= _('Delete'),
}

local window_
local panelButtons_
local buttonNew_
local buttonJump_
local buttonDelete_
local listBoxNames_
local selectedItem_

-- CameraBookmarks table initially defined in C:\Users\<USER>\Saved Games\<ProductID>\Config\View\Bookmarks\...\*.lua
local function updateBookmarkItems()
--	print('updateBookmarkItems()')
	listBoxNames_:clear()
	local id = 0
	if CameraBookmarks ~= nil then
		for i = 1, table.getn(CameraBookmarks) do
			local bookmarkInfo = CameraBookmarks[i]
			local name = bookmarkInfo.name
			local listBoxItem = ListBoxItem.new(name)
			listBoxItem.id = id
			listBoxNames_:insertItem(listBoxItem)
			id = id + 1
--			print(name)
		end
--		print('listBoxNames_:getItemCount() = ', listBoxNames_:getItemCount())
	end
	local skin = listBoxNames_:getSkin()
	listBoxNames_:setSkin(SkinUtils.setWindowBkgColor(skin, 0x00000000))
	window_:getLayout():updateSize()
	local w, h = window_:getSize()
	local headerHeight = window_:getSkin().skinData.params.headerHeight
	local _, panelHeight = panelButtons_:getSize()
	local _, listHeight = listBoxNames_:getSize()
	window_:setSize(w, headerHeight + panelHeight + listHeight + 1)
end

local function create()	
--	print('BookmarsEditorDialog.create()')
	window_ = DialogLoader.spawnDialogFromFile('./Scripts/UI/View/BookmarksEditorDialog.dlg', localization)
--	print('window_:getBounds()', window_:getBounds())
	window_:setText(localization.bookmarksEditor)
	window_:setBounds(200, 100, 360, 240)
--	print('window_:getBounds()', window_:getBounds())
	window_:setSkin(SkinUtils.setWindowBkgColor(window_:getSkin(), 0x000000A0))
	listBoxNames_ = window_.listBoxNames
	panelButtons_ = window_.panelButtons
	buttonNew_ = window_.panelButtons.buttonNew
	buttonNew_:setText(localization.new)
	buttonJump_ = window_.panelButtons.buttonJump
	buttonJump_:setText(localization.jump)
	buttonDelete_ = window_.panelButtons.buttonDelete
	buttonDelete_:setText(localization.delete)
	-- updateBookmarkItems() -- called from C++
	
	function buttonNew_:onChange()
--		print('buttonNew_:onChange()')
--		print('onButtonNew', onButtonNew)
		onButtonNew()
	end
	
	function buttonJump_:onChange()
--		print('buttonJump_:onChange()')
		local selectedItem = listBoxNames_:getSelectedItem()
		if selectedItem ~= nil then
			local index = listBoxNames_:getItemIndex(selectedItem)
--			print('Selected item index:', index);
			onButtonJump(index)
		end
	end

	function listBoxNames_:onItemMouseDoubleClick()
--		print('listBoxNames_:onItemMouseDoubleClick()')
		local selectedItem = listBoxNames_:getSelectedItem()
		if selectedItem ~= nil then
			local index = listBoxNames_:getItemIndex(selectedItem)
--			print('Selected item index:', index);
			onButtonJump(index)
		end
	end
	
	function buttonDelete_:onChange()
--		print('buttonDelete_:onChange()')
		local selectedItem = listBoxNames_:getSelectedItem()
		if selectedItem ~= nil then
			local index = listBoxNames_:getItemIndex(selectedItem)
--			print('Selected item index:', index);
			onButtonDelete(index)
		end
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

local function getWindow()
	return window_.widget
end

local function selectBookmark(index)
	listBoxNames_:selectItem(listBoxNames_:getItem(index))
end

return {
	create								= create,
	kill								= kill,
	show								= show,
	hide								= hide,
	getWindow							= getWindow,
	updateBookmarkItems					= updateBookmarkItems,
	selectBookmark						= selectBookmark,
}
