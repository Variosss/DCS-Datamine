function init()
end

function run(t)
	if t == 0 then
		outputs.check_obj(false);
		return ${delay};
	else
		outputs.check_obj(true);
		return -1;
	end
end