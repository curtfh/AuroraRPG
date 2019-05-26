--[[
________________________________________________
AuroraRPG - aurorarpg.com

This resource is property of AuroraRPG.

Author: Anubhav Agarwal
All Rights Reserved 2017
________________________________________________
]]--


local originalColumns = {
    [1] = {0.01, 0.02},
    [2] = {0.36, 0.02},
    [3] = {0.71, 0.02},
}

local allowedElements = {
    ["ped"] = true, 
    ["player"] = true, 
    ["object"] = true, 
    ["vehicle"] = true
}
local antiSpamInfo = {}

local buttonInfoTable = {
        --{ "button name", function(theElement, theClient) doSomeStuffInHere(theELement) end},
    
    ['vehicle'] = { 
        {"Tell player to despawn", function(theElement, theClient) triggerServerEvent("AURinteractions.action", resourceRoot, "v_despawn", theElement) closeHandle() end},
    },

    ['object'] = {

    },

    ['ped'] = {

    },

    ['player'] = {

    },
	
	['myself'] = {
		{"Updates", function(theElement, theClient) executeCommandHandler("updates") end },
		{"Stats", function(theElement, theClient) executeCommandHandler("stats") closeHandle() end },
		{"Music player", function(theElement, theClient) executeCommandHandler("mplayer") closeHandle() end },
		{"Drugs", function(theElement, theClient) executeCommandHandler("drugs") closeHandle() end },
		{"Documentation", function(theElement, theClient) executeCommandHandler("documentation") closeHandle() end },
		{"Take screenshot for report", function(theElement, theClient) executeCommandHandler("rsc") closeHandle() end },
		{"Report", function(theElement, theClient) executeCommandHandler("report") closeHandle() end },
		{"Kill", function(theElement, theClient) triggerServerEvent("AURinteractions.serverCmd", resourceRoot, "kill") closeHandle() end },
		{"Settings", function(theElement, theClient) executeCommandHandler("settings") closeHandle() end },
		{"Use Medkit", function(theElement, theClient) executeCommandHandler("medkit") closeHandle() end },
		{"Jetpack", function(theElement, theClient) triggerServerEvent("onGetJetPack", root, theElement) closeHandle() end },
		{"VIP", function(theElement, theClient) triggerServerEvent("openVIPPanel", root, theElement) closeHandle() end },
		{"Craft", function(theElement, theClient) executeCommandHandler("craft") closeHandle() end },
		{"Peak", function(theElement, theClient) triggerServerEvent("AURinteractions.serverCmd", resourceRoot, "peak") closeHandle() end },
	},
}

local bW, bH = 0.35, 0.12
local isPlayerKeying = false
local buttons = {}

local interactionWindow = guiCreateWindow(0.35, 0.22, 0.30, 0.57, "Interacting with a vehicle", true)

local objectInformation = guiCreateLabel(0.11, 0.07, 0.77, 0.12, "Element: Ped\nHealth: 100%\nID: 5", true, interactionWindow)
guiLabelSetHorizontalAlign(objectInformation, "center", false)
guiLabelSetVerticalAlign(objectInformation, "center")

local scrollPane = guiCreateScrollPane(0.02, 0.21, 0.95, 0.68, true, interactionWindow)

local closeButton = guiCreateButton(0.03, 0.90, 0.95, 0.07, "Close", true, interactionWindow)
guiSetVisible(interactionWindow, false)

function loadButtons(element)
    for i, v in ipairs(buttons) do
        destroyElement(v)
    end

    buttons = {}

    local currentY = 0.01 
    local currentX = 0.02
	local x, y, z = getElementPosition(element)
	local xp, yp, zp = getElementPosition(localPlayer)
	local distance = getDistanceBetweenPoints3D (x, y, z, xp, yp, zp)
	if (distance >= 50) then 
		local language = exports.AURlanguage:getTranslate("The element that your clicking is too far.", true, localPlayer)
		exports.NGCdxmsg:createNewDxMessage(language, 200, 0, 0)
		return false
	end 
	if (element == localPlayer) then 
		for i, v in ipairs(buttonInfoTable["myself"]) do
			buttons[#buttons + 1] = guiCreateButton(currentX, currentY, bW, bH, v[1], true, scrollPane)
			addEventHandler("onClientGUIClick", buttons[#buttons], function () v[2](element, localPlayer) end , false)
			if (i % 3 == 0) then
				currentX = 0.02
				currentY = currentY + 0.17
			else 
				currentX = currentX + 0.40
			end
		end
	else 
		for i, v in ipairs(buttonInfoTable[getElementType(element)]) do
			buttons[#buttons + 1] = guiCreateButton(currentX, currentY, bW, bH, v[1], true, scrollPane)
			addEventHandler("onClientGUIClick", buttons[#buttons], function () v[2](element, localPlayer) end , false)
			if (i % 3 == 0) then
				currentX = 0.02
				currentY = currentY + 0.17
			else 
				currentX = currentX + 0.40
			end
		end
	end 
	
end

function closeHandle()
    showCursor(false)
    guiSetVisible(interactionWindow, false)
end
addEventHandler("onClientGUIClick", closeButton, closeHandle, false)

function buttonPressShowC()
    isPlayerKeying = not isPlayerKeying
    showCursor(isPlayerKeying)

    if (isPlayerKeying) then
        addEventHandler("onClientClick", root, clickElement)
    else
        removeEventHandler("onClientClick", root, clickElement)
    end
end
bindKey("m", "down", buttonPressShowC)

function getElHP(el)
    if (getElementType(el) == "vehicle") then
        return tostring(getElementHealth(el) / 10).."%"
    end

    return tostring(getElementHealth(el)).. "%"
end

function getElementTypeName(el)
    if (getElementType(el) == "player") then
        return getPlayerName(el)
    end

    if (getElementType(el) == "object") then
        return "an object"
    end 

    if (getElementType(el) == "vehicle") then
        return "a "..getVehicleName(el)
    end

    return "a "..getElementType(el)
end

function loadInfo(el)
    guiSetText(objectInformation, "Element: "..getElementType(el).."\nHealth: "..getElHP(el).."\nID: "..getElementModel(el))
    guiSetText(interactionWindow, "Interacting with "..getElementTypeName(el))
end

function clickElement(button, state, _, _, _, _, _, clickedElement)
    if (not isPlayerKeying) then
        return false 
    end

    if (button ~= "left") then
        return false 
    end

    if (clickedElement) then
        if (allowedElements[getElementType(clickedElement)]) then
            local elType = getElementType(clickedElement)
            if (clickedElement ~= localPlayer) then
                if (not antiSpamInfo[elType]) then
                    antiSpamInfo[elType] = getTickCount()
                elseif (getTickCount() - antiSpamInfo[elType] < 5000) then
                    outputChatBox("Please wait "..(math.floor((5000 - (getTickCount() - antiSpamInfo[elType])) / 1000)).."s more to interact with this element.", 255, 0, 0)
                    return false
                else
                    antiSpamInfo[elType] = getTickCount()
                end
            end
            showCursor(true)
            loadButtons(clickedElement)
            loadInfo(clickedElement)
            guiSetVisible(interactionWindow, true)
            isPlayerKeying = false
            removeEventHandler("onClientClick", root, clickElement)
        end
    end
end
