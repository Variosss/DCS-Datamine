
dofile(LockOn_Options.script_path.."command_defs.lua")

function HOTAS_animation(arg_,val)
	return {{direct_set = true,arg = arg_,arg_increment =  val}}
end

function HOTAS_animation_release(args)
	local tab_ = {}
	for i = 1,#args do
		tab_[i] = {direct_set = true,arg = args[i],arg_increment = 0}
	end
	return tab_
end

KeyCommands = {{command = Keys.HOTAS_CoolieUp   ,animation_data = HOTAS_animation(756, 1.0)},
			   {command = Keys.HOTAS_CoolieDown ,animation_data = HOTAS_animation(756,-1.0)},
			   {command = Keys.HOTAS_CoolieLeft ,animation_data = HOTAS_animation(755, 1.0)},
			   {command = Keys.HOTAS_CoolieRight,animation_data = HOTAS_animation(755,-1.0)},
			   {command = Keys.HOTAS_CoolieOff  ,animation_data = HOTAS_animation_release({755, 756})},

			   {command = Keys.HOTAS_TargetManagementSwitchUp	,animation_data = HOTAS_animation(748, 1.0)},
			   {command = Keys.HOTAS_TargetManagementSwitchDown	,animation_data = HOTAS_animation(748,-1.0)},
			   {command = Keys.HOTAS_TargetManagementSwitchLeft	,animation_data = HOTAS_animation(747,-1.0)},
			   {command = Keys.HOTAS_TargetManagementSwitchRight,animation_data = HOTAS_animation(747, 1.0)},
			   {command = Keys.HOTAS_TargetManagementSwitchOff	,animation_data = HOTAS_animation_release({747,748})},

			   {command = Keys.HOTAS_DataManagementSwitchUp		,animation_data = HOTAS_animation(750, 1.0)},
			   {command = Keys.HOTAS_DataManagementSwitchDown	,animation_data = HOTAS_animation(750,-1.0)},
			   {command = Keys.HOTAS_DataManagementSwitchLeft	,animation_data = HOTAS_animation(749,-1.0)},
			   {command = Keys.HOTAS_DataManagementSwitchRight	,animation_data = HOTAS_animation(749, 1.0)},
			   {command = Keys.HOTAS_DataManagementSwitchOff	,animation_data = HOTAS_animation_release({749,750})},

				{command = Keys.Plane_HOTAS_CMS_Up,              animation_data = HOTAS_animation(744, 1.0)},
				{command = Keys.Plane_HOTAS_CMS_Down,            animation_data = HOTAS_animation(744,-1.0)},
				{command = Keys.Plane_HOTAS_CMS_Left,            animation_data = HOTAS_animation(743,-1.0)},
				{command = Keys.Plane_HOTAS_CMS_Right,           animation_data = HOTAS_animation(743, 1.0)},
				{command = Keys.Plane_HOTAS_CMS_Off,             animation_data = HOTAS_animation_release({743,744})},
				{command = Keys.Plane_HOTAS_CMS_Zaxis,           animation_data = HOTAS_animation(745, 1.0)},
				{command = Keys.Plane_HOTAS_CMS_Zaxis_Off,       animation_data = HOTAS_animation(745, 0.0)},

				{command = Keys.Plane_HOTAS_MasterModeControlButton,     animation_data = HOTAS_animation(746, 1.0)},
				{command = Keys.Plane_HOTAS_MasterModeControlButtonUP,   animation_data = HOTAS_animation(746, 0.0)},
				{command = Keys.Plane_HOTAS_NoseWheelSteeringButton,     animation_data = HOTAS_animation(742, 1.0)},
				{command = Keys.Plane_HOTAS_NoseWheelSteeringButtonOff,  animation_data = HOTAS_animation(742, 0.0)},

				{command = Keys.Plane_HOTAS_BoatSwitchForward, animation_data = HOTAS_animation(757, 1)},
				{command = Keys.Plane_HOTAS_BoatSwitchAft	 , animation_data = HOTAS_animation(757,-1)},
				{command = Keys.Plane_HOTAS_BoatSwitchCenter , animation_data = HOTAS_animation(757, 0)},
				
				{command = Keys.Plane_HOTAS_BoatSwitchOff				, animation_data = HOTAS_animation(757, 1)},
				{command = Keys.Plane_HOTAS_BoatSwitchForwardMomentary	, animation_data = HOTAS_animation(757,-1)},
				{command = Keys.Plane_HOTAS_BoatSwitchAftMomentary		, animation_data = HOTAS_animation(757, 0)},
				
				{command = Keys.Plane_HOTAS_ChinaHatForward	, animation_data = HOTAS_animation(758,  1)},
				{command = Keys.Plane_HOTAS_ChinaHatAft		, animation_data = HOTAS_animation(758, -1)},
				{command = Keys.Plane_HOTAS_ChinaHatOff		, animation_data = HOTAS_animation(758,  0)},

				
				{command = Keys.Plane_HOTAS_PinkySwitchForward	,animation_data = HOTAS_animation(753, 1) },
				{command = Keys.Plane_HOTAS_PinkySwitchAft		,animation_data = HOTAS_animation(753,-1) },
				{command = Keys.Plane_HOTAS_PinkySwitchCenter	,animation_data = HOTAS_animation(753, 0) },

				{command = Keys.Plane_HOTAS_LeftThrottleButton,arg = 754,arg_increment = 1.0,arg_lim = {0,1}},
				{command = Keys.Plane_HOTAS_LeftThrottleButton_Off,arg = 754,arg_increment = -1.0,arg_lim = {0,1}},

				-- MIC switch is animated in avHOTAS::::SetCommand function
				{command = Keys.Plane_HOTAS_MIC_SwitchUp},
				{command = Keys.Plane_HOTAS_MIC_SwitchDown},
				{command = Keys.Plane_HOTAS_MIC_SwitchLeft},
				{command = Keys.Plane_HOTAS_MIC_SwitchRight},
				{command = Keys.Plane_HOTAS_MIC_SwitchOff},
							
				{command = Keys.Plane_HOTAS_SpeedBrakeSwitchForward	, animation_data = HOTAS_animation(762 ,1)},
				{command = Keys.Plane_HOTAS_SpeedBrakeSwitchAft		, animation_data = HOTAS_animation(762,-1)},
				{command = Keys.Plane_HOTAS_SpeedBrakeSwitchCenter	, animation_data = HOTAS_animation(762, 0)},
				
				{command = Keys.Plane_HOTAS_TDC_depress_on},
				{command = Keys.Plane_HOTAS_TDC_depress_off},

				{command = Keys.PlaneRadarHorizontal},
				{command = Keys.PlaneRadarVertical},
				{command = Keys.PlaneRadarHorizontalAbs},
				{command = Keys.PlaneRadarVerticalAbs},
				{command = Keys.PlaneSelecterHorizontal},
				{command = Keys.PlaneSelecterVertical},
				{command = Keys.PlaneSelecterHorizontalAbs},
				{command = Keys.PlaneSelecterVerticalAbs},
				{command = Keys.PlaneRadarLeft},
				{command = Keys.PlaneRadarRight},
				{command = Keys.PlaneRadarUp},
				{command = Keys.PlaneRadarDown},
				{command = Keys.PlaneRadarStop},
				{command = Keys.SelecterLeft},
				{command = Keys.SelecterRight},
				{command = Keys.SelecterUp},
				{command = Keys.SelecterDown},
				{command = Keys.SelecterStop},
				
				{command = Keys.PlaneFire},
				{command = Keys.PlaneFireOff},	
				
				{command = Keys.PlaneTrimLeft ,animation_data = HOTAS_animation(738,-1)},-- Триммер влево
				{command = Keys.PlaneTrimRight,animation_data = HOTAS_animation(738, 1)},-- Триммер вправо
				{command = Keys.PlaneTrimUp   ,animation_data = HOTAS_animation(739, 1)},-- Триммер вверх
				{command = Keys.PlaneTrimDown ,animation_data = HOTAS_animation(739,-1)},-- Триммер вниз
				{command = Keys.PlaneTrimStop ,animation_data = HOTAS_animation_release({738,739})},			
}
						