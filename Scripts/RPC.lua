local log = require('log')

module('RPC', package.seeall)
method = {}
currentRequest = nil

local _RPC_requests = {}

local function arg_pack(...) return {n=select('#', ...), ...} end
local function arg_unpack(args) return unpack(args, 1, args.n) end


function onRequest(sender_id, method_name, param_str, request_id)
    local func = method[method_name]
    if not func then
        net.send_rpc_error(sender_id, request_id, 404, "Method not found")
        return
    end
    local ok, params = pcall(net.json2lua, param_str)
    if not ok then
        net.send_rpc_error(sender_id, request_id, 400, params)
        return
    end
    local ok, result = pcall(func, sender_id, arg_unpack(params))
    if not ok then
        print("RPC", result)
        net.send_rpc_error(sender_id, request_id, 500, result)
    end
    if request_id then
        result_str = net.lua2json(result)
        net.send_rpc_result(sender_id, request_id, result_str)
    end
end

function onResult(sender_id, request_id, result_str)
    local req = _RPC_requests[request_id]
    if not req then return end
    _RPC_requests[request_id] = nil
    log.debug("rpc result for %d: %s", request_id, result_str)
    currentRequest = req
    local result = net.json2lua(result_str)
    local ok, err = pcall(req.handler, sender_id, result)
    currentRequest = nil
end

function onError(sender_id, request_id, error_code, error_msg)
    local req = _RPC_requests[request_id]
    if req then
        _RPC_requests[request_id] = nil
    end
    print(string.format("LuaRPC Error: request = %d, error_code = %d, error_msg = %s", request_id, error_code, error_msg))
end

function sendEvent(dest_id, method, ...)
    net.send_rpc_request(dest_id, method, net.lua2json(arg_pack(...)), 0)
end

function sendRequest(handler, dest_id, method, ...)
    local params = arg_pack(...)
    local request_id = net.send_rpc_request(dest_id, method, net.lua2json(params))
    _RPC_requests[request_id] = { handler = handler, host_id = dest_id, request_id = request_id, method = method, params = params }
    log.debug("rpc request %d: %s", request_id, method)
end

function resetRequests()
    _RPC_requests = {}
end
