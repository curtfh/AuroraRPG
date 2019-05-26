--gridlist = {}
local sX, sY = guiGetScreenSize()
local sX = sX / 1366
local sY = sY / 768
local isShowing = false

gridlist1 = guiCreateGridList(sX*258, sY*210, sX*292, sY*391, false)
guiGridListAddColumn(gridlist1, "Group Name:", 0.5)
guiGridListAddColumn(gridlist1, "Leader:", 0.5)
guiSetVisible(gridlist1, false)
gridlist2 = guiCreateGridList(sX*580, sY*210, sX*292, sY*391, false)
guiGridListAddColumn(gridlist2, "Rank:", 0.9)
guiSetVisible(gridlist2, false)
searchBox = guiCreateEdit(264, 616, 275, 31, "Search...", false)
guiSetVisible(searchBox, false)
local rank = ""
local confirm = false
data = {}
ranks = {}

addEventHandler("onClientRender", root, function()
	if (isShowing) then
		dxDrawRectangle(sX*249, sY*126, sX*882, sY*556, tocolor(28, 25, 25, 165), false)
		dxDrawRectangle(sX*249, sY*126, sX*882, sY*45, tocolor(28, 25, 25, 165), false)
		dxDrawText("Groups Management", sX*250, sY*128, sX*1132, sY*172, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, true, true, false)
		dxDrawText("Groups Management", sX*250, sY*126, sX*1132, sY*170, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, true, true, false)
		dxDrawText("Groups Management", sX*248, sY*128, sX*1130, sY*172, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, true, true, false)
		dxDrawText("Groups Management", sX*248, sY*126, sX*1130, sY*170, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, true, true, false)
		dxDrawText("Groups Management", sX*249, sY*127, sX*1131, sY*171, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, true, true, false)
		dxDrawText("Groups list:", sX*267, sY*181, sX*541, sY*205, tocolor(0, 0, 0, 255), 1.00, "clear", "center", "center", true, true, true, true, false)
		dxDrawText("Groups list:", sX*267, sY*179, sX*541, sY*203, tocolor(0, 0, 0, 255), 1.00, "clear", "center", "center", true, true, true, true, false)
		dxDrawText("Groups list:", sX*265, sY*181, sX*539, sY*205, tocolor(0, 0, 0, 255), 1.00, "clear", "center", "center", true, true, true, true, false)
		dxDrawText("Groups list:", sX*265, sY*179, sX*539, sY*203, tocolor(0, 0, 0, 255), 1.00, "clear", "center", "center", true, true, true, true, false)
		dxDrawText("Groups list:", sX*266, sY*180, sX*540, sY*204, tocolor(255, 255, 255, 255), 1.00, "clear", "center", "center", true, true, true, true, false)
		dxDrawText("Ranks list:", sX*591, sY*182, sX*865, sY*206, tocolor(0, 0, 0, 255), 1.00, "clear", "center", "center", true, true, true, true, false)
		dxDrawText("Ranks list:", sX*591, sY*180, sX*865, sY*204, tocolor(0, 0, 0, 255), 1.00, "clear", "center", "center", true, true, true, true, false)
		dxDrawText("Ranks list:", sX*589, sY*182, sX*863, sY*206, tocolor(0, 0, 0, 255), 1.00, "clear", "center", "center", true, true, true, true, false)
		dxDrawText("Ranks list:", sX*589, sY*180, sX*863, sY*204, tocolor(0, 0, 0, 255), 1.00, "clear", "center", "center", true, true, true, true, false)
		dxDrawText("Ranks list:", sX*590, sY*181, sX*864, sY*205, tocolor(255, 255, 255, 255), 1.00, "clear", "center", "center", true, true, true, true, false)
		dxDrawRectangle(sX*938, sY*323, sX*135, sY*54, tocolor(28, 25, 25, 165), false)
		dxDrawText("Join as "..rank, sX*938, sY*324, sX*1074, sY*378, tocolor(0, 0, 0, 255), 1.00, "default", "center", "center", false, false, true, true, false)
		dxDrawText("Join as "..rank, sX*938, sY*322, sX*1074, sY*376, tocolor(0, 0, 0, 255), 1.00, "default", "center", "center", false, false, true, true, false)
		dxDrawText("Join as "..rank, sX*936, sY*324, sX*1072, sY*378, tocolor(0, 0, 0, 255), 1.00, "default", "center", "center", false, false, true, true, false)
		dxDrawText("Join as "..rank, sX*936, sY*322, sX*1072, sY*376, tocolor(0, 0, 0, 255), 1.00, "default", "center", "center", false, false, true, true, false)
		dxDrawText("Join as "..rank, sX*937, sY*323, sX*1073, sY*377, tocolor(255, 255, 255, 255), 1.00, "default", "center", "center", false, false, true, true, false)
		dxDrawRectangle(sX*938, sY*432, sX*135, sY*54, tocolor(28, 25, 25, 165), false)
		dxDrawText("Delete group", sX*939, sY*433, sX*1075, sY*487, tocolor(0, 0, 0, 255), 1.00, "default", "center", "center", true, true, true, true, false)
		dxDrawText("Delete group", sX*939, sY*431, sX*1075, sY*485, tocolor(0, 0, 0, 255), 1.00, "default", "center", "center", true, true, true, true, false)
		dxDrawText("Delete group", sX*937, sY*433, sX*1073, sY*487, tocolor(0, 0, 0, 255), 1.00, "default", "center", "center", true, true, true, true, false)
		dxDrawText("Delete group", sX*937, sY*431, sX*1073, sY*485, tocolor(0, 0, 0, 255), 1.00, "default", "center", "center", true, true, true, true, false)
		dxDrawText("Delete group", sX*938, sY*432, sX*1074, sY*486, tocolor(255, 255, 255, 255), 1.00, "default", "center", "center", true, true, true, true, false)
		dxDrawText("X", sX*1083, sY*126, sX*1135, sY*170, tocolor(255, 255, 255, 255), 1.00, "bankgothic", "center", "center", false, false, true, false, false)
		dxDrawRectangle(sX*1083, sY*127, sX*48, sY*44, tocolor(52, 0, 0, 165), false)
	end
end)

