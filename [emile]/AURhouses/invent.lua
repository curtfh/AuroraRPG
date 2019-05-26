local screenWidth, screenHeight = guiGetScreenSize()
local screenW,screenH=guiGetScreenSize()
local allowed_dat_panel = false
local state = "No"
local hs = {
    label = {},
    radiobutton = {}
}

function init_house_panel()
	windowX, windowY = (screenWidth / 2) - (windowWidth / 2), (screenHeight / 2) - (windowHeight / 2)
	mainh_panel = guiCreateWindow(windowX, windowY, 662, 397, "AUR ~ Housing Panel", false)
	guiSetVisible(mainh_panel, false)
	guiWindowSetSizable(mainh_panel, false)
	guiSetAlpha(mainh_panel, 1.00)

	mainh_tabs = guiCreateTabPanel(229, 23, 423, 359, false, mainh_panel)

	mainh_tabweps = guiCreateTab("Weapons", mainh_tabs)

	mainhw_peaaoclabel = guiCreateLabel(8, 238, 223, 32, "Please enter an amount of clips", false, mainh_tabweps)
	guiSetFont(mainhw_peaaoclabel, "default-bold-small")
	guiLabelSetColor(mainhw_peaaoclabel, 254, 126, 0)
	guiLabelSetHorizontalAlign(mainhw_peaaoclabel, "center", false)
	guiLabelSetVerticalAlign(mainhw_peaaoclabel, "center")
	mainhw_clipedit = guiCreateEdit(10, 194, 222, 34, "", false, mainh_tabweps)
	mainhw_inputbutton = guiCreateButton(62, 274, 106, 36, "Input", false, mainh_tabweps)
	guiSetFont(mainhw_inputbutton, "default-bold-small")
	guiSetProperty(mainhw_inputbutton, "NormalTextColour", "FFAAAAAA")
	mainhw_takebutton = guiCreateButton(276, 274, 106, 36, "Take", false, mainh_tabweps)
	guiSetFont(mainhw_takebutton, "default-bold-small")
	guiSetProperty(mainhw_takebutton, "NormalTextColour", "FFAAAAAA")
	wepsGrid = guiCreateGridList(8, 10, 223, 132, false, mainh_tabweps)
	guiGridListAddColumn(wepsGrid, "Weapon", 0.5)
	guiGridListAddColumn(wepsGrid, "Amount", 0.5)


	slot1 = guiCreateLabel(241, 10, 177, 30, "Slot1:", false, mainh_tabweps)
	guiSetFont(slot1, "default-bold-small")
	guiLabelSetColor(slot1, 254, 126, 0)
	guiLabelSetVerticalAlign(slot1, "center")
	slot2 = guiCreateLabel(240, 50, 177, 30, "Slot2:", false, mainh_tabweps)
	guiSetFont(slot2, "default-bold-small")
	guiLabelSetColor(slot2, 254, 126, 0)
	guiLabelSetVerticalAlign(slot2, "center")
	slot3 = guiCreateLabel(241, 90, 177, 30, "Slot3:", false, mainh_tabweps)
	guiSetFont(slot3, "default-bold-small")
	guiLabelSetColor(slot3, 254, 126, 0)
	guiLabelSetVerticalAlign(slot3, "center")
	slot4 = guiCreateLabel(241, 132, 177, 30, "Slot4:", false, mainh_tabweps)
	guiSetFont(slot4, "default-bold-small")
	guiLabelSetColor(slot4, 254, 126, 0)
	guiLabelSetVerticalAlign(slot4, "center")

	hs.radiobutton[1] = guiCreateRadioButton(13, 146, 100, 15, "Slot1", false, mainh_tabweps)
	hs.radiobutton[2] = guiCreateRadioButton(13, 171, 100, 15, "Slot2", false, mainh_tabweps)
	hs.radiobutton[3] = guiCreateRadioButton(121, 146, 100, 15, "Slot3", false, mainh_tabweps)
	hs.radiobutton[4] = guiCreateRadioButton(121, 171, 100, 15, "Slot4", false, mainh_tabweps)

	mainh_tabdrugs = guiCreateTab("Drugs", mainh_tabs)

	mainhd_gridlistdrugs = guiCreateGridList(241, 10, 174, 208, false, mainh_tabdrugs)
	guiGridListAddColumn(mainhd_gridlistdrugs, "Drugs", 0.6)
	guiGridListAddColumn(mainhd_gridlistdrugs, "Amount", 0.4)
	mainhd_drugslabel = guiCreateLabel(8, 0, 223, 32, "Drugs Inventory", false, mainh_tabdrugs)
	guiSetFont(mainhd_drugslabel, "clear-normal")
	guiLabelSetHorizontalAlign(mainhd_drugslabel, "center", false)
	guiLabelSetVerticalAlign(mainhd_drugslabel, "center")
	mainhw_peadtslabel = guiCreateLabel(7, 32, 223, 32, "Please select drug type", false, mainh_tabdrugs)
	guiSetFont(mainhw_peadtslabel, "default-bold-small")
	guiLabelSetColor(mainhw_peadtslabel, 254, 126, 0)
	guiLabelSetHorizontalAlign(mainhw_peadtslabel, "center", false)
	guiLabelSetVerticalAlign(mainhw_peadtslabel, "center")
	mainhw_peaaodlabel = guiCreateLabel(8, 186, 223, 32, "Please enter an amount of drugs", false, mainh_tabdrugs)
	guiSetFont(mainhw_peaaodlabel, "default-bold-small")
	guiLabelSetColor(mainhw_peaaodlabel, 254, 126, 0)
	guiLabelSetHorizontalAlign(mainhw_peaaodlabel, "center", false)
	guiLabelSetVerticalAlign(mainhw_peaaodlabel, "center")
	mainhd_drgnamedit = guiCreateEdit(8, 142, 222, 34, "", false, mainh_tabdrugs)
	mainhd_inputbutton = guiCreateButton(60, 228, 106, 36, "Input", false, mainh_tabdrugs)
	guiSetFont(mainhd_inputbutton, "default-bold-small")
	guiSetProperty(mainhd_inputbutton, "NormalTextColour", "FFAAAAAA")
	mainhd_takebutton = guiCreateButton(278, 228, 106, 36, "Take", false, mainh_tabdrugs)
	guiSetFont(mainhd_takebutton, "default-bold-small")
	guiSetProperty(mainhd_takebutton, "NormalTextColour", "FFAAAAAA")
	radiobutton1 = guiCreateRadioButton(20, 67, 106, 19, "Ritalin", false, mainh_tabdrugs)
	radiobutton2 = guiCreateRadioButton(132, 100, 99, 19, "Heroine", false, mainh_tabdrugs)
	radiobutton3 = guiCreateRadioButton(132, 67, 98, 19, "Ecstasy", false, mainh_tabdrugs)
	radiobutton4 = guiCreateRadioButton(20, 100, 106, 19, "Weed", false, mainh_tabdrugs)

	mainh_tabmoney = guiCreateTab("Money", mainh_tabs)

	mainhm_labelx = guiCreateLabel(106, 7, 211, 33, "Store Your Money", false, mainh_tabmoney)
	guiSetFont(mainhm_labelx, "clear-normal")
	guiLabelSetColor(mainhm_labelx, 254, 126, 0)
	guiLabelSetHorizontalAlign(mainhm_labelx, "center", false)
	guiLabelSetVerticalAlign(mainhm_labelx, "center")
	mainhm_acclabel = guiCreateLabel(126, 47, 182, 33, "Account: nil", false, mainh_tabmoney)
	guiSetFont(mainhm_acclabel, "clear-normal")
	guiLabelSetColor(mainhm_acclabel, 254, 126, 0)
	guiLabelSetVerticalAlign(mainhm_acclabel, "center")
	mainhm_ballabel = guiCreateLabel(126, 90, 182, 29, "Balance: $nil", false, mainh_tabmoney)
	guiSetFont(mainhm_ballabel, "clear-normal")
	guiLabelSetColor(mainhm_ballabel, 254, 126, 0)
	guiLabelSetVerticalAlign(mainhm_ballabel, "center")
	mainhm_labelx2 = guiCreateLabel(118, 176, 182, 33, "Enter a valid amount", false, mainh_tabmoney)
	guiSetFont(mainhm_labelx2, "default-bold-small")
	guiLabelSetColor(mainhm_labelx2, 254, 126, 0)
	guiLabelSetHorizontalAlign(mainhm_labelx2, "center", false)
	guiLabelSetVerticalAlign(mainhm_labelx2, "center")
	mainhm_edit = guiCreateEdit(110, 133, 182, 33, "", false, mainh_tabmoney)
	mainhm_deposit = guiCreateButton(267, 229, 96, 32, "Deposit", false, mainh_tabmoney)
	guiSetFont(mainhm_deposit, "default-bold-small")
	guiSetProperty(mainhm_deposit, "NormalTextColour", "FFAAAAAA")
	mainhm_withdraw = guiCreateButton(55, 229, 96, 32, "Withdraw", false, mainh_tabmoney)
	guiSetFont(mainhm_withdraw, "default-bold-small")
	guiSetProperty(mainhm_withdraw, "NormalTextColour", "FFAAAAAA")

	mainh_tabmusic = guiCreateTab("Music", mainh_tabs)

	mainhmm_labelx = guiCreateLabel(102, 10, 221, 24, "House Music", false, mainh_tabmusic)
	guiSetFont(mainhmm_labelx, "clear-normal")
	guiLabelSetColor(mainhmm_labelx, 254, 126, 0)
	guiLabelSetHorizontalAlign(mainhmm_labelx, "center", false)
	guiLabelSetVerticalAlign(mainhmm_labelx, "center")
	mainhmm_label2 = guiCreateLabel(68, 34, 291, 17, "We all love to party and listen to the vibes of House Music", false, mainh_tabmusic)
	guiSetFont(mainhmm_label2, "default-small")
	guiLabelSetColor(mainhmm_label2, 254, 126, 0)
	guiLabelSetHorizontalAlign(mainhmm_label2, "center", false)
	mainhmm_label3 = guiCreateLabel(16, 96, 303, 23, "Process is simple, enter a valid URL, click play.", false, mainh_tabmusic)
	guiSetFont(mainhmm_label3, "default-bold-small")
	guiLabelSetColor(mainhmm_label3, 254, 126, 0)
	guiLabelSetVerticalAlign(mainhmm_label3, "center")
	mainhmm_label4 = guiCreateLabel(250, 181, 145, 24, "Music State: Stopped", false, mainh_tabmusic)
	guiSetFont(mainhmm_label4, "default-bold-small")
	guiLabelSetColor(mainhmm_label4, 254, 126, 0)
	guiLabelSetHorizontalAlign(mainhmm_label4, "center", false)
	guiLabelSetVerticalAlign(mainhmm_label4, "center")
	mainhmm_edit = guiCreateEdit(16, 61, 395, 31, "", false, mainh_tabmusic)
	mainhmm_play = guiCreateButton(10, 180, 108, 35, "Play Music", false, mainh_tabmusic)
	guiSetFont(mainhmm_play, "clear-normal")
	guiSetProperty(mainhmm_play, "NormalTextColour", "FFAAAAAA")
	mainhmm_stop = guiCreateButton(128, 180, 108, 35, "Stop Music", false, mainh_tabmusic)
	guiSetFont(mainhmm_stop, "clear-normal")
	guiSetProperty(mainhmm_stop, "NormalTextColour", "FFAAAAAA")

	--[[mainh_tabadmin = guiCreateTab("Admin", mainh_tabs)

	mainha_labelx = guiCreateLabel(98, 10, 223, 26, "Administrative Actions", false, mainh_tabadmin)
	guiSetFont(mainha_labelx, "clear-normal")
	guiLabelSetColor(mainha_labelx, 254, 126, 0)
	guiLabelSetHorizontalAlign(mainha_labelx, "center", false)
	guiLabelSetVerticalAlign(mainha_labelx, "center")
	mainha_label2 = guiCreateLabel(10, 170, 355, 26, "First edit box is always the name of element, remember!", false, mainh_tabadmin)
	guiSetFont(mainha_label2, "default-bold-small")
	guiLabelSetColor(mainha_label2, 254, 126, 0)
	guiLabelSetHorizontalAlign(mainha_label2, "center", false)
	guiLabelSetVerticalAlign(mainha_label2, "center")
	mainha_label3 = guiCreateLabel(10, 196, 355, 24, "Second edit box is always the amount of element, remember!", false, mainh_tabadmin)
	guiSetFont(mainha_label3, "default-bold-small")
	guiLabelSetColor(mainha_label3, 254, 126, 0)
	guiLabelSetHorizontalAlign(mainha_label3, "center", false)
	guiLabelSetVerticalAlign(mainha_label3, "center")
	mainha_tmedit = guiCreateEdit(10, 46, 150, 27, "", false, mainh_tabadmin)
	mainha_editdrugname = guiCreateEdit(10, 78, 78, 25, "", false, mainh_tabadmin)
	mainha_editdrugamount = guiCreateEdit(92, 78, 78, 25, "", false, mainh_tabadmin)
	mainha_wepnameedit = guiCreateEdit(10, 107, 78, 25, "", false, mainh_tabadmin)
	mainha_wepamtedit = guiCreateEdit(92, 107, 78, 25, "", false, mainh_tabadmin)
	mainha_musicedit = guiCreateEdit(10, 138, 150, 27, "", false, mainh_tabadmin)
	mainha_tmbtn = guiCreateButton(165, 46, 88, 27, "Take Money", false, mainh_tabadmin)
	guiSetFont(mainha_tmbtn, "default-bold-small")
	guiSetProperty(mainha_tmbtn, "NormalTextColour", "FFAAAAAA")
	mainha_gmbtn = guiCreateButton(257, 46, 88, 27, "Give Money", false, mainh_tabadmin)
	guiSetFont(mainha_gmbtn, "default-bold-small")
	guiSetProperty(mainha_gmbtn, "NormalTextColour", "FFAAAAAA")
	mainha_tdbtn = guiCreateButton(175, 76, 88, 27, "Take Drugs", false, mainh_tabadmin)
	guiSetFont(mainha_tdbtn, "default-bold-small")
	guiSetProperty(mainha_tdbtn, "NormalTextColour", "FFAAAAAA")
	mainha_twbtn = guiCreateButton(175, 107, 88, 27, "Take Weps", false, mainh_tabadmin)
	guiSetFont(mainha_twbtn, "default-bold-small")
	guiSetProperty(mainha_twbtn, "NormalTextColour", "FFAAAAAA")
	mainha_gwbtn = guiCreateButton(267, 107, 88, 27, "Give Weps", false, mainh_tabadmin)
	guiSetFont(mainha_gwbtn, "default-bold-small")
	guiSetProperty(mainha_gwbtn, "NormalTextColour", "FFAAAAAA")
	mainha_pmbtn = guiCreateButton(165, 138, 88, 27, "Play Music", false, mainh_tabadmin)
	guiSetFont(mainha_pmbtn, "default-bold-small")
	guiSetProperty(mainha_pmbtn, "NormalTextColour", "FFAAAAAA")
	mainha_smbtn = guiCreateButton(257, 138, 88, 27, "Stop Music", false, mainh_tabadmin)
	guiSetFont(mainha_smbtn, "default-bold-small")
	guiSetProperty(mainha_smbtn, "NormalTextColour", "FFAAAAAA")
	mainha_gdbtn = guiCreateButton(267, 76, 88, 27, "Give Drugs", false, mainh_tabadmin)
	guiSetFont(mainha_gdbtn, "default-bold-small")
	guiSetProperty(mainha_gdbtn, "NormalTextColour", "FFAAAAAA")]]


	mainh_label = guiCreateLabel(9, 33, 210, 37, "House Panel Maintenence", false, mainh_panel)
	guiSetFont(mainh_label, "clear-normal")
	guiLabelSetColor(mainh_label, 254, 126, 0)
	guiLabelSetHorizontalAlign(mainh_label, "center", false)
	guiLabelSetVerticalAlign(mainh_label, "center")
	mainh_ownerlabel = guiCreateLabel(9, 74, 210, 37, "House Owner: prime", false, mainh_panel)
	guiSetFont(mainh_ownerlabel, "default-bold-small")
	guiLabelSetColor(mainh_ownerlabel, 254, 126, 0)
	guiLabelSetVerticalAlign(mainh_ownerlabel, "center")
	mainh_mscplylabel = guiCreateLabel(9, 111, 210, 37, "Music Playing: No", false, mainh_panel)
	guiSetFont(mainh_mscplylabel, "default-bold-small")
	guiLabelSetColor(mainh_mscplylabel, 254, 126, 0)
	guiLabelSetVerticalAlign(mainh_mscplylabel, "center")
	--[[mainh_hselcklabel = guiCreateLabel(9, 148, 210, 37, "House Locked: No", false, mainh_panel)
	guiSetFont(mainh_hselcklabel, "default-bold-small")
	guiLabelSetColor(mainh_hselcklabel, 254, 126, 0)
	guiLabelSetVerticalAlign(mainh_hselcklabel, "center")]]
	--mainh_decorate = guiCreateButton(10, 285, 200, 37, "Edit House", false, mainh_panel)
	mainh_closebutton = guiCreateButton(10, 339, 200, 37, "Exit House Panel", false, mainh_panel)
	guiSetFont(mainh_closebutton, "clear-normal")
	guiSetProperty(mainh_closebutton, "NormalTextColour", "FFAAAAAA")

	centerWindow(mainh_panel)


	setTimer(function()
		if mainh_panel then
			if guiGetVisible(mainh_panel) then
				showCursor(true)
				getMyDrug()
			end
		end
	end,100,0)
	--[[addEventHandler("onClientGUIClick",mainh_decorate, function()
		if source == mainh_decorate then
			forceHide()
			setDecoratePanelVisible(true)
		end
	end)]]

	addEventHandler("onClientGUIClick", mainh_closebutton, function()
		if(source==mainh_closebutton)then
			if getLocalPlayer() then
				guiSetVisible(mainh_panel, false)
				setElementData(localPlayer,"ho",false)
				toggleAllControls(true,true,true)
				setElementFrozen(localPlayer,false)
				--if isTimer(weaponSynceTimer) then killTimer(weaponSynceTimer) end
				if isTimer(synceTimer) then killTimer(synceTimer) end
				if isTimer(moneyChecker) then killTimer(moneyChecker) end
				showCursor(false)
			end
		end
	end)
	addEventHandler( "onClientGUIClick", root, house_panel_actions)
	addEventHandler( "onClientGUIChanged", mainhw_clipedit, removeL)
	addEventHandler( "onClientGUIChanged", mainhd_drgnamedit, removeL)
	addEventHandler( "onClientGUIChanged", mainhm_edit, removeL)
	if isTimer(synceTimer) then killTimer(synceTimer) end
	synceTimer = setTimer(synceTiming,500,0)
