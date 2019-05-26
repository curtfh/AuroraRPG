hospitals = {
	--{ x, y, z, rot},
	--LS
	{ 1190.9, -1366.46, 8572, 1, "All Saints"}, --All Saints
	{ 2040.7, -1417.03, 8572 ,4, "Jefferson"}, --Jefferson
	{ 1240.54, 333.18, 8572, 2, "Montgomery"}, --Montgomery
	--SF
	{ -2209.08, -2315.81, 8572, 0.5, "Whetstone"}, --Whetstone
	{ -2659.04, 633.36, 8572 , 0.2, "Santa Flora"}, --Santa Flora
	--LV
	{ 1588.56, 1785.28, 8572,0.5, "Las Venturas"}, --LV Airport
	{ -1510.19, 2533.55, 8572, 1, "El Quebrados"}, --El Quebrados
	{ -259.02, 2583.64, 8572, 1, "Las Payasadas"}, --Las Payasadas
	{  -308.75, 1030.72, 8572, 1, "Fort Carson"}, --Fort Carson
}

local houseData = {
	
-- Leaving positions for the doors
[1] = {3, 235.23, 1186.67, 1080.25},
[2] = {2, 226.78, 1239.93, 1082.14},
[3] = {1, 223.07, 1287.08, 1082.13},
[4] = {15, 327.94, 1477.72, 1084.43},
[5] = {2, 2468.84, -1698.36, 1013.5},
[6] = {5, 226.29, 1114.27, 1080.99},
[7] = {15, 387.22, 1471.73, 1080.18},
[8] = {7, 225.66, 1021.44, 1084},
[9] = {8, 2807.62, -1174.76, 1025.57},
[10] = {10, 2270.41, -1210.53, 1047.56},
[11] = {3, 2496.05, -1692.09, 1014.74},
[12] = {10, 2259.38, -1135.9, 1050.63},
[13] = {8, 2365.18, -1135.6, 1050.87},
[14] = {5, 2233.64, -1115.27, 1050.88},
[15] = {11, 2282.82, -1140.29, 1050.89},
[16] = {6, 2196.85, -1204.45, 1049.02},
[17] = {6, 2308.76, -1212.94, 1049.02},
[18] = {1, 2218.4, -1076.36, 1050.48},
[19] = {2, 2237.55, -1081.65, 1049.02},
[20] = {9, 2317.77, -1026.77, 1050.21},
[21] = {6, 2333, -1077.36, 1049.02},
[22] = {5, 1260.64, -785.34, 1091.9},
[23] = {1, 243.71, 305.01, 999.14},
[24] = {2, 266.49, 304.99, 999.14},
[25] = {12, 2324.31, -1149.55, 1050.71},
[26] = {5, 318.57, 1114.47, 1083.88},
[27] = {1, 243.71, 304.96, 999.14},
[28] = {5, 140.32, 1365.91, 1083.86},
[29] = {6, 234.13, 1063.72, 1084.2},
[30] = {9, 83.04, 1322.28, 1083.85},
[31] = {10, 23.92, 1340.16, 1084.37},
[32] = {15, 377.15, 1417.3, 1081.32},
[33] = {5, 1298.87, -797.01, 1084, 1015.4990}
}

local timing = {}
local playerStats = { }
local wepTimer = {}
local fuckingCunt = {}
local lawTimer = {}
local timerex = {}


function findNearestHostpital(thePlayer)
	local nearest = nil
	local min = 999999
	for key,val in pairs(hospitals) do
		local xx,yy,zz=getElementPosition(thePlayer)
		local x1=val[1]
		local y1=val[2]
		local z1=val[3]
		local pR=val[4]
		local hN=val[5]
		local dist = getDistanceBetweenPoints2D(xx,yy,x1,y1)
		if dist<min then
			nearest = val
			min = dist
		end
	end
	return nearest[1],nearest[2],nearest[3],nearest[4],nearest[5],nearest[6],nearest[7],nearest[8]
end

function giveStats(player)
	if player then
		if ( playerStats [ player ] ) then
			for k, stats in pairs ( playerStats [ player ] ) do
				setPedStat(player,k,stats)
				if tonumber(k) == 73 then
					if getPedStat(player,k) > 950 then
						setPedStat(player,k,950)
					else
						setPedStat(player,k,stats)
					end
				end
			end
		else
			giveAccountStats(player)
		end
	playerStats [ player ] = nil


	setTimer(function(player) if player and isElement(player) then setElementAlpha(player, 255 ) setElementData(player,"safezone",false) end end,20000,1,player)
	end
end



hotal = {
	--{ x, y, z, rot},
	--LS
	{ 1178.7457275391, -1323.8264160156, 14.135261535645, 270, "All Saints"}, --All Saints
	{ 2032.7645263672, -1416.2613525391, 16.9921875, 132, "Jefferson"}, --Jefferson
	{ 1242.409, 327.797, 19.755, 332, "Montgomery"}, --Montgomery
	--- { 2269.598, -75.157, 26.772, 181, "Palimino Creek"}, custom hospital
	--SF
	{ -2201.1604003906, -2307.6457519531, 30.625, 320, "Whetstone"}, --Whetstone
	{ -2655.1650390625, 635.66253662109, 14.453125, 180, "Santa Flora"}, --Santa Flora
	--LV
	{ 1607.2800292969, 1818.4868164063, 10.8203125, 1, "Las Venturas"}, --LV Airport
	{ -1514.902, 2525.023, 55.783, 0, "El Quebrados"}, --El Quebrados
	{ -254.074, 2603.394, 62.858, 270, "Las Payasadas"}, --Las Payasadas
	{ -320.331, 1049.375, 20.340, 360, "Fort Carson"}, --Fort Carson
}


function findNearest(thePlayer)
  local nearest = nil
  local min = 999999
  for key,val in pairs(hotal) do
    local xx,yy,zz=getElementPosition(thePlayer)
    local x1=val[1]
    local y1=val[2]
    local z1=val[3]
	local pR=val[4]
	local hN=val[5]
    local dist = getDistanceBetweenPoints2D(xx,yy,x1,y1)
    if dist<min then
      nearest = val
      min = dist
    end
  end
  return nearest[1],nearest[2],nearest[3],nearest[4],nearest[5]
end


function giveAccountStats(player)
	if player then
	local playerID = exports.server:getPlayerAccountID(player)
	 local playerStatus = exports.DENmysql:querySingle( "SELECT * FROM playerstats WHERE userid=?", playerID )
		if ( playerStatus ) then
			local wepSkills = fromJSON( playerStatus.weaponskills )
			if ( wepSkills ) then
				for skillint, valueint in pairs( wepSkills ) do
					if ( tonumber(valueint) > 950 ) then
						if tonumber(skillint) == 73 then
							if isElement(player) then setPedStat ( player, tonumber(skillint), 995 ) end
						else
							if isElement(player) then setPedStat ( player, tonumber(skillint), 1000 ) end
						end
					else
						if isElement(player) then setPedStat ( player, tonumber(skillint), tonumber(valueint) ) end
					end
				end
			end
		end
	end
end

addEventHandler("onPlayerWasted", root,
	function(totalAmmo, killer, killerWeapon, bodypart)
		local xx,yy,zz,rot, hName = findNearestHostpital(source)
		if ( not playerStats [ source ] ) then
			playerStats [ source ] = { }
		end
		for i = 69, 79 do
			local stats = getPedStat(source,i)
			if ( stats > 0 ) then
				playerStats [ source ] [i] = stats
			end
		end
		--[[setTimer(function(plr)
		if plr then
		fadeCamera(plr,false)
		end
		end,1000,1,source)
		setTimer(function(plr)
		if plr then
		fadeCamera(plr,true)
		end
		end,3000,1,source)]]
		if killer and isElement(killer) and getElementType(killer) == "player" then
			setCameraTarget(source,killer)
		else
			setCameraTarget(source,source)
		end
		setElementAlpha(source,150)
		setElementData(source,"safezone",true)
		setElementData(source,"elementSkin",getElementModel(source))
		setTimer(function(name,player)
			if player and isElement(player) then
				triggerClientEvent(player,"onServerWasted",player,name,getElementModel(player))
			end
		end,3000,1,hName,source)
		if isTimer(timing[source]) then killTimer(timing[source]) end

	end
)

addEventHandler( "onPlayerQuit",root,
	function()
		if getElementHealth( source ) <= 1 or isPedDead(source) == true then
			local userid = exports.server:getPlayerAccountID( source )
			local xx,yy,zz,rot, hName = findNearestHostpital(source)
			setTimer(function(player,id,x,y,z,r)
					exports.DENmysql:exec("UPDATE `accounts` SET `x`=?, `y`=?, `z`=?, `rotation`=?, `health`=? WHERE `id`=?", x, y, z, r, 100, id )
			end,3000,1,source,userid,xx,yy,zz,rot)
		end
		if isTimer(timing[source]) then killTimer(timing[source]) end
	end
)


