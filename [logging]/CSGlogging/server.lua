-- Get the time from a log
function getCurrentTime ()
	local time = getRealTime()
	local year, month, day,hours, mins, secs = time.year + 1900, time.month + 1, time.monthday, time.hour, time.minute, time.second
	
	if ( month < 10 ) then
		month = "0" .. month
	end
	
	if ( day < 10 ) then
		day = "0" .. day
	end
	
	if ( hours < 10 ) then
		hours = "0" .. hours
	end
	
	if ( mins < 10 ) then
		mins = "0" .. mins
	end
	
	if ( secs < 10 ) then
		secs = "0" .. secs
	end
	
	theDate = day .. "-" .. month .. "-" .. year
	theTime = hours .. ":" .. mins .. ":" .. secs
	return theDate, theTime, time.timestamp
end

-- Create a new log
function createLogRow ( thePlayer, theType, theAction, theType2 )
	if ( isElement( thePlayer ) ) then
		if ( exports.server:getPlayerAccountName ( thePlayer ) ) then theAccount = ( exports.server:getPlayerAccountName ( thePlayer ) ) else theAccount = "Guest" end
		local theDate, theTime, aTimestamp = getCurrentTime ()
		local theType2 = theType2 or "N/A"
		--[[exports.DENmysql:exec( "INSERT INTO `logs` SET player=?, account=?, type=?, type2=?, timestamp=?, date=?, time=?, action=?, serial=?"
			, getPlayerName( thePlayer )
			, theAccount
			, theType
			, theType2
			, aTimestamp
			, theDate
			, theTime
			, theAction
			, getPlayerSerial( thePlayer )
		)]]--
		local logWrite = "["..theDate.." "..theTime.." UTC -8] "..theType.." ("..theType2..") "..getPlayerName(thePlayer).." ["..theAccount.."] - "..getPlayerSerial(thePlayer).." ("..getPlayerIP (thePlayer).."): "..theAction
		
		if not ( fileExists ( "logs/accounts/"..theAccount..".txt" ) ) then 
			local newly = fileCreate ( "logs/accounts/"..theAccount..".txt" )
			if (newly) then  
				fileWrite(newly, "------------------------------------------------\n-- AuroraRPG Logs\n-- First Logged Account: "..theAccount.."\n-- First Logged Serial: "..getPlayerSerial(thePlayer).."\n-- First IP Address: "..getPlayerIP (thePlayer).."\n-- Log Since: "..theTime.." (GMT -8)\n-- Timestamp: "..aTimestamp.."\n------------------------------------------------\n")
				fileClose(newly) 
			else
				outputDebugString("Cannot save new logs ACC: "..theAccount)
			end 
		end 
		file = fileOpen ( "logs/accounts/"..theAccount..".txt" ) 
		if ( file ) then 
			pos = fileGetSize( file ); 
			newPos = fileSetPos ( file, pos ); 
			writeFile = fileWrite ( file, logWrite .."\n" )
			if ( writeFile ) then 
				fileClose ( file )
			else 
				outputDebugString ( "Error writing the logs." )
				fileClose ( file )
			end 
		end 
		
		if not ( fileExists ( "logs/serials/"..getPlayerSerial(thePlayer)..".txt" ) ) then 
			local newly = fileCreate (  "logs/serials/"..getPlayerSerial(thePlayer)..".txt")
			fileWrite(newly, "------------------------------------------------\n-- AuroraRPG Logs\n-- First Logged Account: "..theAccount.."\n-- First Logged Serial: "..getPlayerSerial(thePlayer).."\n-- First IP Address: "..getPlayerIP (thePlayer).."\n-- Log Since: "..theTime.." (GMT -8)\n-- Timestamp: "..aTimestamp.."\n------------------------------------------------\n")
			fileClose(newly) 
		end 
		file = fileOpen ( "logs/serials/"..getPlayerSerial(thePlayer)..".txt" ) 
		if ( file ) then 
			pos = fileGetSize( file ); 
			newPos = fileSetPos ( file, pos ); 
			writeFile = fileWrite ( file, logWrite .."\n" )
			if ( writeFile ) then 
				fileClose ( file )
			else 
				outputDebugString ( "Error writing the logs." )
				fileClose ( file )
			end 
		end 
		
		if not ( fileExists ( "logs/ips/"..getPlayerIP (thePlayer)..".txt" ) ) then 
			local newly = fileCreate ( "logs/ips/"..getPlayerIP (thePlayer)..".txt" )
			fileWrite(newly, "------------------------------------------------\n-- AuroraRPG Logs\n-- First Logged Account: "..theAccount.."\n-- First Logged Serial: "..getPlayerSerial(thePlayer).."\n-- First IP Address: "..getPlayerIP (thePlayer).."\n-- Log Since: "..theTime.." (GMT -8)\n-- Timestamp: "..aTimestamp.."\n------------------------------------------------\n")
			fileClose(newly) 
		end 
		file = fileOpen ( "logs/ips/"..getPlayerIP (thePlayer)..".txt" ) 
		if ( file ) then 
			pos = fileGetSize( file ); 
			newPos = fileSetPos ( file, pos ); 
			writeFile = fileWrite ( file, logWrite .."\n" )
			if ( writeFile ) then 
				fileClose ( file )
			else 
				outputDebugString ( "Error writing the logs." )
				fileClose ( file )
			end 
		end 
		
		return true
	else
		return false
	end
end