addEventHandler("onClientClick", root,
	function(button, state, abX, abY)
		if (isShowing) then
			if (state == "down") then
				if (abX >= sX*1083) and (abX <= sX*(1083 + 48)) and (abY >= sY*127) and (abY <= sY*(127+44)) then
					isShowing = false
					showCursor(isShowing)
					guiSetVisible(gridlist1, false)
					guiSetVisible(gridlist2, false)
					guiSetVisible(searchBox, false)
					data = {}
					guiSetInputMode("allow_binds")
				end
			end
		end
	end
)

addEventHandler("onClientClick", root,
	function(button, state, abX, abY)
		if (isShowing) and (state == "down") then
			if (abX >= sX*938) and (abX <= sX*(938 + 135)) and (abY >= sY*323) and (abY <= sY*(323+54)) then
				if (getElementData(localPlayer, "Group ID")) then return false end
				local row, column = guiGridListGetSelectedItem(gridlist1)
				if (row ~= -1) and (column ~= -1) then
					local r1, c1 = guiGridListGetSelectedItem(gridlist2)
					if (r1 ~= -1) and (c1 ~= -1) then
						local groupID = guiGridListGetItemData(gridlist1, row, 1)
						local name = guiGridListGetItemText(gridlist1, row, 1)
						local rank = guiGridListGetItemText(gridlist2, r1, 1)
						triggerServerEvent("AURmanagegrp.joinGroup", localPlayer, groupID, name, rank)
					end
				end
			elseif (abX >= sX*938) and (abX <= sX*(938 + 135)) and (abY >= sY*432) and (abY <= sY*(432+54)) then
				local row, column = guiGridListGetSelectedItem(gridlist1)
				if (row ~= -1) and (column ~= -1) then
					if (confirm) then
						confirm = false
						local groupID = guiGridListGetItemData(gridlist1, row, 1)
						local name = guiGridListGetItemText(gridlist1, row, 1)
						triggerServerEvent("AURmanagegrp.deleteGroup", localPlayer, groupID, name)
						for k, v in pairs(data) do
							if (v['id'] == groupID) then
								table.remove(data, k)
							end
						end
						guiGridListClear(gridlist1)
						for k, v in ipairs(data) do
							local row = guiGridListAddRow(gridlist1)
							guiGridListSetItemText(gridlist1, row, 1, v['groupName'], false, false)
							guiGridListSetItemText(gridlist1, row, 2, v['founderAcc'], false, false)
							guiGridListSetItemData(gridlist1, row, 1, v['id'])
						end
					else
						confirm = true
						exports.NGCdxmsg:createNewDxMessage("Are you sure you want to delete this group? Click again to confirm.",255,0,0)
					end
				end
			end
		end
	end
)

