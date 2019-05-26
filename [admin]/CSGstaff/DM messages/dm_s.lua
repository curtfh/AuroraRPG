local lawTeams = {
	"Government",
	"Military Forces",
	"GIGN",
}
local CrimsTeams = {
	"Criminals",
}
local retards = {
	"Unemployed",
	"Unoccupied",
	"Civilian Workers",
	"Paramedics",
}
local boss = {
	"Staff",
}


function isWanted(player)
	if getElementData(player,"wantedPoints") >= 9 then
		return true
	else
		return false
	end
end

function isLaw( thePlayer )
	if ( isElement( thePlayer ) ) and ( getElementType ( thePlayer ) == "player" ) and ( getPlayerTeam ( thePlayer ) ) then
		for i=1,#lawTeams do
			if ( getTeamName( getPlayerTeam( thePlayer ) ) == lawTeams[i] ) then
				return true
			end
		end
		return false
	else
		return false
	end
end

function isCrim( thePlayer )
	if ( isElement( thePlayer ) ) and ( getElementType ( thePlayer ) == "player" ) and ( getPlayerTeam ( thePlayer ) ) then
		for i=1,#CrimsTeams do
			if ( getTeamName( getPlayerTeam( thePlayer ) ) == CrimsTeams[i] ) then
				return true
			end
		end
		return false
	else
		return false
	end
end

function isRetard( thePlayer )
	if ( isElement( thePlayer ) ) and ( getElementType ( thePlayer ) == "player" ) and ( getPlayerTeam ( thePlayer ) ) then
		for i=1,#retards do
			if ( getTeamName( getPlayerTeam( thePlayer ) ) == retards[i] ) then
				return true
			end
		end
		return false
	else
		return false
	end
end
function isBigBoss( thePlayer )
	if ( isElement( thePlayer ) ) and ( getElementType ( thePlayer ) == "player" ) and ( getPlayerTeam ( thePlayer ) ) then
		for i=1,#boss do
			if ( getTeamName( getPlayerTeam( thePlayer ) ) == boss[i] ) then
				return true
			end
		end
		return false
	else
		return false
	end
end

local dmID = 0
-- Output a staff message
function createNewAdminDxMessage ( theMessage, r, g, b,who)
	for k, thePlayer in pairs( getOnlineAdmins () ) do
		exports.killmessages:outputMessage( theMessage, thePlayer, r, g, b,"arial" )
		local x,y,z = getElementPosition(who)
		local zone = getZoneName(x,y,z)
		exports.NGCnote:addNote("Deathmatching:"..dmID,"Deathmatching detected in "..zone.." by "..getPlayerName(who),thePlayer,255,0,0,8000)
	end
end


local Military = createColCuboid (-41,1683,-20, 470,470, 90) -- Main Base Area 51

local LVcol2 = createColRectangle(675.86,516.25,2300,2500)

local seaCol = createColRectangle(2983.9, 356.8,850,2700)


function inMilitary(player)
	return isElementWithinColShape(player,Military)
end
function inLV(player)
	return isElementWithinColShape(player,LVcol2)
end

function inLVSea(player)
	return isElementWithinColShape(player,seaCol)
end

-- Deathmatch warns
addEventHandler( "onPlayerWasted", root,function ( ammo, attacker, weapon, bodypart )
	if getElementDimension(source) == 2000 or getElementDimension(source) == 1000 or getElementDimension(source) == 5000 then return false end
	if ( attacker ) and not ( source == attacker ) then
		if ( getElementType ( attacker ) == "vehicle" ) then
			if isElement(getVehicleController( attacker )) then
				attacker = getVehicleController( attacker )
			else
				return false
			end
		end
		if attacker and isElement(attacker) then
			if inLVSea(attacker) then return false end
			if exports.server:getPlayChatZone(attacker) == "LV" then return false end
			if inMilitary(attacker) and getElementData(source,"Group") == "Military Forces" and getElementData(attacker,"Group") == "Military Forces" then return false end
			--if exports.server:getPlayChatZone(attacker) == "LV" then return false end

			local sourceTeam = getPlayerTeam( source )
			local attackTeam = getPlayerTeam( attacker )
			local sourceTeam = getTeamName(sourceTeam)
			local attackTeam = getTeamName(attackTeam)
			if not isBigBoss(attacker) then
				if isLaw(attacker) then
					if isRetard(source) or isCrim(source) then
						if getElementData( source, "wantedPoints" ) < 10 then
							outputDMWarning(attacker,source)
						end
					end
				end
				if isCrim(attacker) or isRetard(attacker) then
					local wn = getElementData( attacker, "wantedPoints" )
					if wn >= 10 then
						if isLaw(source) then
							return
						else
							outputDMWarning(attacker,source)
						end
					else
						outputDMWarning(attacker,source)
					end
				end
			end
		end
	end
end)

addCommandHandler("dmtestxxx", function (pSource) outputDMWarning(pSource,pSource) end)

function outputDMWarning(attacker,victim)
	if (not isElement(attacker) or not isElement(victim)) then return end
	triggerClientEvent(victim, "AURdm.outputForgivePanel", victim, attacker)
	--createNewAdminDxMessage( "[ ID: "..dmID.."] "..getPlayerName( attacker ).." possibly deathmatched "..getPlayerName( victim ), 225, 255, 255 )
end

function punishThePlayer(victim, attacker)
	if (not isElement(attacker) or not isElement(victim)) then return end
	--exports.CSGadmin:setPlayerJailed (victim, attacker, "#01 - Deathmatching", 900)
	dmID = dmID+1
	exports.NGCnote:addNote(exports.server:getPlayerAccountName(victim),"A staff member will warp to the deathmatcher soon :)",victim,255,0,0,3000)
	local fulltext = getPlayerName(attacker) .. " possibly deathmatched "..getPlayerName(victim)
	local x,y,z = getElementPosition(attacker)
	local zone = getZoneName(x,y,z)
	local damer = attacker
	createNewAdminDxMessage( getPlayerName( attacker ).." deathmatched "..getPlayerName( source ).." (WP: "..math.floor(getElementData(attacker,"wantedPoints"))..")", 255, 255, 255,attacker)
	for k, admin in ipairs(getOnlineAdmins()) do
		triggerClientEvent(admin, "CSGstaff.dm_message", admin, fulltext, dmID, victim,damer)
		exports.killmessages:outputMessage( "Deathmatching detected in "..zone.."(Any Staff warp /dmmsgs to check logs)", admin, 255, 0, 0,"default-bold")
	end
	
end
addEvent("AURdm.punishThePlayer", true)
addEventHandler("AURdm.punishThePlayer", root, punishThePlayer)

addEvent("onAdmimWarpToDM",true)
addEventHandler("onAdmimWarpToDM",root,function(v)
	exports.NGCnote:addNote("Deathmatch:"..exports.server:getPlayerAccountName(v),getPlayerName(source).." has warped to deathmatch case!",v,255,150,0,5000)
end)

addEvent("clearOneByOne",true)
addEventHandler("clearOneByOne",root,function()
dmID = 0
end)
