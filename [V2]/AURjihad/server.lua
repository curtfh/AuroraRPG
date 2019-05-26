-- Table that stores some data
local jihad = {}
local timer = {}
local math = math
--lv,unwanted,not arrested,once a hour, and for 100k
-- The time the player should wait before he can jihad again, in seconds
local wait = 1800

-- Command to start the jihad attack
addCommandHandler( "jihad", 
	function ( thePlayer )
		if ( jihad[ thePlayer ] ) and ( getTickCount() - jihad[ thePlayer ] < ( wait * 1000 ) ) then
			outputChatBox( "You can't jihad right now, you need to wait 30 mins!", thePlayer, 225, 0, 0 )
		return false end
		--if (getPlayerMoney(thePlayer) < 50000) then
			--outputChatBox("You need $50,000 to use this command.", thePlayer, 255, 0, 0)
		--return false end
		if (exports.server:getPlayChatZone(thePlayer) ~= "LV") then
			outputChatBox("You need to be in LV to use this command.", thePlayer, 255, 0, 0)
		return false end
		if (exports.server:getPlayerWantedPoints(thePlayer) > 0) then
			outputChatBox("You need to be not wanted to use this command.", thePlayer, 255, 0, 0)
		return false end
		if (getElementData(thePlayer, "isPlayerArrested") == true) then
			outputChatBox("You're arrested, you can't use this command.", thePlayer, 255, 0, 0)
		return false end
		if (getElementData(thePlayer, "tazed") == true) then
			outputChatBox("You're tazered, you can't use this command.", thePlayer, 255, 0, 0)
		return false end
		if (getElementDimension(thePlayer) ~= 0 or getElementInterior(thePlayer) ~= 0) then
			outputChatBox("You can't use this command outside of the main world.", thePlayer, 255, 0, 0)
		return false end
			jihad[ thePlayer ] = getTickCount()
			local x, y, z = getElementPosition( thePlayer )
			--takePlayerMoney(thePlayer, 50000)
			playJihadSound( thePlayer )
			--local spark = createObject( 2046, x, y, z )
			--setElementCollisionsEnabled ( spark, false )
			--attachElements( spark, thePlayer )
			--setTimer( destroyElement, 6000, 1, spark )
			timer[thePlayer] = setTimer( startExplosions, 10000, 1, thePlayer )
		end
)

-- Function that plays the sound for all nearby players
function playJihadSound( thePlayer )
	if ( isElement( thePlayer ) ) then
		local x, y, z = getElementPosition( thePlayer )
		for k, aPlayer in ipairs ( getElementsByType( "player" ) ) do
			local x2, y2, z2 = getElementPosition( aPlayer )
			if ( getDistanceBetweenPoints2D( x, y, x2, y2 ) <= 80 ) then
				triggerClientEvent( aPlayer, "onClientPlayJihadSound", aPlayer, thePlayer )
			end
		end
	end
end

-- Function that creates the explosions
function startExplosions ( thePlayer )
	if (getElementData(thePlayer, "isPlayerArrested") == true) then return false end
	if ( isElement( thePlayer ) ) and (exports.server:getPlayerWantedPoints(thePlayer) == 0) then
		local x, y, z = getElementPosition( thePlayer ) 
		createExplosion ( x, y, z, 10, thePlayer )
		for i = 1, 5 do
			local x, y, z = getElementPosition( thePlayer ) 
			createExplosion ( x - math.random( 8 ) + math.random( 8 ), y  - math.random( 8 ) + math.random( 8 ), z, 10, thePlayer )
		end
	end
end
