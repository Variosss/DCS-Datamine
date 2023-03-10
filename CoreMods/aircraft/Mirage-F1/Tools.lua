
function copyTable(src, target)
    if not target then
        target = {}
    end
	
    for i, v in pairs(src) do
        if type(v) == 'table' then
            if not target[i] then
                target[i] = {}
            end
            copyTable(v, target[i])
        else
            target[i] = v
        end
    end
	
    return target
end
