-- open panel
function openChief ( playerSource, commandName )
    triggerClientEvent ( playerSource, "onChiefO", playerSource)
end
addCommandHandler ( "chief", openChief )

local chiefs = {

	["epozide"] = 5,

}



aeh = addEventHandler

ach = addCommandHandler



local logs = {}



aeh("onPlayerLogin",root,function()

	local nam = exports.server:getPlayerAccountName(source)

	if chiefs[nam] ~= nil then

		setElementData(source,"polc",chiefs[nam],true)

		triggerClientEvent(source,"pchiefRecRank",source,chiefs[nam])

	end

	sendLogs(source)

end)

aeh("onServerPlayerLogin",root,function()

	local nam = exports.server:getPlayerAccountName(source)

	if chiefs[nam] ~= nil then

		setElementData(source,"polc",chiefs[nam],true)

		triggerClientEvent(source,"pchiefRecRank",source,chiefs[nam])

	end

	sendLogs(source)

end)



function isLaw(p)

	local nam = getTeamName(getPlayerTeam(p))

	if exports.DENlaw:isLaw(p) or nam == "Staff" then

		return true

	else

		return false

	end

end



function isLaw2(p)

	local nam = getTeamName(getPlayerTeam(p))

	if exports.DENlaw:isLaw(p) then

		return true

	else

		return false

	end

end

local employmentSkins = {
	["Security Guard"] = {71}, -- the skin , Level = 1
	["Traffic Officer"] = {284}, -- the skin, Level = 2
	["County Chief"] = {283,288}, -- the skin, Level = 3
	["Police Officer"] = {280,281,282}, -- the skin, Level = 4
	["Police Detective"] = {166}, -- the skin, Level = 5
	["CIA Agent"] = {165}, -- the skin, Level = 6
	["FBI Agent"] = {286}, -- the skin, Level = 7
	["SAPD Officer"] = {285}, -- the skin, Level = 8
	["Task Force Agent"] = {295}, -- the skin, Level = 9
	["Military Soldier"] = {287}, -- the skin, Level = 10
}


function seemsLaw(p)

	local nam = getElementData(p,"Occupation")

	if nam == "Security Guard" or
		nam == "Traffic Officer" or
		nam == "County Chief" or
		nam == "Police Officer" or
		nam == "Police Detective" or
		nam == "CIA Agent" or
		nam == "FBI Agent" or
		nam == "SAPD" or
		nam == "Task Force Agent" or
		nam == "Military Forces"
	then

		return true

	else

		return false

	end

end



function setLevel(ps,_,user,level)

	local pl = getElementData(ps,"polc")

	if (pl == false) or (pl ~= 5) then

		outputChatBox("You are not authorized to change the Police Chief Roster",ps,255,0,0)

		return

	end

	if not (user) then

		outputChatBox("You didn't specify a user name. Usage: /pchiefsetlevel username level  0=remove",ps,255,0,0)

		return

	end

	if not (level) or (type(tonumber(level)) ~= "number") then

		outputChatBox("You didn't specify a valid level. Usage: /pchiefsetlevel username level  0=remove",ps,255,0,0)

		return

	end

	level = tonumber(level)

	chiefs[user] = level

	for k,v in pairs(chiefs) do

		if v == 0 then

			chiefs[k] = nil

		end

	end

	local str = toJSON(chiefs)

	exports.DENmysql:exec('UPDATE serverstats SET value=? WHERE name=?',str,"policeChiefRoster")

	outputChatBox("You have set "..user.."'s Police Chief Rank to Level "..level.."",ps,0,255,0)

	logAction("set Username "..user.."'s Police Chief Rank to Level "..level..")",ps)

	for k,v in pairs(getElementsByType("player")) do

		if exports.server:getPlayerAccountName(v) == user then

			outputChatBox(""..getPlayerName(ps).." has set your Police Chief Rank to Level "..level.."",v,0,255,0)

			setElementData(v,"polc",level,true)

			triggerClientEvent(v,"pchiefRecRank",v,level)

			return

		end

	end

end

ach("pchiefsetlevel",setLevel)



function printRoster(ps)

	for k,v in pairs(chiefs) do

		if v > 0 then

			outputChatBox("Username: "..k..". Level: "..v.."",ps,25,120,225)

		end

	end

end

ach("pchiefprintroster",printRoster)



function logAction(action,chief)

	local acc = exports.server:getPlayerAccountName(chief)

	local name = getPlayerName(chief)

	local namerow = name.."("..acc..") Level "..chiefs[acc]..""

	local datum = exports.CSGpriyenmisc:getTimeStampYYYYMMDD()

	table.insert(logs,{action,namerow,datum})

	sendLogs(nil,action,namerow,datum)

	local r,g,b = 0,0,0

	if string.find(action,"Unbanned") then r,g,b = 0,255,0 else r,g,b = 255,0,0 end

	for k,v in pairs(getElementsByType("player")) do

		if exports.server:isPlayerLoggedIn(v) then

			if isLaw(v) then

				outputChatBox(name.." (Police Chief Level "..chiefs[acc]..")  has "..action.."",v,r,g,b)

			end

		end

	end

	--save()

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

		triggerClientEvent(p,"pchiefLogT",p,tlogs)

	else

		for k,v in pairs(getElementsByType("player")) do

			if exports.server:isPlayerLoggedIn(v) then

				triggerClientEvent(v,"pchiefLogAction",v,action,namerow,datum)

			end

		end

	end

