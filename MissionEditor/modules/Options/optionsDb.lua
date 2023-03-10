local videoModes = ...

-- база данных для настроек
local DbOption			= require('Options.DbOption')
local i18n				= require('i18n')
local lfs				= require('lfs')
local optionsUtils		= require('Options.optionsUtils')
local mod_sound			= require('sound')
local Gui 				= require('dxgui')
local _ = i18n.ptranslate

local difficultyOptions = {}
local graphicOptions = {}
local viewsOptions = {cockpit = {}}
local viewsCockpitOptions = viewsOptions.cockpit
local soundOptions = {}
local miscOptions = {}
local VROptions = {}



local function VR(name)
	VROptions[name] = DbOption.new()
	
	return VROptions[name]
end

local function difficulty(name)
	difficultyOptions[name] = DbOption.new()
	
	return difficultyOptions[name]
end

local function graphics(name)
	graphicOptions[name] = DbOption.new()
	
	return graphicOptions[name]
end

local function viewsCockpit(name)
	viewsCockpitOptions[name] = DbOption.new()
	
	return viewsCockpitOptions[name]
end

local function sound(name)
	soundOptions[name] = DbOption.new()
	
	return soundOptions[name]
end

local function misc(name)
	miscOptions[name] = DbOption.new()
	
	return miscOptions[name]	
end

--[[
local relationsDeferredShading = 
{	
	[0] = {
		action = {
			["cockpitGI"] = 0,
		},
		enabled = {
			["cockpitGI"] = false,
			["HDR"] = true,
			["outputGamma"] = false,
		},
	},
	[1] = {
		action = {
			["HDR"] = 0,
		},
		enabled = {
			["HDR"] = false,
			["cockpitGI"] = true,
			["outputGamma"] = true,
		},
	},
}
]]

-- использование:
-- combo({	Name('Name 1'):Value(0),
--			Name('Name 2'):Value(1):OnlyArch64(),
--			...			
--})
local Name = DbOption.Item

-- использование:
-- slider(Range(-30, 0):Mute(-100):OnlyArch64())
--})
local Range = DbOption.Range

local function getDevices()
	local devices = mod_sound.getDevices()
	local result = {Name(_('Default')):Value("")}

	for k,v in ipairs(devices) do
		table.insert(result,Name(v[2]):Value(v[1]))
	end

	return result
end

local function getLayouts()
	local layouts = mod_sound.getLayouts()
	local result = {Name(_('Auto')):Value("")}

	for k,v in ipairs(layouts) do
		table.insert(result,Name(v[2]):Value(v[1]))
	end

	return result
end

local function getVoiceChatDevices(dev_type)
	local devices = mod_sound.getVoiceChatDevices(dev_type)		
	local result = {Name(_('Default')):Value("")}
	
	if devices then
		for k,v in ipairs(devices) do
			table.insert(result,Name(v[2]):Value(v[1]))
		end
	end
	
	return result
end

difficulty('easyFlight')				:setValue(true)		:checkbox():setEnforceable():low(true)	:medium(false)	:high(false)
difficulty('radio')						:setValue(false)	:checkbox():setEnforceable():low(true)	:medium(false)	:high(false)
difficulty('tips')						:setValue(true)		:checkbox():low(true)	:medium(true)	:high(true)
difficulty('permitCrash')				:setValue(true)		:checkbox():setEnforceable():low(true)	:medium(true)	:high(false)
difficulty('easyCommunication')			:setValue(true)		:checkbox():setEnforceable():low(true)	:medium(true)	:high(false)
difficulty('padlock')					:setValue(true)		:checkbox():setEnforceable():low(true)	:medium(true)	:high(false)
difficulty('labels')					:setValue(1)		:combo({
																	Name(_('FULL'))			:Value(1),
																	Name(_('ABBREVIATED'))	:Value(2),
																	Name(_('SYMBOL ONLY'))	:Value(3),	
																	Name(_('DOT NEUTRAL'))	:Value(4),	
																	Name(_('NO LABELS'))	:Value(0),
																}):setEnforceable():low(1):medium(1):high(0)																			



