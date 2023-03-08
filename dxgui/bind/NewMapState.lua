-- Модуль для взаимодействия c картой
-- определяет реакцию карты на действия мыши
local base = _G

module('NewMapState')
mtab = { __index = _M }

local Factory = base.require('Factory')

function new(mapView)
  return Factory.create(_M, mapView)
end

function construct(self, mapView)
  self.mapView = mapView
  mapView:setState(self)
end

function setMap(self, mapView)
  self.mapView = mapView  
end

function onMouseMove(self, x, y)
end

function onMouseDown(self, x, y, button)
end

function onMouseDoubleClick(self, x, y, button)
  self:onMouseDown(x, y, button)
end

function onMouseUp(self, x, y, button)
end

function onMouseDrag(self, dx, dy, button, x, y)
  if 3 == button then 
    local cameraX, cameraY = self.mapView:getCamera()
    local mapX0, mapY0 = self.mapView:getMapPoint(0, 0) 
    local mapX1, mapY1 = self.mapView:getMapPoint(dx, dy) 
    local mapX = mapX1 - mapX0
    local mapY = mapY1 - mapY0
    cameraX = cameraX - mapX
    cameraY = cameraY - mapY
    self.mapView:setCamera(cameraX, cameraY)
  end
end

function onMouseWheel(self, x, y, clicks)
end