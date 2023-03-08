local base = _G

module('me_nav_target_fix_points')

local require = base.require
local pairs = base.pairs
local ipairs = base.ipairs
local tostring = base.tostring

local U                 = require('me_utilities')	
local DialogLoader      = require('DialogLoader')
local MapWindow         = require('me_map_window')
local mod_mission 		= require('me_mission')
local i18n              = require('i18n')
local UC				= require('utils_common')
local OptionsData		= require('Options.Data')
local panel_aircraft	= require('me_aircraft')
local DB 				= require('me_db_api')

i18n.setup(_M)

cdata = {
	add 					= _('ADD'),
	edit 					= _('EDIT'),
	del 					= _('DEL'),
	lat 					= _('LATITUDE:'),
	lon 					= _('LONGITUDE:'),
	of 						= _('OF'),
	comment 				= _('Comment'),
	NavigationTargetPoint  	= _('NAVIGATION TARGET POINTS'),
	INUFixPoint 			= _('INU FIX POINT'),
}

vdata = {}
vdata.selectedPointNTP = nil
vdata.selectedPointIFP = nil


function create(x, y, w, h)
	window = DialogLoader.spawnDialogFromFile('MissionEditor/modules/dialogs/me_nav_target_fix_points.dlg', cdata)
    window:setBounds(x,y,w,h)
	
	window.spBox:setBounds(0,0,w,h)
	
	pNavTarget = window.spBox.pNavTarget
	
    buttonAddNTP 		= pNavTarget.buttonAddNTP
    buttonEditNTP		= pNavTarget.buttonEditNTP
    buttonDelNTP 		= pNavTarget.buttonDelNTP
    editCommentNTP 		= pNavTarget.editCommentNTP
    spOfNTP 			= pNavTarget.spOfNTP
    editboxNumberNTP 	= pNavTarget.editboxNumberNTP
    staticLatNTP 		= pNavTarget.staticLatNTP
    staticLonNTP 		= pNavTarget.staticLonNTP
	
	pFixPoints = window.spBox.pFixPoints

    buttonAddIFP 			= pFixPoints.buttonAddIFP
    buttonEditIFP 			= pFixPoints.buttonEditIFP
    buttonDelIFP 			= pFixPoints.buttonDelIFP
    spOfIFP 				= pFixPoints.spOfIFP
    editboxNumberIFP 		= pFixPoints.editboxNumberIFP
    staticLatIFP 			= pFixPoints.staticLatIFP
    staticLonIFP 			= pFixPoints.staticLonIFP
	
	editboxNumberNTP:setEnabled(false)
	editboxNumberIFP:setEnabled(false)
	
	buttons = {
        buttonAddNTP,
        buttonEditNTP,
		buttonAddIFP,
		buttonEditIFP
    }
	
	setupCallbacks()
end

function show(b)
	window:setVisible(b)
	vdata.selectedPointNTP = nil
	vdata.selectedPointIFP = nil
	update()
end

function setupCallbacks()
	editCommentNTP.onChange = onChange_editCommentNTP
	buttonAddNTP.onChange 	= onChange_buttonAddNTP
	buttonEditNTP.onChange 	= onChange_buttonEditNTP
	buttonDelNTP.onChange 	= onChange_buttonDelNTP
	spOfNTP.onChange 		= onChange_spOfNTP
	
	buttonAddIFP.onChange 	= onChange_buttonAddIFP 
    buttonEditIFP.onChange 	= onChange_buttonEditIFP 
    buttonDelIFP.onChange 	= onChange_buttonDelIFP 
    spOfIFP.onChange 		= onChange_spOfIFP 
end

