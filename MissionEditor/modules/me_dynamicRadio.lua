local base = _G

module('me_dynamicRadio')

local require = base.require

-- Модули LuaGUI
local DialogLoader 		= require('DialogLoader')
local DB 				= require('me_db_api')
local U 				= require('me_utilities')	-- Утилиты создания типовых виджетов
local Static 			= require('Static')
local CheckBox 			= require('CheckBox')
local Button			= require('Button')
local ComboList 		= require('ComboList')
local Slider 			= require('HorzSlider')
local ToggleButton		= require('ToggleButton')
local SpinBox 			= require('SpinBox')
local EditBox 			= require('EditBox')
local ListBoxItem 		= require('ListBoxItem')
local Gui               = require('dxgui')
local lfs 				= require('lfs')
local Tools  			= require('tools')
local TableUtils 		= require('TableUtils')
local TabGroupItem		= require('TabGroupItem')
local i18n 				= require('i18n')
local textutil 			= require('textutil')
local UpdateManager		= require('UpdateManager')
local Tools  			= require('tools')
local MsgWindow			= require('MsgWindow')
local RadioMod 			= require('presetsHandling')

i18n.setup(_M)

cdata = 
{
	RadioOptions		= _("Radio Options"),
	ok					= _("OK"),
	Cancel 				= _('CANCEL'),
	IntegratedRadio		= _('Integrated Radio Units'),
	ExtraRadioUnits		= _('Extra Radio Units'),
	LoadPreset			= _('Load preset'),
	AddRadioUnit		= _('Add existing radio'),
	CustomOptions		= _('Custom Options'),
	dB					= _('dB'),
	InnerNoise			= _('Inner Noise'),
	FrequencyAccuracy 	= _('Frequency Accuracy'),
	BandWidth			= _('Band Width'),
	Hz					= _('Hz'),
	kHz					= _('kHz'),
	MHz					= _('MHz'),
	AutomaticGC			= _('Automatic Gain Control'),
	InputSD				= _('Input Signal Deviation'),
	OutputSD			= _('Output Signal Deviation'),
	InputSLZ    		= _('Input Signal Linear Zone'),
	RegulationTime 		= _('Regulation Time'),
	Sec					= _('sec'),
	AutomaticMD			= _('Automatic Matching Device'),
	MinSearchTime    	= _('Min Search Time'),
	MaxSearchTime    	= _('Max Search Time'),
	Cancel				= _('Cancel'),
	Save				= _('Save'),
	ChoosePreset		= _('Choose preset'),
	ChooseModulation	= _('Choose modulation'),
	SetChannels			= _('Set channels'),
	SetGuard			= _('Set Guard'),
	LA					= _('Unit')..":",
	SetPower			= _('Set power'),
	Add					= _('Add+'),
	Change				= _('Change'),
	Step  				= _('Step'),
	Channels			= _('Channels'),
	FM					= _("FM modulation", "FM"),
	AM					= _("AM modulation", "AM"),
	SelectRange			= _('Select Range'),
	Ranges				= _('Ranges (in MHz)'),
	Guard				= _('Guard frequency'),
	Encryption			= _('Encryption'),
	Key					= _('Key'),
	Squelch				= _("SQUELCH", "Squelch"),
	Power				= _("XMIT POWER","Power"),
	mW					= _('mW'),
	W					= _("Watt", "W"),
	kW					= _('kW'),
	MW					= _('MW'),
	RadioUnitOptions	= _('Radio Unit Options'),
	AddRadioUnit		= _('Add existing radio'),
	File				= _('Filename'),
	Name				= _('Radio name'),
	copyPreset			= _('Apply Preset'),
	AddNewRadioUnit		= _('Create new radio'),
	EnableAtStart		= _('Enable at start'),
	Step				= _('Step'),
	txtWarning			= _('Current set conflicts with existing ranges. Please change the range or modulation.'),
	Max					= _('Max'),
	Min					= _('Min'),
	rbCustom			= _('Custom'),
	rbUHF				= _("UHF freq", "UHF"),
	rbVHF				= _("VHF freq", "VHF"),
	rbHF 				= _("HF freq", "HF"),
	rbMF 				= _("MF freq", "MF"),
	rbLF				= _("LF freq", "LF"),
	sUHF				= '[300-999] '.._('MHz'),
	sVHF				= '[30-300] '.._('MHz'),
	sHF 				= '[3-30] '.._('MHz'),
	sMF 				= '[300-3000] '.._('kHz'),
	sLF					= '[50-300] '.._('kHz'),

	
	modulationName		= {
		[DB.MODULATION_AM] 			= _("AM"),
		[DB.MODULATION_FM]			= _("FM"),
		[DB.MODULATION_AM_AND_FM] 	= _('AM/FM') -- It should not be present in the list. Don't use it, as it is a cheat for FC3 planes.
	},
}

local curRadioUnit

local bRedChannel = false
local maxChannels = 30