-- Create a new staff log
function createAdminLogRow ( thePlayer, theAction )
	if ( isElement( thePlayer ) ) then
		if ( exports.server:getPlayerAccountName ( thePlayer ) ) then theAccount = ( exports.server:getPlayerAccountName ( thePlayer ) ) else theAccount = "Ghost" end
		local theDate, theTime, aTimestamp = getCurrentTime ()
		exports.DENmysql:exec( "INSERT INTO `adminlog` SET player=?, account=?, action=?, serial=?"
			, getPlayerName( thePlayer )
			, theAccount
			, theAction
			, getPlayerSerial( thePlayer )
		)
		local logWrite = "["..theDate.." "..theTime.." UTC -8] adminlog (N/A) "..getPlayerName(thePlayer).." ["..theAccount.."] - "..getPlayerSerial(thePlayer).." ("..getPlayerIP (thePlayer).."): "..theAction
		if not ( fileExists ( "logs/accounts/"..theAccount..".txt" ) ) then 
			local newly = fileCreate ( "logs/accounts/"..theAccount..".txt" )
			fileWrite(newly, "------------------------------------------------\n-- AuroraRPG Logs\n-- First Logged Account: "..theAccount.."\n-- First Logged Serial: "..getPlayerSerial(thePlayer).."\n-- IP Address: "..getPlayerIP (thePlayer).."\n-- Log Since: "..theTime.." (GMT -8)\n-- Timestamp: "..aTimestamp.."\n------------------------------------------------\n")
			fileClose(newly) 
		end 
		file = fileOpen ( "logs/accounts/"..theAccount..".txt" ) 
		if ( file ) then 
			pos = fileGetSize( file ); 
			newPos = fileSetPos ( file, pos ); 
			writeFile = fileWrite ( file, logWrite .."\n" )
			if ( writeFile ) then 
				fileClose ( file )
			else 
				outputDebugString ( "Error writing the logs." )
				fileClose ( file )
			end 
		end 
		
		if not ( fileExists ( "logs/serials/"..getPlayerSerial(thePlayer)..".txt" ) ) then
			local newly = fileCreate ( "logs/serials/"..getPlayerSerial(thePlayer)..".txt" )
			fileWrite(newly, "------------------------------------------------\n-- AuroraRPG Logs\n-- First Logged Account: "..theAccount.."\n-- First Logged Serial: "..getPlayerSerial(thePlayer).."\n-- IP Address: "..getPlayerIP (thePlayer).."\n-- Log Since: "..theTime.." (GMT -8)\n-- Timestamp: "..aTimestamp.."\n------------------------------------------------\n")
			fileClose(newly) 
		end 
		file = fileOpen ( "logs/serials/"..getPlayerSerial(thePlayer)..".txt" ) 
		if ( file ) then 
			pos = fileGetSize( file ); 
			newPos = fileSetPos ( file, pos ); 
			writeFile = fileWrite ( file, logWrite .."\n" )
			if ( writeFile ) then 
				fileClose ( file )
			else 
				outputDebugString ( "Error writing the logs." )
				fileClose ( file )
			end 
		end 
		
		if not ( fileExists ( "logs/ips/"..getPlayerIP (thePlayer)..".txt" ) ) then 
			local newly = fileCreate ( "logs/ips/"..getPlayerIP (thePlayer)..".txt" )
			fileWrite(newly, "------------------------------------------------\n-- AuroraRPG Logs\n-- First Logged Account: "..theAccount.."\n-- First Logged Serial: "..getPlayerSerial(thePlayer).."\n-- IP Address: "..getPlayerIP (thePlayer).."\n-- Log Since: "..theTime.." (GMT -8)\n-- Timestamp: "..aTimestamp.."\n------------------------------------------------\n")
			fileClose(newly) 
		end 
		file = fileOpen ( "logs/ips/"..getPlayerIP (thePlayer)..".txt" ) 
		if ( file ) then 
			pos = fileGetSize( file ); 
			newPos = fileSetPos ( file, pos ); 
			writeFile = fileWrite ( file, logWrite .."\n" )
			if ( writeFile ) then 
				fileClose ( file )
			else 
				outputDebugString ( "Error writing the logs." )
				fileClose ( file )
			end 
		end 
		
		return true
	else
		return false
	end
end

function adminLogCheck(plr)
	if (not exports.CSGstaff:isPlayerStaff(plr)) then
		return false 
	end
	-- admin player level check
	if (exports.CSGstaff:getPlayerAdminLevel(plr) < 4) then
		return false
	end
	-- Open
	triggerClientEvent(plr, "CSGlogging.gui", plr)
end
addCommandHandler("logp", adminLogCheck)

function requestLogs(t, e)
	if (not exports.CSGstaff:isPlayerStaff(client)) then
		triggerClientEvent(client, "CSGlogging.gui", client)
		return false
	end
	-- level check
	if (exports.CSGstaff:getPlayerAdminLevel(client) < 4) then
		triggerClientEvent(client, "CSGlogging.gui", client)
		return false
	end	
	-- get events
	local folder = "logs/"..t.."s/"..e..".txt"
	if (not fileExists(folder)) then
		triggerClientEvent(client, "CSGlogging.info", client, "Logs for '"..e.."' was not found.")
		return false
	end
	local file = fileOpen(folder, true)
	triggerClientEvent(client, "CSGlogging.info", client, fileRead(file, fileGetSize(file)))
	fileClose(file)
end
addEvent("CSGlogging.getLogs", true)
addEventHandler("CSGlogging.getLogs", root, requestLogs)