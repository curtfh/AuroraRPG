-- Call service with phone
addEvent( "onPhoneCallService", true )
function onPhoneCallService ( theOccupation, theTeam )
	if theTeam ~= "Government" then
		local players = getElementsByType("player")
		for i=1,#players do
			if getPlayerTeam(players[i]) and ( getTeamName( getPlayerTeam( players[i] ) ) == theTeam ) and players[i] ~= source then
				if ( getElementData( players[i], "Occupation" ) == theOccupation ) or theTeam ~= "Civilian Workers" then
					triggerClientEvent(players[i], "onPlayerJobCall", source, theOccupation, theTeam )
				end
			end
		end
	else
		local players = getElementsByType("player")
		for i=1,#players do
			if getPlayerTeam(players[i]) and ( getTeamName( getPlayerTeam( players[i] ) ) == theTeam ) and players[i] ~= source then
				triggerClientEvent(players[i], "onPlayerJobCall", source, "", theTeam )
			end
		end
	end
end
addEventHandler( "onPhoneCallService", root, onPhoneCallService )

-- Event for change email
addEvent( "onPlayerEmailChange", true )
function onPlayerEmailChange ( theEmail, thePassword )
	if ( theEmail ) and ( thePassword ) then
		exports.server:updatePlayerEmail( source, theEmail, thePassword )
	end
end
addEventHandler( "onPlayerEmailChange", root, onPlayerEmailChange )

-- Event for change password
addEvent( "onPlayerPasswordChange", true )
function onPlayerPasswordChange ( newPassword, newPassword2, oldPassword )
	if ( newPassword ) and ( newPassword2 ) and ( oldPassword ) then
		exports.server:updatePlayerPassword( source, newPassword, newPassword2, oldPassword )
	end
end
addEventHandler( "onPlayerPasswordChange", root, onPlayerPasswordChange )

antiHack = {}
smartTimer = {}
addEvent("onServerPlayerLogin",true)
addEventHandler("onServerPlayerLogin",root,function()
	antiHack[source] = true
	if isTimer(smartTimer[source]) then return false end
	smartTimer[source] = setTimer(function(player)
		antiHack[player] = false
	end,60000,1,source)
end)
-- Event send money
addEvent( "onTransferMoneyToPlayer", true )
function onTransferMoneyToPlayer ( toPlayer, theMoney )
	local can,msg = exports.NGCmanagement:isPlayerLagging(source)
	if can then
		if ( isElement( toPlayer ) ) then
			if ( getPlayerMoney( source ) >= tonumber(theMoney) ) then
				exports.AURpayments:addMoney(toPlayer,tonumber(theMoney),"Custom","ATM",0,"AURPhone earned them by "..getPlayerName(source))
				exports.AURpayments:takeMoney(source, tonumber(theMoney),"AURphone sent to "..getPlayerName(toPlayer))
				exports.NGCdxmsg:createNewDxMessage( toPlayer, getPlayerName( source ).." sent you $"..theMoney, 225, 0, 0 )
				exports.NGCdxmsg:createNewDxMessage( source, "$ " .. theMoney .. " has been sent to "..getPlayerName( toPlayer), 225, 0, 0 )
				exports.CSGlogging:createLogRow ( source, "money", getPlayerName(source).." sent $".. theMoney .." to ".. getPlayerName(toPlayer) .." (IPHONE APP)" )
				exports.CSGlogging:createLogRow ( toPlayer, "money", getPlayerName(toPlayer).." recieved $".. theMoney .." from ".. getPlayerName(source) .." (IPHONE APP)" )
			else
				exports.NGCdxmsg:createNewDxMessage( source, "You don't have enough money!", 225, 0, 0 )
			end
		end
	else
		exports.NGCdxmsg:createNewDxMessage( source, "You can't send money while lagging or having network problem!", 225, 0, 0 )
		exports.NGCdxmsg:createNewDxMessage( source,msg, 225, 0, 0 )
	end
end
addEventHandler( "onTransferMoneyToPlayer", root, onTransferMoneyToPlayer )
local tempIDS = {}

-- Music stuff

