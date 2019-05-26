function addPJfction (paintjobID,player)
     triggerClientEvent (getRootElement(),"addPJ2", getRootElement(),paintjobID, player )
end
addEvent( "addPJ", true )
addEventHandler( "addPJ", resourceRoot, addPJfction )

function removePJfction (player)
     triggerClientEvent (getRootElement(),"removePJ2", getRootElement(),player )
end
addEvent( "removePJ", true )
addEventHandler( "removePJ", resourceRoot, removePJfction )