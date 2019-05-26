local sound
local theTimer

function playMusic () 
	if (isElement(sound)) then return end
	local ox, oy, oz = getElementPosition(client)
	sound = playSound("ican.mp3", false)
	setGameSpeed (1.2)
	setGravity(0.008)
	setCameraShakeLevel (0)
	theTimer = setTimer(function(theSound)
		local soundLength = getSoundPosition(theSound)
		
		--Fly Marshmello Template
		if (soundLength >= 36 and soundLength <= 41.3) then 
			setSkyGradient(math.random (0,255), math.random (0,255), math.random (0,255), math.random (0,255), math.random (0,255), math.random (0,255))
		end 
		if (soundLength >= 42.2 and soundLength <= 71) then 
			setSkyGradient(math.random (0,255), math.random (0,255), math.random (0,255), math.random (0,255), math.random (0,255), math.random (0,255))
		end 
		if (soundLength <= 42.4 and soundLength >= 41) then 
			setElementData(localPlayer, "superman:flying", true)
			setGravity(0)
			setGameSpeed (0.3)
			local x,y,z = getElementPosition(localPlayer)
			setElementPosition(localPlayer, x,y,tonumber(z)+5)
			setWorldSpecialPropertyEnabled( "aircars", true )
		end 
		if (soundLength >= 55 and soundLength <= 72) then 
			executeCommandHandler("superman")
		end 
		if (soundLength >= 71 and soundLength <= 72) then 
			setElementData(localPlayer, "superman:flying", false)
			setGravity(0.008)
			setGameSpeed (1.2)
			setWorldSpecialPropertyEnabled( "aircars", false )
		end 
		if (soundLength >= 101 and soundLength <= 159) then 
			setSkyGradient(math.random (0,255), math.random (0,255), math.random (0,255), math.random (0,255), math.random (0,255), math.random (0,255))
		end 
		if (soundLength >= 115 and soundLength <= 116) then 
			setElementData(localPlayer, "superman:flying", true)
			setWorldSpecialPropertyEnabled( "aircars", true )
			setGravity(0)
			setGameSpeed (0.3)
			local x,y,z = getElementPosition(localPlayer)
			setElementPosition(localPlayer, x,y,tonumber(z)+5)
		end 
		if (soundLength >= 128 and soundLength <= 159) then 
			executeCommandHandler("superman")
		end 

		if (soundLength >= 159 and soundLength <= 160) then 
			setElementData(client, "superman:flying", false)
			setWorldSpecialPropertyEnabled( "aircars", false )
		end 
		if (soundLength >= 180 and soundLength <= 181) then 
			setGameSpeed (1.2)
			setGravity(0.008)
			setElementPosition(client, ox, oy, oz)
			resetSkyGradient()
			killTimer(theTimer)
		end 
	end, 100, 0, sound)
end 
addEvent( "AURsevent.special", true )
addEventHandler( "AURsevent.special", localPlayer, playMusic )

function neonSky ()
	setSkyGradient(math.random (0,255), math.random (0,255), math.random (0,255), math.random (0,255), math.random (0,255), math.random (0,255))
end