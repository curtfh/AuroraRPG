local turfRadarArea = {}
local turfColArea = {}
local turfingTimersStart = {}
local turfingTimersAttack = {}
local turfProvocationTimer = {}
local turfAttackGroup = {}
local turfGroups = {}
local turfData = {}
local antiSpam = {}
local paying = {}
local dontgive = false
local dickHead = {}
local crimdontgive = {}
local dickHeadTimers = {}

local turfSpawnTable = {

[1] = {1701.8564453125,682.2275390625,10.8203125,263.98626708984},

[2] = {1453.265625,756.8681640625,11.0234375,89.460296630859},

[3] = {1951.05859375,736.83984375,10.8203125,136.46051025391},

[4] = {2048.81, 691.3, 11.43 ,178.42346191406},

[5] = {2248.6572265625,694.2216796875,11.453125,357.00344848633},

[6] = {2354.109375,693.7431640625,11.4609375,357.31655883789},

[7] = {2601.11328125,746.3095703125,10.8203125,270.83633422852},

[8] = {2523.861328125,917.8134765625,10.8203125,274.59371948242},


[9] = {2475.5205078125,994.318359375,10.8203125,177.46209716797},


[10] = {2550.427734375,1053.3935546875,10.8203125,356.03662109375},


[11] = {2478.244140625,1270.29296875,10.8125,270.49575805664},


[12] = {2465.962890625,1405.7119140625,10.8203125,267.36462402344},


[13] = {2600.373046875,1439.83203125,10.8203125,83.725341796875},

[14] = {2531.86328125,1517.4091796875,10.818544387817,359.14581298828},


[15] = {2623.138671875,1716.904296875,11.0234375,91.075317382813},

[16] = {2569.6953125,1976.4609375,11.1640625,180.81300354004},


[17] = {2577.0361328125,2080.5439453125,10.812986373901,181.1261138916},


[18] = {2587.552734375,2370.6669921875,17.8203125,54.561676025391},


[19] = {2361.076171875,2310.109375,8.140625,0.66741943359375},

[20] = {2179.6005859375,1116.677734375,12.6484375,62.373077392578},

[21] = {2206.37890625,1269.896484375,10.8203125,85.246978759766},


[22] = {2322.27734375,1392.5029296875,10.8203125,357.19570922852},


[23] = {2171.6484375,1416.76953125,11.0625,84.933837890625},


[24] = {2001.0849609375,1527.720703125,14.6171875,356.88259887695},


[25] = {1988.00390625,1796.9140625,12.043745994568,85.246978759766},

[26] = {2046.40625,1916.318359375,12.280037879944,88.378112792969},

[27] = {2445.873046875,1659.5693359375,10.8203125,265.72763061523},

[28] = {2252.7646484375,1803.3359375,10.8203125,88.691223144531},

[29] = {2208.16796875,1968.419921875,10.8203125,90.740234375},

[30] = {2205.33984375,2065.2802734375,10.8203125,268.85876464844},

[31] = {2437.7265625,2125.78515625,10.8203125,358.47561645508},

[32] = {1933.736328125,1346.0693359375,9.96875,267.60632324219},

[33] = {2009.5126953125,1181.017578125,10.8203125,186.14144897461},

[34] = {1922.2158203125,964.7099609375,10.8203125,126.58364868164},


[35] = {1619.5302734375,1061.5419921875,10.8203125,357.19570922852},

[36] = {1465.2802734375,1088.7841796875,10.8203125,264.42572021484},

[37] = {1047.74609375,1016.8701171875,11,320.82489013672},

[38] = {1039.8740234375,1304.7421875,10.8203125,359.07989501953},

[39] = {1100.4326171875,1452.884765625,5.8203125,184.86152648926},


[40] = {1042.1748046875,1724.080078125,10.8203125,0.62347412109375},

[41] = {943.19140625,1733.8115234375,8.8515625,270.69351196289},

[42] = {1054.1123046875,1912.169921875,10.8203125,355.58618164063},

[43] = {973.021484375,1897.0693359375,11.4609375,175.14947509766},


[44] = {975.921875,2050.072265625,10.8203125,269.7541809082},

[45] = {1041.708984375,2009.6123046875,11.4609375,268.1611328125},

[46] = {1071.2294921875,2152.611328125,10.8203125,303.23550415039},

[47] = {1036.33203125,2330.712890625,11.261547088623,356.18493652344},

[48] = {950.57, 2274.61, 11.46,181.3458404541},

[49] = {971.2890625,2343.6416015625,11.46875,89.850311279297},

[50] = {1360.083984375,2210.7109375,12.015625,178.50036621094},


[51] = {1419.6005859375,2000.109375,10.8203125,266.83724975586},


[52] = {1762.2119140625,2107.029296875,10.831106185913,2.4087829589844},

[53] = {1863.6982421875,2003.3818359375,7.5945882797241,267.94689941406},

[54] = {1858.27734375,2236.2958984375,11.125,0.23895263671875},

[55] = {1860.978515625,2349.23046875,10.979915618896,178.18725585938},

[56] = {1615.91796875,2767.2734375,10.8203125,0.84323120117188},


[57] = {1819.8828125,2820.4609375,11.350912094116,253.3897857666},


[58] = {1881.033203125,2645.4033203125,10.8203125,179.12658691406},

[59] = {2315.01171875,2775.4736328125,10.8203125,85.752349853516},

[60] = {2589.8515625,2791.0673828125,10.8203125,89.202087402344},

[61] = {2833.962890625,2400.6240234375,11.068956375122,192.89265441895},

[62] = {2821.9443359375,2209.2919921875,10.8203125,86.070953369141},

[63] = {2806.505859375,2595.1982421875,10.8203125,42.828094482422},

[64] = {2869.4716796875,944.41796875,10.75,182.57633972168},

[65] = {1139.560546875,731.6982421875,10.81880569458,2.1176452636719},

[66] = {1484.67578125,2832.3583984375,10.8203125,180.07141113281},


--[67] = {3454.7673339844,2378.7189941406,9.2662696838379,180.07141113281},


--[68] = {1216.2017822266,2721.2944335938,10.8203125,180.07141113281},


}

--id's don't nessarly correspond to turf ids
local radStations = {
[63] = "#1 LVPD", -- turf id 54
[64] = "#2 LVPD", -- turf id 65
[65] = "#3 LVPD", -- turf id 69
[66] = "#4 LVPD", -- turf id 68
--[76] = "LV Sea"
}

local blipStats = {
[63] = "law",
[64] = "law",
[65] = "law",
[66] = "law",
--[76] = "crim",
}


