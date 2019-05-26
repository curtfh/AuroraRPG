addEvent("onColorPickerOk", true)
local screenW, screenH = guiGetScreenSize()
local sX = screenW/1366
local sY = screenH/768
local viewingAchievement = false
local nFont = guiCreateFont( "font.ttf", 12 )
local nFont2 = guiCreateFont( "font.ttf", 8 )
local expInformation = {
	["Criminal"] = {
		[1] = {"Kill someone in turf",5}, --- added
		[2] = {"Turf taken",1}, --- added
		[3] = {"Cop killer in CnR event",20}, -- added
		[4] = {"Taken RT",2}, --- added
		[5] = {"Destroyed AT",15}, -- added
		[6] = {"Success CnR event",20}, --- added
		[7] = {"Store robbed",5}, -- added
		[8] = {"Success MR",20},
		[9] = {"Success Drug truck escort",20}, -- Added
		[10] = {"Armor Delivery",10}, ---added
		[11] = {"Killed a cop",3}, ---added
	},
	["Law"] = {
		[1] = {"Tazer assists",5}, --- added
		[2] = {"Turf taken",1}, -- added
		[3] = {"Criminal killed in CnR event",20}, -- added
		[4] = {"Taken RT",2}, --- added
		[5] = {"Success AT",15}, -- added
		[6] = {"Success CnR event",20}, --- added
		[7] = {"Jailed a criminal",5}, ---- added
		[8] = {"x3 Criminals jailed",20}, ---- added
		[9] = {"Jailed +800 WP criminal",30}, --- added
		[10] = {"Success Hostages Rescue",10}, -- added
	},
	["Civilian"] = {
		[1] = {"Working as a Clothes Seller",7}, --- added
		[3] = {"Working as a Trash Collector",3}, -- added
		[4] = {"Working as a Trucker",7}, --- added
		[5] = {"Working as a Pilot",7}, -- added
		[6] = {"Working as a Street Cleaner",2}, --- added
		[7] = {"Working as a Mechanic",3}, ---- added
		[8] = {"Working as a Farmer",0.5}, ---- added
		[9] = {"Working as a Lumberjack",2}, --- added
		[10] = {"Working as a Rescuer Man",3}, -- added
		[11] = {"Working as a Taxi Driver",4}, -- added
		[12] = {"Working as a Miner",3}, -- added
	},
}
local currentEXP = expInformation["Law"]

function createImage()
    auImage = guiCreateStaticImage((screenW / 2) - 260, (screenH / 2) + 150, 320, 100, "msg.png", false)
	local screenW,screenH=guiGetScreenSize()
	local windowW,windowH=guiGetSize(auImage,false)
	local x,y = (screenW-windowW)/2,(screenH-windowH)/2
	guiSetPosition(auImage,x+20,y+150,false)
	guiSetVisible(auImage, false)
	guiSetProperty(auImage, "AlwaysOnTop", "true")
    auLabel1 = guiCreateLabel(10, 15, 324, 53, "Groups ~ Experience points", false, auImage)
    auLabel = guiCreateLabel(10, 55, 324, 53, "", false, auImage)
	guiLabelSetColor(auLabel1,250,135,0)
	guiSetFont(auLabel1,nFont)
	guiSetFont(auLabel,nFont2)
    guiLabelSetHorizontalAlign(auLabel1, "center", false)
	guiLabelSetHorizontalAlign(auLabel, "center", false)
end
addEventHandler("onClientResourceStart", resourceRoot, createImage)

function unlockAch(ach, desc)
	if (viewingAchievement) then setTimer(unlockAch, 8000, 1, ach, desc) return end
    guiSetText(auLabel, ach.."\n+"..desc.." to your group")
    guiBringToFront(auImage)
    guiSetVisible(auImage, true)


    viewingAchievement = true
    local function hideAchievementUnlocked()
        guiSetVisible(auImage, false)
        viewingAchievement = false
    end
    setTimer(hideAchievementUnlocked, 8000, 1)
end
addEvent( "setXPMsg", true )
addEventHandler( "setXPMsg",root, unlockAch)


function getPlayerFromAccountID(id)
	if (id) then
		for k, v in ipairs(getElementsByType("player")) do
			if (getElementData(v, "accountUserID") == id) then
				return v
			end
		end
	return false
	end
end

function getPlayerFromAccountName(theName)
	local lowered = string.lower(tostring(theName))
	for k,v in ipairs (getElementsByType ("player" )) do
		if (getElementData(v, "playerAccount")) and (string.lower(getElementData(v, "playerAccount")) == lowered) then
			return v
		end
	end
end

function getAccountNameFromID(tab, id)
	for k, v in ipairs(tab) do
		if (k == id) then
			return v
		end
	end
end

function convertNumToBool(num)
	if (num == 1) then
		return true
	else
		return false
	end
end

function convertBoolToNum(bool)
	if (bool) then
		return 1
	else
		return 0
	end
end

function RGBToHex(red, green, blue)
	if (red < 0) or (red > 255) or (green < 0) or (green > 255) or (blue < 0) or (blue > 255) then
		return nil
	end
	return string.format("%.2X%.2X%.2X", red, green, blue)
end

function isBlacklisted(p, blacklistedTable)
	for i=1,#blacklistedTable do
		if (exports.server:getPlayerAccountName(p) == blacklistedTable[i]["blacklistedAcc"]) then
			return true
		end
	return false
	end
end

function updateGUIPerms(v)
	--if (v.updateInfo) then
		guiSetEnabled(grpInfoBtn, convertNumToBool(tonumber(v.updateInfo)))
		guiMemoSetReadOnly(groupInfoMemo, not convertNumToBool(tonumber(v.updateInfo)))
	--end
	--if (v.changeColor) then
		guiSetEnabled(setTurfBtn, convertNumToBool(tonumber(v.changeColor)))
		guiSetEnabled(openPicker, convertNumToBool(tonumber(v.changeColor)))
		guiSetEnabled(rEdit, convertNumToBool(tonumber(v.changeColor)))
		guiSetEnabled(gEdit, convertNumToBool(tonumber(v.changeColor)))
		guiSetEnabled(bEdit, convertNumToBool(tonumber(v.changeColor)))
	--end
	--if (v.changeMotd) then
		guiSetEnabled(motdBtn, convertNumToBool(tonumber(v.changeMotd)))
	--end
	--if (v.kick) then
		guiSetEnabled(kickBtn, convertNumToBool(tonumber(v.kick)))
	--end
	--if (v.warn) then
		guiSetEnabled(setWarnBtn, convertNumToBool(tonumber(v.warn)))
	--end
	--if (v.pointsChange) then
		guiSetEnabled(setPtsBtn, convertNumToBool(tonumber(v.pointsChange)))
	--end
	--if (v.invitePlayers) then
		guiSetEnabled(invitePlayers, convertNumToBool(tonumber(v.invitePlayers)))
	--end
	--if (v.depositMoney) then
		guiSetEnabled(depositBtn, convertNumToBool(tonumber(v.depositMoney)))
	--end
	--if (v.withdrawMoney) then
		guiSetEnabled(withdrawBtn, convertNumToBool(tonumber(v.withdrawMoney)))
	--end
	--if (v.histChecking) then
		guiSetEnabled(histTab, convertNumToBool(tonumber(v.histChecking)))
	--end
	--if (v.changeAvs) then
		guiSetEnabled(avGrid, convertNumToBool(tonumber(v.changeAvs)))
	--end
	--if (v.buySlots) then
		guiSetEnabled(buySlots, convertNumToBool(tonumber(v.buySlots)))
	--end
	--if (v.noteAll) then
		guiSetEnabled(noteToAllBtn, convertNumToBool(tonumber(v.noteAll)))
	--end
	--if (v.blacklistPlayers) then
		guiSetEnabled(addBlacklist, convertNumToBool(tonumber(v.blacklistPlayers)))
		guiSetEnabled(removeBlacklist, convertNumToBool(tonumber(v.blacklistPlayers)))
	--end
	--if (v.expView) then
		guiSetEnabled(viewExp, convertNumToBool(tonumber(v.expView)))
	--end
	--if (v.changeGroupName) then
		guiSetEnabled(changeNameBtn, convertNumToBool(tonumber(v.changeGroupName)))
	--end
	--if (v.changeGroupType) then
		guiSetEnabled(changeTypeBtn, convertNumToBool(tonumber(v.changeGroupType)))
	--end
	--if (v.upgradeGrp) then
		guiSetEnabled(upgradeGrp, convertNumToBool(tonumber(v.upgradeGrp)))
	--end
	--if (v.deleteGroup) then
		if (convertNumToBool(tonumber(v.deleteGroup))) then
			guiSetText(leaveGrpBtn, "Delete Group")
		end
	--end
	--if (v.setRank) then
		guiSetEnabled(setRankBtn, convertNumToBool(tonumber(v.setRank)))
	--end
	if (getElementData(localPlayer, "Group Rank") ~= "Founder") then
		guiSetEnabled(manageRanksBtn, false)
		guiSetEnabled(setNewFounder, false)
	end
end

local buySlotsWnd
function initSlotsWnd(slots)
	if (isElement(buySlotsWnd)) then
		destroyElement(buySlotsWnd, false)
	else
		buySlotsWnd = guiCreateWindow(sX*((1366 - 485) / 2), sY*((768 - 112) / 2), sX*485, sY*112, "Buy Slots", false)
		guiWindowSetSizable(buySlotsWnd, false)
		guiBringToFront(buySlotsWnd)
		currentSlotsLabel = guiCreateLabel(sX*189, sY*29, sX*169, sY*17, "Current Slots: "..slots or "30", false, buySlotsWnd)
		confirmBuySlots = guiCreateButton(sX*149, sY*72, sX*190, sY*30, "Buy Slot (500K)", false, buySlotsWnd)
		guiSetProperty(confirmBuySlots, "NormalTextColour", "FF00A10B")
		closeSlots = guiCreateButton(sX*396, sY*82, sX*79, sY*20, "Close", false, buySlotsWnd) 
		addEventHandler("onClientGUIClick", root, function() if (source == closeSlots) then guiSetVisible(buySlotsWnd, false) end end )
	end
end

local changeNameWnd
function initChangeNameWnd()
	if (isElement(changeNameWnd)) then
		destroyElement(changeNameWnd)
	else
        changeNameWnd = guiCreateWindow(sX*((1366 - 481) / 2), sY*((768 - 386) / 2), sX*481, sY*386, "Change Group Name", false)
        guiWindowSetSizable(changeNameWnd, false)
		guiBringToFront(changeNameWnd)
        changeAccEdit = guiCreateEdit(sX*103, sY*58, sX*276, sY*61, "", false, changeNameWnd)
        changeLabel1 = guiCreateLabel(sX*194, sY*35, sX*94, sY*13, "Account Name", false, changeNameWnd)
        changeLabel2 = guiCreateLabel(sX*182, sY*129, sX*116, sY*15, "Current Group Name", false, changeNameWnd)
        changeCurrentName = guiCreateEdit(sX*103, sY*154, sX*276, sY*61, getElementData(localPlayer, "Group"), false, changeNameWnd)
        changeLabel3 = guiCreateLabel(sX*182, sY*225, sX*116, sY*15, "New Group Name", false, changeNameWnd)
        changeGroupEdit = guiCreateEdit(sX*103, sY*250, sX*276, sY*61, "", false, changeNameWnd)
        confirmGroupName = guiCreateButton(sX*140, sY*321, sX*200, sY*36, "Change Group Name", false, changeNameWnd)   
		closeChangeName = guiCreateButton(sX*426, sY*25, sX*35, sY*33, "X", false, changeNameWnd) 
		addEventHandler("onClientGUIClick", root, function() if (source == closeChangeName) then guiSetVisible(changeNameWnd, false) end end )
    end
