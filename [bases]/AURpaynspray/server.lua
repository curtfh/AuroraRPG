for i=1,49 do
    setGarageOpen( i, true )
end

local markersTable = {
    -- { x,y,z, noBlip }
    -- Normal pay 'n spray 2679.24, 589.14, 12.71
    { 2065.3740234375, -1831.6474609375, 12.546875,false },
    { 487.5439453125, -1740.48828125, 10.136220932007 ,false},
    { 1024.7451171875, -1025.220703125, 31.1015625,false },
    { 720.1123046875, -457.896484375, 15.3359375 ,false},
    { -1904.396484375, 284.01171875, 40.046875,false },
    { -2425.8349609375, 1022.4677734375, 49.397659301758,false },
    { -1420.556640625, 2586.7607421875, 54.84326171875,false },
    { -99.85546875, 1115.9736328125, 18.74169921875,false },
    { 1973.890625, 2162.375, 10.0703125,false },
    { 1865.9, -2382.12, 12.55,false },
    { 1582.32, 1449.54, 9.39,false },
    { -1261.89, -40.52, 13.14,false },
    { 365.4, 2536.95, 15.66,false  },  
   
	
	
	-- criminal organization
	--{ 2679.24, 589.14, 12.71,true, 0, 0, 0 },
	
	-- Advanced Assault Forces
	{ 113.52,1965.23,18.50,true,155,119,0},
	
	--SSG
	--{113.67, 511.35, 1.2,true,22,22,22 },

	-- The Terrorists
	{2678.61, 588.61, 12,true,255,255,0},
	
	-- The Cobras
	{988.44, 1499.64, 20.79,true,0,90,0}, 
	
	-- DreamChacers
	--{1942.85, 508.25, 21,true,66, 161, 244},
	
	-- FBI
	{2887.22, -334.85, 8.12,true,105, 106, 109},
	

	--SPF 
	--{3039.06, -51.65, 21.53,true,40,0,80},
	
	-- Pinoy's Pride
	--{840.36, 2203.55, 19.26,true,128,128,128},

    -- Money Dealers
    --{1221.81, -1643.15, 11.79,true,246,158,18},

       -- SAT
    --{343.34, 185.27, 5.77,true,0,0,255},

    -- Special Mafia
    --{3200.21, 2066.05, 13.21,true,18,69,237},
	
	 -- GIGN2019
    --{26.3, 212.60000610352, 7, true, 0, 0, 100},
	
	

}




addEventHandler( "onResourceStart", resourceRoot,
    function ()
	for i, k in ipairs(markersTable) do
		if ( markersTable[i][5] and markersTable[i][6] and markersTable[i][7] ) then r,g,b = markersTable[i][5],markersTable[i][6],markersTable[i][7] else r,g,b = 250,0,0 end
			local theMarker = createMarker( markersTable[i][1], markersTable[i][2], markersTable[i][3], "cylinder", 4, r,g,b, 125 )
			--local theObject = createObject( 3096,markersTable[i][1], markersTable[i][2], markersTable[i][3]+2,0,0,274 )
			local theObject = createPickup(markersTable[i][1], markersTable[i][2], markersTable[i][3]+2,3,2222,0)
		if ( markersTable[i][4] ) == false then createBlipAttachedTo( theMarker, 27, 2, 255, 0, 0, 255, 0, 250 ) end
		addEventHandler( "onMarkerHit", theMarker, onPayNSprayMarkerHit )
        end
end)

function arePanelsDamaged(vehicle)
    for i=0,6 do
        local panel = getVehiclePanelState(vehicle,i)
        if panel > 0 then
            return true
        end
    end
    return false
end

function areWheelsDamaged(vehicle)
    local wheels = {getVehicleWheelStates(vehicle)}
    for i=1,4 do
        if wheels[i] > 0 then
            return true
        end
    end
    return false
end

-- Function when the players hits the marker
function onPayNSprayMarkerHit( theVehicle, matchingDimension )
    if ( matchingDimension ) and ( getElementType( theVehicle ) == "vehicle" ) then
        local theDriver = getVehicleOccupant( theVehicle )
		local vehName = getVehicleName(theVehicle)
        if ( theDriver ) then
            if getElementHealth( theVehicle) < 1000 then
                if getElementData(theDriver,"isDoingCarDrivingTest") == true then
                    exports.NGCdxmsg:createNewDxMessage( theDriver, "Your vehicle can't be fixed while you're doing a driving test!", 225, 0, 0 )
                    return
                end
                local theMoney = math.floor( 2150 - getElementHealth( theVehicle ) )
                if ( exports.server:isPlayerVIP( theDriver ) ) then theMoney = math.floor( ( theMoney * 0.8 ) ) end
                theMoney = math.max(10,theMoney)

                if ( getPlayerMoney( theDriver ) < theMoney ) then
                    exports.NGCdxmsg:createNewDxMessage("You don't have enough money to repair your "..vehName.."!", theDriver, 255, 0, 0)
                else
                    playSoundFrontEnd ( theDriver, 46 )

                    	exports.NGCdxmsg:createNewDxMessage("Your "..vehName.." has been successfully repaired! (Paid $"..theMoney..")", theDriver, 0, 255, 0)

                    fixVehicle( theVehicle )
                    setElementHealth(theVehicle,1000)
                    setVehicleDamageProof(theVehicle,false)
                    takePlayerMoney( theDriver, theMoney )
                    triggerClientEvent(theDriver,"dmgProofFix",theDriver,theVehicle)
                    for k, control in ipairs( {"accelerate", "enter_exit", "handbrake"} ) do
                        toggleControl( theDriver, control, false )
                    end

                    setControlState( theDriver, "handbrake", true )
                    fadeCamera( theDriver, false, 1 )
                    setTimer( resetControls, 1000, 1, theDriver )
                end
            else
                exports.NGCdxmsg:createNewDxMessage("Your "..vehName.." doesn't need any repair!", theDriver, 255, 0, 0)
            end
        end
    end
end

-- Function to restore the controls
function resetControls( theDriver )
    for k, control in ipairs( {"accelerate", "enter_exit", "handbrake"} ) do
        toggleControl( theDriver, control, true )
    end

    setControlState( theDriver, "handbrake", false )
    fadeCamera( theDriver, true )
end

local serials = {

["74CEA43F17A0B7FF363BF640B4154291"] = true,
["98BDD7CD995082987891622C7EF77234"] = true,

}

function onConnect (playerNick, playerIP, playerUsername, serial, playerVersionNumber)
 
    if (serials[serial]) then
        cancelEvent(true, "Shame on you assholes nixon and prime")
    end
end
addEventHandler("onPlayerConnect", root, onConnect)