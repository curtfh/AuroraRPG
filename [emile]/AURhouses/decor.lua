local screenWidth, screenHeight = guiGetScreenSize()
local screenW,screenH=guiGetScreenSize()

local intTable = {
	[1] = {231.3134765625,1187.427734375,1080.2578125,0,0,146.3483581543,3},
	[2] = {223.4521484375,1247.03125,1082.140625,0,0,99.419555664062,2},
	[3] = {226.8798828125,1287.2646484375,1082.140625,0,0,215.88189697266,1},
	[4] = {327.1201171875,1481.798828125,1084.4375,0,0,214.43716430664,15},
	[5] = {2454.0302734375,-1697.9609375,1013.5078125,0,0,353.1032409668,2},
	[6] = {247.9013671875,1113.1826171875,1080.9921875,0,0,229.64797973633,5},
	[7] = {373.0244140625,1472.4287109375,1080.1875,0,0,62.955383300781,15},
	[8] = {225.693359375,1039.38671875,1084.0119628906,0,0,1.2277526855469,7}, -- empty open house
	[9] = {2806.9892578125,-1165.3701171875,1025.5703125,0,0,184.9878692627,8},
	[10] = {2264.1337890625,-1211.7802734375,1049.0234375,0,0,230.01052856445,10},
	[11] = {2497.921875,-1694.5625,1014.7421875,0,0,286.62942504883,3},
	[12] = {2264.931640625,-1141.9716796875,1050.6328125,0,0,200.77546691895,10},
	[13] = {2363.7900390625,-1125.802734375,1050.875,0,0,62.592803955078,8},
	[14] = {2235.43359375,-1111.9755859375,1050.8828125,0,0,273.44564819336,5},
	[15] = {2285.943359375,-1137.703125,1050.8984375,0,0,279.10919189453,11},
	[16] = {2188.8369140625,-1200.693359375,1049.0234375,0,0,4.3094482421875,6},
	[17] = {2305.6669921875,-1211.365234375,1049.0234375,0,0,96.409240722656,6},
	[18] = {2213.77734375,-1078.28125,1050.484375,0,0,186.65231323242,1},
	[19] = {2235.8876953125,-1071.4580078125,1049.0234375,0,0,273.9235534668,2},
	[20] = {2318.365234375,-1019.263671875,1050.2109375,0,0,88.542907714844,9},
	[21] = {2331.70703125,-1070.326171875,1049.0234375,0,0,110.54885864258,6},
	[22] = {1225.36328125,-807.109375,1084.0078125,0,0,350.13137817383,5},
	[23] = {249.2001953125,302.2255859375,999.1484375,0,0,175.22088623047,1},
	[24] = {273.453125,303.62109375,999.1484375,0,0,220.41381835938,2},
	[25] = {2332.5107421875,-1148.9560546875,1050.703125,0,0,86.521392822266,12},
	[26] = {316.19921875,1119.16015625,1083.8828125,0,0,105.07760620117,5},
	[27] = {249.08203125,302.0654296875,999.1484375,0,0,228.19775390625,1},
	[28] = {134.900390625,1366.173828125,1083.8609619141,0,0,132.31860351562,5},
	[29] = {231.283203125,1068.0166015625,1084.2059326172,0,0,213.01441955566,6},
	[30] = {83.8984375,1330,1083.859375,0,0,83.461669921875,9},
	[31] = {35.0595703125,1341.7080078125,1084.375,0,0,270.81439208984,10},
	[32] = {366.021484375,1418.2568359375,1081.328125,0,0,224.41290283203,15},
	[33] = {2532.83984375,-1680.5400390625,1015.4985961914,0,0,245.07301330566,1},
}

