GUIEditor = {
    edit = {},
    button = {},
    window = {},
    label = {},
    gridlist = {}
}
local screenW, screenH = guiGetScreenSize()
local localElements = {}
local allowedRooms = {[5001]=true,[5002]=true,[5003]=true,[5004]=true}

function openGUI ()
	if (isElement(GUIEditor.window[1])) then 
		destroyElement(GUIEditor.window[1])
		killTimer(localElements["antiCursorBug"])
		showCursor(false)
		return 
	end 
	if (localElements["assignedRoomS"] == true) then 
		if (allowedRooms[getElementDimension(localPlayer)]) then 
				localElements["assignedRoom"] = getElementDimension(localPlayer) 
			else
				return 
		end
	end
	
	if (localElements["assignedRoom"] ~= getElementDimension(localPlayer)) then return end 
	GUIEditor.window[1] = guiCreateWindow((screenW - 818) / 2, (screenH - 506) / 2, 818, 506, "Aurora - Mini-Games Moderator", false)
	guiWindowSetSizable(GUIEditor.window[1], false)

	GUIEditor.label[1] = guiCreateLabel(18, 29, 286, 15, "Current Room Assigned: "..localElements["assignedRoom"], false, GUIEditor.window[1])
	guiSetFont(GUIEditor.label[1], "default-bold-small")
	GUIEditor.gridlist[1] = guiCreateGridList(11, 52, 249, 444, false, GUIEditor.window[1])
	guiGridListAddColumn(GUIEditor.gridlist[1], "Player", 0.9)
	GUIEditor.label[2] = guiCreateLabel(272, 81, 315, 15, "Player Name:", false, GUIEditor.window[1])
	guiSetFont(GUIEditor.label[2], "default-bold-small")
	GUIEditor.label[3] = guiCreateLabel(272, 106, 315, 15, "Alive:", false, GUIEditor.window[1])
	guiSetFont(GUIEditor.label[3], "default-bold-small")
	GUIEditor.label[4] = guiCreateLabel(272, 131, 315, 15, "Level: ", false, GUIEditor.window[1])
	guiSetFont(GUIEditor.label[4], "default-bold-small")
	GUIEditor.label[5] = guiCreateLabel(272, 156, 315, 15, "VIP:", false, GUIEditor.window[1])
	guiSetFont(GUIEditor.label[5], "default-bold-small")
	GUIEditor.label[6] = guiCreateLabel(272, 181, 315, 15, "State:", false, GUIEditor.window[1])
	guiSetFont(GUIEditor.label[6], "default-bold-small")
	GUIEditor.button[1] = guiCreateButton(692, 471, 104, 25, "Close", false, GUIEditor.window[1])
	GUIEditor.label[7] = guiCreateLabel(264, 204, 544, 15, "_________________________________________________________________________________________________________________________________________________", false, GUIEditor.window[1])
	guiSetFont(GUIEditor.label[7], "default-bold-small")
	guiLabelSetColor(GUIEditor.label[7], 127, 127, 127)
	GUIEditor.button[2] = guiCreateButton(597, 76, 92, 30, "Kick Player", false, GUIEditor.window[1])
	GUIEditor.button[3] = guiCreateButton(703, 116, 92, 30, "Slap Player", false, GUIEditor.window[1])
	GUIEditor.button[4] = guiCreateButton(703, 76, 92, 30, "Fix Vehicle", false, GUIEditor.window[1])
	GUIEditor.gridlist[2] = guiCreateGridList(268, 224, 188, 272, false, GUIEditor.window[1])
	guiGridListAddColumn(GUIEditor.gridlist[2], "List Maps", 0.9)
	GUIEditor.button[5] = guiCreateButton(464, 243, 106, 32, "Queue for next map", false, GUIEditor.window[1])
	GUIEditor.button[6] = guiCreateButton(464, 285, 106, 32, "Skip Map", false, GUIEditor.window[1])
	GUIEditor.button[7] = guiCreateButton(464, 327, 106, 49, "Skip the current one and start this selected map", false, GUIEditor.window[1])
	GUIEditor.label[8] = guiCreateLabel(272, 56, 315, 15, "Current Players:", false, GUIEditor.window[1])
	guiSetFont(GUIEditor.label[8], "default-bold-small")
	GUIEditor.button[8] = guiCreateButton(597, 116, 92, 30, "Mute Player", false, GUIEditor.window[1])
	GUIEditor.edit[1] = guiCreateEdit(594, 169, 201, 25, "", false, GUIEditor.window[1])
	guiEditSetMaxLength(GUIEditor.edit[1], 5000)
	GUIEditor.label[9] = guiCreateLabel(597, 151, 193, 15, "Type the reason:", false, GUIEditor.window[1])
	guiSetFont(GUIEditor.label[9], "default-bold-small")
	guiLabelSetHorizontalAlign(GUIEditor.label[9], "center", false)    
	guiSetEnabled(GUIEditor.button[2], false)
	guiSetEnabled(GUIEditor.button[3], false)
	guiSetEnabled(GUIEditor.button[4], false)
	guiSetEnabled(GUIEditor.button[8], false)
	guiSetEnabled(GUIEditor.button[5], false)
	guiSetEnabled(GUIEditor.button[6], false)
	guiSetEnabled(GUIEditor.button[7], false)
	showCursor(true)
	
	
	localElements["antiCursorBug"] = setTimer(function() 
		if (isElement(GUIEditor.window[1])) then 
			if (not isCursorShowing()) then
				showCursor(true)
			end 
		end 
	end, 500, 0)
	
	addEventHandler( "onClientGUIClick", GUIEditor.button[1], function() 
		if (GUIEditor.button[1] ~= source) then return end 
		openGUI()
	end)
	
	addEventHandler( "onClientGUIClick", GUIEditor.button[3], function() 
	if (GUIEditor.button[3] ~= source) then return end 
		local thePlayer = getElementData(GUIEditor.button[2], "player")
		if (isElement(thePlayer) and getElementDimension(thePlayer) == localElements["assignedRoom"]) then 
			triggerServerEvent("AURroom_admin.slapPlayer",resourceRoot,thePlayer)
			triggerServerEvent("AURroom_admin.messageToDim", resourceRoot, localElements["assignedRoom"], getPlayerName(localPlayer).." slapped "..getPlayerName(thePlayer).." ("..guiGetText(GUIEditor.edit[1])..")")
			updatePlayerList(localElements["assignedRoom"])
		end 
	end)
	
	addEventHandler( "onClientGUIClick", GUIEditor.button[4], function() 
	if (GUIEditor.button[4] ~= source) then return end 
		local thePlayer = getElementData(GUIEditor.button[2], "player")
		if (isElement(thePlayer) and getElementDimension(thePlayer) == localElements["assignedRoom"]) then 
			triggerServerEvent("AURroom_admin.fixVeh",resourceRoot,thePlayer)
			triggerServerEvent("AURroom_admin.messageToDim", resourceRoot, localElements["assignedRoom"], getPlayerName(localPlayer).." fixed "..getPlayerName(thePlayer).."'s vehicle ("..guiGetText(GUIEditor.edit[1])..")")
			updatePlayerList(localElements["assignedRoom"])
		end 
	end)
	
	addEventHandler( "onClientGUIClick", GUIEditor.button[2], function() 
	if (GUIEditor.button[2] ~= source) then return end 
		local thePlayer = getElementData(GUIEditor.button[2], "player")
		if (isElement(thePlayer) and getElementDimension(thePlayer) == localElements["assignedRoom"]) then 
			if getElementDimension(thePlayer) == 5001 then
				triggerServerEvent("quitShooterRoom",thePlayer)
				triggerServerEvent("AURroom_admin.messageToDim", resourceRoot, localElements["assignedRoom"], getPlayerName(localPlayer).." kicked "..getPlayerName(thePlayer).." from this room ("..guiGetText(GUIEditor.edit[1])..")")
			elseif getElementDimension(thePlayer) == 5002 then
				triggerServerEvent("quitDDRoom",thePlayer)
				triggerServerEvent("AURroom_admin.messageToDim", resourceRoot, localElements["assignedRoom"], getPlayerName(localPlayer).." kicked "..getPlayerName(thePlayer).." from this room ("..guiGetText(GUIEditor.edit[1])..")")
			elseif getElementDimension(thePlayer) == 5004 then
				triggerServerEvent("quitDMRoom",thePlayer)
				triggerServerEvent("AURroom_admin.messageToDim", resourceRoot, localElements["assignedRoom"], getPlayerName(localPlayer).." kicked "..getPlayerName(thePlayer).." from this room ("..guiGetText(GUIEditor.edit[1])..")")
			elseif getElementDimension(thePlayer) == 5003 then
				triggerServerEvent("quitCSGORoom",thePlayer)
				triggerServerEvent("AURroom_admin.messageToDim", resourceRoot, localElements["assignedRoom"], getPlayerName(localPlayer).." kicked "..getPlayerName(thePlayer).." from this room ("..guiGetText(GUIEditor.edit[1])..")")
			else
				exports.NGCdxmsg:createNewDxMessage("Current player is not in the room.",255,0,0)
			end
			updatePlayerList(localElements["assignedRoom"])
		end 
	end)
	
	
	addEventHandler( "onClientGUIClick", GUIEditor.gridlist[1], function(btn) 
	if (GUIEditor.gridlist[1] ~= source) then return end 
	if btn ~= 'left' then return false end 
	  local row, col = guiGridListGetSelectedItem(source) 
		  if row >= 0 and col >= 0 then 
				local player = guiGridListGetItemText(source, row, 1)
				player = getPlayerFromName(player)
				if (player) then 
					if (getElementDimension(player) == localElements["assignedRoom"]) then 
						local veh = getPedOccupiedVehicle(player)
						guiSetText(GUIEditor.label[2], "Player Name: "..getPlayerName(player))
						if (veh and isElement(veh)) then
							guiSetText(GUIEditor.label[3], "Alive: Yes")
						else
							guiSetText(GUIEditor.label[3], "Alive: No")
						end 
						guiSetText(GUIEditor.label[4], "Level: "..getElementData(player, "playerLevel").." ("..getElementData(player, "playerXP").." XPs)")
						if (getElementData(player, "VIP") == "Yes") then 
							guiSetText(GUIEditor.label[5], "VIP: Yes")
						else
							guiSetText(GUIEditor.label[5], "VIP: No")
						end 
						
						if (veh and isElement(veh)) then
							guiSetText(GUIEditor.label[6], "State: Playing")
						else
							guiSetText(GUIEditor.label[6], "State: Waiting")
						end 
						
						setElementData(GUIEditor.button[2], "player", player)
						setElementData(GUIEditor.button[3], "player", player)
						setElementData(GUIEditor.button[4], "player", player)
						guiSetEnabled(GUIEditor.button[2], true)
						guiSetEnabled(GUIEditor.button[3], true)
						guiSetEnabled(GUIEditor.button[4], true)
					end
				else
					guiSetText(GUIEditor.label[2], "Player Name:")
					guiSetText(GUIEditor.label[3], "Alive:")
					guiSetText(GUIEditor.label[4], "Level:")
					guiSetText(GUIEditor.label[5], "VIP:")
					guiSetText(GUIEditor.label[6], "State:")
					updatePlayerList(localElements["assignedRoom"])
					
					setElementData(GUIEditor.button[2], "player", nil)
					setElementData(GUIEditor.button[3], "player", nil)
					setElementData(GUIEditor.button[4], "player", nil)
					guiSetEnabled(GUIEditor.button[2], false)
					guiSetEnabled(GUIEditor.button[3], false)
					guiSetEnabled(GUIEditor.button[4], false)
					guiSetEnabled(GUIEditor.button[8], false)
				end 
			else
				guiSetText(GUIEditor.label[2], "Player Name:")
				guiSetText(GUIEditor.label[3], "Alive:")
				guiSetText(GUIEditor.label[4], "Level:")
				guiSetText(GUIEditor.label[5], "VIP:")
				guiSetText(GUIEditor.label[6], "State:")
				updatePlayerList(localElements["assignedRoom"])
				
				setElementData(GUIEditor.button[2], "player", nil)
				setElementData(GUIEditor.button[3], "player", nil)
				setElementData(GUIEditor.button[4], "player", nil)
				guiSetEnabled(GUIEditor.button[2], false)
				guiSetEnabled(GUIEditor.button[3], false)
				guiSetEnabled(GUIEditor.button[4], false)
				guiSetEnabled(GUIEditor.button[8], false)
		  end 
	end) 
	
	updatePlayerList(localElements["assignedRoom"])
