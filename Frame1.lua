--[[
    Add-On frame controls

    Author      : ZooLoo
    Create Date : 10/29/2020 18:43:02
]]

function Frame1_OnEvent(event, ...)
  print("Event: "..event.." "..select("#", ...))
  Core:OnEvent(event, ...)
end

function ButtonClose_OnClick()
	Frame1:Hide()
end
