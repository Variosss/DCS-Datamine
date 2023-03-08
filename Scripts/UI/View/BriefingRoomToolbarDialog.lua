-- toolbar for the Briefing Room view
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
local i18n 				= require('i18n')

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
	room_views				= _('Room Views'),
	air_squadrons			= _('Air Squadrons'),
	pilots					= _('Pilots'),	
	from_room				= _('From Room'),
	to_room					= _('To Room'),
	TV						= _('TV'),
	projector				= _('Projector'),
	greenie_board			= _('Greenie Board'),
	kill_board				= _('Kill Board'),
	pilot_PC				= _('Pilot PC'),
	commander_PC			= _('Commander PC'),
	camera_mode				= _('Camera mode'),
	frontal					= _('Frontal'),
	horizontal				= _('Horizontal'),
	vertical				= _('Vertical'),
	along_the_walls			= _('Along The Walls'),
}

local camera_name_
local window_
local menuBar_
local menuViews_
local menuRoomViews_
local menuAirSquadrons_
local menuPilots_
local menuCameraMode_
local radioFrontal_
local radioHorizontal_
local radioVertical_
local radioAlongTheWalls_
local radioWASD_
local buttonClose_

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
    menuViews_.menuItemSupercarrier.func  	= onSupercarrier
    menuViews_.menuItemAirBoss.func       	= onAirBoss
    menuViews_.menuItemLSO.func           	= onLSO
    menuViews_.menuItemCatapults.func     	= onCatapults
    menuViews_.menuItemHangar.func      	= onHangar
    menuViews_.menuItemBriefingRoom.func  	= onBriefingRoom
    setMenuCallback(menuViews_)
end

local function setRoomViewsMenu()
    menuRoomViews_.menuItemFromRoom.func  = function() onCameraCustomPosition(1) end
    menuRoomViews_.menuItemToRoom.func  = function() onCameraCustomPosition(2) end
    menuRoomViews_.menuItemTV.func  = function() onCameraCustomPosition(3) end
    menuRoomViews_.menuItemProjector.func  = function() onCameraCustomPosition(4) end
    menuRoomViews_.menuItemGreenieBoard.func  = function() onCameraCustomPosition(5) end
	menuRoomViews_.menuItemKillBoard.func  = function() onCameraCustomPosition(6) end
	menuRoomViews_.menuItemCommanderPC.func  = function() onCameraCustomPosition(7) end	
	menuRoomViews_.menuItemPilotPC.func  = function() onCameraCustomPosition(8) end	
	setMenuCallback(menuRoomViews_)
end

local function updateAirSquadronsMenu()
--	print('updateAirSquadronsMenu()')
	if (menuAirSquadrons_ ~= nil and AirSquadrons ~= nil) then
		menuAirSquadrons_:clear()
--		print('AirSquadrons: ', table.getn(AirSquadrons))
--		for k, v in pairs(AirSquadrons) do
--			print('~~~k, v', k, v)
--		end
		for i = 1, table.getn(AirSquadrons) do
			local name = AirSquadrons[i]
			local menuItem = MenuItem.new(name)
--			menuItem.id = i - 1
			menuAirSquadrons_:insertItem(menuItem)			
		end
		function menuAirSquadrons_:onChange()
			local item = self:getSelectedItem()
			onAirSquadron(item:getText())
		end	
	end
end

local function updatePilotsMenu()
--	print('updatePilotsMenu()')
	if (menuPilots_ ~= nil and Pilots ~= nil) then
		menuPilots_:clear()
--		print('Pilots: ', table.getn(Pilots))
--		for k, v in pairs(Pilots) do
--			print('~~~k, v', k, v)
--		end
		for i = 1, table.getn(Pilots) do
			local name = Pilots[i]
			local menuItem = MenuItem.new(name)
--			menuItem.id = i - 1
			menuPilots_:insertItem(menuItem)			
		end
		function menuPilots_:onChange()
			local item = self:getSelectedItem()
			onPilot(item:getText())
		end	
	end
end

local function create(camera_name)
	camera_name_ = camera_name
--	print('BriefingRoomToolbarDialog:create(' .. camera_name_ .. ')')
	local screenWidth, screenHeight = dxgui.GetWindowSize()
	window_ = DialogLoader.spawnDialogFromFile('./Scripts/UI/View/BriefingRoomToolbarDialog.dlg', localization)
	local w, h = window_:getSize()
--	print('screenWidth = ', screenWidth)
	window_:setBounds(0, 0, screenWidth, h)	
	window_:setSkin(SkinUtils.setWindowBkgColor(window_:getSkin(), 0x00000080))
	
	buttonClose_ = window_.button_close
	function buttonClose_:onChange()
		window_:setVisible(false)
	end
	
	menuBar_ = window_.menuBarTop	
	
	menuViews_ = menuBar_.menuBarItemViews.menu
	menuRoomViews_ = menuBar_.menuBarItemRoomViews.menu
	menuAirSquadrons_ = menuBar_.menuBarItemAirSquadrons.menu
	function menuAirSquadrons_:onChange()
		local item = self:getSelectedItem()
		onAirSquadron(item:getText())
	end	
	menuPilots_ = menuBar_.menuBarItemPilots.menu
	function menuPilots_:onChange()
		local item = self:getSelectedItem()
		onPilot(item:getText())
	end
	menuCameraMode_ = menuBar_.menuBarItemCameraMode.menu
	radioFrontal_ = menuCameraMode_.menuRadioItemFrontal
	radioFrontal_:setState(true)
	radioFrontal_.id = 0
	radioHorizontal_ = menuCameraMode_.menuRadioItemHorizontal	
	radioHorizontal_.id = 1
	radioVertical_ = menuCameraMode_.menuRadioItemVertical	
	radioVertical_.id = 2
	radioAlongTheWalls_ = menuCameraMode_.menuRadioItemAlongTheWalls
	radioAlongTheWalls_.id = 3
	radioWASD_ = {
		radioFrontal_,
		radioHorizontal_,
		radioVertical_,
		radioAlongTheWalls_,
	}
	function menuCameraMode_:onChange()
		local item = self:getSelectedItem()
--		print("menuCameraMode_:onChange()-> id = "..item.id..", text = "..item:getText())
		onCameraModeRadio(item.id)
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

local function setVisible(visible)
	window_:setVisible(visible)
end

local function getWindow()
	return window_.widget
end

local function setMenuCallbacks()
	setViewsMenu()
	setRoomViewsMenu()
end

local function setCameraMode(mode)
	if mode >= 0 and mode <= 3 then
		radioWASD_[mode + 1]:setState(true)
	end
end

return {
	create						= create,
	kill						= kill,
	show						= show,
	hide						= hide,
	getWindow					= getWindow,
	isVisible					= isVisible,
	setVisible					= setVisible,
	setMenuCallbacks			= setMenuCallbacks,
	updateAirSquadronsMenu		= updateAirSquadronsMenu,
	updatePilotsMenu			= updatePilotsMenu,
	setCameraMode				= setCameraMode,
}
