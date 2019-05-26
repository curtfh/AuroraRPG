

function banTeleport()
	if not exports.CSGstaff:isPlayerStaff(source) then
		kickPlayer(source, "Teleport Hack")
		outputDebugString("Teleport hack by "..getPlayerName(source))
	end
end
addEvent("bantp",true)
addEventHandler("bantp",getRootElement(),banTeleport)

--[[function logged()
	setTimer(function(source)
		if exports.CSGstaff:isPlayerStaff(source) then
			triggerClientEvent(source,"startANTItp",source,1)
		else
			triggerClientEvent(source,"startANTItp",source,2)
		end
	end,4000,1,source)
end
--addEventHandler("onPlayerLogin",getRootElement(),logged)
addEventHandler("onPlayerSpawn",getRootElement(),logged)

cols = {}
addEventHandler("onServerPlayerLogin",root,function()
	local x,y,z = getElementPosition(source)
	local playerCol = createColSphere(x,y,z,1.5)
	cols[source] = playerCol
	setElementData(source,"playerCol",playerCol)
	attachElements ( playerCol, source, 0, 0, 0 )
end)

addEventHandler("onPlayerQuit",root,function()
	if cols[source] then
		if isElement(cols[source]) then
			destroyElement(cols[source])
		end
	end
end)

addEventHandler("onResourceStart",resourceRoot,function()
	setTimer(function()
		for i, v in ipairs(getElementsByType("player")) do
			if exports.server:getPlayerAccountName(v) == "neon.-" then
			local x,y,z = getElementPosition(v)
			local playerCol = createColSphere(x,y,z,1.5)
			cols[v] = playerCol
			setElementData(v,"playerCol",playerCol)
			attachElements ( playerCol, v, 0, 0, 0 )
			if exports.CSGstaff:isPlayerStaff(v) then
				triggerClientEvent(v,"startANTItp",v,1)
			else
				triggerClientEvent(v,"startANTItp",v,2)
			end
			end
		end
	end,3000,1)
end)
]]
local lossCount = {}
local isLosingConnection = false
local pos ={}


function checkLoss()
	for i, v in ipairs(getElementsByType("player")) do
		if exports.server:isPlayerLoggedIn(v) then
			if getElementDimension(v) ~= 0 then return false end
			--if exports.server:getPlayerAccountName(v) == "neon.-" then
			local loss = getNetworkStats(v)["packetlossLastSecond"]
			if not lossCount[v] then
				lossCount[v] = 0
			end
			if loss >= 5 then -- If we have packet loss then send message and add counter.
				if not pos[v] or pos[v] == nil or pos[v] == {} then
					local x,y,z = getElementPosition(v)
					--setElementFrozen(v,true)
					pos[v] = {x,y,z}
					--outputDebugString("Got his place")
				end
			end
			if loss >= 80 then -- If we have packet loss then send message and add counter.
				if not isLosingConnection then
					isLosingConnection = true
					triggerClientEvent(v,"onPlayerIsLosingConnection",v,isLosingConnection)
					--outputDebugString("Player "..string.gsub(getPlayerName(v), '#%x%x%x%x%x%x', '' ).." is losing connection")
					if isLosingConnection then
						--setElementFrozen(v,false)
						if pos[v] then
							local x,y,z = unpack(pos[v])
							if x and y and z then
								--setElementPosition(v,x,y,z)
								pos[v] = {}
							end
						end
					end
				end
				lossCount[v] = lossCount[v] + 1
				if lossCount[v] >= 10 then -- If counter is equal to gameplayVariables["packetlossmax"] or higher then reset counter and kick player
					lossCount[v] = nil
					--outputDebugString("Kicked "..getPlayerName(v).." packet loss")
					--kickPlayer(v, "Huge Packet Loss detected")
				end
			else -- If packet loss was corrected then reset counter
				lossCount[v] = 0
				isLosingConnection = false
				triggerClientEvent(v,"onPlayerIsLosingConnection",v,isLosingConnection)
			end
		end
	end
end

setTimer(checkLoss,1000,0) -- Set timer to check every two seconds
