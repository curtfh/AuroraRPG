whoHasIt = false
rewardMoney = 40000
rewardScore = 5
theTable = {}

mark = {
	{1532.1966552734,749,11},
	{1771,2108.2109375,11},
	{2389.5483105469,2310,11},
	{1098,1602,11},
	{2378.9074707031,1040,11},
	{2323,1283.4815673828,97},
	{1989.2025146484,1068,11},
	}

Armour = {

	{2281,1125,10},
	{2460,1566,10},
	{1960,2752,10},
	{1434,2616,10},
	{1386,1025,10},
	{1612,1353,10},
	{1600,1945,10},
}


function createArmour()
	local mt = math.random(#Armour)
	ob = createObject(1242,Armour[mt][1],Armour[mt][2],Armour[mt][3])
	setElementCollisionsEnabled(ob,false)
	if isTimer(FTWTimer) then killTimer(FTWTimer) end
	FTWTimer = setTimer(checkingTimer,1000,0)
	mar = createMarker(Armour[mt][1],Armour[mt][2],Armour[mt][3],"checkpoint",0.2,0,255,0,40)
	bl = createBlipAttachedTo(mar,53)
	setElementData(mar,"num",mt)
	exports.NGCdxmsg:createNewDxMessage(root,"Flag has been placed on the map! Find it and deliver it! Look for the white flag blip.",0,255,0)
	whoHasIt=false
end

theTimingStart = setTimer(createArmour,2000000,1)
--theTimingStart = setTimer(createArmour,5000,1)
--setTimer(createArmour,5000,1)



function onCalcTimer ( theTime )
	if ( theTime >= 60000 ) then
		local plural = ""
		if ( math.floor((theTime/1000)/60) >= 2 ) then
			plural = "s"
		end

		return tostring(math.floor((theTime/1000)/60) .. " minute" .. plural)
	else
		local plural = ""
		if ( math.floor((theTime/1000)) >= 2 ) then
			plural = "s"
		end

		return tostring(math.floor((theTime/1000)) .. " second" .. plural)
	end
end

showTime = function( thePlayer )
	if exports.server:isPlayerLoggedIn(thePlayer) then
		local robType = "(Armor)"
		if ( isTimer(theTimingStart) ) then
			local timeLeft, timeExLeft, timeExMax = getTimerDetails(theTimingStart)
			exports.NGCdxmsg:createNewDxMessage( thePlayer, "Time left until next mini-event: " .. onCalcTimer ( math.floor( timeLeft ) ) .. " "..robType, 225, 0, 0 )
		elseif not isTimer(theTimingStart) then
			exports.NGCdxmsg:createNewDxMessage(thePlayer,robType.." is ready look at flag blip in LV!")
		else
			exports.NGCdxmsg:createNewDxMessage( thePlayer, "There is no event here anytime soon! "..robType)
		end
	end
end
addCommandHandler ( "armorevent",showTime)

addEventHandler("onMarkerHit",root,
	function (player,dim)
		if ( source == mar ) then
			if not dim then return false end
			if getElementType(player) == "player" then
				if getElementData(player,"isPlayerArrested") then
					exports.NGCdxmsg:createNewDxMessage(player,"You can't take the Armour while you are arrested",255,0,0)
					return
				end
				if exports.AURgames:isPlayerSigned(player) then
					exports.NGCdxmsg:createNewDxMessage(player,"You can't take the Armour while you are signed up in mini games",255,0,0)
					return
				end
				if not isPedOnGround(player) then
					exports.NGCdxmsg:createNewDxMessage(player,"You can't take the Armour while you are not on ground",255,0,0)
					return
				end
				if getPlayerTeam(player) and getTeamName(getPlayerTeam(player)) ~= "Criminals" and getTeamName(getPlayerTeam(player)) ~= "HolyCrap" then
					exports.NGCdxmsg:createNewDxMessage(player,"Sorry you are not criminal to hold this armor",255,0,0)
					return
				end
				if dim then
				local x,y,z = getElementPosition(player)
				local data = getElementData(mar,"num")
				--local data = tonumber(data)
				local data = math.random(data)
				destroyElement(mar)
				destroyElement(ob)
				destroyElement(bl)
				if isElement(bl) then destroyElement(bl) end
				if isElement(ob) then destroyElement(ob) end
				if isElement(mar) then destroyElement(mar) end
				setElementData(player,"isPlayerFlagger",true)
				setElementData(player,"armor",true)
				atArmour = createObject(1242,x,y,z)
				setElementData(atArmour,"num",data)
				exports.bone_attach:attachElementToBone(atArmour,player,12,0,0.05,0.27,0,480,0)
				bli = createBlipAttachedTo(player,53)
				whoHasIt=player
				exports.NGCdxmsg:createNewDxMessage(player,"Deliver The Armour to the white flag blip on your map",255,255,0,true)
				marker = createMarker(mark[data][1],mark[data][2],mark[data][3],"checkpoint",1.5,255,255,0,255,player)
				marBli = createBlipAttachedTo(marker,53,2,255,0,0,255,0,99999.0,player)
				setElementVisibleTo ( marBli, root, false )
				setElementVisibleTo ( marBli, player, true )
				truckDM = createColCircle(mark[data][1],mark[data][2],30)
				attachElements(truckDM,marker)
				triggerClientEvent("addArmorCol",root,truckDM)
				local arpedid = math.random( 28, 29 )
				armped = createPed( arpedid, mark[data][1],mark[data][2],mark[data][3] )
				--CheckVehicleTimer = setTimer(checkForVehicle,1000, 0)

				end
			end
		end
	end
)

addEventHandler("onServerPlayerLogin",root,function()
	if truckDM and isElement(truckDM) then
		triggerClientEvent(source,"addArmorCol",source,truckDM)
	end
end)


function dropArmour(player,force)

		if isElement(atArmour) then
			local data = getElementData(atArmour,"num")
			local data = tonumber(data)
			local x,y,z = getElementPosition(player)
			setElementData(player,"isPlayerFlagger",false)
			setElementData(player,"armor",false)
			exports.bone_attach:detachElementFromBone(atArmour)
			whoHasIt=false
			if isElement(atArmour) then destroyElement(atArmour) end
			if isElement(truckDM) then destroyElement(truckDM) end
			if isElement(marker) then destroyElement(marker) end
			if isElement(marBli) then destroyElement(marBli) end
			if isElement(bli) then destroyElement(bli) end
			if isElement(armped) then destroyElement(armped) end

			if z < 11 or z == nil then z = 11 end
			if exports.server:getPlayChatZone(player) ~= "LV" then
				local mt = math.random(#Armour)
				x,y,z = Armour[mt][1],Armour[mt][2],Armour[mt][3]
			end
			if isElementInWater(player) then
				local mt = math.random(#Armour)
				x,y,z = Armour[mt][1],Armour[mt][2],Armour[mt][3]
			end
			ob = createObject(1242,x,y,z)
			setElementCollisionsEnabled(ob,false)
			mar = createMarker(x,y,z,"checkpoint",0.5,0,255,0,120)
			exports.NGCdxmsg:createNewDxMessage(root,"The Armour has been dropped in the city, please check white flag blip to gain it!",0,255,0)
			setElementData(mar,"num",data)
			bl = createBlipAttachedTo(mar,53)
			---if isTimer(CheckVehicleTimer) then killTimer(CheckVehicleTimer) end
		end
end

addEventHandler("onPlayerWasted",root,
	function ()
		if whoHasIt==source then
			dropArmour(source)
		end
	end
)

addEventHandler("onPlayerQuit",root,
	function ()
		if whoHasIt==source then
			dropArmour(source)
		end
	end
)

local weps = {
	27,26,30,31

}

quitDetect = {}
addEvent("setPlayerQuit",true)
addEventHandler("setPlayerQuit",root,function()
	quitDetect[source] = true
	exports.CSGaccounts:forceWeaponSync(source)
end)


addEventHandler("onPlayerCommand",root,function(cmd)
	if cmd == "reconnect" or cmd == "quit" or cmd == "disconnect" or cmd == "exit" or cmd == "connect" then
		quitDetect[source] = true
		exports.CSGaccounts:forceWeaponSync(source)
	end
end)

addEventHandler("onMarkerHit",root,
	function (player,dim)
		if ( source == marker ) then
			if not dim then return false end
			if getElementType(player) == "player" then
				if player~=whoHasIt then return end
				local px,py,pz = getElementPosition ( player )
				local mx, my, mz = getElementPosition ( source )
				if ( pz-3.5 < mz ) and ( pz+3.5 > mz ) then
					if getElementData(player,"isPlayerArrested") then
						exports.NGCdxmsg:createNewDxMessage(player,"You can't drop the Armour while you are arrested",255,0,0)
						return
					end
					if exports.AURgames:isPlayerSigned(player) then
						exports.NGCdxmsg:createNewDxMessage(player,"You can't drop the Armour while you are signed up in mini games",255,0,0)
						return
					end

					whoHasIt=false
					setElementData(player,"armor",false)
					exports.bone_attach:detachElementFromBone(atArmour)
					if isElement(truckDM) then destroyElement(truckDM) end
					if isElement(marker) then destroyElement(marker) end
					if isElement(marBli) then destroyElement(marBli) end
					if isElement(bli) then destroyElement(bli) end
					if isElement(atArmour) then destroyElement(atArmour) end
					if isElement(armped) then destroyElement(armped) end

					--local APS = exports.AURpoints:getAuroraPoints(player)
					local name = getPlayerName(player)
					exports.NGCdxmsg:createNewDxMessage( player, "You have been rewarded an Armour, $40000, and +5 score", 255, 100, 0,true )
					for k,v in pairs(getElementsByType("player")) do
						exports.NGCdxmsg:createNewDxMessage( v, name.." has delivered the armour successfully!", 0, 255, 0 )
					end
					triggerClientEvent(player,"onShowMoney",player)
					exports.CSGscore:givePlayerScore( player, rewardScore )
					exports.CSGgroups:addXP(player,10)
					local fl = exports.DENstats:getPlayerAccountData ( player, "flags" )
					if not fl or fl == false or fl == nil then fl = 0 end
					exports.DENstats:setPlayerAccountData ( player, "flags", fl + 1 )
					theTimingStart = setTimer( createArmour, 2000000, 1 )
					if quitDetect[player] then return false end
					--givePlayerMoney( player, rewardMoney )
					exports.AURpayments:addMoney(player, rewardMoney,"Custom","Event",0,"NGCarmo Armour Robber")

					--exports.AURpoints:givePlayerAPS(player,10)
					---setElementData(player,"APS",APS+10)
					if isTimer(FTWTimer) then killTimer(FTWTimer) end
					setPedArmor( player, 100 )
					weaponType = 35
					amm = 3
					setElementData(player,"isPlayerFlagger",false)
					---if isTimer(CheckVehicleTimer) then killTimer(CheckVehicleTimer) end
					if not (exports.DENlaw:isLaw(player)) then
						setElementData( player, "wantedPoints", getElementData( player, "wantedPoints" ) + 30 )
					end
					local can,msg = exports.NGCmanagement:isPlayerLagging(source)
					if not can then
						exports.NGCdxmsg:createNewDxMessage(source,"You are lagging you cant get flag weapon reward",255,0,0)
						return false
					end
					local weaponSlot = getSlotFromWeapon(getWeaponIDFromName("Rocket Launcher"))
					local playerAmmo = getPedTotalAmmo(player,weaponSlot)
					if getPedWeapon(player,weaponSlot) == 35 then
						weaponType = 35
						amm = 3
						local total = 3 + playerAmmo
						if total > 100 then
							exports.NGCdxmsg:createNewDxMessage(player, "You have enough amount we can't give you "..amm.." of "..getWeaponNameFromID(weaponType),255,100,0,true)
							return
							false
						end
					end
					if getPedWeapon(player,weaponSlot) == 38 then
						weaponType = 38
						amm = 500
						local total = 500 + playerAmmo
						if total > 9000 then
							exports.NGCdxmsg:createNewDxMessage(player, "You have enough amount we can't give you "..amm.." of "..getWeaponNameFromID(weaponType),255,100,0,true)
							return
							false
						end
					end
					if quitDetect[player] then return false end
					giveWeapon(player,weaponType,amm)
					exports.NGCdxmsg:createNewDxMessage(player, "You've been rewarded "..amm.." of "..getWeaponNameFromID(weaponType),255,100,0,true)

				end
			end
		end
	end
)

addEventHandler("onVehicleStartEnter",root,
	function (player)
		if whoHasIt == player then
			cancelEvent()
			exports.NGCdxmsg:createNewDxMessage(player,"You can not enter a vehicle while holding the armour!",255,0,0,true)
		end
	end
)

addEventHandler("onPlayerContact",root,
	function (old,new)
		if whoHasIt == source and isElement(new) then

			exports.NGCdxmsg:createNewDxMessage(source,"You're not allowed to stand on vehicles while holding The Armour!",255,0,0,true)
		end
	end
)

addEventHandler("onSetPlayerJailed",root,function()
	if getElementData(source,"isPlayerFlagger") then
		dropArmour(source,"reset")
	end
end)
addEventHandler("onPlayerSetArrested",root,function()
	if getElementData(source,"isPlayerFlagger") then
		dropArmour(source)
	end
end)

function checkingTimer()
	for k,v in ipairs(getElementsByType("player")) do
		if whoHasIt and isElement(whoHasIt) then
			if whoHasIt and v == whoHasIt then
				local elementStandingOn = getPedContactElement (v)
				if elementStandingOn and getElementType(elementStandingOn) == "vehicle" then
					dropArmour(v)
				end
				if isElement(whoHasIt) then
					if isPedInVehicle(whoHasIt) or isElementAttached(whoHasIt) then
						dropArmour(v)
						exports.NGCdxmsg:createNewDxMessage(player,"You can not enter or /glue to a vehicle while holding the armour!",255,0,0,true)
					end
				end
				if getElementDimension(whoHasIt) ~= 0 then
					dropArmour(v)
				end
				if getElementData(whoHasIt,"isPlayerArrested") then
					dropArmour(v)
				end
				if exports.AURgames:isPlayerSigned(whoHasIt) then
					dropArmour(v)
				end
				if isElementInWater(v) then
					dropArmour(v,"reset")
				end
				local can,msg = exports.NGCmanagement:isPlayerLagging(whoHasIt)
				if can then
				else
					if msg == "False client connection!" or msg == "You're lagging due packet loss!" or msg == "Warning: Huge packet loss" then
						exports.NGCdxmsg:createNewDxMessage(whoHasIt,"The Armour was dropped from you due packet loss lag",255,0,0)
						dropArmour(v)
					end
				end
				if exports.server:getPlayChatZone(whoHasIt) ~= "LV" then
					dropArmour(v,"reset")
				end
			end
		end
	end
end
