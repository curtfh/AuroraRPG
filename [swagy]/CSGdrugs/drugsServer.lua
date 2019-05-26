----------------------------------------------------------------------------------

 -- CSG

 -- CSGdrugs/drugsServer.slua

 -- Drugs

 -- Rozza

----------------------------------------------------------------------------------



local drugsTable = {}

local numToName = {

	[1] = "Ritalin",

	[2] = "LSD",

	[3] = "Cocaine",

	[4] = "Ecstasy",

	[5] = "Heroine",

	[6] = "Weed",

	["Ritalin"] = 1,

	["LSD"] = 2,

	["Cocaine"] = 3,

	["Ecstasy"] = 4,

	["Heroine"] = 5,

	["Weed"] = 6,

}



local obj = {

	[1] = 1580,

	[2] = 1575,

	[3] = 1576,

	[4] = 1577,

	[5] = 1578,

	[6] = 1579,

}

local dimensions = {
	[5001] = true, 
	[5002] = true, 
	[5004] = true,
}

local heroineEffect = {}

local droppedDrugs = {}

local noPickup = {}

local markEnt = {}

local ecstasyEffect = {}

--[[

local dFacEnter = createMarker(-1826.84, 43.76, 16.12, "arrow", 2, 255, 0, 0)

local dFacExit = createMarker(2541.69, -1304.01, 1026.07, "arrow", 2, 255, 0, 0)

setElementDimension(dFacExit, 10)

setElementInterior(dFacExit, 2)



function onmHit(element, dim)

	if (dim and isElement(element) and getElementType(element) == "player" and not getPedOccupiedVehicle(element) and not markEnt[element]) then

		if (getPlayerWantedLevel(element) > 0) then

			outputChatBox("You must be unwanted to enter the factory", element, 0, 255, 0)

			return false

		end

		markEnt[element] = true

		setTimer(function (element) markEnt[element] = nil end, 5000, 1, element)

		if (source == dFacEnter) then

			setPedWeaponSlot(element, 0)

			toggleControl(element, "fire", false)

			toggleControl(element, "previous_weapon", false)

			toggleControl(element, "next_weapon", false)

			toggleControl(element, "aim_weapon", false)

			setElementDimension(element, 10)

			setElementInterior(element, 2, 2541.69, -1304.01, 1025.07)

			return true

		elseif (source == dFacExit) then

			toggleControl(element, "previous_weapon", true)

			toggleControl(element, "next_weapon", true)

			toggleControl(element, "fire", true)

			toggleControl(element, "aim_weapon", true)

			setElementInterior(element, 0, -1826.84, 43.76, 16.12)

			setElementDimension(element, 0)

			return true

		end

	end

end

addEventHandler("onMarkerHit", dFacEnter, onmHit)

addEventHandler("onMarkerHit", dFacExit, onmHit)

]]

addEvent("callbackDrugsPanel",true)
addEventHandler("callbackDrugsPanel",root,function()
	local can,msg = exports.NGCmanagement:isPlayerLagging(source)
	if dimensions[getElementDimension(source)] then return false end	
	if can then
		triggerClientEvent(source,"onPlayerOpenDrugs",source)
	else
		exports.NGCdxmsg:createNewDxMessage(source,"You can't open (F4) drugs panel due "..msg,255,0,0)
	end
end)


function sendPlayerDrugs(player)

	if (not drugsTable[player]) then

		return false

	end

	if (not isElement(player)) then return false end

	triggerClientEvent(player, "CSGdrugs.sendDrugTable", player, drugsTable[player], numToName)

end



local ToName = {

	[1] = "Ritalin",

	[2] = "LSD",

	[3] = "Cocaine",

	[4] = "Ecstasy",

	[5] = "Heroine",

	[6] = "Weed",

}



function giveDrug(plr, drug, amount)

	if (isElement(plr) and drugsTable[plr]) then

		local drug = tostring(drug)

		local tysx = tostring(drug)

		if (type(drug) == "number") then

			drug = tostring(drug)

		else

			drug = tostring(numToName[drug])

		end

		if (not drug or drug == "") then

			outputChatBox("There was a problem with giving you some drugs, please report this to an administrator", plr, 0, 255, 0)

			return false

		end

		local amount2 = drugsTable[plr][drug]

		if (not amount2 or amount2 == "") then

			outputChatBox("There was a problem with giving you some drugs, please report this to an administrator", plr, 0, 255, 0)

			return false

		end

		drugsTable[plr][drug] = amount2 + amount

		sendPlayerDrugs(plr)

		for k,v in ipairs(getElementsByType("player")) do

			if getElementData(v,"isPlayerPrime") == true then

				outputChatBox(getPlayerName(plr).." has bought or pickedup drugs ( "..tysx.." ) ( "..amount.." ) ",v,255,255,0)

			end

		end

		return true

	else

		return false

	end

