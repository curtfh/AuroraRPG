
addEventHandler("onServerPlayerLogin",getRootElement(),
function ()
	local dTable = executeSQLQuery("SELECT * FROM AFK WHERE id=?",exports.server:getPlayerAccountID(source) )
	if dTable then
		for k,v in ipairs(dTable) do
			if v.id and v.id == exports.server:getPlayerAccountID(source) then
				if v.x and v.y and v.z then
					local t = {v.x,v.y,v.z}
					triggerClientEvent(source,"synceAFKLobby",source,exports.server:getPlayerAccountID(source))
					setElementData(source, "isPlayerAFK",true)
					setElementData(source, "AFK",t)
					setElementDimension(source,v.id)
					setElementPosition(source,1994.89,2471.92,10.89)
					triggerClientEvent(source, "setSpawnRotation",source,354)
					exports.NGCdxmsg:createNewDxMessage(source,"You have taken to AFK Lobby",255,255,0)
				end
			end
		end
	end
end)
--[[host = {}
addEventHandler("onPlayerSpawn",root,function()
	host[source] = setTimer(function(player)
		if player and isElement(player) then
			if (exports.server:getPlayerWantedPoints(player) >= 10) then return end
			if getPlayerTeam(player) and (getTeamName(getPlayerTeam(player)) == "Staff") then return end
			if (getElementData(player,"isPlayerAFK") ~= true) and (getPlayerIdleTime(player) > 60000) then
				if getElementDimension(player) == 0 then
					setPlayerAFK(player)
				end
			end
		end
	end,10000,1,source)
end)]]

addEventHandler("onPlayerWasted",root,function()
	local id = exports.server:getPlayerAccountID(source)
	executeSQLQuery("DELETE FROM AFK WHERE id=?",id)
	setElementData(source,"isPlayerAFK",false)
	setElementData(source,"AFK",false)
end)

addEvent("checkIdleTime",true)
addEventHandler("checkIdleTime",root,function(player)
	if (exports.server:getPlayerWantedPoints(player) >= 10) then return end
	if getPlayerTeam(player) and (getTeamName(getPlayerTeam(player)) == "Staff") then return end
	if (getElementData(player,"isPlayerAFK") ~= true) and (getPlayerIdleTime(player) > 60000) then
		if getElementDimension(player) == 0 then
			local x,y,z = getElementPosition(player)
			if z >= 8550 then
				setPlayerAFK(player)
			end
		end
	end
end)

function setPlayerAFK(player)
	local x,y,z = getElementPosition(player)
	local dim = exports.server:getPlayerAccountID(player)
	executeSQLQuery("INSERT INTO AFK( id,x,y,z) VALUES(?,?,?,?)",dim,x,y,z )
	local t = {x,y,z}
	triggerClientEvent(player,"synceAFKLobby",player,dim)
	setElementDimension(player,dim)
	setElementData(player, "isPlayerAFK",true)
	setElementData(player, "AFK",t)
	setElementPosition(player,1994.89,2471.92,10.89)
	triggerClientEvent(player, "setSpawnRotation", player,354)
	exports.NGCdxmsg:createNewDxMessage(player,"You have taken to AFK Lobby",255,255,0)
end


addEventHandler("onResourceStart",resourceRoot,function()
	executeSQLQuery("CREATE TABLE IF NOT EXISTS AFK (id INTEGER, x INTEGER, y INTEGER, z INTEGER)")
	outputDebugString("Creating AFK table")
	for k,player in ipairs(getElementsByType("player")) do
		if (getElementData(player,"isPlayerAFK") == true) then
			setElementData(player,"isPlayerAFK",false)
			local pack = getElementData(player, "AFK")
			if pack then
				local x,y,z = unpack(pack)
				setElementDimension(player,0)
				setElementPosition(player,x,y,z)
				local id = exports.server:getPlayerAccountID(player)
				executeSQLQuery("DELETE FROM AFK WHERE id=?",id)
			end
		end
	end
end)


addCommandHandler( "back", function(player)
	if (getElementData(player,"isPlayerAFK") == true) then
		setElementData(player,"isPlayerAFK",false)
		local pack = getElementData(player, "AFK")
		if pack then
			local x,y,z = unpack(pack)
			setElementDimension(player,0)
			setElementPosition(player,x,y,z)
			local id = exports.server:getPlayerAccountID(player)
			executeSQLQuery("DELETE FROM AFK WHERE id=?",id)
		end
	end
end)