addEvent("CSGphone.musicAdded",true)
addEventHandler("CSGphone.musicAdded",root,function(t)
	local name,link=t[1],t[2]
	local id = nil
	if t[3] ~= nil then
		id = t[3]
	end
	local username = exports.server:getPlayerAccountName(source)
	local t = exports.DENmysql:query("SELECT * FROM personalmusic WHERE username=?",username)
	if #t > 0 then
		local data = t[1].data
		data=fromJSON(data)
		table.insert(data,{name,link,id})
		exports.DENmysql:query("UPDATE personalmusic SET data=? WHERE username=?",toJSON(data),username)
	else
		local data = {}
		table.insert(data,{name,link,id})
		exports.DENmysql:query( "INSERT INTO personalmusic SET username=?, data=?",username,toJSON(data))
	end
	exports.NGCdxmsg:createNewDxMessage(source,"Added Music :: Name - "..name..". Link - "..link.."",0,255,0)
end)

addEvent("CSGphone.removemusic",true)
addEventHandler("CSGphone.removemusic",root,function(link)
	local username = exports.server:getPlayerAccountName(source)
	local t = exports.DENmysql:query("SELECT * FROM personalmusic WHERE username=?",username)
	local data = t[1].data
	data=fromJSON(data)
	for k,v in pairs(data) do
		if v[2] == link then
			exports.NGCdxmsg:createNewDxMessage(source,"Music :: Removed "..v[1].."",0,255,0)
			table.remove(data,k)
			break
		end
	end
	exports.DENmysql:query("UPDATE personalmusic SET data=? WHERE username=?",toJSON(data),username)

end)


local vehmusic = {}
addEvent("CSGphone.addedToVeh",true)
addEventHandler("CSGphone.addedToVeh",root,function(url,pos,maxx,name)
	if maxx then
	vehmusic[source]={url,pos,maxx*1000,name}
	playForVeh(source)
	end
end)

addEvent("CSGphone.removedFromVeh",true)
addEventHandler("CSGphone.removedFromVeh",root,function()
	killSoundVeh(source)
	vehmusic[source] = nil
end)

function killSoundVeh(veh)
	local t=getVehicleOccupants(veh)
	for k,v in pairs(t) do
		if isElement(v) then
			exports.NGCdxmsg:createNewDxMessage(v,"**Vehicle Sound System -- Music Off**",0,255,0)
			triggerClientEvent(v,"CSGphone.stopCarSound",v)
		end
	end
	vehmusic[veh]=nil
end

function playForVeh(veh)
	local t=getVehicleOccupants(veh)
	for k,v in pairs(t) do
		if isElement(v) then
			if getPedOccupiedVehicleSeat(v) ~= 0 then
				exports.NGCdxmsg:createNewDxMessage(v,"Vehicle Sound System - Playing "..vehmusic[veh][4].." - "..math.floor(vehmusic[veh][2]/1000).."s/"..math.floor(vehmusic[veh][3]/1000).."s",0,255,0)
				triggerClientEvent(v,"CSGphone.playCarSound",v,vehmusic[veh][1],vehmusic[veh][2],vehmusic[veh][4])
			end
		end
	end
end

addEventHandler("onVehicleExit",root,function(p,seat)
	if seat == 0 then
		if vehmusic[source] ~= nil then
			killSoundVeh(source)
			triggerClientEvent(p,"CSGphone.stopCarSound",p)
		end
	else
		triggerClientEvent(p,"CSGphone.stopCarSound",p)
	end
end)

addEventHandler("onVehicleEnter",root,function(p)
	if vehmusic[source] ~= nil and isElement(getVehicleController(source)) and getVehicleController(source) ~= p then
		local v=p
		local veh=source
		exports.NGCdxmsg:createNewDxMessage(v,"Vehicle Sound System - Playing "..vehmusic[veh][4].." - "..math.floor(vehmusic[veh][2]/1000).."s/"..math.floor(vehmusic[veh][3]/1000).."s",0,255,0)
		triggerClientEvent(v,"CSGphone.playCarSound",v,vehmusic[veh][1],vehmusic[veh][2],vehmusic[veh][4])
	end
end)

