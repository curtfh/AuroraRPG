local RSA_C = dbConnect("sqlite", "rsa.db")
dbExec(RSA_C, "CREATE TABLE IF NOT EXISTS rsa(accountName TEXT, level INT)")
dbExec(RSA_C, "CREATE TABLE IF NOT EXISTS logs(action TEXT, victim TEXT, date TEXT, line TEXT)")
dbExec(RSA_C, "CREATE TABLE IF NOT EXISTS bannedP(action TEXT, victim TEXT, date TEXT, reason TEXT)")
dbExec(RSA_C, "CREATE TABLE IF NOT EXISTS warns(action TEXT, victim TEXT, date TEXT, reason TEXT)")

function add_rsa(player, level)
	if (not exports.server:isPlayerLoggedIn(player)) then
		return false 
	end
	local ACC = exports.server:getPlayerAccountName(player)
	local S = dbPoll(dbQuery(RSA_C, "SELECT * FROM rsa WHERE accountName = ?", ACC), -1)
	if (#S == 0) then
		dbExec(RSA_C, "INSERT INTO rsa (accountName, level) VALUES(?,?)", ACC, level)
	else
		dbExec(RSA_C, "UPDATE rsa SET level=? WHERE accountName=?", level, ACC)
	end
end

function get_date()
	local time = getRealTime()
	return "("..time['monthday'].."/"..time['month'].."/"..""..time['year']..") "..time.hour..":"..time.minute
end

function add_log(actionP, victimP, line)
	if (not exports.server:isPlayerLoggedIn(actionP)) then
		return false 
	end
	if (not exports.server:isPlayerLoggedIn(victimP)) then
		return false 
	end
	local AACC = exports.server:getPlayerAccountName(actionP)
	local VACC = exports.server:getPlayerAccountName(victimP)
	local date = get_date()

	dbExec(RSA_C, "INSERT INTO logs(action, victim, date, line) VALUES(?,?,?,?)", AACC, VACC, date, line)
end

function add_ban(actionP, victimP, line)
	if (not exports.server:isPlayerLoggedIn(actionP)) then
		return false 
	end
	if (not exports.server:isPlayerLoggedIn(victimP)) then
		return false 
	end
	local AACC = exports.server:getPlayerAccountName(actionP)
	local VACC = exports.server:getPlayerAccountName(victimP)
	local date = get_date()

	dbExec(RSA_C, "INSERT INTO bannedP(action, victim, date, reason) VALUES(?,?,?,?)", AACC, VACC, date, line)
end

function add_warn(actionP, victimP, line)
	if (not exports.server:isPlayerLoggedIn(actionP)) then
		return false 
	end
	if (not exports.server:isPlayerLoggedIn(victimP)) then
		return false 
	end
	local AACC = exports.server:getPlayerAccountName(actionP)
	local VACC = exports.server:getPlayerAccountName(victimP)
	local date = get_date()

	dbExec(RSA_C, "INSERT INTO warns(action, victim, date, reason) VALUES(?,?,?,?)", AACC, VACC, date, line)
end

function get_ban_player(p)
	if (not exports.server:isPlayerLoggedIn(p)) then
		return false 
	end
	local AACC = exports.server:getPlayerAccountName(p)
	return dbPoll(dbQuery(RSA_C, "SELECT * FROM bannedP WHERE victim=?", AACC), -1)
end

function get_warns(p)
	if (not exports.server:isPlayerLoggedIn(p)) then
		return false 
	end
	local AACC = exports.server:getPlayerAccountName(p)
	return dbPoll(dbQuery(RSA_C, "SELECT * FROM warns WHERE victim=?", AACC), -1)
end

function get_logs()
	return dbPoll(dbQuery(RSA_C, "SELECT * FROM logs"), -1)
end

function get_logs_victim(player)
	if (not exports.server:isPlayerLoggedIn(player)) then
		return false 
	end
	local AACC = exports.server:getPlayerAccountName(player)
	return dbPoll(dbQuery(RSA_C, "SELECT * FROM logs WHERE victim=?", AACC), -1)
end

function remove_rsa(player)
	if (not exports.server:isPlayerLoggedIn(player)) then
		return false 
	end
	local ACC = exports.server:getPlayerAccountName(player)
	dbExec(RSA_C, "DELETE FROM rsa WHERE accountName = ?", ACC)
end

function RGBToHex(red, green, blue, alpha)
	if((red < 0 or red > 255 or green < 0 or green > 255 or blue < 0 or blue > 255) or (alpha and (alpha < 0 or alpha > 255))) then
		return nil
	end
	if(alpha) then
		return string.format("#%.2X%.2X%.2X%.2X", red,green,blue,alpha)
	else
		return string.format("#%.2X%.2X%.2X", red,green,blue)
	end
end

function get_rsas()
	return dbPoll(dbQuery(RSA_C, "SELECT * FROM rsa"), -1)
end

function is_rsa(player)
	if (not exports.server:isPlayerLoggedIn(player)) then
		return false 
	end
	local ACC = exports.server:getPlayerAccountName(player)
	local S = dbPoll(dbQuery(RSA_C, "SELECT * FROM rsa WHERE accountName = ?", ACC), -1)
	if (#S > 0) then
		return true 
	end
end

function get_rsa_l(player)
	if (not is_rsa(player)) then
		return false 
	end
	local ACC = exports.server:getPlayerAccountName(player)
	local S = dbPoll(dbQuery(RSA_C, "SELECT * FROM rsa WHERE accountName = ?", ACC), -1)
	if (#S > 0) then
		return S[1].level
	end
end

function getPlayerFromPartialName(name)
    local name = name and name:gsub("#%x%x%x%x%x%x", ""):lower() or nil
    if name then
        for _, player in ipairs(getElementsByType("player")) do
            local name_ = getPlayerName(player):gsub("#%x%x%x%x%x%x", ""):lower()
            if name_:find(name, 1, true) then
                return player
            end
        end
    end
end

function add_rsa_c(player, _, p)
	if (not is_rsa(player)) then
		return false 
	end
	if (get_rsa_l(player) < 5) then
		return false
	end
	if (getPlayerFromPartialName(p)) then
		local p = getPlayerFromPartialName(p)
		if (is_rsa(p)) then
			outputChatBox("Already RSA member", player, 255, 0, 0)
			return false
		end
		add_rsa(p, 1)
		outputChatBox(getPlayerName(p).." is now a Representative of San Andreas!", root, 255, 255, 0)
		add_log(player, p, getPlayerName(p).." ("..exports.server:getPlayerAccountName(p)..") was added as a RSA by "..getPlayerName(player).." ("..exports.server:getPlayerAccountName(player)..")")
	else
		outputChatBox("No such player was found", player, 255, 0, 0)
		return false
	end
end
addCommandHandler("addrsa", add_rsa_c)


function removersa(player, _, p)
	if (not is_rsa(player)) then
		return false 
	end
	if (get_rsa_l(player) < 5) then
		return false
	end
	if (getPlayerFromPartialName(p)) then
		local p = getPlayerFromPartialName(p)
		if (not is_rsa(p)) then
			outputChatBox("Not a member of RSA", player, 255, 0, 0)
			return false
		end
		remove_rsa(p, 1)
		outputChatBox(getPlayerName(p).." is no more a Representative of San Andreas!", root, 255, 255, 0)
		add_log(player, p, getPlayerName(p).." ("..exports.server:getPlayerAccountName(p)..") has been removed from RSA by "..getPlayerName(player).." ("..exports.server:getPlayerAccountName(player)..")")
	else
		outputChatBox("No such player was found", player, 255, 0, 0)
		return false
	end
end
addCommandHandler("removersa", removersa)

function demote_rsa(player, _, p)
	if (not is_rsa(player)) then
		return false 
	end
	if (get_rsa_l(player) < 5) then
		return false
	end
	if (getPlayerFromPartialName(p)) then
		local p = getPlayerFromPartialName(p)
		if (not is_rsa(p)) then
			outputChatBox("Not a member of RSA", player, 255, 0, 0)
			return false
		end
		local level = get_rsa_l(p)
		if (level == 1) then
			outputChatBox("Cannot demote a level 1 RSA", player, 255, 0, 0)
			return false
		end
		outputChatBox(getPlayerName(p).." has been demoted in the Representative of San Andreas!", root, 255, 255, 0)
		outputChatBox(getPlayerName(p).." demoted to level "..tostring(level-1)..".", player, 255, 0, 0)
		add_rsa(p, level-1)
		add_log(player, p, getPlayerName(p).." ("..exports.server:getPlayerAccountName(p)..") has been demoted to Level "..tostring(level-1).." by "..getPlayerName(player).." ("..exports.server:getPlayerAccountName(player)..")")
	else
		outputChatBox("No such player was found", player, 255, 0, 0)
		return false
	end
end
addCommandHandler("demotersa", demote_rsa)

function promote_rsa(player, _, p)
	if (not is_rsa(player)) then
		return false 
	end
	if (get_rsa_l(player) < 5) then
		return false
	end
	if (getPlayerFromPartialName(p)) then
		local p = getPlayerFromPartialName(p)
		if (not is_rsa(p)) then
			outputChatBox("Not a member of RSA", player, 255, 0, 0)
			return false
		end
		local level = get_rsa_l(p)
		if (level == 5) then
			outputChatBox("Cannot promote a level 5 RSA", player, 255, 0, 0)
			return false
		end
		if (level == 4 and get_rsa_l(player) == 4) then
			outputChatBox("Cannot promote a level 4 RSA while being level 4 RSA", player, 255, 0, 0)
			return false
		end
		outputChatBox(getPlayerName(p).." has been promoted in the Representative of San Andreas!", root, 255, 255, 0)
		outputChatBox(getPlayerName(p).." promoted to level "..tostring(level+1)..".", player, 255, 0, 0)
		add_rsa(p, level+1)
		add_log(player, p, getPlayerName(p).." ("..exports.server:getPlayerAccountName(p)..") has been promoted to Level "..tostring(level+1).." by "..getPlayerName(player).." ("..exports.server:getPlayerAccountName(player)..")")
	else
		outputChatBox("No such player was found", player, 255, 0, 0)
		return false
	end
end
addCommandHandler("promotersa", promote_rsa)

function check_rsa(player, _, p)
	if (getPlayerFromPartialName(p)) then
		local p = getPlayerFromPartialName(p)
		if (not is_rsa(p)) then
			outputChatBox("Not a member of RSA", player, 255, 0, 0)
			return false
		end
		local level = get_rsa_l(p)
		outputChatBox(getPlayerName(p).."\'s level is: "..tostring(level), player, 255, 0, 0)
	else
		outputChatBox("No such player was found", player, 255, 0, 0)
		return false
	end
end
addCommandHandler("checkrsa", check_rsa)

function rsa_chat(player, _, ...)
	if (not exports.server:isPlayerLoggedIn(player)) then
		return false 
	end
	if (not is_rsa(player)) then
		return false 
	end
	local MSG = table.concat({...}, " ")
	if (MSG and #MSG > 2) then
		local r, g, b = getTeamColor(getPlayerTeam(player))
		local hex = RGBToHex(r, g, b)
		for i, v in ipairs(getElementsByType("player")) do
			if (is_rsa(v)) then
				outputChatBox("(RSA) "..hex.." "..getPlayerName(player)..":#ffffff "..MSG, v, 255, 255, 0, true)
			end
		end
	else
		outputChatBox("Too short message", player, 255, 0, 0)
	end
end
addCommandHandler("rsa", rsa_chat)

function rsas_chat(player, _, ...)
	if (not exports.server:isPlayerLoggedIn(player)) then
		return false 
	end
	if (not is_rsa(player)) then
		if (not exports.CSGstaff:isPlayerStaff(player)) then
			return false 
		end
	end
	local MSG = table.concat({...}, " ")
	if (MSG and #MSG > 2) then
		local r, g, b = getTeamColor(getPlayerTeam(player))
		local hex = RGBToHex(r, g, b)
		for i, v in ipairs(getElementsByType("player")) do
			if (is_rsa(v) or exports.CSGstaff:isPlayerStaff(v)) then
				outputChatBox("(RSAS) "..hex.." "..getPlayerName(player)..":#ffffff "..MSG, v, 255, 255, 0, true)
			end
		end
	else
		outputChatBox("Too short message", player, 255, 0, 0)
	end
end
addCommandHandler("rsas", rsas_chat)

function rsa_panel(player)
	if (not is_rsa(player)) then
		return false 
	end
	triggerClientEvent(player, "AURrsa.rsaP", player, get_rsas(), get_rsa_l(player), get_logs())
end
addCommandHandler("rsap", rsa_panel)

function punish_p(p, time, reason, t)
	if (not is_rsa(client)) then
		outputChatBox("Not a rsa", client, 255, 0 ,0)
		return false 
	end
	
	local bans = get_ban_player(p)
	local warns = get_warns(p)
	if (getPlayerTeam(p) == getTeamFromName("Civilian Workers")) then
		if (t == "Warn") then
			if (#warns == 1 or #warns > 1) then
				triggerEvent("onQuitJob", p, getElementData(p,"Occupation"))
				outputChatBox(getPlayerName(p).." has been kicked from civilian job by: "..getPlayerName(client).." for "..reason, root, 255, 0, 0)
				add_warn(client, p, getPlayerName(p).." has been kicked (warned) from civilian job by: "..getPlayerName(client).." for "..reason)
				add_log(client, p, getPlayerName(p).." has been kicked (warned) from civilian job by: "..getPlayerName(client).." for "..reason)
			else
				add_warn(client, p, getPlayerName(p).." has been warned from civilian job by: "..getPlayerName(client).." for "..reason)
				add_log(client, p, getPlayerName(p).." has been warned from civilian job by: "..getPlayerName(client).." for "..reason)
				outputChatBox(getPlayerName(p).." has been warned (civilian job) by: "..getPlayerName(client).." for "..reason, root, 255, 0, 0)
			end
			triggerClientEvent(client, "AURrsa.rsaP", client)
		elseif (t == "Kick") then
			triggerEvent("onQuitJob", p, getElementData(p,"Occupation"))
			outputChatBox(getPlayerName(p).." has been kicked from civilian job by: "..getPlayerName(client).." for "..reason, root, 255, 0, 0)
			add_log(client, p, getPlayerName(p).." has been kicked from civilian job by: "..getPlayerName(client).." for "..reason)
			triggerClientEvent(client, "AURrsa.rsaP", client)
		elseif (t == "Ban") then
			add_ban(client, p, getPlayerName(p).." has been banned from civilian job by: "..getPlayerName(client).." for "..reason)
			triggerEvent("onQuitJob", p, getElementData(p,"Occupation"))
			outputChatBox(getPlayerName(p).." has been banned from civilian job by: "..getPlayerName(client).." for "..reason, root, 255, 0, 0)
			add_log(client, p, getPlayerName(p).." has been banned from civilian job by: "..getPlayerName(client).." for "..reason)
			triggerClientEvent(client, "AURrsa.rsaP", client)
		end
	end
end
addEvent("AURrsa.punish", true)
addEventHandler("AURrsa.punish", root, punish_p)

function kick_if_banned()
	if (getPlayerTeam(source) == getTeamFromName("Civilian Workers")) then
		local bans = get_ban_player(source)
		if (#bans > 0) then
			triggerEvent("onQuitJob", source, getElementData(source,"Occupation"))
			outputChatBox("You are banned from civilian jobs -> thus removed!", source, 255, 0 ,0)
		end
	end
end
addEvent("onPlayerJobChange", true)
addEventHandler("onPlayerJobChange", root, kick_if_banned)

function unban_p(player, _, t)
	if (not is_rsa(player)) then
		return false 
	end
	if (get_rsa_l(player) < 3) then
		return false 
	end
	local partialName = getPlayerFromPartialName(t)
	if (not partialName) then
		local b = dbPoll(dbQuery(RSA_C, "SELECT * FROM bannedP WHERE victim=?", t), -1)
		if (#b == 0) then
			return false 
		end
		dbExec(RSA_C, "DELETE FROM bannedP WHERE victim=?", t)
		outputChatBox(t.." has been unbanned from civilian job by: "..getPlayerName(player).." for "..reason, root, 255, 0, 0)
		add_log(player, p, t.." has been unbanned from civilian job by: "..getPlayerName(player).." for "..reason)
		return true
	end
	local b = get_ban_player(partialName)
	if (#b > 0) then
		local acc = exports.server:getPlayerAccountName(partialName)
		dbExec(RSA_C, "DELETE FROM bannedP WHERE victim=?", ACC)
		outputChatBox(getPlayerName(partialName).." has been unbanned from civilian job by: "..getPlayerName(player), root, 255, 0, 0)
		add_log(player, p, getPlayerName(partialName).." has been unbanned from civilian job by: "..getPlayerName(player))		
	else
		outputChatBox("Not banned", player, 255, 0, 0)
		return false 
	end
end
addCommandHandler("unbanrsa", unban_p)

function check_bans_rsa(player)
	local bans = dbPoll(dbQuery(RSA_C, "SELECT * FROM bannedP"), -1)
	for i, v in ipairs(bans) do
		outputChatBox(v['victim'].."(victim) "..v['action'].." (banisher)", player)
	end
end
addCommandHandler("checkbansrsa", check_bans_rsa)
