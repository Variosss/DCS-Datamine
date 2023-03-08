local base = _G

module('list')

__index = base.getfenv()

head = nil
tail = nil
size = 0

function new(self)
	local newList = { size = 0 }
	base.setmetatable(newList,self)
	return newList
end

function clear(self)
	self.head = nil
	self.tail = nil
	self.size = 0
end

function empty(self)
	return self.head ~= nil
end

function insert(self, element, place) --insert before place node
	if place then	
		local newNode = {
			prev_ = place.prev_,
			element_ = element,
			next_ = place
		}
		if place.prev_ then
			place.prev_.next_ = newNode
		end
		place.prev_ = newNode
		self.size = self.size + 1
		return newNode
	else
		if self.tail then			
			local oldTail = self.tail
			self.tail = {
				prev_ = oldTail,
				element_ = element,
				next_ = nil
			}
			oldTail.next_ = self.tail
			self.size = self.size + 1
			return self.tail
		else
			self.tail = {
				prev_ = nil,
				element_ = element,
				next_ = nil
			}
			self.head = self.tail
			self.size = self.size + 1
			return self.head
		end
	end	
end

function erase(self, place) --remove place
	if 	(place.prev_ or place == self.head_) or
		(place.next_ or place == self.tail_) then
		if place.prev_ then
			place.prev_.next_ = place.next_
		end	
		if place.next_ then
			place.next_.prev_ = place.prev_
		end	
		if place == self.head then
			self.head = place.next_
		end
		if place == self.tail then
			self.tail = place.prev_
		end
		self.size = self.size - 1
		return place.next_ or place.prev_			
	else
		return nil
	end
end

function push_back(self, element)
	return self:insert(element)
end

function push_front(self, element)
	return self:insert(element, self.head)
end

function get_size(self)
	return self.size
end
