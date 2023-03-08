local base = _G

module('me_mapInfoPanel')

local require = base.require
local string = base.string
local os = base.os

local loader			= require('DialogLoader')
local U					= require('me_utilities')
local MapWindow			= require('me_map_window')
local Terrain			= require('terrain')
local UpdateManager		= require('UpdateManager')
local OptionsData		= require('Options.Data')

require('i18n').setup(_M)

cdata =
{

}

local wLineAll = 100
local resolutionMap = 3500


function create(x, y, w, h)
	window = loader.spawnDialogFromFile('MissionEditor/modules/dialogs/me_mapInfoPanel.dlg', cdata)
	window:setBounds(x, y, w, h)

    sScaleLine = window.sScaleLine
    
    --[[--статическая линейка
    local wLine = base.math.floor(w/20)
    wLineAll = 4*wLine+3
    
    window.sText:setBounds(15 + 4*wLine, 0, 70, 20)
    sScaleLine1 = window.sScaleLine1
    sScaleLine2 = window.sScaleLine2
    sScaleLine3 = window.sScaleLine3
    sScaleLine4 = window.sScaleLine4
    sScaleLine5 = window.sScaleLine5
    
    sScaleLine1:setBounds(50,            15, wLine, 20)
    sScaleLine2:setBounds(50 + wLine,    15, wLine, 20)
    sScaleLine3:setBounds(50 + 2*wLine,  15, wLine, 20)
    sScaleLine4:setBounds(50 + 3*wLine,  15, wLine, 20)
    sScaleLine5:setBounds(50 + 4*wLine,  15, 3, 20)]]
end    


function show(visible)
    window:setVisible(visible)	
end

function update()
    --updateStaticLine()
    updateDynLine()
end

function updateDynLine()
    local distance = 100 * MapWindow.getScale()/resolutionMap
    local unitSys = OptionsData.getUnits()
	local sunit
    local distanceTxt
    local newDistance 
    
    function reCalkLine(a_distance, a_basis)
        local newDist = 1
        i = 0.1
        while true do          
            if a_distance / (i*10) < 1 then
                break
            end
            i = i * 10
        end
        
        newDist = (base.math.floor(a_distance/i) + 1) * i
        return newDist
    end
    
    function reSizeLine(a_distance)
        local newSize = a_distance/MapWindow.getScale()*resolutionMap
        sScaleLine:setBounds(50,  15, newSize, 20)
        window.sText:setBounds(15 + newSize, 0, 70, 20)
    end
    
	if (unitSys == "metric") then
		sunit = _('m')	
		distance = base.math.floor(distance)  
        if (distance > 1000) then             
            distance = distance/1000  
            newDistance = reCalkLine(distance)  
            reSizeLine(newDistance*1000)  
            sunit = _('km')
        else
            newDistance = reCalkLine(distance)  
            reSizeLine(newDistance)    
        end
	else
		sunit = _('feet')
		distance = base.math.floor(distance/0.3048)
        if (distance > 6076.12) then            
            distance = base.math.floor(distance/6.07612) / 1000
            newDistance = reCalkLine(distance) 
            reSizeLine(newDistance * 0.3048 * 6076.12)     
            sunit = _('nm')
        else
            newDistance = reCalkLine(distance)
            reSizeLine(newDistance * 0.3048) 
        end
	end
	
    distanceTxt = base.string.format("%i",newDistance)
    
	local text = distanceTxt ..' '..sunit
    
    window.sText:setText(text)
end
--[[ --статическая линейка
function updateStaticLine()
    local formatTxt
    function setFormat(a_distance, a_basis)
        if  a_distance > (25*a_basis) then
            formatTxt = "%.0f"
        elseif a_distance > (10*a_basis) then
            formatTxt = "%.1f"
        elseif a_distance > a_basis then
            formatTxt = "%.2f"
        else   
            formatTxt = "%.0f"
        end
    end
    local distance = wLineAll * MapWindow.getScale()/resolutionMap
    local unitSys = OptionsData.getUnits()
	local sunit
    local distanceTxt
    
	if (unitSys == "metric") then
		sunit = _('m')	
		distance = base.math.floor(distance)  
        setFormat(distance, 1000)
        if (distance > 1000) then                      
            distance = distance/1000            
            sunit = _('km')
        end
	else
		sunit = _('feet')
		distance = base.math.floor(distance/0.3048)
        setFormat(distance,6076.12)
        if (distance > 6076.12) then
            distance = base.math.floor(distance/6.07612) / 1000
            sunit = _('nm')
        end
	end
	
    distanceTxt = base.string.format(formatTxt,distance)
    
	local text = distanceTxt ..' '..sunit
    
    window.sText:setText(text)
end
]]