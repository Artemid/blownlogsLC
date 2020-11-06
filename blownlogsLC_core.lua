--[[
    Some introduction what this stuff is all about

    Add-On Setup

    Author      : ZooLoo
    Create Date : 10/29/2020 20:42:14
]]

-----------------------------------------------------------------------
local LDB = BlownLogs_LDB()
local LDBIcon = BlownLogs_LDBIcon()

local miniMapBtn = {}

-- init minimap icon
function BlownLogs_initMMIcon()
  if not LDB then
    return
  end

  miniMapBtn = LDB:NewDataObject("BLOWNLOGS", {
    type = "launcher",
    label = "BlownLogs",
    icon = "Interface\\Icons\\INV_Box_04",
    OnClick = function(self, button)
      if button == "LeftButton" then
        BlownLogs:ToggleUI()
      elseif button == "RightButton" then
      end
    end,
    OnTooltipShow = function(self, tt)
    end,
  })

  Core.iconDB = Core.iconDB or {
    ["hide"] = false
  }

  LDBIcon:Register("BLOWNLOGS", miniMapBtn, Core.iconDB);
end

-----------------------------------------------------------------------
function CLR_ROLL(name)
  return "|cffF0FFF0"..name.."|r"
end

function CLR_OFFSPEC(name)
  return "|cffC41F3B"..name.."|r"
end

function CLR_PRIEST(name)
  return "|cffFFFFFF"..name.."|r"
end

function CLR_ROGUE(name)
  return "|cffFFF569"..name.."|r"
end

function CLR_DRUID(name)
  return "|cffFF7D0A"..name.."|r"
end

function CLR_MAGE(name)
  return "|cff40C7EB"..name.."|r"
end

function CLR_WARLOC(name)
  return "|cff8787ED"..name.."|r"
end

function CLR_WARRIOR(name)
  return "|cffC79C6E"..name.."|r"
end

function CLR_PALADIN(name)
  return "|cffF58CBA"..name.."|r"
end

function CLR_HUNTER(name)
  return "|cffA9D271"..name.."|r"
end

SPLITER = " > "