end
addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), init_house_panel)


function synceTiming()
	if mainh_panel then
		if guiGetVisible(mainh_panel) then
			showCursor(true)
			getMyDrug()
			if getElementData(localPlayer,"isPlayerJailed") or getElementData(localPlayer,"isPlayerArrested") then
				forceHide()
			end
			if getPlayerPing(localPlayer) >= 400 then
				forceHide()
				exports.NGCdxmsg:createNewDxMessage("You are lagging try again later",255,0,0)
			end
			if tonumber(getElementData(localPlayer,"FPS")) < 5 then
				forceHide()
				exports.NGCdxmsg:createNewDxMessage("You are lagging try again later",255,0,0)
			end
			if getElementDimension(localPlayer) == 0 or OMG and tonumber(OMG) and tonumber(OMG) ~= getElementDimension(localPlayer) then
				forceHide()
			end
			if getElementInterior(localPlayer) == 0 then
				if getElementData(localPlayer,"isPlayerInHouse") then
					setElementData(localPlayer,"isPlayerInHouse",false)
					forceHide()
				end
			end
			if getElementData(localPlayer,"drugsOpen") then
				forceHide()
			end
			if getElementData(localPlayer,"isPlayerOnPhone") then
				forceHide()
				exports.NGCdxmsg:createNewDxMessage("You can't use house Inventory while you're using phone!",255,0,0)
			end
			if disabled then
				forceHide()
				exports.NGCdxmsg:createNewDxMessage("You can't use house Inventory while bounded ("..theKey..")",255,0,0)
			end
			if isConsoleActive() then
				forceHide()
				exports.NGCdxmsg:createNewDxMessage("You can't use house Inventory while Console window is open",255,0,0)
			end
			if isChatBoxInputActive() then
				forceHide()
				exports.NGCdxmsg:createNewDxMessage("You can't use house Inventory while Chat input box is open",255,0,0)
			end
			if isMainMenuActive() then
				forceHide()
				exports.NGCdxmsg:createNewDxMessage("You can't use house Inventory while MTA Main Menu is open",255,0,0)
			end
			if mainh_panel and guiGetVisible(mainh_panel) then
				for k,v in ipairs(getElementsByType("gui-window")) do
					if mainh_panel ~= v then
						if guiGetVisible(v) then
							forceHide()
						end
					end
				end
			end
		end
	end
