function init()
	eng_on = true
	booster_off = true
	march_off = true
	march2_off = true
	outports.booster(false)
	outports.march(false)
	outports.march2(false)
	outports.march_smoke(false)
end

function on_eng_on(value)
	eng_on = value
end

function run(t)
	if (${boost_start} - t > ${dt}) then
		next_call_t = ${boost_start} - t
		return validate_t(next_call_t)
	end
	
	if (booster_off) then
		booster_off = false
		outports.booster(true)
		next_call_t = ${march_start} - t
		return validate_t(next_call_t)
	end
	
	if (not eng_on) then
		return -1
	end
	
	if (t - ${march_start} >= 0) and march_off then
		march_off = false
		outports.march(true)
		next_call_t = ${march2_start} - t
		return validate_t(next_call_t)
	end
		
	if (t - ${march2_start} >= 0) and march2_off then
		march2_off = false
		outports.march2(true)
		next_call_t = ${march_smoke_start} - t
		return validate_t(next_call_t)
	end
	
	if (t - ${march_smoke_start} >= 0) then
		outports.march_smoke(true)
		return -1
	end
		
	return ${dt}
end

function validate_t(t)
	if (t < ${dt}) then
		t = ${dt}
	else
		t = math.ceil(t/${dt}) * ${dt}
	end
	return t
end