end

local viewExpWnd
function initViewExpWnd()
	if (isElement(viewExpWnd)) then
		destroyElement(viewExpWnd)
	else
        viewExpWnd = guiCreateWindow(sX*((1366 - 693) / 2), sY*((768 - 448) / 2), sX*693, sY*448, "Exp Information", false)
        guiWindowSetSizable(viewExpWnd, false)
		guiBringToFront(viewExpWnd)
        expGrid = guiCreateGridList(sX*15, sY*33, sX*658, sY*364, false, viewExpWnd)
        guiGridListAddColumn(expGrid, "Requirements", 0.6)
        guiGridListAddColumn(expGrid, "Exp", 0.3)
        closeExpWnd = guiCreateButton(sX*218, sY*403, sX*256, sY*35, "Close", false, viewExpWnd)
        for i, v in pairs(currentEXP) do
        	guiGridListAddRow(expGrid, v[1], tostring(v[2]))
        end
		addEventHandler("onClientGUIClick", root, function() if (source == closeExpWnd) then guiSetVisible(viewExpWnd, false) end end )
    end
end

local invitePlayersWnd
function initInvitesWnd(blacklistedTable)
	if (isElement(invitePlayersWnd)) then
		destroyElement(invitePlayersWnd)
	else
        invitePlayersWnd = guiCreateWindow(sX*((1366 - 484) / 2), sY*((768 - 527) / 2), sX*484, sY*527, "Invite Players", false)
        guiWindowSetSizable(invitePlayersWnd, false)
		guiBringToFront(invitePlayersWnd)
        searchPlayerWnd = guiCreateEdit(sX*9, sY*30, sX*466, sY*38, "", false, invitePlayersWnd)
        playersGrid = guiCreateGridList(sX*17, sY*78, sX*448, sY*390, false, invitePlayersWnd)
        guiGridListAddColumn(playersGrid, "Name", 0.3)
        guiGridListAddColumn(playersGrid, "Account Name", 0.3)
        guiGridListAddColumn(playersGrid, "Playtime", 0.3)
        closePlayersWnd = guiCreateButton(sX*133, sY*472, sX*217, sY*45, "Close", false, invitePlayersWnd)
        guiSetProperty(closePlayersWnd, "NormalTextColour", "FFFE0000") 
		addEventHandler("onClientGUIClick", root, function() if (source == closePlayersWnd) then guiSetVisible(invitePlayersWnd, false) end end )
		for k, v in ipairs(getElementsByType("player")) do
			if not (isBlacklisted(v, blacklistedTable)) and (getElementData(v, "Group") == "None") and (exports.server:isPlayerLoggedIn(v)) then
				local row = guiGridListAddRow (playersGrid)
				guiGridListSetItemText(playersGrid, row, 1, getPlayerName(v), false, false)
				guiGridListSetItemText(playersGrid, row, 2, exports.server:getPlayerAccountName(v), false, false)
				guiGridListSetItemText(playersGrid, row, 3, math.floor(getElementData(v, "playTime")/60).." hours", false, false)
			end
		end
    end
end

local kickMemberWnd
function initKickWnd()
	if (isElement(kickMemberWnd)) then
		destroyElement(kickMemberWnd)
	else
        kickMemberWnd = guiCreateWindow(sX*((1366 - 600) / 2), sY*((768 - 180) / 2), sX*600, sY*180, "Kick Member", false)
        guiWindowSetSizable(kickMemberWnd, false)
		guiBringToFront(kickMemberWnd)
        kickReasonEdit = guiCreateEdit(sX*((600 - 522) / 2), sY*((180 - 88) / 2), sX*522, sY*88, "Reason Here", false, kickMemberWnd)
        confirmKickMember = guiCreateButton(sX*178, sY*143, sX*245, sY*27, "Kick Member", false, kickMemberWnd)
        closeKickMember = guiCreateButton(sX*562, sY*26, sX*28, sY*30, "X", false, kickMemberWnd)   
		addEventHandler("onClientGUIClick", root, function() if (source == closeKickMember) then guiSetVisible(kickMemberWnd, false) end end )
    end
end

local manageRanksWnd
function initManageWnd(ranksTable)
	if (isElement(manageRanksWnd)) then
		destroyElement(manageRanksWnd)
		removeEventHandler("onClientGUIClick", root, getRankPerms)
	else
        manageRanksWnd = guiCreateWindow(sX*((1366 - 930) / 2), sY*((768 - 582) / 2), sX*930, sY*582, "Manage Ranks", false)
        guiWindowSetSizable(manageRanksWnd, false)
		guiBringToFront(manageRanksWnd)
        manageRanksGrid = guiCreateGridList(sX*10, sY*28, sX*368, sY*544, false, manageRanksWnd)
        guiGridListAddColumn(manageRanksGrid, "Position", 0.1)
        guiGridListAddColumn(manageRanksGrid, "Ranks", 0.8)
        guiGridListSetSortingEnabled(manageRanksGrid, false)
        groupJobCheck = guiCreateCheckBox(sX*388, sY*31, sX*152, sY*15, "Ability to use group job", false, false, manageRanksWnd)
        updateCheck = guiCreateCheckBox(sX*388, sY*56, sX*218, sY*15, "Ability to update group informations", false, false, manageRanksWnd)
        changeColorCheck = guiCreateCheckBox(sX*388, sY*81, sX*218, sY*15, "Ability to change turf color", false, false, manageRanksWnd)
        motdCheck = guiCreateCheckBox(sX*388, sY*106, sX*218, sY*15, "Ability to change/add MOTD", false, false, manageRanksWnd)
        kickCheck = guiCreateCheckBox(sX*388, sY*131, sX*218, sY*15, "Ability to kick members", false, false, manageRanksWnd)
        warnCheck = guiCreateCheckBox(sX*388, sY*156, sX*218, sY*15, "Ability to warn members", false, false, manageRanksWnd)
        pointsCheck = guiCreateCheckBox(sX*388, sY*181, sX*218, sY*15, "Ability to set points", false, false, manageRanksWnd)
        inviteCheck = guiCreateCheckBox(sX*388, sY*206, sX*218, sY*15, "Ability to invite players", false, false, manageRanksWnd)
        depositCheck = guiCreateCheckBox(sX*388, sY*231, sX*218, sY*15, "Ability to deposit money to bank", false, false, manageRanksWnd)
        withdrawCheck = guiCreateCheckBox(sX*388, sY*256, sX*224, sY*15, "Ability to withdraw money from bank", false, false, manageRanksWnd)
        histCheck = guiCreateCheckBox(sX*388, sY*281, sX*224, sY*15, "Ability to view/copy group history", false, false, manageRanksWnd)
        accessCheck = guiCreateCheckBox(sX*388, sY*306, sX*224, sY*15, "Ability to give AVs access", false, false, manageRanksWnd)
        buySlotsCheck = guiCreateCheckBox(sX*388, sY*331, sX*224, sY*15, "Ability to buy slots", false, false, manageRanksWnd)
        upgradeCheck = guiCreateCheckBox(sX*388, sY*356, sX*224, sY*15, "Ability to upgrade group", false, false, manageRanksWnd)
        noteCheck = guiCreateCheckBox(sX*388, sY*381, sX*224, sY*15, "Ability to note to all members", false, false, manageRanksWnd)
        blCheck = guiCreateCheckBox(sX*388, sY*406, sX*224, sY*15, "Ability to blacklist/unblacklist players", false, false, manageRanksWnd)
        expCheck = guiCreateCheckBox(sX*388, sY*431, sX*224, sY*15, "Ability to view exp informations", false, false, manageRanksWnd)
        spawnerCheck = guiCreateCheckBox(sX*388, sY*456, sX*224, sY*15, "Ability to access to group spawners", false, false, manageRanksWnd)
        changeNameCheck = guiCreateCheckBox(sX*388, sY*481, sX*224, sY*15, "Ability to change group name", false, false, manageRanksWnd)
        typeCheck = guiCreateCheckBox(sX*388, sY*506, sX*224, sY*15, "Ability to change group type", false, false, manageRanksWnd)
        delCheck = guiCreateCheckBox(sX*388, sY*531, sX*224, sY*15, "Ability to delete group", false, false, manageRanksWnd)
        ranksCheck = guiCreateCheckBox(sX*388, sY*556, sX*224, sY*15, "Ability to set ranks", false, false, manageRanksWnd)
        addRankBtn = guiCreateButton(sX*630, sY*368, sX*290, sY*53, "Add Rank", false, manageRanksWnd)
        guiSetProperty(addRankBtn, "NormalTextColour", "FF18FE00")
        removeRankBtn = guiCreateButton(sX*630, sY*431, sX*290, sY*53, "Remove Rank", false, manageRanksWnd)
        guiSetProperty(removeRankBtn, "NormalTextColour", "FFFD0000")
        updatePermsBtn = guiCreateButton(sX*630, sY*493, sX*290, sY*53, "Update Permissions", false, manageRanksWnd)
        guiSetProperty(updatePermsBtn, "NormalTextColour", "FFFD0000")
        moveRankUpBtn = guiCreateButton(sX*630, sY*185, sX*290, sY*53, "Move Up", false, manageRanksWnd)
        guiSetProperty(moveRankUpBtn, "NormalTextColour", "FF18FE00")
        moveRankDownBtn = guiCreateButton(sX*630, sY*247, sX*290, sY*53, "Move Down", false, manageRanksWnd)
        guiSetProperty(moveRankDownBtn, "NormalTextColour", "FF18FE00")
        rankNameEdit = guiCreateEdit(sX*630, sY*309, sX*289, sY*49, "", false, manageRanksWnd)
        closeManageRanks = guiCreateButton(sX*807, sY*555, sX*113, sY*17, "Close", false, manageRanksWnd)   
		addEventHandler("onClientGUIClick", root, function() if (source == closeManageRanks) then guiSetVisible(manageRanksWnd, false) end end )
		local sortedTable = {}
		for k, v in ipairs(ranksTable) do
			if (v.position ~= -1) then
				sortedTable[v.position] = v
			else
				guiGridListAddRow(manageRanksGrid, v["position"], v["rankName"])
			end
		end
		for i, v in pairs(sortedTable) do
			local row = guiGridListAddRow(manageRanksGrid, v["position"], v["rankName"])
		end
		function getRankPerms()
			if (source == manageRanksGrid) then
			local rankName = guiGridListGetItemText(manageRanksGrid, guiGridListGetSelectedItem(manageRanksGrid), 2)
			--if (rankName == "Founder") then return false end
				guiCheckBoxSetSelected(groupJobCheck, false)
				guiCheckBoxSetSelected(updateCheck, false)
				guiCheckBoxSetSelected(changeColorCheck, false)
				guiCheckBoxSetSelected(motdCheck, false)
				guiCheckBoxSetSelected(kickCheck, false)
				guiCheckBoxSetSelected(warnCheck, false)
				guiCheckBoxSetSelected(pointsCheck, false)
				guiCheckBoxSetSelected(inviteCheck, false)
				guiCheckBoxSetSelected(depositCheck, false)
				guiCheckBoxSetSelected(withdrawCheck, false)
				guiCheckBoxSetSelected(histCheck, false)
				guiCheckBoxSetSelected(accessCheck, false)
				guiCheckBoxSetSelected(buySlotsCheck, false)
				guiCheckBoxSetSelected(upgradeCheck, false)
				guiCheckBoxSetSelected(noteCheck, false)
				guiCheckBoxSetSelected(blCheck, false)
				guiCheckBoxSetSelected(expCheck, false)
				guiCheckBoxSetSelected(spawnerCheck, false)
				guiCheckBoxSetSelected(changeNameCheck, false)
				guiCheckBoxSetSelected(typeCheck, false)
				guiCheckBoxSetSelected(delCheck, false)
				guiCheckBoxSetSelected(ranksCheck, false)
				if (guiGridListGetSelectedItem(manageRanksGrid) ~= -1) then
					for i=1,#ranksTable do
						if (ranksTable[i]["rankName"] == rankName) then
							guiCheckBoxSetSelected(groupJobCheck, convertNumToBool(tonumber(ranksTable[i]["useJob"])))
							guiCheckBoxSetSelected(updateCheck, convertNumToBool(tonumber(ranksTable[i]["updateInfo"])))
							guiCheckBoxSetSelected(changeColorCheck, convertNumToBool(tonumber(ranksTable[i]["changeColor"])))
							guiCheckBoxSetSelected(motdCheck, convertNumToBool(tonumber(ranksTable[i]["changeMotd"])))
							guiCheckBoxSetSelected(kickCheck, convertNumToBool(tonumber(ranksTable[i]["kick"])))
							guiCheckBoxSetSelected(warnCheck, convertNumToBool(tonumber(ranksTable[i]["warn"])))
							guiCheckBoxSetSelected(pointsCheck, convertNumToBool(tonumber(ranksTable[i]["pointsChange"])))
							guiCheckBoxSetSelected(inviteCheck, convertNumToBool(tonumber(ranksTable[i]["invitePlayers"])))
							guiCheckBoxSetSelected(depositCheck, convertNumToBool(tonumber(ranksTable[i]["depositMoney"])))
							guiCheckBoxSetSelected(withdrawCheck, convertNumToBool(tonumber(ranksTable[i]["withdrawMoney"])))
							guiCheckBoxSetSelected(histCheck, convertNumToBool(tonumber(ranksTable[i]["histChecking"])))
							guiCheckBoxSetSelected(accessCheck, convertNumToBool(tonumber(ranksTable[i]["changeAvs"])))
							guiCheckBoxSetSelected(buySlotsCheck, convertNumToBool(tonumber(ranksTable[i]["buySlots"])))
							guiCheckBoxSetSelected(upgradeCheck, convertNumToBool(tonumber(ranksTable[i]["upgradeGrp"])))
							guiCheckBoxSetSelected(noteCheck, convertNumToBool(tonumber(ranksTable[i]["noteAll"])))
							guiCheckBoxSetSelected(blCheck, convertNumToBool(tonumber(ranksTable[i]["blacklistPlayers"])))
							guiCheckBoxSetSelected(expCheck, convertNumToBool(tonumber(ranksTable[i]["expView"])))
							guiCheckBoxSetSelected(spawnerCheck, convertNumToBool(tonumber(ranksTable[i]["useSpawners"])))
							guiCheckBoxSetSelected(changeNameCheck, convertNumToBool(tonumber(ranksTable[i]["changeGroupName"])))
							guiCheckBoxSetSelected(typeCheck, convertNumToBool(tonumber(ranksTable[i]["changeGroupType"])))
							guiCheckBoxSetSelected(delCheck, convertNumToBool(tonumber(ranksTable[i]["deleteGroup"])))
							guiCheckBoxSetSelected(ranksCheck, convertNumToBool(tonumber(ranksTable[i]["setRank"])))
						end
					end
				end
			end
		end
		addEventHandler("onClientGUIClick", root, getRankPerms)
    end
