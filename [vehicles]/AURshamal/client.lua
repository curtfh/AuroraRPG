
bindKey("G","down",function()
	for k,v in ipairs(getElementsByType("vehicle")) do
		if getElementModel(v) == 519 then
			local driver = getVehicleOccupant(v,0)
			if driver and isElement(driver) then
				local veh = getPedOccupiedVehicle(driver)
				if veh == v then
					if isPedOnGround(localPlayer) then
						local x,y,z = getElementPosition(localPlayer)
						local vX,vY,vZ = getElementPosition(v)
						if (getDistanceBetweenPoints3D(x,y,z,vX,vY,vZ) <= 5) then
							if not isPedInVehicle(localPlayer) then
								if getElementHealth(v) >= 300 then
									if getElementData(driver,"Occupation") ~= "Pilot" then
										triggerServerEvent("onPlayerEnterShamal",localPlayer,driver,v)
									end
								end
							end
						end
					end
				end
			end
		end
	end
end)


function dxDrawBorderedText( text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI )
	dxDrawText ( text, x - 1, y - 1, w - 1, h - 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, false ) -- black
	dxDrawText ( text, x + 1, y - 1, w + 1, h - 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text, x - 1, y + 1, w - 1, h + 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text, x + 1, y + 1, w + 1, h + 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text, x - 1, y, w - 1, h, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text, x + 1, y, w + 1, h, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text, x, y - 1, w, h - 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text, x, y + 1, w, h + 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI )
end


addEventHandler("onClientRender",getRootElement(),
function ()
	if getElementData(localPlayer,"isPlayerInShamal") then
		exports.NGCnote:addNote("Shamal","#FFFFFFType #FF0000/getout #FFFFFFto leave Shamal interior",255,0,0,50)
	end
	for i,v in ipairs(getElementsByType("vehicle")) do
		if getElementModel(v) == 519 then
			local driver = getVehicleOccupant(v,0)
			if driver and isElement(driver) then
				if driver ~= localPlayer then
					local veh = getPedOccupiedVehicle(driver)
					if veh == v then
						local x,y,z = getElementPosition(localPlayer)
						local vX,vY,vZ = getElementPosition(v)
						if (getDistanceBetweenPoints3D(x,y,z,vX,vY,vZ) <= 5) then
							if not isPedInVehicle(localPlayer) then
								if getElementHealth(v) >= 300 then
									if getElementData(driver,"Occupation") ~= "Pilot" then
										if getElementDimension(localPlayer) > 0 then return end
										local name = "Press G to enter in this plane"
										local x,y,z = getElementPosition(v)
										local cx,cy,cz = getCameraMatrix()
										if getDistanceBetweenPoints3D(cx,cy,cz,x,y,z) <= 15 then
											local px,py = getScreenFromWorldPosition(x,y,z+1.3,0.06)
											if px then
												local width = dxGetTextWidth(name,1,"sans")
												local r,g,b = 255,250,0
												dxDrawBorderedText(name, px, py, px, py, tocolor(r, g, b, 255), 1.5, "sans", "center", "center", false, false)
											end
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end
end)
