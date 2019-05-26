--**************************************************************************************
--********							Duel panel 									********
--**************************************************************************************

dueling = {
    tab = {},
    staticimage = {},
    edit = {},
    window = {},
    tabpanel = {},
    label = {},
    button = {},
    checkbox = {},
    gridlist = {},
    combobox = {}
}
local rx, ry = guiGetScreenSize()
dueling.window[1] = guiCreateWindow((rx/2) - 310, (ry/2) - 250, 614, 507, "", false)
guiWindowSetSizable(dueling.window[1], false)
guiSetAlpha(dueling.window[1], 1.00)
guiSetVisible(dueling.window[1],false)
dueling.staticimage[1] = guiCreateStaticImage(122, 25, 344, 84, "logo.png", false, dueling.window[1])
dueling.tabpanel[1] = guiCreateTabPanel(9, 113, 595, 380, false, dueling.window[1])

dueling.tab[1] = guiCreateTab("Duel", dueling.tabpanel[1])

dueling.gridlist[1] = guiCreateGridList(5, 2, 203, 343, false, dueling.tab[1])
guiGridListAddColumn(dueling.gridlist[1], "Name", 0.9)
dueling.label[1] = guiCreateLabel(299, 19, 181, 23, "Allowed Weapons:", false, dueling.tab[1])
guiSetFont(dueling.label[1], "default-bold-small")
guiLabelSetColor(dueling.label[1], 25, 125, 227)
guiLabelSetHorizontalAlign(dueling.label[1], "center", false)
dueling.checkbox[1] = guiCreateCheckBox(238, 52, 125, 22, "Knfie/Katana", true, false, dueling.tab[1])
dueling.checkbox[2] = guiCreateCheckBox(417, 52, 125, 22, "Pistols/Deagle", true, false, dueling.tab[1])
dueling.checkbox[3] = guiCreateCheckBox(238, 84, 125, 22, "Sawn/Spas", true, false, dueling.tab[1])
dueling.checkbox[4] = guiCreateCheckBox(417, 84, 125, 22, "Mp5/Tec", true, false, dueling.tab[1])
dueling.checkbox[5] = guiCreateCheckBox(238, 116, 125, 22, "M4/AK", true, false, dueling.tab[1])
dueling.checkbox[6] = guiCreateCheckBox(417, 116, 125, 22, "Sniper/Rifle", true, false, dueling.tab[1])
dueling.checkbox[7] = guiCreateCheckBox(238, 148, 125, 22, "RPG/Minigun", true, false, dueling.tab[1])
dueling.checkbox[8] = guiCreateCheckBox(417, 148, 125, 22, "Satchels/Grenades", true, false, dueling.tab[1])
dueling.edit[1] = guiCreateEdit(257, 236, 110, 25, "", false, dueling.tab[1])
dueling.label[2] = guiCreateLabel(234, 210, 152, 18, "Duel Bet", false, dueling.tab[1])
guiSetFont(dueling.label[2], "default-bold-small")
guiLabelSetColor(dueling.label[2], 253, 0, 0)
guiLabelSetHorizontalAlign(dueling.label[2], "center", false)
dueling.label[3] = guiCreateLabel(407, 210, 152, 18, "Arena", false, dueling.tab[1])
guiSetFont(dueling.label[3], "default-bold-small")
guiLabelSetColor(dueling.label[3], 243, 158, 9)
guiLabelSetHorizontalAlign(dueling.label[3], "center", false)
dueling.combobox[1] = guiCreateComboBox(406, 236, 153, 99, "Duel", false, dueling.tab[1])
dueling.button[1] = guiCreateButton(250, 296, 130, 28, "Duel/Cancel", false, dueling.tab[1])
dueling.button[5] = guiCreateButton(407, 296, 130, 28, "Close", false, dueling.tab[1])
guiSetProperty(dueling.button[1], "NormalTextColour", "FFAAAAAA")
guiSetProperty(dueling.button[5], "NormalTextColour", "FFAAAAAA")

--dueling.tab[2] = guiCreateTab("not ready", dueling.tabpanel[1])
dueling.tab[3] = guiCreateTab("Invites", dueling.tabpanel[1])

dueling.gridlist[2] = guiCreateGridList(10, 5, 352, 341, false, dueling.tab[3])
guiGridListAddColumn(dueling.gridlist[2], "Name", 0.3)
guiGridListAddColumn(dueling.gridlist[2], "Bet", 0.2)
guiGridListAddColumn(dueling.gridlist[2], "Duel Arena", 0.2)
dueling.button[2] = guiCreateButton(416, 113, 122, 27, "Accept", false, dueling.tab[3])
guiSetProperty(dueling.button[2], "NormalTextColour", "FFAAAAAA")
dueling.button[3] = guiCreateButton(416, 150, 122, 27, "Reject", false, dueling.tab[3])
guiSetProperty(dueling.button[3], "NormalTextColour", "FFAAAAAA")
dueling.button[4] = guiCreateButton(416, 187, 122, 27, "Clear", false, dueling.tab[3])
guiSetProperty(dueling.button[4], "NormalTextColour", "FFAAAAAA")
dueling.label[4] = guiCreateLabel(402, 18, 151, 22, "Won duels", false, dueling.tab[3])
guiSetFont(dueling.label[4], "default-bold-small")
guiLabelSetColor(dueling.label[4], 34, 235, 19)
dueling.label[5] = guiCreateLabel(402, 50, 151, 22, "Lost duels", false, dueling.tab[3])
guiSetFont(dueling.label[5], "default-bold-small")
guiLabelSetColor(dueling.label[5], 253, 0, 0)


duelInfo = {
    checkbox = {},
    staticimage = {},
    label = {},
    button = {},
    window = {}
}
duelInfo.window[1] = guiCreateWindow((rx/2) - 250, (ry/2) - 220, 491, 431, "AUR ~ Duel", false)
guiWindowSetSizable(duelInfo.window[1], false)

duelInfo.staticimage[1] = guiCreateStaticImage(25, 27, 448, 120, "logo.png", false, duelInfo.window[1])
duelInfo.checkbox[1] = guiCreateCheckBox(68, 210, 97, 15, "Knife/Katana", false, false, duelInfo.window[1])
duelInfo.checkbox[2] = guiCreateCheckBox(213, 210, 97, 15, "Pistols/Deagle", false, false, duelInfo.window[1])
duelInfo.checkbox[3] = guiCreateCheckBox(341, 210, 97, 15, "Sawn/Spas", false, false, duelInfo.window[1])
duelInfo.checkbox[4] = guiCreateCheckBox(68, 235, 97, 15, "Mp5/Tec", false, false, duelInfo.window[1])
duelInfo.checkbox[5] = guiCreateCheckBox(213, 235, 97, 15, "M4/Ak47", false, false, duelInfo.window[1])
duelInfo.checkbox[6] = guiCreateCheckBox(341, 235, 97, 15, "Sniper/Rifle", false, false, duelInfo.window[1])
duelInfo.checkbox[7] = guiCreateCheckBox(68, 260, 97, 15, "RPG/Minigun", false, false, duelInfo.window[1])
duelInfo.checkbox[8] = guiCreateCheckBox(213, 260, 97, 15, "Grenades/Satchels", false, false, duelInfo.window[1])
duelInfo.button[1] = guiCreateButton(188, 337, 122, 29, "Accept Duel", false, duelInfo.window[1])
guiSetProperty(duelInfo.button[1], "NormalTextColour", "FFAAAAAA")
duelInfo.button[2] = guiCreateButton(188, 376, 122, 29, "Close", false, duelInfo.window[1])
guiSetProperty(duelInfo.button[2], "NormalTextColour", "FFAAAAAA")
duelInfo.label[1] = guiCreateLabel(25, 157, 448, 43, "Do you accept the duel ?", false, duelInfo.window[1])
guiSetFont(duelInfo.label[1], "sa-header")
guiLabelSetHorizontalAlign(duelInfo.label[1], "center", false)
guiLabelSetVerticalAlign(duelInfo.label[1], "center")
guiSetVisible(duelInfo.window[1],false)

