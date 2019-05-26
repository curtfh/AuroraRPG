local holdon = false
local bought = false
vehicle = {}
local tempTable = {}
local count = 1
local color = {}
local blips = {}
Viewer = {
    label = {},
    staticimage = {}
}
Viewer.staticimage[1] = guiCreateWindow(10, 173, 201, 286, "Aurora ~ Vehicle Viewer", false)
guiSetVisible(Viewer.staticimage[1],false)
guiWindowSetSizable(Viewer.staticimage[1], false)
---Viewer.staticimage[2] = guiCreateStaticImage(8, 15, 185, 40, "images/Face.png", false, Viewer.staticimage[1])
Viewer.label[1] = guiCreateLabel(13, 61, 77, 21, "Vehicle name:", false, Viewer.staticimage[1])
guiSetFont(Viewer.label[1], "default-bold-small")
Viewer.label[2] = guiCreateLabel(106, 61, 77, 21, "GTA", false, Viewer.staticimage[1])
guiSetFont(Viewer.label[2], "default-bold-small")
Viewer.label[3] = guiCreateLabel(13, 92, 77, 21, "Vehicle Cost:", false, Viewer.staticimage[1])
guiSetFont(Viewer.label[3], "default-bold-small")
Viewer.label[4] = guiCreateLabel(106, 92, 77, 21, "$0", false, Viewer.staticimage[1])
guiSetFont(Viewer.label[4], "default-bold-small")
--Viewer.label[5] = guiCreateLabel(13, 120, 170, 32, "Remember our vehicles\nAre the best!", false, Viewer.staticimage[1])
--guiSetFont(Viewer.label[5], "default-bold-small")
--guiLabelSetHorizontalAlign(Viewer.label[5], "center", true)
Viewer.staticimage[3] = guiCreateStaticImage(20, 234, 34, 33, "images/Back.png", false, Viewer.staticimage[1])
Viewer.staticimage[4] = guiCreateStaticImage(147, 232, 30, 35, "images/Go.png", false, Viewer.staticimage[1])
Viewer.staticimage[5] = guiCreateStaticImage(78, 234, 45, 33, "images/button.png", false, Viewer.staticimage[1])
Viewer.staticimage[6] = guiCreateStaticImage(78, 184, 45, 18, "images/button.png", false, Viewer.staticimage[1])
Viewer.label[6] = guiCreateLabel(25, 210, 54, 22, "Back", false, Viewer.staticimage[1])
guiSetFont(Viewer.label[6], "default-bold-small")
Viewer.label[7] = guiCreateLabel(74, 210, 54, 22, "Return", false, Viewer.staticimage[1])
guiSetFont(Viewer.label[7], "default-bold-small")
guiLabelSetHorizontalAlign(Viewer.label[7], "center", false)
Viewer.label[8] = guiCreateLabel(133, 210, 54, 22, "Forward", false, Viewer.staticimage[1])
guiSetFont(Viewer.label[8], "default-bold-small")
Viewer.label[9] = guiCreateLabel(74, 165, 54, 22, "Color", false, Viewer.staticimage[1])
guiSetFont(Viewer.label[9], "default-bold-small")
guiLabelSetHorizontalAlign(Viewer.label[8], "center", false)
guiLabelSetHorizontalAlign(Viewer.label[9], "center", false)

addEventHandler("onClientMouseEnter",root,function()
	if source == Viewer.staticimage[6] or source == Viewer.staticimage[4] or source == Viewer.staticimage[5] or source == Viewer.staticimage[3] then
		guiSetAlpha(source,0.50)
	end
end)
addEventHandler("onClientMouseLeave",root,function()
	if source == Viewer.staticimage[6] or source == Viewer.staticimage[4] or source == Viewer.staticimage[5] or source == Viewer.staticimage[3] then
		guiSetAlpha(source,1)
	end
end)

