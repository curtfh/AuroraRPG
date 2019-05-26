local sX, sY = guiGetScreenSize()
local nX, nY = 1366, 768
local disabledHUD = { "health", "armour", "breath", "clock", "money", "weapon", "ammo", "area_name","wanted" }
hudEnabled = false
local fps = 30
local ping = 500
local aps = 0
for i, v in pairs( disabledHUD ) do
	showPlayerHudComponent( v, true )
end

local hudswitch = function (hudstate)
	if hudstate then
		for i, v in pairs( disabledHUD ) do
			showPlayerHudComponent( v, false )
		end
		hudEnabled = true
	else
		for i, v in pairs( disabledHUD ) do
			showPlayerHudComponent( v, true )
		end
		hudEnabled = false
	end
end


addEvent( "onPlayerSettingChange", true )
addEventHandler( "onPlayerSettingChange", localPlayer,
	function ( setting, hudstate )
		if setting == "hud" then
			hudswitch( hudstate )
		end
	end
)

function checkSettinghud()
	if ( getResourceRootElement( getResourceFromName( "DENsettings" ) ) ) then
		local setting = exports.DENsettings:getPlayerSetting( "hud" )
		if getElementDimension(localPlayer) ~= 1001 then
			showPlayerHudComponent( "radar", true )
			hudswitch( setting )
		else
			showPlayerHudComponent( "radar", false )
			hudswitch( false )
		end
	else
		setTimer( checkSettinghud, 5000, 1 )
	end
end
addEventHandler( "onClientResourceStart", resourceRoot, checkSettinghud )
setTimer( checkSettinghud, 5000, 0 )


local root = getRootElement()
local player = localPlayer
--local ping = getPlayerPing(player)
local xo = 0
local counter = 0
local starttick
local currenttick
local toggle = false
--FPS Counter, this runs in the background even if its enabled / disabled.
addEventHandler("onClientRender",root,
	function ()
		if not starttick then
			starttick = getTickCount()
		end
		counter = counter + 1
		currenttick = getTickCount()
		if currenttick - starttick >= 1000 then
			local xo = counter - 1
			if xo > 60 then
				xo = 60
			end
			setElementData(player, "FPS", xo)
			xo = 0
			counter = 0
			starttick = false
		end
	end
)

setTimer(
	function ()
		fps = getElementData( localPlayer, "FPS" )
		if (getElementData(localPlayer, "serverlocation") == "SEA") then 
			ping = getPlayerPing( localPlayer ) - 181
		else 
			ping = getPlayerPing( localPlayer )
		end 
	end, 100, 0
)

-- We should move these functions to somewhere we can call them from. NGCutil would be a good resource name to store export functions like these.
function tocomma( number )
	while true do
		number, k = string.gsub( number, "^(-?%d+)(%d%d%d)", '%1,%2' )
		if ( k == 0 ) then
			break
		end
	end
	return number
end

function math.round( number, decimals, method )
    decimals = decimals or 0
    local factor = 10 ^ decimals
    if ( method == "ceil" or method == "floor" ) then return math[method]( number * factor ) / factor
    else return tonumber( ( "%."..decimals.."f" ):format( number ) ) end
end


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

function dxDrawRelativeText2( text,posX,posY,right,bottom,color,scale,mixed_font,alignX,alignY,clip,wordBreak,postGUI )
    local resolutionX = 1366
    local resolutionY = 768
    local sWidth,sHeight = guiGetScreenSize( )
    return dxDraw(
        tostring( text ),
        ( posX/resolutionX )*sWidth,
        ( posY/resolutionY )*sHeight,
        ( right/resolutionX )*sWidth,
        ( bottom/resolutionY)*sHeight,
        color,scale, --( sWidth/resolutionX )*scale,
        mixed_font,
        alignX,
        alignY,
        clip,
        wordBreak,
        postGUI
    )
end

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
        color,scale, --( sWidth/resolutionX )*scale,
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




