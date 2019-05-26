local recentDamage = {}
local medicTeam = getTeamFromName("Paramedics")

function recentDamageFunction(a, w)
	if (not isElement(a)) then
		return false 
	end
	if (getElementType(a) ~= "player") then
		return false 
	end
	if (getPlayerTeam(a) ~= medicTeam) then
		return false 
	end
	if (w == 41) then
		return false
	end
	if (a == source) then
		return false 
	end
	if (recentDamage[source]) then
		table.insert(recentDamage, {a, getTickCount()})
	else
		recentDamage[source] = {{a, getTickCount()}}
	end
end
addEventHandler("onPlayerDamage", root, recentDamageFunction)

function reloadHeals()
	for i, v in pairs(recentDamage) do
		if (not isElement(i)) then
			recentDamage[i] = nil
		else
			if (type(v) == "table") then
				for i2, v in ipairs(v) do
					if (getTickCount() - v[2] > 60000) then
						recentDamage[i][i2] = nil			
					end
				end
			end 
		end
	end
end

function getPedMaxHealth(ped) -- taken from wikki
    -- Output an error and stop executing the function if the argument is not valid
    assert(isElement(ped) and (getElementType(ped) == "ped" or getElementType(ped) == "player"), "Bad argument @ 'getPedMaxHealth' [Expected ped/player at argument 1, got " .. tostring(ped) .. "]")

    -- Grab his player health stat.
    local stat = getPedStat(ped, 24)

    -- Do a linear interpolation to get how many health a ped can have.
    -- Assumes: 100 health = 569 stat, 200 health = 1000 stat.
    local maxhealth = 100 + (stat - 569) / 4.31

    -- Return the max health. Make sure it can't be below 1
    return math.max(1, maxhealth)
end

function healingCheck(player, other) 
	reloadHeals()
	for i, v in pairs(recentDamage) do
		if (i == player) then
			for i, v in ipairs(v) do
				if (v[1] == other) then
					return true 
				end
			end
		end
	end
end

function doHeal(a, h, t)
	if (healingCheck(h, a)) then
		exports.NGCdxmsg:createNewDxMessage("You recently damaged the player you are trying to heal, you cannot heal him!", a, 255, 25, 25)
		return false 
	end
	if (getPlayerIdleTime(h) > 60000*5) then
		exports.NGCdxmsg:createNewDxMessage("You cannot heal AFK players (player is afk more than 5 minutes)!", a, 255, 25, 25)
		return false 
	end
	local t = math.ceil(t/1000)
	if (getPedMaxHealth(h) == getElementHealth(h)) then
		exports.NGCdxmsg:createNewDxMessage("Player already has full health!", a, 255, 25, 25)
		return false 
	end
	if (getPlayerMoney(h) < math.ceil((t*3)*100)) then
		exports.NGCdxmsg:createNewDxMessage("Player does not have enough money!", a, 255, 25, 25)
		return false 
	end
	setElementHealth(h, getElementHealth(h) + math.ceil((t*3)))
	exports.AURpayments:takeMoney(h, math.ceil((t*3)*100), "AURparamedicj")
	exports.AURpayments:addMoney(a, math.ceil((t*3)*100), "Custom", "Paramedics", 0, "AURparamedicj")
	takePlayerMoney(h, math.ceil((t*3)*100))
	givePlayerMoney(a, math.ceil((t*3)*100))
	exports.NGCdxmsg:createNewDxMessage("You were healed by "..getPlayerName(a).." ("..tostring(math.ceil(t*3)).." HP) ($"..tostring(math.ceil((t*3)*100))..")", h, 25, 255, 25)

end
addEvent("AURparamedicj.healP", true)
addEventHandler("AURparamedicj.healP", resourceRoot, doHeal)

function enterVehicleHeal(p, seat)
	local driver = getVehicleOccupant(source, 0)
	if (seat == 0) then
		return false 
	end
	if (driver == p) then
		return false 
	end
	if (not driver) then
		return false
	end
	if (getPlayerTeam(driver) == medicTeam) then
		if (getPedMaxHealth(p) == getElementHealth(p)) then
			return false 
		end
		local hp = getPedMaxHealth(p) - getElementHealth(p)
		if (getPlayerMoney(p) < math.ceil(hp*100)) then
			return false 
		end
		setElementHealth(p, getPedMaxHealth(p))
		exports.AURpayments:takeMoney(p, math.ceil((t*3)*100), "AURparamedicj")
		exports.AURpayments:addMoney(driver, math.ceil((t*3)*100), "Custom", "Paramedics", 0, "AURparamedicj")
		exports.NGCdxmsg:createNewDxMessage("You were healed by "..getPlayerName(driver).." ("..tostring(hp).." HP) ($"..tostring(math.ceil(hp*100))..")", p, 25, 255, 25)
	end
end
addEventHandler("onVehicleEnter", root, enterVehicleHeal)