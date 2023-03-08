local OptionsData    = require('Options.Data')
local DbOption   	 = require('Options.DbOption')
local TabViewVR      = require('Options.TabViewVR')
local i18n	    	 = require('i18n')
local UpdateManager	 = require('UpdateManager')

--Trunk can't start on Win7 , error "loading module 'edCaptoGlove'
local ok, CaptoGlove = pcall(require, "edCaptoGlove")

local leftSensorId = 1
local rightSensorId = 3
local leftGlovaId = 2
local rightGloveId = 4

local is_sensors = false
local lostTime = 0

local saved_dlg = nil

local function checkSensors()

	local is_enabled = false
	local count = 0
	if saved_dlg ~= nil then
		local s_names = CaptoGlove.changeName()
		if s_names ~= nil then

			for k,v in pairs(s_names.names) do
				if k == leftSensorId then --Left Sensor
					saved_dlg.sensorNameLeft:setText(v)
				elseif k == leftGlovaId then --Left Glove
					saved_dlg.gloveNameLeft:setText(v)
				elseif k == rightSensorId then -- Right Sensor
					saved_dlg.sensorNameRight:setText(v)
				elseif k == rightGloveId then -- Right Glove
					saved_dlg.gloveNameRight:setText(v)
				end
			end

			count = s_names.size			
			is_enabled = s_names.enable
		end
	end
	
	return is_enabled, count
end

local function symmetricallyOptions(enabled)
	if saved_dlg ~= nil then
		if ok then
			CaptoGlove.resetDirection()
		end
		saved_dlg.shoulderJointX_RightSlider:setEnabled(enabled)
		saved_dlg.shoulderJointY_RightSlider:setEnabled(enabled)
		saved_dlg.shoulderJointZ_RightSlider:setEnabled(enabled)
		saved_dlg.shoulderLength_RightSlider:setEnabled(enabled)
		saved_dlg.forearmLength_RightSlider:setEnabled(enabled)
	end
end

local function bendingOptions(enabled)
	if saved_dlg ~= nil then
		saved_dlg.armBendingSlider:setEnabled(enabled)
	end
end


local function enableOptions(enabled)
	if saved_dlg ~= nil then
		saved_dlg.set_attachCheckbox:setEnabled(enabled)
		saved_dlg.resetDirection:setEnabled(enabled)
		saved_dlg.mouseClickSrcComboList:setEnabled(enabled)
		saved_dlg.set_debugCheckbox:setEnabled(enabled)
		saved_dlg.set_symmetricallyCheckbox:setEnabled(enabled)
		local is_symmetrically = saved_dlg.set_symmetricallyCheckbox:getState()
		if is_symmetrically then
			symmetricallyOptions(false)
		else
			symmetricallyOptions(enabled)
		end
		saved_dlg.shoulderJointX_LeftSlider:setEnabled(enabled)
		saved_dlg.shoulderJointY_LeftSlider:setEnabled(enabled)
		saved_dlg.shoulderJointZ_LeftSlider:setEnabled(enabled)
		saved_dlg.shoulderLength_LeftSlider:setEnabled(enabled)
		saved_dlg.forearmLength_LeftSlider:setEnabled(enabled)
		saved_dlg.useBendingCheckbox:setEnabled(enabled)
		local is_bending = saved_dlg.useBendingCheckbox:getState()
		if is_bending then
			bendingOptions(enabled)
		else
			bendingOptions(false)
		end
		saved_dlg.saveAngles:setEnabled(enabled)
		saved_dlg.breakAngles:setEnabled(enabled)
		saved_dlg.pitchOffsetShoulder_LeftSlider:setEnabled(enabled)
		saved_dlg.pitchOffsetShoulder_RightSlider:setEnabled(enabled)
		saved_dlg.yawOffsetShoulder_LeftSlider:setEnabled(enabled)
		saved_dlg.yawOffsetShoulder_RightSlider:setEnabled(enabled)
		saved_dlg.pitchOffsetGlove_LeftSlider:setEnabled(enabled)
		saved_dlg.pitchOffsetGlove_RightSlider:setEnabled(enabled)
		saved_dlg.yawOffsetGlove_LeftSlider:setEnabled(enabled)
		saved_dlg.yawOffsetGlove_RightSlider:setEnabled(enabled)
		saved_dlg.calibrationSpinRate:setEnabled(enabled)
		
		if enabled == true then
			local mouse_combo = saved_dlg.mouseClickSrcComboList:getSelectedItem()
			CaptoGlove.setMouseClickSrc(mouse_combo)
			local debug_box = saved_dlg.set_debugCheckbox:getState()
			CaptoGlove.setDebug(debug_box)
		end
	end

