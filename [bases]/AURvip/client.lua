screenW, screenH = guiGetScreenSize()
gui_elements = {}
buttons = {}
vipHours = "0"
local mRow = nil
local hRow = nil

local aObjects ={
        { "Grass Hat", 861,scale=0.5},
        { "Grass Hat 2", 862,scale=0.5 },
        { "Pizza Box", 2814 },
        { "Roulete", 1895,scale=0.3 },
        { "Car model", 2485 },
        { "Ventilator", 1661,scale=0.7 },
		{ "Green Flag", 2993 },
		{ "TV", 1518,scale=0.7},
		{ "Arrow", 1318,scale=0.5 },
	    { "Tree", 811,scale=0.3 },
		{ "Skull",1254},
		{ "Dolphin",1607,scale=0.05},
		{ "Parking Sign",1233,scale=0.3},
        { "WW2 Hat", 2053 },
		{ "Captain 3", 2054 },
		{ "Donuts",  2222},
     	{ "Hoop",  1316, scale=0.1},
		{ "Turtle",1609,scale=0.1},
		{ "SAM",3267,scale=0.2},
		{ "MG",2985,scale=0.5},
		{ "Money",1274,scale=3},
		{ "Para",3108,scale=0.1},
		{ "Torch",3461,scale=0.5},
		{ "Remove hat" }

};


theMasks = {
	{"Demon",1544,scale=1,rotx=0,roty=0,rotz=0,z=0.038,y=0.030},
	{"Demon2",1664,scale=1,rotx=0,roty=270,rotz=0,z=0.06,y=0.025},
	{"Ape",1543,scale=1,rotx=0,roty=270,rotz=0,z=0.06,y=0.025},
	{"Ape2",1546,scale=1,rotx=0,roty=270,rotz=0,z=0.06,y=0.025},
	{"Hockey",1551,scale=1,rotx=0,roty=270,rotz=0,z=0.06,y=0.040},
	{"Pig",1667,scale=1,rotx=0,roty=270,rotz=0,z=0.06,y=0.040},
	{"Mickey",1668,scale=0.9,rotx=0,roty=0,rotz=90,z=0.06,y=0.025},
	{"Vendetta",1669,scale=1,rotx=0,roty=270,rotz=0,z=0.06,y=0.11},
	{"Cat",1517,scale=1,rotx=0,roty=0,rotz=90,z=-0.6,y=0.008},
	{"Bird",1512,scale=1,rotx=0,roty=0,rotz=90,z=-0.6,y=-0.05},
	{"Fox",1510,scale=1,rotx=0,roty=0,rotz=90,z=-0.6,y=0.008},
	{"Fox2",1509,scale=1,rotx=0,roty=0,rotz=90,z=-0.6,y=0.008},
	{"Iron man",1455,scale=1,rotx=0,roty=0,rotz=90,z=-0.6,y=-0.01},
	{"Biker helmet",1951,scale=1,rotx=0,roty=0,rotz=90,z=-0.6,y=-0.006},
	{"bunnyears",1950,scale=1,rotx=90,roty=0,rotz=0,z=0.06,y=-0.04},
	{ "Remove mask" }
}

closeButton = guiCreateButton(0.26, 0.76, 0.48, 0.03, "", true)
getHat = guiCreateButton(0.27, 0.63, 0.14, 0.02, "", true)
getVipSkin = guiCreateButton(0.27, 0.43, 0.14, 0.02, "", true)
getVehicle = guiCreateButton(0.43, 0.43, 0.14, 0.02, "", true)
toggleJetpack = guiCreateButton(0.43, 0.63, 0.14, 0.02, "", true)
toggleVIPChat = guiCreateButton(0.43, 0.58, 0.14, 0.02, "", true)
getMask = guiCreateButton(0.59, 0.63, 0.14, 0.02, "", true)
convertVIPHours = guiCreateButton(0.60, 0.43, 0.14, 0.02, "", true)

skinMila = guiCreateCheckBox(0.272, 0.34, 0.13, 0.02, "Mila", false, true)
skinTommy = guiCreateCheckBox(0.272, 0.36, 0.13, 0.02, "Tommy", false, true)
skinChloe = guiCreateCheckBox(0.272, 0.38, 0.13, 0.02, "Chloe", false, true)
skinHitman = guiCreateCheckBox(0.272, 0.40, 0.13, 0.02, "Hitman", false, true)

