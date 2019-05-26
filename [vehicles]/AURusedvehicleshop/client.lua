local client = getLocalPlayer()
local rootElement = getRootElement()
local inShop = {}
local carLocation = {}
local clientX, clientY, clientZ = nil, nil, nil
local vehicleBLIP = false
local locatingEnabled = false
local currentColor = 1
local tempPos = {}
local rotation = 0
local spamBuy = false
local spamAdd = false
local viewerModel = true
local carElement = nil
local spams = {}

local usedVehicleShops = {
	{name="Used Car shop", x=2475.36,y=-1947.06, z=13.55394, size=2, camera={2488.24, -1957.39, 17.84,2489.03, -1941.67, 13.38, 0, 180}, car={ 2452.03,-1976.55,13.54,91 },market="Automobile",City="LS"},
	{name="Used Plane shop", x=1993.75,y=-2313.48,z=13.54,size=3, camera={2052.535, -2529.665, 31.829, 2045.756, -2437.324, -5.948, 0,0}, car={ 2061.72,-2486.29,13.54,273 },market="Plane",City="LS"},
	{name="Used Helicopter shop", x=1553.47,y=-1353.08,z=329.45,size=3, camera={1533.378, -1345.775, 351.927, 1577.318, -1348.295, 262.134, 0,0}, car={ 1543.95,-1353.54,329.47,80 },market="Helicopter",City="LS"},
	{name="Used Boat shop", x=2.59,y=-1578.1,z=-0.6,size=3, camera={-7.996, -1575.448, 11.665, -10.134, -1634.735, -68.836, 0,0}, car={ -12.29,-1585.01,-0.6,188 },market="Boat",City="LS"},
	{name="Used Monster truck shop", x=2408.92,y=-1242.23,z=23.81,size=3, camera={2412.75, -1241.333, 26.835, 2418.77, -1145.639, -1.562, 0,0}, car={ 2415.32,-1230.2,24.39,264 },market="Monster Truck",City="LS"},
	{name="Used Bike shop", x=990.45,y=-1524.91,z=13.55,size=2, camera={979.19,-1535.44,23.61,968.39,-1530.71,13.56, 0,0}, car={ 968.39,-1530.71,13.56,270 },market="Bike",City="LS"},
}

for k, v in ipairs(usedVehicleShops) do
	exports.customblips:createCustomBlip(v.x, v.y, 20, 20, v.market..".png")
end

local xide = {
{1,"Normal/camo"},
{2,"Normal/dragon"},
{3,"Normal/matrix"},
{4,"Normal/stripes"},
{5,"Normal/snip"},
{6,"Normal/snakes"},
{7,"Normal/wolf"},
{8,"Normal/Tiger"},
{10,"Sports/sultan1"},
{11,"Sports/sultan2"},
{12,"Sports/sultan3"},
{13,"Sports/uranus1"},
{14,"Sports/uranus2"},
{15,"Sports/uranus3"},
{16,"Sports/stratum1"},
{17,"Sports/stratum2"},
{18,"Sports/slamvan1"},
{19,"Sports/slamvan2"},
{20,"Sports/slamvan3"},
{21,"Sports/remington1"},
{22,"Sports/remington2"},
{23,"Sports/remington3"},
{24,"Sports/jester1"},
{25,"Sports/jester2"},
{26,"Sports/jester3"},
{27,"Sports/flash1"},
{28,"Sports/flash2"},
{29,"Sports/elegy1"},
{30,"Sports/elegy2"},
{31,"Sports/elegy3"},
}

local x, y = guiGetScreenSize()

local usedShopGUI = {}

usedShopGUI["window"] = {}
usedShopGUI["grid"] = {}
usedShopGUI["edit"] = {}
usedShopGUI["button"] = {}
usedShopGUI["label"] = {}

