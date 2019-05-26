
local screenWidth, screenHeight = guiGetScreenSize()
local mygun = nil
local rx, ry = guiGetScreenSize()
local nX, nY = 1366, 768
local sX, sY = guiGetScreenSize()
local count = 3
local count2 = 3
local trigger = false
local canFireRockets = false
local startProtect = false

hop = nil
function startCountdown(interval)
	if countdownImage and isElement(countdownImage) then destroyElement(countdownImage) end
	if isTimer(hop) then killTimer(hop) end
    countdownImage = guiCreateStaticImage((rx/2)-125, (ry/2)-80, 250, 190, "images/3.png", false)
	if not interval then interval = 2000 end
    hop = setTimer(decrementCountdown, interval, 4)
    countdownCount = 3
	startProtect = true
end

function decrementCountdown()
	countdownCount = countdownCount - 1
	if (countdownCount > 0) then
		guiStaticImageLoadImage (countdownImage, "images/"..countdownCount..".png")
	elseif (countdownCount == 0) then
		destroyElement(countdownImage)
		countdownImage = guiCreateStaticImage((rx/2)-160, (ry/2)-80, 320, 190, "images/go.png", false)
	else
		destroyElement(countdownImage)
	end
end

theKiller = {}
dmg = {}
active = false
suckers = {}
targ = false




addEvent("CSGOclient.prepareRound", true)
function prepareRound()
    -- init countdown
	startProtect = true
    startCountdown(2000)
	-- spawn protection

end
addEventHandler("CSGOclient.prepareRound", root, prepareRound)

addEvent("AddCSGOClientCamera",true)
addEventHandler("AddCSGOClientCamera",root,function(playing)
	active = true
	suckers = playing
end)
addEvent("setCSGOClientCamera",true)
addEventHandler("setCSGOClientCamera",root,function()
	active = false
end)



addEventHandler("onClientRender", getRootElement(),function()
	if getElementDimension(localPlayer) == 5003 then
		if active == true then
			dxDrawText("Please wait...\nGame in progress", 0, 0, screenWidth, screenHeight-250, tocolor(255,255,255),2,"default-bold","center","center")
		end
	end
end)

addEvent("CSGOclient.gameStopSpawnProtection", true)
function stopSpawnProtection()
    startProtect = false
end
addEventHandler("CSGOclient.gameStopSpawnProtection", root, stopSpawnProtection)

function gameTick()

end

local roundWinner = false

addEvent("CSGOclient.roundWon", true)
function onRoundWon()
    if(getElementDimension(localPlayer) ~= 5003) then return false end
    roundWinner = source
    addEventHandler("onClientRender", root, renderWinner)
end
addEventHandler("CSGOclient.roundWon", root, onRoundWon)

addEvent("CSGOclient.roundEnd", true)
addEvent("onPlayerExitRoom", true)
function onRoundEnd()
    if(roundWinner) then
        removeEventHandler("onClientRender", root, renderWinner)
    end
    roundWinner = false
end
addEventHandler("CSGOclient.roundEnd", root, onRoundEnd)
addEventHandler("onPlayerExitRoom", localPlayer, onRoundEnd)


function renderWinner()
	if getElementDimension(localPlayer) == 5003 then
		if(isElement(roundWinner)) then
			local name = getElementData(roundWinner,"Team")
			if name == "Terrorist" then
				r,g,b = 255,0,0
			else
				r,g,b = 0,100,250
			end
			dxDrawText(name.."\nWin", 0, 0, screenWidth, screenHeight, r,g,b,4,"default-bold","center","center")
		end
    end
end

function findPointFromDistanceRotation(x,y, angle, dist)
    local angle = math.rad(angle+90)
    return x+(dist * math.cos(angle)), y+(dist * math.sin(angle))
end


addEvent("CSGOclient.playerWasted", true)
function onPlayerWasted(rank, timex, nick,byw)
	if byw == "" or byw == nil then
		outputChatBox("[ "..rank.." ] "..nick.." | "..timex,0,255,0)
	else
		outputChatBox("[ "..rank.." ] "..byw.." has killed "..nick.." | "..timex,0,255,0)
	end
end
addEventHandler("CSGOclient.playerWasted", root, onPlayerWasted)

addEvent("CSGOclient.freezeCamera", true)
function freezeCamera()
    local x,y,z,lx,ly,lz,roll,fov = getCameraMatrix()
    setCameraMatrix(x,y,z+50,lx,ly,lz,roll,fov)
end
addEventHandler("CSGOclient.freezeCamera", localPlayer, freezeCamera)




