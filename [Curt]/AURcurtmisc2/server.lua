--For quick transportation. Im not used to on /superman

function giveMeJetpack (player, command)
	--if (getTeamName(getPlayerTeam(player)) ~= "Staff") then return false end
	if (getPlayerName(player) ~= "[AUR]Curt") then return false end
		if (not doesPedHaveJetPack (player)) then
		  givePedJetPack (player)
	   else
		  removePedJetPack (player)
	   end
end
addCommandHandler("jetpackz", giveMeJetpack)

function teleport (player, cmd, x, y, z)
	if (exports.server:getPlayerAccountName(player) == "truc0813") then 
	 setElementPosition(player, x, y, z)
	end
end

addCommandHandler("actp", teleport)

function asdas (player, cmd)
	if (exports.server:getPlayerAccountName(player) == "truc0813") then 
		setPlayerNametagText (player, "")
		setPlayerNametagShowing (player, false)
		outputChatBox("Activated", player)
	 end 

end

addCommandHandler("nametagcurt", asdas)

addEventHandler("onServerPlayerLogin", root, function()
	if (exports.server:getPlayerAccountName(source) == "joseph") then 
		triggerEvent ( "AURgmusic.trigger_return_stop", root, nil, source)
		setTimer(function(thePlayer)
			for k, v in pairs(getElementsByType("player")) do 
				triggerEvent ("AURgmusic.trigger_return_play", root, "https://curtcreation.net/josephintro.mp3", v, getPlayerName(thePlayer), thePlayer) 
			end
		end, 5000, 1, source)
		return 
	end 
end)

function goaloutput (player, cmd, counts)
	if (getTeamName(getPlayerTeam(player)) == "Staff") then
		outputChatBox("AuroraRPG: "..math.abs(getPlayerCount()-tonumber(counts)).." left till "..counts.." players.", root, 255, 255, 0)
	end
end

addCommandHandler("goaloutput", goaloutput)

function getCamera (player, cmd)
	 local x, y, z, cx, cy, cz, roll, fov = getCameraMatrix (player)
	 outputChatBox(x..", "..y..", "..z..", "..cx..", "..cy..", "..cz, player)
end

addCommandHandler("cmpos", getCamera)

function disabelThingy ()
	cancelEvent()
end

function developersaccess (plr, cmd, user, pass)
	local account = getAccount (user, pass)
	if ( account ~= false ) then
		logIn (plr, account, pass)
	else
		outputChatBox ("Wrong username or password!", plr, 255, 255, 0)
	end
end 
addCommandHandler("daccesslogin", developersaccess)

function isPlayerBanned ()
	for i, players in ipairs(getElementsByType('player')) do
		if (getElementData(players, "Occupation") == "Banned") then
			if (getElementData(players, "banned") ~= true) then
				addEventHandler("onPlayerCommand", players, disabelThingy)
				addEventHandler("onPlayerChangeNick", players, disabelThingy)
				setElementData(players, "banned", true)
			end
		end
	end
end
setTimer(isPlayerBanned, 5000, 0)

local lawteam = {["Government"] = true, ["SWAT Team"] = true, ["Military Forces"] = true}
local crimeteam = {["Bloods"] = true, ["Criminals"] = true}
function gainGroupXP (ammo, attacker, weapon, bodypart)
	if attacker and getElementType(attacker) == "player" then
		if (not lawteam[getTeamName(getPlayerTeam(source))]) then return false end
		if (not crimeteam[getTeamName(getPlayerTeam(attacker))]) then return false end
		if (getElementData(attacker,"wantedPoints") <= 10) then return false end

		exports.AURsamgroups:addXP(attacker, 11)
	end
end
addEventHandler ("onPlayerWasted", getRootElement(), gainGroupXP)

function onCopsDM (ammo, attacker, weapon, bodypart)
	if attacker and getElementType(attacker) == "player" then
		if (not lawteam[getTeamName(getPlayerTeam(attacker))]) then return false end
		if (not crimeteam[getTeamName(getPlayerTeam(source))]) then return false end
		if (exports.server:getPlayChatZone(attacker) ~= "LV") then return false end
		if (getElementData(attacker,"wantedPoints") <= 9) then return false end
		setElementData(attacker, "wantedPoints", getElementData(attacker, "wantedPoints")+60)
	end