end

function forceHide()
	guiSetVisible(mainh_panel, false)
	setElementData(localPlayer,"ho",false)
	toggleAllControls(true,true,true)
	setElementFrozen(localPlayer,false)
	---if isTimer(weaponSynceTimer) then killTimer(weaponSynceTimer) end
	if isTimer(moneyChecker) then killTimer(moneyChecker) end
	if isTimer(synceTimer) then killTimer(synceTimer) end
	showCursor(false)
	triggerEvent("closeHousingDecor",localPlayer)
end

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

function openInventory()
	if getLocalPlayer() then
		if (allowed_dat_panel == false) then return end
		if (getElementInterior(localPlayer) == 0) then exports.NGCdxmsg:createNewDxMessage("You cannot use this panel in the outside world!", 255, 0, 0) return end
		if (not guiGetVisible(mainh_panel)) then
			for k,v in ipairs(houseData) do
				OMG = v[1]
			end
			enableButtons()
			--setDecoratePanelVisible(false)
			guiSetVisible(mainh_panel, true)
			setElementData(localPlayer,"ho",true)
			updateMyWeps()
			showCursor(true)
			toggleAllControls(false,true,true)
			setElementFrozen(localPlayer,true)
			if isTimer(synceTimer) then killTimer(synceTimer) end
			synceTimer = setTimer(synceTiming,500,0)
			getMyDrug()
			triggerServerEvent("NGChousing.getHouseMoney",localPlayer,getElementDimension(localPlayer))
			triggerServerEvent("NGChousing.sendHouseWeapons",localPlayer,getElementDimension(localPlayer))
			triggerServerEvent("NGChousing.sendHouseDrugs",localPlayer,getElementDimension(localPlayer))
			weaponSynceTimer = setTimer(function() updateMyWeps() end,2000,1)
		else
			guiSetVisible(mainh_panel, false)
			setElementData(localPlayer,"ho",false)
			toggleAllControls(true,true,true)
			setElementFrozen(localPlayer,false)
			showCursor(false)
			--if isTimer(weaponSynceTimer) then killTimer(weaponSynceTimer) end
			if isTimer(moneyChecker) then killTimer(moneyChecker) end
			if isTimer(synceTimer) then killTimer(synceTimer) end
		end
	end
