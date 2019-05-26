crash = {{{{{{{{ {}, {}, {} }}}}}}}}
isSpeedEnabled = false

function Speedd()
	if ( getPedOccupiedVehicle( localPlayer ) ) then
		if ( getVehicleController( getPedOccupiedVehicle( localPlayer ) ) == localPlayer ) then
			--if ( isVehicleOnGround( getPedOccupiedVehicle( localPlayer ) ) ) then
				if ( getAnalogControlState("accelerate") == 1) then
					if ( getTeamName( getPlayerTeam( localPlayer ) ) == "Staff" ) then
						local velX, velY, velZ = getElementVelocity( getPedOccupiedVehicle( localPlayer ) )
						local a = setElementVelocity( getPedOccupiedVehicle( localPlayer ), velX * 1.1, velY * 1.1, velZ )
					end
				end
			--end
		end
	end
end

function startSpeed()
	if ( getTeamName( getPlayerTeam( localPlayer ) ) == "Staff" ) then
		addEventHandler("onClientRender", root, Speedd)
		isSpeedEnabled = true
	end
end

function killSpeed()
	if (isSpeedEnabled) then
		removeEventHandler("onClientRender", root, Speedd)
		isSpeedEnabled = false
	end
end

function bindStuff()
	--outputDebugString("Binding keys for Speed")
	bindKey("l", "down", startSpeed)
	bindKey("l", "up", killSpeed)
end
bindStuff()