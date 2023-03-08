----   DEBUG DEFINITIONS  -------------------------------------------
is_debug = false
----   END OF DEBUG DEFINITIONS  --------------------------------

package.path = package.path..";./Scripts/?.lua"

local S        = require("Serializer")
local gettext = require("i_18n")

_ = gettext.translate

default_db			= LockOn_Options.script_path.."TGP/Database/DataBase.lua"

function get_file_name(loader)
	local campaign = LockOn_Options.mission.campaign
	local mission  = LockOn_Options.mission.title
	local					  name     = db_path
	if campaign ~= "" then    name     = name .. campaign .. "/" end
	if mission  ~= "" then	  name     = name .. mission .. TGP_DB_name_suffix end
	return 					  name
end


mask = {}
mask[9] = {}
mask[9].regions = {}  
mask[1] = {}
mask[1].regions = {} 

use_real_mask_scheme_A10A = true -- mask from A-10A 
 
 local left =    {{math.rad(-21.096) ,math.rad(	0.198675)},--
				 {math.rad(-21.1053),math.rad(	9.7351)},--3
				 {math.rad(-23.5702),math.rad(	16.4901)},--4
				 {math.rad(-28.6709),math.rad(	21.457)},--5
				 {math.rad(-30.5834),math.rad(	25.8278)},--6
				 {math.rad(-36.2642),math.rad(	31.7881)},--7
				 {math.rad(-44.9967),math.rad(	35.1656)},--8
				 {math.rad(-50.7689),math.rad(	36.5563)},--9
				 {math.rad(-54.557) ,math.rad(	37.1523)},--10
				 {math.rad(-68.4258),math.rad(	43.7086)},--11
				 {math.rad(-76.1702),math.rad(	46.4901)},--12
				 {math.rad(-83.1424),math.rad(	47.8808)},--13
				 {math.rad(-89.7225),math.rad(	48.8742)},--14
				 {math.rad(-93.2603),math.rad(	61.9868)},--15
				 {math.rad(-98.2576),math.rad(	72.1192)},--16
				 {math.rad(-106.126),math.rad(	78.6755)},--17
				 {math.rad(-117.651),math.rad(	82.4503)},--18
				 {math.rad(-131.999),math.rad(	85.0331)},--19
				 {math.rad(-149.979),math.rad(	86.0265)},--20
				 {math.rad(-180)	,math.rad(	86.6225)},--21
				 {math.rad(-180)	,math.rad(	0)},--22
				 {math.rad(-176.96) ,math.rad(	-2.98013)},--23
				 {math.rad(-171.96) ,math.rad(	-2.98013)},--24
				 {math.rad(-168.124),math.rad(	-1.19205)},--25
				 {math.rad(-162.92) ,math.rad(	-0.993377)},--26
				 {math.rad(-160.556),math.rad(	-2.78146)},--27
				 {math.rad(-160.738),math.rad(	-11.9205)},--28
				 {math.rad(-156.838),math.rad(	-16.8874)},--29
				 {math.rad(-131.056),math.rad(	-27.8146)},--30
				 {math.rad(-113.948),math.rad(	-32.3841)},--31
				 {math.rad(-97.3993),math.rad(	-34.9669)},--32
				 {math.rad(-69.9993),math.rad(	-34.9669)},--33
				 {math.rad(-41.496) ,math.rad(	-29.8013)},--34
				 {math.rad(-33.149) ,math.rad(	-22.4503)},--35
				 {math.rad(-33.2748),math.rad(	-8.74172)},--36
				 {math.rad(-24.3477),math.rad(	-2.38411)}}--37


 local right =  {{math.rad( 31.304),math.rad(	0)},
				 {math.rad(31.7503),math.rad(	12.5166)},
				 {math.rad(29.3901),math.rad(	14.5033)},
				 {math.rad(29.2656),math.rad(	18.2781)},
				 {math.rad(37.2046),math.rad(	25.2318)},
				 {math.rad(50.5119),math.rad(	30.596)},
				 {math.rad(69.4113),math.rad(	35.5629)},
				 {math.rad(82.451) ,math.rad(	37.5497)},
				 {math.rad(92.0589),math.rad(	37.947)},
				 {math.rad(99.3715),math.rad(	63.5762)},
				 {math.rad(106.99) ,math.rad(74.5033)},
				 {math.rad(117.109),math.rad(	80.4636)},
				 {math.rad(133.993),math.rad(	84.6358)},
				 {math.rad(158.425),math.rad(	86.2252)},
				 {math.rad(180	)  ,math.rad(86.6225)},
				 {math.rad(180	)  ,math.rad(0)},
				 {math.rad(176.039),math.rad(	6.95364)},
				 {math.rad(170.639),math.rad(	6.95364)},
				 {math.rad(171.104),math.rad(	0.198675)},
				 {math.rad(165.769),math.rad(	-6.55629)},
				 {math.rad(119.558),math.rad(	-17.0861)},
				 {math.rad(101.903),math.rad(	-19.8675)},
				 {math.rad(86.8868),math.rad(-20.6623)},
				 {math.rad(58.8828),math.rad(	-20.8609)},
				 {math.rad(36.9185),math.rad(	-19.0728)},
				 {math.rad(30.8656),math.rad(	-11.7219)},
				 {math.rad(31.2881),math.rad(	0)}}

 
