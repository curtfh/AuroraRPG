--Temporary script. 
marker1 = createMarker(1022.3805541992, -1121.4208984375, 24.870140075684, "arrow", 1.5, 230, 251, 3, 153) 
marker2 = createMarker(3572.3608398438, -396.00219726563, 517.17346191406, "arrow", 1.5, 230, 251, 3, 153)  
setElementDimension(marker2, 343)
function teleport(player) 
    if (source == marker1 and getElementType(player) == "player") then 
		if (exports.server:getPlayerWantedPoints(player) ~= 0) then 
			exports.NGCdxmsg:createNewDxMessage(sr, "Wanted criminals aren't allowed here.", 255, 0, 0)
			return 
		end 
        setElementPosition(player, 3572.3608398438, -394.00219726563, 517.17346191406) 
        setElementFrozen(player, false) 
		setElementDimension(player, 343)
        setTimer(setElementFrozen, 1000, 1, player, false) 
    elseif (source == marker2 and getElementType(player) == "player") then 
        setElementPosition(player, 1022.33, -1124.25, 23.86) 
        setElementFrozen(player, false) 
		setElementDimension(player, 0)
        setTimer(setElementFrozen, 1000, 1, player, false)   
    end 
end 
addEventHandler("onMarkerHit", root, teleport) 