end
addEvent("CSGdrugs:giveDrug", true)
addEventHandler("CSGdrugs:giveDrug", root, giveDrug)


function takeDrug(plr, drug, amount)

	if (isElement(plr) and numToName[drug] and drugsTable[plr]) then

		local drug = drug

		local tysx = tostring(drug)

		if (type(drug) == "number") then

			drug = tostring(drug)

		else

			drug = tostring(numToName[drug])

		end

		local amount2 = drugsTable[plr][drug]

		if(amount2-amount < 0) then

			return false

		end

		drugsTable[plr][drug] = amount2 - amount

		sendPlayerDrugs(plr)

		for k,v in ipairs(getElementsByType("player")) do

			if getElementData(v,"isPlayerPrime") == true then



				outputChatBox(getPlayerName(plr).." has dropped or fucked up drugs ( "..tysx.." ) ( "..amount.." ) ",v,255,255,0)

			end

		end

		return true

	else

		return false

	end

end



function setDrug(plr, drug, amount)

	if (isElement(plr) and numToName[drug] and drugsTable[plr]) then

		local drug = drug

		if (type(drug) == "number") then

			drug = tostring(drug)

		else

			drug = tostring(numToName[drug])

		end

		drugsTable[plr][drug] = amount

		sendPlayerDrugs(plr)

		return true

	else

		return false

	end

end

local drugsXD = {}

function ds(plr,cmd,ty)

	if getElementData(plr,"isPlayerPrime") == true then

		for k,v in ipairs(getElementsByType("player")) do

			local id = exports.server:getPlayerAccountID(v)

			local dataxz = exports.DENmysql:querySingle("SELECT `drugs` FROM `playerstats` WHERE `userid` =? LIMIT 1", id)

			if (dataxz) then

				local datax = fromJSON(dataxz.drugs)

				drugsXD[v] = {}

				drugsXD[v] = datax

				for a,b in pairs(drugsXD[v]) do

					local a = tostring(a)

					local a2 = tonumber(a)

					if (numToName[a2]) then

						if tonumber(b) > 25000 then

							exports.NGCdxmsg:createNewDxMessage(plr,getPlayerName(v).." have ("..b.." of "..numToName[a2]..")",255,255,255)

							outputChatBox(getPlayerName(v).." have ("..b.." of "..numToName[a2]..")",plr,255,255,255)

							setDrug(v,a2,10000)

						end

					end

				end

			end

		end

	end

end

addCommandHandler("dealwithdrugs",ds)





local drugsXD2 = {}

function ds(plr,cmd,ty)

	if getElementData(plr,"isPlayerPrime") == true then

		for k,v in ipairs(getElementsByType("player")) do

			local id = exports.server:getPlayerAccountID(v)

			local dataxw2 = exports.DENmysql:querySingle("SELECT `drugs` FROM `playerstats` WHERE `userid` =? LIMIT 1", id)

			if (dataxw2) then

				local datax2 = fromJSON(dataxw2.drugs)

				drugsXD2[v] = {}

				drugsXD2[v] = datax2

				for a,b in pairs(drugsXD2[v]) do

					local a = tostring(a)

					local a2 = tonumber(a)

					if (numToName[a2]) then

						if tonumber(b) > 25000 then

							exports.NGCdxmsg:createNewDxMessage(plr,getPlayerName(v).." have ("..b.." of "..numToName[a2]..")",255,255,255)

							outputChatBox(getPlayerName(v).." have ("..b.." of "..numToName[a2]..")",plr,255,255,255)

						end

					end

				end

			end

		end

	end

end

addCommandHandler("dealwithdr",ds)







function getPlayerDrugs(player)

	if (drugsTable[player]) then

		return false

	end

	if (not isElement(player)) then return false end

	local id = exports.server:getPlayerAccountID(player)

	local data = exports.DENmysql:querySingle("SELECT `drugs` FROM `playerstats` WHERE `userid` =? LIMIT 1", id)

	if (data) then

		data = fromJSON(data.drugs)

		drugsTable[player] = {}

		drugsTable[player] = data

		sendPlayerDrugs(player)

	end

end



function getPlayerDrugsTable(player)

	return getPlayerDrugs(player) or drugsTable[player]

end



function getDrugNumber(name)

	return numToName[name]

end



function savePlayerDrugs(player, rem)

	if (isElement(player) and drugsTable[player]) then

		local id = exports.server:getPlayerAccountID(player)

		local data = toJSON(drugsTable[player])

		----exports.DENmysql:querySingle("UPDATE `playerstats` SET `drugs`=? WHERE `userid`=?", data, id)

		exports.DENmysql:exec("UPDATE playerstats SET drugs=? WHERE userid=?", data, id)

		if (rem) then

			drugsTable[player] = nil

		end

		return true

	else

		return false

	end

