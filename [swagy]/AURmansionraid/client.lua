local wave = 1

-- Disable bombs


addEventHandler( "onClientProjectileCreation", root,
function ( creator )
	if ( getElementData ( localPlayer, "isPlayerInMR" ) ) then
		if ( getProjectileType( source ) == 16 ) or ( getProjectileType( source ) == 17 ) or ( getProjectileType( source ) == 18 ) or ( getProjectileType( source ) == 39 ) then

			if ( creator == localPlayer ) then
				-------
			end

			destroyElement( source )
		end
	end
end
)

addEventHandler("onClientExplosion", root,
function(x, y, z, theType)
	if (getElementData(localPlayer, "isPlayerInMR")) then
		cancelEvent()
	end
end)


weapons = {
	[1] = {2, 3, 4, 5, 6, 7, 8, 9},
	[2] = {22, 23, 24},
	[3] = {25, 26, 27},
	[4] = {28, 29, 32},
	[5] = {30, 31},
	[6] = {33, 34},
	[7] = {35, 36, 37,38},
	[8] = {16, 17, 18, 39},
	[9] = {41, 42, 43},
	[10] = {10, 11, 12, 13, 14, 15},
	[11] = {44, 45, 46},
	[12] = {40},
}

restrictedWeapons = {}

function onClientPreRender()
	if getElementData(localPlayer,"isPlayerInMR") then
		local weapon = getPedWeapon(localPlayer)
		local slot = getPedWeaponSlot(localPlayer)
		if (restrictedWeapons[weapon]) then
			local weapons = {}
			for i=1, 30 do
				if (getControlState("next_weapon")) then
					slot = slot + 1
				else
					slot = slot - 1
				end
				if (slot == 13) then
					slot = 0
				elseif (slot == -1) then
					slot = 12
				end

				local w = getPedWeapon(localPlayer, slot)
				if (((w ~= 0 and slot ~= 0) or (w == 0 and slot == 0)) and not restrictedWeapons[w]) then
					setPedWeaponSlot(localPlayer, slot)
					break
				end
			end
		end
	end
end
addEventHandler("onClientPreRender", root, onClientPreRender)

function onClientPlayerWeaponFire(weapon)
	if (restrictedWeapons[weapon]) then return end
end
addEventHandler("onClientPlayerWeaponFire", localPlayer, onClientPlayerWeaponFire)

---- dont forget to make exports for these .........

function setWeaponDisabled(id, bool)
	if (id == 0) then return end
	restrictedWeapons[id] = bool
end

function isWeaponDisabled(id)
	return restrictedWeapons[id]
end

function setWeaponSlotDisabled(slot, bool)
	if (not weapons[slot]) then return end
	for k, v in ipairs(weapons[slot]) do
		setWeaponDisabled(v, bool)
	end
end

addEventHandler("onClientExplosion", localPlayer,
function( x, y, z, theType)
	if ( getElementDimension(localPlayer) == 1 and getElementInterior(localPlayer) == 5 ) then
		cancelEvent()
	end
end
)
kills=0
peds=0
saying = "Guards Alive"
	topKillerLaw = {}
	topKillerCrim = {}
	criminalCount = 0
	lawCount = 0


-- Disable teamkill
addEventHandler( "onClientPlayerDamage", root,
function ( theAttacker )
	if ( isElement( source ) ) and ( isElement( theAttacker ) ) then -- moeten ook nog player zijn he
		if ( getElementType(theAttacker) == "player" ) then
			if ( getPlayerTeam( source ) ) and ( getPlayerTeam( theAttacker ) ) then
				if ( getElementData ( source, "isPlayerInMR" ) ) then
					if ( getTeamName( getPlayerTeam( theAttacker ) ) == "Criminals" ) and ( getTeamName( getPlayerTeam( source ) ) == "Criminals" ) or ( getTeamName( getPlayerTeam( source ) ) == "Paramedics" ) then
						cancelEvent()
					elseif ( getTeamName( getPlayerTeam( theAttacker ) ) == "Paramedics" ) then
						if ( getTeamName( getPlayerTeam( source ) ) == "Criminals" ) or exports.DENlaw:isLaw(source) or ( getTeamName( getPlayerTeam( source ) ) == "Paramedics" ) then
							cancelEvent()
						end
					else
						if exports.DENlaw:isLaw(theAttacker) then
							if exports.DENlaw:isLaw(source) or ( getTeamName( getPlayerTeam( source ) ) == "Paramedics" ) then
								cancelEvent()
							end
						end
					end
				end
			end
		end
	end
end
)
-- Set the mansionraid stats enabled or disabled
addEvent( "onTogglemansionraidStats", true )
addEventHandler( "onTogglemansionraidStats", localPlayer,
	function ( state )
		if ( state ) then
			local team = getTeamName(getPlayerTeam(localPlayer))
			if team == "Criminals" then
				saying = "Security Guards Alive"
			else
				saying = "Mafia Men Alive"
			end
			setElementData(localPlayer,"isPlayerInMR",true)

			setWeaponSlotDisabled(7,true)
			setWeaponSlotDisabled(8,true)
			addEventHandler( "onClientRender", root, onDrawmansionraidStats )
		else
			removeEventHandler( "onClientRender", root, onDrawmansionraidStats )
			setElementData(localPlayer,"isPlayerInMR",false)
			setWeaponSlotDisabled(7,false)
			setWeaponSlotDisabled(8,false)
		end
	end
)


