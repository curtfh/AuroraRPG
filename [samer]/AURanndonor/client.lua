local isShowing = false
local screenW, screenH = guiGetScreenSize()
local sX = screenW/1366
local sY = screenH/768
local desc = ""
local playerName = ""
local amount = ""
local theCurrentQueue = {}
local theSound

addEvent("AURanndonor.drawDonorDx", true)

addEvent("playTTS", true)

local function playTTS(text)
    local URL = "https://curtcreation.net/tts.php?t="..text
    return true, playSound(URL), URL
end
addEventHandler("playTTS", root, playTTS)

function initDonorDx()
	dxDrawRectangle(sX*403, sY*pos1, sX*561, sY*215, tocolor(0, 0, 0, 183), false)
	dxDrawText(playerName.." donated $"..amount, sX*405, sY*(pos1+16), sX*960, sY*(pos1+101), tocolor(255, 255, 255, 255), 3.00, "default", "center", "center", false, false, false, false, false)
	dxDrawText(desc, sX*402 - 1, sY*(107+pos1) - 1, sX*964 - 1, sY*(209+pos1) - 1, tocolor(0, 0, 0, 255), 1.00, "default", "center", "center", false, true, false, false, false)
	dxDrawText(desc, sX*402 + 1, sY*(107+pos1) - 1, sX*964 + 1, sY*(209+pos1) - 1, tocolor(0, 0, 0, 255), 1.00, "default", "center", "center", false, true, false, false, false)
	dxDrawText(desc, sX*402 - 1, sY*(107+pos1) + 1, sX*964 - 1, sY*(209+pos1) + 1, tocolor(0, 0, 0, 255), 1.00, "default", "center", "center", false, true, false, false, false)
	dxDrawText(desc, sX*402 + 1, sY*(107+pos1) + 1, sX*964 + 1, sY*(209+pos1) + 1, tocolor(0, 0, 0, 255), 1.00, "default", "center", "center", false, true, false, false, false)
	dxDrawText(desc, sX*402, sY*(107+pos1), sX*964, sY*(209+pos1), tocolor(255, 255, 255, 255), 1.00, "default", "center", "center", false, true, false, false, false)
end

function skipDonation()
	removeEventHandler("onClientRender", root, firstInterpolation)
	removeEventHandler("onClientRender", root, secondInterpolation)
	removeEventHandler("onClientRender", root, drawDonorDx)
	removeEventHandler("onClientRender", root, initDonorDx)
	stopSound(theSound)
	theSound = nil
	isShowing = false
end 
addEvent("AURanndonor.skipDonation", true)
addEventHandler("AURanndonor.skipDonation", root, skipDonation)

function drawDonorDx(plr, am, de)
	setTimer(function()
		if (isShowing == true) then 
			theCurrentQueue[#theCurrentQueue+1] = {plr, am, de}
			return 
		end 
		playSound("alert.ogg")
		isShowing = true
		addEventHandler("onClientRender", root, firstInterpolation)
		addEventHandler("onClientRender", root, initDonorDx)
		start = getTickCount()
		desc = de
		amount = am
		playerName = plr
		local r, theS, url = playTTS(de)
		theSound = theS
	end, 2000, 1)
end
addEvent("AURanndonor.drawDonorDx", true)
addEventHandler("AURanndonor.drawDonorDx", root, drawDonorDx)

function firstInterpolation()
	local now = getTickCount()
	local duration = 2000
	local elapsed = now - start
	local progress = (now - start) / (duration)
	pos1 = interpolateBetween(768, 0, 0, 391, 0, 0, progress, "OutBounce")
	if (now > start + duration) then
		removeEventHandler("onClientRender", root, firstInterpolation)
		setTimer(function()
			start2 = getTickCount()
			addEventHandler("onClientRender", root, secondInterpolation)
		end, 5000, 1)
	end
end

function secondInterpolation()
	local now = getTickCount()
	local duration = 2000
	local elapsed = now - start2
	local progress = (now - start2) / (duration)
	pos1 = interpolateBetween(391, 0, 0, 768, 0, 0, progress, "Linear")
	if (now > start2 + duration) then
		isShowing = false
		removeEventHandler("onClientRender", root, secondInterpolation)
		removeEventHandler("onClientRender", root, drawDonorDx)
	end
end

setTimer(function()
	if (#theCurrentQueue >= 1) then 
		if (isShowing == true) then return end 
		playerName1 = theCurrentQueue[1][1]
		amount1 = theCurrentQueue[1][2]
		desc1 = theCurrentQueue[1][3]
		table.remove(theCurrentQueue, 1)
		drawDonorDx(playerName1, amount1, desc1)
	end 
end, 5000, 0)
