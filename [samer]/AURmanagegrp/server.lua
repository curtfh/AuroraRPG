addEvent("AURmanagegrp.sendData", true)
addEventHandler("AURmanagegrp.sendData", root, function()
	local query = exports.DENmysql:query("SELECT id, groupName, founderAcc FROM samer_groups")
	triggerClientEvent(client, "AURmanagegrp.retrieveData", client, query)
end)

addEvent("AURmanagegrp.sendRanks", true)
addEventHandler("AURmanagegrp.sendRanks", root, function(id)
	local query = exports.DENmysql:query("SELECT groupID, rankName FROM samer_groupRanks WHERE groupID=?", id)
	triggerClientEvent(client, "AURmanagegrp.retrieveRanks", client, query)
end)

addCommandHandler("manage_groups", function(plr)
	if (exports.CSGstaff:getPlayerAdminLevel(plr) < 4) then return false end
	triggerClientEvent(plr, "AURmanagegrp.showPanel", plr)
end)

addEvent("AURmanagegrp.deleteGroup", true)
addEventHandler("AURmanagegrp.deleteGroup", root, function(groupID, name)
	triggerEvent("onGroupDelete", root, name)
	exports.DENmysql:exec("DELETE FROM samer_groupAvs WHERE groupID=?", groupID)
	exports.DENmysql:exec("DELETE FROM samer_groupBlacklist WHERE groupname=?", name)
	exports.DENmysql:exec("DELETE FROM samer_groupInvitations WHERE groupID=?", groupID)
	exports.DENmysql:exec("DELETE FROM samer_groupLogs WHERE groupID=?", groupID)
	exports.DENmysql:exec("DELETE FROM samer_groupmembers WHERE groupID=?", groupID)
	exports.DENmysql:exec("DELETE FROM samer_groupmembers WHERE groupID=?", groupID)
	exports.DENmysql:exec("DELETE FROM samer_groupRanks WHERE groupID=?", groupID)
	exports.DENmysql:exec("DELETE FROM samer_groups WHERE id=?", groupID)
	exports.DENmysql:exec("DELETE FROM samer_groupTransactions WHERE groupID=?", groupID)
	for k, v in ipairs(getElementsByType("player")) do
		if (getElementData(v, "Group ID") == groupID) then
			outputChatBox("Your group has been deleted by group manager "..getPlayerName(client), v, 255, 0, 0)
			setElementData(v, "Group", "None")
			setElementData(v, "Group Rank", "None")
			setElementData(v, "Group ID", false)
		end
	end
end)

addEvent("AURmanagegrp.joinGroup", true)
addEventHandler("AURmanagegrp.joinGroup", root, function(groupID, name, rank)
	local accName = exports.server:getPlayerAccountName(client)
	exports.DENmysql:exec("INSERT INTO samer_groupAvs (groupID, memberAcc, hunter, hydra, rhino, rustler, seasparrow, tank) VALUES(?,?,?,?,?,?,?,?)", groupID, accName, 0, 0, 0, 0, 0, 0)
	exports.DENmysql:exec("INSERT INTO samer_groupmembers (groupID, memberAcc, memberName, groupRank, lastOnline, points, warned) VALUES(?,?,?,?,?,?,?)", groupID, accName, getPlayerName(client), rank, getRealTime().timestamp, 0, 0)
	exports.DENmysql:exec("UPDATE samer_groups SET count=count+1 WHERE id=?", groupID)
	setElementData(client, "Group", name)
	setElementData(client, "Group Rank", rank)
	setElementData(client, "Group ID", groupID)
	if (rank == "Founder") then
		local founder = exports.DENmysql:querySingle("SELECT founderAcc FROM samer_groups WHERE id=?", groupID)
		exports.DENmysql:exec("UPDATE samer_groupmembers SET groupRank=? WHERE memberAcc=?", "Trial", founder["founderAcc"])
		exports.DENmysql:exec("UPDATE samer_groups SET founderAcc=? WHERE id=?", accName, groupID)
	end
end)