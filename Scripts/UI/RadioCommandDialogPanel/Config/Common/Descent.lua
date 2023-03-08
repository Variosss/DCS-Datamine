local mainMenuPos = ...
--Menu
local menus = data.menus

local StaticList    = require("StaticList")



menus['Descent'] = {
	name = _('Descent'),
	items = 
	{
	},
	onEnterMenu = function(menu, pUnit)
		local count, reserv = pUnit:getDescentOnBoard()
		local capacity = pUnit:getDescentCapacity()
		local text = _("Descent").." "..count.."/"..capacity.."    ["..reserv.." R]"
		menu.additionalStaticSetText(text)
	end,
	onLeaveMenu = function(menu)
		menu.additionalStaticHide()		
	end,
	
	updatePosition = function(menu)
		menu.additionalStaticUpdatePosition()
	end,
}


local function getDescents()
	local t_descents = coalition.getAllDescents(data.pUnit:getObjectID(), true)
	return t_descents
end

local function buildDescents(self, menu)
	local t_descents = getDescents()
	menu.items[mainMenuPos] = buildDescentsMenu(t_descents, _('Airborne Troops'), { name = _('Descent'), submenu = menus['Descent']}, data.pUnit)
end

table.insert(data.rootItem.builders, buildDescents)

--Dialogs

local worldEventHandler = {
	onEvent = function(self, event)
	end,
}

table.insert(data.worldEventHandlers, worldEventHandler)

--Message Handler

local msgHandler = {
	onMsg = function(self, pMessage, pRecepient)
		self:onMsgEvent(pMessage:getEvent(), pMessage:getSender(), pRecepient)
	end,
	onMsgEvent = function(self, event, pMsgSender, pRecepient)
	end,
}


table.insert(data.msgHandlers, msgHandler)