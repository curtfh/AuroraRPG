local x, y = guiGetScreenSize()

weaponsPanel = {
    staticimage = {},
    button = {},
    edit = {},
    gridlist = {},
    window = {},
    label = {},
    radiobutton = {}
}
weaponsPanel.window[1] = guiCreateWindow(( x / 2 ) - ( 700 / 2 ), ( y / 2 ) - ( 420 / 2 ), 697, 434, "AuroraRPG ~ Ammunation", false)
guiWindowSetSizable(weaponsPanel.window[1], false)
guiSetVisible(weaponsPanel.window[1],false)
weaponsPanel.gridlist[1] = guiCreateGridList(9, 28, 465, 350, false, weaponsPanel.window[1])
guiGridListAddColumn(weaponsPanel.gridlist[1], "Item Type", 0.3)
guiGridListAddColumn(weaponsPanel.gridlist[1], "Name", 0.3)
guiGridListAddColumn(weaponsPanel.gridlist[1], "ID", 0.1)
guiGridListAddColumn(weaponsPanel.gridlist[1], "Clip", 0.1)
guiGridListAddColumn(weaponsPanel.gridlist[1], "Price per clip", 0.2)
weaponsPanel.button[1] = guiCreateButton(523, 387, 125, 29, "Buy", false, weaponsPanel.window[1])
weaponsPanel.label[1] = guiCreateLabel(480, 34, 206, 59, "Welcome to Ammunation\n\nDon't murder anyone outside LV \nDon't break AuroraRPG rules", false, weaponsPanel.window[1])
guiSetFont(weaponsPanel.label[1], "default-bold-small")
guiLabelSetColor(weaponsPanel.label[1], 45, 228, 26)
guiLabelSetHorizontalAlign(weaponsPanel.label[1], "center", true)
weaponsPanel.button[2] = guiCreateButton(65, 394, 125, 29, "Close", false, weaponsPanel.window[1])
weaponsPanel.label[2] = guiCreateLabel(521, 250, 127, 28, "Cost:", false, weaponsPanel.window[1])
guiSetFont(weaponsPanel.label[2], "default-bold-small")
guiLabelSetHorizontalAlign(weaponsPanel.label[2], "center", false)
weaponsPanel.edit[1] = guiCreateEdit(523, 335, 125, 35, "", false, weaponsPanel.window[1])
weaponsPanel.radiobutton[1] = guiCreateRadioButton(495, 155, 74, 15, "Weapon", false, weaponsPanel.window[1])
guiSetFont(weaponsPanel.radiobutton[1], "default-bold-small")
weaponsPanel.radiobutton[2] = guiCreateRadioButton(605, 155, 74, 15, "Ammo", false, weaponsPanel.window[1])
guiSetFont(weaponsPanel.radiobutton[2], "default-bold-small")
weaponsPanel.label[3] = guiCreateLabel(480, 114, 199, 21, "Select item", false, weaponsPanel.window[1])
guiSetFont(weaponsPanel.label[3], "default-bold-small")
guiLabelSetColor(weaponsPanel.label[3], 45, 228, 26)
guiLabelSetHorizontalAlign(weaponsPanel.label[3], "center", false)
weaponsPanel.label[4] = guiCreateLabel(536, 293, 98, 40, "Total Cost", false, weaponsPanel.window[1])
weaponsPanel.label[5] = guiCreateLabel(536, 273, 98, 40, "Clips ammo", false, weaponsPanel.window[1])
guiSetFont(weaponsPanel.label[4], "default-bold-small")
guiSetFont(weaponsPanel.label[5], "default-bold-small")
guiLabelSetHorizontalAlign(weaponsPanel.label[4], "center", false)
guiLabelSetHorizontalAlign(weaponsPanel.label[5], "center", false)

function loadmods(code)
	triggerServerEvent("loadWeaponsXML",localPlayer,code)
end

