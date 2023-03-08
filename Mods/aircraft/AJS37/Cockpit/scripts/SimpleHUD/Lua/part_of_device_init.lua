if not indicators then
   indicators  = {}
end

indicators[#indicators + 1]   = {
"Samples::HUD_Indicator"				  , -- name of created class 
LockOn_Options.script_path.."SimpleHUD/Lua/HUD_init.lua", -- file parsed on init
nil, -- not linked to any avDevice 
{
	--{"HUD-CENTER", "HUD-DOWN", "HUD-RIGHT"}, -- geometry anchors from cockpit shape ,we will comment them at the moment
	
	
}
}