end

function addCommandOrBinds(theType, assignedDim)
	if (theType == "staff") then 
		addCommandHandler("roomadmin", openGUI)
		--outputDebugString("Open roomadmin")
		localElements["assignedRoom"] = 0
		localElements["assignedRoomS"] = true
	elseif (theType == "mod") then 
		bindKey ("P", "down", openGUI) 
		addCommandHandler("roomadmin", openGUI)
		if (type(assignedDim) == "number") then 
			localElements["assignedRoom"] = assignedDim
		end
		--outputDebugString("Open roomadmin")
		localElements["assignedRoomS"] = false
	end 
end 
addEvent("AURroom_admin.addCommandOrBinds", true)
addEventHandler("AURroom_admin.addCommandOrBinds", resourceRoot, addCommandOrBinds)

function updatePlayerList(theRoom)
	if (not isElement(GUIEditor.window[1])) then return end 
	guiGridListClear(GUIEditor.gridlist[1])
	guiSetText(GUIEditor.label[2], "Player Name:")
	guiSetText(GUIEditor.label[3], "Alive:")
	guiSetText(GUIEditor.label[4], "Level:")
	guiSetText(GUIEditor.label[5], "VIP:")
	guiSetText(GUIEditor.label[6], "State:")
	
	setElementData(GUIEditor.button[2], "player", nil)
	setElementData(GUIEditor.button[3], "player", nil)
	setElementData(GUIEditor.button[4], "player", nil)
	guiSetEnabled(GUIEditor.button[2], false)
	guiSetEnabled(GUIEditor.button[3], false)
	guiSetEnabled(GUIEditor.button[4], false)
	guiSetEnabled(GUIEditor.button[8], false)
	
	for k, thePlayer in ipairs ( getElementsByType( "player" ) ) do
		if (getElementDimension(thePlayer) == theRoom) then
			guiGridListAddRow(GUIEditor.gridlist[1], getPlayerName(thePlayer))
		end
	end
	
end 

addEventHandler( "onClientResourceStart", getRootElement(), function ()
	triggerServerEvent ("AURroom_admin.requestUpdate", resourceRoot, getLocalPlayer())
end)

if (fileExists("client.lua")) then fileDelete("client.lua") end