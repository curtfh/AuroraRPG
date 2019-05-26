local dmarea2 =  createColRectangle( 1911.48, 175.47, 90, 70 )
function isElementWithinLVDmArea(player)
if (not player or not isElement(player)) then return end
    if (isElementWithinColShape(player, dmarea2)) then
        return true
    else return false
    end
end