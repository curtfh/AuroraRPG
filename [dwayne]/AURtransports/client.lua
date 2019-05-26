
local toPlace = false
local tranporter = false

local rx, ry = guiGetScreenSize()

Transports = {
    staticimage = {},
    radiobutton = {},
    button = {},
    window = {},
    label = {}
}
Transports.window[1] = guiCreateWindow((rx/2) - 250, (ry/2) - 180, 516, 343, "Train System", false)
guiWindowSetSizable(Transports.window[1], false)
guiSetAlpha(Transports.window[1], 1.00)
guiSetVisible(Transports.window[1],false)
Transports.staticimage[1] = guiCreateStaticImage(70, 22, 380, 84, "logo.png", false, Transports.window[1])
Transports.label[1] = guiCreateLabel(37, 111, 439, 28, "Where you want to go?", false, Transports.window[1])
guiSetFont(Transports.label[1], "default-bold-small")
guiLabelSetHorizontalAlign(Transports.label[1], "center", false)
guiLabelSetVerticalAlign(Transports.label[1], "center")
Transports.radiobutton[1] = guiCreateRadioButton(189, 155, 137, 20, "Las Venturas", false, Transports.window[1])
Transports.radiobutton[2] = guiCreateRadioButton(189, 215, 137, 20, "San fierro", false, Transports.window[1])
Transports.radiobutton[3] = guiCreateRadioButton(189, 185, 137, 20, "Los Santos", false, Transports.window[1])
Transports.button[1] = guiCreateButton(184, 257, 142, 32, "Visit", false, Transports.window[1])
guiSetProperty(Transports.button[1], "NormalTextColour", "FFAAAAAA")
Transports.button[2] = guiCreateButton(184, 293, 142, 32, "No, thanks!", false, Transports.window[1])
guiSetProperty(Transports.button[2], "NormalTextColour", "FFAAAAAA")

addEvent("toggleTrainPanel",true)
addEventHandler("toggleTrainPanel",root,function(pos)
	if source ~= localPlayer then return false end
	if tranporter == true then return false end
	if pos == "Los Santos" then
		guiSetEnabled(Transports.radiobutton[1],true)
		guiSetEnabled(Transports.radiobutton[2],true)
		guiSetEnabled(Transports.radiobutton[3],false)
		guiRadioButtonSetSelected(Transports.radiobutton[3], false)
	elseif pos == "Las Venturas" then
		guiSetEnabled(Transports.radiobutton[1],false)
		guiSetEnabled(Transports.radiobutton[2],true)
		guiSetEnabled(Transports.radiobutton[3],true)
		guiRadioButtonSetSelected(Transports.radiobutton[1], false)
	else
		guiSetEnabled(Transports.radiobutton[1],true)
		guiSetEnabled(Transports.radiobutton[2],false)
		guiSetEnabled(Transports.radiobutton[3],true)
		guiRadioButtonSetSelected(Transports.radiobutton[2], false)
	end
	toPlace = pos
	guiSetVisible(Transports.window[1],true)
	showCursor(true)
end)

addEventHandler("onClientGUIClick",root,function()
	if source == Transports.button[2] then
		guiSetVisible(Transports.window[1],false)
		showCursor(false)
	elseif source == Transports.button[1] then
		if getPlayerMoney(localPlayer) >= 5000 then
			guiSetVisible(Transports.window[1],false)
			showCursor(false)
			if guiRadioButtonGetSelected(Transports.radiobutton[1]) then
				triggerServerEvent("TrainAccepted",localPlayer,"Las Venturas")
			elseif guiRadioButtonGetSelected(Transports.radiobutton[2]) then
				triggerServerEvent("TrainAccepted",localPlayer,"San fierro")
			elseif guiRadioButtonGetSelected(Transports.radiobutton[3]) then
				triggerServerEvent("TrainAccepted",localPlayer,"Los Santos")
			end
		else
			exports.NGCdxmsg:createNewDxMessage("You can't efford this !! you don't have enough money",255,0,0)
		end
	end
end)

local lvCol = createColSphere( 1431.44, 2634.37,10, 20 )
local sfCol = createColSphere( -1946,116,25, 20 )
local lsCol = createColSphere( 1702,-1957,13, 20 )

local vehicles = {}
local civilians = {
{1821.13, -1956.24, 2104},
--{1821.24, -1959.34, 2104},
{1822.9, -1954.69, 2104},
}

