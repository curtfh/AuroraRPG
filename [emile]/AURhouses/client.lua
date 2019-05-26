disabled = false
theKey = false
TheTable = {}
marker = {}
local screenW,screenH=guiGetScreenSize()
local screenW, screenH = guiGetScreenSize()
local screenWidth, screenHeight = guiGetScreenSize()
local sx,sy = screenW/3,screenH/3
local ready = false
houseData = {}
local soonBlip = {}
local allBlips = {}

function erra()
	outputChatBox("House ID not found , please try again",255,0,0)
end

function load_housing_window()
	--CreateWindowElements:
	if getLocalPlayer() then
	windowWidth, windowHeight = 564, 394
	windowX, windowY = (screenWidth / 2) - (windowWidth / 2), (screenHeight / 2) - (windowHeight / 2)
	housing_window = guiCreateWindow(windowX, windowY, windowWidth, windowHeight, "AUR House Panel", false)
	guiWindowSetSizable(housing_window, false)
	guiSetAlpha(housing_window, 1.00)
	guiSetVisible(housing_window, false)

	--CreateWindowLabels:
	sale_label = guiCreateLabel(17, 97, 259, 31, "For Sale: N/A", false, housing_window)
	price_label = guiCreateLabel(17, 128, 259, 31, "Price: $nil", false, housing_window)
	bought_label = guiCreateLabel(17, 159, 259, 31, "Bought For: $nil", false, housing_window)
	debug_label = guiCreateLabel(137, 159, 259, 31, "original price : $nil", false, housing_window)
	debug2_label = guiCreateLabel(453, 44, 96, 36, "", false, housing_window)
	locked_label = guiCreateLabel(17, 190, 259, 31, "Locked: false", false, housing_window)
	location_label = guiCreateLabel(17, 221, 259, 31, "Location: N/A", false, housing_window)
	interior_label = guiCreateLabel(17, 252, 259, 31, "Interior: N/A", false, housing_window)
	houseID_label = guiCreateLabel(453, 24, 96, 36, "House ID: N/A", false, housing_window)
	housePassword_label = guiCreateLabel(17, 40, 259, 31, "House Password: N/A", false, housing_window)
	owner_label = guiCreateLabel(17, 66, 480, 31, "House Owner: N/A", false, housing_window)
	main_label = guiCreateLabel(152, 24, 258, 36, "Housing Maintenence", false, housing_window)

	--CreateWindowButtons:
	lock_btn = guiCreateButton(17, 339, 109, 37, "Lock/Unlock", false, housing_window)
	buyhouse_btn = guiCreateButton(136, 298, 109, 37, "Buy House", false, housing_window)
	enthouse_btn = guiCreateButton(255, 298, 109, 37, "Enter House", false, housing_window)
	setprice_btn = guiCreateButton(136, 340, 109, 37, "Set Price", false, housing_window)
	cancel_btn = guiCreateButton(440, 340, 109, 37, "Cancel", false, housing_window)
	markhouse_btn = guiCreateButton(255, 340, 109, 37, "Mark House", false, housing_window)
	togglesale_btn = guiCreateButton(17, 298, 109, 37, "Toggle Sale", false, housing_window)
	selltobank_btn = guiCreateButton(440, 298, 109, 37, "Sell To Bank", false, housing_window)
	setpassword_btn = guiCreateButton(440, 256, 109, 37, "Set Password", false, housing_window)

	--AddWindowMisc:
	guiSetAlpha(housePassword_label,0)
	guiSetAlpha(debug_label,0)
	guiSetAlpha(debug2_label,0)

	guiSetFont(lock_btn, "default-bold-small")
	guiSetFont(buyhouse_btn, "default-bold-small")
	guiSetFont(enthouse_btn, "default-bold-small")
	guiSetFont(setprice_btn, "default-bold-small")
	guiSetFont(cancel_btn, "default-bold-small")
	guiSetFont(markhouse_btn, "default-bold-small")
	guiSetFont(togglesale_btn, "default-bold-small")
	guiSetFont(selltobank_btn, "default-bold-small")
	guiSetFont(setpassword_btn, "default-bold-small")
	guiSetFont(housePassword_label, "default-bold-small")

	guiSetFont(main_label, "clear-normal")
	guiLabelSetColor(main_label, 254, 126, 0)

	--AddWindowProperties:
	guiSetProperty(lock_btn, "NormalTextColour", "FFAAAAAA")
	guiSetProperty(buyhouse_btn, "NormalTextColour", "FFAAAAAA")
	guiSetProperty(enthouse_btn, "NormalTextColour", "FFAAAAAA")
	guiSetProperty(setprice_btn, "NormalTextColour", "FFAAAAAA")
	guiSetProperty(cancel_btn, "NormalTextColour", "FFAAAAAA")
	guiSetProperty(markhouse_btn, "NormalTextColour", "FFAAAAAA")
	guiSetProperty(togglesale_btn, "NormalTextColour", "FFAAAAAA")
	guiSetProperty(selltobank_btn, "NormalTextColour", "FFAAAAAA")
	guiSetProperty(setpassword_btn, "NormalTextColour", "FFAAAAAA")

	guiLabelSetVerticalAlign(main_label, "center")
	guiLabelSetVerticalAlign(houseID_label, "center")
	guiLabelSetVerticalAlign(sale_label, "center")
	guiLabelSetVerticalAlign(price_label, "center")
	guiLabelSetVerticalAlign(bought_label, "center")
	guiLabelSetVerticalAlign(locked_label, "center")
	guiLabelSetVerticalAlign(location_label, "center")
	guiLabelSetVerticalAlign(interior_label, "center")
	guiLabelSetVerticalAlign(owner_label, "center")
	guiLabelSetVerticalAlign(housePassword_label, "center")
	guiLabelSetVerticalAlign(debug_label, "center")
	guiLabelSetVerticalAlign(debug2_label, "center")
	guiLabelSetHorizontalAlign(main_label, "center", false)

	guiSetFont(main_label, "default-bold-small")
	guiSetFont(houseID_label, "default-bold-small")
	guiSetFont(sale_label, "default-bold-small")
	guiSetFont(price_label, "default-bold-small")
	guiSetFont(bought_label, "default-bold-small")
	guiSetFont(locked_label, "default-bold-small")
	guiSetFont(location_label, "default-bold-small")
	guiSetFont(interior_label, "default-bold-small")
	guiSetFont(owner_label, "default-bold-small")
	guiSetFont(debug_label, "default-bold-small")
	guiSetFont(debug2_label, "default-bold-small")

	guiLabelSetColor(sale_label, 255, 150, 0)
	guiLabelSetColor(price_label, 255, 150, 0)
	guiLabelSetColor(bought_label, 255, 150, 0)
	guiLabelSetColor(locked_label, 255, 150, 0)
	guiLabelSetColor(location_label, 255, 150, 0)
	guiLabelSetColor(interior_label, 255, 150, 0)
	guiLabelSetColor(owner_label, 255, 150, 0)
	guiLabelSetColor(housePassword_label, 255, 255, 255)
	guiLabelSetColor(debug_label, 255, 255, 255)
	guiLabelSetColor(debug2_label, 255, 255, 255)

	---- set price when player click set price from main gui
	setprice_window = guiCreateWindow(windowX, windowY, 350, 160, "AUR ~ House Price", false)
	guiWindowSetSizable(setprice_window, false)
	guiSetAlpha(setprice_window, 0.94)
	guiSetVisible(setprice_window, false)
	main_labelx = guiCreateLabel(50, 29, 258, 20, "Housing price maintenence", false, setprice_window)
	guiSetFont(main_labelx, "default-bold-small")
	guiLabelSetColor(main_labelx, 254, 126, 0)
	guiLabelSetHorizontalAlign(main_labelx, "center", false)
	sethousePrice_edit = guiCreateEdit(50, 54, 258, 36, "", false, setprice_window)
	sethousePrice_btn = guiCreateButton(50, 104, 122, 36, "Set price", false, setprice_window)
	closesethousePrice_btn = guiCreateButton(178, 104, 130, 36, "Close", false, setprice_window)
	labelsetprice = guiCreateLabel(87, 149, 171, 21, "", false, setprice_window)
	guiLabelSetHorizontalAlign(labelsetprice, "center", false)

	password_window = guiCreateWindow(windowX, windowY, 350, 160, "AUR ~ Password Required", false)
	guiWindowSetSizable(password_window, false)
	guiSetAlpha(password_window, 0.94)
	guiSetVisible(password_window, false)
	main_labelx_ = guiCreateLabel(50, 29, 258, 20, "Housing Password", false, password_window)
	guiSetFont(main_labelx_, "default-bold-small")
	guiLabelSetColor(main_labelx_, 254, 126, 0)
	guiLabelSetHorizontalAlign(main_labelx_, "center", false)
	enthousePass_edit = guiCreateEdit(50, 54, 258, 36, "", false, password_window)
	enthousePass_btn = guiCreateButton(50, 104, 122, 36, "Enter", false, password_window)
	closePasswordWnd_btn = guiCreateButton(178, 104, 130, 36, "Cancel", false, password_window)
	labelpass = guiCreateLabel(87, 149, 171, 21, "", false, password_window)
	guiLabelSetHorizontalAlign(labelpass, "center", false)

	setpassword_window = guiCreateWindow(windowX, windowY, 350, 160, "AUR ~ Set Password", false)
	guiWindowSetSizable(setpassword_window, false)
	guiSetAlpha(setpassword_window, 0.94)
	guiSetVisible(setpassword_window, false)
	main_labelx__ = guiCreateLabel(50, 29, 258, 20, "Set Housing Password", false, setpassword_window)
	guiSetFont(main_labelx__, "default-bold-small")
	guiLabelSetColor(main_labelx__, 254, 126, 0)
	guiLabelSetHorizontalAlign(main_labelx__, "center", false)
	sethousePass_edit = guiCreateEdit(50, 54, 258, 36, "", false, setpassword_window)
	sethousePass_btn = guiCreateButton(50, 104, 122, 36, "Set Pass", false, setpassword_window)
	closePasswordSetWnd_btn = guiCreateButton(178, 104, 130, 36, "Cancel", false, setpassword_window)
	labelpass_ = guiCreateLabel(87, 149, 171, 21, "", false, setpassword_window)
	guiLabelSetHorizontalAlign(labelpass_, "center", false)

	sellConfirmation_window = guiCreateWindow(windowX, windowY, 400, 120, "AUR ~ Confirmation", false)
	guiWindowSetSizable(sellConfirmation_window, false)
	guiSetAlpha(sellConfirmation_window, 0.94)
	guiSetVisible(sellConfirmation_window, false)
	main_labely = guiCreateLabel(20, 29, 358, 20, "Are you sure you would like to sell your house to the bank?", false, sellConfirmation_window)
	sellfor = guiCreateLabel(20, 50, 358, 20, "Are you sure you would like to sell your house to the bank?", false, sellConfirmation_window)
	guiSetFont(sellfor, "default-bold-small")
	guiSetFont(main_labely, "default-bold-small")
	guiLabelSetColor(main_labely, 254, 126, 0)
	guiLabelSetColor(sellfor, 254, 126, 0)
	guiLabelSetHorizontalAlign(main_labely, "center", false)
	guiLabelSetHorizontalAlign(sellfor, "center", false)
	confirmSell_btn = guiCreateButton(70, 84, 122, 36, "Yes", false, sellConfirmation_window)
	closeConfWnd_btn = guiCreateButton(198, 84, 130, 36, "Cancel", false, sellConfirmation_window)
	labelconf_ = guiCreateLabel(87, 149, 171, 21, "", false, sellConfirmation_window)
	guiLabelSetHorizontalAlign(labelconf_, "center", false)


	warnWindow4 = guiCreateWindow(517,281,247,133,"AUR ~ Housing Warning",false)
	guiSetVisible(warnWindow4,false)
	warnLabel1 = guiCreateLabel(96,27,55,17,"Warning!",false,warnWindow4)
	guiLabelSetColor(warnLabel1,225,165,0)
	guiSetFont(warnLabel1,"default-bold-small")
	warnButton4 = guiCreateButton(33,97,181,27,"Close Warning",false,warnWindow4)
	warnLabel2 = guiCreateLabel(72,55,110,17,"House items will be removed!",false,warnWindow4)
	guiLabelSetColor(warnLabel2,225,225,225)
	guiSetFont(warnLabel2,"default-bold-small")
	warnLabel3 = guiCreateLabel(37,69,175,17,"Are you sure about this?",false,warnWindow4)
	guiSetFont(warnLabel3,"default-bold-small")
	guiLabelSetHorizontalAlign(warnLabel1, "center", false)
	guiLabelSetHorizontalAlign(warnLabel2, "center", false)
	guiLabelSetHorizontalAlign(warnLabel3, "center", false)
	addEventHandler("onClientGUIClick",warnButton4,function()
		if source == warnButton4 then
			guiSetVisible(warnWindow4,false)
			showCursor(false)
		end
	end,false)
	setTimer(function()
		if warnWindow4 and guiGetVisible(warnWindow4) then
			if isCursorShowing() then
				return
			else
				showCursor(true)
			end
		end
		if sellConfirmation_window and guiGetVisible(sellConfirmation_window) then
			if isCursorShowing() then
				return
			else
				showCursor(true)
			end
		end
		if housing_window and guiGetVisible(housing_window) then
			if isCursorShowing() then
				return
			else
				showCursor(true)
			end
		end
		if setpassword_window and guiGetVisible(setpassword_window) then
			if isCursorShowing() then
				return
			else
				showCursor(true)
			end
		end
		if password_window and guiGetVisible(password_window) then
			if isCursorShowing() then
				return
			else
				showCursor(true)
			end
		end
		if setprice_window and guiGetVisible(setprice_window) then
			if isCursorShowing() then
				return
			else
				showCursor(true)
			end
		end
	end,1000,0)
	centerWindow(warnWindow4)
	centerWindow(housing_window)
	centerWindow(setprice_window)
	centerWindow(password_window)
	centerWindow(setpassword_window)
	centerWindow(sellConfirmation_window)
	--AddWindowEvents:
	addEventHandler( "onClientGUIChanged", sethousePrice_edit, removeLetters, false )
	addEventHandler( "onClientGUIChanged", sethousePass_edit, removeLetters2, false )

	setTimer(function()
		if guiGetVisible(housing_window) then
			local can,msg = exports.NGCmanagement:isPlayerLagging(localPlayer)
			if tonumber(getElementData(localPlayer,"FPS")) <= 5 or getPlayerPing(localPlayer) >= 450 or not can then
				if guiGetVisible(housing_window) then
					pleaseCloseAllHousing()
					guiSetVisible(housing_window, false)
					showCursor(false)
				end
			end
		end
	end,500,0)
	addEventHandler("onClientGUIClick", cancel_btn, function()
		if (source==cancel_btn) then
			if getLocalPlayer() then
				pleaseCloseAllHousing()
				guiSetVisible(housing_window, false)
				showCursor(false)
			end
		end
	end)
	end
