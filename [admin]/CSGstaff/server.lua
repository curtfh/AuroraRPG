-- Staff ranks
local spamTable = {}
local helpSpamTable = {}
local helpTable = {}
local adminTable = {}
local completeAdminTable = {}

-- Staff ranks
local staffRanks = {
	[0] = "Help Desk",
    [1] = "Trial Manager",
    [2] = "Manager",
    [3] = "Senior Manager",
    [4] = "Supervising Manager",
    [5] = "Executive Manager",
    [6] = "Head Manager",
	[7] = "AUR Developer",
    [8] = "Community Owner",
    [9] = ""
}

local webhook = "https://discordapp.com/api/webhooks/396160415840731156/G4M-XEeElH8VTUruz4Pl0uVm2wNPmfoeBDJil51BvALnJn1MtXTGRw8havv2_ChjrHJt"

--Prevent imposters
function scanForTag(old, new)
    if (type(string.find(string.lower(new), "[aur]", 1, true)) == "number" or type(string.find(string.lower(new), "[ngc]", 1, true)) == "number" or type(string.find(string.lower(new), "[csg]", 1, true)) == "number") then
        if (not adminTable[source]) then
            outputChatBox(old.." has been kicked", root, 255, 0, 0)
            --exports.AURnewDiscord:sendMessageToDiscord(webhook, getPlayerName(source).." kicked for using [AUR]/[CSG]/[NGC] in his name")
            kickPlayer(source, "AutoPunish", "You cannot use [AUR]/[CSG]/[NGC] tag. Please change your name.")
            cancelEvent()
        end
    end
    if (adminTable[source]) then
        if (string.match(new, "%d+")) then
            outputChatBox("Numbers are not allowed in your nickname", source, 255, 0, 0)
            setPlayerName(source, new:gsub("[0-9]", ""))
        end
    end
end
addEventHandler("onPlayerChangeNick",root,scanForTag)

-- Staff Job
local wp = {}

addCommandHandler( "staff",
    function ( thePlayer )
		--[[if (exports.server:getPlayerAccountName(thePlayer) == "boss55") then
			if (getElementData(thePlayer, "wantedPoints") < 10) then
				setElementData( thePlayer, "Occupation", "Tester", true)
				setElementModel( thePlayer, 217 )
				setPlayerTeam ( thePlayer, getTeamFromName( "Staff" ) )
				exports.server:updatePlayerJobSkin( thePlayer, 217 )
				setElementHealth( thePlayer, 100 )
				exports.DENvehicles:reloadFreeVehicleMarkers( thePlayer, true )
				triggerEvent("onPlayerJobChange", thePlayer, "Tester", false, getPlayerTeam( thePlayer ) )
				setPlayerNametagColor(thePlayer,255,255,255)
				exports.NGCdxmsg:createNewDxMessage( thePlayer, "You are now on-duty as staff!", 0, 225, 0 )
			end
		end]]
        if ( isPlayerStaff ( thePlayer ) ) then
			if getElementData(thePlayer,"wantedPoints") >= 10 then
				if wp[thePlayer] == false or not wp[thePlayer] or wp[thePlayer] == nil then
					exports.NGCnote:addNote("WPWarning", "(Warning - Staff) : #FFFFFFYou have WantedPoints! Use the command again in order to skip this", thePlayer, 255, 0, 100,8000 )
					wp[thePlayer] = true
					return
				end
			end
			
			if getElementDimension(thePlayer) == 5004 or getElementDimension(thePlayer) == 5002 or getElementDimension(thePlayer) == 5001 or getElementDimension(thePlayer) == 5003 or getElementDimension(thePlayer) == 5005 then
				exports.NGCdxmsg:createNewDxMessage("You can't become staff in minigame rooms!", thePlayer, 225, 0, 0 )
	           return false									
	         end
            setPlayerTeam ( thePlayer, getTeamFromName( "Staff" ) )
			local rank = getPlayerAdminLevel(thePlayer)
			if not rank then rank = "Staff" else rank = staffRanks[rank] end

			wp[thePlayer] = false
            setElementData( thePlayer, "Occupation", rank, true)

            -- setElementData( thePlayer, "Rank", staffRanks[getPlayerAdminLevel ( thePlayer )], true)

            if ( adminTable[thePlayer].gender == 0 ) then skin = 217 else skin = 211 end
            setElementModel( thePlayer, skin )
            exports.server:updatePlayerJobSkin( thePlayer, skin )

            setElementHealth( thePlayer, 100 )

            exports.DENvehicles:reloadFreeVehicleMarkers( thePlayer, true )
            triggerEvent("onPlayerJobChange", thePlayer, staffRanks[getPlayerAdminLevel ( thePlayer )], false, getPlayerTeam( thePlayer ) )
			if exports.server:getPlayerWantedPoints( thePlayer ) >= 10  then
				exports.CSGlogging:createAdminLogRow ( thePlayer, getPlayerName( thePlayer ).." entered staff job with " .. getPlayerWantedLevel( thePlayer ) .. " stars" )
			end
            setElementData( thePlayer, "wantedPoints", 0, true )
            setPlayerWantedLevel( thePlayer, 0 )
			setPlayerNametagColor(thePlayer,255,255,255)
            exports.NGCdxmsg:createNewDxMessage( thePlayer, "You are now on-duty as staff!", 0, 225, 0 )
            --exports.AURnewDiscord:sendMessageToDiscord(webhook, getPlayerName(thePlayer).." is on duty now.")
        end
    end
)