end

local function zeroAngles()
	if saved_dlg ~= nil then
		saved_dlg.pitchOffsetShoulder_LeftSlider:setValue(0)
		saved_dlg.pitchOffsetShoulder_RightSlider:setValue(0)
		saved_dlg.yawOffsetShoulder_LeftSlider:setValue(0)
		saved_dlg.yawOffsetShoulder_RightSlider:setValue(0)
		saved_dlg.pitchOffsetGlove_LeftSlider:setValue(0)
		saved_dlg.pitchOffsetGlove_RightSlider:setValue(0)
		saved_dlg.yawOffsetGlove_LeftSlider:setValue(0)
		saved_dlg.yawOffsetGlove_RightSlider:setValue(0)
		
		saved_dlg.pitchOffsetShoulder_LeftWidget:setText('0')
		saved_dlg.pitchOffsetShoulder_RightWidget:setText('0')
		saved_dlg.yawOffsetShoulder_LeftWidget:setText('0')
		saved_dlg.yawOffsetShoulder_RightWidget:setText('0')
		saved_dlg.pitchOffsetGlove_LeftWidget:setText('0')
		saved_dlg.pitchOffsetGlove_RightWidget:setText('0')
		saved_dlg.yawOffsetGlove_LeftWidget:setText('0')
		saved_dlg.yawOffsetGlove_RightWidget:setText('0')
		
		CaptoGlove.setPitchOffsetShoulderLeft(0)
		CaptoGlove.setPitchOffsetShoulderRight(0)
		CaptoGlove.setPitchOffsetGloveLeft(0)
		CaptoGlove.setPitchOffsetGloveRight(0)
		CaptoGlove.setYawOffsetShoulderLeft(0)
		CaptoGlove.setYawOffsetShoulderRight(0)
		CaptoGlove.setYawOffsetGloveLeft(0)
		CaptoGlove.setYawOffsetGloveRight(0)
	end
end

local function otherTrackerVarningDesable()
	if saved_dlg ~= nil then
		saved_dlg.detectedTracker:setVisible(false)
		saved_dlg.currentTracker:setVisible(false)
		saved_dlg.detectedTrackerName:setText("name")
		saved_dlg.detectedTrackerName:setVisible(false)
		saved_dlg.hintTrackerComlpex:setVisible(false)
		saved_dlg.hintTrackerSeparate:setVisible(false)
	end
end


local function checkOtherTracker()
	local is_other = false
	if saved_dlg ~= nil then
	
		local is_used_controllers_in_VR_options = OptionsData.getVR('hand_controllers')
		if is_used_controllers_in_VR_options == true then
			saved_dlg.detectedTracker:setVisible(true)
			saved_dlg.hintTrackerComlpex:setVisible(true)
			saved_dlg.hintTrackerSeparate:setVisible(false)
			is_other = true
		else
			local other_trackers = CaptoGlove.checkTrackers()
			if other_trackers == nil or other_trackers.other == false then
				otherTrackerVarningDesable()
			else
				saved_dlg.detectedTracker:setVisible(true)
				saved_dlg.detectedTrackerName:setVisible(true)
				saved_dlg.detectedTrackerName:setText(other_trackers.type)
				saved_dlg.currentTracker:setVisible(true)
				if other_trackers.complex == true then
					saved_dlg.hintTrackerComlpex:setVisible(true)
					saved_dlg.hintTrackerSeparate:setVisible(false)
				else
					saved_dlg.hintTrackerComlpex:setVisible(false)
					saved_dlg.hintTrackerSeparate:setVisible(true)
				end
				is_other = true
			end
		end
	end
	
	return is_other
end