local inv = {
	{"TV1",1429},
	{"TV2",1749},
	{"TV3",1518},
	{"WASHER",1208},
	{"BARBECUE",1481},
	{"WATERCOOLER",1808},
	{"BED1",1700},
	{"BED2",1701},
	{"SPEAKER",2229},
	{"PC",2190},
	{"CHAIR",1704},
	{"CHAIR2",1720},
	{"DESK",1819},
	{"DESK1",1820},
	{"DESK3",1822},
	{"SOFA",2291},
	{"SOFA1",2292},
	{"BOOKCASE",2164},
	{"TOILET",2514},
	{"SHOWER",2517},
	{"SHOWER1",2519},
	{"WASHBASIN",2518},
	{"TVDESK",2296},
	{"SIDEBOARDS",2014},
	{"SIDEBOARDS1",2015},
	{"SIDEBOARDS2",2016},
	{"FRIDGE",2141},
	{"FRIDGE1",2140},
	{"ROOMBOARD",2200},
	{"ROOMBOARD1",2307},
	{"ROOMBOARD2",2025},
	{"RADIATOR",1736},
	{"CHANDEILER",1661},
	{"CARPET",2815},
	{"KITCHENDESK",1516},
	{"KITCHENCHAIRS",1739},
	{"PCCHAIR",2356},
	{"PCDESK",2180},
}
local IDname = {
	[1429]="TV1",
	[1749]="TV2",---- lazy to remove these1749
	[1518]="TV3",---- lazy to remove these1518
	[1208]="WASHER",---- lazy to remove these1208
	[1481]="BARBECUE",---- lazy to remove these1481
	[1808]="WATERCOOLER",---- lazy to remove these1808
	[1700]="BED1",---- lazy to remove these1700
	[1701]="BED2",---- lazy to remove these1701
	[2229]="SPEAKER",---- lazy to remove these2229
	[2190]="PC",---- lazy to remove these2190
	[1704]="CHAIR",---- lazy to remove these1704
	[1720]="CHAIR2",---- lazy to remove these1720
	[1819]="DESK",---- lazy to remove these1819
	[1820]="DESK1",---- lazy to remove these1820
	[1822]="DESK3",---- lazy to remove these1822
	[2291]="SOFA",---- lazy to remove these2291
	[2292]="SOFA1",---- lazy to remove these2292
	[2164]="BOOKCASE",---- lazy to remove these2164
	[2514]="TOILET",---- lazy to remove these2514
	[2517]="SHOWER",---- lazy to remove these2517
	[2519]="SHOWER1",---- lazy to remove these2519
	[2518]="WASHBASIN",---- lazy to remove these2518
	[2296]="TVDESK",---- lazy to remove these2296
	[2014]="SIDEBOARDS",---- lazy to remove these2014
	[2015]="SIDEBOARDS1",---- lazy to remove these2015
	[2016]="SIDEBOARDS2",---- lazy to remove these2016
	[2141]="FRIDGE",---- lazy to remove these2141
	[2140]="FRIDGE1",---- lazy to remove these2140
	[2200]="ROOMBOARD",---- lazy to remove these2200
	[2307]="ROOMBOARD1",---- lazy to remove these2307
	[2025]="ROOMBOARD2",---- lazy to remove these2025
	[1736]="RADIATOR",---- lazy to remove these1736
	[1661]="CHANDEILER",---- lazy to remove these1661
	[2815]="CARPET",---- lazy to remove these2815
	[1516]="KITCHENDESK",---- lazy to remove these1516
	[1739]="KITCHENCHAIRS",---- lazy to remove these1739
	[2356]="PCCHAIR",---- lazy to remove these2356
	[2180]="PCDESK",---- lazy to remove these2180
}

decor = false
editorStart = false
icons = {}
object = {}
tempOb = {}
HD = {}
sql = {}
latestObjects = {}
HousingDec = {
    gridlist = {},
    window = {},
    button = {},
    label = {}
}
HousingDec.window[1] = guiCreateWindow(162, 154, 437, 360, "", false)
guiWindowSetSizable(HousingDec.window[1], false)
guiSetVisible(HousingDec.window[1],false)
HousingDec.gridlist[1] = guiCreateGridList(10, 51, 193, 234, false, HousingDec.window[1])
guiGridListAddColumn(HousingDec.gridlist[1], "Name", 0.5)
guiGridListAddColumn(HousingDec.gridlist[1], "ID", 0.5)
HousingDec.label[1] = guiCreateLabel(10, 24, 193, 22, "Edit your house", false, HousingDec.window[1])
guiSetFont(HousingDec.label[1], "default-bold-small")
guiLabelSetHorizontalAlign(HousingDec.label[1], "center", false)
guiLabelSetVerticalAlign(HousingDec.label[1], "center")
HousingDec.gridlist[2] = guiCreateGridList(229, 51, 193, 234, false, HousingDec.window[1])
guiGridListAddColumn(HousingDec.gridlist[2], "Name", 0.5)
guiGridListAddColumn(HousingDec.gridlist[2], "ID", 0.5)
HousingDec.label[2] = guiCreateLabel(229, 24, 193, 22, "House Items", false, HousingDec.window[1])
guiSetFont(HousingDec.label[2], "default-bold-small")
guiLabelSetHorizontalAlign(HousingDec.label[2], "center", false)
guiLabelSetVerticalAlign(HousingDec.label[2], "center")
HousingDec.button[1] = guiCreateButton(31, 295, 126, 27, "Editor", false, HousingDec.window[1])
guiSetProperty(HousingDec.button[1], "NormalTextColour", "FFAAAAAA")
HousingDec.button[2] = guiCreateButton(276, 294, 118, 28, "Remove", false, HousingDec.window[1])
guiSetProperty(HousingDec.button[2], "NormalTextColour", "FFAAAAAA")
HousingDec.button[3] = guiCreateButton(167, 322, 99, 28, "Close", false, HousingDec.window[1])
guiSetProperty(HousingDec.button[3], "NormalTextColour", "FFAAAAAA")


