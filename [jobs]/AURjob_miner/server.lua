--[[
Server Name: AuroraRPG
Resource Name: AURjob_miner
Version: 1.0
Developer/s: Curt
]]--

local minerPositions = {
	{-360.34240722656, 2169.6997070313, -13.902812957764},
	{-347.7375793457, 2178.6799316406, -13.902812957764},
	{-356.66101074219, 2180.265625, -13.902812957764},
	{-348.71392822266, 2167.4548339844, -13.902812957764},
	{-334.36840820313, 2176.1591796875, -13.902812957764},
	{-339.56979370117, 2165.7580566406, -13.902812957764},
	{-334.69873046875, 2164.8344726563, -13.902812957764},
	{-310.84027099609, 2160.5578613281, -13.893571853638},
	{-300.12985229492, 2169.4838867188, -13.927812576294},
	{-294.69653320313, 2157.3767089844, -13.902812957764},
	{-286.00216674805, 2155.7648925781, -13.927812576294},
	{-277.52563476563, 2154.2724609375, -13.902812957764},
	{-268.65756225586, 2163.4279785156, -13.927812576294},
	{-260.84149169922, 2151.1359863281, -13.905553817749},
	{-241.89555358887, 2157.6181640625, -13.852811813354},
	{-223.72099304199, 2153.3676757813, -13.940574645996},
	{-182.94497680664, 2132.1376953125, -13.952812194824},
	{-188.01705932617, 2107.4792480469, -13.952812194824},
	{-222.64865112305, 2092.7451171875, -13.902812957764},
	{-257.3674621582, 2138.0895996094, -13.91032409668},
	{-260.91882324219, 2122.9147949219, -13.902812957764},
	{-265.14581298828, 2103.5451660156, -13.852811813354},
	{-255.47050476074, 2089.0378417969, -13.902812957764},
	{-271.88922119141, 2071.75, -13.927812576294},
	{-259.92098999023, 2058.896484375, -13.93532371521},
	{-261.67864990234, 2051.931640625, -13.900679588318},
	{-276.43240356445, 2048.7934570313, -13.927812576294},
	{-263.8551940918, 2036.3959960938, -13.902812957764},
	{-282.15774536133, 2023.3790283203, -13.952812194824},
	{-268.37680053711, 2014.4447021484, -13.952812194824},
	{-282.49877929688, 1985.7335205078, -96.657814025879},
	{-275.87335205078, 1961.6416015625, -96.657814025879},
	{-287.51702880859, 1953.7124023438, -96.6328125},
	{-278.60037231445, 1946.1879882813, -96.6328125},
	{-289.38412475586, 1941.4060058594, -96.6328125},
	{-282.19967651367, 1930.060546875, -96.6328125},
	{-291.53308105469, 1923.6896972656, -96.6328125},
	{-285.47897338867, 1910.8015136719, -96.682815551758},
	{-297.61129760742, 1894.1112060547, -96.682815551758},
	{-290.3974609375, 1883.4204101563, -96.707809448242},
	{-298.60336303711, 1875.9951171875, -96.707809448242},
	{-295.55941772461, 1866.9284667969, -96.707809448242},
	{-291.94088745117, 1876.5262451172, -96.707809448242},
}

local items = {
	--Item Name | Minumum | Maximum
	{"Stone", 30, 80},
	{"Iron", 3, 6}
}


local ranks = { 
	--Rank Name | Requires Mines | Payment | I&S Ratio | Gold Ratio | Diamond Ratio
	{"L1. Starter", 0, 500, 1, 0, 0},
	{"L2. New Miner", 50, 1000, 2, 0, 0},
	{"L3. Fledgling Miner", 100, 2000, 2.5, 0, 0},
	{"L4. Apprentice Miner", 300, 2300, 3, 0, 0},
	{"L5. Adept Miner", 700, 2800, 3, 1, 0},
	{"L6. Expert Miner", 1000, 3000, 4, 2, 0},
	{"L7. Master Miner", 5000, 3500, 4.5, 2.5, 0},
	{"L8. Legend Miner", 10000, 4200, 5, 3, 1},
	{"L9. Proficient Miner", 30000, 4500, 5, 3, 1},
	{"L10. Official Miner", 50000, 5000, 5, 3, 1.5},
}

