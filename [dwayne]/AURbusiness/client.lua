local screenWidth, screenHeight = guiGetScreenSize()
local screenW,screenH=guiGetScreenSize()
local client = getLocalPlayer()
local nickToPlayer = {}

local rank_powers = {
	[1] = {"kick", "Kick member"},
	[2] = {"invite", "Invite player"},
	[3] = {"log", "View Business log"},
	[4] = {"setrank", "Set member rank"},
	[5] = {"rankManage", "Rank management"},
	[6] = {"withdraw", "Business bank withdraw"},
	[7] = {"cleanBusinessLog", "Clear log"},
	[8] = {"delrank", "Delete rank"},
	[9] = {"addrank", "Add rank"},
	[10] = {"assign", "Assign Task"},
	[11] = {"delBusiness", "Delete business"},
	[12] = {"accesspanel", "Access to office computer"},
}


panels = {
    tab = {},
    tabpanel = {},
    label = {},
    button = {},
    window = {},
    edit = {},
    gridlist = {}
}
pa = {
    checkbox = {},
    button = {},
    label = {}
}
panels.window[1] = guiCreateWindow(143, 113, 549, 398, "AUR ~ Business", false)
guiWindowSetSizable(panels.window[1], false)
guiSetAlpha(panels.window[1], 1.00)
guiSetVisible(panels.window[1],false)
panels.tabpanel[1] = guiCreateTabPanel(9, 24, 530, 364, false, panels.window[1])

panels.tab[2] = guiCreateTab("Main", panels.tabpanel[1])

panels.button[1] = guiCreateButton(6, 15, 150, 31, "Create Business (250k)", false, panels.tab[2])
guiSetProperty(panels.button[1], "NormalTextColour", "FFAAAAAA")
panels.edit[1] = guiCreateEdit(169, 15, 351, 31, "", false, panels.tab[2])
guiEditSetMaxLength(panels.edit[1],24)
panels.label[1] = guiCreateLabel(5, 54, 515, 15, "--------------------------------------------------------------------------------------------------------------------------------------------------", false, panels.tab[2])
panels.label[2] = guiCreateLabel(5, 79, 113, 17, "Your current group :", false, panels.tab[2])
guiSetFont(panels.label[2], "default-bold-small")
panels.label[3] = guiCreateLabel(146, 79, 158, 18, "None", false, panels.tab[2])
panels.label[4] = guiCreateLabel(5, 144, 132, 22, "Your current Business :", false, panels.tab[2])
guiSetFont(panels.label[4], "default-bold-small")
panels.label[5] = guiCreateLabel(147, 144, 158, 18, "None", false, panels.tab[2])
panels.label[6] = guiCreateLabel(5, 208, 132, 21, "Business bank balance :", false, panels.tab[2])
guiSetFont(panels.label[6], "default-bold-small")
panels.label[7] = guiCreateLabel(147, 208, 158, 18, "None", false, panels.tab[2])
panels.label[8] = guiCreateLabel(6, 107, 112, 18, "Your group rank :", false, panels.tab[2])
guiSetFont(panels.label[8], "default-bold-small")
panels.label[9] = guiCreateLabel(147, 107, 134, 18, "None", false, panels.tab[2])
panels.label[11] = guiCreateLabel(6, 176, 113, 15, "Your business rank :", false, panels.tab[2])
guiSetFont(panels.label[11], "default-bold-small")
panels.label[12] = guiCreateLabel(147, 176, 134, 18, "None", false, panels.tab[2])
pa.label[1] = guiCreateLabel(5, 270, 515, 15, "--------------------------------------------------------------------------------------------------------------------------------------------------", false, panels.tab[2])
pa.button[1] = guiCreateButton(10, 295, 157, 30, "Leave business", false, panels.tab[2])
guiSetProperty(pa.button[1], "NormalTextColour", "FFAAAAAA")
pa.label[2] = guiCreateLabel(6, 239, 132, 21, "Date created :", false, panels.tab[2])
guiSetFont(pa.label[2], "default-bold-small")
pa.label[3] = guiCreateLabel(147, 239, 158, 18, "None", false, panels.tab[2])
pa.checkbox[1] = guiCreateCheckBox(189, 296, 224, 29, "Enable blips for business members", false, false, panels.tab[2])
guiSetFont(pa.checkbox[1], "default-bold-small")

panels.tab[10] = guiCreateTab("Members", panels.tabpanel[1])

panels.gridlist[6] = guiCreateGridList(7, 4, 516, 325, false, panels.tab[10])
guiGridListAddColumn(panels.gridlist[6], "Name", 0.3)
guiGridListAddColumn(panels.gridlist[6], "Account", 0.2)
guiGridListAddColumn(panels.gridlist[6], "Rank", 0.2)
guiGridListAddColumn(panels.gridlist[6], "Status", 0.2)

panels.tab[9] = guiCreateTab("Information", panels.tabpanel[1])
panels.label[100] = guiCreateLabel(6,6,115,16,"Business information:",false,panels.tab[9])
memo = guiCreateMemo(3,22,526,293,"",false,panels.tab[9])
memobutton = guiCreateButton(3,317,526,22,"Update Business information",false,panels.tab[9])

panels.tab[3] = guiCreateTab("Actions", panels.tabpanel[1])

panels.gridlist[1] = guiCreateGridList(7, 4, 240, 325, false, panels.tab[3])
guiGridListAddColumn(panels.gridlist[1], "Nick (Accountname):", 0.90)
panels.button[2] = guiCreateButton(275, 254, 116, 29, "Manage Ranks", false, panels.tab[3])
guiSetProperty(panels.button[2], "NormalTextColour", "FFAAAAAA")
panels.button[3] = guiCreateButton(275, 41, 116, 29, "Set rank", false, panels.tab[3])
guiSetProperty(panels.button[3], "NormalTextColour", "FFAAAAAA")
panels.button[4] = guiCreateButton(401, 41, 116, 29, "Kick", false, panels.tab[3])
guiSetProperty(panels.button[4], "NormalTextColour", "FFAAAAAA")
panels.button[5] = guiCreateButton(275, 80, 116, 29, "Tasks & Incoments", false, panels.tab[3])
guiSetProperty(panels.button[5], "NormalTextColour", "FFAAAAAA")
panels.button[6] = guiCreateButton(401, 80, 116, 29, "Logs", false, panels.tab[3])
guiSetProperty(panels.button[6], "NormalTextColour", "FFAAAAAA")
panels.button[7] = guiCreateButton(401, 254, 116, 29, "Delete Business", false, panels.tab[3])
guiSetProperty(panels.button[7], "NormalTextColour", "FFAAAAAA")
panels.button[90] = guiCreateButton(275, 117, 116, 29, "Invite player", false, panels.tab[3])
guiSetProperty(panels.button[90], "NormalTextColour", "FFAAAAAA")
pa.label[4] = guiCreateLabel(252, 6, 13, 323, "|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n", false, panels.tab[3])
pa.label[5] = guiCreateLabel(274, 225, 243, 15, "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------", false, panels.tab[3])
--panels.button[91] = guiCreateButton(275, 290, 116, 29, "Set new President", false, panels.tab[3])
---guiSetProperty(panels.button[91], "NormalTextColour", "FFAAAAAA")
pa.label[6] = guiCreateLabel(274, 16, 243, 15, "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------", false, panels.tab[3])

