--
-- Author: Ab-47; State: Complete (Version 1.0 Lite).
-- Additional Notes; N/A; Rights: All Rights Reserved by Developers and Ab-47.
-- Project: AURgmusic/client.lua consisting of 1 file(s).
-- Directory: AURgmusic/client.lua
-- Side Notes: N/A
--

local password = "haha nice try noob, no password here"
local screenWidth, screenHeight = guiGetScreenSize()
local dims_allowed = {[5001] = true, [5002] = true, [5003] = true, [5004] = true}

music = {
    button = {},
    window = {},
    edit = {},
    label = {}
}

gmusic = {
    button = {},
    window = {},
    edit = {},
    label = {}
}

music_2 = {
    button = {},
    window = {},
    edit = {}
}

music_3 = {
    button = {},
    window = {},
    label = {},
    edit = {}
}


addEventHandler("onClientResourceStart", resourceRoot,
    function()
		local p1 = "h"
		local p2 = "llo"
		local p3 = "78"
		
			windowWidth, windowHeight = 488, 183
		windowX, windowY = (screenWidth / 2) - (windowWidth / 2), (screenHeight / 2) - (windowHeight / 2)
		gmusic.window[1] = guiCreateWindow(windowX, windowY, windowWidth, windowHeight, "Aurora ~ Music", false)
        guiWindowSetSizable(gmusic.window[1], false)
        guiSetAlpha(gmusic.window[1], 1.00)
		guiSetVisible(gmusic.window[1], false)

        gmusic.label[1] = guiCreateLabel(96, 21, 291, 43, "Enter a URL to play!", false, gmusic.window[1])
        guiLabelSetColor(gmusic.label[1], 251, 102, 3)
        guiLabelSetHorizontalAlign(gmusic.label[1], "center", false)
        guiLabelSetVerticalAlign(gmusic.label[1], "center")
        gmusic.label[2] = guiCreateLabel(96, 39, 291, 43, "Music is legit, in my opinion, it's the only thing that keeps us going!", false, gmusic.window[1])
        guiSetFont(gmusic.label[2], "default-small")
        guiLabelSetColor(gmusic.label[2], 246, 7, 243)
        guiLabelSetHorizontalAlign(gmusic.label[2], "center", false)
        guiLabelSetVerticalAlign(gmusic.label[2], "center")
        gmusic.edit[1] = guiCreateEdit(9, 82, 467, 36, "", false, gmusic.window[1])
        gmusic.button[1] = guiCreateButton(10, 127, 118, 39, "Play Music", false, gmusic.window[1])
        guiSetFont(gmusic.button[1], "default-bold-small")
        guiSetProperty(gmusic.button[1], "NormalTextColour", "FFF607F3")
        gmusic.button[2] = guiCreateButton(133, 128, 118, 39, "Stop Music", false, gmusic.window[1])
        guiSetFont(gmusic.button[2], "default-bold-small")
		guiSetEnabled(gmusic.button[2], false)
        guiSetProperty(gmusic.button[2], "NormalTextColour", "FF1AF309")
        gmusic.button[3] = guiCreateButton(358, 128, 118, 39, "Close Panel", false, gmusic.window[1])
        guiSetFont(gmusic.button[3], "default-bold-small")
        guiSetProperty(gmusic.button[3], "NormalTextColour", "FFF11A0A")
        gmusic.button[5] = guiCreateButton(452, 22, 26, 27, "+", false, gmusic.window[1])
        guiSetProperty(gmusic.button[5], "NormalTextColour", "FFAAAAAA")
        gmusic.button[6] = guiCreateButton(422, 22, 26, 27, "-", false, gmusic.window[1])
        guiSetProperty(gmusic.button[6], "NormalTextColour", "FFAAAAAA")
        gmusic.label[3] = guiCreateLabel(5, 21, 94, 25, "Volume: 100%", false, gmusic.window[1])
        guiLabelSetHorizontalAlign(gmusic.label[3], "center", false)
        guiLabelSetVerticalAlign(gmusic.label[3], "center")
		
		windowWidth, windowHeight = 378, 149
		windowX, windowY = (screenWidth / 2) - (windowWidth / 2), (screenHeight / 2) - (windowHeight / 2)
		music.window[1] = guiCreateWindow(windowX, windowY, windowWidth, windowHeight, "Aurora ~ Music", false)
        guiWindowSetSizable(music.window[1], false)
        guiSetAlpha(music.window[1], 1.00)

        music.label[1] = guiCreateLabel(86, 24, 214, 36, "Proceed to DJ", false, music.window[1])
        guiLabelSetColor(music.label[1], 250, 4, 242)
        guiLabelSetHorizontalAlign(music.label[1], "center", false)
        guiLabelSetVerticalAlign(music.label[1], "center")
        music.edit[1] = guiCreateEdit(14, 59, 351, 33, "", false, music.window[1])
        music.button[1] = guiCreateButton(15, 99, 126, 35, "Enter", false, music.window[1])
        guiSetProperty(music.button[1], "NormalTextColour", "FFAAAAAA")
        music.button[2] = guiCreateButton(146, 99, 126, 35, "Close", false, music.window[1])
		guiSetEnabled(music.button[2], false)
        guiSetProperty(music.button[2], "NormalTextColour", "FFAAAAAA")
		
		music_2.window[1] = guiCreateWindow(456, 232, 484, 168, "AUR Global Music Override", false)
        guiWindowSetSizable(music_2.window[1], false)
        guiSetAlpha(music_2.window[1], 0.98)

        music_2.edit[1] = guiCreateEdit(9, 26, 464, 47, "Link", false, music_2.window[1])
        music_2.button[1] = guiCreateButton(10, 83, 111, 35, "Play Link", false, music_2.window[1])
        guiSetFont(music_2.button[1], "clear-normal")
        guiSetProperty(music_2.button[1], "NormalTextColour", "FFAAAAAA")
        music_2.button[2] = guiCreateButton(125, 121, 111, 35, "Stop All", false, music_2.window[1])
        guiSetFont(music_2.button[2], "clear-normal")
        guiSetProperty(music_2.button[2], "NormalTextColour", "FFAAAAAA")
        music_2.button[3] = guiCreateButton(10, 121, 111, 35, "Play Global", false, music_2.window[1])
        guiSetFont(music_2.button[3], "clear-normal")
        guiSetProperty(music_2.button[3], "NormalTextColour", "FFAAAAAA")
        music_2.button[4] = guiCreateButton(125, 83, 111, 35, "Stop Current", false, music_2.window[1])
        guiSetFont(music_2.button[4], "clear-normal")
        guiSetProperty(music_2.button[4], "NormalTextColour", "FFAAAAAA")
        music_2.button[5] = guiCreateButton(244, 121, 162, 35, "Grant Temp Access", false, music_2.window[1])
        guiSetFont(music_2.button[5], "clear-normal")
        guiSetProperty(music_2.button[5], "NormalTextColour", "FFAAAAAA")
        music_2.edit[2] = guiCreateEdit(244, 83, 230, 32, "Username", false, music_2.window[1])
        music_2.button[6] = guiCreateButton(428, 122, 45, 34, "X", false, music_2.window[1])
        guiSetFont(music_2.button[6], "clear-normal")
        guiSetProperty(music_2.button[6], "NormalTextColour", "FFAAAAAA") 
		
		music_3.window[1] = guiCreateWindow(416, 335, 511, 156, "AUR Global Music Temp Song", false)
        guiWindowSetSizable(music_3.window[1], false)
        guiSetAlpha(music_3.window[1], 1.00)

        music_3.label[1] = guiCreateLabel(17, 22, 477, 25, "This is your temp access music GUI, you can only play a song once!", false, music_3.window[1])
        guiSetFont(music_3.label[1], "clear-normal")
        guiLabelSetColor(music_3.label[1], 55, 242, 12)
        guiLabelSetHorizontalAlign(music_3.label[1], "center", false)
        guiLabelSetVerticalAlign(music_3.label[1], "center")
        music_3.edit[1] = guiCreateEdit(9, 53, 489, 37, "Paste your link here.", false, music_3.window[1])
        music_3.button[1] = guiCreateButton(9, 102, 123, 39, "Play Song", false, music_3.window[1])
        guiSetFont(music_3.button[1], "default-bold-small")
        guiSetProperty(music_3.button[1], "NormalTextColour", "FFF904F0")
        music_3.button[2] = guiCreateButton(136, 102, 123, 39, "Clear Text", false, music_3.window[1])
        guiSetFont(music_3.button[2], "default-bold-small")
        guiSetProperty(music_3.button[2], "NormalTextColour", "FE838383")
        music_3.button[3] = guiCreateButton(375, 102, 123, 39, "Close Panel", false, music_3.window[1])
        guiSetFont(music_3.button[3], "default-bold-small")
        guiSetProperty(music_3.button[3], "NormalTextColour", "FFFC0000")    
		
		guiSetVisible(music.window[1], false)
		guiSetVisible(music_2.window[1], false)
		guiSetVisible(music_3.window[1], false)
		
		for index, buttons in pairs(gmusic.button) do
			addEventHandler("onClientGUIClick", buttons, function() if (source==gmusic.button[2]) then if (guiGetVisible(gmusic.window[1])) then stop_global_music() end end end)
			addEventHandler("onClientGUIClick", buttons, function() if (source==gmusic.button[3]) then if (guiGetVisible(gmusic.window[1])) then guiSetVisible(gmusic.window[1], false) showCursor(false) end end end)
			addEventHandler("onClientGUIClick", buttons, function() if (source==gmusic.button[1]) then if (guiGetText(gmusic.edit[1]) ~= "") then play_global_music(guiGetText(gmusic.edit[1])) else proceed_to_main("password_denied") end end end)
			addEventHandler("onClientGUIClick", buttons, function() if (source==gmusic.button[5]) then if (guiGetVisible(gmusic.window[1])) then changeVolume("increase") end end end)
			addEventHandler("onClientGUIClick", buttons, function() if (source==gmusic.button[6]) then if (guiGetVisible(gmusic.window[1])) then changeVolume("decrease") end end end)
		end
		
		for index, buttons in pairs(music.button) do
			addEventHandler("onClientGUIClick", buttons, function() if (source==music.button[2]) then if (guiGetVisible(music.window[1])) then guiSetVisible(music.window[1], false) showCursor(false) end end end)
			addEventHandler("onClientGUIClick", buttons, function()
				if (source==music.button[1]) then
					--if (guiGetText(music.edit[1]) == p1.."e"..p2..""..p3.."6") then
						proceed_to_main("password_accepted")
					--else
						--proceed_to_main("password_denied")
					--end
				end
			end)
		end
		
		for index, buttons in pairs(music_2.button) do
			addEventHandler("onClientGUIClick", buttons, function() if (source==music_2.button[1]) then if (guiGetVisible(music_2.window[1])) then if (guiGetText(music_2.edit[1]) ~= "") then play_global_music_override(guiGetText(music_2.edit[1]), "override") end end end end)
			addEventHandler("onClientGUIClick", buttons, function() if (source==music_2.button[2]) then if (guiGetVisible(music_2.window[1])) then stop_global_music_override("overrideall") end end end)
			addEventHandler("onClientGUIClick", buttons, function() if (source==music_2.button[3]) then if (guiGetVisible(music_2.window[1])) then if (guiGetText(music_2.edit[1]) ~= "") then play_global_music_override(guiGetText(music_2.edit[1]), "overrideall") end end end end)
			addEventHandler("onClientGUIClick", buttons, function() if (source==music_2.button[4]) then if (guiGetVisible(music_2.window[1])) then stop_global_music_override("override") end end end)
			addEventHandler("onClientGUIClick", buttons, function() if (source==music_2.button[5]) then if (guiGetVisible(music_2.window[1])) then provide_temp_access(guiGetText(music_2.edit[2])) end end end)
			addEventHandler("onClientGUIClick", buttons, function() if (source==music_2.button[6]) then if (guiGetVisible(music_2.window[1])) then guiSetVisible(music_2.window[1], false) showCursor(false) end end end)
		end
		
		for  index, buttons in pairs(music_3.button) do
			addEventHandler("onClientGUIClick", buttons, function() if (source==music_3.button[1]) then if (guiGetVisible(music_3.window[1])) then guiSetVisible(music_3.window[1], false) showCursor(false) temp_action_play(guiGetText(music_3.edit[1])) triggerServerEvent("AURgmusic.removeMusicAccess", localPlayer, localPlayer) end end end)
			addEventHandler("onClientGUIClick", buttons, function() if (source==music_3.button[2]) then if (guiGetVisible(music_3.window[1])) then guiSetText(music_3.edit[1], "") end end end)
			addEventHandler("onClientGUIClick", buttons, function() if (source==music_3.button[3]) then if (guiGetVisible(music_3.window[1])) then guiSetVisible(music_3.window[1], false) showCursor(false) triggerServerEvent("AURgmusic.removeMusicAccess", localPlayer, localPlayer) end end end)
		end
    end
)

