dofile(LockOn_Options.common_script_path.."elements_defs.lua")

ARC51_table_font_Size = 0.0056
ARC51_table_font = {ARC51_table_font_Size, 0.67 * ARC51_table_font_Size, 0.00003, 0}

-- size of sheet
x_size  = 0.1227
y_size  = 0.0413

x_size_05 = x_size * 0.5
y_size_05 = y_size * 0.5

channel_dx = 2.0 / 4.0
channel_dy = 2.0 / 6.0
channel_shift_x = -(channel_dx * 0.5) + 0.2023 * channel_dx

function get_channel_x(channel)
	local ret = 0.0

	if (channel < 3) then
		ret = (-channel_dx * 1.5)
	else
		if (channel < 9) then
			ret = (-channel_dx * 0.5) + channel_dx * 0.07
		else
			if (channel < 15) then
				ret = (channel_dx * 0.5) + channel_dx * 0.1
			else
				ret = (channel_dx * 1.5) + channel_dx * 0.07
			end
		end
	end

	return (ret + channel_shift_x) * x_size_05
end

function get_channel_y(channel)
	local ret = 0.0

	if (channel == 2) then
		ret = (1.0 - channel_dy * 0.5 - (channel - 1) * channel_dy) + channel_dy * 0.2
	else
		if (channel < 3) then
			ret = (1.0 - channel_dy * 0.5 - (channel - 1) * channel_dy) + channel_dy * 0.1
		else
			if (channel < 9) then
				ret = (1.0 - channel_dy * 0.5 - (channel - 3) * channel_dy) + channel_dy * 0.1
			else
				if (channel < 15) then
					ret = (1.0 - channel_dy * 0.5 - (channel - 9) * channel_dy) + channel_dy * 0.1
				else
					ret = (1.0 - channel_dy * 0.5 - (channel - 15) * channel_dy) + channel_dy * 0.1
				end
			end
		end
	end

	return ret * y_size_05
end




mip_filter_used = true

function use_mipfilter(object)
	if mip_filter_used then
		object.use_mipfilter = true
	end
end

