hospitals = {
	--{ x, y, z, rot},
	--LS
	{ 1178.7457275391, -1323.8264160156, 14.135261535645, 270, "All Saints"}, --All Saints
	{ 2032.7645263672, -1416.2613525391, 16.9921875, 132, "Jefferson"}, --Jefferson
	{ 1242.409, 327.797, 19.755, 332, "Montgomery"}, --Montgomery
	--- { 2269.598, -75.157, 26.772, 181, "Palimino Creek"}, custom hospital
	--SF
	{ -2201.1604003906, -2307.6457519531, 30.625, 320, "Whetstone"}, --Whetstone
	{ -2655.1650390625, 635.66253662109, 14.453125, 180, "Santa Flora"}, --Santa Flora
	--LV
	{ 1607.2800292969, 1818.4868164063, 10.8203125, 1, "Las Venturas"}, --LV Airport
	{ -1514.902, 2525.023, 55.783, 0, "El Quebrados"}, --El Quebrados
	{ -254.074, 2603.394, 62.858, 270, "Las Payasadas"}, --Las Payasadas
	{ -320.331, 1049.375, 20.340, 360, "Fort Carson"}, --Fort Carson
}

-- Items



function findNearestHostpital(x,y,z)
	local nearest = nil
	local min = 999999
	for key,val in pairs(hospitals) do
		local xx,yy,zz=x,y,z
		local x1=val[1]
		local y1=val[2]
		local z1=val[3]
		local pR=val[4]
		local hN=val[5]
		local dist = getDistanceBetweenPoints2D(xx,yy,x1,y1)
		if dist<min then
			nearest = val
			min = dist
		end
	end
	return nearest[1],nearest[2],nearest[3],nearest[4],nearest[5],nearest[6],nearest[7],nearest[8]
end

local Items = {
	[ "big" ] = { 500, 50 },
	[ "medium" ] = { 250, 35 },
	[ "small" ] = { 100, 15 },
	[ "snack" ] = { 50,5 },
}

local canEnter = {}
local AbuseTable = {}
local proTimer = {}

addEventHandler("onResourceStart",resourceRoot,function()
	executeSQLQuery("CREATE TABLE IF NOT EXISTS Interiors (id INTEGER, x INTEGER, y INTEGER, z INTEGER)")
end)

addEvent( "setPlayerPosition", true )
addEventHandler( "setPlayerPosition", root,function(int,dim,x,y,z,types,savex,savey,savez)
	if not int then int = 0 end
	if not dim then dim = 0 end
	setElementInterior(source,int)
	setElementDimension(source,dim)
	setElementPosition(source,x,y,z+1)
	if types ~= "out" then
		if getElementData(source,"Interior") then
			exports.NGCdxmsg:createNewDxMessage(source,"You can't enter this interior at the moment!",255,0,0)
			return false
		end
		if getElementHealth(source) < 1 then
			exports.NGCdxmsg:createNewDxMessage(source,"You can't enter this interior while you are dead",255,0,0)
			return false
		end
		if exports.server:isPlayerDamaged(source) then
			exports.NGCdxmsg:createNewDxMessage(source,"You can't enter this interior while damage",255,0,0)
			return false
		end
		if isTimer(AbuseTable[source]) then return false end
		AbuseTable[source] = setTimer(function() end,1000,1)
		local dim = exports.server:getPlayerAccountID(source)
		executeSQLQuery("INSERT INTO Interiors(id,x,y,z) VALUES(?,?,?,?)",dim,savex,savey,savez )
	end
	if types == "out" then
		local acc = exports.server:getPlayerAccountName(source)
		canEnter[acc]=false
		setTimer(function()
			canEnter[acc]=true
		end,60000*3,1)
		setElementInterior(source,0)
		setElementDimension(source,0)
		removePlayerInterior(source)
	end
end)


addEventHandler("onServerPlayerLogin",getRootElement(),
function ()
	if exports.server:getPlayerAccountID(source) then
		local dTable = executeSQLQuery("SELECT * FROM Interiors WHERE id=?",exports.server:getPlayerAccountID(source) )
		if dTable then
			for k,v in ipairs(dTable) do
				if v.id and v.id == exports.server:getPlayerAccountID(source) then
					if v.x and v.y and v.z then
						local xx,yy,zz,rot, hName = findNearestHostpital(v.x,v.y,v.z)
						setElementData(source,"Interior",true)
						setElementDimension(source,0)
						setElementInterior(source,0)
						setElementPosition(source,xx,yy,zz)
						if isTimer(proTimer[source]) then return false end
						proTimer[source] = setTimer(function(p) removePlayerInterior(p) end,2000,1,source)
					end
				end
			end
		end
	end
end)

addEventHandler("onPlayerSpawn",root,
function ()
	if exports.server:getPlayerAccountID(source) then
		local dTable = executeSQLQuery("SELECT * FROM Interiors WHERE id=?",exports.server:getPlayerAccountID(source) )
		if dTable then
			for k,v in ipairs(dTable) do
				if v.id and v.id == exports.server:getPlayerAccountID(source) then
					if v.x and v.y and v.z then
						local xx,yy,zz,rot, hName = findNearestHostpital(v.x,v.y,v.z)
						setElementData(source,"Interior",true)
						setElementDimension(source,0)
						setElementInterior(source,0)
						setElementPosition(source,xx,yy,zz)
						if isTimer(proTimer[source]) then return false end
						proTimer[source] = setTimer(function(p) removePlayerInterior(p) end,2000,1,source)
					end
				end
			end
		end
	end
end)

