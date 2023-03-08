local base = _G

module('NodesMap')
mtab = { __index = _M }

local Factory = base.require('Factory')
local Widget = base.require('Widget')
local gui_nodes_map = base.require('gui_nodes_map')

Factory.setBaseClass(_M, Widget)

function new()
  return Factory.create(_M)
end

function construct(self)
  Widget.construct(self)
end

function newWidget(self)
  return gui_nodes_map.NewNodesMap()
end

function updateNodes(self, nodes)
    gui_nodes_map.NodesMapUpdateNodes(self.widget, nodes)
end

function getSelectedNodes(self)
  return gui_nodes_map.NodesMapGetSelectedNodes(self.widget)
end

function setMissionNode(self, nodeId)
    gui_nodes_map.NodesMapSetMissionNode(self.widget, nodeId)
end

function setMapBorders(self, minX, minZ, maxX, maxZ)
    gui_nodes_map.NodesMapSetMapBorders(self.widget, minX, minZ, maxX, maxZ)
end
