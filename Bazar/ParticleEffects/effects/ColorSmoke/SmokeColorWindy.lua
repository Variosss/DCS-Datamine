dofile('./Bazar/ParticleEffects/effects/ColorSmoke/SmokeColor.lua')

local smoke = Emitters[1]

smoke.Number = {{0, 10}}
smoke.Velocity = { {0., {-2, 1.0, -2}, {2, 4.0, 2}}}
smoke.SizeOverLife = {{0, 1} , {0.6, 8.0}}