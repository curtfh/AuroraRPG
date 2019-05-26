--[[local range = 30

addEventHandler ( "onClientPlayerVoiceStart", root, 
function() 
    if (source and isElement(source) and getElementType(source) == "player") and localPlayer ~= source then 
        local sX, sY, sZ = getElementPosition(localPlayer) 
        local rX, rY, rZ = getElementPosition(source) 
        local distance = getDistanceBetweenPoints3D(sX, sY, sZ, rX, rY, rZ) 
        if distance <= range then 
            voicePlayers[source] = true 
        else 
            cancelEvent()--This was the shit 
        end 
    end 
end 
) 
--]]

local nearbyPlayers = {} 
  
addEventHandler("onPlayerVoiceStart", root, 
    function() 
        local r = 40 
        local posX, posY, posZ = getElementPosition(source) 
        local chatSphere = createColSphere(posX, posY, posZ, r) 
        nearbyPlayers = getElementsWithinColShape(chatSphere, "player") 
        destroyElement(chatSphere) 
        local empty = exports.voice:getNextEmptyChannel() 
        exports.voice:setPlayerChannel(source, empty) 
        for index, player in ipairs(nearbyPlayers) do 
            exports.voice:setPlayerChannel(player, empty) 
        end 
    end 
) 

addEventHandler("onPlayerVoiceStop", root, 
    function() 
        exports.voice:setPlayerChannel(source) 
        for index, player in ipairs(nearbyPlayers) do 
            exports.voice:setPlayerChannel(player) 
        end 
        nearbyPlayers = {} 
    end 
) 
