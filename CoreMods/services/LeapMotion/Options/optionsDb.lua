local OptionsData   = require('Options.Data')
local DbOption   	= require('Options.DbOption')
local i18n	     	= require('i18n')
--Trunk can't start on Win7 , error "loading module 'edLeapMotion'
local ok, Leap = pcall(require, "edLeapMotion")


local saved_dlg = nil

local function enableOptions(enabled)
	if saved_dlg ~= nil then
		saved_dlg.mouseClickSrcComboList:setEnabled(enabled)
		saved_dlg.mouseClickSrcHeader:setEnabled(enabled)
		saved_dlg.set_debugCheckbox:setEnabled(enabled)
		saved_dlg.handUseStickCheckbox:setEnabled(enabled)
		saved_dlg.handUseThrottleCheckbox:setEnabled(enabled)
		saved_dlg.handsHorizontalShiftHeader:setEnabled(enabled)
		saved_dlg.handsHorizontalShiftSlider:setEnabled(enabled)
		saved_dlg.handsHorizontalShiftWidget:setEnabled(enabled)
		
		if enabled == true then
			local mouse_combo = saved_dlg.mouseClickSrcComboList:getSelectedItem()
			Leap.setMouseClickSrc(mouse_combo)
			local debug_box = saved_dlg.set_debugCheckbox:getState()
			Leap.setDebug(debug_box)
			local stick_box = saved_dlg.handUseStickCheckbox:getState()
			Leap.setUseStick(stick_box)
			local throttle_box = saved_dlg.handUseThrottleCheckbox:getState()
			Leap.setUseThrottle(throttle_box)
			local horizontal_shift = saved_dlg.handsHorizontalShiftSlider:getValue()
			Leap.setHorizontalShift(horizontal_shift)
		end
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
			local other_trackers = Leap.checkTrackers()
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
		
			local is_other = checkOtherTracker()
			if is_other == false then
			
				enabled = Leap.setEnable(true)
				
				if enabled == true then
					enableOptions(enabled)
				end

			end
			
			if enabled == false then
			
				Leap.setEnable(false)
				
				saved_dlg.enableCheckbox:setState(false)
				saved_dlg.enableCheckbox:onChange()
				
			end
				
			saved_dlg.not_detectedTracker:setVisible(not enabled)
			
		else
		
			Leap.setEnable(false)
			
			saved_dlg.not_detectedTracker:setVisible(false)
			otherTrackerVarningDesable()
			enableOptions(false)
			
			enabled = false
		end
	
	
	end
end


local	enable	   = DbOption.new():setValue(false):checkbox()
:callback(function(value) 
	if ok then 
		tryEnabled(value)
	else
		if saved_dlg ~= nil then
			saved_dlg.enableCheckbox:setState(false)
			saved_dlg.enableCheckbox:onChange()
			saved_dlg.not_detectedLib:setVisible(true)
		end
	end
end)

local	mouseClickSrc = DbOption.new():setValue(0):combo({DbOption.Item(_('THUMB PRESSURE')):Value(0),
														  DbOption.Item(_('INDEX BENDING')):Value(1)})
:callback(function(value) 
	Leap.setMouseClickSrc(value)
end)

local	handUseStick	   = DbOption.new():setValue(false):checkbox()
:callback(function(value) 
	Leap.setUseStick(value)
end)

local	handUseThrottle	   = DbOption.new():setValue(false):checkbox()
:callback(function(value) 
	Leap.setUseThrottle(value)
end)

local	handsHorizontalShift = DbOption.new():setValue(0):slider(DbOption.Range(30,-30))
:callback(function(value) 
	Leap.setHorizontalShift(value)
end)

local function showDialog(dlg)
	if  saved_dlg ~= dlg then
		saved_dlg  = dlg

		if ok then  
		
			if dlg.enableCheckbox:getState() == false then
				enableOptions(false)
			else
				tryEnabled(true)
			end
		
		else
		
			enableOptions(false)
			saved_dlg.enableCheckbox:setState(false)
			saved_dlg.enableCheckbox:onChange()
		
		end

	end
end


local	set_debug	   = DbOption.new():setValue(false):checkbox()
:callback(function(value) 
	Leap.setDebug(value)
end)

if not ok then  
	return {
	enable	   				= enable,
	callbackOnShowDialog  	= showDialog,
	}
end

return {
	enable	   				= enable,
	mouseClickSrc			= mouseClickSrc,
	--- dlg callbacks
	callbackOnShowDialog  	= showDialog,
	--- geometry
	set_debug 				= set_debug,
	--- controls
	handUseStick			= handUseStick,
	handUseThrottle			= handUseThrottle,
	--- shift position
	handsHorizontalShift	= handsHorizontalShift,

}