local function tryEnabled(value)
	if saved_dlg ~= nil then
		
		saved_dlg.not_detectedLib:setVisible(false)
		
		local enabled = false
		
		if value == true then
		
			--local VR_Container = TabViewVR:getContainer()
			--local is_TabVR_enable = VR_Container.hand_controllersCheckbox:getState()
			local is_other = checkOtherTracker()
			if is_other == false then
			
				enabled = CaptoGlove.setEnable(true)
				
				saved_dlg.not_detectedTracker:setVisible(not enabled)
				
				if enabled == true then
					checkingSensors()
				end
				
				--enableOptions(enabled)
				
			end	
			
			if enabled == false then
			
				CaptoGlove.setEnable(false)
				
				saved_dlg.enableCheckbox:setState(false)
				saved_dlg.enableCheckbox:onChange()
				
			end
			
		else
		
			CaptoGlove.setEnable(false)
			
			saved_dlg.not_detectedTracker:setVisible(false)
			otherTrackerVarningDesable()
			enableOptions(false)
			
			enabled = false
		end

		if saved_dlg.recheckSensors then
			saved_dlg.recheckSensors:setText(_("Warning! Sensors not found!"))		
			saved_dlg.recheckSensors:setVisible(enabled)
			saved_dlg.recheckSensorsTime:setVisible(enabled)
		end
		
	end
end


local	enable	   = DbOption.new():setValue(false):checkbox()
:callback(function(value) 

	if ok then

		tryEnabled(value)
		if value == false then
			UpdateManager.delete(updateSensors)
		end
	
	else
		
		if saved_dlg ~= nil then
			saved_dlg.enableCheckbox:setState(false)
			saved_dlg.enableCheckbox:onChange()
			saved_dlg.not_detectedLib:setVisible(true)
		end
	
	end
end)

local	useBending	   = DbOption.new():setValue(false):checkbox()
:callback(function(value) 
	CaptoGlove.setUseBending(value)
	if saved_dlg ~= nil then
		saved_dlg.armBendingSlider:setEnabled(value)
	end
end)

local	armBending = DbOption.new():setValue(60):slider(DbOption.Range(0,90))
:callback(function(value) 
	CaptoGlove.setArmBending(value)
end)

local	mouseClickSrc = DbOption.new():setValue(0):combo({DbOption.Item(_('THUMB PRESSURE')):Value(0),
														  DbOption.Item(_('INDEX BENDING')):Value(1)})
:callback(function(value) 
	CaptoGlove.setMouseClickSrc(value)
end)

function checkingSensors()
	
	realTimePrev = os.clock()
	lostTime = 0
	UpdateManager.add(updateSensors)	
end


function updateSensors()
	local realTime = os.clock()

	if realTimePrev then
		if realTime - realTimePrev >= 1 then
			lostTime = lostTime + 1
			realTimePrev = realTime

			local count = 0
			is_sensors, count = checkSensors()
			
			saved_dlg.recheckSensorsTime:setText(10-lostTime)
			
			if is_sensors then
				saved_dlg.recheckSensorsTime:setText(10)
				saved_dlg.recheckSensorsTime:setVisible(false)
				enableOptions(is_sensors)
				is_sensors = false
				if count == 4 then
					saved_dlg.recheckSensors:setVisible(false)				
				else
					saved_dlg.recheckSensors:setText(_("Check device names"))				
				end
				
				return true
			end
			if lostTime > 10 then
				CaptoGlove.setEnable(false)
				saved_dlg.not_detectedTracker:setVisible(true)
				return true
			end
			
		end
	else
		realTimePrev = realTime
	end
end

function checkingCalibration()
	
	CaptoGlove.calibrationSpinRate()
	
	realTimePrev = os.clock()
	lostTime = 0
	local is_complite = false
	UpdateManager.add(updateCalibration)	

end

function updateCalibration()
	local realTime = os.clock()

	if realTimePrev then
		if realTime - realTimePrev >= 1 then
			lostTime = lostTime + 1
			realTimePrev = realTime

			is_complite = CaptoGlove.calibrationComplite()
			
			saved_dlg.breakSpinRate:setText(30-lostTime)
			
			if is_complite then
			
				saved_dlg.breakSpinRate:setEnabled(true)
				saved_dlg.breakSpinRate:setText(_("Cancel"))

				return true
			end
			
		end
	else
		realTimePrev = realTime
	end
