--please keep fields  "width", "height"  and "aspect" always  empty to start with user primary display resolution
options = {
	["VR"] = {
		["box_mouse_cursor"] = true,
		["enable"] = false,
		["pixel_density"] = 1,
		["use_mouse"] = true,
		["bloom"] = true,
		["msaaMaskSize"] = 0.42,
		["mirror_crop"] = false,
		["mirror_source"] = 0,
		["mirror_use_DCS_resolution"] = false,
	},
	["difficulty"] = {
		["avionicsLanguage"] = "native",
		["birds"] = 0,
		["cockpitStatusBarAllowed"] = false,
		["cockpitVisualRM"] = false,
		["easyCommunication"] = true,
		["easyFlight"] = false,
		["externalViews"] = true,
		["fuel"] = false,
		["geffect"] = "realistic",
		["hideStick"] = false,
		["iconsTheme"] = "nato",
		["immortal"] = false,
		["labels"] = 1,
		["map"] = true,
		["miniHUD"] = false,
		["optionsView"] = "optview_all",
		["padlock"] = true,
		["permitCrash"] = true,
		["radio"] = false,
		["reports"] = true,
		["setGlobal"] = true,
		["spectatorExternalViews"] = true,
		["tips"] = true,
		["units"] = "imperial",
		["userMarks"] = true,
		["userSnapView"] = true,
		["weapons"] = false,
		["RBDAI"] = true,
		["controlsIndicator"] = true,
		["autoTrimmer"] = false,
		["wakeTurbulence"] = false,
		["unrestrictedSATNAV"] = false,
	},
	["format"] = 1,
	["graphics"] = {
		["DOF"] = 0,
		["LensEffects"] = 3,
		["MSAA"] = 2,
		["SSAA"] = 0,
		["SSLR"] = 0,
		["SSAO"] = 0,
		["ScreenshotExt"] = "jpg",
		["anisotropy"] = 4,
		["civTraffic"] = "",
		["clouds"] = 1,  -- используется в симе без возможности изменения в GUI
		["clutterMaxDistance"] = 0,
		["cockpitGI"] = 1,
		["effects"] = 3, -- используется в симе без возможности изменения в GUI
		["lights"] = 2,
		["shadowTree"] = false,
		["flatTerrainShadows"] = 0,
		["fullScreen"] = false,
		["heatBlr"] = 0,
		["multiMonitorSetup"] = "1camera",
		["preloadRadius"] = 150000,
		["shadows"] = 2,
		["BlurFlatShadows"] = 0,
		["secondaryShadows"] = 0,
		["sync"] = false,
		["terrainTextures"] = "min",
		["textures"] = 0,
		["forestDetailsFactor"] = 1,
		["forestDistanceFactor"] = 0.5,
		["visibRange"] = "High",
		["water"] = 2,
		["motionBlur"] = 0,
		["motionBlurAmount"] = 1,
		["chimneySmokeDensity"] = 4,
		["useDeferredShading"] = 1,
		["outputGamma"]= 2.2,
		["defaultFOV"] = 78,
		["messagesFontScale"]= 1,
		["scaleGui"]= 1,
		["sceneryDetailsFactor"] = 1,
	},
	["miscellaneous"] = {
		["Coordinate_Display"] = "Lat Long",
		["F2_view_effects"] = 1,
		["allow_server_screenshots"] = false,
		["TrackIR_external_views"] = true,
		["accidental_failures"] = false,
		["chat_window_at_start"] = true,
		["f10_awacs"] = true,
		["f11_free_camera"] = true,
		["f5_nearest_ac"] = true,
		["force_feedback_enabled"] = true,
		["headmove"] = false,
		["show_pilot_body"] = false,
		["synchronize_controls"] = false,
		["autologin"] = false,
		["collect_stat"] = false,
	},
	["plugins"] = {
	},
	["sound"] = {
		["GBreathEffect"] = true,
		["cockpit"] = 100,
		["gui"] = 100,
		["headphones"] = 100,
		["hear_in_helmet"] = false,
		["music"] = 60,
		["radioSpeech"] = true,
		["subtitles"] = true,
		["volume"] = 80,
		["world"] = 100,
		["headphones_on_external_views"] = true,
		["hp_output"] = "",
		["main_output"] = "",
		["main_layout"] = "",
		["switches"] = 100,
		["voice_chat_output"] = "",
		["voice_chat_input"] = "",
		["voice_chat"] = true,
		["play_audio_while_minimized"] = false,
		["microphone_use"] = 2,
		["FakeAfterburner"] = false,
	},
	["views"] = {
		["cockpit"] = {
			["avionics"] = 0,
			["mirrors"] = false,
			["reflections"] = false,
		},
	},
}