addEvent("AURmanagegrp.retrieveData", true)
addEventHandler("AURmanagegrp.retrieveData", root, function(tab)
	data = tab
end)

addEvent("AURmanagegrp.retrieveRanks", true)
addEventHandler("AURmanagegrp.retrieveRanks", root, function(tab)
	ranks = tab
end)

addEvent("AURmanagegrp.showPanel", true)
addEventHandler("AURmanagegrp.showPanel", root,	function()
	if (isShowing) then
		isShowing = false
		showCursor(isShowing)
		guiSetVisible(gridlist1, false)
		guiSetVisible(gridlist2, false)
		guiSetVisible(searchBox, false)
		data = {}
		guiSetInputMode("allow_binds")
	else
		isShowing = true
		confirm = false
		triggerServerEvent("AURmanagegrp.sendData", localPlayer)
		showCursor(isShowing)
		guiGridListClear(gridlist1)
		guiGridListClear(gridlist2)
		guiSetVisible(gridlist1, true)
		guiSetVisible(gridlist2, true)
		guiSetVisible(searchBox, true)
		guiSetInputMode("no_binds_when_editing")
		exports.NGCdxmsg:createNewDxMessage("Wait as we load the data needed.",255,0,0)
		loading = true
		setTimer(function()
			for k, v in ipairs(data) do
				local row = guiGridListAddRow(gridlist1)
				guiGridListSetItemText(gridlist1, row, 1, v['groupName'], false, false)
				guiGridListSetItemText(gridlist1, row, 2, v['founderAcc'], false, false)
				guiGridListSetItemData(gridlist1, row, 1, v['id'])
				loading = false
			end
		end, 3000, 1)
	end
end)

addEventHandler("onClientGUIChanged", searchBox,
	function (theElement)
		if (loading) then return false end
		guiGridListClear(gridlist1)
		for k, v in pairs(data) do
			if (string.find(v['groupName']:lower(), guiGetText(searchBox):lower())) then
				local row = guiGridListAddRow(gridlist1)
				guiGridListSetItemText(gridlist1, row, 1, v['groupName'], false, false)
				guiGridListSetItemText(gridlist1, row, 2, v['founderAcc'], false, false)
				guiGridListSetItemData(gridlist1, row, 1, v['id'])
			end
		end
	end
)

addEventHandler("onClientGUIClick", root,
	function()
		if (source == gridlist1) then
			local row, column = guiGridListGetSelectedItem(gridlist1)
			if (row ~= -1) and (column ~= -1) then
				guiGridListClear(gridlist2)
				local id = guiGridListGetItemData(gridlist1, row, 1)
				exports.NGCdxmsg:createNewDxMessage("Wait as we load the ranks data needed.",255,0,0)
				triggerServerEvent("AURmanagegrp.sendRanks", localPlayer, id)
				loading = true
				setTimer(function()
					for k, v in ipairs(ranks) do
						local row = guiGridListAddRow(gridlist2)
						guiGridListSetItemText(gridlist2, row, 1, v['rankName'], false, false)
						loading = false
					end
					outputChatBox(#ranks)
				end, 3000, 1)
			end
		end
	end
)

addEventHandler("onClientGUIClick", root,
	function()
		if (source == gridlist2) then
			local row, column = guiGridListGetSelectedItem(gridlist2)
			if (row ~= -1) then
				rank = guiGridListGetItemText(gridlist2, row, 1)
			else
				rank = ""
			end
		end
	end
)