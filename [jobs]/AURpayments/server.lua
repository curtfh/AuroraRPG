local theTable = {
	-- Name , Type , payment depends on type 1 or 0 same v[3],v[4]
	{"Clothes Seller","Custom"}, --- check the resource it maybe by distance or something like that
	{"Firefighter","Type",15,30}, --- we check if Type == 1 then payment is v[3] else payment is v[4]
	{"Trash Collector","Custom"}, --- check the resource it maybe by distance or something like that
	{"Paramedics","Custom"},  --- check the resource it maybe by distance or something like that
	{"Trucker","Custom"}, --- check the resource it maybe by distance or something like that
	{"Pilot","Custom"}, --- check the resource it maybe by distance or something like that
	{"Street Cleaner","Custom"}, --- check the resource it maybe by distance or something like that
	{"Mechanic","Custom"}, --- check the resource it maybe by distance or something like that
	{"Fisherman","Custom"}, --- check the resource it maybe by distance or something like that
	{"Farmer","Custom"},
	{"Lumberjack","Normal",1500},
	{"Rescuer Man","Custom"}, --- check the resource it maybe by distance or something like that
	{"Taxi Driver","Custom"}, --- check the resource it maybe by distance or something like that
	{"Miner","Custom"}, --- check the resource it maybe by distance or something like that
	{"CTC","Custom"}, --- Capture the City Event
	{"24/7 Conv Store","Custom"}, --- Conv Store
	{"Easter Event","Custom"}, --- Conv Store
	{"Automatic Donation","Custom"}, --- Conv Store
	{"Racing","Custom"}, --- Conv Store
	{"Pizza Boy","Custom"},


	{"Event","Custom"}, --- check the resource it maybe by distance or something like that
	{"Misc","Custom"}, --- check the resource it maybe by distance or something like that
	{"Robber","Custom"}, --- check the resource it maybe by distance or something like that
	{"Groups","Custom"}, --- check the resource it maybe by distance or something like that
	{"ATM","Custom"}, --- check the resource it maybe by distance or something like that
	{"Turfing","Custom"}, --- check the resource it maybe by distance or something like that
	{"Groups Turfing","Custom"}, --- check the resource it maybe by distance or something like that
	{"Sea Turfing","Custom"}, --- check the resource it maybe by distance or something like that
	{"Turfing Bag","Custom"}, --- check the resource it maybe by distance or something like that
	{"Turfing Defend","Custom"}, --- check the resource it maybe by distance or something like that
	{"Pirates CnR Event","Custom"}, --- check the resource it maybe by distance or something like that
	{"Criminal Promotion","Custom"}, --- check the resource it maybe by distance or something like that
	{"Daily Rewards","Custom"}, --- check the resource it maybe by distance or something like that
	{"Aurora Cases","Custom"}, --- check the resource it maybe by distance or something like that
	{"Aurora Core","Custom"}, --- check the resource it maybe by distance or something like that


}
local players = {}
---srun exports.AURpayments:addMoney(getPlayerFromName("AFK"),5000,"Custom","Taxi Driver",0,"runcode")
function addMoney(player,money,paymentType,job,arv)
	resourceName = getResourceName(sourceResource) or "N/A"
	if player and isElement(player) then
		if money and tonumber(money) and tonumber(money) > 0 then
			for k,v in ipairs(theTable) do
				if v[1] == job then
					if v[2] == paymentType then
						local pType = v[2]
						if pType == "Normal" then
							--outputDebugString(getPlayerName(player).." has earned "..v[3])
							setMoney(player,v[3],resourceName,pType,job)
						elseif pType == "Type" then
							if arv == 1 then
						---		outputDebugString("XDPlayerMoney(player,v[3])")
								setMoney(player,v[3],resourceName,pType,job)
							elseif arv == 2 then
						---		outputDebugString("XDPlayerMoney(player,v[4])")
								setMoney(player,v[4],resourceName,pType,job)
							end
						elseif pType == "Custom" then
						---	outputDebugString("XDPlayerMoney(player,money)")
							if (job == "Clothes Seller") then 
								exports.AURsamgroups:addXP(player, 1)
							elseif (job == "Firefighter") then 
								exports.AURsamgroups:addXP(player, 2)
							elseif (job == "Trash Collector") then 
								exports.AURsamgroups:addXP(player, 3)
							elseif (job == "Trucker") then 
								exports.AURsamgroups:addXP(player, 4)
							elseif (job == "Pilot") then 
								exports.AURsamgroups:addXP(player, 5)
							elseif (job == "Street Cleaner") then 
								exports.AURsamgroups:addXP(player, 6)
							elseif (job == "Mechanic") then 
								exports.AURsamgroups:addXP(player, 7)
							elseif (job == "Farmer") then 
								exports.AURsamgroups:addXP(player, 8)
							elseif (job == "Lumberjack") then 
								exports.AURsamgroups:addXP(player, 9)
							elseif (job == "Rescuer Man") then 
								exports.AURsamgroups:addXP(player, 10)
							elseif (job == "Taxi Driver") then 
								exports.AURsamgroups:addXP(player, 11)
							elseif (job == "Miner") then 
								exports.AURsamgroups:addXP(player, 12)
							end 
							setMoney(player,money,resourceName,pType,job)
						else
							--outputDebugString("Failed to give player money, payment type not found return "..resourceName)
						end
						--outputDebugString(pType.." is now with "..job)
						return true
					end
					break
				end
			end
		else
			--outputDebugString("Failed to give player money, no money value found return "..resourceName)
		end
	else
		--outputDebugString("Failed to give player money, no player element found return "..resourceName)
	end
