local markers = {}

local markers2 = {}

local peds = { }

local MainTable = { }

local pickups = { }

local playersRobbing = { }

local robbers = { }

local beg = {}

local Gays = {}

drugs = {
	{"Ritalin"},
	{"Weed"},
	{"LSD"},
	{"Cocaine"},
	{"Ecstasy"},
	{"Heroine"},
}


local positions = {

	-- enter marker position 1,2,3

	-- leave marker position 4,5,6

	-- where you warp inside 7,8,9

	-- rotation warp in 10

	-- where you warp outside 11,12,13

	-- rotation warp out 14

	-- shop name 15

	{x=1072.26, y=-1221.36, z=16.89,xx=1053.56, yy=-1227.68, zz=-14.5,x3=1056.26,y3=-1227.91,z3=-13.68,r1=268,x4=1068.84, y4=-1221.25, z4=16.89,r2=88,name="Electronic Shop",ints=0,de=0},

	{x=1290.73, y=-1161.22, z=23.96 ,xx=1297, yy=-1192.26, zz=-59.18,x3=1297,y3=-1189,z3=-59,r1=358,x4=1290,y4=-1156,z4=24,r2=350,name="Global Shop",ints=0,de=0},

	{x=2423.98, y=-1954.92, z=13.54,xx=-31.03, yy=-91.61, zz=1003.54,x3=-31.2,y3=-89.21,z3=1003.54,r1=357,x4=2421,y4=-1956,z4=13,r2=89,name="24/7 Tiny Store",ints=18,de=500},

	{x=2481.47, y=-1494.7, z=24,xx=418.56, yy=-84.37, zz=1001.8,x3=418.62,y3=-82.38,z3=1001.8,r1=359,x4=2481.38,y4=-1496.84,z4=24,r2=179,name="Barber",ints=3,de=500},

	{x=1072.14, y=-1354.02, z=13.55,xx=1212.16, yy=-26.07, zz=1000.95,x3=1212.25,y3=-29.17,z3=1000.95,r1=179,x4=1068,y4=-1354.02,z4=13.55,r2=90,name="Big spread ranch nighclub",ints=3,de=500},

	{x=2267.8,y=-1671.3,z=15.3,xx=285.82, yy=-86.76, zz=1001.5,x3=285.8,y3=-84.5,z3=1001.5,r1=356,x4=2267,y4=-1667.9,z4=16,r2=1,name="Grove Weapons",ints=4,de=0},

	{x=1928.5, y=-1776, z=13.54,xx=-31.03, yy=-91.61, zz=1003.54,x3=-31.2,y3=-89.21,z3=1003.54,r1=357,x4=1931,y4=-1776.27,z4=13.54,r2=268,name="Fuel Station Store",ints=18,de=501},

	{x=840.7, y=-1628.19, z=13.54,xx=858, yy=-1624.3, zz=-61.1,x3=860.8,y3=-1623,z3=-61,r1=293,x4=840,y4=-1625,z4=13.5,r2=356,name="Drug house",ints=0,de=0},
	--{x=, y=, z=,xx=, yy=, zz=,x3=,y3=,z3=,r1=,x4=,y4=,z4=,r2=,name="",ints=,de=},

}



local pedsTable = { --id, x, y, z, rotz, int, dim,blipx and blip y

	{147,1055.64, -1225.04, -15,178,0,0,1072.26, -1221.36,"Cash"},

	{193,1283.2, -1180.86, -59.18,268,0,0,1283.2, -1180.86,"Cash"},

	{216,-27.94, -91.64, 1003.54,357,18,500,2423.97,-1954.93,"Cash"},

	{308,418.4, -75.45, 1001.8,171,3,500,2481.46,-1494.7,"Cash"},

	{308,1206,-30,1001,270,3,500,1072.14,-1354.03,"Cash"},

	{105,293.59,-84.45,1001,89,4,0,2267.8,-1671,"Weapons"},

	{305,-27.94, -91.64, 1003.54,357,18,501,1928.9,-1775.9,"Fuel"},

	{306,867.4,-1620.3,-61.5,107,0,0,841,-1626,"Drugs"},

}




