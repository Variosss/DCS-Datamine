local lfs 			= require('lfs')
local InputData		= require('Input.Data')
Input 				= require('Input')
Input.Loader		= require('Input.Loader')

local userConfigPath = lfs.writedir() .. 'Config/Input/'
local sysConfigPath = './Config/Input/'

-- Turn Input logging in Config/main.cfg

InputData.initialize(userConfigPath, sysConfigPath)
Input.setUnitMarker(InputData.getUnitMarker())

Input.Loader.load(sysConfigPath)
