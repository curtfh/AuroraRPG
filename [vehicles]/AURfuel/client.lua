-- Some stats

-- Tables for the fuel markers
local pumpsMarkers = {}
local isPumping = false

local fuelPrice = 150*exports.AURtax:getCurrentTax()

local currentMarker

local doEventHandlers

local gscc = 0



local rx, ry = guiGetScreenSize()

local antiSpam = {}

fuels = {

    staticimage = {},

    radiobutton = {},

    button = {},

    window = {},

    label = {}

}

fuels.window[1] = guiCreateWindow((rx/2) - 210, (ry/2) - 130, 409, 303, "AUR ~ Fuel station", false)

guiWindowSetSizable(fuels.window[1], false)

guiSetVisible(fuels.window[1],false)

fuels.staticimage[1] = guiCreateStaticImage(9, 20, 390, 83, "logo.png", false, fuels.window[1])

fuels.staticimage[2] = guiCreateStaticImage(294, 113, 57, 44, "fuel.png", false, fuels.window[1])

fuels.label[1] = guiCreateLabel(253, 162, 143, 23, "Fuel Canister", false, fuels.window[1])

guiSetFont(fuels.label[1], "default-bold-small")

guiLabelSetHorizontalAlign(fuels.label[1], "center", false)

fuels.radiobutton[1] = guiCreateRadioButton(293, 190, 58, 24, "$"..(550*exports.AURtax:getCurrentTax()), false, fuels.window[1])

fuels.button[1] = guiCreateButton(137, 224, 141, 28, "Refuel/Buy", false, fuels.window[1])

guiSetProperty(fuels.button[1], "NormalTextColour", "FFAAAAAA")

fuels.button[2] = guiCreateButton(143, 258, 131, 26, "Close", false, fuels.window[1])

guiSetProperty(fuels.button[2], "NormalTextColour", "FFAAAAAA")

fuels.staticimage[3] = guiCreateStaticImage(57, 113, 64, 44, "fuel2.png", false, fuels.window[1])

fuels.label[2] = guiCreateLabel(19, 162, 143, 23, "Fuel", false, fuels.window[1])

guiSetFont(fuels.label[2], "default-bold-small")

guiLabelSetHorizontalAlign(fuels.label[2], "center", false)

fuels.radiobutton[2] = guiCreateRadioButton(63, 190, 100, 24, "Litre: $"..fuelPrice, false, fuels.window[1])

guiRadioButtonSetSelected(fuels.radiobutton[2], true)



function handlepanel(state)

	guiSetVisible(fuels.window[1],state)

	showCursor(state)

	guiSetText(fuels.label[1],"Fuel Canister:("..gscc..")")

end



addEventHandler("onClientGUIClick",root,function()

	if source == fuels.button[1] then

		if isTimer(antiSpam) then return false end

		antiSpam = setTimer(function() end,1500,1)

		if guiRadioButtonGetSelected(fuels.radiobutton[1]) then

			if tonumber(gscc) >= 0 and tonumber(gscc) < 3 then

				if getPlayerMoney(localPlayer) >= 550*exports.AURtax:getCurrentTax() then

					triggerServerEvent("buyFuelCan",localPlayer)

					gscc = (tonumber(gscc) + 1)

					guiSetText(fuels.label[1],"Fuel Canister:("..gscc..")")

				else

					exports.NGCdxmsg:createNewDxMessage("You don't have enough money to buy fuel canister!",255,0,0)

				end

			else

				exports.NGCdxmsg:createNewDxMessage("You have 3 Canisters you can't buy more!!",255,0,0)

			end

		elseif guiRadioButtonGetSelected(fuels.radiobutton[2]) then

			local theVehicle = getPedOccupiedVehicle( localPlayer )

			if ( getElementData( theVehicle, "vehicleFuel" ) >= 100 ) then

				exports.NGCdxmsg:createNewDxMessage ( "Your vehicle has already enough fuel!", 225, 0, 0 )

				return

				false

			else

				handlepanel(false)

				bindKey ( "space", "down", onRefuelVehicle )

				exports.NGCnote:addNote("fuel4","Hold spacebar if you want to refuel.", 0, 255, 0,5000 )

			end

		end

	elseif source == fuels.button[2] then

		handlepanel(false)

	end

end)