function create()
	window = DialogLoader.spawnDialogFromFile('MissionEditor/modules/dialogs/me_dynamicRadio.dlg', cdata)

	bClose 			= window.bClose
	bCancel 		= window.bCancel
	bOk 			= window.bOk
	spLists			= window.spLists
	pAddRadio		= window.pAddRadio
	spAddBox		= pAddRadio.spAddBox
	pAddBox			= spAddBox.pAddBox
	pIntegrated		= spLists.pIntegrated
	pExtra			= spLists.pExtra
	pAdd			= pExtra.pAdd
	eFile			= pAdd.eFile
	eNamePreset 	= pAdd.eNamePreset
	clPresetAdd		= pAdd.clPresetAdd
	bAddRadioUnit	= pAdd.bAddRadioUnit
	bAddNewRadioUnit= pAdd.bAddNewRadioUnit
	pNoVisible 		= window.pNoVisible
	pOptions		= pAddBox.pOptions
	clInner			= pOptions.clInner
	clFreqAccuracy	= pOptions.clFreqAccuracy
	clBandWidth		= pOptions.clBandWidth
	clLA			= spLists.clLA
	lbIntegrated	= pIntegrated.lbIntegrated
	gridExtra		= pExtra.gridExtra
	sbInnerNoise	= pOptions.sbInnerNoise
	sbFreqAccuracy	= pOptions.sbFreqAccuracy
	sbBandWidth		= pOptions.sbBandWidth
	sbInputSD		= pOptions.sbInputSD
	sbOutputSD		= pOptions.sbOutputSD
	sbInputSLZ		= pOptions.sbInputSLZ
	sbRegTime		= pOptions.sbRegTime
	sbMinSearchTime = pOptions.sbMinSearchTime
	sbMaxSearchTime = pOptions.sbMaxSearchTime
	bAddCancel		= pAddRadio.bAddCancel
	bAddSave		= pAddRadio.bAddSave
	clPresetCopy	= pAddRadio.clPresetCopy
	bCopyPreset		= pAddRadio.bCopyPreset
		
	-- средняя панель
	bAddRanges		= pAddBox.pRanges.bAddRanges
	pRangesV		= pAddBox.pRangesV
	pStep			= pAddBox.pStep
	clStep			= pStep.clStep

	pChannels		= pAddBox.pChannels
	bAddChannels	= pChannels.bAddChannels
	pChannelsV		= pAddBox.pChannelsV
	pGuards			= pAddBox.pGuards
	pGuardsV		= pAddBox.pGuardsV
	bAddGuards		= pGuards.bAddGuards
	pEncryption		= pAddBox.pEncryption
	pSquelch		= pAddBox.pSquelch
	cbEncEnable		= pEncryption.cbEncEnable
	cbEncPresent	= pEncryption.cbEncPresent
	sEncryption		= pEncryption.sEncryption
	sbEncryption	= pEncryption.sbEncryption
	cbSquelch		= pSquelch.cbSquelch
	pPower			= pAddBox.pPower
	pPowerV			= pAddBox.pPowerV
	bAddPower		= pPower.bAddPower	
	sAddRadioUnit	= pAddRadio.sAddRadioUnit
	
	spMisc			= window.spMisc	
	
	
	--панель задания Ranges-----------
	pSelectRange	= spMisc.pSelectRange
	bAddRangesSave	= pSelectRange.bAddRangesSave
	bAddRangesCancel= pSelectRange.bAddRangesCancel
	sbMin			= pSelectRange.sbMin
	sbMax			= pSelectRange.sbMax
	cbAM			= pSelectRange.pModulation.cbAM
	cbFM			= pSelectRange.pModulation.cbFM
	rbCustom		= pSelectRange.pPreset.rbCustom
	rbUHF			= pSelectRange.pPreset.rbUHF 
	rbVHF			= pSelectRange.pPreset.rbVHF
	rbHF			= pSelectRange.pPreset.rbHF
	rbMF			= pSelectRange.pPreset.rbMF
	rbLF			= pSelectRange.pPreset.rbLF
	sWarning		= pSelectRange.sWarning
	
	rbUHF.data = {minFreq = 300000000, maxFreq = 999000000, multValue = 1000000}
	rbVHF.data = {minFreq = 30000000, maxFreq = 300000000, multValue = 1000000}
	rbHF.data  = {minFreq = 3000000, maxFreq = 30000000, multValue = 1000000}
	rbMF.data  = {minFreq = 300000, maxFreq = 3000000, multValue = 1000000}
	rbLF.data  = {minFreq = 50000, maxFreq = 300000, multValue = 1000000}
	
	rbUHF.onChange = onChange_rbPreset
	rbVHF.onChange = onChange_rbPreset
	rbHF.onChange = onChange_rbPreset
	rbMF.onChange = onChange_rbPreset
	rbLF.onChange = onChange_rbPreset
	bAddRangesSave.onChange = onChange_bAddRangesSave
	bAddRangesCancel.onChange = onChange_bAddRangesCancel
	cbEncEnable.onChange = onChange_cbEncEnable
	cbEncPresent.onChange = onChange_cbEncPresent
	sbEncryption.onChange = onChange_sbEncryption
	cbSquelch.onChange = onChange_cbSquelch
	sbInnerNoise.onChange = onChange_sbInnerNoise
	clInner.onChange = onChange_clInner
	clFreqAccuracy.onChange = onChange_clFreqAccuracy
	sbFreqAccuracy.onChange = onChange_sbFreqAccuracy
	sbBandWidth.onChange = onChange_sbBandWidth
	clBandWidth.onChange = onChange_clBandWidth
	sbInputSD.onChange = onChange_sbInputSD
	sbOutputSD.onChange = onChange_sbOutputSD
	sbInputSLZ.onChange = onChange_sbInputSLZ
	sbRegTime.onChange = onChange_sbRegTime
	sbMinSearchTime.onChange = onChange_sbMinSearchTime
	sbMaxSearchTime.onChange = onChange_sbMaxSearchTime
	bCopyPreset.onChange = onChange_bCopyPreset
	gridExtra.onMouseDown = onMouseDown_gridExtra
	sbMin.onChange = onChange_sbMin
	sbMax.onChange = onChange_sbMax
	cbAM.onChange = onChange_cbAM
	cbFM.onChange = onChange_cbFM
	clStep.onChange = onChange_clStep
	
	sbMin:setFormatString("%0.3f")
	sbMax:setFormatString("%0.3f")
	-------------------------------------
	
	gridStaticSkin 	= pNoVisible.gridStatic:getSkin()
	staticSkin 		= pNoVisible.static:getSkin()
	staticYelloySkin= pNoVisible.staticYelloy:getSkin()
	staticWhiteSkin	= pNoVisible.staticWhite:getSkin()
	gridButtonSkin 	= pNoVisible.gridButton:getSkin()
	addRemoveSkin 	= pNoVisible.addRemove:getSkin()		
	checkBoxSkin 	= pNoVisible.checkBox:getSkin()
	spinBoxSkin		= pNoVisible.spinBox:getSkin()
	spinBoxRedSkin	= pNoVisible.spinBoxRed:getSkin()
	comboListSkin	= pNoVisible.comboList:getSkin()
	
	local w, h = Gui.GetWindowSize()
	window:setBounds((w-1280)/2, (h-768)/2, 1280, 768)
	
	bAddRadioUnit.onChange = onChange_bAddRadioUnit
	bAddNewRadioUnit.onChange = onChange_bAddNewRadioUnit
	bCancel.onChange = onChange_bCancel
	bClose.onChange = onChange_bCancel
	bOk.onChange = onChange_bOk
	clLA.onChange = onChange_clLA
	lbIntegrated.onChange = onChange_lbIntegrated
	bAddCancel.onChange = onChange_bAddCancel
	bAddSave.onChange = onChange_bAddSave
	bAddRanges.onChange = onChange_bAddRanges
	bAddChannels.onChange = onChange_bAddChannels
	bAddGuards.onChange = onChange_bAddGuards
	bAddPower.onChange = onChange_bAddPower
	
	sbRegTime:setStep(0.05)
	sbMinSearchTime:setStep(0.05)
	sbMaxSearchTime:setStep(0.05)
	
	fillLA()
	fillUnitsValuesList(clInner, "V")
	fillListFreq(clFreqAccuracy)
	fillListFreq(clBandWidth)
	fillListStep(clStep)
	
	eNamePreset:setText("newNamePreset")
	eFile:setText("newFilePreset")
	
	window:addHotKeyCallback('escape', onChange_bCancel)
end	

-- Открытие/закрытие панели
function show(b) 
	if window == nil then
		create()
	end	
	
    if b then		
        update()
    end
    
    window:setVisible(b)
end

function onChange_bAddNewRadioUnit()
	lbIntegrated:selectItem()
	gridExtra:selectRow(-1)
	
	local itemLA = clLA:getSelectedItem()
	local id = eFile:getText()
	if RadioMod.isValidId(id) then	
		if RadioMod.isValidAdd(itemLA.type, id) then
			RadioMod.addNewPresetToUnit(itemLA.type, id, eNamePreset:getText())
			curRadioUnit = RadioMod.getPreset(id)
		else
			MsgWindow.warning(_("This radio has already been added "), _("warning"), _("OK")):show()	
		end
	else
		MsgWindow.warning(_("Current filename already in use"), _("warning"), _("OK")):show()	
	end	
	
	update_lbRadios()
--	openAddRadio()	
--	setEnabledAddRadio(true)
end

