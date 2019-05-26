function disable_ped_dmg()
	if (getElementData(source, "taxi_ped")) then
		cancelEvent()
	end
end
addEventHandler("onClientPedDamage", root, disable_ped_dmg)

function create_ped_text()
	if (getElementData(localPlayer, "Occupation") ~= "Taxi Driver") then return false end
	for i, v in ipairs(getElementsByType("ped"), resourceRoot) do
		if (getElementData(v, "taxi_ped") and getElementData(v, "taxi_ped") == localPlayer) then
			local pX, pY, pZ = getElementPosition(localPlayer)
			local x, y, z = getElementPosition(v)
			local sX, sY = getScreenFromWorldPosition(x, y, z+1)
			local textToDisplay = "Hey taxi driver, can I have a ride please?"
			if (sX and getDistanceBetweenPoints3D(x, y, z, pX, pY, pZ) < 50) then
					if (isLineOfSightClear(pX, pY, pZ, x, y, z, true, false, false, true, false)) then
					local sX = sX - 1
					local r, g, b = 255, 255, 0
					dxDrawText(textToDisplay:gsub("#%x%x%x%x%x%x", ""), sX-1, sY-1, sX-1, sY-1, tocolor(0,0,0,255), 1.0, "default", "left", "top", false, false, false, false)
					dxDrawText(textToDisplay:gsub("#%x%x%x%x%x%x", ""), sX+1, sY-1, sX+1, sY-1, tocolor(0,0,0,255), 1.0, "default", "left", "top", false, false, false, false)
					dxDrawText(textToDisplay:gsub("#%x%x%x%x%x%x", ""), sX-1, sY+1, sX-1, sY+1, tocolor(0,0,0,255), 1.0, "default", "left", "top", false, false, false, false)
					dxDrawText(textToDisplay:gsub("#%x%x%x%x%x%x", ""), sX+1, sY+1, sX+1, sY+1, tocolor(0,0,0,255), 1.0, "default", "left", "top", false, false, false, false)
					dxDrawText(textToDisplay:gsub("#%x%x%x%x%x%x", ""), sX-1, sY, sX-1, sY, tocolor(0,0,0,255), 1.0, "default", "left", "top", false, false, false, false)
					dxDrawText(textToDisplay:gsub("#%x%x%x%x%x%x", ""), sX+1, sY, sX+1, sY, tocolor(0,0,0,255), 1.0, "default", "left", "top", false, false, false, false)
					dxDrawText(textToDisplay:gsub("#%x%x%x%x%x%x", ""), sX, sY-1, sX, sY-1, tocolor(0,0,0,255), 1.0, "default", "left", "top", false, false, false, false)
					dxDrawText(textToDisplay:gsub("#%x%x%x%x%x%x", ""), sX, sY+1, sX, sY+1, tocolor(0,0,0,255), 1.0, "default", "left", "top", false, false, false, false)
					dxDrawText(textToDisplay, sX, sY, sX, sY, tocolor(r,g,b,255), 1.0, "default", "left", "top", false, false, false, true)
				end
			end
		end
	end
end
addEventHandler("onClientRender", root, create_ped_text)