addCommandHandler("refuel",function()

	if isPedInVehicle(localPlayer) then

		exports.NGCdxmsg:createNewDxMessage("You can't refuel your vehicle while you're inside it!!",255,0,0)

		return

	end

	if isTimer(antiSpam) then

		exports.NGCdxmsg:createNewDxMessage("You can only use fuel canister one time each 5 seconds",255,0,0)

		return

	end

	if tonumber(gscc) > 0 then

		gscc = (tonumber(gscc) - 1)

		triggerServerEvent("onPlayerUsedRefuel",localPlayer)

		triggerServerEvent("onPlayerEffectRefuel",localPlayer)

		antiSpam = setTimer(function() end,5000,1)

		exports.NGCdxmsg:createNewDxMessage("Only "..gscc.." fuel canisters left",255,255,0)

	end

end)



addEvent("recgsc",true)

addEventHandler("recgsc",localPlayer,function(k)

	if k == nil or k == false then k = 0 end

	gscc=k

	if (tonumber(gscc) < 0) then gscc = 0 end

	if not tonumber(k) then gscc = 0 end

	if k == nil or k == false then gscc = 0 end

end)





-- When the player enters a vehicle

addEventHandler ( "onClientVehicleEnter", root,

	function ( thePlayer, seat )

		if ( thePlayer == localPlayer ) and ( seat == 0 ) then

			if ( fuelTimer ) and ( isTimer( fuelTimer ) ) then killTimer( fuelTimer ) end

			if not ( getElementData ( source, "vehicleFuel" ) ) then

				setElementData ( source, "vehicleFuel", 100 )

			elseif ( getElementData ( source, "vehicleFuel" ) <= 0 ) then

				disableVehicleFunctions( source )

			else

				enableVehicleFunctions( source )

			end



			if ( doEventHandlers ) then

				addEventHandler ( "onClientVehicleExit", source, onVehicleExitDestroy, false )

				addEventHandler ( "onClientElementDestroy", source, onVehicleExitDestroy, false )

				doEventHandlers = false

			end



			fuelTimer = setTimer ( onDecreaseFuel, 15000, 0 )

		end

	end

)



-- Disable all vehicle functions whenever the vehicle has no fuel left

function disableVehicleFunctions ( theVehicle )

	if ( fuelTimer ) and ( isTimer( fuelTimer ) ) then killTimer( fuelTimer ) end

	setVehicleEngineState( theVehicle, false )

	toggleControl ( "accelerate", false )

	toggleControl ( "brake_reverse", false )

	exports.NGCnote:addNote("fuel3", "This vehicle has no fuel left, call a mechanic to refuel it!", 0, 225, 0,10000 )

end



-- Enable the vehicle functions again

function enableVehicleFunctions( theVehicle )

	setVehicleEngineState( theVehicle, true )

	toggleControl ( "accelerate", true )

	toggleControl ( "brake_reverse", true )

end



-- When the resource starts

addEventHandler ( "onClientResourceStart", resourceRoot,

	function ()

		if ( getPedOccupiedVehicle ( localPlayer ) ) and ( getVehicleOccupant ( getPedOccupiedVehicle ( localPlayer ), 0 ) == localPlayer ) then

			doEventHandlers = true

			local theVehicle = getPedOccupiedVehicle ( localPlayer )

			if not ( getElementData ( theVehicle, "vehicleFuel" ) ) then

				setElementData ( theVehicle, "vehicleFuel", 100 )

			elseif ( getElementData ( theVehicle, "vehicleFuel" ) <= 0 ) then

				disableVehicleFunctions( theVehicle )

			end



			if ( doEventHandlers ) then

				addEventHandler ( "onClientVehicleExit", root, onVehicleExitDestroy, false )

				addEventHandler ( "onClientElementDestroy", root, onVehicleExitDestroy, false )

				doEventHandlers = false

			end



			fuelTimer = setTimer ( onDecreaseFuel, 12000, 0 )

		end

	end

)



-- Function when a vehicle gets destroyed or when a player exit the vehicle