function spawnAtHouse (plr, houseName)

	if (isElement(plr)) and (getElementType(plr) == "player") then
		local query = exports.DENmysql:query("SELECT * FROM housing WHERE ownerid=? AND housename=?", exports.server:getPlayerAccountID(plr), houseName)
		if (#query > 0) then
			if isTimer(timing[source]) then killTimer(timing[source]) end
			local intID = query[1].interiorid
			local int,x,y,z,dim = houseData[intID][1], houseData[intID][2], houseData[intID][3], houseData[intID][4], query[1].id
			setElementPosition(plr, x,y,z)
			setElementDimension(plr, dim)
			setElementInterior(plr, int)
			exports.NGCdxmsg:createNewDxMessage(plr,"You have successfully spawned at your "..houseName.." house!",255,255,0)
		end
	end
end
addEvent("AURspawn:spawnAtHouse", true)
addEventHandler("AURspawn:spawnAtHouse", root, spawnAtHouse)

addEvent("spawnToHospital",true)
addEventHandler("spawnToHospital",root,function(x,y,z,rot)
	if isTimer(timing[source]) then killTimer(timing[source]) end
	setElementPosition(source,x,y,z)
	triggerClientEvent(source, "setSpawnRotation", source,rot)
end)


addEvent("spawnPlayer",true)
addEventHandler("spawnPlayer",root,function(model)
	if source and isElement(source) then
		if isTimer(timing[source]) then killTimer(timing[source]) end
		local xx,yy,zz,rot,hName = findNearestHostpital(source)
		if getElementData(source,"isPlayerInLvCol") then
			xx,yy,zz,rot,hName =  1588.56, 1785.28+math.random(-1,2), 8572.5,0.5, "Las Venturas"
		end
		local theMessage = "You have been taken to "..hName.." hospital"
		triggerClientEvent(source, "addHospitalText", source, theMessage)
		setCameraMatrix(source, xx,yy,zz,xx,yy,zz)
		if getElementData(source,"isPlayerVIP") then respawnTimer = 2000 else respawnTimer = 5000 end
		fuckingCunt[source] = setTimer(function(player,model,x,y,z,rotation)
			if player and isElement(player) then
				setCameraTarget(player, player)
				local mode = getElementModel(player)
				spawnPlayer(player, x,y+math.random(-1,2),z+0.5, rotation, mode, 0, 0)
				giveStats(player)
				if exports.server:isPlayerVIP(player) == true then
					setPedArmor( player, 100 )
				end
				local t = fromJSON(exports.CSGaccounts:getPlayerWeaponString(player))
				if t and t~= nil then
				for k,v in pairs(t) do
					giveWeapon(player,k,v)
				end
				end
				if getElementData(player,"isPlayerJailed") then
					setElementDimension(player,2)
					setElementPosition(player,926.36, -2446.03, 5700.42)
				return false end
				if getElementData(player,"wantedPoints") >= 20 then
					if getElementData(player,"Interior") == true then
						if isTimer(timing[player]) then killTimer(timing[player]) end
						return
					end
					if isTimer(timing[player]) then killTimer(timing[player]) end
					timing[player] = setTimer(function(plr)
						if plr and isElement(plr) then
							local oldx,oldy,oldz = getElementPosition(plr)
							if oldz > 5000 then
								local x,y,z = findNearest(plr)
								setElementPosition(plr,x,y,z)
								exports.NGCdxmsg:createNewDxMessage(plr,"You have warped out of hospital due you're wanted!!",255,0,0)
							end
						end
					end,30000,1,player)
				end
				triggerClientEvent(player, "setSpawnRotation",player,rotation)
			end
		end,respawnTimer,1,source,model,xx,yy,zz,rot)
	end
end)

addEvent("onPlayerJailed",true)
addEventHandler("onPlayerJailed",root,function(player)
	if isTimer(timing[player]) then killTimer(timing[player]) end
end)


addEvent("spawnBasePlayer",true)
addEventHandler("spawnBasePlayer",root,function(x,y,z,rot,msg)
	setElementPosition(source,x,y,z)
	triggerClientEvent(source, "setSpawnRotation", source,rot)
	triggerClientEvent(source, "addHospitalText", source, msg)
	setElementData(source,"safezone",false)
	if isTimer(timing[source]) then killTimer(timing[source]) end
end)


addEvent("spawnTurfingPlayer",true)
addEventHandler("spawnTurfingPlayer",root,function(x,y,z,rot)
	local tm = getTeamName(getPlayerTeam(source))
	if (tm == "Criminals") or (tm == "HolyCrap") then 
		local x,y,z,rot = getElementData(source,"x"),getElementData(source,"y"),getElementData(source,"z"),getElementData(source,"rot")
		if x and y and z then
			setElementPosition(source, x,y,z)
			triggerClientEvent(source, "setSpawnRotation", source,rot)
			exports.NGCdxmsg:createNewDxMessage(source, "You have been taken to the nearest turf of your group, "..getElementData(source,"Group").."!",0,255,0)
		else
			exports.NGCdxmsg:createNewDxMessage(source, "You have been taken to Las Venturas hospital. We couldn't find nearest turf for your group.",255,255,0)
			setElementPosition(source,1607.2800292969, 1818.4868164063, 10.8203125)
			triggerClientEvent(source, "setSpawnRotation", source,1)
		end
	elseif (tm == "Government" or tm == "SWAT Team" or tm == "Military Forces") then 
		exports.NGCdxmsg:createNewDxMessage(source, "You have been taken to LVPD.",0,255,0)
		setElementPosition(source,2339.71,2474.04,14.98)
		triggerClientEvent(source, "setSpawnRotation", source,175)
	end 
	if isTimer(timing[source]) then killTimer(timing[source]) end
end)

function openHousesPanel ()

	if (getElementType(source) ~= "player") then return false end
	local wl = getPlayerWantedLevel(source)
	if (wl > 0) then return exports.NGCdxmsg:createNewDxMessage("You can't pass through this door while wanted!",source,255,0,0) end
	local pID = exports.server:getPlayerAccountID(source)
	local qh = exports.DENmysql:query("SELECT * FROM housing WHERE ownerid=?", pID)
	if (#qh > 0) then
		triggerClientEvent(source, "AURspawn:openHousesPanel", source, qh)
	else
		exports.NGCdxmsg:createNewDxMessage("You don't have houses to respawn at!",source,255,0,0)
	end
end
addEvent("AURspawn:openHouseRespawn", true)
addEventHandler("AURspawn:openHouseRespawn", root, openHousesPanel)


function createObjectls(id,x,y,z,r1,r2,r3)
	bl = createObject(id,x,y,z+8000,r1,r2,r3)

end

function createObjectls2(id,x,y,z,r1,r2,r3)
	bl = createObject(id,x+850,y-50,z+8000,r1,r2,r3)

end

function createObjectls3(id,x,y,z,r1,r2,r3)
	bl = createObject(id,x+50,y+1700,z+8000,r1,r2,r3)

end

function createObjectsf(id,x,y,z,r1,r2,r3)
	bl = createObject(id,x-3400,y-950,z+8000,r1,r2,r3)

end
function createObjectsf2(id,x,y,z,r1,r2,r3)
	bl = createObject(id,x-3850,y+2000,z+8000,r1,r2,r3)

end

function createObjectlv(id,x,y,z,r1,r2,r3)
	bl = createObject(id,x+400,y+3150,z+8000,r1,r2,r3)

end

function createObjectlv2(id,x,y,z,r1,r2,r3)
	bl = createObject(id,x-2700,y+3900,z+8000,r1,r2,r3)

end
function createObjectlv3(id,x,y,z,r1,r2,r3)
	bl = createObject(id,x-1450,y+3950,z+8000,r1,r2,r3)

end

function createObjectlv4(id,x,y,z,r1,r2,r3)
	bl = createObject(id,x-1500,y+2400,z+8000,r1,r2,r3)

end



createObjectls(1504,1178.5,-1354,571.7,0,0,90) --- turf door
createObjectls(1505,1178.5,-1348,571.7,0,0,90) --- base door
createObjectls(1507, 1178.172607, -1349.523193, 571.744873, 0.0000, 0.0000, 270.0000)--
createObjectls(14669, 1188.746948, -1350.306396, 571.745300, 0.0000, 0.0000, 270.0000)--
createObjectls(16500, 1178.100952, -1350.264648, 573.038818, 0.0000, 0.0000, 180.0000)--
createObjectls(18001, 1184.308838, -1340.759888, 573.494263, 0.0000, 0.0000, 0.0000)--
createObjectls(18079, 1184.351685, -1340.786133, 573.766785, 0.0000, 0.0000, 180.0000)--
createObjectls(2632, 1180.114258, -1350.337158, 571.716553, 0.0000, 0.0000, 0.0000)--
createObjectls(2185, 1181.094727, -1357.269165, 571.743469, 0.0000, 0.0000, 180.0000)--
createObjectls(1806, 1180.310059, -1358.306396, 571.764954, 0.0000, 0.0000, 0.0000)--
createObjectls(2610, 1179.541992, -1359.595215, 572.570740, 0.0000, 0.0000, 180.0000)--
createObjectls(2610, 1180.030273, -1359.596436, 572.570740, 0.0000, 0.0000, 180.0000)--
createObjectls(2202, 1182.232422, -1359.418091, 571.738220, 0.0000, 0.0000, 180.0000)--
createObjectls(1797, 1194.704590, -1370.338623, 571.738892, 0.0000, 0.0000, 270.0000)--
createObjectls(1797, 1194.731812, -1367.876709, 571.738892, 0.0000, 0.0000, 270.0000)--
createObjectls(1797, 1194.753296, -1365.335449, 571.738892, 0.0000, 0.0000, 270.0000)--
createObjectls(1797, 1194.730835, -1362.682129, 571.738892, 0.0000, 0.0000, 270.0000)--
createObjectls(1726, 1182.289063, -1341.340332, 571.737732, 0.0000, 0.0000, 0.0000)--
createObjectls(1726, 1185.411255, -1342.506104, 571.737732, 0.0000, 0.0000, 270.0000)--
createObjectls(1726, 1184.295044, -1345.564697, 571.737732, 0.0000, 0.0000, 180.0000)--
createObjectls(2700, 1179.601929, -1343.437622, 574.643311, 0.0000, 0.0000, 0.0000)--
createObjectls(16501, 1192.881714, -1341.856567, 573.945801, 0.0000, 0.0000, 0.0000)--
createObjectls(1523, 1192.826050, -1345.329834, 571.726196, 0.0000, 0.0000, 270.0000)--
createObjectls(1523, 1192.903687, -1348.527832, 571.732788, 0.0000, 0.0000, 90.0000)--
createObjectls(16501, 1196.391724, -1346.944946, 573.945801, 0.0000, 0.0000, 90.0000)--
createObjectls(16501, 1192.939575, -1350.696411, 573.620483, 269.7592, 0.0000, 0.0000)--
createObjectls(16501, 1196.453735, -1352.769409, 573.945801, 0.0000, 0.0000, 90.0000)--
createObjectls(16501, 1192.886597, -1346.923828, 576.432983, 0.0000, 0.0000, 0.0000)--
createObjectls(3383, 1186.726929, -1369.386108, 571.745300, 0.0000, 0.0000, 270.0000)--
createObjectls(3391, 1189.210815, -1373.099854, 571.743103, 0.0000, 0.0000, 270.0000)--
createObjectls(3395, 1192.694336, -1373.091553, 571.743103, 0.0000, 0.0000, 270.0000)--
createObjectls(1208, 1197.962891, -1347.392212, 571.745300, 0.0000, 0.0000, 90.0000)--
createObjectls(2380, 1198.132813, -1348.626221, 573.421631, 0.0000, 0.0000, 270.0000)--
createObjectls(1208, 1197.955444, -1348.073120, 571.745300, 0.0000, 0.0000, 90.0000)--
createObjectls(2742, 1193.195801, -1349.242065, 572.958923, 0.0000, 0.0000, 90.0000)--
createObjectls(2742, 1193.195801, -1350.103760, 572.968323, 0.0000, 0.0000, 90.0000)--
createObjectls(2741, 1193.120728, -1350.723145, 572.966003, 0.0000, 0.0000, 90.0000)--
createObjectls(2739, 1193.517212, -1351.701904, 571.744507, 0.0000, 0.0000, 90.0000)--
createObjectls(2739, 1193.508057, -1352.447754, 571.744507, 0.0000, 0.0000, 90.0000)--
createObjectls(2738, 1195.882324, -1352.212769, 572.348145, 0.0000, 0.0000, 180.0000)--
createObjectls(2738, 1196.953369, -1352.234131, 572.348145, 0.0000, 0.0000, 180.0000)--
createObjectls(2713, 1197.916382, -1349.533813, 571.891541, 0.0000, 0.0000, 270.0000)--
createObjectls(2602, 1197.844604, -1350.860474, 572.268738, 0.0000, 0.0000, 270.0000)--
createObjectls(2603, 1196.954102, -1346.273193, 572.198547, 0.0000, 0.0000, 90.2408)--
createObjectls(3393, 1194.845093, -1341.210083, 571.743103, 0.0000, 0.0000, 90.0000)--
createObjectls(3389, 1197.151245, -1340.863892, 571.745300, 0.0000, 0.0000, 89.9999)--
createObjectls(3383, 1197.434692, -1343.766235, 571.745300, 0.0000, 0.0000, 90.0000)--

createObjectls2(1504,1178.5,-1354,571.7,0,0,90) --- turf door
createObjectls2(1505,1178.5,-1348,571.7,0,0,90) --- base door
createObjectls2(1507, 1178.172607, -1349.523193, 571.744873, 0.0000, 0.0000, 270.0000)--
createObjectls2(14669, 1188.746948, -1350.306396, 571.745300, 0.0000, 0.0000, 270.0000)--
createObjectls2(16500, 1178.100952, -1350.264648, 573.038818, 0.0000, 0.0000, 180.0000)--
createObjectls2(18001, 1184.308838, -1340.759888, 573.494263, 0.0000, 0.0000, 0.0000)--
createObjectls2(18079, 1184.351685, -1340.786133, 573.766785, 0.0000, 0.0000, 180.0000)--
createObjectls2(2632, 1180.114258, -1350.337158, 571.716553, 0.0000, 0.0000, 0.0000)--
createObjectls2(2185, 1181.094727, -1357.269165, 571.743469, 0.0000, 0.0000, 180.0000)--
createObjectls2(1806, 1180.310059, -1358.306396, 571.764954, 0.0000, 0.0000, 0.0000)--
createObjectls2(2610, 1179.541992, -1359.595215, 572.570740, 0.0000, 0.0000, 180.0000)--
createObjectls2(2610, 1180.030273, -1359.596436, 572.570740, 0.0000, 0.0000, 180.0000)--
createObjectls2(2202, 1182.232422, -1359.418091, 571.738220, 0.0000, 0.0000, 180.0000)--
createObjectls2(1797, 1194.704590, -1370.338623, 571.738892, 0.0000, 0.0000, 270.0000)--
createObjectls2(1797, 1194.731812, -1367.876709, 571.738892, 0.0000, 0.0000, 270.0000)--
createObjectls2(1797, 1194.753296, -1365.335449, 571.738892, 0.0000, 0.0000, 270.0000)--
createObjectls2(1797, 1194.730835, -1362.682129, 571.738892, 0.0000, 0.0000, 270.0000)--
createObjectls2(1726, 1182.289063, -1341.340332, 571.737732, 0.0000, 0.0000, 0.0000)--
createObjectls2(1726, 1185.411255, -1342.506104, 571.737732, 0.0000, 0.0000, 270.0000)--
createObjectls2(1726, 1184.295044, -1345.564697, 571.737732, 0.0000, 0.0000, 180.0000)--
createObjectls2(2700, 1179.601929, -1343.437622, 574.643311, 0.0000, 0.0000, 0.0000)--
createObjectls2(16501, 1192.881714, -1341.856567, 573.945801, 0.0000, 0.0000, 0.0000)--
createObjectls2(1523, 1192.826050, -1345.329834, 571.726196, 0.0000, 0.0000, 270.0000)--
createObjectls2(1523, 1192.903687, -1348.527832, 571.732788, 0.0000, 0.0000, 90.0000)--
createObjectls2(16501, 1196.391724, -1346.944946, 573.945801, 0.0000, 0.0000, 90.0000)--
createObjectls2(16501, 1192.939575, -1350.696411, 573.620483, 269.7592, 0.0000, 0.0000)--
createObjectls2(16501, 1196.453735, -1352.769409, 573.945801, 0.0000, 0.0000, 90.0000)--
createObjectls2(16501, 1192.886597, -1346.923828, 576.432983, 0.0000, 0.0000, 0.0000)--
createObjectls2(3383, 1186.726929, -1369.386108, 571.745300, 0.0000, 0.0000, 270.0000)--
createObjectls2(3391, 1189.210815, -1373.099854, 571.743103, 0.0000, 0.0000, 270.0000)--
createObjectls2(3395, 1192.694336, -1373.091553, 571.743103, 0.0000, 0.0000, 270.0000)--
createObjectls2(1208, 1197.962891, -1347.392212, 571.745300, 0.0000, 0.0000, 90.0000)--
createObjectls2(2380, 1198.132813, -1348.626221, 573.421631, 0.0000, 0.0000, 270.0000)--
createObjectls2(1208, 1197.955444, -1348.073120, 571.745300, 0.0000, 0.0000, 90.0000)--
createObjectls2(2742, 1193.195801, -1349.242065, 572.958923, 0.0000, 0.0000, 90.0000)--
createObjectls2(2742, 1193.195801, -1350.103760, 572.968323, 0.0000, 0.0000, 90.0000)--
createObjectls2(2741, 1193.120728, -1350.723145, 572.966003, 0.0000, 0.0000, 90.0000)--
createObjectls2(2739, 1193.517212, -1351.701904, 571.744507, 0.0000, 0.0000, 90.0000)--
createObjectls2(2739, 1193.508057, -1352.447754, 571.744507, 0.0000, 0.0000, 90.0000)--
createObjectls2(2738, 1195.882324, -1352.212769, 572.348145, 0.0000, 0.0000, 180.0000)--
createObjectls2(2738, 1196.953369, -1352.234131, 572.348145, 0.0000, 0.0000, 180.0000)--
createObjectls2(2713, 1197.916382, -1349.533813, 571.891541, 0.0000, 0.0000, 270.0000)--
createObjectls2(2602, 1197.844604, -1350.860474, 572.268738, 0.0000, 0.0000, 270.0000)--
createObjectls2(2603, 1196.954102, -1346.273193, 572.198547, 0.0000, 0.0000, 90.2408)--
createObjectls2(3393, 1194.845093, -1341.210083, 571.743103, 0.0000, 0.0000, 90.0000)--
createObjectls2(3389, 1197.151245, -1340.863892, 571.745300, 0.0000, 0.0000, 89.9999)--
createObjectls2(3383, 1197.434692, -1343.766235, 571.745300, 0.0000, 0.0000, 90.0000)--


createObjectls3(1504,1178.5,-1354,571.7,0,0,90) --- turf door
createObjectls3(1505,1178.5,-1348,571.7,0,0,90) --- base door
createObjectls3(1507, 1178.172607, -1349.523193, 571.744873, 0.0000, 0.0000, 270.0000)--
createObjectls3(14669, 1188.746948, -1350.306396, 571.745300, 0.0000, 0.0000, 270.0000)--
createObjectls3(16500, 1178.100952, -1350.264648, 573.038818, 0.0000, 0.0000, 180.0000)--
createObjectls3(18001, 1184.308838, -1340.759888, 573.494263, 0.0000, 0.0000, 0.0000)--
createObjectls3(18079, 1184.351685, -1340.786133, 573.766785, 0.0000, 0.0000, 180.0000)--
createObjectls3(2632, 1180.114258, -1350.337158, 571.716553, 0.0000, 0.0000, 0.0000)--
createObjectls3(2185, 1181.094727, -1357.269165, 571.743469, 0.0000, 0.0000, 180.0000)--
createObjectls3(1806, 1180.310059, -1358.306396, 571.764954, 0.0000, 0.0000, 0.0000)--
createObjectls3(2610, 1179.541992, -1359.595215, 572.570740, 0.0000, 0.0000, 180.0000)--
createObjectls3(2610, 1180.030273, -1359.596436, 572.570740, 0.0000, 0.0000, 180.0000)--
createObjectls3(2202, 1182.232422, -1359.418091, 571.738220, 0.0000, 0.0000, 180.0000)--
createObjectls3(1797, 1194.704590, -1370.338623, 571.738892, 0.0000, 0.0000, 270.0000)--
createObjectls3(1797, 1194.731812, -1367.876709, 571.738892, 0.0000, 0.0000, 270.0000)--
createObjectls3(1797, 1194.753296, -1365.335449, 571.738892, 0.0000, 0.0000, 270.0000)--
createObjectls3(1797, 1194.730835, -1362.682129, 571.738892, 0.0000, 0.0000, 270.0000)--
createObjectls3(1726, 1182.289063, -1341.340332, 571.737732, 0.0000, 0.0000, 0.0000)--
createObjectls3(1726, 1185.411255, -1342.506104, 571.737732, 0.0000, 0.0000, 270.0000)--
createObjectls3(1726, 1184.295044, -1345.564697, 571.737732, 0.0000, 0.0000, 180.0000)--
createObjectls3(2700, 1179.601929, -1343.437622, 574.643311, 0.0000, 0.0000, 0.0000)--
createObjectls3(16501, 1192.881714, -1341.856567, 573.945801, 0.0000, 0.0000, 0.0000)--
createObjectls3(1523, 1192.826050, -1345.329834, 571.726196, 0.0000, 0.0000, 270.0000)--
createObjectls3(1523, 1192.903687, -1348.527832, 571.732788, 0.0000, 0.0000, 90.0000)--
createObjectls3(16501, 1196.391724, -1346.944946, 573.945801, 0.0000, 0.0000, 90.0000)--
createObjectls3(16501, 1192.939575, -1350.696411, 573.620483, 269.7592, 0.0000, 0.0000)--
createObjectls3(16501, 1196.453735, -1352.769409, 573.945801, 0.0000, 0.0000, 90.0000)--
createObjectls3(16501, 1192.886597, -1346.923828, 576.432983, 0.0000, 0.0000, 0.0000)--
createObjectls3(3383, 1186.726929, -1369.386108, 571.745300, 0.0000, 0.0000, 270.0000)--
createObjectls3(3391, 1189.210815, -1373.099854, 571.743103, 0.0000, 0.0000, 270.0000)--
createObjectls3(3395, 1192.694336, -1373.091553, 571.743103, 0.0000, 0.0000, 270.0000)--
createObjectls3(1208, 1197.962891, -1347.392212, 571.745300, 0.0000, 0.0000, 90.0000)--
createObjectls3(2380, 1198.132813, -1348.626221, 573.421631, 0.0000, 0.0000, 270.0000)--
createObjectls3(1208, 1197.955444, -1348.073120, 571.745300, 0.0000, 0.0000, 90.0000)--
createObjectls3(2742, 1193.195801, -1349.242065, 572.958923, 0.0000, 0.0000, 90.0000)--
createObjectls3(2742, 1193.195801, -1350.103760, 572.968323, 0.0000, 0.0000, 90.0000)--
createObjectls3(2741, 1193.120728, -1350.723145, 572.966003, 0.0000, 0.0000, 90.0000)--
createObjectls3(2739, 1193.517212, -1351.701904, 571.744507, 0.0000, 0.0000, 90.0000)--
createObjectls3(2739, 1193.508057, -1352.447754, 571.744507, 0.0000, 0.0000, 90.0000)--
createObjectls3(2738, 1195.882324, -1352.212769, 572.348145, 0.0000, 0.0000, 180.0000)--
createObjectls3(2738, 1196.953369, -1352.234131, 572.348145, 0.0000, 0.0000, 180.0000)--
createObjectls3(2713, 1197.916382, -1349.533813, 571.891541, 0.0000, 0.0000, 270.0000)--
createObjectls3(2602, 1197.844604, -1350.860474, 572.268738, 0.0000, 0.0000, 270.0000)--
createObjectls3(2603, 1196.954102, -1346.273193, 572.198547, 0.0000, 0.0000, 90.2408)--
createObjectls3(3393, 1194.845093, -1341.210083, 571.743103, 0.0000, 0.0000, 90.0000)--
createObjectls3(3389, 1197.151245, -1340.863892, 571.745300, 0.0000, 0.0000, 89.9999)--
createObjectls3(3383, 1197.434692, -1343.766235, 571.745300, 0.0000, 0.0000, 90.0000)--


createObjectsf(1504,1178.5,-1354,571.7,0,0,90) --- turf door
createObjectsf(1505,1178.5,-1348,571.7,0,0,90) --- base door
createObjectsf(1507, 1178.172607, -1349.523193, 571.744873, 0.0000, 0.0000, 270.0000)--
createObjectsf(14669, 1188.746948, -1350.306396, 571.745300, 0.0000, 0.0000, 270.0000)--
createObjectsf(16500, 1178.100952, -1350.264648, 573.038818, 0.0000, 0.0000, 180.0000)--
createObjectsf(18001, 1184.308838, -1340.759888, 573.494263, 0.0000, 0.0000, 0.0000)--
createObjectsf(18079, 1184.351685, -1340.786133, 573.766785, 0.0000, 0.0000, 180.0000)--
createObjectsf(2632, 1180.114258, -1350.337158, 571.716553, 0.0000, 0.0000, 0.0000)--
createObjectsf(2185, 1181.094727, -1357.269165, 571.743469, 0.0000, 0.0000, 180.0000)--
createObjectsf(1806, 1180.310059, -1358.306396, 571.764954, 0.0000, 0.0000, 0.0000)--
createObjectsf(2610, 1179.541992, -1359.595215, 572.570740, 0.0000, 0.0000, 180.0000)--
createObjectsf(2610, 1180.030273, -1359.596436, 572.570740, 0.0000, 0.0000, 180.0000)--
createObjectsf(2202, 1182.232422, -1359.418091, 571.738220, 0.0000, 0.0000, 180.0000)--
createObjectsf(1797, 1194.704590, -1370.338623, 571.738892, 0.0000, 0.0000, 270.0000)--
createObjectsf(1797, 1194.731812, -1367.876709, 571.738892, 0.0000, 0.0000, 270.0000)--
createObjectsf(1797, 1194.753296, -1365.335449, 571.738892, 0.0000, 0.0000, 270.0000)--
createObjectsf(1797, 1194.730835, -1362.682129, 571.738892, 0.0000, 0.0000, 270.0000)--
createObjectsf(1726, 1182.289063, -1341.340332, 571.737732, 0.0000, 0.0000, 0.0000)--
createObjectsf(1726, 1185.411255, -1342.506104, 571.737732, 0.0000, 0.0000, 270.0000)--
createObjectsf(1726, 1184.295044, -1345.564697, 571.737732, 0.0000, 0.0000, 180.0000)--
createObjectsf(2700, 1179.601929, -1343.437622, 574.643311, 0.0000, 0.0000, 0.0000)--
createObjectsf(16501, 1192.881714, -1341.856567, 573.945801, 0.0000, 0.0000, 0.0000)--
createObjectsf(1523, 1192.826050, -1345.329834, 571.726196, 0.0000, 0.0000, 270.0000)--
createObjectsf(1523, 1192.903687, -1348.527832, 571.732788, 0.0000, 0.0000, 90.0000)--
createObjectsf(16501, 1196.391724, -1346.944946, 573.945801, 0.0000, 0.0000, 90.0000)--
createObjectsf(16501, 1192.939575, -1350.696411, 573.620483, 269.7592, 0.0000, 0.0000)--
createObjectsf(16501, 1196.453735, -1352.769409, 573.945801, 0.0000, 0.0000, 90.0000)--
createObjectsf(16501, 1192.886597, -1346.923828, 576.432983, 0.0000, 0.0000, 0.0000)--
createObjectsf(3383, 1186.726929, -1369.386108, 571.745300, 0.0000, 0.0000, 270.0000)--
createObjectsf(3391, 1189.210815, -1373.099854, 571.743103, 0.0000, 0.0000, 270.0000)--
createObjectsf(3395, 1192.694336, -1373.091553, 571.743103, 0.0000, 0.0000, 270.0000)--
createObjectsf(1208, 1197.962891, -1347.392212, 571.745300, 0.0000, 0.0000, 90.0000)--
createObjectsf(2380, 1198.132813, -1348.626221, 573.421631, 0.0000, 0.0000, 270.0000)--
createObjectsf(1208, 1197.955444, -1348.073120, 571.745300, 0.0000, 0.0000, 90.0000)--
createObjectsf(2742, 1193.195801, -1349.242065, 572.958923, 0.0000, 0.0000, 90.0000)--
createObjectsf(2742, 1193.195801, -1350.103760, 572.968323, 0.0000, 0.0000, 90.0000)--
createObjectsf(2741, 1193.120728, -1350.723145, 572.966003, 0.0000, 0.0000, 90.0000)--
createObjectsf(2739, 1193.517212, -1351.701904, 571.744507, 0.0000, 0.0000, 90.0000)--
createObjectsf(2739, 1193.508057, -1352.447754, 571.744507, 0.0000, 0.0000, 90.0000)--
createObjectsf(2738, 1195.882324, -1352.212769, 572.348145, 0.0000, 0.0000, 180.0000)--
createObjectsf(2738, 1196.953369, -1352.234131, 572.348145, 0.0000, 0.0000, 180.0000)--
createObjectsf(2713, 1197.916382, -1349.533813, 571.891541, 0.0000, 0.0000, 270.0000)--
createObjectsf(2602, 1197.844604, -1350.860474, 572.268738, 0.0000, 0.0000, 270.0000)--
createObjectsf(2603, 1196.954102, -1346.273193, 572.198547, 0.0000, 0.0000, 90.2408)--
createObjectsf(3393, 1194.845093, -1341.210083, 571.743103, 0.0000, 0.0000, 90.0000)--
createObjectsf(3389, 1197.151245, -1340.863892, 571.745300, 0.0000, 0.0000, 89.9999)--
createObjectsf(3383, 1197.434692, -1343.766235, 571.745300, 0.0000, 0.0000, 90.0000)--


createObjectsf2(1504,1178.5,-1354,571.7,0,0,90) --- turf door
createObjectsf2(1505,1178.5,-1348,571.7,0,0,90) --- base door
createObjectsf2(1507, 1178.172607, -1349.523193, 571.744873, 0.0000, 0.0000, 270.0000)--
createObjectsf2(14669, 1188.746948, -1350.306396, 571.745300, 0.0000, 0.0000, 270.0000)--
createObjectsf2(16500, 1178.100952, -1350.264648, 573.038818, 0.0000, 0.0000, 180.0000)--
createObjectsf2(18001, 1184.308838, -1340.759888, 573.494263, 0.0000, 0.0000, 0.0000)--
createObjectsf2(18079, 1184.351685, -1340.786133, 573.766785, 0.0000, 0.0000, 180.0000)--
createObjectsf2(2632, 1180.114258, -1350.337158, 571.716553, 0.0000, 0.0000, 0.0000)--
createObjectsf2(2185, 1181.094727, -1357.269165, 571.743469, 0.0000, 0.0000, 180.0000)--
createObjectsf2(1806, 1180.310059, -1358.306396, 571.764954, 0.0000, 0.0000, 0.0000)--
createObjectsf2(2610, 1179.541992, -1359.595215, 572.570740, 0.0000, 0.0000, 180.0000)--
createObjectsf2(2610, 1180.030273, -1359.596436, 572.570740, 0.0000, 0.0000, 180.0000)--
createObjectsf2(2202, 1182.232422, -1359.418091, 571.738220, 0.0000, 0.0000, 180.0000)--
createObjectsf2(1797, 1194.704590, -1370.338623, 571.738892, 0.0000, 0.0000, 270.0000)--
createObjectsf2(1797, 1194.731812, -1367.876709, 571.738892, 0.0000, 0.0000, 270.0000)--
createObjectsf2(1797, 1194.753296, -1365.335449, 571.738892, 0.0000, 0.0000, 270.0000)--
createObjectsf2(1797, 1194.730835, -1362.682129, 571.738892, 0.0000, 0.0000, 270.0000)--
createObjectsf2(1726, 1182.289063, -1341.340332, 571.737732, 0.0000, 0.0000, 0.0000)--
createObjectsf2(1726, 1185.411255, -1342.506104, 571.737732, 0.0000, 0.0000, 270.0000)--
createObjectsf2(1726, 1184.295044, -1345.564697, 571.737732, 0.0000, 0.0000, 180.0000)--
createObjectsf2(2700, 1179.601929, -1343.437622, 574.643311, 0.0000, 0.0000, 0.0000)--
createObjectsf2(16501, 1192.881714, -1341.856567, 573.945801, 0.0000, 0.0000, 0.0000)--
createObjectsf2(1523, 1192.826050, -1345.329834, 571.726196, 0.0000, 0.0000, 270.0000)--
createObjectsf2(1523, 1192.903687, -1348.527832, 571.732788, 0.0000, 0.0000, 90.0000)--
createObjectsf2(16501, 1196.391724, -1346.944946, 573.945801, 0.0000, 0.0000, 90.0000)--
createObjectsf2(16501, 1192.939575, -1350.696411, 573.620483, 269.7592, 0.0000, 0.0000)--
createObjectsf2(16501, 1196.453735, -1352.769409, 573.945801, 0.0000, 0.0000, 90.0000)--
createObjectsf2(16501, 1192.886597, -1346.923828, 576.432983, 0.0000, 0.0000, 0.0000)--
createObjectsf2(3383, 1186.726929, -1369.386108, 571.745300, 0.0000, 0.0000, 270.0000)--
createObjectsf2(3391, 1189.210815, -1373.099854, 571.743103, 0.0000, 0.0000, 270.0000)--
createObjectsf2(3395, 1192.694336, -1373.091553, 571.743103, 0.0000, 0.0000, 270.0000)--
createObjectsf2(1208, 1197.962891, -1347.392212, 571.745300, 0.0000, 0.0000, 90.0000)--
createObjectsf2(2380, 1198.132813, -1348.626221, 573.421631, 0.0000, 0.0000, 270.0000)--
createObjectsf2(1208, 1197.955444, -1348.073120, 571.745300, 0.0000, 0.0000, 90.0000)--
createObjectsf2(2742, 1193.195801, -1349.242065, 572.958923, 0.0000, 0.0000, 90.0000)--
createObjectsf2(2742, 1193.195801, -1350.103760, 572.968323, 0.0000, 0.0000, 90.0000)--
createObjectsf2(2741, 1193.120728, -1350.723145, 572.966003, 0.0000, 0.0000, 90.0000)--
createObjectsf2(2739, 1193.517212, -1351.701904, 571.744507, 0.0000, 0.0000, 90.0000)--
createObjectsf2(2739, 1193.508057, -1352.447754, 571.744507, 0.0000, 0.0000, 90.0000)--
createObjectsf2(2738, 1195.882324, -1352.212769, 572.348145, 0.0000, 0.0000, 180.0000)--
createObjectsf2(2738, 1196.953369, -1352.234131, 572.348145, 0.0000, 0.0000, 180.0000)--
createObjectsf2(2713, 1197.916382, -1349.533813, 571.891541, 0.0000, 0.0000, 270.0000)--
createObjectsf2(2602, 1197.844604, -1350.860474, 572.268738, 0.0000, 0.0000, 270.0000)--
createObjectsf2(2603, 1196.954102, -1346.273193, 572.198547, 0.0000, 0.0000, 90.2408)--
createObjectsf2(3393, 1194.845093, -1341.210083, 571.743103, 0.0000, 0.0000, 90.0000)--
createObjectsf2(3389, 1197.151245, -1340.863892, 571.745300, 0.0000, 0.0000, 89.9999)--
createObjectsf2(3383, 1197.434692, -1343.766235, 571.745300, 0.0000, 0.0000, 90.0000)--


createObjectlv(1504,1178.5,-1354,571.7,0,0,90) --- turf door
createObjectlv(1505,1178.2,-1352,571.7,0,0,90) --- house door
createObjectlv(1505,1178.5,-1348,571.7,0,0,90) --- base door
createObjectlv(1507, 1178.172607, -1348.823193, 571.744873, 0.0000, 0.0000, 270.0000)--
createObjectlv(14669, 1188.746948, -1350.306396, 571.745300, 0.0000, 0.0000, 270.0000)--
createObjectlv(16500, 1178.100952, -1350.264648, 573.038818, 0.0000, 0.0000, 180.0000)--
createObjectlv(18001, 1184.308838, -1340.759888, 573.494263, 0.0000, 0.0000, 0.0000)--
createObjectlv(18079, 1184.351685, -1340.786133, 573.766785, 0.0000, 0.0000, 180.0000)--
createObjectlv(2632, 1180.114258, -1350.337158, 571.716553, 0.0000, 0.0000, 0.0000)--
createObjectlv(2185, 1181.094727, -1357.269165, 571.743469, 0.0000, 0.0000, 180.0000)--
createObjectlv(1806, 1180.310059, -1358.306396, 571.764954, 0.0000, 0.0000, 0.0000)--
createObjectlv(2610, 1179.541992, -1359.595215, 572.570740, 0.0000, 0.0000, 180.0000)--
createObjectlv(2610, 1180.030273, -1359.596436, 572.570740, 0.0000, 0.0000, 180.0000)--
createObjectlv(2202, 1182.232422, -1359.418091, 571.738220, 0.0000, 0.0000, 180.0000)--
createObjectlv(1797, 1194.704590, -1370.338623, 571.738892, 0.0000, 0.0000, 270.0000)--
createObjectlv(1797, 1194.731812, -1367.876709, 571.738892, 0.0000, 0.0000, 270.0000)--
createObjectlv(1797, 1194.753296, -1365.335449, 571.738892, 0.0000, 0.0000, 270.0000)--
createObjectlv(1797, 1194.730835, -1362.682129, 571.738892, 0.0000, 0.0000, 270.0000)--
createObjectlv(1726, 1182.289063, -1341.340332, 571.737732, 0.0000, 0.0000, 0.0000)--
createObjectlv(1726, 1185.411255, -1342.506104, 571.737732, 0.0000, 0.0000, 270.0000)--
createObjectlv(1726, 1184.295044, -1345.564697, 571.737732, 0.0000, 0.0000, 180.0000)--
createObjectlv(2700, 1179.601929, -1343.437622, 574.643311, 0.0000, 0.0000, 0.0000)--
createObjectlv(16501, 1192.881714, -1341.856567, 573.945801, 0.0000, 0.0000, 0.0000)--
createObjectlv(1523, 1192.826050, -1345.329834, 571.726196, 0.0000, 0.0000, 270.0000)--
createObjectlv(1523, 1192.903687, -1348.527832, 571.732788, 0.0000, 0.0000, 90.0000)--
createObjectlv(16501, 1196.391724, -1346.944946, 573.945801, 0.0000, 0.0000, 90.0000)--
createObjectlv(16501, 1192.939575, -1350.696411, 573.620483, 269.7592, 0.0000, 0.0000)--
createObjectlv(16501, 1196.453735, -1352.769409, 573.945801, 0.0000, 0.0000, 90.0000)--
createObjectlv(16501, 1192.886597, -1346.923828, 576.432983, 0.0000, 0.0000, 0.0000)--
createObjectlv(3383, 1186.726929, -1369.386108, 571.745300, 0.0000, 0.0000, 270.0000)--
createObjectlv(3391, 1189.210815, -1373.099854, 571.743103, 0.0000, 0.0000, 270.0000)--
createObjectlv(3395, 1192.694336, -1373.091553, 571.743103, 0.0000, 0.0000, 270.0000)--
createObjectlv(1208, 1197.962891, -1347.392212, 571.745300, 0.0000, 0.0000, 90.0000)--
createObjectlv(2380, 1198.132813, -1348.626221, 573.421631, 0.0000, 0.0000, 270.0000)--
createObjectlv(1208, 1197.955444, -1348.073120, 571.745300, 0.0000, 0.0000, 90.0000)--
createObjectlv(2742, 1193.195801, -1349.242065, 572.958923, 0.0000, 0.0000, 90.0000)--
createObjectlv(2742, 1193.195801, -1350.103760, 572.968323, 0.0000, 0.0000, 90.0000)--
createObjectlv(2741, 1193.120728, -1350.723145, 572.966003, 0.0000, 0.0000, 90.0000)--
createObjectlv(2739, 1193.517212, -1351.701904, 571.744507, 0.0000, 0.0000, 90.0000)--
createObjectlv(2739, 1193.508057, -1352.447754, 571.744507, 0.0000, 0.0000, 90.0000)--
createObjectlv(2738, 1195.882324, -1352.212769, 572.348145, 0.0000, 0.0000, 180.0000)--
createObjectlv(2738, 1196.953369, -1352.234131, 572.348145, 0.0000, 0.0000, 180.0000)--
createObjectlv(2713, 1197.916382, -1349.533813, 571.891541, 0.0000, 0.0000, 270.0000)--
createObjectlv(2602, 1197.844604, -1350.860474, 572.268738, 0.0000, 0.0000, 270.0000)--
createObjectlv(2603, 1196.954102, -1346.273193, 572.198547, 0.0000, 0.0000, 90.2408)--
createObjectlv(3393, 1194.845093, -1341.210083, 571.743103, 0.0000, 0.0000, 90.0000)--
createObjectlv(3389, 1197.151245, -1340.863892, 571.745300, 0.0000, 0.0000, 89.9999)--
createObjectlv(3383, 1197.434692, -1343.766235, 571.745300, 0.0000, 0.0000, 90.0000)--

createObjectlv2(1504,1178.5,-1354,571.7,0,0,90) --- turf door
createObjectlv2(1505,1178.5,-1348,571.7,0,0,90) --- base door
createObjectlv2(1507, 1178.172607, -1349.523193, 571.744873, 0.0000, 0.0000, 270.0000)--
createObjectlv2(14669, 1188.746948, -1350.306396, 571.745300, 0.0000, 0.0000, 270.0000)--
createObjectlv2(16500, 1178.100952, -1350.264648, 573.038818, 0.0000, 0.0000, 180.0000)--
createObjectlv2(18001, 1184.308838, -1340.759888, 573.494263, 0.0000, 0.0000, 0.0000)--
createObjectlv2(18079, 1184.351685, -1340.786133, 573.766785, 0.0000, 0.0000, 180.0000)--
createObjectlv2(2632, 1180.114258, -1350.337158, 571.716553, 0.0000, 0.0000, 0.0000)--
createObjectlv2(2185, 1181.094727, -1357.269165, 571.743469, 0.0000, 0.0000, 180.0000)--
createObjectlv2(1806, 1180.310059, -1358.306396, 571.764954, 0.0000, 0.0000, 0.0000)--
createObjectlv2(2610, 1179.541992, -1359.595215, 572.570740, 0.0000, 0.0000, 180.0000)--
createObjectlv2(2610, 1180.030273, -1359.596436, 572.570740, 0.0000, 0.0000, 180.0000)--
createObjectlv2(2202, 1182.232422, -1359.418091, 571.738220, 0.0000, 0.0000, 180.0000)--
createObjectlv2(1797, 1194.704590, -1370.338623, 571.738892, 0.0000, 0.0000, 270.0000)--
createObjectlv2(1797, 1194.731812, -1367.876709, 571.738892, 0.0000, 0.0000, 270.0000)--
createObjectlv2(1797, 1194.753296, -1365.335449, 571.738892, 0.0000, 0.0000, 270.0000)--
createObjectlv2(1797, 1194.730835, -1362.682129, 571.738892, 0.0000, 0.0000, 270.0000)--
createObjectlv2(1726, 1182.289063, -1341.340332, 571.737732, 0.0000, 0.0000, 0.0000)--
createObjectlv2(1726, 1185.411255, -1342.506104, 571.737732, 0.0000, 0.0000, 270.0000)--
createObjectlv2(1726, 1184.295044, -1345.564697, 571.737732, 0.0000, 0.0000, 180.0000)--
createObjectlv2(2700, 1179.601929, -1343.437622, 574.643311, 0.0000, 0.0000, 0.0000)--
createObjectlv2(16501, 1192.881714, -1341.856567, 573.945801, 0.0000, 0.0000, 0.0000)--
createObjectlv2(1523, 1192.826050, -1345.329834, 571.726196, 0.0000, 0.0000, 270.0000)--
createObjectlv2(1523, 1192.903687, -1348.527832, 571.732788, 0.0000, 0.0000, 90.0000)--
createObjectlv2(16501, 1196.391724, -1346.944946, 573.945801, 0.0000, 0.0000, 90.0000)--
createObjectlv2(16501, 1192.939575, -1350.696411, 573.620483, 269.7592, 0.0000, 0.0000)--
createObjectlv2(16501, 1196.453735, -1352.769409, 573.945801, 0.0000, 0.0000, 90.0000)--
createObjectlv2(16501, 1192.886597, -1346.923828, 576.432983, 0.0000, 0.0000, 0.0000)--
createObjectlv2(3383, 1186.726929, -1369.386108, 571.745300, 0.0000, 0.0000, 270.0000)--
createObjectlv2(3391, 1189.210815, -1373.099854, 571.743103, 0.0000, 0.0000, 270.0000)--
createObjectlv2(3395, 1192.694336, -1373.091553, 571.743103, 0.0000, 0.0000, 270.0000)--
createObjectlv2(1208, 1197.962891, -1347.392212, 571.745300, 0.0000, 0.0000, 90.0000)--
createObjectlv2(2380, 1198.132813, -1348.626221, 573.421631, 0.0000, 0.0000, 270.0000)--
createObjectlv2(1208, 1197.955444, -1348.073120, 571.745300, 0.0000, 0.0000, 90.0000)--
createObjectlv2(2742, 1193.195801, -1349.242065, 572.958923, 0.0000, 0.0000, 90.0000)--
createObjectlv2(2742, 1193.195801, -1350.103760, 572.968323, 0.0000, 0.0000, 90.0000)--
createObjectlv2(2741, 1193.120728, -1350.723145, 572.966003, 0.0000, 0.0000, 90.0000)--
createObjectlv2(2739, 1193.517212, -1351.701904, 571.744507, 0.0000, 0.0000, 90.0000)--
createObjectlv2(2739, 1193.508057, -1352.447754, 571.744507, 0.0000, 0.0000, 90.0000)--
createObjectlv2(2738, 1195.882324, -1352.212769, 572.348145, 0.0000, 0.0000, 180.0000)--
createObjectlv2(2738, 1196.953369, -1352.234131, 572.348145, 0.0000, 0.0000, 180.0000)--
createObjectlv2(2713, 1197.916382, -1349.533813, 571.891541, 0.0000, 0.0000, 270.0000)--
createObjectlv2(2602, 1197.844604, -1350.860474, 572.268738, 0.0000, 0.0000, 270.0000)--
createObjectlv2(2603, 1196.954102, -1346.273193, 572.198547, 0.0000, 0.0000, 90.2408)--
createObjectlv2(3393, 1194.845093, -1341.210083, 571.743103, 0.0000, 0.0000, 90.0000)--
createObjectlv2(3389, 1197.151245, -1340.863892, 571.745300, 0.0000, 0.0000, 89.9999)--
createObjectlv2(3383, 1197.434692, -1343.766235, 571.745300, 0.0000, 0.0000, 90.0000)--


--createObjectlv3(1504,1178.5,-1354,571.7,0,0,90) --- turf door
createObjectlv3(1504,1178.5,-1354,571.7,0,0,90) --- base door
createObjectlv3(1505,1178.5,-1348,571.7,0,0,90) --- house door
createObjectlv3(1507, 1178.172607, -1349.523193, 571.744873, 0.0000, 0.0000, 270.0000)--
createObjectlv3(14669, 1188.746948, -1350.306396, 571.745300, 0.0000, 0.0000, 270.0000)--
createObjectlv3(16500, 1178.100952, -1350.264648, 573.038818, 0.0000, 0.0000, 180.0000)--
createObjectlv3(18001, 1184.308838, -1340.759888, 573.494263, 0.0000, 0.0000, 0.0000)--
createObjectlv3(18079, 1184.351685, -1340.786133, 573.766785, 0.0000, 0.0000, 180.0000)--
createObjectlv3(2632, 1180.114258, -1350.337158, 571.716553, 0.0000, 0.0000, 0.0000)--
createObjectlv3(2185, 1181.094727, -1357.269165, 571.743469, 0.0000, 0.0000, 180.0000)--
createObjectlv3(1806, 1180.310059, -1358.306396, 571.764954, 0.0000, 0.0000, 0.0000)--
createObjectlv3(2610, 1179.541992, -1359.595215, 572.570740, 0.0000, 0.0000, 180.0000)--
createObjectlv3(2610, 1180.030273, -1359.596436, 572.570740, 0.0000, 0.0000, 180.0000)--
createObjectlv3(2202, 1182.232422, -1359.418091, 571.738220, 0.0000, 0.0000, 180.0000)--
createObjectlv3(1797, 1194.704590, -1370.338623, 571.738892, 0.0000, 0.0000, 270.0000)--
createObjectlv3(1797, 1194.731812, -1367.876709, 571.738892, 0.0000, 0.0000, 270.0000)--
createObjectlv3(1797, 1194.753296, -1365.335449, 571.738892, 0.0000, 0.0000, 270.0000)--
createObjectlv3(1797, 1194.730835, -1362.682129, 571.738892, 0.0000, 0.0000, 270.0000)--
createObjectlv3(1726, 1182.289063, -1341.340332, 571.737732, 0.0000, 0.0000, 0.0000)--
createObjectlv3(1726, 1185.411255, -1342.506104, 571.737732, 0.0000, 0.0000, 270.0000)--
createObjectlv3(1726, 1184.295044, -1345.564697, 571.737732, 0.0000, 0.0000, 180.0000)--
createObjectlv3(2700, 1179.601929, -1343.437622, 574.643311, 0.0000, 0.0000, 0.0000)--
createObjectlv3(16501, 1192.881714, -1341.856567, 573.945801, 0.0000, 0.0000, 0.0000)--
createObjectlv3(1523, 1192.826050, -1345.329834, 571.726196, 0.0000, 0.0000, 270.0000)--
createObjectlv3(1523, 1192.903687, -1348.527832, 571.732788, 0.0000, 0.0000, 90.0000)--
createObjectlv3(16501, 1196.391724, -1346.944946, 573.945801, 0.0000, 0.0000, 90.0000)--
createObjectlv3(16501, 1192.939575, -1350.696411, 573.620483, 269.7592, 0.0000, 0.0000)--
createObjectlv3(16501, 1196.453735, -1352.769409, 573.945801, 0.0000, 0.0000, 90.0000)--
createObjectlv3(16501, 1192.886597, -1346.923828, 576.432983, 0.0000, 0.0000, 0.0000)--
createObjectlv3(3383, 1186.726929, -1369.386108, 571.745300, 0.0000, 0.0000, 270.0000)--
createObjectlv3(3391, 1189.210815, -1373.099854, 571.743103, 0.0000, 0.0000, 270.0000)--
createObjectlv3(3395, 1192.694336, -1373.091553, 571.743103, 0.0000, 0.0000, 270.0000)--
createObjectlv3(1208, 1197.962891, -1347.392212, 571.745300, 0.0000, 0.0000, 90.0000)--
createObjectlv3(2380, 1198.132813, -1348.626221, 573.421631, 0.0000, 0.0000, 270.0000)--
createObjectlv3(1208, 1197.955444, -1348.073120, 571.745300, 0.0000, 0.0000, 90.0000)--
createObjectlv3(2742, 1193.195801, -1349.242065, 572.958923, 0.0000, 0.0000, 90.0000)--
createObjectlv3(2742, 1193.195801, -1350.103760, 572.968323, 0.0000, 0.0000, 90.0000)--
createObjectlv3(2741, 1193.120728, -1350.723145, 572.966003, 0.0000, 0.0000, 90.0000)--
createObjectlv3(2739, 1193.517212, -1351.701904, 571.744507, 0.0000, 0.0000, 90.0000)--
createObjectlv3(2739, 1193.508057, -1352.447754, 571.744507, 0.0000, 0.0000, 90.0000)--
createObjectlv3(2738, 1195.882324, -1352.212769, 572.348145, 0.0000, 0.0000, 180.0000)--
createObjectlv3(2738, 1196.953369, -1352.234131, 572.348145, 0.0000, 0.0000, 180.0000)--
createObjectlv3(2713, 1197.916382, -1349.533813, 571.891541, 0.0000, 0.0000, 270.0000)--
createObjectlv3(2602, 1197.844604, -1350.860474, 572.268738, 0.0000, 0.0000, 270.0000)--
createObjectlv3(2603, 1196.954102, -1346.273193, 572.198547, 0.0000, 0.0000, 90.2408)--
createObjectlv3(3393, 1194.845093, -1341.210083, 571.743103, 0.0000, 0.0000, 90.0000)--
createObjectlv3(3389, 1197.151245, -1340.863892, 571.745300, 0.0000, 0.0000, 89.9999)--
createObjectlv3(3383, 1197.434692, -1343.766235, 571.745300, 0.0000, 0.0000, 90.0000)--


createObjectlv4(1504,1178.5,-1354,571.7,0,0,90) --- turf door
createObjectlv4(1505,1178.5,-1348,571.7,0,0,90) --- base door
createObjectlv4(1507, 1178.172607, -1349.523193, 571.744873, 0.0000, 0.0000, 270.0000)--
createObjectlv4(14669, 1188.746948, -1350.306396, 571.745300, 0.0000, 0.0000, 270.0000)--
createObjectlv4(16500, 1178.100952, -1350.264648, 573.038818, 0.0000, 0.0000, 180.0000)--
createObjectlv4(18001, 1184.308838, -1340.759888, 573.494263, 0.0000, 0.0000, 0.0000)--
createObjectlv4(18079, 1184.351685, -1340.786133, 573.766785, 0.0000, 0.0000, 180.0000)--
createObjectlv4(2632, 1180.114258, -1350.337158, 571.716553, 0.0000, 0.0000, 0.0000)--
createObjectlv4(2185, 1181.094727, -1357.269165, 571.743469, 0.0000, 0.0000, 180.0000)--
createObjectlv4(1806, 1180.310059, -1358.306396, 571.764954, 0.0000, 0.0000, 0.0000)--
createObjectlv4(2610, 1179.541992, -1359.595215, 572.570740, 0.0000, 0.0000, 180.0000)--
createObjectlv4(2610, 1180.030273, -1359.596436, 572.570740, 0.0000, 0.0000, 180.0000)--
createObjectlv4(2202, 1182.232422, -1359.418091, 571.738220, 0.0000, 0.0000, 180.0000)--
createObjectlv4(1797, 1194.704590, -1370.338623, 571.738892, 0.0000, 0.0000, 270.0000)--
createObjectlv4(1797, 1194.731812, -1367.876709, 571.738892, 0.0000, 0.0000, 270.0000)--
createObjectlv4(1797, 1194.753296, -1365.335449, 571.738892, 0.0000, 0.0000, 270.0000)--
createObjectlv4(1797, 1194.730835, -1362.682129, 571.738892, 0.0000, 0.0000, 270.0000)--
createObjectlv4(1726, 1182.289063, -1341.340332, 571.737732, 0.0000, 0.0000, 0.0000)--
createObjectlv4(1726, 1185.411255, -1342.506104, 571.737732, 0.0000, 0.0000, 270.0000)--
createObjectlv4(1726, 1184.295044, -1345.564697, 571.737732, 0.0000, 0.0000, 180.0000)--
createObjectlv4(2700, 1179.601929, -1343.437622, 574.643311, 0.0000, 0.0000, 0.0000)--
createObjectlv4(16501, 1192.881714, -1341.856567, 573.945801, 0.0000, 0.0000, 0.0000)--
createObjectlv4(1523, 1192.826050, -1345.329834, 571.726196, 0.0000, 0.0000, 270.0000)--
createObjectlv4(1523, 1192.903687, -1348.527832, 571.732788, 0.0000, 0.0000, 90.0000)--
createObjectlv4(16501, 1196.391724, -1346.944946, 573.945801, 0.0000, 0.0000, 90.0000)--
createObjectlv4(16501, 1192.939575, -1350.696411, 573.620483, 269.7592, 0.0000, 0.0000)--
createObjectlv4(16501, 1196.453735, -1352.769409, 573.945801, 0.0000, 0.0000, 90.0000)--
createObjectlv4(16501, 1192.886597, -1346.923828, 576.432983, 0.0000, 0.0000, 0.0000)--
createObjectlv4(3383, 1186.726929, -1369.386108, 571.745300, 0.0000, 0.0000, 270.0000)--
createObjectlv4(3391, 1189.210815, -1373.099854, 571.743103, 0.0000, 0.0000, 270.0000)--
createObjectlv4(3395, 1192.694336, -1373.091553, 571.743103, 0.0000, 0.0000, 270.0000)--
createObjectlv4(1208, 1197.962891, -1347.392212, 571.745300, 0.0000, 0.0000, 90.0000)--
createObjectlv4(2380, 1198.132813, -1348.626221, 573.421631, 0.0000, 0.0000, 270.0000)--
createObjectlv4(1208, 1197.955444, -1348.073120, 571.745300, 0.0000, 0.0000, 90.0000)--
createObjectlv4(2742, 1193.195801, -1349.242065, 572.958923, 0.0000, 0.0000, 90.0000)--
createObjectlv4(2742, 1193.195801, -1350.103760, 572.968323, 0.0000, 0.0000, 90.0000)--
createObjectlv4(2741, 1193.120728, -1350.723145, 572.966003, 0.0000, 0.0000, 90.0000)--
createObjectlv4(2739, 1193.517212, -1351.701904, 571.744507, 0.0000, 0.0000, 90.0000)--
createObjectlv4(2739, 1193.508057, -1352.447754, 571.744507, 0.0000, 0.0000, 90.0000)--
createObjectlv4(2738, 1195.882324, -1352.212769, 572.348145, 0.0000, 0.0000, 180.0000)--
createObjectlv4(2738, 1196.953369, -1352.234131, 572.348145, 0.0000, 0.0000, 180.0000)--
createObjectlv4(2713, 1197.916382, -1349.533813, 571.891541, 0.0000, 0.0000, 270.0000)--
createObjectlv4(2602, 1197.844604, -1350.860474, 572.268738, 0.0000, 0.0000, 270.0000)--
createObjectlv4(2603, 1196.954102, -1346.273193, 572.198547, 0.0000, 0.0000, 90.2408)--
createObjectlv4(3393, 1194.845093, -1341.210083, 571.743103, 0.0000, 0.0000, 90.0000)--
createObjectlv4(3389, 1197.151245, -1340.863892, 571.745300, 0.0000, 0.0000, 89.9999)--
createObjectlv4(3383, 1197.434692, -1343.766235, 571.745300, 0.0000, 0.0000, 90.0000)--