Window = {
    tab = {},
    tabpanel = {},
    radiobutton = {},
    button = {},
    window = {},
    gridlist = {},
    label = {},
    edit = {}
}
Window.window[1] = guiCreateWindow(53, 93, 692, 451, "Aurora ~ Vehicles Shop", false)
guiWindowSetSizable(Window.window[1], false)
guiSetVisible(Window.window[1],false)
Window.tabpanel[1] = guiCreateTabPanel(9, 20, 673, 421, false, Window.window[1])

Window.tab[1] = guiCreateTab("Buy vehicle", Window.tabpanel[1])

Window.gridlist[1] = guiCreateGridList(299, 6, 368, 381, false, Window.tab[1])
guiGridListAddColumn(Window.gridlist[1], "ID", 0.3)
col=guiGridListAddColumn(Window.gridlist[1], "Model", 0.3)
guiGridListAddColumn(Window.gridlist[1], "Cost", 0.3)
Window.label[1] = guiCreateLabel(17, 6, 256, 38, "Vehicles Types", false, Window.tab[1])
guiSetFont(Window.label[1],myFont)
guiLabelSetColor(Window.label[1], 250, 250, 250)
guiLabelSetHorizontalAlign(Window.label[1], "center", false)
Window.button[1] = guiCreateButton(17, 323, 113, 27, "View", false, Window.tab[1])
guiSetProperty(Window.button[1], "NormalTextColour", "FFAAAAAA")
Window.button[2] = guiCreateButton(170, 323, 115, 27, "Buy", false, Window.tab[1])
guiSetProperty(Window.button[2], "NormalTextColour", "FFAAAAAA")
Window.button[3] = guiCreateButton(75, 360, 141, 27, "Close", false, Window.tab[1])
guiSetProperty(Window.button[3], "NormalTextColour", "FFAAAAAA")
Window.radiobutton[1] = guiCreateRadioButton(17, 50, 80, 25, "Sports", false, Window.tab[1])
guiSetFont(Window.radiobutton[1],"default-bold-small")
guiRadioButtonSetSelected(Window.radiobutton[1], true)
Window.radiobutton[2] = guiCreateRadioButton(104, 50, 80, 25, "Muscle", false, Window.tab[1])
guiSetFont(Window.radiobutton[2], "default-bold-small")
Window.radiobutton[3] = guiCreateRadioButton(193, 50, 80, 25, "Luxury", false, Window.tab[1])
guiSetFont(Window.radiobutton[3], "default-bold-small")
Window.radiobutton[4] = guiCreateRadioButton(17, 85, 80, 25, "Compact", false, Window.tab[1])
guiSetFont(Window.radiobutton[4], "default-bold-small")
Window.radiobutton[5] = guiCreateRadioButton(104, 85, 80, 25, "Lowriders", false, Window.tab[1])
guiSetFont(Window.radiobutton[5], "default-bold-small")
Window.radiobutton[6] = guiCreateRadioButton(193, 85, 180, 25, "Light Trucks", false, Window.tab[1])
guiSetFont(Window.radiobutton[6], "default-bold-small")
Window.radiobutton[7] = guiCreateRadioButton(194, 120, 109, 25, "Heavy Trucks", false, Window.tab[1])
guiSetFont(Window.radiobutton[7], "default-bold-small")
Window.radiobutton[8] = guiCreateRadioButton(17, 120, 80, 25, "Bikes", false, Window.tab[1])
guiSetFont(Window.radiobutton[8], "default-bold-small")
Window.radiobutton[9] = guiCreateRadioButton(103, 120, 180, 25, "Police Vehicles", false, Window.tab[1])
guiSetFont(Window.radiobutton[9], "default-bold-small")
Window.radiobutton[10] = guiCreateRadioButton(17, 145, 180, 25, "Plane & Helicopter", false, Window.tab[1])
guiSetFont(Window.radiobutton[10], "default-bold-small")
Window.radiobutton[11] = guiCreateRadioButton(194, 150, 80, 25, "Boats", false, Window.tab[1])
guiSetFont(Window.radiobutton[11], "default-bold-small")
Window.label[2] = guiCreateLabel(17, 145, 256, 15, "--------------------------------------------------------------------------------------------------------------", false, Window.tab[1])
guiSetFont(Window.label[2], "default-bold-small")
guiLabelSetHorizontalAlign(Window.label[2], "center", false)
Window.label[7] = guiCreateLabel(27, 203, 90, 21, "Selling for: ", false, Window.tab[1])
Window.label[3] = guiCreateLabel(120, 203, 163, 21, "$0", false, Window.tab[1])
guiSetFont(Window.label[3], myFont4)
guiLabelSetColor(Window.label[3], 0, 255, 0)
guiSetFont(Window.label[7], "default-bold-small")
Window.label[4] = guiCreateLabel(18, 175, 256, 23, "Pick a vehicle from the list", false, Window.tab[1])
guiSetFont(Window.label[4], "default-bold-small")
guiLabelSetColor(Window.label[4], 221, 0, 0)
guiLabelSetHorizontalAlign(Window.label[4], "center", false)
Window.label[5] = guiCreateLabel(27, 230, 106, 30, "License plate:", false, Window.tab[1])
guiSetFont(Window.label[5], "default-bold-small")
guiLabelSetVerticalAlign(Window.label[5], "center")
Window.edit[1] = guiCreateEdit(170, 234, 117, 26, "", false, Window.tab[1])
Window.label[6] = guiCreateLabel(27, 278, 106, 30, "Choose Color:", false, Window.tab[1])
guiSetFont(Window.label[6], "default-bold-small")
guiLabelSetVerticalAlign(Window.label[6], "center")
Window.button[4] = guiCreateButton(170, 281, 115, 27, "Pick color", false, Window.tab[1])
guiSetFont(Window.button[1], "default-bold-small")
guiSetFont(Window.button[2], "default-bold-small")
guiSetFont(Window.button[3], "default-bold-small")
guiSetFont(Window.button[4], "default-bold-small")
guiSetFont(Window.gridlist[1],"default-bold-small")

