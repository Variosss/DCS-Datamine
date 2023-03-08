local base = _G

local enabled = false

module('GroupVariant')
mtab = { __index = _M }

local Factory = base.require('Factory')

local Panel = base.require('Panel')
local Static = base.require('Static')

local DialogLoader = base.require('DialogLoader')
local i18n = base.require('i18n')
i18n.setup(_M)


function new(parent)
	return Factory.create(_M, parent)
end

local function setMultiVariantMode(self, on)
	self.spVariantIndex:setEnabled(on)
	self.btRemoveVariant:setEnabled(on)
	self.eVariantCount:setEnabled(on)
	self.spVariantProbability:setEnabled(on)
end

local function updateVariantCount(self)
	self.eVariantCount:setText(#self.variantProbability)
	self.spVariantIndex:setRange(1, #self.variantProbability)
end

local function onVariantIndexSet(self, variantIndex)
	self.variantIndex = variantIndex
	self.spVariantProbability:setRange(0, self.variantProbability[self.variantIndex].value + self.variantProbabilityUnused)
	self.spVariantProbability:setValue(self.variantProbability[self.variantIndex].value)
end

local function setVariantIndex(self, variantIndex)
	self.spVariantIndex:setValue(variantIndex)
	onVariantIndexSet(self, variantIndex)
end

local function distributeProbability(self)
	local probabilityToDistribute = self.variantProbabilityUnused
	local variantCountToDistribute = 0
	for index, probability in base.pairs(self.variantProbability) do
		if not probability.changed then
			probabilityToDistribute = probabilityToDistribute + probability.value		
			variantCountToDistribute = variantCountToDistribute + 1
		end
	end
	
	if variantCountToDistribute > 0 then	
		local variantProbabilityPerVariant = base.math.floor(probabilityToDistribute / variantCountToDistribute)
		local probabilityIndex = 0
		for index, probability in base.pairs(self.variantProbability) do
			if not probability.changed then
				probabilityIndex = probabilityIndex + 1
				probability.value = variantProbabilityPerVariant
				if probabilityIndex == variantCountToDistribute then
					probability.value = probability.value + probabilityToDistribute - variantProbabilityPerVariant * variantCountToDistribute
				end	
			end
		end
		self.variantProbabilityUnused = 0
	end
end

--handlers

local function onVariantIndexChange(self, variantIndex)
	onVariantIndexSet(self, variantIndex)
end

local function onVariantAddChange(self)	
	base.table.insert(self.variantProbability, { changed = false, value = 0 } )
	distributeProbability(self)
	self.btAddVariant:setEnabled(#self.variantProbability < 99)
	if #self.variantProbability == 2 then
		setMultiVariantMode(self, true)
	end
	updateVariantCount(self)
	setVariantIndex(self, #self.variantProbability)
end

local function onVariantRemoveChange(self)
	base.assert(#self.variantProbability > 1)	
	self.variantProbabilityUnused = self.variantProbabilityUnused + self.variantProbability[self.variantIndex].value
	base.table.remove(self.variantProbability, self.variantIndex)
	distributeProbability(self)
	if #self.variantProbability == 1 then
		setMultiVariantMode(self, false)
	end
	updateVariantCount(self)
	setVariantIndex(self, base.math.min(self.variantIndex + 1, #self.variantProbability))
end

local function onVariantProbabilityChange(self, probability)
	self.variantProbabilityUnused = self.variantProbabilityUnused + self.variantProbability[self.variantIndex].value - probability
	self.variantProbability[self.variantIndex].changed = true
	self.variantProbability[self.variantIndex].value = probability
end

local cdata = 
{
	variant = _('VARIANT(N/A)'), 
	variant_of = _('OF'),
	add_variant = _('+'),
	remove_variant = _('-'),
	probability = _('%')
}

function construct(self, parent)
	if not enabled then
		return
	end
	local window = DialogLoader.spawnDialogFromFile('MissionEditor/modules/dialogs/me_group_variant.dlg', cdata)
	local panel = window.panel
	
	window:removeWidget(panel)
	window:kill()
	
	self.panel = panel
	parent:insertWidget(panel)
	--data
	self.variantIndex = 1
	self.variantProbabilityUnused = 100
	--widgets
	self.spVariantIndex = panel.spVariantIndex
	function self.spVariantIndex.onChange(spinBox)
		onVariantIndexChange(self, spinBox:getValue())
	end
	self.eVariantCount = panel.eVariantCount
	self.btAddVariant = panel.btAddVariant
	function self.btAddVariant.onChange(button)
		onVariantAddChange(self)
	end
	self.btRemoveVariant = panel.btRemoveVariant
	function self.btRemoveVariant.onChange(button)
		onVariantRemoveChange(self)
	end
	self.spVariantProbability = panel.spVariantProbability
	function self.spVariantProbability.onChange(spinBox)
		onVariantProbabilityChange(self, spinBox:getValue())
	end
end

function initialize(self, variantProbability, variantIndex)
	if not enabled then
		return
	end
	self.btAddVariant:setEnabled(variantProbability ~= nil)
	if variantProbability ~= nil then
		self.variantProbability = variantProbability
		self.variantProbabilityUnused = 100
		for index, probability in base.pairs(self.variantProbability) do
			self.variantProbabilityUnused = self.variantProbabilityUnused - probability.value
		end
		updateVariantCount(self)
		setMultiVariantMode(self, #self.variantProbability > 1)
		setVariantIndex(self, variantIndex)
	else
		self.spVariantIndex:setRange(0, 0)
		self.spVariantIndex:setValue(0)
		self.eVariantCount:setText(0)
		self.spVariantProbability:setValue(0)
		setMultiVariantMode(self, false)
	end
end

function setPosition(self, x, y)	
	self.panel:setPosition(x, y)
end