usedShopGUI["window"]["shop"] = guiCreateWindow((x / 2) - (750 / 2), (y / 2) - (580 / 2), 333, 573, "NGC ~ Buy used vehicles", false)
guiWindowSetSizable(usedShopGUI["window"]["shop"], false)
guiSetVisible(usedShopGUI["window"]["shop"],false)
text = guiCreateLabel(43, 23, 251, 18, "You can sell or buy used vehicles from here", false, usedShopGUI["window"]["shop"])
guiSetFont(text, "default-bold-small")
guiLabelSetColor(text, 199, 88, 7)
usedShopGUI["grid"]["shop"] = guiCreateGridList(13, 46, 308, 247, false, usedShopGUI["window"]["shop"])
guiGridListAddColumn(usedShopGUI["grid"]["shop"], "Vehicle ID:", 0.2)
guiGridListAddColumn(usedShopGUI["grid"]["shop"], "Vehicle owner:", 0.3)
guiGridListAddColumn(usedShopGUI["grid"]["shop"], "Vehicle name:", 0.3)
guiGridListAddColumn(usedShopGUI["grid"]["shop"], "Vehicle price:", 0.3)
guiGridListAddColumn(usedShopGUI["grid"]["shop"], "Bought Price:", 0.3)
guiGridListAddColumn(usedShopGUI["grid"]["shop"], "Vehicle Type", 0.3)
guiGridListAddColumn(usedShopGUI["grid"]["shop"], "Vehicle Health", 0.3)
guiGridListAddColumn(usedShopGUI["grid"]["shop"], "Vehicle paintjob", 0.3)
guiGridListAddColumn(usedShopGUI["grid"]["shop"], "Vehicle Nod", 0.3)
guiGridListAddColumn(usedShopGUI["grid"]["shop"], "Vehicle Info", 0.3)
usedShopGUI["button"]["shop_buy"] = guiCreateButton(83, 465, 161, 29, "Buy/Recover vehicle", false, usedShopGUI["window"]["shop"])
guiSetProperty(usedShopGUI["button"]["shop_buy"], "NormalTextColour", "FFAAAAAA")
usedShopGUI["button"]["shop_close"] = guiCreateButton(104, 510, 119, 29, "Close", false, usedShopGUI["window"]["shop"])
guiSetProperty(usedShopGUI["button"]["shop_close"], "NormalTextColour", "FFAAAAAA")
memo = guiCreateMemo(14, 300, 307, 155, "", false, usedShopGUI["window"]["shop"])
guiMemoSetReadOnly(memo, true)


usedShopGUI["window"]["add"] = guiCreateWindow((x / 2) - (480 / 2), (y / 2) - (480 / 2), 485, 462, "NGC ~ You're about to sell your car are you sure about this?", false)
guiWindowSetSizable(usedShopGUI["window"]["add"], false)
guiSetVisible(usedShopGUI["window"]["add"],false)
usedShopGUI["grid"]["add"] = guiCreateGridList(10, 29, 462, 191, false, usedShopGUI["window"]["add"])
guiGridListAddColumn(usedShopGUI["grid"]["add"], "Vehicle ID:", 0.3)
guiGridListAddColumn(usedShopGUI["grid"]["add"], "Vehicle name:", 0.3)
guiGridListAddColumn(usedShopGUI["grid"]["add"], "Vehicle Type:", 0.3)
guiGridListAddColumn(usedShopGUI["grid"]["add"], "Orginal Cost:", 0.3)
guiGridListAddColumn(usedShopGUI["grid"]["add"], "Selling Price:", 0.3)
guiGridListAddColumn(usedShopGUI["grid"]["add"], "Vehicle HP", 0.3)
guiGridListAddColumn(usedShopGUI["grid"]["add"], "Vehicle Nod", 0.3)
guiGridListAddColumn(usedShopGUI["grid"]["add"], "", 0.1)
usedShopGUI["button"]["add_it"] = guiCreateButton(293, 326, 161, 29, "Add it", false, usedShopGUI["window"]["add"])
guiSetProperty(usedShopGUI["button"]["add_it"], "NormalTextColour", "FFAAAAAA")
usedShopGUI["button"]["add_close"] = guiCreateButton(314, 370, 119, 29, "Cancel", false, usedShopGUI["window"]["add"])
guiSetProperty(usedShopGUI["button"]["add_close"], "NormalTextColour", "FFAAAAAA")
usedShopGUI["edit"]["edit"] = guiCreateEdit(314, 280, 119, 29, "0", false, usedShopGUI["window"]["add"])
usedShopGUI["label"]["price"] = guiCreateLabel(303, 238, 140, 28, "Set Price", false, usedShopGUI["window"]["add"])
guiSetFont(usedShopGUI["label"]["price"], "default-bold-small")
guiLabelSetHorizontalAlign(usedShopGUI["label"]["price"], "center", false)
guiLabelSetVerticalAlign(usedShopGUI["label"]["price"], "center")
addmemo = guiCreateMemo(10, 270, 273, 174, "", false, usedShopGUI["window"]["add"])
lbl = guiCreateLabel(71, 238, 140, 28, "Insert information", false, usedShopGUI["window"]["add"])
guiSetFont(lbl, "default-bold-small")
guiLabelSetHorizontalAlign(lbl, "center", false)
guiLabelSetVerticalAlign(lbl, "center")


