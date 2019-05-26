local jailPoints = {
{1535.93, -1670.89, 13, "LS1"},
{638.95, -571.69, 15.81, "LS2"},
{-2166.05, -2390.38, 30.04, "LS3"},
{-1606.34, 724.44, 11.53, "SF1"},
{-1402.04, 2637.7, 55.25, "SF2"},
{2290.46, 2416.55, 10.3, "LV1"},
{-208.63, 978.9, 18.73, "LV2"}
}
--[[
GUIEditor = {
    button = {},
    label = {},
    window = {},
}
GUIEditor.window[1] = guiCreateWindow(464, 235, 420, 214, "CSG ~ Jail", false)
guiWindowSetSizable(GUIEditor.window[1], false)

GUIEditor.label[1] = guiCreateLabel(10, 29, 405, 33, "Your arrested person(s) are authorized to be taken to CSG's federal prison. You have 2 options as the jailer of these felons.", false, GUIEditor.window[1])
guiLabelSetHorizontalAlign(GUIEditor.label[1], "left", true)
GUIEditor.button[1] = guiCreateButton(9, 72, 164, 32, "1) Accept offer", false, GUIEditor.window[1])
GUIEditor.button[2] = guiCreateButton(9, 111, 164, 32, "2) Deny offer", false, GUIEditor.window[1])
GUIEditor.label[2] = guiCreateLabel(181, 73, 245, 29, "Transport these criminals to the federal prison for 35% bonus. 3 Minutes Max.", false, GUIEditor.window[1])
guiLabelSetHorizontalAlign(GUIEditor.label[2], "left", true)
GUIEditor.label[3] = guiCreateLabel(181, 108, 245, 45, "Let them be transported by the government instead. Get paid the regular salary.", false, GUIEditor.window[1])
guiLabelSetHorizontalAlign(GUIEditor.label[3], "left", true)
GUIEditor.label[4] = guiCreateLabel(8, 151, 418, 20, "-----------------------------------------------------------------------------------------------------------------", false, GUIEditor.window[1])
GUIEditor.label[5] = guiCreateLabel(9, 174, 415, 56, "> If you accept and do not transport them in 3 minutes, they will be transferred automatically and you will not be paid.", false, GUIEditor.window[1])
guiLabelSetHorizontalAlign(GUIEditor.label[5], "left", true)

pos to be transported to  884.56, -2566.88, 23.16

--]]
local oldwp = {}
local newwp = {}
local oldnick = {}
local newnick = {}
function updateWPTag()
	newwp = getElementData(localPlayer,"wantedPoints")
	newnick = getPlayerName(localPlayer)
	if newwp ~= oldwp or newnick ~= oldnick then
		triggerServerEvent("updatePlayerWantedPointTag",localPlayer)
		oldwp = newwp
		oldnick = newnick
		setTimer(updateWPTag,5000,1)
	else
		setTimer(updateWPTag,5000,1)
	end
end
setTimer(updateWPTag,5000,1)

local theColBlips = {}
local theMarker = {}
function onColJailMakrerHit ( thePlayer )
	if getElementData ( thePlayer, "isPlayerArrested" ) then
		local theJailPoint = getElementData ( source, "jailPoint" )
		local theOfficer = getElementData ( thePlayer, "arrestedBy" )
		triggerServerEvent ( "onJailArrestedPlayers", theOfficer, theJailPoint, localPlayer )
	end
end

for ID in pairs(jailPoints) do
	local x, y, z = jailPoints[ID][1], jailPoints[ID][2], jailPoints[ID][3]
	local jailPoint = jailPoints[ID][4]
	theColShape = createColSphere ( x, y, z, 6 )
	setElementData ( theColShape, "jailPoint", jailPoint )
	addEventHandler ( "onClientColShapeHit", theColShape, onColJailMakrerHit)
end

addEvent("onCreateJailPoints", true)
function onCreateJailPoints ()
	onRemoveJailPoints ()
	for i=1,7 do
		local x, y, z = jailPoints[i][1], jailPoints[i][2], jailPoints[i][3]
		theColBlips[i] = createBlip ( x, y, z, 30, 3, 0, 0, 255, 255, 50 )
		theMarker[i] = createMarker(x,y,z-1,"cylinder",4,0,100,255)
		setElementData(theMarker[i],"jailPoints",true)
	end
	addEventHandler("onClientRender", getRootElement(), showTextOnTop)