addEventHandler("onClientPlayerWasted",localPlayer,function()
	triggerEvent("onTogglemansionraidStats",localPlayer,false)
	if getElementData(localPlayer,"isPlayerInMR") then
		setElementData(localPlayer,"isPlayerInMR",false)
	end
end)

-- Reset the counters for everyone
addEvent( "onResetmansionraidStats", true )
addEventHandler( "onResetmansionraidStats", localPlayer,
	function ()
		kills=0
		topKillerLaw = {}
		topKillerCrim = {}
		criminalCount = 0
		lawCount = 0
		removeEventHandler( "onClientRender", root, onDrawmansionraidStats )
	end
)

-- On count change
addEvent( "onChangeMansionCount", true )
addEventHandler( "onChangeMansionCount", root,
	function ( lawCounts, crimCounts, pedc )
		if ( crimCounts ) then
			criminalCount = crimCounts
		end
		peds=pedc
		if ( lawCounts ) then
			lawCount = lawCounts
		end
	end
)

-- Get the top killers
function getTopKillersmansionraid ()
	local C1, C2, C3, C4, C5, L1, L2, L3, L4, L5 = "Noone yet", "Noone yet", "Noone yet", "Noone yet", "Noone yet", "Noone yet", "Noone yet", "Noone yet", "Noone yet", "Noone yet",

	table.sort( topKillerLaw )
	table.sort( topKillerCrim )

	local i1 = 1

	for thePlayer, theKills in pairs ( topKillerLaw ) do
		if ( isElement( thePlayer ) ) then
			if ( i1 >= 5 ) then
				break;
			else
				if ( i1 == 1 ) then
					L1 = getPlayerName( thePlayer ).." ("..theKills..")"
					i1 = i1 + 1
				elseif ( i1 == 2 ) then
					L2 = getPlayerName( thePlayer ).." ("..theKills..")"
					i1 = i1 + 1
				elseif ( i1 == 3 ) then
					L3 = getPlayerName( thePlayer ).." ("..theKills..")"
					i1 = i1 + 1
				elseif ( i1 == 4 ) then
					L4 = getPlayerName( thePlayer ).." ("..theKills..")"
					i1 = i1 + 1
				elseif ( i1 == 5 ) then
					L5 = getPlayerName( thePlayer ).." ("..theKills..")"
					i1 = i1 + 1
				end
			end
		else
			topKillerLaw[thePlayer] = {}
		end
	end

	local i2 = 1

	for thePlayer, theKills in pairs ( topKillerCrim ) do
		if ( isElement( thePlayer ) ) then
			if ( i2 >= 5 ) then
				break;
			else
				if ( i2 == 1 ) then
					C1 = getPlayerName( thePlayer ).." ("..theKills..")"
					i2 = i2 + 1
				elseif ( i2 == 2 ) then
					C2 = getPlayerName( thePlayer ).." ("..theKills..")"
					i2 = i2 + 1
				elseif ( i2 == 3 ) then
					C3 = getPlayerName( thePlayer ).." ("..theKills..")"
					i2 = i2 + 1
				elseif ( i2 == 4 ) then
					C4 = getPlayerName( thePlayer ).." ("..theKills..")"
					i2 = i2 + 1
				elseif ( i2 == 5 ) then
					C5 = getPlayerName( thePlayer ).." ("..theKills..")"
					i2 = i2 + 1
				end
			end
		else
			topKillerCrim[thePlayer] = {}
		end
	end

	return C1, C2, C3, C4, C5, L1, L2, L3, L4, L5
