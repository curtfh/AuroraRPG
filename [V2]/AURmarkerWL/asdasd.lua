local markerWL = createMarker(1874.4189453125, -1381.4033203125, 12.54733180999 , "cylinder", 7,178,34,34,175)
createBlipAttachedTo(markerWL, 41)
players={}
function getElementsWithinMarker(marker)
local markerColShape = getElementColShape(marker)
local elements = getElementsWithinColShape(markerColShape)
    if (not isElement(marker) or getElementType(marker) ~= "marker") then
        return false
    end
    return elements
end 
 
function markerHit(hitElement)
    if (getElementData(hitElement, "wantedPoints") or 0) < 60 then
            if getElementType(hitElement) == "player" then
                players = getElementsWithinMarker(markerWL)
                for k,v in ipairs(players) do 
                if  exports.server:getPlayerWantedPoints(v) > 100 or getElementType(v) ~= "player" then return false end
                    if #players == 5 then
                        exports.server:givePlayerWantedPoints(v , 100)
                        exports.NGCdxmsg:createNewDxMessage(v,"You got 100 wanted level, now kill all cops!")
						exports.NGCdxmsg:createNewDxMessage("5 Criminals started LS Game, go arrest them")
                    else exports.NGCdxmsg:createNewDxMessage(v,5-#players.." players left to start the event")
                        
                end
            end
        end    
    else exports.NGCdxmsg:createNewDxMessage(hitElement,"You got enough wanted level you can't get in that event")
    end
end
addEventHandler("onMarkerHit", markerWL, markerHit)
