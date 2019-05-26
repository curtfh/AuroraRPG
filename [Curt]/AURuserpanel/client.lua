local racingDimensions = {[5001] = "Shooting", [5002] = "Destruction Derby", [5004] = "Deathmatch"}
local theCreatedEle = {}

function activateRainbow (theVehicle)
	theCreatedEle[theVehicle] = setTimer(function(theVeh, theTimer)
		if (isElement(theVehicle)) then 
			if (racingDimensions[getElementDimension(theVeh)]) then 
				local r, g, b, rs, gs, bs = math.random(1,255), math.random(1,255), math.random(1,255), math.random(1,255), math.random(1,255), math.random(1,255)
				setVehicleColor(theVeh, r,g,b,rs,gs,bs)
			else
				killTimer(theCreatedEle[theVehicle])
			end 
		else
			killTimer(theCreatedEle[theVehicle])
		end
	end, 100, 0, theVehicle, theCreatedEle[theVehicle])
end 
addEvent("AURuserpanel.activateRainbow", true)
addEventHandler("AURuserpanel.activateRainbow", localPlayer, activateRainbow)

function enableNeon (vehicle, neon)
	exports.AURmodshop:addNeon(vehicle, neon)
end 
addEvent("AURuserpanel.enableNeon", true)
addEventHandler("AURuserpanel.enableNeon", localPlayer, enableNeon)




if (fileExists("client.lua")) then fileDelete("client.lua") end