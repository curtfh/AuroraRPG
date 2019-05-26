local x, y = guiGetScreenSize()

drugwnd = guiCreateWindow((x / 2) - (520 / 2), (y / 2) - (335 / 2), 560, 340, "NGC ~ Drugs detector", false)
guiWindowSetSizable(drugwnd, false)

druggrd = guiCreateGridList(10, 26, 250, 290, false, drugwnd)
clomn = guiGridListAddColumn(druggrd, "Players", 1)
drug7 = guiCreateLabel(300, 31, 132, 32,"Name : Epozide",false,drugwnd)
drug6 = guiCreateLabel(300, 60, 132, 32,"Ritalin",false,drugwnd)
drug1 = guiCreateLabel(300, 90, 132, 32,"Cocaine",false,drugwnd)
drug2 = guiCreateLabel(300, 120, 132, 32,"Ecstasy",false,drugwnd)
drug3 = guiCreateLabel(300, 150, 132, 32,"Heroine",false,drugwnd)
drug4 = guiCreateLabel(300, 180, 132, 32,"Weed",false,drugwnd)
drug5 = guiCreateLabel(300, 210, 132, 32,"LSD",false,drugwnd)


guiSetText(drug7,"Name: "..getPlayerName(localPlayer).."")
guiLabelSetColor(drug1,100,0,100)
guiLabelSetColor(drug2,255,0,0)
guiLabelSetColor(drug3,255,150,0)
guiLabelSetColor(drug4,0,250,0)
guiLabelSetColor(drug5,255,255,0)
guiLabelSetColor(drug6,0,100,250)
guiLabelSetColor(drug7,255,255,255)
drugbt6 = guiCreateButton(430, 280, 90, 32, "Close", false, drugwnd)
drugbt9 = guiCreateButton(290, 280, 132, 32, "Refresh", false, drugwnd)
guiSetVisible(drugwnd,false)
local idToElem = {
    [1] = drug6,--Ritalin
    [2] = drug1,--cocaine
    [3] = drug2,--Ecstasy
    [4] = drug3,--heroine
    [5] = drug4,--weed
    [6] = drug5,--lsd
}

addCommandHandler("cdrug",function()
	if exports.CSGstaff:isPlayerStaff(localPlayer) then
		guiSetVisible(drugwnd,true)
		showCursor(true)
		forcetoShowList2()
	end
end)



addEventHandler("onClientGUIClick",root,function()
	if source == drugbt6 then
		guiSetVisible(drugwnd,false)
		showCursor(false)
	elseif source == drugbt9 then
		forcetoShowList2()
	elseif source == druggrd then
		local row = guiGridListGetSelectedItem(druggrd)
	    if row ~= nil and row ~= false and row ~= -1 then
            local id = guiGridListGetItemText(druggrd,row,1)
			if id then
				local player = getPlayerFromName(id)
				if player and isElement(player) then
					triggerServerEvent("getDrugsFromQuery",localPlayer,player)
					guiSetText(drug7,"Name: "..getPlayerName(player).."")
				end
			end
		end
	end
end)

addEvent("sendDrugsFromQuery",true)
addEventHandler("sendDrugsFromQuery",root,function(drugsTable,drugNames)
	for a,b in pairs(drugsTable) do
        local a = tostring(a)
        local a2 = tonumber(a)
        if (drugNames[a2]) then
            local elem = idToElem[a2]
            if (isElement(elem)) then
                guiSetText(elem, drugNames[a2] .. " (" .. b .. ")")
			end
		end
	end
end)

function forcetoShowList2()
	guiGridListClear(druggrd)
    for key, player in ipairs(getElementsByType("player")) do
		if exports.server:isPlayerLoggedIn(player) then
			local name = getPlayerName(player)
			local row = guiGridListAddRow(druggrd)
			if getPlayerTeam(player) then
				local r,g,b = getTeamColor(getPlayerTeam(player))
				if name then
					guiGridListSetItemText(druggrd, row, clomn, getPlayerName(player), false, false)
					guiGridListSetItemColor(druggrd, row, clomn, r,g,b)
				end
			end
        end
    end
end
