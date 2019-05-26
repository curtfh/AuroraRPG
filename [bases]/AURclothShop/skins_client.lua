local client = getLocalPlayer()
local rotation = 0
local tempTable = {}
local x, y = guiGetScreenSize()
local money = 8000

clothes_window = guiCreateWindow((x / 2) - (1000 / 2), (y / 2) - (500 / 2), 502, 577, "AUR ~ Skin shop", false)
guiWindowSetSizable(clothes_window, false)
guiSetAlpha(clothes_window, 0.85)

clothes_grid = guiCreateGridList(26, 47, 447, 410, false, clothes_window)
loc1 = guiGridListAddColumn(clothes_grid, "Model ID & Group", 0.3)
loc2 = guiGridListAddColumn(clothes_grid, "Model Name", 0.3)
loc3 = guiGridListAddColumn(clothes_grid, "Model price $$$", 0.3)
clothes_buy = guiCreateButton(164, 477, 131, 32, "Get Skin", false, clothes_window)
guiSetFont(clothes_buy, "default-bold-small")
guiSetProperty(clothes_buy, "NormalTextColour", "FFF1830C")
clothes_close = guiCreateButton(162, 519, 133, 32, "Close", false, clothes_window)
guiSetFont(clothes_close, "default-bold-small")
sdas = guiCreateLabel(106, 26, 273, 15, "Welcome to skin shop", false, clothes_window)
guiSetFont(sdas, "default-bold-small")
guiLabelSetColor(sdas, 236, 157, 18)
guiLabelSetHorizontalAlign(sdas, "center", false)
checkbox = guiCreateCheckBox(340, 476, 118, 32, "Sort by Groups", false, false, clothes_window)
guiSetFont(checkbox, "default-bold-small")
guiSetProperty(checkbox, "NormalTextColour", "FF2CD923")


guiSetVisible(clothes_window,false)

addEventHandler("onClientGUIClick",root,function()
	if source == checkbox then
		if guiCheckBoxGetSelected(checkbox) == true then
			aLoadSkins(2)
			guiGridListSetSortingEnabled (clothes_grid, false)
		else
			aLoadSkins(1)
			guiGridListSetSortingEnabled (clothes_grid, false)
		end
	end
end)

function rotatePlayer()
	rotation = rotation + 1
	if rotation > 359 then rotation = 0 end
	setPedRotation(localPlayer,rotation)
end

addEvent("closeClothingShopXD",true)
addEventHandler("closeClothingShopXD",root,
function ()
	removeEventHandler("onClientRender",root,rotatePlayer)
end)

