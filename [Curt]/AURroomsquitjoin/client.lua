local lastDimension = getElementDimension(localPlayer) 
local function processDimensionChanges() 
    local currentDimension = getElementDimension(localPlayer) 
    if currentDimension ~= lastDimension then 
        lastDimension = currentDimension 
        triggerServerEvent("AURroomsquitjoin.messageToDim", resourceRoot, localPlayer, lastDimension) 
    end 
end 
addEventHandler("onClientRender", root, processDimensionChanges) 
