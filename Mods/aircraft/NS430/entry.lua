if ED_MULTI_THREAD and ED_PUBLIC_AVAILABLE then 
	return
end

--do return end
local ns430_disp  = _("NS430")
declare_plugin("NS430",
{
	dirName		  = current_mod_path,
	displayName   = ns430_disp,
	shortName	  = "NS430",
	fileMenuName  = "NS430",
	update_id     = "NS430",
	registryPath  = "Eagle Dynamics\\NS430",
	version		  = __DCS_VERSION__,
	state		  = "installed",
	developerName = "Belsimtek",
	info		  = "NS430",
	MAC_ignore    = true,
	binaries 	  = 
	{
		'NS430',
	},
	load_immediately = true,
	InputProfiles =
	{
		["NS430"] = current_mod_path .. '/Input'
	},
	rules = 
	{	
		["jsAvionics"] = {required = true},
	},
	Options =
	{
		{
			name		=  ns430_disp,
			nameId		= "NS430",
			dir			= "Options",
		},
	},
})

mount_vfs_texture_path  (current_mod_path ..  "/Textures/NS430")
mount_vfs_model_path    (current_mod_path ..  "/Shapes")
local path = current_mod_path..'/Cockpit/Scripts/'

local  disabled =	{enable_options_key_for_unit = "disabled"}
 
add_plugin_systems('NS430','*',path,
{
	["A-10A"] 	= {enable_options_key_for_unit 		= "a10a_enabled"},
	----------------------------------------------------------------
	["A-10C"] 			= disabled,
	["A-10C_2"] 		= disabled,
	["Ka-50"] 			= disabled,
	["Ka-50_3"] 		= disabled,
	["F-16C_50"] 		= disabled,
	["FA-18C_hornet"] 	= disabled,
	["AH-64D_BLK_II"] 	= disabled,
	["Mi-24P"] 		= disabled,
	
	----------------------------------------------------------------

	["AJS37"] = {enable_options_key_for_unit 			= "ajs37_enabled"},
	["AV8BNA"] = {enable_options_key_for_unit 			= "av8b_enabled"},
	["C-101CC"] = {enable_options_key_for_unit 			= "c101cc_common_enabled"},
	["C-101EB"] = {enable_options_key_for_unit 			= "c101eb_common_enabled"},
	["F-15C"] = {enable_options_key_for_unit 			= "f15c_enabled"},
	["F-5E-3"] = {enable_options_key_for_unit 			= "f5e3_enabled"},
	["F-86F Sabre"] = {enable_options_key_for_unit 		= "f86f_enabled"},
	["J-11A"] = {enable_options_key_for_unit 			= "j11a_enabled"},
	["L-39ZA"] = {enable_options_key_for_unit 			= "l39za_enabled"},
	["M-2000C"] = {enable_options_key_for_unit 			= "miraj_enabled"},
	["MiG-15bis"] = {enable_options_key_for_unit 		= "mig15bis_enabled"},
	["MiG-21bis"] = {enable_options_key_for_unit 		= "mig21bis_enabled"},
	["MiG-29A"] = {enable_options_key_for_unit 			= "mig29a_enabled"},
	["MiG-29G"] = {enable_options_key_for_unit 			= "mig29g_enabled"},
	["MiG-29S"] = {enable_options_key_for_unit 			= "mig29s_enabled"},
	["Su-25"] = {enable_options_key_for_unit 			= "su25_enabled"},
	["Su-25T"] = {enable_options_key_for_unit 			= "su25t_enabled"},
	["Su-27"] = {enable_options_key_for_unit 			= "su27_enabled"},
	["Su-33"] = {enable_options_key_for_unit 			= "su33_enabled"},
	["Bf-109K-4"] = {enable_options_key_for_unit 		= "bf109k4_enabled"},
	["FW-190D9"] = {enable_options_key_for_unit 		= "fw190d9_enabled"},
	["I-16"] = {enable_options_key_for_unit 			= "i16_enabled"},
	["P-51D"] = {enable_options_key_for_unit 			= "p51d_enabled"},
	["SpitfireLFMkIX"] = {enable_options_key_for_unit 	= "SpitfireLFMkIX_enabled"},	
	["SpitfireLFMkIXCW"] = {enable_options_key_for_unit = "SpitfireLFMkIXCW_enabled"},
	["TF-51D"] = {enable_options_key_for_unit 			= "tf51d_enabled"},
	["Yak-52"] = {enable_options_key_for_unit 			= "yak52_enabled"},	
	["SA342L"] = {enable_options_key_for_unit 			= "sa342_enabled"},
	["SA342M"] = {enable_options_key_for_unit 			= "sa342_enabled"},
	["SA342Minigun"] = {enable_options_key_for_unit 	= "sa342_enabled"},
	["SA342Mistral"] = {enable_options_key_for_unit 	= "sa342_enabled"},
	["UH-1H"] = {enable_options_key_for_unit 			= "uh1h_enabled"},
	["Mi-8MT"] = {enable_options_key_for_unit 			= "mi8_common_enabled"},	
	["L-39C"] = {enable_options_key_for_unit 			= "l39c_common_enabled"},
	["Christen Eagle II"] 	= {enable_options_key_for_unit 			= "CE_II_enabled"},

	["F-14B"] 	= {enable_options_key_for_unit 			= "f14b_enabled"},
	["JF-17"] 	= {enable_options_key_for_unit 			= "jf17_enabled"},
	["Mi-24P"] 	= {enable_options_key_for_unit 			= "mi24p_enabled"},
})
turn_on_waypoint_panel('*',nil,true) -- enable custom fields only

plugin_done()
