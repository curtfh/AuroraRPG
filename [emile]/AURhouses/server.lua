local warpers = {}
local houseObject = {}
local handled = {}
local quitDetect = {}
local antiBug = {}
local gays = {}
local theTable = {}
local process = {}
local robCD = {}
local packetloss = {}
local lossTimer = {}
local blockedPlayers = {}
local intids = {
-- House interoirs with locations
[1]="3|235.22|1188.84|1080.25",
[2]="2|225.13|1240.07|1082.14",
[3]="1|223.2|1288.84|1082.13",
[4]="15|328.03|1479.42|1084.43",
[5]="2|2466.27|-1698.18|1013.5",
[6]="5|227.76|1114.44|1080.99",
[7]="15|385.72|1471.91|1080.18",
[8]="7|225.83|1023.95|1084",
[9]="8|2807.61|-1172.83|1025.57",
[10]="10|2268.66|-1210.38|1047.56",
[11]="3|2495.79|-1694.12|1014.74",
[12]="10|2261.62|-1135.71|1050.63",
[13]="8|2365.2|-1133.07|1050.87",
[14]="5|2233.68|-1113.33|1050.88",
[15]="11|2283|-1138.13|1050.89",
[16]="6|2194.83|-1204.12|1049.02",
[17]="6|2308.73|-1210.88|1049.02",
[18]="1|2215.42|-1076.06|1050.48",
[19]="2|2237.74|-1078.89|1049.02",
[20]="9|2318.03|-1024.64|1050.21",
[21]="6|2333.03|-1075.38|1049.02",
[22]="5|1263.44|-785.63|1091.9",
[23]="1|245.98|305.13|999.14",
[24]="2|269.09|305.15|999.14",
[25]="12|2324.39|-1145.2|1050.71",
[26]="5|318.56|1118.2|1083.88",
[27]="1|245.78|305.12|999.14",
[28]="5|140.33|1368.78|1083.86",
[29]="6|234.21|1066.84|1084.2",
[30]="9|83.52|1324.48|1083.85",
[31]="10|24.15|1341.64|1084.37",
[32]="15|374.34|1417.51|1081.32",
[33]="1|2525.0420|-1679.1150|1015.4990",
}

local leavingCols = {
-- Leaving positions for the doors
[1] = {3, 235.23, 1186.67, 1080.25},
[2] = {2, 226.78, 1239.93, 1082.14},
[3] = {1, 223.07, 1287.08, 1082.13},
[4] = {15, 327.94, 1477.72, 1084.43},
[5] = {2, 2468.84, -1698.36, 1013.5},
[6] = {5, 226.29, 1114.27, 1080.99},
[7] = {15, 387.22, 1471.73, 1080.18},
[8] = {7, 225.66, 1021.44, 1084},
[9] = {8, 2807.62, -1174.76, 1025.57},
[10] = {10, 2270.41, -1210.53, 1047.56},
[11] = {3, 2496.05, -1692.09, 1014.74},
[12] = {10, 2259.38, -1135.9, 1050.63},
[13] = {8, 2365.18, -1135.6, 1050.87},
[14] = {5, 2233.64, -1115.27, 1050.88},
[15] = {11, 2282.82, -1140.29, 1050.89},
[16] = {6, 2196.85, -1204.45, 1049.02},
[17] = {6, 2308.76, -1212.94, 1049.02},
[18] = {1, 2218.4, -1076.36, 1050.48},
[19] = {2, 2237.55, -1081.65, 1049.02},
[20] = {9, 2317.77, -1026.77, 1050.21},
[21] = {6, 2333, -1077.36, 1049.02},
[22] = {5, 1260.64, -785.34, 1091.9},
[23] = {1, 243.71, 305.01, 999.14},
[24] = {2, 266.49, 304.99, 999.14},
[25] = {12, 2324.31, -1149.55, 1050.71},
[26] = {5, 318.57, 1114.47, 1083.88},
[27] = {1, 243.71, 304.96, 999.14},
[28] = {5, 140.32, 1365.91, 1083.86},
[29] = {6, 234.13, 1063.72, 1084.2},
[30] = {9, 83.04, 1322.28, 1083.85},
[31] = {10, 23.92, 1340.16, 1084.37},
[32] = {15, 377.15, 1417.3, 1081.32},
[33] = {5, 1298.87, -797.01, 1084, 1015.4990}
}

function onPlayerUpdateLabels ( thePlayer, houseID )
	local houseTable = exports.DENmysql:querySingle( "SELECT * FROM housing WHERE id = ?", tonumber(houseID) )
	iprint(housetable)
	local houseOwner = exports.DENmysql:querySingle( "SELECT * FROM accounts WHERE id = ?", tonumber(houseTable.ownerid) )
	if not ( houseOwner ) then
		houseOwn = "AUR Housing"
	else
		houseOwn = houseOwner.username
	end
	triggerClientEvent ( thePlayer, "updateHousingLabels", thePlayer, houseTable.ownerid, houseTable.interiorid, houseTable.sale, houseTable.houseprice, houseTable.housename, houseTable.locked, houseTable.boughtprice,houseTable.passwordlocked,houseTable.originalPrice,houseOwn,houseTable.lastonline )
	--[[for k,v in ipairs(getElementsByType("player")) do
		triggerClientEvent ( v, "updateHousingLabels", v, houseTable.ownerid, houseTable.interiorid, houseTable.sale, houseTable.houseprice, houseTable.housename, houseTable.locked, houseTable.boughtprice,houseTable.passwordlocked,houseTable.originalPrice,houseOwn )
	end]]--
	return true
end