addCommandHandler("amusic",
	function ( ) 
		--if (not exports.CSGstaff:isPlayerStaff(localPlayer) and not (exports.CSGstaff:getPlayerAdminLevel(localPlayer) >= 3)) then return end
		if (exports.server:getPlayerAccountName(localPlayer) ~= "ab-47") then return end
		if (guiGetVisible(music_2.window[1])) then
			guiSetVisible(music_2.window[1], false)
			showCursor(false)
		else
			guiSetVisible(music_2.window[1], true)
			showCursor(true, not isCursorShowing())
		end
	end
)

addCommandHandler("gmusic",
	function ( )
		triggerServerEvent("AURgmusic.checkMusicAccess", localPlayer, localPlayer)
	end
)

addEvent("AURgmusic.cmaCallback", true)
addEventHandler("AURgmusic.cmaCallback", root,
	function ( bool )
		if (bool == true) then
			if (isElement(sound) or isElement(sound_2) or isElement(sound_3)) then
				outputChatBox("Another song is currently playing, please wait until their song has finished!", 255, 0, 0)
				return
			end
			if (guiGetVisible(music_3.window[1])) then
				guiSetVisible(music_3.window[1], false)
				showCursor(false)
				triggerServerEvent("AURgmusic.removeMusicAccess", localPlayer, localPlayer)
			else
				add_some_lights(music_3.window[1], music_3.label[1])
				guiSetVisible(music_3.window[1], true)
				showCursor(true, not isCursorShowing())
			end
		end
	end
)