addEvent("returnWeaponsXML",true)
addEventHandler("returnWeaponsXML",root,function(tables,prime)
	if prime then
		aSkins = {}
		aSkins = tables
		aListSkins(prime)
	else
		exports.NGCdxmsg:createNewDxMessage("Weapons list aren't loading from the server , please contact a developer",255,0,0)
		return false
	end
end)


function aListSkins(modex)
	aListSkinsx(modex)
	triggerServerEvent("getWeaponBought",localPlayer)
end

addEvent("sendWeaponsBought",true)
addEventHandler("sendWeaponsBought",root,function(tbl,wep)
	if tbl then
		if wep == 0 then
			guiGridListSetItemColor( weaponsPanel.gridlist[1], tbl, 1,255,0,0)
		else
			guiGridListSetItemColor( weaponsPanel.gridlist[1], tbl, 1,0,255,0)
		end
	end
end)



function aListSkinsx( modex,t,w )
	guiGridListClear( weaponsPanel.gridlist[1] )
	if modex == 2 then
		for name, group in pairs ( aSkins ) do
			if (name ~= "Skins" or name == "Skins") then
				local row = guiGridListAddRow ( weaponsPanel.gridlist[1] )
				if name ~= "Thrown" and name ~= "Misc" then
					guiGridListSetItemText ( weaponsPanel.gridlist[1], row, 1, name, true, false )
					guiGridListSetItemColor( weaponsPanel.gridlist[1], row, 1,255,255,255)
					for id, mode in ipairs ( aSkins[name] ) do
						row = guiGridListAddRow ( weaponsPanel.gridlist[1] )
						guiGridListSetItemText ( weaponsPanel.gridlist[1], row, 1,"Weapon", false, true )
						guiGridListSetItemText ( weaponsPanel.gridlist[1], row, 2, mode["name"], false, true )
						guiGridListSetItemText ( weaponsPanel.gridlist[1], row,3, mode["model"], false, true )
						guiGridListSetItemText(weaponsPanel.gridlist[1], row, 4,mode["clip"], false, true)
						guiGridListSetItemText(weaponsPanel.gridlist[1], row, 5,mode["weaponCost"], false, true)
						guiGridListSetItemData(weaponsPanel.gridlist[1], row, 1,mode["imgPath"])
						guiGridListSetItemData(weaponsPanel.gridlist[1], row, 2,mode["weaponCost"])
						guiGridListSetItemData(weaponsPanel.gridlist[1], row, 4,mode["model"])
						triggerServerEvent("getWeaponBought",localPlayer,row,mode["model"])
					end
				end
			end
		end
		guiGridListSetSortingEnabled ( weaponsPanel.gridlist[1], false )
	else
		for name, group in pairs ( aSkins ) do
			if (name ~= "Skins" or name == "Skins") then
				local row = guiGridListAddRow ( weaponsPanel.gridlist[1] )
				guiGridListSetItemText ( weaponsPanel.gridlist[1], row, 1, name, true, false )
				guiGridListSetItemColor( weaponsPanel.gridlist[1], row, 1,255,255,255)
				for id, mode in ipairs ( aSkins[name] ) do
					row = guiGridListAddRow ( weaponsPanel.gridlist[1] )
					guiGridListSetItemText ( weaponsPanel.gridlist[1], row, 1,"Ammo", false, true )
					guiGridListSetItemText ( weaponsPanel.gridlist[1], row, 2, mode["name"], false, true )
					guiGridListSetItemText ( weaponsPanel.gridlist[1], row,3, mode["model"], false, true )
					guiGridListSetItemText(weaponsPanel.gridlist[1], row, 4,mode["clip"], false, true)
					guiGridListSetItemText(weaponsPanel.gridlist[1], row, 5,mode["clipCost"], false, true)
					guiGridListSetItemData(weaponsPanel.gridlist[1], row, 1,mode["imgPath"])
					guiGridListSetItemData(weaponsPanel.gridlist[1], row, 2,mode["clipCost"])
					if name ~= "Misc" then
						guiGridListSetItemData(weaponsPanel.gridlist[1], row, 3,mode["clipCost"])
					end
					guiGridListSetItemData(weaponsPanel.gridlist[1], row, 4,mode["model"])
					guiGridListSetItemData(weaponsPanel.gridlist[1], row, 5,mode["clipCost"])
					--guiGridListSetItemData(weaponsPanel.gridlist[1], row, 6,mode["clip"])
					triggerServerEvent("getWeaponBought",localPlayer,row,mode["model"])
				end
			end
		end
		guiGridListSetSortingEnabled ( weaponsPanel.gridlist[1], false )
	end
