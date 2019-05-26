local screenW, screenH = guiGetScreenSize()
local theCurrentName = ""
local theCurrentAmmount = 0
local theCurrentDescription = ""
local theTimer
local start 

local theCurrentQueue = {}

function startRendering()
	local now = getTickCount()
	local elapsedTime = now - start
	local endTime = start + 3000
	local duration = endTime - start
	local progress = elapsedTime / duration
	local x1, y1, z1 = interpolateBetween ( 0, 0, 0, screenWidth, screenHeight, 255, progress, "OutBack")

	dxDrawText("#ff0000"..theCurrentName.." #ffffffhas donated #ff0000$"..theCurrentAmmount.."!", screenW * 0.3974, y1 * 0.2435, x1 * 0.5667, screenH * 0.2815, tocolor(255, 255, 255, 255), 2.00, "sans", "center", "center", false, true, false, true, false)
	dxDrawText(theCurrentDescription, (screenW * 0.3974) - 1, (y1 * 0.2815) - 1, (x1 * 0.5667) - 1, (screenHeight * 0.3296) - 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "top", true, true, false, false, false)
	dxDrawText(theCurrentDescription, (screenW * 0.3974) + 1, (y1 * 0.2815) - 1, (x1 * 0.5667) + 1, (screenH * 0.3296) - 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "top", true, true, false, false, false)
	dxDrawText(theCurrentDescription, (screenW * 0.3974) - 1, (y1 * 0.2815) + 1, (x1 * 0.5667) - 1, (screenH * 0.3296) + 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "top", true, true, false, false, false)
	dxDrawText(theCurrentDescription, (screenW * 0.3974) + 1, (y1 * 0.2815) + 1, (x1 * 0.5667) + 1, (screenH * 0.3296) + 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "top", true, true, false, false, false)
	dxDrawText(theCurrentDescription, screenW * 0.3974, y1 * 0.2815, x1 * 0.5667, screenH * 0.3296, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "top", true, true, false, false, false)
end

setTimer(function()
	if (#theCurrentQueue >= 1) then 
		if (isTimer(theTimer)) then return end 
		theCurrentName = theCurrentQueue[1][1]
		theCurrentAmmount = theCurrentQueue[1][2]
		theCurrentDescription = theCurrentQueue[1][3]
		table.remove(theCurrentQueue, 1)
		triggerEventDonation()
	end 
end, 5000, 0)

function triggerEventDonation (name, amount, desc)
	if (isTimer(theTimer)) then 
		return false
	end 
	theCurrentName = name
	theCurrentAmmount = amount
	theCurrentDescription = desc
	addEventHandler("onClientRender", root, startRendering)
	theTimer = setTimer(function()
		removeEventHandler("onClientRender", root, startRendering)
		start = nil
	end, 8000, 1)
end 
addEvent("AURtts.triggerEventDonation", true)
addEventHandler("AURtts.triggerEventDonation", localPlayer, triggerEventDonation)

function testFunc ()
	theCurrentName = "Curt"
	theCurrentAmmount = 
	triggerEventDonation()
end 

if (fileExists("client.lua")) then 
	fileDelete("client.lua")
end 