vehicleCar = guiCreateCheckBox(0.4325, 0.34, 0.13, 0.02, "Car", false, true)
vehicleMaverick = guiCreateCheckBox(0.4325, 0.36, 0.13, 0.02, "Maverick", false, true)
vehicleBike = guiCreateCheckBox(0.4325, 0.38, 0.13, 0.02, "Bike", false, true)
vehicleBoat = guiCreateCheckBox(0.4325, 0.40, 0.13, 0.02, "Boat", false, true)

convertVIPEdit = guiCreateEdit(0.599, 0.37, 0.13, 0.03, "Number of vip hours", true)

hatsGridlist = guiCreateGridList(0.27, 0.54, 0.135, 0.085, true)
guiGridListAddColumn(hatsGridlist, "Hat name", 0.9)
maskGridlist = guiCreateGridList(0.597, 0.54, 0.135, 0.085, true)
guiGridListAddColumn(maskGridlist, "Mask name", 0.9)

for i,m_obj in ipairs( aObjects ) do
	hRow = guiGridListAddRow( hatsGridlist );
	guiGridListSetItemText (hatsGridlist, hRow, 1, tostring( m_obj [ 1 ] ), false, false );
	if m_obj [ 2 ] then
		guiGridListSetItemData (hatsGridlist, hRow, 1, tostring( m_obj [ 2 ] ) )
	end
end
for i,m_obj in ipairs( theMasks ) do
	mRow = guiGridListAddRow( maskGridlist );
	guiGridListSetItemText (maskGridlist, mRow, 1, tostring( m_obj [ 1 ] ), false, false );
	if m_obj [ 2 ] then
		guiGridListSetItemData (maskGridlist, mRow, 1, tostring( m_obj [ 2 ] ) )
	end
end

gui_elements = {closeButton, getHat, getVipSkin, getVehicle, toggleJetpack, toggleVIPChat, getMask, convertVIPHours, skinMila, skinTommy, skinChloe, skinHitman, vehicleCar, vehicleMaverick, vehicleBike, vehicleBoat, convertVIPEdit, hatsGridlist, maskGridlist}
buttons = {closeButton, getHat, getVipSkin, getVehicle, toggleJetpack, toggleVIPChat, getMask, convertVIPHours}

for i, v in ipairs(buttons) do
    guiSetAlpha(v, 0.00)
end

for i, v in ipairs(gui_elements) do
    guiSetVisible(v, false)
end