end
addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), load_housing_window)


-- Center the windows
function centerWindow(center_window)

    local windowW,windowH=guiGetSize(center_window,false)
    local x,y = (screenW-windowW)/2,(screenH-windowH)/2
    guiSetPosition(center_window,x,y,false)
end

function handleTrigger()
	if getLocalPlayer() then
	guiSetVisible(housing_window, true)
	showCursor(true)
	for k,v in ipairs(houseData) do
		houseid,ownerid,ownername,interiorid,forsale,price,name,locked,boughtfor,hpassworded,hpassword,originalprice = v[1],v[2],v[3],v[4],v[5],v[6],v[7],v[8],v[9],v[10],v[11],v[12]
	end
	guiSetText(sellfor,"")
	guiSetProperty(lock_btn, "Disabled", "True")
	guiSetProperty(setprice_btn, "Disabled", "True")
	guiSetProperty(togglesale_btn, "Disabled", "True")
	guiSetProperty(selltobank_btn, "Disabled", "True")
	guiSetProperty(setpassword_btn, "Disabled", "True")

	local lsixs = getElementData(localPlayer, "isPlayerPrime") --exports.CSGstaff:getPlayerAdminLevel(localPlayer)

	if (exports.server:getPlayerAccountID(localPlayer) == ownerid or lsixs == true) then
		guiSetProperty(lock_btn, "Disabled", "False")
		guiSetProperty(setprice_btn, "Disabled", "False")
		guiSetProperty(togglesale_btn, "Disabled", "False")
		guiSetProperty(selltobank_btn, "Disabled", "False")
		guiSetProperty(setpassword_btn, "Disabled", "False")
	else
		guiSetProperty(lock_btn, "Disabled", "True")
		guiSetProperty(setprice_btn, "Disabled", "True")
		guiSetProperty(togglesale_btn, "Disabled", "True")
		guiSetProperty(selltobank_btn, "Disabled", "True")
		guiSetProperty(setpassword_btn, "Disabled", "True")
	end
		guiSetText(houseID_label, "House ID: "..houseid)
		if ownername == "AURhousing" then
			guiSetText(owner_label, "House Owner: "..ownername.." (Last Seen: Online)")
		else
			guiSetText(owner_label, "House Owner: "..ownername.." (Last Seen: N.A)")
		end
		triggerServerEvent("getOwnerTime",localPlayer,houseid)
		guiSetText(interior_label, "Interior: "..interiorid)
		guiSetText(bought_label, "Bought For: $"..exports.server:convertNumber(boughtfor))
		guiSetText(debug_label, "1st Price: $"..exports.server:convertNumber(originalprice))
		guiSetText(debug2_label, "ID: "..ownerid)
		guiSetText(price_label, "Price: $"..exports.server:convertNumber(price))
		guiSetText(location_label, "Location: "..name)
		if forsale == 1 then
			guiSetText(sale_label, "For Sale: Yes")
		else
			guiSetText(sale_label, "For Sale: No")
		end
		if locked == 1 then
			guiSetText(locked_label, "Locked: Yes")
			houseLocked = 1
			hpassworded_ = 1
		else
			guiSetText(locked_label, "Locked: No")
			houseLocked = 0
			hpassworded_ = 0
		end
		if (hpassworded == 0) then
			hpassworded_ = 0
		else
			hpassworded_ = 1
		end
	if exports.server:getPlayerAccountID(localPlayer) == ownerid then --- owner check for password info
		guiSetAlpha(housePassword_label,255)
		guiSetText(housePassword_label,"House password: "..hpassword)
	else
		guiSetAlpha(housePassword_label,0)
		guiSetText(housePassword_label,"")
	end
	if getElementData(localPlayer,"isPlayerPrime") == true then
		guiSetAlpha(debug_label,255)
		guiSetAlpha(debug2_label,255)
	else
		guiSetAlpha(debug_label,0)
		guiSetAlpha(debug2_label,0)
	end
	removeEventHandler("onClientGUIClick",root,handleHousing)
	addEventHandler("onClientGUIClick",root,handleHousing)
	end
