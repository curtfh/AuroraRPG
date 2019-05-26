
OfflinePunishment = {
    edit = {},
    button = {},
    window = {},
    label = {},
    radiobutton = {}
}
OfflinePunishment.window[1] = guiCreateWindow(111, 49, 573, 511, "", false)
guiWindowSetSizable(OfflinePunishment.window[1], false)
guiSetVisible(OfflinePunishment.window[1],false)
OfflinePunishment.label[1] = guiCreateLabel(16, 27, 547, 35, "Account Finder : \nYou must get the Account first", false, OfflinePunishment.window[1])
guiSetFont(OfflinePunishment.label[1], "default-bold-small")
guiLabelSetHorizontalAlign(OfflinePunishment.label[1], "center", false)
OfflinePunishment.label[2] = guiCreateLabel(16, 147, 112, 15, "Bans Punishment", false, OfflinePunishment.window[1])
guiSetFont(OfflinePunishment.label[2], "default-bold-small")
OfflinePunishment.label[3] = guiCreateLabel(16, 333, 149, 24, "Account punishments", false, OfflinePunishment.window[1])
guiSetFont(OfflinePunishment.label[3], "default-bold-small")
guiLabelSetVerticalAlign(OfflinePunishment.label[3], "center")
OfflinePunishment.label[4] = guiCreateLabel(16, 125, 547, 15, "--------------------------------------------------------------------------------------------------------------------------------------------", false, OfflinePunishment.window[1])
guiSetFont(OfflinePunishment.label[4], "default-bold-small")
OfflinePunishment.label[5] = guiCreateLabel(16, 67, 126, 25, "Target Account :?", false, OfflinePunishment.window[1])
guiSetFont(OfflinePunishment.label[5], "default-bold-small")
guiLabelSetColor(OfflinePunishment.label[5], 244, 170, 10)
guiLabelSetVerticalAlign(OfflinePunishment.label[5], "center")
OfflinePunishment.edit[1] = guiCreateEdit(16, 99, 383, 23, "Target Serial", false, OfflinePunishment.window[1])
OfflinePunishment.button[1] = guiCreateButton(409, 99, 142, 23, "Get Account By Serial", false, OfflinePunishment.window[1])
guiSetProperty(OfflinePunishment.button[1], "NormalTextColour", "FFAAAAAA")
OfflinePunishment.label[6] = guiCreateLabel(16, 170, 66, 25, "Account :", false, OfflinePunishment.window[1])
guiSetFont(OfflinePunishment.label[6], "default-bold-small")
guiLabelSetColor(OfflinePunishment.label[6], 244, 170, 10)
guiLabelSetVerticalAlign(OfflinePunishment.label[6], "center")
OfflinePunishment.label[7] = guiCreateLabel(16, 205, 66, 25, "Serial :", false, OfflinePunishment.window[1])
guiSetFont(OfflinePunishment.label[7], "default-bold-small")
guiLabelSetColor(OfflinePunishment.label[7], 244, 170, 10)
guiLabelSetVerticalAlign(OfflinePunishment.label[7], "center")
OfflinePunishment.label[8] = guiCreateLabel(16, 304, 547, 19, "--------------------------------------------------------------------------------------------------------------------------------------------", false, OfflinePunishment.window[1])
guiSetFont(OfflinePunishment.label[8], "default-bold-small")
OfflinePunishment.label[9] = guiCreateLabel(16, 240, 66, 25, "Time : (Sec)", false, OfflinePunishment.window[1])
guiSetFont(OfflinePunishment.label[9], "default-bold-small")
guiLabelSetColor(OfflinePunishment.label[9], 244, 170, 10)
guiLabelSetVerticalAlign(OfflinePunishment.label[9], "center")
OfflinePunishment.label[10] = guiCreateLabel(16, 275, 66, 25, "Reason :", false, OfflinePunishment.window[1])
guiSetFont(OfflinePunishment.label[10], "default-bold-small")
guiLabelSetColor(OfflinePunishment.label[10], 244, 170, 10)
guiLabelSetVerticalAlign(OfflinePunishment.label[10], "center")
OfflinePunishment.edit[2] = guiCreateEdit(88, 170, 312, 25, "Target Account", false, OfflinePunishment.window[1])
OfflinePunishment.edit[3] = guiCreateEdit(88, 205, 312, 25, "Target Serial", false, OfflinePunishment.window[1])
OfflinePunishment.edit[4] = guiCreateEdit(88, 240, 312, 25, "300", false, OfflinePunishment.window[1])
OfflinePunishment.edit[5] = guiCreateEdit(88, 275, 312, 25, "Reason", false, OfflinePunishment.window[1])
OfflinePunishment.button[2] = guiCreateButton(411, 170, 142, 25, "Account Ban", false, OfflinePunishment.window[1])
guiSetProperty(OfflinePunishment.button[2], "NormalTextColour", "FFAAAAAA")
OfflinePunishment.radiobutton[1] = guiCreateRadioButton(188, 333, 134, 24, "Jail punishment", false, OfflinePunishment.window[1])
OfflinePunishment.radiobutton[2] = guiCreateRadioButton(306, 333, 134, 24, "Mute punishment", false, OfflinePunishment.window[1])
OfflinePunishment.radiobutton[3] = guiCreateRadioButton(426, 333, 134, 24, "Global Mute", false, OfflinePunishment.window[1])
OfflinePunishment.label[11] = guiCreateLabel(16, 376, 66, 25, "Account :", false, OfflinePunishment.window[1])
guiSetFont(OfflinePunishment.label[11], "default-bold-small")
guiLabelSetColor(OfflinePunishment.label[11], 244, 170, 10)
guiLabelSetVerticalAlign(OfflinePunishment.label[11], "center")
OfflinePunishment.button[3] = guiCreateButton(410, 205, 142, 25, "Serial Ban", false, OfflinePunishment.window[1])
guiSetProperty(OfflinePunishment.button[3], "NormalTextColour", "FFAAAAAA")
OfflinePunishment.label[12] = guiCreateLabel(16, 411, 66, 25, "Time: (Sec)", false, OfflinePunishment.window[1])
guiSetFont(OfflinePunishment.label[12], "default-bold-small")
guiLabelSetColor(OfflinePunishment.label[12], 244, 170, 10)
guiLabelSetVerticalAlign(OfflinePunishment.label[12], "center")
OfflinePunishment.label[13] = guiCreateLabel(16, 446, 66, 25, "Reason :", false, OfflinePunishment.window[1])
guiSetFont(OfflinePunishment.label[13], "default-bold-small")
guiLabelSetColor(OfflinePunishment.label[13], 244, 170, 10)
guiLabelSetVerticalAlign(OfflinePunishment.label[13], "center")
OfflinePunishment.edit[6] = guiCreateEdit(88, 376, 312, 25, "Account", false, OfflinePunishment.window[1])
OfflinePunishment.edit[7] = guiCreateEdit(88, 411, 312, 25, "300", false, OfflinePunishment.window[1])
OfflinePunishment.edit[8] = guiCreateEdit(88, 446, 312, 25, "Reason", false, OfflinePunishment.window[1])
OfflinePunishment.button[4] = guiCreateButton(423, 376, 120, 27, "Punish him", false, OfflinePunishment.window[1])
guiSetProperty(OfflinePunishment.button[4], "NormalTextColour", "FFAAAAAA")
OfflinePunishment.button[5] = guiCreateButton(423, 471, 120, 27, "Close panel", false, OfflinePunishment.window[1])
guiSetProperty(OfflinePunishment.button[5], "NormalTextColour", "FFAAAAAA")


