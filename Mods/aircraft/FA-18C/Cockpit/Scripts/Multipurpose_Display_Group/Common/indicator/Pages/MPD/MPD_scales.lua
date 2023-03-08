-- Set screen units and indicator scale
dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/MDG_units.lua")

-- DI - F/A-18 Multipurpose Display Group stroke indicator Display Increment
DItoScreenUnits = DItoIn()
ScreenUnitsToDI = 1 / DItoScreenUnits

-- Scale
SetScale(METERS)
SetCustomScale(GetScale() * (1 / MeterToIn) * DItoScreenUnits) -- Display Increments