difficulty('fuel')						:setValue(false)	:checkbox():setEnforceable():low(false)	:medium(false)	:high(false)
difficulty('weapons')					:setValue(false)	:checkbox():setEnforceable():low(false)	:medium(false)	:high(false)
difficulty('immortal')					:setValue(false)	:checkbox():setEnforceable():low(false)	:medium(false)	:high(false)
difficulty('reports')					:setValue(false)	:checkbox()
difficulty('miniHUD')					:setValue(false)	:checkbox():setEnforceable():low(true)	:medium(true)	:high(false)
difficulty('setGlobal')					:setValue(false)	:checkbox()
difficulty('cockpitVisualRM')			:setValue(false)	:checkbox():setEnforceable():low(false)	:medium(false)	:high(false)

difficulty('birds')						:setValue(0):setEnforceable()
															:slider(Range(0, 1000)):low(0):medium(0):high(0)
difficulty('optionsView')				:setValue('optview_all'):setEnforceable()
															:radio({Name('mapOnly')		:Value('optview_onlymap'),
																	Name('myPlane')		:Value('optview_myaircraft'),
																	Name('allies')		:Value('optview_allies'),
																	Name('alliesOnly')	:Value('optview_onlyallies'),
																	Name('all')			:Value('optview_all'),
																}):low('optview_all'):medium('optview_all'):high('optview_all')


difficulty('avionicsLanguage')			:setValue('native'):combo({	Name(_('NATIVE'))	:Value('native'),
																	Name(_('ENGLISH'))	:Value('english'),
																})
											
difficulty('units')						:setValue('metric'):combo({	Name(_('IMPERIAL'))	:Value('imperial'),
																	Name(_('METRIC'))	:Value('metric'),
																})
difficulty('heading_units')				:setValue(1):combo({	Name(_('degrees'))	:Value(1),
																Name(_('mils'))		:Value(2),
																})

difficulty('externalViews')				:setValue(true)		:checkbox():setEnforceable():low(true)	:medium(true)	:high(true)
difficulty('spectatorExternalViews')	:setValue(true)		:checkbox()
difficulty('userSnapView')				:setValue(true)		:checkbox()					:low(true)	:medium(true)	:high(true)

if __PRODUCT_ID__ == 2 then
	difficulty('iconsTheme')				:setValue('nato')	:combo({Name(_('NATO'))		:Value('nato'),
																})
else
	difficulty('iconsTheme')				:setValue('nato')	:combo({Name(_('NATO'))		:Value('nato'),
																	Name(_('Russia'))	:Value('russian'),
																})
end																

difficulty('geffect')					:setValue('none')	:combo({Name(_('None'))		:Value('none'),
																	Name(_('REDUCED'))	:Value('reduced'),
																	Name(_('REALISTIC')):Value('realistic'),
																}):low('none'):medium('reduced'):high('realistic')																			

difficulty('hideStick')					:setValue(false)	:checkbox()
difficulty('userMarks')					:setValue(true)		:checkbox():setEnforceable()

difficulty('controlsIndicator')			:setValue(true)		:checkbox()
difficulty('RBDAI')						:setValue(true)		:checkbox():setEnforceable()
difficulty('cockpitStatusBarAllowed')	:setValue(false)	:checkbox():setEnforceable()
difficulty('wakeTurbulence')			:setValue(false)	:checkbox():setEnforceable()
difficulty('autoTrimmer')				:setValue(false)	:checkbox()
difficulty('unrestrictedSATNAV')		:setValue(false)	:checkbox():setEnforceable()

graphics('textures')					:setValue(0)		:combo({Name(_('LOW'))		:Value(0),
																	Name(_('MEDIUM'))	:Value(1),
																	Name(_('HIGH'))		:Value(2)			:OnlyArch64(),
																}):low(0):medium(1):high(2):VR(1)
									
graphics('terrainTextures')				:setValue(0)		:combo({Name(_('LOW'))		:Value('min'),
																	Name(_('HIGH'))		:Value('max'),
																}):low('min'):medium('min'):high('max'):VR('min')									