--cars:1,5 Light vehicle (SUV)6 Truck 7 Bike 8 Police 9 Plane 10, Boat 11
addEventHandler ( "onClientResourceStart", resourceRoot,function()
	garage = {
		createObject(11388, -2048.216796875, 166.73092651367, 34.468391418457, 0.000000, 0.000000, 0.000000), --
		createObject(11389, -2048.1174316406, 166.71966552734, 30.975694656372, 0.000000, 0.000000, 0.000000), --
		createObject(11390, -2048.1791992188, 166.76277160645, 32.235980987549, 0.000000, 0.000000, 0.000000), --
		createObject(11391, -2056.2062988281, 158.56985473633, 29.087089538574, 0.000000, 0.000000, 0.000000), --
		createObject(11392, -2047.8289794922, 167.54446411133, 27.835615158081, 0.000000, 0.000000, 0.000000), --
		createObject(11393, -2043.5166015625, 161.337890625, 29.320350646973, 0.000000, 0.000000, 0.000000), --
		createObject(2893, -2050.9521484375, 171.15930175781, 29.11247253418, 7.9400024414063, 0.000000, 89.450988769531), --
		createObject(2893, -2050.9458007813, 169.32849121094, 29.112930297852, 7.9376220703125, 0.000000, 89.45068359375), --
	}
	for index, object in ipairs ( garage ) do
		setElementInterior(object,1)
	end
	for index, object in ipairs ( Objects ) do
		setElementDoubleSided ( object, true )
	end
	for k,v in ipairs(markers) do
		local name,x,y,z = v[1],v[2],v[3],v[4]
		local marker = createMarker(x,y,z,"cylinder",1.5,255,150,0)
		setElementData(marker,"table",{name,x,y,z,v.pos,v.cam,v.int,v.spawn})
		addEventHandler("onClientMarkerHit",marker,openMarket)
		addEventHandler("onClientMarkerLeave",marker,closeMarket)
		if name == "Car" then
			blip = exports.customblips:createCustomBlip( x,y,18,18,"images/car.png",500 )
			table.insert(blips,blip)
		elseif name == "Police" then
			blip = exports.customblips:createCustomBlip( x,y,25,25,"images/police.png",500 )
			table.insert(blips,blip)
		elseif name == "Truck" then
			blip = exports.customblips:createCustomBlip( x,y,18,18,"images/truck.png",500 )
			table.insert(blips,blip)
		elseif name == "Plane" then
			blip = exports.customblips:createCustomBlip( x,y,18,18,"images/plane.png",500 )
			table.insert(blips,blip)
		elseif name == "Boat" then
			blip = exports.customblips:createCustomBlip( x,y,20,20,"images/boat.png",500 )
			table.insert(blips,blip)
		elseif name == "Bike" then
			blip = exports.customblips:createCustomBlip( x,y,20,20,"images/bike.png",500 )
			table.insert(blips,blip)
		end
	end
	local col = engineLoadCOL ( "data/hubprops6_SFSe.col" )
	engineReplaceCOL ( col, 11391 )
	local col = engineLoadCOL ( "data/hubprops1_SFS.col")
	engineReplaceCOL ( col, 11393 )
	local txd = engineLoadTXD ( "data/oldgarage_sfse.txd")
	engineImportTXD ( txd, 11387 )
end)