end

function loadPanel()
	showCursor(true)
	loadmods(2)
	prime = 2
	guiSetVisible(weaponsPanel.window[1],true)
	guiRadioButtonSetSelected(weaponsPanel.radiobutton[1], true)
end


local antiTimer = {}
addEventHandler("onClientGUIClick",root,function()
	if source == weaponsPanel.radiobutton[1] then
		loadmods(2)
		prime = 2
		resetThings()
	elseif	source == weaponsPanel.radiobutton[2] then
		loadmods(1)
		prime = 1
		resetThings()
	elseif source == weaponsPanel.edit[1] then
		guiSetInputMode("no_binds_when_editing")
	elseif source == weaponsPanel.gridlist[1] then
		local we = guiGridListGetItemText(weaponsPanel.gridlist[1], guiGridListGetSelectedItem(weaponsPanel.gridlist[1]), 1)
		if (guiGridListGetItemText(weaponsPanel.gridlist[1], guiGridListGetSelectedItem(weaponsPanel.gridlist[1]), 2) ~= "") then
			if we then
				resetThings()
				local imgpath = guiGridListGetItemData(weaponsPanel.gridlist[1], guiGridListGetSelectedItem(weaponsPanel.gridlist[1]), 1)
				local cost = guiGridListGetItemData(weaponsPanel.gridlist[1], guiGridListGetSelectedItem(weaponsPanel.gridlist[1]), 2)
				local kd = guiGridListGetItemText(weaponsPanel.gridlist[1], guiGridListGetSelectedItem(weaponsPanel.gridlist[1]), 3)
				if tonumber(kd) == 200 then
					weaponSlot = 0
				else
					weaponSlot = getSlotFromWeapon ( kd )
				end
				if imgpath and cost and weaponSlot then
					setPedWeaponSlot(localPlayer,tonumber(weaponSlot))
					img = guiCreateStaticImage(536, 171, 96, 81,imgpath, false, weaponsPanel.window[1])
					guiSetText(weaponsPanel.label[2],"Cost: $"..cvtNumber(cost))
					triggerServerEvent("setPWS",localPlayer,tonumber(weaponSlot))
					--outputDebugString(weaponSlot)
				end
			end
		end
	elseif source == weaponsPanel.button[2] then
		resetThings()
		guiSetVisible(weaponsPanel.window[1],false)
		showCursor(false)
		--guiSetInputMode("allow_binds")
	elseif source == weaponsPanel.button[1] then
		if isTimer(antiTimer) then return false end
		antiTimer = setTimer(function() end,2000,1)
		if guiRadioButtonGetSelected(weaponsPanel.radiobutton[2]) then
			local wes = guiGridListGetItemText(weaponsPanel.gridlist[1], guiGridListGetSelectedItem(weaponsPanel.gridlist[1]), 1)
			if wes then
				local id = guiGridListGetItemData(weaponsPanel.gridlist[1], guiGridListGetSelectedItem(weaponsPanel.gridlist[1]), 4)
				local cost = guiGridListGetItemData(weaponsPanel.gridlist[1], guiGridListGetSelectedItem(weaponsPanel.gridlist[1]), 2)
				local cost2 = guiGridListGetItemData(weaponsPanel.gridlist[1], guiGridListGetSelectedItem(weaponsPanel.gridlist[1]), 5)
				local clips = guiGridListGetItemText(weaponsPanel.gridlist[1], guiGridListGetSelectedItem(weaponsPanel.gridlist[1]), 4)
				local amount = guiGetText(weaponsPanel.edit[1])
				if id == "8" or id == "2" or id == "4" or id == "5" or id == "7" or id == "10" or id == "12" or id == "15" then
					if id ~= "200" then
						if cost2 then
							triggerServerEvent("buyWeaponMisc",localPlayer,tostring(id),cost2)
							guiSetText( weaponsPanel.label[5], "Clips ammo" )
							guiSetText( weaponsPanel.label[4], "Total Cost" )
							guiSetText( weaponsPanel.label[2],"Cost:" )
							guiSetText( weaponsPanel.edit[1], "" )
						end
					end
				elseif id == "200" then
					exports.cpicker:openPicker("ammuLaser",false,"AUR ~ Pick a Laser Color")
				elseif id ~= "200" or id ~= "2" or id ~= "4" or id ~= "5" or id ~= "7" or id ~= "10" or id ~= "12" or id ~= "15" or id ~= "8" then
					if cost then
						if amount and tonumber(amount) and tonumber(amount) > 0 then
							if clips then
								local totall = cost*amount
								local pack = clips*amount
								if getPlayerMoney(localPlayer) < totall then
									return
									false
								else
									local weaponSlot = getSlotFromWeapon(tonumber(id))
									local totalAmmo = getPedTotalAmmo( localPlayer,weaponSlot ) + pack
									if totalAmmo <= 0 or totalAmmo >= 9000 then
										if getPedWeapon(localPlayer,weaponSlot) == tonumber(id) then
											exports.NGCdxmsg:createNewDxMessage("You can't purchase more than 9000 ammo",255,0,0)
											return false
										end
									end
									if tonumber(id) == 36 then
										if getPedWeapon(localPlayer,weaponSlot) == tonumber(id) then
											local totalAmmo = getPedTotalAmmo( localPlayer,7 ) + pack
											if totalAmmo > 2 then
												exports.NGCdxmsg:createNewDxMessage("You can't purchase more than 2 ammo for Javelin",255,0,0)
												return false
											end
										end
									end
									triggerServerEvent("buyWeaponAmmoByID",localPlayer,tostring(id),totall,pack)
									guiSetText( weaponsPanel.label[5], "Clips ammo" )
									guiSetText( weaponsPanel.label[4], "Total Cost" )
									guiSetText( weaponsPanel.label[2],"Cost:" )
									guiSetText( weaponsPanel.edit[1], "" )
								end
							end
						end
					end
				end
			end
		elseif guiRadioButtonGetSelected(weaponsPanel.radiobutton[1]) then
			local wes = guiGridListGetItemText(weaponsPanel.gridlist[1], guiGridListGetSelectedItem(weaponsPanel.gridlist[1]), 1)
			if wes then
				local cost = guiGridListGetItemData(weaponsPanel.gridlist[1], guiGridListGetSelectedItem(weaponsPanel.gridlist[1]), 2)
				local id = guiGridListGetItemData(weaponsPanel.gridlist[1], guiGridListGetSelectedItem(weaponsPanel.gridlist[1]), 4)
				if cost and id then
					triggerServerEvent("buyWeaponByID",localPlayer,tostring(id),cost)
					guiSetText( weaponsPanel.label[5], "Clips ammo" )
					guiSetText( weaponsPanel.label[4], "Total Cost" )
					guiSetText( weaponsPanel.label[2],"Cost:" )
					guiSetText( weaponsPanel.edit[1], "" )
					aListSkins(prime)
				end
			end
		end
	end
end)