end



addCommandHandler("plogtest",function(ps)

	logAction("test",ps)

end)



addEvent("Chieflevel",true)
addEventHandler("Chieflevel",root,function(name,level)
local ps = source
	local user = exports.server:getPlayerAccountName(name)
	local pl = getElementData(ps,"polc")
	if (pl == false) or (pl < 4) then
		outputChatBox("You are not authorized to change Police Chief Roster",ps,255,0,0)
		return
	end
	if not (user) then
		outputChatBox("You didn't specify a user name. Usage: /pchiefsetlevel username level  0=remove",ps,255,0,0)
		return
	end
	if not (level) or (type(tonumber(level)) ~= "number") then
		outputChatBox("You didn't specify a valid level. Usage: /pchiefsetlevel username level  0=remove",ps,255,0,0)
		return
	end
	level = tonumber(level)
	chiefs[user] = level
	for k,v in pairs(chiefs) do
		if v == 0 then
			chiefs[k] = nil
		end
	end
	local str = toJSON(chiefs)
	exports.DENmysql:exec('UPDATE serverstats SET value=? WHERE name=?',str,"policeChiefRoster")
	outputChatBox("You have set "..user.."'s Police Chief Rank to Level "..level.."",ps,0,255,0)
	logAction("set Username "..user.."'s Police Chief Rank to Level "..level..")",ps)
	for k,v in pairs(getElementsByType("player")) do
		if exports.server:getPlayerAccountName(v) == user then
			outputChatBox(""..getPlayerName(ps).." has set your Police Chief Rank to Level "..level.."",v,0,255,0)
			setElementData(v,"polc",level,true)
			triggerClientEvent(v,"pchiefRecRank",v,level)
			return
		end
	end
end)

local recWarn = {}

