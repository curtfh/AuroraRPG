-- Open VIP Panel
function openVIPPanel ( playerSource, commandName )
	local thePlayer = playerSource
	if ( exports.server:getPlayerAccountID( thePlayer ) ) then
		local userData = exports.DENmysql:querySingle( "SELECT * FROM accounts WHERE id=? LIMIT 1", exports.server:getPlayerAccountID( thePlayer ) )
		if ( userData ) then
			if ( userData.VIP == 0 ) then
				exports.NGCdxmsg:createNewDxMessage( thePlayer, "You are not a VIP member! Check the forum for more information!", 225, 0, 0 )
				--triggerClientEvent(thePlayer,"updatesPremHours",thePlayer,math.floor( userData.VIP / 60 ))
			elseif ( userData.VIP < 60 ) then
				exports.NGCdxmsg:createNewDxMessage( thePlayer, "VIP time remaining: " .. userData.VIP .. " minutes", 0, 225, 0 )
				--triggerClientEvent(thePlayer,"updatesPremHours",thePlayer,userData.VIP,"minutes")
				triggerClientEvent ( thePlayer, "openVIP", thePlayer, math.floor(userData.VIP/60))
			else
				if ( math.floor( userData.VIP / 60 ) == 1 ) then
					exports.NGCdxmsg:createNewDxMessage( thePlayer, "VIP time remaining: 1 hour", 0, 225, 0)
					--triggerClientEvent(thePlayer,"updatesPremHours",thePlayer,1,"hour")
					triggerClientEvent ( thePlayer, "openVIP", thePlayer, 1)
				else
					exports.NGCdxmsg:createNewDxMessage( thePlayer, "VIP time remaining: " .. math.floor( userData.VIP / 60 ) .. " hours", 0, 225, 0)
					triggerClientEvent ( thePlayer, "openVIP", thePlayer, math.floor(userData.VIP/60))
				end
			end
		end
	end
end
addCommandHandler ( "vip", openVIPPanel )
addEvent("openVIPPanel", true)
addEventHandler("openVIPPanel", root, openVIPPanel)

---- VIP chat
local enabledvchat = {}
addCommandHandler( "vchat",
	function ( thePlayer, cmd, ... )
		if ( exports.server:isPlayerVIP( thePlayer ) ) then
			if enabledvchat[thePlayer] == nil then enabledvchat[thePlayer] = true end
			if enabledvchat[thePlayer] == false then
				exports.NGCdxmsg:createNewDxMessage(thePlayer,"VIP chat is disabled, enable it from the panel",0,255,0)
				return
			end
			local theMessage = table.concat( {...}, " " )
			for k, aPlayer in ipairs ( getElementsByType( "player" ) ) do
			if ( exports.CSGadmin:getPlayerMute ( thePlayer ) == "Global" ) then
					exports.NGCdxmsg:createNewDxMessage(thePlayer, "You are muted!", 236, 201, 0)
					return false end
				if ( exports.server:isPlayerVIP( aPlayer ) ) then
					if enabledvchat[aPlayer] == nil then
						outputChatBox( "(VIP) " .. getPlayerName( thePlayer ) .. ": #FFFFFF"..theMessage, aPlayer, 255, 69, 0, true )
					elseif enabledvchat[aPlayer] == true then
						outputChatBox( "(VIP) " .. getPlayerName( thePlayer ) .. ": #FFFFFF"..theMessage, aPlayer, 255, 69, 0, true )
					else
						--off for him
					end
				end
			end
			exports.CSGlogging:createLogRow ( thePlayer, "VIPchat", theMessage )
		end
	end
)
addEvent("togglevchat",true)
addEventHandler("togglevchat",root,
function(ps)
	if not getElementData(ps, "isPlayerVIP") then exports.NGCdxmsg:createNewDxMessage(ps,"You are not VIP",255,0,0) return end
	if enabledvchat[ps] == false or enabledvchat[ps] == nil then
		exports.NGCdxmsg:createNewDxMessage(ps,"VIP chat enabled, you can now talk and see VIP chat",0,255,0)
		enabledvchat[ps]=true
	else
		exports.NGCdxmsg:createNewDxMessage(ps,"VIP chat disabled, you can no longer talk or see VIP chat",0,255,0)
		enabledvchat[ps]=false
	end
end)