panels.tab[4] = guiCreateTab("Banking", panels.tabpanel[1])

panels.gridlist[2] = guiCreateGridList(4, 8, 516, 222, false, panels.tab[4])
guiGridListAddColumn(panels.gridlist[2], "Date", 0.5)
guiGridListAddColumn(panels.gridlist[2], "Transaction", 0.5)
panels.edit[2] = guiCreateEdit(172, 288, 171, 27, "", false, panels.tab[4])
panels.button[8] = guiCreateButton(20, 288, 130, 27, "Deposit", false, panels.tab[4])
guiSetProperty(panels.button[8], "NormalTextColour", "FFAAAAAA")
panels.button[9] = guiCreateButton(365, 288, 130, 27, "Withdraw", false, panels.tab[4])
guiSetProperty(panels.button[9], "NormalTextColour", "FFAAAAAA")
panels.label[21] = guiCreateLabel(84, 247, 337, 25, "Current balance: $0", false, panels.tab[4])
guiSetFont(panels.label[21], "default-bold-small")
guiLabelSetHorizontalAlign(panels.label[21], "center", false)

panels.tab[7] = guiCreateTab("Invites", panels.tabpanel[1])

panels.label[90] = guiCreateLabel(7,7,394,16,"Business invites:",false,panels.tab[7])
panels.gridlist[5] = guiCreateGridList(4,24,523,272,false,panels.tab[7])
panels.button[20] = guiCreateButton(4,305,260,34,"Accept business invite",false,panels.tab[7])
panels.button[50] = guiCreateButton(267,305,260,34,"Delete business invite",false,panels.tab[7])
guiGridListAddColumn(panels.gridlist[5], "Business name", 0.5)
guiGridListAddColumn(panels.gridlist[5], "Invited by", 0.4)

panels.tab[5] = guiCreateTab("Lists", panels.tabpanel[1])

panels.gridlist[3] = guiCreateGridList(5, 5, 519, 324, false, panels.tab[5])
guiGridListAddColumn(panels.gridlist[3], "Business name", 0.5)
guiGridListAddColumn(panels.gridlist[3], "President", 0.4)


panels.tab[8] = guiCreateTab("Send money", panels.tabpanel[1])
panels.gridlist[9] = guiCreateGridList(5, 5, 319, 324, false, panels.tab[8])
guiGridListAddColumn(panels.gridlist[9], "Business name", 0.5)
guiGridListAddColumn(panels.gridlist[9], "Total Cash", 0.4)
panels.edit[100] = guiCreateEdit(360,80,134,28,"",false,panels.tab[8])
panels.button[100] = guiCreateButton(360,120,134,28,"Send money",false,panels.tab[8])
panels.label[100] = guiCreateLabel(360, 30, 302, 18, "Your cash: $0", false,panels.tab[8])
guiSetFont(panels.label[100], "default-bold-small")

panels.window[2] = guiCreateWindow(340,333,291,434,"Invite a new player",false)
guiWindowSetSizable(panels.window[2], false)
guiSetAlpha(panels.window[2], 1.00)
guiSetVisible(panels.window[2],false)
---panels.edit[90] = guiCreateEdit(9,24,273,24,"",false,panels.window[2])
panels.gridlist[4] = guiCreateGridList(9,45,272,348,false,panels.window[2])
panels.button[10] = guiCreateButton(9,401,134,24,"Invite player",false,panels.window[2])
panels.button[92] = guiCreateButton(146,401,134,24,"Close window",false,panels.window[2])
guiGridListAddColumn(panels.gridlist[4], "Nick name", 0.4)
guiGridListAddColumn(panels.gridlist[4], "Group name", 0.5)


logs = {
    gridlist = {},
    window = {},
    button = {}
}
logs.window[1] = guiCreateWindow(166, 175, 479, 219, "AUR ~ Business Logs", false)
guiWindowSetSizable(logs.window[1], false)
guiSetVisible(logs.window[1],false)
logs.gridlist[1] = guiCreateGridList(9, 22, 315, 184, false, logs.window[1])
guiGridListAddColumn(logs.gridlist[1], "Log", 0.9)
logs.button[1] = guiCreateButton(334, 67, 125, 30, "Clear", false, logs.window[1])
logs.button[2] = guiCreateButton(334, 131, 125, 30, "Close", false, logs.window[1])


cl = {
    button = {},
    window = {},
	label = {}
}

cl.window[1] = guiCreateWindow(166, 175, 479, 219, "AUR ~ Delete Business", false)
guiWindowSetSizable(cl.window[1], false)
guiSetVisible(cl.window[1],false)
cl.label[1] = guiCreateLabel(80, 60, 315, 184, "Are you sure you want to delete your Business?", false, cl.window[1])
guiSetFont(cl.label[1], "default-bold-small")
guiLabelSetColor(cl.label[1], 255, 255, 0)
guiLabelSetHorizontalAlign(cl.label[1], "center", false)
cl.button[1] = guiCreateButton(20, 140, 125, 30, "Yes", false, cl.window[1])
cl.button[2] = guiCreateButton(334, 140, 125, 30, "No!", false, cl.window[1])


rnk = {
    button = {},
    window = {},
    grid = {}
}
rnk.window[1] = guiCreateWindow(57, 182, 698, 229, "AUR ~ Ranks mangements", false)
guiWindowSetSizable(rnk.window[1], false)
guiSetVisible(rnk.window[1],false)
rnk.grid[1] = guiCreateGridList(10, 26, 251, 194, false, rnk.window[1])
guiGridListAddColumn(rnk.grid[1], "Rank name", 0.9)
rnk.grid[2] = guiCreateGridList(431, 28, 253, 192, false, rnk.window[1])
guiGridListAddColumn(rnk.grid[2], "Access name", 0.9)
rnk.button[1] = guiCreateButton(274, 34, 140, 33, "Add rank", false, rnk.window[1])
rnk.button[2] = guiCreateButton(274, 77, 140, 33, "Remove rank", false, rnk.window[1])
rnk.button[3] = guiCreateButton(274, 161, 140, 31, "Close", false, rnk.window[1])


rnkadd = {
    button = {},
    window = {},
    grid = {},
	label = {},
    edit = {}
}
rnkadd.window[1] = guiCreateWindow(142, 198, 469, 230, "AUR ~ Ranks", false)
guiWindowSetSizable(rnkadd.window[1], false)
guiSetVisible(rnkadd.window[1],false)
rnkadd.grid[1] = guiCreateGridList(207, 25, 251, 194, false, rnkadd.window[1])
guiGridListAddColumn(rnkadd.grid[1], "Rank name", 0.9)
rnkadd.button[1] = guiCreateButton(30, 135, 140, 33, "Add rank", false, rnkadd.window[1])
rnkadd.button[2] = guiCreateButton(30, 178, 140, 31, "Close", false, rnkadd.window[1])
rnkadd.edit[1] = guiCreateEdit(30, 82, 140, 38, "", false, rnkadd.window[1])
rnkadd.label[1] = guiCreateLabel(30, 31, 140, 41, "Insert New Rank", false, rnkadd.window[1])
guiSetFont(rnkadd.label[1], "default-bold-small")
guiLabelSetHorizontalAlign(rnkadd.label[1], "center", false)
for index, text in ipairs(rank_powers) do
	local row = guiGridListAddRow(rnkadd.grid[1])
	guiGridListSetItemText(rnkadd.grid[1],row,1,text[2],false,false)
	guiGridListSetItemData(rnkadd.grid[1],row,1,text[1])
	guiGridListSetItemColor(rnkadd.grid[1],row,1,255,0,0)
