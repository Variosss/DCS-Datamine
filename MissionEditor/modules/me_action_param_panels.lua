local base = _G

module('me_action_param_panels')

local require = base.require

local actionDB			= require('me_action_db')
local Panel				= require('Panel')
local ListBoxItem		= require('ListBoxItem')
local CheckListTree 	= require('CheckListTree')
local CheckListTreeMulty= require('CheckListTreeMulty')
local SkinUtils			= require('SkinUtils')

local U					= require('me_utilities')
local UC				= require('utils_common')
local crutches			= require('me_crutches')

local widgetFactory 	= require('me_action_panel_widget_factory')
local actionMapObjects	= require('me_action_map_objects')
local vehicle			= require('me_vehicle')
local loadOutUtils		= require('me_loadoututils')
local MsgWindow 		= require('MsgWindow')
local me_db_api			= require('me_db_api')
local OptionsData		= require('Options.Data')
local CoalitionController	= require('Mission.CoalitionController')
local TriggerZoneController	= require('Mission.TriggerZoneController')
local mod_dictionary        = require('dictionary')
local MeSettings 			= require('MeSettings')
local FileDialog 			= require('FileDialog')
local FileDialogFilters		= require('FileDialogFilters')
local FileDialogUtils		= require('FileDialogUtils')
local ProductType 			= require('me_ProductType') 


require('i18n').setup(_M)

local staticWidth = 1.7 * U.text_w
local staticHeight = U.widget_h

local function createStatic(text, x, y, w, h)
	-- почти все статики создаются в одном и том же месте
	return widgetFactory.createStatic(text, x or 0, y or 0, w or staticWidth, h or staticHeight)
end

local function createSpinBox(min, max, step, x, y, w, h)
	local spinBox = widgetFactory.createSpinBox(min, max, x, y, w, h)
	
	spinBox:setStep(step)
	spinBox:setValue(0)
	
	return spinBox
end

local getUnits = OptionsData.getUnits

local problemValueComboListItemSkin = SkinUtils.setListBoxItemTextColor('0xff8026ff')

function fill_combo_list_types(comboList, t)
    comboList:clear()  
	
	local itemAll = ListBoxItem.new(_("ALL"))
	itemAll.index = 1
	itemAll.type = "ALL"
	itemAll.DisplayName = _("ALL")
	comboList:insertItem(itemAll)
  
    for i, type in base.ipairs(t) do
        local DisplayName = me_db_api.getDisplayNameByName(type)
        local item = ListBoxItem.new(DisplayName)
        item.index = i + 1
        item.type = type
        item.DisplayName = DisplayName
        comboList:insertItem(item)
    end
    
    comboList:selectItem(comboList:getItem(0))
end

--Widget alignment
function addChild(child, parent, leftOffset, line0, rightOffset, linesQty)
	local left, top, width, height = parent:getClientRect()

	local child_top = (line0 - 1) * (U.widget_h + U.dist_h)
	local child_height = (linesQty - 1) * (U.widget_h + U.dist_h) + (U.widget_h+U.dist_h)
	child:setBounds(leftOffset, child_top, width - leftOffset - rightOffset, child_height)
	parent:insertWidget(child)
end

function addChildCenter(child, parent, widthRatio, line0, linesQty)
	base.assert(widthRatio <= 1.0)
	local parentLeft, parentTop, parentWidth, parentHeight = parent:getBounds()

	local childTop = (line0 - 1) * (U.widget_h + U.dist_h)
	local childHeight = U.dist_h + (linesQty - 1) * (U.widget_h + U.dist_h) + 5 + (U.widget_h+U.dist_h) + 5
	
	local gap = parentWidth * (1.0 - widthRatio) / 2
	
	child:setBounds(gap, childTop, parentWidth - 2 * gap, childHeight)
	parent:insertWidget(child)
end

function addPanel(parent, leftOffset, line0, rightOffset, linesQty)
	local panel = widgetFactory.createPanel()	
	
	addChild(panel, parent, leftOffset, line0, rightOffset, linesQty) 
		
	return panel
end

local function getLineRight(line)
	local widgetCount = line:getWidgetCount()
	if widgetCount > 0 then
		local widget = line:getWidget(widgetCount - 1)
		local left, top, width, height = widget:getBounds()
		
		return left + width
	else
		return 0
	end
end

function addLines(parent, from, qty, tblSizeY) -- tblSize таблица задающая определенный размер высоты определенной линии
	local left, top, width, height = parent:getBounds()
	local lines = {}
	local yOffset = 0
	width = width - 10
	
	for i = 1, qty do
		local line = Panel.new()
		line:setBounds(0, (from - 1) * (U.widget_h + U.dist_h) + yOffset, width, (tblSizeY and tblSizeY[i]) or (U.widget_h+U.dist_h))
		yOffset = yOffset + ((tblSizeY and tblSizeY[i]) or (U.widget_h+U.dist_h))
		parent:insertWidget(line)
		lines[i] = line		
	end
	return lines
end

--Action Parameter Handlers

local function getGroupTask(group)
	return group and (group.type == 'plane' or group.type == 'helicopter') and crutches.taskToId(group.task) or 'Default'
end

local function openFileDlgCallback(filename, edit)
		if filename then
            edit:setText(filename)			
            edit:onChange()
		end
	end

ActionParamHandler = {
	open = function(self, data)
		self.data = data
		self:openChilds(data)
		self.panel:setVisible(true)
	end,
	openChilds = function(self, data)
		if self.childs then
			for childIndex, child in base.pairs(self.childs) do
				child:open(data)
			end
		end
	end,
	close = function(self)
		self.data = nil
		self.panel:setVisible(false)
	end,
	onGroupTaskChange = function(self, groupTask)
		if self.childs then
			for childIndex, child in base.pairs(self.childs) do
				child:onGroupTaskChange(groupTask)
			end
		end	
	end,
	onMapUnitSelected = function(self, unit)
		--base.error('What the fuck?!')
	end,	
	onTargetMoved = function(self, x, y)
		--base.error('What the fuck?!')
	end,
}
ActionParamHandler.__index = ActionParamHandler

--Weapon
do
	local cdata = {
		weapon	= _('WEAPON'),
		auto	= _('AUTO'),
		drop	= _('DROP'),
	}

	local weaponTable = actionDB.weaponTable
	
	--This example is taken from "Iterating bits in Lua" article by r · i · c · i
	--http://ricilake.blogspot.com/2007/10/iterating-bits-in-lua.html
	
	local function hasbit(x, p)
	  return x % (p + p) >= p       
	end
	
	local function bitor(x, y)
	  local p = 1; local z = 0; local limit = x > y and x or y
	  while p <= limit do
		if hasbit(x, p) or hasbit(y, p) then
		  z = z + p
		end
		p = p + p
	  end
	  return z
	end	
	
	local function makeWeaponList(...)
		local list = {}
		local all = 0
		for i, v in base.ipairs{...} do
			all = bitor(all, v.value)
			base.table.insert(list, v)
		end
		base.table.insert(list, 1, {name = cdata.auto, value = all, default = true})
		return list
	end
	
	-- https://jira.eagle.ru/browse/ASSETS-1812 
	--[[local markerWeapon = makeWeaponList(weaponTable.smokeRockets,
										weaponTable.candleRockets,
										weaponTable.candleBombs)]]--
	local markerWeapon = makeWeaponList(weaponTable.unguided,
										weaponTable.cannon,
										weaponTable.rockets,
											weaponTable.lightRockets,
											weaponTable.heavyRockets,
											weaponTable.smokeRockets,
											weaponTable.candleRockets,
											weaponTable.candleBombs,
										weaponTable.bombs,
											weaponTable.ironBombs,
											weaponTable.clusterBombs,
											weaponTable.candleBombs,		
										weaponTable.guided,
											weaponTable.guidedBombs,
											weaponTable.missiles,
												weaponTable.ASM,
													weaponTable.ATGM,
													weaponTable.standardASM,
													weaponTable.ARM,
													weaponTable.antiship,
													weaponTable.cruiseMissile,
												weaponTable.AAM,
													weaponTable.SR_AAM,
													weaponTable.MR_AAM,
													weaponTable.LR_AAM)
	
	local preciseWeapon = makeWeaponList(	weaponTable.guidedBombs,
											weaponTable.standardASM,
											weaponTable.ARM,
											weaponTable.antiship,
											weaponTable.cruiseMissile)
											
	local airborneUnitWeapon = {
		['nothing'] = {
			['Default'] = {
				actionDB.weaponItem(cdata.auto, 0)
			}
		},
		['unknown'] = {
			['Default'] = makeWeaponList(
							weaponTable.unguided,
								weaponTable.cannon,
								weaponTable.rockets,
									weaponTable.lightRockets,
									weaponTable.heavyRockets,
								weaponTable.bombs,
									weaponTable.ironBombs,
									weaponTable.clusterBombs,
									weaponTable.candleBombs,
								weaponTable.Torpedoes,		
							weaponTable.guided,
								weaponTable.guidedBombs,
								weaponTable.missiles,
									weaponTable.ASM,
										weaponTable.ATGM,
										weaponTable.standardASM,
										weaponTable.ARM,
										weaponTable.antiship,
										weaponTable.cruiseMissile,
									weaponTable.AAM,
										weaponTable.SR_AAM,
										weaponTable.MR_AAM,
										weaponTable.LR_AAM,
								weaponTable.Decoys),
		},
		['plane'] = {
			['Default'] = makeWeaponList(
							weaponTable.cannon,
								weaponTable.AAM,
									weaponTable.SR_AAM,
									weaponTable.MR_AAM,
									weaponTable.LR_AAM,
								weaponTable.Decoys )
		},
		['helicopter'] = {
			['Default'] = makeWeaponList(
							weaponTable.cannon,
								weaponTable.AAM,
									weaponTable.SR_AAM,
									weaponTable.MR_AAM,
									weaponTable.LR_AAM )
		},
		['vehicle'] = {
			['Default'] = makeWeaponList(
							weaponTable.unguided,
								weaponTable.cannon,
								weaponTable.rockets,
									weaponTable.lightRockets,
									weaponTable.heavyRockets,
								weaponTable.bombs,
									weaponTable.ironBombs,
									weaponTable.clusterBombs,
									weaponTable.candleBombs,
							weaponTable.guided,
								weaponTable.guidedBombs,
								weaponTable.ASM,
									weaponTable.ATGM,
									weaponTable.standardASM,
									weaponTable.ARM,
								weaponTable.Decoys),
			['AFAC'] = markerWeapon,
			['Pinpoint Strike'] = preciseWeapon
		},
		['ship'] = {
			['Default'] = makeWeaponList(
							weaponTable.unguided,
								weaponTable.cannon,
								weaponTable.rockets,
									weaponTable.lightRockets,
									weaponTable.heavyRockets,
								weaponTable.bombs,
									weaponTable.ironBombs,
									weaponTable.clusterBombs,
									weaponTable.candleBombs,
								weaponTable.Torpedoes,		
							weaponTable.guided,
								weaponTable.guidedBombs,
								weaponTable.ASM,
									weaponTable.ATGM,
									weaponTable.standardASM,
									weaponTable.ARM,
									weaponTable.antiship,
								weaponTable.Decoys),
			['AFAC'] = markerWeapon,
			['Pinpoint Strike'] = preciseWeapon
		},
		['static'] = {
			['Default'] = makeWeaponList(
							weaponTable.unguided,
								weaponTable.cannon,
								weaponTable.rockets,
									weaponTable.lightRockets,
									weaponTable.heavyRockets,
								weaponTable.bombs,
									weaponTable.ironBombs,
									weaponTable.clusterBombs,
									weaponTable.candleBombs,
							weaponTable.guided,
								weaponTable.guidedBombs,
								weaponTable.ASM,
									weaponTable.ATGM,
									weaponTable.standardASM,
									weaponTable.cruiseMissile,
								weaponTable.Decoys ),
			['AFAC'] = markerWeapon,
			['Pinpoint Strike'] = preciseWeapon
		},
		['point'] = {
			['Default'] = makeWeaponList(
							weaponTable.unguided,
								weaponTable.cannon,
								weaponTable.rockets,
									weaponTable.lightRockets,
									weaponTable.heavyRockets,
								weaponTable.bombs,
									weaponTable.ironBombs,
									weaponTable.clusterBombs,
									weaponTable.candleBombs,
							weaponTable.guided,
								weaponTable.guidedBombs,
								weaponTable.ASM,
									weaponTable.ATGM,
									weaponTable.standardASM,
									weaponTable.cruiseMissile,
								weaponTable.Decoys),
			['AFAC'] = markerWeapon,
			['Pinpoint Strike'] = preciseWeapon
		},
		['runway'] = {
			['Default'] = makeWeaponList(
							weaponTable.unguided,
									weaponTable.heavyRockets,
								weaponTable.bombs,
									weaponTable.ironBombs,
									weaponTable.clusterBombs,
									weaponTable.candleBombs,
							weaponTable.guided,
								weaponTable.guidedBombs,
								weaponTable.ASM,
									weaponTable.standardASM,
									weaponTable.cruiseMissile),
			['Pinpoint Strike'] = preciseWeapon
		}
	}

	local weapon = {
		['nothing'] = {
			['Default'] = {
				actionDB.weaponItem(cdata.auto, 0)
			}
		},
		['vehicle'] = {
			['nothing'] = {
				['Default'] = {
					actionDB.weaponItem(cdata.auto, 0)
				}
			},
			['vehicle'] = {
				['Default'] = makeWeaponList(	weaponTable.unguided,
													weaponTable.shells,
														weaponTable.conventionalShell,
													weaponTable.markerShell,
														weaponTable.smokeShell,
														weaponTable.candleShell,
													weaponTable.rockets,
												weaponTable.guided,
													weaponTable.missiles,
														weaponTable.ASM,
															weaponTable.ATGM,
															weaponTable.standardASM)
			},
			['ship'] = {
				['Default'] = makeWeaponList(	weaponTable.unguided,
													weaponTable.shells,
														weaponTable.conventionalShell,
													weaponTable.markerShell,
														weaponTable.smokeShell,
														weaponTable.candleShell,
													weaponTable.rockets,
												weaponTable.guided,
													weaponTable.missiles,
														weaponTable.ASM,
															weaponTable.ATGM,
															weaponTable.antiship)
			},
			['point'] = {
				['Default'] = makeWeaponList(	weaponTable.unguided,
													weaponTable.shells,
														weaponTable.conventionalShell,
													weaponTable.markerShell,
														weaponTable.smokeShell,
														weaponTable.candleShell,
													weaponTable.rockets,
												weaponTable.guided,
													weaponTable.missiles,
														weaponTable.ASM,
															weaponTable.ATGM,
															weaponTable.cruiseMissile)
			},
			['static'] = {
				['Default'] = makeWeaponList(
								 ),
			},
		},
		['ship'] = {
			['nothing'] = {
				['Default'] = {
					actionDB.weaponItem(cdata.auto, 0)
				}
			},
			['vehicle'] = {
				['Default'] = makeWeaponList(	weaponTable.unguided,
													weaponTable.shells,
														weaponTable.conventionalShell,
													weaponTable.markerShell,
														weaponTable.smokeShell,
														weaponTable.candleShell,
													weaponTable.rockets,
												weaponTable.guided,
													weaponTable.missiles,
														weaponTable.standardASM)
			},
			['ship'] = {
				['Default'] = makeWeaponList(	weaponTable.unguided,
													weaponTable.shells,
														weaponTable.conventionalShell,
													weaponTable.markerShell,
														weaponTable.smokeShell,
														weaponTable.candleShell,
													weaponTable.rockets,
												weaponTable.Torpedoes,		
												weaponTable.guided,
													weaponTable.missiles,
														weaponTable.ASM,
															weaponTable.antiship)
			},
			['point'] = {
				['Default'] = makeWeaponList(	weaponTable.unguided,
													weaponTable.shells,
														weaponTable.conventionalShell,
													weaponTable.markerShell,
														weaponTable.smokeShell,
														weaponTable.candleShell,
													weaponTable.rockets,
												weaponTable.guided,
													weaponTable.missiles,	
														weaponTable.cruiseMissile)
			},
			['plane'] = {
				['Default'] = {
					actionDB.weaponItem(cdata.auto, 0)
				},
			},
			['helicopter'] = {
				['Default'] = {
					actionDB.weaponItem(cdata.auto, 0)
				},
			},
		},
		['plane'] = airborneUnitWeapon,
		['helicopter'] = airborneUnitWeapon	
	}

	local function getWeaponItems(self)		
		local groupTask = getGroupTask(self.data.group)		
		if self.fac then
			return airborneUnitWeapon[self.targetType]['Default']
		else
			if weapon[self.data.group.type][self.targetType] == nil then
				return airborneUnitWeapon[self.targetType]['Default']
			end
			return weapon[self.data.group.type][self.targetType][groupTask] or weapon[self.data.group.type][self.targetType]['Default']
		end
	end
	
	local function updateWeaponList(self)
		local groupTask = getGroupTask(self.data.group)
		local items = getWeaponItems(self)
		U.fillComboList(self.comboList, items)
		if 	self.data and
			self.data.actionParams then			
			self.data.actionParams.weaponType = self.data.actionParams.weaponType or items[1].value
			if not U.setComboBoxValue(self.comboList, self.data.actionParams.weaponType) then
				self.data.actionParams.weaponType = self.comboList.set[1].value
				self.comboList:setText(self.comboList.set[1].name)
			end
		end
	end
	
	local function getWeaponAuto_(self)
		return getWeaponItems(self)[1].value
	end
	
	WeaponParamBox = {
		open = function(self, data, targetType)
			self.targetType = targetType or 'nothing'
			ActionParamHandler.open(self, data)
			updateWeaponList(self)
			data.actionParams.weaponType = data.actionParams.weaponType or getWeaponAuto_(self)
			U.setComboBoxValue(self.comboList, data.actionParams.weaponType)
		end,
		
		onGroupTaskChange = function(self, groupTask)
			ActionParamHandler.onGroupTaskChange(self)
			updateWeaponList(self)
		end,
		
		setTargetType = function(self, targetType)
			if self.targetType == targetType then
				return
			end
			self.targetType = targetType or 'nothing'
			updateWeaponList(self)
		end,

		create = function(self, parent, line0, fac)	
			
			local left, top, width, height = parent.panel:getBounds()
			local box_w = width
			
			local panel = addPanel(parent.panel, 0, line0, 0, 1)
			local panelLines = addLines(panel, 1, 1)
			parent.panel:insertWidget(panel)
			
			panelLines[1]:insertWidget(createStatic(cdata.weapon))
			
			local comboList = widgetFactory.createComboList(1.7 * U.text_w, 0, 220, U.widget_h)
			panelLines[1]:insertWidget(comboList)
			U.fillComboList(comboList, weapon['nothing']['nothing'])
			
			local instance = {
				parent		= parent,
				comboList	= comboList,
				fac			= fac,
				panel		= panel
			}
			self.__index = self
			base.setmetatable(instance, self)
			
			function comboList:onChange(item)
				instance.data.actionParams.weaponType = item.itemId.value
				if instance.parent.onWeaponChange ~= nil then
					instance.parent:onWeaponChange()
				end
			end
			
			return instance
		end,
		
		getWeaponAuto = function(self)
			return getWeaponAuto_(self)
		end
	}
	base.setmetatable(WeaponParamBox, ActionParamHandler)

	local function updateDropList(self)
		local items = {
				{itemId = "Troops", displayName = _("Troops")},
				{itemId = "Vehicles", displayName = _("Vehicles")},
				{itemId = "Equipment", displayName = _("Equipment")},
			}
		U.fillComboList2(self.comboList, items)
		if self.data and self.data.actionParams then			
			self.data.actionParams.dropType = self.data.actionParams.dropType or items[1].itemId
			if not U.setComboboxValueById(self.comboList, self.data.actionParams.dropType) then
				self.data.actionParams.dropType = self.comboList.set[1].itemId
				U.setComboboxValueById(self.comboList, self.data.actionParams.dropType)
			end
		end
	end
	
	AirboneDropParamBox= {
		open = function(self, data, targetType)
			self.targetType = targetType or 'nothing'
			ActionParamHandler.open(self, data)
			updateDropList(self)
			U.setComboboxValueById(self.comboList, data.actionParams.dropType)
		end,
		
		onGroupTaskChange = function(self, groupTask)
			ActionParamHandler.onGroupTaskChange(self)
			updateDropList(self)
		end,
		
		setTargetType = function(self, targetType)
			if self.targetType == targetType then
				return
			end
			self.targetType = targetType or "Troops"
			updateDropList(self)
		end,

		create = function(self, parent, line0, fac)	
			
			local left, top, width, height = parent.panel:getBounds()
			local box_w = width
			
			local panel = addPanel(parent.panel, 0, line0, 0, 1)
			local panelLines = addLines(panel, 1, 1)
			parent.panel:insertWidget(panel)
			
			panelLines[1]:insertWidget(createStatic(cdata.drop))
			
			local comboList = widgetFactory.createComboList(1.7 * U.text_w, 0, 220, U.widget_h)
			panelLines[1]:insertWidget(comboList)
			--U.fillComboList(comboList, weapon['nothing']['nothing'])
			
			local instance = {
				parent		= parent,
				comboList	= comboList,
				fac			= fac,
				panel		= panel
			}
			self.__index = self
			base.setmetatable(instance, self)
			
			function comboList:onChange(item)
				instance.data.actionParams.dropType = item.itemId
				if instance.parent.onWeaponChange ~= nil then
					instance.parent:onWeaponChange()
				end
			end
			
			return instance
		end,
	}
	base.setmetatable(AirboneDropParamBox, ActionParamHandler)
end

local groupTypeFilters = {	
	['Default'] = {
		['ship'] 		= true,
		['vehicle'] 	= true,
		['static']		= true,
	},
	['SEAD']				= {
		['ship'] 		= true,
		['vehicle'] 	= true,
		['static']		= true,
	},
	['Antiship Strike']	= {
		['ship'] 		= true
	},
	['CAS']				= {
		['vehicle']		= true,
		['static']		= true,
		['helicopter'] 	= true,
	},
	['AFAC']			= {
		['vehicle']		= true,
		['static']		= true,
	},
	['Intercept'] 		= {
		['plane']		= true,
		['helicopter'] 	= true,
	},
	['CAP'] 			= {
		['plane']		= true,
		['helicopter'] 	= true,
	},
	['Fighter Sweep'] 	= {
		['plane']		= true,
		['helicopter'] 	= true,
	},
	['RecoveryTanker']= {
		['ship'] 	= true,
	},
	['Refueling']= {
		['ship'] 	= true,
	},
	['SHIP_HOLD_POINT']= {
		['ship'] 	= true,
	},
}

local groupTypeFiltersShips = {	
	['plane'] 		= true,
	['helicopter'] 	= true,
	['vehicle'] 	= true,
	['static']		= true,
	['ship']		= true,
}

local function compareGroupByName(left, right)
	return left.name < right.name
end