end
--addCommandHandler("housepanel", handle_house_panel)

function dat_house_panel(player,id, dim,intx,ow)
	if player == localPlayer then
		outputDebugString(id)
		outputDebugString(dim)

		if (id and dim and (tonumber(id) == tonumber(dim))) then
			if (allowed_dat_panel == false) then
				allowed_dat_panel = true
				enableButtons()
				for k,v in ipairs(getElementsByType("player")) do
					if exports.server:getPlayerAccountID(v) == ow then
						guiSetText(mainh_ownerlabel,"House owner: "..getPlayerName(v))
						break
					end
					if exports.server:getPlayerAccountID(v) ~= ow then
						guiSetText(mainh_ownerlabel,"House owner: Unknown")
					end
				end
				outputDebugString("Going to decor housing pickup")
				triggerEvent("createDecorHousing",localPlayer,intx,id)
				exports.NGCdxmsg:createNewDxMessage("You have been granted housing access, please use /housepanel to toggle the house panel.",0,255,0)
			else
				allowed_dat_panel = false
			end
		end
	end
end
addEvent("NGChousing.dat_house_panel", true)
addEventHandler("NGChousing.dat_house_panel", root, dat_house_panel)

function des_house_panel()
	if source == localPlayer then
		if (allowed_dat_panel == true) then
			allowed_dat_panel = false
			quitEditor()
			delete()
		end
	end
