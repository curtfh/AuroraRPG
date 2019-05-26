function getPos ( )
	local x, y, z = getElementPosition( localPlayer )
	local xr = getPedRotation ( localPlayer )
	setClipboard((math.floor( x * 100 ) / 100 )..","..(math.floor( y * 100 ) / 100 )..","..( math.floor( z * 100 ) / 100 )..","..math.floor(xr) )
	outputChatBox( "Position: " .. ( math.floor( x * 100 ) / 100 ) .. ", " .. ( math.floor( y * 100 ) / 100 ) .. ", " .. ( math.floor( z * 100 ) / 100 ) .." Interior: " .. getElementInterior( localPlayer ) .. ", Dimension: " .. getElementDimension( localPlayer ).. " Rotation: " .. xr,0, 255, 153 )
end
addCommandHandler ( "pos", getPos )

---local playerData = {}
--[[
addEventHandler("onClientRender",root,function()
	if not isPedInWater(localPlayer) then
		if isPedOnGround(localPlayer) then
			x,y,z=getElementPosition(localPlayer)
			--playerData = {x,y,z}
			setElementData(localPlayer,"playerWaterSave",{x,y,z})
		else
			return false
		end
	end
end)]]

--[[addEventHandler("onClientPlayerQuit",root,function()
	if source == localPlayer then
		if isPedInWater(localPlayer) then
			if getElementHeal(localPlayer) >= 1 then
				if playerData then
					local mx,my,mz = getElementPosition(localPlayer)
					if mz <= -0.90 then
						local px,py,pz = unpack(playerData)
						if px then
							outputChatBox("Reset positions to none water zone",255,0,0)
							setElementPosition(localPlayer,px,py,pz)
							triggerServerEvent("setWaterBugPosition",localPlayer,px,py,pz)
						end
					end
				end
			end
		end
	end
end)]]