function onMessageToSupporters ( theMessage )
	for k, thePlayer in ipairs ( getElementsByType( "player" ) ) do
		if ( exports.CSGstaff:isPlayerStaff( thePlayer ) ) then
			outputChatBox( theMessage, thePlayer, 0, 225, 0 )
		end
	end
end

-- helpme command
--[[addCommandHandler( "helpme",
	function ( thePlayer )
		if ( exports.server:getPlayerAccountName( thePlayer ) ) then
			if ( helpSpamTable[ getPlayerSerial( thePlayer ) ] ) and ( getTickCount()-helpSpamTable[ getPlayerSerial( thePlayer ) ] < 1200000 ) and (getElementData(thePlayer, "playTime") / 60 < 15) then
				outputChatBox( "Please refuse from spamming this command! (Once every 20 minutes)", thePlayer, 225, 0, 0 )
			elseif ( getElementData( thePlayer, "playTime" ) ) then
				onMessageToSupporters ( getPlayerName( thePlayer ).." requested help! Warp to him, quickly!" )
				helpSpamTable[ getPlayerSerial( thePlayer ) ] = getTickCount()
				helpTable[ thePlayer ] = true
                --exports.AURnewDiscord:sendMessageToDiscord(webhook, getPlayerName(thePlayer).." requested help. (/helpme)")
				outputChatBox( "Your help request has been sent!", thePlayer, 0, 225, 0 )
			else
				outputChatBox( "You can only request Help Desk when you're playtime is lower than 15 hours!", thePlayer, 225, 0, 0 )
			end
		end
	end
)]]

-- Set the rank of a staff when he login
addEvent("onServerPlayerLogin" )
addEventHandler( "onServerPlayerLogin", root,
    function ( userID )
        local theTable = exports.DENmysql:querySingle( "SELECT * FROM staff WHERE userid=? LIMIT 1", userID )
        if ( theTable ) and ( theTable.active == 1 ) then
            if (string.match(getPlayerName(source), "%d+")) then
                outputChatBox("Numbers are not allowed in your nickname", source, 255, 0, 0)
                setPlayerName(source, getPlayerName(source):gsub("[0-9]", ""))
            end
            adminTable[source] = theTable
            triggerClientEvent( "onSyncAdminTable", root, adminTable[source], source )
            exports.NGCnote:addNote("Login", "Welcome admin, press 'P' to use your panel!", source, 255, 128, 0,5000 )
        else
            if type(string.find(string.lower(getPlayerName(source)),"[aur]",1,true)) == "number" or type(string.find(string.lower(getPlayerName(source)),"[ngc]",1,true)) == "number" or type(string.find(string.lower(getPlayerName(source)),"[csg]",1,true)) == "number" then
                outputChatBox(getPlayerName(source).." has been kicked", root, 255, 0, 0)
                kickPlayer(source, "AutoPunish", "You cannot use [AUR]/[CSG]/[NGC] tag. Please change your name.")
                cancelEvent()
            end
        end
    end
)

-- on Resource start
addEventHandler("onResourceStart", resourceRoot,
    function ()
        local theTable = exports.DENmysql:query( "SELECT * FROM staff" )
        completeAdminTable = theTable
        for k, thePlayer in ipairs( getElementsByType( "player" ) ) do
            local accountID = exports.server:getPlayerAccountID( thePlayer )
            if ( accountID ) then
                for i=1,#theTable do
                    if ( theTable[i].userid == accountID ) and ( theTable[i].active == 1 ) then
                        adminTable[thePlayer] = theTable[i]
                    end
                end
            end
        end
    end
)