end

function setMoney(player,theMoney,resourceName,paymentType,job)
	if player and isElement(player) then
		givePlayerMoney( player, tonumber( theMoney ) )
		players[player] = getPlayerMoney(player)
		--exports.DENmysql:exec( "UPDATE accounts SET money=? WHERE id=?", ( tonumber( theMoney ) + getPlayerMoney( player ) ), exports.server:getPlayerAccountID( player ) )
		exports.CSGlogging:createLogRow ( player, "money", getPlayerName( player ).." has earned $"..exports.server:convertNumber(theMoney).." from resource: ("..resourceName..")" )
		addMoneyLog(getPlayerName(player).." (Account: "..exports.server:getPlayerAccountName(player).." ) has been given money $"..exports.server:convertNumber(theMoney).." ("..paymentType..") ("..job..") by resource "..resourceName)
		return true
	end
end

function takeMoney(player,theMoney,resourceName)
	if player and isElement(player) then
		takePlayerMoney( player, tonumber( theMoney ) )
		players[player] = getPlayerMoney(player)
		--exports.DENmysql:exec( "UPDATE accounts SET money=? WHERE id=?", ( tonumber( theMoney ) + getPlayerMoney( player ) ), exports.server:getPlayerAccountID( player ) )
		addRemoveLog(getPlayerName(player).." (Account: "..exports.server:getPlayerAccountName(player).." ) money "..exports.server:convertNumber(theMoney).." has been removed by Resource "..resourceName)
		exports.CSGlogging:createLogRow ( player, "money", "$"..exports.server:convertNumber(theMoney).." removed from "..getPlayerName( player ).." by "..resourceName)
		return true
	end
end



local aPlayers = {}
setTimer ( function()
	for id, player in ipairs ( getElementsByType ( "player" ) ) do
		if aPlayers[player] then
			local money = getPlayerMoney ( player )
			local prev = aPlayers[player]
			if ( money ~= prev ) then
				--outputDebugString("CAS")
				if (not type(players[player]) == "number") then 
					exports.CSGlogging:createLogRow ( player, "moneyalert", "NOTICE: "..getPlayerName(player).." made unexpected earnings. Prev Money: $"..prev..", Now Money: $"..money.."")
					--outputDebugString("NOTICE 1: "..getPlayerName(player).." made unexpected earnings. Prev Money: $"..prev..", Now Money: $"..money.."")
					return 
				end
				if (money ~= players[player]) then 
					exports.CSGlogging:createLogRow ( player, "moneyalert", "NOTICE: "..getPlayerName(player).." made unexpected earnings. Prev Money: $"..prev..", Now Money: $"..money.."")
					--outputDebugString("NOTICE 2: "..getPlayerName(player).." made unexpected earnings. Prev Money: $"..prev..", Now Money: $"..money.."")
				end 
				aPlayers[player] = money
			end
		else 
			aPlayers[player] = getPlayerMoney ( player )
		end
	end
end, 500, 0 )

function getTimeDate()
	local aRealTime = getRealTime ( )
	return
	string.format ( "%04d/%02d/%02d", aRealTime.year + 1900, aRealTime.month + 1, aRealTime.monthday ),
	string.format ( "%02d:%02d:%02d", aRealTime.hour, aRealTime.minute, aRealTime.second )
end

function addRemoveLog(message)
	if (not message) then return end
	local date, time = getTimeDate()
	local final = "["..date.. " - "..time.."]"
	if (not fileExists("logs/takeMoney.log")) then
		log = fileCreate("logs/takeMoney.log")
	else
		log = fileOpen("logs/takeMoney.log")
	end
	if (not log) then return end
	if (not fileExists("logs/takeMoney.log")) then return end
	if (fileGetSize(log) == 0) then
		fileWrite(log, final.." "..message)
	else
		fileSetPos(log, fileGetSize(log))
		fileWrite(log, "\r\n", "takeMoney : "..final.." "..message)
	end
	fileClose(log)
end

function addMoneyLog(message)
	if (not message) then return end
	local date, time = getTimeDate()
	local final = "["..date.. " - "..time.."]"
	if (not fileExists("logs/AddMoney.log")) then
		log = fileCreate("logs/AddMoney.log")
	else
		log = fileOpen("logs/AddMoney.log")
	end
	if (not log) then return end
	if (not fileExists("logs/AddMoney.log")) then return end
	if (fileGetSize(log) == 0) then
		fileWrite(log, final.." "..message)
	else
		fileSetPos(log, fileGetSize(log))
		fileWrite(log, "\r\n", "AddMoney : "..final.." "..message)
	end
	fileClose(log)
end