graphics('flatTerrainShadows')			:setValue(0)		:combo({Name(_('Default'))	:Value(0),
																	Name(_('Flat'))		:Value(1),
																	Name(_('Off'))		:Value(2),
																}):low(1):medium(1):high(0):VR(1)		 

graphics('cockpitGI')					:setValue(0)		:combo({Name(_('OFF'))		:Value(0),
																	Name(_('ON'))		:Value(1),
																}):low(0):medium(0):high(1):VR(0)

graphics('civTraffic')					:setValue(''):setEnforceable()
															:combo({	Name(_('OFF'))	:Value(''),
																	Name(_('LOW'))		:Value('low'),
																	Name(_('MEDIUM'))	:Value('medium'),
																	Name(_('HIGH'))		:Value('high')		:OnlyArch64(),
																}):low(''):medium('medium'):high('high'):VR('low') 

graphics('water')						:setValue(2)		:combo({Name(_('LOW'))		:Value(0),
																	Name(_('MEDIUM'))	:Value(1),
																	Name(_('HIGH'))		:Value(2),
																}):low(0):medium(1):high(2):VR(1)

graphics('visibRange')					:setValue('Low')	:combo({Name(_('LOW'))		:Value('Low'),
																	Name(_('MEDIUM'))	:Value('Medium'),
																	Name(_('HIGH'))		:Value('High'),
																	Name(_('ULTRA'))	:Value('Ultra')		:OnlyArch64(),
																	Name(_('EXTREME'))	:Value('Extreme')	:OnlyArch64(),
																}):low('Low'):medium('Medium'):high('High'):VR('Medium')
												
graphics('heatBlr')						:setValue(0)		:combo({Name(_('OFF'))		:Value(0),
																	Name(_('LOW'))		:Value(1),
																	Name(_('HIGH'))		:Value(2),
																}):low(0):medium(1):high(1):VR(0)
										
graphics('DOF')							:setValue(0)		:combo({Name(_('OFF'))		:Value(0),
																	Name(_('BOKEH'))	:Value(1),
																	Name(_('SIMPLE')):Value(2),
																}):low(0):medium(0):high(0):VR(0)

graphics('shadows')						:setValue(2)		:combo({Name(_('OFF'))		:Value(0),
																	Name(_('FLAT ONLY')):Value(1),
																	Name(_('LOW'))		:Value(2),
																	Name(_('MEDIUM'))	:Value(3),
																	Name(_('HIGH'))		:Value(4)
																}):low(1):medium(1):high(4):VR(3)
graphics('BlurFlatShadows')				:setValue(0)		:combo({Name(_('OFF'))		:Value(0),
																	Name(_('ON'))		:Value(1),
																}):low(0):medium(1):high(1)
graphics('secondaryShadows')			:setValue(0)		:combo({Name(_('OFF'))		:Value(0),
																	Name(_('ON'))		:Value(1),
																})									
graphics('MSAA')						:setValue(2)		:combo({Name(_('OFF'))		:Value(0),
																	Name('2x')			:Value(1),
																	Name('4x')			:Value(2)
																}):low(0):medium(0):high(1):VR(0)
graphics('aspect')						:setValue(4/3)
									
graphics('LensEffects')					:setValue(3)		:combo({Name(_('None'))		:Value(0),
																	Name(_('DIRT'))		:Value(1),
																	Name(_('FLARE_lenseffect','FLARE')):Value(2),
																	Name(_('DIRT+FLARE')):Value(3),
																}):low(0):medium(0):high(0):VR(0)

graphics('clouds'):setValue(1):combo({	Name(_('LOW_CLOUDS', 'LOW'))		   	:Value(0),
										Name(_("STANDARD_CLOUDS","STANDARD"))	:Value(1),
										Name(_('HIGH_CLOUDS', 'HIGH'))			:Value(2),
										Name(_('ULTRA_CLOUDS', 'ULTRA'))		:Value(3),
                               }):low(0):medium(1):high(2)
								
graphics('anisotropy')					:setValue(4)		:combo({Name(_('OFF'))		:Value(0),
																	Name('2x')			:Value(1),
																	Name('4x')			:Value(2),
																	Name('8x')			:Value(3),
																	Name('16x')			:Value(4),
																}):low(0):medium(2):high(3):VR(1)