function removeL(element)
	local txts2 = guiGetText(element)
	local removed = string.gsub(txts2, "[^0-9]", "")
	if (removed ~= txts2) then
		guiSetText(element, removed)
	end
end
addEventHandler( "onClientGUIChanged", usedShopGUI["edit"]["edit"], removeL)

local antiSpamTable = {}


addEvent("addUsedCarShop",true)
addEventHandler("addUsedCarShop",getRootElement(),function(car,vehID,vehicleid,uniqueid,color1,color2,vehiclehealth,paintjob,tune,boughtprice,fuckme,shopName)
	if isCursorShowing (localPlayer) then
		exports.NGCdxmsg:createNewDxMessage("You can't add this vehicle to shop while there is another panel open!",255,0,0)
		fadeCamera(true, 2)
		setCameraTarget(client)
		return
	end
	if getElementData ( localPlayer, "copArrestedCrim", true ) then
	exports.NGCdxmsg:createNewDxMessage("You should release criminals first",255,0,0)
	return false 
	end
	setElementData(localPlayer,"isPlayerInUsedShop",true)
	guiSetVisible(usedShopGUI["window"]["add"],true)
	guiGridListClear(usedShopGUI["grid"]["add"])
	veh = car
	if veh and isElement(veh) then
		showCursor(true)
		local row = guiGridListAddRow(usedShopGUI["grid"]["add"])
		guiGridListSetItemText(usedShopGUI["grid"]["add"],row,1,tostring(vehicleid),false,false)
		guiGridListSetItemText(usedShopGUI["grid"]["add"],row,2,tostring(getVehicleNameFromModel(vehicleid)),false,false)
		guiGridListSetItemText(usedShopGUI["grid"]["add"],row,3,tostring(getVehicleType(vehicleid)),false,false)
		guiGridListSetItemText(usedShopGUI["grid"]["add"],row,6,tostring(vehiclehealth),false,false)
		guiGridListSetItemText(usedShopGUI["grid"]["add"],row,7,"True",false,false)
		guiGridListSetItemText(usedShopGUI["grid"]["add"],row,4,tostring(boughtprice),false,false)
		guiGridListSetItemText(usedShopGUI["grid"]["add"],row,5,math.floor(fuckme),false,false)
		guiGridListSetItemData(usedShopGUI["grid"]["add"],row,5,math.floor(fuckme))
		guiGridListSetItemData(usedShopGUI["grid"]["add"],row,1,tostring(vehiclehealth))
		guiGridListSetItemData(usedShopGUI["grid"]["add"],row,2,tostring(uniqueid))
		guiGridListSetItemData(usedShopGUI["grid"]["add"],row,3,color1)
		guiGridListSetItemData(usedShopGUI["grid"]["add"],row,4,color2)
		function addVehicle()
			if source ~= usedShopGUI["button"]["add_it"] then return false end
			if veh then
				local upgrade = getVehicleUpgradesJSON(veh)
				local paintjob = getVehiclePaintjob(veh)
				local carID = tonumber(guiGridListGetItemText(usedShopGUI["grid"]["add"], row, 1))
				local vehhealth = tonumber(guiGridListGetItemData(usedShopGUI["grid"]["add"], row,1))
				local unID = tonumber(guiGridListGetItemData(usedShopGUI["grid"]["add"], row,2))
				local color1 = guiGridListGetItemData(usedShopGUI["grid"]["add"],row,4)
				local color2 = guiGridListGetItemData(usedShopGUI["grid"]["add"],row,4)
				local carPrice = tonumber(guiGridListGetItemData(usedShopGUI["grid"]["add"], row,5))
				local boughCost = tonumber(guiGridListGetItemText(usedShopGUI["grid"]["add"], row,4))
				if (not carPrice) then exports.NGCdxmsg:createNewDxMessage("Original price not found contact Prime.",255,0,0) return end
				local customPrice = guiGetText(usedShopGUI["edit"]["edit"])
				local customPrice = tonumber(customPrice)
				local allowedPrice = boughCost*1
				local text = "Vehicle Owner : "..getPlayerName(localPlayer).."\nVehicle Info: "..guiGetText(addmemo)
				if customPrice >= 25000 and customPrice <= allowedPrice then
					if isTimer(spams[source]) then exports.NGCdxmsg:createNewDxMessage("You are no longer allowed to click on this, please wait 5 seconds!",255,0,0) return false end
					spams[source] = setTimer(function() end,5000,1)
					local info = text
					triggerServerEvent("addUsedVehicle",client,client,carID,unID,carPrice,vehhealth,color1,color2,upgrade,paintjob,tune,customPrice,info)
					removeEventHandler("onClientGUIClick",usedShopGUI["button"]["add_it"],addVehicle)
				else
					exports.NGCdxmsg:createNewDxMessage("Min price $25000 & Max price $"..allowedPrice,255,0,0)
					return
				end
			else
				exports.NGCdxmsg:createNewDxMessage("Something went wrong , try again later",255,0,0)
			end
		end
		removeEventHandler("onClientGUIClick",usedShopGUI["button"]["add_it"],addVehicle)
		addEventHandler("onClientGUIClick",usedShopGUI["button"]["add_it"],addVehicle)
	end
end)

