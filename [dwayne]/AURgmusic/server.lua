local state = {}
local dims_allowed = {[5001] = true, [5002] = true, [5003] = true, [5004] = true}
local votes = {[5001] = 0, [5002] = 0, [5003] = 0, [5004] = 0}
local alreadyVoted = {}
local plays = {}
local tries = {}

function stopmyaudio(v)
	if (v) then
		if (state[v] == nil) then state[v] = false end
		if (state[v] == false) then
			--state[v] = true
			exports.NGCdxmsg:createNewDxMessage("Please use this command /settings to mute this option.", v, 0, 255, 0)
		end
	end
end
addEvent("AURgmusic.stopmyaudio", true)
addEventHandler("AURgmusic.stopmyaudio", root, stopmyaudio)

function playmyaudio(v)
	if (v) then
		if (state[v] == true) then
			state[v] = false
			exports.NGCdxmsg:createNewDxMessage("You've unmuted your audio, you'll start hearing again when the next track starts!", v, 0, 255, 0)
		end
	end
end
addEvent("AURgmusic.playmyaudio", true)
addEventHandler("AURgmusic.playmyaudio", root, playmyaudio)


function getAllPlayerInDimension ( dimension ) 
    local rValue = { }
    for i, v in ipairs ( getElementsByType ( "player" ) ) do 
        if ( getElementDimension ( v ) == dimension ) then 
            table.insert ( rValue, v )
        end 
    end 
    return rValue
end 