function removeNoobLetter(element)
	if string.len( tostring( guiGetText(element) ) ) > 6 then
		guiSetText(element,"AUR")
		exports.NGCdxmsg:createNewDxMessage("Plate name 6 chars max",255,0,0)
	end
end
addEventHandler("onClientGUIChanged",Window.edit[1],removeNoobLetter)

function openMarket(hitElement,dim)
	if dim then
		if hitElement and getElementType(hitElement) == "player" then
			if hitElement ~= localPlayer then return false end
			local px,py,pz = getElementPosition ( hitElement )
			local mx, my, mz = getElementPosition ( source )
			if ( hitElement == localPlayer ) and ( pz-1.5 < mz ) and ( pz+1.5 > mz ) then
				if not isPedInVehicle(hitElement) then
					if holdon ~= true then
						local myTable = getElementData(source,"table")
						if myTable then
							local shopname = unpack(myTable)
							setElementData(localPlayer,"table",myTable)
							updateMyList(shopname)
							holdon = true
							setElementFrozen(localPlayer,true)
						else
							exports.NGCdxmsg:createNewDxMessage("Please try again",255,0,0)
						end
					end
				end
			end
		end
	end
end

function closeMarket(hitElement,dim)
	if dim then
		if hitElement and getElementType(hitElement) == "player" then
			if hitElement ~= localPlayer then return false end
			if holdon == true and bought ~= true and guiGetVisible(Window.window[1]) then
				closeShop(hitElement,source)
			end
		end
	end
end

function closeShop(plr,d)
	local p = plr or localPlayer
	if bought == true then
		return
	else
		local myTable = getElementData(d,"table")
		if myTable then
			if d and isElement(d) then
				local name,x,y,z,pos,cam = unpack(myTable)
				if x and y and z then
					stopCamera()
					setElementPosition(p,x,y,z+1)
					closePanel()
				else
					stopCamera()
					local x,y,z = getElementPosition(myTable)
					setElementPosition(p,x,y,z+1)
					closePanel()
				end
			end
		else
			if d and isElement(d) then
				if holdon == true then
					stopCamera()
					local x,y,z = getElementPosition(myTable)
					setElementPosition(p,x,y,z+1)
					closePanel()
				end
			end
		end
	end
end

function closePanel()
	--fadeCamera(false,0, 0, 0, 0)
	--setTimer(fadeCamera,2000,1,true,0.5)
	guiSetVisible(Window.window[1],false)
	showCursor(false)
	setElementFrozen(localPlayer,false)
	if isTimer(x) then return false end
	x = setTimer(function()
		holdon = false
	end,2000,1)
end

function stopCamera()
	setCameraInterior(0)
	setCameraTarget(localPlayer)
end

function disable(p)
	guiSetVisible(p,false)
	guiSetEnabled(p,false)
