dofile("Tools.lua")
dofile("GroundUnits/WeaponSystem/Tools/weapons.lua")

dofile("GroundUnits/WeaponSystem/Tools/MissileSounds.lua")

Tor_weapons = weapons:new()

Tor_weapons:addTurret(1)
Tor_weapons:addLauncher(1, 1, _9A330)
