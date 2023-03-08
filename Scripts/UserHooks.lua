local lfs = require('lfs')
package.path = (lfs.writedir()..'Scripts\\?.lua;')
	.. '.\\Scripts\\?.lua;'
	.. '.\\Scripts\\UI\\?.lua;'
	.. './LuaSocket/?.lua;'
	.. './dxgui/bind/?.lua;'
	.. './dxgui/loader/?.lua;'
	.. './dxgui/skins/skinME/?.lua;'
	.. './dxgui/skins/common/?.lua;'
	.. './MissionEditor/modules/?.lua;'

--package.cpath = 'bin/lua-?.dll;bin/?.dll;'..package.cpath

-- init gui
Gui = require('dxgui')
GuiWin = require('dxguiWin')
setmetatable(dxgui, {__index = dxguiWin})
local UpdateManager = require('UpdateManager')
Gui.AddUpdateCallback(UpdateManager.update)

OptionsData = require('Options.Data')

me_db = require('me_db_api')
me_db.create()

RPC = require('RPC')
