function replySms ( playerSource, commandName, ... )
	local msg = table.concat({...}, " ")
    triggerClientEvent ( playerSource, "onSMS", playerSource, msg )
end
addCommandHandler ( "r", replySms )