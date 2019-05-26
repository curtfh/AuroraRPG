local x, y = guiGetScreenSize()

Chiefwnd = guiCreateWindow((x / 2) - (520 / 2), (y / 2) - (335 / 2), 560, 340, "NGC ~ Police Chief", false)
guiWindowSetSizable(Chiefwnd, false)

Chiefgrd = guiCreateGridList(10, 26, 230, 290, false, Chiefwnd)
clomn = guiGridListAddColumn(Chiefgrd, "Players", 0.5)
clomn2 = guiGridListAddColumn(Chiefgrd, "Chief", 0.5)
Chiefbt1 = guiCreateButton(262, 31, 132, 32, "Warn", false, Chiefwnd)
Chiefbt2 = guiCreateButton(262, 200, 132, 32, "Ban", false, Chiefwnd)
Chiefbt3 = guiCreateButton(262, 78, 132, 32, "Kick", false, Chiefwnd)
Chiefbt4 = guiCreateButton(262, 240, 132, 32, "Unban", false, Chiefwnd)
Chiefbt5 = guiCreateButton(400, 280, 132, 32, "Refresh", false, Chiefwnd)
Chiefbt6 = guiCreateButton(262, 280, 132, 32, "Close", false, Chiefwnd)
Chief = guiCreateEdit(262, 125, 132, 32, "Reason", false, Chiefwnd)
Chieftime = guiCreateEdit(262, 160, 132, 32, "Time", false, Chiefwnd)
Chief0 = guiCreateRadioButton(400, 31, 132, 32,"Remove Chief",false,Chiefwnd)
Chief1 = guiCreateRadioButton(400, 60, 132, 32,"Chief L1",false,Chiefwnd)
Chief2 = guiCreateRadioButton(400, 90, 132, 32,"Chief L2",false,Chiefwnd)
Chief3 = guiCreateRadioButton(400, 120, 132, 32,"Chief L3",false,Chiefwnd)
Chief4 = guiCreateRadioButton(400, 150, 132, 32,"Chief L4",false,Chiefwnd)
Chief5 = guiCreateRadioButton(400, 180, 132, 32,"Chief L5",false,Chiefwnd)
Chiefbt7 = guiCreateButton(400, 240, 132, 32, "Set Chief rank", false, Chiefwnd)
guiSetVisible(Chiefwnd,false)


function openChiefPanel()
	if getElementData(localPlayer,"polc") and getElementData(localPlayer,"polc") > 0 then
		if guiGetVisible(window) then
			outputChatBox("close the logs panel first",255,0,0)
		else
			guiSetVisible(Chiefwnd,true)
			showCursor(true)
			exports.NGCdxmsg:createNewDxMessage("Only L5/L4 allowed to set ranks.",0,255,0)
			local Chief = getElementData(localPlayer,"polc")
			if Chief and Chief == 3 then
				guiSetEnabled(Chiefbt2,true)
				guiSetEnabled(Chiefbt4,false)
				guiSetEnabled(Chiefbt7,false)
				guiSetEnabled(Chiefbt3,true)
				guiSetEnabled(Chief0,false)
				guiSetEnabled(Chief1,false)
				guiSetEnabled(Chief2,false)
				guiSetEnabled(Chief3,false)
				guiSetEnabled(Chief4,false)
				guiSetEnabled(Chief5,false)
			elseif Chief and Chief == 4 then
				guiSetEnabled(Chiefbt2,true)
				guiSetEnabled(Chiefbt4,false)
				guiSetEnabled(Chiefbt7,true)
				guiSetEnabled(Chiefbt3,true)
				guiSetEnabled(Chief0,true)
				guiSetEnabled(Chief1,true)
				guiSetEnabled(Chief2,true)
				guiSetEnabled(Chief3,false)
				guiSetEnabled(Chief4,false)
				guiSetEnabled(Chief5,false)
			elseif Chief and Chief == 5 then
				guiSetEnabled(Chiefbt7,true)
				guiSetEnabled(Chiefbt2,true)
				guiSetEnabled(Chiefbt4,true)
				guiSetEnabled(Chiefbt3,true)
				guiSetEnabled(Chief0,true)
				guiSetEnabled(Chief1,true)
				guiSetEnabled(Chief2,true)
				guiSetEnabled(Chief3,true)
				guiSetEnabled(Chief4,true)
				guiSetEnabled(Chief5,true)
			elseif Chief and Chief == 1 then
				guiSetEnabled(Chiefbt3,false)
				guiSetEnabled(Chiefbt2,false)
				guiSetEnabled(Chiefbt4,false)
				guiSetEnabled(Chiefbt7,false)
				guiSetEnabled(Chief0,false)
				guiSetEnabled(Chief1,false)
				guiSetEnabled(Chief2,false)
				guiSetEnabled(Chief3,false)
				guiSetEnabled(Chief4,false)
				guiSetEnabled(Chief5,false)
			elseif Chief and Chief == 2 then
				guiSetEnabled(Chiefbt3,true)
				guiSetEnabled(Chiefbt2,false)
				guiSetEnabled(Chiefbt4,false)
				guiSetEnabled(Chiefbt7,false)
				guiSetEnabled(Chief0,false)
				guiSetEnabled(Chief1,false)
				guiSetEnabled(Chief2,false)
				guiSetEnabled(Chief3,false)
				guiSetEnabled(Chief4,false)
				guiSetEnabled(Chief5,false)
			end
			forcetoShowList2()
		end
	end
