local usedShops = {}
local timers = {}
local veh = {}
local markers = {}
local markerStatus = {}
local carElement = {}
local usedVehicleShops = {
	{name="Used Car shop", x=2475.36,y=-1947.06, z=13.55394, size=2, camera={2488.24, -1957.39, 17.84,2489.03, -1941.67, 13.38, 0, 180}, car={ 2452.03,-1976.55,13.54,91 },market="Automobile",City="LS"},
	{name="Used Plane shop", x=1993.75,y=-2313.48,z=13.54,size=3, camera={2052.535, -2529.665, 31.829, 2045.756, -2437.324, -5.948, 0,0}, car={ 2061.72,-2486.29,13.54,273 },market="Plane",City="LS"},
	{name="Used Helicopter shop", x=1553.47,y=-1353.08,z=329.45,size=3, camera={1533.378, -1345.775, 351.927, 1577.318, -1348.295, 262.134, 0,0}, car={ 1543.95,-1353.54,329.47,80 },market="Helicopter",City="LS"},
	{name="Used Boat shop", x=2.59,y=-1578.1,z=-0.6,size=3, camera={-7.996, -1575.448, 11.665, -10.134, -1634.735, -68.836, 0,0}, car={ -12.29,-1585.01,-0.6,188 },market="Boat",City="LS"},
	{name="Used Monster truck shop", x=2408.92,y=-1242.23,z=23.81,size=3, camera={2412.75, -1241.333, 26.835, 2418.77, -1145.639, -1.562, 0,0}, car={ 2415.32,-1230.2,24.39,264 },market="Monster Truck",City="LS"},
	{name="Used Bike shop", x=990.45,y=-1524.91,z=13.55,size=2, camera={979.19,-1535.44,23.61,968.39,-1530.71,13.56, 0,0}, car={ 968.39,-1530.71,13.56,270 },market="Bike",City="LS"},
}


local pk = {}
local parks = {
["Automobile"] = {
	["LS"] = { --- LS
		[1]={2479, -1952.57, 13.43,0},
		[2]={2482.5, -1952.57, 13.43,0},
		[3]={2485.5, -1952.57, 13.43,0},
		[4]={2489, -1952.57, 13.43,0},
		[5]={2492, -1952.57, 13.43,0},
		[6]={2495, -1952.57, 13.43,0},
		[7]={2498.5, -1952.57, 13.43,0},
		[8]={2501.5, -1952.57, 13.43,0},
	},
},
["Bike"] = {
	["LS"] = { --- LS
		[1]={962.91,-1523.66,13.55,179},
		[2]={967.78,-1524.28,13.55,177},
		[3]={973.4,-1524.33,13.55,179},
		[4]={962.91,-1523.66,13.55,179},
		[5]={967.78,-1524.28,13.55,177},
		[6]={973.4,-1524.33,13.55,179},
		[7]={962.91,-1523.66,13.55,179},
		[8]={967.78,-1524.28,13.55,177},
	},
},
["Plane"] = {
	["LS"] = { --- LS
		[1]={2057.24,-2493.9,13.54,89},
		[2]={2057.34,-2593.37,13.54,91},
		[3]={2057.24,-2493.9,13.54,89},
		[4]={2057.34,-2593.37,13.54,91},
		[5]={2057.24,-2493.9,13.54,89},
		[6]={2057.34,-2593.37,13.54,91},
		[7]={2057.24,-2493.9,13.54,89},
		[8]={2057.34,-2593.37,13.54,91},

	},
},
["Helicopter"] = {
	["LS"] = { --- LS
		[1]={1544.29,-1352.28,329.47,91},
		[2]={1544.29,-1352.28,329.47,91},
		[3]={1544.29,-1352.28,329.47,91},
		[4]={1544.29,-1352.28,329.47,91},
		[5]={1544.29,-1352.28,329.47,91},
		[6]={1544.29,-1352.28,329.47,91},
		[7]={1544.29,-1352.28,329.47,91},
		[8]={1544.29,-1352.28,329.47,91},
	},
},
["Boat"] = {
	["LS"] = { --- LS
		[1]={0.95,-1592.52,-0.49,174},
		[2]={-4.79,-1610.32,-0.55,172},
		[3]={0.95,-1592.52,-0.49,174},
		[4]={-4.79,-1610.32,-0.55,172},
		[5]={0.95,-1592.52,-0.49,174},
		[6]={-4.79,-1610.32,-0.55,172},
		[7]={0.95,-1592.52,-0.49,174},
		[8]={-4.79,-1610.32,-0.55,172},

	},
},
["Monster Truck"] = {
	["LS"] = { --- LS
		[1]={2424.05,-1231.52,24.78,183},
		[2]={2432.8,-1231.59,25.01,181},
		[3]={2432.68,-1237.97,24.62,180},
		[4]={2424.78,-1237.59,24.44,177},
		[5]={2427.88,-1250.94,23.83,93},
		[6]={2432.68,-1237.97,24.62,180},
		[7]={2432.8,-1231.59,25.01,181},
		[8]={2424.05,-1231.52,24.78,183},
	},
},
}
---[exports.server:getZone(source)]


