dofile(LockOn_Options.script_path.."command_defs.lua")
KeyCommands =
{
	{command = Keys.Selected_Engine_start},
	{command = Keys.Selected_Engine_start_up},
	{command = Keys.Selected_Engine_stop},
	{command = Keys.Selected_Engine_stop_up},
	{command = Keys.APU_stop},
	{command = Keys.APU_stop_up},
	{command = Keys.EngineLaunchMethodSelect},
	{command = Keys.Engine_Select},				
	{command = Keys.Left_Engine_Break},
	{command = Keys.Right_Engine_Break},
	{command = Keys.Rotor_Break},
	--axis commands
	{command = Keys.LeftEngineBrake_ByAxis},
	{command = Keys.RightEngineBrake_ByAxis},
	{command = Keys.RotorEngineBrake_ByAxis},				

	{command = Keys.ElectronicControlSystemLeftEngine},
	{command = Keys.ElectronicControlSystemLeftEngineCover},
	{command = Keys.ElectronicControlSystemRightEngine},
	{command = Keys.ElectronicControlSystemRightEngineCover},
	{command = Keys.iCommandPlane_ReadjustFreeTurbineRPM_Up},
	{command = Keys.iCommandPlane_ReadjustFreeTurbineRPM_Down},
	
	{command = Keys.iCommandHelicopter_Engine_Temperature_Control_Cover},
	{command = Keys.iCommandHelicopter_Engine_Temperature_Control},
	
	{command = Keys.iCommandHelicopter_TC_RPM},
	{command = Keys.iCommandHelicopter_TC_RPM_Cover},
	
	{command = Keys.iCommandHelicopter_Engines_Anti_Icing_Dust_Protection_System},
	{command = Keys.iCommand_ENG_INTERF_Right_Engine_RT_12_6},
	{command = Keys.iCommand_ENG_INTERF_Left_Engine_RT_12_6},
	{command = Keys.iCommand_ENG_INTERF_EngVibrDetectorBIT},
	{command = Keys.iCommand_ENG_INTERF_TempIndTestwRunningEng},
	{command = Keys.iCommand_ENG_INTERF_TempIndTestwStoppedEng},
	{command = Keys.iCommandHelicopter_Rotor_Anti_Icing_Dust_Protection_System},
}
