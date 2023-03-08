local  mission_category   = _("Get more missions with DCS: WWII Assets Pack")

declare_plugin("WWII Armour and Technics",
{
installed     = true,
dirName		  = current_mod_path,
displayName   = _("WWII Assets Pack"),
version		  =   __DCS_VERSION__,
state		  =   "sale",

linkBuy =
    {
        ED     = "https://www.digitalcombatsimulator.com/en/shop/modules/wwii_assets_pack/",
    },

attachMissionsToMods = 
	{
		["Bf 109 K-4 by Eagle Dynamics"] = 
		{
			name		=   mission_category,
			MissionsDir =  "Missions/Bf-109K-4",
			showLinkBuy = true,
		},
		["Spitfire LF Mk. IX by Eagle Dynamics"] = 
		{
			name		=   mission_category,
			MissionsDir =  "Missions/SpitfireLFMkIX",
			showLinkBuy = true,
		},
		["P-47D-30 by Eagle Dynamics"] = 
		{
			name		=   mission_category,
			MissionsDir =  "Missions/P-47D-30",
			showLinkBuy = true,
		},
		["FW-190D9 Dora by Eagle Dynamics"] = 
		{
			name		=   mission_category,
			MissionsDir =  "Missions/FW-190D-9",
			showLinkBuy = true,
		},
		["Fw 190 A-8 by Eagle Dynamics"] = 
		{
			name		=   mission_category,
			MissionsDir =  "Missions/FW-190A-8",
			showLinkBuy = true,
		},
		["P-51D Mustang by Eagle Dynamics"] = 
		{
			name		=   mission_category,
			MissionsDir =  "Missions/P-51D",
			showLinkBuy = true,
		},
		["DH.98 Mosquito FB Mk. VI by Eagle Dynamics"] = 
		{
			name		=   mission_category,
			MissionsDir =  "Missions/MosquitoFBVI",
			showLinkBuy = true,	
		},
	},
})

plugin_done()


