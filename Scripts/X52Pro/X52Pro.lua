local basespace = _G

module('X52Pro')

direct_output = basespace.require('direct_output')
basespace.dofile ("Scripts/X52Pro/X52Pro_enum.lua")
basespace.require 'class'

function myclass(bs,ctor)
    basespace.print("class")
    return basespace.class(bs,ctor)
end


DirectOutputDevice = myclass(function(d,dev)                  d:create(dev) end)
DirectOutputPage   = myclass(function(p,dev,id,name,activate) p:create(dev,id,name,activate) end)

function DirectOutputPage.create(self,dev,id,name,activate)
    basespace.print("add_page")
    self.device = dev
    self.id     = id
    self.name   = name
    self.active = activate
    direct_output.add_page(self.device,
                           self.id,
                           self.name,
                           self.active);
end

function DirectOutputPage.free(self)

    direct_output.remove_page(self.device,
                              self.id);
    self.device = nil
    self.id     = nil
    self.active = false
end

function DirectOutputPage.set_string(self,index,value)  direct_output.set_string(self.device,self.id,index,value);   end
function DirectOutputPage.set_led   (self,index,value)  direct_output.set_led   (self.device,self.id,index,value);   end


function DirectOutputDevice.create(self,dev)
  basespace.print("create device")
  self.device = dev
  self.pages  = {}
end

function DirectOutputDevice.new_page(self,name,active)
  
  local page_id       = #self.pages
  local active        = active
  
  if active == nil then
     active  = false
  end
  basespace.print("new page")
  self.pages[page_id] = DirectOutputPage(self.device,page_id,name,active)
  return self.pages[page_id]
end

function DirectOutputDevice.get_page(self,id)
  return self.pages[id]
end


function  on_device_change(device,added)
    dbg_print("device added\n")
	if  added then
        direct_output.devices[device] = DirectOutputDevice(device)
        local dev  = direct_output.devices[device]
		local page = dev:new_page("first",true)
              page:set_string(0,"simple string");
              page:set_led(LED_COMPLEX_FIRE_A,LED_RED);
	else
        basespace.table.remove(direct_output.devices,device)
	end
end

function  on_soft_button (device,action)


end

function  on_page_change (device,page,activate)


end

basespace.on_device_change = basespace.on_device_change or on_device_change
basespace.on_soft_button   = basespace.on_soft_button   or on_soft_button
basespace.on_page_change   = basespace.on_page_change   or on_page_change

function   initialize()
    direct_output.devices = {}
    return direct_output.initialize()    
end

function   deinitialize()
    direct_output.devices = {}
    return direct_output.deinitialize()    
end

