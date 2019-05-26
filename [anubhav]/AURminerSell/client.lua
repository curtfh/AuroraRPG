edit = {}
screenW, screenH = guiGetScreenSize()

sell = guiCreateButton(0.32, 0.65, 0.35, 0.04, "sell", true)
guiSetAlpha(sell, 0.00)
close = guiCreateButton(0.32, 0.71, 0.35, 0.04, "close", true)
guiSetAlpha(close, 0.00)

edit[1] = guiCreateEdit(0.33, 0.29, 0.13, 0.04, "Stone", true)
edit[2] = guiCreateEdit(0.33, 0.35, 0.13, 0.04, "Iron", true)
edit[3] = guiCreateEdit(0.33, 0.42, 0.13, 0.04, "Gold", true)
edit[4] = guiCreateEdit(0.33, 0.49, 0.13, 0.04, "Diamond", true)
edit[5] = guiCreateEdit(0.33, 0.56, 0.13, 0.04, "Explosive Power", true)

function dxMiner()
    dxDrawRectangle(screenW * 0.3164, screenH * 0.2319, screenW * 0.3672, screenH * 0.5361, tocolor(0, 0, 0, 179), false)
    dxDrawRectangle(screenW * 0.3164, screenH * 0.2319, screenW * 0.3672, screenH * 0.0389, tocolor(0, 0, 0, 179), false)
    dxDrawText("AuroraRPG - Sell Mining Items", screenW * 0.3148, screenH * 0.2292, screenW * 0.6836, screenH * 0.2708, tocolor(255, 255, 255, 255), 1.50, "default-bold", "center", "center", false, false, false, false, false)
    dxDrawText("10$ per stone ("..(tonumber(guiGetText(edit[1])) and "$"..tostring(tonumber(guiGetText(edit[1]))*10) or "$0")..")", screenW * 0.4672, screenH * 0.2889, screenW * 0.6492, screenH * 0.3292, tocolor(255, 255, 255, 255), 1.00, "default-bold", "left", "center", false, false, false, false, false)
    dxDrawText("15$ per iron ("..(tonumber(guiGetText(edit[2])) and "$"..tostring(tonumber(guiGetText(edit[2]))*15) or "$0")..")", screenW * 0.4672, screenH * 0.3514, screenW * 0.6492, screenH * 0.3917, tocolor(255, 255, 255, 255), 1.00, "default-bold", "left", "center", false, false, false, false, false)
    dxDrawText("100$ per gold ("..(tonumber(guiGetText(edit[3])) and "$"..tostring(tonumber(guiGetText(edit[3]))*100) or "$0")..")", screenW * 0.4672, screenH * 0.4181, screenW * 0.6492, screenH * 0.4583, tocolor(255, 255, 255, 255), 1.00, "default-bold", "left", "center", false, false, false, false, false)
    dxDrawText("500$ per diamond ("..(tonumber(guiGetText(edit[4])) and "$"..tostring(tonumber(guiGetText(edit[4]))*500) or "$0")..")", screenW * 0.4672, screenH * 0.4889, screenW * 0.6492, screenH * 0.5292, tocolor(255, 255, 255, 255), 1.00, "default-bold", "left", "center", false, false, false, false, false)
    dxDrawText("2500$ per explosive powder ("..(tonumber(guiGetText(edit[5])) and "$"..tostring(tonumber(guiGetText(edit[5]))*2500) or "$0")..")", screenW * 0.4672, screenH * 0.5625, screenW * 0.6492, screenH * 0.6028, tocolor(255, 255, 255, 255), 1.00, "default-bold", "left", "center", false, false, false, false, false)
    dxDrawRectangle(screenW * 0.3227, screenH * 0.7153, screenW * 0.3547, screenH * 0.0333, tocolor(0, 0, 0, 179), false)
    dxDrawRectangle(screenW * 0.3227, screenH * 0.6569, screenW * 0.3547, screenH * 0.0333, tocolor(0, 0, 0, 179), false)
    dxDrawText("Close", screenW * 0.3227, screenH * 0.7125, screenW * 0.6758, screenH * 0.7486, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
    dxDrawText("Sell", screenW * 0.3227, screenH * 0.6542, screenW * 0.6758, screenH * 0.6903, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
end

function toggleGui()
    local vis = (not guiGetVisible(sell))
    for i, v in ipairs(edit) do
        guiSetVisible(v, vis)
    end
    guiSetVisible(sell, vis)
    guiSetVisible(close, vis)
    return vis
end
toggleGui()

function toggleAll()
    local vis = toggleGui()
    if (vis) then
        guiSetInputMode("no_binds_when_editing")
        addEventHandler("onClientRender", root, dxMiner)
    else
        guiSetInputMode("allow_binds")
        removeEventHandler("onClientRender", root, dxMiner)
    end
    showCursor(vis)
end
addEvent("AURminerSell.gui", true)
addEventHandler("AURminerSell.gui", resourceRoot, toggleAll)

function number_mode_function(elementChanged)
    local newText = guiGetText(elementChanged)
    if (newText == getElementData(source, "place_holder")) then
        return false 
    end
    if (not tonumber(newText)) then
        guiSetText(elementChanged, "")
        return false 
    end
    if (tonumber(newText) < 0) then
        guiSetText(elementChanged, "0")
        return true
    end
    guiSetText(elementChanged, newText)
    return true 
end

function set_number_mode(guiElement, text)
    addEventHandler("onClientGUIChanged", guiElement, number_mode_function)
end

function placeholder_function()
    if (eventName == "onClientGUIFocus") then
        local newText = guiGetText(source)
        if (newText == getElementData(source, "place_holder")) then
            guiSetText(source, "")
        end
    else
        if (guiGetText(source) == "") then
            guiSetText(source, getElementData(source, "place_holder"))
        end
    end
end

function set_placeholder(guiElement)
    addEventHandler("onClientGUIFocus", guiElement, placeholder_function, true)
    addEventHandler("onClientGUIBlur", guiElement, placeholder_function, true)
    setElementData(guiElement, "place_holder", guiGetText(guiElement))
end
for i, v in ipairs(edit) do
    set_placeholder(v)
    set_number_mode(v)
end

function buttonHandler(btn)
    if (btn ~= "left") then
        return false
    end
    if (source == close) then
        toggleAll()
    end
    if (source == sell) then
        local data = {}
        for i, v in ipairs(edit) do
            data[i] = guiGetText(v)
        end
        triggerServerEvent("AURminerSell.sell", resourceRoot, data)
    end
end
addEventHandler("onClientGUIClick", sell, buttonHandler, false)
addEventHandler("onClientGUIClick", close, buttonHandler, false)