function onVehicleExitDestroy ( theVehicle )

	local theVehicle = theVehicle or source

	if ( fuelTimer ) and ( isTimer( fuelTimer ) ) then killTimer( fuelTimer ) end



	if ( getElementData ( theVehicle, "vehicleFuel" ) ) then

		setElementData ( theVehicle, "vehicleFuel", getElementData ( theVehicle, "vehicleFuel" ) )

	end



	unbindKey ( "space", "down", onRefuelVehicle )

	unbindKey ( "space", "up", onStopRefuelVehicle )

	isPumping = false



	if ( theVehicle ) then

		removeEventHandler ( "onClientVehicleExit", theVehicle, onVehicleExitDestroy, false )

		removeEventHandler ( "onClientElementDestroy", theVehicle, onVehicleExitDestroy, false )

		doEventHandlers = true

	end

end



-- When the resource gets stopped

addEventHandler ( "onClientResourceStop", resourceRoot,

	function ()

		if ( getPedOccupiedVehicle ( localPlayer ) ) and ( getVehicleOccupant ( getPedOccupiedVehicle ( localPlayer ), 0 ) == localPlayer ) then

			onVehicleExitDestroy ( getPedOccupiedVehicle ( localPlayer ) )

		end

	end

)



-- Function that decreases the fuel

function onDecreaseFuel ()

	local theVehicle = getPedOccupiedVehicle ( localPlayer )

	if ( theVehicle ) then

		if ( getElementModel ( theVehicle ) == 509 ) or ( getElementModel ( theVehicle ) == 481 ) or ( getElementModel ( theVehicle ) == 510 ) then return end

		local theFuel = getElementData ( theVehicle, "vehicleFuel" )

		if not ( getTeamName( getPlayerTeam( localPlayer ) ) == "Staff" ) and ( theFuel ) and not ( isPumping ) and ( getVehicleEngineState ( theVehicle ) ) and ( theFuel > 0 ) and ( getVehicleOccupant ( getPedOccupiedVehicle ( localPlayer ), 0 ) == localPlayer ) then

			setElementData ( theVehicle, "vehicleFuel", theFuel - 1 )

			if ( getElementData ( theVehicle, "vehicleFuel" ) <= 0 ) then

				disableVehicleFunctions( theVehicle )

			end

		end

	end

end



-- Get the vehicle speed

function getVehicleSpeed ( theVehicle, unit )

	if ( unit == nil ) then unit = 0 end

	if ( isElement( theVehicle ) ) then

		local x,y,z = getElementVelocity( theVehicle )

		if ( unit=="mph" or unit==1 or unit =='1' ) then

			return ( x^2 + y^2 + z^2 ) ^ 0.5 * 100

		else

			return ( x^2 + y^2 + z^2 ) ^ 0.5 * 1.61 * 100

		end

	else

		return false

	end

end



-- When the player hits a fuel marker

function onFuelPumpMarkerHit ( hitElement, matchingDimension, msgs, theMarker )

	--outputDebugString("Running...")

	local theMarker = theMarker or source

	if ( hitElement ) and ( getElementType ( hitElement ) == "player" ) and ( matchingDimension ) and ( getPedOccupiedVehicle( hitElement ) ) and ( isFuelMarker ( theMarker ) ) and ( getVehicleController( getPedOccupiedVehicle( hitElement ) ) == localPlayer ) then

		--outputDebugString("Vehicle found")
		local px,py,pz = getElementPosition ( hitElement )
		local mx, my, mz = getElementPosition ( theMarker )
		if ( pz-5.5 < mz ) and ( pz+4.5 > mz ) then
			local theVehicle = getPedOccupiedVehicle( hitElement )

			outputDebugString("Vehicle ID: "..getElementModel(theVehicle))

			if (getElementModel(getPedOccupiedVehicle(localPlayer)) == 510) or (getElementModel(getPedOccupiedVehicle(localPlayer)) == 481) or (getElementModel(getPedOccupiedVehicle(localPlayer)) == 509) or (getElementModel(getPedOccupiedVehicle(localPlayer)) == 571) then exports.NGCdxmsg:createNewDxMessage("You can't refuel a bike",255,0,0) return false end

			if ( getVehicleSpeed ( theVehicle, "kmh" ) >= 1 ) then

				if ( msgs ~= 1 ) or ( msgs ~= 2 ) then

					exports.NGCnote:addNote("fuel1", "Please bring the vehicle to a complete stop!", 225, 0, 0 )

				end

				setTimer( onFuelPumpMarkerHit, 1000, 1, hitElement, true, 1, theMarker )

				--outputDebugString("Vehicle traveling too fast, timer set.")

			elseif ( getVehicleEngineState( theVehicle ) ) then

				if ( msgs ~= 2 ) then

					exports.NGCnote:addNote("fuel2", "Turn off the vehicle engine before refueling! Type /engine to toggle your engine.", 225, 0, 0 )

				end

				setTimer( onFuelPumpMarkerHit, 1000, 1, hitElement, true, 2, theMarker )

				--outputDebugString("Vehicle engine is on, timer set.")

			--elseif ( getElementData( theVehicle, "vehicleFuel" ) >= 100 ) then

			--	exports.NGCdxmsg:createNewDxMessage ( "Your vehicle has already enough fuel!", 225, 0, 0 )

				--outputDebugString("Fuel tank.")

			else

				--outputDebugString("Key binded.")

				currentMarker = theMarker

				--bindKey ( "space", "down", onRefuelVehicle )

				---exports.NGCdxmsg:createNewDxMessage ( "Hold spacebar if you want to refuel.", 0, 255, 0 )

				handlepanel(true)

			end

		end
	end

