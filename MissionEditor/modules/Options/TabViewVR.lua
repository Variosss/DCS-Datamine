local base = _G

local require			= base.require
local string			= base.string
local DialogLoader		= require('DialogLoader'		)
local Factory			= require('Factory'				)
local TabViewBase		= require('Options.TabViewBase'	)
local WidgetUtils		= require('Options.WidgetUtils'	)
local SkinUtils			= require('SkinUtils'			)
local i18n				= require('i18n'				)
local visualizer 		= base.visualizer
local HMD           	= base.HMD

local _ = i18n.ptranslate

local function loadFromResource(self)
	local localization = {
		enable						= _('ENABLE VIRTUAL REALITY HEADSET').." *",
		pixel_density				= _('PIXEL DENSITY').." *",
		use_mouse					= _('USE MOUSE'),
		box_mouse_cursor			= _('CURSOR CONFINED TO GAME WINDOW'),
		custom_IPD_enable   		= _('FORCE IPD DISTANCE'),
		hand_controllers    		= _('USE HAND CONTROLLERS'),
		prefer_built_in_audio 		= _('Use Built-In Audio Device').." *",
		interaction_with_grip_only 	= _('Hand Interaction Only When Palm Grip is Obtained'),
		bloom						= _('Bloom Effect'),
		msaaMaskSize				= _('MSAA Mask Size'),
		
		hand_controllers_conflict	= _("Warning! You must disable other trackers!"),
		hand_controllers_current	= _("Current enabled tracker name is:"),
		hand_controllers_hint	 	= _("Options tab \"Special\""),
		mirrorOptions				= _("VR Mirror Options"),
		mirrorSource				= _("Mirror Eye Source"),
		use_DCS_system_resolution   = _("Use DCS System Resolution"),
		cropToRectangle				= _("Crop To Rectangle"),
		
		hand_controllers_use_stick  = _('Hand controllers use Cockpit Stick'),
		hand_controllers_use_throttle= _('Hand controllers use Cockpit Throttle'),
		hand_controllers_joint_throttle= _('Joint/separate use Cockpit Throttles'),
		hand_debug_draw			 	= _("Draw hands skeleton"),
		hand_pointer_use			= _("Use Pointer"),
		hand_hide_disable			= _("Show Hide Hands"),
		
		enableHMDMask				= _("enable HMD Mask"),
		
		note						= "* - ".._("Game restart is required."),
	}
	local window = DialogLoader.spawnDialogFromFile('./MissionEditor/modules/dialogs/me_options_VR.dlg', localization)
	local container  = window.containerMain.containerVR
	window.containerMain:removeWidget(container)
	window:kill()
	return container
end

local function otherTrackerWarning(container, value)
	if container ~= nil then
		container.detected_hand_controllers:setVisible(value)
		container.current_hand_controllers:setVisible(value)
		container.detected_hand_controllers_name:setVisible(value)
		container.hint_hand_controllers:setVisible(value)
	end
end

local function additionalControllersActivity(container, value, is_vrg)
	if container ~= nil then
		container.hand_controllers_use_stickCheckbox:setEnabled(value)
		container.hand_controllers_use_throttleCheckbox:setEnabled(value)
		container.hand_controllers_joint_throttleCheckbox:setEnabled(value)
		
		if is_vrg == true then
			container.hand_controllers_debug_drawCheckbox:setVisible(true)
			container.hand_controllers_debug_drawCheckbox:setEnabled(value)
		else
			container.hand_controllers_debug_drawCheckbox:setVisible(false)
		end
		
	end
end

local function checkOtherTracker(container)
	local is_other = false
	local is_vrg = false
	if container ~= nil then
	
		local other_trackers = HMD.checkTrackers()
		if other_trackers == nil then 
			otherTrackerWarning(container, false)
		else
			if other_trackers.other == false then
				otherTrackerWarning(container, false)
			else
				otherTrackerWarning(container, true)
				container.detected_hand_controllers_name:setText(other_trackers.type)
				is_other = true
			end
			
		
			if other_trackers.type == 'VRG' then
				is_vrg = true
			end
		end
	end
	
	return is_other, is_vrg
end

