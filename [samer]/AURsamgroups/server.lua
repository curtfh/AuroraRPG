addEvent("onServerPlayerLogin", true)
local isShowing = {}
local antiSpam = {}
local cacheSamerGroupsTbl = {}
local groupIDToPointer = {}

function getTimeDate()
	local aRealTime = getRealTime ( )
	return
	string.format ( "%04d/%02d/%02d", aRealTime.year + 1900, aRealTime.month + 1, aRealTime.monthday ),
	string.format ( "%02d:%02d:%02d", aRealTime.hour, aRealTime.minute, aRealTime.second )
end

function addInviteLog(groupname,player,account,inviter,iaccount)
	local date, time = getTimeDate()
	local final = "["..date.. " - "..time.."]"
	exports.DENmysql:exec("INSERT INTO groupmanager SET groupname=?,nickname=?,accountname=?,invitedby=?,iaccount=?,times=?",groupname,player,account,inviter,iaccount,final)
end

function changeisShowing()
	isShowing[client] = false
end
addEvent("AURgroups.changeisShowing", true)
addEventHandler("AURgroups.changeisShowing", root, changeisShowing)

function getPlayerFromAccountID(id)
	if (id) then
		for k, v in ipairs(getElementsByType("player")) do
			if (getElementData(v, "accountUserID") == id) then
				return v
			end
		end
	return false
	end
end

function getPlayerFromAccountName(theName)
	local lowered = string.lower(tostring(theName))
	for k,v in ipairs (getElementsByType ("player" )) do
		if (getElementData(v, "playerAccount")) and (string.lower(getElementData(v, "playerAccount")) == lowered) then
			return v
		end
	end
end

