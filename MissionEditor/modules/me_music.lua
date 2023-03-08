module('me_music', package.seeall)

local sound		= require('sound')
local lfs		= require('lfs')
local Widget	= require('Widget')
local U			= require('me_utilities')


-- path to samples directory
local samplesPath = 'Effects/'

local enableEffects = true
local playingMusic = false
local lastPlayList = {}

function init(wave_path, sdef_path)
    sound.init(wave_path, sdef_path)

    Widget.setSoundCallback(play)
end

local function exit()
	sound.exit()
end

function update()
	sound.update()
end


function playListFromDir(dirPath)
    local list = {}
    for file in lfs.dir(dirPath) do
        local fullPath = dirPath .. file
        if 'file' == lfs.attributes(fullPath).mode then
            table.insert(list, fullPath)
        end
    end 
    return list
end


-- start music player
function start(playlist)
    if (playlist ~= nil) then
        U.recursiveCopyTable(lastPlayList, playlist)
    else
        playlist = {}
        U.recursiveCopyTable(playlist, lastPlayList)
    end
        
    if not playingMusic then        
        sound.playMusic(playlist)
        playingMusic = true
    end
end

-- stop music player
function stop()
    if playingMusic then
        sound.stopMusic()
        playingMusic = false
    end
end

-- set volume of music

-- if volumes equals to zero music playng disabled
function setMusicVolume(volume)
    local v = volume/100.0
    sound.setMusicGain(v)
    if (0 == v) then
        stop()
    else
        start(lastPlayList)
    end
end

-- play sound
function play(name)
    if not enableEffects then
        return 0
    end
    
    sound.playSound(samplesPath .. name)
    return 0
end

-- play sound of mission
function playOneSound(name)
    sound.playPreview(name)
end

function stopOneSound()
    sound.stopPreview()
end

function setEffectsVolume(volume)
    local gain = volume / 100.0
    enableEffects = 0 < gain
    sound.setEffectsGain(gain)
end

function pause()
	sound.pauseMusic()
end

function resume()
	sound.resumeMusic()
end