end



-- When the player hits a fuel marker

function onFuelPumpMarkerLeave ( hitElement, matchingDimension )

	if ( hitElement == localPlayer ) then

		unbindKey ( "space", "down", onRefuelVehicle )

		unbindKey ( "space", "up", onStopRefuelVehicle )

		handlepanel(false)

		isPumping = false

	end

end



-- When the player press the space button to refuell

function onRefuelVehicle ()

	if ( getPedOccupiedVehicle( localPlayer ) ) then

		local theVehicle = getPedOccupiedVehicle( localPlayer )

		if ( getPlayerMoney() < fuelPrice ) then

			exports.NGCdxmsg:createNewDxMessage ( "You don't have enough money, the price is $" .. fuelPrice .." per litre!", 255, 0, 0 )

		else

			local oldFuel = math.floor( getElementData ( theVehicle, "vehicleFuel" ) )

			setTimer ( onRefillVehicle, 250, 1, theVehicle, oldFuel )

			exports.NGCdxmsg:createNewDxMessage ( "Your vehicle is being filled, please wait...", 0, 255, 0 )



			isPumping = true



			unbindKey ( "space", "down", onRefuelVehicle )

			bindKey ( "space", "up", onStopRefuelVehicle )

		end

	else

		onStopRefuelVehicle ()

	end

end



-- Actualy refill the vehicle

function onRefillVehicle( theVehicle, oldFuel, price )

	if ( theVehicle ) and ( oldFuel ) then

		local theFuel = tonumber( oldFuel )

		local thePrice = tonumber( price ) or 0

		if not ( getKeyState ( "space" ) ) then

			onStopRefuelVehicle ( theFuel, thePrice, theVehicle )

		elseif ( getPlayerMoney() < fuelPrice ) and not ( getElementData( theVehicle, "vehicleOccupation" ) ) then

			exports.NGCdxmsg:createNewDxMessage ( "You don't have enough money to continue, the price is $" .. fuelPrice .." per litre!", 255, 0, 0 )

			onStopRefuelVehicle ( theFuel, thePrice, theVehicle )

		elseif ( oldFuel >= 100 ) then

			onStopRefuelVehicle ( theFuel, thePrice, theVehicle )

		else

			theFuel = math.floor( theFuel + 10 )

			thePrice = math.floor( thePrice + 20 )*exports.AURtax:getCurrentTax()

			setTimer ( onRefillVehicle, 250, 1, theVehicle, theFuel, thePrice )

			if theFuel >= 100 then

				theFuel = 100

			end

			setElementData ( theVehicle, "vehicleFuel", theFuel )

		end

	end

end



-- When the player stops pressing space or stop fuel

function onStopRefuelVehicle ( theFuel, thePrice, theVehicle )

	unbindKey ( "space", "up", onStopRefuelVehicle )

	isPumping = false



	if ( theFuel ) and ( thePrice ) and not ( tostring( theFuel ) == "space" ) then

		if ( tonumber( theFuel ) < 100 ) then bindKey ( "space", "down", onRefuelVehicle ) exports.NGCdxmsg:createNewDxMessage ( "Hold spacebar if you want to refuel more.", 225, 0, 0 ) end

		if ( theVehicle ) and ( getElementData( theVehicle, "vehicleOccupation" ) ) then

			exports.NGCdxmsg:createNewDxMessage ( "The company you work for paid your fuel, lucky bastard.", 0, 255, 0 )

		else

			triggerServerEvent ( "payFuelVehicle", localPlayer, thePrice )

			if ( thePrice ) then exports.NGCdxmsg:createNewDxMessage ( "You paid $" .. thePrice .. " for the refilling!", 0, 255, 0 ) end

		end

	end

