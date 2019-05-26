-- Spam table
local spamTable = {}
local helpSpamTable = {}
local helpTable = {}
local warpPosition = {}
local supporters = {}

local accounts = {
	--["ortega"] = true,
}

function loadSupporters()
	if (plr and isElement(plr) and getElementType(plr) == "player") then
		if (exports.server:isPlayerLoggedIn(plr)) then
			local nam = exports.server:getPlayerAccountName(plr)
			if accounts[nam] ~= nil then
			setElementData(plr,"isPlayerSupporter", true) else return false
		  end
	   end
   end
end


-- Open the supporters GUI
addCommandHandler( "supporters",function(thePlayer)
	if getElementData(thePlayer,"isPlayerSupporter") then
		triggerClientEvent(thePlayer,"openSupportersWindow",thePlayer)
	end
end)

-- Available for help
addCommandHandler( "supporter",
	function ( thePlayer )
		if ( getElementData(thePlayer,"isPlayerSupporter") == true ) then
			if ( spamTable[ thePlayer ] ) and ( getTickCount()-spamTable[ thePlayer ] < 120000 ) then
				outputChatBox( "Please refuse from spamming this command!", thePlayer, 225, 0, 0 )
			else
				spamTable [ thePlayer ] = getTickCount()
				outputChatBox( "Supporter "..getPlayerName( thePlayer ).." is now available to help you!", root, 255, 128, 0 )
			end
		end
	end
)

-- Mute the player
addEvent( "onSupportMutePlayer", true )
addEventHandler( "onSupportMutePlayer", root,
	function ( thePlayer, theReason, theTime )
		if not ( exports.CSGadmin:getPlayerMute( source ) ) then
			exports.CSGadmin:adminMutePlayer ( source, thePlayer, theReason, theTime, "Support" )
		else
			outputChatBox( "This player is already muted!", source, 225, 0, 0 )
		end
	end
)

-- On player login
addEventHandler( "onServerPlayerLogin", root,
	function ()
		local theT = exports.DENmysql:query("SELECT * FROM supporters")
		for key, data in ipairs(theT) do
			--if (exports.DENmysql:querySingle("SELECT * FROM supporters WHERE userid=? LIMIT 1", exports.server:getPlayerAccountID(source))) then
			if (math.floor(data.userid) == math.floor(exports.server:getPlayerAccountID(source))) then 
				setElementData( source, "isPlayerSupporter", true )
				outputChatBox( "Welcome supporter, have a nice day! :)", source, 255, 128, 0 )
			return
			end 
		end
		--if supporters[exports.server:getPlayerAccountID(source)] then
			
		--end
		if ( getElementData( source, "playTime" ) ) and ( getElementData( source, "playTime" ) < 20 ) then
			outputChatBox( "Welcome new player! Use /helpme if you recuire a supporter!", source, 255, 128, 0 )
		end
	end
)

-- isPlayerSupporter
function isPlayerSupporter ( thePlayer )
	if not ( isElement( thePlayer ) ) then
		return false
	else
		return getElementData( thePlayer, "isPlayerSupporter" )
	end
end

function getPlayerFromPartialName(name)
    local name = name and name:gsub("#%x%x%x%x%x%x", ""):lower() or nil
    if name then
        for _, player in ipairs(getElementsByType("player")) do
            local name_ = getPlayerName(player):gsub("#%x%x%x%x%x%x", ""):lower()
            if name_:find(name, 1, true) then
                return player
            end
        end
    end
end

function getPlayerFromPartialName(name)
    local name = name and name:gsub("#%x%x%x%x%x%x", ""):lower() or nil
    if name then
        for _, player in ipairs(getElementsByType("player")) do
            local name_ = getPlayerName(player):gsub("#%x%x%x%x%x%x", ""):lower()
            if name_:find(name, 1, true) then
                return player
            end
        end
    end
end

-- To get player account ID
function getplrid (plr, command, playern)
	if (exports.CSGstaff:isPlayerStaff( plr ) ) then 
		if (exports.CSGstaff:getPlayerAdminLevel(plr) >= 5) then 
			exports.NGCdxmsg:createNewDxMessage("Player account ID is: "..exports.server:getPlayerAccountID(getPlayerFromPartialName(playern)), plr, 255, 255, 255)
		end 
	end