end

-- Insert into top list when player kills a player
addEventHandler( "onClientPlayerWasted", root,
	function ( theKiller, weapon, bodypart )
		if ( isElement( theKiller ) ) and getElementType(theKiller) == "player" and ( getPlayerTeam( theKiller ) ) then
			if ( getElementDimension(theKiller) == 1 and getElementInterior(theKiller) == 5 ) then
				if ( getTeamName( getPlayerTeam( theKiller ) ) == "Criminals" ) then
					if ( topKillerCrim[theKiller] ) then
						topKillerCrim[theKiller] = topKillerCrim[theKiller] +1
					else
						topKillerCrim[theKiller] = 1
					end
				elseif exports.DENlaw:isLaw(theKiller) then
					if ( topKillerLaw[theKiller] ) then
						topKillerLaw[theKiller] = topKillerLaw[theKiller] +1
					else
						topKillerLaw[theKiller] = 1
					end
				end
			end
		end
	end
)

function updateKill ( theKiller, weapon, bodypart )
		if ( isElement( theKiller ) ) and getElementType(theKiller) == "player" and ( getPlayerTeam( theKiller ) ) then
			if theKiller == localPlayer and getElementDimension(theKiller) == 1 and getElementInterior(theKiller) == 5 then
				kills=kills+1
			end
			if ( getElementDimension(theKiller) == 1 and getElementInterior(theKiller) == 5 ) then
				if (getPlayerTeam( theKiller )) and ( getTeamName( getPlayerTeam( theKiller ) ) == "Criminals" ) then
					if ( topKillerCrim[theKiller] ) then
						topKillerCrim[theKiller] = topKillerCrim[theKiller] +1
					else
						topKillerCrim[theKiller] = 1
					end
				elseif exports.DENlaw:isLaw(theKiller) then
					if ( topKillerLaw[theKiller] ) then
						topKillerLaw[theKiller] = topKillerLaw[theKiller] +1
					else
						topKillerLaw[theKiller] = 1
					end
				end
			end
		end
	end
addEvent("NGCraid:updateKill", true)
addEventHandler("NGCraid:updateKill", root, updateKill)

timeLeft=0
tickTimer=false
addEvent("NGCraid:updateTimer",true)
addEventHandler("NGCraid:updateTimer",root,function(left)
	timeLeft = left
end)

-- mansionraid stats
local sx, sy = guiGetScreenSize()

