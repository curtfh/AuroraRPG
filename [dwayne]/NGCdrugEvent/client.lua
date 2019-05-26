local shipCol = createColCircle(2804.58,-2450.42,200)


local sxW,syW = guiGetScreenSize()
local sx, sy = guiGetScreenSize()
local lawCount = 0
local crimCount = 0
local CopsKills = {}
local CriminalsKills = {}
local isEventFinished = false
local show = false


function dxDrawRelativeText( text,posX,posY,right,bottom,color,scale,mixed_font,alignX,alignY,clip,wordBreak,postGUI )
    local resolutionX = 1366
    local resolutionY = 768
    local sWidth,sHeight = guiGetScreenSize( )
    return dxDrawText(
        tostring( text ),
        ( posX/resolutionX )*sWidth,
        ( posY/resolutionY )*sHeight,
        ( right/resolutionX )*sWidth,
        ( bottom/resolutionY)*sHeight,
        color,
		( sWidth/resolutionX )*scale,
        mixed_font,
        alignX,
        alignY,
        clip,
        wordBreak,
        postGUI
    )
end


function dxDrawRelativeRectangle( posX, posY, width, height,color,postGUI )
    local resolutionX = 1366
    local resolutionY = 768
    local sWidth,sHeight = guiGetScreenSize( )
    return dxDrawRectangle(
        ( posX/resolutionX )*sWidth,
        ( posY/resolutionY )*sHeight,
        ( width/resolutionX )*sWidth,
        ( height/resolutionY )*sHeight,
        color,
        postGUI
    )
end

function dxDrawRelativeLine( posX, posY, width, height,color, size, postGUI )
    local resolutionX = 1366
    local resolutionY = 768
    local sWidth,sHeight = guiGetScreenSize( )
    return dxDrawLine(
        ( posX/resolutionX )*sWidth,
        ( posY/resolutionY )*sHeight,
        ( width/resolutionX )*sWidth,
        ( height/resolutionY )*sHeight,
		color,
        size,
        postGUI
    )
end

addEvent("drawMoney",true)
addEventHandler("drawMoney",root,function(a1,a2,a3,r1,r2,r3)
	l1 = a1
    l2 = a2
    l3 = a3
	r,g,b = r1,r2,r3
	show = true
	if isTimer(dm) then return false end
	dm = setTimer(function()
		show = false
	end,5000,1)
end)

local screenWidth, screenHeight = guiGetScreenSize() -- Get the screen resolution
function drawx()
	if show == true then
		dxDrawColorText(l1,screenWidth*0.25, screenHeight*0.30, screenWidth*0.75, screenHeight, tocolor(r,g,b,255),1.1,"pricedown","center")
		dxDrawColorText(l2,screenWidth*0.25, screenHeight*0.45, screenWidth*0.75, screenHeight, tocolor(r,g,b,255),1.1,"pricedown","center")
		dxDrawColorText(l3,screenWidth*0.25, screenHeight*0.60, screenWidth*0.75, screenHeight, tocolor(r,g,b,255),1.1,"pricedown","center")
	end
end
addEventHandler("onClientRender",root, drawx) -- keep the text visible with onClientRender.


function dxDrawColorText(str, ax, ay, bx, by, color, scale, font, alignX, alignY)
  bx, by, color, scale, font = bx or ax, by or ay, color or tocolor(255,255,255,255), scale or 1, font or "default"
  if alignX then
    if alignX == "center" then
      ax = ax + (bx - ax - dxGetTextWidth(str:gsub("#%x%x%x%x%x%x",""), scale, font))/2
    elseif alignX == "right" then
      ax = bx - dxGetTextWidth(str:gsub("#%x%x%x%x%x%x",""), scale, font)
    end
  end
  if alignY then
    if alignY == "center" then
      ay = ay + (by - ay - dxGetFontHeight(scale, font))/2
    elseif alignY == "bottom" then
      ay = by - dxGetFontHeight(scale, font)
    end
  end
  local alpha = string.format("%08X", color):sub(1,2)
  local pat = "(.-)#(%x%x%x%x%x%x)"
  local s, e, cap, col = str:find(pat, 1)
  local last = 1
  while s do
    if cap == "" and col then color = tocolor(getColorFromString("#"..col..alpha)) end
    if s ~= 1 or cap ~= "" then
      local w = dxGetTextWidth(cap, scale, font)
      dxDrawText(cap, ax, ay, ax + w, by, color, scale, font,"center","top",false,false,true)
      ax = ax + w
      color = tocolor(getColorFromString("#"..col..alpha))
    end
    last = e + 1
    s, e, cap, col = str:find(pat, last)
  end
  if last <= #str then
    cap = str:sub(last)
    dxDrawText(cap, ax, ay, ax + dxGetTextWidth(cap, scale, font), by, color, scale, font,"center","top",false,false,true)
  end