function loadCiv()
	for k,v in ipairs(civilians) do
		local pe = createPed(80,v[1],v[2],v[3])
		if pe then
			setPedRotation(pe,180)
			setPedAnimation(pe,"MISC","Seat_talk_01",-1, true, false, true, true)
			setElementFrozen(pe,true)
		end
	end
end



addEvent("TrainLoaded",true)
addEventHandler("TrainLoaded",root,function(fromPlace)
	if toPlace == "San fierro" and fromPlace == "Las Venturas" then
		gayTime(-1940,120,26,true,0,3)
		outputDebugString("From LV to SF")
	elseif toPlace == "Los Santos" and fromPlace == "Las Venturas" then
		gayTime(1700,-1941,13,false,280,-3)
		outputDebugString("From LV to LS")
	elseif toPlace == "Los Santos" and fromPlace == "San fierro" then
		gayTime(1700,-1941,13,true,280,3)
		outputDebugString("From SF to LS")
	elseif toPlace == "San fierro" and fromPlace == "Los Santos" then
		gayTime(-1949,86,25,false,280,-3)
		outputDebugString("From LS to SF")
	elseif toPlace == "Las Venturas" and fromPlace == "San fierro" then
		gayTime(1436,2632,10,false,280,-3)
		outputDebugString("From LV to SF")
	elseif toPlace == "Las Venturas" and fromPlace == "Los Santos" then
		gayTime(1436,2632,10,true,280,3)
		outputDebugString("From LV to LS")
	end
end)

function gayTime(x,y,z,state,r,speed)
	gay = false
	veh = createVehicle(537,x,y,z,0,0,r)
	setTrainDirection(veh, state)
	ped = createPed(302,x,y,z)
	warpPedIntoVehicle(ped,veh)
	addEventHandler("onClientRender",root,draw)
	setTrainDerailable(veh, false)
	setTrainSpeed(veh,speed)
	table.insert(vehicles,veh)
	tranporter = true
	speedx = speed
	--exports.NGCdxmsg:createNewDxMessage("Be patient train will reach your distination within 3 minutes",255,255,0)
	setTimer(function() gay = true end,5000,1)
	rectangleAlpha = 170
	rectangleAlpha2 = 170
	textAlpha = 255
	textAlpha2 = 255
	fadeTimer = setTimer(fadeTheText, 500, 0)
	removeEventHandler("onClientRender", root, drawTCText)
	addEventHandler("onClientRender", root, drawTCText)

end


function draw()
	if gay == true then
		local x,y,z = getElementPosition(veh)
		setCameraMatrix(x,y,z+100, x,y,z)
	else
		setCameraMatrix(1822,-1963,2105,1821,-1955,2104)
	end
	if speedx then
		setTrainSpeed(veh,speedx)
	end
end

addEventHandler("onClientPlayerQuit",localPlayer,function()
	if isElement(veh) then destroyElement(veh) end
	if isElement(ped) then destroyElement(ped) end
	removeEventHandler("onClientRender",root,draw)
end)

addEventHandler("onClientPedDamage",root,function()
	if getElementData(source,"DM") then
		cancelEvent(true)
	end
end)

addEventHandler("onClientElementColShapeHit",root,function(col)
	if lvCol == col then
		if getElementType(source) ~= "vehicle" then return false end
		if source == veh then
			if isElement(veh) then destroyElement(veh) end
			if isElement(ped) then destroyElement(ped) end
			removeEventHandler("onClientRender",root,draw)
			setCameraTarget(localPlayer)
			tranporter = false
			triggerServerEvent("setPositionTrain",localPlayer,1431,2623,11,181)
		end
	elseif sfCol == col then
		if getElementType(source) ~= "vehicle" then return false end
		if source == veh then
			if isElement(veh) then destroyElement(veh) end
			if isElement(ped) then destroyElement(ped) end
			removeEventHandler("onClientRender",root,draw)
			setCameraTarget(localPlayer)
			tranporter = false
			triggerServerEvent("setPositionTrain",localPlayer,-1959,116,27,83)
		end
	elseif lsCol == col then
		if getElementType(source) ~= "vehicle" then return false end
		if source == veh then
			if isElement(veh) then destroyElement(veh) end
			if isElement(ped) then destroyElement(ped) end
			removeEventHandler("onClientRender",root,draw)
			setCameraTarget(localPlayer)
			tranporter = false
			triggerServerEvent("setPositionTrain",localPlayer,1739,-1950,14,176)
		end
	end
end)