function onHousingStart ()
	local houses = exports.DENmysql:query( "SELECT * FROM housing" )
	if ( houses and #houses > 0 ) then
		for i=1,1000 do
			if houses[i] then
					createHouse( houses[i].id, houses[i].ownerid, houses[i].interiorid, houses[i].x, houses[i].y, houses[i].z, houses[i].sale, houses[i].houseprice, houses[i].housename, houses[i].locked, houses[i].boughtprice, houses[i].passwordlocked, houses[i].password,houses[i].originalPrice,houses[i].lastonline)
			end
		end
		setTimer(function(houses,i)
			for i=1001,1500 do
				if houses[i] then
					createHouse( houses[i].id, houses[i].ownerid, houses[i].interiorid, houses[i].x, houses[i].y, houses[i].z, houses[i].sale, houses[i].houseprice, houses[i].housename, houses[i].locked, houses[i].boughtprice, houses[i].passwordlocked, houses[i].password,houses[i].originalPrice,houses[i].lastonline)

				end
			end
		end,10000,1,houses,i)
		setTimer(function(houses,i)
			for i=1501,2000 do
				if houses[i] then
					createHouse( houses[i].id, houses[i].ownerid, houses[i].interiorid, houses[i].x, houses[i].y, houses[i].z, houses[i].sale, houses[i].houseprice, houses[i].housename, houses[i].locked, houses[i].boughtprice, houses[i].passwordlocked, houses[i].password,houses[i].originalPrice,houses[i].lastonline)

				end
			end
		end,20000,1,houses,i)

		setTimer(function(houses,i)
			for i=2001,2500 do
				if houses[i] then
					createHouse( houses[i].id, houses[i].ownerid, houses[i].interiorid, houses[i].x, houses[i].y, houses[i].z, houses[i].sale, houses[i].houseprice, houses[i].housename, houses[i].locked, houses[i].boughtprice, houses[i].passwordlocked, houses[i].password,houses[i].originalPrice,houses[i].lastonline)

				end
			end
		end,30000,1,houses,i)
		setTimer(function(houses,i)
			for i=2501,3000 do
				if houses[i] then
					createHouse( houses[i].id, houses[i].ownerid, houses[i].interiorid, houses[i].x, houses[i].y, houses[i].z, houses[i].sale, houses[i].houseprice, houses[i].housename, houses[i].locked, houses[i].boughtprice, houses[i].passwordlocked, houses[i].password,houses[i].originalPrice,houses[i].lastonline)

				end
			end

		end,40000,1,houses,i)
		setTimer(function(houses,i)
			for i=3001,3500 do
				if houses[i] then
					createHouse( houses[i].id, houses[i].ownerid, houses[i].interiorid, houses[i].x, houses[i].y, houses[i].z, houses[i].sale, houses[i].houseprice, houses[i].housename, houses[i].locked, houses[i].boughtprice, houses[i].passwordlocked, houses[i].password,houses[i].originalPrice,houses[i].lastonline)

				end
			end

		end,50000,1,houses,i)
		setTimer(function(houses,i)
			for i=3501,#houses do
				if houses[i] then
					createHouse( houses[i].id, houses[i].ownerid, houses[i].interiorid, houses[i].x, houses[i].y, houses[i].z, houses[i].sale, houses[i].houseprice, houses[i].housename, houses[i].locked, houses[i].boughtprice, houses[i].passwordlocked, houses[i].password,houses[i].originalPrice,houses[i].lastonline)

				end
			end
		end,60000,1,houses,i)
	end
end
addEventHandler ( "onResourceStart", getResourceRootElement(getThisResource()), onHousingStart )
addEvent("housesReload",true)
addEventHandler("housesReload",root,onHousingStart)

-- Create houses


-- Compare the timestamp
function compareTimestampDays ( timeStamp )
	local theStamp = ( getRealTime().timestamp - timeStamp )
	if ( theStamp <= 86400 ) then
		local hours = math.floor( ( theStamp / 3600  ) )
		if ( hours == 1 ) then
			return 1,"hours"
		elseif ( hours == -1 ) then
			return 0 ,"hours"
		else
			return hours,"hours"
		end
	else
		local days = math.floor( ( theStamp / 86400 ) )
		if ( timeStamp == 99999 ) then
			return "Unknown","days"
		elseif ( days == 1 ) then
			return 1,"days"
		elseif ( days == -1 ) then
			return 0,"days"
		else
			return days,"days"
		end
	end
end

function createHouse ( houseid, ownerid, interiorid, housex, housey, housez, housesale, houseprice, housename, houselocked, boughtprice, passwordlocked, housepassword, originalPrice,seen )

	local houseOwner = exports.DENmysql:querySingle( "SELECT * FROM accounts WHERE id = ?", tonumber(ownerid) )

	if not ( houseOwner ) then
		houseOwner = "AUR Housing"
	else
		houseOwner = houseOwner.username
	end
	if houseprice >= 20000000 then houseprice = boughtprice end
	if houseprice <= 40000 then houseprice = boughtprice end

	if ( housesale == 0 ) then
		_G["house"..tostring(houseid)] = createPickup ( housex, housey, housez, 3, 1272, 0)
		local house = _G["house"..tostring(houseid)]
		setElementData(house, "houseid", houseid)
		setElementData(house, "ownerid",ownerid)
		setElementData(house, "ownername",houseOwner)
		setElementData(house, "interiorid",interiorid)
		setElementData(house, "housesale",housesale)
		setElementData(house, "houseprice",houseprice)
		setElementData(house, "housename",housename)
		setElementData(house, "houselocked",houselocked)
		setElementData(house, "boughtprice",boughtprice)
		setElementData(house, "passwordlocked",passwordlocked)
		setElementData(house, "housepassword",housepassword)
		setElementData(house, "originalPrice",originalPrice)
		setElementData(house, "lastSeen",seen)
		setElementData(house, "secured",false)
		setElementData(house, "robbed","Available for robbery")
	else
		_G["house"..tostring(houseid)] = createPickup ( housex, housey, housez, 3, 1273, 0)
		local house = _G["house"..tostring(houseid)]
		setElementData(house, "houseid", houseid)
		setElementData(house, "ownerid",ownerid)
		setElementData(house, "ownername",houseOwner)
		setElementData(house, "interiorid",interiorid)
		setElementData(house, "housesale",housesale)
		setElementData(house, "houseprice",houseprice)
		setElementData(house, "housename",housename)
		setElementData(house, "houselocked",houselocked)
		setElementData(house, "boughtprice",boughtprice)
		setElementData(house, "passwordlocked",passwordlocked)
		setElementData(house, "housepassword",housepassword)
		setElementData(house, "originalPrice",originalPrice)
		setElementData(house, "lastSeen",seen)
		setElementData(house, "secured",false)
		setElementData(house, "robbed","Available for robbery")
	end
	--[[if not seen then seen = 25 end
	local result,ty = compareTimestampDays(seen)
	if result then
		if ty == "hours" and result >= 720 then
			setPickupType(_G["house"..tostring(houseid)],3,1273)
			outputDebugString(houseid.." is being sold for bank Above hours 720")
			setElementData(_G["house"..tostring(houseid)],"ownerid", 0)
			setElementData(_G["house"..tostring(houseid)],"ownername","AURhousing")
			setElementData(_G["house"..tostring(houseid)],"housesale",1)
			setElementData(_G["house"..tostring(houseid)],"houselocked",0)
		elseif ty == "hours" and result <= -720 then
			setPickupType(_G["house"..tostring(houseid)],3,1273)
			outputDebugString(houseid.." is being sold for bank Above hours 720")
			setElementData(_G["house"..tostring(houseid)],"ownerid", 0)
			setElementData(_G["house"..tostring(houseid)],"ownername","AURhousing")
			setElementData(_G["house"..tostring(houseid)],"housesale",1)
			setElementData(_G["house"..tostring(houseid)],"houselocked",0)
		elseif ty == "days" and result == "Unknown" then
			setPickupType(_G["house"..tostring(houseid)],3,1273)
			outputDebugString(houseid.." is being sold for bank Above days 30")
			setElementData(_G["house"..tostring(houseid)],"ownerid", 0)
			setElementData(_G["house"..tostring(houseid)],"ownername","AURhousing")
			setElementData(_G["house"..tostring(houseid)],"housesale",1)
			setElementData(_G["house"..tostring(houseid)],"houselocked",0)
		elseif ty == "days" and result >= 30 then
			setPickupType(_G["house"..tostring(houseid)],3,1273)
			outputDebugString(houseid.." is being sold for bank Above hours 30")
			setElementData(_G["house"..tostring(houseid)],"ownerid", 0)
			setElementData(_G["house"..tostring(houseid)],"ownername","AURhousing")
			setElementData(_G["house"..tostring(houseid)],"housesale",1)
			setElementData(_G["house"..tostring(houseid)],"houselocked",0)

		end
	end]]--

		--[[ to prevent bug so synce it with epozide owner id
		if houseOwner == "AURhousing" then
			setElementData(_G["house"..tostring(houseid)], "housesale",1)
			setElementData(_G["house"..tostring(houseid)], "houselocked",0)
			setElementData(_G["house"..tostring(houseid)], "ownerid",0)
			setPickupType(_G["house"..tostring(houseid)], 3, 1273, 0 )
		end]]
		local houseOwner = exports.DENmysql:querySingle( "SELECT * FROM accounts WHERE id = ?", tonumber(ownerid) )
		if not ( houseOwner ) then
			setElementData(_G["house"..tostring(houseid)], "housesale",1)
			setElementData(_G["house"..tostring(houseid)], "houselocked",0)
			setElementData(_G["house"..tostring(houseid)], "ownerid",0)
			setPickupType(_G["house"..tostring(houseid)], 3, 1273, 0 )
		end
		local x,y,z = leavingCols[interiorid][2],leavingCols[interiorid][3],leavingCols[interiorid][4]
		local rx,ry,rz = 0,0,180
		if isElement(warpers[houseid]) then destroyElement(warpers[houseid]) end
		warpers[houseid] = createPickup ( x, y, z, 3, 1318, 0)
		setElementDimension(warpers[houseid],houseid)
		setElementInterior(warpers[houseid],leavingCols[interiorid][1])
end

function trackPlayerHouse(player)
	local int = getElementInterior(player)
	if int ~= 0 then
		local dim = getElementDimension(player)
		local thisHouse = _G["house"..tostring(dim)]
		if thisHouse then
			local x,y,z = getElementPosition(thisHouse)
			return x,y,z
		end
	end
	return 0,0,0
end


-- When the player quit save the last online time
addEventHandler( "onPlayerQuit", root,
	function ()
		local playerID = exports.server:getPlayerAccountID( source )
		local houses = exports.DENmysql:query( "SELECT * FROM housing WHERE ownerid=?",playerID )
		if houses then
			for k,v in ipairs(houses) do
				local thisHouse = _G["house"..tostring(v.id)]
				if thisHouse and isElement(thisHouse) then
					setElementData(thisHouse,"lastSeen",getRealTime().timestamp)
					exports.DENmysql:exec( "UPDATE housing SET lastonline=? WHERE ownerid=? AND id=?", getRealTime().timestamp, playerID, v.id )
				end
			end
		end
	end
)


-- if blockedPlayers[cmds][source] then
addEventHandler("onPlayerQuit",root,function()
	quitDetect[source] = true
end)

addEvent("checkPacket",true)
addEventHandler("checkPacket",root,function(s,t)
	---outputDebugString(getPlayerName(source).." Status("..s..") : Ticks :"..t )
	if s == 0 then
		packetloss[source] = true
		if isTimer(lossTimer[source]) then killTimer(lossTimer[source]) end
	elseif s == 1 then
		if not isTimer(lossTimer[source]) then return false end
		lossTimer[source] = setTimer(function(p)
			packetloss[p] = false
		end,1000,1,source)
	end
end)

addEventHandler( "onPlayerNetworkStatus", root,function( status, ticks )
    if status == 0 then
		---outputDebugString( "(packets from " .. getPlayerName(source) .. ") interruption began " .. ticks .. " ticks ago" )
		packetloss[source] = true
		if isTimer(lossTimer[source]) then killTimer(lossTimer[source]) end
    elseif status == 1 then
		if not isTimer(lossTimer[source]) then return false end
		----outputDebugString( "(packets from " .. getPlayerName(source) .. ") interruption began " .. ticks .. " ticks ago and has just ended" )
		lossTimer[source] = setTimer(function(p)
			packetloss[p] = false
		end,1000,1,source)
	end
end)

addEvent("setPlayerQuitDetected",true)
addEventHandler("setPlayerQuitDetected",root,function()
	quitDetect[source] = true
	exports.CSGaccounts:forceWeaponSync(source)
end)

addEventHandler("onPlayerCommand",root,function(cmd)
	if cmd == "reconnect" or cmd == "quit" or cmd == "disconnect" or cmd == "exit" or cmd == "connect" then
		quitDetect[source] = true
		exports.CSGaccounts:forceWeaponSync(source)
	end
end)

-- Function that toggle house lock
addEvent("setHouseLock",true)
addEventHandler("setHouseLock",root,function(id,typeoflock,owner)
	if not isOwner(source,id) then exports.NGCdxmsg:createNewDxMessage(source,"You are not the owner of this house!",255,0,0) return false end
	if id and typeoflock then
		local can,ms = exports.NGCmanagement:isPlayerLagging(source)
		if can then
			exports.DENmysql:exec("UPDATE housing SET locked=? WHERE id=?",tonumber(typeoflock),id)
			local theHouse = _G["house"..tostring(id)]
			setElementData(theHouse,"houselocked",tonumber(typeoflock))
			onPlayerUpdateLabels(owner,id)
		else
			exports.NGCdxmsg:createNewDxMessage(source,msg,255,0,0)
		end
	end
end)

function isOwner(player,houseid)
	local theHouse = _G["house"..tostring( houseid )]
	local ownerid = getElementData(theHouse,"ownerid")
	if exports.server:getPlayerAccountID(player) == tonumber(ownerid) or getElementData(player,"isPlayerPrime") then
		return true
	else
		return false
	end
end

antiPriceSpam = {}
-- function that set house price
addEvent("setHousePrice",true)
addEventHandler("setHousePrice",root,function(id,price)
	if not isOwner(source,id) then exports.NGCdxmsg:createNewDxMessage(source,"You are not the owner of this house!",255,0,0) return false end
	if id and price then
		local can,ms = exports.NGCmanagement:isPlayerLagging(source)
		if can then
			if isTimer(antiPriceSpam[source]) then return false end
			exports.DENmysql:exec("UPDATE housing SET houseprice=? WHERE id=?",tonumber(price),id)
			exports.NGCdxmsg:createNewDxMessage(source,"Your house has updated with the new price",255,0,0)
			local theHouse = _G["house"..tostring(id)]
			setElementData(theHouse,"houseprice",tonumber(price))
			onPlayerUpdateLabels(source,id)
			antiPriceSpam[source] = setTimer(function() end,5000,1)
			addHouseLog("House ID:"..id.." (Price: $"..price..") (Owner:"..exports.server:getPlayerAccountName(source)..")")
		else
			exports.NGCdxmsg:createNewDxMessage(source,msg,255,0,0)
		end
	end
end)


--- function to set house password
addEvent("NGChousing.setHousePassword",true)
addEventHandler("NGChousing.setHousePassword",root,function(id, password)
	if not isOwner(source,id) then exports.NGCdxmsg:createNewDxMessage(source,"You are not the owner of this house!",255,0,0) return false end
	if (id and password) then
		local can,ms = exports.NGCmanagement:isPlayerLagging(source)
		if can then
			local theHouse = _G["house"..tostring( id )]
			exports.NGCdxmsg:createNewDxMessage(source,"Your house is now passworded with pass ("..password..")",255,0,0)
			setElementData(theHouse,"housepassword",tostring(password))
			setElementData(theHouse, "passwordlocked",1)
			exports.DENmysql:exec("UPDATE housing SET password=?,passwordlocked=? WHERE id=?",tonumber(password),1,id)
			onPlayerUpdateLabels(source,id)
		else
			exports.NGCdxmsg:createNewDxMessage(source,msg,255,0,0)
		end
	end
end)

local antiSaleSpam = {}
-- Function that toggle the house his sale status
addEvent( "setHouseToggleSale", true )
function toggleSale (houseid, doesForSale)
	if not isOwner(source,houseid) then exports.NGCdxmsg:createNewDxMessage(source,"You are not the owner of this house!",255,0,0) return false end
	local theHouse = _G["house"..tostring( houseid )]
	local houseSaleStatus = getElementData( theHouse, "housesale" )
	if houseSaleStatus then
		local can,ms = exports.NGCmanagement:isPlayerLagging(source)
		if can then
			if isTimer(antiSaleSpam[source]) then return false end
			antiSaleSpam[source] = setTimer(function() end,5000,1)
			if ( houseSaleStatus == 1 ) then
				setElementData( theHouse, "housesale", 0 )
				setPickupType( theHouse, 3, 1272, 0 )
				setElementData(theHouse,"houselocked",1)
				exports.DENmysql:exec("UPDATE housing SET locked=? WHERE id=?",1,houseid)
				exports.DENmysql:exec("UPDATE housing SET sale=? WHERE id=?",0,houseid)
				onPlayerUpdateLabels ( source, houseid )
			else
				setElementData( theHouse, "housesale", 1 )
				setPickupType( theHouse, 3, 1273, 0 )
				setElementData(theHouse,"houselocked",0)
				exports.DENmysql:exec("UPDATE housing SET locked=? WHERE id=?",0,houseid)
				exports.DENmysql:exec("UPDATE housing SET sale=? WHERE id=?",1,houseid)
				onPlayerUpdateLabels ( source, houseid )
			end
		else
			exports.NGCdxmsg:createNewDxMessage(source,msg,255,0,0)
		end
	end
end
addEventHandler( "setHouseToggleSale", root, toggleSale )


addEvent("saveHousingDecor",true)
addEventHandler("saveHousingDecor",root,function(player,whoData) --- get house ID triggered from client
	if quitDetect[source] == true then
		return false
	end
	local myDim = getElementDimension(player)
	if myDim ~= 0 then
		local playerdim = exports.DENmysql:querySingle( "SELECT * FROM housing WHERE id = ?",myDim)
		local ho_ = exports.DENmysql:querySingle( "SELECT * FROM accounts WHERE id = ?", tonumber(playerdim.ownerid) )
		if (ho_ and ho_.id) then
			if (ho_.id == exports.server:getPlayerAccountID(source)) or getElementData(source,"isPlayerPrime") == true then
				exports.DENmysql:exec("UPDATE housing SET housingDeco=? WHERE id=?",whoData,myDim)
				outputChatBox("Items saved in your house Good luck :)",player,255,255,0)
				local housing = exports.DENmysql:querySingle("SELECT * FROM housing WHERE id=?",myDim)
				if (housing and housing.id) then
					triggerClientEvent(source,"updateClientDecor",source,source,housing.housingDeco)
				end
			end
		end
	end
end)

--- function to handle the enter button
addEvent("enterHousing",true)
addEventHandler("enterHousing",root,function(houseid,interiorid) --- get house ID triggered from client
	local thisHouse = _G["house"..tostring(houseid)]
	local playerdim = exports.DENmysql:querySingle( "SELECT * FROM housing WHERE id = ?", houseid)
	local ho_ = exports.DENmysql:querySingle( "SELECT * FROM accounts WHERE id = ?", tonumber(playerdim.ownerid) )
	if playerdim then
		local x,y,z = getElementPosition(thisHouse)
		setElementData(source,"playerHouse",{x,y,z})
		local tableString = intids[tonumber(interiorid)]
		local tInt = gettok ( tableString, 1, string.byte('|') )
		local tX = gettok ( tableString, 2, string.byte('|') )
		local tY = gettok ( tableString, 3, string.byte('|') )
		local tZ = gettok ( tableString, 4, string.byte('|') )
		setElementInterior(source, tInt, tX, tY, tZ)
		setElementPosition(source, tX,tY,tZ)
		setElementDimension(source, tonumber(playerdim.id))
		setElementData(source,"isPlayerInHouse",true)
		triggerClientEvent(source,"closeAllHousing",source)
		triggerClientEvent(source,"updateClientDecor",source,source,playerdim.housingDeco)
		local ownerid = getElementData(thisHouse,"ownerid")
		triggerClientEvent(source,"NGChousing.dat_house_panel",source,source,tonumber(houseid),tonumber(playerdim.id),tInt,ownerid)

		if (ho_ and ho_.id) then
		else

		end
	end
end)

local buggedHouses = {}

function getPlayerMaxHouses ( thePlayer )
	if ( getElementData(thePlayer, "isPlayerVIP") ) then
		return 10
	else
		return 7
	end
end
--- function to buy the house while its forsale
addEvent("buyHouse",true)
addEventHandler("buyHouse",root,function(houseid)
	if quitDetect[source] == true then
		return false
	end
	local can,ms = exports.NGCmanagement:isPlayerLagging(source)
	if can then
		--if packetloss[source] then exports.NGCdxmsg:createNewDxMessage(source,"You're packet loss has reached the limit",255,0,0) return false end
		local thisHouse = _G["house"..tostring(houseid)]
		local ownerid = getElementData(thisHouse,"ownerid")
		local forsale = getElementData(thisHouse,"housesale")
		local price = getElementData(thisHouse,"houseprice")
		local playerID = exports.server:getPlayerAccountID(source)
		local maxHouses = getPlayerMaxHouses( source )
		if tonumber(ownerid) == exports.server:getPlayerAccountID(source) then return false end
		if tonumber(forsale) == 1 then
			local money = getPlayerMoney(source)
			if tonumber(money) >= tonumber(price) then
				if tonumber(price) < 5000 then table.insert(buggedHouses,houseid) return false end
				local getPlayerHouses = exports.DENmysql:query( "SELECT * FROM housing WHERE ownerid = ?",playerID)
				if ( getPlayerHouses and #getPlayerHouses > maxHouses ) then
					exports.NGCdxmsg:createNewDxMessage(source, "You can't have more then " .. maxHouses .. " houses!", 200, 0, 0)
					triggerClientEvent ( source, "destroyPickupData", source)
				else
					--if packetloss[source] then exports.NGCdxmsg:createNewDxMessage(source,"You're packet loss has reached the limit",255,0,0) return false end
					local theHouseOwnerBank = exports.DENmysql:querySingle( "SELECT * FROM banking WHERE userid = ?", tonumber(ownerid) )
					if theHouseOwnerBank then
						theHouseOwnerBalance = theHouseOwnerBank.balance
					else
						theHouseOwnerBalance = 0
					end
					if ( theHouseOwnerBalance ) then
						local theOwnerNewBalance = ( theHouseOwnerBalance + price )
						local theOwnerGiveMoney = exports.DENmysql:exec( "UPDATE banking SET balance=? WHERE userid=?", theOwnerNewBalance, tonumber(ownerid) )
						if ( theOwnerGiveMoney ) then
							for k,v in ipairs(getElementsByType("player")) do
								if exports.server:getPlayerAccountID(v) == tonumber(ownerid) then
									local dim = getElementDimension(v)
									if dim ~= 0 then
										triggerClientEvent(v,"updateClientHouse",v,dim)
									end
									triggerClientEvent(v,"closeAllHousing",v)
								end
							end
							addHouseLog("House ID:"..houseid.." (Bought for :$"..price..") (Owner:"..exports.server:getPlayerAccountName(source)..")")
							exports.NGCmanagement:RPM(source,price,"NGC Housing","Buy house")
							exports.DENmysql:exec("UPDATE housing SET sale=?,ownerid=?,boughtprice=?,houseprice=? WHERE id=?",0,exports.server:getPlayerAccountID(source),price,price,houseid)
							exports.NGCdxmsg:createNewDxMessage(source,"You have successfully bought house "..houseid.." for $"..price..", congratulations!",0,255,0)
							setElementData(thisHouse,"ownername",exports.server:getPlayerAccountName(source))
							setElementData(thisHouse,"ownerid",exports.server:getPlayerAccountID(source))
							setElementData(thisHouse,"boughtprice",price)
							setElementData(thisHouse,"housesale",0)
							setElementData(thisHouse,"houselocked",0)
							setPickupType( thisHouse, 3, 1272, 0 )
							onPlayerUpdateLabels ( source, houseid )
							onResetHouse(houseid)
							triggerClientEvent(source,"destroyPickupData",source)
							exports.CSGlogging:createLogRow ( source, "money", getPlayerName(source).." bought a house for $" .. price .. " (HOUSEID: " .. houseid .. ") (PREVIOUS OWNER: " .. ownerid .. ")" )
							local transaction = exports.DENmysql:exec( "INSERT INTO banking_transactions SET userid=?, transaction=?"
								,tonumber(ownerid)
								,"Your house was sold for $".. price .."" .. " to ".. getPlayerName(source) ..""
							)
							local myHouseList = getFormattedHouseListForPhone(source)
							triggerClientEvent(source,"CSGphone.recHouseList",source,myHouseList)
						end
					end
				end
			else
				exports.NGCdxmsg:createNewDxMessage(source,"You don't have enough money to buy this property",255,0,0)
			end
		else
			exports.NGCdxmsg:createNewDxMessage(source,"This house isn't forsale!",255,0,0)
		end
	else
		exports.NGCdxmsg:createNewDxMessage(source,"You can't buy this house while lagging!",255,0,0)
	end
end)
anti = {}
addEvent("NGChousing.sellToBank",true)
addEventHandler("NGChousing.sellToBank",root,function(houseid, thePricesellFor)
	if not isOwner(source,houseid) then exports.NGCdxmsg:createNewDxMessage(source,"You are not the owner of this house!",255,0,0) return false end
	if quitDetect[source] == true then
		return false
	end
	if isTimer(anti[source]) then return false end
	local can,ms = exports.NGCmanagement:isPlayerLagging(source)
	if can then
		local thisHouse = _G["house"..tostring(houseid)]
		local ownerid = getElementData(thisHouse,"ownerid")
		local forsale = getElementData(thisHouse,"housesale")
		local price = getElementData(thisHouse,"houseprice")
		if (not thePricesellFor) then return end
		local BankPrice = exports.DENmysql:querySingle("Select * FROM housing WHERE id=?",tonumber(houseid))
		local newPrice = BankPrice.originalPrice
		if tonumber(ownerid) == exports.server:getPlayerAccountID(source) then
			anti[source] = setTimer(function() end,5000,1)
			--if packetloss[source] then exports.NGCdxmsg:createNewDxMessage(source,"You're packet loss has reached the limit",255,0,0) return false end
			exports.NGCdxmsg:createNewDxMessage(source, "You have successfully sold your house to the bank for $"..tonumber(thePricesellFor),0,255,0)
			exports.NGCmanagement:GPM(source, thePricesellFor,"NGC Housing","Sell to bank")
			exports.DENmysql:exec("UPDATE housing SET sale=?,ownerid=?,houseprice=? WHERE id=?", 1, 0, newPrice, houseid)
			setElementData(thisHouse,"ownerid", 0)
			setElementData(thisHouse,"ownername","AURhousing")
			setElementData(thisHouse,"housesale",1)
			setElementData(thisHouse,"houselocked",0)
			setElementData(thisHouse,"houseprice",newPrice)
			setElementData(thisHouse,"boughtprice",newPrice)
			setPickupType( thisHouse, 3, 1273, 0 )
			onPlayerUpdateLabels ( source, houseid )
			onResetHouse(houseid)
			triggerClientEvent(source,"destroyPickupData",source)
			local myHouseList = getFormattedHouseListForPhone(source)
			triggerClientEvent(source,"CSGphone.recHouseList",source,myHouseList)
			addHouseLog("House ID:"..houseid.." (Sold to bank for :$"..thePricesellFor..") (Owner:"..exports.server:getPlayerAccountName(source)..")")
		else
			exports.NGCdxmsg:createNewDxMessage(source,"You are not the owner of this house!",255,0,0)
		end
	else
		exports.NGCdxmsg:createNewDxMessage(source,"You can't sell this house while lagging!",255,0,0)
	end
end)

function isPlayerInTeam(src, TeamName)
	if src and isElement ( src ) and getElementType ( src ) == "player" then
		local team = getPlayerTeam(src)
		if team then
			if getTeamName(team) == TeamName then
				return true
			else
				return false
			end
		end
	end
end

function outputServerRestriction(player,text11,text21,timer)
	triggerClientEvent(player,"OutputRestricted",root,text11,text21,timer)
end

-- This Function will result in kick player from the house by entering the cols
function onHousingColHit ( thePlayer )
	if thePlayer and getElementType(thePlayer) == "player" then
		local houseDimension = getElementDimension(thePlayer)
		local houseLocation = exports.DENmysql:querySingle( "SELECT * FROM housing WHERE id = ?", tonumber(houseDimension) )
		triggerClientEvent(thePlayer,"onPlayerLeaveHouse",thePlayer,houseDimension)
		setElementInterior(thePlayer, 0, houseLocation.x, houseLocation.y, houseLocation.z)
		setElementPosition(thePlayer, houseLocation.x,houseLocation.y,houseLocation.z)
		triggerClientEvent(thePlayer, "NGChousing.des_house_panel", thePlayer)
		setElementDimension(thePlayer, 0)
		setElementData(thePlayer,"isPlayerInHouse",false)
		setElementData(thePlayer,"playerHouse",false)
		local milicol = exports.AURrestrictedarea:getMilitaryColshape()
		if (isElementWithinColShape(thePlayer, milicol)) then
			if (((getElementData(thePlayer,"Group")) == "Military Forces") or ((getElementData(thePlayer,"MFbasePermission")) == true) or isPlayerInTeam(thePlayer,"Staff") or isPlayerInTeam(thePlayer,"Military Forces")) then return end
				if( isPlayerInTeam(thePlayer,"Government")) then
					campTime = 10
					outputServerRestriction(thePlayer,"Res1","Res2",campTime)
				else
					campTime = 30
					outputServerRestriction(thePlayer,"Res1","Res2",campTime)
				end
				CampingPlayersTimer[thePlayer] = setTimer( function ()
				for k,v in ipairs(getElementsByType("player")) do
					if isPlayerInTeam(v, "Military Forces") then
						exports.killmessages:outputMessage("ATTENTION : > "..getPlayerName(thePlayer).." has been killed due of camping at Military Base!", v, 250, 0, 0,"default-bold")
					end
				end
				killPed ( thePlayer, thePlayer )
			end , campTime*1000, 1  )
		end
	end
end

addEvent("onPlayerJailed",true)
addEventHandler("onPlayerJailed",root,function()
	if getElementDimension(source) ~= 0 then
		triggerClientEvent(source,"onPlayerLeaveHouse",source,getElementDimension(source))
		triggerClientEvent(source,"closeAllHousing",source)
		setElementData(source,"isPlayerInHouse",false)
	end
end)

function getFormattedHouseListForPhone(p)
	local t = {}
		local id = exports.server:getPlayerAccountID(p)
		local hT = exports.DENmysql:query( "SELECT * FROM housing WHERE ownerid = ?", id)
		for k,v in pairs(hT) do
			local x,y,z = v.x,v.y,v.z
			local zoneName = getZoneName(x,y,z)
			local theHouseT = {v.id,""..(v.housename.." @ "..zoneName.."").."",false,x,y,z}
			table.insert(t,theHouseT)
		end
	return t
end

setTimer(function()
for k,v in pairs(getElementsByType("player")) do
	local myHouseList = getFormattedHouseListForPhone(v)
	triggerClientEvent(v,"CSGphone.recHouseList",v,myHouseList)
end
end,10000,1)


addEventHandler("onServerPlayerLogin",root,function()
	setTimer(function(p)
		local myHouseList = getFormattedHouseListForPhone(p)
		if exports.server:isPlayerLoggedIn(p) then
		triggerClientEvent(p,"CSGphone.recHouseList",p,myHouseList)
		end
	end,5000,1,source)
end)

-- Create the leaving markers inside all ints
for i=1,#leavingCols do
	local x, y, z = leavingCols[i][2], leavingCols[i][3], leavingCols[i][4]
	local interior = leavingCols[i][1]
	colCircle = createColTube ( x, y, z -0.5, 1.3, 2.5 )
	setElementInterior (colCircle, interior)
	addEventHandler ( "onColShapeHit", colCircle, onHousingColHit )
end


function house_create_music(x, y, z, int, dim, url)
	if (isElement(houseObject[client])) then exports.NGCdxmsg:createNewDxMessage(client, "Please stop your old song before starting a new one!",255,0,0) return end
	houseObject[client] = createObject(2229, x, y+2, z-1)
	setElementInterior(houseObject[client], int)
	setElementDimension(houseObject[client], dim)
	triggerClientEvent(root, "NGChousing.play_house_sound", root, x, y, z, int, dim, url)
end
addEvent("NGChousing.house_create_music", true)
addEventHandler("NGChousing.house_create_music", root, house_create_music)

function remove_house_speaker(owner)
	if (isElement(houseObject[owner])) then
		destroyElement(houseObject[owner])
		triggerClientEvent(root, "NGChousing.stop_house_sound", root,owner)
		triggerClientEvent(owner, "NGChousing.stop_house_sound2", owner,owner)
	end
end
addEvent("NGChousing.remove_house_speaker", true)
addEventHandler("NGChousing.remove_house_speaker", root, remove_house_speaker)

function getHouseMoney(houseid)
	local t = exports.DENmysql:querySingle("SELECT * FROM housing WHERE id=?",tonumber(houseid))
	if t then
		triggerClientEvent(source,"NGChousing.setBalanceLable",source,t.balance)
	end
end
addEvent("NGChousing.getHouseMoney", true)
addEventHandler("NGChousing.getHouseMoney", root, getHouseMoney)


function setHouseMoney(player,howmuch)
	if isTimer(antiBug[source]) then exports.NGCdxmsg:createNewDxMessage(source,"Please wait few seconds",255,0,0) return false end
	if quitDetect[source] == true then
		return false
	end
	local can,ms = exports.NGCmanagement:isPlayerLagging(source)
	if not can then exports.NGCdxmsg:createNewDxMessage(source,"You can't do this at the moment due lag detected!",255,0,0) return false end
	if howmuch and tonumber(howmuch) and tonumber(howmuch) > 0 then
		if getPlayerMoney(source) >= tonumber(howmuch) then
			if quitDetect[source] == true then
				addHouseLog("House ID:"..houseid.." (ABUSING deposit money) (Owner:"..exports.server:getPlayerAccountName(source)..")")
				return false
			end
			--if packetloss[source] then exports.NGCdxmsg:createNewDxMessage(source,"You're packet loss has reached the limit",255,0,0) return false end
			local user = exports.server:getPlayerAccountName(source)
			local name = getPlayerName(source)
			local houseid = getElementDimension(source)
			exports.NGCmanagement:RPM(source,tonumber(howmuch),"NGC Housing","Deposit money to inventory")
			local t = exports.DENmysql:querySingle("SELECT * FROM housing WHERE id=?",houseid)
			local defaultbalance = t.balance or 0
			exports.DENmysql:exec("UPDATE housing SET balance=? WHERE id=?",tonumber(defaultbalance)+tonumber(howmuch),tonumber(houseid))
			---local moneyT = fromJSON(t.moneyStorage)
			--table.insert(moneyT,2,{""..user.."("..name..")","Deposit","$"..tonumber(howmuch).."",exports.CSGpriyenmisc:getTimeStampYYYYMMDD()}) --exports.CSGpriyenmisc:getTimeStampYYYYMMDD()
			---local ts = toJSON(moneyT)
			---exports.DENmysql:exec("UPDATE housing SET moneyStorage=? WHERE id=?",ts,tonumber(houseid))
			addHouseLog("House ID:"..houseid.." (Deposit :$"..howmuch..") (Owner:"..exports.server:getPlayerAccountName(source)..")")
			exports.NGCdxmsg:createNewDxMessage(source,"Successfully Deposit $ "..exports.server:convertNumber(tonumber(howmuch)),0,255,0)
			local xd = exports.DENmysql:querySingle("SELECT * FROM housing WHERE id=?",houseid)
			triggerClientEvent(source,"NGChousing.setBalanceLable",source,xd.balance)
			antiBug[source] = setTimer(function(p)
			end,5000,1,source)
		else
			exports.NGCdxmsg:createNewDxMessage(source,"You don't have this much money",255,0,0)
			antiBug[source] = setTimer(function(p)
			end,5000,1,source)
		end
	else
		antiBug[source] = setTimer(function(p)
		end,5000,1,source)
	end
end
addEvent("NGChousing.setHouseMoney", true)
addEventHandler("NGChousing.setHouseMoney", root, setHouseMoney)



function takeHouseMoney(player,howmuch)
	if isTimer(antiBug[source]) then exports.NGCdxmsg:createNewDxMessage(source,"Please wait few seconds",255,0,0) return false end
	if quitDetect[source] == true then
		return false
	end
	local can,ms = exports.NGCmanagement:isPlayerLagging(source)
	if not can then exports.NGCdxmsg:createNewDxMessage(source,"You can't do this at the moment due lag detected!",255,0,0) return false end
	local user = exports.server:getPlayerAccountName(source)
	local name = getPlayerName(source)
	local houseid = getElementDimension(source)
	local t = exports.DENmysql:querySingle("SELECT * FROM housing WHERE id=?",houseid)
	local defaultbalance = t.balance or 0
	if tonumber(defaultbalance) >= tonumber(howmuch) then
		if quitDetect[source] == true then
			addHouseLog("House ID:"..houseid.." (ABUSING withdraw money) (Owner:"..exports.server:getPlayerAccountName(source)..")")
			return false
		end
		--if packetloss[source] then exports.NGCdxmsg:createNewDxMessage(source,"You're packet loss has reached the limit",255,0,0) return false end
		exports.DENmysql:exec("UPDATE housing SET balance=? WHERE id=?",tonumber(defaultbalance)-tonumber(howmuch),tonumber(houseid))
		exports.NGCmanagement:GPM(source,tonumber(howmuch),"NGC Housing","Withdraw from inventory")
		---local moneyT = fromJSON(t.moneyStorage)
		--table.insert(moneyT,2,{""..user.."("..name..")","Withdraw","$"..tonumber(howmuch).."",exports.CSGpriyenmisc:getTimeStampYYYYMMDD()}) --exports.CSGpriyenmisc:getTimeStampYYYYMMDD()
		--local ts = toJSON(moneyT)
		--exports.DENmysql:exec("UPDATE housing SET moneyStorage=? WHERE id=?",ts,tonumber(houseid))
		addHouseLog("House ID:"..houseid.." (Withdraw :$"..howmuch..") (Owner:"..exports.server:getPlayerAccountName(source)..")")
		exports.NGCdxmsg:createNewDxMessage(source,"Successfully withdraw $ "..exports.server:convertNumber(tonumber(howmuch)),0,255,0)
		local xd = exports.DENmysql:querySingle("SELECT * FROM housing WHERE id=?",houseid)
		triggerClientEvent(source,"NGChousing.setBalanceLable",source,xd.balance)
		antiBug[source] = setTimer(function(p)
		end,5000,1,source)
	else
		exports.NGCdxmsg:createNewDxMessage(source,"Your house storage doesn't have this amount of money",255,0,0)
		antiBug[source] = setTimer(function(p)
		end,5000,1,source)
	end
end
addEvent("NGChousing.takeHouseMoney", true)
addEventHandler("NGChousing.takeHouseMoney", root, takeHouseMoney)

function sendHouseWeapons()
	local houseid = getElementDimension(source)
	local t = exports.DENmysql:querySingle("SELECT * FROM housing WHERE id=?",houseid)
	if t then
		triggerClientEvent(source,"NGChousing.synceWeapons",source,source,1,t.slot1)
		triggerClientEvent(source,"NGChousing.synceWeapons",source,source,2,t.slot2)
		triggerClientEvent(source,"NGChousing.synceWeapons",source,source,3,t.slot3)
		triggerClientEvent(source,"NGChousing.synceWeapons",source,source,4,t.slot4)
	end
end
addEvent("NGChousing.sendHouseWeapons", true)
addEventHandler("NGChousing.sendHouseWeapons", root, sendHouseWeapons)


function canWeapon(houseWeapon,wepID)
	if(gettok(houseWeapon, 1, ",")) then
		if tonumber(houseWeapon) ~= 0 then
			local sexyweapon,sexyammo = gettok(houseWeapon, 1, ","), gettok(houseWeapon, 2, ",")
			if tonumber(sexyweapon) == tonumber(wepID) then
				exports.NGCdxmsg:createNewDxMessage(source,"You already have ammo for this weapon type!",255,0,0)
				antiBug[source] = setTimer(function(p)
				end,5000,1,source)
				return false
			end
		else
			antiBug[source] = setTimer(function(p)
			end,5000,1,source)
		end
	else
		antiBug[source] = setTimer(function(p)
		end,5000,1,source)
	end
	return true
end

function addHouseWeapon(wepID,clipAmount,weapons)
	if isTimer(antiBug[source]) then exports.NGCdxmsg:createNewDxMessage(source,"Please wait few seconds",255,0,0) return false end
	if quitDetect[source] == true then
		return false
	end
	local houseid = getElementDimension(source)
	local can,ms = exports.NGCmanagement:isPlayerLagging(source)
	if not can then exports.NGCdxmsg:createNewDxMessage(source,"You can't do this at the moment due lag detected!",255,0,0) return false end
	if weapons then
		if weapons == 1 then
			local house = exports.DENmysql:querySingle("SELECT * FROM housing WHERE id=?",houseid)
			if house then
				local weap = house.slot1
				if tonumber(weap) ~= 0 then
					exports.NGCdxmsg:createNewDxMessage(source,"There is already weapon in this slot",255,0,0)
				else
					if not canWeapon(house.slot2,wepID) then return false end
					if not canWeapon(house.slot3,wepID) then return false end
					if not canWeapon(house.slot4,wepID) then return false end
					--if packetloss[source] then exports.NGCdxmsg:createNewDxMessage(source,"You're packet loss has reached the limit",255,0,0) return false end
					weap = wepID..", "..clipAmount
					exports.NGCdxmsg:createNewDxMessage(source,"You sucessfull deposit your weapon "..getWeaponNameFromID(wepID).." into your weaponbox!",0, 255, 0)
					---exports.DENmysql:exec("UPDATE housing SET weaponsStorage=? WHERE id=?",weap,houseid)
					takeWeapon(source,tonumber(wepID),clipAmount)
					exports.CSGaccounts:forceWeaponSync(source)
					addHouseLog("House ID:"..houseid.." (Slot1 :"..weap..") (Owner:"..exports.server:getPlayerAccountName(source)..")")
					if quitDetect[source] == true then
						addHouseLog("House ID:"..houseid.." (ABUSING) (Owner:"..exports.server:getPlayerAccountName(source)..")")
						return false
					end
					exports.DENmysql:exec("UPDATE housing SET slot1=? WHERE id=?",weap,houseid)
					triggerClientEvent(source,"NGChousing.synceWeapons",source,source,1,weap)
				end
			end
			antiBug[source] = setTimer(function(p)
			end,5000,1,source)
		elseif weapons == 2 then
			local house = exports.DENmysql:querySingle("SELECT * FROM housing WHERE id=?",houseid)
			if house then
				local weap = house.slot2
				if tonumber(weap) ~= 0 then
					exports.NGCdxmsg:createNewDxMessage(source,"There is already weapon in this slot",255,0,0)
				else
					if not canWeapon(house.slot1,wepID) then return false end
					if not canWeapon(house.slot3,wepID) then return false end
					if not canWeapon(house.slot4,wepID) then return false end
					--if packetloss[source] then exports.NGCdxmsg:createNewDxMessage(source,"You're packet loss has reached the limit",255,0,0) return false end
					weap = wepID..", "..clipAmount
					exports.NGCdxmsg:createNewDxMessage(source,"You sucessfull deposit your weapon "..getWeaponNameFromID(wepID).." into your weaponbox!",0, 255, 0)
					takeWeapon(source,tonumber(wepID),clipAmount)
					exports.CSGaccounts:forceWeaponSync(source)
					addHouseLog("House ID:"..houseid.." (Slot2 :"..weap..") (Owner:"..exports.server:getPlayerAccountName(source)..")")
					if quitDetect[source] == true then
						addHouseLog("House ID:"..houseid.." (ABUSING) (Owner:"..exports.server:getPlayerAccountName(source)..")")
						return false
					end
					exports.DENmysql:exec("UPDATE housing SET slot2=? WHERE id=?",weap,houseid)
					triggerClientEvent(source,"NGChousing.synceWeapons",source,source,2,weap)
				end
			end
			antiBug[source] = setTimer(function(p)
			end,5000,1,source)
		elseif weapons == 3 then
			local house = exports.DENmysql:querySingle("SELECT * FROM housing WHERE id=?",houseid)
			if house then
				local weap = house.slot3
				if tonumber(weap) ~= 0 then
					exports.NGCdxmsg:createNewDxMessage(source,"There is already weapon in this slot",255,0,0)
				else
					if not canWeapon(house.slot1,wepID) then return false end
					if not canWeapon(house.slot2,wepID) then return false end
					if not canWeapon(house.slot4,wepID) then return false end
					--if packetloss[source] then exports.NGCdxmsg:createNewDxMessage(source,"You're packet loss has reached the limit",255,0,0) return false end
					weap = wepID..", "..clipAmount
					exports.NGCdxmsg:createNewDxMessage(source,"You sucessfull deposit your weapon "..getWeaponNameFromID(wepID).." into your weaponbox!",0, 255, 0)
					takeWeapon(source,tonumber(wepID),clipAmount)
					exports.CSGaccounts:forceWeaponSync(source)
					if quitDetect[source] == true then
						addHouseLog("House ID:"..houseid.." (ABUSING) (Owner:"..exports.server:getPlayerAccountName(source)..")")
						return false
					end
					addHouseLog("House ID:"..houseid.." (Slot3 :"..weap..") (Owner:"..exports.server:getPlayerAccountName(source)..")")
					exports.DENmysql:exec("UPDATE housing SET slot3=? WHERE id=?",weap,houseid)
					triggerClientEvent(source,"NGChousing.synceWeapons",source,source,3,weap)
				end
			end
			antiBug[source] = setTimer(function(p)
			end,5000,1,source)
		elseif weapons == 4 then
			local house = exports.DENmysql:querySingle("SELECT * FROM housing WHERE id=?",houseid)
			if house then
				local weap = house.slot4
				if tonumber(weap) ~= 0 then
					exports.NGCdxmsg:createNewDxMessage(source,"There is already weapon in this slot",255,0,0)
				else
					if not canWeapon(house.slot1,wepID) then return false end
					if not canWeapon(house.slot2,wepID) then return false end
					if not canWeapon(house.slot3,wepID) then return false end
					--if packetloss[source] then exports.NGCdxmsg:createNewDxMessage(source,"You're packet loss has reached the limit",255,0,0) return false end
					weap = wepID..", "..clipAmount
					exports.NGCdxmsg:createNewDxMessage(source,"You sucessfull deposit your weapon "..getWeaponNameFromID(wepID).." into your weaponbox!",0, 255, 0)
					takeWeapon(source,tonumber(wepID),clipAmount)
					addHouseLog("House ID:"..houseid.." (Slot4 :"..weap..") (Owner:"..exports.server:getPlayerAccountName(source)..")")
					if quitDetect[source] == true then
						addHouseLog("House ID:"..houseid.." (ABUSING) (Owner:"..exports.server:getPlayerAccountName(source)..")")
						return false
					end
					exports.DENmysql:exec("UPDATE housing SET slot4=? WHERE id=?",weap,houseid)
					triggerClientEvent(source,"NGChousing.synceWeapons",source,source,4,weap)
					exports.CSGaccounts:forceWeaponSync(source)
				end
			end
			antiBug[source] = setTimer(function(p)
			end,5000,1,source)
		end
	else
		exports.NGCdxmsg:createNewDxMessage(source,"Error: No lost found",255,0,0)
	end
end
addEvent("NGChousing.addHouseWeapon", true)
addEventHandler("NGChousing.addHouseWeapon", root,addHouseWeapon)

function takeHouseWeapon(value)
	if isTimer(antiBug[source]) then exports.NGCdxmsg:createNewDxMessage(source,"Please wait few seconds",255,0,0) return false end
	if quitDetect[source] == true then
		return false
	end
	local houseid = getElementDimension(source)
	local can,ms = exports.NGCmanagement:isPlayerLagging(source)
	if not can then exports.NGCdxmsg:createNewDxMessage(source,"You can't do this at the moment due lag detected!",255,0,0) return false end
	if value == 1 then
		local house = exports.DENmysql:querySingle("SELECT * FROM housing WHERE id=?",houseid)
		local weapons = house.slot1
		if(gettok(weapons, 1, ",")) then
			if tonumber(weapons) ~= 0 then
				if quitDetect[source] == true then
					addHouseLog("House ID:"..houseid.." (ABUSING withdraw weapons) (Owner:"..exports.server:getPlayerAccountName(source)..")")
					return false
				end
				--if packetloss[source] then exports.NGCdxmsg:createNewDxMessage(source,"You're packet loss has reached the limit",255,0,0) return false end
				local weapon, ammo = gettok(weapons, 1, ","), gettok(weapons, 2, ",")
				local weaponSlot = getSlotFromWeapon ( weapon )
				local playerAmmo = getPedTotalAmmo(source,weaponSlot)
				local total = tonumber(ammo) + playerAmmo
				if tonumber(total) and tonumber(total) > 9000 then
					exports.NGCnote:addNote("House ammo","You can't have more than 9000 ammo",source,255,0,0,5000)
					return false
				end
				giveWeapon(source, weapon, ammo, true)
				exports.NGCdxmsg:createNewDxMessage("You sucessfull withdraw your weapon slot "..value.."!", 0, 255, 0)
				weapons = 0
				addHouseLog("House ID:"..houseid.." (Withdraw Slot1 :"..weapon.."|"..ammo..") (Owner:"..exports.server:getPlayerAccountName(source)..")")
				exports.DENmysql:exec("UPDATE housing SET slot1=? WHERE id=?",0,houseid)
				triggerClientEvent(source,"NGChousing.synceWeapons",source,source,1,0)
				exports.CSGaccounts:forceWeaponSync(source)
			else
				exports.NGCdxmsg:createNewDxMessage(source,"This slot it's empty",255,0,0)
			end
		end
		antiBug[source] = setTimer(function(p)
		end,5000,1,source)
	elseif value == 2 then
		local house = exports.DENmysql:querySingle("SELECT * FROM housing WHERE id=?",houseid)
		local weapons = house.slot2
		if(gettok(weapons, 1, ",")) then
			if tonumber(weapons) ~= 0 then
				if quitDetect[source] == true then
					addHouseLog("House ID:"..houseid.." (ABUSING withdraw weapons) (Owner:"..exports.server:getPlayerAccountName(source)..")")
					return false
				end
				--if packetloss[source] then exports.NGCdxmsg:createNewDxMessage(source,"You're packet loss has reached the limit",255,0,0) return false end
				local weapon, ammo = gettok(weapons, 1, ","), gettok(weapons, 2, ",")
				local weaponSlot = getSlotFromWeapon ( weapon )
				local playerAmmo = getPedTotalAmmo(source,weaponSlot)
				local total = tonumber(ammo) + playerAmmo
				if tonumber(total) and tonumber(total) > 9000 then
					exports.NGCnote:addNote("House ammo","You can't have more than 9000 ammo",source,255,0,0,5000)
					return false
				end
				giveWeapon(source, weapon, ammo, true)
				exports.NGCdxmsg:createNewDxMessage("You sucessfull withdraw your weapon slot "..value.."!", 0, 255, 0)
				weapons = 0
				addHouseLog("House ID:"..houseid.." (Withdraw Slot2 :"..weapon.."|"..ammo..") (Owner:"..exports.server:getPlayerAccountName(source)..")")
				exports.DENmysql:exec("UPDATE housing SET slot2=? WHERE id=?",0,houseid)
				triggerClientEvent(source,"NGChousing.synceWeapons",source,source,2,0)
				exports.CSGaccounts:forceWeaponSync(source)
			else
				exports.NGCdxmsg:createNewDxMessage(source,"This slot it's empty",255,0,0)
			end
		end
		antiBug[source] = setTimer(function(p)
		end,5000,1,source)
	elseif value == 3 then
		local house = exports.DENmysql:querySingle("SELECT * FROM housing WHERE id=?",houseid)
		local weapons = house.slot3
		if(gettok(weapons, 1, ",")) then
			if tonumber(weapons) ~= 0 then
				if quitDetect[source] == true then
					addHouseLog("House ID:"..houseid.." (ABUSING withdraw weapons) (Owner:"..exports.server:getPlayerAccountName(source)..")")
					return false
				end
				--if packetloss[source] then exports.NGCdxmsg:createNewDxMessage(source,"You're packet loss has reached the limit",255,0,0) return false end
				local weapon, ammo = gettok(weapons, 1, ","), gettok(weapons, 2, ",")
				local weaponSlot = getSlotFromWeapon ( weapon )
				local playerAmmo = getPedTotalAmmo(source,weaponSlot)
				local total = tonumber(ammo) + playerAmmo
				if tonumber(total) and tonumber(total) > 9000 then
					exports.NGCnote:addNote("House ammo","You can't have more than 9000 ammo",source,255,0,0,5000)
					return false
				end
				giveWeapon(source, weapon, ammo, true)
				exports.NGCdxmsg:createNewDxMessage("You sucessfull withdraw your weapon slot "..value.."!", 0, 255, 0)
				weapons = 0
				addHouseLog("House ID:"..houseid.." (Withdraw Slot3 :"..weapon.."|"..ammo..") (Owner:"..exports.server:getPlayerAccountName(source)..")")
				exports.DENmysql:exec("UPDATE housing SET slot3=? WHERE id=?",0,houseid)
				triggerClientEvent(source,"NGChousing.synceWeapons",source,source,3,0)
				exports.CSGaccounts:forceWeaponSync(source)
			else
				exports.NGCdxmsg:createNewDxMessage(source,"This slot it's empty",255,0,0)
			end
		end
		antiBug[source] = setTimer(function(p)
		end,5000,1,source)
	elseif value == 4 then
		local house = exports.DENmysql:querySingle("SELECT * FROM housing WHERE id=?",houseid)
		local weapons = house.slot4
		if(gettok(weapons, 1, ",")) then
			if tonumber(weapons) ~= 0 then
				if quitDetect[source] == true then
					addHouseLog("House ID:"..houseid.." (ABUSING withdraw weapons) (Owner:"..exports.server:getPlayerAccountName(source)..")")
					return false
				end
				--if packetloss[source] then exports.NGCdxmsg:createNewDxMessage(source,"You're packet loss has reached the limit",255,0,0) return false end
				local weapon, ammo = gettok(weapons, 1, ","), gettok(weapons, 2, ",")
				local weaponSlot = getSlotFromWeapon ( weapon )
				local playerAmmo = getPedTotalAmmo(source,weaponSlot)
				local total = tonumber(ammo) + playerAmmo
				if tonumber(total) and tonumber(total) > 9000 then
					exports.NGCnote:addNote("House ammo","You can't have more than 9000 ammo",source,255,0,0,5000)
					return false
				end
				giveWeapon(source, weapon, ammo, true)
				exports.NGCdxmsg:createNewDxMessage("You sucessfull withdraw your weapon slot "..value.."!", 0, 255, 0)
				weapons = 0
				addHouseLog("House ID:"..houseid.." (Withdraw Slot4 :"..weapon.."|"..ammo..") (Owner:"..exports.server:getPlayerAccountName(source)..")")
				exports.DENmysql:exec("UPDATE housing SET slot4=? WHERE id=?",0,houseid)
				triggerClientEvent(source,"NGChousing.synceWeapons",source,source,4,0)
				exports.CSGaccounts:forceWeaponSync(source)
			else
				exports.NGCdxmsg:createNewDxMessage(source,"This slot it's empty",255,0,0)
			end
		end
		antiBug[source] = setTimer(function(p)
		end,5000,1,source)
	end
end
addEvent("NGChousing.takeHouseWeapon", true)
addEventHandler("NGChousing.takeHouseWeapon", root,takeHouseWeapon)
local antiSpam = {}
local antiSpam2 = {}
function addHouseDrug(drugname,drugamount)
	if antiSpam[source] == true then return false end
	if isTimer(antiBug[source]) then exports.NGCdxmsg:createNewDxMessage(source,"Please wait few seconds",255,0,0) return false end
	if quitDetect[source] == true then
		return false
	end
	--if packetloss[source] then exports.NGCdxmsg:createNewDxMessage(source,"You're packet loss has reached the limit",255,0,0) return false end
	local can,ms = exports.NGCmanagement:isPlayerLagging(source)
	if not can then exports.NGCdxmsg:createNewDxMessage(source,"You can't do this at the moment due lag detected!",255,0,0) return false end
	exports.CSGdrugs:takeDrug(source,drugname,drugamount)
	local houseid = getElementDimension(source)
	local t = exports.DENmysql:querySingle("SELECT * FROM housing WHERE id=?",houseid)
	local drugsTable = t.drugsStorage
	local houseDrugs = fromJSON(drugsTable)
	if houseDrugs[drugname] == nil then houseDrugs[drugname]=0 end
	antiSpam[source] = true
	houseDrugs[drugname] = houseDrugs[drugname]+drugamount
	if quitDetect[source] == true then
		addHouseLog("House ID:"..houseid.." (ABUSING deposit drugs) (Owner:"..exports.server:getPlayerAccountName(source)..")")
		return false
	end
	--if packetloss[source] then exports.NGCdxmsg:createNewDxMessage(source,"You're packet loss has reached the limit",255,0,0) return false end
	exports.DENmysql:exec("UPDATE housing SET drugsStorage=? WHERE id=?",toJSON(houseDrugs),tonumber(houseid))
	local dr = exports.DENmysql:querySingle("SELECT * FROM housing WHERE id=?",houseid)
	antiBug[source] = setTimer(function(p,dr)
	end,5000,1,source,dr.drugsStorage)
	addHouseLog("House ID:"..houseid.." (Deposit Drugs :"..drugname.."|"..drugamount..") (Owner:"..exports.server:getPlayerAccountName(source)..")")
	exports.NGCdxmsg:createNewDxMessage(source,"Successfully Deposit drugs",0,255,0)
end
addEvent("NGChousing.addHouseDrug", true)
addEventHandler("NGChousing.addHouseDrug", root,addHouseDrug)


function takeHouseDrug(drugname,drugamount,houseamount)
	if antiSpam2[source] == true then return false end
	if isTimer(antiBug[source]) then exports.NGCdxmsg:createNewDxMessage(source,"Please wait few seconds",255,0,0) return false end
	if quitDetect[source] == true then
		return false
	end
	--if packetloss[source] then exports.NGCdxmsg:createNewDxMessage(source,"You're packet loss has reached the limit",255,0,0) return false end
	local can,ms = exports.NGCmanagement:isPlayerLagging(source)
	if not can then exports.NGCdxmsg:createNewDxMessage(source,"You can't do this at the moment due lag detected!",255,0,0) return false end
	local houseid = getElementDimension(source)
	local t = exports.DENmysql:querySingle("SELECT * FROM housing WHERE id=?",houseid)
	local drugsTable = t.drugsStorage
	local houseDrugs = fromJSON(drugsTable)
	if houseDrugs[drugname] == nil then houseDrugs[drugname]=0 end
	if houseDrugs[drugname] == 0 then exports.NGCdxmsg:createNewDxMessage(source,"This house doesn't have this amount!",255,0,0) return false end
	if houseamount == 0 then exports.NGCdxmsg:createNewDxMessage(source,"This house doesn't have this amount!",255,0,0) return false end
	if houseDrugs[drugname] == houseamount then
		antiSpam[source] = true
		houseDrugs[drugname] = houseDrugs[drugname]-drugamount
		local ts = toJSON(houseDrugs)
		if quitDetect[source] == true then
			addHouseLog("House ID:"..houseid.." (ABUSING withdraw drugs) (Owner:"..exports.server:getPlayerAccountName(source)..")")
			return false
		end
		--if packetloss[source] then exports.NGCdxmsg:createNewDxMessage(source,"You're packet loss has reached the limit",255,0,0) return false end
		exports.DENmysql:exec("UPDATE housing SET drugsStorage=? WHERE id=?",ts,tonumber(houseid))
		local dr = exports.DENmysql:querySingle("SELECT * FROM housing WHERE id=?",houseid)
		triggerClientEvent(source,"NGChousing.synceDrugs",source,source,dr.drugsStorage)
		addHouseLog("House ID:"..houseid.." (Withdraw Drugs :"..drugname.."|"..drugamount..") (Owner:"..exports.server:getPlayerAccountName(source)..")")
		exports.CSGdrugs:giveDrug(source,drugname,drugamount)
	else
		exports.NGCdxmsg:createNewDxMessage(source,"This house doesn't have this amount!",255,0,0)
	end
	antiBug[source] = setTimer(function(p)
	end,5000,1,source)
end
addEvent("NGChousing.takeHouseDrug", true)
addEventHandler("NGChousing.takeHouseDrug", root,takeHouseDrug)


function sendHouseDrugs()
	local houseid = getElementDimension(source)
	local t = exports.DENmysql:querySingle("SELECT * FROM housing WHERE id=?",houseid)
	if t then
		triggerClientEvent(source,"NGChousing.synceDrugs",source,source,t.drugsStorage)
	end
end
addEvent("NGChousing.sendHouseDrugs", true)
addEventHandler("NGChousing.sendHouseDrugs", root,sendHouseDrugs)
gay = {}
function disableMiscPrev(houseid)
	if (not houseid) then return end
	local w = theTable
	for k,v in ipairs(w) do
		if v.id == houseid and v.owner == exports.server:getPlayerAccountID(source) then
			table.remove(w,k)
			handled[houseid] = false
		end
	end
end
addEvent("NGChousing.disableMiscPrev", true)
addEventHandler("NGChousing.disableMiscPrev", root, disableMiscPrev)

function canID(player,houseid)
	handled[houseid] = true
	for k,v in ipairs(theTable) do
		if v.id == houseid and v.owner == exports.server:getPlayerAccountID(player) then
			handled[houseid] = true
			return false
		elseif v.id == houseid and v.owner ~= exports.server:getPlayerAccountID(player) then
			exports.NGCdxmsg:createNewDxMessage(player,"This house is being operated by another player, please wait.", 255,0,0)
			handled[houseid] = false
			return false
		elseif v.id == nil then
			handled[houseid] = true
			return true
		else
			handled[houseid] = true
			return true
		end
	end
end

function houseMiscPrev(houseid)
	if (not houseid) then return end
	canID(source,houseid)
	if handled[houseid] then
		table.insert(theTable,{id=houseid,owner=exports.server:getPlayerAccountID(source)})
		triggerClientEvent(source, "NGChousing.continueDatPrev", source, houseid)
	else
		exports.NGCdxmsg:createNewDxMessage(source,"This house is being operated by another player, please wait.", 255,0,0)
	end
end
addEvent("NGChousing.houseMiscPrev", true)
addEventHandler("NGChousing.houseMiscPrev", root, houseMiscPrev)



-- Create part for housing system
addEvent( "createTheNewHouse", true )
function createTheNewHouse (int, price, name)
	if ( int ) and ( price ) and ( name ) then
	local madeBy = getPlayerName(source)
	local x, y, z = getElementPosition (source)
	local drugT = fromJSON('[ { "1": 0, "8": 0, "3": 0, "2": 0, "5": 0, "4": 0, "7": 0, "6": 0 } ]')
	local drugsStorage = toJSON(drugT)
	local makeHouse = exports.DENmysql:exec("INSERT INTO housing SET sale=?, locked=?, housename=?, x=?, y=?, z=?, interiorid=?, houseprice=?,originalPrice=?,boughtprice=?, createdBy=?,slot1=?,slot2=?,slot3=?,slot4=?,drugsStorage=?,balance=?,password=?,passwordlocked=?,ownerid=?,moneyStorage=?,houseDeco=?"
			,1 ---- sale
			,0 ---- locked
			,name ---- street name
			,x ----x
			,y ----y
			,z ----z
			,int ---int
			,price --- price
			,price --- price
			,price --- price
			,madeBy---mapper
			,0---wep1
			,0---wep2
			,0---wep3
			,0---wep4
			,drugsStorage --- drugs
			,0--- balance
			,0--- pass
			,0--- pass
			,0--- owner id
			,"[ [ 0, [ ] ] ]" --Money Storage
			," " --House Deco
		)
		outputChatBox ("House created and putted into the database :)", source, 0, 225, 0)
		createPickup ( x, y, z, 3, 1277, 0)
	else
		outputChatBox ("Something is wrong, please check the fields!", source, 225, 225, 0)
	end
end
addEventHandler( "createTheNewHouse", root, createTheNewHouse )


--- Edit part for the housing system
function getTheHouseInfo ( houseid )
local houseinfo = exports.DENmysql:querySingle( "SELECT * FROM housing WHERE id = ?", houseid )
	if ( houseinfo ) then
		triggerClientEvent ( source, "updateEditGUI", source, houseinfo.interiorid, houseinfo.houseprice, houseinfo.housename )
	else
		outputChatBox("The ID of the house you enterd is wrong!", source, 225, 0, 0)
	end
end
addEvent( "getTheHouseInfo", true )
addEventHandler( "getTheHouseInfo", root, getTheHouseInfo )


addEvent( "doEditTheHouse", true )
function doEditTheHouse (int, price, street, houseID)
	local houseinfo = exports.DENmysql:querySingle( "SELECT * FROM housing WHERE id = ?", houseID )
	if ( houseinfo ) then
		local getHouse = _G["house"..tostring(houseID)]
		setElementData(getHouse,"interiorid", int)
		setElementData(getHouse,"houseprice", price)
		setElementData(getHouse,"housename", street)
		local updatHouse = exports.DENmysql:exec("UPDATE housing SET houseprice=?, interiorid=?, housename=? WHERE id = ?",tonumber(price),tonumber(int),street,houseID)
		onPlayerUpdateLabels ( source, houseID )
		outputChatBox("Updating the house... Cleaning the house... Doing some laundry... DONE!", source, 0, 225, 0)
	else
		outputChatBox("The ID of the house you enterd is wrong!", source, 225, 0, 0)
	end
end
addEventHandler( "doEditTheHouse", root, doEditTheHouse )


-- Delete house part
function deleteHouse ( playerSource, command, houseid )
	if ( houseid ) then
		if getElementData(playerSource, "houseMapper") == true then
			local checkHouse = exports.DENmysql:querySingle( "SELECT * FROM housing WHERE id = ?", houseid )
			if ( checkHouse ) then
				local deleteHouse = exports.DENmysql:exec( "DELETE FROM housing WHERE id = ?", houseid )
				local getTheHouse = _G["house"..tostring(houseid)]
				destroyElement( getTheHouse )
				outputChatBox("House Deleted!", playerSource, 0, 200, 0)
			else
				outputChatBox("The ID of the house you enterd is wrong!", playerSource, 225, 0, 0)
			end
		end
	end
end
addCommandHandler ( "deletehouse", deleteHouse )

function getPlayerFromPartialName(name)
    local name = name and name:gsub("#%x%x%x%x%x%x", ""):lower() or nil
    if name then
        for _, player in ipairs(getElementsByType("player")) do
            local name_ = getPlayerName(player):gsub("#%x%x%x%x%x%x", ""):lower()
            if name_:find(name, 1, true) then
                return player
            end
        end
    end
end

function setHouseOwner ( playerSource, command, houseid, owner )
	if ( houseid ) then
		if getElementData(playerSource, "houseMapper") == true then
			local checkHouse = exports.DENmysql:querySingle( "SELECT * FROM housing WHERE id = ?", houseid )
			if ( checkHouse ) then
				local ownerid = exports.server:getPlayerAccountID(getPlayerFromPartialName(owner))
				if (ownerid) then
					local updatHouse = exports.DENmysql:exec("UPDATE housing SET ownerid=? WHERE id = ?",ownerid,houseid)
					setElementData(house, "ownerid",ownerid)
					setElementData(house, "ownername",owner)
					outputChatBox("House owner set to "..ownerid, playerSource, 0, 200, 0)
				end
			else
				outputChatBox("The ID of the house you enterd is wrong!", playerSource, 225, 0, 0)
			end
		end
	end
end
addCommandHandler ( "sethouseowner", setHouseOwner )

---- IMPORTANT commands, only used just 1 time when script get added in the server for 1st time


addCommandHandler("resultbuggedhouses",function(player)
	if getElementData(player,"isPlayerPrime") then
		for k,v in ipairs(buggedHouses) do
			outputChatBox(v,player,255,255,0)
		end
	end
end)

addEvent("getOwnerTime",true)
addEventHandler("getOwnerTime",root,function(id)
	local houses = exports.DENmysql:querySingle( "SELECT * FROM housing WHERE id=?",id )
	if houses then
		local myHouse = _G["house"..tostring(id)]
		if myHouse then
			local ow = getElementData(myHouse,"ownername")
			triggerClientEvent(source,"updateOwnerTime",source,ow,houses.lastonline)
		end
	end
end)

addCommandHandler("fixhousetime",function(player)
	if getElementData(player,"isPlayerPrime") then
		local houses = exports.DENmysql:query( "SELECT * FROM housing" )
		if ( houses and #houses > 0 ) then
			for i=1,#houses do
				exports.DENmysql:exec( "UPDATE housing SET lastonline=? WHERE id=?", getRealTime().timestamp, houses[i].id )
			end
		end
	end
	outputChatBox("Wait 3 minutes then restart housing",player,255,0,0)
end)

addCommandHandler("fixhouses",function(player)
	if getElementData(player,"isPlayerPrime") then
		local houses = exports.DENmysql:query( "SELECT * FROM housing" )
		if ( houses and #houses > 0 ) then
			for i=1,#houses do
				outputDebugString(houses[i].id)
				exports.DENmysql:exec("UPDATE housing SET ownerid=?,sale=?,locked=?,passwordlocked=?,password=? WHERE id=?",0,1,0,0,0,houses[i].id)
			end
		end
	end
	outputChatBox("Wait 3 minutes then restart housing",player,255,0,0)
end)

addCommandHandler("resetprices",function(player)
	if getElementData(player,"isPlayerPrime") then
		local houses = exports.DENmysql:query( "SELECT * FROM housing" )
		if ( houses and #houses > 0 ) then
			for i=1,#houses do
				exports.DENmysql:exec("UPDATE housing SET boughtprice=?,houseprice=? WHERE id=?",houses[i].originalPrice,houses[i].originalPrice,houses[i].id)
			end
		end
	end
	outputChatBox("Wait 3 minutes then restart housing",player,255,0,0)
end)

addCommandHandler("fixhousingprices",function(player)
	if getElementData(player,"isPlayerPrime") then
		local houses = exports.DENmysql:query( "SELECT * FROM housing" )
		if ( houses and #houses > 0 ) then
			for i=1,#houses do
				if houses[i].originalPrice < 10000 then
					exports.DENmysql:exec("UPDATE housing SET originalPrice=? WHERE id=?",60000,houses[i].id)

				end
				if houses[i].boughtprice < 10000 then
					exports.DENmysql:exec("UPDATE housing SET boughtprice=? WHERE id=?",60000,houses[i].id)

				end
				if houses[i].houseprice < 10000 then
					exports.DENmysql:exec("UPDATE housing SET houseprice=? WHERE id=?",60000,houses[i].id)

				end
			end
		end
	end
	outputChatBox("Wait 3 minutes then restart housing",player,255,0,0)
end)

function onResetHouse(houseID)
	local drugT = fromJSON('[ { "1": 0, "8": 0, "3": 0, "2": 0, "5": 0, "4": 0, "7": 0, "6": 0 } ]')
	local drugsStorage = toJSON(drugT)
	exports.DENmysql:exec("UPDATE housing SET slot1=?,slot2=?,slot3=?,slot4=?,drugsStorage=?,balance=? WHERE id=?",0,0,0,0,drugsStorage,0,houseID)
end

addCommandHandler("fixwep",function(player)
	if getElementData(player,"isPlayerPrime") then
		local houses = exports.DENmysql:query( "SELECT * FROM housing" )
		local ws = 0
		for i=1,#houses do
			exports.DENmysql:exec("UPDATE housing SET slot1=?,slot2=?,slot3=?,slot4=? WHERE id=?",ws,ws,ws,ws,houses[i].id)
		end
	end
	outputChatBox("Wait 3 minutes then restart housing",player,255,0,0)
end)

addCommandHandler("fixdrugs",function(player)
	if getElementData(player,"isPlayerPrime") then
		local houses = exports.DENmysql:query( "SELECT * FROM housing" )
		local drugT = fromJSON('[ { "1": 0, "8": 0, "3": 0, "2": 0, "5": 0, "4": 0, "7": 0, "6": 0 } ]')
		local drugsStorage = toJSON(drugT)
		for i=1,#houses do
			exports.DENmysql:exec("UPDATE housing SET drugsStorage=? WHERE id=?",drugsStorage,houses[i].id)
		end
	end
	outputChatBox("Wait 3 minutes then restart housing",player,255,0,0)
end)

addCommandHandler("fixmoney",function(player)
	if getElementData(player,"isPlayerPrime") then
		local houses = exports.DENmysql:query( "SELECT * FROM housing" )
		local moneyT = {0,{}}
--		local moneyStorage = toJSON(moneyT)
		for i=1,#houses do
			exports.DENmysql:exec("UPDATE housing SET balance=? WHERE id=?",0,houses[i].id)
		end
	end
	outputChatBox("Wait 3 minutes then restart housing",player,255,0,0)
end)

local mappers = {
	["prime"] = true
}

addEventHandler("onServerPlayerLogin",root,function()
	local ac = exports.server:getPlayerAccountName(source)
	if mappers[ac] then
		setElementData(source,"houseMapper",true)
		outputChatBox("Welcome to NGC house mapper (/deletehouse ID  /createhouse  /edithouse)",source,255,255,0)
	end
end)
addEventHandler("onResourceStart",resourceRoot,function()
	for k,v in ipairs(getElementsByType("player")) do
		local ac = exports.server:getPlayerAccountName(v)
		if mappers[ac] then
			setElementData(v,"houseMapper",true)
			outputChatBox("Welcome to NGC house mapper (/deletehouse ID  /createhouse  /edithouse)",v,255,255,0)
		end
	end
end)


function getTimeDate()
	local aRealTime = getRealTime ( )
	return
	string.format ( "%04d/%02d/%02d", aRealTime.year + 1900, aRealTime.month + 1, aRealTime.monthday ),
	string.format ( "%02d:%02d:%02d", aRealTime.hour, aRealTime.minute, aRealTime.second )
end

function addHouseLog(message)
	if (not message) then return end
	local date, time = getTimeDate()
	local final = "["..date.. " - "..time.."]"
	if (not fileExists("logs/houses.log")) then
		log = fileCreate("logs/houses.log")
	else
		log = fileOpen("logs/houses.log")
	end
	if (not log) then return end
	if (not fileExists("logs/houses.log")) then return end
	if (fileGetSize(log) == 0) then
		fileWrite(log, final.." "..message)
	else
		fileSetPos(log, fileGetSize(log))
		fileWrite(log, "\r\n", "houses : "..final.." "..message)
	end
	fileClose(log)
end