local turfStability = { -- 15 mins = 900000

}
sexyTimer = {}
for i=1,100 do turfStability[i] = getTickCount() end
-- Create the turfs when the resource gets started
addEventHandler ( "onResourceStart", getResourceRootElement(getThisResource()),
function ()
	local CSGTurfs = exports.DENmysql:query( "SELECT * FROM turfing" )
	if ( CSGTurfs ) and ( #CSGTurfs > 0 ) then
		for i=1,#CSGTurfs do
		--for i=1,77 do
			turfStability[i] = getTickCount()
			turfRadarArea[i] = createRadarArea ( CSGTurfs[i].leftx, CSGTurfs[i].bottomy, CSGTurfs[i].sizex, CSGTurfs[i].sizey, CSGTurfs[i].r, CSGTurfs[i].g, CSGTurfs[i].b, 180 )
			turfColArea[i] = createColRectangle ( CSGTurfs[i].leftx, CSGTurfs[i].bottomy, CSGTurfs[i].sizex, CSGTurfs[i].sizey )
			setElementData( turfColArea[i], "sqlID", CSGTurfs[i].turfid )
			setElementData( turfColArea[i], "turfID", i )
			turfData[i] = {}
			if isTimer(sexyTimer[CSGTurfs[i].turfid]) then killTimer(sexyTimer[CSGTurfs[i].turfid]) end
			if CSGTurfs[i].turfid == 63 or CSGTurfs[i].turfid == 64 or CSGTurfs[i].turfid == 65 or CSGTurfs[i].turfid == 66 then
				sexyTimer[CSGTurfs[i].turfid] = setTimer(function(theTurfID,turfOwner)
				---outputDebugString("Here start timing id "..theTurfID)
				if theTurfID == 63 then
					if turfOwner == "Unoccupied" then
						blipStats[theTurfID] = "noone"
					elseif turfOwner == "Aurora Law" then
						blipStats[theTurfID] = "law"
					elseif turfOwner == "Criminals" then
						blipStats[theTurfID] = "crim"
					end
					--outputDebugString("Sending blips data")
					for i,blipName in pairs(blipStats) do
						triggerClientEvent("CSGturfing.updateBlips",root,i,blipName)
					--	outputDebugString(theTurfID.."is with "..blipName)
					end
					--triggerClientEvent("synceClientTurfs",root,theTurfID,blipStats[theTurfID],turfOwner)
				elseif theTurfID == 64 then
					if turfOwner == "Unoccupied" then
						blipStats[theTurfID] = "noone"
					elseif turfOwner == "Aurora Law" then
						blipStats[theTurfID] = "law"
					elseif turfOwner == "Criminals" then
						blipStats[theTurfID] = "crim"
					end
				----outputDebugString("Sending blips data2")
					for i,blipName in pairs(blipStats) do
						triggerClientEvent("CSGturfing.updateBlips",root,i,blipName)
					---	outputDebugString(theTurfID.."is with "..blipName)
					end
					--triggerClientEvent("synceClientTurfs",root,theTurfID,blipStats[theTurfID],turfOwner)
				elseif theTurfID == 65 then
					if turfOwner == "Unoccupied" then
						blipStats[theTurfID] = "noone"
					elseif turfOwner == "Aurora Law" then
						blipStats[theTurfID] = "law"
					elseif turfOwner == "Criminals" then
						blipStats[theTurfID] = "crim"
					end
					--outputDebugString("Sending blips data3")
					for i,blipName in pairs(blipStats) do
						triggerClientEvent("CSGturfing.updateBlips",root,i,blipName)
					---	outputDebugString(theTurfID.."is with "..blipName)
					end
					--triggerClientEvent("synceClientTurfs",root,theTurfID,blipStats[theTurfID],turfOwner)
				elseif theTurfID == 66 then
					if turfOwner == "Unoccupied" then
						blipStats[theTurfID] = "noone"
					elseif turfOwner == "Aurora Law" then
						blipStats[theTurfID] = "law"
					elseif turfOwner == "Criminals" then
						blipStats[theTurfID] = "crim"
					end
					---outputDebugString("Sending blips data4")
					for i,blipName in pairs(blipStats) do
						triggerClientEvent("CSGturfing.updateBlips",root,i,blipName)
					---	outputDebugString(theTurfID.."is with "..blipName)
					end
					--triggerClientEvent("synceClientTurfs",root,theTurfID,blipStats[theTurfID],turfOwner)
				end
				end,5000,1,CSGTurfs[i].turfid,CSGTurfs[i].turfowner)
			end
			if CSGTurfs[i].turfowner ~= "Unoccupied" then
				turfData[i].health=100
				turfData[i].mode="Owned"
			else
				turfData[i].health=15
				turfData[i].mode="Unoccupied"
			end
			turfData[i].owner=CSGTurfs[i].turfowner
			turfData[i].attackinggroup="None"
			turfData[i].col=turfColArea[i]
			turfData[i].influences = {}
			addEventHandler ( "onColShapeHit", turfColArea[i], onHitTurfZone )
			addEventHandler ( "onColShapeLeave", turfColArea[i], onLeaveTurfZone )
		end
	end

	CSGTurfingTable = CSGTurfs
end
)

function isPlayerCriminal(player)
	return getPlayerTeam(player) and (getTeamName(getPlayerTeam(player)) == "Criminals" or getTeamName(getPlayerTeam(player)) == "HolyCrap")
end

local LVcol = createColRectangle(675.86,516.25,2300,2500)
local seaCol = createColRectangle(2983.9, 356.8,850,2700)
-- When a turfer dies spawn him at a turf owned by the group
--addEventHandler( "onPlayerWasted", root,





local spawnTable = {}





--[[
addEvent( "onTurfingWasted", true)
addEventHandler( "onTurfingWasted", root,
function ()
	--if isElementWithinColShape(source,LVcol) == true or isElementWithinColShape(source,seaCol) then
		if not isPlayerCriminal(source) then return end
			local myGroup = getElementData(source,"Group")
			if not spawnTable[source] then spawnTable[source] = nil end
			for k,v in pairs(turfData) do
				if v.owner == myGroup and v.health >= 55 and (isElementWithinColShape(source,v.col)==false) then
					local x,y = getElementPosition(v.col)
					local z = 10
					local t = {x,y,z,k}
					table.insert(spawnTable[source],t)
					triggerClientEvent( source, "onClientTurferDied", source, spawnTable[source] )
					--outputDebugString("ff")
				end
			end

	--end
end
)
]]



function findNearestTurf(Dxturfing)
  local turfx = nil
  local min = 99999999
  for key,val in pairs(Dxturfing) do
		local xx,yy,zz=getElementPosition(localPlayer)
		local dist = getDistanceBetweenPoints2D(xx,yy,val[1],val[2])
		if dist < min then
			turfx = val
			min = dist
		end
	end
	return Dxturfing[1],Dxturfing[2],Dxturfing[3],Dxturfing[4]
end
local spawnTable = {}
local t = {}
local sp = {}
addEventHandler( "onPlayerWasted", root,
function ()
	--[[if isElementWithinColShape(source,LVcol) == true then
		--if not isPlayerCriminal(source) then return end

			spawnTable[source] = {}
			t[source] = {}
		for k,v in pairs(turfData) do
			if v.owner == myGroup and v.health >= 55 and (isElementWithinColShape(source,v.col)==false) then
				local x,y = getElementPosition(v.col)
				local xx,yy = getElementPosition(source)
				local z = 10
				t[source] = {x,y,z,k}
				outputChatBox("1")
				table.insert(spawnTable[source],t[source])
			end
		end
		triggerClientEvent(source,"onClientTurferDied",source,spawnTable[source])
	end]]


	setElementData(source,"x",false)
	setElementData(source,"y",false)
	setElementData(source,"z",false)
	setElementData(source,"rot",false)
	if not isPlayerCriminal(source) then return end
	local myGroup = getElementData(source,"Group")
	spawnTable[source] = {}
	sp[source] = {}
	for k,v in ipairs(turfData) do
		if v.owner == myGroup and v.health >= 55 then
			if v.owner == myGroup and v.health >= 55 and (isElementWithinColShape(source,v.col)==false) then

				local x,y = getElementPosition(v.col)
				local z = 12
				sp[source] = {x,y,z,k}
				table.insert(spawnTable[source],sp[source])

				triggerClientEvent(source,"onClientTurferDied",source,spawnTable[source])
			end
		end
	end
end
)


id = 19
addCommandHandler("turfspawnerpos",function(plr)
--[[for i=1,60 do
	outputDebugString(i)
exports.DENmysql:exec( "UPDATE turfing SET turfowner=?, r=?, g=?, b=? WHERE turfid=?",
				"Unoccupied",
				255,
				255,
				255,
				i
			)
end]]

id = id + 1
local x,y,z = getElementPosition(plr)
local rot = getPedRotation(plr)
--outputDebugString("["..id.."] = {"..x..","..y..","..z..","..rot.."},")
outputConsole("["..id.."] = {"..x..","..y..","..z..","..rot.."},",plr)
end)

function onHitTurfZone ( hitElement, matchingDimension )
	local turfNumber = getElementData ( source, "turfID" )
	local sq = getElementData ( source, "sqlID" )
	if getElementType ( hitElement ) == "player" then
		if getElementData(hitElement,"isPlayerPrime") == true then
			outputDebugString(sq.." sql id for this turf")
			outputDebugString(turfData[turfNumber].owner.." turf")
		end
		if canElementTurf(hitElement) == false then return end
		if radStations[turfNumber] == nil then
			local gangName = turfData[turfNumber].owner
			local message = "You entered the turf of " .. gangName .. "."
			local gx = getActualG(hitElement)
			if not gangName or gangName == "" then
				message = "You entered an unoccupied turf."
			elseif gx and gangName == gx then
				if gx and getElementData(hitElement,"Group") ~= gx then
					message = "You entered a turf owned by your alliance: " .. gangName .. "."
				else
					message = "You entered a turf owned by your group: " .. gangName .. "."
				end
			end
			if getElementData(hitElement,"isPlayerPrime") == true then
				outputDebugString("Turf ID : "..turfNumber.."")
			end
			exports.NGCdxmsg:createNewDxMessage(hitElement, message, 0, 230, 0)
		else
			local gangName = turfData[turfNumber].owner
			if turfData[turfNumber].owner ~= "Unoccupied" then
				exports.NGCdxmsg:createNewDxMessage(hitElement, "You entered a Radio Station turf, currently run by "..gangName.."", 0, 230, 0)
			else
				exports.NGCdxmsg:createNewDxMessage(hitElement, "You entered a Radio Station turf currently run by No one", 0, 230, 0)
			end
			--if getTeamName(getPlayerTeam(hitElement)) == "Staff" then
			--outputChatBox("TURF ID "..turfNumber.."",hitElement,255,255,0)
			--end
		end
	end

end

function isPlayerInRegTurf(p)
	for k,v in pairs(turfData) do
		if radStations[k] == nil and isElementWithinColShape(p,v.col) then
			return true
		end
	end
	return false
end

--[[
function startTurfWar (turf, group, player)
	if getPlayersFromGroupInTurf ( group, turf ) >= 1 then
		setGroupAttacking ( turf, group )
		local gangName = CSGTurfingTable[turf].turfowner
		local message = "You started a attack on a turf from " .. gangName .. "."
		if not gangName or gangName == "" then
			message = "You started a attack on a unoccupied turf."
		end
		exports.NGCdxmsg:createNewDxMessage(player, message, 0, 230, 0)
	end
end
--]]

function isLaw(p)
	if getElementType(p) == "player" then else return false end
	local team = getPlayerTeam(p)
	if(team) then
		local tName = getTeamName(team)
		if tName == "Government" or tName == "Military Forces" or tName == "GIGN" then
			return true
		end
	end
	return false
end

function isPlayerInRT(p)
	for k,v in pairs(turfData) do
		if radStations[k] ~= nil then
			if isElementWithinColShape(p,turfData[k].col) == true then
				return true
			end
		end
	end
	return false
end

local allianceDB = {}
function getActualG(v)
	local gr = getElementData(v,"Group")
	if gr and (gr ~= "None") then
		return gr
	else
		return false
	end
end

local zoneInfo = {}

addEvent("CSGwanted.wUpdate",true)
addEventHandler("CSGwanted.wUpdate",root,function(str)
	zoneInfo[source]=str
end)

addEventHandler("onPlayerQuit",root,function() zoneInfo[source] = nil end)

function getNearestRTType(p)
	return zoneInfo[p] or "noone"
end

function getGColor(group)
	return exports.AURsamgroups:getGroupColor(group)
end


LV = createColRectangle(901.67871, 601.66272, 2050, 2400)

function isElementInLV(ele)
	if (not ele or not isElement(ele)) then return nil end
	if (isElementWithinColShape(ele, LV)) then
		return true
	end
	return false
end

function getGroupOnlineMembers(groupName)
	if (not groupName) then return end
	local onlineMembers = {}
	for _, plr in ipairs(getElementsByType("player")) do
		if (getElementData(plr, "Group") == groupName) then
			table.insert(onlineMembers, plr)
		end
	end
	return onlineMembers
end

function getLawTurfs()
	local lawturfs = {}
	for i, v in pairs ( turfData ) do
		if v.owner == "Unoccupied" then
			table.insert(lawturfs,v)
		end
	end
	return #lawturfs,lawturfs
end


function turfpayout()
	local groupTurfs = { }
	for i, v in pairs ( turfData ) do
		if ( not groupTurfs [ v.owner ] ) then
			groupTurfs [ v.owner ] = 0
		end

		if v.owner ~= "Unoccupied" and v.owner ~= "Aurora Law" and v.owner ~= "Criminals" then
			if v.health >= 55 then
				groupTurfs [ v.owner ] = groupTurfs [ v.owner ] + 1
			end
		end
	end
	LVCRIMS = {}
	for i, v in pairs ( getElementsByType ( 'player' ) ) do
		if isElementInLV(v) and getPlayerTeam(v) and getTeamName(getPlayerTeam(v)) == "Criminals" then
			table.insert(LVCRIMS,v)
		end
	end
	for i, v in pairs ( getElementsByType ( 'player' ) ) do
		if getPlayerTeam(v) and (getTeamName(getPlayerTeam(v)) == "Criminals" or getTeamName(getPlayerTeam(v)) == "HolyCrap") then
			if isElementInLV(v) and getElementDimension(v) == 0 then
				local g = getElementData(v, "Group")
				if ( g and groupTurfs [ g ] and g ~= "None" and groupTurfs [ g ] > 0 ) then
					local idleTime = getPlayerIdleTime(plr)
					if (not idleTime) then
						idleTime = 0
					end
					if (type(idleTime) == "boolean") then idleTime = 0 end 
					local members = getGroupOnlineMembers(g)
					local LVMembers = 0
					for x, z in ipairs(members) do
						if (isElementInLV(z)) then
							LVMembers = LVMembers + 1
						end
					end
					if #LVCRIMS >= 4 and LVMembers >= 2 and (((idleTime / 1000) <= 60) or getPlayerIdleTime(plr) < 60000) then
						local c = ((groupTurfs [ g ] * 1500) / LVMembers)
						exports.AURpayments:addMoney(v,c,"Custom","Groups Turfing",0,"Turfs Totall CSGnewturfing2")
						exports.NGCdxmsg:createNewDxMessage(v, "("..g.." earnings $"..(groupTurfs [ g ] * 1500)..") You have earned $"..tostring(c).." for having "..tostring ( groupTurfs [ g ] ).." from your turfs in the past 10 minutes",0,255,0)
					end
				end
			end
		end
	end
	--[[local groupTurfs = { }
	for i, data in pairs ( turfData ) do
		local col = data.col
		local t = getElementsWithinColShape(col,"player")
		local groups = {}
		for k,v in pairs(t) do
			if isElementInLV(v) then
				if getElementInterior(v) == 0 and getElementDimension(v) == 0 then
					local gr = getActualG(v)
					if groups[gr] == nil then
						groups[gr] = 0
					end
				end
			end
		end

		if ( not v.attackers ) then
			groupTurfs [ v.owner ] = groupTurfs [ v.owner ] + 1
		end
	end]]
	--[[local turfs = {}
	local LVMembers = {}
	local gangs = {}

	for _, plr in ipairs(getElementsByType("player")) do
		local group = getElementData(plr,"Group")
		local grp = getElementData(plr,"GroupType")
		if (group and grp == "Criminals" and isElementInLV(plr) and exports.server:isPlayerLoggedIn(plr)) then
			local members = getGroupOnlineMembers(group)
			LVMembers[group] = 0
			for k, v in ipairs(members) do
				if (isElementInLV(v)) then
					LVMembers[group] = LVMembers[group] + 1
				end
			end


			for i,data in pairs(turfData) do
				if radStations[i] == nil then
					if data.owner ~= "Unoccupied" and data.owner ~= "Aurora Law" and data.owner ~= "Criminals" then
						if data.health >= 55 then
							if (data.owner == group) then
								if turfs[group] == nil then turfs[group] = 0 end
								turfs[group] = turfs[group] + 1
								gangs[group] = data.owner
							end
						end
					end
				end
			end
			local idleTime = getPlayerIdleTime(plr)
			if (not idleTime) then
				idleTime = 0
			end
			if (turfs[group] and tonumber(turfs[group]) and tonumber(turfs[group]) >= 1 and tonumber(LVMembers[group]) >= 1 and (idleTime / 1000) <= 1200) then
				local payout = math.floor((1500 * tonumber(turfs[group])) / tonumber(LVMembers[group]))
				outputDebugString(payout.."$ Payout for "..gangs[group].." is "..turfs[group].." * 1000 / members "..LVMembers[group])
			end
		end
	end]]
end
paying = setTimer(turfpayout, 10 * 60000, 0)
fuckme = {}
addEventHandler("onPlayerQuit",root,function()
	if fuckme[exports.server:getPlayerAccountID(source)] then
		if isTimer(fuckme[exports.server:getPlayerAccountID(source)]) then
			killTimer(fuckme[exports.server:getPlayerAccountID(source)])
		end
	end
end)

addEvent("getTurfTimer",true)
addEventHandler("getTurfTimer",root,function()
	triggerClientEvent("addTurfingTimer",root,60000*10)
	if fuckme[exports.server:getPlayerAccountID(source)] and isTimer(fuckme[exports.server:getPlayerAccountID(source)]) then killTimer(fuckme[exports.server:getPlayerAccountID(source)]) end
	fuckme[exports.server:getPlayerAccountID(source)] = setTimer(function(d)
		if (isTimer(paying) and isElement(d)) then
			local timeLeft, timeExLeft, timeExMax = getTimerDetails(paying)
			triggerClientEvent(d,"addTurfingTimer",d,timeLeft)
		end
	end,60000,0,source)
end)


--addCommandHandler("sx",function()
	--turfpayout()
--end)

doTurf = function()

for i,data in pairs(turfData) do
	local col = data.col
	local t = getElementsWithinColShape(col,"player")
	local groups = {}
	local biggestInfluenceGroup=""
	local biggestInfluence=0
	local first = {}
	local RT = {}
	local asshole = {}
	local counted = {}
	local oldHealth = data.health
	local lawRT = false
	for k,v in pairs(t) do
		if getElementInterior(v) == 0 and getElementDimension(v) == 0 and canElementTurf(v) == true then
			local gr = getActualG(v)
			local team = getPlayerTeam(v)
			local teamName = false
			if(team) then teamName = getTeamName(team) end
			if teamName and teamName == "Government" then
				gr="Government"
			end
			if gr ~= false then
				if groups[gr] == nil then groups[gr]=0 end --- bug under this
				if (canElementTurf(v) == true and ( teamName and (teamName == "Criminals" or teamName == "HolyCrap"))) or (((isLaw(v) and radStations[i] ~= nil)) or (isLaw(v) and getNearestRTType(v) == "law")) then

					--outputDebugString("Here it starts turfing")
					-- bug
					--outputDebugString("Started")
					--local gn = getActualG(v)
					--if gn and gn == "Aurora Law" and getTeamName(getPlayerTeam(v)) == "Criminals"  or gn == "GIGN" and getTeamName(getPlayerTeam(v)) == "Criminals"  or "Military Forces" and getTeamName(getPlayerTeam(v)) == "Criminals" then
					--	return
					--end
					if getNearestRTType(v) == "law" then lawRT=true end
					if first[gr] == nil then
						if counted[v] == nil then
							groups[gr] = groups[gr]+2
							local rank = getElementData(v,"Rank")
							local rank2 = getElementData(v,"skill")
							if rank == "Don of LV" then
								groups[gr]=groups[gr]+0.600
							elseif rank == "Capo" then
								groups[gr]=groups[gr]+0.333
							end
							if rank2 == "Riot Squad" then
								groups[gr]=groups[gr]+0.777
							elseif rank2 == "Task Force" then
								groups[gr]=groups[gr]+0.500
							end
							if getElementData(v,"isPlayerPrime") then
								groups[gr]=groups[gr]+500
							end
							--[[
							local rank2 = getElementData(v,"skill")
							if rank2 == false then rank2="Task Force" end
							if rank == "Don of LV" then
								groups[gr]=groups[gr]+0.600
							elseif rank2 == "Riot Squad" then
								groups[gr]=groups[gr]+0.777
								if rank2 ~= false and rank2 == "Riot Squad" then
									groups[gr]=groups[gr]+0.777
								end
							elseif rank == "Capo" then
									groups[gr]=groups[gr]+0.333
							elseif rank2 == "Task Force" then
								groups[gr]=groups[gr]+0.555
							end]]

							--if exports.CSGstaff:isPlayerStaff(v) then
							--	outputDebugString(rank.."["..getPlayerName(v).."] turf speed = "..groups[gr].." was from first check")
							--end
							counted[v]=true
							first[gr] = true
						end
					else
						if counted[v] == nil then
							local rank = getElementData(v,"Rank")
							groups[gr] = groups[gr]+1
							if rank == "Don of LV" then
								groups[gr]=groups[gr]+0.450
							elseif rank == "Capo" then
								groups[gr]=groups[gr]+0.250
							end
							--[[
							]]
							if getElementData(v,"isPlayerPrime") then
								groups[gr]=groups[gr]+500
							end
							--if exports.CSGstaff:isPlayerStaff(v) then
							--	outputDebugString(rank.."["..getPlayerName(v).."] turf speed = "..groups[gr].." was from 2nd check")
							--end
							counted[v]=true
						end
					end
				end
			end
		end
	end
	if radStations[i] ~= nil then
		local addLaw,addCrim = 0,0
		for k,v in pairs(groups) do

			if k == "GIGN" or k == "Military Forces" or k == "Government" or k == "Aurora Law" then
				addLaw=addLaw+v
			else
				addCrim=addCrim+v
			end
		end
		groups["Aurora Law"] = addLaw
		groups["Criminals"] = addCrim

	end

	if data.mode == "Unoccupied" or turfData[i].health <= 20 then
		if turfData[i].health <= 20 then
			for k,v in pairs(groups) do
				if v > biggestInfluence then
					if radStations[i] ~= nil then
						if k == "Aurora Law" or k == "Criminals" then
							biggestInfluenceGroup=k
							biggestInfluence=v
						end
					else
						biggestInfluenceGroup=k
						biggestInfluence=v
					end
				end
			end
			data.attackinggroup=biggestInfluenceGroup
			turfData[i].attackinggroup=biggestInfluenceGroup
			--new attacking turf
			--[[if radStations[i] ~= nil then
			if turfData[i].attackinggroup == "Criminals" then
				turfData[i].attackinggroup = "Aurora Law"
			else
				turfData[i].attackinggroup = "Criminals"
			end
			end--]]
		end
	end

	for k,v in pairs(groups) do
		if (k ~= data.owner and k ~= data.attackinggroup) or (radStations[i] ~= nil) then
			if radStations[i] ~= nil then
				if turfData[i].attackinggroup == "Aurora Law" then
					if k == "GIGN" or k == "Military Forces" or k == "Government" or k == "Aurora Law" then
						--do nothing
					else
						groups[k] = groups[k]*-1
					end
				elseif turfData[i].attackinggroup == "Criminals" then
					if k == "GIGN" or k == "Military Forces" or k == "Government" or k == "Aurora Law" then
						groups[k] = groups[k]*-1
					else
						--do nothing
					end
				else
					if turfData[i].owner == "Aurora Law" then
						if  k == "GIGN" or k == "Military Forces" or k == "Government" or k == "Aurora Law" then
							--do nothing
						else
							groups[k] = groups[k]*-1
						end
					elseif turfData[i].owner == "Criminals" then
						if  k == "GIGN" or k == "Military Forces" or k == "Government" or k == "Aurora Law" then
							groups[k] = groups[k]*-1
						end
					else
						groups[k] = groups[k]*-1
					end
				end

			else
				groups[k] = groups[k]*-1
			end
		end
	end
	if radStations[i] ~= nil then

	else
		if (lawRT) and ( groups["GIGN"] or groups["Military Forces"] or groups["Government"]) then
				for k,v in pairs(groups) do
					if not ( k == "GIGN" or k == "Military Forces" or k == "Government") then
						groups[k] = groups[k] * 0.5
					end
				end
			--end------------------- bug
		end
		for k,v in pairs(groups) do
			if  k == "GIGN" or k == "Military Forces" or k == "Government" then
				if v > 0 then
					groups[k] = groups[k] * -1
				end
			end
		end
	end

	local isDiff=false
	if #groups > 1 then
		for k,v in pairs(groups) do
			for k2,v2 in pairs(groups) do
				if v2 ~= v then isDiff=true end
			end
		end
	end


	for k,v in pairs(groups) do
		if radStations[i] == nil then
			turfData[i].health = turfData[i].health+v
		else
			turfData[i].health = turfData[i].health+((v/2)/2)
		end
	end
	if oldHealth == turfData[i].health or (#groups > 1 and isDiff==false) then
		data.attackinggroup="None"
		turfData[i].attackinggroup="None"
	end
	turfData[i].influences = groups
	if turfData[i].health > 100 then turfData[i].health=100 end
	if turfData[i].health < 0 then turfData[i].health=0 end

	if data.mode == "Owned" then
		if turfData[i].health <= 20 then
			turfData[i].mode="Unoccupied"
			turfData[i].oldRealGroup=turfData[i].owner
			turfData[i].owner="Unoccupied"
			turfData[i].attackinggroup="None"
			blipStats[i] = "noone"
			for k,v in pairs(getElementsByType("player")) do
				if getElementDimension(v) == 0 and getElementInterior(v) == 0 then
					if radStations[i] == nil then
						if isElementWithinColShape(v,turfData[i].col) then
							if isLaw(v) then
								------(v,1250)
								exports.AURpayments:addMoney(v,1250,"Custom","Turfing",0,"CSGnewturfing2")
								exports.AURsamgroups:addXP(v,2)
								--exports.server:givePlayerWantedPoints(v,2)
								exports.CSGscore:givePlayerScore(v,1)
								exports.NGCdxmsg:createNewDxMessage(v,"Earned $1,250 and +1 Score for Neutralizing a Criminal Turf",0,255,0)
							end
						end
						local gs =getActualG(v)
						if gs and gs == turfData[i].oldRealGroup then
							local x,y = getElementPosition(turfData[i].col)
							local zoneName=getZoneName(x,y,10)
							exports.NGCdxmsg:createNewDxMessage(v,"Your turf at "..zoneName.." was under attack and has been lost!",255,0,0)
							destroyBag(i)
							turfStability[i] = getTickCount()
						end
					else
						if isLaw(v) then
							if turfData[i].oldRealGroup == "Aurora Law" then
								exports.NGCdxmsg:createNewDxMessage(v,"Law Radio Station Turf "..radStations[i].." has been lost!",0,0,255)
								exports.NGCdxmsg:createNewDxMessage(v,"There is too much criminal influence! Respond!",0,0,255)
							end
						elseif isPlayerCriminal(v) then
							if turfData[i].oldRealGroup == "Criminals" then
								exports.NGCdxmsg:createNewDxMessage(v,"Criminals Radio Station Turf "..radStations[i].." has been lost!",0,0,255)
								exports.NGCdxmsg:createNewDxMessage(v,"There is too much Law Enforcement influence! Respond!",0,0,255)
							end
						end
						triggerClientEvent(v,"CSGturfing.updateBlips",v,i,"noone")
					end
				end

			end

			--if exports.DENlaw:isLaw(player) and isElementInLV(player) then
							local copsTurfs,copsData = getLawTurfs()
							if getPlayerCount() >= 8 then
								if copsTurfs >= 62 then
									if dontgive == true then

									else
										if dontgive == false or dontgive == nil then
											dontgive = true
											if isTimer(dickHead) then killTimer(dickHead) end
											dickHead = setTimer(function() dontgive = false end,60000*120,1)
											for prime,dark in ipairs(getElementsByType("player")) do
												if exports.DENlaw:isLaw(dark) and isElementInLV(dark) then
													exports.AURpayments:addMoney(dark,150000,"Custom","Turfing",0,"CSGnewturfing2")
													exports.NGCdxmsg:createNewDxMessage(dark,"You have earned $150,000 from neutralizing LV turfs",0,255,0)
												end
											end
											for prime,dark in ipairs(getElementsByType("player")) do
												if getPlayerTeam(dark) and (getTeamName(getPlayerTeam(dark)) == "Criminals" or getTeamName(getPlayerTeam(dark)) == "HolyCrap") then
													exports.server:givePlayerWantedPoints(dark,100)
													exports.NGCdxmsg:createNewDxMessage(dark,"You have got 100 wanted points because cops neutralized LV turfs",0,255,0)
												end
											end
										end
									end
								end
							end

							--[[if (getPlayerCount() >= 8) then
								local group = turfData[i].owner
								local qh = exports.DENmysql:query("SELECT * FROM turfing WHERE turfowner=?", group)
								if (#qh == 72) then
									if (crimdontgive[group] == false) or (crimdontgive[group] == nil) or not (crimdontgive[group]) then
										crimdontgive[group] = true
										if isTimer(dickHeadTimers[group]) then killTimer(dickHeadTimers[group]) end
											dickHeadTimers[group] = setTimer(function(group) crimdontgive[group] = false end,60000*120,1, group)
											for k,v in ipairs(getElementsByType("player")) do
												if (getElementData(v, "Group") == group) and (isElementInLV(v)) then
													exports.AURpayments:addMoney(v,150000,"Custom","Turfing",0,"CSGnewturfing2")
													exports.NGCdxmsg:createNewDxMessage(v,"You have earned $150,000 for LV Takeover!",255,255,255)
												end
											end
										end
									end
								end
							end
							end]]--
					--	end
			exports.DENmysql:exec( "UPDATE turfing SET turfowner=?, r=?, g=?, b=? WHERE turfid=?",
				turfData[i].owner,
				255,
				255,
				255,
				i
			)
			--turf lost
		elseif oldHealth > 55 and turfData[i].health <= 55 then
			for k,v in pairs(getElementsByType("player")) do
				if radStations[i] == nil then
					local gx = getActualG(v)
					if gx and gx == turfData[i].owner then
						local x,y = getElementPosition(turfData[i].col)
						local zoneName=getZoneName(x,y,10)
						exports.NGCdxmsg:createNewDxMessage(v,"Your turf at "..zoneName.." is in danger of being lost, go defend it!",255,0,0)
					end
				elseif turfData[i].owner == "Aurora Law" or turfData[i].owner == "Criminals" then
					if isLaw(v) then
						if turfData[i].owner == "Aurora Law" then
							exports.NGCdxmsg:createNewDxMessage(v,"All units be advised there is heavy criminal presence at "..radStations[i].." Radio Station",0,0,255)
							exports.NGCdxmsg:createNewDxMessage(v,"Criminals are attacking the turf! Go defend it!", 0, 0, 255)
						else
							exports.NGCdxmsg:createNewDxMessage(v,"Criminal Radio Station Turf "..radStations[i].." is being neutralized by law!",0,0,255)
							exports.NGCdxmsg:createNewDxMessage(v,"Go help them!",0,0,255)
						end
					elseif isPlayerCriminal(v) then
						if turfData[i].owner == "Criminals" then
							exports.NGCdxmsg:createNewDxMessage(v,"Criminals Radio Station Turf "..radStations[i].." is in danger of being lost!",255,0,0)
							exports.NGCdxmsg:createNewDxMessage(v,"Law Enforcement is trying to regrain control! Go defend it!",255,0,0)
						else
							exports.NGCdxmsg:createNewDxMessage(v,"Law Radio Station Turf "..radStations[i].." is being neutralized by criminals!",255,0,0)
							exports.NGCdxmsg:createNewDxMessage(v,"Go help them!",255,0,0)
						end
					end
				end
			end
		end
	elseif data.mode == "Unoccupied" then
		if ( groups["GIGN"] or groups["Military Forces"] or groups["Government"]) then
			for k,v in pairs(groups) do
				if not( k == "GIGN" or k == "Military Forces" or k == "Government") then
					groups[k] = 0
				end
			end
		end
		destroyBag(i)
		if turfData[i].health > 20 then
			data.mode="Attack in Progress"
			turfData[i].mode="Attack in Progress"
			for k,v in pairs(getElementsByType("player")) do
				local gx = getActualG(v)
				if (gx and gx == turfData[i].attackinggroup) or (radStations[i] ~= nil) then
					if radStations[i] ~= nil then
						if isPlayerCriminal(v) then
							if turfData[i].attackinggroup == "Criminals" then
								exports.NGCdxmsg:createNewDxMessage(v,"The Criminals have started an attack on Radio Station Turf "..radStations[i].."",255,0,0)
								exports.NGCdxmsg:createNewDxMessage(v,"Go help them!",255,0,0)
							elseif turfData[i].attackinggroup == "Aurora Law" then
								exports.NGCdxmsg:createNewDxMessage(v,"The Law Enforcement have started an attack on Radio Station Turf "..radStations[i].."",255,0,0)
								exports.NGCdxmsg:createNewDxMessage(v,"Go stop them and stop the Law advancement!",255,0,0)
							end
						elseif isLaw(v) then
							if turfData[i].attackinggroup == "Criminals" then
								exports.NGCdxmsg:createNewDxMessage(v,"The Criminals have started an attack on Radio Station Turf "..radStations[i].."",255,0,0)
								exports.NGCdxmsg:createNewDxMessage(v,"Go stop them and regain control!",255,0,0)
							elseif turfData[i].attackinggroup == "Aurora Law" then
								--outputDebugString("2")
								exports.NGCdxmsg:createNewDxMessage(v,"The Law Enforcement have started an attack on Radio Station Turf "..radStations[i].."",255,0,0)
								exports.NGCdxmsg:createNewDxMessage(v,"Go help them and support the Law advancement!",255,0,0)
							end
						end
					else
						local x,y = getElementPosition(turfData[i].col)
						local zoneName=getZoneName(x,y,10)
						local typeg
						if getElementData(v,"ta") == true then
							typeg="Alliance"
						else
							typeg="Group"
						end
						exports.NGCdxmsg:createNewDxMessage(v,"Your "..typeg.." is attacking a turf at "..zoneName..", go help them!",255,0,0)
					end
				end
			end
		elseif turfData[i].health <= 20 then
			turfData[i].mode = "Unoccupied"
			data.mode = "Unoccupied"
		end
	elseif turfData[i].mode == "Attack in Progress" then
		if turfData[i].health >= 55 then
			turfData[i].mode="Owned"
			turfData[i].owner=data.attackinggroup
			turfData[i].attackinggroup="None"
			--new turf owner
			local r, g, b = 0,0,0
			if turfData[i].owner ~= "Aurora Law" and turfData[i].owner ~= "Criminals" then
				local turfColorString = getGColor(turfData[i].owner)
				local turfColorTable = exports.server:stringExplode(turfColorString, ",")
				if turfColorTable == nil then
					turfColorTable = {255, 0, 0}
				end
				r, g, b = turfColorTable[1], turfColorTable[2], turfColorTable[3]
			else
				if data.owner == "Aurora Law" then
					r, g, b = 57, 55, 57
				elseif data.owner == "Criminals" then
					r, g, b = 255,0,0
				end

			end
			setRadarAreaColor(turfRadarArea[i], r, g, b, 150)
			exports.DENmysql:exec( "UPDATE `turfing` SET `turfowner`=?, `r`=?, `g`=?, `b`=? WHERE `turfid`=?",
				turfData[i].owner,
				tonumber(r),
				tonumber(g),
				tonumber(b),
				i
			)

			local grInTurf = 0
			for k,v in pairs(getElementsWithinColShape(turfColArea[i],"player")) do
				local gx = getActualG(v)
				if (gx and gx == turfData[i].owner) or (isLaw(v)) then
					grInTurf=grInTurf+1
				end
			end
			local blipName="noone"
			if turfData[i].owner == "Aurora Law" then
				blipName="law"
				blipStats[i]="law"
			elseif turfData[i].owner == "Criminals" then
				blipName="crim"
				blipStats[i]="crim"
			end
			destroyBag(i)
			for index, player in ipairs(getElementsByType("player")) do
				local oldGroup=turfData[i].oldRealGroup
				if oldGroup == nil then oldGroup = "No one" end
				local attackerMSG
				if getElementData(player,"ta") == true then
					attackerMSG = "Your alliance has captured a turf which was previously owned by " .. oldGroup .. "!"
				else
					attackerMSG = "Your group has captured a turf which was previously owned by " .. oldGroup .. "!"
				end
				turfStability[i] = getTickCount()
				local teamE = getPlayerTeam(player)
				if teamE ~= false then
					local gx = getActualG(player)
					if oldGroup and (gx and gx == oldGroup) then
						--exports.NGCdxmsg:createNewDxMessage (player, "Your turf has been captured by " .. newGroupName .. "!", 255, 0, 0 )
						--
					elseif (( gx and gx == turfData[i].owner ) and turfData[i].owner ~= oldGroup) or ((isLaw(player) or (getTeamName(teamE) == "Criminals" or getTeamName(teamE) == "HolyCrap")) and (turfData[i].owner == "Aurora Law" or turfData[i].owner == "Criminals")) then
						if turfData[i].owner == "Aurora Law" then
							local r,g,b = 0,255,0
							if isLaw(player) == false then r,g,b = 255,0,0 end
							exports.NGCdxmsg:createNewDxMessage (player, "Law Enforcement have captured the Radio Station Turf "..radStations[i].."", r,g,b)
							exports.NGCdxmsg:createNewDxMessage (player, "Station powered on, all crimes nearby being reported to NGC-PD HQ", r,g,b )
							if isLaw(player) then
								if isElementWithinColShape ( player, turfColArea[i] ) then
									exports.AURsamgroups:addXP(player,4)
									exports.DENstats:setPlayerAccountData(player,"radioTurfsTaken",exports.DENstats:getPlayerAccountData(player,"radioTurfsTaken")+1)
									exports.DENstats:setPlayerAccountData(player,"radioTurfsTakenAsCop",exports.DENstats:getPlayerAccountData(player,"radioTurfsTakenAsCop")+1)
								end
							end
							--[[for k,v in pairs(getElementsWithinColShape(turfData[i].col,"player")) do
								if isLaw(v) then
									if isTimer(antiSpam[v]) then return end
									antiSpam[v] = setTimer(function()
									exports.DENstats:setPlayerAccountData(v,"radioTurfsTaken",exports.DENstats:getPlayerAccountData(v,"radioTurfsTaken")+1)
									exports.DENstats:setPlayerAccountData(v,"radioTurfsTakenAsCop",exports.DENstats:getPlayerAccountData(v,"radioTurfsTakenAsCop")+1)
								end
							end]]
						elseif turfData[i].owner == "Criminals" then
							local r, g, b = 0, 255, 0
							if isLaw(player) then r,g,b = 0,0,255 end
							exports.NGCdxmsg:createNewDxMessage (player, "Criminals have captured the Radio Station Turf "..radStations[i].."", r,g,b )
							exports.NGCdxmsg:createNewDxMessage (player, "Station shutdown, too much criminal influence! nearby crimes not being reported!", r,g,b )
							if isLaw(player) == false and isPlayerCriminal(player) then
								if isElementWithinColShape ( player, turfColArea[i] ) then
									exports.AURsamgroups:addXP(player,4)
									exports.DENstats:setPlayerAccountData(player,"radioTurfsTaken",exports.DENstats:getPlayerAccountData(player,"radioTurfsTaken")+1)
									exports.DENstats:setPlayerAccountData(player,"radioTurfsTakenAsCrim",exports.DENstats:getPlayerAccountData(player,"radioTurfsTakenAsCrim")+1)
								end
							end
							--[[for k,v in pairs(getElementsWithinColShape(turfData[i].col,"player")) do
								if isLaw(v) == false and isPlayerCriminal(v) then
									exports.DENstats:setPlayerAccountData(v,"radioTurfsTaken",exports.DENstats:getPlayerAccountData(v,"radioTurfsTaken")+1)
									exports.DENstats:setPlayerAccountData(v,"radioTurfsTakenAsCrim",exports.DENstats:getPlayerAccountData(v,"radioTurfsTakenAsCrim")+1)
								end
							end]]
						else
							exports.NGCdxmsg:createNewDxMessage (player, attackerMSG, 0, 255, 0 )
						end
					end
					local gx = getActualG(player)
					if ( turfColArea[i] ) and ( turfData[i].owner ) and ( isElementWithinColShape ( player, turfColArea[i] ) ) and ( (gx and gx == turfData[i].owner) or (turfData[i].owner=="Aurora Law" and isLaw(player)) or (turfData[i].owner=="Criminals" and isPlayerCriminal(player)) ) then
						LVCRIMS2 = {}
						for pro, dick in pairs ( getElementsByType ( 'player' ) ) do
							if isElementInLV(dick) and getPlayerTeam(dick) and (getTeamName(getPlayerTeam(dick)) == "Criminals" or getTeamName(getPlayerTeam(dick)) == "HolyCrap") then
								table.insert(LVCRIMS2,dick)
							end
						end
						if #LVCRIMS2 < 4 then
							if grInTurf == 1 then
								-------(player, 5000)
								exports.AURpayments:addMoney(player,5000,"Custom","Groups Turfing",0,"CSGnewturfing2")
								if getNearestRTType(player) == "law" and isPlayerCriminal(player) then
									exports.server:givePlayerWantedPoints(player,5)
									else
									--exports.server:givePlayerWantedPoints(player,5)
								end
								if isElementWithinColShape(player,seaCol) then
									exports.AURpayments:addMoney(player,1000,"Custom","Sea Turfing",0,"CSGnewturfing2")
									--------(player,1000)
									exports.CSGscore:givePlayerScore(player,0.2)
								end
							elseif grInTurf == 2 then
								-------(player, 4000)
								exports.AURpayments:addMoney(player,4000,"Custom","Groups Turfing",0,"CSGnewturfing2")
								if getNearestRTType(player) == "law" and isPlayerCriminal(player) then
									exports.server:givePlayerWantedPoints(player,10)
									else
									--exports.server:givePlayerWantedPoints(player,5)
								end
								if isElementWithinColShape(player,seaCol) then
									exports.AURpayments:addMoney(player,750,"Custom","Sea Turfing",0,"CSGnewturfing2")
									------(player,750)
									exports.CSGscore:givePlayerScore(player,0.2)
								end
							elseif grInTurf > 2 then
								------(player, 3000)
								exports.AURpayments:addMoney(player,3000,"Custom","Groups Turfing",0,"CSGnewturfing2")
								if getNearestRTType(player) == "law" and isPlayerCriminal(player) then
									exports.server:givePlayerWantedPoints(player,10)
									else
									--exports.server:givePlayerWantedPoints(player,5)
								end
								if isElementWithinColShape(player,seaCol) then
									exports.AURpayments:addMoney(player,500,"Custom","Sea Turfing",0,"CSGnewturfing2")
									------(player,500)
									exports.CSGscore:givePlayerScore(player,0.2)
								end
							end
						else
							exports.AURpayments:addMoney(player,1000,"Custom","Groups Turfing",0,"CSGnewturfing2")
							if getNearestRTType(player) == "law" and isPlayerCriminal(player) then
	                            exports.server:givePlayerWantedPoints(player,10)
								else
								--exports.server:givePlayerWantedPoints(player,5)
							end
							if isElementWithinColShape(player,seaCol) then
								exports.AURpayments:addMoney(player,1000,"Custom","Sea Turfing",0,"CSGnewturfing2")
								------(player,500)
								exports.CSGscore:givePlayerScore(player,0.2)
							end
							if isElementWithinColShape(player,seaCol) then
								if turfData[i].owner == "Criminals" then
									if isPlayerCriminal(player) then
									---	----(player,1000)
										exports.AURpayments:addMoney(player,1000,"Custom","Sea Turfing",0,"CSGnewturfing2")
									end
								elseif turfData[i].owner == "Aurora Law" then
									if isLaw(player) then
										exports.AURpayments:addMoney(player,1000,"Custom","Sea Turfing",0,"CSGnewturfing2")
										------(player,1000)
										exports.CSGscore:givePlayerScore(player,1)
									end
								end
							end
						end

						---exports.server:givePlayerWantedPoints(player,4)
						exports.CSGscore:givePlayerScore(player,2)
						exports.AURsamgroups:addXP(player,2)
						local taken = exports.DENstats:getPlayerAccountData(player,"turfsTaken")
						if taken==nil or taken==false then taken=0 end
						exports.DENstats:setPlayerAccountData(player,"turfsTaken",taken+1)

					end
					triggerClientEvent(player,"CSGturfing.updateBlips",player,i,blipName)
				end
			end

		end
	end

	local toSend = turfData[i]
	toSend.oldHealth=oldHealth
	toSend.text=toSend.mode
	toSend.barText = ""
	toSend.colors = {}
	toSend.turfID = i
	toSend.colors["Government"] = {0,0,0}
	toSend.colors["Criminals Forces"] = {255,0,0}

	for k,v in pairs(groups) do
		local turfColorString = getGColor(k)
		if k ~= "Aurora Law" and k ~= "Criminals" then
			if type(turfColorString) ~= "boolean" then
				local turfColorTable = exports.server:stringExplode(turfColorString, ",")
				local r, g, b = turfColorTable[1], turfColorTable[2], turfColorTable[3]
				toSend.colors[k]={r,g,b}
			end
		else
			if k == "Aurora Law" then
				local r, g, b = 57, 55, 57
				toSend.colors[k]= {r,g,b}
			elseif k == "Criminals" then
				local r, g, b = 255, 0, 0
				toSend.colors[k]= {r,g,b}
			end
		end
	end
	if turfData[i].owner ~= "Unoccupied" then
		local turfColorString = getGColor(turfData[i].owner)
		if type(turfColorString) ~= "boolean" then
			local turfColorTable = exports.server:stringExplode(turfColorString, ",")
			if type(turfColorTable) ~= "boolean" then
				local r, g, b = turfColorTable[1], turfColorTable[2], turfColorTable[3]
				toSend.colors[turfData[i].owner]= {r,g,b}
			end
		end
	end
	if turfData[i].attackinggroup ~= "None" then
		local k = turfData[i].attackinggroup
		if (radStations[i] == nil and groups["GIGN"] or groups["Military Forces"] or groups["Government"]) then
			toSend.barText="Law Presence Detected"

		else
			toSend.barText="Attack in Progress by "..turfData[i].attackinggroup

		end
		if turfData[i].health > 20 then
			setRadarAreaFlashing(turfRadarArea[i],true)
			--local r,g,b = toSend.colors[turfData[i].attackinggroup][1],toSend.colors[turfData[i].attackinggroup][2],toSend.colors[turfData[i].attackinggroup][3]
			setRadarAreaColor ( turfRadarArea[i], 255,255,255, 150 )
		end
	else
		toSend.barText = turfData[i].owner.." Turf"
		setRadarAreaFlashing(turfRadarArea[i],false)
		local r,g,b = 255,255,255
		if turfData[i].owner ~= "Unoccupied" then
			toSend.colors["Unoccupied"] = {255,255,255}
			toSend.colors["Aurora Law"] = {57,55,57}
			toSend.colors["Criminals"] = {255,0,0}
			toSend.colors["Government"] = {0,191,255}
			if toSend.colors[turfData[i].owner] ~= nil then
				r,g,b = toSend.colors[turfData[i].owner][1],toSend.colors[turfData[i].owner][2],toSend.colors[turfData[i].owner][3]
			end
		end
		setRadarAreaColor ( turfRadarArea[i], tonumber(r), tonumber(g), tonumber(b), 150 )
	end
	if turfData[i].health > 20 and turfData[i].health < 55 and turfData[i].mode=="Owned" then
		toSend.barText = turfData[i].owner.." Turf (In Danger)"
		setRadarAreaFlashing(turfRadarArea[i],true)
	end
	toSend.colors["Unoccupied"] = {255,255,255}
	toSend.colors["Aurora Law"] = {0,100,255}
	toSend.colors["Criminals"] = {255,0,0}
	for k,v in pairs(t) do
		if (canElementTurf(v)) and (isPlayerCriminal(v)) or ((((isLaw(v))) and (radStations[i] ~= nil)) or (isLaw(v) and getNearestRTType(v) == "law")) then
			if getElementInterior(v) == 0 and getElementDimension(v) == 0 then
				triggerClientEvent(v,"recTurfData",v,toSend)
			end
		end
	end
	 if getTickCount() - turfStability[i] >= 900000 then
		if (turfData[i].owner) and (turfData[i].owner ~= "Unoccupied") and (turfData.owner ~= "Aurora Law") and (turfData.owner ~= "Criminals") then
			makeBag(i)
		end
	end
end
end
setTimer(doTurf,5000,0)

local bags = {

}

function makeBag(i)
	if not (bags[i]) then
		bags[i] = {math.random(800,1200), turfData[i].owner}
		--outputChatBox("bag made for "..turfData[i].owner.."")
		sendBagInfo(i)
	end
end

function destroyBag(i)
	turfStability[i] = getTickCount()

	if not bags[i] then
		return
	end
	--outputChatBox("bag destroyed for "..bags[i][2].."")
	for k,v in pairs(getElementsByType("player")) do
		triggerClientEvent(v,"tsKillBag",v,i)
	end
	bags[i] = nil
	turfStability[i] = getTickCount()
end

function sendBagInfo(i,p)

	if (p) then
		triggerClientEvent(p,"tsRecBagInfo",p, i,bags[i],true)
	else
		for k,e in pairs(getElementsByType("player")) do
			if exports.server:isPlayerLoggedIn(e) then
				triggerClientEvent(e,"tsRecBagInfo",e,i,bags[i])
			end
		end
	end
end

addEvent("tsBagPick",true)
addEventHandler("tsBagPick",root,function(i,zoneName)
	if bags[i] then
		local stolen = false
		local gr = getElementData(source,"Group")
		if gr ~= bags[i][2] then
			stolen = true
		end
		local money = math.random(1600,3200)
		if stolen then money = money + math.random(500,900) end
		------(source,money)
		exports.AURpayments:addMoney(source,money,"Custom","Turfing Bag",0,"CSGnewturfing2")
		if stolen then
			exports.NGCdxmsg:createNewDxMessage(source,"Got $"..money.." for stealing a turf money bag",0,255,0)
		else
			exports.NGCdxmsg:createNewDxMessage(source,"Got $"..money.." for picking up a turf money bag",0,255,0)
		end
		local grMoney = bags[i][1]
		if stolen == true then grMoney = math.random(800,1400) end
		local pName = getPlayerName(source)
		for k,v in pairs(getElementsByType("player")) do
			local gr2 = getElementData(v,"Group")
			if (gr2) and gr == gr2 then
				if stolen then
					exports.NGCdxmsg:createNewDxMessage(v,pName.." has stolen a turf money bag at "..zoneName.." from "..bags[i][2].."",0,255,0)
				else
					exports.NGCdxmsg:createNewDxMessage(v,pName.." has picked up a turf money bag at "..zoneName.."",0,255,0)
				end
				--exports.NGCdxmsg:createNewDxMessage(v,"$"..grMoney.." has been added to the group bank",0,255,0)
			end
		end
		-- add code to add to group bank here
		triggerEvent("onServerGroupBankingDeposit",source,grMoney,true)
		destroyBag(i)
	end
end)

addEvent("onServerPlayerLogin",true)
addEventHandler("onServerPlayerLogin",root,function()
	for k,v in pairs(bags) do
		if (v) then
			sendBagInfo(k,source)
		end
	end
end)

addEvent("CSGturfing.reqDefendingMoney",true)
addEventHandler("CSGturfing.reqDefendingMoney",root,function()
-------(source,30)
exports.AURpayments:addMoney(source,30,"Custom","Turfing Defend",0,"CSGnewturfing2")
exports.CSGscore:givePlayerScore(source,0.0208333)
	if isElementWithinColShape(source,seaCol) then
		-------(source,10)
		exports.AURpayments:addMoney(source,10,"Custom","Turfing Bag",0,"CSGnewturfing2")
		exports.CSGscore:givePlayerScore(source,0.0308333)
	end
end)

function turferDied ()
	for k,v in pairs(turfData) do
		if isElementWithinColShape(source,v.col) then
			triggerClientEvent(source,"recTurfData",source,nil)
			return
		end
	end
end
addEventHandler ( "onPlayerWasted", root, turferDied )

function turferDied2 (wp,kill)
	if kill and isElement(kill) and getElementType(kill) == "player" then
		if not isPedInVehicle(kill) then
			for k,v in pairs(turfData) do
				if isElementWithinColShape(source,v.col) and isElementWithinColShape(kill,v.col) then
					if isPlayerCriminal(kill) then
						if kill ~= source then
							local oldXP = exports.DENmysql:querySingle("SELECT * FROM groups WHERE groupid=?",getElementData(kill, "Group ID"))
							if oldXP then
								if oldXP.gType == "Criminals" then
									exports.CSGgroups:addXP(kill,1)
								end
							end
						end
					end
				end
			end
		end
	end
end
addEventHandler ( "onPlayerWasted", root, turferDied2 )

function onLeaveTurfZone ( leaveElement, matchingDimension )
	if getElementType(leaveElement) == "player" then
		triggerClientEvent(leaveElement,"recTurfData",leaveElement,nil)
	end
end

local badList = {
	[592]=true,
	[577]=true,
	[511]=true,
	[548]=true,
	[512]=true,
	[593]=true,
	[425]=true,
	[520]=true,
	[417]=true,
	[487]=true,
	[553]=true,
	[488]=true,
	[497]=true,
	[563]=true,
	[476]=true,
	[447]=true,
	[519]=true,
	[460]=true,
	[469]=true,
	[513]=true,
}

function canElementTurf ( theElement )
	if getElementType ( theElement ) == "player" then
		if getElementHealth ( theElement ) ~= 0 then
			if (getTeamName(getPlayerTeam(theElement)) == "Criminals" or getTeamName(getPlayerTeam(theElement)) == "HolyCrap") and getActualG(theElement) == "Military forces" or getActualG(theElement) == "GIGN" and (getTeamName(getPlayerTeam(theElement)) == "Criminals" or getTeamName(getPlayerTeam(theElement)) == "HolyCrap") or getActualG(theElement) == "Aurora Law" and (getTeamName(getPlayerTeam(theElement)) == "Criminals" or getTeamName(getPlayerTeam(theElement)) == "HolyCrap") then return false end
			if getPedOccupiedVehicle( theElement ) then
				local theVehicle = getPedOccupiedVehicle( theElement )
				if ( isElement(theVehicle) ) and (badList[getElementModel(theVehicle)]) then
					return false
				else
					return true
				end
			else
				return true
			end
		else
			return false
		end
	else
		return false
	end
end

addEvent( "onGroupChangeColor", true )
function setNewTurfColor (group, colorString)
	if type(colorString) == "boolean" then return end
	local turfColorTable = exports.server:stringExplode(colorString, ",")
	local r, g, b = turfColorTable[1], turfColorTable[2], turfColorTable[3]
	for i,v in pairs(turfData) do
		if v.owner == group then
			setRadarAreaColor ( turfRadarArea[i], tonumber(r), tonumber(g), tonumber(b), 150 )
		end
	end
end
addEventHandler ( "onGroupChangeColor", root, setNewTurfColor )

addEvent( "onAllianceChangeColor", true )
function setNewTurfColorA (alliance, r,g,b)
 	for i,v in pairs(turfData) do
		if v.owner == alliance then
			setRadarAreaColor ( turfRadarArea[i], tonumber(r), tonumber(g), tonumber(b), 150 )
		end
	end
end
addEventHandler ( "onAllianceChangeColor", root, setNewTurfColorA )

addEventHandler("onPlayerLogin",root,function()
local player=source
for i,blipName in pairs(blipStats) do
	triggerClientEvent(player,"CSGturfing.updateBlips",player,i,blipName)
end
end)


---- new feature
--[[
addEventHandler("onPlayerWasted",root,function( ammo, killer, weapon, bodypart )
if killer and getElementType(killer) == "player" then
for i,data in pairs(turfData) do
	local col = data.col
	    local t = getElementsWithinColShape(col,"player")
	        if t then
                if isPlayerCriminal(killer) and isPlayerCriminal(source) then
                    if getActualG(killer) ~= getActualG(source) then
                        if getNearestRTType(player) == "law" then
	                        ----(killer,1000)
	                     ---   exports.server:givePlayerWantedPoints(killer,10)
	                        exports.NGCdxmsg:createNewDxMessage(killer,"You have killed "..getPlayerName(source).." while Nearest RT for law (Kill rewards $1000)",0,255,0)
                        else
	                        ----(killer,500)
	                    exports.NGCdxmsg:createNewDxMessage(killer,"You have killed "..getPlayerName(source).." (Kill rewards $500) ",0,255,0)
		            end
	            end
	        end
	    end
	end
	else
	outputDebugString("Fail Attacker in turf")
	end
end)
]]
addCommandHandler("RT",function(player)
if getNearestRTType(player) == "law" then
outputDebugString("LAW")
elseif getNearestRTType(player) == "crim" then
outputDebugString("Crim")
end
end)
