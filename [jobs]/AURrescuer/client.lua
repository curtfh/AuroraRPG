local chauffeurSkins = { [18]=true, [35]=true, [45]=true }

local Rescuers = { [472]=true}

local playerClients = { }

local playerCols = { }

local playerBlips = { }

local jobClients = { }

local playerJobLocation = {  }




local money = 0

local timee = 0



local RescuerLocations = {
--[[
[1]={ 170.98 ,-2422.04 ,-0.56 },

[2]={ 153.51 ,-2612.05 ,-0.56},

[3]={ 175.74 ,-2606.12 ,-0.21 },

[4]={ 305.77 ,-2608.96 ,-0.56 },

[5]={ 305.07 ,-2536.87 ,-0.39 },

[6]={ 443 ,-2519.46 ,-0.56 },

[7]={ 430.58 ,-2613.17 ,-0.56 },

[8]={ 586.75 ,-2585.64 ,-0.56 },

[9]={ 570.76 ,-2505.61 ,-0.52 },

[10]={ 668.81 ,-2415.14 ,-0.28 },

[11]={ 668.52 ,-2568.22 ,-0.56 },

[12]={ 541.37 ,-2668.3 ,-0.56 },

[13]={ 541.17 ,-2668.42 ,-0.45 },

[14]={ 472.68 ,-2714.36 ,-0.4 },

[15]={ 436.46 ,-2758.92 ,-0.31 },

[16]={ 334.1 ,-2742.74 ,-0.56 },

[17]={ 258.35 ,-2737.31 ,-0.81 },

[18]={ 272.33 ,-2781.64 ,-0.56 },

[19]={ 321.81 ,-2752.86 ,-0.66 },

[20]={ 531.91 ,-2690.15 ,-0.21 },

[21]={ 430.91 ,-2030.58 ,-0.21 },

[22]={ 317.88 ,-2276.54 ,-0.21 },

[23]={ 218.42 ,-2332.18 ,-0.3 },

[24]={ 215.01 ,-2448.52 ,-0.35 },

[25]={ 207.5 ,-2264.21 ,-0.63 }]]

[1] = {-2706.07, 1749.03, 0.05,12.530517578125},

[2] = {-2633.36, 1619.57, 0.21,152.90966796875},

[3] = {-2190.57, 1849.92, 0.14,68.93603515625},

[4] = {-2007.55, 2159.34, 0.22,139.43768310547},

[5] = {-2160.63, 2336.48, 0.03,179.22906494141},

[6] = {-2584.8, 2190.09, 0.19,224.66162109375},

[7] = {-3049.26, 2448.47, -0.42,359.39733886719},

[8] = {-3114.99, 1711.06, -0.11,324.30541992188},

[9] = {-3011.34, 1053.42, -0.43,172.95959472656},

[10] = {-2337.69, 1510.55, 0.17,93.691162109375},


[11] = {-1952.49, 1608.48, 0.47,80.216369628906},


[12] = {-1853.33, 1907.82, -0.21,356.87231445313},

[13] = {-1759.56, 1546.13, -0.07,186.12200927734},


[14] = {-1623.93, 1620.84, -0.49,5.9568481445313},

[15] = {-1864.4, 1493.38, 0.21,174.82421875},
}



local dropoffs = {
--[[
[1]={ 267.28, -1908.23, -0.56  },

[2]={ 350.86, -1913.29, -0.37 },

[3]={ 405.25, -1915.08, -0.56 },

[4]={ 468.08, -1904.69, -0.57  },

[5]={ 545.63, -1920.09, -0.56 },

[6]={ 623.67, -1926.33, -0.56},

[7]={ 678.44, -1930.2, -0.56}]]

[1] = {-2923.79, 1224.04, -0.25,276.03271484375},
[2] = {-2747.66,1344.97,0.03,177},
[3] = {-2864.96,1268.43,-0.18,203},

}





 local vipSkins = {

[1]={ 17 },

[2]={ 43 },

[3]={ 46 },

[4]={ 55 },

[5]={ 57 },

[6]={ 70 },

[7]={ 120 },

[8]={ 165 },

[9]={ 185 },

[10]={ 217 },

[11]={ 228 },

[12]={ 294 },

[13]={ 295 }

}



function startJob ( thePlayer)

if thePlayer == getLocalPlayer() then

local occc = exports.server:getPlayerOccupation(thePlayer)

