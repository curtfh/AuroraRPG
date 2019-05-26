local dmarea =  createColRectangle( 1498.1162109375, 1883.88, 200, 117)
local test =  createColRectangle( 677, 1952, 51, 57)
local testarea = createRadarArea ( 677, 1952, 51, 57, 0, 0, 0 )
local respawn = {
    {1612.5693359375, 1928.0107421875, 10.8},
    {1652.390625, 1969.837890625, 10.8203},
    {1632.7236328125, 1898.12109375, 10.8203125},
    {1680.7314453125, 1899.0400390625, 10.8203125},
    {1684.421875, 1969.38671875, 10.8203125},
    {1634.529296875, 1991.2265625, 10.820312},
    {1599.2412109375, 1984.220703125, 10.8203125},
    {1582.064453125, 1951.7060546875, 10.820312},
    {1578.4677734375, 1901.7109375, 10.8203125},
    {1554.005859375, 1918.65625, 10.8203125},
    {1532.9306640625, 1956.9619140625, 10.8203125},
    {1514.02734375, 1903.861328125, 10.8203125},
    }

function isElementWithinLVDmArea(player)
if (not player or not isElement(player)) then return end
    if (isElementWithinColShape(player, dmarea)) then
        return true
    else return false
    end
end

function onHitShape(hitElement)
    exports.NGCdxmsg:createNewDxMessage(hitElement,"You just joined the DM area!!")
end
addEventHandler ( "onColShapeHit", dmarea, onHitShape )
local res = {}


addEventHandler( "onPlayerSpawn", getRootElement( ),function()
	if res[source] == true then
		respawnInCol(source)
	end
end)

addEventHandler( "onPlayerWasted", getRootElement( ),
    function(ammo,killer)
        if isElementWithinColShape( source, dmarea ) then
            res[source] = true
        else
			res[source] = false
            return false
        end
        if killer and isElement(killer) and getElementType(killer) == "player" then
            if isElementWithinColShape( killer, dmarea ) then
                if ( killer ~= source ) then
                    local y = math.random(1,6)
                    exports.CSGdrugs:giveDrug(killer,"Ritalin",y)
                    exports.CSGdrugs:giveDrug(killer,"Ecstasy",y)
					exports.CSGdrugs:giveDrug(killer,"Heroine",y)
                    exports.NGCdxmsg:createNewDxMessage(killer,"You got "..y.." of Ritalin,Ecstasy and Heroine for killing a super noob")
                    exports.NGCdxmsg:createNewDxMessage(killer,"You got 250$ for killing a super noob")
					givePlayerMoney(killer, 250)
                end
            end
        end
    end
)

function respawnInCol(player)
    local x = math.random(1,#respawn)
    setElementPosition(player, respawn[x][1], respawn[x][2], respawn[x][3])
	res[player] = false
end


function leavearea(player)
   if (not player or not isElement(player)) then return end
    if (isElementWithinColShape(player, dmarea)) then
	if getElementHealth(player) > 30 then
	setElementPosition(player,1607.2800292969, 1818.4868164063, 10.8203125) 
	exports.NGCdxmsg:createNewDxMessage(player,"You left DM area!",255,0,0)
	else
		if getElementHealth(player) < 30 or (getElementData(player,"wantedPoints") >= 10) then
			exports.NGCdxmsg:createNewDxMessage(player,"You can't use this feature while having low health or being wanted!",255,0,0)
			return false
		 end
      end
   end
end
addCommandHandler("leavedm", leavearea)