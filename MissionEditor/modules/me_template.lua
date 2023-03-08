local base = _G

module('me_template')

local require = base.require
local math = base.math
local pairs = base.pairs
local ipairs = base.ipairs
local table = base.table
local print = base.print

local DialogLoader			= require('DialogLoader')
local ListBoxItem			= require('ListBoxItem')
local U						= require('me_utilities')  
local T						= require('tools')	
local MapWindow				= require('me_map_window')
local DB					= require('me_db_api')
local crutches				= require('me_crutches')  -- temporary crutches
local ConfigHelper			= require('ConfigHelper')
local OptionsData			= require('Options.Data')
local CoalitionController	= require('Mission.CoalitionController')
local PanelUtils			= require('PanelUtils')
local i18n                  = require('i18n')
local textutil              = require('textutil')

i18n.setup(_M)

templates = {}

local comboListTemplates_
local comboListCountries_
local editBoxGroupName_
local editBoxName_
local dialHeading_
local editBoxInvalidSkin_

local writePath = ConfigHelper.getConfigWritePath('templates.lua')
local sysPath = ConfigHelper.getSysFilePath('templates.lua')

function save_templates()
	local templatesTmp = {}
	for k,v in base.pairs(templates) do
		if v.sys ~= true then
			templatesTmp[k] = v
		end
	end
	U.saveUserData(ConfigHelper.getConfigWritePath('templates.lua'), {templates = templatesTmp}, true)
end

function load_templates()
	local fTempl = T.safeDoFile(writePath, false)
	local fTemplSys = T.safeDoFile(sysPath)
	templates = {}
  
	for k, fTempl in ipairs({fTempl, fTemplSys}) do
		tmpTemplates = (fTempl and fTempl.templates) or {}
		for templName, templ in pairs(tmpTemplates) do
			--fix templates name
			if templName ~= templ.name then
				templ.name = templName
			end
			
			if templ.units then
				local bAdd = true
				for k,v in base.pairs(templ.units) do
					if DB.unit_by_type[v.name] == nil then
						bAdd = false
					end
				end
				if bAdd == true then
					if templates[templName] then
						if U.compareTables(templates[templName], templ) ~= true then
							local newName = templName.."-copy"
							templates[newName] = {}
							base.U.recursiveCopyTable(templates[newName], templates[templName])
							templates[newName].name = newName
						end
					end
					templates[templName] = templ
					if k == 2 then
						templates[templName].sys = true
					end
				end
			end
		end
	end	
end

local function compareTempl(templ1, templ2)
    return textutil.Utf8Compare(templ1.templName, templ2.templName)
end

local function fillTemplatesCombo(countryName, comboList)
	local c = DB.country_by_name[countryName]
	comboList:clear() 
    
    local templs = {}
    for templName, templ in pairs(templates) do
        local tmpTempl = {}
        tmpTempl.templName  = i18n.ptranslate(templName)
        tmpTempl.id         = templName
        tmpTempl.templ      = templ
        table.insert(templs,tmpTempl)
    end
	
    table.sort(templs, compareTempl)
    
	for k, templ in ipairs(templs) do
		if templ.templ.country == c.WorldID and templ.templ.isCustomForm ~= true then
			local item = ListBoxItem.new(templ.templName)
            item.name = templ.templName
            item.id = templ.id
			if templ.templ.sys then
				item:setSkin(lbSysSkin)
			else
				item:setSkin(lbNormalSkin)
			end
			comboList:insertItem(item)
		end
	end
	
	local itemCount = comboList:getItemCount()
	
	if itemCount > 0 then
		comboList:selectItem(comboList:getItem(0))
	else
		comboList:selectItem(nil)
	end
end