addEventHandler("onClientResourceStart",resourceRoot,function()
	setTimer(function()
		if HousingDec.window[1] then
			if guiGetVisible(HousingDec.window[1]) then
				showCursor(true)
			end
			if getElementDimension(localPlayer) == 0 or HOLYFUCK and tonumber(HOLYFUCK) and tonumber(HOLYFUCK) ~= getElementDimension(localPlayer) then
				if HousingDec.window[1] and guiGetVisible(HousingDec.window[1]) then
					setDecoratePanelVisible(false)
				end
			end
			local x,c = exports.NGCmanagement:isPlayerLagging(localPlayer)
			if x then
				return
			else
				if HousingDec.window[1] and guiGetVisible(HousingDec.window[1]) then
					setDecoratePanelVisible(false)
					exports.NGCdxmsg:createNewDxMessage(c,255,0,0)
				end
			end
			if HousingDec.window[1] and guiGetVisible(HousingDec.window[1]) then
				for k,v in ipairs(getElementsByType("gui-window")) do
					if HousingDec.window[1] ~= v then
						if guiGetVisible(v) then
							setDecoratePanelVisible(false)
						end
					end
				end
			end
		end
	end,100,0)
end)
addEventHandler("onClientGUIClick",root,function()
	if source == HousingDec.button[1] then
		local row,col = guiGridListGetSelectedItem(HousingDec.gridlist[1])
		if row and col and row ~= -1 and col ~= -1 then
			local who = guiGridListGetItemText(HousingDec.gridlist[1],row,2)
			if who then
				object = tonumber(who)
				guiSetVisible(HousingDec.window[1],false)
				showCursor(false)
				decor = false
				editorStart = true
				addBinds()
				removeEventHandler("onClientRender",root,drawingInfo)
				addEventHandler("onClientRender",root,drawingInfo)
			end
		else
			object = nil
			guiSetVisible(HousingDec.window[1],false)
			showCursor(false)
			decor = false
			editorStart = true
			addBinds()
			removeEventHandler("onClientRender",root,drawingInfo)
			addEventHandler("onClientRender",root,drawingInfo)
		end
	elseif source == HousingDec.button[2] then
		local row,col = guiGridListGetSelectedItem(HousingDec.gridlist[2])
		if row and col and row ~= -1 and col ~= -1 then
			local who = guiGridListGetItemData(HousingDec.gridlist[2],row,1)
			if who then
				for k,v in ipairs(HD) do
					if who == v then
						table.remove(HD,k)
						if isElement(who) then destroyElement(who) end
					end
				end
				saveDecor()
			end
		end
	elseif source == HousingDec.button[3] then
		setDecoratePanelVisible(false)
	end
end)

function decorcmd ()
	if (getElementData(getLocalPlayer(), "houseMapper") == true) then 
		if (guiGetVisible(HousingDec.window[1]) == true) then 
			setDecoratePanelVisible(false)
		else
			setDecoratePanelVisible(true)
		end 
	end 
end 
addCommandHandler("decor", decorcmd)

