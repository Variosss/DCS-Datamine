function join_override(t1, t2)
  local namerows={}

  for k,v in ipairs(t1) do
    namerows[v["name"]] = k
  end
  for k,v in ipairs(t2) do
    local row = namerows[v["name"]]
    if row ~= nil then
      t1[row] = v
    else
      t1[#t1+1] = v
    end
  end
  return t1
end
