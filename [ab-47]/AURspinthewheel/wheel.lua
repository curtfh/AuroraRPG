-----
-- Author Ab-47 (AURspinthewheel/wheel.lua - client)
-- Content under construction
-----

local screenWidth,screenHeight = guiGetScreenSize()  -- Get screen resolution.
local screenW, screenH = guiGetScreenSize()

--------------
-- GUI STUFF
--------------

elements = {
    button = {}
}
tries = 0
turn = false
spun = false
stopping = false
local rot = 0
local rotx = 0

addEventHandler("onClientResourceStart", resourceRoot, function ( )
	elements.button[1] = guiCreateButton(screenW * (393/1024), screenH * (532/768), screenW * (102/1024), screenH * (43/768), "", false)
	elements.button[2] = guiCreateButton(screenW * (505/1024), screenH * (532/768), screenW * (102/1024), screenH * (43/768), "", false)
	elements.button[3] = guiCreateButton(screenW * (590/1024), screenH * (137/768), screenW * (80/1024), screenH * (36/768), "", false)
	
	for k, v in pairs(elements.button) do
		guiSetAlpha(v, 0)
		guiSetVisible(v, false)
	end
	
	addEventHandler("onClientGUIClick", elements.button[1], turnTheWheel)
	addEventHandler("onClientGUIClick", elements.button[2], stopTheWheel)
	addEventHandler("onClientGUIClick", elements.button[3], removeThePic)
	end
)

function HandleTheRendering()
	if (showing or turn or spun or stopping or isTimer(timer1)) then
		outputChatBox("Something's not right, but you cannot use this command right now!", 255, 0, 0)
		return
	end
	triggerServerEvent("AURspinthewheel.updateInf", localPlayer, localPlayer, "checksCompletion")
end
addEvent("AURspinthewheel.handleTheRendering", true)
addEventHandler("AURspinthewheel.handleTheRendering", root, HandleTheRendering)

function continueOpen(plr, tries_, string)
	if (string == "yes") then
		for k, v in pairs(elements.button) do
			guiSetVisible(v, true)
		end
		showing = true
		showCursor(not isCursorShowing(), true)
		triggerServerEvent("AURspinthewheel.updateInf", localPlayer, localPlayer, "updateTries")
		addEventHandler("onClientRender", getRootElement(), renderDisplay2)
	elseif (string == "no") then
		outputChatBox("You do not have any tries left to open this panel, sorry!", 255, 0, 0)
		return
	elseif (string == "updateTries") then
		tries = tries_
	end
end
addEvent("AURspinthewheel.continueOpen", true)
addEventHandler("AURspinthewheel.continueOpen", root, continueOpen)
 
