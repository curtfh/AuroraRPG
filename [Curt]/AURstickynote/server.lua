--[[
AuroraRPG - aurorarpg.com
This resource is property of AuroraRPG.
Author: Curt
All Rights Reserved 2017
]]--

function displayText (thePlayer, theID, theType, theText, r, g, b)
	triggerClientEvent(thePlayer, "AURstickynote.createTextScreen", thePlayer, theID, theType, theText, r, g, b) 
	return true
end 