end
function enable(p)
	guiSetVisible(p,true)
	guiSetEnabled(p,true)
end
--cars:1,5 Light vehicle (SUV)6 Truck 7 Bike 8 Police 9 Plane 10, Boat 11
function updateMyList(shop)
	if shop == "Car" then
		for i=1,11 do
			if i <= 5 then
				enable(Window.radiobutton[i])
			else
				disable(Window.radiobutton[i])
			end
		end
		guiRadioButtonSetSelected(Window.radiobutton[1], true)
		if guiRadioButtonGetSelected(Window.radiobutton[1]) then
			fillGridList("Sports")
		end
	elseif shop == "Bike" then
		for i=1,11 do
			if i == 8 then
				enable(Window.radiobutton[i])
			else
				disable(Window.radiobutton[i])
			end
		end
		guiSetPosition(Window.radiobutton[8],17,50,false)
		guiRadioButtonSetSelected(Window.radiobutton[8], true)
		if guiRadioButtonGetSelected(Window.radiobutton[8]) then
			fillGridList("Bike")
		end
	elseif shop == "Truck" then
		for i=1,11 do
			if i == 6 or i == 7 then
				enable(Window.radiobutton[i])
			else
				disable(Window.radiobutton[i])
			end
		end
		guiSetPosition(Window.radiobutton[6],17,50,false)
		guiSetPosition(Window.radiobutton[7],173,50,false)
		guiRadioButtonSetSelected(Window.radiobutton[6], true)
		if guiRadioButtonGetSelected(Window.radiobutton[6]) then
			fillGridList("Light vehicle (SUV)")
		end
	elseif shop == "Plane" then
		for i=1,11 do
			if i == 10 then
				enable(Window.radiobutton[i])
			else
				disable(Window.radiobutton[i])
			end
		end
		guiSetPosition(Window.radiobutton[10],17,50,false)
		guiRadioButtonSetSelected(Window.radiobutton[10], true)
		if guiRadioButtonGetSelected(Window.radiobutton[10]) then
			fillGridList("Plane & Helicopter")
		end
	elseif shop == "Police" then
		for i=1,11 do
			if i == 9 then
				enable(Window.radiobutton[i])
			else
				disable(Window.radiobutton[i])
			end
		end
		guiSetPosition(Window.radiobutton[9],17,50,false)
		guiRadioButtonSetSelected(Window.radiobutton[9], true)
		if guiRadioButtonGetSelected(Window.radiobutton[9]) then
			fillGridList("Police")
		end
	elseif shop == "Boat" then
		for i=1,11 do
			if i == 11 then
				enable(Window.radiobutton[i])
			else
				disable(Window.radiobutton[i])
			end
		end
		guiSetPosition(Window.radiobutton[11],17,50,false)
		guiRadioButtonSetSelected(Window.radiobutton[11], true)
		if guiRadioButtonGetSelected(Window.radiobutton[11]) then
			fillGridList("Boat")
		end
	end
	guiSetVisible(Window.window[1],true)
	showCursor(true)
	exports.NGCdxmsg:createNewDxMessage(exports.AURlanguage:getTranslate("You can test vehicles by double pressing the list.", true),255,0,0)
end

function fillGridList(carType)
	guiGridListClear(Window.gridlist[1])
	guiGridListSetSortingEnabled ( Window.gridlist[1], false)
	local vehicleTable = getVehiclesTable()
	local theTable = vehicleTable[carType]
	tempTable = theTable
	for i=1,#theTable do
		local name = ""
		if (theTable[i][1] == 495) then 
			name = "Armored Truck"
		else
			name = getVehicleNameFromModel(theTable[i][1])
		end 
		local row = guiGridListAddRow(Window.gridlist[1])
		guiGridListSetItemText ( Window.gridlist[1], row, 1, theTable[i][1], false, false )
		guiGridListSetItemText ( Window.gridlist[1], row, 2, name, false, false )
		guiGridListSetItemText ( Window.gridlist[1], row, 3, "$"..exports.server:convertNumber(theTable[i][2]), false, false )
		guiGridListSetItemData ( Window.gridlist[1], row, 1, theTable[i][1])
		guiGridListSetItemData ( Window.gridlist[1], row, 2, name)
		guiGridListSetItemData ( Window.gridlist[1], row, 3, theTable[i][2])
	end