end
addEvent("NGChousing.des_house_panel", true)
addEventHandler("NGChousing.des_house_panel", root, des_house_panel)

addEventHandler("onPlayerCommand",root,function()
	if getElementData(localPlayer,"ho") then
		cancelEvent()
	end
end)


local antiSpam = {}

function house_panel_actions()
	if (source == mainhmm_play) then
		local url = guiGetText(mainhmm_edit)
		if (url == "") then exports.NGCdxmsg:createNewDxMessage("You have to enter a link to play!",255,0,0) return end
		local x, y, z = getElementPosition(localPlayer)
		local int = getElementInterior(localPlayer)
		local dim = getElementDimension(localPlayer)
		triggerServerEvent("NGChousing.house_create_music", root, x, y, z, int, dim, url)
	elseif (source == mainhmm_stop) then
		triggerServerEvent("NGChousing.remove_house_speaker", root,localPlayer)
	elseif source == mainhm_deposit then
		if isTimer(antiSpam[source]) then exports.NGCdxmsg:createNewDxMessage("Please wait few seconds before you click again",255,0,0) return false end
		antiSpam[source] = setTimer(function() end,3000,1)
		disableButtons("money")
		triggerServerEvent("NGChousing.setHouseMoney",localPlayer,localPlayer,guiGetText(mainhm_edit))
	elseif source == mainhm_withdraw then
		if isTimer(antiSpam[source]) then exports.NGCdxmsg:createNewDxMessage("Please wait few seconds before you click again",255,0,0) return false end
		antiSpam[source] = setTimer(function() end,3000,1)
		disableButtons("money")
		triggerServerEvent("NGChousing.takeHouseMoney",localPlayer,localPlayer,guiGetText(mainhm_edit))
	elseif source == mainhw_inputbutton then
		if isTimer(antiSpam[source]) then exports.NGCdxmsg:createNewDxMessage("Please wait few seconds before you click again",255,0,0) return false end
		antiSpam[source] = setTimer(function() end,3000,1)
		local row = guiGridListGetSelectedItem(wepsGrid)
		if row ~= -1 and row ~= false and row ~= nil then
			local wepAmount = guiGetText(mainhw_clipedit)
			local wepAmount = tonumber(wepAmount)
			if wepAmount < 10 then exports.NGCdxmsg:createNewDxMessage("You can't deposit less than 10 ammo!",255,255,0) return end
			local wepID = getWeaponIDFromName(guiGridListGetItemText(wepsGrid,row,1))
			local wepID = tonumber(wepID)
			for k,v in pairs(myWeps) do
				if getWeaponIDFromName(v[1]) == wepID then
					if tonumber(v[2]) < wepAmount then
						exports.NGCdxmsg:createNewDxMessage("You don't have "..wepAmount.." "..guiGridListGetItemText(wepsGrid,row,1).." ammo, you only have "..guiGridListGetItemText(wepsGrid,row,2).."",255,255,0)
						return
					end
				end
			end
			if guiRadioButtonGetSelected(hs.radiobutton[1]) then
				disableButtons("weapon")
				triggerServerEvent("NGChousing.addHouseWeapon",localPlayer,wepID,wepAmount,1)
			elseif guiRadioButtonGetSelected(hs.radiobutton[2]) then
				disableButtons("weapon")
				triggerServerEvent("NGChousing.addHouseWeapon",localPlayer,wepID,wepAmount,2)
			elseif guiRadioButtonGetSelected(hs.radiobutton[3]) then
				disableButtons("weapon")
				triggerServerEvent("NGChousing.addHouseWeapon",localPlayer,wepID,wepAmount,3)
			elseif guiRadioButtonGetSelected(hs.radiobutton[4]) then
				disableButtons("weapon")
				triggerServerEvent("NGChousing.addHouseWeapon",localPlayer,wepID,wepAmount,4)
			end
		else
			exports.NGCdxmsg:createNewDxMessage("You didn't select a weapon",255,255,0)
			return
		end
	elseif source == mainhw_takebutton then
		if isTimer(antiSpam[source]) then exports.NGCdxmsg:createNewDxMessage("Please wait few seconds before you click again",255,0,0) return false end
		antiSpam[source] = setTimer(function() end,3000,1)
		if guiRadioButtonGetSelected(hs.radiobutton[1]) then
			disableButtons("weapon")
			triggerServerEvent("NGChousing.takeHouseWeapon",localPlayer,1)
		elseif guiRadioButtonGetSelected(hs.radiobutton[2]) then
			disableButtons("weapon")
			triggerServerEvent("NGChousing.takeHouseWeapon",localPlayer,2)
		elseif guiRadioButtonGetSelected(hs.radiobutton[3]) then
			disableButtons("weapon")
			triggerServerEvent("NGChousing.takeHouseWeapon",localPlayer,3)
		elseif guiRadioButtonGetSelected(hs.radiobutton[4]) then
			disableButtons("weapon")
			triggerServerEvent("NGChousing.takeHouseWeapon",localPlayer,4)
		end
	elseif source == mainhd_inputbutton then
		if isTimer(antiSpam[source]) then exports.NGCdxmsg:createNewDxMessage("Please wait few seconds before you click again",255,0,0) return false end
		antiSpam[source] = setTimer(function() end,3000,1)
		if guiRadioButtonGetSelected(radiobutton1) then
			local amount = guiGetText(mainhd_drgnamedit)
			if tonumber(amount) then
				if tonumber(amount) > 0 then
					local DrugName,DrugHits = getDrug("Ritalin")
					if tonumber(DrugHits) >= tonumber(amount) then
						disableButtons("drug")
						--triggerServerEvent("NGChousing.addHouseDrug",localPlayer,DrugName,amount)
					else
						exports.NGCdxmsg:createNewDxMessage("You don't have this amount of drugs",255,0,0)
					end
				end
			end
		elseif guiRadioButtonGetSelected(radiobutton2) then
			local amount = guiGetText(mainhd_drgnamedit)
			if tonumber(amount) then
				if tonumber(amount) > 0 then
					local DrugName,DrugHits = getDrug("Heroine")
					if tonumber(DrugHits) >= tonumber(amount) then
						disableButtons("drug")
						--triggerServerEvent("NGChousing.addHouseDrug",localPlayer,DrugName,amount)
					else
						exports.NGCdxmsg:createNewDxMessage("You don't have this amount of drugs",255,0,0)
					end
				end
			end
		elseif guiRadioButtonGetSelected(radiobutton3) then
			local amount = guiGetText(mainhd_drgnamedit)
			if tonumber(amount) then
				if tonumber(amount) > 0 then
					local DrugName,DrugHits = getDrug("Ecstasy")
					if tonumber(DrugHits) >= tonumber(amount) then
						disableButtons("drug")
						--triggerServerEvent("NGChousing.addHouseDrug",localPlayer,DrugName,amount)
					else
						exports.NGCdxmsg:createNewDxMessage("You don't have this amount of drugs",255,0,0)
					end
				end
			end
		elseif guiRadioButtonGetSelected(radiobutton4) then
			local amount = guiGetText(mainhd_drgnamedit)
			if tonumber(amount) then
				if tonumber(amount) > 0 then
					local DrugName,DrugHits = getDrug("Weed")
					if tonumber(DrugHits) >= tonumber(amount) then
						disableButtons("drug")
						--triggerServerEvent("NGChousing.addHouseDrug",localPlayer,DrugName,amount)
					else
						exports.NGCdxmsg:createNewDxMessage("You don't have this amount of drugs",255,0,0)
					end
				end
			end
		end
	elseif source == mainhd_takebutton then
		if isTimer(antiSpam[source]) then exports.NGCdxmsg:createNewDxMessage("Please wait few seconds before you click again",255,0,0) return false end
		antiSpam[source] = setTimer(function() end,3000,1)
		local row = guiGridListGetSelectedItem(mainhd_gridlistdrugs)
		if row ~= -1 and row ~= false and row ~= nil then
			local mm = guiGetText(mainhd_drgnamedit)
			if mm and tonumber(mm) then
				local text = tonumber(guiGetText(mainhd_drgnamedit))
				if tonumber(text) and tonumber(text) < 1 then exports.NGCdxmsg:createNewDxMessage("You can't withdraw less than 1 hit!",255,255,0) return end
				local name = guiGridListGetItemText(mainhd_gridlistdrugs,row,1)
				local houseAmount = tonumber(guiGridListGetItemText(mainhd_gridlistdrugs,row,2))
				if tonumber(houseAmount) and tonumber(houseAmount) < tonumber(text) then
					exports.NGCdxmsg:createNewDxMessage("The house storage doesn't have "..text.." "..name..", only "..houseAmount.."",255,255,0)
					return
				end
				disableButtons("drug")
				--triggerServerEvent("NGChousing.takeHouseDrug",localPlayer,name,text,houseAmount)
			end
		end
	end