function buyLaser2(id,hex,r,g,b)
	if id == "ammuLaser" then
		local cost = 5000
		local tName = getTeamName(getPlayerTeam(localPlayer))
		if tName == exports.DENjob:getFirstLaw() then
			cost = 1000
		else
			cost = 5000
		end
		triggerServerEvent("NGCammu.buyLaser",localPlayer,cost,r,g,b)
		guiSetText( weaponsPanel.label[5], "Clips ammo" )
		guiSetText( weaponsPanel.label[4], "Total Cost" )
		guiSetText( weaponsPanel.label[2],"Cost:" )
		guiSetText( weaponsPanel.edit[1], "" )
	end
end
addEvent("onColorPickerOK",true)
addEventHandler("onColorPickerOK",root,buyLaser2)

function resetThings()
	setElementData(localPlayer,"isPlayerInAmmunation",false)
	guiSetText( weaponsPanel.label[5], "Clips ammo" )
	guiSetText( weaponsPanel.label[4], "Total Cost" )
	guiSetText( weaponsPanel.label[2],"Cost:" )
	guiSetText( weaponsPanel.edit[1], "" )
	if isElement(img) then destroyElement(img) end
end

function removeLetters(element)
	local txts2 = guiGetText(element)
	local removed = string.gsub(txts2, "[^0-9]", "")
	if (removed ~= txts2) then
		guiSetText(element, removed)
	end
	local txts = guiGetText(element)
	if ( txts ~= "" and tonumber( txts2 ) and tonumber( txts2 ) > 0) then
		local cost = guiGridListGetItemData(weaponsPanel.gridlist[1], guiGridListGetSelectedItem(weaponsPanel.gridlist[1]), 3)
		local clipo = guiGridListGetItemText(weaponsPanel.gridlist[1], guiGridListGetSelectedItem(weaponsPanel.gridlist[1]), 4)
		if cost then
			guiSetText( weaponsPanel.label[4], "Total Cost\n$ "..cvtNumber(txts*cost) )
			guiSetText( weaponsPanel.label[5], "Clips Ammo: "..clipo*txts2 )
			if txts*cost > getPlayerMoney(localPlayer) then
				guiSetText( weaponsPanel.label[4], "Total Cost" )
				guiSetText( weaponsPanel.edit[1], "" )
				guiSetText( weaponsPanel.label[5], "Clips Ammo" )
				exports.NGCdxmsg:createNewDxMessage("You don't have money to buy "..txts2.." clips",255,0,0)
			end
		else
			guiSetText( weaponsPanel.label[4], "Total Cost" )
			guiSetText( weaponsPanel.edit[1], "" )
			guiSetText( weaponsPanel.label[5], "Clips Ammo" )
		end
	else
		guiSetText( weaponsPanel.label[4], "Total Cost" )
		guiSetText( weaponsPanel.edit[1], "" )
	end