end
addEventHandler("onCreateJailPoints", root, onCreateJailPoints)

addEvent("onPlayerSetArrested", true)
function onPlayerSetArrested ()
	triggerEvent( "onPlayerArrest", localPlayer )
end
addEventHandler("onPlayerSetArrested", root, onPlayerSetArrested)

addEvent("onRemoveJailPoints", true)
function onRemoveJailPoints ()
	for i=1,7 do
		if ( theColBlips[i] ) then
			destroyElement(theColBlips[i])
		end
		if ( theMarker[i] ) then
			destroyElement(theMarker[i])
		end
	end
	theMarker = {}
	theColBlips = {}
	removeEventHandler("onClientRender", getRootElement(), showTextOnTop)
end
addEventHandler("onRemoveJailPoints", root, onRemoveJailPoints)


function showTextOnTop()
    local xx, yy, zz = getElementPosition(localPlayer)
	for k,v in ipairs(getElementsByType("marker",resourceRoot)) do
		if getElementData(v,"jailPoints") then
			if isLaw(localPlayer) then
				local mXX, mYY, mZZ = getElementPosition(v)
				local rr, gg, bb = 255,255,255
				local sxx, syy = getScreenFromWorldPosition(mXX, mYY, mZZ+1)
				if (sxx) and (syy) then
					local distancee = getDistanceBetweenPoints3D(xx, yy, zz, mXX, mYY, mZZ)
					if (distancee < 30) then
						dxDrawText("Jail point", sxx+6, syy+6, sxx, syy, tocolor(0, 0, 0, 255), 2-(distancee/30),  "sans", "center", "center")
						dxDrawText("Jail point", sxx+2, syy+2, sxx, syy, tocolor(250, 255, 255, 255), 2-(distancee/30), "sans", "center", "center")
					end
				end
			end
		end
	end
end


local officer = false
local theTimer = {}
local arrestedPerson=false
local lag = 0
local who = {}
local CrimPosition = nil
local copPosition = nil
-- When the player got arrested make him follow the cop
addEvent("onClientFollowTheCop", true)
function onClientFollowTheCop ( cop, pri )
	officer=cop
	arrestedPerson=source or pri
	CrimPosition = nil
	copPosition = nil
	theTimer = {}
	follow()
	lag = 0
	if isTimer(who) then killTimer(who) end
	who = setTimer(onPlayerLag,10000,0,officer,arrestedPerson)
end
addEventHandler("onClientFollowTheCop", root, onClientFollowTheCop)



function targetingActivated ( target )
	if source == localPlayer then
		if target and isElement(target) and getElementType ( target ) == "player" then
			if not isPedInVehicle(target) and not isPedInVehicle(source) then
				if isLaw(source) then
					if getPedWeapon(source) == 23 or getPedWeapon(source) == 3 then
						if getPedControlState(source,"fire") or getPedControlState(source,"aim_weapon") then
							if getElementHealth(target) <= 10 then
								triggerServerEvent("onPlayerTargetLossWanted",source,target)
							end
						end
					end
				end
			end
		end
	end
end
addEventHandler ( "onClientPlayerTarget", getRootElement(), targetingActivated )

function onPlayerLag(police,crim)
	if police and crim then
		if getPlayerPing(crim) >= 700 or getElementData(crim,"isPlayerLoss") then
			lag = lag + 1
			if lag > 5 then
				if police and isElement(police) and crim and isElement(crim) then
					triggerServerEvent ( "onJailArrestedPlayers", police, "FBI", crim,true )
				else
					if isTimer(who) then killTimer(who) end
				end
			end
		end
	end
end


addEvent("releaseFromTheClient",true)
addEventHandler("releaseFromTheClient",root,function(pr)
	lag = 0
	CrimPosition = nil
	copPosition = nil
	if isTimer(who) then killTimer(who) end
end)