function update()
	if not window:isVisible() or MapWindow.selectedGroup == nil then
        return
    end
	
	local curUnit = panel_aircraft.getCurUnit()
	local unitTypeDesc = DB.unit_by_type[curUnit.type]  
	local offset = 0
	if (unitTypeDesc and unitTypeDesc.Navpoint_Panel == true) then
		pNavTarget:setVisible(true)
		offset = 340
	else
		pNavTarget:setVisible(false)
	end
	
	if (unitTypeDesc and unitTypeDesc.Fixpoint_Panel == true)then
		pFixPoints:setVisible(true)
		pFixPoints:setPosition(0, offset)
	else
		pFixPoints:setVisible(false)
	end
	
	window.spBox:updateWidgetsBounds()
    
    if vdata.selectedPointNTP == nil then
        if not MapWindow.selectedGroup then
            vdata.selectedPointNTP = nil
        else
            if MapWindow.selectedGroup.NavTargetPoints then
                if #MapWindow.selectedGroup.NavTargetPoints > 0 then
                    vdata.selectedPointNTP = MapWindow.selectedGroup.NavTargetPoints[1]
                else
                    vdata.selectedPointNTP = nil
                end
            else
                vdata.selectedPointNTP = nil
            end
        end    
    end
    
    if buttonAddNTP:getState() then
        MapWindow.setState(MapWindow.getCreatingNavTargetPointState())
    elseif buttonAddIFP:getState() then
        MapWindow.setState(MapWindow.getCreatingINUFixPointState())
	else	
        MapWindow.setState(MapWindow.getPanState())
    end

    local lat = 0
    local long = 0
    
	if vdata.selectedPointNTP then
		local pointCount = 0
		if MapWindow.selectedGroup.NavTargetPoints then
			pointCount = #MapWindow.selectedGroup.NavTargetPoints
		end
		spOfNTP:setRange(1, pointCount)
		editboxNumberNTP:setText(tostring(pointCount))
		
		if buttonEditNTP:getState() and vdata.selectedPointNTP then -- что-то выделено      
			-- lat, long в градусах
			lat, long = MapWindow.convertMetersToLatLon(vdata.selectedPointNTP.x, vdata.selectedPointNTP.y)
			local datum = OptionsData.getMiscellaneous('Datum')
			if datum == 2 then
				lat, long = UC.LL_datum_convert(1, 2, lat, long)
			end	
			
			editboxNumberNTP:setText(tostring(vdata.selectedPointNTP.index))
			spOfNTP:setEnabled(true)
			spOfNTP:setValue(vdata.selectedPointNTP.index)
			if (vdata.selectedPointNTP.text_comment) then
				editCommentNTP:setText(vdata.selectedPointNTP.text_comment)  
			else
				editCommentNTP:setText("")
			end
			selectPointNTP(vdata.selectedPointNTP)
		else 
			spOfNTP:setEnabled(false)
			editCommentNTP:setText("")    
			selectPointNTP(nil)
		end
	else
		editCommentNTP:setText("") 
		editboxNumberNTP:setText('0')
		spOfNTP:setRange(0, 0)
		spOfNTP:setEnabled(false)
	end	
    
	vdata.comment = editCommentNTP:getText() 
	
	staticLatNTP:setText(U.getLatitudeString(U.toRadians(lat)))
	staticLonNTP:setText(U.getLongitudeString(U.toRadians(long)))
   
    --IFP--------------
    if vdata.selectedPointIFP == nil then
        if not MapWindow.selectedGroup then
            vdata.selectedPointIFP = nil
        else
            if MapWindow.selectedGroup.INUFixPoints then
                if #MapWindow.selectedGroup.INUFixPoints > 0 then
                    vdata.selectedPointIFP = MapWindow.selectedGroup.INUFixPoints[1]
                else
                    vdata.selectedPointIFP = nil
                end
            else
                vdata.selectedPointIFP = nil
            end
        end    
    end

    local lat = 0
    local long = 0
	
	if vdata.selectedPointIFP then
		local pointCount = 0
		if MapWindow.selectedGroup.INUFixPoints then
			pointCount = #MapWindow.selectedGroup.INUFixPoints
		end		
		spOfIFP:setRange(1, pointCount)	
		editboxNumberIFP:setText(tostring(pointCount))
    
		if buttonEditIFP:getState() and vdata.selectedPointIFP then -- что-то выделено        
			-- lat, long в градусах
			lat, long = MapWindow.convertMetersToLatLon(vdata.selectedPointIFP.x, vdata.selectedPointIFP.y)
			local datum = OptionsData.getMiscellaneous('Datum')
			if datum == 2 then
				lat, long = UC.LL_datum_convert(1, 2, lat, long)
			end	

			editboxNumberIFP:setText(tostring(vdata.selectedPointIFP.index))
				  
			spOfIFP:setEnabled(true)
			--editboxNumberIFP:setEnabled(true)
			--editboxNumberIFP:setText(tostring(pointCount))
			spOfIFP:setValue(vdata.selectedPointIFP.index)
			selectPointIFP(vdata.selectedPointIFP)
		else -- нифига не выделено 
			--editboxNumberIFP:setText('0')
			--editboxNumberIFP:setEnabled(false)
			--spOfIFP:setRange(0,1)
			spOfIFP:setEnabled(false)
			--spOfIFP:setValue(0)        
			selectPointIFP(nil)
		end
	else
		editboxNumberIFP:setText('0')
		spOfIFP:setRange(0, 0)
		spOfIFP:setEnabled(false)	
	end
    
    staticLatIFP:setText(U.getLatitudeString(U.toRadians(lat)))
    staticLonIFP:setText(U.getLongitudeString(U.toRadians(long)))
end

-- установить режим редактирования точек 
function setModeNTFP(a_mode)
	if a_mode == "NTP" then		
		buttonAddNTP:setState(false)
		buttonEditNTP:setState(true)
		buttonAddIFP:setState(false)
		buttonEditIFP:setState(false)
	else --"IFP"
		buttonAddNTP:setState(false)
		buttonEditNTP:setState(false)
		buttonAddIFP:setState(false)
		buttonEditIFP:setState(true)
	end