end



function resetDrugs(player,cmd,id)

	if getElementData(player,"isPlayerPrime") then

		if not id then

			outputChatBox("Please insert account ID of the player",player,255,0,0)

		return end

		local drugT = fromJSON('[ { "1": 0, "8": 0, "3": 0, "2": 0, "5": 0, "4": 0, "7": 0, "6": 0 } ]')

		local drugsStorage = toJSON(drugT)

		exports.DENmysql:exec("UPDATE playerstats SET drugs=? WHERE userid=?", drugsStorage, id)

		--drugsTable[player] = {}

	end

end

addCommandHandler("resetdrugs",resetDrugs)



function madeDrugS(name, hits)

	local hits = tonumber(hits)

	exports.CSGlogging:createLogRow( client, "drugs", getPlayerName( client ).." made " .. hits .. " hits of " .. name )

	giveDrug(client, name, hits)

end

addEvent("CSGdrugs.madeDrug", true)

addEventHandler("CSGdrugs.madeDrug", root, madeDrugS)



function onLogin()

	getPlayerDrugs(source)

end

addEvent("onServerPlayerLogin")

addEventHandler("onServerPlayerLogin", root, onLogin)



function onDeath()

	savePlayerDrugs(source, false)

end

addEventHandler("onPlayerWasted", root, onDeath)



function onQuit()

	savePlayerDrugs(source, true)

end

addEventHandler("onPlayerQuit", root, onQuit)



-- In case CSGdrugs is restarted with clients online.

function clientLoad()

	if (not drugsTable[client] and exports.server:getPlayerAccountID(client)) then

		getPlayerDrugs(client)

	end

end

addEvent("CSGdrugs.clientLoaded", true)

addEventHandler("CSGdrugs.clientLoaded", root, clientLoad)



-- On resource stop, save all drugs



function saveAllDrugs()

	for a, b in pairs(getElementsByType("player")) do

		if getElementData(b,"isPlayerPrime") then

			outputChatBox("All have auto save except you",b)

		else

			savePlayerDrugs(b, true)

		end

	end

end

addEventHandler("onResourceStop", resourceRoot, saveAllDrugs)

addEventHandler("onResourceStart", resourceRoot, function()

	for k,v in ipairs(getElementsByType("player")) do

		setPedStat(v,24,569)

	end

end)



function takeDrugS(id,am)

	local id = tostring(id)

	if (drugsTable[client]) then

		if (drugsTable[client][id] < 1) then

			exports.NGCdxmsg:createNewDxMessage(client, "You don't have enough drugs to do that", 0, 255, 0)

			return false

		end

		if (getPlayerIdleTime(client) > (1 * 60000 * 5)) then
			triggerClientEvent(client, "CSGdrugs:stopAllDrugs", client)
			return false
		end

		drugsTable[client][id] = drugsTable[client][id] - am

		triggerClientEvent(client, "CSGdrugs.takeDrugC", client, id,am)

	end

end

addEvent("CSGdrugs.takeDrug", true)

addEventHandler("CSGdrugs.takeDrug", root, takeDrugS)



function bot(fails)

	for a, b in pairs(getElementsByType("player")) do

		if (exports.server:isPlayerStaff(b)) then

			outputChatBox("(NGC) " .. getPlayerName(client) .. " is possibly trying to bot the drug factory (failed attempts: " .. fails .. ")", b, 255, 0, 0)

		end

	end

end

addEvent("CSGdrugs.reportBot", true)

addEventHandler("CSGdrugs.reportBot", root, bot)



function startEffect(drug)

	if (drug == "Ecstasy") then

		setPedStat(client, 24, 1000)

		ecstasyEffect[client] = true

	end

	if (drug == "Heroine") then

		heroineEffect[client] = true

	end

end

addEvent("CSGdrugs.drugEffectStart", true)

addEventHandler("CSGdrugs.drugEffectStart", root, startEffect)



function stopEffect(drug)

	if (drug == "Ecstasy") then

		if (ecstasyEffect[client]) then

			setPedStat(client, 24, 569)

			local hp = getElementHealth(client)

			if (hp > 100) then

				setElementHealth(client, 100)

			end

			ecstasyEffect[client] = nil

		end

	end

	if (drug == "Heroine") then

		heroineEffect[client] = nil

	end

end

addEvent("CSGdrugs.drugEffectStop", true)

addEventHandler("CSGdrugs.drugEffectStop", root, stopEffect)



local giveCD = {}



addEventHandler("onPlayerQuit",root,

	function()

		if (giveCD[source]) then

			giveCD[source] = nil

		end

	end

)