local pedsmiscs = {





}








for k,v in ipairs(positions) do

	markers = createMarker(v.x,v.y,v.z+1,"arrow",2,255,0,0)

	markers2 = createMarker(v.xx,v.yy,v.zz+1,"arrow",2,255,0,0)
	setElementData(markers,"shopName",v.name)
	---blip = createBlipAttachedTo(markers,44)

	--setBlipVisibleDistance(blip,200)

	setElementInterior(markers2,v.ints)

	setElementDimension(markers2,v.de)

	addEventHandler("onMarkerHit",markers,function(hitElement,dimx)

		if dimx then

			if getElementType(hitElement) == "player" then
				if getElementData(hitElement,"isPlayerArrested") then
					return false
				end
				--if not getElementData(hitElement,"isPlayerPrime") then
				--	outputChatBox("Store robbery under development",hitElement,255,0,0)
				--	return false
				--end
				if exports.server:isPlayerDamaged(hitElement) then
					exports.NGCdxmsg:createNewDxMessage(hitElement,"You can't enter this interior while damage",255,0,0)
					return false
				end
				if getElementData(hitElement,"Interior") then
					exports.NGCdxmsg:createNewDxMessage(hitElement,"You can't enter this interior at the moment!",255,0,0)
					return false
				end
				if isPedInVehicle(hitElement) then return false end
				if getElementHealth(hitElement) < 3 then
					exports.NGCdxmsg:createNewDxMessage(hitElement,"You can't enter this interior while you are dead",255,0,0)
					return false
				end
				setElementData(hitElement,"shopName",v.name)
				local prox,proy,proz = getElementPosition(hitElement)
				triggerEvent("setInteriorReturnData",hitElement,prox,proy,proz)

				exports.NGCdxmsg:createNewDxMessage(hitElement,"Dont rob this store alone , get more criminals to get more earnings",255,2550,0)
				exports.NGCdxmsg:createNewDxMessage(hitElement,"As more as criminals join this store to rob as much as you get reward ( 1 Robber : $12,000 )",255,0,0)
				setElementPosition(hitElement,v.x3,v.y3,v.z3)

				setElementInterior(hitElement,v.ints)

				setElementDimension(hitElement,v.de)
				setElementData(hitElement,"isPlayerRobbingStore",true)
				setPedRotation(hitElement,v.r1)
				triggerClientEvent(hitElement,"setSpawnRotation",hitElement,v.r1)



				exports.NGCdxmsg:createNewDxMessage(hitElement,"Aim on ped to start robbing",255,255,0)




			end

		end

	end)

	addEventHandler("onMarkerHit",markers2,function(hitElement,dimx)

		if dimx then

			if getElementType(hitElement) == "player" then
				if isPedInVehicle(hitElement) then return false end
				setElementData(hitElement,"shopName",false)

				setElementPosition(hitElement,v.x4,v.y4,v.z4)

				setElementInterior(hitElement,0)

				setElementDimension(hitElement,0)
				setElementData(hitElement,"isPlayerRobbingStore",false)
				setPedRotation(hitElement,v.r2)
				triggerEvent("setInteriorStopReturnPlayer",hitElement)
				---setTimer(setPedRotation,2000,1,hitElement,v.r2)

			end

		end

	end)

end




