reasonsBB = 
{
	"#1 Trying to kill other civilians",
	"#2 Trolling",
	"#3 Misusing civilian bugs",
}

rsaPanel = guiCreateWindow(0.25, 0.19, 0.51, 0.62, "AuroraRPG - RSA Panel", true)
guiWindowSetSizable(rsaPanel, false)
guiSetAlpha(rsaPanel, 0.80)
guiSetVisible(rsaPanel, false)

rsaTabPanel = guiCreateTabPanel(0.01, 0.07, 0.97, 0.83, true, rsaPanel)

memberT = guiCreateTab("RSA Members", rsaTabPanel)

membersG = guiCreateGridList(0.01, 0.02, 0.98, 0.95, true, memberT)
guiGridListAddColumn(membersG, "Member account", 0.5)
guiGridListAddColumn(membersG, "Member level", 0.5)

managementTab = guiCreateTab("Management", rsaTabPanel)

playersG = guiCreateGridList(0.01, 0.03, 0.47, 0.94, true, managementTab)
guiGridListAddColumn(playersG, "Player name", 0.9)
punishP = guiCreateButton(0.48, 0.55, 0.50, 0.08, "Punish", true, managementTab)
ban = guiCreateRadioButton(0.49, 0.47, 0.50, 0.05, "Ban", true, managementTab)
kick = guiCreateRadioButton(0.49, 0.40, 0.50, 0.05, "Kick", true, managementTab)
warn = guiCreateRadioButton(0.49, 0.33, 0.50, 0.05, "Warn", true, managementTab)
guiRadioButtonSetSelected(warn, true)
reasonsB = guiCreateComboBox(0.48, 0.03, 0.50, 0.61, "", true, managementTab)
reasons = guiCreateEdit(0.48, 0.11, 0.50, 0.06, "Custom Reason", true, managementTab)
reasonCustom = guiCreateCheckBox(0.49, 0.28, 0.49, 0.04, "Custom reason", true, true, managementTab)
checkLogs = guiCreateButton(0.48, 0.67, 0.50, 0.08, "Check logs of player", true, managementTab)

logsT = guiCreateTab("Logs", rsaTabPanel)

logs = guiCreateGridList(6, 8, 617, 330, false, logsT)
guiGridListAddColumn(logs, "Log line", 0.9)

for i, v in ipairs(reasonsBB) do
	guiComboBoxAddItem(reasonsB, v)
end
guiComboBoxSetSelected(reasonsB, 0)


closeButton = guiCreateButton(0.02, 0.90, 0.97, 0.07, "Close", true, rsaPanel)

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

function set_number_mode(guiElement)
	addEventHandler("onClientGUIChanged", guiElement, number_mode_function)
end

function placeholder_function()
	if (eventName == "onClientGUIFocus") then
		local newText = guiGetText(source)
		if (newText == getElementData(source, "place_holder")) then
			guiSetText(source, "")
		end
	else
		if (guiGetText(source) == "" and getElementData(source, "place_holder")) then
			guiSetText(source, getElementData(source, "place_holder"))
		end
	end
end

function set_placeholder(guiElement)
	addEventHandler("onClientGUIFocus", guiElement, placeholder_function, true)
	addEventHandler("onClientGUIBlur", guiElement, placeholder_function, true)
	setElementData(guiElement, "place_holder", guiGetText(guiElement))
end


--set_placeholder(time)
set_placeholder(reasons)
--set_number_mode(time)

function panel_toggle(rsa, level, log2s)
	local guiV = not guiGetVisible(rsaPanel)
	showCursor(guiV)
	guiSetVisible(rsaPanel, guiV)

	if (rsa) then
		guiGridListClear(membersG)
		for i, v in ipairs(rsa) do
			guiGridListAddRow(membersG, v.accountName, v.level)
		end
	end
	if (log2s) then
		guiGridListClear(logs)
		for i, v in ipairs(log2s) do
			guiGridListAddRow(logs, v.date..' '..v.line)
		end
	end
	if (level and level < 3) then
		guiSetEnabled(ban, false)
	end

	guiGridListClear(playersG)
	for i, v in ipairs(getElementsByType("player")) do
		if (getPlayerTeam(v) == getTeamFromName("Civilian Workers")) then
			guiGridListAddRow(playersG, getPlayerName(v))
		end
	end
end
addEvent("AURrsa.rsaP", true)
addEventHandler("AURrsa.rsaP", root, panel_toggle)

function handle_buttons(button)
	if (button ~= "left") then
		return false 
	end

	if (source == closeButton) then
		panel_toggle()
	end

	if (source == punishP) then
		local r = guiGridListGetSelectedItem(playersG)
		if (r == -1) then
			outputChatBox("Please click")
			return false 
		end
		local t = guiGridListGetItemText(playersG, r, 1)
		local playerName = getPlayerFromName(t)
		if (not playerName) then
			guiGridListClear(playersG)
			for i, v in ipairs(getElementsByType("player")) do
				if (getPlayerTeam(v) == getTeamFromName("Civilian Workers")) then
					guiGridListAddRow(playersG, getPlayerName(v))
				end
			end
			outputChatBox("Invalid player")
			return false 
		end
		local reason = guiComboBoxGetItemText(reasonsB, guiComboBoxGetSelected(reasonsB))
		if (guiCheckBoxGetSelected(reasonCustom)) then
			reason = guiGetText(reasons)
		end
		local t = "Warn"
		if (guiRadioButtonGetSelected(ban)) then
			t = "Ban"
		elseif (guiRadioButtonGetSelected(kick)) then
			t = "Kick"
		end
		triggerServerEvent("AURrsa.punish", localPlayer, playerName, 0, reason, t)
	end
end
addEventHandler("onClientGUIClick", closeButton, handle_buttons, false)
addEventHandler("onClientGUIClick", punishP, handle_buttons, false)