function onDrawmansionraidStats ()
	C1, C2, C3, C4, C5, L1, L2, L3, L4, L5 = getTopKillersmansionraid ()
	-- Rectangle
	dxDrawRectangle(sx*(1121.0/1440),sy*(205.0/900),sx*(248.0/1440),sy*(257.0/900),tocolor(0,0,0,100),false)
	-- Top killers Law
	dxDrawText("5. "..L5,sx*(1125.0/1440),sy*(393.0/900),sx*(1359.0/1440),sy*(407.0/900),tocolor(255,255,255,255),0.9,"clear","left","top",false,false,false)
	dxDrawText("4. "..L4,sx*(1125.0/1440),sy*(380.0/900),sx*(1359.0/1440),sy*(394.0/900),tocolor(255,255,255,255),0.9,"clear","left","top",false,false,false)
	dxDrawText("3. "..L3,sx*(1125.0/1440),sy*(368.0/900),sx*(1359.0/1440),sy*(382.0/900),tocolor(255,255,255,255),0.9,"clear","left","top",false,false,false)
	dxDrawText("2. "..L2,sx*(1125.0/1440),sy*(354.0/900),sx*(1359.0/1440),sy*(368.0/900),tocolor(255,255,255,255),0.9,"clear","left","top",false,false,false)
	dxDrawText("1. "..L1,sx*(1125.0/1440),sy*(341.0/900),sx*(1359.0/1440),sy*(355.0/900),tocolor(255,255,255,255),0.9,"clear","left","top",false,false,false)
    dxDrawText("Top killers: (Law)",sx*(1125.0/1440),sy*(318.0/900),sx*(1357.0/1440),sy*(336.0/900),tocolor(0,0,225,225),1.2,"default-bold","left","top",false,false,false)
	-- Top killer Crim
	dxDrawText("5. "..C5,sx*(1125.0/1440),sy*(293.0/900),sx*(1359.0/1440),sy*(307.0/900),tocolor(255,255,255,255),0.9,"clear","left","top",false,false,false)
	dxDrawText("4. "..C4,sx*(1125.0/1440),sy*(279.0/900),sx*(1359.0/1440),sy*(293.0/900),tocolor(255,255,255,255),0.9,"clear","left","top",false,false,false)
	dxDrawText("3. "..C3,sx*(1125.0/1440),sy*(265.0/900),sx*(1359.0/1440),sy*(279.0/900),tocolor(255,255,255,255),0.9,"clear","left","top",false,false,false)
	dxDrawText("2. "..C2,sx*(1125.0/1440),sy*(251.0/900),sx*(1359.0/1440),sy*(265.0/900),tocolor(255,255,255,255),0.9,"clear","left","top",false,false,false)
	dxDrawText("1. "..C1,sx*(1125.0/1440),sy*(235.0/900),sx*(1359.0/1440),sy*(249.0/900),tocolor(255,255,255,255),0.9,"clear","left","top",false,false,false)
    dxDrawText("Top killers: (Criminals)",sx*(1125.0/1440),sy*(209.0/900),sx*(1357.0/1440),sy*(227.0/900),tocolor(225,0,0,225),1.2,"default-bold","left","top",false,false,false)
	-- Totals
	dxDrawText("Cops: "..lawCount,sx*(1125.0/1440),sy*(433.0/900),sx*(1357.0/1440),sy*(451.0/900),tocolor(0,0,225,225),1.2,"default-bold","left","top",false,false,false)
    dxDrawText("Criminals: "..criminalCount,sx*(1125.0/1440),sy*(413.0/900),sx*(1357.0/1440),sy*(431.0/900),tocolor(225,0,0,225),1.2,"default-bold","left","top",false,false,false)
	dxDrawText("Time Left: "..timeLeft.." Seconds",sx*(1125.0/1440),sy*(473.0/900)+20,sx*(1357.0/1440),sy*(431.0/900),tocolor(225,0,0,225),1.2,"default-bold","left","top",false,false,false)
	dxDrawText("Wave: "..wave.."",sx*(1125.0/1440),sy*(473.0/900),sx*(1357.0/1440),sy*(431.0/900),tocolor(225,0,0,225),1.2,"default-bold","left","top",false,false,false)
	dxDrawText(""..peds.." "..saying.."",sx*(1125.0/1440),sy*(533.0/900)+20,sx*(1357.0/1440),sy*(431.0/900),tocolor(225,0,0,225),1.2,"default-bold","left","top",false,false,false)
	dxDrawText("My Kills: "..kills.."",sx*(1125.0/1440),sy*(503.0/900)+20,sx*(1357.0/1440),sy*(431.0/900),tocolor(225,0,0,225),1.2,"default-bold","left","top",false,false,false)

end

addEvent("CSGmd.getKC",true)
addEventHandler("CSGmd.getKC",localPlayer,function()
	triggerServerEvent("CSGmd.recKC",localPlayer,kills)
	triggerEvent("onResetmansionraidStats",localPlayer)
end)

local bags = ""
local monitorBlipVisibilityTimer = ""
function rec(t,s)
	timeLeft=60
	bags=t
	addEventHandler("onClientRender",root,rotateBags)
	setTimer(function() removeEventHandler("onClientRender",root,rotateBags) triggerEvent("onResetmansionraidStats",localPlayer) end,s,1)
end
addEvent("CSGmansionRecBags",true)
addEventHandler("CSGmansionRecBags",localPlayer,rec)

function rotateBags()
	for k,v in pairs(bags) do
		if isElement(v) == false then return end
		local rx,ry,rz = getElementRotation(v)
		rz=rz+1
		if rz > 360 then rz = rz-360 end

		setElementRotation(v,rx,ry,rz)
	end
end

exports.customblips:createCustomBlip(1277.8, -789.11,20,20,"blip.png",99999)


function addWave (state)

	if (state == "add") then
		wave = wave + 1
	else
		wave = 1
	end
end
addEvent("AURmansion:addWave", true)
addEventHandler("AURmansion:addWave", root, addWave)