addEvent("NGCduel.openDuelPanel",true)
addEventHandler("NGCduel.openDuelPanel",root,function(won,lost,duels)
	if getElementData(localPlayer,"isPlayerProtected",true) then exports.NGCdxmsg:createNewDxMessage("Leave the protected area to duel",255,0,0) return false end
	if getElementData(localPlayer,"isBuyingArmor",true) then exports.NGCdxmsg:createNewDxMessage("Close the armor panel",255,0,0) return false end
	guiSetVisible(dueling.window[1],true)
	showCursor(true)
	guiSetText(dueling.label[4],"Wins: "..won)
	guiSetText(dueling.label[5],"Loses: "..lost)
	updatePlayerGrid()
	updateInvitesGrid(won,lost,duels)
end)


addEvent("NGCduel.abortDuel",true)
addEventHandler("NGCduel.abortDuel",root,function()
	guiSetVisible(duelInfo.window[1],false)
	showCursor(false)
end)

addEvent("NGCduel.updatePanel",true)
addEventHandler("NGCduel.updatePanel",root,function(won,lost,duels)
	updatePlayerGrid()
	updateInvitesGrid(won,lost,duels)
end)

addEventHandler( "onClientGUIChanged",root,function()
	if source == dueling.edit[1] then
		local txts2 = guiGetText(source)
		local removed = string.gsub(txts2, "[^0-9]", "")
		if (removed ~= txts2) then
			guiSetText(source, removed)
		end
	end
end)




addEventHandler("onClientGUIClick",root,function()
	if source == dueling.button[5] then
		guiSetVisible(dueling.window[1],false)
		showCursor(false)
	elseif source == duelInfo.button[1] then
		if (antiSpamCheck()) then return end
		local name = getGridListItem(dueling.gridlist[2], false)
		local t = getGridListItem(dueling.gridlist[2], false, 3)
		if (name) then
			local player = getPlayerFromName(name)
			triggerServerEvent("NGCduel.AcceptDuel", localPlayer, player)
		end
	elseif source == duelInfo.button[2] then
		guiSetVisible(duelInfo.window[1],false)
		showCursor(false)
	elseif source == dueling.button[1] then
		local bet = guiGetText(dueling.edit[1])
		local bet = tonumber(bet)
		local player = getGridListItem(dueling.gridlist[1], true)
		local weaponsAllowed = getWeaponsTable()
		local arena = guiGetText(dueling.combobox[1])
		if tonumber(bet) and bet <= 1000000 and bet >= 500 then
			if weaponsAllowed then
				if arena then
					if player then
						triggerServerEvent("NGCduel.duelPlayer", root, player, tonumber(bet), weaponsAllowed, arena)
						local r, g, b = guiGridListGetItemColor (dueling.gridlist[1], guiGridListGetSelectedItem(dueling.gridlist[1]), 1)
						if (r == 255) then 
							guiGridListSetItemColor (dueling.gridlist[1], guiGridListGetSelectedItem(dueling.gridlist[1]), 1, 0, 0, 0)
						else
							guiGridListSetItemColor (dueling.gridlist[1], guiGridListGetSelectedItem(dueling.gridlist[1]), 1, 255, 0, 0)
						end 
						
					else
						exports.NGCdxmsg:createNewDxMessage("You didn't select a player",255,0,0)
					end
				end
			end
		else
			exports.NGCdxmsg:createNewDxMessage("Max bet money : $1,000,000",255,0,0)
			exports.NGCdxmsg:createNewDxMessage("Min bet money : $500",255,0,0)
		end
	elseif source == dueling.tabpanel[1] then
		triggerServerEvent("NGCduel.UpdateMyGrid",localPlayer)
	elseif source == dueling.button[2] then
		showDuel()
	elseif source == dueling.button[3] then
		rejectChallenge()
	elseif source == dueling.button[4] then
		triggerServerEvent("NGCduel.rejectAllDuels", localPlayer)
	end
end)

function updateInvitesGrid(won,lost,duels)
	if (duels) then
		guiGridListClear(dueling.gridlist[2])
		for k, v in pairs(duels["player"]) do
			if (isElement(k)) then
				local row = guiGridListAddRow(dueling.gridlist[2])
				guiGridListSetItemText(dueling.gridlist[2], row, 1, getPlayerName(k), false, false)
				guiGridListSetItemText(dueling.gridlist[2], row, 2, v[1], false, false)
				guiGridListSetItemText(dueling.gridlist[2], row, 3, v[3], false, false)
				guiGridListSetItemData(dueling.gridlist[2], row, 1, v[2])
			end
		end
	end
end

function updatePlayerGrid()
	guiGridListClear(dueling.gridlist[1])
	for k, v in ipairs(getElementsByType("player")) do
		if (v ~= localPlayer) then
			local row = guiGridListAddRow(dueling.gridlist[1])
			guiGridListSetItemText(dueling.gridlist[1], row, 1, getPlayerName(v), false, false)
			guiGridListSetItemData(dueling.gridlist[1], row, 1, v)
		end
	end
end


function showDuel()
	local rules = getGridListItem(dueling.gridlist[2], true)
	local duelType = getGridListItem(dueling.gridlist[2], false, 3)
	if (rules) then
		printDuelWeapons(duelType, rules)
	end
end

function rejectChallenge()
	local name = getGridListItem(dueling.gridlist[2], false)
	local t = getGridListItem(dueling.gridlist[2], false, 3)
	if (name) then
		local player = getPlayerFromName(name)
		triggerServerEvent("NGCduel.RejectDuel", localPlayer, player or name, t)
	end
end


lastSpamCheck = 0
function antiSpamCheck()
	if (getTickCount() > lastSpamCheck) then
		lastSpamCheck = getTickCount() + 1500
		return false
	else
		return true
	end
end


function printDuelWeapons(duelType, wep)
	guiSetVisible(duelInfo.window[1], true)
	guiSetVisible(dueling.window[1], false)
	for i=1,8 do
		guiCheckBoxSetSelected(duelInfo.checkbox[i], wep[i])
		guiSetEnabled(duelInfo.checkbox[i], false)
	end
end

--**************************************************************************************
--********							Duel miscs 									********
--**************************************************************************************
function getGridListItem(gridlist, useData, col) -- fast check instead of fucking long things idk why we didn't use this with housing LOL
	if (useData) then
		return guiGridListGetItemData(gridlist, guiGridListGetSelectedItem(gridlist), col or 1)
	else
		return guiGridListGetItemText(gridlist, guiGridListGetSelectedItem(gridlist), col or 1)
	end
end

for k, v in pairs(mapObjects) do
	guiComboBoxAddItem(dueling.combobox[1], k)
end

---- weapons table belongs to ID of slot some of them useless
weapons = {
	[1] = {2, 3, 4, 5, 6, 7, 8, 9},
	[2] = {22, 23, 24},
	[3] = {25, 26, 27},
	[4] = {28, 29, 32},
	[5] = {30, 31},
	[6] = {33, 34},
	[7] = {35, 36, 37, 38},
	[8] = {16, 17, 18, 39},
	[9] = {41, 42, 43},
	[10] = {10, 11, 12, 13, 14, 15},
	[11] = {44, 45, 46},
	[12] = {40},
}

