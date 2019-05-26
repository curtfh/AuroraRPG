saveMode = 'SQLite' -- Can be MySQL or SQLite

-- Connect database.
addEventHandler ( "onResourceStart", resourceRoot, function ( )
	local saveMode_ = string.lower ( saveMode )
	if ( saveMode_ == 'sqlite' ) then
		dbc = dbConnect ( "sqlite", "updates.sql" )
	else
		return outputDebugString ( "Server Updates: "..saveMode.." is an invalid saving method. Valid SQLite ." )
	end

	-- Check Database
	if ( dbc ) then
		outputDebugString ( "Sever Updates: "..saveMode.." has successfully connected.")
		dbExec ( dbc, "CREATE TABLE IF NOT EXISTS Updates ( Date_ TEXT, Name TEXT, Developer TEXT, AddedBy TEXT )" )
	else
		outputDebugString ( "Sever Updates: "..saveMode.." has failed to connected." )
	end

end )

function getUpdates ( )
	return dbPoll ( dbQuery ( dbc, "SELECT * FROM Updates LIMIT 2000" ), -1 )
end



function addUpdate ( player, date, update, author )
	--local accnt = getAccountName ( getPlayerAccount ( player ) )
	local accnt = exports.server:getPlayerAccountName(player)
	dbExec ( dbc, "INSERT INTO Updates ( Date_, Name, Developer, AddedBy ) VALUES ( ?, ?, ?, ? )", date, update, author, accnt )
	outputDebugString ( "Server Updates: "..getPlayerName ( player ).." added an update.")
	triggerClientEvent("ToggleUP",root)
	triggerEvent( "onAddingUpdate", player)
end

function removeUpdate ( player, date, update, author )
	dbExec ( dbc, "DELETE FROM Updates WHERE Date_=? AND Name=? AND Developer=?", date, update, author )
end

addEvent ( "Updates:onServerEvent", true )
addEventHandler ( "Updates:onServerEvent", root, function ( callBack, args )
	if ( callBack == 'addUpdate' ) then
		addUpdate ( source, unpack ( args ) )
	elseif ( callBack == 'removeUpdate' ) then
		removeUpdate ( source, unpack ( args ) )
	end
end )

function isPlayerInACL ( player )

	if exports.CSGstaff:isPlayerDeveloper(player) or getElementData(player,"isPlayerPrime") then
		return true
	else
		return false
	end
end

function requestUpdates(update)
 local update = "[Announcement] ".. string.gsub(update,"\n","")
 outputChatBox("An update has been released, do /updates to see all server updates", getRootElement(), 255, 128, 0)
 outputChatBox(update, getRootElement(), 255, 128, 0)
 fetchRemote("https://aurorarvg.com/stats/updates.txt",downl)
 end



local updates = ""
function downl(responseData, errno)
    if (errno == 0) then
		if responseData == "" then return end
		local responseData = string.sub(tostring(responseData),3,#responseData)
		updates = responseData
	else
		updates = "Failed to collect updates"
    end
end
addEvent("requestUpdates",true)
addEventHandler("requestUpdates",getRootElement(),function()
	triggerLatentClientEvent(client,"requestUpdates",resourceRoot,updates,0)
end)
fetchRemote("https://aurorarvg.com/stats/updates.txt",downl)

--if setAccountPassword(getAccount("darknes"),98989898) then
--	outputDebugString("YE")
--end
