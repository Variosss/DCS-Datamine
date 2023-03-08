function init()
	outports.fire(false)
end

function run(t)
	if (${delay} - t > ${dt}) then
		next_call_t = ${delay} - t;
		return validate_t(next_call_t);
	end
	
    outports.fire(true)
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