end
addEvent( "onChiefO", true )
addEventHandler( "onChiefO", localPlayer, openChiefPanel )

addEventHandler("onClientGUIClick",root,function()
if source == Chiefbt5 then
forcetoShowList2()
elseif source == Chiefbt1 then
local name = guiGridListGetItemText ( Chiefgrd, guiGridListGetSelectedItem ( Chiefgrd ), 1 )
local target = getPlayerFromName(name)
local reason = guiGetText(Chief)
if target then
if reason == "" or reason == "Reason" or tonumber(reason) then exports.NGCdxmsg:createNewDxMessage("Insert valid reason",255,0,0) return false end
triggerServerEvent("policeWarn",localPlayer,target,reason)
else
exports.NGCdxmsg:createNewDxMessage("The player not found",255,0,0)
end
elseif source == Chiefbt3 then
local name = guiGridListGetItemText ( Chiefgrd, guiGridListGetSelectedItem ( Chiefgrd ), 1 )
local target = getPlayerFromName(name)
local reason = guiGetText(Chief)
if target then
if reason == "" or tonumber(reason) then exports.NGCdxmsg:createNewDxMessage("Insert valid reason",255,0,0) return false end
triggerServerEvent("policeKick",localPlayer,target,reason)
else
exports.NGCdxmsg:createNewDxMessage("The player not found",255,0,0)
end

elseif source == Chiefbt2 then
local name = guiGridListGetItemText ( Chiefgrd, guiGridListGetSelectedItem ( Chiefgrd ), 1 )
local target = getPlayerFromName(name)
local reason = guiGetText(Chief)
local tim = guiGetText(Chieftime)
if target then
if reason == "" or tonumber(reason) then exports.NGCdxmsg:createNewDxMessage("Insert valid reason",255,0,0) return false end
if not tonumber(tim) or tim and tonumber(tim) <= 0 then exports.NGCdxmsg:createNewDxMessage("Insert number",255,0,0) return false end
triggerServerEvent("policeBan",localPlayer,target,reason,tim)
else
exports.NGCdxmsg:createNewDxMessage("The player not found",255,0,0)
end

elseif source == Chiefbt4 then
local name = guiGridListGetItemText ( Chiefgrd, guiGridListGetSelectedItem ( Chiefgrd ), 1 )
local target = getPlayerFromName(name)
if target then
triggerServerEvent("policeUnBan",localPlayer,target)
else
exports.NGCdxmsg:createNewDxMessage("The player not found",255,0,0)
end

elseif source == Chiefbt7 then
local name = guiGridListGetItemText ( Chiefgrd, guiGridListGetSelectedItem ( Chiefgrd ), 1 )
local target = getPlayerFromName(name)
if target then
if guiRadioButtonGetSelected(Chief0) then lvl = 0
elseif guiRadioButtonGetSelected(Chief1) then lvl = 1
elseif guiRadioButtonGetSelected(Chief2) then lvl = 2
elseif guiRadioButtonGetSelected(Chief3) then lvl = 3
elseif guiRadioButtonGetSelected(Chief4) then lvl = 4
elseif guiRadioButtonGetSelected(Chief5) then lvl = 5
else exports.NGCdxmsg:createNewDxMessage("Please select rank first",255,0,0) return false end
if target == localPlayer then exports.NGCdxmsg:createNewDxMessage("You can't set your rank.",255,0,0) return false end
triggerServerEvent("Chieflevel",localPlayer,target,lvl)
else
exports.NGCdxmsg:createNewDxMessage("The player not found",255,0,0)
end

elseif source == Chiefbt6 then
guiSetVisible(Chiefwnd,false)
showCursor(false)
end
end)

