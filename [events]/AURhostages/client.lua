local topKillerLaw = {}
local hostages = {}

local hostagesCount = 0
local TerroristCount = 0
local lawCount = 0
local bm = 0
local act = {}
local act2 = {}
-- Disable projectiles in bank
addEventHandler( "onClientProjectileCreation", localPlayer,
function ( creator )
	if ( getElementData ( localPlayer, "isPlayerSAPD" ) ) then
		if ( getProjectileType( source ) == 16 ) or ( getProjectileType( source ) == 17 ) or ( getProjectileType( source ) == 18 ) or ( getProjectileType( source ) == 39 ) then

			if ( creator == localPlayer ) then
				exports.NGCdxmsg:createNewDxMessage( "Its not allowed to use projectiles inside the event!", 225, 0, 0 )
			end

			destroyElement( source )
		end
	end
end
)
-- Disable bombs
addEventHandler("onClientExplosion", localPlayer,
function( x, y, z, theType)
	if ( getElementData ( localPlayer, "isPlayerSAPD" ) ) then
		--if ( theType == 0 ) or ( theType == 1 ) then
			cancelEvent()
		--end
	end
end
)

-- Set the HOE stats enabled or disabled
addEvent( "onToggleHOEStats", true )
addEventHandler( "onToggleHOEStats", localPlayer,
	function ( state )
	--[[	if ( state ) then
			addEventHandler( "onClientRender", root, onDrawHOEStats )
			addEventHandler("onClientRender",root,drawHandler)
		else]]
			removeEventHandler( "onClientRender", root, onDrawHOEStats )
			removeEventHandler("onClientRender",root,drawHandler)
		--end
	end
)


-- Set the HOE stats enabled or disabled
addEvent( "onToggleHR", true )
addEventHandler( "onToggleHR", localPlayer,function()
	addEventHandler( "onClientRender", root, onDrawHOEStats )
	addEventHandler("onClientRender",root,drawHandler)
end)

-- Reset the counters for everyone
addEvent( "onResetHOEStats", true )
addEventHandler( "onResetHOEStats", localPlayer,
	function ()
		topKillerLaw = {}
		hostages = {}
		lawCount = 0
		TerroristCount = 0
		hostagesCount = 0
		handle = 0
		bm = 0
		act = {}
		act2 = {}
		--removeEventHandler( "onClientRender", root, onDrawHOEStats )
		--removeEventHandler("onClientRender",root,drawHandler)
	end
)

-- On count change
addEvent( "onChangeHOECount", true )
addEventHandler( "onChangeHOECount", root,
	function ( lawCounts )
		if ( lawCounts ) then
			lawCount = lawCounts
		end
	end
)



addEventHandler("onClientPedDamage",root,function(attacker)
	if getElementData(source,"kills") == true then
		if attacker and getElementType(attacker) == "player" then
			cancelEvent(true)
		end
	end
end)

addEvent("assignHostages",true)
addEventHandler("assignHostages",root,function(cunts)
	hostagesCount = cunts
end)

-- Insert into top list when player kills a player
addEventHandler( "onClientPedWasted", root,
	function ( theKiller, weapon, bodypart )
		if source and getElementData(source,"bot") or getElementData(source,"botX") then
			if ( isElement( theKiller ) ) and getElementType(theKiller) == "player" and ( getPlayerTeam( theKiller ) ) and ( getElementType( theKiller ) == "player" ) then
				if ( getElementData( theKiller, "isPlayerSAPD" ) ) then
					if exports.DENjob:isFirstLaw(theKiller) then
						if ( topKillerLaw[theKiller] ) then
							topKillerLaw[theKiller] = topKillerLaw[theKiller] +1
						else
							topKillerLaw[theKiller] = 1
						end
					end
				end
			end
		end
	end
)


addEvent("calcBots",true)
addEventHandler("calcBots",root,function(th)
TerroristCount = th
end)

addEvent("removeBots",true)
addEventHandler("removeBots",root,function(thing)
TerroristCount = 0
end)

addEvent("sendTimers",true)
addEventHandler("sendTimers",root,function(thing)
	msg = true
	st = thing
end)


-- Get the top killers
function getTopKillersHOE ()
	local C1, C2, C3, C4, C5, L1, L2, L3, L4, L5 = "Noone yet", "Noone yet", "Noone yet", "Noone yet", "Noone yet", "Noone yet", "Noone yet", "Noone yet", "Noone yet", "Noone yet",

	table.sort( topKillerLaw )
	table.sort( hostages )

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

	return L1, L2, L3, L4, L5
end

-- HOE stats
local sx, sy = guiGetScreenSize()

function dxDrawDxText(text,x,y,w,h,r,g,b,a,size,type,area,sc,state1,state2,state3)
	dxDrawText(text,x,y+200,w,h,tocolor(r,g,b,a),size,type,area,sc,state1,state2,state3)
