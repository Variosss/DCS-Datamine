require 'class'

--Matrix33  class which reflect DCS internal matrix math
--test code for export 
--require 'Matrix33'

--local data = LoGetSelfData()
--local yaw   = 2.0 * math.pi - data.Heading -- because heading returned opposite for navigation use 
--local pitch = data.Pitch
--local roll  = data.Bank
--
--local m = Matrix33()
--m:RotateY(yaw);
--m:RotateZ(pitch);
--m:RotateX(roll);
--print("-------------------------------------")
--print(m.x.x,m.x.y,m.x.z)
--print(m.y.x,m.y.y,m.y.z)
--print(m.z.x,m.z.y,m.z.z)


Matrix33 = class(function(v)
	v.x = {x = 1, y = 0, z = 0}
	v.y = {x = 0, y = 1, z = 0}
	v.z = {x = 0, y = 0, z = 1}
end)

function Matrix33.RotateX(self, arad)
	local  _sin = math.sin(arad);
	local  _cos = math.cos(arad);

	local _y = self.y.x;
	local _z = self.z.x;
	self.y.x = _y*_cos + _z*_sin;
	self.z.x = _z*_cos - _y*_sin;

	_y = self.y.y; 
	_z = self.z.y;
	self.y.y = _y*_cos + _z*_sin;
	self.z.y = _z*_cos - _y*_sin;

	_y = self.y.z; 
	_z = self.z.z;
	self.y.z = _y*_cos + _z*_sin;
	self.z.z = _z*_cos - _y*_sin;
	
end

function Matrix33.RotateY(self, arad) 
	local  _sin = math.sin(arad);
	local  _cos = math.cos(arad);
                                      
	local _x = self.x.x;
	local _z = self.z.x;                 
	self.x.x = _x*_cos - _z*_sin;
	self.z.x = _z*_cos + _x*_sin;
                                      
	_x = self.x.y;
	_z = self.z.y;                 
	self.x.y = _x*_cos - _z*_sin;
	self.z.y = _z*_cos + _x*_sin;
                                      
	_x = self.x.z;
	_z = self.z.z;                 
	self.x.z = _x*_cos - _z*_sin;
	self.z.z = _z*_cos + _x*_sin;
end                                  
                                      
function Matrix33.RotateZ(self, arad) 
	local  _sin = math.sin(arad);
	local  _cos = math.cos(arad);
                                     
	local _x = self.x.x;
	local _y = self.y.x;                 
	self.x.x = _x*_cos + _y*_sin;
	self.y.x = _y*_cos - _x*_sin;
                                      
	_x = self.x.y;
	_y = self.y.y;                 
	self.x.y = _x*_cos + _y*_sin;
	self.y.y = _y*_cos - _x*_sin;
                                      
	_x = self.x.z;
	_y = self.y.z;                 
	self.x.z = _x*_cos + _y*_sin;
	self.y.z = _y*_cos - _x*_sin;
end