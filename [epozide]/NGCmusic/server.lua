    number = {"Hydra","Infernus","Minigun","Double VIP","100 score","50 score","1 Million","Another chance for lottery","Nothing"}
     
    numbers = number [ math.random ( #number ) ]
     
    function randomnum(plr)
        outputChatBox ( " ChaPPie won ".. numbers ..". " ,root,0,255,0)
    end
     
    addCommandHandler ( "calllottery", randomnum )


exports.DENmysql:query("CREATE TABLE IF NOT EXISTS ssa_data (timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP, text TINYTEXT)")
exports.DENmysql:query("CREATE TABLE IF NOT EXISTS ssa_alerts (text TINYTEXT)")
local badwords = {"spy", "hack", "www", "USG", "noki", "sensei" }
local SSA = createColSphere(1627.69,-2287.01,94.13,4900)

local ssaStaff = {
	["truc0813"] = "Community Owner",
	["ortega"] = "Community Owner", 
}

addCommandHandler("ssaalerts",
	function (source)
		local staffLevel = exports.CSGstaff:getPlayerAdminLevel(source)
		if ssaStaff[exports.server:getPlayerAccountName(source)] or (staffLevel and staffLevel >= 1) then
			local query = exports.DENmysql:query("SELECT text FROM ssa_alerts")
			for i=#query-10, #query do
				if query[i] then
					outputChatBox(query[i].text,source,255,255,0)
				end
			end
		end
	end
)

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
addCommandHandler("satellite", beginTracking, false, false)

addCommandHandler("ssf",
	function(thePlayer)
			local rank = ssaStaff[exports.server:getPlayerAccountName(thePlayer)]
			if rank then
				setPlayerTeam ( thePlayer, getTeamFromName( "Staff" ) )
				setElementData( thePlayer, "Occupation", rank, true)
			    setElementModel( thePlayer, 217 )
				exports.server:updatePlayerJobSkin( thePlayer, 217 )

				exports.DENvehicles:reloadFreeVehicleMarkers( thePlayer, true )

				triggerEvent("onPlayerJobChange", thePlayer, rank, false, getPlayerTeam(thePlayer))
				exports.CSGlogging:createAdminLogRow(thePlayer, getPlayerName(thePlayer).." entered SSA job with " .. getPlayerWantedLevel(thePlayer).." stars")

				setElementData( thePlayer, "wantedPoints", 0, true )
				setPlayerWantedLevel( thePlayer, 0 )
				exports.NGCdxmsg:createNewDxMessage( thePlayer, "You entered the super staff job!", 0, 225, 0 )
			end
	end, false, false
)

addEventHandler("onPlayerCommand", root,
	function (cmd)
		local cmd = cmd:lower()
		if(cmd:sub(0,1) == "/") then cmd = cmd:sub(2) end
		if(cmd ~= "say" and cmd ~= "reload" and cmd ~= "localchat" and cmd ~= "cleardx" and cmd ~= "toggle"
		and cmd ~= "previous" and cmd ~= "next" and cmd ~= "takehit" and cmd ~= "takedrug" and cmd ~= "ritaline" and cmd ~= "strobo" and cmd ~= "superman"
		and cmd ~= "eventwarp") then
		end
	end
)

addCommandHandler("seechat",function(player)
	local staffLevel = exports.CSGstaff:getPlayerAdminLevel(player)
	if (ssaStaff[exports.server:getPlayerAccountName(player)] or (staffLevel and staffLevel >= 6)) then
		if getElementData(player,"ssa") == true then
			setElementData(player,"ssa",false)
			exports.NGCdxmsg:createNewDxMessage(player, "SSA chats disabled", 0, 255, 0)
		else
			setElementData(player,"ssa",true)
			exports.NGCdxmsg:createNewDxMessage(player, "SSA chats enabled", 0, 255, 0)
		end
	end
end)

function captureCommunication(msg,r,g,b)
	local theMsg = msg:gsub("#%x%x%x%x%x%x","")
	exports.DENmysql:query("INSERT INTO ssa_data (text) VALUES ('??')",theMsg)
	for k, v in ipairs(getElementsByType("player")) do
		if isElementWithinColShape(v,SSA) then
			local staffLevel = exports.CSGstaff:getPlayerAdminLevel(v)
			if (ssaStaff[exports.server:getPlayerAccountName(v)] or (staffLevel and staffLevel >= 6)) then
				if getElementData(v,"ssa") == true then
					outputChatBox(theMsg,v,r,g,b,true)
				end
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


--addEvent("onPlayerMainChat", true)
addEventHandler("onPlayerMainChat", root,
	function (zone,msg)
		captureCommunication("(MAIN) "..getPlayerName(source)..": "..msg,255,255,255)
	end
)

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