function make_region(source,indexes,inverse)
	local region = {}
 	i = 1
	for j = 1,#indexes do
		region[i]    = {}
		if inverse then	region[i][1] = -source[indexes[j]][1]
		else			region[i][1] =  source[indexes[j]][1]	
		end				region[i][2] =  source[indexes[j]][2]
		i = i + 1
	end
	return region
 end
 
 
 
if use_real_mask_scheme_A10A  then
 
mask[9].regions[1] = make_region(left,{36,35,4,3,2,1})
mask[9].regions[2] = make_region(left,{9,8,7,6,5,4})
mask[9].regions[3] = make_region(left,{35,26,25,13,12,11,10,9,4})
mask[9].regions[4] = make_region(left,{25,24,20,19,18,17,16,15,14,13})
mask[9].regions[5] = make_region(left,{24,23,22,21,20})
mask[9].regions[6] = make_region(left,{35,34,33,32,31,30,29,28,27,26})


mask[9].regions[7]  = make_region(right,{2,3,4,5,6,7,8,9})
mask[9].regions[8]  = make_region(right,{9,10,11,12,13,14,15,17,18})
mask[9].regions[9]  = make_region(right,{15,16,17})
mask[9].regions[10] = make_region(right,{9,18,19,20,21,22,23,24,25,26,2})

mask[1].regions[1] = make_region(left,{1,2,3,4,35,36},true)
mask[1].regions[2] = make_region(left,{4,5,6,7,8,9},true)
mask[1].regions[3] = make_region(left,{4,9,10,11,12,13,25,26,35},true)
mask[1].regions[4] = make_region(left,{13,14,15,16,17,18,19,20,24,25},true)
mask[1].regions[5] = make_region(left,{20,21,22,23,24},true)
mask[1].regions[6] = make_region(left,{26,27,28,29,30,31,32,33,34,35},true)


mask[1].regions[7]  = make_region(right,{9,8,7,6,5,4,3,2},true)
mask[1].regions[8]  = make_region(right,{18,17,15,14,13,12,11,10,9},true)
mask[1].regions[9]  = make_region(right,{17,16,15},true)
mask[1].regions[10] = make_region(right,{2,26,25,24,23,22,21,20,19,18,9},true)
 
else
 -- mask scheme generated with  DTS model and 3ds max 
mask[9].regions[1] ={{math.rad(-42),math.rad(-1.8)},
					 {math.rad(-74.4),-math.rad(1.8)},
					 {math.rad(-90),math.rad(15)},
					 {math.rad(-55.8),math.rad(15)},
					 {math.rad(-42),math.rad(3.6)}} 
					 
mask[9].regions[2] ={{math.rad(-74.4),math.rad(-1.8)},
					 {math.rad(-82.8),math.rad(-9.6)},
					 {math.rad(-180),math.rad(8.4)},
					 {math.rad(-90),math.rad(15)}}
					 
mask[9].regions[3] ={{math.rad(-180),math.rad(8.4)},
					 {math.rad(-180),math.rad(150)},
					 {math.rad(-139.2),math.rad(150)},
					 {math.rad(-117.6),math.rad(90)},
					 {math.rad(-90),math.rad(15)}}
					 
mask[9].regions[4] ={{math.rad(101.7),math.rad(16.8)},
					 {math.rad(180),math.rad(150)},
					 {math.rad(180),math.rad(8.4)},
					 {math.rad(142.5),math.rad(11.4)}}
					 
