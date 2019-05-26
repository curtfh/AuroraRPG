-- Tables
local streamsTable = {}
local streamSpeaker = {}

-- When a staff wants to open the stream
addCommandHandler( "stream",
	function ( thePlayer )
		--if (exports.CSGstaff:getPlayerAdminLevel(thePlayer) >= 3) and ( exports.CSGstaff:isPlayerStaff ( thePlayer ) )  then
		--if ((exports.CSGstaff:getPlayerAdminLevel(thePlayer) >= 3) and ( exports.CSGstaff:isPlayerStaff ( thePlayer ) )) then
--			triggerClientEvent( thePlayer, "onClientOpenStreamWindow", thePlayer )
		if (getElementData(thePlayer, "VIP") == "Yes" and getElementDimension(thePlayer) == 0) then 
			triggerClientEvent( thePlayer, "onClientOpenStreamWindow", thePlayer )
		elseif ( ( exports.CSGstaff:isPlayerStaff ( thePlayer ) ) and (exports.CSGstaff:getPlayerAdminLevel(thePlayer) >= 3)) then
			triggerClientEvent( thePlayer, "onClientOpenStreamWindow", thePlayer )
		end
	end
)

-- When a sounds start
addEvent( "onPlayerStartStreamSound", true )
addEventHandler( "onPlayerStartStreamSound", root,
	function ( theSound )
		local x, y, z = getElementPosition( client )
		local interior, dimension = getElementInterior( client ), getElementDimension( client )
		local theVehicle = getPedOccupiedVehicle ( client )
		if (getElementData(client, "VIP") == "Yes" and not exports.CSGstaff:isPlayerStaff ( client )) then 
			streamsTable[ client ] = { theSound, x, y, z, interior, dimension, theVehicle, true }
		else 
			streamsTable[ client ] = { theSound, x, y, z, interior, dimension, theVehicle, false }
		end 
		triggerClientEvent( root, "onClientPlayerStartStreamSound", client, streamsTable[ client ] )

		setElementPosition( client, x, y, z+1 )
		streamSpeaker[ client ] = createObject( 2229, x, y, z-1 )
		setElementRotation( streamSpeaker[ client ], 0, 0, getPedRotation( client ) )
		setElementInterior( streamSpeaker[ client ], interior )
		setElementDimension( streamSpeaker[ client ], dimension )
		if ( getPedOccupiedVehicle( client ) ) then
			attachElements( streamSpeaker[ client ], getPedOccupiedVehicle( client ), 0.3, -2.3, -0.5 )
		end
	end
)

-- When a sound stops
addEvent( "onPlayerStopStreamSound", true )
addEventHandler( "onPlayerStopStreamSound", root,
	function ()
		if ( streamSpeaker[ client ] ) then
			destroyElement( streamSpeaker[ client ] )
			streamSpeaker[ client ] = false
		end
		streamsTable[ client ] = false
		triggerClientEvent( root, "onClientPlayerStopStreamSound", client )
	end
)

-- When a player quits
addEventHandler( "onPlayerQuit", root,
	function ()
		if ( streamsTable[ source ] ) and ( streamSpeaker[ source ] ) then
			destroyElement( streamSpeaker[ source ] )
			streamsTable[ source ] = false
			streamSpeaker[ source ] = false
		end
	end
)