-- Ask for a admin table sync
addEvent( "onRequestSyncAdminTable", true )
addEventHandler( "onRequestSyncAdminTable", root,
    function ()
        triggerClientEvent( source, "onSyncAdminTable", source, adminTable )
    end
)

-- Function to promote a admin
function promoteAdmin ( adminNick )
    for i=1,#completeAdminTable do
        if ( completeAdminTable[i].nickname == adminNick ) and ( completeAdminTable[i].rank ~= 6 )  then
            completeAdminTable[i].rank = completeAdminTable[i].rank +1
            local thePlayer = getPlayerFromID ( completeAdminTable[i].userid )
            if ( thePlayer ) and ( isElement( thePlayer ) ) then adminTable[thePlayer].rank = completeAdminTable[i].rank end
            exports.DENmysql:query( "UPDATE staff SET rank=? WHERE userid=?", completeAdminTable[i].rank, completeAdminTable[i].userid )
            break;
        end
    end
    triggerClientEvent( "onSyncAdminTable", root, adminTable[thePlayer], thePlayer )
    completeAdminTable = exports.DENmysql:query( "SELECT * FROM staff" )
end

-- Function to demote a admin
function demoteAdmin ( adminNick )
    for i=1,#completeAdminTable do
        if ( completeAdminTable[i].nickname == adminNick ) and ( completeAdminTable[i].rank ~= 0 ) then
            completeAdminTable[i].rank = completeAdminTable[i].rank -1
            local thePlayer = getPlayerFromID ( completeAdminTable[i].userid )
            if ( thePlayer ) and ( isElement( thePlayer ) ) then adminTable[thePlayer].rank = completeAdminTable[i].rank end
            exports.DENmysql:query( "UPDATE staff SET rank=? WHERE userid=?", completeAdminTable[i].rank, completeAdminTable[i].userid )
            break;
        end
    end
    triggerClientEvent( "onSyncAdminTable", root, adminTable[thePlayer], thePlayer )
    completeAdminTable = exports.DENmysql:query( "SELECT * FROM staff" )
end

-- Function to kick a admin
function kickAdmin ( adminNick )
    for i=1,#completeAdminTable do
        if ( completeAdminTable[i].nickname == adminNick ) then
            local thePlayer = getPlayerFromID ( completeAdminTable[i].userid )
            exports.DENmysql:query( "DELETE FROM staff WHERE userid=?", completeAdminTable[i].userid )
            if ( thePlayer ) and ( isElement( thePlayer ) ) then
                adminTable[thePlayer] = false
                setPlayerTeam( thePlayer, getTeamFromName( "Unemployed" ) )
                setElementData( thePlayer, "Occupation", "", true)
                setElementData( thePlayer, "Rank", "", true)
                exports.DENvehicles:reloadFreeVehicleMarkers( thePlayer, true )
            end
            break;
        end
    end
    triggerClientEvent( "onSyncAdminTable", root, adminTable[thePlayer], thePlayer )
    completeAdminTable = exports.DENmysql:query( "SELECT * FROM staff" )
end

-- Set admin developer
function setAdminDeveloper ( adminNick )
    for i=1,#completeAdminTable do
        if ( completeAdminTable[i].nickname == adminNick ) then
            if ( completeAdminTable[i].developer == 1 ) then completeAdminTable[i].developer = 0 else completeAdminTable[i].developer = 1 end
            local thePlayer = getPlayerFromID ( completeAdminTable[i].userid )
            if ( thePlayer ) and ( isElement( thePlayer ) ) then adminTable[thePlayer].developer = completeAdminTable[i].developer end
            exports.DENmysql:query( "UPDATE staff SET developer=? WHERE userid=?", completeAdminTable[i].developer, completeAdminTable[i].userid )
            break;
        end
    end
    triggerClientEvent( "onSyncAdminTable", root, adminTable[thePlayer], thePlayer )
    completeAdminTable = exports.DENmysql:query( "SELECT * FROM staff" )
end

