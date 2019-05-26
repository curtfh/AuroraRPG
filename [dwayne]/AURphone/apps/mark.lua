local trackPlayer = {}

local labels = {}
------------------------------------
-- Window
------------------------------------
function openTrackerMode()
	if not trackPlayer[1] then trackPlayer[1] = guiCreateGridList(BGX, BGY+5, 0.99770569801331*BGWidth, 0.80*BGHeight, false) end
	if not trackPlayer[2] then trackPlayer[2] = guiGridListAddColumn(trackPlayer[1], "Player", 0.9) end
    if not trackPlayer[3] then trackPlayer[3] = guiCreateButton(BGX+(BGWidth*0.0), BGY+(0.930*BGHeight), 0.50*BGWidth, 0.068*BGHeight, "Toggle blip", false) end
    if not trackPlayer[4] then trackPlayer[4] = guiCreateButton(BGX+(BGWidth*0.50), BGY+(0.930*BGHeight), 0.50*BGWidth, 0.068*BGHeight, "Refresh list", false) end
	if not trackPlayer[5] then trackPlayer[5] = guiCreateEdit(BGX+(BGWidth*0.50), BGY+(0.850*BGHeight), 0.50*BGWidth, 0.075*BGHeight, "", false) end
	if not trackPlayer[6] then trackPlayer[6] = guiCreateButton(BGX+(BGWidth*0.0), BGY+(0.850*BGHeight), 0.50*BGWidth, 0.068*BGHeight, "Remove Blips", false) end
    addEventHandler ("onClientGUIClick", trackPlayer[3], trackBu)
	addEventHandler("onClientGUIClick", trackPlayer[4], openplayersMarkWindow)
	addEventHandler("onClientGUIClick", trackPlayer[6], tr)
	addEventHandler ("onClientGUIChanged", trackPlayer[5], playerGridsSearch)
    openplayersMarkWindow(playersMark)
			guiSetVisible ( trackPlayer[1], true )
			guiSetProperty ( trackPlayer[1], "AlwaysOnTop", "True" )
			guiSetVisible ( trackPlayer[3], true )
			guiSetProperty ( trackPlayer[3], "AlwaysOnTop", "True" )
			guiSetVisible ( trackPlayer[4], true )
			guiSetProperty ( trackPlayer[4], "AlwaysOnTop", "True" )
			guiSetVisible ( trackPlayer[5], true )
			guiSetVisible ( trackPlayer[6], true )
			guiSetProperty ( trackPlayer[5], "AlwaysOnTop", "True" )
			guiSetProperty ( trackPlayer[6], "AlwaysOnTop", "True" )
	apps[17][7] = true
end
apps[17][8] = openTrackerMode

function closeTracks()
    removeEventHandler ("onClientGUIClick", trackPlayer[3], trackBu)
	removeEventHandler("onClientGUIClick", trackPlayer[4], openplayersMarkWindow)
	removeEventHandler("onClientGUIClick", trackPlayer[6], tr)
	removeEventHandler ("onClientGUIChanged", trackPlayer[5], playerGridsSearch)

			guiSetVisible ( trackPlayer[1], false )
			guiSetProperty ( trackPlayer[1], "AlwaysOnTop", "False" )
			guiSetVisible ( trackPlayer[3], false )
			guiSetProperty ( trackPlayer[3], "AlwaysOnTop", "False" )
			guiSetVisible ( trackPlayer[4], false )
			guiSetProperty ( trackPlayer[4], "AlwaysOnTop", "False" )
			guiSetVisible ( trackPlayer[5], false )
			guiSetVisible ( trackPlayer[6], false )
			guiSetProperty ( trackPlayer[5], "AlwaysOnTop", "False" )
			guiSetProperty ( trackPlayer[6], "AlwaysOnTop", "False" )


	apps[17][7] = false