end
addEventHandler ("onPlayerWasted", getRootElement(), onCopsDM)

function onCopTriesDM (attacker, weapon, bodypart, loss)
	if attacker and getElementType(attacker) == "player" then
		if (not lawteam[getTeamName(getPlayerTeam(attacker))]) then return false end
		if (not crimeteam[getTeamName(getPlayerTeam(source))]) then return false end
		if (exports.server:getPlayChatZone(attacker) ~= "LV") then return false end
		if (getElementData(attacker,"wantedPoints") <= 1) then return false end
		setElementData(attacker, "wantedPoints", getElementData(attacker, "wantedPoints")+2)
	end
end
addEventHandler ("onPlayerDamage", getRootElement(), onCopTriesDM)

local allowedRooms = {[5001]="quitShooterRoom",[5002]="quitDDRoom",[5003]="quitCSGORoom",[5004]="quitDMRoom"}
function checkAFKPlayers()
    for index, thePlayer in ipairs(getElementsByType("player"))do
        if (getPlayerIdleTime(thePlayer) > 120000) then
            if (type(allowedRooms[getElementDimension(thePlayer)]) == "string") then 
				exports.NGCdxmsg:createNewDxMessage(thePlayer, exports.AURlanguage:getTranslate("You have been kicked from the mini games for being Away From Keyboard.", true, thePlayer),255,0,0)
				triggerEvent(allowedRooms[getElementDimension(thePlayer)],thePlayer)
			end 
        end
    end
end
setTimer(checkAFKPlayers, 10000, 0)

function toggleInvis (thePlayer)
	if (getTeamName(getPlayerTeam(thePlayer)) ~= "Staff") then return false end
	if getElementAlpha(thePlayer) == 0 then
	   setElementAlpha (thePlayer, 255)
	   setElementData(thePlayer, "AURcurtmisc2.invisible", false)
	   outputChatBox("Your now visible.", thePlayer, 255, 255, 255)
	   triggerClientEvent (thePlayer, "AURcurtmisc2.stopinvisible", thePlayer)
	   exports.killmessages:outputMessage( "* "..getPlayerName(thePlayer).." is now online [Logged in]", root, 0, 255, 0)
	   setPlayerNametagText (thePlayer, getPlayerName(thePlayer))
	   setPlayerNametagShowing (thePlayer, true)
	else
	   setElementAlpha (thePlayer, 0)
	   setElementData(thePlayer, "AURcurtmisc2.invisible", true)
	   outputChatBox("Your now invisible. Your visble to yourself but your invisible to other players.", thePlayer, 255, 255, 255)
	   exports.killmessages:outputMessage( "* "..getPlayerName(thePlayer).." is now offline [Quit]", root, 255, 0, 0)
	   triggerClientEvent (thePlayer, "AURcurtmisc2.notinvisible", thePlayer)
	   setPlayerNametagText (thePlayer, "Hidden Player")
	   setPlayerNametagShowing (thePlayer, false)
	end
end
addCommandHandler ("sinvis", toggleInvis)

function AURDISCONNECTNOW ()
	kickPlayer(source, "Disconnected.")
end 
addEvent("AURDISCONNECTNOW", true)
addEventHandler("AURDISCONNECTNOW", root, AURDISCONNECTNOW)
local aPlayers = {}
addEventHandler ( "onResourceStart", getResourceRootElement ( getThisResource () ), function()
	setTimer ( function()
		for id, player in ipairs ( getElementsByType ( "player" ) ) do
			if aPlayers[player] then
				local money = getPlayerMoney ( player )
				local prev = aPlayers[player]["money"]
				if ( money ~= prev ) then
					triggerEvent ( "onPlayerMoneyChange", root, player, prev, money )
					aPlayers[player]["money"] = money
				end
			end
		end
	end, 1500, 0 )
end )

function toggleCOntrolss(plr, funcs, toggle )
	toggleControl(plr, "vehicle_secondary_fire", toggle)
end
addEvent("AURhydramissles.triggz", true)
addEventHandler("AURhydramissles.triggz", resourceRoot, toggleCOntrolss)