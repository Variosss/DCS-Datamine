local base = _G

module('me_infoPlugin')

local require = base.require


local DialogLoader 			= require('DialogLoader')
local i18n 					= require('i18n')
local panel_quickstart		= require('me_quickstart')
local panel_aboutModules	= require('me_aboutModules')
local DCS    				= require('DCS')
local ProductType 			= require('me_ProductType')

i18n.setup(_M)

cdata =
{
	setWallpaper    = _("SET WALLPAPER"), 
	buy			    = _("BUY"),
	Instant 		= _("INSTANT ACTION"),
	credits			= _("CREDITS"),
	
}

curData = nil

local H_ = 0

-------------------------------------------------------------------------------
--
function create(x, y, w, h)
    local dialog = DialogLoader.spawnDialogFromFile('MissionEditor/modules/dialogs/me_info_plugin.dlg', cdata)
    panel = dialog.panel
	pButtons = panel.pButtons
    
	H_ = h
	
    dialog:removeWidget(panel)
    dialog:kill()
    
	panel:setPosition(-304, y)
	
	t_info = panel.t_info
	pTriangle = panel.pTriangle
	panelbg = panel.panelbg
	
	panel.b_close.onChange = function(self)
		panel:setVisible(false)
	end
	
	e_text = panel.e_text
    
    bSetWalpaper = pButtons.bSetWalpaper
	
    function bSetWalpaper:onChange()
        if curData then
            if (curData.state == "installed") then
                setWallpaper()
            elseif (curData.state == "sale") then
                openLink()
            end
        end
    end
	
	bInstant = pButtons.bInstant
	
	function bInstant:onChange()
        if curData then
            panel_quickstart.show(curData.id)
        end
    end
	
	bCredits = pButtons.bCredits
	
	function bCredits:onChange()
        if curData and curData.creditsFile then		
            panel_aboutModules.show(true, curData.dirRoot.."/"..curData.creditsFile, curData.displayName)
        end
    end
    
	return panel;
end

-------------------------------------------------------------------------------
--
function show(b)
	panel:setVisible(b)	
end

-------------------------------------------------------------------------------
--
function setPosition(a_x, a_y)
	panel:setPosition(a_x, a_y)
end

-------------------------------------------------------------------------------
--
function setData(a_data)
	local xP, yP, wP, hP = panel:getBounds()
	local wE, hE = e_text:getSize()

	panel:setBounds()

	curData = a_data
	t_info:setText(a_data.name)	
	e_text:setText(a_data.info)	
	local nw,nh = e_text:calcSize()
	
	panel:setBounds(xP, H_-150-(nh+75+47+10), wP, nh+75+47+20)
	e_text:setSize(wE, nh)
	pButtons:setPosition(0, nh+75+47-79+10)
	panelbg:setSize(319, nh+47+75+10)
	pTriangle:setPosition(31,nh+47+75+10)
		
	if panel_quickstart.isPresentModule(a_data.id) == true then
		bInstant:setEnabled(true)
	else
		bInstant:setEnabled(false)
	end
	
	if a_data.creditsFile ~= nil then
		bCredits:setEnabled(true)
	else
		bCredits:setEnabled(false)
	end
	
	if (a_data.state == "installed") then
		bSetWalpaper:setText(cdata.setWallpaper)
	elseif (a_data.state == "sale") then
        bSetWalpaper:setText(cdata.buy)
	end
end


function setWallpaper()
    curData.setWallpaper(curData.fullName)
    panel:setVisible(false)
end

function openLink()
	if (ProductType.getType() == "STEAM") then
		if curData.linkBuy and base.type(curData.linkBuy) == 'number' then
			DCS.activateSteamOverlayToStore(curData.linkBuy)			
		else
			DCS.activateSteamOverlayToStore(223750) -- DCS DLC Main Page
		end
	else		
		if (curData.linkBuy) then
			base.os.open_uri(curData.linkBuy)
		end
	end
end
