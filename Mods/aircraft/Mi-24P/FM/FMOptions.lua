AP_Yaw_On = false
AP_Pitch_On = false
AP_Roll_On = false
AP_Height_On = false
--�������.����-1
AP_K_PitchPilot	= 2.0 --1.6 | 0.83
AP_K_RollPilot	= 4.0 --0.96 --1.6
AP_K_RudderPilot = 0
AP_K_Pitch = 28 -- 20+-8
AP_K_Roll = 6 -- 16.7+-6.7
AP_K_Yaw = 12 -- 16.7+-6.7
AP_K_Wz =40 -- 20+-8
AP_K_Wx = 5 -- 16.7+-6.7
AP_K_Wy = 16 -- 16.7+-6.7

AP_K_Vx	= -0.6 -- ��� ��-8 = 0.4 [���� / ��/�] = 0.025 [��� / �/�]
AP_K_Vy	= 0.3
--AP_K_Alt = 0.2
AP_K_Alt = 6.65 / 15.0 * 0.2 --6.65+-2.65

AP_T_Wy_Filter = 0.3  -- hpf wy tau 
AP_T_Wz_Filter = 0.10  -- hpf wz tau
AP_K_Wz_HPF    = 1.5    -- hpf wz coeff

--������������ �������
AP_K_HoverVg = 0.1*2
AP_K_HoverPos = 0.01*2

--�������� �� ����� ��� ������ �������
AP_K_RouteGain = 2.0

BalanceFM_On = false
CheckInput = false -- �������� ����� ������ ������ �� �����

RotorBrakeFriction = 18000.0

WheelStaticFriction = 1.12;--0.9 ������� 08.02.2020
WheelGlideFriction = 0.9;--0.6 ������� 08.02.2020

--RotInertX = 18522.0	--* 0.5	-- ��� ������� �������
--RotInertY = 81144.0 --* 0.5
--RotInertZ = 85064.0 --* 1.4

--YawDamperK = 120000.0	-- �-�� ��������
YawDamperK = 0 --2000.0	-- �-�� ��������, ������� 08.02.2020
PitchDamperK = 0 --3000.0 -- 100000.0 ������� 08.02.2020
RollDamperK = 0 --2000.0-- 60000 ������� 08.02.2020
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

kMRwakeToTR = 0.5 -- �-� ������� �� �� �� (����� �� ������� ��� ������� ����� ������ ������� �����)
kTailRotorVortex_1 = 2.0	-- �-� ������� ��������� �� � �� 
kTailRotorVortex_2 = 0.25	-- �-� ����������� �� ��
CushionParam = 0.3   --�-� �������. ����������� � ��������� 0.15...0.3

--stickPitchCurvPow = 1.07		-- ������� �������� ������ ����� �� �������
--stickRollCurvPow = 1.3			-- ������� �������� ������ ����� �� �����
stickPitchCurvPow = 1.0		-- ������� �������� ������ ����� �� �������
stickRollCurvPow = 1.0			-- ������� �������� ������ ����� �� �����

Pilot_Place = true -- ������� ��� ��� �������� ������ ��������� (� �������� �������������� � ������������ ���������� �� ����� ���������� ���-���)
FFB_On = true -- ������ ���� true ��� �������� ������ ��������� (��� �������������)
PilotHelperOn = false -- �������� � ���������� (��� ���������)

ValezhGain						= 0.1	-- ������� - �-� �������� �������
ValezhReverse					= 60.0	-- ������� - �-� ������� �����
ValezhVel0						= 330	-- �������� ������ �������� ������� ��� 0 ��� (��/�)
ValezhRotorPitchK				= 0.1
ValezhRotorPitch0				= 11

ExtForceGenPitchK				= 1.0	-- �-� ���������� ������� �� ������� ��� 
ExtForceGenPitch0				= 8.5	-- �������� �� �� (� ����), ��� ������� �� = 0
ExtForceTailPitchK				= 0.1	-- �-� ���������� ������� �� ������� �� 
ExtForceTailBias				= 0.24	-- �������� ������� �� (���. � ���� -1...1), ��� ������� �� = 0

Circ85K							= 5.0	-- ��������� ���� �� 85% ��

Centering				= 189		-- ��������� oX (��� Mempty = 8891)


Rudder_Speed_Warning_Limit = 0.2 -- ����� ������������ �������������� "����� ���� ���� ������"

TV3_117_VMA_Mod 			= true
EngineLife				= 1.0		-- 0...1.0 

Pilot_Place				= false

VindWingK				= 1.0;
VindStabK				= 1.0;
VindFusK				= 0.0;
SlipstreamRadK				= 1.03;


ExhaustScreenK					= 0.98		-- �-� ������� ��� �� ��������� (0.95 - ��� �������)