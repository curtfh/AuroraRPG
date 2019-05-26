
forced_players = {}

startForcing = {}


addEvent("rules:forcerules", true )
addEventHandler("rules:forcerules", root,
	function( theAdmin, thePlayer, duration )
		if ( not theAdmin or not thePlayer or not duration ) then return end 
	    local username = exports.server:getPlayerAccountName( thePlayer )
	    local serial = thePlayer.serial 
	    if ( username ) and ( serial ) then 
	    	table.insert( forced_players, {username,serial,duration} )
	    	startForcing[thePlayer.serial] = duration
	    	triggerClientEvent( thePlayer, "rules:showrules", thePlayer, theAdmin, duration )
			thePlayer.dimension = 69
	    	outputChatBox("You have been forced to read the rules by "..theAdmin.." for "..duration.." minutes", thePlayer, 255, 0, 0 )
	    	outputChatBox(getPlayerName(thePlayer).." has been forced to read the rules by "..theAdmin.." for "..duration.." minutes", root, 255, 0, 0 )
			toggleAllControls(thePlayer, false)
	    end 
	end 
)

function openPanel( thePlayer ) 
	if ( exports.CSGstaff:isPlayerStaff( thePlayer ) ) then 
		triggerClientEvent( thePlayer, "rules:showGUI", thePlayer ) 
	else
	    return 
    end
end
addCommandHandler("forcerules", openPanel)	

addEvent("rules:unforcerules", true )
addEventHandler("rules:unforcerules", root,
    function( thePlayer )
        if ( not thePlayer ) then return end
        startForcing[thePlayer.serial] = nil
        for i, v in ipairs( forced_players ) do
            if ( v[1] == exports.server:getPlayerAccountName( thePlayer ) and v[2] == thePlayer.serial ) then
                outputChatBox("You are no longer forced to read the rules.", thePlayer, 0, 255, 0 )
                table.remove( forced_players, i )
                triggerClientEvent( thePlayer, "rules:removeforce", thePlayer )
				toggleAllControls(thePlayer, true)
                if thePlayer.frozen then thePlayer.frozen = false end
                if thePlayer.dimension == 69 then thePlayer.dimension = 0 end
            end
        end
    end
)

addEventHandler("onPlayerQuit", root, 
	function()
		for i, v in ipairs( forced_players ) do 
			if ( v[1] == exports.server:getPlayerAccountName( source ) and v[2] == source.serial ) then 
			    table.remove( forced_players, i )
			    table.insert( forced_players, {exports.server:getPlayerAccountName( source ), source.serial, startForcing[source.serial]} ) 
			end
		end
	end
)

addEventHandler("onServerPlayerLogin", root, 
    function()
    	for i, v in ipairs( forced_players ) do 
    		if ( v[1] == exports.server:getPlayerAccountName( source ) and v[2] == source.serial ) then 
    			theStaff = "AutoForce"
    			triggerClientEvent( source, "rules:showrules", source, theStaff, v[3] )
				toggleAllControls(source, false)
    		end
    	end
    end
)


addEvent("rules:forcerules", true )
addEventHandler("rules:forcerules", root,
    function( theAdmin, thePlayer, duration )
        if ( not theAdmin or not thePlayer or not duration ) then return end
        local username = exports.server:getPlayerAccountName( thePlayer )
        local serial = thePlayer.serial
        if ( username ) and ( serial ) then
            table.insert( forced_players, {username,serial,duration} )
            startForcing[thePlayer.serial] = duration
            triggerClientEvent( thePlayer, "rules:showrules", thePlayer, theAdmin, duration )
            outputChatBox("You have been forced to read the rules by "..theAdmin.." for "..duration.." minutes", thePlayer, 255, 0, 0 )
			toggleAllControls(thePlayer, false)
            if not thePlayer.frozen then thePlayer.frozen = true end
            if not thePlayer.dimension == 69 then thePlayer.dimension = 69 end
        end
    end
)