end


local house_sound = {}

function play_house_sound(x, y, z, int, dim, url)
	if (state == "No") then
		state = "Yes"
		state_ = "Started"
		house_sound[localPlayer] = playSound3D(url, x, y, z)
		setElementInterior(house_sound[localPlayer], int)
		setElementDimension(house_sound[localPlayer], dim)
		setSoundMaxDistance(house_sound[localPlayer], 100)
		guiSetText(mainh_mscplylabel, "Music Playing: "..state)
		guiSetText(mainhmm_label4, "Music State: "..state_)
	end
end
addEvent("NGChousing.play_house_sound", true)
addEventHandler("NGChousing.play_house_sound", root, play_house_sound)

function stop_house_sound()

end
addEvent("NGChousing.stop_house_sound", true)
addEventHandler("NGChousing.stop_house_sound", root, stop_house_sound)

function stop_house_sound2()
	if (state == "Yes") then
		if house_sound[localPlayer] then stopSound(house_sound[localPlayer]) end
		state = "No"
		state_ = "Stopped"
		guiSetText(mainh_mscplylabel, "Music Playing: "..state)
		guiSetText(mainhmm_label4, "Music State: "..state_)
		for k,v in ipairs(getElementsByType("player")) do
			if house_sound[localPlayer] then stopSound(house_sound[localPlayer]) end
		end
	end
