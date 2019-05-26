-- Cancel the damage
addEventHandler ( "onClientPedDamage", root,
	function ()
		if ( getElementData( source, "showModelPed" ) == true ) then
			cancelEvent()
		end
	end
)