function follow()
	if ( officer ) then
		local prisoner = arrestedPerson
		local officerX, officerY, officerZ = getElementPosition ( officer )
		local prisonerX, prisonerY, prisonerZ = getElementPosition ( prisoner )
		local distance = getDistanceBetweenPoints3D ( officerX, officerY, officerZ, prisonerX, prisonerY, prisonerZ )
		if ( getElementData ( prisoner, "isPlayerArrested" ) ) then
			local officerRotation = ( 360 - math.deg ( math.atan2 ( ( officerX - prisonerX ), ( officerY - prisonerY ) ) ) ) % 360
			setPedRotation ( prisoner, officerRotation )

			if ( getElementDimension( prisoner ) ~= getElementDimension( officer ) ) then
				exports.server:setClientPlayerDimension( prisoner, getElementDimension( officer ) )
			end

			if ( getElementInterior( prisoner ) ~= getElementInterior( officer ) ) then
				exports.server:setClientPlayerInterior( prisoner, getElementInterior( officer ) )
			end
			local vehicle = getPedOccupiedVehicle(officer)

			--[[local vehicle = getPedOccupiedVehicle(officer)
			if ( distance > 9 ) and ( isPedInVehicle ( officer ) ) and not ( isPedInVehicle ( prisoner ) )  then
				if (getElementModel(getPedOccupiedVehicle(officer)) == 510) or (getElementModel(getPedOccupiedVehicle(officer)) == 481) or (getElementModel(getPedOccupiedVehicle(officer)) == 509) or (getElementModel(getPedOccupiedVehicle(officer)) == 571) then
					if not getElementData(prisoner,"isPlayerJailed") then
						triggerServerEvent( "onReleasePlayerFromArrest", prisoner, officer )
					end
				end
				setControlState ( "sprint", true )
				setControlState ( "walk", false )
				setControlState ( "forwards", true )
				setControlState ( "jump", true )
			elseif ( distance > 15 ) then
				setControlState ( "sprint", true )
				setControlState ( "walk", false )
				setControlState ( "forwards", true )
				setControlState ( "jump", true )
				setElementPosition (prisoner, officerX + 1, officerY + 1, officerZ)
				setTimer ( follow, 500, 1, officer, prisoner )
			elseif ( distance > 9 ) then
				setControlState ( "sprint", true )
				setControlState ( "walk", false )
				setControlState ( "forwards", true )
				setTimer ( follow, 500, 1, officer, prisoner )
			elseif ( distance > 6 ) then
				setControlState ( "sprint", false )
				setControlState ( "walk", false )
				setControlState ( "forwards", true )
				setTimer ( follow, 500, 1, officer, prisoner )
			elseif ( distance > 1.5 ) then
				setControlState ( "sprint", false )
				setControlState ( "walk", true )
				setControlState ( "forwards", true )
				setTimer ( follow, 500, 1, officer, prisoner )
			elseif ( distance < 1.5 ) then
				setControlState ( "sprint", false )
				setControlState ( "walk", false )
				setControlState ( "forwards", false )
				setTimer ( follow, 500, 1, officer, prisoner )
			end]]

			if (distance > 35) and ( isPedInVehicle ( officer ) ) and not ( isPedInVehicle ( prisoner ) )  then
				--if (getElementModel(getPedOccupiedVehicle(officer)) == 510) or (getElementModel(getPedOccupiedVehicle(officer)) == 481) or (getElementModel(getPedOccupiedVehicle(officer)) == 509) or (getElementModel(getPedOccupiedVehicle(officer)) == 571) then
				if not getElementData(prisoner,"isPlayerJailed") then
					triggerServerEvent( "onReleasePlayerFromArrest", prisoner, officer )
				end
				setControlState ( "sprint", true )
				setControlState ( "walk", false )
				setControlState ( "forwards", true )
				setControlState ( "jump", true )
				local posx,posy,posz = getElementPosition(prisoner)
				local posx2,posy,posz = getElementPosition(officer)
				CrimPosition = posx
				copPosition = posx2
			elseif (distance > 15) then
				setControlState("sprint", false)
				setControlState("walk", false)
				setControlState("forwards", true)
				setControlState("jump", true)
				setTimer ( follow, 100, 1, officer, prisoner )
				setElementPosition (prisoner, officerX + 1, officerY + 1, officerZ)
				local posx,posy,posz = getElementPosition(prisoner)
				local posx2,posy,posz = getElementPosition(officer)
				CrimPosition = posx
				copPosition = posx2
			elseif (distance > 10) then
				setControlState("sprint", true)
				setControlState("walk", false)
				setControlState("forwards", true)
				setControlState("jump", false)
				setTimer ( follow, 100, 1, officer, prisoner )
				local posx,posy,posz = getElementPosition(prisoner)
				local posx2,posy,posz = getElementPosition(officer)
				CrimPosition = posx
				copPosition = posx2
			elseif (distance > 5) then
				setControlState("sprint", false)
				setControlState("walk", false)
				setControlState("forwards", true)
				setControlState("jump", false)
				setTimer ( follow, 100, 1, officer, prisoner )
				local posx,posy,posz = getElementPosition(prisoner)
				local posx2,posy,posz = getElementPosition(officer)
				CrimPosition = posx
				copPosition = posx2
			elseif (distance <= 5) and distance > 2 then
				setControlState("sprint", false)
				setControlState("walk", false)
				setControlState("forwards", true)
				setControlState("jump", false)
				setTimer ( follow, 100, 1, officer, prisoner )
				setElementPosition (prisoner, officerX + 1, officerY + 1, officerZ)
				local posx,posy,posz = getElementPosition(prisoner)
				local posx2,posy,posz = getElementPosition(officer)
				CrimPosition = posx
				copPosition = posx2
			elseif (distance > 1.5) then
				setControlState("sprint", false)
				setControlState("walk", true)
				setControlState("forwards", true)
				setControlState("jump", false)
				setTimer ( follow, 100, 1, officer, prisoner )
				local posx,posy,posz = getElementPosition(prisoner)
				local posx2,posy,posz = getElementPosition(officer)
				CrimPosition = posx
				copPosition = posx2
			elseif (distance < 1.5) then
				setControlState("sprint", false)
				setControlState("walk", false)
				setControlState("forwards", false)
				setControlState("jump", false)
				setTimer ( follow, 100, 1, officer, prisoner )
				local posx,posy,posz = getElementPosition(prisoner)
				local posx2,posy,posz = getElementPosition(officer)
				CrimPosition = posx
				copPosition = posx2
			end
			if ( isControlEnabled ( "fire" ) ) then
				toggleAllControls ( false, true, false )
			end

			if not ( isPedInVehicle ( prisoner ) ) then
				setCameraTarget ( prisoner, prisoner )
			end

			if ( isPedInVehicle ( officer ) ) then
				if not ( isPedInVehicle( prisoner ) ) then
					triggerServerEvent("warpPrisonerIntoVehicle", prisoner, officer)
					if isTimer(theTimer) then killTimer(theTimer) end
				end
			end

			if ( isPedInVehicle ( prisoner ) ) and not ( isPedInVehicle( officer ) ) then
				triggerServerEvent("removePrisonerOutVehicle", prisoner, officer)
			end
		end
	end
