dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/MPD_page_defs.lua")

function add_Harm_Ovrd_PB16()
	local pb16 = add_PB_label(16,	{"HRM OVRD", nil, {{"MPD_HARM_OVRD_Opt", 0}}, {{"MPD_HARM_OVRD_Opt", 1}}},
									{"", nil, {{"MPD_HARM_OVRD_Opt", 2}}})[3]
	pb16.formats = {"",
					"SP",
					"TOO",
					"PB",
					"SP"
					}
end

HARM_Classes = {
	"",
	"ALL",
	"FRD",
	"HOS",
	"FN",
	"HN",
	"F1",
	"F2",
	"H1",
	"H2",
	"FAA",
	"HAA",
	"FS",
	"HS",
	"UKN",
	"PRI"}
