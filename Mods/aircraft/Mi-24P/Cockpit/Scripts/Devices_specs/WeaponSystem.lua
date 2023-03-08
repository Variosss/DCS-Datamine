UnlimitedWeapon = true

LeftGunner = 0.1
RightGunner = 0.2

dofile(LockOn_Options.script_path.."AI/AI_Gunners.lua")

--KORD_SightVal = 0.35  -- прицельная дальность по планке=700, при тестах 600м
KORD_SightVal = 0.5

Door_Head_Pos = {}
Door_Head_Pos[KORD_12_7] =
{
--	pivot = {-1.3064, -0.48,  -1.33},
	d_v   = {-0.30, -0.01, 0.0217}
--	d_v   = {0.0, 0.0, 0.0}
}

MGSightPos = 0.046

EmptyRack_MG_restrAngle = 35.5
B6_MG_restrAngle 		= 34
UB32_MG_restrAngle 		= 34
S24_MG_restrAngle 		= 36
ATAKA_MG_restrAngle 	= 24
ATAKA_OutBrd_MG_restrAngle 	= 34
R60_MG_restrAngle 		= 24
R60x2_MG_restrAngle 	= 22
B13_MG_restrAngle 		= 6
KMGU_MG_restrAngle 		= 3.5
GUV_MG_restrAngle 		= 24
FUELTANK_MG_restrAngle 	= 25


MI24_LEFT_WING_TIP 	= 0
MI24_LEFT_WING 		= 1
MI24_RIGHT_WING_TIP = 2	
MI24_RIGHT_WING 	= 3

Damage = {	
	{Failure = MI24_LEFT_WING_TIP,	Element = 23, Integrity_Treshold = 0.2},
	{Failure = MI24_LEFT_WING,		Element = 35, Integrity_Treshold = 0.2},
	{Failure = MI24_RIGHT_WING_TIP,	Element = 24, Integrity_Treshold = 0.2},
	{Failure = MI24_RIGHT_WING,		Element = 36, Integrity_Treshold = 0.2},
}

need_to_be_closed = true -- lua_state  will be closed in post_initialize()