-- Show the remaining hours or say that the player isn't VIP
addEvent( "VIP",true)
addEventHandler( "VIP",root,
	function ( thePlayer )
		if ( exports.server:getPlayerAccountID( thePlayer ) ) then
			local userData = exports.DENmysql:querySingle( "SELECT * FROM accounts WHERE id=? LIMIT 1", exports.server:getPlayerAccountID( thePlayer ) )
			if ( userData ) then
				if ( userData.VIP == 0 ) then
					exports.NGCdxmsg:createNewDxMessage( thePlayer, "You are not a VIP member! Check the forum for more information!", 225, 0, 0 )
					triggerClientEvent(thePlayer,"updatesPremHours",thePlayer,math.floor( userData.VIP / 60 ))
				elseif ( userData.VIP < 60 ) then
					exports.NGCdxmsg:createNewDxMessage( thePlayer, "VIP time remaining: " .. userData.VIP .. " minutes", 0, 225, 0 )
					triggerClientEvent(thePlayer,"updatesPremHours",thePlayer,userData.VIP,"minutes")
				else
					if ( math.floor( userData.VIP / 60 ) == 1 ) then
						exports.NGCdxmsg:createNewDxMessage( thePlayer, "VIP time remaining: 1 hour", 0, 225, 0)
						triggerClientEvent(thePlayer,"updatesPremHours",thePlayer,1,"hour")
					else
						exports.NGCdxmsg:createNewDxMessage( thePlayer, "VIP time remaining: " .. math.floor( userData.VIP / 60 ) .. " hours", 0, 225, 0)
						triggerClientEvent(thePlayer,"updatesPremHours",thePlayer,math.floor( userData.VIP / 60 ),"hours")
					end
				end
			end
		end
	end
)
local antiSpam = {}
addEvent("convertVIPMoney",true)
addEventHandler("convertVIPMoney",root,function(player,value)
	if not getElementData(player, "isPlayerVIP") then exports.NGCdxmsg:createNewDxMessage(player,"You are not VIP",255,0,0) return end
	if ( exports.server:isPlayerVIP( player ) ) then
		if value and tonumber(value) and tonumber(value) >= 1 then
			local userData = exports.DENmysql:querySingle( "SELECT * FROM accounts WHERE id=? LIMIT 1", exports.server:getPlayerAccountID( player ) )
			if ( userData ) then
				local premTime = math.floor( userData.VIP / 60 )
				if tonumber(premTime) >= tonumber(value) then
					if isTimer(antiSpam[source]) then return false end
					antiSpam[source] = setTimer(function() end,3000,1)
					local newTime = (tonumber(premTime) - tonumber(value)) * 60
					local testTime = math.floor( userData.VIP / 60 )
					local cost = value*10000
					exports.NGCdxmsg:createNewDxMessage(player,"You have converted "..tonumber(value).." hour(s) to $"..cost.."",0,255,0)
					exports.DENmysql:exec("UPDATE accounts SET VIP=? WHERE id=?", tonumber(newTime), exports.server:getPlayerAccountID(player))
					givePlayerMoney(player,cost)
					if newTime == 0 then
						setElementData(player, "isPlayerVIP", false)
						setElementData(player, "VIP", "No")
				else
					exports.NGCdxmsg:createNewDxMessage(player,"You don't have that amount of VIP hours.",255,0,0)
				end
			end
		else
			exports.NGCdxmsg:createNewDxMessage(player,"Error wrong value.",255,0,0)
		end
	else
		exports.NGCdxmsg:createNewDxMessage(player,"You're not VIP.",255,0,0)
		end
	end
end)