graphics('SSAO')						:setValue(0)		:combo({Name(_('OFF'))		:Value(0),
																	Name(_('ON'))		:Value(1),
																}):low(0):medium(0):high(0):VR(0)

graphics('motionBlur')					:setValue(0)		:combo({Name(_('OFF'))		:Value(0),
																	Name(_('LOW'))		:Value(1),
																	Name(_('HIGH'))		:Value(2),
																}):low(0):medium(0):high(0):VR(0)

graphics('motionBlurAmount')			:setValue(1)		:slider(Range(1.0, 3.0))																

graphics('SSAA')						:setValue(0)		:combo({Name(_('OFF'))		:Value(0),
																	Name(_('x1.5'))		:Value(1),
																	Name(_('x2'))		:Value(2),
																}):low(0):medium(0):high(0):VR(0)

graphics('SSLR')						:setValue(0)		:combo({Name(_('OFF'))		:Value(0),
																	Name(_('ON'))		:Value(1),
																}):low(0):medium(0):high(1):VR(0)
																
graphics('SSAO')						:setValue(0)		:combo({Name(_('OFF'))		:Value(0),
																	Name(_('ON'))		:Value(1),
																}):low(0):medium(0):high(1):VR(0)
																
graphics('multiMonitorSetup')			:setValue('1camera'):combo(optionsUtils.getMultiMonitorSetupValues())

graphics('messagesFontScale')			:setValue(1)		:combo({Name('1')			:Value(1),
																	Name('1.25')		:Value(1.25),
																	Name('1.5')			:Value(1.5),
																	Name('1.75')		:Value(1.75),
																	Name('2')			:Value(2),
																})
graphics('ScreenshotExt')				:setValue('jpg')	:combo({Name('jpg')		:Value('jpg'),
																	Name('png')		:Value('png'),
																	Name('bmp')		:Value('bmp'),
																}):enabledSim()
																														
local screenWidths = {}
local screenHeights = {}

local primary_w
local primary_h
if  Gui and Gui.GetPrimaryMonitorSize then
	primary_w,primary_h = Gui.GetPrimaryMonitorSize()
else
	primary_w = 1280
	primary_h = 768
end

for i, videoMode in ipairs(videoModes) do
	table.insert(screenWidths, videoMode[1])
	table.insert(screenHeights, videoMode[2])
end	

graphics('width')						:setValue(primary_w)		:combo(screenWidths)
graphics('height')						:setValue(primary_h)		:combo(screenHeights)
graphics('sync')						:setValue(false)	:checkbox()
graphics('fullScreen')					:setValue(false)	:checkbox()
graphics('scaleGui')					:setValue(1)		:combo({Name('1')			:Value(1),
																	Name('1.25')		:Value(1.25),
																	Name('1.5')			:Value(1.5),
																	Name('1.75')		:Value(1.75),
																	Name('2')			:Value(2),
																})

graphics('rainDroplets')				:setValue(false)	:checkbox():low(false):medium(false):high(true):VR(false)


graphics('forestDistanceFactor')		:setValue(0.5)		:slider(Range(0.3, 1))	:low(0.3)	:medium(0.7)	:high(1):VR(0.5):enabledSim()
graphics('clutterMaxDistance')			:setValue(0)		:slider(Range(0, 1500))		:low(0)		:medium(500)	:high(1000)	:VR(750):enabledSim()
graphics('forestDetailsFactor')			:setValue(1)		:slider(Range(0.1,1))		:low(1)		:medium(1)		:high(1)	:VR(1):enabledSim()
graphics('preloadRadius')				:setValue(150000)	:slider(Range(100, 150000))	:low(100)	:medium(30000)	:high(60000):VR(100000)
graphics('chimneySmokeDensity')			:setValue(10)		:slider(Range(0, 10))		:low(1)		:medium(5)		:high(5)	:VR(0)
graphics('outputGamma')					:setValue(2.2)		:slider(Range(1.0, 3.5))	:low(2.2)	:medium(2.2)	:high(2.2)	:VR(2.2) :enabledSim()
graphics('defaultFOV')					:setValue(78)		:slider(Range(3, 140))		:low(78)    :medium(78)     :high(78)   :VR(78): enabledSim()
graphics('sceneryDetailsFactor')		:setValue(1)		:slider(Range(0.1,1))		:low(1)		:medium(1)		:high(1)	:VR(1): enabledSim()

