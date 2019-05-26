local toBoolean = function (str) return str == "true" end

local MusicGUI = {}
local volume = nil
local soundURL = nil
local actualURL = nil
local mySongs = {}
local playingName = {}
local MusicSoundVeh=nil
local posTimer = false
local lengthTimer = false
local playingName = "" --vehs
local scrollX = 1110
local nowPlaying = {}
local previousSongs = {}

function recMySongList(t)
	mySongs=t
	if isElement(MusicGUI[1]) then
		guiGridListClear(MusicGUI[1])
		for k,v in pairs(mySongs) do
			local row = guiGridListAddRow( MusicGUI[1] )
			guiGridListSetItemText( MusicGUI[1], row, 1, v[1], false, false )
			guiGridListSetItemData ( MusicGUI[1], row, 1, v[2] )
			if v[2] == actualURL then
				guiGridListSetItemColor(MusicGUI[1],row,1,0,255,0)
			end
		end
	end
end
addEvent("CSGphone.recMySongList",true)
addEventHandler("CSGphone.recMySongList",localPlayer,recMySongList)

function openMusic()
	togglePhone()
	executeCommandHandler ( "mplayer" )
end
apps[15][8] = openMusic

local oldTick = getTickCount()
function addmusic()
	if getTickCount() - oldTick < 2000 then
		exports.NGCdxmsg:createNewDxMessage("Do not spam click add!",255,255,0)
		return
	end
	if  string.len( tostring( guiGetText(MusicGUI[12] ) ) ) > 15 then
		guiSetText(MusicGUI[12],"")
		exports.NGCdxmsg:createNewDxMessage("You can't spam this with very long name",255,0,0)
		return false
	end
	if  string.len( tostring( guiGetText(MusicGUI[13] ) ) ) > 200 then
		guiSetText(MusicGUI[13],"")
		exports.NGCdxmsg:createNewDxMessage("You can't spam this with very long link",255,0,0)
		return false
	end
	oldTick=getTickCount()
	--[[if 1+1==2 then
		exports.NGCdxmsg:createNewDxMessage("Feature in Development. Only enabled for testers at the moment.",0,255,0)
		return
	end--]]
	--if getPlayerName(localPlayer) ~= "[CSG]Priyen[MF]" and getPlayerName(localPlayer) ~= "[AS]Influx" and getPlayerName(localPlayer) ~= "[CSG]Pranav[FBI]" then return end
	local name = guiGetText(MusicGUI[12])
	local link = guiGetText(MusicGUI[13])
	--link=string.lower(link)

	if link == "" or link == "Link (mp3)" or type(tonumber(string.find(link,"Link")))=="number" then
		exports.NGCdxmsg:createNewDxMessage("Invalid music link, must be .mp3 direct link",255,255,0)
		return
	end
	if name == "Song Name" then name = "" end
	addMusic(name,link)
end

function removemusic()
	local row, column = guiGridListGetSelectedItem ( MusicGUI[1] )
	if ( row ) then
		if ( MusicSound ) then killSound() end
		local stationURL = guiGridListGetItemData( MusicGUI[1], row, column )

			local id = nil
			local index=nil
			local name = ""
			for k,v in pairs(mySongs) do
				if v[2] == stationURL then
					table.remove(mySongs,k)
					triggerServerEvent("CSGphone.removemusic",localPlayer,stationURL)
					recMySongList(mySongs)
					break
				end
			end

	end
end

function addMusic(name,link,id)
	table.insert(mySongs,{name,link,id})
	recMySongList(mySongs)
	triggerServerEvent("CSGphone.musicAdded",localPlayer,{name,link,id})
end

function stopMusicApp()

	removeEventHandler ( "onClientGUIClick", MusicGUI[3], startMusicApp )
	removeEventHandler ( "onClientGUIClick", MusicGUI[2], stopmusic )
	removeEventHandler ( "onClientGUIClick", MusicGUI[4], upVol )
	removeEventHandler ( "onClientGUIClick", MusicGUI[5], lowerVol )
	removeEventHandler ( "onClientGUIClick", MusicGUI[8], vehtoggle )
	removeEventHandler ( "onClientGUIClick", MusicGUI[9], addmusic )
	removeEventHandler ( "onClientGUIClick", MusicGUI[10], removemusic )
	for i=1,#MusicGUI do
		if i ~= 7 then
			guiSetVisible ( MusicGUI[i], false )
			guiSetProperty ( MusicGUI[i], "AlwaysOnTop", "False" )
		end
	end
	guiSetText(MusicGUI[12],"Song Name")
	guiSetText(MusicGUI[13],"Link (.	")
	apps[15][7] = false

end
apps[15][9] = stopMusicApp