-- Update the VIP time from all players and update it
setTimer(
	function ()
		for k, thePlayer in ipairs ( getElementsByType ( "player" ) ) do
			if ( exports.server:getPlayerAccountID( thePlayer ) ) then
				if ( exports.server:isPlayerVIP( thePlayer ) ) then

					local userData = exports.DENmysql:querySingle( "SELECT * FROM accounts WHERE id=? LIMIT 1", exports.server:getPlayerAccountID( thePlayer ) )
					if userData == nil then userData={} userData.VIP=0 end
					if ( userData.VIP > 4 ) then
						VIPTime = userData.VIP - 5
						premType = userData.VIPType
					elseif ( userData.VIP == 4 ) then
						VIPTime = userData.VIP - 4
						premType = userData.VIPType
					elseif ( userData.VIP == 3 ) then
						VIPTime = userData.VIP - 3
						premType = userData.VIPType
					elseif ( userData.VIP == 2 ) then
						VIPTime = userData.VIP - 2
						premType = userData.VIPType
					elseif ( userData.VIP == 1 ) then
						VIPTime = userData.VIP - 1
						premType = userData.VIPType
					end

					if (VIPTime == 0) then
						setElementData(thePlayer, "isPlayerVIP", false)
						setElementData(thePlayer, "VIP", "No")
						triggerClientEvent(thePlayer,"forceVIP",thePlayer)
						premType = 0
					end

					exports.DENmysql:exec("UPDATE accounts SET VIP=? WHERE id=?", tonumber(VIPTime), exports.server:getPlayerAccountID(thePlayer))
				end
			end
		end
	end, 300000, 0
)

function getNearbyPlayers(thePlayer)
	local nearbyPlayers = { }
	local px,py,pz = getElementPosition(thePlayer)
	for k,v in pairs(getElementsByType("player"))do
		local vx,vy,vz = getElementPosition(v)
		--outputDebugString(getDistanceBetweenPoints3D(px,py,pz,vx,vy,vz))
		if(getDistanceBetweenPoints3D(px,py,pz,vx,vy,vz) < 50)then
			table.insert(nearbyPlayers, v)
		end
	end
	return nearbyPlayers
end

------ enable jetpack
addEvent("onGetJetPack",true)
function getJetPack(plr, cmd)
	if (doesPedHaveJetPack(plr)) then
		removePedJetPack(plr)
	end
	if (doesPedHaveJetPack(plr)) then
		removePedJetPack(plr)
	end

	if not getElementData(plr, "isPlayerVIP") then exports.NGCdxmsg:createNewDxMessage(plr,"This feature is only restricted to VIP Members. You can purchase VIP at aurorarvg.com",255,0,0) return end
	if getElementData(plr,"isPlayerVIP") == true then
		local theDis = getNearbyPlayers(plr)
		if (cmd == true) then
			triggerClientEvent(plr, "AURvip.isPlayerUnderWater", plr)
			return
		end
		local velx, vely, velz = getElementVelocity(plr)
		--outputChatBox(velx..","..vely..","..velz, plr)
		if (isElementInWater(plr) and (velx ~= 0 and vely ~= 0 and velz ~= 0)) then
			exports.NGCdxmsg:createNewDxMessage(plr, "You must be above water to use a jetpack!", 255, 0, 0)
			if (doesPedHaveJetPack(plr)) then
				removePedJetPack(plr)
			end
			return false
		end
		if ( exports.server:getPlayerWantedPoints( plr ) >= 10 ) then
			exports.NGCdxmsg:createNewDxMessage( plr, "You can't use the VIP jetpack while wanted!", 225, 0, 0 )
			if (doesPedHaveJetPack(plr)) then
				removePedJetPack(plr)
			end
		elseif ( getElementZoneName ( plr, true ) == "Las Venturas" or getElementData(plr, "inLV")) then
			exports.NGCdxmsg:createNewDxMessage( plr, "You can't use the VIP jetpack inside the city of LV!", 225, 0, 0 )
			if (doesPedHaveJetPack(plr)) then
				removePedJetPack(plr)
			end
		elseif ( getElementDimension( plr ) ~= 0 ) then
			exports.NGCdxmsg:createNewDxMessage( plr, "You can only use a jetpack in the main world!", 225, 0, 0 )
			if (doesPedHaveJetPack(plr)) then
				removePedJetPack(plr)
			end
		elseif (getElementData(plr, "copArrestedCrim")) then
			exports.NGCdxmsg:createNewDxMessage( plr, "You cannot use this feature when you have arrested a player!", 225, 0, 0 )
		else
			if (getTeamName(getPlayerTeam(plr)) == "Government" or getTeamName(getPlayerTeam(plr)) == "SWAT Team" or getTeamName(getPlayerTeam(plr)) == "Military Forces") then
				for i=1, #theDis do
					if ( exports.server:getPlayerWantedPoints(theDis[i]) >= 10 and not exports.DENlaw:isPlayerLawEnforcer(plr)) then
						exports.NGCdxmsg:createNewDxMessage( plr, "You cannot use this feature when there's nearby wanted player!", 225, 0, 0 )
						if (doesPedHaveJetPack(plr)) then
							removePedJetPack(plr)
						end
						return
					end
				end
			end
			if (doesPedHaveJetPack(plr)) then
				removePedJetPack(plr)
			else
				givePedJetPack(plr)
				setTimer(giveWeapon, 500, 1, plr, 0, 1, true)
			end
		end
	end