addEvent("returnAddShop",true)
addEventHandler("returnAddShop",root,function()
	addEventHandler("onClientGUIClick",usedShopGUI["button"]["add_it"],addVehicle)
end)


getVehicleUpgradesJSON = function(veh)
local upgrades = {}
local anyUpgrade = false
	for slot = 0, 16 do
		local upgrade = getVehicleUpgradeOnSlot(veh, slot)
		if upgrade then
			upgrades[slot] = upgrade
			anyUpgrade = true
		end
	end
	if anyUpgrade then
		return toJSON(upgrades)
	else
		return "NULL"
	end
end

setTimer(function()
	if getElementData(localPlayer,"isPlayerInUsedShop") then
		if getElementData(localPlayer,"wantedPoints") >= 10 then
			viewerModel = false
			setElementDimension(localPlayer,0)
		else
			viewerModel = true
		end
	end
end,1000,0)

addEvent("ShowUsedCarShop",true)
addEventHandler("ShowUsedCarShop",getRootElement(),
function (vehicles, shopName,shopType,myTable)
	if isCursorShowing (localPlayer) then
		exports.NGCdxmsg:createNewDxMessage("You can't view this shop while there is another panel open!",255,0,0)
		fadeCamera(true, 2)
		setCameraTarget(client)
		return
	end
	local m = getElementData(localPlayer,"markCam")
	if m then
		setCameraMatrix(unpack(m))
	end
	setElementData(localPlayer,"isPlayerInUsedShop",true)
	allAbout = myTable
	guiSetVisible(usedShopGUI["window"]["shop"], true)
	guiSetText(usedShopGUI["window"]["shop"], shopName)
	showCursor(true)
	setElementFrozen(client, true)
	guiGridListClear(usedShopGUI["grid"]["shop"])
	for index, vehicle in pairs(vehicles) do
		if vehicle.sale == 1 then
			if tostring(getVehicleType(vehicle.vehicleid)) == tostring(shopType) then
				if not vehicle.custom then vehicle.custom = 0 end
				local row = guiGridListAddRow(usedShopGUI["grid"]["shop"])
				guiGridListSetItemText(usedShopGUI["grid"]["shop"], row, 1, tostring(vehicle.vehicleid), false, false)
				guiGridListSetItemText(usedShopGUI["grid"]["shop"], row, 2, "NGC Sales", false, false)
				guiGridListSetItemText(usedShopGUI["grid"]["shop"], row, 3, tostring(getVehicleNameFromModel(vehicle.vehicleid)), false, false)
				guiGridListSetItemText(usedShopGUI["grid"]["shop"], row, 4,  math.floor(vehicle.customPrice),false,false)

				guiGridListSetItemText(usedShopGUI["grid"]["shop"], row, 5, vehicle.boughtprice, false, false)
				guiGridListSetItemText(usedShopGUI["grid"]["shop"], row, 6, tostring(getVehicleType(vehicle.vehicleid)), false, false)
				guiGridListSetItemText(usedShopGUI["grid"]["shop"], row, 7, tostring((vehicle.vehiclehealth)), false, false)
				guiGridListSetItemText(usedShopGUI["grid"]["shop"], row, 9, "True", false, false)
				guiGridListSetItemData(usedShopGUI["grid"]["shop"], row, 7, 0)
				if vehicle.custom and tonumber(vehicle.custom) and tonumber(vehicle.custom) > 0 then
					guiGridListSetItemText(usedShopGUI["grid"]["shop"], row, 8,"Custom color", false, false)
					guiGridListSetItemData(usedShopGUI["grid"]["shop"], row, 7, vehicle.custom)
				else
					guiGridListSetItemText(usedShopGUI["grid"]["shop"], row, 8,"Simple Color", false, false)
					guiGridListSetItemData(usedShopGUI["grid"]["shop"], row, 7, 3)
					if vehicle.paintjob and vehicle.paintjob < 3 then
						guiGridListSetItemData(usedShopGUI["grid"]["shop"], row, 7, vehicle.paintjob)
					else
						guiGridListSetItemData(usedShopGUI["grid"]["shop"], row, 7, 3)
					end
				end
				if vehicle.sinfo then
					guiGridListSetItemText(usedShopGUI["grid"]["shop"], row, 9,"True", false, false)
				else
					guiGridListSetItemText(usedShopGUI["grid"]["shop"], row, 9,"False", false, false)
				end
				guiGridListSetItemData(usedShopGUI["grid"]["shop"], row, 1, tostring(vehicle.uniqueid))
				guiGridListSetItemData(usedShopGUI["grid"]["shop"], row, 2, tostring(vehicle.ownerid))
				guiGridListSetItemData(usedShopGUI["grid"]["shop"], row, 3, tostring(vehicle.vehiclehealth))
				guiGridListSetItemData(usedShopGUI["grid"]["shop"], row, 4, vehicle.color1)
				guiGridListSetItemData(usedShopGUI["grid"]["shop"], row, 5, vehicle.color2)
				guiGridListSetItemData(usedShopGUI["grid"]["shop"], row, 6, vehicle.vehiclemods)
				guiGridListSetItemData(usedShopGUI["grid"]["shop"], row, 8, vehicle.tune)
				guiGridListSetItemData(usedShopGUI["grid"]["shop"], row, 9, vehicle.sinfo)
			end
		end
	end
end)
   function HexadecimalToColor(x)
 	if type(x) == 'number' then
 		x = string.format('%x+', x):upper()
 	end
 	x = x:match'%x+':upper()
 	if x:len() ~= 6 then
 		return error('Invalid hexadecimal color code: ' .. x)
 	end
 	return {
 		r = loadstring('return 0x'..x:sub(1,2))();
 		g = loadstring('return 0x'..x:sub(3,4))();
 		b = loadstring('return 0x'..x:sub(5,6))();
	}
