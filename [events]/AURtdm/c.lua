blip = exports.customblips:createCustomBlip( 1187.8785400391,-2040.1242675781,25,25,"csgo2.png",1000)
exports.customblips:setCustomBlipRadarScale(blip,0.8,0.8)

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

lobby = {} or 0
terro = {} or 0
counter = {} or 0
--[[
addEvent("addYesTimer",true)
addEventHandler("addYesTimer",root,function()
	if isTimer(yesTimer) then killTimer(yesTimer) end
end)]]
local disabledHUD = { "health", "armour", "radar", "breath", "clock", "money", "weapon", "ammo", "area_name" }

for i, v in pairs( disabledHUD ) do
	showPlayerHudComponent( v, true )
end
yesTimer = {}
function addYesTimer()
	if getElementDimension(localPlayer) == 1001 then
		if isTimer(yesTimer) then killTimer(yesTimer) end
		yesTimer = setTimer(function()
			lobby = {} or 0
			terro = {} or 0
			counter = {} or 0
			for k,v in ipairs(getElementsByType("player")) do
				if getElementData(v,"CS:GO") then
					if getElementData(v,"isPlayerinLobby") then
						table.insert(lobby,v)
						setPedWeaponSlot(v,0)
					elseif not getElementData(v,"isPlayerinLobby") and getElementData(v,"CS:GO Team") == "Terrorists" then
						table.insert(terro,v)
					elseif not getElementData(v,"isPlayerinLobby") and getElementData(v,"CS:GO Team") == "Counter-Terrorists" then
						table.insert(counter,v)
					end
				end
			end
		end,1000,0)
		for i, v in pairs( disabledHUD ) do
			showPlayerHudComponent( v, false )
		end
		setTimer(addYesTimer,5000,1)
	else
		if isTimer(yesTimer) then killTimer(yesTimer) end
		setTimer(addYesTimer,5000,1)
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

addYesTimer()


local newFont = dxCreateFont( "FONT.ttf", 8 ) or "default-bold"

theTime = 0
local round = 0
local twins = 0
local ctwins = 0
local r,g,b = 255,255,255
addEvent("CS:GO RoundTime",true)
addEventHandler("CS:GO RoundTime",root,function(tm,rnd,win1,win2)
	theTime = tm or 0
	round = rnd
	twins = win1
	ctwins = win2
end)

function convertTime(ms)
    local min = math.floor ( ms/60000 )
    local sec = math.floor( (ms/1000)%60 )
    return min, sec
end


function showTextOnTop()
    local xx, yy, zz = getElementPosition(localPlayer)
	for k,v in ipairs(getElementsByType("marker",resourceRoot)) do
		if getElementData(v,"CSGO") then
			if getElementDimension(localPlayer) == getElementDimension(v) then
				local mXX, mYY, mZZ = getElementPosition(v)
				local rr, gg, bb = 255,255,255
				local sxx, syy = getScreenFromWorldPosition(mXX, mYY, mZZ+1)
				if (sxx) and (syy) then
					local distancee = getDistanceBetweenPoints3D(xx, yy, zz, mXX, mYY, mZZ)
					if (distancee < 30) then
						local m = getElementData(v,"CSGO")
						if m == "Terrorists" then
							r,g,b = 255,0,0
						else
							r,g,b = 0,100,200
						end
						dxDrawText(m, sxx+6, syy+6, sxx, syy, tocolor(0, 0, 0, 255), 2-(distancee/30),  "sans", "center", "center")
						dxDrawText(m, sxx+2, syy+2, sxx, syy, tocolor(r,g,b, 255), 2-(distancee/30), "sans", "center", "center")
					end
				end
			end
		end
	end
end
addEventHandler("onClientRender", getRootElement(), showTextOnTop)