viewsCockpit('avionics')				:setValue(1)		:combo({Name('256')					:Value(0),
																	Name('512')					:Value(1),
																	Name(_('512 every frame'))	:Value(2),
																	Name('1024')				:Value(3),
																	Name(_('1024 every frame'))	:Value(4),
																}):low(0):medium(1):high(3):VR(1)
												
viewsCockpit('mirrors')					:setValue(true) :checkbox()
viewsCockpit('reflections')				:setValue(true) :checkbox()

graphics('box_mouse_cursor')			:setValue(false):checkbox():enabledSim()

-- FIXME: это должно быть вынесено в me_music
-- Mute - значение, которое будет установлено вместо минимального
-- связано это с тем, что при значениях громкости, ниже определенного предела(-30)
-- часть звуков в симуляторе пропадает, 
-- поэтому для этих эффектов выставляется значение(-100 - выключить)
local Range = DbOption.Range

sound('volume')							:setValue(80)		:slider(Range(0, 100):Mute(0))
sound('music')							:setValue(60)		:slider(Range(0, 100):Mute(0))
sound('gui')							:setValue(100)		:slider(Range(0, 100):Mute(0))
sound('world')							:setValue(100)		:slider(Range(0, 100):Mute(0))
sound('cockpit')						:setValue(100)		:slider(Range(0, 100):Mute(0))
sound('headphones')						:setValue(100)		:slider(Range(0, 100):Mute(0))
sound('radioSpeech')					:setValue(true)		:checkbox()
sound('subtitles')						:setValue(true)		:checkbox()
sound('GBreathEffect')					:setValue(true)		:checkbox()
sound('hear_in_helmet')					:setValue(false)	:checkbox()
sound('headphones_on_external_views')	:setValue(true)		:checkbox()
sound('main_output')					:setValue("")		:combo(getDevices())
sound('main_layout')					:setValue("")		:combo(getLayouts())
sound('hp_output')						:setValue("")		:combo(getDevices())
sound('voice_chat_output')				:setValue("")		:combo(getVoiceChatDevices(0))
sound('voice_chat_input')				:setValue("")		:combo(getVoiceChatDevices(1))
sound('switches')						:setValue(100)		:slider(Range(0, 300))
sound('voice_chat')						:setValue(true)		:checkbox()
sound('play_audio_while_minimized')		:setValue(false)	:checkbox()
sound('FakeAfterburner')				:setValue(false)	:checkbox()


sound('microphone_use')					:setValue(2) :combo({Name(_('Use mic (Mic mode dropbox)', 'Activated'))		:Value(0),
															 Name(_('Mute mic (Mic mode dropbox)', 'Muted'))	:Value(1),
															 Name(_('Push to talk (Mic mode dropbox)', 'Push to talk')):Value(2),
													})

misc('synchronize_controls')			:setValue(false)	:checkbox()
misc('accidental_failures')				:setValue(false)	:checkbox():setEnforceable()
misc('headmove')						:setValue(false)	:checkbox()
misc('f5_nearest_ac')					:setValue(false)	:checkbox()
misc('f10_awacs')						:setValue(false)	:checkbox()
misc('f11_free_camera')					:setValue(false)	:checkbox()
misc('force_feedback_enabled')			:setValue(false)	:checkbox()

misc('Coordinate_Display')				:setValue('Lat Long')
															:combo({Name(_('Lat Long'))			:Value('Lat Long'),
																	Name(_('Lat Long Decimal Minutes'))	:Value('Lat Long Decimal'),
																	Name(_('MGRS GRID'))		:Value('MGRS'),
																	Name(_('Metric'))			:Value('Metric'),
																	Name(_('Precise Lat/Long'))	:Value('Precise Lat Long'),	
													})
misc('Datum')							:setValue(1)
															:combo({Name('WGS84')				:Value(1),
																	Name('ED50')				:Value(2),
													})
