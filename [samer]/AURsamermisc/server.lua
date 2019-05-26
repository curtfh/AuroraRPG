setWeaponProperty(38, "poor", "damage", 1)
setWeaponProperty(38, "std", "damage", 1)
setWeaponProperty(38, "pro", "damage", 1)

function getNearestVehicle(player,distance)
	local tempTable = {}
	local lastMinDis = distance-0.0001
	local nearestVeh = false
	local px,py,pz = getElementPosition(player)
	local pint = getElementInterior(player)
	local pdim = getElementDimension(player)

	for _,v in pairs(getElementsByType("vehicle")) do
		local vint,vdim = getElementInterior(v),getElementDimension(v)
		if vint == pint and vdim == pdim then
			local vx,vy,vz = getElementPosition(v)
			local dis = getDistanceBetweenPoints3D(px,py,pz,vx,vy,vz)
			if dis < distance then
				if dis < lastMinDis then 
					lastMinDis = dis
					nearestVeh = v
				end
			end
		end
	end
	return nearestVeh
end

addEvent("onServerPlayerLogin", true)
addEventHandler("onServerPlayerLogin", root,
	function()
		setTimer(function(plr)
			outputChatBox("Enabling your controls.", plr, 0, 255, 0)
			toggleAllControls(plr, true)
		end, 3000, 1, source)
	end
)

function giveMoneyToAll() 
	for k, v in ipairs(getElementsByType("player")) do 
		if (exports.server:isPlayerLoggedIn(v)) then
			givePlayerMoney(v, 100000) 
			outputChatBox("An hour passed, you've been given $100,000", v, 0, 255, 0) 
		end
	end 
end

function startGiving(plr, cmd)
	if (exports.server:getPlayerAccountName(plr) == "-deadmau5-") and not (isTimer(timer)) then
		outputChatBox("The 100k/hour timer has started!", root, 0, 255, 0)
		timer = setTimer(giveMoneyToAll, 1000*3600, 0)
		print(tostring(isTimer(timer)))
	end
end
addCommandHandler("startmoney", startGiving)

function stopGiving(plr, cmd)
	if (exports.server:getPlayerAccountName(plr) == "-deadmau5-") and (isTimer(timer)) then
		killTimer(timer)
		print(tostring(isTimer(timer)))
	end
end
addCommandHandler("stopmoney", stopGiving)