end
apps[17][9] = closeTracks
pblip = {}
boxes = {}
function trackBu(btn)
	local row,col = guiGridListGetSelectedItem( trackPlayer[1] )
	local rec = guiGridListGetItemText(trackPlayer[1], row, col )
	local recPlayer = getPlayerFromName( rec )
	if isElement( recPlayer ) and getElementType( recPlayer ) == "player" then
		if isElement(pblip[recPlayer]) then
			destroyElement(pblip[recPlayer])
			exports.NGCdxmsg:createNewDxMessage("Blip removed from "..getPlayerName(recPlayer),255,0,0)
		else
			x, y = getElementPosition(recPlayer)
			if getElementAlpha(recPlayer) < 100 then exports.NGCdxmsg:createNewDxMessage("Blip can't be added for "..getPlayerName(recPlayer),255,0,0) return false end
			pblip[recPlayer] = createBlipAttachedTo(recPlayer,59)
			table.insert(boxes,pblip[recPlayer])
			exports.NGCdxmsg:createNewDxMessage("Blip added to "..getPlayerName(recPlayer),255,255,0)
		end
	end
end

function getPlayerFromPartialName(name)
    local name = name and name:gsub("#%x%x%x%x%x%x", ""):lower() or nil
    if name then
        for _, player in ipairs(getElementsByType("player")) do
            local name_ = getPlayerName(player):gsub("#%x%x%x%x%x%x", ""):lower()
            if name_:find(name, 1, true) then
                return player
            end
        end
    end
end

function markCommand (cmd, plrt)
	local target = getPlayerFromPartialName(plrt)
	if (target) then 
		if isElement(pblip[target]) then
			destroyElement(pblip[target])
			exports.NGCdxmsg:createNewDxMessage("Blip removed from "..getPlayerName(target),255,0,0)
			closeMarkWindow()
		else
			x, y = getElementPosition(target)
			if getElementAlpha(target) < 100 then exports.NGCdxmsg:createNewDxMessage("Blip can't be added for "..getPlayerName(target),255,0,0) return false end
			pblip[target] = createBlipAttachedTo(target,59)
			table.insert(boxes,pblip[target])
			exports.NGCdxmsg:createNewDxMessage("Blip added to "..getPlayerName(target),255,255,0)
			addEventHandler("onClientPlayerQuit", target, removeMarkedBlip)
			markWindow(target)
		end
	else 
		exports.NGCdxmsg:createNewDxMessage("Player name cannot found.",255,0,0)
	end 
end 
addCommandHandler("mark", markCommand)
function tr()
	for k,v in ipairs(boxes) do
		if isElement(v) then destroyElement(v) end
		pblip = {}
	end
end

function removeMarkedBlip()
	if isElement( pblip[source] ) then
		destroyElement(pblip[source])
		pblip[source] = nil
	end
end

setTimer(
	function ()
		for k, v in ipairs(getElementsByType("player")) do
			if isElement( pblip[v] ) and (getElementAlpha(v) == 0) then
				destroyElement(pblip[v])
				pblip[v] = nil
			end
		end
	end
, 1000, 0)

local userDefinedplayersMark = false

function openplayersMarkWindow(playersMark)
	guiGridListClear(trackPlayer[1])
	for key, player in ipairs(getElementsByType("player")) do
		pname = getPlayerName(player)
		--if (pname ~= getPlayerName(localPlayer)) then   -- localPlayer
			local row = guiGridListAddRow(trackPlayer[1])
			guiGridListSetItemText(trackPlayer[1], row, trackPlayer[2], getPlayerName(player), false, false)
		--send
	end
	guiSetVisible(trackPlayer[1], true)
	showCursor(true)
end
addEvent("openplayersMarkWindow", true)
addEventHandler("openplayersMarkWindow", root, openplayersMarkWindow)

function updatePlayerGridsOnJoin()
	if trackPlayer[5] and (guiGetText(trackPlayer[5]) == "") then
		local row = guiGridListAddRow(trackPlayer[1])
		guiGridListSetItemText(trackPlayer[1], row, trackPlayer[2], getPlayerName(source), false, false)
	end
end
addEventHandler("onClientPlayerJoin", root, updatePlayerGridsOnJoin)