end

local motdWnd
function initMotdWnd()
	if (isElement(motdWnd)) then
		destroyElement(motdWnd)
	else
        motdWnd = guiCreateWindow(sX*((1366 - 548) / 2), sY*((768 - 149) / 2), sX*548, sY*149, "Message Of The Day", false)
        guiWindowSetSizable(motdWnd, false)
		guiBringToFront(motdWnd)
        motdEdit = guiCreateEdit(sX*((548 - 497) / 2), sY*((149 - 49) / 2), sX*497, sY*49, "", false, motdWnd)
        applyMotd = guiCreateButton(sX*193, sY*123, sX*160, sY*16, "Apply", false, motdWnd)
        closeMotdWnd = guiCreateButton(sX*477, sY*123, sX*61, sY*16, "Close", false, motdWnd)    
		addEventHandler("onClientGUIClick", root, function() if (source == closeMotdWnd) then guiSetVisible(motdWnd, false) end end )	
    end
end

local noteAllWnd
function initNoteWnd()
	if (isElement(noteAllWnd)) then
		destroyElement(noteAllWnd)
	else
        noteAllWnd = guiCreateWindow(sX*((1366 - 650) / 2), sY*((768 - 194) / 2), sX*650, sY*194, "Note To All Members", false)
        guiWindowSetSizable(noteAllWnd, false)
		guiBringToFront(noteAllWnd)
        noteEdit = guiCreateEdit(sX*24, sY*61, sX*607, sY*54, "", false, noteAllWnd)
        sendNote = guiCreateButton(sX*179, sY*141, sX*290, sY*43, "Send", false, noteAllWnd)
        guiSetProperty(sendNote, "NormalTextColour", "FF00FF00")
        closeNoteWnd = guiCreateButton(sX*597, sY*21, sX*43, sY*34, "X", false, noteAllWnd)    
		addEventHandler("onClientGUIClick", root, function() if (source == closeNoteWnd) then guiSetVisible(noteAllWnd, false) end end )
    end
end

local insertPointsWnd
function initPointsWnd()
	if (isElement(insertPointsWnd)) then
		destroyElement(insertPointsWnd)
	else
        insertPointsWnd = guiCreateWindow(sX*((1366 - 431) / 2), sY*((768 - 195) / 2), sX*431, sY*195, "Set Points", false)
        guiWindowSetSizable(insertPointsWnd, false)
		guiBringToFront(insertPointsWnd)
        pointsEdit = guiCreateEdit(sX*58, sY*77, sX*312, sY*61, "", false, insertPointsWnd)
        pointsLabel = guiCreateLabel(sX*180, sY*31, sX*71, sY*16, "Insert Points", false, insertPointsWnd)
        savePointsBtn = guiCreateButton(sX*123, sY*148, sX*180, sY*26, "Set Points", false, insertPointsWnd)
        closePointsWnd = guiCreateButton(sX*379, sY*24, sX*37, sY*37, "X", false, insertPointsWnd)    
		addEventHandler("onClientGUIClick", root, function() if (source == closePointsWnd) then guiSetVisible(insertPointsWnd, false) end end )
    end
end

local setRanksWnd
function initSetRanksWnd(membersTable, ranksTable)
	if (isElement(setRanksWnd)) then
		destroyElement(setRanksWnd)
	else
        setRanksWnd = guiCreateWindow(sX*((1366 - 852) / 2), sY*((768 - 558) / 2), sX*852, sY*558, "Ranks Settings", false)
        guiWindowSetSizable(setRanksWnd, false)
		guiBringToFront(setRanksWnd)
        rankMembersGrid = guiCreateGridList(sX*14, sY*50, sX*274, sY*492, false, setRanksWnd)
        guiGridListAddColumn(rankMembersGrid, "Account Name", 0.5)
		guiGridListAddColumn(rankMembersGrid, "Rank", 0.5)
        setRanksGrid = guiCreateGridList(sX*300, sY*52, sX*295, sY*490, false, setRanksWnd)
        guiGridListAddColumn(setRanksGrid, "Group Ranks", 0.9)
        confirmRankBtn = guiCreateButton(sX*606, sY*235, sX*236, sY*53, "Set Rank", false, setRanksWnd)
        guiSetProperty(confirmRankBtn, "NormalTextColour", "FF00FE11")
        reasonEdit = guiCreateEdit(sX*607, sY*298, sX*235, sY*40, "Reason", false, setRanksWnd)
        closeSetRanks = guiCreateButton(sX*748, sY*529, sX*94, sY*19, "Close", false, setRanksWnd)    
		addEventHandler("onClientGUIClick", root, function() if (source == closeSetRanks) then guiSetVisible(setRanksWnd, false) end end )
		for k, v in ipairs(membersTable) do
			if (v["groupRank"] ~= "Founder") then
				local row = guiGridListAddRow (rankMembersGrid)
				guiGridListSetItemText(rankMembersGrid, row, 1, v["memberAcc"], false, false)
				guiGridListSetItemText(rankMembersGrid, row, 2, v["groupRank"], false, false)
			end
		end
		for k, v in ipairs(ranksTable) do
			if (v["rankName"] ~= "Founder") then
				local row = guiGridListAddRow (setRanksGrid)
				guiGridListSetItemText(setRanksGrid, row, 1, v["rankName"], false, false)
			end
		end
    end
end

local warningWnd
function initWarnWnd(level)
	if (isElement(warningWnd)) then
		destroyElement(warningWnd)
	else
        warningWnd = guiCreateWindow(sX*((1366 - 625) / 2), sY*((768 - 153) / 2), sX*625, sY*153, "Warning Reason/Level", false)
        guiWindowSetSizable(warningWnd, false)
		guiBringToFront(warningWnd)
        newWarningLevel = guiCreateEdit(sX*87, sY*44, sX*212, sY*66, "", false, warningWnd)
        warningLevelLabel = guiCreateLabel(sX*13, sY*63, sX*74, sY*30, "WL - "..level.."%", false, warningWnd)
        warningReasonEdit = guiCreateEdit(sX*403, sY*44, sX*212, sY*66, "", false, warningWnd)
        warningLabel = guiCreateLabel(sX*323, sY*63, 74, sY*30, "Reason", false, warningWnd)
        confirmWarnBtn = guiCreateButton(sX*408, sY*123, sX*197, sY*20, "Warn Member", false, warningWnd)
        closeWarningBtn = guiCreateButton(sX*9, sY*115, sX*30, sY*28, "X", false, warningWnd)    
		addEventHandler("onClientGUIClick", root, function() if (source == closeWarningBtn) then guiSetVisible(warningWnd, false) end end )
    end
end