function onChange_bAddRadioUnit()
	local item = clPresetAdd:getSelectedItem()
	local itemLA = clLA:getSelectedItem()
	
	if itemLA and item and item.ID then
		if RadioMod.isValidAdd(itemLA.type, item.ID) then	
			RadioMod.addPresetToUnit(itemLA.type, item.ID)
			curRadioUnit = RadioMod.getPreset(item.ID)
			
			update_lbRadios()	
			--openAddRadio()	
			--setEnabledAddRadio(true)
		else
			MsgWindow.warning(_("This radio has already been added "), _("warning"), _("OK")):show()	
		end
	end
end

function openAddRadio()	
	oldRadioUnit = {}
	TableUtils.copyTable(oldRadioUnit, curRadioUnit)
	updateAddRadioUnit()
	updateModifiedRadio()
end

function onChange_bCancel()

	window:setVisible(false)
end

function onChange_bOk()

	window:setVisible(false)
end

function onChange_clLA()
	local item = clLA:getSelectedItem()
	if item then
		curLA = item.type 
		update_lbRadios()	
	end
end

function onChange_lbIntegrated()
	gridExtra:selectRow(-1)
	local item = lbIntegrated:getSelectedItem()
	
	if item then
		
		curRadioUnit =  {}
		curRadioUnit = RadioMod.getPreset(item.ID)
		openAddRadio()	
		setEnabledAddRadio(false)
		pAddBox:setVisible(true)
		sAddRadioUnit:setVisible(true)
		clPresetCopy:setVisible(true)
		bCopyPreset:setVisible(true)
		bAddCancel:setVisible(true)
		bAddSave:setVisible(true)
		spAddBox:setVisible(true)
	end
end

