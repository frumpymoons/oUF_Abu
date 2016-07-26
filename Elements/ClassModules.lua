local _, ns = ...
ns.classModule = {}

local function updateTotemPosition()
	local _, class = UnitClass("player")
	TotemFrame:ClearAllPoints()
	if ( class == "PALADIN" or class == "DEATHKNIGHT" or class == "MONK" ) then --runes/holyower
		TotemFrame:SetPoint("TOPLEFT", oUF_AbuPlayer, "BOTTOMLEFT", 22, 0)
	elseif ( class == "DRUID" ) then
		local form  = GetShapeshiftFormID();
		if ( form == MOONKIN_FORM or not form ) and ( GetSpecialization() == 1 ) then
			TotemFrame:SetPoint("TOPLEFT", oUF_AbuPlayer, "BOTTOMLEFT", 37, -5)
		elseif ( form == BEAR_FORM or form == CAT_FORM ) then
			TotemFrame:SetPoint("TOPLEFT", oUF_AbuPlayer, "BOTTOMLEFT", 37, -5)
		else
			TotemFrame:SetPoint("TOPLEFT", oUF_AbuPlayer, "BOTTOMLEFT", 57, 0)
		end
	elseif ( class == "MAGE" ) then
		TotemFrame:SetPoint("TOPLEFT", oUF_AbuPlayer, "BOTTOMLEFT", 30, -5)
	elseif ( class == "WARLOCK" ) then
		TotemFrame:SetPoint("BOTTOMLEFT", oUF_AbuPlayer, "TOPLEFT", 40, -20) --not sure where to put this
	elseif ( class == "SHAMAN" ) and ( GetSpecialization() == 1 ) then
		TotemFrame:SetPoint('TOP', oUF_AbuPlayer, 'BOTTOM', 6, -7)
	else
		TotemFrame:SetPoint("TOPLEFT", oUF_AbuPlayer, "BOTTOMLEFT", 37, -5)
	end
end

function ns.classModule.Totems(self, config, uconfig)
	TotemFrame:ClearAllPoints()
	TotemFrame:SetParent(self)
	TotemFrame:SetScale(uconfig.scale * 0.81)

	for i = 1, MAX_TOTEMS do
		local _, totemBorder = _G['TotemFrameTotem'..i]:GetChildren()
		ns.PaintFrames(totemBorder:GetRegions())

		_G['TotemFrameTotem'..i]:SetFrameStrata('LOW')

		_G['TotemFrameTotem'..i.. 'Duration']:SetParent(totemBorder)
		_G['TotemFrameTotem'..i.. 'Duration']:SetDrawLayer('OVERLAY')
		_G['TotemFrameTotem'..i.. 'Duration']:ClearAllPoints()
		_G['TotemFrameTotem'..i.. 'Duration']:SetPoint('BOTTOM', _G['TotemFrameTotem'..i], 0, 3)
		_G['TotemFrameTotem'..i.. 'Duration']:SetFont(config.fontNormal, 10, 'OUTLINE')
		_G['TotemFrameTotem'..i.. 'Duration']:SetShadowOffset(0, 0)
	end

	_G.TotemFrame_AdjustPetFrame = function() end -- noop these else we'll get taint
	_G.PlayerFrame_AdjustAttachments = function() end

	hooksecurefunc("TotemFrame_Update", updateTotemPosition)
	updateTotemPosition()
end

function ns.classModule.alternatePowerBar(self, config, uconfig)
	self.DruidMana = ns.CreateOutsideBar(self, false, 0, 0, 1)
	self.DruidMana.colorPower = true

	self.DruidMana.Value = ns.CreateFontString(self.DruidMana, 13, 'CENTER')
	self.DruidMana.Value:SetPoint('CENTER', self.DruidMana, 0, 0.5)
	self.DruidMana.Value:Hide()
	self:Tag(self.DruidMana.Value, '[druidmana]')
end

function ns.classModule.DEATHKNIGHT(self, config, uconfig)
	if (config.DEATHKNIGHT.showRunes) then
		RuneFrame:SetParent(self)
		RuneFrame_OnLoad(RuneFrame)
		RuneFrame:ClearAllPoints()
		RuneFrame:SetPoint('TOP', self, 'BOTTOM', 32, -2)
		for i = 1, 6 do
			local b = _G['RuneButtonIndividual'..i].Border
			ns.PaintFrames(b:GetRegions())
		end
	end