-- Set admin eventmanager
function setAdminEventManager( adminNick )
    for i=1,#completeAdminTable do
        if ( completeAdminTable[i].nickname == adminNick ) then
            if ( completeAdminTable[i].eventmanager == 1 ) then completeAdminTable[i].eventmanager = 0 else completeAdminTable[i].eventmanager = 1 end
            local thePlayer = getPlayerFromID ( completeAdminTable[i].userid )
            if ( thePlayer ) and ( isElement( thePlayer ) ) then adminTable[thePlayer].eventmanager = completeAdminTable[i].eventmanager end
            --outputChatBox(tostring(thePlayer)) outputChatBox(tostring(adminTable[thePlayer].eventmanager))
            exports.DENmysql:query( "UPDATE staff SET eventmanager=? WHERE userid=?", completeAdminTable[i].eventmanager, completeAdminTable[i].userid )
            break;
        end
    end
    triggerClientEvent( "onSyncAdminTable", root, adminTable[thePlayer], thePlayer )
    completeAdminTable = exports.DENmysql:query( "SELECT * FROM staff" )
end

-- Set admin inactive
function setAdminActive( adminNick )
    for i=1,#completeAdminTable do
        if ( completeAdminTable[i].nickname == adminNick ) then
            if ( completeAdminTable[i].active == 1 ) then completeAdminTable[i].active = 0 else completeAdminTable[i].active = 1 end
            local thePlayer = getPlayerFromID ( completeAdminTable[i].userid )
            if ( thePlayer ) and ( isElement( thePlayer ) ) then adminTable[thePlayer] = false end
            exports.DENmysql:query( "UPDATE staff SET active=? WHERE userid=?", completeAdminTable[i].active, completeAdminTable[i].userid )
            break;
        end
    end
    triggerClientEvent( "onSyncAdminTable", root, adminTable[thePlayer], thePlayer )
    completeAdminTable = exports.DENmysql:query( "SELECT * FROM staff" )
end

-- Function to get all admins
function getAllAdmins ()
    return completeAdminTable
end

-- Get player from ID function
function getPlayerFromID ( userID )
    for k, thePlayer in ipairs ( getElementsByType ( "player" ) ) do
        if ( exports.server:getPlayerAccountID ( thePlayer ) == userID ) then
            return thePlayer
        end
    end
    return false
end

-- Remove again on quit
addEventHandler( "onPlayerQuit", root,
    function ()
        if ( adminTable[source] ) then
            adminTable[source] = {}
            triggerClientEvent( "onSyncAdminTable", root, adminTable )
        end
    end
)

-- Function to check if a player is staff
function isPlayerStaff ( thePlayer )
    if ( adminTable[thePlayer] ) then
        return true
    else
        return false
    end
end

-- Function to check if a player is a developer
function isPlayerDeveloper ( thePlayer )
    if ( adminTable[thePlayer] ) then
        if ( adminTable[thePlayer].developer == 1 ) then
            return true
        else
            return false
        end
    else
        return false
    end
end

-- Check is a player is a eventmanager
function isPlayerEventManager ( thePlayer )
    if ( adminTable[thePlayer] ) then
        if ( adminTable[thePlayer].eventmanager == 1 ) then
            return true
        else
            return false
        end
    else
        return false
    end
end

function isPlayerBaseMod ( thePlayer )
    if ( adminTable[thePlayer] ) then
        return adminTable[thePlayer].basemod == 1
    else
        return false
    end
end

-- Function that gets the staff level of a player
function getPlayerAdminLevel ( thePlayer )
    if ( adminTable[thePlayer] ) then
        if ( adminTable[thePlayer].rank ) then
            return adminTable[thePlayer].rank
        else
            return false
        end
    else
        return false
    end
end

-- Staff note
addCommandHandler( "note",
    function ( thePlayer, cmd, ... )
        if ( isPlayerStaff ( thePlayer ) ) then
            local theMessage = table.concat( {...}, " " )
            outputChatBox( "#FF0000(NOTE) " .. getPlayerName( thePlayer ) .. ": #FFFFFF" .. theMessage, root, 255, 255, 255, true )
            exports.NGCnote:addNote("Note", "#FF0000(NOTE) " .. getPlayerName( thePlayer ) .. ": #FFFFFF" .. theMessage, root, 255, 255, 255, 10000 )
            triggerEvent( "onServerNote", thePlayer, theMessage )
           -- exports.AURnewDiscord:sendMessageToDiscord(webhook, "**(NOTE)** "..getPlayerName(thePlayer)..": "..theMessage)
            exports.CSGlogging:createLogRow ( thePlayer, "notes", theMessage )
        end
    end
)

