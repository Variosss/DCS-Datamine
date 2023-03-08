local DialogLoader		= require('DialogLoader')
local Factory			= require('Factory')
local TabViewBase		= require('Options.TabViewBase')
local WidgetUtils		= require('Options.WidgetUtils')
local i18n				= require('i18n')
local DbOption			= require('Options.DbOption')
local mod_sound			= require('sound')
local ProductType 		= require('me_ProductType')

local _ = i18n.ptranslate

local function loadFromResource(self)
	local localization = {
		audio 			= _("Audio"),
		volume 			= _("VOLUME"),
		music 			= _("MUSIC"),
		gui 			= _("GUI"),
		world			= _("WORLD"),
		Helmet			= _("HEADPHONES"),
		inCockpit 		= _("IN-COCKPIT"),
		radioSpeech 	= _("RADIO SPEECH"),
		subtitles 		= _("SUBTITLES"),
		GBreathEffect   = _("G-BREATH EFFECT"),
        hear_in_helmet  = _("HEAR LIKE IN HELMET"),
		headphones_sounds  = _("External View Cockpit Sounds and Radio Messages"),
		MainAudioOut	= _("Main audio out"),
		Headphones		= _("Headphones"),
		VoiceChatOut	= _("Voice Chat output"),
		VoiceChatIn		= _("Voice Chat input"),
		VoiceChat		= _("Voice Chat"),
		main_layout		= _("Speaker layout"),
		FakeAfterburner = _("Loud Cockpit Afterburner Sound"),
		switches		= _('switches', 'Switches'),
		Microphone_use	= _('Microphone use on Multiplayer start', 'Microphone at Multiplayer start'),
		play_audio_while_minimized = _("Play Audio While in Background"),
		
		tip_volume 			= _("Tips.Audio.volume"),
		tip_music 			= _("Tips.Audio.music"),
		tip_gui 			= _("Tips.Audio.gui"),
		tip_world 			= _("Tips.Audio.world"),
		tip_Helmet 			= _("Tips.Audio.Helmet"),
		tip_InCockpit 		= _("Tips.Audio.InCockpit"),
		tip_radioSpeech 	= _("Tips.Audio.radioSpeech"),
		tip_subtitles 		= _("Tips.Audio.subtitles"),
		tip_GBreathEffect 	= _("Tips.Audio.GBreathEffect"),
		tip_hear_in_helmet 	= _("Tips.Audio.hear_in_helmet"),
		tip_headphones_sounds = _("Tips.Audio.headphones_sounds"),
		tip_MainAudioOut 	= _("Tips.Audio.MainAudioOut"),
		tip_Headphones 		= _("Tips.Audio.Headphones"),
		tip_VoiceChatOut 	= _("Tips.Audio.VoiceChatOut"),
		tip_VoiceChatIn 	= _("Tips.Audio.VoiceChatIn"),
		tip_VoiceChat 		= _("Tips.Audio.VoiceChat"),
		tip_main_layout 	= _("Tips.Audio.main_layout"),
		tip_FakeAfterburner = _("Tips.Audio.FakeAfterburner"),
		tip_switches 		= _("Tips.Audio.switches"),
		tip_Microphone_use 	= _("Tips.Audio.Microphone_use"),
		tip_play_audio_w_m 	= _("Tips.Audio.play_audio_w_m"),
	}
	local window = DialogLoader.spawnDialogFromFile('./MissionEditor/modules/dialogs/me_options_audio.dlg', localization)
	local container = window.containerMain.containerAudio
	
	window.containerMain:removeWidget(container)
	window:kill()
	
	return container
end