end

addEvent("updateOwnerTime",true)
function updateTime(ownername,theTime)
	if ownername ~= "NGCbanking" then
		local p = exports.server:getPlayerFromAccountname(ownername)
		if p and isElement(p) then
			guiSetText(owner_label, "House Owner: "..ownername.." (Last Seen: Online)")
		else
			if theTime then
				guiSetText(owner_label, "House Owner: "..ownername.." (Last Seen: "..compareTimestampDays(theTime)..")")
			else
				guiSetText(owner_label, "House Owner: "..ownername.." (Last Seen: N.A)")
			end
		end
	end
end
addEventHandler("updateOwnerTime",root,updateTime)

function getPanelDataReady(dat1, dat2, dat3, dat4, dat5, dat6, dat7, dat8, dat9, dat10, dat11, dat12,dat13,mk)
		--marker = mk
		--setPickup(dat1,true)
		ready = true
		removeEventHandler("onClientRender",root,draw)
		addEventHandler("onClientRender",root,draw)
		t = {dat1, dat2, dat3, dat4, dat5, dat6, dat7, dat8, dat9, dat10, dat11, dat12,dat13}
		table.insert(houseData,t)

end
addEvent("NGChousing.handlePanel", true)
addEventHandler("NGChousing.handlePanel", root, getPanelDataReady)


