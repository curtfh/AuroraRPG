addEvent("iGotTaz",true)
addEventHandler("iGotTaz",localPlayer,function(i)

	setElementData(localPlayer,"tazed",true)
	setTimer(function()
		setControlState("jump",false)
		toggleControl("jump",false)
	end,50,35)
	local prisoner = localPlayer
	if i == 1 then
--		setGravity(0.1)
		setTimer(function() setPedAnimation(prisoner, "CRACK", "crckidle2") end,2000,1)
			setTimer(setPedAnimation, 3800, 1, prisoner)
			toggleControl("fire",false)
			setControlState("jump",false)
			toggleControl("jump",false)
			toggleControl("sprint",false)
			setControlState("walk",true)
			toggleControl("aim_weapon",false)
			setTimer(function()
			toggleControl("jump",true)
			toggleControl("sprint",true)
			toggleControl("fire",true)
			toggleControl("aim_weapon",true)
			setControlState("walk",false)
			setElementData(localPlayer,"tazed",false)
		--	setGravity(0.008)
			end,3800,1)
	elseif i == 2 then
		setTimer(function() setPedAnimation(prisoner, "CRACK", "crckidle2") end,2000,1)
			setTimer(setPedAnimation, 4000, 1, prisoner)
			toggleControl("fire",false)
			setControlState("jump",false)
			toggleControl("jump",false)
			toggleControl("sprint",false)
			setControlState("walk",true)
			toggleControl("aim_weapon",false)
			setTimer(function()
			toggleControl("jump",true)
			toggleControl("sprint",true)
			toggleControl("fire",true)
			toggleControl("aim_weapon",true)
			setControlState("walk",false)
			setElementData(localPlayer,"tazed",false)
		--	setGravity(0.008)
			end,4000,1)
	end
end)

local peds = {}
addEvent("recTazTimeToHit",true)
addEventHandler("recTazTimeToHit",root,function(p)
	peds[p] = getTickCount()
end)

local success = {}

addEvent("removeTimeToHit",true)
addEventHandler("removeTimeToHit",root,function(p)
	peds[p] = getTickCount()-6000
	success[p] = true
end)

addEventHandler( "onClientRender",root,
   function( )
      local px, py, pz, tx, ty, tz, dist
      px, py, pz = getCameraMatrix( )
      for v,tim in pairs( peds ) do
		if (tim) then
		-- if getElementType(v) == "ped" then
		if v and isElement(v) then
         tx, ty, tz = getElementPosition( v )
         dist = math.sqrt( ( px - tx ) ^ 2 + ( py - ty ) ^ 2 + ( pz - tz ) ^ 2 )
         if dist < 50.0 then
            if isLineOfSightClear( px, py, pz, tx, ty, tz, true, false, false, true, false, false, false,localPlayer ) then
               local sx, sy, sz = 0,0,0
			   local x = false
			   if v and isElement(v) and getElementType(v) == "player" then
					sx, sy, sz = getPedBonePosition( v, 5 )
					x,y = getScreenFromWorldPosition( sx, sy, sz + 0.3 )
				else
					sx, sy, sz = getElementPosition( v )
					x,y = getScreenFromWorldPosition( sx, sy, sz + 1.2 )
			   end


               if x then -- getScreenFromWorldPosition returns false if the point isn't on screen
			   local r,g,b = 255,0,0
			   local txt = ""
			   local theTim = 0
			   local diff = getTickCount() - tim
			   theTim = 8000 - diff
			   theTim = theTim/1000
				if success[v] then
					txt = ">> Tazer - Target Neutralized <<"  r,g,b = 0,255,0
				else
					txt = ">> Tazer - Hit within "..math.floor(theTim).."s <<"  r,g,b = 255,255,0
				end
                dxDrawText( txt, x, y, x, y, tocolor(r,g,b), 0.85 + ( 15 - dist ) * 0.03)
				if theTim <= 0 then
					peds[v] = nil
					success[v] = nil
				end
               end
            end
            end
         end
		end
      end
   end
)

--[[

local lawTeams = {
	["GIGN"] = true,
	["Military Forces"] = true,
	["Government"] = true
}

addEventHandler("onClientPlayerDamage", root,
	function (attacker, weapon, _, loss)
		if (source:getData("tased")) then return end
		if (source.alpha ~= 255) then return end
		if (source.inVehicle) then return end
		if (exports.server:isPlayerArrested(source)) then return end
		if (exports.server:getPlayChatZone(source) == "LS" or exports.server:getPlayChatZone(source) == "SF") then return end
		if (attacker and isElement(attacker) and attacker.type == "player") then
			if (lawTeams[attacker.team.name] and (not lawTeams[source.team.name])) then
				if (weapon == 23 and source:getData("wantedPoints") >= 10) then
					cancelEvent()
					if (getDistanceBetweenPoints3D(source.position, attacker.position) <= 10) then
						local success = math.random(0, 100)
						local check = 40
						if (source.ping >= 200 and source.ping < 300) then
							check = 30
						elseif (source.ping >= 300 and source.ping < 400) then
							check = 20
						elseif (source.ping >= 400) then
							check = 10
						end
						if (success >= check) then
							triggerEvent("onClientPlayerTased", source, attacker)
							triggerServerEvent("onPlayerTased", source, attacker)
						end
					end
				end
			end
		end
	end
)

addEventHandler("onClientKey", root,
	function ()
		if (localPlayer:getData("tased")) then
			toggleAllControls(false, false)
			localPlayer.weaponSlot = 0
		else
			toggleAllControls(true, true)
		end
	end
)]]--