addEventHandler("onClientGUIClick",root,
function ()
	if (source == clothes_buy) then
		if (getPlayerMoney(localPlayer) >= 400) then
			local skinID2 = guiGridListGetItemText(clothes_grid, guiGridListGetSelectedItem(clothes_grid), 1)
			local moneyID2 = tonumber(guiGridListGetItemText(clothes_grid, guiGridListGetSelectedItem(clothes_grid), 3))
			if skinID2 and skinID2 == "LIMITED" then
				guiSetVisible(clothes_window, false)
				showCursor(false)
				setTimer(function () removeEventHandler("onClientRender",root,rotatePlayer) end, 1000, 1)
				setElementModel(localPlayer, 310)
				triggerServerEvent("buyVIPSkin", localPlayer, localPlayer, 310, 0)
				local theSound = playSound("https://static-cdn.curtcreation.net/yt-mp3/J_QGZspO4gg_q0.mp3")
				setSoundVolume(theSound, 0.5)
				exports.DENsettings:setPlayerSetting("snoweather", true)
				exports.DENsettings:setPlayerSetting("snowground", true)
				exports.NGCdxmsg:createNewDxMessage("Merry Christmas!",0,255,0)
				return false
			elseif skinID2 and skinID2 == "VIP4" then
				guiSetVisible(clothes_window, false)
				showCursor(false)
				setTimer(function () removeEventHandler("onClientRender",root,rotatePlayer) end, 1000, 1)
				setElementModel(localPlayer, tonumber(getElementData(localPlayer,"skinShopTempSkin")))
				triggerServerEvent("buyVIPSkin", localPlayer, localPlayer, 41,moneyID2)
				return false
			elseif skinID2 and skinID2 == "VIP3" then
				guiSetVisible(clothes_window, false)
				showCursor(false)
				setTimer(function () removeEventHandler("onClientRender",root,rotatePlayer) end, 1000, 1)
				setElementModel(localPlayer, tonumber(getElementData(localPlayer,"skinShopTempSkin")))
				triggerServerEvent("buyVIPSkin", localPlayer, localPlayer, 52,moneyID2)
				return false
			elseif skinID2 and skinID2 == "VIP2" then
				guiSetVisible(clothes_window, false)
				showCursor(false)
				setTimer(function () removeEventHandler("onClientRender",root,rotatePlayer) end, 1000, 1)
				setElementModel(localPlayer, tonumber(getElementData(localPlayer,"skinShopTempSkin")))
				triggerServerEvent("buyVIPSkin", localPlayer, localPlayer, 94,moneyID2)
				return false
			elseif skinID2 and skinID2 == "VIP1" then
				guiSetVisible(clothes_window, false)
				showCursor(false)
				setTimer(function () removeEventHandler("onClientRender",root,rotatePlayer) end, 1000, 1)
				setElementModel(localPlayer, tonumber(getElementData(localPlayer,"skinShopTempSkin")))
				triggerServerEvent("buyVIPSkin", localPlayer, localPlayer, 183,moneyID2)
				return false
			end
			local skinID = tonumber(guiGridListGetItemText(clothes_grid, guiGridListGetSelectedItem(clothes_grid), 1))
			local moneyID = tonumber(guiGridListGetItemText(clothes_grid, guiGridListGetSelectedItem(clothes_grid), 3))
			if (skinID and type(skinID) == "number") then
				if exports.AURmodels:normalSkin(skinID) or getElementData(localPlayer,"isPlayerPrime") then
					guiSetVisible(clothes_window, false)
					showCursor(false)
					setElementModel(localPlayer, tonumber(getElementData(localPlayer,"skinShopTempSkin")))
					triggerServerEvent("buyNewSkin", localPlayer, localPlayer, skinID,moneyID)
					setTimer(function () removeEventHandler("onClientRender",root,rotatePlayer) end, 1000, 1)
				else
					exports.NGCdxmsg:createNewDxMessage("You can't use Custom skin model",255,0,0)
				end
			end
		else
			exports.NGCdxmsg:createNewDxMessage("Skin shop: You need $400 to buy this skin.",255,0,0)
		end
	elseif (source == clothes_grid) then
		local skin = tonumber(guiGridListGetItemText(clothes_grid, guiGridListGetSelectedItem(clothes_grid), 1)) or tonumber(getElementData(localPlayer,"skinShopTempSkin"))
		if skin ~= "LIMITED" or skin ~= "VIP4" or skin ~= "VIP3" or skin ~= "VIP2" or skin ~= "VIP1" then
			if exports.AURmodels:normalSkin(skin) then
				if skin == "LIMITED" then 
					setElementModel(localPlayer, skin)
					exports.NGCdxmsg:createNewDxMessage("Merry Christmas!",0,255,0)
				else
					setElementModel(localPlayer, skin)
				end
			else
				if skin == "LIMITED" then 
					setElementModel(localPlayer, skin)
					exports.NGCdxmsg:createNewDxMessage("Merry Christmas!",0,255,0)
				else
					exports.NGCdxmsg:createNewDxMessage("You can't use Custom skin model",255,0,0)
				end 
				
			end
		end
		local skin2 = guiGridListGetItemText(clothes_grid, guiGridListGetSelectedItem(clothes_grid), 1) or tonumber(getElementData(localPlayer,"skinShopTempSkin"))
		if skin2 == "LIMITED" then
			setElementModel(localPlayer,310)
		elseif skin2 == "VIP4" then
			setElementModel(localPlayer,41)
		elseif skin2 == "VIP3" then
			setElementModel(localPlayer,52)
		elseif skin2 == "VIP2" then
			setElementModel(localPlayer,94)
		elseif skin2 == "VIP1" then
			setElementModel(localPlayer,183)
		end
	elseif (source == clothes_close) then
		guiSetVisible(clothes_window, false)
		setTimer(function () removeEventHandler("onClientRender",root,rotatePlayer) end, 1000, 1)
		showCursor(false)
		triggerServerEvent("setTempSkin",localPlayer,localPlayer)
		setElementModel(localPlayer, tonumber(getElementData(localPlayer,"skinShopTempSkin")))
	end
end)

addEvent("showClothesGUI", true)
addEventHandler("showClothesGUI", localPlayer,
function (theTable)
	if source == localPlayer then
	guiGridListClear(clothes_grid)
	guiCheckBoxSetSelected(checkbox,false)
	guiSetVisible(clothes_window, true)
	showCursor(true)
	aLoadSkins(1)
	guiGridListSetSortingEnabled (clothes_grid, false)
	addEventHandler("onClientRender",root,rotatePlayer)
	end
end)

