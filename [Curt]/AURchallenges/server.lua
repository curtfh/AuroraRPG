local elementsCreated = {}
local theChallenges = {
--Name, Description, Time in minutes, Function of the challenge, award function
{"Highest Plane Height", "Hit the highest plane height in any air vehicle before time runs out.", 11, function()
	
end, 
function()
end

},
}

elementsCreated["theListOfHeight"] = {}
elementsCreated["loopOfGettingHeight"] = setTimer(function() 
	for i, thePlayer in ipairs (getElementsByType("player")) do
		if (getElementDimension(thePlayer) == 0) then 
			local theVeh = getPedOccupiedVehicle(thePlayer)
			if (theVeh) then 
				local typel = getVehicleType(theVeh)
				if (typel == "Plane" or typel == "Helicopter") then
					--exports.NGCnote:addNote("title_challenges", "Test", 225, 0, 0)
					local x,y,z = getElementPosition (thePlayer)
					local height = math.floor(z*001)
					elementsCreated["theListOfHeight"][#elementsCreated["theListOfHeight"]+1] = {thePlayer, height}
					
				end
			end
		end 
	end 
	
	table.sort(elementsCreated["theListOfHeight"]) 
	for i=1, elementsCreated["theListOfHeight"] do 
		outputDebugString(getPlayerName(elementsCreated["theListOfHeight"][i][1]))
	end 
	
	
	--outputDebugString("1st. "..getPlayerName(elementsCreated["theListOfHeight"][key][1]).." ("..(mkills+1)..")")
	--exports.NGCnote:addNote("first_challenges", "1st. "..getPlayerName(elementsCreated["theListOfHeight"][key][1]).." ("..(mkills+1)..")", 225, 0, 0)
end, 1000, 0)