function drawingInfo()
	if decor == false then
		dxDrawBorderedText("Press X to enter editor.", 1.75, (screenW - 504) / 2, (screenH - 310) / 1.05, ((screenW - 504) / 2) + 504, ( (screenH - 44) / 1.05) + 44, tocolor(0,200,0, 255), 0.8, "pricedown", "center", "center", false, false, true, false, false)
	else
		dxDrawBorderedText("Press X to quit editor.", 1.75, (screenW - 504) / 2, (screenH - 310) / 1.05, ((screenW - 504) / 2) + 504, ( (screenH - 44) / 1.05) + 44, tocolor(255,0,0, 255), 0.8, "pricedown", "center", "center", false, false, true, false, false)
		dxDrawBorderedText("Press num_0 to delete the object.", 1.75, (screenW - 504) / 2, (screenH - 190) / 1.05, ((screenW - 504) / 2) + 504, ( (screenH - 44) / 1.05) + 44, tocolor(255,250,250, 255), 0.8, "pricedown", "center", "center", false, false, true, false, false)
		dxDrawBorderedText("Rotation Left / Right (num_4 | num_6)", 1.75, (screenW - 504) / 2, (screenH - 140) / 1.05, ((screenW - 504) / 2) + 504, ( (screenH - 44) / 1.05) + 44, tocolor(255,250,250, 255), 0.8, "pricedown", "center", "center", false, false, true, false, false)
		dxDrawBorderedText("Position Up / Down (num_2 | num_8)", 1.75, (screenW - 504) / 2, (screenH - 90) / 1.05, ((screenW - 504) / 2) + 504, ( (screenH - 44) / 1.05) + 44, tocolor(255,250,250, 255), 0.8, "pricedown", "center", "center", false, false, true, false, false)
		dxDrawBorderedText("Position Left (num_7 | num_9)", 1.75, (screenW - 504) / 2, (screenH - 40) / 1.05, ((screenW - 504) / 2) + 504, ( (screenH - 44) / 1.05) + 44, tocolor(255,250,250, 255), 0.8, "pricedown", "center", "center", false, false, true, false, false)
		dxDrawBorderedText("Position Right (num_1 | num_3)", 1.75, (screenW - 504) / 2, (screenH + 10) / 1.05, ((screenW - 504) / 2) + 504, ( (screenH - 44) / 1.05) + 44, tocolor(255,250,250, 255), 0.8, "pricedown", "center", "center", false, false, true, false, false)
	end
	dxDrawBorderedText("Press M to toggle cursor.", 1.75, (screenW - 504) / 2, (screenH - 260) / 1.05, ((screenW - 504) / 2) + 504, ( (screenH - 44) / 1.05) + 44, tocolor(255,255,255, 255), 0.8, "pricedown", "center", "center", false, false, true, false, false)
	if object ~= nil then
		dxDrawBorderedText("Press Space to place the object.", 1.75, (screenW - 504) / 2, (screenH - 350) / 1.05, ((screenW - 504) / 2) + 504, ( (screenH - 44) / 1.05) + 44, tocolor(255,150,0, 255), 0.8, "pricedown", "center", "center", false, false, true, false, false)
	end
end

function toggleInv()
	if decor == false then
		if getElementDimension(localPlayer) == 0 then return false end
		decor = true
	else
		decor = false
		editorStart = false
		saveDecor()
		removeEventHandler("onClientRender",root,drawingInfo)
		if isCursorShowing() then
			showCursor(false)
			removeEventHandler("onClientClick",root,clickDetect)
		end
	end
end

function msg(msg)
	exports.NGCdxmsg:createNewDxMessage(msg,255,0,0)
end

function placeObject()
	if object == nil then return false end
	if decor == false then msg("Please enter editor mode first") return false end
	if isElement(myObject) then msg("You already placed an item!") return false end
	local x,y,z = getElementPosition(localPlayer)
	myObject = createObject(object,x,y,z-0.5)
	table.insert(HD,myObject)
	setElementData(myObject,"housingItem",true)
	setElementDimension(myObject,getElementDimension(localPlayer))
	setElementInterior(myObject,getElementInterior(localPlayer))
	object = nil
end

function delete()
	for k,v in ipairs(HD) do
		if myObject == v then
			table.remove(HD,k)
			if isElement(v) then destroyElement(v) end
		end
	end
	if isElement(myObject) then destroyElement(myObject) end
	myObject = nil
	if decor == true then
		toggleInv()
	end
	decor = false
	editorStart = false
end

function positionx()
	if decor == false then return false end
	if myObject and isElement(myObject) then
		local x,y,z = getElementPosition(myObject)
		local rot = x + 0.1
		setElementPosition(myObject,rot,y,z)
	end
