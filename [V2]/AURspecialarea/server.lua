local Left,Botom = 2020, 259
local Right, Top = 1894,172
local Width = Right - Left
local Height = Top - Botom
local area = createRadarArea(Left,Botom,Width,Height,1,2,3,180)
local dmarea2 =  createColRectangle( 1911.48, 175.47, 90, 70 )

addEventHandler( "onPlayerWasted", getRootElement( ),
    function(ammo,killer)
        if killer and isElement(killer) and getElementType(killer) == "player" then
            if isElementWithinColShape( killer, dmarea2 ) then
                if ( killer ~= source ) then
                    local y = math.random(1,5)
                    exports.CSGdrugs:giveDrug(killer,"Ritalin",y)
                    exports.CSGdrugs:giveDrug(killer,"Ecstasy",y)
					exports.CSGdrugs:giveDrug(killer,"Heroine",y)
                    exports.NGCdxmsg:createNewDxMessage(killer,"You got "..y.." of Ritalin,Ecstasy and Heroine for killing an enemy")
                end
            end
        end
    end
)



