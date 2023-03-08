--Phrase construction module

local base = _G

module('phrase')


fullSubtitle = true

--Phrase is a list of sound files + subtitle string. 
--Phrase is a part of speech. 
--Phrase is made from part of message.
--Speech is made from whole message.

--Phrase metatable
mt = {
	__add = function (left, right)
		if right == nil then
			return left
		end
		
		local result = { files = {}, subtitle = left.subtitle or '' , duration = left.duration or 0}
		
		if left.file then
			base.table.insert(result.files, left.file)
		elseif left.files then
			for index, file in base.pairs(left.files) do
				base.table.insert(result.files, file)
			end
		end
		
		if base.type(right) == 'table' then
			if right.file then
				base.table.insert(result.files, right.file)
			elseif right.files then
				for index, file in base.pairs(right.files or {}) do
					base.table.insert(result.files, file)
					--[[
					if file ~= nil then
						base.print('\t file = '..file)
					else
						base.print('\t file = nil')
					end
					--]]
				end
			end
			result.subtitle 	= result.subtitle..right.subtitle or ''
			--base.print('\"'..right.subtitle..'\" duration = '..right.duration)
			--base.print('result.duration = '..result.duration..' + '..right.duration..' = '..(result.duration + right.duration))
			result.duration 	= result.duration + right.duration
		else
			result.subtitle 	= result.subtitle..base.tostring(right)
		end
		return create(result)
	end
}

function create(tbl)
	return base.setmetatable(tbl, mt)
end

function separator(sep_)
	local tbl = { files = {}, subtitle = sep_, duration = 0.0 }
	return create(tbl)
end


function start()
	local tbl = { files = {}, subtitle = '', duration = 0.0 }
	return create(tbl)
end

--Phrase with only pronouncable subtitle

function _s(phrase_)
	local tbl = { files = {}, subtitle = phrase_, duration = 0.0 }
	return create(tbl)
end

--Phrase with full subtitle

function _S(phrase_)
	if fullSubtitle then
		local tbl = { files = {}, subtitle = '['..phrase_..']', duration = 0.0 }
		return create(tbl)
	end
end

--Phrase with only one audio file

function _f(file_)
	local tbl = { files = {file_}, subtitle = '', duration = 0.0 }
	return create(tbl)
end

local syllableDuration = 0.28
local delimeterDuration = 0.13

local symbolDuration = {
	['A'] = syllableDuration,
	['E'] = syllableDuration,
	['I'] = syllableDuration,
	['O'] = syllableDuration,
	['U'] = syllableDuration,
	['Y'] = syllableDuration,
	['&'] = syllableDuration, --'and'
	['+'] = syllableDuration, --'plus'
	['-'] = delimeterDuration,
	[';'] = delimeterDuration,
	--[':'] = delimeterDuration,
	[','] = delimeterDuration,
	['.'] = delimeterDuration,
	['\n'] = 0.26
}

local function getTextDuration(text)
	local result = 0.0
	local strLen = base.string.len(text)
	for i = 1, strLen do
		local symbol = base.string.sub(text, i, i)
		result = result + (symbolDuration[symbol] or 0.0)
	end
	return result
end

local digitDuration = {
	[0] = getTextDuration('ZERO'),
	[1] = getTextDuration('ONE'),
	[2] = getTextDuration('TWO'),
	[3] = getTextDuration('THREE'),
	[4] = getTextDuration('FOUR'),
	[5] = getTextDuration('FIVE'),
	[6] = getTextDuration('SIX'),
	[7] = getTextDuration('SEVEN'),
	[8] = getTextDuration('EIGHT'),
	[9] = getTextDuration('NINE'),
}

--[[
local digitDuration = {}
for d = 0, 9 do
	digitDuration[d] = 1.1 * syllableDuration
end
--]]

for digit, duration in base.pairs(digitDuration) do
	symbolDuration[base.tostring(digit)] = duration
end

--Phrase with audio file and subtitle

--Phrase can contain:
--	- file name
--	- subtitle string
--	- native phrase to pronounce (used to calculate phrase length)
--	- phrase to pronounce (helpers for phrase recordes and not used in the simulator)

function getSubtitle(phrase_)
	return base.type(phrase_) == 'table' and (phrase_[1] or phrase_[2]) or phrase_
end

function getFile(phrase_)
	return base.type(phrase_) == 'table' and (phrase_[2] or phrase_[1]) or phrase_
end

function getNativeTextToPronounce(phrase_)
	return base.type(phrase_) == 'table' and (phrase_[3] or phrase_[2] or phrase_[1]) or phrase_
end

function getTextToPronounce(phrase_)
	return base.type(phrase_) == 'table' and (phrase_[4] or phrase_[3] or phrase_[1] or phrase_[2]) or phrase_
end

