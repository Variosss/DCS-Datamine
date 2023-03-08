local gettext = require("i_18n")
_ = gettext.translate

device_timer_dt		= 0.05	-- 20 Hz
need_to_be_closed	= true	-- lua_state  will be closed in post_initialize()

-------------------------------------------------------------------------------------------------
-- TACAN Data Stored in Memory (only for T4) ----------------------------------------------------
local fileName =  get_terrain_related_data("beacons") or get_terrain_related_data("beaconsFile")
if 	  fileName then
	local f = loadfile(fileName)
	if    f     then
		  f()
	end
end

theatre          = get_terrain_related_data("name")

TACAN_Data = {}
if beacons then

	local beacons_by_id = {}
	for i,o in pairs(beacons) do
		if (o.type == BEACON_TYPE_TACAN) or (o.type == BEACON_TYPE_VORTAC) then
			beacons_by_id[o.beaconId] = o
		end
	end

	local getTACAN = function (id)
		local res = {}
		res.Channel		= beacons_by_id[id].channel
		res.Elevation	= beacons_by_id[id].position[2]
		res.Latitude	= beacons_by_id[id].positionGeo.latitude
		res.Longitude	= beacons_by_id[id].positionGeo.longitude
		return	res
	end
	
	local theatre_ = theatre or "none"

	if theatre_ == 'Caucasus' then
		TACAN_Data = { 
			getTACAN('airfield22_2'),	-- BTM
			getTACAN('airfield24_4'),	-- KBL
			getTACAN('airfield25_3'),	-- KTS
			getTACAN('airfield29_9'),	-- GTB
			getTACAN('airfield23_4'),	-- TSK
			getTACAN('airfield31_4'),	-- VAS
			--getTACAN(''),	-- 
			--getTACAN(''),	-- 
			--getTACAN(''),	-- 
			--getTACAN(''),	-- 
		}
	elseif theatre == 'Nevada' then
		TACAN_Data = { 
			getTACAN('airfield1_4'),	-- IndianSprings
			getTACAN('airfield2_2'),	-- Groom_Lake
			getTACAN('airfield4_1'),	-- Nellis
			getTACAN('airfield18_4'),	-- Silverbow
			getTACAN('airfield3_4'),	-- LasVegas
			getTACAN('world_5'),	-- Daggett
			getTACAN('world_19'),	-- PeachSprings
			getTACAN('world_14'),	-- BryceCanyon
			getTACAN('world_12'),	-- WilsonCreek
			getTACAN('world_18'),	-- Coaldale
		}
	end
end

-- Failures
F18_MC_FAILURE	= 0

Damage = {	
	{Failure = F18_MC_FAILURE,	Failure_name = "Failure_Comp_MC1",	Failure_editor_name = _("MC 1 FAILURE"),	Element = 4,	Integrity_Treshold = 0.7, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
}