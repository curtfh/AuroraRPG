max_lost_percent = 150 -- maximum allowed percent of lost packets

errorMessages = {
    ["Warning"] = {"Warning: Packet loss"},
    ["highping"] = {"High ping (> 700 ping)"},
    ["lowfps"] = {"Low FPS (> 5 FPS)!"},
    ["justLogged"] = {"You have just logged in, please wait"},
    ["loss"] = {"Packet Loss"},
    ["client loss"] = {"Packet loss"},
    ["status"] = {"False client connection"},
	["hellLag"] = {"You are lagging like hell (Huge packet loss)"},
}

local antiAllowed = {}
local packet = {}
local whowas = {}
local rape = {}
local packetloss = {}
local lossTimer = {}
local lastPacketAmount = {}

addEventHandler("onServerPlayerLogin",root,function()
	if isTimer(whowas[source]) then return false end
	antiAllowed[source] = true
	whowas[source] = setTimer(function(p)
		antiAllowed[p] = false
	end,60000,1,source)
end)

function isPlayerLagging(player) --- important checks dont touch dick head
    if (not isElement(player)) then return end
    if getPlayerPing(player) > 500 then
        return false, errorMessages["highping"][1]
    end
	if tonumber(getElementData(player,"FPS")) <= 5 then
        return false, errorMessages["lowfps"][1]
    end
	if antiAllowed[player] then
        return false, errorMessages["justLogged"][1]
    end
	if getNetworkStats(player) and getNetworkStats(player)["packetlossLastSecond"] >= 25 then
		return false, errorMessages["loss"][1]
    end
	if rape[player] == true then
		return false, errorMessages["client loss"][1]
	end
	if ( not getNetworkStats( player ) ) then
		return false, errorMessages["status"][1]
    end
	if packetloss[source] == true then
		return false, errorMessages["Warning"][1]
    end
	local network = getNetworkStats(player)
	if (network["packetsReceived"] > 0) then
		lastPacketAmount[player] = network["packetsReceived"]
	else --Packets are the same. Check ResendBuffer
		if (network["messagesInResendBuffer"] >= 15) then
			return false, errorMessages["hellLag"][1]
		end
	end
    return true
end


-- Function to give player money
function GPM( thePlayer, theMoney,resource,message )
	if not resource then resource = "NGCmanagement" end
	if not message then message = "NGCmanagement gave player some cash!" end
	if ( givePlayerMoney( thePlayer, tonumber( theMoney ) ) ) and ( exports.server:getPlayerAccountID( thePlayer ) ) then
		exports.DENmysql:exec( "UPDATE accounts SET money=? WHERE id=?", ( tonumber( theMoney ) + getPlayerMoney( thePlayer ) ), exports.server:getPlayerAccountID( thePlayer ) )
		exports.CSGlogging:createLogRow ( thePlayer, "money", getPlayerName( thePlayer ).." has earned $"..exports.server:convertNumber(theMoney).." from resource: ("..resource..") ("..message..")"  )
		return true
	else
		return false
	end
end

-- Function to remove player money
function RPM( thePlayer, theMoney )
	if ( takePlayerMoney( thePlayer, tonumber( theMoney ) ) ) and ( exports.server:getPlayerAccountID( thePlayer ) ) then
		exports.DENmysql:exec( "UPDATE accounts SET money=? WHERE id=?", ( tonumber( theMoney ) + getPlayerMoney( thePlayer ) ), exports.server:getPlayerAccountID( thePlayer ) )
		exports.CSGlogging:createLogRow ( thePlayer, "money", "$"..exports.server:convertNumber(theMoney).." removed from "..getPlayerName( thePlayer ))
		return true
	else
		return false
	end
end

addEvent("setPacketLoss",true)
addEventHandler("setPacketLoss",root,function(state)
	if state == true and rape[source] == true then return false end
	if state == false and rape[source] == false then return false end
	rape[source] = state
end)


local cmd_spam = {}

function checkCMDSpam()
	if not cmd_spam[source] then
		cmd_spam[source] = 1
	elseif cmd_spam[source] == 3 then
		cancelEvent()
	end
	cmd_spam[source] = cmd_spam[source] + 1
end
addEventHandler( "onPlayerCommand", root, checkCMDSpam)

setTimer(
	function()
		cmd_spam = {}
	end, 1000, 0
)


addEvent("checkClientPacket",true)
addEventHandler("checkClientPacket",root,function(s,t)
	---outputDebugString(getPlayerName(source).." Status("..s..") : Ticks :"..t )
	if s == 0 then
		packetloss[source] = true
		if isTimer(lossTimer[source]) then killTimer(lossTimer[source]) end
	elseif s == 1 then
		if not isTimer(lossTimer[source]) then return false end
		lossTimer[source] = setTimer(function(p)
			packetloss[p] = false
		end,1000,1,source)
	end
end)

addEventHandler( "onPlayerNetworkStatus", root,function( status, ticks )
    if status == 0 then
		if packetloss[source] ~= true then
			---outputDebugString( "(packets from " .. getPlayerName(source) .. ") interruption began " .. ticks .. " ticks ago" )
			packetloss[source] = true
			if isTimer(lossTimer[source]) then killTimer(lossTimer[source]) end
		end
    elseif status == 1 then
		if packetloss[source] == true then
			if not isTimer(lossTimer[source]) then return false end
			----outputDebugString( "(packets from " .. getPlayerName(source) .. ") interruption began " .. ticks .. " ticks ago and has just ended" )
			lossTimer[source] = setTimer(function(p)
				packetloss[p] = false
			end,1000,1,source)
		end
	end
end)