function _p(phrase_, directory)
	local subtitle			= getSubtitle(phrase_)
	local file				= getFile(phrase_)
	local files = nil
	if base.type(file) == 'table' then
		local filesRaw = file
		for fileRawIndex, fileRaw in base.pairs(filesRaw) do
			if fileRaw ~= '' then		
				files = files or {}
				base.table.insert(files, directory and directory..'/'..fileRaw or fileRaw)
			end
		end
	elseif file ~= '' and file ~= nil then
		files = { [1] = directory and directory..'/'..file or file}
	end
	if files == nil then
		return nil
	end
	local nativeTextToPronuounce = getNativeTextToPronounce(phrase_)
	local pureNativeTextToPronuounce = base.string.upper(base.string.gsub(nativeTextToPronuounce, '<[^>]*>', ''))
	local tbl = {	files = files,
					subtitle = subtitle,
					duration =  getTextDuration(pureNativeTextToPronuounce) }
	--base.print('\''..pureNativeTextToPronuounce..'\' duration = '..tbl.duration)
	return create(tbl)
end

--Phrase of digits

function digits_string(str)
	local digitsStr = base.string.upper(base.string.gsub(str, '-', 'minus'))
	digitsStr = base.string.upper(base.string.gsub(digitsStr, '[.,]', 'decimal'))
	local tbl = { files = {}, subtitle = str, duration = getTextDuration(digitsStr) }
	local strLen = base.string.len(str)
	for i = 1, strLen do
		local digit = base.string.sub(str, i, i)
		local pos			
		if i == base.string.len(str) then
			pos = '-end'			
		elseif i == 1 then
			pos = '-begin'
		else
			pos = '-continue'
		end
		if base.tonumber(digit) ~= nil then
			base.table.insert(tbl.files, 'Digits/'..digit..pos)
		elseif digit == '.' or digit == ',' then
			base.table.insert(tbl.files, 'Digits/point'..pos)
		end
	end
	--base.print(str..' duration = '..tbl.duration)
	return create(tbl)
end

function digits(num, fmt)
	return digits_string(base.string.format(fmt or '%d', num))
end

function digit_groups(fmt, ...)
	return digits_string(base.string.format(fmt or '%d', ...))
end

local soundEffectDir = 'Effects/Aircrafts/Cockpits/'

--Radio clicks
function addRadioClicks(p)
	if p.files ~= nil then
		base.table.insert(p.files, 1, soundEffectDir..'RadioClickBefore.wav')
		base.table.insert(p.files, soundEffectDir..'RadioClickAfter.wav')
	end
end

--Phrase of morze text

local dotDuration = 0.15
local morzeDir = soundEffectDir..'Morze/'

function morze(str, type)
	local tbl = { files = {}, subtitle = '', duration = 0.0 }
	local morze_string = base.Message.convertToMorze(str)
	for i = 1, base.string.len(morze_string) do
		local symbol = base.string.sub(morze_string, i, i)
		if symbol == ' ' then
			base.table.insert(tbl.files, morzeDir..'MorzeSpace')
			tbl.duration = tbl.duration + 5 * dotDuration
		else
			if symbol == '_' then
				base.table.insert(tbl.files, morzeDir..type..'/MorzeDash')
				tbl.duration = tbl.duration + 3 * dotDuration
			elseif symbol == '.' then
				base.table.insert(tbl.files, morzeDir..type..'/MorzeDot')
				tbl.duration = tbl.duration + dotDuration
			end
			base.table.insert(tbl.files, morzeDir..'MorzePause')
			tbl.duration = tbl.duration + dotDuration
		end
	end
	-- NOTE: TACAN (1350 Hz) MorzeSilence length is made 30 seconds.
	-- The goal is to have AT LEAST 30 seconds of silence between ID transmissions.
	-- The maximum ID length is assumed to be 7.5 seconds,
	-- and the total time delay between two ID transmissions is 37.5 seconds.
	base.table.insert(tbl.files, morzeDir..type..'/MorzeSilence')
	--tbl.subtitle = morze_string
	
	return create(tbl)
end

--Numbers

local function number1(num, tbl)
	if num >= 1 then
		num = base.math.floor(num + 0.5)
		base.table.insert(tbl.files, num)
		tbl.duration = tbl.duration + digitDuration[num]
	end
end

local numberDuration = {
	[10] = getTextDuration('TEN'),
	[11] = getTextDuration('ELEVEN'),
	[12] = getTextDuration('TWELVE'),
	[13] = getTextDuration('THIRTEEN'),
	[14] = getTextDuration('FOURTEEN'),	
	[15] = getTextDuration('FIVETEEN'),
	[16] = getTextDuration('SIXTEEN'),
	[17] = getTextDuration('SEVENTEEN'),
	[18] = getTextDuration('EIGHTEEN'),
	[19] = getTextDuration('NINETEEN'),	
	
	[20] = getTextDuration('TWENTY'),
	[30] = getTextDuration('THIRTY'),
	[40] = getTextDuration('FOURTY'),
	[50] = getTextDuration('FIVETY'),
	[60] = getTextDuration('SIXTY'),
	[70] = getTextDuration('SEVENTY'),
	[80] = getTextDuration('EIGHTY'),
	[90] = getTextDuration('NINETY'),
	[100] = getTextDuration('HUNDRED'),
	
	[1000] = getTextDuration('THOUSAND'),
	[1000000] = getTextDuration('MILLION'),
}