end
addCommandHandler("getplayerid", getplrid)

-- Supporters list
function listSupports (plr, command)
	if (exports.CSGstaff:isPlayerStaff( plr ) ) then 
		if (exports.CSGstaff:getPlayerAdminLevel(plr) >= 5) then 
			local theT = exports.DENmysql:query("SELECT * FROM supporters")
			outputChatBox ("Supporters list: ", plr, 255, 128, 0)
			for key, data in ipairs(theT) do
				outputChatBox ("ID: "..math.floor(data.userid).." | Name: "..data.name, plr, 255, 128, 0)
			end
		end 
	end
end
addCommandHandler("supporterslist", listSupports)

-- To add someone as supporter
function addSup (plr, command, id, name)
	if (exports.CSGstaff:isPlayerStaff( plr ) ) then 
		if (exports.CSGstaff:getPlayerAdminLevel(plr) >= 5) then 
			exports.DENmysql:exec("INSERT INTO supporters (userid, name) VALUES (?, ?)", id, name)
			exports.NGCdxmsg:createNewDxMessage ("Added id "..id, plr, 0, 255, 0)
		end 
	end
end
addCommandHandler("addsup", addSup)

-- To delete someone from supporters list
function delsup (plr, command, id)
	if (exports.CSGstaff:isPlayerStaff( plr ) ) then 
		if (exports.CSGstaff:getPlayerAdminLevel(plr) >= 5) then 
			exports.DENmysql:exec("DELETE FROM supporters WHERE userid=?", id)
			exports.NGCdxmsg:createNewDxMessage ("Deleted id "..id, plr, 255, 0, 0)
		end 
	end
end
addCommandHandler("delsup", delsup)

-- supporter message
function onMessageToSupporters (plr, command, ...)
	if (isPlayerSupporter ( plr ) or exports.CSGstaff:isPlayerStaff( plr ) ) then 
		local theMessage = table.concat({...}, " ")
		if (theMessage:match("^%s*$")) then
			exports.NGCdxmsg:createNewDxMessage(plr,"Syntax: /sup <message>.",255,0,0)
			return
		end
		for k, thePlayer in ipairs ( getElementsByType( "player" ) ) do
			if ( isPlayerSupporter ( thePlayer ) ) or ( exports.CSGstaff:isPlayerStaff( thePlayer ) ) then
				outputChatBox("(Supporter) "..getPlayerName(plr)..": #ffffff"..theMessage, thePlayer, 255, 128, 0, true)
			end
		end
	end
end
addCommandHandler("sup", onMessageToSupporters)

-- helpme command
addCommandHandler( "helpme",
	function ( thePlayer )
		if ( exports.server:getPlayerAccountName( thePlayer ) ) then
			if ( helpSpamTable[ getPlayerSerial( thePlayer ) ] ) and ( getTickCount()-helpSpamTable[ getPlayerSerial( thePlayer ) ] < 120000 ) then
				outputChatBox( "Please refuse from spamming this command! (Once every 2 minutes)", thePlayer, 225, 0, 0 )
			return false end
			if ( getElementData( thePlayer, "playTime" ) ) and ( getElementData( thePlayer, "playTime" ) < 900 ) then
				--onMessageToSupporters ( getPlayerName( thePlayer ).." requested a supporter! Use /helphim [thePlayer] to warp to him/her!" )
				for k, thePlayerz in ipairs ( getElementsByType( "player" ) ) do
					if ( isPlayerSupporter ( thePlayerz ) ) or ( exports.CSGstaff:isPlayerStaff( thePlayerz ) ) then
						outputChatBox("(Supporter Alert) "..getPlayerName( thePlayer ).." requested a supporter! Use /helphim [thePlayer] to warp to him/her!", thePlayerz, 0, 225, 0, true)
					end
				end
				helpSpamTable[ getPlayerSerial( thePlayer ) ] = getTickCount()
				helpTable[ thePlayer ] = true
				outputChatBox( "Your help request has been sent!", thePlayer, 0, 225, 0 )
			else
				outputChatBox( "You can only request a supporter when you're playtime is lower than 15 hours!", thePlayer, 225, 0, 0 )
			end
		end
	end
)