setTimer(function()
	for k,v in pairs(vehmusic) do
		if v ~= nil then
			local tim = v[2]
			tim=tim+1000
			if tim > v[3] then
				tim = 0
			end
			vehmusic[k][2]=tim
		end
	end
end,1000,0)

addEventHandler("onPlayerLogin",root,function()
	local username = exports.server:getPlayerAccountName(source)
	local t = exports.DENmysql:query("SELECT * FROM personalmusic WHERE username=?",username)
	if #t > 0 then
		local data = fromJSON(t[1].data)
		for k,v in pairs(data) do
			if type(exists) == "table" then
				if v[1] == "" then
					data[k][1] = exists.name
				end
			end
		end
		triggerClientEvent(source,"CSGphone.recMySongList",source,data)
	end
end)

setTimer(function()
	for k,source in pairs(getElementsByType("player")) do
		local username = exports.server:getPlayerAccountName(source)
		local t = exports.DENmysql:query("SELECT * FROM personalmusic WHERE username=?",username)
		if #t > 0 then
			local data = fromJSON(t[1].data)
			for k,v in pairs(data) do
				if type(exists) == "table" then
					if v[1] == "" then
					data[k][1] = exists.name
					end
				end
			end
			triggerClientEvent(source,"CSGphone.recMySongList",source,data)
		end
	end
end,5000,1)

addEvent("resetAnim",true)
addEventHandler("resetAnim",root,function()
	setPedAnimation(source,false)
end)

--[[
local reportTable = {}
local reports = {}

addEvent("reports.createReport", true)
function createReport(scrX, scrY)
	screenShot = takePlayerScreenShot(source, scrX, scrY)
	if (screenShot) then
		exports.NGCdxmsg:createNewDxMessage(source,"Screenshot taken, uploading to server...",0, 255, 0)
		reportTable[source] = {reporting = source, scrX = scrX, scrY = scrY}
	else
		exports.NGCdxmsg:createNewDxMessage(source,"Unknown Error ~ Failed to take screen shot", 255, 0, 0)
	end
end
addEventHandler("reports.createReport", root, createReport)

local nextID = 1
function onScreenShot(resource, status, imageData)
	if (resource == getThisResource()) then
		if (status == "ok") then
			exports.NGCdxmsg:createNewDxMessage(source,"Screenshot uploaded and sent to staff members.",0, 255, 0)
			local info = reportTable[source]
			local reporting, scrX, scrY = info.reporting, info.scrX, info.scrY
			reportTable[source] = nil
			reports[nextID] = {reporting = reporting,imageData = imageData, scrX = scrX, scrY = scrY}

			for index, player in ipairs(getElementsByType("player")) do
				--if (exports.csgstaff:isPlayerStaff(player)) then
					exports.killMessages:outputMessage("New report has been made. /reports to view it",player,255, 255, 0,"default-bold")
				--end
			end
				triggerClientEvent(root, "reports.recieveReport", root, nextID, reporting, imageData, scrX, scrY)

			nextID = nextID + 1

		else
			exports.NGCdxmsg:createNewDxMessage(source,"Unknown Error ~ Failed to send screenshot", 255, 0, 0)
		end
	end
end
addEventHandler("onPlayerScreenShot", root, onScreenShot)

addEvent("reports.deleteReport", true)
function deleteReport(id, reason)
	exports.NGCdxmsg:createNewDxMessage(source, "Report has been removed", 0, 255, 0)
	if (isElement(reports[id].reporting)) then
		exports.NGCdxmsg:createNewDxMessage(reports[id].reporting, "Your report has been removed by "..getPlayerName(source), 0, 255, 0)
		exports.NGCdxmsg:createNewDxMessage(reports[id].reporting,"Reason: "..reason, 0, 255, 0)
	end
	reports[id] = nil
	triggerClientEvent(root, "reports.deleteGridReport", root, id)
end
addEventHandler("reports.deleteReport", root, deleteReport)


function showReportsGUI(player, cmd)
	--if (exports.csgstaff:isPlayerStaff(player)) then
		triggerClientEvent(player, "reports.showReportsG", player)
	--end
end
addCommandHandler("reports", showReportsGUI)
]]
