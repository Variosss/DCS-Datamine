local base = _G
module('pretty')
local string = base.string

local function val2str(val)
	local t = base.type(val)
	if t=="number" or t=="boolean" then
		return base.tostring(val)
	elseif t == "table" then
		return "!TABLE!"
	else
		return string.format("%q", base.tostring(val))
	end
end

local function array2str(tbl)
	local res
	local k, v
	for k,v in base.ipairs(tbl) do
		if res then
			res = res .. ", " .. val2str(v)
		else
			res = val2str(v)
		end
	end
	if not res then res = "" end
	return "{" .. res .. "}"
end

local function is_empty(tbl)
	local k,v
	for k,v in base.pairs(tbl) do
		return false
	end
	return true
end

local function is_plain(tbl)
	local k,v
	for k,v in base.pairs(tbl) do
		if base.type(v) == "table" then
			return false
		end
	end
	return true
end

local function is_array(tbl)
	return tbl[1] ~= nil or is_empty(tbl)
end

local do_save

local function do_save_value(out, v, indent, endl)
	if base.type(v) == "table" then
		if is_array(v) and is_plain(v) and nil then
			out(array2str(v))
		else
			out("{\n")
			do_save(out, v, indent .. "\t", ",\n")
			out(indent .. "}")
		end
	else
		out(val2str(v))
	end
end

local function do_save_hash(out, tbl, indent, endl)
	for k,v in base.pairs(tbl) do
		out(indent .. k .. " = ")
		do_save_value(out, v, indent, endl)
		out(endl)
	end
end

local function do_save_array(out, tbl, indent, endl)
	for k,v in base.ipairs(tbl) do
		out(indent)
		do_save_value(out, v, indent, endl)
		out(endl)
	end
end

do_save = function(out, tbl, indent, endl)
	if is_array(tbl) then
		do_save_array(out, tbl, indent, endl)
	else
		do_save_hash(out, tbl, indent, endl)
	end
end

function format(out, tbl)
	do_save(out, tbl, "", "\n")
end

function tostring(tbl)
	local res = ""
	do_save(function(str) res = res..str end, tbl, "", "\n")
	return res
end