end

setTimer(function()
	local prisoner = arrestedPerson
	if prisoner and isElement(prisoner) and officer and isElement(officer) then
		if isLaw(officer) and getElementData(prisoner,"isPlayerArrested") then
			if not ( isPedInVehicle ( prisoner ) ) then
				if CrimPosition ~= nil and copPosition ~= nil then
					local newCrimPosition,newy,newz = getElementPosition(prisoner)
					local newCopPosition,newy2,newz2 = getElementPosition(officer)
					local distance = getDistanceBetweenPoints3D ( newCrimPosition,newy,newz, newCopPosition,newy2,newz2 )
					local mov = getPedMoveState(officer)
					if mov ~= "stand" and distance < 10 then
						return false
					end
					if distance < 10 then return false end
					if newCrimPosition == CrimPosition then
						if newCopPosition ~= copPosition then
							triggerServerEvent("onlawCheckLaw",prisoner,officer,prisoner)
							local theOfficer = getElementData ( prisoner, "arrestedBy" )
							triggerServerEvent ( "onJailArrestedPlayers", theOfficer,"LS1",prisoner )
						--	triggerServerEvent("onServerLawMsg",prisoner,officer,"Send same position")
						else
						--	triggerServerEvent("onServerLawMsg",prisoner,officer,"Abort cop position is the same as old")
						end
					else
						--triggerServerEvent("onServerLawMsg",prisoner,officer,"Abort Criminal position is the same as old")
					end
				end
			end
		end
	end
end,10000,0)
-- The tazer script with checks
local tazerTable = {}

