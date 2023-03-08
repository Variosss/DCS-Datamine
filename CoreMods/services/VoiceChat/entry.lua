local voicechat_disp  = _("VoiceChat")
declare_plugin("VoiceChat",
{
	dirName		  = current_mod_path,
	displayName   = voicechat_disp,
	shortName	  = "VoiceChat",
	fileMenuName  = "VoiceChat",
	version		  = __DCS_VERSION__,
	state		  = "installed",
	developerName = "Eagle Dynamics",
	info		  = "VoiceChat",
	binaries 	  = 
	{
		'VoiceChat',
	},
	Options 	  =
	{
		{
			name		= _("Voice Chat"),
			nameId		= "VoiceChat",
			dir		= "Options",
			CLSID		= "{Voice Chat}",
			allow_in_simulation = false,
		},
	},
})
plugin_done()
