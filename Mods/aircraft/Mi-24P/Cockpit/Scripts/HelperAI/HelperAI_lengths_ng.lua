-- a substitute of https://github.com/Youka/LuaWAV/blob/master/wav.lua
--[[
	Library for simple audio reading, writing and analysing.
	
	Copyright © 2014, Christoph "Youka" Spanknebel
	Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
	The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
]]

-- I'd have added the library stated above to the project but there's no file:seek() in our implementation of io

local first_dir = './Mods/Aircraft/Mi-24P/Sounds/'
local second_dir = 'Speech/RUS/MI-24P/HelperAI/'
local extension = '.wav'

filenames_for_c = {}
times = {}


local filenames = {

	'Petrovich_ON', --START
	'Petrovich_OFF', --END
	'_Delimiter', --DELIMITER

	'', --PILOT_COMMENCE,
	'', --PILOT_CEASE,
	
	'Op_RogerSearch', --OP_ROGER,

	'Op_AirDetected', --OP_SEE_AIR,
	'Op_GroundDetected', --OP_SEE_GROUND,

	'Op_1h', --OP_A1H,
	'Op_2h', --OP_A2H,
	'Op_3h', --OP_A3H,
	'Op_4h', --OP_A4H,
	'Op_5h', --OP_A5H,
	'Op_6h', --OP_A6H,
	'Op_7h', --OP_A7H,
	'Op_8h', --OP_A8H,
	'Op_9h', --OP_A9H,
	'Op_10h', --OP_A10H,
	'Op_11h', --OP_A11H,
	'Op_12h', --OP_A12H,

	'Op_d100', --OP_D100M,
	'Op_d200', --OP_D200M,
	'Op_d300', --OP_D300M,
	'Op_d400', --OP_D400M,
	'Op_d500', --OP_D500M,
	'Op_d600', --OP_D600M,
	'Op_d700', --OP_D700M,
	'Op_d800', --OP_D800M,
	'Op_d900', --OP_D900M,
	'Op_d1000', --OP_D1000M,

	'Op_d1_1-5k', --OP_D1_1p5k,
	'Op_d1-5_2k', --OP_D1p5_2k,
	'Op_d2_2-5k', --OP_D2_2p5k,
	'Op_d2-5_3k', --OP_D2p5_3k,
	'Op_d3_3-5k', --OP_D3_3p5k,
	'Op_d3-5_4k', --OP_D3p5_4k,
	'Op_d4_4-5k', --OP_D4_4p5k,
	'Op_d4-5_5k', --OP_D4p5_5k,
	'Op_d5_6k', --OP_D5_6k,
	'Op_d6_7k', --OP_D6_7k,
	'Op_d7_8k', --OP_D7_8k,
	'Op_d8_9k', --OP_D8_9k,
	'Op_d9_10k', --OP_D9_10k,
	'Op_d10k', --OP_D10k,

	'Op_TargetHigher', --OP_TARGET_HIGHER,
	'Op_TargetLower', --OP_TARGET_LOWER,
	
	'Op_Heli',  --OP_HELI,
	'Op_Helis',  --OP_HELIS,
	'Op_CombatHeli',  --OP_COMBATHELI,
	'Op_CombatHelis',  --OP_COMBATHELIS,
	'Op_TransportHeli',  --OP_TRANSPORTHELI,
	'Op_TransportHelis',  --OP_TRANSPORTHELIS,
	'Op_Unmanned',  --OP_UNMANNED,
	'Op_PropPlane',  --OP_PROPPLANE,
	'Op_PropPlanes',  --OP_PROPPLANES,
	'Op_Jet',  --OP_JET,
	'Op_Jets',  --OP_JETS,
	
	'Op_WhiteSmoke',  --OP_WHITESMOKE,
	'Op_RedSmoke',  --OP_REDSMOKE,
	'Op_OrangeSmoke',  --OP_ORANGESMOKE,
	'Op_YellowSmoke',  --OP_YELLOWSMOKE,
	'Op_GreenSmoke',  --OP_GREENSMOKE,
	'Op_BlueSmoke',  --OP_BLUESMOKE,
	'Op_BlackSmoke',  --OP_BLACKSMOKE,
	
	'Op_Armored',  --OP_ARMORED,
	'Op_Truck',  --OP_TRUCK,
	'Op_Trucks',  --OP_TRUCKS,
	'Op_Infantry',  --OP_INFANTRY,
	'Op_SrSam',  --OP_SRSAM,
	'Op_MrSam',  --OP_MRSAM,
	'Op_LrSam',  --OP_LRSAM,
	'Op_Spaag',  --OP_SPAAG,
	'Op_zu23',  --OP_ZU23,
	'Op_GroupSomething',  --OP_GROUPSOMETHING,
	'Op_Ships',  --OP_SHIPS,
	'Op_Ship',  --OP_SHIP,
	
	'Op_Launch_1',  --OP_LAUNCH,
	
	'Op_1unit',  --OP_1UNIT,
	'Op_2units',  --OP_2UNITS,
	'Op_3units',  --OP_3UNITS,
	'Op_to5units',  --OP_TO5UNITS,
	'Op_5to7units',  --OP_5TO7UNITS,
	'Op_8to10units',  --OP_8TO10UNITS,
	'Op_about15units',  --OP_ABOUT15UNITS,
	'Op_morethan15units',  --OP_MORETHAN15UNITS,
	
	'Op_Single',  --OP_SINGLE,
	'Op_Group',  --OP_GROUP,

	--COUNT,
}