end
addEventHandler("onGetJetPack",root,getJetPack)
addCommandHandler("vipjetpack", getJetPack)
addEvent("openVIPJetpack", true)
addEventHandler("openVIPJetpack", root, getJetPack)

for i=1,46 do
	if ( i ~= 46 ) and ( i ~= 13 ) and ( i ~= 19 ) and ( i ~= 20 ) and ( i ~= 21 ) and ( getWeaponNameFromID( i ) ~= "Freefall Bomb" ) then
		setJetpackWeaponEnabled( getWeaponNameFromID( i ), false )
	end
end

-- Vehicle spawn
local theVehicle = {}
local latestSpawn = {}
local theTimer = {}

addEvent("getVIPCar",true)
addEventHandler("getVIPCar",root,
	function (thePlayer,theID)
		if not getElementData(thePlayer, "isPlayerVIP") then exports.NGCdxmsg:createNewDxMessage(thePlayer,"You are not VIP",255,0,0) return end
		if exports.server:isPlayerLoggedIn( thePlayer ) then
			if getElementData(thePlayer,"isPlayerJailed") then
				exports.NGCdxmsg:createNewDxMessage(thePlayer, "You can't use this feature while jailed!", 225, 0, 0)
				return
			end
			if  getElementData(thePlayer, "isPlayerVIP") or getElementData(thePlayer, "canUseVIPCar") and ( getElementInterior(thePlayer) == 0 ) then
				if getElementInterior(thePlayer) ~= 0 then exports.NGCdxmsg:createNewDxMessage(thePlayer,"You can't use VIP vehicle in a interior!",255,0,0) return end
				if ( latestSpawn[getPlayerSerial(thePlayer)] ) and ( getTickCount()-latestSpawn[getPlayerSerial(thePlayer)] < 600000 ) then
					exports.NGCdxmsg:createNewDxMessage(thePlayer, "You can only use this feature once every 10 minutes!", 225, 0, 0)
				elseif ( exports.server:getPlayerWantedPoints(thePlayer) >= 10 ) then
					exports.NGCdxmsg:createNewDxMessage(thePlayer, "You can't use this feature when having one or more wanted stars!", 225, 0, 0)
				elseif theID == 452 and not isElementInWater(thePlayer) then
					exports.NGCdxmsg:createNewDxMessage(thePlayer, "You can't use this boat while you're not in water!!", 225, 0, 0)
				elseif theID ~= 452 and not isPedOnGround(thePlayer) then
					exports.NGCdxmsg:createNewDxMessage(thePlayer, "You can't use this feature while you're not on ground!!", 225, 0, 0)
				else
					if ( getElementDimension( thePlayer ) ~= 0 ) then
						return false
					end
					if not ( isPedInVehicle(thePlayer) ) then
						if ( isElement( theVehicle[thePlayer] ) ) then destroyElement( theVehicle[thePlayer] ) end
						latestSpawn[getPlayerSerial(thePlayer)] = getTickCount()
						local x, y, z = getElementPosition(thePlayer)
						local rx, ry, rz = getElementRotation(thePlayer)
						theVehicle[thePlayer] = createVehicle( theID, x, y, z, rx, ry, rz, "VIP" )
						warpPedIntoVehicle(thePlayer, theVehicle[thePlayer])
						setElementData(theVehicle[thePlayer], "vehicleType", "VIPCar")
						setElementData(theVehicle[thePlayer], "vehicleOwner", thePlayer)
						setVehicleColor(theVehicle[thePlayer],157,0,0)
						if theID == 526 then

							local handlingTable = getVehicleHandling ( theVehicle[thePlayer] )
							local newVelocity = ( handlingTable["maxVelocity"] + ( handlingTable["maxVelocity"] / 100 * 50 ) )
							setVehicleHandling ( theVehicle[thePlayer], "numberOfGears", 4 )
							setVehicleHandling ( theVehicle[thePlayer], "driveType", 'awd' )
							setVehicleHandling ( theVehicle[thePlayer], "maxVelocity", newVelocity )
							setVehicleHandling ( theVehicle[thePlayer], "engineAcceleration", handlingTable["engineAcceleration"] +20 )
							setVehicleHandling ( theVehicle[thePlayer], "tractionMultiplier" , 1.23)
							setVehicleHandling ( theVehicle[thePlayer], "brakeDeceleration", 6.4)
						end
					end
				end
			end
		end
	end
)
addEventHandler("onVehicleEnter",root,function(p,seat)
	if seat == 0 then
		if getElementData(source,"vehicleType") == "VIPCar" then
			if getPlayerWantedLevel(p) > 0 then
				exports.NGCdxmsg:createNewDxMessage(p,"You can't drive a VIP car with wanted points",255,0,0)
				cancelEvent()
			end
		end
	end
end)