addEvent("tazed",true)
addEventHandler("tazed",root,function()

end)


function targetingActivated ( target )
	if source == localPlayer then
		if isLaw(source) then
			if target and isElement(target) and getElementType ( target ) == "player" and not isPedInVehicle(target) then
				if getPlayerTeam(target) and getTeamName(getPlayerTeam(target)) ~= "Staff" then
					if getPedWeapon(source) == 3 then
						if getPedControlState(source,"fire") then
							if getElementData(target,"wantedPoints") >= 10 then
								if getElementData(target,"isPlayerArrested") then return false end
								if getElementData(target,"isPlayerJailed") then return false end
								local ax, ay, az = getElementPosition( target )
								local bx, by, bz = getElementPosition( source )
								if ( math.floor ( getDistanceBetweenPoints2D( ax, ay, bx, by ) ) <= 2 ) then
									triggerServerEvent("onPlayerArrestedLagPlayer",localPlayer,target)
								end
							end
						end
					end
				end
			end
		end
	end
end
addEventHandler ( "onClientPlayerTarget", getRootElement(), targetingActivated )

addEvent("onClientPlayerTaze", true)
addEventHandler("onClientPlayerTaze", root,
function( attacker, weapon, bodypart )
	if ( isElement( attacker ) ) and ( source == localPlayer) then
		if ( weapon == 23 ) and ( getPlayerTeam( attacker ) ) and not ( getTeamName( getPlayerTeam( attacker ) ) == "Staff" ) then
			if ( getElementData( source, "wantedPoints" ) >= 10 ) then
				if ( canCopTazer ( attacker, source ) ) then
					if not ( getElementData ( source, "safezone" ) ) then
						if not ( getElementData ( source, "isPlayerArrested" ) ) then
							if not ( getElementData ( source, "isPlayerRobbing" ) ) or not ( getElementData ( source, "robberyFinished" ) ) then
								if not ( getElementData ( source, "isPlayerInMotel" ) ) or not ( getElementData ( source, "JefFinished" ) ) then
									if not ( getElementData ( source, "isPlayerRobbing" ) ) and not ( getElementDimension( source ) == 1 ) or not ( getElementDimension( source ) == 2 ) or not ( getElementDimension( source ) == 3 ) then
										if getElementDimension(attacker) ~= 0 then return false end
										local ax, ay, az = getElementPosition( attacker )
										local bx, by, bz = getElementPosition( source )
										if ( tazerTable[attacker] ) and ( getTickCount()-tazerTable[attacker] < 1500 ) or ( math.floor ( getDistanceBetweenPoints2D( ax, ay, bx, by ) ) > 14 ) then
										--if ( math.floor ( getDistanceBetweenPoints2D( ax, ay, bx, by ) ) > 14 ) then

											cancelEvent()
										elseif ( getElementData( attacker, "Occupation" ) == "K-9 Unit Officer" ) then
											cancelEvent()
											tazerTable[attacker] = getTickCount()
											triggerServerEvent( "onWantedPlayerGotTazerd", attacker, source, true )
										else
											cancelEvent()
											tazerTable[attacker] = getTickCount()
											triggerServerEvent( "onWantedPlayerGotTazerd", attacker, source )
										end
									end
								end
							end
						end
					end
				end
			else
				cancelEvent()
			end
		end
	end
end
)

-- Check if tazer is allowed
function canCopTazer ( officer, thePrisoner )
	if ( thePrisoner ) and ( officer ) and ( officer ~= thePrisoner ) and ( getTeamName( getPlayerTeam( officer ) ) ) and ( getTeamName( getPlayerTeam( thePrisoner ) ) ) then
		local attackerTeam = (getTeamName(getPlayerTeam(officer)))
		local sourceTeam = (getTeamName(getPlayerTeam(thePrisoner)))
		if getElementDimension(officer) ~= 0 then return false end
		if getElementData ( thePrisoner, "isPlayerArrested" ) then
			return false
		elseif getElementData ( thePrisoner, "isPlayerJailed" ) and getElementDimension(thePrisoner) == 2 then
			return false
		elseif ( getElementData ( thePrisoner, "isPlayerRobbing" ) ) or ( getElementData ( thePrisoner, "robberyFinished" ) ) then
			return false
		elseif ( getElementData ( thePrisoner, "isPlayerInMotel" ) ) or ( getElementData ( thePrisoner, "JefFinished" ) ) then
			return false
		elseif isLaw(thePrisoner) then
			return false
		elseif ( attackerTeam == "Government" ) then
			if ( sourceTeam == "Government" ) then
				return false
			else
				return true
			end
		elseif ( attackerTeam == "Military Forces" ) then
			if ( sourceTeam == "Military Forces" ) then
				return false
			else
				return true
			end
		elseif ( attackerTeam == "SWAT Team" ) then
			if ( sourceTeam == "SWAT Team" ) then
				return false
			else
				return true
			end
		else
			return false
		end
	end