--Group
do
	local function getGroups(self, groundEscort)
		local groups = {}
		local targetCoalition
		local targetCoalition2
		if self.friendly then
			if self.data.group.boss.boss.name == CoalitionController.redCoalitionName() then
				targetCoalition = base.module_mission.mission.coalition.red
			elseif self.data.group.boss.boss.name == CoalitionController.neutralCoalitionName() then
				targetCoalition = base.module_mission.mission.coalition.neutrals
			else
				targetCoalition = base.module_mission.mission.coalition.blue
			end
		else
			if self.data.group.boss.boss.name == CoalitionController.redCoalitionName() then
				targetCoalition = base.module_mission.mission.coalition.blue
				targetCoalition2 = base.module_mission.mission.coalition.neutrals
			elseif self.data.group.boss.boss.name == CoalitionController.neutralCoalitionName() then
				targetCoalition = base.module_mission.mission.coalition.red
				targetCoalition2 = base.module_mission.mission.coalition.blue
			else
				targetCoalition = base.module_mission.mission.coalition.red
				targetCoalition2 = base.module_mission.mission.coalition.neutrals
			end
		end
		for k,v in base.pairs({targetCoalition, targetCoalition2}) do
			for countryIndex, country in base.pairs(v.country) do
				for groupItemIndex, groupItem in base.pairs(country) do
					if 	base.type(groupItem) == 'table' and
						base.type(groupItem.group) == 'table' then							
						for groupIndex, group in base.pairs(groupItem.group) do
							if groundEscort == true then
								if 	group ~= self.data.group and
									(
										(not self.friendly and self.groupTypeFilter ~= nil and self.groupTypeFilter[group.type]) or
										(self.friendly and group.type == self.data.group.type and not self.groundEscort) or
										(self.friendly and group.type ~= self.data.group.type and self.groundEscort) 
									)  and
									group.type == 'vehicle' then
									base.table.insert(groups, group)
								end
							else
								if 	group ~= self.data.group and
									(
										(not self.friendly and self.groupTypeFilter ~= nil and self.groupTypeFilter[group.type]) or
										(self.friendly and group.type == self.data.group.type and not self.groundEscort) or
										(self.friendly and group.type ~= self.data.group.type and self.groundEscort) or
										(self.friendly and self.data.group.type == 'helicopter' and (group.type == 'vehicle' or group.type == 'ship'))
									)  and
									group.type ~= 'static' then
									base.table.insert(groups, group)
								end
							end
						end
					end
				end
			end
		end	
		base.table.sort(groups, compareGroupByName)
		return groups
	end
	
	local function getGroupsRecoveryTanker(self)
		local groups = {}
		local targetCoalition
		local targetCoalition2
		if self.friendly then
			if self.data.group.boss.boss.name == CoalitionController.redCoalitionName() then
				targetCoalition = base.module_mission.mission.coalition.red
			elseif self.data.group.boss.boss.name == CoalitionController.neutralCoalitionName() then
				targetCoalition = base.module_mission.mission.coalition.neutrals
			else
				targetCoalition = base.module_mission.mission.coalition.blue
			end
		else
			if self.data.group.boss.boss.name == CoalitionController.redCoalitionName() then
				targetCoalition = base.module_mission.mission.coalition.blue
				targetCoalition2 = base.module_mission.mission.coalition.neutrals
			elseif self.data.group.boss.boss.name == CoalitionController.neutralCoalitionName() then
				targetCoalition = base.module_mission.mission.coalition.red
				targetCoalition2 = base.module_mission.mission.coalition.blue
			else
				targetCoalition = base.module_mission.mission.coalition.red
				targetCoalition2 = base.module_mission.mission.coalition.neutrals
			end
		end
		for k,v in base.pairs({targetCoalition, targetCoalition2}) do			
			for countryIndex, country in base.pairs(v.country) do				
				for groupItemIndex, groupItem in base.pairs(country) do
					if 	base.type(groupItem) == 'table' and
						base.type(groupItem.group) == 'table' then							
						for groupIndex, group in base.pairs(groupItem.group) do							
							if 	group ~= self.data.group and
								(
									(self.friendly and self.groupTypeFilter ~= nil and self.groupTypeFilter[group.type] )
								)  and
								group.type ~= 'static' then
								base.table.insert(groups, group)
							end
						end
					end
				end
			end
		end	
		base.table.sort(groups, compareGroupByName)
		return groups
	end
	
	local function getNearestGroupRecoveryTanker(self, x, y)
		local groups = getGroupsRecoveryTanker(self)
		local nearestGroup = nil
		local minDist2 = nil
		for groupIndex, group in base.pairs(groups) do
			local dist2 = base.math.pow(group.units[1].x - x, 2) + base.math.pow(group.units[1].y - y, 2)
			if nearestGroup == nil or dist2 < minDist2 then
				nearestGroup = group
				minDist2 = dist2
			end
		end
		return nearestGroup
	end
	
	
	local function isValidGroup(self, a_group)
		local groups = getGroups(self, self.groundEscort)

		for k,v in base.pairs(groups) do
			if v.groupId == a_group.groupId then
				return true
			end
		end
		return false
	end
	
	local function isValidGroupRecoveryTanker(self, a_group)
		local groups = getGroupsRecoveryTanker(self)

		for k,v in base.pairs(groups) do
			if v.groupId == a_group.groupId then
				return true
			end
		end
		return false
	end
	
	local function getNearestGroup(self, x, y)
		local groups = getGroups(self, self.groundEscort)
		local nearestGroup = nil
		local minDist2 = nil
		for groupIndex, group in base.pairs(groups) do
			local dist2 = base.math.pow(group.units[1].x - x, 2) + base.math.pow(group.units[1].y - y, 2)
			if nearestGroup == nil or dist2 < minDist2 then
				nearestGroup = group
				minDist2 = dist2
			end
		end
		return nearestGroup
	end

	local cdata = {
		target	= _('TARGET'),
		group 	= _('GROUP'),
		nothing	= _('NOTHING')
	}

	local function setGroup(self, group)
		if group then
			self.data.actionParams.groupId = group.groupId
			
			if base.MapWindow.isShowHidden(self.data.group) == true then
				actionMapObjects.targetMark.set(self.data.mapObjects,
												actionMapObjects.targetMark.groupById:new(group.groupId),
												self.data.group, self.data.wpt, self.data.task)
			end								 
		else
			self.data.actionParams.groupId = nil
			actionMapObjects.targetMark.set(self.data.mapObjects, nil)
		end
		return group ~= nil
	end	

	local function setGroupFull(self, group)
		setGroup(self, group)
		if group then
			self.groupComboList:setText(group.name)
			return true
		else
			self.groupComboList:setText(cdata.nothing)
			return false
		end
	end   
	
	local function onGroupComboListChange(self, item)
		if item ~= nil then
			local group = base.module_mission.group_by_id[item.itemId.value]
			setGroup(self, group)
			self.parent:onChangeGroup(group)
		end
	end
		
	AttackGroupParamHandler = {
		open = function(self, data)
			base.assert(data.mapObjects ~= nil)
			ActionParamHandler.open(self, data)
			local groupTask = getGroupTask(self.data.group)
			if self.data.group.type ==  'ship' then
				self.groupTypeFilter = groupTypeFiltersShips
			else
				self.groupTypeFilter = groupTypeFilters[groupTask]
			end
			
			self.groupComboList:clear()
			if self.data.group ~= nil then			
				local voidItem = ListBoxItem.new(cdata.nothing)
				voidItem.itemId = { name = cdata.nothing, value = nil }
				self.groupComboList:insertItem(voidItem)
				local groups = getGroups(self, self.groundEscort)
				for groupIndex, group in base.pairs(groups) do
					local newItem = ListBoxItem.new(group.name)
					newItem.itemId = { name = group.name, value = group.groupId }
					self.groupComboList:insertItem(newItem)
				end				
				
				local group = nil
				if self.data.actionParams.groupId then
					group = base.module_mission.group_by_id[self.data.actionParams.groupId]
				end				
				setGroupFull(self, group)
				if group ~= nil and (base.MapWindow.isShowHidden(self.data.group) == true) then
					base.panel_targeting.selectTarget(data.mapObjects.mark)	
					base.panel_targeting.vdata.target = self.data.mapObjects.mark					
				end			
			end
		end,
		
		onGroupTaskChange = function(self)
			local groupTask = getGroupTask(self.data.group)
			self.groupTypeFilter = groupTypeFilters[groupTask]
		end,
		
		onMapUnitSelected = function(self, unit, noStatic)			
			local group = unit and unit.boss
			if isValidGroup(self, group) == false then
				return
			end
			if group and
				(
					(	not self.friendly and			
						group.boss.boss.name ~= self.data.group.boss.boss.name and 
						self.groupTypeFilter ~= nil and self.groupTypeFilter[group.type] 
						and (noStatic ~= true or group.type ~= 'static' ))
					or					
					(	self.friendly and
						group.boss.boss.name == self.data.group.boss.boss.name and
						group.type == self.data.group.type and
						group ~= self.data.group )
					or 
					(
						self.groundEscort == true and
						self.friendly
					)					
				) then
				setGroupFull(self, group)
				
				if base.MapWindow.isShowHidden(self.data.group) == true then
					base.panel_targeting.selectTarget(self.data.mapObjects.mark)
					base.panel_targeting.vdata.target = self.data.mapObjects.mark
				end
			else
				setGroupFull(self, nil)
				group = nil
			end
			self.parent:onChangeGroup(group)
			return true
		end,
		
		onTargetMoved = function(self, x, y)
			local nearestGroup = getNearestGroup(self, x, y)
			if nearestGroup then
				setGroupFull(self, nearestGroup)
			else
				setGroupFull(self, nil)
			end
			self.parent:onChangeGroup(group)
		end,
		
		create = function(self, parent, line0, friendly, groundEscort)
			local left, top, width, height = parent.panel:getBounds()
			local box_w = width
		
			local panel = addPanel(parent.panel, 0, line0, 0, 1)
			local panelLines = addLines(panel, 1, 1)
			parent.panel:insertWidget(panel)
				
			panelLines[1]:insertWidget(createStatic(cdata.group))
			
			local groupComboList = widgetFactory.createComboList(1.7 * U.text_w, 0, 220, U.widget_h)
			panelLines[1]:insertWidget(groupComboList)
			
			local instance = {
				parent			= parent,
				groupComboList	= groupComboList,
				panel			= panel,
				friendly		= friendly,
				groundEscort	= groundEscort
			}
			self.__index = self
			base.setmetatable(instance, self)
			
			groupComboList.onChange = function(comboList, item)
				onGroupComboListChange(instance, item)
			end
			
			return instance
		
		end,
	}
	base.setmetatable(AttackGroupParamHandler, ActionParamHandler)
	
	recoveryTankerGroupParamHandler = {
		open = function(self, data)
			base.assert(data.mapObjects ~= nil)
			ActionParamHandler.open(self, data)
			local groupTask = getGroupTask(self.data.group)			
			if self.data.group.type ==  'ship' then
				self.groupTypeFilter = groupTypeFiltersShips
			else
				self.groupTypeFilter = groupTypeFilters[groupTask]				
			end
			
			self.groupComboList:clear()
			if self.data.group ~= nil then			
				local voidItem = ListBoxItem.new(cdata.nothing)
				voidItem.itemId = { name = cdata.nothing, value = nil }
				self.groupComboList:insertItem(voidItem)
				local groups = getGroupsRecoveryTanker(self)
				for groupIndex, group in base.pairs(groups) do
					local newItem = ListBoxItem.new(group.name)
					newItem.itemId = { name = group.name, value = group.groupId }
					self.groupComboList:insertItem(newItem)
				end				
				
				local group = nil
				if self.data.actionParams.groupId then
					group = base.module_mission.group_by_id[self.data.actionParams.groupId]
				end				
				setGroupFull(self, group)
				if group ~= nil and (base.MapWindow.isShowHidden(self.data.group) == true) then
					base.panel_targeting.selectTarget(data.mapObjects.mark)	
					base.panel_targeting.vdata.target = self.data.mapObjects.mark					
				end			
			end
		end,
		
		onGroupTaskChange = function(self)
			local groupTask = getGroupTask(self.data.group)
			self.groupTypeFilter = groupTypeFilters[groupTask]
		end,
		
		onMapUnitSelected = function(self, unit, noStatic)			
			local group = unit and unit.boss
			if isValidGroupRecoveryTanker(self, group) == false then
				return
			end

			if group then
				setGroupFull(self, group)
				
				if base.MapWindow.isShowHidden(self.data.group) == true then
					base.panel_targeting.selectTarget(self.data.mapObjects.mark)
					base.panel_targeting.vdata.target = self.data.mapObjects.mark
				end
			else
				setGroupFull(self, nil)
				group = nil
			end
			self.parent:onChangeGroup(group)
			return true
		end,
		
		onTargetMoved = function(self, x, y)
			local nearestGroup = getNearestGroupRecoveryTanker(self, x, y)
			if nearestGroup then
				setGroupFull(self, nearestGroup)
			else
				setGroupFull(self, nil)
			end
			self.parent:onChangeGroup(group)
		end,
		
		create = function(self, parent, line0, friendly)
			local left, top, width, height = parent.panel:getBounds()
			local box_w = width

			local panel = addPanel(parent.panel, 0, line0, 0, 1)
			local panelLines = addLines(panel, 1, 1)
			parent.panel:insertWidget(panel)				
			panelLines[1]:insertWidget(createStatic(cdata.group))
			
			local groupComboList = widgetFactory.createComboList(1.7 * U.text_w, 0, 220, U.widget_h)
			panelLines[1]:insertWidget(groupComboList)
			
			local instance = {
				parent			= parent,
				groupComboList	= groupComboList,
				panel			= panel,
				friendly		= friendly,
			}
			self.__index = self
			base.setmetatable(instance, self)
			
			groupComboList.onChange = function(comboList, item)
				onGroupComboListChange(instance, item)
			end
			
			return instance
		
		end,
	}
	base.setmetatable(recoveryTankerGroupParamHandler, ActionParamHandler)
	
	
	EscortGroupParamHandler = {
		open = function(self, data)
			base.assert(data.mapObjects ~= nil)
			ActionParamHandler.open(self, data)
			local groupTask = getGroupTask(self.data.group)
			self.groupTypeFilter = groupTypeFilters[groupTask]
			self.groupComboList:clear()
			if self.data.group ~= nil then			
				local voidItem = ListBoxItem.new(cdata.nothing)
				voidItem.itemId = { name = cdata.nothing, value = nil }
				self.groupComboList:insertItem(voidItem)			
				local groups = getGroundEscortGroups(self)
				for groupIndex, group in base.pairs(groups) do
					local newItem = ListBoxItem.new(group.name)
					newItem.itemId = { name = group.name, value = group.groupId }
					self.groupComboList:insertItem(newItem)
				end				
				
				local group = nil
				if self.data.actionParams.groupId then
					group = base.module_mission.group_by_id[self.data.actionParams.groupId]
				end				
				setGroupFull(self, group)
				if group ~= nil and (base.MapWindow.isShowHidden(self.data.group) == true) then
					base.panel_targeting.selectTarget(data.mapObjects.mark)	
					base.panel_targeting.vdata.target = self.data.mapObjects.mark					
				end
				
			end
		end,
		
		onGroupTaskChange = function(self)
			local groupTask = getGroupTask(self.data.group)
			self.groupTypeFilter = groupTypeFilters[groupTask]
		end,
		
		onMapUnitSelected = function(self, unit)
			local group = unit and unit.boss
			if group and
				(
					(	not self.friendly and			
						group.boss.boss.name ~= self.data.group.boss.boss.name and 
						self.groupTypeFilter ~= nil and self.groupTypeFilter[group.type] )  or
					
					(	self.friendly and
						--group.boss.boss.name == self.data.group.boss.boss.name and
						--group.type == self.data.group.type and
						group ~= self.data.group )
				) then
				setGroupFull(self, group)
				if base.MapWindow.isShowHidden(self.data.group) == true then
					base.panel_targeting.selectTarget(self.data.mapObjects.mark)
					base.panel_targeting.vdata.target = self.data.mapObjects.mark
				end
			else
				setGroupFull(self, nil)
			end
			self.parent:onChangeGroup(group)
			return true
		end,
		
		onTargetMoved = function(self, x, y)
			local nearestGroup = getNearestGroup(self, x, y)
			if nearestGroup then
				setGroupFull(self, nearestGroup)
			else
				setGroupFull(self, nil)
			end
			self.parent:onChangeGroup(group)
		end,
		
		create = function(self, parent, line0, friendly)
			local left, top, width, height = parent.panel:getBounds()
			local box_w = width
		
			local panel = addPanel(parent.panel, 0, line0, 0, 1)
			local panelLines = addLines(panel, 1, 1)
			parent.panel:insertWidget(panel)
				
			panelLines[1]:insertWidget(createStatic(cdata.group))
			
			local groupComboList = widgetFactory.createComboList(1.7 * U.text_w, 0, 220, U.widget_h)
			panelLines[1]:insertWidget(groupComboList)
			
			local instance = {
				parent			= parent,
				groupComboList	= groupComboList,
				panel			= panel,
				friendly		= friendly
			}
			self.__index = self
			base.setmetatable(instance, self)
			
			groupComboList.onChange = function(comboList, item)
				onGroupComboListChange(instance, item)
			end
			
			return instance
		
		end,
	}
	base.setmetatable(EscortGroupParamHandler, ActionParamHandler)

end


--Cargo
do

	local function getCargos(self)
		local groups = {}
		local targetCoalition

		if self.data.group.boss.boss.name == CoalitionController.redCoalitionName() then
			targetCoalition = base.module_mission.mission.coalition.red
		elseif self.data.group.boss.boss.name == CoalitionController.neutralCoalitionName() then
			targetCoalition = base.module_mission.mission.coalition.neutrals
		else
			targetCoalition = base.module_mission.mission.coalition.blue
		end

		
		for countryIndex, country in base.pairs(targetCoalition.country) do
			for groupItemIndex, groupItem in base.pairs(country) do
				if 	base.type(groupItem) == 'table' and
					base.type(groupItem.group) == 'table' then
					for staticIndex, static in base.pairs(groupItem.group) do
						if static.type == 'static' and static.units[1].canCargo == true then
							base.table.insert(groups, static)
						end
					end						
				end
			end
		end
		base.table.sort(groups, compareGroupByName)
		return groups
	end	
	
	local function getNearestGroup(self, x, y)
		local groups = getCargos(self)
		local nearestGroup = nil
		local minDist2 = nil
		for groupIndex, group in base.pairs(groups) do
			local dist2 = base.math.pow(group.units[1].x - x, 2) + base.math.pow(group.units[1].y - y, 2)
			if nearestGroup == nil or dist2 < minDist2 then
				nearestGroup = group
				minDist2 = dist2
			end
		end
		return nearestGroup
	end

	local cdata = {
		target	= _('TARGET'),
		group 	= _('GROUP'),
		nothing	= _('NOTHING')
	}

    local function setGroup(self, group)
		if group then
			self.data.actionParams.groupId = group.groupId
            self.data.actionParams.unitId = group.units[1].unitId
			actionMapObjects.targetMark.set(self.data.mapObjects,
											actionMapObjects.targetMark.groupById:new(group.groupId),
											self.data.group, self.data.wpt, self.data.task)
		else
			self.data.actionParams.groupId = nil
            self.data.actionParams.unitId = nil
			actionMapObjects.targetMark.set(self.data.mapObjects, nil)
		end
		return group ~= nil
	end	
    
    local function setGroupFull(self, group)
		setGroup(self, group)
		if group then
			self.groupComboList:setText(group.name)
			return true
		else
			self.groupComboList:setText(cdata.nothing)
			return false
		end
	end
	
	local function onGroupComboListChange(self, item)
		if item ~= nil then
			local group = base.module_mission.group_by_id[item.itemId.value]
			setGroup(self, group)
			self.parent:onChangeGroup(group)
		end
	end
		
	CargoDeliveryParamHandler = {
		open = function(self, data)
			base.assert(data.mapObjects ~= nil)
			ActionParamHandler.open(self, data)
			local groupTask = getGroupTask(self.data.group)
			self.groupTypeFilter = groupTypeFilters[groupTask]
			self.groupComboList:clear()
			if self.data.group ~= nil then			
				local voidItem = ListBoxItem.new(cdata.nothing)
				voidItem.itemId = { name = cdata.nothing, value = nil }
				self.groupComboList:insertItem(voidItem)			
				local groups = getCargos(self)
				for groupIndex, group in base.pairs(groups) do
					local newItem = ListBoxItem.new(group.name)
					newItem.itemId = { name = group.name, value = group.groupId }
					self.groupComboList:insertItem(newItem)
				end				
				
				local group = nil
				if self.data.actionParams.groupId then
					group = base.module_mission.group_by_id[self.data.actionParams.groupId]
				end				
				setGroupFull(self, group)
				if group ~= nil and (base.MapWindow.isShowHidden(self.data.group) == true) then
					base.panel_targeting.selectTarget(data.mapObjects.mark)
					base.panel_targeting.vdata.target = self.data.mapObjects.mark
				end
			end
		end,
		
		onGroupTaskChange = function(self)
			local groupTask = getGroupTask(self.data.group)
			self.groupTypeFilter = groupTypeFilters[groupTask]
		end,
		
		onMapUnitSelected = function(self, unit)
			local group = unit and unit.boss
            if 	group and
                group.boss.boss.name == self.data.group.boss.boss.name and
                group.type == 'static' and group.units[1].canCargo == true and
                group ~= self.data.group then
                setGroupFull(self, group)
				if base.MapWindow.isShowHidden(self.data.group) == true then
					base.panel_targeting.selectTarget(self.data.mapObjects.mark)
					base.panel_targeting.vdata.target = self.data.mapObjects.mark  
				end	
            else
                setGroupFull(self, nil)
            end
            self.parent:onChangeGroup(group)
            return true
		end,
		
		onTargetMoved = function(self, x, y)
			local nearestGroup = getNearestGroup(self, x, y)
			if nearestGroup then
				setGroupFull(self, nearestGroup)
			else
				setGroupFull(self, nil)
			end
			self.parent:onChangeGroup(group)
		end,

		create = function(self, parent, line0)
		
			local left, top, width, height = parent.panel:getBounds()
			local box_w = width
		
			local panel = addPanel(parent.panel, 0, line0, 0, 1)
			local panelLines = addLines(panel, 1, 1)
			parent.panel:insertWidget(panel)
				
			panelLines[1]:insertWidget(createStatic(cdata.group))
			
			local groupComboList = widgetFactory.createComboList(1.7 * U.text_w, 0, 220, U.widget_h)
			panelLines[1]:insertWidget(groupComboList)
			
			local instance = {
				parent			= parent,
				groupComboList	= groupComboList,
				panel			= panel,
			}
			self.__index = self
			base.setmetatable(instance, self)
			
			groupComboList.onChange = function(comboList, item)
				onGroupComboListChange(instance, item)
			end
			
			return instance
		
		end,
	}
	base.setmetatable(CargoDeliveryParamHandler, ActionParamHandler)
	
	CargoUnloadPlaneParamHandler = {
		open = function(self, data)
			base.assert(data.mapObjects ~= nil)
			ActionParamHandler.open(self, data)
			local groupTask = getGroupTask(self.data.group)
			self.groupTypeFilter = groupTypeFilters[groupTask]
			self.groupComboList:clear()
			if self.data.group ~= nil then			
				local voidItem = ListBoxItem.new(cdata.nothing)
				voidItem.itemId = { name = cdata.nothing, value = nil }
				self.groupComboList:insertItem(voidItem)			
				
				local selectedItem = voidItem

				for kk, wpt in base.ipairs(data.group.route.points) do
					if data.wpt and kk > data.wpt.index then
						break
					end
										
					for kkk, wptTask in base.ipairs(wpt.task.params.tasks) do
						if wptTask.id == "CargoTransportationPlane" 
							and wptTask.params and wptTask.params.groupId then
							local groupTmp = base.module_mission.group_by_id[wptTask.params.groupId]
							local newItem = ListBoxItem.new(groupTmp.name)
							newItem.itemId = { name = groupTmp.name, value = groupTmp.groupId }
							self.groupComboList:insertItem(newItem)	
							
							if groupTmp.groupId  == self.data.actionParams.groupId then
								selectedItem = newItem
							end
						end					
					end						
				end	
				
				if selectedItem then
					self.groupComboList:selectItem(selectedItem)
				end
								
				local group = nil
				if self.data.actionParams.groupId then
					group = base.module_mission.group_by_id[self.data.actionParams.groupId]
				end				
				--setGroupFull(self, group)
			end
		end,
		
		onGroupTaskChange = function(self)
			local groupTask = getGroupTask(self.data.group)
			self.groupTypeFilter = groupTypeFilters[groupTask]
		end,
		
		create = function(self, parent, line0)
		
			local left, top, width, height = parent.panel:getBounds()
			local box_w = width
		
			local panel = addPanel(parent.panel, 0, line0, 0, 1)
			local panelLines = addLines(panel, 1, 1)
			parent.panel:insertWidget(panel)
				
			panelLines[1]:insertWidget(createStatic(cdata.group))
			
			local groupComboList = widgetFactory.createComboList(1.7 * U.text_w, 0, 220, U.widget_h)
			panelLines[1]:insertWidget(groupComboList)
			
			local instance = {
				parent			= parent,
				groupComboList	= groupComboList,
				panel			= panel,
			}
			self.__index = self
			base.setmetatable(instance, self)
			
			groupComboList.onChange = function(comboList, item)
				onGroupComboListChange(instance, item)
			end
			
			return instance
		
		end,
	}
	base.setmetatable(CargoUnloadPlaneParamHandler, ActionParamHandler)
