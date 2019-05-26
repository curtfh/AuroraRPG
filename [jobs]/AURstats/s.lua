local selected = {}

local de = function(e, k)
    return exports.denstats:getPlayerAccountData(e, k)
end

local dez = function(e, k)
    return exports.DENmysql:querySingle("SELECT * FROM playerstats WHERE userid=? LIMIT 1", e)[k]
end

local rank = function (e, occ)
	if e and occ then
		local name, num, maxs = exports.CSGranks:getRank(e, occ)
		if name and num and maxs then
			return name.." ("..num.."/"..maxs..")"
		else
			return "None (0/0)"
		end
	else
		return "None (0/0)"
	end
end

local rankz = function (e, occ)
	if e and occ then
		local name, num, maxs = exports.CSGranks:getRankAccountFromID(e, occ)
		if name and num and maxs then
			return name.." ("..num.."/"..maxs..")"
		else
			return "None (0/0)"
		end
	else
		return "None (0/0)"
	end
end



--GETTINGS MINER SHIT RANKS
local minerRank = {
	--Rank Name | Requires Mines | Payment | I&S Ratio | Gold Ratio | Diamond Ratio
	{"L1. Starter", 0},
	{"L2. New Miner", 50},
	{"L3. Fledgling Miner", 100},
	{"L4. Apprentice Miner", 300},
	{"L5. Adept Miner", 700},
	{"L6. Expert Miner", 1300},
	{"L7. Master Miner", 1600},
	{"L8. Legend Miner", 2400},
	{"L9. Proficient Miner", 3000},
	{"L10. Official Miner", 6000},
}


function getPlayerRankInfo (player)
	local theData = exports.AURcurtmisc:getPlayerAccountData(player, "aurjob_miner.mines") or 1
	--local theData = getElementData(player, "aurjob_miner.mines") or 1 
	for i=1, #minerRank do 
		if (math.floor(theData) <= minerRank[i][2]) then 
			return minerRank[i-1][1].." ("..theData.."/6000)"
		end 
	end 
	return minerRank[10][1].." ("..theData.."/~)"
end 

function getPlayerRankInfoz (player)
	local theData = exports.DENmysql:querySingle("SELECT * FROM playerstats WHERE userid=? LIMIT 1", player)["aurjob_miner.mines"] or 1
	--local theData = getElementData(player, "aurjob_miner.mines") or 1 
	for i=1, #minerRank do 
		if (math.floor(theData) <= minerRank[i][2]) then 
			return minerRank[i-1][1].." ("..theData.."/6000)"
		end 
	end 
	return minerRank[10][1].." ("..theData.."/~)"
end 
--END OF MINER SHIT

function getChiefStatus(e)
    local s = getElementData(e, "polc")
    if s == false then return "No" end
    return  "Chief level "..s..""
end

