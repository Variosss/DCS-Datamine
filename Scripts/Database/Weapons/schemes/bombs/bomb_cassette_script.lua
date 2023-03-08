function init()
	count = 0;
	check_off = true;
	outputs.check_obj(false);
	outports.open(false);
end


function run(t)
	if (${check_delay} - t > ${dt}) then
		next_call_t = ${check_delay} - t;
		return validate_t(next_call_t);
	end

	if (check_off) then
		check_off = false;
		outputs.check_obj(true);
		next_call_t = ${open_delay} - t;
		return validate_t(next_call_t);
	end

	if (t - ${open_delay} >= 0) then
		outports.open(true);
		return -1;
	end

	return ${dt};
end

function validate_t(t)
	if (t < ${dt}) then
		t = ${dt}
	else
		t = math.ceil(t/${dt}) * ${dt}
	end
	return t;
end