function dxVipPanel()
    dxDrawRectangle(screenW * 0.2617, screenH * 0.2111, screenW * 0.4766, screenH * 0.5792, tocolor(0, 0, 0, 175), false)
    dxDrawRectangle(screenW * 0.2617, screenH * 0.2111, screenW * 0.4766, screenH * 0.0486, tocolor(0, 0, 0, 175), false)
    dxDrawText("AuroraRPG - VIP Panel", screenW * 0.2609, screenH * 0.2083, screenW * 0.7383, screenH * 0.2597, tocolor(255, 255, 255, 255), 1.30, "default-bold", "center", "center", false, false, false, false, false)
    dxDrawRectangle(screenW * 0.2617, screenH * 0.7625, screenW * 0.4766, screenH * 0.0278, tocolor(0, 0, 0, 175), false)
    dxDrawText("Close", screenW * 0.2609, screenH * 0.7611, screenW * 0.7383, screenH * 0.7903, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
    dxDrawText(vipHours.." vip hours left", screenW * 0.2680, screenH * 0.2653, screenW * 0.7305, screenH * 0.2944, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
    dxDrawRectangle(screenW * 0.2695, screenH * 0.3111, screenW * 0.1336, screenH * 0.1403, tocolor(0, 0, 0, 175), false)
    dxDrawLine(screenW * 0.2695, screenH * 0.3361, screenW * 0.4031, screenH * 0.3361, tocolor(255, 255, 255, 255), 1, false)
    dxDrawRectangle(screenW * 0.2695, screenH * 0.4264, screenW * 0.1336, screenH * 0.0250, tocolor(254, 254, 254, 175), false)
    dxDrawText("Buy for $5500", screenW * 0.2680, screenH * 0.4264, screenW * 0.4031, screenH * 0.4514, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
    dxDrawRectangle(screenW * 0.5969, screenH * 0.3111, screenW * 0.1336, screenH * 0.1403, tocolor(0, 0, 0, 175), false)
    dxDrawRectangle(screenW * 0.4320, screenH * 0.3111, screenW * 0.1336, screenH * 0.1403, tocolor(0, 0, 0, 175), false)
    dxDrawRectangle(screenW * 0.4320, screenH * 0.5097, screenW * 0.1336, screenH * 0.1403, tocolor(0, 0, 0, 175), false)
    dxDrawRectangle(screenW * 0.5969, screenH * 0.5097, screenW * 0.1336, screenH * 0.1403, tocolor(0, 0, 0, 175), false)
    dxDrawRectangle(screenW * 0.2695, screenH * 0.5097, screenW * 0.1336, screenH * 0.1403, tocolor(0, 0, 0, 175), false)
    dxDrawText("VIP Skins", screenW * 0.2680, screenH * 0.3097, screenW * 0.4031, screenH * 0.3361, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
    dxDrawText("VIP Vehicles", screenW * 0.4305, screenH * 0.3111, screenW * 0.5656, screenH * 0.3375, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
    dxDrawLine(screenW * 0.4320, screenH * 0.3375, screenW * 0.5656, screenH * 0.3375, tocolor(255, 255, 255, 255), 1, false)
    dxDrawRectangle(screenW * 0.4313, screenH * 0.4264, screenW * 0.1344, screenH * 0.0250, tocolor(254, 254, 254, 175), false)
    dxDrawText("Get vehicle", screenW * 0.4305, screenH * 0.4264, screenW * 0.5656, screenH * 0.4514, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
    dxDrawRectangle(screenW * 0.5961, screenH * 0.4264, screenW * 0.1344, screenH * 0.0250, tocolor(254, 254, 254, 175), false)
    dxDrawText("VIP to Money (10K per hour)", screenW * 0.5953, screenH * 0.3111, screenW * 0.7305, screenH * 0.3375, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
    dxDrawLine(screenW * 0.5969, screenH * 0.3375, screenW * 0.7305, screenH * 0.3375, tocolor(255, 255, 255, 255), 1, false)
    dxDrawRectangle(screenW * 0.5961, screenH * 0.6250, screenW * 0.1344, screenH * 0.0250, tocolor(254, 254, 254, 175), false)
    dxDrawText("Convert", screenW * 0.5953, screenH * 0.4264, screenW * 0.7305, screenH * 0.4514, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
    dxDrawText("Get mask", screenW * 0.5953, screenH * 0.6250, screenW * 0.7305, screenH * 0.6500, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
    dxDrawRectangle(screenW * 0.4320, screenH * 0.6250, screenW * 0.1344, screenH * 0.0250, tocolor(254, 254, 254, 175), false)
    dxDrawRectangle(screenW * 0.2695, screenH * 0.6250, screenW * 0.1344, screenH * 0.0250, tocolor(254, 254, 254, 175), false)
    dxDrawText("Toggle jetpack", screenW * 0.4320, screenH * 0.6250, screenW * 0.5672, screenH * 0.6500, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
    dxDrawRectangle(screenW * 0.4328, screenH * 0.5806, screenW * 0.1344, screenH * 0.0250, tocolor(254, 254, 254, 175), false)
    dxDrawText("Toggle VIP chat", screenW * 0.4320, screenH * 0.5806, screenW * 0.5672, screenH * 0.6056, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
    dxDrawText("Get hat", screenW * 0.2695, screenH * 0.6250, screenW * 0.4047, screenH * 0.6500, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
    dxDrawText("VIP Hats", screenW * 0.2680, screenH * 0.5097, screenW * 0.4031, screenH * 0.5361, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
    dxDrawText("VIP Misc Commands", screenW * 0.4305, screenH * 0.5097, screenW * 0.5656, screenH * 0.5361, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
    dxDrawText("VIP Masks", screenW * 0.5953, screenH * 0.5097, screenW * 0.7305, screenH * 0.5361, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
    dxDrawLine(screenW * 0.5969, screenH * 0.5361, screenW * 0.7305, screenH * 0.5361, tocolor(255, 255, 255, 255), 1, false)
    dxDrawLine(screenW * 0.4320, screenH * 0.5361, screenW * 0.5656, screenH * 0.5361, tocolor(255, 255, 255, 255), 1, false)
    dxDrawLine(screenW * 0.2695, screenH * 0.5361, screenW * 0.4031, screenH * 0.5361, tocolor(255, 255, 255, 255), 1, false)
end

function number_mode_function(elementChanged)
    local newText = guiGetText(elementChanged)
    if (newText == getElementData(source, "place_holder")) then
        return false 
    end
    if (not tonumber(newText)) then
        guiSetText(elementChanged, "")
        return false 
    end
    if (tonumber(newText) > 255) then
        guiSetText(elementChanged, "255")
        return true
    elseif (tonumber(newText) < 0) then
        guiSetText(elementChanged, "0")
        return true
    end
    guiSetText(elementChanged, newText)
    return true 
end

function set_number_mode(guiElement, text)
    addEventHandler("onClientGUIChanged", guiElement, number_mode_function)
end

function placeholder_function()
    if (eventName == "onClientGUIFocus") then
        local newText = guiGetText(source)
        if (newText == getElementData(source, "place_holder")) then
            guiSetText(source, "")
        end
    else
        if (guiGetText(source) == "") then
            guiSetText(source, getElementData(source, "place_holder"))
        end
    end
end

function set_placeholder(guiElement)
    addEventHandler("onClientGUIFocus", guiElement, placeholder_function, true)
    addEventHandler("onClientGUIBlur", guiElement, placeholder_function, true)
    setElementData(guiElement, "place_holder", guiGetText(guiElement))
end
set_placeholder(convertVIPEdit)
set_number_mode(convertVIPEdit)

function handleVIPSkinsCheckBox()
    if (source == skinMila) then
        guiCheckBoxSetSelected(skinMila, true)
        guiCheckBoxSetSelected(skinTommy, false)
        guiCheckBoxSetSelected(skinChloe, false)
        guiCheckBoxSetSelected(skinHitman, false)
    end

    if (source == skinTommy) then
        guiCheckBoxSetSelected(skinMila, false)
        guiCheckBoxSetSelected(skinTommy, true)
        guiCheckBoxSetSelected(skinChloe, false)
        guiCheckBoxSetSelected(skinHitman, false)
    end

    if (source == skinChloe) then
        guiCheckBoxSetSelected(skinMila, false)
        guiCheckBoxSetSelected(skinTommy, false)
        guiCheckBoxSetSelected(skinChloe, true)
        guiCheckBoxSetSelected(skinHitman, false)
    end

    if (source == skinHitman) then
        guiCheckBoxSetSelected(skinMila, false)
        guiCheckBoxSetSelected(skinTommy, false)
        guiCheckBoxSetSelected(skinChloe, false)
        guiCheckBoxSetSelected(skinHitman, true)
    end
end
addEventHandler("onClientGUIClick", skinMila, handleVIPSkinsCheckBox, false)
addEventHandler("onClientGUIClick", skinTommy, handleVIPSkinsCheckBox, false)
addEventHandler("onClientGUIClick", skinChloe, handleVIPSkinsCheckBox, false)
addEventHandler("onClientGUIClick", skinHitman, handleVIPSkinsCheckBox, false)

function handleVehicleCheckbox()
    if (source == vehicleCar) then
        guiCheckBoxSetSelected(vehicleCar, true)
        guiCheckBoxSetSelected(vehicleMaverick, false)
        guiCheckBoxSetSelected(vehicleBike, false)
        guiCheckBoxSetSelected(vehicleBoat, false)
    end

    if (source == vehicleMaverick) then
        guiCheckBoxSetSelected(vehicleCar, false)
        guiCheckBoxSetSelected(vehicleMaverick, true)
        guiCheckBoxSetSelected(vehicleBike, false)
        guiCheckBoxSetSelected(vehicleBoat, false)
    end

    if (source == vehicleBike) then
        guiCheckBoxSetSelected(vehicleCar, false)
        guiCheckBoxSetSelected(vehicleMaverick, false)
        guiCheckBoxSetSelected(vehicleBike, true)
        guiCheckBoxSetSelected(vehicleBoat, false)
    end

    if (source == vehicleBoat) then
        guiCheckBoxSetSelected(vehicleCar, false)
        guiCheckBoxSetSelected(vehicleMaverick, false)
        guiCheckBoxSetSelected(vehicleBike, false)
        guiCheckBoxSetSelected(vehicleBoat, true)
    end
end
addEventHandler("onClientGUIClick", vehicleCar, handleVehicleCheckbox, false)
addEventHandler("onClientGUIClick", vehicleMaverick, handleVehicleCheckbox, false)
addEventHandler("onClientGUIClick", vehicleBike, handleVehicleCheckbox, false)
addEventHandler("onClientGUIClick", vehicleBoat, handleVehicleCheckbox, false)

function toggleVIP(vip)
	vipHours = tostring(vip)
    local visibility = (not guiGetVisible(closeButton))

    if (visibility) then
        addEventHandler("onClientRender", root, dxVipPanel)
    else
        removeEventHandler("onClientRender", root, dxVipPanel)
    end


    for i, v in ipairs(gui_elements) do
        guiSetVisible(v, visibility)
    end

    guiSetInputMode((visibility and "no_binds_when_editing" or "allow_binds"))
    showCursor(visibility)
end
--addEvent and addEventHandler for opening only one argument - vip, vip = vip hours in string/number both ok, like "5" or 5
addEvent( "openVIP", true )
addEventHandler( "openVIP", localPlayer, toggleVIP )

function getCheckBoxSelected(checkSeriesN)
    if (checkSeriesN == "skin") then
        if (guiCheckBoxGetSelected(skinMila)) then
            return "Mila"
        end

        if (guiCheckBoxGetSelected(skinTommy)) then
            return "Tommy"
        end

        if (guiCheckBoxGetSelected(skinChloe)) then
            return "Chloe"
        end

        if (guiCheckBoxGetSelected(skinHitman)) then
            return "Hitman"
        end

        return false
    elseif (checkSeriesN == "vehicle") then
        if (guiCheckBoxGetSelected(vehicleMaverick)) then
            return "Maverick"
        end

        if (guiCheckBoxGetSelected(vehicleCar)) then
            return "Car"
        end

        if (guiCheckBoxGetSelected(vehicleBike)) then
            return "Bike"
        end

        if (guiCheckBoxGetSelected(vehicleBoat)) then
            return "Boat"
        end

        return false

    end
end

function buttonHandler(button)
    if (button ~= "left") then
        return false 
    end

    if (source == closeButton) then
        toggleVIP()
        return true 
    end

    if (source == getHat) then
        local r = guiGridListGetSelectedItem(hatsGridlist)

        if (r == -1) then
            -- Output error
            return false
        end

        --local hat = guiGridListGetItemText(hatsGridlist, r, 1)

        -- do whatever needed, hat = hat name
		local row, col = guiGridListGetSelectedItem (hatsGridlist)
		if ( row and col and row ~= -1 and col ~= -1 ) then
			local model = tonumber ( guiGridListGetItemData (hatsGridlist, row, 1 ) )
			local scale=1
			local name = ""
			for k,v in pairs(aObjects) do
				if v[2] == model then
					name=v[1]
					if v.scale ~= nil then scale=v.scale break end
				end
			end
			if not getElementData(localPlayer, "isPlayerVIP") then exports.NGCdxmsg:createNewDxMessage("You are not VIP",255,0,0) return end
			if model ~= nil then
				exports.NGCdxmsg:createNewDxMessage("You are now wearing the "..name.." hat",0,255,0)
			end
			triggerServerEvent("vipHats_changeHat",localPlayer,model,scale)
		end
    end

    if (source == getVipSkin) then
        local checkBoxNameSelected = getCheckBoxSelected("skin")
        if (not checkBoxNameSelected) then
            -- Output error
			exports.NGCdxmsg:createNewDxMessage("Please check skin ID first",255,0,0)
            return false 
        end
		setElementData(localPlayer,"skinShopTempSkin",getElementModel(localPlayer))
		if checkBoxNameSelected == "Car" then
			triggerServerEvent("buyVIPSkin",localPlayer,localPlayer,94,5500)
		elseif checkBoxNameSelected == "Maverick" then
			triggerServerEvent("buyVIPSkin",localPlayer,localPlayer,183,5500)
		elseif checkBoxNameSelected == "Bike" then
			triggerServerEvent("buyVIPSkin",localPlayer,localPlayer,52,5500)
		elseif checkBoxNameSelected == "Boat" then
			triggerServerEvent("buyVIPSkin",localPlayer,localPlayer,41,5500)
		end
    end 

    if (source == getVehicle) then
        local checkBoxNameSelected = getCheckBoxSelected("vehicle")
        if (not checkBoxNameSelected) then
            -- Output error
			exports.NGCdxmsg:createNewDxMessage("Please select VIP Vehicle Type",255,0,0)
            return false 
        end
		if checkBoxNameSelected == "Car" then
			id = 526
			sec = true
		elseif checkBoxNameSelected == "Maverick" then
			id = 487
			sec = true
		elseif checkBoxNameSelected == "Bike" then
			id = 522
			sec = true
		elseif checkBoxNameSelected  == "Boat" then
			id = 452
			sec = true
		end
		if sec == true then
			if exports.NGCsafezone:isElementWithinSafeZone(localPlayer) then
				exports.NGCnote:addNote("Vip","You can't spawn VIP vehicle inside safe zone!",255,0,0,5000)
				return false
			end
			triggerServerEvent("getVIPCar",localPlayer,localPlayer,id)
			sec = false
		else
			exports.NGCdxmsg:createNewDxMessage("Please select VIP Vehicle Type",255,0,0)
		end
    end

    if (source == toggleJetpack) then
        -- Do whatever needed
		triggerServerEvent("onGetJetPack",localPlayer,localPlayer)
    end

    if (source == toggleVIPChat) then
        -- Do whatever needed
		triggerServerEvent("togglevchat",localPlayer,localPlayer)
    end

    if (source == getMask) then 
        local r = guiGridListGetSelectedItem(maskGridlist)

        if (r == -1) then
            -- Output error
            return false
        end

        --local mask = guiGridListGetItemText(maskGridlist, r, 1)
		
		local row, col = guiGridListGetSelectedItem (maskGridlist)
		if ( row and col and row ~= -1 and col ~= -1 ) then
			local model = tonumber ( guiGridListGetItemData (maskGridlist, row, 1 ) )
			local scale=1
			local name = ""
			for k,v in pairs(theMasks) do
				if v[2] == model then
					name=v[1]
					rotx,roty,rotz = v.rotx,v.roty,v.rotz
					z=v.z
					y=v.y
					if v.scale ~= nil then scale=v.scale break end
				end
			end
			if not getElementData(localPlayer, "isPlayerVIP") then exports.NGCdxmsg:createNewDxMessage("You are not VIP",255,0,0) return end
			if model ~= nil then
				exports.NGCdxmsg:createNewDxMessage("You are now wearing the "..name.." mask",0,255,0)
			end
			triggerServerEvent("changeMask",localPlayer,model,scale,rotx,roty,rotz,z,y)
		end

        -- do whatever needed, mask = mask name
    end

    if (source == convertVIPHours) then
        if (not tonumber(guiGetText(convertVIPEdit))) then
            --Output error
            return false
        end

        local vipHours = tonumber(guiGetText(convertVIPEdit))

		triggerServerEvent("convertVIPMoney",localPlayer,localPlayer,vipHours)

        -- All checks passed
    end
end

for i, v in ipairs(buttons) do
    addEventHandler("onClientGUIClick", v, buttonHandler)
end

local lastCity

setTimer(function()
	local lx, ly, lz = getElementPosition (localPlayer)
	local currentCity = getZoneName(lx, ly, lz, true)
	if (currentCity ~= lastCity) then 
		triggerServerEvent("playerZoneChange",localPlayer,lastCity,currentCity)
		lastCity = currentCity
	end 
end, 2000, 0)


masks = {
    {"mask1Demon",1544},
    {"mask2Ape",1543},
    {"mask3Ape2",1546},
    {"mask4Hockey",1551},
    {"mask5Demon2",1664},
    {"mask6Pig",1667},
    {"mask7Mickey",1668},
    {"mask8Vendetta",1669},
    {"mask9bunnyears",1950},
    {"mask10cat",1517},
    {"mask11bo",1512},
    {"mask12fox",1510},
    {"mask13id",1509},
    {"mask14biker",1951},
    {"mask15Iron",1455},
}
function onThisResourceStart ( )
    for k,v in ipairs(masks) do
        downloadFile ( "models/"..v[1]..".dff" )
    end
end
addEventHandler ( "onClientResourceStart", resourceRoot, onThisResourceStart )


function onDownloadFinish ( file, success )
    if ( source == resourceRoot ) then                            -- if the file relates to this resource
        if ( success ) then
            for k,v in ipairs(masks) do
                if file == "models/"..v[1]..".dff" then
                    downloadFile("models/"..v[1]..".txd")
                elseif file == "models/"..v[1]..".txd" then
                    local txd =  engineLoadTXD("models/"..v[1]..".txd")
                    engineImportTXD(txd,v[2])
                    local dff = engineLoadDFF("models/"..v[1]..".dff", v[2])
                    engineReplaceModel(dff,v[2])
                end
            end
        end
    end
end
addEventHandler ( "onClientFileDownloadComplete", getRootElement(), onDownloadFinish )