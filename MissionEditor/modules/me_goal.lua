local base = _G

module('me_goal')

local DialogLoader 	= base.require('DialogLoader')
local mission 		= base.require('me_mission')
local U 			= base.require('me_utilities')
local predicates 	= base.require('me_predicates')
local ProductType 	= base.require('me_ProductType') 

base.require('i18n').setup(_M)


local types = { 
    { id = 'OFFLINE', name = _('OFFLINE') },
    { id = 'RED', name = _('RED (Multiplayer only)') }, 
    { id = 'BLUE', name = _('BLUE (Multiplayer only)') },
	
}

base.table.insert(types, { id = 'NEUTRALS', name = _('NEUTRALS (Multiplayer only)') })


-- returns list of goals types
function goalsTypesLister()
    return types
end

-- convert rule ID to localized rule name
function localizeGoal(cdata, rule)
    return _(rule)
end


-- list of available actions for score calculation and their arguments
goalActionsDescr = {
    {
        name = "score";
        firstValueAsName = true;
        fields = {
            {
                id = "comment",
                type = "edit",
                default = "",
            },
            {
                id = "score",
                type = "spin",
                default = 100,
                min = -100,
                max = 100,
            },
            {
                id = "side",
                type = "combo",
                default = 'OFFLINE',
                comboFunc = goalsTypesLister,
                displayFunc = localizeGoal,
            }
        }
    },
}


-- goals localization resources
cdata = {
    goals = _("MISSION GOALS"),
    new = _("NEW"),
    update = _("UPDATE"),
    delete = _("DELETE"),
    rules = _("RULES"),
    rule = _("TYPE:"),
    type = _("ACTION:"),
    side = _("SIDE:"),
    clone = _("CLONE"),


    predicates = {
        score = _("SCORE"),
        side = _("SIDE:"),
    },

    values = {
        score = _("SCORE:"),
        comment = _("NAME:"),
        text = _("TEXT:"),
    }
};

if ProductType.getType() == "LOFAC" then
    cdata.goals = _("MISSION GOALS-LOFAC")
end

-- show goals dialog
function showGoals(b)
    if b then
        if not mission.mission.goals then
            mission.mission.goals = { }
        end
        fixGoals(mission.mission.goals)
        setupCallbacks(goalsWindow, mission.mission.goals, 
                        goalActionsDescr, predicates.rulesDescr, cdata)
    end
    goalsWindow:setVisible(b)
end


function create(x, y, w, h)
    U.copyTable(cdata, predicates.cdata)
    
    goalsWindow = DialogLoader.spawnDialogFromFile('MissionEditor/modules/dialogs/misgoals_dialog.dlg', cdata)
	
    goalsWindow:setBounds(x, y, w, h)
    
    if 1 == #goalActionsDescr then
        hideActionType(goalsWindow)
    end
end



-- create widgets for rule predicate editing
function createRuleArgumentsWidgets(window, rule, list, cdata)
    local labelX, _tmp, labelW, _tmp1 = window.ruleTypeLabel:getBounds()
    local comboX, _tmp, comboW, comboH = window.ruleTypeCombo:getBounds()
    predicates.updateArgumentsPanel(rule, list, window.argsContainer, labelX, 
        comboX, labelW, comboW, comboH, cdata)
end


-- create widgets for action editing
function createActionArgumentsWidgets(window, rule, cdata)
    local labelX, _tmp, labelW, _tmp1 = window.goalTypeLabel:getBounds()
    local comboX, _tmp, comboW, comboH = window.goalTypeCombo:getBounds()
    predicates.updateArgumentsPanel(rule, window.goalsList, 
        window.goalArgsContainer, labelX, comboX, labelW, comboW, comboH, 
        cdata)
end


-- Create action from description
function createAction(descr)
    local res = predicates.createRule(descr)
    res.rules = { }
    return res
end


-- show or hide rules widgets
function showRulesWidgets(window, visible)
    predicates.showWidgets(visible, window.argsContainer, window.ruleTypeCombo,
        window.ruleTypeLabel, window.delRuleBtn, window.cloneRuleBtn)
end


-- show or hide goals widgets
function showGoalsWidgets(window, visible, noActionChoice)
    if noActionChoice then
        predicates.showWidgets(visible, window.goalArgsContainer, 
                window.delGoalBtn, window.cloneGoalBtn)
    else
        predicates.showWidgets(visible, window.goalArgsContainer, 
                window.goalTypeCombo, window.goalTypeLabel, window.delGoalBtn , window.cloneGoalBtn)
    end
end


