local DialogLoader	= require('DialogLoader')
local Static		= require('Static')
local CheckBox		= require('CheckBox')
local i18n			= require('i18n')
local U 			= require('me_utilities')
local textutil      = require('textutil')
local MapWindow		= require('me_map_window')

local _ = i18n.ptranslate

local window_
local grid_
local cellSkin_
local checkBoxSkin_
local initialBounds_
local controller_
local rowHeight_			= 20
local nameColumnIndex_		= 0
local hiddenColumnIndex_	= 1
local radiusColumnIndex_	= 2

local function setController(controller)
	controller_ = controller
end

local function create(...)
	initialBounds_ = {...}
end

local KeysSort = 
    {
        "name", 
		"hidden",
        "radius",
    }
	
local curKeySort = 'name'
local sortReverse = false	

local hide
local function create_()
	local localization = {
		title	= _('TRIGGER ZONES LIST'),
		showAll	= _('Show all'),
		hideAll	= _('Hide all'),
		toggle	= _('Toggle'),
		name	= _('NAME'),
		hidden	= _('HIDDEN'),
		radius	= _('RADIUS')..", ".._('m'),
	}
	
	window_ = DialogLoader.spawnDialogFromFile('./MissionEditor/modules/dialogs/me_trig_zones_list_panel.dlg', localization)
	
	if initialBounds_ then
		window_:setBounds(unpack(initialBounds_))
	end
	
	function window_:onClose()
	   hide()
	end	
	
	grid_			= window_.grid
	cellSkin_		= window_.staticCell:getSkin()
	checkBoxSkin_	= window_.checkBoxCell:getSkin()
	pNoVisible		= window_.pNoVisible
	
	SkinsHeaders = 
    {
        [1] = {
            skinSortUp      = pNoVisible.gridHeaderCellSortUpPadding:getSkin(),
            skinSortDown    = pNoVisible.gridHeaderCellSortDownPadding:getSkin(),
            skinNoSort      = pNoVisible.gridHeaderCellNoSortPadding:getSkin(),
        }        
    }
	
	
	for i = 0, 2 do
		local gridHeaderCell = grid_:getColumnHeader(i)
		
		if gridHeaderCell then
			gridHeaderCell.KeySort = KeysSort[i+1] 
			local skin = getColumnHeaderSkin(i)
			if skin then
				gridHeaderCell:setSkin(skin)
			end
			
			gridHeaderCell:addChangeCallback(function(self)        
				if curKeySort == self.KeySort then
					sortReverse = not sortReverse
				else
					sortReverse = false
				end
				curKeySort = self.KeySort

				update()
			end	)
		end
	end
	
	function window_.buttonShow:onChange()
		if controller_ then
			for i, triggerZoneId in ipairs(controller_.getTriggerZoneIds()) do
				if controller_.getTriggerZoneHidden(triggerZoneId) then
					controller_.setTriggerZoneHidden(triggerZoneId, false)
				end
			end
		end
	end
	
	function window_.buttonHide:onChange()
		if controller_ then
			for i, triggerZoneId in ipairs(controller_.getTriggerZoneIds()) do
				if not controller_.getTriggerZoneHidden(triggerZoneId) then
					controller_.setTriggerZoneHidden(triggerZoneId, true)
				end
			end
		end	
	end		
	
	function window_.buttonToggle:onChange()
		if controller_ then
			for i, triggerZoneId in ipairs(controller_.getTriggerZoneIds()) do
				controller_.setTriggerZoneHidden(triggerZoneId, not controller_.getTriggerZoneHidden(triggerZoneId))
			end
		end			
	end
	
	function grid_:onMouseDown(x, y, button)
		local col, row = grid_:getMouseCursorColumnRow(x, y)

		if -1 < row and -1 < col then
			grid_:selectRow(row)
			
			if controller_ then
				MapWindow.unselectAll()
				controller_.onTriggerZoneSelected(grid_:getCell(nameColumnIndex_, row).triggerZoneId)
			end
		end
	end
end

function getColumnHeaderSkin(a_key)
	if curKeySort == a_key then
		if sortReverse then
			return SkinsHeaders[1].skinSortDown
		else
			return SkinsHeaders[1].skinSortUp
		end
	else
		return SkinsHeaders[1].skinNoSort
	end
end

function updateColumnHeaders()
	for i = 0, 2 do
		local gridHeaderCell = grid_:getColumnHeader(i)
		
		if gridHeaderCell then
			local skin = getColumnHeaderSkin(gridHeaderCell.KeySort)
			
			if skin then
				gridHeaderCell:setSkin(skin)
			end
		end
	end
end

local function needUpdate()
	return window_ and window_:getVisible() and controller_
end

local function getTriggerZoneRow(triggerZoneId)
	for i = 0, grid_:getRowCount() - 1 do	
		if grid_:getCell(nameColumnIndex_, i).triggerZoneId == triggerZoneId then
			return i
		end
	end
end