local changeTypeWnd
function initChangeTypeWnd()
	if (isElement(changeTypeWnd)) then
		destroyElement(changeTypeWnd)
	else
        changeTypeWnd = guiCreateWindow(sX*((1366 - 606) / 2), sY*((768 - 117) / 2), sX*606, sY*117, "Change Group Type", false)
        guiWindowSetSizable(changeTypeWnd, false)
		guiBringToFront(changeTypeWnd)
        changeLawRadio = guiCreateRadioButton(sX*10, sY*52, sX*119, sY*15, "Law", false, changeTypeWnd)
        guiSetProperty(changeLawRadio, "NormalTextColour", "FF006CFE")
        changeCrimRadio = guiCreateRadioButton(sX*139, sY*52, sX*119, sY*15, "Criminals", false, changeTypeWnd)
        guiSetProperty(changeCrimRadio, "NormalTextColour", "FFFD0000")
        changeCivRadio = guiCreateRadioButton(sX*268, sY*52, sX*119, sY*15, "Civilians", false, changeTypeWnd)
        guiSetProperty(changeCivRadio, "NormalTextColour", "FFEEFC00")
        guiRadioButtonSetSelected(changeCivRadio, true)
        confirmChangeType = guiCreateButton(sX*396, sY*45, sX*200, sY*32, "Change Type", false, changeTypeWnd)
        closeChangeType = guiCreateButton(sX*499, sY*86, sX*97, sY*21, "Close", false, changeTypeWnd)  
		addEventHandler("onClientGUIClick", root, function() if (source == closeChangeType) then guiSetVisible(changeTypeWnd, false) end end ) 
    end
end