addEvent("loadCSGOMap",true)
addEventHandler("loadCSGOMap",root,function(temp)
	if temp then
		if unloadMap() then
			for k,v in ipairs(temp) do
				local obj = createObject(v[1],v[2],v[3],v[4],v[5],v[6],v[7])
				setElementDimension(obj, 5003)
				setElementInterior(obj,50)

				--if exports.server:getPlayerAccountName(localPlayer) == "iphone7" then

				--else
					engineSetModelLODDistance ( v[1], 2000 )
				--end
			end
		end
	else
		outputChatBox("invalid map")
	end
end)


function unloadMap()
	for k, v in ipairs(getElementsByType("object",resourceRoot)) do
		if v and isElement(v) then
			if getElementDimension(v) == 5003 then
				destroyElement(v)
			end
		end
	end
	return true
end



LawSkins = {
	{"c1",170},
	{"c2",171},
	{"t1",174},
	{"t2",175},
}

local mods = {}
local txdFile = {}
local dffFile = {}

---- 3437,
function onThisResourceStart ( )
	for k,v in ipairs(LawSkins) do
		downloadFile ( "skins/"..v[1]..".dff" )
	end
	local txd = engineLoadTXD("maps/train.txd")
	engineImportTXD(txd, 3906)
	local col = engineLoadCOL("maps/train.col")
	local dff = engineLoadDFF("maps/train.dff")
	engineReplaceCOL(col, 3906)
	engineReplaceModel(dff, 3906)
	engineSetModelLODDistance(3906, 2000)

	local txd = engineLoadTXD("maps/assault.txd")
	engineImportTXD(txd, 3905)
	local col = engineLoadCOL("maps/assault.col")
	local dff = engineLoadDFF("maps/assault.dff")
	engineReplaceCOL(col, 3905)
	engineReplaceModel(dff, 3905)
	engineSetModelLODDistance(3905, 2000)

	local txd = engineLoadTXD("maps/dust2.txd")
	engineImportTXD(txd, 3899)
	local col = engineLoadCOL("maps/dust2.col")
	local dff = engineLoadDFF("maps/dust2.dff")
	engineReplaceCOL(col, 3899)
	engineReplaceModel(dff, 3899)
	engineSetModelLODDistance(3899, 2000)

	local txd = engineLoadTXD("maps/cbble.txd")
	engineImportTXD(txd, 3907)
	local col = engineLoadCOL("maps/cbble.col")
	local dff = engineLoadDFF("maps/cbble.dff")
	engineReplaceCOL(col, 3907)
	engineReplaceModel(dff, 3907)
	engineSetModelLODDistance(3907, 2000)

	local txd = engineLoadTXD("maps/aztec.txd")
	engineImportTXD(txd, 3908)
	local col = engineLoadCOL("maps/aztec.col")
	local dff = engineLoadDFF("maps/aztec.dff")
	engineReplaceCOL(col, 3908)
	engineReplaceModel(dff, 3908)
	engineSetModelLODDistance(3908, 2000)
end
addEventHandler ( "onClientResourceStart", resourceRoot, onThisResourceStart )

function onDownloadFinish ( file, success )
    if ( source == resourceRoot ) then                            -- if the file relates to this resource
        if ( success ) then
			for k,v in ipairs(LawSkins) do
				if file == "skins/"..v[1]..".dff" then
					if fileExists(":AURgamesCSGO/skins/"..v[1]..".dff") then
						loadMyMods(v[1],":AURgamesCSGO/skins/"..v[1]..".dff",":AURgamesCSGO/skins/"..v[1]..".txd",v[2],v[1])
					end
				elseif file == "skins/"..v[1]..".txd" then
					if fileExists(":AURgamesCSGO/skins/"..v[1]..".dff") and fileExists(":AURgamesCSGO/skins/"..v[1]..".txd") then
						loadSkins(v[1],v[2])
					end
				end
            end
        end
    end
end
addEventHandler ( "onClientFileDownloadComplete", getRootElement(), onDownloadFinish )

function loadMyMods(name,dff,txd,id,wh)
	downloadFile ( "skins/"..name..".txd" )
end

function loadSkins(name,id)
	mods[name] = {
		{name,id}
	}
	replaceMods(name)
end

