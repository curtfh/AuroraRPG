local accessList = {
	["accountNAmhdfgfeLol"] = 5002,
	
}

function onModLoggsIn ()
	local accName = exports.server:getPlayerAccountName(source)
	if (accessList[accName]) then 
		triggerClientEvent(source, "AURroom_admin.addCommandOrBinds", resourceRoot, "mod", accessList[accName])
	elseif (exports.CSGstaff:isPlayerStaff(source)) then 
		triggerClientEvent(source, "AURroom_admin.addCommandOrBinds", resourceRoot, "staff")
	end 
end 
addEventHandler("onServerPlayerLogin", root, onModLoggsIn)

function outputTheMessageToDim (theDim, theMessage)
	for k, thePlayer in ipairs ( getElementsByType( "player" ) ) do
		if (getElementDimension(thePlayer) == theDim) then
			outputChatBox(theMessage, thePlayer, 255, 0, 0)
		end
	end
end 
addEvent("AURroom_admin.messageToDim", true)
addEventHandler("AURroom_admin.messageToDim", resourceRoot, outputTheMessageToDim)

function requestUpdate (thePlayer)
	local accName = exports.server:getPlayerAccountName(thePlayer)
	if (accessList[accName]) then 
		triggerClientEvent(thePlayer, "AURroom_admin.addCommandOrBinds", resourceRoot, "mod", accessList[accName])
		--outputDebugString(getPlayerName(thePlayer).." got access")
	elseif (exports.CSGstaff:isPlayerStaff(thePlayer)) then 
		triggerClientEvent(thePlayer, "AURroom_admin.addCommandOrBinds", resourceRoot, "staff")
	end 
end 
addEvent("AURroom_admin.requestUpdate", true)
addEventHandler("AURroom_admin.requestUpdate", resourceRoot, requestUpdate)

function slapThatShit (thePlayer)
	local veh = getPedOccupiedVehicle(thePlayer)
	if (veh) then 
		setElementHealth(veh, 200)
	end 
	
end 
addEvent("AURroom_admin.slapPlayer", true)
addEventHandler("AURroom_admin.slapPlayer", resourceRoot, slapThatShit)

function fixVeh (thePlayer)
	local veh = getPedOccupiedVehicle(thePlayer)
	if (veh) then 
		setElementHealth(veh, 1000)
	end 
	
end 
addEvent("AURroom_admin.fixVeh", true)
addEventHandler("AURroom_admin.fixVeh", resourceRoot, fixVeh)