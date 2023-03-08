function init()
	outputs.check_obj(false);
end

function run(t)
	next_call_t = ${delay} - t;
	if (next_call_t > ${dt}) then
		return validate_t(next_call_t);
	end
	
    outputs.check_obj(true);
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