function createTrain(id,x,y,z,r1,r2,r3)
	ob = createObject(id,x-200,y-4200,z,r1,r2,r3)
end


local job = {
	{-1974,118,28.5,"San Fierro Train Station"},
	{1734,-1946,14.5,"Los Santos Train Station"},
	{1438,2615,12.5,"Las Venturas Train Station"},
}

for i,k in pairs(job) do
	createBlip(k[1],k[2],k[3],42)
end

function showTextOnTopOfPed1()
    local x1, y1, z1 = getElementPosition(localPlayer)
	for ID in ipairs(job) do
		local mX1, mY1, mZ1 = job[ID][1], job[ID][2], job[ID][3]
		local jobb1 = job[ID][4]
		local sx1, sy1 = getScreenFromWorldPosition(mX1, mY1, mZ1)
		if (sx1) and (sy1) then
			local distance1 = getDistanceBetweenPoints3D(x1, y1, z1, mX1, mY1, mZ1)
			if (distance1 < 30) then
				dxDrawText(jobb1, sx1-1, sy1-1, sx1, sy1, tocolor(0,0,0, 255), 1-(distance1/20), "pricedown", "center", "center")
				dxDrawText(jobb1, sx1+1, sy1+1, sx1, sy1, tocolor(0,0,0, 255), 1-(distance1/20), "pricedown", "center", "center")
				dxDrawText(jobb1, sx1+2, sy1+2, sx1, sy1, tocolor(255,150,0, 255), 1-(distance1/20), "pricedown", "center", "center")
			end
		end
	end
end
addEventHandler("onClientRender",root,showTextOnTopOfPed1)


local screenWidth, screenHeight = guiGetScreenSize()
local screenWidth, screenHeight = guiGetScreenSize()
rectangleAlpha = 170
rectangleAlpha2 = 170
textAlpha = 255
textAlpha2 = 255
local screenW, screenH = guiGetScreenSize()

function fadeTheText()
	textAlpha = textAlpha - 5.5
	rectangleAlpha = rectangleAlpha - 5.5
	if (rectangleAlpha <= 0) then
		if isTimer(fadeTimer) then killTimer(fadeTimer) end
		removeEventHandler("onClientRender", root, drawTCText)
	end
end

function drawTCText()
	dxDrawBorderedText("Please wait till the train reach the next station", 1.75, (screenW - 504) / 2, (screenH - 350) / 1.05, ((screenW - 504) / 2) + 504, ( (screenH - 44) / 1.05) + 44, tocolor(0,100,200, 255), 1, "pricedown", "center", "center", false, false, true, false, false)
end


function dxDrawBorderedText ( text, wh, x, y, w, h, clr, scale, font, alignX, alignY, clip, wordBreak, postGUI )
	if not wh then wh = 1.5 end
	dxDrawText ( text, x - wh, y - wh, w - wh, h - wh, tocolor ( 0, 0, 0, a ), scale, font, alignX, alignY, clip, wordBreak, false, true) -- black
	dxDrawText ( text, x + wh, y - wh, w + wh, h - wh, tocolor ( 0, 0, 0, a ), scale, font, alignX, alignY, clip, wordBreak, false, true)
	dxDrawText ( text, x - wh, y + wh, w - wh, h + wh, tocolor ( 0, 0, 0, a ), scale, font, alignX, alignY, clip, wordBreak, false, true)
	dxDrawText ( text, x + wh, y + wh, w + wh, h + wh, tocolor ( 0, 0, 0, a ), scale, font, alignX, alignY, clip, wordBreak, false, true)
	dxDrawText ( text, x - wh, y, w - wh, h, tocolor ( 0, 0, 0, a ), scale, font, alignX, alignY, clip, wordBreak, false, true)
	dxDrawText ( text, x + wh, y, w + wh, h, tocolor ( 0, 0, 0, a ), scale, font, alignX, alignY, clip, wordBreak, false, true)
	dxDrawText ( text, x, y - wh, w, h - wh, tocolor ( 0, 0, 0, a ), scale, font, alignX, alignY, clip, wordBreak, false, true)
	dxDrawText ( text, x, y + wh, w, h + wh, tocolor ( 0, 0, 0, a ), scale, font, alignX, alignY, clip, wordBreak, false, true)
	dxDrawText ( text, x, y, w, h, clr, scale, font, alignX, alignY, clip, wordBreak, postGUI, true)
