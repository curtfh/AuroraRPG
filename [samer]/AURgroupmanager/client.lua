local sX, sY = guiGetScreenSize()
local sX = sX / 1366
local sY = sY / 768
local isGMShowing = false

GUIEditor = {
    gridlist = {},
    edit = {},
    radiobutton = {}
}
function searchThrough(table)
	for i=1,2 do
		if (source == GUIEditor.edit[i]) and isGMShowing then
			guiGridListClear (GUIEditor.gridlist[i]) 
			local text = guiGetText(source)
			for k,v in ipairs (table) do 
				if string.find (string.upper (v.blacklistedElement:gsub('#%x%x%x%x%x%x', '')),string.upper (text)) then 
					if (v.type == i) then
						local row = guiGridListAddRow(GUIEditor.gridlist[i])
						guiGridListSetItemText(GUIEditor.gridlist[i], row, 1, v["blacklistedElement"], false, false)
					end
				end
			end
		end
	end 
end

function initGMElements(tab)
	if (isElement(GUIEditor.edit[1])) then
		destroyGMElements()
		isGMShowing = false
		guiSetInputMode("allow_binds") 
	else
        GUIEditor.edit[3] = guiCreateEdit(sX*286, sY*508, sX*372, sY*46, "Serial or Account Name..", false)
        GUIEditor.edit[1] = guiCreateEdit(sX*284, sY*197, sX*379, sY*32, "Search..", false)
        GUIEditor.edit[2] = guiCreateEdit(sX*703, sY*197, sX*379, sY*32, "Search..", false)
        GUIEditor.gridlist[1] = guiCreateGridList(sX*282, sY*239, sX*391, sY*254, false)
        guiGridListAddColumn(GUIEditor.gridlist[1], "Blacklisted Serial:", 0.9)
        GUIEditor.gridlist[2] = guiCreateGridList(sX*693, sY*239, sX*391, sY*254, false)
        guiGridListAddColumn(GUIEditor.gridlist[2], "Blacklisted Account:", 0.9)
		for i=1,#tab do
			local row = guiGridListAddRow (GUIEditor.gridlist[tab[i]["type"]])
			guiGridListSetItemText(GUIEditor.gridlist[tab[i]["type"]], row, 1, tab[i]["blacklistedElement"], false, false)
		end
        GUIEditor.radiobutton[1] = guiCreateRadioButton(sX*690, sY*514, sX*164, sY*28, "Serial", false)
        GUIEditor.radiobutton[2] = guiCreateRadioButton(sX*879, sY*514, sX*164, sY*28, "Account", false)    
		isGMShowing = true
		guiSetInputMode("no_binds_when_editing") 
    end
	showCursor(isGMShowing)
end

function destroyGMElements()
	for i=1,#GUIEditor.gridlist do
		if (isElement(GUIEditor.gridlist[i])) then
			destroyElement(GUIEditor.gridlist[i])
		end
	end
	for i=1,#GUIEditor.edit do
		if (isElement(GUIEditor.edit[i])) then
			destroyElement(GUIEditor.edit[i])
		end
	end
	for i=1,#GUIEditor.radiobutton do
		if (isElement(GUIEditor.radiobutton[i])) then
			destroyElement(GUIEditor.radiobutton[i])
		end
	end
end