end



function toggleEngine()

	local theVehicle = getPedOccupiedVehicle( localPlayer )

	if ( theVehicle ) and ( getVehicleController( theVehicle ) == localPlayer ) then

		local model = getElementModel(theVehicle)

		if model ~= 509 and model ~= 481 and model ~= 510 then -- if vehicle is not a bicycle
			local fuel = getElementData(theVehicle,"vehicleFuel") or 100


			if ( getVehicleEngineState( theVehicle )) then

				setVehicleEngineState( theVehicle, false )

				exports.NGCdxmsg:createNewDxMessage ( "Vehicle engine is now turned off!", 0, 255, 0 )



			elseif ( math.floor( getElementHealth( theVehicle ) ) <= 250 ) then

				exports.NGCdxmsg:createNewDxMessage ( "This vehicle is broken, request a mechanic to repair it!", 0, 255, 0 )

			elseif fuel and tonumber(fuel) <= 0 then

				setVehicleEngineState( theVehicle, false )

				exports.NGCdxmsg:createNewDxMessage ( "*** Engine Shutdown - No Fuel ***", 255, 255, 0 )

			else

				setVehicleEngineState( theVehicle, true )

				exports.NGCdxmsg:createNewDxMessage ( "Vehicle engine is now turned on!", 0, 255, 0 )

			end

		end

	end

end

-- Vehicle engine

addEvent( "onEngine", true )

addEventHandler( "onEngine", localPlayer, toggleEngine )

