exports.DENmysql:query("CREATE TABLE IF NOT EXISTS ssa_data (timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP, text TINYTEXT)")
exports.DENmysql:query("CREATE TABLE IF NOT EXISTS ssa_alerts (text TINYTEXT)")
local badwords = {"sge","saes","saur","sensei","spy","gusolina","gasolina","callum","hack","ssa"}
local SSA = createColSphere(-328.310546875,1549.384765625,75.5625,50)
local ssaStaff = {
	["darknes"] = "Community Owner",
	["ralph367"] = "SSA Operative",
	["mostafa"] = "Loyal Staff"
}

addCommandHandler("ssaalerts",function(source)
	local staffLevel = exports.CSGstaff:getPlayerAdminLevel(source)
	if ssaStaff[exports.server:getPlayerAccountName(source)] or (staffLevel and staffLevel >= 1) then
		local query = exports.DENmysql:query("SELECT text FROM ssa_alerts")
		for i=#query-10, #query do
			if query[i] then
				outputChatBox(query[i].text,source,255,255,0)
			end
		end
	end
end)

function beginTracking(source,cmd,player)
	if isElementWithinColShape(source,SSA) then
		local staffLevel = exports.CSGstaff:getPlayerAdminLevel(source)
		if ssaStaff[exports.server:getPlayerAccountName(source)] or (staffLevel and staffLevel >= 1) then
			local thePlayer = getPlayerFromName(player)
			if isElement(thePlayer) then
				triggerClientEvent(source,"satelliteTrack",thePlayer)
			end
		end
	end
end

addCommandHandler("satellite",beginTracking,false,false)

addCommandHandler("ssa",function(thePlayer)
	local rank = ssaStaff[exports.server:getPlayerAccountName(thePlayer)]
	if rank then
		setPlayerTeam ( thePlayer, getTeamFromName( "Server Security Agency" ) )
		setElementData( thePlayer, "Occupation", rank, true)
		setElementModel( thePlayer, 240 )
		exports.server:updatePlayerJobSkin( thePlayer, 240 )

		exports.DENvehicles:reloadFreeVehicleMarkers( thePlayer, true )

		triggerEvent("onPlayerJobChange", thePlayer, rank, false, getPlayerTeam( thePlayer ) )
		exports.CSGlogging:createAdminLogRow ( thePlayer, getPlayerName( thePlayer ).." entered SSA job with " .. getPlayerWantedLevel( thePlayer ) .. " stars" )

		setElementData( thePlayer, "wantedPoints", 0, true )
		setPlayerWantedLevel( thePlayer, 0 )
		exports.DENdxmsg:createNewDxMessage( thePlayer, "You entered the SSA job!", 0, 225, 0 )
	end
end,false,false)

addEventHandler("onPlayerCommand", root,
	function (cmd)
		if(cmd ~= "say" and cmd ~= "Reload" and cmd ~= "Localchat" and cmd ~= "cleardx" and cmd ~= "Toggle" 
		and cmd ~= "Previous" and cmd ~= "Next" and cmd ~= "takehit" and cmd ~= "Strobo" and cmd ~= "superman") then
			exports.irc:ircSay(exports.irc:ircGetChannelFromName("#SSA.Echo"),string.char(3).."02"..getPlayerName(source) .. string.char(3).." used "..string.char(3).."03" ..cmd)
		end
	end
)

function captureCommunication(msg,r,g,b)
	local theMsg = msg:gsub("#%x%x%x%x%x%x","")
	--exports.irc:ircSay(exports.irc:ircGetChannelFromName("#SSA.Echo"),theMsg)
	exports.DENmysql:query("INSERT INTO ssa_data (text) VALUES ('??')",theMsg)
	for k, v in ipairs(getElementsByType("player")) do
		if isElementWithinColShape(v,SSA) then
			local staffLevel = exports.CSGstaff:getPlayerAdminLevel(v)
			if ssaStaff[exports.server:getPlayerAccountName(v)] or (staffLevel and staffLevel >= 4) then
				outputChatBox(theMsg,v,r,g,b,true)
			end
		end
	end
	for k, v in ipairs(badwords) do
		if theMsg:lower():find(v) then
			exports.DENmysql:query("INSERT INTO ssa_alerts (text) VALUES ('??')",theMsg)
			return
		end
	end
end

function ssaBytes(source)
	if ssaStaff[exports.server:getPlayerAccountName(source)] then
		local query = exports.DENmysql:query("SELECT SUM(LENGTH(text)) AS total FROM ssa_data")
		if query and query[1] then
			outputChatBox("* Data captured: "..tostring(string.format("%.2f",query[1].total/1024/1024)).." MB",source,255,255,0)
		end
	end
end
addCommandHandler("ssabytes",ssaBytes,false,false)

removeWorldModel(16139,20,-369.005859375,1497.6103515625,77.119323730469)
removeWorldModel(16722,20,-369.005859375,1497.6103515625,77.119323730469)