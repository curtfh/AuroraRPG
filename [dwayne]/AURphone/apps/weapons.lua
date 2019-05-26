local weaponsGUI = {}
local weaponTable = { [1]=69, [2]=70, [3]=71, [4]=72, [5]=73, [6]=74, [7]=75, [8]=76, [9]=78, [10]=77, [11]=79 }

local thewepFont = "Tahoma bold"
local theFontSize = 2
theFont = "Tahoma bold"

function onResStart ()
local dxStatus = dxGetStatus()
	if tonumber(dxStatus['VideoMemoryFreeForMTA']) > 250 then
		local testFont = guiCreateFont( "tutano_cc_v2.ttf", 0.07*BGWidth )
		if testFont then
			thewepFont = testFont
		end
	end
end
addEventHandler ( "onClientResourceStart", getResourceRootElement(getThisResource()), onResStart )


local sx, sy = guiGetScreenSize()
function isCursorHover(posX,posY,sizeX,sizeY)
	if posX and posY and sizeX and sizeY then
		if isCursorShowing() then
			local x,y = getCursorPosition()
			local x,y = x*sx,y*sy
			if x>=posX and x<=posX+sizeX and y>=posY and y<=posY+sizeY then
				return true
			end
		else
			return false
		end
	else
		return false
	end
end