addEventHandler("onClientGUIClick",root,function()
	if source == OfflinePunishment.button[5] then
		guiSetVisible(OfflinePunishment.window[1],false)
		showCursor(false)
	elseif source == OfflinePunishment.button[4] then
		if guiRadioButtonGetSelected(OfflinePunishment.radiobutton[1]) then
			local AccountName = guiGetText(OfflinePunishment.edit[6])
			local theTime = guiGetText(OfflinePunishment.edit[7])
			local reason = guiGetText(OfflinePunishment.edit[8])
			triggerServerEvent("offlineJail",localPlayer,AccountName,theTime,reason)
		elseif	guiRadioButtonGetSelected(OfflinePunishment.radiobutton[2]) then
			local AccountName = guiGetText(OfflinePunishment.edit[6])
			local theTime = guiGetText(OfflinePunishment.edit[7])
			local reason = guiGetText(OfflinePunishment.edit[8])
			triggerServerEvent("offlineMute",localPlayer,AccountName,theTime,reason)
		elseif	guiRadioButtonGetSelected(OfflinePunishment.radiobutton[3]) then
			local AccountName = guiGetText(OfflinePunishment.edit[6])
			local theTime = guiGetText(OfflinePunishment.edit[7])
			local reason = guiGetText(OfflinePunishment.edit[8])
			triggerServerEvent("offlineGOMute",localPlayer,AccountName,theTime,reason)
		end
	elseif source == OfflinePunishment.button[3] then
		local AccountName = guiGetText(OfflinePunishment.edit[2])
		local serial = guiGetText(OfflinePunishment.edit[3])
		local theTime = guiGetText(OfflinePunishment.edit[4])
		local reason = guiGetText(OfflinePunishment.edit[5])
		triggerServerEvent("banOfflineSerial",localPlayer,AccountName,serial,theTime,reason)
	elseif source == OfflinePunishment.button[2] then
		local AccountName = guiGetText(OfflinePunishment.edit[2])
		local theTime = guiGetText(OfflinePunishment.edit[4])
		local reason = guiGetText(OfflinePunishment.edit[5])
		triggerServerEvent("banOfflineAccount",localPlayer,AccountName,theTime,reason)
	elseif source == OfflinePunishment.button[1] then
		local AccountFiner = guiGetText(OfflinePunishment.edit[1])
		triggerServerEvent("getPlayerAccountBySerial",localPlayer,AccountFiner)
	end
end)

addCommandHandler("offline",function()
	if exports.CSGstaff:isPlayerStaff(localPlayer) and exports.CSGstaff:getPlayerAdminLevel(localPlayer) >= 2 then
		guiSetVisible(OfflinePunishment.window[1],true)
		showCursor(true)
	end
end)

addEvent("foundSerial",true)
addEventHandler("foundSerial",root,function(Account)
	guiSetText(OfflinePunishment.label[5],Account)
end)