local radio = {}
local mainGroupWnd
function initGroupWnd(membersTable, blacklistedTable, groupsTable, logsTable, transactionsTable, avTable, invitationsTable, ranksTable, accsTable, myGroupTable, lastOnlineTimestamp)
	if (isElement(mainGroupWnd)) then
		closeAllGUIs()
	else
		exports.NGCdxmsg:createNewDxMessage("Group panel loading...",0,255,0)
		mainGroupWnd = guiCreateWindow(sX*((1366 - 1022) / 2), sY*((768 - 501) / 2), sX*1022, sY*501, "Groups Panel", false)
		guiWindowSetSizable(mainGroupWnd, false)
		showCursor(true)
		guiSetInputMode("no_binds_when_editing")
		mainTabPanel = guiCreateTabPanel(sX*10, sY*22, sX*1002, sY*469, false, mainGroupWnd)

		mainTab = guiCreateTab("Main", mainTabPanel)
		createGrpBtn = guiCreateButton(sX*10, sY*10, sX*174, sY*34, "Create Group", false, mainTab)
		guiSetProperty(createGrpBtn, "NormalTextColour", "FFF84506")
		label1 = guiCreateLabel(sX*470, sY*16, sX*70, sY*18, "Select Type:", false, mainTab)
		lawRadioBtn = guiCreateRadioButton(sX*550, sY*19, sX*43, sY*15, "Law", false, mainTab)	
		guiSetProperty(lawRadioBtn, "NormalTextColour", "FF008EF3")
		crimRadioBtn = guiCreateRadioButton(sX*603, sY*19, sX*67, sY*15, "Criminals", false, mainTab)
		guiSetProperty(crimRadioBtn, "NormalTextColour", "FFF20005")
		civRadioBtn = guiCreateRadioButton(sX*680, sY*19, sX*67, sY*15, "Civilians", false, mainTab)
		guiSetProperty(civRadioBtn, "NormalTextColour", "FFEAFE3B")	
		guiRadioButtonSetSelected(civRadioBtn, true)
		
		groupTypeLabel = guiCreateLabel(sX*757, sY*19, sX*233, sY*15, "Group Type:", false, mainTab)
		label2 = guiCreateLabel(sX*0, sY*49, sX*997, sY*15, "____________________________________________________________________________________________________________________________________________________________", false, mainTab)
		groupNameLabel = guiCreateLabel(sX*10, sY*74, sX*260, sY*15, "Group Name:", false, mainTab)
		groupFounderLabel = guiCreateLabel(sX*10, sY*99, sX*260, sY*15, "Group Founder:", false, mainTab)
		creationDateLabel = guiCreateLabel(sX*10, sY*124, sX*260, sY*15, "Group Creation Date:", false, mainTab)
		groupJoinLabel = guiCreateLabel(sX*10, sY*149, sX*260, sY*15, "Group Join Date:", false, mainTab)
		membersCountLabel = guiCreateLabel(sX*10, sY*174, sX*260, sY*15, "Group Members:", false, mainTab)
		--groupRankLabel = guiCreateLabel(10, 199, 260, 15, "Group Rank:", false, mainTab)
		groupTurfColor = guiCreateLabel(sX*10, sY*224, sX*260, sY*15, "Group Turf Color:", false, mainTab)
		groupBalanceLabel = guiCreateLabel(sX*10, sY*249, sX*260, sY*15, "Group Bank Balance:", false, mainTab)
		groupRankLabel = guiCreateLabel(sX*10, sY*274, sX*260, sY*15, "Group Ranks:", false, mainTab)
		groupMottoLabel = guiCreateLabel(sX*10, sY*299, sX*260, sY*15, "Group Motto:", false, mainTab)
		groupLevelLabel = guiCreateLabel(sX*10, sY*324, sX*260, sY*15, "Group Level:", false, mainTab)
		groupExpLabel = guiCreateLabel(sX*10, sY*349, sX*260, sY*15, "Group Exp:", false, mainTab)
		label3 = guiCreateLabel(sX*0, sY*368, sX*997, sY*15, "____________________________________________________________________________________________________________________________________________________________", false, mainTab)
		leaveGrpBtn = guiCreateButton(sX*10, sY*393, sX*200, sY*41, "Leave Group", false, mainTab)
		guiSetProperty(leaveGrpBtn, "NormalTextColour", "FFE30000")
		label4 = guiCreateLabel(sX*266, sY*403, sX*43, sY*15, "Reason:", false, mainTab)
		--groupBlipsCheck = guiCreateCheckBox(sX*624, sY*404, sX*163, sY*15, "Enable/Disable Group Blips", false, false, mainTab)
		--groupChatCheck = guiCreateCheckBox(797, sY*404, 163, sY*15, "Enable/Disable Group Chat", false, false, mainTab)
		--guiCheckBoxSetSelected(groupChatCheck, convertNumToBool(chatStatus))
		groupInfoMemo = guiCreateMemo(sX*273, sY*92, sX*719, sY*247, "", false, mainTab)
		label5 = guiCreateLabel(sX*583, sY*67, sX*101, sY*15, "Group Information", false, mainTab)
		grpInfoBtn = guiCreateButton(sX*543, sY*346, sX*181, sY*27, "Update Informations", false, mainTab)
		guiSetProperty(grpInfoBtn, "NormalTextColour", "FF00E3D5")
		groupNameEdit = guiCreateEdit(sX*200, sY*9, sX*254, sY*35, "", false, mainTab)
		leaveResEdit = guiCreateEdit(sX*363, sY*392, sX*218, sY*43, "", false, mainTab)
		membersTab = guiCreateTab("Members", mainTabPanel)

		membersGridList = guiCreateGridList(sX*((1002 - 982) / 2), sY*((445 - 427) / 2), sX*982, sY*427, false, membersTab)
		guiGridListAddColumn(membersGridList, "Name", 0.1)
		guiGridListAddColumn(membersGridList, "Account Name", 0.1)
		guiGridListAddColumn(membersGridList, "Rank", 0.1)
		guiGridListAddColumn(membersGridList, "Points", 0.1)
		guiGridListAddColumn(membersGridList, "Warning Level", 0.1)
		guiGridListAddColumn(membersGridList, "Last Seen", 0.1)
		bankTab = guiCreateTab("Balance", mainTabPanel)

		groupBalanceGrid = guiCreateGridList(sX*9, sY*10, sX*983, sY*350, false, bankTab)
		guiGridListAddColumn(groupBalanceGrid, "Text", 0.5)
		guiGridListAddColumn(groupBalanceGrid, "Time", 0.5)
		guiGridListSetSelectionMode(groupBalanceGrid, 1)
		moneyEdit = guiCreateEdit(sX*9, sY*380, sX*266, sY*45, "", false, bankTab)
		depositBtn = guiCreateButton(sX*330, sY*380, sX*177, sY*45, "Deposit", false, bankTab)
		guiSetProperty(depositBtn, "NormalTextColour", "FF008D00")
		withdrawBtn = guiCreateButton(sX*550, sY*380, sX*177, sY*45, "Withdraw", false, bankTab)
		guiSetProperty(withdrawBtn, "NormalTextColour", "FFFF0B0B")
		balanceLabel = guiCreateLabel(sX*737, sY*390, sX*255, sY*16, "Current Balance:", false, bankTab)
			
		histTab = guiCreateTab("History", mainTabPanel)

		groupHistoryGrid = guiCreateGridList(sX*7, sY*11, sX*985, sY*356, false, histTab)
		guiGridListAddColumn(groupHistoryGrid, "Date", 0.3)
		guiGridListAddColumn(groupHistoryGrid, "Text", 0.6)
		guiGridListSetSelectionMode(groupHistoryGrid, 1)
		searchHistoryEdit = guiCreateEdit(sX*550, sY*380, sX*177, sY*45, "Search", false, histTab)
		copySelectedBtn = guiCreateButton(sX*733, sY*375, sX*249, sY*60, "Copy Selected", false, histTab)
		guiSetProperty(copySelectedBtn, "NormalTextColour", "FF0BFCFE")
		histLabel = guiCreateLabel(sX*54, sY*393, sX*643, sY*15, "Added copy selected incase you wanna copy the selected group history to update your changelogs topic on forums.", false, histTab)

		function searchHistory()
			local txt = guiGetText(source)
			guiGridListClear(groupHistoryGrid)
			for i, v in pairs(logsTable) do
				if (txt == "Search" or v["logText"]:find(txt, 1, true)) then
					local row = guiGridListAddRow(groupHistoryGrid, v["dateLogged"], v["logText"])
				end
			end
		end
		addEventHandler("onClientGUIChanged", searchHistoryEdit, searchHistory)

		settingsTab = guiCreateTab("Settings", mainTabPanel)

		settingsGrid = guiCreateGridList(sX*9, sY*41, sX*282, sY*394, false, settingsTab)
		guiGridListAddColumn(settingsGrid, "Account Name", 0.3)
		guiGridListAddColumn(settingsGrid, "Rank", 0.3)
		guiGridListAddColumn(settingsGrid, "Warning Level", 0.3)
		settingsLabel = guiCreateLabel(sX*95, sY*14, sX*88, sY*17, "Group Members", false, settingsTab)
		guiLabelSetColor(settingsLabel, 10, 254, 229)
		kickBtn = guiCreateButton(sX*296, sY*157, sX*149, sY*48, "Kick Member", false, settingsTab)
		function drawKickWnd()
			if (source == kickBtn) then
				local accName = guiGridListGetItemText(settingsGrid, guiGridListGetSelectedItem(settingsGrid), 1)
				local rankName = guiGridListGetItemText(settingsGrid, guiGridListGetSelectedItem(settingsGrid), 2)
				local warnLevel = guiGridListGetItemText(settingsGrid, guiGridListGetSelectedItem(settingsGrid), 3)
				if (rankName == "Founder") then return false end
				if (guiGridListGetSelectedItem(settingsGrid) ~= -1) then
					initKickWnd()
				end
			end
		end 
		addEventHandler("onClientGUIClick", root, drawKickWnd)
		setWarnBtn = guiCreateButton(sX*296, sY*215, sX*149, sY*48, "Set Warning Level", false, settingsTab)	
		function drawWarnWnd()
			if (source == setWarnBtn) then
				local accName = guiGridListGetItemText(settingsGrid, guiGridListGetSelectedItem(settingsGrid), 1)
				local rankName = guiGridListGetItemText(settingsGrid, guiGridListGetSelectedItem(settingsGrid), 2)
				local warnLevel = guiGridListGetItemText(settingsGrid, guiGridListGetSelectedItem(settingsGrid), 3)
				--if (rankName == "Founder") then return false end
				if (guiGridListGetSelectedItem(settingsGrid) ~= -1) then
					initWarnWnd(warnLevel)
				end
			end
		end
		addEventHandler("onClientGUIClick", root, drawWarnWnd)
		setPtsBtn = guiCreateButton(sX*296, sY*273, sX*149, sY*48, "Set Points", false, settingsTab)
		 function drawPointsWnd()
			if (source == setPtsBtn) then
				local accName = guiGridListGetItemText(settingsGrid, guiGridListGetSelectedItem(settingsGrid), 1)
				local rankName = guiGridListGetItemText(settingsGrid, guiGridListGetSelectedItem(settingsGrid), 2)
				local warnLevel = guiGridListGetItemText(settingsGrid, guiGridListGetSelectedItem(settingsGrid), 3)
				--if (rankName == "Founder") then return false end
				if (guiGridListGetSelectedItem(settingsGrid) ~= -1) then
					initPointsWnd()
				end
			end
		end
		addEventHandler("onClientGUIClick", root, drawPointsWnd)
		manageRanksBtn = guiCreateButton(sX*296, sY*331, sX*149, sY*48, "Manage Ranks", false, settingsTab)
		function drawManageWnd()
			if (source == manageRanksBtn) then
				initManageWnd(ranksTable)
			end
		end
		addEventHandler("onClientGUIClick", root, drawManageWnd)
		setRankBtn = guiCreateButton(sX*296, sY*389, sX*149, sY*48, "Set Rank", false, settingsTab)
		function drawSetRankWnd()
			if (source == setRankBtn) then
				initSetRanksWnd(membersTable, ranksTable)
			end
		end
		addEventHandler("onClientGUIClick", root, drawSetRankWnd)
		changeNameBtn = guiCreateButton(sX*462, sY*41, sX*149, sY*48, "Change Group Name", false, settingsTab)
		function drawChangeWnd()
			if (source == changeNameBtn) then
				initChangeNameWnd()
			end
		end
		addEventHandler("onClientGUIClick", root, drawChangeWnd)
		changeTypeBtn = guiCreateButton(sX*462, sY*99, sX*149, sY*48, "Change Group Type", false, settingsTab)
		function drawTypeWnd()
			if (source == changeTypeBtn) then
				initChangeTypeWnd()
			end
		end
		addEventHandler("onClientGUIClick", root, drawTypeWnd)
		setTurfBtn = guiCreateButton(sX*462, sY*157, sX*149, sY*48, "Set Turf Color", false, settingsTab)
		noteToAllBtn = guiCreateButton(sX*462, sY*215, sX*149, sY*48, "Note To All Members", false, settingsTab)
		function drawNoteWnd()
			if (source == noteToAllBtn) then
				initNoteWnd()
			end
		end
		addEventHandler("onClientGUIClick", root, drawNoteWnd)
		motdBtn = guiCreateButton(sX*462, sY*273, sX*149, sY*48, "Message Of The Day", false, settingsTab)
		function drawMotdWnd()
			if (source == motdBtn) then
				initMotdWnd()
			end
		end
		addEventHandler("onClientGUIClick", root, drawMotdWnd)
		setNewFounder = guiCreateButton(sX*462, sY*331, sX*149, sY*48, "Set New Founder", false, settingsTab)
		invitePlayers = guiCreateButton(sX*462, sY*389, sX*149, sY*48, "Invite Players", false, settingsTab)
		function drawInvitesWnd()
			if (source == invitePlayers) then
				initInvitesWnd(blacklistedTable)
			end
		end
		addEventHandler("onClientGUIClick", root, drawInvitesWnd)
		upgradeGrp = guiCreateButton(sX*629, sY*41, sX*149, sY*48, "Upgrade Group", false, settingsTab)
		viewExp = guiCreateButton(sX*296, sY*99, sX*149, sY*48, "View Exp Informations", false, settingsTab)
		function drawExpWnd()
			if (source == viewExp) then
				initViewExpWnd()
			end
		end
		addEventHandler("onClientGUIClick", root, drawExpWnd)
		buySlots = guiCreateButton(sX*296, sY*41, sX*149, sY*48, "Buy Slots", false, settingsTab)
		function drawSlotsWnd()
			if (source == buySlots) then
				for i=1,#myGroupTable do
					if (myGroupTable[i]["groupName"] == getElementData(localPlayer, "Group")) then
						initSlotsWnd(myGroupTable[1]["maxSlots"])
					end
				end
			end
		end
		addEventHandler("onClientGUIClick", root, drawSlotsWnd)
		rEdit = guiCreateEdit(sX*629, sY*160, sX*68, sY*45, "", false, settingsTab)
		rLabel = guiCreateLabel(sX*629, sY*136, sX*15, sY*21, "R", false, settingsTab)
		guiLabelSetColor(rLabel, 253, 1, 1)
		gEdit = guiCreateEdit(sX*720, sY*160, sX*68, sY*45, "", false, settingsTab)
		gLabel = guiCreateLabel(sX*720, sY*136, sX*15, sY*21, "G", false, settingsTab)
		guiLabelSetColor(gLabel, 0, 255, 0)
		bEdit = guiCreateEdit(sX*818, sY*160, sX*68, sY*45, "", false, settingsTab)
		bLabel = guiCreateLabel(sX*818, sY*136, sX*15, sY*21, "B", false, settingsTab)
		guiLabelSetColor(bLabel, 0, 0, 255)
		openPicker = guiCreateButton(sX*629, sY*215, sX*149, sY*48, "Open Picker", false, settingsTab)
		function drawThePicker()
			if (source == openPicker) then
				exports.AURcpicker:openPicker("SAMgroups")
			end
		end
		addEventHandler("onClientGUIClick", root, drawThePicker)
		avTab = guiCreateTab("AVs Access", mainTabPanel)

		avGrid = guiCreateGridList(sX*9, sY*10, sX*983, sY*425, false, avTab)
		guiGridListAddColumn(avGrid, "Name", 0.3)
		guiGridListAddColumn(avGrid, "Hunter", 0.1)
		guiGridListAddColumn(avGrid, "Hydra", 0.1)
		guiGridListAddColumn(avGrid, "Rhino", 0.1)
		guiGridListAddColumn(avGrid, "Rustler", 0.1)
		guiGridListAddColumn(avGrid, "Seasparrow", 0.1)
		guiGridListAddColumn(avGrid, "SWAT Tank", 0.1)
		guiGridListSetSelectionMode(avGrid, 2)
		blackTab = guiCreateTab("Blacklist", mainTabPanel)

		blabel4 = guiCreateLabel(sX*310, sY*10, sX*98, sY*17, "Blacklisted Players", false, blackTab)
		guiLabelSetColor(blabel4, 253, 0, 0)
		blacklistGrid = guiCreateGridList(sX*7, sY*34, sX*706, sY*401, false, blackTab)
		guiGridListAddColumn(blacklistGrid, "Name", 0.2)
		guiGridListAddColumn(blacklistGrid, "Account Name", 0.2)
		guiGridListAddColumn(blacklistGrid, "Level", 0.2)
		guiGridListAddColumn(blacklistGrid, "Blacklisted By", 0.2)
		guiGridListAddColumn(blacklistGrid, "Reason", 0.2)
		blabel1 = guiCreateLabel(sX*818, sY*34, sX*81, sY*17, "Account Name", false, blackTab)
		bacc = guiCreateEdit(sX*738, sY*61, sX*245, sY*29, "", false, blackTab)
		blabel2 = guiCreateLabel(sX*818, sY*100, sX*81, sY*17, "Player Name", false, blackTab)
		bname = guiCreateEdit(sX*738, sY*127, sX*245, sY*29, "", false, blackTab)
		blabel3 = guiCreateLabel(sX*818, sY*166, sX*85, sY*15, "Blacklist Reason", false, blackTab)
		breason = guiCreateEdit(sX*738, sY*191, sX*245, sY*29, "", false, blackTab)
		radio[1] = guiCreateRadioButton(sX*741, sY*236, sX*67, sY*15, "Level 1", false, blackTab)
		radio[2] = guiCreateRadioButton(sX*916, sY*236, sX*67, sY*15, "Level 2", false, blackTab)
		radio[3] = guiCreateRadioButton(sX*741, sY*280, sX*67, sY*15, "Level 3", false, blackTab)
		radio[4] = guiCreateRadioButton(sX*916, sY*280, sX*67, sY*15, "Level 4", false, blackTab)
		radio[5] = guiCreateRadioButton(sX*828, sY*305, sX*67, sY*15, "Level 5", false, blackTab)
		addBlacklist = guiCreateButton(sX*741, sY*330, sX*242, sY*39, "Add Blacklist", false, blackTab)
		guiSetProperty(addBlacklist, "NormalTextColour", "FFFD0000")
		removeBlacklist = guiCreateButton(sX*741, sY*386, sX*242, sY*39, "Remove Blacklist", false, blackTab)
		guiSetProperty(removeBlacklist, "NormalTextColour", "FF05FD00")
		
		invitationsTab = guiCreateTab("Invitations", mainTabPanel)

		invitationsGrid = guiCreateGridList(sX*10, sY*10, sX*982, sY*365, false, invitationsTab)
		guiGridListAddColumn(invitationsGrid, "Group Name:", 0.3)
		guiGridListAddColumn(invitationsGrid, "Invited By:", 0.3)
		guiGridListAddColumn(invitationsGrid, "Date:", 0.3)
		acceptBtn = guiCreateButton(sX*296, sY*381, sX*175, sY*48, "Accept", false, invitationsTab)
		guiSetProperty(acceptBtn, "NormalTextColour", "FF00FF00")
		declineBtn = guiCreateButton(sX*554, sY*381, sX*175, sY*48, "Decline", false, invitationsTab)
		guiSetProperty(declineBtn, "NormalTextColour", "FFFF0000")
		

		otherTab = guiCreateTab("Other Groups", mainTabPanel)

		otherGroupsGrid = guiCreateGridList(sX*9, sY*12, sX*983, sY*423, false, otherTab)
		guiGridListAddColumn(otherGroupsGrid, "Group Level", 0.1)
		guiGridListAddColumn(otherGroupsGrid, "Group Name", 0.3)
		guiGridListAddColumn(otherGroupsGrid, "Total Members", 0.1)
		guiGridListAddColumn(otherGroupsGrid, "Group Founder", 0.1)
		guiGridListAddColumn(otherGroupsGrid, "Creation Date", 0.1)
		guiGridListAddColumn(otherGroupsGrid, "Group Balance", 0.2)
		for k, v in ipairs(groupsTable) do
			local row = guiGridListAddRow (otherGroupsGrid)
			guiGridListSetItemText(otherGroupsGrid, row, 1, v["groupLevel"], false, true)
			guiGridListSetItemText(otherGroupsGrid, row, 2, v["groupName"], false, false)
			guiGridListSetItemText(otherGroupsGrid, row, 3, v["count"], false, true)
			if (getPlayerFromAccountName(v["founderAcc"])) then
				guiGridListSetItemText(otherGroupsGrid, row, 4, getPlayerName(getPlayerFromAccountName(v["founderAcc"])), false, false)
			else
				guiGridListSetItemText(otherGroupsGrid, row, 4, v["founderAcc"], false, false)
			end
			guiGridListSetItemText(otherGroupsGrid, row, 5, v["dateCreated"], false, false)
			guiGridListSetItemText(otherGroupsGrid, row, 6, "$"..exports.server:convertNumber(v["groupBalance"]), false, false)
		end
		if (getElementData(localPlayer, "Group") ~= "None") then
			guiSetEnabled(createGrpBtn, false)
			guiSetEnabled(invitationsTab, false)
			for i=1,#myGroupTable do
				if (myGroupTable[i]["groupName"] == getElementData(localPlayer, "Group")) then
					guiSetText(groupNameLabel, "Group Name: "..myGroupTable[i]["groupName"])
					guiSetText(groupTypeLabel, "Group Type: "..myGroupTable[i]["groupType"])
					currentEXP = expInformation[myGroupTable[i]["groupType"]]
					if (getPlayerFromAccountName(myGroupTable[i]["founderAcc"])) then
						guiSetText(groupFounderLabel, "Group Founder: "..getPlayerName(getPlayerFromAccountName(myGroupTable[i]["founderAcc"])))
					else
						guiSetText(groupFounderLabel, "Group Founder: "..myGroupTable[i]["founderAcc"])
					end
					guiSetText(creationDateLabel, "Group Creation Date: "..myGroupTable[i]["dateCreated"])
					guiSetText(membersCountLabel, "Group Members: "..myGroupTable[i]["count"].." / "..myGroupTable[i]["maxSlots"].."")
					guiSetText(groupTurfColor, "Group Turf Color: This is your turf color.")
					guiLabelSetColor(groupTurfColor, tonumber(myGroupTable[i]["turfR"]), tonumber(myGroupTable[i]["turfG"]), tonumber(myGroupTable[i]["turfB"]))
					guiSetText(groupBalanceLabel, "Group Bank Balance: $"..exports.server:convertNumber(tonumber(myGroupTable[i]["groupBalance"])))
					guiSetText(balanceLabel, "Current Balance: $"..exports.server:convertNumber(tonumber(myGroupTable[i]["groupBalance"])))
					guiSetText(groupMottoLabel, "Group Motto: "..myGroupTable[i]["motto"])
					guiSetText(groupLevelLabel, "Group Level: "..myGroupTable[i]["groupLevel"])
					local expNeededNextLevel = 2000
					local moneyNeeded = 100000
					if (myGroupTable[i]["groupLevel"] == 1) then
						expNeededNextLevel = 5000
						moneyNeeded = 300000
					elseif (myGroupTable[i]["groupLevel"] == 2) then
						expNeededNextLevel = 9500
						moneyNeeded = 500000
					elseif (myGroupTable[i]["groupLevel"] == 3) then
						expNeededNextLevel = 15000
						moneyNeeded = 700000
					elseif (myGroupTable[i]["groupLevel"] == 4) then
						expNeededNextLevel = 30000
						moneyNeeded = 1000000
					elseif (myGroupTable[i]["groupLevel"] == 5) then
						expNeededNextLevel = "Max level"
						moneyNeeded = 0
					end
					guiSetText(groupExpLabel, "Group Exp: "..exports.server:convertNumber(myGroupTable[i]["groupExp"]).."/"..exports.server:convertNumber(expNeededNextLevel).." ($"..exports.server:convertNumber(moneyNeeded)..")")
					guiSetText(groupInfoMemo, myGroupTable[i]["groupInfo"] or "N/A")
				end
				guiSetText(groupRankLabel, "Group Rank: "..getElementData(localPlayer, "Group Rank"))
			end
			for k, v in ipairs(membersTable) do
				local row = guiGridListAddRow (membersGridList)
				guiGridListSetItemText(membersGridList, row, 1, v["memberName"], false, false)
				guiGridListSetItemText(membersGridList, row, 2, v["memberAcc"], false, false)
				guiGridListSetItemText(membersGridList, row, 3, v["groupRank"], false, false)
				guiGridListSetItemText(membersGridList, row, 4, v["points"], false, false)
				guiGridListSetItemText(membersGridList, row, 5, v["warned"], false, false)
				guiGridListSetItemColor(membersGridList, row, 1, 255, 0, 0)
				guiGridListSetItemColor(membersGridList, row, 2, 255, 0, 0)
				guiGridListSetItemColor(membersGridList, row, 3, 255, 0, 0)
				guiGridListSetItemColor(membersGridList, row, 4, 255, 0, 0)
				guiGridListSetItemColor(membersGridList, row, 5, 255, 0, 0)
				if (getPlayerFromAccountName(v["memberAcc"])) then
					guiGridListSetItemText(membersGridList, row, 6, "Online", false, false)
					guiGridListSetItemText(membersGridList, row, 1, getPlayerName((getPlayerFromAccountName(v["memberAcc"]))), false, false)
					guiGridListSetItemColor(membersGridList, row, 1, 0, 255, 0)
					guiGridListSetItemColor(membersGridList, row, 2, 0, 255, 0)
					guiGridListSetItemColor(membersGridList, row, 3, 0, 255, 0)
					guiGridListSetItemColor(membersGridList, row, 4, 0, 255, 0)
					guiGridListSetItemColor(membersGridList, row, 5, 0, 255, 0)
					guiGridListSetItemColor(membersGridList, row, 6, 0, 255, 0)
				else
					local diff = lastOnlineTimestamp - v["lastOnline"]
					if (diff < 60) then
						guiGridListSetItemText(membersGridList, row, 6, ""..diff.." seconds ago", false, false)
					end
					if (diff <= 3600) and (diff >=  60) then
						guiGridListSetItemText(membersGridList, row, 6, ""..math.floor(diff/60).." minutes ago", false, false)
					end
					if (diff < 86400) and (diff >= 3600) then
						guiGridListSetItemText(membersGridList, row, 6, ""..math.floor(diff/3600).." hours ago", false, false)
					end
					if (diff >= 86400) then
						if (math.floor(diff/86400) < 1729) then
							guiGridListSetItemText(membersGridList, row, 6, ""..math.floor(diff/86400).." days ago", false, false)
						else
							guiGridListSetItemText(membersGridList, row, 6, "Unknown", false, false)
						end
					end
					guiGridListSetItemColor(membersGridList, row, 6, 255, 0, 0)
				end
			end
			for k, v in ipairs(transactionsTable) do
				local row = guiGridListAddRow (groupBalanceGrid)
				guiGridListSetItemText(groupBalanceGrid, row, 1, v["logText"], false, false)
				guiGridListSetItemText(groupBalanceGrid, row, 2, v["dateLogged"], false, false)
			end
		
			for k, v in ipairs(membersTable) do
			if (v["memberAcc"] == exports.server:getPlayerAccountName(localPlayer)) then
				guiSetText(groupJoinLabel, "Group Join Date: "..v["dateJoined"])
			end
				local row = guiGridListAddRow (settingsGrid)
				guiGridListSetItemText(settingsGrid, row, 1, v["memberAcc"], false, false)
				guiGridListSetItemText(settingsGrid, row, 2, v["groupRank"], false, false)
				guiGridListSetItemText(settingsGrid, row, 3, v["warned"], false, false)
			end
		
			for k, v in ipairs(avTable) do	
				local row = guiGridListAddRow (avGrid)
				if (getPlayerFromAccountName(v["memberAcc"])) then
					guiGridListSetItemText(avGrid, row, 1, getPlayerName(getPlayerFromAccountName(v["memberAcc"])), false, false)
				else
					guiGridListSetItemText(avGrid, row, 1, v["memberAcc"], false, false)
				end
				if (v["hunter"] == 0) then
					guiGridListSetItemText(avGrid, row, 2, "No", false, false)
				else
					guiGridListSetItemText(avGrid, row, 2, "Yes", false, false)
				end
				if (v["hydra"] == 0) then
					guiGridListSetItemText(avGrid, row, 3, "No", false, false)
				else
					guiGridListSetItemText(avGrid, row, 3, "Yes", false, false)
				end
				if (v["rhino"] == 0) then
					guiGridListSetItemText(avGrid, row, 4, "No", false, false)
				else
					guiGridListSetItemText(avGrid, row, 4, "Yes", false, false)
				end
				if (v["rustler"] == 0) then
					guiGridListSetItemText(avGrid, row, 5, "No", false, false)
				else
					guiGridListSetItemText(avGrid, row, 5, "Yes", false, false)
				end
				if (v["seasparrow"] == 0) then
					guiGridListSetItemText(avGrid, row, 6, "No", false, false)
				else
					guiGridListSetItemText(avGrid, row, 6, "Yes", false, false)
				end
				if (v["tank"] == 0) then
					guiGridListSetItemText(avGrid, row, 7, "No", false, false)
				else
					guiGridListSetItemText(avGrid, row, 7, "Yes", false, false)
				end
			end
			logsTableCache = logsTable
			for k, v in ipairs(logsTable) do
				local row = guiGridListAddRow (groupHistoryGrid)
				guiGridListSetItemText(groupHistoryGrid, row, 1, v["dateLogged"], false, false)
				guiGridListSetItemText(groupHistoryGrid, row, 2, v["logText"], false, false)
			end
		
			for k, v in ipairs(blacklistedTable) do
				local row = guiGridListAddRow (blacklistGrid)
				guiGridListSetItemText(blacklistGrid, row, 1, v["blacklistedName"], false, false)
				guiGridListSetItemText(blacklistGrid, row, 2, v["blacklistedAcc"], false, false)
				guiGridListSetItemText(blacklistGrid, row, 3, v["level"], false, false)
				guiGridListSetItemText(blacklistGrid, row, 4, v["blacklistedBy"], false, false)
				guiGridListSetItemText(blacklistGrid, row, 5, v["reason"], false, false)
			end
			local groupRank = getElementData(localPlayer, "Group Rank")
			for i, v2 in pairs(ranksTable) do
				if (v2.rankName == groupRank) then
					updateGUIPerms(v2)
					break
				end
			end
		else
			guiSetEnabled(leaveGrpBtn, false)
			guiSetEnabled(membersTab, false)
			guiSetEnabled(bankTab, false)
			guiSetEnabled(histTab, false)
			guiSetEnabled(settingsTab, false)
			guiSetEnabled(avTab, false)
			guiSetEnabled(blackTab, false)
			guiSetEnabled(grpInfoBtn, false)
			guiMemoSetReadOnly(groupInfoMemo, true)
			for k, v in ipairs(invitationsTable) do	
				local row = guiGridListAddRow (invitationsGrid)
				guiGridListSetItemText(invitationsGrid, row, 1, v["groupName"], false, false)
				guiGridListSetItemText(invitationsGrid, row, 2, v["invitedBy"], false, false)
				guiGridListSetItemText(invitationsGrid, row, 3, v["dateInvited"], false, false)
			end
		end
	end