misc('F2_view_effects')					:setValue(1)		:combo({Name(_('None'))				:Value(0),
																	Name(_('FLOATING'))			:Value(1),
																	Name(_('SHAKING'))			:Value(2),
																})													
misc('show_pilot_body')					:setValue(false)	:checkbox()
misc('TrackIR_external_views')			:setValue(true)		:checkbox()
misc('chat_window_at_start')			:setValue(true)		:checkbox()
misc('autologin')						:setValue(false)	:checkbox()
misc('collect_stat')					:setValue(false)	:checkbox()
misc('allow_server_screenshots')		:setValue(false)	:checkbox()

misc('backup')							:setValue(false)	:checkbox()
misc('backupTime')						:setValue(5)		:slider(Range(1, 60))	

-------------------------------------------------------------
--VR

VR('enable')							:setValue(false)	:checkbox()					:low(false)	:medium(false)	:high(false):VR(true)
VR('pixel_density')						:setValue(1)		:slider(Range(0.5,2.5))		:low(1)		:medium(1)		:high(1)	:VR(1)
VR('use_mouse')							:setValue(true)		:checkbox()					:low(true)	:medium(true)	:high(true) :VR(true)
VR('box_mouse_cursor')					:setValue(true)		:checkbox()					:low(true)	:medium(true)	:high(true)	:VR(true)
VR('hand_controllers')					:setValue(true)		:checkbox()					:low(true)	:medium(true)	:high(true)	:VR(true)
VR('hand_controllers_use_stick')		:setValue(true)		:checkbox()					:low(true)	:medium(true)	:high(true)	:VR(true)
VR('hand_controllers_use_throttle')		:setValue(true)		:checkbox()					:low(true)	:medium(true)	:high(true)	:VR(true)
VR('hand_controllers_joint_throttle')	:setValue(false)	:checkbox()					:low(true)	:medium(true)	:high(true)	:VR(true)
VR('hand_controllers_debug_draw')		:setValue(false)	:checkbox()					:low(true)	:medium(true)	:high(true)	:VR(true)
VR('custom_IPD_enable')					:setValue(false)	:checkbox()					:low(false)	:medium(false)	:high(false):VR(false)
VR('custom_IPD')						:setValue(63.5)		:editbox()					:low(63.5)	:medium(63.5)	:high(63.5) :VR(63.5)
VR('prefer_built_in_audio')				:setValue(true)		:checkbox()					:low(true)	:medium(true)	:high(true)	:VR(true)
VR('interaction_with_grip_only')		:setValue(false)	:checkbox()					:low(false)	:medium(false)	:high(false):VR(false)
VR('bloom')								:setValue(true)		:checkbox()					:low(true)	:medium(true)	:high(true):VR(true)
VR('msaaMaskSize')						:setValue(0.42)		:slider(Range(0.1, 1.0))	:low(0.42)	:medium(0.42)	:high(0.42)	:VR(0.42) 

VR('mirror_source')						:setValue(0):combo({Name(_('LEFT EYE'))	:Value(0),
															Name(_('RIGHT EYE')):Value(1),
															Name(_('BOTH'))		:Value(2),}):low(0):medium(0):high(0):VR(0) 

VR('pointer_use_type')					:setValue(0):combo({Name(_('Use on both hands')) :Value(0),
															Name(_('Use on left hand'))	 :Value(1),
															Name(_('Use on right hand')) :Value(2),
															Name(_('No pointers'))		 :Value(3),
																}):low(0):medium(0):high(0):VR(0) 

VR('mirror_crop')						:setValue(false):checkbox():low(false):medium(false):high(false):VR(false)
VR('mirror_use_DCS_resolution')			:setValue(false):checkbox():low(false):medium(false):high(false):VR(false)
VR('enableHMDMask')						:setValue(true):checkbox() :low(true) :medium(true) :high(true) :VR(true)
-------------------------------------------------------------


return {
	difficulty		= difficultyOptions,
	graphics		= graphicOptions,
	views			= viewsOptions,
	sound			= soundOptions,
	miscellaneous	= miscOptions,
	VR 				= VROptions
}