function getWeaponsTable()
	local weaponsTable = {}
	for i=1,8 do
		weaponsTable[i] = guiCheckBoxGetSelected(dueling.checkbox[i])
	end
	return weaponsTable
end

---- This has no info , you know it
---- just incase when player choose some weapons for duel

restrictedWeapons = {}

function onClientPreRender()
	if isPlayerDueling(localPlayer) then
		local weapon = getPedWeapon(localPlayer)
		local slot = getPedWeaponSlot(localPlayer)
		if (restrictedWeapons[weapon]) then
			local weapons = {}
			for i=1, 30 do
				if (getControlState("next_weapon")) then
					slot = slot + 1
				else
					slot = slot - 1
				end
				if (slot == 13) then
					slot = 0
				elseif (slot == -1) then
					slot = 12
				end
				if isWeaponDisabled(weapon) then
					setPedWeaponSlot(localPlayer, slot)
				end
				local w = getPedWeapon(localPlayer, slot)
				if (((w ~= 0 and slot ~= 0) or (w == 0 and slot == 0)) and not restrictedWeapons[w]) then
					setPedWeaponSlot(localPlayer, slot)
					break
				end
			end
		end
		local block, animation = getPedAnimation(localPlayer)
		if block then
			setPedAnimation(localPlayer,false)
		end
	end
end
addEventHandler("onClientPreRender", root, onClientPreRender)

function onClientPlayerWeaponFire(weapon)
	if (restrictedWeapons[weapon]) then return end
end
addEventHandler("onClientPlayerWeaponFire", localPlayer, onClientPlayerWeaponFire)

---- dont forget to make exports for these .........

function setWeaponDisabled(id, bool)
	if (id == 0) then return end
	restrictedWeapons[id] = bool
end

function isWeaponDisabled(id)
	return restrictedWeapons[id]
end

function setWeaponSlotDisabled(slot, bool)
	if (not weapons[slot]) then return end
	for k, v in ipairs(weapons[slot]) do
		setWeaponDisabled(v, bool)
	end
end


function onPlayerQuit()
	for i=0, (guiGridListGetRowCount(dueling.gridlist[1]) - 1) do
		if (guiGridListGetItemData(dueling.gridlist[1], i, 1)  == source) then
			guiGridListRemoveRow(dueling.gridlist[1], i)
		end
	end
end

function onPlayerJoin()
	local row = guiGridListAddRow(dueling.gridlist[1])
	guiGridListSetItemText(dueling.gridlist[1], row, 1, getPlayerName(source), false, false)
	guiGridListSetItemData(dueling.gridlist[1], row, 1, source)
end

function onPlayerNameChange()
	for i=0, (guiGridListGetRowCount(dueling.gridlist[1]) - 1) do
		if (guiGridListGetItemData(dueling.gridlist[1], i, 1) == source) then
			guiGridListSetItemText(dueling.gridlist[1], i, 1, getPlayerName(source), false, false)
		end
	end
end
addEventHandler("onClientPlayerJoin", root, onPlayerJoin)
addEventHandler("onClientPlayerQuit", root, onPlayerQuit)
addEventHandler("onClientPlayerChangeNick", root, onPlayerNameChange)


function msg(text)
	exports.NGCdxmsg:createNewDxMessage(text, 255, 255, 255)
end

--- check must get exports for this
function isPlayerDueling(player)
	local dimension = getElementDimension(player)
	if (dimension >= 11000 and dimension <= 12000) then
		return true
	end
end



--**************************************************************************************
--********					Duel hard stuff  									********
--**************************************************************************************

tempWeps = nil

function onPlayerDuel(dtype,weps, myTeam, map, index)
	--- dtype for 1 vs 1 or team so this will be later if i made team duels
	--- weps : weapons things , allowed and disallowed
	--- myTeam which it define the position of warp just that :|
	--- map the chosen map where the sender defined it
	--- index it will load map from index where ...etc
	tempWeps = weps  --- tempWeps was NIL so here we give it the rules
    loadMap(map, index) --- we defined map with index to find it

	--- weapons allowed where we added setWeaponSlotDisabled things :| the function before
    setWeaponSlotDisabled(1, not weps[1]) -- knfie katana
    setWeaponSlotDisabled(2, not weps[2]) -- dealge
    setWeaponSlotDisabled(3, not weps[3]) -- shotgun
    setWeaponSlotDisabled(4, not weps[4]) -- mp5
    setWeaponSlotDisabled(5, not weps[5]) -- m4
    setWeaponSlotDisabled(6, not weps[6]) --- rifles
    setWeaponSlotDisabled(7, not weps[7]) --- minigun
    setWeaponSlotDisabled(8, not weps[8]) -- explosion

	if (myTeam) then
        tempTeam = {}
        for k, v in pairs(myTeam) do
            tempTeam[v] = true
        end
    end

end
addEvent("onPlayerDuel",true)
addEventHandler("onPlayerDuel",root,onPlayerDuel)


function stopDuelClientside()
    setWeaponSlotDisabled(1, false)
    setWeaponSlotDisabled(2, false)
    setWeaponSlotDisabled(3, false)
    setWeaponSlotDisabled(4, false)
    setWeaponSlotDisabled(5, false)
    setWeaponSlotDisabled(6, false)
    setWeaponSlotDisabled(7, false)
    setWeaponSlotDisabled(8, false)
    tempTeam = nil
    tempWeps = nil
end
addEvent("StopDuelClientside", true)
addEventHandler("StopDuelClientside", root, stopDuelClientside)

--[[
Sea map


]]

