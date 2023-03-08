--revised 20. Jan 2015.
--/N/ this script holds navigation data to be used with MiG-21BiS mod

--[[
/N/ Instructions for inserting a custom station:

1. RSBN
		RSBN table can hold up to 100 stations. 
		See the commented example at the end of active stations sequence.
		- uncomment or add additional station (copy-paste existing one),
		- change it according to this example:
		
		{
			airbase = 'AAAAAA',	-- name of station, ignore "airbase" variable name
			lat = YY.YYYY, -- latitude from Editor map
			long = XX.XXXX, -- longitude from Editor map
			alt = HHH, -- above sea altitude on station location, read from Editor map
			rwy = CC, -- if station is near RWY, this will be the PRMG course, insert value between 0-180 in degrees
			length = LLLL, -- length of the RWY if exist, if not - put 2500 (in meters)
			code = '.- -. .- ' -- Morse code, be very careful, separate letters with one space, put one space at the end
		},

2. ARK
		for ARK data -> Every 10th channel MUST be empty, like it is now!
		Go to first free slot that has
			country = 0
		value.

		Edit it in this manner:

		{
			country = 'CCC - description here',
			freq = FFF, -- frequency number if you know it, if not - put 3 digit number
			lat = YY.YYYY, -- latitude from Editor map
			long = XX.XXXX, -- longitude from Editor map
			location = 'LLLL', -- map sector from Editor map, this should help you find your station later
			code = '--.. - ...-- ..--- ' -- Morse code, be very careful, separate letters with one space, put one space at the end
		},

]]

--[[

Add an entry into the Maps_Table for each theatre.

]]--

Maps_Table = {
	"Caucasus",
	"Nevada",
	"Normandy",
	"PersianGulf",
	"TheChannel",
	"Syria"
}

--[[

The naming convention for the NAV files is:
	R_NAV_data_[Theatre].lua

Examples:
	R_NAV_data_Caucasus.lua
	R_NAV_data_Nevada.lua

Each NAV file must contain two tables, a RSBN and an ARK table.
The naming convention for RSBN and ARK tables is:
	RSBN_data_[Theatre]
	ARK_data_[Theatre]

Examples:
	RSBN_data_Caucasus
	ARK_data_Nevada

]]--

for k,v in pairs(Maps_Table) do
	local name = LockOn_Options.script_path.."Systems/R_NAV_data_"..v..".lua"
	print("loading navigation data: ",name)
	dofile(LockOn_Options.script_path.."Systems/R_NAV_data_"..v..".lua")
end
	
need_to_be_closed = true