addEvent("updateHousingLabels",true)
addEventHandler("updateHousingLabels",root,function(ownerid,interiorid,forsale,price,housename,lockedx,boughtprice,hpassworded,originalpricex,houseOwn,seen)
	if houseOwn == "AURhousing" then
		guiSetText(owner_label, "House Owner: "..houseOwn.." (Last Seen: Online)")
	else
		local p = exports.server:getPlayerFromAccountname(ownername)
		if p and isElement(p) then
			guiSetText(owner_label, "House Owner: "..houseOwn.." (Last Seen: Online)")
		else
			guiSetText(owner_label, "House Owner: "..houseOwn.." (Last Seen: "..compareTimestampDays(seen)..")")
		end
	end
	guiSetText(price_label, "Price: $"..exports.server:convertNumber(price))
	guiSetText(bought_label, "Bought For: $"..exports.server:convertNumber(boughtprice))
	guiSetText(location_label, "Location: "..housename)
	guiSetText(interior_label, "Interior: "..interiorid)
	originalprice = originalpricex
	if lockedx == 1 then
		guiSetText(locked_label, "Locked: Yes")
		houseLocked = 1
		hpassworded_= 1
	else
		guiSetText(locked_label, "Locked: No")
		houseLocked = 0
		hpassworded_= 0
	end
	if (hpassworded == 0) then
		hpassworded_ = 0
	else
		hpassworded_ = 1
	end
	if exports.server:getPlayerAccountID(localPlayer) == ownerid then --- owner check for password info
		guiSetAlpha(housePassword_label,255)
		guiSetText(housePassword_label,"House password: "..hpassword)
	else
		guiSetAlpha(housePassword_label,0)
		guiSetText(housePassword_label,"")
	end
	if forsale == 1 then
		guiSetText(sale_label, "For Sale: Yes")
	else
		guiSetText(sale_label, "For Sale: No")
	end
	local lsixs = exports.CSGstaff:getPlayerAdminLevel(localPlayer)
	if (exports.server:getPlayerAccountID(localPlayer) == ownerid or lsixs >= 5) then
		guiSetProperty(lock_btn, "Disabled", "False")
		guiSetProperty(setprice_btn, "Disabled", "False")
		guiSetProperty(togglesale_btn, "Disabled", "False")
		guiSetProperty(selltobank_btn, "Disabled", "False")
		guiSetProperty(setpassword_btn, "Disabled", "False")
	else
		guiSetProperty(lock_btn, "Disabled", "True")
		guiSetProperty(setprice_btn, "Disabled", "True")
		guiSetProperty(togglesale_btn, "Disabled", "True")
		guiSetProperty(selltobank_btn, "Disabled", "True")
		guiSetProperty(setpassword_btn, "Disabled", "True")
	end
end)


