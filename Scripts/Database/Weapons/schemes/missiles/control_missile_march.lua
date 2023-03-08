function init()
	eng_on = true
	booster_off = true
	outports.booster(false)
	outports.march(false)
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
		
	if (t - ${march_start} >= 0) then
		outports.march(true)
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