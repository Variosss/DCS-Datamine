
function copyTable(target, src)
    for i, v in pairs(src) do
        if type(v) == 'table' then
            if not target[i] then
                target[i] = { }
            end
            copyTable(target[i], v)
        else
            target[i] = v
        end
    end
end