end

function ns.classModule.MAGE(self, config, uconfig)
	if (config.MAGE.showArcaneStacks) then
		MageArcaneChargesFrame:SetParent(self)
		MageArcaneChargesFrame:ClearAllPoints()
		MageArcaneChargesFrame:SetPoint('TOP', self, 'BOTTOM', 30, -0.5)
		--ns.PaintFrames(select(2, MonkHarmonyBar:GetRegions()), 0.1)
		return MageArcaneChargesFrame
	end
end

function ns.classModule.MONK(self, config, uconfig)
	if (config.MONK.showStagger) then
		-- Stagger Bar for tank monk
		MonkStaggerBar:SetParent(self)
		MonkStaggerBar:SetScale(uconfig.scale * .81)
		MonkStaggerBar_OnLoad(MonkStaggerBar)
		MonkStaggerBar:ClearAllPoints()
		MonkStaggerBar:SetPoint('TOP', self, 'BOTTOM', 31, 0)
		ns.PaintFrames(MonkStaggerBar.MonkBorder, 0.3)
		MonkStaggerBar:SetFrameLevel(1)
	end

	if (config.MONK.showChi) then
		-- Monk combo points for Windwalker
		MonkHarmonyBarFrame:SetParent(self)
		MonkHarmonyBarFrame:SetScale(uconfig.scale * 0.81)
		MonkHarmonyBarFrame:ClearAllPoints()
		MonkHarmonyBarFrame:SetPoint('TOP', self, 'BOTTOM', 31, 18)
		ns.PaintFrames(select(2, MonkHarmonyBarFrame:GetRegions()), 0.1)
		return MonkHarmonyBarFrame
	end
end

function ns.classModule.PALADIN(self, config, uconfig)
	if (config.PALADIN.showHolyPower) then
		PaladinPowerBarFrame:SetParent(self)
		PaladinPowerBarFrame:SetScale(uconfig.scale * 0.78)
		PaladinPowerBarFrame:ClearAllPoints()
		PaladinPowerBarFrame:SetPoint('TOP', self, 'BOTTOM', 28, 2)
		ns.PaintFrames(PaladinPowerBarFrameBG, 0.1)
		return PaladinPowerBarFrame
	end
end

function ns.classModule.PRIEST(self, config, uconfig)
	if (config.PRIEST.showInsanity) then
		InsanityBarFrame:SetParent(self) 
		InsanityBarFrame:ClearAllPoints()
		InsanityBarFrame:SetPoint('BOTTOMRIGHT', self, 'TOPLEFT', 52, -50)
		return InsanityBarFrame
	end
end


function ns.classModule.WARLOCK(self, config, uconfig)
	if (config.WARLOCK.showShards) then
		WarlockPowerFrame:SetParent(self)
		WarlockPowerFrame:ClearAllPoints()
		WarlockPowerFrame:SetScale(uconfig.scale * 0.81)
		WarlockPowerFrame:SetPoint('TOP', self, 'BOTTOM', 30, -1)

		-- Affliction
		for i = 1, 5 do
			local shard = _G["WarlockPowerFrameShard"..i];
			ns.PaintFrames(select(5,shard:GetRegions()), .2)
		end
		
		return WarlockPowerFrame
	end
end
--[[
	function ns.classModule.ROGUENOPE(self, config, uconfig)
		if self.cUnit == "player" and config.showSlicenDice then
			local Aurabar = ns.CreateOutsideBar(self, true, 1, .6, 0)
			Aurabar.spellID = 5171
			self.Aurabar = Aurabar
		end
	end

	function ns.classModule.WARRIORNOPE(self, config, uconfig)
		if self.cUnit == "player" and config.showEnraged then
			local Aurabar = ns.CreateOutsideBar(self, true, 1, 0, 0)
			Aurabar.spellID = 136224

			Aurabar.Visibility = function(self, event, unit)
				local bar = self.Aurabar
				local index = GetSpecialization() or 0

				if (index == 2) then -- Enrage(fury)
					bar:SetStatusBarColor(1, 0, 0)
					bar.spellName, bar.rank = GetSpellInfo(136224)
				elseif (index == 1) then --Sweeping(arms)
					bar:SetStatusBarColor(1, .6, 0)
					bar.spellName, bar.rank = GetSpellInfo(12328)
				end
				return (index == 2 or index == 1)
			end

			self.Aurabar = Aurabar
		end
	end
]]