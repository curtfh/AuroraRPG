function glue ( playerSource, commandName )
    triggerClientEvent ( playerSource, "onGlue", playerSource )
end
addCommandHandler ( "glue", glue )

function unglue ( playerSource, commandName )
    triggerClientEvent ( playerSource, "onUnGlue", playerSource)
end
addCommandHandler ( "unglue", unglue )

addEventHandler( "onPlayerWasted", getRootElement( ),
	function()
		setElementData(source,"isPlayerGlued",false)
	end
)