function renderDisplay2()
	dxDrawLine(screenW * (320/1024), screenH * (126/768), screenW * (320/1024), screenH * (589/768), tocolor(255, 19, 230, 255), 1, false)
	dxDrawLine(screenW * (680/1024), screenH * (126/768), screenW * (320/1024), screenH * (126/768), tocolor(255, 19, 230, 255), 1, false)
	dxDrawLine(screenW * (320/1024), screenH * (589/768), screenW * (680/1024), screenH * (589/768), tocolor(255, 19, 230, 255), 1, false)
	dxDrawLine(screenW * (680/1024), screenH * (589/768), screenW * (680/1024), screenH * (126/768), tocolor(255, 19, 230, 255), 1, false)
	
	dxDrawRectangle(screenW * (320/1024), screenH * (126/768), screenW * (360/1024), screenH * (463/768), tocolor(255, 19, 230, 30), false)
	dxDrawRectangle(screenW * (393/1024), screenH * (532/768), screenW * (102/1024), screenH * (43/768), tocolor(24, 249, 35, 160), false)
	dxDrawRectangle(screenW * (505/1024), screenH * (532/768), screenW * (102/1024), screenH * (43/768), tocolor(255, 19, 230, 160), false)

	dxDrawText("Spin", (screenW * 0.3814) + 1, (screenH * 0.6927) + 1, (screenW * 0.4846) + 1, (screenH * 0.7487) + 1, tocolor(243, 29, 190, 160), 1.50, "default", "center", "center", false, false, false, true, false)
	dxDrawText("Spin", screenW * 0.3814, screenH * 0.6927, screenW * 0.4846, screenH * 0.7487, tocolor(255, 255, 255, 255), 1.50, "default", "center", "center", false, false, false, true, false)
	dxDrawText("Stop", screenW * 0.4905, screenH * 0.6927, screenW * 0.5937, screenH * 0.7487, tocolor(255, 255, 255, 255), 1.50, "default", "center", "center", false, false, false, true, false)
	dxDrawText("Tries: "..tries, screenW * (172/1024), screenH * (133/768), screenW * (552/1024), screenH * (172/768), tocolor(255, 255, 255, 255), 1.50, "default", "center", "center", false, false, false, true, false)
	dxDrawText("X", screenW * (394/1024), screenH * (133/768), screenW * (904/1024), screenH * (172/768), tocolor(255, 255, 255, 255), 1.50, "default", "center", "center", false, false, false, true, false)
	dxDrawText("Spin The Wheel", screenW * (276/1024), screenH * (120/768), screenW * (726/1024), screenH * (155/768), tocolor(0, 0, 0, 255), 1.20, "default", "center", "center", false, false, false, true, false)
	dxDrawText("Spin The Wheel", screenW * (276/1024), screenH * (120/768), screenW * (726/1024), screenH * (155/768), tocolor(24, 249, 35, 255), 1.20, "default", "center", "center", false, false, false, true, false)
	dxDrawImage(screenWidth * 0.3484, screenHeight * 0.1972, screenWidth * 0.2755, screenHeight * 0.4855, 'img/wheel.png', rot, 0, 0, tocolor(255, 255, 255, 180), false)
end

function turnTheWheel()
	if turn == true then
		outputChatBox("It's already turning", 255, 0, 0)
		return
	end
	if spun then
		outputChatBox("You must exit this panel in order to spin again!", 255, 0, 0)
		return
	end
	outputChatBox("You've spun the wheel! Click stop to stop the wheel!", 0, 255, 255)
	addEventHandler("onClientRender", getRootElement(), renderDisplay)
	dd = math.random(1,5)
	turn = true
	spun = true
end

function stopTheWheel()
	if turn == false or stopping == true then
		outputChatBox("You cannot use this command right now!", 255, 0, 0)
		return
	end
	if isTimer(timer1) then
		destroyTimer(timer1)
		outputDebugString("Timer was still active")
	end
	stopping = true
	outputChatBox("Stopping the wheel.. Lets see what you get?", 0, 255, 255)
	triggerServerEvent("AURspinthewheel.addPlayerTry", localPlayer, localPlayer)
	timer1 = setTimer(function()
		removeEventHandler("onClientRender", getRootElement(), renderDisplay)
		turn = false
		if (dd == 1) then
			triggerServerEvent("AURspinthewheel.getPackage", localPlayer, localPlayer, dd)
			stopping = false
		elseif (dd == 2) then
			triggerServerEvent("AURspinthewheel.getPackage", localPlayer, localPlayer, dd)
			stopping = false
		elseif (dd == 3) then
			triggerServerEvent("AURspinthewheel.getPackage", localPlayer, localPlayer, dd)
			stopping = false
		elseif (dd == 4) then
			triggerServerEvent("AURspinthewheel.getPackage", localPlayer, localPlayer, dd)
			stopping = false
		elseif (dd == 5) then
			triggerServerEvent("AURspinthewheel.getPackage", localPlayer, localPlayer, dd)
			stopping = false
		else
			outputDebugString("failed: "..tonumber(dd))
		end
	end, 3000, 1)
end

function removeThePic()
	if turn then
		outputChatBox("You cannot exit until the wheel has stopped!", 255, 0, 0)
		return
	end
	removeEventHandler("onClientRender", getRootElement(), renderDisplay2)
	rot, rotx = 0, 0
	spun = false
	showing = false
	for k, v in pairs(elements.button) do
		if (guiGetVisible(v)) then
			guiSetVisible(v, false)
		end
	end
	showCursor(false)
end

function renderDisplay()
	if not turn then return end
	--[[if rot >= 2000 then
		rotx = rot - rotx
	end
	rotx = rot - rotx]]
	rot = rot + 4
end