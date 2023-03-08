AP_Yaw_On = false
AP_Pitch_On = false
AP_Roll_On = false
AP_Height_On = false
--коэффиц.ВУАП-1
AP_K_PitchPilot	= 2.0 --1.6 | 0.83
AP_K_RollPilot	= 4.0 --0.96 --1.6
AP_K_RudderPilot = 0
AP_K_Pitch = 28 -- 20+-8
AP_K_Roll = 6 -- 16.7+-6.7
AP_K_Yaw = 12 -- 16.7+-6.7
AP_K_Wz =40 -- 20+-8
AP_K_Wx = 5 -- 16.7+-6.7
AP_K_Wy = 16 -- 16.7+-6.7

AP_K_Vx	= -0.6 -- для Ми-8 = 0.4 [град / км/ч] = 0.025 [рад / м/с]
AP_K_Vy	= 0.3
--AP_K_Alt = 0.2
AP_K_Alt = 6.65 / 15.0 * 0.2 --6.65+-2.65

AP_T_Wy_Filter = 0.3  -- hpf wy tau 
AP_T_Wz_Filter = 0.10  -- hpf wz tau
AP_K_Wz_HPF    = 1.5    -- hpf wz coeff

--коэффициенты висения
AP_K_HoverVg = 0.1*2
AP_K_HoverPos = 0.01*2

--усиление по крену для режима Маршрут
AP_K_RouteGain = 2.0

BalanceFM_On = false
CheckInput = false -- вертолет будет просто висеть на ручке

RotorBrakeFriction = 18000.0

WheelStaticFriction = 1.12;--0.9 поменял 08.02.2020
WheelGlideFriction = 0.9;--0.6 поменял 08.02.2020

--RotInertX = 18522.0	--* 0.5	-- три момента инерции
--RotInertY = 81144.0 --* 0.5
--RotInertZ = 85064.0 --* 1.4

--YawDamperK = 120000.0	-- к-ты демпфера
YawDamperK = 0 --2000.0	-- к-ты демпфера, поменял 08.02.2020
PitchDamperK = 0 --3000.0 -- 100000.0 поменял 08.02.2020
RollDamperK = 0 --2000.0-- 60000 поменял 08.02.2020
--PitchDamperK = 30000.0
--RollDamperK = 10000.0

WingDamperZ			= 0.3
StabilizerDamperZ		= 0.0
FuselageDamperZ			= 0.3
FuselageDamperY			= 0.0


MassPosShiftY = 0.0 
MassPosShiftZ = 0.0 
RotorPosShiftY = 0.0 --const Vec3 ROTOR_POS = Vec3(0.107, 2.427, 0.147);  
--RotorPosShiftY = -0.90 --const Vec3 ROTOR_POS = Vec3(0.107, 2.427, 0.055); 

kMRwakeToTR = 0.5 -- к-т влияния НВ на РВ (чтобы на висении при боковом ветре всегда крутило влево)
kTailRotorVortex_1 = 2.0	-- к-т условия попадания РВ в ВК 
kTailRotorVortex_2 = 0.25	-- к-т воздействия ВК РВ
CushionParam = 0.3   --К-т подушки. Варьировать в диапазоне 0.15...0.3

--stickPitchCurvPow = 1.07		-- степень кривизны инпута ручки по тангажу
--stickRollCurvPow = 1.3			-- степень кривизны инпута ручки по крену
stickPitchCurvPow = 1.0		-- степень кривизны инпута ручки по тангажу
stickRollCurvPow = 1.0			-- степень кривизны инпута ручки по крену

Pilot_Place = true -- признак что это основная кабина тренажера (с железным триммированием и механическим сумматором на посте управления ШАГ-ГАЗ)
FFB_On = true -- должно быть true для основной кабины тренажера (для триммирования)
PilotHelperOn = false -- помощник в управлении (для подыгрыша)

ValezhGain						= 0.1	-- валежка - к-т действия эффекта
ValezhReverse					= 60.0	-- валежка - к-т реверса ручки
ValezhVel0						= 330	-- скорость начала действия валежки при 0 РОШ (км/ч)
ValezhRotorPitchK				= 0.1
ValezhRotorPitch0				= 11

ExtForceGenPitchK				= 1.0	-- к-т шарнирного момента на приводе РОШ 
ExtForceGenPitch0				= 8.5	-- значение ОШ НВ (в град), при котором ШМ = 0
ExtForceTailPitchK				= 0.1	-- к-т шарнирного момента на приводе РВ 
ExtForceTailBias				= 0.24	-- значение педалей РВ (отн. в диап -1...1), при котором ШМ = 0

Circ85K							= 5.0	-- ухудшатор тяги на 85% НВ

Centering				= 189		-- Центровка oX (при Mempty = 8891)


Rudder_Speed_Warning_Limit = 0.2 -- порог срабатывания предупреждения "ВЕЛИК ТЕМП ДАЧИ ПЕДАЛИ"

TV3_117_VMA_Mod 			= true
EngineLife				= 1.0		-- 0...1.0 

Pilot_Place				= false

VindWingK				= 1.0;
VindStabK				= 1.0;
VindFusK				= 0.0;
SlipstreamRadK				= 1.03;


ExhaustScreenK					= 0.98		-- к-т влияния ЭВУ на двигатель (0.95 - нет влияния)
