local base = _G

module('me_staticTemplateSave')

local require       = base.require
local pairs         = base.pairs
local ipairs        = base.ipairs
local table         = base.table
local math          = base.math
local loadfile      = base.loadfile
local setfenv       = base.setfenv
local string        = base.string
local assert        = base.assert
local io            = base.io
local loadstring    = base.loadstring
local print         = base.print
local os            = base.os

local Tools 			= require('tools')
local lfs 				= require('lfs')
local S 				= require('Serializer')
local i18n 				= require('i18n')
local Gui				= require('dxgui')
local DialogLoader		= require('DialogLoader')
local FileDialogUtils	= require('FileDialogUtils')
local staticTemplate	= require('me_staticTemplate') 
local MsgWindow			= require('MsgWindow')

i18n.setup(_M)

cdata = {
	createTemp 			= _("Create Static Template"),
	Name 				= _("Name"),
	Description			= _("Description"),
	FileName			= _("File Name"),
	Save				= _("Save"),
	Close				= _("Close"),
	Create				= _("Create"),
	Cancel				= _("Cancel"),
	text				= _("The current mission will be saved as a template"),
	already				= _("Such file already exists"),
	invalidFilenameMsg 	= _('Invalid filename!'),
	overwriteFile		= _('File already exists on disk, do you wish to overwrite file?'),  
	question 			= _('QUESTION'), 
	cancel 				= _('Cancel'),
	yes 				= _('YES'),
	no 					= _('NO'),
}

function create()
	w, h = Gui.GetWindowSize()
	window = DialogLoader.spawnDialogFromFile('./MissionEditor/modules/dialogs/me_staticTemplateSave.dlg', cdata)
	
	containerMain = window.containerMain
	
	eName			= containerMain.panelBody.eName	
	eDesc			= containerMain.panelBody.eDesc	
	eFileName		= containerMain.panelBody.eFileName
	sWarning		= containerMain.panelBody.sWarning
	bClose			= containerMain.pUp.bClose 
	bCancel			= containerMain.pBtn.bCancel	
	bCreate			= containerMain.pBtn.bCreate

	bClose.onChange 	= onChange_bClose
	bCancel.onChange 	= onChange_bClose
	bCreate.onChange  	= onChange_bCreate
	eFileName.onChange 	= onChange_eFileName
	
	containerMain:setPosition((w-450)/2,(h-550)/2)
	window:setBounds(0,0,w, h)
	
	eName:setText(_("New name"))
	eDesc:setText("")
	eFileName:setText(_("New template"))
	
	window:addHotKeyCallback('escape', onChange_bClose)
end

function show(b)
	if window == nil then
		create()
	end

	window:setVisible(b)
end


function onChange_bClose()
	window:setVisible(false)
end

function onChange_eFileName(self)
	local fileName = self:getText()
	local fullFileName = lfs.writedir() .. 'StaticTemplate/'..fileName..'.stm'
	if FileDialogUtils.getFilenameIsValid(fullFileName) == false then
		sWarning:setText(cdata.invalidFilenameMsg)
		sWarning:setVisible(true)
		bCreate:setEnabled(false)
	else
		bCreate:setEnabled(true)
		if FileDialogUtils.getFileExists(fullFileName) == true then
			sWarning:setText(cdata.already)
			sWarning:setVisible(true)			
		else
			sWarning:setVisible(false)			
		end	
	end
end

function onChange_bCreate()
	local fullFileName = lfs.writedir() .. 'StaticTemplate/'..eFileName:getText()..'.stm'
	
	if FileDialogUtils.getFileExists(fullFileName) == true then
		local handler = MsgWindow.question(cdata.overwriteFile, cdata.question, cdata.yes, cdata.no, cdata.cancel)
		
		function handler:onChange(button)
            handler:hide()
			if button == cdata.yes then                
				staticTemplate.save(fullFileName, eName:getText(), eDesc:getText())
			end
		end		
		handler:show()
	else
		staticTemplate.save(fullFileName, eName:getText(), eDesc:getText())
	end
	
	window:setVisible(false)
end





