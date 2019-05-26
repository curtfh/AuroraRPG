
local DXMessages = {}
local DXNoteSorted = {}

local sX,sY = guiGetScreenSize()
local aX,aY = (sX*0.50), (sY*0.88)
local font = "default-bold"


local Z_OFFSET = -25	-- Distance between Messages
local VEH_OFFSET = 85	-- Offset of Vehicle HUD
local ALPHA = 255		-- Shadow Alpha

-- Draw Message
--------------------->>

function addNote(id, text, r, g, b, timer)
	if not id then id = "Note" end
	if (type(id) ~= "string") then return end
	if not timer then timer = 5000 end
	if (not text or text == "") then
		DXMessages[id] = nil
		for i,v in ipairs(DXNoteSorted) do
			if (v == id) then
				table.remove(DXNoteSorted, i)
				break
			end
		end
		return true
	end

	if (type(text) ~= "string" or type(r) ~= "number" or type(g) ~= "number" or type(b) ~= "number") then return false end
	if (timer and type(timer) ~= "number") then return false end
	if (r > 255 or g > 255 or b > 255) then return false end

	local iNotes = #DXNoteSorted

	if (not DXMessages[id]) then
		DXMessages[id] = {text, r, g, b}
		if (timer) then
			local tick = getTickCount()+timer
			DXMessages[id][5] = tick
		end
		table.insert(DXNoteSorted, id)
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

	if (iNotes == 0) then
		addEventHandler("onClientRender", root, renderDXMessage)
	end
	playSoundFrontEnd(11)
	return true
end
addEvent("addNote", true)
addEventHandler("addNote", root, addNote)

-- Render Message
----------------------->>

function renderDXMessage()
	if (isPlayerMapVisible()) then return end
	if exports.server:isPlayerLoggedIn(localPlayer) then
		if (#DXNoteSorted == 0) then
			removeEventHandler("onClientRender", root, renderDXMessage)
		end

		for i,id in ipairs(DXNoteSorted) do
			local v = DXMessages[id]
			if (not v[5] or v[5] > getTickCount()) then
				local shadow = string.gsub(v[1], "#%x%x%x%x%x%x", "")
				local x,y = aX, aY+( (i-1)*Z_OFFSET)
				if (isPedInVehicle(localPlayer)) then y = y - VEH_OFFSET end
				dxDrawText(shadow, x-1, y+1, x+1, y+1, tocolor(0, 0, 0, ALPHA), 1, font, "center", "bottom", false, false, false, false, true)
				dxDrawText(shadow, x+1, y+1, x+1, y+1, tocolor(0, 0, 0, ALPHA), 1, font, "center", "bottom", false, false, false, false, true)
				dxDrawText(v[1], x, y, x, y, tocolor(v[2], v[3], v[4], 255), 1, font, "center", "bottom", false, false, false, true, true)
			else
				DXMessages[id] = nil
				table.remove(DXNoteSorted, i)
			end
		end
	end
end