local olddim,oldint=0,0

function playMusic(stationURL,playingPrevious)

	if ( MusicSound ) then killSound() end
	local index=nil
	local name = ""
	for k,v in pairs(mySongs) do
		if v[2] == stationURL then
			name=v[1]
			index=k
			break
		end
	end
	actualURL = stationURL
	nowPlaying = { name,actualURL}
	if mySongs[index].soundURL ~= nil then
		soundURL = mySongs[index].soundURL
	else
		soundURL=stationURL
	end
	if not playingPrevious then table.insert(previousSongs,actualURL) end
	exports.NGCdxmsg:createNewDxMessage("Music :: Playing "..name.."",0,255,0)
	olddim,oldint=getElementDimension(localPlayer),getElementInterior(localPlayer)
	local x,y,z = getElementPosition(localPlayer)
	MusicSound=playSound(soundURL,true)
	recMySongList(mySongs)
	local lengthTimer=false
	if isPedInVehicle(localPlayer) then
		lengthTimer = setTimer(function()
			if guiCheckBoxGetSelected(MusicGUI[8]) == false then killTimer(lengthTimer) return end
			local length = getSoundLength(MusicSound)
			local name = ""
			for k,v in pairs(mySongs) do
				if v.soundURL ~= nil then
					if v.soundURL == soundURL then
						name=v[1]
					end
				else
					if v[2] == soundURL then
						name=v[1]
					end
				end
			end
			if length ~= 0 and length ~= false then
				triggerServerEvent("CSGphone.addedToVeh",getPedOccupiedVehicle(localPlayer),soundURL,getSoundPosition(MusicSound),length,name)
				playingName=name
				MusicSoundVeh=MusicSound
				killTimer(lengthTimer)
			end
		end,1000,0)
	end

	if ( volume ) then setSoundVolume(MusicSound, volume) else setSoundVolume(MusicSound, 0.5) end

end

function startMusicApp ()

	local row, column = guiGridListGetSelectedItem ( MusicGUI[1] )
	if ( row ) and row ~= -1 then
		playMusic(guiGridListGetItemData( MusicGUI[1], row, column ))
	end
end

function updateSound()
	local x,y,z = getElementPosition(localPlayer)
	local int,dim = getElementInterior(localPlayer),getElementDimension(localPlayer)
	if int ~= oldint then
		setElementInterior(MusicSound,int)
	end
	if dim ~= olddim then
		setElementDimension(MusicSound,dim)
	end
	setElementPosition(MusicSound,x,y,z)
	if guiCheckBoxGetSelected(MusicGUI[8]) == true then
		if isPedInVehicle(localPlayer) then
			if getVehicleController(getPedOccupiedVehicle(localPlayer)) == localPlayer then
				triggerServerEvent("CSGphone.removedFromVeh",getPedOccupiedVehicle(localPlayer))
				MusicSoundVeh=false
				playingName=""
			end
		end
	end
end

function stopmusic ()
	killSound()
	if isPedInVehicle(localPlayer) then
		if getVehicleController(getPedOccupiedVehicle(localPlayer)) == localPlayer then
			triggerServerEvent("CSGphone.removedFromVeh",getPedOccupiedVehicle(localPlayer))
			MusicSoundVeh=false
			playingName=""
		end
	end
end

local enabledMusicHUD = true
local sX, sY = guiGetScreenSize()
local nX, nY = 1366, 768
addEventHandler("onClientRender", root,
	function()
		if enabledMusicHUD and isPedInVehicle(localPlayer) then
			if isElement(MusicSoundVeh) then
				timeIn = "("..math.floor(getSoundPosition(MusicSoundVeh)).."s/"..math.floor(getSoundLength(MusicSoundVeh)).."s)"
			else
				timeIn = "Nothing Playing"
			end
			if timeIn ~= "Nothing Playing" then
				dxDrawText( ""..timeIn.."", ( 1101 / nX ) * sX, ( 753 / nY ) * sY, ( 1347 / nX ) * sX, ( 735 / nY ) * sY, tocolor( 0, 255, 0, 255 ), 1.00, "default-bold", "center", "center" )
			else
				dxDrawText( ""..timeIn.."", ( 1101 / nX ) * sX, ( 753/ nY ) * sY, ( 1347 / nX ) * sX, ( 735 / nY ) * sY, tocolor( 255, 255, 0, 255 ), 1.00, "default-bold", "center", "center" )
			end
		elseif isElement(MusicSoundVeh) then
			killSoundVeh()
			if guiCheckBoxGetSelected(MusicGUI[8]) == true then guiCheckBoxSetSelected(MusicGUI[8],false) end
		end
	end
)