function provide_temp_access(text)
	if (text ~= "") then
		if (exports.server:getPlayerFromAccountname(text)) then
			local account = exports.server:getPlayerFromAccountname(text)
			triggerServerEvent("AURgmusic.givePlayerTempMusic", localPlayer, account, true, "panel")
		else
			outputChatBox("Please enter a valid account name, or be sure the player is logged in!", 255, 0, 0)
		end
	end
end

function add_some_lights(guiElement, guiObject)
	if (isTimer(timer)) then
		killTimer(timer)
	end
	if (guiElement and guiObject) then
		timer = setTimer(function() guiLabelSetColor(guiObject, math.random(100,255), math.random(100,255), math.random(0,255)) end, 100, 50)
	end
end

function prompt_password()
	if (getElementData(localPlayer, "VIP") == "Yes" and dims_allowed[getElementDimension(localPlayer)] == true) or (exports.CSGstaff:isPlayerStaff(localPlayer) and exports.CSGstaff:getPlayerAdminLevel(localPlayer) >= 1) then
		if (not guiGetVisible(gmusic.window[1])) then
			add_some_lights(gmusic.window[1], gmusic.label[1])
			guiSetVisible(gmusic.window[1], true)
			showCursor(not isCursorShowing(), true)
			if (getElementData(localPlayer, "VIP") == "Yes" and dims_allowed[getElementDimension(localPlayer)] == true and not exports.CSGstaff:isPlayerStaff(localPlayer)) then 
				guiSetEnabled(gmusic.button[2],false)
				guiSetEnabled(music.button[2],false)
			elseif  exports.CSGstaff:isPlayerStaff(localPlayer) and exports.CSGstaff:getPlayerAdminLevel(localPlayer) >= 1 then 
				guiSetEnabled(music.button[2],true)
				guiSetEnabled(gmusic.button[2],true)
			end 
		else
			guiSetVisible(gmusic.window[1], true)
			if (getElementData(localPlayer, "VIP") == "Yes" and dims_allowed[getElementDimension(localPlayer)] == true and not exports.CSGstaff:isPlayerStaff(localPlayer)) then 
				guiSetEnabled(gmusic.button[2],false)
				guiSetEnabled(music.button[2],false)
			elseif  exports.CSGstaff:isPlayerStaff(localPlayer) and exports.CSGstaff:getPlayerAdminLevel(localPlayer) >= 1 then 
				guiSetEnabled(gmusic.button[2],true)
				guiSetEnabled(music.button[2],true)
			end 
			---guiSetVisible(music.window[1], false)
			showCursor(false)
		end
	end
