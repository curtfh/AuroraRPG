local screenW, screenH = guiGetScreenSize()
local ignore = fromJSON(exports.DENsettings:getPlayerSetting("ignorePeople") or toJSON({}))

function createIgnoreWindow()
	if (ignoreWindow) then
		return true
	end
	ignoreWindow = guiCreateWindow((screenW - 488) / 2, (screenH - 569) / 2, 488, 569, "AuroraRPG ~ Ignore a player", false)
	guiWindowSetSizable(ignoreWindow, false)
	guiSetVisible(ignoreWindow, false)
	ignoreGridlist = guiCreateGridList(9, 28, 469, 331, false, ignoreWindow)
	guiGridListAddColumn(ignoreGridlist, "Player name", 0.45)
	guiGridListAddColumn(ignoreGridlist, "Account name", 0.45)
	closeIgnoreWindowBtn = guiCreateButton(9, 524, 469, 29, "Close", false, ignoreWindow)
	guiSetProperty(closeIgnoreWindowBtn, "NormalTextColour", "FFAAAAAA")
	ignoreEdit = guiCreateEdit(9, 369, 469, 30, "", false, ignoreWindow)
	addPlrIGBtn = guiCreateButton(9, 448, 469, 29, "Add (by in-game name)", false, ignoreWindow)
	guiSetProperty(addPlrIGBtn, "NormalTextColour", "FFAAAAAA")
	addPlrAccBtn = guiCreateButton(9, 409, 469, 29, "Add (by account name)", false, ignoreWindow)
	guiSetProperty(addPlrAccBtn, "NormalTextColour", "FFAAAAAA")
	removePlrBtn = guiCreateButton(10, 485, 468, 29, "Remove", false, ignoreWindow)
	guiSetProperty(removePlrBtn, "NormalTextColour", "FFAAAAAA")
	addEventHandler("onClientGUIClick", closeIgnoreWindowBtn, closeIgnoreWindow, false)
	addEventHandler("onClientGUIClick", addPlrIGBtn, addIngamePlayerIgnore, false)
	addEventHandler("onClientGUIClick", addPlrAccBtn, addIngameAccountIgnore, false)
	addEventHandler("onClientGUIClick", removePlrBtn, removeSelectedItem, false)
end

function closeIgnoreWindow(btn)
	if (btn ~= "left") then
		return false
	end
	guiSetVisible(ignoreWindow, false)
	showCursor(false)
end


function addIngameAccountIgnore(btn)
	if (btn ~= "left") then
		return false
	end
	local accName = guiGetText(ignoreEdit)
	if (accName == "") then
		outputChatBox("Please enter a account name.", 255, 0, 0)
		return false
	end
	if (ignore[accName]) then
		outputChatBox("This player is already in your ignore list.", 255, 0, 0)
		return false
	end
	ignore[accName] = true 
	exports.DENsettings:setPlayerSetting("ignorePeople", toJSON(ignore))
	outputChatBox("Added account "..accName.." to your ignore list.", 255, 0 ,0)
	loadGridlistData()
end

function addIngamePlayerIgnore(btn)
	if (btn ~= "left") then
		return false
	end
	local edit = guiGetText(ignoreEdit)
	if (edit == "") then
		outputChatBox("Please enter a player name", 255, 0, 0)
		return false
	end
	local plr = getPlayerFromPartialName(edit)
	if (not plr) then
		outputChatBox("Cannot find a player with that name", 255, 0, 0)
		return false
	end
	local accName = getElementData(plr, "playerAccount")
	if (ignore[accName]) then
		outputChatBox("This player is already in your ignore list.", 255, 0, 0)
		return false
	end
	ignore[accName] = true 
	exports.DENsettings:setPlayerSetting("ignorePeople", toJSON(ignore))
	outputChatBox("Added account "..accName.." to your ignore list.", 255, 0 ,0)
	loadGridlistData()
end

function removeSelectedItem(btn)
	if (btn ~= "left") then
		return false
	end
	local r, c = guiGridListGetSelectedItem(ignoreGridlist)
	if (r == -1) then
		outputChatBox("Please select an account name from the gridlist.", 255, 0, 0)
		return false
	end
	local accName = guiGridListGetItemText(ignoreGridlist, r, 2)
	if (not ignore[accName]) then
		outputChatBox("This player is not in your ignore list. Please re-open '/ignore'!", 255, 0, 0)
		return false
	end
	ignore[accName] = nil
	exports.DENsettings:setPlayerSetting("ignorePeople", toJSON(ignore))
	outputChatBox("Removed account "..accName.." from your ignore list.", 255, 0 ,0)
	loadGridlistData()
end

function getPlayerFromPartialName(name)
    local name = name and name:gsub("#%x%x%x%x%x%x", ""):lower() or nil
    if name then
        for _, player in ipairs(getElementsByType("player")) do
            local name_ = getPlayerName(player):gsub("#%x%x%x%x%x%x", ""):lower()
            if name_:find(name, 1, true) then
                return player
            end
        end
    end
end

function loadGridlistData()
	guiGridListClear(ignoreGridlist)
	local settingValue = exports.DENsettings:getPlayerSetting("ignorePeople")
	if (not settingValue) then
		exports.DENsettings:setPlayerSetting("ignorePeople", toJSON({}))
		return true
	end
	local settingValue = fromJSON(settingValue)
	ignore = settingValue
	for i, v in pairs(settingValue) do
		local plrName = exports.server:getPlayerFromAccountname(i)
		if (not plrName) then
			plrName = "N/A"
		else
			plrName = getPlayerName(plrName)
		end
		local r, g, b = 255, 0, 0
		if (plrName ~= "N/A") then
			r, g, b = 0, 255, 0
		end
		local row = guiGridListAddRow(ignoreGridlist, plrName, i)
		guiGridListSetItemColor(ignoreGridlist, row, 1, r, g, b)
		guiGridListSetItemColor(ignoreGridlist, row, 2, r, g, b)
	end
end

function openIgnoreWindow()
	createIgnoreWindow()
	local vis = (not guiGetVisible(ignoreWindow))
	if (not vis) then
		closeIgnoreWindow("left")
		return true
	end
	loadGridlistData()
	guiSetVisible(ignoreWindow, true)
	showCursor(vis)
end
addCommandHandler("ignore", openIgnoreWindow)

function blockMessages(text)
	local spli = split(text, "\:")
	if (#spli <= 1) then
		return false
	end
	local plr = split(spli[1], " ")
	if (#plr < 2) then
		return false
	end
	for i, v in pairs(ignore) do
		local plrName = exports.server:getPlayerFromAccountname(i)
		if (plrName) then
			plrName = getPlayerName(plrName)
			--outputDebugString(plr[2].." vs "..plrName)
			if (string.find(plr[2], plrName, 1, true)) then
				cancelEvent()
				break
			end
		end
	end
end
addEventHandler("onClientChatMessage", root, blockMessages)