function playerGridsSearch()

	if (source == trackPlayer[5]) then
		guiGridListClear (trackPlayer[1])
		local text = guiGetText(trackPlayer[5])
		if (text == "") then
			for key, player in ipairs (getElementsByType("player")) do
				local name = getPlayerName(player)
				if (name ~= getPlayerName(localPlayer)) then    ---- not local
					local row = guiGridListAddRow (trackPlayer[1])
					guiGridListSetItemText(trackPlayer[1], row, trackPlayer[2], getPlayerName(player), false, false)
				end
			end
		else
			for key, player in ipairs (getElementsByType("player")) do
				if (string.find(string.upper(getPlayerName(player)), string.upper(text), 1, true)) then
					local name = getPlayerName(player)
					if (name ~= getPlayerName(localPlayer)) then  -- not local
						local row = guiGridListAddRow (trackPlayer[1])
						guiGridListSetItemText(trackPlayer[1], row, trackPlayer[2], getPlayerName(player), false, false)
					end
				end
			end
		end
    end
end

function closeMarkWindow()
	if (not mainMarkWindow) then
		return false
	end
	removeEventHandler("onClientKey", root, closeWindowKey)
	if (guiGetVisible(mainMarkWindow)) then
		guiSetVisible(mainMarkWindow, false)
	end
end

function closeWindowKey(button)
	if (button == "lalt" or button == "ralt") then	
		closeMarkWindow()
	end
end

function markWindow(plr)
	local plrName = string.gsub(getPlayerName (plr), "#%x%x%x%x%x%x", "")
	local mx, my, mz = getElementPosition(plr)
	local you = localPlayer
	local px, py, pz = getElementPosition(you)	
	local dis = getDistanceBetweenPoints3D(mx, my, mz, px, py, pz)
	local zone = getZoneName(mx, my, mz)
	local city = getZoneName(mx, my, mz, true)
	local money = getPlayerMoney(plrName)
	local isInVeh = isPlayerInVehicle(plr)
	exports.NGCdxmsg:createNewDxMessage("Window opened, press alt to close it.", 255, 255, 255, true)
	mainMarkWindow = guiCreateWindow(0.68, 0.36, 0.31, 0.32, "mainMarkWindow for "..plrName.."!", true)
	guiWindowSetSizable(mainMarkWindow, false)
	markWindowTabP = guiCreateTabPanel(0.03, 0.11, 0.94, 0.81, true, mainMarkWindow)
	markSystemTab = guiCreateTab("AuroraRPG Mark system", markWindowTabP)
	streetInfoLabel = guiCreateLabel(0.03, 0.52, 0.40, 0.09, "Street: "..zone, true,markSystemTab)
	guiSetFont(streetInfoLabel, "default-bold-small")  
	cityInfoLabel = guiCreateLabel(0.03, 0.74, 0.41, 0.09, "City: "..city, true, markSystemTab)
	guiSetFont(cityInfoLabel, "default-bold-small")  
	moneyInfoLabel = guiCreateLabel(0.52, 0.52, 0.43, 0.09, "Money: "..money.."$", true, markSystemTab)
	guiSetFont(moneyInfoLabel, "default-bold-small")  
	if (dis == 0) then
		playerNameLabel = guiCreateLabel(0.03, 0.09, 0.43, 0.09, "Player: You", true, markSystemTab)
		guiSetFont(playerNameLabel, "default-bold-small")  
		playerDistanceLabel = guiCreateLabel(0.52, 0.30, 0.43, 0.10, "Distance: None", true, markSystemTab)
		guiSetFont(playerDistanceLabel, "default-bold-small")  
	else	
		playerNameLabel = guiCreateLabel(0.03, 0.09, 0.43, 0.09, "Player: "..plrName, true, markSystemTab)
		guiSetFont(playerNameLabel, "default-bold-small")  
		playerDistanceLabel = guiCreateLabel(0.52, 0.30, 0.43, 0.10, "Distance: "..dis.." m", true, markSystemTab)
		guiSetFont(playerDistanceLabel, "default-bold-small")  
	end
	if (isInVeh) then
		vehicleStateLabel = guiCreateLabel(0.03, 0.30, 0.40, 0.10, "State: In a car", true, markSystemTab)
		guiSetFont(vehicleStateLabel, "default-bold-small")  
	else
		vehicleStateLabel = guiCreateLabel(0.03, 0.30, 0.40, 0.10, "State: Not in a car", true, markSystemTab)
		guiSetFont(vehicleStateLabel, "default-bold-small")  
	end
	removeEventHandler("onClientKey", root, closeWindowKey)
	addEventHandler("onClientKey", root, closeWindowKey)
end

function onPlayerGPS()

openTrackerMode()

end