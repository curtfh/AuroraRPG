screenW, screenH = guiGetScreenSize()
button = {}

button[1] = guiCreateButton(0.35, 0.59, 0.30, 0.04, "train", true)
guiSetAlpha(button[1], 0.00)


button[2] = guiCreateButton(0.35, 0.65, 0.30, 0.04, "reset", true)
guiSetAlpha(button[2], 0.00)


button[3] = guiCreateButton(0.35, 0.71, 0.30, 0.04, "close", true)
guiSetAlpha(button[3], 0.00)

function dxTrain()
    dxDrawRectangle(screenW * 0.3492, screenH * 0.2319, screenW * 0.3016, screenH * 0.5361, tocolor(0, 0, 0, 183), false)
    dxDrawRectangle(screenW * 0.3484, screenH * 0.2319, screenW * 0.3023, screenH * 0.0556, tocolor(0, 0, 0, 255), false)
    dxDrawText("AuroraRPG - Gym", screenW * 0.3492, screenH * 0.2319, screenW * 0.6508, screenH * 0.2875, tocolor(255, 255, 255, 255), 1.70, "default-bold", "center", "center", false, false, false, false, false)
    dxDrawText("Here you can train your muscles for $2,000!\nYou must have the CJ skin to train your muscles!", screenW * 0.3477, screenH * 0.2986, screenW * 0.6508, screenH * 0.5847, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
    dxDrawRectangle(screenW * 0.3484, screenH * 0.5861, screenW * 0.3023, screenH * 0.0375, tocolor(0, 0, 0, 183), false)
    dxDrawRectangle(screenW * 0.3492, screenH * 0.6514, screenW * 0.3023, screenH * 0.0375, tocolor(0, 0, 0, 183), false)
    dxDrawRectangle(screenW * 0.3492, screenH * 0.7111, screenW * 0.3023, screenH * 0.0375, tocolor(0, 0, 0, 183), false)
    dxDrawText("Close", screenW * 0.3484, screenH * 0.7097, screenW * 0.6508, screenH * 0.7486, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
    dxDrawText("Reset Muscle", screenW * 0.3484, screenH * 0.6500, screenW * 0.6508, screenH * 0.6889, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
    dxDrawText("Train Muscle", screenW * 0.3477, screenH * 0.5861, screenW * 0.6500, screenH * 0.6250, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
end

function toggleButtons()
    local vs = (not guiGetVisible(button[1]))
    for i, v in ipairs(button) do
        guiSetVisible(v, vs)
    end 
    return vs
end
toggleButtons()

function toggleGUI()
    local buttons = toggleButtons()
    if (buttons) then
        addEventHandler("onClientRender", root, dxTrain)
    else
        removeEventHandler("onClientRender", root, dxTrain)
    end
    showCursor(buttons)
end
addEvent("AURgymtraining.open", true)
addEventHandler("AURgymtraining.open", resourceRoot, toggleGUI)

function buttonHandler(clickedB)
    if (clickedB ~= "left") then
        return false 
    end
    if (source == button[1]) then
        triggerServerEvent("AURgymtraining.train", resourceRoot)
    end
    if (source == button[2]) then
        triggerServerEvent("AURgymtraining.reset", resourceRoot)
    end
    toggleGUI()
end

for i, v in ipairs(button) do
    addEventHandler("onClientGUIClick", v, buttonHandler, false)
end

if (fileExists("client.lua")) then
    fileDelete("client.lua")
end