function startDatabase()
	if (not getResourceFromName("DENmysql")) or (getResourceState(getResourceFromName("DENmysql")) == "loaded") then
		cancelEvent()
		outputChatBox(""..getResourceName(getThisResource()).." failed to start due to some MySQL resource failure.", root, 255, 0, 0)
	else
		exports.DENmysql:exec("CREATE TABLE IF NOT EXISTS samer_groups (id INT NOT NULL AUTO_INCREMENT PRIMARY KEY, groupName TEXT, founderAcc TEXT, groupInfo TEXT, dateCreated timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP, groupBalance INT, count INT, turfR INT, turfG INT, turfB INT, motto TEXT, groupLevel INT, groupExp INT, groupType TEXT, maxSlots INT, motd TEXT)")
		exports.DENmysql:exec("CREATE TABLE IF NOT EXISTS samer_groupmembers (id INT NOT NULL AUTO_INCREMENT PRIMARY KEY, groupID INT, memberAcc TEXT, memberName TEXT, groupRank TEXT, lastOnline INT, dateJoined timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP, points INT, warned INT)")
		exports.DENmysql:exec("CREATE TABLE IF NOT EXISTS samer_groupLogs (id INT NOT NULL AUTO_INCREMENT PRIMARY KEY, groupID INT, dateLogged timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP, logText TEXT)")
		exports.DENmysql:exec("CREATE TABLE IF NOT EXISTS samer_groupRanks (id INT NOT NULL AUTO_INCREMENT PRIMARY KEY, groupID INT, position INT, rankName TEXT, useJob INT, useSpawners INT, updateInfo INT, changeColor INT, changeMotd INT, kick INT, warn INT, pointsChange INT, invitePlayers INT, depositMoney INT, withdrawMoney INT, histChecking INT,changeAvs INT, buySlots INT, upgradeGrp INT, noteAll INT, blacklistPlayers INT, expView INT, changeGroupName INT, changeGroupType INT, deleteGroup INT, setRank INT)")
		exports.DENmysql:exec("CREATE TABLE IF NOT EXISTS samer_groupBlacklist (id INT NOT NULL AUTO_INCREMENT PRIMARY KEY, groupname TEXT, blacklistedAcc TEXT, blacklistedName TEXT, level INT, reason INT, blacklistedBy TEXT)")		
		exports.DENmysql:exec("CREATE TABLE IF NOT EXISTS samer_groupAvs (id INT NOT NULL AUTO_INCREMENT PRIMARY KEY, groupID INT, memberAcc TEXT, hunter INT, hydra INT, rhino INT, rustler INT, seasparrow INT, tank INT)")
		exports.DENmysql:exec("CREATE TABLE IF NOT EXISTS samer_groupInvitations (id INT NOT NULL AUTO_INCREMENT PRIMARY KEY, invitedAcc TEXT, groupName TEXT, groupID INT, invitedBy TEXT, dateInvited timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP)")
		exports.DENmysql:exec("CREATE TABLE IF NOT EXISTS samer_groupTransactions (id INT NOT NULL AUTO_INCREMENT PRIMARY KEY, groupID INT, dateLogged timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP, logText TEXT)")
		cacheSamerGroupsTbl = exports.DENmysql:query("SELECT * FROM samer_groups")
		groupIDToPointer = {}
		groupNameToPointer = {}
		for i, v in pairs(cacheSamerGroupsTbl) do
			if (v.id and v.groupName) then
				groupIDToPointer[v.id] = i
				groupNameToPointer[v.groupName] = i
			end
		end
		groupIDToRanksPointer = {}
		local cacheSamerGroupRanksTbl = exports.DENmysql:query("SELECT * FROM samer_groupRanks")
		for i, v in pairs(cacheSamerGroupRanksTbl) do
			if (not groupIDToRanksPointer[v.groupID]) then
				groupIDToRanksPointer[v.groupID] = {}
			end
			--exports.DENmysql:exec("UPDATE samer_groupRanks SET position = ? WHERE id = ?", (v.rankName == "Founder" and -1 or (#groupIDToRanksPointer[v.groupID])), v.id)
			table.insert(groupIDToRanksPointer[v.groupID], v)
		end
		for k, v in ipairs(getElementsByType("player")) do
			bindKey(v, "F6", "down", showGroupPanel)    
			local res = exports.DENmysql:query("SELECT * FROM samer_groupmembers WHERE memberAcc=? LIMIT 1", exports.server:getPlayerAccountName(v))
			if (#res > 0) then
				setElementData(v, "Group ID", res[1]["groupID"])
				setElementData(v, "Group", getGroupName(res[1]["groupID"]))
				setElementData(v, "Group Rank", res[1]["groupRank"])
			else
				setElementData(v, "Group", "None")
				setElementData(v, "Group Rank", "None")
			end
		end
	end
end
addEventHandler("onResourceStart", resourceRoot, startDatabase)

addEvent("callGroupSpawnAccess",true)
addEventHandler("callGroupSpawnAccess",root,function()
	local playerID = exports.server:getPlayerAccountName( source )
	local groupID = getElementData(source, "Group ID")
	if groupID then
		local spawnData = exports.DENmysql:querySingle("SELECT * FROM samer_groupAvs WHERE groupID=? AND memberAcc=?",groupID,playerID)
		if spawnData.hydra == nil or spawnData.hydra == false then spawnData.hydra = 0 end
		if spawnData.rustler == nil or spawnData.rustler == false then spawnData.rustler = 0 end
		if spawnData.hunter == nil or spawnData.hunter == false then spawnData.hunter = 0 end
		if spawnData.rhino == nil or spawnData.rhino == false then spawnData.rhino = 0 end
		if spawnData.seasparrow == nil or spawnData.seasparrow == false then spawnData.seasparrow = 0 end
		local stbl = {
			{"Hydra",spawnData.hydra},
			{"Rustler",spawnData.rustler},
			{"Hunter",spawnData.hunter},
			{"Rhino",spawnData.rhino},
			{"Seasparrow",spawnData.seasparrow},
		}
		triggerClientEvent(source,"avList",source,stbl)
	end
end)

function showGroupPanel(thePlayer)
	if (isShowing[thePlayer]) then
		triggerClientEvent(thePlayer, "AURgroups.initGroupWnd", thePlayer, {}, {}, {}, {}, {}, {}, {}, {}, {}, getRealTime().timestamp)
		isShowing[thePlayer] = false
		antiSpam[thePlayer] = getTickCount()
	else
		if (antiSpam[thePlayer]) and (getTickCount() - antiSpam[thePlayer] <= 600) then return false end
		if not (exports.server:isPlayerLoggedIn(thePlayer)) then return false end
		local accName = exports.server:getPlayerAccountName(thePlayer)
		--if not (exports.CSGstaff:isPlayerStaff(thePlayer)) then return false end
		local groupName = getElementData(thePlayer, "Group")
		local groupID = getElementData(thePlayer, "Group ID")
		local membersTable = exports.DENmysql:query("SELECT * FROM samer_groupmembers WHERE groupID=?", groupID)
		local blacklistedTable = exports.DENmysql:query("SELECT * FROM samer_groupBlacklist WHERE groupname=?", groupName)
		local groupsTable = cacheSamerGroupsTbl
		local myGroupTable = exports.DENmysql:query("SELECT * FROM samer_groups WHERE id=?", groupID) 
		local logsTable = exports.DENmysql:query("SELECT * FROM samer_groupLogs WHERE groupID=? ORDER BY dateLogged DESC ", groupID)
		local transactionsTable = exports.DENmysql:query("SELECT * FROM samer_groupTransactions WHERE groupID=? ORDER BY dateLogged DESC", groupID)
		local avTable = exports.DENmysql:query("SELECT * FROM samer_groupAvs WHERE groupID=?", groupID)
		local invitationsTable = exports.DENmysql:query("SELECT * FROM samer_groupInvitations WHERE invitedAcc=?", exports.server:getPlayerAccountName(thePlayer))
		local ranksTable = groupIDToRanksPointer[groupID]
		triggerClientEvent(thePlayer, "AURgroups.initGroupWnd", thePlayer, membersTable, blacklistedTable, groupsTable, logsTable, transactionsTable, avTable, invitationsTable, ranksTable, "", myGroupTable,  getRealTime().timestamp)
		isShowing[thePlayer] = true
		antiSpam[thePlayer] = getTickCount()
	end
end
addCommandHandler("samgroups", showGroupPanel)
addEvent("AURgroups.showGroupPanel", true)
addEventHandler("AURgroups.showGroupPanel", root, showGroupPanel)

local perms = {"useJob", "useSpawners", "updateInfo", "changeColor", "changeMotd", "kick"," warn", "pointsChange", "invitePlayers", "depositMoney", "withdrawMoney", "histChecking", "changeAvs", "buySlots", "upgradeGrp", "noteAll", "blacklistPlayers", "expView", "changeGroupName", "changeGroupType", "deleteGroup", "setRank"}

function getGroupName(groupID)
	if (groupIDToPointer[groupID]) then
		return cacheSamerGroupsTbl[groupIDToPointer[groupID]]["groupName"]
	else
		return false
	end
end

function getGroupID(groupName)
	if (groupNameToPointer[groupName]) then
		return cacheSamerGroupsTbl[groupNameToPointer[groupName]]["id"]
	else
		return false
	end
end

function getGroupColor(groupName)
	if (groupNameToPointer[groupName] and cacheSamerGroupsTbl[groupNameToPointer[groupName]]["turfR"]) then
		return cacheSamerGroupsTbl[groupNameToPointer[groupName]]["turfR"]..","..cacheSamerGroupsTbl[groupNameToPointer[groupName]]["turfG"]..","..cacheSamerGroupsTbl[groupNameToPointer[groupName]]["turfB"]
	else
		return false
	end
end

-- Update at client side once you update it here
local expInformation = {
	["Criminal"] = {
		[1] = {"Kill someone in turf",5}, --- added
		[2] = {"Turf taken",1}, --- added
		[3] = {"Cop killer in CnR event",20}, -- added
		[4] = {"Taken RT",2}, --- added
		[5] = {"Destroyed AT",15}, -- added
		[6] = {"Success CnR event",20}, --- added
		[7] = {"Store robbed",5}, -- added
		[8] = {"Success MR",20},
		[9] = {"Success Drug truck escort",20}, -- Added
		[10] = {"Armor Delivery",10}, ---added
		[11] = {"Killed a cop",3}, ---added
	},
	["Law"] = {
		[1] = {"Tazer assists",5}, --- added
		[2] = {"Turf taken",1}, -- added
		[3] = {"Criminal killed in CnR event",20}, -- added
		[4] = {"Taken RT",2}, --- added
		[5] = {"Success AT",15}, -- added
		[6] = {"Success CnR event",20}, --- added
		[7] = {"Jailed a criminal",5}, ---- added
		[8] = {"x3 Criminals jailed",20}, ---- added
		[9] = {"Jailed +800 WP criminal",30}, --- added
		[10] = {"Success Hostages Rescue",10}, -- added
	},
	["Civilian"] = {
		[1] = {"Working as a Clothes Seller",7}, --- added
		[3] = {"Working as a Trash Collector",3}, -- added
		[4] = {"Working as a Trucker",7}, --- added
		[5] = {"Working as a Pilot",7}, -- added
		[6] = {"Working as a Street Cleaner",2}, --- added
		[7] = {"Working as a Mechanic",3}, ---- added
		[8] = {"Working as a Farmer",0.5}, ---- added
		[9] = {"Working as a Lumberjack",2}, --- added
		[10] = {"Working as a Rescuer Man",3}, -- added
		[11] = {"Working as a Taxi Driver",4}, -- added
		[12] = {"Working as a Miner",3}, -- added
	},
}

function addXP(player,ids)
	if player and isElement(player) then
		local playerID = exports.server:getPlayerAccountID( player )
		local groupID = getElementData(player, "Group ID")
		local column = {}
		if playerID and groupID then
			local oldXP = groupIDToPointer[groupID]
			if oldXP then
				oldXP = cacheSamerGroupsTbl[groupIDToPointer[groupID]]
				if oldXP.groupExp == nil or oldXP.groupExp == false or not oldXP.groupExp then
					oldXP.groupExp = 0
				end
				if oldXP.groupExp then
					local grtype = oldXP.groupType
					if grtype then
						if grtype == "Criminal" then
							if getPlayerTeam(player) and getTeamName(getPlayerTeam(player)) ~= "Criminals" then
								return false
							end
						end
						if grtype == "Law" then
							if exports.DENlaw:isLaw(player) ~= true then
								return false
							end
						end
						if grtype == "Civilian" then
							if getPlayerTeam(player) and getTeamName(getPlayerTeam(player)) ~= "Civilian Workers" then
								return false
							end
						end
						if expInformation[grtype] then
							local ids = tonumber(ids)
							local xpdata = expInformation[grtype][ids][1]
							local xp = expInformation[grtype][ids][2]
							if xp then
								local newxp = tonumber(oldXP.groupExp) + tonumber(xp)
								if exports.DENmysql:exec("UPDATE samer_groups SET groupExp=? WHERE id=?",tonumber(newxp),groupID) then
									cacheSamerGroupsTbl[groupIDToPointer[groupID]]["groupExp"] = tonumber(newxp)
									triggerClientEvent(player,"setXPMsg",player,xpdata,xp)
									local data = exports.DENmysql:query("SELECT * FROM groupStats WHERE groupid=? LIMIT 1",groupID)
									if data then
										if tonumber(ids) == 1 then
											column[groupID] = data.action1
										elseif tonumber(ids) == 2 then
											column[groupID] = data.action2
										elseif tonumber(ids) == 3 then
											column[groupID] = data.action3
										elseif tonumber(ids) == 4 then
											column[groupID] = data.action4
										elseif tonumber(ids) == 5 then
											column[groupID] = data.action5
										elseif tonumber(ids) == 6 then
											column[groupID] = data.action6
										elseif tonumber(ids) == 7 then
											column[groupID] = data.action7
										elseif tonumber(ids) == 8 then
											column[groupID] = data.action8
										elseif tonumber(ids) == 9 then
											column[groupID] = data.action9
										elseif tonumber(ids) == 10 then
											column[groupID] = data.action10
										end
										if column[groupID] == nil or column[groupID] == false or not column[groupID] then
											column[groupID] = 0
										end
										local ids = tostring(ids)
										local tblvalue = "action"..ids
										local newaction = tonumber(column[groupID])+tonumber(xp)
										if newaction then
											exports.DENmysql:exec("UPDATE groupStats SET `??`=? WHERE groupid=?",tblvalue,newaction,groupID)
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end
end

function logGroupAction(plr, logText)
	local id = getGroupID(getElementData(plr, "Group"))
	exports.DENmysql:exec("INSERT INTO samer_groupLogs (groupID, logText) VALUES(?,?)", id, logText)
	local colorString = getGroupColor(getElementData(plr, "Group"))
	local turfColorTable = exports.server:stringExplode(colorString, ",")
	local r, g, b = tonumber(turfColorTable[1]), tonumber(turfColorTable[2]), tonumber(turfColorTable[3])
	for k, v in ipairs(getOnlineGroupMembers(getElementData(plr, "Group"))) do
		outputChatBox(logText, v, r, g, b)
	end
end

function logBankAction(plr, logText)
	local id = getGroupID(getElementData(plr, "Group"))
	exports.DENmysql:exec("INSERT INTO samer_groupTransactions (groupID, logText) VALUES(?,?)", id, logText)
end

function getGroupMotd(groupID)
	if (groupIDToPointer[groupID] and cacheSamerGroupsTbl[groupIDToPointer[groupID]]["motd"] and cacheSamerGroupsTbl[groupIDToPointer[groupID]]["motd"] ~= "") then
		return cacheSamerGroupsTbl[groupIDToPointer[groupID]]["motd"]
	else
		return false
	end
end

function getOnlineGroupMembers(groupName)
	local tab = {}
	for k, v in ipairs(getElementsByType("player")) do
		if (getElementData(v, "Group") == groupName) then
			table.insert(tab, v)
		end
	end
	return tab
end

function setOnLogin()
	local res = exports.DENmysql:query("SELECT * FROM samer_groupmembers WHERE memberAcc=? LIMIT 1", exports.server:getPlayerAccountName(source))
	bindKey(source, "F6", "down", showGroupPanel) 
	if (#res > 0) then
		setElementData(source, "Group ID", res[1]["groupID"])
		setElementData(source, "Group", getGroupName(res[1]["groupID"]))
		setElementData(source, "Group Rank", res[1]["groupRank"])
		exports.DENmysql:exec("UPDATE samer_groupmembers SET memberName=?, lastOnline=? WHERE memberAcc=?", getPlayerName(source), getRealTime().timestamp, exports.server:getPlayerAccountName(source))
		local motd = getGroupMotd(res[1]["groupID"])
		if (motd) then
			outputChatBox("[GROUP MOTD]#ffffff "..motd.."", source, 255, 0, 0, true)
		end
	else
		setElementData(source, "Group", "None")
		setElementData(source, "Group Rank", "None")
	end
end
addEventHandler("onPlayerLogin", root, setOnLogin)

function onQuit()
	if (exports.server:isPlayerLoggedIn(source)) then
		exports.DENmysql:exec("UPDATE samer_groupmembers SET memberName=?, lastOnline=? WHERE memberAcc=?", getPlayerName(source), getRealTime().timestamp, exports.server:getPlayerAccountName(source))
	end
end
addEventHandler("onPlayerQuit", root, onQuit)

function onResourceStop()
    for index, players in ipairs(getElementsByType("player")) do
        unbindKey(players, "F6", "down", showPanel)             
    end
end
addEventHandler("onResourceStop", getResourceRootElement(getThisResource()), onResourceStop)

function createGroup(plr, groupName, returnType)
	local res = exports.DENmysql:query("SELECT * FROM samer_groups WHERE groupName=? LIMIT 1", groupName)
	if (#res > 0) then
		outputChatBox("A group with this name already is in existence. Please choose another name.", plr, 255, 0, 0)
		--Message of an error
	return false end
	local accName = exports.server:getPlayerAccountName(plr)
	exports.DENmysql:exec("INSERT INTO samer_groups (groupName, founderAcc, groupInfo, groupBalance, count, turfR, turfG, turfB, motto, groupLevel, groupExp, groupType, maxSlots) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?)", groupName, accName, " ", 0, 1, 255, 0, 0, " ", 1, 0, returnType, 30)
	local res = exports.DENmysql:query("SELECT id, dateCreated FROM samer_groups WHERE groupName = ?", groupName)	
	local id = res[1].id	
	cacheSamerGroupsTbl[#cacheSamerGroupsTbl + 1] = {id = id, dateCreated = res[1].dateCreated, groupName = groupName, founderAcc = accName, groupInfo = " ", groupBalance = 0, count = 1, turfR = 255, turfG = 0, turfB = 0, motto = " ", groupLevel = 1, groupExp = 0, groupType = returnType, maxSlots = 30}
	groupIDToPointer[id] = #cacheSamerGroupsTbl
	groupNameToPointer[groupName] = #cacheSamerGroupsTbl	
	exports.DENmysql:exec("INSERT INTO samer_groupmembers (groupID, memberAcc, memberName, groupRank, lastOnline, points, warned) VALUES(?,?,?,?,?,?,?)", id, accName, getPlayerName(plr), "Founder", getRealTime().timestamp, 0, 0)
	exports.DENmysql:exec("INSERT INTO samer_groupRanks (groupID, position, rankName, useJob, useSpawners, updateInfo, changeColor, changeMotd, kick, warn, pointsChange, invitePlayers, depositMoney, withdrawMoney, histChecking, changeAvs, buySlots, upgradeGrp, noteAll, blacklistPlayers, expView, changeGroupName, changeGroupType, deleteGroup, setRank) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)", id, -1, "Founder",1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1)
	exports.DENmysql:exec("INSERT INTO samer_groupRanks (groupID, position, rankName, useJob, useSpawners, updateInfo, changeColor, changeMotd, kick, warn, pointsChange, invitePlayers, depositMoney, withdrawMoney, histChecking, changeAvs, buySlots, upgradeGrp, noteAll, blacklistPlayers, expView, changeGroupName, changeGroupType, deleteGroup, setRank) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)", id, 1, "Trial", 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0)
	exports.DENmysql:exec("INSERT INTO samer_groupAvs (groupID, memberAcc, hunter, hydra, rhino, rustler, seasparrow, tank) VALUES(?,?,?,?,?,?,?,?)", id, accName, 1, 1, 1, 1, 1, 1)
	setElementData(plr, "Group", groupName)
	setElementData(plr, "Group ID", id)
	setElementData(plr, "Group Rank", "Founder")
	--exports.AURaccounts:setAccountData(plr, "groupChatStatus", 1)
	groupIDToRanksPointer[id] = {{groupID = id, position = -1, rankName = "Founder", useJob = 1, useSpawners = 1, updateInfo = 1, changeColor = 1, changeMotd = 1, kick = 1, warn = 1, pointsChange = 1, invitePlayers = 1, depositMoney = 1, withdrawMoney = 1, histChecking = 1, changeAvs = 1, buySlots = 1, upgradeGrp = 1, noteAll = 1, blacklistPlayers = 1, expView = 1, changeGroupName = 1, changeGroupType = 1, deleteGroup = 1, setRank = 1}, {groupID = id, position = 1, rankName = "Trial", useJob = 0, useSpawners = 0, updateInfo = 0, changeColor = 0, changeMotd = 0, kick = 0, warn = 0, pointsChange = 0, invitePlayers = 0, depositMoney = 0, withdrawMoney = 0, histChecking = 0, changeAvs = 0, buySlots = 0, upgradeGrp = 0, noteAll = 0, blacklistPlayers = 0, expView = 0, changeGroupName = 0, changeGroupType = 0, deleteGroup = 0, setRank = 0}}
	logGroupAction(plr, ""..getPlayerName(plr).." has created the group!")
end
addEvent("AURgroups.createNewGroup", true)
addEventHandler("AURgroups.createNewGroup", root, createGroup)

function updateRankPermissions(plr, rankName, job, update, color, motd, kick ,warn, points, invite, depo, with, hist, access, slots, upgrd, note, bl, exp, spawn, name, type, del, set)
	local groupID = getElementData(plr, "Group ID")
	logGroupAction(plr, ""..getPlayerName(plr).." has updated permissions for "..rankName..".")
	exports.DENmysql:exec("UPDATE samer_groupRanks SET useJob=?, useSpawners=?, updateInfo=?, changeColor=?, changeMotd=?, kick=?, warn=?, pointsChange=?, invitePlayers=?, depositMoney=?, withdrawMoney=?, histChecking=?, changeAvs=?, buySlots=?, upgradeGrp=?, noteAll=?, blacklistPlayers=?, expView=?, changeGroupName=?, changeGroupType=?, deleteGroup=?, setRank=? WHERE rankName=? AND groupID=?", job, spawn, update, color, motd, kick, warn, points, invite,depo, with, hist, access, slots, upgrd, note, bl, exp, name, type, del, set, rankName, groupID)
	groupIDToRanksPointer = {}
	local cacheSamerGroupRanksTbl = exports.DENmysql:query("SELECT * FROM samer_groupRanks")
	for i, v in pairs(cacheSamerGroupRanksTbl) do
		if (not groupIDToRanksPointer[v.groupID]) then
			groupIDToRanksPointer[v.groupID] = {}
		end
		table.insert(groupIDToRanksPointer[v.groupID], v)
	end
end
addEvent("AURgroups.updateRankPermissions", true)
addEventHandler("AURgroups.updateRankPermissions", root, updateRankPermissions)

function getRankBeforeIndex(groupID, pos)
	local previousRank, rankName = pos, ""
	for i, v in pairs(groupIDToRanksPointer[groupID]) do
		if (v.position > previousRank and v.position > pos) then
			previousRank, rankName = v.position, v.rankName
			break
		end
	end
	if (previousRank == pos) then
		for i, v in pairs(groupIDToRanksPointer[groupID]) do
			if (v.position == (pos - 1)) then
				previousRank, rankName = v.position, v.rankName
				break
			end
		end
	end
	return previousRank, rankName
end

function addNewRank(plr, rankName, job, update, color, motd, kick ,warn, points, invite, depo, with, hist, access, slots, upgrd, note, bl, exp, spawn, name, type, del, set)
	local groupID = getElementData(plr, "Group ID")
	logGroupAction(plr, ""..getPlayerName(plr).." added '"..rankName.."' rank.")
	for i, v in pairs(groupIDToRanksPointer[groupID]) do
		if (v.rankName == rankName) then
			outputChatBox("This rank name already is in existence.", plr, 255, 0, 0)
			return false
		end
	end
	exports.DENmysql:exec("INSERT INTO samer_groupRanks (groupID, rankName, useJob, useSpawners, updateInfo, changeColor, changeMotd, kick, warn, pointsChange, invitePlayers, depositMoney, withdrawMoney, histChecking, changeAvs, buySlots, upgradeGrp, noteAll, blacklistPlayers, expView, changeGroupName, changeGroupType, deleteGroup, setRank) VALUES(?, ?, ?, ?, ?, ?, ? , ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", groupID, rankName, job, spawn, update, color, motd, kick, warn, points, invite,depo, with, hist, access, slots, upgrd, note, bl, exp, name, type, del, set)
	groupIDToRanksPointer = {}
	local cacheSamerGroupRanksTbl = exports.DENmysql:query("SELECT * FROM samer_groupRanks")
	local rowID, rowIDTbl = -1, 0
	for i, v in pairs(cacheSamerGroupRanksTbl) do
		if (not groupIDToRanksPointer[v.groupID]) then
			groupIDToRanksPointer[v.groupID] = {}
		end
		if (v.rankName == rankName) then
			rowID, rowIDTbl = v.id, #groupIDToRanksPointer[v.groupID] + 1
		end
		table.insert(groupIDToRanksPointer[v.groupID], v)
	end
	exports.DENmysql:exec("UPDATE samer_groupRanks SET position = ? WHERE id = ?", #groupIDToRanksPointer[groupID] + 1, rowID)
	groupIDToRanksPointer[groupID][rowIDTbl].position = (#groupIDToRanksPointer[groupID]) + 1
end
addEvent("AURgroups.addNewRank", true)
addEventHandler("AURgroups.addNewRank", root, addNewRank)

function deleteRank(plr, rankName)
	if (rankName == "Founder") then
		outputChatBox("You cannot remove this rank.", plr, 255, 0, 0)
		return false
	end
	local groupID = getElementData(plr, "Group ID")
	logGroupAction(plr, ""..getPlayerName(plr).." deleted '"..rankName.."' rank.")
	local pos = 0
	for i, v in pairs(groupIDToRanksPointer[groupID]) do
		if (v.rankName == rankName) then
			pos = v.position
			table.remove(groupIDToRanksPointer[groupID], i)
			break
		end
	end
	local prevRank, prevRankName = getRankBeforeIndex(groupID, pos)
	if (prevRank == pos) then
		outputChatBox("This rank cannot be removed.", plr, 255, 0, 0)
		return false
	end
	exports.DENmysql:exec("UPDATE samer_groupmembers SET groupRank = ? WHERE groupRank = ? AND groupID = ?", prevRankName, rankName, groupID)
	exports.DENmysql:exec("DELETE FROM samer_groupRanks WHERE groupID=? AND rankName=?", groupID, rankName)
	exports.DENmysql:exec("UPDATE samer_groupRanks SET position = position - 1 WHERE position > ? AND groupID = ?", pos, groupID)
	for i, v in pairs(groupIDToRanksPointer[groupID]) do
		if (v.position > pos) then
			groupIDToRanksPointer[groupID][i].position = groupIDToRanksPointer[groupID][i].position - 1
		end
	end
end
addEvent("AURgroups.deleteRank", true)
addEventHandler("AURgroups.deleteRank", root, deleteRank)

function moveRankUp(rankName, pos)
	local pos = tonumber(pos)
	if (pos == 1 or pos == -1) then
		outputChatBox("Cannot move these ranks up anymore.", client, 255, 0, 0)
		return false
	end
	local plrRank = getElementData(client, "Group Rank")
	local newRankPos, plrRankPos = pos - 1, 0
	for i, v in pairs(groupIDToRanksPointer[groupID]) do
		if (v.rankName == plrRank) then
			plrRankPos = v.position
			break
		end
	end
	if (pos <= plrRankPos) then
		outputChatBox("You cannot move this rank as it is above you or equal to you.", client, 255, 0, 0)
		return false
	end
	local groupID = getElementData(client, "Group ID")
	exports.DENmysql:exec("UPDATE samer_groupRanks SET position = position + 1 WHERE position = ? AND groupID = ?", pos - 1, groupID)
	exports.DENmysql:exec("UPDATE samer_groupRanks SET position = position - 1 WHERE position = ? AND groupID = ? AND rankName = ?", pos, groupID, rankName)
	for i, v in pairs(groupIDToRanksPointer[groupID]) do
		if (v.position == (pos - 1) and v.groupID == groupID) then
			groupIDToRanksPointer[groupID][i].position = groupIDToRanksPointer[groupID][i].position + 1
		elseif (v.position == pos and v.groupID == groupID and v.rankName == rankName) then
			groupIDToRanksPointer[groupID][i].position = groupIDToRanksPointer[groupID][i].position - 1
		end
	end
	logGroupAction(client, ""..getPlayerName(client).." moved up the rank order of '"..rankName.."' ("..tostring(pos)..")")
	outputChatBox("Moved "..rankName.." up the rank order.", client, 0, 255, 0)
end
addEvent("AURgroups.moveRankUp", true)
addEventHandler("AURgroups.moveRankUp", resourceRoot, moveRankUp)
--
function moveRankDown(rankName, pos)
	local pos = tonumber(pos)
	local groupID = getElementData(client, "Group ID")
	if (pos == -1 or pos == #groupIDToRanksPointer[groupID]) then
		outputChatBox("Cannot move these ranks down anymore.", client, 255, 0, 0)
		return false
	end
	local plrRank = getElementData(client, "Group Rank")
	local newRankPos, plrRankPos = pos + 1, 0
	for i, v in pairs(groupIDToRanksPointer[groupID]) do
		if (v.rankName == plrRank) then
			plrRankPos = v.position
			break
		end
	end
	if (pos <= plrRankPos) then
		outputChatBox("You cannot move this rank as it is above you or equal to you.", client, 255, 0, 0)
		return false
	end
	exports.DENmysql:exec("UPDATE samer_groupRanks SET position = position - 1 WHERE position = ? AND groupID = ?", pos + 1, groupID)
	exports.DENmysql:exec("UPDATE samer_groupRanks SET position = position + 1 WHERE position = ? AND groupID = ? AND rankName = ?", pos, groupID, rankName)
	for i, v in pairs(groupIDToRanksPointer[groupID]) do
		if (v.position == (pos + 1) and v.groupID == groupID) then
			groupIDToRanksPointer[groupID][i].position = groupIDToRanksPointer[groupID][i].position - 1
		elseif (v.position == pos and v.groupID == groupID and v.rankName == rankName) then
			groupIDToRanksPointer[groupID][i].position = groupIDToRanksPointer[groupID][i].position + 1
		end
	end
	logGroupAction(client, ""..getPlayerName(client).." moved down the rank order of '"..rankName.."' ("..tostring(pos)..")")
	outputChatBox("Moved "..rankName.." down the rank order.", client, 0, 255, 0)
end
addEvent("AURgroups.moveRankDown", true)
addEventHandler("AURgroups.moveRankDown", resourceRoot, moveRankDown)

function setPlayerRank(plr, accName, oldRank, newRank, reason)
	local groupID = getElementData(plr, "Group ID")
	local playerRank = getElementData(plr, "Group Rank")
	local currentPerms
	local newPerms
	local res = groupIDToRanksPointer[groupID]
	local oldRankPos, newRankPos, plrRankPos = 0, 0, 0
	for k, v in pairs(res) do
		if (v.rankName == oldRank) then
			oldRankPos = v.position
			currentPerms = tonumber( v.useJob ) + tonumber( v.useSpawners ) + tonumber( v.updateInfo ) + tonumber( v.changeColor ) + tonumber( v.changeMotd ) + tonumber( v.kick ) + tonumber( v.warn ) + tonumber( v.pointsChange ) + tonumber( v.invitePlayers ) + tonumber( v.depositMoney ) + tonumber( v.withdrawMoney ) + tonumber( v.histChecking ) + tonumber( v.changeAvs ) + tonumber( v.buySlots ) + tonumber( v.upgradeGrp ) + tonumber( v.noteAll ) + tonumber( v.blacklistPlayers ) + tonumber( v.expView ) + tonumber( v.changeGroupName ) + tonumber( v.changeGroupType ) + tonumber( v.deleteGroup ) + tonumber( v.setRank )
		end
		if (v.rankName == newRank) then
			newRankPos = v.position
			newPerms = tonumber( v.useJob ) + tonumber( v.useSpawners ) + tonumber( v.updateInfo ) + tonumber( v.changeColor ) + tonumber( v.changeMotd ) + tonumber( v.kick ) + tonumber( v.warn ) + tonumber( v.pointsChange ) + tonumber( v.invitePlayers ) + tonumber( v.depositMoney ) + tonumber( v.withdrawMoney ) + tonumber( v.histChecking ) + tonumber( v.changeAvs ) + tonumber( v.buySlots ) + tonumber( v.upgradeGrp ) + tonumber( v.noteAll ) + tonumber( v.blacklistPlayers ) + tonumber( v.expView ) + tonumber( v.changeGroupName ) + tonumber( v.changeGroupType ) + tonumber( v.deleteGroup ) + tonumber( v.setRank )
		end
		if (v.rankName == playerRank) then
			plrRankPos = v.position
		end
	end
	if (oldRankPos > newRankPos and (newRankPos < plrRankPos)) then
		outputChatBox("You cannot promote anyone above you.", plr, 255, 0, 0)
		return false
	end
	if (newRankPos > oldRankPos and (newRankPos <= plrRankPos)) then
		outputChatBox("You cannot demote anyone above you.", plr, 255, 0, 0)
		return false
	end
	--if (newPerms >= currentPerms) then return false end
	logGroupAction(plr, ""..getPlayerName(plr).." changed "..accName.."'s rank from '"..oldRank.."' to '"..newRank.."' (Reason: "..reason..").")
	exports.DENmysql:exec("UPDATE samer_groupmembers SET groupRank=? WHERE memberAcc=? AND groupID=?", newRank, accName, groupID)
	local guy = getPlayerFromAccountName(accName)
	if (guy) then
		setElementData(guy, "Group Rank", newRank)
	end
end
addEvent("AURgroups.setPlayerRank", true)
addEventHandler("AURgroups.setPlayerRank", root, setPlayerRank)

function depositMoney(plr, amount)
	if (getPlayerMoney(plr) < amount) then return false end
	local groupID = getElementData(plr, "Group ID")
	local res = cacheSamerGroupsTbl[groupIDToPointer[groupID]]
	local amount = math.floor(amount)
	if (amount == 0) then return false end
	local oldAmount = tonumber(res["groupBalance"])
	local newAmount = oldAmount + amount
	exports.DENmysql:exec("UPDATE samer_groups SET groupBalance=? WHERE id=?", newAmount, groupID)
	cacheSamerGroupsTbl[groupIDToPointer[groupID]]["groupBalance"] = newAmount
	logGroupAction(plr, ""..getPlayerName(plr).." deposited $"..amount..".")
	logBankAction(plr, ""..getPlayerName(plr).." deposited $"..amount..".")
	takePlayerMoney(plr, amount)
end
addEvent("AURgroups.depositMoney", true)
addEventHandler("AURgroups.depositMoney", root, depositMoney)

function withdrawMoney(plr, amount)
	local groupID = getElementData(plr, "Group ID")
	local res = cacheSamerGroupsTbl[groupIDToPointer[groupID]]
	local amount = math.floor(amount)
	local oldAmount = tonumber(res["groupBalance"])
	local newAmount = oldAmount - amount
	if (newAmount < 0) then return false end
	exports.DENmysql:exec("UPDATE samer_groups SET groupBalance=? WHERE id=?", newAmount, groupID)
	cacheSamerGroupsTbl[groupIDToPointer[groupID]]["groupBalance"] = newAmount
	logGroupAction(plr, ""..getPlayerName(plr).." withdrew $"..amount..".")
	logBankAction(plr, ""..getPlayerName(plr).." withdrew $"..amount..".")
	givePlayerMoney(plr, amount)
end
addEvent("AURgroups.withdrawMoney", true)
addEventHandler("AURgroups.withdrawMoney", root, withdrawMoney)

function inviteThePlayer(plr, invited, accName)
	local groupID = getElementData(plr, "Group ID")
	local name = getElementData(plr, "Group")
	local res = cacheSamerGroupsTbl[groupIDToPointer[groupID]]
	if (res["maxSlots"] < res["count"]) then return false end
	exports.DENmysql:exec("INSERT INTO samer_groupInvitations (invitedAcc, groupName, groupID, invitedBy) VALUES (?,?,?,?)", exports.server:getPlayerAccountName(invited), name, groupID, exports.server:getPlayerAccountName(plr))
	logGroupAction(plr, ""..getPlayerName(plr).." invited "..getPlayerName(invited).." to the group.")
	addInviteLog(name,getPlayerName(invited),exports.server:getPlayerAccountName(invited),getPlayerName(plr),exports.server:getPlayerAccountName(plr))
end
addEvent("AURgroups.inviteThePlayer", true)
addEventHandler("AURgroups.inviteThePlayer", root, inviteThePlayer)

addEvent("onGroupDelete", true)
function delLeaveGroup(plr, action, reason)
	if (action == "Leave Group") then
		local groupID = getElementData(plr, "Group ID")
		logGroupAction(plr, ""..getPlayerName(plr).." has left the group. (Reason: "..reason..").")
		exports.DENmysql:exec("DELETE FROM samer_groupmembers WHERE memberAcc=?", exports.server:getPlayerAccountName(plr))
		exports.DENmysql:exec("DELETE FROM samer_groupAvs WHERE memberAcc=?", exports.server:getPlayerAccountName(plr))
		exports.DENmysql:exec("UPDATE samer_groups SET count=count-1 WHERE id=?", groupID)
		cacheSamerGroupsTbl[groupIDToPointer[groupID]]["count"] = cacheSamerGroupsTbl[groupIDToPointer[groupID]]["count"] - 1
		setElementData(source, "Group", "None")
		setElementData(source, "Group Rank", "None")
		setElementData(source, "Group ID", false)
	elseif (action == "Delete Group") then
		local groupID = getElementData(plr, "Group ID")
		triggerEvent("onGroupDelete", root, getElementData(plr, "Group"))
		logGroupAction(plr, ""..getPlayerName(plr).." has deleted the group. (Reason:"..reason..").")
		exports.DENmysql:exec("DELETE FROM samer_groupAvs WHERE groupID=?", groupID)
		exports.DENmysql:exec("DELETE FROM samer_groupBlacklist WHERE groupname=?", getElementData(plr, "Group"))
		exports.DENmysql:exec("DELETE FROM samer_groupInvitations WHERE groupID=?", groupID)
		exports.DENmysql:exec("DELETE FROM samer_groupLogs WHERE groupID=?", groupID)
		exports.DENmysql:exec("DELETE FROM samer_groupmembers WHERE groupID=?", groupID)
		exports.DENmysql:exec("DELETE FROM samer_groupmembers WHERE groupID=?", groupID)
		exports.DENmysql:exec("DELETE FROM samer_groupRanks WHERE groupID=?", groupID)
		exports.DENmysql:exec("DELETE FROM samer_groups WHERE id=?", groupID)
		cacheSamerGroupsTbl[groupIDToPointer[groupID]] = nil
		groupIDToPointer[groupID] = nil
		groupNameToPointer[getElementData(plr, "Group")] = nil
		groupIDToRanksPointer[groupID] = nil
		exports.DENmysql:exec("DELETE FROM samer_groupTransactions WHERE groupID=?", groupID)
		for k, v in ipairs(getElementsByType("player")) do
			if (getElementData(v, "Group ID") == groupID) then
				setElementData(v, "Group", "None")
				setElementData(v, "Group Rank", "None")
				setElementData(v, "Group ID", false)
				--exports.AURaccounts:setAccountData(plr, "groupChatStatus", nil)
			end
		end
	end
end
addEvent("AURgroups.delLeaveGroup", true)
addEventHandler("AURgroups.delLeaveGroup", root, delLeaveGroup)

function acceptDenyInvitation(plr, string, groupName)
	local res = exports.DENmysql:query("SELECT * FROM groupmanagers_blacklist WHERE blacklistedElement=? AND type=?", getPlayerSerial(plr), 1)
	if (#res > 0) then outputChatBox("SERIAL BLACKLSITED") return false end
	local res = exports.DENmysql:query("SELECT * FROM groupmanagers_blacklist WHERE blacklistedElement=? AND type=?", exports.server:getPlayerAccountName(plr), 2)
	if (#res > 0) then outputChatBox("ACC BLACKLSITED") return false end
	local groupID = getGroupID(groupName)
	local accID = exports.server:getPlayerAccountID(plr)
	local accName = exports.server:getPlayerAccountName(plr)
	if (string == "accept") then
		exports.DENmysql:exec("INSERT INTO samer_groupAvs (groupID, memberAcc, hunter, hydra, rhino, rustler, seasparrow, tank) VALUES(?,?,?,?,?,?,?,?)", groupID, accName, 0, 0, 0, 0, 0, 0)
		exports.DENmysql:exec("DELETE FROM samer_groupInvitations WHERE invitedAcc=?", accName)
		exports.DENmysql:exec("INSERT INTO  samer_groupmembers (groupID, memberAcc, memberName, groupRank, lastOnline, points, warned) VALUES(?,?,?,?,?,?,?)", groupID, accName, getPlayerName(plr), "Trial", getRealTime().timestamp, 0, 0)
		exports.DENmysql:exec("UPDATE samer_groups SET count=count+1 WHERE id=?", groupID)
		cacheSamerGroupsTbl[groupIDToPointer[groupID]]["count"] = cacheSamerGroupsTbl[groupIDToPointer[groupID]]["count"] + 1
		setElementData(plr, "Group", groupName)
		setElementData(plr, "Group Rank", "Trial")
		setElementData(plr, "Group ID", groupID)
		logGroupAction(plr, ""..getPlayerName(plr).." joined the group.")
	end
	if (string == "deny") then
		exports.DENmysql:exec("DELETE FROM samer_groupInvitations WHERE invitedAcc=? AND groupID=?", accName, groupID)
		--logGroupAction(plr, ""..getPlayerName(plr).." has rejected the invitation to join the group.")
	end
end
addEvent("AURgroups.acceptDenyInvitation", true)
addEventHandler("AURgroups.acceptDenyInvitation", root, acceptDenyInvitation)

function updateGroupInfo(plr, text)
	local groupID = getElementData(plr, "Group ID")
	exports.DENmysql:exec("UPDATE samer_groups SET groupInfo=? WHERE id=?", text, groupID)
	cacheSamerGroupsTbl[groupIDToPointer[groupID]]["groupInfo"] = text
	logGroupAction(plr, ""..getPlayerName(plr).." has updated the group information.")
end
addEvent("AURgroups.updateGroupInfo", true)
addEventHandler("AURgroups.updateGroupInfo", root, updateGroupInfo)

function convertAnswerToNum(answer)
	if (answer == "Yes") then
		return 1
	else
		return 0
	end
end

function convertNumToAnswer(num)
	if (num == 1) then
		return "Yes"
	else
		return "No"
	end
end

function changeAvAccess(plr, accName, access, col)
	local groupID = getElementData(plr, "Group ID")
	local convertedAccess = convertAnswerToNum(access)
	if (convertedAccess == 0) then
		newAccess = 1
	else
		newAccess = 0
	end
	if (getPlayerFromName(accName)) then
		avAccName = exports.server:getPlayerAccountName(getPlayerFromName(accName))
	else
		avAccName = accName
	end
	if (col == 2) then
		exports.DENmysql:exec("UPDATE samer_groupAvs SET hunter=? WHERE memberAcc=?", newAccess, avAccName)
		logGroupAction(plr, ""..getPlayerName(plr).." changed "..avAccName.."'s access to Hunter to "..convertNumToAnswer(newAccess)..".")
	end
	if (col == 3) then
		exports.DENmysql:exec("UPDATE samer_groupAvs SET hydra=? WHERE memberAcc=?", newAccess, avAccName)
		logGroupAction(plr, ""..getPlayerName(plr).." changed "..avAccName.."'s access to Hydra to "..convertNumToAnswer(newAccess)..".")
	end
	if (col == 4) then
		exports.DENmysql:exec("UPDATE samer_groupAvs SET rhino=? WHERE memberAcc=?", newAccess, avAccName)
		logGroupAction(plr, ""..getPlayerName(plr).." changed "..avAccName.."'s access to Rhino to "..convertNumToAnswer(newAccess)..".")
	end
	if (col == 5) then
		exports.DENmysql:exec("UPDATE samer_groupAvs SET rustler=? WHERE memberAcc=?", newAccess, avAccName)
		logGroupAction(plr, ""..getPlayerName(plr).." changed "..avAccName.."'s access to Rustler to "..convertNumToAnswer(newAccess)..".")
	end
	if (col == 6) then
		exports.DENmysql:exec("UPDATE samer_groupAvs SET seasparrow=? WHERE memberAcc=?", newAccess, avAccName)
		logGroupAction(plr, ""..getPlayerName(plr).." changed "..avAccName.."'s access to Seasparrow to "..convertNumToAnswer(newAccess)..".")
	end
	if (col == 7) then
		exports.DENmysql:exec("UPDATE samer_groupAvs SET tank=? WHERE memberAcc=?", newAccess, avAccName)
		logGroupAction(plr, ""..getPlayerName(plr).." changed "..avAccName.."'s access to SWAT Tank to "..convertNumToAnswer(newAccess)..".")
	end
end
addEvent("AURgroups.changeAvAccess", true)
addEventHandler("AURgroups.changeAvAccess", root, changeAvAccess)

function buySlotsForGroup(plr)
	local groupID = getElementData(plr, "Group ID")
	local res = cacheSamerGroupsTbl[groupIDToPointer[groupID]]
	local oldAmount = tonumber(res["groupBalance"])
	if (oldAmount < 500000) then return false end
	local newAmount = oldAmount - 500000
	exports.DENmysql:exec("UPDATE samer_groups SET maxSlots=maxSlots+1, groupBalance=? WHERE id=?", newAmount, groupID)
	cacheSamerGroupsTbl[groupIDToPointer[groupID]]["groupBalance"] = newAmount
	cacheSamerGroupsTbl[groupIDToPointer[groupID]]["maxSlots"] = cacheSamerGroupsTbl[groupIDToPointer[groupID]]["maxSlots"] + 1
	logGroupAction(plr, ""..getPlayerName(plr).." has bought an additional group slot.")
end
addEvent("AURgroups.buySlotsForGroup", true)
addEventHandler("AURgroups.buySlotsForGroup", root, buySlotsForGroup)

function setPlayerWarningLevel(plr, newLevel, reason, accName)
	local groupID = getElementData(plr, "Group ID")
	exports.DENmysql:exec("UPDATE samer_groupmembers SET warned=? WHERE groupID=? AND memberAcc=?", newLevel, groupID, accName)
	logGroupAction(plr, ""..getPlayerName(plr).." has changed "..accName.."'s warning level to "..newLevel.."% (Reason: "..reason..")")
end
addEvent("AURgroups.setPlayerWarningLevel", true)
addEventHandler("AURgroups.setPlayerWarningLevel", root, setPlayerWarningLevel)

function setPlayerPoints(plr, accName, pts)
	local groupID = getElementData(plr, "Group ID")
	exports.DENmysql:exec("UPDATE samer_groupmembers SET points=? WHERE groupID=? AND memberAcc=?", pts, groupID, accName)
	logGroupAction(plr, ""..getPlayerName(plr).." has changed "..accName.."'s points to "..pts.."")
end
addEvent("AURgroups.setPlayerPoints", true)
addEventHandler("AURgroups.setPlayerPoints", root, setPlayerPoints)

function setAnotherFounder(plr, accName)
	local groupID = getElementData(plr, "Group ID")
	exports.DENmysql:exec("UPDATE samer_groups SET founderAcc=? WHERE id=?", accName, groupID)
	exports.DENmysql:exec("UPDATE samer_groupmembers SET groupRank=? WHERE memberAcc=?", "Trial", exports.server:getPlayerAccountName(plr))
	exports.DENmysql:exec("UPDATE samer_groupmembers SET groupRank=? WHERE memberAcc=?", "Founder", accName)
	logGroupAction(plr, ""..getPlayerName(plr).." has given the foundership to "..accName.."")
	setElementData(plr, "Group Rank", "Trial")
	cacheSamerGroupsTbl[groupIDToPointer[groupID]]["founderAcc"] = accName
	local guy = getPlayerFromAccountName(accName)
	if (guy) then
		setElementData(guy, "Group Rank", "Founder")
	end
end
addEvent("AURgroups.setAnotherFounder", true)
addEventHandler("AURgroups.setAnotherFounder", root, setAnotherFounder)

function setGroupMotd(plr, motd)
	local groupID = getElementData(plr, "Group ID")
	exports.DENmysql:exec("UPDATE samer_groups SET motd=? WHERE id=?", motd, groupID)
	cacheSamerGroupsTbl[groupIDToPointer[groupID]]["motd"] = motd
	logGroupAction(plr, ""..getPlayerName(plr).." has updated the group MOTD")
end
addEvent("AURgroups.setGroupMotd", true)
addEventHandler("AURgroups.setGroupMotd", root, setGroupMotd)

function noteToEveryone(plr, text)
	local groupID = getElementData(plr, "Group ID")
	for k, v in ipairs(getElementsByType("player")) do
		if (getElementData(v, "Group ID") == groupID) then
			outputChatBox("[GROUP NOTE]#ffffff "..getPlayerName(plr)..": "..text..".", v, 255, 0, 0, true)
		end
	end
end
addEvent("AURgroups.noteToEveryone", true)
addEventHandler("AURgroups.noteToEveryone", root, noteToEveryone)

function changeTheType(plr, returnType)
	local groupID = getElementData(plr, "Group ID")
	exports.DENmysql:exec("UPDATE samer_groups SET groupType=? WHERE id=?", returnType, groupID)
	cacheSamerGroupsTbl[groupIDToPointer[groupID]]["groupType"] = returnType
	logGroupAction(plr, ""..getPlayerName(plr).." has updated the group type to "..returnType.."")
end
addEvent("AURgroups.changeTheType", true)
addEventHandler("AURgroups.changeTheType", root, changeTheType)

function changeTheName(plr, newName)
	local groupID = getElementData(plr, "Group ID")
	if getGroupID(newName) then return false end
	exports.DENmysql:exec("UPDATE samer_groups SET groupName=? WHERE id=?", newName, groupID)
	cacheSamerGroupsTbl = exports.DENmysql:query("SELECT * FROM samer_groups")
	groupIDToPointer = {}
	groupNameToPointer = {}
	for i, v in pairs(cacheSamerGroupsTbl) do
		if (v.id and v.groupName) then
			groupIDToPointer[v.id] = i
			groupNameToPointer[v.groupName] = i
		end
	end
	exports.DENmysql:exec("UPDATE samer_groupInvitations SET groupName=? WHERE groupID=?", newName, groupID)
	for k, v in ipairs(getElementsByType("player")) do
		if (getElementData(v, "Group ID") == groupID) then
			setElementData(v, "Group", newName)
		end
	end
	logGroupAction(plr, ""..getPlayerName(plr).." has updated the group name to "..newName.."")
end
addEvent("AURgroups.changeTheName", true)
addEventHandler("AURgroups.changeTheName", root, changeTheName)

addEvent("onGroupChangeColor", true)
function saveColor(plr, r, g, b)
	local groupID = getElementData(plr, "Group ID")
	exports.DENmysql:exec("UPDATE samer_groups SET turfR=?, turfG=?, turfB=? WHERE id=?", r, g, b, groupID)
	cacheSamerGroupsTbl[groupIDToPointer[groupID]]["turfR"] = r
	cacheSamerGroupsTbl[groupIDToPointer[groupID]]["turfG"] = g
	cacheSamerGroupsTbl[groupIDToPointer[groupID]]["turfB"] = b
	logGroupAction(plr, ""..getPlayerName(plr).." has changed the group color.")
	local colorString = R.."," .. G .. ","..B
	triggerEvent("onGroupChangeColor", root, getElementData(plr, "Group"), colorString)
end
addEvent("AURgroups.saveColor", true)
addEventHandler("AURgroups.saveColor", root, saveColor)

function addPlayerBlacklist(plr, accName, name, reason, blacklistLevelAdded)
	local groupID = getElementData(plr, "Group")
	exports.DENmysql:exec("INSERT INTO samer_groupBlacklist (groupname, blacklistedAcc, blacklistedName, level, reason, blacklistedBy) VALUES(?,?,?,?,?,?)", groupID, accName, name, blacklistLevelAdded, reason, exports.server:getPlayerAccountID(plr))
	logGroupAction(plr, ""..getPlayerName(plr).." has blacklisted "..accName.." for "..reason.."")
end
addEvent("AURgroups.addPlayerBlacklist", true)
addEventHandler("AURgroups.addPlayerBlacklist", root, addPlayerBlacklist)

function removePlayerBlacklist(plr, name)
	local groupID = getElementData(plr, "Group")
	exports.DENmysql:exec("DELETE FROM samer_groupBlacklist WHERE groupname=? AND blacklistedName=?", groupID, name)
	logGroupAction(plr, ""..getPlayerName(plr).." has deleted "..name.."'s blacklist")
end
addEvent("AURgroups.removePlayerBlacklist", true)
addEventHandler("AURgroups.removePlayerBlacklist", root, removePlayerBlacklist)

function getPlayerFromAccountName(theName)
	local lowered = string.lower(tostring(theName))
	for k,v in ipairs (getElementsByType ("player" )) do
		if (getElementData(v, "playerAccount")) and (string.lower(getElementData(v, "playerAccount")) == lowered) then
			return v
		end
	end
end

function kickMember(plr, reason, accName)
	local groupID = getElementData(plr, "Group ID")
	logGroupAction(plr, ""..getPlayerName(plr).." has kicked "..accName..".")
	exports.DENmysql:exec("DELETE FROM samer_groupmembers WHERE memberAcc=?", accName)
	exports.DENmysql:exec("DELETE FROM samer_groupAvs WHERE memberAcc=?", accName)
	exports.DENmysql:exec("UPDATE samer_groups SET count=count-1 WHERE id=?", groupID)
	cacheSamerGroupsTbl[groupIDToPointer[groupID]]["count"] = cacheSamerGroupsTbl[groupIDToPointer[groupID]]["count"] - 1
	if (getPlayerFromAccountName(accName)) then
		local kicked = getPlayerFromAccountName(accName)
		setElementData(kicked, "Group", "None")
		setElementData(kicked, "Group Rank", "None")
		setElementData(kicked, "Group ID", false)
	end
end
addEvent("AURgroups.kickMember", true)
addEventHandler("AURgroups.kickMember", root, kickMember)

function upgradeGrp(plr)
	local playerID = exports.server:getPlayerAccountID( source )
	local groupID = getElementData(plr, "Group ID")
	if groupID then
		local groupData = groupIDToPointer[groupID]
		if groupData then
			local groupData = cacheSamerGroupsTbl[groupIDToPointer[groupID]]
			if groupData.groupExp == nil or groupData.groupExp == false or not groupData.groupExp then groupData.groupExp = 0 end
			local level = groupData.groupLevel
			local level = tonumber(level)
			if level == nil or level == false then level = 0 end
			local grxp = groupData.groupExp
			local grxp = tonumber(grxp)
			if tonumber(level) == 0 then
				if grxp >= 2000 then
					if getPlayerMoney(source) >= 100000 then
						exports.AURpayments:takeMoney(source,100000,"CSGGroups upgrading")
					else
						exports.NGCdxmsg:createNewDxMessage(source,"You don't have enough money to upgrade your group",255,0,0)
						return false
					end
					exports.DENmysql:exec("UPDATE samer_groups SET groupLevel=? WHERE id=?",1,groupID)
					cacheSamerGroupsTbl[groupIDToPointer[groupID]]["groupLevel"] = 1
					exports.NGCdxmsg:createNewDxMessage(source,"Your group has been upgraded to level 1 by 2,000 Exp",255,0,0)
					exports.DENchatsystem:outPutGroupMessageByPlayer( source, getPlayerName( source ).." upgraded the group to level 1" )
				else
					exports.NGCdxmsg:createNewDxMessage(source,"Your group doesn't have enough XP to be upgraded from level "..(level).." to next level "..(level+1).." ("..grxp.."/2000)",255,0,0)
				end
			elseif tonumber(level) == 1 then
				if grxp >= 5000 then
					if getPlayerMoney(source) >= 300000 then
						exports.AURpayments:takeMoney(source,300000,"CSGGroups upgrading")
					else
						exports.NGCdxmsg:createNewDxMessage(source,"You don't have enough money to upgrade your group",255,0,0)
						return false
					end
					exports.DENmysql:exec("UPDATE samer_groups SET groupLevel=? WHERE id=?",2,groupID)
					cacheSamerGroupsTbl[groupIDToPointer[groupID]]["groupLevel"] = 2
					exports.NGCdxmsg:createNewDxMessage(source,"Your group has been upgraded to level 2 by 5,000 Exp",255,0,0)
					exports.DENchatsystem:outPutGroupMessageByPlayer( source, getPlayerName( source ).." upgraded the group to level 2" )
				else
					exports.NGCdxmsg:createNewDxMessage(source,"Your group doesn't have enough XP to be upgraded from level "..(level).." to next level "..(level+1).." ("..grxp.."/5000)",255,0,0)
				end
			elseif tonumber(level) == 2 then
				if grxp >= 9500 then
					if getPlayerMoney(source) >= 500000 then
						exports.AURpayments:takeMoney(source,500000,"CSGGroups upgrading")
					else
						exports.NGCdxmsg:createNewDxMessage(source,"You don't have enough money to upgrade your group",255,0,0)
						return false
					end

					exports.DENmysql:exec("UPDATE samer_groups SET groupLevel=? WHERE id=?",3,groupID)
					cacheSamerGroupsTbl[groupIDToPointer[groupID]]["groupLevel"] = 3
					exports.NGCdxmsg:createNewDxMessage(source,"Your group has been upgraded to level 3 by 9,500 Exp",255,0,0)
					exports.DENchatsystem:outPutGroupMessageByPlayer( source, getPlayerName( source ).." upgraded the group to level 3" )
				else
					exports.NGCdxmsg:createNewDxMessage(source,"Your group doesn't have enough XP to be upgraded from level "..(level).." to next level "..(level+1).." ("..grxp.."/9500)",255,0,0)
				end
			elseif tonumber(level) == 3 then
				if grxp >= 15000 then
					if getPlayerMoney(source) >= 700000 then
						exports.AURpayments:takeMoney(source,700000,"CSGGroups upgrading")
					else
						exports.NGCdxmsg:createNewDxMessage(source,"You don't have enough money to upgrade your group",255,0,0)
						return false
					end

					exports.DENmysql:exec("UPDATE samer_groups SET groupLevel=? WHERE id=?",4,groupID)
					cacheSamerGroupsTbl[groupIDToPointer[groupID]]["groupLevel"] = 4
					exports.NGCdxmsg:createNewDxMessage(source,"Your group has been upgraded to level 4 by 15,000 Exp",255,0,0)
					exports.DENchatsystem:outPutGroupMessageByPlayer( source, getPlayerName( source ).." upgraded the group to level 4" )
				else
					exports.NGCdxmsg:createNewDxMessage(source,"Your group doesn't have enough XP to be upgraded from level "..(level).." to next level "..(level+1).." ("..grxp.."/15000)",255,0,0)
				end
			elseif tonumber(level) == 4 then
				if grxp >= 30000 then
					if getPlayerMoney(source) >= 1000000 then
						exports.AURpayments:takeMoney(source,1000000,"CSGGroups upgrading")
					else
						exports.NGCdxmsg:createNewDxMessage(source,"You don't have enough money to upgrade your group",255,0,0)
						return false
					end

					exports.DENmysql:exec("UPDATE samer_groups SET groupLevel=? WHERE id=?",5,groupID)
					cacheSamerGroupsTbl[groupIDToPointer[groupID]]["groupLevel"] = 5
					exports.NGCdxmsg:createNewDxMessage(source,"Your group has been upgraded to level 5 by 30,000 Exp",255,0,0)
					exports.DENchatsystem:outPutGroupMessageByPlayer( source, getPlayerName( source ).." upgraded the group to level 5" )
				else
					exports.NGCdxmsg:createNewDxMessage(source,"Your group doesn't have enough XP to be upgraded from level "..(level).." to next level "..(level+1).." ("..grxp.."/30000)",255,0,0)
				end
			elseif tonumber(level) == 5 then
				exports.NGCdxmsg:createNewDxMessage(source,"Your group have reached the maximum level",255,0,0)
			else
				exports.NGCdxmsg:createNewDxMessage(source,"Try again later",255,0,0)
			end
		end
	end
end
addEvent("AURgroups.upgradeGroup", true)
addEventHandler("AURgroups.upgradeGroup", root, upgradeGrp)