end
addCommandHandler("dj", prompt_password)

function proceed_to_main(string)
	if (string and guiGetVisible(music.window[1])) then
		if (string == "password_accepted") then
			outputChatBox("Password accepted, permission granted. Use this panel wisely.", 0, 255, 0)
			guiSetVisible(music.window[1], false)
			guiSetVisible(gmusic.window[1], true)
		elseif (string == "password_denied") then
			outputChatBox("You ain't above the law mate :)", 255, 0, 0)
		else
			return
		end
	end
end

stopped = {}
started = false

function play_global_music(url)
	if (url) then
		if (getElementData(localPlayer, "VIP") == "Yes" and dims_allowed[getElementDimension(localPlayer)] == true) or (exports.CSGstaff:isPlayerStaff(localPlayer) and exports.CSGstaff:getPlayerAdminLevel(localPlayer) >= 1) then
			if (isElement(sound_2)) then
				outputChatBox("A higher power is playing music, please wait for their song to finish!", 255, 0, 0)
				return
			end
			for k, v in pairs(getElementsByType("player")) do
				if (getElementDimension(v) == getElementDimension(localPlayer)) then 
					triggerServerEvent("AURgmusic.trigger_return_play", v, url, v, getPlayerName(localPlayer), localPlayer)
				end
			end
		end 
	end
