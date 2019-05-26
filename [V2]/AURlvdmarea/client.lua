local dmarea =  createColRectangle( 1498.1162109375, 1883.88, 200, 117)
function isElementWithinLVDmArea(player)
if (not player or not isElement(player)) then return end
    if (isElementWithinColShape(player, dmarea)) then
        return true
    else return false
    end
end