local pumpsTable = {
	-- SF GAS STATION NEAR SFPD
	{-1672.05, 405.35, 6.85, true },
	{-1666.75, 410.37, 6.85 },
	{-1679.24, 412.21, 6.85 },
	{-1673.81, 417.5, 6.85 },

	-- SF Juniper Hallow place.Near Jizzys club>Pay N spray Gas station
	{-2407.49, 971.53, 44.97, true },
	{-2407.56, 982.32, 44.97 },
	{-2414.68, 980.48, 44.97 },
	{-2414.68, 970.04, 44.97 },


	-- Angel Pine GAS STATION
	{-2249.57, -2558.71, 31.58, true },
	{-2239.06, -2563.1, 31.6 },
	{-2244.82, -2561.4, 31.6 },

	-- FLINT COUNTRY TRUCKER JOB GAS STATION
	{-95, -1161.41, 1.91, true },
	{-99.95, -1173.21, 2.12 },
	{-88.1, -1164.68, 1.96 },
	{-92.88, -1176.37, 1.88 },

	-- MONTGOMERY
	{1378.92, 458.36, 19.61, true },
	{1383.41, 456.51, 19.61 },
	{1385.15, 461.04, 19.8 },
	{1380.73, 463.16, 19.8 },

	-- LS DILIMORE PD GAS STATION
	{652.66, -560.14, 16.01, true },
	{652.74, -570.98, 16.01 },
	{658.22, -569.71, 16.01 },
	{658.27, -558.89, 16.01 },

	-- LV NEAR BASEBALL STADIUM GAS STATION
	{1590.09, 2190.96, 10.82, true },
	{1601.8, 2190.69, 10.82 },
	{1590.38, 2196.61, 10.82 },
	{1601.84, 2196.18, 10.82 },
	{1602.17, 2202.28, 10.82 },
	{1590.28, 2201.79, 10.82 },
	{1596, 2206.69, 10.82 },

	-- NORTH OF LV NEAR BURGER SHOT GAS STATION
	{2141.41, 2756.27, 10.82, true },
	{2153.37, 2756.49, 10.82 },
	{2153.23, 2750.65, 10.82 },
	{2141.55, 2750.51, 10.82 },
	{2147.46, 2740.06, 10.82 },

	-- NORTH OF LV NEAR LVPD GAS STATION
	{2194.45, 2470.04, 10.82, true },
	{2194.61, 2480.42, 10.82 },
	{2205.36, 2480.33, 10.82 },
	{2205.01, 2469.95, 10.82 },

	-- LV NEAR MF BASE GUNSHOP STOP/CARSHOP GAS STATIONS
	{618.93, 1684.98, 6.99 },
	{615.32, 1689.81, 6.99 },
	{612.02, 1694.95, 6.99 },
	{608.64, 1699.88, 6.99 },
	{605.27, 1704.75, 6.99 },

	-- SOUTH OF LV,GUNSHOP GAS STATION
	{2120.77, 928.59, 10.82, true },
	{2108.88, 928.72, 10.82 },
	{2120.69, 917.61, 10.82 },
	{2109.05, 917.79, 10.82 },

	-- SOUTH EAST OF LV GAS STATION COME A LOT NEAR THE PYRAMID
	{2634.68, 1097.78, 10.82, true },
	{2645.61, 1097.5, 10.82 },
	{2645.34, 1109.25, 10.82 },
	{2634.64, 1109.06, 10.82 },


	-- FORT CARSON NEAR CLUCKIN BELL
	{64.56, 1219.51, 18.82, true },
	{70.53, 1218.7, 18.81 },
	{76.42, 1217.21, 18.82 },

	-- EL QUEBRADOS GAS STATION
	{-1328.92, 2672.1, 50.06, true },
	{-1327.91, 2677.47, 50.06 },
	{-1327.51, 2682.94, 50.06 },

	-- LV DESERT-Tiera Robbada near Cluckin bell
	{-1477.61, 1857.44, 32.63, true },
	{-1464.91, 1857.88, 32.63 },
	{-1465.24, 1865.8, 32.63 },
	{-1477.75, 1865.01, 32.63 },

	-- LS GAS STATION NEAR EX.DOD BASE
	{999.97, -940, 42.17, true },
	{1007.03, -939.19, 42.17 },
	{1007.75, -933.45, 42.17 },
	{1000.55, -934.48, 42.17 },

	-- LS GAS STATION "Little Mexico"
	{1944.29, -1776.53, 13.39, true },
	{1944.3, -1769.2, 13.39 },
	{1938.93, -1769.1, 13.38 },
	{1938.91, -1776.63, 13.39 },

	-- Tiera Robbada Gas Station-Trucker stop.
	{-742.21, 2751.14, 47.22, true },

	-- Whetstone-24/7 shop near Angel Pine Gas station
	{-1602.46, -2709.84, 48.53, true },
	{-1605.85, -2714.2, 48.53 },
	{-1609.22, -2718.53, 48.53 },

	-- LS airport
	{1943.16, -2643.56, 13.54, true },
	{1973.68, -2642.29, 13.54 },
	{2006.33, -2641.51, 13.54 },
	{2042.73, -2640.8, 13.54 },

	-- LV airport
	{11332.48, 1571.46, 10.82, true },
	{11332.54, 1609.93, 10.82 },

	-- SF airport
	{-1308.82, 25.31, 14.14, true },
	{-1292.43, 8.07, 14.14 },
	{-1275.06, -9.45, 14.14 },

	-- Others
	{1326.45, 1391.54, 10.47, true },
	{1910.71, -2335.42, 13.25, true },
	{-2175.83, 2427.19, 0.75, true },
	{2372.07, 505.63, 0.47, true },
	{2285.01, -2501.6, 0.61, true },
	{-11.01, -1656.07, 0.53, true },
}