addCommandHandler("vehmusichud",function() enabledMusicHUD=true end)
function killSound()
	if ( MusicSound ) then
		removeEventHandler("onClientRender",root,updateSound)
		stopSound( MusicSound )
		MusicSound = nil
		soundURL = nil
		actualURL = nil
		recMySongList(mySongs)
		if isTimer(lengthTimer) then killTimer(lengthTimer) end
	end
end

function upVol ()
	if ( MusicSound ) then
		if ( tonumber( string.format( "%.1f", getSoundVolume ( MusicSound ) +0.1 ) ) <= 1 ) then
			volume = tonumber( string.format( "%.1f", getSoundVolume ( MusicSound ) +0.1 ) )
			setSoundVolume(MusicSound, volume )
			guiSetText ( MusicGUI[6], "Music volume: " .. math.floor((volume/1*100)) .. "%" )
		end
	end
end

function lowerVol ()
	if ( MusicSound ) then
		if ( tonumber( string.format( "%.1f", getSoundVolume ( MusicSound ) -0.1 ) ) >= 0 ) then
			volume = tonumber( string.format( "%.1f", getSoundVolume ( MusicSound ) -0.1 ) )
			setSoundVolume(MusicSound, volume )
			guiSetText ( MusicGUI[6], "Music volume: " .. math.floor((volume/1*100)) .. "%" )
		end
	end
end

function vehtoggle ()
	if ( source == MusicGUI[8] ) then
		--if isPedInVehicle(localPlayer) == false then return end
		if guiCheckBoxGetSelected(MusicGUI[8]) == true then
			if isPedInVehicle(localPlayer) == false then
				exports.NGCdxmsg:createNewDxMessage("Youre not in a vehicle, you can't plug your Phone into anything",255,255,0)
				guiCheckBoxSetSelected(MusicGUI[8],false)
				return
			elseif getVehicleController(getPedOccupiedVehicle(localPlayer)) == localPlayer then
				--controller, so allow it
			else
				exports.NGCdxmsg:createNewDxMessage("You're not the vehicle driver, you can't plug your phone into the sound system",0,255,0)
				guiCheckBoxSetSelected(MusicGUI[8],false)
				return
			end
			if (MusicSound) then
				lengthTimer = setTimer(function()
				if guiCheckBoxGetSelected(MusicGUI[8]) == false then killTimer(lengthTimer) return end
				local length = getSoundLength(MusicSound)
				local name = ""
				for k,v in pairs(mySongs) do
					if v.soundURL ~= nil then
						if v.soundURL == soundURL then
							name=v[1]
						end
					else
						if v[2] == soundURL then
							name=v[1]
						end
					end
				end
				if length ~= 0 and length ~= false then
					exports.NGCdxmsg:createNewDxMessage("Plugged phone into vehicle sound system",0,255,0)
					triggerServerEvent("CSGphone.addedToVeh",getPedOccupiedVehicle(localPlayer),soundURL,getSoundPosition(MusicSound),length,name)
					MusicSoundVeh=MusicSound
					playingName=name
					killTimer(lengthTimer)
				end
				end,1000,0)
			end
		else
			if isPedInVehicle(localPlayer) then
				if getVehicleController(getPedOccupiedVehicle(localPlayer)) == localPlayer then
					triggerServerEvent("CSGphone.removedFromVeh",getPedOccupiedVehicle(localPlayer))
					exports.NGCdxmsg:createNewDxMessage("Unplugged phone from vehicle sound system",0,255,0)
					MusicSoundVeh=false
					playingName="Nothing Playing"
				end
			end
		end
		--exports.DENsettings:setPlayerSetting( "MusicTitle", tostring( guiCheckBoxGetSelected( MusicGUI[8] ) ) )
	end
end

function killSoundVeh()
	playingName=""
	if isElement( MusicSoundVeh ) then
		if isTimer(posTimer) then killTimer(posTimer) end
		if MusicSoundVeh ~= MusicSound or getElementHealth(localPlayer) <= 0 then
			stopSound(MusicSoundVeh)
			if isElement(MusicSoundVeh) then guiCheckBoxSetSelected(MusicGUI[8],false) destroyElement(MusicSoundVeh) end
		end
	end
end
addEvent("CSGphone.stopCarSound",true)
addEventHandler("CSGphone.stopCarSound",localPlayer,killSoundVeh)