function forcetoShowList2()
	guiGridListClear(Chiefgrd)
    for key, player in ipairs(getElementsByType("player")) do
		if player ~= localPlayer then
			local name = getPlayerName(player)
			local row = guiGridListAddRow(Chiefgrd)
			if getPlayerTeam(player) then
				local r,g,b = getTeamColor(getPlayerTeam(player))
				if name then
					guiGridListSetItemText(Chiefgrd, row, clomn, getPlayerName(player), false, false)
					local Chief = getElementData(player,"polc")
					if Chief and Chief > 0 then
						guiGridListSetItemText(Chiefgrd, row, clomn2, "Chief Rank: "..Chief, true, true)
					end
					guiGridListSetItemColor (Chiefgrd, row, clomn, r, g, b )
				end
			end
        end
    end
end


--////////////////////////////****************************/////////////////////////


dds = {

    memo = {},

    label = {},

}

addEventHandler("onClientResourceStart", resourceRoot,

    function()

        window = guiCreateWindow(387, 178, 460, 401, "NGC Police Chief - Panel", false)

        guiWindowSetSizable(window, false)



        list = guiCreateGridList(10, 29, 441, 231, false, window)

        guiGridListAddColumn(list, "Log", 1.2)

		guiGridListAddColumn(list, "Date", 0.3)

        guiGridListAddColumn(list, "Chief", 0.5)

        dds.memo[1] = guiCreateMemo(12, 286, 436, 78, "Police Chief Commands:\n\nYou must be in a law job to use the commands. 2 Warnings automatically kicks a player from the job. Do not double warn on purpose and be considerate. Your goal is to help police have a better attitude towards their jobs, not punish players. Punishment should always be the final resort. \n /pchiefprintroster - Shows the roster\n\n /pchiefsetlevel username level - Level 5 Chiefs only\n\nLevel 1: /pwarn name reason\nLevel 2: /pwarn name reason, /pkick name reason\nLevel 3: /pwarn name reason, /pkick name reason, /pban name reason (if level 3, 60 minutes)\nLevel 4: /pwarn name reason, /pkick name reason, /pban name reason time <-- minutes\nLevel 5: /pwarn name reason, /pkick name reason, /pban name reason time, /punban name reason\n\nGuidelines:\nWarn before other actions, tell the player what they are doing that is \nunethical and then proceed.\n\nBe aware and be considerate.\n\nFor rank inquiry's, please contact any level 5 pchief via Forum, do not ask ingame!\nForum message only.\n", false, window)

        dds.label[1] = guiCreateLabel(12, 267, 82, 16, "My Rank:", false, window)

        guiLabelSetColor(dds.label[1], 67, 251, 2)

        lblRank = guiCreateLabel(70, 267, 131, 15, "Not a Police Chief", false, window)

        guiLabelSetColor(lblRank, 3, 9, 249)

        btnClose = guiCreateButton(12, 370, 437, 22, "Close", false, window)

		addEventHandler("onClientGUIClick",btnClose,function()

			if source == btnClose then

				guiSetVisible(window,false)

				showCursor(false)

			end

		end)

		guiSetVisible(window,false)

    end

)



addEvent("pchiefLogT",true)

addEventHandler("pchiefLogT",localPlayer,function(t)

	guiGridListClear(list)

	for k,v in ipairs(t) do

		local row = guiGridListInsertRowAfter(list,-1)

		guiGridListSetItemText(list,row,1,v[1],false,false)

		guiGridListSetItemText(list,row,2,v[3],false,false)

		guiGridListSetItemText(list,row,3,v[2],false,false)

	end

end)



addEvent("pchiefLogAction",true)

addEventHandler("pchiefLogAction",localPlayer,function(v1,v2,v3)

	local row = guiGridListInsertRowAfter(list,-1)

	guiGridListSetItemText(list,row,1,v1,false,false)

	guiGridListSetItemText(list,row,2,v3,false,false)

	guiGridListSetItemText(list,row,3,v2,false,false)

end)



addEvent("pchiefRecRank",true)

addEventHandler("pchiefRecRank",localPlayer,function(rank)

	guiSetText(lblRank,"Level "..rank.."")

end)



function tog()

	guiSetVisible(window,not guiGetVisible(window))

	if guiGetVisible(window) then showCursor(true) else showCursor(false) end

end



addCommandHandler("pchief",tog)