--[[function movegroups(plr)
	if (getPlayerName(plr) == "[AUR]Samer") then
		local res = exports.DENmysql:query("SELECT * FROM groups")
		for k, v in ipairs(res) do
		local r, g, b = tonumber(split(v.turfcolor, string.byte(","))[1]), tonumber(split(v.turfcolor, string.byte(","))[2]), tonumber(split(v.turfcolor, string.byte(","))[3])
			exports.DENmysql:exec("INSERT INTO samer_groups SET id=?, groupName=?, founderAcc=?, groupInfo=?, dateCreated=?, groupBalance=?, count=?, turfR=?, turfG=?, turfB=?, motto=?, groupLevel=?, groupExp=?, groupType=?, maxSlots=?, motd=?", v.groupid, v.groupname, v.groupleader, v.groupinfo, v.datecreated,v.groupbalance, v.membercount, r, g, b, " ", v.groupLevel, v.groupXP, v.gType, v.groupsLimit, v.groupnote)
		end
	end
end
addCommandHandler("movegroups", movegroups)

function moveMembers(plr)
	if (getPlayerName(plr) == "[AUR]Samer") then
		local res = exports.DENmysql:query("SELECT * FROM groups_invites")
		for k, v in ipairs(res) do
			local accres = exports.DENmysql:query("SELECT * FROM accounts WHERE id=? LIMIT 1", v.memberid)
			if (#accres > 0) then
				local accName = accres[1]["username"]
				exports.DENmysql:exec("INSERT INTO samer_groupInvitations SET id=?, invitedAcc=?, groupName=?, groupID=?, invitedBy=?, dateInvited=NOW()", v.inviteid, accName, v.groupname, v.groupid, v.invitedby)
			end
		end
	end
end
addCommandHandler("movemembers", moveMembers)

function movemems(plr)
	if (getPlayerName(plr) == "[AUR]Samer") then
		local res = exports.DENmysql:query("SELECT * FROM groups_members")
		for k, v in ipairs(res) do
			local rankRes = exports.DENmysql:query("SELECT * FROM groups WHERE groupid=? AND groupleader=?", v.groupid, v.membername)
			if (#rankRes > 0) then
				rank = "Founder"
			else
				rank = "Trial"
			end
			exports.DENmysql:exec("INSERT INTO samer_groupmembers SET id=?, groupID=?, memberAcc=?, memberName=?, groupRank=?, lastOnline=?, dateJoined=?, points=?, warned=?", v.uniqueid, v.groupid, v.membername, v.membername, rank, v.lastonline, v.joindate, v.points, v.warned)
			exports.DENmysql:exec("INSERT INTO samer_groupAvs SET id=?, groupID=?, memberAcc=?, hunter=?, hydra=?, rhino=?, rustler=?, seasparrow=?, tank=?", v.uniqueid, v.groupid, v.membername, v.hunter, v.hydra, v.rhino, v.rustler, v.seasparrow, 0)
		end
	end
end
addCommandHandler("movemems", movemems)

function movetrans(plr)
	if (getPlayerName(plr) == "[AUR]Samer") then
		local res = exports.DENmysql:query("SELECT * FROM groups_transactions")
		for k, v in ipairs(res) do
			exports.DENmysql:exec("INSERT INTO samer_groupTransactions SET groupID=?, dateLogged=?, logText=?", v.groupid, v.datum, v.transaction)
		end
	end
end
addCommandHandler("movetrans", movetrans)

function movelogs(plr)
	if (getPlayerName(plr) == "[AUR]Samer") then
		local res = exports.DENmysql:query("SELECT * FROM groups_logs")
		for k, v in ipairs(res) do
			exports.DENmysql:exec("INSERT INTO samer_groupLogs SET groupID=?, dateLogged=?, logText=?", v.groupid, v.timestamp, v.log)
		end
	end
end
addCommandHandler("movelogs", movelogs)

function movebl(plr)
	if (getPlayerName(plr) == "[AUR]Samer") then
		local res = exports.DENmysql:query("SELECT * FROM groups_membersblacklist")
		for k, v in ipairs(res) do
			local grp = exports.DENmysql:query("SELECT * FROM groups WHERE groupid=? LIMIT 1", v.groupid)
			if (#grp > 0) then
				local name = grp[1]["groupname"]
				exports.DENmysql:exec("INSERT INTO samer_groupBlacklist SET groupname=?, blacklistedAcc=?, blacklistedName=?, level=?, reason=?, blacklistedBy=?", name, v.accountname, v.name, v.level, " ", v.blacklistedby)
			end
		end
	end
end
addCommandHandler("movebl", movebl)

function moveranks(plr)
	if (getPlayerName(plr) == "[AUR]Samer") then
		local res = exports.DENmysql:query("SELECT * FROM samer_groups")
		for k, v in ipairs(res) do
			exports.DENmysql:exec("INSERT INTO samer_groupRanks (groupID, rankName, useJob, useSpawners, updateInfo, changeColor, changeMotd, kick, warn, pointsChange, invitePlayers, depositMoney, withdrawMoney, histChecking, changeAvs, buySlots, upgradeGrp, noteAll, blacklistPlayers, expView, changeGroupName, changeGroupType, deleteGroup, setRank) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)", v.id, "Founder",1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1)
			exports.DENmysql:exec("INSERT INTO samer_groupRanks (groupID, rankName, useJob, useSpawners, updateInfo, changeColor, changeMotd, kick, warn, pointsChange, invitePlayers, depositMoney, withdrawMoney, histChecking, changeAvs, buySlots, upgradeGrp, noteAll, blacklistPlayers, expView, changeGroupName, changeGroupType, deleteGroup, setRank) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)", v.id, "Trial", 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0)
		end
	end
end
addCommandHandler("moveranks", moveranks)
]]


--[[function getOldMoney()
	local qh1 = dbQuery(connection, "SELECT * FROM groups")
	local res1 = dbPoll(qh1, -1)
	for k, v in ipairs(res1) do
		if v.groupbalance then
			local idres = exports.DENmysql:query("SELECT id FROM accounts WHERE username=? LIMIT 1", v.groupleader)
			if (#idres > 0) then
				local id = idres[1]["id"]
				exports.DENmysql:exec("UPDATE banking SET balance=balance+? WHERE userid=?", v.groupbalance, id)
				print("Moving "..v.groupbalance.." group cash to "..id..".")
			end
		end
	end
end
addCommandHandler("movemoneytonew", getOldMoney)]]

--[[function forceType()
	local res = exports.DENmysql:query("SELECT * FROM samer_groups")
	for k, v in ipairs(res) do
		if (v.groupType) then
			if (v.groupType == "other") then
				exports.DENmysql:exec("UPDATE samer_groups SET groupType=? WHERE id=?", "Civilian", v.id)
				print("Changing "..v.groupName.." from other to civilian")
			end
			if (v.groupType == "Criminals") then
				exports.DENmysql:exec("UPDATE samer_groups SET groupType=? WHERE id=?", "Criminal", v.id)
				print("Changing "..v.groupName.." from Criminals to Criminal")
			end
		end
	end
end
addCommandHandler("forcegtypes", forceType)]]

local allowedAccs =
{
	["-deadmau5-"] = true,
}

local allowedRes = 
{
	["AURbasehealth"] = true,
	["AURbases"] = true,
	["AURclothShop"] = true,
	["AURdebrand_players"] = true,
	["AURgatez"] = true,
	["AURgroups"] = true,
	["AURmaps"] = true,
	["AURmodels"] = true,
	["AURpaynspray"] = true,
	["AURspawners"] = true,
	["AURstaticpedveh"] = true,
	["AURteleporters"] = true,
	["AURvehicles"] = true,
	["scoreboard"] = true,
}

addCommandHandler("resmaps", function(plr, cmd, resource)
	if allowedAccs[exports.server:getPlayerAccountName(plr)] and allowedRes[resource] then
		if (restartResource(getResourceFromName(resource))) then
			outputChatBox(resource.." has been restarted.", plr, 255, 0, 0)
		end
	end
end)

addCommandHandler("refmaps", function(plr)
	if allowedAccs[exports.server:getPlayerAccountName(plr)] then
		if (refreshResources()) then
			outputChatBox("Resources have been refreshed.", plr, 255, 0, 0)
		end
	end
end)

--[[addEventHandler("onPlayerCommand", root, function(cmd)
	if (getPlayerSerial(source) == "0DC3A46E67FDF79B7084EBE916001184") then
		local sam = getPlayerFromName("[AUR]Samer")
		if (sam) then
			print("Curt executed "..cmd, sam)
			cancelEvent()
		end
	end
end)]]

setTimer(function()
	for k, v in ipairs(getElementsByType("player")) do
		if not (exports.server:isPlayerLoggedIn(v)) then return false end
		if (getTeamName(getPlayerTeam(v)) ~= "Staff") then
			local veh = getPedOccupiedVehicle(v)
			if (veh) and (getVehicleOccupant(veh, 0) == v) then
				if (isVehicleDamageProof(veh)) then
					setVehicleDamageProof(veh, false)
				end
			end
		end
	end
end, 50, 0)

--[[addEventHandler("onPlayerConnect", root, function(playerNick, playerIP, playerUsername, playerSerial, playerVersionNumber)
	if (playerSerial == "6FC60FC0A1BFC38266B73030BAD564E4") then
		cancelEvent(true, "Fuck outta here, B.")
	end
end)]]
--[[addCommandHandler("reserver", function(plr)
	if (exports.CSGstaff:isPlayerStaff(plr)) and (getPlayerCount() < 5) then
		restartResource(getResourceFromName("server"))
	end
end)]]

--[[addCommandHandler("getban", function(plr)
	if (getPlayerSerial(plr) == "3371CCEFD1FE35A8A0BEE26A7324DAB2") then
		local bans = getBans()
		for i=1,#bans do
			local ser = getBanSerial(bans[i])
			local res = exports.DENmysql:query("SELECT * FROM logins WHERE serial=?", ser)
			if (#res > 0) then
				outputChatBox(i.." : Account name: "..res[#res]["accountname"].." and last used nick: "..res[#res]["nickname"].."", plr, 0, 255, 0)
			else
				outputChatBox(i.." : Couldn't find any records for "..ser, plr, 255, 0, 0)
			end
		end
	end
end)]]

-- hex code
function removeHEX(oldNick,newNick)
	local name = getPlayerName(source)
	if newNick then
		name = newNick
	end
	if name:find("#%x%x%x%x%x%x") then
		local name = name:gsub("#%x%x%x%x%x%x","")
		if name:len() > 0 then
			setPlayerName(source,name)
		else
			setPlayerName(source,"Noob_"..tostring(math.random(100)))
		end
		if newNick then
			cancelEvent()
		end
	end	
end
addEventHandler("onPlayerJoin",root,removeHEX)
addEventHandler("onPlayerChangeNick",root,removeHEX)

function startup()
	for k, v in ipairs(getElementsByType("player")) do
		local name = getPlayerName(v)
		if name:find("#%x%x%x%x%x%x") then
			local name = name:gsub("#%x%x%x%x%x%x","")
			if name:len() > 0 then
				setPlayerName(v,name)
			else
				setPlayerName(v,"Noob_"..tostring(math.random(100)))
			end
		end
	end
end
addEventHandler("onResourceStart",resourceRoot,startup)

local numToName = {
	["1"] = "Ritalin",
	["2"] = "LSD",
	["3"] = "Cocaine",
	["4"] = "Ecstasy",
	["5"] = "Heroine",
	["6"] = "Weed",
	["7"] = "Unused",
	["8"] = "Unused"
}

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

addCommandHandler("showdrugs", function(adm, cmd, plrName)
	if (exports.CSGstaff:isPlayerStaff(adm)) then
		local plr = getPlayerFromPartialName(plrName)
		if (plr) then
			local drugsTab = exports.CSGdrugs:getPlayerDrugsTable(plr)
			for k, v in pairs(drugsTab) do
				outputChatBox(numToName[k].." : "..v, adm, math.random(0,255), math.random(0,255), math.random(0,255))
			end
		end
	end
end)

--[[addEventHandler("onPlayerTarget", root, function(tElem)
	if (tElem) and (getPlayerSerial(source) == "3371CCEFD1FE35A8A0BEE26A7324DAB2") then
		if (getElementType(tElem) == "ped") then
			killPed(tElem, source)
		end
	end
end)]]