end


--Zones
do
	local function getZones(self)
		local zones = {}
	
		for i, triggerZoneId in base.pairs(TriggerZoneController.getTriggerZoneIds()) do
			base.table.insert(zones, { 
				id		= triggerZoneId, 
				name	= TriggerZoneController.getTriggerZoneName(triggerZoneId),
				})
		end
	
		base.table.sort(zones, U.namedTableComparator)
	
		return zones
	end	
	
	local function zoneIdToTableZoneIdName(self, zoneId)
		local zone = {}
		
		base.table.insert(zone, { 
			id		= zoneId, 
			name	= TriggerZoneController.getTriggerZoneName(zoneId),
			})
		return zone
	end
	
	
	local cdata = {
		target	= _('TARGET'),
		zone 	= _('ZONE'),
		nothing	= _('NOTHING')
	}

	local function setZone(self, zoneId)
		if zoneId then
			self.data.actionParams.zoneId = zoneId
			--actionMapObjects.targetMark.set(self.data.mapObjects,
			--								actionMapObjects.targetMark.groupById:new(group.groupId),
			--								self.data.group, self.data.wpt, self.data.task)
		else
			self.data.actionParams.zoneId = nil
			--actionMapObjects.targetMark.set(self.data.mapObjects, nil)
		end
		return zoneId ~= nil
	end	
	
	local function setZoneFull(self, zoneId)
		setZone(self, zoneId)
		if zoneId then
			self.zoneComboList:setText(TriggerZoneController.getTriggerZoneName(zoneId))
			return true
		else
			self.zoneComboList:setText(cdata.nothing)
			return false
		end
	end
	
	local function onZoneComboListChange(self, item)
		if item ~= nil then
			setZone(self, item.itemId.value)
			self.parent:onChangeZone(item.itemId.value)
		end
	end

		
	CargoZonesParamHandler = {
		open = function(self, data)
			base.assert(data.mapObjects ~= nil)
			ActionParamHandler.open(self, data)
			self.zoneComboList:clear()
			
			local voidItem = ListBoxItem.new(cdata.nothing)
			voidItem.itemId = { name = cdata.nothing, value = nil }
			self.zoneComboList:insertItem(voidItem)
			
			local zones = getZones(self)
			for zoneIndex, zone in base.pairs(zones) do
				local newItem = ListBoxItem.new(zone.name)
				newItem.itemId = { name = zone.name, value = zone.id }
				self.zoneComboList:insertItem(newItem)
			end				
						
			setZoneFull(self, self.data.actionParams.zoneId)
			if self.data.actionParams.zoneId ~= nil and (base.MapWindow.isShowHidden(self.data.group) == true) then
				base.panel_targeting.selectTarget(data.mapObjects.mark)
				base.panel_targeting.vdata.target = self.data.mapObjects.mark
			end
		end,
		
		create = function(self, parent, line0)
		
			local left, top, width, height = parent.panel:getBounds()
			local box_w = width
		
			local panel = addPanel(parent.panel, 0, line0, 0, 1)
			local panelLines = addLines(panel, 1, 1)
			parent.panel:insertWidget(panel)
				
			panelLines[1]:insertWidget(createStatic(cdata.zone))
			
			local zoneComboList = widgetFactory.createComboList(1.7 * U.text_w, 0, 220, U.widget_h)
			panelLines[1]:insertWidget(zoneComboList)
			
			local instance = {
				parent			= parent,
				zoneComboList	= zoneComboList,
				panel			= panel,
			}
			self.__index = self
			base.setmetatable(instance, self)
			
			zoneComboList.onChange = function(comboList, item)
				onZoneComboListChange(instance, item)
			end
			
			return instance
		
		end,
	}
	base.setmetatable(CargoZonesParamHandler, ActionParamHandler)
end


--Unit
do
	
	local cdata = {
		target	= _('TARGET'),
		group	= _('GROUP'),
		unit	= _('UNIT'),
		static	= _('STATIC'),
		nothing	= _('NOTHING'),
	}
    
    if ProductType.getType() == "LOFAC" then
        cdata.unit   = _("UNIT-LOFAC")
    end
	
	local function compareUnitByName(left, right)
		return left.name < right.name
	end	
		
	--private
	--build unit list of group and fill combo box with it
	local function buildGroupUnits(self, group)
		self.unitComboList:clear()
		local voidItem = ListBoxItem.new(cdata.nothing)
		voidItem.itemId = { name = cdata.nothing, value = nil }
		self.unitComboList:insertItem(voidItem)			
		if group then
			local units = {}
			for unitIndex, unit in base.pairs(group.units) do			
				base.table.insert(units, unit)
			end
			base.table.sort(units, compareUnitByName)					
			for unitIndex, unit in base.pairs(units) do
				local newUnitItem = ListBoxItem.new(unit.name)
				newUnitItem.itemId = { name = unit.name, value = unit.unitId }
				self.unitComboList:insertItem(newUnitItem)
			end
		end
	end
	--set unit to action params and notify parent handler
	local function setUnit(self, unit)
		if unit then			
			self.data.actionParams.unitId = unit.unitId
			actionMapObjects.targetMark.set(self.data.mapObjects,
											actionMapObjects.targetMark.unitById:new(unit.unitId),
											self.data.group, self.data.wpt, self.data.task)
		else
			self.data.actionParams.unitId = nil
			actionMapObjects.targetMark.set(self.data.mapObjects, nil)
		end
		return unit ~= nil
	end
	--set unit to combo boxes
	local function setUnitToComboList(self, unit)
		if unit then
			local group = unit.boss
			self.groupComboList:setText(group.name)
			buildGroupUnits(self, unit.boss)
			self.unitComboList:setText(unit.name)				
		else
			self.groupComboList:setText(cdata.nothing)
			buildGroupUnits(self, nil)
			self.unitComboList:setText(cdata.nothing)	
		end
	end
	--set static to combo box
	local function setStaticToComboList(self, static)
		if static then
			self.staticComboList:setText(static.name)
		else
			self.staticComboList:setText(cdata.nothing)
		end
	end
	--set unit
	local function setUnitFull(self, unit)
		setUnit(self, unit)
		if unit then
			local group = unit.boss
			if 	group == nil or
				group.type == 'static' then
				setUnitToComboList(self, nil)
				setStaticToComboList(self, unit)					
			else
				setUnitToComboList(self, unit)
				setStaticToComboList(self, nil)					
			end			
			return true
		else	
			setUnitToComboList(self, nil)
			setStaticToComboList(self, nil)				
			return false
		end
	end

	--public
	AttackUnitParamBox = {
		open = function(self, data)
			ActionParamHandler.open(self, data)
			local groupTask = getGroupTask(self.data.group)
			self.groupTypeFilter = groupTypeFilters[groupTask]			
			if self.data.group then				
				local enemyCoalition
				local enemyCoalition2
				if self.data.group.boss.boss.name == CoalitionController.redCoalitionName() then
					enemyCoalition = base.module_mission.mission.coalition.blue
					enemyCoalition2 = base.module_mission.mission.coalition.neutrals
				elseif self.data.group.boss.boss.name == CoalitionController.neutralCoalitionName() then
					enemyCoalition = base.module_mission.mission.coalition.blue
					enemyCoalition2 = base.module_mission.mission.coalition.red
				else
					enemyCoalition = base.module_mission.mission.coalition.red
					enemyCoalition2 = base.module_mission.mission.coalition.neutrals
				end
				--groups
				self.groupComboList:clear()
				do
					local groups = {}
					local groupVoidItem = ListBoxItem.new(cdata.nothing)
					groupVoidItem.itemId = { name = cdata.nothing, value = nil }
					self.groupComboList:insertItem(groupVoidItem)
					for k,v in base.pairs({enemyCoalition, enemyCoalition2}) do
						for countryIndex, country in base.pairs(v.country) do
							for groupItemIndex, groupItem in base.pairs(country) do
								if 	base.type(groupItem) == 'table' and
									base.type(groupItem.group) == 'table' then							
									for groupIndex, group in base.pairs(groupItem.group) do									
										if 	self.groupTypeFilter and
											self.groupTypeFilter[group.type] and
											group.type ~= 'static' then
											if group.type ~= 'static' then
												base.table.insert(groups, group)
											end
										end
									end
								end
							end
						end	
					end	
					base.table.sort(groups, compareUnitByName)					
					for groupIndex, group in base.pairs(groups) do
						local newGroupItem = ListBoxItem.new(group.name)
						newGroupItem.itemId = { name = group.name, value = group.groupId }
						self.groupComboList:insertItem(newGroupItem)
					end					
				end				
				
				--statics
				self.staticComboList:clear()
				do
					local statics = {}				
					local staticVoidItem = ListBoxItem.new(cdata.nothing)
					staticVoidItem.itemId = { name = cdata.nothing, value = nil }
					self.staticComboList:insertItem(staticVoidItem)
					if self.groupTypeFilter and self.groupTypeFilter['static'] then
						for k,v in base.pairs({enemyCoalition, enemyCoalition2}) do
							for countryIndex, country in base.pairs(v.country) do
								for groupItemIndex, groupItem in base.pairs(country) do
									if 	base.type(groupItem) == 'table' and
										base.type(groupItem.group) == 'table' then							
										for groupIndex, group in base.pairs(groupItem.group) do
											if group.type == 'static' then
												for staticIndex, static in base.pairs(group.units) do
													base.table.insert(statics, static)
												end											
											end
										end
									end
								end
							end
						end
					end					
				
					base.table.sort(statics, compareUnitByName)					
					for staticIndex, static in base.pairs(statics) do
						local newStaticItem = ListBoxItem.new(static.name)
						newStaticItem.itemId = { name = static.name, value = static.unitId }
						self.staticComboList:insertItem(newStaticItem)
					end				
				end
				local unit = self.data.actionParams.unitId and base.module_mission.unit_by_id[self.data.actionParams.unitId]
				setUnitFull(self, unit)
			end			
		end,
		onGroupTaskChange = function(self)
			local groupTask = getGroupTask(self.data.group)
			self.groupTypeFilter = groupTypeFilters[groupTask]
		end,
		onMapUnitSelected = function(self, unit)
			if 	unit and
				unit.boss and
				unit.boss.boss.boss.name ~= self.data.group.boss.boss.name and 
				self.groupTypeFilter ~= nil and self.groupTypeFilter[unit.boss.type] then
				setUnitFull(self, unit)
			else
				setUnitFull(self, nil)
			end
			self.parent:onChangeUnit(unit)
			return true
		end,
		create = function(self, parent, line0)
			local left, top, width, height = parent.panel:getBounds()
			local box_w = width
			
			local panel = addPanel(parent.panel, 0, line0, 0, 3)
			local panelLines = addLines(panel, 1, 3)
			parent.panel:insertWidget(panel)
			
			panelLines[1]:insertWidget(createStatic(cdata.group))
			
			local groupComboList = widgetFactory.createComboList(1.7 * U.text_w, 0, 220, U.widget_h)
			panelLines[1]:insertWidget(groupComboList)
			
			panelLines[2]:insertWidget(createStatic(cdata.unit))
			
			panelLines[2]:insertWidget(createStatic(cdata.or_, U.text_w, 0, U.text_w, U.widget_h))						
			
			local unitComboList = widgetFactory.createComboList(1.7 * U.text_w, 0, 220, U.widget_h)
			panelLines[2]:insertWidget(unitComboList)
			
			panelLines[3]:insertWidget(createStatic(cdata.static))		
			
			local staticComboList = widgetFactory.createComboList(1.7 * U.text_w, 0, 220, U.widget_h)
			panelLines[3]:insertWidget(staticComboList)
			
			local instance = {
				parent			= parent,
				groupComboList	= groupComboList,
				unitComboList	= unitComboList,
				staticComboList	= staticComboList,
				panel			= panel
			}
			self.__index = self
			base.setmetatable(instance, self)
			
			function groupComboList:onChange(item)
				local group = base.module_mission.group_by_id[item.itemId.value]
				buildGroupUnits(instance, group)
				local firstUnitInGroup = nil
				if group then
					firstUnitInGroup = group.units[1]
					base.assert(firstUnitInGroup ~= nil)
				end
				if firstUnitInGroup then
					instance.unitComboList:setText(firstUnitInGroup.name)
					instance.staticComboList:setText(cdata.nothing)
				else
					instance.unitComboList:setText(cdata.nothing)
				end			
				setUnit(instance, firstUnitInGroup)
				instance.parent:onChangeUnit(firstUnitInGroup)
			end
			
			function unitComboList:onChange(item)
				local unit = base.module_mission.unit_by_id[item.itemId.value]
				setUnit(instance, unit)
				instance.parent:onChangeUnit(unit)
				instance.staticComboList:setText(cdata.nothing)
			end
			
			function staticComboList:onChange(item)
				local static = base.module_mission.unit_by_id[item.itemId.value]
				setUnit(instance, static)
				instance.parent:onChangeUnit(static)
				instance.groupComboList:setText(cdata.nothing)
				instance.unitComboList:setText(cdata.nothing)
			end
			
			return instance			
		end
	}
	base.setmetatable(AttackUnitParamBox, ActionParamHandler)
end

--Priority
do
	--public
	PriorityParamBox = {
		open = function(self, data)
			ActionParamHandler.open(self, data)
			self.data.actionParams.priority = self.data.actionParams.priority or 0
			self.prioritySpin:setValue(self.data.actionParams.priority)
		end,
		create = function(self, parent, line0)
			
			local cdata = {
				priority = _('PRIORITY')
			}
		
			local left, top, width, height = parent.panel:getBounds()
			
			local panel = addPanel(parent.panel, 0, line0, 0, 1)
			parent.panel:insertWidget(panel)

			panel:insertWidget(createStatic(cdata.priority, 0, 0, 1.7 * U.text_w, U.widget_h))		

			local prioritySpin = createSpinBox(0, actionDB.priorityMax, 1, 1.7 * U.text_w, 0, 85, U.widget_h)
			panel:insertWidget(prioritySpin)
			
			local instance = {
				parent			= parent,
				prioritySpin	= prioritySpin,
				panel			= panel
			}
			self.__index = self
			base.setmetatable(instance, self)
			
			prioritySpin.onChange = function(theSpin, onChange)
				instance.data.actionParams.priority = theSpin:getValue()
			end			
			
			return instance			
		end
	}
	base.setmetatable(PriorityParamBox, ActionParamHandler)
end

--Visible
do
	--public
	VisibleParamBox = {
		open = function(self, data)
			ActionParamHandler.open(self, data)
			self.data.actionParams.visible = self.data.actionParams.visible or false
			self.visibleCheckBox:setState(self.data.actionParams.visible)
		end,
		create = function(self, parent, line0)
			
			local cdata = {
				visible = _('VISIBLE')
			}
		
			local left, top, width, height = parent.panel:getBounds()
			local box_w = width
			
			local panel = addPanel(parent.panel, 0, line0, 0, 1)
			parent.panel:insertWidget(panel)
			
			panel:insertWidget(createStatic(cdata.visible))				
		
			local visibleCheckBox = widgetFactory.createCheckBox(nil, 5 + 1.7 * U.text_w, 0, U.spin_long_w - 15, U.widget_h)
			visibleCheckBox.attackGroupDefault = attackGroupDefault
			panel:insertWidget(visibleCheckBox)
						
			local instance = {
				parent			= parent,
				visibleCheckBox = visibleCheckBox,
				panel			= panel
			}
			self.__index = self
			base.setmetatable(instance, self)
			
			visibleCheckBox.onChange = function(theCheckBox, onChange)
				instance.data.actionParams.visible = theCheckBox:getState()
			end			
			
			return instance			
		end
	}
	base.setmetatable(VisibleParamBox, ActionParamHandler)
end

--Strike Parameters
do
	local expendItems = {	U.makeComboboxItem(_('Auto'),	'Auto'),
							U.makeComboboxItem(_('One'),	'One'),
							U.makeComboboxItem(_('Two'),	'Two'),
							U.makeComboboxItem(_('Four'),	'Four'),
							U.makeComboboxItem(_('Quarter'),'Quarter'),
							U.makeComboboxItem(_('Half'),	'Half'),
							U.makeComboboxItem(_('All'),	'All') }
	local ratios = {
		['Quarter']	= 0.25,
		['Half']	= 0.5,
		['All']		= 1.0
	}
	
	local defaultExpend = expendItems[1].value
	
	local function updateExpendList(self, attackQty)
		local selected = {}
		for i, v in base.pairs(expendItems) do
			local ratio = ratios[v.value]
			local maxRatio = 1.0 / attackQty
			if ratio == nil or ratio <= maxRatio then
				base.table.insert(selected, v)
			end
		end
		U.fillComboList(self.weaponExpendComboList, selected)
	end
	
	local function updateAttackQtyMax(self, expendRatio)
		self.attackQtySpin:setRange(1, expendRatio and 1.0 / expendRatio or 1000)
	end
		
	Strike = {
		open = function(self, data, targetType)
			self.data = data
			self.childs.weaponParamBox:open(data, targetType)
			self.panel:setVisible(true)
			
			data.actionParams.expend = data.actionParams.expend or defaultExpend --move to me_db_api			
			updateExpendList(self, data.actionParams.attackQty or 1)
			U.setComboBoxValue(self.weaponExpendComboList, data.actionParams.expend)
			self.weaponExpendComboList:setEnabled(self.childs.weaponParamBox:getWeaponAuto() ~= self.data.actionParams.weaponType)
			
			if self.attackQtyLimitCheckBox ~= nil then
				self.attackQtyLimitCheckBox:setState(data.actionParams.attackQtyLimit or false)
				self.attackQtySpin:setEnabled(self.data.actionParams.attackQtyLimit or false)
			else
				self.attackQtySpin:setEnabled(true)
			end
			
			self.attackQtySpin:setValue(data.actionParams.attackQty or 1)
			updateAttackQtyMax(self, ratios[data.actionParams.expend])			
			self.groupAttackCheckBox:setState(data.actionParams.groupAttack or false)
			
			data.actionParams.directionEnabled = data.actionParams.directionEnabled ~= nil and data.actionParams.directionEnabled or false
			self.attackCourseCheckBox:setState(data.actionParams.directionEnabled)
			self.attackCourseDial:setEnabled(data.actionParams.directionEnabled)
			data.actionParams.direction = data.actionParams.direction or 0
			self.attackCourseDial:setValue(UC.toDegrees(data.actionParams.direction))
			
			if data.group.type == 'ship' then
				data.actionParams.altitudeEnabled = false
				self.attackAltitudeCheckBox:setVisible(false)
				self.altitudeSpinBox:setVisible(false)
				self.altUnitsLabel:setVisible(false)
				self.altStatic:setVisible(false)
			else
				self.attackAltitudeCheckBox:setVisible(true)
				self.altitudeSpinBox:setVisible(true)
				self.altUnitsLabel:setVisible(true)
				self.altStatic:setVisible(true)
			end	
			data.actionParams.altitudeEnabled = data.actionParams.altitudeEnabled ~= nil and data.actionParams.altitudeEnabled or false
			self.attackAltitudeCheckBox:setState(data.actionParams.altitudeEnabled)
			self.altUnitSpinBox:setEnabled(data.actionParams.altitudeEnabled)
			local unit = data.group.units[1]			
			local unitDesc = me_db_api.unit_by_type[unit.type]			
			local wpt = self.data.wpt or self.data.group.route.points[1]
			local wptAltitude = wpt.alt
			if wpt.alt_type == 'RADIO' then
				local Hrel = U.getAltitude(wpt.x, wpt.y)
				wptAltitude = wptAltitude + Hrel
			end			
			self.data.actionParams.altitude = (self.data.actionParams.altitudeEdited and self.data.actionParams.altitude) or wptAltitude			
			self.altUnitSpinBox:setUnitSystem(getUnits())
			self.altUnitSpinBox:setRange(0, unitDesc.MaxHeight or 0)	
			self.altUnitSpinBox:setValue(base.math.floor(self.data.actionParams.altitude + 0.5))
			
			if self.diveAttackCheckBox then				
				self.diveAttackCheckBox:setState(data.actionParams.attackType == 'Dive')
			end
		end,
		setTargetType = function(self, targetType)
			self.childs.weaponParamBox:setTargetType(targetType)
		end,
		onWeaponChange = function(self)
			local defaultWeapon = self.childs.weaponParamBox:getWeaponAuto() == self.data.actionParams.weaponType
			self.weaponExpendComboList:setEnabled(not defaultWeapon)
			if defaultWeapon then
				self.data.actionParams.expend = defaultExpend
				U.setComboBoxValue(self.weaponExpendComboList, self.data.actionParams.expend)
			end
		end,
		create = function(self, parent, line0, objectAsTarget, dive_bombing)
			local left, top, width, height = parent.panel:getBounds()
			local box_w = width
			local panel = addPanel(parent.panel, 0, line0, 0, 8)
			
			local panelLines = addLines(panel, 2, 7, {[4] = 50})
			parent.panel:insertWidget(panel)
			
			local cdata = {
				weapon_expend	= _('REL QTY'),
				attack_qty		= _('ATTACK QTY'),
				max_attack_qty	= _('MAX ATTACK QTY'),
				group_attack	= _('GROUP ATTACK'),
				attack_direction= _('DIRECTION FROM'),
				attack_altitude	= _('ALTITUDE ABOVE'),
				dive_atack      = _('DIVE BOMB'),
			}

			panelLines[1]:insertWidget(createStatic(cdata.weapon_expend))
			
			local weaponExpendComboList = widgetFactory.createComboList(1.7 * U.text_w, 0, 220, U.widget_h)
			panelLines[1]:insertWidget(weaponExpendComboList)
			
			panelLines[2]:insertWidget(createStatic(objectAsTarget and cdata.max_attack_qty or cdata.attack_qty))
			
			local attackQtyLimitCheckBox = nil
			if objectAsTarget then
				attackQtyLimitCheckBox = widgetFactory.createCheckBox(nil, 1.7 * U.text_w, 0, 175, U.widget_h)
				panelLines[2]:insertWidget(attackQtyLimitCheckBox)
			end
			
			local offset = objectAsTarget and 18 or 0.0
			local attackQtySpin = createSpinBox(1, 10, 1, 150, 0, 85, U.widget_h)
			attackQtySpin.onlyOneAttack = onlyOneAttack
			panelLines[2]:insertWidget(attackQtySpin)
			
			panelLines[3]:insertWidget(createStatic(cdata.group_attack))
			
			local groupAttackCheckBox = widgetFactory.createCheckBox(nil, 1.7 * U.text_w, 0, 18, U.widget_h)
			panelLines[3]:insertWidget(groupAttackCheckBox)
			
			panelLines[4]:insertWidget(createStatic(cdata.attack_direction, 0, 13))
			
			local attackCourseCheckBox = widgetFactory.createCheckBox(nil, 1.7 * U.text_w, 13, 18, U.widget_h)
			panelLines[4]:insertWidget(attackCourseCheckBox)

			local attackCourseDial = widgetFactory.createDial(1.7 * U.text_w + U.dist_w + 18 + U.dist_w, 0, 43, 43)
			attackCourseDial:setRange(0, 359)
			attackCourseDial:setCyclic(true)
			panelLines[4]:insertWidget(attackCourseDial)
			
			local altStatic = createStatic(cdata.attack_altitude)
			panelLines[5]:insertWidget(altStatic)
			
			local attackAltitudeCheckBox = widgetFactory.createCheckBox(nil, 1.7 * U.text_w, 0, 18, U.widget_h)
			panelLines[5]:insertWidget(attackAltitudeCheckBox)			
					
			local altitudeSpinBox = createSpinBox(1, 10, 1, 150, 0, 85, U.widget_h)
			panelLines[5]:insertWidget(altitudeSpinBox)
			
			local altUnitsLabel = createStatic(nil, 1.7 * U.text_w + U.dist_w + 18 + U.dist_w + U.spin_long_w - 15 + U.dist_w,
									0, U.text_w, U.widget_h)
			panelLines[5]:insertWidget(altUnitsLabel)			
			
			local altUnitSpinBox = U.createUnitSpinBox(altUnitsLabel, altitudeSpinBox, U.altitudeUnits, 0, 5000)
			
			local diveAttackCheckBox 
			if dive_bombing then				
				panelLines[6]:insertWidget(createStatic(cdata.dive_atack))			
				diveAttackCheckBox = widgetFactory.createCheckBox(nil, 1.7 * U.text_w, 0, 18, U.widget_h)
				panelLines[6]:insertWidget(diveAttackCheckBox)
			end
			
			local instance = {
				parent 					= parent,
				weaponExpendComboList 	= weaponExpendComboList,				
				attackQtyLimitCheckBox	= attackQtyLimitCheckBox,
				attackQtySpin			= attackQtySpin,
				groupAttackCheckBox		= groupAttackCheckBox,
				attackCourseCheckBox	= attackCourseCheckBox,
				attackCourseDial		= attackCourseDial,
				attackAltitudeCheckBox	= attackAltitudeCheckBox,
				altUnitSpinBox			= altUnitSpinBox,
				diveAttackCheckBox		= diveAttackCheckBox,
				panel					= panel,
				altUnitsLabel			= altUnitsLabel,
				altitudeSpinBox			= altitudeSpinBox,
				altStatic				= altStatic,			
			}
			instance.childs = {
				weaponParamBox = WeaponParamBox:create(instance, 1)
			}
			self.__index = self
			base.setmetatable(instance, self)
			
			function weaponExpendComboList:onChange(item)
				instance.data.actionParams.expend = item.itemId.value
				updateAttackQtyMax(instance, ratios[item.itemId.value])
			end
			
			function attackQtySpin.onChange(spinBox)
				instance.data.actionParams.attackQty = spinBox:getValue()
				updateExpendList(instance, instance.data.actionParams.attackQty)
				U.setComboBoxValue(weaponExpendComboList, instance.data.actionParams.expend)
			end
			
			function groupAttackCheckBox.onChange(self)
				instance.data.actionParams.groupAttack = self:getState()
			end
			
			function attackCourseCheckBox.onChange(self)
				instance.data.actionParams.directionEnabled = self:getState()
				attackCourseDial:setEnabled(instance.data.actionParams.directionEnabled)
			end
			
			function attackCourseDial.onChange(self)
				instance.data.actionParams.direction = U.toRadians(self:getValue())
			end
			
			function attackAltitudeCheckBox.onChange(self)
				instance.data.actionParams.altitudeEnabled = self:getState()
				altitudeSpinBox:setEnabled(instance.data.actionParams.altitudeEnabled)
			end
			
			function altitudeSpinBox.onChange(self)
				instance.data.actionParams.altitude = altUnitSpinBox:getValue()
				instance.data.actionParams.altitudeEdited = true
			end

			if diveAttackCheckBox then				
				function diveAttackCheckBox.onChange(self)
					if self:getState() then
						instance.data.actionParams.attackType = 'Dive' 
					else
						instance.data.actionParams.attackType = nil
					end
				end
			end
			
			if attackQtyLimitCheckBox ~= nil then
				function attackQtyLimitCheckBox.onChange()
					instance.data.actionParams.attackQtyLimit = attackQtyLimitCheckBox:getState()
					instance.attackQtySpin:setEnabled(instance.data.actionParams.attackQtyLimit)
				end
			end
			
			return instance				
		end
	}
	base.setmetatable(Strike, ActionParamHandler)
