local log = require('log')

module('WebSocket', package.seeall)

local handlers = {}
local connections = {}

function addHandler(uri, func)
    handlers[uri] = func
end

function delHandler(uri)
    handlers[uri] = nil
end

function send(conn, data)
    _websocket_send(conn.id, data)
end


-- internal machinery

local function dummy_ready(conn) end
local function dummy_receive(data) end
local function dummy_close(conn) end

function onConnect(conn_id, uri, addr, port)
    local h = handlers[uri]
    if h then
        local conn = {}
        conn.id = conn_id
        conn.uri = uri
        conn.addr = addr
        conn.port = port
        conn.onReady = dummy_ready
        conn.onReceive = dummy_receive
        conn.onClose = dummy_close
        conn.send = send
        local c = h(conn)
        if c then 
            connections[conn_id] = c
            return true
        end
    end
    return false
end

function onReady(conn_id)
    local c = connections[conn_id]
    if c then
        return c:onReady()
    end
end

function onReceive(conn_id, data)
    local c = connections[conn_id]
    if c then
        return c:onReceive(data)
    end
end

function onClose(conn_id)
    local c = connections[conn_id]
    if c then
        c:onClose()
        connections[conn_id] = nil
    end
end