end


-- Check if the attack is allowed
function isAttackNotAllowed (attacker, victim)
	if getElementData(victim, "wantedPoints") > 9 then
		if isPlayerLawEnforcer(attacker) then
			return false
		else
			return true
		end
	else
		return true
	end
end

-- Check if the police are friends
function isActionNotAllowedForLaw ( attacker, victim )
	if ( victim ) and ( attacker ) and ( attacker ~= victim ) then
		if isPlayerLawEnforcer(attacker) then
			if isPlayerLawEnforcer(victim) then
				return false
			else
				return true
			end
		else
			return true
		end
	else
		return false
	end
end

-- When player damage let him fall of bike
addEvent("onClientLocalPlayerDamage", true)
addEventHandler( "onClientLocalPlayerDamage", localPlayer,
function ( attacker, weapon, bodypart )
	if ( isPedInVehicle ( source ) ) then
		if ( source == localPlayer ) then
			local theVehicle = getPedOccupiedVehicle( source )
			local theHealth = getElementHealth( source )
			if ( theHealth < 20 ) then
				if ( getVehicleType ( theVehicle ) == "BMX" ) or ( getVehicleType ( theVehicle ) == "Bike" ) then
					triggerServerEvent( "onRemovePlayerFromBike", source )
				end
			end
		end
	end
end
)

-- Check if a player is a law player
local lawTeams = {
	"Government",
	"Military Forces",
	"Advanced Assault Forces",
}

function isPlayerLawEnforcer ( thePlayer )
	if ( isElement( thePlayer ) ) and ( getPlayerTeam ( thePlayer ) ) then
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

function isLaw ( thePlayer )
	if ( isElement( thePlayer ) ) and ( getPlayerTeam ( thePlayer ) ) then
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

addEventHandler("onClientElementDataChange",localPlayer,function(k,v)
	if source == localPlayer and k == "isPlayerArrested" then
		if getElementData(localPlayer,"isPlayerArrested") == true then
			addEventHandler("onClientRender",root,draw)
		else
			removeEventHandler("onClientRender",root,draw)
		end
	end
end)


function AbsoluteToRelativ2( X, Y )
    local rX, rY = guiGetScreenSize()
    local x = math.floor(X*rX/1280)
    local y = math.floor(Y*rY/768)
    return x, y
end


function draw()
			x,y=AbsoluteToRelativ2(650, 677)
			x2,y2=AbsoluteToRelativ2(750, 702)
			dxDrawText("Lagger & NT Abusers will result in auto jail", x,y,x2,y2, tocolor(255,0,0, 255), 0.8, "default-bold", "center", "top", false, false, true, false, false)
			x,y=AbsoluteToRelativ2(650, 707)
			x2,y2=AbsoluteToRelativ2(750, 732)
			dxDrawText("You are under arrest. Do NOT quit or reconnect.", x,y,x2,y2, tocolor(255,0,0, 255), 0.8, "default-bold", "center", "top", false, false, true, false, false)
			x,y=AbsoluteToRelativ2(650, 730)
			x2,y2=AbsoluteToRelativ2(750, 765)
			dxDrawText("You will be jailed and fined 5 Scores for intentional disconnection!", x,y,x2,y2, tocolor(255,250,250, 255), 0.8, "default", "center", "top", false, false, true, false, false)
end


addEventHandler("onClientResourceStart", resourceRoot, function()
	local txd = engineLoadTXD("cuffs.txd")
	engineImportTXD(txd, 331)
	local dff = engineLoadDFF("cuffs.dff")
	engineReplaceModel(dff, 331)
end)