-- Staff event note

function eventNote( thePlayer, cmd, ... )
        if ( isPlayerStaff ( thePlayer ) ) then
            local theMessage = table.concat( {...}, " " )
           -- exports.AURnewDiscord:sendMessageToDiscord(webhook, "**(Event)** "..getPlayerName(thePlayer)..": "..theMessage)
            outputChatBox( "#1ca949(Event) " .. getPlayerName( thePlayer ) .. ": #FFFFFF" .. theMessage, root, 255, 255, 255, true )
            triggerEvent( "onEventNote", thePlayer, theMessage )
            exports.CSGlogging:createLogRow ( thePlayer, "notes", theMessage )
        end
    end
addCommandHandler("eventnote",eventNote)

-- Staff chat
function outputStaffChatMessage(nick, message, thePlayer)
    for k, aPlayer in pairs( getOnlineAdmins() ) do
		if (getElementData(aPlayer, "streamerModeStaff") == true) then 
			outputChatBox ( "(AUR) "..tostring( nick )..": #FFFFFF"..tostring( "<<< OFF DUTY >>>" ), aPlayer, 10,200,150,true )
			triggerClientEvent(aPlayer,"onChatSystemMessageToClient",aPlayer, thePlayer, message, "AUR" )
		else
			outputChatBox ( "(AUR) "..tostring( nick )..": #FFFFFF"..tostring( message ), aPlayer, 10,200,150,true )
			triggerClientEvent(aPlayer,"onChatSystemMessageToClient",aPlayer, thePlayer, message, "AUR", nick or "N/A")
		end
    end
    --exports.AURnewDiscord:sendMessageToDiscord(webhook, "**(AUR)** "..getPlayerName(thePlayer)..": "..message)
    --local staffEchoChan = exports.irc:ircGetChannelFromName("#staff")
    --if staffEchoChan and isElement(thePlayer) then -- channel found and message was sent from ingame
    if isElement(thePlayer) then -- channel found and message was sent from ingame
        --exports.irc:ircSay(staffEchoChan,"(AUR) 07"..tostring( nick )..": "..tostring( message ) )
		exports.discord_staff:send("chat.message.text", { author = tostring(nick), text = tostring(message) })
    end
end

addCommandHandler( "aur",
    function ( thePlayer, cmd, ... )
        if ( isPlayerStaff ( thePlayer ) ) then
            local theMessage = table.concat( {...}, " " )
            if #(string.gsub(theMessage," ","")) < 1 then
                exports.NGCdxmsg:createNewDxMessage(thePlayer, "Enter a message!", 255, 0, 0)
                return false
            else
                outputStaffChatMessage(getPlayerName(thePlayer), theMessage, thePlayer)
            end
        end
    end
)


addCommandHandler( "aurd",
    function ( thePlayer, cmd, ... )
        if ( isPlayerStaff ( thePlayer ) ) then
			if (getElementData(thePlayer, "streamerModeStaff") == true) then 
				setElementData(thePlayer, "streamerModeStaff", false)
			else 
				setElementData(thePlayer, "streamerModeStaff", true)
			end
        end
    end
)

addEvent("onIRCMessage", true)
addEventHandler("onIRCMessage",root,
    function (channel,message)
        local server = exports.irc:ircGetServers()[1]
        if exports.irc:ircGetUserNick(source) == exports.irc:ircGetServerNick(server) then -- speaker = echobot
            return false
        elseif string.sub(message,1,1) ~= "!" and exports.irc:ircGetChannelName(channel) == "#staff" then
            outputStaffChatMessage((exports.irc:ircGetUserNick(source) .. " (IRC)"), message)
        end
    end
)
-- Returns a table with all staff players

function getOnlineAdmins ()
    local theTable = {}
    for k, thePlayer in pairs( getElementsByType( "player" ) ) do
        if ( isPlayerStaff ( thePlayer ) ) then
            table.insert( theTable, thePlayer )
        end
    end
    return theTable
end