local function bindControls(self, a_style, a_w, a_h)
	local container = self:getContainer()
	
	container.sNote:setPosition(40, a_h-40)
	
	container.use_mouseCheckbox.callbackUpdate = function(self)
		HMD.setUseMouse(self:getState())
	end
	
	container.box_mouse_cursorCheckbox.callbackUpdate = function(self)
		if  HMD.isActive() then
			visualizer.boxMouseCursor(self:getState())
		end
	end
	
	if HMD and container.hand_hideDisableButton then 
		HMD.setHandControllersVisible()
	end
	
	container.hand_controllersCheckbox.callbackUpdate = function(self)
	
	
		local is_hmd_vrg = false
		local enable = self:getState()
		if enable == true then
			local other, is_vrg = checkOtherTracker(container)
			if other == true then
				enable = false
				self:setState(false)
				self:onChange()
			end
			
			is_hmd_vrg = is_vrg
		end
		
		additionalControllersActivity(container, enable, is_hmd_vrg)
	
		HMD.setUseHandControllers(enable)
		
		
		local is_hand_hide = HMD.checkTrackersVisible()
		if container.hand_hideDisableButton then
			container.hand_hideDisableButton:setVisible(is_hand_hide)
		end
	
		if is_hand_hide and container.hand_hideDisableButton then 
			function container.hand_hideDisableButton:onChange() 
				HMD.setHandControllersVisible()
				container.hand_hideDisableButton:setVisible(false)
			end
		end
	end
	
	container.hand_controllers_use_stickCheckbox.callbackUpdate = function(self)
		HMD.setHandControllersUseStick(self:getState())
	end
	
	container.hand_controllers_use_throttleCheckbox.callbackUpdate = function(self)
		HMD.setHandControllersUseThrottle(self:getState())
	end
	
	container.hand_controllers_joint_throttleCheckbox.callbackUpdate = function(self)
		HMD.setHandControllersJointThrottle(self:getState())
	end
	
	container.hand_controllers_debug_drawCheckbox.callbackUpdate = function(self)
		HMD.setHandSkeletonDraw(self:getState())
	end
	
	container.custom_IPD_enableCheckbox.callbackUpdate = function(self)
		HMD.setForceIPDEnable(self:getState())
	end	
	
	container.custom_IPDEditBox.callbackUpdate = function(self)
		HMD.setForcedIPD(self:getText())
	end
	
	container.interaction_with_grip_onlyCheckbox.callbackUpdate = function(self)
		HMD.setInteractionWithGripOnly(self:getState())
	end
	
	container.mirror_sourceComboList.callbackUpdate = function(self)
		local item = self:getSelectedItem()
		if item then
			HMD.mirrorSetSource(item.value)
		end
	end

	container.mirror_cropCheckbox.callbackUpdate = function(self)
		HMD.mirrorSetCrop(self:getState())
	end
	
	container.pointer_use_typeComboList.callbackUpdate = function(self)
		local item = self:getSelectedItem()
		if item then
			HMD.setPointerAction(item.value)
		end
	end
	
	container.enableHMDMaskCheckbox.callbackUpdate = function(self)
		HMD.setUseMask(self:getState())
	end
	
	
	self:bindOptionsContainer(container, 'VR')
	
	local helpInfos = {
		{	file = './MissionEditor/images/options/vr_help_1.png', 
			description = _("Tap controls with your fingertip to activate"),
		},
		{	file = './MissionEditor/images/options/vr_help_2.png', 
			description = _("Hold grip to invoke laser pointer."),
		},
		{	file = './MissionEditor/images/options/vr_help_3.png', 
			description = _("Depressing trigger performs LMB click on selected controls. Use this to push buttons, toggle switches e.t.c."),
		},
		{	file = './MissionEditor/images/options/vr_help_4.png', 
			description = _("Twist hand controller till laser pointer changes into blue. Now trigger will perform RMB clicks on selected controls."),
		},
		{	file = './MissionEditor/images/options/vr_help_5.png', 
			description = _("Push thumb hat up and down to toggle switches, cycle multi-position switches and rotary selectors; push thumb hat left and right to rotate knobs."),
		},	
		{	file = './MissionEditor/images/options/vr_help_6.png', 
			description = _("Push buttons A, B, X, Y for I really don't know what they do..."),
		},
	}
	
	local count				= #helpInfos
	local counter			= 1
	local containerHelp		= container.containerHelp
	local staticDescription	= containerHelp.staticDescription
	local staticPicture		= containerHelp.staticPicture
	local skin				= staticPicture:getSkin()
	local staticCount		= containerHelp.staticCount
	local setPicture 		= function()
		staticCount:setText(string.format(_("%d of %d"), counter, count))		
		staticPicture:setSkin(SkinUtils.setStaticPicture(helpInfos[counter].file, skin))
		staticDescription:setText(helpInfos[counter].description)
	end
	
	function containerHelp.buttonPrev:onChange()
		if counter > 1 then
			counter = counter - 1
			setPicture()
		end
	end
	
	function containerHelp.buttonNext:onChange()
		if counter < count then
			counter = counter + 1
			setPicture()
		end
	end
	
	setPicture()
end


local function bindSlider(self, slider, static, optionName, getFunc, setFunc, getDbValuesFunc)
	local dbValues 	= getDbValuesFunc(optionName)

	WidgetUtils.fillSlider(slider, dbValues)
	
	local formatText = "%0.1f"
	if slider:getStep() < 0.1 then
		formatText = "%0.2f"
	end
	
	local disp = function (value)
		return string.format(formatText,value)
	end
	function slider:onChange()
		local value = self:getValue()
		setFunc(optionName, value)
		static:setText(disp(value))
	end	
	
	self.updateFunctions_[optionName] = function()
		local value = getFunc(optionName)
		slider:setValue(value)
		static:setText(disp(value))
	end
end



return Factory.createClass({
	construct		 = construct,
	bindControls 	 = bindControls,
	bindSlider		 = bindSlider,
	loadFromResource = loadFromResource,
}, TabViewBase)
