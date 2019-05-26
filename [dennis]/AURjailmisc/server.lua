addEvent( "setPlayerJailBug", true )
addEventHandler( "setPlayerJailBug", root,
	function ()
		if isPedInVehicle(source) then
				removePedFromVehicle(source)
			end
		setElementPosition( source,  918.3681640625,-2276.8415527344,739.86828613281 )
		setElementInterior( source, 0 )
		setElementDimension( source, 2 )
		setElementRotation(source,0,0,353)
	end
)
addEvent( "setPlayerJailDIM", true )
addEventHandler( "setPlayerJailDIM", root,
	function ()
		setElementDimension( source, 2 )
	end
)

addEvent( "setPlayerJail", true )
addEventHandler( "setPlayerJail", root,
	function ( damn )
		if ( damn == true ) then
			if isPedInVehicle(source) then
				removePedFromVehicle(source)
			end
			setElementPosition( source,  918.3681640625,-2276.8415527344,739.86828613281 )
			setElementDimension( source, 2 )
			setElementRotation(source,0,0,353)
		end
	end
)
