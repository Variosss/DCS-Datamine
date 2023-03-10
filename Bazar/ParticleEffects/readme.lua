-- ? lockon ??????????? ??????? ???????? ? ??????????? ????????????? ???????? ????????, ? ????? ???????????? ???? ???????? (?? ???? ????? ???????? ?????? ? ?????????? ??????????? ?? ??????).
-- ctrl+shift+s ? ???????? ??????? ?? ????????? ??????, ??? ? ????????? ? ???????? ???????, ???? ?????? ????????? ?? ????
-- ?????????? ??????? (? ??????? ??????????):
-- ps.setEffect('readme') ? ??????? ??????? ?????? ./Bazar/Particleeffects/effects/readme.lua
-- ps.reset() ? ???????? ??? ????????, ? ????????? ???? ??????? ????????
-- ps.setOffset(x,y,z) ? ?????????? ?????? ??? ???????? ??????? ? viObject.

Duration = {{0, 900}, {1, 1500}} --????????????????? ??????? 1.5 ??? - 25 ?????.
--????????????????? ?????? ????? ????? ???? ?????????? ? ????, ??? ???????? ??? ???????? ???????.

Emitters = 
{--?????? ?????????, ? ?????? ?????? ???????? 2? ????? ? ????
        {
        Name = "Fire1", --????????????? ????????, ????? ? ?????
        Texture = "DCSFireTex.png", --????????, ??? ???????? ?????? ???????? ? .\Bazar\ParticleEffects\textures
        Technique = "AnimatedFire", --??????? ????????? (?????? ?????????????? ? ??????? ???????), 
        --?????? ??????????? ????????? ??????:
        --Translucent --??????? ???????, ???????????? ????? ??????? ? ????????????
        --AnimatedFire --?????????? ??? ????, ?????????? ????????????? ?????????? ?????? ????
        --TranslucentAnim --?????????? ????????????? ?????? ???? + ????????? ?? normalmap, ? ????????
        --TranslucentAnimLowLight--??? ??????? ?????, ??????? ? TranslucentAnim, ?????? ? ???????????? ??????????? ?????
        
        InitPositionBox = {Min = {-1.2,0.8,0.3}, Max = {-1.2,1,1.3}},-- ????? ???????? ??????, ????????? ??????? ????? ?????
        
        --[[InitPositionSphere = {MinR = 1, Max = 5, EnableY = false}, ????? ????? ? ???????? ????? ???????? ????? ??????? ?????, 
        ????? ??????????? ??????????? ? ???????????? ???????? + ? ???????? ?????????? ????? ??????????? ???, ???????? ??? EnableY = false, ??????? ????? ????????? ? ??????????, ??????? ? ????????? XZ]]
        

        Flags = {"SoftParticles"}, --?????????????? ?????????, ????????? ?????:
        --"SoftParticles" - ?????????? ???????????? ?? ???????? ????????, ???????? ?????? ? edge
        --"Sort" - ????????? ?????????? ?? ???????? ?? ?????? (??-????????? ?????????)
        --"Disable" - ?????????? ????????, ?? ?? ?????, ??? Number = {{0,0}}
        --"LocalSpace" - ???????? ??????? ???????? ? ????????? ??????? ?????????, ??? ???????? ???? ? ?????? ???????    
        
        Number = {{0, 3.5}, {1.5, 1}}, --??????? ???????? ?????? ?? ???????,
        --? ????????? ?????? ????? ????????? 3.5 ??????? ? ???????, ?? ?????????? 1.5 ?????? - ??? 1 ??????? ? ???????,
        --????? ??????? ??????????? ??????????????? ???????
        Life = {{0.0, 1.8}}, -- ????? ????? ??????? (? ???????? ????? - ????????? ????????), ? ?????? ?????? ????????? - 1.8 ???????
        
        ShaderParams = {{0, {0.8,0,0,0}, {0.8,0,0,0}}}, --?????????, ??????? ????? ???????? ? ??????, ?? ????????????? ??????? ?? ??????? ???????
        --????????? ????????:
        --AnimatedFire: x - ???????????? ???????? ?????? ???????, ????????? ????????? ?? ???????????
        --TranslucentAnim: xy - ???????? ???????? ??????, ????, z - ????? ?? ?????? ????????? ???????? ??????
        --Translucent: xy ????? ??????? ? ?????? ?? ??????????? ? ?????????

        Velocity = { {0.,{0, 2, 0}, {0., 2.5, 0}}}, --???????? ???????? ??????? ????????? ????????
        VelocityOverLife = { {0,0} , {0.16, 0.15}, {0.33,1}, {0.4,1}, {1.0,1.7}}, -- ????????? ????????? ??????? ? ???????? ?????, ? ?????? ?????? ??????? ???????????
        
        Size = {{0.0, 2.5}, {1.0, 2.8}}, --????????? ?????? ??????? (?? 2.5 ?? 2.8 ??????)
        SizeOverLife = {{0.6, 1} , {1, 0.1}}, --????????? ??????? ? ??????? ?????
        
        ParentVelocity = {{0, 0.5}}, --????? ????????, ??????? ??????? ????????? ? ????????????? ??????? 
        -- 0 - ????????? ???????? ??????? ?? ??????? ?? ???????? ???????? ????????
        -- 1 - ???????? ? ????????? ????????? ???????
        Windage = {{0, 0.3}}, --??????? ????? ?? ???????? ??????? 0 - ?? ??????
        --InitVelocity = ParentVelocity*emitter_speed + Velocity
        --Velocity =     VelocityOverLife(age)*InitVelocity + Windage*wind_speed
        
        --??????? ????????? ????? ?? ??????? ????? ???????
        RedOverLife =   {{0, 1.0}, {1, 1.0}},
        GreenOverLife = {{0, 0.65}, {1, 0.7}},
        BlueOverLife = {{0, 0.4}, {1, 0.4}},
        AlfaOverLife = {{0.0, 0.0}, {0.4, 1.4}, {1, 0}},
    },
    --?????? ????????
    -- {
        -- Name = "Fire2",
        -- ...
    -- },
    -- {
        -- Name = "SmokeL",
        -- ...
    -- },
}

--?????? ?????????? ?????
local lb = 1.2 
Lights =
{
    {
        offset = {0,3,0}, --????????? ???????????? ??????? ??????
        color = {{0, {1*lb, 0.6*lb, 0.2*lb}}, {0.3, {0.8*lb, 0.5*lb, 0.1*lb}}, {0.4, {1*lb, 0.6*lb, 0.2*lb}}}, --??????????? ????????? ????? ? ???????? ???????
        distance = {{0, 6}, {1, 7}, {2, 6}}, --??????????? ????????? ??????? ?????????
    },
}

--????????? ?????
--???? ????????? ???????????? ????? ????????? ????? ????????? ?? ??????????
--??????? ??????: ?????????? ??????? ????????? ??????, ?????????? ??????????, ?????????? ???????????? ?????????
--? ????????, ????? ????????? ????????? ???????, ?? ??????? ??????, ?? ????????? ?? ????? - ????, ????????? ??????
--?????? ?????????? ???? ???
Lods = 
{
    [1] = 
    {
        Distance = 800,
        Emitters = 
        {
            ["Fire1"] = 
            {            
                Number = {{0, 2}},
                Flags = {},
            },
            ["Fire2"] = 
            {        
                Flags = {'Disable'},
            },
            ["SmokeL"] = 
            {
                Number = {{0, 1.7}},
                Flags = {},
            },
        }
    },
}