function renderHealth()
	if isPlayerMapVisible() then return end
	if exports.server:isPlayerLoggedIn(localPlayer) then
		if (getElementData(localPlayer, "serverlocation") == "SEA") then 
			if (getTeamName(getPlayerTeam(localPlayer)) == "Staff") then 
				if (isPlayerNametagShowing(localPlayer) == false) then
					dxDrawRelativeText2("  FPS: "..fps.. "  Ping: "..ping.."  STAFF MODE  INVISIBE MODE",800,5,1500,60,tocolor( 255, 255, 0, 255 ), 1.0, "default-bold", "center", "top")
					else
					dxDrawRelativeText2("  FPS: "..fps.. "  Ping: "..ping.."  STAFF MODE",800,5,1500,60,tocolor( 255, 0, 0, 255 ), 1.0, "default-bold", "center", "top")
				end
			else
				dxDrawRelativeText2("  FPS: "..fps.. "  Ping: "..ping.."  Server Location: South East Asia",800,5,1500,60,tocolor( 255, 255, 255, 255 ), 1.0, "default-bold", "center", "top")
			end 
		else 
			if (getTeamName(getPlayerTeam(localPlayer)) == "Staff") then 
				if (isPlayerNametagShowing(localPlayer) == false) then
					dxDrawRelativeText2("  FPS: "..fps.. "  Ping: "..ping.."  STAFF MODE  INVISIBE MODE",800,5,1500,60,tocolor( 255, 255, 0, 255 ), 1.0, "default-bold", "center", "top")
					else
					dxDrawRelativeText2("  FPS: "..fps.. "  Ping: "..ping.."  STAFF MODE",800,5,1500,60,tocolor( 255, 0, 0, 255 ), 1.0, "default-bold", "center", "top")
				end
			else 
				dxDrawRelativeText2("  FPS: "..fps.. "  Ping: "..ping.."  Server Location: Europe",800,5,1500,60,tocolor( 255, 255, 255, 255 ), 1.0, "default-bold", "center", "top")
			end 
		end 
	end
end
addEventHandler( "onClientRender", root, renderHealth )


local sX,sY = guiGetScreenSize()

local SAFEZONE_X = sX*0.05
local SAFEZONE_Y = sY*0.05

local disabledHUD = {"health", "armour", "breath", "clock", "money", "weapon", "ammo", "vehicle_name", "area_name", "wanted"}
	-- Replaced HUD Components

local game_time	= ""	-- Game Date and Time
local date_ = ""		-- Client Date and Time
local uptime = getRealTime().timestamp
	-- Client Uptime

local healthTimer = setTimer(function() end, 1000, 0)
	-- Timer that makes health flash


function tocomma(number)
	while true do
		number, k = string.gsub(number, "^(-?%d+)(%d%d%d)", '%1,%2')
		if (k==0) then
			break
		end
	end
	return number
end

-- Toggle HUD
-------------->>

function toggleCustomHUD()
	if (not hudEnabled) then
		for i,hud in ipairs(disabledHUD) do
			showPlayerHudComponent(hud, false)
		end
		hudEnabled = true
	else
		for i,hud in ipairs(disabledHUD) do
			showPlayerHudComponent(hud, true)
		end
		hudEnabled = nil
	end
end
--[[addCommandHandler("hud", toggleCustomHUD)

addEventHandler("onClientResourceStart", resourceRoot, function()
	for i,hud in ipairs(disabledHUD) do
		showPlayerHudComponent(hud, false)
	end
	hudEnabled = true
end)]]

-- HUD Exports
--------------->>

local enabledHud = {"radar", "radio", "crosshair"}
function showHud()
	if (isCustomHudEnabled()) then
		showPlayerHudComponent("all", false)
		for i,hud in ipairs(enabledHud) do
			showPlayerHudComponent(hud, true)
		end
	else
		showPlayerHudComponent("all", true)
	end
end

function isCustomHudEnabled()
	return hudEnabled or false
end

-- Health
---------->>

function renderHealth()
	if getElementDimension(localPlayer) == 1001 then return false end
	if (not isPlayerHudComponentVisible("radar") or isPlayerMapVisible() or not hudEnabled) then return end

	local health = getElementHealth(localPlayer)
	local maxHealth = getPedStat(localPlayer, 24)
	local maxHealth = (((maxHealth-569)/(1000-569))*100)+100
	local healthStat = health/maxHealth

	local r1,g1,b1, r2,g2,b2, a
	if (healthStat > 0.25) then
		r1,g1,b1 = 85,125,85
		r2,g2,b2 = 25,60,37
		a = 200
	else
		r1,g1,b1 = 200,100,105
		r2,g2,b2 = 80,40,40
		local aT = getTimerDetails(healthTimer)
		if (aT > 500) then
			a = (aT-500)/500*200
		else
			a = (500-aT)/500*200
		end
	end

	local dX,dY,dW,dH = sX-150,0,150,15
	local dX,dY,dW,dH = sX-150-SAFEZONE_X, dY+SAFEZONE_Y, dW, dH
	dxDrawRectangle( dX,dY,dW,dH, tocolor(0,0,0,200) )
	local dX,dY,dW,dH = sX-147,3,144,9
	local dX,dY,dW,dH = sX-147-SAFEZONE_X, dY+SAFEZONE_Y, dW, dH
	dxDrawRectangle( dX,dY,dW,dH, tocolor(r2,g2,b2,200) )
	dxDrawRectangle( dX+dW-(healthStat*dW),dY,healthStat*dW,dH, tocolor(r1,g1,b1,a) )