function handleHousing()
	if source == markhouse_btn then
		for k,v in ipairs(houseData) do
			houseid,ownerid,ownername,interiorid,forsale,price,name,locked,boughtfor,hpassworded,hpassword,originalprice = v[1],v[2],v[3],v[4],v[5],v[6],v[7],v[8],v[9],v[10],v[11],v[12]
		end
		if getLocalPlayer() then
		if houseid then
			local x,y,z = getElementPosition(localPlayer)
			if isElement(soonBlip[houseid]) then
				for k,v in ipairs(soonBlip) do
					if isElement(v[houseid]) then
						table.remove(allBlips,k)
					end
				end
				destroyElement(soonBlip[houseid])
			else
				soonBlip[houseid] = createBlip(x,y,z,32)
				table.insert(allBlips,soonBlip[houseid])
				exports.NGCdxmsg:createNewDxMessage("This house marked in Radar as Red house blip",255,250,0)
			end
		else
			erra()
		end
		end
	elseif source == closesethousePrice_btn then
		if getLocalPlayer() then
		if (guiGetVisible(setprice_window) and not guiGetVisible(housing_window)) then
			guiSetVisible(setprice_window, false)
			guiSetVisible(housing_window, true)
		end
		end
	elseif source == closePasswordWnd_btn then
		if getLocalPlayer() then
		if (guiGetVisible(password_window) and not guiGetVisible(housing_window)) then
			guiSetVisible(password_window, false)
			guiSetVisible(housing_window, true)
		end
		end
	elseif source == closePasswordSetWnd_btn then
		if getLocalPlayer() then
		if (guiGetVisible(setpassword_window) and not guiGetVisible(housing_window)) then
			guiSetVisible(setpassword_window, false)
			guiSetVisible(housing_window, true)
		end
		end
	elseif source == closeConfWnd_btn then
		if getLocalPlayer() then
		if (guiGetVisible(sellConfirmation_window) and not guiGetVisible(housing_window)) then
			guiSetVisible(sellConfirmation_window, false)
			guiSetVisible(housing_window, true)
		end
		end
	elseif source == setprice_btn then
		if getLocalPlayer() then
		if houseid then
			if (guiGetVisible(housing_window)) then
				guiSetVisible(housing_window, false)
			end
			guiSetVisible(setprice_window, true)
			guiSetProperty (setprice_window, "AlwaysOnTop", "True" )
			guiBringToFront(setprice_window)
			guiSetText(labelsetprice,"")
			addEventHandler("onClientGUIClick",sethousePrice_btn,function()
				if guiGetText(labelsetprice) then
					for k,v in ipairs(houseData) do
						houseid,ownerid,ownername,interiorid,forsale,price,name,locked,boughtfor,hpassworded,hpassword,originalprice = v[1],v[2],v[3],v[4],v[5],v[6],v[7],v[8],v[9],v[10],v[11],v[12]
					end
					local id = houseid
					if id and tonumber(id) then
						local tempprice = guiGetText(sethousePrice_edit)
						local allowedPrice = math.floor(originalprice/2)
						local maxprice = math.floor(originalprice*5.5)
						local maximalPrice = 30000000
						if (tempprice == "") then exports.NGCdxmsg:createNewDxMessage("Please enter a valid price!",255,0,0) return end
						if tonumber(tempprice) <= maxprice and tonumber(tempprice) >= tonumber(allowedPrice) then
							if tonumber(tempprice) >= tonumber(allowedPrice) then
								local txts = guiGetText(sethousePrice_edit)
								if ( string.len( tostring( txts ) ) ) <= 8  then
									triggerServerEvent("setHousePrice",localPlayer,id,tempprice)
								else
									exports.NGCdxmsg:createNewDxMessage("You can't spam useless numbers",255,0,0)
									return
									false
								end
							else
								exports.NGCdxmsg:createNewDxMessage("You can't set this price try more than $ "..exports.server:convertNumber(allowedPrice).." & less than $30,000,000 !!",255,0,0)
								return
								false
							end
						else
							exports.NGCdxmsg:createNewDxMessage("You can't set this price try more than $ "..exports.server:convertNumber(allowedPrice).." & less than $"..exports.server:convertNumber(maxprice),255,0,0)
							return
							false
						end
						if (guiGetVisible(setprice_window)) then
							guiSetVisible(setprice_window, false)
							guiSetVisible(housing_window, true)
						end
					end
				end
			end,false)
		else
			erra()
		end
		end
	elseif source == lock_btn then
		if getLocalPlayer() then
		for k,v in ipairs(houseData) do
			houseid,ownerid,ownername,interiorid,forsale,price,name,locked,boughtfor,hpassworded,hpassword,originalprice = v[1],v[2],v[3],v[4],v[5],v[6],v[7],v[8],v[9],v[10],v[11],v[12]
		end
		if houseid then
			if guiGetText(sale_label) ~= "For Sale: Yes" then
				if guiGetText(locked_label) == "Locked: Yes" then
					houseLocked = 0
					exports.NGCdxmsg:createNewDxMessage("You have unlocked your house!",0,255,0)
				else
					houseLocked = 1
					exports.NGCdxmsg:createNewDxMessage("You have locked your house!",255,0,0)
				end
				triggerServerEvent("setHouseLock", localPlayer, houseid,houseLocked,localPlayer)
			else
				exports.NGCdxmsg:createNewDxMessage("You can't lock your house while it's for sale, the buyers want to see it!",255,0,0)
			end
		else
			erra()
		end
		end
	elseif source == togglesale_btn then
		if getLocalPlayer() then
		for k,v in ipairs(houseData) do
			houseid,ownerid,ownername,interiorid,forsale,price,name,locked,boughtfor,hpassworded,hpassword,originalprice = v[1],v[2],v[3],v[4],v[5],v[6],v[7],v[8],v[9],v[10],v[11],v[12]
		end
		if houseid then
			if guiGetText(sale_label) == "For Sale: Yes" then
				doesForSale = 0
				exports.NGCdxmsg:createNewDxMessage("Your house is no longer for sale!",255,0,0)
			else
				doesForSale = 1
				exports.NGCdxmsg:createNewDxMessage("Your house is now for sale!",0,255,0)
				guiSetVisible(warnWindow4, true)
				guiSetProperty (warnWindow4, "AlwaysOnTop", "True" )
				guiBringToFront(warnWindow4)
			end
			triggerServerEvent("setHouseToggleSale", localPlayer, houseid,doesForSale,localPlayer)
		else
			erra()
		end
		end
	elseif source == enthouse_btn then
		if getLocalPlayer() then
		for k,v in ipairs(houseData) do
			houseid,ownerid,ownername,interiorid,forsale,price,name,locked,boughtfor,hpassworded,hpassword,originalprice = v[1],v[2],v[3],v[4],v[5],v[6],v[7],v[8],v[9],v[10],v[11],v[12]
		end
		if houseid then
			if (hpassworded_ == false or houseLocked == 0) then
				triggerServerEvent("enterHousing",localPlayer,houseid,interiorid)
				--setPickup(houseid,false)
				pleaseCloseAllHousing()
				exports.NGCdxmsg:createNewDxMessage("Oops, this house was left unlocked, seems you have access to enter/exit this house.",0,255,0)
			else
				if (hpassworded_ == true or houseLocked == 1) then
					if exports.DENlaw:isLaw(localPlayer) then
						triggerServerEvent("enterHousing",localPlayer,houseid,interiorid)
						pleaseCloseAllHousing()
						return false
					end
					exports.NGCdxmsg:createNewDxMessage("This house is passworded, please enter the correct password to enter!",255,0,0)
					if (guiGetVisible(housing_window)) then
						guiSetVisible(housing_window, false)
						guiSetVisible(password_window, true)
					end
				end
			end
		else
			erra()
		end
		end
	elseif source == enthousePass_btn then
		if getLocalPlayer() then
		for k,v in ipairs(houseData) do
			houseid,ownerid,ownername,interiorid,forsale,price,name,locked,boughtfor,hpassworded,hpassword,originalprice = v[1],v[2],v[3],v[4],v[5],v[6],v[7],v[8],v[9],v[10],v[11],v[12]
		end
		if houseid then
			local entpw = guiGetText(enthousePass_edit)
			if (not hpassword) then return end
			if getElementData(localPlayer,"isPlayerPrime") == true then outputChatBox("PW2: "..hpassword,0,255,0) end
			if (entpw == hpassword) then
				triggerServerEvent("enterHousing",localPlayer,houseid,interiorid)
				--setPickup(houseid,false)
				pleaseCloseAllHousing()
				exports.NGCdxmsg:createNewDxMessage("Password Accepted! You've been warped inside the house.",0,255,0)
				if (guiGetVisible(housing_window) or guiGetVisible(setpassword_window)) then
					guiSetVisible(housing_window, false)
					guiSetVisible(setpassword_window, false)
				end
			else
				exports.NGCdxmsg:createNewDxMessage("You have entered an incorrect password!",255,0,0)
				if (guiGetVisible(housing_window) or guiGetVisible(setpassword_window)) then
					guiSetVisible(housing_window, false)
					guiSetVisible(setpassword_window, false)
				end
			end
		else
			erra()
		end
		end
	elseif source == setpassword_btn then
		if getLocalPlayer() then
		for k,v in ipairs(houseData) do
			houseid,ownerid,ownername,interiorid,forsale,price,name,locked,boughtfor,hpassworded,hpassword,originalprice = v[1],v[2],v[3],v[4],v[5],v[6],v[7],v[8],v[9],v[10],v[11],v[12]
		end
		if houseid then
			if (guiGetVisible(housing_window)) then
				guiSetVisible(housing_window, false)
				guiSetVisible(setpassword_window, true)
			end
		else
			erra()
		end
		end
	elseif source == sethousePass_btn then
		if getLocalPlayer() then
		for k,v in ipairs(houseData) do
			houseid,ownerid,ownername,interiorid,forsale,price,name,locked,boughtfor,hpassworded,hpassword,originalprice = v[1],v[2],v[3],v[4],v[5],v[6],v[7],v[8],v[9],v[10],v[11],v[12]
		end
		if houseid then
			local housepass = guiGetText(sethousePass_edit)
			if (housepass == "") then exports.NGCdxmsg:createNewDxMessage("Please enter a password to set!",255,0,0) return end
			if ( string.len(housepass) ) == 4 then
				triggerServerEvent("NGChousing.setHousePassword",localPlayer,houseid,housepass)
				guiSetText(housePassword_label, "House Password: "..housepass)
				if (guiGetVisible(setpassword_window)) then
					guiSetVisible(setpassword_window, false)
					guiSetVisible(housing_window, true)
				end
			else
				exports.NGCdxmsg:createNewDxMessage("A house password can only be 4 digits!", 225, 0, 0)
			end
		else
			erra()
		end
		end
	elseif source == buyhouse_btn then
		if getLocalPlayer() then
		for k,v in ipairs(houseData) do
			houseid,ownerid,ownername,interiorid,forsale,price,name,locked,boughtfor,hpassworded,hpassword,originalprice = v[1],v[2],v[3],v[4],v[5],v[6],v[7],v[8],v[9],v[10],v[11],v[12]
		end
		if houseid then
			triggerServerEvent("buyHouse",localPlayer,houseid)
		else
			erra()
		end
		end
	elseif source == selltobank_btn then
		if getLocalPlayer() then
		for k,v in ipairs(houseData) do
			houseid,ownerid,ownername,interiorid,forsale,price,name,locked,boughtfor,hpassworded,hpassword,originalprice = v[1],v[2],v[3],v[4],v[5],v[6],v[7],v[8],v[9],v[10],v[11],v[12]
		end
		if houseid then
			if (guiGetVisible(housing_window)) then
				guiSetVisible(housing_window, false)
				guiSetVisible(sellConfirmation_window, true)
				for index, prc_ in ipairs(houseData) do
					orgpr = prc_[12]
					--orgpr = originalprice
				end
				prizo = math.floor(orgpr / 2)
				guiSetText(sellfor,"$ "..exports.server:convertNumber(prizo))
				guiSetVisible(warnWindow4, true)
				guiSetProperty (warnWindow4, "AlwaysOnTop", "True" )
				guiBringToFront(warnWindow4)
			end
		else
			erra()
		end
		end
	elseif source == confirmSell_btn then
		if getLocalPlayer() then
		for k,v in ipairs(houseData) do
			houseid,ownerid,ownername,interiorid,forsale,price,name,locked,boughtfor,hpassworded,hpassword,originalprice = v[1],v[2],v[3],v[4],v[5],v[6],v[7],v[8],v[9],v[10],v[11],v[12]
		end
		if houseid then
			for index, prc_ in ipairs(houseData) do
				orgpr = prc_[12]
				--orgpr = originalprice
			end
			thePricesellFor = math.floor(orgpr / 2)
			triggerServerEvent("NGChousing.sellToBank", localPlayer, houseid, thePricesellFor)
			if (guiGetVisible(sellConfirmation_window) or guiGetVisible(housing_window)) then
				guiSetVisible(sellConfirmation_window, false)
				guiSetVisible(housing_window, false)
				showCursor(false)
			end
		else
			erra()
		end
		end
	end
