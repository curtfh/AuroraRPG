local linkBodyToBone = {
    [3] = 4,
    [4] = 1,
    [5] = 23,
    [6] = 33,
    [7] = 52,
    [8] = 42,
    [9] = 5,
}
local linkBodyToFly = {
    [3] = 0,
    [4] = 1,
    [5] = 1,
    [6] = 0,
    [7] = 1,
    [8] = 0,
    [9] = 1,
}
-- 1 = Text flows Left side
-- 0 = Text flows Right Side
 
local drawTextQueue = {}
local font = dxCreateFont("font.otf", 16)
if (not font) then
    font = "arial"
end
 
function getRGBFromObject(v)
    if (v[2] == 9) then
        return 210, 117, 7
    end
    if (v[10] == 0) then
        return 0, 0, 255
    end
    return 255, 255, 255
end
 
function drawDamageText()
    for i, v in pairs(drawTextQueue) do
        if (getTickCount() - v[6] > 500) then
            drawTextQueue[i] = nil
        else
            if (v[1] and isElementOnScreen(v[1])) then
                if (not v[7]) then
                    local boneX, boneY, boneZ = getPedBonePosition(v[1], v[5])
                    local screenX, screenY = getScreenFromWorldPosition(boneX, boneY, boneZ)
                    drawTextQueue[i][7] = true
                    if (screenX) then
                        drawTextQueue[i][8] = {0, 0}
                        local r, g, b = getRGBFromObject(v)
                        dxDrawText(tostring(v[3]), screenX, screenY, screenX, screenY, tocolor(r, g, b, 255), 1, font, "left", "top", false, false, true)
                    else
                        drawTextQueue[i] = nil
                    end
                else
                    local boneX, boneY, boneZ = getPedBonePosition(v[1], v[5])
                    local screenX, screenY = getScreenFromWorldPosition(boneX, boneY, boneZ)
                    if (screenX) then
                        local alterX, alterY = unpack(drawTextQueue[i][8])
                        local screenX, screenY = screenX + alterX, screenY + alterY
                        local moveTo = v[4]
                        screenY = screenY - 1
                        alterY = alterY - 1
                        if (moveTo == 0) then
                            screenX = screenX - 1
                            alterX = alterX - 1
                        else
                            screenX = screenX + 1
                            alterX = alterX + 1
                        end
                        drawTextQueue[i][8] = {alterX , alterY}
                        local r, g, b = getRGBFromObject(v)
                        dxDrawText(tostring(v[3]), screenX, screenY, screenX, screenY, tocolor(r, g, b, (500 - (getTickCount() - v[6]) / 500) * 255), 1, font, "left", "top", false, false, true)
                    end
                end
            end
        end
    end
end
addEventHandler("onClientRender", root, drawDamageText)
 
function drawDamageNumbers(attacker, weapon, bodypart, loss)
    if (wasEventCancelled()) then
        return false
    end
    if (loss < 5) then
        return false
    end
    if (localPlayer ~= attacker) then
        return false
    end
    if (bodypart == 9) then
        setSoundVolume(playSound("sound.mp3", false), 1.5)
    end
    drawTextQueue[#drawTextQueue + 1] = {source, bodypart, math.floor(loss), linkBodyToFly[bodypart], linkBodyToBone[bodypart], getTickCount(), false, 0, 0, getPedArmor(source) > 0 and 0 or 1}
end
addEvent("onClientLocalPlayerDamage", true)
addEventHandler("onClientLocalPlayerDamage", root, drawDamageNumbers, true, "low-5")