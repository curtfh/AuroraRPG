local event = false
local eventCreator = false
local freezeOnWarp = false
local eventDim  = false
local eventInt = false
local eventLim = false
local eventWarps = false
local multiWarps = false
local allowedTeam = false
local x, y, z = false, false, false
local eventPlayers = {}

addEvent("AURsamevents.createEvent", true)
addEventHandler("AURsamevents.createEvent", root,
	function(name, eventLimit, freezeOnWarps, eventInterior, eventDimension, team)
		if (event) then
			exports.NGCdxmsg:createNewDxMessage(client, "There is already an ongoing event.", 255, 0, 0)
		return end
		if (name == "")  then
			exports.NGCdxmsg:createNewDxMessage(client, "You need to specify an event name.", 255, 0, 0)
		return end
		if (not eventLimit) or (eventLimit < 1) then
			exports.NGCdxmsg:createNewDxMessage(client, "You need to specify a positive event limit number.", 255, 0, 0)
		return end
		if (not eventInterior) or (eventInterior < 0) then
			exports.NGCdxmsg:createNewDxMessage(client, "You need to specify a positive interior id.", 255, 0, 0)
		return end
		if (not eventDimension) or (eventDimension < 0) then
			exports.NGCdxmsg:createNewDxMessage(client, "You need to specify a positive dimension id.", 255, 0, 0)
		return end
		event = true
		eventName = name
		eventCreator = client
		freezeOnWarp = freezeOnWarps
		eventDim = eventDimension
		eventInt = eventInterior
		eventLim = eventLimit
		x, y, z = getElementPosition(client)
		if team and team ~= "Law" and team ~= "Team Name" then
			allowedTeam = team
		elseif team and team == "Law" then
			allowedTeam = "Law"
		elseif team and team == "Team Name" then
			allowedTeam = "All"
		end
		eventPlayers = {}
		outputChatBox( "[EVENT] " .. eventName .. " (Team: "..allowedTeam..") (LIMIT: " .. eventLim .. ") (BY: " .. getPlayerName( client ) .. ") Use /eventwarp to participate!", root, 0, 225, 0 )
		--exports.CSGlogging:createAdminLogRow( client, getPlayerName( client ).." has created event with playerlimit "..eventLim.." (EVENT Panel)" )
	end
)