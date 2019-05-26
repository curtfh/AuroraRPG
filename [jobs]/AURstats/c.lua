local window = GuiWindow(367, 156, 515, 500, "Aurora RPG ~ Stats panel", false)
window.sizable = false
window.visible = false

screenW, screenH = GuiElement.getScreenSize()
windowW, windowH = window:getSize(false)
window:setPosition((screenW-windowW)/2, (screenH-windowH)/2, false)

local playersGrid = GuiGridList(9, 80, 152, 420, false, window)
playersGrid:addColumn("Player name", 0.9 )
playersGrid:setScrollBars(false, false)
playersGrid:setSortingEnabled( false)


local check = GuiCheckBox(315, 25, 195, 21, "Show my stats to other players", true, false, window)

local playersEdit = GuiEdit(9, 25, 152, 26, "Search for a player...", false, window)

local accountSearch = guiCreateButton(10, 56, 149, 18, "Search Account", false, window)  

local crim = GuiRadioButton(167, 25, 57.5, 15, "Criminal", false, window)
local law = GuiRadioButton(167, 41, 40, 15, "Law", false, window)
local civ = GuiRadioButton(167, 56, 51.5, 15, "Civilian", false, window)

local refresh = GuiButton(315, 50, 80, 21, "Refresh", false, window)
local close = GuiButton(415, 50, 80, 21, "Close", false, window)

local statsGrid = GuiGridList(165, 80, 350, 418, false, window)
statsGrid:addColumn("Stat", 0.5 )
statsGrid:addColumn("Value", 0.5)
statsGrid:addRow()
statsGrid:setScrollBars(false, false)
statsGrid:setSortingEnabled(false)

function openGUI()
		if exports.server:isPlayerLoggedIn(localPlayer) then
			window.visible = not window.visible
			showCursor(window.visible)
		end
    end
addCommandHandler("stats",openGUI)
function addPlayerIntoGrid(player)
    local row = playersGrid:addRow()
    playersGrid:setItemText(row, 1, player.name, false, false)
    playersGrid:setItemColor(row, 1, player:getNametagColor())
end

addEventHandler("onClientGUIFocus", playersEdit,
    function()
        if source == playersEdit then
            if playersEdit.text:len() == 0 then
                playersEdit.text = "Search for a player.."
            elseif playersEdit.text == "Search for a player..." then
                playersEdit.text = ""
            end
        end
    end
)

addEventHandler("onClientGUIBlur", playersEdit,
    function()
        if source == playersEdit then
            if playersEdit.text:len() == 0 then
                playersEdit.text = "Search for a player..."
                for _, v in ipairs(Element.getAllByType("player")) do
                    addPlayerIntoGrid(v)
                end
            end
        end
    end
)

addEvent("refreshPlayers", true)

addEvent("AURstats.send", true)

addEvent("refreshStats", true)

addEventHandler("refreshStats", resourceRoot,
    function(player1, state)
        local row = playersGrid:getSelectedItem()
        if not (row == -1) then
            local player2 = Player.create(playersGrid:getItemText(row, 1))
            if (player1 == player2) and (state == false) then
                statsGrid:clear()
                outputChatBox("Sorry, this player disallowed sharing his stats!", 255, 0, 0)
            elseif (player1 == player2) and (state == true) then
                triggerServerEvent("AURstats.get", resourceRoot, player1, false)
                outputChatBox("This player allowed sharing his stats!", 0, 255, 0)
            end
        end
    end
)

addEventHandler("AURstats.send", resourceRoot,
    function(data)
        statsGrid:clear()
        local cr = crim.selected
        local la = law.selected
        local ci = civ.selected
        local category
        if cr then
            category = "Criminal"
        elseif la then
            category = "Law"
        elseif ci then
            category = "Civilian"
        end
        statsGrid:setItemText(statsGrid:addRow(), 1, category, true, false)
        local topair = data[category]
        for _, v in pairs(topair) do
            local row = statsGrid:addRow()
            statsGrid:setItemText(row, 1, v[1], false, false)
            statsGrid:setItemText(row, 2, v[2], false, false)
        end
    end
)

addEventHandler("refreshPlayers", resourceRoot,
    function(new)
        playersGrid:clear()
        for _, v in ipairs(new) do
            addPlayerIntoGrid(v)
        end
    end
)

addEventHandler("onClientGUIChanged", playersEdit,
    function(element)
        if element == source and source == playersEdit then
            playersGrid:clear()
            for _, v in ipairs(Element.getAllByType("player")) do
                local match = v.name:lower():match(playersEdit.text:lower())
                if match then
                    addPlayerIntoGrid(v)
                end
            end
        end
    end
)

addEventHandler("onClientGUIClick", check,
    function(button)
        if source == check and button == "left" then
            triggerServerEvent("refreshSelected", resourceRoot, check.selected)
        end
    end
, false)

addEventHandler("onClientGUIClick", refresh,
    function(button)
        if button == "left" and source == refresh then
            local row = playersGrid:getSelectedItem()
            if not (row == -1) then
                local player = Player.create(playersGrid:getItemText(row, 1))
                triggerServerEvent("AURstats.get", resourceRoot, player, false)
            else
                outputChatBox("Select a player first!", 255, 0, 0)
            end
        end
    end
, false)

addEventHandler("onClientGUIClick", close,
    function(button)
        if button == "left" and source == close then
            window.visible = false
			showCursor(false)
        end
    end
, false)

local antiSpamAccountSearch = getTickCount()

addEventHandler("onClientGUIClick", accountSearch,
    function(button)
        if (getTickCount() - antiSpamAccountSearch < 10000) then
            outputChatBox("Wait at least "..(math.floor((10000 - (getTickCount() - antiSpamAccountSearch)) / 1000)).."s before using this button again", 255, 0, 0)
            return false
        end
        if button == "left" and source == accountSearch then
            local cr = crim.selected
            local la = law.selected
            local ci = civ.selected
			if not cr and not la and not ci then
				outputChatBox("Select a category first", 255, 0, 0)
				playersGrid:setSelectedItem(-1, -1)
				return false
			end
            antiSpamAccountSearch = getTickCount()
			local player = guiGetText(playersEdit)
            triggerServerEvent("AURstats.get", resourceRoot, player, true)
			guiGridListSetSelectedItem (playersGrid, -1, -1)
        end
    end
, false)

addEventHandler("onClientGUIClick", playersGrid,
    function(button)
        if button == "left" and source == playersGrid then
            local row = playersGrid:getSelectedItem()
            local cr = crim.selected
            local la = law.selected
            local ci = civ.selected
            if not (row == -1) then
                if not cr and not la and not ci then
                    outputChatBox("Select a category first", 255, 0, 0)
                    playersGrid:setSelectedItem(-1, -1)
                    return
                end
                local player = Player.create(playersGrid:getItemText(row, 1))
                triggerServerEvent("AURstats.get", resourceRoot, player, false)
            else
                statsGrid:clear()
            end
        end
    end
, false)

local radios = {crim, law, civ}

function onSelectCategory()
    local row = playersGrid:getSelectedItem()
    if not (row == -1) then
        local player = Player.create(playersGrid:getItemText(row, 1))
        triggerServerEvent("AURstats.get", resourceRoot, player, false)
	else
		triggerServerEvent("AURstats.get", resourceRoot, guiGetText(playersEdit), true)
    end
end

for _, v in ipairs(radios) do
    addEventHandler("onClientGUIClick", v, onSelectCategory)
end

function canShowState()
    return check.selected
end