function getStats(player, account)
	if (account == true) then 		
		local accID = exports.DENmysql:querySingle("SELECT id FROM accounts WHERE username=? LIMIT 1", player)
		if (not accID) then
			outputChatBox("Account not found", client, 255, 255, 0)
			return false
		end
		accID = accID["id"]
		local kills = dez(accID, "kills")
		local deaths = dez(accID, "deaths")
		local kdr = kills/deaths
		if kills == 0 or deaths == 0 then kdr = "Undefined" end
		if tonumber(kdr) then kdr = string.format("%.2f", kdr) end
		data = {
			Civilian = {
				{"Diver rank", rankz(accID, "Diver")},
				{"Trucker rank", rankz(accID, "Trucker")},
				{"Pilot rank", rankz(accID, "Pilot")},
				{"Fisherman rank", rankz(accID, "Fisherman")},
				{"Farmer rank", rankz(accID, "Farmer")},
				{"Firefighter rank", rankz(accID, "Firefighter")},
				{"Lumberjack rank", rankz(accID, "Lumberjack")},
				{"Rescuer rank", rankz(accID, "Rescuer Man")},
				{"Paramedic rank", rankz(accID, "Paramedic")},
				{"Taxi Driver rank", rankz(accID, "Taxi Driver")},
				{"Trash Collector rank",  rankz(accID, "Trash Collector")},
				{"Miner rank",  getPlayerRankInfoz(accID)}
			},
			Law = {
				{"Arrests",  dez(accID, "arrests")},
				{"Arrest points",  dez(accID, "arrestpoints")},
				{"Assists",  dez(accID, "tazerassists")},
				{"Radio turfs taken as cop",  dez(accID, "radioTurfsTakenAsCop")},
				{"Armoured truck escorts",  dez(accID, "armoredtrucks")},
				{"Bankrob participations",  dez(accID, "brcrlaw")},
				{"DS participations",  dez(accID, "drugshipmentlaw")},
				{"Flags delivered",  dez(accID, "flags")},
			},
			Criminal = {
				{"House robbed as Thief",  dez(accID, "thief")},
				{"Turfs taken",  dez(accID, "turfsTaken")},
				{"Radio turfs taken as criminal",  dez(accID, "radioTurfsTakenAsCrim")},
				{"Bankrob fails",  dez(accID, "brcrcrimfail")},
				{"Bankrob successes",  dez(accID, "brcrcrimsuccess")},
				{"Store Robbery successes",  dez(accID, "storescrimsuccess") or 0},
				{"Flags delivered",  dez(accID, "flags")},
				{"DS participations",  dez(accID, "drugshipmentcrim")},
				{"Kills",  kills},
				{"Deaths",  deaths},
				{"Kill/Death Ratio", kdr}
			}
		}
	else
		if not (exports.server:isPlayerLoggedIn(player)) then
			exports.NGCdxmsg:createNewDxMessage("This player is not logged in",client,255,0,0)
			return false
		end
		if (selected[player] == false) then
			outputChatBox("Sorry, this player doesn't want to share his stats", client, 255, 0, 0)
			return
		end
		local kills = de(player, "kills")
		local deaths = de(player, "deaths")
		local kdr = kills/deaths
		if kills == 0 or deaths == 0 then kdr = "Undefined" end
		if tonumber(kdr) then kdr = string.format("%.2f", kdr) end
		data = {
			Civilian = {
				{"Diver rank", rank(player, "Diver")},
				{"Trucker rank", rank(player, "Trucker")},
				{"Pilot rank", rank(player, "Pilot")},
				{"Fisherman rank", rank(player, "Fisherman")},
				{"Farmer rank", rank(player, "Farmer")},
				{"Firefighter rank", rank(player, "Firefighter")},
				{"Lumberjack rank", rank(player, "Lumberjack")},
				{"Rescuer rank", rank(player, "Rescuer Man")},
				{"Paramedic rank", rank(player, "Paramedic")},
				{"Taxi Driver rank", rank(player, "Taxi Driver")},
				{"Trash Collector rank",  rank(player, "Trash Collector")},
				{"Miner rank",  getPlayerRankInfo(player)}
			},
			Law = {
				{"Arrests",  de(player, "arrests")},
				{"Arrest points",  de(player, "arrestpoints")},
				{"Assists",  de(player, "tazerassists")},
				{"Police chief",  getChiefStatus(player)},
				{"Radio turfs taken as cop",  de(player, "radioTurfsTakenAsCop")},
				{"Armoured truck escorts",  de(player, "armoredtrucks")},
				{"Bankrob participations",  de(player, "brcrlaw")},
				{"DS participations",  de(player, "drugshipmentlaw")},
				{"Flags delivered",  de(player, "flags")},
			},
			Criminal = {
				{"House robbed as Thief",  de(player, "thief")},
				{"Turfs taken",  de(player, "turfsTaken")},
				{"Radio turfs taken as criminal",  de(player, "radioTurfsTakenAsCrim")},
				{"Bankrob fails",  de(player, "brcrcrimfail")},
				{"Bankrob successes",  de(player, "brcrcrimsuccess")},
				{"Store Robbery successes",  de(player, "storescrimsuccess") or 0},
				{"Flags delivered",  de(player, "flags")},
				{"DS participations",  de(player, "drugshipmentcrim")},
				{"Kills",  kills},
				{"Deaths",  deaths},
				{"Kill/Death Ratio", kdr}
			}
		}
	end 
    
    
    triggerClientEvent(client, "AURstats.send", resourceRoot, data)
end
addEvent("AURstats.get", true)
addEventHandler("AURstats.get", resourceRoot, getStats)

addEventHandler("onPlayerJoin", root,
    function()
        triggerClientEvent("refreshPlayers", resourceRoot, Element.getAllByType("player"))
        selected[source] = true
    end
)

addEventHandler("onPlayerQuit", root,
    function()
        triggerClientEvent("refreshPlayers", resourceRoot, Element.getAllByType("player"))
        selected[source] = nil
    end
)

setTimer(
    function()
        triggerClientEvent("refreshPlayers", resourceRoot, Element.getAllByType("player"))
        for _, v in ipairs(Element.getAllByType("Player")) do
            selected[v] = true
        end
    end, 2500, 1
)

addEvent("refreshSelected", true)

addEventHandler("refreshSelected", resourceRoot,
    function(select)
        selected[client] = select
        triggerClientEvent("refreshStats", resourceRoot, client, select)
    end
)

function canShowState(player)
    if not (selected[player] == nil)then
        return selected[player]
    else
        return nil
    end
end