function onMouseDown_gridExtra(self, x, y, button)
	local col, row = self:getMouseCursorColumnRow(x, y)

	if -1 < row then
		self:selectRow(row)  
		lbIntegrated:selectItem()
		local ID = self:getCell(0, row).ID
		curRadioUnit =  {}
		curRadioUnit = RadioMod.getPreset(ID)
		--base.U.traverseTable(curRadioUnit)
		--base.print("---onMouseDown_gridExtra--", #curRadioUnit.Channels)
		setEnabledAddRadio(true)
		openAddRadio()			
		pAddBox:setVisible(true)
		sAddRadioUnit:setVisible(true)
		clPresetCopy:setVisible(true)
		bCopyPreset:setVisible(true)
		bAddCancel:setVisible(true)
		bAddSave:setVisible(true)
		spAddBox:setVisible(true)
	end
end

function onChange_bAddCancel()
	lbIntegrated:selectItem()
	gridExtra:selectRow(-1)
	spLists:setEnabled(true)
	setEnabledAddRadio(false)
	pAddBox:setVisible(false)
	sAddRadioUnit:setVisible(false)
	clPresetCopy:setVisible(false)
	bCopyPreset:setVisible(false)
	bAddCancel:setVisible(false)
	bAddSave:setVisible(false)
	spAddBox:setVisible(false)
	
	curRadioUnit = {}
	TableUtils.copyTable(curRadioUnit, oldRadioUnit)
end

--эта кнопка сохраняет текущие настройки в текущий пресет
function onChange_bAddSave()	
	lbIntegrated:selectItem()
	gridExtra:selectRow(-1)
	spLists:setEnabled(true)
	setEnabledAddRadio(false)
	
	RadioMod.savePresetToFile(curRadioUnit.file, curRadioUnit)
	
	pAddBox:setVisible(false)
	sAddRadioUnit:setVisible(false)
	clPresetCopy:setVisible(false)
	bCopyPreset:setVisible(false)
	bAddCancel:setVisible(false)
	bAddSave:setVisible(false)
	spAddBox:setVisible(false)
end

function onChange_bAddRanges()
	pSelectRange:setVisible(true)
	pSelectRange:setPosition(0,0)
	pSelectRange.editRange = nil

	verifyNewRange()
	updateModifiedRadio()
	
	spLists:setEnabled(false)
	setEnabledAddRadio(false)
end

function onChange_bAddChannels()
	if #curRadioUnit.Channels < 30 then
		base.table.insert(curRadioUnit.Channels, {freq = getDefaultFreq(),  modulation = 0, number = getFreeChannel()})

		UpdateManager.add(function()
				updateAddRadioUnit()
				updateModifiedRadio()	
				return true
			end)
	end	
end

function onChange_bAddGuards()
	base.table.insert(curRadioUnit.Guards, {freq = 333000,  modulation = 0})

	UpdateManager.add(function()
			updateAddRadioUnit()	
			updateModifiedRadio()
			return true
		end)
end

function onChange_bAddPower()
	base.table.insert(curRadioUnit.Power, {value = 10})

	UpdateManager.add(function()
			updateAddRadioUnit()
			updateModifiedRadio()	
			return true
		end)
end

function update()
	update_lbRadios()
	spLists:setEnabled(true)
	setEnabledAddRadio(false)
end

local function getMultValueUnitSize(a_multValue, a_freq)
	local multValue =  a_multValue
	local unitSize
	if multValue == nil then
		if a_freq > 1000000 then
			multValue = 1000000
		elseif a_freq > 1000 then
			multValue = 1000
		else
			multValue = 1
		end
	end	
	
	if multValue == 1000 then
		unitSize = cdata.kHz
	elseif multValue == 1000000 then 
		unitSize = cdata.MHz
	else
		unitSize = cdata.Hz
	end
	
	return multValue, unitSize
end

function compareTbl(tbl1, tbl2)
	if tbl1.minFreq == tbl2.minFreq then
		return tbl1.modulation < tbl2.modulation
	end
	return tbl1.minFreq < tbl2.minFreq
end

function compareTblChannels(tbl1, tbl2)
	return tbl1.number < tbl2.number
end

function updateAddRadioUnit()
	local offsetY= 20
	bRedChannel = false
	
	curRadioUnit.Step = curRadioUnit.Step or 1000

	pRangesV:clear()
	local row = 0
	local maxF = 1
	local textWidgets = {}
	local wMax1 = 0 
	local wMax2 = 0 
	local wMax3 = 0
	
	--base.U.traverseTable(curRadioUnit)
	--base.print("--updateAddRadioUnit--")
	
	base.table.sort(curRadioUnit.Ranges, compareTbl)
	
	for k,v in base.ipairs(curRadioUnit.Ranges) do
		--local multValue, unitSize = getMultValueUnitSize(v.multValue,v.minFreq)

		local minFreq = (v.minFreq/1000000)
		local maxFreq = (v.maxFreq/1000000)
		if v.maxFreq > maxF then
			maxF = v.maxFreq
		end

		local text1 = Static.new()
		local text2 = Static.new()
		local text3 = Static.new()
		
		textWidgets[k] = {}
		textWidgets[k][1] = text1
		textWidgets[k][2] = text2
		textWidgets[k][3] = text3
		
		text1.num = k
		text2.num = k
		text3.num = k
		
		text1:addMouseDownCallback(editRange)
		text2:addMouseDownCallback(editRange)
		text3:addMouseDownCallback(editRange)

		if base.math.fmod(v.maxFreq-v.minFreq, curRadioUnit.Step) == 0 then
			--local str = base.string.format('%8.3f - %8.3f, %s', minFreq, maxFreq, cdata.modulationName[v.modulation])
			text1:setText(base.string.format('%.3f - ',minFreq))
			text2:setText(base.string.format('%.3f',maxFreq))
			text3:setText(base.string.format(' %s',cdata.modulationName[v.modulation]))
			text1:setSkin(staticWhiteSkin)
			text2:setSkin(staticWhiteSkin)
			text3:setSkin(staticWhiteSkin)
		else
			
			local freqTmp = (base.math.floor((v.maxFreq-v.minFreq)/curRadioUnit.Step)*curRadioUnit.Step+ v.minFreq)/1000000

		--	local str = base.string.format('%8.3f - %8.3f (%8.3f), %s ', minFreq, maxFreq, freqTmp, cdata.modulationName[v.modulation])
			text1:setText(base.string.format('%.3f - ',minFreq))
			text2:setText(base.string.format('%.3f',maxFreq))
			text3:setText(base.string.format(' (%.3f) %s',freqTmp, cdata.modulationName[v.modulation]))
			text1:setSkin(staticYelloySkin)
			text2:setSkin(staticYelloySkin)
			text3:setSkin(staticYelloySkin)
		end
		
		local tmpW = text1:calcSize()
		if tmpW > wMax1 then
			wMax1 = tmpW
		end
		
		tmpW = text2:calcSize()
		if tmpW > wMax2 then
			wMax2 = tmpW
		end
		
		tmpW = text3:calcSize()
		if tmpW > wMax3 then
			wMax3 = tmpW
		end
		
		pRangesV:insertWidget(text1)
		pRangesV:insertWidget(text2)
		pRangesV:insertWidget(text3)
		
		local bRemove = Button.new()
		bRemove:setText(_("Remove"))
		bRemove:setBounds(281, row*20, 80, 20)
		bRemove:setSkin(addRemoveSkin)
		pRangesV:insertWidget(bRemove)
		bRemove.row = row + 1
		bRemove.onChange = onChange_bRemoveRanges
		
		row = row + 1
	end
	
	for row,text in base.pairs(textWidgets) do
		text[1]:setBounds(10, (row-1)*20, wMax1, 20)
		text[2]:setBounds(10+wMax1, (row-1)*20, wMax2, 20)
		text[3]:setBounds(10+wMax1+wMax2, (row-1)*20, wMax3, 20)
	end

	sbFreqAccuracy.maxF = maxF -- допустимые значения зависят от максимальной частоты
	sbBandWidth.maxF = maxF -- допустимые значения зависят от максимальной частоты
	
	pRangesV:setBounds(15, offsetY, 375, row*20)
	offsetY = offsetY + row*20
	
	pStep:setPosition(10, offsetY)
	setListStep(clStep, curRadioUnit.Step)
	offsetY = offsetY + 50
	
	pChannels:setPosition(10, offsetY)
	offsetY = offsetY + 25
	
	pChannelsV:clear()
	local row = 0

	base.table.sort(curRadioUnit.Channels, compareTblChannels)
	tblSbChannels = {}
	for k,v in base.ipairs(curRadioUnit.Channels) do
	--	local multValue, unitSize = getMultValueUnitSize(v.multValue,v.freq)
	
		local clNum = ComboList.new(k)
		clNum:setBounds(30, row*20, 40, 20)
		clNum:setSkin(comboListSkin)
		fillListChannels(clNum)
		setListChannels(clNum, v.number)
		clNum.key = k
		clNum.onChange = onChange_clNum
		pChannelsV:insertWidget(clNum)
		
		local sbChannel = SpinBox.new()
		sbChannel:setRange(0.05, 999)
		sbChannel:setAcceptDecimalPoint(true)
		sbChannel:setStep(0.001)	
		sbChannel:setFormatString("%0.3f")	
		sbChannel:setValue(v.freq/1000000)
		sbChannel:setSkin(spinBoxSkin)
		sbChannel:setBounds(80, row*20, 90, 20)
		sbChannel.row = row + 1	
		pChannelsV:insertWidget(sbChannel)
		tblSbChannels[row+1] = sbChannel
					
		local sChannelUnitsize = Static.new(cdata.MHz)
		sChannelUnitsize:setSkin(staticSkin)
		sChannelUnitsize:setBounds(180, row*20, 40, 20)
		pChannelsV:insertWidget(sChannelUnitsize)		
		
		local sbChannelMod = ComboList.new()
		fillListMod(sbChannelMod)
		sbChannelMod:setSkin(comboListSkin)
		sbChannelMod:setBounds(210, row*20, 40, 20)
		sbChannelMod.row = row + 1	
		pChannelsV:insertWidget(sbChannelMod)
		setListMod(sbChannelMod, v.modulation)
		
		sbChannel.onChange = function(self)
			changeValue("Channels", self.row, "freq", base.math.floor(self:getValue() * 1000000))	
			VerifyChannelsGuards()			
		end
		
		sbChannelMod.onChange = function(self)
			changeValue("Channels", self.row, "modulation", self:getSelectedItem().modulation)
			VerifyChannelsGuards()	
		end
		
		local bRemove = Button.new()
		bRemove:setText(_("Remove"))
		bRemove:setBounds(281, row*20, 80, 20)
		bRemove:setSkin(addRemoveSkin)
		pChannelsV:insertWidget(bRemove)
		bRemove.row = row + 1
		bRemove.onChange = onChange_bRemoveChannels
		
		row = row +1
	end	
	pChannelsV:setBounds(10, offsetY, 380, row*20)
	offsetY = offsetY + row*20
	
	pGuards:setPosition(10, offsetY)
	offsetY = offsetY + 25
	
	pGuardsV:clear()
	local row = 0
	tblSbGuards = {}
	for k,v in base.ipairs(curRadioUnit.Guards) do
	--	local multValue, unitSize = getMultValueUnitSize(v.multValue,v.freq)
	
		local sbGuard = SpinBox.new()
		sbGuard:setRange(0.05, 999)
		sbGuard:setAcceptDecimalPoint(true)
		sbGuard:setStep(0.001)	
		sbGuard:setFormatString("%0.3f")	
		sbGuard:setValue(v.freq/1000000)
		sbGuard:setSkin(spinBoxSkin)
		sbGuard:setBounds(80, row*20, 90, 20)
		sbGuard.row = row + 1
		pGuardsV:insertWidget(sbGuard)
		tblSbGuards[row+1] = sbGuard
				
		local sGuardUnitsize = Static.new(cdata.MHz)
		sGuardUnitsize:setSkin(staticSkin)
		sGuardUnitsize:setBounds(180, row*20, 40, 20)
		pGuardsV:insertWidget(sGuardUnitsize)
		
		local sbGuardMod = ComboList.new()
		fillListMod(sbGuardMod)
		sbGuardMod:setSkin(comboListSkin)
		sbGuardMod:setBounds(210, row*20, 40, 20)
		sbGuardMod.row = row + 1
		pGuardsV:insertWidget(sbGuardMod)
		setListMod(sbGuardMod, v.modulation)
		

		sbGuard.onChange = function(self)
			changeValue("Guards", self.row, "freq", base.math.floor(self:getValue() * 1000000))
			VerifyChannelsGuards()
		end
		
		sbGuardMod.onChange = function(self)
			changeValue("Guards", self.row, "modulation", self:getSelectedItem().modulation)
			VerifyChannelsGuards()
		end
		
		local bRemove = Button.new()
		bRemove:setText(_("Remove"))
		bRemove:setBounds(281, row*20, 80, 20)
		bRemove:setSkin(addRemoveSkin)
		pGuardsV:insertWidget(bRemove)
		bRemove.row = row + 1
		bRemove.onChange = onChange_bRemoveGuards
		
		row = row +1
	end		
	pGuardsV:setBounds(10, offsetY, 375, row*20)
	offsetY = offsetY + row*20
	
	
	pEncryption:setPosition(10, offsetY)
	sbEncryption:setValue(curRadioUnit.Encryption.key)
	cbEncEnable:setState(curRadioUnit.Encryption.enable)
	cbEncPresent:setState(curRadioUnit.Encryption.present)
	if cbEncPresent:getState() == false then
		sbEncryption:setVisible(false)
		cbEncEnable:setVisible(false)
		offsetY = offsetY + 25
		pEncryption:setSize(381, 25)
	else
		sbEncryption:setVisible(true)
		cbEncEnable:setVisible(true)
		offsetY = offsetY + 50
		pEncryption:setSize(381, 50)
	end
	
	
	pSquelch:setPosition(10, offsetY)
	cbSquelch:setState(curRadioUnit.Squelch)
	offsetY = offsetY + 25
	
	pPower:setPosition(10, offsetY)
	offsetY = offsetY + 25
	
	pPowerV:clear()
	local row = 0
	for k,v in base.ipairs(curRadioUnit.Power) do
		local multValue, unitSize = getMultValueUnitSize(v.multValue,v.value)
	
		local sbPower = SpinBox.new()
		sbPower:setRange(0, 10000000)
		sbPower:setValue(v.value/multValue)
		sbPower:setSkin(spinBoxSkin)
		sbPower:setBounds(80, row*20, 90, 20)
		sbPower.row = row + 1
		pPowerV:insertWidget(sbPower)
		
		local sbPowerUnitsize = ComboList.new()
		fillListPower(sbPowerUnitsize)
		sbPowerUnitsize:setSkin(comboListSkin)
		sbPowerUnitsize:setBounds(180, row*20, 40, 20)
		sbPowerUnitsize.row = row + 1
		pPowerV:insertWidget(sbPowerUnitsize)
		setListPower(sbPowerUnitsize, multValue)
		
		sbPower.multValueW = sbPowerUnitsize
		sbPower.onChange = function(self)
			changeValue("Power", self.row, "value", self:getValue() * self.multValueW:getSelectedItem().multValue)
		end
		
		sbPowerUnitsize.powerW = sbPower
		sbPowerUnitsize.onChange = function(self)
			changeValue("Power", self.row, "value", self.powerW:getValue() * self:getSelectedItem().multValue)
		end
		
		local bRemove = Button.new()
		bRemove:setText(_("Remove"))
		bRemove:setBounds(281, row*20, 80, 20)
		bRemove:setSkin(addRemoveSkin)
		pPowerV:insertWidget(bRemove)
		bRemove.row = row + 1
		bRemove.onChange = onChange_bRemovePower
		
		row = row +1
	end	
	
	pPowerV:setBounds(10, offsetY, 380, row*20)
	offsetY = offsetY + row*20
	
	pOptions:setPosition(10, offsetY)
	
	--curRadioUnit
	setVList(clInner,curRadioUnit.InnerNoise)
	sbInnerNoise:setValue(curRadioUnit.InnerNoise/clInner:getSelectedItem().multValue)
	
	if curRadioUnit.FrequencyAccuracy > sbFreqAccuracy.maxF then
		curRadioUnit.FrequencyAccuracy = sbFreqAccuracy.maxF
	end
	local multValue, unitSize = getMultValueUnitSize(nil, curRadioUnit.FrequencyAccuracy)
	setListFreq(clFreqAccuracy, multValue)
	sbFreqAccuracy:setRange(1, sbFreqAccuracy.maxF/clFreqAccuracy:getSelectedItem().multValue)
	sbFreqAccuracy:setValue(curRadioUnit.FrequencyAccuracy/clFreqAccuracy:getSelectedItem().multValue)
	
	if curRadioUnit.BandWidth > sbBandWidth.maxF then
		curRadioUnit.BandWidth = sbBandWidth.maxF
	end
	local multValue, unitSize = getMultValueUnitSize(nil, curRadioUnit.BandWidth)
	setListFreq(clBandWidth, multValue)
	sbBandWidth:setRange(1, sbBandWidth.maxF/clBandWidth:getSelectedItem().multValue)
	sbBandWidth:setValue(curRadioUnit.BandWidth/clBandWidth:getSelectedItem().multValue)
	
	sbInputSD:setValue(curRadioUnit.InputSD) 
	sbOutputSD:setValue(curRadioUnit.OutputSD) 
	sbInputSLZ:setValue(curRadioUnit.InputSLZ) 
	sbRegTime:setValue(curRadioUnit.RegulationTime) 
	sbMinSearchTime:setValue(curRadioUnit.MinSearchTime) 
	sbMaxSearchTime:setValue(curRadioUnit.MaxSearchTime) 
	
	pAddBox:setSize(395, offsetY+ 340)
	spAddBox:updateWidgetsBounds()
	VerifyChannelsGuards()
end


function updateModifiedRadio()
	if U.compareTables(oldRadioUnit, curRadioUnit) == false then
		spLists:setEnabled(false)
		bAddCancel:setEnabled(true)	
		bAddSave:setEnabled(true)	
	else
		spLists:setEnabled(true)	
		bAddCancel:setEnabled(false)	
		bAddSave:setEnabled(false)
	end	
	
	if bRedChannel == true then
		bAddSave:setEnabled(false)
	end
end


function fillLA()
	clLA:clear()
	
	local humanControlledAircrafts = DB.getHumanControlledAircrafts()
	local aircrafts = {}
	
	for k,v in base.pairs(humanControlledAircrafts) do
		base.table.insert(aircrafts, { type = v.type, DisplayName = v.DisplayName })
	end
	
	local function compTable(tab1, tab2)
		return textutil.Utf8Compare((tab1.DisplayName or tab1.type), (tab2.DisplayName or tab2.type))
	end
	base.table.sort(aircrafts, compTable)
	
	for i, v in base.ipairs(aircrafts) do
        local item = ListBoxItem.new(v.DisplayName)
		item.type = v.type
        clLA:insertItem(item)
    end
	clLA:selectItem(clLA:getItem(0))
	curLA = clLA:getItem(0).type 	
end

function editRange(self, x, y, button)
	pSelectRange:setVisible(true)
	pSelectRange:setPosition(0,0)
	pSelectRange.editRange = self.num
	
	sbMin:setValue(curRadioUnit.Ranges[self.num].minFreq/1000000)
	sbMax:setValue(curRadioUnit.Ranges[self.num].maxFreq/1000000)
	
	if curRadioUnit.Ranges[self.num].modulation == 0 then
		cbAM:setState(true)
		cbFM:setState(false)
	else
		cbAM:setState(false)
		cbFM:setState(true)
	end
	
	verifyNewRange()
	updateModifiedRadio()
	
	spLists:setEnabled(false)
	setEnabledAddRadio(false)
end

function fillUnitsValuesList(a_clList, a_type)
	a_clList:clear()
	if a_type == 'W' then
		local item = ListBoxItem.new(_("mW"))
		item.multValue = 0.001
		a_clList:insertItem(item)
		
		local item = ListBoxItem.new(_("W"))
		item.multValue = 1
		a_clList:insertItem(item)
	elseif a_type == 'V' then
	--	local item = ListBoxItem.new(_("pV"))  --пиковольт
	--	item.multValue = 0.000000000001
	--	a_clList:insertItem(item)

		local item = ListBoxItem.new(_("nV"))  --нановольт
		item.multValue = 0.000000001
		a_clList:insertItem(item)
		
		local item = ListBoxItem.new(_("µV"))  --микровольт
		item.multValue = 0.000001
		a_clList:insertItem(item)
		
		local item = ListBoxItem.new(_("mV"))  --милливольт
		item.multValue = 0.001
		a_clList:insertItem(item)
		
		local item = ListBoxItem.new(_("V"))
		item.multValue = 1
		a_clList:insertItem(item)
	end
	a_clList:selectItem(a_clList:getItem(0))

end

function setVList(a_list, a_value)
	local multValue = 0
	if a_value < 0.001 then
		multValue = 0.000000001
	elseif a_value < 1 then
		multValue = 0.000001
	else
		multValue = 0.001
	end
	
	local itemCount = a_list:getItemCount()

	for i = 0, itemCount - 1 do
		local item = a_list:getItem(i)
		if item.multValue == multValue then
			a_list:selectItem(item)
			return
		end
	end
end

function fillListChannels(a_list)
	for i = 0, maxChannels-1 do
		local item = ListBoxItem.new(i)
		item.value = i
		a_list:insertItem(item)
	end
end

function setListChannels(a_list, a_value)
	local itemCount = a_list:getItemCount()

	for i = 0, itemCount - 1 do
		local item = a_list:getItem(i)
		if item.value == a_value then
			a_list:selectItem(item)
			return
		end
	end
end

-- 0,1 кГц (или 100Hz) - опция долступна только если в радио все диапазоны находятся в рамках от 1 до 999кГц, при появлении диапазона с 1 МГц и выше, шаг меняется на 1 кГц
-- 1 5 10 20 25 50 100 200 250 500 1000 кГц -
function fillListStep(a_list)
	for k,v in base.ipairs({0.1, 1, 5, 10, 20, 25, 50, 100, 200, 250, 500, 1000}) do
		local item = ListBoxItem.new(v.." "..cdata.kHz)
		item.value = v*1000
		a_list:insertItem(item)
	end
	
	a_list:selectItem(a_list:getItem(1))
end

function setListStep(a_list, a_value)
	local itemCount = a_list:getItemCount()

	for i = 0, itemCount - 1 do
		local item = a_list:getItem(i)
		if item.value == a_value then
			a_list:selectItem(item)
			return
		end
	end
end

function fillListFreq(a_list)
	local item = ListBoxItem.new(cdata.Hz)
	item.multValue  = 1
	a_list:insertItem(item)
	
	local item = ListBoxItem.new(cdata.kHz)
	item.multValue = 1000
	a_list:insertItem(item)

	local item = ListBoxItem.new(cdata.MHz)
	item.multValue = 1000000
	a_list:insertItem(item)

	a_list:selectItem(a_list:getItem(0))
end

function setListFreq(a_list, a_value)
	local itemCount = a_list:getItemCount()

	for i = 0, itemCount - 1 do
		local item = a_list:getItem(i)
		if item.multValue == a_value then
			a_list:selectItem(item)
			return
		end
	end
end


function fillListPower(a_list)
	local item = ListBoxItem.new(cdata.mW)
	item.multValue  = 0.001
	a_list:insertItem(item)
	
	local item = ListBoxItem.new(cdata.W)
	item.multValue  = 1
	a_list:insertItem(item)
	
	local item = ListBoxItem.new(cdata.kW)
	item.multValue = 1000
	a_list:insertItem(item)

	local item = ListBoxItem.new(cdata.MW)
	item.multValue = 1000000
	a_list:insertItem(item)

	a_list:selectItem(a_list:getItem(0))
end

function setListPower(a_list, a_value)
	local itemCount = a_list:getItemCount()

	for i = 0, itemCount - 1 do
		local item = a_list:getItem(i)
		if item.multValue == a_value then
			a_list:selectItem(item)
			return
		end
	end
end

function fillListMod(a_list)
	local item = ListBoxItem.new(cdata.AM)
	item.modulation  = 0
	a_list:insertItem(item)
	
	local item = ListBoxItem.new(cdata.FM)
	item.modulation = 1
	a_list:insertItem(item)

	a_list:selectItem(a_list:getItem(0))
end

function setListMod(a_list, a_value)
	local itemCount = a_list:getItemCount()

	for i = 0, itemCount - 1 do
		local item = a_list:getItem(i)
		if item.modulation == a_value then
			a_list:selectItem(item)
			return
		end
	end
end
--[[
function fillModulationList()
	clModulation:clear()
	
	local item = ListBoxItem.new(cdata.modulationName[DB.MODULATION_AM])
	item.modulation = DB.MODULATION_AM
	clModulation:insertItem(item)
	
	local item = ListBoxItem.new(cdata.modulationName[DB.MODULATION_FM])
	item.modulation = DB.MODULATION_FM
	clModulation:insertItem(item)

	local item = ListBoxItem.new(cdata.modulationName[DB.MODULATION_AM_AND_FM])
	item.modulation = DB.MODULATION_AM_AND_FM
	clModulation:insertItem(item)

	clModulation:selectItem(clModulation:getItem(0))
end

]]

function onChange_bRemove()

end


--панель задания Ranges
function onChange_bAddRangesSave()
	local data = {}
	
	if cbAM:getState() == true then
		base.table.insert(data, {	minFreq = base.math.floor(sbMin:getValue()*1000000),
									maxFreq = base.math.floor(sbMax:getValue()*1000000),
									modulation = DB.MODULATION_AM
								})
	end	
	
	if cbFM:getState() == true then
		base.table.insert(data, {	minFreq = base.math.floor(sbMin:getValue()*1000000),
									maxFreq = base.math.floor(sbMax:getValue()*1000000),
									modulation = DB.MODULATION_FM,
								})
	end
	
	pSelectRange:setVisible(false)
	
	if pSelectRange.editRange == nil then
		AddNewRange(data)	
	else
		EditRange(data, pSelectRange.editRange)	
	end
	setEnabledAddRadio(true)
	updateModifiedRadio()
end

function onChange_bAddRangesCancel()
	pSelectRange:setVisible(false)
	--spLists:setEnabled(true)
	setEnabledAddRadio(true)
	updateModifiedRadio()
end

function onChange_bRemoveRanges(self)
	base.table.remove(curRadioUnit.Ranges, self.row)
	
	UpdateManager.add(function()
				updateAddRadioUnit()	
				VerifyChannelsGuards()	
				return true				
			end)
end

function getDefaultFreq()
--берем минимальную частоту из первого диапазона 
	if curRadioUnit.Ranges[1] then
		return curRadioUnit.Ranges[1].minFreq
	end
	
	return 300000
end

function getFreeChannel()
	local freeChannels = {}
	for i = 0, maxChannels-1 do
		freeChannels[i] = true
	end

	for k,v in base.ipairs(curRadioUnit.Channels) do
		freeChannels[v.number] = false
	end
	
	local nextAfterLastBusy = nil
	for i = 0, maxChannels-2 do
		if freeChannels[i] == false and freeChannels[i+1] == true then
			nextAfterLastBusy = i+1
		end
	end
	
	if nextAfterLastBusy then
		return nextAfterLastBusy
	else
		for i = 0, maxChannels-1 do
			if freeChannels[i] == true then
				return i
			end
		end
	end
end
	
function onChange_clNum(self)
	local value = self:getSelectedItem().value
	
	local oldNumber = curRadioUnit.Channels[self.key].number
	curRadioUnit.Channels[self.key].number = value

	for k,v in base.ipairs(curRadioUnit.Channels) do
		if k ~= self.key and value == v.number then
			curRadioUnit.Channels[k].number = oldNumber
		end
	end
	
	UpdateManager.add(function()
				updateAddRadioUnit()
				updateModifiedRadio()	
				return true
			end)
end

function onChange_bRemoveChannels(self)
	base.table.remove(curRadioUnit.Channels, self.row)
	
	UpdateManager.add(function()
				updateAddRadioUnit()
				updateModifiedRadio()	
				return true
			end)	
end

function onChange_bRemoveGuards(self)
	base.table.remove(curRadioUnit.Guards, self.row)
	
	UpdateManager.add(function()
				updateAddRadioUnit()
				updateModifiedRadio()		
				return true
			end)			
end

function onChange_bRemovePower(self)
	base.table.remove(curRadioUnit.Power, self.row)
	
	UpdateManager.add(function()
				updateAddRadioUnit()
				VerifyChannelsGuards()				
				return true
			end)
end



function onChange_cbEncEnable(self)
	curRadioUnit.Encryption.enable = self:getState()
	updateModifiedRadio()
end

function onChange_cbEncPresent(self)
	curRadioUnit.Encryption.present = self:getState()
	if cbEncPresent:getState() == false then
		sbEncryption:setVisible(false)
		cbEncEnable:setVisible(false)
	else
		sbEncryption:setVisible(true)
		cbEncEnable:setVisible(true)
	end	
	
	UpdateManager.add(function()
				updateAddRadioUnit()
				updateModifiedRadio()				
				return true
			end)
	
end

function onChange_sbEncryption(self)
	curRadioUnit.Encryption.key = self:getValue()
	updateModifiedRadio()
end

function onChange_cbSquelch(self)
	curRadioUnit.Squelch = self:getState()
	updateModifiedRadio()
end

function onChange_sbInnerNoise(self)
	curRadioUnit.InnerNoise = base.math.floor(self:getValue()) * clInner:getSelectedItem().multValue
	updateModifiedRadio()
end

function onChange_clInner(self)
	curRadioUnit.InnerNoise = base.math.floor(sbInnerNoise:getValue()) * self:getSelectedItem().multValue
	updateModifiedRadio()
end

function onChange_clFreqAccuracy(self)
	curRadioUnit.FrequencyAccuracy = sbFreqAccuracy:getValue() * self:getSelectedItem().multValue
	sbFreqAccuracy:setRange(1, sbFreqAccuracy.maxF/self:getSelectedItem().multValue)
	updateModifiedRadio()
end

function onChange_sbFreqAccuracy(self)
	curRadioUnit.FrequencyAccuracy = self:getValue() * clFreqAccuracy:getSelectedItem().multValue
	updateModifiedRadio()
end

function onChange_sbBandWidth(self)
	curRadioUnit.BandWidth = self:getValue() * clBandWidth:getSelectedItem().multValue
	updateModifiedRadio()
end

function onChange_clBandWidth(self)
	curRadioUnit.BandWidth = sbBandWidth:getValue() * self:getSelectedItem().multValue
	sbBandWidth:setRange(1, sbBandWidth.maxF/self:getSelectedItem().multValue)
	updateModifiedRadio()
end

function onChange_sbInputSD(self)
	curRadioUnit.InputSD = sbInputSD:getValue()
	updateModifiedRadio()
end

function onChange_sbOutputSD(self)
	curRadioUnit.OutputSD = sbOutputSD:getValue()
	updateModifiedRadio()
end

function onChange_sbInputSLZ(self)
	curRadioUnit.InputSLZ = sbInputSLZ:getValue()
	updateModifiedRadio()
end

function onChange_sbRegTime(self)
	curRadioUnit.RegulationTime = sbRegTime:getValue()
	updateModifiedRadio()
end

function onChange_sbMinSearchTime(self)
	curRadioUnit.MinSearchTime = sbMinSearchTime:getValue()
	updateModifiedRadio()
end

function onChange_sbMaxSearchTime(self)
	curRadioUnit.MaxSearchTime = sbMaxSearchTime:getValue()
	updateModifiedRadio()
end

function onChange_bCopyPreset(self)
	local item = clPresetCopy:getSelectedItem()
	
	if item and item.ID then
		local srcPreset = RadioMod.getPreset(item.ID)
		
		local Name = curRadioUnit.Name
		local ID = curRadioUnit.ID
		local type = curRadioUnit.type
		local file = curRadioUnit.file

		curRadioUnit = {}
		TableUtils.copyTable(curRadioUnit, srcPreset)
		
		curRadioUnit.Name = Name
		curRadioUnit.ID = ID
		curRadioUnit.type = type
		curRadioUnit.file = file
		curRadioUnit.Modul = nil
		
		UpdateManager.add(function()
				updateAddRadioUnit()
				updateModifiedRadio()		
				return true
			end)
	end
end

function onChange_rbPreset(self)
	if self.data.minFreq and self.data.maxFreq then
		local x1, x2 = sbMin:getRange()

		sbMin:setValue(self.data.minFreq/1000000)
		sbMax:setValue(self.data.maxFreq/1000000)
		
		verifyNewRange()
		updateModifiedRadio()
	end
end

function onChange_removeRadio(self)
	local itemLA = clLA:getSelectedItem()
	RadioMod.removePresetFromUnit(itemLA.type, self.ID)
	update_lbRadios()
end

function onChange_sbMin(self)
--	local value = self:getValue()
--	value = base.math.floor(value*10000)/10000
--	self:setValue(value)
	rbCustom:setState(true)
	verifyNewRange()
end

function onChange_sbMax(self)
--	local value = self:getValue()
--	value = base.math.floor(value*10000)/10000
--	self:setValue(value)
	rbCustom:setState(true)
	verifyNewRange()
end

function onChange_clStep(self)
	local item = self:getSelectedItem()	
	curRadioUnit.Step = item.value
	
	UpdateManager.add(function()
		updateAddRadioUnit()	
		VerifyChannelsGuards()
		updateModifiedRadio()		
		return true				
	end)
end
	
function onChange_cbAM(self)
	if self:getState() == true and pSelectRange.editRange ~= nil then
		cbFM:setState(false)
	end
	verifyNewRange()
end

function onChange_cbFM(self)
	if self:getState() == true and pSelectRange.editRange ~= nil then
		cbAM:setState(false)
	end
	verifyNewRange()
end

local function verifyRange(minV, maxV, modulation, ignoreNumRange)
	if minV > maxV then
		return false
	end
		
	for k,v in base.pairs(curRadioUnit.Ranges) do
		if ignoreNumRange ~= k and  (modulation == 2 or modulation == v.modulation) then		
			if minV >= v.minFreq and minV <= v.maxFreq then
				return false
			end
			
			if maxV >= v.minFreq and maxV <= v.maxFreq then
				return false
			end
			
			if v.minFreq >= minV and v.minFreq <= maxV then
				return false
			end
			
			if v.maxFreq >= minV and v.maxFreq <= maxV then
				return false
			end
		end
	end
	return true
end

function verifyNewRange()
	local minV = base.math.floor(sbMin:getValue() * 1000000)
	local maxV = base.math.floor(sbMax:getValue() * 1000000)
	
	if cbAM:getState() == false and cbFM:getState() == false then
		bAddRangesSave:setEnabled(false)
		sWarning:setVisible(true)
	else	
		local modulation = 0
		if cbFM:getState() == true then
			if cbAM:getState() == false then 
				modulation = 1
			else
				modulation = 2
			end
		end
		local bEnabled = verifyRange(minV, maxV, modulation, pSelectRange.editRange)
		bAddRangesSave:setEnabled(bEnabled)
		sWarning:setVisible(not bEnabled)
	end
end

--находим в каком диапазоне канал соответствующей модуляции
--проверяем кратность относительно минимального значения канала
function VerifyChannelsGuards()
	local item = clStep:getSelectedItem()
	local step = item.value
	
	bRedChannel = false
	
	for k,sbChannel in base.pairs(tblSbChannels) do	
		--находим в каком диапазоне канал
		local minFreq
		local maxFreq
		local modulation = curRadioUnit.Channels[sbChannel.row].modulation
		local freq = curRadioUnit.Channels[sbChannel.row].freq
		
		for k,v in base.pairs(curRadioUnit.Ranges) do
			if modulation == v.modulation then
				if freq >= v.minFreq and freq <= v.maxFreq then
					minFreq = v.minFreq
					maxFreq = v.maxFreq
				end
			end
		end

		local result = true --красный
		if minFreq ~= nil then
			local freqHz = base.math.floor(sbChannel:getValue() * 1000000)

			freqHz  = freqHz - minFreq
																
			if base.math.fmod(freqHz, step) == 0 then
				result = false
			else
				result = true
			end	
		end

		if result == false then
			sbChannel:setSkin(spinBoxSkin)
			bRedChannel = bRedChannel or false
		else
			sbChannel:setSkin(spinBoxRedSkin)
			bRedChannel = true
		end	
	end
	
	for k,sbGuard in base.pairs(tblSbGuards) do	
		--находим в каком диапазоне канал
		local minFreq
		local maxFreq
		local modulation = curRadioUnit.Guards[sbGuard.row].modulation
		local freq = curRadioUnit.Guards[sbGuard.row].freq
		
		for k,v in base.pairs(curRadioUnit.Ranges) do
			if modulation == v.modulation then
				if freq >= v.minFreq and freq <= v.maxFreq then
					minFreq = v.minFreq
					maxFreq = v.maxFreq
				end
			end
		end

		local result = true --красный
		if minFreq ~= nil then
			local freqHz = base.math.floor(sbGuard:getValue() * 1000000)

			freqHz  = freqHz - minFreq
																
			if base.math.fmod(freqHz, step) == 0 then
				result = false
			else
				result = true
			end	
		end

		if result == false then
			sbGuard:setSkin(spinBoxSkin)
			bRedChannel = bRedChannel or false
		else
			sbGuard:setSkin(spinBoxRedSkin)
			bRedChannel = true
		end	
	end
	
	
	if #curRadioUnit.Power < 1 or #curRadioUnit.Ranges < 1 then
		bRedChannel = true
	end
	updateModifiedRadio()
end
	
----------

--добавляем новый Range в Radio Unit
function AddNewRange(data)
	-- добавляем созданные Range в curRadioUnit
	for k,v in base.ipairs(data) do
		base.table.insert(curRadioUnit.Ranges, v)
	end
	updateAddRadioUnit()
	updateModifiedRadio()
end

--изменяем существующийRange в Radio Unit
function EditRange(a_data, a_editRange)	
	curRadioUnit.Ranges[a_editRange] = a_data[1]

	updateAddRadioUnit()
	updateModifiedRadio()
end

function update_lbRadios()	
	lbIntegrated:clear()
	-- получаем список зашитых радио
	IntegratedRadio = {}
	ExtraRadio = {}	
	
	local presets = {}
	
	if curLA then
		presets = RadioMod.getUnitPresets(curLA)	
	end
	
	for k,v in base.ipairs(presets) do
		if v.type == "notRemovable" then
			base.table.insert(IntegratedRadio,{name = v.Name, DisplayName = v.Name, ID = v.ID, preset = v})
		else
			base.table.insert(ExtraRadio,{name = v.Name, DisplayName = v.Name, ID = v.ID, preset = v})
		end	
	end


	local function compTable(tab1, tab2)
		return textutil.Utf8Compare((tab1.DisplayName or tab1.name), (tab2.DisplayName or tab2.name))
	end
--	base.table.sort(IntegratedRadio, compTable)
	
	for i, v in base.ipairs(IntegratedRadio) do
        local item = ListBoxItem.new(v.DisplayName)
		item.name = v.name
		item.preset = v.preset
		item.ID = v.ID
        lbIntegrated:insertItem(item)
    end

	gridExtra:removeAllRows()
	-- получаем список зашитых радио
	
	local function compTable(tab1, tab2)
		return textutil.Utf8Compare((tab1.DisplayName or tab1.name), (tab2.DisplayName or tab2.name))
	end
--	base.table.sort(ExtraRadio, compTable)
	rowIndex = 0
	for i, v in base.ipairs(ExtraRadio) do		
		gridExtra:insertRow(20)
        local cell = Static.new()
        cell:setSkin(gridStaticSkin)
        cell:setText(v.DisplayName)
		cell.ID = v.ID
        gridExtra:setCell(0, rowIndex, cell)
		
		local cell = Button.new()
        cell:setSkin(gridButtonSkin)
        cell:setText(_("Remove"))
		cell.ID = v.ID
		cell.onChange = onChange_removeRadio
        gridExtra:setCell(1, rowIndex, cell)

		rowIndex = rowIndex + 1
    end
	
	local allPresets = RadioMod.getAllPresets()
	
	if allPresets then
		base.table.sort(allPresets, compTable)
		clPresetCopy:clear() 
		clPresetAdd:clear() 		

		for i, v in base.ipairs(allPresets) do
			local item = ListBoxItem.new(v.DisplayName)
			item.ID = v.ID
			clPresetCopy:insertItem(item)
			
			if v.preset.Modul ~= true then			
				local item = ListBoxItem.new(v.DisplayName)
				item.ID = v.ID
				clPresetAdd:insertItem(item)
			end
		end
	
	
	end
	pAddBox:setVisible(false)
	sAddRadioUnit:setVisible(false)
	clPresetCopy:setVisible(false)
	bCopyPreset:setVisible(false)
	bAddCancel:setVisible(false)
	bAddSave:setVisible(false)
	spAddBox:setVisible(false)
end



function changeValue(a_nameTbl, a_numTbl, a_nameValue, a_value)
	--base.print("---changeValue--",a_nameTbl, a_numTbl, a_nameValue, a_value)
	curRadioUnit[a_nameTbl][a_numTbl][a_nameValue] = a_value
	updateModifiedRadio()
end

function setEnabledAddRadio(b)
	if b == true and curRadioUnit and curRadioUnit.type ~= 'users' then
		b = false
	end
	pAddBox:setEnabled(b)
	clPresetCopy:setEnabled(b)
	bCopyPreset:setEnabled(b)
	bAddCancel:setEnabled(b)
	bAddSave:setEnabled(b)
end
