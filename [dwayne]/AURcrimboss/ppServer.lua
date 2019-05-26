local crimsBoss = {
	["darknes"] = 6,
	["ab-47"] = 6,
}

aeh = addEventHandler
ach = addCommandHandler

local logs = {}

-- LOGS
function bossLog ( playerSource, commandName )
    triggerClientEvent ( playerSource, "onBossLog", playerSource )
end
addCommandHandler ( "cbosslog", bossLog )

-- MAIN
function openMain ( playerSource, commandName )
    triggerClientEvent ( playerSource, "onCmainP", playerSource )
end
addCommandHandler ( "cboss", openMain )

aeh("onServerPlayerLogin",root,function()
	local nam = exports.server:getPlayerAccountName(source)
	if crimsBoss[nam] ~= nil then
		setElementData(source,"boss",crimsBoss[nam],true)
		triggerClientEvent(source,"cbossRecRank",source,crimsBoss[nam])
	end
	sendLogs(source)
end)


function isCrim(p)
	local nam = getTeamName(getPlayerTeam(p))
	if nam == "Criminals" or nam == "HolyCrap" then
		return true
	else
		return false
	end
end


function isCrim2(p)
	local nam = getTeamName(getPlayerTeam(p))
	if nam == "Criminals" or nam == "Staff" or nam == "HolyCrap"  then
		return true
	else
		return false
	end
end

function setLevel(ps,_,user,level)
	local pl = getElementData(ps,"boss")
	if (pl == false) or (pl <= 5) then
		outputChatBox("You are not authorized to change Criminals Boss Roster",ps,255,0,0)
		return
	end
	if not (user) then
		outputChatBox("You didn't specify a user name. Usage: /bosslevel username level  0=remove",ps,255,0,0)
		return
	end
	if not (level) or (type(tonumber(level)) ~= "number") then
		outputChatBox("You didn't specify a valid level. Usage: /bosslevel username level  0=remove",ps,255,0,0)
		return
	end
	level = tonumber(level)
	if pl == 6 and level <= 6 then
	crimsBoss[user] = level
	for k,v in pairs(crimsBoss) do
		if v == 0 then
			crimsBoss[k] = nil
		end
	end
	local str = toJSON(crimsBoss)
	exports.DENmysql:exec('UPDATE serverstats SET value=? WHERE name=?',str,"criminalsBossRoster")
	outputChatBox("You have set "..user.."'s Boss Rank to Level "..level.."",ps,0,255,0)
	logAction("set Username "..user.."'s Boss Rank to Level "..level..")",ps)
	for k,v in pairs(getElementsByType("player")) do
		if exports.server:getPlayerAccountName(v) == user then
			outputChatBox(""..getPlayerName(ps).." has set your Boss Rank to Level "..level.."",v,0,255,0)
			if level == 0 then
				setElementData(v,"boss",false)
			else
				setElementData(v,"boss",level)
			end
			triggerClientEvent(v,"cbossRecRank",v,level)
			return
		end
	end
	end
end
ach("bosslevel",setLevel)


addEvent("bosslevel",true)
addEventHandler("bosslevel",root,function(name,level)
local ps = source
	local user = exports.server:getPlayerAccountName(name)
	local pl = getElementData(ps,"boss")
	if (pl == false) or (pl < 5) then
		outputChatBox("You are not authorized to change Criminals Boss Roster",ps,255,0,0)
		return
	end
	if not (user) then
		outputChatBox("You didn't specify a user name. Usage: /bosslevel username level  0=remove",ps,255,0,0)
		return
	end
	if not (level) or (type(tonumber(level)) ~= "number") then
		outputChatBox("You didn't specify a valid level. Usage: /bosslevel username level  0=remove",ps,255,0,0)
		return
	end
	if crimsBoss[user] == 6 then
		outputChatBox("You cant demote The God Father!!",ps,255,0,0)
		return
	end
	level = tonumber(level)
	crimsBoss[user] = level
	for k,v in pairs(crimsBoss) do
		if v == 0 then
			crimsBoss[k] = nil
		end
	end
	local str = toJSON(crimsBoss)
	exports.DENmysql:exec('UPDATE serverstats SET value=? WHERE name=?',str,"criminalsBossRoster")
	outputChatBox("You have set "..user.."'s Boss Rank to Level "..level.."",ps,0,255,0)
	logAction("set Username "..user.."'s Boss Rank to Level "..level..")",ps)
	for k,v in pairs(getElementsByType("player")) do
		if exports.server:getPlayerAccountName(v) == user then
			outputChatBox(""..getPlayerName(ps).." has set your Boss Rank to Level "..level.."",v,0,255,0)
			if level == 0 then
				setElementData(v,"boss",false)
			else
				setElementData(v,"boss",level)
			end
			triggerClientEvent(v,"cbossRecRank",v,level)
			return
		end
	end
end)

