local parameters = {
	fighter = true,
	radar = true,
	ECM = true,
	refueling = true
}

local menus = data.menus

utils.verifyChunk(utils.loadfileIn('Scripts/UI/RadioCommandDialogPanel/Config/LockOnAirplane.lua', getfenv()))(parameters)
utils.verifyChunk(utils.loadfileIn('Scripts/UI/RadioCommandDialogPanel/Config/Common/JTAC.lua', getfenv()))(9)
utils.verifyChunk(utils.loadfileIn('Scripts/UI/RadioCommandDialogPanel/Config/Common/Ground Crew.lua', getfenv()))(8)

-- Wheel Chocks
menus['Wheel chocks'] = {
	name = _('Wheel chocks'),
	items = {
		[1] = {name = _('Place'),	command = sendMessage.new(Message.wMsgLeaderGroundToggleWheelChocks, true)},
		[2] = {name = _('Remove'),	command = sendMessage.new(Message.wMsgLeaderGroundToggleWheelChocks, false)}
	}
}

menus['Ground Crew'].items[4] = { name = _('Wheel chocks'), submenu = menus['Wheel chocks']}

function specialEvent(params) 
	return staticParamsEvent(Message.wMsgLeaderSpecialCommand,params)
end

local function helmetEvent(is_NVG)
	return specialEvent({type = 4,device = is_NVG})
end

menus['Change helmet-mounted device'] =
{
	name = _('Change helmet-mounted device'),
	items = {
		[1] = {name = _('Setup Visor'),	command = helmetEvent(0) },
		[2] = {name = _('Setup NVG'),	command = helmetEvent(1) },
	}
}

local g_crew_items = menus['Ground Crew'].items;

g_crew_items[#g_crew_items  + 1] = 
{
	name 	= _('Change helmet-mounted device'),
	submenu = menus['Change helmet-mounted device']
}

table.insert(menus['Ground Crew'].items, { name = _('Load Water'), command = 
{
	perform = function(self)		
		local device = data.base.GetDevice(28)
		if device then
			device:load_water()
		end
	end
}})

