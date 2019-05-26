g_base_col = createColSphere (570,-1853.15,7.42, 250)
  
g_root = getRootElement () 

local opened = false
  
function hit ( pla, dim ) 
    if getElementType ( pla ) == "player" then 
    local vehicle = getPlayerOccupiedVehicle ( pla ) 
        if vehicle or not vehicle then 
            local teamname = getTeamName(getPlayerTeam(pla))
			setElementData(pla, "AURconcert2.browsersound", true)
			if (opened == false) then 
					exports.NGCdxmsg:createNewDxMessage(pla, "This area is closed by the Law Enforcement.", 255, 0, 0)
				if (teamname ~= "Staff") then 
					setElementPosition (pla, 632.89,-1584.67,15.51, true) 
					if (vehicle) then 
						setElementPosition (vehicle, 632.89,-1584.67,15.51, true) 
					end 
				end 
			end
        end 
    end 
end 
addEventHandler ( "onColShapeHit", g_base_col, hit ) 

function asdasd ( thePlayer )
   if getElementType ( thePlayer ) == "player" then
      setElementData(thePlayer, "AURconcert2.browsersound", false)
   end
end
addEventHandler ( "onColShapeLeave", g_base_col, asdasd )

function openit (pla)
	local teamname = getTeamName(getPlayerTeam(pla))
	if (teamname == "Staff") then 
		if opened == false then 
			outputChatBox("Opened the event for all players.", pla, 255, 255, 255)
			opened = true
		else 
			outputChatBox("Clsoed the event for all players.", pla, 255, 255, 255)
			opened = false
		end 
	end 
end 
addCommandHandler("openeventparty", openit)

function sadasdasa (pla)
	local teamname = getTeamName(getPlayerTeam(pla))
	if (teamname == "Staff") then 
		for index, player in pairs(getElementsByType("player")) do
			if (isElementWithinColShape(player, g_base_col)) then 
				exports.csgdrugs:giveDrug(player, "LSD",30)
				exports.csgdrugs:giveDrug(player, "Cocaine",30)
				exports.csgdrugs:giveDrug(player, "Heroine",30)
				exports.csgdrugs:giveDrug(player, "Ritalin",30)
				exports.csgdrugs:giveDrug(player, "Ecstasy",30)
				exports.csgdrugs:giveDrug(player, "Weed",30)
				exports.CSGscore:givePlayerScore(player,0.5)
				exports.AURvip:givePlayerVIP(player, math.floor(5)*60)
				exports.NGCdxmsg:createNewDxMessage("Thanks for participating for this event.",player,255,255,0)
				exports.NGCdxmsg:createNewDxMessage("We added 30 drugs on your account, 5 hours of VIP and 0.5 score.",player,255,255,0)
				exports.NGCdxmsg:createNewDxMessage("Stay here on this event and you will get more drugs, vip hours and 0.5 score.",player,255,255,0)
			end 
		end 
	end 
end 
addCommandHandler("giveallcandyLOL", sadasdasa)
