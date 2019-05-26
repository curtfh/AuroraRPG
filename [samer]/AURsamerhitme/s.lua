local timer = {}
local lvtimer = {}

function startHit(p, cmd, amount)
	local amount = tonumber(amount)
	-- Checking part
	if not (exports.server:getPlayChatZone(p) == "LV") then 
		exports.NGCdxmsg:createNewDxMessage("You must be in Las Venturas to use this command!", p, 255, 0, 0)
	return false end
	if (getPlayerCount() < 20) then
		exports.NGCdxmsg:createNewDxMessage("There must be 20 players at least online to use this command", p, 255, 0, 0)
	return false end
	if not (amount) and not (type(amount) == "number") then
		exports.NGCdxmsg:createNewDxMessage("Wrong usage, use /hitme amount.", p, 255, 0, 0)
	return false end
	if (amount < 100000) or (amount > 1000000) then
		exports.NGCdxmsg:createNewDxMessage("Amount must be superior to $100,000 and inferior to $1,000,000", p, 255, 0, 0)
	return false end
	if (getPlayerMoney(p) < (amount)) then
		exports.NGCdxmsg:createNewDxMessage("You don't have enough money.", p, 255, 0, 0)
	return false end
	if (exports.server:getPlayerWantedPoints(p) > 0) then
		exports.NGCdxmsg:createNewDxMessage("You're wanted, you can't use this feature.", p, 255, 0, 0)
	return false end
	if (getElementData(p, "isHitme")) then
		exports.NGCdxmsg:createNewDxMessage("You already have a bounty on your head.", p, 255, 0, 0)
	return false end
	-- On hit part
	takePlayerMoney(p, amount)
	exports.NGCdxmsg:createNewDxMessage(""..getPlayerName(p).." has added a bounty of $"..exports.server:convertNumber(amount).." on himself.", root, 255, 0, 0)
	exports.NGCdxmsg:createNewDxMessage("You have one hour to find him and kill him before it is too late to get the money.", root, 255, 0, 0)
	setElementData(p, "isHitme", true)
	setElementData(p, "hitMeAmount", amount)
	-- Timer part
	timer[p] = setTimer(function(player, amount)
		exports.NGCdxmsg:createNewDxMessage(""..getPlayerName(player).." has survived and no one managed to kill him, therefore he wins.", root, 0, 255, 0)
		local newAmount = math.ceil(amount + (amount*25)/100)
		exports.NGCdxmsg:createNewDxMessage("You have won $"..exports.server:convertNumber(newAmount)..".", player, 0, 255, 0)
		givePlayerMoney(player, newAmount)
		setElementData(player, "isHitme", false)
		setElementData(player, "hitMeAmount", false)
		end, 60*60*1000, 1, p, amount)
	lvtimer[p] = setTimer(function(plr)
		local pX, pY, pZ = getElementPosition(plr) 
		local gZone = getZoneName(pX, pY, pZ, true) 
		if (gZone ~= "Las Venturas") then 
			if (isTimer(timer[plr])) then
				killTimer(timer[plr])
				exports.NGCdxmsg:createNewDxMessage("You left Las Venturas, therefore you lose your money.", plr, 255, 0, 0)
				killTimer(lvtimer[plr])
				setElementData(plr, "isHitme", false)
				setElementData(plr, "hitMeAmount", false)
			end 
		end
		end, 1000, 0, p)
end
addCommandHandler("hitme", startHit)

function onDead(totalAmmo, killer, killerWeapon, bodypart, stealth)
	if (killer) and (getElementType(killer) == "player") and (getElementData(source, "isHitme")) then
		exports.NGCdxmsg:createNewDxMessage(""..getPlayerName(killer).." has killed "..getPlayerName(source)..", therefore he wins the bounty.", root, 0, 255, 0)
		local money = getElementData(source, "hitMeAmount")
		givePlayerMoney(killer, money)
		exports.NGCdxmsg:createNewDxMessage("You have won $"..exports.server:convertNumber(money)..".", killer, 0, 255, 0)
		setElementData(source, "isHitme", false)
		setElementData(source, "hitMeAmount", false)
		killTimer(timer[source])
		if (isTimer(lvtimer[source])) then
			killTimer(lvtimer[source])
		end
	end
end
addEventHandler("onPlayerWasted", root, onDead)

function onInteriorEnter(hElem)
	if (hElem) then
		if (source) and (getMarkerIcon(source) == "arrow") and (getElementData(hElem, "isHitme")) then
			exports.AURstores:returnPlayerInterior(hElem)
			exports.server:createNewDxMessage("You can't go in an interior if you've got a bounty on your head", p, 255, 0, 0)
		end
	end
end
addEventHandler("onMarkerHit", root, onInteriorEnter)