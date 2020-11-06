--[[
    Some introduction what this stuff is all about

    Add-On Setup

    Author      : ZooLoo
    Create Date : 10/29/2020 18:43:02
]]

-----------------------------------------------------------------------
-- Basic initialization
BLOWNLOGS, Core, BlownLogs = ...

assert(LibStub, BLOWNLOGS.." requires LibStub.")

BlownLogs = LibStub and LibStub("AceAddon-3.0"):NewAddon(BLOWNLOGS)

local WOW_RETAIL = (select(4, GetBuildInfo()) > 20000) and true or nil

local LSM = BlownLogs_LSM()


-----------------------------------------------------------------------
-- Add-On

-- Handle ADDON_LOADED Event
function BlownLogs:OnInitialize()
  local Defaults = {
    profile = {
      Debug = true,
      -- LDB = {
      --     hide = true,
      --     minimapPos = 220,
      --     radius = 80,
      -- },
    },
  }
    
  Core.db = LibStub("AceDB-3.0"):New("RaiderStateDB", Defaults, true)

  SLASH_BLOWNLOGS1 = "/blownlogs"
  SLASH_BLOWNLOGS2 = "/bbl"

  SlashCmdList["BLOWNLOGS"] = function(Cmd, ...)
    if Cmd == "debug" then
      Core:ToggleDebug()
    elseif Cmd == "show" then
      BlownLogs:ShowUI()
    --else
    -- more commands here
    end
  end

  --Acquire our frame
  self.frame = _G["Frame1"]

  BlownLogs_initMMIcon()
end

function BlownLogs:OnEnable()
  local db = Core.db.profile
	Core.Debug = db.Debug
end

function BlownLogs:ShowUI()
  -- ShowUIPanel(self.frame)
  -- HideUIPanel
  self.frame:Show()
end

function BlownLogs:ToggleUI()
  if self.frame:IsShown() then
		self.frame:Hide()
	else
		self.frame:Show()
	end
end

-----------------------------------------------------------------------
-- Core
-- Toggles debug mode.
function Core:ToggleDebug()
  local db = Core.db.profile

  -- inverse debug state
	local Debug = not db.Debug

	db.Debug = Debug
	Core.Debug = Debug

	if Debug then
		print("|cffffff99".."Унесёные логами: debug mode enabled".."|r")
	else
		print("|cffffff99".."Унесёные логами: debug mode disabled".."|r")
	end
end

function Core:GetIDFromLink(link)
	if link then
		local linktype, id = string.match(link, "|H([^:]+):(%d+)")
		if id then
			return tonumber(id)
		end
	end
end

function Core:OnEvent(event, ...)
  if event == "PLAYER_TARGET_CHANGED" then
    local unitName = UnitName("target")
    if unitName then
      local eventText = "Hello "..UnitName("target").." eh"
      _G["MessageLine"]:SetText(eventText)
      print(eventText)
    end
	end
end

-----------------------------------------------------------------------
-- Hook
local SELL_PRICE_TEXT = format("%s:", SELL_PRICE)
local EventFrame = CreateFrame("Frame")
local ttDone = false

local function OnGameTooltipSetItem(tt)
  if (not ttDone) and tt then
    ttDone = true

    local container = GetMouseFocus()
    local itemLink = select(2, tt:GetItem())
    if itemLink then
      local iteminfo = select(1, GetItemInfo(itemLink))
      if Core.Debug then
        print("Item Id:"..Core:GetIDFromLink(itemLink))
        print(iteminfo)
      end
      if BlownLogsPrio[iteminfo] ~= nil then
        --print(BlownLogsPrio[iteminfo])
        local prioStr = "Претенденты: \n"..BlownLogsPrio[iteminfo]
        tt:AddDoubleLine(prioStr)
      end
    end
  end
end

local function OnGameTooltipCleared(tt)
    ttDone = false
end

GameTooltip:HookScript("OnTooltipSetItem", OnGameTooltipSetItem)
GameTooltip:HookScript("OnTooltipCleared", OnGameTooltipCleared)

ItemRefTooltip:HookScript("OnTooltipSetItem", OnGameTooltipSetItem)
ItemRefTooltip:HookScript("OnTooltipCleared", OnGameTooltipCleared)

EventFrame:RegisterEvent("MODIFIER_STATE_CHANGED")
EventFrame:SetScript("OnEvent", EventFrame.OnEvent)