--[[

vally = -1110.67, -992.73, 129.21

createObject(3933,-1094.5800000,-970.3900000,134.3800000,0.0000000,0.0000000,3.1300000) --
createObject(3933,-1135.7400000,-1006.3900000,134.3800000,0.0000000,0.0000000,3.1300000) --
createObject(3933,-1169.9900000,-980.4800000,134.3800000,0.0000000,0.0000000,3.1300000) --
createObject(3499,-1097.8900000,-987.2500000,125.1200000,0.0000000,0.0000000,0.0000000) --
createObject(3499,-1095.0900000,-987.0600000,125.1200000,0.0000000,0.0000000,0.0000000) --
createObject(3499,-1098.2000000,-996.4500000,125.1200000,0.0000000,0.0000000,0.0000000) --
createObject(3499,-1095.5700000,-996.4700000,125.1200000,0.0000000,0.0000000,0.0000000) --
createObject(3498,-1109.7100000,-971.1500000,125.8800000,0.0000000,0.0000000,0.0000000) --
createObject(3498,-1106.8500000,-970.9100000,125.8800000,0.0000000,0.0000000,0.0000000) --
createObject(3498,-1109.4700000,-974.1700000,125.8800000,0.0000000,0.0000000,0.0000000) --
createObject(3498,-1115.8600000,-1005.7200000,125.8800000,0.0000000,0.0000000,0.0000000) --
createObject(3498,-1106.5600000,-974.0700000,125.8800000,0.0000000,0.0000000,0.0000000) --
createObject(3498,-1165.2200000,-973.4600000,125.8800000,0.0000000,0.0000000,0.0000000) --
createObject(3498,-1118.2800000,-984.7100000,125.8800000,0.0000000,0.0000000,0.0000000) --
createObject(3498,-1118.4700000,-981.3800000,125.8800000,0.0000000,0.0000000,0.0000000) --
createObject(3498,-1143.1300000,-981.9200000,125.8800000,0.0000000,0.0000000,0.0000000) --
createObject(3498,-1116.2700000,-999.2800000,125.8800000,0.0000000,0.0000000,0.0000000) --
createObject(3498,-1113.0300000,-1005.6400000,125.8800000,0.0000000,0.0000000,0.0000000) --
createObject(3498,-1113.2000000,-999.0200000,125.8800000,0.0000000,0.0000000,0.0000000) --
createObject(2914,-1098.2100000,-996.3900000,130.5400000,0.0000000,0.0000000,258.0800000) --
createObject(2914,-1097.8700000,-987.2000000,130.5400000,0.0000000,0.0000000,113.9400000) --
createObject(3498,-1162.2100000,-973.3500000,125.8800000,0.0000000,0.0000000,0.0000000) --
createObject(3498,-1164.9100000,-979.9100000,125.8800000,0.0000000,0.0000000,0.0000000) --
createObject(3498,-1155.6900000,-994.0500000,125.8800000,0.0000000,0.0000000,0.0000000) --
createObject(3498,-1166.6800000,-1007.5100000,125.8800000,0.0000000,0.0000000,0.0000000) --
createObject(3498,-1167.8600000,-998.0700000,125.8800000,0.0000000,0.0000000,0.0000000) --
createObject(3498,-1164.9000000,-997.7400000,125.8800000,0.0000000,0.0000000,0.0000000) --
createObject(3498,-1161.9400000,-979.7500000,125.8800000,0.0000000,0.0000000,0.0000000) --
createObject(3498,-1155.8900000,-987.5300000,125.8800000,0.0000000,0.0000000,0.0000000) --
createObject(3498,-1152.6100000,-987.3600000,125.8800000,0.0000000,0.0000000,0.0000000) --
createObject(3498,-1152.4100000,-993.9700000,125.8800000,0.0000000,0.0000000,0.0000000) --
createObject(3498,-1121.2900000,-984.8100000,125.8800000,0.0000000,0.0000000,0.0000000) --
createObject(3498,-1146.2900000,-982.1700000,125.8800000,0.0000000,0.0000000,0.0000000) --
createObject(3498,-1142.9600000,-985.2900000,125.8800000,0.0000000,0.0000000,0.0000000) --
createObject(3498,-1146.0900000,-985.3700000,125.8800000,0.0000000,0.0000000,0.0000000) --
createObject(16644,-1118.0500000,-968.7200000,128.6000000,0.0000000,18.0000000,3.0000000) --
createObject(16644,-1085.7900000,-993.6000000,130.9400000,0.0000000,0.0000000,93.4500000) --
createObject(3498,-1121.4000000,-981.7000000,125.8800000,0.0000000,0.0000000,0.0000000) --
createObject(16644,-1176.1200000,-1011.8400000,128.6300000,0.0000000,18.0000000,273.0800000) --
createObject(16644,-1135.0500000,-969.6600000,130.9400000,0.0000000,0.0000000,3.3800000) --
createObject(16644,-1086.0100000,-974.1600000,127.8800000,0.0000000,-18.0000000,272.4100000) --
createObject(16644,-1177.9900000,-977.8900000,127.8800000,0.0000000,-18.0000000,273.0800000) --
createObject(17030,-1109.2900000,-966.1400000,107.1200000,0.0000000,0.0000000,327.2100000) --
createObject(17030,-1125.1000000,-989.1400000,108.0400000,0.0000000,0.0000000,22.9800000) --
createObject(17030,-1171.4400000,-989.8400000,107.5400000,0.0000000,0.0000000,26.1200000) --
createObject(17030,-1141.0600000,-955.2000000,107.4400000,0.0000000,0.0000000,318.4500000) --
createObject(17030,-1140.5100000,-972.0200000,107.4400000,0.0000000,0.0000000,336.1500000) --
createObject(17030,-1099.9100000,-979.5900000,108.0600000,0.0000000,0.0000000,111.7300000) --
createObject(17030,-1144.0300000,-1022.7700000,107.3300000,0.0000000,0.0000000,111.7300000) --
createObject(17030,-1123.0000000,-1033.2100000,107.9700000,0.0000000,0.0000000,111.7300000) --
createObject(16644,-1177.6300000,-997.2500000,130.9400000,0.0000000,0.0000000,93.4500000) --
createObject(16644,-1152.0100000,-970.5300000,127.8800000,0.0000000,-18.0000000,3.0000000) --
createObject(17030,-1099.7400000,-1024.8600000,109.8200000,0.0000000,0.0000000,111.7300000) --
createObject(3498,-1163.7600000,-1007.0700000,125.8800000,0.0000000,0.0000000,0.0000000) --
createObject(3498,-1140.0300000,-1012.5600000,125.8800000,0.0000000,0.0000000,0.0000000) --
createObject(3498,-1139.9500000,-1015.7000000,125.8800000,0.0000000,0.0000000,0.0000000) --
createObject(3498,-1130.3500000,-1015.2800000,125.8800000,0.0000000,0.0000000,0.0000000) --
createObject(3498,-1130.5300000,-1012.2000000,125.8800000,0.0000000,0.0000000,0.0000000) --
createObject(17030,-1175.1000000,-1031.9700000,107.9700000,0.0000000,0.0000000,111.7300000) --
createObject(17030,-1121.7200000,-956.1600000,107.1200000,0.0000000,0.0000000,327.2100000) --
]]