end


rnkset = {
    button = {},
    window = {},
    grid = {}
}
rnkset.window[1] = guiCreateWindow(57, 182, 698, 229, "AUR ~ Set Ranks", false)
guiWindowSetSizable(rnkset.window[1], false)
guiSetVisible(rnkset.window[1],false)
rnkset.grid[1] = guiCreateGridList(10, 26, 251, 194, false, rnkset.window[1])
guiGridListAddColumn(rnkset.grid[1], "Rank name", 0.9)
rnkset.grid[2] = guiCreateGridList(431, 28, 253, 192, false, rnkset.window[1])
guiGridListAddColumn(rnkset.grid[2], "Access name", 0.9)
rnkset.button[1] = guiCreateButton(274, 34, 140, 33, "Apply rank", false, rnkset.window[1])
rnkset.button[2] = guiCreateButton(274, 161, 140, 31, "Close", false, rnkset.window[1])

msg = {
    button = {},
    window = {},
    memo = {},
    edit = {}
}
msg.window[1] = guiCreateWindow(77, 171, 662, 290, "AUR ~ Tasks", false)
guiWindowSetSizable(msg.window[1], false)
guiSetVisible(msg.window[1],false)
--da = guiCreateMemo(10, 26, 636, 213, "", false, msg.window[1])
--guiMemoSetReadOnly(da, true)
da = guiCreateGridList(10, 20, 655, 230,false,msg.window[1])
guiGridListAddColumn(da, "Name", 0.3)
guiGridListAddColumn(da, "Task", 0.4)
guiGridListAddColumn(da, "Date & Time", 0.2)
msg.edit[1] = guiCreateEdit(10, 250, 381, 30, "", false, msg.window[1])
msg.button[1] = guiCreateButton(396, 249, 124, 31, "Assign", false, msg.window[1])
msg.button[2] = guiCreateButton(528, 250, 124, 30, "Close", false, msg.window[1])

function removeL(element)
	local txts2 = guiGetText(element)
	local removed = string.gsub(txts2, "[^0-9]", "")
	if (removed ~= txts2) then
		guiSetText(element, removed)
	end
end

function centerWindow(center_window)
    local windowW,windowH=guiGetSize(center_window,false)
    local x,y = (screenW-windowW)/2,(screenH-windowH)/2
    guiSetPosition(center_window,x,y,false)
end

centerWindow(msg.window[1])
centerWindow(rnkset.window[1])
centerWindow(rnkadd.window[1])
centerWindow(rnk.window[1])
centerWindow(cl.window[1])
centerWindow(logs.window[1])
centerWindow(panels.window[2])
centerWindow(panels.window[1])

addEventHandler( "onClientGUIChanged",panels.edit[2], removeL)
addEventHandler( "onClientGUIChanged",panels.edit[100], removeL)
addEventHandler ( 'onClientGUIDoubleClick', root, function ( btn )
	if ( source == da ) then
		if guiGetEnabled(msg.button[1]) then
			local row, col = guiGridListGetSelectedItem ( da )
			if ( row ~= -1 and col ~= 0 ) then
				local msg = guiGridListGetItemText(da, guiGridListGetSelectedItem(da), 2)
				triggerServerEvent("businessRemoveTask",localPlayer,msg)
			end
		end
	end
end)

function getSelectedMaintenanceTabPlayer ()
	local theAccountName = nickToPlayer[guiGridListGetItemText ( panels.gridlist[1], guiGridListGetSelectedItem ( panels.gridlist[1] ), 1 )]
	local row, column = guiGridListGetSelectedItem ( panels.gridlist[1] )
	if ( theAccountName ) and ( tostring( row ) ~= "-1" ) then
		local thePlayer = exports.server:getPlayerFromAccountname ( theAccountName )
		if ( thePlayer ) and ( isElement( thePlayer ) ) then
			return thePlayer, theAccountName
		else
			return false, theAccountName
		end
	else
		return false, false
	end
end