end

createTrain(2631,2022.0000000,2236.7000000,2102.9000000,0.0000000,0.0000000,90.0000000) --
createTrain(2631,2022.0000000,2240.6000000,2102.9000000,0.0000000,0.0000000,90.0000000) --
createTrain(2631,2022.0000000,2244.5000000,2102.9000000,0.0000000,0.0000000,90.0000000) --
createTrain(2631,2022.0000000,2248.4000000,2102.9000000,0.0000000,0.0000000,90.0000000) --
createTrain(16501,2022.1000000,2238.3000000,2102.8000000,0.0000000,90.0000000,0.0000000) --
createTrain(16501,2022.1000000,2245.3000000,2102.8000000,0.0000000,90.0000000,0.0000000) --
createTrain(16000,2024.2000000,2240.1000000,2101.2000000,0.0000000,0.0000000,90.0000000) --
createTrain(16000,2019.8000000,2240.6000000,2101.2000000,0.0000000,0.0000000,-90.0000000) --
createTrain(16000,2022.2000000,2248.7000000,2101.2000000,0.0000000,0.0000000,180.0000000) --
createTrain(16501,2021.8000000,2246.5000000,2107.3000000,0.0000000,270.0000000,90.0000000) --
createTrain(16501,2022.0000000,2240.8000000,2107.3000000,0.0000000,270.0000000,0.0000000) --
createTrain(16501,2022.0000000,2233.7000000,2107.3000000,0.0000000,270.0000000,0.0000000) --
createTrain(18098,2024.3000000,2239.6000000,2104.8000000,0.0000000,0.0000000,90.0000000) --
createTrain(18098,2024.3000000,2239.7000000,2104.7000000,0.0000000,0.0000000,450.0000000) --
createTrain(18098,2020.1000000,2239.6000000,2104.8000000,0.0000000,0.0000000,90.0000000) --
createTrain(18098,2020.0000000,2239.6000000,2104.7000000,0.0000000,0.0000000,90.0000000) --
createTrain(2180,2023.6000000,2236.1000000,2106.7000000,0.0000000,180.0000000,90.0000000) --
createTrain(2180,2023.6000000,2238.1000000,2106.7000000,0.0000000,180.0000000,90.0000000) --
createTrain(2180,2023.6000000,2240.1000000,2106.7000000,0.0000000,180.0000000,90.0000000) --
createTrain(2180,2023.6000000,2242.1000000,2106.7000000,0.0000000,180.0000000,90.0000000) --
createTrain(2180,2023.6000000,2244.1000000,2106.7000000,0.0000000,180.0000000,90.0000000) --
createTrain(2180,2023.6000000,2246.1000000,2106.7000000,0.0000000,180.0000000,90.0000000) --
createTrain(2180,2023.6000000,2248.1000000,2106.7000000,0.0000000,180.0000000,90.0000000) --
createTrain(2180,2020.3000000,2235.1000000,2106.7000000,0.0000000,180.0000000,270.0000000) --
createTrain(2180,2020.3000000,2237.1000000,2106.7000000,0.0000000,180.0000000,270.0000000) --
createTrain(2180,2020.3000000,2239.1000000,2106.7000000,0.0000000,180.0000000,270.0000000) --
createTrain(2180,2020.3000000,2241.1000000,2106.7000000,0.0000000,180.0000000,270.0000000) --
createTrain(2180,2020.3000000,2243.1000000,2106.7000000,0.0000000,180.0000000,270.0000000) --
createTrain(2180,2020.3000000,2245.1000000,2106.7000000,0.0000000,180.0000000,270.0000000) --
createTrain(2674,2023.4000000,2238.3000000,2102.9000000,0.0000000,0.0000000,600.0000000) --
createTrain(2674,2020.4000000,2242.3000000,2102.9000000,0.0000000,0.0000000,600.0000000) --
createTrain(2674,2023.4000000,2246.3000000,2102.9000000,0.0000000,0.0000000,600.0000000) --
createTrain(14405,2022.0000000,2242.1000000,2103.5000000,0.0000000,0.0000000,540.0000000) --
createTrain(14405,2022.0000000,2243.6000000,2103.5000000,0.0000000,0.0000000,180.0000000) --
createTrain(14405,2022.0000000,2245.1000000,2103.5000000,0.0000000,0.0000000,180.0000000) --
createTrain(14405,2022.0000000,2246.6000000,2103.5000000,0.0000000,0.0000000,180.0000000) --
createTrain(14405,2022.0000000,2248.1000000,2103.5000000,0.0000000,0.0000000,180.0000000) --
createTrain(14405,2022.0000000,2249.6000000,2103.5000000,0.0000000,0.0000000,180.0000000) --
createTrain(14405,2022.0000000,2251.1000000,2103.5000000,0.0000000,0.0000000,180.0000000) --
createTrain(14405,2024.6000000,2242.1000000,2103.5000000,0.0000000,0.0000000,180.0000000) --
createTrain(14405,2024.6000000,2243.6000000,2103.5000000,0.0000000,0.0000000,180.0000000) --
createTrain(14405,2024.6000000,2245.1000000,2103.5000000,0.0000000,0.0000000,180.0000000) --
createTrain(14405,2024.6000000,2246.6000000,2103.5000000,0.0000000,0.0000000,180.0000000) --
createTrain(14405,2024.6000000,2248.1000000,2103.5000000,0.0000000,0.0000000,180.0000000) --
createTrain(14405,2024.6000000,2249.6000000,2103.5000000,0.0000000,0.0000000,180.0000000) --
createTrain(14405,2024.6000000,2251.1000000,2103.5000000,0.0000000,0.0000000,180.0000000) --
createTrain(14405,2019.4000000,2242.1000000,2103.5000000,0.0000000,0.0000000,180.0000000) --
createTrain(14405,2019.4000000,2243.6000000,2103.5000000,0.0000000,0.0000000,180.0000000) --
createTrain(14405,2019.4000000,2245.1000000,2103.5000000,0.0000000,0.0000000,180.0000000) --
createTrain(14405,2019.4000000,2246.6000000,2103.5000000,0.0000000,0.0000000,180.0000000) --
createTrain(14405,2019.4000000,2248.1000000,2103.5000000,0.0000000,0.0000000,180.0000000) --
createTrain(14405,2019.4000000,2249.6000000,2103.5000000,0.0000000,0.0000000,180.0000000) --
createTrain(14405,2019.4000000,2251.1000000,2103.5000000,0.0000000,0.0000000,180.0000000) --
createTrain(14405,2022.0000000,2253.6000000,2104.0000000,-6.0000000,0.0000000,180.0000000) --
createTrain(14405,2021.1000000,2253.6000000,2104.0000000,-6.0000000,0.0000000,180.0000000) --
createTrain(14405,2024.6000000,2253.6000000,2103.5000000,0.0000000,0.0000000,180.0000000) --
createTrain(2674,2020.4000000,2235.7000000,2102.9000000,0.0000000,0.0000000,52.0000000) --
createTrain(2673,2020.4000000,2246.7000000,2102.9000000,0.0000000,0.0000000,270.0000000) --
createTrain(2700,2023.5000000,2235.1000000,2105.5000000,180.0000000,-4.0000000,90.0000000) --
createTrain(2700,2020.4000000,2235.1000000,2105.5000000,180.0000000,0.0000000,90.0000000) --
createTrain(2700,2023.5000000,2242.1000000,2105.5000000,180.0000000,-4.0000000,90.0000000) --
createTrain(2700,2020.4000000,2242.1000000,2105.5000000,180.0000000,0.0000000,90.0000000) --
createTrain(1799,2023.1000000,2234.2000000,2105.7000000,270.0000000,0.0000000,360.0000000) --
createTrain(1799,2019.8000000,2234.2000000,2105.7000000,270.0000000,0.0000000,0.0000000) --
createTrain(1538,2022.7000000,2234.7000000,2102.8000000,0.0000000,0.0000000,180.0000000) --
createTrain(1799,2022.1000000,2234.2000000,2106.1000000,720.0000000,90.0000000,450.0000000) --
createTrain(1799,2021.8000000,2234.2000000,2105.1000000,0.0000000,270.0000000,270.0000000) --
createTrain(1799,2022.1000000,2234.2000000,2107.3000000,0.0000000,90.0000000,90.0000000) --
createTrain(1799,2021.6000000,2234.2000000,2106.3000000,0.0000000,270.0000000,270.0000000) --
createTrain(1799,2022.3000000,2234.2000000,2104.3000000,90.0000000,0.0000000,180.0000000) --

setTimer(loadCiv,3000,1)