function skipMusic (plr, cmd)
	if (dims_allowed[getElementDimension(plr)] == true) then 
		if (alreadyVoted[plr] == true) then 
			exports.NGCdxmsg:createNewDxMessage("You already voted.", plr, 0, 255, 0)
			return 
		end 
		if (math.floor(#getAllPlayerInDimension(getElementDimension(plr))*0.5) <= votes[getElementDimension(plr)]) then 
			votes[1] = 0
			for k, v in pairs(getElementsByType("player")) do
				if (getElementDimension(v) == getElementDimension(plr)) then 
					trigger_return_stopp(v, plr)
					alreadyVoted[v] = nil
					exports.NGCdxmsg:createNewDxMessage("Music has been skipped by players.", v, 0, 255, 0)
				end
			end
		else
			for k, v in pairs(getElementsByType("player")) do
				if (getElementDimension(v) == getElementDimension(plr)) then 
					exports.NGCdxmsg:createNewDxMessage("Someone voted to skip the music. Type /skip to skip it. Votes Required: "..(votes[getElementDimension(plr)]+1).."/"..math.floor(#getAllPlayerInDimension(getElementDimension(plr))*0.5).."", v, 0, 255, 0)
				end
			end
			alreadyVoted[plr] = true
			votes[getElementDimension(plr)] = votes[getElementDimension(plr)] + 1
			if (math.floor(#getAllPlayerInDimension(getElementDimension(plr))*0.5) <= votes[getElementDimension(plr)]) then 
				votes[1] = 0
				for k, v in pairs(getElementsByType("player")) do
					if (getElementDimension(v) == getElementDimension(plr)) then 
						trigger_return_stopp(v, plr)
						alreadyVoted[v] = nil
						exports.NGCdxmsg:createNewDxMessage("Music has been skipped by players.", v, 0, 255, 0)
					end
				end
			end
		end 
	end
end 
addCommandHandler("skip", skipMusic)

function trigger_return_playy(url, v, plrname, plr, string)
	if (url) then
		if (not string or string == "vip") then
			if (tries[exports.server:getPlayerAccountName(plr)] or string == "vip") then
				if (state[v] == nil) then state[v] = false end
				if (state[v] == false) then 
					triggerClientEvent(v, "AURgmusic.play_global_music_return", v, url, plrname, string)
				else
					exports.NGCdxmsg:createNewDxMessage("A new song is playing whilst you've muted audio, to enable music toggle /muteaudio", v, 255, 0, 0)
				end
				return
			elseif (getElementData(plr, "VIP") == "Yes" and dims_allowed[getElementDimension(plr)] == true and getElementDimension(plr) == getElementDimension(v)) or (exports.CSGstaff:isPlayerStaff(plr) and exports.CSGstaff:getPlayerAdminLevel(plr) >= 1 and getElementDimension(plr) == getElementDimension(v)) then
				if (state[v] == nil) then state[v] = false end
				if (state[v] == false) then 
					triggerClientEvent(v, "AURgmusic.play_global_music_return", v, url, plrname)
					plays[getElementDimension(plr)] = url
					if (dims_allowed[getElementDimension(v)] ) then 
						exports.NGCdxmsg:createNewDxMessage("Since your in a minigames room. You can skip this song by using /skip.", v, 255, 0, 0)
					end 
				else
					exports.NGCdxmsg:createNewDxMessage("A new song is playing whilst you've muted audio, to enable music toggle /muteaudio", v, 255, 0, 0)
				end
			end
		elseif (string == "override" or string == "overrideall") then
			triggerClientEvent(v, "AURgmusic.play_global_music_return", v, url, plrname, string)
		end
	end
end
addEvent("AURgmusic.trigger_return_play", true)
addEventHandler("AURgmusic.trigger_return_play", root, trigger_return_playy)

function trigger_return_stopp(v, plr, string)
	if (not string or string == "vipstop") then
		if (state[v] == true) then exports.NGCdxmsg:createNewDxMessage("Music has been stopped whilst you've muted audio!", v, 255, 0, 0) return end
		votes[getElementDimension(v)] = 0
		for k, v in pairs(getElementsByType("player")) do
			if (getElementDimension(plr) == getElementDimension(v)) then
				triggerClientEvent(v, "AURgmusic.stop_global_music_return", v, v)
				plays[getElementDimension(plr)] = "none"
			end 
		end
	elseif (string == "override" or string == "overrideall") then
		for k, v in pairs(getElementsByType("player")) do
			triggerClientEvent(v, "AURgmusic.stop_global_music_return", v, string)
		end
	end
end
addEvent("AURgmusic.trigger_return_stop", true)
addEventHandler("AURgmusic.trigger_return_stop", root, trigger_return_stopp)

function changeVolume(string, plr)
	for k, v in pairs(getElementsByType("player")) do
		if (exports.CSGstaff:isPlayerStaff(plr) and exports.CSGstaff:getPlayerAdminLevel(plr) >= 1) then
			if (getElementDimension(plr) == getElementDimension(v)) then 
				triggerClientEvent(v, "AURgmusic.changeVolumes", v, string)
			end
		end 
	end
end
addEvent("AURgmusic.changeVolume", true)
addEventHandler("AURgmusic.changeVolume", root, changeVolume)

function stopMusicFromUserEnd(player)
	if (state[player] == true) then return end
	triggerClientEvent(player, "AURgmusic.stop_global_music_return", player, player)
	if (plays[getElementDimension(player)] ~= "none" and type(plays[getElementDimension(player)]) == "string") then 
		triggerClientEvent(player, "AURgmusic.play_global_music_return", source, plays[getElementDimension(player)], "AutoPlay")
	end 
end 
addEvent("AURgmusic.stopMusicFromUserEnd", true)
addEventHandler("AURgmusic.stopMusicFromUserEnd", root, stopMusicFromUserEnd)

function checkMusicAccess(plr)
	if (plr and isElement(plr)) then
		if (exports.server:getPlayerAccountName(plr)) then
			local account = exports.server:getPlayerAccountName(plr)
			if (tries[account]) then
				triggerClientEvent(plr, "AURgmusic.cmaCallback", plr, tries[account])
			end
		end
	end
end
addEvent("AURgmusic.checkMusicAccess", true)
addEventHandler("AURgmusic.checkMusicAccess", root, checkMusicAccess)

function givePlayerTempMusic(plr, bool, string)
	if (plr and isElement(plr)) then
		if (exports.server:getPlayerAccountName(plr)) then
			local account = exports.server:getPlayerAccountName(plr)
			if (bool) then
				if (not tries[account] or tries[account] == false) then
					tries[account] = bool
					if (string == "panel") then
						outputChatBox("You have given temp music access to "..getPlayerName(plr)..".", source, 0, 255, 0)
						outputChatBox("You've been given temp music access by "..getPlayerName(source)..", use /gmusic to play a song!", plr, 0, 255, 0)
					else
						outputChatBox("You have been given temporary music access, use /gmusic to access the panel!", plr, 0, 255, 0)
					end
					outputDebugString("Player "..getPlayerName(plr).." has been given temp music access!")
					return true
				end
			else
				tries[account] = nil
				return false
			end
		end
	end
end
addEvent("AURgmusic.givePlayerTempMusic", true)
addEventHandler("AURgmusic.givePlayerTempMusic", root, givePlayerTempMusic)

function giveEvilMusic(plr)
	local account = exports.server:getPlayerAccountName(plr)
	if (account == "evil") then
		tries[account] = true
		outputChatBox("Yes you pru, 1 try given!", plr, 0, 255, 0)
	end
end
addCommandHandler("evilpro", giveEvilMusic)

function removeMusicAccess(plr)
	if (plr and isElement(plr)) then
		if (exports.server:getPlayerAccountName(plr)) then
			local account = exports.server:getPlayerAccountName(plr)
			if (tries[account]) then
				tries[account] = nil
				outputDebugString("Player "..getPlayerName(plr).."'s temp music access has been revoked!")
			end	
		end
	end
end
addEvent("AURgmusic.removeMusicAccess", true)
addEventHandler("AURgmusic.removeMusicAccess", root, removeMusicAccess)

setTimer(function()
	plays = {}
end, 180000, 0)