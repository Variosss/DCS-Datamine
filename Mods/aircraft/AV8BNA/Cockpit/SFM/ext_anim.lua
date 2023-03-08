local ext_anim = GetSelf()
local sensor_data = get_base_data()
local update_rate = 0.01
make_default_activity(update_rate)

local engPercentRPM
local propMaxNomRPM = 2200
local hydraulicPressMinPct = 50
local hydraulicPressMinEngPct = 20
local hydraulicPressPctRate
local hydraulicPressPct = 50
local manFlaps = 12
local ldgFlaps = 35

local handFeetSpeed = 2.0

extAnims = {
    -- Separated Animations
    NWS          = {arg =  2, command = 0, lims = {-1,1}, cycle = false, animTime = handFeetSpeed, pwrType = "mechanical"},
    gearNose     = {arg =  0, command = 0, lims = { 0,1}, cycle = false, animTime = 0.33, pwrType = "hydraulic"},
    gearLeft     = {arg =  5, command = 0, lims = { 0,1}, cycle = false, animTime = 0.25, pwrType = "hydraulic"},
    gearRight    = {arg =  3, command = 0, lims = { 0,1}, cycle = false, animTime = 0.25, pwrType = "hydraulic"},
    flapLeft     = {arg = 10, command = 0, lims = { 0,1}, cycle = false, animTime = 0.5, pwrType = "electrical"},
    flapRight    = {arg =  9, command = 0, lims = { 0,1}, cycle = false, animTime = 0.5, pwrType = "electrical"},
    aileronLeft  = {arg = 12, command = 0, lims = {-1,1}, cycle = false, animTime = handFeetSpeed, pwrType = "mechanical"},
    aileronRight = {arg = 11, command = 0, lims = {-1,1}, cycle = false, animTime = handFeetSpeed, pwrType = "mechanical"},
    elevLeft     = {arg = 16, command = 0, lims = {-1,1}, cycle = false, animTime = handFeetSpeed, pwrType = "mechanical"},
    elevRight    = {arg = 15, command = 0, lims = {-1,1}, cycle = false, animTime = handFeetSpeed, pwrType = "mechanical"},
    rudder       = {arg = 17, command = 0, lims = {-1,1}, cycle = false, animTime = handFeetSpeed, pwrType = "mechanical"},
    canopy       = {arg = 38, command = 0, lims = { 0, 0.89}, animTime = 1.5, pwrType = "mechanical"},

    -- Sub-animations
    propeller    = {mode = 0, arg = 40, command = 0, lims = {-1,1}, animTime = 0},
    propellerSolid    = {mode = 1, arg = 40, command = 0, lims = {-1.0, -0.501}, cycle = true, animTime = 1/propMaxNomRPM},
    propellerBlurLow  = {mode = 2, arg = 40, command = 0, lims = {-0.5, -0.001}, cycle = true, animTime = 1/propMaxNomRPM},
    propellerBlurMed  = {mode = 3, arg = 40, command = 0, lims = { 0.0,  0.499}, cycle = true, animTime = 1/propMaxNomRPM},
    propellerBlurHigh = {mode = 4, arg = 40, command = 0, lims = { 0.5,  1.0  }, cycle = true, animTime = 1/propMaxNomRPM}, 
    -- Compound Animations
    gear         = {arg = nil, command = 0},
    flaps        = {arg = nil, command = 0},
    ailerons     = {arg = nil, command = 0},
    elevators    = {arg = nil, command = 0},
}

function post_initialize()
    main_panel = GetDevice(0)
end