local function bindSlider300P(self, slider, static, optionName, getFunc, setFunc, getDbValuesFunc)
	local dbValues = getDbValuesFunc(optionName)
	local range = dbValues[1]
	local minValue = range.min
	local maxValue = range.max
	
	range.max = 100
	
	WidgetUtils.fillSlider(slider, dbValues)
	
	local getValueUp = function(value)	
		if value <= 50 then
			return math.floor(value*2)
		else
			return math.floor(100+(value-50)*((maxValue-100)/50))
		end	
	end
	
	local getValueDown = function(value)	
		if value <= 100 then
			return math.floor(value/2)
		else
			return math.floor(50+(value-100)/(maxValue-100)*50)
		end	
	end
	
	function slider:onChange()
		local value = self:getValue()
		
	--	print("--onChange--getValueUp--",value,getValueUp(value))
		setFunc(optionName, getValueUp(value))
		
		static:setText(getValueUp(value) .. '%')
	end	
	
	self.restoreFunctions_[optionName] = function()
		local value = getFunc(optionName)
		setFunc(optionName, value)
	end
	
	self.updateFunctions_[optionName] = function()
		local value = getFunc(optionName)
		
	--	print("--updateFunctions_--",value,getValueDown(value))
		slider:setValue(getValueDown(value))
		static:setText(value .. '%')
	end	
end

local function bindSlider(self, slider, static, optionName, getFunc, setFunc, getDbValuesFunc)
	if optionName == 'switches' then
		return bindSlider300P(self, slider, static, optionName, getFunc, setFunc, getDbValuesFunc)
	end
	local dbValues = getDbValuesFunc(optionName)
	local range = dbValues[1]
	local minValue = range.min
	local maxValue = range.max
	
	--FIXME: muteValue должно устанавливаться в me_sound
	local muteValue = range.mute
	
	WidgetUtils.fillSlider(slider, dbValues)
	
	local getPercents = function(value)	
		return math.floor(((value - minValue) / (maxValue - minValue)) * 100)
	end
	
	function slider:onChange()
		local value = self:getValue()
		
		if value == minValue then
			setFunc(optionName, muteValue)
		else
			setFunc(optionName, value)
		end	
		
		static:setText(getPercents(value) .. '%')
	end	
	
	self.restoreFunctions_[optionName] = function()
		local value = getFunc(optionName)
		if value == muteValue then
			value = minValue
		end

		setFunc(optionName, value)
	end
	
	self.updateFunctions_[optionName] = function()
		local value = getFunc(optionName)
		
		if value == muteValue then
			value = minValue
		end
		
		slider:setValue(value)
		static:setText(getPercents(value) .. '%')
	end
end

local function bindControls(self, a_style, a_w, a_h)
	local container	= self:getContainer()
	
	self:bindOptionsContainer(container, 'Sound')
	
	if _G.__PRODUCT_ID__ == 2 then
		container.musicLabel:setVisible(false)
		container.musicSlider:setVisible(false)	
		container.musicWidget:setVisible(false)	
		
		container.switchesLabel:setPosition(184, 293)
		container.switchesSlider:setPosition(350, 290)
		container.switchesWidget:setPosition(633, 292)
	end
end

local function onOptionsRestored(self)
	local container	= self:getContainer()
	local getOptionsDbFunc = self.controller_['getSoundDb']
	
	for optionName, dbOption in pairs(getOptionsDbFunc()) do
		local widgetType = dbOption.control
		
		if DbOption.sliderName() == widgetType then
			local value = self.controller_.getSound(optionName)
			self.restoreFunctions_[optionName]()
		end
	end
end

local function updateDevices(self)
	local container = self:getContainer()
	local Name = DbOption.Item
	local function getDevices()
		local devices = mod_sound.getDevices()
		local result = {Name(_('Default')):Value("")}

		for k,v in ipairs(devices) do
			table.insert(result,Name(v[2]):Value(v[1]))
		end

		return result
	end

	self.controller_.setSoundValues("main_output", getDevices())
	self.controller_.setSoundValues("hp_output", getDevices())
	
	container.main_outputComboList:clear()
	container.hp_outputComboList:clear()
	WidgetUtils.fillComboList(container.main_outputComboList, self.controller_.getSoundValues("main_output")) 
	WidgetUtils.fillComboList(container.hp_outputComboList, self.controller_.getSoundValues("hp_output")) 
	
	self:updateOption("main_output")
	self:updateOption("hp_output")
end


return Factory.createClass({
	construct			= construct,
	bindSlider			= bindSlider,
	bindControls		= bindControls,
	loadFromResource	= loadFromResource,
	onOptionsRestored	= onOptionsRestored,
	updateDevices		= updateDevices,
}, TabViewBase)