end


local function showDialog(dlg)
	if  saved_dlg ~= dlg then
		saved_dlg  = dlg
		
		if ok then  
	
			if  dlg.resetDirection then 
				function dlg.resetDirection:onChange() 
					CaptoGlove.resetDirection()
				end
			end
			
			if dlg.calibrationSpinRate then
				function dlg.calibrationSpinRate:onChange() 
					checkingCalibration()
					dlg.calibrationSpinRate:setEnabled(false)
					dlg.breakSpinRate:setVisible(true)
					dlg.breakSpinRate:setEnabled(false)
					dlg.breakSpinRate:setText(30)
				end
			end
			if dlg.breakSpinRate then
				function dlg.breakSpinRate:onChange() 
					dlg.calibrationSpinRate:setEnabled(true)
					dlg.breakSpinRate:setVisible(false)
					CaptoGlove.breakSpinRate()
					UpdateManager.delete(updateCalibration)
				end
			end
			
			if dlg.saveAngles then
				function dlg.saveAngles:onChange() 
					CaptoGlove.setPitchAndYawToSave(true)
					zeroAngles()
				end
			end
			if dlg.breakAngles then
				function dlg.breakAngles:onChange() 
					CaptoGlove.setPitchAndYawToSave(false)
					zeroAngles()
				end
			end
			
			if dlg.recheckSensors then
				function dlg.recheckSensors:onChange() 
					local sensors, count = checkSensors()
					if count == 4 then
						dlg.recheckSensors:setText(_("Warning! Sensors not found!"))		
						dlg.recheckSensors:setVisible(false)				
					end
				end
			end

			if dlg.enableCheckbox:getState() == false then
				enableOptions(false)
			else
				tryEnabled(true)
			end

		else
			
			enableOptions(false)
			saved_dlg.enableCheckbox:setState(false)
			saved_dlg.enableCheckbox:onChange()
			saved_dlg.not_detectedLib:setVisible(false)
		
		end

	end
end


local	set_debug	   = DbOption.new():setValue(false):checkbox()
:callback(function(value) 
	CaptoGlove.setDebug(value)
end)

local	set_symmetrically	   = DbOption.new():setValue(false):checkbox()
:callback(function(value) 
	CaptoGlove.setSymmetrically(value)
	if saved_dlg ~= nil then
		symmetricallyOptions(not(value))
	end
end)

local	set_attach	   = DbOption.new():setValue(false):checkbox()
:callback(function(value) 
	CaptoGlove.setAttach(value)
end)


-- arm length offset смещение плеча от шлема 
local	shoulderJointX_Left = DbOption.new():setValue(-15.0):slider(DbOption.Range(10,-30))
:callback(function(value) 
	CaptoGlove.setShoulderJointLeftX(value)
end)
local	shoulderJointX_Right = DbOption.new():setValue(-15.0):slider(DbOption.Range(10,-30))
:callback(function(value) 
	CaptoGlove.setShoulderJointRightX(value)
end)

local	shoulderJointY_Left = DbOption.new():setValue(-23.0):slider(DbOption.Range(0,-40))
:callback(function(value) 
	CaptoGlove.setShoulderJointLeftY(value)
end)
local	shoulderJointY_Right = DbOption.new():setValue(-23.0):slider(DbOption.Range(0,-40))
:callback(function(value) 
	CaptoGlove.setShoulderJointRightY(value)
end)

local	shoulderJointZ_Left = DbOption.new():setValue(23.0):slider(DbOption.Range(0,40))
:callback(function(value) 
	CaptoGlove.setShoulderJointLeftZ(value)
end)
local	shoulderJointZ_Right = DbOption.new():setValue(23.0):slider(DbOption.Range(0,40))
:callback(function(value) 
	CaptoGlove.setShoulderJointRightZ(value)
end)

-- shoulder length длинна плеча
local	shoulderLength_Left = DbOption.new():setValue(40.0):slider(DbOption.Range(30,50))
:callback(function(value) 
	CaptoGlove.setShoulderLengthLeft(value)
end)
local	shoulderLength_Right = DbOption.new():setValue(40.0):slider(DbOption.Range(30,50))
:callback(function(value) 
	CaptoGlove.setShoulderLengthRight(value)
end)

