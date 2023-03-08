local menus = data.menus

local openFormation = true

data.rootItem = {
	name = _('Main'),
	getSubmenu = function(self)		
		local tbl = {
			name = _('Main'),
			items = {
			}
		}
		if #data.menuOther.submenu.items > 0 then
			tbl.items[10] = {
				name = _('Other'),
				submenu = data.menuOther.submenu
			}
		end		
		if #data.menuEmbarkToTransport.submenu.items > 0 then
			tbl.items[6] = {
				name = _('Descent'),
				submenu = data.menuEmbarkToTransport.submenu,
				condition = data.menuEmbarkToTransport.condition
			}
		end
		return tbl
	end,
}