end
addEventHandler("onClientRender", root, renderHealth)

-- Armor
--------->>

function renderArmor()
	if getElementDimension(localPlayer) == 1001 then return false end
	if (not isPlayerHudComponentVisible("radar") or isPlayerMapVisible() or not hudEnabled) then return end

	local armor = getPedArmor(localPlayer)
	local oxygen = getPedOxygenLevel(localPlayer)
	if (oxygen < 1000) then return end
	local armorStat = armor/100

	local dX,dY,dW,dH = sX-222,0,72,15
	local dX,dY,dW,dH = sX-222-SAFEZONE_X, dY+SAFEZONE_Y, dW, dH
	dxDrawRectangle( dX,dY,dW,dH, tocolor(0,0,0,200) )
	local dX,dY,dW,dH = sX-219,3,69,9
	local dX,dY,dW,dH = sX-219-SAFEZONE_X, dY+SAFEZONE_Y, dW, dH
	dxDrawRectangle( dX,dY,dW,dH, tocolor(20,60,80,200) )
	dxDrawRectangle( dX+dW-(armorStat*dW),dY,armorStat*dW,dH, tocolor(90,165,200,200) )
end
addEventHandler("onClientRender", root, renderArmor)

-- Oxygen
---------->>

function renderOxygenLevel()
	if (not isPlayerHudComponentVisible("radar") or isPlayerMapVisible() or not hudEnabled) then return end

	local oxygen = getPedOxygenLevel(localPlayer)
	if (oxygen >= 1000) then return end
	local oxygenStat = oxygen/1000

	local dX,dY,dW,dH = sX-222,0,72,15
	local dX,dY,dW,dH = sX-222-SAFEZONE_X, dY+SAFEZONE_Y, dW, dH
	dxDrawRectangle( dX,dY,dW,dH, tocolor(0,0,0,200) )
	local dX,dY,dW,dH = sX-219,3,69,9
	local dX,dY,dW,dH = sX-219-SAFEZONE_X, dY+SAFEZONE_Y, dW, dH
	dxDrawRectangle( dX,dY,dW,dH, tocolor(58,100,128,200) )
	dxDrawRectangle( dX+dW-(oxygenStat*dW),dY,oxygenStat*dW,dH, tocolor(145,205,240,200) )
end
addEventHandler("onClientRender", root, renderOxygenLevel)

-- Game Time
------------->>

function updateGameTime()
	local hrs,mins = getTime()
	local ampm = "am"
	if (hrs >= 12) then ampm = "pm" end
	if (hrs == 0) then hrs = 12 end
	if (hrs > 12) then hrs = hrs - 12 end
	if (hrs < 10) then hrs = "0"..hrs end
	if (mins < 10) then mins = "0"..mins end

	game_time = hrs..":"..mins.." "..ampm
end
setTimer(updateGameTime, 1000, 0)

function renderGameTime()
	if getElementDimension(localPlayer) == 1001 then return false end
	if (not isPlayerHudComponentVisible("radar") or isPlayerMapVisible() or not hudEnabled) then return end

	local dX,dY,dW,dH = sX-222,20,sX-222+75,20
	local dX,dY,dW,dH = dX-SAFEZONE_X, dY+SAFEZONE_Y, dW-SAFEZONE_X, dH+SAFEZONE_Y
	dxDrawText(game_time, dX+1,dY,dW+1,dH, tocolor(0,0,0,100), 1, "clear", "center")
	dxDrawText(game_time, dX,dY+1,dW,dH+1, tocolor(0,0,0,100), 1, "clear", "center")
	dxDrawText(game_time, dX,dY,dW,dH, tocolor(255,255,255,255), 1, "clear", "center")