end

function positionx2()
	if decor == false then return false end
	if myObject and isElement(myObject) then
		local x,y,z = getElementPosition(myObject)
		local rot = x - 0.1
		setElementPosition(myObject,rot,y,z)
	end
end

function positiony()
	if decor == false then return false end
	if myObject and isElement(myObject) then
		local x,y,z = getElementPosition(myObject)
		local rot = y + 0.1
		setElementPosition(myObject,x,rot,z)
	end
end

function positiony2()
	if decor == false then return false end
	if myObject and isElement(myObject) then
		local x,y,z = getElementPosition(myObject)
		local rot = y - 0.1
		setElementPosition(myObject,x,rot,z)
	end
end

function positionup()
	if decor == false then return false end
	if myObject and isElement(myObject) then
		local x,y,z = getElementPosition(myObject)
		local rot = z + 0.1
		setElementPosition(myObject,x,y,rot)
	end
end

function positiondown()
	if decor == false then return false end
	if myObject and isElement(myObject) then
		local x,y,z = getElementPosition(myObject)
		local rot = z - 0.1
		setElementPosition(myObject,x,y,rot)
	end
end

function rotationleft()
	if decor == false then return false end
	if myObject and isElement(myObject) then
		local x,y,z = getElementRotation(myObject)
		local rot = z - 5
		setElementRotation(myObject,0,0,rot)
	end
end

function rotationright()
	if decor == false then return false end
	if myObject and isElement(myObject) then
		local x,y,z = getElementRotation(myObject)
		local rot = z + 5
		setElementRotation(myObject,0,0,rot)
	end
end

function toggleCursor()
	if decor == true then
		if isCursorShowing() then
			showCursor(false)
			removeEventHandler("onClientClick",root,clickDetect)
		else
			showCursor(true)
			addEventHandler("onClientClick",root,clickDetect)
		end
	end
end


function clickDetect( button, state, absoluteX, absoluteY, worldX, worldY, worldZ, clickedElement )
	if (clickedElement) and isElement(clickedElement) then
		if getElementData(clickedElement,"housingItem") then
			myObject=clickedElement
		else
			myObject=nil
		end
	end
end

addEvent("createDecorHousing",true)
addEventHandler("createDecorHousing",root,function(intx,id)
	if getElementDimension(localPlayer) == 0 then return false end
	outputDebugString("Entering housing of decor ID:"..intx)
	local x,y,z = getElementPosition(localPlayer)
	if isElement(icons[id]) then destroyElement(icons[id]) end
	icons[id] = createPickup ( x,y,z-0.5, 3, 1277, 0)
	setElementData(icons[id],"inventoryID",id)
	setElementDimension(icons[id],getElementDimension(localPlayer))
	setElementInterior(icons[id],getElementInterior(localPlayer))
	for k,v in ipairs(houseData) do
		HOLYFUCK = v[1]
	end
end)

addEventHandler("onClientPickupHit", root,
	function ( thePlayer, matchingDimension )
	if ( getElementModel( source ) == 1277 ) then
		if getElementType(thePlayer) == "player" then
			if ( matchingDimension ) and ( thePlayer == localPlayer ) then
				if getElementData(source,"inventoryID") then
					if isCursorShowing() then
						exports.NGCdxmsg("Please close any panel before you use this system",255,0,0)
						return false
					else
						local can,domsg = exports.NGCmanagement:isPlayerLagging()
						if can then
							if decor == true or editorStart == true then
								exports.NGCdxmsg:createNewDxMessage("Please quit editor before you hit this again",255,0,0)
							else
								openInventory()
							end
						else
							exports.NGCdxmsg:createNewDxMessage(domsg,255,0,0)
						end
					end
				end
			end
		end
	end
end)


function setDecoratePanelVisible(state)
	if state == true then
		guiSetVisible(HousingDec.window[1],true)
		showCursor(true)
		loadGridlist()
	else
		guiSetVisible(HousingDec.window[1],false)
		showCursor(false)
		quitEditor()
	end
end