end
addEvent("AURgroups.initGroupWnd", true)
addEventHandler("AURgroups.initGroupWnd", root, initGroupWnd)

function closeAllGUIs()
	guiSetInputMode("allow_binds")
	removeEventHandler("onClientGUIClick", root, drawKickWnd)
	removeEventHandler("onClientGUIClick", root, drawExpWnd)
	removeEventHandler("onClientGUIClick", root, drawWarnWnd)
	removeEventHandler("onClientGUIClick", root, drawPointsWnd)
	removeEventHandler("onClientGUIClick", root, drawManageWnd)
	removeEventHandler("onClientGUIClick", root, drawChangeWnd)
	removeEventHandler("onClientGUIClick", root, drawTypeWnd)
	removeEventHandler("onClientGUIClick", root, drawNoteWnd)
	removeEventHandler("onClientGUIClick", root, drawMotdWnd)
	removeEventHandler("onClientGUIClick", root, drawInvitesWnd)
	removeEventHandler("onClientGUIClick", root, drawExpWnd)
	removeEventHandler("onClientGUIClick", root, drawSlotsWnd)
	removeEventHandler("onClientGUIClick", root, drawSetRankWnd)
	removeEventHandler("onClientGUIClick", root, drawThePicker)
	triggerServerEvent("AURgroups.changeisShowing", localPlayer)
	for k, v in ipairs(getElementsByType("gui-window", resourceRoot)) do
		if (isElement(v)) then
			destroyElement(v)
			showCursor(false)
		end
	end