function vehSound(link,pos,name)
	if getVehicleController(getPedOccupiedVehicle(localPlayer)) == localPlayer then return end

	pos=math.floor(pos)
	pos=pos/1000
	killSoundVeh()
	--stopSound(MusicSoundVeh)
	if isTimer(posTimer) then killTimer(posTimer) end
	MusicSoundVeh=playSound(link,true)
	--setSoundPosition(MusicSoundVeh,pos)
	--setTimer(function() setSoundPosition(MusicSoundVeh,pos+5000) end,1000,5)
	if pos ~= 0 and pos ~= false then
		if isTimer(posTimer) then killTimer(posTimer) end
		posTimer = setTimer(function() setSoundPosition(MusicSoundVeh,pos) if getSoundPosition(MusicSoundVeh) == pos then killTimer(posTimer) end end,50,0)
	end
	playingName=name
end
addEvent("CSGphone.playCarSound",true)
addEventHandler("CSGphone.playCarSound",localPlayer,vehSound)

local littlePlayerGUI = {}
local littleController = exports.densettings:getPlayerSetting("musiccontrol")

local littleControllerActive

function maintainLittleController()

	if nowPlaying[1] and nowPlaying[1] ~= "" and isElement(MusicSound) then

		local songTitleWidth,songTitleHeight = math.max(60,dxGetTextWidth(nowPlaying[1] or "None",1.2)+30), 30
		local songTitleX,songTitleY = (sW-songTitleWidth)/2,sH-songTitleHeight-30

		dxDrawRectangle(songTitleX,songTitleY,songTitleWidth,songTitleHeight,tocolor(0,0,0,200) )
		dxDrawText ( nowPlaying[1] or "None",songTitleX,songTitleY,songTitleX+songTitleWidth,songTitleY+songTitleHeight, tocolor ( 255, 255, 255, 255 ), 1.2, "default", "center", "center", false, false, false )

		if not isElement(littlePlayerGUI.previous) then

			littlePlayerGUI.previous = guiCreateButton(songTitleX,sH-30,30,30,'<',false)
			littlePlayerGUI.next = guiCreateButton(songTitleX+songTitleWidth-30,sH-30,30,30,'>',false)
			--littlePlayerGUI.toggle = guiCreateButton(songTitleX+( (songTitleWidth-40)/2 ),sH-20,40,20,'Stop',false)
			bindKey("m","down",toggleMusicCursor )
			addEventHandler("onClientGUIClick",root,onLittlePlayerClick)

		else

			guiSetPosition(littlePlayerGUI.previous,songTitleX,sH-30,false)
			guiSetPosition(littlePlayerGUI.next,songTitleX+songTitleWidth-30,sH-30,false)

		end

	elseif isElement(littlePlayerGUI.previous) then

		for k,v in pairs(littlePlayerGUI) do destroyElement(v) end
		littlePlayerGUI = {}
		unbindKey("m","down",toggleMusicCursor )
		removeEventHandler("onClientGUIClick",root,onLittlePlayerClick)

	end

end

function applyNewControllerSetting()

	if littleController and not littleControllerActive then

		addEventHandler("onClientRender",root,maintainLittleController)
		littleControllerActive = true

	elseif littleControllerActive and not littleController then

		removeEventHandler("onClientRender",root,maintainLittleController)
		littleControllerActive = false
		if isElement(littlePlayerGUI.previous) then

			for k,v in pairs(littlePlayerGUI) do destroyElement(v) end
			littlePlayerGUI = {}
			unbindKey("m","down",toggleMusicCursor )
			removeEventHandler("onClientGUIClick",root,onLittlePlayerClick)
		end

	end

end
applyNewControllerSetting()

addEventHandler("onPlayerSettingChange",localPlayer,
function (setting,newState)

	if setting == "musiccontrol" then

		littleController = newState
		applyNewControllerSetting()

	end

end)


function onLittlePlayerClick()

	if source == littlePlayerGUI.previous then

		if previousSongs and #previousSongs > 0 then

			stopmusic()
			playMusic (previousSongs[math.max(1,#previousSongs-1)],true)

		end

	elseif source == littlePlayerGUI.next then

		local songCount = guiGridListGetRowCount(MusicGUI[1])
		if songCount > 0 then

			for i=1,10 do
				local givenURL = guiGridListGetItemData(MusicGUI[1],math.random(0,songCount),1)
				if givenURL and givenURL ~= nowPlaying[2] then
					stopmusic()
					playMusic (givenURL)
					break
				end
			end

		end

	elseif source == littlePlayerGUI.toggle then

		if isElement(MusicSound) and isSoundPaused(MusicSound) and nowPlaying[2] then

			playMusic (nowPlaying[2])
			guiSetText(littlePlayerGUI.toggle,"Stop")

		elseif isElement(MusicSound) then

			stopmusic()
			guiSetText(littlePlayerGUI.toggle,"Play")

		end

	end

end

function toggleMusicCursor()
	showCursor(not isCursorShowing())
end

addCommandHandler("vehsoundpos",function()
	outputChatBox(getSoundPosition(MusicSoundVeh))
end)