bindKey("F9","down",
--addCommandHandler("bus",
function ()
--	if exports.server:getPlayerAccountName(localPlayer) == "iphone7" or exports.server:getPlayerAccountName(localPlayer) == "king_nadim" then
		doesPlayerInBusiness()
		if guiGetVisible(panels.window[1]) then
			guiSetVisible(panels.window[1], false)
			showCursor(false)
		else
			guiSetText( memo, "" )
			loadingpanel()
			exports.NGCdxmsg:createNewDxMessage("Business panel loading...",0,255,0)
		end
--	end
end)



function openpanel()
	guiSetVisible(msg.window[1],false)
	guiSetVisible(rnkset.window[1],false)
	guiSetVisible(rnkadd.window[1],false)
	guiSetVisible(rnk.window[1],false)
	guiSetVisible(cl.window[1],false)
	guiSetVisible(logs.window[1],false)
	guiSetVisible(panels.window[2],false)
	guiSetVisible(panels.window[1], true)
	showCursor(true)
	guiSetSelectedTab(panels.tabpanel[1],panels.tab[2])
	guiSetInputMode("no_binds_when_editing")
end

function doesPlayerInBusiness()
	if getClientBusiness() == "None" then

		guiSetEnabled(panels.tab[10],false)
		guiSetEnabled(panels.tab[9],false)
		guiSetEnabled(panels.tab[3],false)
		guiSetEnabled(panels.tab[4],false)
		guiSetEnabled(panels.tab[7],true)
		guiSetEnabled(panels.button[1],true)
	else
		guiSetEnabled(panels.button[1],false)
		guiSetEnabled(panels.tab[7],false)
		guiSetEnabled(panels.tab[3],true)
		guiSetEnabled(panels.tab[4],true)
		guiSetEnabled(panels.tab[10],true)
		guiSetEnabled(panels.tab[9],true)
	end
end

function loadingpanel()
	triggerServerEvent("getBusinessInfo",localPlayer,localPlayer)
	triggerServerEvent("getBusinessPayment",localPlayer,localPlayer)
	triggerServerEvent("getBusinessList",localPlayer,localPlayer)
	triggerServerEvent("getBankBalance",localPlayer,localPlayer)
	triggerServerEvent("getMemberList",localPlayer,localPlayer)
	triggerServerEvent("getTasks",localPlayer,localPlayer)
	triggerServerEvent("getInvites",localPlayer,localPlayer)
	triggerServerEvent("queryPanel",localPlayer,localPlayer)
	loadPlayers()

	guiSetText(panels.label[3],getElementData(localPlayer,"Group") or "None")
	guiSetText(panels.label[9],getElementData(localPlayer,"GroupRank") or "None")
	guiSetText(panels.label[5],getElementData(localPlayer,"Business") or "None")
	guiSetText(panels.label[12],getElementData(localPlayer,"Business rank") or "None")

end

function getClientBusiness()
	return tostring(getElementData(client,"Business"))
end

function loadPlayers()
	guiGridListClear(panels.gridlist[4])
	for index, player in ipairs(getElementsByType("player")) do
		if getElementData(player,"Business") == "None" then
		local row = guiGridListAddRow(panels.gridlist[4])
		guiGridListSetItemText(panels.gridlist[4], row, 1, tostring(getPlayerName(player)), false, true)
		guiGridListSetItemText(panels.gridlist[4], row, 2, getElementData(player,"Group") or "None", false, true)
		guiGridListSetItemColor(panels.gridlist[4], row, 1, getPlayerNametagColor(player))
		end
	end
end
addEventHandler("onClientPlayerQuit",root,loadPlayers)
addEventHandler("onClientPlayerChangeNick",root,loadPlayers)


addEvent("returnBusinessInfo",true)
addEventHandler("returnBusinessInfo",root,function(myTable)
	for k,v in pairs(myTable) do
		guiSetText(memo,v["Business_info"] or "")
	end
end)





addEvent("returnMemberList",true)
addEventHandler("returnMemberList",root,
function (memberList)
guiGridListClear(panels.gridlist[1])
guiGridListClear(panels.gridlist[6])
	if memberList then
		for index, member in pairs(memberList) do
			if member then
				local row1 = guiGridListAddRow(panels.gridlist[1])
				local row = guiGridListAddRow(panels.gridlist[6])
				guiGridListSetItemData(panels.gridlist[1],row1,1,tostring(member["member_rank"]))
				guiGridListSetItemText(panels.gridlist[1],row1,1,member["member_account"], false, false )
				guiGridListSetItemText(panels.gridlist[6],row,1,member["member_account"], false, false )
				guiGridListSetItemText(panels.gridlist[6],row,2,tostring(member["member_account"]),false,false)
				guiGridListSetItemText(panels.gridlist[6],row,3,tostring(member["member_rank"]),false,false)
				guiGridListSetItemText(panels.gridlist[6],row,4,tostring(member["member_status"]),false,false)
				nickToPlayer[member["member_account"]]=member["member_account"]
				local playerElement = exports.server:getPlayerFromAccountname ( member["member_account"] )
				if ( playerElement ) and ( isElement( playerElement ) ) then
					guiGridListSetItemText( panels.gridlist[1], row1, 1, getPlayerName(playerElement).." ("..member["member_account"]..")", false, false )
					guiGridListSetItemColor(panels.gridlist[1], row1, 1, 0,255,0)
					nickToPlayer[getPlayerName(playerElement).." ("..member["member_account"]..")"]=member["member_account"]
					guiGridListSetItemText( panels.gridlist[6], row, 1, getPlayerName(playerElement), false, false )
					guiGridListSetItemColor(panels.gridlist[6], row, 1, 0,255,0)
					guiGridListSetItemColor(panels.gridlist[6], row, 2, 0,255,0)
					guiGridListSetItemColor(panels.gridlist[6], row, 3, 0,255,0)
					guiGridListSetItemColor(panels.gridlist[6], row, 4, 0,255,0)
				else
					guiGridListSetItemColor(panels.gridlist[1], row1, 1, 250,0,0)
					guiGridListSetItemColor(panels.gridlist[6], row, 1, 250,0,0)
				end
			end
		end
	end
end)

addEvent("returnInvites",true)
addEventHandler("returnInvites",root,function(invitesTable)
	if ( invitesTable ) then
		guiGridListClear(panels.gridlist[5])
		for i=1,#invitesTable do
			local row2 = guiGridListAddRow ( panels.gridlist[5] )
			guiGridListSetItemText( panels.gridlist[5], row2, 1, invitesTable[i].Business_name, false, false )
			guiGridListSetItemText( panels.gridlist[5], row2, 2, invitesTable[i].invitedby, false, false )
			guiGridListSetItemData( panels.gridlist[5], row2, 1, invitesTable[i].Business_name )
		end
	end
end)

addEvent("returnQuery",true)
addEventHandler("returnQuery",root,function(v1,v2,v3,v4,v5,v6,v7,v8,v9,v10,v11)
	if v1 then
		guiSetEnabled(panels.button[90],true)
	else
		guiSetEnabled(panels.button[90],false)
	end
	if v2 then
		guiSetEnabled(panels.button[4],true)
	else
		guiSetEnabled(panels.button[4],false)
	end
	if v3 then
		guiSetEnabled(panels.button[6],true)
	else
		guiSetEnabled(panels.button[6],false)
	end
	if v4 then
		guiSetEnabled(panels.button[3],true)
	else
		guiSetEnabled(panels.button[3],false)
	end
	if v5 then
		guiSetEnabled(panels.button[2],true)
	else
		guiSetEnabled(panels.button[2],false)
	end
	if v6 then
		guiSetEnabled(panels.button[9],true)
	else
		guiSetEnabled(panels.button[9],false)
	end
	if v7 then
		guiSetEnabled(logs.button[1],true)
	else
		guiSetEnabled(logs.button[1],false)
	end
	if v8 then
		guiSetEnabled(rnk.button[2],true)
	else
		guiSetEnabled(rnk.button[2],false)
	end
	if v9 then
		guiSetEnabled(panels.button[7],true)
	else
		guiSetEnabled(panels.button[7],false)
	end
	if v10 then
		guiSetEnabled(rnk.button[1],true)
	else
		guiSetEnabled(rnk.button[1],false)
	end
	if v11 then
		guiSetEnabled(msg.button[1],true)
		guiSetEnabled(memobutton,true)
	else
		guiSetEnabled(memobutton,false)
		guiSetEnabled(msg.button[1],false)
	end
	--- President check
	if getElementData(localPlayer,"Business rank") == "President" then
		guiSetEnabled(pa.button[1],false)
		---guiSetEnabled(panels.button[91],true)
	else
		guiSetEnabled(pa.button[1],true)
		---guiSetEnabled(panels.button[91],false)
	end
	if getElementData(localPlayer,"Business") == "None" then
		guiSetEnabled(pa.button[1],false)
		---guiSetEnabled(panels.button[91],false)
	end
	if getElementData(localPlayer,"Business") ~= "None" or getElementData(localPlayer,"Business") ~= false then
		openpanel()
	end
end)

addEvent("returnBusinessPayment",true)
addEventHandler("returnBusinessPayment",root,
function (tbl)
	guiGridListClear(panels.gridlist[9])
	for k, v in pairs(tbl) do
		local row = guiGridListAddRow(panels.gridlist[9])
		guiGridListSetItemText(panels.gridlist[9],row,1,v[2],false,true)
		guiGridListSetItemText(panels.gridlist[9],row,2,"$"..cvtNumber(v[1]),false,true)
	end
	triggerServerEvent("getBankBalance",localPlayer,localPlayer)
end)

addEvent("returnBusinessList",true)
addEventHandler("returnBusinessList",root,
function (BusinessList)
	if BusinessList then
		guiGridListClear(panels.gridlist[3])
		for index, Business in pairs(BusinessList) do
			if Business then
				local row = guiGridListAddRow(panels.gridlist[3])
				guiGridListSetItemText(panels.gridlist[3],row,1,tostring(Business["Business_name"]),false,true)
				guiGridListSetItemText(panels.gridlist[3],row,2,tostring(Business["Business_leader"]),false,true)
			end
		end
	end
end)



addEvent("returnBankBalance",true)
addEventHandler("returnBankBalance",root,
function (balance,mytable,dat)
	if balance then
		guiSetText(panels.label[7],"$ "..cvtNumber(balance) or "None")
		guiSetText(panels.label[21],"$ "..cvtNumber(balance) or "None")
	else
		guiSetText(panels.label[7],"None")
		guiSetText(panels.label[21],"None")
	end
	if dat then
		guiSetText(pa.label[3],dat)
	else
		guiSetText(pa.label[3],"None")
	end
	guiGridListClear(panels.gridlist[2])
	for index, v in pairs(mytable) do
		local row = guiGridListAddRow(panels.gridlist[2])
		guiGridListSetItemText(panels.gridlist[2],row,1,v.datum,false,true)
		guiGridListSetItemText(panels.gridlist[2],row,2,v.transaction,false,true)
	end
end)


addEvent("returnLog",true)
addEventHandler("returnLog",root,
function (BusinessLog)
	guiGridListClear(logs.gridlist[1])
	for index, logM in pairs(BusinessLog) do
		local row = guiGridListAddRow(logs.gridlist[1])
		local info = split(logM["log_message"],string.byte(";"))
		local logMessage = info[1]
		guiGridListSetItemText(logs.gridlist[1],row,1,tostring(logMessage),false,false)
	end
	guiSetVisible(panels.window[1],false)
	guiSetVisible(logs.window[1],true)
end)


addEvent("returnRankList",true)
addEventHandler("returnRankList",root,
function (rankList)
	if guiGetVisible(rnk.window[1]) then
		guiGridListClear(rnk.grid[1])
		for index, rank in pairs(rankList) do
			local row = guiGridListAddRow(rnk.grid[1])
			guiGridListSetItemText(rnk.grid[1],row,1,tostring(rank["rank_name"]),false,false)
			guiGridListSetItemData(rnk.grid[1],row,1,tostring(rank["rank_powers"]))
		end
	end
	if guiGetVisible(rnkset.window[1]) then
		guiGridListClear(rnkset.grid[1])
		for index, rank in pairs(rankList) do
			local row = guiGridListAddRow(rnkset.grid[1])
			guiGridListSetItemText(rnkset.grid[1],row,1,tostring(rank["rank_name"]),false,false)
			guiGridListSetItemData(rnkset.grid[1],row,1,tostring(rank["rank_powers"]))
		end
	end
end)


addEvent("returnTasks",true)
addEventHandler("returnTasks",root,
function (BusinessTasks)
	guiGridListClear(da)
	if BusinessTasks then
		for index, msg in pairs(BusinessTasks) do
			if msg then
				local info = split(msg["message"],string.byte(","))
				if info[1] == nil then info[1] = "" end
				if info[2] == nil then info[2] = "" end
				if info[3] == nil then info[3] = "" end
				if info[4] == nil then info[4] = "" end
				local message = info[1] ..": ".. info[2] .." [".. info[3] .." - ".. info[4] .."]"
				local row = guiGridListAddRow(da)
				guiGridListSetItemText(da,row,1,info[1],false,false)
				guiGridListSetItemText(da,row,2,info[2],false,false)
				guiGridListSetItemText(da,row,3,info[3].."("..info[4]..")",false,false)
			end
		end
	end
end)
whowas = {}
addEventHandler("onClientGUIClick",root,function()
	if source == panels.button[1] then
		if whowas[source] == true then
			exports.NGCdxmsg:createNewDxMessage("Please wait few seconds before you spam clicks",255,0,0)
			return false
		end
		whowas[source] = true
		setTimer(function(d) whowas[d] = false end,3000,1,source)
		local BusinessName = guiGetText(panels.edit[1])
		if BusinessName == "" or BusinessName:len() < 4 then exports.NGCdxmsg:createNewDxMessage("You must write a Business name & min chars 4",255,0,0) return end
		if BusinessName:len() >= 20 then exports.NGCdxmsg:createNewDxMessage("You can't create +25 chars of business name",255,0,0) return end
		guiSetVisible(panels.window[1], false)
		showCursor(false)
		triggerServerEvent("createBusiness",localPlayer,localPlayer,BusinessName)
	elseif source == memobutton then
		if whowas[source] == true then
			exports.NGCdxmsg:createNewDxMessage("Please wait few seconds before you spam clicks",255,0,0)
			return false
		end
		whowas[source] = true
		setTimer(function(d) whowas[d] = false end,3000,1,source)
		local text = guiGetText(memo)
		if text:len() > 1500 then
			exports.NGCdxmsg:createNewDxMessage("Your info has too much words (Max 500 words)",255,0,0)
			return false
		end
		triggerServerEvent("saveBusinessInfo",localPlayer,text)
	elseif source == panels.button[90] then
		if whowas[source] == true then
			exports.NGCdxmsg:createNewDxMessage("Please wait few seconds before you spam clicks",255,0,0)
			return false
		end
		whowas[source] = true
		setTimer(function(d) whowas[d] = false end,3000,1,source)
		loadPlayers()
		guiSetVisible(panels.window[2],true)
		guiBringToFront( panels.window[2] )
		guiSetProperty( panels.window[2], "AlwaysOnTop", "True" )
	elseif source == pa.button[1] then
		if whowas[source] == true then
			exports.NGCdxmsg:createNewDxMessage("Please wait few seconds before you spam clicks",255,0,0)
			return false
		end
		whowas[source] = true
		setTimer(function(d) whowas[d] = false end,3000,1,source)
		triggerServerEvent("leaveBusiness",localPlayer,localPlayer)
		guiSetVisible(panels.window[1], false)
			showCursor(false)
	--[[elseif source == panels.button[91] then
		if whowas[source] == true then
			exports.NGCdxmsg:createNewDxMessage("Please wait few seconds before you spam clicks",255,0,0)
			return false
		end
		whowas[source] = true
		setTimer(function(d) whowas[d] = false end,3000,1,source)
		local thePlayer,account = getSelectedMaintenanceTabPlayer()
		if thePlayer and isElement(thePlayer) then
			triggerServerEvent("giveBusinessPlayer",localPlayer,thePlayer)
		elseif account then
			triggerServerEvent("giveBusinessAccount",localPlayer,account)
		else
			exports.NGCdxmsg:createNewDxMessage("You didn't select a player",255,0,0)
		end]]
	elseif source == panels.button[92] then
		if whowas[source] == true then
			exports.NGCdxmsg:createNewDxMessage("Please wait few seconds before you spam clicks",255,0,0)
			return false
		end
		whowas[source] = true
		setTimer(function(d) whowas[d] = false end,3000,1,source)
		guiSetVisible(panels.window[2],false)
	elseif source == panels.button[10] then
		if whowas[source] == true then
			exports.NGCdxmsg:createNewDxMessage("Please wait few seconds before you spam clicks",255,0,0)
			return false
		end
		whowas[source] = true
		setTimer(function(d) whowas[d] = false end,3000,1,source)
		local row,col = guiGridListGetSelectedItem(panels.gridlist[4])
		if row and col and row ~= -1 and col ~= -1 then
			local playerName = guiGridListGetItemText(panels.gridlist[4], row, 1)
			local thePlayer = getPlayerFromName(playerName)
			if not thePlayer then loadPlayers() return end
			if thePlayer == client then exports.NGCdxmsg:createNewDxMessage("You can't invite yourself",255,0,0) return end
			if getClientBusiness() == "None" then return end
			if getElementData(thePlayer,"Business") == "None" then
				triggerServerEvent("invitePlayer",localPlayer,localPlayer,thePlayer)
			else
				exports.NGCdxmsg:createNewDxMessage("This player already signed with another business",255,0,0)
			end
		end
	elseif source == panels.button[8] then
		if whowas[source] == true then
			exports.NGCdxmsg:createNewDxMessage("Please wait few seconds before you spam clicks",255,0,0)
			return false
		end
		whowas[source] = true
		setTimer(function(d) whowas[d] = false end,3000,1,source)
		local amount = guiGetText(panels.edit[2])
		if amount == "" then return end
		if ( string.match(amount,'^%d+$') ) then
			if tonumber(amount) and tonumber(amount) > 0 then
				if ( string.len( tostring( amount ) ) ) < 8  then
					local amount = tonumber(amount)
					triggerServerEvent("bbDeposit",localPlayer,localPlayer,amount)
				else
				exports.NGCdxmsg:createNewDxMessage( "You cannot spam this with useless numbers!", 255, 0, 0 )
				end
			end
		end
	elseif source == panels.button[5] then
		if whowas[source] == true then
			exports.NGCdxmsg:createNewDxMessage("Please wait few seconds before you spam clicks",255,0,0)
			return false
		end
		whowas[source] = true
		setTimer(function(d) whowas[d] = false end,3000,1,source)
		guiSetVisible(msg.window[1],true)
		guiSetVisible(panels.window[1],false)
	elseif source == panels.button[20] then
		if whowas[source] == true then
			exports.NGCdxmsg:createNewDxMessage("Please wait few seconds before you spam clicks",255,0,0)
			return false
		end
		whowas[source] = true
		setTimer(function(d) whowas[d] = false end,3000,1,source)
		local row,col = guiGridListGetSelectedItem(panels.gridlist[5])
		if row and col and row ~= -1 and col ~= -1 then
			local name = guiGridListGetItemText(panels.gridlist[5], row, 1)
			triggerServerEvent("acceptInvite",localPlayer,localPlayer,name)
			guiGridListClear(panels.gridlist[5])
		end
	elseif source == panels.button[50] then
		if whowas[source] == true then
			exports.NGCdxmsg:createNewDxMessage("Please wait few seconds before you spam clicks",255,0,0)
			return false
		end
		whowas[source] = true
		setTimer(function(d) whowas[d] = false end,3000,1,source)
		local row,col = guiGridListGetSelectedItem(panels.gridlist[5])
		if row and col and row ~= -1 and col ~= -1 then
			local name = guiGridListGetItemText(panels.gridlist[5], row, 1)
			triggerServerEvent("declineInvite",localPlayer,localPlayer,name)
			guiGridListClear(panels.gridlist[5])
			triggerServerEvent("getInvites",localPlayer,localPlayer)
		end
	elseif source == panels.button[9] then
		if whowas[source] == true then
			exports.NGCdxmsg:createNewDxMessage("Please wait few seconds before you spam clicks",255,0,0)
			return false
		end
		whowas[source] = true
		setTimer(function(d) whowas[d] = false end,3000,1,source)
		local amount = guiGetText(panels.edit[2])
		if amount == "" then return end
		if ( string.match(amount,'^%d+$') ) then
			if tonumber(amount) and tonumber(amount) > 0 then
				if ( string.len( tostring( amount ) ) ) < 8  then
					local amount = tonumber(amount)
					triggerServerEvent("bbWithdraw",localPlayer,localPlayer,amount)
				else
					exports.NGCdxmsg:createNewDxMessage( "You cannot spam this with useless numbers!", 255, 0, 0 )
				end
			end
		end
	elseif source == msg.button[1] then
		if whowas[source] == true then
			exports.NGCdxmsg:createNewDxMessage("Please wait few seconds before you spam clicks",255,0,0)
			return false
		end
		whowas[source] = true
		setTimer(function(d) whowas[d] = false end,3000,1,source)
		local text = guiGetText(msg.edit[1])
		if text == "" then return end
		triggerServerEvent("sendTask",localPlayer,localPlayer,text)
	elseif source == msg.button[2] then
		if whowas[source] == true then
			exports.NGCdxmsg:createNewDxMessage("Please wait few seconds before you spam clicks",255,0,0)
			return false
		end
		whowas[source] = true
		setTimer(function(d) whowas[d] = false end,3000,1,source)
		guiSetVisible(msg.window[1],false)
		guiSetVisible(panels.window[1],true)
	elseif source == rnkset.button[1] then
		if whowas[source] == true then
			exports.NGCdxmsg:createNewDxMessage("Please wait few seconds before you spam clicks",255,0,0)
			return false
		end
		whowas[source] = true
		setTimer(function(d) whowas[d] = false end,3000,1,source)
		local row,col = guiGridListGetSelectedItem(rnkset.grid[1])
		local row2,col2 = guiGridListGetSelectedItem(panels.gridlist[1])
		if row and col and row ~= -1 and col ~= -1 then
			local rankName = guiGridListGetItemText(rnkset.grid[1], row, col)
			local thePlayer,account = getSelectedMaintenanceTabPlayer()
			triggerServerEvent("setPlayerBusinessRank",localPlayer,localPlayer,account,rankName)
			guiSetVisible(rnkset.window[1],false)
			guiSetVisible(panels.window[1],true)
		end
	elseif source == rnkset.button[2] then
		if whowas[source] == true then
			exports.NGCdxmsg:createNewDxMessage("Please wait few seconds before you spam clicks",255,0,0)
			return false
		end
		whowas[source] = true
		setTimer(function(d) whowas[d] = false end,3000,1,source)
		guiSetVisible(rnkset.window[1],false)
		guiSetVisible(panels.window[1],true)
	elseif source == rnkset.grid[1] then
		if whowas[source] == true then
			exports.NGCdxmsg:createNewDxMessage("Please wait few seconds before you spam clicks",255,0,0)
			return false
		end
		whowas[source] = true
		setTimer(function(d) whowas[d] = false end,3000,1,source)
		local row,col = guiGridListGetSelectedItem(rnkset.grid[1])
		if row and col and row ~= -1 and col ~= -1 then
			local data = guiGridListGetItemData(rnkset.grid[1], row, col)
			local info = split(data,string.byte(","))
			guiGridListClear(rnkset.grid[2])
			for i,v in pairs(info) do
				if rank_powers[i] then
					local row = guiGridListAddRow(rnkset.grid[2])
					guiGridListSetItemText(rnkset.grid[2],row,1,rank_powers[i][2],false,false)
					if info[i] == "true" then
						guiGridListSetItemColor(rnkset.grid[2],row,1,0,255,0)
					elseif info[i] == "false" then
						guiGridListSetItemColor(rnkset.grid[2],row,1,255,0,0)
					end
				end
			end
		else
			guiGridListClear(rnkset.grid[2])
		end
	elseif source == rnkadd.grid[1] then
		if whowas[source] == true then
			exports.NGCdxmsg:createNewDxMessage("Please wait few seconds before you spam clicks",255,0,0)
			return false
		end
		whowas[source] = true
		setTimer(function(d) whowas[d] = false end,3000,1,source)
		local row,col = guiGridListGetSelectedItem(rnkadd.grid[1])
		if row and col and row ~= -1 and col ~= -1 then
			local r, g, b = guiGridListGetItemColor(rnkadd.grid[1],row,1)
			if r == 255 and g == 0 and b == 0 then
				guiGridListSetItemColor(rnkadd.grid[1],row,1,0,255,0)
			elseif r == 0 and g == 255 and b == 0 then
				guiGridListSetItemColor(rnkadd.grid[1],row,1,255,0,0)
			end
		end
	elseif source == rnkadd.button[1] then
		if whowas[source] == true then
			exports.NGCdxmsg:createNewDxMessage("Please wait few seconds before you spam clicks",255,0,0)
			return false
		end
		whowas[source] = true
		setTimer(function(d) whowas[d] = false end,3000,1,source)
		local rankName = guiGetText(rnkadd.edit[1])
		if rankName == "" then return end
		if rankName:len() < 4 then exports.NGCdxmsg:createNewDxMessage("You can't create rank with less than 5 chars of rank name",255,0,0) return end
		if rankName:len() >= 15 then exports.NGCdxmsg:createNewDxMessage("You can't create rank with +15 chars of rank name",255,0,0) return end
		data = ""
		for i=0, guiGridListGetRowCount(rnkadd.grid[1]) do
			local r, g, b = guiGridListGetItemColor(rnkadd.grid[1],i,1)
			if r == 0 and g == 255 and b == 0 and tostring(guiGridListGetItemText(rnkadd.grid[1],i,1)) ~= "" then
				data = data .. ",true"
			else
				if tostring(guiGridListGetItemText(rnkadd.grid[1],i,1)) ~= "" then
					data = data .. ",false"
				end
			end
		end
		local data = string.gsub(data,",","",1)
		triggerServerEvent("addRank",localPlayer,localPlayer,rankName,data)
		guiSetVisible(rnkadd.window[1],false)
		guiSetVisible(rnk.window[1],true)
		triggerServerEvent("getRankList",localPlayer,localPlayer)
	elseif source == rnkadd.button[2] then
		if whowas[source] == true then
			exports.NGCdxmsg:createNewDxMessage("Please wait few seconds before you spam clicks",255,0,0)
			return false
		end
		whowas[source] = true
		setTimer(function(d) whowas[d] = false end,3000,1,source)
		guiSetVisible(rnk.window[1],true)
		guiSetVisible(rnkadd.window[1],false)
	elseif source == rnk.button[3] then
		if whowas[source] == true then
			exports.NGCdxmsg:createNewDxMessage("Please wait few seconds before you spam clicks",255,0,0)
			return false
		end
		whowas[source] = true
		setTimer(function(d) whowas[d] = false end,3000,1,source)
		guiSetVisible(panels.window[1],true)
		guiSetVisible(rnk.window[1],false)
	elseif source == rnk.button[2] then
		if whowas[source] == true then
			exports.NGCdxmsg:createNewDxMessage("Please wait few seconds before you spam clicks",255,0,0)
			return false
		end
		whowas[source] = true
		setTimer(function(d) whowas[d] = false end,3000,1,source)
		local row,col = guiGridListGetSelectedItem(rnk.grid[1])
		if row and col and row ~= -1 and col ~= -1 then
			local rankName = guiGridListGetItemText(rnk.grid[1], row, col)
			triggerServerEvent("deleteRank",localPlayer,localPlayer,rankName)
		end
	elseif source == rnk.button[1] then
		if whowas[source] == true then
			exports.NGCdxmsg:createNewDxMessage("Please wait few seconds before you spam clicks",255,0,0)
			return false
		end
		whowas[source] = true
		setTimer(function(d) whowas[d] = false end,3000,1,source)
		guiSetVisible(rnk.window[1],false)
		guiSetVisible(rnkadd.window[1],true)
	elseif source == rnk.grid[1] then
		if whowas[source] == true then
			exports.NGCdxmsg:createNewDxMessage("Please wait few seconds before you spam clicks",255,0,0)
			return false
		end
		whowas[source] = true
		setTimer(function(d) whowas[d] = false end,3000,1,source)
		local row,col = guiGridListGetSelectedItem(rnk.grid[1])
		if row and col and row ~= -1 and col ~= -1 then
			local data = guiGridListGetItemData(rnk.grid[1], row, col)
			local info = split(data,",")
			guiGridListClear(rnk.grid[2])
			for i,v in pairs(info) do
				if rank_powers[i] then
					local row = guiGridListAddRow(rnk.grid[2])
					guiGridListSetItemText(rnk.grid[2],row,1,rank_powers[i][2],false,false)
					if info[i] == "true" then
						guiGridListSetItemColor(rnk.grid[2],row,1,0,255,0)
					elseif info[i] == "false" then
						guiGridListSetItemColor(rnk.grid[2],row,1,255,0,0)
					end
				end
			end
		else
			guiGridListClear(rnk.grid[2])
		end
	elseif source == panels.button[4] then
		if whowas[source] == true then
			exports.NGCdxmsg:createNewDxMessage("Please wait few seconds before you spam clicks",255,0,0)
			return false
		end
		whowas[source] = true
		setTimer(function(d) whowas[d] = false end,3000,1,source)
		local row,col = guiGridListGetSelectedItem(panels.gridlist[1])
		if row and col and row ~= -1 and col ~= -1 then
			local thePlayer,account = getSelectedMaintenanceTabPlayer()
			triggerServerEvent("kickMember",localPlayer,localPlayer,account)
		end
	elseif source == panels.button[3] then
		if whowas[source] == true then
			exports.NGCdxmsg:createNewDxMessage("Please wait few seconds before you spam clicks",255,0,0)
			return false
		end
		whowas[source] = true
		setTimer(function(d) whowas[d] = false end,3000,1,source)
		local row,col = guiGridListGetSelectedItem(panels.gridlist[1])
		if row and col and row ~= -1 and col ~= -1 then
			local memberAccount = guiGridListGetItemText(rnkset.grid[1], row, 2)
			guiSetVisible(rnkset.window[1],true)
			guiSetVisible(panels.window[1],false)
			selectedMember = tostring(memberAccount)
			triggerServerEvent("getRankList",localPlayer,localPlayer)
		end
	elseif source == panels.button[2] then
		if whowas[source] == true then
			exports.NGCdxmsg:createNewDxMessage("Please wait few seconds before you spam clicks",255,0,0)
			return false
		end
		whowas[source] = true
		setTimer(function(d) whowas[d] = false end,3000,1,source)
		guiSetVisible(panels.window[1],false)
		guiSetVisible(rnk.window[1],true)
		triggerServerEvent("getRankList",localPlayer,localPlayer)
	elseif source == panels.button[7] then
		if whowas[source] == true then
			exports.NGCdxmsg:createNewDxMessage("Please wait few seconds before you spam clicks",255,0,0)
			return false
		end
		whowas[source] = true
		setTimer(function(d) whowas[d] = false end,3000,1,source)
		guiSetVisible(cl.window[1],true)
		guiSetVisible(panels.window[1],false)
	elseif source == panels.button[6] then
		if whowas[source] == true then
			exports.NGCdxmsg:createNewDxMessage("Please wait few seconds before you spam clicks",255,0,0)
			return false
		end
		whowas[source] = true
		setTimer(function(d) whowas[d] = false end,3000,1,source)
		triggerServerEvent("getLog",localPlayer,localPlayer)
	elseif source == logs.button[1] then
		if whowas[source] == true then
			exports.NGCdxmsg:createNewDxMessage("Please wait few seconds before you spam clicks",255,0,0)
			return false
		end
		whowas[source] = true
		setTimer(function(d) whowas[d] = false end,3000,1,source)
		triggerServerEvent("cleanBusinessLog",localPlayer,localPlayer)
	elseif source == logs.button[2] then
		if whowas[source] == true then
			exports.NGCdxmsg:createNewDxMessage("Please wait few seconds before you spam clicks",255,0,0)
			return false
		end
		whowas[source] = true
		setTimer(function(d) whowas[d] = false end,3000,1,source)
		guiSetVisible(panels.window[1],true)
		guiSetVisible(logs.window[1],false)
	elseif source == cl.button[1] then
		if whowas[source] == true then
			exports.NGCdxmsg:createNewDxMessage("Please wait few seconds before you spam clicks",255,0,0)
			return false
		end
		whowas[source] = true
		setTimer(function(d) whowas[d] = false end,3000,1,source)
		triggerServerEvent("deleteBusiness",localPlayer,localPlayer)
		guiSetVisible(cl.window[1],false)
		showCursor(false)
	elseif source == cl.button[2] then
		if whowas[source] == true then
			exports.NGCdxmsg:createNewDxMessage("Please wait few seconds before you spam clicks",255,0,0)
			return false
		end
		whowas[source] = true
		setTimer(function(d) whowas[d] = false end,3000,1,source)
		guiSetVisible(cl.window[1],false)
		guiSetVisible(panels.window[1],true)
	elseif source == panels.tabpanel[1] then
		triggerServerEvent("getBusinessPayment",localPlayer,localPlayer)
		guiSetText(panels.label[100],"Your Cash: $"..cvtNumber(getPlayerMoney(localPlayer)))
	elseif source == panels.button[100] then
		if whowas[source] == true then
			exports.NGCdxmsg:createNewDxMessage("Please wait few seconds before you spam clicks",255,0,0)
			return false
		end
		whowas[source] = true
		setTimer(function(d) whowas[d] = false end,3000,1,source)
		local row, col = guiGridListGetSelectedItem (panels.gridlist[9])
		if ( row ~= -1 and col ~= 0 ) then
			local msg = guiGridListGetItemText(panels.gridlist[9], guiGridListGetSelectedItem(panels.gridlist[9]), 1)
			local cost = guiGetText(panels.edit[100])
			local cost = tonumber(cost)
			if getPlayerMoney(localPlayer) >= cost then
				triggerServerEvent("sendBusinessPayment",localPlayer,msg,cost)
			end
		else
			exports.NGCdxmsg:createNewDxMessage("Please select business from the list first!!",255,0,0)
		end
	end
end)



function cvtNumber( theNumber )

	local formatted = theNumber

	while true do

		formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')

	if (k==0) then

		break

		end

	end

	return formatted

end


local cmds = {
[1]="reconnect",
[2]="quit",
[3]="connect",
[4]="disconnect",
[5]="exit",
}

function unbindTheBindedKey()
	local key = getKeyBoundToCommand("reconnect")
	local key2 = getKeyBoundToCommand("quit")
	local key3 = getKeyBoundToCommand("connect")
	local key4 = getKeyBoundToCommand("disconnect")
	local key5 = getKeyBoundToCommand("exit")
	if key or key2 or key3 or key4 or key5 then
		if key then
			theKey = "Reconnect/Disconnect"
		elseif key2 then
			theKey = "Reconnect/Disconnect"
		elseif key3 then
			theKey = "Reconnect/Disconnect"
		elseif key4 then
			theKey = "Reconnect/Disconnect"
		elseif key5 then
			theKey = "Reconnect/Disconnect"
		end
		if disabled then return end
		disabled = true
	else
		if not disabled then return end
		disabled = false
	end
end
setTimer(unbindTheBindedKey,500,0)
stuck = false
function handleInterrupt( status, ticks )
	if (status == 0) then
		--outputDebugString( "(packets from server) interruption began " .. ticks .. " ticks ago" )
		if getElementData(localPlayer,"isPlayerLoss") ~= true then
			stuck = true
			setElementData(localPlayer,"isPlayerLoss",true)
		end
	elseif (status == 1) then
		--outputDebugString( "(packets from server) interruption began " .. ticks .. " ticks ago and has just ended" )
		triggerServerEvent("setPacketLoss",localPlayer,false)
		if getElementData(localPlayer,"isPlayerLoss") == true then
			stuck = false
			setElementData(localPlayer,"isPlayerLoss",false)
		end
	end
end
addEventHandler( "onClientPlayerNetworkStatus", root, handleInterrupt)

setTimer(function()
	if guiGetVisible(panels.window[1]) then
		if stuck == true then
			forceHide()
			outputmsg("You are lagging due Huge Network Loss you can't open Business panel")
		end
		if getPlayerPing(localPlayer) >= 600 then
			forceHide()
			outputmsg("You are lagging due PING you can't open Business panel")
		end
		if getElementDimension(localPlayer) == exports.server:getPlayerAccountID(localPlayer) then
			forceHide()
			outputmsg("You can't open Business panel in house or afk zone!")
		end
		if tonumber(getElementData(localPlayer,"FPS") or 5) < 5 then
			forceHide()
			outputmsg("You are lagging due FPS you can't open Business panel")
		end
		if getElementInterior(localPlayer) ~= 0 then
			forceHide()
			outputmsg("Please be in the real world instead of interiors and other dims")
		end
		if getElementData(localPlayer,"drugsOpen") then
			forceHide()
			outputmsg("Please close Drugs panel")
		end
		if disabled then
			forceHide()
			exports.NGCdxmsg:createNewDxMessage("You can't use Business system while bounded ("..theKey..")",255,0,0)
		end
		if isConsoleActive() then
			forceHide()
			exports.NGCdxmsg:createNewDxMessage("You can't use Business system while Console window is open",255,0,0)
		end
		if isChatBoxInputActive() then
			forceHide()
			exports.NGCdxmsg:createNewDxMessage("You can't use Business system while Chat input box is open",255,0,0)
		end
		if getElementData(localPlayer,"isPlayerPhone") then
			forceHide()
			exports.NGCdxmsg:createNewDxMessage("You can't use Business system while phone is open",255,0,0)
		end
		if isMainMenuActive() then
			forceHide()
			outputmsg("Please close MTA Main Menu")
			exports.NGCdxmsg:createNewDxMessage("You can't use Business system while MTA Main Menu is open",255,0,0)
		end
		if panels.window[1] and guiGetVisible(panels.window[1]) then
			for k,v in ipairs(getElementsByType("gui-window")) do
				if v ~= panels.window[1] then
					if panels.window[2] ~= v then
						if guiGetVisible(v) and guiGetVisible(panels.window[1]) then
							forceHide()
							outputmsg("Please close any panel open!")
						end
					end
				end
			end
		end
		for k,v in ipairs(getElementsByType("gui-window",resourceRoot)) do
			if guiGetVisible(v) then
				showCursor(true)
			end
		end
	end
end,500,0)

function outputmsg(s)
	if s then
		exports.NGCdxmsg:createNewDxMessage(s,255,0,0)
	else
		exports.NGCdxmsg:createNewDxMessage("You are lagging : You can't open Business panel at the moment!",255,0,0)
	end
end

function forceHide()
	guiSetVisible(msg.window[1],false)
	guiSetVisible(rnkset.window[1],false)
	guiSetVisible(rnkadd.window[1],false)
	guiSetVisible(rnk.window[1],false)
	guiSetVisible(cl.window[1],false)
	guiSetVisible(logs.window[1],false)
	guiSetVisible(panels.window[2],false)
	guiSetVisible(panels.window[1], false)
	showCursor(false)
end