mask[9].regions[5] ={{math.rad(101.7),math.rad(16.8)},
					 {math.rad(142.5),math.rad(11.4)},
					 {math.rad(137.7),math.rad(6.0)},
					 {math.rad(101.7),math.rad(11.4)}}

					 
mask[1].regions[1] ={{math.rad(42),math.rad(3.6)},
					 {math.rad(55.8),math.rad(15)},
					 {math.rad(90),math.rad(15)},
					 {math.rad(74.4),-math.rad(1.8)},
					 {math.rad(42),math.rad(-1.8)}}
					 
mask[1].regions[2] ={{math.rad(90),math.rad(15)},
					 {math.rad(180),math.rad(8.4)},
					 {math.rad(82.8),math.rad(-9.6)},
					 {math.rad(74.4),math.rad(-1.8)}}
					 
mask[1].regions[3] ={{math.rad(90),math.rad(15)},
					 {math.rad(117.6),math.rad(90)},
					 {math.rad(139.2),math.rad(150)},		
					 {math.rad(180),math.rad(150)},	
					 {math.rad(180),math.rad(8.4)},}
					 
mask[1].regions[4] ={
					 {math.rad(-142.5),math.rad(11.4)},
					 {math.rad(-180),math.rad(8.4)},
					 {math.rad(-180),math.rad(150)},
					 {math.rad(-101.7),math.rad(16.8)},
					 }
					 
mask[1].regions[5] ={
					 {math.rad(-101.7),math.rad(11.4)},
					 {math.rad(-137.7),math.rad(6.0)},					 
					 {math.rad(-142.5),math.rad(11.4)},					 
					 {math.rad(-101.7),math.rad(16.8)}}
 
end

use_native_axis  = true
use_digital_zoom = false -- Set to false as digital zoom results in unacceptably low picture quality

keyboard_slew_magnifier = 5.0
use_synthetic_IR_effect = true -- false
			
ir_sharpness    = 0.0002 -- sharpness of TGP IR image, Float - 0...1.
ir_levels_count = 8      -- TGP IR image levels count, Int.
ir_gains_count  = 8	     -- TGP IR image gains count, Int.
ir_init_gain    = 4		 -- initial IR image gain value, Int - 0...8.
ir_init_level   = 4      -- initial IR image level value, Int - 0...8.
					 
local 	TGP  = GetSelf()

package.path = "?;?.lua;./Config/Export/?.lua;./Scripts/?.lua"

require("Vector")

function p(v)
	return string.format("(%f,%f,%f)",v.x,v.y,v.z)
end

function outline_segment(s1,s2,outline_value)
	
	local ret = {}

	local direction = {}
	
	direction[1] = s1.endpoint - s1.start
	direction[2] = s2.endpoint - s2.start
	direction[1]  = direction[1]:ort()
	direction[2]  = direction[2]:ort()
	
--	dbg_print(string.format("dir1    = %s\n",p(direction[1]) ))	
--	dbg_print(string.format("dir2     = %s\n",p(direction[2])))
	
	direction[3]  = direction[1] - direction[2]
	direction[3]  = direction[3]:ort()
	
	direction[1]  = direction[1]:rotZ(math.rad(90))
	direction[2]  = direction[2]:rotZ(math.rad(90))
	
--	dbg_print(string.format("dir1     = %s\n",p(direction[1])))	
--	dbg_print(string.format("dir2     = %s\n",p(direction[2])))
--	dbg_print(string.format("dir3     = %s\n",p(direction[3])))

    local ret1 	= s1.endpoint + direction[1] * outline_value
	local ret2  = s1.endpoint + direction[3] * outline_value
	local ret3  = s1.endpoint + direction[2] * outline_value
	
	ret[1] = {ret1.x,ret1.y}
	ret[2] = {ret2.x,ret2.y}
	ret[3] = {ret3.x,ret3.y}
	
	
--	dbg_print(string.format("point    = %s\n",p(s1.endpoint)))
--	dbg_print(string.format("outlined = %s,%s,%s",p(ret1),
--												  p(ret2),
--												  p(ret3)))
	return ret
end

