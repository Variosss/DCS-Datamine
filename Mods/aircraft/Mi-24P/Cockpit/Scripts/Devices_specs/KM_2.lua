-- KM-2 - Magnetic Variation Entry Panel

ElecConsumerParamsDC = 
{
	0.1, 			-- load DC current KM-2, [A]
	true,
	19.0,			-- DC voltage value after which the KM-2 is off, [V]
	22.0, 			-- DC voltage value after which the KM-2 is on, [V]
	27.0			-- nominal DC voltage value KM-2, [V]
 }

ElecConsumerParamsAC = 
{
	0.1, 			-- load AC current KM-2, [A]
	true,
	28.0,			-- AC voltage value after which the KM-2 is off, [V]
	30.0, 			-- AC voltage value after which the KM-2 is on, [V]
	36.0			-- nominal AC voltage value KM-2, [V]
 }
 
 ElecConsumerParamsLights = {0.5, true}
 
ScaleK = 0.06
test					= math.rad(315.0) --gr/sec

magnetic_scale = {isLagElement = true, T1 = 0.4, bias = ptrsBias}

need_to_be_closed = true -- lua_state  will be closed in post_initialize()
