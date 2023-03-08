dofile(LockOn_Options.script_path.."Displays/Common/indicator/Units.lua")

dacLowerPoint	= DegToRad(30)		-- [rad] elevation of movement start
dacUpperPoint	= DegToRad(80)		-- [rad] elevation of movement stop
dacBiasMax		= MilToRad(168)		-- [rad] DAC movement amount from start to stop

hudBoresightShiftY	= -MilToRad(98)

need_to_be_closed = true -- close lua state after initialization 