end

function isEditNTP()
	return buttonEditNTP:getState()
end

function isEditIFP()
	return buttonEditIFP:getState()
end

function onChange_editCommentNTP(self)
	vdata.comment = editCommentNTP:getText()        
	if (vdata.selectedPointNTP) then
		vdata.selectedPointNTP.text_comment = vdata.comment
		vdata.selectedPointNTP.mapObjects.comment.title = vdata.comment
		mod_mission.update_group_map_objects(vdata.selectedPointNTP.boss)
	end
end
	
	-- обработчик нажатия кнопки добавления Add
function onChange_buttonAddNTP(self)
    toggle(self)
    if self:getState() then -- если нажата Add
        MapWindow.setState(MapWindow.getCreatingNavTargetPointState()) -- карту в режим создания точек
    else -- если Add не нажата 
        MapWindow.setState(MapWindow.getPanState()) -- карту в обычный режим
    end
    update()
end

-- обработчик нажатия кнопки редактирования Edit
function onChange_buttonEditNTP(self)
    toggle(self)
    if self:getState() then -- если нажата Edit
        MapWindow.setState(MapWindow.getPanState()) --  карту в обычный режим
    end
    update()
end

-- обработчик нажатия кнопки удаления Del
function onChange_buttonDelNTP(self)
    if vdata.selectedPointNTP then
        local group = vdata.selectedPointNTP.boss
        local points = group.NavTargetPoints
        mod_mission.remove_NavTargetPoint(group, vdata.selectedPointNTP.index)        
        if #points > 0 then
            vdata.selectedPointNTP = points[1]
            selectPointNTP(vdata.selectedPointNTP)
        end
        update()        
    end
end

function onChange_spOfNTP(self)
    if vdata.selectedPointNTP then
        local group = vdata.selectedPointNTP.boss
        local points = group.NavTargetPoints
        
        vdata.selectedPointNTP = points[self:getValue()]
    end
    
    update()
end 

function toggle(button)
    for k,v in pairs(buttons) do 
        if button ~= v then
            v:setState(false)
        end
    end
end  


	
-- обработчик нажатия кнопки добавления Add
function onChange_buttonAddIFP(self)
    toggle(self)
    if self:getState() then -- если нажата Add
        MapWindow.setState(MapWindow.getCreatingINUFixPointState()) -- карту в режим создания точек коррекции
    else -- если Add не нажата 
        MapWindow.setState(MapWindow.getPanState()) -- карту в обычный режим
    end
    update()
end

-- обработчик нажатия кнопки редактирования Edit
function onChange_buttonEditIFP(self)
    toggle(self)
    if self:getState() then -- если нажата Edit
        MapWindow.setState(MapWindow.getPanState()) --  карту в обычный режим
    end
    update()
end

-- обработчик нажатия кнопки удаления Del
function onChange_buttonDelIFP(self)
    if vdata.selectedPointIFP then
        local group = vdata.selectedPointIFP.boss
        local points = group.INUFixPoints
        mod_mission.remove_INUFixPoint(group, vdata.selectedPointIFP.index)        
        if #points > 0 then
            vdata.selectedPointIFP = points[1]
            selectPointIFP(vdata.selectedPointIFP)
        end
        update()        
    end
end	

function onChange_spOfIFP(self)
    if vdata.selectedPointIFP then
        local group = vdata.selectedPointIFP.boss
        local points = group.INUFixPoints
        local listSize = #points

        vdata.selectedPointIFP = points[self:getValue()]
    end
    update()
end 

function selectPointNTP(point)
    local group
    if point ~= nil then 
        group = point.boss
    else
        if MapWindow.selectedGroup ~= nil then 
            group = MapWindow.selectedGroup
        else
            return
        end
    end
    
    if group.NavTargetPoints then
        local color = group.boss.boss.color

        for i, point in ipairs(group.NavTargetPoints) do
            point.symbol.currColor = color
            point.text.currColor = color
            point.comment.currColor = color
        end
    end
    
    if point ~= nil then
        local color = group.boss.boss.selectWaypointColor
        
        point.symbol.currColor = color
        point.text.currColor = color
        point.comment.currColor = color
    end

   mod_mission.update_group_map_objects(group) 
end 

function selectPointIFP(point)
    local group
    if point ~= nil then 
        group = point.boss
    else
        if MapWindow.selectedGroup ~= nil then 
            group = MapWindow.selectedGroup
        else
            return
        end
    end
    
    for i,pnt in ipairs(group.INUFixPoints or {}) do
        pnt.symbol.currColor = group.boss.boss.selectGroupColor
        pnt.text.currColor = group.boss.boss.selectGroupColor    
    end
    
    if point ~= nil then
        point.symbol.currColor = group.boss.boss.selectWaypointColor
        point.text.currColor = group.boss.boss.selectWaypointColor
    end
    mod_mission.update_group_map_objects(group) 
end