-- forearm length длина предплечья
local	forearmLength_Left = DbOption.new():setValue(30.0):slider(DbOption.Range(20,40))
:callback(function(value) 
	CaptoGlove.setForearmLengthLeft(value)
end)
local	forearmLength_Right = DbOption.new():setValue(30.0):slider(DbOption.Range(20,40))
:callback(function(value) 
	CaptoGlove.setForearmLengthRight(value)
end)


-- controller pitch offset сещение угла места
local	pitchOffsetShoulder_Left = DbOption.new():setValue(0.0):slider(DbOption.Range(-90,90))
:callback(function(value) 
	CaptoGlove.setPitchOffsetShoulderLeft(value)
end)
local	pitchOffsetShoulder_Right = DbOption.new():setValue(0.0):slider(DbOption.Range(-90,90))
:callback(function(value) 
	CaptoGlove.setPitchOffsetShoulderRight(value)
end)
local	pitchOffsetGlove_Left = DbOption.new():setValue(0.0):slider(DbOption.Range(-90,90))
:callback(function(value) 
	CaptoGlove.setPitchOffsetGloveLeft(value)
end)
local	pitchOffsetGlove_Right = DbOption.new():setValue(0.0):slider(DbOption.Range(-90,90))
:callback(function(value) 
	CaptoGlove.setPitchOffsetGloveRight(value)
end)


-- controller yaw offset смещения по азимуту
local	yawOffsetShoulder_Left = DbOption.new():setValue(0.0):slider(DbOption.Range(-180,180))
:callback(function(value) 
	CaptoGlove.setYawOffsetShoulderLeft(value)
end)
local	yawOffsetShoulder_Right = DbOption.new():setValue(0.0):slider(DbOption.Range(-180,180))
:callback(function(value) 
	CaptoGlove.setYawOffsetShoulderRight(value)
end)
local	yawOffsetGlove_Left = DbOption.new():setValue(0.0):slider(DbOption.Range(-180,180))
:callback(function(value) 
	CaptoGlove.setYawOffsetGloveLeft(value)
end)
local	yawOffsetGlove_Right = DbOption.new():setValue(0.0):slider(DbOption.Range(-180,180))
:callback(function(value) 
	CaptoGlove.setYawOffsetGloveRight(value)
end)


if not ok then  
	return {
	enable	   				= enable,
	callbackOnShowDialog  	= showDialog,
	}
end


return {
	enable	   				= enable,
	
	useBending				= useBending,
	armBending 				= armBending,
	mouseClickSrc			= mouseClickSrc,
	--- dlg callbacks
	callbackOnShowDialog  	= showDialog,
	--- geometry
	set_debug 				= set_debug,
	set_symmetrically		= set_symmetrically,
	set_attach				= set_attach,
	
	shoulderJointX_Left		= shoulderJointX_Left,
	shoulderJointY_Left		= shoulderJointY_Left,
	shoulderJointZ_Left		= shoulderJointZ_Left,
	shoulderJointX_Right	= shoulderJointX_Right,
	shoulderJointY_Right	= shoulderJointY_Right,
	shoulderJointZ_Right	= shoulderJointZ_Right,
	
	shoulderLength_Left		= shoulderLength_Left,
	shoulderLength_Right	= shoulderLength_Right,
	forearmLength_Left		= forearmLength_Left,
	forearmLength_Right		= forearmLength_Right,
	
	pitchOffsetShoulder_Left  = pitchOffsetShoulder_Left,
	pitchOffsetShoulder_Right = pitchOffsetShoulder_Right,
	yawOffsetShoulder_Left	  = yawOffsetShoulder_Left,
	yawOffsetShoulder_Right	  = yawOffsetShoulder_Right,
	
	pitchOffsetGlove_Left  = pitchOffsetGlove_Left,
	pitchOffsetGlove_Right = pitchOffsetGlove_Right,
	yawOffsetGlove_Left	   = yawOffsetGlove_Left,
	yawOffsetGlove_Right   = yawOffsetGlove_Right,

}
