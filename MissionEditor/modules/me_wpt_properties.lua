local base = _G

module('me_wpt_properties')

local require = base.require
local pairs = base.pairs
local tonumber = base.tonumber

local DialogLoader 	= require('DialogLoader')
local U 			= require('me_utilities')
local panel_route 	= require('me_route')
local SpinWPT 		= require('me_spin_wpt')
local Static 		= require('Static')
local EditBox 		= require('EditBox')
local Button 		= require('Button')
local UpdateManager = require('UpdateManager')
local DB 			= require('me_db_api')

require('i18n').setup(_M)

vdata = {
  -- group = ..., присваивается снаружи. Там же устанавливается и умалчиваемая текущая точка маршрута
  wpt = nil
}

scale_combo_fill =
{
    {name = _('ENROUTE'),   id = 0},
    {name = _('TERMINAL'),  id = 1},
    {name = _('APPROACH'),  id = 2},
    {name = _('HIGH ACC'),  id = 3},    
    {name = _('none'),      id = 4}
}

steer_combo_fill =
{
    {name = _('TO FROM'),  id = 0},
    {name = _('DIRECT'),   id = 1},
    {name = _('TO TO'),    id = 2},
    {name = _('none'),     id = 3}
}

vnav_combo_fill =
{
    {name = _('2D'),        id = 0},
    {name = _('3D'),        id = 1},
    {name = _('none'),      id = 3}
}

vangle_combo_fill =
{
    {name = _('COMPUTED'),  id = 0},
    {name = _('ENTERED'),   id = 1},
}

defaultProperties =
{
    scale   = 0,
    steer   = 2,
    vnav    = 1,
    vangle  = 0,
    angle   = 0.0
}

local rowLast

-------------------------------------------------------------------------------
-- получать дефолтные значения нужно только через эту функцию!
function getDefaultProperties()
    local tmp_prop = {}
    U.copyTable(tmp_prop, defaultProperties)
    return tmp_prop
end

cdata = 
{
    waypoint 			= _('WAYPNT'),
    of 					= _('OF'),  
    scale               = _('SCALE'),
    steer               = _('STEER'),
    vnav                = _('VNAV'),
    vangle              = _('VANGLE'),
    angle               = _('ANGLE'),
	Name				= _('Name'),
	Value				= _('Value'),
	add             	= _('Add'),
    remove            	= _('Remove'),
}