local function get_samples_and_rate_from_filename(filename)
	-- Check function parameters
	if type(filename) ~= "string" then
		return 0,0, "invalid function parameters, expected filename"
	end
	-- Audio file handle
	local file = io.open(filename, "r")
	if not file then
		return 0, 0, string.format("couldn't open file %q", filename)
	end
	-- Byte-string(unsigend integer,little endian)<->Lua-number converters
	local function bton(s)
		local bytes = {s:byte(1,#s)}
		local n, bytes_n = 0, #bytes
		for i = 0, bytes_n-1 do
			n = n + bytes[1+i] * 2^(i*8)
		end
		return n
	end
	-- Audio meta informations
	local file_size, channels_number, sample_rate, byte_rate, block_align, bits_per_sample, samples_per_channel
	-- Audio samples file area
	local data_begin, data_end
	-- Read file type
	if file:read(4) ~= "RIFF" then
		error("not a RIFF file", 2)
	end
	file_size = file:read(4)
	if not file_size then
		error("file header incomplete (file size)")
	end
	file_size = bton(file_size) + 8
	if file:read(4) ~= "WAVE" then
		return 0, 0, "not a WAVE file"
	end
	-- Read file chunks
	local chunk_id, chunk_size
	while true do
		-- Read chunk header
		chunk_id, chunk_size = file:read(4), file:read(4)
		if not chunk_size then
			break
		end
		chunk_size = bton(chunk_size)
		-- Identify chunk type
		if chunk_id == "fmt " then
			-- Read format informations
			local bytes = file:read(2)
			if not bytes or bton(bytes) ~= 1 then
				return 0, 0, "data must be in PCM format"
			end
			bytes = file:read(2)
			if not bytes then
				return 0, 0, "channels number not found"
			end
			channels_number = bton(bytes)
			bytes = file:read(4)
			if not bytes then
				return 0, 0, "sample rate not found"
			end
			sample_rate = bton(bytes)
			bytes = file:read(4)
			if not bytes then
				return 0, 0, "byte rate not found"
			end
			byte_rate = bton(bytes)
			bytes = file:read(2)
			if not bytes then
				return 0, 0, "block align not found"
			end
			block_align = bton(bytes)
			bytes = file:read(2)
			if not bytes then
				return 0, 0, "bits per sample not found"
			end
			bits_per_sample = bton(bytes)
			if bits_per_sample ~= 8 and bits_per_sample ~= 16 and bits_per_sample ~= 24 and bits_per_sample ~= 32 then
				return 0, 0, "bits per sample must be 8, 16, 24 or 32"
			end
			file:read(chunk_size-16)
		elseif chunk_id == "data" then
			-- Read samples
			if not block_align then
				return 0, 0, "format informations must be defined before sample data"
			end
			samples_per_channel = chunk_size / block_align
			--data_begin = file:seek()				
			--data_end = data_begin + chunk_size
			break	-- Stop here for later reading
		else
			-- Skip chunk
			file:read(chunk_size)
		end
	end
	-- Enough informations available?
	if not bits_per_sample then
		return 0, 0, "no format informations found"
	end
	io.close(file)
	return samples_per_channel, sample_rate, nil
end

for unneeded_key, short_filename in ipairs(filenames) do
	local filename = first_dir..second_dir..short_filename..extension
	local samples, rate, errormsg = get_samples_and_rate_from_filename(filename)
	if not errormsg then
		local duration = samples / rate
		table.insert(filenames_for_c, second_dir..short_filename)
		table.insert(times, duration)
		print(string.format("%d frames, framerate %d frames/s, duration %.3f sec", samples, rate, duration))
	else
		table.insert(filenames_for_c, "")
		table.insert(times, 0)
		print(errormsg)
	end
end
