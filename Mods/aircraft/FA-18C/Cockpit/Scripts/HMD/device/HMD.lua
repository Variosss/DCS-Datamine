dofile(LockOn_Options.script_path.."HMD/indicator/HMD_units.lua")

dacLowerPoint	= DegToRad(0)			-- [rad] elevation of movement start
dacUpperPoint	= DegToRad(30)			-- [rad] elevation of movement stop
dacBiasMax		= DegToRad(9)			-- [rad] DAC movement amount from start to stop

hudBoresightShiftY	= -DegToRad(4)

need_to_be_closed = true -- close lua state after initialization 