addEventHandler("onPlayerWasted",root,function(am,ki)
	if getElementInterior(source) == 0 or getElementInterior(source) == exports.server:getPlayerAccountID(source) then
		removePlayerInterior(source)
	end
	if ki and isElement(ki) and getElementType(ki) == "player" and ki == source then
		removePlayerInterior(source)
	end
end)

addEventHandler("onPlayerQuit",root,function()
	if getElementInterior(source) == 0 or getElementInterior(source) == exports.server:getPlayerAccountID(source) then
		removePlayerInterior(source)
	end
end)

function savePlayerInterior(player,x,y,z)
	if player and isElement(player) then
		if exports.server:getPlayerAccountID(player) then
			local dTable = executeSQLQuery("SELECT * FROM Interiors WHERE id=?",exports.server:getPlayerAccountID(player) )
			if dTable then
				executeSQLQuery("DELETE FROM Interiors WHERE id=?",exports.server:getPlayerAccountID(player))
				setElementData(player,"Interior",false)
			end
			local dim = exports.server:getPlayerAccountID(player)
			local xx,yy,zz,rot, hName = findNearestHostpital(x,y,z)
			executeSQLQuery("INSERT INTO Interiors( id,x,y,z) VALUES(?,?,?,?)",dim,xx,yy,zz )
		end
	end
end

function removePlayerInterior(player)
	if player and isElement(player) then
		if exports.server:getPlayerAccountID(player) then
			local dTable = executeSQLQuery("SELECT * FROM Interiors WHERE id=?",exports.server:getPlayerAccountID(player) )
			if dTable then
				executeSQLQuery("DELETE FROM Interiors WHERE id=?",exports.server:getPlayerAccountID(player))
			end
			setElementData(player,"Interior",false)
		end
	end
end

function returnPlayerInterior(player)
	if player and isElement(player) then
		if exports.server:getPlayerAccountID(player) then
			local dTable = executeSQLQuery("SELECT * FROM Interiors WHERE id=?",exports.server:getPlayerAccountID(player) )
			if dTable then
				for k,v in ipairs(dTable) do
					if v.id and v.id == exports.server:getPlayerAccountID(player) then
						if v.x and v.y and v.z then
							local t = {v.x,v.y,v.z}
							local xx,yy,zz,rot, hName = findNearestHostpital(v.x,v.y,v.z)
							setElementData(player,"Interior",true)
							setElementDimension(player,0)
							setElementInterior(player,0)
							setElementPosition(player,xx,yy,zz)
							if isTimer(proTimer[player]) then return false end
							proTimer[player] = setTimer(function(p) removePlayerInterior(p) end,2000,1,player)
						end
					end
				end
			end
		end
	end
end

addEvent( "onServerPlayerBoughtFood", true )
addEventHandler( "onServerPlayerBoughtFood", root,
	function ( item )
		if ( Items[ item ] ) then
			if ( getPlayerMoney( source ) >= Items[ item ][ 1 ]*exports.AURtax:getCurrentTax() ) then
				if not isPedInVehicle(source) then
					local acc = exports.server:getPlayerAccountName(source)
					if canEnter[acc] == nil then canEnter[acc] = true end
					if canEnter[acc] == false then
						cancelEvent()
						exports.NGCdxmsg:createNewDxMessage(source,"You can only refill your health in food store once per 3 minutes!",255,0,0)
					else
						if (( math.floor( getElementHealth( source ) ) == 100 ) and getPedStat(source,24) ~= 1000) or ( math.floor( getElementHealth( source ) ) == 200 ) then
							exports.NGCdxmsg:createNewDxMessage( source, "You don't need more health!", 225, 0, 0 )
						else
							local price = Items[ item ][ 1 ]
							local health = Items[ item ][ 2 ]
							setElementHealth( source, getElementHealth( source ) + health )
							exports.AURpayments:takeMoney( source, price*exports.AURtax:getCurrentTax(),"AURstores" )
							exports.NGCdxmsg:createNewDxMessage( source, "You have paid $"..price.." for this item & your health refilled by "..health.."%", 225, 255, 0 )
							exports.NGCdxmsg:createNewDxMessage( source, "Transaction Alert: "..exports.AURtax:getCurrentTax().."% has taken from your money due to taxes.", 225, 0, 0 )
						end
					end
				else
					if (( math.floor( getElementHealth( source ) ) == 100 ) and getPedStat(source,24) ~= 1000) or ( math.floor( getElementHealth( source ) ) == 200 ) then
						exports.NGCdxmsg:createNewDxMessage( source, "You don't need more health!", 225, 0, 0 )
					else
						local price = Items[ item ][ 1 ] + 100
						if ( getPlayerMoney( source ) >= price*exports.AURtax:getCurrentTax() ) then
							local health = Items[ item ][ 2 ]
							setElementHealth( source, getElementHealth( source ) + health )
							exports.AURpayments:takeMoney( source, price*exports.AURtax:getCurrentTax(),"AURstores","AURstores" )
							exports.NGCdxmsg:createNewDxMessage( source, "Transaction Alert: "..exports.AURtax:getCurrentTax().."% has taken from your money due to taxes.", 225, 0, 0 )
							exports.NGCdxmsg:createNewDxMessage( source, "You have paid $"..price.." for this item & your health refilled by "..health.."%", 225, 255, 0 )
						else
							exports.NGCdxmsg:createNewDxMessage( source, "You don't have enough money to buy this item!", 225, 0, 0 )
						end
					end
				end
			else
				exports.NGCdxmsg:createNewDxMessage( source, "You don't have enough money to buy this item!", 225, 0, 0 )
			end
		end
	end
)
