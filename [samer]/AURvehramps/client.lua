addEvent("AURsmiler.request", true)

addEventHandler("AURsmiler.request", root,
	function()
		if (getPedOccupiedVehicle(localPlayer)) then
			local veh = getPedOccupiedVehicle(localPlayer)
			for k in pairs(getVehicleComponents(veh)) do
				if (k == "bump_front_dummy") or (k == "wheel_front") then
					local x, y, z = getVehicleComponentPosition(veh, k, "parent")
					triggerServerEvent("AURsmiler.updatePos", localPlayer, x, y, z)
				end
			end
		end
	end
)