local base = _G

module('VideoPlayerWidget')
mtab = { __index = _M }

local Factory = base.require('Factory')
local Widget = base.require('Widget')
local gui_video_player = base.require('gui_video_player')

Factory.setBaseClass(_M, Widget)

function new()
	return Factory.create(_M)
end

function construct(self)
	Widget.construct(self)
	
	self:addVideoUpdateCallback(function()
		self:onVideoUpdate()
	end)	
	
	self:addVideoFinishedCallback(function()
		self:onVideoFinished()
	end)
end

function newWidget(self)
	return gui_video_player.NewWidget()
end

function setRectSize(self, width, height)
	gui_video_player.SetRectSize(self.widget, width, height)
end

function getRectSize(self)
	local width, height = gui_video_player.GetRectSize(self.widget)
	
	return width, height
end

function setRectPosition(self, x, y)
	gui_video_player.SetRectPosition(self.widget, x, y)
end

function getRectPosition(self)
	local x, y = gui_video_player.GetRectPosition(self.widget)
	
	return x, y
end

function openVideo(self, filename)
	return gui_video_player.Open(self.widget, filename)
end

function closeVideo(self, filename)
	return gui_video_player.Close(self.widget)
end

function getPos(self)
	return gui_video_player.GetPos(self.widget)
end	

function getLength(self)
		return gui_video_player.GetLength(self.widget)
end

function pause(self)
		return gui_video_player.Pause(self.widget)
end

function play(self)
		return gui_video_player.Play(self.widget)
end

function setSeek(self, pos)
		gui_video_player.Seek(self.widget, pos)
end

function addVideoUpdateCallback(self, callback)
	self:addCallback('video player update', callback)
end

function addVideoFinishedCallback(self, callback)
	self:addCallback('video player finished', callback)
end

function onVideoUpdate(self)
end

function onVideoFinished(self)
end