addEventHandler( "onClientResourceStart", resourceRoot,
    function( )
		if (getPlayerName(getLocalPlayer()) == "Anubhav") then 
			setWorldSpecialPropertyEnabled( "aircars", true )
		end 
    end
)