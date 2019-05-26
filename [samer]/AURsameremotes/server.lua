local allEmotes = { "cometome", "orangejustice", "starpower", "takethel", "shout_01", "lkaround_loop", "infinitedab", "electroshuffle",
	"floss", "wash_up", "defaultdance", "bestmates", "eagle"}

addEventHandler("onResourceStart", resourceRoot,
	function()
		exports.DENmysql:exec("CREATE TABLE IF NOT EXISTS playerEmotes (player_id INT PRIMARY KEY AUTO_INCREMENT, emotesTable TEXT)")
		for k, v in ipairs(getElementsByType("player")) do
			bindKey(v, "b", "down", "emoteswheel")
		end
	end
)

addEvent("onServerPlayerLogin", true)
addEventHandler("onServerPlayerLogin", root,
	function()
		bindKey(source, "b", "down", "emoteswheel")
	end
)

function getPlayerEmotes(plr)
	--local accID = exports.server:getPlayerAccountID(plr)
	--local emotes = exports.DENmysql:querySingle("SELECT * FROM playerEmotes WHERE player_id=?", accID)
	--if (emotes) then
		--return fromJSON(emotes['emotesTable'])
		--return allEmotes
	--else
		--exports.DENmysql:exec("INSERT INTO playerEmotes (player_id, emotesTable) VALUES(?,?)", accID, toJSON({}))
		--return toJSON({})
		return allEmotes
	--end
end

function doesEmoteExist(emote)
	for k, v in ipairs(allEmotes) do
		if (v == emote) then
			return true
		end
	end
	return false
end

function addPlayerEmote(plr, emote)
	if not (doesEmoteExist(emote)) then return false end
	local tab = getPlayerEmotes(plr)
	if (tab) then
		for k, v in ipairs(tab) do
			if (v == emote) then
				return false
			end
		end
		table.insert(tab, emote)
		local accID = exports.server:getPlayerAccountID(plr)
		exports.DENmysql:exec("UPDATE playerEmotes SET emotesTable=? WHERE player_id=?", toJSON(tab), accID)
		return true
	else
		return false
	end
end

function deletePlayerEmote(plr, emote)
	if not (doesEmoteExist(emote)) then return false end
	local tab = getPlayerEmotes(plr)
	if (tab) then
		for k, v in ipairs(tab) do
			if (v == emote) then
				table.remove(tab, k)
				local accID = exports.server:getPlayerAccountID(plr)
				exports.DENmysql:exec("UPDATE playerEmotes SET emotesTable=? WHERE player_id=?", toJSON(tab), accID)
				return true
			end
		end
		return false
	else
		return false
	end
end

addCommandHandler("emoteswheel", function(plr)
	--if (getTeamName(getPlayerTeam(plr)) == "Staff") then
		if (getElementData(plr, "isPlayerArrested")) then return false end
		if (getPedOccupiedVehicle(plr)) then return false end
		if (isElementInWater(plr)) then return false end
		if (getElementData(plr, "tased")) then return false end
		if (not isPedOnGround(plr)) then return false end
		triggerClientEvent(plr, "AURemotes.showWheel", plr, getPlayerEmotes(plr))
	--end
end)
