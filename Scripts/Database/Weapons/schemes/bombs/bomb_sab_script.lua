function init()
	count = 0;
	outputs.check_obj(false);
	outports.open(false)
end


function getBasis(w, x, y, z, axis)
    local wx, wy, wz, xx, yy, yz, xy, xz, zz, x2, y2, z2;
	x2 = x + x;
	y2 = y + y;
	z2 = z + z;
	xx = x * x2;   xy = x * y2;   xz = x * z2;
	yy = y * y2;   yz = y * z2;   zz = z * z2;
	wx = w * x2;   wy = w * y2;   wz = w * z2;

	if( axis == 0 ) then
        return 1.0 - (yy + zz), xy + wz, xz - wy;
    end
	
	if( axis == 1 ) then
		return xy - wz, 1.0 - (xx + zz), yz + wx;
    end
	
	if( axis == 2 ) then
		return xz + wy, yz - wx, 1.0 - (xx + yy);
	end    
end

function run(t)
	min_delay = math.min(${check_delay}, ${open_delay});
	max_delay = math.min(${check_delay}, ${open_delay});

	next_call_t = min_delay - t;
	if (next_call_t > 0) then
		return validate_t(next_call_t);
	end

	-- Note! If check_delay > open_delay it will
	-- be enabled with one of open_interval steps
	if (t - ${check_delay} >= 0) then
		outputs.check_obj(true);
	end
	
	if (t - ${open_delay} >= 0) then
		local qw, qx, qy, qz = inputs.rot();
        local x, y, z        = inputs.pos();
        local xx, xy, xz     = getBasis(qw, qx, qy, qz, 0);
        local yx, yy, yz     = getBasis(qw, qx, qy, qz, 1);
            
        x = x - yx*0.15 - xx*0.3;
        y = y - yy*0.15 - xy*0.3;
        z = z - yz*0.15 - xz*0.3;
            
        outputs.pos(x, y, z);
        
		outports.open(true);
        count = count + 1;
            
        if (count < ${items_count}) then
            return validate_t(${open_interval});
        else
            return -1;
        end
	end
	
	next_call_t = max_delay - t;
	if (next_call_t > 0) then
		return validate_t(next_call_t);
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