function aLoadSkins(mode)
	triggerServerEvent("loadSkinXML",localPlayer,mode)
end

addEvent("checkBlockedSkin",true)
addEventHandler("checkBlockedSkin",root,function(id)
	if exports.AURmodels:normalSkin(id) then
		return
	else
		triggerServerEvent("onSetBlockSkin",localPlayer,id,true)
	end
end)

addEvent("reloadSkinXML",true)
addEventHandler("reloadSkinXML",root,function(tabx,mx)
	aSkins = tabx
	if aSkins then
		aListSkins(mx)
	else
		exports.NGCdxmsg:createNewDxMessage("Re enter the marker, server side not ready yet",255,0,0)
	end
end)


function aListSkins( mode )
	guiGridListClear ( clothes_grid )
	if ( mode == 1 ) then --Normal
		local skins = {}
		for name, group in pairs ( aSkins ) do
			if (name ~= "Special" or name == "Special") then
				for id, skin in pairs ( group ) do
					local id = tonumber ( skin["model"] )
					skins[id] = skin["name"]
				end
			end
		end
		local i = -5
		while ( i <= 312 ) do
			if ( skins[i] ~= nil ) then
				local row = guiGridListAddRow ( clothes_grid )
				if i == -5 then tag = "LIMITED"
				elseif i == -4 then tag = "VIP4"
				elseif i == -3 then tag = "VIP3"
				elseif i == -2 then tag = "VIP2"
				elseif i == -1 then tag = "VIP1"
				elseif i == -1 then tag = "VIP1"
				else
				tag = ""
				end
				if i < 0 then
					guiGridListSetItemText ( clothes_grid, row, 1, tag, false, true )

				else
					guiGridListSetItemText ( clothes_grid, row, 1, tostring ( i ), false, true )
				end
				guiGridListSetItemText ( clothes_grid, row, 2, skins[i], false, false )
				if i == -5 then
					guiGridListSetItemText ( clothes_grid, row, 3, math.floor(0), false, false )
				else
					guiGridListSetItemText ( clothes_grid, row, 3, math.floor(money/math.random(2,4)), false, false )
				end
				if i >= 0 then
					if not exports.AURmodels:normalSkin(i) then
						guiGridListSetItemColor ( clothes_grid, row,loc1, 255,0,0)
						guiGridListSetItemColor ( clothes_grid, row,loc2, 255,0,0)
						guiGridListSetItemColor ( clothes_grid, row,loc3, 255,0,0)
					end
				end
				if i < 0 then
					guiGridListSetItemColor ( clothes_grid, row,loc1, 255,150,0)
					guiGridListSetItemColor ( clothes_grid, row,loc2, 255,150,0)
					guiGridListSetItemColor ( clothes_grid, row,loc3, 255,150,0)
				end
			end
			i = i + 1
		end
		guiGridListSetSortingEnabled ( clothes_grid, true )
	else	--Groups
		for name, group in pairs ( aSkins ) do
			if (name ~= "Special" or name == "Special") then
				local row = guiGridListAddRow ( clothes_grid )
				guiGridListSetItemText ( clothes_grid, row, 1, name, true, false )
				for id, skin in ipairs ( aSkins[name] ) do
					row = guiGridListAddRow ( clothes_grid )
					if skin["model"] == "-5" then tag = "LIMITED"
					elseif skin["model"] == "-4" then tag = "VIP4"
					elseif skin["model"] == "-3" then tag = "VIP3"
					elseif skin["model"] == "-2" then tag = "VIP2"
					elseif skin["model"] == "-1" then tag = "VIP1"
					else
					tag = ""
					end
					if skin["model"] < "0" then
					guiGridListSetItemText ( clothes_grid, row, 1, tag, false, true )
					else
					guiGridListSetItemText ( clothes_grid, row, 1, skin["model"], false, true )
					end
					guiGridListSetItemText ( clothes_grid, row, 2, skin["name"], false, false )
					guiGridListSetItemText ( clothes_grid, row, 3, math.floor(money/math.random(2,4)), false, false )

					if skin["model"] < "0" then
						guiGridListSetItemColor ( clothes_grid, row,loc1, 255,150,0)
						guiGridListSetItemColor ( clothes_grid, row,loc2, 255,150,0)
						guiGridListSetItemColor ( clothes_grid, row,loc3, 255,150,0)
					end
				end
			end
		end
		guiGridListSetSortingEnabled ( clothes_grid, false )
	end
end
if ( fileExists( "skins_client.lua" ) ) then
	fileDelete( "skins_client.lua" )
end