function printRoster(ps)
	for k,v in pairs(crimsBoss) do
		if v > 0 then
			outputChatBox("Username: "..k..". Level: "..v.."",ps,255,0,255)
		end
	end
end
ach("cbossprintroster",printRoster)

function logAction(action,chief)
	local acc = exports.server:getPlayerAccountName(chief)
	local name = getPlayerName(chief)
	local namerow = name.."("..acc..") Level "..crimsBoss[acc]..""
	local datum = exports.CSGpriyenmisc:getTimeStampYYYYMMDD()
	table.insert(logs,{action,namerow,datum})
	sendLogs(nil,action,namerow,datum)
	local r,g,b = 0,0,0
	if string.find(action,"Unbanned") then r,g,b = 0,255,0 else r,g,b = 255,0,0 end
	for k,v in pairs(getElementsByType("player")) do
		if exports.server:isPlayerLoggedIn(v) then
			if isCrim(v) or isCrim2(v) then
				outputChatBox(name.." (Boss Level "..crimsBoss[acc]..")  has "..action.."",v,r,g,b)
			end
		end
	end
	save()
end

function sendLogs(p,action,namerow,datum)
	if (p) then
		local tlogs = logs
		local size = #tlogs
		if size > 25 then
			for i=1,size-25 do
				table.remove(tlogs,1)
			end
		end
		triggerClientEvent(p,"cbossLogT",p,tlogs)
	else
		for k,v in pairs(getElementsByType("player")) do
			if exports.server:isPlayerLoggedIn(v) then
				triggerClientEvent(v,"cbossLogAction",v,action,namerow,datum)
			end
		end
	end
end

function kickPlayerFromJob(player)
setElementData(player,"Occupation","Unemployed")
setPlayerTeam(player,getTeamFromName("Unemployed"))
exports.DENvehicles:reloadFreeVehicleMarkers(player, true )
end


