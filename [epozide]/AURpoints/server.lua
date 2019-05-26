-- Open VIP Panel
function openAPSPanel ( playerSource, commandName )
    triggerClientEvent ( playerSource, "openAPS", playerSource)
end
addCommandHandler ( "convertaps", openAPSPanel )

function getAuroraPoints(thePlayer)
	local userData = exports.DENmysql:querySingle( "SELECT * FROM accounts WHERE id=? LIMIT 1", exports.server:getPlayerAccountID( thePlayer ) )
	if ( userData.APS ) and (userData) then
		return tonumber(userData.APS)
	end
end

function givePlayerAPS(player,amount)
	if (isElement(player)) and (exports.server:isPlayerLoggedIn(player)) then
		local id = exports.server:getPlayerAccountID(player)
		local data = exports.DENmysql:querySingle("SELECT APS FROM accounts WHERE id=?",id)
		local newValue = data["APS"] + amount
		if (exports.DENmysql:exec("UPDATE accounts SET APS=? WHERE id=?",newValue,id)) then
			outputDebugString("[APS Gain] "..getPlayerName(player).." has been given "..amount.." of APS.",0,0,255,200)
			setElementData(player,"auroraPoints",data["APS"] + amount)
			return true
		else
			outputDebugString("[APS Error] failed to give "..getPlayerName(player).." "..amount.." of APS!",0,255,0,0)
			return false
		end
	else
		return false
	end
end

addEventHandler("onPlayerLogin", root, 
	function ()
		if (isElement(source)) and (exports.server:isPlayerLoggedIn(source)) then
			local id = exports.server:getPlayerAccountID(source)
			local data = exports.DENmysql:querySingle("SELECT APS FROM accounts WHERE id=?",id)
			local value = data["APS"]
			setElementData(source, "auroraPoints", data["APS"])
		end
	end
)

function setPlayerAPS(player,amount)
	if (isElement(player)) and (exports.server:isPlayerLoggedIn(player)) then
		local id = exports.server:getPlayerAccountID(player)
		local data = exports.DENmysql:querySingle("SELECT APS FROM accounts WHERE id=?",id)
		local newValue, oldValue = amount, tonumber(data.APS)
		local calculation = oldValue - newValue
		if (exports.DENmysql:exec("UPDATE accounts SET APS=? WHERE id=?",newValue,id)) then
			if (oldValue >= newValue) then
				outputDebugString("[APS Loss] "..getPlayerName(player).." has been charged "..calculation.." of APS.",0,0,255,200)
			else
				outputDebugString("[APS Gain] "..getPlayerName(player).." has been given "..calculation.." of APS.",0,0,255,200)
			end
			setElementData(player,"auroraPoints",amount)
			return true
		else
			outputDebugString("[APS Error] failed to set "..getPlayerName(player).." "..amount.." of APS!",0,255,0,0)
			return false
		end
	else
		return false
	end
end

--[[setTimer(
	function ()
		for k, plr in pairs(getElementsByType("player")) do
			setElementData(plr, "auroraPoints", getAuroraPoints(plr))
		end
	end, 1000, 0
)]]

-- SEND VIP
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

local antispam = {}
function sendAPS(plr, _, name, t)
   if (plr and exports.server:isPlayerLoggedIn(plr)) then
		if (antispam[plr]) then
            exports.NGCdxmsg:createNewDxMessage(plr, "You can only use this once every minute", 255, 0, 0)
            return false
        end
		local plrAPS = getAuroraPoints(plr)
		local plrAPS = math.floor(plrAPS)
		if (not plrAPS or plrAPS < 1) then
			exports.NGCdxmsg:createNewDxMessage(plr, "You're poor. You don't have APS to send.", 255, 0, 0)
			return false
		end
		local _plr = getPlayerFromPartialName(name) -- There should be an export for this
		if (not _plr) then
			exports.NGCdxmsg:createNewDxMessage(plr, "We couldn't find a player with this name, or there are multiple players with this name", 255, 0, 0)
		end
		if (_plr.name == plr.name) then
			exports.NGCdxmsg:createNewDxMessage(plr, "You can not send yourself APS", 255, 0, 0)
			return false
		end
		if (not exports.server:isPlayerLoggedIn(_plr) or plr.dead) then
			return false
		end
		local _plrAPS = getAuroraPoints(plr)
		local t = math.floor(t)
		if (t and tonumber(t) and tonumber(t) > 0) then
			t = tonumber(t)
			local plrNewAPS = plrAPS - t
			if (plrNewAPS < 0) then
				exports.NGCdxmsg:createNewDxMessage(plr, "You don't have this amount of APS to send.", 255, 0, 0)
				return
			end
			if tonumber(t) < 1 then
				exports.NGCdxmsg:createNewDxMessage(plr, "You're poor. You don't have APS to send.", 255, 0, 0)
				return false
			end
			--givePlayerAPS(plr, (plrAPS*0 - t))
			--givePlayerAPS(_plr, (_plrAPS*0 + t))
			exports.NGCdxmsg:createNewDxMessage(plr, "You have given ".._plr.name.." "..t.." APS", 0, 255, 0)
			exports.NGCdxmsg:createNewDxMessage(_plr, "You have received "..t.." APS from "..plr.name, 0, 255, 0)
			antispam[plr] = true
            Timer(function () antispam[plr] = nil end, 60 * 1000, 1, plr)
		else
			exports.NGCdxmsg:createNewDxMessage(plr, "You must enter a number after the player's name", 255, 0, 0)
		end
	end
end
--[[addCommandHandler("sendaps",sendAPS) DO NOT ENABLE THIS, OTHERWISE THE PURPOSE OF APS WOULD BE RUINED]]

-- Convert
local antiSpam = {}
addEvent("convertAPS",true)
addEventHandler("convertAPS",root,function(player,value)
	local userData = exports.DENmysql:querySingle( "SELECT * FROM accounts WHERE id=? LIMIT 1", exports.server:getPlayerAccountID( player ) )
	if ( exports.server:isPlayerLoggedIn( player ) ) then
		if value and tonumber(value) and tonumber(value) >= 1 then
			if ( userData ) then
				local aps = math.floor( userData.APS )
				if tonumber(aps) < tonumber(value) then
					exports.NGCdxmsg:createNewDxMessage(player,"You don't have that amount of APS.",255,0,0)
					return false
				end
				if isTimer(antiSpam[source]) then return false end
				antiSpam[source] = setTimer(function() end,60000,1)
				local newAPS = (tonumber(aps) - tonumber(value))
				local testTime = math.floor( userData.APS )
				local cost = value*1000
				exports.NGCdxmsg:createNewDxMessage(player,"You have converted "..tonumber(value).." APS to $"..cost.."",0,255,0)
				exports.DENmysql:exec("UPDATE accounts SET APS=? WHERE id=?", tonumber(newAPS), exports.server:getPlayerAccountID(player))
				setElementData(player,"auroraPoints",tonumber(newAPS))
				setPlayerAPS( player,tonumber(newAPS))
				givePlayerMoney(player,cost)
				if newAPS == 0 then
					setElementData(player, "auroraPoints", 0)
				end
			end
		else
			exports.NGCdxmsg:createNewDxMessage(player,"Error wrong value.",255,0,0)
		end
	end
end)