end
addEvent("NGChousing.stop_house_sound2", true)
addEventHandler("NGChousing.stop_house_sound2", root, stop_house_sound2)


function setBalanceLable(balances)
	guiSetText(mainhm_acclabel,"My Money: $ "..exports.server:convertNumber(tonumber(getPlayerMoney(localPlayer))))
	guiSetText(mainhm_ballabel,"House Money: $ "..exports.server:convertNumber(tonumber(balances)))
	moneyChecker = setTimer(function()
	guiSetText(mainhm_acclabel,"My Money: $ "..exports.server:convertNumber(tonumber(getPlayerMoney(localPlayer))))
	end,1000,0)
end
addEvent("NGChousing.setBalanceLable", true)
addEventHandler("NGChousing.setBalanceLable", root, setBalanceLable)

function updateHouseWeapons(player,value,sl1)
	updateMyWeps()
	--weaponSynceTimer = setTimer(function() updateMyWeps() end,3000,1)
	if tonumber(sl1) or type(sl1) == "number" then
		sl1 = (0)..", "..(0)
	end
	if value == 1 then
		guiSetText(slot1, "Slot 1: "..getWeaponNameFromID(gettok(sl1, 1, ",")).."\nAmmo: "..gettok(sl1, 2, ","))
	elseif value == 2 then
		guiSetText(slot2, "Slot 2: "..getWeaponNameFromID(gettok(sl1, 1, ",")).."\nAmmo: "..gettok(sl1, 2, ","))
	elseif value == 3 then
		guiSetText(slot3, "Slot 3: "..getWeaponNameFromID(gettok(sl1, 1, ",")).."\nAmmo: "..gettok(sl1, 2, ","))
	elseif value == 4 then
		guiSetText(slot4, "Slot 4: "..getWeaponNameFromID(gettok(sl1, 1, ",")).."\nAmmo: "..gettok(sl1, 2, ","))
	end
