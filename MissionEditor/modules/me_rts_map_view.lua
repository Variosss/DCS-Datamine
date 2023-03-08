local base = _G

module('me_rts_map_view')

local require = base.require
local table = base.table
local math = base.math
local pairs = base.pairs
local ipairs = base.ipairs

local U = require('me_utilities')


function onMouseDown(x, y, button)
	base.print("--RTS-onMouseDown--",x, y, button)
	base.rts.onMouseDown(x, y, button)
end

function onMouseDrag(dx, dy, button, x, y)
	base.print("--RTS-onMouseDrag--",dx, dy, button, x, y)
	return base.rts.onMouseDrag(dx, dy, button, x, y)
end

function onMouseMove(x, y)
	base.print("--RTS-onMouseMove--",x, y)
	base.rts.onMouseMove(x, y)
end

function onMouseUp(x, y, button)
	base.print("--RTS-onMouseUp--",x, y, button)
	base.rts.onMouseUp(x, y, button)
end

function onChangeZoom(scale)
	base.print("--RTS-onChangeZoom--",scale)
	base.rts.onChangeZoom(scale)
end