end

function createGroup()
	if (source == createGrpBtn) then
		local groupName = guiGetText(groupNameEdit)
		if (groupName == "") then return false end
		if not (guiRadioButtonGetSelected(lawRadioBtn)) and not (guiRadioButtonGetSelected(civRadioBtn)) and not (guiRadioButtonGetSelected(crimRadioBtn)) then return false end
		if (guiRadioButtonGetSelected(lawRadioBtn)) then
			returnType = "Law"
		elseif (guiRadioButtonGetSelected(civRadioBtn)) then
			returnType = "Civilian"
		elseif (guiRadioButtonGetSelected(crimRadioBtn)) then
			returnType = "Criminal"
		end
		triggerServerEvent("AURgroups.createNewGroup", localPlayer, localPlayer, groupName, returnType)
		closeAllGUIs()
	end
end
addEventHandler("onClientGUIClick", root, createGroup)

function updateRankPerms()
	if (source == updatePermsBtn) then
		local rankName = guiGridListGetItemText(manageRanksGrid, guiGridListGetSelectedItem(manageRanksGrid), 2)
		if (rankName == "Founder") then return false end
		if (guiGridListGetSelectedItem(manageRanksGrid) ~= -1) then
			local job = convertBoolToNum(guiCheckBoxGetSelected(groupJobCheck))
			local update = convertBoolToNum(guiCheckBoxGetSelected(updateCheck))
			local color = convertBoolToNum(guiCheckBoxGetSelected(changeColorCheck))
			local motd = convertBoolToNum(guiCheckBoxGetSelected(motdCheck))
			local kick = convertBoolToNum(guiCheckBoxGetSelected(kickCheck))
			local warn = convertBoolToNum(guiCheckBoxGetSelected(warnCheck))
			local points = convertBoolToNum(guiCheckBoxGetSelected(pointsCheck))
			local invite = convertBoolToNum(guiCheckBoxGetSelected(inviteCheck))
			local depo = convertBoolToNum(guiCheckBoxGetSelected(depositCheck))
			local with = convertBoolToNum(guiCheckBoxGetSelected(withdrawCheck))
			local hist = convertBoolToNum(guiCheckBoxGetSelected(histCheck))
			local access = convertBoolToNum(guiCheckBoxGetSelected(accessCheck))
			local slots = convertBoolToNum(guiCheckBoxGetSelected(buySlotsCheck))
			local upgrd = convertBoolToNum(guiCheckBoxGetSelected(upgradeCheck))
			local note = convertBoolToNum(guiCheckBoxGetSelected(noteCheck))
			local bl = convertBoolToNum(guiCheckBoxGetSelected(blCheck))
			local exp = convertBoolToNum(guiCheckBoxGetSelected(expCheck))
			local spawn = convertBoolToNum(guiCheckBoxGetSelected(spawnerCheck))
			local name = convertBoolToNum(guiCheckBoxGetSelected(changeNameCheck))
			local type = convertBoolToNum(guiCheckBoxGetSelected(typeCheck))
			local del = convertBoolToNum(guiCheckBoxGetSelected(delCheck))
			local set = convertBoolToNum(guiCheckBoxGetSelected(ranksCheck))
			triggerServerEvent("AURgroups.updateRankPermissions", localPlayer, localPlayer, rankName, job, update, color, motd, kick ,warn, points, invite, depo, with, hist, access, slots, upgrd, note, bl, exp, spawn, name, type, del, set)
			closeAllGUIs()
		end
	end
end
addEventHandler("onClientGUIClick", root, updateRankPerms)

function addNewRank()
	if (source == addRankBtn) then
		local rankName = guiGetText(rankNameEdit)
		if (rankName == "") then return false end
		local job = convertBoolToNum(guiCheckBoxGetSelected(groupJobCheck))
		local update = convertBoolToNum(guiCheckBoxGetSelected(updateCheck))
		local color = convertBoolToNum(guiCheckBoxGetSelected(changeColorCheck))
		local motd = convertBoolToNum(guiCheckBoxGetSelected(motdCheck))
		local kick = convertBoolToNum(guiCheckBoxGetSelected(kickCheck))
		local warn = convertBoolToNum(guiCheckBoxGetSelected(warnCheck))
		local points = convertBoolToNum(guiCheckBoxGetSelected(pointsCheck))
		local invite = convertBoolToNum(guiCheckBoxGetSelected(inviteCheck))
		local depo = convertBoolToNum(guiCheckBoxGetSelected(depositCheck))
		local with = convertBoolToNum(guiCheckBoxGetSelected(withdrawCheck))
		local hist = convertBoolToNum(guiCheckBoxGetSelected(histCheck))
		local access = convertBoolToNum(guiCheckBoxGetSelected(accessCheck))
		local slots = convertBoolToNum(guiCheckBoxGetSelected(buySlotsCheck))
		local upgrd = convertBoolToNum(guiCheckBoxGetSelected(upgradeCheck))
		local note = convertBoolToNum(guiCheckBoxGetSelected(noteCheck))
		local bl = convertBoolToNum(guiCheckBoxGetSelected(blCheck))
		local exp = convertBoolToNum(guiCheckBoxGetSelected(expCheck))
		local spawn = convertBoolToNum(guiCheckBoxGetSelected(spawnerCheck))
		local name = convertBoolToNum(guiCheckBoxGetSelected(changeNameCheck))
		local type = convertBoolToNum(guiCheckBoxGetSelected(typeCheck))
		local del = convertBoolToNum(guiCheckBoxGetSelected(delCheck))
		local set = convertBoolToNum(guiCheckBoxGetSelected(ranksCheck))
		triggerServerEvent("AURgroups.addNewRank", localPlayer, localPlayer, rankName, job, update, color, motd, kick ,warn, points, invite, depo, with, hist, access, slots, upgrd, note, bl, exp, spawn, name, type, del, set)
		closeAllGUIs()
	elseif (source == moveRankUpBtn) then
		local row = guiGridListGetSelectedItem(manageRanksGrid)
		if (row == -1) then
			return false
		end
		local pos, rankName = guiGridListGetItemText(manageRanksGrid, row, 1), guiGridListGetItemText(manageRanksGrid, row, 2) 
		triggerServerEvent("AURgroups.moveRankUp", resourceRoot, rankName, pos)
		closeAllGUIs()
	elseif (source == moveRankDownBtn) then
		local row = guiGridListGetSelectedItem(manageRanksGrid)
		if (row == -1) then
			return false
		end
		local pos, rankName = guiGridListGetItemText(manageRanksGrid, row, 1), guiGridListGetItemText(manageRanksGrid, row, 2) 
		triggerServerEvent("AURgroups.moveRankDown", resourceRoot, rankName, pos)
		closeAllGUIs()
	end
end
addEventHandler("onClientGUIClick", root, addNewRank)

function deleteRank()
	if (source == removeRankBtn) then
		local rankName = guiGridListGetItemText(manageRanksGrid, guiGridListGetSelectedItem(manageRanksGrid), 2)
		if (rankName == "Founder") or (rankName == "Trial") then return false end
		if (guiGridListGetSelectedItem(manageRanksGrid) ~= -1) then
			triggerServerEvent("AURgroups.deleteRank", localPlayer, localPlayer, rankName)
			closeAllGUIs()
		end
	end
end
addEventHandler("onClientGUIClick", root, deleteRank)

function setPlayerRank()
	if (source == confirmRankBtn) then
		local accName = guiGridListGetItemText(rankMembersGrid, guiGridListGetSelectedItem(rankMembersGrid), 1)
		local oldRank = guiGridListGetItemText(rankMembersGrid, guiGridListGetSelectedItem(rankMembersGrid), 2)
		local newRank = guiGridListGetItemText(setRanksGrid, guiGridListGetSelectedItem(setRanksGrid), 1)
		local reason = guiGetText(reasonEdit)
		if (oldRank == newRank) or (reason == "") then return false end
		if (accName == exports.server:getPlayerAccountName(localPlayer)) then return false end
		if (guiGridListGetSelectedItem(setRanksGrid) ~= -1) and (guiGridListGetSelectedItem(rankMembersGrid) ~= -1) then
			triggerServerEvent("AURgroups.setPlayerRank", localPlayer, localPlayer, accName, oldRank, newRank, reason)
			closeAllGUIs()
		end
	end
end
addEventHandler("onClientGUIClick", root, setPlayerRank)

function manageMoney()
	if (source == depositBtn) then
		local money = guiGetText(moneyEdit)
		if not (tonumber(money)) then return false end
		local money = tonumber(money)
		if (money < 0) then return false end
		triggerServerEvent("AURgroups.depositMoney", localPlayer, localPlayer, money)
		closeAllGUIs()
	end
	if (source == withdrawBtn) then
		local money = guiGetText(moneyEdit)
		if not (tonumber(money)) then return false end
		local money = tonumber(money)
		if (money < 0) then return false end
		triggerServerEvent("AURgroups.withdrawMoney", localPlayer, localPlayer, money)
		closeAllGUIs()
	end
end
addEventHandler("onClientGUIClick", root, manageMoney)

function inviteThePlayer()
	if (source == playersGrid) then
		local playerName = guiGridListGetItemText(playersGrid, guiGridListGetSelectedItem(playersGrid), 1)
		local accName = guiGridListGetItemText(playersGrid, guiGridListGetSelectedItem(playersGrid), 2)
		if (guiGridListGetSelectedItem(playersGrid) ~= -1) then
			triggerServerEvent("AURgroups.inviteThePlayer", localPlayer, localPlayer, getPlayerFromName(playerName), accName)
			closeAllGUIs()
		end
	end
end
addEventHandler("onClientGUIDoubleClick", root, inviteThePlayer)

function delLeaveGroup()
	if (source == leaveGrpBtn) then
		local reason = guiGetText(leaveResEdit)
		if (reason == "") then return false end
		triggerServerEvent("AURgroups.delLeaveGroup", localPlayer, localPlayer, guiGetText(leaveGrpBtn), reason)
		closeAllGUIs()
	end
