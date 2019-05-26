
function dxDraw(text, x, y, w, h, clr, scale, font, alignX, alignY, clip, wordBreak, postGUI )
	if not wh then wh = 1.5 end
	dxDrawText ( text, x - wh, y - wh, w - wh, h - wh, tocolor ( 0, 0, 0, a ), scale, font, alignX, alignY, clip, wordBreak, false, true) -- black
	dxDrawText ( text, x + wh, y - wh, w + wh, h - wh, tocolor ( 0, 0, 0, a ), scale, font, alignX, alignY, clip, wordBreak, false, true)
	dxDrawText ( text, x - wh, y + wh, w - wh, h + wh, tocolor ( 0, 0, 0, a ), scale, font, alignX, alignY, clip, wordBreak, false, true)
	dxDrawText ( text, x + wh, y + wh, w + wh, h + wh, tocolor ( 0, 0, 0, a ), scale, font, alignX, alignY, clip, wordBreak, false, true)
	dxDrawText ( text, x - wh, y, w - wh, h, tocolor ( 0, 0, 0, a ), scale, font, alignX, alignY, clip, wordBreak, false, true)
	dxDrawText ( text, x + wh, y, w + wh, h, tocolor ( 0, 0, 0, a ), scale, font, alignX, alignY, clip, wordBreak, false, true)
	dxDrawText ( text, x, y - wh, w, h - wh, tocolor ( 0, 0, 0, a ), scale, font, alignX, alignY, clip, wordBreak, false, true)
	dxDrawText ( text, x, y + wh, w, h + wh, tocolor ( 0, 0, 0, a ), scale, font, alignX, alignY, clip, wordBreak, false, true)
	dxDrawText ( text, x, y, w, h, clr, scale, font, alignX, alignY, clip, wordBreak, postGUI, true)
end

function dxDrawRelativeText( text,posX,posY,right,bottom,color,scale,mixed_font,alignX,alignY,clip,wordBreak,postGUI )
    local resolutionX = 1366
    local resolutionY = 768
    local sWidth,sHeight = guiGetScreenSize( )
    return dxDraw(
        tostring( text ),
        ( posX/resolutionX )*sWidth,
        ( posY/resolutionY )*sHeight,
        ( right/resolutionX )*sWidth,
        ( bottom/resolutionY)*sHeight,
        color,( sWidth/resolutionX )*scale,
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

function dxDrawRelativeImage( posX, posY, width, height,path,rot1,rot2,rot3,color,postGUI )
    local resolutionX = 1366
    local resolutionY = 768
    local sWidth,sHeight = guiGetScreenSize( )
    return dxDrawImage(
        ( posX/resolutionX )*sWidth,
        ( posY/resolutionY )*sHeight,
        ( width/resolutionX )*sWidth,
        ( height/resolutionY )*sHeight,
        path,
        rot1,
        rot2,
        rot3,
        color,
        postGUI
    )
end

local redmafia = 0
local yellowmafia = 0
local guard = 0


addEventHandler("onClientRender",root,function()
	--if getElementInterior(localPlayer) == 1 then
		if getElementData(localPlayer,"CW") then
			local redmafia = countPlayersInTeam(getTeamFromName("Red Dragon Mafia"))
			local yellowmafia = countPlayersInTeam(getTeamFromName("Yellow Dragon Mafia"))
			local guard = countPlayersInTeam(getTeamFromName("Casino Security"))
			dxDrawRelativeImage(1040,510,50,50,"team1.png",0.0,0.0,0.0,tocolor(255,255,255,255),false)
			dxDrawRelativeImage(1160,510,50,50,"team3.png",0.0,0.0,0.0,tocolor(255,255,255,255),false)
			dxDrawRelativeImage(1270,510,50,50,"team2.png",0.0,0.0,0.0,tocolor(255,255,255,255),false)
			dxDrawRelativeText(redmafia.."/4",1010,600,1156.0,274.0,tocolor(255,0,0,255),2,"default-bold","center","top",false,false,false)
			dxDrawRelativeText("Vs",1120,600,1156.0,274.0,tocolor(255,255,255,255),2,"default-bold","center","top",false,false,false)
			dxDrawRelativeText(guard.."/4",1230,600,1156.0,274.0,tocolor(0,80,200,255),2,"default-bold","center","top",false,false,false)
			dxDrawRelativeText("Vs",1370,600,1156.0,274.0,tocolor(255,255,255,255),2,"default-bold","center","top",false,false,false)
			dxDrawRelativeText(yellowmafia.."/4",1470,600,1156.0,274.0,tocolor(255,255,0,255),2,"default-bold","center","top",false,false,false)

		end
	--end
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
	if getElementData(localPlayer,"CW") then
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

addEvent("setCWrules",true)
addEventHandler("setCWrules",root,function()
	setWeaponSlotDisabled(7,true)
	setWeaponSlotDisabled(8,true)
end)

function showTextOnTop()
    local xx, yy, zz = getElementPosition(localPlayer)
	for k,v in ipairs(getElementsByType("marker",resourceRoot)) do
		if getElementData(v,"CW") then
			if getElementDimension(localPlayer) == getElementDimension(v) then
				local mXX, mYY, mZZ = getElementPosition(v)
				local rr, gg, bb = 255,255,255
				local sxx, syy = getScreenFromWorldPosition(mXX, mYY, mZZ+1)
				if (sxx) and (syy) then
					local distancee = getDistanceBetweenPoints3D(xx, yy, zz, mXX, mYY, mZZ)
					if (distancee < 30) then
						local m = getElementData(v,"CW")
						local m2 = getElementData(v,"CRW")
						if m == "Red" then
							r,g,b = 255,0,0
						elseif m == "Blue" then
							r,g,b = 0,100,200
						else
							r,g,b = 250,250,0
						end
						dxDrawText(m2, sxx+6, syy+6, sxx, syy, tocolor(0, 0, 0, 255), 2-(distancee/30),  "sans", "center", "center")
						dxDrawText(m2, sxx+2, syy+2, sxx, syy, tocolor(r,g,b, 255), 2-(distancee/30), "sans", "center", "center")
					end
				end
			end
		end
	end
end
addEventHandler("onClientRender", getRootElement(), showTextOnTop)