end
addEventHandler( "onClientGUIChanged", weaponsPanel.edit[1], removeLetters)

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


warnWindow1 = guiCreateWindow(517,281,247,133,"AUR ~ Ammu Nation",false)
warnLabel1 = guiCreateLabel(96,27,55,17,"Warning!",false,warnWindow1)
guiLabelSetColor(warnLabel1,225,165,0)
guiSetFont(warnLabel1,"default-bold-small")
warnButton1 = guiCreateButton(33,97,181,27,"Close Warning",false,warnWindow1)
warnLabel2 = guiCreateLabel(42,53,160,17,"You dont have this weapon!",false,warnWindow1)
guiLabelSetColor(warnLabel2,225,225,225)
guiSetFont(warnLabel2,"default-bold-small")
warnLabel3 = guiCreateLabel(9,69,227,17,"First buy the weapon, and then ammo.",false,warnWindow1)
guiLabelSetColor(warnLabel3,225,225,225)
guiSetFont(warnLabel3,"default-bold-small")
-- 2
warnWindow2 = guiCreateWindow(517,281,247,133,"AUR ~ Ammu Nation",false)
warnLabel1 = guiCreateLabel(96,27,55,17,"Warning!",false,warnWindow2)
guiLabelSetColor(warnLabel1,225,165,0)
guiSetFont(warnLabel1,"default-bold-small")
warnButton2 = guiCreateButton(33,97,181,27,"Close Warning",false,warnWindow2)
warnLabel2 = guiCreateLabel(36,53,174,17,"You already have this weapon!",false,warnWindow2)
guiLabelSetColor(warnLabel2,225,225,225)
guiSetFont(warnLabel2,"default-bold-small")
warnLabel3 = guiCreateLabel(9,69,227,17,"Now you can buy ammo for this weapon!",false,warnWindow2)
guiLabelSetColor(warnLabel3,225,225,225)
guiSetFont(warnLabel3,"default-bold-small")
-- 3
warnWindow3 = guiCreateWindow(517,281,247,133,"AUR ~ Ammu Nation",false)
warnLabel1 = guiCreateLabel(96,27,55,17,"Succes!",false,warnWindow3)
guiLabelSetColor(warnLabel1,0,200,0)
guiSetFont(warnLabel1,"default-bold-small")
warnButton3 = guiCreateButton(33,97,181,27,"Close Warning",false,warnWindow3)
warnLabel2 = guiCreateLabel(62,55,210,17,"You have bought a weapon!",false,warnWindow3)
guiLabelSetColor(warnLabel2,225,225,225)
guiSetFont(warnLabel2,"default-bold-small")
warnLabel3 = guiCreateLabel(9,69,227,17,"Now you can buy ammo for this weapon!",false,warnWindow3)
guiLabelSetColor(warnLabel3,225,225,225)
guiSetFont(warnLabel3,"default-bold-small")
-- 4
warnWindow4 = guiCreateWindow(517,281,247,133,"AUR ~ Ammu Nation",false)
warnLabel1 = guiCreateLabel(96,27,55,17,"Warning!",false,warnWindow4)
guiLabelSetColor(warnLabel1,225,165,0)
guiSetFont(warnLabel1,"default-bold-small")
warnButton4 = guiCreateButton(33,97,181,27,"Close Warning",false,warnWindow4)
warnLabel2 = guiCreateLabel(72,55,110,17,"Not enough money!",false,warnWindow4)
guiLabelSetColor(warnLabel2,225,225,225)
guiSetFont(warnLabel2,"default-bold-small")
warnLabel3 = guiCreateLabel(37,69,175,17,"You dont have enough money.",false,warnWindow4)