end
addEventHandler("onClientRender", root, renderGameTime)

-- Wanted Level
---------------->>

local wantedOff = 0
function renderWantedLevel()
	if getElementDimension(localPlayer) == 1001 then return false end
	if (not isPlayerHudComponentVisible("radar") or isPlayerMapVisible() or not hudEnabled) then return end
	local wanted = getPlayerWantedLevel()
	if (wanted == 0) then wantedOff = 0 return end
	wantedOff = 35

	local DIST_BTWN_STARS = 216/6
	local dX,dY,dW,dH = sX-33,37,30,29
	local dX,dY,dW,dH = dX-SAFEZONE_X, dY+SAFEZONE_Y, dW, dH

	local total_stars = 0
	local active_stars = 0
	for i=1,wanted do
		dxDrawImage(dX-(total_stars*DIST_BTWN_STARS), dY, dW, dH, "wanted/wanted_active.png")
		total_stars = total_stars + 1
		active_stars = active_stars + 1
	end
	for i=1,6-active_stars do
		dxDrawImage(dX-(total_stars*DIST_BTWN_STARS), dY, dW, dH, "wanted/wanted_inactive.png")
		total_stars = total_stars + 1
	end
end
addEventHandler("onClientRender", root, renderWantedLevel)

-- Money
--------->>

local moneyY = 0
local value = false
local timer = {}

function updateAPSmsg() 
	if (value == true) then
		value = false
		aps = "/premium"
	else
		value = true
		aps = getElementData(localPlayer, "auroraPoints") or 0
		aps = tocomma(aps)
	end
end
timer[localPlayer] = setTimer(updateAPSmsg, 1000, 14)

function renderMoney()
	if getElementDimension(localPlayer) == 1001 then return false end
	if (not isPlayerHudComponentVisible("radar") or isPlayerMapVisible() or not hudEnabled) then return end

	local cash = getPlayerMoney()
	cash = tocomma(cash)
	
	
	
	if (not isTimer(timer[localPlayer])) then
		aps = getElementData(localPlayer, "auroraPoints") or 0
		aps = tocomma(aps)
	end
	
	local dX,dY,dW,dH = sX-6,35+moneyY+wantedOff,sX-6,30
	local dX,dY,dW,dH = dX-SAFEZONE_X, dY+SAFEZONE_Y, dW-SAFEZONE_X, dH+SAFEZONE_Y
	local dX2, dY2, dW2, dH2 = dX, dY+45, dW, dH
	dxDrawText("$"..cash, dX+2,dY,dW+2,dH, tocolor(0,0,0,255), 1.35, "pricedown", "right")
	dxDrawText("$"..cash, dX,dY+2,dW,dH+2, tocolor(0,0,0,255), 1.35, "pricedown", "right")
	dxDrawText("$"..cash, dX-2,dY,dW-2,dH, tocolor(0,0,0,255), 1.35, "pricedown", "right")
	dxDrawText("$"..cash, dX,dY-2,dW,dH-2, tocolor(0,0,0,255), 1.35, "pricedown", "right")
	dxDrawText("$"..cash, dX,dY,dW,dH, tocolor(220,220,220,255), 1.35, "pricedown", "right")
	dxDrawText("APS: "..aps, dX2+2,dY2,dW2+2,dH2, tocolor(0,0,0,255), 0.8, "bankgothic", "right")
	dxDrawText("APS: "..aps, dX2,dY2+2,dW2,dH2+2, tocolor(0,0,0,255), 0.8, "bankgothic", "right")
	dxDrawText("APS: "..aps, dX2-2,dY2,dW2-2,dH2, tocolor(0,0,0,255), 0.8, "bankgothic", "right")
	dxDrawText("APS: "..aps, dX2,dY2-2,dW2,dH2-2, tocolor(0,0,0,255), 0.8, "bankgothic", "right")
	dxDrawText("APS: "..aps, dX2,dY2,dW2,dH2, tocolor(0,220,220,255), 0.8, "bankgothic", "right")
end
addEventHandler("onClientRender", root, renderMoney)

-- Show +/- Money
------------------>>