end


function dxDrawDxRectangle(x,y,w,h,r,g,b,a,state1)
	dxDrawRectangle(x,y+200,w,h,tocolor(r,g,b,a),state1)
end

function onDrawHOEStats ()
	L1, L2, L3, L4, L5 = getTopKillersHOE ()
	-- Rectangle
	dxDrawDxRectangle(sx*(1121.0/1440),sy*(300.0/900),sx*(300/1440),sy*(290.0/900),0,0,0,100,false)
	-- Top killers Law
	dxDrawDxText("5. "..L5,sx*(1125.0/1440),sy*(393.0/900),sx*(1359.0/1440),sy*(407.0/900),255,255,255,255,0.9,"clear","left","top",false,false,false)
	dxDrawDxText("4. "..L4,sx*(1125.0/1440),sy*(380.0/900),sx*(1359.0/1440),sy*(394.0/900),255,255,255,255,0.9,"clear","left","top",false,false,false)
	dxDrawDxText("3. "..L3,sx*(1125.0/1440),sy*(368.0/900),sx*(1359.0/1440),sy*(382.0/900),255,255,255,255,0.9,"clear","left","top",false,false,false)
	dxDrawDxText("2. "..L2,sx*(1125.0/1440),sy*(354.0/900),sx*(1359.0/1440),sy*(368.0/900),255,255,255,255,0.9,"clear","left","top",false,false,false)
	dxDrawDxText("1. "..L1,sx*(1125.0/1440),sy*(341.0/900),sx*(1359.0/1440),sy*(355.0/900),255,255,255,255,0.9,"clear","left","top",false,false,false)
    dxDrawDxText("Top killers: (Law)",sx*(1125.0/1440),sy*(318.0/900),sx*(1357.0/1440),sy*(336.0/900),0,0,225,225,1.2,"default-bold","left","top",false,false,false)
	-- Totals
	dxDrawDxText("Cops: "..lawCount,sx*(1125.0/1440),sy*(450.0/900),sx*(1357.0/1440),sy*(440.0/900),0,0,225,225,1.2,"default-bold","left","top",false,false,false)
	dxDrawDxText("Terrorist: "..TerroristCount,sx*(1125.0/1440),sy*(480.0/900),sx*(1357.0/1440),sy*(460.0/900),255,0,0,225,1.2,"default-bold","left","top",false,false,false)
    dxDrawDxText("Hostages: "..hostagesCount,sx*(1125.0/1440),sy*(420.0/900),sx*(1357.0/1440),sy*(440.0/900),255,155,0,225,1.2,"default-bold","left","top",false,false,false)

	act = {}
	act2 = {}
    for k,v in ipairs(getElementsByType("marker",resourceRoot)) do
		if getElementData(v,"status") then
			table.insert(act,v)
		end
	end
	for k,v in ipairs(getElementsByType("marker",resourceRoot)) do
		if getElementData(v,"status2") then
			table.insert(act2,v)
		end
	end
	if act and #act > 0 then
		dxDrawDxText("Bombs active left: "..#act,sx*(1125.0/1440),sy*(510.0/900),sx*(1357.0/1440),sy*(440.0/900),255,0,0,225,1.2,"default-bold","left","top",false,false,false)
		else
		dxDrawDxText("Bombs active left: 0",sx*(1125.0/1440),sy*(510.0/900),sx*(1357.0/1440),sy*(440.0/900),0,255,0,225,1.2,"default-bold","left","top",false,false,false)
	end
	if act2 and #act2 >= 0 then
		dxDrawDxText("MCP left: "..#act2,sx*(1125.0/1440),sy*(540.0/900),sx*(1357.0/1440),sy*(440.0/900),255,0,0,225,1.2,"default-bold","left","top",false,false,false)
	end
end

function drawHandler()
	if  exports.DENjob:isFirstLaw(localPlayer) or exports.DENlaw:isLaw(localPlayer) and getElementData(localPlayer,"Group") == "United States Air Force " then
		if getElementData(localPlayer,"isPlayerSAPD") == true then
			dxDrawDxRectangle(sx*(1121.0/1440),sy*(250.0/900),sx*(300.0/1440),sy*(27.0/900),0,0,0,100,false)
			if msg == true then
				dxDrawDxText(st,sx*(1124.0/1440),sy*(250.0/900),sx*(1357.0/1440),sy*(431.0/900),0,0,0,225,1.2,"default-bold","left","top",false,false,false)
				dxDrawDxText(st,sx*(1125.0/1440),sy*(250.0/900),sx*(1357.0/1440),sy*(431.0/900),0,255,0,225,1.2,"default-bold","left","top",false,false,false)
			end
		end
	end
end

blip = exports.customblips:createCustomBlip( 1779.78, -1258.52,18,18,"T.png",500)
exports.customblips:setCustomBlipRadarScale(blip,0.8,0.8)
