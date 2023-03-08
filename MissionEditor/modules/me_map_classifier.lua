local base = _G

module('me_map_classifier')

local require	= base.require
local math		= base.math
local pairs		= base.pairs
local ipairs	= base.ipairs
local table		= base.table
local print		= base.print

local i18n 	= require('i18n')
local me_db = require('me_db_api')

local function load_classifier()
	if classifier == nil then
		print ("LOADING MAP CLASSIFIER")
		local filename  = 'MissionEditor/data/NewMap/Classifier.lua'
		local func, err = base.loadfile(filename)
		if func then
			classifier = func(i18n.ptranslate)
			
			if classifier then
				for k,module_ in pairs(base.plugins) do
					if module_.applied and module_.callbacksME ~= nil  then
						if module_.callbacksME.getClassifier then
							local tmp = module_.callbacksME.getClassifier()
							local ClassifierMod = tmp.Classifier
							local iconsPaths = tmp.iconsPaths
							
							if iconsPaths then
								base.table.insert(classifier.iconsPaths, iconsPaths)
							end
							
							for kk, vv in base.pairs(ClassifierMod) do
								if classifier.objects[kk] == nil then
									classifier.objects[kk] = vv
								end						
							end
						end
					end
				end
			end
		else
			print(err)
		end
		print ("LOADING MAP CLASSIFIER DONE")
	end	
	
	return classifier
end


local function getFromClassifier(classKey)
	load_classifier()
	
	local iconFile
	local rotatable

	if classKey and classifier and classifier.objects then
		local classInfo = classifier.objects[classKey]
		if classInfo then
			iconFile  = classInfo.file
			rotatable = classInfo.rotatable or false
		end
	end
	return iconFile, rotatable
end

local function getUnitIconByType(a_type)
	local  classKey 		   = me_db.getClassKeyByType(a_type)
	local  iconFile, rotatable = getFromClassifier(classKey)
    return iconFile, rotatable
end

return  
{
	get               = load_classifier,
	getFromClassifier = getFromClassifier,
	getUnitIconByType = getUnitIconByType,
}