local recWarn = {}
addEvent("pwarn",true)
addEventHandler("pwarn",root,function(name,reason,...)
local ps = source
	local acc = exports.server:getPlayerAccountName(ps)
	if (crimsBoss[acc]) then
		if not(isCrim(ps)) then return end
		if crimsBoss[acc] >= 1 then
			local data = {...}
			local t = {}
			tim=data[#data]
		--	local reason = ""
			for k,v in pairs(data) do  table.insert(t,1,v)   end
		--	for k,v in pairs(t) do if reason ~= "" then reason=v.." "..reason else reason = v  end end
			--if (reason) and (reason ~= "") and (name) then
				--local e = exports.server:getPlayerFromNamePart(name)
				local e = name
				if (e) and isElement(e) then
					if isCrim(e) and getTeamName(getPlayerTeam(e)) ~= "Staff" then
						if (recWarn[exports.server:getPlayerAccountName(e)]) then
							recWarn[exports.server:getPlayerAccountName(e)]=nil

							logAction(""..getPlayerName(e).." (Kicked due to repeat warning) for ("..reason..")",ps)
							exports.NGCdxmsg:createNewDxMessage(e,""..getPlayerName(ps).." (Criminal Boss) has kicked you from the job: "..reason.."",255,0,0)
							if isCrim(e) then
							kickPlayerFromJob(e)
							end
						else
							recWarn[exports.server:getPlayerAccountName(e)]=true
							logAction(" Warned "..getPlayerName(e).." for ("..reason..")",ps)
							exports.NGCdxmsg:createNewDxMessage(e,""..getPlayerName(ps).." (Criminal Boss) has warned you for: "..reason.."",255,0,0)
						end
					else
						exports.NGCdxmsg:createNewDxMessage(ps,name.." is not in Criminals Team at the moment",255,0,0)
					end
				else
					exports.NGCdxmsg:createNewDxMessage(ps,name.." is not a valid player",255,0,0)
				end
		--	else
		--		if not(name) then
		--			exports.NGCdxmsg:createNewDxMessage(ps,"You did not specify a player name!",255,0,0)
		--			return
		--		elseif not(reason) or reason=="" then
		---			exports.NGCdxmsg:createNewDxMessage(ps,"You did not specify a reason!",255,0,0)
		---		end
			--end
	--	else
	--		exports.NGCdxmsg:createNewDxMessage(ps,"You do not have permission to use this feature!",255,0,0)
		end
	end
end)

addEvent("pkick",true)
addEventHandler("pkick",root,function(name,reason,...)
local ps = source
	local acc = exports.server:getPlayerAccountName(ps)
	if (crimsBoss[acc]) then
		if not(isCrim(ps)) then return end
		if crimsBoss[acc] >= 2 then
			local data = {...}
			local t = {}
			tim=data[#data]
		--	local reason = ""
			for k,v in pairs(data) do  table.insert(t,1,v)   end
		--	for k,v in pairs(t) do if v ~= tim then  reason=v.." "..reason else reason = v end   end
		--	if (reason) and (reason ~= "") and (name) then
				--local e = exports.server:getPlayerFromNamePart(name)
				local e = name
				if (e) and isElement(e) then
					if isCrim(e) and getTeamName(getPlayerTeam(e)) ~= "Staff" then
						logAction("Kicked "..getPlayerName(e).." from Criminals Team for ("..reason..")",ps)
						exports.NGCdxmsg:createNewDxMessage(e,""..getPlayerName(ps).." (Criminal Boss) has kicked you from the job: "..reason.."",255,0,0)
						if isCrim(e) then
							kickPlayerFromJob(e)
						end
					else
						exports.NGCdxmsg:createNewDxMessage(ps,name.." is not in Criminals Team at the moment",255,0,0)
					end
				else
					exports.NGCdxmsg:createNewDxMessage(ps,name.." is not a valid player",255,0,0)
				end
	---		else
	---			if not(name) then
	--				exports.NGCdxmsg:createNewDxMessage(ps,"You did not specify a player name!",255,0,0)
	---				return
	--			elseif not(reason) or reason=="" then
	--				exports.NGCdxmsg:createNewDxMessage(ps,"You did not specify a reason!",255,0,0)
	--			end
	--		end
	--	else
	--		exports.NGCdxmsg:createNewDxMessage(ps,"You do not have permission to use this feature!",255,0,0)
		end
	end
end)

--addCommandHandler("cban",function(ps,cmd,name,...)
addEvent("cban",true)
addEventHandler("cban",root,function(name,reason,tim)
local ps = source
	local acc = exports.server:getPlayerAccountName(ps)
	if (crimsBoss[acc]) then
	outputDebugString("@@")
		if isCrim2(ps) == false then return end
		outputDebugString("@")
		if crimsBoss[acc] >= 3 then
			--[[local data = {...}
			local t = {}
			tim=data[#data]
			local reason = ""
			for k,v in pairs(data) do if v ~= tim then table.insert(t,1,v) end end
			for k,v in pairs(t) do if v ~= tim then if reason ~= "" then reason=v.." "..reason else reason = v end end end
		--	if (tim) then --and (crimsBoss[acc] == 3) then
		--		exports.NGCdxmsg:createNewDxMessage(ps,"You do not have permission to specify ban time!",255,0,0)
		--	else]]
				if not(reason) or reason=="" then
					exports.NGCdxmsg:createNewDxMessage(ps,"You did not specify a reason!",255,0,0)
					return
				end

				--if (name) then
					--local e = exports.server:getPlayerFromNamePart(name)
					local e = name
					if (e) and isElement(e) then
						if (tim) then
							local timem = tonumber(tim)
							if crimsBoss[acc] == 3 then
								if type(timem) == "number" and math.floor(timem) > 0 and math.floor(timem) <= 10 then
									exports.DENcriminal:banFromJob(exports.server:getPlayerAccountName(e),"CrimBan",math.floor(timem))
									logAction("Banned "..getPlayerName(e).." from Criminals Team for ("..reason..") "..math.floor(timem).." Minutes",ps)
									if isCrim(e) then
										kickPlayerFromJob(e)
									end
									else
									exports.NGCdxmsg:createNewDxMessage(ps,"You only allowed to ban for 10 mins max, insert valid time value",255,0,0)
								end
							end
							if crimsBoss[acc] > 3 and type(timem) == "number" and math.floor(timem) > 0 then
								exports.DENcriminal:banFromJob(exports.server:getPlayerAccountName(e),"CrimBan",math.floor(timem))
								logAction("Banned "..getPlayerName(e).." from Criminals Team for ("..reason..") "..math.floor(timem).." Minutes",ps)
								if isCrim(e) then
									kickPlayerFromJob(e)
								end
							end

						else
							exports.DENcriminal:banFromJob(exports.server:getPlayerAccountName(e),"CrimBan",60)
							logAction("Banned "..getPlayerName(e).." from Criminals Team ("..reason..") for 60 Minutes",ps)
							if isCrim(e) then
								kickPlayerFromJob(e)
							end
						end
					end
				--else
				--	exports.NGCdxmsg:createNewDxMessage(ps,"You did not specify a player name",255,0,0)
				--end
			end
		else
			exports.NGCdxmsg:createNewDxMessage(ps,"You do not have permission to use this command!",255,0,0)
	--	end
	end
end)

--[[addCommandHandler("cbossban",function(ps,cmd,name,...)
	local acc = exports.server:getPlayerAccountName(ps)
	if (crimsBoss[acc]) then
		--if isCrim(ps) == false then return end
		if crimsBoss[acc] >= 4 then
			local data = {...}
			local t = {}
			tim=data[#data]
			local reason = ""
			for k,v in pairs(data) do if v ~= tim then table.insert(t,1,v) end end
			for k,v in pairs(t) do if v ~= tim then if reason ~= "" then reason=v.." "..reason else reason = v end end end
		--	if (tim) then --and (crimsBoss[acc] == 3) then
		--		exports.NGCdxmsg:createNewDxMessage(ps,"You do not have permission to specify ban time!",255,0,0)
		--	else
				if not(reason) or reason=="" then
					exports.NGCdxmsg:createNewDxMessage(ps,"You did not specify a reason!",255,0,0)
					return
				end

				if (name) then
					local e = exports.server:getPlayerFromNamePart(name)
					if (e) and isElement(e) then
						if (tim) then
							local timem = tonumber(tim)
							if type(timem) == "number" and math.floor(timem) > 0 then
								exports.DENcriminal:banFromJob(exports.server:getPlayerAccountName(e),"CrimBan",math.floor(timem))
								logAction("Banned "..getPlayerName(e).." from Criminals Team for ("..reason..") "..math.floor(timem).." Minutes",ps)
								if isCrim(e) then
									kickPlayerFromJob(e)
								end
							else
								exports.NGCdxmsg:createNewDxMessage(ps,"Invalid time input",255,0,0)
							end
						else
							exports.DENcriminal:banFromJob(exports.server:getPlayerAccountName(e),"CrimBan",60)
							logAction("Banned "..getPlayerName(e).." from Criminals Team ("..reason..") for 60 Minutes",ps)
							if isCrim(e) then
								kickPlayerFromJob(e)
							end
						end
					else
						exports.NGCdxmsg:createNewDxMessage(ps,name.." is not a valid player",255,0,0)
					end
				else
					exports.NGCdxmsg:createNewDxMessage(ps,"You did not specify a player name",255,0,0)
				end
			end
		else
			exports.NGCdxmsg:createNewDxMessage(ps,"You do not have permission to use this command!",255,0,0)
	--	end
	end
end)]]

--addCommandHandler("cunban",function(ps,cmd,name)
addEvent("cunban",true)
addEventHandler("cunban",root,function(name)
local ps = source
	local acc = exports.server:getPlayerAccountName(ps)
	if (crimsBoss[acc]) then
		if crimsBoss[acc] >= 5 then
			--if (name) then
				local e = name
				if (e) and isElement(e) then
					local acc = exports.server:getPlayerAccountName(e)
					if exports.DENcriminal:unbanFromJob(acc,"CrimBan") == true then
						logAction("Unbanned "..getPlayerName(e).." from Criminals Team",ps)
						exports.NGCdxmsg:createNewDxMessage(e,"You have been unbanned from Criminals Team",0,255,0)
					else
						exports.NGCdxmsg:createNewDxMessage(ps,getPlayerName(e).." was not banned",255,0,0)
					end
				end
			--else
			--	exports.NGCdxmsg:createNewDxMessage(ps,"You did not specify a player name",255,0,0)
			--end
		else
			exports.NGCdxmsg:createNewDxMessage(ps,"You do not have permission to use this command!",255,0,0)
		end
	end
end)

function save()
	xmlRootTree = xmlLoadFile ( "userSettings.xml" ) --Attempt to load the xml file
	if xmlRootTree then -- If the xml loaded then...
		xmlHudBranch = xmlFindChild(xmlRootTree,"data",0) -- Find the hud sub-node
	else -- If the xml does not exist then...
		xmlRootTree = xmlCreateFile ( "userSettings.xml", "root" ) -- Create the xml file
		xmlHudBranch = xmlCreateChild ( xmlRootTree, "data" ) -- Create the hud sub-node under the root node
		xmlNodeSetValue (xmlCreateChild ( xmlHudBranch, "saved"), toJSON({}) ) --Create sub-node values under the hud sub-node

	end
	xmlNodeSetValue(xmlFindChild(xmlHudBranch,"saved",0),toJSON(logs))
	xmlSaveFile(xmlRootTree)
end

function loads()
	xmlRootTree = xmlLoadFile ( "userSettings.xml" ) --Attempt to load the xml file
	if xmlRootTree then -- If the xml loaded then...
		xmlHudBranch = xmlFindChild(xmlRootTree,"data",0) -- Find the hud sub-node
	else -- If the xml does not exist then...
		xmlRootTree = xmlCreateFile ( "userSettings.xml", "root" ) -- Create the xml file
		xmlHudBranch = xmlCreateChild ( xmlRootTree, "data" ) -- Create the hud sub-node under the root node
		xmlNodeSetValue (xmlCreateChild ( xmlHudBranch, "saved"), toJSON({}) ) --Create sub-node values under the hud sub-node

	end
	--noob = xmlFindChild( xmlFile, "userSettings.xml", 0 )
    --saved = (xmlNodeGetValue ((xmlHudBranch,"saved",0)))
    --saved = xmlNodeGetValue(noob((xmlHudBranch,"saved",0)))


	logs = fromJSON(saved)

	if logs == nil then logs = {} end
	setTimer(function() for k,v in pairs(getElementsByType("player")) do sendLogs(v) end end,5000,1)
	xmlSaveFile(xmlRootTree)
	local t=exports.DENmysql:query( "SELECT * FROM serverstats WHERE name=? LIMIT 1", "criminalsBossRoster" )
	local res = false
	if t == nil then
		t = crimsBoss
	else
		local ts = nil
		for k,v in pairs(t) do
			ts = v.value
			ts = fromJSON(ts)
			break
		end
		crimsBoss = ts
	end
end
loads()