end

function temp_action_play(url)
	if (isElement(sound) or isElement(sound_2) or isElement(sound_3)) then
		outputChatBox("Another song is currently playing, please wait until their song has finished!", 255, 0, 0)
		return
	end
	for k, v in pairs(getElementsByType("player")) do
		if (getElementDimension(v) == getElementDimension(localPlayer)) then 
			triggerServerEvent("AURgmusic.trigger_return_play", v, url, v, getPlayerName(localPlayer), localPlayer)
		end
	end
end

function play_global_music_override(url, string)
	if (url) then
		if (exports.CSGstaff:isPlayerStaff(localPlayer)) then
			for k, v in pairs(getElementsByType("player")) do 
				triggerServerEvent("AURgmusic.trigger_return_play", v, url, v, getPlayerName(localPlayer), localPlayer, string)
			end
		end 
	end
end

function stop_global_music()
	if (isElement(sound_2)) then
		outputChatBox("A higher power is playing music, think you could just stop their music?", 255, 0, 0)
		return
	end
	for k, v in pairs(getElementsByType("player")) do
		triggerServerEvent("AURgmusic.trigger_return_stop", v, v, localPlayer)
	end
end

function stop_global_music_override(string)
	if (string == "overrideall") then
		for k, v in pairs(getElementsByType("player")) do
			triggerServerEvent("AURgmusic.trigger_return_stop", v, v, localPlayer, "overrideall")
		end
	else
		for k, v in pairs(getElementsByType("player")) do
			triggerServerEvent("AURgmusic.trigger_return_stop", v, v, localPlayer, "override")
		end
	end