end

function err(msg)
	exports.NGCdxmsg:createNewDxMessage(msg,255,0,0)
end


function getSellPrice(buyPrice)
	if getResourceFromName("CSGplayervehicles") and getResourceDynamicElementRoot(getResourceFromName("CSGplayervehicles")) then
		return exports.CSGplayervehicles:getVehicleSellPrice(buyPrice,localPlayer)
	else
		return ( buyPrice - buyPrice / 100 * 10 )
	end
end

antispam = {}

addEventHandler("onClientGUIDoubleClick", Window.gridlist[1], function()
	local row,_ = guiGridListGetSelectedItem(Window.gridlist[1])
		if row and row ~= -1 then
			local ID = guiGridListGetItemData(Window.gridlist[1], row,1)
			if (ID ~= 495) then 
				triggerServerEvent("AURvehicleshop.testVeh", resourceRoot, localPlayer, ID)
			end
			
		end
end)


addEventHandler("onClientGUIClick",root,function()
	if source == Window.button[3] then
		closePanel()
	elseif source == Window.gridlist[1] then
		local row,_ = guiGridListGetSelectedItem(Window.gridlist[1])
		if row and row ~= -1 then
			local ID = guiGridListGetItemData(Window.gridlist[1], row,1)
			local vehicleName = guiGridListGetItemData(Window.gridlist[1], row,2)
			local vehiclePrice = guiGridListGetItemData(Window.gridlist[1], row,3)
			local sellPrice = getSellPrice(vehiclePrice)
			guiSetText(Window.label[3],"$"..exports.server:convertNumber(sellPrice))
		else
			guiSetText(Window.label[3],"$0")
		end
	elseif source == Viewer.staticimage[3] then
		local myTable = getElementData(localPlayer,"table")
		if myTable then
			local name,x,y,z,pos,cam,int = unpack(myTable)
			if name then
				local vx,vy,vz,vr = unpack(pos)
				if vx and vy then
					if vehicle and isElement(vehicle) then destroyElement(vehicle) end
					count = count - 1
					if count < 1 then count = #tempTable end
					local ID = tempTable[count][1]
					if ID then
						local name = ""
						if (theTabletempTable[count][1] == 495) then 
							name = "Armored Truck"
						else
							name = getVehicleNameFromModel(tempTable[count][1])
						end 
						local vehcost = tempTable[count][2]
						if name then
							vehicle = createVehicle(tonumber(ID),0,0,9000)
							setElementPosition(vehicle,vx,vy,vz)
							guiSetText(Viewer.label[2],name)
							guiSetText(Viewer.label[4],vehcost)
							setElementRotation(vehicle,0,0,vr)
							setElementInterior(vehicle,int)
						else
							err("Shop table not found , please try again later")
						end
					else
						err("Shop table not found , please try again later")
					end
				else
					err("Shop table not found , please try again later")
				end
			else
				err("Shop table not found , please try again later")
			end
		else
			err("Shop table not found , please try again later")
		end
	elseif source == Viewer.staticimage[4] then
		local myTable = getElementData(localPlayer,"table")
		if myTable then
			local name,x,y,z,pos,cam,int = unpack(myTable)
			if name then
				local vx,vy,vz,vr = unpack(pos)
				if vx and vy then
					if vehicle and isElement(vehicle) then destroyElement(vehicle) end
					count = count + 1
					if count > #tempTable then count = 1 end
					local ID = tempTable[count][1]
					if ID then
						local name = ""
						if (theTabletempTable[count][1] == 495) then 
							name = "Armored Truck"
						else
							name = getVehicleNameFromModel(tempTable[count][1])
						end 
						local vehcost = tempTable[count][2]
						if name then
							vehicle = createVehicle(tonumber(ID),0,0,9000)
							setElementPosition(vehicle,vx,vy,vz)
							guiSetText(Viewer.label[2],name)
							guiSetText(Viewer.label[4],vehcost)
							setElementRotation(vehicle,0,0,vr)
							setElementInterior(vehicle,int)
						else
							err("Shop table not found , please try again later")
						end
					else
						err("Shop table not found , please try again later")
					end
				else
					err("Shop table not found , please try again later")
				end
			else
				err("Shop table not found , please try again later")
			end
		else
			err("Shop table not found , please try again later")
		end
	elseif source == Viewer.staticimage[5] then
		if vehicle and isElement(vehicle) then destroyElement(vehicle) end
		stopCamera()
		guiSetVisible(Viewer.staticimage[1],false)
		guiSetVisible(Window.window[1],true)
	elseif source == Viewer.staticimage[6] then
		if cpicker ~= true then
			cpicker = true
			openColorPicker()
		end
	elseif source == Window.button[4] then
		if cpicker ~= true then
			cpicker = true
			openColorPicker()
		end
	elseif source == Window.button[2] then
		local row,_ = guiGridListGetSelectedItem(Window.gridlist[1])
		if row and row ~= -1 then
			local ID = guiGridListGetItemData(Window.gridlist[1], row,1)
			local vehicleName = guiGridListGetItemData(Window.gridlist[1], row,2)
			local vehiclePrice = guiGridListGetItemData(Window.gridlist[1], row,3)
			local plate = guiGetText(Window.edit[1])
			local myTable = getElementData(localPlayer,"table")
			if ID and vehicleName then
				if myTable then
					local name,x,y,z,pos,cam,int,spawn = unpack(myTable)
					if name then
						local x1,y1,z1,rot1,x2,y2,z2,rot2 = unpack(spawn)
						local red,green,blue,red2,green2,blue2 = r1,g1,b1,r2,g2,b2
						if x1 and y1 then
							if not red then
								red,green,blue,red2,green2,blue2 = 255,255,255,255,255,255
							end
							if antispam[source] == true then
								exports.NGCdxmsg:createNewDxMessage("Please wait few seconds dont spam",255,0,0)
							return false end
							antispam[source] = true
							setTimer(function(t) antispam[t] = false end,10000,1,source)
							triggerServerEvent("onClientPlayerBuyCar",localPlayer,ID,vehiclePrice,plate,x1,y1,z1,rot1,red,green,blue,red2,green2,blue2)
						else
							exports.NGCdxmsg:createNewDxMessage("The Position to spawn not found",255,0,0)
						end
					else
						exports.NGCdxmsg:createNewDxMessage("Vehicle data from table not found",255,0,0)
					end
				else
					exports.NGCdxmsg:createNewDxMessage("Vehicle list table not found",255,0,0)
				end
			else
				exports.NGCdxmsg:createNewDxMessage("Error vehicle ID not found",255,0,0)
			end
		else
			guiSetText(Window.label[3],"$0")
			exports.NGCdxmsg:createNewDxMessage("Please select vehicle from the list",255,0,0)
		end
	elseif source == Window.button[1] then
		local row,_ = guiGridListGetSelectedItem(Window.gridlist[1])
		if row and row ~= -1 then
			local ID = guiGridListGetItemData(Window.gridlist[1], row,1)
			local vehicleName = guiGridListGetItemData(Window.gridlist[1], row,2)
			local vehiclePrice = guiGridListGetItemData(Window.gridlist[1], row,3)
			local myTable = getElementData(localPlayer,"table")
			if ID and vehicleName then
				if myTable then
					local name,x,y,z,pos,cam,int = unpack(myTable)
					if name then
						local vx,vy,vz,vr = unpack(pos)
						local cx,cy,cz,cx2,cy2,cz2 = unpack(cam)
						if vx and vy and cx and cy then
							if antispam[source] == true then return false end
							antispam[source] = true
							setTimer(function(t) antispam[t] = false end,5000,1,source)
							count = 1
							guiSetVisible(Viewer.staticimage[1],true)
							guiSetVisible(Window.window[1],false)
							setCameraInterior(int)
							setCameraMatrix(cx,cy,cz,cx2,cy2,cz2)
							if vehicle and isElement(vehicle) then destroyElement(vehicle) end
							vehicle = createVehicle(tonumber(ID),0,0,9000)
							setElementPosition(vehicle,vx,vy,vz)
							setElementRotation(vehicle,0,0,vr)
							setElementInterior(vehicle,int)
							guiSetText(Viewer.label[2],vehicleName)
							guiSetText(Viewer.label[4],vehiclePrice)
						end
					end
				end
			end
		else
			guiSetText(Window.label[3],"$0")
			exports.NGCdxmsg:createNewDxMessage("Please select vehicle from the list",255,0,0)
		end
	elseif source == Window.radiobutton[1] then
		if guiGetEnabled(Window.radiobutton[1]) then
			if guiRadioButtonGetSelected(Window.radiobutton[1]) then
				fillGridList("Sports")
			end
		end
	elseif source == Window.radiobutton[2] then
		if guiGetEnabled(Window.radiobutton[2]) then
			if guiRadioButtonGetSelected(Window.radiobutton[2]) then
				fillGridList("Muscle")
			end
		end
	elseif source == Window.radiobutton[3] then
		if guiGetEnabled(Window.radiobutton[3]) then
			if guiRadioButtonGetSelected(Window.radiobutton[3]) then
				fillGridList("Luxury")
			end
		end
	elseif source == Window.radiobutton[4] then
		if guiGetEnabled(Window.radiobutton[4]) then
			if guiRadioButtonGetSelected(Window.radiobutton[4]) then
				fillGridList("Compact")
			end
		end
	elseif source == Window.radiobutton[5] then
		if guiGetEnabled(Window.radiobutton[5]) then
			if guiRadioButtonGetSelected(Window.radiobutton[5]) then
				fillGridList("Lowriders")
			end
		end
	elseif source == Window.radiobutton[6] then
		if guiGetEnabled(Window.radiobutton[6]) then
			if guiRadioButtonGetSelected(Window.radiobutton[6]) then
				fillGridList("Light vehicle (SUV)")
			end
		end
	elseif source == Window.radiobutton[7] then
		if guiGetEnabled(Window.radiobutton[7]) then
			if guiRadioButtonGetSelected(Window.radiobutton[7]) then
				fillGridList("Heavy Trucks")
			end
		end
	elseif source == Window.radiobutton[8] then
		if guiGetEnabled(Window.radiobutton[8]) then
			if guiRadioButtonGetSelected(Window.radiobutton[8]) then
				fillGridList("Bike")
			end
		end
	elseif source == Window.radiobutton[9] then
		if guiGetEnabled(Window.radiobutton[9]) then
			if guiRadioButtonGetSelected(Window.radiobutton[9]) then
				fillGridList("Police")
			end
		end
	elseif source == Window.radiobutton[10] then
		if guiGetEnabled(Window.radiobutton[10]) then
			if guiRadioButtonGetSelected(Window.radiobutton[10]) then
				fillGridList("Plane & Helicopter")
			end
		end
	elseif source == Window.radiobutton[11] then
		if guiGetEnabled(Window.radiobutton[11]) then
			if guiRadioButtonGetSelected(Window.radiobutton[11]) then
				fillGridList("Boat")
			end
		end
	end
end)
dx = {}
function closeWindows()
	guiSetVisible(Viewer.staticimage[1],false)
	guiSetVisible(Window.window[1],false)
	showCursor(false)
	if isTimer(dx) then killTimer(dx) end
	dx = setTimer(function() holdon = false bought=false end,5000,1)
end

addEvent("onClientExitCarshop",true)
addEventHandler("onClientExitCarshop",root,function()
	bought = true
	if isTimer(dx) then killTimer(dx) end
	dx = setTimer(function() bought=false end,5000,1)
	closeShop(localPlayer,nil)
	closeWindows()
end)
