local DialogLoader		= require('DialogLoader')
local music				= require('me_music')
local Factory			= require('Factory')
local i18n				= require('i18n')
local lfs               = require('lfs')
local U                 = require('me_utilities')
local Gui               = require('dxgui')

_ = i18n.ptranslate

local function construct(self)
	local localization =
	{
		ok = _('OK'),
		Campaign_end = _('CAMPAIGN END'),
	}

	self.window = DialogLoader.spawnDialogFromFile('MissionEditor/modules/dialogs/campaign_end_dialog.dlg', localization)

    w, h = Gui.GetWindowSize()
    
    self.window:setBounds(0, 0, w, h)
    self.window.containerMain:setBounds((w-1280)/2, (h-768)/2, 1280, 768)
    
	self.pictureWidget = self.window.containerMain.panelBody.pictureWidget
	self.editBoxText = self.window.containerMain.panelBody.editBoxText
	
	self.victoryPictureSkin = self.window.staticVictoryPicture:getSkin()
	self.defeatPictureSkin = self.window.staticDefeatPicture:getSkin()
	
	local hide = function ()
		music.stop()
		music.start()
		
		self.window:setVisible(false)
	end
	
	self.window.containerMain.panelBottom.btnOk.onChange = hide
	--self:getCloseButton().onChange = hide
	
	self.window:addHotKeyCallback('escape', hide)
	self.window:addHotKeyCallback('return', hide)

	return self.window
end

-- обновление диалога
local function update(self, isCampaignWon, campaign)
	local text
	local pictureSkin = {}
	local musicFile

	if isCampaignWon then
        U.recursiveCopyTable(pictureSkin, self.victoryPictureSkin)
        
        local locale = i18n.getLocale()
        local pictureSuccess = campaign["pictureSuccess_"..locale] or campaign.pictureSuccess
        
        if pictureSuccess then
            local picFile = campaign.dir..'/'.. pictureSuccess        
            local attributes = lfs.attributes(picFile)		        
            if pictureSuccess and attributes and attributes.mode == 'file' then
                pictureSkin.skinData.states.released[1].picture.file = picFile
            end
        end    

		text = _(
[[Campaign Success!

Given your outstanding contributions to the war effort, our forces have triumphed over the enemy! Your efforts in particular were instrumental in bringing about a swift and decisive conclusion to this unfortunate chapter in history. You should hold your head high in the knowledge that your bravery and skill saved countless friendly lives.
Well done soldier!]])
		musicFile = 'CampaignMusic/victory.ogg'
	else
        U.recursiveCopyTable(pictureSkin, self.defeatPictureSkin)
        
		local locale = i18n.getLocale()
        local pictureFailed = campaign["pictureFailed_"..locale] or campaign.pictureFailed
        
        if pictureFailed then
            local picFile = campaign.dir..'/'.. pictureFailed            
            local attributes = lfs.attributes(picFile)
            if attributes and attributes.mode == 'file' then
                pictureSkin.skinData.states.released[1].picture.file = picFile
            end
        end    
		
		text = _(
[[Campaign Failure

Given your inability to effectively contribute to the war effort, our forces have been defeated. Your efforts in particular were lacking in bringing about a favorable conclusion to this unfortunate chapter in our history. You should feel no honor knowing that your failures cost many friendly lives and brought the shame of defeat upon our great country.]])
		musicFile = 'CampaignMusic/defeat.ogg'
	end

	music.stop()
	music.start({musicFile})
	self.pictureWidget:setSkin(pictureSkin)
	self.editBoxText:setText(text)
end

local function show(self, isCampaignWon, campaign)	
	update(self, isCampaignWon, campaign)
	
	self.window:setVisible(true)
end

return Factory.createClass({
	construct = construct,
	show = show,
})
