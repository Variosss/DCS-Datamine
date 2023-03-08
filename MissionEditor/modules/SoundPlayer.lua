--Контрол 

local base = _G

module('SoundPlayer')
mtab = { __index = _M }

local require = base.require
local pairs = base.pairs
local type = base.type
local table = base.table

local Factory           = require('Factory')
local Grid              = require('Grid')
local Skin              = require('Skin')
local U                 = require('me_utilities')
local textutil          = require('textutil')
local DialogLoader      = require('DialogLoader')
local music             = require('me_music')
local sound				= require('sound')
local UpdateManager	    = require('UpdateManager')

-------------------------------------------------------------------------------
--
function new()
  return Factory.create(_M)
end

-------------------------------------------------------------------------------
--
function construct(self)
    self.timeUpdate = 0 
    self.timeUpdateStart = 0 
    
    local dialog = DialogLoader.spawnDialogFromFile("MissionEditor/modules/dialogs/SoundPlayer.dlg", cdata)
    
    self.container = dialog.panelWidgets
    
    dialog:removeWidget(self.container)
    dialog:kill()
    
    self.buttonPlay = self.container.ButtonPlay
    self.buttonPlay.parent = self
    self.buttonPlay.onChange = playSound   
    
    self.ButtonStop = self.container.ButtonStop
    self.ButtonStop.parent = self
    self.ButtonStop.onChange = stopSound 
    
    self.Slider = self.container.Slider
    
    self.Text = self.container.sText 
    self.Text:setText("00:00 / 00:00")
end

function setBounds(self,x, y, w, h)
    self.container:setBounds(x, y, w, h)
    self.Slider:setBounds(60, 15, w-60,20)
    self.Text:setBounds(w-140, 5, 140,20)
end

function getContainer(self)
    return self.container
end

function setPathSound(self, a_path)
    self.path = a_path
	self.buttonPlay:setEnabled(true)
	music.stopOneSound();
    UpdateManager.delete(updateSoundInfo)  
    if self.path then
        self.soundInfo = sound.getWaveInfo(self.path)
        self.Text:setText(base.string.format('00:00 / %s', getTimeF(self.soundInfo.length)))   
        self.Slider:setRange(0, base.math.floor(self.soundInfo.length))
       --base.print("---self.soundInfo.length----",self.soundInfo.length)
        self.Slider:setValue(0)
    else    
        self.Text:setText("00:00 / 00:00")
        self.Slider:setValue(0)
    end
end

function getTimeF(a_time)
    local mm = base.math.floor(a_time / 60)
	local ss = base.math.floor(a_time - mm * 60)
    return base.string.format('%02i:%02i',mm,ss)
end

function updateSoundInfo()
    curSelf.timeUpdate = base.math.floor(base.os.clock() - curSelf.timeUpdateStart)
    if (curSelf.timeUpdate) > curSelf.soundInfo.length then
        UpdateManager.delete(updateSoundInfo)
    else
        curSelf.Text:setText(base.string.format('%s / %s',getTimeF(curSelf.timeUpdate), getTimeF(curSelf.soundInfo.length)))    
        curSelf.Slider:setValue(curSelf.timeUpdate)
        
        --base.print("---setValue---",curSelf.timeUpdate)
    end
    
end

function playSound(self) 
	local parent = self.parent
	if parent.path and parent.soundInfo then
		music.playOneSound(parent.path)
		parent.timeUpdateStart = base.os.clock()
		curSelf = parent
		UpdateManager.delete(updateSoundInfo)
		UpdateManager.add(updateSoundInfo)	 
		parent.buttonPlay:setEnabled(false)	
	end  
end

function stopSound(self)
    local parent = self.parent
    if parent.soundInfo then
        music.stopOneSound();
        UpdateManager.delete(updateSoundInfo)    
        parent.Text:setText(base.string.format('00:00 / %s', getTimeF(parent.soundInfo.length)))    
        parent.Slider:setValue(0)
		parent.buttonPlay:setEnabled(true)
    end
end