-- Destroy the vehicle on quit
addEventHandler ( "onPlayerQuit", root,
	function()
		if ( isElement( theVehicle[source] ) ) then
			destroyElement( theVehicle[source] )
			theVehicle[source] = nil
		end
	end
)

-- Prevent people from entering VIP cars
addEventHandler("onVehicleStartEnter", root,
	function ( thePlayer, seat, jacked )
		if ( getElementData(source, "vehicleType") == "VIPCar" ) and ( seat == 0 ) and not ( getTeamName( getPlayerTeam( thePlayer ) ) == "Staff" ) then
					if not ( exports.server:isPlayerVIP( thePlayer ) ) then
						cancelEvent()
						exports.NGCdxmsg:createNewDxMessage(thePlayer, "You are not allowed to enter this vehicle!", 225, 0, 0)
			end
		end
	end
)

addEventHandler("onElementDataChange",root,function(k)
	if k == "wantedPoints" then
		if getPlayerWantedLevel(source) > 0 then
			if doesPedHaveJetPack(source) then
				removePedJetPack(source)
				exports.NGCdxmsg:createNewDxMessage(source,"Jetpack removed due to being wanted",255,0,0)
			end
		end
	end
end)

-- Destroy the vehicle when it explodes
addEventHandler("onVehicleExplode", root,
	function ()
		if ( getElementData(source, "vehicleType") == "VIPCar" ) then
			local theOwner = getElementData(source, "vehicleOwner")
			theTimer[theOwner] = setTimer(destroyVehicle, 5000, 1, source, theOwner)
		end
	end
)

-- Destroy function
function destroyVehicle ( vehicle, thePlayer  )
        theVehicle[thePlayer] = nil
        theTimer[thePlayer] = nil
        destroyElement(vehicle)
end

-- onPlayerZoneChange
addEvent( "playerZoneChange", true )
addEventHandler( "playerZoneChange", root,
	function ( oldZone, newZone )
		triggerEvent( "onPlayerZoneChange", source, oldZone, newZone )

		if ( doesPedHaveJetPack ( source ) ) and ( getTeamName( getPlayerTeam( source ) ) ~= "Staff" ) then
			if ( newZone == "Las Venturas" ) then
				exports.NGCdxmsg:createNewDxMessage( source, "You lost your jetpack, it's not allowed to use it in LV!", 225, 0, 0 )
				removePedJetPack ( source )
			end
			if ( oldZone == "Las Venturas" and newZone == "Unknown" ) then
				exports.NGCdxmsg:createNewDxMessage( source, "You lost your jetpack, it's not allowed to use it in LV!", 225, 0, 0 )
				removePedJetPack ( source )
			end
		end
	end
)

addEvent("vipHats_changeHat",true)