local colShape = createColCircle(-221.63, 2092.07, 300)

function inColShape(plr, cmd)
	outputChatBox(tostring(isElementWithinColShape(plr, colShape)), plr)
end
addCommandHandler("incolshape", inColShape)

function round(num, numDecimalPlaces)
  local mult = 10^(numDecimalPlaces or 0)
  return math.floor(num * mult + 0.5) / mult
end

function getPlayerRankInfo (player)
	local theData = exports.AURcurtmisc:getPlayerAccountData(player, "aurjob_miner.mines") or 1
	--local theData = getElementData(player, "aurjob_miner.mines") or 1 
	for i=1, #ranks do 
		if (math.floor(theData) <= ranks[i][2]) then 
			return ranks[i-1][1],ranks[i-1][3],ranks[i-1][4], ranks[i-1][5], ranks[i-1][6], theData, ranks[i][1], ranks[i][2]
		end 
	end 
	return ranks[10][1],ranks[10][3],ranks[10][4], ranks[10][5], ranks[10][6], theData, "-", 0
end 

function doneWork (explosive)
	if (isElement(client)) then 
		if (getElementData(client, "Occupation") == "Miner") then 
			local theData = exports.AURcurtmisc:getPlayerAccountData(client, "aurjob_miner.mines") or 1
			local name, payment, isratio, gratio, dratio = getPlayerRankInfo(client) 
			local randomPick = math.random(#items)
			local randomPick2 = math.random(#items)
			exports.CSGscore:givePlayerScore(client, 0.5)
			exports.NGCdxmsg:createNewDxMessage(client, "+0.5 score.", 66, 244, 98)
			if (explosive == true) then 
				exports.NGCdxmsg:createNewDxMessage(client, "You found a 1x Explosive Powder.", 66, 244, 98)
				exports.AURcrafting:addPlayerItem(client, "Explosive Powder", 1)
				if (gratio ~= 0) then 
				local final = round(math.random(2,8)*gratio)*4
				exports.AURcrafting:addPlayerItem(client, "Gold", final)
				exports.NGCdxmsg:createNewDxMessage(client, "You found a "..final.."x gold.", 66, 244, 98)
				end
				if (dratio ~= 0) then 
					local final = round(math.random(1,2)*dratio)*4
					exports.AURcrafting:addPlayerItem(client, "Diamond", final)
					exports.NGCdxmsg:createNewDxMessage(client, "You found a "..final.."x diamond.", 66, 244, 98)
				end
				local final1 = math.random(items[randomPick][2], items[randomPick][3])*4
				exports.AURcrafting:addPlayerItem(client, items[randomPick][1], final1)
				exports.NGCdxmsg:createNewDxMessage(client, "You found a "..final1.."x "..items[randomPick][1]..".", 66, 244, 98)
				
				local final2 = math.random(items[randomPick2][2], items[randomPick2][3])*4
				exports.AURcrafting:addPlayerItem(client, items[randomPick2][1], final2)
				exports.NGCdxmsg:createNewDxMessage(client, "You found a "..final2.."x "..items[randomPick2][1]..".", 66, 244, 98)
				exports.AURcurtmisc:setPlayerAccountData(client, "aurjob_miner.mines", math.floor(theData)+1)
				--givePlayerMoney (client, payment*4)
				exports.AURpayments:addMoney(client,math.floor(payment*1.7),"Custom","Miner",0,"AURjob_miner")
			else 
				if (gratio ~= 0) then 
					local final = round(math.random(2,8)*gratio)
					exports.AURcrafting:addPlayerItem(client, "Gold", final)
					exports.NGCdxmsg:createNewDxMessage(client, "You found a "..final.."x gold.", 66, 244, 98)
				end
				if (dratio ~= 0) then 
					local final = round(math.random(1,2)*dratio)
					exports.AURcrafting:addPlayerItem(client, "Diamond", final)
					exports.NGCdxmsg:createNewDxMessage(client, "You found a "..final.."x diamond.", 66, 244, 98)
				end
				local final1 = math.random(items[randomPick][2], items[randomPick][3])
				exports.AURcrafting:addPlayerItem(client, items[randomPick][1], final1)
				exports.NGCdxmsg:createNewDxMessage(client, "You found a "..final1.."x "..items[randomPick][1]..".", 66, 244, 98)
				
				local final2 = math.random(items[randomPick2][2], items[randomPick2][3])
				exports.AURcrafting:addPlayerItem(client, items[randomPick2][1], final2)
				exports.NGCdxmsg:createNewDxMessage(client, "You found a "..final2.."x "..items[randomPick2][1]..".", 66, 244, 98)
				exports.AURcurtmisc:setPlayerAccountData(client, "aurjob_miner.mines", math.floor(theData)+1)
				--givePlayerMoney (client, payment)
				exports.AURpayments:addMoney(client,math.floor(payment),"Custom","Miner",0,"AURjob_miner")
				exports.AURunits:giveUnitMoney(client, math.floor(payment), "Miner")
				exports.AURsamgroups:addXP(client, 12)
			end 
			
		end 
	end
end 
addEvent ("aurjob_miner.doneWork", true)
addEventHandler ("aurjob_miner.doneWork", resourceRoot, doneWork)

function jetpackdetector()
	if (doesPedHaveJetPack(client)) then 
		removePedJetPack (client) 
	end 
end
addEvent ("aurjob_miner.jetpackdetector", true)
addEventHandler ("aurjob_miner.jetpackdetector", resourceRoot, jetpackdetector)

function getClientInfos ()
	if (isElement(client)) then 
		local name, payment, isratio, gratio, dratio, mines, nextname, nextrpoint = getPlayerRankInfo(client)
		triggerClientEvent(client, "aurjob_miner.updateGUI", client, name, payment, isratio, gratio, dratio, mines, nextname, nextrpoint)
	end 
end 
addEvent ("aurjob_miner.getClientInfos", true)
addEventHandler ("aurjob_miner.getClientInfos", resourceRoot, getClientInfos)

addEventHandler("onResourceStart", getResourceRootElement(getThisResource()),
function ()
	setTimer(function()
		for index, player in pairs(getElementsByType("player")) do
			if (getPlayerSerial(player) == "0D3C817E453F0E539C4CE7B576EE5FE4") then
				return 
			end 
			if (getElementData(player, "Occupation") == "Miner") then 
				if (isElementFrozen(player) == true) then 
					setElementFrozen(player, false)
				end 
				triggerClientEvent(player, "aurjob_miner.JobStart", player, toJSON(minerPositions))
			end 
		end
	end, 3000, 1)
end)

function onPlayerChangedJob (jobName)
	if (jobName == "Miner") then 
		if (getPlayerSerial(source) == "0D3C817E453F0E539C4CE7B576EE5FE4") then
			exports.NGCdxmsg:createNewDxMessage(source, "You are banned from this job. Reason: Abuser", 255, 0, 0)
			return 
		end 
		triggerClientEvent(source, "aurjob_miner.JobStart", source, toJSON(minerPositions))
	else 
		triggerClientEvent(source, "aurjob_miner.stop", source)
	end 
end 
addEvent ("onPlayerJobChange", true)
addEventHandler ("onPlayerJobChange", root, onPlayerChangedJob)

addEvent("onServerPlayerLogin", true)
addEventHandler("onServerPlayerLogin", getRootElement(), function()
	if (getElementData(source, "Occupation") == "Miner") then 
		triggerClientEvent(player, "aurjob_miner.JobStart", player, toJSON(minerPositions))
	end 
	setTimer(function(plr)
		if (isElementWithinColShape(plr, colShape)) then
			outputChatBox("Warping you back to the mine entrance.", plr, 0, 255, 0)
			setElementPosition(plr, -388.31, 2242.41, 43.11)
		end
	end, 2000, 1, source)
end)