-- Get the zone of the user
function getZone( thePlayer )
	if ( isElement( thePlayer ) ) then
		local theZone = printCity( thePlayer )
		if ( theZone ) then
			return tostring(theZone)
		else
			return false
		end
	else
		return false
	end
end

function printCity( thePlayer )
	local x, y, z = getElementPosition(thePlayer)
	if x < -920 then
		return "SF"
	elseif y < 420 then
		return "LS"
	else
		return "LV"
	end
end

addEventHandler("onResourceStart", getResourceRootElement(getThisResource()),
function ()

	for index, data in pairs(usedVehicleShops) do
		local marker = createMarker(data.x, data.y, data.z-1.3, "cylinder", data.size, 255, 155, 0, 180)
		--markerStatus[marker] = false
		setElementData(marker,"markerBusy",false)
		setElementData(marker,"USD",true)
		setElementData(marker,"Market",data.market)
		setElementData(marker,"City",data.City)
		usedShops[marker] = {data.camera, data.car}
		setElementData(marker,"shopName",data.name)
		addEventHandler("onMarkerHit",marker,onUsedShopMarkerHit)
		addEventHandler("onMarkerLeave",marker,clearMarkerHit)

	end
end)

addEvent("loadSellingShops",true)
addEventHandler("loadSellingShops",root,function()
end)

local tm = {}