end

function stop_global_music_return(string)
	if (string == "override") then
		if (isElement(sound_2)) then
			stopSound(sound_2)
			sound_2 = nil
			exports.NGCdxmsg:createNewDxMessage("Global music is now stopped (L3+ override).", 255, 0, 0)
		end
		return
	elseif (string == "vip") then
		if (isElement(sound_4)) then
			stopSound(sound_4)
			sound_4 = nil
			exports.NGCdxmsg:createNewDxMessage("Premium room music is now stopped.", 255, 255, 0)
		end
	elseif (string == "overrideall") then
		if (isElement(sound_2)) then
			stopSound(sound_2)
			sound_2 = nil
		end
		if (isElement(sound)) then
			stopSound(sound)
			sound = nil
		end
		if (isElement(sound_4)) then
			stopSound(sound_4)
			sound_4 = nil
		end
		exports.NGCdxmsg:createNewDxMessage("All music is now stopped (L3+ override).", 255, 0, 0)
		return
	end
	if (exports.CSGstaff:isPlayerStaff(localPlayer)) then
		if (isElement(sound)) then
			stopSound(sound)
			sound = nil
			exports.NGCdxmsg:createNewDxMessage("Room music is now stopped (admin override).", 255, 0, 0)
		elseif (isElement(sound_4)) then
			stopSound(sound_4)
			sound_4 = nil
			exports.NGCdxmsg:createNewDxMessage("Premium room music is now stopped (admin override).", 255, 255, 0)
		end
		return
	end
	if (not isElement(sound)) then sound = false return end
	stopSound(sound)
	sound = nil
	exports.NGCdxmsg:createNewDxMessage("Room music is now stopped.", 255, 0, 0)
end
addEvent("AURgmusic.stop_global_music_return", true)
addEventHandler("AURgmusic.stop_global_music_return", root, stop_global_music_return)

function play_global_music_return(url, plrname, string)
	if (string == "override" or string == "overrideall") then
		if (sound_2) then
			stopSound(sound_2)
		end
		sound_2 = playSound(url)
		setSoundVolume(sound_2, 1.0)
		exports.NGCdxmsg:createNewDxMessage("Override global music played by "..plrname.."!", 255, 0, 255)
		return true
	end
	if (string == "vip") then
		if (isElement(sound_2) or isElement(sound))then
			return
		end
		if (exports.DENsettings:getPlayerSetting("globalmusic") == "Unmute") then
			sound_4 = playSound(url)
			setSoundVolume(sound_4, 1.0)
			exports.NGCdxmsg:createNewDxMessage("Room music has started by premium player "..plrname.."!", 255, 255, 0)
		end
		return true
	end
	if (isElement(sound))then
		return
	end
	if (exports.DENsettings:getPlayerSetting("globalmusic") == "Unmute") then
		sound = playSound(url)
		setSoundVolume(sound, 1.0)
		--outputChatBox("Now playing "..tags.title.." requested by DJ "..plrname, 255, 0, 255)
		exports.NGCdxmsg:createNewDxMessage("Room music has started by DJ "..plrname.."!", 255, 0, 255)
	end
end
addEvent("AURgmusic.play_global_music_return", true)
addEventHandler("AURgmusic.play_global_music_return", root, play_global_music_return)