--addEvent("",true)
--addEventHandler("",root,function()

addEvent("policeWarn",true)
addEventHandler("policeWarn",root,function(target,reason,...)
	local acc = exports.server:getPlayerAccountName(source)

	if (chiefs[acc]) then

		if not(isLaw(source)) then return end

		if chiefs[acc] >= 1 then

			local data = {...}

			local t = {}

			tim=data[#data]
			local name = getPlayerName(target)
			if (reason) and (reason ~= "") and (name) then

				local e = target

				if (e) and isElement(e) then

					if isLaw2(e) or seemsLaw(e) and getTeamName(getPlayerTeam(e)) ~= "Staff" then

						if (recWarn[exports.server:getPlayerAccountName(e)]) then

							recWarn[exports.server:getPlayerAccountName(e)]=nil



							logAction(""..getPlayerName(e).." (Kicked due to repeat warning) for ("..reason..")",source)

							exports.NGCdxmsg:createNewDxMessage(e,""..getPlayerName(source).." (Police Chief) has kicked you from the job: "..reason.."",255,0,0)

							if isLaw2(e) or seemsLaw(e) then

								triggerEvent("onQuitJob",e,getElementData(e,"Occupation"))

							end

						else

							recWarn[exports.server:getPlayerAccountName(e)]=true

							logAction("Warned "..getPlayerName(e).." for ("..reason..")",source)

							exports.NGCdxmsg:createNewDxMessage(e,""..getPlayerName(source).." (Police Chief) has warned you for: "..reason.."",255,0,0)

						end

					else

						exports.NGCdxmsg:createNewDxMessage(source,name.." is not in a law Enforcement job at the moment",255,0,0)

					end

				else

					exports.NGCdxmsg:createNewDxMessage(source,name.." is not a valid player",255,0,0)

				end

			else

				if not(name) then

					exports.NGCdxmsg:createNewDxMessage(source,"You did not specify a player name!",255,0,0)

					return

				elseif not(reason) or reason=="" then

					exports.NGCdxmsg:createNewDxMessage(source,"You did not specify a reason!",255,0,0)

				end

			end

		else

			exports.NGCdxmsg:createNewDxMessage(source,"You do not have permission to use this command!",255,0,0)

		end

	end

end)


addEvent("policeKick",true)
addEventHandler("policeKick",root,function(target,reason,...)
	local ps = source
	local acc = exports.server:getPlayerAccountName(ps)

	if (chiefs[acc]) then

		if not(isLaw(ps)) then return end

		if chiefs[acc] >= 2 then

			local data = {...}

			local t = {}

			tim=data[#data]
			local name = getPlayerName(target)
			if (reason) and (reason ~= "") and (name) then

				local e = target

				if (e) and isElement(e) then

					if isLaw2(e) or seemsLaw(e) and getTeamName(getPlayerTeam(e)) ~= "Staff" then

						logAction("Kicked "..getPlayerName(e).." from Law Enforcement for ("..reason..")",ps)

						exports.NGCdxmsg:createNewDxMessage(e,""..getPlayerName(ps).." (Police Chief) has kicked you from the job: "..reason.."",255,0,0)

						if isLaw2(e) or seemsLaw(e) then

							triggerEvent("onQuitJob",e,getElementData(e,"Occupation"))

						end

					else

						exports.NGCdxmsg:createNewDxMessage(ps,name.." is not in a law Enforcement job at the moment",255,0,0)

					end

				else

					exports.NGCdxmsg:createNewDxMessage(ps,name.." is not a valid player",255,0,0)

				end

			else

				if not(name) then

					exports.NGCdxmsg:createNewDxMessage(ps,"You did not specify a player name!",255,0,0)

					return

				elseif not(reason) or reason=="" then

					exports.NGCdxmsg:createNewDxMessage(ps,"You did not specify a reason!",255,0,0)

				end

			end

		else

			exports.NGCdxmsg:createNewDxMessage(ps,"You do not have permission to use this command!",255,0,0)

		end

	end

end)

addEvent("policeBan",true)
addEventHandler("policeBan",root,function(name,reason,tim)
local ps = source
	local acc = exports.server:getPlayerAccountName(ps)
	if (chiefs[acc]) then
	outputDebugString("@@")
		if isLaw(ps) == false then return end
		outputDebugString("@")
		if chiefs[acc] >= 3 then

				if not(reason) or reason=="" then
					exports.NGCdxmsg:createNewDxMessage(ps,"You did not specify a reason!",255,0,0)
					return
				end

					local e = name
					if (e) and isElement(e) then
						if (tim) then
							local timem = tonumber(tim)
							if chiefs[acc] == 3 then
								if type(timem) == "number" and math.floor(timem) > 0 and math.floor(timem) <= 10 then
									exports.DENjob:banFromJob(exports.server:getPlayerAccountName(e),"LawBan",math.floor(timem))
									logAction("Banned "..getPlayerName(e).." from police team for ("..reason..") "..math.floor(timem).." Minutes",ps)
									if isLaw(e) or seemsLaw(e) then
										triggerEvent("onQuitJob",e,getElementData(e,"Occupation"))
									end
									else
									exports.NGCdxmsg:createNewDxMessage(ps,"You only allowed to ban for 10 mins max, insert valid time value",255,0,0)
								end
							end
							if chiefs[acc] > 3 and type(timem) == "number" and math.floor(timem) > 0 then
								exports.DENjob:banFromJob(exports.server:getPlayerAccountName(e),"LawBan",math.floor(timem))
								logAction("Banned "..getPlayerName(e).." from police team for ("..reason..") "..math.floor(timem).." Minutes",ps)
								if isLaw(e) or seemsLaw(e) then
									triggerEvent("onQuitJob",e,getElementData(e,"Occupation"))
								end
							end

						else
							exports.DENjob:banFromJob(exports.server:getPlayerAccountName(e),"LawBan",math.floor(timem))
							logAction("Banned "..getPlayerName(e).." from police team ("..reason..") for 60 Minutes",ps)
							if isLaw(e) or seemsLaw(e) then
								triggerEvent("onQuitJob",e,getElementData(e,"Occupation"))
							end
						end
					end
			end
		else
			exports.NGCdxmsg:createNewDxMessage(ps,"You do not have permission to use this command!",255,0,0)
	end
end)

addEvent("policeUnBan",true)
addEventHandler("policeUnBan",root,function(target)
	local ps = source

	local acc = exports.server:getPlayerAccountName(ps)

	if (chiefs[acc]) then

		if chiefs[acc] >= 4 then
			local name = getPlayerName(target)
			if (name) then

				local e = target

				if (e) and isElement(e) then

					local acc = exports.server:getPlayerAccountName(e)

					if exports.DENjob:unbanFromJob(acc,"LawBan") == true then

						logAction("Unbanned "..getPlayerName(e).." from Law Enforcement",ps)

						exports.NGCdxmsg:createNewDxMessage(e,"You have been unbanned from Law Enforcement",0,255,0)

					else

						exports.NGCdxmsg:createNewDxMessage(ps,name.." was not banned",255,0,0)

					end

				else

					exports.NGCdxmsg:createNewDxMessage(ps,name.." is not a valid player",255,0,0)

				end

			else

				exports.NGCdxmsg:createNewDxMessage(ps,"You did not specify a player name",255,0,0)

			end

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



	saved = (xmlNodeGetValue (xmlFindChild(xmlHudBranch,"saved",0)))



	logs = fromJSON(saved)



	if logs == nil then logs = {} end

	setTimer(function() for k,v in pairs(getElementsByType("player")) do sendLogs(v) end end,5000,1)

	xmlSaveFile(xmlRootTree)

	local t=exports.DENmysql:query( "SELECT * FROM serverstats WHERE name=? LIMIT 1", "policeChiefRoster" )

	local res = false

	if t == nil then

		t = chiefs

	else

		local ts = nil

		for k,v in pairs(t) do

			ts = v.value

			ts = fromJSON(ts)

			break

		end

		chiefs = ts

	end

end

loads()