local blipsTable = {
	-- SF GAS STATION NEAR SFPD
	{-1672.05, 405.35, 6.85, true },

	-- SF Juniper Hallow place.Near Jizzys club>Pay N spray Gas station
	{-2407.49, 971.53, 44.97, true },


	-- Angel Pine GAS STATION
	{-2249.57, -2558.71, 31.58, true },

	-- FLINT COUNTRY TRUCKER JOB GAS STATION
	{-95, -1161.41, 1.91, true },

	-- MONTGOMERY
	{1378.92, 458.36, 19.61, true },

	-- LS DILIMORE PD GAS STATION
	{652.66, -560.14, 16.01, true },

	-- LV NEAR BASEBALL STADIUM GAS STATION
	{1590.09, 2190.96, 10.82, true },

	-- NORTH OF LV NEAR BURGER SHOT GAS STATION
	{2141.41, 2756.27, 10.82, true },

	-- NORTH OF LV NEAR LVPD GAS STATION
	{2194.45, 2470.04, 10.82, true },

	-- LV NEAR MF BASE GUNSHOP STOP/CARSHOP GAS STATIONS
	{622.3, 1679.94, 6.99, true },

	-- SOUTH OF LV,GUNSHOP GAS STATION
	{2120.77, 928.59, 10.82, true },

	-- SOUTH EAST OF LV GAS STATION COME A LOT NEAR THE PYRAMID
	{2634.68, 1097.78, 10.82, true },

	-- FORT CARSON NEAR CLUCKIN BELL
	{64.56, 1219.51, 18.82, true },
	-- EL QUEBRADOS GAS STATION
	{-1328.92, 2672.1, 50.06, true },

	-- LV DESERT-Tiera Robbada near Cluckin bell
	{-1477.61, 1857.44, 32.63, true },

	-- LS GAS STATION NEAR EX.DOD BASE
	{999.97, -940, 42.17, true },

	-- LS GAS STATION "Little Mexico"
	{1944.29, -1776.53, 13.39, true },

	-- Tiera Robbada Gas Station-Trucker stop.
	{-742.21, 2751.14, 47.22, true },

	-- Whetstone-24/7 shop near Angel Pine Gas station
	{-1602.46, -2709.84, 48.53, true },

	-- LS airport
	{1943.16, -2643.56, 13.54, true },

	-- LV airport
	{11332.48, 1571.46, 10.82, true },
	-- SF airport
	{-1308.82, 25.31, 14.14, true },

	-- Others
	{1326.45, 1391.54, 10.47, true },
	{1910.71, -2335.42, 13.25, true },
	{-2175.83, 2427.19, 0.75, true },
	{2372.07, 505.63, 0.47, true },
	{2285.01, -2501.6, 0.61, true },
	{-11.01, -1656.07, 0.53, true },
}

-- Create the markers and blips
addEventHandler ( "onClientResourceStart", resourceRoot,
	function ()
		for i=1,#pumpsTable do
			local x, y, z = pumpsTable[i][1], pumpsTable[i][2], pumpsTable[i][3]
			theMarker = createMarker ( x, y, z -1, "cylinder", 3.0, 255, 150, 0, 250 )
			table.insert ( pumpsTable, theMarker )
			if theMarker then
			addEventHandler ( "onClientMarkerHit", theMarker, onFuelPumpMarkerHit, false )
			addEventHandler ( "onClientMarkerLeave", theMarker, onFuelPumpMarkerLeave, false )
			end
			if ( pumpsTable[i][4] ) then exports.customblips:createCustomBlip ( x, y, 16, 16, "blip.png", 100 ) end
		end
	end
)


function showTextOnTopOfPed1()
	local x1, y1, z1 = getElementPosition(localPlayer)
	for ID in ipairs(blipsTable) do
		local mX1, mY1, mZ1 = blipsTable[ID][1], blipsTable[ID][2], blipsTable[ID][3]
		local jobb1 = "Fuel Station"
		local sx1, sy1 = getScreenFromWorldPosition(mX1, mY1, mZ1+10)
		if (sx1) and (sy1) then
			local distance1 = getDistanceBetweenPoints3D(x1, y1, z1, mX1, mY1, mZ1)
			if (distance1 < 30) then
				dxDrawText(jobb1, sx1-1, sy1-1, sx1, sy1, tocolor(0,0,0, 255), 5-(distance1/20), "pricedown", "center", "center")
				dxDrawText(jobb1, sx1+1, sy1+1, sx1, sy1, tocolor(0,0,0, 255), 5-(distance1/20), "pricedown", "center", "center")
				dxDrawText(jobb1, sx1+2, sy1+2, sx1, sy1, tocolor(255,150,0, 255), 5-(distance1/20), "pricedown", "center", "center")
			end
		end
	end
end
addEventHandler("onClientRender",root,showTextOnTopOfPed1)



-- Function for get all the fuel pump markers
function getFuelMarkers ()
	if ( pumpsMarkers ) then
		return pumpsMarkers
	else
		return false
	end
end

-- Check if a marker is a fuel marker
function isFuelMarker ( theMarker )
	for k, aMarker in ipairs ( pumpsTable ) do
		if ( aMarker == theMarker ) and ( isElementWithinMarker( localPlayer, theMarker ) ) then
			return true
		end
	end
	return false
end