--[[
--outlaws = 3206.23, 1689.21, 16.49

createObject(12814,3219.6440400,1697.5240500,14.0278900,0.0000000,0.0000000,0.0000000) --
createObject(16121,3236.9052700,1702.0981400,13.0941500,0.0000000,0.0000000,-16.2000000) --
createObject(12814,3189.6848100,1697.4309100,14.0278900,0.0000000,0.0000000,0.0600000) --
createObject(3887,3186.6357400,1729.7397500,22.3989800,0.0000000,0.0000000,0.0000000) --
createObject(12814,3189.6477100,1747.3878200,14.0278900,0.0000000,0.0000000,0.0600000) --
createObject(12814,3219.5861800,1747.4281000,14.0278900,0.0000000,0.0000000,0.0000000) --
createObject(16121,3236.2412100,1754.4644800,13.0941500,0.0000000,0.0000000,-16.2000000) --
createObject(3279,3222.1462400,1679.2371800,14.0043600,0.0000000,0.0000000,92.3399900) --
createObject(987,3230.9348100,1673.1292700,14.0138000,0.0000000,0.0000000,180.0000000) --
createObject(987,3218.7990700,1673.1292700,14.0138000,0.0000000,0.0000000,180.0000000) --
createObject(987,3206.7690400,1673.1292700,14.0138000,0.0000000,0.0000000,180.0000000) --
createObject(987,3194.7177700,1673.1292700,14.0138000,0.0000000,0.0000000,180.0000000) --
createObject(987,3186.7617200,1673.1292700,14.0138000,0.0000000,0.0000000,180.0000000) --
createObject(987,3175.4670400,1673.2285200,14.0138000,0.0000000,0.0000000,90.0000000) --
createObject(987,3175.4670400,1685.3320300,14.0138000,0.0000000,0.0000000,90.0000000) --
createObject(987,3175.4670400,1697.3333700,14.0138000,0.0000000,0.0000000,90.0000000) --
createObject(987,3175.4670400,1709.3193400,14.0138000,0.0000000,0.0000000,90.0000000) --
createObject(987,3175.4670400,1721.3696300,14.0138000,0.0000000,0.0000000,90.0000000) --
createObject(987,3175.4670400,1733.4520300,14.0138000,0.0000000,0.0000000,90.0000000) --
createObject(987,3175.4670400,1745.4729000,14.0138000,0.0000000,0.0000000,90.0000000) --
createObject(987,3175.4670400,1757.4930400,14.0138000,0.0000000,0.0000000,90.0000000) --
createObject(6865,3195.9899900,1697.4462900,18.4328300,0.0000000,0.0000000,225.7799700) --
createObject(3528,3207.9372600,1674.9777800,17.5128300,0.0000000,0.0000000,89.8800000) --
createObject(14637,3207.2978500,1673.7312000,16.8253400,0.0000000,0.0000000,89.8799900) --
createObject(16641,3215.7612300,1712.2606200,15.8850300,0.0000000,0.0000000,135.6000200) --
createObject(2977,3206.2023900,1710.9129600,14.0317300,0.0000000,0.0000000,0.0000000) --
createObject(2057,3207.7448700,1714.2154500,14.1871500,0.0000000,0.0000000,0.0000000) --
createObject(3524,3206.2561000,1710.7948000,18.0333700,0.0000000,0.0000000,96.7800200) --
createObject(3524,3212.5485800,1704.3418000,17.8747900,0.0000000,0.0000000,178.0799700) --
createObject(2977,3212.6162100,1704.7366900,14.0317300,0.0000000,0.0000000,0.0000000) --
createObject(2977,3213.8994100,1703.6339100,14.0317300,0.0000000,0.0000000,0.0000000) --
createObject(3524,3213.9685100,1703.7713600,15.3765700,0.0000000,0.0000000,185.6400500) --
createObject(3524,3204.8552200,1712.4491000,15.3765700,0.0000000,0.0000000,90.3600300) --
createObject(2977,3204.7011700,1712.3398400,14.0317300,0.0000000,0.0000000,0.0000000) --
createObject(3884,3192.7038600,1704.6528300,20.0511500,0.0000000,0.0000000,-92.6400100) --
createObject(3884,3192.4675300,1709.8206800,20.0511500,0.0000000,0.0000000,-92.6400100) --
createObject(3884,3185.9741200,1703.9581300,20.0511500,0.0000000,0.0000000,-178.7400100) --
createObject(3884,3180.2871100,1703.9670400,20.0511500,0.0000000,0.0000000,-178.7400100) --
createObject(3884,3179.5815400,1708.7922400,20.0511500,0.0000000,0.0000000,-270.0600000) --
createObject(3092,3212.6032700,1704.7402300,18.0233300,0.0000000,0.0000000,-1.1400000) --
createObject(3092,3206.4751000,1710.9431200,18.0233300,0.0000000,0.0000000,-85.3200100) --
createObject(2905,3213.5146500,1709.5137900,14.1239200,0.0000000,0.0000000,0.0000000) --
createObject(2906,3214.1899400,1709.0896000,14.1358400,0.0000000,0.0000000,-49.7400000) --
createObject(2907,3213.4211400,1708.7778300,14.1063400,0.0000000,0.0000000,0.0000000) --
createObject(2908,3213.4201700,1708.2430400,14.0752400,0.0000000,0.0000000,11.2200000) --
createObject(2905,3213.3449700,1709.5992400,14.1239200,0.0000000,0.0000000,0.0000000) --
createObject(2906,3212.5817900,1708.8411900,14.1358400,0.0000000,0.0000000,71.0400300) --
createObject(2907,3209.3808600,1715.6503900,14.1063400,0.0000000,0.0000000,-110.0999900) --
createObject(2908,3208.5739700,1715.2401100,14.0752400,0.0000000,0.0000000,-82.8000000) --
createObject(2905,3210.4799800,1716.3848900,14.1239200,0.0000000,0.0000000,-19.7400000) --
createObject(2906,3204.6420900,1718.2120400,14.1358400,0.0000000,0.0000000,176.6400100) --
createObject(2905,3210.6433100,1715.0235600,14.1239200,0.0000000,0.0000000,-74.1600000) --
createObject(2906,3209.6914100,1716.0210000,14.1358400,0.0000000,0.0000000,71.0400300) --
createObject(841,3017.6897000,1694.5866700,-0.1236600,0.0000000,0.0000000,0.0000000) --
createObject(841,3214.7292500,1704.9661900,14.0275600,0.0000000,0.0000000,0.0000000) --
createObject(841,3214.0908200,1705.4820600,14.0275600,0.0000000,0.0000000,0.0000000) --
createObject(841,3213.5263700,1706.1668700,14.0275600,0.0000000,0.0000000,0.0000000) --
createObject(841,3207.7280300,1711.5105000,14.0275600,0.0000000,0.0000000,0.0000000) --
createObject(841,3206.9599600,1712.1584500,14.0275600,0.0000000,0.0000000,0.0000000) --
createObject(841,3207.7280300,1711.5105000,14.0275600,0.0000000,0.0000000,0.0000000) --
createObject(841,3206.2370600,1712.9613000,14.0275600,0.0000000,0.0000000,0.0000000) --
createObject(840,3224.7194800,1693.3792700,15.5184000,0.0000000,0.0000000,-15.2400000) --
createObject(843,3224.9340800,1684.6329300,14.7114600,0.0000000,0.0000000,0.0000000) --
createObject(840,3226.3422900,1700.8376500,15.5841300,0.0000000,0.0000000,-1.6800000) --
createObject(13649,3182.1674800,1712.7186300,20.7397000,0.0000000,0.0000000,0.0000000) --
createObject(13649,3182.0668900,1714.6674800,21.5072600,0.0000000,0.0000000,0.0000000) --
createObject(13649,3181.9470200,1716.3158000,22.2718200,0.0000000,0.0000000,0.0000000) --
createObject(844,3204.1342800,1689.2924800,15.2641200,0.0000000,0.0000000,210.3599500) --
createObject(844,3220.3608400,1698.7932100,15.2641200,0.0000000,0.0000000,107.3399800) --
createObject(831,3210.4699700,1688.6374500,15.1133400,0.0000000,0.0000000,0.0000000) --

createObject(821,3218.5012200,1696.3508300,13.4844400,0.0000000,0.0000000,0.0000000) --

createObject(833,3214.3615700,1684.3529100,14.8080000,0.0000000,0.0000000,-91.8600000) --
createObject(833,3211.0124500,1684.0087900,14.8080000,0.0000000,0.0000000,-91.8600000) --
createObject(833,3207.7568400,1683.7514600,14.8080000,0.0000000,0.0000000,-91.8600000) --

createObject(2977,3183.7753900,1681.6301300,17.8887000,0.0000000,0.0000000,0.0000000) --
createObject(2977,3183.7067900,1679.1602800,17.8887400,0.0000000,0.0000000,0.0000000) --
createObject(2977,3183.8051800,1681.6484400,18.8676200,0.0000000,0.0000000,0.0000000) --
createObject(2977,3183.6987300,1679.1746800,18.8675700,0.0000000,0.0000000,0.0600000) --
createObject(2977,3183.6921400,1679.1590600,19.8835600,0.0000000,0.0000000,0.0600000) --
createObject(2977,3183.8115200,1681.6289100,19.8836000,0.0000000,0.0000000,0.0600000) --
createObject(2977,3183.8112800,1680.6669900,19.8836000,0.0000000,0.0000000,0.0600000) --
createObject(2977,3183.8447300,1679.9876700,19.8836000,0.0000000,0.0000000,0.0600000) --
createObject(2977,3183.8461900,1678.1373300,19.8836000,0.0000000,0.0000000,0.0600000) --
createObject(2977,3183.7468300,1678.1480700,17.9084400,0.0000000,0.0000000,0.0000000) --
createObject(2977,3183.8139600,1677.2027600,17.9454900,0.0000000,0.0000000,0.0000000) --
createObject(2977,3183.8942900,1677.2899200,19.8836000,0.0000000,0.0000000,0.0600000) --
createObject(2977,3183.8244600,1676.2410900,17.9333000,0.0000000,0.0000000,0.0000000) --
createObject(3866,3192.6174300,1686.1765100,21.8728500,0.0000000,0.0000000,0.0000000) --
createObject(2977,3183.9350600,1676.2619600,19.8836100,0.0000000,0.0000000,0.0600000) --
createObject(2977,3179.6159700,1681.6563700,17.8887000,0.0000000,0.0000000,0.0000000) --
createObject(2977,3179.6335400,1680.7004400,17.8687300,0.0000000,0.0000000,0.0000000) --
createObject(2977,3179.6420900,1679.6602800,17.8887000,0.0000000,0.0000000,0.0000000) --
createObject(2977,3179.8630400,1677.3126200,17.8887000,0.0000000,0.0000000,0.0000000) --
createObject(2977,3179.8466800,1676.3632800,17.8887000,0.0000000,0.0000000,0.0000000) --
createObject(6865,3179.9907200,1688.3830600,18.4328000,0.0000000,0.0000000,860.5199600) --
createObject(2977,3215.6210900,1759.3122600,14.0248900,0.0000000,0.0000000,0.0000000) --
createObject(2977,3214.8178700,1759.2905300,14.0260200,0.0000000,0.0000000,0.0000000) --
createObject(2977,3213.9035600,1759.2648900,14.0267300,0.0000000,0.0000000,0.0000000) --
createObject(2977,3213.0019500,1759.2771000,14.0267100,0.0000000,0.0000000,0.0000000) --
createObject(2976,3214.9287100,1759.3418000,15.1861800,0.0000000,0.0000000,0.0000000) --
createObject(2976,3213.8518100,1759.2856400,15.1868400,0.0000000,0.0000000,0.0000000) --
createObject(2977,3211.7609900,1756.3929400,14.0267100,0.0000000,0.0000000,0.0000000) --
createObject(2977,3213.0019500,1759.2771000,14.0267100,0.0000000,0.0000000,0.0000000) --
createObject(2977,3214.6313500,1754.6096200,14.0267100,0.0000000,0.0000000,0.0000000) --
createObject(2977,3217.0158700,1754.9852300,14.0267100,0.0000000,0.0000000,0.0000000) --
createObject(2977,3218.5966800,1756.6635700,14.0267100,0.0000000,0.0000000,0.0000000) --
createObject(2977,3221.7773400,1750.4420200,14.0267100,0.0000000,0.0000000,0.0000000) --
createObject(2977,3218.3337400,1750.7265600,14.0267100,0.0000000,0.0000000,0.0000000) --
createObject(2977,3215.7070300,1746.0737300,14.0267100,0.0000000,0.0000000,0.0000000) --
createObject(2977,3210.9885300,1747.3571800,14.0205800,0.0000000,0.0000000,0.0000000) --
createObject(2977,3222.9121100,1756.2268100,14.0267100,0.0000000,0.0000000,0.0000000) --
createObject(2977,3217.1879900,1763.1821300,14.0267100,0.0000000,0.0000000,0.0000000) --
createObject(2977,3219.9802200,1760.8892800,14.0267100,0.0000000,0.0000000,0.0000000) --
createObject(2977,3212.8193400,1751.1665000,14.0267100,0.0000000,0.0000000,0.0000000) --
createObject(2977,3208.3002900,1757.6470900,14.0267100,0.0000000,0.0000000,0.0000000) --
createObject(2977,3226.6650400,1760.8068800,14.0220700,0.0000000,0.0000000,0.0000000) --
createObject(2977,3223.5134300,1762.4571500,14.0267100,0.0000000,0.0000000,0.0000000) --
createObject(2977,3227.1901900,1750.6092500,14.0267100,0.0000000,0.0000000,0.0000000) --
createObject(3279,3185.8168900,1763.6558800,14.0043600,0.0000000,0.0000000,-1.8000100) --
createObject(2977,3219.5639600,1765.2883300,14.0267100,0.0000000,0.0000000,3.2400000) --
createObject(2977,3213.8459500,1765.8117700,14.0267100,0.0000000,0.0000000,3.2400000) --
createObject(2977,3210.1362300,1761.9990200,14.0267100,0.0000000,0.0000000,3.2400000) --
createObject(2977,3208.0295400,1767.9895000,14.0267100,0.0000000,0.0000000,3.2400000) --
createObject(2977,3208.0295400,1767.9895000,14.0267100,0.0000000,0.0000000,3.2400000) --
createObject(2977,3217.0158700,1754.9852300,15.0472700,0.0000000,0.0000000,0.0000000) --
createObject(2977,3218.5966800,1756.6635700,14.9397700,0.0000000,0.0000000,0.0000000) --
createObject(2977,3214.6313500,1754.6096200,15.0106700,0.0000000,0.0000000,0.0000000) --
createObject(2977,3211.7609900,1756.3929400,15.0360600,0.0000000,0.0000000,0.0000000) --
createObject(2977,3212.8193400,1751.1665000,15.0416300,0.0000000,0.0000000,0.0000000) --
createObject(2977,3210.9885300,1747.3571800,15.0142200,0.0000000,0.0000000,0.0000000) --
createObject(2977,3215.7070300,1746.0737300,14.9939500,0.0000000,0.0000000,0.0000000) --
createObject(2977,3218.3337400,1750.7265600,15.0422000,0.0000000,0.0000000,0.0000000) --
createObject(2977,3221.7773400,1750.4420200,15.0100900,0.0000000,0.0000000,0.0000000) --
createObject(2977,3222.9121100,1756.2268100,15.0134600,0.0000000,0.0000000,0.0000000) --
createObject(2977,3227.1901900,1750.6092500,15.0147200,0.0000000,0.0000000,0.0000000) --
createObject(2977,3226.6650400,1760.8068800,15.0248700,0.0000000,0.0000000,0.0000000) --
createObject(2977,3223.5134300,1762.4571500,15.0216000,0.0000000,0.0000000,0.0000000) --
createObject(2977,3219.5639600,1765.2883300,15.0183900,0.0000000,0.0000000,3.2400000) --
createObject(2977,3219.9802200,1760.8892800,15.0121600,0.0000000,0.0000000,0.0000000) --
createObject(2977,3217.1879900,1763.1821300,14.9961800,0.0000000,0.0000000,0.0000000) --
createObject(2977,3213.8459500,1765.8117700,15.0441700,0.0000000,0.0000000,3.2400000) --
createObject(2977,3210.1362300,1761.9990200,14.9830800,0.0000000,0.0000000,3.2400000) --
createObject(2977,3208.3002900,1757.6470900,15.0592900,0.0000000,0.0000000,0.0000000) --
createObject(2977,3212.8950200,1764.7204600,14.0267100,0.0000000,0.0000000,3.2400000) --
createObject(2977,3212.8950200,1764.7204600,15.0160300,0.0000000,0.0000000,3.2400000) --
createObject(2977,3211.9753400,1764.6713900,14.0267100,0.0000000,0.0000000,3.2400000) --
createObject(2977,3210.8935500,1764.6737100,14.0267100,0.0000000,0.0000000,3.2400000) --
createObject(2977,3210.9985400,1767.7879600,14.0267100,0.0000000,0.0000000,3.2400000) --
createObject(2977,3212.1074200,1767.8195800,14.0267100,0.0000000,0.0000000,3.2400000) --
createObject(2977,3213.1628400,1768.5131800,14.0267100,0.0000000,0.0000000,3.2400000) --
createObject(2977,3223.4804700,1767.8803700,14.0277700,0.0000000,0.0000000,3.2400000) --
createObject(2977,3224.5830100,1767.9022200,14.0267100,0.0000000,0.0000000,3.2400000) --
createObject(2977,3225.6447800,1767.9061300,14.0267100,0.0000000,0.0000000,3.2400000) --
createObject(2977,3226.7268100,1767.9086900,14.0267100,0.0000000,0.0000000,3.2400000) --
createObject(2977,3227.7502400,1767.9339600,14.0267100,0.0000000,0.0000000,3.2400000) --
createObject(2977,3224.5830100,1767.9022200,14.9367000,0.0000000,0.0000000,3.2400000) --
createObject(2977,3223.4804700,1767.8803700,14.8785000,0.0000000,0.0000000,3.2400000) --
createObject(2977,3226.7268100,1767.9086900,15.0266300,0.0000000,0.0000000,3.2400000) --
createObject(2977,3223.4021000,1770.5683600,14.0277700,0.0000000,0.0000000,3.2400000) --
createObject(2977,3225.9689900,1770.6329300,14.0277700,0.0000000,0.0000000,3.2400000) --
createObject(2977,3220.8696300,1768.5196500,14.0277700,0.0000000,0.0000000,3.2400000) --
createObject(2977,3217.5734900,1770.5770300,14.0277700,0.0000000,0.0000000,3.2400000) --
createObject(2977,3218.6994600,1770.6578400,14.0277700,0.0000000,0.0000000,3.2400000) --
createObject(2977,3218.3342300,1770.5771500,15.0393400,0.0000000,0.0000000,3.2400000) --
createObject(3524,3225.7302200,1764.5568800,16.5869200,0.0000000,0.0000000,-122.1600000) --
createObject(3524,3208.9345700,1750.5404100,16.5869200,0.0000000,0.0000000,-216.8999900) --
createObject(2977,3210.3825700,1743.8031000,14.0267100,0.0000000,0.0000000,0.0000000) --
createObject(2977,3209.2819800,1743.7833300,14.0267100,0.0000000,0.0000000,0.0000000) --
createObject(2977,3208.2299800,1743.8026100,14.0267100,0.0000000,0.0000000,0.0000000) --
createObject(2977,3208.2829600,1740.6903100,14.0267100,0.0000000,0.0000000,0.0000000) --
createObject(2977,3207.1335400,1741.5047600,14.0267100,0.0000000,0.0000000,0.0000000) --
createObject(2977,3207.1936000,1744.6575900,14.0267100,0.0000000,0.0000000,0.0000000) --
createObject(2977,3205.9619100,1743.9506800,14.0267100,0.0000000,0.0000000,0.0000000) --
createObject(2977,3206.0522500,1741.4921900,14.0267100,0.0000000,0.0000000,0.0000000) --
createObject(2977,3210.5249000,1740.6976300,14.0073900,0.0000000,0.0000000,0.0000000) --
createObject(2977,3211.5222200,1742.2907700,14.0267100,0.0000000,0.0000000,0.0000000) --
createObject(2977,3211.5222200,1742.2907700,15.0738400,0.0000000,0.0000000,0.0000000) --
createObject(2977,3210.8689000,1740.7271700,14.9928100,0.0000000,0.0000000,0.0000000) --
createObject(2977,3210.3825700,1743.8031000,15.1087400,0.0000000,0.0000000,0.0000000) --
createObject(2977,3208.8117700,1743.7935800,15.1189000,0.0000000,0.0000000,0.0000000) --
createObject(2977,3206.0522500,1741.4921900,15.1361000,0.0000000,0.0000000,0.0000000) --
createObject(2977,3205.9619100,1743.9506800,15.2466600,0.0000000,0.0000000,0.0000000) --
createObject(2977,3205.9619100,1743.9506800,15.2466600,0.0000000,0.0000000,0.0000000) --
createObject(2977,3198.3728000,1754.1136500,14.0267100,0.0000000,0.0000000,0.0000000) --
createObject(2977,3198.9960900,1756.2352300,14.0267100,0.0000000,0.0000000,0.0000000) --
createObject(2977,3196.8784200,1757.9572800,14.0267100,0.0000000,0.0000000,0.0000000) --
createObject(2977,3194.3613300,1757.9022200,14.0267100,0.0000000,0.0000000,0.0000000) --
createObject(2977,3192.4213900,1756.1057100,14.0267100,0.0000000,0.0000000,0.0000000) --
createObject(2977,3193.6005900,1753.9526400,14.0267100,0.0000000,0.0000000,0.0000000) --
createObject(2977,3192.5022000,1755.0321000,14.0267100,0.0000000,0.0000000,0.0000000) --
createObject(2977,3194.7392600,1753.0011000,14.0267100,0.0000000,0.0000000,0.0000000) --
createObject(2977,3195.7932100,1752.0764200,14.0267100,0.0000000,0.0000000,0.0000000) --
createObject(2977,3196.8166500,1751.2078900,14.0267100,0.0000000,0.0000000,0.0000000) --
createObject(2977,3196.8784200,1757.9572800,15.0361600,0.0000000,0.0000000,0.0000000) --
createObject(2977,3194.3613300,1757.9022200,14.9400400,0.0000000,0.0000000,0.0000000) --
createObject(2977,3196.8166500,1751.2078900,15.0132000,0.0000000,0.0000000,0.0000000) --
createObject(2977,3195.7932100,1752.0764200,15.0889900,0.0000000,0.0000000,0.0000000) --
createObject(2977,3194.7392600,1753.0011000,15.0853300,0.0000000,0.0000000,0.0000000) --
createObject(2977,3193.6005900,1753.9526400,15.0616600,0.0000000,0.0000000,0.0000000) --
createObject(2977,3198.3728000,1754.1136500,15.0257900,0.0000000,0.0000000,0.0000000) --
createObject(2977,3198.9960900,1756.2352300,15.0257900,0.0000000,0.0000000,0.0000000) --
createObject(987,3175.5131800,1760.3162800,14.0138000,0.0000000,0.0000000,90.0000000) --
createObject(987,3175.8266600,1771.6136500,14.0138000,0.0000000,0.0000000,0.0000000) --
createObject(987,3187.7519500,1771.6689500,14.0138000,0.0000000,0.0000000,0.0000000) --
createObject(987,3199.7089800,1771.7030000,14.0138000,0.0000000,0.0000000,0.0000000) --
createObject(987,3211.5166000,1771.6417200,14.0138000,0.0000000,0.0000000,0.0000000) --
createObject(987,3221.4177200,1771.6770000,14.0138000,0.0000000,0.0000000,0.0000000) --
createObject(2977,3223.9309100,1756.1377000,13.9317900,0.0000000,0.0000000,0.0000000) --
createObject(2977,3227.1118200,1756.2205800,13.9317900,0.0000000,0.0000000,0.0000000) --
createObject(2977,3227.1032700,1755.2827100,13.9317900,0.0000000,0.0000000,0.0000000) --
createObject(2977,3226.3779300,1750.6534400,13.9317900,0.0000000,0.0000000,0.0000000) --
createObject(2977,3226.3835400,1751.7755100,13.9317900,0.0000000,0.0000000,0.0000000) --
createObject(2977,3225.5085400,1751.7917500,13.9317900,0.0000000,0.0000000,0.0000000) --
createObject(2977,3224.6020500,1752.7537800,13.9317900,0.0000000,0.0000000,0.0000000) --
createObject(2977,3224.8576700,1758.6833500,13.9317900,0.0000000,0.0000000,0.0000000) --
createObject(2977,3223.8979500,1759.7786900,13.9317900,0.0000000,0.0000000,0.0000000) --
createObject(2977,3220.3654800,1753.3262900,13.9317900,0.0000000,0.0000000,0.0000000) --
createObject(2977,3221.7312000,1758.6433100,13.9317900,0.0000000,0.0000000,0.0000000) --
createObject(2977,3219.9543500,1762.1149900,13.9317900,0.0000000,0.0000000,0.0000000) --
createObject(2977,3216.1110800,1764.2352300,13.9317900,0.0000000,0.0000000,0.0000000) --
createObject(2977,3213.0739700,1763.6517300,13.9317900,0.0000000,0.0000000,0.0000000) --
createObject(2977,3216.1840800,1761.7867400,13.9317900,0.0000000,0.0000000,0.0000000) --
createObject(2977,3210.2331500,1760.9338400,13.9317900,0.0000000,0.0000000,0.0000000) --
createObject(2977,3213.2441400,1761.4476300,13.9317900,0.0000000,0.0000000,0.0000000) --
createObject(2977,3227.3950200,1739.3325200,14.0205800,0.0000000,0.0000000,0.0000000) --
createObject(2977,3226.3764600,1739.3664600,14.0205800,0.0000000,0.0000000,0.0000000) --
createObject(2977,3225.4133300,1738.2153300,14.0205800,0.0000000,0.0000000,0.0000000) --
createObject(2977,3223.3183600,1739.3082300,14.0205800,0.0000000,0.0000000,0.0000000) --
createObject(2977,3225.5537100,1737.1060800,14.0205800,0.0000000,0.0000000,0.0000000) --
createObject(2977,3225.6186500,1736.0609100,14.0205800,0.0000000,0.0000000,0.0000000) --
createObject(2977,3223.4030800,1740.3167700,14.0205800,0.0000000,0.0000000,0.0000000) --
createObject(2977,3228.4138200,1739.2972400,14.0205800,0.0000000,0.0000000,0.0000000) --
createObject(2977,3228.4138200,1739.2972400,15.0777000,0.0000000,0.0000000,0.0000000) --
createObject(2977,3227.3950200,1739.3325200,14.9758100,0.0000000,0.0000000,0.0000000) --
createObject(2977,3226.3764600,1739.3664600,14.8962000,0.0000000,0.0000000,0.0000000) --
createObject(2977,3225.4133300,1738.2153300,15.0267500,0.0000000,0.0000000,0.0000000) --
createObject(2977,3225.2541500,1737.1634500,15.1536600,0.0000000,0.0000000,0.0000000) --
createObject(2977,3225.4316400,1736.1634500,15.1145800,0.0000000,0.0000000,0.0000000) --
createObject(2977,3223.3437500,1739.3757300,15.0364300,0.0000000,0.0000000,0.0000000) --
createObject(2977,3222.3916000,1736.6275600,14.0205800,0.0000000,0.0000000,0.0000000) --
createObject(2977,3226.4279800,1734.9328600,14.0205800,0.0000000,0.0000000,0.0000000) --
createObject(2977,3227.5539600,1733.9099100,14.0205800,0.0000000,0.0000000,0.0000000) --
createObject(2977,3222.7460900,1728.9669200,14.0401800,0.0000000,0.0000000,0.0000000) --
createObject(2977,3222.7136200,1730.0144000,14.0205800,0.0000000,0.0000000,0.0000000) --
createObject(2977,3222.7673300,1730.9832800,14.0205800,0.0000000,0.0000000,0.0000000) --
createObject(2977,3222.7854000,1731.9796100,14.0205800,0.0000000,0.0000000,0.0000000) --
createObject(2977,3222.7568400,1733.0466300,14.0205800,0.0000000,0.0000000,0.0000000) --
createObject(2977,3222.7568400,1733.0466300,14.9614100,0.0000000,0.0000000,0.0000000) --
createObject(2977,3222.7673300,1730.9832800,15.0398100,0.0000000,0.0000000,0.0000000) --
createObject(2977,3222.7460900,1728.9669200,14.9614100,0.0000000,0.0000000,0.0000000) --
createObject(2977,3220.6330600,1732.9588600,14.0205800,0.0000000,0.0000000,0.0000000) --
createObject(2977,3221.2731900,1736.5698200,14.0205800,0.0000000,0.0000000,0.0000000) --
createObject(2977,3222.3916000,1736.6275600,15.0809800,0.0000000,0.0000000,0.0000000) --
createObject(5132,3220.1425800,1736.0603000,15.9956800,0.0000000,0.0000000,0.0000000) --
createObject(2977,3221.2731900,1736.5698200,15.1101200,0.0000000,0.0000000,0.0000000) --
createObject(833,3193.8615700,1684.9157700,14.8080000,0.0000000,0.0000000,-91.8600000) --
createObject(831,3196.2209500,1680.5837400,15.1133400,0.0000000,0.0000000,0.0000000) --
createObject(833,3198.9333500,1717.0799600,14.3108400,0.0000000,142.0000000,1.0000000) --
createObject(833,3198.8002900,1720.5650600,14.3108400,0.0000000,142.0000000,1.0000000) --
createObject(833,3198.5197800,1724.1152300,14.3108400,0.0000000,142.0000000,1.0000000) --
createObject(2907,3202.6938500,1717.9451900,14.1063400,0.0000000,0.0000000,-110.0999900) --
createObject(2905,3203.6425800,1719.0052500,14.1239200,0.0000000,0.0000000,-74.1600000) --
createObject(2908,3201.8042000,1718.6038800,14.0752400,0.0000000,0.0000000,-82.8000000) --
createObject(2908,3202.1018100,1724.2353500,14.0752400,0.0000000,0.0000000,-82.8000000) --
createObject(2906,3209.3132300,1714.6275600,14.1358400,0.0000000,0.0000000,176.6400100) --
createObject(2907,3202.9753400,1723.4777800,14.1063400,0.0000000,0.0000000,-110.0999900) --
createObject(2906,3203.0095200,1716.8000500,14.1358400,0.0000000,0.0000000,176.6400100) --
createObject(2905,3206.8552200,1719.5467500,14.1239200,0.0000000,0.0000000,-74.1600000) --
createObject(2905,3203.7507300,1721.2700200,14.1239200,0.0000000,0.0000000,-74.1600000) --
createObject(2905,3204.2316900,1726.0278300,14.1239200,0.0000000,0.0000000,-74.1600000) --
createObject(2905,3201.5876500,1725.1728500,14.1239200,0.0000000,0.0000000,-74.1600000) --
createObject(2906,3205.8855000,1725.2349900,14.1358400,0.0000000,0.0000000,176.6400100) --
createObject(2906,3203.0095200,1716.8000500,14.1358400,0.0000000,0.0000000,176.6400100) --
createObject(2906,3206.7685500,1721.9296900,14.1358400,0.0000000,0.0000000,176.6400100) --
createObject(16121,3213.2138700,1650.4343300,13.0941500,0.0000000,0.0000000,75.6000100) --
createObject(16121,3187.7937000,1649.7340100,13.0941500,0.0000000,0.0000000,75.6000100) --
createObject(16121,3152.9541000,1675.4185800,13.0941500,0.0000000,0.0000000,-7.9199800) --
createObject(16121,3166.6530800,1745.2841800,13.0941500,0.0000000,0.0000000,162.1199800) --
createObject(16121,3212.3737800,1779.8544900,13.0941500,0.0000000,0.0000000,72.4799900) --
createObject(16121,3180.8676800,1779.8780500,13.0941500,0.0000000,0.0000000,72.4799900) --
createObject(16121,3167.8579100,1708.9444600,13.0941500,0.0000000,0.0000000,162.1199800) --


]]