function manageParks(client,theType)
	local tpl = hostPosition(getZone(client),theType)
	if tpl then
		local ran = math.random(1,#tpl)
		local x,y,z,r = tpl[ran][1], tpl[ran][2], tpl[ran][3], tpl[ran][4]
		setElementPosition(client,x,y,z+2)
		return x,y,z+1,r or 354
	end
end


function hostPosition(city,types)
	if parks then
		if parks[types][city] then

			return parks[types][city]

		end
	end

end



addEventHandler("onPlayerWasted",root,function()
	if carElement[source] and isElement(carElement[source]) then
		triggerClientEvent(source,"removeCarPaint",source,carElement[source])
		triggerClientEvent(source,"onClientRemoveUsedVehicle",source)
		destroyElement(carElement[source])
	end
end)

addEventHandler("onPlayerQuit",root,function()
	if carElement[source] and isElement(carElement[source]) then
		triggerClientEvent(source,"removeCarPaint",source,carElement[source])
		triggerClientEvent(source,"onClientRemoveUsedVehicle",source)
		destroyElement(carElement[source])
	end
end)

addEvent("destroyUsedVehicleModel",true)
addEventHandler("destroyUsedVehicleModel",root,function()
	if carElement[source] and isElement(carElement[source]) then
		triggerClientEvent(source,"removeCarPaint",source,carElement[source])
		destroyElement(carElement[source])
	end
end)

addEvent("setUsedVehicleModel",true)
addEventHandler("setUsedVehicleModel",root,function(carID,x,y,z,rot,r,g,b,r2,g2,b2,pj,vm,row)
	if carElement[source] and isElement(carElement[source]) then
		triggerClientEvent(source,"removeCarPaint",source,carElement[source])
		destroyElement(carElement[source])
	end
	carElement[source] = createVehicle(carID,x,y,z)
	local id = exports.server:getPlayerAccountID(source)
	setElementDimension(carElement[source],id)
	setElementVisibleTo (carElement[source],root, false )
	setElementRotation(carElement[source],0,0,rot)
	setVehicleColor(carElement[source],r,g,b,r2,g2,b2)
	setElementData(carElement[source], "locked", true)
	setElementCollisionsEnabled(carElement[source], false)
	setElementFrozen(carElement[source],true)
	setElementVisibleTo (carElement[source],source, true )
	triggerClientEvent(source,"onClientReloadUsedVehicle",source,carElement[source],pj,vm,row)
end)


function onUsedShopMarkerHit(hitElement, matchingDim)
	if matchingDim then
		if hitElement and getElementType(hitElement) == "player" and not isPedInVehicle(hitElement) then
			if getElementData(source,"markerBusy") == false then
				if getElementData(hitElement,"isPlayerArrested") then return false end
				if getElementData (hitElement, "copArrestedCrim", true ) then return false end
				if getElementData(hitElement,"wantedPoints") >= 30 then
					exports.NGCnote:addNote("used car","Your wanted points are too high sorry we can't have a deal with you!",hitElement,255,0,0,5000)
					return false
				end
				local x,y,z = getElementPosition(source)
				local shopType = getElementData(source,"Market")
				local shopName = getElementData(source,"shopName")
				setElementData(source,"markerBusy",true)
				setElementData(hitElement,"shopPosition",{x,y,z})
				setElementData(hitElement,"theType",getElementData(source,"Market"))
				setElementData(hitElement,"theMarker",getElementData(source,"City"))
				setElementData(hitElement,"markCam",usedShops[source][1])
				setElementData(hitElement,"elementMarker",source)
				---setCameraMatrix(hitElement, unpack(usedShops[source][1]))
				local id = exports.server:getPlayerAccountID(hitElement)
				setElementDimension(hitElement,id)
				local vehicleList = exports.DENmysql:query("SELECT * FROM vehicles WHERE sale=?",1)
				exports.NGCdxmsg:createNewDxMessage(hitElement,"Be patient, vehicles are being loaded",255,255,0)
				triggerClientEvent(hitElement, "ShowUsedCarShop", hitElement, vehicleList, shopName,shopType,usedShops[source][2])--,owner)
				markerStatus[source] = hitElement
				--markers[hitElement] = true
			end
		elseif hitElement and getElementType(hitElement) == "vehicle" then
			local driver = getVehicleOccupant ( hitElement,0 ) -- get the player sitting in seat 0
			if driver and getVehicleController(hitElement) == driver then
				local shopType = getElementData(source,"Market")
				local shopName = getElementData(source,"shopName")
				if tostring(getVehicleType(hitElement)) ~= tostring(shopType) then
					exports.NGCdxmsg:createNewDxMessage(driver,"You can't sell this vehicle here. This is ("..shopName.." type)",255,0,0)
					return
				end
				local x,y,z = getElementPosition(source)
				setElementData(driver,"shopPosition",{x,y,z})
				setElementData(driver,"theType",getElementData(source,"Market"))
				setElementData(driver,"theMarker",getElementData(source,"City"))
				local vehID = exports.CSGplayervehicles:getVehicleID(hitElement)
				local vehicles = exports.DENmysql:query("SELECT * FROM vehicles WHERE ownerid=?", exports.server:getPlayerAccountID(driver))
				for k,v in ipairs(vehicles) do
					if vehID == v.uniqueid then
						if getElementData(hitElement,"vehicleOwner") ~= driver then exports.NGCdxmsg:createNewDxMessage(driver,"You are not the owner of this vehicle",255,0,0) return false end
						if getElementData(source,"markerBusy") == false then
							setElementData(driver,"elementMarker",source)
							setElementData(source,"markerBusy",true)
							setElementFrozen(hitElement,true)
							markerStatus[source] = hitElement
							--markers[driver] = true
							local tune = v.tune
							local boughtprice = v.boughtprice
							local fuckme = v.customPrice -- or 0
							triggerClientEvent(driver, "addUsedCarShop", driver,hitElement,vehID,v.vehicleid,v.uniqueid,v.color1,v.color2,v.vehiclehealth,v.paintjob,tune,boughtprice,fuckme,shopType)
						end
					end
				end
			end
		end
	end