function drawGMElements()
	dxDrawRectangle(sX*272, sY*135, sX*822, sY*498, tocolor(0, 0, 0, 183), false)
	dxDrawRectangle(sX*272, sY*135, sX*822, sY*50, tocolor(0, 0, 0, 183), false)
	dxDrawText("Blacklist ", sX*271 - 1, sY*135 - 1, sX*1094 - 1, sY*185 - 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
	dxDrawText("Blacklist ", sX*271 + 1, sY*135 - 1, sX*1094 + 1, sY*185 - 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
	dxDrawText("Blacklist ", sX*271 - 1, sY*135 + 1, sX*1094 - 1, sY*185 + 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
	dxDrawText("Blacklist ", sX*271 + 1, sY*135 + 1, sX*1094 + 1, sY*185 + 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
	dxDrawText("Blacklist ", sX*271, sY*135, sX*1094, sY*185, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
	dxDrawRectangle(sX*497, sY*574, sX*146, sY*49, tocolor(0, 0, 0, 183), false)
	dxDrawRectangle(sX*743, sY*574, sX*146, sY*49, tocolor(0, 0, 0, 183), false)
	dxDrawText("Blacklist", sX*497 - 1, sY*574 - 1, sX*643 - 1, sY*623 - 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
	dxDrawText("Blacklist", sX*497 + 1, sY*574 - 1, sX*643 + 1, sY*623 - 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
	dxDrawText("Blacklist", sX*497 - 1, sY*574 + 1, sX*643 - 1, sY*623 + 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
	dxDrawText("Blacklist", sX*497 + 1, sY*574 + 1, sX*643 + 1, sY*623 + 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
	dxDrawText("Blacklist", sX*497, sY*574, sX*643, sY*623, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
	dxDrawText("Close", sX*743 - 1, sY*574 - 1, sX*889 - 1, sY*623 - 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
	dxDrawText("Close", sX*743 + 1, sY*574 - 1, sX*889 + 1, sY*623 - 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
	dxDrawText("Close", sX*743 - 1, sY*574 + 1, sX*889 - 1, sY*623 + 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
	dxDrawText("Close", sX*743 + 1, sY*574 + 1, sX*889 + 1, sY*623 + 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
	dxDrawText("Close", sX*743, sY*574, sX*889, sY*623, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
end

function openGMPanel(tab)
	initGMElements(tab)
	if (isGMShowing) then
		addEventHandler("onClientRender", root, drawGMElements)
		function search()
			searchThrough(tab)
		end
		addEventHandler("onClientGUIChanged", root, search)
	else
		removeEventHandler("onClientRender", root, drawGMElements)
		removeEventHandler("onClientGUIChanged", root, search)
	end
end
addEvent("AURgm.openGMPanel", true)
addEventHandler("AURgm.openGMPanel", root, openGMPanel)

function closeGMPanel(button, state, absoluteX, absoluteY)
	if (isGMShowing) and (state == "down") then 
		if ((absoluteX >= sX*743) and (absoluteX <= sX*(743+146)) and (absoluteY >= sY*574) and (absoluteY <= sY*(574+49))) then
			triggerEvent("AURgm.openGMPanel", localPlayer)
		end
	end
end
addEventHandler("onClientClick", root, closeGMPanel)

function addBlacklist(button, state, absoluteX, absoluteY)
	if (isGMShowing) and (state == "down") then 
		if ((absoluteX >= sX*497) and (absoluteX <= sX*(497+146)) and (absoluteY >= sY*574) and (absoluteY <= sY*(574+49))) then
			local blacklistedElement = guiGetText(GUIEditor.edit[3])
			if (blacklistedElement == "") then return false end
			for i=1,#GUIEditor.radiobutton do
				if (guiRadioButtonGetSelected(GUIEditor.radiobutton[i])) then
					triggerServerEvent("AURgm.addBlacklist", localPlayer, localPlayer, blacklistedElement, i)
					local row = guiGridListAddRow (GUIEditor.gridlist[i])
					guiGridListSetItemText(GUIEditor.gridlist[i], row, 1, blacklistedElement, false, false)
				end
			end
		end
	end
end
addEventHandler("onClientClick", root, addBlacklist)

function removeBlacklist()
	for i=1,#GUIEditor.gridlist do
		if (source == GUIEditor.gridlist[i]) and isGMShowing then
			local blacklistedElement = guiGridListGetItemText(source, guiGridListGetSelectedItem(source), 1)
			if (guiGridListGetSelectedItem(source) ~= -1) then
				triggerServerEvent("AURgm.removeBlacklist", localPlayer, localPlayer, blacklistedElement, i)
				guiGridListRemoveRow(source, guiGridListGetSelectedItem(source))
			end
		end
	end
end
addEventHandler("onClientGUIDoubleClick", root, removeBlacklist)

groupInviteLogs = {
    label = {},
    edit = {},
    button = {},
    window = {},
    radiobutton = {},
    gridlist = {}
}
groupInviteLogs.window[1] = guiCreateWindow(18, 53, 745, 481, "Aurora ~ Group Invites log", false)
guiWindowSetSizable(groupInviteLogs.window[1], false)
guiSetAlpha(groupInviteLogs.window[1], 0.95)
guiSetVisible ( groupInviteLogs.window[1], false )
local screenW,screenH=guiGetScreenSize()
local windowW,windowH=guiGetSize(groupInviteLogs.window[1],false)
local x,y = (screenW-windowW)/2,(screenH-windowH)/2
guiSetPosition(groupInviteLogs.window[1],x,y,false)

groupInviteLogs.gridlist[1] = guiCreateGridList(13, 27, 722, 354, false, groupInviteLogs.window[1])
guiGridListAddColumn(groupInviteLogs.gridlist[1], "Playername", 0.2)
guiGridListAddColumn(groupInviteLogs.gridlist[1], "Account name", 0.2)
guiGridListAddColumn(groupInviteLogs.gridlist[1], "Invited by", 0.2)
guiGridListAddColumn(groupInviteLogs.gridlist[1], "Inviter Account", 0.2)
guiGridListAddColumn(groupInviteLogs.gridlist[1], "Time", 0.2)
---guiGridListAddColumn(groupInviteLogs.gridlist[1], "", 0.2)
groupInviteLogs.label[1] = guiCreateLabel(40, 391, 213, 28, "Use search type", false, groupInviteLogs.window[1])
guiSetFont(groupInviteLogs.label[1], "default-bold-small")
guiLabelSetHorizontalAlign(groupInviteLogs.label[1], "center", false)
groupInviteLogs.edit[1] = guiCreateEdit(34, 429, 129, 36, "Group name", false, groupInviteLogs.window[1])
groupInviteLogs.button[1] = guiCreateButton(400, 429, 80, 36, "Search", false, groupInviteLogs.window[1])
groupInviteLogs.button[2] = guiCreateButton(600, 429, 80, 36, "Close", false, groupInviteLogs.window[1])



addEventHandler( "onClientGUIClick", root,function ()
	if source == groupInviteLogs.button[1] then
		local text = guiGetText(groupInviteLogs.edit[1])
		if text then
			exports.NGCdxmsg:createNewDxMessage("Please wait , we are looking for invite logs",255,0,0)
			triggerServerEvent("findThrowGroups",localPlayer,text)
		end
	elseif source == groupInviteLogs.button[2] then
		guiSetVisible ( groupInviteLogs.window[1], false )
		showCursor( false )
	end
end)


-- Open the window and insert the last groupInviteLogs
addEvent( "callClientgroupInviteLogs", true )
addEventHandler( "callClientgroupInviteLogs", root,
	function ( theTable,mn )
		if ( theTable ) then
			guiGridListClear( groupInviteLogs.gridlist[1] )
			--guiGridListSetItemText( groupInviteLogs.gridlist[1],1,1,mn, true,true )
			for i=1,#theTable do
				local row = guiGridListAddRow( groupInviteLogs.gridlist[1] )
				guiGridListSetItemText( groupInviteLogs.gridlist[1], row, 1, theTable[i].nickname, false, false )
				guiGridListSetItemText( groupInviteLogs.gridlist[1], row, 2, theTable[i].accountname, false, false )
				guiGridListSetItemText( groupInviteLogs.gridlist[1], row, 3, theTable[i].invitedby, false, false )
				guiGridListSetItemText( groupInviteLogs.gridlist[1], row, 4, theTable[i].iaccount, false, false )
				guiGridListSetItemText( groupInviteLogs.gridlist[1], row, 5, theTable[i].times, false, false )
			end

		else
			outputChatBox( "Something wen't wrong while loading the last groupInviteLogs! Try again.", 225, 0, 0 )
		end
	end
)

addEvent("openGMPanel",true)
addEventHandler("openGMPanel",root,function()
	guiSetVisible ( groupInviteLogs.window[1], true )
	showCursor( true )
end)