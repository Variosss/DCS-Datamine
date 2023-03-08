dofile(LockOn_Options.script_path.."MFCD/indicator/TAD/MFCD_TAD_tools.lua")

Label_OSB = {}
Label_OSB[1]   = add_OSB_label(1, BRANCH_L .. "CNTL")

addOSB_Box(1, {Label_OSB[1]})

hints_osb = {}
local fmt = _("Activate %s profile")
for i = 2, 5 do
	Label_OSB[i] = add_OSB_label(i ,"")
	Label_OSB[i].formats = {"%s"}
	Label_OSB[i].controllers	= {{"declutter"},
								   {"tad_PPP_OSB_label", 0, i - 1},
								   {"tad_color_current_profile", i - 1}}
								  
	local nm = "OSB_"..string.format("%02d",i)
	hints_osb[i] 				= CreateElement  "ceHint"
	hints_osb[i].hint_name      = hint_name[nm]
	hints_osb[i].controllers    = {{"tad_magic_button_hint",0,i - 1}}
	hints_osb[i].formats        = {fmt}
	Add(hints_osb[i])
	
	addOSB_Box(i, {Label_OSB[i]})
end

add_osb_static_hint(1,_("Go to TAD Profile Control page"))