end
noob = {}
function clearMarkerHit(hitElement,matchingDim)
	if not matchingDim then return false end
	if hitElement and getElementType(hitElement) == "player" then
		if markerStatus[source] == hitElement then
			if getElementData(source,"markerBusy") == true then
				noob[source] = setTimer(function(x,m)
					markerStatus[m] = nil
					setElementData(m,"markerBusy",false)
				end,3000,1,hitElement,source)
			end
		end
	elseif hitElement and getElementType(hitElement) == "vehicle" then
		if markerStatus[source] == hitElement then
			local driver = getVehicleOccupant ( hitElement,0 ) -- get the player sitting in seat 0
			if driver and getVehicleController(hitElement) == driver then
				if getElementData(source,"markerBusy") then
					noob[source] = setTimer(function(x,m)
						markerStatus[m] = nil
						setElementData(m,"markerBusy",false)
					end,3000,1,driver,source)
				end
			end
		end
	end
end

addEventHandler("onPlayerWasted",root,function()
	local m = getElementData(source,"elementMarker")
	if m and isElement(m) then
		if m and getElementData(m,"markerBusy") then
			markerStatus[m] = nil
			setElementData(m,"markerBusy",false)
		end
		freshShop(source)
	end
end)
addEventHandler("onPlayerQuit",root,function()
	local m = getElementData(source,"elementMarker")
	if m and isElement(m) then
		if m and getElementData(m,"markerBusy") then
			markerStatus[m] = nil
			setElementData(m,"markerBusy",false)
		end
		freshShop(source)
	end
end)

function getUsedVehicles()
	return exports.DENmysql:query("SELECT * FROM used_vehicles")
end

function getPlayerVehicles(player)
	local vehicles = exports.DENmysql:query("SELECT * FROM vehicles WHERE ownerid=?", exports.server:getPlayerAccountID(player))
	return vehicles
end


function doesUsedVehicleExists(ID)
	if exports.DENmysql:query("SELECT * FROM used_vehicles where uniqueid=?",tonumber(ID)) then
		return false
	else
		return true
	end
end


function countPlayerVehicles(id)
	return #exports.DENmysql:query("SELECT * FROM vehicles WHERE ownerid=?",id)
end

function freshShop(hitElement)
	setElementData(hitElement,"shopPosition",false)
	setElementData(hitElement,"theType",false)
	setElementData(hitElement,"theMarker",false)
	setElementData(hitElement,"markCam",false)
	setElementData(hitElement,"elementMarker",false)
end

addEvent("getOwnedVehicles",true)
addEventHandler("getOwnedVehicles",root,
function (client)
	local vehicles = getPlayerVehicles(client)
	triggerClientEvent(client,"returnOwnedVehicles",client,vehicles)
end)



addEvent("closeUsedShopForServer",true)
addEventHandler("closeUsedShopForServer",root,function()
	if carElement[source] and isElement(carElement[source]) then
		triggerClientEvent(source,"removeCarPaint",source,carElement[source])
		triggerClientEvent(source,"onClientRemoveUsedVehicle",source)
		destroyElement(carElement[source])
	end
	setElementDimension(source,0)
	local theVehicle = getPedOccupiedVehicle ( source )
	if theVehicle then
		setElementFrozen(theVehicle,false)
		local marker = getElementData(source,"theType")
		local x,y,z,rot = manageParks(theVehicle,marker)
		setElementPosition(theVehicle, x,y,z )
		setElementRotation(theVehicle,0,0,rot or 1.5)
		setElementPosition(source,x+math.random(-1,1),y+math.random(-1,1),z)
		freshShop(source)
	end
	local m = getElementData(source,"elementMarker")
	if m then
		--markerStatus[m] = false
		markerStatus[m] = nil
		setElementData(m,"markerBusy",false)
	end
end)