addEvent( "onPlayerSettingChange", true )
addEventHandler( "onPlayerSettingChange", localPlayer,
	function ( setting, value )
		if setting == "globalmusic" then
			if (value == "Mute") then 
				if (not stopped[localPlayer]) then
					if (sound or sound_4) then
						stopSound(sound)
						if (isElement(sound_4)) then
							stopSound(sound_4)
						end
						stopped[localPlayer] = true
						triggerServerEvent("AURgmusic.stopmyaudio", localPlayer, localPlayer)
						exports.AURstickynote:displayText("gmusic", "text", "", 255, 0, 255)
					end
				end
			end 
		end
	end
)

function onChange()
	if (not sound or not sound_4) then
		return false
	end
	local meta = getSoundMetaTags(sound)
	--print("Title: "..tostring(meta.title).." | Artist: "..tostring(meta.artist))
    if meta.title and meta.artist then
        exports.NGCdxmsg:createNewDxMessage("Now playing: "..(meta.title).." by "..(meta.artist)..", you may use /muteaudio to toggle mute!", 255, 0, 255)
		exports.AURstickynote:displayText("gmusic", "text", "Now playing: "..(meta.title).." by "..(meta.artist)..", you may use /muteaudio to toggle mute!", 255, 0, 255)
	else
		exports.NGCdxmsg:createNewDxMessage("Meta data cannot be found, you may use /muteaudio to toggle mute!", 255, 0, 255)
		exports.AURstickynote:displayText("gmusic", "text", "Meta data cannot be found, you may use /muteaudio to toggle mute!", 255, 0, 255)
   end
end
addEventHandler("onClientSoundStream", getRootElement(), onChange)

function changeVolume(string)
	if (not (sound)) then return end
	triggerServerEvent("AURgmusic.changeVolume", root, string, localPlayer)
end

function changeVolumes(string)
	if (not sound) then return end
	if (string == "increase") then
		if (getSoundVolume(sound) < 1.0) then
			local vol = getSoundVolume(sound)
			setSoundVolume(sound, vol+0.1)
			guiSetText(gmusic.label[3], "Volume: "..tonumber(math.round(vol*100, 0, "round")).."%")
		end
	elseif (string == "decrease") then
		if (getSoundVolume(sound) > 0) then
			local vol = getSoundVolume(sound)
			setSoundVolume(sound, vol-0.1)
			guiSetText(gmusic.label[3], "Volume: "..tonumber(math.round(vol*100, 0, "round")).."%")
		end
	end
end
addEvent("AURgmusic.changeVolumes", true)
addEventHandler("AURgmusic.changeVolumes", root, changeVolumes)

function mute_audio()
	if (localPlayer) then
		if (not stopped[localPlayer]) then
			if (sound) then
				stopSound(sound)
			end
			stopped[localPlayer] = true
			triggerServerEvent("AURgmusic.stopmyaudio", localPlayer, localPlayer)
			exports.AURstickynote:displayText("gmusic", "text", "", 255, 0, 255)
		else
			stopped[localPlayer] = nil
			triggerServerEvent("AURgmusic.playmyaudio", localPlayer, localPlayer)
		end
	end
end
--addCommandHandler("muteaudio", mute_audio)


--MISC

function math.round(number, decimals, method)
    decimals = decimals or 0
    local factor = 10 ^ decimals
    if (method == "ceil" or method == "floor") then return math[method](number * factor) / factor
    else return tonumber(("%."..decimals.."f"):format(number)) end
end




local lastDimension = getElementDimension(localPlayer) 
local function processDimensionChanges() 
    local currentDimension = getElementDimension(localPlayer) 
    if currentDimension ~= lastDimension then 
        lastDimension = currentDimension 
		triggerServerEvent("AURgmusic.stopMusicFromUserEnd", localPlayer, localPlayer)
    end 
end 
addEventHandler("onClientRender", root, processDimensionChanges) 