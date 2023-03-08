local mainMenuPos = ...
--Menu
local menus = data.menus

menus['Cargos'] = {
	name = _('Cargos'),
	items = 
	{
	},
}

local function getCargos()
	return data.pUnit:getNearestCargos()
end

local function buildCargos(self, menu)
	local t_cargos = getCargos()
	menu.items[mainMenuPos] = buildCargosMenu(t_cargos, _('All Cargos'), { name = _('Cargos'), submenu = menus['Cargos']}, data.pUnit)
end

table.insert(data.rootItem.builders, buildCargos)

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