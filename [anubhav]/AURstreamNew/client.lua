--
button = {}
links = {
    ['Awesome 80\'s']="http://listen.181fm.com/181-awesome80s_128k.mp3",
    ['Star 90\'s']="http://listen.181fm.com/181-star90s_128k.mp3",
    ['90\'s dance']="http://listen.181fm.com/181-90sdance_128k.mp3",
    ['Power 181']="http://listen.181fm.com/181-power_128k.mp3",
    ['UK Top 40']="http://listen.181fm.com/181-uktop40_128k.mp3",
    ['Party 181']="http://listen.181fm.com/181-party_128k.mp3",
    ['Old School HipHop/RnB']="http://listen.181fm.com/181-oldschool_128k.mp3",
    ['Techno']="http://listen.181fm.com/181-technoclub_128k.mp3",

}
--
screenW, screenH = guiGetScreenSize()
sound = {}
--

button[1] = guiCreateButton(0.37, 0.63, 0.26, 0.03, "start", true)
guiSetAlpha(button[1], 0.00)
button[2] = guiCreateButton(0.37, 0.67, 0.26, 0.03, "stop", true)
guiSetAlpha(button[2], 0.00)
button[3] = guiCreateButton(0.37, 0.71, 0.26, 0.03, "close", true)
guiSetAlpha(button[3], 0.00)

edit = guiCreateEdit(0.37, 0.32, 0.26, 0.03, "Put the URL here", true)

gridlist = guiCreateGridList(0.37, 0.36, 0.25, 0.27, true)
guiGridListAddColumn(gridlist, "Station Name", 0.9)

for i, v in pairs(links) do
    guiGridListAddRow(gridlist, i)
end

guiElements = {button[1], button[2], button[3], edit, gridlist}

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
set_placeholder(edit)

function dxStream()
    dxDrawRectangle(screenW * 0.3664, screenH * 0.2444, screenW * 0.2672, screenH * 0.5111, tocolor(0, 0, 0, 179), false)
    dxDrawRectangle(screenW * 0.3664, screenH * 0.2444, screenW * 0.2672, screenH * 0.0333, tocolor(0, 0, 0, 179), false)
    dxDrawText("AuroraRPG - MP3/Radio Streamer", screenW * 0.3664, screenH * 0.2417, screenW * 0.6336, screenH * 0.2778, tocolor(255, 255, 255, 255), 1.30, "default-bold", "center", "center", false, false, false, false, false)
    dxDrawText("Enter a MP3/Radio URL or select one:", screenW * 0.3703, screenH * 0.2917, screenW * 0.5414, screenH * 0.3139, tocolor(255, 255, 255, 255), 1.00, "default-bold", "left", "top", false, false, false, false, false)
    dxDrawRectangle(screenW * 0.3719, screenH * 0.6361, screenW * 0.2539, screenH * 0.0278, tocolor(0, 0, 0, 179), false)
    dxDrawText("Start", screenW * 0.3719, screenH * 0.6361, screenW * 0.6258, screenH * 0.6653, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
    dxDrawRectangle(screenW * 0.3719, screenH * 0.6722, screenW * 0.2539, screenH * 0.0278, tocolor(0, 0, 0, 179), false)
    dxDrawRectangle(screenW * 0.3719, screenH * 0.7083, screenW * 0.2539, screenH * 0.0278, tocolor(0, 0, 0, 179), false)
    dxDrawText("Stop", screenW * 0.3719, screenH * 0.6708, screenW * 0.6258, screenH * 0.7000, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
    dxDrawText("Close", screenW * 0.3719, screenH * 0.7069, screenW * 0.6258, screenH * 0.7361, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
end

function toggleGUI()
    local p = (not guiGetVisible(guiElements[1]))
    for i, v in ipairs(guiElements) do
        guiSetVisible(v, p)
    end
    return p
end
toggleGUI()

function playRadio(l, x, y, z, p)
    if (sound[p]) then
        for i, v in ipairs(sound[p]) do
            destroyElement(v)
        end
    end
    sound[p] = {playSound3D(l, x, y, z, true),createObject(2229, x, y, z)}
    setElementData(sound[p][2], "creator", p)
    if (isPedInVehicle(p)) then
        attachElements(sound[p][1], sound[p][2])
        attachElements(sound[p][2], getPedOccupiedVehicle(p), 0.3, -2, -0.35)
        addEventHandler("onClientVehicleExplode", getPedOccupiedVehicle(p),
            function()
                local attached = getAttachedElements(source)
                for i, v in ipairs(attached) do
                    if (getElementModel(v) == 2229) then
                        if (getElementData(v, "creator")) then
                            if (sound[getElementData(v, "creator")]) then
                                for i, v in ipairs(sound[getElementData(v, "creator")]) do
                                    destroyElement(v)
                                end
                            end
                        end
                    end
                end
            end
        )
    end
    setSoundMaxDistance(sound[p][1], 100)
    addEventHandler("onClientPlayerQuit", p,
        function()
            if (sound[source]) then
                for i, v in ipairs(sound[source]) do
                    destroyElement(v)
                end
                sound[source] = nil
            end
        end
    )
end
addEvent("AURstreamNew.playSong", true)
addEventHandler("AURstreamNew.playSong", root, playRadio)

--[[function setVolume(_, v)
    if (not sound) then
        return false 
    end
    if (not tonumber(v)) then
        outputChatBox("Please enter a number! (Syntax: /streamvolume <volume>)", 255, 255, 0)
        return false 
    end
    local v = tonumber(v)
    if (v > 1 or v < 0) then
        outputChatBox("Please enter a number between 0 and 1", 255, 255, 0)
        return false 
    end
    setSoundVolume(sound, v)
    outputChatBox("Volume set to: "..v, 255, 255, 0)
end
addCommandHandler("streamvolume", setVolume)]]

function toggleEverything()
    local t = toggleGUI()
    if (t) then
        guiSetInputMode("no_binds_when_editing")
        addEventHandler("onClientRender", root, dxStream)
    else
        guiSetInputMode("allow_binds")
        removeEventHandler("onClientRender", root, dxStream)
    end
    showCursor(t)
end
addEvent("AURstreamNew.window", true)
addEventHandler("AURstreamNew.window", root, toggleEverything)

function buttonHandling(btn)
    if (btn ~= "left") then
        return false 
    end

    if (source == button[1]) then
        local grid = guiGridListGetSelectedItem(gridlist)
        if (grid == -1) then
            local text = guiGetText(edit)
            if (text == getElementData(edit, "place_holder")) then
                return false 
            end
            local x, y, z = getElementPosition(localPlayer)
            triggerServerEvent("AURstreamNew.playSong", localPlayer, text, x+2, y, z-1.3)
        else 
            local text = guiGridListGetItemText(gridlist, grid, 1)
            if (links[text]) then
                local x, y, z = getElementPosition(localPlayer)
                triggerServerEvent("AURstreamNew.playSong", localPlayer, links[text], x+2, y, z-1.3)
             end
        end
    end
    if (source == button[2]) then
        if (sound[localPlayer]) then
            triggerServerEvent("AURstreamNew.stopSong", localPlayer)
        end
    end
    if (source == button[3]) then
        toggleEverything()
    end
end

function removeSound(player)
    if (sound[player]) then
        for i, v in ipairs(sound[player]) do
            destroyElement(v)
        end
        sound[player] = nil
    end
end
addEvent("AURstreamNew.stopSong", true)
addEventHandler("AURstreamNew.stopSong", root, removeSound)

for i, v in ipairs(button) do
    addEventHandler("onClientGUIClick", v, buttonHandling)
end