end

function pleaseCloseAllHousing()
	if getLocalPlayer() then
	if (t) then
		local d1, d2, d3, d4, d5, d6, d7, d8, d9, d10, d11, d12 = unpack(t)
		triggerServerEvent("NGChousing.disableMiscPrev", localPlayer, d1)
	end
	if mainh_panel and guiGetVisible(mainh_panel) then guiSetVisible(mainh_panel, false) end
	guiSetVisible(setprice_window, false)
	guiSetVisible(housing_window, false)
	guiSetVisible(password_window, false)
	guiSetVisible(setpassword_window, false)
	guiSetVisible(sellConfirmation_window, false)
	showCursor(false)
	houseData = {}
	ready = false
	houseid = nil
	removeEventHandler("onClientRender",root,draw)
	triggerEvent("closeHousingDecor",localPlayer)
	end
end
addEventHandler("onClientPlayerWasted", localPlayer, pleaseCloseAllHousing)
addEventHandler("onClientPlayerQuit", localPlayer, pleaseCloseAllHousing)

addEvent("closeAllHousing",true)
addEventHandler("closeAllHousing",root,function()
	pleaseCloseAllHousing()
end)



function initCheck_f()
	if (isElement(localPlayer)) then
		if (not guiGetVisible(housing_window)) then return end
		local isPlayerArrested = (getElementData(localPlayer, "isPlayerArrested"))
		local isPlayerJailed = (getElementData(localPlayer, "isPlayerJailed"))
		if (isPlayerArrested == true) then
			pleaseCloseAllHousing()
			exports.NGCdxmsg:createNewDxMessage("You cannot operate this panel as you are arrested!", 225, 0, 0)
		elseif (isPlayerJailed == true) then
			pleaseCloseAllHousing()
			exports.NGCdxmsg:createNewDxMessage("You cannot operate this panel as you are jailed!", 225, 0, 0)
		elseif getPlayerPing(localPlayer) >= 400 then
			pleaseCloseAllHousing()
			exports.NGCdxmsg:createNewDxMessage("You cannot operate this panel as you are lagging!", 225, 0, 0)
		elseif tonumber(getElementData(localPlayer,"FPS")) < 5 then
			pleaseCloseAllHousing()
			exports.NGCdxmsg:createNewDxMessage("You cannot operate this panel as you are lagging!", 225, 0, 0)
		elseif disabled == true then
			pleaseCloseAllHousing()
			exports.NGCdxmsg:createNewDxMessage("You cannot operate this panel as you bounded ("..theKey..")", 225, 0, 0)
		elseif getElementData(localPlayer,"isPlayerOnPhone") then
			pleaseCloseAllHousing()
			exports.NGCdxmsg:createNewDxMessage("You cannot operate this panel as you are using phone!", 225, 0, 0)
		elseif getElementData(localPlayer,"playerHouse") then
			if getElementInterior(localPlayer) == 0 then
				setElementData(localPlayer,"playerHouse",false)
			end
		elseif housing_window and guiGetVisible(housing_window) then
			for k,v in ipairs(getElementsByType("gui-window")) do
				if housing_window ~= v then
					if guiGetVisible(v) then
						pleaseCloseAllHousing()
					end
				end
			end
		else
			return
		end
	end