end


addEventHandler( "onClientProjectileCreation", root,
function ( creator )
	if ( getElementData ( localPlayer, "isPlayerRobbingDrugs" ) ) then
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
	if (getElementData(localPlayer, "isPlayerRobbingDrugs")) then
		cancelEvent()
	end
end)


-- Insert into top list when player kills a player
addEventHandler( "onClientPlayerWasted", root,
	function ( theKiller, weapon, bodypart )
		if ( theKiller and isElement(theKiller) and getElementType(theKiller) == "player" ) then
			if ( getElementData( theKiller, "isPlayerRobbingDrugs" ) ) then
				if not getPlayerTeam(theKiller) then return false end
				if getTeamName(getPlayerTeam(theKiller)) == "Criminals" and ( exports.DENlaw:isLaw(source) ) then
					if ( CriminalsKills[theKiller] ) then
						CriminalsKills[theKiller] = CriminalsKills[theKiller] +1
					else
						CriminalsKills[theKiller] = 1
					end
				elseif ( exports.DENlaw:isLaw(theKiller) and getTeamName(getPlayerTeam(source)) == "Criminals" )  then
					if ( CopsKills[theKiller] ) then
						CopsKills[theKiller] = CopsKills[theKiller] +1
					else
						CopsKills[theKiller] = 1
					end
				end
			end
		end
	end
)

-- Get the top killers
function TopKills()
	local C1, C2, C3, C4, C5,C6,C7,C8, L1, L2, L3, L4, L5,L6,L7,L8 = "Noone yet", "Noone yet", "Noone yet", "Noone yet", "Noone yet", "Noone yet", "Noone yet", "Noone yet", "Noone yet", "Noone yet","Noone yet", "Noone yet", "Noone yet", "Noone yet", "Noone yet", "Noone yet"

	--table.sort( CopsKills )
	--table.sort( CriminalsKills )
	    table.sort(CriminalsKills, function(a, b) return a[1] > b[1] end)
	    table.sort(CopsKills, function(a, b) return a[1] > b[1] end)

	local i1 = 1

	for thePlayer, theKills in pairs ( CopsKills ) do
		if ( isElement( thePlayer ) ) then
			if ( i1 > 10 ) then
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
				elseif ( i1 == 6 ) then
					L6 = getPlayerName( thePlayer ).." ("..theKills..")"
					i1 = i1 + 1
				elseif ( i1 == 7 ) then
					L7 = getPlayerName( thePlayer ).." ("..theKills..")"
					i1 = i1 + 1
				elseif ( i1 == 8 ) then
					L8 = getPlayerName( thePlayer ).." ("..theKills..")"
					i1 = i1 + 1
				--[[elseif ( i1 == 9 ) then
					L9 = getPlayerName( thePlayer ).." ("..theKills..")"
					i1 = i1 + 1
				elseif ( i1 == 10 ) then
					L10 = getPlayerName( thePlayer ).." ("..theKills..")"
					i1 = i1 + 1]]
				end
			end
		else
			CopsKills[thePlayer] = {}
		end
	end

	local i2 = 1

	for thePlayer, theKills in pairs ( CriminalsKills ) do
		if ( isElement( thePlayer ) ) then
			if ( i2 > 10 ) then
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
				elseif ( i2 == 6 ) then
					C6 = getPlayerName( thePlayer ).." ("..theKills..")"
					i2 = i2 + 1
				elseif ( i2 == 7 ) then
					C7 = getPlayerName( thePlayer ).." ("..theKills..")"
					i2 = i2 + 1
				elseif ( i2 == 8 ) then
					C8 = getPlayerName( thePlayer ).." ("..theKills..")"
					i2 = i2 + 1
				--[[elseif ( i2 == 9 ) then
					C9 = getPlayerName( thePlayer ).." ("..theKills..")"
					i2 = i2 + 1
				elseif ( i2 == 10 ) then
					C10 = getPlayerName( thePlayer ).." ("..theKills..")"
					i2 = i2 + 1]]
				end
			end
		else
			CriminalsKills[thePlayer] = {}
		end
	end

	return C1, C2, C3, C4, C5,C6,C7,C8, L1, L2, L3, L4, L5,L6,L7,L8