end


btn = 0
addEvent("onClientReloadUsedVehicle",true)
function uploadTire(veh,paintjob,vehiclemods,row)
	--removeEventHandler( "onClientPreRender", root, rotateCameraAroundPlayer )
	carElement = veh
	if guiGridListGetItemText(usedShopGUI["grid"]["shop"], row, 8) == "Simple Color" then
		if tonumber(paintjob) and tonumber(paintjob) < 3 then
			setVehiclePaintjob(carElement,paintjob)
		end
	else
		if tonumber(paintjob) and tonumber(paintjob) > 0 then
			for k,v in ipairs(xide) do
				if v[1] == tonumber(paintjob) then
					vname = v[2]
					triggerEvent("addCarPaint",localPlayer,carElement,vname)
				end
			end
		end
	end
	local upgrades = fromJSON(vehiclemods)
	if upgrades then
		for _,upgrade in pairs(upgrades) do
			addVehicleUpgrade(carElement, upgrade)
		end
	end
	--addEventHandler( "onClientPreRender", root, rotateCameraAroundPlayer )
end
addEventHandler("onClientReloadUsedVehicle",root,uploadTire)
se = {}
addEventHandler("onClientGUIClick",root,
function ()
	if (source == usedShopGUI["button"]["shop_buy"]) then
		local row,col = guiGridListGetSelectedItem(usedShopGUI["grid"]["shop"])
		if row and col and row ~= -1 and col ~= -1 then
			local carID = tonumber(guiGridListGetItemText(usedShopGUI["grid"]["shop"], row, 1))
			local carName = tostring(guiGridListGetItemText(usedShopGUI["grid"]["shop"], row, 3))
			local carPrice = tonumber(guiGridListGetItemText(usedShopGUI["grid"]["shop"], row, 4))
			local uniqueid = tonumber(guiGridListGetItemData(usedShopGUI["grid"]["shop"], row, 1))
			local ownerid = tonumber(guiGridListGetItemData(usedShopGUI["grid"]["shop"], row, 2))
			local health = tonumber(guiGridListGetItemData(usedShopGUI["grid"]["shop"], row, 3))
			local color1 = guiGridListGetItemData(usedShopGUI["grid"]["shop"], row, 4)
			local color2 = guiGridListGetItemData(usedShopGUI["grid"]["shop"], row, 5)
			local vehiclemods = guiGridListGetItemData(usedShopGUI["grid"]["shop"], row, 6)
			local paintjob = guiGridListGetItemData(usedShopGUI["grid"]["shop"], row, 7)
			local tune = guiGridListGetItemData(usedShopGUI["grid"]["shop"], row, 8)
			local red, green, blue, alpha = getColorFromString ( color1 )
			local red2, green2, blue2, alpha = getColorFromString ( color2 )
			if isTimer(spams[source]) then exports.NGCdxmsg:createNewDxMessage("You are no longer allowed to click on this, please wait 5 seconds!",255,0,0) return false end
			spams[source] = setTimer(function() end,5000,1)
			triggerServerEvent("buyUsedVehicle",client,client,uniqueid,carID,ownerid,carName,carPrice,health,tonumber(red), tonumber(green), tonumber(blue),tonumber(red2), tonumber(green2), tonumber(blue2),vehiclemods,paintjob,tune)
		end
	elseif (source == usedShopGUI["grid"]["shop"]) then
		local row,col = guiGridListGetSelectedItem(source)
		if row and col and row ~= -1 and col ~= -1 then
			if viewerModel == true then
				local carID = tonumber(guiGridListGetItemText(usedShopGUI["grid"]["shop"], row, 1))
				local color1 = guiGridListGetItemData(usedShopGUI["grid"]["shop"], row, 4)
				local color2 = guiGridListGetItemData(usedShopGUI["grid"]["shop"], row, 5)
				local vehiclemods = guiGridListGetItemData(usedShopGUI["grid"]["shop"], row, 6)
				local paintjob = guiGridListGetItemData(usedShopGUI["grid"]["shop"], row, 7)
				local infoveh = guiGridListGetItemData(usedShopGUI["grid"]["shop"], row, 9)
				local red, green, blue, alpha = getColorFromString ( color1 )
				local red2, green2, blue2, alpha = getColorFromString ( color2 )
				local x,y,z,rot = unpack(allAbout)
				guiSetText(memo,"")
				guiSetText(memo,infoveh)
				triggerServerEvent("setUsedVehicleModel",localPlayer,carID,x,y,z,rot,red, green, blue,red2, green2, blue2,paintjob,vehiclemods,row)
			else
				restartThing()
			end
		else
			guiSetText(memo,"")
			restartThing()
		end
	elseif (source == usedShopGUI["button"]["shop_close"]) then
		setTimer(setElementFrozen,500,1,client, false)
		guiSetVisible(usedShopGUI["window"]["shop"], false)
		showCursor(false)
		triggerEvent("onClientRemoveUsedVehicle",localPlayer)
		triggerServerEvent("closeUsedShopForServer",localPlayer)
		setElementData(localPlayer,"isPlayerInUsedShop",false)
		fadeCamera(false, 2)
		setTimer(function()
		fadeCamera(true, 2)
		setCameraTarget(client)
		end, 1500, 1)
	elseif (source == usedShopGUI["button"]["add_close"]) then
		guiSetVisible(usedShopGUI["window"]["add"],false)
		showCursor(false)
		triggerServerEvent("closeUsedShopForServer",localPlayer)
		setElementData(localPlayer,"isPlayerInUsedShop",false)
	end
end)
addEvent("onClientRemoveUsedVehicle",true)
function restartThing()
	if carElement and isElement(carElement) then
		local m = getElementData(localPlayer,"markCam")
		if m then
			setCameraMatrix(unpack(m))
		end
		--removeEventHandler( "onClientPreRender", root, rotateCameraAroundPlayer )
		triggerServerEvent("destroyUsedVehicleModel",localPlayer)
		carElement = nil
	end