function replaceMods(name)
	for k,v in ipairs(mods[name]) do
		if fileExists(":AURgamesCSGO/skins/"..v[1]..".txd") then
			txd = engineLoadTXD(":AURgamesCSGO/skins/"..v[1]..".txd")
			if txd and txd ~= false then
				engineImportTXD(txd,v[2])
			end
		end
		if fileExists(":AURgamesCSGO/skins/"..v[1]..".dff") and fileExists(":AURgamesCSGO/skins/"..v[1]..".txd") then
			if fileExists(":AURgamesCSGO/skins/"..v[1]..".dff") then
				dff = engineLoadDFF(":AURgamesCSGO/skins/"..v[1]..".dff",v[2])
				if txd and txd ~= false then
					if dff and dff ~= false then
						if v[2] then
							engineReplaceModel(dff,v[2])
							--outputDebugString(v[1].." model has been loaded")
						end
					end
				end
			end
		end
	end
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

local disabledHUD = { "health", "armour", "radar", "breath", "clock", "money", "weapon", "ammo", "area_name" }


yesTimer = {}
function addYesTimer()
	if getElementDimension(localPlayer) == 5003 then
		for i, v in pairs( disabledHUD ) do
			showPlayerHudComponent( v, false )
		end
	else
		checkSettinghud()
	end
end


function checkSettinghud()
	if ( getResourceRootElement( getResourceFromName( "DENsettings" ) ) ) then
		local setting = exports.DENsettings:getPlayerSetting( "hud" )
		if setting == false then
			for i, v in pairs( disabledHUD ) do
				showPlayerHudComponent( v, true )
			end
		end
	end
end

setTimer(addYesTimer,100,0)


addEventHandler("onClientRender",root,function()
	if getElementDimension(localPlayer) == 5003 then
		if active == false then
			local team = getElementData(localPlayer,"Team")
			if team == "Terrorist" then r,g,b = 255,0,0 else r,g,b = 0,150,250 end
			--local mins,secs = convertTime ( math.floor( theTime ) )
			--dxDrawRelativeText(mins..":"..secs,700,690,1156.0,274.0,tocolor(255,255,255,255),1.7,newFont,"left","top",false,false,false)
			--dxDrawRelativeText(math.floor(getPedArmor(localPlayer)),320,690,1156.0,274.0,tocolor(255,255,255,255),1.7,newFont,"left","top",false,false,false)
			--dxDrawRelativeText(math.floor(getElementHealth(localPlayer)),150,690,1156.0,274.0,tocolor(255,255,255,255),1.7,newFont,"left","top",false,false,false)
			weaponID = getPedWeapon(localPlayer)
			dxDrawRelativeImage(1150,665,180,90,"icons/".. tostring( weaponID ) .. ".png",0.0,0.0,0.0,tocolor(255,255,255,255),false)
			dxDrawRelativeImage(60,676,60,60,"Heart.png",0.0,0.0,0.0,tocolor(255,255,255,255),false)


			if getPedArmor(localPlayer) > 1 then
				dxDrawRelativeImage(230,672,60,60,"armor.png",0.0,0.0,0.0,tocolor(255,255,255,255),false)
			else
				dxDrawRelativeImage(230,672,65,65,"armor.png",0.0,0.0,0.0,tocolor(0,0,0,155),false)
			end
			dxDrawRelativeImage(630,672,65,65,"Time.png",0.0,0.0,0.0,tocolor(255,255,255,255),false)
			local wepSlot = getPedWeaponSlot( localPlayer )
			local clipAmmo = getPedAmmoInClip( localPlayer )
			local totalAmmo = getPedTotalAmmo( localPlayer )
			local wepID = getPedWeapon( localPlayer )
			local ammoIndicatorText = clipAmmo.."/"..totalAmmo - clipAmmo

			if ( wepSlot == 6 ) or ( wepSlot == 8 ) or ( wepID == 25 ) or ( wepID == 35 ) or ( wepID == 36 ) then
				ammoIndicatorText = tostring( totalAmmo )
			end

			if ( wepSlot == 0 ) or ( wepSlot == 1 ) or ( wepSlot == 10 ) or ( wepID == 44 ) or ( wepID == 45 ) or ( wepSlot == 12 ) or ( wepID == 46 ) then
				return
			end
			--dxDrawRelativeText(ammoIndicatorText,990,690,1156.0,274.0,tocolor(255,255,255,255),1.5,newFont,"left","top",false,false,false)
		end
	end
end)


function onClientPlayerWeaponFireFunc(weapon, ammo, ammoInClip, hitX, hitY, hitZ, hitElement )
    if hitElement and isElement(hitElement) and getElementType(hitElement)=="player" then -- If the player shoots with a minigun, and hits another player...
		local dim = getElementDimension(hitElement)
		local health = getElementHealth(hitElement)
		if dim == 5003 then
			if active == false then
				if health <= 20 then
					setElementHealth(hitElement,20)
					cancelEvent()
				end
			end
		end
    end