guiSetFont(warnLabel3,"default-bold-small")




guiWindowSetMovable (warnWindow1, true)
guiWindowSetSizable (warnWindow1, false)
guiSetVisible (warnWindow1, false)

local screenW,screenH=guiGetScreenSize()
local windowW,windowH=guiGetSize(warnWindow1,false)
local x,y = (screenW-windowW)/2,(screenH-windowH)/2
guiSetPosition(warnWindow1,x,y,false)

guiWindowSetMovable (warnWindow2, true)
guiWindowSetSizable (warnWindow2, false)
guiSetVisible (warnWindow2, false)


local screenW,screenH=guiGetScreenSize()
local windowW,windowH=guiGetSize(warnWindow2,false)
local x,y = (screenW-windowW)/2,(screenH-windowH)/2
guiSetPosition(warnWindow2,x,y,false)

guiWindowSetMovable (warnWindow3, true)
guiWindowSetSizable (warnWindow3, false)
guiSetVisible (warnWindow3, false)

local screenW,screenH=guiGetScreenSize()
local windowW,windowH=guiGetSize(warnWindow3,false)
local x,y = (screenW-windowW)/2,(screenH-windowH)/2
guiSetPosition(warnWindow3,x,y,false)

guiWindowSetMovable (warnWindow4, true)
guiWindowSetSizable (warnWindow4, false)
guiSetVisible (warnWindow4, false)


local screenW,screenH=guiGetScreenSize()
local windowW,windowH=guiGetSize(warnWindow4,false)
local x,y = (screenW-windowW)/2,(screenH-windowH)/2
guiSetPosition(warnWindow4,x,y,false)