local cashAmt = 0
local r,g,b = 0,0,0
local pmTimer
local pm = ""
function showPlusMoney(amount)
	cashAmt = cashAmt + amount
	mr,mg,mb = 110,150,125
	pm = "+"
	if (isTimer(pmTimer)) then killTimer(pmTimer) pmTimer = nil end
	pmTimer = setTimer(function() cashAmt = 0 pmTimer = nil end, 5000, 1)
end
addEvent("onClientPlayerGiveMoney", true)
addEventHandler("onClientPlayerGiveMoney", localPlayer, showPlusMoney)

function showMinusMoney(amount)
	cashAmt = cashAmt + amount
	mr,mg,mb = 180,80,90
	pm = "-"
	if (isTimer(pmTimer)) then killTimer(pmTimer) pmTimer = nil end
	pmTimer = setTimer(function() cashAmt = 0 pmTimer = nil end, 5000, 1)
end
addEvent("onClientPlayerTakeMoney", true)
addEventHandler("onClientPlayerTakeMoney", localPlayer, showMinusMoney)

local monA = 0
function renderPlusMinusMoney()
	if getElementDimension(localPlayer) == 1001 then return false end
	if (not isPlayerHudComponentVisible("radar") or isPlayerMapVisible() or not hudEnabled) then return end

	if (cashAmt == 0 or not pmTimer) then return end
	local cash = tocomma(cashAmt)

	local timeLeft = getTimerDetails(pmTimer)
	if (timeLeft > 4750) then
		monA = ((5000-timeLeft)/250) * 255
	elseif (timeLeft < 250) then
		monA = (timeLeft/250) * 255
	end

	local dX,dY,dW,dH = sX-6,70+moneyY+wantedOff,sX-6,30
	local dX,dY,dW,dH = dX-SAFEZONE_X, dY+SAFEZONE_Y, dW-SAFEZONE_X, dH+SAFEZONE_Y
	dxDrawText(pm.."$"..cash, dX+2,dY,dW+2,dH, tocolor(0,0,0,monA), 1.25, "pricedown", "right")
	dxDrawText(pm.."$"..cash, dX,dY+2,dW,dH+2, tocolor(0,0,0,monA), 1.25, "pricedown", "right")
	dxDrawText(pm.."$"..cash, dX-2,dY,dW-2,dH, tocolor(0,0,0,monA), 1.25, "pricedown", "right")
	dxDrawText(pm.."$"..cash, dX,dY-2,dW,dH-2, tocolor(0,0,0,monA), 1.25, "pricedown", "right")
	dxDrawText(pm.."$"..cash, dX,dY,dW,dH, tocolor(mr,mg,mb,monA), 1.25, "pricedown", "right")
end
addEventHandler("onClientRender", root, renderPlusMinusMoney)

-- Weapons
----------->>

