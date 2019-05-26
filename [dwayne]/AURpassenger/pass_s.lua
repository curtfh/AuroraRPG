--[[
vehiclesList = {433}

function in_array(e, t)
	for _,v in pairs(t) do
		if (v==e) then return true end
	end
	return false
end

function getFreeSeat(veh)
	local max = getVehicleMaxPassengers(veh)
	for i=2,max,1 do
		local occ = getVehicleOccupant(veh, i)
		if (occ==false) then return i end
	end
	return false
end

addCommandHandler("barracks",function(player)
	if getElementData(player,"isPlayerPrime") ~= true then return false end
	if isPedInVehicle(player)==true then return end
	local x,y,z = getElementPosition(player)
	for k,v in ipairs(getElementsByType("vehicle")) do
		local vX,vY,vZ = getElementPosition(v)
		if (getDistanceBetweenPoints3D(x,y,z,vX,vY,vZ) < 2.5) then
			local model = getElementModel(v)
			if (in_array(model, vehiclesList)) then
				setPedAnimation(player,"INT_OFFICE","OFF_Sit_Watch",-1, true, false, true, true )
				attachElements(player,v,-6,0,0)
				outputDebugString("TEST")
			end
		end
	end
end)
]]


-- Glue stuff
addEvent( "glueMF",true )
addEventHandler( "glueMF", root,
    function ( slot, vehicle, x, y, z, rotX, rotY, rotZ )
		setPedAnimation(source,"INT_OFFICE","OFF_Sit_Watch",-1, true, false, true, true )
        attachElements( source, vehicle, x, y, z, rotX, rotY, rotZ )
        setPedWeaponSlot( source, slot )
    end
)

addEvent( "unglueMF", true )
addEventHandler( "unglueMF", root,
    function ()
        detachElements( source )
		setPedAnimation(source,false)
    end
)
