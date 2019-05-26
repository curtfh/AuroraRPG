
function resourceStart ()
	--exports.DENmysql:exec("CREATE TABLE IF NOT EXISTS  Business  ( `Business_name` TEXT(225) NOT NULL , `Business_leader` TEXT(225) NOT NULL , `Business_date` TEXT(225) NOT NULL , `Business_bank` VARCHAR(225) NOT NULL , `Business_info` TEXT(225) NOT NULL , `businessID` INT(225) NOT NULL AUTO_INCREMENT , PRIMARY KEY (`businessID`))")
	--exports.DENmysql:exec("CREATE TABLE IF NOT EXISTS  Business_ranks  ( `Business_name` TEXT(225) NOT NULL , `rank_name` TEXT(225) NOT NULL , `rank_powers` TEXT(225) NOT NULL)")
	--exports.DENmysql:exec("CREATE TABLE IF NOT EXISTS  Business_messages ( `Business_name` TEXT(225) NOT NULL , `message` TEXT(225) NOT NULL )")
	--exports.DENmysql:exec("CREATE TABLE IF NOT EXISTS  Business_log ( `Business_name` TEXT(225) NOT NULL , `log_message` TEXT(225) NOT NULL )")
	---exports.DENmysql:exec("CREATE TABLE IF NOT EXISTS  Business_invites ( `Business_name` TEXT(225) NOT NULL , `memberid` VARCHAR(225) NOT NULL , `invitedby` TEXT(225) NOT NULL )")
---	exports.DENmysql:exec("CREATE TABLE IF NOT EXISTS  Business_transactions ( `Business_name` TEXT(225) NOT NULL , `memberid` VARCHAR(225) NOT NULL , `transaction` TEXT(225) NOT NULL )")
	--exports.DENmysql:exec("CREATE TABLE IF NOT EXISTS  Business_members ( `Business_name` TEXT(225) NOT NULL ,`member_account` TEXT(225) NOT NULL ,`member_rank` TEXT(225) NOT NULL ,`added_by` TEXT(225) NOT NULL ,`added_on` TEXT(225) NOT NULL ,`member_status` TEXT(225) NOT NULL )")

	for index, player in pairs(getElementsByType("player")) do
		local accountName = exports.server:getPlayerAccountName(player)
		local BusinessName = getPlayerBusiness(accountName)
		if BusinessName ~= "None" or BusinessName ~= "none" then
			local rank = getMemberRank(accountName, BusinessName)
			if rank then
				setElementData(player,"Business rank",rank)
				setElementData(player,"Business",BusinessName)
			end
		else
			setElementData(player,"Business rank","None")
			setElementData(player,"Business","None")
		end
	end
end
addEventHandler("onResourceStart", resourceRoot, resourceStart)


function createNewBusiness(BusinessName, BusinessLeader)
	if BusinessName ~= "none" or BusinessName ~= "None" then
		if not doesBusinessExists(BusinessName) then
			local cDate, cTime = getCurrentDateAndTime()
			local theDate = tostring(cDate) .." - ".. tostring(cTime)
			exports.DENmysql:exec("INSERT INTO Business SET Business_name=?,Business_leader=?,Business_date=?,Business_bank=?,Business_info=?",tostring(BusinessName),tostring(BusinessLeader),theDate,0,"")

			return true
		else
			return false
		end
	else
		exports.NGCdxmsg:createNewDxMessage(source,"You can't use this name!",255,0,0)
		return false
	end
end



function removeBusinessFromDatabase(BusinessName)
	if doesBusinessExists(BusinessName) then
		if exports.DENmysql:exec("DELETE FROM Business WHERE Business_name=?",tostring(BusinessName)) then
			exports.DENmysql:exec("DELETE FROM Business_transactions WHERE Business_name=?",tostring(BusinessName))
			exports.DENmysql:exec("DELETE FROM Business_invites WHERE Business_name=?",tostring(BusinessName))
			exports.DENmysql:exec("DELETE FROM Business_members WHERE Business_name=?",tostring(BusinessName))
			exports.DENmysql:exec("DELETE FROM Business_log WHERE Business_name=?",tostring(BusinessName))
			exports.DENmysql:exec("DELETE FROM Business_messages WHERE Business_name=?",tostring(BusinessName))
			exports.DENmysql:exec("DELETE FROM Business_ranks WHERE Business_name=?",tostring(BusinessName))
			return true
		else
			return false
		end
	else
		return false
	end
end

function doesBusinessExists(BusinessName)

	local check = exports.DENmysql:querySingle("SELECT * FROM Business WHERE Business_name=?",tostring(BusinessName))
	if not check then
		return false
	else
		return true
	end
end

function getBusinessList()
	local data = exports.DENmysql:query("SELECT * FROM Business")
	return data
end

function getBusinessMembers(BusinessName)

	local data = exports.DENmysql:query("SELECT * FROM Business_members WHERE Business_name=?",tostring(BusinessName))
	return data
end


