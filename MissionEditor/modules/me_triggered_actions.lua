local base = _G

module('me_triggered_actions')

local require = base.require

-- Модули LuaGUI
local DialogLoader = require('DialogLoader')
local crutches = require('me_crutches')
local ActionsListBox = require('me_actions_listbox')
local panel_route = require('me_route')

require('i18n').setup(_M)

local actionsListBox = nil

local cdata = 
{
    triggered_actions = _('TRIGGERED ACTIONS'),
}


function create(x, y, w, h)   
	window = DialogLoader.spawnDialogFromFile("MissionEditor/modules/dialogs/me_triggered_actions_panel.dlg", cdata)
    window:setBounds(x, y, w, h)
    
	local scrollP = window.scrollP
    actionsListBox = ActionsListBox.create()
    
    local panel = actionsListBox.panel
    panel:setPosition(scrollP.staticActionsListBoxPlaceholder:getPosition())
    scrollP:insertWidget(panel)
    
	actionsListBox:setHandlers( {
		onActionEditPanelShow = function()
		end,        
		onActionEditPanelHide = function()
		end
	} )	
end

-- Открытие/закрытие панели
function show(b)
	window:setVisible(b)
	if (b == true) then
		setPlannerMission(base.isPlannerMission())
	else	
		actionsListBox:show(false)
	end	
end

function updateActionsListBox()
	actionsListBox:update(true)
end

function setPlannerMission(planner_mission)
	if (planner_mission == true) then
		if (panel_route.vdata.group) and (panel_route.vdata.group.units[1].skill == crutches.getPlayerSkill()) then
			actionsListBox:show(true)
		else
			actionsListBox:show(false)
		end
	else
		actionsListBox:show(true)
	end
end

function setGroup(group)
	if group ~= nil then
		actionsListBox:setGroup(group)
	end
end

function selectItemByTaskAndOpenPanel(task)
    actionsListBox:selectItemByTaskAndOpenPanel(task)
end

function removeItemByTask(self,task)
	return actionsListBox:removeItemByTask(task)
end