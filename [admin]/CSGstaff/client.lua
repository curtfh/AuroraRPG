-- Table
local staffTable = {}

-- Sync for staff table
addEvent( "onSyncAdminTable", true )
addEventHandler( "onSyncAdminTable", root,
	function ( theTable, thePlayer )
		if not ( theTable ) then return end
		if ( isElement( thePlayer ) ) then
			staffTable[thePlayer] = theTable
		else
			staffTable = theTable
		end
	end
)

-- Request table when resource starts
addEventHandler( "onClientResourceStart", root,
	function ()
		triggerServerEvent( "onRequestSyncAdminTable", localPlayer )
	end
)

-- Function to check if a player is staff
function isPlayerStaff ( thePlayer )
	if ( staffTable[thePlayer] ) then
		return true
	else
		return false
	end
end

-- Function to check if a player is a developer
function isPlayerDeveloper ( thePlayer )
	if ( staffTable[thePlayer] ) then
		if ( staffTable[thePlayer].developer == 1 ) then
			return true
		else
			return false
		end
	else
		return false
	end
end

-- Check if a player is a eventmanager
function isPlayerEventManager ( thePlayer )
	if ( staffTable[thePlayer] ) then
		if ( staffTable[thePlayer].eventmanager == 1 ) then
			return true
		else
			return false
		end
	else
		return false
	end
end

-- check if player is basemod
function isPlayerBaseMod ( thePlayer )
	if ( staffTable[thePlayer] ) then
		return staffTable[thePlayer].basemod == 1
	else
		return false
	end
end

-- Function that gets the staff level of a player
function getPlayerAdminLevel ( thePlayer )
	if ( staffTable[thePlayer] ) then
		if ( staffTable[thePlayer].rank ) then
			return staffTable[thePlayer].rank
		else
			return false
		end
	else
		return false
	end
end

addEvent("checkForStaffCmdBind",true)
addEventHandler("checkForStaffCmdBind",root,
	function()
		outputDebugString("Scanning...")
		local hasBinded = getKeyBoundToCommand("staff")
		if (hasBinded == false) then
			outputDebugString("Bind not found, sending back...")
			triggerServerEvent("returnHasPlayerGotStaffBinded",localPlayer,false)
		else
			outputDebugString("Bind found, sending back...")
			triggerServerEvent("returnHasPlayerGotStaffBinded",localPlayer,true)
		end
	end
)