function renderWeapons()
	if getElementDimension(localPlayer) == 1001 then return false end
	if (not isPlayerHudComponentVisible("radar") or isPlayerMapVisible() or not hudEnabled) then return end

	local weapon = getPedWeapon(localPlayer)
	local clip = getPedAmmoInClip(localPlayer)
	local ammo = getPedTotalAmmo(localPlayer)
	if (weapon == 0 or weapon == 1 or ammo == 0) then moneyY = 0 return end
	moneyY = 35

	local len = #tostring(clip)
	if string.find(tostring(clip), 1) then len = len - 0.5 end
	local xoff = (len*17) + 10

	local len2 = #tostring(ammo-clip)
	if string.find(tostring(ammo-clip), 1) then len2 = len2 - 0.5 end
	local weapLen = ((len+len2)*17) + 20

	if (weapon >= 15 and weapon ~= 40 and weapon <= 44 or weapon >= 46) then
			-- Ammo in Clip
		local dX,dY,dW,dH = sX-6,35+wantedOff,sX-6,30
		local dX,dY,dW,dH = dX-SAFEZONE_X, dY+SAFEZONE_Y, dW-SAFEZONE_X, dH+SAFEZONE_Y
		dxDrawText(clip, dX+2,dY,dW+2,dH, tocolor(0,0,0,255), 1.25, "pricedown", "right")
		dxDrawText(clip, dX,dY+2,dW,dH+2, tocolor(0,0,0,255), 1.25, "pricedown", "right")
		dxDrawText(clip, dX-2,dY,dW-2,dH, tocolor(0,0,0,255), 1.25, "pricedown", "right")
		dxDrawText(clip, dX,dY-2,dW,dH-2, tocolor(0,0,0,255), 1.25, "pricedown", "right")
		dxDrawText(clip, dX,dY,dW,dH, tocolor(110,110,110,255), 1.25, "pricedown", "right")
			-- Total Ammo
		local dX,dY,dW,dH = sX-6-xoff,35+wantedOff,sX-6-xoff,30
		local dX,dY,dW,dH = dX-SAFEZONE_X, dY+SAFEZONE_Y, dW-SAFEZONE_X, dH+SAFEZONE_Y
		dxDrawText(ammo-clip, dX+2-xoff,dY,dW+2,dH, tocolor(0,0,0,255), 1.25, "pricedown", "right")
		dxDrawText(ammo-clip, dX,dY+2,dW,dH+2, tocolor(0,0,0,255), 1.25, "pricedown", "right")
		dxDrawText(ammo-clip, dX-2,dY,dW-2,dH, tocolor(0,0,0,255), 1.25, "pricedown", "right")
		dxDrawText(ammo-clip, dX,dY-2,dW,dH-2, tocolor(0,0,0,255), 1.25, "pricedown", "right")
		dxDrawText(ammo-clip, dX,dY,dW,dH, tocolor(220,220,220,255), 1.25, "pricedown", "right")
	else
		xoff = 0
		weapLen = 0
	end
	--[[
	local weapName = getWeaponNameFromID(weapon)
	local dX,dY,dW,dH = sX-6,110,sX-6,125
	local dX,dY,dW,dH = dX-SAFEZONE_X, dY+SAFEZONE_Y, dW-SAFEZONE_X, dH+SAFEZONE_Y
	dxDrawText(weapName, dX+1,dY,dW+1,dH, tocolor(0,0,0,100), 1, "clear", "right")
	dxDrawText(weapName, dX,dY+1,dW,dH+1, tocolor(0,0,0,100), 1, "clear", "right")
	dxDrawText(weapName, dX,dY,dW,dH, tocolor(255,255,255,255), 1, "clear", "right")
	--]]
	if (weapon == 0 or weapon == 1) then return end
	local img = "weaps/"..weapon..".png"
	local dX,dY,dW,dH = sX-133-weapLen,35+wantedOff,128,40
	local dX,dY,dW,dH = dX-SAFEZONE_X, dY+SAFEZONE_Y, dW, dH
	dxDrawImage(dX, dY, dW, dH, img)
end
addEventHandler("onClientRender", root, renderWeapons)

-- Your Date and Time
---------------------->>

local monthTable = {"January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"}
function getMonthName(month, digits)
	if (not monthTable[month]) then return end
	local month = monthTable[month]
	if (digits) then
		month = string.sub(month, 1, digits)
	end
	return month
end


function totime(timestamp)
	local timestamp = timestamp - (math.floor(timestamp/86400) * 86400)
	local hours = math.floor(timestamp/3600)
	timestamp = timestamp - (math.floor(timestamp/3600) * 3600)
	local mins = math.floor(timestamp/60)
	local secs = timestamp - (math.floor(timestamp/60) * 60)
	return hours, mins, secs
end


function updateDateAndTime()
	local t = getRealTime()
	local day = t.monthday
	if (day < 10) then day = "0"..day end
	local hr = t.hour
	if (hr < 10) then hr = "0"..hr end
	local mins = t.minute
	if (mins < 10) then mins = "0"..mins end
	local sec = t.second
	if (sec < 10) then sec = "0"..sec end

	local uptime_ = t.timestamp - uptime
	local hrs_, mins_, secs_ = totime(uptime_)
	if (hrs_ < 10) then hrs_ = "0"..hrs_ end
	if (mins_ < 10) then mins_ = "0"..mins_ end
	if (secs_ < 10) then secs_ = "0"..secs_ end
	date_ = day.." "..getMonthName(t.month+1).." "..(t.year+1900).." — "..hr..":"..mins..":"..sec.." (Online: "..hrs_..":"..mins_..":"..secs_..") - AuroraRPG V2 - aurorarpg.com"
end
setTimer(updateDateAndTime, 1000, 0)

function renderDateAndTime()
	local dX,dY,dW,dH = sX-5,sY-15,sX-5,sY-15
	dxDrawText(date_, dX,dY,dW,dH, tocolor(255,255,255,100), 1, "default", "right", "bottom")
end
addEventHandler("onClientRender", root, renderDateAndTime)