function outline_region(region,outline_value)

	local ret = {}
	local n   = 0
	local number = #region
	for i = 1,number do
		
		local j_prev = i - 1
		local j		 = i
		local j_next = i + 1
		
		if  i == 1 		then    j_prev = number	end
		if  i == number then    j_next = 1		end

		local s1 = {}
		local s2 = {}

		s1.start 	  = Vector(region[j_prev][1],region[j_prev][2],0)
		s1.endpoint   = Vector(region[j][1]     ,region[j][2]     ,0)
	
		s2.start	  = Vector(region[j][1]     ,region[j][2]     ,0)
		s2.endpoint   = Vector(region[j_next][1],region[j_next][2],0)
		
		local points   = outline_segment(s1,s2,outline_value)
		
		ret[n + 1] = points[1]
		ret[n + 2] = points[2]
		ret[n + 3] = points[3]
		n = n + 3
	end
	return ret
end


function post_initialize()
	
	local i = 1
	local station  = TGP:get_station()

	if station > 5 then i = 9 end
	
	if mask[station] and mask[station].regions then
		i = station 
	end
	for i,v in pairs(mask[i].regions) do
		local reg = outline_region(v,math.rad(5))
	
		TGP:add_masked_region(v,false)
		TGP:add_masked_region(reg,true)
	end
	TGP:set_laser_designation_code(1688)
	TGP:set_laser_spot_search_code(1688)
end


function ReadAALaser(str)
	str, temp	= GetStringField(str)
	str, temp	= GetStringField(str)

	if nil ~= string.find(temp, "Enabled", 1, true) then
		TGP_data["AALaser"] = true
	else
		TGP_data["AALaser"] = false
	end

	str, temp	= GetStringField(str)
	str, temp	= GetStringField(str)
	str, temp	= GetStringField(str)

	str, temp	= GetNumberField(str)
	TGP_data["TAAFAltitude"] = temp
end

function ReadFLIRIntegration(str)
	str, temp	= GetStringField(str)
	str, temp	= GetStringField(str)

	if nil ~= string.find(temp, "Hot", 1, true) then
		TGP_data["FLIRIntegration"] = 0
	else
		TGP_data["FLIRIntegration"] = 1
	end
end

function ReadCalibrationMethod(str)
	str, temp	= GetStringField(str)
	str, temp	= GetStringField(str)

	if nil ~= string.find(temp, "Short", 1, true) then
		TGP_data["CalibrationMethod"] = 0
	else
		TGP_data["CalibrationMethod"] = 1
	end

	str, temp	= GetStringField(str)
	str, temp	= GetNumberField(str)
	TGP_data["LSSCode"] = temp
end

function ReadGainControl(str)
	str, temp	= GetStringField(str)
	str, temp	= GetStringField(str)

	if nil ~= string.find(temp, "Auto", 1, true) then
		TGP_data["GainControl"] = 1
	else
		TGP_data["GainControl"] = 0
	end

	str, temp	= GetStringField(str)
	str, temp	= GetNumberField(str)
	TGP_data["LCode"] = temp
end

function Read_from_CDU_DB(f)
	TGP_data = {}
	
	local str
	str=f:read()
	while nil ~= str do
		if nil ~= string.find(str, "Air-to-Air Laser:", 1, true) then
			ReadAALaser(str)
		end
		if nil ~= string.find(str, "FLIR Integration:", 1, true) then
			ReadFLIRIntegration(str)
		end
		if nil ~= string.find(str, "Calibration Method:", 1, true) then
			ReadCalibrationMethod(str)
		end
		if nil ~= string.find(str, "Gain Control:", 1, true) then
			ReadGainControl(str)
		end
		str=f:read()
	end
end

-- SETTINGS_PATH is left for compatibility with old missions
SETTINGS_PATH = "TGP/settings.lua"
dofile(LockOn_Options.common_script_path.."mission_prepare.lua")

TGP_FAILURE_RIGHT	= 0
TGP_FAILURE_LEFT	= 1
Damage = {	{Failure = TGP_FAILURE_RIGHT, Failure_name = "TGP_FAILURE_RIGHT", Failure_editor_name = _("TGP total failure"),  Element = 30, Integrity_Treshold = 0.5, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
			{Failure = TGP_FAILURE_LEFT, Failure_name = "TGP_FAILURE_LEFT", Failure_editor_name = _("TGP total failure"),  Element = 29, Integrity_Treshold = 0.5, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300}}
		