local hatObjects = {}
local timers = {}
function changeHats(model,scale)

	if model then

		if isElement(hatObjects[source]) then
			destroyElement(hatObjects[source])
			hatObjects[source] = nil
			if isTimer(timers) then killTimer(timers[source]) end
		end
			hatObjects[source] = createObject(model, 0,0,-10 )
			setObjectScale(hatObjects[source],scale)
			exports.bone_attach:attachElementToBone(hatObjects[source],source,1,-0.0050,0.025,0.125,0,4,180)
			local p = source
			timers[p] = setTimer(function(p)
				local int,dim=getElementInterior(p),getElementDimension(p)
				setElementInterior(hatObjects[p],int)
				setElementDimension(hatObjects[p],dim)
			end,3000,1,source)


	else

		if isElement(hatObjects[source]) then destroyElement(hatObjects[source]) end
		if isTimer(timers) then killTimer(timers[source]) end

			hatObjects[source] = nil
			exports.NGCdxmsg:createNewDxMessage(source,"No longer wearing any hat",0,255,0)
		end



end

addEventHandler("vipHats_changeHat",root,changeHats)

addEvent("changeMask",true)

local maskObjects = {}
local timers2 = {}
function changeMask(model,scale,rotx,roty,rotz,z,y)

	if model then

		if isElement(maskObjects[source]) then
			destroyElement(maskObjects[source])
			maskObjects[source] = nil
			if isTimer(timers2) then killTimer(timers2[source]) end
		end
			maskObjects[source] = createObject(model, 0,0,-10 )
			setObjectScale(maskObjects[source],scale)
			exports.bone_attach:attachElementToBone(maskObjects[source],source,1,-0.0050,y,z,0,0,0)
			exports.bone_attach:setElementBoneRotationOffset(maskObjects[source],rotx,roty,rotz)
			local p = source
			timers2[p] = setTimer(function(p)
				local int,dim=getElementInterior(p),getElementDimension(p)
				setElementInterior(maskObjects[p],int)
				setElementDimension(maskObjects[p],dim)
			end,2000,1,source)


	else

		if isElement(maskObjects[source]) then destroyElement(maskObjects[source]) end
		if isTimer(timers2) then killTimer(timers2[source]) end

			maskObjects[source] = nil
			exports.NGCdxmsg:createNewDxMessage(source,"No longer wearing any mask",0,255,0)
		end



end

addEventHandler("changeMask",root,changeMask)

addEventHandler("onPlayerQuit",root,function()
	if isElement(hatObjects[source]) then
		if isTimer(timers[source]) then
			killTimer(timers[source])
		end
		destroyElement(hatObjects[source])
		hatObjects[source] = nil
	end
	if isElement(maskObjects[source]) then
		if isTimer(timers2[source]) then
			killTimer(timers2[source])
		end
		destroyElement(maskObjects[source])
		maskObjects[source] = nil
	end
end)





--------------------------

function givePlayerVIP(player,amount)
	if (isElement(player)) and (exports.server:isPlayerLoggedIn(player)) then
		local id = exports.server:getPlayerAccountID(player)
		local data = exports.DENmysql:querySingle("SELECT VIP FROM accounts WHERE id=?",id)
		local newValue = data["VIP"] + amount
		if (exports.DENmysql:exec("UPDATE accounts SET VIP=?, VIPType=? WHERE id=?",newValue,4,id)) then
			outputDebugString("[VIP] "..getPlayerName(player).." has been given "..amount.." of VIP minutes.",0,0,255,0)
			setElementData(player,"isPlayerVIP",true)
			setElementData(player,"VIP","Yes")
			return true
		else
			outputDebugString("[VIP] failed to give "..getPlayerName(player).." "..amount.." of VIP minutes!",0,255,0,0)
			return false
		end
	else
		return false
	end
end

function decreasePlayerVIP(player,amount)
	if (isElement(player)) and (exports.server:isPlayerLoggedIn(player)) then
		local id = exports.server:getPlayerAccountID(player)
		local data = exports.DENmysql:querySingle("SELECT VIP FROM accounts WHERE id=?",id)
		local newValue = data["VIP"] - amount
		if (newValue <= 0) then
			return false
		end
		if (exports.DENmysql:exec("UPDATE accounts SET VIP=?, VIPType=? WHERE id=?",newValue,4,id)) then
			outputDebugString("[VIP] "..getPlayerName(player).." has been decreased to "..amount.." of VIP minutes.",0,0,255,0)
			return true
		else
			outputDebugString("[VIP] failed to decrease "..getPlayerName(player).." "..amount.." of VIP minutes!",0,255,0,0)
			return false
		end
	else
		return false
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