end
addEventHandler("onClientRemoveUsedVehicle",root,restartThing)
addEventHandler("onClientPlayerQuit",root,function()
	if source == localPlayer then
		restartThing()
	end
end)
addEventHandler("onClientPlayerWasted",root,function()
	if source == localPlayer then
		restartThing()
		setElementData(localPlayer,"isPlayerInUsedShop",false)
	end
end)

addEvent("closeUsedShop",true)
addEventHandler("closeUsedShop",root,
function ()
	restartThing()
	setTimer(setElementFrozen,500,1,client, false)
	guiSetVisible(usedShopGUI["window"]["shop"], false)
	guiSetVisible(usedShopGUI["window"]["add"],false)
	setElementData(localPlayer,"isPlayerInUsedShop",false)
	showCursor(false)
	triggerServerEvent("closeUsedShopForServer",localPlayer)
	fadeCamera(false, 2)
	setCameraTarget(client)
	setTimer(function()
	fadeCamera(true, 2)
	end, 1500, 1)
end)

function getVehicleOwner(vehicle)
	if (vehicle and getElementType(vehicle) == "vehicle") then
		return getElementData(vehicle,"vehicleOwner")
	end
end


function dxDrawFramedText(message, left, top, width, height, color, scale, font, alignX, alignY, clip, wordBreak, postGUI)
	dxDrawText(message, left + 1, top + 1, width + 1, height + 1, tocolor(0, 0, 0, 255), scale, font, alignX, alignY, clip, wordBreak, postGUI)
	dxDrawText(message, left + 1, top - 1, width + 1, height - 1, tocolor(0, 0, 0, 255), scale, font, alignX, alignY, clip, wordBreak, postGUI)
	dxDrawText(message, left - 1, top + 1, width - 1, height + 1, tocolor(0, 0, 0, 255), scale, font, alignX, alignY, clip, wordBreak, postGUI)
	dxDrawText(message, left - 1, top - 1, width - 1, height - 1, tocolor(0, 0, 0, 255), scale, font, alignX, alignY, clip, wordBreak, postGUI)
	dxDrawText(message, left, top, width, height, color, scale, font, alignX, alignY, clip, wordBreak, postGUI)
