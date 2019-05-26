local barriers = {}
local antiSpam = {}
local allowed = {
    ["1"] = true,
    ["2"] = true,
    ["3"] = true,
    ["4"] = true,
    ["closed"] = true,
    ["right"] = true,
    ["left"] = true
}
local idToModel = {
    ["1"] = 1459,
    ["2"] = 1423,
    ["3"] = 1237,
    ["4"] = 1237,
    ["closed"] = 3091,
    ["right"] = 978,
    ["left"] = 979
}

function isAllowed(player, string)
	if (string == "add") then
		if antiSpam[player] and getTickCount() - antiSpam[player] <= 10000 then
			msg(player,"Wait before placing another barrier")
			return false
		end
		if isPedInVehicle(player) then
			msg(player,"You must be on foot to place barriers")
			return false
		end
		local x, y, z = getElementVelocity(player)
		if x ~= 0 or y ~= 0 or z ~= 0 then
			msg(player,"You must stand still in order to place barriers")
			return false
		end
		local contactElement = getPedContactElement(player)
		if contactElement and getElementType(contactElement) == "object" then
			msg(player,"You must not stand on object to place barriers")
			return false
		end
		if getElementDimension(player) ~= 0 then
			msg(player,"You must be in main world to place barriers")
			return false
		end
		if not isPedOnGround(player) then
			msg(player,"You must be on ground to place barriers")
			return false
		end
		local team = getPlayerTeam(player)
		local occupation = getElementData(player, "Occupation")
		if team then
			local teamName = getTeamName(team)
			if teamName == "Military Forces" then
				return true
			elseif teamName == "SWAT Team" then
				return true
			elseif teamName == "Government" and occupation == "NSA Team" then
				return true
			elseif teamName == "Government" and occupation == "NSA Agent" then
				return true
			elseif teamName == "Government" and occupation == "FBI Agent" then
				return true
			elseif teamName == "Government" and occupation == "National Task Force" then
				return true
			elseif getElementData(player, "polc") == true then
				return true
			end
		end
		return false
	else
		return true
	end
end

--function outputChatBox(msg, plr, r, g, b)
    --return exports.NGCdxmsg:createNewDxMessage(plr, msg, r, g, b)
--end

addCommandHandler("addbarrier",
    function (player, _, barrier)
        if isAllowed(player, "add") then
            if barrier then
                if allowed[barrier] then
                    if not barriers[player] then
                        barriers[player] = {}
                    end
                    if isElement(barriers[player][barrier]) then
                        destroyElement(barriers[player][barrier])
                        barriers[player][barrier] = nil
                    end
                    antiSpam[player] = getTickCount()
                    local model = idToModel[barrier]
                    local x, y, z = getElementPosition(player)
                    local _, _, rz = getElementRotation(player)
                    if barrier == "left" or barrier == "right" or barrier == "2" then
                        z = z + 0.25
                    end
                    if barrier == "3" or barrier == "4" then
                        z = z - 0.5
                    end
                    local barrierObject = createObject(model, x, y, z - 0.5, 0, 0, rz)
					setElementData(barrierObject,"barrierID",barrier)
					setElementData(barrierObject,"barrierOwner",player)
					setElementData(barrierObject,"isBarrier",true)
                    triggerClientEvent("fixyy", resourceRoot, barrierObject)
                    barriers[player][barrier] = barrierObject
                    msg(player,"Barrier "..barrier.." added")
                else
                    msg(player,"Barrier "..barrier.." is not allowed")
                end
            else
				msg(player,"Specify a barrier ID")
            end
        end
    end
)

addCommandHandler("removebarrier",
    function (player, _, barrier)
        if isAllowed(player, "remove") then
            if barrier then
                 if allowed[barrier] then
                    if not barriers[player] then
                        barriers[player] = {}
                    end
                    if barriers[player][barrier] then
                       destroyElement(barriers[player][barrier])
                       barriers[player][barrier] = nil
                       msg(player,"Barrier "..barrier.." has been removed")
                    end
                end
            end
        end
    end
)

function removeAllBarriers(player)
    if isAllowed(player, "remove") then
        if barriers[player] then
            for _, barrier in pairs(barriers[player]) do
				if (isElement(barrier)) then
					destroyElement(barrier)
				end
            end
            if not eventName then
				msg(player,"You have removed all barriers")
                barriers[player] = {}
            end
        end
    end
end
addCommandHandler("removeall", removeAllBarriers)

addEvent("removeBarrierSpeed",true)
addEventHandler("removeBarrierSpeed",root,function(id)
	if barriers[source][id] then
        destroyElement(barriers[source][id])
        barriers[source][id] = nil
		msg(source,"A vehicle has broke your barrier "..id.." (Speed ram)")
	end
end)


function msg(p,msg)
	exports.NGCnote:addNote("Barriers", "Barriers: #FFFFFF"..msg, p, 0, 100, 200,5000 )
end

addEventHandler("onPlayerJailed", root, function() removeAllBarriers(source) end)
addEventHandler("onPlayerArrested", root,  function() removeAllBarriers(source) end)
addEventHandler("onPlayerQuit", root, function() removeAllBarriers(source) end)
addEventHandler("onPlayerWasted", root,  function() removeAllBarriers(source) end)

addEvent("onPlayerJobChange",true)
addEventHandler("onPlayerJobChange",root,function(new,old)
	removeAllBarriers(source)
end)

addEvent("onStartShift",true)
addEventHandler("onStartShift",root,function(occ)
	removeAllBarriers(source)
end)

addEvent("onEndShift",true)
addEventHandler("onEndShift",root,function()
	removeAllBarriers(source)
end)

addEventHandler("onElementDataChange",root,function(d, o)
	if ((d == "Occupation" and o == "National Task Force") or (d == "Occupation" and o == "NSA Agent") or (d == "Occupation" and o == "FBI Agent")) then
		removeAllBarriers(source)
	end
end)
