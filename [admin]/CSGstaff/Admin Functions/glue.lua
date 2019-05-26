function glue()
	if not getPlayerOccupiedVehicle( localPlayer ) then
			local vehicle = getPlayerContactElement( localPlayer )
			if (exports.server:getPlayerWantedPoints( localPlayer ) >= 10) then exports.NGCdxmsg:createNewDxMessage("You can not glue to vehicles while being wanted",255,0,0) return end
			if isElement(vehicle) and getElementType(vehicle) == "vehicle" then
				if getElementModel(vehicle) ~= 497 then
				if getElementData(localPlayer,"isPlayerVIP",true) or ( getTeamName( getPlayerTeam( localPlayer ) ) == "Staff" ) then 
				local px, py, pz = getElementPosition( localPlayer )
				local vx, vy, vz = getElementPosition(vehicle)
				local sx = px - vx
				local sy = py - vy
				local sz = pz - vz

				local rotpX = 0
				local rotpY = 0
				local rotpZ = getPlayerRotation( localPlayer )

				local rotvX,rotvY,rotvZ = getVehicleRotation(vehicle)

				local t = math.rad(rotvX)
				local p = math.rad(rotvY)
				local f = math.rad(rotvZ)

				local ct = math.cos(t)
				local st = math.sin(t)
				local cp = math.cos(p)
				local sp = math.sin(p)
				local cf = math.cos(f)
				local sf = math.sin(f)

				local z = ct*cp*sz + (sf*st*cp + cf*sp)*sx + (-cf*st*cp + sf*sp)*sy
				local x = -ct*sp*sz + (-sf*st*sp + cf*cp)*sx + (cf*st*sp + sf*cp)*sy
				local y = st*sz - sf*ct*sx + cf*ct*sy

				local rotX = rotpX - rotvX
				local rotY = rotpY - rotvY
				local rotZ = rotpZ - rotvZ

				local slot = getPlayerWeaponSlot( localPlayer )

				triggerServerEvent("gluePlayer", localPlayer, slot, vehicle, x, y, z, rotX, rotY, rotZ)
				setElementData(localPlayer,"isPlayerGlued",true)
				end
			end
		end
	end
end
addEvent( "onGlue", true )
addEventHandler( "onGlue", localPlayer, glue )

function unglue ()
	triggerServerEvent("ungluePlayer", localPlayer )
	setElementData(localPlayer,"isPlayerGlued",false)
end
addEvent( "onUnGlue", true )
addEventHandler( "onUnGlue", localPlayer, unglue )