end

function drawKit()
	for index, Marker in ipairs(getElementsByType("marker", resourceRoot)) do
		if getElementData(Marker,"USD") == true then
			if getElementDimension(localPlayer) ~= 0 then return false end
			local x,y,z = getElementPosition(Marker)
			local name = getElementData(Marker,"shopName")
			local camX, camY, camZ = getCameraMatrix()
			if getDistanceBetweenPoints3D(camX, camY, camZ, x,y,z) < 20 then
				local scX, scY = getScreenFromWorldPosition(x,y,z + 0.7)
				if scX then
					if getElementData(Marker,"markerBusy") then
						dxDrawFramedText(name.." is Busy", scX, scY, scX, scY, tocolor(255, 0, 0, 255), 1.0, "pricedown", "center", "center", false, false, false)
						setMarkerColor(Marker,255,0,0,180)
					else
						dxDrawFramedText(name.." is Available", scX, scY, scX, scY, tocolor(255, 255, 255, 255), 1.0, "pricedown", "center", "center", false, false, false)
						setMarkerColor(Marker,255,155,0,180)
					end
				end
			end
		end
	end
end
addEventHandler("onClientRender",root,drawKit)

local facing = 0
function rotateCameraAroundPlayer( )
	if getElementData(localPlayer,"isPlayerInUsedShop") then
		local x, y, z = getElementPosition( localPlayer )
		if carElement and isElement(carElement) then
			x, y, z = getElementPosition( carElement )
			local camX = x + math.cos( facing / math.pi * 180 ) * 5
			local camY = y + math.sin( facing / math.pi * 180 ) * 5
			setCameraMatrix( camX, camY, z+1, x, y, z )
			facing = facing + 0.0002
		else
			x, y, z = getElementPosition( localPlayer )
			local camX = x + math.cos( facing / math.pi * 180 ) * 5
			local camY = y + math.sin( facing / math.pi * 180 ) * 5
			setCameraMatrix( camX, camY, z+1, x, y, z )
			facing = facing + 0.0002
		end
	end
end
addEventHandler( "onClientPreRender", root, rotateCameraAroundPlayer )

addEvent("onPlayerSetArrested",true)
addEventHandler("onPlayerSetArrested",root,function()
	fadeCamera(false, 2)
	setTimer(function()
	fadeCamera(true, 2)
	setCameraTarget(client)
	end, 1500, 1)
	setTimer(setElementFrozen,500,1,client, false)
	guiSetVisible(usedShopGUI["window"]["shop"], false)
	guiSetVisible(usedShopGUI["window"]["add"],false)
	showCursor(false)
	triggerEvent("onClientRemoveUsedVehicle",localPlayer)
	triggerServerEvent("closeUsedShopForServer",localPlayer)
	restartThing()
	setElementData(localPlayer,"isPlayerInUsedShop",false)
end)

addEventHandler("onClientResourceStart",resourceRoot,function()
	triggerServerEvent("loadSellingShops",localPlayer)
	setElementData(localPlayer,"isPlayerInUsedShop",false)
end)

