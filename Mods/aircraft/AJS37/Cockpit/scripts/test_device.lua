-- DEBUG DEBUG DEBUG DEBUG DEBUG DEBUG DEBUG
local grona_tentakler = get_param_handle("GRONA_TENTAKLER")
grona_tentakler:set(0) -- Ändra till 0 för att stänga av tentakler

-- ^^^^^^^^^^^^^^ DEBUG ^^^^^^^^^^^^^^^^^^^^








local dev 	    = GetSelf()
local my_param  = get_param_handle("TEST_PARAM") -- obtain shared parameter (created if not exist ), i.e. databus
local my_param2  = get_param_handle("RHM_PARAM") -- obtain shared parameter (created if not exist ), i.e. databus
local my_param3  = get_param_handle("HDG_PARAM") -- obtain shared parameter (created if not exist ), i.e. databus
local display_param = get_param_handle("SYS_DISPLAY") -- Just create
local displaytext_param = get_param_handle("SYS_TEXT") -- Just create
local machdec2_param = get_param_handle("MACHDEC2_PARAM")
local machdec1_param = get_param_handle("MACHDEC1_PARAM")
local machint_param = get_param_handle("MACHINT_PARAM")
local real_pitch_param = get_param_handle("REAL_PITCH_PARAM")
local real_bank_param = get_param_handle("REAL_BANK_PARAM")
local real_HDG_param = get_param_handle("REAL_HDG_PARAM")
local magnetic_HDG_param = get_param_handle("EDCOMPASSHEADING")


-- THESE ARE FOR THE HUD
local alpha_param = get_param_handle("HUD_ALPHA_PARAM")
local beta_param = get_param_handle("HUD_BETA_PARAM")
local vspeed_param = get_param_handle("HUD_VSPEED_PARAM")
local pitch_param = get_param_handle("HUD_PITCH_PARAM")
local roll_param = get_param_handle("HUD_ROLL_PARAM")
local l0horiz_param = get_param_handle("HUD_LAD0HORIZ_PARAM")
local pitch_p10_x_param = get_param_handle("HUD_LADp10X_PARAM")
local pitch_p10_y_param = get_param_handle("HUD_LADp10Y_PARAM")
local pitch_p5_x_param = get_param_handle("HUD_LADp5X_PARAM")
local pitch_p5_y_param = get_param_handle("HUD_LADp5Y_PARAM")

local CK37pitch = get_param_handle("FCPITCHIND")
local CK37roll = get_param_handle("FCROLLIND")

my_param:set(0.1) -- set to 0.1
my_param2:set(0.1) -- set to 0.1
my_param3:set(0.1) -- set to 0.1
machdec2_param:set(1)
machdec1_param:set(1)
machint_param:set(1)

alpha_param:set(0.1)
beta_param:set(0.1)
vspeed_param:set(0.1)
pitch_param:set(0.1)
roll_param:set(0.1)
l0horiz_param:set(0.1)
pitch_p10_x_param:set(0.1)
pitch_p10_y_param:set(0.1)
pitch_p5_x_param:set(0.1)
pitch_p5_y_param:set(0.1)


real_pitch_param:set(0.0)
real_bank_param:set(0.0)
real_HDG_param:set(0.0)
magnetic_HDG_param:set(0.0)

local update_time_step = 0.01


make_default_activity(update_time_step)
--update will be called 10 times per second


-- Key Commands --
-- local LTKRAN = 3030 -- Fuelpump
-- local HTKRAN = 3031 -- Throttle off
-- local STARTERSWITCH = 3032 -- Starter switch
-- dev:listen_command(LTKRAN)
-- dev:listen_command(HTKRAN)
-- dev:listen_command(STARTERSWITCH)
-- local enginemgmt = get_param_handle("ENGINE_MGMT")
-- enginemgmt:set(0)


local sensor_data = get_base_data()

-- function SetCommand(command,value)		
	-- if command==LTKRAN then
		-- enginemgmt:set(1)
		-- print("LTKRAN")
	-- end
	-- if command==HTKRAN then
		-- enginemgmt:set(2)
		-- print("HTKRAN")
	-- end
	-- if command==STARTERSWITCH then
		-- enginemgmt:set(3)
		-- print("STARTER")
	-- end
-- end
	

local DC_BUS_V  = get_param_handle("DC_BUS_V")
DC_BUS_V:set(0)

function post_initialize()
	electric_system = GetDevice(3) --devices["ELECTRIC_SYSTEM"]
	print("post_initialize called")
