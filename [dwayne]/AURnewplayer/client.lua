local rx, ry = guiGetScreenSize()
local nX, nY = 1366, 768
local sX, sY = guiGetScreenSize()

displayedInfo = {
	[1] = "Welcome to AuroraRPG",
	[2] = "LS: CnR SF: Civilian LV: Mafia Wars",
	[3] = "New here? You can start Turfing as criminal robbing houses/stores and more",
	[4] = "To join multigames rooms do /room and to back to CnR, from the multigames panel click on CnR",
	[5] = "Remember that deathmatching is only allowed in LV",
	[6] = "You can be a criminal from red circle blip on the map",
	[7] = "To be a cop go to a Police Department and arrested wanted criminals anywhere in SA",
	[8] = "To work as a civilian, go to SF and go to the yellow circles in your map, those are jobs",
	[9] = "Need money? Find a job to earn money mark the location by typing N > Maps",
	[10] = "Cars can be bought at a shop with a vehicle or bike blip on the map",
	[11] = "Become a medic by going to any hospital and using the spray can",
	[12] = "In main, team,advert and support chats, use ONLY English!",
	[13] = "Want to be more involved? Register in forums.aurorarvg.com",
	[14] = "Staff members are identified with [AUR] tag",
	[15] = "You must know the rules! check them by pressing F1",
	[16] = "Don't insult,provoke,abuse or it will result in punishment",
	[17] = "Do you want to speak non-english? Press on J and select your country section" ,
	[18] = "If you have question just ask it on support channel Press J",
	[19] = "You can check game options in N > Settings",
	[20] = "To remove TIP you need to reach 10 hours of playtime or reach 5 hours then type /stoptip",
	[21] = "Thanks for reading this enjoy your stay",
	[22] = "Do you have more doubts? press F1 for our full info or use our support chat",
}

local count = 1
checkTimer = nil

function onStart()
	checkTimer = setTimer(function()
		local hours = getElementData(localPlayer,"playTime")
		if (not hours) or (hours and tonumber(hours) and math.floor(tonumber(hours)/ 60 ) <= 10) or getElementData(localPlayer,"isPlayerPrime") then
			count = count +1
			if count > 22 then
				count = 1
			end
			local text = displayedInfo[count]
			addTip("Info","Info : "..text,255,100,155, 8000)
		end
	end,15000,0)
end
addEventHandler("onClientResourceStart",resourceRoot,onStart)

addCommandHandler("stoptip",function()
	local hours = getElementData(localPlayer,"playTime")
	if (not hours) or (hours and tonumber(hours) and math.floor(tonumber(hours)/ 60 ) >= 5) or getElementData(localPlayer,"isPlayerPrime") then
		if isTimer(checkTimer) then killTimer(checkTimer) end
	end
end)


local DXMessages = {}
local DXTipSorted = {}

local sX,sY = guiGetScreenSize()
local aX,aY = (sX*0.55), (sY*0.95)
local font = "default-bold"


local Z_OFFSET = -25	-- Distance between Messages
local VEH_OFFSET = 85	-- Offset of Vehicle HUD
local ALPHA = 255		-- Shadow Alpha

-- Draw Message
--------------------->>

function addTip(id, text, r, g, b, timer)
	if not id then id = "Tip" end
	if (type(id) ~= "string") then return end
	if not timer then timer = 5000 end
	if (not text or text == "") then
		DXMessages[id] = nil
		for i,v in ipairs(DXTipSorted) do
			if (v == id) then
				table.remove(DXTipSorted, i)
				break
			end
		end
		return true
	end

	if (type(text) ~= "string" or type(r) ~= "number" or type(g) ~= "number" or type(b) ~= "number") then return false end
	if (timer and type(timer) ~= "number") then return false end
	if (r > 255 or g > 255 or b > 255) then return false end

	local iTips = #DXTipSorted

	if (not DXMessages[id]) then
		DXMessages[id] = {text, r, g, b}
		if (timer) then
			local tick = getTickCount()+timer
			DXMessages[id][5] = tick
		end
		table.insert(DXTipSorted, id)
	else
		DXMessages[id][1] = text
		DXMessages[id][2] = r
		DXMessages[id][3] = g
		DXMessages[id][4] = b
		if (timer) then
			local tick = getTickCount()+timer
			DXMessages[id][5] = tick
		end
	end

	if (iTips == 0) then
		addEventHandler("onClientRender", root, renderDXMessage)
	end
	playSoundFrontEnd(11)
	return true
end
addEvent("addTip", true)
addEventHandler("addTip", root, addTip)

-- Render Message
----------------------->>

function renderDXMessage()
	if (isPlayerMapVisible()) then return end
	if exports.server:isPlayerLoggedIn(localPlayer) then
		if (#DXTipSorted == 0) then
			removeEventHandler("onClientRender", root, renderDXMessage)
		end

		for i,id in ipairs(DXTipSorted) do
			local v = DXMessages[id]
			if (not v[5] or v[5] > getTickCount()) then
				local shadow = string.gsub(v[1], "#%x%x%x%x%x%x", "")
				local x,y = aX, aY+( (i-1)*Z_OFFSET)
				if (isPedInVehicle(localPlayer)) then y = y - VEH_OFFSET end
				dxDrawText(shadow, x-1, y+1, x+1, y+1, tocolor(0, 0, 0, ALPHA), 1, font, "center", "bottom", false, false, false, false, true)
				dxDrawText(shadow, x+1, y+1, x+1, y+1, tocolor(0, 0, 0, ALPHA), 1, font, "center", "bottom", false, false, false, false, true)
				dxDrawText(shadow, x-1, y-1, x+1, y+1, tocolor(0, 0, 0, ALPHA), 1, font, "center", "bottom", false, false, false, false, true)
				dxDrawText(shadow, x+1, y-1, x+1, y+1, tocolor(0, 0, 0, ALPHA), 1, font, "center", "bottom", false, false, false, false, true)
				dxDrawText(v[1], x, y, x, y, tocolor(v[2], v[3], v[4], 255), 1, font, "center", "bottom", false, false, false, true, true)
			else
				DXMessages[id] = nil
				table.remove(DXTipSorted, i)
			end
		end
	end
end