end
setTimer(initCheck_f, 1000, 0)

bindKey("h","down",function()
	if ready==false then return end
	if set == false then return false end
	if isPedInVehicle(localPlayer) then
		return false
	end
	if getElementData(localPlayer,"Occupation") == "Thief" then
		return false
	end
	if (t) then
		local d1, d2, d3, d4, d5, d6, d7, d8, d9, d10, d11, d12 = unpack(t)
		triggerServerEvent("NGChousing.houseMiscPrev", localPlayer, d1)
	end
end)

function continueDatPrev(id)
	if ready==false then return end
	ready = false
	removeEventHandler("onClientRender",root,draw)
	handleTrigger()
	--setPickup(houseid,true)
end
addEvent("NGChousing.continueDatPrev", true)
addEventHandler("NGChousing.continueDatPrev", root, continueDatPrev)

function setPickup(id,state)
	if id then
		for k,v in ipairs(getElementsByType("pickup",resourceRoot)) do
			if ( getElementModel( v ) == 1272 ) or ( getElementModel( v ) == 1273 ) then
				if getElementData(v,"houseid") == tostring(id) then
					setElementData(v,"secured",state)
				end
			end
		end
	end
end

addEvent("destroyPickupData",true)
addEventHandler("destroyPickupData",root,function()
	pleaseCloseAllHousing()
end)

addEventHandler("onClientPickupLeave", root,function ( thePlayer, matchingDimension )
	if ( getElementModel( source ) == 1272 ) or ( getElementModel( source ) == 1273 ) then
		if ( matchingDimension ) and ( thePlayer == localPlayer ) then
			local ac = exports.server:getPlayerAccountName(thePlayer)
			houseData = {}
			pleaseCloseAllHousing()
			ready = false
			removeEventHandler("onClientRender",root,draw)
		else
			return false
		end
	end
end)