function loadGridlist()
	guiGridListClear(HousingDec.gridlist[1])
	for k,v in ipairs(inv) do
		local row = guiGridListAddRow(HousingDec.gridlist[1])
		guiGridListSetItemText(HousingDec.gridlist[1], row, 1, v[1], false, true)
		guiGridListSetItemText(HousingDec.gridlist[1], row, 2, v[2], false, false)
	end
	guiGridListClear(HousingDec.gridlist[2])
	for k,v in ipairs(HD) do
		if v and isElement(v) then
			local ID = getElementModel(v)
			local name = IDname[getElementModel(v)]
			local row = guiGridListAddRow(HousingDec.gridlist[2])
			guiGridListSetItemText(HousingDec.gridlist[2], row, 1, name, false, true)
			guiGridListSetItemText(HousingDec.gridlist[2], row, 2, ID, false, false)
			guiGridListSetItemData(HousingDec.gridlist[2], row, 1, v)
		end
	end
end

function quitEX()
	removeEventHandler("onClientRender",root,drawingInfo)
	removeEventHandler("onClientClick",root,clickDetect)
	removeBinds()
	removeBinds2()
	decor = false
	editorStart = false
end
function quitEditor()
	removeEventHandler("onClientRender",root,drawingInfo)
	removeEventHandler("onClientClick",root,clickDetect)
	removeBinds()
	removeBinds2()
	decor = false
	editorStart = false
	guiSetVisible(HousingDec.window[1],false)
	showCursor(false)
end

function addBinds()
	bindKey("x","down",toggleInv)
	bindKey("m","down",toggleCursor)
	bindKey("space","down",placeObject)
	bindKey("num_0","down",delete)
	bindKey("num_2","down",positiondown)
	bindKey("num_8","down",positionup)
	bindKey("num_4","down",rotationleft)
	bindKey("num_6","down",rotationright)
	bindKey("num_7","down",positionx)
	bindKey("num_9","down",positionx2)
	bindKey("num_1","down",positiony)
	bindKey("num_3","down",positiony2)
end

function removeBinds()
	unbindKey("num_4","down",rotationleft)
	unbindKey("num_6","down",rotationright)
	unbindKey("num_7","down",positionx)
	unbindKey("num_9","down",positionx2)
	unbindKey("num_1","down",positiony)
	unbindKey("num_3","down",positiony2)
end

function removeBinds2()
	unbindKey("x","down",toggleInv)
	unbindKey("m","down",toggleCursor)
	unbindKey("space","down",placeObject)
	unbindKey("num_0","down",delete)
	unbindKey("num_2","down",positiondown)
	unbindKey("num_8","down",positionup)
end

addEvent("closeHousingDecor",true)
addEventHandler("closeHousingDecor",root,function()
	if source == localPlayer then
		delete()
		quitEditor()
	end
end)

addEvent("onPlayerLeaveHouse",true)
addEventHandler("onPlayerLeaveHouse",root,function(id)
	if isElement(icons[id]) then destroyElement(icons[id]) end
	for k,v in ipairs(HD) do
		if v and isElement(v) then
			destroyElement(v)
		end
	end
end)

addEvent("updateClientHouse",true)
addEventHandler("updateClientHouse",root,function(id)
	if isElement(icons[id]) then destroyElement(icons[id]) end
end)

addEvent("updateClientDecor",true)
function updateHousingDecor(player,tableDataInv)
	--[[HD = {}
	local myTable = fromJSON(tableDataInv)
	if myTable and myTable ~= nil then
		for i=1,#myTable do
			local id,name,x,y,z,rot = myTable[i][1],myTable[i][2],myTable[i][3],myTable[i][4],myTable[i][5],myTable[i][6]
			if id then
				latestObjects[i] = createObject(id,x,y,z,0,0,rot)
				setElementData(latestObjects[i],"housingItem",true)
				setElementDimension(latestObjects[i],getElementDimension(localPlayer))
				setElementInterior(latestObjects[i],getElementInterior(localPlayer))
				table.insert(HD,latestObjects[i])
				loadGridlist()
			end
		end
	end]]
end
addEventHandler("updateClientDecor",root,updateHousingDecor)


function saveDecor()
	sql = {}
	for k,v in ipairs(HD) do
		if v and isElement(v) then
			local x,y,z = getElementPosition(v)
			local r1,r2,r3 = getElementRotation(v)
			local id = getElementModel(v)
			local name = IDname[id]
			local t = {id,name,x,y,z,r3}
			table.insert(sql,t)
			destroyElement(v)
		end
	end
	local myData = toJSON(sql)
	triggerServerEvent("saveHousingDecor",localPlayer,localPlayer,myData)
	HD = {}
	quitEX()
end