-- warp to
addCommandHandler( "helphim",
	function ( thePlayer, cmd, aPlayer )
		if ( isPlayerSupporter ( thePlayer ) ) then
			if ( aPlayer ) and not ( aPlayer == "" ) or ( aPlayer == " " ) and ( exports.server:getPlayerFromNamePart( aPlayer ) ) then
				local aPlayerElement = exports.server:getPlayerFromNamePart( aPlayer )
				if ( aPlayerElement ) and ( helpTable[ aPlayerElement ] ) then
					if (getElementData(player,"isPlayerJailed") == true) then
						exports.NGCdxmsg:createNewDxMessage("You cannot warp to players while you're in jail!",255,0,0)
						return false
					end
					if (exports.CSGadmin:isPlayerJailed(aPlayer)) then
						exports.NGCdxmsg:createNewDxMessage("You cannot warp to players while they're in jail!",255,0,0)
						return false									
					end
					if exports.server:getPlayerWantedPoints(thePlayer) >= 20 then
                       exports.NGCdxmsg:createNewDxMessage("Your wanted points are more than or equal 20, you cannot warp!", thePlayer, 225, 0, 0 )
					   return false
				    end
					if getElementDimension(thePlayer) == 5004 or getElementDimension(thePlayer) == 5002 or getElementDimension(thePlayer) == 5001 or getElementDimension(thePlayer) == 5003 or getElementDimension(thePlayer) == 5005 then
					   exports.NGCdxmsg:createNewDxMessage("You cannot warp whilst you are in minigame rooms!", thePlayer, 225, 0, 0 )
					   return false
				    end
					
					local x1, y1, z1 = getElementPosition( thePlayer )
					warpPosition[ thePlayer ] = x1..",".. y1 ..","..z1
					local x, y, z = getElementPosition( aPlayerElement )
					local int, dim = getElementInterior( aPlayerElement ), getElementDimension( aPlayerElement )
					if ( isPedInVehicle( thePlayer ) ) then removePedFromVehicle( thePlayer, getPedOccupiedVehicle( thePlayer ) ) end
					
					setElementPosition( thePlayer, x, y, z )
					setElementDimension ( thePlayer, dim )
					setElementInterior( thePlayer, int )
					if ( isPedInVehicle( aPlayerElement ) ) then 
						local veh = getPedOccupiedVehicle( aPlayerElement )
						local tSeat = false
						for seat=0, 3 do
							if not getVehicleOccupant(veh,seat) then
								tSeat = seat
								break
							end
						end
						if tSeat then
							warpPedIntoVehicle( thePlayer, tSeat ) 
						else	
							outputChatBox( "This player was in a filled vehicle, you have been warped near it.", thePlayer, 255, 225, 0 )
						end
					end
					
					helpTable[ aPlayerElement ] = false
					outputChatBox( "You can use /warpback to get back to your old position!", thePlayer, 0, 225, 0 )
				else
					outputChatBox( "This player didn't ask for help, got already help or is not a valid player!", thePlayer, 225, 0, 0 )
				end
			else
				outputChatBox( "You didn't enter a valid playername!", thePlayer, 225, 0, 0 )
			end
		end
	end
)

-- warp back
addCommandHandler( "warpback",
	function ( thePlayer )
		if ( isPlayerSupporter ( thePlayer ) ) then
			if exports.server:getPlayerWantedPoints(thePlayer) >= 20 then
               exports.NGCdxmsg:createNewDxMessage("Your wanted points are more than or equal 20, you cannot warpback!", thePlayer, 225, 0, 0 )
				return false
			end
			   if ( warpPosition[ thePlayer ] ) then
				  local tbl = split( warpPosition[ thePlayer ], "," )
				  setElementPosition( thePlayer, tbl[1], tbl[2], tbl[3] )
				  warpPosition[ thePlayer ] = false
			  end
		  end
	  end
)