function onOpenWeaponsApp ( )
	apps[8][7] = true
	function drawT()

	local Pistolstats = (getPedStat(localPlayer,69))
	if Pistolstats <= 100 then
		pr,pg,pb = 255,0,0
	elseif Pistolstats > 200 and Pistolstats <= 400 then
		pr,pg,pb = 255,150,0
	elseif Pistolstats > 400 and Pistolstats <= 800 then
		pr,pg,pb = 255,255,0
	elseif Pistolstats >= 950 then
	Pistolstats = 1000
		pr,pg,pb = 0,255,0
	end
	local Silencedstats = (getPedStat(localPlayer,70))
	if Silencedstats <= 100 then
		psr,psg,psb = 255,0,0
	elseif Silencedstats > 200 and Silencedstats <= 400 then
		psr,psg,psb = 255,150,0
	elseif Silencedstats > 400 and Silencedstats <= 800 then
		psr,psg,psb = 255,255,0
	elseif Silencedstats >= 950 then
		psr,psg,psb = 0,255,0
	end
	local Deaglestats = (getPedStat(localPlayer,71))
	if Deaglestats <= 100 then
		dr,dg,db = 255,0,0
	elseif Deaglestats > 200 and Deaglestats <= 400 then
		dr,dg,db = 255,150,0
	elseif Deaglestats > 400 and Deaglestats <= 800 then
		dr,dg,db = 255,255,0
	elseif Deaglestats >= 950 then
		dr,dg,db = 0,255,0
	end
	local Shotgunstats = (getPedStat(localPlayer,72))
	if Shotgunstats <= 100 then
		shr,shg,shb = 255,0,0
	elseif Shotgunstats > 200 and Shotgunstats <= 400 then
		shr,shg,shb = 255,150,0
	elseif Shotgunstats > 400 and Shotgunstats <= 800 then
		shr,shg,shb = 255,255,0
	elseif Shotgunstats >= 950 then
		shr,shg,shb = 0,255,0
	end
	local Sawnstats = (getPedStat(localPlayer,73))
	if Sawnstats <= 100 then
		swr,swg,swb = 255,0,0
	elseif Sawnstats > 200 and Sawnstats <= 400 then
		swr,swg,swb = 255,150,0
	elseif Sawnstats > 400 and Sawnstats <= 800 then
		swr,swg,swb = 255,255,0
	elseif Sawnstats >= 950 then
		Sawnstats = 1000
		swr,swg,swb = 0,255,0
	end
	local Spasstats = (getPedStat(localPlayer,74))
	if Spasstats <= 100 then
		Spr,Spg,Spb = 255,0,0
	elseif Spasstats > 200 and Spasstats <= 400 then
		Spr,Spg,Spb = 255,150,0
	elseif Spasstats > 400 and Spasstats <= 800 then
		Spr,Spg,Spb = 255,255,0
	elseif Spasstats >= 950 then
		Spr,Spg,Spb = 0,255,0
	end
	local UZIstats = (getPedStat(localPlayer,75))
	if UZIstats <= 100 then
		UZIr,UZIg,UZIb = 255,0,0
	elseif UZIstats > 200 and UZIstats <= 400 then
		UZIr,UZIg,UZIb = 255,150,0
	elseif UZIstats > 400 and UZIstats <= 800 then
		UZIr,UZIg,UZIb = 255,255,0
	elseif UZIstats >= 950 then
	UZIstats = 1000
		UZIr,UZIg,UZIb = 0,255,0
	end
	local MP5stats = (getPedStat(localPlayer,76))
	if MP5stats <= 100 then
		MP5r,MP5g,MP5b = 255,0,0
	elseif MP5stats > 200 and MP5stats <= 400 then
		MP5r,MP5g,MP5b = 255,150,0
	elseif MP5stats > 400 and MP5stats <= 800 then
		MP5r,MP5g,MP5b = 255,255,0
	elseif MP5stats >= 950 then
		MP5r,MP5g,MP5b = 0,255,0
	end
	local M4stats = (getPedStat(localPlayer,78))
	if M4stats <= 100 then
		M4r,M4g,M4b = 255,0,0
	elseif M4stats > 200 and M4stats <= 400 then
		M4r,M4g,M4b = 255,150,0
	elseif M4stats > 400 and M4stats <= 800 then
		M4r,M4g,M4b = 255,255,0
	elseif M4stats >= 950 then
		M4r,M4g,M4b = 0,255,0
	end
	local AKstats = (getPedStat(localPlayer,77))
	if AKstats <= 100 then
		AKr,AKg,AKb = 255,0,0
	elseif AKstats > 200 and AKstats <= 400 then
		AKr,AKg,AKb = 255,150,0
	elseif AKstats > 400 and AKstats <= 800 then
		AKr,AKg,AKb = 255,255,0
	elseif AKstats >= 950 then
		AKr,AKg,AKb = 0,255,0
	end
	local Cstats = (getPedStat(localPlayer,79))
	if Cstats <= 100 then
		Cr,Cg,Cb = 255,0,0
	elseif Cstats > 200 and Cstats <= 400 then
		Cr,Cg,Cb = 255,150,0
	elseif Cstats > 400 and Cstats <= 800 then
		Cr,Cg,Cb = 255,255,0
	elseif Cstats >= 950 then
		Cr,Cg,Cb = 0,255,0
	end
	weaponsGUI[31] = dxDrawRectangle(BGX+(0.0*BGWidth),BGY+(0.02*BGHeight), 1*BGWidth, 0.060*BGHeight, tocolor(0,0,0, 100), true,true)
	weaponsGUI[32] = dxDrawRectangle(BGX+(0.0*BGWidth),BGY+(0.10*BGHeight), 1*BGWidth, 0.060*BGHeight, tocolor(0,0,0, 100), true,true)
	weaponsGUI[33] = dxDrawRectangle(BGX+(0.0*BGWidth),BGY+(0.18*BGHeight), 1*BGWidth, 0.060*BGHeight, tocolor(0,0,0, 100), true,true)
	weaponsGUI[34] = dxDrawRectangle(BGX+(0.0*BGWidth),BGY+(0.26*BGHeight), 1*BGWidth, 0.060*BGHeight, tocolor(0,0,0, 100), true,true)
	weaponsGUI[35] = dxDrawRectangle(BGX+(0.0*BGWidth),BGY+(0.34*BGHeight), 1*BGWidth, 0.060*BGHeight, tocolor(0,0,0, 100), true,true)
	weaponsGUI[36] = dxDrawRectangle(BGX+(0.0*BGWidth),BGY+(0.42*BGHeight), 1*BGWidth, 0.060*BGHeight, tocolor(0,0,0, 100), true,true)
	weaponsGUI[37] = dxDrawRectangle(BGX+(0.0*BGWidth),BGY+(0.50*BGHeight), 1*BGWidth, 0.060*BGHeight, tocolor(0,0,0, 100), true,true)
	weaponsGUI[38] = dxDrawRectangle(BGX+(0.0*BGWidth),BGY+(0.58*BGHeight), 1*BGWidth, 0.060*BGHeight, tocolor(0,0,0, 100), true,true)
	weaponsGUI[39] = dxDrawRectangle(BGX+(0.0*BGWidth),BGY+(0.66*BGHeight), 1*BGWidth, 0.060*BGHeight, tocolor(0,0,0, 100), true,true)
	weaponsGUI[40] = dxDrawRectangle(BGX+(0.0*BGWidth),BGY+(0.74*BGHeight), 1*BGWidth, 0.060*BGHeight, tocolor(0,0,0, 100), true,true)
	weaponsGUI[41] = dxDrawRectangle(BGX+(0.0*BGWidth),BGY+(0.82*BGHeight), 1*BGWidth, 0.060*BGHeight, tocolor(0,0,0, 100), true,true)

	weaponsGUI[1] = dxDrawRectangle(BGX+(0.0*BGWidth),BGY+(0.02*BGHeight), (Pistolstats/1000)*BGWidth, 0.060*BGHeight, tocolor(pr,pg,pb, 178), true,true)
	weaponsGUI[2] = dxDrawRectangle( BGX+(0.0*BGWidth),BGY+(0.10*BGHeight), (Silencedstats/1000)*BGWidth, 0.060*BGHeight, tocolor(psr,psg,psb, 178), true,true)
	weaponsGUI[3] = dxDrawRectangle( BGX+(0.0*BGWidth),BGY+(0.18*BGHeight), (Deaglestats/1000)*BGWidth, 0.060*BGHeight, tocolor(dr,dg,db, 178), true,true)
	weaponsGUI[4] = dxDrawRectangle( BGX+(0.0*BGWidth),BGY+(0.26*BGHeight), (Shotgunstats/1000)*BGWidth, 0.060*BGHeight, tocolor(shr,shg,shb, 178), true,true)
	weaponsGUI[5] = dxDrawRectangle( BGX+(0.0*BGWidth),BGY+(0.34*BGHeight), (Sawnstats/1000)*BGWidth, 0.060*BGHeight, tocolor(swr,swg,swb, 178), true,true)
	weaponsGUI[6] = dxDrawRectangle( BGX+(0.0*BGWidth),BGY+(0.42*BGHeight), (Spasstats/1000)*BGWidth, 0.060*BGHeight, tocolor(Spr,Spg,Spb, 178), true,true)
	weaponsGUI[7] = dxDrawRectangle( BGX+(0.0*BGWidth),BGY+(0.50*BGHeight), (UZIstats/1000)*BGWidth, 0.060*BGHeight, tocolor(UZIr,UZIg,UZIb, 178), true,true)
	weaponsGUI[8] = dxDrawRectangle( BGX+(0.0*BGWidth),BGY+(0.58*BGHeight), (MP5stats/1000)*BGWidth, 0.060*BGHeight, tocolor(MP5r,MP5g,MP5b, 178), true,true)
	weaponsGUI[9] = dxDrawRectangle( BGX+(0.0*BGWidth),BGY+(0.66*BGHeight), (M4stats/1000)*BGWidth, 0.060*BGHeight, tocolor(M4r,M4g,M4b, 178), true,true)
	weaponsGUI[10] = dxDrawRectangle( BGX+(0.0*BGWidth),BGY+(0.74*BGHeight), (AKstats/1000)*BGWidth, 0.060*BGHeight, tocolor(AKr,AKg,AKb, 178), true,true)
	weaponsGUI[11] = dxDrawRectangle( BGX+(0.0*BGWidth),BGY+(0.82*BGHeight), (Cstats/1000)*BGWidth, 0.060*BGHeight, tocolor(Cr,Cg,Cb, 178), true,true)
	local pistol = isCursorHover(BGX+(0.05*BGWidth),BGY+(0.02*BGHeight), 0.90*BGWidth, 0.060*BGHeight)
	local silenced = isCursorHover(BGX+(0.05*BGWidth),BGY+(0.10*BGHeight), 0.90*BGWidth, 0.060*BGHeight)
	local deagle = isCursorHover(BGX+(0.05*BGWidth),BGY+(0.18*BGHeight), 0.90*BGWidth, 0.060*BGHeight)
	local Shotgun = isCursorHover(BGX+(0.05*BGWidth),BGY+(0.26*BGHeight), 0.90*BGWidth, 0.060*BGHeight)
	local sawnoff = isCursorHover(BGX+(0.05*BGWidth),BGY+(0.34*BGHeight), 0.90*BGWidth, 0.060*BGHeight)
	local spas = isCursorHover(BGX+(0.05*BGWidth),BGY+(0.42*BGHeight), 0.90*BGWidth, 0.060*BGHeight)
	local UZI = isCursorHover(BGX+(0.05*BGWidth),BGY+(0.50*BGHeight), 0.90*BGWidth, 0.060*BGHeight)
	local MP5 = isCursorHover(BGX+(0.05*BGWidth),BGY+(0.58*BGHeight), 0.90*BGWidth, 0.060*BGHeight)
	local M4 = isCursorHover(BGX+(0.05*BGWidth),BGY+(0.66*BGHeight), 0.90*BGWidth, 0.060*BGHeight)
	local AK = isCursorHover(BGX+(0.05*BGWidth),BGY+(0.74*BGHeight), 0.90*BGWidth, 0.060*BGHeight)
	local sniper = isCursorHover(BGX+(0.05*BGWidth),BGY+(0.82*BGHeight), 0.90*BGWidth, 0.060*BGHeight)
	local note = isCursorHover(BGX+(0.05*BGWidth),BGY+(0.85*BGHeight), 0.90*BGWidth, 0.20*BGHeight)

		if pistol and weaponsGUI[12] then
			local x,y = getCursorPosition()
			local x,y = x*sx,y*sy
			dxDrawText ( "Pistol skills", x*2,y*2-40, 0.20*BGWidth, 0.060*BGHeight, tocolor ( 255, 255, 255, 255 ), theFontSize-0.3, theFont, "center", "center", false,false,true )
		elseif silenced and weaponsGUI[13] then
			local x,y = getCursorPosition()
			local x,y = x*sx,y*sy
			dxDrawText ( "Silenced skills", x*2,y*2-40, 0.20*BGWidth, 0.060*BGHeight, tocolor ( 255, 255, 255, 255 ), theFontSize-0.3, theFont, "center", "center", false,false,true )

		elseif deagle and weaponsGUI[14] then
			local x,y = getCursorPosition()
			local x,y = x*sx,y*sy
			dxDrawText ( "Deagle skills", x*2,y*2-40, 0.20*BGWidth, 0.060*BGHeight, tocolor ( 255, 255, 255, 255 ), theFontSize-0.3, theFont, "center", "center", false,false,true )

		elseif Shotgun and weaponsGUI[15] then
			local x,y = getCursorPosition()
			local x,y = x*sx,y*sy
			dxDrawText ( "Shotgun skills", x*2,y*2-40, 0.20*BGWidth, 0.060*BGHeight, tocolor ( 255, 255, 255, 255 ), theFontSize-0.3, theFont, "center", "center", false,false,true )

		elseif sawnoff and weaponsGUI[16] then
			local x,y = getCursorPosition()
			local x,y = x*sx,y*sy
			dxDrawText ( "Sawn-off skills", x*2,y*2-40, 0.20*BGWidth, 0.060*BGHeight, tocolor ( 255, 255, 255, 255 ), theFontSize-0.3, theFont, "center", "center", false,false,true )

		elseif spas and weaponsGUI[17] then
			local x,y = getCursorPosition()
			local x,y = x*sx,y*sy
			dxDrawText ( "Spas-12 skills", x*2,y*2-40, 0.20*BGWidth, 0.060*BGHeight, tocolor ( 255, 255, 255, 255 ), theFontSize-0.3, theFont, "center", "center", false,false,true )

		elseif UZI and weaponsGUI[18] then
			local x,y = getCursorPosition()
			local x,y = x*sx,y*sy
			dxDrawText ( "UZI & Tec-9 skills", x*2,y*2-40, 0.20*BGWidth, 0.060*BGHeight, tocolor ( 255, 255, 255, 255 ), theFontSize-0.3, theFont, "center", "center", false,false,true )

		elseif MP5 and weaponsGUI[19] then
			local x,y = getCursorPosition()
			local x,y = x*sx,y*sy
			dxDrawText ( "MP5 skills", x*2,y*2-40, 0.20*BGWidth, 0.060*BGHeight, tocolor ( 255, 255, 255, 255 ), theFontSize-0.3, theFont, "center", "center", false,false,true )

		elseif M4 and weaponsGUI[20] then
			local x,y = getCursorPosition()
			local x,y = x*sx,y*sy
			dxDrawText ( "M4 Rifle skills", x*2,y*2-40, 0.20*BGWidth, 0.060*BGHeight, tocolor ( 255, 255, 255, 255 ), theFontSize-0.3, theFont, "center", "center", false,false,true )

		elseif AK and weaponsGUI[21] then
			local x,y = getCursorPosition()
			local x,y = x*sx,y*sy
			dxDrawText ( "AK-47 Rifle skills", x*2,y*2-40, 0.20*BGWidth, 0.060*BGHeight, tocolor ( 255, 255, 255, 255 ), theFontSize-0.3, theFont, "center", "center", false,false,true )

		elseif sniper and weaponsGUI[22] then
			local x,y = getCursorPosition()
			local x,y = x*sx,y*sy
			dxDrawText ( "Sniper Rifle skills", x*2,y*2-40, 0.20*BGWidth, 0.060*BGHeight, tocolor ( 255, 255, 255, 255 ), theFontSize-0.3, theFont, "center", "center", false,false,true )

		elseif note and weaponsGUI[23] then
			local x,y = getCursorPosition()
			local x,y = x*sx,y*sy
			dxDrawText ( "Only Pistol,Tec-9 and Uzi are dual guns.", x*2,y*2-40, 0.20*BGWidth, 0.060*BGHeight, tocolor ( 255, 255, 255, 255 ), theFontSize-1, theFont, "center", "center", false,true,true )

		end
	end
	addEventHandler("onClientRender",root,drawT)




	weaponsGUI[12] = guiCreateLabel( BGX+(0.05*BGWidth),BGY+(0.02*BGHeight), 0.90*BGWidth, 0.060*BGHeight, "Pistol", false, nil )
	weaponsGUI[13] = guiCreateLabel( BGX+(0.05*BGWidth),BGY+(0.10*BGHeight), 0.90*BGWidth, 0.060*BGHeight, "Silenced Pistol", false, nil )
	weaponsGUI[14] = guiCreateLabel( BGX+(0.05*BGWidth),BGY+(0.18*BGHeight), 0.90*BGWidth, 0.060*BGHeight, "Desert Eagle", false, nil )
	weaponsGUI[15] = guiCreateLabel( BGX+(0.05*BGWidth),BGY+(0.26*BGHeight), 0.90*BGWidth, 0.060*BGHeight, "Shotgun", false, nil )
	weaponsGUI[16] = guiCreateLabel( BGX+(0.05*BGWidth),BGY+(0.34*BGHeight), 0.90*BGWidth, 0.060*BGHeight, "Sawn-Off Shotgun", false, nil )
	weaponsGUI[17] = guiCreateLabel( BGX+(0.05*BGWidth),BGY+(0.42*BGHeight), 0.90*BGWidth, 0.060*BGHeight, "Spas-12", false, nil )
	weaponsGUI[18] = guiCreateLabel( BGX+(0.05*BGWidth),BGY+(0.50*BGHeight), 0.90*BGWidth, 0.060*BGHeight, "Uzi / TEC-9", false, nil )
	weaponsGUI[19] = guiCreateLabel( BGX+(0.05*BGWidth),BGY+(0.58*BGHeight), 0.90*BGWidth, 0.060*BGHeight, "MP5", false, nil )
	weaponsGUI[20] = guiCreateLabel( BGX+(0.05*BGWidth),BGY+(0.66*BGHeight), 0.90*BGWidth, 0.060*BGHeight, "M4", false, nil )
	weaponsGUI[21] = guiCreateLabel( BGX+(0.05*BGWidth),BGY+(0.74*BGHeight), 0.90*BGWidth, 0.060*BGHeight, "AK-47", false, nil )
	weaponsGUI[22] = guiCreateLabel( BGX+(0.05*BGWidth),BGY+(0.82*BGHeight), 0.90*BGWidth, 0.060*BGHeight, "Country Rifle / Sniper", false, nil )
	weaponsGUI[23] = guiCreateLabel( BGX+(0.05*BGWidth),BGY+(0.85*BGHeight), 0.90*BGWidth, 0.20*BGHeight, "", false, nil )

	for i=12,23 do
		guiSetProperty( weaponsGUI[i], "AlwaysOnTop", "True" )
		guiSetVisible( weaponsGUI[i],true )
		guiBringToFront( weaponsGUI[i] )
		guiLabelSetColor ( weaponsGUI[i], 255, 255, 255 )
		guiLabelSetHorizontalAlign ( weaponsGUI[i], "center" )
		guiLabelSetVerticalAlign ( weaponsGUI[i], "center" )
		guiSetFont ( weaponsGUI[i], thewepFont )
	end
end
apps[8][8] = onOpenWeaponsApp


function onCloseWeaponsApp ()
	for i=12,23 do
		guiSetProperty( weaponsGUI[i], "AlwaysOnTop", "True" )
		guiSetVisible(weaponsGUI[i],false)
	end
	removeEventHandler("onClientRender",root,drawT)
	apps[8][7] = false
end

apps[8][9] = onCloseWeaponsApp
