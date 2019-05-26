playerTrailers = {}
doesAccountHaveLicense = {}
licenseDB = dbConnect("sqlite", "license.db")
dbExec(licenseDB, "CREATE TABLE IF NOT EXISTS licenses(accName TEXT)")

function loadLicenseCache()
	local result = dbPoll(dbQuery(licenseDB, "SELECT * FROM licenses"), -1)
	--if (#result < 1) then
	--	return true
	--end
	for i, v in pairs(result) do
		doesAccountHaveLicense[v.accName] = true
	end
	for i, v in ipairs(getElementsByType("player")) do
		if (exports.server:isPlayerLoggedIn(v)) then
			local acc = exports.server:getPlayerAccountName(v)
			if (doesAccountHaveLicense[acc]) then
				setTimer(triggerClientEvent, 2000, 1, v, "AURtruck.licenseStatus", v, true)
			end
		end
	end
end
loadLicenseCache()

function addLicense(player)
	local acc = exports.server:getPlayerAccountName(player)
	if (doesAccountHaveLicense[acc]) then
		return true
	end
	doesAccountHaveLicense[acc] = true
	dbExec(licenseDB, "INSERT INTO licenses(accName) VALUES(?)", acc)
end

function buyLicense()
	local acc = exports.server:getPlayerAccountName(client)
	if (doesAccountHaveLicense[acc]) then
		outputChatBox("You already have a trucking license.", client, 255, 255, 0)
		return false
	end
	if (getPlayerMoney(client) < 5000000) then
		outputChatBox("You don't have enough money to buy a trucking license", client, 255, 0, 0)
		return false
	end
	exports.AURpayments:takeMoney(client, 5000000, "AURtruck - trucker license")
	addLicense(client)
	triggerClientEvent(client, "AURtruck.licenseStatus", client, true)
	outputChatBox("You sucessfully bought a trucker's license!", client, 0, 255, 0)
end
addEvent("AURtruck.buyLicense", true)
addEventHandler("AURtruck.buyLicense", resourceRoot, buyLicense)

function getPointFromDistanceRotation(x, y, dist, angle)
    local a = math.rad(angle - 90);
    local dx = math.cos(a) * dist;
    local dy = math.sin(a) * dist;
    return x + dx, y+ dy;
end

trailers = {
	435,
	450,
	591,
	584
}

function createPlayerTrailer()
	if (isElement(playerTrailers[client])) then 
		destroyElement(playerTrailers[client]) 
	end
	local playerVeh = getPedOccupiedVehicle(client)
	local x,y,z = getElementPosition(playerVeh)
	local rx,ry,rz = getElementRotation(playerVeh)
	local endX, endY = getPointFromDistanceRotation(x, y, 8, rz)
	local trailer = createVehicle(trailers[math.random(1, #trailers)], endX, endY,z + 0.5)
	attachTrailerToVehicle(playerVeh, trailer)
	triggerClientEvent(client, "trailerAttached", trailer)
	playerTrailers[client] = trailer
end
addEvent("trucking_CreatePlayerTrailer", true)
addEventHandler("trucking_CreatePlayerTrailer", resourceRoot, createPlayerTrailer)

function destroyTrailer(trailer)
	if (isElement(trailer)) then
		destroyElement(trailer)
	end
	if (isElement(playerTrailers[client])) then 
		destroyElement(playerTrailers[client]) 
	end
	playerTrailers[client] = nil
end
addEvent("trucking_DestroyTrailer", true)
addEventHandler("trucking_DestroyTrailer", resourceRoot, destroyTrailer)

function giveReward(price, dist)
	local score = 0
	if (not dist or not tonumber(dist)) then 
		score = 1 
	elseif (dist > 0) then 
		score = 2 
	elseif (dist > 2500) then 
		score = 5 
	elseif (dist > 5000) then 
		score = 10 
	end
	--exports.CSGaccounts:addPlayerMoney(client, exports.NGCVIP:getVIPPaymentBonus(client, price))
	exports.AURpayments:addMoney(client, price, "Custom", "Trucker", 0, "AURTruck")
	exports.CSGscore:givePlayerScore(client, score)
	exports.CSGranks:addStat(client, 1)
	exports.AURunits:giveUnitMoney(client, price, "Trucker delivery (AURtruck)", "Trucker")
	exports.NGCdxmsg:createNewDxMessage(client, "You have earned $"..price.." and "..score.." scores!", 0, 255, 0)
end
addEvent("trucking_GiveReward", true)
addEventHandler("trucking_GiveReward", resourceRoot, giveReward)

function onQuit()
	if (isElement(playerTrailers[source])) then 
		destroyElement(playerTrailers[source]) 
	end
end
addEventHandler("onPlayerQuit", root, onQuit)

function onLogin()
	local stops = exports.DENstats:getPlayerAccountData(source, "trucking")
	setElementData(source, "trucking_stopsDone", stops)
	local acc = exports.server:getPlayerAccountName(source)
	if (doesAccountHaveLicense[acc]) then
		triggerClientEvent(source, "AURtruck.licenseStatus", source, doesAccountHaveLicense[acc])
	end
end
addEventHandler("onPlayerLogin", root, onLogin)
