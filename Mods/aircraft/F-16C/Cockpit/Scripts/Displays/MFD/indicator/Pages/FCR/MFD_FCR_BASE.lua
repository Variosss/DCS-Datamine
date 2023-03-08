dofile(LockOn_Options.script_path.."Displays/MFD/indicator/MFD_Symbology.lua")
dofile(LockOn_Options.script_path.."Displays/MFD/indicator/Pages/FCR/MFD_FCR_Defs.lua")

-- Common
local AntennaAzimuthTicsRoot = addPlaceholder("FCR_Antenna_Azimuth_Tics_Root", {0, -212})
for i = 0, 6 do
    local LineLen
    if i == 3 then
        LineLen = 22
    else
        LineLen = 15
    end
    addStrokeLine("FCR_Antenna_Azimuth_Tic_"..i, LineLen, {-120 + i * 40, 0}, 0, AntennaAzimuthTicsRoot.name, {{"MFD_SetColor_Group_1"}})
end

local AntennaElevationTicsRoot = addPlaceholder("FCR_Antenna_Elevation_Tics_Root", {-197, 0})
for i = 0, 6 do
    local LineLen
    if i == 3 then
        LineLen = 22
    else
        LineLen = 15
    end
    addStrokeLine("Antenna_Elevation_Tic_"..i, LineLen, {0, 120 - i * 40}, -90, AntennaElevationTicsRoot.name, {{"MFD_SetColor_Group_1"}})
end