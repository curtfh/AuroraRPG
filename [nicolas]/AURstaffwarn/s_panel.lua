local KickCount = {}

addEvent("WarnSys",true)
addEventHandler("WarnSys",root,function(txt,plrName)
	if ( KickCount[plrName] ) then
		KickCount[plrName] = KickCount[plrName] + 1
	else
		KickCount[plrName] = 1
	end
	if ( KickCount[plrName] == 3 ) then
		--ckPlayer(source)
	end
	outputChatBox ( "".. plrName.." has been warned by "..getPlayerName(source).." for ("..txt..")",root,255,0,0,true)
	exports.NGCdxmsg:createNewDxMessage(root,"".. plrName.." has been warned by "..getPlayerName(source).." for ("..txt..")",255,0,0,true)
end)


------------------------------------------------------------------
function showPanel(thePlayer)
	if getTeamName(getPlayerTeam(thePlayer)) == "Staff" then
			triggerClientEvent (thePlayer, "main.windows", getRootElement())
	   else
	   outputChatBox ("", thePlayer, 193, 13, 13)	
	end
end

function onResStart ()
    for index, player in ipairs ( getElementsByType ( "player" ) ) do
        addCommandHandler("warn",showPanel)           
    end
end
addEventHandler ( "onResourceStart", getResourceRootElement ( getThisResource() ), onResStart)

function onPlayerJoin ()
    addCommandHandler("warn",showPanel)     
end
addEventHandler ( "onPlayerJoin", getRootElement(), onPlayerJoin)