end

-- Carpet Strike Parameters
do
	local expendItems = {	U.makeComboboxItem(_('Auto'),	'Auto'),
							U.makeComboboxItem(_('One'),	'One'),
							U.makeComboboxItem(_('Two'),	'Two'),
							U.makeComboboxItem(_('Four'),	'Four'),
							U.makeComboboxItem(_('Quarter'),'Quarter'),
							U.makeComboboxItem(_('Half'),	'Half'),
							U.makeComboboxItem(_('All'),	'All') }
	local ratios = {
		['Quarter']	= 0.25,
		['Half']	= 0.5,
		['All']		= 1.0
	}
	
	local defaultExpend = expendItems[1].value
	
	local function updateExpendList(self, attackQty)
		local selected = {}
		for i, v in base.pairs(expendItems) do
			local ratio = ratios[v.value]
			local maxRatio = 1.0 / attackQty
			if ratio == nil or ratio <= maxRatio then
				base.table.insert(selected, v)
			end
		end
		U.fillComboList(self.weaponExpendComboList, selected)
	end
	
	local function updateAttackQtyMax(self, expendRatio)
		self.attackQtySpin:setRange(1, expendRatio and 1.0 / expendRatio or 1000)
	end
		
	CarpetStrike = {
		open = function(self, data, targetType)
			self.data = data
			self.childs.weaponParamBox:open(data, targetType)
			self.panel:setVisible(true)
			
			data.actionParams.expend = data.actionParams.expend or defaultExpend --move to me_db_api			
			updateExpendList(self, data.actionParams.attackQty)
			U.setComboBoxValue(self.weaponExpendComboList, data.actionParams.expend)
			self.weaponExpendComboList:setEnabled(self.childs.weaponParamBox:getWeaponAuto() ~= self.data.actionParams.weaponType)
						
			self.carpetLengthSpinBox:setEnabled(true)		
			self.carpetLengthSpinBox:setUnitSystem(getUnits())
			self.carpetLengthSpinBox:setRange(0, 3000)		
			self.carpetLengthSpinBox:setValue(self.data.actionParams.carpetLength)	
				
			data.actionParams.altitudeEnabled = data.actionParams.altitudeEnabled ~= nil and data.actionParams.altitudeEnabled or false
			self.attackAltitudeCheckBox:setState(data.actionParams.altitudeEnabled)
			self.altUnitSpinBox:setEnabled(data.actionParams.altitudeEnabled)
			local unit = data.group.units[1]			
			local unitDesc = me_db_api.unit_by_type[unit.type]			
			local wpt = self.data.wpt or self.data.group.route.points[1]
			local wptAltitude = wpt.alt
			if wpt.alt_type == 'RADIO' then
				local Hrel = U.getAltitude(wpt.x, wpt.y)
				wptAltitude = wptAltitude + Hrel
			end			
			self.data.actionParams.altitude = (self.data.actionParams.altitudeEdited and self.data.actionParams.altitude) or wptAltitude			
			self.altUnitSpinBox:setUnitSystem(getUnits())
			self.altUnitSpinBox:setRange(0, unitDesc.MaxHeight)	
			self.altUnitSpinBox:setValue(self.data.actionParams.altitude)	
		end,
		setTargetType = function(self, targetType)
			self.childs.weaponParamBox:setTargetType(targetType)
		end,
		onWeaponChange = function(self)
			local defaultWeapon = self.childs.weaponParamBox:getWeaponAuto() == self.data.actionParams.weaponType
			self.weaponExpendComboList:setEnabled(not defaultWeapon)
			if defaultWeapon then
				self.data.actionParams.expend = defaultExpend
				U.setComboBoxValue(self.weaponExpendComboList, self.data.actionParams.expend)
			end
		end,
		create = function(self, parent, line0, objectAsTarget)
			local left, top, width, height = parent.panel:getBounds()
			local box_w = width
			
			local panel = addPanel(parent.panel, 0, line0, 0, 6)
			
			local panelLines = addLines(panel, 2, 5)
			parent.panel:insertWidget(panel)
			
			local cdata = {
				weapon_expend	= _('REL QTY'),
				carpetLength 	= _('PATTERN LENGTH'),
				attack_direction= _('DIRECTION FROM'),
				attack_altitude	= _('ALTITUDE ABOVE'),
				
			}

			panelLines[1]:insertWidget(createStatic(cdata.weapon_expend))
			
			local weaponExpendComboList = widgetFactory.createComboList(1.7 * U.text_w, 0, 220, U.widget_h)
			panelLines[1]:insertWidget(weaponExpendComboList)
			
			
			panelLines[2]:insertWidget(createStatic(cdata.carpetLength))
			local carpLengthSpinBox = createSpinBox(1, 10, 1, 1.7 * U.text_w + U.dist_w + 18 + U.dist_w, 0, U.spin_long_w - 15, U.widget_h)
			panelLines[2]:insertWidget(carpLengthSpinBox)
			
			local carpetLengthUnitsLabel = createStatic(nil, 1.7 * U.text_w + U.dist_w + 18 + U.dist_w + U.spin_long_w - 15 + U.dist_w,
									0, U.text_w, U.widget_h)
			panelLines[2]:insertWidget(carpetLengthUnitsLabel)	
			local carpetLengthSpinBox = U.createUnitSpinBox(carpetLengthUnitsLabel, carpLengthSpinBox, U.altitudeUnits, 0, 3000)
			
			
			panelLines[3]:insertWidget(createStatic(cdata.attack_altitude))
			
			local attackAltitudeCheckBox = widgetFactory.createCheckBox(nil, 1.7 * U.text_w, 0, 18, U.widget_h)
			panelLines[3]:insertWidget(attackAltitudeCheckBox)			
					
			local altitudeSpinBox = createSpinBox(1, 10, 1, 1.7 * U.text_w + U.dist_w + 18 + U.dist_w, 0, U.spin_long_w - 15, U.widget_h)
			panelLines[3]:insertWidget(altitudeSpinBox)
			
			local altUnitsLabel = createStatic(nil, 1.7 * U.text_w + U.dist_w + 18 + U.dist_w + U.spin_long_w - 15 + U.dist_w,
									0, U.text_w, U.widget_h)
			panelLines[3]:insertWidget(altUnitsLabel)			
			
			local altUnitSpinBox = U.createUnitSpinBox(altUnitsLabel, altitudeSpinBox, U.altitudeUnits, 0, 5000)
			
			local instance = {
				parent 					= parent,
				weaponExpendComboList 	= weaponExpendComboList,		
				carpetLengthSpinBox		= carpetLengthSpinBox,
				attackAltitudeCheckBox	= attackAltitudeCheckBox,
				altUnitSpinBox			= altUnitSpinBox,
				panel					= panel
			}
			instance.childs = {
				weaponParamBox = WeaponParamBox:create(instance, 1)
			}
			self.__index = self
			base.setmetatable(instance, self)
			
			function weaponExpendComboList:onChange(item)
				instance.data.actionParams.expend = item.itemId.value
			end
						
						
			function carpLengthSpinBox.onChange(self)
				instance.data.actionParams.carpetLength = carpetLengthSpinBox:getValue()
			end		
			
			
			function attackAltitudeCheckBox.onChange(self)
				instance.data.actionParams.altitudeEnabled = self:getState()
				altitudeSpinBox:setEnabled(instance.data.actionParams.altitudeEnabled)
			end
			
			function altitudeSpinBox.onChange(self)
				instance.data.actionParams.altitude = altUnitSpinBox:getValue()
				instance.data.actionParams.altitudeEdited = true
			end			
			
			
			return instance				
		end
	}
	base.setmetatable(CarpetStrike, ActionParamHandler)
end


--Paratroopers drop parameters
do
	local function getGroups(self)
		local groups = {}
		local targetCoalition
		local targetCoalition2
		
		if self.data.group.boss.boss.name == CoalitionController.redCoalitionName() then
			targetCoalition = base.module_mission.mission.coalition.red
		elseif self.data.group.boss.boss.name == CoalitionController.neutralCoalitionName() then
			targetCoalition = base.module_mission.mission.coalition.neutrals
		else
			targetCoalition = base.module_mission.mission.coalition.blue
		end
			
		for k,v in base.pairs({targetCoalition, targetCoalition2}) do
			for countryIndex, country in base.pairs(v.country) do
				for groupItemIndex, groupItem in base.pairs(country) do
					if 	base.type(groupItem) == 'table' and
						base.type(groupItem.group) == 'table' then							
						for groupIndex, group in base.pairs(groupItem.group) do
							if 	group ~= self.data.group and
								(
									(not self.friendly and self.groupTypeFilter ~= nil and self.groupTypeFilter[group.type]) or
									(self.friendly and group.type == self.data.group.type and not self.groundEscort) or
									(self.friendly and group.type ~= self.data.group.type and self.groundEscort) 
								)  and
								group.type == 'vehicle' then
								base.table.insert(groups, group)
							end
						end
					end
				end
			end
		end	
		base.table.sort(groups, compareGroupByName)
		return groups
	end
	
	
	ParatroopersDrop = {

		--добвить/убрать задачу десантирований у заданной группы
		setLateActivationToGroup = function(self, group, value)	
			if group then
				if value == true then
					group.visible = false
					group.lateActivation = true
				else
					group.visible = true
					group.lateActivation = false
				end	
			end
		end,
		
		refreshGroupsComboList = function(self, groupsForDropComboList, data)
			local groups = {}
			
			for id,group in base.pairs(base.module_mission.group_by_id) do
				if data.group.boss.boss.name == group.boss.boss.name  
				  and group.type ~= "static" then
					local enable = true
					for k, unit in base.pairs(group.units) do
						if not (me_db_api.unit_by_type[unit.type].visual and me_db_api.unit_by_type[unit.type].visual.parachute) then
							enable = false
						end
					end
				
					if enable then
						base.table.insert(groups, group)
					end
				end
			end
				
			base.table.sort(groups, compareGroupByName)
			
			groupsForDropComboList:clear()
			for kk,group in base.pairs(groups) do
				local voidItem = ListBoxItem.new(group.name)
				voidItem.groupId = group.groupId
				groupsForDropComboList:insertItem(voidItem)
			end						
		end,
				
		open = function(self, data, targetType)
			self.data = data
			self.panel:setVisible(true)					
				
			data.actionParams.altitudeEnabled = data.actionParams.altitudeEnabled ~= nil and data.actionParams.altitudeEnabled or false
			self.attackAltitudeCheckBox:setState(data.actionParams.altitudeEnabled)
			self.altUnitSpinBox:setEnabled(data.actionParams.altitudeEnabled)
			local unit = data.group.units[1]			
			local unitDesc = me_db_api.unit_by_type[unit.type]			
			local wpt = self.data.wpt or self.data.group.route.points[1]
			local wptAltitude = wpt.alt
			if wpt.alt_type == 'RADIO' then
				local Hrel = U.getAltitude(wpt.x, wpt.y)
				wptAltitude = wptAltitude + Hrel
			end			
			self.data.actionParams.altitude = (self.data.actionParams.altitudeEdited and self.data.actionParams.altitude) or wptAltitude			
			self.altUnitSpinBox:setUnitSystem(getUnits())
			self.altUnitSpinBox:setRange(0, unitDesc.MaxHeight)	
			self.altUnitSpinBox:setValue(base.math.floor(self.data.actionParams.altitude + 0.5))			

			ParatroopersDrop:refreshGroupsList(self.groupsForDropComboList, data)
			self.fileEditBox:setText(data.actionParams.scriptFileName)

			if data.actionParams.scriptFileName ~= '' then
				data.actionParams.groupsOnBoard = {}
			end

			ParatroopersDrop:refreshGroupsComboList(self.groupsForDropComboList, data)
			ParatroopersDrop:refreshGroupsList(self.groupsForDropListBox, data)	
		end,
		
		refreshGroupsList = function(self, groupsForDropListBox, data)
			base.U.traverseTable(groupsForDropListBox,2)
			groupsForDropListBox:clear()
			local groupsId = data.actionParams.groupsOnBoard  	
			
			if groupsId then
				local removeTab = {}
				for key,id in base.ipairs(groupsId) do
					local group = base.module_mission.group_by_id[id]
					if group then
						local name = group.name
						item = widgetFactory.createListBoxItem(name, 0, 0, 5 * U.text_w, U.widget_h)
						item.groupId = id
						groupsForDropListBox:insertItem(item)
					else	
						base.table.insert(removeTab, key)
					end
				end
				
				for i = #removeTab, 1, -1 do   
					base.table.remove(data.actionParams.groupsOnBoard, removeTab[i])            
				end
			end
		end,
			
		addGroup = function(self, data, groupId, fileEditBox)
			ParatroopersDrop:removeGroup(data,groupId)
			data.actionParams.scriptFileName = ''
			fileEditBox:setText('')
		
			base.table.insert(data.actionParams.groupsOnBoard  , groupId)
			
			ParatroopersDrop:setLateActivationToGroup(base.module_mission.group_by_id[groupId], true)
		end,
		
		removeGroup = function(self,data,groupId)
			for k,v in base.pairs(data.actionParams.groupsOnBoard) do
				if v == groupId then
					base.table.remove(data.actionParams.groupsOnBoard, k)
					ParatroopersDrop:setLateActivationToGroup(base.module_mission.group_by_id[groupId], false)
					break
				end
			end
		end,
		
		create = function(self, parent, line0, objectAsTarget)
			local left, top, width, height = parent.panel:getBounds()
			local box_w = width
			
			local panel = addPanel(parent.panel, 0, line0, 0, 10)
			
			local panelLines = addLines(panel, 1, 10)
			parent.panel:insertWidget(panel)
			
			local cdata = {
				attack_altitude		= _('ALTITUDE ABOVE'),
				group_spawn			= _('GROUP'),
				file 				= _('FILE'),
				select 				= _('SELECT')
			}			

					
			panelLines[1]:insertWidget(createStatic(cdata.attack_altitude))			
			local attackAltitudeCheckBox = widgetFactory.createCheckBox(nil, 1.7 * U.text_w, 0, 18, U.widget_h)
			panelLines[1]:insertWidget(attackAltitudeCheckBox)					
			local altitudeSpinBox = createSpinBox(1, 10, 1, 1.7 * U.text_w + U.dist_w + 18 + U.dist_w, 0, U.spin_long_w - 15, U.widget_h)
			panelLines[1]:insertWidget(altitudeSpinBox)			
			local altUnitsLabel = createStatic(nil, 1.7 * U.text_w + U.dist_w + 18 + U.dist_w + U.spin_long_w - 15 + U.dist_w,
									0, U.text_w, U.widget_h)
			panelLines[1]:insertWidget(altUnitsLabel)			


			panelLines[2]:insertWidget(createStatic(cdata.group_spawn))
			local groupsForDropComboList = widgetFactory.createComboList(80, 0 , 3 * U.text_w, U.widget_h)
			panelLines[2]:insertWidget(groupsForDropComboList)
				
			local addGroupButton = widgetFactory.createButton(_('ADD'),-5,0,box_w*0.3,U.widget_h)
			panelLines[3]:insertWidget(addGroupButton)
			
			local removeGroupButton = widgetFactory.createButton(_('REMOVE'),box_w*0.4,0,box_w*0.3,U.widget_h)
			panelLines[3]:insertWidget(removeGroupButton)

			local groupsForDropListBox = widgetFactory.createListBox(0, U.widget_h *4, 5 * U.text_w, (6)*U.widget_h)
			panel:insertWidget(groupsForDropListBox)			
			
			
			local sFile = createStatic(cdata.file)
			panelLines[10]:insertWidget(sFile)
			local fileEditBox = widgetFactory.createEditBox(50, 0, box_w - U.text_w-90, U.widget_h)
			fileEditBox:setReadOnly(false)
			panelLines[10]:insertWidget(fileEditBox)			
			local buttonFile = widgetFactory.createButton(cdata.select, box_w - U.text_w-40, 0, U.text_w, U.widget_h)	
			panelLines[10]:insertWidget(buttonFile)
			
			if (base.__FINAL_VERSION__) then
				sFile:setVisible(false)
				fileEditBox:setVisible(false)
				buttonFile:setVisible(false)
			end
			

			local altUnitSpinBox = U.createUnitSpinBox(altUnitsLabel, altitudeSpinBox, U.altitudeUnits, 200, 5000)
			
			local instance = {
				parent 							= parent,		
				attackAltitudeCheckBox			= attackAltitudeCheckBox,
				altUnitSpinBox					= altUnitSpinBox,
				groupsForDropComboList 			= groupsForDropComboList,
				panel							= panel,
				fileEditBox						= fileEditBox,
				groupsForDropListBox			= groupsForDropListBox,
			}
			instance.childs = {
			}
			self.__index = self
			base.setmetatable(instance, self)
									
			function attackAltitudeCheckBox.onChange(self)
				instance.data.actionParams.altitudeEnabled = self:getState()
				altitudeSpinBox:setEnabled(instance.data.actionParams.altitudeEnabled)
			end
			
			function altitudeSpinBox.onChange(self)
				instance.data.actionParams.altitude = altUnitSpinBox:getValue()
				instance.data.actionParams.altitudeEdited = true
			end
			
			function buttonFile:onChange()			
				local path = MeSettings.getScriptPath()
				local filters = {FileDialogFilters.script()}
				local filename = FileDialog.open(path, filters, _('Choose Lua script:'))
				
				if filename then
					MeSettings.setScriptPath(filename)
				end
				
				openFileDlgCallback(filename, fileEditBox)
				instance.data.actionParams.scriptFileName = FileDialogUtils.extractFilenameFromPath(fileEditBox:getText())
				if instance.data.actionParams.scriptFileName then
					for k, groupId in base.pairs(instance.data.actionParams.groupsOnBoard) do
						ParatroopersDrop:setLateActivationToGroup(base.module_mission.group_by_id[groupId], false)
					end
					instance.data.actionParams.groupsOnBoard = {}
					groupsForDropComboList:selectItem()
				end
				ParatroopersDrop:refreshGroupsList(instance.groupsForDropListBox, instance.data)	
			end
			
			function fileEditBox.onChange(self)
				instance.data.actionParams.scriptFileName = fileEditBox:getText()
			end
			
			function groupsForDropComboList:onChange()
			--	local item = groupsForDropComboList:getSelectedItem()
			--	if item then
			--		local text = item:getText()
			--		local id = item.groupId
			--		
			--	end
			end
			
			function addGroupButton:onChange()
				local item = groupsForDropComboList:getSelectedItem()
				if item then
					local text = item:getText()
					local id = item.groupId
					
					ParatroopersDrop:addGroup(parent.data, id, fileEditBox)
					ParatroopersDrop:refreshGroupsList(groupsForDropListBox, parent.data)
				end
			end
			
			function removeGroupButton:onChange()
				local item = groupsForDropListBox:getSelectedItem()
				if item then 
					local id = item.groupId
					
					ParatroopersDrop:removeGroup(parent.data,id)
					ParatroopersDrop:refreshGroupsList(groupsForDropListBox, parent.data)
				end
			end
			
			return instance				
		end

	}
	base.setmetatable(ParatroopersDrop, ActionParamHandler)