addEvent("addUsedVehicle",true)
addEventHandler("addUsedVehicle",root,
function (client, carID, unID, carPrice,health,color1,color2,carParts,paintjob,tune,cs,ins)
	local can,msg = exports.NGCmanagement:isPlayerLagging(source)
	if can then
		local ac = exports.server:getPlayerAccountID(client)
		local Owner = exports.DENmysql:querySingle( "SELECT * FROM accounts WHERE id = ?", tonumber(ac) )
		triggerClientEvent(client,"closeUsedShop",client)
		exports.DENmysql:exec("UPDATE vehicles SET sale=?,licenseplate=?,customPrice=?,sinfo=? WHERE uniqueid=?",1,"For sale",cs,ins,unID)
		--exports.DENmysql:exec("UPDATE vehicles SET sale=?,licenseplate=? WHERE uniqueid=?",1,"For sale",unID)
		removePedFromVehicle(client)
		local marker = getElementData(client,"theType")
		local x,y,z = unpack(getElementData(client,"shopPosition"))
		setElementPosition(client, x,y,z )
		setElementRotation(client,0,0,0)
		local m = getElementData(client,"elementMarker")
		if m then
			markerStatus[m] = nil
			setElementData(m,"markerBusy",false)
		end
		freshShop(client)
		exports.CSGplayervehicles:despawnPlayerVehicle(client,unID,false)
		exports.CSGplayervehicles:sendPlayerVehicleInfo(client)
	else
		triggerClientEvent(source,"returnAddShop",source)
		exports.NGCdxmsg:createNewDxMessage(source,"You are lagging , try again later",255,0,0)
	end
end)


