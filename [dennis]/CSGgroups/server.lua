local alliances = {}
local allianceGroups = {}
local alliancesFile

antiHack = {}
smartTimer = {}
-- Group ranks
local groupRanks = { ["Guest"]=0, ["Member"]=1, ["Steward"]=2, ["Manager"]=3, ["Deputy Leader"]=4, ["Group Leader"]=5 }


local toadd = {
	["Criminals"] = {
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
	["other"] = {
		[1] = {"Working as a Clothes Seller",7}, --- added
		[2] = {"Working as a Clothes Seller",5}, -- added
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



addCommandHandler("gxp",function(p,cmd,id)
	if getElementData(p,"isPlayerPrime") then
		addXP(p,id)
	end
end)

addCommandHandler("gs",function(p,cmd,id)
	if getElementData(p,"isPlayerPrime") then
		local g = exports.server:getPlayerGroupID(p)
		exports.DENmysql:exec("INSERT INTO groupStats SET groupid=?,action1=?,action2=?,action3=?,action4=?,action5=?,action6=?,action7=?,action8=?,action9=?,action10=?",g,0,0,0,0,0,0,0,0,0,0)
	end
end)

function addXP(player,ids)
	if player and isElement(player) then
		local playerID = exports.server:getPlayerAccountID( player )
		local groupID = exports.server:getPlayerGroupID( player )
		local column = {}
		-----outputDebugString("Attempt to give xp")
		if playerID and groupID then
			local oldXP = exports.DENmysql:querySingle("SELECT * FROM groups WHERE groupid=?",groupID)
			if oldXP then
				if oldXP.groupXP == nil or oldXP.groupXP == false or not oldXP.groupXP then
					oldXP.groupXP = 0
				end
				if oldXP.groupXP then
					-----outputDebugString("Group XP triggered")
					local grtype = oldXP.gType
					if grtype then
						if grtype == "Criminals" then
							if getPlayerTeam(player) and getTeamName(getPlayerTeam(player)) ~= "Criminals" then
								return false
							end
						end
						if grtype == "Law" then
							if exports.DENlaw:isLaw(player) ~= true then
								return false
							end
						end
						if grtype == "other" then
							if getPlayerTeam(player) and getTeamName(getPlayerTeam(player)) ~= "Civilian Workers" then
								return false
							end
						end
						-----outputDebugString("Gtype triggered "..grtype)
						if toadd[grtype] then
							local ids = tonumber(ids)
							local xpdata = toadd[grtype][ids][1]
							local xp = toadd[grtype][ids][2]
							if xp then
								local newxp = tonumber(oldXP.groupXP) + tonumber(xp)
								if exports.DENmysql:exec("UPDATE groups SET groupXP=? WHERE groupid=?",tonumber(newxp),groupID) then
									triggerClientEvent(player,"setXPMsg",player,xpdata,xp)
									--exports.DENmysql:exec("INSERT INTO groups_logs (groupid,log) VALUES (?,?)",groupID,getPlayerName(player).." added "..xp.." to group")
									local data = exports.DENmysql:querySingle("SELECT * FROM groupStats WHERE groupid=?",groupID)
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
										else
											-----outputDebugString("Error for IDS")
										end
										if column[groupID] == nil or column[groupID] == false or not column[groupID] then
											column[groupID] = 0
											-----outputDebugString("Error Column reset to 0")
										end
										local ids = tostring(ids)
										local tblvalue = "action"..ids
										-----outputDebugString("Old column for "..ids.." is "..column[groupID])
										local newaction = tonumber(column[groupID])+tonumber(xp)
										if newaction then
											-----outputDebugString(tblvalue.." New column for "..ids.." is "..newaction)
											exports.DENmysql:exec("UPDATE groupStats SET `??`=? WHERE groupid=?",tblvalue,newaction,groupID)
											-----outputDebugString("Adding actions")
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
local antiSpamsex = {}
addEvent("changeMemberAvAccess",true)
addEventHandler("changeMemberAvAccess",root,function(target,av,wh)
	if target then
		if isTimer(antiSpamsex[target]) then
			exports.NGCdxmsg:createNewDxMessage(source,"Please wait few seconds before you change member AV access",255,0,0)
			return false
		end
		antiSpamsex[target] = setTimer(function() end,2000,1)
		if target and isElement(target) then
			local playerID = exports.server:getPlayerAccountID( target )
			local accName = exports.server:getPlayerAccountName( target )
			local groupID = exports.server:getPlayerGroupID( source )
			local groupID2 = exports.server:getPlayerGroupID( target )
			if groupID then
				if groupID2 then
					if groupID2 == groupID then
						if tonumber(wh) == 2 then
							local val = 0
							if tonumber(av) == 0 then
								val = 1
							else
								val = 0
							end
							-----outputDebugString("AV "..wh.." is hydra: new "..val.." old "..av)
							exports.DENmysql:exec("UPDATE groups_members SET hydra=? WHERE groupid=? AND memberid=?",val,groupID,playerID)
							exports.NGCdxmsg:createNewDxMessage(source,"You have changed player/account AV access",0,255,0)
							exports.AURnotifications:addNotification(accName, "Your Hydra access has been changed.")

						elseif tonumber(wh) == 3 then
							local val = 0
							if tonumber(av) == 0 then
								val = 1
							else
								val = 0
							end
							-----outputDebugString("COL 3")
							exports.DENmysql:exec("UPDATE groups_members SET rustler=? WHERE groupid=? AND memberid=?",val,groupID,playerID)
							exports.NGCdxmsg:createNewDxMessage(source,"You have changed player/account AV access",0,255,0)
							exports.AURnotifications:addNotification(accName, "Your Rustler access has been changed.")

						elseif tonumber(wh) == 4 then
							local val = 0
							if tonumber(av) == 0 then
								val = 1
							else
								val = 0
							end
							-----outputDebugString("COL 4")
							exports.DENmysql:exec("UPDATE groups_members SET hunter=? WHERE groupid=? AND memberid=?",val,groupID,playerID)
							exports.NGCdxmsg:createNewDxMessage(source,"You have changed player/account AV access",0,255,0)
							exports.AURnotifications:addNotification(accName, "Your Hunter access has been changed.")

						elseif tonumber(wh) == 5 then
							local val = 0
							if tonumber(av) == 0 then
								val = 1
							else
								val = 0
							end
							-----outputDebugString("COL 5")
							exports.DENmysql:exec("UPDATE groups_members SET seasparrow=? WHERE groupid=? AND memberid=?",val,groupID,playerID)
							exports.NGCdxmsg:createNewDxMessage(source,"You have changed player/account AV access",0,255,0)
							exports.AURnotifications:addNotification(accName, "Your Seasparrow access has been changed.")

						elseif tonumber(wh) == 6 then
							local val = 0
							if tonumber(av) == 0 then
								val = 1
							else
								val = 0
							end
							-----outputDebugString("COL 5")
							exports.DENmysql:exec("UPDATE groups_members SET rhino=? WHERE groupid=? AND memberid=?",val,groupID,playerID)
							exports.NGCdxmsg:createNewDxMessage(source,"You have changed player/account AV access",0,255,0)
							exports.AURnotifications:addNotification(accName, "Your Rhino access has been changed.")

						end
					end
				end
			end
		else
			if target and not isElement(target) then
				-----outputDebugString("Being adding not player")
				local playerID = exports.server:getPlayerAccountID( source )
				local groupID = exports.server:getPlayerGroupID( source )
				local pAcc = target
				if playerID then
					if groupID then
						if tonumber(wh) == 2 then
							local val = 0
							if tonumber(av) == 0 then
								val = 1
							else
								val = 0
							end
							exports.DENmysql:exec("UPDATE groups_members SET hydra=? WHERE groupid=? AND membername=?",val,groupID,pAcc)
							exports.NGCdxmsg:createNewDxMessage(source,"You have changed player/account AV access",0,255,0)
							exports.AURnotifications:addNotification(pAcc, "Your Hydra access has been changed.")
						elseif tonumber(wh) == 3 then
							local val = 0
							if tonumber(av) == 0 then
								val = 1
							else
								val = 0
							end
							exports.DENmysql:exec("UPDATE groups_members SET rustler=? WHERE groupid=? AND membername=?",val,groupID,pAcc)
							exports.NGCdxmsg:createNewDxMessage(source,"You have changed player/account AV access",0,255,0)
							exports.AURnotifications:addNotification(pAcc, "Your Rustler access has been changed.")
						elseif tonumber(wh) == 4 then
							local val = 0
							if tonumber(av) == 0 then
								val = 1
							else
								val = 0
							end
							exports.DENmysql:exec("UPDATE groups_members SET hunter=? WHERE groupid=? AND membername=?",val,groupID,pAcc)
							exports.NGCdxmsg:createNewDxMessage(source,"You have changed player/account AV access",0,255,0)
							exports.AURnotifications:addNotification(pAcc, "Your Hunter access has been changed.")
						elseif tonumber(wh) == 5 then
							local val = 0
							if tonumber(av) == 0 then
								val = 1
							else
								val = 0
							end
							exports.DENmysql:exec("UPDATE groups_members SET seasparrow=? WHERE groupid=? AND membername=?",val,groupID,pAcc)
							exports.NGCdxmsg:createNewDxMessage(source,"You have changed player/account AV access",0,255,0)
							exports.AURnotifications:addNotification(pAcc, "Your Seasparrow access has been changed.")
						elseif tonumber(wh) == 6 then
							local val = 0
							if tonumber(av) == 0 then
								val = 1
							else
								val = 0
							end
							exports.DENmysql:exec("UPDATE groups_members SET rhino=? WHERE groupid=? AND membername=?",val,groupID,pAcc)
							exports.NGCdxmsg:createNewDxMessage(source,"You have changed player/account AV access",0,255,0)
							exports.AURnotifications:addNotification(pAcc, "Your Rhino access has been changed.")
							--
						end
					end
				end
			end
		end
		local groupID = exports.server:getPlayerGroupID( source )
		if groupID then
			local d = exports.DENmysql:query("SELECT * FROM groups_members WHERE groupid=?",groupID)
			triggerClientEvent(source,"reloadMemb",source,d)
		end
	end
end)

addEvent("callGroupSpawnAccess",true)
addEventHandler("callGroupSpawnAccess",root,function()
	local playerID = exports.server:getPlayerAccountID( source )
	local groupID = exports.server:getPlayerGroupID( source )
	if groupID then
		local spawnData = exports.DENmysql:querySingle("SELECT * FROM groups_members WHERE groupid=? AND memberid=?",groupID,playerID)
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



addEvent("onFounderUpgradeGroup",true)
addEventHandler("onFounderUpgradeGroup",root,function()
	local playerID = exports.server:getPlayerAccountID( source )
	local groupID = exports.server:getPlayerGroupID( source )
	if groupID then
		local groupData = exports.DENmysql:querySingle("SELECT * FROM groups WHERE groupid=?",groupID)
		if groupData then
			if groupData.groupXP == nil or groupData.groupXP == false or not groupData.groupXP then groupData.groupXP = 0 end
			local level = groupData.groupLevel
			local level = tonumber(level)
			if level == nil or level == false then level = 0 end
			local grxp = groupData.groupXP
			local grxp = tonumber(grxp)
			if tonumber(level) == 0 then
				if grxp >= 2000 then
					if getPlayerMoney(source) >= 100000 then
						exports.AURpayments:takeMoney(source,100000,"CSGGroups upgrading")
					else
						exports.NGCdxmsg:createNewDxMessage(source,"You don't have enough money to upgrade your group",255,0,0)
						return false
					end
					exports.DENmysql:exec("UPDATE groups SET groupLevel=? WHERE groupid=?",1,groupID)
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
					exports.DENmysql:exec("UPDATE groups SET groupLevel=? WHERE groupid=?",2,groupID)
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

					exports.DENmysql:exec("UPDATE groups SET groupLevel=? WHERE groupid=?",3,groupID)
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

					exports.DENmysql:exec("UPDATE groups SET groupLevel=? WHERE groupid=?",4,groupID)
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

					exports.DENmysql:exec("UPDATE groups SET groupLevel=? WHERE groupid=?",5,groupID)
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
end)


function checkGroupLevel(groupID)
	local groupData = exports.DENmysql:querySingle("SELECT * FROM groups WHERE groupid=?",groupID)
	if groupData then
		if groupData.groupXP == nil or groupData.groupXP == false or not groupData.groupXP then groupData.groupXP = 0 end
		if groupData.groupXP >= 0 and groupData.groupXP < 500 then
			local glvl = 0
			if groupData.groupLevel ~= glvl then
				exports.DENmysql:exec("UPDATE groups SET groupLevel=? WHERE groupid=?",glvl,groupID)
			end
		elseif groupData.groupXP >= 500 and groupData.groupXP < 2500 then
			local glvl = 1
			if groupData.groupLevel ~= glvl then
				exports.DENmysql:exec("UPDATE groups SET groupLevel=? WHERE groupid=?",glvl,groupID)
			end
		elseif groupData.groupXP >= 2500 and groupData.groupXP < 5000 then
			local glvl = 2
			if groupData.groupLevel ~= glvl then
				exports.DENmysql:exec("UPDATE groups SET groupLevel=? WHERE groupid=?",glvl,groupID)
			end
		elseif groupData.groupXP >= 5000 and groupData.groupXP < 10000 then
			local glvl = 3
			if groupData.groupLevel ~= glvl then
				exports.DENmysql:exec("UPDATE groups SET groupLevel=? WHERE groupid=?",glvl,groupID)
			end
		elseif groupData.groupXP >= 10000 and groupData.groupXP < 20000 then
			local glvl = 4
			if groupData.groupLevel ~= glvl then
				exports.DENmysql:exec("UPDATE groups SET groupLevel=? WHERE groupid=?",glvl,groupID)
			end
		elseif groupData.groupXP >= 20000 then
			local glvl = 5
			if groupData.groupLevel ~= glvl then
				exports.DENmysql:exec("UPDATE groups SET groupLevel=? WHERE groupid=?",glvl,groupID)
			end
		end
	end
end

-- Get a table with all the players from a group
local updateTick = false
local theTable = {}

function getGroupPlayers ( theGroup )
	if not ( updateTick ) or ( getTickCount()-updateTick > 60000 ) then
		updateTick = getTickCount()
		theTable = {}
		for k, thePlayer in ipairs ( getElementsByType ( "player" ) ) do
			if ( getElementData( thePlayer, "Group" ) == theGroup ) then
				table.insert( theTable, thePlayer )
			end
		end
		return theTable
	else
		return theTable
	end
end

-- Get all the data needed to show the groups panel
addEvent( "requestGroupsData", true )
addEventHandler( "requestGroupsData", root,
	function ()
		local playerID = exports.server:getPlayerAccountID( source )
		local groupID = exports.server:getPlayerGroupID( source )
		if ( playerID ) and ( groupID ) then
			dbQuery(grCallBack,{source,playerID},exports.DENmysql:getConnection(),"SELECT * FROM groups WHERE (membercount > 0 OR groupid=?) ORDER BY membercount DESC",groupID )
			--local groupsTable = exports.DENmysql:query( "SELECT * FROM groups ORDER BY groupid ASC" )
			--local invitesTable = exports.DENmysql:query( "SELECT * FROM groups_invites WHERE memberid=? ORDER BY groupid ASC", playerID )
			--local memberTable = exports.DENmysql:querySingle( "SELECT * FROM groups_members WHERE memberid=? LIMIT 1", playerID )
			--local membersTable = exports.DENmysql:query( "SELECT * FROM groups_members WHERE groupid=? LIMIT 80", groupID )
			--local bankingTable = exports.DENmysql:query( "SELECT * FROM groups_transactions WHERE groupid=? ORDER BY datum DESC LIMIT 25", groupID )
			--triggerClientEvent( source, "onRequestGroupDataCallback", source, groupsTable, invitesTable, memberTable, bankingTable, membersTable, groupID )

			--if ( #membersTable ) then exports.DENmysql:exec( "UPDATE groups SET membercount=? WHERE groupid=?", #membersTable, groupID ) end
		else
			dbQuery(nogGroupsCB,{source,playerID},exports.DENmysql:getConnection(),"SELECT * FROM groups WHERE membercount > 0 ORDER BY membercount DESC")
			--local groupsTable = exports.DENmysql:query( "SELECT * FROM groups ORDER BY groupid ASC" )
			--local invitesTable = exports.DENmysql:query( "SELECT * FROM groups_invites WHERE memberid=? ORDER BY groupid ASC", playerID )
			--triggerClientEvent( source, "onRequestGroupDataCallback", source, groupsTable, invitesTable, false, false )
		end
	end
)

function nogGroupsCB(qh,source,playerID)
	if isElement(source) then else return end
	local groupsTable=dbPoll(qh,0)
	dbQuery(nogInvitesCB,{source,groupsTable},exports.DENmysql:getConnection(),"SELECT * FROM groups_invites WHERE memberid=? ORDER BY groupid ASC", playerID)
end

function nogInvitesCB(qh,source,groupsTable)
	if isElement(source) then else return end
	local invitesTable=dbPoll(qh,0)
	triggerClientEvent( source, "onRequestGroupDataCallback", source, groupsTable, invitesTable, false, false )
end

function grCallBack(qh,source,playerID)
	if isElement(source) then else return end
	local groupsTable=dbPoll(qh,0)
	dbQuery(invitesCallBack,{groupsTable,source,playerID},exports.DENmysql:getConnection(),"SELECT * FROM groups_invites WHERE memberid=? ORDER BY groupid ASC", playerID )
end

function invitesCallBack(qh,groupsTable,source,playerID)
	if isElement(source) then else return end
	local invitesTable=dbPoll(qh,0)
	dbQuery(memberCallBack,{groupsTable,invitesTable,source,playerID},exports.DENmysql:getConnection(),"SELECT * FROM groups_members WHERE memberid=? LIMIT 1", playerID )
end

function memberCallBack(qh,groupsTable,invitesTable,source,playerID)
	if isElement(source) then else return end
	local memberTable=dbPoll(qh,0)
	memberTable=memberTable[1]
	local groupID = exports.server:getPlayerGroupID( source )
	dbQuery(membersCallBack,{groupsTable,invitesTable,memberTable,source,playerID},exports.DENmysql:getConnection(),"SELECT * FROM groups_members WHERE groupid=? LIMIT 80", groupID )
end

function membersCallBack(qh,groupsTable,invitesTable,memberTable,source,playerID)
	if isElement(source) then else return end
	local membersTable=dbPoll(qh,0)
	local groupID = exports.server:getPlayerGroupID( source )
	if getElementData(source,"isPlayerPrime") then
		dbQuery(bankingCallBack,{groupsTable,invitesTable,memberTable,membersTable,source,playerID},exports.DENmysql:getConnection(),"SELECT * FROM groups_transactions WHERE groupid=? ORDER BY datum DESC", groupID )
	else
		dbQuery(bankingCallBack,{groupsTable,invitesTable,memberTable,membersTable,source,playerID},exports.DENmysql:getConnection(),"SELECT * FROM groups_transactions WHERE groupid=? ORDER BY datum DESC LIMIT 25", groupID )
	end
end

function bankingCallBack(qh,groupsTable,invitesTable,memberTable,membersTable,source,playerID)
	if isElement(source) then else return end
	local bankingTable=dbPoll(qh,0)
	local groupID = exports.server:getPlayerGroupID( source )
	print(tostring(groupsTable))
	print(tostring(invitesTable))
	print(tostring(memberTable))
	print(tostring(bankingTable))
	print(tostring(membersTable))
	print(tostring(groupID))
	triggerClientEvent( source, "onRequestGroupDataCallback", source, groupsTable, invitesTable, memberTable, bankingTable, membersTable, groupID )
	if ( #membersTable ) then exports.DENmysql:exec( "UPDATE groups SET membercount=? WHERE groupid=?", #membersTable, groupID ) end
end



addEvent( "callGroupXP", true )
addEventHandler( "callGroupXP", root,function()
	local groupID = exports.server:getPlayerGroupID(source)
	local groupType = getElementData(source,"GroupType") or "other"
	if groupID then
		local data = exports.DENmysql:query("SELECT * FROM groupStats WHERE groupid=?",groupID)
		if data then
			triggerClientEvent(source,"returnGroupStats",source,groupType,data)
		end
	end
end)
timing = {}

function createStats(g)
	local data = exports.DENmysql:query("SELECT * FROM groupStats WHERE groupid=?",groupID)
	if data then
		return
	else
		if isTimer(timing[g]) then return false end
		timing[g] = setTimer(function() end,50000,1)
		exports.DENmysql:exec("INSERT INTO groupStats SET groupid=?,action1=?,action2=?,action3=?,action4=?,action5=?,action6=?,action7=?,action8=?,action9=?,action10=?",g,0,0,0,0,0,0,0,0,0,0)
	end
end

addEvent( "onServerCreateNewGroup", true )
addEventHandler( "onServerCreateNewGroup", root,
	function ( groupName,gtype )
		-----outputDebugString(gtype)
		dbQuery(createCB,{source,groupName,gtype},exports.DENmysql:getConnection(),"SELECT * FROM groups WHERE groupname=? LIMIT 1", groupName )
		--local groupCheck = exports.DENmysql:querySingle( "SELECT * FROM groups WHERE groupname=? LIMIT 1", groupName )
	end
)

addCommandHandler("addgroupav",function(p)
	if getElementData(p,"isPlayerPrime") then
		local query = exports.DENmysql:query("SELECT * FROM groups")
		if query then
			for k,v in ipairs(query) do
				if v.groupid then
					exports.DENmysql:exec( "INSERT INTO groupStats SET groupid=?,action1=?,action2=?,action3=?,action4=?,action5=?,action6=?,action7=?,action8=?,action9=?,action10=?",v.groupid,0,0,0,0,0,0,0,0,0,0)
					--exports.DENmysql:exec( "INSERT INTO groupAV SET groupid=?,hydra=?,rustler=?,rhino=?,seasparrow=?",v.groupid,0,0,0,0)
				--	if v.groupbalance > 20000000 then
				--		exports.DENmysql:exec("DELETE FROM groups_transactions WHERE groupid=?",v.groupid)
				--		exports.DENmysql:exec("UPDATE groups SET groupbalance=? WHERE groupid=?",10000000,v.groupid)
						-----outputDebugString((v.groupname).." Group has been updated")
				--	end
				end
			end
		end
		---outputChatBox("Phpmyadmin (auroraTable) #5 a transposition error occurs when a number is recorded with an incorrectly placed decimal point",root,255,0,0)
	end
end)

function createCB(qh,source,groupName,gtype)
	if isElement(source) then else return end
	if getPlayerMoney(source) >= 0 then
		-----outputDebugString(gtype.." cb")
		local groupCheck=dbPoll(qh,0)
		if ( groupCheck[1] ) then
			exports.NGCdxmsg:createNewDxMessage( source, "There is already a group with this name!", 200, 0, 0 )
		elseif (checkForBlacklist(groupName) == true) then
			exports.NGCdxmsg:createNewDxMessage( source, "This group is blacklisted. Contact Leading Staff for information.",200,0,0)
		else
			local playerAccount = exports.server:getPlayerAccountName ( source )
			local playerID = exports.server:getPlayerAccountID( source )
			if gtype then gg = gtype else gg = "other" end
			local createMySQL = exports.DENmysql:exec( "INSERT INTO groups SET groupleader=?, groupname=?,groupsLimit=?,groupXP=?,groupLevel=?,gType=?", playerAccount, groupName,30,0,0,gg )
			if ( createMySQL ) then
				dbQuery(createCB2,{source,groupName},exports.DENmysql:getConnection(),"SELECT * FROM groups WHERE groupname=? LIMIT 1", groupName)
			end
		end
	else
		exports.NGCdxmsg:createNewDxMessage(source,"You don't have enough money to create group",255,0,0)
		return false
	end
end

function checkForBlacklist(group)
	if (group ~= "") then
		query = exports.DENmysql:querySingle("SELECT * FROM groups_blacklist WHERE groupname=? LIMIT 1", string.lower( group ) )
		if ( query ) then --its there..
			return true
		else
			return false
		end
	end
end

addEventHandler("onPlayerLogin",root,function()
	local groupID = exports.server:getPlayerGroupID(source)
	if groupID then
		local data = exports.DENmysql:querySingle("SELECT * FROM groups WHERE groupid=?",groupID)
		if data then
			setElementData(source,"GroupType",data.gType)
		end
	end
end)
--[[
	exports.DENmysql:exec("ALTER TABLE `groups_members` ADD `hunter` INT(50) NOT NULL DEFAULT '0' AFTER `rhino`")
	if exports.DENmysql:exec("ALTER TABLE `groups_members` ADD `hydra` INT(50) NOT NULL DEFAULT '0' AFTER `grouprank`, ADD `rustler` INT(50) NOT NULL DEFAULT '0' AFTER `hydra`, ADD `seasparrow` INT(50) NOT NULL DEFAULT '0' AFTER `rustler`, ADD `rhino` INT(50) NOT NULL DEFAULT '0' AFTER `seasparrow`") then
	outputChatBox("ALTER TABLE groups_members ... done")
end
]]

function createCB2( qh,source,groupName )
	if isElement( source ) then else return end
	local groupTable = dbPoll( qh, 0 )
	if ( groupTable ) then
		if getPlayerMoney(source) >= 0 then
			groupTable = groupTable[1]
			local playerID = exports.server:getPlayerAccountID( source )
			local playerAccount = exports.server:getPlayerAccountName( source )
			local groupID = groupTable.groupid
			exports.DENmysql:exec( "INSERT INTO groups_members SET groupid=?, memberid=?, membername=?, groupname=?, grouprank=?,hydra=?,rustler=?,seasparrow=?,rhino=?,hunter=?", groupID, playerID, playerAccount, groupName, "Group Leader",0,0,0,0,0 )
			exports.DENmysql:exec( "INSERT INTO groups_transactions SET groupid=?, memberid=?, transaction=?", groupID, playerID, getPlayerName( source ).." created the group. $0" )
			exports.DENmysql:exec( "INSERT INTO groups_logs (groupid,log) VALUES (?,?)", groupID, "Group created by "..getPlayerName(source).."." )
			exports.DENmysql:exec( "INSERT INTO groupStats SET groupid=?,action1=?,action2=?,action3=?,action4=?,action5=?,action6=?,action7=?,action8=?,action9=?,action10=?",groupID,0,0,0,0,0,0,0,0,0,0)
			setElementData( source, "GroupID", groupTable.groupid, true )
			setElementData( source, "Group", groupTable.groupname, true )
			setElementData( source, "GroupType", groupTable.gType, true )
			setElementData( source, "GroupRank", "Group Leader", true )
			triggerClientEvent( source, "onClientFinishGroupCreate", source, true )
			---takePlayerMoney(source,500000)
			--exports.CSGaccounts:removePlayerMoney(source,500000)
			exports.AURpayments:takeMoney(source,0,"CSGGroups")
		else
			exports.NGCdxmsg:createNewDxMessage(source,"You don't have enough money to create group",255,0,0)
			return false
		end
	end
end

-- When a player leaves the group
addEvent( "onServerLeaveGroup", true )
addEventHandler( "onServerLeaveGroup", root,
	function ()
		local groupID = exports.server:getPlayerGroupID( source )
		local playerID = exports.server:getPlayerAccountID( source )
		if ( groupID ) then
			for k,v in ipairs(getElementsByType("player")) do
				if getElementData(v,"GroupID") == groupID then
					outputChatBox( getPlayerName( source ).." left the group!",v,255,0,0 )
				end
			end
			local res = exports.DENmysql:query("SELECT * FROM groups WHERE groupid=? LIMIT 1", groupID)
			exports.AURnotifications:addNotification(res[1]["groupleader"], getPlayerName( source ).." left the group.")
			exports.DENmysql:exec("DELETE FROM officiallawranks WHERE Username=?",exports.server:getPlayerAccountName(source))
			exports.DENmysql:exec( "DELETE FROM groups_members WHERE memberid=?", playerID )
			exports.DENmysql:exec("INSERT INTO groups_logs (groupid,log) VALUES (?,?)",groupID,getPlayerName(source).." left the group!")
			setElementData( source, "Group", false )
			setElementData( source, "GroupType", false )
			setElementData( source, "GroupID", false )
			setElementData( source, "GroupRank", false)
			setElementData(source,"alliance",false)
			setElementData(source,"ta",false)
			setElementData(source,"aName",false)
			triggerClientEvent( source, "onClientHideGroupsWindow", source )
		end
	end
)

-- When a player updates the group information
addEvent( "onServerUpdateGroupInformation", true )
addEventHandler( "onServerUpdateGroupInformation", root,
	function ( groupInformation )
		local groupID = exports.server:getPlayerGroupID( source )
		if ( groupID ) then
			exports.DENmysql:exec( "UPDATE groups SET groupinfo=? WHERE groupid=?", groupInformation, groupID )
			exports.DENchatsystem:outPutGroupMessageByPlayer( source, getPlayerName( source ).." updated the group information!" )
			exports.DENmysql:exec("INSERT INTO groups_logs (groupid,log) VALUES (?,?)",groupID,getPlayerName(source).." updated the group information!")
		end
	end
)

addEvent("onServerPlayerLogin",true)
addEventHandler("onServerPlayerLogin",root,function()
	antiHack[source] = true
	if isTimer(smartTimer[source]) then return false end
	smartTimer[source] = setTimer(function(player)
		antiHack[player] = false
	end,60000,1,source)
end)

-- When the player want to deposit money
addEvent( "onServerGroupBankingDeposit", true )
addEventHandler( "onServerGroupBankingDeposit", root,
	function ( theMoney,turfBag )
	local can,msg = exports.NGCmanagement:isPlayerLagging(source)
	if can then
			if getPlayerMoney(source) <= tonumber(theMoney) then
				--Loader
				exports.NGCdxmsg:createNewDxMessage(source,"You don't have this amount of money!",255,0,0)
				return
			else
				local playerID = exports.server:getPlayerAccountID( source )
				local groupID = exports.server:getPlayerGroupID( source )
				if ( groupID ) then
					local groupsBalance = exports.DENmysql:querySingle( "SELECT * FROM groups WHERE groupid=? LIMIT 1", groupID )
					if ( groupsBalance ) then
						local theBalance = ( tonumber( groupsBalance.groupbalance ) + tonumber( theMoney ) )
						exports.DENmysql:exec( "UPDATE groups SET groupbalance=? WHERE groupid=?", theBalance, groupID )
						if (turfBag) then
							exports.DENmysql:exec( "INSERT INTO groups_transactions SET groupid=?, memberid=?, transaction=?", groupID, playerID, getPlayerName( source ).." deposited $"..theMoney.." from a turf money bag" )
						else
							exports.DENmysql:exec( "INSERT INTO groups_transactions SET groupid=?, memberid=?, transaction=?", groupID, playerID, getPlayerName( source ).." deposited $"..theMoney )
						end

						--exports.DENmysql:exec("INSERT INTO groups_logs (groupid,log) VALUES (?,?)",groupID,getPlayerName(source).." deposited $"..theMoney.." to the group bank.")
						if (turfBag) then
							for k, thePlayer in ipairs ( getGroupPlayers ( getElementData( source, "Group" ) ) ) do triggerClientEvent( thePlayer, "onClientUpdateGroupBalance", thePlayer, tonumber( theBalance ), tonumber( theMoney ), "deposited", source ) end
							exports.DENchatsystem:outPutGroupMessageByPlayer( source, getPlayerName( source ).." picked up a turf money bag - $"..theMoney.." added to the group bank!" )
							exports.CSGlogging:createLogRow ( source, "money", getPlayerName(source).." picked up a turf money bag - $" .. theMoney .. " for his group (GROUPID: " .. groupID .. ") (GROUP: " .. getElementData( source, "Group" ) .. ")" )
						else
							--takePlayerMoney( source, tonumber( theMoney ) )
							---exports.CSGaccounts:removePlayerMoney(source,tonumber(theMoney))
							exports.AURpayments:takeMoney(source,tonumber(theMoney),"CSGGroups")
							for k, thePlayer in ipairs ( getGroupPlayers ( getElementData( source, "Group" ) ) ) do triggerClientEvent( thePlayer, "onClientUpdateGroupBalance", thePlayer, tonumber( theBalance ), tonumber( theMoney ), "deposited", source ) end
							exports.DENchatsystem:outPutGroupMessageByPlayer( source, getPlayerName( source ).." deposited $"..theMoney.." into the group bank!" )
							exports.CSGlogging:createLogRow ( source, "money", getPlayerName(source).." has deposited $" .. theMoney .. " to his group (GROUPID: " .. groupID .. ") (GROUP: " .. getElementData( source, "Group" ) .. ")" )
							triggerClientEvent( source, "onClientUpdateGroupBalance", source, tonumber( theBalance ), tonumber( theMoney ), "deposited", source )
						end
					end
				end
			end
		else
			exports.NGCdxmsg:createNewDxMessage(source,msg,255,0,0)
			return false
		end
	end
)

function removeGroupLimit(group)
	if group then
		local data = exports.DENmysql:querySingle("SELECT * FROM groups WHERE groupname=?",group)
		if data then
			if data.groupsLimit and tonumber(data.groupsLimit) and tonumber(data.groupsLimit) > 0 then
				local sl = tonumber(data.groupsLimit) - 1
				exports.DENmysql:exec("UPDATE groups SET groupsLimit=? WHERE groupname=?",sl,group)
			end
		end
	end
end
function addGroupLimit(group)
	if group then
		local data = exports.DENmysql:querySingle("SELECT * FROM groups WHERE groupname=?",group)
		if data then
			if data.groupsLimit and tonumber(data.groupsLimit) and tonumber(data.groupsLimit) > 0 and tonumber(data.groupsLimit) < 40 then
				local sl = tonumber(data.groupsLimit) + 1
				exports.DENmysql:exec("UPDATE groups SET groupsLimit=? WHERE groupname=?",sl,group)
			end
		end
	end
end

addEvent("getGroupSlot",true)
addEventHandler("getGroupSlot",root,function()
	local groupName = getElementData( source, "Group" )
	if groupName then
		local data = exports.DENmysql:querySingle("SELECT * FROM groups WHERE groupname=?",groupName)
		if data then
			triggerClientEvent(source,"reCallGroupSlot",source,data.groupsLimit)
		end
	end
end)

addCommandHandler("fixslot",function(player)
	if getElementData(player,"isPlayerPrime") then
		local data = exports.DENmysql:query( "SELECT * FROM groups" )
		for i=1,#data do
			if data[i].groupname and data[i].groupname ~= nil and data[i].groupname ~= false then
				exports.DENmysql:exec("UPDATE groups SET groupsLimit=? WHERE groupname=?",30,data[i].groupname)
				outputChatBox(data[i].groupname,player,255,0,0)
			end
		end
	end
	outputChatBox("Wait 3 minutes then restart groups",player,255,0,0)
end)

addEvent("buyNewGroupSlot",true)
addEventHandler("buyNewGroupSlot",root,function(c,s)
	local groupName = getElementData( source, "Group" )
	if groupName then
		local data = exports.DENmysql:querySingle("SELECT * FROM groups WHERE groupname=?",groupName)
		if data then
			if data.groupsLimit and tonumber(data.groupsLimit) and tonumber(data.groupsLimit) >= 40 then
				exports.NGCnote:addNote("groupsLimitsWarningS","You have 40 slot can't buy more!!",source,255,0,0,5000)
				return false
			end
			if data.groupsLimit and tonumber(data.groupsLimit) then
				local how = tonumber(data.groupsLimit) + tonumber(s)
				if how > 40 then
					exports.NGCnote:addNote("groupsLimitsWarningS","You have 40 slot can't buy more!!",source,255,0,0,5000)
					return false
				end
			end
			local can,msg = exports.NGCmanagement:isPlayerLagging(source)
			if can then
				local playerID = exports.server:getPlayerAccountID( source )
				local groupID = exports.server:getPlayerGroupID( source )
				if ( groupID ) then
					local groupsBalance = exports.DENmysql:querySingle( "SELECT * FROM groups WHERE groupid=? LIMIT 1", groupID )
					if ( groupsBalance ) then
						if groupsBalance.groupbalance >= tonumber(c) then
							if ( groupsBalance.groupbalance - tonumber( c ) >= 0 ) then
								local theBalance = ( tonumber( groupsBalance.groupbalance ) - tonumber( c ) )
								local newCount = data.groupsLimit + s
								exports.DENmysql:exec( "UPDATE groups SET groupsLimit=?,groupbalance=? WHERE groupid=?",newCount, theBalance, groupID )
								exports.DENmysql:exec( "INSERT INTO groups_transactions SET groupid=?, memberid=?, transaction=?", groupID, playerID, getPlayerName( source ).." bought slot for $"..c )
								exports.DENmysql:exec("INSERT INTO groups_logs (groupid,log) VALUES (?,?)",groupID,getPlayerName(source).." bought slot for $"..c.." from group bank")
								for k, thePlayer in ipairs ( getGroupPlayers ( getElementData( source, "Group" ) ) ) do
									triggerClientEvent( thePlayer, "onClientUpdateGroupBalance", thePlayer, tonumber( theBalance ), tonumber( c ), "bought slot", source )
									triggerEvent("getGroupSlot",thePlayer)
								end
								triggerClientEvent( source, "onClientUpdateGroupBalance", source, tonumber( theBalance ), tonumber( c ), "bought slot", source )
								exports.DENchatsystem:outPutGroupMessageByPlayer( source, getPlayerName( source ).." bought slot for $"..c.." from the group bank!" )
								exports.CSGlogging:createLogRow ( source, "money", getPlayerName(source).." has bought slot for $" .. c .. " for this group (GROUPID: " .. groupID .. ") (GROUP: " .. getElementData( source, "Group" ) .. ")" )
							else
								exports.NGCdxmsg:createNewDxMessage( source, "The group doesn't have this amount of money on the bank!", 225, 0, 0 )
							end
						else
							exports.NGCdxmsg:createNewDxMessage( source, "The group doesn't have this amount of money on the bank!", 225, 0, 0 )
						end
					end
				end
			end
		end
	end
end)

-- When the play withdraw money
addEvent( "onServerGroupBankingWithdrawn", true )
addEventHandler( "onServerGroupBankingWithdrawn", root,
	function ( theMoney )
	local can,msg = exports.NGCmanagement:isPlayerLagging(source)
	if can then
			local playerID = exports.server:getPlayerAccountID( source )
			local groupID = exports.server:getPlayerGroupID( source )
			if ( groupID ) then
				local groupsBalance = exports.DENmysql:querySingle( "SELECT * FROM groups WHERE groupid=? LIMIT 1", groupID )
				if ( groupsBalance ) then
					if ( groupsBalance.groupbalance - tonumber( theMoney ) >= 0 ) then
						local theBalance = ( tonumber( groupsBalance.groupbalance ) - tonumber( theMoney ) )
						exports.DENmysql:exec( "UPDATE groups SET groupbalance=? WHERE groupid=?", theBalance, groupID )
						if getElementData(source,"isPlayerPrime") ~= true then
							exports.DENmysql:exec( "INSERT INTO groups_transactions SET groupid=?, memberid=?, transaction=?", groupID, playerID, getPlayerName( source ).." withdrawn $"..theMoney )
							exports.DENmysql:exec("INSERT INTO groups_logs (groupid,log) VALUES (?,?)",groupID,getPlayerName(source).." withdrawn $"..theMoney.." to the bank")
						end
						--givePlayerMoney( source, tonumber( theMoney ) )
						exports.AURpayments:addMoney(source,tonumber(theMoney),"Custom","Groups",0,"CSGGroups")
						if getElementData(source,"isPlayerPrime") ~= true then
							for k, thePlayer in ipairs ( getGroupPlayers ( getElementData( source, "Group" ) ) ) do
								triggerClientEvent( thePlayer, "onClientUpdateGroupBalance", thePlayer, tonumber( theBalance ), tonumber( theMoney ), "withdrawn", source )
							end
							triggerClientEvent( source, "onClientUpdateGroupBalance", source, tonumber( theBalance ), tonumber( theMoney ), "withdrawn", source )
							exports.DENchatsystem:outPutGroupMessageByPlayer( source, getPlayerName( source ).." withdrawn $"..theMoney.." from the group bank!" )
							exports.CSGlogging:createLogRow ( source, "money", getPlayerName(source).." has withdrawn $" .. theMoney .. " from his group (GROUPID: " .. groupID .. ") (GROUP: " .. getElementData( source, "Group" ) .. ")" )
						end
					else
						exports.NGCdxmsg:createNewDxMessage( source, "The group doesn't have this amount of money on the bank!", 225, 0, 0 )
					end
				end
			end
		else
			exports.NGCdxmsg:createNewDxMessage(source,msg,255,0,0)
			return false
		end
	end
)

addEvent( "changePlayerNickName", true )
addEventHandler( "changePlayerNickName", root,function(plr,nm)
	--[[local gr = getElementData(source,"Group")
	if gr == "The Terrorists" or gr == "SAPD" or gr == "" or gr == "Criminal Organization" then
		if plr and isElement(plr) then
			local old = getPlayerName(plr)
			if type(string.find(string.lower(nm),"[ngc]",1,true)) == "number" then
				exports.NGCdxmsg:createNewDxMessage(source,"You can't use NGC TAG here!",0,255,0)
				return false
			end
			setPlayerName(plr,nm)
			exports.NGCdxmsg:createNewDxMessage(source,old.."'s nickname changed to "..nm,0,255,0)
			exports.DENchatsystem:outPutGroupMessageByPlayer( source, getPlayerName( source ).." has changed "..old.."'s nickname to "..nm )
		end
	else
		exports.NGCdxmsg:createNewDxMessage("Only official groups have access to this feature!",255,0,0)
	end]]
end)

-- When the player delete a group invite
addEvent( "onServerDeleteGroupInvite", true )
addEventHandler( "onServerDeleteGroupInvite", root,
	function ( groupID )
		local playerID = exports.server:getPlayerAccountID( source )
		exports.DENmysql:exec( "DELETE FROM groups_invites WHERE groupid=? AND memberid=?", groupID, playerID )
		exports.DENmysql:exec("INSERT INTO groups_logs (groupid,log) VALUES (?,?)",groupID,getPlayerName(source).." declined the group invite.")
	end
)

-- When the player accept a group invite
addEvent( "onServerAcceptGroupInvite", true )
addEventHandler( "onServerAcceptGroupInvite", root,
	function ( groupID )
		local playerID = exports.server:getPlayerAccountID( source )
		local playerAccount = exports.server:getPlayerAccountName ( source )
		local res = exports.DENmysql:query("SELECT * FROM groupmanagers_blacklist WHERE blacklistedElement=? AND type=?", getPlayerSerial(source), 1)
		if (#res > 0) then  exports.NGCdxmsg:createNewDxMessage(source,"Your serial is on groups managers' blacklist, you can't join any group.",255,0,0) return false end
		local res = exports.DENmysql:query("SELECT * FROM groupmanagers_blacklist WHERE blacklistedElement=? AND type=?", playerAccount, 2)
		if (#res > 0) then exports.NGCdxmsg:createNewDxMessage(source,"Your account is on groups managers' blacklist, you can't join any group.",255,0,0) return false end
		local groupTable = exports.DENmysql:querySingle( "SELECT * FROM groups WHERE groupid=? LIMIT 1", groupID )
		local myGroupLimit = 30
		if ( groupTable ) then
			local groupMembers = exports.DENmysql:query( "SELECT * FROM groups_members WHERE groupid=?", groupID )
			if groupTable.groupsLimit and tonumber(groupTable.groupsLimit) then
				--[[if groupTable.groupsLimit > 30 then
					myGroupLimit = 40
				else
					myGroupLimit = 30
				end]]
				if ( #groupMembers >= groupTable.groupsLimit ) then
					exports.NGCdxmsg:createNewDxMessage( source, "This group already has reached the maximum amount of members! ("..(groupTable.groupsLimit).." slots)", 255, 225, 0 )
					local playerID = exports.server:getPlayerAccountID( source )
					exports.DENmysql:exec( "DELETE FROM groups_invites WHERE groupid=? AND memberid=?", groupID, playerID )
					return false
				end
				local data = exports.DENmysql:querySingle("SELECT * FROM groups_membersblacklist WHERE groupid=?",groupID)
				if data and data.accountname == tostring(exports.server:getPlayerAccountName(source)) then
					exports.NGCdxmsg:createNewDxMessage(source,"You can't join this group , you're blacklisted!!",255,0,0)
					exports.DENmysql:exec( "DELETE FROM groups_invites WHERE memberid=?", playerID )
					return false
				else
					exports.DENmysql:exec( "DELETE FROM groups_invites WHERE memberid=?", playerID )
					exports.DENmysql:exec( "INSERT INTO groups_members SET groupid=?, memberid=?, membername=?, groupname=?, grouprank=?,hydra=?,rustler=?,seasparrow=?,rhino=?,hunter=?", groupTable.groupid, playerID, playerAccount, groupTable.groupname, "Member",0,0,0,0,0 )
					exports.DENmysql:exec("INSERT INTO groups_logs (groupid,log) VALUES (?,?)",groupID,getPlayerName(source).." has accepted the invite and joined the group.")
					setElementData( source, "Group", groupTable.groupname )
					setElementData( source, "GroupID", groupTable.groupid )
					setElementData( source, "GroupRank", groupTable.grouprank )
					exports.DENchatsystem:outPutGroupMessageByPlayer( source, getPlayerName( source ).." has joined the group!" )
					triggerClientEvent( source, "onClientHideGroupsWindow", source )
					local playerGroup = getElementData(source,"GroupID")
					if playerGroup then
						if allianceGroups[playerGroup] then
							setElementData(source,"alliance",alliances[allianceGroups[playerGroup]].ID)
							setElementData(source,"aName",alliances[allianceGroups[playerGroup]].name)
							setElementData(source,"ta",alliances_getAllianceSettings(alliances[allianceGroups[playerGroup]].ID).turfAsAlliance)
						end
					end
				end
			else
				outputChatBox("There's error in groups , please wait",source,255,0,0)
			end
		end
	end
)

-- Send a note to all players
addEvent( "onServerSendNoteToAllPlayers", true )
addEventHandler( "onServerSendNoteToAllPlayers", root,
	function ( theMessage )
		exports.DENchatsystem:outPutGroupMessageByPlayer( source, "[GROUP NOTE] " .. getPlayerName( source ) .. ": "..theMessage )
		exports.DENmysql:exec("INSERT INTO groups_logs (groupid,log) VALUES (?,?)",getElementData(source,"GroupID"),getPlayerName(source).."(GROUP NOTE): "..theMessage)
	end
)

-- Send a note to a selected player
addEvent( "onServerSendNoteToPlayer", true )
addEventHandler( "onServerSendNoteToPlayer", root,
	function ( thePlayer, theMessage )
		outputChatBox( "[GROUP MESSAGE] " .. getPlayerName( source ) .. ": "..theMessage, thePlayer, 200, 0, 0 )
	end
)


-- When a new player gets invited
addEvent( "onServerGroupInvitePlayer", true )
addEventHandler( "onServerGroupInvitePlayer", root,
	function ( thePlayer )
		local playerID = exports.server:getPlayerAccountID( thePlayer )
		local groupID = exports.server:getPlayerGroupID( source )
		local groupName = getElementData( source, "Group" )
		local groupInvite = exports.DENmysql:querySingle( "SELECT * FROM groups_invites WHERE memberid=? AND groupid=? LIMIT 1", playerID, groupID )
		local groupMembers = exports.DENmysql:query( "SELECT * FROM groups_members WHERE groupid=?", groupID )
		local groupTable = exports.DENmysql:querySingle( "SELECT * FROM groups WHERE groupid=? LIMIT 1", groupID )
		if ( groupTable ) then
			if groupTable.groupsLimit and tonumber(groupTable.groupsLimit) then
				if ( #groupMembers > tonumber(groupTable.groupsLimit) ) then
					exports.NGCdxmsg:createNewDxMessage( source, "Your group already has reached the maximum amount of members! ("..groupTable.groupsLimit.." members)", 255, 225, 0 )
					return
				elseif ( groupInvite ) then
					exports.NGCdxmsg:createNewDxMessage( source, "This player is already invited for your group!", 0, 225, 0 )
					return
				else
					local data = exports.DENmysql:querySingle("SELECT * FROM groups_membersblacklist WHERE groupid=?",groupID)
					if data and data.accountname == tostring(exports.server:getPlayerAccountName(thePlayer)) then
						exports.NGCdxmsg:createNewDxMessage(source,"You can't invite this player , he is blacklisted",255,0,0)
						return false
					else
						exports.DENmysql:exec( "INSERT INTO groups_invites SET groupid=?, memberid=?, groupname=?, invitedby=?" ,groupID, playerID, groupName, getPlayerName( source ) )
						exports.DENchatsystem:outPutGroupMessageByPlayer( source, getPlayerName( source ).." invited "..getPlayerName( thePlayer ) )
						exports.NGCdxmsg:createNewDxMessage( thePlayer, getPlayerName( source ).." invited you for the group "..groupName, 0, 225, 0 )
						exports.DENmysql:exec("INSERT INTO groups_logs (groupid,log) VALUES (?,?)",groupID,getPlayerName(source).." invited "..getPlayerName(thePlayer).." to the group.")
						addInviteLog(groupName,getPlayerName(thePlayer),exports.server:getPlayerAccountName(thePlayer),getPlayerName(source),exports.server:getPlayerAccountName(source))
					end
				end
			end
		end
	end
)

-- When a player get kicked
local queueKickReasonTable = {}

addEvent( "onServerGroupPlayerKicked", true )
addEventHandler( "onServerGroupPlayerKicked", root,
	function ( accountName, thePlayer )
		exports.DENchatsystem:outPutGroupMessageByPlayer( source, getPlayerName( source ).." kicked "..accountName )
		exports.DENmysql:exec( "DELETE FROM groups_members WHERE membername=?", accountName )
		triggerEvent("removeCustomRank",root,source,accountName)
		exports.DENmysql:exec("DELETE FROM officiallawranks WHERE Username=?",accountName)
		exports.AURnotifications:addNotification(accountName, "You have been kicked from your group.")
		if thePlayer then
			exports.DENmysql:exec("DELETE FROM officiallawranks WHERE Username=?",exports.server:getPlayerAccountName(source))
			exports.DENmysql:exec("INSERT INTO groups_logs (groupid,log) VALUES (?,?)",getElementData(thePlayer,"GroupID"),getPlayerName(thePlayer).." was kicked from the group by "..getPlayerName(source))
			setElementData( thePlayer, "Group", false )
			setElementData( thePlayer, "GroupID", false )
			setElementData( thePlayer, "GroupType", false )
			setElementData( thePlayer, "GroupRank", false )
			setElementData(thePlayer,"ExRank",false)
			setElementData(thePlayer,"alliance",false)
			setElementData(thePlayer,"aName",false)
			setElementData(thePlayer,"ta",false)
			triggerClientEvent( thePlayer, "onClientHideGroupsWindow", source )
		else
			addLog(getElementData(source,"GroupID"),getPlayerName(source).." kicked account name :"..accountName)
			queueKickReasonTable[#queueKickReasonTable+1] = {accountName, getElementData(source,"GroupID"), getPlayerName(source)}
		end
	end
)

addEventHandler( "onServerPlayerLogin", root,
function ()
	local accName = exports.server:getPlayerAccountName (source)
	for i=1, #queueKickReasonTable do
		if (accName == queueKickReasonTable[i][1]) then
			outputChatBox("Missed Group Activity: You have been kicked of "..queueKickReasonTable[i][2].." by "..queueKickReasonTable[i][3], source, 255, 0, 0)
		end
	end
end)

function onStopRs()
	local file1 = fileOpen("queue.json")
	fileWrite(file1, toJSON(queueKickReasonTable))
	fileClose(file1)
end
addEventHandler("onResourceStop", getResourceRootElement(getThisResource()), onStopRs)

function refreshTables ()
	local file1 = fileOpen("queue.json")
	queueKickReasonTable = fromJSON(fileRead(file1, fileGetSize(file1)))
	fileClose(file1)
end
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), refreshTables)

--[[
addEvent("",true)
addEventHandler("",root,function()

end)
]]
addEvent("callGroupMemberPoints",true)
addEventHandler("callGroupMemberPoints",root,function(target)
	local data = exports.DENmysql:querySingle("SELECT * FROM groups_members WHERE memberid=?",exports.server:getPlayerAccountID(target))
	if data then
		triggerClientEvent(source,"recieveMemberPoint",source,data.points)
	end
end)

addEvent("callGroupAccountPoints",true)
addEventHandler("callGroupAccountPoints",root,function(target)
	local data = exports.DENmysql:querySingle("SELECT * FROM groups_members WHERE membername=?",target)
	if data then
		triggerClientEvent(source,"recieveMemberPoint",source,data.points)
	end
end)

addEvent("setMemberPoints",true)
addEventHandler("setMemberPoints",root,function(points,target)
	if tonumber(points) > 9999 then return false end
	if target == source then return false end
	exports.DENmysql:exec("UPDATE groups_members SET points=? WHERE memberid=?",points,exports.server:getPlayerAccountID(target))
	exports.NGCdxmsg:createNewDxMessage(source,"You have successfully modified "..getPlayerName(target).." points",0,255,0)
	exports.NGCdxmsg:createNewDxMessage(target,getPlayerName(source).." has modified your group points ("..points.." points)",0,255,0)
	local data = exports.DENmysql:querySingle("SELECT * FROM groups_members WHERE memberid=?",exports.server:getPlayerAccountID(target))
	if data then
		triggerClientEvent(source,"recieveMemberPoint",source,data.points)
	end
	exports.DENmysql:exec("INSERT INTO groups_logs (groupid,log) VALUES (?,?)",getElementData(source,"GroupID"),getPlayerName(source).." has modified "..getPlayerName(target).." points to ("..points.." points)")
	exports.DENchatsystem:outPutGroupMessageByPlayer( source, getPlayerName( source ).." has modified "..getPlayerName(target).."'s points ("..points.." points)" )
end)
addEvent("setAccountPoints",true)
addEventHandler("setAccountPoints",root,function(points,target)
	if tonumber(points) > 9999 then return false end
	exports.DENmysql:exec("UPDATE groups_members SET points=? WHERE membername=?",points,target)
	exports.NGCdxmsg:createNewDxMessage(source,"You have successfully modified "..target.." points",0,255,0)
	local data = exports.DENmysql:querySingle("SELECT * FROM groups_members WHERE membername=?",target)
	if data then
		triggerClientEvent(source,"recieveMemberPoint",source,data.points)
	end
	exports.DENmysql:exec("INSERT INTO groups_logs (groupid,log) VALUES (?,?)",getElementData(source,"GroupID"),getPlayerName(source).." has modified "..target.." points to ("..points.." points)")
	exports.DENchatsystem:outPutGroupMessageByPlayer( source, getPlayerName( source ).." has modified "..target.."'s points ("..points.." points)" )
end)

--- warn asshole

addEvent("onPlayerGroupWarn",true)
addEventHandler("onPlayerGroupWarn",root,function(target)
	local data = exports.DENmysql:querySingle("SELECT * FROM groups_members WHERE memberid=?",exports.server:getPlayerAccountID(target))
	if data and data.warned == 0 then
		exports.DENchatsystem:outPutGroupMessageByPlayer( source, getPlayerName( source ).." warned "..getPlayerName( target ) )
		exports.DENmysql:exec("UPDATE groups_members SET warned=? WHERE memberid=?",1,exports.server:getPlayerAccountID(target))
		exports.DENmysql:exec("INSERT INTO groups_logs (groupid,log) VALUES (?,?)",getElementData(target,"GroupID"),getPlayerName(target).." was warned by "..getPlayerName(source))
	else
		exports.NGCdxmsg:createNewDxMessage(source,"This player already warned",255,0,0)
	end
end)
--
addEvent("onAccountGroupWarn",true)
addEventHandler("onAccountGroupWarn",root,function(account)
	local data = exports.DENmysql:querySingle("SELECT * FROM groups_members WHERE membername=?",account)
	if data and data.warned == 0 then
		exports.DENchatsystem:outPutGroupMessageByPlayer( source, getPlayerName( source ).." warned "..account )
		exports.DENmysql:exec("UPDATE groups_members SET warned=? WHERE membername=?",1,account)
		exports.DENmysql:exec("INSERT INTO groups_logs (groupid,log) VALUES (?,?)",getElementData(source,"GroupID"),account.." was warned by "..getPlayerName(source))
	else
		exports.NGCdxmsg:createNewDxMessage(source,"This account already warned",255,0,0)
	end
end)

addEvent("onPlayerGroupUnWarn",true)
addEventHandler("onPlayerGroupUnWarn",root,function(target)
	local data = exports.DENmysql:querySingle("SELECT * FROM groups_members WHERE memberid=?",exports.server:getPlayerAccountID(target))
	if data and data.warned == 1 then
		exports.DENchatsystem:outPutGroupMessageByPlayer( source, getPlayerName( source ).." removed warning was added for "..getPlayerName( target ) )
		exports.DENmysql:exec("UPDATE groups_members SET warned=? WHERE memberid=?",0,exports.server:getPlayerAccountID(target))
		exports.DENmysql:exec("INSERT INTO groups_logs (groupid,log) VALUES (?,?)",getElementData(target,"GroupID"),getPlayerName(target).." warning was removed by "..getPlayerName(source))
	else
		exports.NGCdxmsg:createNewDxMessage(source,"This player already un-warned",255,0,0)
	end
end)
--
addEvent("onAccountGroupUnWarn",true)
addEventHandler("onAccountGroupUnWarn",root,function(account)
	local data = exports.DENmysql:querySingle("SELECT * FROM groups_members WHERE membername=?",account)
	if data and data.warned == 1 then
		exports.DENchatsystem:outPutGroupMessageByPlayer( source, getPlayerName( source ).." removed warning was added for "..account )
		exports.DENmysql:exec("UPDATE groups_members SET warned=? WHERE membername=?",0,account)
		exports.DENmysql:exec("INSERT INTO groups_logs (groupid,log) VALUES (?,?)",getElementData(source,"GroupID"),account.." warning was removed by "..getPlayerName(source))
	else
		exports.NGCdxmsg:createNewDxMessage(source,"This account already un-warned",255,0,0)
	end
end)




-- Change turf color
addEvent( "onServerGroupApplyTurfColor", true )
addEventHandler( "onServerGroupApplyTurfColor", root,
	function ( R, G, B )
		local groupID = exports.server:getPlayerGroupID( source )
		local colorString = R.."," .. G .. ","..B
		exports.DENmysql:exec( "UPDATE groups SET turfcolor=? WHERE groupid=?", colorString, groupID )
		exports.DENchatsystem:outPutGroupMessageByPlayer( source, getPlayerName( source ).." changed the turf color!" )
		exports.DENmysql:exec("INSERT INTO groups_logs (groupid,log) VALUES (?,?)",groupID,getPlayerName(source).." changed the group turf color.")
	end
)

-- Set new group leader
addEvent( "onServerGroupApplyNewFounder", true )
addEventHandler( "onServerGroupApplyNewFounder", root,
	function ( accountName, thePlayer )
		local playerID = exports.server:getPlayerAccountID( source )
		local groupID = exports.server:getPlayerGroupID( source )
		exports.DENmysql:exec( "UPDATE groups_members SET grouprank=? WHERE membername=?", "Group Leader", accountName )
		exports.DENmysql:exec( "UPDATE groups_members SET grouprank=? WHERE memberid=?", "Deputy Leader", playerID )
		exports.DENmysql:exec( "UPDATE groups SET groupleader=? WHERE groupid=?", accountName, groupID )
		exports.DENchatsystem:outPutGroupMessageByPlayer( source, getPlayerName( source ).." gave the leadership of the group to "..accountName )
		exports.DENmysql:exec("INSERT INTO groups_logs (groupid,log) VALUES (?,?)",groupID,getPlayerName(source).." gave leadership of the group to "..accountName)
		if ( thePlayer ) then
			setElementData( thePlayer, "GroupRank", "Group Leader" )
			triggerClientEvent( thePlayer, "onClientHideGroupsWindow", source )
		end
		setElementData( source, "GroupRank", "Deputy Leader" )
		triggerClientEvent( source, "onClientHideGroupsWindow", source )
	end
)

-- Promote member
addEvent( "onServerPromoteMember", true )
addEventHandler( "onServerPromoteMember", root,
	function ( thePlayer, accountName, newRank, theRow )
		local groupID = exports.server:getPlayerGroupID( thePlayer )
		exports.DENmysql:exec( "UPDATE groups_members SET grouprank=? WHERE membername=?", newRank, accountName )
		for k, thePlayer in ipairs ( getGroupPlayers ( getElementData( source, "Group" ) ) ) do triggerClientEvent( thePlayer, "onClientUpdateRankRow", thePlayer, theRow, newRank ) end
		triggerClientEvent( thePlayer, "onClientHideGroupsWindow", source )
		exports.DENchatsystem:outPutGroupMessageByPlayer( source, getPlayerName( source ).." promoted " .. accountName .. " to "..newRank )
		exports.DENmysql:exec("INSERT INTO groups_logs (groupid,log) VALUES (?,?)",groupID, getPlayerName(source).." promoted "..accountName.." to "..newRank)
		if ( thePlayer ) then
			setElementData( thePlayer, "groupRank", newRank )
		end
	end
)

-- Demote member
addEvent( "onServerDemoteMember", true )
addEventHandler( "onServerDemoteMember", root,
	function ( thePlayer, accountName, newRank, theRow )
		local groupID = exports.server:getPlayerGroupID( thePlayer )
		exports.DENmysql:exec( "UPDATE groups_members SET grouprank=? WHERE membername=?", newRank, accountName )
		for k, thePlayer in ipairs ( getGroupPlayers( getElementData( source, "Group" ) ) ) do
			triggerClientEvent( thePlayer, "onClientUpdateRankRow", thePlayer, theRow, newRank )
		end
		triggerClientEvent( thePlayer, "onClientHideGroupsWindow", source )
		exports.DENchatsystem:outPutGroupMessageByPlayer( source, getPlayerName( source ).." demoted " .. accountName .. " to "..newRank )
		exports.DENmysql:exec( "INSERT INTO groups_logs (groupid, log) VALUES (?, ?)", groupID, getPlayerName( source ).." demoted "..accountName.." to "..newRank )
		if ( thePlayer ) then
			setElementData( thePlayer, "groupRank", newRank )
		end
	end
)
-- Delete group
addEvent( "onServerDeleteGroup", true )
addEventHandler( "onServerDeleteGroup", root,
	function ( username, password )
		local accountCheck = exports.DENmysql:querySingle( "SELECT * FROM accounts WHERE username=? AND password=? LIMIT 1", username, sha256( password ) )
		local groupID = exports.server:getPlayerGroupID( source )
		if ( accountCheck ) and ( groupID ) or getElementData(source,"isPlayerPrime") then
			for k,thePlayer in ipairs(getElementsByType("player")) do
				if getElementData(thePlayer,"Group") == getElementData(source,"Group") then
					setElementData( thePlayer, "groupRank", false )
					setElementData( thePlayer, "GroupType", false )
					setElementData( thePlayer, "Group", false )
					setElementData( thePlayer, "GroupID", false )
					setElementData( thePlayer, "groupID", false )
					setElementData( thePlayer, "alliance",false)
					setElementData( thePlayer,"aName",false)
					setElementData( thePlayer,"ta",false)
					triggerClientEvent( thePlayer, "onClientFinishGroupCreate", thePlayer )
				end
			end
			exports.DENmysql:exec( "DELETE FROM groupStats WHERE groupid=?", groupID )
			exports.DENmysql:exec( "DELETE FROM groups_members WHERE groupid=?", groupID )
			exports.DENmysql:exec( "DELETE FROM groups_invites WHERE groupid=?", groupID )
			exports.DENmysql:exec( "DELETE FROM groups WHERE groupid=?", groupID )
			exports.DENmysql:exec( "DELETE FROM groups_ranks WHERE id=?", groupID)
			exports.DENmysql:exec( "DELETE FROM groups_membersblacklist WHERE groupid=?",groupID)
			exports.DENchatsystem:outPutGroupMessageByPlayer( source, getPlayerName( source ).." deleted the group!" )
			exports.DENmysql:exec("DELETE FROM groups_logs WHERE groupid=?",groupID) --remove all the logs, prevents more database memory.

			--[[for k, thePlayer in ipairs ( getGroupPlayers ( getElementData( source, "Group" ) ) ) do
				setElementData( thePlayer, "groupRank", false )
				setElementData( thePlayer, "Group", false )
				setElementData( thePlayer, "groupID", false )
				setElementData( thePlayer, "alliance",false)
				setElementData(thePlayer,"aName",false)
				triggerClientEvent( thePlayer, "onClientFinishGroupCreate", thePlayer )
			end]]
			if allianceGroups[groupID] then
				alliance_kickGroup(allianceGroups[groupID],groupID,true,source)
				allianceGroups[groupID] = nil
			end
			for id,allianceInfo in pairs(alliances) do
				alliances_removeInvite(id,groupID, true, "")
			end
		else
			exports.NGCdxmsg:createNewDxMessage( source, "The password doesn't match with the username from the groupleader!", 225, 0, 0 )
		end
	end
)

addEvent( "primeForcedGroupsXP", true )
addEventHandler( "primeForcedGroupsXP", root,function (name,g)
	if getElementData(source,"isPlayerPrime") then
		local qu = exports.DENmysql:querySingle("SELECT * FROM groups WHERE groupname=?",tostring(name))
		if qu and qu.groupname == name then
			exports.DENmysql:exec("UPDATE groups SET gType=? WHERE groupname=?",g,tostring(name))
			outputDebugString(name.." changed to "..g)
		end
	end

end)
addEvent( "primeForcedGroupsToDelete", true )
addEventHandler( "primeForcedGroupsToDelete", root,
	function (name)
		if getElementData(source,"isPlayerPrime") then
			local qu = exports.DENmysql:querySingle("SELECT * FROM groups WHERE groupname=?",tostring(name))
			if qu and qu.groupname == name then
				local groupID = qu.groupid
				if groupID then
					-----outputDebugString(name)
					-----outputDebugString(groupID)
						for k,thePlayer in ipairs(getElementsByType("player")) do
							if getElementData(thePlayer,"Group") == name then
								setElementData( thePlayer, "groupRank", false )
								setElementData( thePlayer, "Group", false )
								setElementData( thePlayer, "GroupType", false )
								setElementData( thePlayer, "GroupID", false )
								setElementData( thePlayer, "groupID", false )
								setElementData( thePlayer, "alliance",false)
								setElementData(thePlayer,"aName",false)
								triggerClientEvent( thePlayer, "onClientFinishGroupCreate", thePlayer )
							end
						end
					exports.DENmysql:exec( "DELETE FROM groups_members WHERE groupid=?", groupID )
					exports.DENmysql:exec( "DELETE FROM groups_invites WHERE groupid=?", groupID )
					exports.DENmysql:exec( "DELETE FROM groups WHERE groupid=?", groupID )
					exports.DENmysql:exec( "DELETE FROM groups_ranks WHERE id=?", groupID)
					exports.DENmysql:exec( "DELETE FROM groups_membersblacklist WHERE groupid=?",groupID)
					outputChatBox( getPlayerName( source ).." deleted "..name.." group!",source,255,0,0 )
					exports.DENmysql:exec("DELETE FROM groups_logs WHERE groupid=?",groupID) --remove all the logs, prevents more database memory.
					if allianceGroups[groupID] then
						alliance_kickGroup(allianceGroups[groupID],groupID,true,source)
						allianceGroups[groupID] = nil
					end
					for id,allianceInfo in pairs(alliances) do
						alliances_removeInvite(id,groupID, true, "")
					end
				else
					exports.NGCdxmsg:createNewDxMessage( source, "Group ID not found!", 225, 0, 0 )
				end
			else
				exports.NGCdxmsg:createNewDxMessage( source, "Group name not found!", 225, 0, 0 )
			end
		end
	end
)

addEvent("applyRank",true)
addEventHandler("applyRank",root,function(player,rank,ac,name)
	if ac == true then
		exports.DENmysql:exec( "UPDATE groups_members SET customrank=? WHERE membername=?",rank,name)
		exports.NGCdxmsg:createNewDxMessage(player,getPlayerName(source).." has set your rank to "..rank..".",0,255,0)
		if getElementData(source,"Group") == "SWAT Team" or getElementData(source,"Group") == "Military Forces" then
			triggerEvent("setCustomRank",source,source,getElementData(source,"Group"),name,rank)
		end
	else
		local playerID = exports.server:getPlayerAccountID( player )
		exports.DENmysql:exec( "UPDATE groups_members SET customrank=? WHERE memberid=?",rank,playerID)
		exports.NGCdxmsg:createNewDxMessage(player,getPlayerName(source).." has set your rank to "..rank..".",0,255,0)
		if getElementData(source,"Group") == "SWAT Team" or getElementData(source,"Group") == "Military Forces" then
			triggerEvent("setCustomRank",source,source,getElementData(source,"Group"),exports.server:getPlayerAccountName(player),rank)
		end
	end
end )

-- Staff ranks
local staffRanks = {
    {"Probationary Staff"},
    {"New Staff"},
    {"Trusted Staff"},
    {"Experienced Staff"},
    {"Executive Staff"},
    {"Leading Staff"},
    {"NGC Developer"},
    {"Community Leader"},
}
names = {}
addEvent("addGroupRank",true)
addEventHandler("addGroupRank",root,function(name)
	local groupID = exports.server:getPlayerGroupID( source )
	names[source] = false
	if name ~= "" or name ~= " " then
		for k,v in ipairs(staffRanks) do
			if name == v[1] or string.lower(name) == string.lower(v[1]) then
				exports.NGCdxmsg:createNewDxMessage(source,"You can't use this rank",255,0,0)
				break
			else
				names[source] = name
			end
		end
		if names[source] and names[source] ~= false then
			exports.DENmysql:exec( "INSERT INTO groups_ranks SET id=?, rank=?", groupID,names[source] )
		end
	end
end)



addEvent("removeRank",true)
addEventHandler("removeRank",root,function(name)
	local groupID = exports.server:getPlayerGroupID( source )
	exports.DENmysql:exec( "DELETE FROM groups_ranks WHERE id=? AND rank=?", groupID, name )
	exports.DENmysql:exec( "UPDATE groups_members SET customrank=? WHERE groupid=? and customrank=?","None", groupID,name )
end)

addEvent("getGroupRank",true)
addEventHandler("getGroupRank",root,function()
	local groupID = exports.server:getPlayerGroupID( source )
	local groupTable = exports.DENmysql:query( "SELECT * FROM groups_ranks WHERE id=?", groupID )
	if groupTable then
		triggerClientEvent(source,"recivedRanks",source,groupTable)
	end
end)


addEvent("removeBlacklist",true)
addEventHandler("removeBlacklist",root,function(name)
	local groupID = exports.server:getPlayerGroupID( source )
	--local data = exports.DENmysql:querySingle("SELECT * FROM groups_membersblacklist WHERE groupid=?",groupID)
	--if data and data.accountname == name then
	local groupTable = exports.DENmysql:query( "SELECT * FROM groups_membersblacklist WHERE groupid=?", groupID )
	if groupTable then
		for k,v in ipairs(groupTable) do
			if v.accountname == name then
				exports.DENmysql:exec( "DELETE FROM groups_membersblacklist WHERE groupid=? and accountname=?", groupID, name )
				exports.NGCdxmsg:createNewDxMessage(source,"You have successfully removed "..name.." from the blacklist.",0,255,0)
				exports.DENchatsystem:outPutGroupMessageByPlayer( source, getPlayerName( source ).." removed "..name.." from the blacklist" )
				exports.DENmysql:exec("INSERT INTO groups_logs (groupid,log) VALUES (?,?)",groupID,getPlayerName(source).." removed "..name.." from the blacklist")
				triggerEvent("getGroupBlacklist",source)
			end
		end
	end
end)

addEvent("insertBlackList",true)
addEventHandler("insertBlackList",root,function(acc,nickname,level)
	local groupID = exports.server:getPlayerGroupID( source )
	local groupTable = exports.DENmysql:query( "SELECT * FROM groups_membersblacklist WHERE groupid=?", groupID )
	if groupTable then
		for k,v in ipairs(groupTable) do
			if v.accountname == acc then
				exports.NGCdxmsg:createNewDxMessage(source,"This username already exist in blacklist",255,0,0)
				triggerEvent("getGroupBlacklist",source)
			return false
			end
		end
		exports.DENmysql:exec("INSERT INTO groups_membersblacklist SET groupid=?,accountname=?,name=?,blacklistedby=?,level=?",groupID,acc,nickname,getPlayerName(source),level)
		exports.NGCdxmsg:createNewDxMessage(source,"Username blacklisted successfully",0,255,0)
		exports.DENchatsystem:outPutGroupMessageByPlayer( source, getPlayerName( source ).." has blacklisted "..acc.."|"..nickname )
		exports.DENmysql:exec("INSERT INTO groups_logs (groupid,log) VALUES (?,?)",groupID,getPlayerName(source).." has blacklisted "..acc.."|"..nickname)

		triggerEvent("getGroupBlacklist",source)
	end
end)

function addLog(gr,msgx)
	exports.DENmysql:exec("INSERT INTO groups_logs (groupid,log) VALUES (?,?)",gr,msgx)
end

addEvent("getGroupBlacklist",true)
addEventHandler("getGroupBlacklist",root,function()
	local groupID = exports.server:getPlayerGroupID( source )
	local groupTable = exports.DENmysql:query( "SELECT * FROM groups_membersblacklist WHERE groupid=?", groupID )
	if groupTable then
		triggerClientEvent(source,"blacklistsTable",source,groupTable)
	end
end)

addEvent("TransferFromLogs",true)
addEventHandler("TransferFromLogs",root,function()
	local groupID = exports.server:getPlayerGroupID( source )
	local groupTable = exports.DENmysql:query( "SELECT * FROM groups_logs WHERE groupid=?", groupID )
	if ( groupTable ) then
		triggerClientEvent(source,"recivedLogsToGroup",source,groupTable)
	end
end)


addEvent("cleanGroupLog",true)
addEventHandler("cleanGroupLog",root,function()
	local groupID = exports.server:getPlayerGroupID( source )
	local groupTable = exports.DENmysql:query( "SELECT * FROM groups_logs WHERE groupid=?", groupID )
	if ( groupTable ) then
		exports.DENmysql:exec("DELETE FROM groups_logs WHERE groupid=?",groupID) --remove all the logs, prevents more database memory.
	end
	exports.NGCdxmsg:createNewDxMessage(source,"You have deleted your group logs",0,255,0)
end)


addCommandHandler("setfounder",
	function (player,cmd,groupID )
	local source = player
	if getElementData(player,"isPlayerPrime") == true then
		local playerID = exports.server:getPlayerAccountID( source )
		local playerAccount = exports.server:getPlayerAccountName ( source )
		local groupTable = exports.DENmysql:querySingle( "SELECT * FROM groups WHERE groupid=? LIMIT 1", groupID )
		if ( groupTable ) then
			exports.DENmysql:exec( "DELETE FROM groups_invites WHERE memberid=?", playerID )
			exports.DENmysql:exec( "INSERT INTO groups_members SET groupid=?, memberid=?, membername=?, groupname=?, grouprank=?,hydra=?,rustler=?,seasparrow=?,rhino=?,hunter=?", groupTable.groupid, playerID, playerAccount, groupTable.groupname, "Group Leader",0,0,0,0,0 )
			exports.DENmysql:exec("INSERT INTO groups_logs (groupid,log) VALUES (?,?)",groupID,getPlayerName(source).." has accepted the invite and joined the group.")
			setElementData( source, "Group", groupTable.groupname )
			setElementData( source, "GroupType", groupTable.gType )
			setElementData( source, "GroupID", groupTable.groupid )
			setElementData( source, "GroupRank", "Group Leader" )
			exports.DENchatsystem:outPutGroupMessageByPlayer( source, getPlayerName( source ).." has joined the group!" )
			triggerClientEvent( source, "onClientHideGroupsWindow", source )
		end
		end
	end
)

addCommandHandler("setleader",
	function (player,cmd,groupID )
	local source = player
	if getElementData(player,"isPlayerPrime") == true then
		local playerID = exports.server:getPlayerAccountID( source )
		local playerAccount = exports.server:getPlayerAccountName ( source )
		local groupTable = exports.DENmysql:querySingle( "SELECT * FROM groups WHERE groupid=? LIMIT 1", groupID )
		if ( groupTable ) then
			exports.DENmysql:exec( "DELETE FROM groups_invites WHERE memberid=?", playerID )
			exports.DENmysql:exec( "INSERT INTO groups_members SET groupid=?, memberid=?, membername=?, groupname=?, grouprank=?,hydra=?,rustler=?,seasparrow=?,rhino=?,hunter=?", groupTable.groupid, playerID, playerAccount, groupTable.groupname, "Deputy Leader",0,0,0,0,0 )
			exports.DENmysql:exec("INSERT INTO groups_logs (groupid,log) VALUES (?,?)",groupID,getPlayerName(source).." has accepted the invite and joined the group.")
			setElementData( source, "Group", groupTable.groupname )
			setElementData( source, "GroupType", groupTable.gType )
			setElementData( source, "GroupID", groupTable.groupid )
			setElementData( source, "GroupRank", "Deputy Leader" )
			exports.DENchatsystem:outPutGroupMessageByPlayer( source, getPlayerName( source ).." has joined the group!" )
			triggerClientEvent( source, "onClientHideGroupsWindow", source )
		end
		end
	end
)

addCommandHandler("setmember",
	function (player,cmd,groupID )
	local source = player
	if getElementData(player,"isPlayerPrime") == true then
		local playerID = exports.server:getPlayerAccountID( source )
		local playerAccount = exports.server:getPlayerAccountName ( source )
		local groupTable = exports.DENmysql:querySingle( "SELECT * FROM groups WHERE groupid=? LIMIT 1", groupID )
		if ( groupTable ) then
			exports.DENmysql:exec( "DELETE FROM groups_invites WHERE memberid=?", playerID )
			exports.DENmysql:exec( "INSERT INTO groups_members SET groupid=?, memberid=?, membername=?, groupname=?, grouprank=?,hydra=?,rustler=?,seasparrow=?,rhino=?,hunter=?", groupTable.groupid, playerID, playerAccount, groupTable.groupname, "Member",0,0,0,0,0 )
			exports.DENmysql:exec("INSERT INTO groups_logs (groupid,log) VALUES (?,?)",groupID,getPlayerName(source).." has accepted the invite and joined the group.")
			setElementData( source, "Group", groupTable.groupname )
			setElementData( source, "GroupType", groupTable.gType )
			setElementData( source, "GroupID", groupTable.groupid )
			setElementData( source, "GroupRank", "Member" )
			exports.DENchatsystem:outPutGroupMessageByPlayer( source, getPlayerName( source ).." has joined the group!" )
			triggerClientEvent( source, "onClientHideGroupsWindow", source )
		end
		end
	end
)

-- When the player quit save the last online time
addEventHandler( "onPlayerQuit", root,
	function ()
		local playerID = exports.server:getPlayerAccountID( source )
		exports.DENmysql:exec( "UPDATE groups_members SET lastonline=? WHERE memberid=?", getRealTime().timestamp, playerID )
	end
)

function getGroupMembers(groupID)
end

-- Alliances
local allianceSettings = {["shareGates"] = "true",["shareSpawners"] = "true",["shareArmor"] = "false",["forceBlips"]="true",["canDefend"]="true",["splitMoney"]="true",["turfAsAlliance"]="true"}

function getAlliancePlayers ( allianceID, groupID )
	if alliances[allianceID] then
		local theTable = {}
		local groups = {}
		for i=1,#alliances[allianceID].groups do
			groups[alliances[allianceID].groups[i]] = true
		end
		local players = getElementsByType ( "player" )
		for i=1,#players do
			if ( groups[getElementData( players[i], "GroupID" )] ) and ( not groupID or getElementData( players[i], "GroupID" ) == groupID ) then
				table.insert( theTable, players[i] )
			end
		end
		return theTable
	end
	return false
end

addEventHandler("onResourceStart",resourceRoot,
	function ()
		if fileExists("alliancesInfo.xml") then
			alliancesFile = xmlLoadFile("alliancesInfo.xml")
		else
			alliancesFile = xmlCreateFile("alliancesInfo.xml","alliances")
		end
		local alliancesInfo = xmlNodeGetChildren(alliancesFile)
		for i=1,#alliancesInfo do
			local allianceNode = alliancesInfo[i]
			makeAllianceEntryForNode(allianceNode)
		end
		for id,alliance in pairs(alliances) do
			if #alliance.groups >= 1 then
				local playersInAlliance = getAlliancePlayers ( id )
				for i=1,#playersInAlliance do
					setElementData(playersInAlliance[i],"alliance",id)
					setElementData(playersInAlliance[i],"aName",alliance.name)
				end
			end
		end
	end
)

function makeAllianceEntryForNode(node)

	if node then

		local allianceInfo = {}

		allianceInfo.node = node
		local allianceNode = node

		allianceInfo.ID = tonumber(xmlNodeGetValue(allianceNode))
		allianceInfo.founderGroup = tonumber(xmlNodeGetAttribute(allianceNode,"founder"))
		allianceInfo.groups = fromJSON(xmlNodeGetAttribute(allianceNode,"groups"))
		local allianceMemberCount = 0
			for i=1,#allianceInfo.groups do
				allianceGroups[tonumber(allianceInfo.groups[i])] = allianceInfo.ID
				local groupMembers = exports.DENmysql:query( "SELECT * FROM groups_members WHERE groupid=? LIMIT 80", tonumber(allianceInfo.groups[i]) )
				allianceMemberCount = allianceMemberCount + ( #groupMembers or 0 )
			end
		allianceInfo.memberCount = allianceMemberCount
		allianceInfo.name = xmlNodeGetAttribute(allianceNode,"name")
		allianceInfo.dateCreated = xmlNodeGetAttribute(allianceNode,"dateCreated")
		allianceInfo.dateLastJoin = xmlNodeGetAttribute(allianceNode,"dateOfLastJoin")
		allianceInfo.info = xmlNodeGetAttribute(allianceNode,"info")
		allianceInfo.invites = fromJSON(xmlNodeGetAttribute(allianceNode,"invites"))
		allianceInfo.rgb = xmlNodeGetAttribute(allianceNode,"rgb")
		allianceInfo.balance = tonumber(xmlNodeGetAttribute(allianceNode,"balance"))
		allianceInfo.transactions = fromJSON(xmlNodeGetAttribute(allianceNode,"transactions"))
			for setting,_ in pairs(allianceSettings) do
				allianceInfo[setting] = xmlNodeGetAttribute(allianceNode,setting) == "true"
			end
		alliances[allianceInfo.ID] = allianceInfo

	end

end


addEvent( "requestAllianceData", true )
addEventHandler( "requestAllianceData", root,
	function ()
		local groupID = exports.server:getPlayerGroupID( source )
		local playerAllianceID

		if allianceGroups[groupID] then playerAllianceID = allianceGroups[groupID] end

		triggerClientEvent(source,"onRequestAllianceDataCallBack",source,alliances,playerAllianceID,allianceSettings)
	end
)

function getAllianceColor(id)
	if (alliances[id]) and (alliances[id].rgb) then
		return alliances[id].rgb
	else
		return toJSON({math.random(255),math.random(255),math.random(255)})
	end
end

function getCurrentTimeFormatted()

	local theTime = getRealTime()
	for key,value in pairs(theTime) do
		if value < 10 then theTime[key] = "0"..value end
	end
	return (theTime.year+1900).."-"..theTime.month.."-"..theTime.monthday.." "..theTime.hour..":"..theTime.minute..":"..theTime.second

end

addEvent("alliances_createNewAlliance",true )
addEventHandler("alliances_createNewAlliance",root,
	function (allianceName)
		local latestID = tonumber(exports.DENmysql:query( "SELECT * FROM serverstats WHERE name=? LIMIT 1", "allianceCountTicker" )[1].value)
		--local latestID = 987+(math.random(5,100))
		for ID,alliance in pairs(alliances) do
			if string.lower(allianceName) == string.lower(alliance.name) then
				exports.NGCdxmsg:createNewDxMessage(source,"Alliance name already in use!",255,0,0)
				return false
			end
			--newID = ID+1
		end
		local newID = latestID+1
		exports.DENmysql:exec('UPDATE serverstats SET value=? WHERE name=?',tostring(newID),"allianceCountTicker")
		if newID then
			local newNode = xmlCreateChild(alliancesFile,"alliance")
			xmlNodeSetValue(newNode,tostring(newID))
			xmlNodeSetAttribute(newNode,"founder",exports.server:getPlayerGroupID(source))
			xmlNodeSetAttribute(newNode,"groups",toJSON({exports.server:getPlayerGroupID(source)}))
			xmlNodeSetAttribute(newNode,"name",allianceName)

			xmlNodeSetAttribute(newNode,"dateCreated",getCurrentTimeFormatted())
			xmlNodeSetAttribute(newNode,"dateOfLastJoin",getCurrentTimeFormatted())
			xmlNodeSetAttribute(newNode,"info","")
			xmlNodeSetAttribute(newNode,"invites",toJSON({}))
			xmlNodeSetAttribute(newNode,"transactions",toJSON({}))
			xmlNodeSetAttribute(newNode,"balance",0)
			xmlNodeSetAttribute(newNode,"rgb",toJSON({255,0,0}))

			for setting,standardValue in pairs(allianceSettings) do
				xmlNodeSetAttribute(newNode,setting,standardValue)
			end
			local playerGroup = exports.server:getPlayerGroupID(source)
			xmlSaveFile(alliancesFile)
			makeAllianceEntryForNode(newNode)
			exports.NGCdxmsg:createNewDxMessage(source,"Alliance '"..allianceName.."' created!",0,255,0)
			allianceGroups[playerGroup] = newID
			triggerClientEvent(source,'alliances_client_updateAllianceInfo',source,newID,nil,alliances[newID],newID)
			local players = getAlliancePlayers ( newID, playerGroup )
			for i=1,#players do
				setElementData(players[i],"alliance",newID)
				setElementData(players[i],"aName",allianceName)
			end
		end
	end
)

addEvent("alliances_inviteGroup",true)
addEventHandler("alliances_inviteGroup",root,
	function (allianceID,groupID)
		local invites = alliances[allianceID].invites
		for i=1,#invites do
			if groupID == invites[i][1] then
				exports.NGCdxmsg:createNewDxMessage(source,"Group already invited!",255,0,0)
				return false
			end
		end
		table.insert(alliances[allianceID].invites,{groupID,exports.server:getPlayerGroupID(source)})
		xmlNodeSetAttribute(alliances[allianceID].node,"invites",toJSON(invites))
		xmlSaveFile(alliancesFile)
		exports.NGCdxmsg:createNewDxMessage(source,"Group successfully invited!",0,255,0)
		triggerClientEvent(source,'alliances_client_updateAllianceInfo',source,allianceID,'invites',alliances[allianceID].invites)
	end
)

addEvent("alliances_kickGroup",true)
function alliance_kickGroup(allianceID,groupID,silent,player)
	local groups = alliances[allianceID].groups
	local found
	for i=1,#groups do
		if groupID == groups[i] then
			table.remove(groups,i)
			found = true
			break
		end
	end
	if #groups <= 0 then
		deleteAlliance(allianceID,true,source or player)
		if not silent then
			exports.NGCdxmsg:createNewDxMessage(source or player,"Alliance '"..(alliances[alliance].name).."' deleted because you kicked the only group left!",255,255,0)
		end
	elseif found then
		xmlNodeSetAttribute(alliances[allianceID].node,"groups",toJSON(groups))
		xmlSaveFile(alliancesFile)
		alliances[allianceID].groups = groups
		if not silent then
			exports.NGCdxmsg:createNewDxMessage(source or player,"Group has been kicked!",0,255,0)
		end
		allianceGroups[groupID] = nil
		triggerClientEvent(source or player,'alliances_client_updateAllianceInfo',source or player,allianceID,'groups',alliances[allianceID].groups)
		local players = getAlliancePlayers ( allianceID, groupID )
		for i=1,#players do
			setElementData(players[i],"alliance",false)
			setElementData(players[i],"aName",false)
			setElementData(players[i],"ta",false)
		end
	else
		if not silent then
			exports.NGCdxmsg:createNewDxMessage(source or player,"Group not found!",255,0,0)
		end
	end
end
addEventHandler("alliances_kickGroup",root,alliance_kickGroup)

addEvent("alliances_leaveAlliance",true)
addEventHandler("alliances_leaveAlliance",root,
	function (allianceID)
		if not alliances[allianceID] then return false end
		local playerGroup = exports.server:getPlayerGroupID(source)
		if playerGroup then
			local groupsInAlliance = alliances[allianceID].groups
			local newGroups = {}
			for i=1,#groupsInAlliance do
				if groupsInAlliance[i] ~= playerGroup then
					table.insert(newGroups,groupsInAlliance[i])
				end
			end
			if #newGroups < 1 then
				exports.NGCdxmsg:createNewDxMessage(source,"Alliance '"..(alliances[allianceID].name).."' deleted because you were the only group left!",255,255,0)
				deleteAlliance(allianceID,true,source)
			else
				alliances[allianceID].groups = newGroups
				xmlNodeSetAttribute(alliances[allianceID].node,"groups",toJSON(newGroups))
				xmlSaveFile(alliancesFile)
				exports.NGCdxmsg:createNewDxMessage(source,"Your group is no longer part of '"..(alliances[allianceID].name).."'!",200,125,0)
				setElementData(source,"alliance",false)
				setElementData(source,"aName",false)
				setElementData(source,"ta",false)
				allianceGroups[playerGroup] = nil
				triggerClientEvent(source,'alliances_client_updateAllianceInfo',source,allianceID,'groups',alliances[allianceID].groups)
				local players = getAlliancePlayers ( allianceID, playerGroup )
				for i=1,#players do
					setElementData(players[i],"alliance",false)
					setElementData(players[i],"aName",false)
					setElementData(players[i],"ta",false)
				end
			end
		end
	end
)
addEvent("alliances_deleteAlliance",true)
function deleteAlliance(alliance,silent,player)
	local players = getAlliancePlayers ( alliance )
	for k,v in ipairs(players) do
		setElementData(v,"alliance",false)
		setElementData(v,"aName",false)
		setElementData(v,"ta",false)
	end
	local nm = alliances_getAllianceName(alliance)
	if nm then
		for k,v in ipairs(getElementsByType("player")) do
			if getElementData(v,"aName") == nm then
				setElementData(v,"alliance",false)
				setElementData(v,"aName",false)
				setElementData(v,"ta",false)
			end
		end
	end
	xmlDestroyNode(alliances[alliance].node)
	for i=1,#alliances[alliance].groups do
		allianceGroups[alliances[alliance].groups[i]] = nil
	end
	alliances[alliance] = nil
	xmlSaveFile(alliancesFile)
	if not silent then
		exports.NGCdxmsg:createNewDxMessage(source,"Alliance successfully deleted!",0,255,0)
	end
	triggerClientEvent(source or player,'alliances_client_updateAllianceInfo',source or player,alliance,nil,nil)-- remove entry at client
end
addEventHandler("alliances_deleteAlliance",root,
	function (allianceID,username,pass)
		local accountCheck = exports.DENmysql:querySingle( "SELECT * FROM accounts WHERE username=? AND password=? LIMIT 1", username, sha256( pass ) )
		if ( accountCheck ) then
			if allianceID then
				deleteAlliance(allianceID,false,source)
			end
		else
			exports.NGCdxmsg:createNewDxMessage(source,"Password incorrect!",255,0,0)
		end
	end
)


addEvent("alliances_setNewFounder",true)
addEventHandler("alliances_setNewFounder",root,
	function (allianceID,newFounderGroupID,username,pass)
		local accountCheck = exports.DENmysql:querySingle( "SELECT * FROM accounts WHERE username=? AND password=? LIMIT 1", username, sha256( pass ) )
		if ( accountCheck ) then
			if allianceID and newFounderGroupID then
				alliances[allianceID].founderGroup = newFounderGroupID
				xmlNodeSetAttribute((alliances[allianceID] or {}).node,"founder",tostring(newFounderGroupID))
				xmlSaveFile(alliancesFile)
				exports.NGCdxmsg:createNewDxMessage(source,"Alliance founder succesfully changed!",0,255,0)
				triggerClientEvent(source,'alliances_client_updateAllianceInfo',source,allianceID,'founderGroup',newFounderGroupID)
			end
		else
			exports.NGCdxmsg:createNewDxMessage(source,"Password incorrect!",255,0,0)
		end
	end
)

addEvent("alliances_updateInfo",true)
addEventHandler("alliances_updateInfo",root,
	function (allianceID,newText)
		(alliances[allianceID] or {}).info = newText
		xmlNodeSetAttribute((alliances[allianceID] or {}).node,"info",newText)
		xmlSaveFile(alliancesFile)
	end
)

addEvent("alliances_noteGroup",true)
addEventHandler("alliances_noteGroup",root,
	function (groups,message)
		if type(groups) ~= "table" then groups = {groups} end
		local sourceGroupName = exports.server:getPlayerGroupName(source)
		local message = "[ALLIANCE NOTE] ("..sourceGroupName..") " .. getPlayerName( source ) .. ": "..message
		for i=1,#groups do
			exports.denchatsystem:outPutGroupMessage (groups[i], message,200,125,0)
		end
		exports.NGCdxmsg:createNewDxMessage(source,"Note successfully sent!",0,255,0)
	end
)

addEvent("alliances_acceptInvite",true)
addEventHandler("alliances_acceptInvite",root,
	function (allianceID,groupID)
		local inAlliance
		if alliances[allianceID] and groupID then
			for i=1,#alliances[allianceID].groups do
				if alliances[allianceID].groups[i] == groupID then
					inAlliance = true
					break
				end
			end
			if not inAlliance then
				table.insert(alliances[allianceID].groups,groupID)
				local theTime = getCurrentTimeFormatted()
				xmlNodeSetAttribute(alliances[allianceID].node,"groups",toJSON(alliances[allianceID].groups))
				xmlNodeSetAttribute(alliances[allianceID].node,"dateOfLastJoin",theTime)
				xmlSaveFile(alliancesFile)
				inAlliance = true
			end
			if inAlliance then
				triggerClientEvent(source,'alliances_client_updateAllianceInfo',source,allianceID,'groups',alliances[allianceID].groups,allianceID)
				allianceGroups[groupID] = allianceID
				alliances_removeInvite(allianceID,groupID, true)
				local players = getAlliancePlayers ( allianceID, groupID )
				for i=1,#players do
					setElementData(players[i],"alliance",allianceID)
					setElementData(players[i],"aName",alliances[allianceID].name)
					exports.NGCdxmsg:createNewDxMessage(players[i],"Your group is now part of '"..(alliances[allianceID].name).."'!",0,255,0)
				end
			end
		end
	end
)

addEvent("alliances_removeInvite",true)
function alliances_removeInvite(allianceID,groupID, silent, msg)
	if alliances[allianceID] and groupID then
		for i=1,#alliances[allianceID].invites do
			if alliances[allianceID].invites[i][1] == groupID then
				table.remove(alliances[allianceID].invites,i)
				xmlNodeSetAttribute(alliances[allianceID].node,"invites",toJSON(alliances[allianceID].invites))
				xmlSaveFile(alliancesFile)
				if not silent then
					exports.NGCdxmsg:createNewDxMessage(source,msg,0,255,0)
				end
				if source then
					triggerClientEvent(source,'alliances_client_updateAllianceInfo',source,allianceID,'invites',alliances[allianceID].invites)
				end
				return true
			end
		end
		if not silent then
			exports.NGCdxmsg:createNewDxMessage(source,"Invitation not found!",255,0,0)
			if source then
				triggerClientEvent(source,'alliances_client_updateAllianceInfo',source,allianceID,'invites',alliances[allianceID].invites)
			end
		end
	end
end
addEventHandler("alliances_removeInvite",root,alliances_removeInvite)

addEvent("CSGalliance.newcolor",true)
addEventHandler("CSGalliance.newcolor",root,function(alliance,r,g,b)
	xmlNodeSetAttribute(alliances[alliance].node,"rgb",tostring(toJSON{r,g,b}))
	alliances[alliance].rgb=toJSON{r,g,b}
	for k,v in pairs(getAlliancePlayers(alliance)) do
		exports.NGCdxmsg:createNewDxMessage(v,""..getPlayerName(source).." updated the alliance turf colors to this color",r,g,b)
	end
	triggerEvent("onAllianceChangeColor",getRandomPlayer(),getElementData(source,"aName"),r,g,b)
end)

addEvent("alliances_bank",true)
addEventHandler("alliances_bank",root,
	function (allianceID,transaction, amount)
	local can,msg = exports.NGCmanagement:isPlayerLagging(source)
		if can then
			local currentBalance = alliances[allianceID].balance
			if currentBalance then
				local groupID = exports.server:getPlayerGroupID(source)
				local newBalance = currentBalance
				if transaction == "deposit" then
					if getPlayerMoney(source) <= tonumber(amount) then
						exports.NGCdxmsg:createNewDxMessage(source,"You don't have this amount of money!",255,0,0)
						return false
					end
					newBalance = newBalance + amount
					--exports.CSGaccounts:removePlayerMoney ( source, amount )
					exports.AURpayments:takeMoney(source,tonumber(amount),"CSGGroups")
					transaction = "deposited"
				elseif transaction == "withdraw" then
					if tonumber(currentBalance)-tonumber(amount) >= 0 then
						newBalance = newBalance - amount
		---				exports.CSGaccounts:addPlayerMoney ( source, amount )
						exports.AURpayments:addMoney(source,tonumber(amount),"Custom","Groups",0,"CSGGroups")
						transaction = "withdrawn"
					else
						exports.NGCdxmsg:createNewDxMessage(source,"Not enough money in the bank!",255,0,0)
						return false
					end
				end
				local transactionEntry = {groupID,amount,transaction}
				alliances[allianceID].balance = newBalance
				table.insert(alliances[allianceID].transactions,transactionEntry)
				xmlNodeSetAttribute(alliances[allianceID].node,"balance",tostring(newBalance))
				xmlNodeSetAttribute(alliances[allianceID].node,"transactions",toJSON(alliances[allianceID].transactions))
				xmlSaveFile(alliancesFile)
				exports.NGCdxmsg:createNewDxMessage(source,"Transaction succesfully made!",0,255,0)
				triggerClientEvent(source,'alliances_client_updateAllianceInfo',source,allianceID,nil,alliances[allianceID])
			end
		else
			exports.NGCdxmsg:createNewDxMessage(source,msg,255,0,0)
			return false
		end
	end
)

addEvent("alliances_settingsAdjusted",true)
addEventHandler("alliances_settingsAdjusted",root,
	function (allianceID,newSettings)
		if alliances[allianceID] then
			for setting,value in pairs(newSettings) do
				alliances[allianceID][setting] = value == true
				xmlNodeSetAttribute(alliances[allianceID].node,setting,tostring(value == true))
				for k,v in pairs(getAlliancePlayers(allianceID)) do
					if setting == "turfAsAlliance" then
						setElementData(v,"ta",value)
					end
					exports.NGCdxmsg:createNewDxMessage(v,""..getPlayerName(source).." has changed alliance setting: "..setting..": "..tostring(value).." - F6 to Refresh",0,255,0)
				end
			end
		end
	end
)



function alliances_saveAndUnloadXML()
	xmlSaveFile(alliancesFile)
	xmlUnloadFile(alliancesFile)
end

addEventHandler("onResourceStop",resourceRoot,alliances_saveAndUnloadXML)

-- alliance chat

function alliances_getGroupAlliance(groupID)
	return allianceGroups[groupID]
end

function alliances_getAllianceIDByName(name)
	for id,alliance in pairs(alliances) do
		if alliance.name == name then
			return id
		end
	end
end

function alliances_getAllianceName(allianceID)
	if alliances[allianceID] then
		return alliances[allianceID].name
	else
		--error("Alliance not found",2)
	end
end
addEvent("alliances_getAllianceSettings",true)
function alliances_getAllianceSettings(allianceID)
	if alliances[allianceID] then
		local settings = {}
		for setting,_ in pairs(allianceSettings) do
			settings[setting] = alliances[allianceID][setting]
		end
		if eventName and isElement(client) then -- was triggered by client event
			triggerClientEvent(client,"alliances_receiveAllianceSettings",source,settings)
		end
		return settings
	else
		--error("Alliance not found",2)
	end
end
addEventHandler("alliances_getAllianceSettings",root,alliances_getAllianceSettings)

addEventHandler("onPlayerLogin",root,
	function ()
		local playerGroup = getElementData(source,"GroupID")
		if playerGroup then
			if allianceGroups[playerGroup] then
				setElementData(source,"alliance",alliances[allianceGroups[playerGroup]].ID)
				setElementData(source,"aName",alliances[allianceGroups[playerGroup]].name)
				setElementData(source,"ta",alliances_getAllianceSettings(alliances[allianceGroups[playerGroup]].ID).turfAsAlliance)
			end
		end
	end
)

---- GROUP manager log
addEvent("findThrowGroups",true)
addEventHandler("findThrowGroups",root,function(gn)
	if gn then
		local datatable = exports.DENmysql:query("SELECT * FROM groupmanager WHERE groupname=?",gn)
		if datatable then
			exports.NGCdxmsg:createNewDxMessage(source,"Please wait we are sending logs...",255,0,0)
			triggerClientEvent(source,"callClientgroupInviteLogs",source,datatable,gn)
		else
			exports.NGCdxmsg:createNewDxMessage(source,"Group with this name not found please try again",255,0,0)
		end
	end
end)



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


antispam = {}

addCommandHandler( "gmlog",
	function ( thePlayer )
		local theAccount = exports.server:getPlayerAccountName ( thePlayer )
		if ( theAccount ) then
			if exports.CSGstaff:isPlayerStaff(thePlayer) and exports.CSGstaff:getPlayerAdminLevel(thePlayer) >= 3 or getElementData(thePlayer,"isPlayerPrime") then
				if isTimer(antispam[thePlayer]) then exports.NGCdxmsg:createNewDxMessage(thePlayer,"You can open invite logs once every 1 minute",255,0,0) return false end
				antispam[thePlayer] = setTimer(function() end,60000,1)
				triggerClientEvent( thePlayer, "openGMPanel", thePlayer )
			end
		end
	end
)
