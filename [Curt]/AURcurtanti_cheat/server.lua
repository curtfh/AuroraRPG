local commandSpam = {}
 function preventCommandSpam( command )
	command = string.lower(command)
	if (command == "takehit") then return false end
	if (command == "takeht") then return false end
	if (command == "tajehit") then return false end
	if (command == "takhit") then return false end
	if (command == "toggle") then return false end
	if (command == "previous") then return false end
	if (command == "next") then return false end
	if (command == "reload") then return false end
	if (command == "ritalin") then return false end
	if (command == "takehe") then return false end
	if (command == "heroine") then return false end
	if (command == "lsd") then return false end
	if (command == "cocaine") then return false end
	if (command == "ecstasy") then return false end
	if (command == "weed") then return false end
	if (command == "shotgun") then return false end
	if (command == "handgun") then return false end
	if (command == "heal") then return false end
	if (command == "strobo") then return false end
	if (command == "say") then return false end
	if (command == "localchat") then return false end
	if (command == "mainchat") then return false end
	if (command == "m4") then return false end
	if (command == "sniper") then return false end
	if (command == "cleardx") then return false end
	if (command == "cleardz") then return false end
	if (command == "r") then return false end
	if (command == "reply") then return false end
	if (command == "medkit") then return false end
	if (command == "takeheroine") then return false end
	if (command == "handguy") then return false end
	if (command == "spaz") then return false end
	if (command == "spazguy") then return false end
	if (command == "shotguy") then return false end
	if (command == "clearx") then return false end
	if (command == "clearx") then return false end
	if (command == "steroid") then return false end
	if (command == "gab") then return false end
	if (command == "grab") then return false end
	if (command == "takethit") then return false end
	if (command == "drugs") then return false end
	if (command == "topcriminal") then return false end
	if (command == "plant") then return false end
	if (command == "spas") then return false end
	if (command == "rit") then return false end
	if (command == "deagle") then return false end
	if (command == "spas-7") then return false end
	if (command == "eventwarp") then return false end
	if (command == "cleardex") then return false end
	if (command == "combat") then return false end
	if (command == "setchel") then return false end
	if (command == "nade") then return false end
	if (command == "rifle") then return false end
	if (command == "sniper") then return false end
	if (command == "takehit") then return false end
	if (command == "takedrug") then return false end
	if (command == "banktime") then return false end
	if (command == "players") then return false end
	if (command == "muteaudio") then return false end
	if (command == "siper") then return false end
	if (command == "nades") then return false end
	if (command == "topcrimnal") then return false end
    if (not commandSpam[source]) then
        commandSpam[source] = 1
    elseif (commandSpam[source] == 5) then
		exports.NGCdxmsg:createNewDxMessage(source,"Stop spamming the commands",255,0,0)
    elseif (commandSpam[source] == 10) then
        kickPlayer(source, "Stop spamming the commands.")
		outputAllDetectionSpam(getPlayerName(source), "Kicked, Spam")
    else
        commandSpam[source] = commandSpam[source] + 1
		outputAllDetectionSpam(getPlayerName(source), commandSpam[source].." | "..command)
    end
end
addEventHandler("onPlayerCommand", root, preventCommandSpam)
setTimer(function() commandSpam = {} end, 1000, 0)

function setDebugDection (plr)
	if (exports.CSGstaff:isPlayerStaff( plr ) ) then
		if (exports.CSGstaff:getPlayerAdminLevel(plr) >= 4) then
			if (getElementData(plr, "AURantispam_cmd.output" ) == true) then
				setElementData(plr,  "AURantispam_cmd.output", false)
				outputChatBox("Disabled", plr, 255,255,255)
			else
				setElementData(plr,  "AURantispam_cmd.output", true)
				outputChatBox("Enabled", plr, 255,255,255)
			end
		end
	end
end
addCommandHandler("cmdsd", setDebugDection)

 function outputAllDetectionSpam (playername, howmany)
	local playertable = getElementsByType("player")
	for i,v in ipairs(playertable) do
		local ggg = getElementData( v, "AURantispam_cmd.output" )
		if (ggg == true) then
			if (exports.CSGstaff:isPlayerStaff( v ) ) then
				if (exports.CSGstaff:getPlayerAdminLevel(v) >= 4) then
					outputChatBox("Action: "..playername.." | "..howmany, v, 255, 255, 255)
				end
			end
		end
	end
 end

 function outputDetectPacketLoss (playername, packetloss)
	outputAllDetectionSpam("Packet Loss Detected: "..playername, "PLOSS: "..packetloss.."%")
end
addEvent( "AURcurt_anticheat.outputDetect", true )
addEventHandler( "AURcurt_anticheat.outputDetect", resourceRoot, outputDetectPacketLoss )

function anticheat_vehdmg (thePlayer, seat, jacked)
	if ((getElementData(source,"vehicleFuel") == 0) or (getElementHealth(source) < 300)) then
		if (seat == 0) then return end
		exports.NGCdxmsg:createNewDxMessage(thePlayer, "You cannot enter the vehicle due to its already damanged or out of fuel.", 255, 0, 0)
		cancelEvent()
	end

end
addEventHandler ("onVehicleStartEnter", getRootElement(), anticheat_vehdmg)

--Do not do commands, when player isnt  logged in
function onPlrCommand ()
	if (not exports.server:isPlayerLoggedIn(source)) then 
		cancelEvent()
	end 
end 
addEventHandler("onPlayerCommand", root, onPlrCommand)

--New Anti Cheat Thing
function isPlayerAllowed ()
end 