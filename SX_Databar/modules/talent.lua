local addon, ns = ...
local cfg = ns.cfg
local unpack = unpack
local current = {}
--------------------------------------------------------------
if not cfg.talent.show then return end

local currentSpec = 0 -- from 1-4
local currentSpecID, currentSpecName = 0,0 --global id
local lootspecid = 0
local id, name = 0,0

local talentFrame = CreateFrame("Frame",nil, cfg.SXframe)
talentFrame:SetPoint("RIGHT", cfg.SXframe, "CENTER", -100,0)
talentFrame:SetSize(16, 16)


---------------------------------------------
-- PRIMARY SPEC FRAME
---------------------------------------------

local primarySpecFrame = CreateFrame("BUTTON",nil, talentFrame)
primarySpecFrame:SetPoint("RIGHT")
primarySpecFrame:SetSize(16, 16)
primarySpecFrame:EnableMouse(true)
primarySpecFrame:RegisterForClicks("AnyUp")

local primarySpecText = primarySpecFrame:CreateFontString(nil, "OVERLAY")
primarySpecText:SetFont(cfg.text.font, cfg.text.normalFontSize)
primarySpecText:SetPoint("RIGHT")
primarySpecText:SetTextColor(unpack(cfg.color.normal))

local primarySpecIcon = primarySpecFrame:CreateTexture(nil,"OVERLAY",nil,7)
primarySpecIcon:SetSize(16, 16)
primarySpecIcon:SetPoint("RIGHT", primarySpecText,20,0)
primarySpecIcon:SetVertexColor(unpack(cfg.color.normal))
	

---------------------------------------------------------------------


---------------------------------------------
-- EVENTS
---------------------------------------------

local eventframe = CreateFrame("Frame")
eventframe:RegisterEvent("PLAYER_ENTERING_WORLD")
eventframe:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
eventframe:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED")
eventframe:RegisterEvent("PLAYER_LOOT_SPEC_UPDATED")
eventframe:RegisterEvent("PLAYER_REGEN_DISABLED")

eventframe:SetScript("OnEvent", function(self,event, ...)
	local  current = {}
	local group = GetActiveTalentGroup(isInspect);
		-- Get points per tree, and set "maxTree" to the tree with most points
	local maxTree, _ = 1;
	for i = 1, 3 do
		_, _, current[i] = GetTalentTabInfo(i,isInspect,nil,group);
		if (current[i] > current[maxTree]) then
			maxTree = i;
		end
	end
	current.tree = GetTalentTabInfo(maxTree,isInspect,nil,group);
	name = current.tree

	if name ~= nil then
		--name = string.upper(name) end
		name = string.upper(name)
		primarySpecText:SetText(name)
		primarySpecIcon:SetTexture(cfg.mediaFolder.."spec\\"..cfg.CLASS)
		--primarySpecIcon:SetTexCoord(unpack(cfg.specCoords[primarySpec]))
		primarySpecFrame:SetSize(primarySpecText:GetStringWidth()+18, 16)
		primarySpecFrame:Show() 
		primarySpecFrame:EnableMouse(true)
	else
		primarySpecFrame:Hide() 
		primarySpecFrame:EnableMouse(false)
	end
	

	
	
	--talentFrame:SetSize((primarySpecFrame:GetWidth())+(secondarySpecFrame:GetWidth()+4), 16)
end)