-------------------------------------------------------------------------------
--
function create(x, y, w, h)
    window = DialogLoader.spawnDialogFromFile("MissionEditor/modules/dialogs/me_wpt_properties_panel.dlg", cdata)
    window:setBounds(x, y, w, h)	

	box = window.box
	box:setBounds(0, 0, w, h)
	panelBase = box.panelBase
    panelCustom = box.panelCustom
	Grid = panelCustom.Grid
	btnAdd = panelCustom.btnAdd
	buttonUp = panelCustom.buttonUp
	buttonDown = panelCustom.buttonDown
	
	eItemSkin 		= window.pNoVisible.eItem:getSkin()
	btnDelSkin		= window.pNoVisible.btnDel:getSkin()

	function btnAdd:onChange(self)
		vdata.wpt.properties.addopt = vdata.wpt.properties.addopt or {}
		local cell1 = insertRow(getDefaulName(Grid:getRowCount()+1), "")
		Grid:selectRow(Grid:getRowCount()-1)
		Grid:setRowVisible(Grid:getRowCount()-1)
		cell1:setFocused(true)
		cell1:setSelectionNew(0, cell1:getLineTextLength(0), 0, cell1:getLineTextLength(0))
	end
	
	function buttonUp:onChange(self)
		local index = Grid:getSelectedRow()
		
		if index > 0 then
			UpdateManager.add(function()
				local index = Grid:getSelectedRow()
				local tmp = {}
				base.U.recursiveCopyTable(tmp, vdata.wpt.properties.addopt[index+1]) 
				vdata.wpt.properties.addopt[index+1] = vdata.wpt.properties.addopt[index]
				vdata.wpt.properties.addopt[index] = tmp
				updateGrid()
				Grid:selectRow(index-1)
				return true
			end) 
		end
	end
	
	function buttonDown:onChange(self)
		local index = Grid:getSelectedRow()
		
		if index >= 0 and index < Grid:getRowCount()-1 then
			UpdateManager.add(function()
				local index = Grid:getSelectedRow()
				local tmp = {}
				base.U.recursiveCopyTable(tmp, vdata.wpt.properties.addopt[index+2]) 
				vdata.wpt.properties.addopt[index+2] = vdata.wpt.properties.addopt[index+1]
				vdata.wpt.properties.addopt[index+1] = tmp
				updateGrid()
				Grid:selectRow(index+1)
				return true
			end) 
		end
	end

	
    sc_wpt = SpinWPT.new()
    
    local con_wpt = sc_wpt:create(panelBase.staticSpinWPTPlaceholder:getBounds())
    
    panelBase:insertWidget(con_wpt)
    
    function sc_wpt:onChange(self)
        local numWPT = self:getCurIndex()
        
        panel_route.sc_wpt:setCurIndex(numWPT)
        panel_route.WPT_onchange(numWPT)
		
        update()
    end
    
    e_wptof = panelBase.e_wptof
        
    c_scale_combo = panelBase.c_scale_combo
    U.fill_comboListIDs(c_scale_combo, scale_combo_fill)

    function c_scale_combo:onChange(item)
        vdata.wpt.properties.scale = item.itemId
        update()
    end
    
    c_steer_combo = panelBase.c_steer_combo
    U.fill_comboListIDs(c_steer_combo, steer_combo_fill)

    function c_steer_combo:onChange(item)
        vdata.wpt.properties.steer = item.itemId
        update()
    end

    c_vnav_combo = panelBase.c_vnav_combo
    U.fill_comboListIDs(c_vnav_combo, vnav_combo_fill)

    function c_vnav_combo:onChange(item)
        vdata.wpt.properties.vnav = item.itemId
        
        if (vdata.wpt.properties.vnav == 1) then
            vdata.wpt.properties.vangle = 1
        end
        if (vdata.wpt.properties.vnav == 0) then
            vdata.wpt.properties.vangle = 0
        end
        update()
    end
        
    c_vangle_combo = panelBase.c_vangle_combo
    U.fill_comboListIDs(c_vangle_combo, vangle_combo_fill)

    function c_vangle_combo:onChange(item)
        vdata.wpt.properties.vangle = item.itemId
        update()
    end
         
    e_angle = panelBase.e_angle

    function e_angle:onChange()
        local angle = tonumber(self:getText())
        if (angle == nil) then
            angle = 0
        end
        if (angle > 89.9) then
            angle = 89.9
            e_angle:setText(angle)
        end
        if (angle < -89.9) then
            angle = -89.9
            e_angle:setText(angle)
        end
        vdata.wpt.properties.angle = angle        
    end
    
    function e_angle:onFocus()
        update()
    end
	
	function Grid:onMouseDown(x, y, button)
		if 1 == button then
			local col
			col, rowLast = self:getMouseCursorColumnRow(x, y)
			if -1 < col and -1 < rowLast then
				self:selectRow(rowLast)
			end
		end
	end
	
	Grid:clearRows()
end

function mergeDefault(a_properties)
	for k,v in base.pairs(getDefaultProperties()) do
		a_properties[k] = a_properties[k] or v	
	end
end

-------------------------------------------------------------------------------
-- записывает валидное значение properties для ППМ в  соответствии с заданным типом 
function applyWptProperties(unitTypeDesc, wpt)
	if unitTypeDesc.Waypoint_Panel == true then
		wpt.properties = wpt.properties or {}
		mergeDefault(wpt.properties)	
		if unitTypeDesc.Waypoint_Custom_Panel == true then
			wpt.properties.addopt = wpt.properties.addopt or {}
		else
			wpt.properties.addopt = nil
		end
	else
		wpt.properties = wpt.properties or {} 
		local tmp_addopt = wpt.properties.addopt
		wpt.properties = nil
		if unitTypeDesc.Waypoint_Custom_Panel == true then
			wpt.properties = {}
			wpt.properties.addopt = tmp_addopt or {}
		end
	end	
end