myBlip = {}
function createPeds ()

	for i=1, #pedsTable do

		local ped = createPed ( pedsTable[i][1], pedsTable[i][2], pedsTable[i][3], pedsTable[i][4], pedsTable[i][5] )
		setElementInterior ( ped, pedsTable[i][6] )
		--triggerClientEvent("synceStoresBlips",root,pedsTable[i][8], pedsTable[i][9],ped,"notrobbed")
		doBlip(ped,pedsTable[i][8], pedsTable[i][9], 30,38)
		--table.insert(theBlips,myBlip[ped])
		setElementDimension ( ped, pedsTable[i][7] )
		setElementData(ped,"pedReward",pedsTable[i][10])
		setElementData(ped,"blipPosition",{pedsTable[i][8], pedsTable[i][9], 30})
		setElementFrozen ( ped, true )

		peds[ (#peds +1) ] = ped

		MainTable[ ped ] = { false, 0, { } }

	end

	setTimer(triggerClientEvent, 1000, 1, "syncPeds", root, peds)

	addEventHandler( "onServerPlayerLogin", root, function() setTimer(triggerClientEvent, 1000, 1, "syncPeds", root, peds) end )

end

setTimer(createPeds,5000,1)


function doBlip(ped,x,y,z,id)
	if isElement(myBlip[ped]) then destroyElement(myBlip[ped]) end
	myBlip[ped] = createBlip( x,y,z,id, 0.001, 0, 0, 0,55,0,500)
end



function onPlayerTarget ( target )
	if source and target and getElementType(source) == "player" and getElementType(target) == "ped" then
		if exports.DENlaw:isLaw(source) then return end
		if getPlayerTeam(source) then
			if (getTeamName(getPlayerTeam(source)) ~= "Criminals" and getTeamName(getPlayerTeam(source)) ~= "HolyCrap") then return end

			if ( playersRobbing[ source ] ) then return end

			for i, v in ipairs ( peds ) do

				if ( target == v ) and ( getPedWeaponSlot ( source ) ~= 0 ) and ( getPedWeaponSlot ( source ) ~= 10 ) and ( getPedWeaponSlot ( source ) ~= 11 ) and ( getPedWeaponSlot ( source ) ~= 12 ) then

				if ( isTimer(beg[target]) ) then

					local timeLeft, timeExLeft, timeExMax = getTimerDetails(beg[target])

					exports.NGCdxmsg:createNewDxMessage( source, "Time left until next robbery for this store: " .. onCalculateTime ( math.floor( timeLeft ) ) .. " ", 225, 0, 0 )

					return

				end

					if not ( MainTable[v][1] ) then

						triggerClientEvent ( "checkForPlayerAim", source, "newRob", v )

					else

						triggerClientEvent ( "checkForPlayerAim", source, "joinRob", v )

					end

				end

			end
		end
	end

end

addEventHandler( "onPlayerTarget", root, onPlayerTarget )



addEvent("startStoreRob", true)

function startStoreRob ( ped )

	if ( playersRobbing[ source ] ) then return end

	if not Gays[ped] then Gays[ped] = {} end

	playersRobbing[ source ] = true

	local robbers = MainTable[ped][3]

	robbers[1] = source

	table.insert(Gays[ped],source)

	MainTable[ped] = { true, 1, robbers }

	exports.server:givePlayerWantedPoints(source,30)

	setTimer ( spawnMoney, 63000, 1, ped,source )

	setTimer( endStoreRob, 90000, 1, ped, source )

	triggerClientEvent ( "startStoreRob", root, source, ped )

end

addEventHandler("startStoreRob", root, startStoreRob)


robbersCount = {}

addEvent("addPlayerToStoreRob", true)

function addPlayerToStoreRob ( ped )

	if ( playersRobbing[ source ] ) then return end

	if not Gays[ped] then Gays[ped] = {} end

	playersRobbing[ source ] = true

	local numberOfRobbers = MainTable[ ped ][ 2 ]

	local robbers = MainTable[ped][3]

	robbers[#robbers+1] = source

	table.insert(Gays[ped],source)

	MainTable[ped] = { true, numberOfRobbers + 1, robbers }

	exports.server:givePlayerWantedPoints(source,30)

	triggerClientEvent ( "addPlayerToStoreRob", root, source, ped )

end

addEventHandler("addPlayerToStoreRob", root, addPlayerToStoreRob)

addEventHandler("onPlayerQuit",root,function()
	if playersRobbing[source] then
		for k,v in ipairs(getElementsByType("ped",resourceRoot)) do
			if Gays[v] then
				for k2,v2 in ipairs(Gays[v]) do
					if v2 == source then
						table.remove(Gays[v],k2)
						break
					end
				end
			end
		end
	end
end)
addEventHandler("onPlayerJailed",root,function()
	if playersRobbing[source] then
		for k,v in ipairs(getElementsByType("ped",resourceRoot)) do
			if Gays[v] then
				for k2,v2 in ipairs(Gays[v]) do
					if v2 == source then
						table.remove(Gays[v],k2)
						break
					end
				end
			end
		end
	end
	setElementData(source,"isPlayerRobbingStore",false)
end)
addEventHandler("onPlayerWasted",root,function()
	if playersRobbing[source] then
		for k,v in ipairs(getElementsByType("ped",resourceRoot)) do
			if Gays[v] then
				for k2,v2 in ipairs(Gays[v]) do
					if v2 == source then
						table.remove(Gays[v],k2)
						break
					end
				end
			end
		end
	end
	setElementData(source,"isPlayerRobbingStore",false)
end)
addEventHandler("onPlayerArrest",root,function()
	if playersRobbing[source] then
		for k,v in ipairs(getElementsByType("ped",resourceRoot)) do
			if Gays[v] then
				for k2,v2 in ipairs(Gays[v]) do
					if v2 == source then
						table.remove(Gays[v],k2)
						break
					end
				end
			end
		end
	end
	setElementData(source,"isPlayerRobbingStore",false)
end)

addEvent("abortStoreRobbery",true)

function abortRobbery(ped)

	triggerClientEvent(source,"endTheRobbery",source,source)

	endStoreRob (ped)

	Gays[ped] = {}

	exports.NGCdxmsg:createNewDxMessage(source,"Store robbery failed due you are arrested/jailed",255,0,0)

end

addEventHandler("abortStoreRobbery",root,abortRobbery)

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

addEventHandler("onPlayerQuit",root,function()
	quitDetect[source] = true
	exports.CSGaccounts:forceWeaponSync(source)
end)


function spawnMoney ( ped,player )

	local x, y, z = getElementPosition ( ped )

	local rx, ry, rz = getElementRotation ( ped )

	x = x - math.sin ( math.rad ( rz ) ) * 2

	y = y + math.cos ( math.rad ( rz ) ) * 2

	local pickup =  createPickup ( x, y, z, 3, 1212 )

	local int, dim = getElementInterior ( ped ), getElementDimension ( ped )

	setElementInterior ( pickup, int )

	setElementDimension ( pickup, dim )

	pickups[pickup] = ped

	for k,v in pairs(Gays[ped]) do

		exports.NGCdxmsg:createNewDxMessage( v, "Take the cash within 60 seconds", 0, 255, 0 )

	end

	setTimer(function (pickup) if ( isElement ( pickup ) ) then destroyElement ( pickup ) end end, 45000, 1, pickup)

	addEventHandler ( "onPickupHit", pickup, function ( hitElement )
		if getPlayerTeam(hitElement) and (getTeamName(getPlayerTeam(hitElement)) == "Criminals" or getTeamName(getPlayerTeam(hitElement)) == "HolyCrap") then

			if ( isElement ( source ) ) then destroyElement ( source ) end

			local ped = pickups[source]

			pickups[source] = nil

			--local numberOfRobbers = MainTable[ped][2]
			local numberOfRobbers = #Gays[ped]

			local moneyAmount = 15000

			---local moneyAmount = math.floor(moneyAmount * ( numberOfRobbers+( 0.1*(numberOfRobbers+1) ) ))

			local moneyAmount = math.floor(moneyAmount*numberOfRobbers*0.5)
			--local moneyAmount = math.floor(moneyAmount*numberOfRobbers)
			local drugType = unpack( drugs [math.random( #drugs )] )
			local drugAmmo = math.random( 20, 40 )
			for k,v in pairs(Gays[ped]) do
				if quitDetect[v] then return false end
				local t = exports.DENstats:getPlayerAccountData(v,"storescrimsuccess")
				if not t or t == 0 or t == false then t = 0 end
				exports.DENstats:setPlayerAccountData(v,"storescrimsuccess",t+1)
				exports.AURpayments:addMoney(v,moneyAmount,"Custom","Event",0,"CnR Stores Robbery")
				exports.CSGgroups:addXP(v,7)
				exports.AURcriminalp:giveCriminalPoints(v, "", 5)
				exports.NGCdxmsg:createNewDxMessage( v, "You have picked up $"..moneyAmount, 0, 255, 0 )

				exports.NGCdxmsg:createNewDxMessage( v, "You have successfully robbed the store", 0, 255, 0 )
				if getElementData(ped,"pedReward") == "Drugs" then
					if quitDetect[v] then return false end
					exports.CSGdrugs:giveDrug( v, drugType, drugAmmo)
					exports.NGCdxmsg:createNewDxMessage(v,"[Store robbery]: This is Drugs house store so you earned "..drugAmmo.." of "..drugType.." from robbing it!",255,255,0)
				end
				if getElementData(ped,"pedReward") == "Fuel" then
					if exports.DENstats:getPlayerAccountData(v,"gsc") < 0 then
						exports.DENstats:setPlayerAccountData(v,"gsc",0)
					elseif exports.DENstats:getPlayerAccountData(v,"gsc") >= 3 then
						exports.DENstats:setPlayerAccountData(v,"gsc",2)
					end
					exports.DENstats:setPlayerAccountData(v,"gsc",exports.DENstats:getPlayerAccountData(v,"gsc")+1)
					triggerClientEvent(v,"recgsc",v,exports.DENstats:getPlayerAccountData(v,"gsc"))
					exports.NGCdxmsg:createNewDxMessage(v,"[Store robbery]: This is Fuel station so you earned 1 fuel conister from robbing it!",255,255,0)
				end
				if getElementData(ped,"pedReward") == "Weapons" then
					local can,msg = exports.NGCmanagement:isPlayerLagging(v)
					if can then
						if getPedWeapon(v,5) == 31 then
							if quitDetect[v] then return false end
							giveWeapon(v,31,200,true)
							exports.CSGaccounts:forceWeaponSync(v)
							exports.NGCdxmsg:createNewDxMessage(v,"[Store robbery]: This is Ammunation store so you earned 100 ammo of M4",255,255,0)
						elseif getPedWeapon(v,5) == 30 then
							if quitDetect[v] then return false end
							giveWeapon(v,30,200,true)
							exports.CSGaccounts:forceWeaponSync(v)
							exports.NGCdxmsg:createNewDxMessage(v,"[Store robbery]: This is Ammunation store so you earned 100 ammo of AK-47",255,255,0)
						else
							if quitDetect[v] then return false end
							giveWeapon(v,31,200,true)
							exports.CSGaccounts:forceWeaponSync(v)
							exports.NGCdxmsg:createNewDxMessage(v,"[Store robbery]: This is Ammunation store so you earned 100 ammo of M4",255,255,0)
						end
					else
						exports.NGCdxmsg:createNewDxMessage(v,"[Store robbery]: We can't give you weapon because you are lagging due "..msg,255,0,0)
					end
				end
			end
		end
	end)

end


function endStoreRob ( ped )

	local robbers = MainTable[ped][3]

	for i, v in ipairs(robbers) do

		playersRobbing[ v ] = nil

	end

	MainTable[ ped ] = { false, 0, { } }
	local x,y,z = unpack(getElementData(ped,"blipPosition"))
	setElementData(ped,"robbed",true)
	doBlip(ped,x,y,z,36)
	beg[ped] = setTimer(function(pe)
		local x,y,z = unpack(getElementData(pe,"blipPosition"))
		setElementData(pe,"robbed",false)
		doBlip(pe,x,y,z,38)
	end,3000000,1,ped)

	Gays[ped] = {}

end
--[[
addEventHandler("onServerPlayerLogin",root,function()
	for k,v in ipairs(getElementsByType("ped",resourceRoot)) do
		if getElementData(v,"robbed") then
			local x,y = unpack(getElementData(v,"blipPosition"))
		else
			local x,y = unpack(getElementData(v,"blipPosition"))
		end
	end
end)
]]




function onCalculateTime ( theTime )

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