-- Make the car from a staff dmgproof
addCommandHandler( "dmgproof",
    function ( thePlayer )
        if ( isPlayerStaff ( thePlayer ) and getTeamName(getPlayerTeam(thePlayer)) == "Staff" ) and (getPlayerAdminLevel(thePlayer) >= 1) then
            local theVehicle = getPedOccupiedVehicle( thePlayer )
            if ( theVehicle ) then
                if ( isVehicleDamageProof( theVehicle ) ) then
                    exports.NGCdxmsg:createNewDxMessage( thePlayer, "Your vehicle is no longer damageproof!", 0, 225, 0 )
                    setVehicleDamageProof( theVehicle, false )
                else
                    exports.NGCdxmsg:createNewDxMessage( thePlayer, "Your vehicle is now damageproof!", 0, 225, 0 )
                    exports.CSGlogging:createAdminLogRow ( thePlayer, getPlayerName( thePlayer ).." made the vehicle from " .. getPlayerName( getVehicleController( theVehicle ) ) .." damageproof" )
                    setVehicleDamageProof( theVehicle, true )
                end
            end
        end
    end
)

-- Nickchange handler
addEventHandler("onPlayerChangeNick", root,
	function ( oldNick, newNick )
	if ( exports.CSGadmin:getPlayerMute ( source ) == "Global" ) then
		exports.NGCdxmsg:createNewDxMessage(source, "You are muted!", 236, 201, 0) cancelEvent() end
	local r,g,b = getPlayerNametagColor (source)
		for k, thePlayer in pairs( getOnlineAdmins () ) do
			exports.killmessages:outputMessage( oldNick.." is now known as "..newNick, thePlayer, r,g,b,"default-bold")
		end
	end
)

-- Skin command
addCommandHandler( "cskin",
    function ( thePlayer,cmd,id )
        if ( isPlayerStaff ( thePlayer ) ) and ( getTeamName( getPlayerTeam( thePlayer ) ) == "Staff" ) then
            if ( getPlayerAdminLevel( thePlayer ) >= 2 ) then
				if id then
                if tonumber(id) == 1 then
					setElementModel(thePlayer,250)
					exports.NGCdxmsg:createNewDxMessage("You are now SuperNix",thePlayer,255,255,255)
				elseif tonumber(id) == 2 then
					setElementModel(thePlayer,223)
					exports.NGCdxmsg:createNewDxMessage("You are now BatNix",thePlayer,255,255,255)
				end
				end
            end
        end
    end
)
-- Minigun command
addCommandHandler( "minigun",
    function ( thePlayer )
        if ( isPlayerStaff ( thePlayer ) ) and ( getTeamName( getPlayerTeam( thePlayer ) ) == "Staff" ) then
            if ( getPlayerAdminLevel( thePlayer ) >= 6 ) then
                giveWeapon( thePlayer, 38, 9000, true )
                exports.CSGlogging:createAdminLogRow ( thePlayer, getPlayerName( thePlayer ).." spawned a minigun" )
            end
        end
    end
)

-- Invis command
addCommandHandler( "invis",
    function ( thePlayer )
        if ( isPlayerStaff ( thePlayer ) ) and ( getTeamName( getPlayerTeam( thePlayer ) ) == "Staff" ) then
            if ( getElementAlpha( thePlayer ) == 255 ) then
                exports.CSGlogging:createAdminLogRow ( thePlayer, getPlayerName( thePlayer ).." made himself invisible" )
                setElementAlpha( thePlayer, 0 )
                setPlayerNametagShowing ( thePlayer, false )
				local attached = getAttachedElements ( thePlayer ) 
					if ( attached ) then 
						for k,element in ipairs(attached) do 
						print("enabling this blip")
						local r, g, b = getBlipColor(element)
						setBlipColor(element, r, g, b, 255)
					end
				end
            else
                setElementAlpha( thePlayer, 255 )
                setPlayerNametagShowing ( thePlayer, true )
				local attached = getAttachedElements ( thePlayer ) 
					if ( attached ) then 
						for k,element in ipairs(attached) do 
						print("enabling this blip")
						local r, g, b = getBlipColor(element)
						setBlipColor(element, r, g, b, 255)
					end
				end
            end
        end
    end
)

-- Glue stuff
addEvent( "gluePlayer",true )
addEventHandler( "gluePlayer", root,
    function ( slot, vehicle, x, y, z, rotX, rotY, rotZ )
        attachElements( source, vehicle, x, y, z, rotX, rotY, rotZ )
        setPedWeaponSlot( source, slot )
    end
)

addEvent( "ungluePlayer", true )
addEventHandler( "ungluePlayer", root,
    function ()
        detachElements( source )
    end
)

-- self explanatory
function CSGJockeAHelp(ps)
        if getPlayerTeam(ps) == getTeamFromName("Staff") then
            outputChatBox(getPlayerName(ps) .. " is now available to help you!", root, 0, 255, 0)
            exports.NGCnote:addNote("Staff help",getPlayerName(ps) .. " is now available to help you!", root, 0, 255, 0,3000)

            setElementData(ps, "PlayerIsBusy", false)
        end
