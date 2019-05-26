local screenW, screenH = guiGetScreenSize()
local gui_elements = {}
local buttons = {}

local closeButton = guiCreateButton(0.32, 0.76, 0.35, 0.02, "", true)
local invitePlayer = guiCreateButton(0.49, 0.63, 0.18, 0.03, "", true)
local setFounder = guiCreateButton(0.49, 0.49, 0.18, 0.03, "", true)
local kickMember = guiCreateButton(0.49, 0.27, 0.18, 0.03, "", true)

local memberGrid = guiCreateGridList(0.33, 0.26, 0.15, 0.26, true)
guiGridListAddColumn(memberGrid, "Members", 0.9)
local inviteGrid = guiCreateGridList(0.33, 0.55, 0.15, 0.20, true)
guiGridListAddColumn(inviteGrid, "Players", 0.9)

local gui_elements = {closeButton, invitePlayer, setFounder, kickMember, memberGrid, inviteGrid}
local buttons = {closeButton, invitePlayer, setFounder, kickMember}

for i=1, #gui_elements do
    guiSetVisible(gui_elements[i], false)
end

local function dxManagement()
    dxDrawRectangle(screenW * 0.3242, screenH * 0.2194, screenW * 0.3523, screenH * 0.5625, tocolor(0, 0, 0, 175), false)
    dxDrawRectangle(screenW * 0.3242, screenH * 0.2194, screenW * 0.3523, screenH * 0.0319, tocolor(0, 0, 0, 175), false)
    dxDrawText("AuroraRPG ~ Unit -> Manage Players", screenW * 0.3242, screenH * 0.2181, screenW * 0.6766, screenH * 0.2514, tocolor(255, 255, 255, 255), 1.30, "default-bold", "center", "center", false, false, false, false, false)
    dxDrawRectangle(screenW * 0.3242, screenH * 0.7597, screenW * 0.3523, screenH * 0.0222, tocolor(0, 0, 0, 175), false)
    dxDrawText("Close", screenW * 0.3227, screenH * 0.7583, screenW * 0.6766, screenH * 0.7819, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
    dxDrawRectangle(screenW * 0.4898, screenH * 0.2653, screenW * 0.1789, screenH * 0.0319, tocolor(0, 0, 0, 175), false)
    dxDrawText("Kick member", screenW * 0.4891, screenH * 0.2639, screenW * 0.6687, screenH * 0.2958, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
    dxDrawRectangle(screenW * 0.4891, screenH * 0.4889, screenW * 0.1789, screenH * 0.0319, tocolor(0, 0, 0, 175), false)
    dxDrawText("Set as founder", screenW * 0.4883, screenH * 0.4889, screenW * 0.6680, screenH * 0.5208, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
    dxDrawRectangle(screenW * 0.4891, screenH * 0.6292, screenW * 0.1789, screenH * 0.0319, tocolor(0, 0, 0, 175), false)
    dxDrawText("Invite player", screenW * 0.4883, screenH * 0.6292, screenW * 0.6680, screenH * 0.6611, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
end

local function handleButtons(btn)
    if (btn ~= "left") then
        return false
    end

    if (source == closeButton) then
        for i=1, #gui_elements do
            guiSetVisible(gui_elements[i], false)
        end
        removeEventHandler("onClientRender", root, dxManagement)
        showCursor(false)   

        toggleGui()
    end

    if (source == kickMember) then
        local r = guiGridListGetSelectedItem(memberGrid)

        if (r == -1) then
            return outputChatBox("Choose a member!", 255, 255, 0)
        end

        triggerLatentServerEvent("AURunits.kickMember", 5000, false, resourceRoot, guiGridListGetItemText(memberGrid, r, 1))

        for i=1, #gui_elements do
            guiSetVisible(gui_elements[i], false)
        end
        removeEventHandler("onClientRender", root, dxManagement)
        showCursor(false)   
    end

    if (source == setFounder) then
        local r = guiGridListGetSelectedItem(memberGrid)

        if (r == -1) then
            return outputChatBox("Choose a member!", 255, 255, 0)
        end

        triggerLatentServerEvent("AURunits.setFounder", 5000, false, resourceRoot, guiGridListGetItemText(memberGrid, r, 1))

        for i=1, #gui_elements do
            guiSetVisible(gui_elements[i], false)
        end
        removeEventHandler("onClientRender", root, dxManagement)
        showCursor(false)   
    end

    if (source == invitePlayer) then
        local r = guiGridListGetSelectedItem(inviteGrid)

        if (r == -1) then
            return outputChatBox("Choose a player!", 255, 255, 0)
        end


        triggerLatentServerEvent("AURunits.invitePlayer", 5000, false, resourceRoot, guiGridListGetItemText(inviteGrid, r, 1))

        for i=1, #gui_elements do
            guiSetVisible(gui_elements[i], false)
        end
        removeEventHandler("onClientRender", root, dxManagement)
        showCursor(false)   
    end
end

for i=1, #buttons do
    addEventHandler("onClientGUIClick", buttons[i], handleButtons)
    guiSetAlpha(buttons[i], 0.00)
end

local function openManagement(unit, memberUnit, invites)
    guiGridListClear(memberGrid)
    guiGridListClear(inviteGrid)

    for i, v in ipairs(memberUnit) do
        local row = guiGridListAddRow(memberGrid)
        local rgb = split(v['rgb'], ",")
        guiGridListSetItemText(memberGrid, row, 1, v['member2'], false, false)
        guiGridListSetItemColor(memberGrid, row, 1, tonumber(rgb[1]), tonumber(rgb[2]), tonumber(rgb[3]))
    end

    for i, v in ipairs(invites) do
        guiGridListAddRow(inviteGrid, getPlayerName(v))
    end

    local visibility = (not guiGetVisible(gui_elements[1]))

    if (visibility) then
        addEventHandler("onClientRender", root, dxManagement)
    else
        removeEventHandler("onClientRender", root, dxManagement)
    end

    for i=1, #gui_elements do
        guiSetVisible(gui_elements[i], visibility)
    end

    showCursor(visibility)
end
addEvent("AURunits.toggleManagement", true)
addEventHandler("AURunits.toggleManagement", resourceRoot, openManagement)