addEventHandler("onClientGUIClick", warnButton1, function() guiSetVisible(warnWindow1, false) end, false)
addEventHandler("onClientGUIClick", warnButton2, function() guiSetVisible(warnWindow2, false) end, false)
addEventHandler("onClientGUIClick", warnButton3, function() guiSetVisible(warnWindow3, false) end, false)
addEventHandler("onClientGUIClick", warnButton4, function() guiSetVisible(warnWindow4, false) end, false)


function warn1 ()

	--guiSetVisible(warnWindow1,true)
	--showCursor(true,true)
	--guiBringToFront ( warnWindow1 )
	exports.NGCnote:addNote("Warn1","You don't have this weapon",255,0,0,5000)
	guiSetVisible(weaponsPanel.window[1],false)
	showCursor(false)
end
addEvent ("warn1", true)
addEventHandler ("warn1", getRootElement(), warn1)

function warn2 ()

	--guiSetVisible(warnWindow2,true)
	--showCursor(true,true)
	--guiBringToFront ( warnWindow2 )
	exports.NGCnote:addNote("Warn2","You already have this weapon",255,0,0,5000)
end
addEvent ("warn2", true)
addEventHandler ("warn2", getRootElement(), warn2)

function warn3 ()

	--guiSetVisible(warnWindow3,true)
	--showCursor(true,true)
	--guiBringToFront ( warnWindow3 )
	exports.NGCnote:addNote("Warn3","You have bought a weapon",255,0,0,5000)

end
addEvent ("warn3", true)
addEventHandler ("warn3", getRootElement(), warn3)

function warn4 ()

	--guiSetVisible(warnWindow4,true)
	--showCursor(true,true)
	--guiBringToFront ( warnWindow4 )
	exports.NGCnote:addNote("Warn4","You dont have enough money",255,0,0,5000)
	guiSetVisible(weaponsPanel.window[1],false)
	showCursor(false)
end
addEvent ("warn4", true)
addEventHandler ("warn4", getRootElement(), warn4)


-- Set marker possitions in table and create markers
local ammoMarkers2 = {
--[1]={1443,-1055,213, 0, 0},
[1]={1372.35,-1292.05,13.54,0,0},
[2]={1378.52,-1284.94,13.54,0,0},
[3]={2397.47,-1986.32,13.54,0,0},
[4]={237.86,-169.83,-3.75,0, 0},
[5]={2322.23,57.43,21.58,0,0},
[6]={2168.02,931.58,11.09,0,0},
[7]={2548.03,2071.46,11.1,0,0},
[8]={772.67,1872.86,5.11,0, 0},
[9]={-320.55,830.38,14.24,0,0},
[10]={295.64, -38, 1001.51, 1, 2},
[11]={-2097.11,-2467.27,30.62,0,0},
[12]={311.88, -164.52, 999.6, 6, 11}
}


function ammoMarkerHit2( hitPlayer, matchingDimension )
	if matchingDimension then
		if hitPlayer == localPlayer then
			if getElementType(hitPlayer) == "player" and not isPedInVehicle(localPlayer) then
				if getElementData(hitPlayer,"isPlayerOnF6") ~= true then
					local px,py,pz = getElementPosition ( hitPlayer )
					local mx, my, mz = getElementPosition ( source )
					local vehicle = getPedOccupiedVehicle (localPlayer)
					if not vehicle then
						if ( pz-3 < mz ) and ( pz+3 > mz ) then
							loadPanel()
						end
					end
				end
			end
		end
	end
end