if ( occc == "Rescuer Man") and ( getTeamName( getPlayerTeam( thePlayer ) ) == "Civilian Workers") then

	local x, y, z = getElementPosition ( thePlayer )

	local playerVehicle = getPedOccupiedVehicle ( thePlayer )

	if ( getElementModel ( playerVehicle ) == 472 ) then

		pass = getElementData(thePlayer, "rescuer")

		if not playerClients[ thePlayer ] then

			local numLocations = #RescuerLocations

			if ( numLocations > 0 ) then

				repeatCount = 0

				repeat

					pickupx, pickupy, pickupz = unpack ( RescuerLocations [ math.random ( #RescuerLocations ) ] )

					local jobDistance = getDistanceBetweenPoints3D ( x, y, z, pickupx, pickupy, pickupz )

					repeatCount = repeatCount+1

				until jobDistance > 10 and jobDistance < 20 + repeatCount*100

				if  playerVehicle  then

					local skins = unpack ( vipSkins [ math.random ( #vipSkins ) ] )

					ped = createPed( skins, pickupx, pickupy, pickupz )



					function stopDamage(attacker, weapon, bodypart)

						cancelEvent()

					end

					addEventHandler("onClientPedDamage", ped, stopDamage)

					setElementFrozen ( ped, true)



				end

				playerClients[ thePlayer ] = {  }

				table.insert( playerClients[ thePlayer ], ped )

				table.insert( jobClients, ped )



				local pedBlip = createBlipAttachedTo ( ped, 41, 2, 255, 0, 0, 255, 1, 99999999.0)

				playerBlips[ thePlayer ] = {  }

				table.insert( playerBlips[ thePlayer ], pedBlip )



				pedMarker = createMarker ( pickupx, pickupy, 0, cylinder, 6.5, 255, 255, 0, 150)

				playerCols[ thePlayer ] = {  }

				table.insert( playerCols[ thePlayer ], pedMarker )

				local loc = getZoneName ( pickupx, pickupy, pickupz )

				local cityy = getZoneName ( pickupx, pickupy, pickupz, true )

				addEventHandler( "onClientMarkerHit", pedMarker, arrivePickup )

				exports.NGCdxmsg:createNewDxMessage("Someone is drown! Go rescue him at " ..loc.. ", " ..cityy,0, 255, 0)

				jobDistance = getDistanceBetweenPoints3D ( x, y, z, pickupx, pickupy, pickupz )

				timee = round(jobDistance/2)

			    if isTimer(tmr) then killTimer(tmr) end

				tmr = setTimer( function ()

					timee = timee - 1

					if timee <= 0 and isPedInVehicle(thePlayer) then

						exports.NGCdxmsg:createNewDxMessage("Time finished",255, 0, 0)

						stopJob(thePlayer)

						startJob(thePlayer)

					elseif timee <= 0 and not isPedInVehicle(thePlayer) then

						timee = 0

						if isTimer(tmr) then killTimer(tmr) end

					end

				end , 1000,	tonumber(timee))

			else

				exports.NGCdxmsg:createNewDxMessage("No one is drown, re-enter your vehicle",0, 255, 0)

			end

		else

			exports.NGCdxmsg:createNewDxMessage("You already have a mission",0, 255, 0)

		end

	end

end

end

end

addEventHandler ("onClientVehicleEnter", getRootElement(), startJob)





function arrivePickup ( thePlayer )

if thePlayer == getLocalPlayer() then

local occc = exports.server:getPlayerOccupation(thePlayer)

if ( occc == "Rescuer Man") and ( getTeamName( getPlayerTeam( thePlayer ) ) == "Civilian Workers") then

    if playerClients[ thePlayer ] then

        for k, ped in pairs( playerClients[ thePlayer ] ) do

            if ped then

                local x,y,z     = getElementPosition(ped)

                local tx,ty,tz  = getElementPosition(thePlayer)

                setPedRotation(ped, findRotation(x,y,tx,ty) )

                local numLocations = #dropoffs

                if ( numLocations > 0 ) then

				local playerVehicle = getPedOccupiedVehicle ( thePlayer )

                    if playerVehicle and Rescuers[getElementModel ( playerVehicle )] then

                        local speedx, speedy, speedz = getElementVelocity ( thePlayer )

                        local actualspeed = (speedx^2 + speedy^2 + speedz^2)^(0.5)

                        if actualspeed < 0.25 then

									setElementFrozen ( playerVehicle, true )

									fadeCamera ( false, 1.0, 0, 0, 0 )

									setTimer ( fadeCamera, 3000, 1,  true, 0.5 )

									setElementFrozen ( playerVehicle, false)

									attachElements ( ped, playerVehicle, 0, -1, 1 )

									end

									local peddVehicle = getPedOccupiedVehicle ( ped )

									if peddVehicle ~= playerVehicle then

										destroyElement(ped)

									end

                                    if playerBlips[ thePlayer ] then

                                        for k, blip in pairs( playerBlips[ thePlayer ] ) do

                                            if blip then

                                                destroyElement( blip )

                                                playerBlips[ thePlayer ] = nil

                                            end

                                        end

                                    end

                                    if playerCols[ thePlayer ] then

                                        for k, col in pairs( playerCols[ thePlayer ] ) do

                                            if col then

                                                destroyElement( col )

                                                playerCols[ thePlayer ] = nil

                                            end

                                        end

                                    end



                                    playerJobLocation[ thePlayer ] = {  }

                                    playerJobLocation[ thePlayer ] = { ["x"]=x, ["y"]=y, ["z"]=z }



                                    repeat

                                        dropOffx, dropOffy, dropOffz = unpack ( dropoffs [ math.random ( #dropoffs ) ] )

                                        local jobDistance = getDistanceBetweenPoints3D ( x, y, z, dropOffx, dropOffy, dropOffz )

                                    until jobDistance > 10 and jobDistance < 3000



                                    local dropOffBlip = createBlip ( dropOffx, dropOffy, dropOffz, 41, 2, 255, 0, 0, 255, 1, 99999.0)

                                    setBlipVisibleDistance(dropOffBlip, 3000)

									playerBlips[ thePlayer ] = {  }

                                    table.insert( playerBlips[ thePlayer ], dropOffBlip )



                                    pedMarkerr = createMarker ( dropOffx, dropOffy, 0, cylinder, 6.5, 255, 255, 0, 150)

                                    playerCols[ thePlayer ] = {  }

                                    table.insert( playerCols[ thePlayer ], pedMarkerr )

                                    addEventHandler( "onClientMarkerHit", pedMarkerr, arriveDropOff )

									local loc = getZoneName ( dropOffx, dropOffy, dropOffz )

									local cityy = getZoneName ( dropOffx, dropOffy, dropOffz, true )

									exports.NGCdxmsg:createNewDxMessage(playerSource,"Good Job! Now take him to " ..loc.. ", " ..cityy,0, 255, 0)

                        else

							exports.NGCdxmsg:createNewDxMessage("Slow down to pick up him!",230, 25, 0)

                        end

                    else

						exports.NGCdxmsg:createNewDxMessage("You don't have the correct boat",255,0, 0)

                    end

                else

					exports.NGCdxmsg:createNewDxMessage("No one is drown, re-enter your vehicle",255, 0, 0)

                 end

            end

        end

    end

end

end





function arriveDropOff ( thePlayer )

if thePlayer == getLocalPlayer() then

local occc = exports.server:getPlayerOccupation(thePlayer)

if ( occc == "Rescuer Man") and ( getTeamName( getPlayerTeam( thePlayer ) ) == "Civilian Workers") then

    if playerClients[ thePlayer ] then

        for k, ped in pairs( playerClients[ thePlayer ] ) do

            if ped then

				local playerVehicle = getPedOccupiedVehicle ( thePlayer )

                if playerVehicle and Rescuers[getElementModel ( playerVehicle )] then

						local speedx, speedy, speedz = getElementVelocity ( thePlayer )

						local actualspeed = (speedx^2 + speedy^2 + speedz^2)^(0.5)

						if actualspeed < 0.42 then

							if playerClients[ thePlayer ] then

								for k, ped in pairs( playerClients[ thePlayer ] ) do

									if ped then

										if isElement(ped) then destroyElement( ped ) end

										playerClients[ thePlayer ] = nil

									end

								end

								for k, blip in pairs( playerBlips[ thePlayer ] ) do

									if blip then

										destroyElement( blip )

										playerBlips[ thePlayer ] = nil

									end

								end

								for k, col in pairs( playerCols[ thePlayer ] ) do

									if col then

										destroyElement( col )

										playerCols[ thePlayer ] = nil

									end

								end



									setElementFrozen ( playerVehicle, true )

									fadeCamera ( false, 1.0, 0, 0, 0 )

									setTimer ( fadeCamera, 3000, 1, true, 0.5 )

									setElementFrozen ( playerVehicle, false )



								dx = tonumber(playerJobLocation[ thePlayer ]["x"])

								dy = tonumber(playerJobLocation[ thePlayer ]["y"])

								dz = tonumber(playerJobLocation[ thePlayer ]["z"])


									pass = tonumber(pass) + 1







								local tx,ty,tz  = getElementPosition(thePlayer)

								local jobDistance = getDistanceBetweenPoints3D ( dx, dy, dz, tx, ty, tz )

								local jobDistanceKM = round(jobDistance)

								local jobReward = round(300+(jobDistanceKM))



								for k, jobLocation in pairs( playerJobLocation[ thePlayer ] ) do

									if jobLocation then

										playerJobLocation[ thePlayer ] = nil

									end

								end



								triggerServerEvent("giveRescuerMoney", getLocalPlayer(),  jobReward )



								setElementData(thePlayer, "rescuer", tostring(pass))



								money = money + jobReward

								triggerServerEvent("giveRescuerScore", getLocalPlayer(), 0.5)



								exports.NGCdxmsg:createNewDxMessage("Job succesful, you earned "..jobReward.."$ +0.5 score",0, 255, 0)

								exports.CSGgps:resetDestination()

								setTimer(startJob, 6000, 1, thePlayer )


							end

						else

						exports.NGCdxmsg:createNewDxMessage("Slow down to drop him",255, 255, 0)

						end

				else

				exports.NGCdxmsg:createNewDxMessage("You don't have the correct boat!",255, 0, 0)

				end

			end

		end

	end

end

end

end



function stopJob ( thePlayer )

	if thePlayer == getLocalPlayer() then

		local occc = exports.server:getPlayerOccupation(thePlayer)

		if ( occc == "Rescuer Man") and ( getTeamName( getPlayerTeam( thePlayer ) ) == "Civilian Workers") then

			if playerClients[ thePlayer ] then

				setElementData(thePlayer, "rescuer", tostring(pass))

				if isTimer(tmr) then killTimer(tmr) end

				timee = 0

				for k, ped in pairs( playerClients[ thePlayer ] ) do

					if ped then

						destroyElement( ped );

						playerClients[ thePlayer ] = nil;

					end

				end

				for k, blip in pairs( playerBlips[ thePlayer ] ) do

					if blip then

						destroyElement( blip );

						playerBlips[ thePlayer ] = nil;

					end

				end

				for k, col in pairs( playerCols[ thePlayer ] ) do

					if col then

						destroyElement( col );

						playerCols[ thePlayer ] = nil;

					end

				end

				if playerJobLocation[ thePlayer ] then

					for k, jobLocation in pairs( playerJobLocation[ thePlayer ] ) do

						if jobLocation then

							if isElement(jobLocation) then destroyElement( jobLocation ) end

							playerJobLocation[ thePlayer ] = nil;

						end

					end

				end

				exports.NGCdxmsg:createNewDxMessage("Job canceled.",255, 0, 0)

			else

				exports.NGCdxmsg:createNewDxMessage("You don't have an assignment!",255, 0, 0)

			end

		end

	end

end

addEventHandler ("onClientVehicleExit",getRootElement(), stopJob)

addEventHandler ("onClientVehicleExplode",getRootElement(), stopJob)





function findRotation(x1,y1,x2,y2)

    local t = -math.deg(math.atan2(x2-x1,y2-y1))

    if t < 0 then t = t + 360 end

    return t

end



function round(number, digits)

  local mult = 10^(digits or 0)

  return math.floor(number * mult + 0.5) / mult

end



--panel








function sayVoice(str)



	local x,y,z = getElementPosition(localPlayer)

	--currentVoice = playSound(str,x,y,z)

end

addEvent("rescuerManVoiceClient",true)

addEventHandler("rescuerManVoiceClient",localPlayer,sayVoice)




function togglePilotPanel()
	if getElementData(localPlayer,"Occupation") == "Rescuer Man" and getPlayerTeam(localPlayer) and getTeamName(getPlayerTeam(localPlayer)) == "Civilian Workers" then
		exports.CSGranks:openPanel()
	end
end
bindKey("F5","down",togglePilotPanel)








if fileExists("Rescuer_c.lua") == true then

	fileDelete("Rescuer_c.lua")

end