end
addCommandHandler("staffhelp", CSGJockeAHelp)

---- Owner house
createObject ( 6300, -2940.8999, 490.39999, -6.3, 0, 0, 90 )
createObject ( 5408, -3020.3, 473.70001, 21.7, 0, 0, 180 )
createObject ( 8657, -2864.3, 431.10001, 4.2 )
createObject ( 8657, -2854.3999, 501.20001, 4.2, 0, 0, 342.75 )
createObject ( 8657, -2862.8301, 461.89001, 4.2, 0, 0, 354.5 )
createObject ( 8657, -2844.46, 530.5, 4.2, 0, 0, 339.746 )
createObject ( 8657, -2853.6001, 548.20001, 4.2, 0, 0, 79.741 )
createObject ( 6959, -2983.2, 433.60001, 0.1 )
createObject ( 6959, -2983.8999, 473.5, 0.1 )
createObject ( 6959, -3024.6001, 433.60001, 0.1 )
createObject ( 6959, -3065.8999, 433.70001, 0.1 )
createObject ( 6959, -3065.8999, 473.70001, 0.1 )
createObject ( 6959, -3065.8999, 513.70001, 0.1 )
createObject ( 6959, -3024.6001, 513.70001, 0.1 )
createObject ( 6959, -2999, 513.5, 0.1 )
createObject ( 11353, -3086, 506.60001, 4.5 )
createObject ( 11353, -3086, 452.29999, 4.5 )
createObject ( 11353, -3086, 441.5, 4.5 )
createObject ( 11353, -3059.3994, 413.90039, 4.5, 0, 0, 90 )
createObject ( 11353, -3005.0996, 413.90039, 4.5, 0, 0, 90 )
createObject ( 11353, -3005.3999, 533.59998, 4.5, 0, 0, 89.247 )
createObject ( 11353, -3059.5, 533.40002, 4.5, 0, 0, 91.242 )
createObject ( 2395, -2975, 510.39999, -1, 0, 0, 180 )
createObject ( 2395, -2971.3, 510.39999, -1, 0, 0, 179.995 )
createObject ( 2395, -2967.6001, 510.39999, -1, 0, 0, 179.995 )
createObject ( 2395, -2963.8999, 510.39999, -1, 0, 0, 179.995 )
createObject ( 2395, -2960.2, 510.39999, -1, 0, 0, 179.995 )
createObject ( 2395, -2956.5, 510.39999, -1, 0, 0, 179.995 )
createObject ( 2395, -2952.8, 510.39999, -1, 0, 0, 179.995 )
createObject ( 2395, -2949.2, 510.39999, -1, 0, 0, 179.995 )
createObject ( 2395, -2945.5, 510.39999, -1, 0, 0, 180 )
createObject ( 2395, -2941.8, 510.39999, -1, 0, 0, 179.995 )
createObject ( 2395, -2941.7998, 510.40039, -1, 0, 0, 179.995 )
createObject ( 2395, -2944.6001, 510.39999, -1, 0, 0, 90 )
createObject ( 2395, -2944.6001, 514.09998, -1, 0, 0, 90 )
createObject ( 2395, -2944.6001, 517.59998, -1, 0, 0, 90 )
createObject ( 2395, -2941.5, 520.90002, -1, 0, 0, 179.995 )
createObject ( 2395, -2937.8, 520.90002, -1, 0, 0, 179.995 )
createObject ( 2395, -2934.1001, 520.90002, -1, 0, 0, 179.995 )
createObject ( 2395, -2930.3999, 520.90002, -1, 0, 0, 179.995 )
createObject ( 2395, -2926.7, 520.90002, -1, 0, 0, 179.995 )
createObject ( 2395, -2923, 520.90002, -1, 0, 0, 179.995 )
createObject ( 2395, -2919.3, 520.90002, -1, 0, 0, 179.995 )
createObject ( 2395, -2915.6001, 520.90002, -1, 0, 0, 179.995 )
createObject ( 2395, -2911.8999, 520.90002, -1, 0, 0, 179.995 )
createObject ( 2395, -2908.2, 520.90002, -1, 0, 0, 179.995 )
createObject ( 2395, -2904.5, 520.90002, -1, 0, 0, 179.995 )
createObject ( 2395, -2902.7, 520.90002, -1, 0, 0, 179.995 )
createObject ( 2395, -2902.2, 517.59998, -1, 0, 0, 90 )
createObject ( 2395, -2902.2, 513.90002, -1, 0, 0, 90 )
createObject ( 2395, -2902.2, 510.20001, -1, 0, 0, 90 )
createObject ( 3985, -2895.1001, 464.60001, 2.7, 0, 0, 90 )
createObject ( 710, -2867.7, 420.89999, 19.5 )
createObject ( 710, -2895.6001, 420.10001, 19.5 )
createObject ( 710, -2924.5, 420, 19.5 )
createObject ( 710, -2926.7, 454, 19.5 )
createObject ( 710, -2926.8999, 486.70001, 19.5 )
createObject ( 710, -2926.8, 507.10001, 19.5 )
createObject ( 710, -2892.8, 507.39999, 19.5, 0, 0, 346 )
createObject ( 710, -2858, 505.79999, 19.5, 0, 0, 345.998 )
createObject ( 710, -2868.1001, 448.10001, 19.5, 0, 0, 345.998 )
createObject ( 710, -2864.7, 475, 19.5, 0, 0, 345.998 )
createObject ( 2774, -2868.1001, 439.20001, -0.7 )
createObject ( 2774, -2861.2, 489.79999, -0.7 )
createObject ( 6965, -2886.7, 464.89999, 7.4 )
createObject ( 717, -2912.1001, 436.89999, 3.8 )
createObject ( 717, -2907.8, 436.89999, 3.8 )
createObject ( 717, -2904, 436.89999, 3.8 )
createObject ( 717, -2899.3, 437, 3.8 )
createObject ( 717, -2898, 492.29999, 3.8 )
createObject ( 717, -2902.5, 492.29999, 3.8 )
createObject ( 717, -2905.8999, 492.29999, 3.8 )
createObject ( 717, -2910.3999, 492.29999, 3.8 )
createObject ( 5812, -3071, 472.70001, 0.5 )
createObject ( 873, -2891.8999, 461.29999, 5.7 )
createObject ( 873, -2885, 458.70001, 5.7, 0, 0, 50 )
createObject ( 873, -2881.3, 463.29999, 5.7, 0, 0, 121.999 )
createObject ( 873, -2886.5, 470.29999, 5.7, 0, 0, 205.998 )
createObject ( 9833, -2905.6001, 485.29999, 7.6 )
createObject ( 9833, -2904.7, 442.39999, 7.6 )
createObject ( 1232, -2881.5, 506.89999, 6.5 )
createObject ( 1232, -2860, 493, 6.5 )
createObject ( 1232, -2865, 469.79999, 6.5 )
createObject ( 1232, -2866.3, 455.5, 6.5 )
createObject ( 1232, -2866.5, 428.79999, 6.5 )
createObject ( 1232, -2926.2, 437.79999, 6.5 )
createObject ( 1232, -2939.6001, 483.20001, 6.5 )
createObject ( 1232, -2926.6001, 496.89999, 6.5 )
createObject ( 1232, -2945.5, 509.79999, 4.1 )
createObject ( 1232, -2959.2, 509.70001, 4.1 )
createObject ( 1232, -2974.2, 509.20001, 4.1 )
createObject ( 1232, -2943.6001, 519.70001, 4.1 )
createObject ( 1232, -2935.1001, 519.90002, 4.1 )
createObject ( 1232, -2926.1001, 519.90002, 4.1 )
createObject ( 1232, -2916, 519.90002, 4.1 )
createObject ( 1232, -2904.6001, 520.20001, 4.1 )
createObject ( 1232, -3059.8, 527.70001, 4.1 )
createObject ( 1232, -3068.8, 528.09998, 4.1 )
createObject ( 1232, -3080.6001, 527.90002, 4.1 )
createObject ( 1232, -3080.8999, 515.40002, 4.1 )
createObject ( 1232, -3081.3, 500.39999, 4.1 )
createObject ( 1232, -3081.2, 483.89999, 4.1 )
createObject ( 1232, -3080.8, 462.39999, 4.1 )
createObject ( 1232, -3081.6001, 443.89999, 4.1 )
createObject ( 1232, -3080.8999, 429.60001, 4.1 )
createObject ( 1232, -3075.1001, 424.39999, 4.1 )
createObject ( 1232, -3059.2, 424.10001, 4.1 )