for ID in pairs(ammoMarkers2) do
	local x, y, z = ammoMarkers2[ID][1], ammoMarkers2[ID][2], ammoMarkers2[ID][3]
	local interior = ammoMarkers2[ID][4]
	local dimension = ammoMarkers2[ID][5]
	local ammoShopMarker2 = createMarker(x,y,z -1,"cylinder",1.5,200,0,0,225)
	setElementInterior(ammoShopMarker2, interior)
	setElementDimension( ammoShopMarker2, tonumber(dimension) )

	addEventHandler("onClientMarkerHit", ammoShopMarker2, ammoMarkerHit2)
	addEventHandler("onClientMarkerLeave", ammoShopMarker2,
		function(hitPlayer)
			if hitPlayer == localPlayer then
			resetThings()
			guiSetVisible(weaponsPanel.window[1],false)
			showCursor(false)
			end
		end,false)
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
--	local key6 = getKeyBoundToCommand("takehit")
	local key7 = getKeyBoundToCommand("dropkit")
	if key or key2 or key3 or key4 or key5  or key7 then
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
	--	elseif key6 then
	--		theKey = "takehit"
		elseif key7 then
			theKey = "dropkit"
		end
		if disabled then return end
		disabled = true
	else
		if not disabled then return end
		disabled = false
	end
end
setTimer(unbindTheBindedKey,500,0)

function forceHide()
	resetThings()
	guiSetVisible(weaponsPanel.window[1],false)
	showCursor(false)
	setElementData(localPlayer,"isPlayerInAmmunation",false)
end

function isPlayerInAmmunation()
	if inAmmo then
		return true
	else
		return false
	end
end

setTimer(function()
	if weaponsPanel.window[1] and guiGetVisible(weaponsPanel.window[1]) then
		for k,v in ipairs(getElementsByType("gui-window")) do
			if weaponsPanel.window[1] ~= v then
				if guiGetVisible(v) then
					resetThings()
					guiSetVisible(weaponsPanel.window[1],false)
					showCursor(false)
					setElementData(localPlayer,"isPlayerInAmmunation",false)
				end
			end
		end
	end
	if weaponsPanel.window[1] and guiGetVisible(weaponsPanel.window[1]) then
		inAmmo = true
	end
	if weaponsPanel.window[1] and guiGetVisible(weaponsPanel.window[1]) then
		local c,m = exports.NGCmanagement:isPlayerLagging(localPlayer)
		if not c then
			resetThings()
			guiSetVisible(weaponsPanel.window[1],false)
			showCursor(false)
			inAmmo = false
			exports.NGCnote:addNote("Weapons Lag","Ammunation panel is closed due "..m,255,0,0,3000)
		end
	end
	if weaponsPanel.window[1] and guiGetVisible(weaponsPanel.window[1]) then
		if stuck == true then
			forceHide()
			msg("You are lagging due Huge Network Loss you can't open Ammunation panel")
		end
		if getPlayerPing(localPlayer) >= 600 then
			forceHide()
			msg("You are lagging due PING you can't open Ammunation panel")
		end
		if getElementDimension(localPlayer) == exports.server:getPlayerAccountID(localPlayer) then
			forceHide()
			msg("You can't open Ammunation panel in house or afk zone!")
		end
		if tonumber(getElementData(localPlayer,"FPS") or 5) < 5 then
			forceHide()
			msg("You are lagging due FPS you can't open Ammunation panel")
		end
		if getElementData(localPlayer,"drugsOpen") then
			forceHide()
			msg("Please close Drugs panel")
		end
		if disabled then
			forceHide()
			exports.NGCdxmsg:createNewDxMessage("You can't use Ammunation system while bounded ("..theKey..")",255,0,0)
		end
		if isConsoleActive() then
			forceHide()
			exports.NGCdxmsg:createNewDxMessage("You can't use Ammunation system while Console window is open",255,0,0)
		end
		if isChatBoxInputActive() then
			forceHide()
			exports.NGCdxmsg:createNewDxMessage("You can't use Ammunation system while Chat input box is open",255,0,0)
		end
		if isMainMenuActive() then
			forceHide()
			msg("Please close MTA Main Menu")
			exports.NGCdxmsg:createNewDxMessage("You can't use Ammunation system while MTA Main Menu is open",255,0,0)
		end
	end
end,500,0)


function msg(m)
	exports.NGCnote:addNote("Weapons Lag",m,255,0,0,3000)
end