end
addEventHandler ( "onClientPlayerWeaponFire", getLocalPlayer(), onClientPlayerWeaponFireFunc )

function onClientPlayerWeaponFireFunc(weapon, ammo, ammoInClip, hitX, hitY, hitZ, hitElement )
    if hitElement and isElement(hitElement) and getElementType(hitElement)=="player" then -- If the player shoots with a minigun, and hits another player...
		local dim = getElementDimension(hitElement)
		local health = getElementHealth(hitElement)
		if dim == 5003 then
			if active == false then
				if getElementData(hitElement,"Team") == getElementData(source,"Team") then
					cancelEvent()
				end
			end
		end
    end
end
addEventHandler ( "onClientPlayerWeaponFire", getLocalPlayer(), onClientPlayerWeaponFireFunc )



function duelDamage(attacker, weapon, bodypart, loss)
    if (source ~= localPlayer) then return end
    if (not loss) then loss = 1 end
    local dim = getElementDimension(source)
    local health = getElementHealth(source) + loss
    if (dim == 5003) then
        if (health <= 20) or (health - loss <= 20) then
			cancelEvent()
			if active == false then
				if attacker and isElement(attacker) and attacker ~= source then
					triggerServerEvent("setPlayerCSGOHealth",source,attacker)
				else
					triggerServerEvent("setPlayerCSGOHealth",source)
				end
			end
        end
    end
end
addEvent("onClientLocalPlayerDamage", true)
addEventHandler("onClientLocalPlayerDamage", localPlayer, duelDamage)

addEventHandler("onClientExplosion", root,
function(x, y, z, theType)
	if getElementDimension(localPlayer) == 5003 then
		cancelEvent()
	end
end)

addEventHandler( "onClientProjectileCreation", root,
function ( creator )
	if active == true or active == false then
		if getElementDimension(localPlayer) == 5003 then
			if ( getProjectileType( source ) == 16 ) or ( getProjectileType( source ) == 17 ) or ( getProjectileType( source ) == 18 ) or ( getProjectileType( source ) == 39 ) then

				if ( creator == localPlayer ) then
					-------
				end

				destroyElement( source )
			end
		end
	end
end
)



local sound = {}
local sduration = {}
local oldurl = ""
local antiSound = {}
function playsound(data,p)
	if (data == 1) then
		url = "misc/terrorists_win.mp3"
		only = false
	elseif (data == 2) then
		url = "misc/cterrorists_win.mp3"
		only = false
	elseif (data == 3) then
		url = "misc/letsgo.mp3"
		only = true
	end
	--[[if url == oldurl then return false end
	]]
	if isTimer(antiSound) then killTimer(antiSound) end
	antiSound = setTimer(function() end,5000,1)
	if only == true then
		--for k, v in pairs(getElementsByType("player")) do
			if (getElementData(p,"CS:GO Team")) then
				triggerServerEvent("AURsounds.return_sounds", p, url, p)
		--		break
			end
		--end
	else
		--for k, v in pairs(getElementsByType("player")) do
			--if (getElementData(v,"CS:GO Team")) then
			if (getElementData(p,"CS:GO Team")) then
				triggerServerEvent("AURsounds.return_sounds", p, url, p)
				--break
			end
		--end
	end
end
addEvent("AURsounds.playsound", true)
addEventHandler("AURsounds.playsound", root, playsound)

function cancel_sounds()
	for k, v in ipairs(getElementsByType("player")) do
		triggerServerEvent("AURsounds.return_stop", v, v)
	end
end

function stop_return(v)
	if (not sound) then return end
	sound[v] = nil
end
addEvent("AURsounds.stop_return", true)
addEventHandler("AURsounds.stop_return", root, stop_return)
who = {}
gotIt = {}
function proceedsounds(url, v)
	if (not v and not isElement(v)) then return end
	if (sound[v]) then return end
	--if gotIt[v] == url then return false end
	--if isTimer(antiSound) then killTimer(antiSound) end
	--antiSound = setTimer(function(d)
	--	gotIt[d] = false
	--end,10000,1,v)
	--gotIt[v] = url
	sound[v] = playSound(url,false)
	setSoundVolume(sound[v], 1.0)
	sduration[v] = getSoundLength(sound[v])
	if isTimer(who[v]) then killTimer(who[v]) end
	who[v] = setTimer(cancel_sounds, sduration[v]*1000, 1)
end
addEvent("AURsounds.proceedsounds", true)
addEventHandler("AURsounds.proceedsounds", root, proceedsounds)

