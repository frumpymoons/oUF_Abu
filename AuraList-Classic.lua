local _, ns = ...
if not ns.Classic then return end
local AuraList = {}

AuraList.Immunity = {
	1022,	-- Hand of Protection
	642,	-- Divine Shield (Paladin)
	19263 ,	-- Deterrence
}

AuraList.CCImmunity = {
	1044,	-- Hand of Freedom
	8178,	-- Grounding Totem Effect (Grounding Totem)
	23920,	-- Spell Reflection (warrior)
}

AuraList.Defensive = {
	22812,	-- Barskin
	498,	-- Divine Protection
	5277,	-- Evasion
	871,	-- Shield Wall
	6940,	-- Hand of Sacrifice
}

AuraList.Offensive = {
	1719,	-- Recklessness
	12472,	-- Icy Veins
}

AuraList.Helpful = {
	1850, 	-- Dash
	2983,	-- Sprint
	66,		-- Invisibility
	740,	-- Tranquility
}

AuraList.Misc = {

}

AuraList.Stun = {
	1833,	-- Cheap Shot
	24394,	-- Intimidation
	408,	-- Kidney Shot
	5211,	-- Bash
	6770,	-- Sap
	853,	-- Hammer of Justice
	22570,	-- Maim
}

AuraList.CC = {
	118, 	-- Polymorph
	19386,	-- Wyvern Sting
	19387, 	-- Entrapment
	20066,	-- Repentance
	2094, 	-- Blind
	339,	-- Entangling Roots
	5246,	-- Intimidating Shout
	5484, 	-- Howl of Terror
	5782,	-- Fear
	605, 	-- Mind Control
	6358,	-- Seduction
	6789, 	-- Death Coil
	8122,	-- Psychic Scream
	8377,	-- Earthgrab
	99,		-- Disorienting Roar
	1776,	-- Gouge
}

AuraList.Silence = {
	1330,	-- Garrote - Silence
	15487,	-- Silence (priest)
	19647,	-- Spell Lock
}

AuraList.Taunt = {
	20736,	-- Distracting Shot
	6795,	-- Growl
	355,	-- Taunt
}

for k, v in pairs(AuraList) do
	for i = #v, 1, -1 do
		if not GetSpellInfo(v[i]) then
			print(string.format("Invalid spellID: %d, in AuraList.%s", v[i], k))
			table.remove(v, v[i])
		end
	end
end

ns.AuraList = AuraList