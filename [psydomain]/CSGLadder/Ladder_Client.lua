function onResourceStart()
	if markersTable then
		for i=1, #markersTable do
			local m1 = createMarker(markersTable[i][1],markersTable[i][2],markersTable[i][3], "arrow",1,255,255,0,0)-- MTA bug : alpha doenst work on Arrow markers (should auto fix when the bug is corrected)
			setElementDimension(m1, 95419)
			setElementData(m1, "warpX", markersTable[i][4])
			setElementData(m1, "warpY", markersTable[i][5])
			setElementData(m1, "warpZ", markersTable[i][6])
			local m2 = createMarker(markersTable[i][4],markersTable[i][5],markersTable[i][6], "arrow",1,255,255,0,0)-- MTA bug : alpha doenst work on Arrow markers(should auto fix when the bug is corrected)
			setElementDimension(m2, 95419)
			setElementData(m2, "warpX", markersTable[i][1]) 
			setElementData(m2, "warpY", markersTable[i][2])
			setElementData(m2, "warpZ", markersTable[i][3])
			addEventHandler("onClientMarkerHit", m1, onPlayerMarkerHit)
			addEventHandler("onClientMarkerLeave", m1, onPlayerMarkerLeave)
			addEventHandler("onClientMarkerHit", m2, onPlayerMarkerHit)
			addEventHandler("onClientMarkerLeave", m2, onPlayerMarkerLeave)
		end
	end
	label = guiCreateLabel(0, 0.8, 1, 0.1, "Press F to climb the ladder", true)
	guiSetVisible(label,false)
end
addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), onResourceStart)

function onPlayerMarkerHit (hitElement)
	if hitElement == localPlayer and not (guiGetVisible(label) == true) then
		guiSetVisible(label,true)
		guiLabelSetHorizontalAlign(label, "center", false)
		bindKey("f", "down", startClimb, source, hitElement)
	end
end

function onPlayerMarkerLeave (leftPlayer)
	if leftPlayer == localPlayer then
		if label then 
			guiSetVisible(label, false)
		end
		unbindKey("f")
	end
end

function startClimb(keyPressed,state, marker, player)
	if player == localPlayer then
		local x = getElementData(marker, "warpX")
		local y = getElementData(marker, "warpY")
		local z = getElementData(marker, "warpZ")
		fadeCamera(false, 1)
		setTimer ( fadeCamera, 1500, 1, true, 1 )
		if label then 
			guiSetVisible(label, false)
		end
		if x and y and z then
			setTimer ( setElementPosition, 1500, 1, player, x, y, z-0.7 )
		end
	end
end