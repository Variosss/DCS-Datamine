-- ~~~~~~~~ Inställningar för SPAK ~~~~~~~~~~
-- Högre faktor = stabilare men trögare
local TippDampningsFaktorLinjar = 10 -- 30
local RollDampningsFaktorLinjar = 2.5 -- 25
local GirDampningsFaktorLinjar = 35--2.5--35 -- 35
local SidvindsKorrigeringsFaktorExponent = 0.0000001
local SidvindsKorrigeringsFaktorLinjar = 0.0001
-- Dämpningen kopplas ur när spaken rörs en viss vinkel (0 = av, 1 = på)
local DampningsUrkopplingsLage = 0



local pitchdamplineparam = get_param_handle("SAS_PITCH_DAMP_FACTOR_LINEAR")
local rolldamplineparam = get_param_handle("SAS_ROLL_DAMP_FACTOR_LINEAR")
local yawdamplineparam = get_param_handle("SAS_YAW_DAMP_FACTOR_LINEAR")
local betacorrectinlineparam = get_param_handle("SAS_BETA_CORRECTION_FACTOR_LINEAR")
local betacorrectinexpparam = get_param_handle("SAS_BETA_CORRECTION_FACTOR_EXPONENT")
local sasdisengageatdeflection = get_param_handle("SAS_STICK_DISENGAGE")

pitchdamplineparam:set(TippDampningsFaktorLinjar)
rolldamplineparam:set(RollDampningsFaktorLinjar)
yawdamplineparam:set(GirDampningsFaktorLinjar)
betacorrectinlineparam:set(SidvindsKorrigeringsFaktorExponent)
betacorrectinexpparam:set(SidvindsKorrigeringsFaktorLinjar)
sasdisengageatdeflection:set(DampningsUrkopplingsLage)