local function createTemplate(name, selectedGroup)
	local temlateUnits = {}
	local x = selectedGroup.x
	local y = selectedGroup.y
	
	for i, unit in ipairs(selectedGroup.units) do
		local skill = unit.skill

		if unit.skill == crutches.getPlayerSkill() then
			skill = crutches.getDefaultSkillAir()
		end
		
		local payload
		
		if unit.payload then
			payload = U.copyTable(nil, unit.payload)
		end
		
		if unit.boss.type == "helicopter" or unit.boss.type == "plane" then	
			skill = crutches.skillToIdAir(skill)
		else
			skill = crutches.skillToId(skill)
		end

		table.insert(temlateUnits, {	name	= unit.type, 
										dx		= unit.x - x, 
										dy		= unit.y - y, 
										skill	= skill, 
										heading	= unit.heading,
										payload	= payload,
									})
	end
	
	return {
		name			= name, 
		country			= selectedGroup.boss.id, 
		type			= selectedGroup.type,
		frequency		= selectedGroup.frequency,
		modulation		= selectedGroup.modulation,
		communication	= selectedGroup.communication,
		units			= temlateUnits,
	}
end

function create(x, y, w, h)
	load_templates()
	
	local localization = {
		title 				= _('TEMPLATES'),
		panel_set_title		= _('CREATE GROUP FROM TEMPLATE:'),
		panel_create_title	= _('CREATE NEW TEMPLATE:'),
		save 				= _('SAVE TEMPLATE'),
		selected_group 		= _('SELECTED GROUP:'),
		template_name 		= _('TEMPLATE NAME:'),
		del 				= 'X',
		heading 			= _('HEADING'),
	}

	window = DialogLoader.spawnDialogFromFile("MissionEditor/modules/dialogs/me_template_panel.dlg", localization)
	window:setBounds(x, y, w, h)
	w_ = w
	
	lbNormalSkin = window.pNoVisible.lbNormal:getSkin()
	lbSysSkin = window.pNoVisible.lbSys:getSkin()

	function window:onClose()
		MapWindow.setState(MapWindow.getPanState())
		base.statusbar.updateState()
		show(false)
		base.toolbar.setTemplateButtonState(false)
		MapWindow.unselectAll();
		MapWindow.expand()	
	end
	
	editBoxInvalidSkin_ = window.editBoxInvalidSkin:getSkin()

	comboListCountries_ = window.comboListCountries
	fillCountries()

	comboListTemplates_ = window.comboListTemplates
	fillTemplatesCombo(comboListCountries_:getText(), comboListTemplates_)

	function window.buttonDelete:onChange()
		local curTempl = getSelectedTemplate()
	 
		if curTempl then
			templates[curTempl.name] = nil

			save_templates()
			fillTemplatesCombo(comboListCountries_:getText(), comboListTemplates_)
		end
	end	   
	
	function comboListCountries_:onChange()
	  fillTemplatesCombo(comboListCountries_:getText(), comboListTemplates_)
	end	  

	dialHeading_ = window.dialHeading
	
	local spinBoxHeading = window.spinBoxHeading
	
	function spinBoxHeading:onChange()
		local value = self:getValue()
		
		if value == -1 then
			value = 359
			self:setValue(value)
		elseif value == 360 then
			value = 0
			self:setValue(value)
		end
		
		dialHeading_:setValue(value)
		dialHeading_:onChange()
	end
	
	function dialHeading_:onChange()
		spinBoxHeading:setValue(math.floor(self:getValue()))
	   
		-- ворочаем текущую группу
		local selectedGroup = MapWindow.selectedGroup
		
		if not selectedGroup then 
			return 
		end

		local _heading = U.toRadians(dialHeading_:getValue()) - selectedGroup.units[1].heading
		local x_ = selectedGroup.x
		local y_ = selectedGroup.y
		
		for k,v in pairs(selectedGroup.units) do			 
			if v.index > 1 then 
				local _dx = v.x - x_
				local _dy = v.y - y_
				local _new_x = x_ + _dx*math.cos(_heading) - _dy*math.sin(_heading)
				local _new_y = y_ + _dx*math.sin(_heading) + _dy*math.cos(_heading)

				MapWindow.move_unit(v.boss, v, _new_x, _new_y);
			end					   
			v.heading = math.mod(_heading + v.heading, 2 * math.pi)			   
		end		   
		updateHeading(selectedGroup)
	end
	
	local panelSave		= window.panelSave
	
	editBoxGroupName_	= panelSave.editBoxGroupName
	editBoxName_		= panelSave.editBoxName

	function panelSave.buttonSave:onChange()
		local selectedGroup = MapWindow.selectedGroup
		
		if not selectedGroup then
			PanelUtils.blinkWidget(editBoxGroupName_, editBoxInvalidSkin_)
			
			return
		end
		
		local templateName = editBoxName_:getText()
		
		if templateName == "" or templates[templateName] then 
			PanelUtils.blinkWidget(editBoxName_, editBoxInvalidSkin_)
			
			return 
		end
	  
		templates[templateName] = createTemplate(templateName, selectedGroup)

		comboListCountries_:setText(selectedGroup.boss.name)
		comboListCountries_:onChange()

		save_templates()
	end
