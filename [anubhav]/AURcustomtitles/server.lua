local connection_sqlite = dbConnect("sqlite", "titles.db")
dbExec(connection_sqlite, "CREATE TABLE IF NOT EXISTS customTitles(cTName TEXT, cTType TEXT, cTextra TEXT, cTr INT, cTg INT, cTb INT)")

function add_ct(name, t, extra, r, g, b)
	dbExec(connection_sqlite, "INSERT INTO customTitles(ctName, cTType, cTextra, cTr, cTg, cTb) VALUES(?,?,?,?,?,?)", name, t, extra, r, g, b)
end

function get_ct_by_extra(extra)
	local q = dbQuery(connection_sqlite, "SELECT * FROM customTitles WHERE cTextra=?", extra)
	if (not q) then
		return false 
	end
	return dbPoll(q, -1)
end

function getJobCustomTitles(player)
	local ranksJob = exports.CSGranks:getOccupationToRankTable()
	local freeCustomtitles = {}
	for i, v in pairs(ranksJob) do
		local rank = exports.CSGranks:getRank(player, i)
		if (v[#v] == rank) then
			table.insert(freeCustomtitles, {cTName = i, cTType = "personal", cTextra = exports.server:getPlayerAccountName(player), cTr = 255, cTg, 255, cTb = 0})
		end
	end
	return freeCustomtitles
end

function open_custom_title_window(p)
	if (exports.server:isPlayerLoggedIn(p)) then 
		triggerClientEvent(p, "AURnewCustomTitle.gui", p, get_ct_by_extra(exports.server:getPlayerAccountName(p)), get_ct_by_extra(getElementData(p, "Group")), getJobCustomTitles(p), getPlayerMoney(p))
	end
end
addCommandHandler("customtitle", open_custom_title_window)
addCommandHandler("ct", open_custom_title_window)

function recieve_custom_title_data(title, r, g, b, choice, xPlr)
	if (xPlr) then
		client = xPlr
	end
	if (not client) then
		outputChatBox("Triggered")
		return false 
	end
	if (choice == "personal") then
		if (getPlayerMoney(client) >= 5000000) then
			outputChatBox("You bought a custom title", client)
			takePlayerMoney(client, 5000000)
			add_ct(title, choice, exports.server:getPlayerAccountName(client), tonumber(r), tonumber(g), tonumber(b))
			triggerClientEvent(client, "AURnewCustomTitle.gui2", client)
		end
	elseif (choice == "group") then
		if (getPlayerMoney(client) >= 10000000) then
			outputChatBox("You bought a custom title", client)
			takePlayerMoney(client, 10000000)
			add_ct(title, choice, getElementData(client, "Group"), tonumber(r), tonumber(g), tonumber(b))		
			triggerClientEvent(client, "AURnewCustomTitle.gui2", client)
		end
	elseif (choice == "premium") then
		outputChatBox("You successfully recieve a premium title", client, 0, 255, 0)
		add_ct("Premium", "personal", exports.server:getPlayerAccountName(client), tonumber(r), tonumber(g), tonumber(b))		
		--triggerClientEvent(client, "AURnewCustomTitle.gui2", client)
	end
end
addEvent("AURnewCustomTitle.recieveCT", true)
addEventHandler("AURnewCustomTitle.recieveCT", resourceRoot, recieve_custom_title_data)