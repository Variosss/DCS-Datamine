local base = _G

module('me_roles')

local DialogLoader 	= base.require('DialogLoader')
local U 			= base.require('me_utilities')
local ProductType 	= base.require('me_ProductType') 
local net           = base.require('net')

--FIXME поле name используется в диалоге симулятора и не должна зависеть от локали, в которой была создана миссия
local groundControlData 
base.require('i18n').setup(_M)

cdata = {
groundControl 			= _("GROUND CONTROL"),
multiplayerRoles 		= _("MISSION/MULTIPLAYER ROLES"),
red 					= _("Red_edtr", "Red"),
blue 					= _("Blue_edtr", "Blue"),
neutrals 				= _("Neutrals_edtr", "Neutrals"),
pilotCanControlVehicles = _("PILOT CAN CONTROL VEHICLES"),
passwordProtection 		= _("Password Protection"),
Lock 					= _("Lock"),
}


if ProductType.getType() == "LOFAC" then
    cdata.groundControl = _("GROUND CONTROL-LOFAC")
    cdata.pilotCanControlVehicles = _("PILOT CAN CONTROL VEHICLES-LOFAC")
end

--FIXME не писать локализованное имя в миссию
--сделать отдельную конфигурационную таблицу для локализаци ролей, в миссии использовать только id
function initData()
    groundControlData = 
    {
        isPilotControlVehicles = false,
		roles = {},
		passwords = {}
	}
	for id, value in base.pairs(base.db.roles) do
		groundControlData.roles[id] = {red = 0, blue = 0, neutrals = 0}
		groundControlData.passwords[id] = {}
	end
end

function create(x, y, w, h)
	--TODO создавать виджеты из базы данных, а не ресурса диалога
	for id, value in base.pairs(base.db.roles) do
		cdata[id] = value
	end
	
    rolesWindow = DialogLoader.spawnDialogFromFile("MissionEditor/modules/dialogs/me_roles.dlg", cdata)
    
    rolesWindow:setBounds(x, y, w, h)
	pPasswords = rolesWindow.pPasswords

	for name, value in base.pairs(groundControlData.roles) do
		bindSpinBox(rolesWindow.pRed[name.."RedSB"], name, "red")
		bindSpinBox(rolesWindow.pBlue[name.."BlueSB"], name, "blue")
		bindSpinBox(rolesWindow.pNeutrals[name.."NeutralsSB"], name, "neutrals")
		
		bindLock(rolesWindow.pRed[name.."LockRedCB"], name, name.."PasswordRedE", "red")
		bindLock(rolesWindow.pBlue[name.."LockBlueCB"], name, name.."PasswordBlueE", "blue")
		bindLock(rolesWindow.pNeutrals[name.."LockNeutralsCB"], name, name.."PasswordNeutralsE", "neutrals")
		
		bindPassword(pPasswords[name.."PasswordRedE"], name, "red")
		bindPassword(pPasswords[name.."PasswordBlueE"], name, "blue")
		bindPassword(pPasswords[name.."PasswordNeutralsE"], name, "neutrals")
	end

    function rolesWindow.pilotControlCheck:onChange()
        groundControlData.isPilotControlVehicles = self:getState()
    end

end

function show(b)
    rolesWindow:setVisible(b)
	
	if b == true then
		for name, value in base.pairs(groundControlData.roles) do
			for side, sideName in base.pairs({["red"] = "Red", ["blue"] = "Blue", ["neutrals"] = "Neutrals"}) do
				local nameE = name.."Password"..sideName.."E"
				if groundControlData.passwords[name][side] ~= nil then
					rolesWindow["p"..sideName][name.."Lock"..sideName.."CB"]:setState(true)
					pPasswords[nameE]:setEnabled(true)	
					pPasswords[nameE]:setText("*****")	
				else
					rolesWindow["p"..sideName][name.."Lock"..sideName.."CB"]:setState(false)
					pPasswords[nameE]:setEnabled(false)	
					pPasswords[nameE]:setText("")
				end	
			end
		end
	end
end

function update(data)
	if data then
		U.copyTable(groundControlData, data)
	else
		initData()
	end
	
	for name, value in base.pairs(groundControlData.roles) do
		redSpinBox = rolesWindow.pRed[name.."RedSB"]
		redSpinBox:setValue(value.red)
        
        blueSpinBox = rolesWindow.pBlue[name.."BlueSB"]
		blueSpinBox:setValue(value.blue)
		
		neutralsSpinBox = rolesWindow.pNeutrals[name.."NeutralsSB"]
		neutralsSpinBox:setValue(value.neutrals)
	end	
    
    rolesWindow.pilotControlCheck:setState(groundControlData.isPilotControlVehicles)
end

function bindSpinBox(control, name, side)
	function control:onChange()
		groundControlData.roles[name][side] = self:getValue()
	end
end

function bindLock(control, name, eName, side)
	function control:onChange()
		pPasswords[eName]:setEnabled(self:getState())
		
		if self:getState() then
			pPasswords[eName]:setEnabled(true)	
			pPasswords[eName]:setText("")			
		else
			pPasswords[eName]:setEnabled(false)	
			pPasswords[eName]:setText("")
			groundControlData.passwords[name][side] = nil
		end	
	end
end

function bindPassword(control, name, side)
	function control:onChange()
		groundControlData.passwords[name][side] = net.hash_password(self:getText())
	end
end

function getGroundControlData()
    return groundControlData;
end






initData()
