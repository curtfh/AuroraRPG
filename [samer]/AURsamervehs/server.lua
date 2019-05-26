local vehicles = { }

addEvent ( "AURspawners.spawnMarkerCar", true )
addEventHandler ( "AURspawners.spawnMarkerCar", root,
    function (plr, vehName, x, y, z, rx, ry, rz, r, g, b)
     if ( isElement ( vehicles [ plr ] ) ) then
            destroyElement ( vehicles [ plr ] )
        end 
		local vehID = getVehicleModelFromName(vehName)
		vehicles [ plr ] = createVehicle ( vehID, x, y, z, rx, ry, rz)
        if ( vehicles [ plr ] ) then
            setVehicleColor ( vehicles [ plr ], r, g, b )
        end
		setTimer ( setElementFrozen, 380, 1, plr, false)
		setTimer ( warpPedIntoVehicle, 400, 1, plr, vehicles [ plr ] )
end
)

function destroyVehicle()
    if ( isElement ( vehicles [ source ] ) ) then
        destroyElement ( vehicles [ source ] )
    end
end
addEventHandler("onPlayerQuit",getRootElement(),destroyVehicle)
addEventHandler("onPlayerWasted",getRootElement(),destroyVehicle)

function djv(p)
	if (isElement(vehicles [p])) then
		destroyElement (vehicles [p])
	end
end
addCommandHandler("djv", djv)

function cancelWanted(player, seat, jacked)
	if (player) then
		if (getElementData(player, "wantedPoints") > 20) then
			for k, v in ipairs(vehicles) do
				if (v == source) then
					cancelEvent()
					exports.NGCdxmsg:createNewDxMessage("You cannot take free a vehicle if you are wanted!", player, 255, 0, 0)
				end
			end
		end
	end
end
addEventHandler("onVehicleStartEnter",root,cancelWanted)