end
addEvent("NGChousing.synceWeapons", true)
addEventHandler("NGChousing.synceWeapons", root, updateHouseWeapons)

function updateHouseDrugs(player,housingDrug)
	updateHPDrugs(housingDrug)
	getMyDrug()
end
addEvent("NGChousing.synceDrugs", true)
addEventHandler("NGChousing.synceDrugs", root, updateHouseDrugs)




function getFormattedDate(stamp)
	local month = ""
	local year = ""
	local day = ""
	stamp=tostring(stamp)
	for i = 1, #stamp do
		local c = stamp:sub(i,i)
		if i > 0 and i < 5 then
			year = year..""..c..""
		end
		if i == 5 or i == 6 then
			month=month..""..c..""
		end
		if i > 6 then
			day=day..""..c..""
		end
	end
	local formatted = year.."/"..month.."/"..day..""
	return formatted
end


function updateMyWeps()
	myWeps = {}
	guiGridListClear(wepsGrid)
	for i=2,8 do
		if i ~= 7 then
			local ammo = getPedTotalAmmo(localPlayer,i)
			local name = getWeaponNameFromID(getPedWeapon(localPlayer,i))
			table.insert(myWeps,{name,ammo})
		end
	end
	for k,v in pairs(myWeps) do
		if tonumber(v[2]) > 2 then
			local row = guiGridListAddRow(wepsGrid)
			for i=1,2 do
				guiGridListSetItemText ( wepsGrid, row, i, v[i], false, false )
			end
		end
	end
end


function updateHPDrugs(drTable)
	guiGridListClear(mainhd_gridlistdrugs)
	if drTable == nil then
		drTable = {}
	end
	t = fromJSON(drTable)
	if t == nil then
		t={}
	end
	for k,v in pairs(t) do
		if v > 0 then
			local row = guiGridListAddRow(mainhd_gridlistdrugs)
			guiGridListSetItemText ( mainhd_gridlistdrugs, row, 1, k, false, false )
			guiGridListSetItemText ( mainhd_gridlistdrugs, row, 2, v, false, false )
		end
	end
end


function getDrug(name)
	local drugsTable,drugNames = exports.CSGdrugs:getDrugsTable()
	if drugsTable == nil then return false end
	for a,b in pairs(drugsTable) do
		local a = tostring(a)
		local a2 = tonumber(a)
		if (drugNames[a2] == name) then
			return drugNames[a2],tonumber(b)
		end
	end
end

function getMyDrug()
	local drugsTable,drugNames = exports.CSGdrugs:getDrugsTable()
	if drugsTable == nil then return false end
	for a,b in pairs(drugsTable) do
		local a = tostring(a)
		local a2 = tonumber(a)
		if (drugNames[a2]) then
			if drugNames[a2] == "Ritalin" then
				guiSetText(radiobutton1,"Ritalin ("..b..")")
			elseif drugNames[a2] == "Heroine" then
				guiSetText(radiobutton2,"Heroine ("..b..")")
			elseif drugNames[a2] == "Ecstasy" then
				guiSetText(radiobutton3,"Ecstasy ("..b..")")
			elseif drugNames[a2] == "Weed" then
				guiSetText(radiobutton4,"Weed ("..b..")")
			end
		end
	end
end

addEvent("enableInventButton",true)
addEventHandler("enableInventButton",root,function(who)
	if who == "weapon" then
		guiSetEnabled(mainhw_inputbutton,true)
		guiSetEnabled(mainhw_takebutton,true)
	elseif who == "drug" then
		guiSetEnabled(mainhd_inputbutton,true)
		guiSetEnabled(mainhd_takebutton,true)
	elseif who == "money" then
		guiSetEnabled(mainhm_deposit,true)
		guiSetEnabled(mainhm_withdraw,true)
	end
end)

function enableButtons()
	guiSetEnabled(mainhw_inputbutton,true)
	guiSetEnabled(mainhw_takebutton,true)
	guiSetEnabled(mainhd_inputbutton,true)
	guiSetEnabled(mainhd_takebutton,true)
	guiSetEnabled(mainhm_deposit,true)
	guiSetEnabled(mainhm_withdraw,true)
end

function disableButtons(who)
	if who == "weapon" then
		guiSetEnabled(mainhw_inputbutton,false)
		guiSetEnabled(mainhw_takebutton,false)
	elseif who == "drug" then
		guiSetEnabled(mainhd_inputbutton,false)
		guiSetEnabled(mainhd_takebutton,false)
	elseif who == "money" then
		guiSetEnabled(mainhm_deposit,false)
		guiSetEnabled(mainhm_withdraw,false)
	end
end


function handleInterrupt( status, ticks )
	triggerServerEvent("checkPacket",localPlayer,status,ticks)
	if (status == 0) then
		enableButtons()
	elseif (status == 1) then
		disableButtons("weapon")
		disableButtons("drug")
		disableButtons("money")
	end
end
addEventHandler( "onClientPlayerNetworkStatus", root, handleInterrupt)