-------------------------------------------------------------------------------
--
function update()
    if not vdata.wpt then 
        return
    end
	
	local bShowProp = false
	local bShowCustomProp = false

	local unitTypeDesc = DB.unit_by_type[vdata.wpt.boss.units[1].type]
	if unitTypeDesc then
		bShowProp = unitTypeDesc.Waypoint_Panel == true
		bShowCustomProp = unitTypeDesc.Waypoint_Custom_Panel == true
	end	

	local group = vdata.wpt.boss
    
	if bShowProp == true then 
		panelBase:setVisible(true)
		e_wptof:setText(#group.route.points)

		sc_wpt:setWPT(vdata.wpt.index, #group.route.points, group.boss.name)

		local wptProperties = vdata.wpt.properties or getDefaultProperties()
		vdata.wpt.properties = wptProperties
		
		setValueComboBox(c_scale_combo, scale_combo_fill, wptProperties.scale)
		setValueComboBox(c_steer_combo, steer_combo_fill, wptProperties.steer)
		setValueComboBox(c_vnav_combo, vnav_combo_fill, wptProperties.vnav)
		
		if (wptProperties.vnav == 1) then
			c_vangle_combo:setEnabled(true)        
		else
			wptProperties.vangle = 0
			c_vangle_combo:setEnabled(false)
		end
		setValueComboBox(c_vangle_combo, vangle_combo_fill, wptProperties.vangle)
		
		if (wptProperties.vangle == 1) then
			e_angle:setEnabled(true)        
		else
			wptProperties.angle = 0.0
			e_angle:setEnabled(false)    
		end
		
		e_angle:setText(wptProperties.angle)
	else
		panelBase:setVisible(false)
	end	
		
	
	if bShowCustomProp then	
		panelCustom:setVisible(true)
		
		vdata.wpt.properties = vdata.wpt.properties or {}
		
		updateGrid()
		
		if bShowProp == true then 
			panelCustom:setPosition(9,173)
		else
			panelCustom:setPosition(9,9)
		end
	else
	    panelCustom:setPosition(9,9)
		panelCustom:setVisible(false)
    end
    box:updateWidgetsBounds()
end

function getDefaulName(rowIndex)
	local result = "PROPERTY_"..rowIndex 

	return result
end

function insertRow(a_propName, a_value)
	local rowIndex = Grid:getRowCount()
	local optIndex = rowIndex + 1
    Grid:insertRow(20,rowIndex)
	  
    ------1
	local cell_1
    cell_1 = EditBox.new()
	cell_1:setSkin(eItemSkin)   
	cell_1:setText(a_propName)	
	cell_1.propName = a_propName
	cell_1.optIndex = optIndex
	cell_1.onChange = function(self)
		vdata.wpt.properties.addopt[self.optIndex]["key"] = self:getText()
		self.propName = self:getText()
    end
    Grid:setCell(0, rowIndex, cell_1)
    
    ------2
	local cell_2
    cell_2 = EditBox.new()
	cell_2:setSkin(eItemSkin)
	cell_2.firstCall = cell_1
	cell_2.propName = a_propName	
    cell_2.onChange = function(self)
		vdata.wpt.properties.addopt[self.firstCall.optIndex]["value"] = self:getText()
    end
    
	cell_2:setText(a_value)
    Grid:setCell(1, rowIndex, cell_2)
	
	------3
	local cell_3
    cell_3 = Button.new()
	cell_3:setSkin(btnDelSkin) 
	cell_3.propName = a_propName	
    cell_3.onChange = function(self)
		UpdateManager.add(function()
			local index = Grid:getSelectedRow()
			base.table.remove(vdata.wpt.properties.addopt, index+1)
			updateGrid()
			return true 
		end) 
    end
	cell_3:setText(a_value)
    Grid:setCell(2, rowIndex, cell_3)
	
	vdata.wpt.properties.addopt[optIndex] = vdata.wpt.properties.addopt[optIndex] or {}
	vdata.wpt.properties.addopt[optIndex]["key"] = cell_1:getText()
	vdata.wpt.properties.addopt[optIndex]["value"] = cell_2:getText()
	
	return cell_1
end


function updateGrid() 
	Grid:clearRows()
	if vdata.wpt.properties.addopt then
		for k,v in base.ipairs(vdata.wpt.properties.addopt) do
			insertRow(v.key, v.value)
		end
	end	
end

-------------------------------------------------------------------------------
--
function setValueComboBox(combobox, fill, id)
    for k, v in pairs(fill) do
        if (id == v.id) then
            combobox:setText(v.name)
        end
    end
end

-------------------------------------------------------------------------------
--
function show(b)
    if not b then

	else
        update()
    end
    window:setVisible(b)
end

-------------------------------------------------------------------------------
--
function setWaypoint(wpt)	
    vdata.wpt = wpt		
end

