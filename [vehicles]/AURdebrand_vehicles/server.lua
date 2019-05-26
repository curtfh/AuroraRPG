local debranded_skins = {
    --Type  |  Whois  |  File  |  Texture name
	{"account", "truc0813", "curtinfernus.png", "bodymap", 1},
}


function activatePersonalShaderCMD (plr, cmd, num)
    if not num or num and not (tonumber(num)) or (tonumber(num) < 0) then 
        return exports.NGCdxmsg:createNewDxMessage("Please specify a number. /pdv <number>", plr,255,0,0)
    end
    if not (isElement(getPedOccupiedVehicle(plr))) then return exports.NGCdxmsg:createNewDxMessage("You need to be in a vehicle to use this command", plr,255,0,0) end
    local acc = exports.server:getPlayerAccountName(plr)
	for k,v in ipairs (debranded_skins) do
		if (v[5] == tonumber(num)) then
			if (v[1] == "account") then
				if (v[2] == acc) then
					local acc = exports.server:getPlayerAccountName(plr)
					triggerClientEvent(root, "AURdebrand_vehicles.activateShader", resourceRoot, "textures/"..debranded_skins[k][3], debranded_skins[k][4], getPedOccupiedVehicle(plr))
					exports.NGCdxmsg:createNewDxMessage ("Applying deBranded vehicle Shader !",plr,255,255,0)
				end
			end
		end
	end
end

addCommandHandler("personaldebrand", activatePersonalShaderCMD)
addCommandHandler("pdv", activatePersonalShaderCMD)

function activateGroupShaderCMD (plr, cmd)
    for index, player in ipairs(getElementsByType("player")) do
    triggerClientEvent(plr, "AURdebrand_vehicles.forceRestore", resourceRoot, 217)
    if not (isElement(getPedOccupiedVehicle(plr))) then return exports.NGCdxmsg("You need to be in a vehicle to use this command", plr,255,0,0) end
        for i=1, #debranded_skins do
            if (debranded_skins[i][1] == "group") then
                if (debranded_skins[i][2] == getElementData(player, "Group")) then
                    triggerClientEvent(root, "AURdebrand_vehicles.activateShader", resourceRoot, "textures/"..debranded_skins[i][3], debranded_skins[i][4], getPedOccupiedVehicle(player))
                end
            end
        end
    end
    exports.NGCdxmsg:createNewDxMessage ("Applying deBranded vehicle Shader !",player,255,255,0)
end

addCommandHandler("groupdebrand", activateGroupShaderCMD)
addCommandHandler("gdv", activateGroupShaderCMD)
