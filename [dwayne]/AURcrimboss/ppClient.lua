GUIEditor = {
    memo = {},
    label = {},
}

local x, y = guiGetScreenSize()

addEventHandler("onClientResourceStart", resourceRoot,
    function()
        window = guiCreateWindow((x / 2) - (400 / 2), (y / 2) - (335 / 2), 428, 372, "NGC ~ Criminals Boss", false)
        guiWindowSetSizable(window, false)

        list = guiCreateGridList(10, 29, 441, 231, false, window)
        guiGridListAddColumn(list, "Log", 1.2)
		guiGridListAddColumn(list, "Date", 0.3)
        guiGridListAddColumn(list, "Boss", 0.5)
	 -- guiMemoSetReadOnly(list, true)
        GUIEditor.memo[1] = guiCreateMemo(12, 286, 436, 78, "Criminals Boss Commands:\n +L3 Commands \n L3 Command /cban name reason time (10min's max) \n\nL4 Command /cbossban name reason time  \n\nL5 Command /cunban name", false, window)
		guiMemoSetReadOnly(GUIEditor.memo[1], true)
        GUIEditor.label[1] = guiCreateLabel(12, 267, 82, 16, "My Rank:", false, window)
        guiLabelSetColor(GUIEditor.label[1], 67, 251, 2)
        lblRank = guiCreateLabel(70, 267, 131, 15, "Not Criminal Boss", false, window)
        guiLabelSetColor(lblRank, 255, 9, 0)
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

addEvent("cbossLogT",true)
addEventHandler("cbossLogT",localPlayer,function(t)
	guiGridListClear(list)
	for k,v in ipairs(t) do
		local row = guiGridListInsertRowAfter(list,-1)
		guiGridListSetItemText(list,row,1,v[1],false,false)
		guiGridListSetItemText(list,row,2,v[3],false,false)
		guiGridListSetItemText(list,row,3,v[2],false,false)
		--guiSetText(list,v[1].."|"..v[2].."|"..v[3])

	end

end)

addEvent("cbossLogAction",true)
addEventHandler("cbossLogAction",localPlayer,function(v1,v2,v3)
	local row = guiGridListInsertRowAfter(list,-1)
	guiGridListSetItemText(list,row,1,v1,false,false)
	guiGridListSetItemText(list,row,2,v3,false,false)
	guiGridListSetItemText(list,row,3,v2,false,false)
	--guiSetText(list,v1.."|"..v2.."|"..v3)

end)

addEvent("cbossRecRank",true)
addEventHandler("cbossRecRank",localPlayer,function(rank)
	guiSetText(lblRank,"Level "..rank.."")
end)

function tog()
if guiGetVisible(bosswnd) then exports.NGCdxmsg:createNewDxMessage("Close Boss panel first",255,0,0) return false end
	if guiGetVisible(window) then
	guiSetVisible(window,false)
	showCursor(false)
	else

	local rank = getElementData(localPlayer,"boss")
	if rank and rank > 0 then
	guiSetText(lblRank,"Level "..rank.."")
	else
	guiSetText(lblRank,"You are not Boss")
	end
	guiSetVisible(window,true)
	showCursor(true)

end
end

addEvent( "onBossLog", true )
addEventHandler( "onBossLog", localPlayer, tog )

bosswnd = guiCreateWindow((x / 2) - (520 / 2), (y / 2) - (335 / 2), 560, 340, "NGC ~ Criminal Boss", false)
guiWindowSetSizable(bosswnd, false)

bossgrd = guiCreateGridList(10, 26, 230, 290, false, bosswnd)
clomn = guiGridListAddColumn(bossgrd, "Players", 0.5)
clomn2 = guiGridListAddColumn(bossgrd, "Boss", 0.5)
bossbt1 = guiCreateButton(262, 31, 132, 32, "Warn", false, bosswnd)
bossbt2 = guiCreateButton(262, 200, 132, 32, "Ban", false, bosswnd)
bossbt3 = guiCreateButton(262, 78, 132, 32, "Kick", false, bosswnd)
bossbt4 = guiCreateButton(262, 240, 132, 32, "Unban", false, bosswnd)
bossbt5 = guiCreateButton(400, 280, 132, 32, "Refresh", false, bosswnd)
bossbt6 = guiCreateButton(262, 280, 132, 32, "Close", false, bosswnd)
boss = guiCreateEdit(262, 125, 132, 32, "Reason", false, bosswnd)
bosstime = guiCreateEdit(262, 160, 132, 32, "Time", false, bosswnd)
boss0 = guiCreateRadioButton(400, 31, 132, 32,"Remove Boss",false,bosswnd)
boss1 = guiCreateRadioButton(400, 60, 132, 32,"Boss L1",false,bosswnd)
boss2 = guiCreateRadioButton(400, 90, 132, 32,"Boss L2",false,bosswnd)
boss3 = guiCreateRadioButton(400, 120, 132, 32,"Boss L3",false,bosswnd)
boss4 = guiCreateRadioButton(400, 150, 132, 32,"Boss L4",false,bosswnd)
boss5 = guiCreateRadioButton(400, 180, 132, 32,"Boss L5",false,bosswnd)
bossbt7 = guiCreateButton(400, 240, 132, 32, "Set boss rank", false, bosswnd)
guiSetVisible(bosswnd,false)


function opencBOSS()
if getElementData(localPlayer,"boss") and getElementData(localPlayer,"boss") > 0 then
if guiGetVisible(window) then
outputChatBox("close the logs panel first",255,0,0)
else
guiSetVisible(bosswnd,true)
showCursor(true)
exports.NGCdxmsg:createNewDxMessage("Only L6/L5 allowed to set ranks, /bosschat msg to talk with other bosses.",0,255,0)
	local boss = getElementData(localPlayer,"boss")
	if boss and boss == 3 then
		guiSetEnabled(bossbt2,true)
		guiSetEnabled(bossbt4,false)
		guiSetEnabled(bossbt7,false)
		guiSetEnabled(bossbt3,true)
		guiSetEnabled(boss0,false)
		guiSetEnabled(boss1,false)
		guiSetEnabled(boss2,false)
		guiSetEnabled(boss3,false)
		guiSetEnabled(boss4,false)
		guiSetEnabled(boss5,false)
	elseif boss and boss == 4 then
		guiSetEnabled(bossbt2,true)
		guiSetEnabled(bossbt4,false)
		guiSetEnabled(bossbt7,false)
		guiSetEnabled(bossbt3,true)
		guiSetEnabled(boss0,false)
		guiSetEnabled(boss1,false)
		guiSetEnabled(boss2,false)
		guiSetEnabled(boss3,false)
		guiSetEnabled(boss4,false)
		guiSetEnabled(boss5,false)
	elseif boss and boss == 5 then
		guiSetEnabled(bossbt7,true)
		guiSetEnabled(bossbt2,true)
		guiSetEnabled(bossbt4,true)
		guiSetEnabled(bossbt3,true)
		guiSetEnabled(boss0,true)
		guiSetEnabled(boss1,true)
		guiSetEnabled(boss2,true)
		guiSetEnabled(boss3,false)
		guiSetEnabled(boss4,false)
		guiSetEnabled(boss5,false)
	elseif boss and boss == 6 then
		guiSetEnabled(bossbt7,true)
		guiSetEnabled(bossbt2,true)
		guiSetEnabled(bossbt4,true)
		guiSetEnabled(bossbt3,true)
		guiSetEnabled(boss0,true)
		guiSetEnabled(boss1,true)
		guiSetEnabled(boss2,true)
		guiSetEnabled(boss3,true)
		guiSetEnabled(boss4,true)
		guiSetEnabled(boss5,true)
	elseif boss and boss == 1 then
		guiSetEnabled(bossbt3,false)
		guiSetEnabled(bossbt2,false)
		guiSetEnabled(bossbt4,false)
		guiSetEnabled(bossbt7,false)
		guiSetEnabled(boss0,false)
		guiSetEnabled(boss1,false)
		guiSetEnabled(boss2,false)
		guiSetEnabled(boss3,false)
		guiSetEnabled(boss4,false)
		guiSetEnabled(boss5,false)
	elseif boss and boss == 2 then
		guiSetEnabled(bossbt3,true)
		guiSetEnabled(bossbt2,false)
		guiSetEnabled(bossbt4,false)
		guiSetEnabled(bossbt7,false)
		guiSetEnabled(boss0,false)
		guiSetEnabled(boss1,false)
		guiSetEnabled(boss2,false)
		guiSetEnabled(boss3,false)
		guiSetEnabled(boss4,false)
		guiSetEnabled(boss5,false)
	end
forcetoShowList2()
end
end
end
addEvent( "onCmainP", true )
addEventHandler( "onCmainP", localPlayer, opencBOSS )

addEventHandler("onClientGUIClick",root,function()
if source == bossbt5 then
forcetoShowList2()
elseif source == bossbt1 then
local name = guiGridListGetItemText ( bossgrd, guiGridListGetSelectedItem ( bossgrd ), 1 )
local target = getPlayerFromName(name)
local reason = guiGetText(boss)
if target then
if reason == "" or tonumber(reason) then exports.NGCdxmsg:createNewDxMessage("Insert valid reason",255,0,0) return false end
triggerServerEvent("pwarn",localPlayer,target,reason)
else
exports.NGCdxmsg:createNewDxMessage("The player not found",255,0,0)
end
elseif source == bossbt3 then
local name = guiGridListGetItemText ( bossgrd, guiGridListGetSelectedItem ( bossgrd ), 1 )
local target = getPlayerFromName(name)
local reason = guiGetText(boss)
if target then
if reason == "" or tonumber(reason) then exports.NGCdxmsg:createNewDxMessage("Insert valid reason",255,0,0) return false end
triggerServerEvent("pkick",localPlayer,target,reason)
else
exports.NGCdxmsg:createNewDxMessage("The player not found",255,0,0)
end

elseif source == bossbt2 then
local name = guiGridListGetItemText ( bossgrd, guiGridListGetSelectedItem ( bossgrd ), 1 )
local target = getPlayerFromName(name)
local reason = guiGetText(boss)
local tim = guiGetText(bosstime)
if target then
if reason == "" or tonumber(reason) then exports.NGCdxmsg:createNewDxMessage("Insert valid reason",255,0,0) return false end
if not tonumber(tim) or tim and tonumber(tim) <= 0 then exports.NGCdxmsg:createNewDxMessage("Insert number",255,0,0) return false end
triggerServerEvent("cban",localPlayer,target,reason,tim)
else
exports.NGCdxmsg:createNewDxMessage("The player not found",255,0,0)
end

elseif source == bossbt4 then
local name = guiGridListGetItemText ( bossgrd, guiGridListGetSelectedItem ( bossgrd ), 1 )
local target = getPlayerFromName(name)
if target then
triggerServerEvent("cunban",localPlayer,target)
else
exports.NGCdxmsg:createNewDxMessage("The player not found",255,0,0)
end

elseif source == bossbt7 then
local name = guiGridListGetItemText ( bossgrd, guiGridListGetSelectedItem ( bossgrd ), 1 )
local target = getPlayerFromName(name)
if target then
if guiRadioButtonGetSelected(boss0) then lvl = 0
elseif guiRadioButtonGetSelected(boss1) then lvl = 1
elseif guiRadioButtonGetSelected(boss2) then lvl = 2
elseif guiRadioButtonGetSelected(boss3) then lvl = 3
elseif guiRadioButtonGetSelected(boss4) then lvl = 4
elseif guiRadioButtonGetSelected(boss5) then lvl = 5
else exports.NGCdxmsg:createNewDxMessage("Please select rank first",255,0,0) return false end
if target == localPlayer then exports.NGCdxmsg:createNewDxMessage("You can't set your rank.",255,0,0) return false end
triggerServerEvent("bosslevel",localPlayer,target,lvl)
else
exports.NGCdxmsg:createNewDxMessage("The player not found",255,0,0)
end

elseif source == bossbt6 then
guiSetVisible(bosswnd,false)
showCursor(false)
end
end)

function forcetoShowList2()
guiGridListClear(bossgrd)
    for key, player in ipairs(getElementsByType("player")) do
        local name = getPlayerName(player)
        --if (name ~= getPlayerName(localPlayer)) then
        local row = guiGridListAddRow(bossgrd)
		if getPlayerTeam(player) then
		local r,g,b = getTeamColor(getPlayerTeam(player))
		if name then
        guiGridListSetItemText(bossgrd, row, clomn, getPlayerName(player), false, false)
		local boss = getElementData(player,"boss")
		if boss and boss > 0 then
			guiGridListSetItemText(bossgrd, row, clomn2, "Boss Rank: "..boss, true, true)
		end

	  	guiGridListSetItemColor (bossgrd, row, clomn, r, g, b )
          end
        end
    end
end
