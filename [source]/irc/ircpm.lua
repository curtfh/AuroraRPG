function ircc(thePlayer, cmd, user, ...)
    local text = table.concat( {...}, " " )
    local name = getPlayerName( thePlayer )
	local userr = exports.irc:ircGetUserFromNick( user )
	local server = exports.irc:ircGetUserServer( exports.irc:ircGetUserFromNick( "Aurora" ) )
	if (userr and #text > 0) then
		exports.irc:ircRaw(server,"PRIVMSG " ..tostring(user).. " You received a private in game msg from " ..tostring( name ) )
		exports.irc:ircRaw(server,"PRIVMSG " ..tostring(user).. " msg: " ..tostring(text))
		exports.NGCdxmsg:createNewDxMessage(thePlayer,"Your message was sent to " ..tostring(user).. " on IRC",0,255,0)
		exports.CSGlogging:createLogRow( thePlayer, "IRCPM", "-> "..user..": "..text )
	else
		exports.NGCdxmsg:createNewDxMessage(thePlayer, "The player is not available at IRC!", 255, 0, 0 )
	end
end
addCommandHandler( "ircpm", ircc )