function addMemberToBusiness(BusinessName, memberAccount, memberRank, addedBy)
	local check = exports.DENmysql:query ("SELECT * FROM Business_members WHERE Business_name =? AND member_account=?",tostring(BusinessName),tostring(memberAccount) )
		if ( type( check ) == "table" and #check == 0 ) or not check then
			local cDate, cTime = getCurrentDateAndTime()
			local theDate = tostring(cDate) .." - ".. tostring(cTime)

			exports.DENmysql:exec("INSERT INTO Business_members SET Business_name=?,member_account=?,member_rank=?,added_by=?,added_on=?,member_status=?",tostring(BusinessName),tostring(memberAccount), tostring(memberRank),tostring(addedBy),theDate,"Online" )

		return true
	else
		return false
	end
end

function removeMemberFromBusiness(BusinessName, memberAccount, kickerName)
	if exports.DENmysql:exec("DELETE FROM Business_members WHERE member_account=? AND Business_name=?",tostring(memberAccount),tostring(BusinessName)) then
		for k,v in ipairs(getElementsByType("player")) do
			if memberAccount == exports.server:getPlayerAccountName(v) then
				if kickerName then
					exports.NGCdxmsg:createNewDxMessage(v," You have been kicked from ".. tostring(BusinessName) .." by ".. tostring(kickerName) ..".",255,0,0)
				else
					exports.NGCdxmsg:createNewDxMessage(v," you left ".. tostring(BusinessName) .." business.",255,255,0)
				end
			end
		end

		return true
	else
		return false
	end
end

function addRankToBusiness(BusinessName, rankName, rankDetails)
	local check = exports.DENmysql:query ( "SELECT * FROM Business_ranks WHERE Business_name=? AND rank_name =?",tostring(BusinessName),tostring(rankName))
		if ( type( check ) == "table" and #check == 0 ) or not check then
			exports.DENmysql:exec( "INSERT INTO Business_ranks SET Business_name=?,rank_name=?,rank_powers=?",tostring(BusinessName),tostring(rankName),tostring(rankDetails))

		return true
	else
		return false
	end
end

function updateRankFromBusiness(BusinessName, rankName, rankDetails)
	local check = exports.DENmysql:query("SELECT * FROM Business_ranks WHERE rank_name=? AND Business_name =?",tostring(rankName),tostring(BusinessName))
		if not ( type( check ) == "table" and #check == 0 ) or check then
		if exports.DENmysql:exec("UPDATE Business_ranks SET rank_powers=? WHERE rank_name =? AND Business_name=? ",tostring(rankDetails),tostring(rankName),tostring(BusinessName)) then
			return true
		else
			return false
		end
	end
end

function getBusinessPresident(BusinessName)
	if doesBusinessExists(BusinessName) then
		local data = exports.DENmysql:querySingle("SELECT * FROM Business WHERE Business_name=?",tostring(BusinessName))
		if data then
			return tostring(data.Business_leader)
		else
			return false
		end
	end
end

function getBusinessBank(BusinessName)
	if doesBusinessExists(BusinessName) then
		local data = exports.DENmysql:querySingle("SELECT Business_bank FROM Business WHERE Business_name=?",tostring(BusinessName))
		return tonumber(data.Business_bank)
	end
end

function updateBusinessBank(BusinessName, newBalance)
	if not doesBusinessExists(BusinessName) then return false end
	if exports.DENmysql:exec("UPDATE Business SET Business_bank=? WHERE Business_name=?",tostring(newBalance),tostring(BusinessName)) then
		return true
	else
		return false
	end
end
--[[
addCommandHandler("delBusiness",function(player,cmd,ty)
	local BusinessName = ty
	if doesBusinessExists(BusinessName) then
		exports.DENmysql:exec("DELETE FROM Business_transactions WHERE Business_name=?",tostring(BusinessName))
		exports.DENmysql:exec("DELETE FROM Business_invites WHERE Business_name=?",tostring(BusinessName))
		exports.DENmysql:exec("DELETE FROM Business_members WHERE Business_name=?",tostring(BusinessName))
		exports.DENmysql:exec("DELETE FROM Business_log WHERE Business_name=?",tostring(BusinessName))
		exports.DENmysql:exec("DELETE FROM Business_messages WHERE Business_name=?",tostring(BusinessName))
		exports.DENmysql:exec("DELETE FROM Business_ranks WHERE Business_name=?",tostring(BusinessName))
		exports.DENmysql:exec("DELETE FROM Business WHERE Business_name=?",tostring(BusinessName))
	end
end)]]


function setPlayerBusinessRank(memberAccount, BusinessName, newRank)
	local check = exports.DENmysql:query ( "SELECT * FROM Business_members WHERE member_account=? AND Business_name=?",tostring(memberAccount),tostring(BusinessName))
	exports.DENmysql:exec("UPDATE Business_members SET member_rank=? WHERE member_account=? AND Business_name =?",newRank,memberAccount,BusinessName)

end

function getMemberRank(memberAccount, BusinessName)
	if memberAccount and BusinessName then
		if BusinessName ~= "None" or BusinessName ~= "none" then
			local data = exports.DENmysql:querySingle("SELECT member_rank FROM Business_members WHERE Business_name=? AND member_account=?",tostring(BusinessName),tostring(memberAccount))
			if data then
				return tostring(data.member_rank)
			else
				return "None"
			end
		else
			return "None"
		end
	else
		return "None"
	end
end

function isPlayerInBusiness(memberAccount)
	local check = exports.DENmysql:query("SELECT * FROM Business_members WHERE member_account=?",tostring(memberAccount))
		if ( type( check ) == "table" and #check == 0 ) or not check then
		return false
	else
		return true
	end
end

function getPlayerBusiness(memberAccount)
	local check = exports.DENmysql:querySingle("SELECT * FROM Business_members WHERE member_account=?",tostring(memberAccount) )
	if check then
		return check.Business_name
	else
		return "None"
	end
end


function addLog(BusinessName, theMessage)
	if doesBusinessExists(BusinessName) then
		addprimebusLog("["..BusinessName.."] : "..theMessage)
			exports.DENmysql:exec( " INSERT INTO Business_log SET Business_name=?,log_message=?",tostring(BusinessName),tostring(theMessage))
		return true
	else
		return false
	end
end


function addTask(BusinessName, theMessage)
	if doesBusinessExists(BusinessName) then
			exports.DENmysql:exec ( " INSERT INTO Business_messages SET Business_name =?,message=? ", tostring(BusinessName),tostring(theMessage)  )
		return true
	else
		return false
	end
end

function removeTask(BusinessName, theMessage)
	if doesBusinessExists(BusinessName) then
		local s = exports.DENmysql:query("SELECT * FROM Business_messages WHERE Business_name=?",tostring(BusinessName))
		for i=1,#s do
			info = split(s[i]["message"],string.byte(","))
			if tostring(info[2]) == tostring(theMessage) then
				if exports.DENmysql:exec ( "DELETE FROM Business_messages WHERE Business_name =? and message=?", tostring(BusinessName),s[i]["message"]) then

					return true
				end
			end
		end
	else
		return false
	end
end


function getBusinessRankList(BusinessName)
	local data = exports.DENmysql:query("SELECT * FROM Business_ranks WHERE Business_name=?",tostring(BusinessName))
	return data
end

function getBusinessInfo(BusinessName)
	local data = exports.DENmysql:query("SELECT * FROM Business WHERE Business_name=?",tostring(BusinessName))
	return data
end

function aclAllowed(BusinessName, rankName, action)
	local data = exports.DENmysql:querySingle("SELECT rank_powers FROM Business_ranks WHERE rank_name=? AND Business_name=?",tostring(rankName),tostring(BusinessName))
	if data then
		local info = split(data.rank_powers,string.byte(","))
		for i,v in pairs(info) do
			if rank_names[i] == tostring(action) then
				return toboolean(info[i])
			end
		end
	end
return false
end


function getBusinessLog(BusinessName)
	local data = exports.DENmysql:query("SELECT * FROM Business_log WHERE Business_name=?",tostring(BusinessName))
	if data then
		return data
	end
end

function getBusinessTasks(BusinessName)
	local data = exports.DENmysql:query("SELECT * FROM Business_messages WHERE Business_name=?",tostring(BusinessName))
	if data then
		return data
	end
end

function clearBusinessLog(BusinessName)
	local dat = exports.DENmysql:query("SELECT * FROM Business_log WHERE Business_name=?",tostring(BusinessName))
	if dat then
		outputDebugString("Business log found")
		exports.DENmysql:exec("DELETE FROM Business_log WHERE Business_name=?",tostring(BusinessName))
	end
end

function getPlayersByBusiness(BusinessName)
	local theTable = {}
	for index, player in pairs(getElementsByType("player")) do
		if getElementData(player,"Business") == tostring(BusinessName) then
		table.insert(theTable, player)
		end
	end
	return theTable
end


function updateMemberStatus(memberAccount, BusinessName, newStatus)
	if BusinessName and memberAccount and newStatus then
		local check = exports.DENmysql:querySingle("SELECT * FROM Business_members WHERE member_account=? AND Business_name=?",tostring(memberAccount),tostring(BusinessName))
		if check then
			if check.member_account == memberAccount then
				if exports.DENmysql:exec("UPDATE Business_members SET member_status=? WHERE member_account=? AND Business_name=?",tostring(newStatus),tostring(memberAccount),tostring(BusinessName)) then
					return true
				else
					return false
				end
			end
		end
	end
end

function removeRankFromBusiness(BusinessName, rankName)
	if exports.DENmysql:exec("DELETE FROM Business_ranks WHERE Business_name=? AND rank_name =?",tostring(BusinessName),tostring(rankName)) then
		local lo = exports.DENmysql:querySingle("SELECT * FROM Business_members WHERE Business_name=? AND member_rank =?",tostring(BusinessName),tostring(rankName))
		if lo then
			for index, member in pairs(lo) do
				exports.DENmysql:exec("UPDATE Business_members SET member_rank =? WHERE member_account=? AND Business_name =?","None",member.member_account,tostring(BusinessName))
			end
		end
		return true
	else
		return false
	end
end

function businessMsg(bn,msg,r,g,b)
	for index, player in pairs(getPlayersByBusiness(bn)) do
		outputChatBox("[Business]: "..msg,player,r or 255,g or 255,b or 0)
	end
end

function getCurrentDateAndTime()
	local realTime = getRealTime()
    local cDate = string.format("%04d/%02d/%02d", realTime.year + 1900, realTime.month + 1, realTime.monthday )
    local cTime = string.format("%02d:%02d", realTime.hour, realTime.minute )
	return cDate, cTime
end

function toboolean(string)
	if string == "true" then
		return true
	elseif string == "false" then
		return false
	end
end

rank_names = {
	[1] = "kick",
	[2] = "invite",
	[3] = "log",
	[4] = "setrank",
	[5] = "rankManage",
	[6] = "withdraw",
	[7] = "cleanBusinessLog",
	[8] = "delrank",
	[9] = "addrank",
	[10] =  "assign",
	[11] =  "delBusiness",
	[12] =  "accesspanel",
}

addEvent("getPlayerData",true)
addEventHandler("getPlayerData",root,
function (client, thePlayer)
	if thePlayer then
		local job = getTeamName(getPlayerTeam(thePlayer)), getElementData(thePlayer,"Occupation")
		local Business = getElementData(thePlayer,"Business")
		local wanted = getPlayerWantedLevel(thePlayer)
		triggerClientEvent(client,"returnPlayerData",client,Business,job,wanted)
	end
end)


addEvent("saveBusinessInfo",true)
addEventHandler("saveBusinessInfo",root,function(info)
	if info then
		local accountName = exports.server:getPlayerAccountName(source)
		local BusinessName = getPlayerBusiness(accountName)
		exports.DENmysql:exec("UPDATE Business SET Business_info=? WHERE Business_name=?",info,BusinessName)
		exports.NGCdxmsg:createNewDxMessage(source,"You have successfully update the info",0,255,0)
		addLog(BusinessName,getPlayerName(source).." has updated the info")
		businessMsg(BusinessName,getPlayerName(source).." has updated business info",255,255,0)
	end
end)

addEvent("createBusiness",true)
addEventHandler("createBusiness",root,
function (client, BusinessName)
	local can,msg = exports.NGCmanagement:isPlayerLagging(source)
	if can then
		if getPlayerMoney(source) >= 250000 then
			local accountName = exports.server:getPlayerAccountName(client)
			if string.find(BusinessName, "'") then exports.NGCdxmsg:createNewDxMessage(client,"You can't use the multi quote character.",255,0,0) return end
			if isPlayerInBusiness(accountName) then exports.NGCdxmsg:createNewDxMessage(client,"You can't create a Business as you are already in one.",255,0,0) return end
			if createNewBusiness(BusinessName, accountName) then
				exports.AURpayments:takeMoney(client,250000,"AURbusiness create bus")
				exports.NGCdxmsg:createNewDxMessage(client,"The Business was successfully created.",0,255,0)
				addMemberToBusiness(BusinessName, accountName, "President", "System")
				setElementData(client,"Business",tostring(BusinessName))
				setElementData(client,"Business rank","President")
				local powersString = ""
				local powersString2 = ""
				for i,v in pairs(rank_names) do
					powersString = powersString .. ",true"
				end
				for i,v in pairs(rank_names) do
					powersString2 = powersString2 .. ",false"
				end
				addRankToBusiness(BusinessName, "President", powersString)
				addRankToBusiness(BusinessName, "Worker", powersString2)
			else
				exports.NGCdxmsg:createNewDxMessage(client,"A Business with this name already exists.",255,0,0)
			end
		else
			exports.NGCdxmsg:createNewDxMessage(source,"You don't have enough money to create business",255,0,0)
		end
	else
		exports.NGCdxmsg:createNewDxMessage(source,msg,255,0,0)
	end
end)

addEventHandler("onServerPlayerLogin",root,
function ()
	local accountName = exports.server:getPlayerAccountName(source)
	local BusinessName = getPlayerBusiness(accountName)
	if BusinessName then
		setElementData(source,"Business",BusinessName or "None")
		if BusinessName ~= "None" then
			updateMemberStatus(accountName, BusinessName, "Online")
			setElementData(source,"Business rank",getMemberRank(accountName, BusinessName))
		else
			setElementData(source,"Business rank","None")
		end
	else
		setElementData(source,"Business rank","None")
	end
end)

function updateStatus()
	local accountName = exports.server:getPlayerAccountName(source)
	updateMemberStatus(accountName, getPlayerBusiness(accountName), "Offline")
	setElementData(source,"Business","None")
end
addEventHandler("onPlayerQuit",root,updateStatus)

addEvent("getBusinessInfo",true)
addEventHandler("getBusinessInfo",root,
function ()
	local accountName = exports.server:getPlayerAccountName(source)
	local BusinessName = getPlayerBusiness(accountName)
	local businessInfo = getBusinessInfo(BusinessName)
	if businessInfo then
		triggerClientEvent(source,"returnBusinessInfo",source,businessInfo)
	end
end)

addEvent("queryPanel",true)
addEventHandler("queryPanel",root,function()
	local accountName = exports.server:getPlayerAccountName(source)
	local BusinessName = getPlayerBusiness(accountName)
	local rankName = getMemberRank(accountName, BusinessName)
	invite,kick,logshow,setrank,rankManage,withdraw,cleanBusinessLog,delrank,delBusiness,addrank,assigntask,accesspanel = false,false,false,false,false,false,false,false,false,false,false,false
	if aclAllowed(BusinessName, rankName, "invite") then
		invite = true
	end
	if aclAllowed(BusinessName, rankName, "kick") then
		kick = true
	end
	if aclAllowed(BusinessName, rankName, "log") then
		logshow = true
	end
	if aclAllowed(BusinessName, rankName, "setrank") then
		setrank = true
	end
	if aclAllowed(BusinessName, rankName, "rankManage") then
		rankManage = true
	end
	if aclAllowed(BusinessName, rankName, "withdraw") then
		withdraw = true
	end
	if aclAllowed(BusinessName, rankName, "cleanBusinessLog") then
		cleanBusinessLog = true
	end
	if aclAllowed(BusinessName, rankName, "delrank") then
		delrank = true
	end
	if aclAllowed(BusinessName, rankName, "delBusiness") then
		delBusiness = true
	end
	if aclAllowed(BusinessName, rankName, "addrank") then
		addrank = true
	end
	if aclAllowed(BusinessName, rankName, "assign") then
		assigntask = true
	end
	if aclAllowed(BusinessName, rankName, "accesspanel") then
		accesspanel = true
	end
	triggerClientEvent(source,"returnQuery",source,invite,kick,logshow,setrank,rankManage,withdraw,cleanBusinessLog,delrank,delBusiness,addrank,assigntask,accesspanel)
end)

addEvent("getBusinessList",true)
addEventHandler("getBusinessList",root,
function (client)
	local BusinessList = getBusinessList()
	triggerClientEvent(source,"returnBusinessList",source,BusinessList)
end)

addEvent("getBusinessPayment",true)
addEventHandler("getBusinessPayment",root,
function (client)
	local BusinessList = getBusinessList()
	local tbl = {}
	if BusinessList then
		for index, Business in ipairs(BusinessList) do
			local balance = getBusinessBank(Business["Business_name"])
			table.insert(tbl,{balance,Business["Business_name"]})
		end
	end
	triggerClientEvent(source,"returnBusinessPayment",source,tbl)
end)

addEvent("getInvites",true)
addEventHandler("getInvites",root,function(client)
	local playerID = exports.server:getPlayerAccountID( source )
	local invitesTable = exports.DENmysql:query( "SELECT * FROM Business_invites WHERE memberid=?", playerID )
	triggerClientEvent(client,"returnInvites",client,invitesTable)
end)

addEvent("invitePlayer",true)
addEventHandler("invitePlayer",root,
function (client, thePlayer)
	if thePlayer and isElement(thePlayer) then
		local accountName = exports.server:getPlayerAccountName(client)
		local playerID = exports.server:getPlayerAccountID( thePlayer )
		local BusinessName = getPlayerBusiness(accountName)
		if getPlayerBusiness(exports.server:getPlayerAccountName(thePlayer)) ~= "None" then
			exports.NGCdxmsg:createNewDxMessage(client,"This player is already in a Business.",255,0,0)
		return end
		local rankName = getMemberRank(accountName, BusinessName)
		if not aclAllowed(BusinessName, rankName, "invite") then exports.NGCdxmsg:createNewDxMessage(client,"You don't have access to this function.",255,0,0) return end
		if #getBusinessMembers(BusinessName) >= 25 then exports.NGCdxmsg:createNewDxMessage(client, "You can't invite more members, max is 25.",255,0,0) return end
		local BusinessInvite = exports.DENmysql:querySingle( "SELECT * FROM Business_invites WHERE memberid=? AND Business_name=? LIMIT 1", playerID, BusinessName )
		if ( BusinessInvite ) then
			exports.NGCdxmsg:createNewDxMessage( source, "This player is already invited for your business!", 0, 225, 0 )
			return
		end
		addLog(BusinessName, getPlayerName( source ).." has invited "..getPlayerName(thePlayer))
		exports.DENmysql:exec( "INSERT INTO Business_invites SET Business_name=?, memberid=?, invitedby=?" ,BusinessName, playerID,getPlayerName( source ) )
		exports.NGCdxmsg:createNewDxMessage(client,"You have invited ".. getPlayerName(thePlayer) .." to the Business",0,255,0)
		exports.NGCdxmsg:createNewDxMessage(thePlayer,"You have been invited to join ".. tostring(BusinessName) .." by ".. getPlayerName(client) ..".",0,255,0)
		businessMsg(BusinessName, getPlayerName( source ).." has invited "..getPlayerName(thePlayer),255,255,0)
	end
end)

addEvent("acceptInvite",true)
addEventHandler("acceptInvite",root,function(thePlayer,BusinessName)
	local playerID = exports.server:getPlayerAccountID( source )
	local playerAccount = exports.server:getPlayerAccountName ( source )
	local BusinessTable = exports.DENmysql:querySingle( "SELECT * FROM Business WHERE Business_name=? LIMIT 1", BusinessName )
	local invitesTable = exports.DENmysql:querySingle( "SELECT * FROM Business_invites WHERE memberid=? AND Business_name=? LIMIT 1",playerID,BusinessName)
	if ( BusinessTable ) then
		exports.DENmysql:exec( "DELETE FROM Business_invites WHERE memberid=?", playerID )
		addLog(BusinessName, getPlayerName( source ).." has accepted the invite and joined the business")
		setElementData(thePlayer,"Business",tostring(BusinessName))
		setElementData(thePlayer,"Business rank","Worker")
		addMemberToBusiness(BusinessName, exports.server:getPlayerAccountName(thePlayer), "Worker",invitesTable.invitedby)
		businessMsg(BusinessName,getPlayerName(thePlayer) .." has joined the Business!",255,255,0)
	end
end)

addEvent("declineInvite",true)
addEventHandler("declineInvite",root,function(thePlayer,BusinessName)
	local playerID = exports.server:getPlayerAccountID( source )
	exports.DENmysql:exec( "DELETE FROM Business_invites WHERE Business_name=? AND memberid=?", BusinessName, playerID )
	addLog(BusinessName,getPlayerName(source).." declined the business invite.")
end)



addEvent("giveBusinessPlayer",true)
addEventHandler("giveBusinessPlayer",root,function(player)
	local accountName = exports.server:getPlayerAccountName(source)
	local targetName = exports.server:getPlayerAccountName(player)
	local BusinessName = getPlayerBusiness(accountName)
	if player == source then
		exports.NGCdxmsg:createNewDxMessage(source,"You can't set yourself as President",255,0,0)
		return
	end
	if targetName and accountName and BusinessName then
		if getBusinessPresident(BusinessName) == tostring(accountName) then
			setElementData(source, "Business rank", "Vice President")
			setElementData(player, "Business rank", "President")
			addLog(BusinessName,getPlayerName(source).." has gave President level to "..getPlayerName(player))
			exports.DENmysql:exec("UPDATE Business SET Business_leader=?",targetName)
			exports.NGCdxmsg:createNewDxMessage(source,"You have gave President to "..getPlayerName(player),0,255,0)
			businessMsg(BusinessName,getPlayerName(source).." gave the President of this business to "..getPlayerName(player),255,255,0)
		end
	end
end)

addEvent("giveBusinessAccount",true)
addEventHandler("giveBusinessAccount",root,function(account)
	local accountName = exports.server:getPlayerAccountName(source)
	local targetName = account
	local BusinessName = getPlayerBusiness(accountName)
	if targetName == accountName then
		exports.NGCdxmsg:createNewDxMessage(source,"You can't set yourself as President",255,0,0)
		return
	end
	if targetName and accountName and BusinessName then
		if getBusinessPresident(BusinessName) == tostring(accountName) then
			setElementData(source, "Business rank", "Worker")
			setElementData(player, "Business rank", "President")
			addLog(BusinessName,getPlayerName(source).." has gave President level to "..accountName)
			exports.DENmysql:exec("UPDATE Business SET Business_leader=?",targetName)
			exports.NGCdxmsg:createNewDxMessage(source,"You have gave President to "..account,0,255,0)
			businessMsg(BusinessName,getPlayerName(source).." gave the President of this business to "..account,0,255,0)
			setPlayerBusinessRank(targetName, BusinessName, "President")
			setPlayerBusinessRank(accountName, BusinessName, "Worker")
		end
	end
end)
----** fix add member from who to who
addEvent("getMemberList",true)
addEventHandler("getMemberList",root,
function (client)
	local accountName = exports.server:getPlayerAccountName(client)
	local BusinessName = getPlayerBusiness(accountName)
	local memberList = getBusinessMembers(BusinessName)
	triggerClientEvent(client,"returnMemberList",client,memberList)
end)

addEvent("getRankList",true)
addEventHandler("getRankList",root,
function (client)
	local accountName = exports.server:getPlayerAccountName(client)
	local BusinessName = getPlayerBusiness(accountName)
	local rankList = getBusinessRankList(BusinessName)
	triggerClientEvent(client,"returnRankList",client,rankList)
end)

addEvent("addRank",true)
addEventHandler("addRank",root,
function (client, rankName, rankPowers)
	local accountName = exports.server:getPlayerAccountName(client)
	local BusinessName = getPlayerBusiness(accountName)
	local myrank = getMemberRank(accountName, BusinessName)
	if not aclAllowed(BusinessName, myrank, "setrank") then
		--getBusinessPresident(BusinessName) ~= tostring(accountName) then
		exports.NGCdxmsg:createNewDxMessage(client,"You don't have access to this function.",255,0,0)
		return
	end
	if string.find(rankName, "'") then exports.NGCdxmsg:createNewDxMessage(client,"You can't use the multi quote character.",255,0,0) return end
	if addRankToBusiness(BusinessName, rankName, rankPowers) then
		triggerEvent("getMemberList",client,client)
		addLog(BusinessName,getPlayerName(source).." has added new rank "..rankName)
		exports.NGCdxmsg:createNewDxMessage(client,"The rank ".. tostring(rankName) .." has been added.",0,255,0)
	end
end)

addEvent("kickMember",true)
addEventHandler("kickMember",root,
function (client, memberAccount)
	local accountName = exports.server:getPlayerAccountName(client)
	local BusinessName = getPlayerBusiness(accountName)
	local rankName = getMemberRank(accountName, BusinessName)
	if not aclAllowed(BusinessName, rankName, "kick")  then exports.NGCdxmsg:createNewDxMessage(client,"You don't have access to this function.",255,0,0) return end
	if getBusinessPresident(BusinessName) == tostring(memberAccount) then exports.NGCdxmsg:createNewDxMessage(client,"You can't kick the Business leader.",255,0,0) return end
	if removeMemberFromBusiness(BusinessName, memberAccount, getPlayerName(client)) then
		businessMsg(BusinessName,getPlayerName(client).." has kicked "..memberAccount.." from the business!",255,0,0)
		for k,v in ipairs(getElementsByType("player")) do
			if memberAccount == exports.server:getPlayerAccountName(v) then
				setElementData(v, "Business rank", "None")
				setElementData(v, "Business", "None")
			end
		end
		triggerEvent("getMemberList",client,client)
		addLog(BusinessName,getPlayerName(source).." has kicked "..memberAccount)
		exports.NGCdxmsg:createNewDxMessage(client,"You have kicked ".. tostring(memberAccount) .." from the Business.",255,0,0)
	end
end)

addEvent("getLog",true)
addEventHandler("getLog",root,
function (client)
	local accountName = exports.server:getPlayerAccountName(client)
	local BusinessName = getPlayerBusiness(accountName)
	local BusinessLog = getBusinessLog(BusinessName)
	triggerClientEvent(client,"returnLog",client,BusinessLog)
end)

addEvent("cleanBusinessLog",true)
addEventHandler("cleanBusinessLog",root,
function (client)
	local accountName = exports.server:getPlayerAccountName(client)
	local BusinessName = getPlayerBusiness(accountName)
	local rankName = getMemberRank(accountName, BusinessName)
	if not aclAllowed(BusinessName, rankName, "cleanBusinessLog") then exports.NGCdxmsg:createNewDxMessage(client,"You don't have access to this function.",255,0,0) return end
	clearBusinessLog(BusinessName)
	triggerEvent("getLog",client,client)
end)

addEvent("getTasks",true)
addEventHandler("getTasks",root,
function (client)
	local accountName = exports.server:getPlayerAccountName(client)
	local BusinessName = getPlayerBusiness(accountName)
	local BusinessTasks = getBusinessTasks(BusinessName)
	triggerClientEvent(client,"returnTasks",client,BusinessTasks)
end)

addEvent("sendTask",true)
addEventHandler("sendTask",root,
function (client, text)
	local can,msg = exports.NGCmanagement:isPlayerLagging(source)
	if can then
		local accountName = exports.server:getPlayerAccountName(client)
		local BusinessName = getPlayerBusiness(accountName)
		local cDate, cTime = getCurrentDateAndTime()
		if string.find(text, "'") then exports.NGCdxmsg:createNewDxMessage(client,"You can't use the multi quote character.",255,0,0) return end
		local theMessage = getPlayerName(client).."("..accountName.."),"..text..","..cDate..","..cTime
		addTask(BusinessName, theMessage)
		for index, player in pairs(getPlayersByBusiness(BusinessName)) do
			triggerEvent("getTasks",player,player)
		end
		businessMsg(BusinessName,getPlayerName(client).." has added new task",255,0,0)
	else
		exports.NGCdxmsg:createNewDxMessage(source,msg,255,0,0)
		return false
	end
end)

addEvent("getBankBalance",true)
addEventHandler("getBankBalance",root,
function (client)
	local accountName = exports.server:getPlayerAccountName(client)
	local BusinessName = getPlayerBusiness(accountName)
	if BusinessName then
		local balance = getBusinessBank(BusinessName)
		local transactions = exports.DENmysql:query("SELECT * FROM Business_transactions WHERE Business_name=?",BusinessName)
		local BDate = exports.DENmysql:querySingle("SELECT * FROM Business WHERE Business_name=?",BusinessName)
		if BDate then
			triggerClientEvent(client,"returnBankBalance",client,balance,transactions,BDate.Business_date)
		else
			triggerClientEvent(client,"returnBankBalance",client,balance,transactions,false)
		end
	end
end)

addEvent("bbWithdraw",true)
addEventHandler("bbWithdraw",root,
function (client, amount)
	local can,msg = exports.NGCmanagement:isPlayerLagging(source)
	if can then
		local accountName = exports.server:getPlayerAccountName(client)
		local BusinessName = getPlayerBusiness(accountName)
		local rankName = getMemberRank(accountName, BusinessName)
		if not aclAllowed(BusinessName, rankName, "withdraw")  then exports.NGCdxmsg:createNewDxMessage(client,"You don't have access to this function.",255,0,0) return end
		if ( amount < 1 ) then exports.NGCdxmsg:createNewDxMessage(client,"You can't withdraw less than $1.",255,0,0) return end
		local balance = getBusinessBank(BusinessName)
		if balance >= amount then
			updateBusinessBank(BusinessName, balance - amount)
			addLog(BusinessName, getPlayerName( source ).." withdraw $"..amount)
			--exports.CSGlogging:createLogRow ( source, "money", getPlayerName(source).." has withdrawn $" .. amount .. " from his business (Business name: " .. BusinessName .. ")" )
			exports.DENmysql:exec( "INSERT INTO Business_transactions SET Business_name=?, memberid=?, transaction=?", BusinessName, exports.server:getPlayerAccountID(source), getPlayerName( source ).." withdrawn $"..amount )
			triggerEvent("getBankBalance",client,client)
			exports.AURpayments:addMoney(client,amount,"Custom","Groups",0,"AURbusiness withdraw")
			businessMsg(BusinessName, getPlayerName( source ).." withdraw $"..amount)
			for k,v in ipairs(getElementsByType("player")) do
				triggerEvent("getBusinessPayment",v)
			end
		else
			exports.NGCdxmsg:createNewDxMessage(client,"The Business bank doesn't has $ "..cvtNumber(amount) ..".",255,0,0)
		end
	else
		exports.NGCdxmsg:createNewDxMessage(source,msg,255,0,0)
		return false
	end
end)

addEvent("bbDeposit",true)
addEventHandler("bbDeposit",root,
function (client, amount)
	local can,msg = exports.NGCmanagement:isPlayerLagging(source)
	if can then
		local accountName = exports.server:getPlayerAccountName(client)
		local BusinessName = getPlayerBusiness(accountName)
		local balance = getBusinessBank(BusinessName)
		if ( amount < 1 ) then exports.NGCdxmsg:createNewDxMessage(client,"You can't deposit less than $1.",255,0,0) return end
		if getPlayerMoney(client) >= amount then
			updateBusinessBank(BusinessName, balance + amount)
			addLog(BusinessName, getPlayerName( source ).." deposited $"..amount)
			exports.DENmysql:exec( "INSERT INTO Business_transactions SET Business_name=?, memberid=?, transaction=?", BusinessName, exports.server:getPlayerAccountID(source), getPlayerName( source ).." deposited $"..amount )
			triggerEvent("getBankBalance",client,client)
			exports.AURpayments:takeMoney(client,amount,"AURbusiness deposit")

			businessMsg(BusinessName, getPlayerName( source ).." deposited $"..amount)
			for k,v in ipairs(getElementsByType("player")) do
				triggerEvent("getBusinessPayment",v)
			end
		else
			exports.NGCdxmsg:createNewDxMessage(client,"You don't have $ "..cvtNumber(amount) .." to deposit.",255,0,0)
		end
	else
		exports.NGCdxmsg:createNewDxMessage(source,msg,255,0,0)
		return false
	end
end)


function cvtNumber( theNumber )

	local formatted = theNumber

	while true do

		formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')

	if (k==0) then

		break

		end

	end

	return formatted

end


addEvent("sendBusinessPayment",true)
addEventHandler("sendBusinessPayment",root,function(bn,cost)
	if doesBusinessExists(bn) then
		local can,msg = exports.NGCmanagement:isPlayerLagging(source)
		if can then
			if getPlayerMoney(client) >= tonumber(cost) then
				exports.AURpayments:takeMoney(source,tonumber(cost),"AURBusiness send to business")
				local balance = getBusinessBank(bn)
				updateBusinessBank(bn, balance + cost)
				exports.DENmysql:exec( "INSERT INTO Business_transactions SET Business_name=?, memberid=?, transaction=?", bn, exports.server:getPlayerAccountID(source),"[Business] "..getPlayerName( source ).." has sent $"..cost )
				addLog(bn, getPlayerName( source ).." send payment $"..cost)
				businessMsg(bn, getPlayerName( source ).." sent $"..cvtNumber(cost).." to your business")
				for k,v in ipairs(getElementsByType("player")) do
					triggerEvent("getBusinessPayment",v)
				end
				exports.NGCdxmsg:createNewDxMessage("You have sent $"..cvtNumber(cost).." to business ("..bn..")",msg,255,0,0)
			end
		else
			exports.NGCdxmsg:createNewDxMessage(source,msg,255,0,0)
		end
	else
		exports.NGCdxmsg:createNewDxMessage(source,"Sorry the business isn't available anymore!",255,0,0)
	end
end)

addEvent("setPlayerBusinessRank",true)
addEventHandler("setPlayerBusinessRank",root,
function (client, memberAccount, rankName)
	local accountName = exports.server:getPlayerAccountName(client)
	local BusinessName = getPlayerBusiness(accountName)
	local myRankName = getMemberRank(accountName, BusinessName)
	if rankName == "President" then
		exports.NGCdxmsg:createNewDxMessage(client,"You can't give anyone President rank!",255,0,0)
		return false
	end
	if not aclAllowed(BusinessName, myRankName, "setrank") then exports.NGCdxmsg:createNewDxMessage(client,"You don't have access to this function.",255,0,0) return end
	if accountName == memberAccount then exports.NGCdxmsg:createNewDxMessage(client,"You can't set your rank.",255,0,0) return end
	if getBusinessPresident(BusinessName) == memberAccount then exports.NGCdxmsg:createNewDxMessage(client,"You can't set the Business leader rank.",255,0,0) return end
		setPlayerBusinessRank(memberAccount, BusinessName, rankName)
		addLog(BusinessName,getPlayerName(source).." has set "..memberAccount.." rank to "..rankName)
	for k,v in ipairs(getElementsByType("player")) do
		if memberAccount == exports.server:getPlayerAccountName(v) then
			setElementData(v, "Business rank", rankName)
		end
	end
	businessMsg(BusinessName,getPlayerName(source).." has set "..memberAccount.." rank to "..rankName)
end)

addEvent("businessRemoveTask",true)
addEventHandler("businessRemoveTask",root,function(msg)
	if msg then
		local accountName = exports.server:getPlayerAccountName(source)
		local BusinessName = getPlayerBusiness(accountName)
		if BusinessName then
			local myRankName = getMemberRank(accountName, BusinessName)
			if aclAllowed(BusinessName, myRankName, "assign") then
				removeTask(BusinessName,msg)
				for index, player in pairs(getPlayersByBusiness(BusinessName)) do
					triggerEvent("getTasks",player,player)
				end
				exports.NGCdxmsg:createNewDxMessage(source,"Task removed successfully",255,0,0)
			end
		end
	end
end)

addEvent("deleteRank",true)
addEventHandler("deleteRank",root,
function (client, theRank)
	local accountName = exports.server:getPlayerAccountName(client)
	local BusinessName = getPlayerBusiness(accountName)
	local rankName = getMemberRank(accountName, BusinessName)
	if not aclAllowed(BusinessName, rankName, "delrank") then exports.NGCdxmsg:createNewDxMessage(client,"You don't have access to this function.",255,0,0) return end
	if theRank == "President" then exports.NGCdxmsg:createNewDxMessage(client,"You can't delete the President rank.",255,0,0) return end
	if theRank == "Worker" then exports.NGCdxmsg:createNewDxMessage(client,"You can't delete the Worker rank.",255,0,0) return end
	if removeRankFromBusiness(BusinessName, theRank) then
		addLog(BusinessName,getPlayerName(source).." has deleted the rank "..theRank)
		exports.NGCdxmsg:createNewDxMessage(client,"You have deleted the rank ".. tostring(theRank) ..".",255,0,0)
		triggerEvent("getRankList",client,client)
		businessMsg(BusinessName,getPlayerName(source).." has deleted the rank "..theRank)
	end
end)

addEvent("leaveBusiness",true)
addEventHandler("leaveBusiness",root,
function (client)
	if getElementData(client,"Business") ~= "None" then
		local accountName = exports.server:getPlayerAccountName(client)
		local BusinessName = getPlayerBusiness(accountName)
		if getBusinessPresident(BusinessName) == accountName then exports.NGCdxmsg:createNewDxMessage(client,"You can't leave the Business as you are the leader of it.",255,0,0) return end
		removeMemberFromBusiness(BusinessName, accountName)
		setElementData(source,"Business","None")
		setElementData(source,"Business rank","None")
		addLog(BusinessName,getPlayerName(source).." has left the business")
		businessMsg(BusinessName,getPlayerName(source).." has left the business",255,0,0)
	end
end)
spm = {}
function BusinessChat(player, commandName, ...)
	if isTimer(spm[player]) then
		exports.NGCdxmsg:createNewDxMessage(player,"Please wait 2 seconds before you spam bc message command",255,0,0)
		return false
	end
	if isPlayerInBusiness(exports.server:getPlayerAccountName(player)) then
		local BusinessName = getPlayerBusiness(exports.server:getPlayerAccountName(player))
		if BusinessName then
			spm[player] = setTimer(function() end,2000,1)
			local parametersTable = {...}
			local theMessage = table.concat(parametersTable, " ")
			for index, thePlayer in pairs(getPlayersByBusiness(BusinessName)) do
				outputChatBox("(Business: "..BusinessName..") "..getPlayerName(player)..": #FFFFFF"..tostring(theMessage), thePlayer, 255, 255,0, true)
			end
			for i, v in ipairs(getElementsByType("player")) do
				if (exports.CSGstaff:isPlayerStaff(v) and getElementData(v, "AURcurtmisc.hackmonitor")) then
					outputChatBox("(Business: "..BusinessName..") "..getPlayerName(player)..": #FFFFFF"..tostring(theMessage), v, 0, 255,0, true)
				end
			end
			outputServerLog("Business "..BusinessName..": "..getPlayerName(player)..": "..tostring(theMessage))
		end
	end
end
addCommandHandler("bc", BusinessChat)

addEvent("deleteBusiness",true)
addEventHandler("deleteBusiness",root,
function (client)
	local accountName = exports.server:getPlayerAccountName(client)
	local BusinessName = getPlayerBusiness(accountName)
	if getBusinessPresident(BusinessName) == accountName then
		if removeBusinessFromDatabase(BusinessName) then
			setElementData(client, "Business rank", "None")
			businessMsg(BusinessName,getPlayerName(source).." has deleted the business!")
			for k,v in ipairs(getElementsByType("player")) do
				if BusinessName == getElementData(v,"Business") then
					setElementData(v, "Business rank", "None")
					setElementData(v, "Business", "None")
				end
			end
		end
		exports.NGCdxmsg:createNewDxMessage(client,"You have deleted the Business ".. tostring(BusinessName) ..".",255,0,0)
	else
		exports.NGCdxmsg:createNewDxMessage(client,"You are not the Business leader.",255,0,0)
	end
end)

--AKE INC
addCommandHandler("delBusiness",function(player,cmd,ty)
	if getElementData(player,"isPlayerPrime") then
		local BusinessName = ty
		if doesBusinessExists(BusinessName) then
			exports.DENmysql:exec("DELETE FROM Business_transactions WHERE Business_name=?",tostring(BusinessName))
			exports.DENmysql:exec("DELETE FROM Business_invites WHERE Business_name=?",tostring(BusinessName))
			exports.DENmysql:exec("DELETE FROM Business_members WHERE Business_name=?",tostring(BusinessName))
			exports.DENmysql:exec("DELETE FROM Business_log WHERE Business_name=?",tostring(BusinessName))
			exports.DENmysql:exec("DELETE FROM Business_messages WHERE Business_name=?",tostring(BusinessName))
			exports.DENmysql:exec("DELETE FROM Business_ranks WHERE Business_name=?",tostring(BusinessName))
			exports.DENmysql:exec("DELETE FROM Business WHERE Business_name=?",tostring(BusinessName))
		end
	end
end)
--AKE INC
addCommandHandler("clearallbus",function(player,cmd,ty)
	if getElementData(player,"isPlayerPrime") then
		exports.DENmysql:exec("DELETE FROM Business_transactions")
		exports.DENmysql:exec("DELETE FROM Business_invites")
		exports.DENmysql:exec("DELETE FROM Business_members")
		exports.DENmysql:exec("DELETE FROM Business_log")
		exports.DENmysql:exec("DELETE FROM Business_messages")
		exports.DENmysql:exec("DELETE FROM Business_ranks")
		exports.DENmysql:exec("DELETE FROM Business")
	end
end)


function getTimeDate()
	local aRealTime = getRealTime ( )
	return
	string.format ( "%04d/%02d/%02d", aRealTime.year + 1900, aRealTime.month + 1, aRealTime.monthday ),
	string.format ( "%02d:%02d:%02d", aRealTime.hour, aRealTime.minute, aRealTime.second )
end

function addprimebusLog(message)
	if (not message) then return end
	local date, time = getTimeDate()
	local final = "["..date.. " - "..time.."]"
	if (not fileExists("logs/primebus2.log")) then
		log = fileCreate("logs/primebus2.log")
	else
		log = fileOpen("logs/primebus2.log")
	end
	if (not log) then return end
	if (not fileExists("logs/primebus2.log")) then return end
	if (fileGetSize(log) == 0) then
		fileWrite(log, final.." "..message)
	else
		fileSetPos(log, fileGetSize(log))
		fileWrite(log, "\r\n", "primebus : "..final.." "..message)
	end
	fileClose(log)
end
