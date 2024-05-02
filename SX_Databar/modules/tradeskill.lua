local addon, ns = ...
local cfg = ns.cfg
local unpack = unpack
--------------------------------------------------------------
if not cfg.tradeSkill.show then return end
local x = {}

local tradeSkillFrame = CreateFrame("Frame",nil, cfg.SXframe)
tradeSkillFrame:SetPoint("LEFT", cfg.SXframe, "CENTER", -48,0)
tradeSkillFrame:SetSize(16, 16)
---------------------------------------------------------------------
local primaryTradeSkillFrame = CreateFrame("BUTTON",nil, tradeSkillFrame)
primaryTradeSkillFrame:SetSize(100, 16)
primaryTradeSkillFrame:SetPoint("RIGHT",tradeSkillFrame)
primaryTradeSkillFrame:EnableMouse(true)
primaryTradeSkillFrame:RegisterForClicks("AnyUp")

local primaryTradeSkillText = primaryTradeSkillFrame:CreateFontString(nil, "OVERLAY")
primaryTradeSkillText:SetFont(cfg.text.font, cfg.text.normalFontSize)
primaryTradeSkillText:SetPoint("RIGHT",primaryTradeSkillFrame,2,0 )
primaryTradeSkillText:SetTextColor(unpack(cfg.color.normal))

local primaryTradeSkillIcon = primaryTradeSkillFrame:CreateTexture(nil,"OVERLAY",nil,7)
primaryTradeSkillIcon:SetSize(16, 16)
primaryTradeSkillIcon:SetPoint("LEFT",primaryTradeSkillText,-16,0 )
primaryTradeSkillIcon:SetVertexColor(unpack(cfg.color.normal))






primaryTradeSkillFrame:SetScript("OnClick", function(self, button, down)
	if InCombatLockdown() then return end
		if button == "LeftButton" then
			if x then
				CastSpellByName(x[1])
			end
		end
end)
---------------------------------------------------------------------
local secondaryTradeSkillFrame = CreateFrame("BUTTON",nil, tradeSkillFrame)
secondaryTradeSkillFrame:SetSize(110, 16)
secondaryTradeSkillFrame:SetPoint("RIGHT",primaryTradeSkillFrame,132,0)
secondaryTradeSkillFrame:EnableMouse(true)
secondaryTradeSkillFrame:RegisterForClicks("AnyUp")

local secondaryTradeSkillText = secondaryTradeSkillFrame:CreateFontString(nil, "OVERLAY")
secondaryTradeSkillText:SetFont(cfg.text.font, cfg.text.normalFontSize)
secondaryTradeSkillText:SetPoint("RIGHT",secondaryTradeSkillFrame,2,0 )
secondaryTradeSkillText:SetTextColor(unpack(cfg.color.normal))

local secondaryTradeSkillIcon = secondaryTradeSkillFrame:CreateTexture(nil,"OVERLAY",nil,7)
secondaryTradeSkillIcon:SetSize(16, 16)
secondaryTradeSkillIcon:SetPoint("LEFT",secondaryTradeSkillText,-16,0 )
secondaryTradeSkillIcon:SetVertexColor(unpack(cfg.color.normal))


secondaryTradeSkillFrame:SetScript("OnClick", function(self, button, down)
	if InCombatLockdown() then return end
		if button == "LeftButton" then
			if x then
				CastSpellByName(x[2])
			end
		end
end)
---------------------------------------------------------------------

local eventframe = CreateFrame("Frame")
eventframe:RegisterEvent("PLAYER_ENTERING_WORLD")
eventframe:RegisterEvent("TRADE_SKILL_UPDATE")
eventframe:RegisterEvent("TRAINER_CLOSED")
eventframe:RegisterEvent("SPELLS_CHANGED")
--eventframe:RegisterUnitEvent("UNIT_SPELLCAST_STOP", "player")

eventframe:SetScript("OnEvent", function(self,event, ...)
	--local prof1, prof2 = GetProfessions()
	
	local profList = {"ALCHEMY", "ENGINEERING", "BLACKSMITHING", "ENCHANTING",
	"INSCRIPTION", "JEWELCRAFTING", "LEATHERWORKING", "TAILORING","FIND MINERALS", "FIND HERBS", "SKINNING"}
	local i = 1
	while i < 25 do
	   local prof1Name, spellRank = GetSpellName(i, BOOKTYPE_SPELL)
	   if not prof1Name then
	      do break end
	   end
	   
	   for _,v in pairs(profList) do
	      if v == string.upper(prof1Name) then
	         table.insert(x,v)
	      end
	   end
	   i = i + 1
	end
	if x[1] ~= nil then
		local prof1Name = x[1]
		prof1Name = string.upper(prof1Name)
		primaryTradeSkillText:SetText(prof1Name)
		primaryTradeSkillIcon:SetTexture(cfg.mediaFolder.."profession\\"..prof1Name)
		
		
	else
		primaryTradeSkillFrame:Hide() 
		primaryTradeSkillFrame:EnableMouse(false)
	end

	
	if x[2] ~= nil then
		local prof2Name = x[2]
		prof2Name = string.upper(prof2Name)
		secondaryTradeSkillText:SetText(prof2Name)
		secondaryTradeSkillIcon:SetTexture(cfg.mediaFolder.."profession\\"..prof2Name)

		else
		secondaryTradeSkillFrame:Hide() 
		secondaryTradeSkillFrame:EnableMouse(false)	
	end	
	tradeSkillFrame:SetSize((primaryTradeSkillFrame:GetWidth())+(secondaryTradeSkillFrame:GetWidth()+4), 16)
end)