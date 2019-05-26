addEventHandler( "onResourceStart", root,
	function ()
		for _, v in pairs( getElementsByType( "player" ) ) do
			resendPlayerModInfo( v )
		end
	end
)

addEventHandler( "onPlayerJoin", root, 
	function ()
		resendPlayerModInfo( source )
	end
)

addEventHandler( "onPlayerModInfo", root, 
	function ( filename, itemlist )
		-- Since itemlist returns a table, we loop through it
		for index, key in pairs( itemlist ) do
			-- If the name of the modded file matches what we want
			if ( key.name == "dynamic.col" ) then
				-- Kick the source player
				kickPlayer( source, "NGCanticheat", "Modified dynamic2.col. Please use original" )
				return true
			end
		end
	end
)