end

--AirboneDropOperation parameters
do			
	local expendDropItems = { U.makeComboboxItem(_('Quarter'),'Quarter'),
							  U.makeComboboxItem(_('Half'),	'Half'),
							  U.makeComboboxItem(_('All'),	'All') }
	
	local ratios = {
		['Quarter']	= 0.25,
		['Half']	= 0.5,
		['All']		= 1.0
	}	
	local defaultDropExpend = expendDropItems[3].value
	
	local function updateDropExpendList(self, runsQty)
		local selected = {}
		for i, v in base.pairs(expendDropItems) do
			local ratio = ratios[v.value]
			local maxRatio = 1.0 / runsQty
			if ratio == nil or ratio <= maxRatio then
				base.table.insert(selected, v)
			end
		end
		U.fillComboList(self.dropExpendComboList, selected)
	end
	
	AirboneDropOperation = {
		open = function(self, data, targetType)
			self.data = data
			self.childs.AirboneDropParamBox:open(data, targetType)
			self.panel:setVisible(true)
			
			data.actionParams.expend = data.actionParams.expend or defaultExpend --move to me_db_api
			updateDropExpendList(self, data.actionParams.runsQty)			
			U.setComboBoxValue(self.dropExpendComboList, data.actionParams.expend)

			self.runsQtySpin:setEnabled(true)

			self.runsQtySpin:setValue(data.actionParams.runsQty or 1)		
			self.groupDropCheckBox:setState(data.actionParams.groupDrop or false)
			
			data.actionParams.directionEnabled = data.actionParams.directionEnabled ~= nil and data.actionParams.directionEnabled or false
			self.attackCourseCheckBox:setState(data.actionParams.directionEnabled)
			self.attackCourseDial:setEnabled(data.actionParams.directionEnabled)
			data.actionParams.direction = data.actionParams.direction or 0
			self.attackCourseDial:setValue(UC.toDegrees(data.actionParams.direction))
			
			self.attackAltitudeCheckBox:setVisible(true)
			self.altitudeSpinBox:setVisible(true)
			self.altUnitsLabel:setVisible(true)
			self.altStatic:setVisible(true)

			data.actionParams.altitudeEnabled = data.actionParams.altitudeEnabled ~= nil and data.actionParams.altitudeEnabled or false
			self.attackAltitudeCheckBox:setState(data.actionParams.altitudeEnabled)
			self.altUnitSpinBox:setEnabled(data.actionParams.altitudeEnabled)
			local unit = data.group.units[1]			
			local unitDesc = me_db_api.unit_by_type[unit.type]			
			local wpt = self.data.wpt or self.data.group.route.points[1]
			local wptAltitude = wpt.alt
			if wpt.alt_type == 'RADIO' then
				local Hrel = U.getAltitude(wpt.x, wpt.y)
				wptAltitude = wptAltitude + Hrel
			end			
			self.data.actionParams.altitude = (self.data.actionParams.altitudeEdited and self.data.actionParams.altitude) or wptAltitude			
			self.altUnitSpinBox:setUnitSystem(getUnits())
			self.altUnitSpinBox:setRange(0, unitDesc.MaxHeight or 0)	
			self.altUnitSpinBox:setValue(base.math.floor(self.data.actionParams.altitude + 0.5))
			
		end,
		setTargetType = function(self, targetType)
			self.childs.AirboneDropParamBox:setTargetType(targetType)
		end,
		onWeaponChange = function(self)

		end,
		create = function(self, parent, line0)
			local left, top, width, height = parent.panel:getBounds()
			local box_w = width
			
			local panel = addPanel(parent.panel, 0, line0, 0, 7)
			
			local panelLines = addLines(panel, 2, 7, {[4] = 50})
			parent.panel:insertWidget(panel)
			
			local cdata = {
				drop_qty		= _('DROP QTY'),
				attack_qty		= _('RUNS QTY'),
				group_drop		= _('GROUP DROP'),
				attack_direction= _('DIRECTION FROM'),
				attack_altitude	= _('ALTITUDE ABOVE'),
			}

			panelLines[1]:insertWidget(createStatic(cdata.drop_qty))
			
			local dropExpendComboList = widgetFactory.createComboList(1.7 * U.text_w, 0, 220, U.widget_h)
			panelLines[1]:insertWidget(dropExpendComboList)
			
			--ATTACK QTY
			panelLines[2]:insertWidget(createStatic(cdata.attack_qty))

			local offset = 0.0
			local runsQtySpin = createSpinBox(1, 4, 1, offset + 1.7 * U.text_w, 0, 220, U.widget_h)
			runsQtySpin.onlyOneAttack = onlyOneAttack
			panelLines[2]:insertWidget(runsQtySpin)
			
			panelLines[3]:insertWidget(createStatic(cdata.group_drop))
			
			local groupDropCheckBox = widgetFactory.createCheckBox(nil, 1.7 * U.text_w, 0, 18, U.widget_h)
			panelLines[3]:insertWidget(groupDropCheckBox)
			
			panelLines[4]:insertWidget(createStatic(cdata.attack_direction, 0, 13))
			
			local attackCourseCheckBox = widgetFactory.createCheckBox(nil, 1.7 * U.text_w, 13, 18, U.widget_h)
			panelLines[4]:insertWidget(attackCourseCheckBox)

			local attackCourseDial = widgetFactory.createDial(1.7 * U.text_w + U.dist_w + 18 + U.dist_w, 0, 43, 43)
			attackCourseDial:setRange(0, 359)
			attackCourseDial:setCyclic(true)
			panelLines[4]:insertWidget(attackCourseDial)
			
			local altStatic = createStatic(cdata.attack_altitude)
			panelLines[5]:insertWidget(altStatic)
			
			local attackAltitudeCheckBox = widgetFactory.createCheckBox(nil, 1.7 * U.text_w, 0, 18, U.widget_h)
			panelLines[5]:insertWidget(attackAltitudeCheckBox)			
					
			local altitudeSpinBox = createSpinBox(1, 10, 1, 1.7 * U.text_w + U.dist_w + 18 + U.dist_w, 0, U.spin_long_w - 15, U.widget_h)
			panelLines[5]:insertWidget(altitudeSpinBox)
			
			local altUnitsLabel = createStatic(nil, 1.7 * U.text_w + U.dist_w + 18 + U.dist_w + U.spin_long_w - 15 + U.dist_w,
									0, U.text_w, U.widget_h)
			panelLines[5]:insertWidget(altUnitsLabel)			
			
			local altUnitSpinBox = U.createUnitSpinBox(altUnitsLabel, altitudeSpinBox, U.altitudeUnits, 0, 5000)
			
			local instance = {
				parent 					= parent,
				dropExpendComboList 	= dropExpendComboList,				
				runsQtySpin				= runsQtySpin,
				groupDropCheckBox		= groupDropCheckBox,
				attackCourseCheckBox	= attackCourseCheckBox,
				attackCourseDial		= attackCourseDial,
				attackAltitudeCheckBox	= attackAltitudeCheckBox,
				altUnitSpinBox			= altUnitSpinBox,
				diveAttackCheckBox		= diveAttackCheckBox,
				panel					= panel,
				altUnitsLabel			= altUnitsLabel,
				altitudeSpinBox			= altitudeSpinBox,
				altStatic				= altStatic,			
			}
			instance.childs = {
				AirboneDropParamBox = AirboneDropParamBox:create(instance, 1)
			}
			self.__index = self
			base.setmetatable(instance, self)
			
			function dropExpendComboList:onChange(item)
				instance.data.actionParams.expend = item.itemId.value
			end
			
			function runsQtySpin.onChange(spinBox)
				instance.data.actionParams.runsQty = spinBox:getValue()
				updateDropExpendList(instance, instance.data.actionParams.runsQty)
				U.setComboBoxValue(dropExpendComboList, instance.data.actionParams.expend)
			end
			
			function groupDropCheckBox.onChange(self)
				instance.data.actionParams.groupDrop = self:getState()
			end
			
			function attackCourseCheckBox.onChange(self)
				instance.data.actionParams.directionEnabled = self:getState()
				attackCourseDial:setEnabled(instance.data.actionParams.directionEnabled)
			end
			
			function attackCourseDial.onChange(self)
				instance.data.actionParams.direction = U.toRadians(self:getValue())
			end
			
			function attackAltitudeCheckBox.onChange(self)
				instance.data.actionParams.altitudeEnabled = self:getState()
				altitudeSpinBox:setEnabled(instance.data.actionParams.altitudeEnabled)
			end
			
			function altitudeSpinBox.onChange(self)
				instance.data.actionParams.altitude = altUnitSpinBox:getValue()
				instance.data.actionParams.altitudeEdited = true
			end
			

			return instance					
		end
	}
	base.setmetatable(AirboneDropOperation, ActionParamHandler)
	
	
end

--Strike Parameters
do
	Strike2 = {
		open = function(self, data, targetType)
			self.data = data
			self.childs.weaponParamBox:open(data, targetType)
			self.panel:setVisible(true)
			--data.actionParams.expendQtyEnabled = data.actionParams.expendQtyEnabled or false
			--data.actionParams.expendQty = data.actionParams.expendQty or 1
			self.expendLimitCheckBox:setState(data.actionParams.expendQtyEnabled)
			self.expendQtySpin:setValue(data.actionParams.expendQty)
			self.expendQtySpin:setEnabled(data.actionParams.expendQtyEnabled)
		end,
		setTargetType = function(self, targetType)
			self.childs.weaponParamBox:setTargetType(targetType)
		end,
		onWeaponChange = function(self)

		end,
		create = function(self, parent, line0, objectAsTarget)
			local left, top, width, height = parent.panel:getBounds()
			local box_w = width
			
			local panel = addPanel(parent.panel, 0, line0, 0, 2)
			
			local panelLines = addLines(panel, 2, 1)
			parent.panel:insertWidget(panel)
			
			local cdata = {
				weapon_expend	= _('ROUNDS EXPEND')
			}

			panelLines[1]:insertWidget(createStatic(cdata.weapon_expend))
				
			local expendLimitCheckBox = widgetFactory.createCheckBox(nil, 1.7 * U.text_w, 1, 2.5 * U.text_w, U.widget_h)
			panelLines[1]:insertWidget(expendLimitCheckBox)
			
			local expendQtySpin = createSpinBox(1, 100, 1, 18 + 2.3 * U.text_w, 0, 85, U.widget_h)
			panelLines[1]:insertWidget(expendQtySpin)
						
			local instance = {
				parent 					= parent,
				expendLimitCheckBox 	= expendLimitCheckBox,				
				expendQtySpin			= expendQtySpin,
				panel					= panel
			}
			instance.childs = {
				weaponParamBox = WeaponParamBox:create(instance, 1)
			}
			self.__index = self
			base.setmetatable(instance, self)
			
			function expendLimitCheckBox.onChange(checkBox)
				instance.data.actionParams.expendQtyEnabled = checkBox:getState()
				expendQtySpin:setEnabled(instance.data.actionParams.expendQtyEnabled)
			end
			
			function expendQtySpin.onChange(spinBox)
				instance.data.actionParams.expendQty = spinBox:getValue()
			end
			
			return instance				
		end
	}
	base.setmetatable(Strike2, ActionParamHandler)
end