-- hide action type combo
function hideActionType(window)
    window.goalTypeLabel:setVisible(false)
    window.goalTypeCombo:setVisible(false)
    local x, y, w, h = window.goalArgsContainer:getBounds()
    local _tmp, _tmp1, _tmp2, offset = window.goalTypeCombo:getBounds()
    offset = offset + 4
    window.goalArgsContainer:setBounds(x, y - offset, w, h + offset)
end

-- setup callbacks
function setupCallbacks(window, goals, actionsDescr, rulesDescr, cdata)
    -- close form
    function window:onClose()
      base.toolbar.untoggle_all_except()
    end

    local noActionChoice = (1 == #actionsDescr)

    -- called on new goal selected 
    function window.goalsList:onChange(item)
        if item then
            showGoalsWidgets(window, true, noActionChoice)
            local goal = item.itemId
            predicates.rulesToList(window.rulesList, goal.rules, cdata)
            window.goalTypeCombo.selectedItem = goal
            window.goalTypeCombo:setText(predicates.getPredicateName(goal.predicate, cdata))
            createActionArgumentsWidgets(window, goal, cdata)
        else
            showGoalsWidgets(window, false, noActionChoice)
            predicates.rulesToList(window.rulesList, nil, cdata)
            showRulesWidgets(window, false)
        end
    end
    
    -- add new goal on new button pressed
    function window.newGoalBtn:onChange()
        local goal = createAction(actionsDescr[1])
        base.table.insert(goals, goal)
        local item = U.addListBoxItem(window.goalsList, 
                predicates.getRuleAsText(goal, cdata), goal)
        window.goalsList:selectItem(item)
        window.goalsList:onChange(item)
    end

    -- delete current goal
    function window.delGoalBtn:onChange()
        local item = window.goalsList:getSelectedItem()
        if item and (0 < window.goalsList:getItemCount()) then
            local goal = item.itemId
            local idx = predicates.getIndex(goals, goal)
            base.table.remove(goals, idx)
            window.goalsList:removeItem(item)
            if idx > window.goalsList:getItemCount() then
                idx = idx - 1
            end
            item = window.goalsList:getItem(idx - 1)
            window.goalsList:selectItem(item)
            window.goalsList:onChange(item)
        end
    end
    
    -- if action type was changed 
    function window.goalTypeCombo:onChange(item)
        self.selectedItem = item.itemId
        if window.goalsList:getSelectedItem() then
            local goal = window.goalsList:getSelectedItem().itemId
            goal.predicate = item.itemId
            predicates.setRuleDefaults(goal, item.itemId)
            createActionArgumentsWidgets(window, goal, cdata)
            predicates.updateListRow(window.goalsList, predicates.ruleTextFunc(cdata))
        end
    end
    
    
    -- called on new rule selected 
    function window.rulesList:onChange(item)
        if item then
            showRulesWidgets(window, true)
            local rule = item.itemId
            createRuleArgumentsWidgets(window, rule, window.rulesList, cdata)
            window.ruleTypeCombo.selectedItem = rule
            window.ruleTypeCombo:setText(predicates.getPredicateName(rule.predicate, cdata))
        else
            showRulesWidgets(window, false)
        end
    end
   
    
    function window.newRuleBtn:onChange()
        local goalItem = window.goalsList:getSelectedItem()
        if goalItem then
            local rule = predicates.createRule(rulesDescr[1])
            base.table.insert(goalItem.itemId.rules, rule)
            local item = U.addListBoxItem(window.rulesList, 
                        predicates.getRuleAsText(rule, cdata), rule)
            window.rulesList:selectItem(item)
            window.rulesList:onChange(item)
        end
    end

    -- if predicate type was changed 
    function window.ruleTypeCombo:onChange(item)
        self.selectedItem = item.itemId
        if window.rulesList:getSelectedItem() then
            local rule = window.rulesList:getSelectedItem().itemId
            rule.predicate = item.itemId
            predicates.setRuleDefaults(rule, item.itemId)
            createRuleArgumentsWidgets(window, rule, window.rulesList, cdata)
            predicates.updateListRow(window.rulesList, predicates.ruleTextFunc(cdata))
        end
    end
    
    -- delete rule
    function window.delRuleBtn:onChange()
        local currentGoal = window.goalsList:getSelectedItem()
        local item = window.rulesList:getSelectedItem()
        if currentGoal and item then
            local rule = item.itemId
            local goal = currentGoal.itemId
            local idx = predicates.getIndex(goal.rules, rule)
            base.table.remove(goal.rules, idx)
            window.rulesList:removeItem(item)
            if idx > window.rulesList:getItemCount() then
                idx = idx - 1
            end
            item = window.rulesList:getItem(idx - 1)
            window.rulesList:selectItem(item)
            window.rulesList:onChange(item)
        end
    end
    
    -- clone goal
    function window.cloneGoalBtn:onChange()
        local item = window.goalsList:getSelectedItem()
		if item then
			local cloneGoal = {}        
			U.recursiveCopyTable(cloneGoal, item.itemId)
			
			base.table.insert(goals, cloneGoal)
			local item = U.addListBoxItem(window.goalsList, 
					predicates.getRuleAsText(cloneGoal, cdata), cloneGoal)
			window.goalsList:selectItem(item)
			window.goalsList:onChange(item)
		end
    end
    
    -- clone rule
    function window.cloneRuleBtn:onChange()
        local goalItem = window.goalsList:getSelectedItem()
        if goalItem then
            local item = window.rulesList:getSelectedItem()
			if item then
				local cloneRule = {}        
				U.recursiveCopyTable(cloneRule, item.itemId)
				
				base.table.insert(goalItem.itemId.rules, cloneRule)
				local item = U.addListBoxItem(window.rulesList, 
						predicates.getRuleAsText(cloneRule, cdata), cloneRule)
				window.rulesList:selectItem(item)
				window.rulesList:onChange(item)
			end
        end
    end

    predicates.rulesToList(window.goalsList, goals, cdata)
    predicates.fillPredicatesCombo(window.goalTypeCombo, actionsDescr, cdata)
    predicates.fillPredicatesCombo(window.ruleTypeCombo, rulesDescr, cdata)
end

-- convert goals to serializable description
function saveGoals(goals)
  local result = { }
  U.copyTable(result, goals)
  for _tmp, goal in base.ipairs(result) do
      goal.predicate = goal.predicate.name
      for _tmp, rule in base.ipairs(goal.rules) do
        rule.predicate = rule.predicate.name
      end
  end
  return result
end


-- convert goals from serializable desctiption to internal representation
function loadGoals(goals)
    local actionsByName = predicates.getRulesIndex(goalActionsDescr)
    local predicatesByName = predicates.getRulesIndex(predicates.rulesDescr)
    local result = { }
    U.copyTable(result, goals)
    for _tmp, goal in base.ipairs(result) do
        goal.predicate = actionsByName[goal.predicate]
        for _tmp, rule in base.ipairs(goal.rules) do
            rule.predicate = predicatesByName[rule.predicate]
        end
        for _tmp, fieldDescr in base.ipairs(goal.predicate.fields) do
            if not goal[fieldDescr.id] then
                goal[fieldDescr.id] = fieldDescr.default
            end
        end
    end
    return result
end


-- Generate Lua functions from rules list.  
-- All functions returned in array as strings
function generateGoalConditions(goals, goalsType) 
  if not goals then
      return { }
  end
  local result = { }
  local idx = 1
  for _tmp, goal in base.ipairs(goals) do
    if goal.side == goalsType and goal.rules and (0 < #goal.rules) then
      local str = "return("
      local first = true
      for _tmp, rule in base.ipairs(goal.rules) do
        if not first then
          str = str .. 'and '
        else
          first = false
        end
        str = str .. predicates.actionToString(rule) .. ' '
      end
      str = str .. ')'
      result[idx] = str
    end
    idx = idx + 1
  end
  return result
end

function generateGoalActions(goals, goalsType) 
  if not goals then
      return { }
  end
  local result = { }
  local idx = 1
  for _tmp, goal in base.ipairs(goals) do
    if goal.side == goalsType and goal.rules and (0 < #goal.rules) then
      result[idx] = 'a_set_mission_result(' .. goal.score .. ')'
    end
    idx = idx + 1
  end
  return result
end

function generateGoalFunc2(goals, goalsType, parent)  -- Dmut: new format, conditions and actions separated
  if not goals then
      return { }
  end
  local result = { }
  local idx = 1
  for _tmp, goal in base.ipairs(goals) do
    if (goal.side == goalsType) and goal.rules and (0 < #goal.rules) then
      result[idx] = "if "..parent..".conditions["..base.tostring(idx).."]() then "..parent..".actions["..base.tostring(idx).."]() end"
    end
    idx = idx + 1
  end
  return result
end

-- remove invalid rules from goals
function fixGoals(goals)
  if goals then
    for _tmp, goal in base.ipairs(goals) do
        predicates.removeInvalidRules(goal.rules)
    end
  end
end

