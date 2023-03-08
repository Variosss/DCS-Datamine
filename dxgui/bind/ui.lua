module("ui", package.seeall)
local mtab = { __index = _M }

local Window = require("Window")
local Static = require("Static")
local Button = require("Button")
local EditBox = require("EditBox")
local CheckBox = require("CheckBox")


local function args(a)
    if type(a)=="table" then return unpack(a)
    else return a end
end

local function make(t, descr, ...)
    local res = t.new(...)
    local k,v
    for k,v in pairs(descr) do
        res[k](res, args(v))
    end
    local env = getfenv(3)
    env._window:insertWidget(res)
    return res
end


local ops = {
R = function(x1, y1, x2, y2, ...)
    return x1, y1, x2-x1, y2-y1, ...
end,

EditBox = function(d)
    return make(EditBox, d)
end,

Static = function (text, d)
    return make(Static, d, text)
end,

Button = function (text, d)
    return make(Button, d, text)
end,

CheckBox = function (text, d)
    return make(CheckBox, d, text)
end,


Window = function(...)
    local env = getfenv(2)
    local w = Window.new(...)
    env._window = w
    return w
end,
} -- ops


function load(name)
    local res = {}
    setmetatable(res, { __index = ops })
    local file, err = loadfile(name)
    if not file then
        dxgui.MessageBox(err, "UI Load Error", "OK")
        return nil, err
    end
    setfenv(file, res)
    local ok, err = pcall(file)
    if not ok then
        dxgui.MessageBox(err, "UI Run Error", "OK")
        return nil, err
    end
    return res
end
    