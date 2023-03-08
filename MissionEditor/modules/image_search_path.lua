-- модуль для установки путей поиска картинок в gui
module('image_search_path', package.seeall)

local dxgui = require('dxgui')

local stack = {}
local mapTextures = {}

local function setGUIPictureSearchPathes()
  local searchPathes = {}
  
  mapTextures = {}
  
  for i, stackItem in ipairs(stack) do
    table.insert(searchPathes, stackItem.path)
    addTexturesInMap(stackItem.path)
  end  
  
  dxgui.SetPictureSearchPathes(searchPathes)
end

function pushPath(path, marker)
  local found = false
  
  for i, stackItem in ipairs(stack) do
    if string.lower(stackItem.path) == string.lower(path) then
      found = true
      
      break
    end
  end
  
  if not found then
    table.insert(stack, 1, {path = path, marker = marker})
    
    setGUIPictureSearchPathes()
  end
end

function getEmpty()
  return #stack == 0
end

function popPath()
  if not getEmpty() then
    table.remove(stack, 1)
    
    setGUIPictureSearchPathes()
  end
end

function getTopPath()
  if not getEmpty() then
    return stack[1].path
  end
end

function getTopPathMarker()
  if not getEmpty() then
    return stack[1].marker
  end
end

function getSearchPaths()
	local result = {}
	
	for i, stackItem in ipairs(stack) do
		table.insert(result, stackItem.path)
	end
	
	return result
end

function addTexturesInMap(a_path)
    for file in lfs.dir(a_path) do
        local b = lfs.attributes(a_path .. '/' .. file)
        if (b.mode == 'file') then
            mapTextures[file] = 1
        end
    end
end

function isTextureAvailable(a_name)
    return mapTextures[a_name] ~= nil
end