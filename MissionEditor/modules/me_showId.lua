local base = _G

module('me_showId')

local DialogLoader	= base.require('DialogLoader')
local Static		= base.require('Static')
local i18n			= base.require('i18n')
local ProductType 	= base.require('me_ProductType') 

i18n.setup(_M)

local cdata = 
{
    groupName   = _("Group name:"),
    groupId     = _("Group Id:"),
    unitName    = _("Unit name"),
    unitId      = _("Unit Id:"),
    Ok          = _("Ok"),
    ShowId      = _("Show Id"),
    
}

if ProductType.getType() == "LOFAC" then
    cdata.unitName    = _("Unit name-LOFAC")
    cdata.unitId      = _("Unit Id:-LOFAC")
end

local vdata = 
{
    group = nil,
}

function create(x, y)
    
    window = DialogLoader.spawnDialogFromFile("MissionEditor/modules/dialogs/me_showId.dlg", cdata)
    local x_, y_, w_, h_ window:getBounds()
    window:setBounds(x, y, w_, h_)
    
    eGroupName = window.pBox.eGroupName
    eGroupId = window.pBox.eGroupId
    
    SkinStatic = window.pBox.StaticTempl:getSkin()
    
    gridUnits = window.pBox.gridUnits
    btnOk = window.pBox.btnOk
    btnOk.onChange = onChange_Ok
    btnClose = window.btnClose
    btnClose.onChange = onChange_Ok
end

function onChange_Ok()
    show(false)
end

function setGroup(a_group)
    group = a_group
end

function show(b)
    if b == true then
        window:setVisible(true)
        update()
    else
        group = nil
        window:setVisible(false)
    end
end

function update()
    eGroupName:setText("")
    eGroupId:setText("")
    gridUnits:removeAllRows()
    
    if group == nil then        
        return
    end
    
    eGroupName:setText(group.name)
    eGroupId:setText(group.groupId)

    local rowIndex = 0;
    for k,v in base.pairs(group.units) do
        gridUnits:insertRow(20)

        local cell = Static.new()
        cell:setSkin(SkinStatic)
        cell:setText(k)
        gridUnits:setCell(0, rowIndex, cell)
        
        cell = Static.new()
        cell:setSkin(SkinStatic)
        cell:setText(v.name)
        gridUnits:setCell(1, rowIndex, cell)
        
        cell = Static.new()
        cell:setSkin(SkinStatic)
        cell:setText(v.unitId)
        gridUnits:setCell(2, rowIndex, cell)
        
        rowIndex = rowIndex + 1;
    end
end


