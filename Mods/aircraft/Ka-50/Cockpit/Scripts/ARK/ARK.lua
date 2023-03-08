mode = ADF_ADF
receiver_mode = ADF_RECEIVER_TLF
homer_selection_method = ADF_HOMER_SELECTION_AUTO
channel = 1
volume = 0.5

local beacons_by_id = {}
if beacons then
	for i,o in pairs(beacons) do
		if o.beaconId ~= nil then
			beacons_by_id[o.beaconId] = o
		end	
	end
end

local NDB_pair = function (id_1,id_2)
		return	{
			[ADF_HOMER_FAR]  = NDB(beacons_by_id[id_1]),
			[ADF_HOMER_NEAR] = NDB(beacons_by_id[id_2])
		}
end

local theatre = theatre or "none"
if theatre == 'Caucasus' then
	channels = 
	{ 
		NDB_pair('airfield13_2'	,'airfield13_3'),
		NDB_pair('airfield16_2'	,'airfield16_3'),
		NDB_pair('airfield15_4'	,'airfield15_5'),
		NDB_pair('airfield12_0'	,'airfield12_1'),
		NDB_pair('airfield28_0'	,'airfield28_1'),
		NDB_pair('airfield27_0'	,'airfield27_1'),
		NDB_pair('airfield26_0'	,'airfield26_1'),
		NDB_pair('world_9'		,'world_58'),
	}
elseif theatre == 'Nevada' then
	channels = 
	{ 
		NDB_pair('airfield1_4'	,'airfield2_2'),
		NDB_pair('airfield3_4'	,'airfield4_1'),
		NDB_pair('world_8'		,'world_9'),
		NDB_pair('world_10'		,'world_11'),
		NDB_pair('world_12'		,'world_13'),
		NDB_pair('world_14'		,'world_15'),
		NDB_pair('world_16'		,'world_17'),
		NDB_pair('world_18'		,'world_19'),
		NDB_pair('world_20'		,'world_21'),
	}
end