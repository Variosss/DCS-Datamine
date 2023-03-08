-- Vector.lua
-- A class representing vectors in 3D
require 'class'

Vector = class(function(v,x,y,z) v:set(x,y,z) end)

function Vector.__eq(self,p)
  return (self.x == p.x) and (self.y == p.y) and (self.z == p.z)
end

function Vector.get(self)
  return self.x, self.y, self.z
end

-- vector addition is '+','-'
function Vector.__add(self,p)
  return Vector(self.x+p.x, self.y+p.y, self.z+p.z)
end

function Vector.__sub(self,p)
  return Vector(self.x-p.x, self.y-p.y, self.z-p.z)
end

-- unitary minus  (e.g in the expression f(-p))
function Vector.__unm(self)
  return Vector(-self.x, -self.y, -self.z)
end

-- scalar multiplication and division is '*' and '/' respectively
function Vector.__mul(self,s)
	if type(self) == 'table' and getmetatable(self) == Vector and type(s) == 'table' then
		return self.x*s.x+self.y*s.y+self.z*s.z
	elseif type(self) == 'number' and type(s) == 'table' and getmetatable(s) == Vector then
		return Vector( self*s.x, self*s.y, self*s.z )
	elseif type(self) == 'table' and getmetatable(self) == Vector and type(s) == 'number' then
		return Vector( self.x*s, self.y*s, self.z*s )
	end
	return nil
end

function Vector.__div(self,s)
  return Vector( self.x/s, self.y/s, self.z/s )
end

-- dot product is also '..'
function Vector.__concat(self,p)
  return self.x*p.x + self.y*p.y + self.z*p.z
end

-- cross product is '^'
function Vector.__pow(self,p)
   return Vector(
     self.y*p.z - self.z*p.y,
     self.z*p.x - self.x*p.z,
     self.x*p.y - self.y*p.x
   )
end

function Vector.ort(self)
  local l = self:length()
  if l > 0 then
	return Vector(self.x/l, self.y/l, self.z/l)
  else
	return self
  end
end

function Vector.normalize(self)
  local l = self:length()
  if l > 0 then
	self.x = self.x/l
	self.y = self.y/l
	self.z = self.z/l
  end
end

function Vector.set(self,xx,yy,zz)
  if type(xx) == 'table' and getmetatable(xx) == Vector then
     local po = xx
     xx = po.x
     yy = po.y
     zz = po.z
  end
  self.x = xx
  self.y = yy
  self.z = zz 
end

function Vector.translate(self,dx,dy,dz)
  return Vector(self.x + dx, self.y + dy, self.z + dz)
end

function Vector.__tostring(self)
  return string.format('(%f,%f,%f)',self.x,self.y,self.z)
end

function Vector.length(self)
  return math.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
end

function Vector.rotZ(self, ang)
  local sina = math.sin(ang)
  local cosa = math.cos(ang)
  return Vector(self.x * cosa - self.y * sina, self.x * sina + self.y * cosa, self.z)
end

function Vector.rotX(self, ang)
  local sina = math.sin(ang)
  local cosa = math.cos(ang)
  return Vector(self.x, self.y * cosa - self.z * sina, self.y * sina + self.z * cosa)
end

function Vector.rotY(self, ang)
  local sina = math.sin(ang)
  local cosa = math.cos(ang)
  return Vector(self.z * sina + self.x * cosa, self.y, self.z * cosa - self.x * sina)
end

function Vector.rotAxis(self, axis, ang)
	local ax = axis:ort()
	local cosa = math.cos(ang)
	local sina = math.sin(ang)
	local versa = 1.0 - cosa
	local xy = ax.x * ax.y
	local yz = ax.y * ax.z
	local zx = ax.z * ax.x
	local sinx = ax.x * sina
	local siny = ax.y * sina
	local sinz = ax.z * sina
	local m10 = ax.x * ax.x * versa + cosa
	local m11 = xy * versa + sinz
	local m12 = zx * versa - siny
	local m20 = xy * versa - sinz
	local m21 = ax.y * ax.y * versa + cosa
	local m22 = yz * versa + sinx
	local m30 = zx * versa + siny
	local m31 = yz * versa - sinx
	local m32 = ax.z * ax.z * versa + cosa
	return Vector(m10 * self.x + m20 * self.y + m30 * self.z, 
	              m11 * self.x + m21 * self.y + m31 * self.z, 
	              m12 * self.x + m22 * self.y + m32 * self.z)
end

-- Examples:
-- u = Vector(1.0, 0.0, 0.0)
-- v = Vector(0.0, 1.0, 0.0)
-- a = u + v * 10.0 -- a == Vector(1.0, 10.0, 0.0)
-- c = u ^ v -- cross product c == Vector{0.0, 0.0, 1.0}
-- d = u * v -- dot product d == 0.0
-- d = u .. v -- alternative dot product syntax
-- len = c:length() -- len == 1.0
-- xcoord = u.x -- xcoord == 1.0
-- w = u:rotY(math.pi/4) -- rotation around Y-axis: w == Vector(0.707107, 0.0, -0707107)