function damageLoss(att, wep, part, loss)

	if (heroineEffect[source]) then

		if not (giveCD[source]) then giveCD[source] = getTickCount() end

		if getPlayerPing(source) > 400 then

			if getTickCount() - giveCD[source] < 1000 then return end

		end

		if getPedArmor(source) <= 0 then

			local hp = getElementHealth(source)

			local loss = math.floor(loss)

			if (loss > 5) then

				if (hp > 20) then

					giveCD[source]=getTickCount()

					setElementHealth(source, hp + (loss / 20))

				end

			end

		end

	end

end

addEventHandler("onPlayerDamage", root, damageLoss)



function drugPickup(plr)

	cancelEvent()

	if (droppedDrugs[source] and not noPickup[plr]) then

		local data = droppedDrugs[source]

		if (isElement(source)) then

			giveDrug(plr, data["drug"], data["amount"])

			exports.NGCdxmsg:createNewDxMessage(plr, "You picked up " .. data["amount"] .. " hits of " .. data["drug"], 0, 255, 0)

			local whoDropped

			if (isElement(data["player"])) then

				whoDropped = getPlayerName(data["player"])

			else

				whoDropped = "N/A"

			end

			exports.CSGlogging:createLogRow ( plr, "drugs", getPlayerName( plr ).." picked up " .. data["amount"] .. " hits of " .. data["drug"] .. " dropped by " .. whoDropped )

			destroyElement(source)

		end

	end

end



antiHack = {}

smartTimer = {}

addEvent("onServerPlayerLogin",true)

addEventHandler("onServerPlayerLogin",root,function()

	antiHack[source] = true

	if isTimer(smartTimer[source]) then return false end

	smartTimer[source] = setTimer(function(player)

		antiHack[player] = false

	end,60000,1,source)

end)


local mypickups = {}
function dropDrug(name, amount)
	if (amount < 1) then
		exports.NGCdxmsg:createNewDxMessage(client, "You can't drop a negative amount of drugs", 0, 255, 0)
		return false
	end
	if (not drugsTable[client]) then 
		exports.NGCdxmsg:createNewDxMessage(client, "Unable to drop drugs. Please /reconnect!", 0, 255, 0)
		return false 
	end

	local id = numToName[tostring(name)]

	if (id) then

		if (drugsTable[client][tostring(id)] < amount) then

			exports.NGCdxmsg:createNewDxMessage(client, "You don't have enough drugs", 0, 255, 0)

			return false

		end

		if getElementData(client,"isPlayerCrafting") then

			exports.NGCdxmsg:createNewDxMessage(client, "You can't drop drugs while crafting drugs", 0, 255, 0)

			return false

		end

		if getElementData(client,"isPlayerMakingDrugs") then

			exports.NGCdxmsg:createNewDxMessage(client, "You can't drop drugs while making drugs", 0, 255, 0)

			return false

		end

		local can,msg = exports.NGCmanagement:isPlayerLagging(client)

		if can then

			local x,y,z = getElementPosition(client)

			local dim = getElementDimension(client)

			local int = getElementInterior(client)

			takeDrug(client, name, amount)

			local pickup = createPickup(x, y, z, 3, obj[id], 10000)
			setElementData(pickup,"owner",client)
			table.insert(mypickups,pickup)
			if (isElement(pickup)) then

				setElementDimension(pickup, dim)

				setElementInterior(pickup, int)

				droppedDrugs[pickup] = {player=client, drug=name, id=tostring(id), amount=amount}

				exports.NGCdxmsg:createNewDxMessage(client, "You dropped " .. amount .. " hits of " .. name, 0, 255, 0)

				exports.CSGlogging:createLogRow ( client, "drugs", getPlayerName( client ).." dropped " .. amount .. " hits of " .. name )

				noPickup[client] = true

				setTimer(function(client) noPickup[client] = nil end, 2000, 1, client)
				
				setElementData(pickup, "drugName", name)
				setElementData(pickup, "drugHits", amount)

				addEventHandler("onPickupHit", pickup, drugPickup)


			else

				exports.NGCdxmsg:createNewDxMessage(client, "Something went wrong with dropping drugs", 0, 255, 0)

				return false

			end

		else

			exports.NGCdxmsg:createNewDxMessage(client, "Something went wrong with dropping drugs because of lag!", 0, 255, 0)

		end

	end

end

addEvent("CSGdrugs.dropDrug", true)

addEventHandler("CSGdrugs.dropDrug", root, dropDrug)

addEventHandler("onPlayerQuit",root,function()
	if mypickups then
		for k,v in ipairs(mypickups) do
			if v and isElement(v) then
				local ow = getElementData(v,"owner")
				if ow and isElement(ow) and ow == source then
					if isElement(v) then destroyElement(v) end
				end
			end
		end
	end
end)
