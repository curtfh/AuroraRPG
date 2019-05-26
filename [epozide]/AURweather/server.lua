function weather ( playerSource, commandName, id )
    triggerClientEvent ( playerSource, "onWeather", playerSource, tonumber(id) )
end
addCommandHandler ( "weather", weather )

function day ( playerSource, commandName )
	triggerClientEvent ( playerSource, "onDay", playerSource )
end
addCommandHandler ( "day", day )

function night ( playerSource, commandName )
	 triggerClientEvent ( playerSource, "onNight", playerSource )
end
addCommandHandler ( "night", night )