local function fillGridRow(rowIndex, data)
	local staticName = Static.new(data.name)
	
	staticName:setSkin(cellSkin_)
	staticName.triggerZoneId = data.id
	
	grid_:setCell(nameColumnIndex_, rowIndex, staticName)
	
	local checkBoxHidden = CheckBox.new()
	
	checkBoxHidden:setSkin(checkBoxSkin_)
	checkBoxHidden.triggerZoneId = data.id
	checkBoxHidden:setState(data.hidden)
	
	grid_:setCell(hiddenColumnIndex_, rowIndex, checkBoxHidden)
	
	function checkBoxHidden:onChange()
		if controller_ then
			controller_.setTriggerZoneHidden(self.triggerZoneId, self:getState())
		end
	end
	
	local staticRadius = Static.new(data.radius)
	
	staticRadius:setSkin(cellSkin_)
	
	grid_:setCell(radiusColumnIndex_, rowIndex, staticRadius)
end

local function triggerZoneAdded(triggerZoneId)
	if needUpdate() then
		update()
	end
end

local function triggerZoneRemoved(triggerZoneId)
	if needUpdate() then
		local rowIndex = getTriggerZoneRow(triggerZoneId)
		
		grid_:clearRow(rowIndex)
	end
end

local function triggerZoneNameChanged(triggerZoneId)
	if needUpdate() then
		local rowIndex		= getTriggerZoneRow(triggerZoneId)
		local staticName	= grid_:getCell(nameColumnIndex_, rowIndex)
		local triggerZone	= controller_.getTriggerZone(triggerZoneId)
		
		staticName:setText(triggerZone:getName())
	end
end

local function triggerZoneRadiusChanged(triggerZoneId)
	if needUpdate() then
		local rowIndex		= getTriggerZoneRow(triggerZoneId)
		local staticRadius	= grid_:getCell(radiusColumnIndex_, rowIndex)
		local triggerZone	= controller_.getTriggerZone(triggerZoneId)
		
		staticRadius:setText(triggerZone:getRadius())
	end
end

local function triggerZoneHiddenChanged(triggerZoneId)
	if needUpdate() then
		local rowIndex			= getTriggerZoneRow(triggerZoneId)
		
		local checkBoxHidden	= grid_:getCell(hiddenColumnIndex_, rowIndex)
		local triggerZone		= controller_.getTriggerZone(triggerZoneId)
		
		checkBoxHidden:setState(triggerZone:getHidden())
	end
end

local function selectTriggerZone(triggerZoneId)
	if needUpdate() then
		local rowIndex = getTriggerZoneRow(triggerZoneId)
		
		grid_:selectRow(rowIndex or -1)
	end
end

local function compTable(tab1, tab2)
    if type(tab1[curKeySort]) == "string" then
        if (tostring(tab1[curKeySort]) == tostring(tab2[curKeySort])) then            
			return (tab1['id'] < tab2['id'])
        end
        if sortReverse then
            return textutil.Utf8Compare(tab2[curKeySort], tab1[curKeySort])
        end
        return textutil.Utf8Compare(tab1[curKeySort], tab2[curKeySort])
    elseif type(tab1[curKeySort]) == "boolean" then
        if (tostring(tab1[curKeySort]) == tostring(tab2[curKeySort])) then            
			return (tab1['id'] < tab2['id'])
        end
        if sortReverse then
            return (tostring(tab1[curKeySort]) < tostring(tab2[curKeySort]))
        end
        return (tostring(tab1[curKeySort]) > tostring(tab2[curKeySort]))
    else
        if (tostring(tab1[curKeySort]) == tostring(tab2[curKeySort])) then            
			return (tab1['id'] < tab2['id'])
        end
        if sortReverse then
            return (tab1[curKeySort] > tab2[curKeySort])
        end
        return (tab1[curKeySort] < tab2[curKeySort])
    end       
end

function update()
	grid_:clearRows()
	
	local zones = {}
	for i, triggerZoneId in ipairs(controller_.getTriggerZoneIds()) do
		local triggerZone = controller_.getTriggerZone(triggerZoneId)	
		table.insert(zones, {id = triggerZoneId, name = triggerZone:getName(), hidden = triggerZone:getHidden(), radius =triggerZone:getRadius()})
	end
	
	table.sort(zones, compTable)
	
	for i, data in ipairs(zones) do
		local rowIndex = i - 1
		
		grid_:insertRow(rowHeight_)
		fillGridRow(rowIndex, data)
	end
	
	updateColumnHeaders()
end

local function show()
	if not window_ then
		create_()
	end
	
	if not window_:getVisible() then
		window_:setVisible(true)
		
		update()
		
		if controller_ then
			controller_.onTriggerZoneListShow()
		end
	end
end

-- объ€влена выше
hide = function()
	if window_ then	
		if window_:getVisible() then
			window_:setVisible(false)
			
			if controller_ then
				controller_.onTriggerZoneListHide()
			end			
		end	
	end
end

local function getWindowSize()
	if window_ then
		return window_:getSize()
	end
	
	return 0, 0
end

return {
	setController				= setController,
	create						= create,
	show						= show,
	hide						= hide,
	getWindowSize				= getWindowSize,
	triggerZoneAdded			= triggerZoneAdded,
	triggerZoneRemoved			= triggerZoneRemoved,
	triggerZoneNameChanged		= triggerZoneNameChanged,
	triggerZoneRadiusChanged	= triggerZoneRadiusChanged,
	triggerZoneHiddenChanged	= triggerZoneHiddenChanged,
	selectTriggerZone			= selectTriggerZone,
}