local function number2(num, tbl)
	if num > 19 then
		local dec = base.math.floor(num / 10) * 10
		base.table.insert(tbl.files, dec)
		number1(num - dec, tbl)
		tbl.duration = tbl.duration + numberDuration[dec]
	elseif num >= 10 then
		base.table.insert(tbl.files, num)
		tbl.duration = tbl.duration + numberDuration[num]
	else
		number1(num, tbl)
	end
end

local function number3(num, tbl)
	if num > 99 then
		local hundred = base.math.floor(num / 100)
		base.table.insert(tbl.files, hundred * 100)
		tbl.duration = tbl.duration + digitDuration[hundred] + numberDuration[100]		
		number2(num - hundred * 100, tbl)
	else
		number2(num, tbl)
	end
end

local function number_(num)
	base.assert(num >= 0.0)
	local tbl = { files = {}, subtitle = num, duration = 0.0 }
	if num == 0 then
		base.table.insert(tbl.files, 0)
		tbl.duration = digitDuration[0]
		return tbl
	end	
	--1000
	local thousands = base.math.floor(num / 1000)
	if thousands > 19 then
		local thousandsRoundedToTenth = 10 * base.math.floor(thousands / 10)
		number3(thousandsRoundedToTenth, tbl)
		local remainThounsands = thousands - thousandsRoundedToTenth
		if remainThounsands > 0 then
			base.table.insert(tbl.files, remainThounsands * 1000)
			tbl.duration = tbl.duration + digitDuration[remainThounsands] + numberDuration[1000]
		else
			base.table.insert(tbl.files, '1000s')
			tbl.duration = tbl.duration + numberDuration[1000]
		end			
	elseif thousands > 9 then
		base.table.insert(tbl.files, thousands)
		base.table.insert(tbl.files, '1000s')
		tbl.duration = tbl.duration + numberDuration[thousands] + numberDuration[1000]
	elseif thousands > 0 then
		base.table.insert(tbl.files, thousands * 1000)
		tbl.duration = tbl.duration + digitDuration[thousands] + numberDuration[1000]
	end
	--100-10-1
	number3(num - 1000 * thousands, tbl)
	return tbl
end

--Phrase of number

local function add_dirs_number(files)
	for index, file in base.pairs(files) do
		if 	base.type(file) == 'string' or
			file > 9 then
			files[index] = 'Numbers/'..file
		else
			files[index] = 'Digits/'..file
		end
	end
end

local function add_pos(files)
	local files_qty = base.table.getn(files)
	if files_qty > 0 then
		files[files_qty] = files[files_qty]..'-end'
		if files_qty > 1 then
			files[1] = files[1]..'-begin'					
			if files_qty > 2 then
				for i = 2, files_qty - 1 do
					files[i] = files[i]..'-continue'
				end
			end
		end
	end
end

function number(num)
	local tbl = number_(num)
	add_dirs_number(tbl.files)
	add_pos(tbl.files)
	--base.print(num..' duration = '..tbl.duration)
	return create(tbl)
end

--Phrase of index

local function add_dirs_index(files)
	for index, file in base.pairs(files) do
		if index == #files then
			files[index] = 'Indexes/'..file
		elseif 	base.type(file) == 'string' or
				file > 9 then
			files[index] = 'Numbers/'..file
		else
			files[index] = 'Digits/'..file
		end
	end
end

local function add_pos_index(files)
	local files_qty = base.table.getn(files)
	if files_qty > 0 then
		if files_qty > 1 then
			files[1] = files[1]..'-begin'					
			if files_qty > 2 then
				for i = 2, files_qty - 1 do
					files[i] = files[i]..'-continue'
				end
			end
		end
	end
end

function index(num)
	local tbl = number_(num)	
	if base.table.getn(tbl.files) > 0 then
		local lastFile = tbl.files[#tbl.files]
		if lastFile == 1 then
			lastFile = lastFile..'st'
		elseif lastFile == 2 then
			lastFile = lastFile..'nd'
		elseif lastFile == 3 then
			lastFile = lastFile..'rd'			
		else
			lastFile = lastFile..'th'
		end
		tbl.files[#tbl.files] = lastFile
	end
	add_dirs_index(tbl.files)
	add_pos_index(tbl.files)
	return create(tbl)
end

base.print('Speech.phrase module loaded')