end
	-- NOTE: GOING TO IGNORE THE ALPHA AND BETA MOVEMENT OF THE LADDER FOR NOW (COULDNT MAKE IT WORK)
	-- TODO ^^^^^^
	function getLadderX(offset)
		local roll1 = math.abs((CK37roll:get()/math.pi)) * 2 -- This goes 0 to 1 where 1 is 90 degrees?
		local blend = roll1
		if (roll1 > 1) then blend = 1 - (roll1 - 1) end
		local horizdir = (0 - CK37pitch:get()) + offset
		local horizslide = sensor_data.getAngleOfSlide()
		local horizattack = 0 - sensor_data.getAngleOfAttack()
			local verticdir = (0 - CK37pitch:get()) + offset-- 0.033
	local verticattack = 0 - sensor_data.getAngleOfAttack()
	local verticslide = sensor_data.getAngleOfSlide()
	local horizattackblend = blend
	local verticslideblend = blend
		if (CK37roll:get() > 0) then 
			-- Right roll
			horizdir = 0 - horizdir 
		end
		return (horizdir * (blend)) --+ (horizslide * (1-blend))-- + ((horizattack * (blend)) / 2)-- + (horizattack * (blend))--  - (horizattack + (1 - blend) * (0 - horizattack))--x + (horizslide + blend * (horizdir - horizslide))
	end
	function getLadderY(offset)
		local roll1 = math.abs((CK37roll:get()/math.pi)) * 2 -- This goes 0 to 1 where 1 is 90 degrees?
		local blend = roll1
		if (roll1 > 1) then blend = 1 - (roll1 - 1) end
		local horizdir = (0 - CK37pitch:get()) + offset
		local horizslide = sensor_data.getAngleOfSlide()
		local horizattack = 0 - sensor_data.getAngleOfAttack()
			local verticdir = (0 - CK37pitch:get()) + offset-- 0.033
	local verticattack = 0 - sensor_data.getAngleOfAttack()
	local verticslide = sensor_data.getAngleOfSlide()
	local horizattackblend = blend
	local verticslideblend = blend
		if ((CK37roll:get()/math.pi) * 2 > 1 or (CK37roll:get()/math.pi) * 2 < -1) then 
			-- Right roll > 90 degrees and left roll < -90
			verticdir = 0 - verticdir 
		end
		return (verticdir * (1-blend))-- + (verticattack * (blend))-- + ((horizslide * (1-blend)) / 2)--(verticslide * (blend)) -- (verticattack + (blend) * (0 - verticattack)) - (verticslide + (1 - blend) * (0 - verticslide))--+ (verticslide + blend * (verticattack - verticslide))--(verticdir + blend * (verticattack - verticdir))-- + (verticslide + verticslideblend * (0 - verticslide))-- + (horizattack * (blend))--  - (horizattack + (1 - blend) * (0 - horizattack))--x + (horizslide + blend * (horizdir - horizslide))
	end
function update()
	local v = my_param:get()
	--print(v)
	local velocitydisplay = math.floor(sensor_data.getMachNumber() * 100)/100

	if (sensor_data.getMachNumber() < 0.5) then 
		velocitydisplay =  math.floor(sensor_data.getIndicatedAirSpeed() * 3.6)
	end
	my_param:set(velocitydisplay)--velocitydisplay)
	
		local v = my_param2:get()
	--print(v)
	my_param2:set(sensor_data.getRadarAltitude())
	
			local v = my_param3:get()
	--print(v)
	my_param3:set(sensor_data.getMagneticHeading()*(180/math.pi)+6)
	

	alpha_param:set((0 - ((sensor_data.getAngleOfAttack() * 1))) + 0.0)
	beta_param:set(sensor_data.getAngleOfSlide() / 1)
	vspeed_param:set(math.floor(sensor_data.getVerticalVelocity()))
	local upsidedown = 1
	

	-- Blend beta and alpha
	
	

	
	local x
	local y
	

		--horizslide = 0 - sensor_data.getAngleOfSlide()
		--x = (horizattack + horizattackblend * (0 - horizattack))

	
	x = getLadderX(0)
	l0horiz_param:set(x)
	--print(blend)

	
	y = getLadderY(0)
	pitch_param:set(y)
	--pitch_param:set(((0.033) - (sensor_data.getPitch() * 1)) - (sensor_data.getAngleOfAttack() * 1))
	roll_param:set(sensor_data.getRoll())--sensor_data.getRoll() * 1.2)
	--print(sensor_data.getRoll())
	-- Roll seems to be pi for 180 degrees (radian)
	-- Rotation of the texture seems to be pi for 360 degrees (?)
	pitch_p10_x_param:set(getLadderX(0.174532925))
	pitch_p10_y_param:set(getLadderY(0.174532925))--(0.033 + (0.174532925)) - (sensor_data.getPitch() * 1))
	pitch_p5_x_param:set(getLadderX(0.174532925 * 0.5))
	pitch_p5_y_param:set(getLadderY(0.174532925 * 0.5))
	--my_param2:set(blend)
	
	--TODO: LEARN QUATERNIONS YOU LAZY ASS!
	real_pitch_param:set(sensor_data.getPitch())
	real_bank_param:set(sensor_data.getRoll())
	real_HDG_param:set(sensor_data.getHeading())
	magnetic_HDG_param:set(sensor_data.getMagneticHeading())
	
	--MACH DIGITS
	local mstr = string.format("%f", sensor_data.getMachNumber())
	machdec2_param:set(math.floor(tonumber(string.sub(mstr,4))/100)/1000)
	machdec1_param:set(math.floor(tonumber(string.sub(mstr,3))/1000)/1000)
	machint_param:set(math.floor(tonumber(string.sub(mstr,1))*100)/1000)

	if electric_system ~= nil then
	   local DC_V     =  electric_system:get_DC_Bus_1_voltage()
	   local prev_val =  DC_BUS_V:get()
	   -- add some dynamic: 
	   DC_V = prev_val + (DC_V - prev_val) * update_time_step   
	   DC_BUS_V:set(DC_V)
	end	
	-- if (land ~= nil) then
		-- print("OMFG!")
	-- end
	
	-- if (Unit.getLife(Unit.getByName("Mig")) < 1.0) then	
		-- print("Omg!")
	-- end
end