addEventHandler("onClientPickupHit", root,
	function ( thePlayer, matchingDimension )
	if ( getElementModel( source ) == 1272 ) or ( getElementModel( source ) == 1273 ) then
		if ( matchingDimension ) and ( thePlayer == localPlayer ) then
			if getElementData(source,"houseid") then
				if getElementType(thePlayer) == "player" then
					if isPedInVehicle(thePlayer) then
						return false
					end
					if isCursorShowing() then
						exports.NGCdxmsg("Please close any panel before you use this system",255,0,0)
						return false
					else
						if getElementData(thePlayer,"Occupation") == "Thief" then
							return false
						end
						local ac = exports.server:getPlayerAccountName(thePlayer)
						local can,domsg = exports.NGCmanagement:isPlayerLagging()
						if can then
							local dat1 = getElementData(source, "houseid")
							local dat2 = getElementData(source, "ownerid")
							local dat3 = getElementData(source, "ownername")
							local dat4 = getElementData(source, "interiorid")
							local dat5 = getElementData(source, "housesale")
							local dat6 = getElementData(source, "houseprice")
							local dat7 = getElementData(source, "housename")
							local dat8 = getElementData(source, "houselocked")
							local dat9 = getElementData(source, "boughtprice")
							local dat10 = getElementData(source, "passwordlocked")
							local dat11 = getElementData(source, "housepassword")
							local dat12 = getElementData(source, "originalPrice")
							local dat13 = getElementData(source, "lastSeen")
							marker = source
							set = true
							triggerEvent("NGChousing.handlePanel", thePlayer, dat1, dat2, dat3, dat4, dat5, dat6, dat7, dat8, dat9, dat10, dat11, dat12,dat13,source)
						else
							exports.NGCdxmsg:createNewDxMessage(domsg,255,0,0)
						end
					end
				end
			end
		else
			return false
		end
	end
end)

---- for label of price and edit of price
function removeLetters(element)
	local txts2 = guiGetText(element)
	local removed = string.gsub(txts2, "[^0-9]", "")
	if (removed ~= txts2) then
		guiSetText(element, removed)
		guiSetText(labelsetprice,"")
	end
	local txts = guiGetText(element)
	if ( txts ~= "" and tonumber( txts2 ) ) then
		guiSetText(labelsetprice,"$ "..exports.server:convertNumber(removed))
	end
end
--- for password
function removeLetters2(element)
	local txts2 = guiGetText(element)
	local removed = string.gsub(txts2, "[^0-9]", "")
	if (removed ~= txts2) then
		guiSetText(element, removed)
	end
end

addEvent("housingRemoveTempBlips",true)
addEventHandler("housingRemoveTempBlips",root,function()
	for k,v in ipairs(allBlips) do
		if isElement(v) then destroyElement(v) end
	end
end)


function draw()
	if set == false then return false end
	dxDrawBorderedText("Press H to open house system panel.", 1.75, (screenW - 504) / 2, (screenH - 290) / 1.05, ((screenW - 504) / 2) + 504, ( (screenH - 44) / 1.05) + 44, tocolor(0,150,250, 255), 1, "pricedown", "center", "center", false, false, true, false, false)
end


function dxDrawBorderedText ( text, wh, x, y, w, h, clr, scale, font, alignX, alignY, clip, wordBreak, postGUI )
	if not wh then wh = 1.5 end
	dxDrawText ( text, x - wh, y - wh, w - wh, h - wh, tocolor ( 0, 0, 0, a ), scale, font, alignX, alignY, clip, wordBreak, false, true) -- black
	dxDrawText ( text, x + wh, y - wh, w + wh, h - wh, tocolor ( 0, 0, 0, a ), scale, font, alignX, alignY, clip, wordBreak, false, true)
	dxDrawText ( text, x - wh, y + wh, w - wh, h + wh, tocolor ( 0, 0, 0, a ), scale, font, alignX, alignY, clip, wordBreak, false, true)
	dxDrawText ( text, x + wh, y + wh, w + wh, h + wh, tocolor ( 0, 0, 0, a ), scale, font, alignX, alignY, clip, wordBreak, false, true)
	dxDrawText ( text, x - wh, y, w - wh, h, tocolor ( 0, 0, 0, a ), scale, font, alignX, alignY, clip, wordBreak, false, true)
	dxDrawText ( text, x + wh, y, w + wh, h, tocolor ( 0, 0, 0, a ), scale, font, alignX, alignY, clip, wordBreak, false, true)
	dxDrawText ( text, x, y - wh, w, h - wh, tocolor ( 0, 0, 0, a ), scale, font, alignX, alignY, clip, wordBreak, false, true)
	dxDrawText ( text, x, y + wh, w, h + wh, tocolor ( 0, 0, 0, a ), scale, font, alignX, alignY, clip, wordBreak, false, true)
	dxDrawText ( text, x, y, w, h, clr, scale, font, alignX, alignY, clip, wordBreak, postGUI, true)
end


-- Compare the timestamp
function compareTimestampDays ( timeStamp )
	local theStamp = ( getRealTime().timestamp - timeStamp )
	if ( theStamp <= 86400 ) then
		local hours = math.floor( ( theStamp / 3600  ) )
		if ( hours == 1 ) then
			return hours.." hour ago"
		elseif ( hours == -1 ) then
			return "0 hours ago"
		else
			return hours.." hours ago"
		end
	else
		local days = math.floor( ( theStamp / 86400 ) )
		if ( timeStamp == 99999 ) then
			return "Unknown"
		elseif ( days == 1 ) then
			return days.." day ago"
		else
			return days.." days ago"
		end
		outputDebugString("no Here")
	end
end

-- Convert a time stamp
function compareTimestampDays2 ( timeStamp )
	local time = getRealTime( timeStamp )
	local year = time.year + 1900
	local month = time.month + 1
	local day = time.monthday
	local hour = time.hour
	local minute = time.minute
	local second = time.second
	return year .."-" .. month .."-" .. day .." " .. hour ..":" .. minute ..":" .. second
end

addEventHandler("onClientPlayerQuit",localPlayer,function()
	triggerServerEvent("setPlayerQuitDetected",localPlayer)
end)

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
		--triggerServerEvent("BlockHousing",localPlayer,true)
	else
		if not disabled then return end
		disabled = false
		--triggerServerEvent("BlockHousing",localPlayer,false)
	end
end
setTimer(unbindTheBindedKey,500,0)