end

-------------------------------------------------------------------------------
--
function updateHeading(a_group)
	if a_group then		
		if OptionsData.getIconsTheme() == 'russian' then	
				for k,v in pairs(a_group.mapObjects.units) do
					local classInfo = MapWindow.getClassifierObject(v.classKey)
					if classInfo and classInfo.rotatable then
						local heading = a_group.units[k].heading
						a_group.mapObjects.units[k].angle = MapWindow.headingToAngle(heading); -- в объектах карты храним все в градусах									 
					end
				end						
				if a_group.mapObjects.route and a_group.mapObjects.route.points 
					and	 a_group.mapObjects.route.points[1] then
					local unitMapObject = a_group.mapObjects.units[1]
					local classInfo = MapWindow.getClassifierObject(unitMapObject.classKey)
					if classInfo and classInfo.rotatable then
						a_group.mapObjects.route.points[1].angle = MapWindow.headingToAngle(a_group.units[1].heading)					 
					end
				end
				base.module_mission.update_group_map_objects(a_group);
		   
		end
	end
end

function update()
  if (MapWindow.selectedGroup and MapWindow.selectedGroup.name) then
	editBoxGroupName_:setText(MapWindow.selectedGroup.name)
	comboListCountries_:setText(MapWindow.selectedGroup.boss.name)
	comboListCountries_:onChange()
  else
	editBoxGroupName_:setText("")
  end
end

function show(b)
	if b then 
		if window:getVisible() == false then
			MapWindow.collapse(w_, 0)
		end
		fillCountries()
		update()
	elseif window:getVisible() == true then
		MapWindow.expand()	 
	end
	window:setVisible(b)
	editBoxName_:setText("")
end

function getSelectedTemplate()
    local selectItem = comboListTemplates_:getSelectedItem()
    if selectItem then
        return templates[comboListTemplates_:getSelectedItem().id]
    end
	return 
end

function addCFTemplate(customForm)
    if templates[customForm.name] ~= nil then 
        return
    end    
    
	local newTempl = 
	{
		name			= customForm.name,
		units			= {},
		isCustomForm	= true,
	}
	
	for i, v in ipairs(customForm.positions) do
		local unit = 
		{
			dx		= v.x, 
			dy		= v.y, 
			heading	= v.heading, 
		}
		
		table.insert(newTempl.units, unit)
	end
	
	templates[newTempl.name] = newTempl
end

function fill_combo(combo, t, curCountry)
	local curItem
    combo:clear()  
    if not t then
        combo:setText("")
        return
    end 
    for i, v in ipairs(t) do
		local item = ListBoxItem.new(v)
      
		item.index = i
		combo:insertItem(item)
		if curCountry == v then
			curItem = item
		end
    end
	
	if curItem then
        combo:selectItem(curItem)
    elseif base.next(t) then
        combo:setText(t[base.next(t)])
    else
        combo:setText('')
    end
end

function fillCountries()
	local curCountry = comboListCountries_:getText()
	comboListCountries_:clear()
	local countries = CoalitionController.getActiveCountries()
	fill_combo(comboListCountries_, countries, curCountry)
end

function getCountry()
	return comboListCountries_:getText()
end

function getHeading()
	return dialHeading_:getValue()
end