end

addEvent("countDrugShipment",true)
addEventHandler("countDrugShipment",root,function(rob,law)
	crimCount = rob
	lawCount = law
end)


addEvent("drawTime",true)
addEventHandler("drawTime",root,function(tim)
	myTime = setTimer(function() isEventFinished = true end,tim,1)
end)

addEvent("stopDS",true)
addEventHandler("stopDS",root,function()
	isEventFinished = true
end)



-- When player does /banktime
function onCalculateBanktime ( theTime )
	if ( theTime >= 60000 ) then
		local plural = ""
		if ( math.floor((theTime/1000)/60) >= 2 ) then
			plural = "s"
		end

		return tostring(math.floor((theTime/1000)/60) .. " minute" .. plural)
	else
		local plural = ""
		if ( math.floor((theTime/1000)) >= 2 ) then
			plural = "s"
		end

		return tostring(math.floor((theTime/1000)) .. " second" .. plural)
	end
end


addEventHandler("onClientRender",root,function()
	if (isElementWithinColShape(localPlayer,shipCol) and getElementData(localPlayer,"isPlayerRobbingDrugs")) or (isElementWithinColShape(localPlayer,shipCol) and getElementData(localPlayer,"isPlayerInDS")) then
		dxDrawRelativeRectangle(1000,209.0,350,348.0,tocolor(0,0,0,190),false)
		dxDrawRelativeRectangle(1000,555.0,350,148.0,tocolor(0,0,0,190),false)
		C1, C2, C3, C4, C5,C6,C7,C8, L1, L2, L3, L4, L5,L6,L7,L8 = TopKills()
		if myTime and isTimer(myTime) then
			local timeLeft, timeExLeft, timeExMax = getTimerDetails(myTime)
			if timeLeft and tonumber(timeLeft) > 0 then
				dxDrawRelativeText("Mission Time: "..onCalculateBanktime ( math.floor( timeLeft ) ).."",1020,220,1156.0,274.0,tocolor(255,0,0,230),2,"default-bold","left","top",false,false,false)
			end
		elseif isEventFinished == true then
			dxDrawRelativeText("Exit the area, event stopped",1020,220,1156.0,274.0,tocolor(255,0,0,230),1.5,"default-bold","left","top",false,false,false)
		elseif isEventFinished == false then
			dxDrawRelativeText("Please wait until event get started",1020,220,1156.0,274.0,tocolor(255,0,0,230),1.5,"default-bold","left","top",false,false,false)
		end
		dxDrawRelativeText("Criminals: "..crimCount.."",1020,260,1156.0,274.0,tocolor(255,0,0,230),2,"default-bold","left","top",false,false,false)
		dxDrawRelativeText("1) "..C1,1020,310,1156.0,274.0,tocolor(255,0,0,230),0.9,"default-bold","left","top",false,false,false)
		dxDrawRelativeText("2) "..C2,1020,340,1156.0,274.0,tocolor(255,0,0,230),0.9,"default-bold","left","top",false,false,false)
		dxDrawRelativeText("3) "..C3,1020,370,1156.0,274.0,tocolor(255,0,0,230),0.9,"default-bold","left","top",false,false,false)
		dxDrawRelativeText("4) "..C4,1020,400,1156.0,274.0,tocolor(255,0,0,230),0.9,"default-bold","left","top",false,false,false)
		dxDrawRelativeText("5) "..C5,1020,430,1156.0,274.0,tocolor(255,0,0,230),0.9,"default-bold","left","top",false,false,false)
		dxDrawRelativeText("6) "..C6,1020,460,1156.0,274.0,tocolor(255,0,0,230),0.9,"default-bold","left","top",false,false,false)
		dxDrawRelativeText("7) "..C7,1020,490,1156.0,274.0,tocolor(255,0,0,230),0.9,"default-bold","left","top",false,false,false)
		dxDrawRelativeText("8) "..C8,1020,520,1156.0,274.0,tocolor(255,0,0,230),0.9,"default-bold","left","top",false,false,false)


		dxDrawRelativeText("Cops: "..lawCount.."",1200,260,1156.0,274.0,tocolor(0,100,250,230),2,"default-bold","left","top",false,false,false)
		dxDrawRelativeText("1) "..L1,1200,310,1156.0,274.0,tocolor(0,100,250,230),0.9,"default-bold","left","top",false,false,false)
		dxDrawRelativeText("2) "..L2,1200,340,1156.0,274.0,tocolor(0,100,250,230),0.9,"default-bold","left","top",false,false,false)
		dxDrawRelativeText("3) "..L3,1200,370,1156.0,274.0,tocolor(0,100,250,230),0.9,"default-bold","left","top",false,false,false)
		dxDrawRelativeText("4) "..L4,1200,400,1156.0,274.0,tocolor(0,100,250,230),0.9,"default-bold","left","top",false,false,false)
		dxDrawRelativeText("5) "..L5,1200,430,1156.0,274.0,tocolor(0,100,250,230),0.9,"default-bold","left","top",false,false,false)
		dxDrawRelativeText("6) "..L6,1200,460,1156.0,274.0,tocolor(0,100,250,230),0.9,"default-bold","left","top",false,false,false)
		dxDrawRelativeText("7) "..L7,1200,490,1156.0,274.0,tocolor(0,100,250,230),0.9,"default-bold","left","top",false,false,false)
		dxDrawRelativeText("8) "..L8,1200,520,1156.0,274.0,tocolor(0,100,250,230),0.9,"default-bold","left","top",false,false,false)


		dxDrawRelativeLine(1350, 250, 1000, 250,tocolor(255,255,255,255),1.0,false)
		dxDrawRelativeLine(1350, 550, 1000, 550,tocolor(255,255,255,255),1.0,false)
		dxDrawRelativeLine(1350, 300, 1000, 300,tocolor(255,255,255,255),1.0,false)
		dxDrawRelativeLine(1178, 253, 1178, 550,tocolor(255,255,255,255),1.0,false)

		for k,v in ipairs(getElementsByType("marker",resourceRoot)) do
			local id = getElementData(v,"id")
			local data = getElementData(v,"name")
			local owner = getElementData(v,"captured")
			if owner == "law" then
				r,g,b = 0,100,255
			elseif owner == "criminals" then
				r,g,b = 255,0,0
			else
				r,g,b = 255,255,255
			end
			if data and id and owner then
				if owner == "none" then
					dxDrawRelativeText(id.." ) "..data.." captured by "..owner,1020,550+id*18,1156.0,274.0,tocolor(r,g,b,255),1.5,"default-bold","left","top",false,false,false)
				else
					dxDrawRelativeText(id.." ) "..data.." captured by the "..owner,1020,550+id*18,1156.0,274.0,tocolor(r,g,b,255),1.3,"default-bold","left","top",false,false,false)
				end
			end
		end
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
	if isElementWithinColShape(localPlayer,shipCol) then
		if getElementData(localPlayer,"stopDM") then
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
end
addEventHandler("onClientPreRender", root, onClientPreRender)

function onClientPlayerWeaponFire(weapon)
	if (restrictedWeapons[weapon]) then return end
end
addEventHandler("onClientPlayerWeaponFire", localPlayer, onClientPlayerWeaponFire)

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

addEvent("stopDM",true)
addEventHandler("stopDM",root,function()
	for i=1,12 do
		setWeaponSlotDisabled(i,true)
	end
end)

setTimer(function()
	if isElementWithinColShape(localPlayer,shipCol) then
		if doesPedHaveJetPack(localPlayer) then
			triggerServerEvent("removeJetpack",localPlayer)
		end
	end
end,5000,0)

blip = exports.customblips:createCustomBlip( 2838.45, -2437.37,18,18,"drug.png",1000)