end
addEventHandler("onClientGUIClick", root, delLeaveGroup)

function acceptDenyInvitation()
	if (source == acceptBtn) then
		local groupName = guiGridListGetItemText(invitationsGrid, guiGridListGetSelectedItem(invitationsGrid), 1)
		if (guiGridListGetSelectedItem(invitationsGrid) ~= -1) then
			triggerServerEvent("AURgroups.acceptDenyInvitation", localPlayer, localPlayer, "accept", groupName)
			closeAllGUIs()
		end
	end
	if (source == declineBtn) then
		local groupName = guiGridListGetItemText(invitationsGrid, guiGridListGetSelectedItem(invitationsGrid), 1)
		if (guiGridListGetSelectedItem(invitationsGrid) ~= -1) then
			triggerServerEvent("AURgroups.acceptDenyInvitation", localPlayer, localPlayer, "deny", groupName)
			closeAllGUIs()
		end
	end
end
addEventHandler("onClientGUIClick", root, acceptDenyInvitation)

function updateGroupInfo()
	if (source == grpInfoBtn) then
	local text = guiGetText(groupInfoMemo)
		triggerServerEvent("AURgroups.updateGroupInfo", localPlayer, localPlayer, text)
		closeAllGUIs()
	end
end
addEventHandler("onClientGUIClick", root, updateGroupInfo)

function copySelectedLog()
	if (source == copySelectedBtn) then
	local date = guiGridListGetItemText(groupHistoryGrid, guiGridListGetSelectedItem(groupHistoryGrid), 1)
	local text = guiGridListGetItemText(groupHistoryGrid, guiGridListGetSelectedItem(groupHistoryGrid), 2)
		if (guiGridListGetSelectedItem(groupHistoryGrid) ~= -1) then
			setClipboard("["..date.."] "..text.."")
		end
	end
end
addEventHandler("onClientGUIClick", root, copySelectedLog)

function changeAvAccess()
	if (source == avGrid) then
		local row, col = guiGridListGetSelectedItem(avGrid)
		local accName = guiGridListGetItemText(avGrid, guiGridListGetSelectedItem(avGrid), 1)
		local access = guiGridListGetItemText(avGrid, guiGridListGetSelectedItem(avGrid), col)
		if (guiGridListGetSelectedItem(avGrid) ~= -1) and (col ~= 1) then
			triggerServerEvent("AURgroups.changeAvAccess", localPlayer, localPlayer, accName, access, col)
			closeAllGUIs()
		end
	end
end
addEventHandler("onClientGUIDoubleClick", root, changeAvAccess)

function buySlotsForGroup()
	if (source == confirmBuySlots) then
		triggerServerEvent("AURgroups.buySlotsForGroup", localPlayer, localPlayer)
		closeAllGUIs()
	end
end
addEventHandler("onClientGUIClick", root, buySlotsForGroup)

function setPlayerWarningLevel()
	if (source == confirmWarnBtn) then
		local newLevel = guiGetText(newWarningLevel)
		if not (tonumber(newLevel)) then return false end
		local newLevel = tonumber(newLevel)
		if (newLevel < 0) or (newLevel > 100) then return false end
		local reason = guiGetText(warningReasonEdit)
		if (reason == "") then return false end
		local accName = guiGridListGetItemText(settingsGrid, guiGridListGetSelectedItem(settingsGrid), 1)
		if (guiGridListGetSelectedItem(settingsGrid) ~= -1) then
			triggerServerEvent("AURgroups.setPlayerWarningLevel", localPlayer, localPlayer, newLevel, reason, accName)
			closeAllGUIs()
		end
	end		
end	
addEventHandler("onClientGUIClick", root, setPlayerWarningLevel)

function setPlayerPoints()
	if (source == savePointsBtn) then
		local accName = guiGridListGetItemText(settingsGrid, guiGridListGetSelectedItem(settingsGrid), 1)
		local pts = guiGetText(pointsEdit)
		if not (tonumber(pts)) then return false end
		local pts = tonumber(pts)
		if (guiGridListGetSelectedItem(settingsGrid) ~= -1) then
			triggerServerEvent("AURgroups.setPlayerPoints", localPlayer, localPlayer, accName, pts)
			closeAllGUIs()
		end
	end
end
addEventHandler("onClientGUIClick", root, setPlayerPoints)	

function setAnotherFounder()
	if (source == setNewFounder) then
		local accName = guiGridListGetItemText(settingsGrid, guiGridListGetSelectedItem(settingsGrid), 1)
		local rankName = guiGridListGetItemText(settingsGrid, guiGridListGetSelectedItem(settingsGrid), 2)
		if (rankName == "Founder") then return false end
		if (guiGridListGetSelectedItem(settingsGrid) ~= -1) then
			triggerServerEvent("AURgroups.setAnotherFounder", localPlayer, localPlayer, accName)
			closeAllGUIs()
		end
	end
end
addEventHandler("onClientGUIClick", root, setAnotherFounder)	

function setGroupMotd()
	if (source == applyMotd) then
		local motd = guiGetText(motdEdit)
		if (motd == "") then return false end
		triggerServerEvent("AURgroups.setGroupMotd", localPlayer, localPlayer, motd)
		closeAllGUIs()
	end
end
addEventHandler("onClientGUIClick", root, setGroupMotd)	

function noteToEveryone()
	if (source == sendNote) then
		local text = guiGetText(noteEdit)
		if (text == "") then return false end
		triggerServerEvent("AURgroups.noteToEveryone", localPlayer, localPlayer, text)
		closeAllGUIs()
	end
end
addEventHandler("onClientGUIClick", root, noteToEveryone)	

function changeTheType()
	if (source == confirmChangeType) then
		if not (guiRadioButtonGetSelected(changeLawRadio)) and not (guiRadioButtonGetSelected(changeCrimRadio)) and not (guiRadioButtonGetSelected(changeCivRadio)) then return false end
		if (guiRadioButtonGetSelected(changeLawRadio)) then
			returnType = "Law"
		elseif (guiRadioButtonGetSelected(changeCivRadio)) then
			returnType = "Civilian"
		elseif (guiRadioButtonGetSelected(changeCrimRadio)) then
			returnType = "Criminal"
		end
		triggerServerEvent("AURgroups.changeTheType", localPlayer, localPlayer, returnType)
		closeAllGUIs()
	end
end
addEventHandler("onClientGUIClick", root, changeTheType)

function changeTheName()
	if (source == confirmGroupName) then
		if not (string.lower(guiGetText(changeAccEdit)) == string.lower(exports.server:getPlayerAccountName(localPlayer))) then return false end
		local newName = guiGetText(changeGroupEdit)
		if (newName == "") then return false end
		triggerServerEvent("AURgroups.changeTheName", localPlayer, localPlayer, newName)
		closeAllGUIs()
	end
end
addEventHandler("onClientGUIClick", root, changeTheName)

function setPickerColor(element, hex, r, g, b)
	if (element == "SAMgroups") then
		guiSetText(rEdit, r)
		guiSetText(gEdit, g)
		guiSetText(bEdit, b)
	end
end
addEventHandler("onColorPickerOK", root, setPickerColor)

function saveColor()
	if (source == setTurfBtn) then
		local r = guiGetText(rEdit)
		local g = guiGetText(gEdit)
		local b = guiGetText(bEdit)
		if not (tonumber(r)) then return false end
		if not (tonumber(g)) then return false end
		if not (tonumber(b)) then return false end
		local r = tonumber(r)
		local g = tonumber(g)
		local b = tonumber(b)
		if (r < 0) or (r > 255) or (g < 0) or (g > 255) or (b < 0) or (b > 255) then return false end
		triggerServerEvent("AURgroups.saveColor", localPlayer, localPlayer, r, g, b)
		closeAllGUIs()
	end
end
addEventHandler("onClientGUIClick", root, saveColor)

function addPlayerBlacklist()
	if (source == addBlacklist) then
		local accName = guiGetText(bacc)
		if (accName == "") then return false end
		local name = guiGetText(bname)
		if (name == "") then return false end
		local reason = guiGetText(breason)
		if (reason == "") then return false end
		--[[if not (guiRadioButtonGetSelected(radio1)) and not (guiRadioButtonGetSelected(radio2)) and not (guiRadioButtonGetSelected(radio3)) and not (guiRadioButtonGetSelected(radio4)) and not (guiRadioButtonGetSelected(radio5)) then return false end
		if (guiRadioButtonGetSelected(radio1)) then
			blacklistLevelAdded = 1
			outputChatBox(blacklistLevelAdded)
		end
		if (guiRadioButtonGetSelected(radio1)) then
			blacklistLevelAdded = 2
			outputChatBox(blacklistLevelAdded)
		end
		if (guiRadioButtonGetSelected(radio1)) then
			blacklistLevelAdded = 3
			outputChatBox(blacklistLevelAdded)
		end
		if (guiRadioButtonGetSelected(radio1)) then
			blacklistLevelAdded = 4
			outputChatBox(blacklistLevelAdded)
		end
		if (guiRadioButtonGetSelected(radio1)) then
			blacklistLevelAdded = 5
			outputChatBox(blacklistLevelAdded)
		end]]
		for i=1,#radio do
			if (guiRadioButtonGetSelected(radio[i])) then
				triggerServerEvent("AURgroups.addPlayerBlacklist", localPlayer, localPlayer, accName, name, reason, i)
			end
		end
		closeAllGUIs()
	end
end
addEventHandler("onClientGUIClick", root, addPlayerBlacklist)
	
function removePlayerBlacklist()
	if (source == removeBlacklist) then
		local name = guiGridListGetItemText(blacklistGrid, guiGridListGetSelectedItem(blacklistGrid), 1)
		if (guiGridListGetSelectedItem(blacklistGrid) ~= -1) then
			triggerServerEvent("AURgroups.removePlayerBlacklist", localPlayer, localPlayer, name)
			closeAllGUIs()
		end
	end
end
addEventHandler("onClientGUIClick", root, removePlayerBlacklist)

function kickTheMember()
	if (source == confirmKickMember) then
		local kickReason = guiGetText(kickReasonEdit)
		if (kickReason == "") then return false end
		local accName = guiGridListGetItemText(settingsGrid, guiGridListGetSelectedItem(settingsGrid), 1)
		local rankName = guiGridListGetItemText(settingsGrid, guiGridListGetSelectedItem(settingsGrid), 2)
		if (guiGridListGetSelectedItem(settingsGrid) ~= -1) and (rankName ~= "Founder") then
			triggerServerEvent("AURgroups.kickMember", localPlayer, localPlayer, reason, accName)
			closeAllGUIs()
		end
	end		
end	
addEventHandler("onClientGUIClick", root, kickTheMember)

function upgradeTheGroup()
	if (source == upgradeGrp) then
		triggerServerEvent("AURgroups.upgradeGroup", localPlayer, localPlayer)
		closeAllGUIs()
	end
end
addEventHandler("onClientGUIClick", root, upgradeTheGroup)

function turnGroupChat()
	if (source == groupChatCheck) then
		local check = guiCheckBoxGetSelected(groupChatCheck)
		print(check)
		triggerServerEvent("AURgroups.turnGroupChat", localPlayer, localPlayer, check)
	end
end
addEventHandler("onClientGUIClick", root, turnGroupChat)