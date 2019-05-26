local bombSpeed = 15 --Bomb dropping speed in m/s
local allowByIDs = true --Set if allow by ids. False = only (all) planes. true = Everything listed in 'allowedIDs' table. REMEMBER TO SET THIS VARIABLE IN CLIENTSIDE TOO!
local allowedIDs = {520,476} --Remember to keep this table matching in clientside
-- You can change bomb model size somewhere else in this lua file, search for 'setObjectScale' and change the digit at end of function. Default: 6, mid sized bomb.

local function isClientValid(player,shouldBe)
	
	if player ~= shouldBe then return false end
	if not player.vehicle then return false end
	if player.vehicle.controller ~= player then return false end
	if player.vehicle.vehicleType ~= "Plane" and allowByIDs == false then return false end
	
	if allowByIDs then
		local isAllowed = false
		for _,allowedID in ipairs(allowedIDs) do
			if player.vehicle.model == allowedID then
				isAllowed = true
			end
		end
		if not isAllowed then
			return false
		end
	end
	
	return true

end

local function explodeBomb(bombObject)

	createExplosion(bombObject.position,10)
	destroyElement(bombObject)

end

local function handlePlayer(player)

	addEventHandler("onPlayerDropAirplaneBomb",player,dropBomb)

end

local function onJoin()

	handlePlayer(source)

end

function dropBomb(sx,sy,sz,ez,distanceToGround)

	if not isClientValid(client,source) then return end
	
	local movingTime = distanceToGround/(bombSpeed/1000)
	movingTime = (movingTime >= 50 and movingTime or 50)
	local bombObject = Object(1636,sx,sy,sz,0,0,0,false)
	setObjectScale(bombObject,6)
	bombObject.dimension = client.dimension
	bombObject.interior = client.interior
	bombObject:move(movingTime,sx,sy,ez)
	
	setTimer(explodeBomb,movingTime,1,bombObject)
	setTimer(handlePlayer,10000,1,client)
	removeEventHandler("onPlayerDropAirplaneBomb",client,dropBomb)

end

local function initScript()

	addEvent("onPlayerDropAirplaneBomb",true)
	addEventHandler("onPlayerJoin",root,onJoin)
	
	local players = getElementsByType("player")
	
	for _,player in ipairs(players) do
		addEventHandler("onPlayerDropAirplaneBomb",player,dropBomb)
	end

end

addEventHandler("onResourceStart",resourceRoot,initScript)