function convertTime(minutes)
local hours = 0
local seconds = 0
    repeat
        if seconds >= 60 then
            minutes = minutes + 1; seconds = seconds - 60
        elseif minutes >= 60 then
            hours = hours + 1; minutes = minutes - 60
        end
    until seconds < 60 and minutes < 60
    return hours
end

function round(num, numDecimalPlaces)
  local mult = 10^(numDecimalPlaces or 0)
  return math.floor(num * mult + 0.5) / mult
end

local antiSpam = {}
function sendPlayerVipToPlayer (player, command, amount, playername)
	if isTimer(antiSpam[player]) then
		exports.NGCdxmsg:createNewDxMessage(player,"Please wait few seconds before you transfer a vip hour.",255,0,0)
		return
	end
	antiSpam[player] = setTimer(function() end,2000,1)
	if (isElement(player) and (exports.server:isPlayerLoggedIn(player))) then
		if (not tonumber(amount) or amount == nil or playername == nil or amount:match("^%s*$") or playername:match("^%s*$")) then
			exports.NGCdxmsg:createNewDxMessage(player,"Syntax: /sendviphours <hours> <player name>",255,0,0)
			return
		end
		local amt = round(math.abs(amount))
		local id = exports.server:getPlayerAccountID(player)
		local data = exports.DENmysql:querySingle("SELECT VIP FROM accounts WHERE id=?",id)
		local theAmount = data["VIP"]
		if (tonumber(theAmount) >= 120) then
			if (convertTime(tonumber(theAmount)) == amt) then
				exports.NGCdxmsg:createNewDxMessage(player,"You cannot transfer the same amount.",255,0,0)
				return
			elseif (convertTime(tonumber(theAmount)) >= amt) then
				if (getPlayerFromPartialName(playername) == player) then
					exports.NGCdxmsg:createNewDxMessage(player,"You cannot transfer the VIP to your self.",255,0,0)
					return
				end
				if (getPlayerFromPartialName(playername)) then
					local transplayer = getPlayerFromPartialName(playername)
					decreasePlayerVIP(player, amt*60)
					givePlayerVIP(transplayer, amt*60)
					exports.NGCdxmsg:createNewDxMessage(player,"Your "..amt.."H of VIP has been transfered to "..getPlayerName(transplayer)..".",0,255,0)
					exports.NGCdxmsg:createNewDxMessage(transplayer,"You received "..amt.."H of VIP from "..getPlayerName(player)..".",0,255,0)
				else
					exports.NGCdxmsg:createNewDxMessage(player,"Player not found. Please make sure the name of the player is correct.",255,0,0)
				end
			else
				exports.NGCdxmsg:createNewDxMessage(player,"You don't have enough VIP hours.",255,0,0)
			end


		else
			exports.NGCdxmsg:createNewDxMessage(player,"You must have at least 2 hours of VIP.",255,0,0)
		end
	end
end
addCommandHandler("sendviphours", sendPlayerVipToPlayer)


function removePlayerVIP(player)
	if (isElement(player) and exports.server:isPlayerLoggedIn(player)) then
		local id = exports.server:getPlayerAccountID(player)
		if (exports.DENmysql:exec("UPDATE accounts SET VIP=? WHERE id=?",0,id)) then
			setElementData(player,"isPlayerVIP",false)
			setElementData(player,"VIP","No")
			return true
		else
			return false
		end
	else
		return false
	end
end

function getVIPPaymentBonus(player,pay)
	if (not isElement(player)) then return false end
	if (type(pay) ~= "number") then return false end
	if (not exports.server:isPlayerVIP(player)) then return pay end

	return math.floor(pay*1.2)
end

addEvent( "onServerPlayerLogin")
addEventHandler( "onServerPlayerLogin", root,
function ()
	local name = getPlayerName( source )
	if getElementData( source, "isPlayerVIP",true) then
			outputChatBox("Welcome back "..name..", you are a VIP player, have a nice day!" ,source,60,125,200)
	end
end
)
