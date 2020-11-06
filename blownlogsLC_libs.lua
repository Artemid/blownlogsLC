--[[
    Some introduction what this stuff is all about

    Add-On Setup

    Author      : ZooLoo
    Create Date : 10/31/2020 11:15:50
]]

-----------------------------------------------------------------------
local libLSM = LibStub and LibStub:GetLibrary("LibSharedMedia-3.0", true)
local libLDB = LibStub and LibStub("LibDataBroker-1.1", true)
local libLDBIcon = LibStub and LibStub("LibDBIcon-1.0", true)


-----------------------------------------------------------------------
function BlownLogs_LSM()
  return libLSM
end

function BlownLogs_LDB()
  return libLDB
end

function BlownLogs_LDBIcon()
  return libLDBIcon
end
