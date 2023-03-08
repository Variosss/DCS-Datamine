local base = _G

module('me_staticTemplateLoad')

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
local advGrid           = require('advGrid')
local UC				= require('utils_common')
local Static            = require('Static')
local Skin              = require('Skin')
local TheatreOfWarData	= require('Mission.TheatreOfWarData')
local MsgWindow			= require('MsgWindow')

i18n.setup(_M)


cdata = {
	TempGame			= _("Default"),
	TempUser			= _("Customized"),
	Close				= _("Close"),
	Cancel				= _("Cancel"),
	NAME				= _("NAME"),
	MAP					= _("MAP"),
	Load				= _("Load"),
	LOADTEMP			= _("LOAD TEMPLATE"),
	Description			= _("Description"),
	delete				= _("Delete"),
	BACK				= _("BACK"),
	delFile 			= _('Are you sure you want to delete the file?'), 
	yes 				= _('YES'),
	no 					= _('NO'),
	warning 			= _('WARNING'), 
}

local staticTemplateSysPath 	= './MissionEditor/data/scripts/StaticTemplate'
local staticTemplateUserPath	= lfs.writedir() .. 'StaticTemplate/'

local dataSys = {}
local dataUser = {}
local rowLast = -1
local selectRowLast = -1
local selectStaticTemplate = nil

function create()

	w, h = Gui.GetWindowSize()
	window = DialogLoader.spawnDialogFromFile('./MissionEditor/modules/dialogs/me_staticTemplateLoad.dlg', cdata)
	
	containerMain = window.containerMain
	
	eName			= containerMain.panelBody.eName	
	eDesc			= containerMain.panelBody.eDesc	
	eFileName		= containerMain.panelBody.eFileName
	sWarning		= containerMain.panelBody.sWarning
	bLoadSys		= containerMain.panelBody.bLoadSys
	bLoadUser		= containerMain.panelBody.bLoadUser
	bClose			= containerMain.panelTop.bClose 
	bCancel			= containerMain.panelBottom.bCancel	
	gridSys			= containerMain.panelBody.gridSys
	gridUser		= containerMain.panelBody.gridUser
	bDelete			= containerMain.panelBody.bDelete
	
	
	pNoVisible		= window.pNoVisible
	
	staticSkinGridNormal	= pNoVisible.staticNormal:getSkin()
    staticSkinGridSelect	= pNoVisible.staticSelected:getSkin()
    staticSkinGridHover		= pNoVisible.staticHover:getSkin()
	
	gridSysAdv = advGrid.new(gridSys)
	gridUserAdv = advGrid.new(gridUser)
	
	skinsForGrid =
    {
        all = {
            normal = staticSkinGridNormal,
            select = staticSkinGridSelect,
            hover  = staticSkinGridHover,
        },
    }    
    
    gridSysAdv:setSkins(skinsForGrid)
	gridUserAdv:setSkins(skinsForGrid)
	
	
	bClose.onChange 	= onChange_bClose
	bCancel.onChange 	= onChange_bClose
	bLoadSys.onChange 	= onChange_bLoad
	bLoadUser.onChange 	= onChange_bLoad
	bDelete.onChange 	= onChange_bDelete
	
	containerMain:setPosition((w-1280)/2,(h-768)/2)
	window:setBounds(0,0,w, h)
	
	setupCallbacksAddGrid(gridSys, gridSysAdv)
	setupCallbacksAddGrid(gridUser, gridUserAdv)
	
	eDesc:setText("")
	
	window:addHotKeyCallback('escape'	, onChange_bClose)
end

function unSelectRow(grid, rowIndex)
    local nameCellLast = grid:getCell(0, rowIndex)
    
    if nameCellLast then
		nameCellLast:setSkin(staticSkinGridNormal)
        grid:getCell(1, rowIndex):setSkin(staticSkinGridNormal)
	end
end

function selectRow(grid,rowIndex)
	local nameCell = grid:getCell(0, rowIndex)    
	if nameCell then
		nameCell:setSkin(staticSkinGridSelect)
        grid:getCell(1, rowIndex):setSkin(staticSkinGridSelect)
	end
end 


function setupCallbacksAddGrid(a_grid, a_gridAdv) 
	a_grid.onMouseDown = function(self, x, y, button)
        if 1 ~= button then
            return
        end
        
        local col, row = a_grid:getMouseCursorColumnRow(x, y)

        if -1 < row then
			if curGrid then
				curGrid:unSelectGrid()
			end
				
            local cell = self:getCell(0, row)
			selectStaticTemplate = nil
			
            if cell then
				eDesc:setText(cell.desc)
				selectStaticTemplate = cell.fullFileName
				curGrid = a_gridAdv
                a_gridAdv:selectRow(row)  			
            end                               
        end
    end
end

function show(b)
	if window == nil then
		create()
	end
	
	if b then
		dataSys = {}
		dataUser = {}
		loadData(staticTemplateSysPath, dataSys)
		loadData(staticTemplateUserPath, dataUser)
		
		fillGrid(gridSys, dataSys)
		fillGrid(gridUser, dataUser)
	end
	
	window:setVisible(b)
end


function onChange_bClose()
	window:setVisible(false)
end

function onChange_bLoad()
--base.print("---onChange_bLoad---",selectStaticTemplate)
	if selectStaticTemplate then
		staticTemplate.load(selectStaticTemplate)
		window:setVisible(false)
	end
end

function loadData(a_path, a_data)
	local missionTheatre = TheatreOfWarData.getName()
	for fileName in lfs.dir(a_path) do
		local ext = UC.getExtension(fileName)
		if ext == "stm" then
			local result, info = staticTemplate.getInfo(a_path..'/'..fileName)
			if result == true and missionTheatre == info.theatre then 
				base.table.insert(a_data,info)
			end	
		end
	end
	
end

function fillGrid(a_grid, a_data)
	a_grid:removeAllRows()
	for k, info in base.pairs(a_data) do
		a_grid:insertRow(20)
		
	------1
		local cell = Static.new()
		cell:setText(info.name)
		a_grid:setCell(0, k-1, cell)
		cell:setSkin(staticSkinGridNormal)
		cell:setTooltipText(info.fullFileName)
		cell.fullFileName = info.fullFileName
		cell.desc = info.desc

	------2
		cell = Static.new()
		cell:setText(info.theatre)
		a_grid:setCell(1, k-1, cell)
		cell:setSkin(staticSkinGridNormal)
	end
end


function onChange_bDelete()
	if curGrid == gridUserAdv then
		local selectedRowIndex = gridUser:getSelectedRow()
		
		if selectedRowIndex then
			local cell = gridUser:getCell(0, selectedRowIndex)
			
            if cell then
				local handler = MsgWindow.warning(cdata.delFile, cdata.warning, cdata.yes, cdata.no)
        
				function handler:onChange(buttonText)
					if (buttonText == cdata.yes) then
						os.remove(cell.fullFileName)
						gridUser:removeRow(selectedRowIndex)
					end
				end

				handler:show()
			end	
		end
	end
end