addEventHandler("onClientRender",root,function()
	if getElementDimension(localPlayer) == 1001 then
		if getElementData(localPlayer,"CS:GO") then
		--if getElementData(localPlayer,"isPlayerPrime") then
			local team = getElementData(localPlayer,"CS:GO Team")
			if team == "Terrorists" then r,g,b = 255,0,0 else r,g,b = 0,150,250 end
			--dxDrawRelativeRectangle(1050,160.0,290,90,tocolor(0,0,0,150),false)
			--dxDrawRelativeRectangle(1050,25.0,290,30,tocolor(0,0,0,150),false)
			--dxDrawRelativeRectangle(1050,55.0,290,70,tocolor(0,0,0,150),false)
			dxDrawRelativeText("Terrorists: "..#terro.."",1140,90,1156.0,274.0,tocolor(255,0,0,255),2,"default-bold","center","top",false,false,false)
			dxDrawRelativeText("Counter-Terrorists: "..#counter.."",1240,60,1156.0,274.0,tocolor(0,100,250,255),2,"default-bold","center","top",false,false,false)
			dxDrawRelativeText("CS:GO TDM",1250,30,1156.0,274.0,tocolor(255,255,255,255),2,"default-bold","center","top",false,false,false)
			local mins,secs = convertTime ( math.floor( theTime ) )
			dxDrawRelativeText(mins..":"..secs,700,690,1156.0,274.0,tocolor(255,255,255,255),1.7,newFont,"left","top",false,false,false)
			dxDrawRelativeText(math.floor(getPedArmor(localPlayer)),320,690,1156.0,274.0,tocolor(255,255,255,255),1.7,newFont,"left","top",false,false,false)
			dxDrawRelativeText(math.floor(getElementHealth(localPlayer)),150,690,1156.0,274.0,tocolor(255,255,255,255),1.7,newFont,"left","top",false,false,false)
			weaponID = getPedWeapon(localPlayer)
			dxDrawRelativeImage(1150,665,180,90,"icons/".. tostring( weaponID ) .. ".png",0.0,0.0,0.0,tocolor(255,255,255,255),false)
			--dxDrawRelativeImage(60,676,65,65,"Heart.png",0.0,0.0,0.0,tocolor(0,0,0,255),false)
			dxDrawRelativeImage(60,676,60,60,"Heart.png",0.0,0.0,0.0,tocolor(255,255,255,255),false)


			if getPedArmor(localPlayer) > 1 then
				dxDrawRelativeImage(230,672,60,60,"armor.png",0.0,0.0,0.0,tocolor(255,255,255,255),false)
			else
				dxDrawRelativeImage(230,672,65,65,"armor.png",0.0,0.0,0.0,tocolor(0,0,0,155),false)
			end
			--dxDrawRelativeImage(630,672,65,65,"Time.png",0.0,0.0,0.0,tocolor(0,0,0,255),false)
			dxDrawRelativeImage(630,672,65,65,"Time.png",0.0,0.0,0.0,tocolor(255,255,255,255),false)
			--dxDrawRelativeImage(1060,180,55,55,"team1.png",0.0,0.0,0.0,tocolor(0,0,0,255),false)
			--dxDrawRelativeImage(1280,180,55,55,"team2.png",0.0,0.0,0.0,tocolor(0,0,0,255),false)
			dxDrawRelativeImage(1060,180,50,50,"team1.png",0.0,0.0,0.0,tocolor(255,255,255,255),false)
			dxDrawRelativeImage(1280,180,50,50,"team2.png",0.0,0.0,0.0,tocolor(255,255,255,255),false)
			dxDrawRelativeText("Round ",1250,180,1156.0,274.0,tocolor(255,255,255,255),2,"default-bold","center","top",false,false,false)
			dxDrawRelativeText("( "..round.." )",1250,210,1156.0,274.0,tocolor(255,255,255,255),2,"default-bold","center","top",false,false,false)
			dxDrawRelativeText("( "..twins.." )",1000,260,1156.0,274.0,tocolor(255,0,0,255),2,"default-bold","center","top",false,false,false)
			dxDrawRelativeText("( "..ctwins.." )",1470,260,1156.0,274.0,tocolor(0,100,200,255),2,"default-bold","center","top",false,false,false)
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
			dxDrawRelativeText(ammoIndicatorText,990,690,1156.0,274.0,tocolor(255,255,255,255),1.5,newFont,"left","top",false,false,false)
		end
	end
end)

function onClientPlayerWeaponFireFunc(weapon, ammo, ammoInClip, hitX, hitY, hitZ, hitElement )
    if hitElement and isElement(hitElement) and getElementType(hitElement)=="player" then -- If the player shoots with a minigun, and hits another player...
		local dim = getElementDimension(hitElement)
		local health = getElementHealth(hitElement)
		if dim == 1001 then
			if ( getElementData ( hitElement, "isPlayerinLobby" ) or getElementData ( hitElement, "CS:GO" ) ) then
				--if getElementData(hitElement,"CS:GO LastRound") then return false end
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
		if dim == 1001 then
			if ( getElementData ( hitElement, "isPlayerinLobby" ) or getElementData ( hitElement, "CS:GO" ) ) then
				if getElementData(hitElement,"CS:GO Team") == getElementData(source,"CS:GO Team") then
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
    if (dim == 1001) then
        if (health <= 20) or (health - loss <= 20) then
			if getElementData(source,"CS:GO LastRound") then
				cancelEvent()
				if not getElementData(source,"isPlayerinLobby") then
					if attacker and isElement(attacker) and attacker ~= source then
						triggerServerEvent("CS_Lobby",source,attacker)
					else
						triggerServerEvent("CS_Lobby",source)
					end
				end
				return
			else
				cancelEvent()
				if not getElementData(source,"isPlayerinLobby") then
					if attacker and isElement(attacker) and attacker ~= source then
						triggerServerEvent("CS_Lobby",source,attacker)
					else
						triggerServerEvent("CS_Lobby",source)
					end
				end
			end
        end
    end
end
addEventHandler("onClientLocalPlayerDamage", root, duelDamage)

addEventHandler( "onClientProjectileCreation", root,
function ( creator )
	if ( getElementData ( localPlayer, "isPlayerinLobby" ) ) or ( getElementData ( localPlayer, "CS:GO" ) ) then
		if getElementDimension(localPlayer) == 1001 then
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

addEventHandler("onClientExplosion", root,
function(x, y, z, theType)
	if getElementDimension(localPlayer) == 1001 then
		cancelEvent()
	end
end)


LawSkins = {
	{"tt",182},
	{"ct",151},
}

local mods = {}
local txdFile = {}
local dffFile = {}

function onThisResourceStart ( )
	for k,v in ipairs(LawSkins) do
		downloadFile ( "models/"..v[1]..".dff" )
	end
end
addEventHandler ( "onClientResourceStart", resourceRoot, onThisResourceStart )

function onDownloadFinish ( file, success )
    if ( source == resourceRoot ) then                            -- if the file relates to this resource
        if ( success ) then
			for k,v in ipairs(LawSkins) do
				if file == "models/"..v[1]..".dff" then
					if fileExists(":AURtdm/models/"..v[1]..".dff") then
						loadMyMods(v[1],":AURtdm/models/"..v[1]..".dff",":AURtdm/models/"..v[1]..".txd",v[2],v[1])
					end
				elseif file == "models/"..v[1]..".txd" then
					if fileExists(":AURtdm/models/"..v[1]..".dff") and fileExists(":AURtdm/models/"..v[1]..".txd") then
						loadSkins(v[1],v[2])
					end
				end
            end
        end
    end
end
addEventHandler ( "onClientFileDownloadComplete", getRootElement(), onDownloadFinish )

function loadMyMods(name,dff,txd,id,wh)
	downloadFile ( "models/"..name..".txd" )
end

function loadSkins(name,id)
	mods[name] = {
		{name,id}
	}
	replaceMods(name)
end

function replaceMods(name)
	for k,v in ipairs(mods[name]) do
		if fileExists(":AURtdm/models/"..v[1]..".txd") then
			txd = engineLoadTXD(":AURtdm/models/"..v[1]..".txd")
			if txd and txd ~= false then
				engineImportTXD(txd,v[2])
			end
		end
		if fileExists(":AURtdm/models/"..v[1]..".dff") and fileExists(":AURtdm/models/"..v[1]..".txd") then
			if fileExists(":AURtdm/models/"..v[1]..".dff") then
				dff = engineLoadDFF(":AURtdm/models/"..v[1]..".dff",v[2])
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


---AURammunation\images
