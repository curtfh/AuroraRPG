local ShieldAgents = {}

addEvent("activeShield",true)
addEventHandler("activeShield",root,function(state)
	ShieldAgents[source] = state
end)

function damage(attacker, wep, body, loss)
	if ( not wasEventCancelled() ) then
		if attacker and isElement(attacker) and getElementType(attacker) == "player" then
			if attacker ~= source then
				if ((not isPedInVehicle(source)) and (not isPedInVehicle(attacker)) ) or ((not isPedInVehicle(source)) and (isPedInVehicle(attacker))) then
					if ShieldAgents[source] == true then
						if wep >= 33 and wep ~= 16 and wep ~= 17 and wep ~= 35 and wep ~= 36 and wep ~= 39 and wep ~= 38 then
							cancelEvent()
							triggerServerEvent("AgentArmorSet",source,13,1,attacker, wep)
							--setElementHealth(source,getElementHealth(source)+(loss/4))

						elseif wep >= 22 and wep < 33 and wep ~= 16 and wep ~= 17 and wep ~= 35 and wep ~= 36 and wep ~= 39  and wep ~= 38 then
							cancelEvent()
							triggerServerEvent("AgentArmorSet",source,8,2,attacker, wep)
							--setElementHealth(source,getElementHealth(source)+(loss/1.5))
						end

					end
				end
			end
		end
	end
end
addEventHandler("onClientPlayerDamage",localPlayer,damage)

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

function dxDrawDrugName()
	if exports.server:isPlayerLoggedIn(localPlayer) then
		for i,v in ipairs(getElementsByType("player")) do
			if v and (getElementData(v, "tws_enabled")) then
				if getElementDimension(localPlayer) == getElementDimension(v) then
					local x,y,z = getElementPosition(v)
					local x2,y2,z2 = getElementPosition(localPlayer)
					local cx,cy,cz = getCameraMatrix()
					local name = "Currently using TWS"
					if getDistanceBetweenPoints3D(cx,cy,cz,x,y,z) <= 25 then
						local px,py = getScreenFromWorldPosition(x,y,z,0.06)
						if px and py then
							if z2 <= z+4 then
								local width = dxGetTextWidth(name,1,"sans")
								dxDrawBorderedText(name, px, py, px, py, tocolor(255, 0, 0, 255), 1.2, "sans", "center", "center", false, false)			
							end
						end
					end
				end
			end
		end
	end
end
addEventHandler("onClientRender", root, dxDrawDrugName)