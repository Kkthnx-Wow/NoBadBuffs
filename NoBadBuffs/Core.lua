--[[
	The MIT License (MIT)
	Copyright (c) 2022 Josh 'Kkthnx' Russell
	Permission is hereby granted, free of charge, to any person obtaining a copy
	of this software and associated documentation files (the "Software"), to deal
	in the Software without restriction, including without limitation the rights
	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
	copies of the Software, and to permit persons to whom the Software is
	furnished to do so, subject to the following conditions:
	The above copyright notice and this permission notice shall be included in all
	copies or substantial portions of the Software.
	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
	SOFTWARE.
--]]

local Module = CreateFrame("Frame", "Kkthnx_NoBadBuffs")
Module:Hide()
Module:RegisterEvent("UNIT_AURA")

local _G = _G

local UnitBuff = _G.UnitBuff
local InCombatLockdown = _G.InCombatLockdown
local GetSpellInfo = _G.GetSpellInfo

local function SpellName(id)
	local name = GetSpellInfo(id)
	if name then
		return name
	else
		-- stylua: ignore
		print("|cffff0000WARNING: [NoBadBuffs] - spell ID ["..tostring(id).."] no longer exists! Report this to Kkthnx.|r")
		return "Empty"
	end
end

local CheckBadBuffs = {
	[SpellName(172003)] = true, -- Slime Costume
	[SpellName(172008)] = true, -- Ghoul Costume
	[SpellName(172010)] = true, -- Abomination Costume
	[SpellName(172015)] = true, -- Geist Costume
	[SpellName(172020)] = true, -- Spider Costume
	[SpellName(24709)] = true, -- Pirate Costume
	[SpellName(24710)] = true, -- Ninja Costume
	[SpellName(24712)] = true, -- Leper Gnome Costume
	[SpellName(24723)] = true, -- Skeleton Costume
	[SpellName(24732)] = true, -- Bat Costume
	[SpellName(24735)] = true, -- Ghost Costume
	[SpellName(24740)] = true, -- Wisp Costume
	[SpellName(261477)] = true, -- Dervish
	[SpellName(279509)] = true, -- A Witch!
	[SpellName(44212)] = true, -- Jack-o'-Lanterned!
	[SpellName(58493)] = true, -- Mohawked!
	[SpellName(61716)] = true, -- Rabbit Costume
	[SpellName(61734)] = true, -- Noblegarden Bunny
	[SpellName(61781)] = true, -- Turkey Feathers
}

Module:SetScript("OnEvent", function(_, _, unit)
	-- print(unit)
	if unit == "player" and not InCombatLockdown() then
		local i = 1
		while true do
			local name = UnitBuff(unit, i)
			-- print(name)
			if not name then
				return
			end

			if CheckBadBuffs[name] then
				CancelSpellByName(name)
				print("|CFF669DFFNoBadBuffs|r " .. ACTION_SPELL_AURA_REMOVED .. " |CFFFFFF00[" .. name .. "]|r")
			end

			i = i + 1
		end
	end
end)