function update()

    engPercentRPM = sensor_data:getEngineLeftRPM()

    hydraulicPressPctRate = 2 * (engPercentRPM - hydraulicPressMinEngPct)
    hydraulicPressPct = limit((hydraulicPressPct + (hydraulicPressPctRate * update_rate)), 0, 100)

    if engPercentRPM > 80 then propellerMode = 4 
    elseif engPercentRPM > 20 then propellerMode = 3
    elseif engPercentRPM > 15 then propellerMode = 2
    elseif engPercentRPM ~= 0 then propellerMode = 1
    else propellerMode = 0
    end

    extAnims.propeller.animTime = 60 * 100 / (engPercentRPM * propMaxNomRPM)
   
    if sensor_data:getWOW_LeftMainLandingGear() == 1 and sensor_data:getWOW_RightMainLandingGear() == 1 and sensor_data:getWOW_NoseLandingGear() == 1 then
        
        -- Make sure gear is down
        extAnims.gear.command = 1
        
        -- NOSEWHEEL STEERING
        if sensor_data:getIndicatedAirSpeed() * 1.943844 < 50 then
            extAnims.NWS.command = (sensor_data:getRudderPosition() * 1)/100
        else
            extAnims.NWS.command = 0
        end

        -- Do canopy if low acceleration and speed
        if engPercentRPM < 2 then
            extAnims.canopy.command = 1
        else
            extAnims.canopy.command = 0
        end

        extAnims.flaps.command = manFlaps/ldgFlaps

    else
        if sensor_data:getIndicatedAirSpeed() < 56.59 and sensor_data:getThrottleLeftPosition() < 0.7 then
            extAnims.flaps.command = 1
			extAnims.gear.command = 1
        elseif sensor_data:getIndicatedAirSpeed() < 61.73 and sensor_data:getThrottleLeftPosition() < 0.7 then
            extAnims.flaps.command = manFlaps/ldgFlaps
            extAnims.gear.command = 1
        elseif sensor_data:getRadarAltitude() > 20  and sensor_data:getThrottleLeftPosition() > 0.7 then
            extAnims.gear.command = 0
            extAnims.flaps.command = 0
        end  	
    end
	-- extAnims.gear.command = sensor_data:getLandingGearHandlePos()
	-- extAnims.canopy.command = sensor_data:getCanopyState()
	-- extAnims.flaps.command = sensor_data:getFlapsPos()

    -- Control Surfaces
    extAnims.ailerons.command  = ((sensor_data:getStickPitchPosition() * 1) / 100) * (1 - 1.25 * sensor_data:getMachNumber())
    extAnims.elevators.command = ((sensor_data:getStickRollPosition() * 1) / 100) * (1 - 1.25 * sensor_data:getMachNumber())
    extAnims.rudder.command    = ((sensor_data:getRudderPosition() * -1) / 100) * (1 - 1.25 * sensor_data:getMachNumber())


    -- Separate compound animation handles
    extAnims.flapLeft.command           =  extAnims.flaps.command
    extAnims.flapRight.command          =  extAnims.flaps.command
    extAnims.aileronRight.command       =  extAnims.ailerons.command
    extAnims.aileronLeft.command        = -extAnims.ailerons.command
    extAnims.elevRight.command          =  extAnims.elevators.command
    extAnims.elevLeft.command           =  extAnims.elevators.command
    extAnims.gearNose.command           =  extAnims.gear.command
    extAnims.gearLeft.command           =  extAnims.gear.command
    extAnims.gearRight.command          =  extAnims.gear.command
    extAnims.propellerSolid.animTime    =  extAnims.propeller.animTime
    extAnims.propellerBlurLow.animTime  =  extAnims.propeller.animTime
    extAnims.propellerBlurMed.animTime  =  extAnims.propeller.animTime
    extAnims.propellerBlurHigh.animTime =  extAnims.propeller.animTime

    if extAnims.canopy.command ~= 0 then
        extAnims.canopy.command = extAnims.canopy.lims[2]
    end

    -- Animate everything with an arg in extAnims()
    for name, v in pairs(extAnims) do
        if v.arg ~= nil then 
            if v.mode == nil then
				-- Don't worry about rate movement for SFM this is just for testing anyways
                -- if (v.pwrType == "hydraulic" and hydraulicPressPct > hydraulicPressMinPct) or
                    -- (v.pwrType == "electrical" and engPercentRPM > 50) or
                    -- (v.pwrType == "mechanical") then
                    -- animate(v.arg, v.command, v.lims[1], v.lims[2], (v.animTime * 100 / hydraulicPressPct), update_rate, false)
                -- else
                    animate(v.arg, v.command, v.lims[1], v.lims[2], v.animTime, update_rate, false)
                -- end
            elseif v.mode == propellerMode and v.mode ~= 0 then
                animate(v.arg, v.lims[2], v.lims[1], v.lims[2], v.animTime, update_rate, true)
            end
        end
    end
	
	-- Don't worry about rate movement for SFM this is just for testing anyways
	-- for name, v in pairs(extAnims) do
		-- if v.arg ~= nil then 
			-- set_aircraft_draw_argument_value(v.arg, v.command)
		-- end
	-- end


end

function animate(ArgNum, command, ArgMin, ArgMax, AnimateTime, UpdateRate, isCycled)
    if math.abs(command - get_aircraft_draw_argument_value(ArgNum)) > 0.0001 then
        if (command < get_aircraft_draw_argument_value(ArgNum)) then
            CurrentPos = get_aircraft_draw_argument_value(ArgNum) - AnimateTime * UpdateRate
	        if (CurrentPos < command) then 
				CurrentPos = command
			end    	
        elseif (command > get_aircraft_draw_argument_value(ArgNum)) then
            CurrentPos = get_aircraft_draw_argument_value(ArgNum) + AnimateTime * UpdateRate
			if (CurrentPos > command) then
				CurrentPos = command
			end    	
        end		
		
		CurrentPos = limit(CurrentPos, ArgMin, ArgMax)
		set_aircraft_draw_argument_value(ArgNum, CurrentPos)
    else
        if isCycled then
            set_aircraft_draw_argument_value(ArgNum, ArgMin)
        else
            set_aircraft_draw_argument_value(ArgNum, command)
        end
    end
end

function limit(command, minVal, maxVal)
    if command > maxVal then 
        return maxVal
    elseif command < minVal then 
        return minVal
    else
        return command
    end
end

need_to_be_closed = false
