dofile("Tools.lua")
dofile("GroundUnits/WeaponSystem/Tools/weapons.lua")

dofile("GroundUnits/WeaponSystem/Tools/AutoGunSounds.lua")
dofile("GroundUnits/WeaponSystem/Tools/MissileSounds.lua")

Vinson_weapons = weapons:new()

Vinson_weapons:addTurret(1)
Vinson_weapons:addLauncher(1, 1, phalanx)

Vinson_weapons:addTurret(2)
Vinson_weapons:addLauncher(2, 1, phalanx)

Vinson_weapons:addTurret(3)
Vinson_weapons:addLauncher(3, 1, phalanx)

Vinson_weapons:addTurret(4)
Vinson_weapons:addLauncher(4, 1, seasparrow)

Vinson_weapons:addTurret(5)
Vinson_weapons:addLauncher(5, 1, seasparrow)