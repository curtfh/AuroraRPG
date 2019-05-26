--[[to kick:
triggerServerEvent("setKickMsg",thePlayer,localPlayer)
triggerServerEvent("quitShooterRoom",thePlayer)
triggerServerEvent("quitDDRoom",thePlayer)
triggerServerEvent("quitDMRoom",thePlayer)
]]

voters = {}
timers = {}
cooldown = {}

local dimensions = {
	[5001] = true, 
	[5002] = true, 
	[5004] = true,
}

function getRoomPlayers(dim)
	if not (dimensions[dim]) then return false end
	local t = {}
	for k, v in ipairs(getElementsByType("player")) do
		if (getElementDimension(v) == dim) then
			table.insert(t, v)
		end
	end
	return t
end

function didPlayerVote(plr)
	local dim = getElementDimension(plr)
	for k, v in ipairs(voters[dim].votedYes) do
		if (v == plr) then
			return "Yes"
		end
	end
	for k, v in ipairs(voters[dim].votedNo) do
		if (v == plr) then
			return "No"
		end
	end
	return false
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

addCommandHandler("votekick", function(plr, cmd, name)
	if not (name) then return false end
	local dim = getElementDimension(plr)
	if (cooldown[dim]) and (getTickCount() - cooldown[dim] <= 15*60*1000) then
		local timeLeft = math.abs(math.ceil((cooldown[dim] - getTickCount()) / (1000*60)))
		exports.NGCdxmsg:createNewDxMessage("A votekick was held recently, please wait another "..timeLeft.." minutes.", plr, 255, 0, 0)
	return false end
	local votedOn = getPlayerFromPartialName(name)
	if not (votedOn) then return false end
	if not (dimensions[dim]) then return false end
	if (getElementDimension(votedOn) ~= dim) then return false end
	if (isTimer(timers[dim])) then return false end
	local players = getRoomPlayers(dim)
	voters[dim] = {votedYes = {}, votedNo = {}, startedBy = plr, toKick = votedOn}
	for index, value in ipairs(players) do
		triggerClientEvent(value, "AURvotekick.showVoting", value, voters)
	end
	timers[dim] = setTimer(outputVote, 15000, 1, dim)
	cooldown[dim] = getTickCount()
end)

addCommandHandler("vote", function(plr, cmd, vote)
	if (string.lower(vote) ~= "yes") and (string.lower(vote) ~= "no") then return false end
	local dim = getElementDimension(plr)
	if (didPlayerVote(plr)) then
		if (string.lower(didPlayerVote(plr)) == vote) then return false end
		if (didPlayerVote(plr) == "Yes") then
			for k, v in ipairs(voters[dim].votedYes) do
				if (v == plr) then
					table.remove(voters[dim].votedYes, k)
				end
			end
		end
		if (didPlayerVote(plr) == "No") then
			for k, v in ipairs(voters[dim].votedNo) do
				if (v == plr) then
					table.remove(voters[dim].votedNo, k)
				end
			end
		end
	end
	if (string.lower(vote) == "yes") then
		table.insert(voters[dim].votedYes, plr)
		triggerClientEvent(plr, "AURvotekick.changeVote", plr, "YES")
	end
	if (string.lower(vote) == "no") then
		table.insert(voters[dim].votedNo, plr)
		triggerClientEvent(plr, "AURvotekick.changeVote", plr, "NO")
	end
	triggerClientEvent(root, "AURvotekick.receiveData", root, voters)
end)

function outputVote(dim)
	if (#voters[dim].votedYes > #voters[dim].votedNo) then
		for k, v in ipairs(getRoomPlayers(dim)) do
			outputChatBox(getPlayerName(voters[dim].toKick).." has been kicked out of the room (vote kick)", v, 255, 0, 0)
			triggerClientEvent(v, "AURvotekick.endVoting", v)
		end
		if (dim == 5004) then
			triggerEvent("quitDMRoom", voters[dim].toKick)
		end
		if (dim == 5001) then
			triggerEvent("quitShooterRoom",voters[dim].toKick)
		end
		if (dim == 5002) then
			triggerEvent("quitDDRoom", voters[dim].toKick)
		end
	else
		for k, v in ipairs(getRoomPlayers(dim)) do
			outputChatBox("The voting ended (insufficient votes)" , v, 255, 0, 0)
			triggerClientEvent(v, "AURvotekick.endVoting", v)
		end
	end
end