--Engage Targets
do

	local allUnitsTypeTree = {
		name = 'All',
		childs = {
			{
				name = 'Air',
				childs = {
					{
						name = 'Planes',
						childs = {
							'Fighters',
							'Multirole fighters',
							'Bombers'							
						}
					},
					'Helicopters',
					'UAVs',
				}
			},				
			{
				name = 'Ground Units',
				childs = {
						'Infantry',
						'Fortifications',
						{
							name = 'Ground vehicles',
							childs = {
								{
									name = 'Armored vehicles',
									childs = {
										'Tanks',
										'IFV',
										'APC'
									},
								},
								'Artillery',
								'Unarmed vehicles'					
							}
						},
						{
							name = 'Air Defence',
							childs = {
								'AAA',
								{
									name = 'SAM related',
									childs = {
										'SR SAM',
										'MR SAM',
										'LR SAM'
									},
								}
							}
						},
				}
			},
			{
				name = 'Naval',
				childs = {
					{
						name = 'Ships',
						childs = {
							{
								name = 'Armed ships',
								childs = {
									{
										name = 'Heavy armed ships',
										childs = {
											'Aircraft Carriers',
											'Cruisers',
											'Destroyers',
											'Frigates',
											'Corvettes',
										}
									},
									'Light armed ships'
								}
							},
							'Unarmed ships'
						}
					},
					'Submarines',
				},
			},
			{
				name = 'Missile',
				childs = {
					'Cruise missiles',
					'Antiship Missiles',
					'AA Missiles',
					'AG Missiles',
					'SA Missiles',
					}
			}
		}
	}
	local airplanesTree = {
		name = 'Planes',
		childs = {
			'Fighters',
			'Multirole fighters',
			'Bombers'			
		}
	}
	local airUnitsTypesTree = {
			name = 'Air',
			childs = {
				{
					name = 'Planes',
					childs = {
						'Fighters',
						'Multirole fighters',
						'Bombers'
					}
				},
				'Helicopters',
				'UAVs',

			}
	}
	local missilesUnitsTypesTree = {
			name = 'Missile',
			childs = {
				'Cruise missiles',
				'Antiship Missiles',
				'AA Missiles',
				'AG Missiles',
				'SA Missiles',
			}
	}
	local groundUnitsTypesTree = {
		name = 'All',
		childs = {
			{
				name = 'Air',
				childs = {
					'Helicopters'
				}
			},
			{
				name = 'Ground Units',
				childs = {
						'Infantry',
						'Fortifications',
						{
							name = 'Ground vehicles',
							childs = {
								{
									name = 'Armored vehicles',
									childs = {
										'Tanks',
										'IFV',
										'APC'
									},
								},
								'Artillery',
								'Unarmed vehicles'					
							}
						},
						{
							name = 'Air Defence',
							childs = {
								'AAA',
								{
									name = 'SAM related',
									childs = {
										'SR SAM',
										'MR SAM',
										'LR SAM'
									},
								}
							}
						},
				}
			},
			{
				name = 'Naval',
				childs = {
					'Light armed ships'
				}
			}
		}
	}
	local airDefenceTypesTree = {
		name = 'Air Defence',
		childs = {
			'AAA',
			{
				name = 'SAM related',
				childs = {
					'SR SAM',
					'MR SAM',
					'LR SAM'
				},
			}
		}
	}
	local navalUnitsTypesTree = {
		name = 'Naval',
		childs = {
			{
				name = 'Ships',
				childs = {
					{
						name = 'Armed ships',
						childs = {
							{
								name = 'Heavy armed ships',
								childs = {
									'Aircraft Carriers',
									'Cruisers',
									'Destroyers',
									'Frigates',
									'Corvettes',
								}
							},
							'Light armed ships',
						}
					},
					'Unarmed ships'
				}
			},
			'Submarines'
		}
	}
	local typesTreeByTask = {
		['all'] = {
			['SEAD']			= airDefenceTypesTree,
			['Antiship Strike'] = navalUnitsTypesTree,
			['CAS']				= groundUnitsTypesTree,
			['AFAC']			= groundUnitsTypesTree,
			['CAP']				= {airUnitsTypesTree, missilesUnitsTypesTree},
			['Escort']			= airUnitsTypesTree,
			['Fighter Sweep']	= airplanesTree,
			['All']				= allUnitsTypeTree,
		},
		['helicopter'] = {
			['SEAD']			= airDefenceTypesTree,
			['Antiship Strike'] = navalUnitsTypesTree,
			['CAS']				= groundUnitsTypesTree,
			['AFAC']			= groundUnitsTypesTree,
			['CAP']				= {airUnitsTypesTree, missilesUnitsTypesTree},
			['Escort']			= groundUnitsTypesTree,
			['Fighter Sweep']	= airplanesTree,
			['All']				= allUnitsTypeTree,
		},
	}
	local defaultTypesByTask = {
		['all'] = {
			['SEAD']			= {'Air Defence'},
			['Antiship Strike'] = {'Naval'},
			['CAS']				= {'All'},
			['AFAC']			= {'All'},
			['CAP']				= {'Air'},
			['Escort']			= {'Air'},
			['Fighter Sweep']	= {'Planes'},
			['All']				= {'All'},
		},
		['helicopter'] = {
			['SEAD']			= {'Air Defence'},
			['Antiship Strike'] = {'Naval'},
			['CAS']				= {'All'},
			['AFAC']			= {'All'},
			['CAP']				= {'Air'},
			['Escort']			= {'All'},
			['Fighter Sweep']	= {'Planes'},
			['All']				= {'All'},
			--['Escort']			= {'Ground Units'},
		},
	}
	
	local cdata = {
		all					= _('ALL'),
			air 				= _('AIR'),
				airplanes 			= _('AIRPLANES'),
				fighters 			= _('FIGHTERS'),
				bombers 			= _('BOMBERS'),
				multiRoleFighters	= _('MULTIROLE FIGHTERS'),
				helicopters 		= _('HELICOPTERS'),
				UAVs				= _('UAVs'),
				Missile				= _('MISSILES'),
					antishipMissiles= _('ANTISHIP MISSILES'),	
					AAMissiles		= _('AA MISSILES'),	
					AGMissiles		= _('AG MISSILES'),	
					SAMissiles		= _('SA MISSILES'),	
					cruiseMissiles	= _('CRUISE MISSILES'),
			ground 				= _('GROUND'),
				infantry 			= _('INFANTRY'),
				fortifications 		= _('FORTIFICATIONS'),
				vehicles 			= _('VEHICLES'),
				armor 				= _('ARMOR'),
				tanks 				= _('TANKS'),
				IFV 				= _('IFV'),
				APC 				= _('APC'),
				unarmed 			= _('UNARMED'),
				artillery 			= _('ARTILLERY'),
				airdefence 			= _('AIR DEFENCE'),
				AAA 				= _('AAA'),
				SAM 				= _('SAM'),
				SR_SAM 				= _('SR SAM'),
				MR_SAM 				= _('MR SAM'),
				LR_SAM 				= _('LR SAM'),
			naval 				= _('NAVAL'),
				ships 				= _('SHIPS'),
					armedShips	= _('ARMED SHIPS'),
						heavyArmedShips 	= _('HEAVY ARMED SHIPS'),
						aircraftCarriers 	= _('AIRCRAFT CARRIER'),
						cruisers 			= _('CRUISERS'),
						destroyers			= _('DESTROYERS'),
						fregates			= _('FREGATES'),
						corvettes			= _('CORVETTES'),
						lightArmedShips		= _('LIGHT ARMED SHIPS'),
					unarmedShips = _('UNARMED SHIPS'),
				submarines			= _('SUBMARINES')
	}
	
	cdata.targetTypeNames = {
		['All']					= cdata.all,
		['Ground Units']		= cdata.ground,
		['Infantry']			= cdata.infantry,
		['Fortifications']		= cdata.fortifications,
		['Air']					= cdata.air,
		['Fighters']			= cdata.fighters,
		['Bombers']				= cdata.bombers,
		['Multirole fighters']	= cdata.multiRoleFighters,
		['Planes']				= cdata.airplanes,
		['Helicopters'] 		= cdata.helicopters,
		['UAVs'] 				= cdata.UAVs, 
		['Cruise missiles'] 	= cdata.cruiseMissiles,
		['Missiles'] 			= cdata.Missiles,
		['Missile'] 			= cdata.Missile,
		['Antiship Missiles'] 	= cdata.antishipMissiles,
		['AA Missiles'] 		= cdata.AAMissiles,
		['AG Missiles'] 		= cdata.AGMissiles,
		['SA Missiles'] 		= cdata.SAMissiles,
		['Ground vehicles']		= cdata.vehicles,
		['Armored vehicles']	= cdata.armor,
		['Tanks']				= cdata.tanks,
		['IFV']					= cdata.IFV,
		['APC']					= cdata.APC,
		['Unarmed vehicles']	= cdata.unarmed,
		['Artillery']			= cdata.artillery,
		['Air Defence']			= cdata.airdefence,
		['AAA']					= cdata.AAA,
		['SAM related']			= cdata.SAM,
		['SR SAM']				= cdata.SR_SAM,
		['MR SAM']				= cdata.MR_SAM,
		['LR SAM']				= cdata.LR_SAM,
		['Naval']				= cdata.naval,
		['Ships']				= cdata.ships,
		['Armed ships']			= cdata.armedShips,
		['Heavy armed ships']	= cdata.heavyArmedShips,
		['Aircraft Carriers']	= cdata.aircraftCarriers,
		['Cruisers']			= cdata.cruisers,
		['Destroyers']			= cdata.destroyers,
		['Frigates']			= cdata.fregates,
		['Corvettes']			= cdata.corvettes,
		['Light armed ships']	= cdata.lightArmedShips,
		['Unarmed ships']		= cdata.unarmedShips,	
		['Submarines']			= cdata.submarines,
	}

	local function loadCheckBoxTree(tree, actionParams)
		tree:reset()
		local checkBoxCounter = tree:getItemCount() - 1
		--base.assert(actionParams.targetTypes ~= nil)
		if actionParams.targetTypes then
			for targetTypeNum, targetType in base.pairs(actionParams.targetTypes) do
				for i = 0, checkBoxCounter do
					local checkBox = tree:getItem(i)
					
					if checkBox.name == targetType then
						checkBox:setChecked(true)
						tree:onChange(checkBox)
						break
					end
				end
			end
		end
	end
	
	local function onTargetTypeCheckBoxTreeChange(self, theCheckBoxTree)
		CheckListTree.onItemChange(theCheckBoxTree)
		self.data.actionParams.targetTypes = {}
		self.data.actionParams.noTargetTypes = {}
		self.data.actionParams.value = 'none;'
		local flags = theCheckBoxTree:getFlags()
		
		if flags and base.next(flags) then
			local value = ''
			
			for flagNum, flagName in base.pairs(flags) do
				self.data.actionParams.targetTypes[#self.data.actionParams.targetTypes + 1] = flagName
				value = value .. flagName .. ';'
			end				
			self.data.actionParams.value = value
		end
		
		local noFlags = theCheckBoxTree:getNoFlags()
		
		if noFlags and base.next(noFlags) then
			local value = ''
			
			for flagNum, flagName in base.pairs(noFlags) do
				self.data.actionParams.noTargetTypes[#self.data.actionParams.noTargetTypes + 1] = flagName
			end				
		end
		
	end
	
	local function fillCheckBoxTree(self)
		local groupTask = getGroupTask(self.data.group)
		local typesTree = (typesTreeByTask[self.data.group.type] or typesTreeByTask['all'])[groupTask]
		if self.bAlwaysAll == true then
			typesTree = typesTreeByTask['all']['All']
		end
		self.targetTypesCheckBoxTree:setCheckBoxTree(typesTree, cdata.targetTypeNames)
		loadCheckBoxTree(self.targetTypesCheckBoxTree, self.data.actionParams)
	end
	
	TargetTypes = {		
		open = function(self, data)
			ActionParamHandler.open(self, data)			
			if data.actionParams.targetTypes == nil then
				local groupTask = getGroupTask(self.data.group)
				local defaultTypes = (defaultTypesByTask[self.data.group.type] or defaultTypesByTask['all'])[groupTask]
				if self.bAlwaysAll == true then					
					defaultTypes = defaultTypesByTask['all']['All']		
				end
				data.actionParams.targetTypes = defaultTypes
				if defaultTypes then
					data.actionParams.value = defaultTypes[1] .. ';'
				end
			end
			

			fillCheckBoxTree(self)
			
			if data.actionParams.noTargetTypes == nil then
				data.actionParams.noTargetTypes = {}
				local noFlags = self.targetTypesCheckBoxTree:getNoFlags()
			
				if noFlags and base.next(noFlags) then
					local value = ''					
					for flagNum, flagName in base.pairs(noFlags) do
						data.actionParams.noTargetTypes[#data.actionParams.noTargetTypes + 1] = flagName
					end				
				end
			end
		end,
		setEnabled = function(self, on)
			self.targetTypesCheckBoxTree:setEnabled(on)
		end,
		onGroupTaskChange = function(self)
			ActionParamHandler.onGroupTaskChange(self)
			fillCheckBoxTree(self)
		end,	
		create = function(self, parent, line0, size, bMultyTree, bAlwaysAll)
			local targetTypesCheckBoxTree
		
			if bMultyTree then
				targetTypesCheckBoxTree = widgetFactory.createCheckListTreeMulty()
			else
				targetTypesCheckBoxTree = widgetFactory.createCheckListTree()
			end

			targetTypesCheckBoxTree:setShift(20)
			addChild(targetTypesCheckBoxTree, parent.panel, 0, line0, 0, size)
			parent.panel:insertWidget(targetTypesCheckBoxTree)

			
			local instance = {
				parent					= parent,
				targetTypesCheckBoxTree	= targetTypesCheckBoxTree,
				panel					= targetTypesCheckBoxTree,
				bAlwaysAll				= bAlwaysAll
			}
			self.__index = self
			base.setmetatable(instance, self)
			
			targetTypesCheckBoxTree.onItemChange = function(theCheckBoxTree)
				onTargetTypeCheckBoxTreeChange(instance, theCheckBoxTree)
			end
			
			return instance				
		end
	}
	base.setmetatable(TargetTypes, ActionParamHandler)
end

--Zone radius
do	
	local function maxDistEditBoxOnChange(self)
		local radius = self.maxDistUnitSpinBox:getValue()
		if radius <= 0 then
			radius = 0.001
		end
		self.data.actionParams.zoneRadius = radius		
		if self.data.mapObjects.mark then
			self.data.mapObjects.mark.radius = radius
			base.module_mission.update_target_zone(self.data.mapObjects.mark)			
		end
	end
	
	ZoneRadius = {
		open = function(self, data)
			ActionParamHandler.open(self, data)
			self.data.actionParams.zoneRadius = self.data.actionParams.zoneRadius or 500
			self.maxDistUnitSpinBox:setUnitSystem(getUnits())
			self.maxDistUnitSpinBox:setValue(self.data.actionParams.zoneRadius)
		end,
		create = function(self, parent, line0, smallScale, maxValue)	
			local cdata = {
				zoneRadius	= _('ZONE RADIUS'),
			}
		
			local left, top, width, height = parent.panel:getBounds()
			local box_w = width
			
			local panel = addPanel(parent.panel, 0, line0, 0, 1)
			parent.panel:insertWidget(panel)
			
			panel:insertWidget(createStatic(cdata.zoneRadius))
					
			--local unitLabelPos = box_w-0.25*U.text_w-U.dist_w-5
			local maxDistSpinBox = createSpinBox(0, 1000, 1, 1.7 * U.text_w, 0, 100, U.widget_h)
			maxDistSpinBox:setValue(150)
			panel:insertWidget(maxDistSpinBox)
			maxDistSpinBox:setValue(15.0)

			local distUnitLabel = createStatic(nil, 1.7 * U.text_w + 110, 0, 30, U.widget_h)
			panel:insertWidget(distUnitLabel)
			
			local maxDistUnitSpinBox = U.createUnitSpinBox(distUnitLabel, maxDistSpinBox, smallScale and U.altitudeUnits or U.distanceUnits, 0, maxValue)
			
			local instance = {
				parent				= parent,
				maxDistUnitSpinBox	= maxDistUnitSpinBox,
				panel				= panel,
				onChange = function(self)
					
				end
			}
			
			self.__index = self
			base.setmetatable(instance, self)
			
			maxDistSpinBox.onChange = function(editBox)
				maxDistEditBoxOnChange(instance)
				instance:onChange()
			end
			
			return instance				
		end,
		unitCoeff = 1
	}
	base.setmetatable(ZoneRadius, ActionParamHandler)
end

--AltAirDefense 
do	
	local function altEditBoxOnChange(self)
		local altMod = self.altUnitSpinBox:getValue()
		if self.data.actionParams.alt_type == 0 then
			local tmpAlt = U.getAltitude(self.data.actionParams.x, self.data.actionParams.y)			
			if altMod < tmpAlt then
				altMod = tmpAlt
				self.altUnitSpinBox:setValue(altMod)
			end
		end
		self.data.actionParams.altitude = altMod
	end
	
	AltAirDefense = {
		open = function(self, data)
			ActionParamHandler.open(self, data)   
			self.data.actionParams.alt_type = self.data.actionParams.alt_type or 1
			self.altUnitSpinBox:setUnitSystem(getUnits())	
		
			U.setComboboxValueById(self.altTypesComboList, self.data.actionParams.alt_type)

			self.altUnitSpinBox:setValue(self.data.actionParams.altitude or 0)
			
			if self.data.actionParams.altitude ~= nil then
				self.altitudeSpinBox:setEnabled(true)	
				self.altTypesComboList:setEnabled(true)	
				self.altitudeCheckBox:setState(true)	
			else
				self.altitudeSpinBox:setEnabled(false)
				self.altTypesComboList:setEnabled(false)
				self.altitudeCheckBox:setState(false)					
			end
		end,

		create = function(self, parent, line0)	
			local cdata = {
				altitude	= _('ALTITUDE'),
			}
		
			local left, top, width, height = parent.panel:getBounds()
			local box_w = width
			
			local panel = addPanel(parent.panel, 0, line0, 0, 1)
			parent.panel:insertWidget(panel)
			
			local altitudeCheckBox = widgetFactory.createCheckBox(nil, 0, 0, 30, U.widget_h)
			panel:insertWidget(altitudeCheckBox)
			
			panel:insertWidget(createStatic(cdata.altitude, 30, 0))
					
			local altitudeSpinBox = createSpinBox(0, 25000, 1, 1.7 * U.text_w, 0, 100, U.widget_h)
			altitudeSpinBox:setValue(150)
			panel:insertWidget(altitudeSpinBox)

			local distUnitLabel = createStatic(nil, 1.7 * U.text_w + 110, 0, 30, U.widget_h)
			panel:insertWidget(distUnitLabel)
			
			local altTypesComboList = widgetFactory.createComboList(1.7 * U.text_w + 140, 0, 50, U.widget_h)
			panel:insertWidget(altTypesComboList)
			
			local altTypeTable = {
				{name = _('MSL Above Mean Sea Level'),	itemId = 0},
				{name = _('AGL Above Ground Level'),	itemId = 1}
			}
			U.fillComboList2(altTypesComboList, altTypeTable)

			local altUnitSpinBox = U.createUnitSpinBox(distUnitLabel, altitudeSpinBox, U.altitudeUnits, 0, 25000)
			
			local instance = {
				parent				= parent,
				altUnitSpinBox		= altUnitSpinBox,
				altitudeSpinBox		= altitudeSpinBox,
				altTypesComboList	= altTypesComboList,
				altitudeCheckBox	= altitudeCheckBox,
				panel				= panel,
				onChange = function(self)
					
				end
			}
			
			self.__index = self
			base.setmetatable(instance, self)
			
			altTypesComboList.onChange = function(self)
				local tmpAlt = U.getAltitude(instance.data.actionParams.x, instance.data.actionParams.y)
				local item = self:getSelectedItem()
				local altMod = instance.data.actionParams.altitude or 0
				if item.itemId ~= instance.data.actionParams.alt_type then
					if item.itemId == 0 then
						altMod = altMod + tmpAlt
					else
						altMod = altMod - tmpAlt
					end	
				end
				instance.data.actionParams.alt_type = item.itemId 				
				instance.altUnitSpinBox:setValue(altMod)
				instance.data.actionParams.altitude = altMod
			end
			
			altitudeSpinBox.onChange = function(editBox)
				altEditBoxOnChange(instance)
				instance:onChange()
			end
			
			altitudeCheckBox.onChange = function(self)
				if self:getState() == true then
					instance.altitudeSpinBox:setEnabled(true)
					instance.altTypesComboList:setEnabled(true)
					instance.data.actionParams.altitude = 0
					instance.altUnitSpinBox:setValue(0)	
				else
					instance.altitudeSpinBox:setEnabled(false)
					instance.altTypesComboList:setEnabled(false)
					instance.data.actionParams.altitude = nil
					instance.altUnitSpinBox:setValue(0)	
				end
			end
			
			return instance				
		end,
		
		move = function(self, x, y)	
			if self.altitudeCheckBox:getState() == true then
				local altMod = self.altUnitSpinBox:getValue() or 0
				if self.data.actionParams.alt_type == 0 then
					local tmpAlt = U.getAltitude(self.data.actionParams.x, self.data.actionParams.y)
					if altMod < tmpAlt then
						altMod = tmpAlt
					end
				end
				self.altUnitSpinBox:setValue(altMod)
				self.data.actionParams.altitude = altMod
			else
				self.altUnitSpinBox:setValue(0)	
			end
		end,
		
		unitCoeff = 1
	}
	base.setmetatable(AltAirDefense, ActionParamHandler)
end


--Speed and altitude
do
	SpeedAndHeight = {
		open = function(self, data)
			ActionParamHandler.open(self, data)
			local unit = data.group.units[1]			
			local unitDesc = me_db_api.unit_by_type[unit.type]
			local minSpeed = data.group.type == 'plane' and 200.0 / 3.6 or 0.0
			local maxSpeed = unitDesc.MaxSpeed / 3.6
			self.speedUnitSpinBox:setUnitSystem(getUnits())
			self.speedUnitSpinBox:setRange(minSpeed, maxSpeed)			
			self.data.actionParams.speed = (self.data.actionParams.speedEdited and self.data.actionParams.speed) or base.math.min(maxSpeed, 1000 / 3.6) / 2			
			self.speedUnitSpinBox:setValue(base.math.floor(self.data.actionParams.speed + 0.5))

			local wpt = self.data.wpt or self.data.group.route.points[1]
			local wptAltitude = wpt.alt
			if wpt.alt_type == 'RADIO' then
				local Hrel = U.getAltitude(wpt.x, wpt.y)
				wptAltitude = wptAltitude + Hrel
			end			
			self.data.actionParams.altitude = (self.data.actionParams.altitudeEdited and self.data.actionParams.altitude) or wptAltitude
						
			self.altUnitSpinBox:setUnitSystem(getUnits())
			self.altUnitSpinBox:setRange(0, unitDesc.MaxHeight or 20000)	
			self.altUnitSpinBox:setValue(base.math.floor(self.data.actionParams.altitude + 0.5))
		end,
		create = function(self, parent, line0)
			
			local cdata = {
				speed		= _('SPEED'),
				altitude	= _('ALTITUDE'),
			}
			
			local left, top, width, height = parent.panel:getBounds()
			local box_w = width
			
			local panel = addPanel(parent.panel, 0, line0, 0, 2)
			local panelLines = addLines(panel, 1, 2)
			parent.panel:insertWidget(panel)
		
			panelLines[1]:insertWidget(createStatic(cdata.speed))
			
			local speedSpinBox = createSpinBox(1, 10, 1, 1.7 * U.text_w, 0, U.spin_long_w - 15, U.widget_h)
			panelLines[1]:insertWidget(speedSpinBox)
			
			local speedUnitsLabel = createStatic(nil, 1.7 * U.text_w + U.spin_long_w - 15 + U.dist_w, 0, U.text_w, U.widget_h)
			panelLines[1]:insertWidget(speedUnitsLabel)
			
			local speedUnitSpinBox = U.createUnitSpinBox(speedUnitsLabel, speedSpinBox, U.speedUnits)
			
			panelLines[2]:insertWidget(createStatic(cdata.altitude))
			
			local altitudeSpinBox = createSpinBox(1, 10, 1, 1.7 * U.text_w, 0, U.spin_long_w - 15, U.widget_h)
			panelLines[2]:insertWidget(altitudeSpinBox)
			
			local altUnitsLabel = createStatic(nil, 1.7 * U.text_w + U.spin_long_w - 15 + U.dist_w, 0, U.text_w, U.widget_h)
			panelLines[2]:insertWidget(altUnitsLabel)
			
			local altUnitSpinBox = U.createUnitSpinBox(altUnitsLabel, altitudeSpinBox, U.altitudeUnits)
			
			local instance = {
				parent				= parent,
				speedUnitSpinBox	= speedUnitSpinBox,
				altUnitSpinBox		= altUnitSpinBox,
				panel				= panel
			}
			self.__index = self
			base.setmetatable(instance, self)
			
			function speedSpinBox.onChange()
				instance.data.actionParams.speed = speedUnitSpinBox:getValue()
				instance.data.actionParams.speedEdited = true
			end
			function altitudeSpinBox.onChange()
				instance.data.actionParams.altitude = altUnitSpinBox:getValue()
				instance.data.actionParams.altitudeEdited = true
				if instance.parent.onAltitudeChange ~= nil then
					instance.parent:onAltitudeChange()
				end				
			end			
			
			return instance				
		end
	}
	base.setmetatable(SpeedAndHeight, ActionParamHandler)
end

local function getMinDistToGroup(point, group)
	local minDist2 = 1E12
	for unitIndex, unit in base.pairs(group.units) do
		local dist2 = base.math.pow(unit.x - point.x, 2) + base.math.pow(unit.y - point.y, 2)
		if dist2 < minDist2 then
			minDist2 = dist2
		end
	end
	return base.math.sqrt(minDist2)
end

local function getTerrainLOS(point, group)
	for unitIndex, unit in base.pairs(group.units) do
		local tmpAlt = unit.alt
		if tmpAlt == nil then
			tmpAlt = U.getAltitude(unit.x, unit.y) 
		end
		if U.isVisible(point.x, point.alt, point.y, unit.x, tmpAlt + 2.0, unit.y) then
			return true
		end
	end
	return false
end


--EWR
do

	EWR = {
		open = function(self, data)
			ActionParamHandler.open(self, data)
				
			self:fillCallSignData(data)
		end,
		create = function(self, parent, line0)
			
			local left, top, width, height = parent.panel:getBounds()
			local box_w = width

			local nCountNum = 2
			local panel = addPanel(parent.panel, 0, line0, 0, nCountNum)
			local panelLines = addLines(panel, 1, nCountNum)
			parent.panel:insertWidget(panel)
			
			local instance = {
				parent				= parent,
				panel				= panel,
			}
			
			self:createCallSignData(panel, 1, instance)
			
			return instance				
		end,
		createCallSignData = function(self, parent, nFromLine, instance)
			local left, top, width, height = parent:getBounds()
			local box_w = width			
			
			local panel = addPanel(parent, 0, nFromLine, 0, 2)
			local panelLines = addLines(panel, 1, 2)
			parent:insertWidget(panel)
		
			local function getCallnames(group)
				local unitType = group.units[1].type
				return	me_db_api.db.getCallnames(group.boss.id, unitType) or		
						me_db_api.db.getUnitCallnames(group.boss.id, me_db_api.unit_by_type[unitType].attribute)	
			end
			
			local cdata = {
				callsign		= _('CALLSIGN'),
				number			= _('NUMBER')				
			}			
			
			local callsignStatic = createStatic(cdata.callsign)
			panelLines[1]:insertWidget(callsignStatic)
			
			local callsignComboList = widgetFactory.createComboList(1.7 * U.text_w, 0, box_w - 1.7 * U.text_w-U.dist_w - 5, U.widget_h)
			panelLines[1]:insertWidget(callsignComboList)
			
			local callsignEditBox = widgetFactory.createEditBox(1.7 * U.text_w, 0, box_w - 1.7 * U.text_w-U.dist_w - 5, U.widget_h)
			panelLines[1]:insertWidget(callsignEditBox)			
			
			local numberStatic = createStatic(cdata.number)
			panelLines[2]:insertWidget(numberStatic)		
			
			local numberSpin = widgetFactory.createSpinBox(1, 9, 1.7 * U.text_w, 0, 220, U.widget_h)
			panelLines[2]:insertWidget(numberSpin)
			
			instance.callsignComboList		= callsignComboList
			instance.callsignEditBox		= callsignEditBox
			instance.callsignStatic			= callsignStatic
			instance.numberStatic			= numberStatic
			instance.numberSpin				= numberSpin
			instance.panelLines				= panelLines
			
			function callsignComboList:onChange(item)
				instance.data.actionParams.callname = item.itemId.value
			end
			function callsignEditBox:onChange()
				instance.data.actionParams.callsign = base.tonumber(self:getText())
			end
			function numberSpin:onChange()
				instance.data.actionParams.number = self:getValue()
			end		

			self.__index = self
			base.setmetatable(instance, self)
			
			return instance
		end,
		fillCallSignData = function(self, data)
		
			local westernCountry = U.isWesternCountry(data.group.boss.name)
			
			self.callsignStatic:setVisible(westernCountry)
			self.numberStatic:setVisible(westernCountry)
			self.numberSpin:setVisible(westernCountry)
			self.callsignComboList:setVisible(westernCountry)
			self.callsignEditBox:setVisible(false)
					
			local function getCallnames(group)
				local unitType = group.units[1].type
				return	me_db_api.db.getCallnames(group.boss.id, unitType) or		
						me_db_api.db.getUnitCallnames(group.boss.id, me_db_api.unit_by_type[unitType].attribute)	
			end			
			
			if westernCountry then
				local callsigns = getCallnames(data.group)
				if callsigns then
					local callsignTable = {}
					for i, v in base.pairs(callsigns) do
						callsignTable[i] = { name = _(v.Name), value = v.WorldID }
					end
					U.fillComboList(self.callsignComboList, callsignTable)
					U.setComboBoxValue(self.callsignComboList, data.actionParams.callname)
				else
					self.callsignComboList:clear()							
				end
				
				if data.actionParams.number == nil then
					data.actionParams.number = 1
				end
				if data.actionParams.callname == nil then
					data.actionParams.callname = 1
				end
				
				self.numberSpin:setValue(data.actionParams.number)
			end
			
		end,
	}
	base.setmetatable(EWR, ActionParamHandler)
end






--FAC: target designation method and datalink usage
do
	local designation = {
		no			= 'No',
		auto		= 'Auto',
		WP			= 'WP',
		IrPointer	= 'IR-Pointer',
		laser		= 'Laser',
        WPLaser     = 'WP+Laser',
	}

	FAC = {
		open = function(self, data, targetGroup, bcreateDataLink)
			ActionParamHandler.open(self, data)
			
			self.data.actionParams.designation = self.data.actionParams.designation or designation.auto
			if self.data.actionParams.datalink == nil then 
				self.data.actionParams.datalink = true
			end
		
			self:setGroup(targetGroup)
			U.setComboBoxValue(self.designationComboList, self.data.actionParams.designation)
			
			if self.data.actionParams.designation == designation.laser or self.data.actionParams.designation == designation.WPLaser then
				self.laserCodeEditBox:setVisible(true)
				self.laserCodeStatic:setVisible(true)				
				self.data.actionParams.laserCode = self.data.actionParams.laserCode or 1688
				self.laserCodeEditBox:setValue(self.data.actionParams.laserCode)
			else
				self.laserCodeEditBox:setVisible(false)
				self.laserCodeStatic:setVisible(false)
				self.data.actionParams.laserCode = nil
			end
			self.datalinkCheckBox:setState(self.data.actionParams.datalink)
				
			self:fillCallSignData(data, targetGroup)
		end,
		create = function(self, parent, line0, bcreateDataLink)
			
			local cdata = {
				designation		= _('DESIGNATION'),
				laserCode		= _('LASER CODE'),
				datalink		= _('DATALINK'),
			}
			
			local left, top, width, height = parent.panel:getBounds()
			local box_w = width

			local nCountNum = 5
			if bcreateDataLink then
				nCountNum = 7
			end
			local panel = addPanel(parent.panel, 0, line0, 0, nCountNum)
			local panelLines = addLines(panel, 1, nCountNum)
			parent.panel:insertWidget(panel)
			
			local instance = {
				parent				= parent,
				designationComboList	= designationComboList,
				datalinkCheckBox	= datalinkCheckBox,				
				panel				= panel,
			}
			
		
			panelLines[1]:insertWidget(createStatic(cdata.designation))

			local designationComboList = widgetFactory.createComboList(1.7 * U.text_w, 0, 220, U.widget_h)
			panelLines[1]:insertWidget(designationComboList)	

			local laserCodeStatic = createStatic(cdata.laserCode)
			laserCodeStatic:setVisible(false)
			panelLines[2]:insertWidget(laserCodeStatic)
			local laserCodeEditBox = widgetFactory.createSpinBox(0, 9999, 1.7 * U.text_w, 0, 85, U.widget_h)
			laserCodeEditBox:setVisible(false)
			panelLines[2]:insertWidget(laserCodeEditBox)
			
			panelLines[3]:insertWidget(createStatic(cdata.datalink))
			
			local datalinkCheckBox = widgetFactory.createCheckBox(nil, 1.7 * U.text_w, 0, 18, U.widget_h)
			panelLines[3]:insertWidget(datalinkCheckBox)
				
			instance.designationComboList	= designationComboList
			instance.laserCodeStatic = laserCodeStatic
			instance.laserCodeEditBox = laserCodeEditBox
			instance.datalinkCheckBox	= datalinkCheckBox
			if bcreateDataLink then
				self:createCallSignData(panel, 4, instance)
			else
				self:createCallSignData(panel, 1, instance)
			end
				
			function visibleLaserCode()
				if instance.data.actionParams.designation == designation.laser 
					or instance.data.actionParams.designation == designation.WPLaser then
					instance.laserCodeEditBox:setVisible(true)
					instance.laserCodeStatic:setVisible(true)
					instance.data.actionParams.laserCode = instance.data.actionParams.laserCode or 1688
					laserCodeEditBox:setValue(instance.data.actionParams.laserCode)
				else
					instance.laserCodeEditBox:setVisible(false)
					instance.laserCodeStatic:setVisible(false)
					instance.data.actionParams.laserCode = nil
				end
			end
			
			function designationComboList.onChange(comboList, item)
				instance.data.actionParams.designation = item.itemId.value	
				--base.U.traverseTable(item,2)
				visibleLaserCode()
			end
			function laserCodeEditBox:onChange()
				instance.data.actionParams.laserCode = laserCodeEditBox:getValue()
			end
			function datalinkCheckBox.onChange(checkBox)
				instance.data.actionParams.datalink = datalinkCheckBox:getState()			
			end
			
			return instance				
		end,
		setGroup = function(self, targetGroup)
			--Designation methods
			local facUnit = self.data.wpt or self.data.group.route.points[1]
			local facPoint = {x = facUnit.x, y = facUnit.y}
			local minDist = targetGroup ~= nil and getMinDistToGroup(facPoint, targetGroup) or 0.0
			
			local point = {
				x = facUnit.x,
				alt = base.math.max(facUnit.alt, U.getAltitude(facUnit.x, facUnit.y) + 2.0),
				y = facUnit.y
			}

			local LOS = true
			if targetGroup ~= nil then
				LOS = getTerrainLOS(point, targetGroup)
			end
		
			local designationMethodItems = {
				{ name = _('No'),	value = designation.no },
				{ name = _('Auto'),	value = designation.auto }
			}

			local methods = {
				{ name = _('WP'), 			value = designation.WP, 		maxDist = 15500},
				{ name = _('IR-Pointer'),	value = designation.IrPointer,	maxDist = 5000 },
				{ name = _('Laser'),		value = designation.laser,		maxDist = 10000 },
                { name = _('WP-Laser'),		value = designation.WPLaser,	maxDist = 15500 },

			}
			
			for methodIndex, method in base.pairs(methods) do
				local item = { name = method.name, value = method.value }				
				if not LOS or minDist > method.maxDist then
					item.name = item.name.._(' (problem: ')
					if not LOS then
						item.name = item.name.._('no LOS')
					end
					if minDist > method.maxDist then
						if not LOS then
							item.name = item.name..', '
						end
						local distanceUnits = U.distanceUnits[getUnits()]
						item.name = item.name.._('D > ')..base.tostring(base.math.floor(method.maxDist * distanceUnits.coeff + 0.5))..' '..distanceUnits.name						
					end
					item.name = item.name..')'
					item.skin = problemValueComboListItemSkin
				end
				base.table.insert(designationMethodItems, item)
			end
			U.fillComboList(self.designationComboList, designationMethodItems)
			if U.setComboBoxValue(self.designationComboList, self.data.actionParams.designation) == false then
				self.designationComboList:selectItem(self.designationComboList:getItem(0))
			end
			local item = self.designationComboList:getSelectedItem()
			self.data.actionParams.designation = item.itemId.value	
			visibleLaserCode()
		end,
		createCallSignData = function(self, parent, nFromLine, instance)
			local left, top, width, height = parent:getBounds()
			local box_w = width			
			
			local panel = addPanel(parent, 0, nFromLine, 0, 4)
			local panelLines = addLines(panel, 1, 4)
			parent:insertWidget(panel)
		
			local function getCallnames(group)
				local unitType = group.units[1].type
				return	me_db_api.db.getCallnames(group.boss.id, unitType) or		
						me_db_api.db.getUnitCallnames(group.boss.id, me_db_api.unit_by_type[unitType].attribute)	
			end
			
			local cdata = {
				callsign		= _('CALLSIGN'),
				number			= _('NUMBER'),
				frequency 		= _('FREQUENCY'),
				modulation		= _('MODULATION'),
				MHz				= _('MHz')				
			}			
			
			panelLines[1]:insertWidget(createStatic(cdata.callsign))
			
			local callsignComboList = widgetFactory.createComboList(1.7 * U.text_w, 0, 220, U.widget_h)
			panelLines[1]:insertWidget(callsignComboList)
			
			local callsignEditBox = widgetFactory.createEditBox(1.7 * U.text_w, 0, 220, U.widget_h)
			panelLines[1]:insertWidget(callsignEditBox)			
			
			panelLines[2]:insertWidget(createStatic(cdata.number))		
			
			local numberSpin = widgetFactory.createSpinBox(1, 9, 1.7 * U.text_w, 0, 220, U.widget_h)
			panelLines[2]:insertWidget(numberSpin)
			
			panelLines[3]:insertWidget(createStatic(cdata.frequency))
			
			local freqEditBox = widgetFactory.createEditBox(1.7 * U.text_w, 0, box_w - 2.2 * U.text_w-U.dist_w - 5, U.widget_h)
			panelLines[3]:insertWidget(freqEditBox)
			
			panelLines[3]:insertWidget(createStatic(cdata.MHz, box_w - 0.5 * U.text_w-U.dist_w, 0, U.text_w, U.widget_h))
			
			panelLines[4]:insertWidget(createStatic(cdata.modulation))
			
			local modulationTypeTable = {
				{name = _('AM'),	value = 0},
				{name = _('FM'),	value = 1}
			}
			
			local modulationComboList = widgetFactory.createComboList(1.7 * U.text_w, 0, 220, U.widget_h)
			U.fillComboList(modulationComboList, modulationTypeTable)
			panelLines[4]:insertWidget(modulationComboList)
			
			instance.callsignComboList		= callsignComboList
			instance.callsignEditBox		= callsignEditBox
			instance.numberSpin				= numberSpin
			instance.freqEditBox			= freqEditBox
			instance.modulationComboList 	= modulationComboList
			instance.panelLines				= panelLines
			
			
			
			function callsignComboList:onChange(item)
				instance.data.actionParams.callname = item.itemId.value
			end
			function callsignEditBox:onChange()
				instance.data.actionParams.callsign = base.tonumber(self:getText())
			end
			function numberSpin:onChange()
				instance.data.actionParams.number = self:getValue()
			end		
			function freqEditBox:onChange()
				local freq = base.tonumber(self:getText())
				instance.data.actionParams.frequency = (freq or 0.0) * 1000000.0
			end
			function modulationComboList:onChange(item)
				instance.data.actionParams.modulation = item.itemId.value
			end
			self.__index = self
			base.setmetatable(instance, self)
			
			return instance
		end,
		fillCallSignData = function(self, data, targetGroup)
		
			local westernCountry = U.isWesternCountry(data.group.boss.name)
				
			self.callsignComboList:setVisible(westernCountry)
			self.callsignEditBox:setVisible(not westernCountry)	
			self.panelLines[4]:setVisible(westernCountry)
					
			local function getCallnames(group)
				local unitType = group.units[1].type
				return	me_db_api.db.getCallnames(group.boss.id, unitType) or		
						me_db_api.db.getUnitCallnames(group.boss.id, me_db_api.unit_by_type[unitType].attribute)	
			end			
			
			if westernCountry then
				local callsigns = getCallnames(data.group)
				if callsigns then
					local callsignTable = {}
					for i, v in base.pairs(callsigns) do
						callsignTable[i] = { name = _(v.Name), value = v.WorldID }
					end
					U.fillComboList(self.callsignComboList, callsignTable)
					U.setComboBoxValue(self.callsignComboList, data.actionParams.callname)
				else
					self.callsignComboList:clear()							
				end
				
				if data.actionParams.number == nil then
					data.actionParams.number = 1
				end
				if data.actionParams.callname == nil then
					data.actionParams.callname = 1
				end
				
				self.numberSpin:setValue(data.actionParams.number)
			else
				data.actionParams.callsign = 1
				self.callsignEditBox:setText(data.actionParams.callsign)						
			end

			if data.actionParams.frequency == nil then
				data.actionParams.frequency	= 133000000.0
			end
			if data.actionParams.modulation == nil then
				data.actionParams.modulation = 0
			end
			
			self.freqEditBox:setText(data.actionParams.frequency / 1000000.0)
			U.setComboBoxValue(self.modulationComboList, data.actionParams.modulation)
			
		end,
	}
	base.setmetatable(FAC, ActionParamHandler)
end

--Position3D
do
	local axes = { x = 'x', y = 'y', z = 'z' }	
	
	Position3D = {
		open = function(self, data)
			ActionParamHandler.open(self, data)			
			for axis, name in base.pairs(axes)  do
				self.posSpinBox[name]:setUnitSystem(getUnits())
				self.posSpinBox[name]:setValue(data.actionParams.pos[name])
			end
		end,
		create = function(self, parent, line0)
			local posSpinBox = {}
			local cdata = {
				position = _('POSITION'),
				axes = axes,
			}
			
			local left, top, width, height = parent.panel:getBounds()
			
			local panel = addPanel(parent.panel, 0, line0, 0, 3)
			local panelLines = addLines(panel, 1, 3)
			parent.panel:insertWidget(panel)

			panelLines[1]:insertWidget(createStatic(cdata.position))
			
			local axisLableWith = U.text_w + 40
			local spinBox = {}
			
			--x
			panelLines[1]:insertWidget(createStatic(_("Distance")..':', 1.7 * U.text_w, 0, axisLableWith, U.widget_h))
			
			spinBox.x = createSpinBox(-400000, 40000, 50, getLineRight(panelLines[1]) + U.dist_w, 0, U.spin_w, U.widget_h)
			panelLines[1]:insertWidget(spinBox.x)
            
            local unitsLabelX = createStatic(nil, getLineRight(panelLines[1]) + U.dist_w, 0, U.text_w / 3, U.widget_h)
			panelLines[1]:insertWidget(unitsLabelX)
			
            --y
			panelLines[2]:insertWidget(createStatic(_("Elevation")..':', 1.7 * U.text_w, 0, axisLableWith, U.widget_h))
			
			spinBox.y = createSpinBox(-10000, 10000, 10, getLineRight(panelLines[2]) + U.dist_w, 0, U.spin_w, U.widget_h)
			panelLines[2]:insertWidget(spinBox.y)
            
            local unitsLabelY = createStatic(nil, getLineRight(panelLines[2]) + U.dist_w, 0, U.text_w / 3, U.widget_h)
			panelLines[2]:insertWidget(unitsLabelY)
            
			--z
			panelLines[3]:insertWidget(createStatic(_("Interval")..':', 1.7 * U.text_w, 0, axisLableWith, U.widget_h))
			
			spinBox.z = createSpinBox(-400000, 40000, 50, getLineRight(panelLines[3]) + U.dist_w, 0, U.spin_w, U.widget_h)
			panelLines[3]:insertWidget(spinBox.z)

			local unitsLabelZ = createStatic(nil, getLineRight(panelLines[3]) + U.dist_w, 0, U.text_w / 3, U.widget_h)
			panelLines[3]:insertWidget(unitsLabelZ)			
			
			posSpinBox.x = U.createUnitSpinBox(unitsLabelX, spinBox.x, U.altitudeUnits, -400000, 40000)
			posSpinBox.y = U.createUnitSpinBox(unitsLabelY, spinBox.y, U.altitudeUnits, -400000, 40000)
			posSpinBox.z = U.createUnitSpinBox(unitsLabelZ, spinBox.z, U.altitudeUnits, -400000, 40000)		
		
			local instance = {
				parent				= parent,
				posSpinBox			= posSpinBox,
				panel				= panel
			}
			self.__index = self
			base.setmetatable(instance, self)
			
			spinBox.x.onChange = function(self)
				instance.data.actionParams.pos[axes.x] = posSpinBox.x:getValue()
			end
			spinBox.y.onChange = function(self)
				instance.data.actionParams.pos[axes.y] = posSpinBox.y:getValue()
			end			
			spinBox.z.onChange = function(self)
				instance.data.actionParams.pos[axes.z] = posSpinBox.z:getValue()
			end
			
			return instance				
		end
	}
	base.setmetatable(Position3D, ActionParamHandler)
end

--Tipes avalible on map - для выбора транспорта при транспортировке
do
	local cdata = {
		vehicleType				= _('VEHICLE TYPE'),
		zoneRadius				= _('ZONE RADIUS'),
		bindingToTransport		= _('Binding to transport'),
		mapSmokePoint			= _('Marking the point of landing'),
	}
		
	--панель содания типов и юнитов транспорта, доступных для погрузки текущей группы пехоты
	AvalibleTipes={
		create=function(self, parent, line0)
			local left, top, width, height = parent.panel:getBounds()
			local box_w = width
		
			local panel = addPanel(parent.panel, 0, line0, 0, 2)
			local lines = addLines(panel, 1, 2)
			parent.panel:insertWidget(panel)
			
			lines[1]:insertWidget(createStatic(cdata.vehicleType, 0, 0, 1.6 * U.text_w, U.widget_h))
			
			local transportTypeCombo = widgetFactory.createComboList(1.7 * U.text_w, 0, box_w*0.5, U.widget_h)
			
			lines[1]:insertWidget(transportTypeCombo)
			
			local instance = {
				parent			= parent,
				transportTypeCombo	= transportTypeCombo,
				panel			= panel
			}
			self.__index = self
			base.setmetatable(instance, self)
			
			function transportTypeCombo:onChange(item)                
				local typeDescription=me_db_api.unit_by_type[transportTypeCombo:getSelectedItem().type] or transportTypeCombo:getSelectedItem().type
				parent.data.actionParams.selectedType=typeDescription.type or typeDescription				
			end			
			
			return instance			
		end,
		open = function(self, data)--открытие панели
			--возввращает истину если в описании типа присутствует требуемуе поле и находится
			--в заданом диопазоне
			
			--проверка на возможность погрузки юнитов в транспорт. передаются их описания
			local bool function unitTypeTranportFilter(transportDescription,unitsDescription)
				if transportDescription==nil or unitsDescription==nil
				then
					return false 
				end
				if transportDescription['InternalCargo']==nil
				then 
					return false 
				end
				for k,v in base.pairs(unitsDescription) do
					if v['Transportable']==nil
					then
						return false 
					end
					--тут проверки на всякие вместимости
				end
				
				return true
			end
			
			--делает активным элемент comboList с текстом selectedText
			local function autoSelect(comboList,selectedText)
				for i=0,comboList:getItemCount()-1,1  
				do
					local item=comboList:getItem(i)
					if item:getText()==selectedText
					then
						comboList:selectItem(comboList:getItem(i))
						break
					end
				end
			end
			
			--для всех юнитов на карте выписываю их типы
			local totalTypes={}--спиок типов
			local types={}--упорядоченный список типов
			
			--создание массива транспортных типов
			i=1
			
			local groupUnits={}

			for k,v in base.pairs(data.group.units) do
				local unitDescription = me_db_api.unit_by_type[v.type]
				groupUnits[v.type] = unitDescription
			end
			
			for k,v in base.pairs(base.module_mission.unit_by_id) do
				if totalTypes[v.type] == nil and 
					unitTypeTranportFilter(me_db_api.unit_by_type[v.type],groupUnits) and
					v.boss.boss.boss.name == data.group.boss.boss.name
				then
					totalTypes[v.type]=i
					i = i+1
				end
			end		
            
			--упорядочивание транспортных типов
			for k,v in base.pairs(totalTypes) do
				types[v]=k
			end
			
			ActionParamHandler.open(self, data)--чтение данных
			            
			--заполнение типов транспортов
			fill_combo_list_types(self.transportTypeCombo,types)
			local unitDescription = me_db_api.unit_by_type[data.actionParams.selectedType]
			if unitDescription then	
				autoSelect(self.transportTypeCombo,unitDescription.DisplayName)	
			end
		end
	}
end

--Groups for embarking - для выбора групп при транспортировке
do	
	local cdata = {
		duration				= _('ON LAND', 'ON LAND'),
		distribution			= _('Distribution'),
		toMuchGroup 			= _('The total weight of the groups is too heavy:'),
		transportingImpossible	= _('The transporting is impossible.'),
		warning				    = _('WARNING'),
		ok						= _('OK'),
		totalSize				= _('Total size'),
		curSize					= _('Current size'),
		start					= _('From start'),	
	}
	
	GroupsForEmbarking={
		--расчет массы которую можно погрузить в транспорт
		getTransportMass = function(self,transport)
			local mass=0
			if transport then
				mass=me_db_api.unit_by_type[transport.type].M_empty
				for k,v in base.pairs(transport.payload) do
					if base.type(v)=='number' and k~='gun' and k~='chaff' then
						mass = mass + v
					end
				end
				for k,v in base.pairs(transport.payload.pylons) do
					mass = mass + loadOutUtils.getLauncherWeight(v.CLSID)
				end
			end
			return mass
		end,
		--суммарная масса группы
		getTransportableGroupMass = function(self, groupId)
			local group = base.module_mission.group_by_id[groupId]
			local mass = 0
			
			if group then
				for k,v in base.pairs(group.units) do
					if me_db_api.unit_by_type[v.type].Transportable then
                        local unit = me_db_api.unit_by_type[v.type]
                        if unit then	
                            mass = mass + unit.chassis.mass
                        end
					end
				end
			end
			return mass
		end,
		--суммарная масса нескольких групп
		getGroupsMass = function(self, groupsId)
			local groupsMass = 0
			for	k,v in base.pairs(groupsId) do
				groupsMass = groupsMass + GroupsForEmbarking:getTransportableGroupMass(v)
			end
			return groupsMass
		end,
		--получить доступную массу для погрузки
		getTransportPassengersMaxMass = function(self,transport)
			local maxMass = me_db_api.unit_by_type[transport.type].M_max
			local currentMass = GroupsForEmbarking:getTransportMass(transport)
			return maxMass-currentMass
		end,
		--получить пару значений - массу группы и возможный вес груза вертолета
		getWeightsGroupsAndAvalibleWeights = function(self,transport, groupsId)
			local groupsMass = GroupsForEmbarking:getGroupsMass(groupsId)
			local transportPassengersMass = GroupsForEmbarking:getTransportPassengersMaxMass(transport)
			return groupsMass, transportPassengersMass
		end,
		--проверка на возможность погрузить в транспорт список групп
		isTransportAvalibleForGroupsByWheight = function(self, transport, groupsId)
			local groupsMass, transportPassengersMass = GroupsForEmbarking:getWeightsGroupsAndAvalibleWeights(transport, groupsId)
			if groupsMass>transportPassengersMass then return true else return false end
		end,
		--предупреждение о превышении массы множества групп
		testAndShowMessage = function(self, transport, groupsId)
			if GroupsForEmbarking:isTransportAvalibleForGroupsByWheight(transport, groupsId) then
				local groupsMass, transportPassengersMass = GroupsForEmbarking:getWeightsGroupsAndAvalibleWeights(transport, groupsId)
				local messageText = cdata.toMuchGroup .. 
									' ' .. base.tostring(groupsMass) .. 
									' / ' .. base.tostring(transportPassengersMass) .. 
									' ' .. cdata.transportingImpossible
				local message = MsgWindow.question(messageText, cdata.warning, cdata.ok)
				message:show()
			end
		end,
		--получить максимально загруженную задачу погрузки транспорта
		getMaxWieghtOfAllTasks = function(self,transport)
			
			local maxWheight=0;
			
			if transport then
				local group = transport.boss
				local tasks = base.U.isEnableTask(group.route.points,'Embarking')
				if tasks then
					for k,task in base.pairs(tasks) do
						if task and task.params and task.params.distribution then
							local curWheight = 0
							if task.params.distribution[transport.unitId] 
							then 
								curWheight = GroupsForEmbarking:getGroupsMass(task.params.distribution[transport.unitId]) 
							end
							maxWheight = base.math.max(curWheight,maxWheight)
						end
					end
				end
			end
			
			return maxWheight
		end,
		--получить объем группы при транспортировке
		getTransportableGroupSize = function(self, groupId)
			local group = base.module_mission.group_by_id[groupId]
			local size = 0
			
			if group then
				for k,v in base.pairs(group.units) do
					if me_db_api.unit_by_type[v.type].Transportable then
						size = size + me_db_api.unit_by_type[v.type].Transportable.size
					end
				end
			end
			return size
		end,
		--получить вместимость транспорта
		getTransportCapacity = function(self,unitId)
			local _type = base.module_mission.unit_by_id[unitId].type
			local transportType = me_db_api.unit_by_type[_type]
			if transportType.InternalCargo then
				return transportType.InternalCargo.nominalCapacity
			else
				return 0
			end
		end,
		-- получить суммарный объем группы пехоты
		getGroupsSize = function(self, groupsId)
			local groupsSize = 0
			if groupsId then
				for	k,v in base.pairs(groupsId) do
					groupsSize = groupsSize + GroupsForEmbarking:getTransportableGroupSize(v)					
				end
			end
			return groupsSize
		end,
		-- обновить текст с текущей массой групп
		updateCurrentSizeText = function(self, data, widget, widgetUnit)
			local groupsSize=0
			local transportPassengersSize=0
			
			local groupsSizeCur=0
			local transportPassengersSizeCur=0

			if data.group then
				for i, unit in base.pairs(data.group.units)do
					if data.actionParams.distributionFlag then
						transportPassengersSizeCur = GroupsForEmbarking:getTransportCapacity(data.actionParams.selectedTransport)					
					else
						transportPassengersSizeCur = transportPassengersSizeCur + GroupsForEmbarking:getTransportCapacity(unit.unitId)		
					end	
					transportPassengersSize = transportPassengersSize + GroupsForEmbarking:getTransportCapacity(unit.unitId)
				end
				
				local idInTransport = {}
				for kk, wpt in base.ipairs(data.group.route.points) do
					if data.wpt and kk > data.wpt.index then
						break
					end
										
					for kkk, wptTask in base.ipairs(wpt.task.params.tasks) do
						if wptTask.id == "Embarking" then
							if data.actionParams.distributionFlag then								
								--groupsSizeCur = groupsSizeCur + GroupsForEmbarking:getGroupsSize(wptTask.params.distribution[data.actionParams.selectedTransport] or 0)
								if wptTask.params.distribution[data.actionParams.selectedTransport] then
									for tmp, groupId in base.pairs(wptTask.params.distribution[data.actionParams.selectedTransport]) do
										idInTransport[groupId] = groupId
									end
								end
							else
								for k,groupId in base.pairs(wptTask.params.groupsForEmbarking) do									
									--groupsSizeCur = groupsSizeCur + GroupsForEmbarking:getGroupsSize(v)
									idInTransport[groupId] = groupId
								end
							end	
							groupsSize = groupsSize + GroupsForEmbarking:getGroupsSize(wptTask.params.groupsForEmbarking)	
						end
						
						if wptTask.id == "Disembarking" then
							--[[for k,v in base.pairs(wptTask.params.distribution) do									
								groupsSizeCur = groupsSizeCur - GroupsForEmbarking:getGroupsSize(v)
							end]]
							for k,groupId in base.pairs(wptTask.params.groupsForEmbarking) do
								idInTransport[groupId] = nil
							end
							groupsSize = groupsSize - GroupsForEmbarking:getGroupsSize(wptTask.params.groupsForEmbarking)
						end
												
					end						
				end
				groupsSizeCur = groupsSizeCur + GroupsForEmbarking:getGroupsSize(idInTransport)				
			end				
						
			groupsSize = groupsSize / 100
			transportPassengersSize = transportPassengersSize / 100

			groupsSizeCur = groupsSizeCur / 100
			transportPassengersSizeCur = transportPassengersSizeCur / 100
			
			if #data.group.units > 1 and data.actionParams.distributionFlag then
				widgetUnit:setVisible(true)
			else
				widgetUnit:setVisible(false)
			end
			
			avalibleWeightText = cdata.totalSize .. ' ' .. base.tostring(groupsSize) .. ' / ' .. base.tostring(transportPassengersSize)
			widget:setText(avalibleWeightText)
			avalibleWeightUnitText = cdata.curSize .. ' ' .. base.tostring(groupsSizeCur) .. ' / ' .. base.tostring(transportPassengersSizeCur)
			widgetUnit:setText(avalibleWeightUnitText)
		end,
		--сортировка транспортов по вместительности от большего к меньшему
		sortKeys = function(self, tbl)
			local orderedKeys = {}
			
			local pseudo = {}
			
			base.U.copyTable(pseudo,tbl)
			
			local length = base.U.getTableSize(tbl)
			
			while length>0 do
				local maxKey
				local maxSize
				for k,v in base.pairs(pseudo) do
					if maxKey then
						if v > maxSize then maxSize = v maxKey = k end
					else
						maxSize = v 
						maxKey = k 
					end
				end
				pseudo[maxKey] = nil
				length = length-1
				base.table.insert(orderedKeys,maxKey)
			end
			
			return orderedKeys
		end,
		
		--перестроить распределение групп по вертолетам
		rebuildDistribution = function(self, data)
			
			data.actionParams.distribution = {}
			
			local occupancy = {}
			local capacitys = {}
			local sizes = {}
			local orderedGroups = {}
			local orderedTransports = {}
			
			for k,t in base.pairs(data.group.units) do
				capacitys[t.unitId] = GroupsForEmbarking:getTransportCapacity(t.unitId)
				occupancy[t.unitId] = 0
				data.actionParams.distribution[t.unitId] = {}
			end
			
			for k,p in base.pairs(data.actionParams.groupsForEmbarking) do
				sizes[k] = GroupsForEmbarking:getTransportableGroupSize(p)
			end
			
			orderedGroups = GroupsForEmbarking:sortKeys(sizes)
			orderedTransports = GroupsForEmbarking:sortKeys(capacitys)
						
			for n,k in base.pairs(orderedGroups) do
				local ct = orderedTransports[1]
				for j,i in base.pairs(orderedTransports) do
					if occupancy[i] + sizes[k] < capacitys[i]*0.8 then 
						ct = i break 
					end
					if occupancy[ct] - capacitys[ct] > occupancy[i] - capacitys[i] then ct = i end
				end
				occupancy[ct] = occupancy[ct] + sizes[k]
				data.actionParams.distribution[ct][k] = data.actionParams.groupsForEmbarking[k]
			end
			
		end,
		--обновить список возможных к погрузке групп солдат
		refreshGroupsList = function(self, data, unitForEmbarkingListBox)
			unitForEmbarkingListBox:clear()			
			local groupsId = data.actionParams.groupsForEmbarking
			
			if data.actionParams.distributionFlag then
				local transportId = 0
				if data.actionParams.selectedTransport then 
					transportId = data.actionParams.selectedTransport
				end
				groupsId = data.actionParams.distribution[transportId]
				if groupsId then
					local newTable = {}
					for _index, _groupId in base.pairs(groupsId) do
						base.table.insert(newTable, _groupId)						
					end
					groupsId = newTable
				end
			end
			
			if groupsId then
				for key,id in base.ipairs(groupsId) do
					local name = base.module_mission.group_by_id[id].name
					item = widgetFactory.createListBoxItem(name, 0, 0, 5 * U.text_w, U.widget_h)
					item.groupId = id
					unitForEmbarkingListBox:insertItem(item)
				end
			end
		end,
		--
		addGroup = function(self,data,groupId)
			GroupsForEmbarking:removeGroup(data,groupId)
		
			base.table.insert(data.actionParams.groupsForEmbarking, groupId)
			
			if data.actionParams.selectedTransport then
				if data.actionParams.distribution[data.actionParams.selectedTransport] then
					base.table.insert(data.actionParams.distribution[data.actionParams.selectedTransport], groupId)	
				else
					data.actionParams.distribution[data.actionParams.selectedTransport] = {}
					base.table.insert(data.actionParams.distribution[data.actionParams.selectedTransport], groupId)	
				end
			else
				GroupsForEmbarking:rebuildDistribution(data)
			end
		end,
		
		removeGroup = function(self,data,groupId)
			for k,v in base.pairs(data.actionParams.distribution) do
				for i,p in base.pairs(v) do
					if p == groupId then v[i]=nil break end
				end
			end
			for k,v in base.pairs(data.actionParams.groupsForEmbarking) do
				if v == groupId then
					base.table.remove(data.actionParams.groupsForEmbarking, k)
					break
				end
			end
		end,
		
		checkGroups = function(self,data)
			local size = base.U.getTableSize(data.actionParams.distribution)
			for k,v in base.pairs(data.group.units) do
				if data.actionParams.distribution[v.unitId] then size = size - 1 end
			end
			return size == 0
		end,
		
		create=function(self,parent,linesNumber)
			
			local left, top, width, height = parent.panel:getBounds()
			local box_w = width
			
			local panel = addPanel(parent.panel, 0, 1, 0, linesNumber)
			local lines = addLines(panel, 1, linesNumber)
			
			local durationCheckBox = widgetFactory.createCheckBox(cdata.duration, 0, 0, 2.5 * U.text_w, U.widget_h)
			lines[1]:insertWidget(durationCheckBox)
			
			local durationPanel = U.create_time_panel()
			durationPanel:setBounds(2.7 * U.text_w, 0, width - 1.7 * U.text_w, U.widget_h)
			durationPanel:setTime(5 * 60)
			lines[1]:insertWidget(durationPanel)
			
			local distributionCheckBox = widgetFactory.createCheckBox(cdata.distribution, 0, 0, 2 * U.text_w, U.widget_h)
			local distributionComboList = widgetFactory.createComboList(2 * U.text_w, 0, box_w*0.6, U.widget_h)
			lines[2]:insertWidget(distributionCheckBox)
			lines[2]:insertWidget(distributionComboList)
						
			local startCheckBox = widgetFactory.createCheckBox(cdata.start, 0, 0, 2 * U.text_w, U.widget_h)
			lines[3]:insertWidget(startCheckBox)
			
			local groupsComboList = widgetFactory.createComboList(0, 0, box_w*0.6, U.widget_h)
			lines[4]:insertWidget(groupsComboList)
			
			local addGroupButton = widgetFactory.createButton(_('ADD'),0,0,box_w*0.3,U.widget_h)
			lines[5]:insertWidget(addGroupButton)
			
			local removeGroupButton = widgetFactory.createButton(_('REMOVE'),box_w*0.4,0,box_w*0.3,U.widget_h)
			lines[5]:insertWidget(removeGroupButton)
			
			local avalibleWeight = widgetFactory.createStatic(cdata.totalWeight, 0, 0, box_w*0.5-10, U.widget_h)
			lines[6]:insertWidget(avalibleWeight)
			
			local avalibleWeightUnit = widgetFactory.createStatic(cdata.unitWeight, 150, 0, box_w*0.5-10, U.widget_h)
			lines[6]:insertWidget(avalibleWeightUnit)
			
			local unitForEmbarkingListBox = widgetFactory.createListBox(0, U.widget_h *7, 5 * U.text_w, (6)*U.widget_h)
			panel:insertWidget(unitForEmbarkingListBox)
			
			function startCheckBox.onChange(theCheckBox)
				parent.data.actionParams.onStartMission = theCheckBox:getState()
			end
			
			function durationPanel:onChange()
				parent.data.actionParams.duration = self:getTime()
			end
			
			function durationCheckBox:onChange()
				parent.data.actionParams.durationFlag = self:getState()
				durationPanel:setEnabled(parent.data.actionParams.durationFlag)
			end
			
			function distributionComboList:onChange(self)
				if distributionComboList:getText() then parent.data.actionParams.selectedTransport = base.module_mission.unit_by_name[distributionComboList:getText()].unitId end
				GroupsForEmbarking:refreshGroupsList(parent.data, unitForEmbarkingListBox)
				GroupsForEmbarking:updateCurrentSizeText(parent.data,avalibleWeight,avalibleWeightUnit)
			end
			
			function distributionCheckBox:onChange()
				parent.data.actionParams.distributionFlag = self:getState()
				distributionComboList:setVisible(parent.data.actionParams.distributionFlag)
				local item
				if parent.data.actionParams.distributionFlag then
					item = distributionComboList:getItem(0)
				end
				
				local groupsId
				if parent.data.actionParams.distributionFlag then 
					GroupsForEmbarking:rebuildDistribution(parent.data)
					distributionComboList:selectItem(item)
					distributionComboList:onChange()
				else
					GroupsForEmbarking:refreshGroupsList( parent.data, unitForEmbarkingListBox)
				end
				
				GroupsForEmbarking:updateCurrentSizeText(parent.data,avalibleWeight,avalibleWeightUnit)
			end
			
			function addGroupButton:onChange()
				local item = groupsComboList:getSelectedItem()
				if item then
					local text = item:getText()
					local id = item.groupId
					
					GroupsForEmbarking:addGroup(parent.data,id)
					GroupsForEmbarking:refreshGroupsList(parent.data,unitForEmbarkingListBox)
					
					GroupsForEmbarking:updateCurrentSizeText(parent.data,avalibleWeight,avalibleWeightUnit)
					parent:onChangeEmbarkingGroup()
					--GroupsForEmbarking:testAndShowMessage(parent.data.group.units[1], parent.data.actionParams.groupsForEmbarking)
				end
			end
			
			function removeGroupButton:onChange()
				local item = unitForEmbarkingListBox:getSelectedItem()
				if item then 
					local id = item.groupId
					
					GroupsForEmbarking:removeGroup(parent.data,id)
					GroupsForEmbarking:refreshGroupsList(parent.data,unitForEmbarkingListBox)
					
					GroupsForEmbarking:updateCurrentSizeText(parent.data,avalibleWeight,avalibleWeightUnit)
					parent:onChangeEmbarkingGroup()
				end
			end
			
			local instance = {
				parent				= parent,
				durationCheckBox	= durationCheckBox,
				durationPanel 		= durationPanel,
				unitForEmbarkingListBox = unitForEmbarkingListBox,
				groupsComboList		= groupsComboList,
				addGroupButton		= addGroupButton,
				removeGroupButton	= removeGroupButton,
				avalibleWeight		= avalibleWeight,
				avalibleWeightUnit	= avalibleWeightUnit,
				panel				= panel,
				distributionCheckBox = distributionCheckBox,
				distributionComboList = distributionComboList,
				startCheckBox		= startCheckBox,
			}
			
			self.__index = self
			base.setmetatable(instance, self)
			
			return instance
		end,
		open = function(self, data)--открытие панели
			self.durationCheckBox:setState(data.actionParams.durationFlag)
			self.durationPanel:setEnabled(data.actionParams.durationFlag)
			self.durationPanel:setTime(data.actionParams.duration)
			self.distributionComboList:setVisible(data.actionParams.distributionFlag)
			self.distributionCheckBox:setState(data.actionParams.distributionFlag)
			self.groupsComboList:clear()
			self.startCheckBox:setState(data.actionParams.onStartMission)	
			--заполняю группы доступные к погрузке
			local transportGroup = base.module_mission.group_by_id[data.group.groupId]
			local transportCoalitionName = transportGroup.boss.boss.name
			local avalibleId={}
			for id,group in base.pairs(base.module_mission.group_by_id) do
				if data.group.boss.boss.name == group.boss.boss.name then
					local out = base.U.isEnableTask(group.route.points, 'EmbarkToTransport')
					for k,v in base.pairs(group.units) do
						if me_db_api.unit_by_type[v.type].Transportable == nil then 
							out=nil
							break
						end
					end
					if out then
						local voidItem = ListBoxItem.new(group.name)
						voidItem.groupId = id
						avalibleId[id]=id
						self.groupsComboList:insertItem(voidItem)
					end
				end
			end
			
			--заполняю ранее выбранные группы к погрузке
			--GroupsForEmbarking:testAndShowMessage(data.group.units[1],data.actionParams.groupsForEmbarking)	
			for i = #data.actionParams.groupsForEmbarking, 1, -1 do
				local id = data.actionParams.groupsForEmbarking[i]
				if avalibleId[id] == nil then
					GroupsForEmbarking:removeGroup(data, id)
				end
			end
			
			--перерисовка 
			self.distributionComboList:clear()
			for k,v in base.pairs(data.group.units) do
				item = widgetFactory.createListBoxItem(v.name, 0, 0, 5 * U.text_w, U.widget_h)
				item.unitId = v.unitId
				self.distributionComboList:insertItem(item)
			end
			
			if data.actionParams.distributionFlag or GroupsForEmbarking:checkGroups(data)==false then
				if GroupsForEmbarking:checkGroups(data)==false then
					GroupsForEmbarking:rebuildDistribution(data)
				end
				
				if data.actionParams.distributionFlag then
					self.distributionComboList:selectItem(self.distributionComboList:getItem(0))
					data.actionParams.selectedTransport = base.module_mission.unit_by_name[self.distributionComboList:getText()].unitId
				end
			end
			
			GroupsForEmbarking:refreshGroupsList(data, self.unitForEmbarkingListBox)
			
			GroupsForEmbarking:updateCurrentSizeText(data, self.avalibleWeight, self.avalibleWeightUnit)			
		end
	}
	
	
	GroupsForDisembarking={
		--расчет массы которую можно погрузить в транспорт
		getTransportMass = function(self,transport)
			local mass=0
			if transport then
				mass=me_db_api.unit_by_type[transport.type].M_empty
				for k,v in base.pairs(transport.payload) do
					if base.type(v)=='number' and k~='gun' and k~='chaff' then
						mass = mass + v
					end
				end
				for k,v in base.pairs(transport.payload.pylons) do
					mass = mass + loadOutUtils.getLauncherWeight(v.CLSID)
				end
			end
			return mass
		end,
		--суммарная масса группы
		getTransportableGroupMass = function(self, groupId)
			local group = base.module_mission.group_by_id[groupId]
			local mass = 0
			
			if group then
				for k,v in base.pairs(group.units) do
					if me_db_api.unit_by_type[v.type].Transportable then
                        local unit = me_db_api.unit_by_type[v.type]
                        if unit then	
                            mass = mass + unit.chassis.mass
                        end
					end
				end
			end
			return mass
		end,
		--суммарная масса нескольких групп
		getGroupsMass = function(self, groupsId)
			local groupsMass = 0
			for	k,v in base.pairs(groupsId) do
				groupsMass = groupsMass + GroupsForDisembarking:getTransportableGroupMass(v)
			end
			return groupsMass
		end,
		--получить доступную массу для погрузки
		getTransportPassengersMaxMass = function(self,transport)
			local maxMass = me_db_api.unit_by_type[transport.type].M_max
			local currentMass = GroupsForDisembarking:getTransportMass(transport)
			return maxMass-currentMass
		end,
		--получить пару значений - массу группы и возможный вес груза вертолета
		getWeightsGroupsAndAvalibleWeights = function(self,transport, groupsId)
			local groupsMass = GroupsForDisembarking:getGroupsMass(groupsId)
			local transportPassengersMass = GroupsForDisembarking:getTransportPassengersMaxMass(transport)
			return groupsMass, transportPassengersMass
		end,
		
		--получить объем группы при транспортировке
		getTransportableGroupSize = function(self, groupId)
			local group = base.module_mission.group_by_id[groupId]
			local size = 0
			
			if group then
				for k,v in base.pairs(group.units) do
					if me_db_api.unit_by_type[v.type].Transportable then
						size = size + me_db_api.unit_by_type[v.type].Transportable.size
					end
				end
			end
			return size
		end,
		--получить вместимость транспорта
		getTransportCapacity = function(self,unitId)
			local _type = base.module_mission.unit_by_id[unitId].type
			local transportType = me_db_api.unit_by_type[_type]
			if transportType.InternalCargo then
				return transportType.InternalCargo.nominalCapacity
			else
				return 0
			end
		end,
		-- получить суммарный объем группы пехоты
		getGroupsSize = function(self, groupsId)
			local groupsSize = 0
			if groupsId then
				for	k,v in base.pairs(groupsId) do
					groupsSize = groupsSize + GroupsForDisembarking:getTransportableGroupSize(v)					
				end
			end
			return groupsSize
		end,
		-- обновить текст с текущей массой групп
		updateCurrentSizeText = function(self, data, widget, widgetUnit)
			local groupsSize=0
			local transportPassengersSize=0
			
			local groupsSizeCur=0
			local transportPassengersSizeCur=0

			if data.group then
				for i, unit in base.pairs(data.group.units)do
					transportPassengersSizeCur = transportPassengersSizeCur + GroupsForDisembarking:getTransportCapacity(unit.unitId)		
					transportPassengersSize = transportPassengersSize + GroupsForDisembarking:getTransportCapacity(unit.unitId)
				end
				
				local idInTransport = {}
				for kk, wpt in base.ipairs(data.group.route.points) do
					if data.wpt and kk > data.wpt.index then
						break
					end
										
					for kkk, wptTask in base.ipairs(wpt.task.params.tasks) do
						if wptTask.id == "Embarking" then
							for k,groupId in base.pairs(wptTask.params.groupsForEmbarking) do									
								idInTransport[groupId] = groupId
							end
							groupsSize = groupsSize + GroupsForDisembarking:getGroupsSize(wptTask.params.groupsForEmbarking)	
						end
						
						if wptTask.id == "Disembarking" then
							for k,groupId in base.pairs(wptTask.params.groupsForEmbarking) do
								idInTransport[groupId] = nil
							end
							groupsSize = groupsSize - GroupsForDisembarking:getGroupsSize(wptTask.params.groupsForEmbarking)
						end
												
					end						
				end
				groupsSizeCur = groupsSizeCur + GroupsForDisembarking:getGroupsSize(idInTransport)				
			end	
			
			groupsSize = groupsSize / 100
			transportPassengersSize = transportPassengersSize / 100

			groupsSizeCur = groupsSizeCur / 100
			transportPassengersSizeCur = transportPassengersSizeCur / 100
			
			widgetUnit:setVisible(false)

			avalibleWeightText = cdata.totalSize .. ' ' .. base.tostring(groupsSize) .. ' / ' .. base.tostring(transportPassengersSize)
			widget:setText(avalibleWeightText)
			avalibleWeightUnitText = cdata.curSize .. ' ' .. base.tostring(groupsSizeCur) .. ' / ' .. base.tostring(transportPassengersSizeCur)
			widgetUnit:setText(avalibleWeightUnitText)
		end,
		--сортировка транспортов по вместительности от большего к меньшему
		sortKeys = function(self, tbl)
			local orderedKeys = {}
			
			local pseudo = {}
			
			base.U.copyTable(pseudo,tbl)
			
			local length = base.U.getTableSize(tbl)
			
			while length>0 do
				local maxKey
				local maxSize
				for k,v in base.pairs(pseudo) do
					if maxKey then
						if v > maxSize then maxSize = v maxKey = k end
					else
						maxSize = v 
						maxKey = k 
					end
				end
				pseudo[maxKey] = nil
				length = length-1
				base.table.insert(orderedKeys,maxKey)
			end
			
			return orderedKeys
		end,
		
		--обновить список возможных к погрузке групп солдат
		refreshGroupsList = function(self, data, unitForEmbarkingListBox)
			unitForEmbarkingListBox:clear()
			local groupsId = data.actionParams.groupsForEmbarking
			
			if groupsId then
				for key,id in base.ipairs(groupsId) do
					local name = base.module_mission.group_by_id[id].name
					item = widgetFactory.createListBoxItem(name, 0, 0, 5 * U.text_w, U.widget_h)
					item.groupId = id
					unitForEmbarkingListBox:insertItem(item)
				end
			end
		end,
		--
		addGroup = function(self,data,groupId)
			GroupsForDisembarking:removeGroup(data,groupId)
		
			base.table.insert(data.actionParams.groupsForEmbarking, groupId)			
		end,
		
		removeGroup = function(self,data,groupId)
			for k,v in base.pairs(data.actionParams.groupsForEmbarking) do
				if v == groupId then
					base.table.remove(data.actionParams.groupsForEmbarking, k)
					break
				end
			end
		end,
		
		create=function(self,parent,linesNumber)
			
			local left, top, width, height = parent.panel:getBounds()
			local box_w = width
			
			local panel = addPanel(parent.panel, 0, 1, 0, linesNumber)
			local lines = addLines(panel, 1, linesNumber)
			
			local groupsComboList = widgetFactory.createComboList(0, 0, box_w*0.6, U.widget_h)
			lines[1]:insertWidget(groupsComboList)
			
			local addGroupButton = widgetFactory.createButton(_('ADD'),0,0,box_w*0.3,U.widget_h)
			lines[2]:insertWidget(addGroupButton)
			
			local removeGroupButton = widgetFactory.createButton(_('REMOVE'),box_w*0.4,0,box_w*0.3,U.widget_h)
			lines[2]:insertWidget(removeGroupButton)
			
			local avalibleWeight = widgetFactory.createStatic(cdata.totalWeight, 0, 0, box_w*0.5-10, U.widget_h)
			lines[3]:insertWidget(avalibleWeight)
			
			local avalibleWeightUnit = widgetFactory.createStatic(cdata.unitWeight, 150, 0, box_w*0.5-10, U.widget_h)
			lines[3]:insertWidget(avalibleWeightUnit)
			
			local unitForEmbarkingListBox = widgetFactory.createListBox(0, U.widget_h *4, 5 * U.text_w, (6)*U.widget_h)
			panel:insertWidget(unitForEmbarkingListBox)

			function addGroupButton:onChange()
				local item = groupsComboList:getSelectedItem()
				if item then
					local text = item:getText()
					local id = item.groupId
					
					GroupsForDisembarking:addGroup(parent.data,id)
					GroupsForDisembarking:refreshGroupsList(parent.data,unitForEmbarkingListBox)
					
					GroupsForDisembarking:updateCurrentSizeText(parent.data,avalibleWeight,avalibleWeightUnit)
					parent:onChangeEmbarkingGroup()
				end
			end
			
			function removeGroupButton:onChange()
				local item = unitForEmbarkingListBox:getSelectedItem()
				if item then 
					local id = item.groupId
					
					GroupsForDisembarking:removeGroup(parent.data,id)
					GroupsForDisembarking:refreshGroupsList(parent.data,unitForEmbarkingListBox)
					
					GroupsForDisembarking:updateCurrentSizeText(parent.data,avalibleWeight,avalibleWeightUnit)
					parent:onChangeEmbarkingGroup()
				end
			end
			
			local instance = {
				parent				= parent,
				unitForEmbarkingListBox = unitForEmbarkingListBox,
				groupsComboList		= groupsComboList,
				addGroupButton		= addGroupButton,
				removeGroupButton	= removeGroupButton,
				avalibleWeight		= avalibleWeight,
				avalibleWeightUnit	= avalibleWeightUnit,
				panel				= panel,
			}
			
			self.__index = self
			base.setmetatable(instance, self)
			
			return instance
		end,
		open = function(self, data)--открытие панели
			self.groupsComboList:clear()
			--заполняю группы доступные к погрузке
			local transportGroup = base.module_mission.group_by_id[data.group.groupId]
			local transportCoalitionName = transportGroup.boss.boss.name
			local avalibleId={}
			
			if data.wpt == nil then
				for id,group in base.pairs(base.module_mission.group_by_id) do
					if data.group.boss.boss.name == group.boss.boss.name and group.route and group.route.points then
						for kk, wpt in base.ipairs(group.route.points) do	
							if wpt.task and wpt.task.params and wpt.task.params.tasks then
								for kkk, wptTask in base.ipairs(wpt.task.params.tasks) do
									if wptTask.id == "EmbarkToTransport" then
										avalibleId[id]=id
									end
								end
							end
						end	
					end
				end
			else
				for kk, wpt in base.ipairs(data.group.route.points) do
					if data.wpt and kk > data.wpt.index then
						break
					end
					
					for kkk, wptTask in base.ipairs(wpt.task.params.tasks) do
						if wptTask.id == "Embarking" and wptTask.params.groupsForEmbarking then
							for kkkk,groupId in base.pairs(wptTask.params.groupsForEmbarking) do
								avalibleId[groupId] = groupId
							end
						end

						if  kk < data.wpt.index and wptTask.id == "Disembarking" and wptTask.params.groupsForEmbarking then
							for kkkk,groupId in base.pairs(wptTask.params.groupsForEmbarking) do
								avalibleId[groupId] = nil
							end
						end
					end
				end	
			end

			for id,groupId in base.pairs(avalibleId) do
				local voidItem = ListBoxItem.new(base.module_mission.group_by_id[groupId].name)
				voidItem.groupId = groupId
				self.groupsComboList:insertItem(voidItem)
			end
			
			for i = #data.actionParams.groupsForEmbarking, 1, -1 do
				local id = data.actionParams.groupsForEmbarking[i]
				if avalibleId[id] == nil then
					GroupsForDisembarking:removeGroup(data, id)
				end
			end

			GroupsForDisembarking:refreshGroupsList(data, self.unitForEmbarkingListBox)
			
			GroupsForDisembarking:updateCurrentSizeText(data, self.avalibleWeight, self.avalibleWeightUnit)			
		end
	}
	
	base.setmetatable(AvalibleTipes, ActionParamHandler)
end