addEvent("buyUsedVehicle",true)
addEventHandler("buyUsedVehicle",root,
function (client,uniqueid,carID,ownerid,carName,carPrice,health,r,g,b,r2,g2,b2,carParts,paintjob,tune)
	if ownerid then
		local playerID = exports.server:getPlayerAccountID(client)
		--if not getElementData(client,"isPlayerVIP") and countPlayerVehicles(playerID) >= 10 then exports.NGCdxmsg:createNewDxMessage(client, "Vehicle shop: You can't buy more than 10 vehicles.",255,0,0) return end
		local maxSlots = exports.CSGplayervehicles:getPlayerVehicleSlots( source )
		if ( not exports.server:getPlayerVehicles ( source ) or #exports.server:getPlayerVehicles ( source ) < maxSlots ) then
			if (playerID == tonumber(ownerid)) then
				local can,msg = exports.NGCmanagement:isPlayerLagging(source)
				if can then
					exports.NGCdxmsg:createNewDxMessage(client, "You took your ".. carName .." from the sales!", 0, 118, 0)
					local color1 = exports.server:convertRGBToHEX( r,g,b )
					local color2 = exports.server:convertRGBToHEX( r2,g2,b2 )
					triggerClientEvent(client,"closeUsedShop",client)
					triggerEvent("closeUsedShopForServer",client)
					local marker = getElementData(client,"theType")
					local x,y,z,rot = manageParks(client,marker)
					---exports.DENmysql:exec("UPDATE vehicles SET ownerid=?,licenseplate=?,sale=?,x=?,y=?,z=?,rotation=?,customPrice=? where uniqueid=?",ownerid,"NGC",0,x,y,z,rot,0,uniqueid)
					exports.DENmysql:exec("UPDATE vehicles SET ownerid=?,licenseplate=?,sale=?,x=?,y=?,z=?,rotation=?,customPrice=? WHERE uniqueid=?",ownerid,"NGC",0,x,y,z,rot,0,uniqueid)
					exports.CSGplayervehicles:sendPlayerVehicleInfo(client)
					triggerEvent("CSGplayerVehicles.spawnVeh",client,uniqueid)
					freshShop(client)
				else
					exports.NGCdxmsg:createNewDxMessage(source,"You are lagging , try again later",255,0,0)
				end
			else
				if getPlayerMoney(client) < carPrice then
					exports.NGCdxmsg:createNewDxMessage(client, "You don't have enough money to buy this vehicle.", 255, 0, 0)
					triggerClientEvent(client,"closeUsedShop",client)
					triggerEvent("closeUsedShopForServer",client)
					return
					false
				end
				local can,msg = exports.NGCmanagement:isPlayerLagging(source)
				if can then
					local color1 = exports.server:convertRGBToHEX( 255, 255, 255 )
					local color2 = exports.server:convertRGBToHEX( 255, 255, 255 )
					bankTransfer(ownerid,carPrice,carName)
					takePlayerMoney(client,carPrice)
					local marker = getElementData(client,"theType")
					local x,y,z,rot = manageParks(client,marker)
					exports.DENmysql:exec("UPDATE vehicles SET ownerid=?,licenseplate=?,sale=?,x=?,y=?,z=?,rotation=?,customPrice=?,boughtprice=? where uniqueid=?",playerID,"NGC",0,x,y,z,rot,0,carPrice,uniqueid)
					for k,v in ipairs(getElementsByType("player")) do
						if exports.server:getPlayerAccountID(v) == ownerid then
							exports.CSGplayervehicles:sendPlayerVehicleInfo(v)
							triggerEvent("CSGplayerVehicles.saleShop",v,v,uniqueid)
						end
					end
					exports.NGCdxmsg:createNewDxMessage(client, "You have bought a ".. carName .." for: ".. (carPrice) .."!", 0, 255, 0)
					for k,v in ipairs(getElementsByType("player")) do
						local ID = exports.server:getPlayerAccountID(v)
						if tonumber(ownerid) == ID then
							exports.NGCdxmsg:createNewDxMessage(v, "".. getPlayerName(client) .." has bought your ".. tostring(carName) .." for: ".. (carPrice) .."( Sent to Bank account (ATM) )!", 0, 255, 0)
						end
					end
					---triggerEvent("CSGplayerVehicles.saleShop",client,client,uniqueid)
					exports.CSGplayervehicles:sendPlayerVehicleInfo(client)
					triggerEvent("CSGplayerVehicles.spawnVeh",client,uniqueid)
					triggerClientEvent(client,"closeUsedShop",client)
					triggerEvent("closeUsedShopForServer",client)
				else
					exports.NGCdxmsg:createNewDxMessage(source,"You are lagging , try again later",255,0,0)
				end
			end
		else
			exports.NGCdxmsg:createNewDxMessage(source, "You can only have "..tostring(maxSlots).." vehicles!", 255, 0, 0)
		end
	else
		exports.NGCdxmsg:createNewDxMessage(client,"Something went wrong please try again",255,0,0)
	end
end)


function bankTransfer(id,price,name)
	local balanceCheck = exports.DENmysql:querySingle( "SELECT * FROM banking WHERE userid = ?", id )
	if not balanceCheck then
		exports.DENmysql:exec("INSERT INTO banking SET userid=?, balance=?", id,price)
		exports.DENmysql:exec( "INSERT INTO banking_transactions SET userid = ?, transaction = ?", id, "Used vehicles shop: Has sent to you $"..price.." for selling your "..name..".")
	else
		local balanceCheck = exports.DENmysql:querySingle( "SELECT * FROM banking WHERE userid = ?", id )
		local totalNewBalance = (balanceCheck.balance + price)
		exports.DENmysql:exec( "UPDATE banking SET balance = ? WHERE userid = ?", totalNewBalance, id)
		exports.DENmysql:exec( "INSERT INTO banking_transactions SET userid = ?, transaction = ?", id, "Used vehicles shop: Has sent to you $"..price.." for selling your "..name..".")
	end
end




