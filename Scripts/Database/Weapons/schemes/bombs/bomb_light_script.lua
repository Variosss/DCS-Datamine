function init()
	outputs.check_obj(false);
	outputs.par_open(false);
end

function run(t)
	min_delay = math.min(${delay_check}, ${delay_par});
	max_delay = math.max(${delay_check}, ${delay_par});

	next_call_t = min_delay - t;
	if (next_call_t > 0) then
		return validate_t(next_call_t);
	end

	if (t - ${delay_check} >= 0) then
		outputs.check_obj(true);
	end
	
	if (t - ${delay_par} >= 0) then
		outputs.par_open(true);
	end
	
	next_call_t = max_delay - t;
	if (next_call_t > 0) then
		return validate_t(next_call_t);
	end
	
	return -1;
end

function validate_t(t)
	if (t < ${dt}) then
		t = ${dt}
	else
		t = math.ceil(t/${dt}) * ${dt}
	end
	return t;
end